require("include")

function r03_020()
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
  Vista.SetScale("WHIP", 1, 1, 1)
  Motion.Player:Play(out_motion, 0, false)
  Vista.PlayAnimation("WHIP", out_motion, 0, false, 0)
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false, false)
  CUT_01()
  Vista.ReleaseLocateCamera()
  Vista.PlayCameraAnimation("cam_OUT")
  Vista.CopyPlayerPositionModel("WHIP")
  Vista.CopyPlayerPositionCamera()
  CAM_WAIT(0)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 30, false, false)
  EVENT_END_SEAMLESS(30)
end

function CUT_01()
  CUT_START()
end

function main()
  r03_020()
end
