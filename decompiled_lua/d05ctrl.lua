require("function_control")
DEFINE_FLAG("FLAG_GIMMICK_D05_010")
DEFINE_FLAG("FLAG_GIMMICK_D05_040")
DEFINE_FLAG("FLAG_GIMMICK_D05_400")
DEFINE_FLAG("FLAG_GIMMICK_D05_420")
DEFINE_FLAG("FLAG_GIMMICK_D05_440")
DEFINE_FLAG("FLAG_GIMMICK_D05_460")
DEFINE_FLAG("FLAG_GIMMICK_D05_180")
DEFINE_FLAG("FLAG_MAIN_04_081")
DEFINE_FLAG("FLAG_MAIN_04_082")
DEFINE_FLAG("FLAG_MAIN_04_083")
DEFINE_FLAG("FLAG_MAIN_04_121")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H310")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H311")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H313")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
PlayerMoveCount = 0
ChangeDirCount = 0
chr725_talk_point_x, chr725_talk_point_y, chr725_talk_point_z = 0, 0, 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  if gMapNum == 501 or gMapNum == 502 or gMapNum == 503 or gMapNum == 504 then
    LoadRailMove(gRailMoveFile)
  end
  if gMapNum == 501 then
    local chr728_help = GetIndex(NPC, "chr728_help")
    Npc(chr728_help).LoadMotion("fe02")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    LocatorObject(elv_0003).LoadMotion("e001")
  elseif gMapNum == 502 then
  elseif gMapNum == 503 then
  elseif gMapNum == 504 then
  elseif gMapNum == 505 then
  elseif gMapNum == 506 then
  end
end

