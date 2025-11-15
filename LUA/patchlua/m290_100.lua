require("include")

function m290_100()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m290")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie02", "ep02_B")
  WaitVistaLoad()
  Sound.StopAmbientSE(0)
  Event_PlaySE(420014, 100, false, 0, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  Fade_In(1, FADE_TIME)
  Vista.SetMessageTalkAuto("m290_100_010", -1, false, 30)
  Vista.SetMessageTalkAuto("m290_100_011", -1, false, 177)
  Vista.SetMessageTalkAuto("m290_100_020", -1, false, 422)
  Vista.SetMessageTalkAuto("m290_100_021", -1, false, 696)
  Vista.SetMessageTalkAuto("m290_100_030", -1, false, 892)
  Vista.SetMessageTalkAuto("m290_100_031", -1, false, 1119)
  Event_StopBGM(2, 42)
  Movie:PLAY(1312)
  Fade_OutNoLoadingWithWait(1, FADE_TIME)
  WaitFrame(60)
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
  m290_100()
end
