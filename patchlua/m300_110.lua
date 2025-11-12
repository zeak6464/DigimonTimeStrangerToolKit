require("include")

function m300_110()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  Talk.Load("m300")
  EventRankSet("S")
  EventRankSet("Shadow")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep02_C")
  WaitVistaLoad()
  Sound.StopAmbientSE(0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlaySE(420015, 100, false, 0, 0)
  Fade_In(1, 60)
  Event_PlayBGM(945, 2, 1)
  Vista.SetMessageTalkAuto("m300_110_010", -1, false, 90)
  Vista.SetMessageTalkAuto("m300_110_020", -1, false, 434)
  Vista.SetMessageTalkAuto("m300_110_040", -1, false, 655)
  Vista.SetMessageTalkAuto("m300_110_050", -1, false, 907)
  Event_StopBGM(2, 37)
  Movie:PLAY(1182)
  Fade_OutNoLoadingWithWait(1, 60)
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
  m300_110()
end