function FirstPeriodDeployLift()
  print("=============== FirstPeriodDeployLift =====================")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 501 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local start_loc = GetLastPlayerSetLocator()
    if IsJustAfterMapChangeNow() == true then
      if start_loc == "start_01" or start_loc == "start_02" or start_loc == "start_05" or start_loc == "start_10" or start_loc == "start_11" or start_loc == "start_12" or start_loc == "start_13" then
        LocatorObject(elv_0001).DeployLift(false)
      end
      if start_loc == "start_03" then
        LocatorObject(elv_0004).DeployLift(false)
        SetExternalVariable("move_elv", "moveing")
        DisableEventCollision("wall_cl_0003")
      else
        if FlagCheck(FLAG_MAIN_04_121) then
          LocatorObject(elv_0004).DeployLift(true)
          DisableEventCollision("wall_cl_0003")
        else
          LocatorObject(elv_0004).DeployLift(false)
          LocatorObject(elv_0004).Invisible(0, true)
        end
        if CheckTimeAxis("A2028_daft_200", "A2028_daft_10000") or CheckTimeAxis("P2028_daft_200", "P2028_daft_10000") or CheckTimeAxis("Z2028_daft_200", "Z2028_daft_10000") then
          LocatorObject(elv_0004).DeployLift(false)
          LocatorObject(elv_0004).Invisible(0, true)
          CancelDisableEventCollision("wall_cl_0003")
        end
        if LocatorObject(elv_0004).ExistingLift(true) then
          DisableEventCollision("wall_cl_0003")
        end
      end
      if start_loc == "start_05" then
        LocatorObject(elv_0003).DeployLift(false)
        SetExternalVariable("move_elv", "moveing")
        if not FlagCheck(FLAG_MAIN_04_121) then
          LocatorObject(elv_0004).DeployLift(false)
        end
      end
      if not FlagCheck(FLAG_GIMMICK_D05_040) then
        LocatorObject(elv_0002).DeployLift(true)
      elseif start_loc == "start_02" or start_loc == "start_05" or start_loc == "start_13" or start_loc == "start_50" then
        LocatorObject(elv_0002).DeployLift(true)
      else
        LocatorObject(elv_0002).DeployLift(false)
      end
      if CheckTimeAxis("A2028_daft_200", "A2028_daft_10000") or CheckTimeAxis("P2028_daft_200", "P2028_daft_10000") or CheckTimeAxis("Z2028_daft_200", "Z2028_daft_10000") then
        LocatorObject(elv_0002).DeployLift(true)
      end
      if LocatorObject(elv_0002).ExistingLift(false) then
        DisableEventCollision("wall_cl_8002")
      end
    end
  elseif gMapNum == 503 then
  elseif gMapNum == 504 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if start_loc == "start_01" then
      LocatorObject(elv_0001).DeployLift(false)
    end
  elseif gMapNum == 505 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    if start_loc == "start_00" then
      LocatorObject(elv_0001).DeployLift(false)
    elseif start_loc == "start_01" then
      LocatorObject(elv_0002).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
    LocatorObject(elv_0001).DeployLift(false)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 501 then
    SetExternalVariable("shop_name", "Initialize")
    SetExternalVariable("chr728_help_state", "Initialize")
    chr725_fa_test = GetIndex(GIM, "fa_0001")
    SetExternalVariable("chr725_fa_test_state", "Initialize")
    SetExternalVariable("focus_camera_state", "Initialize")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    local elv_0004 = GetIndex(GIM, "elv_0004")
    local mob_flymekanori_1 = GetIndex(MOB, "mob_flymekanori_1")
    local mob_flymekanori_2 = GetIndex(MOB, "mob_flymekanori_2")
    local mob_flymekanori_3 = GetIndex(MOB, "mob_flymekanori_3")
    Mob(mob_flymekanori_1).LinkToRailMove("d0501_railmove", "rail_move_150")
    Mob(mob_flymekanori_1).SetRailMoveInDimension3d()
    Mob(mob_flymekanori_1).SetRailMoveSpeed(35)
    Mob(mob_flymekanori_1).Invisible(0, false)
    Mob(mob_flymekanori_2).LinkToRailMove("d0501_railmove", "rail_move_151")
    Mob(mob_flymekanori_2).SetRailMoveInDimension3d()
    Mob(mob_flymekanori_2).SetRailMoveSpeed(35)
    Mob(mob_flymekanori_2).Invisible(0, false)
    Mob(mob_flymekanori_3).LinkToRailMove("d0501_railmove", "rail_move_152")
    Mob(mob_flymekanori_3).SetRailMoveInDimension3d()
    Mob(mob_flymekanori_3).SetRailMoveSpeed(35)
    Mob(mob_flymekanori_3).Invisible(0, false)
    SetExternalVariable("mob_flymekanori_1", "Initialize")
    SetExternalVariable("mob_flymekanori_2", "Initialize")
    SetExternalVariable("mob_flymekanori_3", "Initialize")
    if IsJustAfterMapChangeNow() == true then
      if start_loc == "start_03" then
        LocatorObject(elv_0004).MoveStartLift(false)
        LocatorObject(elv_0004).SetSelfObjectScriptExternalVariable("drive_state", "moving")
        LocatorObject(elv_0004).SetSelfObjectScriptExternalVariable("effect_state", "play")
      elseif start_loc == "start_05" then
        SetInstantCamera(-33.02, -76.19, -72.72, -27.8, -69.84, -67.03, DEFAULT_ANGLE, 0, LINEAR)
        LocatorObject(elv_0003).MoveStartLift(false)
        LocatorObject(elv_0003).SetSelfObjectScriptExternalVariable("drive_state", "moving")
        LocatorObject(elv_0003).SetSelfObjectScriptExternalVariable("effect_state", "play")
      end
    end
    local elv_0004 = GetIndex(GIM, "elv_0004")
    if not FlagCheck(FLAG_MAIN_04_121) then
      LocatorObject(elv_0004).Invisible(0, true)
    else
      DisableEventCollision("wall_cl_0003")
    end
    if (CheckTimeAxis("A2028_daft_200", "A2028_daft_10000") or CheckTimeAxis("P2028_daft_200", "P2028_daft_10000") or CheckTimeAxis("Z2028_daft_200", "Z2028_daft_10000")) and LocatorObject(elv_0004).ExistingLift(false) then
      LocatorObject(elv_0004).Invisible(0, true)
      CancelDisableEventCollision("wall_cl_0003")
    end
    if LocatorObject(elv_0004).ExistingLift(true) then
      DisableEventCollision("wall_cl_0003")
    end
    local elv_0002 = GetIndex(GIM, "elv_0002")
    if LocatorObject(elv_0002).ExistingLift(false) then
      DisableEventCollision("wall_cl_8002")
    end
  elseif gMapNum == 502 then
  elseif gMapNum == 503 then
  elseif gMapNum == 504 then
    if IsJustAfterMapChangeNow() == true then
      if start_loc == "start_01" then
        local elv_0001 = GetIndex(GIM, "elv_0001")
        SetInstantCamera(10.05, -14.26, 39.11, 6.32, -9.93, 44.71, DEFAULT_ANGLE, 0, LINEAR)
        LocatorObject(elv_0001).MoveStartLift(false)
        LocatorObject(elv_0001).SetSelfObjectScriptExternalVariable("drive_state", "moving")
        LocatorObject(elv_0001).SetSelfObjectScriptExternalVariable("effect_state", "play")
      end
      SetExternalVariable("chr373_dig_state", "Initialize")
    end
    SetExternalVariable("player_state", "initialize")
  elseif gMapNum == 505 then
    if IsJustAfterMapChangeNow() == true then
      if start_loc == "start_00" then
        local elv_0001 = GetIndex(GIM, "elv_0001")
        SetInstantCamera(4.44, 5.21, 39.47, 8.37, 3, 30.55, DEFAULT_ANGLE, 0, LINEAR)
        LocatorObject(elv_0001).MoveStartLift(false)
        LocatorObject(elv_0001).SetSelfObjectScriptExternalVariable("drive_state", "moving")
        LocatorObject(elv_0001).SetSelfObjectScriptExternalVariable("effect_state", "play")
      elseif start_loc == "start_01" then
        local elv_0002 = GetIndex(GIM, "elv_0002")
        LocatorObject(elv_0002).MoveStartLift(false)
        LocatorObject(elv_0002).SetSelfObjectScriptExternalVariable("drive_state", "moving")
        LocatorObject(elv_0002).SetSelfObjectScriptExternalVariable("effect_state", "play")
      end
    end
    SetExternalVariable("player_state", "initialize")
  end
