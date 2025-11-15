require("include")

function m360_110()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m360")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep06_C")
  WaitVistaLoad()
  Sound.StopAmbientSE(0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlayBGM(944, 0, 0)
  Event_PlaySE(420025, 100, false, 0, 0)
  Fade_In(1, 20)
  Vista.SetMessageTalkAuto("m360_110_010", -1, false, 30)
  Vista.SetMessageTalkAuto("m360_110_020", -1, false, 294)
  Vista.SetMessageTalkAuto("m360_110_021", -1, false, 521)
  Vista.SetMessageTalkAuto("m360_110_030", -1, false, 743)
  Vista.SetMessageTalkAuto("m360_110_031", -1, false, 950)
  Vista.SetMessageTalkAuto("m360_110_040", -1, false, 1199)
  Movie:PLAY(1387)
  Fade_OutNoLoadingWithWait(1, 60)
  Event_StopBGM(2, 0)
  WaitFrame(70)
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
  m360_110()
end
