require("function_control")
DEFINE_FLAG("FLAG_MAIN_03_470")
DEFINE_FLAG("FLAG_MAIN_03_475")
DEFINE_FLAG("FLAG_MAIN_03_520")
DEFINE_FLAG("FLAG_MAIN_03_530")
DEFINE_FLAG("FLAG_MAIN_03_522")
DEFINE_FLAG("FLAG_MAIN_03_523")
DEFINE_FLAG("FLAG_MAIN_03_525")
DEFINE_FLAG("FLAG_MAIN_03_540")
DEFINE_FLAG("FLAG_MAIN_13_142")
DEFINE_FLAG("FLAG_MAIN_13_151")
DEFINE_FLAG("FLAG_MAIN_13_143")
DEFINE_FLAG("FLAG_MAIN_13_152")
DEFINE_FLAG("FLAG_MAIN_13_147")
DEFINE_FLAG("FLAG_MAIN_13_148")
DEFINE_FLAG("FLAG_MAIN_13_153")
DEFINE_FLAG("FLAG_MAIN_13_149")
DEFINE_FLAG("FLAG_MAIN_13_154")
DEFINE_FLAG("FLAG_MAIN_22_553")
DEFINE_FLAG("FLAG_MAIN_22_550")
DEFINE_FLAG("FLAG_GIMMICK_D02_010")
DEFINE_FLAG("FLAG_GIMMICK_D02_330")
DEFINE_FLAG("FLAG_GIMMICK_D02_420")
DEFINE_FLAG("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
DEFINE_FLAG("FLAG_IS_CHECK_D0213_DOLL_1")
DEFINE_FLAG("FLAG_IS_CHECK_D0213_DOLL_4")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H511")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H810")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H812")
DEFINE_FLAG("FLAG_SUB_S050_043_005")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
CHR918_TRAIN_STOP_FRAME = 150
gBerufeTimer = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  LoadRailMove(gRailMoveFile)
  if gMapNum == 201 then
    local DigiDoor = GetIndex(GIM, "script_digidoor_151_01")
    LocatorObject(DigiDoor).LoadMotion("e001")
  elseif gMapNum == 202 then
  elseif gMapNum == 204 then
  elseif gMapNum == 205 then
    local townelv00 = GetIndex(GIM, "obj_0001")
    local townelv01 = GetIndex(GIM, "obj_0002")
    LocatorObject(townelv00).LoadMotion("e001")
    LocatorObject(townelv01).LoadMotion("e001")
  end
  if gMapNum == 206 then
    local hagr = GetIndex(NPC, "npc_0005")
    local hagr2 = GetIndex(NPC, "npc_0013")
    Npc(hagr).LoadMotion("bn01")
    Npc(hagr).LoadMotion("br01")
    Npc(hagr2).LoadMotion("bn01")
    Npc(hagr2).LoadMotion("br01")
  end
  if gMapNum == 210 then
  elseif gMapNum == 213 then
    local chr001_hide = GetIndex(NPC, "chr001_hide")
    Npc(chr001_hide).LoadMoveMotion("")
    Npc(chr001_hide).LoadMotion("f000")
    Npc(chr001_hide).LoadMotion("f001")
  end
  if gMapNum == 217 then
  end
end

