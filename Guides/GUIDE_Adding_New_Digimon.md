# Guide: Adding a New Digimon to Digimon Time

**Comprehensive step-by-step guide for modding in a new Digimon**

---

## Overview

Adding a new Digimon requires editing multiple interconnected files across data, text, and asset systems. This guide lists every file you need to modify and what to add to each.

**Estimated Files to Edit**: 40-60 files (depending on full localization)

**Difficulty**: Advanced (requires understanding of game data structure and ID management)

---

## Step 1: Prepare Your Digimon Data

Before editing files, prepare these details:

### Required Information:
- **New Digimon ID**: Choose unused ID (587+)
- **Name**: English and other languages
- **Stage**: Rookie (3), Champion (4), Ultimate (5), or Mega (6)
- **Attribute**: Data (0), Vaccine (1), Virus (2), or Free (3)
- **Element**: Fire, Water, Plant, Electric, etc.
- **Base Stats**: HP, SP, ATK, DEF, INT, SPD
- **Skills**: Which skills it learns and at what levels
- **Model ID**: 3D model reference (chr###)
- **Evolution Paths**: What it evolves from and into

### Example Planning:
```
New Digimon: MyCustommon
ID: 587
Stage: 4 (Champion)
Attribute: 1 (Vaccine)
Element: 2 (Water)
Model: chr587
Base HP: 800
Base SP: 450
Skills: Water attacks at levels 1, 10, 20
Evolves from: Digimon ID 50
Evolves into: Digimon ID 100
```

---

## Step 2: Core Data Files (Required)

### File 1: Digimon Stats Database ⭐ CRITICAL

**Location**: `patch.dx11/data/digimon_status/digimon_status.mbe/000_digimon_status_data.csv`

**What to Add**: Complete stat line for your new Digimon

**Columns to Fill** (135 total columns):

```csv
Column 0: 587                          # Your new Digimon ID
Column 1: (leave empty)                # Unused
Column 2: "char_MYCUSTOMMON"           # Internal name (uppercase)
Column 3: "chr587"                     # Model ID
Column 4: 4                            # Stage (4 = Champion)
Column 5: 1                            # Always 1
Column 6: 2                            # Type (0=Data, 1=Vaccine, 2=Virus, 3=Free, 4=Variable)
Column 7-17: ELEMENTAL RESISTANCES     # ⭐ CRITICAL! Per-Digimon resistances
   Column 7: 0                         # Null resistance (0=normal, 1=weak, 3=resist)
   Column 8: 0                         # Fire resistance
   Column 9: 3                         # Water resistance (3=resistant for water type!)
   Column 10: 0                        # Ice resistance
   Column 11: 0                        # Grass resistance
   Column 12: 0                        # Wind resistance
   Column 13: 1                        # Electric resistance (1=weak)
   Column 14: 0                        # Ground resistance
   Column 15: 0                        # Steel resistance
   Column 16: 0                        # Light resistance
   Column 17: 0                        # Dark resistance
Column 18: (empty)
Column 19-60: Trait flags              # true/false for 41 trait flags
Column 61: 3                           # ⭐ BASE PERSONALITY (0-16, e.g., 3=Daring)
Column 62: 1                           # Unknown
Column 63: 99                          # Max level
Column 64: 800                         # ⭐ BASE HP
Column 65: 450                         # ⭐ BASE SP
Column 66: 200                         # ⭐ BASE ATK
Column 67: 180                         # ⭐ BASE DEF
Column 68: 150                         # ⭐ BASE INT
Column 69: 170                         # ⭐ BASE SPI
Column 70: 160                         # ⭐ BASE SPD
Column 71: 26291                       # Skill animation ID
Column 72-107: SIGNATURE SKILLS        # ⭐ 12 signature skills (ID, empty, Slot)
   Format: SkillID, empty, SlotNum (repeats 12 times)
   Example: 30111,,1,30041,,2,30052,,3,...
Column 108-119: GENERIC SKILLS         # ⭐ 4 generic skills (ID, empty, Level)
   Format: SkillID, empty, Level (repeats 4 times)
   Example: 31011,,15,0,,0,0,,0,0,,0
Column 120-130: Various flags          # Battle and growth flags
Column 131: -1                         # Field Guide ID (-1 = not in guide)
Column 132: -1                         # Script ID
Column 133-135: Reference fields       # -1, 0, -1
```

**Template Row** (✅ Verified against Grindosaur.com):
```csv
587,,"char_MYCUSTOMMON","chr587",4,1,2,0,0,3,0,0,0,1,0,0,0,0,,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,0,false,false,false,false,false,false,false,false,true,16,1,99,800,450,200,180,150,170,160,26291,,30111,,1,30041,,2,30052,,3,0,,3,0,,3,0,,3,0,,3,0,,3,0,,3,0,,3,0,,3,0,,3,31011,,15,0,,0,0,,0,0,,0,1,2,6,0,true,false,26291,,164,160,188,1,587,-1,0,-1
```

**Key Changes from Previous Template**:
- ✅ Columns 7-17 now have RESISTANCES (not placeholder 0s)
- ✅ Column 61 is PERSONALITY (not HP!)
- ✅ Columns 64-70 are BASE STATS (HP/SP/ATK/DEF/INT/SPI/SPD)
- ✅ Columns 72-107 are SIGNATURE SKILLS (12 skills, format: ID,,Slot)
- ✅ Columns 108-119 are GENERIC SKILLS (4 skills, format: ID,,Level)

---

### File 2: Character Model Reference

**Location**: `patch.dx11/data/union_model/union_model.mbe/000_union_model.csv`

**What to Add**: Link your Digimon ID to its 3D model

```csv
587,"chr587",1,1,0,0,0
```

**Columns**:
- Column 0: Digimon ID (587)
- Column 1: Model path ("chr587")
- Columns 2-6: Model flags (use 1,1,0,0,0 as default)

---

### File 3: Animation Settings

**Location**: `patch.dx11/data/anim_setting/anim_setting.mbe/001_same_animation_data.csv`

**What to Add** (if sharing animations with existing Digimon):

```csv
"chr587","chr050"
```

This makes chr587 use the same animations as chr050 (change to appropriate base model).

**Or skip this** if you're creating unique animations.

---

## Step 3: Evolution System (Required)

### File 4: Evolution Table - Pre-evolution

**Location**: `patch.dx11/data/evolution/evolution.mbe/000_evolution_table.csv`

**What to Add**: Entry for evolving INTO your new Digimon

```csv
50,587,20,200,180,150,170,50,20,-1,false
```

**Columns**:
- Column 0: **50** (Base Digimon ID that evolves)
- Column 1: **587** (Your new Digimon ID - evolution result)
- Column 2: **20** (Level requirement)
- Column 3: **200** (ATK requirement)
- Column 4: **180** (DEF requirement)
- Column 5: **150** (INT requirement)
- Column 6: **170** (SPD requirement)
- Column 7: **50** (CAM requirement)
- Column 8: **20** (ABI requirement)
- Column 9: **-1** (Item required, -1 = none)
- Column 10: **false** (Special conditions)

### File 5: Evolution Table - Next evolution

**What to Add**: Entry for evolving FROM your new Digimon

```csv
587,100,35,400,350,300,340,70,40,-1,false
```

This allows your new Digimon (587) to evolve into Digimon 100 at level 35 with those stats.

---

## Step 4: Localization - ALL Languages (Required for proper display)

You need to add your Digimon's name and description in **all 11 language files**:

### File 6-16: Character Names (11 files)

**Locations**:
- `patch_text00.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Japanese)
- `patch_text01.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (English)
- `patch_text02.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (French)
- `patch_text03.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (German)
- `patch_text04.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Italian)
- `patch_text05.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Spanish EU)
- `patch_text07.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Korean)
- `patch_text09.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Traditional Chinese)
- `patch_text10.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Simplified Chinese)
- `patch_text11.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Portuguese)
- `patch_text30.dx11/text/char_name/char_name.mbe/000_Sheet1.csv` (Spanish LA)

