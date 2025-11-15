local cpx, cpy, cpz = {}, {}, {}
local lpx, lpy, lpz = {}, {}, {}
local vlx, vly, vlz = {}, {}, {}
local radius = {}
local RANGE = 15
local REB = 0.4
local cyctx, cycty, cyctz, valtx, valty, valtz, p0_x, p0_y, p0_z, p1_x, p1_y, p1_z, p2_x, p2_y, p2_z, cycle, count_frame, t_ratio

function Start()
  count = 0
  t_ratio = 0
  count_frame = 0
  cycle = math.random(120, 150)
  p0_x, p1_x, p2_x, p0_y, p1_y, p2_y, p0_z, p1_z, p2_z = rnd(), rnd(), rnd(), rnd(), rnd(), rnd(), rnd(), rnd(), rnd()
  for i = 1, GetInstanceCount() do
    if i == 1 then
      cpx[i] = p0_x
      cpy[i] = p0_y
      cpz[i] = p0_z
      radius[i] = 10
      vlx[i], vly[i], vlz[i] = 0, 0, 0
    else
      cpx[i] = math.random(-1000, 1000) * 0.01
      cpy[i] = math.random(-1000, 1000) * 0.01
      cpz[i] = math.random(-1000, 1000) * 0.01
      vlx[i], vly[i], vlz[i] = math.random(-50, 50) * 0.001, math.random(-50, 50) * 0.001, math.random(-50, 50) * 0.001
      radius[i] = math.random(50, 150) * 0.01
    end
    lpx[i], lpy[i], lpz[i] = cpx[i], cpy[i], cpz[i]
    SetInstancePosition(i, cpx[i], cpy[i], cpz[i])
    SetInstanceScale(i, radius[i], radius[i], radius[i])
  end
end

function rnd()
  local r = math.random(-RANGE * 100, RANGE * 100) * 0.01
  return r
end

function reset()
  p1_x = (p2_x - p1_x) * 0.5 + p2_x
  p0_x = p2_x
  p2_x = rnd()
  p1_y = (p2_y - p1_y) * 0.5 + p2_y
  p0_y = p2_y
  p2_y = rnd()
  p1_z = (p2_z - p1_z) * 0.5 + p2_z
  p0_z = p2_z
  p2_z = rnd()
end

function self_collision_judgment()
  local gic = GetInstanceCount()
  local gdf = GetDeltaFrame(30)
  local rb = REB / gdf
  for i = 2, gic - 1 do
    for j = 2, gic - 1 do
      if i ~= j then
        local dvx, dvy, dvz = cpx[i] - cpx[j], cpy[i] - cpy[j], cpz[i] - cpz[j]
        local r = math.sqrt(math.pow(cpx[i] - cpx[j], 2) + math.pow(cpy[i] - cpy[j], 2) + math.pow(cpz[i] - cpz[j], 2))
        local ra = radius[i] / 2 + radius[j] / 2
        if r < ra then
          local vx, vy, vz = dvx / r * (ra - r), dvy / r * (ra - r), dvz / r * (ra - r)
          vlx[i], vly[i], vlz[i] = vlx[i] + vx * rb, vly[i] + vy * rb, vlz[i] + vz * rb
          cpx[i] = cpx[i] + vx * rb
          cpy[i] = cpy[i] + vy * rb
          cpz[i] = cpz[i] + vz * rb
          vlx[j], vly[j], vlz[j] = vlx[j] - vx * rb, vly[j] - vy * rb, vlz[j] - vz * rb
          cpx[j] = cpx[j] - vx * rb
          cpy[j] = cpy[j] - vy * rb
          cpz[j] = cpz[j] - vz * rb
        end
      end
    end
  end
end

function Update()
  local gic = GetInstanceCount()
  local gdf = GetDeltaFrame(30)
  t_ratio = (cycle - count_frame) / cycle
  cpx[1] = (1 - t_ratio) * (1 - t_ratio) * p2_x + 2 * (1 - t_ratio) * t_ratio * p1_x + t_ratio * t_ratio * p0_x
  cpy[1] = (1 - t_ratio) * (1 - t_ratio) * p2_y + 2 * (1 - t_ratio) * t_ratio * p1_y + t_ratio * t_ratio * p0_y
  cpz[1] = (1 - t_ratio) * (1 - t_ratio) * p2_z + 2 * (1 - t_ratio) * t_ratio * p1_z + t_ratio * t_ratio * p0_z
  count_frame = count_frame + gdf
  if 0 < count_frame - cycle then
    reset(i)
    count_frame = count_frame - cycle
  end
  for i = 1, gic do
    if i ~= 1 then
      local dvx, dvy, dvz = cpx[i] - cpx[1], cpy[i] - cpy[1], cpz[i] - cpz[1]
      local r = math.sqrt(math.pow(cpx[i] - cpx[1], 2) + math.pow(cpy[i] - cpy[1], 2) + math.pow(cpz[i] - cpz[1], 2))
      local ra = radius[1] / 2 + radius[i] / 2
      if r < ra then
        local vx, vy, vz = dvx / r * (ra - r), dvy / r * (ra - r), dvz / r * (ra - r)
        vlx[i], vly[i], vlz[i] = vlx[i] + vx * REB, vly[i] + vy * REB, vlz[i] + vz * REB
        cpx[i] = cpx[i] + vx * REB
        cpy[i] = cpy[i] + vy * REB
        cpz[i] = cpz[i] + vz * REB
      end
    end
  end
  local v = 0.993
  local sa = 1 - (1 - v) * gdf
  for i = 1, gic do
    if i ~= 1 then
      vlx[i], vly[i], vlz[i] = vlx[i] * sa, vly[i] * sa, vlz[i] * sa
      local distance = math.sqrt(math.pow(cpx[1] - cpx[i], 2) + math.pow(cpy[1] - cpy[i], 2) + math.pow(cpz[1] - cpz[i], 2))
      local g = 1 / math.pow(distance, 2) * 0.1 * gdf
      local gx, gy, gz = (cpx[1] - cpx[i]) * g, (cpy[1] - cpy[i]) * g, (cpz[1] - cpz[i]) * g
      vlx[i], vly[i], vlz[i] = vlx[i] + gx, vly[i] + gy, vlz[i] + gz
      cpx[i], cpy[i], cpz[i] = cpx[i] + vlx[i] * gdf, cpy[i] + vly[i] * gdf, cpz[i] + vlz[i] * gdf
    end
  end
  for i = 1, gic do
    SetInstancePosition(i, cpx[i], cpy[i], cpz[i])
  end
end
