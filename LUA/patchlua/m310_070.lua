require("include")

function m310_070()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m310")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie02", "ep05_B")
  WaitVistaLoad()
  Sound.StopAmbientSE(0)
  Event_PlaySE(420017, 100, false, 0, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  Fade_In(1, FADE_TIME)
  if Debug.IsEventView() then
    Event_PlayBGM(945, 0, 0)
  end
  Vista.SetMessageTalkAuto("m310_070_010", -1, false, 30)
  Vista.SetMessageTalkAuto("m310_070_011", -1, false, 354)
  Vista.SetMessageTalkAuto("m310_070_020", -1, false, 587)
  Vista.SetMessageTalkAuto("m310_070_030", -1, false, 880)
  Vista.SetMessageTalkAuto("m310_070_040", -1, false, 1086)
  Event_StopBGM(2, 44)
  Movie:PLAY(1387)
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
  m310_070()
end
