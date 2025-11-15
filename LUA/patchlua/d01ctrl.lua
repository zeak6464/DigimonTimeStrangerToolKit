require("function_control")
DEFINE_FLAG("FLAG_GIMMICK_D01_010")
DEFINE_FLAG("FLAG_GIMMICK_D01_011")
DEFINE_FLAG("FLAG_GIMMICK_D01_080")
DEFINE_FLAG("FLAG_GIMMICK_D01_190")
DEFINE_FLAG("FLAG_GIMMICK_D01_250")
DEFINE_FLAG("FLAG_GIMMICK_D01_020")
DEFINE_FLAG("FLAG_GIMMICK_D01_030")
DEFINE_FLAG("FLAG_GIMMICK_D01_060")
DEFINE_FLAG("FLAG_GIMMICK_D01_040")
DEFINE_FLAG("FLAG_GIMMICK_D01_050")
DEFINE_FLAG("FLAG_GIMMICK_D01_100")
DEFINE_FLAG("FLAG_MAIN_18_029E")
DEFINE_FLAG("FLAG_MAIN_18_027")
DEFINE_FLAG("FLAG_MAIN_18_029B")
DEFINE_FLAG("FLAG_MAIN_18_029G")
DEFINE_FLAG("FLAG_MAIN_18_029H")
DEFINE_FLAG("FLAG_MAIN_18_040")
DEFINE_FLAG("FLAG_MAIN_18_045")
DEFINE_FLAG("FLAG_MAIN_18_046")
DEFINE_FLAG("FLAG_GIMMICK_D01_280")
DEFINE_FLAG("FLAG_MAIN_18_055")
DEFINE_FLAG("FLAG_FIELD_D01_010")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H213")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H513")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H813")
DEFINE_FLAG("FLAG_GIMMICK_D01_411")
DEFINE_FLAG("FLAG_GIMMICK_D01_412")
DEFINE_FLAG("FLAG_GIMMICK_D01_413")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gCamY = 0
gCamX = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  if gMapNum == 101 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    LocatorObject(elv_0001).LoadMotion("e001")
    LocatorObject(elv_0001).LoadMotion("e002")
  elseif gMapNum == 102 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    LocatorObject(elv_0001).LoadMotion("e002")
  elseif gMapNum == 103 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local elv_0005 = GetIndex(GIM, "elv_0005")
    LocatorObject(elv_0001).LoadMotion("e001")
    LocatorObject(elv_0002).LoadMotion("e001")
    LocatorObject(elv_0003).LoadMotion("e001")
    LocatorObject(elv_0004).LoadMotion("e001")
    LocatorObject(elv_0005).LoadMotion("e001")
    LocatorObject(elv_0001).LoadMotion("e002")
    LocatorObject(elv_0002).LoadMotion("e002")
    LocatorObject(elv_0003).LoadMotion("e002")
    LocatorObject(elv_0004).LoadMotion("e002")
    LocatorObject(elv_0005).LoadMotion("e002")
    Npc(GetIndex(NPC, "npc_0003")).LoadMotion("e209")
    Npc(GetIndex(NPC, "npc_0004")).LoadMotion("e209")
    Npc(GetIndex(NPC, "npc_0004")).LoadMotion("e210")
    Npc(GetIndex(NPC, "npc_0003")).LoadMotion("fe02")
    Npc(GetIndex(NPC, "npc_0004")).LoadMotion("fe02")
    LoadEffectScript("ef_b_gfi_a02", 2)
    LoadEffectScript("ef_b_gfi_a01", 1)
  elseif gMapNum == 104 then
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 105 then
  elseif gMapNum == 106 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    LocatorObject(elv_0001).LoadMotion("e001")
  elseif gMapNum == 107 then
    LoadRailMove(gRailMoveFile)
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local elv_0005 = GetIndex(GIM, "elv_0005")
    local elv_0006 = GetIndex(GIM, "elv_0006")
    local elv_0007 = GetIndex(GIM, "elv_0007")
    local elv_0008 = GetIndex(GIM, "elv_0008")
    local elv_0009 = GetIndex(GIM, "elv_0009")
    local gim_0003 = GetIndex(GIM, "gim_0003")
    local gim_0004 = GetIndex(GIM, "gim_0004")
    local obj_0004 = GetIndex(GIM, "obj_0004")
    local obj_0005 = GetIndex(GIM, "obj_0005")
    local obj_0006 = GetIndex(GIM, "obj_0006")
    local obj_0007 = GetIndex(GIM, "obj_0007")
    local obj_0008 = GetIndex(GIM, "obj_0008")
    local obj_0009 = GetIndex(GIM, "obj_0009")
    local chr370_make_ice = GetIndex(NPC, "chr370_make_ice")
    Npc(chr370_make_ice).LoadMoveMotion("")
    Npc(chr370_make_ice).LoadMotion("bn01")
    Npc(chr370_make_ice).LoadMotion("fe02")
    Npc(chr370_make_ice).LoadMotion("fe01")
    PlayerSystem.PlayerAlwaysLoadMoveMotion("slide_end")
    PlayerSystem.PlayerAlwaysLoadMotion("fg10_w01")
    LocatorObject(elv_0001).LoadMotion("e001")
    LocatorObject(elv_0002).LoadMotion("e001")
    LocatorObject(elv_0004).LoadMotion("e001")
    LocatorObject(elv_0005).LoadMotion("e001")
    LocatorObject(elv_0006).LoadMotion("e001")
    LocatorObject(elv_0007).LoadMotion("e001")
    LocatorObject(elv_0008).LoadMotion("e001")
    LocatorObject(elv_0009).LoadMotion("e001")
    LocatorObject(gim_0003).LoadMotion("e002")
    LocatorObject(gim_0003).LoadMotion("e003")
    LocatorObject(gim_0004).LoadMotion("e002")
    LocatorObject(gim_0004).LoadMotion("e003")
    LocatorObject(obj_0004).LoadMotion("e001")
    LocatorObject(obj_0004).LoadMotion("e002")
    LocatorObject(obj_0005).LoadMotion("e001")
    LocatorObject(obj_0005).LoadMotion("e002")
    LocatorObject(obj_0006).LoadMotion("e001")
    LocatorObject(obj_0006).LoadMotion("e002")
    LocatorObject(obj_0007).LoadMotion("e001")
    LocatorObject(obj_0007).LoadMotion("e002")
    LocatorObject(obj_0008).LoadMotion("e001")
    LocatorObject(obj_0008).LoadMotion("e002")
    LocatorObject(obj_0009).LoadMotion("e001")
    LocatorObject(obj_0009).LoadMotion("e002")
  elseif gMapNum == 108 then
    local mpenmons = {}
    for i = 1, 13 do
      print("=======================================chr622_slide", tostring(i))
      mpenmons[i] = GetIndex(ENEMY, "chr622_slide" .. tostring(i))
      SymbolEnemy(mpenmons[i]).LoadMoveMotion("slide")
    end
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 109 then
    LoadLocatorModel(gPlanData)
  end
end

