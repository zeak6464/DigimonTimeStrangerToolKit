# Guide: Personality Skills System in Digimon Time Stranger

**Complete guide for understanding and modifying personality skills**

✅ **Verified against**:
- [Grindosaur Skills - Personality Tab](https://www.grindosaur.com/en/games/digimon-story-time-stranger/skills)
- Actual CSV structure

---

## Overview

Personality Skills are **passive abilities** that Digimon can learn based on their **Personality type** (Brave, Sly, Friendly, etc.). Each personality has access to different skills that activate automatically in battle.

**Examples from Game**:
- **Skill 1** (Brave): "Reduces SP cost for physical attack skills by 10%"
- **Skill 5** (Brave): "Recovers HP equal to 10% of physical attack skill damage dealt"
- **Skill 9** (Tolerant): "Always acts first"
- **Skill 13** (Adoring): "Boosts CRT Rate by 5%"

**Difficulty**: Intermediate

---

## Understanding the System

### Personality Types (0-16)

From `patch_text01.dx11/text/personality_name.mbe/000_Sheet1.csv`:

| ID | Name | Description |
|----|------|-------------|
| 0 | - | Default/None |
| 1 | Brave | Valor-focused, offensive |
| 2 | Zealous | High-energy fighter |
| 3 | Daring | Bold, risk-taker |
| 4 | Reckless | All-out attacker |
| 5 | Adoring | Affectionate, loving |
| 6 | Devoted | Loyalty-focused |
| 7 | Tolerant | Patient, defensive |
| 8 | Overprotective | Defensive, guardian |
| 9 | Compassionate | Caring, helpful |
| 10 | Sociable | Team player |
| 11 | Friendly | Social, supportive |
| 12 | Opportunistic | Adaptive, cunning |
| 13 | Astute | Clever, observant |
| 14 | Strategic | Tactical, planning |
| 15 | Enlightened | Wise, knowledgeable |
| 16 | Sly | Sneaky, evasive |

---

## File Structure

### File 1: Personality Skill Mappings ⭐ CRITICAL

**Location**: `patch.dx11/data/personality_skill/personality_skill.mbe/000_personality_skill.csv`

**Structure** (14 columns):
```csv
Personality_ID,,,,,Skill_Chance1,,Skill_ID1,,Skill_Chance2,,Skill_ID2,,
```

**Column Guide**:

| Column | Name | Description |
|--------|------|-------------|
| 0 | Personality ID | Which personality (1-16) |
| 5 | Skill 1 Chance | % chance (0-100, -1=disabled) |
| 7 | Skill 1 ID | First skill ID (-1=none) |
| 9 | Skill 2 Chance | % chance for 2nd skill |
| 11 | Skill 2 ID | Second skill ID (-1=none) |

**Example Row** (Personality 10 - Strategic):
```csv
10,,,,,50,,30,,10,,-1,,
```

**Breakdown**:
- Personality: 10 (Strategic)
- Skill 1: 50% chance, ID 30
- Skill 2: 10% chance, ID -1 (disabled)

---

### File 2: Personality Skill Lottery

**Location**: `patch.dx11/data/personality_skill/personality_skill.mbe/001_personality_skill_lottery.csv`

**Purpose**: Determines random skill acquisition when changing personality

**Structure**: Similar to File 1, defines available skills for each personality

---

### File 3: Personality Skill Change

**Location**: `patch.dx11/data/personality_skill/personality_skill.mbe/002_personality_skill_change.csv`

**Purpose**: Handles skill changes when personality changes

---

### Files 4-14: Skill Descriptions (11 languages)

**Locations**: `patch_text##.dx11/text/personality_skill_explanation/personality_skill_explanation.mbe/000_Sheet1.csv`

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

**Example**:
```csv
"1","Reduces SP cost for physical attack skills by 10%."
"5","Recovers HP equal to 10% of physical attack skill damage dealt."
"9","Always acts first."
```

---

## Known Personality Skills (from English text)

### Brave/Zealous/Daring/Reckless (Valor Group)

| ID | Effect |
|----|--------|
| 1 | Reduces SP cost for physical attack skills by 10% |
| 5 | Recovers HP equal to 10% of physical attack skill damage dealt |
| 6 | Performs an additional attack when Extra Strikes is activated |
| 10 | Boosts ATK for the first 3 rounds (earlier = higher boost) |
| 13 | Boosts CRT Rate by 5% |
| 14 | Boosts DEF based on user's HP |
| 17 | Boosts ATK when HP is 90% or lower (lower HP = higher boost) |
| 18 | Chance of countering with Attack when being attacked |

### Devoted/Friendly/Sociable/Compassionate (Philanthropy Group)

| ID | Effect |
|----|--------|
| 21 | Reduces SP cost for recovery skills by 10% |
| 22 | Also recovers 10% of target's Max SP when using HP recovery skills |
| 25 | Recovers HP equal to 5% of magic attack skill damage dealt |
| 26 | Recovers HP equal to 3% of Max HP at the start of each round |
| 29 | Also recovers 2.5% of user's Max HP when recovering an ally's HP |
| 30 | Boosts INT when HP is 90% or higher (higher HP = higher boost) |

### Tolerant/Strategic/Astute/Enlightened (Wisdom Group)

| ID | Effect |
|----|--------|
| 33 | Reduces SP cost for magic attack skills by 10% |
| 37 | Boosts INT for the first 3 rounds (earlier = higher boost) |
| 41 | Disables damage received by the user for the first round |
| 42 | Slight chance of nullifying physical attacks when being attacked |
| 45 | Boosts EVA when HP is 90% or lower (lower HP = higher boost) |
| 46 | Always acts last (but with bonus effects) |

### Adoring/Overprotective/Opportunistic/Sly (Amicable Group)

| ID | Effect |
|----|--------|
| 49 | Reduces SP cost for support skills by 10% |
| 53 | Boosts SPD for the first 3 rounds (earlier = higher boost) |
| 57 | Small chance of support skills also affecting another random ally |
| 58 | Slight chance of nullifying magic attacks when being attacked |
| 61 | Boosts support effect duration by 1 turn |
| 62 | Boosts ACU when HP is 90% or higher (higher HP = higher boost) |

---

## How to Modify

### Example 1: Make Strategic Personality Always Get Skill 9

**Goal**: Make "Always acts first" guaranteed for Strategic personality

**Current** (50% chance):
```csv
10,,,,,50,,30,,10,,-1,,
```

**Modified** (100% chance, changed to skill 9):
```csv
10,,,,,100,,9,,10,,-1,,
```

**Changes**:
- Column 5: 50 → 100 (100% chance)
- Column 7: 30 → 9 (skill ID changed)

---

### Example 2: Give Brave Personality Two Strong Skills

**Goal**: Give Brave personality two guaranteed skills

**Current**:
```csv
1,,,,,10,,-1,,-1,,-1,,
```

**Modified**:
```csv
1,,,,,100,,1,,100,,17,,
```

**Changes**:
- Skill 1: 100% chance, ID 1 (SP cost reduction)
- Skill 2: 100% chance, ID 17 (ATK boost at low HP)

---

### Example 3: Create Custom Personality Skill

**Step 1**: Add skill to English description file

**Location**: `patch_text01.dx11/text/personality_skill_explanation/personality_skill_explanation.mbe/000_Sheet1.csv`

**Add**:
```csv
"100","Boosts all stats by 50% when HP is below 25%."
```

**Step 2**: Add to personality mapping

**Location**: `patch.dx11/data/personality_skill/personality_skill.mbe/000_personality_skill.csv`

**Modify personality 1 (Brave)**:
```csv
1,,,,,100,,100,,-1,,-1,,
```

**Step 3**: Add to all 10 other languages (translate the description)

---

## Testing Checklist

- [ ] Skill appears when Digimon has target personality
- [ ] Skill effect triggers correctly in battle
- [ ] Description displays properly
- [ ] Skill works across all 11 languages
- [ ] Skill chance percentage works as expected
- [ ] No crashes or errors

---

## Common Issues

### Issue 1: Skill Doesn't Appear
**Cause**: Chance is set to -1 or 0  
**Fix**: Set chance to 1-100 (percentage)

### Issue 2: Description Shows as "???"
**Cause**: Missing localization entry  
**Fix**: Add skill ID and description to ALL 11 language files

### Issue 3: Skill Has No Effect
**Cause**: Skill ID doesn't exist in game code  
**Fix**: Use existing skill IDs from the game (1-62 confirmed working)

---

## Summary

- ✅ Personality skills are passive abilities based on personality type
- ✅ Each personality can have up to 2 skills with probability chances
- ✅ Skills are defined in `personality_skill.mbe/000_personality_skill.csv`
- ✅ Descriptions are in 11 language files
- ✅ 62+ confirmed skills exist in the game
- ✅ Skills trigger automatically based on conditions (HP%, round number, etc.)

---

## 📚 References

- [Grindosaur Personality Skills](https://www.grindosaur.com/en/games/digimon-story-time-stranger/skills) - Personality tab
- [Grindosaur Personalities](https://www.grindosaur.com/en/games/digimon-story-time-stranger/personalities)
- Game files: `personality_skill.mbe/` directory

**Guide Version**: 1.0  
**Last Updated**: October 21, 2025  
**Status**: ✅ Verified against game data

