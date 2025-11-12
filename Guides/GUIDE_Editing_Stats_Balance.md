# Guide: Editing Stats & Game Balance in Digimon Time

**Complete guide for modifying Digimon stats, difficulty, and game balance**

---

## Overview

This guide covers modifying Digimon base stats, growth rates, enemy difficulty, experience/money rewards, and overall game balance. Perfect for creating harder difficulties, easy modes, or rebalancing for personal preference.

**Estimated Files to Edit**: 1-20 files (depending on scope)

**Difficulty**: Intermediate

---

## Part 1: Digimon Base Stats

### File 1: Digimon Status Database ⭐ CRITICAL

**Location**: `patch.dx11/data/digimon_status/digimon_status.mbe/000_digimon_status_data.csv`

**Key Stat Columns** (✅ Verified against Grindosaur.com):

| Column | Stat Name | Description | Typical Range |
|--------|-----------|-------------|---------------|
| 61 | Base Personality | Personality type | 0-16 |
| 62 | Unknown | Unknown field | 1 |
| 63 | Max Level | Level cap | 99 |
| 64 | Base HP | Starting health | 200-1500 |
| 65 | Base SP | Starting SP | 100-800 |
| 66 | Base ATK | Physical attack | 80-600 |
| 67 | Base DEF | Physical defense | 70-550 |
| 68 | Base INT | Magic/Special | 60-500 |
| 69 | Base SPI | Spirit/Magic Defense | 60-500 |
| 70 | Base SPD | Speed/turn order | 80-600 |

### Quick Stat Modifications

**Example**: Make Agumon (ID 10) stronger

**Find row 10** (columns 64-70 are the stats):
```csv
10,,"char_AGUMON","chr010",3,1,1,...[cols 7-63]...,600,350,180,160,140,170,150,...
```

**Modify columns 64-70** (HP, SP, ATK, DEF, INT, SPI, SPD):
```csv
Original: ...600,350,180,160,140,150,170...  (columns 64-70)
Buffed:   ...900,500,280,260,240,250,270...  (columns 64-70)
```

**Changes**:
- HP (Col 64): 600 → 900 (+50%)
- SP (Col 65): 350 → 500 (+43%)
- ATK (Col 66): 180 → 280 (+56%)
- DEF (Col 67): 160 → 260 (+62%)
- INT (Col 68): 140 → 240 (+71%)
- SPI (Col 69): 150 → 250 (+67%)
- SPD (Col 70): 170 → 270 (+59%)

---

## Part 2: Elemental Resistances ⭐ NEW!

### File 1 (continued): Resistance System

**Columns 7-17** control ELEMENTAL RESISTANCES (verified against Grindosaur.com).

**⚠️ IMPORTANT**: Resistances are **PER-DIGIMON**, not global!

| Column | Element | Effect |
|--------|---------|--------|
| 7 | Null | Typeless attacks |
| 8 | Fire | Fire attacks |
| 9 | Water | Water attacks |
| 10 | Ice | Ice attacks |
| 11 | Grass | Grass/Plant attacks |
| 12 | Wind | Wind attacks |
| 13 | Electric | Electric attacks |
| 14 | Ground | Ground/Earth attacks |
| 15 | Steel | Steel/Metal attacks |
| 16 | Light | Light attacks |
| 17 | Dark | Dark attacks |

**Resistance Values**:
```
0 = Normal damage (1.0x)
1 = Weak to element (1.5x damage taken)
2 = Very Weak (2.0x damage taken)
3 = Resistant (0.5x damage taken)
4 = Very Resistant (0.25x damage taken)
5 = Immune (0x damage taken)
```

**Example**: Make Agumon Fire-Resistant, Water-Weak

```csv
Original columns 7-17: 0,0,0,0,0,0,0,0,0,0,0  (all normal)
Modified columns 7-17: 0,3,1,0,0,0,1,0,0,0,0  (fire=resist, water=weak, electric=weak)
```

