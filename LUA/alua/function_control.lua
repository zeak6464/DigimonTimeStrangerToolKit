require("ctrl_define")

function GetIndex(type, name)
  if type == NPC then
    return NpcSystem.GetIndex(name)
  elseif type == MOB then
    return MobSystem.GetIndex(name)
  elseif type == GIM then
    return LocatorObjectSystem.GetIndex(name)
  elseif type == RUMOR then
    return RumorNpcSystem.GetIndex(name)
  elseif type == ENEMY then
    return SymbolEnemySystem.GetIndex(name)
  elseif type == GIMMICK or type == OGIM then
    return GimmickSystem.GetIndex(name)
  else
    print("======== ERROR GetIndex type dont match ========")
  end
end

function GetObjectNum(type)
  if type == ALL_OBJECT then
    return NpcSystem.GetObjectNum(), MobSystem.GetObjectNum()
  elseif type == NPC then
    return NpcSystem.GetObjectNum()
  elseif type == MOB then
    return MobSystem.GetObjectNum()
  elseif type == GIM then
    return LocatorObjectSystem.GetObjectNum()
  elseif type == ENEMY then
    return SymbolEnemySystem.GetObjectNum()
  elseif type == SELF then
    return SelfSystem.GetObjectNum()
  else
    print("======== ERROR GetObjectNum type dont match ========")
  end
end

function GetPositionAnyObject(type, index_or_locator)
  local index
  if type == GIM then
    index = GetIndex(type, index_or_locator)
  elseif type ~= PLAYER then
    index = index_or_locator
  end
  local obj_x, obj_y, obj_z = 0, 0, 0
  local prefix, map_num = GetMapPrefix(), GetMapNumber()
  local file_name = prefix .. string.format("%04d", map_num) .. "p"
  local motion_frame = 0
  if type == PLAYER then
    obj_x, obj_y, obj_z = Player().GetPosition()
  elseif type == NPC then
    obj_x, obj_y, obj_z = Npc(index).GetPosition()
  elseif type == MOB then
    obj_x, obj_y, obj_z = Mob(index).GetPosition()
  elseif type == RUMOR then
    obj_x, obj_y, obj_z = RumorNpc(index).GetPosition()
  elseif type == GIM then
    obj_x, obj_y, obj_z = LocatorObject(index).GetPosition()
  elseif type == ENEMY then
    obj_x, obj_y, obj_z = SymbolEnemy(index).GetPosition()
  elseif type == SELF then
    obj_x, obj_y, obj_z = Self().GetPosition()
  elseif type == GIMMICK then
    obj_x, obj_y, obj_z = Gimmick(index).GetPosition()
  end
  return obj_x, obj_y, obj_z
end

function GetPositionAnyObjectIndex(type, index_or_locator)
  local index = index_or_locator
  local obj_x, obj_y, obj_z = 0, 0, 0
  local prefix, map_num = GetMapPrefix(), GetMapNumber()
  local file_name = prefix .. string.format("%04d", map_num) .. "p"
  local motion_frame = 0
  if type == PLAYER then
    obj_x, obj_y, obj_z = Player().GetPosition()
  elseif type == NPC then
    obj_x, obj_y, obj_z = Npc(index).GetPosition()
  elseif type == MOB then
    obj_x, obj_y, obj_z = Mob(index).GetPosition()
  elseif type == RUMOR then
    obj_x, obj_y, obj_z = RumorNpc(index).GetPosition()
  elseif type == GIM then
    obj_x, obj_y, obj_z = LocatorObject(index).GetPosition()
  elseif type == ENEMY then
    obj_x, obj_y, obj_z = SymbolEnemy(index).GetPosition()
  elseif type == SELF then
    obj_x, obj_y, obj_z = Self().GetPosition()
  elseif type == GIMMICK then
    obj_x, obj_y, obj_z = Gimmick(index).GetPosition()
  end
  return obj_x, obj_y, obj_z
end

function GetDistanceBetweenTwoObject2D(object1_x, object1_z, object2_x, object2_z)
  local distance = math.sqrt((object1_x - object2_x) * (object1_x - object2_x) + (object1_z - object2_z) * (object1_z - object2_z))
  return distance
end

function GetDistanceToObject(type, index_or_locator)
  local player_x, player_y, player_z = Player().GetPosition()
  local obj_x, obj_y, obj_z = GetPositionAnyObject(type, index_or_locator)
  local distance = GetDistanceBetweenTwoObject2D(player_x, player_z, obj_x, obj_z)
  return distance
end

function IsArrivalPosition(move_obj_type, move_obj_index, target_type, target_index, permit_range)
  local is_arrival = false
  local move_obj_x, move_obj_y, move_obj_z = GetPositionAnyObjectIndex(move_obj_type, move_obj_index)
  local target_x, target_y, target_z = GetPositionAnyObjectIndex(target_type, target_index)
  local distance = GetDistanceBetweenTwoObject2D(move_obj_x, move_obj_z, target_x, target_z)
  if permit_range >= distance then
    is_arrival = true
  end
  return is_arrival
end

function OpenDoor(locator_name, wait_frame, elapsed_frame)
  if gIsUsedFuncOpenDoor == nil then
    gFuncOpenDoor = {
      State = "go_target",
      WaitCount = 0,
      RotateY = GetLocatorRot2dOfLocatorModel(gPlanData, locator_name, 0)
    }
    gIsUsedFuncOpenDoor = true
    print("######## Func OpenDoor Initialized ########")
  end
  local target_x, target_y, target_z = GetLocatorPosOfLocatorModel(gPlanData, locator_name, 0)
  Player().Physics_SetCollisionContactForNotHit()
  Player().Physics_SetGravity(0)
  if gFuncOpenDoor.State == "go_target" then
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(locator_name), 0) == true then
      gFuncOpenDoor.State = "set_rotateY"
    end
  elseif gFuncOpenDoor.State == "set_rotateY" then
    gFuncOpenDoor.WaitCount = gFuncOpenDoor.WaitCount + elapsed_frame
    if wait_frame <= gFuncOpenDoor.WaitCount then
      gFuncOpenDoor.State = "go_rotateY"
    end
  end
  if gFuncOpenDoor.State == "reset" then
    for key, val in pairs(gFuncOpenDoor) do
      gFuncOpenDoor[key] = nil
    end
    gIsUsedFuncOpenDoor = nil
    print("######## Func OpenDoor reset ########")
  end
  if gFuncOpenDoor.State == "go_target" then
    Player().Move_Move2DToTarget(target_x, target_z, 2)
  elseif gFuncOpenDoor.State == "set_rotateY" then
    Player().Move_SetRotationY(gFuncOpenDoor.RotateY, 10)
  elseif gFuncOpenDoor.State == "go_rotateY" then
    Player().Physics_SetCollisionContactForNotHit()
    Player().Physics_SetGravity(0)
    Player().Move_Move2D(gFuncOpenDoor.RotateY, 2)
  end
end

