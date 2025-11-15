require("function_control")
DEFINE_FLAG("FLAG_FIELD_D0303_010")
DEFINE_FLAG("FLAG_FIELD_D0303_020")
DEFINE_FLAG("FLAG_FIELD_D0303_030")
DEFINE_FLAG("FLAG_FIELD_D0303_040")
DEFINE_FLAG("FLAG_FIELD_D0303_050")
DEFINE_FLAG("FLAG_FIELD_D0303_060")
DEFINE_FLAG("FLAG_FIELD_D0303_070")
DEFINE_FLAG("FLAG_FIELD_D0303_080")
DEFINE_FLAG("FLAG_FIELD_D0303_090")
DEFINE_FLAG("FLAG_FIELD_D0303_100")
DEFINE_FLAG("FLAG_FIELD_D0303_110")
DEFINE_FLAG("FLAG_FIELD_D0303_120")
DEFINE_FLAG("FLAG_FIELD_D0303_130")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H212")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H312")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H416")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
ELV_MOVE_FRAME = 0
APPEAR_FRAME = 0
APPEAR_SPEED = 6
PassCount = 0
ThrustCount = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 301 then
    LoadLocatorModel(gPlanData)
    Player().LoadMoveMotion("")
  elseif gMapNum == 302 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
    Player().LoadMoveMotion("")
  elseif gMapNum == 303 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
    PlayerSystem.PlayerAlwaysLoadMoveMotion("flow")
    PlayerSystem.PlayerAlwaysLoadMotion("fn01_01")
  elseif gMapNum == 304 then
    LoadRailMove(gRailMoveFile)
    LoadLocatorModel(gPlanData)
    LoadEffectScript("ef_f_com_131_sm", 1)
    local pass_skullseadra = GetIndex(NPC, "pass_skullseadra")
    Npc(pass_skullseadra).LoadMoveMotion("move")
    Npc(pass_skullseadra).LoadMotion("f001")
    local rise_skullseadra = GetIndex(NPC, "skullseadra_swim")
    Npc(rise_skullseadra).LoadMoveMotion("move")
    Npc(rise_skullseadra).LoadMotion("f001")
    local pass_skullseadra_2 = GetIndex(NPC, "pass_skullseadra_2")
    Npc(pass_skullseadra_2).LoadMoveMotion("move")
    Npc(pass_skullseadra_2).LoadMotion("f001")
  elseif gMapNum == 305 then
    LoadLocatorModel(gPlanData)
  elseif gMapNum == 306 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elvdoor_1f = GetIndex(GIM, "gim_0001")
    local elvdoor_2f = GetIndex(GIM, "gim_0002")
    LocatorObject(elv_0001).LoadMotion("e001")
    LocatorObject(elv_0001).LoadMotion("e002")
    LocatorObject(elvdoor_1f).LoadMotion("e001")
    LocatorObject(elvdoor_1f).LoadMotion("e002")
    LocatorObject(elvdoor_2f).LoadMotion("e001")
    LocatorObject(elvdoor_2f).LoadMotion("e002")
  end
end

function FirstPeriodDeployLift()
  print("=============== FirstPeriodDeployLift =====================")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 303 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if start_loc == "start_01" then
      LocatorObject(elv_0001).DeployLift(false)
    end
  end
  if gMapNum == 306 then
    if start_loc == "start_03" then
      print("Set elv top")
      local elv = GetIndex(GIM, "elv_0001")
      LocatorObject(elv).DeployLift(false)
    elseif start_loc == "start_00" then
      print("Set elv bottom")
      local elv = GetIndex(GIM, "elv_0001")
      LocatorObject(elv).DeployLift(true)
    end
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("move_motion", "Initialize")
  if gMapNum == 302 then
  elseif gMapNum == 303 then
    local boss_sharkmon = GetIndex(NPC, "boss_sharkmon")
    SetExternalVariable("sharkmon_state", "Initialize")
    Npc(boss_sharkmon).LinkToRailMove("d0303_railmove", 10)
    Npc(boss_sharkmon).SetRailMoveSpeed(6)
    Npc(boss_sharkmon).SetRailMoveInDimension3d()
    SetExternalVariable("elv01_state", "Initialize")
  elseif gMapNum == 304 then
    local pass_skullseadra = GetIndex(NPC, "pass_skullseadra")
    Npc(pass_skullseadra).LinkToRailMove(gRailMoveFile, 20)
    Npc(pass_skullseadra).SetRailMoveInDimension3d()
    local pass_skullseadra_2 = GetIndex(NPC, "pass_skullseadra_2")
    Npc(pass_skullseadra_2).LinkToRailMove(gRailMoveFile, "rail_move_25")
    Npc(pass_skullseadra_2).SetRailMoveInDimension3d()
    local rise_skullseadra = GetIndex(NPC, "skullseadra_swim")
    Npc(rise_skullseadra).LinkToRailMove(gRailMoveFile, 23)
    Npc(rise_skullseadra).SetRailMoveInDimension3d()
  elseif gMapNum == 306 then
    SetExternalVariable("elevator_state", "initialize")
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 302 then
    local chr309_GetFly = GetIndex(NPC, "chr309_GetFly")
    local chr309_GetFly_state = GetExternalVariable("chr309_GetFly_state")
  end
