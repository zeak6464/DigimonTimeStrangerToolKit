require("include")

function m991_010()
  EVENT_BEGIN()
  EventRankSet("S")
  if Debug.IsEventView() then
  end
  local Movie_pv = MOVIE.new("MainMovie", "trial_pv")
  WaitVistaLoad()
  Event_Stop_Play_BGM(991, 0, 0, 0, 0)
  Sound.StopAmbientSE(0)
  SetCamera(0, 0, 0, 0, 40, "LINEAR", 0, false, 0)
  SetCameraTarget(0, 0, 0, "LINEAR", 0, false, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  Fade_In(0, FADE_TIME)
  Vista.SetSkip(true)
  Movie_pv:PLAY(1950)
  Event_StopBGM(0, 0)
  Fade_OutNoLoading(0, 0)
  if type == 0 then
    Vista.SetSkip(false, false)
  else
    Vista.SetSkip(false, true)
  end
  TalkExit()
  VistaExit()
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m991_010()
end