function FirstPeriodDeployLift()
  print("=============== FirstPeriodDeployLift =====================")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 205 then
    if start_loc == "start_01" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 206 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    if not FlagCheck(FLAG_GIMMICK_D02_420) then
      LocatorObject(elv_0003).DeployLift(false)
    end
    if start_loc == "start_00" then
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    elseif start_loc == "start_01" then
      LocatorObject(elv_0002).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    elseif start_loc == "start_02" then
      LocatorObject(elv_0003).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 207 then
    if start_loc == "start_00" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 208 then
    if start_loc == "start_01" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 209 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local elv_0002 = GetIndex(GIM, "elv_0002")
    local elv_0003 = GetIndex(GIM, "elv_0003")
    if not FlagCheck(FLAG_GIMMICK_D02_330) then
      LocatorObject(elv_0003).DeployLift(false)
      LocatorObject(elv_0001).DeployLift(false)
    end
    if start_loc == "start_00" then
      SetExternalVariable("move_elv", "moveing")
    end
    if FlagCheck(FLAG_GIMMICK_D02_330) and start_loc == "start_00" then
      LocatorObject(elv_0002).DeployLift(false)
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
    if start_loc == "start_01" then
      LocatorObject(elv_0002).DeployLift(true)
      LocatorObject(elv_0003).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  elseif gMapNum == 210 then
    if start_loc == "start_00" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      LocatorObject(elv_0001).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    elseif start_loc == "start_01" then
      local elv_0002 = GetIndex(GIM, "elv_0002")
      LocatorObject(elv_0002).DeployLift(false)
      SetExternalVariable("move_elv", "moveing")
    end
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  local start_loc = GetLastPlayerSetLocator()
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 201 then
    SetExternalVariable("shop_name", "Initialize")
    SetExternalVariable("area_change_event", "Initialize")
    SetExternalVariable("leave_house_1", "init")
    SetExternalVariable("leave_house_1_x", 0)
    SetExternalVariable("leave_house_1_z", 0)
    SetExternalVariable("leave_house_2", "init")
    SetExternalVariable("leave_house_2_x", 0)
    SetExternalVariable("leave_house_2_z", 0)
    SetExternalVariable("leave_house_3", "init")
    SetExternalVariable("leave_house_3_x", 0)
    SetExternalVariable("leave_house_3_z", 0)
    SetExternalVariable("digidoor_state", "close")
    gDoorCount = 0
  elseif gMapNum == 202 then
    local lunamon = GetIndex(NPC, "npc_0013")
    gWaitCount = 0
    SetExternalVariable("luna_state", "initialize")
    SetExternalVariable("Rumer_state", "initialize")
    SetExternalVariable("Rumer_state2", "initialize")
    if FlagCheck(FLAG_MAIN_03_520) and not FlagCheck(FLAG_MAIN_03_523) and not FlagCheck(FLAG_MAIN_03_540) then
      Npc(lunamon).LinkToRailMove("d0202_railmove", "rail_move_300")
      Npc(lunamon).SetRailMoveInDimension2d()
      Npc(lunamon).SetRailMoveDirection(true)
      Npc(lunamon).SetRailMoveSpeed(7)
      SetExternalVariable("luna_state", "move_wait")
    end
    if FlagCheck(FLAG_MAIN_03_520) and FlagCheck(FLAG_MAIN_03_523) and not FlagCheck(FLAG_MAIN_03_540) then
      Npc(lunamon).LinkToRailMove("d0202_railmove", "rail_move_300")
      Npc(lunamon).SetRailMoveInDimension2d()
      Npc(lunamon).SetRailMoveDirection(true)
      Npc(lunamon).SetRailMoveSpeed(7)
      SetExternalVariable("luna_state", "wait_set")
      SetExternalVariable("Rumer_state2", "invisible")
    end
    if FlagCheck(FLAG_MAIN_03_520) and FlagCheck(FLAG_MAIN_03_522) and FlagCheck(FLAG_MAIN_03_525) then
      Npc(lunamon).LinkToRailMove("d0202_railmove", "rail_move_300")
      Npc(lunamon).SetRailMoveInDimension2d()
      Npc(lunamon).SetRailMoveDirection(true)
      Npc(lunamon).SetRailMoveSpeed(7)
      SetExternalVariable("luna_state", "end_set")
      SetExternalVariable("Rumer_state2", "invisible")
    end
    if FlagCheck(FLAG_MAIN_03_520) and FlagCheck(FLAG_MAIN_03_522) and FlagCheck(FLAG_MAIN_03_540) and FlagCheck(FLAG_MAIN_03_530) then
      SetExternalVariable("luna_state", "complete")
      SetExternalVariable("Rumer_state2", "invisible")
    end
    SetExternalVariable("leave_house_1", "init")
    SetExternalVariable("leave_house_1_x", 0)
    SetExternalVariable("leave_house_1_z", 0)
  elseif gMapNum == 204 then
    gBerufeTimer = 0
  elseif gMapNum == 205 then
    SetExternalVariable("townelv00_state", "Initialize")
    SetExternalVariable("townelv01_state", "Initialize")
    if IsJustAfterMapChangeNow() == true and start_loc == "start_01" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      LocatorObject(elv_0001).MoveStartLift(false)
    end
  elseif gMapNum == 206 then
    if IsJustAfterMapChangeNow() == true then
      if start_loc == "start_00" then
        local elv_0001 = GetIndex(GIM, "elv_0001")
        LocatorObject(elv_0001).MoveStartLift(false)
        SetInstantCamera(26.68, 1.49, -10.58, 28.44, 5.82, 0.86, DEFAULT_ANGLE, 0, LINEAR)
      elseif start_loc == "start_01" then
        local elv_0002 = GetIndex(GIM, "elv_0002")
        LocatorObject(elv_0002).MoveStartLift(false)
        SetInstantCamera(0.05, 1.49, -24.01, 0.72, 6.95, -12.51, DEFAULT_ANGLE, 0, LINEAR)
      elseif start_loc == "start_02" then
        local elv_0003 = GetIndex(GIM, "elv_0003")
        SetInstantCamera(-0.48, 3.8, -46.22, -4.68, 6.61, -34.33, DEFAULT_ANGLE, 0, LINEAR)
        LocatorObject(elv_0003).MoveStartLift(false)
      end
    end
    if start_loc == "start_03" then
      SetInstantCamera(-37.64, 3.799, 16.241, -36.06, 8.343, 25.007, DEFAULT_ANGLE, 0, LINEAR)
    end
    SetExternalVariable("hagr_state", "initialize")
    local lunamon = GetIndex(NPC, "npc_0005")
    Npc(lunamon).LinkToRailMove("d0206_railmove", "rail_move_05")
    Npc(lunamon).SetRailMoveInDimension2d()
    Npc(lunamon).SetRailMoveDirection(true)
    Npc(lunamon).SetRailMoveSpeed(3)
  elseif gMapNum == 207 then
    if IsJustAfterMapChangeNow() == true and start_loc == "start_00" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      LocatorObject(elv_0001).MoveStartLift(false)
      SetInstantCamera(-45.99, -0.5, -4.47, -45.99, 8.49, 11.52, DEFAULT_ANGLE, 0, LINEAR)
    end
  elseif gMapNum == 208 then
    if IsJustAfterMapChangeNow() == true and start_loc == "start_01" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      LocatorObject(elv_0001).MoveStartLift(false)
    end
    SetExternalVariable("info_board", 0)
  elseif gMapNum == 209 then
    if IsJustAfterMapChangeNow() == true then
      if start_loc == "start_00" then
        local elv_0001 = GetIndex(GIM, "elv_0001")
        SetInstantCamera(-20.49, 1.49, -2.88, -20.49, 9.46, 13.119, DEFAULT_ANGLE, 0, LINEAR)
        LocatorObject(elv_0001).MoveStartLift(false)
      elseif start_loc == "start_01" then
        local elv_0003 = GetIndex(GIM, "elv_0003")
        SetInstantCamera(14.41, 21.49, -4.87, 14.41, 29.33, 11.12, DEFAULT_ANGLE, 0, LINEAR)
        LocatorObject(elv_0003).MoveStartLift(false)
      end
    end
  elseif gMapNum == 210 then
    if IsJustAfterMapChangeNow() == true then
      if start_loc == "start_00" then
        local elv_0001 = GetIndex(GIM, "elv_0001")
        LocatorObject(elv_0001).MoveStartLift(false)
      elseif start_loc == "start_01" then
        local elv_0002 = GetIndex(GIM, "elv_0002")
        LocatorObject(elv_0002).MoveStartLift(false)
      end
    end
    SetExternalVariable("encounter_state", "initialize")
    SetExternalVariable("player_state", "Initialize")
  elseif gMapNum == 213 then
    SetExternalVariable("chr001_hide_state", "initialize")
  end
  if gMapNum == 217 then
    SetExternalVariable("bear_br_state", "init")
    SetExternalVariable("platinum_state", "initialize")
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if GetExternalVariable("move_elv") == "moveing" then
    DisableMenuInNowFrame()
    DisableAnalyzeAndFieldAttackOnlyThisFrame()
    ProhibitSaveOnlyThisFrame()
  end
  if gMapNum == 201 then
  elseif gMapNum == 202 then
  elseif gMapNum == 204 then
  elseif gMapNum == 206 then
    local hagr2 = GetIndex(NPC, "npc_0013")
    local hagr_state = GetExternalVariable("hagr_state")
    if hagr_state == "move" then
      Npc(hagr2).DisablePlayerCheckInNowFrame()
    end
  end
end

