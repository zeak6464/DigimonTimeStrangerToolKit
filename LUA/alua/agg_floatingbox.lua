function Start()
  SetEndTime(100)
  
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    x, y, z = GetInstanceJointPos(i)
    SetInstanceValueF(i, 0, x + (math.random() * 10 - 10))
    SetInstanceValueF(i, 1, y + (math.random() * 10 - 10))
    SetInstanceValueF(i, 2, z + (math.random() * 10 - 10))
    SetInstanceValueF(i, 3, math.random() * 45)
    SetInstanceValueF(i, 4, math.random() * 45)
    SetInstanceValueF(i, 5, math.random() * 45)
  end
end

function Update()
  time = GetTime()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    local px = GetInstanceValueF(i, 0)
    local py = GetInstanceValueF(i, 1)
    local pz = GetInstanceValueF(i, 2)
    local rx = GetInstanceValueF(i, 3)
    local ry = GetInstanceValueF(i, 4)
    local rz = GetInstanceValueF(i, 5)
    SetInstancePosX(i, px + (math.sin(time / 50 + px + 0.01) + px) + px)
    SetInstancePosY(i, py + (math.sin(time / 25 + py + 0.01) + py) + py)
    SetInstancePosZ(i, pz + (math.sin(time / 50 + pz + pz * 0.01) + pz) + pz)
    SetInstanceRotX(i, rx + math.sin(time / 10 * (rx / 100) * rx + rx))
    SetInstanceRotY(i, ry + math.sin(time / 100 * (ry / 100) * ry + ry))
    SetInstanceRotZ(i, rz + math.sin(time / 10 * (rz / 100) * rz + rz))
  end
  x, y, z = GetPlayerPos()
  SetPosX(x)
  SetPosZ(z)
  SetRotX(time / 100)
  SetRotY(time / 20)
end
