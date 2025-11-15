local LOOPCYCLE = math.random(2000, 2500)
local DISTANCE = 20
local FLOCKSCALE_X = 200
local FLOCKSCALE_Y = 100
local FLOCKSCALE_Z = 400
local SHAKE = math.random(20, 30)
local RANGE = 30
local ESC_FRAME = 100
local BCK_FRAME = 150
local SCALE = 5
local OS_TY = 1
local ESC_SPD = 0.3
local state, esc_count, bck_count, start_ry_offset, root_os_pos_x, root_os_pos_y, root_os_pos_z
local rpx, rpz = {}, {}
local instance = {}
local df, count, gic

function Start()
  count = 0
  esc_count = ESC_FRAME
  bck_count = BCK_FRAME
  start_ry_offset = math.random(1, 1000)
  local ry_direct = math.random(1, 2)
  root_os_pos_x, root_os_pos_y, root_os_pos_z = GetPositionXYZ()
  state = 1
  gic = GetInstanceCount()
  for i = 1, LOOPCYCLE do
    if ry_direct == 1 then
      rpx[i] = math.sin(math.pi * 2 / LOOPCYCLE * i) * DISTANCE
      rpz[i] = math.cos(math.pi * 2 / LOOPCYCLE * i) * DISTANCE
    else
      rpx[i] = math.cos(math.pi * 2 / LOOPCYCLE * i) * DISTANCE
      rpz[i] = math.sin(math.pi * 2 / LOOPCYCLE * i) * DISTANCE
    end
  end
  for i = 1, gic do
    instance[i] = {
      tx = math.random(-FLOCKSCALE_X, FLOCKSCALE_X) * 0.01,
      ty = math.random(-FLOCKSCALE_Y, FLOCKSCALE_Y) * 0.01,
      tz = math.random(-FLOCKSCALE_Z, FLOCKSCALE_Z) * 0.01,
      ryv = math.random(80, 120) * 0.002,
      ryc = SHAKE,
      rya = {},
      txv = math.random(25, 45) * 0.01,
      txc = math.random(100, 300),
      txa = {},
      tyv = math.random(40, 100) * 0.01,
      tyc = math.random(150, 450),
      tya = {},
      tzv = math.random(50, 100) * 0.01,
      tzc = math.random(100, 300),
      tza = {},
      itx,
      ity,
      itz = 0,
      0,
      0,
      irx,
      iry,
      irz = 0,
      0,
      0,
      itx_st1,
      ity_st1,
      itz_st1 = 0,
      0,
      0,
      irx_st1,
      iry_st1,
      irz_st1 = 0,
      0,
      0,
      itx_st2,
      ity_st2,
      itz_st2 = 0,
      0,
      0,
      irx_st2,
      iry_st2,
      irz_st2 = 0,
      0,
      0
    }
    for r = 1, instance[i].ryc do
      instance[i].rya[r] = math.sin(math.pi * 2 / instance[i].ryc * r) * instance[i].ryv
    end
    for r = 1, instance[i].txc do
      instance[i].txa[r] = math.sin(math.pi * 2 / instance[i].txc * r) * instance[i].txv
    end
    for r = 1, instance[i].tyc do
      instance[i].tya[r] = math.sin(math.pi * 2 / instance[i].tyc * r) * instance[i].tyv
    end
    for r = 1, instance[i].tzc do
      instance[i].tza[r] = math.sin(math.pi * 2 / instance[i].tzc * r) * instance[i].tzv
    end
  end
  for i = 1, gic do
    SetInstancePosition(i, instance[i].tx, instance[i].ty, instance[i].tz)
    SetInstanceScale(i, SCALE, SCALE, SCALE)
  end
  local count_i = math.floor(count) + start_ry_offset
  state1(count_i)
end

function state1(count_i)
  for i = 1, gic do
    local ftx = count_i % instance[i].txc + 1
    local fty = count_i % instance[i].tyc + 1
    local ftz = count_i % instance[i].tzc + 1
    instance[i].itx = instance[i].tx + instance[i].txa[ftx]
    instance[i].ity = instance[i].ty + instance[i].tya[fty]
    instance[i].itz = instance[i].tz + instance[i].tza[ftz]
    instance[i].itx_st1 = instance[i].itx
    instance[i].ity_st1 = instance[i].ity
    instance[i].itz_st1 = instance[i].itz
    local frx = (count_i + math.floor(instance[i].tyc * 0.25)) % instance[i].tyc + 1
    local fry = count_i % instance[i].ryc + 1
    instance[i].irx = -instance[i].tya[frx] / 2
    instance[i].iry = instance[i].rya[fry]
    instance[i].irz = 0
    instance[i].irx_st1 = instance[i].irx
    instance[i].iry_st1 = instance[i].iry
    instance[i].irz_st1 = instance[i].irz
  end
