forceOperateAnime = true
initialize = false
is_start = true
local range = 3
rnd = math.random() * 10 - 5

function entryJoint()
  return {"TestCube_C"}
end

function main()
  if not initialize then
    SetAnimeFrame(0)
    SetAnimeStartFrame(0)
    SetAnimeEndFrame(0)
    SetAnimeLoop(false)
    initialize = true
  end
  px, py, pz = GetPlayerPos()
  ox, oy, oz = GetPos()
  local kyori = math.sqrt(math.pow(ox - px, 2) + math.pow(oz - pz, 2))
  if is_start then
    if kyori <= range then
      SetAnimeFrame(20)
      SetAnimeStartFrame(20)
      SetAnimeEndFrame(30)
      is_start = false
    end
  elseif kyori >= range then
    SetAnimeFrame(80)
    SetAnimeStartFrame(80)
    SetAnimeEndFrame(90)
    is_start = true
  end
end
