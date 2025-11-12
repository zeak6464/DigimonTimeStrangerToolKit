require("include")

function d05_02(locator)
  EVENT_BEGIN()
  Vista.LoadCameraAnimationID("cam_01", "d05_02_cam")
  Field.PlayerLoadAnimation("fg04_out01", "*Aegiomon")
  Field.PlayerLoadAnimation("fn01_01")
  while Field.IsLoadingPlayerAnimation("") do
    WaitFrame(Util.SecondFromFrame(1))
  end
  WaitVistaLoad()
  FIELD_SET()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_FIELD, 0, false, false)
  EVENT_START()
  CUT_01()
  Fade.In(0, 0.5)
  SetPlayerLocator(locator)
  Field.ObjectPlayMotion(FLD_OBJ_PLAYER, Field.GetPlayerIndex(), "fg04_out01", 0, false)
  Vista.PlayCameraAnimation("cam_01")
  Vista.LocateCamera(locator)
  WaitFrame(38)
  Motion.Player:Play("fn01_01", 3, true)
  WaitFrame(2)
  CAM_WAIT(0)
  EVENT_END_SEAMLESS(30)
end

function CUT_01()
  CUT_START()
end

function main()
  d05_02()
end