function Update(elapsed_frame)
  local player_state = GetExternalVariable("player_state")
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
  if gMapNum == 201 then
    if FlagCheck(FLAG_MAIN_03_470) and not FlagCheck(FLAG_MAIN_03_475) and not IsRunningVistaEvent() then
      local left_pad_axis_x = GetPadAxis(PAD_AXIS_LEFT_X)
      local left_pad_axis_y = GetPadAxis(PAD_AXIS_LEFT_Y)
      local right_pad_axis_x = GetPadAxis(PAD_AXIS_RIGHT_X)
      local right_pad_axis_y = GetPadAxis(PAD_AXIS_RIGHT_Y)
      SetInstantCameraInNowFrame(-23.715, 5.157, 72.939, -24.079, 2.785, 83.646, 50, 1, 45)
      if left_pad_axis_x ~= 0 or left_pad_axis_y ~= 0 or right_pad_axis_x ~= 0 or right_pad_axis_y ~= 0 then
        FlagSet(FLAG_MAIN_03_475)
      end
    end
    LeaveHouseCamera(18.749, 3.872, -15.382, 17.772, 4.002, -5.431, "start_06", "leave_house_1", "leave_house_1_x", "leave_house_1_z")
    LeaveHouseCamera(-8.275, 3.138, 20.682, -5.153, 3.496, 30.176, "start_02", "leave_house_2", "leave_house_2_x", "leave_house_2_z")
    LeaveHouseCamera(9.097, 11.68, -27.219, 9.183, 11.933, -17.223, "start_03", "leave_house_3", "leave_house_3_x", "leave_house_3_z")
    if player_state == "shopping" then
      local shop_name = GetExternalVariable("shop_name")
      local dist_adjust = GetExternalVariable("shop_dist_adjust")
      MoveToNpc(shop_name, dist_adjust)
    end
    local link_event = GetExternalVariable("area_change_event")
    if link_event == "start" then
      start_frame = GetTotalElapsedFrame()
      SetExternalVariable("area_change_event", "move")
      Player().LinkToRailMove(gRailMoveFile, 5)
      Player().SetRailMoveInDimension3d()
      Player().SetRailMoveSpeed(7.5)
    elseif link_event == "move" then
      Player().Move_Move2DToTarget(-23.5, -56.3, 6)
      SetInstantCamera(-40.5, -2.4, -68.7, -33.5, 0.6, -66.1, DEFAULT_ANGLE, 140)
      if 45 < GetTotalElapsedFrame() - start_frame then
        SetExternalVariable("area_change_event", "warp")
      end
    elseif link_event == "warp" then
      Player().RailMoveGo()
      Player().Physics_SetGravity(0)
      Player().Move_SetPosition(-31.9, -6.9, -65)
      SetExternalVariable("area_change_event", "rail_move")
    elseif link_event == "rail_move" then
      Player().RailMoveGo()
    end
    local DigiDoor = GetIndex(GIM, "script_digidoor_151_01")
    local DigiDoorMob = GetIndex(MOB, "EnterDigiDoor_151_01")
    local DigiDoorMob2 = GetIndex(MOB, "mob010")
    local door_pos_x, door_pos_y, door_pos_z = LocatorObject(DigiDoor).GetPosition()
    local mob_pos_x, mob_pos_y, mob_pos_z = GetPositionAnyObject(MOB, DigiDoorMob)
    local mob2_pos_x, mob2_pos_y, mob2_pos_z = GetPositionAnyObject(MOB, DigiDoorMob2)
    local distance = GetDistanceBetweenTwoObject2D(door_pos_x, door_pos_z, mob_pos_x, mob_pos_z)
    local distance2 = GetDistanceBetweenTwoObject2D(door_pos_x, door_pos_z, mob2_pos_x, mob2_pos_z)
    local digidoor_state = GetExternalVariable("digidoor_state")
    if digidoor_state == "action" then
      gDoorCount = gDoorCount + elapsed_frame
      if gDoorCount <= 120 then
        LocatorObject(DigiDoor).Motion_PlayMotion("e001", 10, true)
      else
        SetExternalVariable("digidoor_state", "close")
        gDoorCount = 0
        LocatorObject(DigiDoor).Motion_ResetPlayMotion(10)
      end
    elseif digidoor_state == "close" then
      gDoorCount = gDoorCount + elapsed_frame
      if 5 <= gDoorCount and (distance <= 2 or distance2 <= 2) then
        SetExternalVariable("digidoor_state", "action")
        gDoorCount = 0
      end
    end
    if FlagCheck(FLAG_MAIN_13_142) and not FlagCheck(FLAG_MAIN_13_151) then
      local tagrun01_state = GetExternalVariable("tagrun01_state")
      if tagrun01_state == "run" then
        local knightmon = GetIndex(MOB, "m350_0001")
        local syautomon = GetIndex(MOB, "m350_0002")
        local toyagumon = GetIndex(MOB, "m350_0007")
        local speed = 7
        local speed01 = 6.7
        Mob(knightmon).LinkToRailMove("d0201_railmove", "rail_move_30")
        Mob(knightmon).Physics_SetCollisionContactForNotHit()
        Mob(knightmon).Physics_SetGravity(0)
        Mob(knightmon).SetRailMoveSpeed(speed)
        Mob(knightmon).SetRailMoveInDimension3d()
        Mob(knightmon).RailMoveGo()
        Mob(syautomon).LinkToRailMove("d0201_railmove", "rail_move_29")
        Mob(syautomon).Physics_SetCollisionContactForNotHit()
        Mob(syautomon).Physics_SetGravity(0)
        Mob(syautomon).SetRailMoveSpeed(speed)
        Mob(syautomon).SetRailMoveInDimension3d()
        Mob(syautomon).RailMoveGo()
        Mob(toyagumon).LinkToRailMove("d0201_railmove", "rail_move_29")
        Mob(toyagumon).Physics_SetCollisionContactForNotHit()
        Mob(toyagumon).Physics_SetGravity(0)
        Mob(toyagumon).SetRailMoveSpeed(speed01)
        Mob(toyagumon).SetRailMoveInDimension3d()
        Mob(toyagumon).RailMoveGo()
        if Mob(knightmon).IsArrivalRailBothEnds() and Mob(syautomon).IsArrivalRailBothEnds() and Mob(toyagumon).IsArrivalRailBothEnds() then
          SetExternalVariable("tagrun01_state", "end")
          FlagSet(FLAG_MAIN_13_151)
        end
      elseif tagrun01_state == "end" then
        local knightmon = GetIndex(MOB, "m350_0001")
        local syautomon = GetIndex(MOB, "m350_0002")
        Mob(knightmon).InvisibleInNowFrame(0, 0, true)
        Mob(syautomon).InvisibleInNowFrame(0, 0, true)
        FlagSet(FLAG_MAIN_13_151)
      end
    end
    if FlagCheck(FLAG_MAIN_13_143) and not FlagCheck(FLAG_MAIN_13_152) then
      local tagrun02_state = GetExternalVariable("tagrun02_state")
      if tagrun02_state == "run2" then
        local pandamon = GetIndex(MOB, "m350_0003")
        local starmon = GetIndex(MOB, "m350_0004")
        local speed = 8
        Mob(pandamon).LinkToRailMove("d0201_railmove", "rail_move_31")
        Mob(pandamon).Physics_SetCollisionContactForNotHit()
        Mob(pandamon).Physics_SetGravity(0)
        Mob(pandamon).SetRailMoveSpeed(speed)
        Mob(pandamon).SetRailMoveInDimension3d()
        Mob(pandamon).RailMoveGo()
        Mob(starmon).LinkToRailMove("d0201_railmove", "rail_move_32")
        Mob(starmon).Physics_SetCollisionContactForNotHit()
        Mob(starmon).Physics_SetGravity(0)
        Mob(starmon).SetRailMoveSpeed(speed)
        Mob(starmon).SetRailMoveInDimension3d()
        Mob(starmon).RailMoveGo()
        if Mob(pandamon).IsArrivalRailBothEnds() and Mob(starmon).IsArrivalRailBothEnds() then
          SetExternalVariable("tagrun02_state", "end")
          FlagSet(FLAG_MAIN_13_152)
        end
      elseif tagrun02_state == "end" then
        FlagSet(FLAG_MAIN_13_152)
        local pandamon = GetIndex(MOB, "m350_0003")
        local starmon = GetIndex(MOB, "m350_0004")
        Mob(pandamon).InvisibleInNowFrame(0, 0, true)
        Mob(starmon).InvisibleInNowFrame(0, 0, true)
      end
    end
    if FlagCheck(FLAG_MAIN_13_147) and not FlagCheck(FLAG_MAIN_13_148) then
      local tagrun03_state = GetExternalVariable("tagrun03_state")
      if tagrun03_state == "run3" then
        local fanbimon = GetIndex(NPC, "npc_773")
        local raramon = GetIndex(NPC, "npc_774")
        local speed = 8
        Npc(raramon).LinkToRailMove("d0201_railmove", "rail_move_35")
        Npc(raramon).Physics_SetCollisionContactForNotHit()
        Npc(raramon).Physics_SetGravity(0)
        Npc(raramon).SetRailMoveSpeed(speed)
        Npc(raramon).SetRailMoveInDimension3d()
        Npc(raramon).RailMoveGo()
        if Npc(fanbimon).IsArrivalRailBothEnds() and Npc(raramon).IsArrivalRailBothEnds() then
          SetExternalVariable("tagrun03_state", "end")
          FlagSet(FLAG_MAIN_13_153)
        end
        if not Npc(fanbimon).IsArrivalRailBothEnds() then
          Npc(fanbimon).LinkToRailMove("d0201_railmove", "rail_move_34")
          Npc(fanbimon).Physics_SetCollisionContactForNotHit()
          Npc(fanbimon).Physics_SetGravity(0)
          Npc(fanbimon).SetRailMoveSpeed(speed)
          Npc(fanbimon).SetRailMoveInDimension3d()
          Npc(fanbimon).RailMoveGo()
        end
      elseif tagrun02_state == "end" then
        local fa_bn02 = Motion.Object:new(NPC, "npc_773", "bn02")
        local ra_bn02 = Motion.Object:new(NPC, "npc_774", "bn02")
        Npc(fanbimon).InvisibleInNowFrame(0, 0, true)
        Npc(raramon).InvisibleInNowFrame(0, 0, true)
      end
    end
  elseif gMapNum == 202 then
    LeaveHouseCamera(45.432, 1.436, -4.557, 37.338, 1.405, 1.315, "start_01", "leave_house_1", "leave_house_1_x", "leave_house_1_z")
    local R_lunamon = GetIndex(RUMOR, "guide_lunamon")
    local R_lunamon2 = GetIndex(RUMOR, "guide_lunamon2")
    local lunamon = GetIndex(NPC, "npc_0013")
    local luna_state = GetExternalVariable("luna_state")
    local Rumer_state = GetExternalVariable("Rumer_state")
    local Rumer_state2 = GetExternalVariable("Rumer_state2")
    if FlagCheck(FLAG_MAIN_03_520) and not FlagCheck(FLAG_MAIN_03_530) then
      if luna_state == "move_wait" then
        Npc(lunamon).Move_SetPosition(15.662, 0, -8.174)
        Npc(lunamon).SetRailMoveSpeed(7)
        SetExternalVariable("luna_state", "wait_start")
        RumorNpc(R_lunamon).Move_SetPosition(15.662, 1, -8.174)
        Ctrl_TextRumor(1, lunamon, R_lunamon, R_lunamon2)
      end
      if luna_state == "wait_start" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local player_x, player_y, player_z = GetPositionAnyObject(PLAYER, 1)
        local distance = GetDistanceToObject(NPC, lunamon)
        local y_degree = GetAngleToTarget2D(luna_pos_x, luna_pos_z, player_x, player_z)
        Npc(lunamon).LinkToRailMove("d0202_railmove", "rail_move_300")
        Npc(lunamon).Move_SetRotationY(y_degree, 10)
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).SetRailMoveSpeed(7)
        Npc(lunamon).Motion_PlayMotion("e004", 10, true)
        Ctrl_TextRumor(1, lunamon, R_lunamon, R_lunamon2)
        if distance <= 6 then
          SetExternalVariable("luna_state", "move_point1")
          RumorNpc(R_lunamon).Move_SetPosition(10.838, 1, -8.226)
        end
      end
      if luna_state == "move_point1" then
        FlagSet(FLAG_MAIN_03_523)
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local point1_pos_x, point1_pos_y, point1_pos_z = GetRailPointPos(gRailMoveFile, "rail_marker_300")
        local distance = GetDistanceBetweenTwoObject2D(luna_pos_x, luna_pos_z, point1_pos_x, point1_pos_z)
        Npc(lunamon).Physics_SetCollisionContactForMapOnly()
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).SetRailMoveSpeed(7)
        Npc(lunamon).RailMoveGo()
        Ctrl_TextRumor(0, lunamon, R_lunamon, R_lunamon2)
        if distance <= 4 then
          SetExternalVariable("luna_state", "wait_point1")
        end
      end
      if luna_state == "wait_point1" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local player_x, player_y, player_z = GetPositionAnyObject(PLAYER, 1)
        local distance = GetDistanceToObject(NPC, lunamon)
        local y_degree = GetAngleToTarget2D(luna_pos_x, luna_pos_z, player_x, player_z)
        Npc(lunamon).Move_SetRotationY(y_degree, 10)
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).Motion_PlayMotion("e004", 10, true)
        gWaitCount = gWaitCount + elapsed_frame
        if gWaitCount >= 60 then
          Ctrl_TextRumor(1, lunamon, R_lunamon, R_lunamon2)
        end
        if distance <= 4 then
          SetExternalVariable("luna_state", "move_point2")
          RumorNpc(R_lunamon).Move_SetPosition(-2.889, 3, -8.479)
          gWaitCount = 0
        end
      end
      if luna_state == "move_point2" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local point1_pos_x, point1_pos_y, point1_pos_z = GetRailPointPos(gRailMoveFile, "rail_marker_301")
        local distance = GetDistanceBetweenTwoObject2D(luna_pos_x, luna_pos_z, point1_pos_x, point1_pos_z)
        Npc(lunamon).Physics_SetCollisionContactForMapOnly()
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).SetRailMoveSpeed(7)
        Npc(lunamon).RailMoveGo()
        Ctrl_TextRumor(0, lunamon, R_lunamon, R_lunamon2)
        if distance <= 4 then
          SetExternalVariable("luna_state", "wait_point2")
        end
      end
      if luna_state == "wait_point2" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local player_x, player_y, player_z = GetPositionAnyObject(PLAYER, 1)
        local distance = GetDistanceToObject(NPC, lunamon)
        local y_degree = GetAngleToTarget2D(luna_pos_x, luna_pos_z, player_x, player_z)
        Npc(lunamon).Move_SetRotationY(y_degree, 10)
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).Motion_PlayMotion("e004", 10, true)
        gWaitCount = gWaitCount + elapsed_frame
        if gWaitCount >= 60 then
          Ctrl_TextRumor(1, lunamon, R_lunamon, R_lunamon2)
        end
        if distance <= 4 then
          SetExternalVariable("luna_state", "move_point3")
          RumorNpc(R_lunamon).Move_SetPosition(-29.133, 3, -0.143)
          gWaitCount = 0
        end
      end
      if luna_state == "move_point3" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local point1_pos_x, point1_pos_y, point1_pos_z = GetRailPointPos(gRailMoveFile, "rail_marker_303")
        local distance = GetDistanceBetweenTwoObject2D(luna_pos_x, luna_pos_z, point1_pos_x, point1_pos_z)
        Npc(lunamon).Physics_SetCollisionContactForMapOnly()
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).SetRailMoveSpeed(7)
        Npc(lunamon).RailMoveGo()
        Ctrl_TextRumor(0, lunamon, R_lunamon, R_lunamon2)
        if distance <= 1 then
          SetExternalVariable("luna_state", "wait_point3")
        end
      end
      if luna_state == "wait_point3" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local player_x, player_y, player_z = GetPositionAnyObject(PLAYER, 1)
        local distance = GetDistanceToObject(NPC, lunamon)
        local y_degree = GetAngleToTarget2D(luna_pos_x, luna_pos_z, player_x, player_z)
        Npc(lunamon).Move_SetRotationY(y_degree, 10)
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).Motion_PlayMotion("e004", 10, true)
        gWaitCount = gWaitCount + elapsed_frame
        if gWaitCount >= 60 then
          Ctrl_TextRumor(1, lunamon, R_lunamon, R_lunamon2)
        end
        if distance <= 3 then
          SetExternalVariable("luna_state", "wait_set")
          RumorNpc(R_lunamon).Move_SetPosition(10.838, 1, -8.226)
          gWaitCount = 0
        end
      end
      if luna_state == "wait_set" then
        local mark_x, mark_y, mark_z = GetRailPointPos("d0202_railmove", "rail_marker_303")
        Npc(lunamon).Move_SetPosition(mark_x, mark_y, mark_z)
        Npc(lunamon).SetEnablePlayerCheck(false)
        SetExternalVariable("luna_state", "wait")
        Ctrl_TextRumor(0, lunamon, R_lunamon, R_lunamon2)
        RumorNpc(R_lunamon2).Move_SetPosition(-29.669, 2, 0.265)
      end
      if luna_state == "wait" then
        FlagSet(FLAG_MAIN_03_522)
        local hagr = GetIndex(NPC, "npc_0015")
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local hagr_pos_x, hagr_pos_y, hagr_pos_z = GetPositionAnyObject(NPC, hagr)
        local y_degree = GetAngleToTarget2D(luna_pos_x, luna_pos_z, hagr_pos_x, hagr_pos_z)
        Npc(lunamon).Move_SetRotationY(y_degree, 10)
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).Motion_PlayMotion("e004", 10, true)
        gWaitCount = gWaitCount + elapsed_frame
        if gWaitCount >= 60 then
          Ctrl_TextRumor(2, lunamon, R_lunamon, R_lunamon2)
        end
      end
      if luna_state == "move_point4" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local point1_pos_x, point1_pos_y, point1_pos_z = GetRailPointPos(gRailMoveFile, "rail_marker_302")
        local distance = GetDistanceBetweenTwoObject2D(luna_pos_x, luna_pos_z, point1_pos_x, point1_pos_z)
        Npc(lunamon).Physics_SetCollisionContactForMapOnly()
        Npc(lunamon).SetRailMoveDirection(true)
        Npc(lunamon).SetEnablePlayerCheck(false)
        Npc(lunamon).SetRailMoveSpeed(7)
        Npc(lunamon).RailMoveGo()
        Ctrl_TextRumor(0, lunamon, R_lunamon, R_lunamon2)
        if distance <= 1 then
          SetExternalVariable("luna_state", "move_last")
          RumorNpc(R_lunamon2).Move_SetPosition(-30.046, 1, 20.304)
          gWaitCount = 0
        end
      end
      if luna_state == "move_last" then
        Npc(lunamon).SetRailMoveSpeed(7)
        Npc(lunamon).Physics_SetCollisionContactForMapOnly()
        Npc(lunamon).RailMoveGo()
        Npc(lunamon).SetEnablePlayerCheck(false)
        if Npc(lunamon).IsArrivalRailBothEnds() then
          SetExternalVariable("luna_state", "end")
          SetExternalVariable("Rumer_state2", "invisible")
        end
        Ctrl_TextRumor(0, lunamon, R_lunamon, R_lunamon2)
      end
      if luna_state == "end_set" then
        local rail_x, rail_y, rail_z = GetRailEndPos("d0202_railmove", "rail_move_300")
        Npc(lunamon).Move_SetPosition(rail_x, rail_y, rail_z)
        Npc(lunamon).SetEnablePlayerCheck(false)
        SetExternalVariable("luna_state", "end")
        Ctrl_TextRumor(2, lunamon, R_lunamon, R_lunamon2)
      end
      if luna_state == "end" then
        Npc(lunamon).SetEnablePlayerCheck(false)
        FlagSet(FLAG_MAIN_03_540)
        gWaitCount = gWaitCount + elapsed_frame
        if gWaitCount >= 60 then
          Ctrl_TextRumor(2, lunamon, R_lunamon, R_lunamon2)
        end
      end
      if luna_state == "end" then
        local luna_pos_x, luna_pos_y, luna_pos_z = GetPositionAnyObject(NPC, lunamon)
        local player_x, player_y, player_z = GetPositionAnyObject(PLAYER, 1)
        local y_degree = GetAngleToTarget2D(luna_pos_x, luna_pos_z, player_x, player_z)
        Npc(lunamon).Move_SetRotationY(y_degree, 10)
        Npc(lunamon).Motion_PlayMotion("e004", 10, true)
        Ctrl_TextRumor(2, lunamon, R_lunamon, R_lunamon2)
      end
    end
    local pegas_state = GetExternalVariable("pegas_state")
    if pegas_state == "start_move" then
      Player().LinkToRailMove("d0202_railmove", "rail_move_900")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().SetRailMoveInDimension3d()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().RailMoveGo()
      PlayAndManageSE(211010, 100, 0.5, 1, false, true)
    elseif pegas_state == "start_arrival" then
      Player().LinkToRailMove("d0202_railmove", "rail_move_901")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().SetRailMoveInDimension2d()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().RailMoveGo()
      PlayAndManageSE(211010, 100, 0.5, 1, false, true)
      if Player().IsArrivalRailBothEnds() then
        SetExternalVariable("pegas_state", "stop")
        CallEventScriptFunction("Prcs_d0202_ride_pegasmon_end")
        StopManageSE(1, 1)
      end
    end
    if FlagCheck(FLAG_MAIN_13_149) and not FlagCheck(FLAG_MAIN_13_154) then
      local memberrun01_state = GetExternalVariable("memberrun01_state")
      if memberrun01_state == "run4" then
        local knightmon = GetIndex(MOB, "m350_0001")
        local syautomon = GetIndex(MOB, "m350_0002")
        local pandamon = GetIndex(MOB, "m350_0003")
        local starmon = GetIndex(MOB, "m350_0004")
        local toyagmon = GetIndex(MOB, "m350_0005")
        local speed = 8
        Mob(knightmon).LinkToRailMove("d0202_railmove", "rail_move_30")
        Mob(knightmon).Physics_SetCollisionContactForNotHit()
        Mob(knightmon).Physics_SetGravity(0)
        Mob(knightmon).SetRailMoveSpeed(speed)
        Mob(knightmon).SetRailMoveInDimension3d()
        Mob(knightmon).RailMoveGo()
        Mob(syautomon).LinkToRailMove("d0202_railmove", "rail_move_31")
        Mob(syautomon).Physics_SetCollisionContactForNotHit()
        Mob(syautomon).Physics_SetGravity(0)
        Mob(syautomon).SetRailMoveSpeed(speed)
        Mob(syautomon).SetRailMoveInDimension3d()
        Mob(syautomon).RailMoveGo()
        Mob(pandamon).LinkToRailMove("d0202_railmove", "rail_move_32")
        Mob(pandamon).Physics_SetCollisionContactForNotHit()
        Mob(pandamon).Physics_SetGravity(0)
        Mob(pandamon).SetRailMoveSpeed(speed)
        Mob(pandamon).SetRailMoveInDimension3d()
        Mob(pandamon).RailMoveGo()
        Mob(starmon).LinkToRailMove("d0202_railmove", "rail_move_33")
        Mob(starmon).Physics_SetCollisionContactForNotHit()
        Mob(starmon).Physics_SetGravity(0)
        Mob(starmon).SetRailMoveSpeed(speed)
        Mob(starmon).SetRailMoveInDimension3d()
        Mob(starmon).RailMoveGo()
        Mob(toyagmon).LinkToRailMove("d0202_railmove", "rail_move_34")
        Mob(toyagmon).Physics_SetCollisionContactForNotHit()
        Mob(toyagmon).Physics_SetGravity(0)
        Mob(toyagmon).SetRailMoveSpeed(speed)
        Mob(toyagmon).SetRailMoveInDimension3d()
        Mob(toyagmon).RailMoveGo()
        if Mob(knightmon).IsArrivalRailBothEnds() and Mob(syautomon).IsArrivalRailBothEnds() and Mob(pandamon).IsArrivalRailBothEnds() and Mob(starmon).IsArrivalRailBothEnds() then
          SetExternalVariable("memberrun01_state", "end")
        end
      elseif memberrun01_state == "end" then
        local knightmon = GetIndex(MOB, "m350_0001")
        local syautomon = GetIndex(MOB, "m350_0002")
        local pandamon = GetIndex(MOB, "m350_0003")
        local starmon = GetIndex(MOB, "m350_0004")
        local toyagmon = GetIndex(MOB, "m350_0005")
        Mob(knightmon).Invisible(5, true)
        Mob(syautomon).Invisible(5, true)
        Mob(pandamon).Invisible(5, true)
        Mob(starmon).Invisible(10, true)
        Mob(toyagmon).Invisible(10, true)
        FlagSet(FLAG_MAIN_13_154)
      end
    end
  elseif gMapNum == 204 then
    if FlagCheck(FLAG_MAIN_22_553) and not FlagCheck(FLAG_MAIN_22_550) then
      local berufe_state = GetExternalVariable("berufe_state")
      local berufemon = GetIndex(NPC, "npc_904")
      local speed = 30
      Npc(berufemon).Move_SetRotationY(180, 0)
      if berufe_state == "move" then
        Npc(berufemon).LinkToRailMove("d0204_railmove", "rail_move_200")
        Npc(berufemon).Physics_SetCollisionContactForNotHit()
        Npc(berufemon).Physics_SetGravity(0)
        Npc(berufemon).SetRailMoveSpeed(speed)
        Npc(berufemon).SetRailMoveInDimension3d()
        Npc(berufemon).RailMoveGo()
        if Npc(berufemon).IsArrivalRailBothEnds() then
          SetExternalVariable("berufe_state", "end_01")
          Npc(berufemon).LinkToRailMove("d0204_railmove", "rail_move_201")
        end
      elseif berufe_state == "end_01" then
        gBerufeTimer = gBerufeTimer + elapsed_frame
        if 10 <= gBerufeTimer then
          SetExternalVariable("berufe_state", "move_02")
        end
      elseif berufe_state == "move_02" then
        speed = 25
        Npc(berufemon).LinkToRailMove("d0204_railmove", "rail_move_201")
        Npc(berufemon).Physics_SetCollisionContactForNotHit()
        Npc(berufemon).Physics_SetGravity(0)
        Npc(berufemon).SetRailMoveSpeed(speed)
        Npc(berufemon).SetRailMoveInDimension3d()
        Npc(berufemon).RailMoveGo()
        if Npc(berufemon).IsArrivalRailBothEnds() then
          SetExternalVariable("berufe_state", "end_02")
          PlayVoice(999450071)
        end
      end
    end
  elseif gMapNum == 205 then
    local townelv00 = GetIndex(GIM, "obj_0001")
    local townelv00_state = GetExternalVariable("townelv00_state")
    if townelv00_state == "move" then
      LocatorObject(townelv00).Motion_PlayMotion("e001", 0, false)
      if not LocatorObject(townelv00).IsPlayingMotion("e001") then
        SetExternalVariable("townelv00_state", "arrive")
      end
    elseif townelv00_state == "arrive" then
      DisableEventCollision("plan_cl_1000")
    end
    local townelv01 = GetIndex(GIM, "obj_0002")
    local townelv01_state = GetExternalVariable("townelv01_state")
    if townelv01_state == "move" then
      LocatorObject(townelv01).Motion_PlayMotion("e001", 0, false)
      if not LocatorObject(townelv01).IsPlayingMotion("e001") then
        SetExternalVariable("townelv01_state", "arrive")
      end
    elseif townelv01_state == "arrive" then
      DisableEventCollision("plan_cl_1001")
    end
    local pegas_state = GetExternalVariable("pegas_state")
    if pegas_state == "start_move" then
      Player().LinkToRailMove("d0205_railmove", "rail_move_900")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveDirection(false)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().SetRailMoveInDimension2d()
      Player().RailMoveGo()
      PlayAndManageSE(211010, 100, 0.5, 1, false, true)
    elseif pegas_state == "start_arrival" then
      Player().LinkToRailMove("d0205_railmove", "rail_move_903")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().SetRailMoveInDimension2d()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().RailMoveGo()
      PlayAndManageSE(211010, 100, 0.5, 1, false, true)
      if Player().IsArrivalRailBothEnds() then
        SetExternalVariable("pegas_state", "stop")
        CallEventScriptFunction("Prcs_d0205_ride_pegasmon_end")
        StopManageSE(1, 1)
      end
    end
  elseif gMapNum == 206 then
    local hagr = GetIndex(NPC, "npc_0005")
    local hagr2 = GetIndex(NPC, "npc_0013")
    local hagr_state = GetExternalVariable("hagr_state")
    local hag_x, _, hag_z = Npc(hagr).GetPosition()
    if hagr_state == "stand_up" then
      Npc(hagr).LinkToRailMove("d0206_railmove", "rail_move_05")
      Npc(hagr).SuspendAutoTransparentForCameraInNowFrame()
      Npc(hagr).Motion_PlayMotion("bn01", 10, true)
      Npc(hagr).Physics_SetGravity(0)
      Npc(hagr).Move_SetPosition(hag_x, 0.5, hag_z)
    end
    if hagr_state == "move" then
      Npc(hagr2).Physics_SetGravity(0)
      Npc(hagr2).SetRailMoveSpeed(3)
      Npc(hagr2).LinkToRailMove("d0206_railmove", "rail_move_05")
      Npc(hagr2).SuspendAutoTransparentForCameraInNowFrame()
      Npc(hagr2).LinkToRailMove("d0206_railmove", "rail_move_05")
      Npc(hagr2).RailMoveGo()
      if Npc(hagr2).IsArrivalRailBothEnds() then
        SetExternalVariable("hagr_state", "move_end")
      end
    end
    if hagr_state == "move_end" then
      Npc(hagr2).Physics_SetGravity(0)
      Npc(hagr2).SuspendAutoTransparentForCameraInNowFrame()
      Npc(hagr2).Motion_PlayMotion("bn01", 10, true)
      Npc(hagr2).Move_SetRotationY(180, 20)
      if Npc(hagr2).GetRotationY() == 180 then
        SetExternalVariable("hagr_state", "end")
      end
    end
  elseif gMapNum == 207 then
    local system_type, obj_index = GetCurrentFieldAttackTargetMarker()
    local unique_name
    if system_type ~= nil then
      unique_name = Object(system_type, obj_index).GetUniqueName()
    end
    if unique_name == "fa_0001" then
      SetInstantCameraInNowFrame(-40.5153, 3.3916, -9.699, -30.5736, 4.46722, -9.764, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0002" then
      SetInstantCameraInNowFrame(33.8, 11.12, -14.321, 33.782, 12.548, -4.424, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0003" then
      SetInstantCameraInNowFrame(-10.07, 14.8938, -11.9918, -8.8367, 16.3456, -2.1759, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0004" then
      SetInstantCameraInNowFrame(31.8233, 26.4437, -10.689, 22.0107, 28.3696, -10.6314, DEFAULT_ANGLE, 20, 20)
    end
  elseif gMapNum == 209 then
    local is_coming_elv_to_d0210 = GetExternalVariable("is_coming_elv_to_d0210")
    if is_coming_elv_to_d0210 == true then
      local elv_0003 = GetIndex(GIM, "elv_0003")
      LocatorObject(elv_0003).MoveStartLift(false)
      SetExternalVariable("is_coming_elv_to_d0210", nil)
    end
    local system_type, obj_index = GetCurrentFieldAttackTargetMarker()
    local unique_name
    if system_type ~= nil then
      unique_name = Object(system_type, obj_index).GetUniqueName()
    end
    if unique_name == "fa_0001" then
      SetInstantCameraInNowFrame(-34.64899, 0, 4.2434, -24.797306, 1.69448, 4.5133, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0002" then
      SetInstantCameraInNowFrame(46.0872, 19.7501, -0.537, 36.9122, 23.72634, -0.6295, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0003" then
      SetInstantCameraInNowFrame(10.3694, 10.0319, 9.5298, 15.3694, 15.0319, 14.5298, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0004" then
      SetInstantCameraInNowFrame(10.2994, 10.0151, 9.6468, 15.2994, 15.0151, 14.8468, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0005" then
      SetInstantCameraInNowFrame(3.7127, 10.0897, 9.4825, 8.7127, 15.0897, 14.6825, DEFAULT_ANGLE, 20, 20)
    end
    if unique_name == "fa_0006" then
      SetInstantCameraInNowFrame(46.0872, 19.7501, -0.537, 36.9122, 23.72634, -0.6295, DEFAULT_ANGLE, 20, 20)
    end
  elseif gMapNum == 210 then
    local player_state = GetExternalVariable("player_state")
    local index_1 = GetIndex(NPC, "RoyalKnights_CRANIAMON")
    local index_2 = GetIndex(NPC, "s110_ENBARRMON")
    local index_3 = GetIndex(NPC, "RoyalKights_DYNASMON")
    local index_4 = GetIndex(NPC, "RoyalKights_LOADKNIGHTMON")
    local index_5 = GetIndex(NPC, "RoyalKnights_GANKOOMON")
    local index_6 = GetIndex(NPC, "RoyalKnights_JESMON")
    local index_7 = GetIndex(NPC, "RoyalKights_DUFTMON")
    if player_state == "back_camera" then
      SetInstantCameraInNowFrame(-0.914, 43.5242, 27.926, -0.574, 45.594, 37.703, 50, 45, 45)
      Npc(index_1).OverwriteCheckableRange(0, 0, 0)
      Npc(index_2).OverwriteCheckableRange(0, 0, 0)
      Npc(index_3).OverwriteCheckableRange(0, 0, 0)
      Npc(index_4).OverwriteCheckableRange(0, 0, 0)
      Npc(index_5).OverwriteCheckableRange(0, 0, 0)
      Npc(index_6).OverwriteCheckableRange(0, 0, 0)
      Npc(index_7).OverwriteCheckableRange(0, 0, 0)
    else
      Npc(index_1).ClearOverwriteCheckableRange()
      Npc(index_2).ClearOverwriteCheckableRange()
      Npc(index_3).ClearOverwriteCheckableRange()
      Npc(index_4).ClearOverwriteCheckableRange()
      Npc(index_5).ClearOverwriteCheckableRange()
      Npc(index_6).ClearOverwriteCheckableRange()
      Npc(index_7).ClearOverwriteCheckableRange()
    end
  elseif gMapNum == 213 then
    local chr001_hide = GetIndex(NPC, "chr001_hide")
    local chr001_hide_state = GetExternalVariable("chr001_hide_state")
    local player_rotate = Player().GetRotationY()
    local chr001_hide_rotate = Npc(chr001_hide).GetRotationY()
    local relative_rotate = player_rotate - chr001_hide_rotate
    if chr001_hide_state == "fidget" then
      if relative_rotate <= 60 and relative_rotate >= -50 and not FlagCheck(FLAG_IS_CHECK_D0213_DOLL_1) then
        Npc(chr001_hide).Motion_PlayMotion("f001", 30, false)
        FlagSet(FLAG_IS_CHECK_D0213_DOLL_1)
      end
      if FlagCheck(FLAG_IS_CHECK_D0213_DOLL_4) and chr001_hide_state ~= "initialize" then
        SetExternalVariable("chr001_hide_state", "initialize")
      end
    end
  end
  if gMapNum == 216 then
    local npc_warp01 = GetIndex(NPC, "npc_warp01")
    local npc_warp02 = GetIndex(NPC, "npc_warp02")
    Npc(npc_warp01).Physics_SetCollisionContactForNotHit()
    Npc(npc_warp02).Physics_SetCollisionContactForNotHit()
  end
  if gMapNum == 217 then
    local platinum_state = GetExternalVariable("platinum_state")
    local platinum = GetIndex(NPC, "s050_043_platinum")
    if player_state == "pass" then
      print("********player_state*******")
      print(player_state)
      print("***************")
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    end
    if platinum_state == "move" then
      Npc(platinum).Physics_SetCollisionContactForNotHit()
      Npc(platinum).Physics_SetGravity(0)
      Npc(platinum).LinkToRailMove("d0217_railmove", "rail_move_005")
      Npc(platinum).SetRailMoveInDimension3d()
      if Npc(platinum).IsArrivalRailBothEnds() then
        SetExternalVariable("platinum_state", "wait")
      end
      Npc(platinum).SetRailMoveDirection(true)
      Npc(platinum).Move_SetRotationY(-90, 0)
      Npc(platinum).SetRailMoveSpeed(2)
      Npc(platinum).RailMoveGo()
    elseif platinum_state == "standby" then
      Npc(platinum).Physics_SetCollisionContactForNotHit()
      Npc(platinum).Move_SetRotationY(-90, 0)
      Npc(platinum).Move_SetRotationZ(240, 0)
      Npc(platinum).SetRailMoveInDimension3d()
      Npc(platinum).Physics_SetGravity(0)
      Npc(platinum).Move_SetPosition(39.49, 12.1, 1.92)
    elseif platinum_state == "wait" then
      Npc(platinum).Physics_SetCollisionContactForNotHit()
      Npc(platinum).Move_SetRotationY(-90, 0)
      Npc(platinum).SetRailMoveInDimension3d()
      Npc(platinum).Physics_SetGravity(0)
    elseif platinum_state == "wait2" then
      Npc(platinum).Physics_SetCollisionContactForNotHit()
      Npc(platinum).Move_SetRotationY(-90, 0)
      Npc(platinum).Move_SetRotationZ(240, 0)
      Npc(platinum).SetRailMoveInDimension3d()
      Npc(platinum).Physics_SetGravity(0)
    elseif platinum_state == "reverse" then
      Npc(platinum).Physics_SetCollisionContactForNotHit()
      Npc(platinum).Physics_SetGravity(0)
      Npc(platinum).LinkToRailMove("d0217_railmove", "rail_move_005")
      Npc(platinum).SetRailMoveInDimension3d()
      Npc(platinum).Move_SetRotationY(-90, 0)
      Npc(platinum).SetRailMoveDirection(false)
      Npc(platinum).SetRailMoveSpeed(2)
      Npc(platinum).RailMoveGo()
      if Npc(platinum).IsArrivalRailBothEnds() then
        SetExternalVariable("platinum_state", "standby")
      end
    elseif platinum_state == "move2" then
      Npc(platinum).Physics_SetCollisionContactForNotHit()
      Npc(platinum).Physics_SetGravity(0)
      Npc(platinum).LinkToRailMove("d0217_railmove", "rail_move_006")
      Npc(platinum).SetRailMoveInDimension3d()
      Npc(platinum).Move_SetRotationZ(240, 0)
      Npc(platinum).Move_SetRotationY(-90, 0)
      Npc(platinum).SetRailMoveDirection(true)
      Npc(platinum).SetRailMoveSpeed(2)
      Npc(platinum).RailMoveGo()
      if Npc(platinum).IsArrivalRailBothEnds() then
        SetExternalVariable("platinum_state", "wait2")
      end
    elseif platinum_state == "reverse2" then
      Npc(platinum).Physics_SetCollisionContactForNotHit()
      Npc(platinum).Physics_SetGravity(0)
      Npc(platinum).LinkToRailMove("d0217_railmove", "rail_move_006")
      Npc(platinum).SetRailMoveInDimension3d()
      Npc(platinum).Move_SetRotationZ(240, 0)
      Npc(platinum).Move_SetRotationY(-90, 0)
      Npc(platinum).SetRailMoveDirection(false)
      Npc(platinum).SetRailMoveSpeed(2)
      Npc(platinum).RailMoveGo()
      if Npc(platinum).IsArrivalRailBothEnds() then
        SetExternalVariable("platinum_state", "finish")
      end
    elseif platinum_state == "finish" then
      Npc(platinum).Move_SetRotationZ(0, 0)
      Npc(platinum).Move_SetRotationY(0, 0)
      Player().Physics_ResetGravity()
    end
    AdulationDigiNPC("bear_br_state", "npc_0120")
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local is_fa = args.by_field_attack
  if gMapNum == 217 and is_fa == true then
    local name = SymbolEnemy(symbol_index).GetUniqueName()
    if name == "s050_043_platinum" then
      FlagSet(FLAG_SUB_S050_043_005)
      CallEventScriptFunction("S050_043_Event_073")
    end
  end
end

function OnCheckLocatorLift(gimmick_index, args)
  print("=============== OnCheckLocatorLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== is_forward = ", is_forward, " ======")
  PlaySE(200008, 100)
  PlayAndManageSE(200009, 100, 60, 1, true, true)
  SetExternalVariable("move_elv", "moveing")
  if gMapNum == 205 then
    if elv_name == "elv_0001" then
    end
  elseif gMapNum == 206 then
    if elv_name == "elv_0001" then
      local cam_x, cam_y, cam_z = GetCameraPos()
      local aim_x, aim_y, aim_z = GetCameraAimPos()
      SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, 60, LINEAR)
    elseif elv_name == "elv_0002" then
      local cam_x, cam_y, cam_z = GetCameraPos()
      local aim_x, aim_y, aim_z = GetCameraAimPos()
      SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, 60, LINEAR)
    elseif elv_name == "elv_0003" then
      local cam_x, cam_y, cam_z = GetCameraPos()
      local aim_x, aim_y, aim_z = GetCameraAimPos()
      SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, 60, LINEAR)
    end
  elseif gMapNum == 207 then
    if elv_name == "elv_0001" then
      local cam_x, cam_y, cam_z = GetCameraPos()
      local aim_x, aim_y, aim_z = GetCameraAimPos()
      SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, 60, LINEAR)
    end
  elseif gMapNum == 209 then
    if elv_name == "elv_0001" then
      local cam_x, cam_y, cam_z = GetCameraPos()
      local aim_x, aim_y, aim_z = GetCameraAimPos()
      SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, 60, LINEAR)
    elseif elv_name == "elv_0003" then
      local cam_x, cam_y, cam_z = GetCameraPos()
      local aim_x, aim_y, aim_z = GetCameraAimPos()
      SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, 60, LINEAR)
    end
  end
  return true
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
  local elv_index, was_forward, is_carry_player = gimmick_index, args.was_forward, args.is_carrying_the_player
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== was_forward = ", was_forward, " ====== is_carry_player = ", is_carry_player, " ======")
  PlayAndManageSE(200010, 100, 0, 0, true, true)
  StopManageSE(1, 15)
  SetExternalVariable("move_elv", "stop")
  ClearInstantCamera(60, LINEAR)
end

function OnTouchCollision(col_name)
  local name = col_name
  if gMapNum == 210 and (name == "evt_5000" or name == "evt_5001") then
    SetExternalVariable("player_state", "back_camera")
  end
end

function OnAwayFromCollision(col_name)
  local name = col_name
  if gMapNum == 210 then
    print(name)
    SetExternalVariable("player_state", "Initialize")
  end
end

function Ctrl_TextRumor(num, npc, rumor1, rumor2)
  if num == 0 then
    RumorNpc(rumor1).InvisibleInNowFrame(0, 0, true)
    RumorNpc(rumor2).InvisibleInNowFrame(0, 0, true)
    SetExternalVariable("Rumer_state", "invisible")
    SetExternalVariable("Rumer_state2", "invisible")
  elseif num == 1 then
    RumorNpc(rumor2).InvisibleInNowFrame(0, 0, true)
    SetExternalVariable("Rumer_state", "display")
    SetExternalVariable("Rumer_state2", "invisible")
  elseif num == 2 then
    RumorNpc(rumor1).InvisibleInNowFrame(0, 0, true)
    SetExternalVariable("Rumer_state2", "display")
    SetExternalVariable("Rumer_state", "invisible")
  end
end

function CheckHazamaGateFound(object_type, object_index, args)
  print("=============== CheckHazamaGateFound object_type = ", object_type, "=====================")
  if object_type == OGIM then
    print("=============== CheckHazamaGateFound GIMMICK_OBJECT_TYPE =====================")
    local name = Gimmick(object_index).GetUniqueName()
    if string.find(name, "hazama_gate") ~= nil then
      local first_discovery = true
      if gMapNum == 216 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H511) then
          FlagSet(FLAG_IS_DISCOVERY_H511)
        end
      elseif gMapNum == 217 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H810) then
          FlagSet(FLAG_IS_DISCOVERY_H810)
        end
      elseif gMapNum == 202 and not FlagCheck(FLAG_IS_DISCOVERY_H812) then
        FlagSet(FLAG_IS_DISCOVERY_H812)
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
  if gMapNum == 201 then
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
  if gMapNum == 201 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    if enemy_name == "berufe_01" or enemy_name == "berufe_02" or enemy_name == "berufe_03" or enemy_name == "berufe_04" then
      return false
    end
  end
end
