require("include")

function d05_01c(locator)
  EVENT_BEGIN()
  LoadCamera("cam_01", "d05_01_cam")
  LoadModel("chr184aa010101_01", "chr184aa010101")
  Vista.LoadAnimation("chr184aa010101_01", "fg04_in01")
  while Field.IsLoadingPlayerAnimation("fg04_in01") do
    WaitFrame(Util.SecondFromFrame(1))
  end
  WaitVistaLoad()
  FIELD_SET()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false, false)
  EVENT_START()
  CUT_01()
  AttachLocate("chr184aa010101_01", locator)
  PlayMotion("chr184aa010101_01", "fg04_in01", 0, false, 0)
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
  d05_01c()
end
