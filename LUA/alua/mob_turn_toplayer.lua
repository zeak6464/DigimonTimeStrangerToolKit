require("function_control")

function LoadRequest()
end

function Initialize()
end

function Update(elapsed_frame)
  local pos_x, pos_y, pos_z = Self().GetPosition()
  local player_x, player_y, player_z = Player().GetPosition()
  local y_degree = 0
  y_degree = GetAngleToTarget2D(pos_x, pos_z, player_x, player_z)
  Self().Move_SetRotationY(y_degree, 1)
end
