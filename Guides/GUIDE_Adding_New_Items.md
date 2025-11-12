# Guide: Adding New Items to Digimon Time

**Complete guide for creating custom consumables, equipment, and special items**

---

## Overview

Items in Digimon Time include consumables (healing, stat items), equipment (accessories), key items, and special items. This guide uses **VERIFIED** data from actual game CSV files.

**Estimated Files to Edit**: 2-4 files (core) + optional localization

**Difficulty**: Intermediate

---

## Step 1: Understanding Item Categories

From analysis of `000_item_parameter.csv`:

### Common Categories (Column 7):
- **40**: HP Recovery (small - "Capsule" items)
- **41**: HP Recovery (large - "Spray" items)
- **42**: SP Recovery (small - "Capsule" items)
- **43**: SP Recovery (large - "Spray" items)
- **44**: Revival items
- **45-56**: Status cures and battle consumables
- **57**: Elemental resist items
- **59**: EXP boost items
- **60**: Bond boost items
- **62**: Special rare items

### ID Ranges:
- **1-1000**: Base game consumables
- **1001-2000**: Equipment/accessories
- **2001+**: Special and key items
- **5000+**: SAFE range for custom items

**Recommendation**: Use ID **5000+** for custom items

---

## Step 2: Core Files

### File 1: Item Parameters ⭐ CRITICAL

**Location**: `patch.dx11/data/item/item.mbe/000_item_parameter.csv`

**CSV Structure**: 28 columns (0-27)

**Header**:
```
int32 0,empty 1,empty 2,empty 3,int32 4,int32 5,int32 6,int32 7,int32 8,int32 9,int32 10,bool 11,bool 12,int32 13,empty 14,int32 15,int32 16,int32 17,int32 18,string2 19,int32 20,int32 21,int32 22,int32 23,int32 24,int32 25,int32 26,string2 27
```

**Column Meanings** (verified):

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | int32 | Item ID | Unique identifier |
| 1-3 | empty | - | Always empty |
| 4 | int32 | Name ID | References item_name.mbe |
| 5 | int32 | Secondary ID | Usually 0; matches col 4 for special items |
| 6 | int32 | Special Flag | 0=normal, 1=special/rare item |
| 7 | int32 | Category | Item category (see above) |
| 8 | int32 | Icon ID | UI icon reference |
| 9 | int32 | Buy Price | Shop price (-1 = cannot buy) |
| 10 | int32 | Sell Price | Sell value |
| 11 | bool | Flag 1 | Purpose varies by type |
| 12 | bool | Flag 2 | Purpose varies by type |
| 13 | int32 | Effect ID | References effect system (80000+) |
| 14 | empty | - | Always empty |
| 15 | int32 | Unknown | Usually 0 or -1 |
| 16 | int32 | Param 1 | Context-dependent (effect type, stat type) |
| 17 | int32 | Param 2 | Context-dependent (amount, value) |
| 18 | int32 | Param 3 | Usually -1 |
| 19 | string2 | String 1 | Usually empty |
| 20-22 | int32 | Unknown | Usually 0 |
| 23-26 | int32 | Unknown | Usually -1 |
| 27 | string2 | String 2 | Usually empty |

---

## Step 3: Item Templates (Verified)

### Template 1: HP Recovery Item
**Based on**: HP Capsule I (ID 1)

```csv
5001,,,,5001,0,0,40,15,500,100,true,true,80001,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Breakdown**:
- Item ID: 5001
- Name ID: 5001
- Category: 40 (HP capsule)
- Icon: 15
- Price: 500 buy / 100 sell
- Effect ID: 80001 (define healing amount elsewhere)

**Add to item_name.mbe**:
```csv
"5001","Custom HP Potion"
```

---

### Template 2: SP Recovery Item
**Based on**: SP Capsule I (ID 7)

```csv
5002,,,,5002,0,0,42,23,400,80,true,true,80007,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Breakdown**:
- Category: 42 (SP capsule)
- Icon: 23
- Price: 400 buy / 80 sell
- Effect ID: 80007

---

### Template 3: Revival Item
**Based on**: Revival items (ID 13-14)

```csv
5003,,,,5003,0,0,44,30,9000,1800,true,true,80013,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Breakdown**:
- Category: 44 (revival)
- Icon: 30
- Higher price: 9000 buy / 1800 sell
- Effect ID: 80013

---

### Template 4: Status Cure
**Based on**: Cure items (ID 15-22)

```csv
5004,,,,5004,0,0,45,33,150,30,true,false,80015,,-1,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Breakdown**:
- Category: 45 (status cure)
- Icon: 33
- Low price: 150 buy / 30 sell
- Flag 2: **false** (different from recovery items!)
- Column 15: **-1** (instead of 0)

---

### Template 5: EXP Boost Item ⭐ SPECIAL FORMAT
**Based on**: EXP items (ID 40-44)

