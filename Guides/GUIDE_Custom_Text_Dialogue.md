# Guide: Custom Text & Dialogue in Digimon Time

**Complete guide for modifying and creating custom text, dialogue, and translations**

---

## Overview

Text in Digimon Time covers item names, dialogue, menus, tutorials, and more. This guide shows you how to modify existing text and add custom dialogue for your mods.

**Estimated Files to Edit**: 11-22 files (all languages)

**Difficulty**: Beginner to Intermediate

---

## Part 1: Understanding Text Structure

### Text Categories:

1. **Item Text**: Names, descriptions, ruby (pronunciation)
2. **Character Names**: Digimon, NPCs, players
3. **Profiles**: Digimon descriptions and lore
4. **Skill Text**: Skill names and explanations
5. **Dialogue**: NPC conversations, story scenes
6. **Menu Text**: UI labels, buttons, tutorials
7. **Quest Text**: Quest names, objectives, dialogue
8. **System Messages**: Errors, notifications, prompts

### Language Files:

All text exists in **11 languages**:

| Code | Language | Folder |
|------|----------|--------|
| 00 | Japanese | patch_text00.dx11 |
| 01 | English | patch_text01.dx11 |
| 02 | French | patch_text02.dx11 |
| 03 | German | patch_text03.dx11 |
| 04 | Italian | patch_text04.dx11 |
| 05 | Spanish (EU) | patch_text05.dx11 |
| 07 | Korean | patch_text07.dx11 |
| 09 | Traditional Chinese | patch_text09.dx11 |
| 10 | Simplified Chinese | patch_text10.dx11 |
| 11 | Portuguese | patch_text11.dx11 |
| 30 | Spanish (LA) | patch_text30.dx11 |

**Important**: For proper display, edit all 11 languages!

---

## Part 2: Item Text

### Files 1-11: Item Names

**Location Pattern**: `patch_text[##].dx11/text/item_name/item_name.mbe/000_Sheet1.csv`

**Format**:
```csv
"Item_ID","Item Name"
```

**Example**: Add name for custom item 5001

```csv
"5001","Mega Healing Potion"
```

**Add this to all 11 language files!**

### Files 12-22: Item Descriptions

**Location Pattern**: `patch_text[##].dx11/text/item_explanation/item_explanation.mbe/000_Sheet1.csv`

**Example**: Add description for item 5001

```csv
"5001","Restores 800 HP to one Digimon. Made from rare medicinal herbs found only in the deepest forests."
```

**Tips for Good Descriptions**:
- Include what it does (mechanical)
- Add flavor text (lore)
- Keep it concise (1-3 sentences)
- Match the game's tone

### Files 23-33: Item Ruby (Optional)

**Location Pattern**: `patch_text[##].dx11/text/item_ruby/item_ruby.mbe/000_Sheet1.csv`

**Purpose**: Pronunciation guides (mainly for Japanese)

**Most languages**: Leave empty
```csv
"5001",""
```

**Japanese**: Add pronunciation
```csv
"5001","メガヒーリングポーション"
```

---

## Part 3: Character Text

### Files 1-11: Character Names

**Location Pattern**: `patch_text[##].dx11/text/char_name/char_name.mbe/000_Sheet1.csv`

**Format**:
```csv
"Digimon_ID","Name"
```

**Example**: Custom Digimon 587

```csv
"587","Aquamon"
```

**Naming Tips**:
- Follow Digimon naming conventions (often ends in -mon)
- Keep it pronounceable
- Consider elemental/type themes
- Check for conflicts with existing names

### Files 12-22: Digimon Profiles

**Location Pattern**: `patch_text[##].dx11/text/digimon_profile/digimon_profile.mbe/000_Sheet1.csv`

**Format**:
```csv
"Digimon_ID","Profile Description"
```

**Example**: Profile for Digimon 587

```csv
"587","A Water-type Digimon that dwells in ocean depths. Its signature move, Tsunami Strike, can sink entire fleets. Despite its fearsome power, it's known to protect marine life from harm. Evolves from Betamon at level 20 with high INT."
```

**Profile Writing Tips**:
- Describe appearance/characteristics
- Mention signature moves
- Add lore/personality
- Include evolution hints (optional)
- 3-5 sentences recommended

---

## Part 4: Skill Text

### Files 1-11: Skill Names

**Location Pattern**: `patch_text[##].dx11/text/skill_name/skill_name.mbe/000_Sheet1.csv`

