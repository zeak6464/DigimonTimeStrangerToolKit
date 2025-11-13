"""
Data loader for DTS Creator - loads and parses .mbe directories and CSV files
"""

import os
import csv
import json
import re
from typing import Dict, List, Optional, Any
from dataclasses import dataclass, field
from pathlib import Path
import shutil


@dataclass
class DigimonData:
    """Represents a complete Digimon entry with all associated data"""
    # Core identification
    id: int = 0
    char_key: str = ""
    chr_id: str = ""
    name: str = ""
    
    # Basic stats
    stage_id: int = 0
    type_id: int = 0
    generation_id: int = 0
    personality_id: int = 0
    base_personality: int = 0
    base_hp: int = 0
    base_sp: int = 0
    base_atk: int = 0
    base_def: int = 0
    base_int: int = 0
    base_spi: int = 0
    base_spd: int = 0
    
    # Elemental resistances
    res_null: int = 0
    res_fire: int = 0
    res_water: int = 0
    res_ice: int = 0
    res_grass: int = 0
    res_wind: int = 0
    res_elec: int = 0
    res_ground: int = 0
    res_steel: int = 0
    res_light: int = 0
    res_dark: int = 0
    
    # Signature skills (up to 12)
    signature_skills: List[Dict[str, int]] = field(default_factory=list)
    
    # Generic skills (up to 4)
    generic_skills: List[Dict[str, int]] = field(default_factory=list)
    
    # Traits (boolean flags)
    traits: List[bool] = field(default_factory=list)
    
    # Model and animation data
    model_id: str = ""
    motion_id: str = ""
    lod_data: Dict[str, Any] = field(default_factory=dict)
    
    # Field guide and script references
    field_guide_id: int = -1
    script_id: int = -1
    
    # Complete file data for all 9 required files
    char_info_data: Dict[str, Any] = field(default_factory=dict)
    model_setting_data: Dict[str, Any] = field(default_factory=dict)
    model_locator_data: Dict[str, Any] = field(default_factory=dict)
    model_locator_motion_data: List[Dict[str, str]] = field(default_factory=list)
    lod_model_data: Dict[str, Any] = field(default_factory=dict)
    field_move_animation_data: List[Dict[str, Any]] = field(default_factory=list)
    
    # Extended character data - Evolution & Battle Systems
    evolution_paths: List[Dict[str, Any]] = field(default_factory=list)  # Evolution targets
    evolution_conditions: List[Dict[str, Any]] = field(default_factory=list)  # Evolution requirements
    deevolution_sources: List[Dict[str, Any]] = field(default_factory=list)  # What can evolve into this
    battle_enemy_data: Dict[str, Any] = field(default_factory=dict)  # Battle enemy parameters
    growth_curves: List[Dict[str, Any]] = field(default_factory=list)  # Level-based growth data
    
    
    # Battle & Formation Data
    battle_formation_data: Dict[str, Any] = field(default_factory=dict)  # Battle formations
    encounter_groups: List[Dict[str, Any]] = field(default_factory=list)  # Enemy encounter data
    
    # Character Profile & Personality
    personality_data: Dict[str, Any] = field(default_factory=dict)  # Personality system data
    profile_text: str = ""  # Character description/profile
    can_mount: bool = False  # Mountable Digimon flag
    is_boss_variant: bool = False  # Boss enemy variant


