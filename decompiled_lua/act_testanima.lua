forceOperateAnime = true

function main()
  time = GetTime()
  frame = GetFrame(1)
  x, y, z = GetPos()
  SetAnimeLoop(false)
  if frame > 350 then
    SetAnimeFrame(350)
  end
end
