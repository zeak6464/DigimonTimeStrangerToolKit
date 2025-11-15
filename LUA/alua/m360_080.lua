require("include")

function m360_080()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  Talk.Load("m360")
  EventRankSet("S")
  EventRankSet("Shadow")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep08_A")
  WaitVistaLoad()
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(60)
  Fade_In(1, 30)
  Event_PlaySE(420024, 100, false, 0, 0)
  Vista.SetMessageTalkAuto("m360_080_010", -1, false, 10)
  Vista.SetMessageTalkAuto("m360_080_011", -1, false, 263)
  Vista.SetMessageTalkAuto("m360_080_020", -1, false, 445)
  Vista.SetMessageTalkAuto("m360_080_030", -1, false, 717)
  Vista.SetMessageTalkAuto("m360_080_031", -1, false, 868)
  Vista.SetMessageTalkAuto("m360_080_032", -1, false, 1128)
  Vista.SetMessageTalkAuto("m360_080_040", -1, false, 1247)
  Vista.SetMessageTalkAuto("m360_080_050", -1, false, 1526)
  Vista.SetMessageTalkAuto("m360_080_060", -1, false, 1858)
  Vista.SetMessageTalkAuto("m360_080_070", -1, false, 2225)
  Movie:PLAY(2482)
  Fade_OutNoLoadingWithWait(1, FADE_TIME)
  Vista.SetKeepBGM()
  Vista.SetKeepBGMWithMapChange()
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
  m360_080()
end
