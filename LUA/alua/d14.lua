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
  if gMapNum == 1403 and Flg.Check("FLAG_MAIN_01_230") then
    Sound.PlayBGM(908, 0.3)
  end
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
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if Flg.Check("FLAG_GIMMICK_D14_370") then
    Prcs_d14_GetOutElv_Fade()
  elseif Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
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
  if gMapNum == 1401 then
    M020:Event_120()
    M020:Event_125()
    M390:Event_650()
    M420:Event_030()
  end
  if gMapNum == 1402 then
  end
  if gMapNum == 1403 then
    M020:Event_240()
    M020:Event_285()
  end
  if gMapNum == 1405 then
    M020:Event_330()
  end
  if gMapNum == 1407 then
    Flg.Set("FLAG_GIMMICK_D14_010")
    M020:Event_380()
    M340:Event_070()
    M430:Event_010()
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 1401 then
    local start_loc = GetLastPlayerSetLocator()
  elseif gMapNum == 1402 then
  elseif gMapNum == 1403 then
  elseif gMapNum == 1405 then
  elseif gMapNum == 1407 then
    M020:Event_360()
  end
  M020:Event_145()
end

function UpdateMinimap(start_loc)
  if gMapNum == 1402 then
    if start_loc == "start_00" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if start_loc == "start_01" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
  end
  if gMapNum == 1405 then
    if start_loc == "start_00" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_01" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_02" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  end
end