**Add to each file**:
```csv
"587","MyCustommon"
```

Change "MyCustommon" to the appropriate translation for each language.

### File 17-27: Digimon Profiles (11 files)

**Locations**: Same pattern but in `digimon_profile/digimon_profile.mbe/000_Sheet1.csv`

**Add to each file**:
```csv
"587","A powerful water-type Digimon that controls ocean currents. It evolved from..."
```

Write an appropriate description in each language.

---

## Step 5: Skill Learning (If using existing skills)

### Already done in File 1!

The skill learning is set in columns 72-119 of the digimon_status file.

**Signature Skills (Columns 72-107)**: 12 skills
```
Format: [Skill ID], (empty), [Slot Number] (repeats 12 times)
Column 72-74: Skill 1  (ID, empty, Slot)
Column 75-77: Skill 2  (ID, empty, Slot)
...and so on for 12 skills
```

**Generic Skills (Columns 108-119)**: 4 skills
```
Format: [Skill ID], (empty), [Learn Level] (repeats 4 times)
Column 108-110: Generic Skill 1 (ID, empty, Level)
Column 111-113: Generic Skill 2 (ID, empty, Level)
Column 114-116: Generic Skill 3 (ID, empty, Level)
Column 117-119: Generic Skill 4 (ID, empty, Level)
```

