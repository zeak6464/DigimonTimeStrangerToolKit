local RANGE = 3
local A_RANGE = 3
local IN_FRAME = 0
local OUT_FRAME = 30
local IN_Y = 0
local OUT_Y = 1.5
local IN_SCALE = 2.5
local OUT_SCALE = 0.1
local ax, ay, az, amx, amy, amz
local cx, cy, cz = {}, {}, {}
local instance = {}

function Start()
  ax, ay, az = math.random(-A_RANGE, A_RANGE), math.random(-5, A_RANGE / 3), math.random(-A_RANGE, A_RANGE)
  amx, amy, amz = 0.05, 0.05, 0.05
  for i = 1, GetInstanceCount() do
    local px, py, pz = GetInstanceLocatorWorldPositionXYZ(i)
    cx[i] = px
    cy[i] = py
    cz[i] = pz
    instance[i] = {
      frame = IN_FRAME,
      in_frame = IN_FRAME,
      out_frame = OUT_FRAME,
      y = IN_Y,
      in_y = IN_Y,
      out_y = OUT_Y,
      scale = IN_SCALE,
      in_scale = IN_SCALE,
      out_scale = OUT_SCALE
    }
  end
end

function Update()
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  local df = GetDeltaFrame(30)
  ax, ay, az = ax + amx * df, ay + amy * df, az + amz * df
  SetPosition(ax, ay, az)
  if ax > A_RANGE or ax < -A_RANGE then
    amx = amx * -1
  end
  if ay > A_RANGE / 2 or ay < -5 then
    amy = amy * -1
  end
  if az > A_RANGE or az < -A_RANGE then
    amz = amz * -1
  end
  for i = 1, GetInstanceCount() do
    local px, py, pz = GetInstanceLocatorWorldPositionXYZ(i)
    cx[i] = px
    cy[i] = py
    cz[i] = pz
    distance_sqr = math.pow(cx[i] - plr_x, 2) + math.pow(cy[i] - plr_y, 2) + math.pow(cz[i] - plr_z, 2)
    if distance_sqr < RANGE * RANGE then
      instance[i].frame = instance[i].frame + df
      instance[i].frame = math.min(instance[i].frame, OUT_FRAME)
      instance[i].out_frame = instance[i].frame
      local frame = instance[i].frame - instance[i].in_frame
      local end_frame = OUT_FRAME - instance[i].in_frame
      instance[i].y = outQuad(frame, instance[i].in_y, OUT_Y, end_frame)
      instance[i].out_y = instance[i].y
      instance[i].scale = outQuad(frame, instance[i].in_scale, OUT_SCALE, end_frame)
      instance[i].out_scale = instance[i].scale
    else
      instance[i].frame = instance[i].frame - df
      instance[i].frame = math.max(IN_FRAME, instance[i].frame)
      instance[i].in_frame = instance[i].frame
      local frame = instance[i].frame
      local end_frame = instance[i].out_frame
      instance[i].y = inQuad(frame, IN_Y, instance[i].out_y, end_frame)
      instance[i].in_y = instance[i].y
      instance[i].scale = inQuad(frame, IN_SCALE, instance[i].out_scale, end_frame)
      instance[i].in_scale = instance[i].scale
    end
    SetInstancePosition(i, 0, instance[i].y, 0)
    SetInstanceScale(i, instance[i].scale, instance[i].scale, instance[i].scale)
  end
end

function linear(t, b, c, d)
  return c * t / d + b
end

function inQuad(t, b, c, d)
  t = t / d
  t = math.pow(t, 4)
  return b * (1 - t) + c * t
end

function outQuad(t, b, c, d)
  t = t / d
  t = 1 - math.pow(1 - t, 4)
  return b * (1 - t) + c * t
end
