gGimText = "field_text"

function Prcs_t0401_EnterCvs()
  SetControlScriptExternalVariable("player_state", "go_shop")
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  GimmickZoom_In()
  while GetControlScriptExternalVariableString("player_state") ~= "map_change_shop" do
    WaitFrame(1)
  end
  FadeOutWithWait(0, 15)
  CreateAddress()
  Work.SetString(Field_Shop_Temp_Locator, "start_09")
  MapChange("t", 1, "start_00", false, -1, -1)
end

function Prcs_t0401_TownAccessOff()
  if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
  else
    SetEnableGimmickCheck("gim_0004", false)
    SetEnableGimmickCheck("gim_0005", false)
    SetEnableGimmickCheck("gim_0006", false)
    SetEnableGimmickCheck("gim_0007", false)
    SetEnableGimmickCheck("gim_0008", false)
  end
end

function Prcs_t0401_TownAccessOn()
  if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
  else
    SetEnableGimmickCheck("gim_0004", true)
    SetEnableGimmickCheck("gim_0005", true)
    SetEnableGimmickCheck("gim_0006", true)
    SetEnableGimmickCheck("gim_0007", true)
    SetEnableGimmickCheck("gim_0008", true)
  end
end

function Prcs_t0401_StairsZoom(is_zoom, flame)
  if is_zoom == true then
    Field.CameraZoomFrame(1, -1.8, flame, 0)
  else
    Field.CameraZoomUndo()
  end
end

function Prcs_t0402_QuestBoard()
  local def_text = "t04"
  EVENT_BEGIN()
  EVENT_START()
  SetCamera(-2.156, 1.241, -1.572, 0, 40, "LINEAR", 0, false, 0)
  SetCameraTarget(-2.14, 1.218, -4.416, "LINEAR", 0, false, 0)
  SetCamera(-2.155, 1.24, -1.736, 0, 40, "SCURVE", 30, false, 0)
  SetCameraTarget(-2.14, 1.218, -4.416, "SCURVE", 30, false, 0)
  Obj:new(PLAYER, ""):Invisible(15, true)
  Field_Talk_Start(def_text, 1)
  Talk.Message(40200010)
  WaitFrame(5)
  while true do
    result = Talk.GetResultSelectedNum()
    MessageTalkSel(5, 40200010)
    MessageClose()
    if result == RESULT_TALK00 then
      Qst.Sub:Start(1203, 0, false)
      if Quest.IsReceive() then
        Fade_Out(0, 30)
        WaitFrame(30)
        Execute("m99_110")
      end
    elseif result == RESULT_TALK01 then
      Qst.Sub:Start(1201, 0, false)
      if Quest.IsReceive() then
        Fade_Out(0, 30)
        WaitFrame(30)
        Execute("m99_130")
      end
    elseif result == RESULT_TALK02 then
      Qst.Sub:Start(1202, 0, false)
      if Quest.IsReceive() then
        Fade_Out(0, 30)
        WaitFrame(30)
        Execute("m99_200")
      end
    elseif result == RESULT_TALK03 then
      Qst.Sub:Start(1204, 0, false)
      if Quest.IsReceive() then
        Field_Talk_Start(def_text, 1)
        Message(40201000)
        Field_Talk_End()
      end
    else
      Field_Talk_End()
      break
    end
    if Quest.IsReceive() then
      break
    end
    WaitFrame(10)
  end
  Field_Talk_End()
  Obj:new(PLAYER, ""):CancelInvisible(15)
  EVENT_END()
  print("=================")
  print("QuestBoard_End")
  print("=================")
end

function Prcs_t0404_Bed()
  if Qst.Main:Check(M050.ID, M050.STEP_030, M050.STEP_255) then
    if not Flg.Check("FLAG_MAIN_03_036") then
      local def_text = "field_text"
      local tlk = Tlk:new("field_text", 1, false)
      tlk:StartTalk()
      tlk:Message("g_bed_0010_0010")
      tlk:MessageClose()
      local result = tlk:Select(2, "g_bed_0010_0020")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        FadeOutWithWait(0, 30)
        PlayerObjectResetAim()
        SetPlayerLocator("start_01")
        Digimon.RestoreAllParty()
        PlaySE(200007, 100)
        INFO_WINDOW(5051)
        FadeInWithWait(0, 30)
      elseif result == RESULT_TALK01 then
        tlk:EndTalk()
      end
    elseif Flg.Check("FLAG_MAIN_03_036", "FLAG_MAIN_03_037") then
      local tlk = Tlk:new("field_text", 1, true)
      tlk:StartTalk()
      tlk:Message("g_bed_0010_0030")
      tlk:MessageClose()
      local result = tlk:Select(2, "g_bed_0010_0040")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        M050:Event_120()
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        PlayerObjectResetAim()
        SetPlayerLocator("start_01")
        Digimon.RestoreAllParty()
        MapChangeWithTimeTravel("t", 404, "start_01", AXIS_ORIGINAL, "A2020_dbef_60", MORNING)
      elseif result == RESULT_TALK01 then
        tlk:EndTalk()
      end
    end
  elseif Flg.Check("FLAG_MAIN_03_390", "FLAG_MAIN_03_395") then
    local tlk = Tlk:new("field_text", 1, true)
    tlk:StartTalk()
    if not Flg.Check("FLAG_IS_CLEAR_SUB_001") then
      OpenInfoWindow(20010)
    end
    local result = tlk:Select(2, "g_confirmation_1000_0020")
    if result == RESULT_TALK01 then
      tlk:EndTalk()
      PlayerObjectResetAim()
      Digimon.RestoreAllParty()
      M110:Event_015()
    elseif result == RESULT_TALK00 then
      tlk:EndTalk()
      if not Flg.Check("FLAG_IS_CLEAR_SUB_001") then
        Digitter.Send(2500040)
      end
    end
  else
    local def_text = "field_text"
    local tlk = Tlk:new("field_text", 1, false)
    tlk:StartTalk()
    tlk:Message("g_bed_0010_0010")
    tlk:MessageClose()
    local result = tlk:Select(2, "g_bed_0010_0020")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      FadeOutWithWait(0, 30)
      PlayerObjectResetAim()
      SetPlayerLocator("start_01")
      Digimon.RestoreAllParty()
      PlaySE(200007, 100)
      INFO_WINDOW(5051)
      FadeInWithWait(0, 30)
    elseif result == RESULT_TALK01 then
      tlk:EndTalk()
    end
  end
