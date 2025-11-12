# Guide: Making Every Digimon Rideable in Digimon Time

**Complete guide for enabling riding on all Digimon**

---

## Overview

The Digi-Ride system allows players to ride certain Digimon for faster field traversal. By default, ~167 Digimon are rideable. This guide explains how to make ANY Digimon rideable.

**Files to Edit**: 1-2 files (primarily just 1!)

**Difficulty**: Beginner-Intermediate

**⚠️ VERIFIED**: Only the animation CSV needs editing - no trait flags or status data!

---

## Step 1: Understanding the Ride System

### Core Files:

1. **`patch.dx11/data/field_anime/field_anime.mbe/001_field_digi_ride_animation.csv`**
   - Defines which Digimon can be ridden
   - Sets ride speed, animations, transitions

2. **`patch.dx11/data/field_anime/field_anime.mbe/002_field_digi_ride_get_on_and_off.csv`**
   - Defines mount/dismount animations
   - Animation type settings

3. **`app_0.dx11/data/field/field.mbe/016_field_digi_ride_animation.csv`** (Optional - base game copy)
   - Appears to be base game version (only 2 entries)
   - **NOT NEEDED** - patch version (001_) is used by game

---

## Step 2: Ride Animation File Structure

**Location**: `patch.dx11/data/field_anime/field_anime.mbe/001_field_digi_ride_animation.csv`

**CSV Structure**: 15 columns (0-14)

**Header**:
```
string3 0,string2 1,string2 2,string2 3,float 4,float 5,float 6,float 7,float 8,float 9,float 10,int32 11,float 12,string2 13,string2 14
```

### Column Meanings:

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | string3 | Digimon ID | Character ID (e.g., "chr106") |
| 1 | string2 | Idle Anim | Idle ride animation - stationary (e.g., "r106_fn01") |
| 2 | string2 | Running Anim | Running ride animation - moving (e.g., "r106_fw01") |
| 3 | string2 | Extra Anim | Extra animation (usually empty) |
| 4 | float | Base Speed | Base riding speed (3-20) |
| 5 | float | Min Speed | Minimum speed (usually 0) |
| 6 | float | Max Speed | Speed multiplier (usually 1) |
| 7 | float | Accel Frame 1 | Acceleration frame 1 (-1 if N/A) |
| 8 | float | Accel Frame 2 | Acceleration frame 2 (-1 if N/A) |
| 9 | float | Accel Frame 3 | Acceleration frame 3 (-1 if N/A) |
| 10 | float | Accel Frame 4 | Acceleration frame 4 (-1 if N/A) |
| 11 | int32 | Anim Type | Animation type (0-6) |
| 12 | float | End Speed | Speed at animation end |
| 13 | string2 | Effect 1 | Effect reference ("fe02") |
| 14 | string2 | Effect 2 | Effect type ("F01") |

---

## Step 3: Example Rideable Digimon

### Example 1: WarGreymon (chr027) - Simple Ride
```csv
"chr027","r027_fn01","r027_fw01","",14,0,1,-1,-1,-1,-1,4,14,"fe02","F01"
```

**Breakdown**:
- Digimon: chr027 (WarGreymon)
- Animations: r027_fn01 (idle/stationary), r027_fw01 (running/moving)
- Speed: 14 (moderate speed)
- No acceleration frames: -1, -1, -1, -1
- Type: 4
- Effects: fe02, F01

### Example 2: Greymon (chr001) - With Acceleration
```csv
"chr001","r001_fn01","r001_fw01","",12,0,1,15,30,-1,-1,0,12,"fe02","F01"
```

**Breakdown**:
- Speed: 12
- Acceleration: frames 15 and 30
- Type: 0
- Smoother speed transitions

### Example 3: Imperialdramon DM (chr732) - Fast Ride
```csv
"chr732","r732_fn01","r732_fw01","",14,0,1,-1,-1,-1,-1,4,14,"fe02","F01"
```

**Breakdown**:
- Speed: 14 (standard fast)
- No acceleration
- Type: 4 (common for large Digimon)

### Example 4: Locomon (chr035) - Very Fast
```csv
"chr035","r035_fn01","r035_fw01","",20,0,1,-1,-1,-1,-1,2,20,"fe02","F01"
```

**Breakdown**:
- Speed: 20 (very fast!)
- Type: 2 (special for train-like Digimon)

---

## Step 4: Animation Type Reference (Column 11)

### Common Animation Types:

| Type | Description | Used For |
|------|-------------|----------|
| **0** | Basic ground ride | Small/medium Digimon |
| **1** | Special ride | Unique animations |
| **2** | Fast ground ride | Large/fast Digimon (Locomon) |
| **3** | Multi-transition | Digimon with complex animations |
| **4** | Standard large | Most Mega/Ultimate Digimon |
| **6** | Special case | Unique (rarely used) |

