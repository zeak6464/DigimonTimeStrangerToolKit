require("function_control")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H415")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
TIMING_FRAME = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  Player().LoadMotion("e200")
  if gMapNum == 201 then
    LoadLocatorModel(gPlanData)
  elseif gMapNum == 203 then
    LoadLocatorModel(gPlanData)
    local shop_door = GetIndex(GIM, "obj_0001")
    LocatorObject(shop_door).LoadMotion("e001")
    local junkshop_door = GetIndex(GIM, "obj_0002")
    LocatorObject(junkshop_door).LoadMotion("e001")
    LocatorObject(junkshop_door).LoadMotion("e002")
    local toy_agumon = GetIndex(NPC, "npc_0501")
    LocatorObject(toy_agumon).LoadMotion("bd03")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "initialize")
  if gMapNum == 201 then
    SetExternalVariable("sweets_store", "non_check")
  elseif gMapNum == 203 then
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
    local junk_door = GetIndex(GIM, "obj_0002")
    print(junk_door)
    gJunkShopEvalFrame, gJunkShopWaitFrame = 0, 0
    gJunkShopAnimEndFrame = LocatorObject(junk_door).GetMotionDefaultEndFrame("e001")
    SetExternalVariable("junkshop_door_state", "far")
    SetExternalVariable("toy_state", "Initialize")
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 203 then
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
      elseif LocatorObject(shop_door).IsPlayingMotion("e001") then
        SetExternalVariable("shop_door_state", "far_closed")
      end
    end
    local junkshop_door = GetIndex(GIM, "obj_0002")
    local junkshop_door_state = GetExternalVariable("junkshop_door_state")
    if junkshop_door_state == "come_from_shop1" then
      SetExternalVariable("junkshop_door_state", "near")
    else
      local distance = GetDistanceToObject(GIM, "obj_0002")
      if distance <= 2 then
        if junkshop_door_state == "far" or junkshop_door_state == "far_closed" then
          SetExternalVariable("junkshop_door_state", "near")
        elseif LocatorObject(junkshop_door).IsPlayingMotion("e001") then
          SetExternalVariable("junkshop_door_state", "near_opened")
        end
        gJunkShopEvalFrame = LocatorObject(junkshop_door).GetMotionEvalFrame("e001")
      elseif junkshop_door_state == "near" or junkshop_door_state == "near_opened" then
        SetExternalVariable("junkshop_door_state", "far")
      elseif LocatorObject(junkshop_door).IsPlayingMotion("e001") then
        SetExternalVariable("junkshop_door_state", "far_closed")
      end
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
  if gMapNum == 201 then
    local player_state = GetExternalVariable("player_state")
    if player_state == "enter_drugshop" then
      EnterShop("shop_0003", 10, 30, elapsed_frame)
    elseif player_state == "exit_drugshop" then
      ExitShop("script_setpos_drugshop", "script_exit_drugshop", elapsed_frame)
    elseif player_state == "enter_otakushop" then
      EnterShop("shop_0002", 10, 60, elapsed_frame)
    elseif player_state == "exit_otakushop" then
      ExitShop("script_setpos_otakushop", "script_exit_otakushop", elapsed_frame)
    elseif player_state == "shopping" then
      Player().Physics_SetGravity(0)
    end
  elseif gMapNum == 203 then
    local shop_door = GetIndex(GIM, "obj_0001")
    local shop_door_state = GetExternalVariable("shop_door_state")
    local player_state = GetExternalVariable("player_state")
    if shop_door_state == "near" then
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
    local junkshop_door = GetIndex(GIM, "obj_0002")
    local junkshop_door_state = GetExternalVariable("junkshop_door_state")
    local player_state = GetExternalVariable("player_state")
    if junkshop_door_state == "near" then
      LocatorObject(junkshop_door).Motion_PlayMotionAndSetting("e001", 0, gJunkShopEvalFrame, 0, gJunkShopAnimEndFrame, 1, false)
    elseif junkshop_door_state == "far" then
      LocatorObject(junkshop_door).Motion_PlayMotionAndSetting("e001", 0, gJunkShopEvalFrame, gJunkShopAnimEndFrame, 0, 1, false)
    end
    if player_state == "enter_junkshop" then
      if 20 <= gJunkShopEvalFrame then
        gJunkShopWaitFrame = 0
      else
        gJunkShopWaitFrame = 15
      end
      EnterShopWithLocator("shop_0002", gJunkShopWaitFrame, "script_setpos_junkshop", elapsed_frame)
    elseif player_state == "exit_junkshop" then
      ExitShop("script_setpos_junkshop", "script_exit_junkshop", elapsed_frame)
    elseif player_state == "shopping" then
      Player().Move_SetRotationY(0, 10)
      Player().Physics_SetGravity(0)
    end
    local toy_agumon = GetIndex(NPC, "npc_0501")
    local toy_state = GetExternalVariable("toy_state")
    if toy_state == "start_move" then
      Npc(toy_agumon).Motion_PlayMotionAndSetting("bd03", 0, 60, 0, 60, 1, true)
    end
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local enemy_name = SymbolEnemy(symbol_index).GetUniqueName()
  if args.by_field_attack == true then
    if enemy_name == "s202_kuramon11" then
      CallEventScriptFunction("Prcs_t02_FAkuga", "s202_kuramon11")
    elseif enemy_name == "s202_kuramon12" then
      CallEventScriptFunction("Prcs_t02_FAkuga", "s202_kuramon12")
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
      if gMapNum == 203 and not FlagCheck(FLAG_IS_DISCOVERY_H415) then
        FlagSet(FLAG_IS_DISCOVERY_H415)
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
