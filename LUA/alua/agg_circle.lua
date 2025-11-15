local cpx, cpy, cpz = {}, {}, {}
local bpx, bpy, bpz = {}, {}, {}
local wpx, wpy, wpz = {}, {}, {}
local ccx, ccy, ccz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local cs = {}
local co1, co2, co3, co4 = {}, {}, {}, {}
local distance = {}
local range_in = {}
local radius = {}
local y_offset = {}
local pre_px, pre_py, pre_pz, p_move_flag
local circle_frame = 1000
local range = 1
local current_range
local radius2 = 0.5
local ofx, ofy, ofz = 0, 0, 40
local pre_time, diff_time

function Start()
  for i = 0, GetInstanceMaxCount() do
    cpx[i] = math.random() * 40 - 20 + ofx
    cpy[i] = math.random() * 20 + ofy
    cpz[i] = math.random() * 40 - 20 + ofz
    ccx[i] = math.random() * 40 - 20 + ofx
    ccy[i] = math.random() * 20 + ofy
    ccz[i] = math.random() * 40 - 20 + ofz
    crx[i] = math.random() * 180 - 90
    cry[i] = math.random() * 180 - 90
    crz[i] = math.random() * 180 - 90
    cs[i] = math.random() / 3 + 1
    co1[i] = coroutine.create(set_anim1)
    co2[i] = coroutine.create(set_anim2)
    co3[i] = coroutine.create(set_anim3)
    co4[i] = coroutine.create(set_anim4)
    range_in[i] = false
    radius[i] = math.random() * 5 + 2
    y_offset[i] = math.random() * 1.7
    current_range = range
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
  pre_time = 0
end

function Update()
  local px, py, pz = GetPlayerPos()
  local cur_time = GetTime()
  diff_time = cur_time - pre_time
  if px == pre_px and py == pre_py and pz == pre_pz then
    p_move_flag = false
  else
    p_move_flag = true
  end
  for i = 0, GetInstanceMaxCount() do
    distance[i] = math.sqrt(math.pow(cpx[i] - px, 2) + math.pow(cpz[i] - pz, 2))
    if distance[i] < current_range and p_move_flag == false then
      range_in[i] = true
    end
    if range_in[i] == true then
      if coroutine.status(co2[i]) ~= "dead" then
        coroutine.resume(co2[i], i)
      else
        if coroutine.status(co3[i]) ~= "dead" then
          coroutine.resume(co3[i], i)
        end
        if coroutine.status(co3[i]) == "dead" then
          if coroutine.status(co4[i]) ~= "dead" then
            coroutine.resume(co4[i], i)
          end
          if coroutine.status(co4[i]) == "dead" then
            range_in[i] = false
            co2[i] = coroutine.create(set_anim2)
            co3[i] = coroutine.create(set_anim3)
            co4[i] = coroutine.create(set_anim4)
            current_range = range
          end
        end
      end
    end
    if range_in[i] == false then
      coroutine.resume(co1[i], i)
      wpx[i], wpy[i], wpz[i] = cpx[i], cpy[i], cpz[i]
      bpx[i], bpy[i], bpz[i] = cpx[i], cpy[i], cpz[i]
      if coroutine.status(co1[i]) == "dead" then
        co1[i] = coroutine.create(set_anim1)
      end
    end
    SetInstancePosX(i, cpx[i])
    SetInstancePosY(i, cpy[i])
    SetInstancePosZ(i, cpz[i])
  end
  pre_px, pre_py, pre_pz = px, py, pz
  pre_time = cur_time
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
  local set_sec = 35
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local circle_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  repeat
    elps_sec = circle_sec - (end_sec - GetTime())
    time = elps_sec / circle_sec * 1000
    rd = math.rad((GetTime() + i) * 3 % 360)
    if i % 3 == 0 then
      cpx[i] = math.sin(rd) * radius[i] + ccx[i]
      cpz[i] = math.cos(rd) * radius[i] + ccz[i]
    elseif i % 3 == 1 then
      cpy[i] = math.sin(rd) * radius[i] + ccy[i]
      cpx[i] = math.cos(rd) * radius[i] + ccx[i]
    else
      cpy[i] = math.sin(rd) * radius[i] + ccy[i]
      cpz[i] = math.cos(rd) * radius[i] + ccz[i]
    end
    coroutine.yield()
  until end_sec < GetTime()
end

function set_anim2(i)
  local set_sec = 5
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local circle_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  local aim = 1
  if i % 2 == 0 then
    aim = -1
  end
  repeat
    local px, py, pz = GetPlayerPos()
    elps_sec = circle_sec - (end_sec - GetTime())
    time = elps_sec / circle_sec * 1000
    local rd = math.rad((360 / circle_sec * GetTime() + i) % 360) * aim
    ox = math.sin(rd) * radius2 + px
    oz = math.cos(rd) * radius2 + pz
    cpx[i] = linear(time, wpx[i], ox - wpx[i])
    cpy[i] = linear(time, wpy[i], py + y_offset[i] - wpy[i])
    cpz[i] = linear(time, wpz[i], oz - wpz[i])
    wpx[i], wpy[i], wpz[i] = cpx[i], cpy[i], cpz[i]
    coroutine.yield()
  until end_sec < GetTime() or p_move_flag == true
end

function set_anim3(i)
  local set_sec = 5
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local circle_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  local aim = 1
  if i % 2 == 0 then
    aim = -1
  end
  repeat
    local px, py, pz = GetPlayerPos()
    elps_sec = circle_sec - (end_sec - GetTime())
    time = elps_sec / circle_sec * 1000
    local rd = math.rad((360 / circle_sec * GetTime() + i) % 360) * aim
    ox = math.sin(rd) * radius2 + px
    oz = math.cos(rd) * radius2 + pz
    cpx[i] = ox
    cpy[i] = py + y_offset[i]
    cpz[i] = oz
    current_range = current_range + 0.01
    coroutine.yield()
  until p_move_flag == true
end

function set_anim4(i)
  local set_sec = 2
  local start_sec = GetTime()
  local end_sec = start_sec + set_sec
  local circle_sec = end_sec - start_sec
  local time = 0
  local elps_sec = 0
  wpx[i], wpy[i], wpz[i] = cpx[i], cpy[i], cpz[i]
  rd = math.rad((end_sec + i) * 3 % 360)
  if i % 3 == 0 then
    bpx[i] = math.sin(rd) * radius[i] + ccx[i]
    bpy[i] = math.cos(rd) * radius[i] + ccz[i]
  elseif i % 3 == 1 then
    bpy[i] = math.sin(rd) * radius[i] + ccy[i]
    bpx[i] = math.cos(rd) * radius[i] + ccx[i]
  else
    bpy[i] = math.sin(rd) * radius[i] + ccy[i]
    bpz[i] = math.cos(rd) * radius[i] + ccz[i]
  end
  repeat
    elps_sec = circle_sec - (end_sec - GetTime())
    time = elps_sec / circle_sec * 1000
    cpx[i] = outQuad(time, wpx[i], bpx[i] - wpx[i])
    cpy[i] = outQuad(time, wpy[i], bpy[i] - wpy[i])
    cpz[i] = outQuad(time, wpz[i], bpz[i] - wpz[i])
    coroutine.yield()
  until end_sec < GetTime()
end
