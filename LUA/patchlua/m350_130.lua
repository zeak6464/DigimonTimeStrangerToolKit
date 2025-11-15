require("include")

function m350_130()
  Fade_Out(0, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m350")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep04_C")
  WaitVistaLoad()
  Sound.StopAmbientSE(0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlaySE(420021, 100, false, 0, 0)
  Fade_In(1, 10)
  Event_PlayBGM(945, 2, 0)
  Vista.SetMessageTalkAuto("m350_130_010", -1, false, 10)
  Vista.SetMessageTalkAuto("m350_130_012", -1, false, 240)
  Vista.SetMessageTalkAuto("m350_130_020", -1, false, 524)
  Vista.SetMessageTalkAuto("m350_130_030", -1, false, 648)
  Vista.SetMessageTalkAuto("m350_130_040", -1, false, 869)
  Vista.SetMessageTalkAuto("m350_130_041", -1, false, 1042)
  Event_StopBGM(4, 39)
  Movie:PLAY(1241)
  Fade_OutNoLoadingWithWait(1, 10)
  WaitFrame(40)
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
  m350_130()
end
