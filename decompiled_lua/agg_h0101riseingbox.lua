local RANGE = 5
local OUT_START_FRAME = 0
local OUT_END_FRAME = 18
local IN_START_FRAME = 19
local IN_END_FRAME = 799

function Start()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    SetInstanceAnimeFrame(i, IN_END_FRAME)
    SetInstanceAnimeStartFrame(i, IN_END_FRAME)
    SetInstanceAnimeEndFrame(i, IN_END_FRAME)
  end
end

function Update()
  local px, py, pz = GetPlayerPos()
  local max_count = GetInstanceMaxCount()
  local range_sqr = RANGE
  for i = 0, max_count do
    local ox, oy, oz = GetInstanceJointPos(i)
    local distance_sqr = math.pow(ox - px, 2) + math.pow(oz - pz, 2)
    if range_sqr > distance_sqr then
      SetInstanceAnimeFrame(i, IN_START_FRAME)
      SetInstanceAnimeStartFrame(i, IN_START_FRAME)
      SetInstanceAnimeEndFrame(i, IN_END_FRAME)
    end
  end
end
