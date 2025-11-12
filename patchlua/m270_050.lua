require("include")

function m270_050()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m270")
  SetEventCutNo(1)
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie02", "ep01_B")
  WaitVistaLoad()
  if Debug.IsEventView() then
    Event_PlayBGM(945, 0.3, 0)
  end
  Sound.StopAmbientSE(0)
  Event_PlaySE(420011, 100, false, 0, 0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  Fade_In(1, FADE_TIME)
  Vista.SetMessageTalkAuto("m270_050_010", -1, false, 30)
  Vista.SetMessageTalkAuto("m270_050_011", -1, false, 312)
  Vista.SetMessageTalkAuto("m270_050_012", -1, false, 500)
  Vista.SetMessageTalkAuto("m270_050_020", -1, false, 673)
  Vista.SetMessageTalkAuto("m270_050_021", -1, false, 802)
  Vista.SetMessageTalkAuto("m270_050_030", -1, false, 1092)
  Vista.SetMessageTalkAuto("m270_050_040", -1, false, 1401)
  Vista.SetMessageTalkAuto("m270_050_041", -1, false, 1584)
  Vista.SetMessageTalkAuto("m270_050_050", -1, false, 1878)
  Vista.SetMessageTalkAuto("m270_050_051", -1, false, 2066)
  Vista.SetMessageTalkAuto("m270_050_060", -1, false, 2253)
  Movie:PLAY(2440)
  Event_StopBGM(2, 0)
  Fade_OutNoLoadingWithWait(0, FADE_TIME)
  WaitFrame(75)
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
  m270_050()
end
