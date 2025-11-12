local RX = -0.35
local RY = 2
local SCALE = 0.25
local MIN_ROT = -0.8
local MAX_ROT = 0.8
local OS_RY = -2.3
local OFFSET_TY = 0.5
local ctx, cty, ctz = {}, {}, {}
local cry = {}
local ipx, ipy, ipz = {}, {}, {}
local temp_cry, count
local sin_em = {}
local cycle_em, value_em, rnd

function Start()
  count = 0
  for i = 1, GetInstanceCount() do
    local ip = GetInstanceLocatorWorldPosition(i)
    ipx[i] = ip.x
    ipy[i] = ip.y
    ipz[i] = ip.z
    ctx[i] = 0
    cty[i] = 0
    ctz[i] = 0
    SetInstanceScale(i, SCALE, SCALE, SCALE)
  end
  cycle_em = 60
  value_em = 7
  rnd = 0
  for i = 1, cycle_em do
    sin_em[i] = math.sin(6.28 / cycle_em * i) * value_em + value_em + 1
  end
end

function Update()
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  local fc = math.floor(count)
  for i = 1, GetInstanceCount() do
    cry[i] = math.atan2(plr_x - ipx[i], plr_z - ipz[i])
    AngleLimit(i)
    SetInstancePosition(i, ctx[i], cty[i], ctz[i])
    SetInstanceRotation(i, RX, RY, 0)
  end
  for i = 1, GetInstanceModelCount() do
    SetInstanceMaterialParamValue(i, "colladafxShader2", Expression.keyEmissiveIntensity, sin_em[(i + fc + rnd) % (cycle_em - 1) + 1])
  end
  count = count + GetDeltaFrame(30)
end

function AngleLimit(i)
  if cry[i] + OS_RY < MAX_ROT and cry[i] + OS_RY > MIN_ROT then
    temp_cry = cry[i] + OS_RY
  elseif cry[i] + OS_RY > -1.5 + OS_RY and cry[i] + OS_RY < MIN_ROT then
    temp_cry = MIN_ROT
  else
    temp_cry = MAX_ROT
  end
  if temp_cry < 0 then
    ctx[i] = temp_cry * -0.25
    cty[i] = temp_cry * 0.14
    ctz[i] = temp_cry * -0.3
  else
    ctx[i] = temp_cry * -0.5
    cty[i] = temp_cry * 0.09
    ctz[i] = temp_cry * -0.18
  end
end