end

function PreparationBeforeReactionToField()
  if GetExternalVariable("move_elv") == "moveing" then
    DisableMenuInNowFrame()
    DisableAnalyzeAndFieldAttackOnlyThisFrame()
    ProhibitSaveOnlyThisFrame()
  end
end

function Update(elapsed_frame)
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
    Player().Move_Stop()
  end
  if gMapNum == 501 then
    local mob_flymekanori_1 = GetIndex(MOB, "mob_flymekanori_1")
    local mob_flymekanori_2 = GetIndex(MOB, "mob_flymekanori_2")
    local mob_flymekanori_3 = GetIndex(MOB, "mob_flymekanori_3")
    if GetExternalVariable("mob_flymekanori_1") == "go" then
      Mob(mob_flymekanori_1).Physics_SetGravity(0)
      Mob(mob_flymekanori_1).Physics_SetCollisionContactForNotHit()
      Mob(mob_flymekanori_1).RailMoveGo()
    end
    if Mob(mob_flymekanori_1).IsArrivalRailBothEnds() == true then
      Mob(mob_flymekanori_1).Invisible(0, false)
    end
    if GetExternalVariable("mob_flymekanori_2") == "go" then
      Mob(mob_flymekanori_2).Physics_SetGravity(0)
      Mob(mob_flymekanori_2).Physics_SetCollisionContactForNotHit()
      Mob(mob_flymekanori_2).RailMoveGo()
    end
    if Mob(mob_flymekanori_2).IsArrivalRailBothEnds() == true then
      Mob(mob_flymekanori_2).Invisible(0, false)
    end
    if GetExternalVariable("mob_flymekanori_3") == "go" then
      Mob(mob_flymekanori_3).Physics_SetGravity(0)
      Mob(mob_flymekanori_3).Physics_SetCollisionContactForNotHit()
      Mob(mob_flymekanori_3).RailMoveGo()
    end
    if Mob(mob_flymekanori_3).IsArrivalRailBothEnds() == true then
      Mob(mob_flymekanori_3).Invisible(0, false)
    end
    local chr725_fa_test = GetIndex(GIM, "fa_0001")
    local chr725_fa_test_state = GetExternalVariable("chr725_fa_test_state")
    if chr725_fa_test_state == "reaction" then
      LocatorObject(chr725_fa_test).Invisible(0, false)
    end
    local move_elv04_single = GetExternalVariable("move_elv04_single")
    if move_elv04_single == "moveing" then
      local elv_0004 = GetIndex(GIM, "elv_0004")
      local elv_name = LocatorObject(elv_0004).GetLocatorName()
      local drive_state = LocatorObject(elv_0004).GetSelfObjectScriptExternalVariable("drive_state")
      if drive_state == "moving" or drive_state == "standby_arrive" then
        if not LocatorObject(elv_0004).IsMovingLift() then
          LocatorObject(elv_0004).MoveStartLift(true)
        end
      elseif drive_state == "arrived" then
        GetExternalVariable("move_elv04_single", "end")
      end
    end
    local move_elv02_single = GetExternalVariable("move_elv02_single")
    if move_elv02_single == "moveing" then
      local elv_0002 = GetIndex(GIM, "elv_0002")
      local elv_name = LocatorObject(elv_0002).GetLocatorName()
      local drive_state = LocatorObject(elv_0002).GetSelfObjectScriptExternalVariable("drive_state")
      if drive_state == "moving" or drive_state == "standby_arrive" then
        if not LocatorObject(elv_0002).IsMovingLift() then
          LocatorObject(elv_0002).MoveStartLift(false)
        end
      elseif drive_state == "arrived" then
        GetExternalVariable("move_elv02_single", "end")
      end
    end
  elseif gMapNum == 502 then
  elseif gMapNum == 503 then
  elseif gMapNum == 504 then
  elseif gMapNum == 505 then
    local arubura = GetIndex(NPC, "npc_9000")
    Npc(arubura).Physics_SetCollisionContactForNotHit()
  end
