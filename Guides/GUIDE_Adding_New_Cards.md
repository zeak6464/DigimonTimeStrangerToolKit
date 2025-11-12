# Guide: Adding New Cards to Digimon Time

**Complete guide for creating custom cards for the Digital Card Game minigame**

---

## Overview

The Digital Card Game is a minigame in Digimon Time where players collect and battle with cards. This guide covers adding new cards, including stats, artwork, and integration with the collection system.

**Estimated Files to Edit**: 4-6 files

**Difficulty**: Intermediate

---

## Step 1: Understanding Card System

### Card Components:
1. **Card ID Info**: Defines card stats, power, type
2. **Card Hand Info**: Defines how cards appear when drawn/held
3. **Card Names**: Localized card names
4. **Card Explanations**: Localized card descriptions  
5. **Card Packs**: Distribution in card packs (optional)

### File Locations:
- **Data**: `app_0.dx11/data/card_info/card_info.mbe/` (app) or `patch.dx11/data/card_info/card_info.mbe/` (patch)
- **Text**: `app_text00.dx11/text/card_name/` and `card_explanation/`

---

## Step 2: Card ID Info (Core Stats)

**Location**: `app_0.dx11/data/card_info/card_info.mbe/000_card_id_info.csv` or `patch.dx11/data/card_info/card_info.mbe/000_card_id_info.csv`

**CSV Structure**: 7 columns (0-6)

**Header**:
```
int32 0,int32 1,int32 2,empty 3,empty 4,empty 5,empty 6
```

### Column Meanings:

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | int32 | Card ID | Unique card identifier |
| 1 | int32 | Card Type | Card type/category |
| 2 | int32 | Card Power | Power/strength value (10000+) |
| 3-6 | empty | - | Always empty |

### Example Cards:
```csv
1,1,10001,,,,
2,2,10002,,,,
3,3,10003,,,,
```

### Card Type Values:
- **1-16**: Standard card types (corresponds to Digimon types or card effects)
- Use existing card types as reference

### Card Power:
- **10000+**: Power rating (higher = stronger)
- Format: 10001, 10002, 10003, etc.
- Use incremental values

---

## Step 3: Card Hand Info (Visual Display)

**Location**: `app_0.dx11/data/card_info/card_info.mbe/001_card_hand_info.csv` or `patch.dx11/data/card_info/card_info.mbe/001_card_hand_info.csv`

**Purpose**: Defines card appearance and Digimon associations

This file maps cards to specific Digimon. The structure is more complex and varies by entry.

**⚠️ NOTE**: This file has dynamic column structure. Copy existing entries as templates.

---

## Step 4: Card Names

**Location**: `app_text00.dx11/text/card_name/card_name.mbe/000_Sheet1.csv`

**Format**:
```csv
"CardID","Card Display Name"
```

**Example**:
```csv
"1","Agumon Card"
"2","Gabumon Card"
"3","Patamon Card"
"500","Custom Legendary Card"
```

**Add to all language folders**:
- English: `app_text00.dx11/text/`
- Japanese: `app_text01.dx11/text/`
- Other languages: `app_text02-09.dx11/text/`

---

## Step 5: Card Descriptions

**Location**: `app_text00.dx11/text/card_explanation/card_explanation.mbe/000_Sheet1.csv`

**Format**:
```csv
"CardID","Card Description"
```

**Example**:
```csv
"1","A basic Agumon card with moderate power."
"2","Gabumon's fierce attack card!"
"3","Patamon brings luck to your hand."
"500","The ultimate legendary card with maximum power!"
```

---

## Step 6: Card Pack Distribution (Optional)

**Location**: `app_0.dx11/data/card/card.mbe/000_card_pack_parameter.csv`

**Purpose**: Defines which cards appear in which packs

**Format**: Complex - defines pack contents, rarity distribution, and pull rates

**⚠️ NOTE**: This file controls how cards are obtained. Editing requires understanding of pack IDs and distribution mechanics.

---

## Step 7: Creating a New Card (Full Example)

### Example: Creating "UltraAgumon Card" (ID 500)

