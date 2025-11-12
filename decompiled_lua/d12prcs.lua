gGimText = "field_text"

function Prcs_d1201_CheckSwitchBoard()
  Motion.Player:Play("fg07_u01", 0, false)
  WaitFrame(45)
  SetEnableGimmickCheck("gim_0001", false)
  SetEnableGimmickCheck("fa_0007", true)
end

function Prcs_d1201_TurnOnSwitchBoard()
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  WaitFrame(10)
  local index = GetIndex(FLD_OBJ_LOCATOR, "fa_0007")
  AttachAndStartEffectScript(FLD_OBJ_LOCATOR, index, "ef_b_com_610_paralysis", false, 1, false, false, false, false)
  WaitFrame(45)
  Motion.Gimmick:Play("fa_0007", "e001", true)
  Quake_Start(0.02, 0, 30)
  WaitFrame(30)
  SetEnableGimmickCheck("fa_0007", false)
  SetEnableGimmickCheck("gim_0001", true)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
end

function Prcs_d1204_DageGate()
  local tlk = Tlk:new("field_text", 1, true)
  tlk:StartTalk()
  tlk:Message("g_d1201_0010_0010")
  tlk:MessageClose()
  local result = tlk:Select(2, "g_d1201_0010_0011")
  if result == RESULT_TALK00 then
    tlk:EndTalk()
    MoveGateBlue("change_0001", 1, 0)
    MapChange("d", 216, "start_01", true, FADE_WHITE, 30)
  else
    tlk:EndTalk()
  end
end
