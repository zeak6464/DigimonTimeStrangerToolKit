require("include")

function d05_01(locator)
  EVENT_BEGIN()
  LoadCamera("cam_01", "d05_01_cam")
  LoadModel("chr183aa010101_01", "char_AEGIOMON")
  Vista.LoadAnimation("chr183aa010101_01", "fg04_in01")
  WaitVistaLoad()
  FIELD_SET()
  EVENT_START()
  CUT_01()
  AttachLocate("chr183aa010101_01", locator)
  PlayMotion("chr183aa010101_01", "fg04_in01", 0, false, 0)
  Event_PlaySE(400002, 100, false, 0, 0)
  PlayCamera("cam_01")
  LocateCamera(locator)
  WaitFrame(10)
  CAM_WAIT(5)
  Fade_Out(0, 5)
  WaitFrame(5)
  EVENT_END()
end

function CUT_01()
  CUT_START()
end

function main()
  d05_01()
end
