require("include")

function m020_190()
  Fade_Out(0, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  Talk.Load("m020")
  if Debug.IsEventView() then
    LoadMap("d1407")
  end
  local Movie_m = MOVIE.new("movie_m", "m020_190_m")
  local Movie_f = MOVIE.new("movie_f", "m020_190_f")
  WaitVistaLoad()
  SetCamera(-733.722, 232.497, -101.135, 0, 40, "LINEAR", 0, false, 0)
  SetCameraTarget(-11.587, -14.308, 8.504, "LINEAR", 0, false, 0)
  Event_Stop_Play_BGM(206, 0, 0, 0, 0.3)
  Event_PlaySE(420001, 100, false, 0, 0)
  FIELD_SET()
  EVENT_START()
  CUT(1)
  Fade_In(0, 0)
  CtrVibration(0, 0.7, 20, 26)
  CtrVibration(0, 0, 0, 46)
  CtrVibration(0, 0.7, 10, 81)
  CtrVibration(0, 0, 0, 91)
  CtrVibration(0, 0.7, 63, 134)
  CtrVibration(0, 0, 0, 197)
  CtrVibration(0.7, 0, 5, 163)
  CtrVibration(0, 0, 0, 139)
  CtrVibration(0, 0.5, 214, 202)
  CtrVibration(0, 0, 0, 416)
  CtrVibration(0, 0.5, 121, 420)
  CtrVibration(0, 0, 0, 541)
  CtrVibration(0.7, 0, 5, 760)
  CtrVibration(0, 0, 0, 765)
  CtrVibration(0.1, 0.5, 124, 781)
  CtrVibration(1, 0.5, 83, 905)
  CtrVibration(0, 0, 0, 988)
  CtrVibration(0, 0.7, 83, 999)
  CtrVibration(0, 0, 0, 1012)
  if Common.GetPlayerAvatarType() == PLAYER_AVATAR_TYPE_HERO then
    BackFade_In(1, 0)
    Movie_m:PLAY(1012)
  elseif Common.GetPlayerAvatarType() == PLAYER_AVATAR_TYPE_HEROINE then
    BackFade_In(1, 0)
    Movie_f:PLAY(1012)
  else
    BackFade_In(1, 0)
    Movie_f:PLAY(1012)
  end
  Fade_OutNoLoading(1, 37)
  WaitFrame(37)
  Event_StopBGM(5)
  Sound.StopAmbientSE(5)
  WaitFrame(150)
  if Debug.IsEventView() then
  end
  Vista.SetKeepBGM()
  EVENT_END()
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m020_190()
end