end

function OnCheckLocatorLift(gimmick_index, args)
  print("=============== OnCheckLocatorLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  local drive_state = LocatorObject(elv_index).GetSelfObjectScriptExternalVariable("drive_state")
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== is_forward = ", is_forward, " ======")
  PlaySE(200008, 100)
  PlayAndGlobalManageSE(200009, 100, 60, 90, true, true)
  SetExternalVariable("move_elv", "moveing")
  if gMapNum == 501 then
    if elv_name == "elv_0002" then
      if not FlagCheck(FLAG_GIMMICK_D05_040) then
        CallEventScriptFunction("Prcs_d0501_StuckElvEvent_01")
      end
      DisableEventCollision("wall_cl_8002")
    elseif elv_name == "elv_0003" then
      SetInstantCamera(-33.02, -76.19, -72.72, -27.8, -69.84, -67.03, DEFAULT_ANGLE, 45, LINEAR)
    elseif elv_name == "elv_0004" then
    end
  elseif gMapNum == 503 then
    SetInstantCamera(-23.14, 9.17, -39.5, -28.25, 7.66, -47.95, DEFAULT_ANGLE, 45, LINEAR)
    FlagSet(FLAG_GIMMICK_D05_180)
  elseif gMapNum == 505 then
    if elv_name == "elv_0001" then
      SetInstantCamera(4.44, 5.21, 39.47, 8.37, 3, 30.55, DEFAULT_ANGLE, 45, LINEAR)
    elseif elv_name == "elv_0002" and not FlagCheck(FLAG_GIMMICK_D05_010) then
      FlagSet(FLAG_GIMMICK_D05_010)
    end
  end
  LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("drive_state", "start")
  LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("effect_state", "play")
  if is_forward == "true" then
    LocatorObject(elv_index).MoveStartLift(true)
  elseif is_forward == "false" then
    LocatorObject(elv_index).MoveStartLift(false)
  end
end

function CheckMoveStartGimmickLift(gimmick_index, args)
  print("=============== CheckMoveStartGimmickLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  local drive_state = LocatorObject(elv_index).GetSelfObjectScriptExternalVariable("drive_state")
  SetExternalVariable("move_elv", "moveing")
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
  local start_loc = GetLastPlayerSetLocator()
  local drive_state = LocatorObject(elv_index).GetSelfObjectScriptExternalVariable("drive_state")
  StopGlobalManageSE(90, 15)
  SetExternalVariable("play_elavator_se", "initialize")
  if drive_state == "standby_arrive" then
    LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("drive_state", "arrive")
  end
  SetExternalVariable("move_elv", "stop")
  LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("effect_state", "end")
  ClearInstantCamera(45, LINEAR)
  if gMapNum == 503 then
    if start_loc == "start_00" then
      SetFollowerCameraOperateRotation(0, 150)
    end
  elseif gMapNum == 504 then
    if start_loc == "start_01" then
      SetFollowerCameraOperateRotation(0, 10)
    end
  elseif gMapNum == 505 then
    if start_loc == "start_00" then
      SetFollowerCameraOperateRotation(0, 200)
    elseif start_loc == "start_01" then
    end
  end
  if drive_state == nil then
    return true
  elseif drive_state ~= "arrived" then
    return false
  else
    print("elevator arrived")
    return true
  end
end

function OnTouchCollision(col_name)
  if gMapNum == 501 then
    if col_name == "evt_2000" then
      local mob_flymekanori_1 = GetIndex(MOB, "mob_flymekanori_1")
      local mob_flymekanori_2 = GetIndex(MOB, "mob_flymekanori_2")
      local mob_flymekanori_3 = GetIndex(MOB, "mob_flymekanori_3")
      Mob(mob_flymekanori_1).CancelInvisible(0, false, false)
      Mob(mob_flymekanori_2).CancelInvisible(0, false, false)
      Mob(mob_flymekanori_3).CancelInvisible(0, false, false)
      if GetExternalVariable("mob_flymekanori_1") == "Initialize" then
        SetExternalVariable("mob_flymekanori_1", "go")
      end
      if GetExternalVariable("mob_flymekanori_2") == "Initialize" then
        SetExternalVariable("mob_flymekanori_2", "go")
      end
      if GetExternalVariable("mob_flymekanori_3") == "Initialize" then
        SetExternalVariable("mob_flymekanori_3", "go")
      end
    end
    if col_name == "evt_1003" then
      if CheckTimeAxis("A2028_daft_200", "A2028_daft_10000") or CheckTimeAxis("P2028_daft_200", "P2028_daft_10000") or CheckTimeAxis("Z2028_daft_200", "Z2028_daft_10000") then
        local elv_0004 = GetIndex(GIM, "elv_0004")
        if LocatorObject(elv_0004).ExistingLift(true) then
          LocatorObject(elv_0004).SetSelfObjectScriptExternalVariable("drive_state", "start")
          LocatorObject(elv_0004).SetSelfObjectScriptExternalVariable("effect_state", "play")
          SetExternalVariable("move_elv04_single", "moveing")
          CancelDisableEventCollision("wall_cl_0003")
          PlaySE(200008, 100)
          PlayAndGlobalManageSE(200009, 100, 60, 90, true, true)
          CallEventScriptFunction("Prcs_d05FollowerWarp")
        end
      end
    elseif col_name == "evt_1004" and (CheckTimeAxis("A2028_daft_200", "A2028_daft_10000") or CheckTimeAxis("P2028_daft_200", "P2028_daft_10000") or CheckTimeAxis("Z2028_daft_200", "Z2028_daft_10000")) then
      local elv_0002 = GetIndex(GIM, "elv_0002")
      if LocatorObject(elv_0002).ExistingLift(false) then
        LocatorObject(elv_0002).SetSelfObjectScriptExternalVariable("drive_state", "start")
        LocatorObject(elv_0002).SetSelfObjectScriptExternalVariable("effect_state", "play")
        SetExternalVariable("move_elv02_single", "moveing")
        CancelDisableEventCollision("wall_cl_8002")
        PlaySE(200008, 100)
        PlayAndGlobalManageSE(200009, 100, 60, 90, true, true)
        CallEventScriptFunction("Prcs_d05FollowerWarp")
      end
    end
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local is_fa = args.by_field_attack
  if gMapNum == 502 then
    local name = SymbolEnemy(symbol_index).GetUniqueName()
    if (name == "enemy_01" or name == "enemy_02" or name == "enemy_03") and args.by_field_attack then
      if not FlagCheck(FLAG_MAIN_04_083) then
        FlagSet(FLAG_MAIN_04_083)
      elseif not FlagCheck(FLAG_MAIN_04_082) then
        FlagSet(FLAG_MAIN_04_082)
      elseif not FlagCheck(FLAG_MAIN_04_081) then
        FlagSet(FLAG_MAIN_04_081)
        CallEventScriptFunction("Prcs_d0502_M150Event_180BA")
      end
    end
  end
end

function CheckHazamaGateFound(object_type, object_index, args)
  print("=============== CheckHazamaGateFound object_type = ", object_type, "=====================")
  if object_type == OGIM then
    print("=============== CheckHazamaGateFound GIMMICK_OBJECT_TYPE =====================")
    local name = Gimmick(object_index).GetUniqueName()
    if string.find(name, "hazama_gate") ~= nil then
      local first_discovery = true
      if gMapNum == 502 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H310) then
          FlagSet(FLAG_IS_DISCOVERY_H310)
        end
      elseif gMapNum == 501 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H311) then
          FlagSet(FLAG_IS_DISCOVERY_H311)
        end
      elseif gMapNum == 506 and not FlagCheck(FLAG_IS_DISCOVERY_H313) then
        FlagSet(FLAG_IS_DISCOVERY_H313)
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

function OnFieldAttackSymbolEnemy(object_index, args)
  if gMapNum == 501 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    if enemy_name == "berufe_01" or enemy_name == "berufe_02" or enemy_name == "berufe_03" or enemy_name == "berufe_04" then
      local rot = SymbolEnemy(object_index).GetRotationY()
      local pos_x, pos_y, pos_z = SymbolEnemy(object_index).GetPosition()
      PlayEffectScript("ef_b_van_100", pos_x, pos_y, pos_z, rot, 1)
      SymbolEnemy(object_index).SymbolForceLeave(false)
      CallEventScriptFunction("Prcs_440_BerufeFlag")
      return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
    end
  end
end

function OnEncountSymbolEnemy(object_index, args)
  if gMapNum == 501 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    if enemy_name == "berufe_01" or enemy_name == "berufe_02" or enemy_name == "berufe_03" or enemy_name == "berufe_04" then
      return false
    end
  end
end
