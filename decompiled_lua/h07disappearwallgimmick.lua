require("function_control")
RANGE = 5
MOTION = "e001"
MOTION_START_FRAME = 0
MOTION_END_FRAME = 180
gSaveEvalFrame = 0
gEvalFrame = 0

function LoadRequest()
  print("===============LoadRequest [h07apperwall_range] =====================")
  Self().LoadMotion(MOTION)
end

function Initialize()
  print("===============Initialize [h07apperwall_range] =====================")
  SetExternalVariable("state", "Initialize")
  SetExternalVariable("player", "Initialize")
end

function PreparationBeforeReactionToField(elapsed_frame)
  local distance = GetDistanceToObject(SELF, "")
  if distance <= RANGE then
    SetExternalVariable("player", "near")
  else
    SetExternalVariable("player", "far")
  end
end

function Update(elapsed_frame)
  local player_state = GetExternalVariable("player")
  local self_state = GetExternalVariable("state")
  if player_state == "near" then
    if self_state ~= "disappear" then
      Self().Motion_PlayMotionAndSetting(MOTION, 0, gSaveEvalFrame, MOTION_START_FRAME, MOTION_END_FRAME, 5, false)
      SetExternalVariable("state", "disappear")
    end
    gSaveEvalFrame = Self().GetMotionEvalFrame(MOTION)
  end
  gEvalFrame = Self().GetMotionEvalFrame(MOTION)
  if gEvalFrame >= 120 then
    Self().Physics_SetCollisionContactForNotHit()
  end
  if player_state == "far" then
    if self_state ~= "appear" then
      Self().Motion_PlayMotionAndSetting(MOTION, 0, gSaveEvalFrame, MOTION_END_FRAME, MOTION_START_FRAME, 5, false)
      SetExternalVariable("state", "appear")
    end
    gSaveEvalFrame = Self().GetMotionEvalFrame(MOTION)
  end
end
