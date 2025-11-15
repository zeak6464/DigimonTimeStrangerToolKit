require("include")

function r01_010(locator)
  EVENT_BEGIN(SEAMLESS)
  Vista.LoadCameraAnimationID("cam_IN_01", "Cam_r01_010")
  WaitVistaLoad()
  Field.MovePlayerToLocatorFrame(locator, 45)
  EVENT_START()
  CUT_01()
  Vista.PlayCameraAnimation("cam_IN_01")
  Vista.StartSeamlessCameraFrame(45, "SCURVE")
  Vista.CopyPlayerPositionCamera()
  CAM_WAIT(0)
  EVENT_END_SEAMLESS(30)
end

function CUT_01()
  CUT_START()
end

function main()
  r01_010()
end
