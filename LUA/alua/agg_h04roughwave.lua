local count, gic
local sin_tx1 = {}
local cycle_tx1 = 57
local value_tx1 = 0.1
local sin_ty1 = {}
local cycle_ty1 = 60
local value_ty1 = 0.5
local sin_tz1 = {}
local cycle_tz1 = 43
local value_tz1 = 0.17
local sin_ry1 = {}
local cycle_ry1 = 37
local value_ry1 = 0.2

function Start()
  count = 0
  gic = GetInstanceCount()
  for i = 1, gic do
    SetInstanceScale(i, 1.1, 1.1, 1.1)
  end
  for i = 1, cycle_tx1 do
    sin_tx1[i] = math.sin(6.28 / cycle_tx1 * i) * value_tx1
  end
  for i = 1, cycle_ty1 do
    sin_ty1[i] = math.sin(6.28 / cycle_ty1 * i) * value_ty1
  end
  for i = 1, cycle_tz1 do
    sin_tz1[i] = math.sin(6.28 / cycle_tz1 * i) * value_tz1
  end
  for i = 1, cycle_ry1 do
    sin_ry1[i] = math.sin(6.28 / cycle_ry1 * i) * value_ry1
  end
end

function Update()
  local floor_count = math.floor(count)
  for i = 1, gic do
    local tx = sin_tx1[(i + floor_count) % (cycle_tx1 - 1) + 1]
    local ty = sin_ty1[(i + floor_count) % (cycle_ty1 - 1) + 1]
    local tz = sin_tz1[(i + floor_count) % (cycle_tz1 - 1) + 1]
    local rx = tx
    local ry = sin_ry1[(i + floor_count) % (cycle_ry1 - 1) + 1]
    local rz = tz
    SetInstancePosition(i, tx, ty, tz)
    SetInstanceRotation(i, rx, ry, rz)
  end
  count = count + GetDeltaFrame(30)
end
