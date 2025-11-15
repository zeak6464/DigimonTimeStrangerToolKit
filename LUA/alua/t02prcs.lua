gGimText = "field_text"

function Prcs_t0203_EnterCvs()
  SetControlScriptExternalVariable("player_state", "go_shop")
  GimmickZoom_In()
  while GetControlScriptExternalVariableString("player_state") ~= "map_change_shop" do
    WaitFrame(1)
  end
  FadeOutWithWait(0, 30)
  CreateAddress()
  Work.SetString(Field_Shop_Temp_Locator, "start_09")
  MapChange("t", 1, "start_00", false, -1, -1)
end

function Prcs_t02_SettingSignal()
  SIG0201 = {
    [1] = {
      1,
      "signal_0001",
      "signal_0002",
      "signal_0003",
      "signal_0004"
    }
  }
  WALK_SIG0201 = {
    [1] = {
      11,
      "signal_0051",
      "signal_0052"
    }
  }
  STOP_SIG0201 = {
    1,
    2,
    3,
    4
  }
  STOP_WALKSIG0201 = {11}
  local sig, walk_sig, stop_sig, stop_walk
  if gMapNum == 201 then
    sig = SIG0201
    walk_sig = WALK_SIG0201
    stop_sig = STOP_SIG0201
    stop_walk = STOP_WALKSIG0201
  end
  for table_number = 1, #sig do
    for signal_number = 2, #sig[table_number] do
      Field.StopSignalSynchroGimmick(sig[table_number][signal_number], sig[table_number][1], "e001", false, -180, "e002", true, 0)
    end
  end
  for table_number = 1, #walk_sig do
    for signal_number = 2, #walk_sig[table_number] do
      Field.StopSignalSynchroGimmick(walk_sig[table_number][signal_number], walk_sig[table_number][1], "e001", false, -420, "e002", true, 0)
    end
  end
  Field.StopSignalResetCurrentTime(1, 800)
  Field.StopSignalResetCurrentTime(11, 800)
  for table_number = 1, #stop_sig do
    Field.StopSignalAddSwitchTime(stop_sig[table_number], true, 1200)
    Field.StopSignalAddSwitchTime(stop_sig[table_number], false, 1800)
  end
  for table_number = 1, #stop_walk do
    Field.StopSignalAddSwitchTime(stop_walk[table_number], false, 1200)
    Field.StopSignalAddSwitchTime(stop_walk[table_number], true, 1800)
  end
end

function Prcs_t0201_SettingSignal()
  STOP_SIG0201 = {
    1,
    2,
    3,
    4
  }
  STOP_WALKSIG0201 = {11}
  SIG0201 = {
    [1] = {
      1,
      "signal_0001",
      "signal_0002",
      "signal_0003",
      "signal_0004"
    }
  }
  WALK_SIG0201 = {
    [1] = {
      11,
      "signal_0051",
      "signal_0052"
    }
  }
  local sig, walk_sig, stop_sig, stop_walksig
  sig = SIG0201
  walk_sig = WALK_SIG0201
  stop_sig = STOP_SIG0201
  stop_walksig = STOP_WALKSIG0201
  for table_number = 1, #sig do
    for signal_number = 2, #sig[table_number] do
      Field.StopSignalSynchroGimmick(sig[table_number][signal_number], sig[table_number][1], "e001", false, 0, "e002", true, 0)
    end
  end
  for table_number = 1, #walk_sig do
    for signal_number = 2, #walk_sig[table_number] do
      Field.StopSignalSynchroGimmick(walk_sig[table_number][signal_number], walk_sig[table_number][1], "e001", false, 0, "e002", true, 0)
    end
  end
  for table_number = 1, #stop_walksig do
    Field.StopSignalResetSwitchTime(stop_walksig[table_number], false, true, 0, 0)
  end
  for table_number = 1, #stop_sig do
    Field.StopSignalResetSwitchTime(stop_sig[table_number], true, true, 0, 0)
  end
end

function Prcs_t02_FAkuga(enemy_name)
  if enemy_name == "s202_kuramon11" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_111")
    require("Sow_202")
    SeekDrKuga_T0201()
  elseif enemy_name == "s202_kuramon12" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_112")
    require("Sow_202")
    SeekDrKuga_T0203()
  end
end