end

function Update(elapsed_frame)
  if gMapNum == 301 or gMapNum == 302 then
    local move_motion = GetExternalVariable("move_motion")
    if move_motion == "change" then
      Player().MoveMotion_StandbyMoveMotionSet("swim")
      Player().Motion_StartMoveMotion(15)
      Player().ShowAttachment(4)
      SetExternalVariable("move_motion", "Initialize")
    elseif move_motion == "reset" then
      Player().MoveMotion_ResetStandbyMoveMotionSet()
      Player().Motion_StartMoveMotion(15)
      Player().HideAttachment(4)
      SetExternalVariable("move_motion", "Initialize")
    end
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
  if GetExternalVariable("enter_shellmonhouse") == "start" then
    Player().Physics_SetCollisionContactForNotHit()
    Player().Physics_SetGravity(0)
  end
  if gMapNum == 302 then
    local chr309_GetFly = GetIndex(NPC, "chr309_GetFly")
    local chr309_GetFly_state = GetExternalVariable("chr309_GetFly_state")
    if chr309_GetFly_state == "initialize" then
      Npc(chr309_GetFly).Move_SetPosition(0, 0, 0)
    elseif chr309_GetFly_state == "flying" then
      Npc(chr309_GetFly).Motion_PlayMotion("f000", 0, false)
      if Npc(chr309_GetFly).IsPlayingMotion("f000") == false then
        SetExternalVariable("chr309_GetFly_state", "standby_move")
      end
    elseif chr309_GetFly_state == "standby_move" then
      Npc(chr309_GetFly).Move_SetPosition(-135, 34, 43)
      SetExternalVariable("chr309_GetFly_state", "move")
    elseif chr309_GetFly_state == "move" then
      Npc(chr309_GetFly).Physics_SetCollisionContactForNotHit()
      Npc(chr309_GetFly).Physics_SetGravity(0)
      Npc(chr309_GetFly).RailMoveGo()
    elseif chr309_GetFly_state == "landing" then
      Npc(chr309_GetFly).Move_SetPosition(-63, 21.34, 40.35)
      Npc(chr309_GetFly).Move_SetRotationY(105, 0)
    end
  elseif gMapNum == 303 then
    local boss_sharkmon = GetIndex(NPC, "boss_sharkmon")
    local marin_index = GetIndex(NPC, "s020_172_002")
    local sharkmon_state = GetExternalVariable("sharkmon_state")
    if sharkmon_state == "start" then
      APPEAR_FRAME = APPEAR_FRAME + elapsed_frame
      Npc(boss_sharkmon).RailMoveGo()
      Npc(boss_sharkmon).Physics_SetCollisionContactForNotHit()
      Npc(boss_sharkmon).Physics_SetGravity(0)
      if APPEAR_FRAME > 90 then
        if APPEAR_SPEED > 0.2 then
          APPEAR_SPEED = APPEAR_SPEED / 1.03
        else
          APPEAR_SPEED = 0.2
        end
        Npc(boss_sharkmon).SetRailMoveSpeed(APPEAR_SPEED)
      else
        Npc(boss_sharkmon).SetRailMoveSpeed(APPEAR_SPEED)
      end
    end
    local elv01 = GetIndex(GIM, "elv_0001")
    local elv01_state = GetExternalVariable("elv01_state")
    local se_start_waterflow = GetExternalVariable("se_start_waterflow")
    if elv01_state == "true" then
      LocatorObject(elv01).MoveStartLift(true)
      Player().MoveMotion_StandbyMoveMotionSet("flow")
      SetExternalVariable("elv01_state", "moving")
      PlayAndManageSE(201002, 100, 30, 0, true, true)
    elseif elv01_state == "false" then
      LocatorObject(elv01).MoveStartLift(false)
      Player().MoveMotion_StandbyMoveMotionSet("flow")
      SetExternalVariable("elv01_state", "moving")
      PlayAndManageSE(201002, 100, 30, 0, true, true)
    elseif elv01_state == "end" then
      Player().MoveMotion_ResetStandbyMoveMotionSet()
      Player().Motion_PlayMotion("fn01_01", 20, true)
      SetExternalVariable("elv01_state", "Initialize")
      StopManageSE(0, 20)
    end
    local ride_submarimon = GetExternalVariable("ride_submarimon")
    local ride_rail = GetExternalVariable("ride_rail")
    local rail_direction = GetExternalVariable("rail_direction")
    local speed = 15
    local speed_LR = 8
    if FlagCheck(FLAG_FIELD_D0303_110) then
      speed = 18
      speed_LR = 3
    else
      speed = 7.5
      speed_LR = 2
    end
    if ride_submarimon == "riding" then
      Player().LinkToRailMove("d0303_railmove", ride_rail)
      Player().SetRailMoveDirection(rail_direction)
      Player().SetRailMoveSpeed(speed)
      if ride_rail == "rail_move_106" then
        Player().Physics_SetCollisionContactForNotHit()
        Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(1)
        Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(1)
      else
        Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
        Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      end
      Player().Physics_SetGravity(0)
      Player().SetRailMoveInDimension3d()
      Player().RailMoveGo()
      Player().EnableRailMoveLeftAxisMoveOperate(speed_LR, true, 60)
      if Player().IsArrivalRailBothEnds() then
        if ride_rail == "rail_move_100" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 89, "FLAG_FIELD_D0303_010")
        elseif ride_rail == "rail_move_101" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 270, "FLAG_FIELD_D0303_020")
        elseif ride_rail == "rail_move_102" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 183, "FLAG_FIELD_D0303_030")
        elseif ride_rail == "rail_move_103" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 3, "FLAG_FIELD_D0303_040")
        elseif ride_rail == "rail_move_104" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 215, "FLAG_FIELD_D0303_050")
        elseif ride_rail == "rail_move_105" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 35, "FLAG_FIELD_D0303_060")
        elseif ride_rail == "rail_move_106" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 252, "FLAG_FIELD_D0303_070")
        elseif ride_rail == "rail_move_107" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 72, "FLAG_FIELD_D0303_080")
        elseif ride_rail == "rail_move_108" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 293, "FLAG_FIELD_D0303_090")
        elseif ride_rail == "rail_move_109" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 113, "FLAG_FIELD_D0303_100")
        elseif ride_rail == "rail_move_110" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 273, "FLAG_FIELD_D0303_120")
        elseif ride_rail == "rail_move_111" then
          CallEventScriptFunction("Prcs_d0303_WaterFlowEnd", 93, "FLAG_FIELD_D0303_130")
        end
      end
    end
    if se_start_waterflow == "start" then
      PlayAndManageSE(201002, 100, 15, 1, false, true)
    elseif se_start_waterflow == "end" then
      StopManageSE(1, 60)
    end
  elseif gMapNum == 304 then
    local pass_skullseadra = GetIndex(NPC, "pass_skullseadra")
    local pass_skullseadra_state = GetExternalVariable("pass_skullseadra_state")
    local pass_skullseadra_speed = 100
    if pass_skullseadra_state == "start" then
      Npc(pass_skullseadra).Motion_PlayMotion("f001", 10, true)
      Npc(pass_skullseadra).DisableCullingInNowFrame()
      Npc(pass_skullseadra).SuspendAutoTransparentForCameraInNowFrame()
      Npc(pass_skullseadra).SuspendAutoTransparentInNowFrame(AUTO_TRANSPARENT_TYPE_ALL)
      Npc(pass_skullseadra).Physics_SetCollisionContactForNotHit()
      Npc(pass_skullseadra).Physics_SetGravity(0)
      Npc(pass_skullseadra).SetRailMoveSpeed(pass_skullseadra_speed)
      Npc(pass_skullseadra).RailMoveGo()
      PassCount = PassCount + elapsed_frame
      if 10 > PassCount then
      elseif 10 <= PassCount and PassCount < 120 then
      else
        Npc(pass_skullseadra).Physics_SetCollisionContactForNotHit()
        Npc(pass_skullseadra).Physics_SetGravity(0)
        Npc(pass_skullseadra).SetRailMoveSpeed(pass_skullseadra_speed)
        Npc(pass_skullseadra).RailMoveGo()
        SetExternalVariable("pass_skullseadra_state", "end")
      end
    elseif pass_skullseadra_state == "end" then
      Npc(pass_skullseadra).DisableCullingInNowFrame()
      Npc(pass_skullseadra).SuspendAutoTransparentForCameraInNowFrame()
      Npc(pass_skullseadra).SuspendAutoTransparentInNowFrame(AUTO_TRANSPARENT_TYPE_ALL)
      Npc(pass_skullseadra).Physics_SetCollisionContactForNotHit()
      Npc(pass_skullseadra).Physics_SetGravity(0)
      Npc(pass_skullseadra).SetRailMoveSpeed(pass_skullseadra_speed)
      Npc(pass_skullseadra).RailMoveGo()
      if Npc(pass_skullseadra).IsArrivalRailBothEnds() then
        Npc(pass_skullseadra).InvisibleInNowFrame(0, 0, true)
      end
    end
    local rise_skullseadra = GetIndex(NPC, "skullseadra_swim")
    local rise_skullseadra_state = GetExternalVariable("rise_skullseadra_state")
    local rise_skullseadra_speed = 100
    if rise_skullseadra_state == "start" then
      Npc(rise_skullseadra).Motion_PlayMotion("f001", 10, true)
      Npc(rise_skullseadra).DisableCullingInNowFrame()
      Npc(rise_skullseadra).SuspendAutoTransparentForCameraInNowFrame()
      Npc(rise_skullseadra).SuspendAutoTransparentInNowFrame(AUTO_TRANSPARENT_TYPE_ALL)
      Npc(rise_skullseadra).Physics_SetCollisionContactForNotHit()
      Npc(rise_skullseadra).Physics_SetGravity(0)
      Npc(rise_skullseadra).SetRailMoveSpeed(rise_skullseadra_speed)
      Npc(rise_skullseadra).RailMoveGo()
      Npc(rise_skullseadra).DisableCullingInNowFrame()
      if Npc(rise_skullseadra).IsArrivalRailBothEnds() then
        Npc(rise_skullseadra).DisableCullingInNowFrame()
        Npc(rise_skullseadra).SuspendAutoTransparentForCameraInNowFrame()
        Npc(rise_skullseadra).SuspendAutoTransparentInNowFrame(AUTO_TRANSPARENT_TYPE_ALL)
        SetExternalVariable("rise_skullseadra_state", "end")
      end
    elseif rise_skullseadra_state == "end" then
      Npc(rise_skullseadra).InvisibleInNowFrame(0, 0, true)
    end
    local pass_skullseadra_2 = GetIndex(NPC, "pass_skullseadra_2")
    local pass_skullseadra_2_state = GetExternalVariable("pass_skullseadra_2_state")
    local pass_skullseadra_2_speed = 100
    if pass_skullseadra_2_state == "start" then
      Npc(pass_skullseadra_2).Motion_PlayMotion("f001", 10, true)
      Npc(pass_skullseadra_2).DisableCullingInNowFrame()
      Npc(pass_skullseadra_2).SuspendAutoTransparentForCameraInNowFrame()
      Npc(pass_skullseadra_2).SuspendAutoTransparentInNowFrame(AUTO_TRANSPARENT_TYPE_ALL)
      Npc(pass_skullseadra_2).Physics_SetCollisionContactForNotHit()
      Npc(pass_skullseadra_2).Physics_SetGravity(0)
      Npc(pass_skullseadra_2).SetRailMoveSpeed(pass_skullseadra_2_speed)
      Npc(pass_skullseadra_2).RailMoveGo()
      if Npc(pass_skullseadra_2).IsArrivalRailBothEnds() then
        Npc(pass_skullseadra_2).DisableCullingInNowFrame()
        Npc(pass_skullseadra_2).SuspendAutoTransparentForCameraInNowFrame()
        Npc(pass_skullseadra_2).SuspendAutoTransparentInNowFrame(AUTO_TRANSPARENT_TYPE_ALL)
        SetExternalVariable("pass_skullseadra_2_state", "end")
      end
    elseif pass_skullseadra_2_state == "end" then
      Npc(pass_skullseadra_2).InvisibleInNowFrame(0, 0, true)
    end
    local ride_submarimon = GetExternalVariable("ride_submarimon")
    local ride_rail = GetExternalVariable("ride_rail")
    local rail_direction = GetExternalVariable("rail_direction")
    if ride_submarimon == "riding" then
      speed = 18
      speed_LR = 3
      Player().LinkToRailMove("d0304_railmove", ride_rail)
      Player().SetRailMoveDirection(rail_direction)
      Player().SetRailMoveSpeed(speed)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().EnableRailMoveLeftAxisMoveOperate(speed_LR, true, 60)
      Player().Physics_SetGravity(0)
      Player().SetRailMoveInDimension3d()
      Player().RailMoveGo()
      if Player().IsArrivalRailBothEnds() then
        if ride_rail == "rail_move_100" then
          if rail_direction == true then
            CallEventScriptFunction("Prcs_d0304_WaterFlowEnd", 0)
          else
            CallEventScriptFunction("Prcs_d0304_WaterFlowEnd", 180)
          end
        end
        if ride_rail == "rail_move_101" then
          if rail_direction == true then
            CallEventScriptFunction("Prcs_d0304_WaterFlowEnd", 150)
          else
            CallEventScriptFunction("Prcs_d0304_WaterFlowEnd", 330)
          end
        end
        if ride_rail == "rail_move_102" then
          if rail_direction == true then
            CallEventScriptFunction("Prcs_d0304_WaterFlowEnd", 195)
          else
            CallEventScriptFunction("Prcs_d0304_WaterFlowEnd", 15)
          end
        end
      end
    end
  elseif gMapNum == 305 then
  elseif gMapNum == 306 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elvdoor_1f = GetIndex(GIM, "gim_0001")
    local elvdoor_2f = GetIndex(GIM, "gim_0002")
    local elevator_state = GetExternalVariable("elevator_state")
    local start_loc = GetLastPlayerSetLocator()
    if elevator_state == "initialize" then
      if start_loc == "start_03" then
        LocatorObject(elv_0001).Motion_PlayMotionAndSetting("e001", 0, 40, 40, 60, 1, false)
        LocatorObject(elvdoor_2f).Motion_PlayMotionAndSetting("e001", 0, 40, 40, 60, 1, false)
        SetExternalVariable("elevator_state", "standby_2f")
      elseif start_loc == "start_00" then
        LocatorObject(elv_0001).Motion_PlayMotionAndSetting("e001", 0, 40, 40, 60, 1, false)
        LocatorObject(elvdoor_1f).Motion_PlayMotionAndSetting("e001", 0, 40, 40, 60, 1, false)
        SetExternalVariable("elevator_state", "standby_1f")
      end
    elseif elevator_state == "opening_1f" then
      LocatorObject(elv_0001).Motion_PlayMotion("e001", 0, false)
      LocatorObject(elvdoor_1f).Motion_PlayMotion("e001", 0, false)
      if LocatorObject(elv_0001).IsPlayingMotion("e001") == false then
        SetExternalVariable("elevator_state", "arrival")
      end
    elseif elevator_state == "closing_1f" then
      LocatorObject(elv_0001).Motion_PlayMotion("e002", 0, false)
      LocatorObject(elvdoor_1f).Motion_PlayMotion("e002", 0, false)
      if LocatorObject(elv_0001).IsPlayingMotion("e002") == false then
        SetExternalVariable("elevator_state", "moving")
      end
    elseif elevator_state == "opening_2f" then
      LocatorObject(elv_0001).Motion_PlayMotion("e001", 0, false)
      LocatorObject(elvdoor_2f).Motion_PlayMotion("e001", 0, false)
      if LocatorObject(elv_0001).IsPlayingMotion("e001") == false then
        SetExternalVariable("elevator_state", "arrival")
      end
    elseif elevator_state == "closing_2f" then
      LocatorObject(elv_0001).Motion_PlayMotion("e002", 0, false)
      LocatorObject(elvdoor_2f).Motion_PlayMotion("e002", 0, false)
      if LocatorObject(elv_0001).IsPlayingMotion("e002") == false then
        SetExternalVariable("elevator_state", "moving")
      end
    end
    local elevator_camera_state = GetExternalVariable("elevator_camera_state")
    if elevator_camera_state == "start_1f" then
      SetInstantCamera(-17.3, 3.5, 3.3, -8.9, 7.7, 6.5, DEFAULT_ANGLE, 30)
      ELV_MOVE_FRAME = ELV_MOVE_FRAME + elapsed_frame
      if ELV_MOVE_FRAME > 127 then
        PlayAndManageSE(200009, 50, 10, 1, true, true)
        ClearInstantCamera(0)
        CameraSwitchChange("railcam_loc_01_01", false)
        SetExternalVariable("elevator_camera_state", "moving_to_2f")
        ELV_MOVE_FRAME = 0
      end
    elseif elevator_camera_state == "start_2f" then
      SetInstantCamera(-15.8, 80.3, 3.5, -8.1, 85.5, 6.9, DEFAULT_ANGLE, 30)
      ELV_MOVE_FRAME = ELV_MOVE_FRAME + elapsed_frame
      if ELV_MOVE_FRAME > 115 then
        PlayAndManageSE(200009, 50, 10, 1, true, true)
        ClearInstantCamera(0)
        CameraSwitchChange("railcam_loc_02_01", false)
        SetExternalVariable("elevator_camera_state", "moving_to_1f")
        ELV_MOVE_FRAME = 0
      end
    elseif elevator_camera_state == "moving_to_1f" or elevator_camera_state == "moving_to_2f" then
      ELV_MOVE_FRAME = ELV_MOVE_FRAME + elapsed_frame
      if ELV_MOVE_FRAME > 178 then
        PlayAndManageSE(200009, 100, 10, 1, true, true)
        if elevator_camera_state == "moving_to_2f" then
          SetExternalVariable("elevator_camera_state", "end_2f")
        else
          SetExternalVariable("elevator_camera_state", "end_1f")
        end
        ELV_MOVE_FRAME = 0
      end
    elseif elevator_camera_state == "end_1f" then
      SetInstantCamera(-17.3, 3.5, 3.3, -8.9, 7.7, 6.5, DEFAULT_ANGLE, 0)
      CameraSwitchChange("railcam_loc_03_01", false)
      ELV_MOVE_FRAME = ELV_MOVE_FRAME + elapsed_frame
      if ELV_MOVE_FRAME > 70 then
        CameraSwitchChange("followcam_default_loc", false)
        SetFollowerCameraOperateRotationY(-90)
        SetFollowerCameraOperateRotationX(0)
        ClearInstantCamera(30)
        SetExternalVariable("elevator_camera_state", "Initialize")
        ELV_MOVE_FRAME = 0
      end
    elseif elevator_camera_state == "end_2f" then
      SetInstantCamera(-15.8, 80.3, 3.5, -8.1, 85.5, 6.9, DEFAULT_ANGLE, 0)
      CameraSwitchChange("railcam_loc_04_01", false)
      ELV_MOVE_FRAME = ELV_MOVE_FRAME + elapsed_frame
      if ELV_MOVE_FRAME > 70 then
        CameraSwitchChange("followcam_default_loc", false)
        SetFollowerCameraOperateRotationX(0)
        SetFollowerCameraOperateRotationY(-90)
        ClearInstantCamera(30)
        SetExternalVariable("elevator_camera_state", "Initialize")
        ELV_MOVE_FRAME = 0
      end
    end
  end
