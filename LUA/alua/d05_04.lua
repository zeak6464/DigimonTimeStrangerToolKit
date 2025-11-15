require("include")

function d05_04(locator)
  EVENT_BEGIN()
  if Debug.IsEventView() then
    LoadMap("d0502")
    LoadLocater("d0502p")
    LoadObject("d05craneswitch00_01", "d05craneswitch00")
  end
  LoadModel("chr609_01", "chr609")
  Vista.LoadAnimation("chr609_01", "f000")
  LoadEffectScript("eff_01", "ef_f_mov_500_el")
  Vista.LoadCameraAnimationID("cam_01", "d05_04_cam")
  WaitVistaLoad()
  ResetEnvironmentSettings()
  FIELD_SET()
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 30, false, false)
  EVENT_START()
  CUT(1)
  if Debug.IsEventView() then
    AttachLocate("chr609_01", "gim_0001")
    AttachLocate("d05craneswitch00_01", "gim_0001")
    AttachLocate("eff_01", "gim_0001")
    PlayMotion("chr609_01", "f000", 0, true, 0)
    PlayCamera("cam_01")
    LocateCamera("gim_0001")
  else
    AttachLocate("chr609_01", locator)
    AttachLocate("eff_01", locator)
    PlayMotion("chr609_01", "f000", 0, true, 0)
    PlayCamera("cam_01")
    LocateCamera(locator)
  end
  PlayEffect("eff_01", false, 0)
  CameraMove(0, 45)
  WaitFrame(30)
  Event_Quake_Start(0.5, 0, 30, 0)
  PlaySE(300210, 100)
  WaitFrame(15)
  CameraMove(46, 90)
  WaitFrame(15)
  Motion.Gimmick:Play(locator, "e001", false)
  PlaySE(200014, 100)
  CAM_WAIT(0)
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 30, false, false)
  EVENT_END_SEAMLESS(30)
end

function CUT(cut_no)
  CUT_START()
end

function main()
  d05_04()
end
