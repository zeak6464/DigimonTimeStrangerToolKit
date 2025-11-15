require("function_control")
TRAIN01_STOP_FRAME = 300
TRAIN01_RESPAWN_FRAME = 3000

function LoadRequest()
  print("===============LoadRequest [t0105_train_01] =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  LoadRailMove(gRailMoveFile)
end

function Initialize()
  print("===============Initialize [t0105_train_01] =====================")
  SetExternalVariable("Train01_state", "Initialize")
  Self().LinkToRailMove("t0105_railmove", 101)
  Self().SetRailMoveInDimension3d()
  Self().SetRailMoveSpeed(20)
  gTrain01StopX, gTrain01StopY, gTrain01StopZ = GetLocatorPosOfLocatorModel("t0105p", "script_TrainStop01", 0)
  gTrain01StopRotate = GetLocatorRot2dOfLocatorModel("t0105p", "script_TrainStop01", 0)
  gTrain01StopCount = 0
end

function PreparationBeforeReactionToField(elapsed_frame)
end

function Update(elapsed_frame)
  local Train01_state = GetExternalVariable("Train01_state")
  local Train01_x, Train01_y, Train01_z = Self().GetPosition()
  local dist_Train01 = GetDistanceBetweenTwoObject2D(Train01_x, Train01_z, gTrain01StopX, gTrain01StopZ)
  Self().Physics_SetGravity(0)
  Self().Physics_SetCollisionContactForNotHit()
  if Train01_state == "Initialize" then
    Self().Move_SetPosition(10.9, 0.2, -234)
    SetExternalVariable("Train01_state", "coming")
  end
  if Self().IsArrivalRailBothEnds() == true then
    SetExternalVariable("Train01_state", "reset")
  elseif -0.5 < dist_Train01 and dist_Train01 < 0.5 then
    if GetExternalVariable("Train01_state") == "stopping" then
      SetExternalVariable("Train01_state", "arrive")
      SetExternalVariable("door_state", "open")
    end
  elseif dist_Train01 <= 50 and GetExternalVariable("Train01_state") == "coming" then
    SetExternalVariable("Train01_state", "stopping")
  end
  if Train01_state == "coming" then
    Self().SetRailMoveSpeed(20)
    Self().RailMoveGo()
  elseif Train01_state == "going" then
    if dist_Train01 <= 35 then
      Self().SetRailMoveSpeed(2 + dist_Train01 / 2)
    end
    Self().RailMoveGo()
  elseif Train01_state == "arrive" then
    gTrain01StopCount = gTrain01StopCount + elapsed_frame
    if gTrain01StopCount >= TRAIN01_STOP_FRAME then
      SetExternalVariable("Train01_state", "going")
      SetExternalVariable("door_state", "close")
      gTrain01StopCount = 0
    else
      Self().SetRailMoveSpeed(0)
      Self().RailMoveGo()
    end
  elseif Train01_state == "stopping" then
    if dist_Train01 <= 4 then
      Self().SetRailMoveSpeed(0.5 + dist_Train01 / 3)
    elseif dist_Train01 <= 8 then
      Self().SetRailMoveSpeed(1 + dist_Train01 / 3)
    elseif dist_Train01 <= 50 then
      Self().SetRailMoveSpeed(2 + dist_Train01 / 3)
    end
    Self().RailMoveGo()
  elseif Train01_state == "reset" then
    gTrain01StopCount = gTrain01StopCount + elapsed_frame
    if gTrain01StopCount >= TRAIN01_RESPAWN_FRAME then
      Self().Move_SetPosition(10.9, 0.2, -234)
      Self().CancelInvisible(30, false, false)
      SetExternalVariable("Train01_state", "coming")
      gTrain01StopCount = 0
    else
      Self().Invisible(30, false)
    end
  end
end