end

function state2(count_i)
  local n = 0
  if esc_count > ESC_FRAME / 2 then
    n = 4
  elseif esc_count > ESC_FRAME / 3 then
    n = 2
  else
    n = 1
  end
  local cf = count_i % LOOPCYCLE + 1
  for i = 1, gic do
    local ftx = count_i % instance[i].txc + 1
    local fty = count_i % instance[i].tyc + 1
    local ftz = count_i % instance[i].tzc + 1
    local tx = inOutQuad(ESC_FRAME - esc_count, instance[i].itx_st1, instance[i].tx * ESC_SPD * ESC_FRAME - instance[i].itx_st1, ESC_FRAME)
    local ty = inOutQuad(ESC_FRAME - esc_count, instance[i].ity_st1, instance[i].ty * ESC_SPD * ESC_FRAME - instance[i].ity_st1, ESC_FRAME)
    local tz = inOutQuad(ESC_FRAME - esc_count, instance[i].itz_st1, instance[i].tz * ESC_SPD * ESC_FRAME - instance[i].itz_st1, ESC_FRAME)
    local ntx = instance[i].tx + tx * 0.5
    local nty = instance[i].ty + ty * 0.5
    local ntz = instance[i].tz + tz * 0.5
    instance[i].itx = linear(ESC_FRAME - esc_count, tx, ntx - tx, ESC_FRAME)
    instance[i].ity = linear(ESC_FRAME - esc_count, ty, nty - ty, ESC_FRAME)
    instance[i].itz = linear(ESC_FRAME - esc_count, tz, ntz - tz, ESC_FRAME)
    instance[i].itx_st2 = instance[i].itx
    instance[i].ity_st2 = instance[i].ity
    instance[i].itz_st2 = instance[i].itz
    local frx = (count_i + math.floor(instance[i].tyc * 0.25)) % instance[i].tyc + 1
    local fry = math.floor(count_i * n) % instance[i].ryc + 1
    local dis = math.sqrt(math.pow(instance[i].itx_st1 - instance[i].tx * ESC_SPD * ESC_FRAME, 2) + math.pow(instance[i].itz_st1 - instance[i].tz * ESC_SPD * ESC_FRAME, 2))
    local e_rx = math.atan2(instance[i].ity_st1 - instance[i].ty * ESC_SPD * ESC_FRAME, dis)
    local e_ry = math.atan2(instance[i].tx * ESC_SPD * ESC_FRAME - instance[i].itx_st1, instance[i].tz * ESC_SPD * ESC_FRAME - instance[i].itz_st1) + instance[i].rya[fry]
    local n_rx = math.atan2(instance[i].ty * ESC_SPD * ESC_FRAME - nty, dis)
    local n_ry = math.atan2(ntx - instance[i].tx * ESC_SPD * ESC_FRAME, ntz - instance[i].tz * ESC_SPD * ESC_FRAME) + instance[i].rya[fry]
    local rx = inQuad(ESC_FRAME - esc_count, e_rx, n_rx - e_rx, ESC_FRAME)
    local ry = inQuad(ESC_FRAME - esc_count, e_ry, n_ry - e_ry, ESC_FRAME)
    instance[i].irx = -instance[i].tya[frx] / 2 + rx
    instance[i].iry = instance[i].rya[fry] + ry
    instance[i].irz = 0
    instance[i].irx_st2 = instance[i].irx
    instance[i].iry_st2 = instance[i].iry
    instance[i].irz_st2 = instance[i].irz
  end
end

