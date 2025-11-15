require("function_control")
APPEAR_P_RANGE = 3
FADE_FRAME = 30
FADE_P_FRAME = 10

function LoadRequest()
  print("===============LoadRequest [t3001_wait_disappear] =====================")
  LoadLocatorModel("t3001p")
end

function Initialize()
  print("===============Initialize [t3001_wait_disappear] =====================")
end

function Update(elapsed_frame)
  local distance = GetDistanceToObject(SELF, "")
  if distance <= APPEAR_P_RANGE then
    Self().Invisible(FADE_P_FRAME, false, false)
  else
    Self().CancelInvisible(FADE_FRAME, false, false)
  end
end
