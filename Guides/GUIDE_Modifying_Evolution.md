# Guide: Modifying Evolution Paths in Digimon Time

**Complete guide for changing evolution requirements and digivolution trees**

---

## Overview

Evolution (Digivolution) in Digimon Time is controlled by requirements including level, stats, CAM (Camaraderie), ABI (Ability), and sometimes items. This guide shows you how to modify existing paths or create entirely new evolution trees.

**Estimated Files to Edit**: 3-15 files

**Difficulty**: Intermediate

---

## Understanding Evolution System

### Evolution Components:
1. **Base Digimon** - The starting form
2. **Target Digimon** - The evolution result
3. **Requirements** - Conditions that must be met
4. **Evolution Type** - Normal, special, or triggered

### Requirement Types:
- **Level** - Digimon's current level
- **Stats** - ATK, DEF, INT, SPD values
- **CAM** - Camaraderie/friendship (0-100)
- **ABI** - Ability stat from training (0-100)
- **Item** - Special evolution item required
- **Special Conditions** - Story flags, time of day, etc.

---

## Step 1: Core Evolution Table

### File 1: Evolution Table ⭐ CRITICAL

**Location**: `patch.dx11/data/evolution/evolution.mbe/000_evolution_table.csv`

**Structure**:
```csv
Base_ID,Target_ID,Level,ATK,DEF,INT,SPD,CAM,ABI,Item_ID,Special_Flag
```

**Column Guide** (11 total columns):

| Column | Name | Example | Description |
|--------|------|---------|-------------|
| 0 | Base Digimon ID | 50 | Starting Digimon |
| 1 | Target Digimon ID | 100 | Evolution result |
| 2 | Level Required | 20 | Minimum level |
| 3 | ATK Required | 200 | Minimum ATK stat |
| 4 | DEF Required | 180 | Minimum DEF stat |
| 5 | INT Required | 150 | Minimum INT stat |
| 6 | SPD Required | 170 | Minimum SPD stat |
| 7 | CAM Required | 50 | Minimum Camaraderie |
| 8 | ABI Required | 20 | Minimum Ability |
| 9 | Item Required | -1 | Item ID or -1 for none |
| 10 | Special Condition | false | Requires special flag |

---

## Step 2: Common Evolution Scenarios

### Scenario 1: Make Evolution Easier

**Example**: Reduce requirements for Agumon → Greymon

**Find the row**:
```csv
10,25,20,200,180,150,170,50,20,-1,false
```

**Change to**:
```csv
10,25,15,150,130,100,120,30,10,-1,false
```

**Changes**:
- Level: 20 → 15
- ATK: 200 → 150
- DEF: 180 → 130
- INT: 150 → 100
- SPD: 170 → 120
- CAM: 50 → 30
- ABI: 20 → 10

### Scenario 2: Make Evolution Harder

**Example**: Make Mega evolutions more challenging

**Original**:
```csv
100,200,35,400,350,300,340,70,40,-1,false
```

**Change to**:
```csv
100,200,50,600,550,500,540,90,80,-1,false
```

**Changes**:
- Level: 35 → 50
- All stats significantly increased
- CAM: 70 → 90
- ABI: 40 → 80

### Scenario 3: Require Evolution Item

**Example**: Add item requirement to special evolution

**Original**:
```csv
75,150,30,300,280,250,270,60,30,-1,false
```

**Change to**:
```csv
75,150,30,300,280,250,270,60,30,5300,false
```

**Changes**:
- Item Required: -1 → 5300 (Data Crystal)
- Now requires holding item 5300 to evolve

### Scenario 4: Remove All Requirements (Easy Mode)

**Example**: Allow instant evolution at low level

```csv
10,25,1,0,0,0,0,0,0,-1,false
```

**Properties**:
- Level 1 minimum
- All stat requirements = 0
- No CAM/ABI needed
- No item required

### Scenario 5: Stat-Focused Evolution

**Example**: Physical fighter path (high ATK, low INT)

```csv
50,100,25,500,300,100,350,50,20,-1,false
```

**Properties**:
- High ATK (500) and SPD (350)
- Low INT (100)
- This naturally guides training

