require("function_control")
DEFINE_FLAG("FLAG_MAIN_01_020")
DEFINE_FLAG("FLAG_MAIN_01_025")
DEFINE_FLAG("FLAG_MAIN_02_020")
DEFINE_FLAG("FLAG_MAIN_07_050")
DEFINE_FLAG("FLAG_MAIN_07_054B")
DEFINE_FLAG("FLAG_MAIN_03_260")
DEFINE_FLAG("FLAG_MAIN_03_270")
DEFINE_FLAG("FLAG_GIMMICK_T01_020")
DEFINE_FLAG("FLAG_GIMMICK_T01_030")
DEFINE_FLAG("FLAG_GIMMICK_T01_040")
DEFINE_FLAG("FLAG_GIMMICK_T01_070")
DEFINE_FLAG("FLAG_MAIN_01_030")
DEFINE_FLAG("FLAG_MAIN_01_060")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H210")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H211")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gLine = {}
gLoopRange = {}
for i = 1, 36 do
  gLine[i] = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  }
end
gLoopRange.rail_110 = {
  start = 9,
  fin = 6,
  add = -1
}
gLoopRange.rail_111 = {
  start = 27,
  fin = 24,
  add = -1
}
gLoopRange.rail_112 = {
  start = 10,
  fin = 15,
  add = 1
}
gLoopRange.rail_113 = {
  start = 28,
  fin = 33,
  add = 1
}
gLoopRange.rail_114 = {
  start = 5,
  fin = 3,
  add = -1
}
gLoopRange.rail_115 = {
  start = 23,
  fin = 21,
  add = -1
}

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  Player().LoadMotion("e200")
  if gMapNum == 101 then
  elseif gMapNum == 102 then
    LoadLocatorModel("t0102p")
    local shop_door = GetIndex(GIM, "obj_0001")
    LocatorObject(shop_door).LoadMotion("e001")
  elseif gMapNum == 103 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 105 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
    local train01 = GetIndex(MOB, "Train01")
    local train02 = GetIndex(MOB, "Train02")
    Mob(train01).LoadMotion("e003")
    Mob(train01).LoadMotion("e004")
    Mob(train02).LoadMotion("e003")
    Mob(train02).LoadMotion("e004")
    for i = 10, 45 do
      local index = GetIndex(GIM, "gim_00" .. string.format("%02d", i))
      LocatorObject(index).LoadMotion("e001")
      LocatorObject(index).LoadMotion("e002")
    end
  elseif gMapNum == 107 then
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 109 then
    LoadLocatorModel(gPlanData)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 101 then
  elseif gMapNum == 102 then
    rotateY = GetLocatorRot2dOfLocatorModel("t0102p", "shop_0001", 0)
    local shop_door = GetIndex(GIM, "obj_0001")
    gShop1EvalFrame, gShop1WaitFrame = 0, 0
    gShop1AnimEndFrame = LocatorObject(shop_door).GetMotionDefaultEndFrame("e001")
    start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_09" then
      SetExternalVariable("shop_door_state", "come_from_shop1")
      gShop1EvalFrame = gShop1AnimEndFrame
    else
      SetExternalVariable("shop_door_state", "far")
    end
  elseif gMapNum == 103 then
    SetExternalVariable("npc0001_state", "initialize")
    SetExternalVariable("npc0002_state", "initialize")
    SetExternalVariable("npc0003_state", "initialize")
    SetExternalVariable("total_frame", 0)
    SetExternalVariable("total_frame_2", 0)
    SetExternalVariable("move_x", 0)
    SetExternalVariable("move_y", 0)
    SetExternalVariable("douger_state_1", "initialize")
    SetExternalVariable("douger_state_2", "initialize")
    SetExternalVariable("douger_state_3", "initialize")
    SetExternalVariable("douger_state_4", "initialize")
    SetExternalVariable("douger_state_5", "initialize")
    SetExternalVariable("douger_state_6", "initialize")
    SetExternalVariable("douger_state_7", "initialize")
    SetExternalVariable("douger_state_8", "initialize")
    SetExternalVariable("douger_move_state", "initialize")
  elseif gMapNum == 105 then
    SetExternalVariable("player_state", "initialize")
    gIsFinishInitialMobSet = false
    gMobNum = 0
    gMobTotal = 120
    SetExternalVariable("train01_next_rail", 110)
    SetExternalVariable("train02_next_rail", 113)
    for i = 1, 36 do
      for j = 1, 8 do
        gLine[i][j] = 0
      end
    end
  elseif gMapNum == 107 then
    SetExternalVariable("npc_state", "initialize")
    SetExternalVariable("player_move_state", "initialize")
    SetExternalVariable("player_state", "low")
    SetExternalVariable("total_frame", 0)
    SetExternalVariable("move_x", 0)
    SetExternalVariable("move_y", 0)
  elseif gMapNum == 109 then
    SetExternalVariable("treasure_test", false)
    SetExternalVariable("treasure_test2", false)
    SetExternalVariable("treasure_test3", false)
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 102 then
    if not CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      do
        local shop_door = GetIndex(GIM, "obj_0001")
        local shop_door_state = GetExternalVariable("shop_door_state")
        if shop_door_state == "come_from_shop1" then
          SetExternalVariable("shop_door_state", "near")
        else
          local distance = GetDistanceToObject(GIM, "obj_0001")
          if distance <= 2 then
            if shop_door_state == "far" or shop_door_state == "far_closed" then
              SetExternalVariable("shop_door_state", "near")
            elseif LocatorObject(shop_door).IsPlayingMotion("e001") then
              SetExternalVariable("shop_door_state", "near_opened")
            end
            gShop1EvalFrame = LocatorObject(shop_door).GetMotionEvalFrame("e001")
          elseif shop_door_state == "near" or shop_door_state == "near_opened" then
            SetExternalVariable("shop_door_state", "far")
          else
            if LocatorObject(shop_door).IsPlayingMotion("e001") then
              SetExternalVariable("shop_door_state", "far_closed")
            else
            end
          end
        end
      end
    end
  elseif gMapNum == 103 then
    if CheckTimeAxis("A2028_daft_310", "A2028_daft_10000") or CheckTimeAxis("P2028_daft_310", "P2028_daft_10000") or CheckTimeAxis("Z2028_daft_390", "Z2028_daft_10000") then
    else
      DisableLinkCollisionInNowFrame("col_t0121_start_00_0")
    end
  elseif gMapNum == 108 then
    if CheckTimeAxis("X2028_daft_0", "X2028_daft_20") or CheckTimeAxis("P2028_daft_0", "P2028_daft_10000") or CheckTimeAxis("A2028_daft_310", "A2028_daft_10000") or CheckTimeAxis("Z2028_daft_310", "Z2028_daft_10000") then
      DisableLinkCollisionInNowFrame("col_t0301_start_04_0")
    else
      DisableLinkCollisionInNowFrame("col_t0107_start_00_0")
      DisableLinkCollisionInNowFrame("col_t0107_start_00_1")
    end
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
  if gMapNum == 101 then
    SetStartInstantCameraInNowFrameEndPad(-1.504, 4.07, -12.134, 0.017, 1.521, -2.585, 60, 1, 45, FLAG_MAIN_01_025, FLAG_MAIN_01_020)
    local x, y, z = Player().GetPosition()
    local player_state = GetExternalVariable("player_state")
    if player_state == "mapchange" then
      Player().Motion_PlayMotionAndSetting("e200", 0, 0, 0, 120, 1, true)
      SetExternalVariable("player_state", "wait")
    elseif player_state == "wait" then
      local rotateY = Player().GetRotationY()
      local aim_distance = GetDistanceBetweenTwoObject2D(0, 0, 0.2493, -0.0486)
      local cam_distance = GetDistanceBetweenTwoObject2D(0, 0, 0.972, 0.2839)
      local aim_rotate = rotateY + GetAngleToTarget2D(0, 0, 0.2493, -0.0486)
      local cam_rotate = rotateY + GetAngleToTarget2D(0, 0, 0.972, 0.2839)
      local aim_vector_x, aim_vector_z = GetUnitVector2D(aim_rotate)
      local cam_vector_x, cam_vector_z = GetUnitVector2D(cam_rotate)
      local relative_aimpos_x = aim_vector_x * aim_distance
      local relative_aimpos_z = aim_vector_z * aim_distance
      local relative_campos_x = cam_vector_x * cam_distance
      local relatevie_campos_z = cam_vector_z * cam_distance
      Cam.Inst:Set(x + relative_aimpos_x, y + 1.5429, z + relative_aimpos_z, x + relative_campos_x, y + 2, z + relatevie_campos_z, DEFAULT_ANGLE, 0)
    elseif player_state == "clear" then
      ClearInstantCamera(30)
      SetExternalVariable("player_state", "Initialize")
    end
  elseif gMapNum == 102 then
    local shop_door = GetIndex(GIM, "obj_0001")
    local shop_door_state = GetExternalVariable("shop_door_state")
    local player_state = GetExternalVariable("player_state")
    if CheckTimeAxis("X2028_daft_10", "X2028_daft_20") then
    elseif shop_door_state == "near" then
      LocatorObject(shop_door).Motion_PlayMotionAndSetting("e001", 0, gShop1EvalFrame, 0, gShop1AnimEndFrame, 1, false)
    elseif shop_door_state == "far" then
      LocatorObject(shop_door).Motion_PlayMotionAndSetting("e001", 0, gShop1EvalFrame, gShop1AnimEndFrame, 0, 1, false)
    end
    if player_state == "go_shop" or player_state == "map_change_shop" then
      if gIsUsedFuncOpenDoor == nil then
        if gShop1EvalFrame >= 20 then
          gShop1WaitFrame = 0
        else
          gShop1WaitFrame = 15
        end
      end
      OpenDoor("shop_0001", gShop1WaitFrame, elapsed_frame)
      if gFuncOpenDoor.State == "go_rotateY" then
        SetExternalVariable("player_state", "map_change_shop")
      end
    end
    if CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
    end
  elseif gMapNum == 103 then
    local npc0001 = GetIndex(NPC, "npc_0001")
    local npc0001_state = GetExternalVariable("npc0001_state")
    local npc0002 = GetIndex(NPC, "npc_0002")
    local npc0002_state = GetExternalVariable("npc0002_state")
    local npc0003 = GetIndex(NPC, "npc_0003")
    local npc0003_state = GetExternalVariable("npc0003_state")
    if npc0001_state == "move" then
      Npc(npc0001).LinkToRailMove("t0103_railmove", "rail_move_100")
      Npc(npc0001).SetRailMoveInDimension2d()
      Npc(npc0001).SetRailMoveSpeed(2)
      Npc(npc0001).RailMoveGo()
      if Npc(npc0001).IsArrivalRailBothEnds() then
        SetExternalVariable("npc0001_state", "move_end")
        SetExternalVariable("player_move_state", "move_standby")
      end
    elseif npc0001_state == "move_end" then
      if not Npc(npc0001).IsPlayingMotion("ft01_02") then
        Npc(npc0001).Move_SetRotationY(345, 10)
        Npc(npc0001).Motion_PlayMotion("ft01_02", 10, false)
      end
      if Npc(npc0001).GetRotationY() == 180 then
        SetExternalVariable("npc0001_state", "end")
      end
      Npc(npc0001).Physics_SetCollisionContactForNotHit()
      Npc(npc0001).Physics_SetGravity(0)
    elseif npc0001_state == "end" then
    end
    if npc0002_state == "move" then
      Npc(npc0002).LinkToRailMove("t0103_railmove", "rail_move_101")
      Npc(npc0002).SetRailMoveInDimension2d()
      Npc(npc0002).SetRailMoveSpeed(2)
      Npc(npc0002).RailMoveGo()
      if Npc(npc0002).IsArrivalRailBothEnds() then
        SetExternalVariable("npc0002_state", "move_end")
      end
    elseif npc0002_state == "move_end" then
      if not Npc(npc0002).IsPlayingMotion("ft01_02") then
        Npc(npc0002).Move_SetRotationY(345, 10)
        Npc(npc0002).Motion_PlayMotion("ft01_02", 10, false)
      end
      if Npc(npc0002).GetRotationY() == 180 then
        SetExternalVariable("npc0002_state", "end")
      end
      Npc(npc0002).Physics_SetCollisionContactForNotHit()
      Npc(npc0002).Physics_SetGravity(0)
    elseif npc0002_state == "end" then
    end
    if npc0003_state == "move" then
      Npc(npc0003).LinkToRailMove("t0103_railmove", "rail_move_102")
      Npc(npc0003).SetRailMoveInDimension2d()
      Npc(npc0003).SetRailMoveSpeed(2)
      Npc(npc0003).RailMoveGo()
      if Npc(npc0003).IsArrivalRailBothEnds() then
        SetExternalVariable("npc0003_state", "move_end")
      end
    elseif npc0003_state == "move_end" then
      if not Npc(npc0003).IsPlayingMotion("ft01_01") then
        Npc(npc0003).Move_SetRotationY(15, 10)
        Npc(npc0003).Motion_PlayMotion("ft01_01", 10, false)
      end
      if Npc(npc0003).GetRotationY() == 180 then
        SetExternalVariable("npc0003_state", "end")
      end
      Npc(npc0003).Physics_SetCollisionContactForNotHit()
      Npc(npc0003).Physics_SetGravity(0)
    elseif npc0003_state == "end" then
    end
    if FlagCheck(FLAG_MAIN_03_260) and FlagCheck(FLAG_GIMMICK_T01_020) then
      local player_move_state = GetExternalVariable("player_move_state")
      local total_frame = GetExternalVariable("total_frame")
      local total_frame_2 = GetExternalVariable("total_frame_2")
      Player().LinkToRailMove("t0103_railmove", "rail_move_200")
      local pad_input_x = GetPadAxis(PAD_AXIS_RIGHT_X) * 15
      local pad_input_y = 0
      local move_x = GetExternalVariable("move_x")
      local move_y = GetExternalVariable("move_y")
      local camera_speed = 0.05
      local camera_cancel_speed = 0.2
      local frame = 2
      if 0 < GetPadAxis(PAD_AXIS_RIGHT_Y) then
        pad_input_y = GetPadAxis(PAD_AXIS_RIGHT_Y) * 15
      else
        SetExternalVariable("move_y", 0)
      end
      if 0 < pad_input_x and pad_input_x >= move_x then
        SetExternalVariable("move_x", move_x + camera_speed)
      end
      if 0 < pad_input_y and move_y <= pad_input_y then
        SetExternalVariable("move_y", move_y + camera_speed)
      end
      if pad_input_x < 0 and pad_input_x <= move_x then
        SetExternalVariable("move_x", move_x - camera_speed)
      end
      if pad_input_y < 0 and move_y >= pad_input_y then
        SetExternalVariable("move_y", move_y - camera_speed)
      end
      if pad_input_x == 0 and pad_input_y == 0 then
        if 0 < move_x then
          SetExternalVariable("move_x", move_x - camera_cancel_speed)
        end
        if move_x < 0 then
          SetExternalVariable("move_x", move_x + camera_cancel_speed)
        end
        if 0 < move_y then
          SetExternalVariable("move_y", move_y - camera_cancel_speed)
        end
        if move_y < 0 then
          SetExternalVariable("move_y", move_y + camera_cancel_speed)
        end
        if math.floor(move_x) == 0 then
          SetExternalVariable("move_x", 0)
        end
        if math.floor(move_y) == 0 then
          SetExternalVariable("move_y", 0)
        end
      end
      local pc_rot = Player().GetRotationY()
      local pc_rot_vec_x = GetUnitVector2D(0)
      local pc_rot_vec_z = GetUnitVector2D(0)
      local pc_rot_rev_vec_x = GetUnitVector2D(-180)
      local pc_rot_rev_vec_z = GetUnitVector2D(-180)
      local pc_x, _, pc_z = Player().GetPosition()
      local cam_pos_x = pc_x + pc_rot_rev_vec_x * 0.5
      local cam_pos_z = pc_z + pc_rot_rev_vec_z * 0.5
      local cam_aim_x = cam_pos_x + pc_rot_vec_x * 10
      local cam_aim_z = cam_pos_z + pc_rot_vec_z * 10
      local operatedegrees = GetLeftAxisDegrees()
      local speed = 0
      local rail_direction = true
      if player_move_state == "move" then
        if total_frame <= 120 then
          SetInstantCameraInNowFrame(cam_aim_x, 1.6, cam_aim_z - 1, cam_pos_x, 2.5, cam_pos_z + 2.5, 70, 30, 120, QUINTIC_OUT, QUINTIC_OUT)
        elseif 120 < total_frame then
          SetInstantCameraInNowFrame(cam_aim_x, 1.6, cam_aim_z - 1, cam_pos_x, 2.5, cam_pos_z + 2.5, 70, frame, 120, QUINTIC_OUT, QUINTIC_OUT)
          if IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil and (operatedegrees <= 120 or 240 <= operatedegrees) then
            rail_direction = true
            speed = 2
          end
        end
        Player().SetRailMoveDirection(rail_direction)
        Player().SetRailMoveSpeed(speed)
        Player().SetRailMoveInDimension2d()
        Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
        Player().RailMoveGo()
        SetExternalVariable("total_frame", total_frame + 1)
      elseif player_move_state == "wait" then
        Player().SetRailMoveDirection(true)
        Player().SetRailMoveSpeed(0)
        Player().SetRailMoveInDimension2d()
        Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
        Player().RailMoveGo()
      elseif player_move_state == "talk_wait" then
        Player().SetRailMoveDirection(true)
        Player().SetRailMoveSpeed(0)
        Player().SetRailMoveInDimension2d()
        Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
        Player().RailMoveGo()
        SetInstantCameraInNowFrame(cam_aim_x, 1.6, cam_aim_z - 1, cam_pos_x, 2.5, cam_pos_z + 2.5, 70, frame, 120, QUINTIC_OUT, QUINTIC_OUT)
      elseif player_move_state == "move_standby" then
        if 15 <= total_frame and total_frame <= 60 then
          Player().SetRailMoveDirection(true)
          Player().SetRailMoveSpeed(3)
          Player().SetRailMoveInDimension2d()
          Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0)
          Player().RailMoveGo()
        elseif 60 < total_frame then
          SetExternalVariable("player_move_state", "move")
        end
        SetExternalVariable("total_frame", total_frame + 1)
      elseif player_move_state == "lastmove" then
        local operatedegrees = GetLeftAxisDegrees()
        local speed = 0
        local rail_direction = true
        if IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil and (operatedegrees <= 120 or 240 <= operatedegrees) then
          rail_direction = true
          speed = 2
          if FlagCheck(FLAG_GIMMICK_T01_040) then
            speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
          end
        end
        Player().LinkToRailMove("t0103_railmove", "rail_move_200")
        Player().SetRailMoveDirection(rail_direction)
        Player().SetRailMoveSpeed(speed)
        Player().SetRailMoveInDimension2d()
        Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
        Player().RailMoveGo()
        SetInstantCameraInNowFrame(-1.55, 1.92, -53.14, 8.39, 2.48, -52.18, DEFAULT_ANGLE, 60, 60)
      elseif player_move_state == "lastcamera" then
        local pad_input_x = GetPadAxis(PAD_AXIS_RIGHT_X) * 15
        local pad_input_y = GetPadAxis(PAD_AXIS_RIGHT_Y) * 15
        local move_x = GetExternalVariable("move_x")
        local move_y = GetExternalVariable("move_y")
        local camera_speed = 0.05
        local camera_cancel_speed = 0.2
        local frame = 2
        if 0 < pad_input_x and pad_input_x >= move_x then
          SetExternalVariable("move_x", move_x + camera_speed)
        end
        if pad_input_x < 0 and pad_input_x <= move_x then
          SetExternalVariable("move_x", move_x - camera_speed)
        end
        if pad_input_y < 0 and pad_input_y <= move_y then
          SetExternalVariable("move_y", move_y - camera_speed)
        end
        if pad_input_x == 0 and pad_input_y == 0 then
          if 0 < move_x then
            SetExternalVariable("move_x", move_x - camera_cancel_speed)
          end
          if move_x < 0 then
            SetExternalVariable("move_x", move_x + camera_cancel_speed)
          end
          if 0 < move_y then
            SetExternalVariable("move_y", move_y - camera_cancel_speed)
          end
          if move_y < 0 then
            SetExternalVariable("move_y", move_y + camera_cancel_speed)
          end
          if math.floor(move_x) == 0 then
            SetExternalVariable("move_x", 0)
          end
          if math.floor(move_y) == 0 then
            SetExternalVariable("move_y", 0)
          end
        end
        local pc_rot = Player().GetRotationY()
        local pc_rot_vec_x, pc_rot_vec_z = GetUnitVector2D(pc_rot)
        local pc_rot_rev_vec_x, pc_rot_rev_vec_z = GetUnitVector2D(pc_rot - 170)
        local pc_x, _, pc_z = Player().GetPosition()
        local cam_pos_x = pc_x + pc_rot_rev_vec_x * 1
        local cam_pos_z = pc_z + pc_rot_rev_vec_z * 1
        local cam_aim_x = cam_pos_x + pc_rot_vec_x * 10
        local cam_aim_z = cam_pos_z + pc_rot_vec_z * 10
        if total_frame_2 <= 30 then
          SetInstantCameraInNowFrame(-1.55, 1.92, -53.14, 8.39, 2.48, -52.18, DEFAULT_ANGLE, 60, 60)
          Player().LinkToRailMove("t0103_railmove", "rail_move_200")
          Player().SetRailMoveDirection(true)
          Player().SetRailMoveSpeed(2)
          Player().SetRailMoveInDimension2d()
          Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
          Player().RailMoveGo()
        elseif 30 < total_frame_2 and total_frame_2 <= 90 then
          SetInstantCameraInNowFrame(-10.380313932896, 1.6, -55.194135420024, -0.38574987649918, 1.6, -54.864450469613, 70, 30, 120, QUINTIC_OUT, QUINTIC_OUT)
          Player().LinkToRailMove("t0103_railmove", "rail_move_200")
          Player().SetRailMoveDirection(true)
          Player().SetRailMoveSpeed(0)
          Player().SetRailMoveInDimension2d()
          Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
          Player().RailMoveGo()
        else
          Player().DisableCullingInNowFrame()
          move_x = move_x * -1
          SetInstantCameraInNowFrame(cam_aim_x, 1.6 + move_y * 2, cam_aim_z + move_x, cam_pos_x, 1.6, cam_pos_z, 70, frame, 120, QUINTIC_OUT, QUINTIC_OUT)
          local operatedegrees = GetLeftAxisDegrees()
          local speed = 0
          local rail_direction = true
          if IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil and (operatedegrees <= 120 or 240 <= operatedegrees) then
            rail_direction = true
            speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
          end
          Player().LinkToRailMove("t0103_railmove", "rail_move_200")
          Player().SetRailMoveDirection(rail_direction)
          Player().SetRailMoveSpeed(speed)
          Player().SetRailMoveInDimension2d()
          Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
          Player().RailMoveGo()
        end
        SetExternalVariable("total_frame_2", total_frame_2 + 1)
      end
    end
    local douger_1 = GetIndex(NPC, "douger_1")
    local douger_2 = GetIndex(NPC, "douger_2")
    local douger_3 = GetIndex(NPC, "douger_3")
    local douger_4 = GetIndex(NPC, "douger_4")
    local douger_5 = GetIndex(NPC, "douger_5")
    local douger_6 = GetIndex(NPC, "douger_6")
    local douger_7 = GetIndex(NPC, "douger_7")
    local douger_8 = GetIndex(NPC, "douger_8")
    local douger_move = GetIndex(NPC, "douger_move")
    local distance = GetDistanceToObject(NPC, douger_move)
    local douger_move_speed = 8.25
    local douger_state_1 = GetExternalVariable("douger_state_1")
    local douger_state_2 = GetExternalVariable("douger_state_2")
    local douger_state_3 = GetExternalVariable("douger_state_3")
    local douger_state_4 = GetExternalVariable("douger_state_4")
    local douger_state_5 = GetExternalVariable("douger_state_5")
    local douger_state_6 = GetExternalVariable("douger_state_6")
    local douger_state_7 = GetExternalVariable("douger_state_7")
    local douger_state_8 = GetExternalVariable("douger_state_8")
    local douger_move_state = GetExternalVariable("douger_move_state")
    local douger_pos_x, douger_pos_y, douger_pos_z = Npc(douger_move).GetPosition()
    local player_pos_x, player_pos_y, player_pos_z = GetPositionAnyObject(PLAYER, 1)
    local y_degree = GetAngleToTarget2D(douger_pos_x, douger_pos_z, player_pos_x, player_pos_z)
    local relative_degree = y_degree - Npc(douger_move).GetRotationY()
    if douger_move_state == "initialize" then
      if 30 < relative_degree then
        if not Npc(douger_move).IsPlayingMotion("ft01_01") and not Npc(douger_move).IsPlayingMotion("ft01_02") then
          Npc(douger_move).Move_SetRotationY(y_degree, 10)
          Npc(douger_move).Motion_PlayMotion("ft01_01", 10, false)
        end
      elseif relative_degree < -30 then
        if not Npc(douger_move).IsPlayingMotion("ft01_01") and not Npc(douger_move).IsPlayingMotion("ft01_02") then
          Npc(douger_move).Move_SetRotationY(y_degree, 10)
          Npc(douger_move).Motion_PlayMotion("ft01_02", 10, false)
        end
      elseif Npc(douger_move).IsPlayingMotion("ft01_01") then
        Npc(douger_move).Motion_PlayMotion("ft01_01", 10, false)
      elseif Npc(douger_move).IsPlayingMotion("ft01_02") then
        Npc(douger_move).Motion_PlayMotion("ft01_02", 10, false)
      else
        Npc(douger_move).Motion_PlayMotion("e111", 10, true)
      end
    elseif douger_move_state == "move_1" then
      Npc(douger_move).LinkToRailMove("t0103_railmove", "rail_move_300")
      if Npc(douger_move).IsArrivalRailBothEnds() then
        Npc(douger_2).Move_SetPosition(douger_pos_x, douger_pos_y, douger_pos_z)
        Npc(douger_move).Move_SetRotationY(y_degree, 10)
        SetExternalVariable("douger_state_2", "visible")
        if not Npc(douger_move).IsPlayingMotion("ft01_01") then
          SetExternalVariable("douger_move_state", "wait")
        end
      else
        Npc(douger_move).SetRailMoveDirection(true)
        Npc(douger_move).SetRailMoveSpeed(douger_move_speed)
        Npc(douger_move).SetRailMoveInDimension2d()
        Npc(douger_move).RailMoveGo()
      end
    elseif douger_move_state == "move_2" then
      Npc(douger_move).LinkToRailMove("t0103_railmove", "rail_move_301")
      Npc(douger_6).LinkToRailMove("t0103_railmove", "rail_move_301")
      SetExternalVariable("douger_state_6", "visible")
      Npc(douger_6).Move_SetPosition(douger_pos_x, douger_pos_y, douger_pos_z)
      if Npc(douger_move).IsArrivalRailBothEnds() then
        Npc(douger_3).Move_SetPosition(douger_pos_x, douger_pos_y, douger_pos_z)
        Npc(douger_move).Move_SetRotationY(y_degree, 10)
        SetExternalVariable("douger_state_3", "visible")
        SetExternalVariable("douger_state_6", "invisible")
        if not Npc(douger_move).IsPlayingMotion("ft01_01") then
          SetExternalVariable("douger_move_state", "wait")
        end
      else
        Npc(douger_6).Physics_SetCollisionContactForNotHit()
        Npc(douger_6).Physics_SetGravity(0)
        Npc(douger_6).SetRailMoveDirection(true)
        Npc(douger_6).SetRailMoveSpeed(douger_move_speed)
        Npc(douger_6).SetRailMoveInDimension2d()
        Npc(douger_6).RailMoveGo()
        Npc(douger_move).SetRailMoveDirection(true)
        Npc(douger_move).SetRailMoveSpeed(douger_move_speed)
        Npc(douger_move).SetRailMoveInDimension2d()
        Npc(douger_move).RailMoveGo()
      end
    elseif douger_move_state == "move_3" then
      Npc(douger_move).LinkToRailMove("t0103_railmove", "rail_move_302")
      Npc(douger_7).LinkToRailMove("t0103_railmove", "rail_move_302")
      if douger_state_2 == "visible" then
        SetExternalVariable("douger_state_2", "invisible")
      end
      SetExternalVariable("douger_state_7", "visible")
      Npc(douger_7).Move_SetPosition(douger_pos_x, douger_pos_y, douger_pos_z)
      if Npc(douger_move).IsArrivalRailBothEnds() then
        Npc(douger_4).Move_SetPosition(douger_pos_x, douger_pos_y, douger_pos_z)
        Npc(douger_move).Move_SetRotationY(y_degree, 10)
        SetExternalVariable("douger_state_4", "visible")
        SetExternalVariable("douger_state_7", "invisible")
        if not Npc(douger_move).IsPlayingMotion("ft01_01") then
          SetExternalVariable("douger_move_state", "wait")
        end
      else
        Npc(douger_7).Physics_SetCollisionContactForNotHit()
        Npc(douger_7).Physics_SetGravity(0)
        Npc(douger_7).SetRailMoveDirection(true)
        Npc(douger_7).SetRailMoveSpeed(douger_move_speed)
        Npc(douger_7).SetRailMoveInDimension2d()
        Npc(douger_7).RailMoveGo()
        Npc(douger_move).SetRailMoveDirection(true)
        Npc(douger_move).SetRailMoveSpeed(douger_move_speed)
        Npc(douger_move).SetRailMoveInDimension2d()
        Npc(douger_move).RailMoveGo()
      end
    elseif douger_move_state == "move_4" then
      Npc(douger_move).LinkToRailMove("t0103_railmove", "rail_move_303")
      Npc(douger_8).LinkToRailMove("t0103_railmove", "rail_move_303")
      if douger_state_3 == "visible" then
        SetExternalVariable("douger_state_3", "invisible")
      end
      SetExternalVariable("douger_state_8", "visible")
      Npc(douger_8).Move_SetPosition(douger_pos_x, douger_pos_y, douger_pos_z)
      if Npc(douger_move).IsArrivalRailBothEnds() then
        Npc(douger_5).Move_SetPosition(douger_pos_x, douger_pos_y, douger_pos_z)
        Npc(douger_move).Move_SetRotationY(y_degree, 10)
        SetExternalVariable("douger_state_5", "visible")
        SetExternalVariable("douger_state_8", "invisible")
        if not Npc(douger_move).IsPlayingMotion("ft01_01") then
          SetExternalVariable("douger_move_state", "wait")
        end
      else
        Npc(douger_8).Physics_SetCollisionContactForNotHit()
        Npc(douger_8).Physics_SetGravity(0)
        Npc(douger_8).SetRailMoveDirection(true)
        Npc(douger_8).SetRailMoveSpeed(douger_move_speed)
        Npc(douger_8).SetRailMoveInDimension2d()
        Npc(douger_8).RailMoveGo()
        Npc(douger_move).SetRailMoveDirection(true)
        Npc(douger_move).SetRailMoveSpeed(douger_move_speed)
        Npc(douger_move).SetRailMoveInDimension2d()
        Npc(douger_move).RailMoveGo()
      end
    elseif douger_move_state == "wait" then
      if 30 < relative_degree then
        if not Npc(douger_move).IsPlayingMotion("ft01_01") and not Npc(douger_move).IsPlayingMotion("ft01_02") then
          Npc(douger_move).Move_SetRotationY(y_degree, 10)
          Npc(douger_move).Motion_PlayMotion("ft01_01", 10, false)
        end
      elseif relative_degree < -30 then
        if not Npc(douger_move).IsPlayingMotion("ft01_01") and not Npc(douger_move).IsPlayingMotion("ft01_02") then
          Npc(douger_move).Move_SetRotationY(y_degree, 10)
          Npc(douger_move).Motion_PlayMotion("ft01_02", 10, false)
        end
      elseif Npc(douger_move).IsPlayingMotion("ft01_01") then
        Npc(douger_move).Motion_PlayMotion("ft01_01", 10, false)
      elseif Npc(douger_move).IsPlayingMotion("ft01_02") then
        Npc(douger_move).Motion_PlayMotion("ft01_02", 10, false)
      else
        Npc(douger_move).Motion_PlayMotion("e109", 10, true)
      end
    end
    if douger_state_1 == "invisible" then
      Npc(douger_1).InvisibleInNowFrame(0, 0, true)
    end
    if douger_state_2 == "initialize" or douger_state_2 == "invisible" then
      Npc(douger_2).InvisibleInNowFrame(0, 0, true)
    end
    if douger_state_3 == "initialize" or douger_state_3 == "invisible" then
      Npc(douger_3).InvisibleInNowFrame(0, 0, true)
    end
    if douger_state_4 == "initialize" or douger_state_4 == "invisible" then
      Npc(douger_4).InvisibleInNowFrame(0, 0, true)
    end
    if douger_state_5 == "initialize" or douger_state_5 == "invisible" then
      Npc(douger_5).InvisibleInNowFrame(0, 0, true)
    end
    if douger_state_6 == "initialize" or douger_state_6 == "invisible" then
      Npc(douger_6).InvisibleInNowFrame(0, 0, true)
    end
    if douger_state_7 == "initialize" or douger_state_7 == "invisible" then
      Npc(douger_7).InvisibleInNowFrame(0, 0, true)
    end
    if douger_state_8 == "initialize" or douger_state_8 == "invisible" then
      Npc(douger_8).InvisibleInNowFrame(0, 0, true)
    end
    local raide_state = GetExternalVariable("ride_state")
    if raide_state == "start_setting" then
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    elseif raide_state == "start_arrival" then
      local p_x, p_y, p_z = Player().GetPosition()
      SetInstantCameraInNowFrame(p_x, p_y + 2, p_z + 2, p_x + 6, p_y + 2, p_z + 2, DEFAULT_ANGLE, 0, 0)
      Player().LinkToRailMove("t0103_railmove", "rail_move_201")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().SetRailMoveInDimension3d()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().RailMoveGo()
      PlayAndManageSE(211010, 100, 0.5, 1, false, true)
      if Player().IsArrivalRailBothEnds() then
        StopManageSE(1, 1)
        SetExternalVariable("ride_state", "stop")
        CallEventScriptFunction("Prcs_t0103_ride_end")
      end
    end
  elseif gMapNum == 105 then
    local player_state = GetExternalVariable("player_state")
    if player_state == "enter_conbinishop" then
      EnterShopWithLocator("script_entershop", 10, "script_setpos", elapsed_frame)
    elseif player_state == "exit_conbinishop" then
      ExitShop("script_setpos", "script_entershop", elapsed_frame)
    elseif player_state == "shopping" then
      Player().Physics_SetGravity(0)
    end
    for gMobNum = 1, gMobTotal do
      gMobIndex = GetIndex(MOB, "Passenger" .. string.format("%02d", gMobNum))
      if gMobIndex == nil then
        goto lbl_3357
      end
      local train01 = GetIndex(MOB, "Train01")
      local train02 = GetIndex(MOB, "Train02")
      local train01_door_state = Mob(train01).GetSelfObjectScriptExternalVariable("door_state")
      local train02_door_state = Mob(train02).GetSelfObjectScriptExternalVariable("door_state")
      if train01_door_state == "open" then
        Mob(train01).Motion_PlayMotion("e003", 0, false)
        for i = 28, 45 do
          LocatorObject(GetIndex(GIM, "gim_00" .. string.format("%02d", i))).Motion_PlayMotion("e001", 0, false)
        end
      elseif train01_door_state == "close" then
        for i = 28, 45 do
          LocatorObject(GetIndex(GIM, "gim_00" .. string.format("%02d", i))).Motion_PlayMotion("e002", 0, false)
        end
        Mob(train01).Motion_PlayMotion("e004", 0, false)
        if Mob(train01).IsPlayingMotion("e004") == false then
          Mob(train01).SetSelfObjectScriptExternalVariable("door_state", "Initialize")
        end
      end
      if train02_door_state == "open" then
        Mob(train02).Motion_PlayMotion("e003", 0, false)
        for i = 10, 27 do
          LocatorObject(GetIndex(GIM, "gim_00" .. string.format("%02d", i))).Motion_PlayMotion("e001", 0, false)
        end
      elseif train02_door_state == "close" then
        for i = 10, 27 do
          LocatorObject(GetIndex(GIM, "gim_00" .. string.format("%02d", i))).Motion_PlayMotion("e002", 0, false)
        end
        Mob(train02).Motion_PlayMotion("e004", 0, false)
        if Mob(train02).IsPlayingMotion("e004") == false then
          Mob(train02).SetSelfObjectScriptExternalVariable("door_state", "Initialize")
        end
      end
      if gIsFinishInitialMobSet == false and Mob(gMobIndex).GetSelfObjectScriptExternalVariable("self_state") == "Initialize" then
        if gMobNum < 7 then
          Mob(gMobIndex).SetSelfObjectScriptExternalVariable("self_state", "start")
        elseif 7 <= gMobNum and gMobNum < 100 then
          Mob(gMobIndex).SetSelfObjectScriptExternalVariable("ini_positioning", "start")
        else
          gIsFinishInitialMobSet = true
        end
      end
      if Mob(gMobIndex).GetSelfObjectScriptExternalVariable("self_state") == "Initialize" then
        for i = 1, gMobTotal do
          local mob = GetIndex(MOB, "Passenger" .. string.format("%02d", i))
          if mob ~= nil and Mob(mob).GetSelfObjectScriptExternalVariable("self_state") == "wait_spawn" then
            goto lbl_2519
          end
        end
        Mob(gMobIndex).SetSelfObjectScriptExternalVariable("self_state", "wait_spawn")
      end
      ::lbl_2519::
      local train01 = GetIndex(MOB, "Train01")
      local train02 = GetIndex(MOB, "Train02")
      local train01_state = Mob(train01).GetSelfObjectScriptExternalVariable("Train01_state")
      local train02_state = Mob(train02).GetSelfObjectScriptExternalVariable("Train02_state")
      local rail_state = Mob(gMobIndex).GetSelfObjectScriptExternalVariable("rail_state")
      local self_state = Mob(gMobIndex).GetSelfObjectScriptExternalVariable("self_state")
      if self_state == "wait_arrive_train" then
        if train01_state == "arrive" and (rail_state == "rail_111" or rail_state == "rail_113" or rail_state == "rail_115") then
          Mob(gMobIndex).SetSelfObjectScriptExternalVariable("self_state", "get_on_train")
          LineCleanUp()
        end
        if train02_state == "arrive" and (rail_state == "rail_110" or rail_state == "rail_112" or rail_state == "rail_114") then
          Mob(gMobIndex).SetSelfObjectScriptExternalVariable("self_state", "get_on_train")
          LineCleanUp()
        end
      elseif self_state == "get_on_train" or self_state == "inside_train" then
        if train01_state == "going" and (rail_state == "rail_111" or rail_state == "rail_113" or rail_state == "rail_115") then
          Mob(gMobIndex).SetSelfObjectScriptExternalVariable("self_state", "reset")
        end
        if train02_state == "going" and (rail_state == "rail_110" or rail_state == "rail_112" or rail_state == "rail_114") then
          Mob(gMobIndex).SetSelfObjectScriptExternalVariable("self_state", "reset")
        end
      end
      if Mob(gMobIndex).GetSelfObjectScriptExternalVariable("position_state") == "request" then
        gIsSetPosition = false
      end
      local start, fin, add = gLoopRange[rail_state].start, gLoopRange[rail_state].fin, gLoopRange[rail_state].add
      if gIsSetPosition == false then
        for j = 1, 8 do
          if gIsSetPosition == true then
            break
          end
          for i = start, fin, add do
            if gLine[i][j] == 0 then
              Mob(gMobIndex).SetSelfObjectScriptExternalVariable("position_state", "Set_" .. string.format("%02d", i) .. "_" .. string.format("%02d", j))
              gLine[i][j] = gMobIndex
              gIsSetPosition = true
              break
            elseif j < 8 and gLine[i][j + 1] == 0 then
              Mob(gMobIndex).SetSelfObjectScriptExternalVariable("position_state", "Set_" .. string.format("%02d", i) .. "_" .. string.format("%02d", j + 1))
              gLine[i][j + 1] = gMobIndex
              gIsSetPosition = true
              break
            end
          end
        end
      end
      if self_state == "set_position" or self_state == "wait_arrive_train" then
        local line_num = tonumber(string.sub(Mob(gMobIndex).GetSelfObjectScriptExternalVariable("position_state"), 5, 6))
        local pos_num = tonumber(string.sub(Mob(gMobIndex).GetSelfObjectScriptExternalVariable("position_state"), -2))
        if line_num ~= nil and pos_num ~= nil then
          if pos_num % 2 == 0 then
            gLoopStart, gLoopEnd = 2, 8
          else
            gLoopStart, gLoopEnd = 1, 7
          end
          for i = gLoopStart, gLoopEnd, 2 do
            if gLine[line_num][i] == 0 and i < pos_num then
              Mob(gMobIndex).SetSelfObjectScriptExternalVariable("position_state", "Set_" .. string.format("%02d", line_num) .. "_" .. string.format("%02d", i))
              Mob(gMobIndex).SetSelfObjectScriptExternalVariable("pos_adjust_state", "start")
              gLine[line_num][i] = gMobIndex
              break
            end
          end
        end
      end
    end
  elseif gMapNum == 107 then
    local npc = GetIndex(NPC, "npc_0002")
    local npc_state = GetExternalVariable("npc_state")
    local player_state = GetExternalVariable("player_state")
    local player_move_state = GetExternalVariable("player_move_state")
    if npc_state == "move" then
      Npc(npc).Physics_SetCollisionContactForMapOnly()
      Npc(npc).LinkToRailMove("t0107_railmove", "rail_move_010")
      Npc(npc).SetRailMoveInDimension2d()
      Npc(npc).SetRailMoveSpeed(2)
      Npc(npc).RailMoveGo()
      if Npc(npc).IsArrivalRailBothEnds() then
        SetExternalVariable("npc_state", "move_end")
        SetExternalVariable("player_move_state", "move_standby")
      end
    elseif npc_state == "move_end" then
      Npc(npc).Move_SetRotationY(0, 20)
      if Npc(npc).GetRotationY() == 180 then
        SetExternalVariable("npc_state", "end")
      end
    elseif npc_state == "end" then
    end
    if FlagCheck(FLAG_MAIN_01_030) and not FlagCheck(FLAG_MAIN_01_060) then
      local total_frame = GetExternalVariable("total_frame")
      if FlagCheck(FLAG_GIMMICK_T01_070) then
        Player().Physics_SetCollisionContactForMapOnly()
        Player().Physics_SetGravity(0)
        Player().Move_Stop()
        Player().LinkToRailMove("t0107_railmove", "rail_move_200")
        if player_move_state == "move" then
          Player().DisableCullingInNowFrame()
          local pad_input_x = GetPadAxis(PAD_AXIS_RIGHT_X) * 15
          local pad_input_y = GetPadAxis(PAD_AXIS_RIGHT_Y) * 15
          local move_x = GetExternalVariable("move_x")
          local move_y = GetExternalVariable("move_y")
          local camera_speed = 0.05
          local camera_cancel_speed = 0.2
          local frame = 2
          if 0 < pad_input_x and pad_input_x >= move_x then
            SetExternalVariable("move_x", move_x + camera_speed)
          end
          if 0 < pad_input_y and pad_input_y >= move_y then
            SetExternalVariable("move_y", move_y + camera_speed)
          end
          if pad_input_x < 0 and pad_input_x <= move_x then
            SetExternalVariable("move_x", move_x - camera_speed)
          end
          if pad_input_y < 0 and pad_input_y <= move_y then
            SetExternalVariable("move_y", move_y - camera_speed)
          end
          if pad_input_x == 0 and pad_input_y == 0 then
            if 0 < move_x then
              SetExternalVariable("move_x", move_x - camera_cancel_speed)
            end
            if move_x < 0 then
              SetExternalVariable("move_x", move_x + camera_cancel_speed)
            end
            if 0 < move_y then
              SetExternalVariable("move_y", move_y - camera_cancel_speed)
            end
            if move_y < 0 then
              SetExternalVariable("move_y", move_y + camera_cancel_speed)
            end
            if math.floor(move_x) == 0 then
              SetExternalVariable("move_x", 0)
            end
            if math.floor(move_y) == 0 then
              SetExternalVariable("move_y", 0)
            end
          end
          local pc_rot = Player().GetRotationY()
          local pc_rot_vec_x, pc_rot_vec_z = GetUnitVector2D(pc_rot)
          local pc_rot_rev_vec_x, pc_rot_rev_vec_z = GetUnitVector2D(pc_rot - 145)
          local pc_x, _, pc_z = Player().GetPosition()
          local cam_pos_x = pc_x + pc_rot_rev_vec_x * 0.57
          local cam_pos_z = pc_z + pc_rot_rev_vec_z * 0.57
          local cam_aim_x = cam_pos_x + pc_rot_vec_x * 10
          local cam_aim_z = cam_pos_z + pc_rot_vec_z * 10
          if total_frame <= 45 and 15 < total_frame then
            SetInstantCameraInNowFrame(cam_aim_x + 2.5, 1.6, cam_aim_z, cam_pos_x, 1.6, cam_pos_z, 70, 30, 120, QUINTIC_OUT, QUINTIC_OUT)
          elseif 45 < total_frame then
            SetInstantCameraInNowFrame(cam_aim_x + 2.5, 1.6 + move_y * 2, cam_aim_z, cam_pos_x, 1.6, cam_pos_z, 70, frame, 120, QUINTIC_OUT, QUINTIC_OUT)
          end
          local operatedegrees = GetLeftAxisDegrees()
          local speed = 0
          local rail_direction = true
          local camera_rotate = GetCameraRotationY(CAMERA_OPERATED_BY_PLAYER)
          if IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil and total_frame > 75 and (operatedegrees <= 120 or 240 <= operatedegrees) then
            if player_state == "low" then
              speed = 0.85
            elseif player_state == "fast" then
              speed = 1.2
            end
            rail_direction = true
          end
          if total_frame <= 15 then
            speed = 2
          end
          Player().SetRailMoveDirection(rail_direction)
          Player().SetRailMoveSpeed(speed)
          Player().SetRailMoveInDimension2d()
          Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
          Player().RailMoveGo()
          SetExternalVariable("total_frame", total_frame + 1)
        elseif player_move_state == "wait" then
          Player().SetRailMoveDirection(true)
          Player().SetRailMoveSpeed(0)
          Player().SetRailMoveInDimension2d()
          Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.1)
          Player().RailMoveGo()
        elseif player_move_state == "move_standby" then
          Player().Physics_SetGravity(0)
          Player().Physics_SetCollisionContactForMapOnly()
          local player_pos_x, player_pos_y, player_pos_z = Player().GetPosition()
          local distance = GetDistanceBetweenTwoObject2D(player_pos_x, player_pos_z, -27.8551, 25.3081)
          Player().Move_Move2DToTarget(-27.8551, 25.3081, 3)
          if distance < 0.2 then
            SetExternalVariable("player_move_state", "move")
          end
        end
      end
    end
  elseif gMapNum == 108 then
    local x, y, z = Player().GetPosition()
    local player_state = GetExternalVariable("player_state")
    local rotateY = Player().GetRotationY()
    local vector_x, vector_z = GetUnitVector2D(rotateY)
    local relative_aim_x = vector_x * 5.64
    local relative_aim_z = vector_z * 5.89
    local relative_cam_x = vector_x * -1.49
    local relatevie_cam_z = vector_z * -0.89
    if player_state == "mapchange" then
      Cam.Inst:Set(x + relative_aim_x, y - 1.275, z + relative_aim_z, x + relative_cam_x, y + 2, z + relatevie_cam_z, DEFAULT_ANGLE, 0)
      Player().Motion_PlayMotion("e200", 0, false)
    elseif player_state == "clear" then
      ClearInstantCamera(30)
      SetExternalVariable("player_state", "Initialize")
    end
  elseif gMapNum ~= 109 or CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
  end
  ::lbl_3357::
