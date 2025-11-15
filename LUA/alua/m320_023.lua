require("include")

function m320_023()
  Fade_Out(0, 0)
  EVENT_BEGIN()
  Talk.Load("m320")
  SetEventCutNo(1)
  if Debug.IsEventView() then
    SetTimeZone("Noon")
    SetTimeAxis("P2028_daft_320")
    SetMapStatus("Enable")
    LoadMap("d0507")
  end
  LoadModel("HERO_01", "Player")
  LoadSceneViewerResource("c1.0", "d0507f_sa")
  LoadEnvironmentFile("c1.0", "es_m320_023_c1.0")
  WaitVistaLoad()
  SetEnv_All("c1.0", 0)
  Event_PlayBGM(313, 0, 0)
  local slot_id = Event_PlaySE(405004, 100, true, 0, 0)
  ModelVisible("HERO_01", false, 0, 0)
  SetPosition("HERO_01", 6, 0, 0.833, "LINEAR", 0, 0)
  SetRotation("HERO_01", 0, -90, 0, "LINEAR", 0, 0)
  BlendEye("HERO_01", 0, 0, "SCURVE", 0, 0)
  BlendFace("HERO_01", 0, 0, 0, false, "SCURVE", 0, 0)
  SetCamera(-15.37, 0.116, 21.237, -10, 30, "LINEAR", 0, false, 0, false)
  SetCameraTarget(0.73, 13.993, 0.589, "LINEAR", 0, false, 0, false)
  SetCamera(-26.833, 16.408, -10.022, -10, 30, "SCURVE", 180, false, 0, false)
  SetCameraTarget(0.73, 13.993, 0.589, "SCURVE", 180, false, 0, false)
  SetCamera(-28.893, 17.894, -14.826, -10, 30, "DECEL", 150, false, 175, false)
  SetCameraTarget(0.73, 13.993, 0.589, "DECEL", 150, false, 175, false)
  FIELD_SET()
  EVENT_START()
  CUT("1.0")
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
  m320_023()
end
