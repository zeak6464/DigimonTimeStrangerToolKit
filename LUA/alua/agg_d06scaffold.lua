local WIDTH = 46
local RANGE = 40
local instance = {}
local OUT_FRAME = 5
local IN_SCALE = 1
local OUT_SCALE = 0
local OS_SX = 0.25
test_flag = 0

function Start()
  local iop_x, iop_y, iop_z = GetPositionXYZ()
  for i = 1, GetInstanceCount() do
    local tz = i % RANGE - RANGE * 0.5
    instance[i] = {
      frame = 0,
      in_frame = 0,
      out_frame = OUT_FRAME,
      x = math.floor((i - 1) / RANGE) * 0.5 - (WIDTH - 1) * OS_SX + math.random(-2000, 2000) * 1.0E-4,
      y = math.random(-2000, 2000) * 1.0E-4 - 0.2 + iop_y,
      z = tz + iop_z,
      rr = math.random(80, 140) * 0.01,
      scale = 0,
      in_scale = 0,
      out_scale = 0
    }
  end
  for i = 1, GetInstanceCount() do
    local r = math.random(1, GetInstanceCount())
    local temp = instance[i]
    instance[i] = instance[r]
    instance[r] = temp
  end
end

function Update()
  local gpc_x, gpc_z = GetPartyCirclePositionXZ()
  local px, py, pz = GetPlayerPos()
  gpc_x = px
  gpc_z = pz
  local df = GetDeltaFrame(30)
  for i = 1, GetInstanceCount() do
    if CheckFlag(7382) == false then
      local distance_x = instance[i].x - gpc_x
      local distance_z = instance[i].z - gpc_z
      if math.abs(distance_x) > WIDTH * 0.25 then
        SetMoveX(i, distance_x)
      end
      if math.abs(distance_z) > RANGE * 0.5 * instance[i].rr then
        SetMoveZ(i, distance_z)
      elseif check_range(i, distance_x, distance_z) then
        instance[i].frame = instance[i].frame + df
        instance[i].frame = math.min(instance[i].frame, OUT_FRAME)
        instance[i].out_frame = instance[i].frame
        local frame = instance[i].frame - instance[i].in_frame
        local end_frame = OUT_FRAME - instance[i].in_frame
        instance[i].scale = inQuad(frame, instance[i].in_scale, OUT_SCALE - instance[i].in_scale, end_frame)
        instance[i].out_scale = instance[i].scale
      else
        instance[i].frame = instance[i].frame - df
        instance[i].frame = math.max(0, instance[i].frame)
        instance[i].in_frame = instance[i].frame
        local frame = instance[i].frame
        local end_frame = instance[i].out_frame
        instance[i].scale = outQuad(end_frame - frame, instance[i].out_scale, IN_SCALE - instance[i].out_scale, end_frame)
        instance[i].in_scale = instance[i].scale
      end
      SetInstancePosition(i, instance[i].x, instance[i].y, instance[i].z)
      if instance[i].scale > 0 then
        SetInstanceScale(i, IN_SCALE, IN_SCALE, instance[i].scale)
      else
        SetInstanceScale(i, OUT_SCALE, OUT_SCALE, OUT_SCALE)
      end
    elseif test_flag == 0 then
      test_flag = 1
      instance[i].frame = instance[i].frame - df
      instance[i].frame = math.max(0, instance[i].frame)
      instance[i].in_frame = instance[i].frame
      local frame = instance[i].frame
      local end_frame = instance[i].out_frame
      instance[i].scale = outQuad(end_frame - frame, instance[i].out_scale, IN_SCALE - instance[i].out_scale, end_frame)
      instance[i].in_scale = instance[i].scale
    end
  end
end

function check_range(i, distance_x, distance_z)
  if math.abs(distance_z) > RANGE * 0.3 * instance[i].rr then
    return true
  elseif math.abs(distance_x * 1.25) + math.abs(distance_z) > RANGE * 0.25 * instance[i].rr then
    return true
  elseif math.abs(distance_x) > RANGE * 0.08 * instance[i].rr and math.abs(distance_z) > RANGE * 0.08 * instance[i].rr then
    return true
  else
    return false
  end
end

function SetMoveX(i, distance_x)
  if 0 < distance_x then
    instance[i].x = instance[i].x - WIDTH * 0.5
  else
    instance[i].x = instance[i].x + WIDTH * 0.5
  end
  instance[i].scale = 0
  instance[i].out_scale = instance[i].scale
  instance[i].in_scale = instance[i].scale
end

function SetMoveZ(i, distance_z)
  if 0 < distance_z then
    instance[i].z = instance[i].z - RANGE
  else
    instance[i].z = instance[i].z + RANGE
  end
  instance[i].scale = 0
  instance[i].out_scale = instance[i].scale
  instance[i].in_scale = instance[i].scale
end

function inQuad(t, b, c, d)
  t = t / d
  return c * t * t + b
end

function outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end
