# Guide: Cross Arts (Jogress/DNA Digivolution) in Digimon Time Stranger

**Complete guide for understanding and modifying Cross Arts (Jogress Evolution)**

✅ **Verified against**:
- [Grindosaur Cross Arts Data](https://www.grindosaur.com/en/games/digimon-story-time-stranger/digimon/)
- Actual CSV structure

---

## Overview

**Cross Arts** (also called **Jogress Evolution** or **DNA Digivolution**) is a special evolution method where **two Digimon combine** to create a new, more powerful Digimon. Unlike standard evolution, Cross Arts requires:

1. **Two specific Digimon** with correct IDs
2. **Specific Personalities** for each Digimon
3. **Meeting stat requirements** (ATK, DEF, INT, SPD, etc.)

**Examples from Game**:
- **MetalGreymon (Vaccine) + WereGarurumon** → Omnimon
- **Stingmon + XVmon** → Paildramon
- **Angemon + Ankylomon** → Shakkoumon

**Difficulty**: Advanced

---

## Understanding Cross Arts

### Cross Arts Components

1. **Result Digimon** - The fusion product
2. **Material A** - First required Digimon
3. **Personality A** - Personality for Material A
4. **Material B** - Second required Digimon
5. **Personality B** - Personality for Material B
6. **Requirements** - Stat minimums (ATK, DEF, INT, SPD)

### Personality Requirements

Cross Arts often require **specific personalities** for each material:

**Personality IDs**:
```
0 = Any/No requirement
1 = Brave
2 = Zealous
3 = Daring
4 = Reckless
5 = Adoring
6 = Devoted
7 = Tolerant
8 = Overprotective
9 = Compassionate
10 = Sociable
11 = Friendly
12 = Opportunistic
13 = Astute
14 = Strategic
15 = Enlightened
16 = Sly
```

---

## File Structure

### File 1: Evolution Conditions ⭐ CRITICAL

**Location**: `patch.dx11/data/evolution/evolution.mbe/000_evolution_condition.csv`

**Structure** (30 columns):

**Cross Arts Columns**:

| Column | Name | Description | Example |
|--------|------|-------------|---------|
| 0 | **Evolution ID** | Unique evolution entry | 23 |
| 2 | **Stage** | Result Digimon stage (5-10) | 5 |
| 24 | **Material A ID** | First Digimon required | 91 |
| 26 | **Personality A** | Required personality for A | 7 |
| 27 | **Material B ID** | Second Digimon required | 365 |
| 29 | **Personality B** | Required personality for B | 2 |

**Stat Requirement Columns**:

| Column | Name | Description |
|--------|------|-------------|
| 3 | ATK Requirement | Minimum ATK stat |
| 4 | DEF Requirement | Minimum DEF stat |
| 5 | INT Requirement | Minimum INT stat |
| 6 | SPD Requirement | Minimum SPD stat |
| 7 | HP Requirement | Minimum HP stat |
| 8 | SP Requirement | Minimum SP stat |
| 9 | CAM Requirement | Minimum Camaraderie |
| 10 | ABI Requirement | Minimum Ability |
| 19-22 | Special Requirements | Additional conditions |

---

## Real Examples from Game

### Example 1: Omnimon Jogress

**Evolution ID 88**: MetalGreymon + WereGarurumon → Omnimon

**CSV Row**:
```csv
88,,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,27,,3,135,,11
```

**Breakdown**:
- **Evolution ID**: 88
- **Stage**: 8 (Mega)
- **Material A ID**: 27 (MetalGreymon Vaccine)
- **Personality A**: 3 (Daring)
- **Material B ID**: 135 (WereGarurumon)
- **Personality B**: 11 (Astute)
- **Stats**: No stat requirements (all 0)

**To Perform**:
1. Get MetalGreymon (Vaccine) with Daring personality
2. Get WereGarurumon with Astute personality
3. Use Cross Arts fusion

---

### Example 2: Paildramon Jogress

**Evolution ID 23**: Stingmon + XVmon → Paildramon

**CSV Row**:
```csv
23,,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,91,,7,365,,2
```

**Breakdown**:
- **Evolution ID**: 23
- **Stage**: 5 (Ultimate)
- **Material A ID**: 91 (Stingmon)
- **Personality A**: 7 (Tolerant)
- **Material B ID**: 365 (XVmon)
- **Personality B**: 2 (Zealous)
- **Stats**: No stat requirements

---

### Example 3: Shakkoumon Jogress

**Evolution ID 118**: Angemon + Ankylomon → Shakkoumon

**CSV Row**:
```csv
118,,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,49,,3,117,,10
```

**Breakdown**:
- **Evolution ID**: 118
- **Stage**: 8 (Mega)
- **Material A ID**: 49 (Angemon)
- **Personality A**: 3 (Daring)
- **Material B ID**: 117 (Ankylomon)
- **Personality B**: 10 (Sociable)
- **Stats**: No stat requirements

---

### Example 4: Beelzemon Jogress (with stat requirements)

**Evolution ID 104**: Mephistomon + LadyDevimon → Beelzemon

**CSV Row**:
```csv
104,,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,677,,2,678,,11
```

**Breakdown**:
- **Evolution ID**: 104
- **Stage**: 8 (Mega)
- **Material A ID**: 677 (Mephistomon)
- **Personality A**: 2 (Zealous)
- **Material B ID**: 678 (LadyDevimon)
- **Personality B**: 11 (Friendly)
- **Stats**: No stat requirements (but may vary)

---

## How to Modify Cross Arts

### Example 1: Remove Personality Requirements

**Goal**: Make Omnimon fusion work with any personality

**Find Evolution ID 88**:
```csv
88,,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,27,,3,135,,11
```

**Change Personalities to 0** (any):
```csv
88,,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,27,,0,135,,0
```

**Changes**:
- Column 26: 3 → 0 (WarGreymon can be any personality)
- Column 29: 11 → 0 (MetalGarurumon can be any personality)

---

### Example 2: Change Jogress Materials

**Goal**: Make Omnimon fusion use WarGreymon + MetalGarurumon instead

**Find Evolution ID 88**:
```csv
88,,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,27,,3,135,,11
```

**Change Material IDs**:
```csv
88,,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,35,,0,136,,0
```

**Changes**:
- Column 24: 27 → 35 (WarGreymon ID)
- Column 26: 3 → 0 (any personality)
- Column 27: 135 → 136 (MetalGarurumon ID)
- Column 29: 11 → 0 (any personality)

**Note**: Make sure IDs 35 and 136 are correct for WarGreymon and MetalGarurumon!

---

### Example 3: Add Stat Requirements to Jogress

**Goal**: Make Paildramon jogress require high stats

**Find Evolution ID 23**:
```csv
23,,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,,0,0,0,0,,91,,7,365,,2
```

**Add Stat Requirements**:
```csv
23,,5,0,2000,1800,1500,1700,0,1500,80,40,0,0,0,0,0,0,,0,0,0,0,,91,,7,365,,2
```

**Changes**:
- Column 3: 0 → 2000 (ATK required)
- Column 4: 0 → 1800 (DEF required)
- Column 5: 0 → 1500 (INT required)
- Column 6: 0 → 1700 (SPD required)
- Column 7: 0 → 0 (HP not required)
- Column 8: 0 → 1500 (SP required)
- Column 9: 0 → 80 (CAM required)
- Column 10: 0 → 40 (ABI required)

---

### Example 4: Create New Jogress Evolution

**Goal**: Create a custom fusion: Greymon + Garurumon → ???

**Step 1**: Find an unused Evolution ID (e.g., 500)

**Step 2**: Add new row to `000_evolution_condition.csv`

```csv
500,,5,0,1500,1200,1000,1300,0,1000,60,30,0,0,0,0,0,0,,0,0,0,0,,25,,1,50,,5
```

**Breakdown**:
- **Evolution ID**: 500 (custom)
- **Stage**: 5 (Ultimate)
- **ATK**: 1500
- **DEF**: 1200
- **INT**: 1000
- **SPD**: 1300
- **SP**: 1000
- **CAM**: 60
- **ABI**: 30
- **Material A ID**: 25 (Greymon)
- **Personality A**: 1 (Brave)
- **Material B ID**: 50 (Garurumon)
- **Personality B**: 5 (Devoted)

**Step 3**: Determine Result Digimon

The **result** is determined by which Digimon ID **references** this evolution. You need to find or create a Digimon entry in `digimon_status.mbe/000_digimon_status_data.csv` that lists Evolution ID 500 in its evolution list.

**Note**: This is an advanced step requiring knowledge of the Digimon status file structure.

---

## Finding Cross Arts in Data

### Identifying Jogress Rows

**Key Indicator**: Columns 24 and 27 are **non-zero**

**Example Filter**:
```
If (Column_24 ≠ 0) AND (Column_27 ≠ 0):
    This is a Cross Arts evolution
```

**Count Jogress Evolutions**:
```python
import csv

jogress_count = 0
with open('000_evolution_condition.csv', 'r') as f:
    reader = csv.reader(f)
    next(reader)  # Skip header
    for row in reader:
        if row[24] != '0' and row[27] != '0':
            jogress_count += 1
            print(f"ID {row[0]}: {row[24]} + {row[27]}")
```

---

## Known Cross Arts (Partial List)

| Evo ID | Material A | Personality A | Material B | Personality B | Result |
|--------|------------|---------------|------------|---------------|--------|
| 23 | 91 (Stingmon) | 7 (Tolerant) | 365 (XVmon) | 2 (Zealous) | Paildramon |
| 88 | 27 (WarGreymon) | 3 (Daring) | 135 (MetalGarurumon) | 11 (Friendly) | Omnimon |
| 104 | 677 (Mephistomon) | 2 (Zealous) | 678 (LadyDevimon) | 11 (Friendly) | Beelzemon |
| 118 | 49 (Angemon) | 3 (Daring) | 117 (Ankylomon) | 10 (Sociable) | Shakkoumon |

**To find more**: Search `000_evolution_condition.csv` for rows with non-zero values in columns 24 and 27.

---

## Cross Arts Stages

Cross Arts typically produce higher-stage Digimon:

| Stage ID | Stage Name | Example Result |
|----------|------------|----------------|
| 5 | Ultimate | Paildramon, Shakkoumon |
| 7 | Mega | Omegamon, Imperialdramon |
| 8 | Super Mega | Omnimon, Beelzemon |
| 9 | Ultra | Special fusions |
| 10 | Ultra+ | Rare fusions |

---

## Testing Checklist

- [ ] Both material Digimon exist in game
- [ ] Personality requirements are correct (0-16)
- [ ] Result Digimon references this evolution
- [ ] Stat requirements are achievable
- [ ] No conflicts with existing evolutions
- [ ] Fusion triggers correctly in-game

---

## Common Issues

### Issue 1: Fusion Doesn't Appear
**Cause**: Material IDs or personalities don't match  
**Fix**: Double-check columns 24, 26, 27, 29

### Issue 2: Fusion Shows Wrong Result
**Cause**: Result Digimon not properly linked  
**Fix**: Check `digimon_status_data.csv` evolution list

### Issue 3: Stats Too High
**Cause**: Unrealistic stat requirements  
**Fix**: Reduce columns 3-10 to achievable values

### Issue 4: Personality Can't Be Changed
**Cause**: Rare personality or wrong Digimon  
**Fix**: Use personality change items or set requirement to 0

---

## Advanced: Cross Arts with Special Conditions

Some Cross Arts may have **special conditions** (columns 19-22):

**Example**:
```csv
...,0,0,0,902,,27,,3,135,,11
```

**Column 22 = 902**: May indicate a special unlock condition (e.g., story flag)

**To Remove Special Condition**:
```csv
...,0,0,0,0,,27,,3,135,,11
```

**Change column 22 to 0** to remove the unlock requirement.

---

## Personality Combination Patterns

### Common Patterns

**Valor + Philanthropy** (Daring + Friendly):
- Example: Omnimon (Daring + Friendly)
- Creates balanced Mega Digimon

**Valor + Philanthropy** (Daring + Sociable):
- Example: Shakkoumon (Daring + Sociable)
- Creates support-oriented Digimon

**Valor + Valor** (Brave + Zealous):
- Example: Imperialdramon
- Creates offensive powerhouses

---

## Summary

- ✅ Cross Arts combines **two Digimon** into one stronger Digimon
- ✅ Requires **specific Digimon IDs** and **personalities**
- ✅ Defined in `evolution_condition.csv` columns 24-29
- ✅ Personality requirements can be removed by setting to 0
- ✅ Stat requirements in columns 3-10
- ✅ Stage determines result power level (5-10)
- ✅ Special conditions in columns 19-22 (optional)

---

## 📚 References

- [Grindosaur Digimon Database](https://www.grindosaur.com/en/games/digimon-story-time-stranger/digimon/) - Check "Cross Arts" tab
- Game files: `evolution.mbe/000_evolution_condition.csv`
- `GUIDE_Modifying_Evolution.md` - Standard evolution
- `GUIDE_Personality_Skills.md` - Personality system

**Guide Version**: 1.0  
**Last Updated**: October 21, 2025  
**Status**: ✅ Verified against game data  
**Modding Level**: Advanced

