# Guide: Modifying Shops & Inventories in Digimon Time

**Complete guide for customizing shop inventories, prices, and availability**

---

## Overview

Shops in Digimon Time sell items, equipment, and sometimes special goods. This guide shows you how to modify what shops sell, when items become available, and how to create custom shops.

**Estimated Files to Edit**: 3-10 files

**Difficulty**: Beginner to Intermediate

---

## Part 1: Shop Inventory

### File 1: Shop Lineup ⭐ CRITICAL

**Location**: `patch.dx11/data/shop/shop.mbe/001_shop_lineup.csv`

**Structure**:
```csv
Shop_ID,Item_ID,Unlock_Flag,Quest_Requirement,Story_Requirement
```

**Column Guide** (5 total columns):

| Column | Name | Example | Description |
|--------|------|---------|-------------|
| 0 | Shop ID | 1 | Which shop (see Shop IDs below) |
| 1 | Item ID | 100 | What item to sell |
| 2 | Unlock Flag | 1 | 0=Locked, 1=Available immediately |
| 3 | Quest Requirement | 0 | Quest ID to complete (0=none) |
| 4 | Story Requirement | 0 | Story chapter required (0=none) |

---

## Part 2: Shop ID Reference

### Shop IDs by Location:

| Shop ID | Location | Type |
|---------|----------|------|
| 1 | Tutorial Town - Item Shop | Consumables |
| 2 | Main City - Item Shop | Consumables |
| 3 | Main City - Equipment Shop | Gear |
| 4 | Port City - Item Shop | Consumables |
| 5 | Port City - Equipment Shop | Gear |
| 6 | Mountain Town - General Store | Mixed |
| 7 | Late Game City - Premium Shop | Rare Items |
| 8 | Secret Shop - Black Market | Special |
| 9 | DLC Shop 1 | DLC Items |
| 10 | DLC Shop 2 | DLC Items |
| 11+ | Custom Shops | Player-created |

---

## Part 3: Adding Items to Shops

### Example 1: Add Item to Existing Shop

**Goal**: Add Mega Potion (ID 5001) to Main City Item Shop (Shop 2)

**Add row**:
```csv
2,5001,1,0,0
```

**Result**: Item 5001 is immediately available at Shop 2.

### Example 2: Add Item with Story Lock

**Goal**: Add Revive Crystal (ID 5003) to Shop 2, but only after Chapter 5

**Add row**:
```csv
2,5003,1,0,5
```

**Result**: Item 5003 appears in Shop 2 only after player reaches Chapter 5.

### Example 3: Add Item with Quest Lock

**Goal**: Add special item (ID 5100) after completing Quest 25

**Add row**:
```csv
7,5100,0,25,0
```

**Result**: Item 5100 appears in Shop 7 only after completing Quest 25.

### Example 4: Add Multiple Items

**Goal**: Stock a shop with healing items

**Add multiple rows**:
```csv
2,100,1,0,0
2,101,1,0,0
2,102,1,0,2
2,103,1,0,4
2,104,1,0,6
```

**Result**: 
- Items 100-101: Available immediately
- Item 102: Chapter 2+
- Item 103: Chapter 4+
- Item 104: Chapter 6+

---

## Part 4: Progressive Shop Inventory

### Template: Tiered Item Shop

**Early Game Items** (Chapter 0-2):
```csv
1,10,1,0,0    # Small Potion
1,11,1,0,0    # Small Ether
1,20,1,0,1    # Medium Potion (Chapter 1+)
1,21,1,0,2    # Medium Ether (Chapter 2+)
```

**Mid Game Items** (Chapter 3-6):
```csv
2,20,1,0,0    # Medium Potion (always available)
2,21,1,0,0    # Medium Ether (always available)
2,30,1,0,3    # Large Potion (Chapter 3+)
2,31,1,0,4    # Large Ether (Chapter 4+)
2,40,1,0,5    # Mega Potion (Chapter 5+)
2,41,1,0,6    # Mega Ether (Chapter 6+)
```

**Late Game Items** (Chapter 7+):
```csv
7,40,1,0,0    # Mega Potion (always available)
7,41,1,0,0    # Mega Ether (always available)
7,50,1,0,7    # Ultra Potion (Chapter 7+)
7,51,1,0,8    # Ultra Ether (Chapter 8+)
7,100,1,50,9  # Divine Elixir (Quest 50 + Chapter 9)
```

---

## Part 5: Equipment Shop Setup

### Template: Balanced Equipment Shop

