require("include")

function r03_010()
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
  Motion.Player:Play(in_motion2, 0, false)
  Vista.PlayAnimation("WHIP", in_motion2, 0, false, 0)
  CUT_01()
  Vista.ReleaseLocateCamera()
  Vista.PlayCameraAnimation("cam_IN_02")
  Vista.CopyPlayerPositionModel("WHIP")
  Vista.CopyPlayerPositionCamera()
  CAM_WAIT(0)
end

function CUT_01()
  CUT_START()
end

function main()
  r03_010()
end