---

## Step 5: Speed Guidelines

### Recommended Speeds:

| Digimon Size | Speed | Examples |
|--------------|-------|----------|
| Small (Rookie) | 3-6 | Agumon, Gabumon |
| Medium (Champion) | 7-10 | Greymon, Garurumon |
| Large (Ultimate) | 11-14 | WarGreymon, MetalGarurumon |
| Mega | 14-16 | Omnimon, Imperialdramon |
| Special (Flying/Fast) | 16-20 | Locomon, Flying Digimon |

---

## Step 6: Making a Digimon Rideable

### Template for Adding New Rideable Digimon:

**Standard Template**:
```csv
"chr###","r###_fn01","r###_fw01","",12,0,1,-1,-1,-1,-1,4,12,"fe02","F01"
```

**Replace**:
- `###` with Digimon's chr ID number
- Speed `12` with desired speed
- Type `4` with appropriate animation type

---

## Step 7: Adding ALL Digimon as Rideable

### Method 1: Universal Template (Safe & Easy)

**Use this template for ANY Digimon**:
```csv
"chr###","r###_fn01","r###_fw01","",10,0,1,-1,-1,-1,-1,4,10,"fe02","F01"
```

**Settings**:
- Speed: 10 (moderate, safe for all)
- No acceleration: -1, -1, -1, -1
- Type: 4 (works for most Digimon)
- Standard effects

**Example - Making Agumon (chr097) Rideable**:
```csv
"chr097","r097_fn01","r097_fw01","",10,0,1,-1,-1,-1,-1,4,10,"fe02","F01"
```

### Method 2: Size-Based Templates

**Small Digimon** (Rookie, In-Training):
```csv
"chr###","r###_fn01","r###_fw01","",6,0,1,-1,-1,-1,-1,0,8,"fe02","F01"
```

**Medium Digimon** (Champion):
```csv
"chr###","r###_fn01","r###_fw01","",9,0,1,-1,-1,-1,-1,0,12,"fe02","F01"
```

**Large Digimon** (Ultimate):
```csv
"chr###","r###_fn01","r###_fw01","",12,0,1,-1,-1,-1,-1,4,12,"fe02","F01"
```

**Mega Digimon**:
```csv
"chr###","r###_fn01","r###_fw01","",14,0,1,-1,-1,-1,-1,4,14,"fe02","F01"
```

---

## Step 8: Get/Dismount Animations

**Location**: `patch.dx11/data/field_anime/field_anime.mbe/002_field_digi_ride_get_on_and_off.csv`

**CSV Structure**: 3 columns (0-2)

**Header**:
```
int32 0,string3 1,string3 2
```

### Column Meanings:

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | int32 | Animation Type | Type ID (1, 2, or 6) |
| 1 | string3 | Mount Anim | Getting on animation |
| 2 | string3 | Dismount Anim | Getting off animation |

### Existing Entries:
```csv
2,"ride_in01","ride_out01"
1,"ride_in01","ride_out01"
6,"ride_in01","ride_out01"
```

**These are already defined** - no need to modify unless adding custom animations!

---

## Step 9: Finding Digimon chr IDs

### Method 1: Check digimon_status_data.csv

**Location**: `patch.dx11/data/digimon_status/digimon_status.mbe/000_digimon_status_data.csv`

**Column 2** contains chr ID references like `"char_AGUMON"` → matches to `chr###`

### Method 2: Check char_info files

**Location**: `patch.dx11/data/char_info/char_info.mbe/000_char_info.csv`

Lists all character model IDs

### Common chr ID Ranges:
- **001-200**: Main game Digimon
- **201-500**: Additional Digimon
- **501-800**: Extended roster
- **801-900**: Special/DLC Digimon

---

## Step 10: Batch Adding Digimon

### Script Approach (Advanced):

Create entries for multiple Digimon at once:

**Example - Adding chr700-750**:
```csv
"chr700","r700_fn01","r700_fw01","",10,0,1,-1,-1,-1,-1,4,10,"fe02","F01"
"chr701","r701_fn01","r701_fw01","",10,0,1,-1,-1,-1,-1,4,10,"fe02","F01"
"chr702","r702_fn01","r702_fw01","",10,0,1,-1,-1,-1,-1,4,10,"fe02","F01"
... (continue pattern)
```

### Bulk Template Generator Pattern:

For each Digimon ID from 1 to 900:
```
"chr{ID:03d}","r{ID:03d}_fn01","r{ID:03d}_fw01","",10,0,1,-1,-1,-1,-1,4,10,"fe02","F01"
```

