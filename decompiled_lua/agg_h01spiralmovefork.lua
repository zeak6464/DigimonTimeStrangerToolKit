local RND_POSZ = 3
local RND_POSY = 3
local STR_POSX = -8
local END_POSX = 8
local CIRCLESIZE = 1
local REVERSE = -1
local SPIRALSPEED = -0.55
local MOVESPEED = 0.3
local SCALE = 1.5
local cpx, cpy, cpz = {}, {}, {}
local spy, spz = {}, {}
local count

function Start()
  count = 0
  for i = 1, GetInstanceCount() do
    reset(i)
    cpx[i] = math.random(STR_POSX, END_POSX)
    SetInstanceScale(i, SCALE, SCALE, SCALE)
  end
end

function reset(i)
  cpx[i], cpy[i], cpz[i] = STR_POSX * REVERSE, 0, 0
  spy[i] = math.random(-RND_POSY, RND_POSY)
  spz[i] = math.random(-RND_POSZ, RND_POSZ)
end

function Update()
  local gdf = GetDeltaFrame(30)
  local rd
  for i = 1, GetInstanceCount() do
    rd = math.rad((count * SPIRALSPEED + i) % 360)
    cpx[i] = cpx[i] + gdf * MOVESPEED * REVERSE
    cpz[i] = math.sin(rd) * CIRCLESIZE + spz[i]
    cpy[i] = math.cos(rd) * CIRCLESIZE + spy[i]
    if 0 < REVERSE then
      if cpx[i] > END_POSX then
        reset(i)
      end
    elseif cpx[i] < END_POSX * REVERSE then
      reset(i)
    end
    SetInstancePosition(i, cpx[i], cpy[i], cpz[i])
  end
  count = count + gdf
end