function FirstPeriodDeployLift()
  print("=============== FirstPeriodDeployLift =====================")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 101 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if start_loc == "start_01" then
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 102 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if start_loc == "start_00" then
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 103 then
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    local elv_0005 = GetIndex(GIM, "elv_0005")
    if start_loc == "start_00" then
      if not FlagCheck(FLAG_MAIN_18_027) then
        LocatorObject(elv_0001).DeployLift(false)
        FlagClear(FLAG_GIMMICK_D01_411)
        LocatorObject(elv_0005).DeployLift(false)
        FlagClear(FLAG_GIMMICK_D01_412)
        LocatorObject(elv_0003).DeployLift(false)
        FlagSet(FLAG_GIMMICK_D01_413)
      else
        LocatorObject(elv_0001).DeployLift(true)
        FlagSet(FLAG_GIMMICK_D01_411)
        LocatorObject(elv_0005).DeployLift(true)
        FlagSet(FLAG_GIMMICK_D01_412)
        LocatorObject(elv_0003).DeployLift(true)
        FlagClear(FLAG_GIMMICK_D01_413)
      end
    elseif start_loc == "start_01" then
      LocatorObject(elv_0002).DeployLift(false)
      LocatorObject(elv_0004).DeployLift(false)
      LocatorObject(elv_0005).DeployLift(false)
      FlagClear(FLAG_GIMMICK_D01_412)
      LocatorObject(elv_0003).DeployLift(false)
      FlagSet(FLAG_GIMMICK_D01_413)
      LocatorObject(elv_0001).DeployLift(false)
      FlagClear(FLAG_GIMMICK_D01_411)
    elseif start_loc == "start_70" then
      LocatorObject(elv_0002).DeployLift(false)
      LocatorObject(elv_0004).DeployLift(false)
      LocatorObject(elv_0003).DeployLift(false)
      FlagSet(FLAG_GIMMICK_D01_413)
      LocatorObject(elv_0005).DeployLift(true)
      FlagSet(FLAG_GIMMICK_D01_412)
      LocatorObject(elv_0001).DeployLift(false)
      FlagClear(FLAG_GIMMICK_D01_411)
    end
    if FlagCheck(FLAG_GIMMICK_D01_020) and FlagCheck(FLAG_GIMMICK_D01_060) then
      if FlagCheck(FLAG_MAIN_18_040) and not FlagCheck(FLAG_MAIN_18_055) then
        LocatorObject(elv_0002).DeployLift(true)
      else
        LocatorObject(elv_0002).DeployLift(false)
      end
    end
    if FlagCheck(FLAG_GIMMICK_D01_030) then
      LocatorObject(elv_0004).DeployLift(false)
    end
    if FlagCheck(FLAG_GIMMICK_D01_040) then
      LocatorObject(elv_0001).DeployLift(false)
    end
    if FlagCheck(FLAG_GIMMICK_D01_050) then
      LocatorObject(elv_0003).DeployLift(false)
    end
    if FlagCheck(FLAG_GIMMICK_D01_100) then
      LocatorObject(elv_0005).DeployLift(false)
    end
  elseif gMapNum == 106 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if start_loc == "start_00" then
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 107 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0006 = GetIndex(GIM, "elv_0006")
    local elv_0007 = GetIndex(GIM, "elv_0007")
    local elv_0008 = GetIndex(GIM, "elv_0008")
    local elv_0009 = GetIndex(GIM, "elv_0009")
    LocatorObject(elv_0009).DeployLift(false)
    LocatorObject(elv_0002).DeployLift(false)
    if not FlagCheck(FLAG_MAIN_18_029B) then
      LocatorObject(elv_0008).DeployLift(false)
    end
    if FlagCheck(FLAG_MAIN_18_040) and not FlagCheck(FLAG_MAIN_18_055) then
      LocatorObject(elv_0008).DeployLift(false)
    end
    if FlagCheck(FLAG_MAIN_18_040) then
      LocatorObject(elv_0001).DeployLift(false)
    end
    if start_loc == "start_70" then
      LocatorObject(elv_0006).DeployLift(false)
      LocatorObject(elv_0007).DeployLift(false)
    end
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  SetExternalVariable("mapchange_seplay", "Initialize")
  SetExternalVariable("elevator_motionloop_d0106", "initialize")
  SetExternalVariable("lift_state", "initialize")
  SetExternalVariable("lift_name", "initialize")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 101 then
    SetExternalVariable("elevator_motionloop", "initialize")
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if IsJustAfterMapChangeNow() == true and start_loc == "start_01" then
      LocatorObject(elv_0001).MoveStartLift(false)
    end
  elseif gMapNum == 102 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if IsJustAfterMapChangeNow() == true and start_loc == "start_00" then
      SetInstantCamera(-70.5, -1.1, 45.9, -61.3, 2.1, 44, DEFAULT_ANGLE, 0)
      LocatorObject(elv_0001).MoveStartLift(false)
    end
  elseif gMapNum == 103 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local elv_0005 = GetIndex(GIM, "elv_0005")
    SetExternalVariable("aporo_npc0003", "initialize")
    SetExternalVariable("aporo_npc0004", "initialize")
  elseif gMapNum == 104 then
    SetExternalVariable("enemy_001_state", "init")
    SetExternalVariable("enemy_002_state", "init")
    SetExternalVariable("enemy_003_state", "init")
    SetExternalVariable("enemy_004_state", "init")
    SetExternalVariable("enemy_005_state", "init")
    SetExternalVariable("enemy_006_state", "init")
    SetExternalVariable("enemy_007_state", "init")
    SetExternalVariable("enemy_008_state", "init")
    SetExternalVariable("enemy_009_state", "init")
    if FlagCheck(FLAG_MAIN_18_029G) then
      SetExternalVariable("enemy_001_state", "start")
      SetExternalVariable("enemy_002_state", "start")
      SetExternalVariable("enemy_003_state", "start")
      SetExternalVariable("enemy_007_state", "start")
    end
    if FlagCheck(FLAG_MAIN_18_029H) then
      SetExternalVariable("enemy_004_state", "start")
      SetExternalVariable("enemy_005_state", "start")
      SetExternalVariable("enemy_006_state", "start")
      SetExternalVariable("enemy_008_state", "start")
      SetExternalVariable("enemy_009_state", "start")
    end
    SetExternalVariable("player")
  elseif gMapNum == 106 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if IsJustAfterMapChangeNow() == true and start_loc == "start_00" then
      SetInstantCamera(69.3, -1, 46.6, 79.2, 0.2, 46.7, DEFAULT_ANGLE, 0)
      LocatorObject(elv_0001).MoveStartLift(false)
    end
  elseif gMapNum == 107 then
    local chr370_make_ice = GetIndex(NPC, "chr370_make_ice")
    SetExternalVariable("chr370_make_ice_state", "Initialize")
    Npc(chr370_make_ice).LinkToRailMove("d0107_railmove", 100)
    Npc(chr370_make_ice).SetRailMoveInDimension2d()
    Npc(chr370_make_ice).SetRailMoveSpeed(7)
    local elv10 = GetIndex(GIM, "elv_0010")
    SetExternalVariable("elv10_state", "Initialize")
    local elv11 = GetIndex(GIM, "elv_0011")
    SetExternalVariable("elv11_state", "Initialize")
    local elv12 = GetIndex(GIM, "elv_0012")
    SetExternalVariable("elv12_state", "Initialize")
    SetExternalVariable("elv_0008", "initialize")
  elseif gMapNum == 108 then
    local mpenmons = {}
    for i = 1, 13 do
      mpenmons[i] = GetIndex(ENEMY, "chr622_slide" .. tostring(i))
      SymbolEnemy(mpenmons[i]).LoadMoveMotion("slide")
      SymbolEnemy(mpenmons[i]).SetRailMoveSpeed(20)
      SymbolEnemy(mpenmons[i]).SetRailMoveInDimension2d()
      SymbolEnemy(mpenmons[i]).SetRailMoveDirection(true)
    end
    SymbolEnemy(mpenmons[1]).LinkToRailMove(gRailMoveFile, 1)
    SymbolEnemy(mpenmons[2]).LinkToRailMove(gRailMoveFile, 5)
    SymbolEnemy(mpenmons[3]).LinkToRailMove(gRailMoveFile, 3)
    SymbolEnemy(mpenmons[4]).LinkToRailMove(gRailMoveFile, 7)
    SymbolEnemy(mpenmons[5]).LinkToRailMove(gRailMoveFile, 9)
    SymbolEnemy(mpenmons[6]).LinkToRailMove(gRailMoveFile, 7)
    SymbolEnemy(mpenmons[7]).LinkToRailMove(gRailMoveFile, 9)
    SymbolEnemy(mpenmons[8]).LinkToRailMove(gRailMoveFile, 13)
    SymbolEnemy(mpenmons[9]).LinkToRailMove(gRailMoveFile, 15)
    SymbolEnemy(mpenmons[10]).LinkToRailMove(gRailMoveFile, 15)
    SymbolEnemy(mpenmons[11]).LinkToRailMove(gRailMoveFile, 17)
    SymbolEnemy(mpenmons[12]).LinkToRailMove(gRailMoveFile, 13)
    SymbolEnemy(mpenmons[13]).LinkToRailMove(gRailMoveFile, 17)
    for i = 1, 13 do
      SetExternalVariable("mpenmons_state" .. tostring(i), "init")
    end
    if FlagCheck(FLAG_MAIN_18_045) then
      SetExternalVariable("mpenmons_state1", "start")
      SetExternalVariable("mpenmons_state2", "start")
      SetExternalVariable("mpenmons_state3", "start")
    end
    if FlagCheck(FLAG_MAIN_18_046) then
      SetExternalVariable("mpenmons_state4", "start")
      SetExternalVariable("mpenmons_state5", "start")
      SetExternalVariable("mpenmons_state6", "start")
      SetExternalVariable("mpenmons_state7", "start")
    end
    if FlagCheck(FLAG_GIMMICK_D01_280) then
      SetExternalVariable("mpenmons_state8", "start")
      SetExternalVariable("mpenmons_state9", "start")
      SetExternalVariable("mpenmons_state10", "start")
      SetExternalVariable("mpenmons_state11", "start")
      SetExternalVariable("mpenmons_state12", "start")
      SetExternalVariable("mpenmons_state13", "start")
    end
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if GetExternalVariable("move_elv") == "moveing" then
    DisableMenuInNowFrame()
    DisableAnalyzeAndFieldAttackOnlyThisFrame()
  end
  if gMapNum == 101 then
  elseif gMapNum == 107 then
    local chr370_make_ice = GetIndex(NPC, "chr370_make_ice")
    if GetExternalVariable("chr370_make_ice_state") == "move" then
      Npc(chr370_make_ice).SetEnablePlayerCheck(false)
    else
      Npc(chr370_make_ice).SetEnablePlayerCheck(true)
    end
  end
