require("function_control")
DEFINE_FLAG("FLAG_MAIN_01_260")
DEFINE_FLAG("FLAG_MAIN_02_010")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
AddMoveSpeed = 0
AddCamMoveSpeed = 0
Cam_x, Cam_y, Cam_z = 0, 0, 0
VecMultiplyX, VecMultiplyZ = 0, 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  if gMapNum == 1 then
    LoadRailMove(gRailMoveFile)
  end
  Player().LoadMotion("fg14_w02")
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("move_motion", "init")
  SetExternalVariable("move_state", "init")
end

function PreparationBeforeReactionToField()
  DisableMenuInNowFrame()
  DisableSystemFieldAttackInNowFrame()
  DisableSystemDigimonChatInNowFrame()
end

function Update(elapsed_frame)
  if gMapNum == 1 and FlagCheck(FLAG_MAIN_01_260) and not FlagCheck(FLAG_MAIN_02_010) then
    local speed = 0
    local second = SecondFromFrame(GetTotalElapsedFrame())
    if 6 <= second then
      speed = 15
      Player().MoveMotion_StandbyMoveMotionSet("cyberspace_end")
      Player().Motion_StartMoveMotion(15)
      AddCamMoveSpeed = AddCamMoveSpeed + 0.015
    elseif 3 <= second then
      speed = 15
      AddCamMoveSpeed = AddCamMoveSpeed + 0.015
    else
      AddCamMoveSpeed = 1
    end
    Player().LinkToRailMove("e0001_railmove", "rail_move_001")
    Player().SetRailMoveSpeed(speed)
    Player().SetRailMoveInDimension2d()
    Player().RailMoveGo()
    local gim = GetIndex(GIM, "gim_9999")
    local pc_pos_x, _, pc_pos_z = Player().GetPosition()
    local gim_pos_x, _, gim_pos_z = LocatorObject(gim).GetPosition()
    local y_degree = GetAngleToTarget2D(pc_pos_x, pc_pos_z, gim_pos_x, gim_pos_z)
    local vec_x, vec_z = GetUnitVector2D(y_degree)
    Cam_x, Cam_y, Cam_z = GetCameraPos(CAMERA_OPERATED_BY_PLAYER)
    local move_cam_x = Cam_x + vec_x * AddCamMoveSpeed
    local move_cam_z = Cam_z + vec_z * AddCamMoveSpeed + 2
    SetInstantCameraInNowFrame(gim_pos_x, Cam_y - 0.3, gim_pos_z, move_cam_x - 0.5, Cam_y - 0.4, move_cam_z, 45, 1, 0)
  end
end
