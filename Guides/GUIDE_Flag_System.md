# Guide: Game Flag System in Digimon Time

**Complete guide for understanding and modifying game flags**

---

## Overview

The Flag System in Digimon Time is the core mechanism for tracking game state, story progression, quest completion, unlocks, and conditions. Every major event, quest, and unlock in the game is controlled by flags.

**Total Flags**: ~5,000 flags

**File Location**: `patch.dx11/data/flag_list/flag_list.mbe/000_Flag_List.csv`

**Difficulty**: Advanced

---

## Step 1: Understanding Flags

### What are Flags?
Flags are boolean (true/false) values that track:
- Story progression
- Quest completion
- Unlocked content
- Game state conditions
- DLC activation
- Area accessibility
- NPC interactions
- Event triggers

### Flag States:
- **Set (true)**: Condition is met, event completed, content unlocked
- **Unset (false)**: Condition not met, event pending, content locked

---

## Step 2: Flag CSV Structure

**CSV Structure**: 10 columns (0-9)

**Header**:
```
string2 0,int32 1,int32 2,int32 3,string2 4,int32 5,int32 6,string2 7,string2 8,int32 9
```

### Column Meanings:

| Column | Type | Name | Description |
|--------|------|------|-------------|
| 0 | string2 | Flag Name | Unique flag identifier (descriptive name) |
| 1 | int32 | Flag ID | Unique numeric ID (1000-30000) |
| 2 | int32 | Chapter | Chapter/phase number (-1 if not chapter-specific) |
| 3 | int32 | Progress | Story progress number (0-200+) |
| 4 | string2 | Type Code | Flag type: "e"=event, "d"=dungeon, "t"=town/field |
| 5 | int32 | Area ID | Location/dungeon ID where flag is relevant |
| 6 | int32 | Reserved | Usually 0 |
| 7 | string2 | Start Point | Spawn/start point reference |
| 8 | string2 | Event Ref | Event/scenario file reference |
| 9 | int32 | Priority | Priority/weight value (1-3) |

---

## Step 3: Flag Naming Conventions

### System Flags (1000-1099):
```csv
"FLAG_IS_TIME_AXIS_PAST",1004,-1,0,"",0,0,"","FirstPresent",1
"FLAG_IS_TIME_AXIS_PRESENT",1005,-1,0,"",0,0,"","FirstPresent",1
"FLAG_IS_GAME_CLEAR",1060,-1,0,"",0,0,"","FirstPresent",1
```
**Purpose**: Core game mechanics, time travel, completion state

### Main Quest Flags (1100-5000):
```csv
"FLAG_MAIN_01_010",1110,10,10,"e",1,0,"start_00","X2028_daft_10",1
"FLAG_MAIN_01_020",1120,10,10,"e",1,0,"start_00","X2028_daft_10",1
"FLAG_MAIN_02_010",1400,30,10,"d",801,0,"start_20","A2020_dbef_30",1
```
**Pattern**: `FLAG_MAIN_[Chapter]_[Step]`
**Purpose**: Main story progression

### Sub Quest Flags (6000-27000):
```csv
"FLAG_SUB_S050_038_001",6226,-1,0,"",0,0,"","FirstPresent",1
"FLAG_SUB_900_172_001",27160,-1,0,"",0,0,"","FirstPresent",1
```
**Pattern**: `FLAG_SUB_[QuestGroup]_[QuestID]_[Step]`
**Purpose**: Side quest tracking

### DLC Flags (27500-30000):
```csv
"FLAG_DLC06_IS_INDICATIONS",27500,-1,0,"",0,0,"","FirstPresent",1
"FLAG_DLC17_IS_INDICATIONS",27501,-1,0,"",0,0,"","FirstPresent",1
"FLAG_DLC_PATCH001_IS_INDICATIONS",28000,3000,0,"t",3001,0,"start_00","P2028_daft_440",1
"FLAG_DLC_DLC001_IS_INDICATIONS",29000,3100,0,"t",3001,0,"start_00","P2028_daft_440",1
```
**Pattern**: `FLAG_DLC[##]_IS_INDICATIONS` or `FLAG_DLC_DLC[###]_IS_INDICATIONS`
**Purpose**: DLC activation and content availability

