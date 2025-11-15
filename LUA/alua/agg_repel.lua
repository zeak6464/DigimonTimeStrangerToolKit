local RANGE = 60

function Start()
end

function Update()
  for i = 1, GetInstanceCount() do
    local px, py, pz = GetPlayerPositionXYZ()
    local ox, oy, oz = GetInstanceLocatorWorldPositionXYZ(i)
    local distance = math.sqrt(math.pow(px - ox, 2) + math.pow(pz - oz, 2))
    SetInstanceRotationX(i, math.atan2(distance, 0 - oy))
    SetInstanceRotationY(i, math.atan2(px - ox, pz - oz))
    local mox = (-RANGE * px + (distance + RANGE) * ox) / (distance + RANGE - RANGE)
    local moz = (-RANGE * pz + (distance + RANGE) * oz) / (distance + RANGE - RANGE)
    SetInstancePosition(i, mox / 10, 0, moz / 10)
  end
end
