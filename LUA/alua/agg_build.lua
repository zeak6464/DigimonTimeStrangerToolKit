local cpx, cpy, cpz = {}, {}, {}
local bpx, bpy, bpz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local cs = {}
local co1, co2 = {}, {}
local range_in = {}
local break_flag = {}
local build_count = {}
local rotate = {}
local range = 20
local build_num = 50
local ofx, ofy, ofz = 0, -(build_num / 3), 0
local FALL = -200

function Start()
  local height = 0
  local count = 0
  local apx, apy, apz = GetPos()
  local height = ofy
  for i = 0, GetInstanceMaxCount() do
    build_count[i] = count / (build_num / 4)
    cs[i] = math.random() * 3 + 0.1
    bpx[i] = math.random() * cs[i] - cs[i] / 2 + ofx + apx
    bpy[i] = height + apy
    bpz[i] = math.random() * cs[i] - cs[i] / 2 + ofz + apz
    cpx[i], cpy[i], cpz[i] = bpx[i], FALL, bpz[i]
    crx[i] = math.random() * 180 - 90
    cry[i] = math.random() * 180 - 90
    crz[i] = math.random() * 180 - 90
    height = height + cs[i] / 2
    co1[i] = coroutine.create(set_anim1)
    co2[i] = coroutine.create(set_anim2)
    range_in[i] = false
    break_flag[i] = false
    count = count + 1
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotX(i, math.rad(crx[i]))
    SetInstanceRotY(i, math.rad(cry[i]))
    SetInstanceRotZ(i, math.rad(crz[i]))
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
  end
end

function Update()
  local px, py, pz = GetPlayerPos()
  local apx, apy, apz = GetPos()
  local rpx, rpz = apx, apz
  local distance = math.sqrt(math.pow(rpx - px, 2) + math.pow(rpz - pz, 2))
  for i = 0, GetInstanceMaxCount() do
    if distance < range then
      range_in[i] = true
    end
    if range_in[i] == true then
      coroutine.resume(co1[i], i)
    end
    if coroutine.status(co1[i]) == "dead" and distance > range then
      break_flag[i] = true
    end
    if coroutine.status(co1[i]) == "dead" and break_flag[i] == true then
      coroutine.resume(co2[i], i)
    end
    if coroutine.status(co2[i]) == "dead" then
      co1[i] = coroutine.create(set_anim1)
      co2[i] = coroutine.create(set_anim2)
      break_flag[i] = false
      range_in[i] = false
    end
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotX(i, math.rad(crx[i]))
    SetInstanceRotY(i, math.rad(cry[i]))
    SetInstanceRotZ(i, math.rad(crz[i]))
  end
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
  local set_sec = 1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec + build_count[i]
  local build_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  local off = math.random() * 0.2 - 0.1
  repeat
    elps_sec = build_sec - (end_sec - GetTime())
    time = elps_sec / build_sec * 1000
    cpx[i] = inQuad(time, cpx[i] + off, bpx[i] - (cpx[i] + off))
    cpy[i] = inQuad(time, cpy[i], bpy[i] - cpy[i])
    cpz[i] = inQuad(time, cpz[i] + off, bpz[i] - (cpz[i] + off))
    crx[i] = inQuad(time, crx[i], 0.2)
    cry[i] = inQuad(time, cry[i], 0.2)
    crz[i] = inQuad(time, crz[i], 0.2)
    coroutine.yield()
  until end_sec < GetTime()
end

function set_anim2(i)
  local set_sec = 2
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec + build_count[i]
  local build_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  local off = math.random() * 6 - 3
  repeat
    elps_sec = build_sec - (end_sec - GetTime())
    time = elps_sec / build_sec * 1000
    cpx[i] = outQuad(time, cpx[i], bpx[i] + off - cpx[i])
    cpy[i] = inQuad(time, cpy[i], FALL + off - cpy[i])
    cpz[i] = outQuad(time, cpz[i], bpz[i] + off - cpz[i])
    crx[i] = outQuad(time, crx[i], 2)
    cry[i] = outQuad(time, cry[i], 2)
    crz[i] = outQuad(time, crz[i], 2)
    coroutine.yield()
  until end_sec < GetTime()
end
