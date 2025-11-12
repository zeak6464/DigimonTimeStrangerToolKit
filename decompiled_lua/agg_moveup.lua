local cpx, cpy, cpz = {}, {}, {}
local crx, cry, crz = {}, {}, {}
local csx, csy, csz = {}, {}, {}
local rpx, rpy, rpz = {}, {}, {}
local rrx, rry, rrz = {}, {}, {}
local count_frame
local loop_frame = 110
local start_fade_frame = 95
local r_spd = 0.2

function Start()
  reset()
  count_frame = math.random(0, loop_frame) - math.random(0, loop_frame)
end

function reset()
  for i = 1, GetInstanceCount() do
    cpx[i] = math.random(-10, 10) * 0.01
    cpz[i] = math.random(-10, 10) * 0.01
    crx[i] = 0
    cry[i] = 0
    crz[i] = 0
    rpx[i] = math.random(-10, 10) * 5.0E-4
    rpy[i] = math.random(10, 100) * 0.01
    rpz[i] = math.random(-10, 10) * 5.0E-4
    rrx[i] = math.random(-100, 100) * 0.01
    rry[i] = math.random(-100, 100) * 0.01
    rrz[i] = math.random(-100, 100) * 0.01
    csx[i] = math.random(50, 500) * 0.05
    csy[i] = math.random(50, 500) * 0.05
    csz[i] = math.random(50, 500) * 0.05
  end
end

function Update()
  local m_value = (count_frame - start_fade_frame) / (loop_frame - start_fade_frame)
  if m_value < 0 then
    m_value = 0
  end
  for i = 1, GetInstanceCount() do
    cpx[i] = cpx[i] + rpx[i]
    cpy[i] = count_frame / (rpy[i] / r_spd) + rpy[i] - 1
    cpz[i] = cpz[i] + rpz[i]
    crx[i] = crx[i] + rrx[i]
    cry[i] = cry[i] + rry[i]
    crz[i] = crz[i] + rrz[i]
    SetInstancePositionX(i, cpx[i])
    SetInstancePositionY(i, cpy[i])
    SetInstancePositionZ(i, cpz[i])
    SetInstanceRotation(i, math.rad(crx[i]), math.rad(cry[i]), math.rad(crz[i]))
    SetInstanceScaleX(i, csx[i])
    SetInstanceScaleY(i, csy[i])
    SetInstanceScaleZ(i, csz[i])
  end
  for i = 1, GetInstanceModelCount() do
    SetInstanceMaterialParamValue(i, "h04_basecolor01_0", Expression.keyScratchBorder, m_value)
  end
  count_frame = count_frame + GetDeltaFrame(30)
  if 0 < count_frame - start_fade_frame - (loop_frame - start_fade_frame) then
    reset()
    count_frame = count_frame - start_fade_frame - (loop_frame - start_fade_frame)
  end
end
