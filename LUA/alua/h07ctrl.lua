require("function_control")
DEFINE_FLAG("FLAG_MAIN_20_025")
DEFINE_FLAG("FLAG_MAIN_20_030")
DEFINE_FLAG("FLAG_MAIN_20_040")
DEFINE_FLAG("FLAG_MAIN_20_050")
DEFINE_FLAG("FLAG_MAIN_20_060")
DEFINE_FLAG("FLAG_MAIN_20_070")
DEFINE_FLAG("FLAG_MAIN_20_075")
DEFINE_FLAG("FLAG_MAIN_20_076")
DEFINE_FLAG("FLAG_MAIN_20_080")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gEventTime = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 701 then
    AddCameraLoad("h0701_railcam")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 701 then
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 701 and FlagCheck(FLAG_MAIN_20_076) and not FlagCheck(FLAG_MAIN_20_080) then
    local npc_aigio02 = GetIndex(NPC, "npc_aigio02")
    local npc_aigio03 = GetIndex(NPC, "npc_aigio03")
    local npc_aigio04 = GetIndex(NPC, "npc_aigio04")
    if GetExternalVariable("PlayVoice_M420_100_01") ~= "stop" then
      Npc(npc_aigio02).DisablePlayerCheckInNowFrame()
    end
    if GetExternalVariable("PlayVoice_M420_100_02") ~= "stop" then
    end
    if GetExternalVariable("PlayVoice_M420_100_03") ~= "stop" then
    end
  end
end

