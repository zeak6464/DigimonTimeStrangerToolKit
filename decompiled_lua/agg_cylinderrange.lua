local RANGE = 6
local IN_FRAME = 0
local OUT_FRAME = 15
local IN_SCALE = 1
local OUT_SCALE = 0
local cpx, cpy, cpz = {}, {}, {}
local frame_mag = {}
local distance_sqr = 0
local instance = {}

function Start()
  local mpx, mpy, mpz = GetPositionXYZ()
  for i = 0, GetInstanceCount() do
    cpx[i], cpy[i], cpz[i] = GetInstanceLocatorWorldPositionXYZ(i)
    instance[i] = {
      frame = IN_FRAME,
      in_frame = IN_FRAME,
      out_frame = OUT_FRAME,
      scale = IN_SCALE,
      in_scale = IN_SCALE,
      out_scale = OUT_SCALE
    }
  end
end

function Update()
  local df = GetDeltaFrame(30)
  local ppx, ppy, ppz = GetPlayerPositionXYZ()
  for i = 0, GetInstanceCount() do
    local distance_sqr = math.pow(cpx[i] - ppx, 2) + math.pow(cpy[i] - ppy, 2) + math.pow(cpz[i] - ppz, 2)
    if distance_sqr < RANGE * RANGE then
      instance[i].frame = instance[i].frame - df
      instance[i].frame = math.max(IN_FRAME, instance[i].frame)
      instance[i].in_frame = instance[i].frame
      local frame = instance[i].frame
      local end_frame = instance[i].out_frame
      instance[i].scale = inQuad(frame, IN_SCALE, instance[i].out_scale, end_frame)
      instance[i].in_scale = instance[i].scale
    else
      instance[i].frame = instance[i].frame + df
      instance[i].frame = math.min(instance[i].frame, OUT_FRAME)
      instance[i].out_frame = instance[i].frame
      local frame = instance[i].frame - instance[i].in_frame
      local end_frame = OUT_FRAME - instance[i].in_frame
      instance[i].scale = inQuad(frame, instance[i].in_scale, OUT_SCALE, end_frame)
      instance[i].out_scale = instance[i].scale
    end
    SetInstanceScale(i, instance[i].scale, instance[i].scale, instance[i].scale)
  end
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
