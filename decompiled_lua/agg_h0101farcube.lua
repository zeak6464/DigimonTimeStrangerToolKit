function Start()
  local max_count = GetInstanceMaxCount()
  
  for i = 0, max_count do
    local sy = SetInstanceScaleY(i)
    SetInstanceValueF(i, 0, sy + (math.random() * 10 - 10))
  end
end

function Update()
  local time = GetTime()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    local sy = GetInstanceValueF(i, 0)
    SetInstanceScaleY(i, sy + math.sin(time + 100 * i * 0.5) * 1 + 0.5)
  end
end
