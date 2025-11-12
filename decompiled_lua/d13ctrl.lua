require("function_control")
DEFINE_FLAG("FLAG_GIMMICK_D13_010")
DEFINE_FLAG("FLAG_GIMMICK_D13_020")
DEFINE_FLAG("FLAG_GIMMICK_D13_030")
DEFINE_FLAG("FLAG_GIMMICK_D13_040")
DEFINE_FLAG("FLAG_GIMMICK_D13_050")
DEFINE_FLAG("FLAG_GIMMICK_D13_060")
DEFINE_FLAG("FLAG_GIMMICK_D13_100")
DEFINE_FLAG("FLAG_GIMMICK_D13_110")
DEFINE_FLAG("FLAG_GIMMICK_D13_160")
DEFINE_FLAG("FLAG_GIMMICK_D13_170")
DEFINE_FLAG("FLAG_GIMMICK_D13_180")
DEFINE_FLAG("FLAG_GIMMICK_D13_190")
DEFINE_FLAG("FLAG_GIMMICK_D13_200")
DEFINE_FLAG("FLAG_GIMMICK_D13_210")
DEFINE_FLAG("FLAG_MAIN_17_031")
DEFINE_FLAG("FLAG_MAIN_17_061")
DEFINE_FLAG("FLAG_MAIN_17_062")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 1301 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
    local index = GetIndex(NPC, "npc_0003")
    Npc(index).LoadMoveMotion("")
  elseif gMapNum == 1302 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 1304 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 1301 then
    local door = GetIndex(GIM, "gim_0003")
    gDoor1EvalFrame, gDoor1WaitFrame = 0, 0
    gDoor1AnimEndFrame = LocatorObject(door).GetMotionDefaultEndFrame("e001")
    SetExternalVariable("door_state", "far")
    SetExternalVariable("researcher_state", nil)
  elseif gMapNum == 1302 then
  elseif gMapNum == 1304 then
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 1301 then
    if FlagCheck(FLAG_GIMMICK_D13_100) and not FlagCheck(FLAG_GIMMICK_D13_110) then
      local enemy_security = GetIndex(ENEMY, "enemysecurity_01")
      local enemy_security_state = GetExternalVariable("enemy_security_state")
      local obj_security = GetIndex(GIMMICK, "security_01")
      if SymbolEnemy(enemy_security).IsSymbolOfDiscoveryInAction() then
        Gimmick(obj_security).DisablePlayerCheckInNowFrame()
      end
    end
    if FlagCheck(FLAG_GIMMICK_D13_010) or FlagCheck(FLAG_GIMMICK_D13_020) or FlagCheck(FLAG_GIMMICK_D13_030) or FlagCheck(FLAG_GIMMICK_D13_040) or FlagCheck(FLAG_GIMMICK_D13_050) or FlagCheck(FLAG_GIMMICK_D13_060) then
      local door = 0
      local door_state = GetExternalVariable("door_state")
      local distance = 0
      local col_name
      local colse_dist = 3
      if FlagCheck(FLAG_GIMMICK_D13_010) then
        door = GetIndex(GIM, "gim_0003")
        distance = GetDistanceToObject(GIM, "gim_0003")
        col_name = "wall_cl_0001"
        Gimmick(GetIndex(GIMMICK, "door_access_01")).SetEnablePlayerCheck(false)
        if 4 < distance and not FlagCheck(FLAG_GIMMICK_D13_160) then
          FlagClear(FLAG_GIMMICK_D13_010)
          Gimmick(GetIndex(GIMMICK, "door_access_01")).SetEnablePlayerCheck(true)
        end
        if FlagCheck(FLAG_GIMMICK_D13_160) then
          colse_dist = 5
        end
      end
      if FlagCheck(FLAG_GIMMICK_D13_020) then
        door = GetIndex(GIM, "gim_0004")
        distance = GetDistanceToObject(GIM, "gim_0004")
        col_name = "wall_cl_0006"
        Gimmick(GetIndex(GIMMICK, "door_access_02")).SetEnablePlayerCheck(false)
        if 4 < distance and not FlagCheck(FLAG_GIMMICK_D13_170) then
          FlagClear(FLAG_GIMMICK_D13_020)
          Gimmick(GetIndex(GIMMICK, "door_access_02")).SetEnablePlayerCheck(true)
        end
        if FlagCheck(FLAG_GIMMICK_D13_170) then
          colse_dist = 5
        end
      end
      if FlagCheck(FLAG_GIMMICK_D13_030) then
        door = GetIndex(GIM, "gim_0005")
        distance = GetDistanceToObject(GIM, "gim_0005")
        col_name = "wall_cl_0003"
        Gimmick(GetIndex(GIMMICK, "door_access_03")).SetEnablePlayerCheck(false)
        if 4 < distance and not FlagCheck(FLAG_GIMMICK_D13_180) then
          FlagClear(FLAG_GIMMICK_D13_030)
          Gimmick(GetIndex(GIMMICK, "door_access_03")).SetEnablePlayerCheck(true)
        end
        if FlagCheck(FLAG_GIMMICK_D13_180) then
          colse_dist = 5
        end
      end
      if FlagCheck(FLAG_GIMMICK_D13_040) then
        door = GetIndex(GIM, "gim_0006")
        distance = GetDistanceToObject(GIM, "gim_0006")
        col_name = "wall_cl_0004"
        Gimmick(GetIndex(GIMMICK, "door_access_04")).SetEnablePlayerCheck(false)
        if 4 < distance and not FlagCheck(FLAG_GIMMICK_D13_190) then
          FlagClear(FLAG_GIMMICK_D13_040)
          Gimmick(GetIndex(GIMMICK, "door_access_04")).SetEnablePlayerCheck(true)
        end
        if FlagCheck(FLAG_GIMMICK_D13_190) then
          colse_dist = 5
        end
      end
      if FlagCheck(FLAG_GIMMICK_D13_050) then
        door = GetIndex(GIM, "gim_0007")
        distance = GetDistanceToObject(GIM, "gim_0007")
        col_name = "wall_cl_0005"
        Gimmick(GetIndex(GIMMICK, "door_access_05")).SetEnablePlayerCheck(false)
        if 4 < distance and not FlagCheck(FLAG_GIMMICK_D13_200) then
          FlagClear(FLAG_GIMMICK_D13_050)
          Gimmick(GetIndex(GIMMICK, "door_access_05")).SetEnablePlayerCheck(true)
        end
        if FlagCheck(FLAG_GIMMICK_D13_200) then
          colse_dist = 5
        end
      end
      if FlagCheck(FLAG_GIMMICK_D13_060) then
        door = GetIndex(GIM, "gim_0011")
        distance = GetDistanceToObject(GIM, "gim_0011")
        col_name = "wall_cl_0007"
        Gimmick(GetIndex(GIMMICK, "door_access_06")).SetEnablePlayerCheck(false)
        if 4 < distance and not FlagCheck(FLAG_GIMMICK_D13_210) then
          FlagClear(FLAG_GIMMICK_D13_060)
          Gimmick(GetIndex(GIMMICK, "door_access_06")).SetEnablePlayerCheck(true)
        end
        if FlagCheck(FLAG_GIMMICK_D13_210) then
          colse_dist = 5
        end
      end
      if distance <= colse_dist then
        if door_state == "far" or door_state == "far_closed" then
          SetExternalVariable("door_state", "near")
        elseif LocatorObject(door).IsPlayingMotion("e001") then
          SetExternalVariable("door_state", "near_opened")
          if LocatorObject(door).GetMotionEvalFrame("e001") >= 45 then
            DisableEventCollisionInNowFrame(col_name)
          end
        else
          DisableEventCollisionInNowFrame(col_name)
        end
        gDoor1EvalFrame = LocatorObject(door).GetMotionEvalFrame("e001")
      elseif door_state == "near" or door_state == "near_opened" then
        SetExternalVariable("door_state", "far")
      elseif LocatorObject(door).IsPlayingMotion("e001") then
        SetExternalVariable("door_state", "far_closed")
      end
    else
      SetExternalVariable("door_state", "far")
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
  if gMapNum == 1301 then
    if FlagCheck(FLAG_GIMMICK_D13_010) or FlagCheck(FLAG_GIMMICK_D13_020) or FlagCheck(FLAG_GIMMICK_D13_030) or FlagCheck(FLAG_GIMMICK_D13_040) or FlagCheck(FLAG_GIMMICK_D13_050) or FlagCheck(FLAG_GIMMICK_D13_060) then
      local door = 0
      local door_state = GetExternalVariable("door_state")
      local distance = 0
      if FlagCheck(FLAG_GIMMICK_D13_010) then
        door = GetIndex(GIM, "gim_0003")
        distance = GetDistanceToObject(GIM, "gim_0003")
      end
      if FlagCheck(FLAG_GIMMICK_D13_020) then
        door = GetIndex(GIM, "gim_0004")
        distance = GetDistanceToObject(GIM, "gim_0004")
      end
      if FlagCheck(FLAG_GIMMICK_D13_030) then
        door = GetIndex(GIM, "gim_0005")
        distance = GetDistanceToObject(GIM, "gim_0005")
      end
      if FlagCheck(FLAG_GIMMICK_D13_040) then
        door = GetIndex(GIM, "gim_0006")
        distance = GetDistanceToObject(GIM, "gim_0006")
      end
      if FlagCheck(FLAG_GIMMICK_D13_050) then
        door = GetIndex(GIM, "gim_0007")
        distance = GetDistanceToObject(GIM, "gim_0007")
      end
      if FlagCheck(FLAG_GIMMICK_D13_060) then
        door = GetIndex(GIM, "gim_0011")
        distance = GetDistanceToObject(GIM, "gim_0011")
      end
      if door_state == "near" then
        LocatorObject(door).Motion_PlayMotionAndSetting("e001", 0, gDoor1EvalFrame, 0, gDoor1AnimEndFrame, 2, false)
        PlayAndManageSE(200024, 50, 0, 1, true, true)
      elseif door_state == "far" then
        LocatorObject(door).Motion_PlayMotionAndSetting("e001", 0, gDoor1EvalFrame, gDoor1AnimEndFrame, 0, 1, false)
        PlayAndManageSE(200024, 50, 0, 1, true, true)
      end
    end
    if FlagCheck(FLAG_GIMMICK_D13_100) and not FlagCheck(FLAG_GIMMICK_D13_110) then
      local enemy_security = GetIndex(ENEMY, "enemysecurity_01")
      local enemy_security_state = GetExternalVariable("enemy_security_state")
      local obj_security = GetIndex(GIMMICK, "security_01")
      local x, y, z = SymbolEnemy(enemy_security).GetPosition()
      Gimmick(obj_security).Move_SetPosition(x, y, z)
      if SymbolEnemy(enemy_security).IsSymbolOfDiscoveryInAction() then
      end
    end
    if FlagCheck(FLAG_MAIN_17_061) and not FlagCheck(FLAG_MAIN_17_062) then
      local researcher_state = GetExternalVariable("researcher_state")
      if researcher_state == "start" then
        local index = GetIndex(NPC, "npc_0003")
        Npc(index).LinkToRailMove(gRailMoveFile, "rail_move_04")
        Npc(index).SetRailMoveSpeed(2)
        Npc(index).SetRailMoveInDimension2d()
        Npc(index).RailMoveGo()
        if Npc(index).IsArrivalRailBothEnds() == true then
          Npc(index).Invisible(15, true)
          SetExternalVariable("researcher_state", "end")
        end
      end
    end
  elseif gMapNum == 1302 then
    local shutter_se = GetExternalVariable("shutter_se")
    if shutter_se == "start" then
      PlayAndManageSE(200009, 100, 0, 1, true, true)
      SetExternalVariable("shutter_se", "playing")
    elseif shutter_se == "playing" then
      local index = GetIndex(GIMMICK, "elv_shutter_01")
      if not Gimmick(index).IsPlayingMotion("e001") then
        SetExternalVariable("shutter_se", "stop")
      end
    elseif shutter_se == "stop" then
      StopManageSE(1, 10)
      SetExternalVariable("shutter_se", "end")
    end
  elseif gMapNum == 1304 then
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local is_fa = args.by_field_attack
  if gMapNum == 1301 and is_fa == true then
    local enemy_name = SymbolEnemy(symbol_index).GetUniqueName()
    if enemy_name == "enemysecurity_01" then
      FlagSet(FLAG_MAIN_17_031)
      CallEventScriptFunction("Prcs_d1301_FA_DefeatedEbamon")
    end
  end
end