end

function LineCleanUp()
  for i = 1, 36 do
    for j = 1, 8 do
      if gLine[i][j] == gMobIndex then
        gLine[i][j] = 0
      end
    end
  end
end

function OnFieldAttackSymbolEnemy(object_index, args)
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local enemy_name = SymbolEnemy(symbol_index).GetUniqueName()
  if args.by_field_attack == true then
    if enemy_name == "s202_kuramon01" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon01")
    elseif enemy_name == "s202_kuramon02" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon02")
    elseif enemy_name == "s202_kuramon03" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon03")
    elseif enemy_name == "s202_kuramon04" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon04")
    elseif enemy_name == "s202_kuramon05" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon05")
    elseif enemy_name == "s202_kuramon06" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon06")
    elseif enemy_name == "s202_kuramon07" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon07")
    elseif enemy_name == "s202_kuramon08" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon08")
    elseif enemy_name == "s202_kuramon09" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon09")
    elseif enemy_name == "s202_kuramon10" then
      CallEventScriptFunction("Prcs_t01_FAkuga", "s202_kuramon10")
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
      if gMapNum == 105 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H211) then
          FlagSet(FLAG_IS_DISCOVERY_H211)
        end
      elseif gMapNum == 109 and not FlagCheck(FLAG_IS_DISCOVERY_H210) then
        FlagSet(FLAG_IS_DISCOVERY_H210)
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
