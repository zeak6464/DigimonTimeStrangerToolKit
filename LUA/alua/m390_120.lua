require("include")

function m390_120()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m390")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep03_C")
  WaitVistaLoad()
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlayBGM(944, 0, 0)
  Event_PlaySE(420028, 100, false, 0, 0)
  Fade_In(1, FADE_TIME)
  Vista.SetMessageTalkAuto("m390_120_010", -1, false, 60)
  Vista.SetMessageTalkAuto("m390_120_020", -1, false, 228)
  Vista.SetMessageTalkAuto("m390_120_030", -1, false, 501)
  Vista.SetMessageTalkAuto("m390_120_040", -1, false, 784)
  Vista.SetMessageTalkAuto("m390_120_050", -1, false, 1017)
  Movie:PLAY(1227)
  Fade_OutNoLoadingWithWait(1, FADE_TIME)
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
  m390_120()
end
