local SPLIT = 10
local DISTANCE = 1500
local PROCESSING_FRAME = 1
local SPEED_RATIO = 3
local tail_count
local cpx, cpy, cpz = {}, {}, {}
local crx, cry = {}, {}
local csx, csy, csz = {}, {}, {}
local dpx, dpy, dpz = {}, {}, {}
local drx, dry = {}, {}
local distance = {}
local gic
local count_frame = {}
local count, df, df_ratio
local p0_x, p1_x, p2_x, p3_x = {}, {}, {}, {}
local p0_y, p1_y, p2_y, p3_y = {}, {}, {}, {}
local p0_z, p1_z, p2_z, p3_z = {}, {}, {}, {}
local cycle = {}
local scale = {}
local t_ratio = {}

function Start()
  count = 0
  df_ratio = 0
  gic = GetInstanceCount()
  tail_count = math.floor(gic / SPLIT)
  if gic < tail_count then
    tail_count = gic
  end
  local offset_ty = -3
  for i = 1, gic do
    cpx[i], cpy[i], cpz[i] = 0, 0, 0
    crx[i], cry[i] = 0, 0
    dpx[i], dpy[i], dpz[i] = 0, 0, 0
    drx[i], dry[i] = 0, 0
    SetInstanceScale(i, 0, 0, 0)
  end
  for i = 1, SPLIT do
    count_frame[i] = 0
    t_ratio[i] = 0
    cycle[i] = math.random(100, 300)
    scale[i] = math.random(50, 50) * 0.1
    p0_x[i] = math.random(-100, 100) * 0.1
    p1_x[i] = DISTANCE * math.cos(math.random(-360, 360) * (math.pi / 180))
    p2_x[i] = p1_x[i]
    p3_x[i] = math.random(-1000, 1000) * 0.1
    p0_y[i] = DISTANCE * 0.3
    p1_y[i] = p0_y[i]
    p2_y[i] = -DISTANCE * 0.3
    p3_y[i] = p2_y[i]
    p0_z[i] = math.random(-100, 100) * 0.1
    p1_z[i] = DISTANCE * math.sin(math.random(-360, 360) * (math.pi / 180))
    p2_z[i] = p1_z[i]
    p3_z[i] = math.random(-1000, 1000) * 0.1
    reset(i)
  end
  for i = 1, 100 do
    Update()
  end
end

function reset(i)
  p0_x[i] = DISTANCE * 0.02 * math.cos(math.random(-360, 360) * (math.pi / 180))
  p1_x[i] = DISTANCE * math.cos(math.random(-360, 360) * (math.pi / 180))
  p2_x[i] = p1_x[i]
  p3_x[i] = DISTANCE * 0.02 * math.cos(math.random(-360, 360) * (math.pi / 180))
  p0_y[i] = DISTANCE * 0.2
  p1_y[i] = p0_y[i]
  p2_y[i] = -DISTANCE * 0.2
  p3_y[i] = p2_y[i]
  p0_z[i] = DISTANCE * 0.02 * math.cos(math.random(-360, 360) * (math.pi / 180))
  p1_z[i] = DISTANCE * math.sin(math.random(-360, 360) * (math.pi / 180))
  p2_z[i] = p1_z[i]
  p3_z[i] = DISTANCE * 0.02 * math.cos(math.random(-360, 360) * (math.pi / 180))
  for t = 1, tail_count do
    local num = (i - 1) * tail_count + 1 * t
    cpx[num] = p0_x[i]
    cpy[num] = p0_y[i]
    cpz[num] = p0_z[i]
    dpx[num] = cpx[num]
    dpy[num] = cpy[num]
    dpz[num] = cpz[num]
  end
end

