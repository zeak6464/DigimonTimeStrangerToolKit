function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  if load_map_num == 403 then
  end
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  InitializeObject()
  MapNameDisp()
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
    if Flg.Check("FLAG_IS_MAPCHANGE_USING_DOOR") then
      Flg.Clear("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200002, 100)
      FadeInWithWait(0, 10)
    else
      FadeInWithWait(0, 0)
    end
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if gMapNum == 401 then
    if start_loc == "start_07" then
      SetFollowerCameraOperateRotation(20, 217)
      Prcs_t0401_StairsZoom(true, 0)
      Prcs_t0401_TownAccessOff()
    end
    if start_loc == "start_08" then
      SetFollowerCameraOperateRotation(23, 218)
      Prcs_t0401_StairsZoom(true, 0)
      Prcs_t0401_TownAccessOff()
    end
    if start_loc == "start_09" then
      M440:Event_839()
    end
    if start_loc == "start_11" then
      SetFollowerCameraOperateRotation(35, 205)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Prcs_t0401_StairsZoom(true, 0)
      Prcs_t0401_TownAccessOff()
    end
  elseif gMapNum == 403 then
    if start_loc == "start_00" then
      if Flg.Check("FLAG_IS_MAPCHANGE_USING_DOOR") then
        SetEnableGimmickCheck("gim_0001", false)
        SetEnableGimmickCheck("gim_0004", false)
        SetEnableGimmickCheck("gim_0005", false)
        SetEnableGimmickCheck("gim_0006", false)
        SetEnableGimmickCheck("gim_0007", false)
        SetEnableGimmickCheck("gim_0008", false)
        SetEnableGimmickCheck("gim_0009", false)
        SetEnableGimmickCheck("gim_0011", false)
        SetEnableGimmickCheck("gim_0012", false)
      end
      M440:Event_837()
    elseif start_loc == "start_01" then
      if Flg.Check("FLAG_IS_MAPCHANGE_USING_DOOR") then
        SetFollowerCameraOperateRotation(25, 185)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        SetEnableGimmickCheck("gim_0001", false)
        SetEnableGimmickCheck("gim_0004", false)
        SetEnableGimmickCheck("gim_0005", false)
        SetEnableGimmickCheck("gim_0006", false)
        SetEnableGimmickCheck("gim_0007", false)
        SetEnableGimmickCheck("gim_0008", false)
        SetEnableGimmickCheck("gim_0009", false)
        SetEnableGimmickCheck("gim_0011", false)
        SetEnableGimmickCheck("gim_0012", false)
      end
    else
      SetEnableGimmickCheck("gim_0001", true)
      SetEnableGimmickCheck("gim_0004", true)
      SetEnableGimmickCheck("gim_0005", true)
      SetEnableGimmickCheck("gim_0006", true)
      SetEnableGimmickCheck("gim_0007", true)
      SetEnableGimmickCheck("gim_0008", true)
      SetEnableGimmickCheck("gim_0009", true)
      SetEnableGimmickCheck("gim_0011", true)
      SetEnableGimmickCheck("gim_0012", true)
    end
  end
  if gMapNum == 404 and start_loc == "start_00" then
    local player = Obj:new(PLAYER, "")
    local y_degree = Field.GetAngleToTarget2D(3.061, 1.056, 1.132, -0.089)
    player:SetRotationY(y_degree, 0)
    SetFollowerCameraOperateRotation(0, y_degree)
    WaitFrame(5)
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 401 then
    local start_loc = Field.GetLastPlayerSetLocator()
    M235:Event_010()
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_560") and Common.CheckTimeAxis("P2028_daft_440") then
      Field.HideMinimap(true)
      Field.HideGuide(true)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
    if start_loc == "start_20" then
      require("S010_001")
      S010_001:Event_050()
    end
  end
  if gMapNum == 402 then
    if not Qst.Sub:IsCompleted(1) and Qst.Sub:Check(1, 10, 255) then
      Obj:new(NPC, "npc_0500"):Invisible()
    end
    if not Qst.Sub:IsCompleted(2) and Qst.Sub:Check(2, 10, 255) then
      Obj:new(NPC, "npc_0500"):Invisible()
    end
    M050:Event_030()
    require("S910_169")
    S910_169:Event_050()
    require("S910_170")
    S910_170:Event_120()
    S910_170:Event_080()
    require("S070_055")
    S070_055:Event_020()
    S070_055:Event_035()
  end
  if gMapNum == 403 then
    M060:Event_130()
    M090:Event_060()
    M090:Event_070()
    M110:Event_010()
    M110:Event_020()
    M230:Event_050()
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_560") and Common.CheckTimeAxis("P2028_daft_440") then
      Field.HideMinimap(true)
      Field.HideGuide(true)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
    M420:Event_045_A02()
  end
  if gMapNum == 404 then
    M050:Event_010()
    M060:Event_010()
    M070:Event_010()
    M070:Event_100()
    M080:Event_010()
    M090:Event_010()
    M100:Event_010()
    M110:Event_018()
  end
  if gMapNum == 408 then
    M080:Event_140()
    if Flg.Check("FLAG_T0408_IS_WARP") and GetLastPlayerSetLocator() == "start_30" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_T0408_IS_WARP")
    end
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 401 then
    local start_loc = Field.GetLastPlayerSetLocator()
    if Flg.Check("FLAG_MAIN_03_170", "FLAG_IS_START_FIRST_SUB_QUEST") then
      Flg.Set("FLAG_IS_START_FIRST_SUB_QUEST")
    end
    if Common.CheckTimeAxis("A2028_daft_419") then
      require("Sow_202")
      SeekDrKuga_T0401()
    end
    if Field.IsJustAfterMapChangeNow() == true and (start_loc == "start_07" or start_loc == "start_08" or start_loc == "start_11") then
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
  elseif gMapNum == 402 then
  elseif gMapNum == 404 then
    M050:Event_115()
  end
end
