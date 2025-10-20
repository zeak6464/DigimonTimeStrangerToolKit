gGimText = "field_text"

function Prcs_t0303_EnterCulvert()
  Field_Talk_Start_Not_LetterBox(gGimText, 1)
  Message("g_t0303_0030_0010")
  MessageClose()
  MessageTalkSel(2, "g_sel_0010_0010")
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Field_Talk_End_Not_LetterBox()
    SetPlayerRotationToLocator("obj_5000", 15)
    Motion.Player:Play("fg07_m03", 0, false)
    WaitFrame(40)
    Motion.Gimmick:Play("obj_0002", "e001", false)
    PlaySE(200003, 100)
    WaitFrame(30)
    MapChange("d", 1102, "start_00", true, 0, 15)
  elseif result == RESULT_TALK01 then
  end
  Field_Talk_End_Not_LetterBox()
end

function Prcs_t03_SettingSignal()
  local STOP_SIG0301 = {
    1,
    2,
    3,
    4
  }
  local STOP_WALKSIG0301 = {10}
  local SIG0301 = {
    [1] = {
      1,
      "signal_0001",
      "signal_0002",
      "signal_0003",
      "signal_0004"
    }
  }
  local WALK_SIG0301 = {
    [1] = {
      10,
      "signal_0051",
      "signal_0052"
    }
  }
  local sig, walk_sig, stop_sig, stop_walksig
  if gMapNum == 301 then
    sig = SIG0301
    walk_sig = WALK_SIG0301
    stop_sig = STOP_SIG0301
    stop_walksig = STOP_WALKSIG0301
  end
  for table_number = 1, #sig do
    for signal_number = 2, #sig[table_number] do
      Field.StopSignalSynchroGimmick(sig[table_number][signal_number], sig[table_number][1], "e001", false, CAR_SIGNAL_RED, "e001", false, CAR_SIGNAL_BLUE)
    end
  end
  for table_number = 1, #walk_sig do
    for signal_number = 2, #walk_sig[table_number] do
      Field.StopSignalSynchroGimmick(walk_sig[table_number][signal_number], walk_sig[table_number][1], "e001", false, WALK_SIGNAL_BLUE, "e002", false, WALK_SIGNAL_RED_SHORT)
    end
  end
  for table_number = 1, #stop_walksig do
    Field.StopSignalResetSwitchTime(stop_walksig[table_number], false, true, 0, 0)
  end
  for table_number = 1, #stop_sig do
    Field.StopSignalResetSwitchTime(stop_sig[table_number], true, true, 0, 0)
  end
end
