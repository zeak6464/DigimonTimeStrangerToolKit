forceOperateAnime = true
initialize = false
is_start = true
local range = 5
rnd = math.random() * 10 - 5

function entryJoint()
  return {
    "act_sunlight_mesh_1"
  }
end

function main()
  px, py, pz = GetPlayerPos()
  ox, oy, oz = GetPos()
  local distance = math.sqrt(math.pow(ox - px, 2) + math.pow(oz - pz, 2))
  if distance >= range then
    SetScale(1, 2 / ((distance + range) / 10))
  else
    SetScale(1, 2 + (range - distance))
  end
end
