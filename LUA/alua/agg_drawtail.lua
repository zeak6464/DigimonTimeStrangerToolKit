local SPLIT = 1
local PROCESSING_FRAME = 1
local SPEED_RATIO = 3
local DISTANCE = 500
local SCALE = 3
local OS_TY = 0.5
local tail_count
local cpx, cpy, cpz = {}, {}, {}
local crx, cry = {}, {}
local dpx, dpy, dpz = {}, {}, {}
local drx, dry = {}, {}
local distance = {}
local gic
local count_frame = {}
local count, df_ratio, df
local p0_x = {}
local p1_x = {}
local p2_x = {}
local p0_y = {}
local p1_y = {}
local p2_y = {}
local p0_z = {}
local p1_z = {}
local p2_z = {}
local value = {}
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
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  for i = 1, SPLIT do
    count_frame[i] = 0
    t_ratio[i] = 0
    value[i] = math.random(20, 40) * 0.1
    cycle[i] = math.random(60, 120)
    scale[i] = math.random(SCALE, SCALE * 1.5) * 0.1
    p0_x[i] = plr_x + math.random(-DISTANCE, DISTANCE) * 0.05
    p1_x[i] = plr_x + math.random(-DISTANCE, DISTANCE) * 0.05
    p2_x[i] = plr_x + math.random(-DISTANCE, DISTANCE) * 0.05
    p0_y[i] = -30
    p1_y[i] = -20
    p2_y[i] = -10
    p0_z[i] = plr_x + math.random(-DISTANCE, DISTANCE) * 0.05
    p1_z[i] = plr_x + math.random(-DISTANCE, DISTANCE) * 0.05
    p2_z[i] = plr_x + math.random(-DISTANCE, DISTANCE) * 0.05
    reset(i)
  end
  for i = 1, 10 do
    Update()
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
        SetInstanceScale(num, scale[i] / tail_count * (tail_count - t) * scale[i], distance[num] * 16, scale[i] / tail_count * (tail_count - t) * scale[i])
      end
    end
  end
end

function reset(i)
  local ppx, ppy, ppz
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  ppx = plr_x + math.random(-DISTANCE, DISTANCE) * 0.01
  ppy = plr_y + math.random(-DISTANCE, DISTANCE) * 0.01
  ppz = plr_z + math.random(-DISTANCE, DISTANCE) * 0.01
  p1_x[i] = (p2_x[i] - p1_x[i]) * 0.5 + p2_x[i]
  p0_x[i] = p2_x[i]
  p2_x[i] = ppx
  p1_y[i] = (p2_y[i] - p1_y[i]) * 0.5 + p2_y[i]
  p0_y[i] = p2_y[i]
  p2_y[i] = ppy
  p1_z[i] = (p2_z[i] - p1_z[i]) * 0.5 + p2_z[i]
  p0_z[i] = p2_z[i]
  p2_z[i] = ppz
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
    cpx[num] = (1 - t_ratio[i]) * (1 - t_ratio[i]) * p2_x[i] + 2 * (1 - t_ratio[i]) * t_ratio[i] * p1_x[i] + t_ratio[i] * t_ratio[i] * p0_x[i]
    cpy[num] = (1 - t_ratio[i]) * (1 - t_ratio[i]) * p2_y[i] + 2 * (1 - t_ratio[i]) * t_ratio[i] * p1_y[i] + t_ratio[i] * t_ratio[i] * p0_y[i] + OS_TY
    cpz[num] = (1 - t_ratio[i]) * (1 - t_ratio[i]) * p2_z[i] + 2 * (1 - t_ratio[i]) * t_ratio[i] * p1_z[i] + t_ratio[i] * t_ratio[i] * p0_z[i]
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
