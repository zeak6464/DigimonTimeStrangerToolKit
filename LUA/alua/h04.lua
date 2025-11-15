function FieldLoadRequest()
  print("=============== FieldLoadRequest =====================")
  
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function StandbyField()
  print("=============== StandbyField =====================")
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  gMapId = string.format("%d", string.sub(gMapNum, 1, 1))
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  MapNameDisp()
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
end

function OnEndLoad()
  print("=============== OnEndLoad =====================")
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
    if gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418 then
      if start_loc == "start_00" then
        print("##### START LOC 00 #####")
        Move.PlayerIsDegeGateOut()
      end
      if start_loc == "start_01" then
        print("##### START LOC 01 #####")
      end
    end
    if gMapNum == 420 then
      local start_loc = GetLastPlayerSetLocator()
      if start_loc == "start_20" then
        require("S010_156")
        Field_InvisibleAllSymbolEnemy(0, 0, false, false)
        S010_156:Event_035()
      end
    end
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  require("S010_156")
  S010_156:Event_040()
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 415 then
    if Flg.Check("FLAG_IS_CLEAR_H415") then
      local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gimmick_0001_online:Play(1, false)
    end
    require("S910_169")
    S910_169:Event_080()
    require("S110_105")
    S110_105:Event_040()
    S110_105:Event_030()
    S110_105:Event_028_C()
    S110_105:Event_028_B()
    S110_105:Event_028_A()
    if Flg.Check("FLAG_SUB_910_169_004", "FLAG_SUB_910_169_005") then
      require("S910_169")
      S910_169:Event_065()
      S910_169:Event_070()
    end
  elseif gMapNum == 416 then
    if Flg.Check("FLAG_IS_CLEAR_H416") then
      local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gimmick_0001_online:Play(1, false)
    end
  elseif gMapNum == 417 then
    if Flg.Check("FLAG_IS_CLEAR_H417") then
      local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
      gimmick_0001_online:Play(1, false)
    end
  elseif gMapNum == 418 and Flg.Check("FLAG_IS_CLEAR_H418") then
    local gimmick_0001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
    gimmick_0001_online:Play(1, false)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if Flg.Check("FLAG_IS_HAZAMA_BOSS_CALL") then
    print("##### CLEAR EVENT CALL #####")
    Flg.Clear("FLAG_IS_HAZAMA_BOSS_CALL")
    Prcs_h04_StageClear()
  end
  if gMapNum ~= 415 and gMapNum ~= 416 and gMapNum ~= 417 and gMapNum ~= 418 or Flg.Check("FLAG_IS_HAZAMA_FIRST_TRIP") or Flg.Check("FLAG_SUB_110_105_005", "FLAG_SUB_110_105_003") then
  else
    HazamaFirstTripEvent()
  end
  if gMapNum == 420 then
    if Flg.Check("FLAG_SUB_900_163_002") then
      local player = Obj:new(PLAYER, "")
      local player_e004 = Motion.Object:new(PLAYER, "", "e004")
      Field_InvisibleAllSymbolEnemy(0, 0, false, false)
      Qst.Sub:End(960, 255)
      Qst.Hazama:Clear(960)
      Common.SetHazamaQuestState(false)
      WaitFrame(60)
      player_e004:Play(10, false)
      WaitFrame(30)
      PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
      PlaySE(200006, 100)
      StartEffectScript(PLAYER, player.index, 1)
      WaitFrame(30)
      player:Invisible()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      WaitFrame(FADE_TIME)
      MapChange("t", 3001, "start_05", false, -1, -1)
    end
  elseif gMapNum == 421 then
    if Flg.Check("FLAG_SUB_900_164_002") then
      local player = Obj:new(PLAYER, "")
      local player_e004 = Motion.Object:new(PLAYER, "", "e004")
      Field_InvisibleAllSymbolEnemy(0, 0, false, false)
      Qst.Sub:End(961, 255)
      Qst.Hazama:Clear(961)
      Common.SetHazamaQuestState(false)
      WaitFrame(60)
      player_e004:Play(10, false)
      WaitFrame(30)
      PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
      PlaySE(200006, 100)
      StartEffectScript(PLAYER, player.index, 1)
      WaitFrame(30)
      player:Invisible()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      WaitFrame(FADE_TIME)
      MapChange("t", 3001, "start_05", false, -1, -1)
    end
  elseif gMapNum == 422 then
    if Flg.Check("FLAG_SUB_900_165_002") then
      local player = Obj:new(PLAYER, "")
      local player_e004 = Motion.Object:new(PLAYER, "", "e004")
      Field_InvisibleAllSymbolEnemy(0, 0, false, false)
      Qst.Sub:End(962, 255)
      Qst.Hazama:Clear(962)
      Common.SetHazamaQuestState(false)
      WaitFrame(60)
      player_e004:Play(10, false)
      WaitFrame(30)
      PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
      PlaySE(200006, 100)
      StartEffectScript(PLAYER, player.index, 1)
      WaitFrame(30)
      player:Invisible()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      WaitFrame(FADE_TIME)
      MapChange("t", 3001, "start_05", false, -1, -1)
    end
  elseif gMapNum == 423 and Flg.Check("FLAG_SUB_900_166_002") then
    local player = Obj:new(PLAYER, "")
    local player_e004 = Motion.Object:new(PLAYER, "", "e004")
    Field_InvisibleAllSymbolEnemy(0, 0, false, false)
    Qst.Sub:End(963, 255)
    Qst.Hazama:Clear(963)
    Common.SetHazamaQuestState(false)
    WaitFrame(60)
    player_e004:Play(10, false)
    WaitFrame(30)
    PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
    PlaySE(200006, 100)
    StartEffectScript(PLAYER, player.index, 1)
    WaitFrame(30)
    player:Invisible()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    WaitFrame(FADE_TIME)
    MapChange("t", 3001, "start_05", false, -1, -1)
  end
end