**Example**: Magical path (high INT, low ATK)

```csv
50,101,25,100,300,500,350,50,20,-1,false
```

**Properties**:
- High INT (500) and SPD (350)
- Low ATK (100)
- Evolves to different form than physical

---

## Step 3: Adding New Evolution Paths

### Example: Add Alternative Evolution

**Goal**: Make Digimon 50 also evolve into Digimon 102 (new option)

**Add new row**:
```csv
50,102,22,180,200,220,190,40,15,-1,false
```

**Result**: Digimon 50 now has TWO evolution options:
- Path A: → 100 (physical fighter stats)
- Path B: → 102 (balanced stats)

### Example: Create Branching Tree

**Rookie → Three Champions**

```csv
# Path 1: Fire Champion (high ATK)
20,40,18,250,150,100,180,40,10,-1,false

# Path 2: Water Champion (high DEF)
20,41,18,150,250,180,160,40,10,-1,false

# Path 3: Plant Champion (high INT)
20,42,18,100,150,250,180,40,10,-1,false
```

**Result**: Digimon 20 has three evolution options based on which stats you train.

---

## Step 4: Special Evolution Conditions

### File 2: Special Evolution Flags

**Location**: `patch.dx11/data/evolution/evolution.mbe/001_special_conditions.csv`

**Add special requirements**:

```csv
50,100,1,5,0,false,true
```

**Column Guide**:

| Column | Name | Description |
|--------|------|-------------|
| 0 | Base ID | Starting Digimon |
| 1 | Target ID | Evolution result |
| 2 | Time of Day | 0=Any, 1=Morning, 2=Day, 3=Evening, 4=Night |
| 3 | Story Chapter | Minimum story progress |
| 4 | Battle Count | Minimum battles participated |
| 5 | Defeat Required | Must defeat specific enemy first |
| 6 | Special Event | Requires special event flag |

**Examples**:

**Night-Only Evolution**:
```csv
50,103,4,0,0,false,false
```

**Late-Game Evolution**:
```csv
50,104,0,10,0,false,false
```

**Battle Veteran Evolution**:
```csv
50,105,0,0,100,false,false
```

---

## Step 5: De-evolution System

### File 3: De-evolution Table

**Location**: `patch.dx11/data/evolution/evolution.mbe/002_devolve_table.csv`

**Add de-evolution options**:

```csv
100,50,5,true
```

**Column Guide**:

| Column | Name | Description |
|--------|------|-------------|
| 0 | Current ID | Digimon to de-evolve from |
| 1 | Target ID | Digimon to de-evolve into |
| 2 | Cost | Digi-Entelechy cost |
| 3 | Allowed | Can de-evolve (true/false) |

**Example**: Create full de-evolution chain

```csv
# Mega → Ultimate
200,100,10,true

# Ultimate → Champion
100,50,7,true

# Champion → Rookie
50,20,5,true

# Rookie → In-Training
20,10,3,true
```

---

## Step 6: DNA/Jogress Evolution

### File 4: Fusion Evolution Table

**Location**: `patch.dx11/data/evolution/evolution.mbe/003_jogress_table.csv`

**Add DNA Digivolution**:

```csv
50,75,200,30,40,60,500,-1,false
```

**Column Guide**:

| Column | Name | Description |
|--------|------|-------------|
| 0 | Base ID 1 | First Digimon |
| 1 | Base ID 2 | Second Digimon |
| 2 | Result ID | Fusion result |
| 3 | Level Required | Both must be this level |
| 4 | CAM Required | Between the two Digimon |
| 5 | ABI Required | Combined ABI |
| 6 | Cost | Fusion cost |
| 7 | Item Required | Special item or -1 |
| 8 | Special Flag | Requires story progress |

**Example**: Classic DNA Evolution

```csv
# Agumon + Gabumon = Omnimon
10,15,300,50,80,60,10000,-1,false

# ExVeemon + Stingmon = Paildramon
120,125,250,35,70,40,5000,-1,false
```

---

## Step 7: Evolution Visualization

### File 5: Evolution Tree Display

