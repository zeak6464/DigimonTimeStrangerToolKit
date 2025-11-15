require("include")

function m340_053()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  Talk.Load("m340")
  EventRankSet("S")
  EventRankSet("Shadow")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie02", "ep04_B")
  WaitVistaLoad()
  Event_PlaySE(420020, 100, false, 0, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  Fade_In(1, 10)
  Vista.SetMessageTalkAuto("m350_080_010", -1, false, 10)
  Vista.SetMessageTalkAuto("m350_080_011", -1, false, 219)
  Vista.SetMessageTalkAuto("m350_080_012", -1, false, 476)
  Vista.SetMessageTalkAuto("m350_080_020", -1, false, 751)
  Vista.SetMessageTalkAuto("m350_080_021", -1, false, 997)
  Vista.SetMessageTalkAuto("m350_080_030", -1, false, 1166)
  Vista.SetMessageTalkAuto("m350_080_031", -1, false, 1478)
  Event_StopBGM(2, 53)
  Movie:PLAY(1663)
  Fade_OutNoLoadingWithWait(1, 7)
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
  m340_053()
end
