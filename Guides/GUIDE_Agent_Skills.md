# Guide: Agent Skills System in Digimon Time Stranger

**Complete guide for understanding and modifying Agent (Tamer) Skills**

✅ **Verified against**:
- In-game skill tree system
- Actual CSV structure

---

## Overview

**Agent Skills** (also called **Tamer Skills**) are passive abilities that the **player character** unlocks by spending **Agent Points**. These skills provide bonuses to specific personality groups of Digimon, such as:

- **Stat boosts** (HP, ATK, SPD, etc.)
- **Experience multipliers**
- **Evolution requirement reductions**
- **Training time reductions**
- **Equipment effect boosts**

Agent Skills are organized into **4 main trees**, one for each personality group:
1. **Valor** (Brave, Zealous, Daring, Reckless)
2. **Philanthropy** (Adoring, Devoted, Tolerant, Overprotective)
3. **Wisdom** (Compassionate, Sociable, Friendly, Opportunistic)
4. **Amicable** (Astute, Strategic, Enlightened, Sly)

**Difficulty**: Intermediate

---

## File Structure

### File 1: Agent Skill Descriptions (11 languages) ⭐ CRITICAL

**Locations**: `patch_text##.dx11/text/tamer_skill_explanation/tamer_skill_explanation.mbe/000_Sheet1.csv`

**Language Codes**:
- 00 = Japanese
- 01 = English
- 02 = French
- 03 = German
- 04 = Italian
- 05 = Spanish (EU)
- 07 = Korean
- 09 = Traditional Chinese
- 10 = Simplified Chinese
- 11 = Portuguese
- 30 = Spanish (LA)

**Format**:
```csv
"Skill_ID","Description text"
```

**Variable Placeholders in Descriptions**:
- `{d0}` = Variable value 0 (generic percentage)
- `{d1}` = Variable value 1 (SP percentage)
- `{d2}` = Variable value 2 (ATK percentage)
- `{d3}` = Variable value 3 (DEF percentage)
- `{d4}` = Variable value 4 (INT percentage)
- `{d5}` = Variable value 5 (SPI percentage)
- `{d6}` = Variable value 6 (SPD percentage)

**Example**:
```csv
"2","Boosts the SPD of Brave, Zealous, Daring, and Reckless Digimon by {d6}%."
```

---

## Agent Skill Trees

### Tree 1: Valor (Skills 1-50)

**Target Personalities**: Brave, Zealous, Daring, Reckless

**Key Skills**:

| ID | Name/Effect | Boost |
|----|-------------|-------|
| 1 | **Unlock Valor Bonds** | Base unlock |
| 2-4 | **SPD Boost** (Valor Group) | Progressive |
| 5 | **EXP Boost** | Per Agent Rank |
| 7 | **Equipment Boost** (Reckless ATK gear) | +% |
| 8-9, 13 | **SP Boost** (Valor Group) | Progressive |
| 10, 18, 34, 46 | **Evolution Requirement Reduction** | -% stats needed |
| 11, 29, 41 | **SPI Boost** (Valor Group) | Progressive |
| 12 | **Talent Boost** (Conversion) | +Initial Talent |
| 14 | **SP/SPD Boost** (Reckless only) | +% |
| 15, 20, 22 | **DEF Boost** (Valor Group) | Progressive |
| 16 | **Training Time Reduction** | -% time |
| 17, 30 | **Extra Strike Damage Boost** | +% damage |
| 21 | **Guard HP Recovery** (Zealous only) | +% HP |
| 23, 25, 27 | **HP Boost** (Valor Group) | Progressive |
| 24 | **Skill SP Cost Reduction** | Per Agent Rank |
| 26 | **Talent Gain Boost** | Easier leveling |
| 28 | **HP/DEF Boost** (Zealous only) | +% |
| 31-32, 36 | **ATK Boost** (Valor Group) | Progressive |
| 35 | **DEF Penetration** (Brave only) | Ignore % per rank |
| 37 | **HP/ATK Boost** (Brave only) | +25% |
| 38, 40, 43 | **INT Boost** (Valor Group) | Progressive |
| 39 | **Personality Shift** | Toward Heart/Affection |
| 44 | **ATK/INT Boost** (Daring only) | +% |
| 45 | **Guard Physical Damage Reduction** (Daring) | Per Agent Rank |

---

### Tree 2: Philanthropy (Skills 51-100)