---

## Step 11: Testing & Troubleshooting

### Testing New Rideable Digimon:

1. ✅ Add entry to `001_field_digi_ride_animation.csv`
2. ✅ Load game
3. ✅ Summon the Digimon
4. ✅ Press ride button (default: R1/RB)
5. ✅ Check if character mounts Digimon
6. ✅ Test movement speed
7. ✅ Test dismount

### Common Issues:

**Issue 1**: Digimon doesn't appear as rideable
- **Solution**: Check chr ID is correct
- **Solution**: Verify entry is in correct CSV file

**Issue 2**: Animation glitches or clipping
- **Solution**: Adjust speed values
- **Solution**: Try different animation type

**Issue 3**: Game crashes when mounting
- **Solution**: Check CSV syntax (commas, quotes)
- **Solution**: Verify animation references exist

**Issue 4**: Digimon rides too slow/fast
- **Solution**: Adjust column 4 (base speed)
- **Solution**: Test speeds between 6-16 for best results

---

## Step 12: Animation Requirements

### ⚠️ IMPORTANT: Animation Files

**The game expects animation files to exist**:
- `r###_fn01` (idle ride animation - when stationary)
- `r###_fw01` (running ride animation - when moving)

**If animations don't exist**:
- Game may use default/fallback animations
- May cause visual glitches
- Digimon may appear floating or clipping

**Workaround**: Use existing rideable Digimon's animation references for similar-sized Digimon