**Example**: Make Gabumon Ice-Immune, Fire-Weak

```csv
Original columns 7-17: 0,0,0,0,0,0,0,0,0,0,0  (all normal)
Modified columns 7-17: 0,1,0,5,0,0,0,0,0,0,0  (fire=weak, ice=immune)
```

**Example**: Kuramon's Actual Resistances (from Grindosaur)

```csv
Columns 7-17: 1,0,3,1,0,0,1,1,3,0,3  
Breakdown:
- Null: 1 (Weak)
- Fire: 0 (Normal)
- Water: 3 (Resistant!)
- Ice: 1 (Weak)
- Grass: 0 (Normal)
- Wind: 0 (Normal)
- Electric: 1 (Weak)
- Ground: 1 (Weak)
- Steel: 3 (Resistant!)
- Light: 0 (Normal)
- Dark: 3 (Resistant!)
```

---

## Part 3: Stat Growth Rates

### File 1 (continued): Growth Rates

**Columns 128-135** control how stats increase per level.

| Column | Growth Stat | Description |
|--------|-------------|-------------|
| 128 | HP Growth | HP per level |
| 129 | SP Growth | SP per level |
| 130 | ATK Growth | ATK per level |
| 131 | DEF Growth | DEF per level |
| 132 | INT Growth | INT per level |
| 133 | SPD Growth | SPD per level |
| 134 | Growth 7 | Unknown |
| 135 | Growth 8 | Unknown |

**Example**: Make slow growth Digimon

**Original**:
```csv
...220,180,195,165,587,-1,0,-1
```

**Slow Growth** (divide by 2):
```csv
...110,90,97,82,587,-1,0,-1
```

**Fast Growth** (multiply by 2):
```csv
...440,360,390,330,587,-1,0,-1
```

### Growth Rate Guidelines

| Rate | HP/Level | ATK/DEF/INT/SPD per Level |
|------|----------|---------------------------|
| Very Slow | 5-10 | 1-2 |
| Slow | 10-15 | 2-3 |
| Normal | 15-25 | 3-5 |
| Fast | 25-40 | 5-8 |
| Very Fast | 40+ | 8+ |

---

## Part 4: Enemy Difficulty

### File 2: Battle Enemy Stats

**Location**: `patch.dx11/data/battle_enemy/battle_enemy.mbe/000_battle_enemy_list.csv`

**Column Guide**:

| Column | Name | Description |
|--------|------|-------------|
| 0 | Encounter ID | Unique battle ID |
| 1 | Enemy 1 ID | First enemy Digimon |
| 2 | Enemy 1 Level | Level override |
| 3 | Enemy 2 ID | Second enemy (-1 for none) |
| 4 | Enemy 2 Level | Level override |
| 5 | Enemy 3 ID | Third enemy (-1 for none) |
| 6 | Enemy 3 Level | Level override |
| 7 | Formation | Battle formation type |
| 8 | Background | Battle background |
| 9 | Music | Battle music track |
| 10 | AI Pattern | Enemy behavior pattern |
| 11 | Boss Flag | Is boss battle |
| 12 | Escape | Can escape (0=no, 1=yes) |
| 13 | EXP Reward | Experience gained |
| 14 | Money Reward | Money gained |

**Example**: Make Easy Mode (reduce enemy levels by 5)

**Original**:
```csv
100,50,25,51,25,-1,0,1,1,1,1,false,1,5000,500
```

**Easy Mode**:
```csv
100,50,20,51,20,-1,0,1,1,1,1,false,1,5000,500
```

**Example**: Make Hard Mode (increase levels, add third enemy)

**Original**:
```csv
100,50,25,51,25,-1,0,1,1,1,1,false,1,5000,500
```

**Hard Mode**:
```csv
100,50,30,51,30,52,28,1,1,1,2,false,0,5000,500
```

**Changes**:
- Enemy levels: 25 → 30
- Added third enemy (ID 52, level 28)
- Harder AI (1 → 2)
- Can't escape (1 → 0)

