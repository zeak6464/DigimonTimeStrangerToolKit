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
    if gMapNum == 810 or gMapNum == 811 or gMapNum == 812 or gMapNum == 813 then
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
  if gMapNum == 810 then
    if Flg.Check("FLAG_IS_CLEAR_H810") then
      local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gim_terminal_e001_online:Play(1, false)
    end
  elseif gMapNum == 811 then
    if Flg.Check("FLAG_IS_CLEAR_H811") then
      local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gim_terminal_e001_online:Play(1, false)
    end
  elseif gMapNum == 812 then
    if Flg.Check("FLAG_IS_CLEAR_H812") then
      local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gim_terminal_e001_online:Play(1, false)
    end
  elseif gMapNum == 813 and Flg.Check("FLAG_IS_CLEAR_H813") then
    local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
    gim_terminal_e001_online:Play(1, false)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  local enemy_count = GetControlScriptExternalVariable("g_enemy_count", "number")
  print("##### enemy_count = ", tostring(enemy_count), " #####")
  if 1 <= enemy_count then
    print("##### QUEST UPDATE #####")
  end
  if 3 <= enemy_count then
    print("##### QUEST CREAR #####")
    WaitFrame(30)
    Prcs_h08_StageClear()
  elseif 1 <= enemy_count then
    print("##### NEXT STAGE #####")
    SetControlScriptExternalVariable("g_enemy_count", enemy_count)
  end
  if (gMapNum == 810 or gMapNum == 811 or gMapNum == 812 or gMapNum == 813) and not Flg.Check("FLAG_IS_HAZAMA_FIRST_TRIP") then
    HazamaFirstTripEvent()
  end
end
