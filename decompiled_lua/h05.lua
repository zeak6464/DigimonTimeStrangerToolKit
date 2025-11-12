function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  LoadEffefctScript("ef_f_mov_112_wa", 1)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  gMapId = string.format("%d", string.sub(gMapNum, 1, 1))
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
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
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    if gMapNum == 510 or gMapNum == 511 or gMapNum == 512 or gMapNum == 513 then
      if start_loc == "start_00" then
        print("##### START LOC 00 #####")
        Move.PlayerIsDegeGateOut()
      end
      if start_loc == "start_01" then
        print("##### START LOC 01 #####")
      end
    end
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 510 then
    if Flg.Check("FLAG_IS_CLEAR_H510") then
      local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gim_terminal_e001_online:Play(1, false)
    end
  elseif gMapNum == 511 then
    if Flg.Check("FLAG_IS_CLEAR_H511") then
      local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gim_terminal_e001_online:Play(1, false)
    end
  elseif gMapNum == 512 then
    if Flg.Check("FLAG_IS_CLEAR_H512") then
      local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gim_terminal_e001_online:Play(1, false)
    end
  elseif gMapNum == 513 then
    if Flg.Check("FLAG_IS_CLEAR_H513") then
      local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gim_terminal_e001_online:Play(1, false)
    end
  elseif gMapNum == 520 then
    local start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_00" then
      local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
      SetFollowerCameraOperateRotation(-15, rot, 0)
    end
    if Flg.Check("FLAG_IS_CLEAR_S900_217") then
      require("S900_217")
      S900_217:Event_045()
      S900_217:Event_055()
      S900_217:Event_065()
      S900_217:Event_075()
      S900_217:Event_085()
      S900_217:Event_095()
      S900_217:Event_105()
      S900_217:Event_115()
      S900_217:Event_125()
      S900_217:Event_135()
      S900_217:Event_145()
      S900_217:Event_155()
    end
    S900_217:Event_160()
    Cam.Inst:Clear(30)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if (gMapNum == 510 or gMapNum == 511 or gMapNum == 512 or gMapNum == 513) and not Flg.Check("FLAG_IS_HAZAMA_FIRST_TRIP") then
    HazamaFirstTripEvent()
  end
end
