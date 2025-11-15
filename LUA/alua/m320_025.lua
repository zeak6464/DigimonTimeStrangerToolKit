require("include")

function m320_025()
  Fade_Out(0, 0)
  EVENT_BEGIN()
  Talk.Load("m320")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
    SetTimeZone("Noon")
    SetTimeAxis("P2028_daft_320")
    SetMapStatus("Enable")
    LoadMap("d0507")
  end
  LoadModel("HERO_01", "Player")
  LoadSceneViewerResource("c1.0", "d0507f_sa")
  LoadEnvironmentFile("c1.0", "es_m320_025_c1.0")
  WaitVistaLoad()
  Event_PlayBGM(313, 0, 0)
  local slot_id = Event_PlaySE(405004, 100, true, 0, 0)
  ModelVisible("HERO_01", false, 0, 0)
  SetPosition("HERO_01", 6, 0, 0.833, "LINEAR", 0, 0)
  SetRotation("HERO_01", 0, -90, 0, "LINEAR", 0, 0)
  BlendEye("HERO_01", 0, 0, "SCURVE", 0, 0)
  BlendFace("HERO_01", 0, 0, 0, false, "SCURVE", 0, 0)
  SetCamera(-26.372, 5.379, 12.148, 0, 30, "LINEAR", 0, false, 0)
  SetCameraTarget(-5.67, 11.569, -1.862, "LINEAR", 0, false, 0)
  SetCamera(33.222, 11.512, 11.799, 10, 25, "SCURVE", 160, false, 0)
  SetCameraTarget(-0.111, 12.131, 0.057, "SCURVE", 160, false, 0)
  CameraOffsetTurn(20, "DECEL", false, true, 400, 155)
  FIELD_SET()
  EVENT_START()
  CUT("1.0")
  SetEnv_All("c1.0", 0)
  Fade_In(FADE_BLACK, FADE_TIME)
  WaitFrame(30)
  MessageTalk("m320_020_010")
  MessageClose()
  WaitFrame(10)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  if Debug.IsEventView() then
    Event_StopBGM(1, 0)
    Event_StopAllSE(0.2, 0)
  end
  EVENT_END()
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m320_025()
end
