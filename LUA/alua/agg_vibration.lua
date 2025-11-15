local cpx, cpy, cpz = {}, {}, {}
local bpx, bpy, bpz = {}, {}, {}
local cs = {}
local co1 = {}
local distance = {}
local range_in = {}
local opx, opy, opz
local range = 2
local ch_move = 0
local ofx, ofy, ofz = 40, 0, 40

function Start()
  local max_count = GetInstanceMaxCount()
  local sqrt = math.floor(math.sqrt(max_count))
  local xx, zz = 0, 0
  for i = 0, max_count do
    cpx[i] = ofx + (xx - sqrt / 2)
    cpy[i] = math.random() / 100 - 0.005 + 0.1
    cpz[i] = ofz + (zz - sqrt / 2)
    bpx[i], bpy[i], bpz[i] = cpx[i], cpy[i], cpz[i]
    cs[i] = 0.95
    co1[i] = coroutine.create(set_anim1)
    range_in[i] = false
    local px, py, pz = GetPlayerPos()
    opx, opy, opz = px, py, pz
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
    xx = xx + 1
    if sqrt < xx then
      xx = 0
      zz = zz + 1
    end
  end
end

function Update()
  local px, py, pz = GetPlayerPos()
  local g_time = GetTime()
  ch_move = math.sqrt(math.pow(opx - px, 2) + math.pow(opz - pz, 2))
  for i = 0, GetInstanceMaxCount() do
    distance[i] = math.sqrt(math.pow(cpx[i] - px, 2) + math.pow(cpz[i] - pz, 2))
    if distance[i] < 1 then
      distance[i] = 1
    end
    if distance[i] < range then
      range_in[i] = true
    end
    if range_in[i] == true then
      cs[i] = 1.5
      coroutine.resume(co1[i], i)
      if coroutine.status(co1[i]) == "dead" then
        co1[i] = coroutine.create(set_anim1)
      end
    else
      cs[i] = 0.95
    end
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
    opx, opy, opz = px, py, pz
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
  local offset = 1.5
  local vib_rate = 3
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    cpx[i] = bpx[i] - offset / distance[i] * vib_rate * ch_move
    coroutine.yield()
  until end_sec < GetTime()
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    coroutine.yield()
  until end_sec < GetTime()
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    cpx[i] = bpz[i] - offset / distance[i] * vib_rate * ch_move
    coroutine.yield()
  until end_sec < GetTime()
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    coroutine.yield()
  until end_sec < GetTime()
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    cpx[i] = bpx[i] + offset / distance[i] * vib_rate * ch_move
    coroutine.yield()
  until end_sec < GetTime()
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    coroutine.yield()
  until end_sec < GetTime()
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    cpx[i] = bpz[i] + offset / distance[i] * vib_rate * ch_move
    coroutine.yield()
  until end_sec < GetTime()
  cpx[i], cpy[i], cpz[i] = bpx[i], bpy[i], bpz[i]
  range_in[i] = false
  local set_sec = math.random() * 0.5 + 0.1
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local vib_sec = end_sec - start_sec
  repeat
    coroutine.yield()
  until end_sec < GetTime()
end
