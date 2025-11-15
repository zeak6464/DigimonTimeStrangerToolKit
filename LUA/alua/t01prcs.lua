gGimText = "field_text"

function Prcs_t0102_EnterCvs()
  if Flg.Check("FLAG_MAIN_02_020") then
    SetControlScriptExternalVariable("player_state", "go_shop")
    Field_InvisibleFollowerAllPartyMember(0, 20, false)
    Field_InvisibleFollowerAllGuest(0, 20, false)
    PlayerObjectResetAim()
    GimmickZoom_In()
    while GetControlScriptExternalVariableString("player_state") ~= "map_change_shop" do
      WaitFrame(1)
    end
    FadeOutWithWait(0, 15)
    CreateAddress()
    Work.SetString(Field_Shop_Temp_Locator, "start_09")
    MapChange("t", 1, "start_00", false, -1, -1)
  else
    Field_Talk_Start_Not_LetterBox("t01", 1)
    Message("f_t0102_0080_0010")
    Field_Talk_End_Not_LetterBox()
  end
end

function Prcs_t0103_ride_end()
  M310:Event_050()
  SetControlScriptExternalVariable("ride_state", "end")
  Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
  WaitFrame(15)
  Field.PlayerScriptDigimonRideEnd(false, "", 5)
  Field.SetPlayerLocator("start_21")
  SetEnableCameraOperate(true)
  Cam.Inst:Clear(0)
  WaitFrame(10)
  FadeAllInWithWait(FADE_BLACK, 10)
  M310:Event_055()
  HideMinimap(false)
  HideGuide(false)
  Field.StartAutoSave()
end

function Prcs_t0105_OpenPlatformDoor()
  Motion.Player:Play("fg07_m02", 0, false)
  WaitFrame(21)
  PlaySE(200003, 100)
  Motion.Gimmick:Play("gim_0001", "e001", false)
  SetEnableGimmickCheck("gim_0001", false)
  ColOff("wall_cl_0001")
  WaitFrame(15)
  Flg.Set("FLAG_GIMMICK_T01_010")
end

function Prcs_t0109_EnterCulvert()
  sp_text = "t0109"
  SetPlayerRotationToLocator("change_0002", 5)
  Field_Talk_Start_Not_LetterBox(gGimText, 1)
  Message("g_t0109_0010_0010")
  MessageClose()
  MessageTalkSel(2, "g_sel_0040_0010")
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Field_Talk_End_Not_LetterBox()
    MapChange("d", 1101, "start_00", true, 0, 15)
  elseif result == RESULT_TALK01 then
    Field_Talk_End_Not_LetterBox()
  end
end

function Prcs_t01_ThroughGate(degree_y)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  ColOff("plan_cl_0002")
  ColOff("plan_cl_0003")
  Field.ObjectLoadMotion(FLD_OBJ_PLAYER, 1, "fg06_w01")
  Motion.Object:Play(FLD_OBJ_PLAYER, 1, 5, "fg06_w01", false)
  Field.SetPlayerRotation(degree_y, 5)
  PlaySE(200025, 100)
  WaitFrame(50)
  Field.ObjectStartMoveMotion(FLD_OBJ_PLAYER, 1, 5)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  ColOn("plan_cl_0002")
  ColOn("plan_cl_0003")
end

