# Guide: Mode Change System in Digimon Time Stranger

---

## Overview

The Mode Change system allows certain Digimon to switch between different forms/modes during battle using special skills. This includes:
- **Burst Modes** (temporary power-ups)
- **Form Changes** (Fighter Mode ↔ Dragon Mode)
- **Werewolf Modes** (Cerberumon)
- **Spirit Evolution Changes** (Agnimon ↔ Vritramon)

**Primary File**: `patch.dx11/data/battle_skill/battle_skill.mbe/003_skill_mode_change.csv`

---

## Table of Contents
1. [File Structure](#file-structure)
2. [Column Definitions](#column-definitions)
3. [How Mode Changes Work](#how-mode-changes-work)
4. [Existing Mode Change Digimon](#existing-mode-change-digimon)
5. [Creating New Mode Changes](#creating-new-mode-changes)
6. [Mode Change Types](#mode-change-types)
7. [Step-by-Step Examples](#step-by-step-examples)
8. [Troubleshooting](#troubleshooting)

---

## File Structure

### Primary File:
```
patch.dx11/data/battle_skill/battle_skill.mbe/003_skill_mode_change.csv
```

### Related Files:
- `000_battle_skill_list.csv` - Defines the mode change skills
- `000_digimon_status_data.csv` - Contains signature skills for each Digimon
- `000_char_info.csv` - Character/model definitions

---

## Column Definitions

### Header:
```csv
int32 0,int32 1,empty 2,empty 3,int32 4,int32 5,int32 6,empty 7,int32 8,empty 9,int32 10,empty 11,int32 12,empty 13,int32 14,empty 15,int32 16,empty 17,int32 18,empty 19,int32 20,empty 21,int32 22,empty 23,int32 24,empty 25,int32 26,empty 27,int32 28,empty 29
```

### Column Breakdown:

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | int32 | Skill ID (×10) | Skill ID multiplied by 10 (e.g., 4191 for skill 419) |
| 1 | int32 | Digimon ID | Character ID without "chr" prefix (e.g., 419 = chr419) |
| 2 | empty | - | Unused |
| 3 | empty | - | Unused |
| 4 | int32 | Mode Count | Number of modes (1 = single mode, more = multiple) |
| 5 | int32 | Mode Type | Type of mode change (1 = standard, 2 = special) |
| 6 | int32 | Mode 1 Skill | First mode change skill ID |
| 7 | empty | - | Unused |
| 8 | int32 | Mode 2 Skill | Second mode change skill ID (0 if none) |
| 9 | empty | - | Unused |
| 10 | int32 | Mode 3 Skill | Third mode change skill ID (0 if none) |
| 11-29 | int32/empty | Additional Modes | Supports up to 10 total modes (rarely used) |

---

## How Mode Changes Work

### System Flow:

1. **Digimon has Mode Change Skill** in their signature skill list
2. **Mode Change Skill is used** in battle (appears in command menu)
3. **Digimon transforms** into alternate form (new model, stats, skills)
4. **Mode can be switched** back and forth during battle
5. **Mode persists** until manually changed or battle ends

### Mode Change vs Evolution:

| Feature | Mode Change | Evolution |
|---------|-------------|-----------|
| **Temporary** | ✅ Yes (battle only) | ❌ No (permanent) |
| **Reversible** | ✅ Yes | ❌ No (unless de-digivolve) |
| **Same Digimon** | ✅ Yes (form switch) | ❌ No (different Digimon) |
| **During Battle** | ✅ Yes | ❌ No |
| **Stat Changes** | ✅ Yes | ✅ Yes |

---

## Existing Mode Change Digimon

### Current Mode Change Digimon (Base Game + Patch):

| Skill ID | Digimon | Form 1 | Form 2 | Form 3 |
|----------|---------|--------|--------|--------|
| 1621 | **Ranamon** | Ranamon | Calamaramon | - |
| 1631 | **Calamaramon** | Calamaramon | Ranamon | - |
| 1761 | **Ceresmon** | Ceresmon | Ceresmon (Alt) | Ceresmon Medium |
| 1891 | **Ceresmon Medium** | Ceresmon Medium | Ceresmon | Ceresmon (Alt) |
| 2231 | **Cerberumon** | Normal | Werewolf Mode | - |
| 2241 | **Cerberumon (Werewolf)** | Werewolf Mode | Normal | - |
| 4191 | **Imperialdramon FM** | Fighter Mode | Paladin Mode | Dragon Mode |
| 6751 | **MagnaGarurumon (Separation)** | Separated Form | - | - |
| 6761 | **Agnimon** | Agnimon | Vritramon | - |
| 6791 | **Vritramon** | Vritramon | Agnimon | - |
| 6801 | **Wolfmon** | Wolfmon | Garummon | - |
| 6811 | **Garummon** | Garummon | Wolfmon | - |
| 7321 | **Imperialdramon DM** | Dragon Mode | Fighter Mode | Fighter Mode (Alt) |
| 7391 | **Duftmon** | Duftmon | Duftmon (Alt) | Duftmon LM |
| 7431 | **Duftmon LM** | Leopard Mode | Duftmon (Alt2) | Duftmon |

---

## Creating New Mode Changes

### Requirements:

1. **Two or more Digimon models** (chr###) with different forms
2. **Mode change skills** defined in `000_battle_skill_list.csv`
3. **Entry in `003_skill_mode_change.csv`** linking skills together
4. **Signature skills assigned** to Digimon in `000_digimon_status_data.csv`

---

## Step-by-Step: Adding a New Mode Change

### Example: Creating a Burst Mode for Agumon

#### Step 1: Define Mode Change Skills

**File**: `patch.dx11/data/battle_skill/battle_skill.mbe/000_battle_skill_list.csv`

Add two new skills:

```csv
29970,,,,29970,29970,29970,true,true,30999,3,1,29970,,0,,12099,,0,,0,2,1,50,100,1,0,0,5,0,-1,-1,-1,5,1,1,200,5,0,0,100,1,5,0,0,0,0,0,,0,0,,0,,0,,0,,0,,0,2997,,0,-1,,-1,,-1,,-1,,""
29971,,,,29971,29971,29971,true,true,30999,3,1,29971,,0,,12099,,0,,0,2,1,50,100,1,0,0,5,0,-1,-1,-1,5,1,1,200,5,0,0,100,1,5,0,0,0,0,0,,0,0,,0,,0,,0,,0,,0,-1,,0,-1,,-1,,-1,,-1,,""
```

**Column 60**: `2997` = Mode change reference (Skill ID / 10)

#### Step 2: Add Mode Change Entry

**File**: `patch.dx11/data/battle_skill/battle_skill.mbe/003_skill_mode_change.csv`

```csv
2997,299,,,1,1,29970,,29971,,0,,0,,0,,0,,0,,0,,0,,0,,0,,0,
```

**Breakdown**:
- `2997` = Skill ID ×10
- `299` = Digimon chr299
- `1,1` = 1 mode, type 1 (standard)
- `29970` = Normal form skill
- `29971` = Burst mode skill
- `0` = No third mode

#### Step 3: Assign Skill to Digimon

**File**: `patch.dx11/data/digimon_status/digimon_status.mbe/000_digimon_status_data.csv`

Find chr299's row and add skill 29970 to one of their signature skill slots (columns 72-107).

Example:
```csv
299,,"char_AGUMON_BURST","chr299",...,29970,0,...
```

#### Step 4: Create Burst Mode Model (Optional)

If creating a NEW model for Burst Mode:
- Create `chr299b` (Burst form)
- Add entry to `char_info.csv`
- Set up model files

Or reuse existing model with visual effects.

---

## Mode Change Types

### Type 1: Standard Mode Change
- **Most common**
- Reversible transformation
- Both forms can switch freely
- Examples: Imperialdramon FM ↔ DM

```csv
4191,419,,,1,1,24191,,24192,,27322,,0,,0,,0,,0,,0,,0,,0,,0,
```

### Type 2: Special/One-Way Mode Change
- **Rare**
- May have restrictions
- Usually single transformation
- Examples: MagnaGarurumon Separation

```csv
6751,675,,,1,2,26751,,0,,0,,0,,0,,0,,0,,0,,0,,0,,0,
```

---

## Mode Change Skill Properties

### Important Skill Columns:

From `000_battle_skill_list.csv`:

| Column | Purpose | Typical Value |
|--------|---------|---------------|
| 0 | Skill ID | 29970 |
| 4-6 | Skill References | Same as skill ID |
| 7-8 | Usability Flags | true, true |
| 9 | Effect ID | 30999 (custom) |
| 10 | Skill Category | 3 (signature) |
| 11 | Action Type | 1 (standard) |
| 60 | **Mode Change Link** | Skill ID / 10 |

**Column 60 is CRITICAL** - Links to `003_skill_mode_change.csv` entry!

---

## Multiple Forms (3+ Modes)

### Example: Imperialdramon (3 Modes)

```csv
4191,419,,,1,1,24191,,24192,,27322,,0,,0,,0,,0,,0,,0,,0,,0,
```

**Modes**:
1. Fighter Mode (24191) - Base form
2. Paladin Mode (24192) - Powered up
3. Dragon Mode (27322) - Alternate form

**In-Game**:
- Press mode change to cycle: FM → PM → DM → FM...
- Or select specific mode from menu (depending on UI)

---

## Step-by-Step Examples

### Example 1: Simple Two-Form Mode Change

**Goal**: Create Greymon ↔ MetalGreymon mode switch

```csv
# Step 1: 003_skill_mode_change.csv
271,27,,,1,1,2710,,2711,,0,,0,,0,,0,,0,,0,,0,,0,,0,

# Step 2: 000_battle_skill_list.csv (add both skills)
27100,,,,27100,27100,27100,true,true,30271,3,1,27100,,0,,12027,,0,,0,2,1,50,100,1,0,0,5,0,-1,-1,-1,5,1,1,200,5,0,0,100,1,5,0,0,0,0,0,,0,0,,0,,0,,0,,0,,0,271,,0,-1,,-1,,-1,,-1,,""
27110,,,,27110,27110,27110,true,true,30271,3,1,27110,,0,,12027,,0,,0,2,1,50,100,1,0,0,5,0,-1,-1,-1,5,1,1,200,5,0,0,100,1,5,0,0,0,0,0,,0,0,,0,,0,,0,,0,,0,-1,,0,-1,,-1,,-1,,-1,,""
```

### Example 2: Three-Form Cycle

**Goal**: Agumon → Greymon → MetalGreymon → Agumon

```csv
# Step 1: 003_skill_mode_change.csv
971,97,,,1,1,9710,,9711,,9712,,0,,0,,0,,0,,0,,0,,0,,0,

# All three forms get mode change skills
# Skill 9710 cycles to 9711, 9711 to 9712, 9712 to 9710
```

---

## Troubleshooting

### Issue 1: Mode Change Skill Doesn't Appear
**Cause**: Skill not assigned to Digimon's signature skills
**Fix**: Add skill ID to columns 72-107 in `000_digimon_status_data.csv`

### Issue 2: Mode Change Does Nothing
**Cause**: Missing or incorrect entry in `003_skill_mode_change.csv`
**Fix**: Verify Skill ID / 10 matches column 0

### Issue 3: Game Crashes on Mode Change
**Cause**: Target form model doesn't exist
**Fix**: Ensure chr### model exists and is properly defined in `char_info.csv`

### Issue 4: Can't Switch Back
**Cause**: Reverse skill not defined or not assigned
**Fix**: Create reciprocal entry with reverse skill IDs

### Issue 5: Wrong Stats After Mode Change
**Cause**: Mode change references wrong Digimon ID
**Fix**: Verify column 1 in `003_skill_mode_change.csv` matches correct chr###

---

## Important Notes

1. **Mode changes are BATTLE ONLY** - Digimon reverts after battle
2. **Both forms need entries** if mode change is reversible
3. **Skill ID × 10** pattern is critical for linking
4. **Column 60 in skill list** MUST match column 0 in mode change file
5. **Signature skills** must include mode change skill
6. **Models must exist** - game will crash if chr### not found
7. **HP/SP are maintained** during mode change (percentage-based)
8. **Status effects persist** through mode changes
9. **Mode changes cost SP** if configured in skill definition
10. **Can have up to 10 modes** (columns support it, rarely used)

---

## Advanced: Mode Change Conditions

### Conditional Mode Changes:

While not fully exposed in CSV, mode changes can be restricted by:
- **Battle conditions** (hardcoded in game engine)
- **Story flags** (certain story points)
- **Items held** (specific equipment)
- **HP thresholds** (Burst Mode when HP < 30%)

These are typically hardcoded and cannot be easily modified via CSV.

---

## Related Guides

- **GUIDE_Adding_New_Skills.md** - Creating mode change skills
- **GUIDE_Adding_New_Digimon.md** - Creating alternate forms
- **GUIDE_Digimon_Status_Data_Columns.md** - Understanding signature skills
- **GUIDE_Cross_Arts_Jogress.md** - Fusion/combination mechanics

---

## Quick Reference

### Mode Change Formula:
```
Mode Change Skill ID (× 10) = Entry in 003_skill_mode_change.csv
Target Form = Different chr### with own stats/skills
Trigger = Signature skill used in battle
Duration = Until battle ends or manually changed
```

### File Editing Order:
1. `000_battle_skill_list.csv` - Create mode change skills
2. `003_skill_mode_change.csv` - Link skills together
3. `000_digimon_status_data.csv` - Assign skills to Digimon
4. Test in-game!

---

## Summary

The Mode Change system allows dynamic form switching during battle via special signature skills. By properly configuring skill definitions and mode change links, you can create:
- Burst Modes
- Form switches (Fighter ↔ Dragon)
- Multi-stage transformations
- Spirit evolution changes

The system is flexible and supports up to 10 different modes per Digimon, though most use 2-3 modes maximum.

---

**Created**: 2025-10-27
**Game**: Digimon Story: Cyber Sleuth - Time Stranger
**File Version**: Patch.dx11


