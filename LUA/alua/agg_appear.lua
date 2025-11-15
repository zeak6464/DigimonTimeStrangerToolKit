local RANGE = 2
local SCALE = 1
local GENERATE_RANGE = 600
local FALL = -1
local cpx, cpy, cpz = {}, {}, {}
local cfy = {}
local ctime = {}
local co1, co2 = {}, {}
local distance = {}
local opx, opy, opz, generate_range_rate, p_angle, op_angle, pre_time

function Start()
  for i = 0, GetInstanceMaxCount() do
    cpx[i] = math.random() * 4 - 2
    cpy[i] = (math.random() - 1.2) * 0.25 + 0.04
    cpz[i] = math.random() * 4 - 2
    cfy[i] = FALL
    ctime[i] = math.random() + 0.5
    co1[i] = coroutine.create(set_anim1)
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceScaleX(i, 0)
    SetInstanceScaleY(i, 0)
    SetInstanceScaleZ(i, 0)
  end
  generate_range_rate = 1
  pre_time = 0
  px, py, pz = GetPlayerPos()
  opx, opy, opz = px, py, pz
  p_angle = math.rad(math.atan2(px - opx, pz - opz))
  op_angle = p_angle
end

function Update()
  local cur_time = GetTime()
  local diff_time = cur_time - pre_time
  generate_range_rate = generate_range_rate + 0.1 * diff_time
  if 1 < generate_range_rate then
    generate_range_rate = 1
  end
  local px, py, pz = GetPlayerPos()
  local gtime = GetTime()
  for i = 0, GetInstanceMaxCount() do
    distance[i] = math.sqrt(math.pow(cpx[i] - px, 2) + math.pow(cpz[i] - pz, 2))
    if gtime > ctime[i] and distance[i] > RANGE then
      coroutine.resume(co2[i], i)
      if coroutine.status(co2[i]) == "dead" then
        cpx[i] = px + (px - opx) * math.random() * GENERATE_RANGE * generate_range_rate * diff_time
        cpz[i] = pz + (pz - opz) * math.random() * GENERATE_RANGE * generate_range_rate * diff_time
        SetInstanceScaleX(i, 0)
        SetInstanceScaleY(i, 0)
        SetInstanceScaleZ(i, 0)
        co1[i] = coroutine.create(set_anim1)
        ctime[i] = gtime + (math.random() + 0.25) * diff_time
      end
    else
      coroutine.resume(co1[i], i)
      if coroutine.status(co1[i]) == "dead" then
        co2[i] = coroutine.create(set_anim2)
        SetInstanceScaleX(i, SCALE)
        SetInstanceScaleY(i, SCALE)
        SetInstanceScaleZ(i, SCALE)
      end
    end
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i] + cfy[i])
    SetInstancePosZ(i, cpz[i])
  end
  p_angle = math.atan2(px - opx, pz - opz)
  if px == opx and py == opy and pz == opz then
    generate_range_rate = 0.3
  end
  if 0.3 < math.abs(p_angle - op_angle) then
    generate_range_rate = 0.3
  end
  pre_time = cur_time
  opx, opy, opz = px, py, pz
  op_angle = p_angle
end

function linear(t, b, c)
  return c * t / 1000 + b
end

function inQuad(t, b, c)
  return c * math.pow(t / 1000, 2) + b
end

function outQuad(t, b, c)
  return -c * t / 1000 * (t / 1000 - 2) + b
end

function set_anim1(i)
  local set_sec = 0.15
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local appear_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  repeat
    elps_sec = appear_sec - (end_sec - GetTime())
    time = elps_sec / appear_sec * 1000
    SetInstanceScaleX(i, outQuad(time, 0, SCALE))
    SetInstanceScaleY(i, outQuad(time, 0, SCALE))
    SetInstanceScaleZ(i, outQuad(time, 0, SCALE))
    cfy[i] = outQuad(time, FALL, -FALL)
    coroutine.yield()
  until end_sec < GetTime()
end

function set_anim2(i)
  local set_sec = 0.05
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local leave_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  repeat
    elps_sec = leave_sec - (end_sec - GetTime())
    time = elps_sec / leave_sec * 1000
    SetInstanceScaleX(i, outQuad(time, SCALE, 0 - SCALE))
    SetInstanceScaleY(i, outQuad(time, SCALE, 0 - SCALE))
    SetInstanceScaleZ(i, outQuad(time, SCALE, 0 - SCALE))
    cfy[i] = outQuad(time, 0, FALL)
    coroutine.yield()
  until end_sec < GetTime()
end
