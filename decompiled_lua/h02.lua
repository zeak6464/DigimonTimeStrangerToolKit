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
    if gMapNum == 201 then
      if start_loc == "start_00" then
        Move.PlayerIsDegeGateOut()
      end
    elseif gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
      if start_loc == "start_00" then
        print("##### START LOC 00 #####")
        Move.PlayerIsDegeGateOut()
      end
      if start_loc == "start_01" then
        print("##### START LOC 01 #####")
      end
    end
    if gMapNum == 220 then
      if start_loc == "start_00" then
        Digitter.Send(5040010)
      end
    elseif gMapNum == 221 then
      if start_loc == "start_00" then
        Digitter.Send(5040012)
      end
    elseif gMapNum == 222 and start_loc == "start_00" then
      Digitter.Send(5040014)
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
  if gMapNum == 201 then
    M080:Event_090()
    M080:Event_110()
    require("S110_090")
    S110_090:Event_020()
    S110_090:Event_030()
    if Flg.Check("FLAG_SUB_200_147_002") then
      require("S200_147")
      S200_147:Event_040()
    end
    if Flg.Check("FLAG_SUB_200_147_004") then
      require("S200_147")
      S200_147:Event_045()
    end
  end
  if gMapNum == 210 then
    if Flg.Check("FLAG_IS_CLEAR_H210") then
      local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gimmick_0001_online:Play(1, false)
    end
  elseif gMapNum == 211 then
    if Flg.Check("FLAG_IS_CLEAR_H211") then
      local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gimmick_0001_online:Play(1, false)
    end
  elseif gMapNum == 212 then
    if Flg.Check("FLAG_IS_CLEAR_H212") then
      local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gimmick_0001_online:Play(1, false)
    end
  elseif gMapNum == 213 and Flg.Check("FLAG_IS_CLEAR_H213") then
    local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
    gimmick_0001_online:Play(1, false)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 201 then
  end
  if gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    print("##### step0 #####")
    if not Flg.Check("FLAG_IS_HAZAMA_FIRST_TRIP") then
      HazamaFirstTripEvent()
    end
    if gMapNum == 210 then
      if Flg.Check("FLAG_IS_H210_PERFECT_CLEAR") then
        Prcs_h02_StageClear()
      end
    elseif gMapNum == 211 then
      if Flg.Check("FLAG_IS_H211_PERFECT_CLEAR") then
        Prcs_h02_StageClear()
      end
    elseif gMapNum == 212 then
      if Flg.Check("FLAG_IS_H212_PERFECT_CLEAR") then
        Prcs_h02_StageClear()
      end
    elseif gMapNum == 213 and Flg.Check("FLAG_IS_H213_PERFECT_CLEAR") then
      Prcs_h02_StageClear()
    end
  end
  if gMapNum == 220 or gMapNum == 221 or gMapNum == 222 then
  end
end