**Example - Using Greymon animations for similar Digimon**:
```csv
"chr999","r001_fn01","r001_fw01","",12,0,1,-1,-1,-1,-1,0,12,"fe02","F01"
```
(Uses Greymon's chr001 animations)

### 🦴 About Bone Attachment:

**Player attachment point is stored IN the animation files**, not in CSV:
- The `r###_fn01` and `r###_fw01` files contain bone attachment data
- Different Digimon use different bones (e.g., WarGreymon uses `J_weapon_l`)
- You **cannot change which bone is used** through CSV editing alone
- The bone attachment is baked into the binary animation files

**What this means**:
- If ride animations exist, they already have the correct attachment configured
- You don't need to specify a bone in the CSV
- To change attachment points, you'd need 3D animation tools (beyond CSV modding)

---

## Step 13: Special Cases

### Flying Digimon:

**Example - Airdramon (chr305)**:
```csv
"chr305","r305_fn01","r305_fw01","",14,0,1,-1,-1,-1,-1,4,14,"fe02","F01"
```
- Type 4 works for flying
- Speed 14+ recommended
- No special flight flag needed

### Small Digimon (Rookies):

**Example - Tailmon (chr049)**:
```csv
"chr049","r049_fn01","r049_fw01","",3,0,1,18,2,-1,-1,0,3,"fe02","F01"
```
- Lower speed (3-6)
- Type 0 for ground-based
- May look odd but functional

### Mega/Large Digimon:

**Example - Omnimon (chr088)**:
```csv
"chr088","r088_fn01","r088_fw01","",14,0,1,-1,-1,-1,-1,4,14,"fe02","F01"
```
- Speed 14+
- Type 4 standard
- No acceleration for smoother ride

---

## Step 14: Quick Reference Template

**Universal Rideable Template** (copy-paste ready):
```csv
"chr###","r###_fn01","r###_fw01","",10,0,1,-1,-1,-1,-1,4,10,"fe02","F01"
```

**Replace `###`** with 3-digit Digimon ID (e.g., 001, 027, 135)

**Adjust speed** (column 4) based on preference:
- 6 = Slow
- 10 = Medium (recommended default)
- 14 = Fast
- 20 = Very fast

---

## Step 15: Complete Example

### Making Agumon (Black) Rideable:

**Assuming Agumon (Black) is chr850**:

**Step 1**: Add to `001_field_digi_ride_animation.csv`:
```csv
"chr850","r850_fn01","r850_fw01","",8,0,1,-1,-1,-1,-1,0,8,"fe02","F01"
```

**Step 2**: Test in game
- Speed: 8 (appropriate for small Digimon)
- Type: 0 (basic ground)

**Step 3**: Adjust if needed
- If too slow, increase to 10-12
- If animations glitch, try type 4

---

## DLC Digimon

### DLC 17 Example (from addcont_17):

**Location**: `addcont_17.dx11/data/field_anime_dlc17/field_anime_dlc17.mbe/`

DLC Digimon follow the same format, just in DLC folders.

---

## Important Verification

### ✅ PRIMARY FILE: Animation CSV (Required)

**ONLY the animation CSV file is required** to make a Digimon rideable:
- ✅ Simply adding a Digimon to `001_field_digi_ride_animation.csv` makes it rideable!

### ⚠️ SECONDARY FILE: Model Setting (Optional but Recommended)

**`model_setting.mbe/000_model_setting.csv` - Column 71** contains a rideable indicator:
- **Value 0** = Not rideable (639 Digimon)
- **Value 1** = Rideable (29 Digimon - mostly small/medium)
- **Value 2** = Rideable (137 Digimon - mostly large)

**Pattern Found:**
- Most rideable Digimon have Column 71 = `1` or `2`
- Most non-rideable have Column 71 = `0`
- A few exceptions exist (6 non-rideable have value `2`)

**Recommendation**: When adding a new rideable Digimon, also set Column 71 in model_setting.csv to `1` or `2` based on size.

### Files That DON'T Need Editing:
- ❌ `000_digimon_status_data.csv` - No rideable flag exists
- ❌ Trait flags (columns 19-59) - None control rideable status
- ❌ Flag system - No unlock flags needed
- ❌ UI files - Automatically detects from animation file

**Bottom Line**: 
1. **Must edit**: `001_field_digi_ride_animation.csv` ⭐
2. **Should also edit**: `000_model_setting.csv` Column 71 (set to 1 or 2) ✅

---

## Tips & Warnings

1. **Always backup original files** before editing
2. **Start with universal template** (speed 10, type 4)
3. **Test each Digimon** after adding
4. **Check CSV syntax** (commas, quotes must be correct)
5. **Animation files may not exist** for all Digimon
6. **Some Digimon may clip through ground** (adjust if needed)
7. **Flying Digimon work the same** as ground Digimon
8. **Very small Digimon may look odd** when ridden
9. **Speed affects gameplay** - don't make everything too fast
10. **Column order matters** - don't rearrange columns
11. **Only patch.dx11 file matters** - ignore app_0.dx11 version

---

## Recommended Workflow

### Making All Digimon Rideable:

1. Get list of all chr IDs (check char_info or digimon_status files)
2. Open `001_field_digi_ride_animation.csv`
3. Check which chr IDs are already there (167 exist)
4. For each missing chr ID, add entry using universal template
5. Set speeds based on Digimon size/type
6. **Also edit `model_setting.csv`**:
   - Open `patch.dx11/data/model_setting/model_setting.mbe/000_model_setting.csv`
   - Find the row for your chr ID
   - Set Column 71 to `1` (small/medium) or `2` (large)
7. Save both files
8. Test in-game
9. Adjust speeds/types as needed

### Quick Example - Making Agumon Rideable:

**Step 1**: Add to `001_field_digi_ride_animation.csv`:
```csv
"chr050","r050_fn01","r050_fw01","",8,0,1,-1,-1,-1,-1,0,8,"fe02","F01"
```

**Step 2**: Edit `000_model_setting.csv` (find chr050 row):
- Change Column 71 from `0` to `1` (small Digimon)

**Step 3**: Test!

---

## Advanced: Custom Speeds Per Digimon

### Example Custom Speed Setup:

**Rookies (chr 001-100)**:
```csv
"chr010","r010_fn01","r010_fw01","",6,0,1,-1,-1,-1,-1,0,8,"fe02","F01"
```

**Champions (chr 101-200)**:
```csv
"chr110","r110_fn01","r110_fw01","",9,0,1,-1,-1,-1,-1,0,12,"fe02","F01"
```

**Ultimates (chr 201-300)**:
```csv
"chr210","r210_fn01","r210_fw01","",12,0,1,-1,-1,-1,-1,4,12,"fe02","F01"
```

**Megas (chr 301-400)**:
```csv
"chr310","r310_fn01","r310_fw01","",14,0,1,-1,-1,-1,-1,4,14,"fe02","F01"
```

---

## Quick Start Checklist

To make a single Digimon rideable:

- [ ] Find Digimon's chr ID
- [ ] Copy universal template
- [ ] Replace ### with chr ID
- [ ] Set appropriate speed (6-14)
- [ ] Add to `001_field_digi_ride_animation.csv`
- [ ] Save file
- [ ] Test in game

To make ALL Digimon rideable:

- [ ] Get complete list of chr IDs
- [ ] Use universal template for all
- [ ] Generate entries (manual or script)
- [ ] Add all entries to CSV
- [ ] Save file
- [ ] Test multiple Digimon

---

**End of Guide**

**Total Default Rideable Digimon**: 167  
**Potential Total**: 900+ (all Digimon in game)

**Safe Speed Range**: 6-16  
**Recommended Universal Speed**: 10

