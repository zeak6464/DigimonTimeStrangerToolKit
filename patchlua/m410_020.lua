require("include")

function m410_020()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m410")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep07_A")
  WaitVistaLoad()
  Sound.StopAmbientSE(0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlayBGM(945, 0.2, 3.2)
  Event_PlaySE(420029, 100, false, 0, 0)
  Fade_In(1, FADE_TIME)
  Vista.SetMessageTalkAuto("m410_020_010", -1, false, 15)
  Vista.SetMessageTalkAuto("m410_020_020", -1, false, 113)
  Vista.SetMessageTalkAuto("m410_020_030", -1, false, 447)
  Vista.SetMessageTalkAuto("m410_020_040", -1, false, 784)
  Vista.SetMessageTalkAuto("m410_020_050", -1, false, 926)
  Vista.SetMessageTalkAuto("m410_020_060", -1, false, 1211)
  Vista.SetMessageTalkAuto("m410_020_070", -1, false, 1461)
  Vista.SetMessageTalkAuto("m410_020_080", -1, false, 1571)
  Event_StopBGM(5, 58)
  Movie:PLAY(1870)
  Fade_OutNoLoadingWithWait(1, FADE_TIME)
  Vista.SetKeepBGM()
  Vista.SetSkip(false, true)
  Event_Quake_Stop(0)
  TalkExit()
  VistaExit()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleMob(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
  local field_player_index = Field.GetPlayerIndex()
  if field_player_index then
    Field.ObjectResetAim(FLD_OBJ_PLAYER, field_player_index, 0)
  end
  if Debug.IsEventView() then
    Event_StopBGM(0, 0)
    Event_StopAllSE(0, 0)
  end
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m410_020()
end