### State Flags:
```csv
"FLAG_IS_SWIM",1012,-1,0,"",0,0,"","FirstPresent",1
"FLAG_IS_FLIGHT_RIDE",1020,-1,0,"",0,0,"","FirstPresent",1
"FLAG_IS_LETTERBOX",1061,-1,0,"",0,0,"","FirstPresent",1
```
**Pattern**: `FLAG_IS_[STATE]`
**Purpose**: Current player/game state

### Completion Flags:
```csv
"FLAG_IS_GAME_CLEAR",1060,-1,0,"",0,0,"","FirstPresent",1
"FLAG_IS_CLEAR_DLC000_010",28100,-1,0,"t",101,0,"start_00","P2028_daft_440",1
"FLAG_DLC_EP00_IS_CLEAR_DLCEP001",28101,-1,0,"t",101,0,"start_00","FirstPresent",1
```
**Pattern**: `FLAG_IS_CLEAR_[CONTENT]`
**Purpose**: Completion tracking

### Player Selection Flags:
```csv
"SELECT_MALE",1101,10,10,"e",1,0,"start_00","X2028_daft_0",1
"SELECT_FEMALE",1102,10,10,"e",1,0,"start_00","X2028_daft_0",1
```
**Purpose**: Character selection and customization

---

## Step 4: Type Codes (Column 4)

### Type Code Values:

| Code | Name | Description |
|------|------|-------------|
| **e** | Event | Story events, cutscenes, triggers |
| **d** | Dungeon | Dungeon/battle area flags |
| **t** | Town/Field | Town, field, exploration flags |
| **""** | System | System/global flags (no specific location) |

**Examples**:
```csv
"FLAG_MAIN_01_010",1110,10,10,"e",1,0,"start_00","X2028_daft_10",1  # Event
"FLAG_MAIN_02_010",1400,30,10,"d",801,0,"start_20","A2020_dbef_30",1 # Dungeon
"FLAG_DLC_EP00_001",28001,-1,0,"t",101,0,"start_00","FirstPresent",1 # Town/Field
"FLAG_IS_GAME_CLEAR",1060,-1,0,"",0,0,"","FirstPresent",1            # System
```

---

## Step 5: Chapter & Progress System

### Chapter Values (Column 2):
- **-1**: Not chapter-specific (global flags)
- **10**: Chapter 1
- **20**: Chapter 2
- **30**: Chapter 3
- **40**: Chapter 4
- **50**: Chapter 5
- **3000-3400**: DLC chapters

### Progress Values (Column 3):
- **0**: Chapter start
- **10-200**: Story progress points within chapter
- **-1**: Not progress-specific

**Example Progression**:
```csv
"FLAG_MAIN_01_010",1110,10,10,"e",1,0,"start_00","X2028_daft_10",1    # Chapter 1, Progress 10
"FLAG_MAIN_01_020",1120,10,10,"e",1,0,"start_00","X2028_daft_10",1    # Chapter 1, Progress 10
"FLAG_MAIN_01_030",1130,10,40,"t",108,0,"start_00","X2028_daft_10",1  # Chapter 1, Progress 40
"FLAG_MAIN_02_010",1400,30,10,"d",801,0,"start_20","A2020_dbef_30",1  # Chapter 3, Progress 10
```

---

## Step 6: ID Ranges

### Flag ID Assignment:

| Range | Category | Description |
|-------|----------|-------------|
| **1000-1099** | System Flags | Core game mechanics |
| **1100-5999** | Main Story | Main quest progression |
| **6000-27499** | Sub Quests | Side quests and optional content |
| **27500-27999** | DLC Indicators | DLC detection flags |
| **28000-29999** | DLC Content | DLC-specific flags |
| **30000+** | Reserved | Future expansion |

