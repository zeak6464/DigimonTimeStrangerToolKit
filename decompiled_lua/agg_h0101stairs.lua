local RANGE = 5
local OUT_START_FRAME = 1
local OUT_END_FRAME = 18
local IN_START_FRAME = 20
local IN_END_FRAME = 30

function Start()
  local max_count = GetInstanceMaxCount()
  for i = 0, max_count do
    SetInstanceAnimeFrame(i, IN_START_FRAME)
    SetInstanceAnimeStartFrame(i, IN_START_FRAME)
    SetInstanceAnimeEndFrame(i, IN_START_FRAME)
  end
end

function Update()
  setOn = 0
  local px, py, pz = GetPlayerPos()
  local max_count = GetInstanceMaxCount()
  local range_sqr = RANGE * RANGE
  if setOn == 0 then
    for i = 0, max_count do
      local ox, oy, oz = GetInstanceJointPos(i)
      local distance_sqr = math.pow(ox - px, 2) + math.pow(oz - pz, 2) + math.pow(oy - py, 2)
      if GetInstanceFlag(i, 0) then
        if range_sqr < distance_sqr then
          SetInstanceAnimeFrame(i, OUT_START_FRAME)
          SetInstanceAnimeStartFrame(i, OUT_START_FRAME)
          SetInstanceAnimeEndFrame(i, OUT_END_FRAME)
          SetInstanceFlag(i, 0, false)
        end
      elseif range_sqr >= distance_sqr then
        SetInstanceAnimeFrame(i, IN_START_FRAME)
        SetInstanceAnimeStartFrame(i, IN_START_FRAME)
        SetInstanceAnimeEndFrame(i, IN_END_FRAME)
        SetInstanceFlag(i, 0, true)
      end
    end
  end
end
