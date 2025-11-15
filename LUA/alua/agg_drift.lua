local CYCLE_TX = 300
local VALUE_TX = 15
local CYCLE_TY = 800
local VALUE_TY = 15
local CYCLE_TZ = 340
local VALUE_TZ = 15
local BIG_SPHERE_SIZE = 13
local CYCLE_NTX = math.random(100, 200)
local CYCLE_NTY = math.random(100, 200)
local CYCLE_NTZ = math.random(100, 200)
local FOLLOW = 40
local cpx, cpy, cpz = {}, {}, {}
local cs = {}
local cwx, cwy, cwz = {}, {}, {}
local count, cyctx, cycty, cyctz, valtx, valty, valtz
local sin_mtx = {}
local sin_mty = {}
local sin_mtz = {}
local sin_ntx = {}
local sin_nty = {}
local sin_ntz = {}

function Start()
  count = 0
  cyctx = math.random(CYCLE_TX / 2, CYCLE_TX * 2)
  valtx = math.random(VALUE_TX / 2, VALUE_TX * 2)
  cycty = math.random(CYCLE_TY / 2, CYCLE_TY * 2)
  valty = math.random(VALUE_TY / 2, VALUE_TY * 2)
  cyctz = math.random(CYCLE_TZ / 2, CYCLE_TZ * 2)
  valtz = math.random(VALUE_TZ / 2, VALUE_TZ * 2)
  for i = 1, cyctx do
    sin_mtx[i] = math.sin(6.28 / cyctx * i) * valtx
  end
  for i = 1, cycty do
    sin_mty[i] = math.sin(6.28 / cycty * i) * valty
  end
  for i = 1, cyctz do
    sin_mtz[i] = math.sin(6.28 / cyctz * i) * valtz
  end
  for i = 1, CYCLE_NTX do
    sin_ntx[i] = math.sin(6.28 / CYCLE_NTX * i) * valtx / 10
  end
  for i = 1, CYCLE_NTY do
    sin_nty[i] = math.sin(6.28 / CYCLE_NTY * i) * valty / 10
  end
  for i = 1, CYCLE_NTZ do
    sin_ntz[i] = math.sin(6.28 / CYCLE_NTZ * i) * valtz / 10
  end
  for i = 1, GetInstanceCount() do
    if i == 1 then
      cpx[i], cpy[i], cpz[i] = 0, 0, 0
      cs[i] = BIG_SPHERE_SIZE
      cwx[i], cwy[i], cwz[i] = 1, 1, 1
    else
      cpx[i] = math.random(-400, 400) * 0.01
      cpy[i] = math.random(-400, 400) * 0.01
      cpz[i] = math.random(-400, 400) * 0.01
      cs[i] = math.random(50, 150) * 0.01
      cwx[i] = math.random(70, 150) * 0.01 / cs[i]
      cwy[i] = math.random(70, 150) * 0.01 / cs[i]
      cwz[i] = math.random(70, 150) * 0.01 / cs[i]
    end
    SetInstanceScale(i, cs[i], cs[i], cs[i])
  end
end

function Update()
  local gic = GetInstanceCount()
  local fc = math.floor(count) + gic
  local gdf = GetDeltaFrame(30)
  local btx, bty, btz
  for i = 1, gic do
    local flw = i % FOLLOW
    local mtx = sin_mtx[(fc - flw) % cyctx + 1]
    local mty = sin_mty[(fc - flw) % cycty + 1]
    local mtz = sin_mtz[(fc - flw) % cyctz + 1]
    local ntx = sin_ntx[(fc + i) % CYCLE_NTX + 1]
    local nty = sin_nty[(fc + i) % CYCLE_NTY + 1]
    local ntz = sin_ntz[(fc + i) % CYCLE_NTZ + 1]
    local px = mtx * cwx[i] + cpx[i] + ntx * cwx[i]
    local py = mty * cwy[i] + cpy[i] + nty * cwy[i]
    local pz = mtz * cwz[i] + cpz[i] + ntz * cwz[i]
    if i == 1 then
      btx, bty, btz = px, py, pz
    end
    local distance = math.sqrt(math.pow(btx - px, 2) + math.pow(bty - py, 2) + math.pow(btz - pz, 2))
    if i == 1 then
      SetInstancePosition(i, px, py, pz)
    elseif distance > BIG_SPHERE_SIZE / 2 + cs[i] / 2 then
      SetInstancePosition(i, px, py, pz)
    else
      local range = BIG_SPHERE_SIZE / 2 + cs[i] / 2
      local sa = range - distance
      local ppx = (-sa * btx + range * px) / (range - sa)
      local ppy = (-sa * bty + range * py) / (range - sa)
      local ppz = (-sa * btz + range * pz) / (range - sa)
      SetInstancePosition(i, ppx, ppy, ppz)
    end
  end
  count = count + gdf
end
