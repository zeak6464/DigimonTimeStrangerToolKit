function Start()
end

function Update()
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  for i = 1, GetInstanceCount() do
    SetInstancePosition(i, plr_x, plr_y, plr_z)
  end
end
