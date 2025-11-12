# Guide: Adding New DLC to Digimon Time

**Complete guide for creating custom DLC packs and content expansion**

---

## Overview

DLC (Downloadable Content) in Digimon Time allows for content expansion including new Digimon, items, costumes, episodes, and more. This guide covers the entire DLC creation pipeline from file structure to integration.

**Estimated Files to Edit**: 10-50+ files (depending on DLC scope)

**Difficulty**: Advanced

---

## Step 1: Understanding DLC Architecture

### DLC Structure:
- **addcont_##.dx11/** - DLC content folders (## = DLC number)
- **dlc_info.mbe** - DLC registry and metadata
- **Patch integration** - How base game recognizes DLC

### DLC Types:
1. **Digimon DLC** - New Digimon species
2. **Item Packs** - Items, equipment, consumables
3. **Costume Packs** - Player/companion costumes
4. **Episode DLC** - Story episodes
5. **BGM DLC** - Music packs
6. **Dungeon DLC** - New areas/dungeons

---

## Step 2: DLC Registry (Core)

**Location**: `patch.dx11/data/dlc_info/dlc_info.mbe/000_dlc_info.csv`

**CSV Structure**: 18 columns (0-17)

**Header**:
```
int32 0,empty 1,string2 2,string2 3,string2 4,bool 5,bool 6,bool 7,bool 8,int32 9,int32 10,int32 11,int32 12,string2 13,string2 14,string2 15,string2 16,string2 17
```

### Column Meanings:

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | int32 | DLC ID | Unique DLC identifier (1-21) |
| 1 | empty | - | Always empty |
| 2 | string2 | Product Code | Internal product code |
| 3 | string2 | Store ID | Platform store identifier |
| 4 | string2 | App ID | Application/DLC ID |
| 5 | bool | Is Episode | true if story episode DLC |
| 6 | bool | Is BGM | true if music pack |
| 7 | bool | Is Visible | true if shown in DLC menu |
| 8 | bool | Auto Flag | Automatic unlock flag |
| 9 | int32 | Item ID | Item unlocked by DLC (0 if none) |
| 10-12 | int32 | Reserved | Usually 0 |
| 13 | string2 | DLC Flag | Main DLC indication flag |
| 14 | string2 | Patch Flag 1 | Patch requirement flag |
| 15 | string2 | Patch Flag 2 | Additional patch flag |
| 16 | string2 | Patch Flag 3 | Additional patch flag |
| 17 | string2 | Patch Flag 4 | Additional patch flag |

---

## Step 3: Existing DLC Analysis

### DLC 1-3: Story Episodes
```csv
1,,"DSTS0MISEPISODE1","9NW069WKXKHC","3524260",true,false,true,true,0,0,0,0,"FLAG_DLC_DLC001_IS_INDICATIONS","FLAG_DLC_PATCH001_IS_INDICATIONS","","",""
2,,"DSTS0MISEPISODE2","9NR7ZZ59CWC2","3524270",true,false,true,false,0,0,0,0,"FLAG_DLC_DLC002_IS_INDICATIONS","FLAG_DLC_PATCH001_IS_INDICATIONS","FLAG_DLC_PATCH002_IS_INDICATIONS","",""
3,,"DSTS0MISEPISODE3","9PFPJVRJPHJG","3524290",true,false,true,true,0,0,0,0,"FLAG_DLC_DLC003_IS_INDICATIONS","FLAG_DLC_PATCH001_IS_INDICATIONS","FLAG_DLC_PATCH002_IS_INDICATIONS","FLAG_DLC_PATCH003_IS_INDICATIONS",""
```

### DLC 5: Item Pack (Golden Moai)
```csv
5,,"DSTS0ITMGOLDMOAI","9NLZGK7VZFJH","3524250",false,false,false,false,0,0,0,0,"","","","",""
```