function Prcs_t01_SettingSignal()
  STOP_SIG0101 = {
    1,
    2,
    3,
    4
  }
  STOP_WALKSIG0101 = {
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  }
  STOP_SIG0102 = {
    1,
    2,
    3,
    4
  }
  STOP_WALKSIG0102 = {11}
  STOP_SIG0108 = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17
  }
  STOP_WALKSIG0108 = {
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34
  }
  SIG0101 = {
    [1] = {
      1,
      "signal_0001",
      "signal_0002",
      "signal_0003",
      "signal_0004"
    },
    [2] = {
      4,
      "signal_0005",
      "signal_0006"
    }
  }
  SIG0102 = {
    [1] = {
      1,
      "signal_0001",
      "signal_0002",
      "signal_0003",
      "signal_0004",
      "signal_0005",
      "signal_0006"
    }
  }
  SIG0108 = {
    [1] = {
      7,
      "signal_0001",
      "signal_0003"
    },
    [2] = {
      1,
      "signal_0002",
      "signal_0004",
      "signal_0005",
      "signal_0006",
      "signal_0007"
    }
  }
  WALK_SIG0101 = {
    [1] = {
      11,
      "signal_0051",
      "signal_0052",
      "signal_0054",
      "signal_0055",
      "signal_0057",
      "signal_0058",
      "signal_0060",
      "signal_0061"
    },
    [2] = {
      15,
      "signal_0053",
      "signal_0056",
      "signal_0059"
    }
  }
  WALK_SIG0102 = {
    [1] = {
      11,
      "signal_0051",
      "signal_0052",
      "signal_0053",
      "signal_0054",
      "signal_0055",
      "signal_0056",
      "signal_0057",
      "signal_0058"
    }
  }
  WALK_SIG0108 = {
    [1] = {
      21,
      "signal_0051",
      "signal_0052",
      "signal_0053",
      "signal_0054"
    }
  }
  local sig, walk_sig, stop_sig, stop_walksig
  if gMapNum == 101 then
    sig = SIG0101
    walk_sig = WALK_SIG0101
    stop_sig = STOP_SIG0101
    stop_walksig = STOP_WALKSIG0101
  elseif gMapNum == 102 then
    sig = SIG0102
    walk_sig = WALK_SIG0102
    stop_sig = STOP_SIG0102
    stop_walksig = STOP_WALKSIG0102
  elseif gMapNum == 108 then
    sig = SIG0108
    walk_sig = WALK_SIG0108
    stop_sig = STOP_SIG0108
    stop_walksig = STOP_WALKSIG0108
  end
  for table_number = 1, #sig do
    for signal_number = 2, #sig[table_number] do
      Field.StopSignalSynchroGimmick(sig[table_number][signal_number], sig[table_number][1], "e001", false, 0, "e002", true, 0)
    end
  end
  for table_number = 1, #walk_sig do
    for signal_number = 2, #walk_sig[table_number] do
      if gMapNum == 101 then
        Field.StopSignalSynchroGimmick(walk_sig[table_number][signal_number], walk_sig[table_number][1], "e001", false, 0, "e002", true, 0)
      else
        Field.StopSignalSynchroGimmick(walk_sig[table_number][signal_number], walk_sig[table_number][1], "e001", false, 0, "e002", true, 0)
      end
    end
  end
  if gMapNum == 101 then
    Field.StopSignalResetCurrentTime(1, 1150)
    Field.StopSignalResetCurrentTime(2, 1150)
    Field.StopSignalResetCurrentTime(3, 1150)
    Field.StopSignalResetCurrentTime(15, 1150)
  elseif gMapNum == 102 then
    Field.StopSignalResetCurrentTime(1, 1150)
    Field.StopSignalResetCurrentTime(2, 1150)
    Field.StopSignalResetCurrentTime(3, 1150)
    Field.StopSignalResetCurrentTime(4, 1150)
  elseif gMapNum == 108 then
    Field.StopSignalResetCurrentTime(8, 1150)
    Field.StopSignalResetCurrentTime(9, 1150)
    Field.StopSignalResetCurrentTime(10, 1150)
    Field.StopSignalResetCurrentTime(12, 1150)
  end
  for table_number = 1, #stop_walksig do
    Field.StopSignalAddSwitchTime(stop_walksig[table_number], true, 700)
    Field.StopSignalAddSwitchTime(stop_walksig[table_number], false, 1600)
  end
  for table_number = 1, #stop_sig do
    Field.StopSignalAddSwitchTime(stop_sig[table_number], true, 1000)
    Field.StopSignalAddSwitchTime(stop_sig[table_number], false, 1300)
  end
end

