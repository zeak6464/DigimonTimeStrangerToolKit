function OnTriggerMapChange(col)
  local col_name = col.name
  
  local fade_type, fade_frame = 0, 20
  first_name, col_name = _SingleSplit(col_name)
  if first_name ~= "col" then
    return
  end
  local base_staging_name = col_name
  first_name, col_name = _SingleSplit(col_name)
  if not first_name then
    return
  end
  local prefix = string.sub(first_name, 1, 1)
  local map_num = tonumber(string.sub(first_name, 2))
  if not map_num then
    return
  end
  local locator, dust = _SingleLSplit(col_name)
  if not locator then
    return
  end
  ProcessIfNeedByLink(col.name)
  Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
  local use_loc, move_speed, move_frame, move_degree, isTarget = GetStagingLocator(base_staging_name)
  fade_frame = move_frame
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToNextArea(base_staging_name)
  end
  if col.name == "col_d0101_start_01_0" then
    fade_type = 0
    fade_frame = 20
  end
  prefix = PREFIX or prefix
  map_num = MAP_NUM or map_num
  locator = LOCATOR or locator
  PREFIX, MAP_NUM, LOCATOR = nil, nil, nil
  if NEXT_TIME ~= nil and NEXT_TIME_QST ~= nil then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Common.RequestMapChangeWithTimeTravelFromRecord(prefix, map_num, locator, NEXT_TIME, NEXT_TIME_QST)
  end
  if TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE == nil then
    MapChange(prefix, map_num, locator, true, fade_type, fade_frame)
  elseif TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE ~= nil then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    MapChangeWithTimePasses(prefix, map_num, locator, TIME_ZONE)
  else
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    MapChangeWithTimeTravel(prefix, map_num, locator, TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
  end
end

function ProcessIfNeedByLink(col_name)
  if col_name == "col_t0401_start_10_0" and Flg.Check("FLAG_MAIN_08_007", "FLAG_MAIN_08_010") then
    Field.MovePlayerToRelativePosFrame(0, 5, 60)
    M230:Event_040()
  end
  if col_name == "col_t0104_start_04_0" then
    M200:Event_025()
  end
  if (col_name == "col_d0202_start_05_0" or col_name == "col_d0202_start_00_0") and Flg.Check("FLAG_MAIN_03_715", "FLAG_MAIN_03_717") then
    Flg.Set("FLAG_MAIN_03_717")
  end
  if col_name == "col_d0205_start_02_0" then
    SetControlScriptExternalVariable("area_change_event", "start")
    SetProhibitDigimonRide(true)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    WaitFrame(90)
  end
  if col_name == "col_d0205_start_01_0" and Qst.Sub:Check(41, 10, 255) then
    require("s050_041")
    S050_041:Event_027()
  end
  if col_name == "col_d0305_start_00_0" then
    if Flg.Check("FLAG_MAIN_10_001") then
    else
      M260:Event_085()
      Flg.Clear("FLAG_FIELD_D0304_SubMarineJoin")
    end
  elseif col_name == "col_d0303_start_01_0" then
  end
  if col_name == "col_d0403_start_01_0" then
    if Flg.Check("FLAG_MAIN_10_060", "FLAG_MAIN_10_070") then
      TIME_AXIS = AXIS_ORIGINAL
      TIME_AXIS_SET = "A2028_daft_310"
      TIME_ZONE = NOON
    end
  elseif col_name == "col_d0405_start_00_0" then
    if Flg.Check("FLAG_MAIN_10_060", "FLAG_MAIN_10_070") then
      TIME_AXIS = AXIS_ORIGINAL
      TIME_AXIS_SET = "A2028_daft_310"
      TIME_ZONE = NOON
    end
  elseif col_name == "col_d0407_start_00_0" and Flg.Check("FLAG_MAIN_10_060", "FLAG_MAIN_10_070") then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2028_daft_310"
    TIME_ZONE = NOON
  end
  if col_name == "col_d0501_start_03_0" and not Flg.Check("FLAG_GIMMICK_D05_010") then
    Flg.Set("FLAG_GIMMICK_D05_010")
  end
  if col_name == "col_d0602_start_00_0" and Flg.Check("FLAG_MAIN_19_010", "FLAG_MAIN_19_065") then
    PREFIX = "d"
    MAP_NUM = 602
    LOCATOR = "start_20"
  end
  if col_name == "col_d0607_start_01_0" and Flg.Check("FLAG_MAIN_07_015", "FLAG_MAIN_07_030") then
    PREFIX = "d"
    MAP_NUM = 608
    LOCATOR = "start_00"
  end
  if col_name ~= "col_d0608_start_01_0" or Flg.Check("FLAG_MAIN_20_010", "FLAG_MAIN_20_020") then
  elseif Flg.Check("FLAG_MAIN_22_428", "FLAG_MAIN_22_445") then
    if CheckTimeAxis("P2028_daft_444") then
      PREFIX = "d"
      MAP_NUM = 905
      LOCATOR = "start_00"
      TIME_AXIS = AXIS_ORIGINAL
      TIME_AXIS_SET = "P2028_daft_445"
      TIME_ZONE = NOON
    end
  elseif Flg.Check("FLAG_MAIN_22_010") then
    if Flg.Check("FLAG_FIELD_TO_D1204") then
      PREFIX = "d"
      MAP_NUM = 1204
      LOCATOR = "start_23"
      Flg.Clear("FLAG_FIELD_TO_D1204")
    elseif Flg.Check("FLAG_FIELD_TO_d0900") then
      PREFIX = "d"
      MAP_NUM = 900
      LOCATOR = "start_00"
      Flg.Clear("FLAG_FIELD_TO_d0900")
    end
  end
  if col_name == "col_d1002_start_00_0" and Flg.Check("FLAG_MAIN_01_110", "FLAG_MAIN_01_160") then
    NEXT_TIME = Common.GetCurrentTimeTravelRecordType()
    NEXT_TIME_QST = Common.GetCurrentTimeTravelQuestRecordIndex()
    print("next time: ", NEXT_TIME)
    print("next time qst: ", NEXT_TIME_QST)
  end
  if col_name == "col_d1205_start_00_0" and Flg.Check("FLAG_MAIN_08_035", "FLAG_MAIN_08_040") then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2028_daft_240"
    TIME_ZONE = NOON
  end
  if col_name == "col_d1204_start_01_0" and Flg.Check("FLAG_MAIN_10_000") and not Qst.Main:IsCompleted(M290.ID) then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2028_daft_290"
    TIME_ZONE = NOON
  end
  if col_name == "col_d1407_start_00_0" and Flg.Check("FLAG_MAIN_01_240", "FLAG_MAIN_01_250") then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "X2028_daft_23"
    TIME_ZONE = NIGHT
  end
  if col_name == "col_t0105_start_03_0" then
    Flg.Set("FLAG_t0105_InLine")
    Flg.Clear("FLAG_t0105_InPlatform")
  end
  if col_name == "col_t0105_start_04_0" then
    Flg.Clear("FLAG_t0105_InLine")
    Flg.Set("FLAG_t0105_InPlatform")
  end
  if col_name == "col_t0109_start_02_0" or col_name == "col_t0401_start_06_0" then
    fade_frame = 0
  end
  if col_name == "col_t0103_start_00_0" then
    M210:Event_017()
  end
  if col_name == "col_t0111_start_01_0" and Flg.Check("FLAG_SUB_110_100_008", "FLAG_SUB_110_100_009") then
    Flg.Set("FLAG_SUB_110_100_009")
  end
  if col_name == "col_t0105_start_00_0" and Flg.Check("FLAG_SUB_110_100_008", "FLAG_SUB_110_100_009") then
    Flg.Set("FLAG_SUB_110_100_009")
  end
  if col_name == "col_t0105_start_01_0" and Flg.Check("FLAG_SUB_110_100_008", "FLAG_SUB_110_100_009") then
    Flg.Set("FLAG_SUB_110_100_009")
  end
  if col_name == "col_t0102_start_03_0" and Flg.Check("FLAG_SUB_110_100_008", "FLAG_SUB_110_100_009") then
    Flg.Set("FLAG_SUB_110_100_009")
  end
  if col_name == "col_t0102_start_04_0" and Flg.Check("FLAG_SUB_110_100_008", "FLAG_SUB_110_100_009") then
    Flg.Set("FLAG_SUB_110_100_009")
  end
  if col_name == "col_t108_start_01_0" and Flg.Check("FLAG_SUB_110_100_008", "FLAG_SUB_110_100_009") then
    Flg.Set("FLAG_SUB_110_100_009")
  end
  if col_name == "col_t0101_start_03_0" and Flg.Check("FLAG_SUB_110_100_008", "FLAG_SUB_110_100_009") then
    Flg.Set("FLAG_SUB_110_100_009")
  end
  if col_name == "col_t0104_start_05_0" and Flg.Check("FLAG_MAIN_07_053", "FLAG_MAIN_07_054B") then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_210"
    TIME_ZONE = NOON
  end
  if col_name == "col_t0301_start_02_0" and Flg.Check("FLAG_MAIN_07_068", "FLAG_MAIN_07_069") then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_210"
    TIME_ZONE = EVENING
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
  end
end

function _SingleSplit(str)
  print("##### _SingleSplit #####")
  local delimiter = "_"
  local index = string.find(str, delimiter, 0, true)
  if index then
    local first = string.sub(str, 1, index - 1)
    local second = string.sub(str, index + 1)
    print("##### first = ", first, " ##### second = ", second, "#####")
    return first, second
  end
  return nil, nil
end

function _SingleLSplit(str)
  print("##### _SingleLSplit #####")
  local delimiter = "_"
  local rev_str = string.reverse(str)
  local index = string.find(rev_str, delimiter, 0, true)
  if index then
    local second = string.reverse(string.sub(rev_str, 1, index - 1))
    local first = string.reverse(string.sub(rev_str, index + 1))
    print("##### first = ", first, " ##### second = ", second, "#####")
    return first, second
  end
  return nil, nil
end

function MovePlayerToStartPosition(base_locator_name)
  print("##### MovePlayerToStartPosition #####")
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  local use_loc, move_speed, move_frame, move_degree, isTarget = GetStagingLocator(base_locator_name)
  if use_loc ~= base_locator_name then
    if isTarget == false then
      FadeIn(move_frame)
      MovePlayerFrame(move_degree, move_speed, move_frame)
      WaitFrame(move_frame)
    else
      FadeIn(move_frame)
      MovePlayerToLocatorFrame(use_loc, move_frame)
    end
  else
    FadeIn(30)
  end
  Field_CancelInvisibleFollowerAllPartyMember(0, 60, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 60, false, true)
  Flg.Set("FLAG_NOT_USE_FIELD_FADE")
end

function MovePlayerToNextArea(base_locator_name)
  print("##### MovePlayerToNextArea #####")
  local use_loc, move_speed, move_frame, move_degree, isTarget = GetStagingLocator(base_locator_name)
  if use_loc ~= base_locator_name then
    if isTarget == false then
      MovePlayerFrame(move_degree, move_speed, move_frame)
    else
      Field.MovePlayerToLocatorFrame(use_loc, move_frame)
    end
  end
end

function GetStagingLocator(base_locator_name)
  print("##### gLocator #####")
  local move_speed, move_frame, move_degree = 0, 0, 0
  local use_loc, sp_loc_name = base_locator_name, ""
  local base_name = base_locator_name
  local sp_prefix = AREACHANGE_MOVE_SETTING
  local isTarget = false
  for key in pairs(sp_prefix) do
    sp_loc_name = sp_prefix[key].type .. base_name
    if Field.CheckLocatorExist(sp_loc_name) then
      use_loc = sp_loc_name
      move_frame = sp_prefix[key].frame
      move_degree = Field.GetLocatorRotationYDegree(sp_loc_name)
      if sp_prefix[key].type == "run_" or sp_prefix[key].type == "longrun_" then
        move_speed = Field.GetPlayerRunVelocity()
      elseif sp_prefix[key].type == "walk_" then
        move_speed = Field.GetPlayerWalkVelocity()
      end
      if sp_prefix[key].type == "target_" then
        isTarget = true
      end
      break
    end
  end
  print("##### use_loc = ", use_loc, " #####")
  return use_loc, move_speed, move_frame, move_degree, isTarget
end

function FadeIn(move_frame)
  if not Flg.Check("FLAG_NOT_USE_FIELD_FADE") then
    if Flg.Check("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER") or Flg.Check("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER") then
      Fade.In(1, Util.SecondFromFrame(move_frame))
      Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
      local MapPrefix, MapNum = Field.GetMapPrefix(), Field.GetMapNumber()
      if MapPrefix == "t" then
        if MapNum == 3001 or MapNum == 3002 or MapNum == 3003 or MapNum == 3004 then
        else
          Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
        end
      else
        Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      end
    else
      Fade.In(0, Util.SecondFromFrame(move_frame))
    end
  else
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
  end
end
