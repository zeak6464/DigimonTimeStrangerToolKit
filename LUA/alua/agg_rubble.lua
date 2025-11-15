local cpx, cpy, cpz = {}, {}, {}
local rnd_px, rnd_py, rnd_pz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local cs = {}
local distance = {}
local co = {}
local degee = {}
local round_sec = {}
local total_sec = {}
local pre_sec
local radius = {}
local cpz_ini = {}
local opx, opy, opz

function Start()
  for i = 0, GetInstanceMaxCount() do
    cpx[i] = math.random()
    cpy[i] = math.random()
    cpz[i] = math.random() * 40 - 20
    crx[i] = 0
    cry[i] = 0
    crz[i] = math.random() * 20 - 10
    cpz_ini[i] = cpz[i]
    cs[i] = math.random() * 10 + 1
    co[i] = coroutine.create(set_anim1)
    degee[i] = 0
    pre_sec = 0
    round_sec[i] = math.random(30, 40)
    radius[i] = math.random(25, 30)
    SetInstanceRotX(i, math.rad(crx[i]))
    SetInstanceRotY(i, math.rad(cry[i]))
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
  end
end

function Update()
  local px, py, pz = GetPlayerPos()
  for i = 0, GetInstanceMaxCount() do
    if coroutine.status(co[i]) == "dead" then
      co[i] = coroutine.create(set_anim1)
    end
    if px ~= opx or py ~= opy or pz ~= opz then
      coroutine.resume(co[i], i)
    elseif math.random(1, 100) == 1 then
      coroutine.resume(co[i], i)
    end
    cpz[i] = cpz_ini[i] * math.abs(pz - cpz_ini[i]) / 2
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
    SetInstanceRotZ(i, math.rad(degee[i]))
  end
  pre_sec = GetTime()
  opx, opy, opz = px, py, pz
end

function linear(t, b, c)
  return c * t / 1000 + b
end

function set_anim1(i)
  local aim = 1
  if i % 2 == 0 then
    aim = -1
  end
  total_sec[i] = 0
  local time = 0
  repeat
    local px, py, pz = GetPlayerPos()
    total_sec[i] = total_sec[i] + (GetTime() - pre_sec)
    time = total_sec[i] / round_sec[i] * 1000
    degee[i] = linear(time, (0 + i) * aim, (360 + i) * aim)
    cpx[i] = math.cos(math.rad(degee[i])) * (radius[i] + math.abs(px))
    cpy[i] = math.sin(math.rad(degee[i])) * (radius[i] + math.abs(px))
    coroutine.yield()
  until total_sec[i] > round_sec[i]
end