function EnterShop(locator_name, wait_frame, move_frame, elapsed_frame)
  if gIsUsedFuncOpenShopDoor == nil then
    gFuncOpenShopDoor = {
      State = "go_target",
      WaitCount = 0,
      RotateY = GetLocatorRot2dOfLocatorModel(gPlanData, locator_name, 0)
    }
    gIsUsedFuncOpenShopDoor = true
    print("######## Func OpenShopDoor Initialized ########")
  end
  local target_x, target_y, target_z = GetLocatorPosOfLocatorModel(gPlanData, locator_name, 0)
  Player().Physics_SetCollisionContactForNotHit()
  Player().Physics_SetGravity(0)
  if gFuncOpenShopDoor.State == "go_target" then
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(locator_name), 0) == true then
      gFuncOpenShopDoor.State = "set_rotateY"
    end
  elseif gFuncOpenShopDoor.State == "set_rotateY" then
    gFuncOpenShopDoor.WaitCount = gFuncOpenShopDoor.WaitCount + elapsed_frame
    if wait_frame <= gFuncOpenShopDoor.WaitCount then
      gFuncOpenShopDoor.State = "go_rotateY"
      gFuncOpenShopDoor.WaitCount = 0
    end
  end
  if gFuncOpenShopDoor.State == "reset" then
    for key, val in pairs(gFuncOpenShopDoor) do
      gFuncOpenShopDoor[key] = nil
    end
    gIsUsedFuncOpenShopDoor = nil
    print("######## Func OpenShopDoor reset ########")
  end
  if gFuncOpenShopDoor.State == "go_target" then
    Player().Move_Move2DToTarget(target_x, target_z, 2)
  elseif gFuncOpenShopDoor.State == "set_rotateY" then
    Player().Move_SetRotationY(gFuncOpenShopDoor.RotateY, 10)
  elseif gFuncOpenShopDoor.State == "go_rotateY" then
    Player().Move_Move2D(gFuncOpenShopDoor.RotateY, 2)
    gFuncOpenShopDoor.WaitCount = gFuncOpenShopDoor.WaitCount + elapsed_frame
    if move_frame <= gFuncOpenShopDoor.WaitCount then
      SetExternalVariable("player_state", "shopping")
      gFuncOpenShopDoor.State = "reset"
    end
  end
end

function EnterShopWithLocator(locator_name, wait_frame, enter_locator_name, elapsed_frame)
  if gIsUsedFuncOpenShopDoor == nil then
    gFuncOpenShopDoor = {
      State = "go_target",
      WaitCount = 0,
      RotateY = GetLocatorRot2dOfLocatorModel(gPlanData, locator_name, 0)
    }
    gIsUsedFuncOpenShopDoor = true
    print("######## Func OpenShopDoor Initialized ########")
  end
  local target_x, target_y, target_z = GetLocatorPosOfLocatorModel(gPlanData, locator_name, 0)
  Player().Physics_SetCollisionContactForNotHit()
  Player().Physics_SetGravity(0)
  if gFuncOpenShopDoor.State == "go_target" then
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(locator_name), 0) == true then
      gFuncOpenShopDoor.State = "set_rotateY"
    end
  elseif gFuncOpenShopDoor.State == "set_rotateY" then
    gFuncOpenShopDoor.WaitCount = gFuncOpenShopDoor.WaitCount + elapsed_frame
    if wait_frame <= gFuncOpenShopDoor.WaitCount then
      gFuncOpenShopDoor.State = "go_rotateY"
      gFuncOpenShopDoor.WaitCount = 0
    end
  end
  if gFuncOpenShopDoor.State == "reset" then
    for key, val in pairs(gFuncOpenShopDoor) do
      gFuncOpenShopDoor[key] = nil
    end
    gIsUsedFuncOpenShopDoor = nil
    print("######## Func OpenShopDoor reset ########")
  end
  if gFuncOpenShopDoor.State == "go_target" then
    Player().Move_Move2DToTarget(target_x, target_z, 2)
  elseif gFuncOpenShopDoor.State == "set_rotateY" then
    Player().Move_SetRotationY(gFuncOpenShopDoor.RotateY, 10)
  elseif gFuncOpenShopDoor.State == "go_rotateY" then
    Player().Move_Move2D(gFuncOpenShopDoor.RotateY, 2)
    local exit_x, exit_y, exit_z = GetLocatorPosOfLocatorModel(gPlanData, enter_locator_name, 0)
    Player().Move_Move2DToTarget(exit_x, exit_z, 2)
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(enter_locator_name), 0) == true then
      SetExternalVariable("player_state", "shopping")
      gFuncOpenShopDoor.State = "reset"
    end
  end
end

function OpenDoorAndEnterShopWithLocator(locator_name, wait_frame, enter_locator_name, elapsed_frame, door_locator)
  if gIsUsedFuncOpenShopDoor == nil then
    gFuncOpenShopDoor = {
      State = "go_target",
      WaitCount = 0,
      RotateY = GetLocatorRot2dOfLocatorModel(gPlanData, locator_name, 0)
    }
    gIsUsedFuncOpenShopDoor = true
    print("######## Func OpenShopDoor Initialized ########")
  end
  local target_x, target_y, target_z = GetLocatorPosOfLocatorModel(gPlanData, locator_name, 0)
  Player().Physics_SetCollisionContactForNotHit()
  Player().Physics_SetGravity(0)
  if gFuncOpenShopDoor.State == "go_target" then
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(locator_name), 0) == true then
      gFuncOpenShopDoor.State = "set_rotateY"
    end
  elseif gFuncOpenShopDoor.State == "set_rotateY" then
    gFuncOpenShopDoor.WaitCount = gFuncOpenShopDoor.WaitCount + elapsed_frame
    if wait_frame <= gFuncOpenShopDoor.WaitCount then
      gFuncOpenShopDoor.State = "go_rotateY"
      gFuncOpenShopDoor.WaitCount = 0
    end
  end
  if gFuncOpenShopDoor.State == "reset" then
    for key, val in pairs(gFuncOpenShopDoor) do
      gFuncOpenShopDoor[key] = nil
    end
    gIsUsedFuncOpenShopDoor = nil
    print("######## Func OpenShopDoor reset ########")
  end
  if gFuncOpenShopDoor.State == "go_target" then
    Player().Move_Move2DToTarget(target_x, target_z, 2)
  elseif gFuncOpenShopDoor.State == "set_rotateY" then
    if door_locator ~= nil then
      LocatorObject(GetIndex(GIM, door_locator)).Motion_PlayMotion("e001", 0, false)
    end
    Player().Move_SetRotationY(gFuncOpenShopDoor.RotateY, 10)
  elseif gFuncOpenShopDoor.State == "go_rotateY" then
    Player().Move_Move2D(gFuncOpenShopDoor.RotateY, 2)
    local exit_x, exit_y, exit_z = GetLocatorPosOfLocatorModel(gPlanData, enter_locator_name, 0)
    Player().Move_Move2DToTarget(exit_x, exit_z, 2)
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(enter_locator_name), 0) == true then
      SetExternalVariable("player_state", "shopping")
      gFuncOpenShopDoor.State = "reset"
    end
  end
end

