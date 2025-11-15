require("include")

function t3001_01(option1)
  EVENT_BEGIN()
  Vista.LoadBackGround("t3001")
  LoadCamera("cam_01", "Cam_t3001_01")
  WaitVistaLoad()
  Field_InvisiblePlayer(INVISIBLE_KEY_EVENT, 30, true)
  EVENT_START()
  CUT_01()
  PlayCamera("cam_01")
  LocateCamera(option1)
  SeamlessCamera(75, "SCURVE")
  CAM_WAIT(30)
  Fade_Out(1, 30)
  WaitFrame(30)
  EVENT_END()
end

function CUT_01()
  CUT_START()
end

function main()
  t3001_01()
end