function state3(count_i)
  for i = 1, gic do
    local ftx = count_i % instance[i].txc + 1
    local fty = count_i % instance[i].tyc + 1
    local ftz = count_i % instance[i].tzc + 1
    instance[i].itx = outQuad(BCK_FRAME - bck_count, instance[i].itx_st2, instance[i].tx + instance[i].txa[ftx] - instance[i].itx_st2, BCK_FRAME)
    instance[i].ity = outQuad(BCK_FRAME - bck_count, instance[i].ity_st2, instance[i].ty + instance[i].tya[fty] - instance[i].ity_st2, BCK_FRAME)
    instance[i].itz = outQuad(BCK_FRAME - bck_count, instance[i].itz_st2, instance[i].tz + instance[i].tza[ftz] - instance[i].itz_st2, BCK_FRAME)
    local frx = (count_i + math.floor(instance[i].tyc * 0.25)) % instance[i].tyc + 1
    local fry = count_i % instance[i].ryc + 1
    local dis = math.sqrt(math.pow(instance[i].itx - (instance[i].tx + instance[i].txa[ftx]), 2) + math.pow(instance[i].itz - (instance[i].tz + instance[i].tza[ftz]), 2))
    local rx = math.atan2(instance[i].ity - (instance[i].ty + instance[i].tya[fty]), dis)
    local ry = math.atan2(instance[i].tx + instance[i].txa[ftx] - instance[i].itx, instance[i].tz + instance[i].tza[ftz] - instance[i].itz) + instance[i].rya[fry]
    local cur_rx = inQuad(BCK_FRAME - bck_count, rx, -instance[i].tya[frx] / 2 - rx, BCK_FRAME)
    local cur_ry = inQuad(BCK_FRAME - bck_count, ry, instance[i].rya[fry] - ry, BCK_FRAME)
    instance[i].irx = outQuart(BCK_FRAME - bck_count, instance[i].irx_st2, cur_rx - instance[i].irx_st2, BCK_FRAME)
    instance[i].iry = outQuart(BCK_FRAME - bck_count, instance[i].iry_st2, cur_ry - instance[i].iry_st2, BCK_FRAME) + instance[i].rya[fry] * (BCK_FRAME - bck_count) / BCK_FRAME
    instance[i].irz = 0
  end
end

function Update()
  local plr_x, plr_y, plr_z = GetPlayerPositionXYZ()
  df = GetDeltaFrame(30)
  local count_i = math.floor(count) + start_ry_offset
  local cf = count_i % LOOPCYCLE + 1
  local cfy = count_i % (SHAKE * df) + 1
  local pf = (count_i - 1) % LOOPCYCLE + 1
  local distance = math.pow(rpx[cf] + root_os_pos_x - plr_x, 2) + math.pow(OS_TY + root_os_pos_y - plr_y, 2) + math.pow(rpz[cf] + root_os_pos_z - plr_z, 2)
  if state == 1 and distance < RANGE then
    state = 2
  elseif state == 2 and esc_count <= 0 then
    state = 3
  elseif state == 3 and bck_count <= 0 then
    state = 1
  end
  local cry = math.atan2(rpx[cf] - rpx[pf], rpz[cf] - rpz[pf])
  if state == 1 then
    state1(count_i)
    esc_count = ESC_FRAME
    for i = 1, GetInstanceModelCount() do
      SetInstanceMaterialParamValue(i, "colladafxShader7_dup", Expression.keyEmissiveIntensity, 1)
      SetInstanceMaterialParamValue3(i, "colladafxShader7_dup", Expression.keyEmissiveColor, 0, 0.75, 1)
    end
  elseif state == 2 then
    state2(count_i)
    esc_count = esc_count - df
    bck_count = BCK_FRAME
    for i = 1, GetInstanceModelCount() do
      SetInstanceMaterialParamValue(i, "colladafxShader7_dup", Expression.keyEmissiveIntensity, (ESC_FRAME - esc_count) / ESC_FRAME * 5 + 1)
      SetInstanceMaterialParamValue3(i, "colladafxShader7_dup", Expression.keyEmissiveColor, 1, 0, 0)
    end
  else
    state3(count_i)
    bck_count = bck_count - df
    for i = 1, GetInstanceModelCount() do
      SetInstanceMaterialParamValue(i, "colladafxShader7_dup", Expression.keyEmissiveIntensity, 1)
      SetInstanceMaterialParamValue3(i, "colladafxShader7_dup", Expression.keyEmissiveColor, 0.75, 1, 0)
    end
  end
  SetPosition(rpx[cf] + root_os_pos_x, 0 + root_os_pos_y, rpz[cf] + root_os_pos_z)
  SetRotation(0, cry, 0)
  for i = 1, gic do
    SetInstancePosition(i, instance[i].itx, instance[i].ity, instance[i].itz)
    SetInstanceRotation(i, instance[i].irx, instance[i].iry, instance[i].irz)
  end
  count = count + df
end

function inQuad(t, b, c, d)
  t = t / d
  return c * math.pow(t, 2) + b
end

function outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end

function inQuart(t, b, c, d)
  t = t / d
  return c * math.pow(t, 4) + b
end

function outQuart(t, b, c, d)
  t = t / d - 1
  return -c * (math.pow(t, 4) - 1) + b
end

function linear(t, b, c, d)
  return c * t / d + b
end

function outInQuad(t, b, c, d)
  if t < d / 2 then
    return outQuad(t * 2, b, c / 2, d)
  else
    return inQuad(t * 2 - d, b + c / 2, c / 2, d)
  end
end

function inOutQuad(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * math.pow(t, 2) + b
  else
    return -c / 2 * ((t - 1) * (t - 3) - 1) + b
  end
end

function outQuart(t, b, c, d)
  t = t / d - 1
  return -c * (math.pow(t, 4) - 1) + b
end
