"""
Game Randomizer GUI - Comprehensive randomizer with 9 randomization options
Features:
- Field Encounters (MIXED randomization: overworld model + random variety in battle)
- Boss Digimon (randomizes which Digimon appear as bosses while keeping scripts intact - FULL RANDOM)
- Evolution & De-evolution Paths (every Digimon gets 6 targets)
- Digimon Base Stats
- Battle Skills & Skill Learnsets
- Remove Evolution Requirements
- Treasure Chests & Shop Inventory

Note: Field encounters randomization (MIXED MODE):
- Randomizes which encounter group appears at each field location (field_battle_*/01_field_symbol_enemy.csv)
- Keeps enemy slot 1 intact (overworld model matches battle enemy 1)
- Randomizes enemy slots 2-6 for variety (fight 1 matching + others random)
- Example: See Agumon overworld → Fight 1 Agumon + 2 random Digimon
- Scales enemy stats by user-defined percentage (1% = very weak, 500% = very strong)
- PROTECTS boss/event encounters (encounters with actual battle scripts, not "battle_00000000" placeholder)
- PROTECTS story-flagged encounters (encounters with FLAG_MAIN_, FLAG_SUB_, etc. in conditions file)
- Story-flagged encounters keep their encounter groups but individual Digimon within them are still randomized
- Tutorial and normal field encounters with placeholder scripts ARE randomized
- Boss Digimon option changes WHICH Digimon the boss is (enemy_parameter column 2) - FULL RANDOM
"""

import sys
import csv
import random
import subprocess
from pathlib import Path
from typing import List
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QLabel, QTextEdit, QGroupBox, QCheckBox, QMessageBox,
    QProgressBar, QComboBox, QFileDialog, QScrollArea, QSpinBox
)
from PyQt6.QtCore import Qt, QThread, pyqtSignal
from PyQt6.QtGui import QFont


