local RND_POSX = 30
local RND_POSZ = 30
local STR_POSY = -10
local END_POSY = 20
local CIRCLESIZE = 5
local SPIRALSPEED = 0.5
local RISESPEED = 0.15
local SCALE = 1
local cpx, cpy, cpz = {}, {}, {}
local spx, spz = {}, {}, {}
local count

function Start()
  count = 0
  for i = 1, GetInstanceCount() do
    reset(i)
    cpy[i] = math.random(STR_POSY, END_POSY)
    SetInstanceScale(i, SCALE, SCALE, SCALE)
  end
end

function reset(i)
  cpx[i], cpy[i], cpz[i] = 0, STR_POSY, 0
  spx[i] = math.random(-RND_POSX, RND_POSX)
  spz[i] = math.random(-RND_POSZ, RND_POSZ)
end

function Update()
  local gdf = GetDeltaFrame(30)
  local rd
  for i = 1, GetInstanceCount() do
    rd = math.rad((count * SPIRALSPEED + i) % 360)
    cpy[i] = cpy[i] + gdf * RISESPEED
    cpx[i] = math.sin(rd) * CIRCLESIZE + spx[i]
    cpz[i] = math.cos(rd) * CIRCLESIZE + spz[i]
    if cpy[i] > END_POSY then
      reset(i)
    end
    SetInstancePosition(i, cpx[i], cpy[i], cpz[i])
  end
  count = count + gdf
end
