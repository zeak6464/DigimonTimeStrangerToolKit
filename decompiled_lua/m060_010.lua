require("include")

function m060_010()
  Fade_Out(0, 0)
  EVENT_BEGIN()
  Talk.Load("m060")
  SetEventCutNo(1)
  if Debug.IsEventView() then
    GetTimeZone()
    SetTimeZone("Noon")
    SetTimeAxis("A2020_dbef_60")
    LoadMap("t0404")
  end
  LoadModel("HERO_01", "Player")
  LoadSceneViewerResource("c1.0", "t0404f_pa")
  LoadEnvironmentFile("c1.0", "es_m060_010_c1.0")
  WaitVistaLoad()
  SetPosition("HERO_01", -1.838, 0, 0.221, "LINEAR", 0, 0)
  SetRotation("HERO_01", 0, 70.5, 0, "LINEAR", 0, 0)
  SetScale("HERO_01", 1, 1, 1)
  PlayMotion("HERO_01", "e051", 0, false, 0)
  SetFace("HERO_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  SetBlink("HERO_01", 0, 1, 0)
  SetMouth("HERO_01", 1, 0, 0)
  BlendEye("HERO_01", 0, 0, "SCURVE", 0, 0)
  BlendFace("HERO_01", 0, 0, 0, false, "SCURVE", 0, 0)
  SetCamera(-1.866, 1.178, 0.349, 0, 40, "LINEAR", 0, false, 0)
  SetCameraTarget(-2.574, 1.047, -0.302, "LINEAR", 0, false, 0)
  FIELD_SET()
  EVENT_START()
  CUT("1.0")
  SetEnv_All("c1.0", 0)
  BackFadeInWithWaitNotFlgCheck(FADE_BLACK, 0)
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  SetCamera(-1.516, 1.698, 0.831, 0, 40, "SCURVE", 45, false, 0)
  SetCameraTarget(-2.2, 1.318, -0.531, "SCURVE", 45, false, 0)
  WaitFrame(100)
  SetCameraCircle(-1.669, -0.105, "SCURVE", 60, 0)
  SetCamera(-3.078, 1.602, 0.469, 0, 40, "SCURVE", 60, false, 0)
  SetCameraTarget(-1.553, 1.44, 0.618, "SCURVE", 60, false, 0)
  WaitFrame(70)
  if Debug.IsEventView() then
    EVENT_END()
  else
    EVENT_END_SEAMLESS(60)
  end
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m060_010()
end