### DLC 6: Digimon Pack (Agumon Black & Gabumon Black)
```csv
6,,"DSTS0CHASPAGUGAB","9MWNPGTZ0B78","3524310",false,false,false,false,0,0,0,0,"FLAG_DLC06_IS_INDICATIONS","","","",""
```

### DLC 7: Costume (Public Safety)
```csv
7,,"DSTS0COSPUBSAFE0","9MWRSVVBR08L","3524350",false,false,false,false,806,0,0,0,"","","","",""
```
- Column 9: **806** = Item ID that unlocks costume

### DLC 8-9: BGM Packs
```csv
8,,"DSTS0BGMCYSLEUTH","9PPJKMRMXQ3B","3524360",false,true,false,false,0,0,0,0,"","","","",""
9,,"DSTS0BGMANISONG0","9PN2RJGJW34Q","3524370",false,true,false,false,0,0,0,0,"","","","",""
```

### DLC 10: Dungeon Pack
```csv
10,,"DSTS0MAPDUNGEONS","9NM69DJZKHW4","3524380",false,false,false,false,0,0,0,0,"","","","",""
```

### DLC 12-15: Costume Packs
```csv
12,,"DSTS0COSCYSLEUTH","9N46WJPKXC4B","3524300",false,false,false,false,824,0,0,0,"","","","",""
13,,"DSTS0COSSWIMWEAR","9NVDFRCJSSTZ","3524320",false,false,false,false,826,0,0,0,"","","","",""
14,,"DSTS0COSCHILDREN","9N92412W0VC6","3524330",false,false,false,false,825,0,0,0,"","","","",""
15,,"DSTS0COSDIGIMON0","9NXP9QJ6KW84","3524340",false,false,false,false,827,0,0,0,"","","","",""
```

### DLC 17: Pre-order Bonus Pack
```csv
17,,"DSTS0ITMPOBONUS0","9PL6FGK5WHKT","3524240",true,false,false,false,805,0,0,0,"FLAG_DLC17_IS_INDICATIONS","","","",""
```

### DLC 21: Training Set
```csv
21,,"DSTS0ITMTRAINSET","9NGFTGP9BMVZ","",false,false,false,false,0,0,0,0,"","","","",""
```

---

## Step 4: DLC Folder Structure

### DLC Content Folder Pattern:
```
addcont_##.dx11/
├── data/
│   ├── [system]_dlc##/
│   │   └── [system]_dlc##.mbe/
│   │       └── ###_[filename].csv
│   └── ...
└── text/ (if needed)
    └── [localization files]
```

### Example: DLC 17 Structure
```
addcont_17.dx11/
├── data/
│   ├── aim_setup_dlc17/
│   ├── anim_setting_dlc17/
│   ├── battle_effect_dlc17/
│   ├── battle_skill_dlc17/
│   ├── card_info_dlc17/
│   ├── char_info_dlc17/
│   ├── digimon_status_dlc17/
│   ├── evolution_dlc17/
│   ├── item_dlc17/
│   └── model_costume_change_dlc17/
```

---

## Step 5: Creating a New DLC

### Example: Creating DLC 18 (Custom Mega Pack)

**Step 1**: Create registry entry in `000_dlc_info.csv`:
```csv
18,,"CUSTOM0MEGAPACK","CUSTOM18ID","9999999",false,false,true,false,900,0,0,0,"FLAG_DLC18_ACTIVE","","","",""
```

**Step 2**: Create folder structure:
```
addcont_18.dx11/
└── data/
    └── digimon_status_dlc18/
        └── digimon_status_dlc18.mbe/
            └── 000_digimon_status_data.csv
```

**Step 3**: Add Digimon data (see GUIDE_Adding_New_Digimon.md)