function ExitShop(locator_name, exit_locator_name, elapsed_frame)
  if gIsUsedFuncExitShopDoor == nil then
    gFuncExitShopDoor = {
      State = "set_position",
      WaitCount = 0,
      RotateY = GetLocatorRot2dOfLocatorModel(gPlanData, locator_name, 0)
    }
    gIsUsedFuncExitShopDoor = true
    print("######## Func ExitShopDoor Initialized ########")
  end
  Player().Physics_SetCollisionContactForNotHit()
  Player().Physics_SetGravity(0)
  local target_x, target_y, target_z = GetLocatorPosOfLocatorModel(gPlanData, locator_name, 0)
  local exit_x, exit_y, exit_z = GetLocatorPosOfLocatorModel(gPlanData, exit_locator_name, 0)
  if gFuncExitShopDoor.State == "reset" then
    for key, val in pairs(gFuncExitShopDoor) do
      gFuncExitShopDoor[key] = nil
    end
    gIsUsedFuncExitShopDoor = nil
    print("######## Func ExitShopDoor reset ########")
  end
  if gFuncExitShopDoor.State == "set_position" then
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(locator_name), 0) == true then
      gFuncExitShopDoor.State = "set_rotateY"
    else
      Player().Move_SetPosition(target_x, target_y, target_z)
    end
  elseif gFuncExitShopDoor.State == "set_rotateY" then
    Player().Move_SetRotationY(gFuncExitShopDoor.RotateY, 10)
    gFuncExitShopDoor.WaitCount = gFuncExitShopDoor.WaitCount + elapsed_frame
    if gFuncExitShopDoor.WaitCount >= 10 then
      gFuncExitShopDoor.State = "go_rotateY"
      gFuncExitShopDoor.WaitCount = 0
    end
  elseif gFuncExitShopDoor.State == "go_rotateY" then
    Player().Move_Move2DToTarget(exit_x, exit_z, 2)
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(exit_locator_name), 0) == true then
      SetExternalVariable("player_state", "exit")
      gFuncExitShopDoor.State = "reset"
    end
  end
end

function Door_Warp(elapsed_frame, locator_name, exitlocator_name, enterdoor_index, exitdoor_index, waitframe, exitframe)
  map_prefix = GetMapPrefix()
  map_num = GetMapNumber()
  map_number = string.format("%04d", tostring(map_num))
  file_name = map_prefix .. tostring(map_number) .. "p"
  distance = GetDistanceToObject(LOCATOR, locator_name)
  locator_x, locator_y, locator_z = GetLocatorPosOfLocatorModel(file_name, locator_name, 0)
  exitlocator_x, exitlocator_y, exitlocator_z = GetLocatorPosOfLocatorModel(file_name, exitlocator_name, 0)
  if first_setting ~= "true" then
    SetExternalVariable("player_move_state", "move_doorfront")
    SetExternalVariable("door_state", "initialize")
    wait_count = 0
    Enter_rotateY = GetLocatorRot2dOfLocatorModel(file_name, locator_name, 0)
    Exit_rotateY = GetLocatorRot2dOfLocatorModel(file_name, exitlocator_name, 0)
    LocatorObject(enterdoor_index).Motion_PlayMotion("", 0, false)
    LocatorObject(exitdoor_index).Motion_PlayMotion("", 0, false)
    first_setting = "true"
  end
  if GetExternalVariable("player_move_state") == "move_doorfront" then
    Player().Move_Move2DToTarget(locator_x, locator_z, 2)
    if distance == 0 then
      wait_count = wait_count + elapsed_frame
      SetExternalVariable("door_state", "open")
      Player().Move_SetRotationY(Enter_rotateY, 10)
      if waitframe <= wait_count then
        SetExternalVariable("player_move_state", "enter")
        wait_count = 0
      end
    end
  end
  if GetExternalVariable("door_state") == "open" then
    LocatorObject(enterdoor_index).Motion_PlayMotion("e001", 10, false)
  end
  if GetExternalVariable("player_move_state") == "enter" then
    Player().Physics_SetCollisionContactForNotHit()
    Player().Physics_SetGravity(0)
    wait_count = wait_count + elapsed_frame
    Player().Move_Move2D(Enter_rotateY, 2)
    if exitframe <= wait_count then
      wait_count = 0
      SetExternalVariable("player_move_state", "warp")
    end
  end
  if GetExternalVariable("player_move_state") == "warp" then
    Player().Move_SetPosition(exitlocator_x, exitlocator_y, exitlocator_z)
    wait_count = wait_count + elapsed_frame
    SetExternalVariable("door_state", "exit_open")
    if waitframe <= wait_count then
      wait_count = 0
      SetExternalVariable("player_move_state", "exit")
    end
  end
  if GetExternalVariable("door_state") == "exit_open" then
    LocatorObject(exitdoor_index).Motion_PlayMotion("e001", 10, false)
  end
  if GetExternalVariable("player_move_state") == "exit" then
    Player().Physics_SetCollisionContactForNotHit()
    Player().Physics_SetGravity(0)
    Player().Move_Move2D(Exit_rotateY, 2)
    wait_count = wait_count + elapsed_frame
    if exitframe <= wait_count then
      print("##############################")
      SetExternalVariable("player_state", "initialize")
    end
  end
  if gPlayer_State == "initialize" then
    first_setting = "initialize"
    SetExternalVariable("player_move_state", "initialize")
  end
end

function EnterWarpDoor(locator_name, enter_locator_name, wait_frame, door_index, door_motion_name)
  if gIsUsedFuncEnterWarpDoor == nil then
    gFuncEnterWarpDoor = {
      State = "go_target",
      DoorState = "initialize",
      WaitCount = 0,
      RotateY = GetLocatorRot2dOfLocatorModel(gPlanData, locator_name, 0),
      EvalFrame = 0
    }
    gIsUsedFuncEnterWarpDoor = true
    print("######## Func EnterWarpDoor Initialized ########")
  end
  local target_x, target_y, target_z = GetLocatorPosOfLocatorModel(gPlanData, locator_name, 0)
  Player().Physics_SetCollisionContactForNotHit()
  Player().Physics_SetGravity(0)
  if gFuncEnterWarpDoor.State == "go_target" then
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(locator_name), 0) == true then
      gFuncEnterWarpDoor.State = "set_rotateY"
      gFuncEnterWarpDoor.DoorState = "open"
    end
  elseif gFuncEnterWarpDoor.State == "set_rotateY" and wait_frame <= gFuncEnterWarpDoor.EvalFrame then
    gFuncEnterWarpDoor.State = "go_rotateY"
  end
  if gFuncEnterWarpDoor.State == "reset" then
    for key, val in pairs(gFuncEnterWarpDoor) do
      gFuncEnterWarpDoor[key] = nil
    end
    gIsUsedFuncEnterWarpDoor = nil
    print("######## Func EnterWarpDoor reset ########")
  end
  if gFuncEnterWarpDoor.State == "go_target" then
    Player().Move_Move2DToTarget(target_x, target_z, 2)
  elseif gFuncEnterWarpDoor.State == "set_rotateY" then
    Player().Move_SetRotationY(gFuncEnterWarpDoor.RotateY, 10)
  elseif gFuncEnterWarpDoor.State == "go_rotateY" then
    Player().Move_Move2D(gFuncEnterWarpDoor.RotateY, 2)
    local exit_x, exit_y, exit_z = GetLocatorPosOfLocatorModel(gPlanData, enter_locator_name, 0)
    Player().Move_Move2DToTarget(exit_x, exit_z, 2)
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(enter_locator_name), 0) == true then
      SetExternalVariable("player_state", "enter")
      gFuncEnterWarpDoor.State = "reset"
    end
  end
  if gFuncEnterWarpDoor.DoorState == "open" then
    PlaySE(200001, 100)
    LocatorObject(door_index).Motion_PlayMotionAndSetting(door_motion_name, 0, 0, 0, 120, 1, false)
    gFuncEnterWarpDoor.DoorState = "get_evalframe"
  elseif gFuncEnterWarpDoor.DoorState == "get_evalframe" then
    gFuncEnterWarpDoor.EvalFrame = LocatorObject(door_index).GetMotionEvalFrame(door_motion_name)
    if LocatorObject(door_index).IsPlayingMotion(door_motion_name) == false then
      gFuncEnterWarpDoor.DoorState = "initialize"
    end
  end
