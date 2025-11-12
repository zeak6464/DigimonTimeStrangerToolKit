# Guide: Adding New Costumes to Digimon Time

**Complete guide for creating custom player costumes and outfit changes**

---

## Overview

Costumes in Digimon Time allow players to change the appearance of their character and companions. This system includes base game costumes and DLC costume packs.

**Estimated Files to Edit**: 2-4 files per costume

**Difficulty**: Advanced (requires model files)

---

## Step 1: Understanding Costume System

### Costume Components:
1. **Model Costume Change**: Defines costume IDs and model references
2. **Model References**: Links to actual 3D model files
3. **DLC Integration**: Optional DLC-exclusive costumes
4. **Flag System**: Unlocking costumes via game flags

### Costume Types:
- **Player Costumes** (Male/Female)
- **Heroine Costumes**
- **Digimon Costumes** (Aegiomon, etc.)

---

## Step 2: Core Costume Data

**Base Game Location**: `app_0.dx11/data/model_costume_change/model_costume_change.mbe/`

**DLC Locations**:
- DLC 12: `addcont_12.dx11/data/model_costume_change_dlc12/`
- DLC 17: `addcont_17.dx11/data/model_costume_change_dlc17/`

### Files:
1. `000_model_defined_in_saved_data.csv` - Saved data definitions
2. `001_model_costume_change.csv` - Costume definitions ⭐ MAIN FILE
3. `002_model_change_by_flag.csv` - Flag-based costume changes

---

## Step 3: Model Costume Change (Main File)

**Location**: `app_0.dx11/data/model_costume_change/model_costume_change.mbe/001_model_costume_change.csv`

**CSV Structure**: 8 columns (0-7)

**Header**:
```
string3 0,string3 1,int32 2,string3 3,string3 4,string3 5,string3 6,empty 7
```

