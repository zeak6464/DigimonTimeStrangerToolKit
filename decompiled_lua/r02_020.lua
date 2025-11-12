require("include")

function r02_020(CameraParam)
  local DigimonId = 0
  if Debug.IsEventView() then
    DigimonId = 96
  else
    DigimonId = Field.GetDigimonIDFromPlayerScriptDigimonRideUI(Enum.DigimonRideTypeFall())
  end
  local string_pre = "r"
  local string_out = "_out01"
  local string_id_number = string.format("%03d", DigimonId)
  local out_motion = string_pre .. string_id_number .. string_out
  EVENT_BEGIN(BLACKOUT)
  if Debug.IsEventView() then
    CameraParam = 1
  end
  if CameraParam == 1 then
    LoadCamera("cam_01", "Cam_fall_out01")
  elseif CameraParam == 2 then
    LoadCamera("cam_01", "Cam_fall_out02")
  elseif CameraParam == 3 then
    LoadCamera("cam_01", "Cam_fall_out03")
  elseif CameraParam == 4 then
    LoadCamera("cam_01", "Cam_fall_out04")
  end
  if Debug.IsEventView() then
    LoadModel("HERO_01", "Player")
    LoadModel("FALL", "chr096")
  else
    Vista.LoadDigimonRideModel("FALL", Enum.DigimonRideTypeFall())
  end
  if Debug.IsEventView() then
    Vista.LoadAnimation("HERO_01", out_motion)
  else
    Field.PlayerLoadAnimation(out_motion)
  end
  Vista.LoadAnimation("FALL", out_motion)
  while Field.IsLoadingPlayerAnimation("") do
    WaitFrame(Util.SecondFromFrame(1))
  end
  WaitVistaLoad()
  SetScale("FALL", 1, 1, 1)
  if Debug.IsEventView() then
    PlayMotion("HERO_01", out_motion, 0, false, 0)
  else
    Motion.Player:Play(out_motion, 0, false)
  end
  PlayMotion("FALL", out_motion, 0, false, 0)
  print("====out_motion===")
  print(out_motion)
  Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, false)
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false, false)
  EVENT_START()
  CUT(1)
  PlayCamera("cam_01")
  if not Debug.IsEventView() then
    Vista.CopyPlayerPositionModel("FALL")
    Vista.CopyPlayerPositionCamera()
  end
  Fade_In(0, 15)
  while not Vista.IsEndAnimation("FALL", Util.SecondFromFrame(0)) do
    WaitFrame(1)
  end
  EVENT_END_SEAMLESS(45)
end

function CUT(cut_no)
  CUT_START()
end

function main()
  r02_020()
end
