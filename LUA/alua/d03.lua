function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  Field.LoadPlayerScriptDigimonRideDigimon(145)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_199") then
    local start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_04" then
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
    end
  end
  MapNameDisp()
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
end

function OnEndLoad()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  SaveSequenceAfterChapterChange()
  if Flg.Check("FLAG_MAIN_05_097", "FLAG_MAIN_05_098") then
  else
    PlayDungeonBGM()
  end
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    local start_loc = GetLastPlayerSetLocator()
    MovePlayerToStartPosition(start_loc)
  else
    StartEventBeforeFadeIn()
    if Field.IsJustAfterMapChangeNow() == true then
      local start_loc = GetLastPlayerSetLocator()
      ProcessIfNeedByStartLocator(start_loc)
    end
    if Flg.Check("FLAG_ISAREA_CHANGE_FOR_LOCOMON") then
      Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
    end
    FadeInWithWait(0, 0)
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if start_loc == "start_50" then
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if gMapNum == 301 then
    if start_loc == "start_00" then
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Flg.Set("FLAG_IS_SWIM")
    elseif start_loc == "start_10" then
      if Flg.Check("FLAG_MAIN_09_033", "FLAG_MAIN_09_037") then
        Flg.Set("FLAG_MAIN_09_037")
        local pc = Obj:new(PLAYER, "")
        local how = Obj:new(NPC, "hoe_01")
        local y_degree = GetAngleToTarget2D(pc.pos.x, pc.pos.z, how.pos.x, how.pos.z)
        SetFollowerCameraOperateRotation(0, y_degree)
      end
    elseif start_loc == "start_05" then
      M260:Event_040()
    elseif start_loc == "start_30" then
      SetFollowerCameraOperateRotation(0, 90)
    end
  elseif gMapNum == 302 then
    if not (start_loc == "start_03" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_LOCOMON")) or Flg.Check("FLAG_MAIN_05_060", "FLAG_MAIN_05_070") then
    else
      PlayStopLocomonSound()
    end
    if start_loc == "start_20" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") then
      PlayStopBlimpSound()
      AddChallengerNotice(false)
    end
  elseif gMapNum == 303 then
  elseif gMapNum == 308 then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 301 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if Flg.Check("FLAG_IS_SWIM") then
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      SetProhibitPlayerOnlyOperate(true)
    end
    if Flg.Check("FLAG_FIELD_D03_IS_WARP") and start_loc == "start_30" then
      SetFollowerCameraOperateRotation(0, 90)
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D03_IS_WARP")
    end
    M170:Event_060()
    M170:Event_102()
    M170:Event_105()
    M170:Event_225()
    M260:Event_120()
    local start_loc = Field.GetLastPlayerSetLocator()
    if start_loc == "start_21" then
      require("S020_018")
      S020_018:Event_080()
    end
    require("S200_150")
    S200_150:Event_020()
    S200_150:Event_030()
    S200_150:Event_040()
    S200_150:Event_050()
    if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_199") and start_loc == "start_04" then
      require("S110_091")
      S110_091:Event_020()
    end
    require("S110_091")
    S110_091:Event_030()
  end
  if gMapNum == 302 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if Flg.Check("FLAG_FIELD_D03_IS_WARP") and start_loc == "start_40" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D03_IS_WARP")
    end
    if Flg.Check("FLAG_FIELD_D03_IS_WARP") and start_loc == "start_41" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D03_IS_WARP")
    end
    M170:Event_020()
    M170:Event_073()
    M260:Event_030()
    M260:Event_130()
    M280:Event_010()
    M280:Event_115()
    M285:Event_010()
    M285:Event_015()
    if Flg.Check("FLAG_IS_SWIM") then
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      SetProhibitPlayerOnlyOperate(true)
    end
    require("S020_012")
    S020_012:Event_090()
    require("S110_108")
    S110_108:Event_040()
    S110_108:Event_030()
    require("S200_150")
    S200_150:Event_060()
    require("S020_172")
    S020_172:Event_050()
  end
  if gMapNum == 303 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if Flg.Check("FLAG_FIELD_D03_IS_WARP") and start_loc == "start_00" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D03_IS_WARP")
    end
    if (Flg.Check("FLAG_FIELD_D0303_010") or Flg.Check("FLAG_FIELD_D0303_020") or Flg.Check("FLAG_FIELD_D0303_030") or Flg.Check("FLAG_FIELD_D0303_040") or Flg.Check("FLAG_FIELD_D0303_050") or Flg.Check("FLAG_FIELD_D0303_060") or Flg.Check("FLAG_FIELD_D0303_070") or Flg.Check("FLAG_FIELD_D0303_080") or Flg.Check("FLAG_FIELD_D0303_090") or Flg.Check("FLAG_FIELD_D0303_100")) and Flg.Check("FLAG_FIELD_D0303_110") then
      Field.PlayerScriptDigimonRideStartFromID(145, false, "", 0)
    end
    M170:Event_120()
    M170:Event_167()
    M170:Event_170()
    M170:Event_220()
    M170:Event_255()
    require("S020_012")
    S020_012:Event_060()
    S020_012:Event_080()
    require("S020_015")
    S020_015:Event_040()
  elseif gMapNum == 304 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if Flg.Check("FLAG_FIELD_D03_IS_WARP") and start_loc == "start_10" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D03_IS_WARP")
    end
    M260:Event_080()
    if start_loc == "start_60" then
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
    end
    if Flg.Check("FLAG_IS_CLEAR_S020_019") then
      ColOff("wall_cl_0006")
    end
  elseif gMapNum == 305 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if Flg.Check("FLAG_FIELD_D03_IS_WARP") and GetLastPlayerSetLocator() == "start_30" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D03_IS_WARP")
    end
    M260:Event_110()
    M280:Event_118()
    M280:Event_130()
    require("S110_102")
    S110_102:Event_040()
    S110_102:Event_020()
    require("S020_172")
    S020_172:Event_040()
    S020_172:Event_030()
    require("S020_013")
    S020_013:Event_030()
  elseif gMapNum == 306 then
    M150:Event_037()
    M260:Event_020()
    M280:Event_080()
    M280:Event_100()
    M285:Event_030()
  elseif gMapNum == 308 then
    M170:Event_071()
    M170:Event_100()
    M170:Event_230()
    M260:Event_060()
    M260:Event_100()
    require("S110_108")
    S110_108:Event_020()
    local start_loc = Field.GetLastPlayerSetLocator()
    if start_loc == "start_20" then
      require("S020_018")
      S020_018:Event_020()
    end
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 301 then
  end
  if gMapNum == 302 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if start_loc == "start_30" then
      M170:Event_080()
    end
    if start_loc == "start_20" then
      M260:Event_035()
    end
  end
  if gMapNum == 308 then
  end
  if gMapNum == 304 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if Flg.Check("FLAG_MAIN_10_001") then
    else
      M260:Event_092()
      if Flg.Check("FLAG_MAIN_09_035") and not Flg.Check("FLAG_FIELD_D0304_SubMarineJoin") then
        local loc = Field.GetLastPlayerSetLocator()
        if loc == "start_20" then
          local tlk = Tlk:new("d03", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d0304_0040_0090")
          tlk:Message("f_d0304_0040_0100")
          tlk:EndTalk()
          Guest.Add(GST_SUBMARINE2)
          Flg.Set("FLAG_FIELD_D0304_SubMarineJoin")
          BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
          INFO_WINDOW(7031)
          FieldObjectSync(FOR_ALL, true)
          WaitFrame(30)
          FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        end
      end
    end
  end
end

function UpdateMinimap(start_loc)
  if gMapNum == 301 then
    if start_loc == "start_04" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_06" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_09" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  elseif gMapNum == 302 and start_loc == "start_71" then
    MiniMapChange(MAP_LAYER_MIDDLE)
  end
end
