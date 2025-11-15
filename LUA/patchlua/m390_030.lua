require("include")

function m390_030()
  Fade_Out(1, 0)
  Event_StopBGM(0.3, 0)
  WaitFrame(15)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m390")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep03_A")
  WaitVistaLoad()
  Event_StopBGM(1, 0)
  Sound.StopAmbientSE(1)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(40)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlaySE(420026, 100, false, 0, 0)
  Fade_In(1, FADE_TIME)
  Event_PlayBGM(945, 0, 1)
  Vista.SetMessageTalkAuto("m390_030_010", -1, false, 30)
  Vista.SetMessageTalkAuto("m390_030_020", -1, false, 325)
  Vista.SetMessageTalkAuto("m390_030_030", -1, false, 475)
  Movie:PLAY(853)
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
  m390_030()
end
