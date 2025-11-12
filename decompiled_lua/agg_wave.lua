local cpx, cpy, cpz = {}, {}, {}
local crx, cry = {}, {}
local cpy2 = {}
local cs = {}
local distance = {}
local ofx, ofy, ofz = 0, -30, 0
local offset = 10
local scale = 0.7
local wave_S_cycle = 2
local wave_S_pd = 10
local wave_S_val = 0.5
local wave_L_cycle = 5
local wave_L_pd = 3
local wave_L_val = 3
local distance_atn = 0.01
local base_rotate = 50

function Start()
  local max_count = GetInstanceMaxCount()
  local sqrt = math.floor(math.sqrt(max_count))
  local xx, zz = 0, 0
  for i = 0, max_count do
    cpx[i] = (ofx + (xx - sqrt / 2)) * offset
    cpy[i] = ofy
    cpz[i] = (ofz + (zz - sqrt / 2)) * offset
    crx[i], cry[i] = 0, 0
    cs[i] = scale
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotY(i, math.atan2(0 - cpx[i], 0 - cpz[i]))
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
    xx = xx + 1
    if sqrt < xx then
      xx = 0
      zz = zz + 1
    end
  end
end

function Update()
  local px, py, pz = GetPlayerPos()
  for i = 0, GetInstanceMaxCount() do
    distance[i] = math.sqrt(math.pow(cpx[i] - 0, 2) + math.pow(cpz[i] - 0, 2)) * distance_atn
    cpy2[i] = math.sin(math.pi * 2 / wave_S_cycle * GetTime() - i * wave_S_pd) * (distance[i] * wave_S_val)
    cpy[i] = math.sin(math.pi * 2 / wave_L_cycle * GetTime() - distance[i] * wave_L_pd) * (distance[i] * wave_L_val)
    crx[i] = math.sin(math.pi * 2 / wave_L_cycle * GetTime() - distance[i] * wave_L_pd) * (base_rotate * distance[i] * wave_L_val / offset)
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i] + cpy2[i] + ofy)
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotX(i, math.rad(crx[i]))
  end
end
