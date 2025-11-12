require("include")

function r03_005(option1)
  if Flag.Check(7273) then
    gDigimonId = 348
  else
    gDigimonId = Field.GetDigimonIDFromPlayerScriptDigimonRideUI(Enum.DigimonRideTypeJump())
  end
  local string_pre = "r"
  local string_in1 = "_in01"
  local string_in2 = "_in02"
  local string_out = "_out01"
  local string_id_number = string.format("%03d", gDigimonId)
  local in_motion1 = string_pre .. string_id_number .. string_in1
  local in_motion2 = string_pre .. string_id_number .. string_in2
  local out_motion = string_pre .. string_id_number .. string_out
  EVENT_BEGIN(SEAMLESS)
  Vista.LoadCameraAnimationID("cam_IN_01", "Cam_r03_in01")
  Vista.LoadCameraAnimationID("cam_IN_02", "Cam_r03_in02")
  Vista.LoadCameraAnimationID("cam_OUT", "Cam_r03_out01")
  if Flag.Check(7273) then
    Vista.LoadModelID("WHIP", "chr348")
  else
    Vista.LoadDigimonRideModel("WHIP", Enum.DigimonRideTypeJump())
  end
  Field.PlayerLoadAnimation(in_motion2)
  Field.PlayerLoadAnimation(out_motion)
  Vista.LoadAnimation("WHIP", in_motion1)
  Vista.LoadAnimation("WHIP", in_motion2)
  Vista.LoadAnimation("WHIP", out_motion)
  WaitVistaLoad()
  Vista.SetScale("WHIP", 1, 1, 1)
  Vista.AttachLocate("WHIP", option1)
  Vista.PlayAnimation("WHIP", in_motion1, 0, false, 0)
  local slot01 = 0
  print(string_id_number)
  if string_id_number == "142" then
    print("===== needle =====")
    slot01 = Sound.PlaySE(200028, 100)
  else
    print("===== roll =====")
    slot01 = Sound.PlaySE(200027, 100)
  end
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, false)
  EVENT_START()
  CUT_01()
  Vista.PlayCameraAnimation("cam_IN_01")
  Vista.LocateCamera(option1)
  WaitFrame(20)
end

function CUT_01()
  CUT_START()
end