**Example**:
```csv
...Column 72: 30111, Column 73: (empty), Column 74: 1...  # Signature skill 1, slot 1
...Column 108: 31011, Column 109: (empty), Column 110: 15... # Generic skill learned at level 15
```

---

## Step 6: Battle System (If enemy encounter)

### File 28: Enemy Encounters (Optional - if Digimon appears as enemy)

**Location**: `patch.dx11/data/battle_enemy/battle_enemy.mbe/000_battle_enemy_list.csv`

**Add new encounter entry**:
```csv
5000,587,25,-1,0,-1,0,1,1,1,1,false,1,5000,500
```

**Columns**:
- Column 0: **5000** (New encounter ID)
- Column 1: **587** (Your Digimon ID)
- Column 2: **25** (Enemy level)
- Column 3: **-1** (No second enemy)
- Column 4-6: Second enemy data (not used)
- Column 7: **1** (Formation type)
- Column 8: **1** (Background)
- Column 9: **1** (Music track)
- Column 10: **1** (AI pattern)
- Column 11: **false** (Not a boss)
- Column 12: **1** (Can escape)
- Column 13: **5000** (EXP reward)
- Column 14: **500** (Money reward)

---

## Step 7: Field/NPC Placement (Optional)

### File 29: NPC Placement (Optional - if Digimon appears in world)

**Location**: `patch.dx11/data/field_npc_[area]/field_npc_[area].mbe/000_npc.csv`

Choose an area (e.g., `field_npc_t0101` for first town).

**Add**:
```csv
100,587,100.0,50.0,200.0,180.0,1,5000,-1,true,-1,-1
```

**Columns**:
- Column 0: **100** (NPC ID for this area)
- Column 1: **587** (Your Digimon model ID)
- Column 2-4: **100.0, 50.0, 200.0** (X, Y, Z position)
- Column 5: **180.0** (Rotation/facing direction)
- Column 6: **1** (Behavior type - standing still)
- Column 7: **5000** (Dialogue ID if talkable)
- Column 8: **-1** (No quest requirement)
- Column 9: **true** (Repeatable interaction)
- Column 10: **-1** (Not a shop)
- Column 11: **-1** (No battle trigger)

---

## Step 8: DigiBank/Farm Support (Optional but recommended)

### File 30: DigiBank Entry

**Location**: `patch.dx11/data/digibank/digibank.mbe/000_digibank_list.csv`

**Add**:
```csv
587,8,1,true,true
```

**Columns**:
- Column 0: **587** (Digimon ID)
- Column 1: **8** (Memory usage - matches File 1)
- Column 2: **1** (Can be stored)
- Column 3: **true** (Can be recruited)
- Column 4: **true** (Shows in bank)

---

## Step 9: Collection/Dex Entry (Optional)

### File 31: Digimon Field Guide

**Location**: `patch.dx11/data/digimon_catalog/digimon_catalog.mbe/000_catalog.csv`

**Add**:
```csv
587,4,1,2,true,1
```

**Columns**:
- Column 0: **587** (Digimon ID)
- Column 1: **4** (Stage - Champion)
- Column 2: **1** (Attribute - Vaccine)
- Column 3: **2** (Element - Water)
- Column 4: **true** (Visible in guide)
- Column 5: **1** (Discovery flag)

---

## Step 10: LOD (Level of Detail) Settings

### File 32: LOD Character Data

**Location**: `patch.dx11/data/lod_chara/lod_chara.mbe/000_lod_chara.csv`

**Add**:
```csv
587,"chr587",1.0,1.0,1.0,50,30,20
```

**Columns**:
- Column 0: **587** (Digimon ID)
- Column 1: **"chr587"** (Model reference)
- Column 2-4: **1.0, 1.0, 1.0** (LOD distance scales)
- Column 5-7: **50, 30, 20** (LOD detail levels)

---

## Step 11: Model & Asset Files (External - Not CSV)

### Required 3D Assets (Not covered by CSV editing):

You'll need to create/import these files (advanced modding):

1. **3D Model**: `chr587.geom` (geometry file)
2. **Textures**: `chr587.img` (texture files)
3. **Animations**: `chr587.anim` (animation files)
4. **Skeleton**: `chr587.nlst` (bone structure)

**Location**: `app_0.dx11/chara/chr587/`

**Alternative**: Reference existing model in animation settings (Step 2, File 3)

---

## Step 12: Verification Checklist

After editing all files, verify:

