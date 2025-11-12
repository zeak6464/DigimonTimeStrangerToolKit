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
  local start_loc = GetLastPlayerSetLocator()
  SaveSequenceAfterChapterChange()
  PlayDungeonBGM()
  UpdateMinimap(start_loc)
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    MovePlayerToStartPosition(start_loc)
  else
    StartEventBeforeFadeIn()
    if Field.IsJustAfterMapChangeNow() == true then
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
    if Flg.Check("FLAG_MAIN_18_015", "FLAG_MAIN_18_016") then
      Flg.Set("FLAG_MAIN_18_016")
    elseif Flg.Check("FLAG_MAIN_13_090", "FLAG_MAIN_13_091") then
      Flg.Set("FLAG_MAIN_13_091")
    else
      InitializeTheaterDoorEvt()
    end
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if gMapNum == 1204 and start_loc == "start_20" then
    Move.PlayerIsDegeGateOut()
    WaitFrame(30)
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
  if gMapNum == 1202 then
    M235:Event_045()
    M235:Event_046()
  end
  if gMapNum == 1204 then
    if Flg.Check("FLAG_D12_D02_IS_WARP") and GetLastPlayerSetLocator() == "start_40" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_D12_D02_IS_WARP")
    end
    M285:Event_050()
    M310:Event_109()
    M350:Event_030()
    M390:Event_010()
    M390:Event_720()
    M400:Event_010()
    M410:Event_260()
    M420:Event_010()
    require("S070_055")
    S070_055:Event_040()
    require("S070_057")
    S070_057:Event_020()
  end
  if gMapNum == 1205 then
    M235:Event_060()
    M240:Event_010()
    M285:Event_060()
    M290:Event_010()
    M330:Event_020()
    M350:Event_040()
    M400:Event_020()
  end
  if gMapNum == 1206 then
    M340:Event_010()
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 1204 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if start_loc == "start_20" then
    end
    M310:Event_038()
  elseif gMapNum == 1206 then
    M235:Event_055()
  end
end

function UpdateMinimap(start_loc)
end