function Update(elapsed_frame)
  if gMapNum == 701 then
    if FlagCheck(FLAG_MAIN_20_075) and not FlagCheck(FLAG_MAIN_20_080) then
      local bs = GetIndex(GIMMICK, "access_bs_01")
      local pos_x, pos_y, pos_z = Gimmick(bs).GetPosition()
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      local rot = GetAngleToTarget2D(pos_x, pos_z, p_pos_x, p_pos_z)
      Gimmick(bs).Move_SetRotationY(rot, 5)
      local bs = GetIndex(GIMMICK, "access_bs_02")
      local pos_x, pos_y, pos_z = Gimmick(bs).GetPosition()
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      local rot = GetAngleToTarget2D(pos_x, pos_z, p_pos_x, p_pos_z)
      Gimmick(bs).Move_SetRotationY(rot, 5)
      local bs = GetIndex(GIMMICK, "access_bs_03")
      local pos_x, pos_y, pos_z = Gimmick(bs).GetPosition()
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      local rot = GetAngleToTarget2D(pos_x, pos_z, p_pos_x, p_pos_z)
      Gimmick(bs).Move_SetRotationY(rot, 5)
      local bs = GetIndex(GIMMICK, "access_bs_04")
      local pos_x, pos_y, pos_z = Gimmick(bs).GetPosition()
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      local rot = GetAngleToTarget2D(pos_x, pos_z, p_pos_x, p_pos_z)
      Gimmick(bs).Move_SetRotationY(rot, 5)
      local bs = GetIndex(GIMMICK, "access_bs_05")
      local pos_x, pos_y, pos_z = Gimmick(bs).GetPosition()
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      local rot = GetAngleToTarget2D(pos_x, pos_z, p_pos_x, p_pos_z)
      Gimmick(bs).Move_SetRotationY(rot, 5)
      local bs = GetIndex(GIMMICK, "access_bs_06")
      local pos_x, pos_y, pos_z = Gimmick(bs).GetPosition()
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      local rot = GetAngleToTarget2D(pos_x, pos_z, p_pos_x, p_pos_z)
      Gimmick(bs).Move_SetRotationY(rot, 5)
    end
    if FlagCheck(FLAG_MAIN_20_076) and not FlagCheck(FLAG_MAIN_20_080) then
      if GetExternalVariable("Cam_M420_100") == "cam_01" then
        SetInstantCameraInNowFrame(0.18, 1.487, 105.875, 0.58, 1.328, 103.987, 23, 0, 0)
      end
      local cam_x, cam_y, cam_z = 0, 0, 0
      if GetExternalVariable("Cam_M420_100") == "cam_02" then
        local p_x, p_y, p_z = Player().GetPosition()
        if 87 <= p_z then
          p_z = 87
          cam_x = p_x + 32.221
          cam_y = p_y + 25.045
          cam_z = p_z + 10.198
        elseif p_z < 87 then
          cam_x = p_x - (87 - p_z) * 0.78 + 32.221
          cam_y = p_y - (87 - p_z) * 0.45 + 25.045
          cam_z = p_z - (87 - p_z) * 0.3 + 10.198
        end
        SetInstantCameraInNowFrame(p_x, p_y, p_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, 0, 0)
      end
      if GetExternalVariable("Cam_M420_100") == "cam_03" then
        local npc_aigio04 = GetIndex(NPC, "npc_aigio04")
        local a_rot = Npc(npc_aigio04).GetRotationY()
        local a_posx, a_posy, a_posz = Npc(npc_aigio04).GetPosition()
        local vec_x, vec_z = GetUnitVector2D(a_rot)
        local aim_posx = a_posx + vec_x * 5
        local aim_posy = a_posy - 1
        local aim_posz = a_posz + vec_z * 5
        Npc(npc_aigio04).Motion_AimOnlyThisFrame(aim_posx, aim_posy, aim_posz, 15, 15, 13)
      end
      local operatedegrees = GetLeftAxisMoveOperateDegrees()
      local speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
      if GetExternalVariable("Cam_M420_100") == "cam_01" then
        speed = speed * 0.2
      elseif GetExternalVariable("Cam_M420_100") == "cam_02" then
        speed = speed * 0.2
      elseif GetExternalVariable("Cam_M420_100") == "cam_03" then
        speed = speed * 0.2
      end
      if EnableOperatePlayer() then
        Player().Move_Stop()
        if IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil then
          if 270 < operatedegrees and operatedegrees < 360 then
            Player().Move_Move2D(0, speed)
          elseif 0 <= operatedegrees and operatedegrees < 90 then
            Player().Move_Move2D(0, speed)
          else
            Player().Move_Stop()
          end
          if GetExternalVariable("PlayVoice_M420_100_01") == "open" then
            SetExternalVariable("PlayVoice_M420_100_01", "start")
          end
          if GetExternalVariable("PlayVoice_M420_100_02") == "open" then
            SetExternalVariable("PlayVoice_M420_100_02", "start")
          end
          if GetExternalVariable("PlayVoice_M420_100_03") == "open" then
            SetExternalVariable("PlayVoice_M420_100_03", "start")
          end
        end
      end
      if GetExternalVariable("PlayVoice_M420_100_01") == "start" then
        PlayVoiceOver("m420", "m420_100_010", 30, "m420_100_020", 30, "m420_100_030", true)
        SetExternalVariable("PlayVoice_M420_100_01", "playing")
      elseif GetExternalVariable("PlayVoice_M420_100_01") == "playing" then
        if IsPlayingVoiceOver() == false then
          SetExternalVariable("PlayVoice_M420_100_01", "stop")
        end
      elseif GetExternalVariable("PlayVoice_M420_100_01") == "stop" then
      end
      if GetExternalVariable("PlayVoice_M420_100_02") == "start" then
        PlayVoiceOver("m420", "m420_100_060", 30, "m420_100_070", true)
        SetExternalVariable("PlayVoice_M420_100_02", "playing")
      elseif GetExternalVariable("PlayVoice_M420_100_02") == "playing" then
        if IsPlayingVoiceOver() == false then
          SetExternalVariable("PlayVoice_M420_100_02", "stop")
        end
      elseif GetExternalVariable("PlayVoice_M420_100_02") == "stop" then
      end
      if GetExternalVariable("PlayVoice_M420_100_03") == "start" then
        PlayVoiceOver("m420", "m420_100_090", 30, "m420_100_100", true)
        SetExternalVariable("PlayVoice_M420_100_03", "playing")
      elseif GetExternalVariable("PlayVoice_M420_100_03") == "playing" then
        if IsPlayingVoiceOver() == false then
          SetExternalVariable("PlayVoice_M420_100_03", "stop")
        end
      elseif GetExternalVariable("PlayVoice_M420_100_03") == "stop" then
      end
    end
  end
end

function OnTouchCollision(col_name)
  if gMapNum == 701 then
  end
end