end

function ExitWarpDoor(locator_name, exit_locator_name, wait_frame, door_index, door_motion_name)
  if gIsUsedFuncExitWarpDoor == nil then
    gFuncExitWarpDoor = {
      State = "set_position",
      DoorState = "initialize",
      RotateY = GetLocatorRot2dOfLocatorModel(gPlanData, locator_name, 0),
      EvalFrame = 0
    }
    gIsUsedFuncExitWarpDoor = true
    print("######## Func ExitWarpDoor Initialized ########")
  end
  Player().Physics_SetCollisionContactForNotHit()
  Player().Physics_SetGravity(0)
  local target_x, target_y, target_z = GetLocatorPosOfLocatorModel(gPlanData, locator_name, 0)
  local exit_x, exit_y, exit_z = GetLocatorPosOfLocatorModel(gPlanData, exit_locator_name, 0)
  if gFuncExitWarpDoor.State == "reset" then
    for key, val in pairs(gFuncExitWarpDoor) do
      gFuncExitWarpDoor[key] = nil
    end
    gIsUsedFuncExitWarpDoor = nil
    print("######## Func ExitWarpDoor reset ########")
  end
  if gFuncExitWarpDoor.State == "set_position" then
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(locator_name), 0) == true then
      gFuncExitWarpDoor.State = "set_rotateY"
      gFuncExitWarpDoor.DoorState = "open"
    else
      Player().Move_SetPosition(target_x, target_y, target_z)
    end
  elseif gFuncExitWarpDoor.State == "set_rotateY" then
    Player().Move_SetRotationY(gFuncExitWarpDoor.RotateY, 10)
    if wait_frame <= gFuncExitWarpDoor.EvalFrame then
      gFuncExitWarpDoor.State = "go_rotateY"
    end
  elseif gFuncExitWarpDoor.State == "go_rotateY" then
    Player().Move_Move2DToTarget(exit_x, exit_z, 2)
    if IsArrivalPosition(PLAYER, -1, GIM, LocatorObjectSystem.GetIndex(exit_locator_name), 0) == true then
      SetExternalVariable("player_state", "exit")
      gFuncExitWarpDoor.State = "reset"
    end
  end
  if gFuncExitWarpDoor.DoorState == "open" then
    PlaySE(200001, 100)
    LocatorObject(door_index).Motion_PlayMotionAndSetting(door_motion_name, 0, 0, 0, 120, 1, false)
    gFuncExitWarpDoor.DoorState = "get_evalframe"
  elseif gFuncExitWarpDoor.DoorState == "get_evalframe" then
    gFuncExitWarpDoor.EvalFrame = LocatorObject(door_index).GetMotionEvalFrame(door_motion_name)
    if LocatorObject(door_index).IsPlayingMotion(door_motion_name) == false then
      gFuncExitWarpDoor.DoorState = "initialize"
    end
  end
end

function TheaterDoorCam(theater_loc, start_loc, elapsed_frame)
  local loc_x, loc_y, loc_z = GetPositionAnyObject(GIM, theater_loc)
  local start_x, start_y, start_z = GetPositionAnyObject(GIM, start_loc)
  gAdjustCamX = math.abs(loc_x - start_x)
  gAdjustCamZ = math.abs(loc_z - start_z)
  if THEATER_DOOR_FRAME == nil then
    THEATER_DOOR_FRAME = 0
  else
    THEATER_DOOR_FRAME = THEATER_DOOR_FRAME + elapsed_frame
  end
  if THEATER_DOOR_FRAME <= 10 then
    if GetExternalVariable("theater_door_state") == "intro" then
      gCamAdjustDist = 1.4
    else
      gCamAdjustDist = 2.7
    end
  end
  if loc_x > start_x and loc_z > start_z then
    gCamXnum, gCamZnum = loc_x - gAdjustCamX * gCamAdjustDist, loc_z - gAdjustCamZ * gCamAdjustDist
  elseif loc_x > start_x and loc_z <= start_z then
    gCamXnum, gCamZnum = loc_x - gAdjustCamX * gCamAdjustDist, loc_z + gAdjustCamZ * gCamAdjustDist
  elseif loc_x <= start_x and loc_z > start_z then
    gCamXnum, gCamZnum = loc_x + gAdjustCamX * gCamAdjustDist, loc_z - gAdjustCamZ * gCamAdjustDist
  elseif loc_x <= start_x and loc_z <= start_z then
    gCamXnum, gCamZnum = loc_x + gAdjustCamX * gCamAdjustDist, loc_z + gAdjustCamZ * gCamAdjustDist
  end
  local theater_door_state = GetExternalVariable("theater_door_state")
  local theater_door = GetIndex(GIM, theater_loc)
  local rotateY = Player().GetRotationY()
  if theater_door_state == "intro" then
    THEATER_DOOR_FRAME = 0
    local angle = GetAngleToTarget2D(start_x, start_z, loc_x, loc_z)
    local adjustX, adjustZ = GetUnitVector2D(angle + 150)
    SetInstantCamera(loc_x, loc_y + 1.3, loc_z, start_x + adjustX * 1.2, start_y + 1.38, start_z + adjustZ * 1.2, 45, 0, LINEAR)
  end
  if theater_door_state == "create" then
    if THEATER_DOOR_FRAME >= 0 and THEATER_DOOR_FRAME < 70 then
      SetInstantCamera(loc_x, loc_y + 2.4, loc_z, gCamXnum, start_y + 1.5, gCamZnum, 45, 10, LINEAR)
      LocatorObject(theater_door).Motion_PlayMotion("e002", 0, false)
    end
  elseif theater_door_state == "open" then
    THEATER_DOOR_FRAME = 0
    LocatorObject(theater_door).Motion_PlayMotion("e004", 0, false)
    SetExternalVariable("theater_door_state", "walk_in")
  elseif theater_door_state == "walk_in" and THEATER_DOOR_FRAME >= 20 then
    gCamAdjustDist = 1
    SetInstantCamera(loc_x, loc_y + 1.8, loc_z, gCamXnum, start_y + 1.5, gCamZnum, 35, 80, LINEAR)
  end
  if theater_door_state == "loading" then
    SetFollowerCameraOperateRotationY(rotateY)
  elseif theater_door_state == "start" then
    LocatorObject(theater_door).SetEnablePlayerCheck(false)
    LocatorObject(theater_door).Motion_PlayMotionAndSetting("e004", 0, 0, 0, 0, 1, false)
    SetExternalVariable("theater_door_state", "disappear")
    PlaySE(401055, 100)
  elseif theater_door_state == "disappear" then
    if LocatorObject(theater_door).IsPlayingMotion("e004") == false then
      LocatorObject(theater_door).Motion_PlayMotion("e005", 0, false)
      SetExternalVariable("theater_door_state", "wait_motion")
      THEATER_DOOR_FRAME = 0
    end
  elseif theater_door_state == "wait_motion" and THEATER_DOOR_FRAME >= 140 then
    THEATER_DOOR_FRAME = 0
    LocatorObject(theater_door).Motion_PlayMotion("e001", 5, true)
    LocatorObject(theater_door).SetEnablePlayerCheck(true)
    SetExternalVariable("theater_state", "Initialize")
    SetExternalVariable("theater_door_state", "Initialize")
  end
  if theater_door_state == "cancel" then
    ClearInstantCamera(0, LINEAR)
    SetExternalVariable("theater_state", "Initialize")
    SetExternalVariable("theater_door_state", "Initialize")
  end