end

function Update(elapsed_frame)
  local seplay = GetExternalVariable("mapchange_seplay")
  if seplay == "play" then
    PlayAndManageSE(200009, 100, 60, 1, true, true)
    SetExternalVariable("mapchange_seplay", "Initialize")
  end
  if GetExternalVariable("theater_state") == "play" then
    local theater_loc = string.sub(GetExternalVariable("theater_place"), 10)
    local start_loc = string.sub(GetExternalVariable("theater_place"), 1, 8)
    TheaterDoorCam(theater_loc, start_loc, elapsed_frame)
  else
    for i = 1, 2 do
      local theater = GetIndex(GIM, "theater_00" .. string.format("%02d", i))
      if theater ~= nil and LocatorObject(theater).IsPlayingMotion("e001") == false then
        LocatorObject(theater).LoadMotion("e001")
        LocatorObject(theater).Motion_PlayMotion("e001", 0, true)
      end
    end
  end
  if GetExternalVariable("move_elv") == "moveing" then
  end
  if GetExternalVariable("elv_cam") == "moveing" then
  end
  if gMapNum == 101 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if FlagCheck(FLAG_GIMMICK_D01_011) then
      if GetExternalVariable("elevator_motionloop") ~= "blue" then
        LocatorObject(elv_0001).Motion_PlayMotionAndSetting("e001", 0, 60, 60, 360, 1, true)
        SetExternalVariable("elevator_motionloop", "blue")
      end
    elseif FlagCheck(FLAG_GIMMICK_D01_010) and GetExternalVariable("elevator_motionloop") ~= "red" then
      LocatorObject(elv_0001).Motion_PlayMotionAndSetting("e002", 0, 60, 60, 360, 1, true)
      SetExternalVariable("elevator_motionloop", "red")
    end
  elseif gMapNum == 102 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if GetExternalVariable("elevator_motionloop_d0102") ~= "red" then
      LocatorObject(elv_0001).Motion_PlayMotionAndSetting("e002", 0, 60, 60, 360, 1, true)
      SetExternalVariable("elevator_motionloop_d0102", "red")
    end
  elseif gMapNum == 103 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local elv_0005 = GetIndex(GIM, "elv_0005")
    local lift_state = GetExternalVariable("lift_state")
    local lift_name = GetExternalVariable("lift_name")
    if FlagCheck(FLAG_GIMMICK_D01_040) and FlagCheck(FLAG_MAIN_18_029E) then
      LocatorObject(elv_0001).Motion_PlayMotion("e002", 0, false)
    else
    end
    if FlagCheck(FLAG_GIMMICK_D01_020) and FlagCheck(FLAG_GIMMICK_D01_060) then
      LocatorObject(elv_0002).Motion_PlayMotion("e002", 0, false)
    else
    end
    if FlagCheck(FLAG_GIMMICK_D01_050) and FlagCheck(FLAG_MAIN_18_029E) then
      LocatorObject(elv_0003).Motion_PlayMotion("e002", 0, false)
    else
    end
    if FlagCheck(FLAG_GIMMICK_D01_030) then
      LocatorObject(elv_0004).Motion_PlayMotion("e002", 0, false)
    else
    end
    if FlagCheck(FLAG_GIMMICK_D01_100) then
      LocatorObject(elv_0005).Motion_PlayMotion("e002", 0, false)
    else
    end
    if lift_state ~= "playing_motion" then
      if lift_name == "elv_0001" then
        PlayElevatorMotion(elv_0001, lift_state)
      elseif lift_name == "elv_0002" then
        PlayElevatorMotion(elv_0002, lift_state)
      elseif lift_name == "elv_0003" then
        PlayElevatorMotion(elv_0003, lift_state)
      elseif lift_name == "elv_0004" then
        PlayElevatorMotion(elv_0004, lift_state)
      elseif lift_name == "elv_0005" then
        PlayElevatorMotion(elv_0005, lift_state)
      end
    end
    local elv_noise = GetExternalVariable("elv_noise")
    if elv_noise == "start" then
      start_frame = GetTotalElapsedFrame()
      SetExternalVariable("elv_noise", "playing")
    elseif elv_noise == "playing" and GetTotalElapsedFrame() - start_frame > 280 then
      StopManageSE(1, 40)
      SetExternalVariable("elv_noise", "Initialize")
      PlaySE(200010, 100)
    end
    if GetExternalVariable("aporo_npc0003") == "start_fe02" then
      local aporo = GetIndex(NPC, "npc_0003")
      Npc(aporo).Motion_PlayMotion("fe02", 5, false)
      if Npc(aporo).GetMotionEvalFrame("fe02") >= 20 then
        QuakeStart(0.1, 0, -1)
        PlayVoiceFromName("m430_020_046")
        SetExternalVariable("aporo_npc0003", "play_fe02")
      end
    elseif GetExternalVariable("aporo_npc0003") == "play_fe02" then
      local aporo = GetIndex(NPC, "npc_0003")
      if Npc(aporo).GetMotionEvalFrame("fe02") >= 50 then
        QuakeStop()
      end
      if Npc(aporo).IsPlayingMotion("fe02") == false then
        Npc(aporo).Motion_PlayMotion("e209", 5, false)
        SetExternalVariable("aporo_npc0003", "start_e209")
      end
    elseif GetExternalVariable("aporo_npc0003") == "start_e209" then
      local aporo = GetIndex(NPC, "npc_0003")
      if Npc(aporo).GetMotionEvalFrame("e209") >= 26 then
        QuakeStart(0.5, 0, -1)
        PlayAndManageSE(202007, 100, 0, 1, false, true)
      end
      if Npc(aporo).GetMotionEvalFrame("e209") >= 30 then
        QuakeStop()
        SetExternalVariable("aporo_npc0003", "start_Invisible")
        Npc(aporo).Motion_PlayMotion("bn01", 5, false)
      end
    elseif GetExternalVariable("aporo_npc0003") == "start_Invisible" then
      local aporo = GetIndex(NPC, "npc_0003")
      Npc(aporo).InvisibleInNowFrame(0, 0, true)
      if 20 <= Npc(aporo).GetMotionEvalFrame("bn01") then
        StopManageSE(1, 10)
        SetExternalVariable("aporo_npc0003", "start_Invisible01")
        local pos_x, pos_y, pos_z = Npc(aporo).GetPosition()
        PlayEffectScript("ef_b_gfi_a02", pos_x, pos_y, pos_z, 0, 1)
        QuakeStart(0.5, 0, 45)
      end
    elseif GetExternalVariable("aporo_npc0003") == "start_Invisible01" then
      local aporo = GetIndex(NPC, "npc_0003")
      Npc(aporo).InvisibleInNowFrame(0, 0, true)
    elseif GetExternalVariable("aporo_npc0003") == "end" then
      QuakeStop()
    end
    if GetExternalVariable("aporo_npc0004") == "start" then
      local aporo = GetIndex(NPC, "npc_0004")
      Npc(aporo).InvisibleInNowFrame(0, 0, true)
      Npc(aporo).Motion_PlayMotion("bn01", 5, false)
      local pos_x, pos_y, pos_z = Npc(aporo).GetPosition()
      PlayEffectScript("ef_b_gfi_a01", pos_x, pos_y, pos_z, 0, 3)
      SetExternalVariable("aporo_npc0004", "start_eff01")
    elseif GetExternalVariable("aporo_npc0004") == "start_eff01" then
      local aporo = GetIndex(NPC, "npc_0004")
      if Npc(aporo).GetMotionEvalFrame("bn01") >= 15 then
        QuakeStart(0.5, 0, 45)
        Npc(aporo).Motion_PlayMotion("e210", 5, false)
        Npc(aporo).InvisibleInNowFrame(0, 0, true)
        SetExternalVariable("aporo_npc0004", "start_e210")
      else
        Npc(aporo).InvisibleInNowFrame(0, 0, true)
      end
    elseif GetExternalVariable("aporo_npc0004") == "start_e210" then
      local aporo = GetIndex(NPC, "npc_0004")
      if 15 <= Npc(aporo).GetMotionEvalFrame("e210") then
        SetExternalVariable("aporo_npc0004", "start_wait")
      else
        Npc(aporo).InvisibleInNowFrame(0, 0, true)
      end
    elseif GetExternalVariable("aporo_npc0004") == "start_fe02" then
      local aporo = GetIndex(NPC, "npc_0004")
      Npc(aporo).Motion_PlayMotion("fe02", 5, false)
      if Npc(aporo).GetMotionEvalFrame("fe02") >= 20 then
        QuakeStart(0.1, 0, -1)
        SetExternalVariable("aporo_npc0004", "play_fe02")
      end
    elseif GetExternalVariable("aporo_npc0004") == "play_fe02" then
      local aporo = GetIndex(NPC, "npc_0004")
      if Npc(aporo).GetMotionEvalFrame("fe02") >= 50 then
        QuakeStop()
      end
      if Npc(aporo).IsPlayingMotion("fe02") == false then
        Npc(aporo).Motion_PlayMotion("e209", 5, false)
        PlayVoiceFromName("m430_020_046")
        SetExternalVariable("aporo_npc0004", "start_e209")
      end
    elseif GetExternalVariable("aporo_npc0004") == "start_e209" then
      local aporo = GetIndex(NPC, "npc_0004")
      if Npc(aporo).GetMotionEvalFrame("e209") >= 26 then
        QuakeStart(0.5, 0, -1)
        PlayAndManageSE(202007, 100, 0, 1, false, true)
      end
      if Npc(aporo).GetMotionEvalFrame("e209") >= 30 then
        QuakeStop()
        SetExternalVariable("aporo_npc0004", "start_Invisible")
        Npc(aporo).Motion_PlayMotion("bn01", 5, false)
      end
    elseif GetExternalVariable("aporo_npc0004") == "start_Invisible" then
      local aporo = GetIndex(NPC, "npc_0004")
      Npc(aporo).InvisibleInNowFrame(0, 0, true)
      if 20 <= Npc(aporo).GetMotionEvalFrame("bn01") then
        StopManageSE(1, 10)
        SetExternalVariable("aporo_npc0004", "start_Invisible01")
        local pos_x, pos_y, pos_z = Npc(aporo).GetPosition()
        PlayEffectScript("ef_b_gfi_a02", pos_x, pos_y, pos_z, 0, 1)
        QuakeStart(0.5, 0, 45)
      end
    elseif GetExternalVariable("aporo_npc0004") == "start_Invisible01" then
      local aporo = GetIndex(NPC, "npc_0004")
      Npc(aporo).InvisibleInNowFrame(0, 0, true)
    elseif GetExternalVariable("aporo_npc0004") == "end" then
      QuakeStop()
    end
  elseif gMapNum == 104 then
    if FlagCheck(FLAG_MAIN_18_029G) then
      local enemy_001 = GetIndex(ENEMY, "enemy_001")
      local enemy_002 = GetIndex(ENEMY, "enemy_002")
      local enemy_003 = GetIndex(ENEMY, "enemy_003")
      local enemy_007 = GetIndex(ENEMY, "enemy_007")
      TutidaruRolling(enemy_001, "enemy_001_state", "rail_move_001", "rail_move_101")
      TutidaruRolling(enemy_002, "enemy_002_state", "rail_move_002", "rail_move_102")
      TutidaruRolling(enemy_003, "enemy_003_state", "rail_move_003", "rail_move_103")
      TutidaruRolling(enemy_007, "enemy_007_state", "rail_move_001", "rail_move_101")
    end
    if FlagCheck(FLAG_MAIN_18_029H) then
      local enemy_004 = GetIndex(ENEMY, "enemy_004")
      local enemy_005 = GetIndex(ENEMY, "enemy_005")
      local enemy_006 = GetIndex(ENEMY, "enemy_006")
      local enemy_008 = GetIndex(ENEMY, "enemy_008")
      local enemy_009 = GetIndex(ENEMY, "enemy_009")
      TutidaruRolling(enemy_004, "enemy_004_state", "rail_move_004", "rail_move_104")
      TutidaruRolling(enemy_005, "enemy_005_state", "rail_move_005", "rail_move_105")
      TutidaruRolling(enemy_006, "enemy_006_state", "rail_move_006", "rail_move_106")
      TutidaruRolling(enemy_008, "enemy_008_state", "rail_move_005", "rail_move_105")
      TutidaruRolling(enemy_009, "enemy_009_state", "rail_move_006", "rail_move_106")
    end
  elseif gMapNum == 106 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if GetExternalVariable("elevator_motionloop_d0106") ~= "blue" then
      LocatorObject(elv_0001).Motion_PlayMotionAndSetting("e001", 0, 60, 60, 360, 1, true)
      SetExternalVariable("elevator_motionloop_d0106", "blue")
    end
  elseif gMapNum == 107 then
    local chr370_make_ice = GetIndex(NPC, "chr370_make_ice")
    local chr370_make_ice_state = GetExternalVariable("chr370_make_ice_state")
    local stop_pos_x, stop_pos_y, stop_pos_z = GetLocatorPosOfLocatorModel("d0107p", "script_chr370_stop", 0)
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local elv_0005 = GetIndex(GIM, "elv_0005")
    local elv_0006 = GetIndex(GIM, "elv_0006")
    local elv_0007 = GetIndex(GIM, "elv_0007")
    local elv_0008 = GetIndex(GIM, "elv_0008")
    local elv_0009 = GetIndex(GIM, "elv_0009")
    local gim_0003 = GetIndex(GIM, "gim_0003")
    local gim_0004 = GetIndex(GIM, "gim_0004")
    local obj_0004 = GetIndex(GIM, "obj_0004")
    local obj_0005 = GetIndex(GIM, "obj_0005")
    local obj_0006 = GetIndex(GIM, "obj_0006")
    local obj_0007 = GetIndex(GIM, "obj_0007")
    local obj_0008 = GetIndex(GIM, "obj_0008")
    local obj_0009 = GetIndex(GIM, "obj_0009")
    if chr370_make_ice_state == "move" then
      Npc(chr370_make_ice).RailMoveGo()
      Npc(chr370_make_ice).Physics_SetCollisionContactForMapOnly()
      if Npc(chr370_make_ice).IsArrivalRailBothEnds() == true then
        SetExternalVariable("chr370_make_ice_state", "arrival")
      end
    elseif chr370_make_ice_state == "arrival" then
      Npc(chr370_make_ice).Move_Move2DToTarget(stop_pos_x, stop_pos_z, 3)
      SetExternalVariable("chr370_make_ice_state", "end")
    elseif chr370_make_ice_state == "eating" then
      Npc(chr370_make_ice).Motion_PlayMotion("fe01", 10, true)
    elseif chr370_make_ice_state == "reaction" then
      Npc(chr370_make_ice).Motion_PlayMotion("fe02", 10, false)
      if Npc(chr370_make_ice).IsPlayingMotion("fe02") == false then
        SetExternalVariable("chr370_make_ice_state", "reaction_end")
      end
    elseif chr370_make_ice_state == "reaction_end" then
      Npc(chr370_make_ice).Motion_PlayMotion("bn01", 30, true)
      SetExternalVariable("chr370_make_ice_state", "Initialize")
    elseif chr370_make_ice_state == "end" then
      Npc(chr370_make_ice).Move_SetRotationY(200, 10)
      Npc(chr370_make_ice).Physics_ResetCollisionContact()
      Npc(chr370_make_ice).Physics_ResetSetupCollisionType()
      Npc(chr370_make_ice).Motion_PlayMotion("bn01", 0, true)
    end
    if FlagCheck(FLAG_GIMMICK_D01_080) and chr370_make_ice_state == "Initialize" then
      Npc(chr370_make_ice).Move_SetPosition(stop_pos_x, stop_pos_y, stop_pos_z)
      Npc(chr370_make_ice).Motion_PlayMotion("bn01", 10, true)
    end
    local elv10 = GetIndex(GIM, "elv_0010")
    local elv10_state = GetExternalVariable("elv10_state")
    local elv11 = GetIndex(GIM, "elv_0011")
    local elv11_state = GetExternalVariable("elv11_state")
    local elv12 = GetIndex(GIM, "elv_0012")
    local elv12_state = GetExternalVariable("elv12_state")
    if elv10_state == "slide_start" then
      Player().Motion_PlayMotion("fg10_w01", 5, true)
      LocatorObject(elv10).MoveStartLift(true)
      SetExternalVariable("elv10_state", "sliding")
    elseif elv10_state == "sliding" then
      rotateY = Player().GetRotationY()
      SetFollowerCameraOperateRotationY(rotateY)
    elseif elv10_state == "arrival" then
      Player().Motion_ResetPlayMotion(0)
      arrival_frame = GetTotalElapsedFrame()
      SetExternalVariable("elv10_state", "landing")
    end
    elv10_state = GetExternalVariable("elv10_state")
    if elv10_state == "landing" then
      if GetTotalElapsedFrame() - arrival_frame < 35 then
        Player().MoveMotion_StandbyMoveMotionSet("slide_end")
        Player().Move_Move2D(0, 3)
        FlagClear(FLAG_GIMMICK_D01_190)
      else
        SetExternalVariable("elv10_state", "end")
      end
    elseif elv10_state == "end" then
      Player().MoveMotion_ResetStandbyMoveMotionSet()
      SetExternalVariable("elv10_state", "Initialize")
      LocatorObject(elv10).DeployLift(true)
    end
    if elv11_state == "slide_start" then
      Player().Motion_PlayMotion("fg10_w01", 5, true)
      LocatorObject(elv11).MoveStartLift(true)
      SetExternalVariable("elv11_state", "sliding")
    elseif elv11_state == "sliding" then
      rotateY = Player().GetRotationY()
      SetFollowerCameraOperateRotationY(rotateY)
    elseif elv11_state == "arrival" then
      Player().Motion_ResetPlayMotion(0)
      arrival_frame = GetTotalElapsedFrame()
      SetExternalVariable("elv11_state", "landing")
    end
    elv11_state = GetExternalVariable("elv11_state")
    if elv11_state == "landing" then
      if GetTotalElapsedFrame() - arrival_frame < 35 then
        Player().MoveMotion_StandbyMoveMotionSet("slide_end")
        Player().Move_Move2D(120, 3)
        FlagClear(FLAG_GIMMICK_D01_190)
      else
        SetExternalVariable("elv11_state", "end")
      end
    elseif elv11_state == "end" then
      Player().MoveMotion_ResetStandbyMoveMotionSet()
      SetExternalVariable("elv11_state", "Initialize")
      LocatorObject(elv11).DeployLift(true)
    end
    if elv12_state == "slide_start" then
      Player().Motion_PlayMotion("fg10_w01", 5, true)
      LocatorObject(elv12).MoveStartLift(true)
      SetExternalVariable("elv12_state", "sliding")
    elseif elv12_state == "sliding" then
      rotateY = Player().GetRotationY()
      SetFollowerCameraOperateRotationY(rotateY)
    elseif elv12_state == "arrival" then
      Player().Motion_ResetPlayMotion(0)
      arrival_frame = GetTotalElapsedFrame()
      SetExternalVariable("elv12_state", "landing")
    end
    elv12_state = GetExternalVariable("elv12_state")
    if elv12_state == "landing" then
      if GetTotalElapsedFrame() - arrival_frame < 35 then
        Player().MoveMotion_StandbyMoveMotionSet("slide_end")
        Player().Move_Move2D(120, 3)
        FlagClear(FLAG_GIMMICK_D01_190)
      else
        SetExternalVariable("elv12_state", "end")
      end
    elseif elv12_state == "end" then
      Player().MoveMotion_ResetStandbyMoveMotionSet()
      SetExternalVariable("elv12_state", "Initialize")
      LocatorObject(elv12).DeployLift(true)
    end
    if GetExternalVariable("elv_0008") == "move" then
      LocatorObject(elv_0008).MoveStartLift(false)
      SetExternalVariable("elv_0008", "end")
    end
    local lift_state = GetExternalVariable("lift_state")
    local lift_name = GetExternalVariable("lift_name")
    if lift_state ~= "playing_motion" then
      if lift_name == "elv_0001" then
        PlayElevatorMotionWithGear(elv_0001, obj_0004, lift_state)
      elseif lift_name == "elv_0002" then
        PlayElevatorMotionWithGear(elv_0002, obj_0005, lift_state)
      elseif lift_name == "elv_0004" then
        PlayElevatorMotionWithGear(elv_0004, obj_0007, lift_state)
      elseif lift_name == "elv_0005" then
        PlayElevatorMotionWithIceGear(elv_0005, gim_0004, lift_state)
      elseif lift_name == "elv_0006" then
        PlayElevatorMotionWithGear(elv_0006, obj_0008, lift_state)
      elseif lift_name == "elv_0007" then
        PlayElevatorMotionWithGear(elv_0007, obj_0009, lift_state)
      elseif lift_name == "elv_0008" then
        if FlagCheck(FLAG_GIMMICK_D01_250) then
          PlayElevatorMotionWithIceGear(elv_0008, gim_0003, lift_state)
        end
      elseif lift_name == "elv_0009" then
        PlayElevatorMotionWithGear(elv_0009, obj_0006, lift_state)
      end
    end
    local elv_noise = GetExternalVariable("elv_noise")
    if elv_noise == "start" then
      start_frame = GetTotalElapsedFrame()
      SetExternalVariable("elv_noise", "playing")
    elseif elv_noise == "playing" and GetTotalElapsedFrame() - start_frame > 280 then
      StopManageSE(1, 40)
      SetExternalVariable("elv_noise", "Initialize")
      PlaySE(200010, 100)
    end
  elseif gMapNum == 108 then
    PenmonSlide(1, 1, 2, 1)
    PenmonSlide(2, 2, 6, 5)
    PenmonSlide(3, 3, 4, 3)
    PenmonSlide(4, 4, 11, 7)
    PenmonSlide(5, 5, 10, 9)
    PenmonSlide(6, 6, 8, 20)
    PenmonSlide(7, 7, 12, 21)
    PenmonSlide(8, 8, 14, 15)
    PenmonSlide(9, 9, 16, 17)
    PenmonSlide(10, 10, 16, 13)
    PenmonSlide(11, 11, 18, 15)
    PenmonSlide(12, 12, 23, 13)
    PenmonSlide(13, 13, 22, 17)
  elseif gMapNum ~= 109 or FlagCheck(FLAG_FIELD_D01_010) then
  end
