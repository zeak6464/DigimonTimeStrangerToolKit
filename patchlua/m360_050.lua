require("include")

function m360_050()
  Fade_Out(0, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m360")
  SetEventCutNo("1.0")
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie02", "ep06_B")
  WaitVistaLoad()
  if Debug.IsEventView() then
    Event_PlayBGM(944, 0, 0)
  end
  Sound.StopAmbientSE(0)
  Event_PlaySE(420023, 100, false, 0, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  Fade_In(0, FADE_TIME)
  Vista.SetMessageTalkAuto("m360_050_010", -1, false, 45)
  Vista.SetMessageTalkAuto("m360_050_011", -1, false, 270)
  Vista.SetMessageTalkAuto("m360_050_020", -1, false, 511)
  Vista.SetMessageTalkAuto("m360_050_021", -1, false, 645)
  Vista.SetMessageTalkAuto("m360_050_022", -1, false, 805)
  Movie:PLAY(1022)
  Fade_OutNoLoadingWithWait(1, FADE_TIME)
  Event_StopBGM(2, 0)
  WaitFrame(70)
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
  m360_050()
end
