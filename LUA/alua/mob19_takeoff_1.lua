require("function_control")
MOTION_1 = "f000"
MOTION_2 = "fn01"
MOTION_3 = "f001"
BLEND_FRAME = 30
WAIT_ARRIVE = 300
WAIT_TAKEOFF = 300
INVISIBLE_FRAME = 30

function LoadRequest()
  print("===============LoadRequest [mob_19_takeoff_1] =====================")
  Self().LoadMotion(MOTION_1)
  Self().LoadMotion(MOTION_2)
  Self().LoadMotion(MOTION_3)
end

function Initialize()
  print("===============Initialize [mob_19_takeoff_1] =====================")
  SetExternalVariable("state", "Initialize")
end

function PreparationBeforeReactionToField(elapsed_frame)
  local self_state = GetExternalVariable("state")
  if self_state == "Initialize" then
    gArriveCount = 0
    gTakeOffCount = 0
    SetExternalVariable("state", "landing")
  elseif self_state == "landing" then
    if Self().IsPlayingMotion(MOTION_1) == false then
      SetExternalVariable("state", "arrive")
    end
  elseif self_state == "arrive" then
    gArriveCount = gArriveCount + elapsed_frame
    if gArriveCount >= WAIT_ARRIVE then
      SetExternalVariable("state", "takeoff")
    end
  elseif self_state == "takeoff" then
    gTakeOffCount = gTakeOffCount + elapsed_frame
    if gTakeOffCount >= WAIT_TAKEOFF then
      SetExternalVariable("state", "Initialize")
      Self().CancelInvisible(30, false, false)
    elseif gTakeOffCount >= INVISIBLE_FRAME then
      Self().Invisible(100, false)
    end
  end
end

function Update(elapsed_frame)
  local self_state = GetExternalVariable("state")
  if self_state == "landing" then
    Self().Motion_PlayMotion(MOTION_1, BLEND_FRAME, false)
  elseif self_state == "arrive" then
    Self().Motion_PlayMotion(MOTION_2, BLEND_FRAME, true)
  elseif self_state == "takeoff" then
    Self().Motion_PlayMotion(MOTION_3, BLEND_FRAME, false)
  end
end
