"""
Game Randomizer GUI - Comprehensive randomizer with 13 randomization options
Features:
- Field Encounters (with level balancing)
- Evolution & De-evolution Paths
- Digimon Base Stats & Growth Rates
- Battle Skills & Skill Learnsets
- Personality Effects
- Evolution Requirements
- Treasure Chests & Shop Inventory
- Item Properties
- Tamer Skills
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
    QProgressBar, QComboBox, QFileDialog
)
from PyQt6.QtCore import Qt, QThread, pyqtSignal
from PyQt6.QtGui import QFont


class RandomizerThread(QThread):
    """Thread for running randomization in background"""
    progress = pyqtSignal(str)
    finished = pyqtSignal(int, int)  # total_randomized, total_files
    modified_files = pyqtSignal(list)  # List of modified .mbe folders
    
    def __init__(self, data_path: Path, backup: bool, 
                 randomize_encounters: bool = True, balance_encounters: bool = True,
                 randomize_evolutions: bool = False, randomize_deevolutions: bool = False,
                 randomize_stats: bool = False, balance_stats: bool = True,
                 randomize_skills: bool = False,
                 randomize_learnsets: bool = False,
                 randomize_personalities: bool = False,
                 randomize_evo_reqs: bool = False, remove_evo_reqs: bool = True,
                 randomize_treasure: bool = False,
                 randomize_shops: bool = False,
                 randomize_items: bool = False,
                 randomize_growth: bool = False,
                 randomize_tamer_skills: bool = False):
        super().__init__()
        self.data_path = data_path
        self.backup = backup
        self.randomize_encounters = randomize_encounters
        self.balance_encounters = balance_encounters
        self.randomize_evolutions = randomize_evolutions
        self.randomize_deevolutions = randomize_deevolutions
        self.randomize_stats = randomize_stats
        self.balance_stats = balance_stats
        self.randomize_skills = randomize_skills
        self.randomize_learnsets = randomize_learnsets
        self.randomize_personalities = randomize_personalities
        self.randomize_evo_reqs = randomize_evo_reqs
        self.remove_evo_reqs = remove_evo_reqs
        self.randomize_treasure = randomize_treasure
        self.randomize_shops = randomize_shops
        self.randomize_items = randomize_items
        self.randomize_growth = randomize_growth
        self.randomize_tamer_skills = randomize_tamer_skills
        self.modified_folders = []  # Track which .mbe folders were modified
    
    def run(self):
        try:
            total_randomized, total_files = self.randomize_files()
            self.modified_files.emit(self.modified_folders)
            self.finished.emit(total_randomized, total_files)
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
    
    def collect_all_column1_values(self) -> List[str]:
        """Collect all valid encounter IDs from battle_enemy.mbe/01_encount_group.csv"""
        all_values = set()
        
        # Load valid encounter IDs from the encounter group file
        encounter_file = self.data_path.parent / "data" / "battle_enemy.mbe" / "01_encount_group.csv"
        
        # If data_path is already 'data', don't go up a level
        if self.data_path.name == "data":
            encounter_file = self.data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        elif (self.data_path / "battle_enemy.mbe" / "01_encount_group.csv").exists():
            encounter_file = self.data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        
        if encounter_file.exists():
            rows = self.load_csv(encounter_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 0 and row[0]:  # Column 0 is encounter ID
                    encounter_id = row[0]
                    # Exclude tutorial encounters (IDs starting with 1010)
                    if not encounter_id.startswith("1010"):
                        all_values.add(encounter_id)
        else:
            # Fallback: collect from field_battle files if encounter file not found
            field_battle_folders = self.get_all_field_battle_folders()
            for folder in field_battle_folders:
                csv_file = folder / "01_field_symbol_enemy.csv"
                if csv_file.exists():
                    rows = self.load_csv(csv_file)
                    for row in rows[1:]:  # Skip header
                        if len(row) > 1 and row[1]:
                            encounter_id = row[1]
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
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🎲 RANDOMIZING FIELD ENCOUNTERS")
            self.progress.emit("="*50)
            enc_randomized, enc_files = self.randomize_field_encounters()
            total_randomized += enc_randomized
            total_files += enc_files
        
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
        
        # Randomize personalities
        if self.randomize_personalities:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🎭 RANDOMIZING PERSONALITY EFFECTS")
            self.progress.emit("="*50)
            personality_randomized = self.randomize_personality_effects()
            total_randomized += personality_randomized
            total_files += 1
        
        # Randomize evolution requirements
        if self.randomize_evo_reqs:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("⏱️ RANDOMIZING EVOLUTION REQUIREMENTS")
            self.progress.emit("="*50)
            evo_req_randomized = self.randomize_evolution_requirements()
            total_randomized += evo_req_randomized
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
        
        # Randomize items
        if self.randomize_items:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("💊 RANDOMIZING ITEM PROPERTIES")
            self.progress.emit("="*50)
            item_randomized = self.randomize_item_properties()
            total_randomized += item_randomized
            total_files += 1
        
        # Randomize growth rates
        if self.randomize_growth:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("📈 RANDOMIZING GROWTH RATES")
            self.progress.emit("="*50)
            growth_randomized = self.randomize_digimon_growth()
            total_randomized += growth_randomized
            total_files += 1
        
        # Randomize tamer skills
        if self.randomize_tamer_skills:
            self.progress.emit("\n" + "="*50)
            self.progress.emit("🎯 RANDOMIZING TAMER SKILLS")
            self.progress.emit("="*50)
            tamer_randomized = self.randomize_tamer_skill_effects()
            total_randomized += tamer_randomized
            total_files += 1
        
        return total_randomized, total_files
    
    def get_encounter_level(self, encounter_id: str) -> int:
        """Get the average level of an encounter by looking it up in encount_group"""
        try:
            encounter_file = self.data_path / "battle_enemy.mbe" / "01_encount_group.csv"
            if not encounter_file.exists():
                return -1
            
            rows = self.load_csv(encounter_file)
            for row in rows[1:]:
                if len(row) > 0 and row[0] == encounter_id:
                    # Extract levels from columns 8, 20, 32 (first enemy in each slot)
                    levels = []
                    for col in [8, 20, 32]:
                        if len(row) > col and row[col]:
                            try:
                                level = int(row[col])
                                if level > 0:
                                    levels.append(level)
                            except:
                                pass
                    if levels:
                        return sum(levels) // len(levels)  # Average level
            return -1
        except:
            return -1
    
    def randomize_field_encounters(self) -> tuple:
        """Randomize field battle encounters"""
        self.progress.emit("🔍 Collecting encounter IDs...")
        all_encounters = self.collect_all_column1_values()
        
        if not all_encounters:
            self.progress.emit("❌ No values found!")
            return 0, 0
        
        self.progress.emit(f"✅ Found {len(all_encounters)} unique encounter IDs")
        
        # If balancing is enabled, group encounters by level
        encounter_by_level = {}
        if self.balance_encounters:
            self.progress.emit("⚖️ Analyzing encounter levels for balancing...")
            for enc_id in all_encounters:
                level = self.get_encounter_level(enc_id)
                if level > 0:
                    if level not in encounter_by_level:
                        encounter_by_level[level] = []
                    encounter_by_level[level].append(enc_id)
            
            if encounter_by_level:
                self.progress.emit(f"✅ Grouped encounters by level (range: {min(encounter_by_level.keys())}-{max(encounter_by_level.keys())})")
            else:
                self.progress.emit("⚠️ Could not determine levels, using full random")
                self.balance_encounters = False
        
        self.progress.emit("")
        
        field_battle_folders = self.get_all_field_battle_folders()
        total_randomized = 0
        
        for folder in field_battle_folders:
            csv_file = folder / "01_field_symbol_enemy.csv"
            
            if not csv_file.exists():
                continue
            
            # Backup if requested
            if self.backup:
                backup_file = csv_file.with_suffix('.csv.backup')
                if not backup_file.exists():
                    rows = self.load_csv(csv_file)
                    self.save_csv(backup_file, rows)
                    self.progress.emit(f"💾 Backed up: {folder.name}")
            
            # Load and randomize
            rows = self.load_csv(csv_file)
            
            if len(rows) < 2:
                continue
            
            randomized_count = 0
            
            for i in range(1, len(rows)):
                if len(rows[i]) > 1 and rows[i][1]:
                    # Get current encounter's level
                    if self.balance_encounters and encounter_by_level:
                        current_level = self.get_encounter_level(rows[i][1])
                        
                        # Find encounters within ±10 levels
                        candidates = []
                        for level in range(max(1, current_level - 10), current_level + 11):
                            if level in encounter_by_level:
                                candidates.extend(encounter_by_level[level])
                        
                        if candidates:
                            rows[i][1] = random.choice(candidates)
                        else:
                            # Fallback to full random if no balanced options
                            rows[i][1] = random.choice(all_encounters)
                    else:
                        # Full random mode
                        rows[i][1] = random.choice(all_encounters)
                    
                    randomized_count += 1
            
            self.save_csv(csv_file, rows)
            self.progress.emit(f"✅ {folder.name}: {randomized_count} encounters")
            total_randomized += randomized_count
        
        # Track all modified field_battle folders
        if field_battle_folders and total_randomized > 0:
            for folder in field_battle_folders:
                if folder not in self.modified_folders:
                    self.modified_folders.append(folder)
        
        return total_randomized, len(field_battle_folders)
    
    def randomize_evolution_paths(self) -> int:
        """Randomize evolution paths (which Digimon evolves into which)
        Ensures ALL Digimon have evolution paths (adds 6 for those with 0)"""
        evo_file = self.data_path / "evolution.mbe" / "01_evolution_to.csv"
        
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
        
        # Collect ALL possible Digimon IDs from digimon_status_data.csv
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        all_digimon_ids = set()
        
        if status_file.exists():
            status_rows = self.load_csv(status_file)
            for row in status_rows[1:]:
                if len(row) > 0 and row[0]:
                    all_digimon_ids.add(row[0])
            self.progress.emit(f"📊 Found {len(all_digimon_ids)} total Digimon in game data")
        else:
            # Fallback: collect from evolution file only
            for row in rows[1:]:
                if len(row) > 1 and row[1]:
                    all_digimon_ids.add(row[1])
                if len(row) > 3 and row[3]:
                    all_digimon_ids.add(row[3])
            self.progress.emit(f"⚠️ Using {len(all_digimon_ids)} Digimon from evolution file only")
        
        # Collect evolution targets for randomization pool
        all_target_ids = set()
        for row in rows[1:]:
            if len(row) > 3 and row[3]:
                all_target_ids.add(row[3])
        
        if not all_target_ids:
            self.progress.emit("❌ No target Digimon found!")
            return 0
        
        # Use all Digimon as potential targets
        all_digimon_list = sorted(all_digimon_ids)
        self.progress.emit(f"📊 Creating balanced evolution distribution for {len(all_digimon_list)} Digimon")
        
        # Delete ALL existing evolution rows (we'll rebuild with exactly 6 each)
        rows = [rows[0]]  # Keep only header
        
        # Get a template row to copy structure
        template_row = [""] * len(rows[0])
        
        # BALANCED APPROACH: Ensure every Digimon appears as a target exactly 6 times
        # Create a list where each Digimon appears exactly 6 times
        balanced_targets = []
        for digimon_id in all_digimon_list:
            balanced_targets.extend([digimon_id] * 6)
        
        # Shuffle the balanced list
        random.shuffle(balanced_targets)
        
        # Distribute targets evenly across all Digimon (6 each)
        target_idx = 0
        randomized_count = 0
        
        for from_id in all_digimon_list:
            # Take next 6 targets from the shuffled balanced list
            chosen_targets = balanced_targets[target_idx:target_idx + 6]
            target_idx += 6
            
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
        self.progress.emit(f"   BALANCED: Every Digimon has 6 evolution targets AND appears as a target 6 times!")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.data_path / "evolution.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_deevolution_paths(self) -> int:
        """Randomize de-evolution paths using 02_chronodevolution.csv
        Ensures ALL Digimon have de-evolution paths (adds 6 for those with 0)"""
        deevo_file = self.data_path / "evolution.mbe" / "02_chronodevolution.csv"
        
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
        
        # Collect ALL possible Digimon IDs from digimon_status_data.csv
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        all_digimon_ids = set()
        
        if status_file.exists():
            status_rows = self.load_csv(status_file)
            for row in status_rows[1:]:
                if len(row) > 0 and row[0]:
                    all_digimon_ids.add(row[0])
            self.progress.emit(f"📊 Found {len(all_digimon_ids)} total Digimon in game data")
        else:
            # Fallback: collect from de-evolution file
            for row in rows[1:]:
                if len(row) > 0 and row[0]:
                    all_digimon_ids.add(row[0])
                for col in range(2, len(row)):
                    if row[col] and row[col] not in ('', '-1', '""'):
                        try:
                            all_digimon_ids.add(row[col])
                        except:
                            pass
            self.progress.emit(f"⚠️ Using {len(all_digimon_ids)} Digimon from de-evolution file only")
        
        # Use all Digimon as potential de-evolution targets
        all_digimon_list = sorted(all_digimon_ids)
        self.progress.emit(f"📊 Creating balanced de-evolution distribution for {len(all_digimon_list)} Digimon")
        
        # Get the number of columns from original file
        num_cols = len(rows[0])
        
        # Delete ALL existing rows (we'll rebuild with exactly 6 each)
        rows = [rows[0]]  # Keep only header
        
        # BALANCED APPROACH: Ensure every Digimon appears as a target exactly 6 times
        # Create a list where each Digimon appears exactly 6 times
        balanced_targets = []
        for digimon_id in all_digimon_list:
            balanced_targets.extend([digimon_id] * 6)
        
        # Shuffle the balanced list
        random.shuffle(balanced_targets)
        
        # Distribute targets evenly across all Digimon (6 each)
        target_idx = 0
        randomized_count = 0
        
        for digimon_id in all_digimon_list:
            # Take next 6 targets from the shuffled balanced list
            chosen_targets = balanced_targets[target_idx:target_idx + 6]
            target_idx += 6
            
            # Create new row
            new_row = ['""'] * num_cols
            new_row[0] = digimon_id  # Digimon ID
            new_row[1] = '""'  # Column 1 (empty string column)
            
            # Columns 2-7: de-evolution targets (6 total)
            # Fill with targets first, then -1 for unused slots
            for col_idx in range(6):
                col = col_idx + 2  # Columns 2-7
                if col < num_cols:
                    if col_idx < len(chosen_targets):
                        new_row[col] = chosen_targets[col_idx]
                        randomized_count += 1
                    else:
                        new_row[col] = '-1'
            
            rows.append(new_row)
        
        # Save
        self.save_csv(deevo_file, rows)
        self.progress.emit(f"✅ Created {randomized_count} de-evolution paths!")
        self.progress.emit(f"   BALANCED: Every Digimon has 6 de-evolution targets AND appears as a target 6 times!")
        
        # Track modified folder (same as evolution)
        if randomized_count > 0:
            folder = self.data_path / "evolution.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_digimon_stats(self) -> int:
        """Randomize Digimon base stats (HP, SP, ATK, DEF, INT, SPI, SPD)"""
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        
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
            folder = self.data_path / "digimon_status.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_skill_properties(self) -> int:
        """Randomize skill properties (power, SP cost, elements)"""
        skill_file = self.data_path / "battle_skill.mbe" / "00_battle_skill_list.csv"
        
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
            folder = self.data_path / "battle_skill.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_treasure_chests(self) -> int:
        """Randomize treasure chest contents"""
        treasure_file = self.data_path / "field_treasure.mbe" / "02_field_treasure.csv"
        
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
            folder = self.data_path / "field_treasure.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_shop_inventory(self) -> int:
        """Randomize shop inventory"""
        shop_file = self.data_path / "shop.mbe" / "01_shop_lineup.csv"
        
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
            folder = self.data_path / "shop.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_skill_learnsets(self) -> int:
        """Randomize which skills each Digimon learns"""
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        
        if not status_file.exists():
            self.progress.emit("❌ Digimon status file not found!")
            return 0
        
        rows = self.load_csv(status_file)
        if len(rows) < 2:
            return 0
        
        # Based on Time Stranger Data File Headers.txt:
        # Signature skill IDs: 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105
        # Generic skill IDs: 108, 111, 114, 117
        signature_skill_cols = [72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105]
        generic_skill_cols = [108, 111, 114, 117]
        all_skill_cols = signature_skill_cols + generic_skill_cols
        
        # Collect all skill IDs from these columns
        all_skills = set()
        for row in rows[1:]:
            for col in all_skill_cols:
                if len(row) > col and row[col]:
                    try:
                        skill_id = int(row[col])
                        if skill_id > 0:
                            all_skills.add(skill_id)
                    except:
                        pass
        
        all_skills = list(all_skills)
        if not all_skills:
            self.progress.emit("❌ No skills found!")
            return 0
        
        self.progress.emit(f"📖 Found {len(all_skills)} unique skills")
        
        # Randomize skill IDs in both signature and generic skill columns
        randomized_count = 0
        for i in range(1, len(rows)):
            if len(rows[i]) > max(all_skill_cols):
                for col in all_skill_cols:
                    try:
                        if int(rows[i][col]) > 0:
                            rows[i][col] = str(random.choice(all_skills))
                    except:
                        pass
                randomized_count += 1
        
        self.save_csv(status_file, rows)
        self.progress.emit(f"✅ Randomized skill learnsets for {randomized_count} Digimon!")
        self.progress.emit(f"   Each Digimon now learns random skills from the pool")
        
        # Track modified folder (same as stats)
        if randomized_count > 0:
            folder = self.data_path / "digimon_status.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_personality_effects(self) -> int:
        """Randomize personality stat bonuses"""
        personality_file = self.data_path / "personality.mbe" / "00_personality_parameter.csv"
        
        if not personality_file.exists():
            self.progress.emit("❌ Personality file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = personality_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(personality_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: personality_parameter.csv")
        
        rows = self.load_csv(personality_file)
        if len(rows) < 2:
            return 0
        
        # Columns 6-13 are stat bonus percentages
        stat_bonus_columns = [6, 7, 8, 9, 10, 11, 12, 13]
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(stat_bonus_columns):
                # Randomize stat bonuses (0-4, representing percentage bonuses)
                for col in stat_bonus_columns:
                    rows[i][col] = str(random.randint(0, 4))
                randomized_count += 1
        
        self.save_csv(personality_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} personalities!")
        self.progress.emit("   Stat bonuses: Random 0-4 for all stats")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.data_path / "personality.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_evolution_requirements(self) -> int:
        """Randomize or remove evolution requirements"""
        evo_cond_file = self.data_path / "evolution.mbe" / "00_evolution_condition.csv"
        
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
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(stat_requirement_cols + skill_count_cols):
                if self.remove_evo_reqs:
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
                else:
                    # Randomize requirements
                    rows[i][2] = str(random.randint(1, 99))  # Random tamer level 1-99
                    # Randomize stat requirements (0-1000)
                    for col in stat_requirement_cols:
                        if rows[i][col] and rows[i][col] not in ('', '""'):
                            rows[i][col] = str(random.randint(0, 1000))
                    # Randomize skill count requirements (0-20)
                    for col in skill_count_cols:
                        if rows[i][col] and rows[i][col] not in ('', '""'):
                            rows[i][col] = str(random.randint(0, 20))
                randomized_count += 1
        
        self.save_csv(evo_cond_file, rows)
        
        if self.remove_evo_reqs:
            self.progress.emit(f"✅ Removed all requirements for {randomized_count} evolutions!")
            self.progress.emit("   All Digimon can now evolve at level 1!")
        else:
            self.progress.emit(f"✅ Randomized requirements for {randomized_count} evolutions!")
            self.progress.emit("   Levels: 1-99 | Stats: 0-1000")
        
        # Track modified folder (same as evolution paths)
        if randomized_count > 0:
            folder = self.data_path / "evolution.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_item_properties(self) -> int:
        """Randomize item effects and prices"""
        item_file = self.data_path / "item.mbe" / "00_item_parameter.csv"
        
        if not item_file.exists():
            self.progress.emit("❌ Item file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = item_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(item_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: item_parameter.csv")
        
        rows = self.load_csv(item_file)
        if len(rows) < 2:
            return 0
        
        # Columns: 7(effect value), 8(buy price), 9(sell price)
        # NOTE: Not verified in headers file - based on empirical observation
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > 9:
                # Randomize effect value
                try:
                    effect = int(rows[i][7])
                    if effect > 0:
                        rows[i][7] = str(random.randint(max(1, effect // 2), effect * 2))
                except:
                    pass
                
                # Randomize buy price
                try:
                    price = int(rows[i][8])
                    if price > 0:
                        rows[i][8] = str(random.randint(max(1, price // 2), price * 2))
                except:
                    pass
                
                # Randomize sell price
                try:
                    sell = int(rows[i][9])
                    if sell > 0:
                        rows[i][9] = str(random.randint(max(1, sell // 2), sell * 2))
                except:
                    pass
                
                randomized_count += 1
        
        self.save_csv(item_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} items!")
        self.progress.emit("   Effect values: 50%-200% | Prices: 50%-200%")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.data_path / "item.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_digimon_growth(self) -> int:
        """Randomize stat growth per level"""
        growth_file = self.data_path / "digimon_growth.mbe" / "00_digimon_growth_data.csv"
        
        if not growth_file.exists():
            self.progress.emit("❌ Growth rates file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = growth_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(growth_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: digimon_growth_data.csv")
        
        rows = self.load_csv(growth_file)
        if len(rows) < 2:
            return 0
        
        # Growth rate columns (HP, SP, ATK, DEF, INT, SPD growth per level)
        # Columns 2-8 typically contain growth rates
        # NOTE: Not verified in headers file - based on empirical observation
        growth_cols = list(range(2, 9))
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(growth_cols):
                for col in growth_cols:
                    try:
                        original = float(rows[i][col])
                        if original > 0:
                            # Randomize ±40%
                            min_val = max(0.1, original * 0.6)
                            max_val = original * 1.4
                            rows[i][col] = str(round(random.uniform(min_val, max_val), 2))
                    except:
                        pass
                randomized_count += 1
        
        self.save_csv(growth_file, rows)
        self.progress.emit(f"✅ Randomized growth rates for {randomized_count} Digimon!")
        self.progress.emit("   Growth rates: 60%-140% of original")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.data_path / "digimon_growth.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count
    
    def randomize_tamer_skill_effects(self) -> int:
        """Randomize tamer skill effects"""
        tamer_file = self.data_path / "tamer_skill.mbe" / "00_tamer_skill_list.csv"
        
        if not tamer_file.exists():
            self.progress.emit("❌ Tamer skill file not found!")
            return 0
        
        # Backup
        if self.backup:
            backup_file = tamer_file.with_suffix('.csv.backup')
            if not backup_file.exists():
                rows = self.load_csv(tamer_file)
                self.save_csv(backup_file, rows)
                self.progress.emit("💾 Backed up: tamer_skill_list.csv")
        
        rows = self.load_csv(tamer_file)
        if len(rows) < 2:
            return 0
        
        # Effect value columns (varies, typically around columns 5-15)
        # NOTE: Not verified in headers file - based on empirical observation
        effect_cols = list(range(5, 16))
        randomized_count = 0
        
        for i in range(1, len(rows)):
            if len(rows[i]) > max(effect_cols):
                for col in effect_cols:
                    try:
                        original = int(rows[i][col])
                        if original != 0:
                            # Randomize ±30%
                            min_val = int(original * 0.7)
                            max_val = int(original * 1.3)
                            rows[i][col] = str(random.randint(min(min_val, max_val), max(min_val, max_val)))
                    except:
                        pass
                randomized_count += 1
        
        self.save_csv(tamer_file, rows)
        self.progress.emit(f"✅ Randomized {randomized_count} tamer skills!")
        self.progress.emit("   Effect values: 70%-130% of original")
        
        # Track modified folder
        if randomized_count > 0:
            folder = self.data_path / "tamer_skill.mbe"
            if folder not in self.modified_folders:
                self.modified_folders.append(folder)
        
        return randomized_count


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
        """Restore all backups"""
        field_battle_folders = self.get_all_field_battle_folders()
        restored = 0
        
        for folder in field_battle_folders:
            csv_file = folder / "01_field_symbol_enemy.csv"
            backup_file = csv_file.with_suffix('.csv.backup')
            
            if backup_file.exists():
                rows = self.load_csv(backup_file)
                self.save_csv(csv_file, rows)
                self.progress.emit(f"✅ Restored: {folder.name}")
                restored += 1
        
        return restored


class FieldBattleRandomizerGUI(QMainWindow):
    """Main GUI window"""
    
    def __init__(self):
        super().__init__()
        self.data_path = Path("data")  # Default path
        self.randomizer_thread = None
        self.restore_thread = None
        self.modified_folders = []  # Track which folders were modified in last randomization
        self.setup_ui()
        self.check_data_folder()
    
    def setup_ui(self):
        self.setWindowTitle("Game Randomizer - DTS Creator")
        self.setGeometry(100, 100, 750, 850)
        
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
            "Comprehensive game randomizer with 13 randomization options!\n"
            "Mix and match to create your perfect chaotic playthrough."
        )
        info.setWordWrap(True)
        info.setStyleSheet("color: #666; padding: 10px;")
        main_layout.addWidget(info)
        
        # Data Path Selection
        path_group = QGroupBox("Data Folder")
        path_layout = QHBoxLayout(path_group)
        
        path_layout.addWidget(QLabel("Select folder:"))
        self.path_combo = QComboBox()
        self.path_combo.addItem("data/", "data")
        self.path_combo.addItem("backup/data/", "backup/data")
        self.path_combo.currentIndexChanged.connect(self.on_path_changed)
        path_layout.addWidget(self.path_combo)
        
        browse_btn = QPushButton("Browse...")
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
        
        self.randomize_encounters_checkbox = QCheckBox("🎲 Field Encounters")
        self.randomize_encounters_checkbox.setChecked(True)
        self.randomize_encounters_checkbox.setToolTip("Randomize wild encounter IDs")
        options_layout.addWidget(self.randomize_encounters_checkbox)
        
        # Encounter balance sub-option
        encounter_balance_layout = QHBoxLayout()
        encounter_balance_layout.addSpacing(30)
        self.balance_encounters_checkbox = QCheckBox("⚖️ Balance by Level (±10)")
        self.balance_encounters_checkbox.setChecked(True)
        self.balance_encounters_checkbox.setToolTip("Only use encounters with similar levels")
        encounter_balance_layout.addWidget(self.balance_encounters_checkbox)
        options_layout.addLayout(encounter_balance_layout)
        
        self.randomize_evolutions_checkbox = QCheckBox("🧬 Evolution Paths (all Digimon)")
        self.randomize_evolutions_checkbox.setChecked(False)
        self.randomize_evolutions_checkbox.setToolTip("Randomize evolution targets - adds 6 evolutions for Digimon with 0")
        options_layout.addWidget(self.randomize_evolutions_checkbox)
        
        self.randomize_deevolutions_checkbox = QCheckBox("🔙 De-evolution Paths (all Digimon)")
        self.randomize_deevolutions_checkbox.setChecked(False)
        self.randomize_deevolutions_checkbox.setToolTip("Randomize de-evolution targets - adds 6 de-evolutions for Digimon with 0")
        options_layout.addWidget(self.randomize_deevolutions_checkbox)
        
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
        
        self.randomize_learnsets_checkbox = QCheckBox("📚 Skill Learnsets")
        self.randomize_learnsets_checkbox.setChecked(False)
        self.randomize_learnsets_checkbox.setToolTip("Randomize which skills each Digimon learns")
        options_layout.addWidget(self.randomize_learnsets_checkbox)
        
        self.randomize_personalities_checkbox = QCheckBox("🎭 Personality Effects")
        self.randomize_personalities_checkbox.setChecked(False)
        self.randomize_personalities_checkbox.setToolTip("Randomize personality stat bonuses")
        options_layout.addWidget(self.randomize_personalities_checkbox)
        
        self.randomize_evo_reqs_checkbox = QCheckBox("⏱️ Evolution Requirements")
        self.randomize_evo_reqs_checkbox.setChecked(False)
        self.randomize_evo_reqs_checkbox.setToolTip("Randomize/remove evolution level requirements")
        options_layout.addWidget(self.randomize_evo_reqs_checkbox)
        
        # Evo reqs sub-option
        evo_reqs_layout = QHBoxLayout()
        evo_reqs_layout.addSpacing(30)
        self.remove_evo_reqs_checkbox = QCheckBox("🚫 Remove All Requirements")
        self.remove_evo_reqs_checkbox.setChecked(True)
        self.remove_evo_reqs_checkbox.setToolTip("Set all requirements to 1 (evolve anytime)")
        evo_reqs_layout.addWidget(self.remove_evo_reqs_checkbox)
        options_layout.addLayout(evo_reqs_layout)
        
        # ===== ITEMS & REWARDS =====
        items_label = QLabel("🎁 ITEMS & REWARDS")
        items_label.setFont(QFont("Arial", 10, QFont.Weight.Bold))
        items_label.setStyleSheet("color: #4CAF50; padding-top: 10px;")
        options_layout.addWidget(items_label)
        
        self.randomize_items_checkbox = QCheckBox("💊 Item Properties")
        self.randomize_items_checkbox.setChecked(False)
        self.randomize_items_checkbox.setToolTip("Randomize item effects and prices")
        options_layout.addWidget(self.randomize_items_checkbox)
        
        self.randomize_treasure_checkbox = QCheckBox("🎁 Treasure Chests")
        self.randomize_treasure_checkbox.setChecked(False)
        self.randomize_treasure_checkbox.setToolTip("Randomize items in chests and pickups")
        options_layout.addWidget(self.randomize_treasure_checkbox)
        
        self.randomize_shops_checkbox = QCheckBox("🛍️ Shop Inventory")
        self.randomize_shops_checkbox.setChecked(False)
        self.randomize_shops_checkbox.setToolTip("Randomize shop stock")
        options_layout.addWidget(self.randomize_shops_checkbox)
        
        self.randomize_growth_checkbox = QCheckBox("📊 Growth Rates")
        self.randomize_growth_checkbox.setChecked(False)
        self.randomize_growth_checkbox.setToolTip("Randomize stat gains per level")
        options_layout.addWidget(self.randomize_growth_checkbox)
        
        self.randomize_tamer_skills_checkbox = QCheckBox("🎯 Tamer Skills")
        self.randomize_tamer_skills_checkbox.setChecked(False)
        self.randomize_tamer_skills_checkbox.setToolTip("Randomize tamer skill effects")
        options_layout.addWidget(self.randomize_tamer_skills_checkbox)
        
        main_layout.addWidget(options_group)
        
        # Buttons
        button_layout = QVBoxLayout()
        
        # Row 1: Randomize and Restore
        row1_layout = QHBoxLayout()
        
        self.randomize_button = QPushButton("🎲 Randomize Encounters")
        self.randomize_button.setStyleSheet("background-color: #4CAF50; color: white; font-weight: bold; padding: 10px;")
        self.randomize_button.clicked.connect(self.randomize)
        row1_layout.addWidget(self.randomize_button)
        
        self.restore_button = QPushButton("🔄 Restore from Backups")
        self.restore_button.setStyleSheet("background-color: #2196F3; color: white; font-weight: bold; padding: 10px;")
        self.restore_button.clicked.connect(self.restore)
        row1_layout.addWidget(self.restore_button)
        
        button_layout.addLayout(row1_layout)
        
        # Row 2: Repack MBE
        self.repack_button = QPushButton("📦 Repack to MBE Files")
        self.repack_button.setStyleSheet("background-color: #FF9800; color: white; font-weight: bold; padding: 10px;")
        self.repack_button.clicked.connect(self.repack_mbe_files)
        button_layout.addWidget(self.repack_button)
        
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
        log_layout.addWidget(self.log_output)
        
        main_layout.addWidget(log_group)
    
    def on_path_changed(self):
        """Handle path selection change"""
        path_str = self.path_combo.currentData()
        self.data_path = Path(path_str)
        self.log_output.clear()
        self.check_data_folder()
    
    def browse_folder(self):
        """Browse for custom folder"""
        folder = QFileDialog.getExistingDirectory(
            self,
            "Select Data Folder",
            str(Path.cwd())
        )
        if folder:
            self.data_path = Path(folder)
            # Add to combo if not already there
            for i in range(self.path_combo.count()):
                if self.path_combo.itemData(i) == folder:
                    self.path_combo.setCurrentIndex(i)
                    return
            self.path_combo.addItem(folder, folder)
            self.path_combo.setCurrentIndex(self.path_combo.count() - 1)
    
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
            self.randomize_evolutions_checkbox.isChecked() or 
            self.randomize_deevolutions_checkbox.isChecked() or
            self.randomize_stats_checkbox.isChecked() or
            self.randomize_skills_checkbox.isChecked() or
            self.randomize_learnsets_checkbox.isChecked() or
            self.randomize_personalities_checkbox.isChecked() or
            self.randomize_evo_reqs_checkbox.isChecked() or
            self.randomize_treasure_checkbox.isChecked() or
            self.randomize_shops_checkbox.isChecked() or
            self.randomize_items_checkbox.isChecked() or
            self.randomize_growth_checkbox.isChecked() or
            self.randomize_tamer_skills_checkbox.isChecked()
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
            self.randomize_encounters_checkbox.isChecked(),
            self.balance_encounters_checkbox.isChecked(),
            self.randomize_evolutions_checkbox.isChecked(),
            self.randomize_deevolutions_checkbox.isChecked(),
            self.randomize_stats_checkbox.isChecked(),
            self.balance_stats_checkbox.isChecked(),
            self.randomize_skills_checkbox.isChecked(),
            self.randomize_learnsets_checkbox.isChecked(),
            self.randomize_personalities_checkbox.isChecked(),
            self.randomize_evo_reqs_checkbox.isChecked(),
            self.remove_evo_reqs_checkbox.isChecked(),
            self.randomize_treasure_checkbox.isChecked(),
            self.randomize_shops_checkbox.isChecked(),
            self.randomize_items_checkbox.isChecked(),
            self.randomize_growth_checkbox.isChecked(),
            self.randomize_tamer_skills_checkbox.isChecked()
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
        self.log(f"🎉 COMPLETE! Randomized {total_randomized} encounters across {total_files} files")
        
        QMessageBox.information(
            self,
            "Success",
            f"✅ Randomization complete!\n\n"
            f"Randomized {total_randomized} encounters across {total_files} files.\n\n"
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
    
    def repack_mbe_files(self):
        """Repack field_battle and evolution CSV folders to .mbe files"""
        # Check if DSCSToolsCLI.exe exists
        cli_tool = Path("DSCSToolsCLI.exe")
        if not cli_tool.exists():
            QMessageBox.warning(
                self,
                "Tool Not Found",
                "DSCSToolsCLI.exe not found in the workspace root!\n\n"
                "This tool is required to pack .mbe files."
            )
            return
        
        # Check if we have modified folders before prompting
        if not self.modified_folders:
            QMessageBox.warning(
                self,
                "Nothing to Repack",
                "⚠️ No modified files to repack!\n\n"
                "Please run randomization first before repacking."
            )
            return
        
        # Build list of folders that will be repacked
        folders_to_show = [f.name for f in self.modified_folders if f.exists()]
        folder_list = "\n".join([f"• {name}" for name in sorted(folders_to_show)])
        
        # Confirm action
        reply = QMessageBox.question(
            self,
            "Repack to MBE Files",
            f"This will pack {len(folders_to_show)} modified .mbe folder(s):\n\n"
            f"{folder_list}\n\n"
            "into .mbe files in the 'MBE' folder.\n\n"
            "Continue?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.No:
            return
        
        self.log("\n" + "="*50)
        self.log("Starting MBE repacking...")
        
        # Collect folders to pack (only those modified)
        folders_to_pack = [folder for folder in self.modified_folders if folder.exists()]
        
        if not folders_to_pack:
            QMessageBox.warning(self, "Error", f"No .mbe folders found to pack in {self.data_path}!")
            return
        
        # Create output directory
        output_dir = Path("MBE")
        output_dir.mkdir(exist_ok=True)
        
        self.log(f"Source: {self.data_path.absolute()}")
        self.log(f"Found {len(folders_to_pack)} folders to pack:")
        for folder in sorted(folders_to_pack):
            self.log(f"  • {folder.name}")
        self.log(f"Output directory: {output_dir.absolute()}")
        self.log("")
        
        # Pack each folder
        packed = 0
        failed = 0
        
        for folder in sorted(folders_to_pack):
            mbe_name = folder.name
            target_mbe = output_dir / mbe_name
            
            try:
                self.log(f"Packing: {mbe_name}...")
                
                # Use forward slashes for DSCSToolsCLI (Unix-style paths work on Windows)
                # Convert to absolute paths first, then make relative to cwd
                abs_folder = folder.absolute()
                abs_target = target_mbe.absolute()
                
                try:
                    source_path = str(abs_folder.relative_to(Path.cwd().absolute())).replace('\\', '/')
                    target_path = str(abs_target.relative_to(Path.cwd().absolute())).replace('\\', '/')
                except ValueError:
                    # If relative_to fails, use the path as-is
                    source_path = str(folder).replace('\\', '/')
                    target_path = str(target_mbe).replace('\\', '/')
                
                self.log(f"  Source: {source_path}")
                self.log(f"  Target: {target_path}")
                
                # Run DSCSToolsCLI with Unix-style paths
                # On Windows, use DSCSToolsCLI.exe directly (not ./DSCSToolsCLI.exe)
                result = subprocess.run(
                    ['DSCSToolsCLI.exe', '--mbepack', source_path, target_path],
                    capture_output=True,
                    text=True,
                    timeout=30
                )
                
                if result.returncode == 0:
                    self.log(f"  ✓ SUCCESS")
                    packed += 1
                else:
                    self.log(f"  ✗ FAILED")
                    if result.stdout:
                        self.log(f"  Output: {result.stdout}")
                    if result.stderr:
                        self.log(f"  Error: {result.stderr}")
                    failed += 1
            except Exception as e:
                self.log(f"  ✗ ERROR: {e}")
                failed += 1
        
        self.log("="*50)
        self.log(f"Complete! Packed {packed} files, {failed} failed")
        self.log(f"Output: {output_dir.absolute()}")
        
        QMessageBox.information(
            self,
            "Repack Complete",
            f"✅ Repacking complete!\n\n"
            f"Packed: {packed} files\n"
            f"Failed: {failed} files\n\n"
            f"Output folder: {output_dir.absolute()}\n\n"
            f"Copy the .mbe files from the MBE folder to your game's data directory."
        )


def main():
    app = QApplication(sys.argv)
    app.setApplicationName("Field Battle Randomizer")
    
    window = FieldBattleRandomizerGUI()
    window.show()
    
    sys.exit(app.exec())


if __name__ == "__main__":
    main()