**Target Personalities**: Adoring, Devoted, Tolerant, Overprotective

**Key Skills**:

| ID | Name/Effect | Boost |
|----|-------------|-------|
| 51 | **Unlock Philanthropy Bonds** | Base unlock |
| 52-54 | **SPI Boost** (Philanthropy Group) | Progressive |
| 55 | **EXP Boost** | Per Agent Rank |
| 56 | **Rare Personality Skill Rate** | Higher chance |
| 57 | **Equipment Boost** (Compassionate SPI gear) | +% |
| 58-60 | **SPD Boost** (Philanthropy Group) | Progressive |
| 61 | **Evolution Requirement Reduction** | -% stats needed |
| 62-64 | **HP Boost** (Philanthropy Group) | Progressive |
| 65 | **Conversion ABI Retention** | Keep % ABI |
| 66 | **Training Time Reduction** | -% time |
| 67 | **Healing Skill Power Boost** | +% healing |
| 68 | **Evolution Requirement Reduction** | -% stats needed |
| 69 | **EXP Boost** | Per Agent Rank |
| 70-72 | **INT Boost** (Philanthropy Group) | Progressive |
| 73 | **HP/SPI Boost** (Sociable only) | +% |
| 74-76 | **SP Boost** (Philanthropy Group) | Progressive |
| 77 | **Skill SP Cost Reduction** | Per Agent Rank |
| 78-80 | **DEF Boost** (Philanthropy Group) | Progressive |
| 81 | **Talent Gain Boost** | Easier leveling |
| 82-84 | **ATK Boost** (Philanthropy Group) | Progressive |
| 85 | **Counter Damage Boost** (Devoted only) | Per Agent Rank |
| 86 | **Evolution Requirement Reduction** | -% stats needed |
| 87 | **HP/DEF Boost** (Devoted only) | +25% |
| 88 | **EXP Boost** | Per Agent Rank |
| 89 | **Personality Shift** | Toward Courage/Valor |
| 90-91 | **ATK/SPI Boost** (Friendly only) | +% |
| 92 | **Magic Damage Reduction** (Friendly) | Per Agent Rank |
| 93 | **Evolution Requirement Reduction** | -% stats needed |

---

### Tree 3: Wisdom (Skills 101-150)

**Target Personalities**: Compassionate, Sociable, Friendly, Opportunistic

**Key Skills**:

| ID | Name/Effect | Boost |
|----|-------------|-------|
| 101 | **Unlock Wisdom Bonds** | Base unlock |
| 102-104 | **INT Boost** (Wisdom Group) | Progressive |
| 105 | **EXP Boost** | Per Agent Rank |
| 106 | **Rare Personality Skill Rate** | Higher chance |
| 107 | **Equipment Boost** (Enlightened INT gear) | +% |
| 108-110 | **DEF Boost** (Wisdom Group) | Progressive |
| 111 | **Evolution Requirement Reduction** | -% stats needed |
| 112-114 | **ATK Boost** (Wisdom Group) | Progressive |
| 115 | **Talent Boost** (Conversion) | +Initial Talent |
| 116 | **Training Time Reduction** | -% time |
| 117 | **Buff Duration Extension** | +turns |
| 118 | **Evolution Requirement Reduction** | -% stats needed |
| 119 | **EXP Boost** | Per Agent Rank |
| 120-122 | **SPI Boost** (Wisdom Group) | Progressive |
| 123 | **HP/INT Boost** (Astute only) | +% |
| 124-126 | **SPD Boost** (Wisdom Group) | Progressive |
| 127 | **Skill SP Cost Reduction** | Per Agent Rank |
| 128-130 | **HP Boost** (Wisdom Group) | Progressive |
| 131 | **Talent Gain Boost** | Easier leveling |
| 132-134 | **SP Boost** (Wisdom Group) | Progressive |
| 135 | **Debuff Success Rate** (Strategic only) | Per Agent Rank |
| 136 | **Evolution Requirement Reduction** | -% stats needed |
| 137 | **SPI/SPD Boost** (Strategic only) | +25% |
| 138 | **EXP Boost** | Per Agent Rank |
| 139 | **Personality Shift** | Toward Amicable |
| 140-141 | **INT/SPI Boost** (Tolerant only) | +% |
| 142 | **Status Ailment Resistance** (Tolerant) | Per Agent Rank |
| 143 | **Evolution Requirement Reduction** | -% stats needed |

---

