function Start()
end

function Update()
  local time = GetTime()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    SetInstancePosY(i, math.sin(time + 100 * i * 0.5) * 200 + 200)
    SetInstanceScaleY(i, math.sin(time + 100 * i * 0.5) * 0.9 + 2)
  end
end