end

function OnCheckLocatorLift(gimmick_index, args)
  print("=============== OnCheckLocatorLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== is_forward = ", is_forward, " ======")
  SetExternalVariable("lift_name", elv_name)
  SetExternalVariable("lift_se_state", "initialize")
  SetExternalVariable("move_elv", "moveing")
  gCamY = GetCameraRotationY()
  gCamX = GetCameraRotationX()
  if gMapNum == 101 then
  elseif gMapNum == 102 then
    SetInstantCamera(-70.5, -1.1, 45.9, -61.3, 2.1, 44, DEFAULT_ANGLE, 30)
  elseif gMapNum == 103 then
    if elv_name == "elv_0001" then
      if not FlagCheck(FLAG_GIMMICK_D01_040) then
        if FlagCheck(FLAG_MAIN_18_029E) then
        end
      elseif FlagCheck(FLAG_MAIN_18_029E) then
        CallEventScriptFunction("Prcs_d0103_StopElvMessage")
        SetExternalVariable("move_elv", "stop")
        return false
      end
    elseif elv_name == "elv_0002" then
      if not FlagCheck(FLAG_GIMMICK_D01_020) then
      elseif FlagCheck(FLAG_GIMMICK_D01_060) then
        CallEventScriptFunction("Prcs_d0103_StopElvMessage")
        SetExternalVariable("move_elv", "stop")
        return false
      end
    elseif elv_name == "elv_0003" then
      if not FlagCheck(FLAG_GIMMICK_D01_050) then
        if FlagCheck(FLAG_MAIN_18_029E) then
        end
      elseif FlagCheck(FLAG_MAIN_18_029E) then
        CallEventScriptFunction("Prcs_d0103_StopElvMessage")
        SetExternalVariable("move_elv", "stop")
        return false
      end
    elseif elv_name == "elv_0004" then
      if not FlagCheck(FLAG_GIMMICK_D01_030) then
      else
        CallEventScriptFunction("Prcs_d0103_StopElvMessage")
        SetExternalVariable("move_elv", "stop")
        return false
      end
    elseif elv_name == "elv_0005" then
      if not FlagCheck(FLAG_GIMMICK_D01_100) then
        if FlagCheck(FLAG_MAIN_18_029E) then
        end
      elseif FlagCheck(FLAG_MAIN_18_029E) then
        CallEventScriptFunction("Prcs_d0103_StopElvMessage")
        SetExternalVariable("move_elv", "stop")
        return false
      end
    end
    SetExternalVariable("lift_se_state", "initialize")
    if is_forward == true then
      print("true")
      SetExternalVariable("lift_state", "move_forward")
    else
      print("false")
      SetExternalVariable("lift_state", "move_retreat")
    end
    SetExternalVariable("elv_noise", "start")
  elseif gMapNum == 106 then
    SetInstantCamera(70.9, -1.6, 47.5, 64.4, 2.5, 41.3, DEFAULT_ANGLE, 30)
  elseif gMapNum == 107 then
    SetExternalVariable("lift_se_state", "initialize")
    if is_forward == true then
      print("true")
      SetExternalVariable("lift_state", "move_forward")
    else
      print("false")
      SetExternalVariable("lift_state", "move_retreat")
    end
    if elv_name == "elv_0008" and not FlagCheck(FLAG_GIMMICK_D01_250) then
      CallEventScriptFunction("Prcs_d0107_StuckElvEvent_02")
      SetExternalVariable("move_elv", "stop")
      return false
    end
    SetExternalVariable("elv_noise", "start")
  end
  if GetExternalVariable("lift_se_state") == "initialize" then
    PlaySE(200008, 100)
    PlayAndManageSE(200009, 100, 60, 1, true, true)
  end