**Accessories (various stat bonuses)**:
```csv
3,1001,1,0,0   # Basic Ring (+50 HP)
3,1002,1,0,1   # Power Band (+20 ATK)
3,1003,1,0,2   # Guard Badge (+20 DEF)
3,1004,1,0,3   # Magic Charm (+20 INT)
3,1005,1,0,4   # Speed Shoes (+20 SPD)
3,1010,1,0,5   # Advanced Ring (+100 HP, +30 SP)
3,1011,1,0,6   # Dragon Scale (all stats, Chapter 6+)
```

**Progression System**:
- Chapter 0-2: Basic stat items (+10-20 single stat)
- Chapter 3-5: Intermediate (+30-50 single stat or dual stats)
- Chapter 6+: Advanced (+50+ or all-stat items)

---

## Part 6: Special/Secret Shops

### Example: Quest Reward Shop

**Goal**: Unlock items only through quest completion

```csv
8,5200,0,10,0   # Item unlocked by Quest 10
8,5201,0,15,0   # Item unlocked by Quest 15
8,5202,0,20,0   # Item unlocked by Quest 20
8,5203,0,30,0   # Item unlocked by Quest 30
8,5204,0,50,0   # Item unlocked by Quest 50 (legendary)
```

**Note**: Unlock Flag = 0, so items are locked until quest is done.

### Example: Black Market

**Goal**: Expensive but powerful items with no restrictions

```csv
8,5300,1,0,0   # Evolution Crystal (expensive)
8,5301,1,0,0   # Rare Skill Book
8,5302,1,0,0   # Legendary Equipment
8,5303,1,0,0   # Debug Item (for testing)
```

**Note**: All unlock flag = 1, no requirements, but items should be very expensive in `item_data.csv`.

---

## Part 7: Creating Custom Shops

### File 2: Shop Data

**Location**: `patch.dx11/data/shop/shop.mbe/000_shop_data.csv`

**Add new shop**:

```csv
11,"CUSTOM_SHOP_1",100.0,50.0,200.0,5,1,0,0
```

**Column Guide**:

| Column | Name | Description |
|--------|------|-------------|
| 0 | Shop ID | 11 (use 11+ for custom) |
| 1 | Internal Name | "CUSTOM_SHOP_1" |
| 2-4 | X, Y, Z | Position in world |
| 5 | Map ID | Which map/area |
| 6 | NPC ID | Shopkeeper NPC |
| 7 | Unlock Quest | Quest to unlock shop (0=none) |
| 8 | Unlock Chapter | Story chapter to unlock (0=always) |

**Example: Hidden Late-Game Shop**

```csv
15,"SECRET_LEGENDARY_SHOP",500.0,100.0,800.0,20,50,75,10
```

**Properties**:
- Shop ID: 15
- Position: (500, 100, 800) on Map 20
- NPC 50 is shopkeeper
- Unlocks after Quest 75 AND Chapter 10

---

## Part 8: Shop Localization

### File 3-13: Shop Names (11 languages)

**Locations**: `patch_text[##].dx11/text/shop_name/shop_name.mbe/000_Sheet1.csv`

**Add name for custom shop**:

```csv
"11","Custom Rare Items"
```

**Add for all 11 language files** (00, 01, 02, 03, 04, 05, 07, 09, 10, 11, 30)

### File 14-24: Shop Descriptions (11 languages)

**Locations**: `patch_text[##].dx11/text/shop_explanation/shop_explanation.mbe/000_Sheet1.csv`

**Add description**:

```csv
"11","A mysterious shop selling rare and powerful items. Only for experienced Tamers."
```

---

## Part 9: Shop Stock Templates

### Template 1: Beginner Shop

**Focus**: Basic healing, cheap items

```csv
1,10,1,0,0    # HP Restore I (100 HP) - 50 money
1,11,1,0,0    # SP Restore I (50 SP) - 30 money
1,12,1,0,0    # Antidote - 20 money
1,13,1,0,0    # Paralysis Cure - 20 money
1,14,1,0,1    # HP Restore II (300 HP) - 150 money, Chapter 1+
1,15,1,0,1    # SP Restore II (100 SP) - 100 money, Chapter 1+
```

### Template 2: Mid-Game Shop

**Focus**: Balanced items, some equipment

```csv
2,20,1,0,0    # HP Restore III (500 HP) - 300 money
2,21,1,0,0    # SP Restore III (200 SP) - 200 money
2,22,1,0,0    # Full Cure - 500 money
2,23,1,0,3    # Revive - 1000 money, Chapter 3+
2,1001,1,0,2  # Basic Accessory - 5000 money, Chapter 2+
2,1002,1,0,4  # Advanced Accessory - 15000 money, Chapter 4+
```