---

## Part 5: Experience & Money Rewards

### File 2 (continued): Reward Scaling

**Columns 13-14** control EXP and money.

**Example**: Double rewards for Hard Mode

**Original**:
```csv
...false,1,5000,500
```

**Double Rewards**:
```csv
...false,1,10000,1000
```

**Example**: Reduce rewards for Easy Mode

**Original**:
```csv
...false,1,5000,500
```

**Half Rewards**:
```csv
...false,1,2500,250
```

### Reward Guidelines

**Experience by Area**:
- **Early Game**: 500-2000
- **Mid Game**: 2000-8000
- **Late Game**: 8000-20000
- **Boss**: 20000-50000
- **Super Boss**: 50000+

**Money by Area**:
- **Early Game**: 50-200
- **Mid Game**: 200-800
- **Late Game**: 800-2000
- **Boss**: 2000-10000
- **Super Boss**: 10000+

---

## Part 6: Battle AI Difficulty

### File 3: Enemy AI Patterns

**Location**: `patch.dx11/data/battle_ai/battle_ai.mbe/000_ai_patterns.csv`

**AI Pattern Types** (column 10 of battle_enemy):
- **0**: Passive (rarely attacks, random)
- **1**: Normal (basic strategy)
- **2**: Aggressive (focus on attacks)
- **3**: Smart (targets weaknesses)
- **4**: Defensive (uses buffs/heals)
- **5**: Boss (advanced tactics)
- **6**: Super Boss (optimal play)

**Modify enemy encounter** to change AI:

```csv
# Dumb enemies (AI 0)
100,50,25,51,25,-1,0,1,1,1,0,false,1,5000,500

# Smart enemies (AI 3)
100,50,25,51,25,-1,0,1,1,1,3,false,1,5000,500

# Boss-level enemies (AI 5)
100,50,25,51,25,-1,0,1,1,1,5,false,1,5000,500
```

---

## Part 7: Item Pricing & Availability

### File 4: Item Prices

**Location**: `patch.dx11/data/item/item.mbe/000_item_data.csv`

**Price Columns**:
- **Column 7**: Buy Price
- **Column 8**: Sell Price

**Example**: Make items cheaper (Easy Mode)

**Original** (Mega Potion):
```csv
100,0,2,"MEGA_POTION",0,0,0,500,250,99,true,false,0,1,800,0,0,0,15,true,false,0
```

**Cheap** (50% off):
```csv
100,0,2,"MEGA_POTION",0,0,0,250,125,99,true,false,0,1,800,0,0,0,15,true,false,0
```

**Example**: Make items expensive (Hard Mode)

**Original**:
```csv
100,0,2,"MEGA_POTION",0,0,0,500,250,99,true,false,0,1,800,0,0,0,15,true,false,0
```

**Expensive** (200%):
```csv
100,0,2,"MEGA_POTION",0,0,0,1000,500,99,true,false,0,1,800,0,0,0,15,true,false,0
```

---

## Part 8: Drop Rates

### File 5: Enemy Drops

**Location**: `patch.dx11/data/drop_table/drop_table.mbe/000_enemy_drops.csv`

**Column Guide**:
- Column 0: Enemy ID
- Column 1: Item ID
- Column 2: **Drop Rate %**
- Column 3: Min quantity
- Column 4: Max quantity
- Column 5: Rare drop flag

**Example**: Increase drop rates

**Original** (10% drop rate):
```csv
50,100,10,1,2,false
```

**Generous** (50% drop rate):
```csv
50,100,50,1,2,false
```

**Example**: Reduce drop rates (Hard Mode)

**Original**:
```csv
50,100,40,1,3,false
```

**Stingy** (10% drop rate, less quantity):
```csv
50,100,10,1,1,false
```

---

## Part 9: Skill Balance

### File 6: Skill Power

**Location**: `patch.dx11/data/skill/skill.mbe/000_skill_data.csv`

