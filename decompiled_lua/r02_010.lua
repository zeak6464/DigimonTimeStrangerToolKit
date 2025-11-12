require("include")

function r02_010(locator, CameraParam)
  local DigimonId = 0
  if Debug.IsEventView() then
    DigimonId = 96
  else
    DigimonId = Field.GetDigimonIDFromPlayerScriptDigimonRideUI(Enum.DigimonRideTypeFall())
  end
  local string_pre = "r"
  local string_in = "_in01"
  local string_id_number = string.format("%03d", DigimonId)
  local in_motion = string_pre .. string_id_number .. string_in
  EVENT_BEGIN(SEAMLESS)
  if Debug.IsEventView() then
    CameraParam = 1
  end
  if CameraParam == 1 then
    LoadCamera("cam_01", "Cam_fall_in01")
  elseif CameraParam == 2 then
    LoadCamera("cam_01", "Cam_fall_in02")
  elseif CameraParam == 3 then
    LoadCamera("cam_01", "Cam_fall_in03")
  elseif CameraParam == 4 then
    LoadCamera("cam_01", "Cam_fall_in04")
  end
  LoadModel("HERO_01", "Player")
  if Debug.IsEventView() then
    LoadModel("FALL", "chr096")
  else
    Vista.LoadDigimonRideModel("FALL", Enum.DigimonRideTypeFall())
  end
  Vista.LoadAnimation("FALL", in_motion)
  Vista.LoadAnimation("HERO_01", in_motion)
  WaitVistaLoad()
  SetScale("FALL", 1, 1, 1)
  if not Debug.IsEventView() then
    AttachLocate("FALL", locator)
    AttachLocate("HERO_01", locator)
  end
  PlayMotion("FALL", in_motion, 0, false, 0)
  PlayMotion("HERO_01", in_motion, 0, false, 0)
  print("====in_motion===")
  print(in_motion)
  Field_InvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, false)
  EVENT_START()
  CUT(1)
  PlayCamera("cam_01")
  if not Debug.IsEventView() then
    LocateCamera(locator)
  end
  while not Vista.IsEndAnimation("HERO_01", Util.SecondFromFrame(10)) do
    WaitFrame(1)
  end
  Fade_Out(0, 10)
  WaitFrame(10)
  EVENT_END()
end

function CUT(cut_no)
  CUT_START()
end

function main()
  r02_010()
end