end

function MoveToNpc(npc_name, dist_adjust)
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos_x, npc_pos_y, npc_pos_z = GetPositionAnyObject(NPC, npc_index)
  local npc_degree = Npc(npc_index).GetRotationY()
  local npc_vector2d_x, npc_vector2d_z = GetUnitVector2D(npc_degree)
  local distance = 1.7
  local move_speed = 1.5
  if dist_adjust == nil then
    dist_adjust = 0
  end
  local move_x = npc_pos_x + npc_vector2d_x * (distance + dist_adjust)
  local move_z = npc_pos_z + npc_vector2d_z * (distance + dist_adjust)
  local pc_pos_x, pc_pos_y, pc_pos_z = GetPositionAnyObject(PLAYER, 1)
  local x_dist = math.abs(pc_pos_x - move_x)
  local z_dist = math.abs(pc_pos_z - move_z)
  if x_dist < 0.1 and z_dist < 0.1 then
    Player().Move_SetRotationY(npc_degree + 180, 10)
  else
    Player().Move_Move2DToTarget(move_x, move_z, move_speed)
  end
end

function LeaveHouseCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, locator, door_cam_state, save_state_x, save_state_z)
  local set_locator = GetLastPlayerSetLocator()
  local state = GetExternalVariable(door_cam_state)
  local s_cam_x = GetExternalVariable(save_state_x)
  local s_cam_z = GetExternalVariable(save_state_z)
  if locator == set_locator and state == "init" then
    SetExternalVariable(door_cam_state, "start")
  end
  if state == "start" then
    local left_pad_axis_x = GetPadAxis(PAD_AXIS_LEFT_X)
    local left_pad_axis_y = GetPadAxis(PAD_AXIS_LEFT_Y)
    local right_pad_axis_x = GetPadAxis(PAD_AXIS_RIGHT_X)
    local right_pad_axis_y = GetPadAxis(PAD_AXIS_RIGHT_Y)
    if Player().GetLastMoveSpeed() ~= 0 then
      local pc_rot_y = Player().GetRotationY()
      local vec_x, vec_z = GetUnitVector2D(pc_rot_y)
      local frame = GetTotalElapsedFrame()
      cam_x, cam_z = cam_x + vec_x * (frame * 0.05), cam_z + vec_z * (frame * 0.05)
      SetExternalVariable(save_state_x, cam_x)
      SetExternalVariable(save_state_z, cam_z)
    end
    if s_cam_x ~= 0 and s_cam_z ~= 0 then
      SetInstantCameraInNowFrame(aim_x, aim_y, aim_z, s_cam_x, cam_y, s_cam_z, 45, 1, 20)
    end
    if Player().GetLastMoveSpeed() == 0 and s_cam_x ~= 0 and s_cam_z ~= 0 then
      SetExternalVariable(door_cam_state, "wait")
    end
    if left_pad_axis_x ~= 0 or left_pad_axis_y ~= 0 or right_pad_axis_x ~= 0 or right_pad_axis_y ~= 0 then
      SetExternalVariable(door_cam_state, "end")
    end
  end
  if state == "wait" then
    local left_pad_axis_x = GetPadAxis(PAD_AXIS_LEFT_X)
    local left_pad_axis_y = GetPadAxis(PAD_AXIS_LEFT_Y)
    local right_pad_axis_x = GetPadAxis(PAD_AXIS_RIGHT_X)
    local right_pad_axis_y = GetPadAxis(PAD_AXIS_RIGHT_Y)
    if left_pad_axis_x ~= 0 or left_pad_axis_y ~= 0 or right_pad_axis_x ~= 0 or right_pad_axis_y ~= 0 then
      SetExternalVariable(door_cam_state, "end")
    end
    SetInstantCameraInNowFrame(aim_x, aim_y, aim_z, s_cam_x, cam_y, s_cam_z, 45, 1, 20)
  end
end

function SetFollowerCameraOperateRotation(rotateX, rotateY)
  SetFollowerCameraOperateRotationX(rotateX)
  SetFollowerCameraOperateRotationY(rotateY)
end

function StartFocusCamera(target_x, target_y, target_z, start_dist, cancel_dist, rotateX, camera_dist, camera_Ypos, blend_frame)
  local player_x, player_y, player_z = Player().GetPosition()
  local angle = GetAngleToTarget2D(target_x, target_z, player_x, player_z)
  local dist = GetDistanceBetweenTwoObject2D(target_x, target_z, player_x, player_z)
  if camera_dist == nil then
    camera_dist = 5
  end
  if camera_Ypos == nil then
    camera_Ypos = 1.5
  end
  if blend_frame == nil then
    blend_frame = 20
  end
  gTargetX = target_x
  gTargetY = target_y
  gTargetZ = target_z
  gAdjustNumX = math.abs(target_x - player_x)
  gAdjustNumZ = math.abs(target_z - player_z)
  local target_adjust = 1.5 + 10 / dist
  for i = 30, 0.1, -0.3 do
    if target_x > player_x and target_z > player_z then
      gCamX, gCamZ = player_x - gAdjustNumX / i, player_z - gAdjustNumZ / i
      if 100 < dist then
        gTargetX, gTargetZ, gTargetY = target_x - gAdjustNumX / target_adjust, target_z - gAdjustNumZ / target_adjust, target_y / target_adjust
      end
    elseif target_x > player_x and target_z <= player_z then
      gCamX, gCamZ = player_x - gAdjustNumX / i, player_z + gAdjustNumZ / i
      if 100 < dist then
        gTargetX, gTargetZ, gTargetY = target_x - gAdjustNumX / target_adjust, target_z + gAdjustNumZ / target_adjust, target_y / target_adjust
      end
    elseif target_x <= player_x and target_z > player_z then
      gCamX, gCamZ = player_x + gAdjustNumX / i, player_z - gAdjustNumZ / i
      if 100 < dist then
        gTargetX, gTargetZ, gTargetY = target_x + gAdjustNumX / target_adjust, target_z - gAdjustNumZ / target_adjust, target_y / target_adjust
      end
    elseif target_x <= player_x and target_z <= player_z then
      gCamX, gCamZ = player_x + gAdjustNumX / i, player_z + gAdjustNumZ / i
      if 100 < dist then
        gTargetX, gTargetZ, gTargetY = target_x + gAdjustNumX / target_adjust, target_z + gAdjustNumZ / target_adjust, target_y / target_adjust
      end
    end
    local player_x, player_y, player_z = Player().GetPosition()
    local dist_sub = GetDistanceBetweenTwoObject2D(gCamX, gCamZ, player_x, player_z)
    if camera_dist < dist_sub then
      break
    end
  end
  if start_dist > dist and cancel_dist < dist then
    SetInstantCamera(gTargetX, gTargetY, gTargetZ, gCamX, player_y + camera_Ypos, gCamZ, 45, blend_frame)
    gFocusCamera = "active"
  elseif gFocusCamera == "active" then
    if rotateX ~= nil and rotateX ~= -1 then
      SetFollowerCameraOperateRotationX(rotateX)
    end
    SetFollowerCameraOperateRotationY(angle + 180)
    ClearInstantCamera(30)
    gFocusCamera = "inactive"
  end
