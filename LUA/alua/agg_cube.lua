local LIMIT = 25
local ACCEL = 2
local rt = {}
local cx, cy, cz = {}, {}, {}
local ax, ay, az = {}, {}, {}
local pre_time

function Start()
  for i = 0, GetInstanceMaxCount() do
    cx[i] = math.random() * LIMIT * 2 - LIMIT
    cy[i] = math.random() * LIMIT * 2 - LIMIT
    cz[i] = math.random() * LIMIT * 2 - LIMIT
    ax[i] = (math.random() - 0.5) * ACCEL
    ay[i] = (math.random() - 0.5) * ACCEL
    az[i] = (math.random() - 0.5) * ACCEL
    rt[i] = math.random() - 0.5 * ACCEL
    pre_time = 0
  end
end

function Update()
  local cur_time = GetTime()
  local diff_time = cur_time - pre_time
  for i = 0, GetInstanceMaxCount() do
    SetInstancePosX(i, cx[i])
    SetInstancePosY(i, cy[i])
    SetInstancePosZ(i, cz[i])
    SetInstanceRotX(i, math.rad(rt[i]))
    SetInstanceRotY(i, math.rad(rt[i]))
    SetInstanceRotZ(i, math.rad(rt[i]))
    if cx[i] > LIMIT or cx[i] < -LIMIT then
      ax[i] = ax[i] * -1
    end
    if cy[i] > LIMIT or cy[i] < -LIMIT then
      ay[i] = ay[i] * -1
    end
    if cz[i] > LIMIT or cz[i] < -LIMIT then
      az[i] = az[i] * -1
    end
    rt[i] = rt[i] + 0.5 * diff_time
    cx[i] = cx[i] + ax[i] * diff_time
    cy[i] = cy[i] + ay[i] * diff_time
    cz[i] = cz[i] + az[i] * diff_time
  end
  pre_time = cur_time
end
