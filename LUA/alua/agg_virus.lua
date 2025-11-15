local CYCLE_TX = 400
local VALUE_TX = 7
local CYCLE_TY = 1000
local VALUE_TY = 7
local CYCLE_TZ = 580
local VALUE_TZ = 7
local BIG_SPHERE_SIZE = 10
local CYCLE_NTX = math.random(100, 200)
local CYCLE_NTY = math.random(100, 200)
local CYCLE_NTZ = math.random(100, 200)
local FOLLOW = 20
local cpx, cpy, cpz = {}, {}, {}
local bcs = {}
local ccs = {}
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
      bcs[i] = BIG_SPHERE_SIZE
      cwx[i], cwy[i], cwz[i] = 1, 1, 1
    else
      cpx[i] = math.random(-400, 400) * 0.01
      cpy[i] = math.random(-400, 400) * 0.01
      cpz[i] = math.random(-400, 400) * 0.01
      bcs[i] = math.random(100, 300) * 0.01
      cwx[i] = math.random(70, 150) * 0.01 / bcs[i]
      cwy[i] = math.random(70, 150) * 0.01 / bcs[i]
      cwz[i] = math.random(70, 150) * 0.01 / bcs[i]
    end
    ccs[i] = bcs[i]
    SetInstanceScale(i, bcs[i], bcs[i], bcs[i])
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
    elseif distance > BIG_SPHERE_SIZE / 2 + ccs[i] / 2 then
      ccs[i] = ccs[i] - bcs[i] * 0.04
      if ccs[i] < 0 then
        ccs[i] = 0
      end
    else
      ccs[i] = ccs[i] + 0.02
      if ccs[i] > bcs[i] then
        ccs[i] = bcs[i]
      end
      local range = BIG_SPHERE_SIZE / 2 + ccs[i] / 2
      local sa = range - distance
      local ppx = (-sa * btx + range * px) / (range - sa)
      local ppy = (-sa * bty + range * py) / (range - sa)
      local ppz = (-sa * btz + range * pz) / (range - sa)
      SetInstancePosition(i, ppx, ppy, ppz)
    end
    SetInstanceScale(i, ccs[i], ccs[i], ccs[i])
  end
  count = count + gdf
end
