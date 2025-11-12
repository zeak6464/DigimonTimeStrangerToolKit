forceOperateAnime = true
is_start = false
anime_frame = 0

function main()
  if not is_start then
    px, py, pz = GetPlayerPos()
    ox, oy, oz = GetPos()
    local kyori = math.sqrt(math.pow(ox - px, 2) + math.pow(oz - pz, 2))
    if kyori <= 3 then
      is_start = true
    end
  end
  if is_start and anime_frame < 20 then
    anime_frame = anime_frame + GetElapsedFrame()
    if anime_frame > 20 then
      anime_frame = 20
    end
  end
  SetAnimeFrame(anime_frame)
end
