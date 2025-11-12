require("include")

function m420_102()
  local pos_x, pos_y, pos_z = 0, 0, 0
  if not Debug.IsEventView() then
    local pos = Field.ObjectGetPosition(PLAYER, 1)
    pos_x, pos_y, pos_z = pos.x, pos.y, pos.z
  end
  EVENT_BEGIN()
  Talk.Load("m420")
  SetEventCutNo(1)
  if Debug.IsEventView() then
    SetTimeZone("Noon")
    SetTimeAxis("P2028_daft_400")
    SetMapStatus("Disable")
    LoadMap("h0701")
  end
  LoadModel("HERO_01", "Player")
  LoadModel("AEGIOMON_01", "char_AEGIOMON")
  LoadEffectScript("eff_01", "ef_e_com_115")
  WaitVistaLoad()
  if Debug.IsEventView() then
    SetPosition("HERO_01", 0, 0.505, 111.145, "LINEAR", 0, 0)
    SetRotation("HERO_01", 0, 180, 0, "LINEAR", 0, 0)
  else
    SetPosition("HERO_01", pos_x, pos_y, pos_z, "LINEAR", 0, 0)
    SetRotation("HERO_01", 0, 180, 0, "LINEAR", 0, 0)
    Obj:new(NPC, "npc_aigio02"):Invisible(0)
  end
  SetPosition("AEGIOMON_01", 0, 0.505, 105.878, "LINEAR", 0, 0)
  SetRotation("AEGIOMON_01", 0, 0, 0, "LINEAR", 0, 0)
  BlendEye("AEGIOMON_01", 0, 0, "SCURVE", 0, 0)
  BlendFace("AEGIOMON_01", 0, 0, 0, false, "SCURVE", 0, 0)
  SetPosition("eff_01", 0, 1.3, 105.878, "LINEAR", 0, 0)
  SetRotation("eff_01", 0, 0, 0, "LINEAR", 0, 0)
  SetScale("eff_01", 0.2, 0.2, 0.2)
  PlayMotion("HERO_01", "e005_01", 0, true, 0)
  SetFace("HERO_01", "E10_M12", 0, 1, 0, 0)
  PlayMotionBlend("HERO_01", "blend02", 5, false, 10)
  PlayMotion("AEGIOMON_01", "fn01_01", 0, true, 0)
  SetFace("AEGIOMON_01", "F01", 2, 1, FACE_BLENDTIME, 0)
  SetCamera(0.58, 1.328, 103.987, 0, 23, "LINEAR", 0, false, 0)
  SetCameraTarget(0.18, 1.487, 105.875, "LINEAR", 0, false, 0)
  FIELD_SET()
  Field_CancelInvisibleNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleMob(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
  Vista.Play()
  SetMobTransparentRange(0.001, 0.001, 0.001)
  CUT("1.0")
  WaitFrame(85)
  PlayMotion("AEGIOMON_01", "ft02_02", 5, false, 30)
  PlayMotion("AEGIOMON_01", "fn01_01", 10, true, 90)
  SetFace("AEGIOMON_01", "E04_M15", 0, 1, 3, 0)
  BlendEye("AEGIOMON_01", 20, 0, "SCURVE", 20, 0)
  SetRotation("AEGIOMON_01", 0, 175, 0, "LINEAR", 60, 30)
  EndMotion("HERO_01", 50)
  MessageTalkAuto("m420_100_040", -1, true)
  MESSAGE_WAIT2()
  WaitFrame(40)
  Event_PlayBGM(319, 0, 0)
  SetFace("AEGIOMON_01", "E04_M15", 2, 2, 6, 0)
  BlendEye("AEGIOMON_01", 32, 0, "SCURVE", 20, 0)
  BlendFace("AEGIOMON_01", 25, 0, 0, true, "SCURVE", 30, 0)
  WaitFrame(10)
  MessageTalkAuto("m420_100_050", 200, true)
  MESSAGE_WAIT2()
  WaitFrame(40)
  PlayEffect("eff_01", false, 0)
  ModelVisible("AEGIOMON_01", false, 4, 5)
  Event_PlaySE(403006, 100, false, 0, 0)
  WaitFrame(60)
  if Debug.IsEventView() then
    EVENT_END()
    Debug.AllUIOn()
  else
    Vista.SetKeepBGM()
    Vista.SetSkip(false, true)
    Vista.ClearMobTransparentRange()
    TalkExit()
    Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false, false)
    Vista.SeamlessExit(Util.SecondFromFrame(0), "SCURVE")
    Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, false, false)
    Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 0, false, false)
    Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false, false)
    Field_CancelInvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false, false)
    Field_CancelInvisibleMob(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
    local field_player_index = Field.GetPlayerIndex()
    if field_player_index then
      Field.ObjectResetAim(FLD_OBJ_PLAYER, field_player_index, 0)
    end
    while true do
      if Vista.IsExit() then
        Vista.End()
        break
      end
      WaitFrame(1)
    end
    if Debug.IsEventView() then
      Event_StopBGM(0, 0)
      Event_StopAllSE(0, 0)
    end
  end
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m420_102()
end