end

function EndFocusCamera(target_x, target_z, blend_frame, rotateX)
  local player_x, player_y, player_z = Player().GetPosition()
  local angle = GetAngleToTarget2D(target_x, target_z, player_x, player_z)
  if gFocusCamera == "active" then
    SetFollowerCameraOperateRotationY(angle + 180)
    if rotateX ~= nil then
      SetFollowerCameraOperateRotationX(rotateX)
    end
    ClearInstantCamera(blend_frame)
    gFocusCamera = "inactive"
  end
end

function SetStartInstantCameraInNowFrameEndPad(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, angle, start_frame, end_frame, end_flag, start_flag)
  local IsPadInput = function()
    local left_pad_axis_x = GetPadAxis(PAD_AXIS_LEFT_X)
    local left_pad_axis_y = GetPadAxis(PAD_AXIS_LEFT_Y)
    local right_pad_axis_x = GetPadAxis(PAD_AXIS_RIGHT_X)
    local right_pad_axis_y = GetPadAxis(PAD_AXIS_RIGHT_Y)
    if left_pad_axis_x ~= 0 or left_pad_axis_y ~= 0 or right_pad_axis_x ~= 0 or right_pad_axis_y ~= 0 then
      return true
    end
    return false
  end
  if not IsRunningVistaEvent() then
    if start_flag ~= nil then
      if FlagCheck(start_flag) and not FlagCheck(end_flag) then
        SetInstantCameraInNowFrame(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, angle, start_frame, end_frame)
        if IsPadInput() then
          FlagSet(end_flag)
        end
      end
    elseif not FlagCheck(end_flag) then
      SetInstantCameraInNowFrame(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, angle, start_frame, end_frame)
      if IsPadInput() then
        FlagSet(end_flag)
      end
    end
  end
end

function CameraClose(camera_length, camera_rotate)
  Player().DisableCullingInNowFrame()
  local pad_input_x = GetPadAxis(PAD_AXIS_RIGHT_X) * 15
  local pad_input_y = GetPadAxis(PAD_AXIS_RIGHT_Y) * 15
  local move_x = GetExternalVariable("move_x")
  local move_y = GetExternalVariable("move_y")
  local player_x, player_y, player_z = Player().GetPosition()
  local camera_speed = 0.05
  local camera_cancel_speed = 0.2
  local frame = 2
  if move_x == nil and move_y == nil then
    SetExternalVariable("move_x", 0)
    SetExternalVariable("move_y", 0)
  else
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
    local pc_rot_rev_vec_x, pc_rot_rev_vec_z = GetUnitVector2D(pc_rot - camera_rotate)
    local pc_x, _, pc_z = Player().GetPosition()
    local cam_pos_x = pc_x + pc_rot_rev_vec_x * camera_length
    local cam_pos_z = pc_z + pc_rot_rev_vec_z * camera_length
    local cam_aim_x = cam_pos_x + pc_rot_vec_x * 10
    local cam_aim_z = cam_pos_z + pc_rot_vec_z * 10
    SetInstantCameraInNowFrame(cam_aim_x, player_y + 1.6 + move_y * 2, cam_aim_z, cam_pos_x, player_y + 1.6, cam_pos_z, 70, frame, 120, QUINTIC_OUT, QUINTIC_OUT)
  end
end

function StartSeamlessJumpRide()
  if gPlayer_State == "jump_start" then
    gRailNumber = GetExternalVariable("jump_rail")
    gRailName = "rail_move_" .. gRailNumber
    gDirection = GetExternalVariable("direct_state")
    if gDirection == "advance" then
      gStartPoint = "start"
      gFirstMarker = "rail_marker_" .. gRailNumber .. "_first"
      gSecondMarker = "rail_marker_" .. gRailNumber .. "_second"
      gEndPoint = "end"
      gMultiply = 1
      Player().SetRailMoveDirection(true)
    elseif gDirection == "return" then
      gStartPoint = "end"
      gFirstMarker = "rail_marker_" .. gRailNumber .. "_second"
      gSecondMarker = "rail_marker_" .. gRailNumber .. "_first"
      gEndPoint = "start"
      gMultiply = -1
      Player().SetRailMoveDirection(false)
    end
    Player().Physics_SetCollisionContactForNotHit()
    Player().Physics_SetGravity(0)
    Player().LinkToRailMove(gRailMoveFile, gRailNumber)
    Player().ShowAttachment(1)
    local second = SecondFromFrame(22)
    local start_distance = GetRailNearestDistanceBetweenAnyTargets3D(gRailMoveFile, gRailName, gStartPoint, gFirstMarker) * gMultiply
    local start_speed = start_distance / second
    Player().SetRailMoveInDimension3d()
    Player().SetRailMoveSpeed(start_speed)
    Player().MoveMotion_DisableMoveMotionSet()
    Player().PlayAttachmentMotion(1, "r348_in02", 0, false)
    Player().Motion_PlayMotion("r348_in02", 0, false)
    Player().RailMoveGo()
    local camera_state = GetExternalVariable("camera_state")
    if camera_state == "normal" then
      CameraSwitchChangeByFile("cam53_railcam", "followcam_loc_02_01", true)
    elseif camera_state == "downward" then
      CameraSwitchChangeByFile("cam53_railcam", "followcam_loc_01_01", true)
    end
    if Player().IsPlayingMotion("r348_in02") == false then
      SetExternalVariable("player_state", "jump_loop")
    end
  elseif gPlayer_State == "jump_loop" then
    local loop_speed = GetExternalVariable("loop_speed")
    local player_x, player_y, player_z = Player().GetPosition()
    local distance_to_merker = GetRailNearestDistanceBetweenAnyTargets3D(gRailMoveFile, gRailName, player_x, player_y, player_z, gSecondMarker, gIndex) * gMultiply
    Player().PlayAttachmentMotion(1, "r348_loop02", 10, true)
    Player().Motion_PlayMotion("r348_loop02", 10, true)
    if loop_speed == "low" then
      Player().SetRailMoveSpeed(10)
    elseif loop_speed == "mid" then
      Player().SetRailMoveSpeed(15)
    elseif loop_speed == "high" then
      Player().SetRailMoveSpeed(30)
    end
    Player().RailMoveGo()
    if distance_to_merker <= 0 then
      SetExternalVariable("player_state", "jump_end")
    end
  elseif gPlayer_State == "jump_end" then
    local second = SecondFromFrame(22)
    local end_distance = GetRailNearestDistanceBetweenAnyTargets3D(gRailMoveFile, gRailName, gSecondMarker, gEndPoint, gIndex) * gMultiply
    local end_speed = end_distance / second
    Player().PlayAttachmentMotion(1, "r348_out02", 0, false)
    Player().Motion_PlayMotion("r348_out02", 0, false)
    Player().SetRailMoveSpeed(end_speed)
    Player().RailMoveGo()
    if Player().IsArrivalRailBothEnds() then
      SetExternalVariable("player_state", "finish")
    end
  elseif gPlayer_State == "finish" then
    Player().Physics_ResetCollisionContact()
    Player().Physics_ResetGravity()
    CameraSwitchChange("followcam_default_loc", true)
    Player().MoveMotion_StandbyMoveMotionSet("")
    SetExternalVariable("player_state", "Initialize")
    Player().HideAttachment(1)
    Player().PlayAttachmentMotion(1, "", 0, false)
  end
