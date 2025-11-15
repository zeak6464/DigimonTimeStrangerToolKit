require("function_control")
APPEAR_RANGE = 10
APPEAR_P_RANGE = 6
FADE_FRAME = 30
FADE_P_FRAME = 10

function LoadRequest()
  print("===============LoadRequest [t3001_walk_disappear] =====================")
  LoadLocatorModel("t3001p")
end

function Initialize()
  print("===============Initialize [t3001_walk_disappear] =====================")
end

function Update(elapsed_frame)
  local unique_name = Self().GetUniqueName()
  local second_str = _SingleSplit(unique_name)
  local locator_num = _SingleSplit(second_str)
  local locator_name = "script_visiblezone_" .. locator_num
  local loc_x, loc_y, loc_z = GetPositionAnyObject(GIM, locator_name)
  local pos_x, pos_y, pos_z = Self().GetPosition()
  local distance = GetDistanceBetweenTwoObject2D(loc_x, loc_z, pos_x, pos_z)
  if distance >= APPEAR_RANGE then
    Self().Invisible(FADE_FRAME, false, false)
  else
    Self().CancelInvisible(FADE_FRAME, false, false)
  end
end

function _SingleSplit(str)
  local delimiter = "_"
  local index = string.find(str, delimiter, 0, true)
  if index then
    local second = string.sub(str, index + 1)
    return second
  end
  return nil
end