end

function CheckMoveStartGimmickLift(gimmick_index, args)
  print("=============== CheckMoveStartGimmickLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  local drive_state = LocatorObject(elv_index).GetSelfObjectScriptExternalVariable("drive_state")
  SetExternalVariable("move_elv", "moveing")
  if gMapNum == 107 and elv_name == "elv_0010" or elv_name == "elv_0011" or elv_name == "elv_0012" then
  else
    SetExternalVariable("elv_cam", "moveing")
  end
  if drive_state == nil then
    return true
  elseif drive_state == "moving" or drive_state == "standby_arrive" then
    print("elevator moving")
    return true
  else
    return false
  end
end

function CheckMoveEndGimmickLift(gimmick_index, args)
  print("=============== CheckMoveEndGimmickLift =====================")
  elv_index, was_forward, is_carry_player = gimmick_index, args.was_forward, args.is_carrying_the_player
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== was_forward = ", was_forward, " ====== is_carry_player =", is_carry_player, "======")
  seplay = GetExternalVariable("mapchange_seplay")
  SetExternalVariable("move_elv", "stop")
  SetExternalVariable("elv_cam", "stop")
  if gMapNum == 107 then
    local elv10 = GetIndex(GIM, "elv_0010")
    local elv11 = GetIndex(GIM, "elv_0011")
    local elv12 = GetIndex(GIM, "elv_0012")
    if elv_name == "elv_0010" then
      if LocatorObject(elv10).IsLiftCarryingThePlayer() == true then
        SetExternalVariable("elv10_state", "arrival")
      end
    elseif elv_name == "elv_0011" then
      if LocatorObject(elv11).IsLiftCarryingThePlayer() == true then
        SetExternalVariable("elv11_state", "arrival")
      end
    elseif elv_name == "elv_0012" and LocatorObject(elv12).IsLiftCarryingThePlayer() == true then
      SetExternalVariable("elv12_state", "arrival")
    end
  elseif gMapNum == 103 then
    if elv_name == "elv_0001" then
      if not FlagCheck(FLAG_GIMMICK_D01_040) and not FlagCheck(FLAG_MAIN_18_055) and FlagCheck(FLAG_MAIN_18_029E) then
        FlagSet(FLAG_GIMMICK_D01_040)
        CallEventScriptFunction("Prcs_d01_ElvStop", elv_name)
      end
    elseif elv_name == "elv_0002" then
      if FlagCheck(FLAG_MAIN_18_040) and not FlagCheck(FLAG_MAIN_18_055) then
        FlagSet(FLAG_GIMMICK_D01_020)
        CallEventScriptFunction("Prcs_d01_ElvStop", elv_name)
      end
    elseif elv_name == "elv_0003" then
      if not FlagCheck(FLAG_GIMMICK_D01_050) and not FlagCheck(FLAG_MAIN_18_055) and FlagCheck(FLAG_MAIN_18_029E) then
        FlagSet(FLAG_GIMMICK_D01_050)
        CallEventScriptFunction("Prcs_d01_ElvStop", elv_name)
      end
    elseif elv_name == "elv_0004" then
      if not FlagCheck(FLAG_GIMMICK_D01_030) and not FlagCheck(FLAG_MAIN_18_055) then
        FlagSet(FLAG_GIMMICK_D01_030)
        CallEventScriptFunction("Prcs_d01_ElvStop", elv_name)
      end
    elseif elv_name == "elv_0005" and not FlagCheck(FLAG_GIMMICK_D01_100) and not FlagCheck(FLAG_MAIN_18_055) and FlagCheck(FLAG_MAIN_18_029E) then
      FlagSet(FLAG_GIMMICK_D01_100)
      CallEventScriptFunction("Prcs_d01_ElvStop", elv_name)
    end
  end
  if seplay ~= "cansel" then
    SetExternalVariable("mapchange_seplay", "Initialize")
  end
  if gMapNum == 107 then
    if elv_name == "elv_0010" or elv_name == "elv_0011" or elv_name == "elv_0012" then
    elseif GetExternalVariable("elv_0008_se") == "stop" then
      SetExternalVariable("elv_0008_se", "initialize")
    else
      PlayAndManageSE(200010, 100, 0, 0, true, true)
      StopManageSE(1, 30)
    end
  else
    PlayAndManageSE(200010, 100, 0, 0, true, true)
    StopManageSE(1, 30)
  end
  if gMapNum == 102 then
    CallEventScriptFunction("M400_060")
  elseif gMapNum == 106 then
    CallEventScriptFunction("M400_055_90")
  end
  ClearInstantCamera(45)
  SetExternalVariable("lift_name", "initialize")
end

function PlayElevatorMotionWithGear(elv_index, gear_index, lift_state)
  LocatorObject(elv_index).Motion_PlayMotionAndSetting("e001", 30, 0, 0, 360, 1, false)
  if lift_state == "move_forward" then
    LocatorObject(gear_index).Motion_PlayMotionAndSetting("e001", 30, 0, 0, 360, 1, false)
  elseif lift_state == "move_retreat" then
    LocatorObject(gear_index).Motion_PlayMotionAndSetting("e002", 30, 0, 0, 360, 1, false)
  end
  SetExternalVariable("lift_state", "playing_motion")
end

function PlayElevatorMotionWithIceGear(elv_index, ice_gear_index, lift_state)
  LocatorObject(elv_index).Motion_PlayMotionAndSetting("e001", 30, 0, 0, 360, 1, false)
  if lift_state == "move_forward" then
    LocatorObject(ice_gear_index).Motion_PlayMotionAndSetting("e002", 30, 0, 0, 360, 1, false)
  elseif lift_state == "move_retreat" then
    LocatorObject(ice_gear_index).Motion_PlayMotionAndSetting("e003", 30, 0, 0, 360, 1, false)
  end
  SetExternalVariable("lift_state", "playing_motion")
end

function PlayElevatorMotion(elv_index, lift_state)
  LocatorObject(elv_index).Motion_PlayMotionAndSetting("e001", 30, 0, 0, 360, 1, false)
  SetExternalVariable("lift_state", "playing_motion")
end

gWork_OnTouchCollision_mpenmons_state = {}

function OnTouchCollision(col_name)
  if gMapNum == 108 then
    local mpenmons_state = gWork_OnTouchCollision_mpenmons_state
    for i = 1, 13 do
      mpenmons_state[i] = GetExternalVariable("mpenmons_state" .. tostring(i))
    end
    if col_name == "evt_0001" then
    elseif col_name == "evt_0002" then
      if mpenmons_state[2] == "init" then
        SetExternalVariable("mpenmons_state2", "start")
      end
    elseif col_name == "evt_0003" then
      if mpenmons_state[3] == "init" then
        SetExternalVariable("mpenmons_state3", "start")
      end
    elseif col_name == "evt_0004" then
    elseif col_name == "evt_0005" then
      if mpenmons_state[5] == "init" then
        SetExternalVariable("mpenmons_state5", "start")
      end
    elseif col_name == "evt_0006" then
      if mpenmons_state[6] == "init" then
        SetExternalVariable("mpenmons_state6", "start")
      end
      if mpenmons_state[7] == "init" then
        SetExternalVariable("mpenmons_state7", "start")
      end
    elseif col_name == "evt_0007" then
      FlagSet(FLAG_GIMMICK_D01_280)
      if mpenmons_state[8] == "init" then
        SetExternalVariable("mpenmons_state8", "start")
      end
      if mpenmons_state[9] == "init" then
        SetExternalVariable("mpenmons_state9", "start")
      end
    elseif col_name == "evt_0008" then
      if mpenmons_state[10] == "init" then
        SetExternalVariable("mpenmons_state10", "start")
      end
      if mpenmons_state[11] == "init" then
        SetExternalVariable("mpenmons_state11", "start")
      end
    elseif col_name == "evt_0009" then
      if mpenmons_state[12] == "init" then
        SetExternalVariable("mpenmons_state12", "start")
      end
      if mpenmons_state[13] == "init" then
        SetExternalVariable("mpenmons_state13", "start")
      end
    end
  end
end

function OnAwayFromCollision(col_name)
end

function TutidaruRolling(enemy_index, state, railname, drop_railname)
  local speed = 10
  local enemy_state = GetExternalVariable(state)
  if enemy_state == "start" then
    SetExternalVariable(state, "rolling")
  elseif enemy_state == "rolling" then
    SymbolEnemy(enemy_index).LinkToRailMove(gRailMoveFile, railname)
    SymbolEnemy(enemy_index).SetRailMoveSpeed(speed)
    SymbolEnemy(enemy_index).SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(2)
    SymbolEnemy(enemy_index).SetRailMoveInDimension2d()
    SymbolEnemy(enemy_index).RailMoveGo()
    if SymbolEnemy(enemy_index).IsArrivalRailBothEnds() == true then
      SymbolEnemy(enemy_index).LinkToRailMove(gRailMoveFile, drop_railname)
      SetExternalVariable(state, "drop")
    end
  elseif enemy_state == "drop" then
    SymbolEnemy(enemy_index).LinkToRailMove(gRailMoveFile, drop_railname)
    SymbolEnemy(enemy_index).SetRailMoveSpeed(speed + 3)
    SymbolEnemy(enemy_index).Physics_SetCollisionContactForNotHit()
    SymbolEnemy(enemy_index).Physics_SetGravity(0)
    SymbolEnemy(enemy_index).SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(2)
    SymbolEnemy(enemy_index).SetRailMoveInDimension3d()
    SymbolEnemy(enemy_index).RailMoveGo()
    if SymbolEnemy(enemy_index).IsArrivalRailBothEnds() == true then
      SymbolEnemy(enemy_index).SymbolForceLeave(true)
      SetExternalVariable(state, "end")
    end
  elseif enemy_state == "end" then
    if SymbolEnemy(enemy_index).Exists() == true then
      SymbolEnemy(enemy_index).SymbolForceLeave(true)
    else
      SetExternalVariable(state, "start")
    end
  end
  local posx, posy, posz = SymbolEnemy(enemy_index).GetPosition()
  if drop_railname == "rail_move_101" or not "rail_move_102" then
  end
  if posy <= 4 then
    SymbolEnemy(enemy_index).SymbolForceLeave(true)
    SetExternalVariable(state, "end")
    goto lbl_177
    if posy <= 15 then
      SymbolEnemy(enemy_index).SymbolForceLeave(true)
      SetExternalVariable(state, "end")
    end
  end
  ::lbl_177::
end

gWork_PenmonSlide_penmons = {}
gWork_PenmonSlide_penmons_state = {}

function PenmonSlide(penmons_index, state_index, railname, railname2)
  local mpenmons = gWork_PenmonSlide_penmons
  local mpenmons_state = gWork_PenmonSlide_penmons_state
  for i = 1, 13 do
    mpenmons[i] = GetIndex(ENEMY, "chr622_slide" .. tostring(i))
    mpenmons_state[i] = GetExternalVariable("mpenmons_state" .. tostring(i))
  end
  if mpenmons_state[state_index] == "start" then
    SymbolEnemy(mpenmons[penmons_index]).MoveMotion_StandbyMoveMotionSet("slide")
    SetExternalVariable("mpenmons_state" .. tostring(state_index), "slide")
  elseif mpenmons_state[state_index] == "slide" then
    SymbolEnemy(mpenmons[penmons_index]).LinkToRailMove(gRailMoveFile, railname2)
    SymbolEnemy(mpenmons[penmons_index]).SetRailMoveInDimension2d()
    SymbolEnemy(mpenmons[penmons_index]).RailMoveGo()
    if SymbolEnemy(mpenmons[penmons_index]).IsArrivalRailBothEnds() == true then
      SymbolEnemy(mpenmons[penmons_index]).LinkToRailMove(gRailMoveFile, railname)
      SetExternalVariable("mpenmons_state" .. tostring(state_index), "run")
    end
  elseif mpenmons_state[state_index] == "run" then
    SymbolEnemy(mpenmons[penmons_index]).Physics_SetCollisionContactForNotHit()
    SymbolEnemy(mpenmons[penmons_index]).Physics_SetGravity(0)
    SymbolEnemy(mpenmons[penmons_index]).SetRailMoveInDimension3d()
    SymbolEnemy(mpenmons[penmons_index]).RailMoveGo()
    if SymbolEnemy(mpenmons[penmons_index]).IsArrivalRailBothEnds() == true then
      SetExternalVariable("mpenmons_state" .. tostring(state_index), "end")
      SymbolEnemy(mpenmons[penmons_index]).Physics_SetCollisionContactForNotHit()
      SymbolEnemy(mpenmons[penmons_index]).Physics_SetGravity(0)
      SymbolEnemy(mpenmons[penmons_index]).SymbolForceLeave(true)
    end
  elseif mpenmons_state[state_index] == "end" then
    SymbolEnemy(mpenmons[penmons_index]).Physics_SetCollisionContactForNotHit()
    SymbolEnemy(mpenmons[penmons_index]).Physics_SetGravity(0)
    SymbolEnemy(mpenmons[penmons_index]).SymbolForceLeave(true)
    if SymbolEnemy(mpenmons[penmons_index]).Exists() == true then
      SymbolEnemy(mpenmons[penmons_index]).SymbolForceLeave(true)
    else
      SetExternalVariable("mpenmons_state" .. tostring(state_index), "start")
      SymbolEnemy(mpenmons[penmons_index]).SymbolForceLeave(true)
    end
  end
end

function OnFieldAttackSymbolEnemy(object_index, args)
  if gMapNum == 101 then
  elseif gMapNum == 104 then
    SymbolEnemy(object_index).SymbolForceLeave(false)
    return REACTION_TO_ATTACK_NO_DAMAGE_BIT + REACTION_TO_ATTACK_NO_ENCOUNT_BIT
  elseif gMapNum == 108 then
    SymbolEnemy(object_index).SymbolForceLeave(false)
    return REACTION_TO_ATTACK_NO_DAMAGE_BIT + REACTION_TO_ATTACK_NO_ENCOUNT_BIT
  end
end

function CheckHazamaGateFound(object_type, object_index, args)
  print("=============== CheckHazamaGateFound object_type = ", object_type, "=====================")
  if object_type == OGIM then
    print("=============== CheckHazamaGateFound GIMMICK_OBJECT_TYPE =====================")
    local name = Gimmick(object_index).GetUniqueName()
    if string.find(name, "hazama_gate") ~= nil then
      local first_discovery = true
      if gMapNum == 103 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H213) then
          FlagSet(FLAG_IS_DISCOVERY_H213)
        end
      elseif gMapNum == 109 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H513) then
          FlagSet(FLAG_IS_DISCOVERY_H513)
        end
      elseif gMapNum == 107 and not FlagCheck(FLAG_IS_DISCOVERY_H813) then
        FlagSet(FLAG_IS_DISCOVERY_H813)
      end
      if not FlagCheck(FLAG_IS_HAZAMA_FIRST_GATE) then
        print("#### FIRST_GATE ####")
        FlagSet(FLAG_IS_HAZAMA_FIRST_GATE)
        HazamaGateFoundFlagSet(args.hazama_gate_found_flag_id)
        CallEventScriptFunction("FirstDiscovery_HazamaGate", object_index)
        first_discovery = false
      else
        print("#### NOT FIRST GATE ####")
        CallEventScriptFunction("AddHazamaMenu", object_index)
      end
      return first_discovery
    end
  end
end
