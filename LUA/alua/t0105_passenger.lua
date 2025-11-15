require("function_control")

function LoadRequest()
  print("===============LoadRequest [t0105_passenger] =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  Self().LoadMoveMotion("fw01")
  Self().LoadMotion("fn01")
  Self().LoadMotion("fn02")
  LoadLocatorModel(gPlanData)
  LoadRailMove(gRailMoveFile)
end

function Initialize()
  print("===============Initialize [t0105_passenger] =====================")
  SetExternalVariable("position_state", "Initialize")
  SetExternalVariable("self_state", "Initialize")
  SetExternalVariable("rail_state", "Initialize")
  SetExternalVariable("pos_adjust_state", "Initialize")
  DELAY_FRAME = math.random(45, 90)
  Self().SetRailMoveDistanceToTheRailMovingAlongTheRail(5)
  Self().SetRailMoveInDimension3d()
  Self().SetRailMoveSpeed(1.5)
  gFindDist = 4.15
  gPassengerStopCount = 0
  local stair01_x, stair01_y, stair01_z = GetLocatorPosOfLocatorModel("t0105p", "script_StairPos01", 0)
  local stair02_x, stair02_y, stair02_z = GetLocatorPosOfLocatorModel("t0105p", "script_StairPos02", 0)
  local self_x, self_y, self_z = Self().GetPosition()
  local stair01_dist = GetDistanceBetweenTwoObject2D(self_x, self_z, stair01_x, stair01_z)
  local stair02_dist = GetDistanceBetweenTwoObject2D(self_x, self_z, stair02_x, stair02_z)
  if stair01_dist < stair02_dist then
    local rail_num = GetControlScriptExternalVariable("train01_next_rail")
    local next_rail_num = rail_num + 1
    if 112 < next_rail_num then
      next_rail_num = 110
    end
    SetControlScriptExternalVariable("train01_next_rail", next_rail_num)
    Self().LinkToRailMove("t0105_railmove", rail_num)
    SetExternalVariable("rail_state", "rail_" .. tostring(rail_num))
    RespawnPos = {
      x = 5.6,
      y = 13.3,
      z = -56.6
    }
  else
    local rail_num = GetControlScriptExternalVariable("train02_next_rail")
    local next_rail_num = rail_num + 1
    if 115 < next_rail_num then
      next_rail_num = 113
    end
    SetControlScriptExternalVariable("train02_next_rail", next_rail_num)
    Self().LinkToRailMove("t0105_railmove", rail_num)
    SetExternalVariable("rail_state", "rail_" .. tostring(rail_num))
    RespawnPos = {
      x = 24.4,
      y = 13,
      z = -19.4
    }
  end
  local rail_state = GetExternalVariable("rail_state")
  if rail_state == "rail_111" or rail_state == "rail_113" or rail_state == "rail_115" then
    PosX = {
      -0.6,
      -0.6,
      -1.5,
      -1.5,
      -2.5,
      -2.5,
      -3.5,
      -3.5,
      4
    }
    PosZ = {
      0.8,
      -0.8,
      0.8,
      -0.8,
      0.8,
      -0.8,
      0.8,
      -0.8
    }
    gRotate = 90
  else
    PosX = {
      0.6,
      0.6,
      1.5,
      1.5,
      2.5,
      2.5,
      3.5,
      -3.5,
      -4
    }
    PosZ = {
      0.8,
      -0.8,
      0.8,
      -0.8,
      0.8,
      -0.8,
      0.8,
      -0.8
    }
    gRotate = -90
  end
  if rail_state == "rail_110" or rail_state == "rail_111" or rail_state == "rail_112" or rail_state == "rail_113" then
    gPassengerPosX, gPassengerPosZ = 0, 0
  else
    gPassengerPosX, gPassengerPosZ = 0, 23
  end
  local rate = math.random(100)
  if rate < 60 then
    gWaitmotion = "fn01"
  else
    gWaitmotion = "fn02"
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
end

function Update(elapsed_frame)
  do
    local check_position_state = GetExternalVariable("position_state")
    if check_position_state then
      local line = string.sub(check_position_state, 5, 6)
      if tonumber(line) then
        gPassengerPosX, gPassengerPosY, gPassengerPosZ = GetLocatorPosOfLocatorModel("t0105p", "script_PassengerPos" .. line, 0)
      end
    end
  end
  local self_x, self_y, self_z = Self().GetPosition()
  local self_state = GetExternalVariable("self_state")
  Self().Physics_SetGravity(0)
  Self().Physics_SetCollisionContactForNotHit()
  if GetExternalVariable("ini_positioning") == "start" then
    SetExternalVariable("position_state", "request")
    SetExternalVariable("self_state", "skip")
    SetExternalVariable("ini_positioning", "waiting")
  elseif GetExternalVariable("ini_positioning") == "waiting" then
    if GetExternalVariable("position_state") ~= "request" then
      local pos_num = tonumber(string.sub(GetExternalVariable("position_state"), -2))
      gPosAdjustX, gPosAdjustZ = PosX[pos_num], PosZ[pos_num]
      SetExternalVariable("ini_positioning", "set_position")
    end
  elseif GetExternalVariable("ini_positioning") == "set_position" and gPosAdjustX ~= nil then
    Self().CancelInvisible(10, false, false)
    Self().Move_SetPosition(gPassengerPosX + gPosAdjustX, 1.2, gPassengerPosZ + gPosAdjustZ)
    SetExternalVariable("self_state", "wait_arrive_train")
    SetExternalVariable("ini_positioning", "Initialize")
  end
  if self_state == "Initialize" then
    Self().Invisible(0, false)
  elseif self_state == "wait_spawn" then
    gPassengerStopCount = gPassengerStopCount + elapsed_frame
    if gPassengerStopCount >= DELAY_FRAME then
      SetExternalVariable("self_state", "start")
      gPassengerStopCount = 0
    else
      Self().Invisible(0, false)
    end
  elseif self_state == "start" then
    Self().CancelInvisible(10, false, false)
    local dist = GetDistanceBetweenTwoObject2D(self_x, self_z, gPassengerPosX, gPassengerPosZ)
    if dist < 7 and GetExternalVariable("position_state") == "Initialize" then
      SetExternalVariable("position_state", "request")
    end
    if dist > gFindDist then
      Self().RailMoveGo()
    else
      local pos_num = tonumber(string.sub(GetExternalVariable("position_state"), -2))
      gPosAdjustX, gPosAdjustZ = PosX[pos_num], PosZ[pos_num]
      SetExternalVariable("self_state", "set_position")
    end
  elseif self_state == "set_position" then
    if gPosAdjustX then
      Self().Move_Move2DToTarget(gPassengerPosX + gPosAdjustX, gPassengerPosZ + gPosAdjustZ, 1.5)
      local self_x, self_y, self_z = Self().GetPosition()
      local dist = GetDistanceBetweenTwoObject2D(self_x, self_z, gPassengerPosX + gPosAdjustX, gPassengerPosZ + gPosAdjustZ)
      if dist < 0.1 and -0.1 < dist then
        SetExternalVariable("self_state", "wait_arrive_train")
      end
    end
  elseif self_state == "wait_arrive_train" then
    Self().Motion_PlayMotion(gWaitmotion, 10, true)
    Self().Move_SetRotationY(gRotate, 7)
  elseif self_state == "get_on_train" then
    Self().Move_Move2DToTarget(gPassengerPosX + PosX[9], gPassengerPosZ, 1.2)
    local dist = GetDistanceBetweenTwoObject2D(self_x, self_z, gPassengerPosX + PosX[9], gPassengerPosZ)
    if dist < 1 and -1 < dist then
      SetExternalVariable("self_state", "inside_train")
    end
  elseif self_state == "inside_train" then
    local pos_num = tonumber(string.sub(GetExternalVariable("position_state"), -2))
    if pos_num % 2 == 0 then
      Self().Move_Move2D(0, 1)
    else
      Self().Move_Move2D(180, 1)
    end
  elseif self_state == "reset" then
    Self().Move_SetPosition(RespawnPos.x, RespawnPos.y, RespawnPos.z)
    Initialize()
  end
  local pos_adjust_state = GetExternalVariable("pos_adjust_state")
  if pos_adjust_state == "start" then
    SetExternalVariable("self_state", "start")
    SetExternalVariable("pos_adjust_state", "Initialize")
  end
end
