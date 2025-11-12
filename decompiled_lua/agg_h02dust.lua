local CYCLE_TX1 = 573
local VALUE_TX1 = 4.1
local CYCLE_TY1 = 600
local VALUE_TY1 = 3
local CYCLE_TZ1 = 631
local VALUE_TZ1 = 2.75
local cpx, cpy, cpz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local count
local sin_tx1 = {}
local ratio_tx1 = {}
local sin_ty1 = {}
local ratio_ty1 = {}
local sin_tz1 = {}
local ratio_tz1 = {}

function Start()
  count = 0
  for i = 1, GetInstanceCount() do
    cpx[i] = math.random(-1000, 1000) * 0.01
    cpy[i] = math.random(-500, 500) * 0.01 + 2.5
    cpz[i] = math.random(-1000, 1000) * 0.01
    crx[i] = math.random(-100, 100) * 0.01
    cry[i] = math.random(-100, 100) * 0.01
    crz[i] = math.random(-100, 100) * 0.01
    ratio_tx1[i] = math.random(0, 1)
    if ratio_tx1[i] == 0 then
      ratio_tx1[i] = -1
    end
    ratio_ty1[i] = math.random(0, 1)
    if ratio_ty1[i] == 0 then
      ratio_ty1[i] = -1
    end
    ratio_tz1[i] = math.random(0, 1)
    if ratio_tz1[i] == 0 then
      ratio_tz1[i] = -1
    end
    for i = 1, CYCLE_TX1 do
      sin_tx1[i] = math.sin(6.28 / CYCLE_TX1 * i) * VALUE_TX1
    end
    for i = 1, CYCLE_TY1 do
      sin_ty1[i] = math.sin(6.28 / CYCLE_TY1 * i) * VALUE_TY1
    end
    for i = 1, CYCLE_TZ1 do
      sin_tz1[i] = math.sin(6.28 / CYCLE_TZ1 * i) * VALUE_TZ1
    end
    SetInstanceScale(i, math.random(60, 80) * 0.01, math.random(60, 80) * 0.01, math.random(60, 80) * 0.01)
  end
end

function Update()
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  local fc = math.floor(count)
  for i = 1, GetInstanceCount() do
    local tx = sin_tx1[(i + fc) % (CYCLE_TX1 - 1) + 1]
    local ty = sin_ty1[(i + fc) % (CYCLE_TY1 - 1) + 1]
    local tz = sin_tz1[(i + fc) % (CYCLE_TZ1 - 1) + 1]
    local rx = math.rad((i + fc) * 3 % 360)
    local ry = math.rad((i + fc) * 4 % 360)
    local rz = math.rad((i + fc) * 5 % 360)
    SetInstancePosition(i, tx * ratio_tx1[i] + cpx[i] + plr_x, ty * ratio_ty1[i] + cpy[i] + plr_y, tz * ratio_tz1[i] + cpz[i] + plr_z)
    SetInstanceRotation(i, crx[i] + rx, cry[i] + ry, crz[i] + rz)
  end
  count = count + GetDeltaFrame(30)
end
