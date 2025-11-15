forceOperateAnime = true
initialize = false
is_start = false

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
  if not is_start then
    if kyori <= 8 then
      SetAnimeEndFrame(20)
      is_start = true
    end
  elseif 8 <= kyori then
    SetAnimeEndFrame(100)
    is_start = false
  end
end