**Format**:
```csv
"Skill_ID","Skill Name"
```

**Example**: Custom skill 90001

```csv
"90001","Tsunami Strike"
```

**Naming Conventions**:
- Action-focused names (Blast, Strike, Wave)
- Element prefixes (Fire, Water, Thunder)
- Power indicators (Mega, Giga, Ultimate)
- Examples: "Mega Flare", "Aqua Burst", "Thunder Blade"

### Files 12-22: Skill Descriptions

**Location Pattern**: `patch_text[##].dx11/text/skill_explanation/skill_explanation.mbe/000_Sheet1.csv`

**Example**: Description for skill 90001

```csv
"90001","Summons a massive tidal wave to crash down on all enemies. High critical rate and may inflict Freeze status. Drains 15% HP from targets."
```

**Description Templates**:

**Damage Skill**:
```
"[Skill performs action] on [target]. [Special effects/status]."
Example: "Strikes enemy with blazing flames. May inflict Burn."
```

**Healing Skill**:
```
"Restores [amount] [resource] to [target]. [Additional effects]."
Example: "Restores 500 HP to one ally. Also cures Poison."
```

**Buff Skill**:
```
"Increases [stat] of [target] by [amount]% for [duration] turns."
Example: "Increases ATK of all allies by 50% for 3 turns."
```

**Status Skill**:
```
"[Action] that may inflict [status] on [target]."
Example: "Toxic attack that may inflict Poison on enemy."
```

---

## Part 5: NPC Dialogue

### Files 1-11: Message/Dialogue Files

**Location Pattern**: `patch_text[##].dx11/message/[area]/[area].mbe/###_[file].csv`

**Format**:
```csv
"Message_ID","Speaker","Dialogue Text"
```

**Example**: Add NPC dialogue

```csv
"10001","Shopkeeper","Welcome to my shop! We have the finest items in town!"
"10002","Shopkeeper","Looking for something specific? Browse at your leisure."
"10003","Shopkeeper","Thank you for your purchase! Come again!"
"10004","Old Man","I've heard rumors of a legendary Digimon in the eastern mountains..."
"10005","Old Man","Be careful out there, young Tamer. The wild Digimon are getting stronger."
```

**Dialogue Writing Tips**:
- Use character voice/personality
- Break long conversations into multiple IDs
- Include player choice responses
- Add variety for repeated NPCs
- Consider quest tie-ins

### Dialogue Scenarios:

**Greeting**:
```csv
"10010","Friendly NPC","Hey there! Beautiful day, isn't it?"
```

**Shop Introduction**:
```csv
"10020","Merchant","Take a look at my wares! Best prices in the Digital World!"
```

**Quest Giver**:
```csv
"10030","Quest NPC","I need your help! Dangerous Digimon have appeared near the village."
```

**Lore/Hint**:
```csv
"10040","Mysterious Stranger","The ancient ruins to the north hold great power... and great danger."
```

**Battle Taunt**:
```csv
"10050","Enemy Tamer","You think you can beat me? My Digimon are unbeatable!"
```

**Post-Battle**:
```csv
"10051","Enemy Tamer","I... I can't believe it! You're stronger than I thought!"
```

---

## Part 6: Quest Text

### Files 1-11: Quest Names

**Location Pattern**: `patch_text[##].dx11/text/quest_name/quest_name.mbe/000_Sheet1.csv`

**Format**:
```csv
"Quest_ID","Quest Title"
```

**Example**: Custom quest 5000

```csv
"5000","The Legendary Water Guardian"
```

**Title Tips**:
- Make it descriptive but intriguing
- Hint at objective or reward
- Keep it short (3-7 words)
- Use articles (The, A, An)

### Files 12-22: Quest Descriptions

**Location Pattern**: `patch_text[##].dx11/text/quest_explanation/quest_explanation.mbe/000_Sheet1.csv`

**Example**: Quest 5000 description

```csv
"5000","A mysterious Water-type Digimon has been sighted near the coastal caves. Investigate the sighting and, if possible, befriend this legendary creature."
```

**Description Structure**:
- **Setup**: What's happening
- **Objective**: What player must do
- **Motivation**: Why it matters

**Template**:
```
"[Context/problem]. [What to do]. [Reward/motivation]."

Example:
"The village is under attack from wild Digimon. Defeat 10 enemies in the forest. The mayor will reward you handsomely."
```

