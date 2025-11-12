function Start()
  SetEndTime(100)
  
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    if i % 2 == 1 then
      local py1 = math.random()
      local pz1 = math.random() * math.random() * 2
      local rx1 = 0
      local rz1 = math.random(360)
      SetInstanceValueF(i, 0, py1)
      SetInstanceValueF(i, 1, pz1)
      SetInstanceValueF(i, 2, rx1)
      SetInstanceValueF(i, 3, rz1)
      SetInstancePosY(i, py1)
      SetInstancePosZ(i, pz1)
      SetInstanceRotZ(i, rz1)
    else
      local Rand1 = math.random() * 0.5
      local Rand2 = math.random()
      local Rand3 = math.random() + math.random(2, 3)
      local Rand4 = math.random() + math.random(1, 2)
      local Rand5 = (math.random() + 1) / 10
      SetInstanceValueF(i, 1, Rand1)
      SetInstanceValueF(i, 2, Rand2)
      SetInstanceValueF(i, 3, Rand3)
      SetInstanceValueF(i, 4, Rand4)
      SetInstanceValueF(i, 5, Rand5)
      SetInstancePosY(i, y)
    end
  end
end

function Update()
  x, y, z = GetPlayerPos()
  time = GetTime()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    local kyori = 0
    if i % 2 == 1 then
      local rz1 = GetInstanceValueF(i, 3)
      local Rand5Index = i + 1
      if max_count < Rand5Index then
        Rand5Index = 0
      end
      local Rand5 = GetInstanceValueF(Rand5Index, 5)
      local rx1 = GetInstanceValueF(i, 2)
      ox, oy, oz = GetInstanceJointPos(i)
      kyori = math.sqrt(math.pow(ox - x, 2) + math.pow(oy - y, 2) + math.pow(oz - z, 2))
      SetRotZ(i, rz1 + time * Rand5 * 10)
      SetRotX(i, rx1 + math.sin(time * 0.2) * 0.2 + 0.2)
    else
      local Rand1 = GetInstanceValueF(i, 1)
      local Rand2 = GetInstanceValueF(i, 2)
      local Rand3 = GetInstanceValueF(i, 3)
      local Rand4 = GetInstanceValueF(i, 4)
      local Rand5 = GetInstanceValueF(i, 5)
      if kyori <= 3 then
        SetInstancePosY(i, Rand1 + math.abs(kyori) + 0.2 + math.sin((time + Rand2) * Rand3) * Rand4 * Rand5)
      else
        SetInstancePosY(i, Rand1 + 3 + math.sin((time + Rand2) * Rand3) * Rand4 * Rand5)
      end
    end
  end
end
