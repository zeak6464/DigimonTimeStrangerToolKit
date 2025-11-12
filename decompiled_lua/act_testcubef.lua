forceOperateAnime = true
initialize = false
is_start = true
local range = 5

function set_rnd()
  return math.random() * 10 - 5
end

function entryJoint()
  return {"TestCube_1", "TestCube_F"}
end

function main()
  if not initialize then
    SetAnimeFrame(0)
    SetAnimeStartFrame(0)
    SetAnimeEndFrame(0)
    SetAnimeLoop(false)
    initialize = true
    rnd_x = set_rnd()
    rnd_y = set_rnd() / 100
    rnd_z = set_rnd()
    px, py, pz = GetPlayerPos()
    old_x = px
    old_y = py
    old_z = pz
    mag = 50
    height = 0
    size = 2.5
    ox = (px - old_x) * mag + px + rnd_x
    oz = (pz - old_z) * mag + pz + rnd_z
    range_in = false
    show_frame_range = 40
    show_frame = show_frame_range
    old_range_in = false
    SetScale(2, size)
  end
  frame = GetFrame()
  px, py, pz = GetPlayerPos()
  local kyori = math.sqrt(math.pow(ox - px, 2) + math.pow(oz - pz, 2))
  if kyori < range then
    range_in = true
  else
    range_in = false
  end
  if old_range_in == false and range_in == true then
    SetAnimeFrame(0)
    SetAnimeStartFrame(0)
    SetAnimeEndFrame(20)
  end
  if range_in == true then
    show_frame = frame + show_frame_range
  end
  if range_in == false and frame > show_frame or kyori > range * 1.25 then
    rnd_x = set_rnd()
    rnd_y = set_rnd() / 100
    rnd_z = set_rnd()
    ox = (px - old_x) * mag + px + rnd_x
    oz = (pz - old_z) * mag + pz + rnd_z
    show_frame = frame
  elseif old_range_in == true and range_in == false and frame < show_frame then
    SetAnimeFrame(30)
    SetAnimeStartFrame(30)
    SetAnimeEndFrame(60)
  end
  if frame < show_frame then
    SetPosX(2, ox)
    SetPosY(2, height + rnd_y)
    SetPosZ(2, oz)
  end
  old_x = px
  old_y = py
  old_z = pz
  old_range_in = range_in
end