### Template 3: Late-Game Premium Shop

**Focus**: Expensive, powerful items

```csv
7,40,1,0,0    # HP Restore V (full heal) - 2000 money
7,41,1,0,0    # SP Restore V (full SP) - 1500 money
7,42,1,0,0    # Divine Elixir (heal all) - 5000 money
7,43,1,0,0    # Battle Boost Items - 3000 money
7,5200,1,0,7  # Legendary Equipment - 50000 money, Chapter 7+
7,5300,1,50,8 # Evolution Items - 25000 money, Quest 50, Chapter 8+
```

### Template 4: Specialty Shop (Skill Books)

**Focus**: Teaching skills

```csv
8,5020,1,0,3   # Skill Book: Fire Attack - 10000 money, Chapter 3+
8,5021,1,0,3   # Skill Book: Water Attack - 10000 money, Chapter 3+
8,5022,1,0,5   # Skill Book: Thunder Attack - 15000 money, Chapter 5+
8,5023,1,0,5   # Skill Book: Healing - 12000 money, Chapter 5+
8,5024,1,25,7  # Skill Book: Ultimate Move - 50000 money, Quest 25, Chapter 7+
```

### Template 5: Materials Shop

**Focus**: Crafting materials

```csv
6,5040,1,0,0   # Steel Fragment - 100 money
6,5041,1,0,0   # Digital Ore - 150 money
6,5042,1,0,2   # Crystal Shard - 300 money, Chapter 2+
6,5043,1,0,4   # Ancient Fossil - 800 money, Chapter 4+
6,5044,1,30,6  # Legendary Material - 5000 money, Quest 30, Chapter 6+
```

---

## Part 10: Shop Modding Presets

### Preset 1: Everything Available Early

**Goal**: Remove all restrictions, all items from start

**Modify shop_lineup.csv**:
```
Set all column 2 (Unlock Flag) = 1
Set all column 3 (Quest Requirement) = 0
Set all column 4 (Story Requirement) = 0
```

**Example script**:
```
For each row:
  Column 2 = 1
  Column 3 = 0
  Column 4 = 0
```

### Preset 2: Hard Mode (Limited Stock)

**Goal**: Remove powerful items from shops

**Modify shop_lineup.csv**:
```
Delete rows with rare/legendary items
Delete revival items
Increase story requirements by +2 chapters
```

**Keep only**:
- Basic healing items
- Cheap equipment
- Essential consumables

### Preset 3: Speedrun Setup

**Goal**: All important items available immediately

**Add to Shop 1**:
```csv
1,100,1,0,0    # All healing items
1,101,1,0,0
1,102,1,0,0
1,103,1,0,0
1,104,1,0,0
1,5300,1,0,0   # Evolution items
1,5301,1,0,0
1,5302,1,0,0
```

**Result**: Everything available from first shop.

### Preset 4: Quest Reward Shop

**Goal**: Lock all rare items behind quests

**Modify shop_lineup.csv**:
```
For legendary items:
  Column 3 (Quest) = High quest ID (50+)
  Column 4 (Story) = Late chapter (8+)
```

**Example**:
```csv
7,5200,0,60,9   # Legendary item needs Quest 60 + Chapter 9
7,5201,0,70,10  # Ultra rare needs Quest 70 + Chapter 10
```

---

## Part 11: Price Modding

### File: Item Prices

**Location**: `patch.dx11/data/item/item.mbe/000_item_data.csv`

**Price Columns**:
- **Column 7**: Buy Price (what player pays)
- **Column 8**: Sell Price (what shop pays)

**Tip**: Sell price is usually 50% of buy price.

**Example**: Make all items cheaper

**Original**:
```csv
100,0,2,"MEGA_POTION",0,0,0,500,250,99,true,false,0,1,800,0,0,0,15,true,false,0
```

**50% Off**:
```csv
100,0,2,"MEGA_POTION",0,0,0,250,125,99,true,false,0,1,800,0,0,0,15,true,false,0
```

**Example**: Make specific item free

```csv
100,0,2,"MEGA_POTION",0,0,0,0,0,99,true,false,0,1,800,0,0,0,15,true,false,0
```

---

## Complete Shop Setup Example

### Example: "Ultimate Modder Shop"

**Goal**: Create custom shop with all modded items

