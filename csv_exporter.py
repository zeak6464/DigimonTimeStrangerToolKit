"""
CSV Exporter for DTS Creator - handles exporting modified Digimon data back to CSV files
"""

import csv
import os
import subprocess
from pathlib import Path
from typing import List, Dict, Any
from data_loader import DigimonData, MBELoader


class CSVExporter:
    """Handles exporting Digimon data back to CSV files"""
    
    def __init__(self, data_path: str = "data", text_path: str = "text"):
        self.data_path = Path(data_path)
        self.text_path = Path(text_path)
        self.loader = MBELoader(data_path, text_path)
        
    def export_digimon_to_csv(self, digimon: DigimonData, output_dir: Path) -> bool:
        """Export a single Digimon to all 9 required CSV files"""
        try:
            # Create output directory structure
            output_data_dir = output_dir / "data"
            output_text_dir = output_dir / "text"
            
            print(f"Exporting complete Digimon data for {digimon.name} ({digimon.chr_id})")
            
            # Export all 9 required files
            # 1. digimon_status.mbe
            self._export_digimon_status(digimon, output_data_dir)
            
            # 2. char_info.mbe  
            self._export_char_info(digimon, output_data_dir)
            
            # 3. text/char_name.mbe
            self._export_char_name(digimon, output_text_dir)
            
            # 4. model_setting.mbe
            self._export_model_setting(digimon, output_data_dir)
            
            # 5 & 6. model_locator.mbe (both files)
            self._export_model_locator(digimon, output_data_dir)
            
            # 7 & 8. lod_chara.mbe (both files)
            self._export_lod_data(digimon, output_data_dir)
            
            # 9. field_anime.mbe (only 00_field_move_animation.csv)
            self._export_field_anime(digimon, output_data_dir)
            
            # Export extended character data
            self._export_extended_character_data(digimon, output_data_dir)
            
            print(f"Successfully exported all 9 core files + extended data for {digimon.name}")
            return True
            
        except Exception as e:
            print(f"Error exporting Digimon {digimon.chr_id}: {e}")
            return False
    
    def _export_digimon_status(self, digimon: DigimonData, output_dir: Path):
        """Export digimon status data to CSV"""
        status_dir = output_dir / "digimon_status.mbe"
        status_dir.mkdir(parents=True, exist_ok=True)
        
        # Load existing data to get header and preserve other entries
        original_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        output_file = status_dir / "00_digimon_status_data.csv"
        
        if original_file.exists():
            # Read original data
            original_rows = self.loader.load_csv(original_file)
            
            # Find and replace/add our digimon's row
            found = False
            for i, row in enumerate(original_rows[1:], 1):  # Skip header
                if len(row) > 3 and row[3] == digimon.chr_id:
                    # Replace existing row
                    original_rows[i] = self._create_digimon_status_row(digimon)
                    found = True
                    break
            
            if not found:
                # Add new row
                original_rows.append(self._create_digimon_status_row(digimon))
            
            # Write updated data preserving original format
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                for row in original_rows:
                    # Write row manually to preserve exact format
                    f.write(','.join(row) + '\n')
        else:
            # Create new file with header and our data
            header = self._get_digimon_status_header()
            data_row = self._create_digimon_status_row(digimon)
            
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                f.write(','.join(header) + '\n')
                f.write(','.join(data_row) + '\n')
    
    def _create_digimon_status_row(self, digimon: DigimonData) -> List[str]:
        """Create a digimon status CSV row matching original format exactly"""
        # Create a row with 136 columns (based on header analysis)
        row = [""] * 136
        
        # Basic data - match original format exactly
        row[0] = str(digimon.id)
        row[1] = '""'  # empty column with quotes
        row[2] = f'"{digimon.char_key}"'
        row[3] = f'"{digimon.chr_id}"'
        row[4] = str(digimon.stage_id)
        row[5] = str(digimon.personality_id)  # This should be 1 for chr805
        row[6] = str(digimon.type_id)
        
        # Elemental resistances
        row[7] = str(digimon.res_null)
        row[8] = str(digimon.res_fire)
        row[9] = str(digimon.res_water)
        row[10] = str(digimon.res_ice)
        row[11] = str(digimon.res_grass)
        row[12] = str(digimon.res_wind)
        row[13] = str(digimon.res_elec)
        row[14] = str(digimon.res_ground)
        row[15] = str(digimon.res_steel)
        row[16] = str(digimon.res_light)
        row[17] = str(digimon.res_dark)
        row[18] = '""'  # empty column with quotes
        
        # Traits (boolean flags starting at index 19)
        for i, trait in enumerate(digimon.traits):
            if 19 + i < len(row):
                row[19 + i] = "1" if trait else "0"
        
        # Base personality and stats
        row[61] = str(digimon.base_personality)
        row[64] = str(digimon.base_hp)
        row[65] = str(digimon.base_sp)
        row[66] = str(digimon.base_atk)
        row[67] = str(digimon.base_def)
        row[68] = str(digimon.base_int)
        row[69] = str(digimon.base_spi)
        row[70] = str(digimon.base_spd)
        
        # Signature skills with proper empty field handling
        skill_indices = [
            (72, 74), (75, 77), (78, 80), (81, 83), (84, 86), (87, 89),
            (90, 92), (93, 95), (96, 98), (99, 101), (102, 104), (105, 107)
        ]
        
        for i, skill in enumerate(digimon.signature_skills):
            if i < len(skill_indices):
                id_idx, slot_idx = skill_indices[i]
                row[id_idx] = str(skill["id"])
                row[slot_idx] = str(skill["slot"])
                # Add empty fields between skills
                if id_idx + 1 < len(row):
                    row[id_idx + 1] = '""'
                if slot_idx + 1 < len(row):
                    row[slot_idx + 1] = '""'
        
        # Generic skills with proper empty field handling
        generic_indices = [(108, 110), (111, 113), (114, 116), (117, 119)]
        
        for i, skill in enumerate(digimon.generic_skills):
            if i < len(generic_indices):
                id_idx, level_idx = generic_indices[i]
                row[id_idx] = str(skill["id"])
                row[level_idx] = str(skill["level"])
                # Add empty fields between skills
                if id_idx + 1 < len(row):
                    row[id_idx + 1] = '""'
                if level_idx + 1 < len(row):
                    row[level_idx + 1] = '""'
        
        # References - preserve original format
        row[131] = str(digimon.field_guide_id) if digimon.field_guide_id != -1 else ""
        row[132] = str(digimon.script_id) if digimon.script_id != -1 else ""
        
        # Fill remaining fields to match original structure exactly
        for i in range(133, len(row)):
            if row[i] == "":
                if i == 133:  # Field 133 should be -1
                    row[i] = "-1"
                elif i == 135:  # Field 135 should be -1
                    row[i] = "-1"
                else:
                    row[i] = "0"
        
        return row
    
    def _get_digimon_status_header(self) -> List[str]:
        """Get the header row for digimon status CSV"""
        # This is a simplified header - in practice, you'd want the full header from the original file
        header = ["id", "empty", "char_key", "chr_id", "stage_id", "empty", "type_id"]
        # Add more header columns as needed...
        return header + [""] * (136 - len(header))  # Pad to 136 columns
    
    def _export_char_info(self, digimon: DigimonData, output_dir: Path):
        """Export character info to CSV"""
        char_dir = output_dir / "char_info.mbe"
        char_dir.mkdir(parents=True, exist_ok=True)
        
        original_file = self.data_path / "char_info.mbe" / "00_char_info.csv"
        output_file = char_dir / "00_char_info.csv"
        
        if original_file.exists():
            # Read and update existing data
            original_rows = self.loader.load_csv(original_file)
            
            # Find and replace/add our digimon's row
            found = False
            for i, row in enumerate(original_rows[1:], 1):  # Skip header
                if len(row) > 0 and row[0] == digimon.char_key:
                    # Replace existing row
                    original_rows[i] = self._create_char_info_row(digimon)
                    found = True
                    break
            
            if not found:
                # Add new row
                original_rows.append(self._create_char_info_row(digimon))
            
            # Write updated data
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerows(original_rows)
    
    def _create_char_info_row(self, digimon: DigimonData) -> List[str]:
        """Create a character info CSV row"""
        return [
            digimon.char_key,
            "",  # empty
            "",  # empty
            digimon.chr_id,
            str(1000 + digimon.id),  # Some ID mapping
            "",  # empty
            "0",  # gender flag
            "0",  # some flag
            "",  # motion/animation reference
            "0",  # flag
            "",  # model reference
            "0",  # flag
            "",  # empty
            "0"   # flag
        ]
    
    def _export_char_name(self, digimon: DigimonData, output_dir: Path):
        """Export character name to CSV"""
        name_dir = output_dir / "char_name.mbe"
        name_dir.mkdir(parents=True, exist_ok=True)
        
        original_file = self.text_path / "char_name.mbe" / "00_Sheet1.csv"
        output_file = name_dir / "00_Sheet1.csv"
        
        if original_file.exists():
            # Read and update existing data
            original_rows = self.loader.load_csv(original_file)
            
            # Find and replace/add our digimon's row
            found = False
            for i, row in enumerate(original_rows[1:], 1):  # Skip header
                if len(row) > 0 and row[0] == digimon.char_key:
                    # Replace existing row
                    original_rows[i] = [digimon.char_key, digimon.name]
                    found = True
                    break
            
            if not found:
                # Add new row
                original_rows.append([digimon.char_key, digimon.name])
            
            # Write updated data
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerows(original_rows)
    
    def _export_model_setting(self, digimon: DigimonData, output_dir: Path):
        """Export model setting data to CSV"""
        model_dir = output_dir / "model_setting.mbe"
        model_dir.mkdir(parents=True, exist_ok=True)
        
        original_file = self.data_path / "model_setting.mbe" / "00_model_setting.csv"
        output_file = model_dir / "00_model_setting.csv"
        
        if original_file.exists():
            # Read and update existing data
            original_rows = self.loader.load_csv(original_file)
            
            # Find and replace/add our digimon's row
            found = False
            for i, row in enumerate(original_rows[1:], 1):  # Skip header
                if len(row) > 0 and row[0] == digimon.chr_id:
                    # Use stored data if available, otherwise preserve original
                    if digimon.model_setting_data and "raw_data" in digimon.model_setting_data:
                        original_rows[i] = digimon.model_setting_data["raw_data"]
                    found = True
                    break
            
            if not found and digimon.model_setting_data and "raw_data" in digimon.model_setting_data:
                # Add new row
                original_rows.append(digimon.model_setting_data["raw_data"])
            
            # Write updated data
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerows(original_rows)
    
    def _export_lod_data(self, digimon: DigimonData, output_dir: Path):
        """Export LOD data to CSV"""
        if not digimon.lod_data:
            return
            
        lod_dir = output_dir / "lod_chara.mbe"
        lod_dir.mkdir(parents=True, exist_ok=True)
        
        # Create LOD row
        lod_row = [
            digimon.chr_id,
            str(digimon.lod_data.get("lod_distance_1", 20)),
            str(digimon.lod_data.get("lod_distance_2", 65)),
            str(digimon.lod_data.get("lod_distance_3", 500))
        ] + ["0"] * 7  # Pad with zeros
        
        output_file = lod_dir / "00_lod.csv"
        with open(output_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(lod_row)
    
    def _export_model_locator(self, digimon: DigimonData, output_dir: Path):
        """Export model locator data to CSV"""
        locator_dir = output_dir / "model_locator.mbe"
        locator_dir.mkdir(parents=True, exist_ok=True)
        
        # Export 00_model_locator.csv
        if digimon.model_locator_data:
            original_file = self.data_path / "model_locator.mbe" / "00_model_locator.csv"
            output_file = locator_dir / "00_model_locator.csv"
            
            if original_file.exists():
                original_rows = self.loader.load_csv(original_file)
                
                # Find and update row
                found = False
                for i, row in enumerate(original_rows[1:], 1):
                    if len(row) > 0 and row[0] == digimon.chr_id:
                        original_rows[i] = [
                            digimon.model_locator_data["chr_id"],
                            digimon.model_locator_data["locator_ref"]
                        ]
                        found = True
                        break
                
                if not found:
                    original_rows.append([
                        digimon.model_locator_data["chr_id"],
                        digimon.model_locator_data["locator_ref"]
                    ])
                
                with open(output_file, 'w', newline='', encoding='utf-8') as f:
                    writer = csv.writer(f)
                    writer.writerows(original_rows)
        
        # Export 01_model_locator_motion.csv
        if digimon.model_locator_motion_data:
            original_file = self.data_path / "model_locator.mbe" / "01_model_locator_motion.csv"
            output_file = locator_dir / "01_model_locator_motion.csv"
            
            if original_file.exists():
                original_rows = self.loader.load_csv(original_file)
                
                # Remove existing entries for this chr_id
                chr_prefix = f"{digimon.chr_id}_"
                original_rows = [row for row in original_rows if not (len(row) > 0 and row[0].startswith(chr_prefix))]
                
                # Add new entries
                for motion_data in digimon.model_locator_motion_data:
                    original_rows.append([
                        motion_data["motion_key"],
                        motion_data["motion_name"]
                    ])
                
                with open(output_file, 'w', newline='', encoding='utf-8') as f:
                    writer = csv.writer(f)
                    writer.writerows(original_rows)
    
    
    def _export_field_anime(self, digimon: DigimonData, output_dir: Path):
        """Export field animation data to CSV"""
        anime_dir = output_dir / "field_anime.mbe"
        anime_dir.mkdir(parents=True, exist_ok=True)
        
        # Export 00_field_move_animation.csv only
        if digimon.field_move_animation_data:
            original_file = self.data_path / "field_anime.mbe" / "00_field_move_animation.csv"
            output_file = anime_dir / "00_field_move_animation.csv"
            
            if original_file.exists():
                original_rows = self.loader.load_csv(original_file)
                
                # Remove existing entries for this chr_id
                chr_prefix = digimon.chr_id
                filtered_rows = [original_rows[0]]  # Keep header
                for row in original_rows[1:]:
                    if not (len(row) > 0 and chr_prefix in row[0]):
                        filtered_rows.append(row)
                
                # Add new entries
                for anim_data in digimon.field_move_animation_data:
                    filtered_rows.append(anim_data["raw_data"])
                
                with open(output_file, 'w', newline='', encoding='utf-8') as f:
                    writer = csv.writer(f)
                    writer.writerows(filtered_rows)
    
    def _export_extended_character_data(self, digimon: DigimonData, output_dir: Path):
        """Export all extended character data"""
        self._export_evolution_data(digimon, output_dir)
        self._export_battle_enemy_data(digimon, output_dir)
        self._export_battle_formation_data(digimon, output_dir)
        self._export_encounter_groups(digimon, output_dir)
        # Note: Quest references, flags, and NPC placements are typically managed
        # by the game's quest system and may not need direct editing
    
    def _export_evolution_data(self, digimon: DigimonData, output_dir: Path):
        """Export evolution data to CSV"""
        if not digimon.evolution_paths and not digimon.evolution_conditions:
            return
        
        # Export evolution paths
        if digimon.evolution_paths:
            evo_to_dir = output_dir / "evolution.mbe"
            evo_to_dir.mkdir(parents=True, exist_ok=True)
            
            original_file = self.data_path / "evolution.mbe" / "01_evolution_to.csv"
            output_file = evo_to_dir / "01_evolution_to.csv"
            
            if original_file.exists():
                original_rows = self.loader.load_csv(original_file)
                
                # Remove existing entries for this Digimon
                filtered_rows = [original_rows[0]]  # Keep header
                for row in original_rows[1:]:
                    if not (len(row) > 1 and row[1] == str(digimon.id)):
                        filtered_rows.append(row)
                
                # Add new entries
                for evo_path in digimon.evolution_paths:
                    filtered_rows.append(evo_path["raw_data"])
                
                with open(output_file, 'w', newline='', encoding='utf-8') as f:
                    writer = csv.writer(f)
                    writer.writerows(filtered_rows)
        
        # Export evolution conditions
        if digimon.evolution_conditions:
            original_file = self.data_path / "evolution.mbe" / "00_evolution_condition.csv"
            output_file = evo_to_dir / "00_evolution_condition.csv"
            
            if original_file.exists():
                original_rows = self.loader.load_csv(original_file)
                
                # Remove existing entries for this Digimon's evolution IDs
                evo_ids = [str(cond["evolution_id"]) for cond in digimon.evolution_conditions]
                filtered_rows = [original_rows[0]]  # Keep header
                for row in original_rows[1:]:
                    if not (len(row) > 0 and row[0] in evo_ids):
                        filtered_rows.append(row)
                
                # Add new entries
                for cond in digimon.evolution_conditions:
                    filtered_rows.append(cond["raw_data"])
                
                with open(output_file, 'w', newline='', encoding='utf-8') as f:
                    writer = csv.writer(f)
                    writer.writerows(filtered_rows)
    
    def _export_battle_enemy_data(self, digimon: DigimonData, output_dir: Path):
        """Export battle enemy data to CSV"""
        if not digimon.battle_enemy_data:
            return
        
        enemy_dir = output_dir / "battle_enemy.mbe"
        enemy_dir.mkdir(parents=True, exist_ok=True)
        
        original_file = self.data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
        output_file = enemy_dir / "00_enemy_parameter.csv"
        
        if original_file.exists():
            original_rows = self.loader.load_csv(original_file)
            
            # Find and update row
            found = False
            for i, row in enumerate(original_rows[1:], 1):
                if len(row) > 2 and row[2] == str(digimon.id):
                    original_rows[i] = digimon.battle_enemy_data["raw_data"]
                    found = True
                    break
            
            if not found:
                original_rows.append(digimon.battle_enemy_data["raw_data"])
            
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerows(original_rows)
    
    def _export_battle_formation_data(self, digimon: DigimonData, output_dir: Path):
        """Export battle formation data to CSV"""
        if not digimon.battle_formation_data:
            return
        
        formation_dir = output_dir / "battle_formation.mbe"
        formation_dir.mkdir(parents=True, exist_ok=True)
        
        original_file = self.data_path / "battle_formation.mbe" / "00_battle_formation.csv"
        output_file = formation_dir / "00_battle_formation.csv"
        
        if original_file.exists():
            original_rows = self.loader.load_csv(original_file)
            
            # Find and update row
            found = False
            for i, row in enumerate(original_rows[1:], 1):
                if len(row) > 0 and str(row[0]) == str(digimon.id):
                    original_rows[i] = digimon.battle_formation_data["raw_data"]
                    found = True
                    break
            
            if not found:
                original_rows.append(digimon.battle_formation_data["raw_data"])
            
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerows(original_rows)
    
    def _export_encounter_groups(self, digimon: DigimonData, output_dir: Path):
        """Export encounter group data to CSV"""
        if not digimon.encounter_groups:
            return
        
        encounter_dir = output_dir / "battle_enemy.mbe"
        encounter_dir.mkdir(parents=True, exist_ok=True)
        
        original_file = self.data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        output_file = encounter_dir / "01_encount_group.csv"
        
        if original_file.exists():
            original_rows = self.loader.load_csv(original_file)
            
            # Remove existing entries for this Digimon
            filtered_rows = [original_rows[0]]  # Keep header
            for row in original_rows[1:]:
                # Check if this row contains references to this Digimon
                should_keep = True
                for encounter in digimon.encounter_groups:
                    if len(row) > 0 and row[0] == encounter['group_id']:
                        should_keep = False
                        break
                if should_keep:
                    filtered_rows.append(row)
            
            # Add new entries
            for encounter in digimon.encounter_groups:
                filtered_rows.append(encounter["raw_data"])
            
            with open(output_file, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerows(filtered_rows)
    
    def export_all_modified_data(self, digimon_list: List[DigimonData], output_dir: Path) -> bool:
        """Export all modified Digimon data to a directory structure"""
        try:
            output_dir.mkdir(parents=True, exist_ok=True)
            
            for digimon in digimon_list:
                self.export_digimon_to_csv(digimon, output_dir)
            
            return True
            
        except Exception as e:
            print(f"Error exporting all data: {e}")
            return False
    
    def export_all_csv_files(self, output_dir: Path) -> bool:
        """Export all CSV files from data and text directories, preserving structure, including DLC"""
        import shutil
        try:
            output_dir.mkdir(parents=True, exist_ok=True)
            
            # Copy all .mbe directories from data folder
            data_source = self.data_path
            data_dest = output_dir / "data"
            
            if data_source.exists():
                if data_dest.exists():
                    shutil.rmtree(data_dest)
                shutil.copytree(data_source, data_dest)
                print(f"Copied all data CSV files to {data_dest}")
            
            # Copy all .mbe directories from text folder
            text_source = self.text_path
            text_dest = output_dir / "text"
            
            if text_source.exists():
                if text_dest.exists():
                    shutil.rmtree(text_dest)
                shutil.copytree(text_source, text_dest)
                print(f"Copied all text CSV files to {text_dest}")
            
            # Copy DLC directories
            workspace_root = self.data_path.parent
            dlc_source_dir = workspace_root / "DLC"
            
            if dlc_source_dir.exists():
                dlc_dest_dir = output_dir / "DLC"
                if dlc_dest_dir.exists():
                    shutil.rmtree(dlc_dest_dir)
                shutil.copytree(dlc_source_dir, dlc_dest_dir)
                print(f"Copied all DLC CSV files to {dlc_dest_dir}")
            
            return True
            
        except Exception as e:
            print(f"Error exporting all CSV files: {e}")
            import traceback
            traceback.print_exc()
            return False


if __name__ == "__main__":
    # Test the exporter with chr805
    from data_loader import MBELoader
    
    loader = MBELoader()
    digimon = loader.get_digimon_by_chr_id("chr805")
    
    if digimon:
        exporter = CSVExporter()
        output_path = Path("exported_data")
        
        if exporter.export_digimon_to_csv(digimon, output_path):
            print(f"Successfully exported {digimon.name} to {output_path}")
        else:
            print("Export failed")
    else:
        print("Could not load chr805 for testing")


def repack_mbe_files(source_dir: Path, target_dir: Path) -> bool:
    """Repack CSV folders to .mbe files using DSCSToolsCLI"""
    try:
        # Ensure target directory exists
        target_dir.mkdir(parents=True, exist_ok=True)
        
        # Find all .mbe folders in source directory
        mbe_folders = [f for f in source_dir.iterdir() if f.is_dir() and f.suffix == '.mbe']
        
        if not mbe_folders:
            print(f"No .mbe folders found in {source_dir}")
            return False
        
        success_count = 0
        for mbe_folder in mbe_folders:
            # Create target .mbe file path
            target_mbe_file = target_dir / mbe_folder.name
            
            # Use Unix-style paths with forward slashes for DSCSToolsCLI
            source_path = str(mbe_folder.relative_to(Path.cwd())).replace('\\', '/')
            target_path = str(target_mbe_file.relative_to(Path.cwd())).replace('\\', '/')
            
            # Run DSCSToolsCLI --mbepack command with Unix-style paths
            # On Windows, use DSCSToolsCLI.exe directly (not ./DSCSToolsCLI.exe)
            cmd = [
                "DSCSToolsCLI.exe",
                "--mbepack",
                source_path,
                target_path
            ]
            
            print(f"Repacking {mbe_folder.name}...")
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode == 0:
                print(f"Successfully repacked {mbe_folder.name}")
                success_count += 1
            else:
                print(f"Error repacking {mbe_folder.name}: {result.stderr}")
        
        print(f"Successfully repacked {success_count}/{len(mbe_folders)} .mbe files")
        return success_count > 0
        
    except Exception as e:
        print(f"Error during MBE repacking: {e}")
        return False


def repack_dlc_mbe_files(dlc_name: str = "addcont_17") -> bool:
    """
    Repack DLC CSV folders into .mbe files using DSCSToolsCLI
    
    Args:
        dlc_name: Name of the DLC (default: addcont_17)
    
    Returns:
        bool: True if repacking was successful
    """
    try:
        # Get DLC paths
        # Source: CSV folders in DLC/addcont_17.dx11/data/mbe/ and DLC/addcont_17_text01.dx11/text/mbe/
        # Target: .mbe files in export/DLC/addcont_17.dx11/data/ and export/DLC/addcont_17_text01.dx11/text/
        try:
            from data_loader import MBELoader
            temp_loader = MBELoader()
            workspace_root = temp_loader.data_path.parent
        except:
            workspace_root = Path.cwd()
        
        # Source paths - CSV folders in DLC/
        dlc_data_source_dir = workspace_root / "DLC" / f"{dlc_name}.dx11" / "data" / "mbe"
        dlc_text_source_dir = workspace_root / "DLC" / f"{dlc_name}_text01.dx11" / "text" / "mbe"
        
        # Target paths - .mbe files in export/DLC/
        dlc_data_target_dir = workspace_root / "export" / "DLC" / f"{dlc_name}.dx11" / "data"
        dlc_text_target_dir = workspace_root / "export" / "DLC" / f"{dlc_name}_text01.dx11" / "text"
        
        if not dlc_data_source_dir.exists():
            print(f"DLC data source directory not found: {dlc_data_source_dir}")
            return False
        
        # Find all DLC .mbe folders (folders ending with _dlc17.mbe containing CSV files)
        mbe_folders = []
        
        # Data folders - from DLC/
        if dlc_data_source_dir.exists():
            for folder in dlc_data_source_dir.iterdir():
                if folder.is_dir() and folder.name.endswith("_dlc17.mbe"):
                    mbe_folders.append((folder, dlc_data_target_dir))
        
        # Text folders - from DLC/
        if dlc_text_source_dir.exists():
            for folder in dlc_text_source_dir.iterdir():
                if folder.is_dir() and folder.name.endswith("_dlc17.mbe"):
                    mbe_folders.append((folder, dlc_text_target_dir))
        
        if not mbe_folders:
            print("No DLC .mbe folders found to repack")
            return False
        
        print(f"\n=== Repacking {len(mbe_folders)} DLC .mbe folders ===")
        print(f"Source: DLC/{dlc_name}.dx11/...")
        print(f"Target: export/DLC/{dlc_name}.dx11/...")
        success_count = 0
        
        for mbe_folder, target_dir in mbe_folders:
            # Check if folder contains CSV files
            csv_files = list(mbe_folder.glob("*.csv"))
            if not csv_files:
                print(f"⚠️ Warning: {mbe_folder.name} contains no CSV files, skipping...")
                continue
            
            print(f"  Found {len(csv_files)} CSV file(s) in folder")
            
            # Verify source folder exists
            if not mbe_folder.exists() or not mbe_folder.is_dir():
                print(f"⚠️ Warning: Source folder does not exist: {mbe_folder}")
                continue
            
            # Create target .mbe file path in export/DLC/
            # Ensure target directory exists
            target_dir.mkdir(parents=True, exist_ok=True)
            target_mbe_file = target_dir / mbe_folder.name
            
            # Convert to absolute paths first
            abs_source = mbe_folder.absolute()
            abs_target = target_mbe_file.absolute()
            
            # Check if target already exists - if it's a file, we'll overwrite it; if it's a directory, skip
            if abs_target.exists():
                if abs_target.is_dir():
                    print(f"  ⚠️ Warning: Target path is a directory (conflict with folder name): {abs_target.name}")
                    print(f"     This means there's both a folder and file with the same name - skipping...")
                    continue
                elif abs_target.is_file():
                    # Existing .mbe file - we'll overwrite it
                    print(f"  Found existing .mbe file, will overwrite: {abs_target.name}")
            
            # Remove existing .mbe file if it exists (DSCSToolsCLI will create it)
            if abs_target.exists():
                try:
                    abs_target.unlink()
                except Exception as e:
                    print(f"  Warning: Could not remove existing file: {e}")
            
            # Use Windows-style paths with backslashes for DSCSToolsCLI on Windows
            # DSCSToolsCLI on Windows expects native Windows paths, quoted
            # Do NOT add trailing backslash - DSCSToolsCLI doesn't need it
            source_path = str(abs_source)
            target_path = str(abs_target)
            
            # Quote paths to handle spaces and special characters
            source_path_quoted = f'"{source_path}"'
            target_path_quoted = f'"{target_path}"'
            
            # Debug: Print what paths we're using
            print(f"  Source path: {source_path}")
            print(f"  Target path: {target_path}")
            print(f"  Source exists: {abs_source.exists()}")
            print(f"  Target dir exists: {abs_target.parent.exists()}")
            
            # Check if DSCSToolsCLI.exe exists
            dscstools_path = Path.cwd() / "DSCSToolsCLI.exe"
            if not dscstools_path.exists():
                print(f"❌ Error: DSCSToolsCLI.exe not found in {Path.cwd()}")
                print(f"   Please ensure DSCSToolsCLI.exe is in the workspace root directory.")
                return False
            
            # Run DSCSToolsCLI --mbepack command with quoted Windows paths
            cmd = [
                str(dscstools_path),
                "--mbepack",
                source_path_quoted,
                target_path_quoted
            ]
            
            print(f"\nRepacking {mbe_folder.name}...")
            print(f"  Source folder: {abs_source}")
            print(f"  Target file: {abs_target}")
            print(f"  Command: {' '.join(cmd)}")
            
            result = subprocess.run(cmd, capture_output=True, text=True, cwd=Path.cwd())
            
            if result.returncode == 0:
                # Wait a moment for file system to sync
                import time
                time.sleep(0.2)
                
                # Check if target file was created
                if abs_target.exists() and abs_target.is_file():
                    file_size = abs_target.stat().st_size
                    if file_size > 0:
                        print(f"✅ Successfully repacked {mbe_folder.name} ({file_size:,} bytes)")
                        success_count += 1
                    else:
                        print(f"⚠️ Warning: File created but is empty (0 bytes)")
                        print(f"  DSCSToolsCLI may have failed silently.")
                        print(f"  Try running manually: {' '.join(cmd)}")
                        if result.stdout:
                            print(f"  Output: {result.stdout}")
                        if result.stderr:
                            print(f"  Error: {result.stderr}")
                else:
                    print(f"⚠️ Warning: Repack reported success but target file not found!")
                    print(f"  Expected: {abs_target}")
                    if result.stdout:
                        print(f"  Output: {result.stdout}")
                    if result.stderr:
                        print(f"  Error: {result.stderr}")
            else:
                print(f"❌ Error repacking {mbe_folder.name} (exit code: {result.returncode})")
                if result.stdout:
                    print(f"  Output: {result.stdout}")
                if result.stderr:
                    print(f"  Error: {result.stderr}")
        
        print(f"\n✅ Successfully repacked {success_count}/{len(mbe_folders)} DLC .mbe files")
        return success_count > 0
        
    except Exception as e:
        print(f"Error during DLC MBE repacking: {e}")
        import traceback
        traceback.print_exc()
        return False