**Key Balance Columns**:
- Column 4: **SP Cost**
- Column 5: **Base Power**
- Column 11: **Critical Rate**
- Column 12: **Penetration**
- Column 18: **Power Multiplier**

**Example**: Nerf overpowered skill

**Original**:
```csv
30041,1,2,50,200,0,1,0,0,1,5,40,0,0,false,true,1,2.0,0,0,0,0,0,0,0,0,0,false,2,8,2,3,false
```

**Balanced**:
```csv
30041,1,2,70,150,0,1,0,0,1,5,30,0,0,false,true,1,1.5,0,0,0,0,0,0,0,0,0,false,2,8,2,3,false
```

**Changes**:
- SP Cost: 50 → 70 (more expensive)
- Power: 200 → 150 (weaker)
- Crit: 40% → 30% (less crit)
- Multiplier: 2.0 → 1.5 (less scaling)

**Example**: Buff weak skill

**Original**:
```csv
30010,1,0,30,80,0,1,1,0,1,5,15,0,0,false,true,0,1.2,0,0,0,0,0,0,0,0,0,false,1,5,1,1,false
```

**Buffed**:
```csv
30010,1,0,20,120,0,1,1,0,1,5,25,0,0,false,true,0,1.5,0,0,0,0,0,0,0,0,0,false,1,5,1,1,false
```

**Changes**:
- SP Cost: 30 → 20 (cheaper)
- Power: 80 → 120 (stronger)
- Crit: 15% → 25% (more crit)
- Multiplier: 1.2 → 1.5 (better scaling)

---

## Part 10: Training Efficiency

### File 7: Training Results

**Location**: `patch.dx11/data/training/training.mbe/000_training_data.csv`

**Column Guide**:
- Column 0: Training ID
- Column 1: Training type
- Column 2: **Stat gained**
- Column 3: **Amount**
- Column 4: Cost
- Column 5: Time required

**Example**: Make training more efficient

**Original**:
```csv
1,1,1,5,100,10
```

**Better Training**:
```csv
1,1,1,10,50,5
```

**Changes**:
- Stat gain: 5 → 10 (double)
- Cost: 100 → 50 (half price)
- Time: 10 → 5 (faster)

---

## Part 11: Complete Balance Presets

### Preset 1: Easy Mode

**Changes to make**:

```csv
# Digimon Stats: Increase player base stats by 50%
# In digimon_status_data.csv, multiply columns 61-69 by 1.5

# Enemy Levels: Reduce by 5
# In battle_enemy_list.csv, subtract 5 from columns 2, 4, 6

# Enemy AI: Set to 0 or 1 (passive/normal)
# In battle_enemy_list.csv, column 10 = 0 or 1

# Rewards: Increase by 50%
# In battle_enemy_list.csv, multiply columns 13-14 by 1.5

# Prices: Reduce by 50%
# In item_data.csv, multiply columns 7-8 by 0.5

# Drop Rates: Double all rates
# In enemy_drops.csv, multiply column 2 by 2 (cap at 95%)
```

### Preset 2: Hard Mode

**Changes to make**:

```csv
# Digimon Stats: Decrease player base stats by 20%
# In digimon_status_data.csv, multiply columns 61-69 by 0.8

# Enemy Levels: Increase by 10
# In battle_enemy_list.csv, add 10 to columns 2, 4, 6

# Enemy AI: Set to 3+ (smart/boss)
# In battle_enemy_list.csv, column 10 = 3, 4, or 5

# Rewards: Decrease by 25%
# In battle_enemy_list.csv, multiply columns 13-14 by 0.75

# Prices: Increase by 100%
# In item_data.csv, multiply columns 7-8 by 2

# Drop Rates: Halve all rates
# In enemy_drops.csv, divide column 2 by 2
```

### Preset 3: Nuzlocke Mode

**Challenge run rules**:

