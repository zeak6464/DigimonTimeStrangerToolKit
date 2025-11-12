local cpx, cpy, cpz = {}, {}, {}
local apx, apy, apz = {}, {}, {}
local rnd_py = {}
local cs = {}
local co1 = {}
local range_in = {}
local distance = {}
local away_frame = 20
local range = 3.5
local ofx, ofy, ofz = -40, 0, 40

function Start()
  for i = 0, GetInstanceMaxCount() do
    cpx[i] = math.random() * 40 - 20 + ofx
    cpy[i] = 0.5 + ofy
    cpz[i] = math.random() * 40 - 20 + ofz
    rnd_py[i] = math.random() * 100
    range_in[i] = false
    cs[i] = math.random() * 4 + 2
    co1[i] = coroutine.create(set_anim1)
    SetInstancePosX(i, cpx[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
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
    if coroutine.status(co1[i]) == "dead" then
      co1[i] = coroutine.create(set_anim1)
      range_in[i] = false
    end
    cpy[i] = cpy[i] + math.sin(math.pi * 2 / 2 * (g_time + rnd_py[i]) * 1) / 500
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotY(i, math.atan2(px - cpx[i], pz - cpz[i]))
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
  local set_sec = 0.2
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local away_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  local ratio = 1.5
  apx[i], apy[i], apz[i] = cpx[i], cpy[i], cpz[i]
  repeat
    local px, py, pz = GetPlayerPos()
    elps_sec = away_sec - (end_sec - GetTime())
    time = elps_sec / away_sec * 1000
    cpx[i] = inQuad(time, apx[i], (apx[i] - px) * ratio)
    cpz[i] = inQuad(time, apz[i], (apz[i] - pz) * ratio)
    coroutine.yield()
  until end_sec < GetTime()
end