#### File 1: `000_card_id_info.csv`
Add row:
```csv
500,1,15000,,,,
```
- Card ID: 500
- Type: 1 (same as Agumon)
- Power: 15000 (very strong)

#### File 2: `001_card_hand_info.csv`
**⚠️ Complex file**: Copy an existing Agumon entry and modify the ID to 500

#### File 3: `card_name.mbe/000_Sheet1.csv`
Add row:
```csv
"500","UltraAgumon Legend"
```

#### File 4: `card_explanation.mbe/000_Sheet1.csv`
Add row:
```csv
"500","An ultra-rare legendary Agumon card with devastating power!"
```

---

## Step 8: Card NPCs (Advanced)

**Location**: `app_0.dx11/data/card_npc/card_npc.mbe/`

### Files:
- `000_card_npc_info.csv`: NPC opponents and their decks
- `001_card_npc_battle_history_info.csv`: Battle history tracking

**Purpose**: Define AI opponents who use specific cards

**Format**: String IDs like "CB_1001", "CB_Test_9000"

---

## Step 9: Field Card Game Integration

**Location**: `app_0.dx11/data/field_card_game/field_card_game.mbe/`

### Files:
- `000_field_card_gamer_npcs.csv`: NPCs who play card game in the field
- `001_field_card_game_def.csv`: Card game definition/settings

**Purpose**: Place card game NPCs in the game world

---

## Testing Checklist

### Test New Cards:

1. ✅ Card appears in collection with correct name
2. ✅ Card description displays correctly
3. ✅ Card power matches intended value
4. ✅ Card can be drawn in battle (if in deck)
5. ✅ Card visuals display correctly
6. ✅ Card works against AI opponents
7. ✅ No crashes or errors in card battles

---

## DLC Card Expansion

**Location**: `addcont_17.dx11/data/card_info_dlc17/card_info_dlc17.mbe/`

For DLC-exclusive cards:
- Create cards in DLC-specific folders
- Use DLC naming pattern: `card_info_dlc[##]`
- Reference DLC IDs in `dlc_info.mbe`

**Example DLC cards**:
```csv
# DLC 17 added cards for IDs: 130, 137, 206, 369, 370
```

---

## ID Ranges & Recommendations

### Safe Custom Card IDs:
- **500-999**: Custom cards (safe range)
- **1000+**: Reserved for future expansion

### Existing Card Count:
- Base game: 449 cards (IDs 1-449)
- Patch: 451 cards
- DLC: Additional cards per DLC

---

## Card Define System (Advanced)

**Location**: `app_0.dx11/data/card_define/card_define.mbe/`

### Files:
- `000_card_define_int.csv`: Integer definitions (46 entries)
- `001_card_define_float.csv`: Float definitions (2 entries)
- `002_card_battle_matrix.csv`: Battle mechanics matrix (3 entries)
- `003_default_card_info.csv`: Default card settings (5 entries)

**Purpose**: Global card game rules and mechanics

**⚠️ WARNING**: Modifying these files affects ALL cards. Only edit if you understand the entire card battle system.

---

## Tips & Warnings

1. **Always use unique IDs** - Duplicate card IDs will cause conflicts
2. **Match file patterns** - Keep card info and hand info synchronized
3. **Test with AI** - Make sure AI can use your cards if they're in NPC decks
4. **Power balance** - Don't make cards too powerful (breaks game balance)
5. **Copy existing templates** - Many card fields are undocumented
6. **Localize all languages** - Add names/descriptions to all language folders

---

## Multi-Language Support

**English**: `app_text00.dx11/text/`
**Japanese**: `app_text01.dx11/text/` (if exists)
**Other languages**: `app_text02-09.dx11/text/`

Add your card names and descriptions to all language folders for full compatibility.

---

## Quick Reference: New Card Checklist

For each new card:

- [ ] Add row to `000_card_id_info.csv` (stats)
- [ ] Add row to `001_card_hand_info.csv` (visuals)
- [ ] Add name to `card_name.mbe/000_Sheet1.csv`
- [ ] Add description to `card_explanation.mbe/000_Sheet1.csv`
- [ ] (Optional) Add to card pack distribution
- [ ] (Optional) Add to NPC decks
- [ ] Test in actual card battle

---

**End of Guide**