```csv
5005,,,,5005,5005,1,59,52,-1,10,false,true,0,,3,50000,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Breakdown**:
- **CRITICAL**: Column 5 must also = 5005 (both col 4 and 5!)
- Column 6: **1** (special item flag)
- Category: 59 (EXP items)
- Buy price: **-1** (cannot buy - drop/reward only)
- Sell price: 10 (fixed)
- Flags: **false, true** (opposite of recovery items!)
- Effect ID: **0** (no effect ID!)
- Param 1: 3 (type indicator?)
- Param 2: **50000** (EXP amount given)

---

### Template 6: Bond Boost Item ⭐ SPECIAL FORMAT
**Based on**: Bond items (ID 45-47)

```csv
5006,,,,5006,5006,1,60,57,-1,10,false,true,0,,4,500,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Breakdown**:
- Column 5: Must match column 4
- Column 6: 1 (special item)
- Category: 60 (bond items)
- Buy: -1 (cannot buy)
- Sell: 10
- Param 1: 4 (bond type indicator)
- Param 2: **500** (bond amount - use 100, 300, 500)

---

### Template 7: Elemental Resistance Item
**Based on**: Resist items (ID 30-39)

```csv
5007,,,,5007,0,1,57,84,700,140,true,false,80031,,-1,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Breakdown**:
- Column 6: 1 (special type)
- Category: 57 (elemental resist)
- Icons: 84-93 (one per element)
- Effect ID: 80031+ (one per element)

---

## Step 4: Required Text Files

### File 2: Item Names ⭐ CRITICAL

**Location**: `patch_text01.dx11/text/item_name/item_name.mbe/000_Sheet1.csv`

**Format**:
```csv
"ItemID","Display Name"
```

**Example**:
```csv
"5001","Mega HP Potion"
"5002","Ultra SP Elixir"
"5003","Phoenix Down"
"5004","Full Cure"
"5005","EXP Boost XL"
"5006","Bond Booster"
"5007","Fire Resist Charm"
```

**⚠️ CRITICAL**: The string ID in quotes must match Column 4 (Name ID) from the parameters file!

---

### File 3: Item Descriptions (Optional)

**Location**: `patch_text01.dx11/text/item_explanation/item_explanation.mbe/000_Sheet1.csv`

**Format**:
```csv
"EffectID","Description Text"
```

**Example**:
```csv
"80001","Restores HP to a Digimon."
"5005","Increases a Digimon's EXP by 50000."
```

**Note**: Use Effect ID from column 13, NOT the item ID!

---

## Step 5: Equipment Items (Advanced)

**Location**: `patch.dx11/data/item/item.mbe/001_equip_parameter.csv`

Equipment items are defined separately. They reference item IDs from `000_item_parameter.csv` but define stats in this file.

**Example equipment entry in 000_item_parameter.csv**:
```csv
6001,,,,6001,0,0,65,100,10000,2000,true,false,0,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```
- Category: 65+ (equipment categories)
- Effect ID: 0 (stats defined in equip_parameter instead)

Then define stats in `001_equip_parameter.csv` (separate guide recommended).

---

## Step 6: Testing Checklist

### Test New Items:

1. ✅ Item appears in game with correct name
2. ✅ Icon displays correctly in inventory
3. ✅ Can be bought from shop (if price > 0)
4. ✅ Sells for correct amount
5. ✅ Using item triggers correct effect
6. ✅ Special items (EXP/Bond) apply correct values
7. ✅ Stack limit works correctly
8. ✅ No crashes or errors

---

## Common Patterns

### Recovery Items:
- Categories: 40-44
- Flags: true, true
- Effect IDs: 80000-80030
- Column 15: 0
- Buyable with normal prices

### Special Items (EXP/Bond):
- Categories: 59-60
- Column 5: MUST match column 4
- Column 6: 1 (special flag)
- Flags: false, true
- Effect ID: 0
- Buy price: -1 (drop only)
- Sell price: 10 (fixed)
- Param 2: Contains actual value

### Status/Battle Items:
- Categories: 45-56
- Flags: true, false (note: second is FALSE!)
- Column 15: -1 (not 0!)
- Lower prices

---

## Effect ID System

Effect IDs (column 13) reference a separate effect system:
- **80000-80030**: Recovery/status effects
- **80031-80040**: Elemental resists
- **85000+**: Custom effects (safe range)

**⚠️ WARNING**: Effect definitions are in a separate system not covered here. For custom healing amounts, you may need to define new effect IDs.

---

## Tips & Warnings

1. **Always copy existing templates** - The item system has many undocumented columns
2. **Match column 4 and 5 for special items** - EXP/Bond items require both!
3. **Use -1 for unsellable items** - Premium items should have buy price = -1
4. **Test thoroughly** - Some column combinations may crash the game
5. **Icon IDs are limited** - Reuse existing icons or add custom icon files
6. **Effect IDs must exist** - Invalid effect IDs will crash on use

---

## Multi-Language Support

**English**: `patch_text01.dx11/text/`
**Japanese**: `patch_text02.dx11/text/`
**Other languages**: `patch_text03-09.dx11/text/`

Add your item names/descriptions to all language folders, or copy English to all for consistency.

---

## Quick Reference: Column Formula

**Standard Consumable**:
```
ID,,,,ID,0,0,CATEGORY,ICON,BUY,SELL,true,true,EFFECT_ID,,0,-1,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

**Special Item (EXP/Bond)**:
```
ID,,,,ID,ID,1,CATEGORY,ICON,-1,10,false,true,0,,TYPE,VALUE,-1,-1,"",0,0,0,-1,-1,-1,-1,""
```

---

**End of Guide**