**Step 4**: Create unlock item (ID 900):
```csv
# In patch.dx11/data/item/item.mbe/000_item_parameter.csv
900,,,,900,0,0,70,999,0,0,true,false,0,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Step 5**: Add item name:
```csv
# In patch_text01.dx11/text/item_name/item_name.mbe/000_Sheet1.csv
"900","DLC 18: Mega Pack Key Item"
```

---

## Step 6: DLC Content Types

### 1. Digimon DLC

**Required Files**:
- `digimon_status_dlc##/000_digimon_status_data.csv`
- `evolution_dlc##/000_evolution_condition.csv`
- `evolution_dlc##/001_evolution_to.csv`
- `evolution_dlc##/002_chronodevolution.csv`
- `char_info_dlc##/000_char_info.csv`

**Example**: DLC 6 (Agumon Black & Gabumon Black)
```
addcont_06.dx11/data/digimon_status_dlc06/
```

### 2. Item Pack DLC

**Required Files**:
- `item_dlc##/000_item_parameter.csv`
- Item name/description text files

**Example**: DLC 5 (Golden Moai)
```
addcont_05.dx11/data/item_dlc05/
```

### 3. Costume Pack DLC

**Required Files**:
- `model_costume_change_dlc##/000_model_costume_change.csv`
- Model files (external)
- Unlock item

**Example**: DLC 12 (Cyber Sleuth Costumes)
```
addcont_12.dx11/data/model_costume_change_dlc12/
```

### 4. Episode DLC

**Required Files**:
- Quest data
- Dialogue/script files
- Enemy encounters
- Rewards

**Example**: DLC 1-3 (Missing Episodes)

### 5. Dungeon DLC

**Required Files**:
- Map data
- Enemy encounters
- Treasure placement
- Field settings

**Example**: DLC 10 (Dungeons of the Past)

---

## Step 7: DLC Flags System

### Flag Naming Convention:
- `FLAG_DLC_DLC###_IS_INDICATIONS` - Main DLC active flag
- `FLAG_DLC_PATCH###_IS_INDICATIONS` - Patch requirement flags
- `FLAG_DLC##_IS_INDICATIONS` - Simplified DLC flag

**Purpose**: Control when DLC content is accessible

**Example**:
```csv
# DLC requires Patch 1 and 2
"FLAG_DLC_DLC002_IS_INDICATIONS","FLAG_DLC_PATCH001_IS_INDICATIONS","FLAG_DLC_PATCH002_IS_INDICATIONS"
```

---

## Step 8: DLC Item Unlock System

### Pattern:
1. Create unlock item (columns 9 in dlc_info.csv)
2. Item is auto-added to inventory when DLC detected
3. Using/owning item unlocks DLC content

**Item ID Ranges for DLC**:
- **805**: DLC 17 unlock
- **806**: DLC 7 unlock
- **824**: DLC 12 unlock
- **825**: DLC 14 unlock
- **826**: DLC 13 unlock
- **827**: DLC 15 unlock
- **900+**: Safe for custom DLC unlocks

---

## Step 9: Multi-System DLC Integration

### Systems That Need DLC Variants:

1. **Digimon Status** → `digimon_status_dlc##`
2. **Evolution** → `evolution_dlc##`
3. **Items** → `item_dlc##`
4. **Battle Skills** → `battle_skill_dlc##`
5. **Battle Enemies** → `battle_enemy_dlc##`
6. **Costumes** → `model_costume_change_dlc##`
7. **Cards** → `card_info_dlc##`
8. **Character Info** → `char_info_dlc##`
9. **Animations** → `anim_setting_dlc##`
10. **Effects** → `battle_effect_dlc##`

Not all systems are needed for every DLC - only include what's relevant.

---

## Step 10: DLC Naming Conventions

### Product Codes:
- `DSTS0MIS` = Mission/Episode
- `DSTS0ITM` = Item pack
- `DSTS0CHA` = Character (Digimon) pack
- `DSTS0COS` = Costume pack
- `DSTS0BGM` = BGM/Music pack
- `DSTS0MAP` = Map/Dungeon pack

