require("include")

function r01_020(locator)
  Field.SetPlayerRotationToLocator(locator, 3)
  Field.MovePlayerToLocatorFrame(locator, 30)
  WaitFrame(3)
  EVENT_BEGIN(SEAMLESS)
  Vista.LoadCameraAnimationID("cam_OUT_01", "Cam_r01_010")
  WaitVistaLoad()
  EVENT_START()
  CUT_01()
  Vista.PlayCameraAnimation("cam_OUT_01")
  Vista.CopyPlayerPositionCamera()
  CAM_WAIT(0)
  EVENT_END_SEAMLESS(30)
end

function CUT_01()
  CUT_START()
end

function main()
  r01_020()
end