### Safe Custom Flag IDs:
- **30000-39999**: Safe for custom flags (won't conflict)

---

## Step 7: Creating Custom Flags

### Example: Adding a Custom Quest Flag

**Goal**: Create a custom side quest with 3 steps

**Step 1**: Add flag entries:
```csv
"FLAG_CUSTOM_QUEST_001_START",35000,-1,0,"t",101,0,"start_00","CustomQuest",1
"FLAG_CUSTOM_QUEST_001_STEP1",35001,-1,0,"t",101,0,"start_00","CustomQuest",1
"FLAG_CUSTOM_QUEST_001_STEP2",35002,-1,0,"t",101,0,"start_00","CustomQuest",1
"FLAG_CUSTOM_QUEST_001_COMPLETE",35003,-1,0,"t",101,0,"start_00","CustomQuest",1
```

**Step 2**: Reference flags in quest data files

**Step 3**: Set/check flags via event scripts or quest conditions

---

## Step 8: DLC Flag System

### DLC Detection Flags:
```csv
"FLAG_DLC06_IS_INDICATIONS",27500,-1,0,"",0,0,"","FirstPresent",1
"FLAG_DLC17_IS_INDICATIONS",27501,-1,0,"",0,0,"","FirstPresent",1
```
**Purpose**: Detect if specific DLC is installed/active

### DLC Patch Flags:
```csv
"FLAG_DLC_PATCH001_IS_INDICATIONS",28000,3000,0,"t",3001,0,"start_00","P2028_daft_440",1
"FLAG_DLC_PATCH002_IS_INDICATIONS",28200,3010,0,"t",3001,0,"start_00","P2028_daft_440",1
"FLAG_DLC_PATCH003_IS_INDICATIONS",28300,3020,0,"t",3001,0,"start_00","P2028_daft_440",1
```
**Purpose**: Track patch version for DLC compatibility

### DLC Episode Flags:
```csv
"FLAG_DLC_DLC001_IS_INDICATIONS",29000,3100,0,"t",3001,0,"start_00","P2028_daft_440",1
"FLAG_DLC_EP01_001",29001,3100,0,"t",3001,0,"start_00","P2028_daft_440",1
"FLAG_DLC_DLC002_IS_INDICATIONS",29300,3200,0,"t",3001,0,"start_00","P2028_daft_440",1
"FLAG_DLC_EP02_001",29301,3200,0,"t",3001,0,"start_00","P2028_daft_440",1
```
**Purpose**: Track DLC episode progression

### DLC Costume Flags:
```csv
"FLAG_DLC_COS_010",29900,-1,0,"t",101,0,"start_00","FirstPresent",1
"FLAG_DLC_COS_020",29901,-1,0,"t",101,0,"start_00","FirstPresent",1
```
**Purpose**: Unlock costume packs

---

## Step 9: Area ID Reference (Column 5)

### Common Area IDs:
- **0**: No specific area / global
- **1**: Starting area / tutorial
- **101**: Town/hub area
- **801-1500**: Various dungeons
- **3001**: DLC lobby area

**Note**: Area IDs correspond to map IDs defined in field data files.

---

## Step 10: Event Reference (Column 8)

### Event Naming Patterns:

**FirstPresent**:
- Used for global/persistent flags
- Example: `"FLAG_IS_GAME_CLEAR",1060,-1,0,"",0,0,"","FirstPresent",1`

**Chapter Events**:
- Format: `[Prefix]####_[suffix]_##`
- Example: `"X2028_daft_10"`, `"A2020_dbef_30"`, `"P2028_daft_440"`

**Prefixes**:
- **X####**: Chapter X events
- **A####**: Area A events
- **P####**: Patch/DLC events

---

## Step 11: Placeholder Flags

### "define" Flags:
```csv
"define1007",1007,-1,0,"",0,0,"","FirstPresent",1
"define1017",1017,-1,0,"",0,0,"","FirstPresent",1
"define1029",1029,-1,0,"",0,0,"","FirstPresent",1
```
**Purpose**: Reserved/undefined flag slots for future use

**Use Case**: Safe to repurpose for custom flags

---

## Step 12: Flag Usage in Other Files

### Flags are referenced in:

1. **Quest Files** (`quest_main.mbe`, `quest_sub.mbe`)
   - Check flags for quest availability
   - Set flags on quest completion

2. **NPC Files** (`field_npc_*.mbe`)
   - Control NPC visibility
   - Trigger NPC dialogue

3. **Event Scripts**
   - Control event flow
   - Branch story paths

4. **DLC Info** (`dlc_info.mbe`)
   - Detect DLC installation
   - Enable DLC content

5. **Shop Data** (`shop.mbe`)
   - Unlock shop items
   - Control shop availability

6. **Evolution Data** (`evolution.mbe`)
   - Unlock evolution paths
   - Special evolution conditions

---

## Step 13: Debugging Flags

### Testing Custom Content:

**Method 1**: Set flag via save editor
- Edit save file to set custom flag = true

**Method 2**: Add test flag
```csv
"FLAG_DEBUG_CUSTOM_UNLOCK",39000,-1,0,"",0,0,"","FirstPresent",1
```
- Use debug flag to bypass conditions

**Method 3**: Chain flags
```csv
"FLAG_CUSTOM_PREREQ",35000,-1,0,"t",101,0,"start_00","Custom",1
"FLAG_CUSTOM_UNLOCK",35001,-1,0,"t",101,0,"start_00","Custom",1
```
- Create dependency chains for testing

---

## Step 14: Common Flag Patterns

### Quest Pattern:
```csv
"FLAG_SUB_[QuestID]_START",ID,-1,0,"t",AREA,0,"start_00","FirstPresent",1
"FLAG_SUB_[QuestID]_001",ID+1,-1,0,"t",AREA,0,"start_00","FirstPresent",1
"FLAG_SUB_[QuestID]_002",ID+2,-1,0,"t",AREA,0,"start_00","FirstPresent",1
"FLAG_SUB_[QuestID]_COMPLETE",ID+3,-1,0,"t",AREA,0,"start_00","FirstPresent",1
```

### Unlock Pattern:
```csv
"FLAG_UNLOCK_[FEATURE]",ID,-1,0,"",0,0,"","FirstPresent",1
```

### DLC Pattern:
```csv
"FLAG_DLC##_IS_INDICATIONS",27500+##,-1,0,"",0,0,"","FirstPresent",1
```

---

## Step 15: Testing Checklist

### Test New Flags:

1. ✅ Flag name is unique
2. ✅ Flag ID doesn't conflict with existing IDs
3. ✅ Flag is referenced correctly in other files
4. ✅ Flag triggers at correct time/condition
5. ✅ Flag persists through save/load
6. ✅ Flag doesn't break existing progression
7. ✅ Flag works in both time periods (if applicable)
8. ✅ Flag integrates with chapter system (if chapter-specific)

---

## Tips & Warnings

1. **Never reuse existing flag IDs** - Always use new IDs in safe range
2. **Use descriptive names** - Follow existing naming conventions
3. **Document custom flags** - Keep a list of your custom flag purposes
4. **Test flag persistence** - Ensure flags save/load correctly
5. **Check flag dependencies** - Some flags depend on other flags
6. **Be careful with system flags** - Modifying 1000-1099 can break core mechanics
7. **DLC flags are special** - Follow exact DLC flag patterns
8. **Chapter flags matter** - Incorrect chapter values can break progression

---

## Advanced: Flag Conditions

### Common Flag Checks:
- **If flag set**: Proceed with event/unlock
- **If flag not set**: Block access/hide content
- **If multiple flags set**: Complex condition (AND)
- **If any flag set**: Alternative condition (OR)

### Example Condition Chain:
```
Quest Start requires:
- FLAG_MAIN_05_100 = true (Chapter 5 complete)
- FLAG_MAIN_06_010 = false (Chapter 6 not started)
- FLAG_SUB_050_100_COMPLETE = true (Specific side quest done)
```

---

## Quick Reference: Adding a Custom Flag

**Template**:
```csv
"FLAG_[CATEGORY]_[NAME]",35000,-1,0,"[TYPE]",[AREA],0,"start_00","[EVENT]",1
```

**Example - Custom Quest**:
```csv
"FLAG_CUSTOM_MYQUEST_START",35000,-1,0,"t",101,0,"start_00","CustomContent",1
```

**Steps**:
1. Choose unique ID (30000-39999)
2. Follow naming convention
3. Set chapter (-1 for global)
4. Set type code (e/d/t)
5. Set area ID (if relevant)
6. Add to `000_Flag_List.csv`
7. Reference in quest/event files
8. Test thoroughly

---

## Flag Categories Summary

| Prefix | Range | Purpose |
|--------|-------|---------|
| FLAG_IS_ | 1000-1099 | State/condition flags |
| FLAG_MAIN_ | 1100-5999 | Main story flags |
| FLAG_SUB_ | 6000-27499 | Side quest flags |
| FLAG_DLC | 27500-30000 | DLC related flags |
| FLAG_CUSTOM_ | 30000+ | Custom/mod flags |
| SELECT_ | 1101-1150 | Player selection flags |
| define | Any | Placeholder flags |

---

**End of Guide**

## Additional Resources

- See quest files for flag usage examples
- Check NPC files for visibility conditions
- Review DLC integration for flag patterns
- Consult event scripts for flag setting/checking

**Total Flags in Base Game**: ~5,000  
**Safe Custom Range**: 30,000-39,999  
**DLC Range**: 27,500-30,000

