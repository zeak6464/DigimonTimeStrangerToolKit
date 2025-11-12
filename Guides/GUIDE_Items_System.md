# Guide: Items System in Digimon Time Stranger

**Complete guide for understanding and modifying items**

✅ **Verified against**:
- [Grindosaur Items Database](https://www.grindosaur.com/en/games/digimon-story-time-stranger/items)
- Actual CSV structure

---

## Overview

Items in Digimon Time Stranger include:
- **Consumables**: HP/SP restoratives, status healers, battle boosters
- **Equipment**: Items that boost stats when held
- **Key Items**: Story/quest items
- **Materials**: Crafting and trading items

**Difficulty**: Intermediate

---

## File Structure

### File 1: Item Parameters ⭐ CRITICAL

**Location**: `patch.dx11/data/item/item.mbe/000_item_parameter.csv`

**Structure** (28 columns):

| Column | Name | Description | Example |
|--------|------|-------------|---------|
| 0 | **Item ID** | Unique item identifier | 1 |
| 4 | **Item Type** | Item category (see below) | 1 |
| 5 | **Sub Type** | Item sub-category | 0 |
| 6 | **Rarity** | Item rarity tier (0-5) | 0 |
| 7 | **Sort Category** | Menu sort category | 40 |
| 8 | **Name ID** | Text reference for name | 15 |
| 9 | **Buy Price** | Shop purchase price | 300 |
| 10 | **Sell Price** | Shop sell price | 60 |
| 11 | **Can Use** | Can use in menu (true/false) | true |
| 12 | **Can Sell** | Can sell to shops (true/false) | true |
| 13 | **Description ID** | Text reference for description | 80001 |
| 15 | **Effect Value** | Effect strength/amount | 0 |
| 16 | **Effect Type 1** | Primary effect | -1 |
| 17 | **Effect Type 2** | Secondary effect | -1 |
| 18 | **Effect Type 3** | Tertiary effect | -1 |
| 19 | **Icon** | Icon reference | "" |
| 20-26 | **Various Flags** | Battle use, field use, etc. | varies |

### Item Types (Column 4)

```
1 = HP Restoratives
2 = SP Restoratives
3 = Status Healers
4 = Battle Boosters
5 = Field Items
6 = Equipment
7 = Key Items
8 = Materials
```

### Rarity Tiers (Column 6)

```
0 = Common (white)
1 = Uncommon (green)
2 = Rare (blue)
3 = Epic (purple)
4 = Legendary (orange)
5 = Unique (gold)
```

---

### File 2: Equipment Parameters

**Location**: `patch.dx11/data/item/item.mbe/001_equip_parameter.csv`

**Purpose**: Defines stat bonuses for equipment items

**Structure**: Stats boosts when equipped

---

### Files 3-13: Item Names (11 languages)

**Locations**: `patch_text##.dx11/text/item_name/item_name.mbe/000_Sheet1.csv`

**Format**:
```csv
"Item_ID","Item Name"
```

**Examples**:
```csv
"1","HP Capsule I"
"7","SP Capsule I"
"15","Poison Recovery"
"30","ATK Boost"
```

---

### Files 14-24: Item Descriptions (11 languages)

**Locations**: `patch_text##.dx11/text/item_explanation/item_explanation.mbe/000_Sheet1.csv`

**Format**:
```csv
"Description_ID","Description text"
```

**Examples**:
```csv
"80001","Restores a small amount of HP to one party member."
"80007","Restores a small amount of SP to one party member."
```

---

## Item Categories

### HP Restoratives (Type 1)

| ID | Name | Effect | Buy Price |
|----|------|--------|-----------|
| 1 | HP Capsule I | Restore small HP | 300 |
| 2 | HP Capsule II | Restore medium HP | 800 |
| 3 | HP Capsule III | Restore large HP | 3300 |
| 4 | HP Spray I | Restore party small HP | 900 |
| 5 | HP Spray II | Restore party medium HP | 3600 |
| 6 | HP Spray III | Restore party large HP | 7200 |

### SP Restoratives (Type 2)

| ID | Name | Effect | Buy Price |
|----|------|--------|-----------|
| 7 | SP Capsule I | Restore small SP | 400 |
| 8 | SP Capsule II | Restore medium SP | 1600 |
| 9 | SP Capsule III | Restore large SP | 6700 |
| 10 | SP Spray I | Restore party small SP | 1200 |
| 11 | SP Spray II | Restore party medium SP | 4800 |
| 12 | SP Spray III | Restore party large SP | 9600 |

### Status Healers (Type 3)

| ID | Name | Effect | Buy Price |
|----|------|--------|-----------|
| 15 | Poison Recovery | Cure poison | 150 |
| 16 | Panic Recovery | Cure panic | 150 |
| 17 | Paralysis Recovery | Cure paralysis | 150 |
| 18 | Sleep Recovery | Cure sleep | 150 |
| 19 | Sprite Recovery | Cure sprite | 150 |
| 24 | Multi-Recovery | Cure all statuses | varies |

### Battle Boosters (Type 4)

| ID | Name | Effect | Buy Price |
|----|------|--------|-----------|
| 30 | ATK Boost | Boost ATK in battle | varies |
| 31 | DEF Boost | Boost DEF in battle | varies |
| 32 | INT Boost | Boost INT in battle | varies |
| 33 | SPI Boost | Boost SPI in battle | varies |
| 34 | SPD Boost | Boost SPD in battle | varies |
| 35 | ACU Boost | Boost Accuracy | varies |
| 36 | EVA Boost | Boost Evasion | varies |
| 37 | CRT Boost | Boost Critical Rate | varies |

---

## How to Modify Items

### Example 1: Make HP Capsule I More Powerful

**Goal**: Increase healing from "small" to "large"

**Find Item 1 in** `000_item_parameter.csv`:
```csv
1,,,,1,0,0,40,15,300,60,true,true,80001,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Modify Column 15** (Effect Value):
```csv
1,,,,1,0,0,40,15,300,60,true,true,80001,,2,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Effect Value Guide**:
- 0 = Small (restores ~30%)
- 1 = Medium (restores ~60%)
- 2 = Large (restores ~100%)

---

### Example 2: Make Items Free

**Goal**: Set all restorative prices to 0

**Find items 1-12**, modify Column 9 (Buy Price):

```csv
Before: 1,,,,1,0,0,40,15,300,60,true,true...
After:  1,,,,1,0,0,40,15,0,60,true,true...
```

**Batch Edit**: Change column 9 to 0 for all consumable items

---

### Example 3: Create Custom Item

**Step 1**: Choose Item ID (use 5000+ for custom items)

**Step 2**: Add to `000_item_parameter.csv`

```csv
5000,,,,1,0,3,40,5000,9999,1999,true,true,85000,,3,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Column Breakdown**:
- ID: 5000
- Type: 1 (HP Restorative)
- Rarity: 3 (Epic)
- Name ID: 5000 (custom)
- Buy Price: 9999
- Sell Price: 1999
- Description ID: 85000
- Effect Value: 3 (Ultra Large!)

**Step 3**: Add name to ALL 11 language files

**Location**: `patch_text01.dx11/text/item_name/item_name.mbe/000_Sheet1.csv`

```csv
"5000","Ultimate HP Potion"
```

**Step 4**: Add description to ALL 11 language files

**Location**: `patch_text01.dx11/text/item_explanation/item_explanation.mbe/000_Sheet1.csv`

```csv
"85000","Fully restores HP to one party member. A legendary restorative."
```

**Step 5**: Add to shop (optional)

**Location**: `patch.dx11/data/shop/shop.mbe/000_shop_lineup.csv`

Find a shop and add item 5000 to its inventory.

---

## Item Rarity Modding

### Make All Items Legendary

**Goal**: Change all items to orange (legendary) rarity

**Modify Column 6** for all items:

```csv
Before: 1,,,,1,0,0,40,15,300...
After:  1,,,,1,0,4,40,15,300...
```

**Rarity Visual Effects**:
- 0 = No glow
- 1 = Green glow
- 2 = Blue glow
- 3 = Purple glow
- 4 = Orange glow (legendary!)
- 5 = Gold glow (unique!)

---

## Price Balancing

### Economy Presets

**Easy Mode** (cheap items):
```
HP Capsule I: 300 → 50
HP Capsule II: 800 → 150
HP Capsule III: 3300 → 500
```

**Hard Mode** (expensive items):
```
HP Capsule I: 300 → 1000
HP Capsule II: 800 → 3000
HP Capsule III: 3300 → 10000
```

**Free Mode** (everything free):
```
All Buy Prices: → 0
All Sell Prices: → 0
```

---

## Equipment System

**Equipment items** (Type 6) have additional data in `001_equip_parameter.csv`:

### Equipment Stats

| Stat | Column | Effect |
|------|--------|--------|
| HP Boost | varies | +HP when equipped |
| SP Boost | varies | +SP when equipped |
| ATK Boost | varies | +ATK when equipped |
| DEF Boost | varies | +DEF when equipped |
| INT Boost | varies | +INT when equipped |
| SPI Boost | varies | +SPI when equipped |
| SPD Boost | varies | +SPD when equipped |

**Example Equipment Entry**:
```csv
Equipment_ID,HP,SP,ATK,DEF,INT,SPI,SPD,Special_Effect
```

---

## Item Effects Reference

### Effect Types (Columns 16-18)

```
-1 = None
0 = Restore HP
1 = Restore SP
2 = Cure Poison
3 = Cure Paralysis
4 = Cure Sleep
5 = Cure Confusion
6 = Cure All Status
7 = Boost ATK
8 = Boost DEF
9 = Boost INT
10 = Boost SPI
11 = Boost SPD
12 = Revive
```

### Effect Values (Column 15)

**For Restoratives**:
```
0 = Small (~30% HP/SP)
1 = Medium (~60% HP/SP)
2 = Large (~100% HP/SP)
3 = Ultra (Full + overflow)
```

**For Boosters**:
```
Value = Percentage boost (e.g., 30 = +30%)
```

---

## Shop Integration

### Adding Items to Shops

**Location**: `patch.dx11/data/shop/shop.mbe/000_shop_lineup.csv`

**Format**:
```csv
Shop_ID,Item_Slot,Item_ID,Quantity_Available,Unlock_Condition
```

**Example**: Add your custom item to shop 1, slot 10
```csv
1,10,5000,99,0
```

---

## Testing Checklist

- [ ] Item appears in inventory menu
- [ ] Name displays correctly in all languages
- [ ] Description displays correctly
- [ ] Price is correct in shops
- [ ] Can be bought from shops
- [ ] Can be sold to shops
- [ ] Effect works correctly (HP restore, etc.)
- [ ] Icon displays properly
- [ ] Rarity color shows correctly

---

## Common Issues

### Issue 1: Item Name Shows as "???"
**Cause**: Missing name in text files  
**Fix**: Add item ID and name to ALL 11 `item_name.mbe` files

### Issue 2: Item Has No Effect
**Cause**: Effect Type and Effect Value not set  
**Fix**: Set columns 15-18 correctly

### Issue 3: Can't Buy Item in Shop
**Cause**: Item not added to shop lineup  
**Fix**: Add to `000_shop_lineup.csv`

### Issue 4: Item Can't Be Used
**Cause**: Column 11 (Can Use) is false  
**Fix**: Set column 11 to `true`

---

## Advanced: Custom Item Categories

### Creating a New Item Category

**Example**: Create "Super Items" category

**Step 1**: Use unused Type ID (e.g., Type 10)

```csv
5001,,,,10,0,5,100,5001,99999,19999,true,true,85001,,5,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Step 2**: Create menu entries (requires more advanced modding)

**Step 3**: Add icon and UI elements

---

## Summary

- ✅ Items are defined in `item.mbe/000_item_parameter.csv`
- ✅ Equipment has additional data in `001_equip_parameter.csv`
- ✅ Names/descriptions are in 11 language files each
- ✅ Item types: 1=HP, 2=SP, 3=Status, 4=Boost, 6=Equipment, 7=Key, 8=Material
- ✅ Rarity affects visual appearance (0-5)
- ✅ Effect values determine strength (0-3 for restoratives)
- ✅ Prices in columns 9 (buy) and 10 (sell)

---

## 📚 References

- [Grindosaur Items Database](https://www.grindosaur.com/en/games/digimon-story-time-stranger/items)
- Game files: `item.mbe/` directory
- `GUIDE_Modifying_Shops.md` - For shop integration

**Guide Version**: 1.0  
**Last Updated**: October 21, 2025  
**Status**: ✅ Verified against game data