- [ ] Digimon ID (587) is unique and not used elsewhere
- [ ] All 11 language name files updated
- [ ] All 11 language profile files updated
- [ ] Stats are balanced (not too strong/weak)
- [ ] Evolution paths work both ways (to and from)
- [ ] Skills are assigned and learnable
- [ ] Model ID matches throughout all files
- [ ] Memory usage is consistent
- [ ] LOD settings added
- [ ] No typos in internal names (they're case-sensitive!)

---

## Summary: Complete File List

### Required Files (Minimum 24):
1. ✅ `digimon_status/000_digimon_status_data.csv` - Stats
2. ✅ `union_model/000_union_model.csv` - Model link
3. ✅ `evolution/000_evolution_table.csv` - Evolution IN (2 entries)
4-14. ✅ `char_name/000_Sheet1.csv` (×11 languages) - Names
15-25. ✅ `digimon_profile/000_Sheet1.csv` (×11 languages) - Descriptions

### Recommended Files (6):
26. ✅ `anim_setting/001_same_animation_data.csv` - Animation sharing
27. ✅ `digibank/000_digibank_list.csv` - Bank support
28. ✅ `digimon_catalog/000_catalog.csv` - Field guide
29. ✅ `lod_chara/000_lod_chara.csv` - LOD settings

### Optional Files (Variable):
30. ⭕ `battle_enemy/000_battle_enemy_list.csv` - If enemy
31. ⭕ `field_npc_[area]/000_npc.csv` - If in overworld
32. ⭕ `shop/001_shop_lineup.csv` - If appears in shops
33. ⭕ `quest/000_quest_main.csv` - If related to quests

---

## Common Issues & Solutions

### Issue: Digimon doesn't appear in game
**Solution**: Check that ID is added to `union_model` and `lod_chara` files

### Issue: Name shows as "???" or blank
**Solution**: Add entry to ALL 11 language name files, not just English

### Issue: Can't evolve into new Digimon
**Solution**: Check evolution table - column 0 should be the BASE Digimon ID, column 1 should be YOUR new Digimon ID

### Issue: Game crashes when viewing Digimon
**Solution**: Ensure model ID (chr587) exists or is properly referenced in animation settings

### Issue: Stats seem wrong
**Solution**: Check column alignment - CSV format is very strict about commas

### Issue: Skills don't appear
**Solution**: Verify skill IDs in columns 74-120 are valid existing skill IDs

---

## Pro Tips

1. **Start with patch.dx11 files** - They override app_0.dx11
2. **Use ID 587+** - Base game uses up to 586
3. **Copy an existing similar Digimon** - Easier than starting from scratch
4. **Test in-game frequently** - Don't wait until all files are edited
5. **Back up original files** - Always keep backups!
6. **Use Excel or similar** - CSV editing is easier in spreadsheet software
7. **Watch for hidden characters** - Some CSV editors add invisible characters
8. **Keep IDs sequential** - Easier to track and debug
9. **Document your changes** - Keep notes on what you modified
10. **Share animations initially** - Easier than creating custom animations

---

## Advanced: Creating Custom Skills

If you want your Digimon to have unique skills, you'll also need to edit:

- `skill/000_skill_data.csv` - Define new skill
- `skill_name/000_Sheet1.csv` (×11) - Skill names
- `skill_explanation/000_Sheet1.csv` (×11) - Skill descriptions
- Battle effects and animations

This is covered in a separate guide.

---

## Example: Complete New Digimon Template

Here's a complete example for adding "Aquamon" (ID 587):

```csv
# File 1: digimon_status_data.csv
587,,"char_AQUAMON","chr587",4,1,2,1,8,3,3,0,0,0,0,0,0,0,,true,true,true,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,0,false,false,false,false,false,false,false,false,false,15,1,99,800,450,200,180,150,170,160,190,10,30041,,1,0,,10,30052,,20,30062,,30,31011,,40,0,,0,0,,0,0,,0,0,,0,0,,0,0,,0,0,,0,0,,3,32091,,15,0,,0,0,,1,2,3,0,1.0,false,false,3,,220,180,195,165,587,-1,0,-1

# File 2: union_model.csv
587,"chr587",1,1,0,0,0

# File 3: evolution_table.csv (evolves from ID 50)
50,587,20,200,180,150,170,50,20,-1,false

# File 4: evolution_table.csv (evolves into ID 100)
587,100,35,400,350,300,340,70,40,-1,false

# Files 5-15: char_name (×11 languages)
"587","Aquamon"

# Files 16-26: digimon_profile (×11 languages)
"587","A water-type Digimon that dwells in the deep ocean. Its signature move is Tidal Wave."

# File 27: lod_chara.csv
587,"chr587",1.0,1.0,1.0,50,30,20
```

---

**Good luck with your Digimon modding!** 🎮✨

*For questions about specific columns or values, refer to COMPREHENSIVE_FILE_DOCUMENTATION.md*

