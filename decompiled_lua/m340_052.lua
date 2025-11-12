require("include")

function m340_052()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  Talk.Load("m340")
  EventRankSet("S")
  EventRankSet("Shadow")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep04_A")
  WaitVistaLoad()
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlaySE(420019, 100, false, 0, 0)
  Fade_In(1, FADE_TIME)
  Event_PlayBGM(945, 2, 0)
  Vista.SetMessageTalkAuto("m350_070_010", -1, false, 30)
  Vista.SetMessageTalkAuto("m350_070_011", -1, false, 243)
  Vista.SetMessageTalkAuto("m350_070_012", -1, false, 479)
  Vista.SetMessageTalkAuto("m350_070_020", -1, false, 696)
  Vista.SetMessageTalkAuto("m350_070_021", -1, false, 914)
  Vista.SetMessageTalkAuto("m350_070_030", -1, false, 1232)
  Vista.SetMessageTalkAuto("m350_070_031", -1, false, 1399)
  Vista.SetMessageTalkAuto("m350_070_032", -1, false, 1714)
  Movie:PLAY(1908)
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
  m340_052()
end
