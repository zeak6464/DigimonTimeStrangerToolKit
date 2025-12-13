# Guide: Complete List of Required Animations for Digimon

**Reference guide for all animation codes needed for Digimon characters**

---

## Overview

This guide lists all animations required for a fully functional Digimon character in Digimon Time Stranger. Animations are organized by category: Battle, Field, and Optional (Ride).

---

## 1. Battle Animations (Required)

These animations are used during battles and are **essential** for a working Digimon.

### Core Battle Animations:

| Animation Code | Description | Usage |
|---------------|-------------|-------|
| **base** | Base Animation | The default/idle animation for the model during battle |
| **ba01** | Attack Animation (Physical) | Animation played for physical/regular attacks |
| **ba02** | Attack Animation (Skills) | Animation played for regular Skill attacks |
| **bs01** | Special Skill 1 | Animation played for Special Skill 1 |
| **bs02** | Special Skill 2 | Animation played for Special Skill 2 |
| **bd01** | Damage Animation | Animation played when taking damage |
| **bd02** | Critical/Defeat Animation | Animation played when hitting 0 HP or receiving a critical hit |
| **bd03** | Recovery Animation | Animation played when getting up from being revived or after a critical hit |
| **bg01** | Guard Animation | Animation played when Guarding against an attack |
| **bn01** | Rest/Idle Animation | Rest/idle animation during battle (standard idle) |
| **bn02** | Sleeping Idle | Sleeping/idle animation variant (optional, used for sleep/rest states) |
| **br01** | Run/Movement Animation | Movement animation during battle |
| **bv01** | Victory Animation | Animation played after winning a battle |
| **bf01** | Battle Field Base / Critical Hit | Alternative base animation; may also be used for critical hit animations (optional) |

**Naming Convention**: `chr###_[animation_code]`
- Example: `chr050_base`, `chr050_ba01`, `chr050_ba02`

---

## 2. Field Animations (Required)

These animations are used when the Digimon appears on the field/overworld.

### Core Field Animations:

| Animation Code | Description | Usage |
|---------------|-------------|-------|
| **fn01_01** | Field Neutral/Idle | Default idle animation on the field |
| **fw01_01** | Field Walk | Walking animation on the field |
| **fr01_01b** | Field Run | Running animation on the field |
| **bn01** | Battle Neutral (Field) | Alternative neutral/idle (some Digimon use this instead of fn01_01) |
| **br01** | Battle Run (Field) | Alternative run animation (some Digimon use this instead of fr01_01b) |

### Optional Field Event Animations:

| Animation Code | Description | Usage |
|---------------|-------------|-------|
| **fe01** | Eating Food Animation | Animation for eating food (useful for Digifarm interactions) |
| **fe02** | Field Event 2 | Event/interaction animation |
| **fe03** | Yawn Animation | Yawning/idle animation |
| **fe04** | Field Event 4 | Event/interaction animation |
| **fq01** | Field Conversation (Positive) | Positive response animation for field conversations |
| **fq02** | Field Conversation (Negative) | Negative response animation for field conversations |
| **fn02_01** | Field Neutral Variant | Alternative neutral animation |
| **bf01** | Battle Field Base / Critical Hit | Alternative base animation, may also be used for critical hit animations |
| **bn02** | Sleeping Idle | Sleeping/idle animation variant |

**Naming Convention**: `chr###_[animation_code]`
- Example: `chr050_fn01_01`, `chr050_fw01_01`, `chr050_fe01`

---

## 3. Ride Animations (Optional - Only if making Digimon rideable)

These animations are only needed if you want to make the Digimon rideable.

| Animation Code | Description | Usage |
|---------------|-------------|-------|
| **r###_fn01** | Ride Idle | Animation when stationary while being ridden (idle on mount) |
| **r###_fw01** | Ride Walk/Run | Animation when moving while being ridden |

