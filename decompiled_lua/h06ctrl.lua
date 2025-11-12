require("function_control")
DEFINE_FLAG("FLAG_GIMMICK_H06_010")
DEFINE_FLAG("FLAG_GIMMICK_H06_020")
DEFINE_FLAG("FLAG_GIMMICK_H06_030")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
CAMERA_FRAME = 0
gChangeCamTime = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 601 then
  elseif gMapNum == 602 then
  elseif gMapNum == 603 then
  elseif gMapNum == 604 then
  elseif gMapNum == 605 then
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum >= 601 then
    local height, dist = 0, 0
    gChangeCamTime = 0
    if gMapNum == 601 then
      height = 0
      dist = 125
    elseif gMapNum == 602 then
      height = 5
      dist = 300
    elseif gMapNum == 603 then
      height = 0
      dist = 300
    elseif gMapNum == 604 then
      height = 0
      dist = 300
    elseif gMapNum == 605 then
      height = 0
      dist = 300
    end
    SetExternalVariable("start_camera", "start")
    SetExternalVariable("gim_camera", "Initialize")
  end
  if gMapNum == 601 then
    SetExternalVariable("lteral_movement", "start")
    SetExternalVariable("loop_count", 0)
  elseif gMapNum == 602 then
  elseif gMapNum == 603 then
  elseif gMapNum == 604 then
  elseif gMapNum == 605 then
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 601 then
  end
end

function Update(elapsed_frame)
  local start_camera = GetExternalVariable("start_camera")
  if start_camera == "start" then
    SetExternalVariable("start_camera", "initialize")
  end
  if gMapNum == 601 then
    local lteral_movement = GetExternalVariable("lteral_movement")
    local change_cam = GetExternalVariable("change_cam")
    local p_x, p_y, p_z = Player().GetPosition()
    local cam_y = 28.5
    local cam_z = 15
    local offset_z = 32
    if p_y < 25 then
      cam_y = 29
    elseif 25 <= p_y and p_y < 35 then
      cam_y = 29.5
    elseif 35 <= p_y then
      cam_y = 44
      offset_z = 22
    end
    if change_cam == "start" then
      SetInstantCameraInNowFrame(p_x, cam_y, cam_z, p_x, cam_y, cam_z + offset_z, DEFAULT_ANGLE, 10 - gChangeCamTime * 0.3, 0)
      gChangeCamTime = gChangeCamTime + elapsed_frame
      if gChangeCamTime >= 30 then
        SetExternalVariable("change_cam", "stop")
        SetInstantCameraInNowFrame(p_x, cam_y, cam_z, p_x, cam_y, cam_z + offset_z, DEFAULT_ANGLE, 0, 0)
        gChangeCamTime = 0
      end
    else
      SetInstantCameraInNowFrame(p_x, cam_y, cam_z, p_x, cam_y, cam_z + offset_z, DEFAULT_ANGLE, 0, 0)
    end
    if lteral_movement == "start" and not IsRunningEventScript() then
      local operatedegrees = GetLeftAxisMoveOperateDegrees()
      local speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
      if IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil then
        if 0 < operatedegrees and operatedegrees < 180 then
          Player().Move_Move2D(90, speed)
        else
          Player().Move_Move2D(270, speed)
        end
      end
    end
    local Bacchus = GetIndex(NPC, "npc_0001")
    Npc(Bacchus).Physics_SetCollisionContactForNotHit()
    Npc(Bacchus).Physics_SetGravity(0)
  elseif gMapNum == 602 then
  elseif gMapNum == 603 then
  elseif gMapNum == 604 then
  elseif gMapNum == 605 then
  end
end
