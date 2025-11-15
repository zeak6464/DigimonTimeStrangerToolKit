local cpx, cpy, cpz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local cs = {}
local radius = {}
local spiral_frame = 5
local spiral_height = 3
local spiral_rate = 75
local ofx, ofy, ofz = -80, 0, -100

function Start()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    cpy[i] = (spiral_height / max_count * i - spiral_height / 2) * spiral_rate + ofy
    radius[i] = 7
  end
end

function Update()
  local g_time = GetTime()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    local rd = math.rad((360 / spiral_frame * g_time + i * 10) % 360)
    cpy[i] = cpy[i] + 0.25
    cs[i] = (spiral_height * (spiral_rate / 2) - math.abs(cpy[i])) / (spiral_rate * 0.15)
    if i % 2 == 0 then
      cpx[i] = math.sin(rd) / (cs[i] / cs[i]) * radius[i] + ofx
      cpz[i] = math.cos(rd) / (cs[i] / cs[i]) * radius[i] + ofz
    else
      cpx[i] = -math.sin(rd) / (cs[i] / cs[i]) * radius[i] + ofx
      cpz[i] = -math.cos(rd) / (cs[i] / cs[i]) * radius[i] + ofz
    end
    if cpy[i] > spiral_height / 2 * spiral_rate then
      cpy[i] = -(spiral_height / 2) * spiral_rate
    end
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
  end
end