**Naming Convention**: `r###_[animation_code]` (where ### is the 3-digit character ID)
- Example for chr050: `r050_fn01`, `r050_fw01`

---

## 4. Complete Animation List Summary

### Minimum Required Animations (Essential):

1. **base** - Base animation
2. **ba01** - Physical attack
3. **ba02** - Skill attack
4. **bs01** - Special skill 1
5. **bs02** - Special skill 2
6. **bd01** - Damage taken
7. **bd02** - Defeat/critical
8. **bd03** - Recovery/get up
9. **bg01** - Guard
10. **bn01** - Rest/idle
11. **br01** - Run/movement
12. **bv01** - Victory
13. **fn01_01** - Field idle (or bn01)
14. **fw01_01** - Field walk (or br01)
15. **fr01_01b** - Field run (or br01)

**Total Minimum**: 15 animations

### Recommended Additional Animations:

16. **fe01** - Eating food (useful for Digifarm)
17. **fe02** - Field event 2
18. **fe03** - Yawn animation
19. **fe04** - Field event 4
20. **fq01** - Field conversation (positive response)
21. **fq02** - Field conversation (negative response)
22. **bn02** - Sleeping idle (optional variant)

**Total Recommended**: 22 animations

### Optional (Ride Support):

22. **r###_fn01** - Ride idle
23. **r###_fw01** - Ride walk

**Total with Ride Support**: 23 animations

---

## 5. Example: chr050 (Agumon)

Based on the Blender screenshot and field animation data:

### Battle Animations (12):
- chr050_base
- chr050_ba01
- chr050_ba02
- chr050_bs01
- chr050_bs02
- chr050_bd01
- chr050_bd02
- chr050_bd03
- chr050_bg01
- chr050_bn01
- chr050_br01
- chr050_bv01

### Field Animations (from NLA tracks visible):
- chr050_base (base animation)
- chr050_bf01 (battle field base / critical hit)
- chr050_bn02 (sleeping idle)
- chr050_fe01 (eating food - useful for Digifarm)
- chr050_fe02 (field event 2)
- chr050_fe03 (yawn animation)
- chr050_fe04 (field event 4)
- chr050_fn02_01 (field neutral variant)
- chr050_fq01 (positive conversation response)
- chr050_fq02 (negative conversation response)

### Field Movement (from CSV):
- chr050 uses: `bn01` (idle), `br01` (run)
- Or could use: `fn01_01`, `fw01_01`, `fr01_01b`

### Ride Animations (if rideable):
- r050_fn01
- r050_fw01

---

## 6. Animation File Format

Animation files are typically stored as:
- Binary animation files (`.anim` format)
- Located in the game's animation data directories
- Referenced by name in CSV configuration files

---

## 7. Notes

1. **Some Digimon use alternative codes**: Not all Digimon use `fn01_01`/`fw01_01` for field animations. Some use `bn01`/`br01` (battle codes) for field movement.

2. **Variants exist**: Some animations have variants (e.g., `fn01_01`, `fn02_01`, `bn01`, `bn02`). The game uses these for variety.

3. **Event animations are optional**: Field event animations (fe01-fe04, fq01-fq02) enhance interactions but may not be strictly required for basic functionality.

4. **Signature skill animations**: Special signature moves may have unique animation IDs (referenced in column 126 of digimon_status_data.csv).

5. **Ride animations require bone setup**: The ride animations (`r###_fn01`, `r###_fw01`) must have the player attachment point configured in the animation file itself.

---

## 8. Quick Checklist

Use this checklist when creating/importing animations for a new Digimon:

### Battle Animations:
- [ ] base
- [ ] ba01
- [ ] ba02
- [ ] bs01
- [ ] bs02
- [ ] bd01
- [ ] bd02
- [ ] bd03
- [ ] bg01
- [ ] bn01
- [ ] br01
- [ ] bv01

### Field Animations:
- [ ] fn01_01 (or bn01)
- [ ] fw01_01 (or br01)
- [ ] fr01_01b (or br01)
- [ ] fe01 (optional - eating food, useful for Digifarm)
- [ ] fe02 (optional)
- [ ] fe03 (optional - yawn animation)
- [ ] fe04 (optional)
- [ ] fq01 (optional - positive conversation response)
- [ ] fq02 (optional - negative conversation response)
- [ ] bn02 (optional - sleeping idle variant)
- [ ] bf01 (optional - alternative base/critical hit)

### Ride Animations (if making rideable):
- [ ] r###_fn01
- [ ] r###_fw01

---

## 9. Additional Optional Animations

### Field Special Animations:

These are **optional** animations that can enhance Digimon field behavior, primarily used by NPCs but may be applicable to Digimon in certain scenarios:

| Animation Code | Description | Usage |
|---------------|-------------|-------|
| **fs01_01** | Field Sit/Special 1 | Sitting or static special pose animation |
| **fs01_02** | Field Sit/Special 2 | Alternative sitting/static pose |
| **ft01_01** | Field Talk 1 | Talking animation variant 1 |
| **ft01_02** | Field Talk 1 Variant | Talking animation variant 1 (alternative) |
| **ft02_01** | Field Talk 2 | Talking animation variant 2 |
| **ft02_02** | Field Talk 2 Variant | Talking animation variant 2 (alternative) |
| **ft03_01** | Field Talk 3 | Talking animation variant 3 |
| **ft03_02** | Field Talk 3 Variant | Talking animation variant 3 (alternative) |

**Note**: These appear to be primarily for NPCs and player characters. Most Digimon don't use these unless they're involved in specific event cutscenes.

### Stair Animations (Optional):

| Animation Code | Description | Usage |
|---------------|-------------|-------|
| **fw02_u01** | Field Walk Up Stairs | Walking up stairs animation |
| **fw02_d01** | Field Walk Down Stairs | Walking down stairs animation |
| **fr02_u01** | Field Run Up Stairs | Running up stairs animation |
| **fr02_d01** | Field Run Down Stairs | Running down stairs animation |

**Note**: These are typically only needed if the Digimon model is used for field navigation (which is uncommon - Digimon are usually in party/summoned state).

### Event Animations (For Cutscenes Only):

Event animations (e### codes like e002, e004, e005, e014, e017, e019, e020, e050, etc.) are used during story events and cutscenes. These are **not typically required** for Digimon unless:

1. The Digimon appears in specific story cutscenes
2. The Digimon is used as an NPC in events

If needed, common event animations include:
- **e002** - Event animation 2
- **e004** - Event animation 4
- **e005** - Event animation 5
- **e014** - Event animation 14
- **e017** - Event animation 17
- **e019** - Event animation 19
- **e020** - Event animation 20
- **e050** - Event animation 50 (sits, transitions to fs01_01)
- And many others (e006, e007, e008, e009, e010, e011, e012, e013, e015, e018, e021, e022, e023, e030, e031, e032, e033, e052, etc.)

**Important**: Most event animations are for player characters (pc###) and NPCs (npc###), not Digimon (chr###). Check if your Digimon needs these before creating them.

### Animation Variants and Suffixes:

Some animations have variant suffixes that indicate alternatives or special cases:
- **_01** - First variant (e.g., `fn01_01`, `fe01_01`)
- **_02** - Second variant (e.g., `fs01_02`)
- **_end01** - End transition animation (e.g., `fg08_w01_end01`)
- **_selfie** - Selfie/photo animation variant (e.g., `fn01_01_selfie`)

These variants are typically optional unless specifically required by game scripts.

---

## 10. Summary of Animation Categories

### Essential for Digimon (Minimum 15):
- 12 Battle animations (base, ba01, ba02, bs01, bs02, bd01, bd02, bd03, bg01, bn01, br01, bv01)
- 3 Field movement animations (fn01_01/fw01_01/fr01_01b OR bn01/br01)

### Recommended for Digimon (22 total):
- All essential animations
- 6 Field event animations (fe01-eating food, fe02-fe04, fq01-positive response, fq02-negative response)
- bn02 (sleeping idle - optional variant)

### Optional for Digimon (23+ total):
- Ride animations (if making rideable)
- Field special animations (fs01, ft01-03) - primarily for NPCs
- Stair animations (fw02, fr02) - rarely needed for Digimon
- Event animations (e###) - only if appearing in cutscenes

### Typically NOT for Digimon:
- Field gimmick animations (fg02, fg04, fg05, fg06, fg08, fg09, fg10, fg14) - These are for player character interactions with environments (swimming, sliding, hiding, etc.)

---

**Last Updated**: Based on codebase analysis and Blender screenshot data