class RandomizerThread(QThread):
    """Thread for running randomization in background"""
    progress = pyqtSignal(str)
    finished = pyqtSignal(int, int)  # total_randomized, total_files
    modified_files = pyqtSignal(list)  # List of modified .mbe folders
    
    def __init__(self, data_path: Path, backup: bool, 
                 patch_data_path: Path = None,
                 randomize_encounters: bool = True,
                 encounter_stat_scale: int = 100,
                 include_boss_encounters: bool = False,
                 randomize_boss_digimon: bool = False,
                 randomize_evolutions: bool = False, balance_evolutions: bool = True,
                 randomize_deevolutions: bool = False, balance_deevolutions: bool = True,
                 randomize_stats: bool = False, balance_stats: bool = True,
                 randomize_skills: bool = False, balance_skills: bool = True,
                 randomize_learnsets: bool = False, balance_learnsets: bool = True,
                 remove_evo_requirements: bool = False,
                 randomize_treasure: bool = False, balance_treasure: bool = True,
                 randomize_shops: bool = False, balance_shops: bool = True):
        super().__init__()
        self.data_path = data_path  # app_0/data for field_battle files
        self.patch_data_path = patch_data_path if patch_data_path else data_path  # patch/data for core files
        self.backup = backup
        self.randomize_encounters = randomize_encounters
        self.balance_encounters = False  # Always full random for encounters
        self.encounter_stat_scale = encounter_stat_scale
        self.include_boss_encounters = include_boss_encounters
        self.randomize_boss_digimon = randomize_boss_digimon
        self.balance_boss_digimon = False  # Always full random for bosses
        self.randomize_evolutions = randomize_evolutions
        self.balance_evolutions = balance_evolutions
        self.randomize_deevolutions = randomize_deevolutions
        self.balance_deevolutions = balance_deevolutions
        self.randomize_stats = randomize_stats
        self.balance_stats = balance_stats
        self.randomize_skills = randomize_skills
        self.balance_skills = balance_skills
        self.randomize_learnsets = randomize_learnsets
        self.balance_learnsets = balance_learnsets
        self.remove_evo_requirements = remove_evo_requirements
        self.randomize_treasure = randomize_treasure
        self.balance_treasure = balance_treasure
        self.randomize_shops = randomize_shops
        self.balance_shops = balance_shops
        self.modified_folders = []  # Track which .mbe folders were modified
    
    def run(self):
        try:
            total_randomized, total_files = self.randomize_files()
            self.modified_files.emit(self.modified_folders)
            self.finished.emit(total_randomized, total_files)
        except Exception as e:
            self.progress.emit(f"❌ Error: {e}")
    
    def get_file_path(self, folder: str, *possible_names: str) -> Path:
        """Get file path supporting multiple naming conventions (e.g., 00_ vs 000_)"""
        # Core files (digimon_status, evolution, etc.) are in patch_data_path
        # Field battle files are in data_path (app_0/data)
        if folder.startswith("field_battle_"):
            folder_path = self.data_path / folder
        else:
            folder_path = self.patch_data_path / folder
        
        for name in possible_names:
            file_path = folder_path / name
            if file_path.exists():
                return file_path
        # Return first option if none exist (will be caught by exists() check later)
        return folder_path / possible_names[0]
    
    def get_all_field_battle_folders(self) -> List[Path]:
        """Get all field_battle_*.mbe folders"""
        return sorted([p for p in self.data_path.iterdir() 
                      if p.is_dir() and p.name.startswith('field_battle_')])
    
    def load_csv(self, file_path: Path) -> List[List[str]]:
        """Load CSV file"""
        with open(file_path, 'r', encoding='utf-8') as f:
            reader = csv.reader(f)
            return [row for row in reader]
    
    def save_csv(self, file_path: Path, rows: List[List[str]]):
        """Save CSV file preserving exact format with proper quoting"""
        if not rows:
            return
        
        # Parse header to determine which columns are strings
        header = rows[0]
        string_cols = set()
        for i, col_type in enumerate(header):
            if 'string' in col_type.lower():
                string_cols.add(i)
        
        with open(file_path, 'w', encoding='utf-8', newline='') as f:
            for row_idx, row in enumerate(rows):
                formatted_row = []
                for col_idx, value in enumerate(row):
                    if row_idx == 0:  # Header row - keep as is
                        formatted_row.append(value)
                    elif col_idx in string_cols:
                        # String column - wrap in quotes
                        if value and not (value.startswith('"') and value.endswith('"')):
                            formatted_row.append(f'"{value}"')
                        elif not value:
                            formatted_row.append('""')
                        else:
                            formatted_row.append(value)
                    else:
                        # Non-string column - use "" for empty
                        formatted_row.append(value if value else '""')
                f.write(','.join(formatted_row) + '\n')
    
    def collect_all_column1_values(self) -> List[str]:
        """Collect all valid encounter IDs from battle_enemy.mbe/01_encount_group.csv"""
        all_values = set()
        
        # Always load from data-backup folder (which has the complete battle_enemy.mbe)
        # The dsts-loader/patch/data folder only contains modified files
        # data_path is now dsts-loader/app_0/data, so go up 3 levels to Randomizer root
        backup_path = self.data_path.parent.parent.parent / "data-backup"
        encounter_file = backup_path / "battle_enemy.mbe" / "01_encount_group.csv"
        
        if encounter_file.exists():
            rows = self.load_csv(encounter_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 0 and row[0]:  # Column 0 is encounter ID
                    encounter_id = row[0].strip().strip('"')
                    # Exclude tutorial encounters (IDs starting with 1010)
                    if not encounter_id.startswith("1010"):
                        all_values.add(encounter_id)
        else:
            self.progress.emit(f"❌ ERROR: Could not find battle_enemy.mbe at {encounter_file}")
            self.progress.emit(f"   Make sure data-backup folder exists with complete game data!")
            # Fallback: collect from field_battle files if encounter file not found
            field_battle_folders = self.get_all_field_battle_folders()
            for folder in field_battle_folders:
                csv_file = folder / "01_field_symbol_enemy.csv"
                if csv_file.exists():
                    rows = self.load_csv(csv_file)
                    for row in rows[1:]:  # Skip header
                        if len(row) > 1 and row[1]:
                            encounter_id = row[1].strip().strip('"')
                            # Exclude tutorial encounters
                            if not encounter_id.startswith("1010"):
                                all_values.add(encounter_id)
        
        return list(all_values)
    
    def randomize_files(self) -> tuple:
        """Randomize all files based on selected options"""
        total_randomized = 0
        total_files = 0
        
        # Randomize field encounters
        if self.randomize_encounters:
            # Randomize which encounters appear in field locations
            # This keeps overworld models matching battle enemies!
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🎲 RANDOMIZING FIELD ENCOUNTER PLACEMENTS")
            self.progress.emit("="*50)
            enc_randomized, enc_files = self.randomize_field_encounters()
            total_randomized += enc_randomized
            total_files += enc_files
            
            # Randomize additional enemies in each encounter (keep slot 1 for overworld)
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🎲 RANDOMIZING ADDITIONAL ENCOUNTER ENEMIES")
            self.progress.emit("="*50)
            additional_randomized = self.randomize_encounter_additional_enemies()
            total_randomized += additional_randomized
            total_files += 1
            
            # Scale enemy parameters by user-defined percentage
            self.progress.emit("\n" + "="*50)
            self.progress.emit(f"⚖️ SCALING ENEMY STATS TO {self.encounter_stat_scale}%")
            self.progress.emit("="*50)
            scaled_count = self.scale_enemy_parameters_by_percentage()
            if scaled_count > 0:
                total_randomized += scaled_count
        
        # Randomize boss Digimon IDs
        if self.randomize_boss_digimon:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("👑 RANDOMIZING BOSS DIGIMON")
            self.progress.emit("="*50)
            boss_randomized = self.randomize_boss_digimon_ids()
            total_randomized += boss_randomized
            total_files += 1
        
        # Randomize evolutions
        if self.randomize_evolutions:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🧬 RANDOMIZING EVOLUTION PATHS")
            self.progress.emit("="*50)
            evo_randomized = self.randomize_evolution_paths()
            total_randomized += evo_randomized
            total_files += 1
        
        # Randomize de-evolutions
        if self.randomize_deevolutions:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🔙 RANDOMIZING DE-EVOLUTION PATHS")
            self.progress.emit("="*50)
            deevo_randomized = self.randomize_deevolution_paths()
            total_randomized += deevo_randomized
            total_files += 1
        
        # Randomize stats
        if self.randomize_stats:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("📈 RANDOMIZING DIGIMON STATS")
            self.progress.emit("="*50)
            stats_randomized = self.randomize_digimon_stats()
            total_randomized += stats_randomized
            total_files += 1
        
        # Randomize skills
        if self.randomize_skills:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("⚔️ RANDOMIZING SKILL PROPERTIES")
            self.progress.emit("="*50)
            skill_randomized = self.randomize_skill_properties()
            total_randomized += skill_randomized
            total_files += 1
        
        # Randomize skill learnsets
        if self.randomize_learnsets:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("📚 RANDOMIZING SKILL LEARNSETS")
            self.progress.emit("="*50)
            learnset_randomized = self.randomize_skill_learnsets()
            total_randomized += learnset_randomized
            total_files += 1
        
        # Remove evolution requirements
        if self.remove_evo_requirements:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🚫 REMOVING EVOLUTION REQUIREMENTS")
            self.progress.emit("="*50)
            removed = self.remove_evolution_requirements()
            if removed > 0:
                total_randomized += removed
                total_files += 1
        
        # Randomize treasure
        if self.randomize_treasure:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🎁 RANDOMIZING TREASURE CHESTS")
            self.progress.emit("="*50)
            treasure_randomized = self.randomize_treasure_chests()
            total_randomized += treasure_randomized
            total_files += 1
        
        # Randomize shops
        if self.randomize_shops:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🛍️ RANDOMIZING SHOP INVENTORY")
            self.progress.emit("="*50)
            shop_randomized = self.randomize_shop_inventory()
            total_randomized += shop_randomized
            total_files += 1
        
        return total_randomized, total_files
    
    def get_encounter_power(self, encounter_id: str) -> int:
        """Get the total power of an encounter by summing enemy stats"""
        try:
            encounter_file = self.patch_data_path / "battle_enemy.mbe" / "01_encount_group.csv"
            enemy_param_file = self.patch_data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
            
            if not encounter_file.exists() or not enemy_param_file.exists():
                return -1
            
            # Build enemy ID -> total power mapping
            enemy_power = {}
            enemy_rows = self.load_csv(enemy_param_file)
            for row in enemy_rows[1:]:  # Skip header
                if len(row) > 23:  # Need all stat columns
                    try:
                        enemy_id = row[0].strip('"')
                        # Stats are in columns 17-23: HP, SP, ATK, DEF, INT, SPI, SPD
                        hp = int(row[17]) if row[17] and row[17] != '""' else 0
                        sp = int(row[18]) if row[18] and row[18] != '""' else 0
                        atk = int(row[19]) if row[19] and row[19] != '""' else 0
                        defense = int(row[20]) if row[20] and row[20] != '""' else 0
                        intelligence = int(row[21]) if row[21] and row[21] != '""' else 0
                        spi = int(row[22]) if row[22] and row[22] != '""' else 0
                        spd = int(row[23]) if row[23] and row[23] != '""' else 0
                        
                        # Calculate total power (weighted: HP counts less per point)
                        total_power = (hp // 10) + sp + atk + defense + intelligence + spi + spd
                        enemy_power[enemy_id] = total_power
                    except:
                        pass
            
            # Find the encounter and sum enemy power
            enc_rows = self.load_csv(encounter_file)
            for row in enc_rows[1:]:
                if len(row) > 0 and row[0] == encounter_id:
                    # Enemy IDs are in columns: 2, 14, 26, 38, 50, 62 (6 slots)
                    enemy_id_columns = [2, 14, 26, 38, 50, 62]
                    count_columns = [9, 21, 33, 45, 57, 69]  # Enemy counts per slot
                    powers = []
                    
                    for idx, col in enumerate(enemy_id_columns):
                        if len(row) > col and row[col]:
                            enemy_id = row[col].strip('"')
                            # Get count for this slot
                            count_col = count_columns[idx]
                            count = int(row[count_col]) if len(row) > count_col and row[count_col] else 1
                            
                            if enemy_id and enemy_id != '0' and enemy_id in enemy_power:
                                # Multiply power by enemy count in this slot
                                powers.append(enemy_power[enemy_id] * count)
                    
                    if powers:
                        return sum(powers)  # Total encounter power
            return -1
        except Exception as e:
            return -1
    
    def get_flagged_encounters_from_field_folder(self, folder: Path) -> set:
        """Get encounter IDs that have story flags (should preserve encounter groups)"""
        flagged_encounters = set()
        conditions_file = folder / "00_field_symbol_enemy_conditions.csv"
        
        if conditions_file.exists():
            rows = self.load_csv(conditions_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 24:  # Column 24 contains flag names
                    flag_value = row[24].strip().strip('"')
                    # If this encounter has a story flag (FLAG_MAIN_, FLAG_SUB_, etc.)
                    if flag_value and flag_value.startswith('FLAG_'):
                        # Get the encounter ID (column 0)
                        encounter_id = row[0].strip('"')
                        if encounter_id:
                            flagged_encounters.add(encounter_id)
        
        return flagged_encounters
    
    def randomize_field_encounters(self) -> tuple:
        """Randomize field battle encounters"""
        self.progress.emit("🔍 Collecting encounter IDs...")
        all_encounters = self.collect_all_column1_values()
        
        if not all_encounters:
            self.progress.emit("❌ No values found!")
            return 0, 0
        
        self.progress.emit(f"✅ Found {len(all_encounters)} unique encounter IDs")
        
        # Identify boss/event encounters (those with ACTUAL battle scripts in column 75)
        boss_encounters = set()
        if not self.include_boss_encounters:
            # Read from data-backup (complete data)
            # data_path is now dsts-loader/app_0/data, so go up 3 levels to Randomizer root
            backup_path = self.data_path.parent.parent.parent / "data-backup"
            encounter_file = backup_path / "battle_enemy.mbe" / "01_encount_group.csv"
            if encounter_file.exists():
                rows = self.load_csv(encounter_file)
                for i in range(1, len(rows)):
                    if len(rows[i]) > 75 and rows[i][75]:
                        script_value = rows[i][75].strip().strip('"')
                        # Only treat as boss if it has a REAL script (not empty, "", or battle_00000000 placeholder)
                        if script_value and script_value not in ['', '""', 'battle_00000000']:
                            encounter_id = rows[i][0].strip('"')
                            boss_encounters.add(encounter_id)
                self.progress.emit(f"🛡️ Protected {len(boss_encounters)} boss/event encounters from randomization")
        else:
            self.progress.emit(f"⚠️ WARNING: Boss encounters will be randomized (may break scripts!)")
        
        # If balancing is enabled, pre-calculate encounter powers
        encounter_power_map = {}
        if self.balance_encounters:
            self.progress.emit("⚖️ Analyzing encounter power for balancing...")
            for enc_id in all_encounters:
                # Skip boss encounters - they should not be used as replacements
                if enc_id not in boss_encounters:
                    power = self.get_encounter_power(enc_id)
                    if power > 0:
                        encounter_power_map[enc_id] = power
            
            if encounter_power_map:
                min_power = min(encounter_power_map.values())
                max_power = max(encounter_power_map.values())
                self.progress.emit(f"✅ Calculated power for {len(encounter_power_map)} encounters (range: {min_power}-{max_power})")
            else:
                self.progress.emit("⚠️ Could not determine power, using full random")
                self.balance_encounters = False
        
        self.progress.emit("")
        
        field_battle_folders = self.get_all_field_battle_folders()
        total_randomized = 0
        folders_with_encounters = 0
        skipped_folders = 0
        total_flagged = 0
        
        for folder in field_battle_folders:
            csv_file = folder / "01_field_symbol_enemy.csv"
            
            if not csv_file.exists():
                skipped_folders += 1
                continue
            
            # Load and check if there are encounters
            rows = self.load_csv(csv_file)
            
            if len(rows) < 2:
                skipped_folders += 1
                continue
            
            # Get encounters with story flags from this field folder
            flagged_encounters = self.get_flagged_encounters_from_field_folder(folder)
            if flagged_encounters:
                total_flagged += len(flagged_encounters)
            
            # Backup if requested
            if self.backup:
                backup_file = csv_file.with_suffix('.csv.backup')
                if not backup_file.exists():
                    self.save_csv(backup_file, rows)
            
            randomized_count = 0
            
            for i in range(1, len(rows)):
                if len(rows[i]) > 1 and rows[i][1]:
                    original_encounter = rows[i][1]
                    
                    # Skip boss/event encounters - they must remain unchanged
                    if original_encounter in boss_encounters:
                        continue
                    
                    # Skip encounters with story flags - they must keep their encounter groups
                    # (but individual Digimon within them can still be randomized later)
                    if len(rows[i]) > 0:
                        overworld_encounter_id = rows[i][0].strip('"')
                        if overworld_encounter_id in flagged_encounters:
                            continue
                    
                    # Use ORIGINAL encounter power for balancing
                    if self.balance_encounters and encounter_power_map:
                        original_power = encounter_power_map.get(original_encounter)
                        
                        if original_power and original_power > 0:
                            # Find encounters within ±30% of ORIGINAL power
                            min_power = int(original_power * 0.7)
                            max_power = int(original_power * 1.3)
                            
                            candidates = [
                                enc_id for enc_id, power in encounter_power_map.items()
                                if min_power <= power <= max_power
                            ]
                            
                            if candidates:
                                rows[i][1] = random.choice(candidates)
                            else:
                                # Fallback: keep original if no balanced options
                                rows[i][1] = original_encounter
                        else:
                            # If can't determine power, keep original
                            rows[i][1] = original_encounter
                    else:
                        # Full random mode
                        rows[i][1] = random.choice(all_encounters)
                    
                    randomized_count += 1
            
            # Only show folders that actually had encounters randomized
            if randomized_count > 0:
                self.save_csv(csv_file, rows)
                self.progress.emit(f"✅ {folder.name}: {randomized_count} encounters")
                folders_with_encounters += 1
                total_randomized += randomized_count
                
                # Track modified folder
                if folder not in self.modified_folders:
                    self.modified_folders.append(folder)
            else:
                skipped_folders += 1
        
        # Summary
        if total_flagged > 0:
            self.progress.emit(f"🚩 Protected {total_flagged} story-flagged encounters (preserve encounter groups)")
        if skipped_folders > 0:
            self.progress.emit(f"ℹ️ Skipped {skipped_folders} empty/boss-only field locations")
        
        return total_randomized, folders_with_encounters
    
    def randomize_encounter_additional_enemies(self) -> int:
        """Randomize enemies in slots 2-6 of encounters (keep slot 1 for overworld model)
        
        This allows for variety in battles while keeping the overworld model consistent.
        Example: See Agumon overworld → Fight 1 Agumon + 2 random Digimon
        """
        # Read from data-backup for reference data, write to patch_data_path
        # data_path is now dsts-loader/app_0/data, so go up 3 levels to Randomizer root
        backup_path = self.data_path.parent.parent.parent / "data-backup"
        encounter_file = self.patch_data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        enemy_param_file = self.patch_data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
        digimon_status_file = backup_path / "digimon_status.mbe" / "000_digimon_status_data.csv"
        if not digimon_status_file.exists():
            digimon_status_file = backup_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        
        if not encounter_file.exists() or not enemy_param_file.exists():
            self.progress.emit("❌ Required files not found!")
            return 0
        
        # Step 1: Identify boss encounters (those with ACTUAL battle scripts in column 75)
        encounter_rows = self.load_csv(encounter_file)
        boss_encounter_rows = set()
        
        if not self.include_boss_encounters:
            for i in range(1, len(encounter_rows)):
                if len(encounter_rows[i]) > 75 and encounter_rows[i][75]:
                    script_value = encounter_rows[i][75].strip().strip('"')
                    # Only treat as boss if it has a REAL script (not empty, "", or battle_00000000 placeholder)
                    if script_value and script_value not in ['', '""', 'battle_00000000']:
                        boss_encounter_rows.add(i)
            
            self.progress.emit(f"🛡️ Protecting {len(boss_encounter_rows)} boss encounters from randomization")
        else:
            self.progress.emit(f"⚠️ WARNING: Boss encounters will be randomized (may break scripts!)")
        
        # Step 2: Get boss Digimon IDs from digimon_status (column 5 = boss flag)
        # AND from model names (chr ID column 3)
        boss_digimon_ids = set()
        if digimon_status_file.exists():
            status_rows = self.load_csv(digimon_status_file)
            for row in status_rows[1:]:
                if len(row) > 5:
                    try:
                        digimon_id = row[0].strip().strip('"')
                        boss_flag = str(row[5]).strip().strip('"') if row[5] else "0"
                        
                        # Column 5: 0=Normal, 1=Boss/Special
                        if boss_flag == "1":
                            boss_digimon_ids.add(digimon_id)
                        
                        # Additional safety: filter by model ID (column 3) for boss variants
                        if len(row) > 3:
                            model_id = str(row[3]).strip().strip('"')
                            # Filter boss model IDs (chr800+ are bosses, or models with specific patterns)
                            if model_id:
                                # Extract numeric ID from chr### format
                                try:
                                    chr_num = int(model_id.replace('chr', '').replace('"', ''))
                                    # chr800-chr950 range are all boss/special variants
                                    if chr_num >= 800:
                                        boss_digimon_ids.add(digimon_id)
                                except:
                                    pass
                    except Exception as e:
                        pass
        else:
            self.progress.emit(f"⚠️ WARNING: digimon_status file not found, cannot filter boss Digimon!")
        
        if boss_digimon_ids:
            self.progress.emit(f"🛡️ Filtering out {len(boss_digimon_ids)} boss-type Digimon from randomization pool")
        else:
            self.progress.emit(f"⚠️ WARNING: No boss Digimon detected to filter! Check if digimon_status.csv exists.")
        
        # Step 3: Collect non-boss enemy IDs
        enemy_param_rows = self.load_csv(enemy_param_file)
        all_enemy_ids = []
        boss_enemies_filtered = 0
        
        for row in enemy_param_rows[1:]:
            if len(row) > 2:
                enemy_id = str(row[0]).strip().strip('"')
                digimon_id = str(row[2]).strip().strip('"')  # Column 2 = Digimon ID reference
                
                # Only include if enemy ID is valid AND the Digimon is NOT a boss type
                if enemy_id and enemy_id not in ['', '0', '-1']:
                    if digimon_id in boss_digimon_ids:
                        boss_enemies_filtered += 1
                    else:
                        all_enemy_ids.append(enemy_id)
        
        if not all_enemy_ids:
            self.progress.emit("❌ No non-boss enemy IDs found!")
            return 0
        
        self.progress.emit(f"📊 Found {len(all_enemy_ids)} non-boss enemy types to choose from")
        if boss_enemies_filtered > 0:
            self.progress.emit(f"🚫 Filtered out {boss_enemies_filtered} boss enemy types")
        
        # Step 3: Backup encounter file
        if self.backup:
            backup_file = encounter_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                self.save_csv(backup_file, encounter_rows)
                self.progress.emit("💾 Backed up: encount_group.csv")
        
        # Step 4: Randomize enemy slots 2-6 (columns 14, 26, 38, 50, 62)
        # Keep slot 1 (column 2) unchanged for overworld model
        additional_enemy_columns = [14, 26, 38, 50, 62]
        randomized_count = 0
        
        for i in range(1, len(encounter_rows)):
            # Skip boss encounters
            if i in boss_encounter_rows:
                continue
            
            row = encounter_rows[i]
            row_changed = False
            
            # Randomize each additional enemy slot
            for col in additional_enemy_columns:
                if len(row) > col and row[col]:
                    original_enemy = row[col].strip('"')
                    
                    # Only randomize if there's an enemy in this slot
                    if original_enemy and original_enemy not in ['', '0', '-1']:
                        # Pick a random different enemy
                        row[col] = random.choice(all_enemy_ids)
                        row_changed = True
            
            if row_changed:
                randomized_count += 1
        
        # Step 5: Save
        self.save_csv(encounter_file, encounter_rows)
        self.progress.emit(f"✅ Randomized additional enemies in {randomized_count} encounters!")
        self.progress.emit(f"   Slot 1 kept intact (overworld models match)")
        self.progress.emit(f"   Slots 2-6 randomized for variety")
        
        # Track modified folder
        folder = self.patch_data_path / "battle_enemy.mbe"
        if folder not in self.modified_folders:
            self.modified_folders.append(folder)
        
        return randomized_count
    
    def get_encounter_chapter_mapping(self) -> dict:
        """Map encounter IDs to their minimum chapter number"""
        encounter_chapters = {}  # encounter_id -> min chapter it appears in
        
        field_battle_folders = self.get_all_field_battle_folders()
        
        for folder in field_battle_folders:
            csv_file = folder / "01_field_symbol_enemy.csv"
            if not csv_file.exists():
                continue
            
            # Extract chapter from folder name (e.g., field_battle_d0102 -> chapter 1)
            folder_name = folder.name.lower()
            chapter = 99  # default to high chapter
            
            if 'field_battle_d01' in folder_name or 'field_battle_t01' in folder_name:
                chapter = 1
            elif 'field_battle_d02' in folder_name or 'field_battle_t02' in folder_name:
                chapter = 2
            elif 'field_battle_d03' in folder_name or 'field_battle_t03' in folder_name:
                chapter = 3
            elif 'field_battle_d04' in folder_name or 'field_battle_t04' in folder_name:
                chapter = 4
            elif 'field_battle_d05' in folder_name or 'field_battle_t05' in folder_name:
                chapter = 5
            elif 'field_battle_d06' in folder_name or 'field_battle_t06' in folder_name:
                chapter = 6
            
            # Read encounters in this area
            rows = self.load_csv(csv_file)
            for i in range(1, len(rows)):
                if len(rows[i]) > 1 and rows[i][1]:
                    encounter_id = rows[i][1]
                    # Track the earliest chapter this encounter appears in
                    if encounter_id not in encounter_chapters or chapter < encounter_chapters[encounter_id]:
                        encounter_chapters[encounter_id] = chapter
        
        return encounter_chapters
    
    def scale_enemy_parameters_by_percentage(self) -> int:
        """Scale enemy stats by user-defined percentage (1%-500%)"""
        encounter_file = self.patch_data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        enemy_param_file = self.patch_data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
        
        if not encounter_file.exists() or not enemy_param_file.exists():
            self.progress.emit("❌ Required files not found!")
            return 0
        
        # Collect enemy IDs from encounter groups
        encounter_rows = self.load_csv(encounter_file)
        enemy_id_columns = [2, 14, 26, 38, 50, 62]
        
        # Identify boss encounters to exclude from scaling (unless user wants them included)
        boss_encounter_rows = set()
        if not self.include_boss_encounters:
            for i in range(1, len(encounter_rows)):
                if len(encounter_rows[i]) > 75 and encounter_rows[i][75]:
                    script_value = encounter_rows[i][75].strip().strip('"')
                    # Only treat as boss if it has a REAL script (not empty, "", or battle_00000000 placeholder)
                    if script_value and script_value not in ['', '""', 'battle_00000000']:
                        boss_encounter_rows.add(i)
            
            if boss_encounter_rows:
                self.progress.emit(f"🛡️ Protecting {len(boss_encounter_rows)} boss encounters from stat scaling")
        else:
            self.progress.emit(f"⚠️ Boss encounters will be scaled (may affect difficulty!)")
        
        # Collect enemy IDs to scale
        enemy_ids_to_scale = set()
        for i in range(1, len(encounter_rows)):
            if i not in boss_encounter_rows:
                for col in enemy_id_columns:
                    if len(encounter_rows[i]) > col and encounter_rows[i][col]:
                        enemy_id = encounter_rows[i][col].strip('"')
                        if enemy_id and enemy_id not in ['-1', '0', '']:
                            enemy_ids_to_scale.add(enemy_id)
        
        if not enemy_ids_to_scale:
            self.progress.emit("⚠️ No enemies to scale")
            return 0
        
        self.progress.emit(f"📊 Scaling {len(enemy_ids_to_scale)} enemy types to {self.encounter_stat_scale}%")
        
        # Backup
        if self.backup:
            backup_file = enemy_param_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(enemy_param_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: enemy_parameter.csv")
        
        # Load and scale enemy parameters
        rows = self.load_csv(enemy_param_file)
        scaled_count = 0
        
        # Stat columns: 17(HP), 18(SP), 19(ATK), 20(DEF), 21(INT), 22(SPI), 23(SPD)
        stat_columns = [17, 18, 19, 20, 21, 22, 23]
        scale_factor = self.encounter_stat_scale / 100.0  # Convert percentage to decimal
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(stat_columns):
                enemy_id = rows[i][0].strip('"')
                
                if enemy_id in enemy_ids_to_scale:
                    for col in stat_columns:
                        try:
                            value = int(rows[i][col]) if rows[i][col] and rows[i][col] != '""' else 0
                            if value > 0:
                                scaled_value = int(value * scale_factor)
                                # Set minimum values
                                if col == 17:  # HP
                                    scaled_value = max(scaled_value, 1)  # Min 1 HP
                                else:  # Other stats
                                    scaled_value = max(scaled_value, 1)  # Min 1 for all stats
                                rows[i][col] = str(scaled_value)
                        except:
                            pass
                    scaled_count += 1
        
        self.save_csv(enemy_param_file, rows)
        self.progress.emit(f"✅ Scaled {scaled_count} enemies to {self.encounter_stat_scale}% of their original stats!")
        
        # Track modified folder
        folder = self.patch_data_path / "battle_enemy.mbe"
        if folder not in self.modified_folders:
            self.modified_folders.append(folder)
        
        return scaled_count
    
    def randomize_boss_digimon_ids(self) -> int:
        """Randomize which Digimon appear as bosses by changing Digimon ID in enemy_parameter.csv
        
        This keeps encounter structure intact while randomizing the actual Digimon that appears.
        Boss enemy IDs stay the same, but point to different Digimon IDs.
        """
        encounter_file = self.patch_data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        enemy_param_file = self.patch_data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
        digimon_status_file = self.get_file_path("digimon_status.mbe", "000_digimon_status_data.csv", "00_digimon_status_data.csv")
        
        if not encounter_file.exists() or not enemy_param_file.exists():
            self.progress.emit("❌ Required files not found!")
            return 0
        
        # Step 1: Identify boss enemy IDs (those in encounters with battle scripts)
        boss_enemy_ids = set()
        encounter_rows = self.load_csv(encounter_file)
        enemy_id_columns = [2, 14, 26, 38, 50, 62]
        
        for i in range(1, len(encounter_rows)):
            # Check if this encounter has a battle script (column 75)
            if len(encounter_rows[i]) > 75 and encounter_rows[i][75] and encounter_rows[i][75].strip() not in ['""', '']:
                # Collect all enemy IDs from this boss encounter
                for col in enemy_id_columns:
                    if len(encounter_rows[i]) > col and encounter_rows[i][col]:
                        enemy_id = encounter_rows[i][col].strip('"')
                        if enemy_id and enemy_id not in ['-1', '0', '']:
                            boss_enemy_ids.add(enemy_id)
        
        if not boss_enemy_ids:
            self.progress.emit("❌ No boss enemy IDs found!")
            return 0
        
        self.progress.emit(f"🎯 Found {len(boss_enemy_ids)} boss enemy IDs to randomize")
        
        # Step 2: Collect all Digimon IDs from digimon_status
        all_digimon_ids = []
        if digimon_status_file.exists():
            status_rows = self.load_csv(digimon_status_file)
            for row in status_rows[1:]:
                if len(row) > 0:
                    try:
                        digimon_id = row[0].strip('"')
                        if digimon_id and digimon_id not in ['', '0']:
                            all_digimon_ids.append(digimon_id)
                    except:
                        pass
        
        if not all_digimon_ids:
            self.progress.emit("❌ No Digimon found for randomization!")
            return 0
        
        self.progress.emit(f"📊 Found {len(all_digimon_ids)} Digimon to choose from")
        
        # Step 3: Backup and load enemy parameters
        if self.backup:
            backup_file = enemy_param_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(enemy_param_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: enemy_parameter.csv")
        
        rows = self.load_csv(enemy_param_file)
        if len(rows) < 2:
            return 0
        
        # Step 4: Randomize Digimon ID (column 2) for boss enemies only - FULL RANDOM MODE
        randomized_count = 0
        for i in range(1, len(rows)):
            if len(rows[i]) > 2:
                enemy_id = rows[i][0].strip('"')
                
                # Only randomize if this is a boss enemy
                if enemy_id in boss_enemy_ids:
                    # Full random: pick any Digimon
                    rows[i][2] = random.choice(all_digimon_ids)
                    randomized_count += 1
        
        # Step 5: Save
        self.save_csv(enemy_param_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} boss enemies!")
        self.progress.emit(f"   Mode: Full Random 🎲")
        
        # Track modified folder
        folder = self.patch_data_path / "battle_enemy.mbe"
        if folder not in self.modified_folders:
            self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_field_encounter_enemies(self) -> int:
        """Randomize individual Digimon in field encounters (EXCLUDES bosses to preserve scripts)"""
        encounter_file = self.patch_data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        enemy_param_file = self.patch_data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
        digimon_status_file = self.get_file_path("digimon_status.mbe", "000_digimon_status_data.csv", "00_digimon_status_data.csv")
        
        if not encounter_file.exists() or not enemy_param_file.exists():
            self.progress.emit("❌ Required files not found!")
            return 0
        
        # Step 1: Identify boss encounters (those with battle scripts in column 75)
        boss_encounter_rows = set()
        encounter_rows = self.load_csv(encounter_file)
        
        for i in range(1, len(encounter_rows)):
            if len(encounter_rows[i]) > 75 and encounter_rows[i][75] and encounter_rows[i][75].strip() not in ['""', '']:
                boss_encounter_rows.add(i)
        
        self.progress.emit(f"🛡️ Protecting {len(boss_encounter_rows)} boss encounters from randomization")
        
        # Step 2: Collect all non-boss Digimon IDs
        all_digimon_ids = []
        if digimon_status_file.exists():
            status_rows = self.load_csv(digimon_status_file)
            # Check if this is a boss-type Digimon (column 5)
            for row in status_rows[1:]:
                if len(row) > 5:
                    try:
                        digimon_id = row[0].strip('"')
                        # Column 5 = isBoss flag (skip boss-type Digimon)
                        is_boss = row[5].strip('"') if row[5] else "0"
                        
                        if digimon_id and digimon_id not in ['', '0'] and is_boss == "0":
                            all_digimon_ids.append(digimon_id)
                    except:
                        pass
        
        if not all_digimon_ids:
            self.progress.emit("❌ No non-boss Digimon found!")
            return 0
        
        self.progress.emit(f"📊 Found {len(all_digimon_ids)} non-boss Digimon to choose from")
        
        # Step 3: Collect all enemy IDs used in NON-BOSS encounters and map to Digimon IDs
        enemy_param_rows = self.load_csv(enemy_param_file)
        enemy_to_digimon = {}  # enemy_id -> digimon_id mapping
        
        for row in enemy_param_rows[1:]:
            if len(row) > 2:
                enemy_id = row[0].strip('"')
                digimon_id = row[2].strip('"')
                if enemy_id and digimon_id:
                    enemy_to_digimon[enemy_id] = digimon_id
        
        # Step 4: Randomize Digimon IDs in enemy_parameter for non-boss encounters only
        enemy_ids_to_randomize = set()
        enemy_id_columns = [2, 14, 26, 38, 50, 62]
        
        # Collect enemy IDs from NON-BOSS encounters only
        for i in range(1, len(encounter_rows)):
            if i not in boss_encounter_rows:  # Skip boss encounters
                for col in enemy_id_columns:
                    if len(encounter_rows[i]) > col and encounter_rows[i][col]:
                        enemy_id = encounter_rows[i][col].strip('"')
                        if enemy_id and enemy_id not in ['-1', '0', '']:
                            enemy_ids_to_randomize.add(enemy_id)
        
        if not enemy_ids_to_randomize:
            self.progress.emit("⚠️ No non-boss enemies found")
            return 0
        
        self.progress.emit(f"🎲 Randomizing {len(enemy_ids_to_randomize)} non-boss enemy types")
        
        # Backup
        if self.backup:
            backup_file = enemy_param_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(enemy_param_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: enemy_parameter.csv")
        
        # Randomize Digimon ID (column 2) for non-boss enemies only - FULL RANDOM MODE
        randomized_count = 0
        for i in range(1, len(enemy_param_rows)):
            if len(enemy_param_rows[i]) > 2:
                enemy_id = enemy_param_rows[i][0].strip('"')
                
                # Only randomize if this enemy is used in non-boss encounters
                if enemy_id in enemy_ids_to_randomize:
                    # Full random: pick any non-boss Digimon
                    enemy_param_rows[i][2] = random.choice(all_digimon_ids)
                    randomized_count += 1
        
        # Save
        self.save_csv(enemy_param_file, enemy_param_rows)
        self.progress.emit(f"✅ Randomized {randomized_count} non-boss enemy Digimon!")
        self.progress.emit(f"   Boss encounters preserved to keep scripts working")
        self.progress.emit(f"   Mode: Full Random 🎲")
        
        return randomized_count
    
    def randomize_encounter_enemy_ids(self) -> int:
        """DEPRECATED: Use randomize_field_encounter_enemies() or randomize_boss_digimon_ids() instead
        
        Randomize which enemies appear in each encounter group (includes bosses!)"""
        encounter_file = self.patch_data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        enemy_param_file = self.patch_data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
        
        if not encounter_file.exists():
            self.progress.emit("❌ Encounter group file not found!")
            return 0
        
        if not enemy_param_file.exists():
            self.progress.emit("❌ Enemy parameter file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = encounter_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(encounter_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: encount_group.csv")
        
        # Collect all enemy IDs and their power levels
        enemy_power = {}
        enemy_rows = self.load_csv(enemy_param_file)
        for row in enemy_rows[1:]:  # Skip header
            if len(row) > 23:
                try:
                    enemy_id = row[0].strip('"')
                    # Calculate power
                    hp = int(row[17]) if row[17] and row[17] != '""' else 0
                    sp = int(row[18]) if row[18] and row[18] != '""' else 0
                    atk = int(row[19]) if row[19] and row[19] != '""' else 0
                    defense = int(row[20]) if row[20] and row[20] != '""' else 0
                    intelligence = int(row[21]) if row[21] and row[21] != '""' else 0
                    spi = int(row[22]) if row[22] and row[22] != '""' else 0
                    spd = int(row[23]) if row[23] and row[23] != '""' else 0
                    
                    total_power = (hp // 10) + sp + atk + defense + intelligence + spi + spd
                    enemy_power[enemy_id] = total_power
                except:
                    pass
        
        all_enemy_ids = list(enemy_power.keys())
        if not all_enemy_ids:
            self.progress.emit("❌ No enemy IDs found!")
            return 0
        
        self.progress.emit(f"📊 Found {len(all_enemy_ids)} enemy IDs")
        
        # Group enemies by power for balanced randomization
        enemies_by_power = {}
        if self.balance_enemy_ids:
            for enemy_id, power in enemy_power.items():
                power_bracket = (power // 200) * 200  # Group by 200 power
                if power_bracket not in enemies_by_power:
                    enemies_by_power[power_bracket] = []
                enemies_by_power[power_bracket].append(enemy_id)
            
            min_power = min(enemies_by_power.keys())
            max_power = max(enemies_by_power.keys())
            self.progress.emit(f"✅ Grouped enemies by power (range: {min_power}-{max_power})")
        
        # Load encounter groups
        rows = self.load_csv(encounter_file)
        if len(rows) < 2:
            return 0
        
        # Enemy ID columns: 2, 14, 26, 38, 50, 62 (6 slots)
        enemy_id_columns = [2, 14, 26, 38, 50, 62]
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(enemy_id_columns):
                for col in enemy_id_columns:
                    if len(rows[i]) > col and rows[i][col]:
                        original_enemy = rows[i][col].strip('"')
                        
                        # Skip if slot is empty (0 or empty string)
                        if not original_enemy or original_enemy == '0':
                            continue
                        
                        # Get original enemy power
                        if self.balance_enemy_ids and original_enemy in enemy_power:
                            original_power = enemy_power[original_enemy]
                            
                            # Find enemies within ±40% power
                            min_power = int(original_power * 0.6)
                            max_power = int(original_power * 1.4)
                            candidates = []
                            
                            for power_bracket in enemies_by_power:
                                if min_power <= power_bracket <= max_power:
                                    candidates.extend(enemies_by_power[power_bracket])
                            
                            if candidates:
                                rows[i][col] = random.choice(candidates)
                            else:
                                # Fallback to full random
                                rows[i][col] = random.choice(all_enemy_ids)
                        else:
                            # Full random mode
                            rows[i][col] = random.choice(all_enemy_ids)
                        
                        randomized_count += 1
        
        # Clear battle event identifiers (column 75) if requested
        cleared_events = 0
        if self.clear_battle_events:
            for i in range(1, len(rows)):
                if len(rows[i]) > 75 and rows[i][75]:
                    if rows[i][75] != '""' and rows[i][75] != "":
                        rows[i][75] = '""'
                        cleared_events += 1
        
        self.save_csv(encounter_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} enemy slots!")
        if self.balance_enemy_ids:
            self.progress.emit("   Mode: Balanced (±40% power)")
        else:
            self.progress.emit("   Mode: Full Random")
        
        if cleared_events > 0:
            self.progress.emit(f"   Cleared {cleared_events} battle event identifiers")
        
        # Track modified folder
        folder = self.patch_data_path / "battle_enemy.mbe"
        if folder not in self.modified_folders:
            self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_evolution_paths(self) -> int:
        """Randomize evolution paths - gives ALL Digimon exactly 6 evolution targets"""
        evo_file = self.get_file_path("evolution.mbe", "001_evolution_to.csv", "01_evolution_to.csv")
        
        if not evo_file.exists():
            self.progress.emit("❌ Evolution file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = evo_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(evo_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: evolution_to.csv")
        
        # Load evolution data
        rows = self.load_csv(evo_file)
        
        if len(rows) < 2:
            self.progress.emit("❌ No evolution data found!")
            return 0
        
        # Collect ALL Digimon IDs from the game data
        status_file = self.get_file_path("digimon_status.mbe", "000_digimon_status_data.csv", "00_digimon_status_data.csv")
        all_digimon_ids = set()
        
        if status_file.exists():
            status_rows = self.load_csv(status_file)
            for row in status_rows[1:]:
                if len(row) > 0 and row[0]:
                    digimon_id = row[0].strip().strip('"')
                    # Only add valid IDs (non-empty, non-zero)
                    if digimon_id and digimon_id != '0' and digimon_id != '""':
                        all_digimon_ids.add(digimon_id)
        
        # If we can't load status file, fall back to evolution file
        if not all_digimon_ids:
            for row in rows[1:]:
                if len(row) > 1 and row[1]:
                    digimon_id = row[1].strip().strip('"')
                    if digimon_id and digimon_id != '0' and digimon_id != '""':
                        all_digimon_ids.add(digimon_id)
                if len(row) > 3 and row[3]:
                    digimon_id = row[3].strip().strip('"')
                    if digimon_id and digimon_id != '0' and digimon_id != '""':
                        all_digimon_ids.add(digimon_id)
        
        if not all_digimon_ids:
            self.progress.emit("❌ No Digimon found!")
            return 0
        
        # Convert to sorted list for consistent ordering
        all_digimon_list = sorted(all_digimon_ids, key=lambda x: int(x) if x.isdigit() else 0)
        
        all_source_list = all_digimon_list
        all_target_list = all_digimon_list
        
        self.progress.emit(f"📊 Giving ALL {len(all_source_list)} Digimon exactly 6 evolution targets")
        self.progress.emit(f"📊 Target pool: {len(all_target_list)} possible evolution targets")
        
        # Get a template row to copy structure
        template_row = [""] * len(rows[0])
        
        # Clear existing rows, keep header
        rows = [rows[0]]
        
        randomized_count = 0
        
        # Give each Digimon exactly 6 random evolution targets
        for from_id in all_source_list:
            # Ensure we have enough targets
            if len(all_target_list) < 6:
                self.progress.emit(f"⚠️ Only {len(all_target_list)} Digimon available, cannot give 6 evolutions to each")
                chosen_targets = all_target_list * 2  # Duplicate if needed
                chosen_targets = chosen_targets[:6]  # Take first 6
            else:
                # Randomly select exactly 6 targets for this Digimon
                chosen_targets = random.sample(all_target_list, 6)
            
            for target_id in chosen_targets:
                new_row = template_row.copy()
                new_row[0] = str(len(rows))  # Evolution ID
                new_row[1] = from_id  # from_id (source Digimon)
                new_row[2] = '""'  # Column 2 (empty string column)
                new_row[3] = target_id  # to_id (target Digimon)
                new_row[4] = '""'  # Column 4 (empty string column)
                # Columns 5-10: 0,-1,-1,-1,-1,-1 pattern
                if len(new_row) > 5:
                    new_row[5] = '0'
                for col in range(6, min(11, len(new_row))):
                    new_row[col] = '-1'
                # Fill any remaining columns with ""
                for col in range(11, len(new_row)):
                    new_row[col] = '""'
                rows.append(new_row)
                randomized_count += 1
        
        # Save
        self.save_csv(evo_file, rows)
        self.progress.emit(f"✅ Created {randomized_count} evolution paths!")
        self.progress.emit(f"   Every Digimon now has exactly 6 evolution targets!")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.patch_data_path / "evolution.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_deevolution_paths(self) -> int:
        """Randomize de-evolution chains - gives ALL Digimon a chain of 6 targets"""
        deevo_file = self.get_file_path("evolution.mbe", "002_chronodevolution.csv", "02_chronodevolution.csv")
        
        if not deevo_file.exists():
            self.progress.emit("❌ De-evolution file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = deevo_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(deevo_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: chronodevolution.csv")
        
        # Load de-evolution data
        rows = self.load_csv(deevo_file)
        
        if len(rows) < 2:
            self.progress.emit("❌ No de-evolution data found!")
            return 0
        
        # Collect ALL Digimon IDs from the game data
        status_file = self.get_file_path("digimon_status.mbe", "000_digimon_status_data.csv", "00_digimon_status_data.csv")
        all_digimon_ids = set()
        
        if status_file.exists():
            status_rows = self.load_csv(status_file)
            for row in status_rows[1:]:
                if len(row) > 0 and row[0]:
                    digimon_id = row[0].strip().strip('"')
                    # Only add valid IDs (non-empty, non-zero)
                    if digimon_id and digimon_id != '0' and digimon_id != '""':
                        all_digimon_ids.add(digimon_id)
        
        # If we can't load status file, fall back to de-evolution file
        if not all_digimon_ids:
            for row in rows[1:]:
                if len(row) > 0 and row[0]:
                    digimon_id = row[0].strip().strip('"')
                    if digimon_id and digimon_id != '0' and digimon_id != '""':
                        all_digimon_ids.add(digimon_id)
                for col in range(2, min(8, len(row))):
                    if row[col] and row[col] not in ('', '-1', '""'):
                        digimon_id = row[col].strip().strip('"')
                        if digimon_id and digimon_id != '0':
                            all_digimon_ids.add(digimon_id)
        
        if not all_digimon_ids:
            self.progress.emit("❌ No Digimon found!")
            return 0
        
        # Convert to sorted list for consistent ordering
        all_digimon_list = sorted(all_digimon_ids, key=lambda x: int(x) if x.isdigit() else 0)
        
        all_source_list = all_digimon_list
        all_chain_list = all_digimon_list
        
        self.progress.emit(f"📊 Giving ALL {len(all_source_list)} Digimon a de-evolution chain of 6")
        self.progress.emit(f"📊 Chain pool: {len(all_chain_list)} possible Digimon")
        
        # Get the number of columns from original file
        num_cols = len(rows[0])
        
        # Clear existing rows, keep header
        rows = [rows[0]]
        
        randomized_count = 0
        
        # Give each Digimon a chain of 6 random targets
        for source_id in all_source_list:
            # Ensure we have enough targets
            if len(all_chain_list) < 6:
                self.progress.emit(f"⚠️ Only {len(all_chain_list)} Digimon available, cannot give 6 de-evolutions to each")
                new_chain = all_chain_list * 2  # Duplicate if needed
                new_chain = new_chain[:6]  # Take first 6
            else:
                # Randomly select exactly 6 targets for this Digimon
                new_chain = random.sample(all_chain_list, 6)
            
            # Create new row
            new_row = ['""'] * num_cols
            new_row[0] = source_id  # Digimon ID
            new_row[1] = '""'  # Column 1 (empty string column)
            
            # Fill columns 2-7 with the 6 chain members
            for i, chain_id in enumerate(new_chain):
                if 2 + i < num_cols:
                    new_row[2 + i] = chain_id
            
            # Fill any remaining columns after the chain with -1 (shouldn't be needed if we have 6)
            for col in range(2 + len(new_chain), num_cols):
                new_row[col] = '-1'
            
            rows.append(new_row)
            randomized_count += 1
        
        # Save
        self.save_csv(deevo_file, rows)
        self.progress.emit(f"✅ Created {randomized_count} de-evolution chains!")
        self.progress.emit(f"   Every Digimon now has a chain of 6 de-evolution targets!")
        
        # Track modified folder (same as evolution)
        if randomized_count > 0:
            folder = self.patch_data_path / "evolution.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_digimon_stats(self) -> int:
        """Randomize Digimon base stats (HP, SP, ATK, DEF, INT, SPI, SPD)"""
        status_file = self.get_file_path("digimon_status.mbe", "000_digimon_status_data.csv", "00_digimon_status_data.csv")
        
        if not status_file.exists():
            self.progress.emit("❌ Digimon status file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = status_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(status_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: digimon_status_data.csv")
        
        rows = self.load_csv(status_file)
        if len(rows) < 2:
            return 0
        
        # Stats are in columns: 64(HP), 65(SP), 66(ATK), 67(DEF), 68(INT), 69(SPI), 70(SPD)
        # Based on Time Stranger Data File Headers.txt
        stat_columns = [64, 65, 66, 67, 68, 69, 70]
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(stat_columns):
                for col in stat_columns:
                    try:
                        original_stat = int(rows[i][col])
                        if original_stat > 0:
                            if self.balance_stats:
                                # Variance mode: ±30%
                                variance = random.uniform(0.7, 1.3)
                                new_stat = int(original_stat * variance)
                            else:
                                # Full random: 50-2000
                                new_stat = random.randint(50, 2000)
                            rows[i][col] = str(max(1, new_stat))
                    except:
                        pass
                randomized_count += 1
        
        self.save_csv(status_file, rows)
        self.progress.emit(f"✅ Randomized stats for {randomized_count} Digimon!")
        if self.balance_stats:
            self.progress.emit("   Mode: Variance (±30%)")
        else:
            self.progress.emit("   Mode: Full Random (50-2000)")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.patch_data_path / "digimon_status.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_skill_properties(self) -> int:
        """Randomize skill properties (power, SP cost, elements)"""
        skill_file = self.patch_data_path / "battle_skill.mbe" / "00_battle_skill_list.csv"
        
        if not skill_file.exists():
            self.progress.emit("❌ Skill file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = skill_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(skill_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: battle_skill_list.csv")
        
        rows = self.load_csv(skill_file)
        if len(rows) < 2:
            return 0
        
        # Columns based on Time Stranger Data File Headers.txt:
        # power: 23, SPCost: 36, element: 28
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > 36:
                # Randomize power (column 23)
                try:
                    power = int(rows[i][23])
                    if power > 0:
                        rows[i][23] = str(random.randint(10, 300))
                except:
                    pass
                
                # Randomize SP cost (column 36)
                try:
                    sp_cost = int(rows[i][36])
                    if sp_cost > 0:
                        rows[i][36] = str(random.randint(5, 150))
                except:
                    pass
                
                # Randomize element (column 28) - 0-10
                try:
                    rows[i][28] = str(random.randint(0, 10))
                except:
                    pass
                
                randomized_count += 1
        
        self.save_csv(skill_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} skills!")
        self.progress.emit("   Power: 10-300 | SP Cost: 5-150 | Elements: Random")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.patch_data_path / "battle_skill.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_treasure_chests(self) -> int:
        """Randomize treasure chest contents"""
        treasure_file = self.patch_data_path / "field_treasure.mbe" / "02_field_treasure.csv"
        
        if not treasure_file.exists():
            self.progress.emit("❌ Treasure file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = treasure_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(treasure_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: field_treasure.csv")
        
        rows = self.load_csv(treasure_file)
        if len(rows) < 2:
            return 0
        
        # Collect all item IDs from column 5
        all_items = set()
        for row in rows[1:]:
            if len(row) > 5 and row[5]:
                try:
                    item_id = int(row[5])
                    if item_id > 0:
                        all_items.add(item_id)
                except:
                    pass
        
        all_items = list(all_items)
        if not all_items:
            self.progress.emit("❌ No items found!")
            return 0
        
        self.progress.emit(f"📦 Found {len(all_items)} unique items")
        
        # Randomize item IDs in column 5
        randomized_count = 0
        for i in range(1, len(rows)):
            if len(rows[i]) > 5 and rows[i][5]:
                try:
                    if int(rows[i][5]) > 0:
                        rows[i][5] = str(random.choice(all_items))
                        randomized_count += 1
                except:
                    pass
        
        self.save_csv(treasure_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} treasure chests!")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.patch_data_path / "field_treasure.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_shop_inventory(self) -> int:
        """Randomize shop inventory"""
        shop_file = self.patch_data_path / "shop.mbe" / "01_shop_lineup.csv"
        
        if not shop_file.exists():
            self.progress.emit("❌ Shop file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = shop_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(shop_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: shop_lineup.csv")
        
        rows = self.load_csv(shop_file)
        if len(rows) < 2:
            return 0
        
        # Collect all item IDs from column 3
        all_items = set()
        for row in rows[1:]:
            if len(row) > 3 and row[3]:
                try:
                    item_id = int(row[3])
                    if item_id > 0:
                        all_items.add(item_id)
                except:
                    pass
        
        all_items = list(all_items)
        if not all_items:
            self.progress.emit("❌ No items found!")
            return 0
        
        self.progress.emit(f"🛒 Found {len(all_items)} unique shop items")
        
        # Randomize item IDs in column 3
        randomized_count = 0
        for i in range(1, len(rows)):
            if len(rows[i]) > 3 and rows[i][3]:
                try:
                    if int(rows[i][3]) > 0:
                        rows[i][3] = str(random.choice(all_items))
                        randomized_count += 1
                except:
                    pass
        
        self.save_csv(shop_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} shop items!")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.patch_data_path / "shop.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def _update_skill_pointer_column(self, row: List[str], pointer_idx: int, old_skill: int, new_skill: str):
        """Update auxiliary skill columns when they store actual skill IDs"""
        if len(row) <= pointer_idx:
            return
        
        pointer_value = row[pointer_idx]
        if not pointer_value or pointer_value in ('0', '-1', '""'):
            return
        
        value = pointer_value.strip('"')
        try:
            pointer_num = int(value)
        except ValueError:
            row[pointer_idx] = new_skill
            return
        
        if pointer_num == old_skill or pointer_num > 1000:
            row[pointer_idx] = new_skill
    
    def randomize_skill_learnsets(self) -> int:
        """Randomize which skills each Digimon learns"""
        status_file = self.get_file_path("digimon_status.mbe", "000_digimon_status_data.csv", "00_digimon_status_data.csv")
        
        if not status_file.exists():
            self.progress.emit("❌ Digimon status file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = status_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(status_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: digimon_status_data.csv")
        
        rows = self.load_csv(status_file)
        if len(rows) < 2:
            return 0
        
        # Based on Time Stranger Data File Headers.txt
        # Format: (SkillID, empty, SlotNum/Level) × N
        # Signature skills: columns 72-107 (12 skills, 3 columns each)
        signature_skill_id_columns = [72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105]
        # Generic skills: columns 108-119 (4 skills, 3 columns each)
        generic_skill_id_columns = [108, 111, 114, 117]
        
        all_skill_id_columns = signature_skill_id_columns + generic_skill_id_columns
        
        # Collect all skill IDs from the ID columns
        all_skills = set()
        for row in rows[1:]:
            for col in all_skill_id_columns:
                if len(row) > col and row[col]:
                    try:
                        skill_id = int(row[col])
                        if skill_id > 0:
                            all_skills.add(skill_id)
                    except:
                        continue
        
        all_skills = list(all_skills)
        if not all_skills:
            self.progress.emit("❌ No skills found!")
            return 0
        
        self.progress.emit(f"📖 Found {len(all_skills)} unique skills")
        
        # Randomize skill IDs ONLY (keep slot/level columns unchanged)
        randomized_count = 0
        for i in range(1, len(rows)):
            row = rows[i]
            row_changed = False
            
            # Randomize all skill ID columns (both signature and generic)
            for id_col in all_skill_id_columns:
                if len(row) <= id_col:
                    continue
                try:
                    current_skill = int(row[id_col])
                except:
                    continue
                
                if current_skill > 0:
                    # Randomize the skill ID (slot/level stays the same)
                    row[id_col] = str(random.choice(all_skills))
                    row_changed = True
            
            if row_changed:
                randomized_count += 1
        
        self.save_csv(status_file, rows)
        self.progress.emit(f"✅ Randomized skill learnsets for {randomized_count} Digimon!")
        self.progress.emit(f"   Each Digimon now learns random skills (slot/level unchanged)")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.patch_data_path / "digimon_status.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def remove_evolution_requirements(self) -> int:
        """Set all evolution requirements to 1 (evolve anytime)"""
        evo_cond_file = self.get_file_path("evolution.mbe", "000_evolution_condition.csv", "00_evolution_condition.csv")
        
        if not evo_cond_file.exists():
            self.progress.emit("❌ Evolution condition file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = evo_cond_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(evo_cond_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: evolution_condition.csv")
        
        rows = self.load_csv(evo_cond_file)
        if len(rows) < 2:
            return 0
        
        # Based on Time Stranger Data File Headers.txt:
        # tamerLevel: 2
        # HP: 4, SP: 5, ATK: 6, DEF: 7, INT: 8, SPI: 9, SPD: 10
        # skillCountValor: 13, skillCountPhilantropy: 14, skillCountAmicable: 15, skillCountWisdom: 16
        stat_requirement_cols = [4, 5, 6, 7, 8, 9, 10]  # HP, SP, ATK, DEF, INT, SPI, SPD
        skill_count_cols = [13, 14, 15, 16]  # Skill counts
        modified_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(stat_requirement_cols + skill_count_cols):
                # Remove all requirements (set to 1/0)
                rows[i][2] = "1"  # Tamer Level = 1
                # Set all stat requirements to 0
                for col in stat_requirement_cols:
                    if rows[i][col] and rows[i][col] not in ('', '""'):
                        rows[i][col] = "0"
                # Set skill count requirements to 0
                for col in skill_count_cols:
                    if rows[i][col] and rows[i][col] not in ('', '""'):
                        rows[i][col] = "0"
                modified_count += 1
        
        self.save_csv(evo_cond_file, rows)
        self.progress.emit(f"✅ Removed requirements for {modified_count} evolution conditions!")
        self.progress.emit(f"   All evolutions now require only level 1")
        
        # Track modified folder
        folder = self.patch_data_path / "evolution.mbe"
        if folder not in self.modified_folders:
            self.modified_folders.append(folder)
        
        return modified_count
    

class RestoreThread(QThread):
    """Thread for restoring backups"""
    progress = pyqtSignal(str)
    finished = pyqtSignal(int)  # restored_count
    
    def __init__(self, data_path: Path):
        super().__init__()
        self.data_path = data_path
    
    def run(self):
        try:
            restored = self.restore_backups()
            self.finished.emit(restored)
        except Exception as e:
            self.progress.emit(f"❌ Error: {e}")
    
    def get_all_field_battle_folders(self) -> List[Path]:
        """Get all field_battle_*.mbe folders"""
        return sorted([p for p in self.data_path.iterdir() 
                      if p.is_dir() and p.name.startswith('field_battle_')])
    
    def load_csv(self, file_path: Path) -> List[List[str]]:
        """Load CSV file"""
        with open(file_path, 'r', encoding='utf-8') as f:
            reader = csv.reader(f)
            return [row for row in reader]
    
    def save_csv(self, file_path: Path, rows: List[List[str]]):
        """Save CSV file preserving exact format with proper quoting"""
        if not rows:
            return
        
        # Parse header to determine which columns are strings
        header = rows[0]
        string_cols = set()
        for i, col_type in enumerate(header):
            if 'string' in col_type.lower():
                string_cols.add(i)
        
        with open(file_path, 'w', encoding='utf-8', newline='') as f:
            for row_idx, row in enumerate(rows):
                formatted_row = []
                for col_idx, value in enumerate(row):
                    if row_idx == 0:  # Header row - keep as is
                        formatted_row.append(value)
                    elif col_idx in string_cols:
                        # String column - wrap in quotes
                        if value and not (value.startswith('"') and value.endswith('"')):
                            formatted_row.append(f'"{value}"')
                        elif not value:
                            formatted_row.append('""')
                        else:
                            formatted_row.append(value)
                    else:
                        # Non-string column - use "" for empty
                        formatted_row.append(value if value else '""')
                f.write(','.join(formatted_row) + '\n')
    
    def restore_backups(self) -> int:
        """Restore ALL backups (not just field_battle)"""
        restored = 0
        
        # Recursively find all .backup files in the data directory
        for backup_file in self.data_path.rglob('*.backup'):
            original_file = backup_file.with_suffix('')  # Remove .backup extension
            
            try:
                rows = self.load_csv(backup_file)
                self.save_csv(original_file, rows)
                # Show relative path from data folder for clarity
                rel_path = original_file.relative_to(self.data_path)
                self.progress.emit(f"✅ Restored: {rel_path}")
                restored += 1
            except Exception as e:
                self.progress.emit(f"❌ Failed to restore {backup_file.name}: {e}")
        
        return restored


class FieldBattleRandomizerGUI(QMainWindow):
    """Main GUI window"""
    
    def __init__(self):
        super().__init__()
        # Point to the dsts-loader/app_0/data folder inside the Randomizer folder
        # Field battle files go in app_0/data, other files stay in patch/data
        self.data_path = Path(__file__).parent / "dsts-loader" / "app_0" / "data"
        self.patch_data_path = Path(__file__).parent / "dsts-loader" / "patch" / "data"
        self.randomizer_thread = None
        self.restore_thread = None
        self.modified_folders = []  # Track which folders were modified in last randomization
        self.setup_ui()
        self.check_data_folder()
    
    def setup_ui(self):
        self.setWindowTitle("Game Randomizer - DTS Creator")
        self.setGeometry(100, 100, 1100, 950)  # Wider window to fit all text
        self.setMinimumSize(1000, 850)  # Minimum size to prevent text cutoff
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        
        # Title
        title = QLabel("DTS Creator - Game Randomizer")
        title.setFont(QFont("Arial", 16, QFont.Weight.Bold))
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        main_layout.addWidget(title)
        
        # Info label
        info = QLabel(
            "Comprehensive game randomizer with 9 randomization options!\n"
            "Mix and match to create your perfect chaotic playthrough."
        )
        info.setWordWrap(True)
        info.setStyleSheet("color: #666; padding: 5px;")
        main_layout.addWidget(info)
        
        # Data Path Selection
        path_group = QGroupBox("Data Folder")
        path_layout = QHBoxLayout(path_group)
        
        self.path_label = QLabel(str(self.data_path))
        self.path_label.setStyleSheet("padding: 5px; background-color: #f0f0f0; border: 1px solid #ccc; border-radius: 3px;")
        path_layout.addWidget(self.path_label, 1)
        
        browse_btn = QPushButton("Browse...")
        browse_btn.setToolTip("Select your data folder location")
        browse_btn.clicked.connect(self.browse_folder)
        path_layout.addWidget(browse_btn)
        
        main_layout.addWidget(path_group)
        
        # Status group
        status_group = QGroupBox("Status")
        status_layout = QVBoxLayout(status_group)
        
        self.status_label = QLabel("Ready")
        self.status_label.setFont(QFont("Arial", 10, QFont.Weight.Bold))
        status_layout.addWidget(self.status_label)
        
        self.file_count_label = QLabel("")
        status_layout.addWidget(self.file_count_label)
        
        main_layout.addWidget(status_group)
        
        # Options group
        options_group = QGroupBox("Randomization Options")
        options_layout = QVBoxLayout(options_group)
        
        self.backup_checkbox = QCheckBox("Create backups before randomizing (RECOMMENDED)")
        self.backup_checkbox.setChecked(True)
        options_layout.addWidget(self.backup_checkbox)
        
        # Separator
        separator = QLabel("─" * 50)
        separator.setStyleSheet("color: #ccc;")
        options_layout.addWidget(separator)
        
        # ===== BATTLES & ENCOUNTERS =====
        battles_label = QLabel("🎮 BATTLES & ENCOUNTERS")
        battles_label.setFont(QFont("Arial", 10, QFont.Weight.Bold))
        battles_label.setStyleSheet("color: #2196F3; padding-top: 5px;")
        options_layout.addWidget(battles_label)
        
        self.randomize_encounters_checkbox = QCheckBox("🎲 Field Encounters (Mixed)")
        self.randomize_encounters_checkbox.setChecked(True)
        self.randomize_encounters_checkbox.setToolTip("Randomize encounters with variety:\n• Slot 1: Matches overworld model (e.g., Agumon)\n• Slots 2-6: Random Digimon for variety\n• Result: Fight 1 Agumon + other random Digimon\n\n🛡️ Protected:\n• Boss encounters (with battle scripts)\n• Story-flagged encounters (FLAG_MAIN_, FLAG_SUB_, etc.)\n  → Keeps encounter groups but randomizes individual Digimon")
        options_layout.addWidget(self.randomize_encounters_checkbox)
        
        # Stat scaling sub-option
        stat_scale_layout = QHBoxLayout()
        stat_scale_layout.addSpacing(30)
        stat_scale_layout.addWidget(QLabel("📊 Enemy Stat Scale:"))
        self.encounter_stat_scale_spinbox = QSpinBox()
        self.encounter_stat_scale_spinbox.setRange(1, 500)
        self.encounter_stat_scale_spinbox.setValue(100)
        self.encounter_stat_scale_spinbox.setSuffix("%")
        self.encounter_stat_scale_spinbox.setToolTip("Scale enemy stats: 1% (very weak) to 500% (very strong)")
        stat_scale_layout.addWidget(self.encounter_stat_scale_spinbox)
        stat_scale_layout.addStretch()
        options_layout.addLayout(stat_scale_layout)
        
        # Boss encounter protection sub-option
        boss_protection_layout = QHBoxLayout()
        boss_protection_layout.addSpacing(30)
        self.include_boss_encounters_checkbox = QCheckBox("⚔️ Include Boss Encounters in Randomization")
        self.include_boss_encounters_checkbox.setChecked(False)
        self.include_boss_encounters_checkbox.setToolTip("⚠️ WARNING: Randomizing boss encounters may break battle scripts and story events!\n\nNOTE: Only encounters with ACTUAL battle scripts are protected.\nTutorial and normal field encounters (with 'battle_00000000' placeholder) ARE randomized.\n\nLeave unchecked to protect boss encounters (recommended)")
        boss_protection_layout.addWidget(self.include_boss_encounters_checkbox)
        options_layout.addLayout(boss_protection_layout)
        
        self.randomize_boss_digimon_checkbox = QCheckBox("👑 Boss Digimon (Full Random)")
        self.randomize_boss_digimon_checkbox.setChecked(False)
        self.randomize_boss_digimon_checkbox.setToolTip("Randomize which Digimon appear as bosses (FULL RANDOM - no power balancing, keeps battle scripts working)")
        options_layout.addWidget(self.randomize_boss_digimon_checkbox)
        
        self.randomize_evolutions_checkbox = QCheckBox("🧬 Evolution Paths (all Digimon)")
        self.randomize_evolutions_checkbox.setChecked(False)
        self.randomize_evolutions_checkbox.setToolTip("Randomize evolution targets - adds 6 evolutions for Digimon with 0")
        options_layout.addWidget(self.randomize_evolutions_checkbox)
        
        # Evolution balance sub-option
        evolution_balance_layout = QHBoxLayout()
        evolution_balance_layout.addSpacing(30)
        self.balance_evolutions_checkbox = QCheckBox("⚖️ Balanced Distribution")
        self.balance_evolutions_checkbox.setChecked(True)
        self.balance_evolutions_checkbox.setToolTip("Ensure every Digimon appears as target 6 times")
        evolution_balance_layout.addWidget(self.balance_evolutions_checkbox)
        options_layout.addLayout(evolution_balance_layout)
        
        self.randomize_deevolutions_checkbox = QCheckBox("🔙 De-evolution Paths (all Digimon)")
        self.randomize_deevolutions_checkbox.setChecked(False)
        self.randomize_deevolutions_checkbox.setToolTip("Randomize de-evolution targets - adds 6 de-evolutions for Digimon with 0")
        options_layout.addWidget(self.randomize_deevolutions_checkbox)
        
        # De-evolution balance sub-option
        deevolution_balance_layout = QHBoxLayout()
        deevolution_balance_layout.addSpacing(30)
        self.balance_deevolutions_checkbox = QCheckBox("⚖️ Balanced Distribution")
        self.balance_deevolutions_checkbox.setChecked(True)
        self.balance_deevolutions_checkbox.setToolTip("Ensure every Digimon appears as target 6 times")
        deevolution_balance_layout.addWidget(self.balance_deevolutions_checkbox)
        options_layout.addLayout(deevolution_balance_layout)
        
        # ===== STATS & BALANCE =====
        stats_label = QLabel("📊 STATS & BALANCE")
        stats_label.setFont(QFont("Arial", 10, QFont.Weight.Bold))
        stats_label.setStyleSheet("color: #FF9800; padding-top: 10px;")
        options_layout.addWidget(stats_label)
        
        self.randomize_stats_checkbox = QCheckBox("📈 Digimon Base Stats")
        self.randomize_stats_checkbox.setChecked(False)
        self.randomize_stats_checkbox.setToolTip("Randomize HP, SP, ATK, DEF, INT, SPI, SPD")
        options_layout.addWidget(self.randomize_stats_checkbox)
        
        # Stats balance sub-option
        stats_balance_layout = QHBoxLayout()
        stats_balance_layout.addSpacing(30)
        self.balance_stats_checkbox = QCheckBox("🎯 Variance Mode (±30%)")
        self.balance_stats_checkbox.setChecked(True)
        self.balance_stats_checkbox.setToolTip("Keep relative strength, just shuffle a bit")
        stats_balance_layout.addWidget(self.balance_stats_checkbox)
        options_layout.addLayout(stats_balance_layout)
        
        self.randomize_skills_checkbox = QCheckBox("⚔️ Skill Properties")
        self.randomize_skills_checkbox.setChecked(False)
        self.randomize_skills_checkbox.setToolTip("Randomize skill power, SP cost, elements")
        options_layout.addWidget(self.randomize_skills_checkbox)
        
        # Skill balance sub-option
        skills_balance_layout = QHBoxLayout()
        skills_balance_layout.addSpacing(30)
        self.balance_skills_checkbox = QCheckBox("⚖️ Keep Relative Power")
        self.balance_skills_checkbox.setChecked(True)
        self.balance_skills_checkbox.setToolTip("Balanced randomization (weaker skills stay weaker)")
        skills_balance_layout.addWidget(self.balance_skills_checkbox)
        options_layout.addLayout(skills_balance_layout)
        
        self.randomize_learnsets_checkbox = QCheckBox("📚 Skill Learnsets")
        self.randomize_learnsets_checkbox.setChecked(False)
        self.randomize_learnsets_checkbox.setToolTip("Randomize which skills each Digimon learns")
        options_layout.addWidget(self.randomize_learnsets_checkbox)
        
        # Learnset balance sub-option
        learnsets_balance_layout = QHBoxLayout()
        learnsets_balance_layout.addSpacing(30)
        self.balance_learnsets_checkbox = QCheckBox("⚖️ Maintain Skill Counts")
        self.balance_learnsets_checkbox.setChecked(True)
        self.balance_learnsets_checkbox.setToolTip("Keep same number of skills per Digimon")
        learnsets_balance_layout.addWidget(self.balance_learnsets_checkbox)
        options_layout.addLayout(learnsets_balance_layout)
        
        self.remove_evo_requirements_checkbox = QCheckBox("🚫 Remove Evolution Requirements")
        self.remove_evo_requirements_checkbox.setChecked(False)
        self.remove_evo_requirements_checkbox.setToolTip("Set all evolution requirements to level 1 (evolve anytime)")
        options_layout.addWidget(self.remove_evo_requirements_checkbox)
        
        # ===== ITEMS & REWARDS =====
        items_label = QLabel("🎁 ITEMS & REWARDS")
        items_label.setFont(QFont("Arial", 10, QFont.Weight.Bold))
        items_label.setStyleSheet("color: #4CAF50; padding-top: 10px;")
        options_layout.addWidget(items_label)
        
        self.randomize_treasure_checkbox = QCheckBox("🎁 Treasure Chests")
        self.randomize_treasure_checkbox.setChecked(False)
        self.randomize_treasure_checkbox.setToolTip("Randomize items in chests and pickups")
        options_layout.addWidget(self.randomize_treasure_checkbox)
        
        # Treasure balance sub-option
        treasure_balance_layout = QHBoxLayout()
        treasure_balance_layout.addSpacing(30)
        self.balance_treasure_checkbox = QCheckBox("⚖️ Similar Value Items")
        self.balance_treasure_checkbox.setChecked(True)
        self.balance_treasure_checkbox.setToolTip("Replace with items of similar rarity/value")
        treasure_balance_layout.addWidget(self.balance_treasure_checkbox)
        options_layout.addLayout(treasure_balance_layout)
        
        self.randomize_shops_checkbox = QCheckBox("🛍️ Shop Inventory")
        self.randomize_shops_checkbox.setChecked(False)
        self.randomize_shops_checkbox.setToolTip("Randomize shop stock")
        options_layout.addWidget(self.randomize_shops_checkbox)
        
        # Shop balance sub-option
        shops_balance_layout = QHBoxLayout()
        shops_balance_layout.addSpacing(30)
        self.balance_shops_checkbox = QCheckBox("⚖️ Similar Price Items")
        self.balance_shops_checkbox.setChecked(True)
        self.balance_shops_checkbox.setToolTip("Replace with items of similar price range")
        shops_balance_layout.addWidget(self.balance_shops_checkbox)
        options_layout.addLayout(shops_balance_layout)
        
        # Wrap options in scroll area
        scroll_area = QScrollArea()
        scroll_area.setWidget(options_group)
        scroll_area.setWidgetResizable(True)
        scroll_area.setMaximumHeight(350)  # Limit height so log area is visible
        main_layout.addWidget(scroll_area)
        
        # Buttons
        button_layout = QVBoxLayout()
        
        # Row 1: Randomize and Restore
        row1_layout = QHBoxLayout()
        
        self.randomize_button = QPushButton("🎲 Start Randomization")
        self.randomize_button.setStyleSheet("background-color: #4CAF50; color: white; font-weight: bold; padding: 10px;")
        self.randomize_button.clicked.connect(self.randomize)
        row1_layout.addWidget(self.randomize_button)
        
        self.restore_button = QPushButton("🔄 Restore from Backups")
        self.restore_button.setStyleSheet("background-color: #2196F3; color: white; font-weight: bold; padding: 10px;")
        self.restore_button.clicked.connect(self.restore)
        row1_layout.addWidget(self.restore_button)
        
        button_layout.addLayout(row1_layout)
        
        main_layout.addLayout(button_layout)
        
        # Progress bar
        self.progress_bar = QProgressBar()
        self.progress_bar.setVisible(False)
        main_layout.addWidget(self.progress_bar)
        
        # Log output
        log_group = QGroupBox("Log")
        log_layout = QVBoxLayout(log_group)
        
        self.log_output = QTextEdit()
        self.log_output.setReadOnly(True)
        self.log_output.setFont(QFont("Consolas", 9))
        self.log_output.setMinimumHeight(250)  # Ensure log area is visible
        log_layout.addWidget(self.log_output)
        
        main_layout.addWidget(log_group, 2)  # Give log area more stretch priority
    
    def browse_folder(self):
        """Browse for custom folder"""
        folder = QFileDialog.getExistingDirectory(
            self,
            "Select Data Folder",
            str(self.data_path.parent)
        )
        if folder:
            self.data_path = Path(folder)
            self.path_label.setText(str(self.data_path))
            self.log_output.clear()
            self.check_data_folder()
    
    def check_data_folder(self):
        """Check if data folder exists and count files"""
        if not self.data_path.exists():
            self.status_label.setText(f"❌ Error: '{self.data_path}' folder not found!")
            self.status_label.setStyleSheet("color: red;")
            self.randomize_button.setEnabled(False)
            self.restore_button.setEnabled(False)
            return
        
        # Count field_battle folders
        folders = [p for p in self.data_path.iterdir() 
                  if p.is_dir() and p.name.startswith('field_battle_')]
        
        self.file_count_label.setText(f"Found {len(folders)} field_battle folders in {self.data_path}")
        self.status_label.setText("✅ Ready")
        self.status_label.setStyleSheet("color: green;")
        
        self.log(f"📁 Scanning: {self.data_path}")
        self.log(f"Found {len(folders)} field_battle folders to randomize:")
        for folder in sorted(folders):
            self.log(f"  • {folder.name}")
    
    def log(self, message: str):
        """Add message to log output"""
        self.log_output.append(message)
        self.log_output.verticalScrollBar().setValue(
            self.log_output.verticalScrollBar().maximum()
        )
    
    def randomize(self):
        """Start randomization"""
        if self.randomizer_thread and self.randomizer_thread.isRunning():
            return
        
        # Confirm
        if not self.backup_checkbox.isChecked():
            reply = QMessageBox.warning(
                self,
                "No Backup Warning",
                "⚠️ You have disabled backups!\n\n"
                "If something goes wrong, you won't be able to restore the original files.\n\n"
                "Continue anyway?",
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
            )
            if reply == QMessageBox.StandardButton.No:
                return
        
        # Disable buttons
        self.randomize_button.setEnabled(False)
        self.restore_button.setEnabled(False)
        self.backup_checkbox.setEnabled(False)
        
        # Show progress
        self.progress_bar.setVisible(True)
        self.progress_bar.setRange(0, 0)  # Indeterminate
        
        self.status_label.setText("🎲 Randomizing...")
        self.status_label.setStyleSheet("color: orange;")
        
        self.log("\n" + "="*50)
        self.log("Starting randomization...")
        
        # Check if at least one option is selected
        any_option_selected = (
            self.randomize_encounters_checkbox.isChecked() or 
            self.randomize_boss_digimon_checkbox.isChecked() or
            self.randomize_evolutions_checkbox.isChecked() or 
            self.randomize_deevolutions_checkbox.isChecked() or
            self.randomize_stats_checkbox.isChecked() or
            self.randomize_skills_checkbox.isChecked() or
            self.randomize_learnsets_checkbox.isChecked() or
            self.remove_evo_requirements_checkbox.isChecked() or
            self.randomize_treasure_checkbox.isChecked() or
            self.randomize_shops_checkbox.isChecked()
        )
        
        if not any_option_selected:
            QMessageBox.warning(
                self,
                "No Options Selected",
                "⚠️ Please select at least one randomization option!"
            )
            self.randomize_button.setEnabled(True)
            self.restore_button.setEnabled(True)
            self.backup_checkbox.setEnabled(True)
            return
        
        # Start thread
        self.randomizer_thread = RandomizerThread(
            self.data_path, 
            self.backup_checkbox.isChecked(),
            self.patch_data_path,
            self.randomize_encounters_checkbox.isChecked(),
            self.encounter_stat_scale_spinbox.value(),
            self.include_boss_encounters_checkbox.isChecked(),
            self.randomize_boss_digimon_checkbox.isChecked(),
            self.randomize_evolutions_checkbox.isChecked(),
            self.balance_evolutions_checkbox.isChecked(),
            self.randomize_deevolutions_checkbox.isChecked(),
            self.balance_deevolutions_checkbox.isChecked(),
            self.randomize_stats_checkbox.isChecked(),
            self.balance_stats_checkbox.isChecked(),
            self.randomize_skills_checkbox.isChecked(),
            self.balance_skills_checkbox.isChecked(),
            self.randomize_learnsets_checkbox.isChecked(),
            self.balance_learnsets_checkbox.isChecked(),
            self.remove_evo_requirements_checkbox.isChecked(),
            self.randomize_treasure_checkbox.isChecked(),
            self.balance_treasure_checkbox.isChecked(),
            self.randomize_shops_checkbox.isChecked(),
            self.balance_shops_checkbox.isChecked()
        )
        self.randomizer_thread.progress.connect(self.log)
        self.randomizer_thread.modified_files.connect(self.on_modified_files)
        self.randomizer_thread.finished.connect(self.on_randomize_finished)
        self.randomizer_thread.start()
    
    def on_modified_files(self, folders: list):
        """Handle list of modified folders from randomizer"""
        self.modified_folders = folders
        self.log(f"\n📁 Modified {len(folders)} .mbe folder(s)")
    
    def on_randomize_finished(self, total_randomized: int, total_files: int):
        """Handle randomization completion"""
        self.progress_bar.setVisible(False)
        self.randomize_button.setEnabled(True)
        self.restore_button.setEnabled(True)
        self.backup_checkbox.setEnabled(True)
        
        self.status_label.setText("✅ Randomization Complete!")
        self.status_label.setStyleSheet("color: green;")
        
        self.log("="*50)
        self.log(f"🎉 COMPLETE! Randomized {total_randomized} items across {total_files} file(s)")
        
        QMessageBox.information(
            self,
            "Success",
            f"✅ Randomization complete!\n\n"
            f"Modified {total_randomized} entries across {total_files} file(s).\n\n"
            f"{'Backups created with .backup extension' if self.backup_checkbox.isChecked() else 'No backups created'}"
        )
    
    def restore(self):
        """Start restoration from backups"""
        if self.restore_thread and self.restore_thread.isRunning():
            return
        
        # Confirm
        reply = QMessageBox.question(
            self,
            "Restore Backups",
            "This will restore all field_battle files from their .backup versions.\n\n"
            "Any randomized data will be lost.\n\n"
            "Continue?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        if reply == QMessageBox.StandardButton.No:
            return
        
        # Disable buttons
        self.randomize_button.setEnabled(False)
        self.restore_button.setEnabled(False)
        
        # Show progress
        self.progress_bar.setVisible(True)
        self.progress_bar.setRange(0, 0)
        
        self.status_label.setText("🔄 Restoring...")
        self.status_label.setStyleSheet("color: orange;")
        
        self.log("\n" + "="*50)
        self.log("Restoring from backups...")
        
        # Start thread
        self.restore_thread = RestoreThread(self.data_path)
        self.restore_thread.progress.connect(self.log)
        self.restore_thread.finished.connect(self.on_restore_finished)
        self.restore_thread.start()
    
    def on_restore_finished(self, restored: int):
        """Handle restoration completion"""
        self.progress_bar.setVisible(False)
        self.randomize_button.setEnabled(True)
        self.restore_button.setEnabled(True)
        
        self.status_label.setText("✅ Restoration Complete!")
        self.status_label.setStyleSheet("color: green;")
        
        self.log("="*50)
        self.log(f"🔄 Restored {restored} files from backups")
        
        QMessageBox.information(
            self,
            "Success",
            f"✅ Restoration complete!\n\n"
            f"Restored {restored} files from backups."
        )
    
    # REMOVED: repack_mbe_files() method - no longer needed with new modloader!
    # The new modloader reads CSV files directly from the data folder


def main():
    app = QApplication(sys.argv)
    app.setApplicationName("Field Battle Randomizer")
    
    window = FieldBattleRandomizerGUI()
    window.show()
    
    sys.exit(app.exec())


if __name__ == "__main__":
    main()


