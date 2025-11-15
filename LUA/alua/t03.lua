function FieldLoadRequest()
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
    InitializeTheaterDoorEvt()
    Field.CameraSwitchChangeByFileName("t0302_railcam_m210", "railcam_col_03_02", false)
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 301 then
    M040:Event_090()
    M200:Event_010()
    M210:Event_300()
    M210:Event_310()
  end
  if gMapNum == 302 then
    M040:Event_010()
    M070:Event_080()
    require("S910_169")
    S910_169:Event_040()
    require("S910_170")
    S910_170:Event_110()
    S910_170:Event_070()
    if Flg.Check("FLAG_SUB_200_147_001") then
      require("S200_147")
      S200_147:Event_020()
    end
    if Flg.Check("FLAG_SUB_200_147_003") then
      require("S200_147")
      S200_147:Event_050()
    end
    require("S200_149")
    S200_149:Event_060()
    S200_149:Event_040()
  end
  if gMapNum == 303 then
    if Flg.Check("FLAG_MAIN_03_181") and not Flg.Check("FLAG_MAIN_03_182") then
      Party.Aegiomon.SetExist(false)
    end
    M070:Event_085()
    M080:Event_120()
    M100:Event_040()
    if not Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
      require("S010_003")
      S010_003:Event_030()
    end
  end
  if gMapNum == 304 then
    M340:Event_050()
  end
  if gMapNum == 308 then
  end
  if gMapNum == 381 then
    M210:Event_320()
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 301 then
  elseif gMapNum == 302 then
    if not Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
      require("S010_003")
      S010_003:Event_080()
    end
  elseif gMapNum == 303 and not Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
    require("S010_003")
    S010_003:Event_070()
  end
end

function UpdateMinimap(start_loc)
end