function edit_list()
  for i = 1, gic do
    dpx[i], dpy[i], dpz[i] = cpx[i], cpy[i], cpz[i]
    drx[i], dry[i] = crx[i], cry[i]
  end
  for i = 1, SPLIT do
    for t = 1, tail_count do
      local num = (i - 1) * tail_count + 1 * t
      cpx[num + 1] = dpx[num]
      cpy[num + 1] = dpy[num]
      cpz[num + 1] = dpz[num]
      crx[num + 1] = drx[num]
      cry[num + 1] = dry[num]
    end
  end
end

function calculate_movement()
  for i = 1, SPLIT do
    local num = (i - 1) * tail_count + 1
    t_ratio[i] = (cycle[i] - count_frame[i]) / cycle[i]
    local t = t_ratio[i]
    cpx[num] = (1 - t) * (1 - t) * (1 - t) * p3_x[i] + 3 * (1 - t) * (1 - t) * t * p2_x[i] + 3 * (1 - t) * t * t * p1_x[i] + t * t * t * p0_x[i]
    cpy[num] = (1 - t) * (1 - t) * (1 - t) * p3_y[i] + 3 * (1 - t) * (1 - t) * t * p2_y[i] + 3 * (1 - t) * t * t * p1_y[i] + t * t * t * p0_y[i]
    cpz[num] = (1 - t) * (1 - t) * (1 - t) * p3_z[i] + 3 * (1 - t) * (1 - t) * t * p2_z[i] + 3 * (1 - t) * t * t * p1_z[i] + t * t * t * p0_z[i]
    distance[i] = math.sqrt(math.pow(cpx[num] - dpx[num], 2) + math.pow(cpz[num] - dpz[num], 2))
    crx[num] = math.atan2(distance[i], cpy[num] - dpy[num])
    cry[num] = math.atan2(cpx[num] - dpx[num], cpz[num] - dpz[num])
  end
  edit_list()
  for i = 1, SPLIT do
    count_frame[i] = count_frame[i] + PROCESSING_FRAME
    if 0 < count_frame[i] - cycle[i] then
      reset(i)
      count_frame[i] = count_frame[i] - cycle[i]
    end
  end
end

function Update()
  df = GetDeltaFrame(30)
  df_ratio = df_ratio + df * SPEED_RATIO
  while df_ratio >= PROCESSING_FRAME do
    calculate_movement()
    df_ratio = df_ratio - PROCESSING_FRAME
  end
  for i = 1, SPLIT do
    for t = 1, tail_count do
      if t ~= 1 then
        local num = (i - 1) * tail_count + 1 * t
        SetInstancePosition(num, cpx[num], cpy[num], cpz[num])
        distance[num] = math.sqrt(math.pow(cpx[num] - dpx[num], 2) + math.pow(cpy[num] - dpy[num], 2) + math.pow(cpz[num] - dpz[num], 2))
        SetInstanceRotation(num, crx[num], cry[num], 0)
        if t < 6 then
          csx[num] = scale[i] / tail_count * (tail_count - t) * scale[i] * inQuart(count_frame[i], 1, -1, cycle[i]) * (t * 2 / 10)
          csy[num] = distance[num] * 16
          csz[num] = scale[i] / tail_count * (tail_count - t) * scale[i] * inQuart(count_frame[i], 1, -1, cycle[i]) * (t * 2 / 10)
        else
          csx[num] = scale[i] / tail_count * (tail_count - t) * scale[i] * inQuart(count_frame[i], 1, -1, cycle[i])
          csy[num] = distance[num] * 16
          csz[num] = scale[i] / tail_count * (tail_count - t) * scale[i] * inQuart(count_frame[i], 1, -1, cycle[i])
        end
        SetInstanceScale(num, csx[num], csy[num], csz[num])
      end
    end
  end
end

function inQuad(t, b, c, d)
  t = t / d
  return c * math.pow(t, 2) + b
end

function outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end

function inQuart(t, b, c, d)
  t = t / d
  return c * math.pow(t, 4) + b
end

function outQuart(t, b, c, d)
  t = t / d - 1
  return -c * (math.pow(t, 4) - 1) + b
end
