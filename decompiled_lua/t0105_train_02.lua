require("function_control")
TRAIN02_START_FRAME = 1200
TRAIN02_STOP_FRAME = 300
TRAIN02_RESPAWN_FRAME = 3000

function LoadRequest()
  print("===============LoadRequest [t0105_train_02] =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  LoadRailMove(gRailMoveFile)
end

function Initialize()
  print("===============Initialize [t0105_train_02] =====================")
  SetExternalVariable("Train02_state", "Initialize")
  Self().LinkToRailMove("t0105_railmove", 100)
  Self().SetRailMoveInDimension3d()
  Self().SetRailMoveSpeed(20)
  gTrain02StopX, gTrain02StopY, gTrain02StopZ = GetLocatorPosOfLocatorModel("t0105p", "script_TrainStop02", 0)
  gTrain02StopRotate = GetLocatorRot2dOfLocatorModel("t0105p", "script_TrainStop02", 0)
  gTrain02StopCount = 0
end

function PreparationBeforeReactionToField(elapsed_frame)
end

function Update(elapsed_frame)
  local Train02_state = GetExternalVariable("Train02_state")
  local Train02_x, Train02_y, Train02_z = Self().GetPosition()
  local dist_Train02 = GetDistanceBetweenTwoObject2D(Train02_x, Train02_z, gTrain02StopX, gTrain02StopZ)
  Self().Physics_SetGravity(0)
  Self().Physics_SetCollisionContactForNotHit()
  if Train02_state == "Initialize" then
    gTrain02StopCount = gTrain02StopCount + elapsed_frame
    if gTrain02StopCount >= TRAIN02_START_FRAME then
      Self().Move_SetPosition(-10.6, 0.2, 224)
      Self().CancelInvisible(30, false, false)
      SetExternalVariable("Train02_state", "coming")
      gTrain02StopCount = 0
    else
      Self().Invisible(0, false)
    end
  end
  if Self().IsArrivalRailBothEnds() == true then
    SetExternalVariable("Train02_state", "reset")
  elseif -0.5 < dist_Train02 and dist_Train02 < 0.5 then
    if GetExternalVariable("Train02_state") == "stopping" then
      SetExternalVariable("Train02_state", "arrive")
      SetExternalVariable("door_state", "open")
    end
  elseif dist_Train02 <= 50 and GetExternalVariable("Train02_state") == "coming" then
    SetExternalVariable("Train02_state", "stopping")
  end
  if Train02_state == "coming" then
    Self().SetRailMoveSpeed(20)
    Self().RailMoveGo()
  elseif Train02_state == "going" then
    if dist_Train02 <= 35 then
      Self().SetRailMoveSpeed(2 + dist_Train02 / 2)
    end
    Self().RailMoveGo()
  elseif Train02_state == "arrive" then
    gTrain02StopCount = gTrain02StopCount + elapsed_frame
    if gTrain02StopCount >= TRAIN02_STOP_FRAME then
      SetExternalVariable("Train02_state", "going")
      SetExternalVariable("door_state", "close")
      gTrain02StopCount = 0
    else
      Self().SetRailMoveSpeed(0)
      Self().RailMoveGo()
    end
  elseif Train02_state == "stopping" then
    if dist_Train02 <= 4 then
      Self().SetRailMoveSpeed(0.5 + dist_Train02 / 3)
    elseif dist_Train02 <= 8 then
      Self().SetRailMoveSpeed(1 + dist_Train02 / 3)
    elseif dist_Train02 <= 50 then
      Self().SetRailMoveSpeed(2 + dist_Train02 / 3)
    end
    Self().RailMoveGo()
  elseif Train02_state == "reset" then
    gTrain02StopCount = gTrain02StopCount + elapsed_frame
    if gTrain02StopCount >= TRAIN02_RESPAWN_FRAME then
      Self().Move_SetPosition(-10.6, 0.2, 224)
      Self().CancelInvisible(30, false, false)
      SetExternalVariable("Train02_state", "coming")
      gTrain02StopCount = 0
    else
      Self().Invisible(30, false)
    end
  end
end
