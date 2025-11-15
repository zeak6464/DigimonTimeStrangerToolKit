require("include")

function m390_040()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m390")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie02", "ep03_B")
  WaitVistaLoad()
  if Debug.IsEventView() then
    Event_PlayBGM(945, 0.2, 5)
  end
  Event_PlaySE(420025, 100, false, 0, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  Fade_In(1, FADE_TIME)
  Vista.SetMessageTalkAuto("m390_040_010", -1, false, 30)
  Vista.SetMessageTalkAuto("m390_040_020", -1, false, 366)
  Vista.SetMessageTalkAuto("m390_040_030", -1, false, 674)
  Vista.SetMessageTalkAuto("m390_040_040", -1, false, 992)
  Vista.SetMessageTalkAuto("m390_040_050", -1, false, 1278)
  Vista.SetMessageTalkAuto("m390_040_060", -1, false, 1677)
  Event_StopBGM(4, 56)
  Movie:PLAY(1820)
  Event_PlayBGM(114, 2, 0.5)
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
  m390_040()
end