**Format**: `[GAME][TYPE][DESCRIPTOR]`

**Custom Example**: `CUSTOM0DIG999` (Custom Digimon Pack 999)

---

## Step 11: Testing DLC

### DLC Testing Checklist:

1. ✅ DLC appears in game's DLC menu
2. ✅ DLC can be "activated" (or auto-activates)
3. ✅ Unlock item is added to inventory (if applicable)
4. ✅ DLC content is accessible in-game
5. ✅ No conflicts with base game or other DLC
6. ✅ Save/load works with DLC active
7. ✅ Disabling DLC doesn't break saves
8. ✅ Flag system works correctly
9. ✅ All text/localization displays
10. ✅ No crashes or errors

---

## Step 12: DLC Dependencies

### Patch Requirements:
Some DLC requires specific patches:

**Example**:
```csv
# DLC 3 requires Patches 1, 2, and 3
"FLAG_DLC_PATCH001_IS_INDICATIONS","FLAG_DLC_PATCH002_IS_INDICATIONS","FLAG_DLC_PATCH003_IS_INDICATIONS"
```

**Define dependencies** in columns 14-17 of dlc_info.csv

---

## DLC ID Assignment

### Existing DLC IDs:
- 1-3: Episode DLC
- 5: Item pack (Moai)
- 6: Digimon pack (Agumon Black/Gabumon Black)
- 7: Costume (Public Safety)
- 8-9: BGM packs
- 10: Dungeon pack
- 12-15: Costume packs
- 17: Pre-order bonus
- 21: Training set

### Safe Custom IDs:
- **18-20**: Available
- **22-99**: Safe for custom DLC

---

## Complete DLC Creation Template

### Minimal DLC (Item Pack):

**1. dlc_info entry**:
```csv
50,,"CUSTOM0ITEMPACK1","CUSTOM50","",false,false,true,false,950,0,0,0,"FLAG_DLC50_ACTIVE","","","",""
```

**2. Create folder**:
```
addcont_50.dx11/
└── data/
    └── item_dlc50/
        └── item_dlc50.mbe/
            └── 000_item_parameter.csv
```

**3. Add items** (see GUIDE_Adding_New_Items.md)

**4. Create unlock item**:
```csv
# 000_item_parameter.csv (base game)
950,,,,950,0,0,70,999,0,0,true,false,0,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**5. Add localization**:
```csv
# item_name.mbe
"950","DLC 50: Custom Item Pack"
```

---

## Tips & Warnings

1. **Use unique DLC IDs** - Don't conflict with existing DLC (1-21)
2. **Test with/without DLC** - Ensure base game still works
3. **Flag system is critical** - Incorrect flags break DLC detection
4. **Item unlock pattern** - Follow existing DLC unlock item patterns
5. **Folder naming must match** - Use `_dlc##` suffix consistently
6. **Store IDs are platform-specific** - Use dummy IDs for custom DLC
7. **Backup everything** - DLC integration can break saves if done wrong
8. **Dependencies matter** - Document any patch/DLC requirements

---

## Platform Store IDs

**⚠️ NOTE**: Store IDs (column 3) and App IDs (column 4) are platform-specific:
- Steam: Numeric App ID
- Console: Platform-specific code
- Custom/Mod: Use dummy values

**For custom DLC**: Leave empty or use placeholder like "CUSTOM##ID"

---

## Quick Reference: New DLC Checklist

For each new DLC:

- [ ] Choose unique DLC ID (18-99)
- [ ] Create registry entry in dlc_info.csv
- [ ] Create `addcont_##.dx11/` folder structure
- [ ] Add content files in appropriate `_dlc##/` folders
- [ ] Create unlock item (if needed)
- [ ] Add DLC flags (if needed)
- [ ] Test DLC activation
- [ ] Test content accessibility
- [ ] Test save/load compatibility
- [ ] Document dependencies

---

**End of Guide**