### Tree 4: Amicable (Skills 151-200)

**Target Personalities**: Astute, Strategic, Enlightened, Sly

**Key Skills**:

| ID | Name/Effect | Boost |
|----|-------------|-------|
| 151 | **Unlock Amicable Bonds** | Base unlock |
| 152-154 | **HP Boost** (Amicable Group) | Progressive |
| 155 | **EXP Boost** | Per Agent Rank |
| 156 | **Rare Personality Skill Rate** | Higher chance |
| 157 | **Equipment Boost** (Sly SPD gear) | +% |
| 158-160 | **ATK Boost** (Amicable Group) | Progressive |
| 161 | **Evolution Requirement Reduction** | -% stats needed |
| 162-164 | **SPD Boost** (Amicable Group) | Progressive |
| 165 | **Conversion ABI Retention** | Keep % ABI |
| 166 | **Training Time Reduction** | -% time |
| 167 | **Buff Skill Power Boost** | +% effect |
| 168 | **Evolution Requirement Reduction** | -% stats needed |
| 169 | **EXP Boost** | Per Agent Rank |
| 170-172 | **DEF Boost** (Amicable Group) | Progressive |
| 173 | **ATK/DEF Boost** (Overprotective only) | +% |
| 174-176 | **INT Boost** (Amicable Group) | Progressive |
| 177 | **Skill SP Cost Reduction** | Per Agent Rank |
| 178-180 | **SPI Boost** (Amicable Group) | Progressive |
| 181 | **Talent Gain Boost** | Easier leveling |
| 182-184 | **SP Boost** (Amicable Group) | Progressive |
| 185 | **Steal Success Rate** (Opportunistic only) | Per Agent Rank |
| 186 | **Evolution Requirement Reduction** | -% stats needed |
| 187 | **SPD/EVA Boost** (Opportunistic only) | +25% |
| 188 | **EXP Boost** | Per Agent Rank |
| 189 | **Personality Shift** | Toward Wisdom |
| 190-191 | **HP/SPD Boost** (Adoring only) | +% |
| 192 | **Support Skill Range Boost** (Adoring) | Multi-target chance |
| 193 | **Evolution Requirement Reduction** | -% stats needed |

---

## How to Modify Agent Skills

### Example 1: Increase EXP Boost Effect

**Goal**: Make skill 5 (Valor EXP Boost) give 50% per rank instead of default

**File**: `patch_text01.dx11/text/tamer_skill_explanation/tamer_skill_explanation.mbe/000_Sheet1.csv`

**Find Skill 5**:
```csv
"5","Boosts the EXP gained in battle by Brave, Zealous, Daring, and Reckless battle and reserve Digimon by {d0}% for each Agent Rank."
```

**Note**: The actual boost value is **hardcoded in game code**, so modifying the text won't change the effect. You can only change the description.

**For Real Modification**: You would need to modify game binaries (advanced modding).

---

### Example 2: Create Custom Agent Skill Description

**Goal**: Add a new skill at ID 500

**File**: `patch_text01.dx11/text/tamer_skill_explanation/tamer_skill_explanation.mbe/000_Sheet1.csv`

**Add**:
```csv
"500","Unlocks the ultimate power of the Digital World. All Digimon gain +100% to all stats."
```

**Repeat for all 11 languages**

**Note**: This only adds the **description**. The actual skill effect is hardcoded in game code.

---

### Example 3: Modify Existing Skill Description

**Goal**: Change skill 37 to say it boosts by 50% instead of 25%

**File**: `patch_text01.dx11/text/tamer_skill_explanation/tamer_skill_explanation.mbe/000_Sheet1.csv`

**Find**:
```csv
"37","Boosts the HP/ATK of Brave Digimon by 25%."
```

**Change to**:
```csv
"37","Boosts the HP/ATK of Brave Digimon by 50%."
```

**Note**: This only changes the **text**. To actually change the effect, you need binary modding.

---

## Understanding the System

### Agent Points

- **Earned**: By completing quests, battles, and story progression
- **Spent**: On unlocking nodes in the 4 skill trees
- **Skill Trees**: Each tree has ~50 skills with dependencies

### Skill Dependencies

Skills have **prerequisites** (parent skills must be unlocked first):

```
Skill 1 (Unlock Valor Bonds)
  ├─ Skill 2 (SPD Boost I)
  │   ├─ Skill 3 (SPD Boost II)
  │   │   └─ Skill 4 (SPD Boost III)
  │   └─ Skill 5 (EXP Boost)
  └─ Skill 7 (Equipment Boost)
```

