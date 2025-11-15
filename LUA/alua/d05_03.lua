require("include")

function d05_03(locator)
  EVENT_BEGIN()
  if Debug.IsEventView() then
    Vista.LoadBackGround("d0502")
    Vista.LoadLocater("d0502p")
    Vista.LoadModelID("HERO_01", "Player")
    Vista.LoadAnimation("HERO_01", "ev006_1")
  end
  Talk.Load("d05")
  Vista.LoadCameraAnimationID("cam_01", "Cam_ev006_1")
  LoadModel("chr183aa010101_01", "char_AEGIOMON")
  Vista.LoadAnimation("chr183aa010101_01", "ev006_1")
  Field.PlayerLoadAnimation("ev006_1")
  Field.PlayerLoadAnimation("fn01_01")
  Vista.LoadAnimationFace("chr183aa010101_01", "e03", "m02")
  while Field.IsLoadingPlayerAnimation("") do
    WaitFrame(Util.SecondFromFrame(1))
  end
  WaitVistaLoad()
  Vista.PlayAnimationFace("chr183aa010101_01", "e03", "m02", 0, 0)
  FIELD_SET()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_FIELD, 0, false, false)
  EVENT_START()
  CUT_01()
  Fade.In(0, 0.5)
  if Debug.IsEventView() then
    Vista.AttachLocate("HERO_01", "duct_0001")
    Vista.PlayAnimation("HERO_01", "ev006_1", 0, false, 0)
    Vista.AttachLocate("chr183aa010101_01", "duct_0001")
    Vista.PlayAnimation("chr183aa010101_01", "ev006_1", 0, false, 0)
    Vista.PlayCameraAnimation("cam_01")
    Vista.LocateCamera("duct_0001")
  else
    SetPlayerLocator(locator)
    Motion.Player:Play("ev006_1", 0, false)
    Vista.AttachLocate("chr183aa010101_01", locator)
    Vista.PlayAnimation("chr183aa010101_01", "ev006_1", 0, false, 0)
    Vista.PlayCameraAnimation("cam_01")
    Vista.LocateCamera(locator)
  end
  WaitFrame(5)
  Event_PlaySE(400003, 100, false, 0, 0)
  Vista.SetMouth("chr183aa010101_01", 0, 6, 0)
  ModelVisible("chr183aa010101_01", false, 0, 60)
  Talk.Message("f_d0502_0070_0010")
  WaitFrame(30)
  Event_PlaySE(400015, 100, false, 0, 0.2)
  Vista.SetMouth("chr183aa010101_01", 1, 6, 0)
  MessageClose()
  CAM_WAIT(0)
  EVENT_END_SEAMLESS(30)
end

function CUT_01()
  CUT_START()
end

function main()
  d05_03()
end
