function FieldLoadRequest()
  print("##### FieldLoadRequest #####")
  
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  MapNameDisp()
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
end

function OnEndLoad()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  SaveSequenceAfterChapterChange()
  PlayDungeonBGM()
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
    FadeInWithWait(0, 0)
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if start_loc == "start_50" then
    if Flg.Check("FLAG_MAIN_14_040", "FLAG_MAIN_14_045") then
      Flg.Set("FLAG_MAIN_14_045")
    else
      InitializeTheaterDoorEvt()
    end
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
    if gMapNum == 701 and start_loc == "start_02" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") then
      PlayStopBlimpSound()
      AddChallengerNotice(false)
    end
    if gMapNum == 702 then
    elseif gMapNum ~= 703 or start_loc == "start_00" then
    elseif start_loc == "start_01" then
    end
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 701 then
    if Flg.Check("FLAG_FIELD_D07_010") and GetLastPlayerSetLocator() == "start_02" then
      Prcs_d07_GekoWarpMapChange(701, "ride_landing_08")
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D07_010")
    end
    if Flg.Check("FLAG_FIELD_D07_020") and GetLastPlayerSetLocator() == "start_10" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D07_020")
    end
    M360:Event_011()
    M360:Event_045()
    M360:Event_047()
    require("S020_016")
    S020_016:Event_030()
    require("S110_092")
    S110_092:Event_070()
    require("S110_093")
    S110_093:Event_060()
    local start_loc = GetLastPlayerSetLocator()
    require("S110_093")
    if start_loc == "start_30" then
      S110_093:Event_050()
    end
  end
  if gMapNum == 702 then
    if Flg.Check("FLAG_FIELD_D07_020") and GetLastPlayerSetLocator() == "start_30" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D07_020")
    end
    if Flg.Check("FLAG_MAIN_14_011", "FLAG_MAIN_14_020") and Common.CheckTimeAxis("A2028_daft_360") then
      Field.ObjectSetPos(FLD_OBJ_NPC, GetIndex(NPC, "npc_warp01"), -9.951, -0.142, 14.568)
      WaitFrame(1)
      Field.ObjectSetRotationY(FLD_OBJ_NPC, GetIndex(NPC, "npc_warp01"), 150, 0)
      WaitFrame(1)
    end
    M360:Event_030()
  end
  if gMapNum == 703 then
    if Flg.Check("FLAG_FIELD_D07_010") and GetLastPlayerSetLocator() == "start_00" then
      if Flg.Check("FLAG_MAIN_14_012", "FLAG_MAIN_14_013") then
        M360:Event_016()
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      else
        Prcs_d07_GekoWarpMapChange(703, "ride_landing_12")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      end
      Flg.Clear("FLAG_FIELD_D07_010")
    end
    require("S020_014")
    S020_014:Event_040()
    require("S020_016")
    S020_016:Event_050()
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 701 then
  end
end
