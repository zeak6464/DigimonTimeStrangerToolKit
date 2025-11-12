require("include")

function m270_040()
  Fade_Out(1, 0)
  EVENT_BEGIN()
  EventRankSet("S")
  EventRankSet("Shadow")
  Talk.Load("m270")
  SetEventCutNo(1)
  if Debug.IsEventView() then
  end
  local Movie = MOVIE.new("movie", "ep01_A")
  WaitVistaLoad()
  Event_StopBGM(0, 0)
  Sound.StopAmbientSE(0)
  FIELD_SET()
  Vista.Play()
  CUT("1.0")
  WaitFrame(15)
  local slot_01 = Event_PlaySE(404031, 100, false, 0.3, 0)
  WaitFrame(60)
  Event_PlaySE(420010, 100, false, 0, 0)
  Fade_In(1, FADE_TIME)
  Event_PlayBGM(319, 2, 1)
  Vista.SetMessageTalkAuto("m270_040_010", -1, false, 45)
  Vista.SetMessageTalkAuto("m270_040_011", -1, false, 325)
  Vista.SetMessageTalkAuto("m270_040_012", -1, false, 561)
  Vista.SetMessageTalkAuto("m270_040_020", -1, false, 720)
  Vista.SetMessageTalkAuto("m270_040_030", -1, false, 1063)
  Vista.SetMessageTalkAuto("m270_040_040", -1, false, 1327)
  Movie:PLAY(1475)
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
  m270_040()
end
