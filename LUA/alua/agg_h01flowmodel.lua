local cpx, cpy, cpz = {}, {}, {}
local cs = {}
local rp = {}
local cf = {}
local cr = {}
local cd = {}
local dec = 1.5
local Thr = 3
local r_spd = 0.3

function Start()
  for i = 1, GetInstanceCount() do
    reset(i)
  end
end

function reset(i)
  cf[i] = 0
  cpx[i] = math.random(-10, 10) * 10
  cpy[i] = math.random(-50, 1000) * 10
  cpz[i] = math.random(-10, 10) * 10
  rp[i] = math.random(10, 100) * 0.01
  cs[i] = math.random(50, 500) * 0.05
  cr[i] = math.random(10, 200) * Thr
  cd[i] = cr[i] - cr[i] / dec
  SetInstancePositionX(i, cpx[i])
  SetInstancePositionY(i, cpy[i])
  SetInstancePositionZ(i, cpz[i])
  SetInstanceScaleX(i, cs[i])
  SetInstanceScaleY(i, cs[i])
  SetInstanceScaleZ(i, cs[i])
end

function Update()
  for i = 1, GetInstanceCount() do
    cf[i] = cf[i] + GetDeltaFrame(30)
    cpy[i] = cf[i] / (rp[i] / r_spd) + rp[i] - 1
    if cd[i] < cpy[i] then
      cs[i] = cs[i] / dec
    end
    SetInstancePositionY(i, cpy[i])
    SetInstanceScaleX(i, cs[i])
    SetInstanceScaleY(i, cs[i])
    SetInstanceScaleZ(i, cs[i])
    if cr[i] < cpy[i] then
      reset(i)
    end
  end
end
