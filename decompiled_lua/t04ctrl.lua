require("function_control")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H417")
DEFINE_FLAG("FLAG_MAIN_22_510")
DEFINE_FLAG("FLAG_MAIN_22_550")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  Player().LoadMotion("e200")
  if gMapNum == 401 then
    LoadRailMove(gRailMoveFile)
    LoadLocatorModel(gPlanData)
    local shop_door = GetIndex(GIM, "obj_0001")
    LocatorObject(shop_door).LoadMotion("e001")
    local sorry_child = GetIndex(NPC, "npc_0040")
    Npc(sorry_child).LoadMotion("e004")
    Npc(sorry_child).LoadMotion("fr01_01")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "initialize")
  if gMapNum == 401 then
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
  end
  if gMapNum == 404 then
    SetExternalVariable("talk", "off")
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 401 then
    local shop_door = GetIndex(GIM, "obj_0001")
    local shop_door_state = GetExternalVariable("shop_door_state")
    if shop_door_state == "come_from_shop1" then
      SetExternalVariable("shop_door_state", "near")
    else
      local distance = GetDistanceToObject(GIM, "obj_0001")
      if distance <= 2 then
        if FlagCheck(FLAG_MAIN_22_510) and not FlagCheck(FLAG_MAIN_22_550) then
        elseif shop_door_state == "far" or shop_door_state == "far_closed" then
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
  if gMapNum == 401 then
    local shop_door = GetIndex(GIM, "obj_0001")
    local shop_door_state = GetExternalVariable("shop_door_state")
    local player_state = GetExternalVariable("player_state")
    if FlagCheck(FLAG_MAIN_22_510) and not FlagCheck(FLAG_MAIN_22_550) then
      if shop_door_state == "near" then
        LocatorObject(shop_door).Motion_PlayMotionAndSetting("e001", 0, gShop1EvalFrame, 0, gShop1AnimEndFrame, 1, false)
      elseif shop_door_state == "far" then
        LocatorObject(shop_door).Motion_PlayMotionAndSetting("e001", 0, gShop1EvalFrame, gShop1AnimEndFrame, 0, 1, false)
      end
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
  end
  if gMapNum == 404 and GetExternalVariable("AfterCostumeTutorialEvent") == "on" then
    CallEventScriptFunction("M050_Event_118B")
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local enemy_name = SymbolEnemy(symbol_index).GetUniqueName()
  if args.by_field_attack == true and enemy_name == "s202_kuramon13" then
    CallEventScriptFunction("Prcs_t04_FAkuga", "s202_kuramon13")
  end
end

function OnFieldAttackSymbolEnemy(object_index, args)
  if gMapNum == 401 or gMapNum == 403 then
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
  if gMapNum == 401 or gMapNum == 403 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    if enemy_name == "berufe_01" or enemy_name == "berufe_02" or enemy_name == "berufe_03" or enemy_name == "berufe_04" then
      return false
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
      if gMapNum == 401 and not FlagCheck(FLAG_IS_DISCOVERY_H417) then
        FlagSet(FLAG_IS_DISCOVERY_H417)
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
