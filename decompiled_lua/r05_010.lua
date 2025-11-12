require("include")

function r05_010(locator)
  EVENT_BEGIN()
  if Debug.IsEventView() then
    LoadMap("d0202")
    LoadLocater("d0202p")
  end
  LoadModel("HERO_01", "Player")
  LoadModel("chr142_01", "chr142")
  Vista.LoadAnimation("HERO_01", "r142_in01")
  Vista.LoadAnimation("chr142_01", "r142_in01")
  Vista.LoadCameraAnimationID("cam_01", "Cam_r142_in01")
  WaitVistaLoad()
  FIELD_SET()
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 30, false, false)
  EVENT_START()
  CUT(1)
  if Debug.IsEventView() then
    AttachLocate("HERO_01", "ride_zip_0011")
    AttachLocate("chr142_01", "ride_zip_0011")
    PlayMotion("HERO_01", "r142_in01", 0, false, 0)
    PlayMotion("chr142_01", "r142_in01", 0, false, 0)
    PlayCamera("cam_01")
    LocateCamera("ride_zip_0011")
    WaitFrame(45)
  else
    AttachLocate("HERO_01", locator)
    AttachLocate("chr142_01", locator)
    PlayMotion("HERO_01", "r142_in01", 0, false, 0)
    PlayMotion("chr142_01", "r142_in01", 0, false, 0)
    PlayCamera("cam_01")
    LocateCamera(locator)
  end
  CAM_WAIT(0)
  FadeOutWithWait(0, 5)
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 30, false, false)
  EVENT_END()
end

function CUT(cut_no)
  CUT_START()
end

function main()
  r05_010()
end
