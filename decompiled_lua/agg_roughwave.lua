local VALUE_X = 0.2
local VALUE_Y = 0.05
local VALUE_Z = 0.2
local NOISE_FRAME_X1 = 48
local NOISE_FRAME_Y1 = 39
local NOISE_FRAME_Z1 = 55
local NOISE_VALUE_X1 = 0.1
local NOISE_VALUE_Y1 = 0.05
local NOISE_VALUE_Z1 = 0.1
local NOISE_CYCLE_X1 = 11
local NOISE_CYCLE_Y1 = 23
local NOISE_CYCLE_Z1 = 9
local NOISE_FRAME_X2 = 64
local NOISE_FRAME_Y2 = 51
local NOISE_FRAME_Z2 = 63
local NOISE_VALUE_X2 = 0.1
local NOISE_VALUE_Y2 = 0.05
local NOISE_VALUE_Z2 = 0.1
local NOISE_CYCLE_X2 = 17
local NOISE_CYCLE_Y2 = 29
local NOISE_CYCLE_Z2 = 21
local NOISE_FRAME_Y3 = 26
local NOISE_VALUE_Y3 = -0.05
local NOISE_CYCLE_Y3 = 17
local NOISE_FRAME_Y4 = 34
local NOISE_VALUE_Y4 = -0.05
local NOISE_CYCLE_Y4 = 21
local nfx1, nfy1, nfz1 = {}, {}, {}
local nfx2, nfy2, nfz2 = {}, {}, {}
local nfy3 = {}
local nfy4 = {}
local e_num
local count = 0
local cpx, cpy, cpz = {}, {}, {}
local crx, cry, crz = {}, {}, {}

function Start()
  e_num = math.floor(math.sqrt(GetInstanceCount()))
  frame_x = e_num * 2
  frame_y = e_num * 2
  frame_z = e_num * 2
  for i = 1, GetInstanceCount() do
    SetInstanceScale(i, 5, 5, 5)
  end
end

function Update()
  for i = 0, NOISE_CYCLE_X1 do
    nfx1[i] = math.sin(math.pi * 2 / NOISE_FRAME_X1 * (count + i * (NOISE_CYCLE_X1 + 1))) * NOISE_VALUE_X1
  end
  for i = 0, NOISE_CYCLE_Y1 do
    nfy1[i] = math.sin(math.pi * 2 / NOISE_FRAME_Y1 * (count + i)) * NOISE_VALUE_Y1 + math.sin(math.pi * 2 / NOISE_FRAME_Y1 * (count + i * 2 % (NOISE_CYCLE_Y1 * 2 + 1))) * NOISE_VALUE_Y1 * 0.5
  end
  for i = 0, NOISE_CYCLE_Z1 do
    nfz1[i] = math.sin(math.pi * 2 / NOISE_FRAME_Z1 * (count + i * (NOISE_CYCLE_Z1 + 1))) * NOISE_VALUE_Z1
  end
  for i = 0, NOISE_CYCLE_X2 do
    nfx2[i] = math.sin(math.pi * 2 / NOISE_FRAME_X2 * (count + i * (NOISE_CYCLE_X2 + 1))) * NOISE_VALUE_X2
  end
  for i = 0, NOISE_CYCLE_Y2 do
    nfy2[i] = math.sin(math.pi * 2 / NOISE_FRAME_Y2 * (count + i)) * NOISE_VALUE_Y2 + math.sin(math.pi * 2 / NOISE_FRAME_Y2 * (count + i * 2 % (NOISE_CYCLE_Y2 * 2 + 1))) * NOISE_VALUE_Y2 * 0.5
  end
  for i = 0, NOISE_CYCLE_Z2 do
    nfz2[i] = math.sin(math.pi * 2 / NOISE_FRAME_Z2 * (count + i * (NOISE_CYCLE_Z2 + 1))) * NOISE_VALUE_Z2
  end
  for i = 0, NOISE_CYCLE_Y3 do
    nfy3[i] = math.sin(math.pi * 2 / NOISE_FRAME_Y3 * (count + i)) * NOISE_VALUE_Y3 + math.sin(math.pi * 2 / NOISE_FRAME_Y3 * (count + i * 2 % (NOISE_CYCLE_Y3 * 2 + 1))) * NOISE_VALUE_Y3 * 0.5
  end
  for i = 1, NOISE_CYCLE_Y4 do
    nfy4[i] = math.sin(math.pi * 2 / NOISE_FRAME_Y4 * (count + i)) * NOISE_VALUE_Y4 + math.sin(math.pi * 2 / NOISE_FRAME_Y4 * (count + i * 2 % (NOISE_CYCLE_Y4 * 2 + 1))) * NOISE_VALUE_Y4 * 0.5
  end
  for i = 1, GetInstanceCount() do
    cpx[i] = math.sin(math.pi * 2 / frame_x * (count + (i * 8 % (e_num * 2) + 1))) * VALUE_X + nfx1[i % NOISE_CYCLE_X1 + 1] + nfx2[i % NOISE_CYCLE_X2 + 1]
    cpy[i] = math.sin(math.pi * 2 / frame_y * (count + i * 8)) * VALUE_Y + math.sin(math.pi * 2 / frame_y * (count + (i * 8 % (e_num * 2 + 1) + 1))) * VALUE_Y * 0.5 + nfy1[i % NOISE_CYCLE_Y1 + 1] + nfy2[i % NOISE_CYCLE_Y2 + 1] + nfy3[i % NOISE_CYCLE_Y3 + 1] + nfy4[i % NOISE_CYCLE_Y4 + 1]
    cpz[i] = math.sin(math.pi * 2 / frame_z * (count + i * 4)) * VALUE_Z + nfz1[i % NOISE_CYCLE_Z1 + 1] + nfz2[i % NOISE_CYCLE_Z2 + 1]
    crx[i] = math.atan(cpx[i] / cpz[i])
    cry[i] = math.sin(math.pi * 2 / 80 * (count + i)) * 15
    crz[i] = math.atan(cpz[i] / cpx[i])
    SetInstancePosition(i, cpx[i], cpy[i], cpz[i])
    SetInstanceRotation(i, math.atan(cpx[i]) * 1, math.rad(cry[i]), math.atan(cpz[i]) * 1)
  end
  count = count + GetDeltaFrame(30)
end
