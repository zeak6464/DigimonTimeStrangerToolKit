function Start()
end

function Update()
  local time = GetTime()
  local max_count = GetInstanceMaxCount()
  local sy = {}
  for i = 1, max_count do
    local py = GetInstanceValueF(i, 1)
    SetInstancePosY(i, py + math.sin((time + i) * 1) * 0.005 + 0.01)
  end
end
