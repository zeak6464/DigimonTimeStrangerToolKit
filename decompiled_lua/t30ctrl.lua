require("function_control")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 3001 then
  elseif gMapNum == 3002 then
  elseif gMapNum == 3003 then
  elseif gMapNum == 3005 then
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 3001 then
    SetExternalVariable("shop_name", "Initialize")
  elseif gMapNum == 3002 then
  elseif gMapNum == 3003 then
    SetExternalVariable("player_state", "Initialize")
  elseif gMapNum == 3005 then
  end
end

function Update(elapsed_frame)
  local player_state = GetExternalVariable("player_state")
  if gMapNum == 3001 then
    if player_state == "shopping" then
      local shop_name = GetExternalVariable("shop_name")
      local dist_adjust = GetExternalVariable("shop_dist_adjust")
      MoveToNpc(shop_name, dist_adjust)
    end
  elseif gMapNum == 3002 then
  elseif gMapNum == 3003 then
    local player_state = GetExternalVariable("player_state")
    local operatedegrees = GetLeftAxisMoveOperateDegrees()
    local speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
    local left_index = GetIndex(NPC, "npc_0001")
    local center_index = GetIndex(NPC, "npc_0002")
    local right_index = GetIndex(NPC, "npc_0003")
    local door_index = GetIndex(OGIM, "door")
    local left_pos_x, left_pos_y, left_pos_z = GetPositionAnyObject(NPC, left_index)
    local center_pos_x, center_pos_y, center_pos_z = GetPositionAnyObject(NPC, center_index)
    local right_pos_x, right_pos_y, right_pos_z = GetPositionAnyObject(NPC, right_index)
    Player().Move_Move2D(0, 0)
    if EnableOperatePlayer() and IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil then
      if 330 <= operatedegrees and operatedegrees < 360 or 0 <= operatedegrees and operatedegrees < 30 then
        if player_state == "center" then
        else
          SetExternalVariable("player_state", "center")
        end
      elseif 30 <= operatedegrees and operatedegrees < 100 then
        if player_state == "right" then
        else
          SetExternalVariable("player_state", "right")
        end
      elseif 100 <= operatedegrees and operatedegrees < 260 then
        if player_state == "back" then
        else
          SetExternalVariable("player_state", "back")
        end
      elseif not (260 <= operatedegrees and operatedegrees < 320) or player_state == "left" then
      else
        SetExternalVariable("player_state", "left")
      end
    end
    if player_state == "center" then
      Gimmick(door_index).OverwriteCheckableRange(6, 0, 0)
      Npc(center_index).OverwriteCheckableRange(6, 1, 1)
      Npc(left_index).OverwriteCheckableRange(6, 0, 0)
      Npc(right_index).OverwriteCheckableRange(6, 0, 0)
    elseif player_state == "right" then
      Player().Motion_AimOnlyThisFrame(right_pos_x, right_pos_y + 1.5, right_pos_z, 10, 15, 100)
      Gimmick(door_index).OverwriteCheckableRange(6, 0, 0)
      Npc(center_index).OverwriteCheckableRange(6, 0, 0)
      Npc(left_index).OverwriteCheckableRange(6, 0, 0)
      Npc(right_index).OverwriteCheckableRange(6, 1, 1)
    elseif player_state == "left" then
      Player().Motion_AimOnlyThisFrame(left_pos_x, left_pos_y + 1.5, left_pos_z, 10, 15, 100)
      Gimmick(door_index).OverwriteCheckableRange(6, 0, 0)
      Npc(center_index).OverwriteCheckableRange(6, 0, 0)
      Npc(left_index).OverwriteCheckableRange(6, 1, 1)
      Npc(right_index).OverwriteCheckableRange(6, 0, 0)
    elseif player_state == "back" then
      Gimmick(door_index).OverwriteCheckableRange(6, 1, 1)
      Npc(center_index).OverwriteCheckableRange(6, 0, 0)
      Npc(left_index).OverwriteCheckableRange(6, 0, 0)
      Npc(right_index).OverwriteCheckableRange(6, 0, 0)
    end
  elseif gMapNum == 3005 then
  end
end
