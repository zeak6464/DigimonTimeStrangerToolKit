local OFFSET_TY = 0.5
local OFFSET_RX = -90
local OFFSET_RY = 0
local count
local sin_em = {}
local cycle_em, value_em, rnd
local crx, cry = {}, {}
local ipx, ipy, ipz = {}, {}, {}

function Start()
  count = 0
  for i = 1, GetInstanceCount() do
    local ip = GetInstanceLocatorWorldPosition(i)
    ipx[i] = ip.x
    ipy[i] = ip.y
    ipz[i] = ip.z
  end
  cycle_em = 100
  value_em = 7
  rnd = math.random(0, 10000)
  for i = 1, cycle_em do
    sin_em[i] = math.sin(6.28 / cycle_em * i) * value_em + value_em + 1
  end
end

function Update()
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  local fc = math.floor(count)
  for i = 1, GetInstanceCount() do
    distance = math.sqrt(math.pow(plr_x - ipx[i], 2) + math.pow(plr_z - ipz[i], 2))
    crx[i] = math.atan2(distance, plr_y + OFFSET_TY - ipy[i])
    cry[i] = math.atan2(plr_x - ipx[i], plr_z - ipz[i])
    SetInstanceRotation(i, crx[i] + math.rad(OFFSET_RX), cry[i] + math.rad(OFFSET_RY), 0)
  end
  for i = 1, GetInstanceModelCount() do
    SetInstanceMaterialParamValue(i, "colladafxShader2", Expression.keyEmissiveIntensity, sin_em[(i + fc + rnd) % (cycle_em - 1) + 1])
  end
  count = count + GetDeltaFrame(30)
end

function AngleLimit(i)
  if cry[i] < 0 and -3.15 < cry[i] or cry[i] == 0 or cry[i] == 3.15 then
  elseif 0 < cry[i] and cry[i] < 1.57 then
    cry[i] = 0
  elseif 1.57 < cry[i] and cry[i] < 3.15 then
    cry[i] = -3.15
  end
end