**Location**: `patch.dx11/data/evolution/evolution.mbe/004_tree_display.csv`

**Control how evolution appears in menu**:

```csv
50,100,1,2,true,0
```

**Column Guide**:

| Column | Name | Description |
|--------|------|-------------|
| 0 | Base ID | Starting Digimon |
| 1 | Target ID | Evolution result |
| 2 | Display Column | X position in tree (1-5) |
| 3 | Display Row | Y position in tree (1-10) |
| 4 | Visible | Show in tree menu |
| 5 | Color | 0=Normal, 1=Special, 2=DNA |

**Example**: Organize evolution tree layout

```csv
# Rookie (column 1)
10,50,1,1,true,0
10,51,1,2,true,0

# Champion (column 2)
50,100,2,1,true,0
51,101,2,2,true,0

# Ultimate (column 3)
100,200,3,1,true,0
101,201,3,2,true,0

# Mega (column 4)
200,300,4,1,true,0

# Special DNA (column 5, different color)
100,101,350,5,1,true,2
```

---

## Complete Examples

### Example 1: Easy Mode Evolution Tree

**All evolutions at level 10, no stat requirements**

```csv
# In-Training → Rookie
1,10,10,0,0,0,0,0,0,-1,false

# Rookie → Champion
10,50,10,0,0,0,0,0,0,-1,false

# Champion → Ultimate
50,100,10,0,0,0,0,0,0,-1,false

# Ultimate → Mega
100,200,10,0,0,0,0,0,0,-1,false
```

### Example 2: Balanced Progression

**Standard JRPG-style progression**

```csv
# In-Training → Rookie (Level 5)
1,10,5,0,0,0,0,10,0,-1,false

# Rookie → Champion (Level 18, basic stats)
10,50,18,180,160,140,170,30,10,-1,false

# Champion → Ultimate (Level 32, good stats)
50,100,32,350,320,300,330,60,30,-1,false

# Ultimate → Mega (Level 48, high stats + item)
100,200,48,550,520,500,530,80,60,5300,false
```

### Example 3: Branching Elemental Tree

**Rookie with 4 element-based Champions**

```csv
# Rookie base
5,30,0,0,0,0,0,0,0,0,-1,false

# Fire Champion (high ATK)
30,60,20,300,200,150,250,40,20,-1,false

# Water Champion (high DEF)
30,61,20,200,300,200,220,40,20,-1,false

# Plant Champion (high INT)
30,62,20,150,200,300,230,40,20,-1,false

# Electric Champion (high SPD)
30,63,20,200,180,180,350,40,20,-1,false
```

### Example 4: Special Item Evolution

**Ancient evolution requiring rare crystal**

```csv
# Normal path (standard)
50,100,25,300,280,260,290,50,25,-1,false

# Ancient path (requires item)
50,110,25,280,300,280,270,60,30,5400,false
```

Add item 5400 (Ancient Crystal) to make path available.

### Example 5: DNA Fusion Tree

**Two Champions fuse into special Ultimate**

```csv
# Normal evolutions
50,100,30,350,320,300,330,60,30,-1,false
60,110,30,320,350,330,310,60,30,-1,false

# DNA Fusion option (more powerful)
50,60,120,35,75,50,8000,-1,false
```

Result: Can evolve normally OR fuse together for special Digimon 120.

---

## Evolution Requirement Guidelines

### Level Requirements by Stage:

| Stage | Min Level | Recommended | Hard Mode |
|-------|-----------|-------------|-----------|
| Baby → In-Training | 1 | 3 | 5 |
| In-Training → Rookie | 5 | 8 | 12 |
| Rookie → Champion | 15 | 20 | 25 |
| Champion → Ultimate | 28 | 35 | 42 |
| Ultimate → Mega | 42 | 50 | 60 |

### Stat Requirements by Stage:

| Stage | Easy | Normal | Hard |
|-------|------|--------|------|
| Champion | 100-150 | 180-220 | 250-300 |
| Ultimate | 250-300 | 350-400 | 450-500 |
| Mega | 400-450 | 550-600 | 700-800 |

