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
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    if map_num == 203 and start_loc == "start_09" then
      SetFollowerCameraOperateRotation(10, 35)
    end
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 201 then
    Obj:new(NPC, "s900_162_002"):Invisible()
    require("S010_002")
    S010_002:Event_070()
  end
  if gMapNum == 203 then
    require("S110_090")
    S110_090:Event_040()
    require("S110_104")
    S110_104:Event_080()
    S110_104:Event_030()
    require("S110_113")
    S110_113:Event_040()
    require("S010_002")
    S010_002:Event_060()
    require("S010_180")
    S010_180:Event_040()
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 201 then
    M100:Event_046()
    if Common.CheckTimeAxis("A2028_daft_419") then
      require("Sow_202")
      SeekDrKuga_T0201()
    end
  elseif gMapNum == 203 then
    if Common.CheckTimeAxis("A2028_daft_419") then
      require("Sow_202")
      SeekDrKuga_T0203()
    end
    require("S110_105")
    S110_105:Event_050()
  end
end