function Prcs_t0101_SettingSignal()
  STOP_SIG0101 = {
    1,
    2,
    3,
    4
  }
  STOP_WALKSIG0101 = {
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  }
  SIG0101 = {
    [1] = {
      1,
      "signal_0001",
      "signal_0002",
      "signal_0003",
      "signal_0004"
    },
    [2] = {
      4,
      "signal_0005",
      "signal_0006"
    }
  }
  WALK_SIG0101 = {
    [1] = {
      12,
      "signal_0051",
      "signal_0052",
      "signal_0054",
      "signal_0055",
      "signal_0057",
      "signal_0058",
      "signal_0060",
      "signal_0061"
    },
    [2] = {
      15,
      "signal_0053",
      "signal_0056",
      "signal_0059"
    }
  }
  local sig, walk_sig, stop_sig, stop_walksig
  sig = SIG0101
  walk_sig = WALK_SIG0101
  stop_sig = STOP_SIG0101
  stop_walksig = STOP_WALKSIG0101
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

function Prcs_t0102_SettingSignal()
  STOP_SIG0102 = {
    1,
    2,
    3,
    4
  }
  STOP_WALKSIG0102 = {11}
  SIG0102 = {
    [1] = {
      1,
      "signal_0001",
      "signal_0002",
      "signal_0003",
      "signal_0004",
      "signal_0005",
      "signal_0006"
    }
  }
  WALK_SIG0102 = {
    [1] = {
      11,
      "signal_0051",
      "signal_0052",
      "signal_0053",
      "signal_0054",
      "signal_0055",
      "signal_0056",
      "signal_0057",
      "signal_0058"
    }
  }
  local sig, walk_sig, stop_sig, stop_walksig
  sig = SIG0102
  walk_sig = WALK_SIG0102
  stop_sig = STOP_SIG0102
  stop_walksig = STOP_WALKSIG0102
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

function Prcs_t0108_SettingSignal()
  STOP_SIG0108 = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17
  }
  STOP_WALKSIG0108 = {
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34
  }
  SIG0108 = {
    [1] = {
      7,
      "signal_0001",
      "signal_0003"
    },
    [2] = {
      1,
      "signal_0002",
      "signal_0004",
      "signal_0005",
      "signal_0006",
      "signal_0007",
      "signal_0008",
      "signal_0009",
      "signal_0010"
    }
  }
  WALK_SIG0108 = {
    [1] = {
      21,
      "signal_0051",
      "signal_0052",
      "signal_0053",
      "signal_0054",
      "signal_0055",
      "signal_0056",
      "signal_0057",
      "signal_0058",
      "signal_0059",
      "signal_0060",
      "signal_0061",
      "signal_0062"
    }
  }
  local sig, walk_sig, stop_sig, stop_walksig
  sig = SIG0108
  walk_sig = WALK_SIG0108
  stop_sig = STOP_SIG0108
  stop_walksig = STOP_WALKSIG0108
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

function Prcs_d0109_uradoriCam()
  Cam.Inst:Set(37.700859, 0.050005, -32.562057, 29.95343, 1.820926, -31, default, 20)
end

function Prcs_t01_FAkuga(enemy_name)
  if enemy_name == "s202_kuramon01" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_101")
    require("Sow_202")
    SeekDrKuga_T0101()
  elseif enemy_name == "s202_kuramon02" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_102")
    require("Sow_202")
    SeekDrKuga_T0102()
  elseif enemy_name == "s202_kuramon03" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_103")
    require("Sow_202")
    SeekDrKuga_T0103()
  elseif enemy_name == "s202_kuramon04" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_104")
    require("Sow_202")
    SeekDrKuga_T0104()
  elseif enemy_name == "s202_kuramon05" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_105")
    require("Sow_202")
    SeekDrKuga_T0105()
  elseif enemy_name == "s202_kuramon06" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_106")
    require("Sow_202")
    SeekDrKuga_T0107()
  elseif enemy_name == "s202_kuramon07" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_107")
    require("Sow_202")
    SeekDrKuga_T0108()
  elseif enemy_name == "s202_kuramon08" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_108")
    require("Sow_202")
    SeekDrKuga_T0109()
  elseif enemy_name == "s202_kuramon09" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_109")
    require("Sow_202")
    SeekDrKuga_T0110()
  elseif enemy_name == "s202_kuramon10" then
    Flg.Set("FLAG_SUB_SEEKDRKUGA_110")
    require("Sow_202")
    SeekDrKuga_T0111()
  end
end
