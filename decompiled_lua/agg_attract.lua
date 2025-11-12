local cpx, cpy, cpz = {}, {}, {}
local bpx, bpy, bpz = {}, {}, {}
local wpx, wpy, wpz = {}, {}, {}
local rnd_py = {}
local crx, cry, crz = {}, {}, {}
local co1, co2 = {}, {}
local distance = {}
local range_in = {}
local wait_sec = {}
local stay_sec = 3
local range = 10
local ofx, ofy, ofz = 40, 0, 0

function Start()
  for i = 0, GetInstanceMaxCount() do
    cpx[i] = math.random() * 40 - 20 + ofx
    cpy[i] = 0.5 + ofy
    cpz[i] = math.random() * 40 - 20 + ofz
    bpx[i], bpy[i], bpz[i] = cpx[i], cpy[i], cpz[i]
    rnd_py[i] = math.random() * 100
    crx[i] = math.random() * 180 - 90
    cry[i] = math.random() * 180 - 90
    crz[i] = math.random() * 180 - 90
    co1[i] = coroutine.create(set_anim1)
    co2[i] = coroutine.create(set_anim2)
    SetInstancePosX(i, cpx[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotX(i, math.rad(crx[i]))
    SetInstanceRotY(i, math.rad(cry[i]))
    SetInstanceRotZ(i, math.rad(crz[i]))
    SetInstanceScaleX(i, math.random() * 4 + 2)
    SetInstanceScaleY(i, math.random() * 4 + 2)
    SetInstanceScaleZ(i, math.random() * 4 + 2)
  end
end

function Update()
  local px, py, pz = GetPlayerPos()
  local g_time = GetTime()
  for i = 0, GetInstanceMaxCount() do
    distance[i] = math.sqrt(math.pow(cpx[i] - px, 2) + math.pow(cpz[i] - pz, 2))
    if distance[i] < range then
      range_in[i] = true
    end
    if range_in[i] == true then
      coroutine.resume(co1[i], i)
    end
    if coroutine.status(co1[i]) == "dead" and g_time > wait_sec[i] then
      coroutine.resume(co2[i], i)
    end
    if coroutine.status(co2[i]) == "dead" then
      range_in[i] = false
      co1[i] = coroutine.create(set_anim1)
      co2[i] = coroutine.create(set_anim2)
    end
    cpy[i] = cpy[i] + math.sin(3.14 * (g_time + rnd_py[i]) * 1) / 100
    cry[i] = (cry[i] + g_time * 0.001) % 360
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotY(i, math.rad(cry[i]))
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
  local set_sec = 2
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local attract_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  bpy[i] = cpy[i]
  repeat
    elps_sec = attract_sec - (end_sec - GetTime())
    time = elps_sec / attract_sec * 1000
    local px, py, pz = GetPlayerPos()
    cpx[i] = inQuad(time, bpx[i], px - bpx[i])
    cpy[i] = inQuad(time, bpy[i], py - bpy[i])
    cpz[i] = inQuad(time, bpz[i], pz - bpz[i])
    wpx[i], wpy[i], wpz[i] = cpx[i], cpy[i], cpz[i]
    wait_sec[i] = GetTime() + stay_sec
    coroutine.yield()
  until end_sec < GetTime()
end

function set_anim2(i)
  local set_sec = 2
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local back_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  repeat
    elps_sec = back_sec - (end_sec - GetTime())
    time = elps_sec / back_sec * 1000
    cpx[i] = outQuad(time, wpx[i], bpx[i] - wpx[i])
    cpy[i] = outQuad(time, wpy[i], bpy[i] - wpy[i])
    cpz[i] = outQuad(time, wpz[i], bpz[i] - wpz[i])
    if bpx[i] == cpx[i] then
      range_in[i] = false
    end
    coroutine.yield()
  until end_sec < GetTime()
end