class MBELoader:
    """Loads and parses .mbe directories containing CSV files"""
    
    def __init__(self, data_path: str = "data", text_path: str = "text"):
        self.data_path = Path(data_path)
        self.text_path = Path(text_path)
        self.headers = self._load_headers()
        
        # CSV data cache to avoid repeated file reads
        self._digimon_status_cache = None
        self._digimon_status_cache_file = None
        
        # Text data caches for enhanced integration
        self._skill_names_cache = None
        self._element_names_cache = None
        self._type_names_cache = None
        self._location_names_cache = None
        self._battle_messages_cache = None
        self._char_names_cache = None
        self._trait_names_cache = None
        self._jogress_skill_names_cache = None
        self._skill_explanations_cache = None
        self._skill_auto_explanations_cache = None
        self._generation_names_cache = None
        self._personality_names_cache = None
        self._item_names_cache = None
        self._belong_names_cache = None
        self._digimon_profiles_cache = None
        self._buff_names_cache = None
        self._status_names_cache = None
        
    def _load_headers(self) -> Dict[str, Dict[str, int]]:
        """Load predefined headers from the Time Stranger Data File Headers"""
        return {
            "main/digimon_status.mbe/00_digimon_status_data.csv": {
                "id": 0,
                "strKey": 2,
                # Signature skills
                "signatureSkillId1": 72, "signatureSkillSlot1": 74,
                "signatureSkillId2": 75, "signatureSkillSlot2": 77,
                "signatureSkillId3": 78, "signatureSkillSlot3": 80,
                "signatureSkillId4": 81, "signatureSkillSlot4": 83,
                "signatureSkillId5": 84, "signatureSkillSlot5": 86,
                "signatureSkillId6": 87, "signatureSkillSlot6": 89,
                "signatureSkillId7": 90, "signatureSkillSlot7": 92,
                "signatureSkillId8": 93, "signatureSkillSlot8": 95,
                "signatureSkillId9": 96, "signatureSkillSlot9": 98,
                "signatureSkillId10": 99, "signatureSkillSlot10": 101,
                "signatureSkillId11": 102, "signatureSkillSlot11": 104,
                "signatureSkillId12": 105, "signatureSkillSlot12": 107,
                # Generic skills
                "gSkill1Id": 108, "gSkill1Level": 110,
                "gSkill2Id": 111, "gSkill2Level": 113,
                "gSkill3Id": 114, "gSkill3Level": 116,
                "gSkill4Id": 117, "gSkill4Level": 119,
                # Base stats
                "stageId": 4, "typeId": 6,
                "basePersonality": 61,
                "baseHP": 64, "baseSP": 65, "baseATK": 66,
                "baseDEF": 67, "baseINT": 68, "baseSPI": 69, "baseSPD": 70,
                # Traits
                "traitsBaseIdx": 19,  # next 41 are trait bool flags
                # Elemental resistance
                "resNull": 7, "resFire": 8, "resWater": 9, "resIce": 10,
                "resGrass": 11, "resWind": 12, "resElec": 13, "resGround": 14,
                "resSteel": 15, "resLight": 16, "resDark": 17,
                "fieldGuideId": 131, "scriptId": 132
            },
            "main/evolution.mbe/01_evolution_to.csv": {
                "idx": 0,
                "idFrom": 1,
                "idTo": 3
            },
            "main/evolution.mbe/00_evolution_condition.csv": {
                "dbId": 0,
                "tamerLevel": 2,
                "HP": 4, "SP": 5, "ATK": 6, "DEF": 7, "INT": 8, "SPI": 9, "SPD": 10,
                "unknown1": 11,
                "skillCountValor": 13, "skillCountPhilantropy": 14,
                "skillCountAmicable": 15, "skillCountWisdom": 16,
                "needsItem": 22,
                "jogressDbIdA": 24, "jogressPersonalityA": 26,
                "jogressDbIdB": 27, "jogressPersonalityB": 29
            },
            "main/battle_skill.mbe/00_battle_skill_list.csv": {
                "skillId": 0, "nameId": 4, "skillFixedDescId": 5,
                "bool_7": 7, "bool_8": 8, "effectId": 16, "unk_0": 21,
                "dmgType": 22, "power": 23, "additionalProperty_1": 26,
                "additionalProperty": 27, "element": 28, "increasedDmgAgainstClass": 29,
                "unusued_0": 30, "unusued_1": 31, "menu_icon": 32,
                "targetType": 33, "minHits": 34, "maxHits": 35, "SPCost": 36,
                "unk_1": 37, "unk_2": 38, "alwaysHits": 39, "accuracy": 40,
                "unk_3": 41, "critRate": 42, "HPDrain": 43, "SPDrain": 44,
                "recoil": 45, "skillConditionalType": 46, "skillEffectIfConditional": 47,
                "empty_0": 48, "skillConditionalArg": 49, "skillEffectArg": 50,
                "empty_1": 51, "buffSet_0": 52, "buffSet_1": 54, "buffSet_2": 56,
                "buffSet_3": 58, "buffSet_4": 60, "jogressIdA": 64, "jogressIdB": 66
            },
            "main/battle_skill.mbe/02_buff_set.csv": {
                "setId": 0, "unk0": 1, "unk1": 2, "unk2": 3,
                "buff0_eff": 6, "buff0_rate": 7, "buff0_changePercent": 8, "buff0_turnOverride": 9,
                "buff1_eff": 11, "buff1_rate": 12, "buff1_changePercent": 13, "buff1_turnOverride": 14,
                "buff2_eff": 16, "buff2_rate": 17, "buff2_changePercent": 18, "buff2_turnOverride": 19,
                "buff3_eff": 21, "buff3_rate": 22, "buff3_changePercent": 23, "buff3_turnOverride": 24,
                "buff4_eff": 26, "buff4_rate": 27, "buff4_changePercent": 28, "buff4_turnOverride": 29,
                "buff5_eff": 31, "buff5_rate": 32, "buff5_changePercent": 33, "buff5_turnOverride": 34,
                "buff6_eff": 36, "buff6_rate": 37, "buff6_changePercent": 38, "buff6_turnOverride": 39,
                "buff7_eff": 41, "buff7_rate": 42, "buff7_changePercent": 43, "buff7_turnOverride": 44,
                "buff8_eff": 46, "buff8_rate": 47, "buff8_changePercent": 48, "buff8_turnOverride": 49,
                "buff9_eff": 51, "buff9_rate": 52, "buff9_changePercent": 53, "buff9_turnOverride": 54,
                "buff10_eff": 56, "buff10_rate": 57, "buff10_changePercent": 58, "buff10_turnOverride": 59
            }
        }
    
    def load_csv(self, file_path: Path) -> List[List[str]]:
        """Load CSV file and return rows preserving original format"""
        # Check if this is the digimon status file and use cache
        if file_path.name == "00_digimon_status_data.csv" and "digimon_status.mbe" in str(file_path):
            return self._get_digimon_status_data()
        
        try:
            # Use Python's csv module for proper multi-line quoted field handling
            # csv.reader automatically handles multi-line quoted fields correctly
            with open(file_path, 'r', encoding='utf-8') as f:
                reader = csv.reader(f)
                rows = []
                for row in reader:
                    # csv.reader returns a list of strings (quotes are stripped)
                    rows.append(row)
                return rows
        except Exception as e:
            print(f"Error loading CSV {file_path}: {e}")
            return []
    
    def _get_digimon_status_data(self) -> List[List[str]]:
        """Get digimon status data with caching"""
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        
        # Check if cache is valid
        if (self._digimon_status_cache is not None and 
            self._digimon_status_cache_file == status_file and 
            status_file.exists()):
            return self._digimon_status_cache
        
        # Load and cache the data
        try:
            with open(status_file, 'r', encoding='utf-8') as f:
                lines = f.readlines()
                rows = []
                for line in lines:
                    # Split by comma but preserve quotes
                    row = []
                    current_field = ""
                    in_quotes = False
                    i = 0
                    while i < len(line.strip()):
                        char = line[i]
                        if char == '"':
                            in_quotes = not in_quotes
                            current_field += char
                        elif char == ',' and not in_quotes:
                            row.append(current_field)
                            current_field = ""
                        else:
                            current_field += char
                        i += 1
                    if current_field:
                        row.append(current_field)
                    rows.append(row)
                
                # Cache the data
                self._digimon_status_cache = rows
                self._digimon_status_cache_file = status_file
                return rows
        except Exception as e:
            print(f"Error loading digimon status CSV {status_file}: {e}")
            return []
    
    def _invalidate_digimon_status_cache(self):
        """Invalidate the digimon status cache (call after saving)"""
        self._digimon_status_cache = None
        self._digimon_status_cache_file = None
    
    def load_mbe_directory(self, mbe_path: Path) -> Dict[str, List[List[str]]]:
        """Load all CSV files in an .mbe directory"""
        data = {}
        if not mbe_path.exists():
            return data
            
        for csv_file in mbe_path.glob("*.csv"):
            data[csv_file.name] = self.load_csv(csv_file)
        
        return data
    
    def get_digimon_by_chr_id(self, chr_id: str) -> Optional[DigimonData]:
        """Load a specific Digimon by its chr_id (e.g., 'chr805')"""
        # Try loading from base game first
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        status_rows = None
        
        if status_file.exists():
            status_rows = self.load_csv(status_file)
            if len(status_rows) >= 2:  # Need header + at least one data row
                # Find the row with matching chr_id
                for row in status_rows[1:]:  # Skip header
                    if len(row) > 3 and (row[3] == chr_id or row[3] == f'"{chr_id}"'):
                        digimon_row = row
                        break
                else:
                    digimon_row = None
            else:
                digimon_row = None
        else:
            digimon_row = None
        
        # If not found in base game, try DLC
        if not digimon_row:
            dlc_exporter = DLCExporter(self)
            dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
            dlc_status_file = dlc_data / "digimon_status_dlc17.mbe" / "00_digimon_status_data.csv"
            
            if dlc_status_file.exists():
                status_rows = self.load_csv(dlc_status_file)
                if len(status_rows) >= 2:
                    for row in status_rows[1:]:  # Skip header
                        if len(row) > 3 and (row[3] == chr_id or row[3] == f'"{chr_id}"'):
                            digimon_row = row
                            break
        
        if not digimon_row:
            return None
            
        # Parse the row using headers
        headers = self.headers["main/digimon_status.mbe/00_digimon_status_data.csv"]
        digimon = DigimonData()
        
        # Basic data
        digimon.id = int(digimon_row[headers["id"]]) if digimon_row[headers["id"]] else 0
        digimon.char_key = digimon_row[headers["strKey"]].strip('"') if len(digimon_row) > headers["strKey"] else ""
        digimon.chr_id = chr_id.strip('"') if chr_id else ""
        
        # Stats
        # Parse stage_id with better error handling
        try:
            if len(digimon_row) > headers["stageId"]:
                stage_val = str(digimon_row[headers["stageId"]]).strip()
                digimon.stage_id = int(stage_val) if stage_val and stage_val.isdigit() else 0
            else:
                digimon.stage_id = 0
            # Clamp stage_id to valid range (0-14, based on generation_name.mbe CSV)
            digimon.stage_id = max(0, min(14, digimon.stage_id))
        except (ValueError, IndexError, AttributeError, TypeError):
            digimon.stage_id = 0
        
        try:
            if len(digimon_row) > headers["typeId"]:
                type_val = str(digimon_row[headers["typeId"]]).strip()
                digimon.type_id = int(type_val) if type_val and type_val.isdigit() else 0
            else:
                digimon.type_id = 0
        except (ValueError, IndexError, AttributeError, TypeError):
            digimon.type_id = 0
        digimon.generation_id = digimon.stage_id  # Generation is the same as stage
        digimon.personality_id = int(digimon_row[headers["basePersonality"]]) if digimon_row[headers["basePersonality"]] else 0
        digimon.base_personality = digimon.personality_id  # basePersonality is the same as personality_id
        digimon.base_hp = int(digimon_row[headers["baseHP"]]) if digimon_row[headers["baseHP"]] else 0
        digimon.base_sp = int(digimon_row[headers["baseSP"]]) if digimon_row[headers["baseSP"]] else 0
        digimon.base_atk = int(digimon_row[headers["baseATK"]]) if digimon_row[headers["baseATK"]] else 0
        digimon.base_def = int(digimon_row[headers["baseDEF"]]) if digimon_row[headers["baseDEF"]] else 0
        digimon.base_int = int(digimon_row[headers["baseINT"]]) if digimon_row[headers["baseINT"]] else 0
        digimon.base_spi = int(digimon_row[headers["baseSPI"]]) if digimon_row[headers["baseSPI"]] else 0
        digimon.base_spd = int(digimon_row[headers["baseSPD"]]) if digimon_row[headers["baseSPD"]] else 0
        
        # Elemental resistances
        digimon.res_null = int(digimon_row[headers["resNull"]]) if digimon_row[headers["resNull"]] else 0
        digimon.res_fire = int(digimon_row[headers["resFire"]]) if digimon_row[headers["resFire"]] else 0
        digimon.res_water = int(digimon_row[headers["resWater"]]) if digimon_row[headers["resWater"]] else 0
        digimon.res_ice = int(digimon_row[headers["resIce"]]) if digimon_row[headers["resIce"]] else 0
        digimon.res_grass = int(digimon_row[headers["resGrass"]]) if digimon_row[headers["resGrass"]] else 0
        digimon.res_wind = int(digimon_row[headers["resWind"]]) if digimon_row[headers["resWind"]] else 0
        digimon.res_elec = int(digimon_row[headers["resElec"]]) if digimon_row[headers["resElec"]] else 0
        digimon.res_ground = int(digimon_row[headers["resGround"]]) if digimon_row[headers["resGround"]] else 0
        digimon.res_steel = int(digimon_row[headers["resSteel"]]) if digimon_row[headers["resSteel"]] else 0
        digimon.res_light = int(digimon_row[headers["resLight"]]) if digimon_row[headers["resLight"]] else 0
        digimon.res_dark = int(digimon_row[headers["resDark"]]) if digimon_row[headers["resDark"]] else 0
        
        # Signature skills
        for i in range(1, 13):  # 12 signature skills
            skill_id_key = f"signatureSkillId{i}"
            skill_slot_key = f"signatureSkillSlot{i}"
            if skill_id_key in headers and skill_slot_key in headers:
                skill_id = int(digimon_row[headers[skill_id_key]]) if digimon_row[headers[skill_id_key]] else 0
                skill_slot = int(digimon_row[headers[skill_slot_key]]) if digimon_row[headers[skill_slot_key]] else 0
                # Always add the skill, even if ID is 0 (preserves slot information)
                digimon.signature_skills.append({"id": skill_id, "slot": skill_slot})
        
        # Generic skills
        for i in range(1, 5):  # 4 generic skills
            skill_id_key = f"gSkill{i}Id"
            skill_level_key = f"gSkill{i}Level"
            if skill_id_key in headers and skill_level_key in headers:
                skill_id = int(digimon_row[headers[skill_id_key]]) if digimon_row[headers[skill_id_key]] else 0
                skill_level = int(digimon_row[headers[skill_level_key]]) if digimon_row[headers[skill_level_key]] else 0
                # Always add the skill, even if ID is 0 (preserves level information)
                digimon.generic_skills.append({"id": skill_id, "level": skill_level})
        
        # Traits (boolean flags starting from traitsBaseIdx)
        traits_start = headers["traitsBaseIdx"]
        for i in range(41):  # 41 trait flags
            if traits_start + i < len(digimon_row):
                trait_value = digimon_row[traits_start + i] == "1"
                digimon.traits.append(trait_value)
        
        # Field guide and script IDs
        digimon.field_guide_id = int(digimon_row[headers["fieldGuideId"]]) if digimon_row[headers["fieldGuideId"]] else -1
        digimon.script_id = int(digimon_row[headers["scriptId"]]) if digimon_row[headers["scriptId"]] else -1
        
        # Load name from text files
        digimon.name = self._get_digimon_name(digimon.char_key)
        
        # Load profile text
        digimon.profile_text = self.get_digimon_profile(digimon.id)
        
        # Load model data
        self._load_model_data(digimon)
        
        return digimon
    
    def _get_digimon_name(self, char_key: str, check_dlc: bool = True) -> str:
        """Get Digimon name from text files
        
        Args:
            char_key: Character key to look up
            check_dlc: If True, also check DLC files
        """
        # Normalize char_key (remove quotes for comparison)
        normalized_key = char_key.strip('"')
        
        # Check base game first
        name_file = self.text_path / "char_name.mbe" / "00_Sheet1.csv"
        if name_file.exists():
            name_rows = self.load_csv(name_file)
            for row in name_rows[1:]:  # Skip header
                if len(row) >= 2:
                    row_key = row[0].strip('"')
                    if row_key == normalized_key:
                        return row[1].strip('"')  # Also strip quotes from name
        
        # Check DLC if not found in base game
        if check_dlc:
            dlc_exporter = DLCExporter(self)
            dlc_text = dlc_exporter.get_dlc_text_path("addcont_17_text01") / "text" / "mbe"
            dlc_name_file = dlc_text / "char_name_dlc17.mbe" / "00_Sheet1.csv"
            
            if dlc_name_file.exists():
                dlc_name_rows = self.load_csv(dlc_name_file)
                for row in dlc_name_rows[1:]:  # Skip header
                    if len(row) >= 2:
                        row_key = row[0].strip('"')
                        if row_key == normalized_key:
                            return row[1].strip('"')  # Also strip quotes from name
        
        return normalized_key
    
    def _get_digimon_name_by_chr_id(self, chr_id: str, check_dlc: bool = True) -> str:
        """Get Digimon name by chr_id
        
        Args:
            chr_id: Character ID to look up
            check_dlc: If True, also check DLC files
        """
        char_key = None
        
        # First check base game
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        if status_file.exists():
            status_rows = self.load_csv(status_file)
            for row in status_rows[1:]:  # Skip header
                # Handle both quoted and unquoted chr_id
                if len(row) > 3 and (row[3] == chr_id or row[3] == f'"{chr_id}"'):
                    char_key = row[2] if len(row) > 2 else None
                    break
        
        # Check DLC if not found in base game
        if not char_key and check_dlc:
            dlc_exporter = DLCExporter(self)
            dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
            dlc_status_file = dlc_data / "digimon_status_dlc17.mbe" / "00_digimon_status_data.csv"
            
            if dlc_status_file.exists():
                dlc_status_rows = self.load_csv(dlc_status_file)
                for row in dlc_status_rows[1:]:  # Skip header
                    # Handle both quoted and unquoted chr_id
                    if len(row) > 3 and (row[3] == chr_id or row[3] == f'"{chr_id}"'):
                        char_key = row[2] if len(row) > 2 else None
                        break
        
        if not char_key:
            return chr_id
            
        # Now get the name using the char_key (which will also check DLC)
        return self._get_digimon_name(char_key, check_dlc=check_dlc)
    
    def _load_model_data(self, digimon: DigimonData):
        """Load model and animation data for the Digimon"""
        # Load all 9 required files for complete Digimon data
        
        # 1. char_info.mbe
        self._load_char_info_data(digimon)
        
        # 2. model_setting.mbe
        self._load_model_setting_data(digimon)
        
        # 3. model_locator.mbe (both files)
        self._load_model_locator_data(digimon)
        
        # 4. lod_chara.mbe (both files)
        self._load_lod_data(digimon)
        
        # 5. field_anime.mbe (only 00_field_move_animation.csv)
        self._load_field_anime_data(digimon)
        
        # Load extended character data
        self._load_extended_character_data(digimon)
    
    def _load_char_info_data(self, digimon: DigimonData):
        """Load character info data - checks both base game and DLC"""
        # Check base game first
        char_file = self.data_path / "char_info.mbe" / "00_char_info.csv"
        if char_file.exists():
            char_rows = self.load_csv(char_file)
            for row in char_rows[1:]:  # Skip header
                if len(row) > 0 and row[0] == digimon.char_key:
                    digimon.char_info_data = {
                        "char_key": row[0] if len(row) > 0 else "",
                        "empty1": row[1] if len(row) > 1 else "",
                        "empty2": row[2] if len(row) > 2 else "",
                        "chr_id": row[3] if len(row) > 3 else "",
                        "numeric_id": row[4] if len(row) > 4 else "",
                        "empty3": row[5] if len(row) > 5 else "",
                        "gender_flag": int(row[6]) if len(row) > 6 and row[6] else 0,
                        "flag1": int(row[7]) if len(row) > 7 and row[7] else 0,
                        "motion_ref": row[8] if len(row) > 8 else "",
                        "flag2": int(row[9]) if len(row) > 9 and row[9] else 0,
                        "model_ref": row[10] if len(row) > 10 else "",
                        "flag3": int(row[11]) if len(row) > 11 and row[11] else 0,
                        "empty4": row[12] if len(row) > 12 else "",
                        "flag4": int(row[13]) if len(row) > 13 and row[13] else 0
                    }
                    return
        
        # Check DLC files if not found in base game
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        dlc_char_file = dlc_data / "char_info_dlc17.mbe" / "00_char_info.csv"
        if dlc_char_file.exists():
            char_rows = self.load_csv(dlc_char_file)
            for row in char_rows[1:]:  # Skip header
                if len(row) > 0 and row[0].strip('"') == digimon.char_key:
                    digimon.char_info_data = {
                        "char_key": row[0].strip('"') if len(row) > 0 else "",
                        "empty1": row[1].strip('"') if len(row) > 1 else "",
                        "empty2": row[2].strip('"') if len(row) > 2 else "",
                        "chr_id": row[3].strip('"') if len(row) > 3 else "",
                        "numeric_id": row[4].strip('"') if len(row) > 4 else "",
                        "empty3": row[5].strip('"') if len(row) > 5 else "",
                        "gender_flag": int(row[6]) if len(row) > 6 and row[6] else 0,
                        "flag1": int(row[7]) if len(row) > 7 and row[7] else 0,
                        "motion_ref": row[8].strip('"') if len(row) > 8 else "",
                        "flag2": int(row[9]) if len(row) > 9 and row[9] else 0,
                        "model_ref": row[10].strip('"') if len(row) > 10 else "",
                        "flag3": int(row[11]) if len(row) > 11 and row[11] else 0,
                        "empty4": row[12].strip('"') if len(row) > 12 else "",
                        "flag4": int(row[13]) if len(row) > 13 and row[13] else 0
                    }
                    break
    
    def _load_model_setting_data(self, digimon: DigimonData):
        """Load model setting data - checks both base game and DLC"""
        # Check base game first
        model_file = self.data_path / "model_setting.mbe" / "00_model_setting.csv"
        if model_file.exists():
            model_rows = self.load_csv(model_file)
            for row in model_rows[1:]:  # Skip header
                if len(row) > 0 and (row[0].strip('"') == digimon.chr_id.strip('"')):
                    digimon.model_id = row[0]
                    # Store full model setting data
                    digimon.model_setting_data = {
                        "chr_id": row[0] if len(row) > 0 else "",
                        "raw_data": row  # Store full row for export
                    }
                    return
        
        # Check DLC files if not found in base game
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        dlc_model_file = dlc_data / "model_setting_dlc17.mbe" / "00_model_setting.csv"
        if dlc_model_file.exists():
            model_rows = self.load_csv(dlc_model_file)
            for row in model_rows[1:]:  # Skip header
                if len(row) > 0 and (row[0].strip('"') == digimon.chr_id.strip('"')):
                    digimon.model_id = row[0]
                    digimon.model_setting_data = {
                        "chr_id": row[0] if len(row) > 0 else "",
                        "raw_data": row
                    }
                    break
    
    def _load_model_locator_data(self, digimon: DigimonData):
        """Load model locator data - checks both base game and DLC"""
        chr_id_clean = digimon.chr_id.strip('"')
        
        # Check base game first
        locator_file = self.data_path / "model_locator.mbe" / "00_model_locator.csv"
        if locator_file.exists():
            locator_rows = self.load_csv(locator_file)
            for row in locator_rows[1:]:  # Skip header
                if len(row) > 0 and (row[0].strip('"') == chr_id_clean):
                    digimon.model_locator_data = {
                        "chr_id": row[0],
                        "locator_ref": row[1] if len(row) > 1 else ""
                    }
                    break
        
        # Check DLC files if not found in base game
        if not digimon.model_locator_data:
            dlc_exporter = DLCExporter(self)
            dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
            dlc_locator_file = dlc_data / "model_locator_dlc17.mbe" / "00_model_locator.csv"
            if dlc_locator_file.exists():
                locator_rows = self.load_csv(dlc_locator_file)
                for row in locator_rows[1:]:  # Skip header
                    if len(row) > 0 and (row[0].strip('"') == chr_id_clean):
                        digimon.model_locator_data = {
                            "chr_id": row[0],
                            "locator_ref": row[1] if len(row) > 1 else ""
                        }
                        break
        
        # Load 01_model_locator_motion.csv - check base game first
        motion_file = self.data_path / "model_locator.mbe" / "01_model_locator_motion.csv"
        if motion_file.exists():
            motion_rows = self.load_csv(motion_file)
            digimon.model_locator_motion_data = []
            chr_prefix = f"{chr_id_clean}_"
            
            for row in motion_rows[1:]:  # Skip header
                if len(row) > 0:
                    row_0_stripped = row[0].strip('"')
                    if row_0_stripped.startswith(chr_prefix):
                        digimon.model_locator_motion_data.append({
                            "motion_key": row[0],
                            "motion_name": row[1] if len(row) > 1 else ""
                        })
        
        # Check DLC files for motion data if not found or to append
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        dlc_motion_file = dlc_data / "model_locator_dlc17.mbe" / "01_model_locator_motion.csv"
        if dlc_motion_file.exists():
            motion_rows = self.load_csv(dlc_motion_file)
            chr_prefix = f"{chr_id_clean}_"
            
            for row in motion_rows[1:]:  # Skip header
                if len(row) > 0:
                    row_0_stripped = row[0].strip('"')
                    if row_0_stripped.startswith(chr_prefix):
                        # Check if already added from base game
                        motion_key = row[0]
                        if not any(m.get('motion_key') == motion_key for m in digimon.model_locator_motion_data):
                            digimon.model_locator_motion_data.append({
                                "motion_key": row[0],
                                "motion_name": row[1] if len(row) > 1 else ""
                            })
    
    def _load_lod_data(self, digimon: DigimonData):
        """Load LOD (Level of Detail) data - checks both base game and DLC"""
        chr_id_clean = digimon.chr_id.strip('"')
        
        # Load 00_lod.csv - check base game first
        lod_file = self.data_path / "lod_chara.mbe" / "00_lod.csv"
        if lod_file.exists():
            lod_rows = self.load_csv(lod_file)
            for row in lod_rows[1:]:  # Skip header
                if len(row) > 0 and (row[0].strip('"') == chr_id_clean):
                    digimon.lod_data = {
                        "chr_id": row[0],
                        "lod_distance_1": float(row[1]) if len(row) > 1 and row[1] else 0,
                        "lod_distance_2": float(row[2]) if len(row) > 2 and row[2] else 0,
                        "lod_distance_3": float(row[3]) if len(row) > 3 and row[3] else 0
                    }
                    break
        
        # Check DLC files if not found in base game
        if not digimon.lod_data:
            dlc_exporter = DLCExporter(self)
            dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
            dlc_lod_file = dlc_data / "lod_chara_dlc17.mbe" / "00_lod.csv"
            if dlc_lod_file.exists():
                lod_rows = self.load_csv(dlc_lod_file)
                for row in lod_rows[1:]:  # Skip header
                    if len(row) > 0 and (row[0].strip('"') == chr_id_clean):
                        digimon.lod_data = {
                            "chr_id": row[0],
                            "lod_distance_1": float(row[1]) if len(row) > 1 and row[1] else 0,
                            "lod_distance_2": float(row[2]) if len(row) > 2 and row[2] else 0,
                            "lod_distance_3": float(row[3]) if len(row) > 3 and row[3] else 0
                        }
                        break
        
        # Load 01_lod_model.csv - check base game first
        lod_model_file = self.data_path / "lod_chara.mbe" / "01_lod_model.csv"
        if lod_model_file.exists():
            lod_model_rows = self.load_csv(lod_model_file)
            for row in lod_model_rows[1:]:  # Skip header
                if len(row) > 0 and (row[0].strip('"') == chr_id_clean):
                    digimon.lod_model_data = {
                        "chr_id": row[0],
                        "lod_model_ref": row[2] if len(row) > 2 else "",
                        "raw_data": row  # Store full row
                    }
                    break
        
        # Check DLC files if not found in base game
        if not digimon.lod_model_data:
            dlc_exporter = DLCExporter(self)
            dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
            dlc_lod_model_file = dlc_data / "lod_chara_dlc17.mbe" / "01_lod_model.csv"
            if dlc_lod_model_file.exists():
                lod_model_rows = self.load_csv(dlc_lod_model_file)
                for row in lod_model_rows[1:]:  # Skip header
                    if len(row) > 0 and (row[0].strip('"') == chr_id_clean):
                        digimon.lod_model_data = {
                            "chr_id": row[0],
                            "lod_model_ref": row[2] if len(row) > 2 else "",
                            "raw_data": row
                        }
                        break
    
    
    def _load_field_anime_data(self, digimon: DigimonData):
        """Load field animation data - checks both base game and DLC"""
        chr_id_clean = digimon.chr_id.strip('"')
        
        # Check base game first
        move_file = self.data_path / "field_anime.mbe" / "00_field_move_animation.csv"
        if move_file.exists():
            move_rows = self.load_csv(move_file)
            digimon.field_move_animation_data = []
            
            for row in move_rows[1:]:  # Skip header
                if len(row) > 0:
                    row_0_stripped = row[0].strip('"')
                    if chr_id_clean in row_0_stripped:
                        digimon.field_move_animation_data.append({
                            "animation_key": row[0],
                            "motion1": row[1] if len(row) > 1 else "",
                            "motion2": row[2] if len(row) > 2 else "",
                            "motion3": row[3] if len(row) > 3 else "",
                            "raw_data": row
                        })
        
        # Check DLC files and append any additional entries
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        dlc_move_file = dlc_data / "field_anime_dlc17.mbe" / "00_field_move_animation.csv"
        if dlc_move_file.exists():
            move_rows = self.load_csv(dlc_move_file)
            
            for row in move_rows[1:]:  # Skip header
                if len(row) > 0:
                    row_0_stripped = row[0].strip('"')
                    if chr_id_clean in row_0_stripped:
                        # Check if already added from base game
                        anim_key = row[0]
                        if not any(a.get('animation_key') == anim_key for a in digimon.field_move_animation_data):
                            digimon.field_move_animation_data.append({
                                "animation_key": row[0],
                                "motion1": row[1] if len(row) > 1 else "",
                                "motion2": row[2] if len(row) > 2 else "",
                                "motion3": row[3] if len(row) > 3 else "",
                                "raw_data": row
                            })
    
    def _load_extended_character_data(self, digimon: DigimonData):
        """Load all extended character data (evolution, battle, quest, etc.)"""
        self._load_evolution_data(digimon)
        self._load_battle_enemy_data(digimon)
        self._load_growth_data(digimon)
        self._load_battle_formation_data(digimon)
        self._load_encounter_groups(digimon)
        self._load_personality_data(digimon)
    
    def _load_evolution_data(self, digimon: DigimonData):
        """Load evolution paths and conditions"""
        # Check both base game and DLC files
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        
        # Load evolution targets (what this Digimon can evolve into)
        # Check base game first
        evolution_to_file = self.data_path / "evolution.mbe" / "01_evolution_to.csv"
        if evolution_to_file.exists():
            rows = self.load_csv(evolution_to_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 1 and row[1] == str(digimon.id):
                    digimon.evolution_paths.append({
                        "evolution_id": int(row[0]) if row[0] else 0,
                        "from_id": int(row[1]) if row[1] else 0,
                        "to_id": int(row[3]) if len(row) > 3 and row[3] else 0,
                        "condition_flags": row[5:] if len(row) > 5 else [],
                        "raw_data": row
                    })
        
        # Check DLC files
        dlc_evolution_to_file = dlc_data / "evolution_dlc17.mbe" / "01_evolution_to.csv"
        if dlc_evolution_to_file.exists():
            rows = self.load_csv(dlc_evolution_to_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 1 and row[1] == str(digimon.id):
                    digimon.evolution_paths.append({
                        "evolution_id": int(row[0]) if row[0] else 0,
                        "from_id": int(row[1]) if row[1] else 0,
                        "to_id": int(row[3]) if len(row) > 3 and row[3] else 0,
                        "condition_flags": row[5:] if len(row) > 5 else [],
                        "raw_data": row
                    })
        
        # Load evolution conditions
        # Check base game first
        evolution_cond_file = self.data_path / "evolution.mbe" / "00_evolution_condition.csv"
        if evolution_cond_file.exists():
            rows = self.load_csv(evolution_cond_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 0:
                    # Find conditions that apply to this Digimon's evolution paths
                    for evo_path in digimon.evolution_paths:
                        if str(evo_path["evolution_id"]) == row[0]:
                            digimon.evolution_conditions.append({
                                "evolution_id": int(row[0]) if row[0] else 0,
                                "level_req": int(row[2]) if len(row) > 2 and row[2] else 0,
                                "hp_req": int(row[4]) if len(row) > 4 and row[4] else 0,
                                "conditions": row,
                                "raw_data": row
                            })
        
        # Check DLC files
        dlc_evolution_cond_file = dlc_data / "evolution_dlc17.mbe" / "00_evolution_condition.csv"
        if dlc_evolution_cond_file.exists():
            rows = self.load_csv(dlc_evolution_cond_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 0:
                    # Find conditions that apply to this Digimon's evolution paths
                    for evo_path in digimon.evolution_paths:
                        if str(evo_path["evolution_id"]) == row[0]:
                            digimon.evolution_conditions.append({
                                "evolution_id": int(row[0]) if row[0] else 0,
                                "level_req": int(row[2]) if len(row) > 2 and row[2] else 0,
                                "hp_req": int(row[4]) if len(row) > 4 and row[4] else 0,
                                "conditions": row,
                                "raw_data": row
                            })
        
        # Load de-evolution sources (what can evolve into this Digimon)
        # Check base game first
        if evolution_to_file.exists():
            rows = self.load_csv(evolution_to_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 3 and row[3] == str(digimon.id):
                    digimon.deevolution_sources.append({
                        "evolution_id": int(row[0]) if row[0] else 0,
                        "from_id": int(row[1]) if row[1] else 0,
                        "to_id": int(row[3]) if row[3] else 0,
                        "raw_data": row
                    })
        
        # Check DLC files
        if dlc_evolution_to_file.exists():
            rows = self.load_csv(dlc_evolution_to_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 3 and row[3] == str(digimon.id):
                    digimon.deevolution_sources.append({
                        "evolution_id": int(row[0]) if row[0] else 0,
                        "from_id": int(row[1]) if row[1] else 0,
                        "to_id": int(row[3]) if row[3] else 0,
                        "raw_data": row
                    })
    
    def _load_battle_enemy_data(self, digimon: DigimonData):
        """Load battle enemy parameter data"""
        # Check both base game and DLC files
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        
        # Check base game first
        enemy_file = self.data_path / "battle_enemy.mbe" / "00_enemy_parameter.csv"
        if enemy_file.exists():
            rows = self.load_csv(enemy_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 2 and row[2] == str(digimon.id):
                    digimon.battle_enemy_data = {
                        "enemy_id": int(row[0]) if row[0] else 0,
                        "base_id": int(row[2]) if row[2] else 0,
                        "level": int(row[10]) if len(row) > 10 and row[10] else 0,
                        "hp": int(row[17]) if len(row) > 17 and row[17] else 0,
                        "sp": int(row[18]) if len(row) > 18 and row[18] else 0,
                        "attack": int(row[19]) if len(row) > 19 and row[19] else 0,
                        "defense": int(row[20]) if len(row) > 20 and row[20] else 0,
                        "intelligence": int(row[21]) if len(row) > 21 and row[21] else 0,
                        "spirit": int(row[22]) if len(row) > 22 and row[22] else 0,
                        "speed": int(row[23]) if len(row) > 23 and row[23] else 0,
                        "raw_data": row
                    }
                    break
        
        # Check DLC files if not found in base game
        if not digimon.battle_enemy_data:
            dlc_enemy_file = dlc_data / "battle_enemy_dlc17.mbe" / "00_enemy_parameter.csv"
            if dlc_enemy_file.exists():
                rows = self.load_csv(dlc_enemy_file)
                for row in rows[1:]:  # Skip header
                    if len(row) > 2 and row[2] == str(digimon.id):
                        digimon.battle_enemy_data = {
                            "enemy_id": int(row[0]) if row[0] else 0,
                            "base_id": int(row[2]) if row[2] else 0,
                            "level": int(row[10]) if len(row) > 10 and row[10] else 0,
                            "hp": int(row[17]) if len(row) > 17 and row[17] else 0,
                            "sp": int(row[18]) if len(row) > 18 and row[18] else 0,
                            "attack": int(row[19]) if len(row) > 19 and row[19] else 0,
                            "defense": int(row[20]) if len(row) > 20 and row[20] else 0,
                            "intelligence": int(row[21]) if len(row) > 21 and row[21] else 0,
                            "spirit": int(row[22]) if len(row) > 22 and row[22] else 0,
                            "speed": int(row[23]) if len(row) > 23 and row[23] else 0,
                            "raw_data": row
                        }
                        break
    
    def _load_encounter_groups(self, digimon: DigimonData):
        """Load encounter groups that this Digimon appears in"""
        if not digimon.battle_enemy_data:
            return
        
        enemy_id = str(digimon.battle_enemy_data.get('enemy_id', 0))
        if not enemy_id or enemy_id == '0':
            return
        
        # Check both base game and DLC files
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        
        def process_encounter_rows(rows):
            """Process encounter group rows"""
            for row in rows[1:]:  # Skip header
                if len(row) > 2:
                    # Column 2 is the primary enemy ID
                    # The repeating enemy slot pattern starts at column 6 and repeats every 12 columns
                    # Pattern: rate(6), type(7), enemy_id(8), count(9), ... (14 cols total per slot)
                    # Strip quotes from CSV value before comparing
                    row_enemy_id = row[2].strip('"') if row[2] else ""
                    if row_enemy_id == enemy_id:
                        encounter_id = int(row[0]) if row[0] else 0
                        digimon.encounter_groups.append({
                            "encounter_id": encounter_id,
                            "slot": 0,  # Primary slot
                            "enemy_count": 1,
                            "raw_data": row
                        })
                    
                    # Check additional enemy slots (pattern repeats every 12 columns starting at 18)
                    # Slot positions: 18+8=26, 30+8=38, 42+8=50, 54+8=62, 66+8=74
                    additional_enemy_cols = [26, 38, 50, 62, 74]
                    for i, col in enumerate(additional_enemy_cols):
                        row_slot_enemy = row[col].strip('"') if col < len(row) and row[col] else ""
                        if row_slot_enemy == enemy_id:
                            encounter_id = int(row[0]) if row[0] else 0
                            count_val = row[col+1].strip('"') if col+1 < len(row) and row[col+1] else ""
                            count = int(count_val) if count_val and count_val != '""' else 1
                            digimon.encounter_groups.append({
                                "encounter_id": encounter_id,
                                "slot": i + 1,  # Slot 1-5 (0 is primary)
                                "enemy_count": count,
                                "raw_data": row
                            })
                            break
        
        # Check base game first
        encounter_file = self.data_path / "battle_enemy.mbe" / "01_encount_group.csv"
        if encounter_file.exists():
            rows = self.load_csv(encounter_file)
            process_encounter_rows(rows)
        
        # Check DLC files
        dlc_encounter_file = dlc_data / "battle_enemy_dlc17.mbe" / "01_encount_group.csv"
        if dlc_encounter_file.exists():
            rows = self.load_csv(dlc_encounter_file)
            process_encounter_rows(rows)
    
    def _load_growth_data(self, digimon: DigimonData):
        """Load growth curve data"""
        # Growth data is spread across multiple files (00_digimon_growth_1.csv to 17.csv)
        for i in range(1, 19):  # Files 1-18
            growth_file = self.data_path / "digimon_growth.mbe" / f"{i:02d}_digimon_growth_{i}.csv"
            if growth_file.exists():
                rows = self.load_csv(growth_file)
                for row in rows[1:]:  # Skip header
                    if len(row) > 0:
                        digimon.growth_curves.append({
                            "growth_type": i,
                            "level": int(row[0]) if row[0] else 0,
                            "hp_growth": int(row[1]) if len(row) > 1 and row[1] else 0,
                            "sp_growth": int(row[2]) if len(row) > 2 and row[2] else 0,
                            "attack_growth": int(row[3]) if len(row) > 3 and row[3] else 0,
                            "defense_growth": int(row[4]) if len(row) > 4 and row[4] else 0,
                            "intelligence_growth": int(row[5]) if len(row) > 5 and row[5] else 0,
                            "spirit_growth": int(row[6]) if len(row) > 6 and row[6] else 0,
                            "speed_growth": int(row[7]) if len(row) > 7 and row[7] else 0,
                            "raw_data": row
                        })
    
    
    def _load_battle_formation_data(self, digimon: DigimonData):
        """Load battle formation data"""
        # Check both base game and DLC files
        dlc_exporter = DLCExporter(self)
        dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
        
        # Check base game first
        formation_file = self.data_path / "battle_formation.mbe" / "00_battle_formation.csv"
        if formation_file.exists():
            rows = self.load_csv(formation_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 0 and str(row[0]) == str(digimon.id):
                    digimon.battle_formation_data = {
                        "formation_id": int(row[0]) if row[0] else 0,
                        "formation_type": row[2] if len(row) > 2 else "",
                        "raw_data": row
                    }
                    break
        
        # Check DLC files if not found in base game
        if not digimon.battle_formation_data:
            dlc_formation_file = dlc_data / "battle_formation_dlc17.mbe" / "00_battle_formation.csv"
            if dlc_formation_file.exists():
                rows = self.load_csv(dlc_formation_file)
                for row in rows[1:]:  # Skip header
                    if len(row) > 0 and str(row[0]) == str(digimon.id):
                        digimon.battle_formation_data = {
                            "formation_id": int(row[0]) if row[0] else 0,
                            "formation_type": row[2] if len(row) > 2 else "",
                            "raw_data": row
                        }
                        break
    
    def _load_personality_data(self, digimon: DigimonData):
        """Load personality system data"""
        # Personality data is complex and spread across multiple files
        # For now, just load basic personality type from digimon_status
        digimon.personality_data = {
            "personality_type": digimon.base_personality,
            "can_mount": False,  # This would need to be determined from other flags
            "is_boss_variant": digimon.is_boss_variant
        }
    
    def get_all_digimon_chr_ids(self, from_dlc: bool = False, dlc_name: str = "addcont_17") -> List[str]:
        """Get all available Digimon chr_ids
        
        Args:
            from_dlc: If True, load from DLC files instead of base game
            dlc_name: Name of the DLC folder (default: "addcont_17")
        """
        if from_dlc:
            # Load from DLC
            dlc_exporter = DLCExporter(self)
            dlc_data = dlc_exporter.get_dlc_path(dlc_name) / "data" / "mbe"
            status_file = dlc_data / "digimon_status_dlc17.mbe" / "00_digimon_status_data.csv"
        else:
            # Load from base game
            status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        
        if not status_file.exists():
            return []
            
        status_rows = self.load_csv(status_file)
        chr_ids = []
        
        for row in status_rows[1:]:  # Skip header
            if len(row) > 3 and row[3]:  # chr_id is in column 3
                chr_ids.append(row[3].strip('"'))  # Strip quotes from chr_id
        
        return chr_ids
    
    def get_all_digimon_ids(self) -> List[int]:
        """Get all digimon IDs from the digimon status file"""
        status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
        if not status_file.exists():
            return []
        
        status_rows = self.load_csv(status_file)
        ids = []
        
        for row in status_rows[1:]:  # Skip header
            if len(row) > 0 and row[0]:  # id is in column 0
                try:
                    ids.append(int(row[0]))
                except ValueError:
                    continue
        
        return ids
    
    def save_digimon_data(self, digimon: DigimonData) -> bool:
        """Save Digimon data back to CSV files"""
        import csv
        try:
            # Save to digimon_status.mbe/00_digimon_status_data.csv
            status_file = self.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
            if not status_file.exists():
                print(f"Error: {status_file} not found")
                return False
            
            # Read all rows
            rows = self.load_csv(status_file)
            if len(rows) < 2:
                print("Error: No data rows found in digimon status file")
                return False
            
            headers = self.headers["main/digimon_status.mbe/00_digimon_status_data.csv"]
            
            # Find the row for this digimon
            digimon_row_index = None
            for i, row in enumerate(rows[1:], 1):  # Skip header
                if len(row) > headers["id"] and int(row[headers["id"]]) == digimon.id:
                    digimon_row_index = i
                    break
            
            # If digimon not found, create a new row
            is_new_digimon = digimon_row_index is None
            if is_new_digimon:
                print(f"Digimon ID {digimon.id} not found, creating new entry...")
                # Create a new row with the correct number of columns
                new_row = [""] * 136  # Ensure we have all 136 columns
                new_row[headers["id"]] = str(digimon.id)
                rows.append(new_row)
                digimon_row_index = len(rows) - 1
                
                # Also create entries in other required files
                self._create_new_digimon_entries(digimon)
            
            # Update the row with new data
            row = rows[digimon_row_index]
            
            # Ensure row has enough columns
            while len(row) < 136:  # Ensure we have all 136 columns
                row.append("")
            
            # Basic data
            row[headers["strKey"]] = f'"{digimon.char_key}"'  # Add quotes like original
            row[3] = f'"{digimon.chr_id}"'  # chr_id is in column 3, add quotes
            row[1] = '""'  # Empty field with quotes like original
            
            # Set specific fields to match the expected format (ONLY for new Digimon)
            if is_new_digimon:
                row[60] = "0"  # Field 60 should be 0, not empty
                row[61] = "1"  # Personality field 1
                row[62] = "1"  # Personality field 2
                row[63] = "99" # Personality field 3
                row[64] = "1"  # Personality field 4
                row[65] = "0"  # Personality field 5
                row[66] = "1"  # Personality field 6
                row[67] = "0"  # Personality field 7
                row[68] = "0"  # Personality field 8
                row[69] = '""'  # Empty field
                row[70] = "0"   # Personality field 9
                row[71] = "0"   # Personality field 10
                row[72] = "0"   # Personality field 11
            
            # Set skill-related fields - these are being overwritten by the signature skills
            # The signature skills are loaded from the digimon data and override these values
            # So we need to set them after the signature skills are processed
            
            # Set skill fields to match expected format
            # These will be overridden by signature skills, so set them after signature skills are processed
            
            # Set final/reference fields (ONLY for new Digimon)
            if is_new_digimon:
                row[119] = "1"  # Final field 1
                row[120] = "2"  # Final field 2
                row[121] = "1"  # Final field 3
                row[122] = "1"  # Final field 4
                row[123] = "0"  # Final field 5
                row[124] = "1"  # Final field 6
                row[125] = "0"  # Final field 7
                row[126] = "0"  # Final field 8
                row[128] = "0"  # Final field 9
                row[129] = "0"  # Final field 10
                row[130] = "0"  # Final field 11
                
                # Set reference fields
                row[131] = "-1"  # Reference field 1
                row[133] = "-1"  # Reference field 2
                row[134] = "0"   # Reference field 3
                row[135] = "-1"  # Reference field 4
            
            # Ensure all empty fields have quotes like the original format
            empty_fields = [18, 73, 76, 79, 82, 85, 88, 91, 94, 97, 100, 103, 106, 109, 112, 115, 118, 127]
            for field_idx in empty_fields:
                if field_idx < len(row) and row[field_idx] == '':
                    row[field_idx] = '""'
            
            # Stage and type
            row[headers["stageId"]] = str(digimon.stage_id)
            row[5] = "1"  # This field is always 1 in chr805
            row[headers["typeId"]] = str(digimon.type_id)
            row[headers["basePersonality"]] = str(digimon.personality_id)
            
            # Base stats
            row[headers["baseHP"]] = str(digimon.base_hp)
            row[headers["baseSP"]] = str(digimon.base_sp)
            row[headers["baseATK"]] = str(digimon.base_atk)
            row[headers["baseDEF"]] = str(digimon.base_def)
            row[headers["baseINT"]] = str(digimon.base_int)
            row[headers["baseSPI"]] = str(digimon.base_spi)
            row[headers["baseSPD"]] = str(digimon.base_spd)
            
            # Elemental resistances
            row[headers["resNull"]] = str(digimon.res_null)
            row[headers["resFire"]] = str(digimon.res_fire)
            row[headers["resWater"]] = str(digimon.res_water)
            row[headers["resIce"]] = str(digimon.res_ice)
            row[headers["resGrass"]] = str(digimon.res_grass)
            row[headers["resWind"]] = str(digimon.res_wind)
            row[headers["resElec"]] = str(digimon.res_elec)
            row[headers["resGround"]] = str(digimon.res_ground)
            row[headers["resSteel"]] = str(digimon.res_steel)
            row[headers["resLight"]] = str(digimon.res_light)
            row[headers["resDark"]] = str(digimon.res_dark)
            
            # Signature skills
            for i in range(1, 13):  # 12 signature skills
                skill_id_key = f"signatureSkillId{i}"
                skill_slot_key = f"signatureSkillSlot{i}"
                if skill_id_key in headers and skill_slot_key in headers:
                    # Get skill from signature_skills list
                    if i-1 < len(digimon.signature_skills):
                        skill_id = digimon.signature_skills[i-1]["id"]
                        skill_slot = digimon.signature_skills[i-1]["slot"]
                    else:
                        # For new Digimon, set default skill slots to match the expected format
                        skill_id = 0
                        if i == 1:
                            skill_slot = 1
                        elif i == 2:
                            skill_slot = 2
                        elif i <= 11:
                            skill_slot = 3
                        else:  # i == 12
                            skill_slot = 3
                    row[headers[skill_id_key]] = str(skill_id)
                    row[headers[skill_slot_key]] = str(skill_slot)
            
            # Generic skills
            for i in range(1, 5):  # 4 generic skills
                skill_id_key = f"gSkill{i}Id"
                skill_level_key = f"gSkill{i}Level"
                if skill_id_key in headers and skill_level_key in headers:
                    # Get skill from generic_skills list
                    if i-1 < len(digimon.generic_skills):
                        skill_id = digimon.generic_skills[i-1]["id"]
                        skill_level = digimon.generic_skills[i-1]["level"]
                    else:
                        skill_id = 0
                        skill_level = 0
                    row[headers[skill_id_key]] = str(skill_id)
                    row[headers[skill_level_key]] = str(skill_level)
            
            # Traits (boolean flags starting at traitsBaseIdx)
            traits_start = headers["traitsBaseIdx"]
            for i, trait_value in enumerate(digimon.traits):
                if traits_start + i < len(row):
                    row[traits_start + i] = "1" if trait_value else "0"
            
            # Field guide and script IDs
            if "fieldGuideId" in headers:
                row[headers["fieldGuideId"]] = str(digimon.field_guide_id) if digimon.field_guide_id >= 0 else "-1"
            if "scriptId" in headers:
                row[headers["scriptId"]] = str(digimon.script_id) if digimon.script_id >= 0 else "-1"
            
            # The reference fields are already set above
            
            # Field 18 (empty field with quotes) - already set above
            
            # Override field 119 to match expected format
            row[119] = "1"
            
            # Write back to file preserving original format
            with open(status_file, 'w', newline='', encoding='utf-8') as f:
                for row in rows:
                    # Write row manually to preserve exact format
                    f.write(','.join(row) + '\n')
            
            # Also update name and profile files for existing Digimon
            self._update_char_name_file(digimon)
            self._update_digimon_profile_file(digimon)
            
            # Invalidate cache after saving
            self._invalidate_digimon_status_cache()
            
            print(f"Successfully saved Digimon {digimon.name} ({digimon.chr_id}) to {status_file}")
            return True
            
        except Exception as e:
            print(f"Error saving Digimon data: {e}")
            return False
    
    def _create_new_digimon_entries(self, digimon: DigimonData):
        """Create new Digimon entries in all required files"""
        try:
            # 1. Add to char_name.mbe/00_Sheet1.csv
            self._add_to_char_name_file(digimon)
            
            # 2. Add to char_info.mbe/00_char_info.csv
            self._add_to_char_info_file(digimon)
            
            # 3. Add to model_setting.mbe/00_model_setting.csv
            self._add_to_model_setting_file(digimon)
            
            # 4. Add to model_locator files
            self._add_to_model_locator_files(digimon)
            
            # 5. Add to lod_chara files
            self._add_to_lod_chara_files(digimon)
            
            # 6. Add to fix_front_of_joint.mbe/00_fix_front_of_joint.csv
            self._add_to_fix_front_of_joint_file(digimon)
            
            print(f"Created new Digimon entries for {digimon.name} ({digimon.chr_id})")
            
        except Exception as e:
            print(f"Error creating new Digimon entries: {e}")
    
    def _add_to_char_name_file(self, digimon: DigimonData):
        """Add new Digimon to char_name.mbe/00_Sheet1.csv"""
        char_name_file = self.text_path / "char_name.mbe" / "00_Sheet1.csv"
        if not char_name_file.exists():
            return
        
        rows = self.load_csv(char_name_file)
        # Add new entry: "char_key","display_name"
        new_row = [f'"{digimon.char_key}"', f'"{digimon.name}"']
        rows.append(new_row)
        
        # Write back to file
        with open(char_name_file, 'w', encoding='utf-8') as f:
            for row in rows:
                f.write(','.join(row) + '\n')
    
    def _update_char_name_file(self, digimon: DigimonData):
        """Update existing Digimon name in char_name.mbe/00_Sheet1.csv"""
        char_name_file = self.text_path / "char_name.mbe" / "00_Sheet1.csv"
        if not char_name_file.exists():
            return
        
        rows = self.load_csv(char_name_file)
        # Find and update existing entry
        entry_found = False
        for i, row in enumerate(rows[1:], 1):  # Skip header
            if len(row) > 0 and row[0].strip('"') == digimon.char_key:
                rows[i] = [f'"{digimon.char_key}"', f'"{digimon.name}"']
                entry_found = True
                break
        
        # If not found, add new entry
        if not entry_found:
            rows.append([f'"{digimon.char_key}"', f'"{digimon.name}"'])
        
        # Write back to file
        with open(char_name_file, 'w', encoding='utf-8') as f:
            for row in rows:
                f.write(','.join(row) + '\n')
    
    def _update_digimon_profile_file(self, digimon: DigimonData):
        """Update existing Digimon profile in digimon_profile.mbe/00_Sheet1.csv"""
        profile_file = self.text_path / "digimon_profile.mbe" / "00_Sheet1.csv"
        if not profile_file.exists():
            return
        
        rows = self.load_csv(profile_file)
        profile_key = f'digimon_{digimon.id:04d}_profile'
        profile_text = digimon.profile_text if digimon.profile_text else ""
        
        # Find and update existing entry
        entry_found = False
        for i, row in enumerate(rows[1:], 1):  # Skip header
            if len(row) > 0 and row[0].strip('"') == profile_key:
                rows[i] = [f'"{profile_key}"', f'"{profile_text}"']
                entry_found = True
                break
        
        # If not found, add new entry
        if not entry_found and profile_text:
            rows.append([f'"{profile_key}"', f'"{profile_text}"'])
        
        # Write back to file
        if entry_found or (not entry_found and profile_text):
            with open(profile_file, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
    
    def _add_to_char_info_file(self, digimon: DigimonData):
        """Add new Digimon to char_info.mbe/00_char_info.csv"""
        char_info_file = self.data_path / "char_info.mbe" / "00_char_info.csv"
        if not char_info_file.exists():
            return
        
        rows = self.load_csv(char_info_file)
        # Add new entry that points to chr805 (Darkshadow) for model/animation loading
        # Column 3 (chr_id) should be "chr805" so it uses Darkshadow's model
        # This is the key - char_info controls which model gets loaded!
        new_row = [
            f'"{digimon.char_key}"', '""', '""', '"chr805"',  # Point to chr805 model
            f'"{digimon.id + 1000}"', '""', '0', '0', '""', '0', '""', '0', '""', '0'
        ]
        rows.append(new_row)
        
        # Write back to file
        with open(char_info_file, 'w', encoding='utf-8') as f:
            for row in rows:
                f.write(','.join(row) + '\n')
    
    def _add_to_model_setting_file(self, digimon: DigimonData):
        """Add new Digimon to model_setting.mbe/00_model_setting.csv"""
        model_setting_file = self.data_path / "model_setting.mbe" / "00_model_setting.csv"
        if not model_setting_file.exists():
            return
        
        rows = self.load_csv(model_setting_file)
        # Use chr805 as template for model settings
        template_row = None
        for row in rows[1:]:  # Skip header
            if len(row) > 0 and row[0] == '"chr805"':
                template_row = row.copy()
                break
        
        if template_row:
            # Replace chr805 with new chr_id
            template_row[0] = f'"{digimon.chr_id}"'
            rows.append(template_row)
            
            # Write back to file
            with open(model_setting_file, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
    
    def _add_to_model_locator_files(self, digimon: DigimonData):
        """Add new Digimon to model_locator files"""
        # Add to 00_model_locator.csv
        locator_file = self.data_path / "model_locator.mbe" / "00_model_locator.csv"
        if locator_file.exists():
            rows = self.load_csv(locator_file)
            # Find template from chr805
            template_row = None
            for row in rows[1:]:
                if len(row) > 0 and 'chr805' in str(row[0]):
                    template_row = row.copy()
                    break
            
            if template_row:
                # Replace chr805 references with new chr_id
                for i, cell in enumerate(template_row):
                    if 'chr805' in str(cell):
                        template_row[i] = str(cell).replace('chr805', digimon.chr_id)
                rows.append(template_row)
                
                with open(locator_file, 'w', encoding='utf-8') as f:
                    for row in rows:
                        f.write(','.join(row) + '\n')
        
        # Add to 01_model_locator_motion.csv
        motion_file = self.data_path / "model_locator.mbe" / "01_model_locator_motion.csv"
        if motion_file.exists():
            rows = self.load_csv(motion_file)
            # Find ALL templates from chr805 (not just the first one)
            template_rows = []
            for row in rows[1:]:
                if len(row) > 0 and 'chr805' in str(row[0]):
                    template_rows.append(row.copy())
            
            # Add all template rows with chr_id replaced
            for template_row in template_rows:
                # Replace chr805 references with new chr_id
                for i, cell in enumerate(template_row):
                    if 'chr805' in str(cell):
                        template_row[i] = str(cell).replace('chr805', digimon.chr_id)
                rows.append(template_row)
                
            with open(motion_file, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
    
    def _add_to_lod_chara_files(self, digimon: DigimonData):
        """Add new Digimon to lod_chara files"""
        # Add to 00_lod.csv
        lod_file = self.data_path / "lod_chara.mbe" / "00_lod.csv"
        if lod_file.exists():
            rows = self.load_csv(lod_file)
            # Find template from chr805
            template_row = None
            for row in rows[1:]:
                if len(row) > 0 and 'chr805' in str(row[0]):
                    template_row = row.copy()
                    break
            
            if template_row:
                # Replace chr805 references with new chr_id
                for i, cell in enumerate(template_row):
                    if 'chr805' in str(cell):
                        template_row[i] = str(cell).replace('chr805', digimon.chr_id)
                rows.append(template_row)
                
                with open(lod_file, 'w', encoding='utf-8') as f:
                    for row in rows:
                        f.write(','.join(row) + '\n')
        
        # Add to 01_lod_model.csv
        lod_model_file = self.data_path / "lod_chara.mbe" / "01_lod_model.csv"
        if lod_model_file.exists():
            rows = self.load_csv(lod_model_file)
            # Find template from chr805
            template_row = None
            for row in rows[1:]:
                if len(row) > 0 and 'chr805' in str(row[0]):
                    template_row = row.copy()
                    break
            
            if template_row:
                # Replace chr805 references with new chr_id
                for i, cell in enumerate(template_row):
                    if 'chr805' in str(cell):
                        template_row[i] = str(cell).replace('chr805', digimon.chr_id)
                rows.append(template_row)
                
                with open(lod_model_file, 'w', encoding='utf-8') as f:
                    for row in rows:
                        f.write(','.join(row) + '\n')
    
    def _add_to_fix_front_of_joint_file(self, digimon: DigimonData):
        """Add new Digimon to fix_front_of_joint.mbe/00_fix_front_of_joint.csv"""
        joint_file = self.data_path / "fix_front_of_joint.mbe" / "00_fix_front_of_joint.csv"
        if not joint_file.exists():
            return
        
        rows = self.load_csv(joint_file)
        # Find ALL templates from chr805 (not just the first one)
        template_rows = []
        for row in rows[1:]:
            if len(row) > 0 and 'chr805' in str(row[0]):
                template_rows.append(row.copy())
        
        # Add all template rows with chr_id replaced
        for template_row in template_rows:
            # Replace chr805 references with new chr_id
            for i, cell in enumerate(template_row):
                if 'chr805' in str(cell):
                    template_row[i] = str(cell).replace('chr805', digimon.chr_id)
            rows.append(template_row)
            
        with open(joint_file, 'w', encoding='utf-8') as f:
            for row in rows:
                f.write(','.join(row) + '\n')
    
    # Text Data Integration Methods
    def _load_text_file(self, filename: str) -> Dict[str, str]:
        """Load a text .mbe file and return ID->Name mapping"""
        file_path = self.text_path / filename / "00_Sheet1.csv"
        text_data = {}
        
        if file_path.exists():
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    headers = next(reader, None)  # Skip header row
                    
                    for row in reader:
                        if len(row) >= 2 and row[0] and row[1]:
                            # Clean the ID (remove quotes)
                            text_id = row[0].strip('"')
                            # Clean the text (remove quotes and basic formatting)
                            text_value = row[1].strip('"')
                            text_data[text_id] = text_value
            except Exception as e:
                print(f"Error loading text file {filename}: {e}")
                
        return text_data
    
    def get_skill_name(self, skill_id: int) -> str:
        """Get localized skill name by skill ID"""
        if self._skill_names_cache is None:
            self._skill_names_cache = self._load_text_file("skill_name.mbe")
        return self._skill_names_cache.get(str(skill_id), f"Skill_{skill_id}")
    
    def get_element_name(self, element_id: int) -> str:
        """Get localized element name by element ID"""
        if self._element_names_cache is None:
            self._element_names_cache = self._load_text_file("element.mbe")
        return self._element_names_cache.get(str(element_id), f"Element_{element_id}")
    
    def get_type_name(self, type_id: int) -> str:
        """Get localized type name by type ID"""
        if self._type_names_cache is None:
            self._type_names_cache = self._load_text_file("digimon_type.mbe")
        return self._type_names_cache.get(str(type_id), f"Type_{type_id}")
    
    def get_location_name(self, location_id: int) -> str:
        """Get localized location name by location ID"""
        if self._location_names_cache is None:
            self._location_names_cache = self._load_text_file("field_name.mbe")
        return self._location_names_cache.get(str(location_id), f"Area_{location_id}")
    
    
    def get_battle_message(self, message_id: int) -> str:
        """Get localized battle message by message ID"""
        if self._battle_messages_cache is None:
            self._battle_messages_cache = self._load_text_file("battle_info_message.mbe")
        return self._battle_messages_cache.get(str(message_id), f"Message_{message_id}")
    
    def get_trait_name(self, trait_id: int) -> str:
        """Get localized trait name by trait ID"""
        if self._trait_names_cache is None:
            self._trait_names_cache = self._load_text_file("digimon_class_name.mbe")
        return self._trait_names_cache.get(str(trait_id), f"Trait_{trait_id}")
    
    def get_jogress_skill_name(self, skill_id: int) -> str:
        """Get localized jogress skill name by skill ID"""
        if self._jogress_skill_names_cache is None:
            self._jogress_skill_names_cache = self._load_text_file("jogress_skill_name.mbe")
        return self._jogress_skill_names_cache.get(str(skill_id), f"JogressSkill_{skill_id}")
    
    def get_skill_explanation(self, skill_id: int) -> str:
        """Get localized skill explanation by skill ID"""
        if self._skill_explanations_cache is None:
            self._skill_explanations_cache = self._load_text_file("skill_explanation.mbe")
        return self._skill_explanations_cache.get(str(skill_id), f"Explanation_{skill_id}")
    
    def get_skill_auto_explanation(self, skill_id: int) -> str:
        """Get localized skill auto explanation by skill ID"""
        if self._skill_auto_explanations_cache is None:
            self._skill_auto_explanations_cache = self._load_text_file("skill_auto_explanation.mbe")
        return self._skill_auto_explanations_cache.get(str(skill_id), f"AutoExplanation_{skill_id}")
    
    def get_generation_name(self, generation_id: int) -> str:
        """Get localized generation name by generation ID"""
        if self._generation_names_cache is None:
            self._generation_names_cache = self._load_text_file("generation_name.mbe")
        return self._generation_names_cache.get(str(generation_id), f"Generation_{generation_id}")
    
    def get_personality_name(self, personality_id: int) -> str:
        """Get localized personality name by personality ID"""
        if self._personality_names_cache is None:
            self._personality_names_cache = self._load_text_file("personality_name.mbe")
        return self._personality_names_cache.get(str(personality_id), f"Personality_{personality_id}")
    
    def get_item_name(self, item_id: int) -> str:
        """Get localized item name by item ID"""
        if self._item_names_cache is None:
            self._item_names_cache = self._load_text_file("item_name.mbe")
        return self._item_names_cache.get(str(item_id), f"Item_{item_id}")
    
    def get_belong_name(self, belong_id: int) -> str:
        """Get localized belong name by belong ID"""
        if self._belong_names_cache is None:
            self._belong_names_cache = self._load_text_file("belong.mbe")
        return self._belong_names_cache.get(str(belong_id), f"Belong_{belong_id}")
    
    def get_digimon_profile(self, digimon_id: int) -> str:
        """Get localized digimon profile by digimon ID"""
        if self._digimon_profiles_cache is None:
            # Profile file uses special keys like "digimon_0002_profile"
            # and profiles span multiple rows
            self._digimon_profiles_cache = {}
            file_path = self.text_path / "digimon_profile.mbe" / "00_Sheet1.csv"
            
            if file_path.exists():
                try:
                    rows = self.load_csv(file_path)
                    current_profile_id = None
                    current_profile_text = []
                    
                    for row in rows[1:]:  # Skip header
                        if len(row) >= 1:
                            # Check if this is a new profile entry
                            key = row[0].strip('"').strip() if row[0] else ""
                            if key.startswith('digimon_') and key.endswith('_profile'):
                                # Save previous profile if exists
                                if current_profile_id is not None and current_profile_text:
                                    # Join with space and clean up multiple spaces/newlines
                                    profile_full_text = ' '.join(current_profile_text).strip()
                                    # Replace multiple spaces/newlines with single space
                                    profile_full_text = re.sub(r'\s+', ' ', profile_full_text)
                                    if profile_full_text:
                                        self._digimon_profiles_cache[current_profile_id] = profile_full_text
                                
                                # Start new profile
                                try:
                                    id_str = key.replace('digimon_', '').replace('_profile', '')
                                    current_profile_id = int(id_str)
                                    # Get text from column 1 - csv.reader handles multi-line quoted fields
                                    if len(row) > 1 and row[1]:
                                        # csv.reader already handles multi-line quoted fields, so row[1] contains the full text
                                        profile_text = row[1].strip()
                                        # Replace newlines with spaces and clean up
                                        profile_text = profile_text.replace('\n', ' ').replace('\r', ' ')
                                        profile_text = re.sub(r'\s+', ' ', profile_text).strip()
                                        if profile_text:
                                            self._digimon_profiles_cache[current_profile_id] = profile_text
                                            current_profile_text = []  # Already saved, clear for next
                                        else:
                                            current_profile_text = []
                                    else:
                                        current_profile_text = []
                                except ValueError:
                                    current_profile_id = None
                                    current_profile_text = []
                            elif current_profile_id is not None:
                                # This is a continuation row (for old CSV format without proper quoting)
                                # Check both columns for text
                                continuation_text = None
                                # Check column 0 first (most continuation rows have text here)
                                if len(row) >= 1 and row[0]:
                                    col0_text = row[0].strip('"').strip()
                                    # Remove trailing newline if present
                                    col0_text = col0_text.rstrip('\n\r')
                                    # Make sure it's not a new profile key and not empty
                                    if col0_text and not col0_text.startswith('digimon_'):
                                        continuation_text = col0_text
                                # If column 0 doesn't have text, check column 1
                                if not continuation_text and len(row) > 1 and row[1]:
                                    col1_text = row[1].strip('"').strip()
                                    if col1_text:
                                        col1_text = col1_text.rstrip('\n\r')
                                        # Make sure it's not a new profile key
                                        if not col1_text.startswith('digimon_'):
                                            continuation_text = col1_text
                                
                                if continuation_text:
                                    current_profile_text.append(continuation_text)
                    
                    # Save the last profile
                    if current_profile_id is not None and current_profile_text:
                        # Join with space and clean up multiple spaces/newlines
                        profile_full_text = ' '.join(current_profile_text).strip()
                        # Replace multiple spaces with single space
                        profile_full_text = re.sub(r'\s+', ' ', profile_full_text)
                        if profile_full_text:
                            self._digimon_profiles_cache[current_profile_id] = profile_full_text
                        
                except Exception as e:
                    print(f"Error loading digimon profiles: {e}")
        
        return self._digimon_profiles_cache.get(digimon_id, "")
    
    def get_buff_name(self, buff_id: int) -> str:
        """Get localized buff name by buff ID"""
        if self._buff_names_cache is None:
            self._buff_names_cache = self._load_text_file("buff_name.mbe")
        return self._buff_names_cache.get(str(buff_id), f"Buff_{buff_id}")
    
    def get_status_name(self, status_id: int) -> str:
        """Get localized status name by status ID"""
        if self._status_names_cache is None:
            self._status_names_cache = self._load_text_file("status_name.mbe")
        return self._status_names_cache.get(str(status_id), f"Status_{status_id}")
    
    def clean_ui_text(self, text: str) -> str:
        """Clean UI text by removing formatting tags and icons"""
        import re
        # Remove image tags like {image(ui_icon_skill_001)}
        text = re.sub(r'\{image\([^)]+\)\}', '', text)
        # Remove formatting tags like {is28}, {fc9}, etc.
        text = re.sub(r'\{[^}]+\}', '', text)
        # Clean up extra spaces
        text = ' '.join(text.split())
        return text.strip()
    
    def load_skill_data(self, skill_id: int) -> Dict[str, Any]:
        """Load skill data from battle_skill.mbe"""
        skill_file = self.data_path / "battle_skill.mbe" / "00_battle_skill_list.csv"
        if skill_file.exists():
            rows = self.load_csv(skill_file)
            for row in rows[1:]:  # Skip header
                if len(row) > 0 and int(row[0]) == skill_id:
                    return {
                        "skill_id": int(row[0]) if row[0] else 0,
                        "name_id": int(row[4]) if len(row) > 4 and row[4] else 0,
                        "description_id": int(row[5]) if len(row) > 5 and row[5] else 0,
                        "power": int(row[23]) if len(row) > 23 and row[23] else 0,
                        "sp_cost": int(row[36]) if len(row) > 36 and row[36] else 0,
                        "accuracy": int(row[40]) if len(row) > 40 and row[40] else 0,
                        "crit_rate": int(row[42]) if len(row) > 42 and row[42] else 0,
                        "damage_type": int(row[22]) if len(row) > 22 and row[22] else 0,
                        "element": int(row[28]) if len(row) > 28 and row[28] else 0,
                        "min_hits": int(row[34]) if len(row) > 34 and row[34] else 1,
                        "max_hits": int(row[35]) if len(row) > 35 and row[35] else 1,
                        "additional_property_1": int(row[26]) if len(row) > 26 and row[26] else 0,
                        "additional_property": int(row[27]) if len(row) > 27 and row[27] else 0,
                        "conditional_type": int(row[46]) if len(row) > 46 and row[46] else 0,
                        "conditional_effect": int(row[47]) if len(row) > 47 and row[47] else 0,
                        "conditional_arg": int(row[49]) if len(row) > 49 and row[49] else 0,
                        "hp_drain": int(row[43]) if len(row) > 43 and row[43] else 0,
                        "sp_drain": int(row[44]) if len(row) > 44 and row[44] else 0,
                        "recoil": int(row[45]) if len(row) > 45 and row[45] else 0,
                        "always_hits": bool(int(row[39])) if len(row) > 39 and row[39] else False,
                        "buff_set_0": int(row[52]) if len(row) > 52 and row[52] else 0,
                        "buff_set_1": int(row[54]) if len(row) > 54 and row[54] else 0,
                        "buff_set_2": int(row[56]) if len(row) > 56 and row[56] else 0,
                        "buff_set_3": int(row[58]) if len(row) > 58 and row[58] else 0,
                        "buff_set_4": int(row[60]) if len(row) > 60 and row[60] else 0,
                        "raw_data": row
                    }
        return {}
    
    def save_skill_data(self, skill_data: Dict[str, Any]) -> bool:
        """Save skill data back to battle_skill.mbe"""
        skill_file = self.data_path / "battle_skill.mbe" / "00_battle_skill_list.csv"
        if not skill_file.exists():
            return False
        
        # Read all rows
        rows = self.load_csv(skill_file)
        skill_id = skill_data.get("skill_id", 0)
        
        # Find and update the skill row
        for i, row in enumerate(rows[1:], 1):  # Skip header
            if len(row) > 0 and int(row[0]) == skill_id:
                # Update the row with new data
                if len(row) > 4: row[4] = str(skill_data.get("name_id", 0))
                if len(row) > 5: row[5] = str(skill_data.get("description_id", 0))
                if len(row) > 22: row[22] = str(skill_data.get("damage_type", 0))
                if len(row) > 23: row[23] = str(skill_data.get("power", 0))
                if len(row) > 26: row[26] = str(skill_data.get("additional_property_1", 0))
                if len(row) > 27: row[27] = str(skill_data.get("additional_property", 0))
                if len(row) > 28: row[28] = str(skill_data.get("element", 0))
                if len(row) > 34: row[34] = str(skill_data.get("min_hits", 1))
                if len(row) > 35: row[35] = str(skill_data.get("max_hits", 1))
                if len(row) > 36: row[36] = str(skill_data.get("sp_cost", 0))
                if len(row) > 39: row[39] = str(1 if skill_data.get("always_hits", False) else 0)
                if len(row) > 40: row[40] = str(skill_data.get("accuracy", 0))
                if len(row) > 42: row[42] = str(skill_data.get("crit_rate", 0))
                if len(row) > 43: row[43] = str(skill_data.get("hp_drain", 0))
                if len(row) > 44: row[44] = str(skill_data.get("sp_drain", 0))
                if len(row) > 45: row[45] = str(skill_data.get("recoil", 0))
                if len(row) > 46: row[46] = str(skill_data.get("conditional_type", 0))
                if len(row) > 47: row[47] = str(skill_data.get("conditional_effect", 0))
                if len(row) > 49: row[49] = str(skill_data.get("conditional_arg", 0))
                if len(row) > 52: row[52] = str(skill_data.get("buff_set_0", 0))
                if len(row) > 54: row[54] = str(skill_data.get("buff_set_1", 0))
                if len(row) > 56: row[56] = str(skill_data.get("buff_set_2", 0))
                if len(row) > 58: row[58] = str(skill_data.get("buff_set_3", 0))
                if len(row) > 60: row[60] = str(skill_data.get("buff_set_4", 0))
                break
        
        # Write back to file (preserve exact CSV format with quotes)
        try:
            with open(skill_file, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            return True
        except Exception as e:
            print(f"Error saving skill data: {e}")
            return False
    
    # Advanced Skill System Methods
    def get_skill_conditional_type_name(self, conditional_type: int) -> str:
        """Get human-readable name for skill conditional types"""
        conditional_types = {
            1: "If user is affected by (de)buff",
            2: "If target is affected by (de)buff", 
            3: "If target is of attribute",
            4: "If target is of element",
            5: "If target's Generation is greater than user's",
            6: "If target's Generation is lesser than user's",
            7: "If target has already acted",
            8: "If target has yet to act",
            9: "If target's HP is 50% or higher",
            10: "If target's HP is X% or less",
            11: "If target's SP is X% or higher",
            12: "If target's SP is X% or less",
            13: "If target is KO'd"
        }
        return conditional_types.get(conditional_type, f"Unknown ({conditional_type})")
    
    def get_skill_effect_name(self, effect_type: int) -> str:
        """Get human-readable name for skill effects"""
        effects = {
            0: "None",
            1: "+X% damage",
            2: "Increased Damage", 
            3: "CRT Rate up",
            4: "None",
            5: "Restore HP",
            6: "Restore SP",
            7: "Restore SP/HP",
            8: "Reduce Target's SP by X%"
        }
        return effects.get(effect_type, f"Unknown ({effect_type})")
    
    def get_damage_type_name(self, damage_type: int) -> str:
        """Get human-readable name for damage types"""
        damage_types = {
            0: "None/Self",
            1: "Physical",
            2: "Magic", 
            4: "Fixed damage at",
            5: "Fixed %",
            6: "Buff",
            11: "Major Damage"
        }
        return damage_types.get(damage_type, f"Unknown ({damage_type})")
    
    def get_additional_property_name(self, prop_type: int) -> str:
        """Get human-readable name for additional properties"""
        properties = {
            1: "The lower the user's HP, the higher the damage",
            2: "The lower all allies' HP, the greater the damage",
            3: "The lower the user's HP, the lower the damage",
            4: "The lower all allies' HP, the lower the damage",
            5: "The lower the user's SP, the greater the damage",
            6: "The lower all allies' SP, the greater the damage",
            7: "The lower the user's SP, the lower the damage",
            8: "The lower all allies' SP, the lower the damage",
            9: "The more battle members are KO'd, the greater the damage",
            10: "The more allies are KO'd, the greater the damage",
            11: "The more it is used, the greater the damage",
            12: "The more rounds have passed, the greater the damage",
            13: "The greater the user's stat buffs, the greater the damage"
        }
        return properties.get(prop_type, f"Unknown ({prop_type})")
    
    def get_additional_property_effect_name(self, prop_type: int) -> str:
        """Get human-readable name for additional property effects"""
        effects = {
            1: "No Effect described",
            2: "No Effect described", 
            3: "Nullifies unfavorable compatibility",
            4: "No effect described",
            5: "Inverts all stat changes of the target",
            6: "Steals all stat changes from the target",
            7: "Recovers beyond the target's Max HP",
            8: "Consumes all SP",
            9: "Nullifies unfavorable attribute compatibility",
            10: "Attack treated as Vaccine",
            11: "Attack treated as Data",
            12: "Attack treated as Virus",
            13: "Attack treated as Free",
            14: "Attack treated as Variable"
        }
        return effects.get(prop_type, f"Unknown ({prop_type})")
    
    def get_menu_icon_name(self, icon_type: int) -> str:
        """Get human-readable name for menu icons"""
        icons = {
            -1: "Damage element",
            11: "Heal",
            12: "Buff", 
            13: "Debuff"
        }
        return icons.get(icon_type, f"Unknown ({icon_type})")


if __name__ == "__main__":
    # Test the loader with chr805
    loader = MBELoader()
    digimon = loader.get_digimon_by_chr_id("chr805")
    
    if digimon:
        print(f"Loaded Digimon: {digimon.name}")
        print(f"ID: {digimon.id}, Chr ID: {digimon.chr_id}")
        print(f"HP: {digimon.base_hp}, ATK: {digimon.base_atk}, DEF: {digimon.base_def}")
        print(f"Signature Skills: {len(digimon.signature_skills)}")
        print(f"Generic Skills: {len(digimon.generic_skills)}")
    else:
        print("Could not load chr805")


class DLCExporter:
    """Handles exporting Digimon data to DLC files"""
    
    def __init__(self, loader: 'MBELoader'):
        self.loader = loader
        self.workspace_root = loader.data_path.parent
    
    def get_dlc_path(self, dlc_name: str = "addcont_17") -> Path:
        """Get the DLC directory path"""
        return self.workspace_root / "DLC" / f"{dlc_name}.dx11"
    
    def get_dlc_text_path(self, dlc_name: str = "addcont_17_text01") -> Path:
        """Get the DLC text directory path"""
        return self.workspace_root / "DLC" / f"{dlc_name}.dx11"
    
    def ensure_dlc_directories(self, dlc_name: str = "addcont_17") -> bool:
        """Ensure all DLC directories exist"""
        try:
            dlc_data = self.get_dlc_path(dlc_name) / "data" / "mbe"
            dlc_text = self.get_dlc_text_path(dlc_name + "_text01") / "text" / "mbe"
            
            # Create all required directories
            dirs_to_create = [
                dlc_data / "char_info_dlc17.mbe",
                dlc_data / "digimon_status_dlc17.mbe",
                dlc_data / "evolution_dlc17.mbe",
                dlc_data / "battle_skill_dlc17.mbe",
                dlc_data / "lod_chara_dlc17.mbe",
                dlc_data / "model_setting_dlc17.mbe",
                dlc_data / "model_outline_dlc17.mbe",
                dlc_data / "aim_setup_dlc17.mbe",
                dlc_data / "fix_front_of_joint_dlc17.mbe",
                dlc_data / "anim_setting_dlc17.mbe",
                dlc_data / "battle_effect_dlc17.mbe",
                dlc_text / "char_name_dlc17.mbe",
                dlc_text / "digimon_profile_dlc17.mbe",
                dlc_text / "skill_name_dlc17.mbe",
            ]
            
            for dir_path in dirs_to_create:
                dir_path.mkdir(parents=True, exist_ok=True)
            
            return True
        except Exception as e:
            print(f"Error creating DLC directories: {e}")
            return False
    
    def save_digimon_to_dlc(self, digimon: DigimonData, animation_ref_chr_id: str = None, dlc_name: str = "addcont_17") -> bool:
        """Export a Digimon to DLC files instead of base game
        
        Args:
            digimon: DigimonData object to export
            animation_ref_chr_id: chr_id to use for animations (e.g., "chr805")
            dlc_name: Name of the DLC folder
        """
        try:
            if not self.ensure_dlc_directories(dlc_name):
                return False
            
            dlc_data = self.get_dlc_path(dlc_name) / "data" / "mbe"
            dlc_text = self.get_dlc_text_path(dlc_name + "_text01") / "text" / "mbe"
            
            # If no animation ref provided, use digimon's chr_id
            if not animation_ref_chr_id:
                animation_ref_chr_id = digimon.chr_id
            
            print(f"\n=== Exporting {digimon.name} (ID: {digimon.id}) to DLC ===")
            print(f"Chr ID: {digimon.chr_id} | Animation Ref: {animation_ref_chr_id}")
            
            # 1. Save to char_info_dlc17
            success = self._save_to_dlc_char_info(digimon, dlc_data)
            if not success:
                print("❌ Failed to save to char_info_dlc17")
                return False
            
            # 2. Save to digimon_status_dlc17
            success = self._save_to_dlc_status(digimon, dlc_data)
            if not success:
                print("❌ Failed to save to digimon_status_dlc17")
                return False
            
            # 3. Save to evolution_dlc17
            success = self._save_to_dlc_evolution(digimon, dlc_data)
            if not success:
                print("❌ Failed to save to evolution_dlc17")
                return False
            
            # 4. Save to char_name_dlc17
            success = self._save_to_dlc_char_name(digimon, dlc_text)
            if not success:
                print("❌ Failed to save to char_name_dlc17")
                return False
            
            # 5. Save to digimon_profile_dlc17
            success = self._save_to_dlc_profile(digimon, dlc_text)
            if not success:
                print("❌ Failed to save to digimon_profile_dlc17")
                return False
            
            # 6. Save to anim_setting_dlc17 (animation references)
            success = self._save_to_dlc_animation(digimon, dlc_data, animation_ref_chr_id)
            if not success:
                print("❌ Failed to save to anim_setting_dlc17")
                return False
            
            # 7. Save to model_setting_dlc17
            success = self._save_to_dlc_model_setting(digimon, dlc_data, animation_ref_chr_id)
            if not success:
                print("❌ Failed to save to model_setting_dlc17")
                return False
            
            # 8. Save to model_outline_dlc17
            success = self._save_to_dlc_model_outline(digimon, dlc_data)
            if not success:
                print("❌ Failed to save to model_outline_dlc17")
                return False
            
            # 9. Save to lod_chara_dlc17 (both files)
            success = self._save_to_dlc_lod(digimon, dlc_data)
            if not success:
                print("❌ Failed to save to lod_chara_dlc17")
                return False
            
            print(f"✅ Successfully exported {digimon.name} to DLC!")
            return True
            
        except Exception as e:
            print(f"Error exporting to DLC: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def remove_digimon_from_dlc(self, digimon_id: int, chr_id: str = None, char_key: str = None, dlc_name: str = "addcont_17") -> bool:
        """Remove a Digimon from all DLC files
        
        Args:
            digimon_id: The Digimon ID to remove
            chr_id: Optional chr_id to match (for more accurate removal)
            char_key: Optional char_key to match (for more accurate removal)
            dlc_name: DLC name (default: "addcont_17")
        
        Returns:
            True if successful, False otherwise
        """
        try:
            dlc_data = self.get_dlc_path(dlc_name) / "data" / "mbe"
            dlc_text = self.get_dlc_text_path(dlc_name + "_text01") / "text" / "mbe"
            
            print(f"\n=== Removing Digimon ID {digimon_id} from DLC ===")
            if chr_id:
                print(f"Chr ID: {chr_id}")
            if char_key:
                print(f"Char Key: {char_key}")
            
            removed_count = 0
            
            # 1. Remove from char_info_dlc17
            file_path = dlc_data / "char_info_dlc17.mbe" / "00_char_info.csv"
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
                original_count = len(rows)
                filtered_rows = [rows[0]]  # Keep header
                for row in rows[1:]:
                    # Match by char_key (row[0]) or chr_id (row[3])
                    if len(row) > 0:
                        row_char_key = row[0].strip('"')
                        row_chr_id = row[3].strip('"') if len(row) > 3 else ""
                        if not (char_key and row_char_key == char_key) and not (chr_id and row_chr_id == chr_id):
                            filtered_rows.append(row)
                if len(filtered_rows) < original_count:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        for row in filtered_rows:
                            f.write(','.join(row) + '\n')
                    removed_count += 1
                    print(f"✅ Removed from char_info_dlc17.mbe")
            
            # 2. Remove from digimon_status_dlc17
            file_path = dlc_data / "digimon_status_dlc17.mbe" / "00_digimon_status_data.csv"
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
                original_count = len(rows)
                filtered_rows = [rows[0]]  # Keep header
                for row in rows[1:]:
                    if len(row) > 0 and row[0] != str(digimon_id):
                        filtered_rows.append(row)
                if len(filtered_rows) < original_count:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        for row in filtered_rows:
                            f.write(','.join(row) + '\n')
                    removed_count += 1
                    print(f"✅ Removed from digimon_status_dlc17.mbe")
            
            # 3. Remove from evolution_dlc17 (both files)
            # Remove from 00_evolution_condition.csv
            file_path = dlc_data / "evolution_dlc17.mbe" / "00_evolution_condition.csv"
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
                original_count = len(rows)
                filtered_rows = [rows[0]]  # Keep header
                for row in rows[1:]:
                    if len(row) > 0 and row[0] != str(digimon_id):
                        filtered_rows.append(row)
                if len(filtered_rows) < original_count:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        for row in filtered_rows:
                            f.write(','.join(row) + '\n')
                    removed_count += 1
                    print(f"✅ Removed from evolution_condition")
            
            # Remove from 01_evolution_to.csv (remove paths where this Digimon is source or target)
            file_path = dlc_data / "evolution_dlc17.mbe" / "01_evolution_to.csv"
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
                original_count = len(rows)
                filtered_rows = [rows[0]]  # Keep header
                for row in rows[1:]:
                    # row[1] = from_id, row[3] = to_id
                    if len(row) > 3:
                        if row[1] != str(digimon_id) and row[3] != str(digimon_id):
                            filtered_rows.append(row)
                if len(filtered_rows) < original_count:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        for row in filtered_rows:
                            f.write(','.join(row) + '\n')
                    removed_count += 1
                    print(f"✅ Removed evolution paths from evolution_to")
            
            # 4. Remove from char_name_dlc17
            file_path = dlc_text / "char_name_dlc17.mbe" / "00_Sheet1.csv"
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
                original_count = len(rows)
                filtered_rows = [rows[0]]  # Keep header
                for row in rows[1:]:
                    if len(row) > 0:
                        row_char_key = row[0].strip('"')
                        if not (char_key and row_char_key == char_key):
                            filtered_rows.append(row)
                if len(filtered_rows) < original_count:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        for row in filtered_rows:
                            f.write(','.join(row) + '\n')
                    removed_count += 1
                    print(f"✅ Removed from char_name_dlc17.mbe")
            
            # 5. Remove from digimon_profile_dlc17
            file_path = dlc_text / "digimon_profile_dlc17.mbe" / "00_Sheet1.csv"
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
                original_count = len(rows)
                filtered_rows = [rows[0]]  # Keep header
                profile_key = f'digimon_{digimon_id:04d}_profile'
                for row in rows[1:]:
                    if len(row) > 0:
                        row_key = row[0].strip('"')
                        if row_key != profile_key:
                            filtered_rows.append(row)
                if len(filtered_rows) < original_count:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        for row in filtered_rows:
                            f.write(','.join(row) + '\n')
                    removed_count += 1
                    print(f"✅ Removed from digimon_profile_dlc17.mbe")
            
            # 6. Remove from anim_setting_dlc17 (by chr_id)
            if chr_id:
                file_path = dlc_data / "anim_setting_dlc17.mbe" / "00_anim_setting.csv"
                if file_path.exists():
                    rows = self.loader.load_csv(file_path)
                    original_count = len(rows)
                    filtered_rows = [rows[0]]  # Keep header
                    chr_id_clean = chr_id.strip('"')
                    for row in rows[1:]:
                        if len(row) > 0:
                            row_chr_id = row[0].strip('"')
                            if row_chr_id != chr_id_clean:
                                filtered_rows.append(row)
                    if len(filtered_rows) < original_count:
                        with open(file_path, 'w', encoding='utf-8') as f:
                            for row in filtered_rows:
                                f.write(','.join(row) + '\n')
                        removed_count += 1
                        print(f"✅ Removed from anim_setting_dlc17.mbe")
            
            # 7. Remove from model_setting_dlc17 (by chr_id)
            if chr_id:
                file_path = dlc_data / "model_setting_dlc17.mbe" / "00_model_setting.csv"
                if file_path.exists():
                    rows = self.loader.load_csv(file_path)
                    original_count = len(rows)
                    filtered_rows = [rows[0]]  # Keep header
                    chr_id_clean = chr_id.strip('"')
                    for row in rows[1:]:
                        if len(row) > 0:
                            row_chr_id = row[0].strip('"')
                            if row_chr_id != chr_id_clean:
                                filtered_rows.append(row)
                    if len(filtered_rows) < original_count:
                        with open(file_path, 'w', encoding='utf-8') as f:
                            for row in filtered_rows:
                                f.write(','.join(row) + '\n')
                        removed_count += 1
                        print(f"✅ Removed from model_setting_dlc17.mbe")
            
            # 8. Remove from model_outline_dlc17 (by chr_id)
            if chr_id:
                file_path = dlc_data / "model_outline_dlc17.mbe" / "00_model_outline.csv"
                if file_path.exists():
                    rows = self.loader.load_csv(file_path)
                    original_count = len(rows)
                    filtered_rows = [rows[0]]  # Keep header
                    chr_id_clean = chr_id.strip('"')
                    for row in rows[1:]:
                        if len(row) > 0:
                            row_chr_id = row[0].strip('"')
                            if row_chr_id != chr_id_clean:
                                filtered_rows.append(row)
                    if len(filtered_rows) < original_count:
                        with open(file_path, 'w', encoding='utf-8') as f:
                            for row in filtered_rows:
                                f.write(','.join(row) + '\n')
                        removed_count += 1
                        print(f"✅ Removed from model_outline_dlc17.mbe")
            
            # 9. Remove from lod_chara_dlc17 (both files)
            if chr_id:
                # 00_lod.csv
                file_path = dlc_data / "lod_chara_dlc17.mbe" / "00_lod.csv"
                if file_path.exists():
                    rows = self.loader.load_csv(file_path)
                    original_count = len(rows)
                    filtered_rows = [rows[0]]  # Keep header
                    chr_id_clean = chr_id.strip('"')
                    for row in rows[1:]:
                        if len(row) > 0:
                            row_chr_id = row[0].strip('"')
                            if row_chr_id != chr_id_clean:
                                filtered_rows.append(row)
                    if len(filtered_rows) < original_count:
                        with open(file_path, 'w', encoding='utf-8') as f:
                            for row in filtered_rows:
                                f.write(','.join(row) + '\n')
                        removed_count += 1
                        print(f"✅ Removed from lod_chara_dlc17.mbe (00_lod.csv)")
                
                # 01_lod_model.csv
                file_path = dlc_data / "lod_chara_dlc17.mbe" / "01_lod_model.csv"
                if file_path.exists():
                    rows = self.loader.load_csv(file_path)
                    original_count = len(rows)
                    filtered_rows = [rows[0]]  # Keep header
                    chr_id_clean = chr_id.strip('"')
                    chr_prefix = f"{chr_id_clean}_"
                    for row in rows[1:]:
                        if len(row) > 0:
                            row_key = row[0].strip('"')
                            if not row_key.startswith(chr_prefix):
                                filtered_rows.append(row)
                    if len(filtered_rows) < original_count:
                        with open(file_path, 'w', encoding='utf-8') as f:
                            for row in filtered_rows:
                                f.write(','.join(row) + '\n')
                        removed_count += 1
                        print(f"✅ Removed from lod_chara_dlc17.mbe (01_lod_model.csv)")
            
            if removed_count > 0:
                print(f"✅ Successfully removed Digimon ID {digimon_id} from {removed_count} DLC file(s)!")
                return True
            else:
                print(f"⚠️ No entries found to remove for Digimon ID {digimon_id}")
                return False
            
        except Exception as e:
            print(f"Error removing Digimon from DLC: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _save_to_dlc_char_info(self, digimon: DigimonData, dlc_data: Path) -> bool:
        """Save to char_info_dlc17.mbe/00_char_info.csv"""
        try:
            file_path = dlc_data / "char_info_dlc17.mbe" / "00_char_info.csv"
            
            # Load or create file
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
            else:
                # Create header
                rows = [['string2 0', 'empty 1', 'empty 2', 'string2 3', 'string2 4', 'empty 5', 'int 6', 'int 7', 'string2 8', 'int 9', 'string2 10', 'int 11', 'string2 12', 'int 13']]
            
            # Calculate column 4 value based on chr_id
            # Extract number from chr_id (e.g., "chr1000" -> 1000)
            chr_id_clean = digimon.chr_id.strip('"')
            chr_id_number = 0
            try:
                # Extract number after "chr"
                if chr_id_clean.startswith('chr'):
                    chr_id_number = int(chr_id_clean[3:])
                else:
                    # Fallback: try to extract any number
                    import re
                    match = re.search(r'\d+', chr_id_clean)
                    if match:
                        chr_id_number = int(match.group())
            except:
                chr_id_number = digimon.id
            
            # Calculate column 4: if chr_id >= 1000, add 9000; otherwise add 1000
            if chr_id_number >= 1000:
                column_4_value = chr_id_number + 9000  # chr1000 -> 10000, chr1001 -> 10001, etc.
            else:
                column_4_value = chr_id_number + 1000  # chr143 -> 1143, chr175 -> 1175, etc.
            
            # Use digimon's loaded char_info_data if available
            if digimon.char_info_data:
                char_info = digimon.char_info_data
                new_row = [
                    f'"{digimon.char_key}"',
                    char_info.get('empty1', '""'),
                    char_info.get('empty2', '""'),
                    f'"{digimon.chr_id}"',
                    f'"{column_4_value}"',
                    char_info.get('empty3', '""'),
                    str(char_info.get('gender_flag', 0)),
                    str(char_info.get('flag1', 0)),
                    char_info.get('motion_ref', '""'),
                    str(char_info.get('flag2', 0)),
                    char_info.get('model_ref', '""'),
                    str(char_info.get('flag3', 0)),
                    char_info.get('empty4', '""'),
                    str(char_info.get('flag4', 0))
                ]
            else:
                # Fallback: create basic entry
                new_row = [
                    f'"{digimon.char_key}"', '""', '""', f'"{digimon.chr_id}"',
                    f'"{column_4_value}"', '""', '0', '0', '""', '0', '""', '0', '""', '0'
                ]
            
            # Check if entry already exists
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == digimon.char_key:
                    # Update existing
                    rows[i] = new_row
                    entry_found = True
                    break
            
            if not entry_found:
                # Add new entry
                rows.append(new_row)
            
            # Write file
            with open(file_path, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to char_info_dlc17.mbe")
            return True
        except Exception as e:
            print(f"Error saving to char_info_dlc17: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _save_to_dlc_status(self, digimon: DigimonData, dlc_data: Path) -> bool:
        """Save to digimon_status_dlc17.mbe/00_digimon_status_data.csv"""
        try:
            file_path = dlc_data / "digimon_status_dlc17.mbe" / "00_digimon_status_data.csv"
            
            # Load or create file
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
            else:
                # Get header from base game file
                base_file = self.loader.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
                base_rows = self.loader.load_csv(base_file)
                rows = [base_rows[0]]  # Just the header
            
            headers = self.loader.headers["main/digimon_status.mbe/00_digimon_status_data.csv"]
            
            # Find the row for this digimon
            digimon_row_index = None
            for i, row in enumerate(rows[1:], 1):  # Skip header
                if len(row) > headers["id"] and row[0] == str(digimon.id):
                    digimon_row_index = i
                    break
            
            # If digimon not found, create a new row
            is_new_digimon = digimon_row_index is None
            if is_new_digimon:
                # Create a new row with the correct number of columns
                new_row = [""] * 136
                new_row[headers["id"]] = str(digimon.id)
                rows.append(new_row)
                digimon_row_index = len(rows) - 1
            
            # Update the row with new data (use same logic as save_digimon_data)
            row = rows[digimon_row_index]
            
            # Ensure row has enough columns
            while len(row) < 136:
                row.append("")
            
            # Basic data
            row[headers["strKey"]] = f'"{digimon.char_key}"'
            row[3] = f'"{digimon.chr_id}"'
            row[1] = '""'
            
            # Set specific fields (ONLY for new Digimon)
            if is_new_digimon:
                row[60] = "0"
                row[61] = "1"
                row[62] = "1"
                row[63] = "99"
                row[64] = "1"
                row[65] = "0"
                row[66] = "1"
                row[67] = "0"
                row[68] = "0"
                row[69] = '""'
                row[70] = "0"
                row[71] = "0"
                row[72] = "0"
                row[119] = "1"
                row[120] = "2"
                row[121] = "1"
                row[122] = "1"
                row[123] = "0"
                row[124] = "1"
                row[125] = "0"
                row[126] = "0"
                row[128] = "0"
                row[129] = "0"
                row[130] = "0"
                row[131] = "-1"
                row[133] = "-1"
                row[134] = "0"
                row[135] = "-1"
            
            # Empty fields with quotes
            empty_fields = [18, 73, 76, 79, 82, 85, 88, 91, 94, 97, 100, 103, 106, 109, 112, 115, 118, 127]
            for field_idx in empty_fields:
                if field_idx < len(row) and row[field_idx] == '':
                    row[field_idx] = '""'
            
            # Stage and type
            row[4] = str(digimon.stage_id)
            row[5] = "1"  # This field is always 1
            row[6] = str(digimon.type_id)
            
            # Columns 7-17: ELEMENTAL RESISTANCES (already set below, don't overwrite!)
            
            # Columns 19-59: Boolean flags (must be 0 or 1, never empty)
            for col_idx in range(19, 60):
                if col_idx < len(row):
                    if row[col_idx] == '' or row[col_idx] == '""':
                        row[col_idx] = "0"  # Default to 0 if not set
            
            row[headers["basePersonality"]] = str(digimon.personality_id)
            
            # Base stats
            row[headers["baseHP"]] = str(digimon.base_hp)
            row[headers["baseSP"]] = str(digimon.base_sp)
            row[headers["baseATK"]] = str(digimon.base_atk)
            row[headers["baseDEF"]] = str(digimon.base_def)
            row[headers["baseINT"]] = str(digimon.base_int)
            row[headers["baseSPI"]] = str(digimon.base_spi)
            row[headers["baseSPD"]] = str(digimon.base_spd)
            
            # Elemental resistances
            row[headers["resNull"]] = str(digimon.res_null)
            row[headers["resFire"]] = str(digimon.res_fire)
            row[headers["resWater"]] = str(digimon.res_water)
            row[headers["resIce"]] = str(digimon.res_ice)
            row[headers["resGrass"]] = str(digimon.res_grass)
            row[headers["resWind"]] = str(digimon.res_wind)
            row[headers["resElec"]] = str(digimon.res_elec)
            row[headers["resGround"]] = str(digimon.res_ground)
            row[headers["resSteel"]] = str(digimon.res_steel)
            row[headers["resLight"]] = str(digimon.res_light)
            row[headers["resDark"]] = str(digimon.res_dark)
            
            # Signature skills
            for i in range(1, 13):
                skill_id_key = f"signatureSkillId{i}"
                skill_slot_key = f"signatureSkillSlot{i}"
                if skill_id_key in headers and skill_slot_key in headers:
                    if i-1 < len(digimon.signature_skills):
                        skill_id = digimon.signature_skills[i-1]["id"]
                        skill_slot = digimon.signature_skills[i-1]["slot"]
                    else:
                        skill_id = 0
                        skill_slot = 3
                    row[headers[skill_id_key]] = str(skill_id)
                    row[headers[skill_slot_key]] = str(skill_slot)
            
            # Generic skills
            for i in range(1, 5):
                skill_id_key = f"gSkill{i}Id"
                skill_level_key = f"gSkill{i}Level"
                if skill_id_key in headers and skill_level_key in headers:
                    if i-1 < len(digimon.generic_skills):
                        skill_id = digimon.generic_skills[i-1]["id"]
                        skill_level = digimon.generic_skills[i-1]["level"]
                    else:
                        skill_id = 0
                        skill_level = 0
                    row[headers[skill_id_key]] = str(skill_id)
                    row[headers[skill_level_key]] = str(skill_level)
            
            # Traits (boolean flags starting at traitsBaseIdx)
            traits_start = headers["traitsBaseIdx"]
            for i, trait_value in enumerate(digimon.traits):
                if traits_start + i < len(row):
                    row[traits_start + i] = "1" if trait_value else "0"
            
            # Field guide and script IDs
            if "fieldGuideId" in headers:
                row[headers["fieldGuideId"]] = str(digimon.field_guide_id) if digimon.field_guide_id >= 0 else "-1"
            if "scriptId" in headers:
                row[headers["scriptId"]] = str(digimon.script_id) if digimon.script_id >= 0 else "-1"
            
            # Fill remaining empty integer/bool fields with defaults
            # Column 51: int field
            if not row[51] or row[51] == '""':
                row[51] = "0"
            
            # Columns 52-59: bool fields
            for col_idx in range(52, 60):
                if col_idx < len(row):
                    if not row[col_idx] or row[col_idx] == '""':
                        row[col_idx] = "0"
            
            # Columns 126-135: int fields at the end
            for col_idx in range(126, 136):
                if col_idx < len(row):
                    if not row[col_idx] or row[col_idx] == '""':
                        # Special handling for reference fields
                        if col_idx in [131, 133, 135]:
                            row[col_idx] = "-1"  # Reference fields default to -1
                        else:
                            row[col_idx] = "0"
            
            # Write file
            with open(file_path, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to digimon_status_dlc17.mbe")
            return True
        except Exception as e:
            print(f"Error saving to digimon_status_dlc17: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _save_to_dlc_evolution(self, digimon: DigimonData, dlc_data: Path) -> bool:
        """Save to evolution_dlc17.mbe/00_evolution_condition.csv and 01_evolution_to.csv"""
        try:
            # 1. Save evolution condition file
            cond_file_path = dlc_data / "evolution_dlc17.mbe" / "00_evolution_condition.csv"
            
            # Load or create condition file
            if cond_file_path.exists():
                cond_rows = self.loader.load_csv(cond_file_path)
            else:
                # Create header (30 columns based on DLC example)
                cond_rows = [['int 0', 'empty 1', 'int 2', 'int 3', 'int 4', 'int 5', 'int 6', 'int 7', 'int 8', 'int 9', 'int 10', 'int 11', 'int 12', 'int 13', 'int 14', 'int 15', 'int 16', 'int 17', 'empty 18', 'int 19', 'int 20', 'int 21', 'int 22', 'empty 23', 'int 24', 'empty 25', 'int 26', 'int 27', 'empty 28', 'int 29']]
            
            # Check if condition entry exists
            cond_entry_found = False
            for i, row in enumerate(cond_rows[1:], 1):
                if len(row) > 0 and row[0] == str(digimon.id):
                    cond_entry_found = True
                    break
            
            if not cond_entry_found:
                # Add minimal evolution condition entry
                cond_rows.append([str(digimon.id), '""', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '""', '0', '0', '0', '0', '""', '0', '""', '0', '0', '""', '0'])
            
            # Write condition file
            with open(cond_file_path, 'w', encoding='utf-8') as f:
                for row in cond_rows:
                    f.write(','.join(row) + '\n')
            
            # 2. Save evolution_to file (actual evolution paths)
            evo_to_file_path = dlc_data / "evolution_dlc17.mbe" / "01_evolution_to.csv"
            
            # Load or create evolution_to file
            if evo_to_file_path.exists():
                evo_to_rows = self.loader.load_csv(evo_to_file_path)
            else:
                # Create header - need to check format from base game
                base_evo_to = self.loader.data_path / "evolution.mbe" / "01_evolution_to.csv"
                if base_evo_to.exists():
                    base_rows = self.loader.load_csv(base_evo_to)
                    evo_to_rows = [base_rows[0]]  # Copy header from base game
                else:
                    # Fallback header (based on loading code: row[0]=evolution_id, row[1]=from_id, row[3]=to_id)
                    evo_to_rows = [['int 0', 'int 1', 'empty 2', 'int 3', 'int 4', 'int 5', 'int 6', 'int 7', 'int 8', 'int 9', 'int 10', 'int 11', 'int 12', 'int 13', 'int 14', 'int 15', 'int 16', 'int 17', 'empty 18', 'int 19', 'int 20', 'int 21', 'int 22', 'empty 23', 'int 24', 'empty 25', 'int 26', 'int 27', 'empty 28', 'int 29']]
            
            # Track ALL evolution IDs from the file to find the maximum
            all_evolution_ids = set()
            for row in evo_to_rows[1:]:
                if len(row) > 0 and row[0]:
                    try:
                        all_evolution_ids.add(int(row[0]))
                    except (ValueError, TypeError):
                        pass
            
            # Track existing evolution IDs from OTHER Digimon (not this one)
            # This allows us to reuse evolution IDs that belonged to this Digimon
            existing_evolution_ids = set()
            filtered_rows = [evo_to_rows[0]]  # Keep header
            for row in evo_to_rows[1:]:
                # Skip rows where this Digimon is the source (row[1]) or target (row[3])
                if len(row) > 3:
                    if row[1] != str(digimon.id) and row[3] != str(digimon.id):
                        filtered_rows.append(row)
                        # Track evolution IDs from other Digimon
                        if len(row) > 0 and row[0]:
                            try:
                                existing_evolution_ids.add(int(row[0]))
                            except (ValueError, TypeError):
                                pass
            
            # Find the next available evolution ID (use max from ALL IDs to ensure uniqueness)
            if all_evolution_ids:
                next_evolution_id = max(all_evolution_ids) + 1
            else:
                next_evolution_id = 1
            
            # Add evolution paths (where this Digimon evolves TO other Digimon)
            # Format: row[0]=evolution_id, row[1]=from_id (this Digimon), row[3]=to_id (target)
            for evo_path in digimon.evolution_paths:
                if evo_path.get('to_id'):
                    # Use raw_data if available, otherwise create new row
                    if evo_path.get('raw_data') and len(evo_path['raw_data']) >= len(evo_to_rows[0]):
                        new_row = evo_path['raw_data'].copy()
                        # Update from_id to this Digimon's ID
                        if len(new_row) > 1:
                            new_row[1] = str(digimon.id)
                        # Update to_id
                        if len(new_row) > 3:
                            new_row[3] = str(evo_path['to_id'])
                        # Update evolution_id if needed (use existing if valid, otherwise assign new)
                        if len(new_row) > 0:
                            existing_evo_id = evo_path.get('evolution_id', 0)
                            if existing_evo_id > 0 and existing_evo_id not in existing_evolution_ids:
                                new_row[0] = str(existing_evo_id)
                            else:
                                new_row[0] = str(next_evolution_id)
                                next_evolution_id += 1
                    else:
                        # Create new row with default format
                        num_cols = len(evo_to_rows[0])
                        new_row = ['0'] * num_cols
                        # Use existing evolution_id if valid, otherwise assign new unique ID
                        existing_evo_id = evo_path.get('evolution_id', 0)
                        if existing_evo_id > 0 and existing_evo_id not in existing_evolution_ids:
                            new_row[0] = str(existing_evo_id)
                        else:
                            new_row[0] = str(next_evolution_id)
                            next_evolution_id += 1
                        new_row[1] = str(digimon.id)  # from_id
                        new_row[2] = '""'  # empty column
                        new_row[3] = str(evo_path['to_id'])  # to_id
                        # Fill rest with defaults
                        for i in range(4, num_cols):
                            if i in [18, 23, 25, 28]:  # empty columns
                                new_row[i] = '""'
                            else:
                                new_row[i] = '0'
                    
                    filtered_rows.append(new_row)
            
            # Add de-evolution sources (where other Digimon evolve TO this Digimon)
            # Format: row[0]=evolution_id, row[1]=from_id (source), row[3]=to_id (this Digimon)
            for deevo_source in digimon.deevolution_sources:
                if deevo_source.get('from_id'):
                    # Use raw_data if available, otherwise create new row
                    if deevo_source.get('raw_data') and len(deevo_source['raw_data']) >= len(evo_to_rows[0]):
                        new_row = deevo_source['raw_data'].copy()
                        # Update from_id
                        if len(new_row) > 1:
                            new_row[1] = str(deevo_source['from_id'])
                        # Update to_id to this Digimon's ID
                        if len(new_row) > 3:
                            new_row[3] = str(digimon.id)
                        # Update evolution_id if needed (use existing if valid, otherwise assign new)
                        if len(new_row) > 0:
                            existing_evo_id = deevo_source.get('evolution_id', 0)
                            if existing_evo_id > 0 and existing_evo_id not in existing_evolution_ids:
                                new_row[0] = str(existing_evo_id)
                            else:
                                new_row[0] = str(next_evolution_id)
                                next_evolution_id += 1
                    else:
                        # Create new row with default format
                        num_cols = len(evo_to_rows[0])
                        new_row = ['0'] * num_cols
                        # Use existing evolution_id if valid, otherwise assign new unique ID
                        existing_evo_id = deevo_source.get('evolution_id', 0)
                        if existing_evo_id > 0 and existing_evo_id not in existing_evolution_ids:
                            new_row[0] = str(existing_evo_id)
                        else:
                            new_row[0] = str(next_evolution_id)
                            next_evolution_id += 1
                        new_row[1] = str(deevo_source['from_id'])  # from_id
                        new_row[2] = '""'  # empty column
                        new_row[3] = str(digimon.id)  # to_id
                        # Fill rest with defaults
                        for i in range(4, num_cols):
                            if i in [18, 23, 25, 28]:  # empty columns
                                new_row[i] = '""'
                            else:
                                new_row[i] = '0'
                    
                    filtered_rows.append(new_row)
            
            # Write evolution_to file
            with open(evo_to_file_path, 'w', encoding='utf-8') as f:
                for row in filtered_rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to evolution_dlc17.mbe (condition + evolution paths)")
            return True
        except Exception as e:
            print(f"Error saving to evolution_dlc17: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _save_to_dlc_char_name(self, digimon: DigimonData, dlc_text: Path) -> bool:
        """Save to char_name_dlc17.mbe/00_Sheet1.csv"""
        try:
            file_path = dlc_text / "char_name_dlc17.mbe" / "00_Sheet1.csv"
            
            # Load or create file
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
            else:
                rows = [['string2 0', 'string 1']]
            
            # Check if entry exists
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == digimon.char_key:
                    rows[i] = [f'"{digimon.char_key}"', f'"{digimon.name}"']
                    entry_found = True
                    break
            
            if not entry_found:
                rows.append([f'"{digimon.char_key}"', f'"{digimon.name}"'])
            
            # Write file
            with open(file_path, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            # Flush to ensure file is written
            import os
            if hasattr(os, 'sync'):
                os.sync()
            
            print(f"✅ Saved to char_name_dlc17.mbe")
            return True
        except Exception as e:
            print(f"Error saving to char_name_dlc17: {e}")
            return False
    
    def _save_to_dlc_profile(self, digimon: DigimonData, dlc_text: Path) -> bool:
        """Save to digimon_profile_dlc17.mbe/00_Sheet1.csv"""
        try:
            file_path = dlc_text / "digimon_profile_dlc17.mbe" / "00_Sheet1.csv"
            
            # Load or create file
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
            else:
                rows = [['string2 0', 'string 1']]
            
            profile_key = f'digimon_{digimon.id:04d}_profile'
            profile_text = digimon.profile_text if digimon.profile_text else f"Profile for {digimon.name}"
            
            # Check if entry exists
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == profile_key:
                    rows[i] = [f'"{profile_key}"', f'"{profile_text}"']
                    entry_found = True
                    break
            
            if not entry_found:
                rows.append([f'"{profile_key}"', f'"{profile_text}"'])
            
            # Write file
            with open(file_path, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to digimon_profile_dlc17.mbe")
            return True
        except Exception as e:
            print(f"Error saving to digimon_profile_dlc17: {e}")
            return False
    
    def _save_to_dlc_animation(self, digimon: DigimonData, dlc_data: Path, animation_ref_chr_id: str) -> bool:
        """Save to anim_setting_dlc17.mbe/01_same_animation_data.csv"""
        try:
            file_path = dlc_data / "anim_setting_dlc17.mbe" / "01_same_animation_data.csv"
            
            # Load or create file
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
            else:
                rows = [['string2 0', 'string2 1']]
            
            # Use the animation_ref_chr_id passed from the editor
            # Format: "chr1000","chr805" (NEW chr_id uses chr805 animations)
            animation_source = animation_ref_chr_id if animation_ref_chr_id else digimon.chr_id
            
            # Check if entry exists
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == digimon.chr_id:
                    # Update existing entry
                    rows[i] = [f'"{digimon.chr_id}"', f'"{animation_source}"']
                    entry_found = True
                    break
            
            if not entry_found:
                # Add new entry - NEW chr_id points to TEMPLATE chr_id for animations
                rows.append([f'"{digimon.chr_id}"', f'"{animation_source}"'])
            
            # Write file
            with open(file_path, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to anim_setting_dlc17.mbe (animations from {animation_source})")
            return True
        except Exception as e:
            print(f"Error saving to anim_setting_dlc17: {e}")
            return False
    
    def _save_to_dlc_model_setting(self, digimon: DigimonData, dlc_data: Path, animation_ref_chr_id: str = None) -> bool:
        """Save to model_setting_dlc17.mbe/00_model_setting.csv"""
        try:
            file_path = dlc_data / "model_setting_dlc17.mbe" / "00_model_setting.csv"
            
            # Load or create file
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
            else:
                # Get header from base game file
                base_file = self.loader.data_path / "model_setting.mbe" / "00_model_setting.csv"
                base_rows = self.loader.load_csv(base_file)
                rows = [base_rows[0]]  # Just the header
            
            # Use digimon's loaded model_setting_data if available
            template_row = None
            if digimon.model_setting_data and digimon.model_setting_data.get('raw_data'):
                # Use raw_data directly if available (preserves all columns)
                template_row = digimon.model_setting_data['raw_data'].copy()
                # Update chr_id
                if len(template_row) > 0:
                    template_row[0] = f'"{digimon.chr_id}"'
                # Update model_id and motion_id if they were changed in the UI
                if len(template_row) > 8:
                    template_row[8] = f'"{digimon.motion_id}"' if digimon.motion_id else '""'
                if len(template_row) > 10:
                    template_row[10] = f'"{digimon.model_id}"' if digimon.model_id else '""'
            elif digimon.model_setting_data and digimon.model_setting_data.get('chr_id'):
                # Reconstruct row from loaded data
                model_data = digimon.model_setting_data
                # Use updated model_id and motion_id from UI if available, otherwise use loaded values
                motion_ref = f'"{digimon.motion_id}"' if digimon.motion_id else model_data.get('motion_ref', '""')
                model_ref = f'"{digimon.model_id}"' if digimon.model_id else model_data.get('model_ref', '""')
                template_row = [
                    f'"{digimon.chr_id}"',
                    model_data.get('empty1', '""'),
                    model_data.get('empty2', '""'),
                    model_data.get('chr_id', f'"{digimon.chr_id}"'),
                    model_data.get('numeric_id', '""'),
                    model_data.get('empty3', '""'),
                    str(model_data.get('gender_flag', 0)),
                    str(model_data.get('flag1', 0)),
                    motion_ref,
                    str(model_data.get('flag2', 0)),
                    model_ref,
                    str(model_data.get('flag3', 0)),
                    model_data.get('empty4', '""'),
                    str(model_data.get('flag4', 0))
                ]
                # Pad to expected length if needed
                while len(template_row) < 82:
                    template_row.append('""')
            else:
                # Find template using animation_ref_chr_id (e.g., chr805) instead of digimon.chr_id (e.g., chr1000)
                template_chr_id = animation_ref_chr_id.strip('"') if animation_ref_chr_id else digimon.chr_id.strip('"')
                
                # First check base game file
                base_file = self.loader.data_path / "model_setting.mbe" / "00_model_setting.csv"
                if base_file.exists():
                    base_rows = self.loader.load_csv(base_file)
                    for row in base_rows[1:]:
                        if len(row) > 0 and row[0].strip('"') == template_chr_id:
                            template_row = row.copy()
                            break
                
                # Also check DLC files if not found in base game
                if not template_row:
                    dlc_file = dlc_data / "model_setting_dlc17.mbe" / "00_model_setting.csv"
                    if dlc_file.exists():
                        dlc_rows = self.loader.load_csv(dlc_file)
                        for row in dlc_rows[1:]:
                            if len(row) > 0 and row[0].strip('"') == template_chr_id:
                                template_row = row.copy()
                                break
            
            if not template_row:
                print(f"⚠️ Warning: No model_setting entry found for template {animation_ref_chr_id or digimon.chr_id}, using defaults")
                # Create minimal row with chr_id
                template_row = [f'"{digimon.chr_id}"'] + ['""'] * 81
            else:
                # Update chr_id in the copied row (keep template's settings)
                template_row[0] = f'"{digimon.chr_id}"'
            
            # Update model_id and motion_id if they were changed in the UI (if not already updated above)
            # Based on model_setting structure: column 8 is motion_ref, column 10 is model_ref
            if len(template_row) > 8:
                template_row[8] = f'"{digimon.motion_id}"' if digimon.motion_id else '""'
            if len(template_row) > 10:
                template_row[10] = f'"{digimon.model_id}"' if digimon.model_id else '""'
            
            # Check if entry exists in DLC file
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == digimon.chr_id:
                    rows[i] = template_row
                    entry_found = True
                    break
            
            if not entry_found:
                rows.append(template_row)
            
            # Write file
            with open(file_path, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to model_setting_dlc17.mbe")
            return True
        except Exception as e:
            print(f"Error saving to model_setting_dlc17: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _save_to_dlc_model_outline(self, digimon: DigimonData, dlc_data: Path) -> bool:
        """Save to model_outline_dlc17.mbe/00_model_outline_battle.csv"""
        try:
            file_path = dlc_data / "model_outline_dlc17.mbe" / "00_model_outline_battle.csv"
            
            # Load or create file
            if file_path.exists():
                rows = self.loader.load_csv(file_path)
            else:
                rows = [['string2 0', 'float 1', 'float 2']]
            
            # Find the template chr_id entry in base game file
            base_file = self.loader.data_path / "model_outline.mbe" / "00_model_outline_battle.csv"
            base_rows = self.loader.load_csv(base_file)
            
            template_row = None
            for row in base_rows[1:]:
                if len(row) > 0 and row[0].strip('"') == digimon.chr_id:
                    template_row = row.copy()
                    break
            
            if not template_row:
                # Create default outline settings
                template_row = [f'"{digimon.chr_id}"', '-0.003', '-0.003']
            else:
                template_row[0] = f'"{digimon.chr_id}"'
            
            # Check if entry exists in DLC file
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == digimon.chr_id:
                    rows[i] = template_row
                    entry_found = True
                    break
            
            if not entry_found:
                rows.append(template_row)
            
            # Write file
            with open(file_path, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to model_outline_dlc17.mbe")
            return True
        except Exception as e:
            print(f"Error saving to model_outline_dlc17: {e}")
            return False
    
    def _save_to_dlc_lod(self, digimon: DigimonData, dlc_data: Path) -> bool:
        """Save to lod_chara_dlc17.mbe (both 00_lod.csv and 01_lod_model.csv)"""
        try:
            # File 1: 00_lod.csv
            lod_file = dlc_data / "lod_chara_dlc17.mbe" / "00_lod.csv"
            
            if lod_file.exists():
                rows = self.loader.load_csv(lod_file)
            else:
                rows = [['string2 0', 'float 1', 'float 2', 'float 3', 'float 4', 'float 5', 'float 6', 'float 7', 'float 8', 'float 9', 'float 10']]
            
            # Use digimon's loaded lod_data if available
            template_row = None
            if digimon.lod_data:
                lod_data = digimon.lod_data
                template_row = [
                    f'"{digimon.chr_id}"',
                    str(lod_data.get('lod_distance_1', 20)),
                    str(lod_data.get('lod_distance_2', 65)),
                    str(lod_data.get('lod_distance_3', 500)),
                    '0', '0', '0', '0', '0', '0', '0'
                ]
            else:
                # Fallback: Find template entry in base game or DLC
                base_file = self.loader.data_path / "lod_chara.mbe" / "00_lod.csv"
                if base_file.exists():
                    base_rows = self.loader.load_csv(base_file)
                    template_chr_id = digimon.chr_id
                    for row in base_rows[1:]:
                        if len(row) > 0 and row[0].strip('"') == template_chr_id:
                            template_row = row.copy()
                            break
                
                # Also check DLC files
                if not template_row:
                    dlc_file = dlc_data / "lod_chara_dlc17.mbe" / "00_lod.csv"
                    if dlc_file.exists():
                        dlc_rows = self.loader.load_csv(dlc_file)
                        template_chr_id = digimon.chr_id
                        for row in dlc_rows[1:]:
                            if len(row) > 0 and row[0].strip('"') == template_chr_id:
                                template_row = row.copy()
                                break
            
            if not template_row:
                # Default LOD settings
                template_row = [f'"{digimon.chr_id}"', '20', '65', '500', '0', '0', '0', '0', '0', '0', '0']
            else:
                template_row[0] = f'"{digimon.chr_id}"'
            
            # Update or add entry
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == digimon.chr_id:
                    rows[i] = template_row
                    entry_found = True
                    break
            
            if not entry_found:
                rows.append(template_row)
            
            # Write 00_lod.csv
            with open(lod_file, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            # File 2: 01_lod_model.csv
            lod_model_file = dlc_data / "lod_chara_dlc17.mbe" / "01_lod_model.csv"
            
            if lod_model_file.exists():
                rows = self.loader.load_csv(lod_model_file)
            else:
                rows = [['string2 0', 'string2 1', 'string2 2', 'string2 3', 'string2 4', 'string2 5', 'string2 6', 'string2 7', 'string2 8', 'string2 9', 'string2 10']]
            
            # Use digimon's loaded lod_model_data if available
            template_row = None
            if digimon.lod_model_data:
                lod_model = digimon.lod_model_data
                template_row = [
                    f'"{digimon.chr_id}"',
                    lod_model.get('model_1', '""'),
                    lod_model.get('model_2', '""'),
                    lod_model.get('model_3', '""'),
                    lod_model.get('model_4', '""'),
                    lod_model.get('model_5', '""'),
                    lod_model.get('model_6', '""'),
                    lod_model.get('model_7', '""'),
                    lod_model.get('model_8', '""'),
                    lod_model.get('model_9', '""'),
                    lod_model.get('model_10', '""')
                ]
            else:
                # Fallback: Find template in base game or DLC
                base_file = self.loader.data_path / "lod_chara.mbe" / "01_lod_model.csv"
                if base_file.exists():
                    base_rows = self.loader.load_csv(base_file)
                    template_chr_id = digimon.chr_id
                    for row in base_rows[1:]:
                        if len(row) > 0 and row[0].strip('"') == template_chr_id:
                            template_row = row.copy()
                            break
                
                # Also check DLC files
                if not template_row:
                    dlc_file = dlc_data / "lod_chara_dlc17.mbe" / "01_lod_model.csv"
                    if dlc_file.exists():
                        dlc_rows = self.loader.load_csv(dlc_file)
                        template_chr_id = digimon.chr_id
                        for row in dlc_rows[1:]:
                            if len(row) > 0 and row[0].strip('"') == template_chr_id:
                                template_row = row.copy()
                                break
            
            if not template_row:
                # Default LOD model reference
                template_row = [f'"{digimon.chr_id}"', '""', f'"{digimon.chr_id}_LOD_2"', '""', '""', '""', '""', '""', '""', '""', '""']
            else:
                # Keep template's LOD model references (chr805_LOD_2, etc.)
                template_row[0] = f'"{digimon.chr_id}"'
            
            # Update or add entry
            entry_found = False
            for i, row in enumerate(rows[1:], 1):
                if len(row) > 0 and row[0].strip('"') == digimon.chr_id:
                    rows[i] = template_row
                    entry_found = True
                    break
            
            if not entry_found:
                rows.append(template_row)
            
            # Write 01_lod_model.csv
            with open(lod_model_file, 'w', encoding='utf-8') as f:
                for row in rows:
                    f.write(','.join(row) + '\n')
            
            print(f"✅ Saved to lod_chara_dlc17.mbe (both files)")
            return True
        except Exception as e:
            print(f"Error saving to lod_chara_dlc17: {e}")
            import traceback
            traceback.print_exc()
            return False