### Files 23-33: Quest Objectives

**Location Pattern**: `patch_text[##].dx11/text/quest_objective/quest_objective.mbe/000_Sheet1.csv`

**Example**: Quest objectives

```csv
"5000_01","Travel to the Coastal Caves"
"5000_02","Investigate the mysterious presence"
"5000_03","Defeat or befriend the Water Guardian"
"5000_04","Report back to the Quest Giver"
```

**Objective Format**: Use Quest_ID + underscore + step number

---

## Part 7: Menu & UI Text

### Files 1-11: System Text

**Location Pattern**: `patch_text[##].dx11/text/system/system.mbe/000_Sheet1.csv`

**Common UI Elements**:

```csv
"SYS_001","Start Game"
"SYS_002","Continue"
"SYS_003","Load Game"
"SYS_004","Settings"
"SYS_005","Quit"
"SYS_010","Confirm"
"SYS_011","Cancel"
"SYS_020","Party"
"SYS_021","Digibank"
"SYS_022","Items"
"SYS_023","Quests"
"SYS_024","Map"
"SYS_030","HP"
"SYS_031","SP"
"SYS_032","ATK"
"SYS_033","DEF"
"SYS_034","INT"
"SYS_035","SPD"
```

**Custom UI Example**:

```csv
"MOD_001","Modded Items"
"MOD_002","Custom Content"
"MOD_003","Debug Menu"
```

---

## Part 8: Tutorial & Help Text

### Files 1-11: Tutorial Messages

**Location Pattern**: `patch_text[##].dx11/text/tutorial/tutorial.mbe/000_Sheet1.csv`

**Example**: Custom tutorial

```csv
"TUT_100","New Feature: Custom Skills"
"TUT_101","You can now use custom skills! Check your Digimon's skill menu to see new abilities."
"TUT_102","Custom skills can be learned through special Skill Books found in shops and treasure chests."
```

**Tutorial Tips**:
- Keep it short (2-3 sentences)
- Be clear and instructive
- Use active voice
- Mention where to find more info

---

## Part 9: Complete Text Example

### Example: Custom Digimon Full Text

**Goal**: Add all text for Aquamon (ID 587)

**Character Name** (all 11 languages):
```csv
"587","Aquamon"
```

**Profile** (English example):
```csv
"587","An ancient Water-type Digimon said to be the guardian of the ocean depths. It controls massive tidal forces and can summon storms with a thought. Despite its immense power, Aquamon is gentle with smaller aquatic Digimon and only fights to protect its domain. Its ultimate technique, Tsunami Strike, is said to have sunk entire continents in the distant past."
```

**Signature Skill Name**:
```csv
"90100","Tsunami Strike"
```

**Skill Description**:
```csv
"90100","Aquamon's ultimate technique. Summons a catastrophic tidal wave that crashes down on all enemies. Massive damage with high critical rate, chance to Freeze, and drains 15% HP from all targets."
```

**Quest Text** (find Aquamon):
```csv
# Quest Name
"5000","The Ocean's Guardian"

# Quest Description
"5000","Ancient texts speak of Aquamon, a legendary Water Digimon that protects the ocean. Travel to the Coastal Caves and seek out this mythical creature."

# Objectives
"5000_01","Travel to Coastal Caves (East of Port City)"
"5000_02","Explore the deepest chamber"
"5000_03","Prove your worth to Aquamon"
"5000_04","Receive Aquamon's blessing"

# Dialogue
"20000","Aquamon","..."
"20001","Aquamon","A human... in my domain. What brings you to these depths?"
"20002","Aquamon","I see strength in you. And a pure bond with your Digimon."
"20003","Aquamon","Very well. I shall test your worthiness!"
"20004","Aquamon","Impressive... You have earned my respect, young Tamer."
"20005","Aquamon","I sense great trials ahead. Take this crystal - it holds a fragment of my power."
```

---

## Part 10: Text Modding Presets

### Preset 1: Rename All Items

**Goal**: Give all items custom names

**Modify**: All `item_name` files (11 languages)

**Example Approach**:
```csv
# Original
"100","Potion"

# Custom Theme (Sci-Fi)
"100","Nano-Repair Kit"

# Custom Theme (Fantasy)
"100","Healing Elixir"

# Custom Theme (Modern)
"100","First Aid Spray"
```

### Preset 2: Comedic Dialogue

**Goal**: Make NPCs funny