### CAM Requirements:

| Stage | Min CAM | Recommended |
|-------|---------|-------------|
| Champion | 20 | 40 |
| Ultimate | 40 | 65 |
| Mega | 60 | 85 |
| Special | 80 | 100 |

### ABI Requirements:

| Stage | Min ABI | Recommended |
|-------|---------|-------------|
| Champion | 0 | 15 |
| Ultimate | 15 | 35 |
| Mega | 35 | 60 |
| Special | 60 | 80 |

---

## Testing Checklist

- [ ] All Base IDs exist (valid Digimon)
- [ ] All Target IDs exist (valid Digimon)
- [ ] Requirements are achievable
- [ ] Item IDs are valid (or -1 for none)
- [ ] Special conditions are properly flagged
- [ ] De-evolution paths work correctly
- [ ] DNA fusion pairs are valid
- [ ] Evolution tree displays correctly
- [ ] No circular evolutions (A→B→A)
- [ ] Balance is appropriate for game difficulty

---

## Common Issues & Solutions

### Issue: Evolution option doesn't appear
**Solution**: Check that Digimon meets level requirement AND at least one stat requirement

### Issue: Evolution grayed out
**Solution**: Check item requirement (column 9). If not -1, must have that item

### Issue: DNA fusion not available
**Solution**: Both Digimon must be in party and meet level/CAM requirements

### Issue: De-evolution costs too much
**Solution**: Adjust cost in devolve_table.csv (column 2)

### Issue: Evolution tree looks messy
**Solution**: Adjust display positions in tree_display.csv (columns 2-3)

### Issue: Wrong Digimon appears after evolution
**Solution**: Check Target ID (column 1) - must be exact match

---

## Advanced Tips

### Tip 1: Create Evolution Loops
```csv
# Forward evolution
50,100,25,300,280,260,290,50,25,-1,false

# De-evolution
100,50,5,true

# Different forward path after de-evolution
50,105,25,280,300,290,270,50,25,-1,false
```

**Result**: Can evolve → de-evolve → evolve to different form

### Tip 2: Stat-Based Branching
```csv
# High ATK = Physical evolution
50,100,25,500,200,150,300,50,20,-1,false

# High INT = Magical evolution
50,101,25,150,200,500,300,50,20,-1,false

# Balanced = Hybrid evolution
50,102,25,350,350,350,350,50,20,-1,false
```

**Result**: Natural role specialization through training

### Tip 3: Time-Gated Evolutions
```csv
# Normal form (any time)
50,100,25,300,280,260,290,50,25,-1,false

# Dark form (night only)
50,103,25,280,260,300,290,50,25,-1,false
```

Add time condition in special_conditions.csv.

### Tip 4: Progressive Item Evolution
```csv
# Tier 1 (no item)
50,100,25,300,280,260,290,50,25,-1,false

# Tier 2 (basic item)
100,200,40,500,480,460,490,70,40,5301,false

# Tier 3 (rare item)
200,300,55,700,680,660,690,90,60,5302,false
```

**Result**: Three tiers of evolution with increasing item requirements

### Tip 5: DNA Evolution Combos
```csv
# Combo 1: Fire + Water = Steam
10,15,50,30,60,40,5000,-1,false

# Combo 2: Fire + Plant = Ash
10,20,51,30,60,40,5000,-1,false

# Combo 3: Water + Plant = Forest
15,20,52,30,60,40,5000,-1,false
```

**Result**: Multiple DNA combinations from same base Digimon

---

## Summary: File Checklist

**Required (1 file)**:
- ✅ `evolution_table.csv` - Core evolution paths

**Optional but Recommended (4 files)**:
- ⭕ `special_conditions.csv` - Time/story requirements
- ⭕ `devolve_table.csv` - De-evolution options
- ⭕ `jogress_table.csv` - DNA Digivolution
- ⭕ `tree_display.csv` - Menu organization

---

**Happy Evolution Modding!** 🔄✨

*For Digimon stats and IDs, see COMPREHENSIVE_FILE_DOCUMENTATION.md*
*For evolution items, see GUIDE_Adding_New_Items.md*

