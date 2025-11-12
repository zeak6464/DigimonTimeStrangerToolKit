local SPLIT = 900
local SCALE_RATIO = 0.75
local PROCESSING_FRAME = 5
local RANGE = 50
local SCALE = 10
local cpx, cpy, cpz = {}, {}, {}
local dpx, dpy, dpz = {}, {}, {}
local lpx, lpy, lpz = {}, {}, {}
local fall_flag = {}
local mx, my, mz = {}, {}, {}
local cube_count, gic, df, df_ratio, count
local cycle_R = math.random(30, 90)
local cycle_G = math.random(30, 90)
local cycle_B = math.random(30, 90)
local rnd_col_R, rnd_col_G, rnd_col_B = {}, {}, {}
local COLLADA = "colladafxShader7"

function Start()
  df_ratio = 0
  count = 0
  gic = GetInstanceCount()
  cube_count = math.floor(gic / SPLIT)
  if gic < cube_count then
    cube_count = gic
  end
  for i = 1, gic do
    cpx[i] = 0
    cpy[i] = -RANGE + 1
    cpz[i] = 0
    SetInstanceScale(i, 0, 0, 0)
  end
  for s = 1, SPLIT do
    mx[s], my[s], mz[s] = 0, 0, 0
    fall_flag[s] = false
    for i = 1, cube_count do
      local num = (s - 1) * cube_count + 1 * i
      SetInstanceScale(num, SCALE * SCALE_RATIO, SCALE * SCALE_RATIO, SCALE * SCALE_RATIO)
    end
  end
  for i = 1, cycle_R do
    rnd_col_R[i] = math.sin(6.28 / cycle_R * i) * 1 + 1
  end
  for i = 1, cycle_G do
    rnd_col_G[i] = math.sin(6.28 / cycle_G * i) * 1 + 1
  end
  for i = 1, cycle_B do
    rnd_col_B[i] = math.sin(6.28 / cycle_B * i) * 1 + 1
  end
  for i = 1, 100 do
    Update()
  end
end

function reset(s)
  cpx[s] = math.random(-RANGE, RANGE)
  cpy[s] = math.random(0, RANGE)
  cpz[s] = math.random(-RANGE, RANGE)
end

function Update()
  local fc = math.floor(count)
  df = GetDeltaFrame(30)
  df_ratio = df_ratio + df
  local move_flag = false
  while df_ratio >= PROCESSING_FRAME do
    df_ratio = df_ratio - PROCESSING_FRAME
    for s = 1, SPLIT do
      mx[s], my[s], mz[s] = 0, 0, 0
      get_move(math.random(1, 5), s)
      push_list(s)
    end
    move_flag = true
  end
  for s = 1, SPLIT do
    local num = (s - 1) * cube_count + 1
    if cpy[num] < -RANGE then
      reset(num)
    end
  end
  if move_flag then
    for i = 1, GetInstanceModelCount() do
      SetInstanceMaterialParamValue3(i, COLLADA, Expression.keyEmissiveColor, 0, 0.75, 1)
    end
  end
  for s = 1, SPLIT do
    for i = 1, cube_count do
      local num = (s - 1) * cube_count + 1 * i
      SetInstancePosition(num, cpx[num], cpy[num], cpz[num])
    end
  end
  count = count + df
end

function push_list(s)
  for i = 1, cube_count do
    local num = (s - 1) * cube_count + 1 * i
    dpx[num], dpy[num], dpz[num] = cpx[num], cpy[num], cpz[num]
  end
  local n = (s - 1) * cube_count + 1
  cpx[n], cpy[n], cpz[n] = dpx[n] + mx[s], dpy[n] + my[s], dpz[n] + mz[s]
  for i = 1, cube_count do
    if i ~= cube_count then
      local num = (s - 1) * cube_count + 1 * i
      cpx[num + 1], cpy[num + 1], cpz[num + 1] = dpx[num], dpy[num], dpz[num]
    end
  end
end

function get_move(n, s)
  if fall_flag[s] == false then
    mx[s] = mx[s] + 0
    my[s] = my[s] - SCALE * 0.1
    mz[s] = mz[s] + 0
    fall_flag[s] = true
  else
    random_move(n, s)
  end
end

function random_move(n, s)
  if n == 1 then
    mx[s] = mx[s] + SCALE * 0.1
    my[s] = my[s] + 0
    mz[s] = mz[s] + 0
    fall_flag[s] = false
  elseif n == 2 then
    mx[s] = mx[s] - SCALE * 0.1
    my[s] = my[s] + 0
    mz[s] = mz[s] + 0
    fall_flag[s] = false
  elseif n == 3 then
    mx[s] = mx[s] + 0
    my[s] = my[s] + 0
    mz[s] = mz[s] + SCALE * 0.1
    fall_flag[s] = false
  elseif n == 4 then
    mx[s] = mx[s] + 0
    my[s] = my[s] + 0
    mz[s] = mz[s] - SCALE * 0.1
    fall_flag[s] = false
  else
    mx[s] = mx[s] + 0
    my[s] = my[s] - SCALE * 0.1
    mz[s] = mz[s] + 0
    fall_flag[s] = true
  end
end