### Column Meanings:

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | string3 | Costume ID | Unique identifier (*CharacterName_#) |
| 1 | string3 | Base Character | Base character reference |
| 2 | int32 | Costume Number | Costume index (0, 1, 2, ...) |
| 3 | string3 | Model A | Model file reference |
| 4 | string3 | Model B | Alternate model file reference |
| 5 | string3 | Model C | Additional model (usually empty) |
| 6 | string3 | Model D | Primary display model |
| 7 | empty | - | Always empty |

---

## Step 4: Costume Entry Examples

### Male Player Costumes:

**Default Costume (ID 0)**:
```csv
"*MalePlayer_0","*MalePlayer",0,"pc001aa010101","pc001ca010101","","pc001ca010101",
```

**Costume 1**:
```csv
"*MalePlayer_1","*MalePlayer",1,"pc001ea010101","pc001fa010101","","pc001fa010101",
```

**Costume 2**:
```csv
"*MalePlayer_2","*MalePlayer",2,"pc001ea020101","pc001fa020101","","pc001fa020101",
```

### Female Player Costumes:

**Default Costume (ID 0)**:
```csv
"*FemalePlayer_0","*FemalePlayer",0,"pc002aa010101","pc002ca010101","","pc002ca010101",
```

**Costume 1**:
```csv
"*FemalePlayer_1","*FemalePlayer",1,"pc002ea010101","pc002fa010101","","pc002fa010101",
```

### Heroine Costumes:

**Default**:
```csv
"*Heroine_0","*Heroine",0,"npc001aa010101","npc001ca010101","","npc001ca010101",
```

**Costume 1**:
```csv
"*Heroine_1","*Heroine",1,"npc001ea010101","npc001fa010101","","npc001fa010101",
```

### Digimon Companion Costumes:

**Aegiomon Default**:
```csv
"*Aegiomon_0","*Aegiomon",0,"chr183ea010101","chr183ea010101","","chr183ea010101",
```

**AegiomonNoCap (without cap)**:
```csv
"*AegiomonNoCap_0","*AegiomonNoCap",0,"chr183ea020101","chr183ea020101","","chr183ea020101",
```

---

## Step 5: Model File Naming Convention

### Pattern Analysis:

**Player Models**:
- `pc001` = Male Player
- `pc002` = Female Player
- Format: `pc[ID][variant][costume][version]`

**NPC Models**:
- `npc001` = Heroine
- Format: `npc[ID][variant][costume][version]`

**Digimon Models**:
- `chr183` = Aegiomon
- Format: `chr[ID][variant][costume][version]`

### Variant Codes:
- `aa` = Base variant A
- `ca` = Common variant C
- `ea` = Extended variant E
- `fa` = Full variant F
- `ia` = Special variant I
- `ja` = Special variant J

### Costume Number:
- `010101` = Costume 1
- `020101` = Costume 2
- `030101` = Costume 3
- etc.

---

## Step 6: Creating a New Costume

### Example: Adding Costume 20 for Male Player

**Step 1**: Add to `001_model_costume_change.csv`:
```csv
"*MalePlayer_20","*MalePlayer",20,"pc001ea200101","pc001fa200101","","pc001fa200101",
```

**Step 2**: Create/reference model files:
- `pc001ea200101` (model file A)
- `pc001fa200101` (model file B and display)

**Step 3** (Optional): Add unlock flag in `002_model_change_by_flag.csv`

---

## Step 7: DLC Costumes

### DLC 12 Costumes (Cyber Sleuth themed):

**Location**: `addcont_12.dx11/data/model_costume_change_dlc12/model_costume_change_dlc12.mbe/000_model_costume_change.csv`

**Example**:
```csv
"*MalePlayer_23","*MalePlayer",23,"pc001ka010101","pc001la010101","","pc001la010101",
"*FemalePlayer_23","*FemalePlayer",23,"pc002ka010101","pc002la010101","","pc002la010101",
"*Heroine_23","*Heroine",23,"npc001ka010101","npc001la010101","","npc001la010101",
"*Aegiomon_23","*Aegiomon",23,"chr183ka010101","chr183ka010101","","chr183ka010101",
"*AegiomonNoCap_23","*AegiomonNoCap",23,"chr183ka020101","chr183ka020101","","chr183ka020101",
```

**DLC Variant Codes**:
- `ka` = DLC variant K
- `la` = DLC variant L

### DLC 17 Costumes (Pre-order bonus):

**Location**: `addcont_17.dx11/data/model_costume_change_dlc17/model_costume_change_dlc17.mbe/000_model_costume_change.csv`

**Example**:
```csv
"*MalePlayer_4","*MalePlayer",4,"pc001ga010101","pc001ha010101","","pc001ha010101",
"*FemalePlayer_4","*FemalePlayer",4,"pc002ga010101","pc002ha010101","","pc002ha010101",
```

**DLC 17 Variant Codes**:
- `ga` = DLC variant G
- `ha` = DLC variant H

---

## Step 8: Model Files (Advanced)

**⚠️ WARNING**: This guide covers CSV data only. Actual 3D model creation requires:

1. **3D Modeling Software** (Blender, Maya, etc.)
2. **Game Model Format** (proprietary format)
3. **Texture Files** (DDS or game-specific format)
4. **Rigging/Skeleton** (must match base character)
5. **Animation Compatibility** (must work with existing animations)

**Recommendation**: Recolor or modify existing models rather than creating new ones from scratch.

---

## Step 9: Flag-Based Costume Changes

**Location**: `002_model_change_by_flag.csv`

**Purpose**: Automatically change costumes based on game flags/events

**Example**:
```csv
"*Test1","*FemalePlayer_1","FLAG_TEST_COSTUME_UNLOCK"
"*Aegiomon","*Aegiomon_1","FLAG_AEGIOMON_SPECIAL"
```

**Format**:
- Column 0: Change ID
- Column 1: Target costume
- Column 2: Game flag that triggers change

---

## Step 10: DLC Info Integration

**Location**: `patch.dx11/data/dlc_info/dlc_info.mbe/000_dlc_info.csv`

**Link costume to DLC** by specifying item ID:

**Example from DLC 12** (Cyber Sleuth Costume):
```csv
12,,"DSTS0COSCYSLEUTH","9N46WJPKXC4B","3524300",false,false,false,false,824,0,0,0,"","","",""
```
- Column 9: **824** = Item ID that unlocks the costume

**Item 824** in `item.mbe` then references the costume unlock.

---

## Step 11: Saved Data Definition

**Location**: `000_model_defined_in_saved_data.csv`

**Purpose**: Defines which character models are saved in player save data

**Example**:
```csv
"*MalePlayer","*MalePlayer_0","*MalePlayer_1","*MalePlayer_2","*MalePlayer_3","*MalePlayer_4","*MalePlayer_5"
"*FemalePlayer","*FemalePlayer_0","*FemalePlayer_1","*FemalePlayer_2","*FemalePlayer_3","*FemalePlayer_4"
"*Heroine","*Heroine_0","*Heroine_1","*Heroine_2","*Heroine_3"
```

**Add your custom costume IDs** to the appropriate character row.

---

## Testing Checklist

### Test New Costumes:

1. ✅ Costume appears in wardrobe/costume menu
2. ✅ Model loads without errors
3. ✅ Textures display correctly
4. ✅ Character animations work properly
5. ✅ No clipping or graphical glitches
6. ✅ Costume persists through save/load
7. ✅ Works in all game areas (field, battle, cutscenes)
8. ✅ Multiplayer compatibility (if applicable)

---

## Costume ID Ranges

### Base Game Costumes:
- **Male Player**: 0-22
- **Female Player**: 0-22
- **Heroine**: 0-22
- **Aegiomon**: 0-1

### DLC Costumes:
- **DLC 4 (Pre-order)**: ID 4
- **DLC 7 (Public Safety)**: ID varies
- **DLC 12 (Cyber Sleuth)**: ID 23
- **DLC 13 (Swimwear)**: ID 26
- **DLC 14 (Children)**: ID 25
- **DLC 15 (Digimon)**: ID 27

### Safe Custom IDs:
- **50+**: Safe for custom costumes (won't conflict with DLC)

---

## Tips & Warnings

1. **Model compatibility is critical** - Models must match base character skeleton
2. **Test in all contexts** - Field, battle, cutscenes, menus
3. **Keep naming consistent** - Follow the `*CharacterName_#` pattern
4. **Backup original files** - Always keep original costume data
5. **Start with recolors** - Modify existing models before creating new ones
6. **Check LOD settings** - Models need proper Level of Detail definitions
7. **Animation issues** - Some costumes may conflict with certain animations

---

## Multi-Character Costume Sets

When creating a "costume pack", add entries for ALL characters:

```csv
"*MalePlayer_50","*MalePlayer",50,"pc001ea500101","pc001fa500101","","pc001fa500101",
"*FemalePlayer_50","*FemalePlayer",50,"pc002ea500101","pc002fa500101","","pc002fa500101",
"*Heroine_50","*Heroine",50,"npc001ea500101","npc001fa500101","","npc001fa500101",
"*Aegiomon_50","*Aegiomon",50,"chr183ea500101","chr183ea500101","","chr183ea500101",
"*AegiomonNoCap_50","*AegiomonNoCap",50,"chr183ea510101","chr183ea510101","","chr183ea510101",
```

This ensures all characters have matching costume sets.

---

## Quick Reference: New Costume Checklist

For each new costume:

- [ ] Decide costume number (ID)
- [ ] Create/modify model files
- [ ] Add entry to `001_model_costume_change.csv`
- [ ] (Optional) Add to `000_model_defined_in_saved_data.csv`
- [ ] (Optional) Add unlock flag to `002_model_change_by_flag.csv`
- [ ] (Optional) Link to DLC if creating DLC costume
- [ ] Test in-game wardrobe
- [ ] Test in all game areas
- [ ] Verify save/load persistence

---

**End of Guide**

