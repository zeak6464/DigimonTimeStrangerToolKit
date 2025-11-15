local cpx, cpy, cpz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local cs = {}
local co1 = {}
local radius = {}
local spiral_frame = 3
local spiral_height = 50
local spiral_rate = -0.25
local ofx, ofy, ofz = -80, 0, 0

function Start()
  for i = 0, GetInstanceMaxCount() do
    cpx[i], cpy[i], cpz[i] = 0, 0, 0
    radius[i] = 5
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
  end
end

function Update()
  local px, py, pz = GetPlayerPos()
  local g_time = GetTime()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    rd = math.rad((360 / spiral_frame * g_time + i * 10) % 360)
    cpy[i] = i * spiral_rate + g_time * spiral_rate - max_count * spiral_rate - spiral_height / 2 + ofy
    cs[i] = math.sin(math.rad((180 / spiral_frame * g_time + i) % 180)) * radius[i]
    if i % 2 == 0 then
      cpx[i] = math.sin(rd) * radius[i] / cs[i] / 0.3 + ofx
      cpz[i] = math.cos(rd) * radius[i] / cs[i] / 0.3 + ofz
    else
      cpx[i] = -math.sin(rd) * radius[i] / cs[i] / 0.3 + ofx
      cpz[i] = -math.cos(rd) * radius[i] / cs[i] / 0.3 + ofz
    end
    if cpy[i] > spiral_height then
      cpy[i] = -(max_count * spiral_rate) - spiral_height / 2
    end
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
  end
end