end

function OnCheckLocatorLift(gimmick_index, args)
  print("=============== OnCheckLocatorLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  local elevator_state = GetExternalVariable("elevator_state")
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== is_forward = ", is_forward, " ======")
  PlaySE(200008, 100)
  if elevator_state == "standby_1f" then
    SetExternalVariable("elevator_state", "closing_1f")
    SetExternalVariable("elevator_camera_state", "start_1f")
  elseif elevator_state == "standby_2f" then
    SetExternalVariable("elevator_state", "closing_2f")
    SetExternalVariable("elevator_camera_state", "start_2f")
  end
end

function CheckMoveStartGimmickLift(gimmick_index, args)
  print("=============== CheckMoveStartGimmickLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  PlayAndManageSE(200009, 100, 15, 1, true, true)
  if gMapNum == 306 then
    local elevator_state = GetExternalVariable("elevator_state")
    if elevator_state ~= "moving" then
      return false
    else
      print("elevator moving")
      return true
    end
  end
end

function CheckMoveEndGimmickLift(gimmick_index, args)
  print("=============== CheckMoveEndGimmickLift =====================")
  elv_index, was_forward, is_carry_player = gimmick_index, args.was_forward, args.is_carrying_the_player
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== was_forward = ", was_forward, " ====== is_carry_player =", is_carry_player, "======")
  local elv01_state = GetExternalVariable("elv01_state")
  PlayAndManageSE(200010, 100, 0, 0, true, true)
  StopManageSE(1, 15)
  if gMapNum == 303 and elv01_state == "moving" then
    SetExternalVariable("elv01_state", "end")
  end
  if gMapNum == 306 then
    local elevator_state = GetExternalVariable("elevator_state")
    if elevator_state == "arrival" then
      if was_forward == true then
        SetExternalVariable("elevator_state", "standby_2f")
      else
        SetExternalVariable("elevator_state", "standby_1f")
      end
      return true
    else
      if was_forward == true then
        SetExternalVariable("elevator_state", "opening_2f")
      else
        SetExternalVariable("elevator_state", "opening_1f")
      end
      return false
    end
  end
end

function OnTouchCollision(col_name)
  print("=============== OnTouchCollision =====================")
  if col_name == "evt_9998" then
    CameraSwitchChangeByFile("cam05_railcam", "followcam_default_loc", true)
  end
end

function OnAwayFromCollision(col_name)
  print("=============== OnAwayFromCollision =====================")
  if col_name == "evt_9998" then
    CameraSwitchChange("followcam_default_loc", true)
  end
end

function OnEncountSymbolEnemy(object_index, args)
  if gMapNum == 301 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    local enemy_tag = SymbolEnemy(object_index).GetTag()
    if enemy_tag == "enemy_syako" then
      return REACTION_TO_ENCOUN_FORCE_NORMAL_ENCOUNT
    end
  elseif gMapNum == 303 then
    local se_start_waterflow = GetExternalVariable("se_start_waterflow")
    if se_start_waterflow == "start" then
      SetExternalVariable("se_start_waterflow", "end")
      StopManageSE(1, 60)
    end
    if GetExternalVariable("ride_submarimon") == "riding" and FlagCheck(FLAG_FIELD_D0303_110) then
      local enemy = object_index
      local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
      PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, 0, 1)
      PlayEffectScript("ef_b_van_100", pos_x, pos_y, pos_z, 0, 1)
      SymbolEnemy(enemy).SymbolForceLeave(false)
      return false
    end
  elseif gMapNum == 304 and GetExternalVariable("ride_submarimon") == "riding" then
    local enemy = object_index
    local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
    PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, 0, 1)
    PlayEffectScript("ef_b_van_100", pos_x, pos_y, pos_z, 0, 1)
    SymbolEnemy(enemy).SymbolForceLeave(false)
    return false
  end
end

function CheckHazamaGateFound(object_type, object_index, args)
  print("=============== CheckHazamaGateFound object_type = ", object_type, "=====================")
  if object_type == OGIM then
    print("=============== CheckHazamaGateFound GIMMICK_OBJECT_TYPE =====================")
    local name = Gimmick(object_index).GetUniqueName()
    if string.find(name, "hazama_gate") ~= nil then
      local first_discovery = true
      if gMapNum == 304 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H212) then
          FlagSet(FLAG_IS_DISCOVERY_H212)
        end
      elseif gMapNum == 302 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H312) then
          FlagSet(FLAG_IS_DISCOVERY_H312)
        elseif not FlagCheck(FLAG_IS_DISCOVERY_H416) then
          FlagSet(FLAG_IS_DISCOVERY_H416)
        end
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