**Step 1: Create shop** (shop_data.csv):
```csv
20,"MODDER_PARADISE",300.0,50.0,400.0,10,100,0,0
```

**Step 2: Add inventory** (shop_lineup.csv):
```csv
# Custom Healing Items
20,5001,1,0,0   # Mega Potion (custom)
20,5002,1,0,0   # Super Ether (custom)
20,5003,1,0,0   # Revive Crystal (custom)

# Custom Equipment
20,5200,1,0,0   # Dragon Scale (custom)
20,5201,1,0,0   # Power Band (custom)
20,5202,1,0,0   # Speed Boots (custom)

# Custom Skill Books
20,5020,1,0,0   # Tsunami Strike book (custom)
20,5021,1,0,0   # Custom skill 2
20,5022,1,0,0   # Custom skill 3

# Evolution Items
20,5300,1,0,0   # Data Crystal (custom)
20,5301,1,0,0   # Digital Core (custom)

# Debug Items
20,9990,1,0,0   # Max Level Up
20,9991,1,0,0   # All Stats +100
```

**Step 3: Add names** (all 11 languages):
```csv
"20","Modder's Paradise"
```

**Step 4: Add descriptions** (all 11 languages):
```csv
"20","A special shop containing all custom-created items. For modders and testers only!"
```

---

## Verification Checklist

- [ ] All shop IDs are unique
- [ ] All item IDs exist in item_data.csv
- [ ] Story requirements are achievable (valid chapters)
- [ ] Quest requirements exist (valid quest IDs)
- [ ] Shop names added to all 11 languages
- [ ] Shop descriptions added to all 11 languages
- [ ] Prices are set in item_data.csv
- [ ] Shop location is accessible in-game
- [ ] Shop NPC exists and is visible
- [ ] Test in-game to verify items appear

---

## Common Issues & Solutions

### Issue: Items don't appear in shop
**Solution**: Check unlock flag (column 2) = 1, or complete required quest/chapter

### Issue: Shop doesn't exist in game world
**Solution**: Add entry to shop_data.csv with valid position and map ID

### Issue: Item shows "???" as name
**Solution**: Add item name to all 11 language files in item_name folders

### Issue: Can't buy item (greyed out)
**Solution**: Check price in item_data.csv column 7, make sure it's not too expensive or check if player has enough money

### Issue: Shop appears too early/late
**Solution**: Adjust story requirement (column 4) or quest requirement (column 3)

### Issue: Wrong items in shop
**Solution**: Check Shop ID (column 0) matches intended shop

---

## Advanced Tips

### Tip 1: Dynamic Shop Updates

Use story requirements to make shops update inventory:

```csv
# Early game version
2,100,1,0,0   # Basic item available from start

# Late game version (replaces early)
2,105,1,0,5   # Better item appears Chapter 5+
```

**Result**: Shop stock "upgrades" as story progresses.

### Tip 2: Quest-Unlocked Rare Shop

Create hidden shop that only appears after special quest:

```csv
# In shop_data.csv
25,"SECRET_SHOP",1000.0,500.0,1500.0,15,200,99,10

# In shop_lineup.csv
25,5500,1,0,0  # Legendary items always in stock
25,5501,1,0,0  # Once shop is unlocked
```

**Result**: Shop 25 only exists after Quest 99 in Chapter 10.

### Tip 3: Progressive Price Reduction

Add same item multiple times with different unlock times:

```csv
7,5200,1,0,5   # Price: 50000 (Chapter 5)
```

Then in item_data.csv, create cheaper versions:

```csv
5200,1,4,"DRAGON_SCALE",0,0,0,50000,25000,1,true,false,0,1,0,0,0,0,0,false,false,0
5205,1,4,"DRAGON_SCALE_SALE",0,0,0,25000,12500,1,true,false,0,1,0,0,0,0,0,false,false,0
```

Add sale version later:
```csv
7,5205,1,80,9  # Quest 80, Chapter 9 - half price!
```

---

## Summary: File Checklist

**Required (1 file)**:
- ✅ `shop_lineup.csv` - Add items to shops

**Optional but Recommended (2+ files)**:
- ⭕ `shop_data.csv` - Create new shops
- ⭕ `shop_name` (×11) - Shop names
- ⭕ `shop_explanation` (×11) - Shop descriptions

**Related (1 file)**:
- ⭕ `item_data.csv` - Adjust prices

---

**Happy Shop Modding!** 🛒✨

*For item IDs and properties, see GUIDE_Adding_New_Items.md*
*For quest IDs, see GUIDE_Adding_Quests.md*

