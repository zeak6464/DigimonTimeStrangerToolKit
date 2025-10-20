require("function_control")
DEFINE_FLAG("FLAG_MAIN_07_068")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
local MOVE_FRAME = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  Player().LoadMotion("e200")
  if gMapNum == 301 then
    LoadLocatorModel(gPlanData)
  elseif gMapNum == 303 then
    LoadLocatorModel(gPlanData)
    local inside_door = GetIndex(GIM, "obj_0002")
    local outside_door = GetIndex(GIM, "obj_0003")
    LocatorObject(inside_door).LoadMotion("e001")
    LocatorObject(inside_door).LoadMotion("e002")
    LocatorObject(outside_door).LoadMotion("e001")
    LocatorObject(outside_door).LoadMotion("e002")
    CtrlLoadPlayerMotion("fn01_01", "ft01_01", "ft01_02", "ft02_01", "ft02_02")
    CtrlLoadNPCMotion("father01", "fw01_01", "fn01_01", "ft01_01", "ft01_02", "ft02_01", "ft02_02")
  elseif gMapNum == 304 then
    LoadRailMove(gRailMoveFile)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "initialize")
  if gMapNum == 301 then
  elseif gMapNum == 303 then
    SetExternalVariable("player_state", "initialize")
    SetExternalVariable("inside_door_state", "initialize")
    SetExternalVariable("outside_door_state", "initialize")
    SetExternalVariable("palyer_move", "init")
    SetExternalVariable("father_move", "init")
  elseif gMapNum == 304 then
    SetExternalVariable("player_state", "initialize")
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 301 then
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
  if gMapNum == 301 then
  elseif gMapNum == 303 then
    local inside_door = GetIndex(GIM, "obj_0002")
    local outside_door = GetIndex(GIM, "obj_0003")
    local player_state = GetExternalVariable("player_state")
    local outside_door_state = GetExternalVariable("outside_door_state")
    if player_state == "enter_underground" then
      EnterWarpDoor("map_0002", "script_enter", 30, inside_door, "e001")
    end
    local father = GetIndex(NPC, "father01")
    local door = GetIndex(GIM, "map_0002")
    local father_move = GetExternalVariable("father_move")
    local player_move = GetExternalVariable("player_move")
    if father_move == "turn" then
      local door_x, door_y, door_z = LocatorObject(door).GetPosition()
      local door_rot_y = LocatorObject(door).GetRotationY()
      local father_x, father_y, father_z = Npc(father).GetPosition()
      local father_to_door_rot = GetAngleToTarget2D(father_x, father_z, door_x, door_z)
      local pos_rot = father_to_door_rot - door_rot_y
      if pos_rot < 0 then
        pos_rot = pos_rot + 360
      end
      Npc(father).Move_SetRotationY(father_to_door_rot, 30)
      if pos_rot < 90 then
        Npc(father).Motion_PlayMotion("ft01_02", 10, false)
        local current_frame = math.floor(Npc(father).GetMotionEvalFrame("ft01_02") - 0.5)
        local end_frame = math.floor(Npc(father).GetMotionEndFrame("ft01_02") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("father_move", "wait")
        end
      end
      if 90 < pos_rot and pos_rot <= 180 then
        Npc(father).Motion_PlayMotion("ft02_02", 10, false)
        local current_frame = math.floor(Npc(father).GetMotionEvalFrame("ft02_02") - 0.5)
        local end_frame = math.floor(Npc(father).GetMotionEndFrame("ft02_02") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("father_move", "wait")
        end
      end
      if 180 < pos_rot and pos_rot <= 270 then
        Npc(father).Motion_PlayMotion("ft02_01", 10, false)
        local current_frame = math.floor(Npc(father).GetMotionEvalFrame("ft02_01") - 0.5)
        local end_frame = math.floor(Npc(father).GetMotionEndFrame("ft02_01") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("father_move", "wait")
        end
      end
      if 270 < pos_rot then
        Npc(father).Motion_PlayMotion("ft01_01", 10, false)
        local current_frame = math.floor(Npc(father).GetMotionEvalFrame("ft01_01") - 0.5)
        local end_frame = math.floor(Npc(father).GetMotionEndFrame("ft01_01") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("father_move", "wait")
        end
      end
    end
    if father_move == "wait" then
      Npc(father).Motion_PlayMotion("fn01_01", 10, true)
      SetExternalVariable("father_move", "move")
    end
    if father_move == "move" then
      local father_x, father_y, father_z = Npc(father).GetPosition()
      local door_x, door_y, door_z = LocatorObject(door).GetPosition()
      local move_rot = GetAngleToTarget2D(father_x, father_z, door_x, door_z)
      Npc(father).Motion_PlayMotion("fw01_01", 10, true)
      Npc(father).Move_Move2D(move_rot, 2)
      MOVE_FRAME = MOVE_FRAME + elapsed_frame
      if 3 <= MOVE_FRAME then
        CallEventScriptFunction("MapChange", "d", 1102, "start_00", true, 0, 15)
      end
    end
    if player_move == "turn" then
      local door_x, door_y, door_z = LocatorObject(door).GetPosition()
      local door_rot_y = LocatorObject(door).GetRotationY()
      local player_x, player_y, player_z = Player().GetPosition()
      local player_to_door_rot = GetAngleToTarget2D(player_x, player_z, door_x, door_z)
      local pos_rot = player_to_door_rot - door_rot_y
      if pos_rot < 0 then
        pos_rot = pos_rot + 360
      end
      Player().Move_SetRotationY(player_to_door_rot, 30)
      if pos_rot < 90 then
        Player().Motion_PlayMotion("ft01_02", 10, false)
        local current_frame = math.floor(Player().GetMotionEvalFrame("ft01_02") - 0.5)
        local end_frame = math.floor(Player().GetMotionEndFrame("ft01_02") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("player_move", "wait")
        end
      end
      if 90 < pos_rot and pos_rot <= 180 then
        Player().Motion_PlayMotion("ft02_02", 10, false)
        local current_frame = math.floor(Player().GetMotionEvalFrame("ft02_02") - 0.5)
        local end_frame = math.floor(Player().GetMotionEndFrame("ft02_02") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("player_move", "wait")
        end
      end
      if 180 < pos_rot and pos_rot <= 270 then
        Player().Motion_PlayMotion("ft02_01", 10, false)
        local current_frame = math.floor(Player().GetMotionEvalFrame("ft02_01") - 0.5)
        local end_frame = math.floor(Player().GetMotionEndFrame("ft02_01") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("player_move", "wait")
        end
      end
      if 270 < pos_rot then
        Player().Motion_PlayMotion("ft01_01", 10, false)
        local current_frame = math.floor(Player().GetMotionEvalFrame("ft01_01") - 0.5)
        local end_frame = math.floor(Player().GetMotionEndFrame("ft01_01") - 0.5)
        if current_frame == end_frame then
          SetExternalVariable("player_move", "wait")
        end
      end
    end
    if player_move == "wait" then
      Player().Motion_PlayMotion("fn01_01", 10, true)
      SetExternalVariable("player_move", "move")
    end
    if player_move == "move" then
      local player_x, player_y, player_z = Player().GetPosition()
      local door_x, door_y, door_z = LocatorObject(door).GetPosition()
      local move_rot = GetAngleToTarget2D(player_x, player_z, door_x, door_z)
      Player().Move_Move2D(move_rot, 2)
    end
  elseif gMapNum == 302 then
    if CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      local fade_frame = 10
      local cancel_fade_frame = 10
      local dist_shield_b = GetDistanceToObject(GIMMICK, GetIndex(GIMMICK, "obj_shield_b02"))
      if dist_shield_b <= 5 and FlagCheck(FLAG_MAIN_07_068) then
        Gimmick(GetIndex(GIMMICK, "obj_shield_b01")).InvisibleInNowFrame(fade_frame, cancel_fade_frame, false)
        Gimmick(GetIndex(GIMMICK, "obj_shield_b02")).InvisibleInNowFrame(fade_frame, cancel_fade_frame, false)
        Gimmick(GetIndex(GIMMICK, "obj_shield_b03")).InvisibleInNowFrame(fade_frame, cancel_fade_frame, false)
      end
    end
  elseif gMapNum == 304 then
    local player_state = GetExternalVariable("player_state")
    if player_state == "focus" then
    elseif player_state == "focus_end" then
      SetExternalVariable("player_state", "Initialize")
    end
  end
end