end

function StartSeamlessJumpRideh05()
  if gPlayer_State == "jump_start" then
    gRailNumber = GetExternalVariable("jump_rail")
    gRailName = "rail_move_" .. gRailNumber
    gDirection = GetExternalVariable("direct_state")
    if gDirection == "advance" then
      gStartPoint = "start"
      gFirstMarker = "rail_marker_" .. gRailNumber .. "_first"
      gSecondMarker = "rail_marker_" .. gRailNumber .. "_second"
      gEndPoint = "end"
      gMultiply = 1
      Player().SetRailMoveDirection(true)
    elseif gDirection == "return" then
      gStartPoint = "end"
      gFirstMarker = "rail_marker_" .. gRailNumber .. "_second"
      gSecondMarker = "rail_marker_" .. gRailNumber .. "_first"
      gEndPoint = "start"
      gMultiply = -1
      Player().SetRailMoveDirection(false)
    end
    Player().Physics_SetCollisionContactForNotHit()
    Player().Physics_SetGravity(0)
    Player().LinkToRailMove(gRailMoveFile, gRailNumber)
    Player().ShowAttachment(1)
    local second = SecondFromFrame(22)
    local start_distance = GetRailNearestDistanceBetweenAnyTargets3D(gRailMoveFile, gRailName, gStartPoint, gFirstMarker) * gMultiply
    local start_speed = start_distance / second
    Player().SetRailMoveInDimension3d()
    Player().SetRailMoveSpeed(start_speed)
    Player().MoveMotion_DisableMoveMotionSet()
    Player().PlayAttachmentMotion(1, "r348_in02", 0, false)
    Player().Motion_PlayMotion("r348_in02", 0, false)
    Player().RailMoveGo()
    local camera_state = GetExternalVariable("camera_state")
    if Player().IsPlayingMotion("r348_in02") == false then
      SetExternalVariable("player_state", "jump_loop")
    end
  elseif gPlayer_State == "jump_loop" then
    local loop_speed = GetExternalVariable("loop_speed")
    local player_x, player_y, player_z = Player().GetPosition()
    local distance_to_merker = GetRailNearestDistanceBetweenAnyTargets3D(gRailMoveFile, gRailName, player_x, player_y, player_z, gSecondMarker, gIndex) * gMultiply
    Player().PlayAttachmentMotion(1, "r348_loop02", 10, true)
    Player().Motion_PlayMotion("r348_loop02", 10, true)
    if loop_speed == "low" then
      Player().SetRailMoveSpeed(10)
    elseif loop_speed == "mid" then
      Player().SetRailMoveSpeed(15)
    elseif loop_speed == "high" then
      Player().SetRailMoveSpeed(30)
    end
    Player().RailMoveGo()
    if distance_to_merker <= 0 then
      SetExternalVariable("player_state", "jump_end")
    end
  elseif gPlayer_State == "jump_end" then
    local second = SecondFromFrame(22)
    local end_distance = GetRailNearestDistanceBetweenAnyTargets3D(gRailMoveFile, gRailName, gSecondMarker, gEndPoint, gIndex) * gMultiply
    local end_speed = end_distance / second
    Player().PlayAttachmentMotion(1, "r348_out02", 0, false)
    Player().Motion_PlayMotion("r348_out02", 0, false)
    Player().SetRailMoveSpeed(end_speed)
    Player().RailMoveGo()
    if Player().IsArrivalRailBothEnds() then
      SetExternalVariable("player_state", "finish")
    end
  elseif gPlayer_State == "finish" then
    Player().Physics_ResetCollisionContact()
    Player().Physics_ResetGravity()
    CameraSwitchChange("followcam_default_loc", true)
    Player().MoveMotion_StandbyMoveMotionSet("")
    SetExternalVariable("player_state", "Initialize")
    Player().HideAttachment(1)
    Player().PlayAttachmentMotion(1, "", 0, false)
  end
end

function LoadRideZip()
  Player().LoadMoveMotion(ATTACH_ZIP.move_set)
  Player().LoadAttachment(ATTACH_ZIP.id)
  Player().LoadAttachmentMotion(ATTACH_ZIP.id, ATTACH_ZIP.motion)
  AddCameraLoad(ATTACH_ZIP.cam_file)
end

function ReadyRideZip()
  local speed = 15
  local zip_rail = GetExternalVariable("zip_rail")
  Player().Physics_SetGravity(0)
  Player().LinkToRailMove(gRailMoveFile, zip_rail)
  Player().SetRailMoveSpeed(speed)
  Player().SetRailMoveDirection(true)
  Player().SetRailMoveInDimension3d()
  Player().Physics_SetCollisionContactForNotHit()
  Player().ShowAttachment(ATTACH_ZIP.id)
  Player().MoveMotion_StandbyMoveMotionSet(ATTACH_ZIP.move_set)
  Player().Motion_StartMoveMotion(0)
  CameraSwitchChangeByFile(ATTACH_ZIP.cam_file, ATTACH_ZIP.cam, false)
end

function RideZipFinish()
  CameraSwitchChange("followcam_default_loc", true)
  Player().MoveMotion_StandbyMoveMotionSet("")
  SetExternalVariable("player_state", "Initialize")
  Player().HideAttachment(ATTACH_ZIP.id)
end

function CtrlLoadPlayerMotion(motion_name, ...)
  local tb = table.pack(motion_name, ...)
  for i = 1, #tb do
    Player().LoadMotion(tb[i])
  end
end

function CtrlLoadNPCMotion(unique_name, motion_name, ...)
  local index = GetIndex(NPC, unique_name)
  local tb = table.pack(motion_name, ...)
  for i = 1, #tb do
    Npc(index).LoadMotion(tb[i])
  end
end

function CtrlLoadMobMotion(unique_name, default_motion, ...)
  local tb_mot = table.pack(default_motion, ...)
  local index = GetIndex(MOB, unique_name)
  for i = 1, #tb_mot do
    Mob(index).LoadMotion(tb_mot[i])
  end
