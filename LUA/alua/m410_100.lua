require("include")

function m410_100()
  Fade_Out(0, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m410")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep07_B")
  WaitVistaLoad()
  Event_StopBGM(0.3, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlayBGM(945, 0.2, 0)
  Event_PlaySE(420030, 100, false, 0, 0)
  Fade_In(0, 10)
  Vista.SetMessageTalkAuto("m410_100_010", -1, false, 10)
  Vista.SetMessageTalkAuto("m410_100_030", -1, false, 283)
  Vista.SetMessageTalkAuto("m410_100_040", -1, false, 574)
  Vista.SetMessageTalkAuto("m410_100_041", -1, false, 894)
  Vista.SetMessageTalkAuto("m410_100_050", -1, false, 1113)
  Vista.SetMessageTalkAuto("m410_100_060", -1, false, 1151)
  Vista.SetMessageTalkAuto("m410_100_070", -1, false, 1385)
  Vista.SetMessageTalkAuto("m410_100_100", -1, false, 1597)
  Event_StopBGM(4, 55)
  Movie:PLAY(1763)
  Fade_OutNoLoadingWithWait(1, FADE_TIME)
  WaitFrame(60)
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
  m410_100()
end