end

function Prcs_t0404_HangerRack()
  if Flg.Check("FLAG_MAIN_03_120", "FLAG_MAIN_03_123") then
    Flg.Set("FLAG_MAIN_03_123")
    INFO_GET_ITEM(803, 1)
  else
    local def_text = "field_text"
    Field_Talk_Start(def_text, 1)
    Message("g_closet_0010_0010")
    Field_Talk_End()
  end
end

function Prcs_t0403_LivingAccessOff()
  SetEnableGimmickCheck("gim_0001", false)
  SetEnableGimmickCheck("gim_0004", false)
  SetEnableGimmickCheck("gim_0005", false)
  SetEnableGimmickCheck("gim_0006", false)
  SetEnableGimmickCheck("gim_0007", false)
  SetEnableGimmickCheck("gim_0008", false)
  SetEnableGimmickCheck("gim_0009", false)
  SetEnableGimmickCheck("gim_0011", false)
  SetEnableGimmickCheck("gim_0012", false)
  Flg.Clear("FLAG_T0403_ACCESS_ON")
end

function Prcs_t0403_LivingAccessOn()
  SetEnableGimmickCheck("gim_0001", true)
  SetEnableGimmickCheck("gim_0004", true)
  SetEnableGimmickCheck("gim_0005", true)
  SetEnableGimmickCheck("gim_0006", true)
  SetEnableGimmickCheck("gim_0007", true)
  SetEnableGimmickCheck("gim_0008", true)
  SetEnableGimmickCheck("gim_0009", true)
  SetEnableGimmickCheck("gim_0010", true)
  SetEnableGimmickCheck("gim_0011", true)
  SetEnableGimmickCheck("gim_0012", true)
  Flg.Set("FLAG_T0403_ACCESS_ON")
end

function M050_Event_118B()
  M050:Event_118B()
end

function Prcs_t04_FAkuga(enemy_name)
  if enemy_name == "s202_kuramon13" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_113")
    require("Sow_202")
    SeekDrKuga_T0401()
  end
end

function Prcs_t04_HirokoQuest()
  require("S110_103")
  require("S010_156")
  require("S910_169")
  require("S910_170")
  require("S910_171")
  local rk_qst_id = 0
  local w_qst_id = 0
  rk_qst_id = rk_qst_id + (Qst.Sub:Check(S110_103.ID, S110_103.STEP_001) and 100 or 0)
  rk_qst_id = Qst.Sub:IsCompleted(S110_103.ID) and 0 or rk_qst_id
  rk_qst_id = rk_qst_id + (Qst.Sub:Check(S010_156.ID, S010_156.STEP_001) and 200 or 0)
  rk_qst_id = Qst.Sub:IsCompleted(S010_156.ID) and 0 or rk_qst_id
  w_qst_id = w_qst_id + (Qst.Sub:Check(S910_169.ID, S910_169.STEP_001) and 10 or 0)
  w_qst_id = w_qst_id + (Qst.Sub:IsCompleted(S910_169.ID) and 10 or 0)
  w_qst_id = w_qst_id + (Qst.Sub:IsCompleted(S910_170.ID) and 10 or 0)
  w_qst_id = Qst.Sub:IsCompleted(S910_169.ID) and Qst.Sub:IsCompleted(S910_170.ID) and Qst.Sub:IsCompleted(S910_171.ID) and 0 or w_qst_id
  local text_id = string.format("%04d", rk_qst_id + w_qst_id)
  local sel_num = 0 < rk_qst_id and 0 < w_qst_id and 3 or 2
  return text_id, sel_num, rk_qst_id, w_qst_id
end