end

function CtrlLoadRumorMotion(unique_name, default_motion, ...)
  local tb_mot = table.pack(default_motion, ...)
  local index = GetIndex(RUMOR, unique_name)
  for i = 1, #tb_mot do
    RumorNpc(index).LoadMotion(tb_mot[i])
  end
end

function CtrlLoadSelfMotion(default_motion, ...)
  local tb_mot = table.pack(default_motion, ...)
  for i = 1, #tb_mot do
    if type(tb_mot[i]) == "string" then
      Self().LoadMotion(tb_mot[i])
    end
    if type(tb_mot[i]) == "table" then
      for j = 1, #tb_mot[i] do
        Self().LoadMotion(tb_mot[i][j])
      end
    end
  end
end

function AdulationDigiNPC(state_name, unique_name)
  local index = GetIndex(NPC, unique_name)
  local state = GetExternalVariable(state_name)
  if index == nil then
    return
  end
  if state == "move" then
    local npc_pos_x, npc_pos_y, npc_pos_z = Npc(index).GetPosition()
    local py_pos_x, py_pos_y, py_pos_z = Player().GetPosition()
    local y_degree = GetAngleToTarget2D(npc_pos_x, npc_pos_z, py_pos_x, py_pos_z)
    Npc(index).Physics_SetupCollisionTypeMovable()
    Npc(index).Physics_SetCollisionContactForMapOnly()
    Npc(index).SetEnablePlayerCheck(false)
    Npc(index).Motion_PlayMotion("br01", 10, true)
    Npc(index).Move_Move2D(y_degree, 9)
    local distance = GetDistanceBetweenTwoObject2D(npc_pos_x, npc_pos_z, py_pos_x, py_pos_z)
    if distance <= 3 then
      SetExternalVariable(state_name, "stop")
    end
    if 8 <= distance then
      SetExternalVariable(state_name, "warp")
    end
  end
  if state == "warp" then
    Npc(index).SetEnablePlayerCheck(false)
    Npc(index).Physics_SetCollisionContactForMapOnly()
    local rot = Player().GetRotationY()
    local vector2d_x, vector2d_z = GetUnitVector2D(rot)
    local py_pos_x, py_pos_y, py_pos_z = Player().GetPosition()
    Npc(index).Move_SetPosition(py_pos_x, py_pos_y, py_pos_z)
    Npc(index).Move_SetRotationY(rot, 0)
    SetExternalVariable(state_name, "stop")
  end
  if state == "stop" then
    Npc(index).SetEnablePlayerCheck(false)
    local npc_pos_x, npc_pos_y, npc_pos_z = Npc(index).GetPosition()
    local py_pos_x, py_pos_y, py_pos_z = Player().GetPosition()
    Npc(index).Physics_SetCollisionContactForMapOnly()
    Npc(index).Motion_PlayMotion("bn01", 10, true)
    Npc(index).Move_Stop()
    local distance = GetDistanceBetweenTwoObject2D(npc_pos_x, npc_pos_z, py_pos_x, py_pos_z)
    if 4 <= distance then
      SetExternalVariable(state_name, "move")
    end
  end
end

function LeadDigiNPC(state_name, unique_name)
end

function SelfPlayRandMotion(unique_name, default_motion, motion_prob, ...)
  local IsorationTableForMotAndProb = function(tables)
    local tb_motion = {}
    local tb_prob = {}
    for i = 1, #tables do
      if i % 2 ~= 0 then
        table.insert(tb_motion, tables[i])
      end
      if i % 2 == 0 then
        table.insert(tb_prob, tables[i])
      end
    end
    return tb_motion, tb_prob
  end
  local GetAllProb = function(prob_table)
    local all_prob = 0
    for i = 1, #prob_table do
      all_prob = all_prob + prob_table[i]
    end
    return all_prob
  end
  local SelectMotion = function(prob_table, select_prob)
    local prob = 0
    for i = 1, #prob_table do
      prob = prob + prob_table[i]
      if select_prob <= prob then
        SetExternalVariable(unique_name, i)
        break
      end
    end
  end
  local GetMotionEvalAndEndFrame = function(motion_name)
    return Self().GetMotionEvalFrame(motion_name), Self().GetMotionEndFrame(motion_name)
  end
  local ChangeFloatToInt = function(num)
    return math.floor(num + 0.5)
  end
  local GetRandNum = function(max_num)
    math.randomseed(os.time())
    return math.random(max_num)
  end
  local PlayMotion = function(motion, mot_cnt)
    local value_type = type(motion)
    if value_type == "string" then
      Self().Motion_PlayMotion(motion, 15, true)
    end
    if value_type == "table" then
      Self().Motion_PlayMotion(motion[mot_cnt], 15, true)
    end
  end
  local ChangeMotion = function(motion, now_mot, mot_cnt, prob)
    local value_type = type(motion)
    local all_prob = 0
    if value_type == "string" and now_mot ~= 1 then
      SetExternalVariable(unique_name, 1)
      local cnt_var = unique_name .. "_cnt"
      SetExternalVariable(cnt_var, 1)
    end
    if value_type == "string" and now_mot == 1 then
      all_prob = GetAllProb(prob)
      SelectMotion(prob, GetRandNum(all_prob))
    end
    if value_type == "table" then
      if mot_cnt == #motion and now_mot ~= 1 then
        SetExternalVariable(unique_name, 1)
        local cnt_var = unique_name .. "_cnt"
        SetExternalVariable(cnt_var, 1)
      end
      if mot_cnt == #motion and now_mot == 1 then
        all_prob = GetAllProb(prob)
        SelectMotion(prob, GetRandNum(all_prob))
      end
      if mot_cnt ~= #motion then
        local cnt_var = unique_name .. "_cnt"
        SetExternalVariable(cnt_var, mot_cnt + 1)
      end
    end
  end
  local now_mot = GetExternalVariable(unique_name)
  local cnt_var = unique_name .. "_cnt"
  local mot_cnt = GetExternalVariable(cnt_var)
  local motions = table.pack(default_motion, motion_prob, ...)
  local mot, prob = IsorationTableForMotAndProb(motions)
  local now_mot_frame = 0
  local end_mot_frame = 0
  if type(mot[now_mot]) == "string" then
    now_mot_frame, end_mot_frame = GetMotionEvalAndEndFrame(mot[now_mot])
  end
  if type(mot[now_mot]) == "table" then
    now_mot_frame, end_mot_frame = GetMotionEvalAndEndFrame(mot[now_mot][mot_cnt])
  end
  now_mot_frame = ChangeFloatToInt(now_mot_frame)
  end_mot_frame = ChangeFloatToInt(end_mot_frame)
  if now_mot_frame == end_mot_frame then
    ChangeMotion(mot[now_mot], now_mot, mot_cnt, prob)
    now_mot = GetExternalVariable(unique_name)
    mot_cnt = GetExternalVariable(cnt_var)
  end
  PlayMotion(mot[now_mot], mot_cnt)
end

function ctrl_StringSplit(str, sep)
  sep = sep or "%s"
  local result = {}
  for s in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(result, s)
  end
  return result
end