---

## Common Boost Types

### Stat Boosts

**Progressive (I → II → III)**:
- Each tier increases the percentage
- Examples: HP +5% → +10% → +15%

**Per Agent Rank**:
- Scales with player's Agent Rank
- Examples: +5% per rank (Rank 10 = +50%)

**Fixed**:
- One-time boost
- Examples: HP/ATK +25%

---

### Unique Skill Types

| Type | Description | Example Skills |
|------|-------------|----------------|
| **EXP Boost** | Increases experience gain | 5, 55, 105, 155 |
| **Evolution Reduction** | Lowers stat requirements for Digivolution | 10, 18, 34, 46 |
| **Training Time Reduction** | Speeds up Digifarm training | 16, 66, 116, 166 |
| **Rare Personality Skill** | Boosts chance of rare skills | 6, 56, 106, 156 |
| **Equipment Effect Boost** | Amplifies equipment bonuses | 7, 57, 107, 157 |
| **Talent Boost** | Increases Talent gain/initial | 12, 26, 65, 115 |
| **Personality Shift** | Influences farm personality changes | 39, 89, 139, 189 |
| **Damage Boosts** | Extra Strike, Counter, etc. | 17, 30, 67, 85 |
| **Defensive Boosts** | Guard effects, damage reduction | 21, 45, 92, 142 |

---

## Testing Checklist

- [ ] Skill description displays correctly
- [ ] Description appears in all 11 languages
- [ ] Skill icon shows properly
- [ ] Skill can be unlocked with Agent Points
- [ ] Prerequisites work correctly
- [ ] Effect description matches actual effect (if modded)

---

## Common Issues

### Issue 1: Skill Description Shows as "???"
**Cause**: Missing entry in text files  
**Fix**: Add skill ID and description to ALL 11 `tamer_skill_explanation.mbe` files

### Issue 2: Skill Has No Effect After Unlocking
**Cause**: Skill ID doesn't exist in game code  
**Fix**: Use existing skill IDs (1-200 confirmed)

### Issue 3: Variable Placeholders Show as "{d0}"
**Cause**: Missing data mapping in game code  
**Fix**: Ensure placeholder variables are defined in skill data (requires binary modding)

---

## Limitations

### Text-Only Modding

With **CSV-only modding**, you can:
- ✅ Change skill descriptions
- ✅ Rename skills
- ✅ Add new skill IDs (cosmetic only)

You **cannot**:
- ❌ Change actual skill effects (stat boost percentages)
- ❌ Add new skill types
- ❌ Modify skill tree structure
- ❌ Change Agent Point costs

### Binary Modding Required For

- Changing boost percentages (e.g., 10% → 50%)
- Adding new skill effects
- Modifying skill tree dependencies
- Changing Agent Point costs
- Creating entirely new skill trees

---

## Advanced: Skill Tree Structure (Theoretical)

**Note**: Skill tree data is likely **hardcoded in game binaries**, not in CSV files.

**Hypothetical Structure**:
```
Skill_ID, Parent_ID, Cost, Effect_Type, Effect_Value
1, 0, 1, UNLOCK_TREE, 1
2, 1, 2, STAT_BOOST, SPD+5
3, 2, 3, STAT_BOOST, SPD+10
```

**To find this data**, you would need to:
1. Use a hex editor or decompiler
2. Search for skill ID sequences
3. Reverse-engineer the skill tree format

---

## Summary

- ✅ Agent Skills are player-unlocked passive abilities
- ✅ 4 skill trees (Valor, Philanthropy, Wisdom, Amicable)
- ✅ Each tree has ~50 skills targeting specific personality groups
- ✅ Skill descriptions are in `tamer_skill_explanation.mbe` (11 languages)
- ✅ Boost types: Stats, EXP, Evolution, Training, etc.
- ✅ **CSV modding**: Can change text only
- ✅ **Binary modding**: Required to change actual effects

---

## 📚 References

- In-game Agent Skill tree menu
- Game files: `tamer_skill_explanation.mbe/` directory
- `GUIDE_Personality_Skills.md` - Related personality system

**Guide Version**: 1.0  
**Last Updated**: October 21, 2025  
**Status**: ✅ Verified against game data  
**Modding Level**: Text-only (Binary modding required for effects)

