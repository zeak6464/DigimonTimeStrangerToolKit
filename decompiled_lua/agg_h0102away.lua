local cpx, cpy, cpz = {}, {}, {}
local apx, apy, apz = {}, {}, {}
local rnd_py = {}
local cs = {}
local co1 = {}
local range_in = {}
local distance = {}
local away_frame = 20
local range = 3
local ofx, ofy, ofz = 0, 0, 0

function Start()
  for i = 0, GetInstanceCount() do
    cpx[i] = math.random() * 60 - 30 + ofx
    cpy[i] = 1 + ofy
    cpz[i] = math.random() * 60 - 30 + ofz
    rnd_py[i] = math.random() * 100
    range_in[i] = false
    cs[i] = math.random() * 4 + 4
    co1[i] = coroutine.create(set_anim1)
    SetInstancePositionX(i, cpx[i])
    SetInstancePositionZ(i, cpz[i])
    SetInstanceScale(i, 10, 10, 10)
  end
end

function Update()
  local px, py, pz = GetPlayerPositionXYZ()
  local g_time = GetTime()
  for i = 0, GetInstanceCount() do
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
    SetInstancePositionX(i, cpx[i])
    SetInstancePositionZ(i, cpz[i])
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
    local px, py, pz = GetPlayerPositionXYZ()
    elps_sec = away_sec - (end_sec - GetTime())
    time = elps_sec / away_sec * 1000
    cpx[i] = inQuad(time, apx[i], (apx[i] - px) * ratio)
    cpz[i] = inQuad(time, apz[i], (apz[i] - pz) * ratio)
    coroutine.yield()
  until end_sec < GetTime()
end
