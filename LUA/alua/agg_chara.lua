local cpx, cpy, cpz = {}, {}, {}
local mpx, mpy, mpz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local frx, fry, frz = {}, {}, {}
local co1, co2 = {}, {}
local distance = {}
local range_in = {}
local break_flag = {}
local range = {}
local FALL = -200
local SCALE = 1

function Start()
  local px, py, pz = GetPos()
  for i = 0, GetInstanceMaxCount() do
    cpx[i], cpy[i], cpz[i] = px, FALL, pz
    frx[i], fry[i], frz[i] = math.rad(math.random() * 360), math.rad(math.random() * 360), math.rad(math.random() * 360)
    crx[i], cry[i], crz[i] = frx[i], fry[i], frz[i]
    range[i] = math.random() * 20 + 20
    range_in[i] = false
    break_flag[i] = false
    co1[i] = coroutine.create(set_anim1)
    co2[i] = coroutine.create(set_anim2)
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotX(i, crx[i])
    SetInstanceRotY(i, cry[i])
    SetInstanceRotZ(i, crz[i])
    SetInstanceScaleX(i, SCALE)
    SetInstanceScaleY(i, SCALE)
    SetInstanceScaleZ(i, SCALE)
  end
end

function Update()
  local px, py, pz = GetPos()
  local ppx, ppy, ppz = GetPlayerPos()
  for i = 0, GetInstanceMaxCount() do
    distance[i] = math.sqrt(math.pow(px - ppx, 2) + math.pow(pz - ppz, 2))
    if distance[i] < range[i] then
      range_in[i] = true
    end
    if range_in[i] == true then
      coroutine.resume(co1[i], i)
    end
    if coroutine.status(co1[i]) == "dead" and distance[i] > range[i] then
      break_flag[i] = true
      crx[i], cry[i], crz[i] = 0, 0, 0
    end
    if break_flag[i] == true then
      coroutine.resume(co2[i], i)
    end
    if coroutine.status(co1[i]) == "dead" and coroutine.status(co2[i]) == "dead" then
      co1[i] = coroutine.create(set_anim1)
      co2[i] = coroutine.create(set_anim2)
      break_flag[i] = false
      range_in[i] = false
    end
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotX(i, crx[i])
    SetInstanceRotY(i, cry[i])
    SetInstanceRotZ(i, crz[i])
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
  local appear_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  local pos = cpy[i]
  local ppx, ppy, ppz = GetPlayerPos()
  repeat
    elps_sec = appear_sec - (end_sec - GetTime())
    time = elps_sec / appear_sec * 1000
    cpy[i] = outQuad(time, FALL, ppy - FALL)
    crx[i] = inQuad(time, frx[i], 0 - frx[i])
    cry[i] = inQuad(time, fry[i], 0 - fry[i])
    crz[i] = inQuad(time, frz[i], 0 - frz[i])
    coroutine.yield()
  until end_sec < GetTime()
end

function set_anim2(i)
  local set_sec = 2
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local break_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  mpx[i], mpy[i], mpz[i] = cpx[i], cpy[i], cpz[i]
  repeat
    elps_sec = break_sec - (end_sec - GetTime())
    time = elps_sec / break_sec * 1000
    cpy[i] = inQuad(time, mpy[i], FALL - mpy[i])
    crx[i] = outQuad(time, 0, frx[i])
    cry[i] = outQuad(time, 0, fry[i])
    crz[i] = outQuad(time, 0, frz[i])
    coroutine.yield()
  until end_sec < GetTime()
end
