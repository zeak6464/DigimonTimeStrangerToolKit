require("include")

function r04_010(locator)
  local DigimonId = Field.GetDigimonIDFromPlayerScriptDigimonRideUI(Enum.DigimonRideTypeDecontamination())
  EVENT_BEGIN(SEAMLESS)
  LoadCamera("cam_01", "r04_010_cam")
  Vista.LoadDigimonRideModel("DECON", Enum.DigimonRideTypeDecontamination())
  Vista.LoadAnimation("DECON", "fe01")
  WaitVistaLoad()
  AttachLocate("DECON", locator)
  FIELD_SET()
  EVENT_START()
  PlayCamera("cam_01")
  LocateCamera(locator)
  PlayMotion("DECON", "fe01", 0, false, 0)
  while not Vista.IsEndAnimation("DECON", 0) do
    WaitFrame(1)
  end
  PlayMotion("DECON", "bn01", 10, true, 0)
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 30, false, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_FIELD, 30, false, false)
  EVENT_END_SEAMLESS(30)
end

function CUT(cut_no)
  CUT_START()
end

function main()
  r04_010()
end