**Example**:
```csv
"10001","Shopkeeper","Welcome! Our prices are so low, they're basically stealing! ...Wait, did I say that out loud?"
"10002","Old Man","Back in my day, Digimon were REAL scary! Now they're all cute and friendly. Kids these days..."
"10003","Kid","My dad says I can't have a Digimon until I'm older. But YOU have like 11! That's not fair!"
```

### Preset 3: Lore-Heavy Descriptions

**Goal**: Add deep lore to everything

**Example**:
```csv
"5001","Mega Healing Potion - Crafted using the Ancient Remedy technique passed down through generations of healers. The rare Moon Herb used in this potion only blooms once every ten years under the light of a full moon. Legends say the first Mega Healing Potion was created by a legendary healer who saved an entire city from a plague."
```

### Preset 4: Minimalist Text

**Goal**: Short, direct text

**Example**:
```csv
"5001","Heals 800 HP."
"90001","Water attack. All enemies."
"587","Water guardian. Very strong."
```

---

## Verification Checklist

- [ ] Text added to ALL 11 language files
- [ ] IDs match corresponding data files
- [ ] No special characters breaking CSV format
- [ ] Quotation marks properly escaped ("")
- [ ] Text fits in UI (not too long)
- [ ] Consistent tone/voice
- [ ] No spelling/grammar errors
- [ ] Tested in-game display
- [ ] All referenced IDs exist
- [ ] Dialogue flows naturally

---

## Common Issues & Solutions

### Issue: Text shows as "???" or ID number
**Solution**: Add text to all 11 language files, not just one

### Issue: CSV file won't load/crashes game
**Solution**: Check for unescaped quotes. Use "" for quotes within text

### Issue: Text is cut off in menus
**Solution**: Shorten text. UI has character limits

### Issue: Line breaks don't work
**Solution**: Use `\n` for line breaks in dialogue

### Issue: Special characters display wrong
**Solution**: Ensure file encoding is UTF-8 with BOM

### Issue: Dialogue doesn't trigger
**Solution**: Check Message ID matches the one referenced in NPC/event data

---

## Advanced Tips

### Tip 1: Text Variables

Some text supports variables:

```csv
"MSG_BATTLE_WIN","You defeated {ENEMY_NAME}!"
"MSG_LEVEL_UP","{DIGIMON_NAME} reached level {LEVEL}!"
"MSG_ITEM_GET","Obtained {ITEM_NAME} x{AMOUNT}!"
```

**Common Variables**:
- `{PLAYER_NAME}` - Player's name
- `{DIGIMON_NAME}` - Current Digimon
- `{ITEM_NAME}` - Item name
- `{AMOUNT}` - Quantity
- `{LEVEL}` - Level number

### Tip 2: Color Codes

Some systems support color codes:

```csv
"MSG_RARE","<color=gold>Rare Item Obtained!</color>"
"MSG_WARNING","<color=red>Warning!</color> Strong enemy ahead."
"MSG_SUCCESS","<color=green>Quest Complete!</color>"
```

### Tip 3: Multi-Line Dialogue

Use \n for line breaks:

```csv
"10050","Long Speaker","This is a long dialogue.\nIt spans multiple lines.\nYou can use this for dramatic effect!"
```

### Tip 4: Choice Dialogue

Format for player choices:

```csv
"10060","NPC","Will you help me?"
"10061","Choice","Yes"
"10062","Choice","No"
"10063","Choice","Maybe later"
```

---

## Summary: Text File Categories

**Item Text** (33 files):
- ✅ `item_name` (×11)
- ✅ `item_explanation` (×11)
- ⭕ `item_ruby` (×11) - Optional

**Character Text** (22 files):
- ✅ `char_name` (×11)
- ✅ `digimon_profile` (×11)

**Skill Text** (22 files):
- ✅ `skill_name` (×11)
- ✅ `skill_explanation` (×11)

**Quest Text** (33 files):
- ✅ `quest_name` (×11)
- ✅ `quest_explanation` (×11)
- ✅ `quest_objective` (×11)

**Dialogue** (varies by area):
- ✅ `message/[area]` (×11 per area)

**UI Text** (11 files):
- ✅ `system` (×11)

---

**Happy Text Modding!** 📝✨

*Remember: Text must be in ALL 11 languages for proper display!*
*For CSV format help, see COMPREHENSIVE_FILE_DOCUMENTATION.md*