```csv
# Revival Items: Remove from shops
# In shop_lineup.csv, delete rows with revival item IDs

# Enemy Damage: Increase by 30%
# In battle_enemy_list.csv, increase levels by 5

# No Escape: Disable fleeing
# In battle_enemy_list.csv, column 12 = 0

# Perma-death flag (requires custom scripting)
```

### Preset 4: Speedrun Mode

**Optimizations**:

```csv
# Experience: 5x multiplier
# In battle_enemy_list.csv, multiply column 13 by 5

# Enemy Levels: Reduce by 10
# In battle_enemy_list.csv, subtract 10 from columns 2, 4, 6

# Evolution: Remove all requirements
# In evolution_table.csv, set columns 2-9 to minimal values

# Training: Instant and free
# In training_data.csv, column 4 = 0, column 5 = 0

# Shops: Everything free
# In item_data.csv, column 7 = 0
```

### Preset 5: Endgame Content Mode

**Post-game grinding**:

```csv
# Enemy Levels: Set all to 99
# In battle_enemy_list.csv, columns 2, 4, 6 = 99

# Mega Stats: All enemies buffed
# Requires modifying digimon_status for enemy IDs

# Super Rewards: 10x EXP/Money
# In battle_enemy_list.csv, multiply columns 13-14 by 10

# Rare Drops: 5x drop rates
# In enemy_drops.csv, multiply column 2 by 5 (cap 95%)

# Legendary Items: Add to late-game shops
# In shop_lineup.csv, add rows for rare items
```

---

## Balance Testing Checklist

- [ ] Player stats tested at levels 1, 25, 50, 75, 99
- [ ] Enemy encounters tested in early/mid/late game
- [ ] Skill costs balanced with SP pools
- [ ] Item prices affordable but not trivial
- [ ] Drop rates feel rewarding
- [ ] Evolution requirements achievable
- [ ] Boss battles challenging but fair
- [ ] Training costs reasonable
- [ ] Experience curve appropriate
- [ ] No game-breaking combinations

---

## Common Balance Issues

### Issue: Game too easy
**Solutions**:
- Increase enemy levels (+5 to +10)
- Reduce player base stats (-20%)
- Increase item prices (+50% to +100%)
- Set enemy AI to 3+ (smart)
- Reduce EXP/money rewards (-25%)

### Issue: Game too hard
**Solutions**:
- Decrease enemy levels (-5 to -10)
- Increase player base stats (+30% to +50%)
- Decrease item prices (-30% to -50%)
- Set enemy AI to 0-1 (passive/normal)
- Increase EXP/money rewards (+50% to +100%)

### Issue: Early game too slow
**Solutions**:
- Increase early-game EXP rewards (+100%)
- Reduce early evolution requirements
- Add more healing items to shops
- Increase early-game money drops

### Issue: Late game too grindy
**Solutions**:
- Increase late-game EXP rewards (+200% to +500%)
- Add super training options
- Increase money from bosses
- Add rare items to shops

### Issue: Specific Digimon too weak
**Solutions**:
- Increase base stats (columns 61-69)
- Increase growth rates (columns 128-135)
- Give better skill learning
- Reduce evolution requirements

### Issue: Specific skill too strong
**Solutions**:
- Increase SP cost (column 4)
- Reduce power (column 5)
- Lower multiplier (column 18)
- Reduce crit rate (column 11)

---

## Summary: Balance File Checklist

**Core Balance Files (3)**:
- ✅ `digimon_status_data.csv` - Player stats
- ✅ `battle_enemy_list.csv` - Enemy difficulty
- ✅ `skill_data.csv` - Skill balance

**Economy Files (3)**:
- ✅ `item_data.csv` - Prices
- ✅ `enemy_drops.csv` - Drop rates
- ✅ `shop_lineup.csv` - Shop availability

**Progression Files (2)**:
- ✅ `evolution_table.csv` - Evolution requirements
- ✅ `training_data.csv` - Training efficiency

---

**Happy Balancing!** ⚖️✨

*For specific value ranges, see COMPREHENSIVE_FILE_DOCUMENTATION.md*

