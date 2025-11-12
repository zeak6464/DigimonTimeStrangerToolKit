gGimText = "field_text"
M150 = {
  ID = 150,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_010 = 10,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_037 = 37,
  STEP_040 = 40,
  STEP_045 = 45,
  STEP_050 = 50,
  STEP_055 = 55,
  STEP_058 = 58,
  STEP_060 = 60,
  STEP_065 = 65,
  STEP_070 = 70,
  STEP_072 = 72,
  STEP_073 = 73,
  STEP_075 = 75,
  STEP_080 = 80,
  STEP_085 = 85,
  STEP_088 = 88,
  STEP_090 = 90,
  STEP_095 = 95,
  STEP_100 = 100,
  STEP_105 = 105,
  STEP_110 = 110,
  STEP_115 = 115,
  STEP_118 = 118,
  STEP_120 = 120,
  STEP_125 = 125,
  STEP_130 = 130,
  STEP_135 = 135,
  STEP_140 = 140,
  STEP_255 = 255
}

function M150:Event_010()
  if Flg.Check("FLAG_MAIN_03_708", "FLAG_MAIN_03_715") then
    Flg.Set("FLAG_MAIN_03_715")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M150:Event_015()
  if Flg.Check("FLAG_MAIN_03_715", "FLAG_MAIN_04_000") then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_150"
    TIME_ZONE = NOON
  end
end

function M150:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Execute("m150_010")
    Flg.Set("FLAG_MAIN_04_000")
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M150:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_006) then
    Execute("m150_020")
    Qst.Main:Set(self.ID, self.STEP_006)
  end
end

function M150:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_006, self.STEP_010) then
    local tlk = Tlk:new("d02")
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0201_0290_0010")
    tlk:MessageClose()
    local result = tlk:Select(2, "f_d0201_0290_0020")
    if result == RESULT_TALK00 then
      tlk:Message("f_d0201_0290_0030")
      tlk:EndTalk()
      Execute("m150_030")
      Flg.Set("FLAG_MAIN_04_005")
      MapChange("d", 306, "start_00", false, FADE_BLACK, FADE_TIME)
    else
      tlk:Message("f_d0201_0290_0040")
      tlk:EndTalk()
    end
  end
end

function M150:Event_037()
  if Qst.Main:Check(self.ID, self.STEP_006, self.STEP_010) then
    Execute("m150_040")
    MapChange("d", 501, "start_09", false, FADE_BLACK, FADE_TIME)
  end
end

function M150:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_006, self.STEP_010) then
    Execute("m150_050")
    Execute("m150_060")
    Flg.Set("FLAG_MAIN_04_010")
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M150:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_020) then
    Flg.Set("FLAG_MAIN_04_020")
    local pc = Obj:new(PLAYER, "")
    pc:SetPos(-67.073, -10.385, 53.877, true)
    Execute("m150_070")
    FieldObjectSync(FOR_ALL, true)
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M150:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M150:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Execute("m150_080")
    Qst.Main:Set(self.ID, self.STEP_030)
  end
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0501_0050_0050")
    tlk:Message("f_d0501_0050_0060")
    tlk:Message("f_d0501_0050_0070")
    tlk:Message("f_d0501_0050_0080")
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_037)
  end
end

function M150:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and not Flg.Check("FLAG_MAIN_04_050") then
    Execute("m150_090")
    INFO_GET_ITEM(30141, 1)
    Flg.Set("FLAG_MAIN_04_040")
    Flg.Set("FLAG_MAIN_04_050")
    Qst.Main:Set(self.ID, self.STEP_035)
  end
end

function M150:Event_095()
  if Qst.Main:Check(self.ID, self.STEP_037, self.STEP_040) then
    WaitFrame(30)
    Execute("m150_095")
    self:Event_100()
  end
end

function M150:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_037, self.STEP_040) then
    Flg.Set("FLAG_MAIN_04_060")
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(25)
    Qst.Main:Set(self.ID, self.STEP_040)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M150:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0501_0150_0010")
    tlk:Message("f_d0501_0150_0020")
    tlk:MessageClose()
    local result = tlk:Select(2, "f_d0501_0150_0030")
    if result == RESULT_TALK00 then
      tlk:Message("f_d0501_0150_0043")
      tlk:MessageClose()
      tlk:EndTalk()
      Flg.Set("FLAG_GIMMICK_D05_030")
      Flg.Set("FLAG_MAIN_04_065")
      Prcs_d0501_OpenShutter_05()
      Motion.Gimmick:PlayFinishedAnim("gim_0050", "e001")
      SetEnableGimmickCheck("gim_0051", false)
      ColOff("wall_cl_8000")
      local gim = Obj:new(FLD_OBJ_LOCATOR, "gim_0051")
      local kokuwa_a = Obj:new(NPC, "kokuwa_a")
      local kokuwa_f001 = Motion.Object:new(NPC, kokuwa_a.name, "f001")
      local y_degree = GetAngleToTarget2D(gim.pos.x, gim.pos.z, kokuwa_a.pos.x, kokuwa_a.pos.z)
      kokuwa_a:SetRotationY(y_degree, 0)
      kokuwa_f001:Play(0, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d0501_0150_0045")
      tlk:EndTalk()
      Qst.Main:Set(self.ID, self.STEP_045)
    end
    if result == RESULT_TALK01 then
      tlk:Message("f_d0501_0150_0040")
      tlk:EndTalk()
    end
  end
end

function M150:Event_115()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_GIMMICK_D05_030") then
    Field_InvisibleFollowerAllPartyMember(1, 10, false)
    Field_InvisibleFollowerAllGuest(1, 10, false)
    FadeOutWithWait(0, 5)
    WaitFrame(5)
    Obj:new(RUMOR_NPC, "rumor_0004"):Invisible()
    Obj:new(RUMOR_NPC, "rumor_0011"):Invisible()
    Obj:new(RUMOR_NPC, "rumor_0013"):Invisible()
    Field_InvisibleObjects(MOB, 141, 146)
    Field_CancelInvisibleObjects(MOB, 147, 155)
    Cam.Inst:Set(70.342, -45.22, 16.53, 80.289, -44.537, 15.77, default, 1)
    FadeInWithWait(0, 5)
    MovePlayerToRelativePosFrame(1.5, 0, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0501_0150_0060")
    tlk:Message("f_d0501_0150_0070")
    tlk:EndTalk()
    Flg.Clear("FLAG_GIMMICK_D05_030")
    Flg.Set("FLAG_MAIN_04_070")
    local index = GetIndex(FLD_OBJ_LOCATOR, "gim_0050")
    Field.ObjectPlayMotionAndSetting(FLD_OBJ_LOCATOR, index, "e001", 5, 60, 60, 0, 1, false)
    PlaySE(201005, 100)
    SetEnableGimmickCheck("gim_0051", false)
    ColOn("wall_cl_8000")
    WaitFrame(70)
    Qst.Main:Set(self.ID, self.STEP_050)
    MapChange("d", 502, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function M150:Event_118()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_055) and not Flg.Check("FLAG_MAIN_04_076") then
    local tlk = Tlk:new("d05", 1, true)
    local rumer_kokuwa = GetIndex(RUMOR_NPC, "rumer_kokuwa")
    local player = Field.GetPlayerIndex()
    local rumer_kokuwa_pos = Field.ObjectGetPosition(RUMOR_NPC, rumer_kokuwa)
    local player_pos = Field.ObjectGetPosition(PLAYER, player)
    local y_rumer_kokuwa = GetAngleToTarget2D(rumer_kokuwa_pos.x, rumer_kokuwa_pos.z, player_pos.x, player_pos.z)
    local rumer_kokuwa_bn01 = Motion.Object:new(RUMOR_NPC, "rumer_kokuwa", "bn01")
    Cam.Inst:Set(37.4455, -0.3989, 69.6, 28.198, 2.51, 67.14, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectLookAtTheObject(RUMOR_NPC, rumer_kokuwa, PLAYER, 1, 30)
    tlk:Message("f_d0502_0080_0010")
    tlk:EndTalk(true)
    Guest.Add(GST_KOKUWAMON_UN)
    EncountFromField_WithNormalEffect(10400010, BTL_MAP_VUKCANUS_PLANT, false)
  end
end

function M150:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_055) and Flg.Check("FLAG_MAIN_04_076") then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Cam.Inst:Set(37.293919, -0.765447, 64.03067, 30.794514, 2.234865, 71.013214, default, 1)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 90, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 31.558, 0.051, 68.05)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    WaitFrame(30)
    Obj:new(NPC, "npc_802"):Invisible()
    Obj:new(NPC, "npc_803"):Invisible()
    Obj:new(NPC, "npc_804"):Invisible()
    Obj:new(RUMOR_NPC, "rumer_kokuwa"):Invisible()
    local npc_801 = Obj:new(NPC, "npc_801")
    local digimon_index = GetIndex(NPC, "npc_801")
    npc_801:CancelInvisible()
    npc_801:SetRotationY(270, 0)
    npc_801:SetPos(34.4, 0, 67.896)
    Field.ObjectLoadMotion(NPC, digimon_index, "bn01")
    Field.ObjectLoadMotion(NPC, digimon_index, "br01")
    Field.ObjectLoadMotion(NPC, digimon_index, "bn02")
    Field.ObjectLoadMotion(NPC, digimon_index, "fq01")
    Field.ObjectLoadMotion(NPC, digimon_index, "fq02")
    Field.ObjectLoadMotion(NPC, digimon_index, "fe02")
    Field.ObjectLoadMotion(NPC, digimon_index, "fe04")
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq01", 10, 10)
    tlk:Message("f_d0502_0080_0030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fe02", 10, 10)
    tlk:Message("f_d0502_0080_0040")
    tlk:MessageClose()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Cam.Inst:Set(20.687, 0.151, 76.563, 11.785, 3.11, 80.02, default, 30)
    Obj:new(NPC, "npc_801"):SetRotationY(235, 30)
    Field.ObjectPlayMotion(NPC, digimon_index, "br01", 15, true)
    WaitFrame(30)
    Field.ObjectPlayMotion(NPC, digimon_index, "bn01", 15, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq01", 10, 10)
    tlk:Message("f_d0502_0080_0060")
    tlk:MessageClose()
    INFO_GET_ITEM(727, 1)
    FadeOutWithWait(0, 10)
    WaitFrame(30)
    Cam.Inst:Clear(0)
    tlk:EndTalk()
    Obj:new(NPC, "npc_801"):Invisible()
    FieldObjectSync(FOR_ALL, true)
    SetEnableGimmickCheck("gim_0007", true)
    Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
    Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
    OpenInfoWindow(7029)
    Common.SetDigimonGraspState(609, DIGIMON_GRASP_FLAG_SCAN)
    WaitFrame(30)
    FadeInWithWait(0, 10)
    WaitFrame(10)
    Qst.Main:Set(self.ID, self.STEP_055)
  end
end

function M150:Event_125()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_058) then
    Qst.Main:Set(self.ID, self.STEP_058)
  end
end

function M150:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_058, self.STEP_060) then
    local mekanori01_bn02 = Motion.Object:new(NPC, "npc_807", "bn02")
    local mekanori02_fq02 = Motion.Object:new(NPC, "npc_807", "fq02")
    local kame01_bn02 = Motion.Object:new(NPC, "npc_808", "bn02")
    local kame02_fe04 = Motion.Object:new(NPC, "npc_808", "fe04")
    local clock01_bn02 = Motion.Object:new(NPC, "npc_809", "bn02")
    local clock02_fq02 = Motion.Object:new(NPC, "npc_809", "fq02")
    local tlk = Tlk:new("d05", 1, true)
    Cam.Inst:Set(85.737, -2.245, 79.121, 75.832, -0.889, 78.88, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    mekanori02_fq02:Play(10, true)
    kame02_fe04:Play(10, true)
    clock02_fq02:Play(10, true)
    tlk:Message("f_d0502_0090_0010")
    Talk.NextNoVoice()
    tlk:Message("f_d0502_0090_0020")
    Cam.Inst:Set(79.892815, -2.920923, 81.926155, 70.233444, -1.319273, 79.8936, default, 30)
    WaitFrame(30)
    Talk.NextNoVoice()
    tlk:Message("f_d0502_0090_0025")
    mekanori01_bn02:Play(10, true)
    tlk:EndTalk()
    kame01_bn02:Play(10, true)
    clock01_bn02:Play(10, true)
    Cam.Inst:Clear(30)
    WaitFrame(30)
    Qst.Main:Set(self.ID, self.STEP_060)
  end
end

function M150:Event_133()
  if Qst.Main:Check(self.ID, self.STEP_060, self.STEP_065) then
    local npc_index = GetIndex(NPC, "npc_809")
    if not Flg.Check("FLAG_MAIN_04_079") then
      FadeOutWithWait(0, 10)
      WaitFrame(10)
      Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 90, 0)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 88.545, -3.704, 79.715)
      Motion.Player:Play("e533", 0, true, "*Aegiomon")
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index, 30)
      local npc_807 = Obj:new(NPC, "npc_807")
      npc_807:SetRotationY(83.945, 0)
      npc_807:SetPos(88.322, -3.704, 77.174, true)
      local npc_808 = Obj:new(NPC, "npc_808")
      npc_808:SetRotationY(79.982, 0)
      npc_808:SetPos(87.08, -3.704, 79.516, true)
      local npc_809 = Obj:new(NPC, "npc_809")
      npc_809:SetRotationY(71.911, 0)
      npc_809:SetPos(87.768, -3.704, 81.031, true)
      Cam.Inst:Set(98.076, -1.089, 77.078, 85.024, -3.012, 80.503, default, 0)
      WaitFrame(20)
      FadeInWithWait(0, 10)
      local tlk = Tlk:new("d05", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d0502_0090_0080")
      tlk:EndTalk()
      EncountFromField_WithNormalEffect(10400020, 10571, false)
      Cam.Inst:Clear(0)
      self:Event_135()
    end
  end
end

function M150:Event_135()
  if Qst.Main:Check(self.ID, self.STEP_060, self.STEP_065) then
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    local digimon_index = GetIndex(NPC, "npc_812")
    Field.ObjectLoadMotion(NPC, digimon_index, "bn01")
    Field.ObjectLoadMotion(NPC, digimon_index, "fq01")
    Field.ObjectLoadMotion(NPC, digimon_index, "fq02")
    if Flg.Check("FLAG_MAIN_04_079") then
      Obj:new(NPC, "npc_807"):Invisible(10)
      Obj:new(NPC, "npc_808"):Invisible(10)
      Obj:new(NPC, "npc_809"):Invisible(10)
      Obj:new(NPC, "npc_810"):Invisible(10)
      Obj:new(NPC, "npc_811"):Invisible(10)
      Obj:new(NPC, "npc_812"):CancelInvisible(10)
      Obj:new(NPC, "npc_813"):CancelInvisible(10)
      Obj:new(NPC, "npc_814"):CancelInvisible(10)
      Motion.Player:Play("fn01_01", 0, true)
      Cam.Inst:Set(99.515, -3.621, 77.69, 86.45, -2.78, 81.483, default, 0)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      local tlk = Tlk:new("d05", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq02", 10, 10)
      tlk:Message("f_d0502_0090_0090")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq01", 10, 10)
      tlk:Message("f_d0502_0090_0100")
      tlk:MessageClose()
      INFO_GET_ITEM(727, 1)
      WaitFrame(60)
      FadeOutWithWait(0, 5)
      WaitFrame(25)
      tlk:EndTalk()
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      Flg.Set("FLAG_MAIN_04_079")
      Obj:new(NPC, "npc_812"):Invisible(10)
      Obj:new(NPC, "npc_813"):Invisible(10)
      Obj:new(NPC, "npc_814"):Invisible(10)
      Qst.Main:Set(self.ID, self.STEP_065)
      Cam.Inst:Clear(1)
      WaitFrame(30)
      FadeInWithWait(0, 5)
    end
  end
end

function M150:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_065, self.STEP_070) then
    Cam.Inst:Set(71.029, -7.879, 2.622, 71.978, -6.481, 12.478, default, 30)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0502_0100_0010")
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_070)
    Flg.Set("FLAG_MAIN_04_089")
    Cam.Inst:Clear(30)
  end
end

function M150:Event_145()
  if Qst.Main:Check(self.ID, self.STEP_070, self.STEP_072) then
    Qst.Main:Set(self.ID, self.STEP_072)
  end
end

function M150:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_072, self.STEP_073) then
    Cam.Inst:Set(58.121, -8.462, -8.35, 69.537, -4.903, -6.472, default, 30)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0502_0100_0020")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_04_095")
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_01"), true)
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_073)
  end
end

function M150:Event_155()
  if Qst.Main:Check(self.ID, self.STEP_073, self.STEP_075) then
    WaitFrame(60)
    FadeOutWithWait(0, 10)
    WaitFrame(10)
    Field_InvisibleObjects(MOB, 1, 6)
    Field_CancelInvisibleObjects(MOB, 7, 14)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Obj:new(RUMOR_NPC, "rumor_0005"):Invisible()
    Obj:new(RUMOR_NPC, "rumor_0006"):Invisible()
    Obj:new(NPC, "npc_805"):Invisible(10)
    Obj:new(NPC, "npc_806"):CancelInvisible(10)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 300, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 66.488, -8.463, -9.113)
    Cam.Inst:Set(60.512, -9.264, -6.264, 69.044, -6.179, -11.077, default, 30)
    WaitFrame(20)
    FadeInWithWait(0, 10)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    local mekanori02_fq01 = Motion.Object:new(NPC, "npc_806", "fq01")
    mekanori02_fq01:Play(10, true)
    tlk:Message("f_d0502_0100_0030")
    tlk:MessageClose()
    INFO_GET_ITEM(30321, 1)
    Qst.Main:Set(self.ID, self.STEP_075)
    WaitFrame(60)
    FadeOutWithWait(0, 5)
    WaitFrame(25)
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_04_087")
    Obj:new(NPC, "npc_806"):Invisible(10)
    Field_InvisibleObjects(MOB, 7, 14)
    Cam.Inst:Clear(1)
    WaitFrame(25)
    FadeInWithWait(0, 5)
  end
end

function M150:Event_160()
  if Qst.Main:Check(self.ID, self.STEP_075, self.STEP_080) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0502_0110_0010")
    Cam.Inst:Set(1.192, -17.344, -57.868, 0.929, -15.454, -49.035, default, 30)
    tlk:Message("f_d0502_0110_0020")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_04_074")
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_080)
  end
end

function M150:Event_165()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_085) and not Flg.Check("FLAG_MAIN_04_085") then
    FadeOutWithWait(0, 10)
    WaitFrame(10)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 90.723, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 11.397, -17.536, -75.617)
    Motion.Player:Play("e533", 0, true, "*Aegiomon")
    Cam.Inst:Set(16.3557, -17.551174, -76.359886, 7.135045, -14.250799, -74.337646, default, 0)
    WaitFrame(20)
    FadeInWithWait(0, 10)
    WaitFrame(20)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    local clock01_fe04 = Motion.Object:new(NPC, "npc_816", "fe04")
    clock01_fe04:Play(10, true)
    tlk:Message("f_d0502_0110_0030")
    local gadoro01_fe02 = Motion.Object:new(NPC, "npc_826", "fe02")
    gadoro01_fe02:Play(10, true)
    tlk:Message("f_d0502_0110_0040")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(10400030, BTL_MAP_VUKCANUS_PLANT, false)
  end
end

function M150:Event_168()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_085) and Flg.Check("FLAG_MAIN_04_085") then
    Flg.Set("FLAG_MAIN_04_085")
    Field_InvisibleObjects(MOB, 15, 24)
    Field_CancelInvisibleObjects(MOB, 25, 36)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Obj:new(RUMOR_NPC, "rumor_0003"):Invisible()
    Obj:new(RUMOR_NPC, "rumor_0007"):Invisible()
    Obj:new(NPC, "npc_816"):Invisible()
    Obj:new(NPC, "npc_826"):Invisible()
    Obj:new(NPC, "npc_817"):CancelInvisible()
    Obj:new(NPC, "npc_818"):CancelInvisible()
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 90, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 11.397, -17.536, -75.617)
    Motion.Player:Play("fn01_01", 0, true)
    Cam.Inst:Set(16.3557, -17.551174, -76.359886, 7.135045, -14.250799, -74.337646, default, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    local clock02_fe02 = Motion.Object:new(NPC, "npc_817", "fe02")
    clock02_fe02:Play(10, true)
    tlk:Message("f_d0502_0110_0050")
    tlk:Message("f_d0502_0110_0060")
    tlk:MessageClose()
    FadeOutWithWait(0, 5)
    WaitFrame(25)
    tlk:EndTalk()
    Field_InvisibleObjects(MOB, 25, 36)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Obj:new(NPC, "npc_817"):Invisible(10)
    Obj:new(NPC, "npc_818"):Invisible(10)
    Cam.Inst:Clear(1)
    WaitFrame(25)
    FadeInWithWait(0, 5)
    Qst.Main:Set(self.ID, self.STEP_085)
  end
end

function M150:Event_170()
  if Qst.Main:Check(self.ID, self.STEP_085, self.STEP_088) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0502_0110_0070")
    tlk:MessageClose()
    INFO_GET_ITEM(727, 1)
    Flg.Set("FLAG_MAIN_04_088")
    Qst.Main:Set(self.ID, self.STEP_088)
    WaitFrame(60)
    FadeOutWithWait(0, 5)
    WaitFrame(25)
    tlk:EndTalk()
    Obj:new(NPC, "npc_815"):Invisible(10)
    WaitFrame(25)
    FadeInWithWait(0, 5)
  end
end

function M150:Event_175()
  if Qst.Main:Check(self.ID, self.STEP_088, self.STEP_090) then
    Qst.Main:Set(self.ID, self.STEP_090)
  end
end

function M150:Event_180()
  if Qst.Main:Check(self.ID, self.STEP_090, self.STEP_095) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-12.401, -18.487, -22.768, -11.785, -16.721, -32.592, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0502_0120_0010")
    Cam.Inst:Set(-52.48, -18.489, -43.012, -42.676, -16.692, -42.214, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0502_0120_0020")
    Cam.Inst:Set(-37.562, -19.173, -58.492, -36.156, -17.849, -49.907, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0502_0120_0030")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    WaitFrame(30)
    Qst.Main:Set(self.ID, self.STEP_095)
  end
end

function M150:Event_180AA()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_0100) and not Flg.Check("FLAG_MAIN_04_084") then
    Cam.Inst:Set(-9.748, -19.535, 6.35, -14.228, -16.956, -2.209, default, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d05", 1, true)
    local solar01_bn01 = Motion.Object:new(RUMOR_NPC, "rumor_0004", "bn01")
    local solar01_fe02 = Motion.Object:new(RUMOR_NPC, "rumor_0004", "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    solar01_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0502_0130_0010")
    local mekanori01_fe04 = Motion.Object:new(NPC, "npc_819", "fe04")
    local mekanori01_br01 = Motion.Object:new(NPC, "npc_819", "br01")
    local mekanori01_bn01 = Motion.Object:new(NPC, "npc_819", "bn01")
    local tank_bn01 = Motion.Object:new(RUMOR_NPC, "rumor_0001", "bn01")
    local tank_br01 = Motion.Object:new(RUMOR_NPC, "rumor_0001", "br01")
    local tank_fe02 = Motion.Object:new(RUMOR_NPC, "rumor_0001", "fe02")
    local mekanori = Obj:new(NPC, "npc_819")
    local tank = Obj:new(RUMOR_NPC, "rumor_0001")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    tank_br01:Play(10, true)
    tank:SetRotationY(30, 30)
    mekanori01_br01:Play(10, true)
    mekanori:SetRotationY(-30, 30)
    WaitFrame(30)
    mekanori01_bn01:Play(10, true)
    tank_bn01:Play(10, true)
    mekanori01_fe04:Play(10, true)
    tank_fe02:Play(10, true)
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 15, true)
    tlk:Message("f_d0502_0130_0020")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(10400040, BTL_MAP_VUKCANUS_PLANT, false)
  end
end

function M150:Event_180AB()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_100) and Flg.Check("FLAG_MAIN_04_084") then
    local mekanori_index = GetIndex(NPC, "npc_820")
    local tank_index = GetIndex(NPC, "npc_821")
    local solar_index = GetIndex(NPC, "npc_822")
    Field.ObjectLoadMotion(NPC, mekanori_index, "bn01")
    Field.ObjectLoadMotion(NPC, mekanori_index, "fq01")
    Field.ObjectLoadMotion(NPC, mekanori_index, "fq02")
    Field.ObjectLoadMotion(NPC, tank_index, "bn01")
    Field.ObjectLoadMotion(NPC, tank_index, "fq01")
    Field.ObjectLoadMotion(NPC, tank_index, "fq02")
    Field.ObjectLoadMotion(NPC, solar_index, "bn01")
    Field.ObjectLoadMotion(NPC, solar_index, "fq01")
    Field.ObjectLoadMotion(NPC, solar_index, "fq02")
    Cam.Inst:Set(-9.748, -19.535, 6.35, -14.228, -16.956, -2.209, default, 30)
    WaitFrame(30)
    Obj:new(NPC, "npc_819"):Invisible(30)
    Obj:new(RUMOR_NPC, "rumor_0001"):Invisible()
    Obj:new(RUMOR_NPC, "rumor_0004"):Invisible()
    Obj:new(NPC, "npc_820"):CancelInvisible(10)
    Obj:new(NPC, "npc_821"):CancelInvisible(10)
    Obj:new(NPC, "npc_822"):CancelInvisible(10)
    Flg.Set("FLAG_MAIN_04_073")
    local tlk = Tlk:new("d05", 1, true)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 15, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, tank_index, "fq02", 10, 10)
    tlk:Message("f_d0502_0130_0035")
    tlk:Message("f_d0502_0130_0030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, mekanori_index, "fq01", 10, 10)
    tlk:Message("f_d0502_0130_0040")
    local solar02_fe03 = Motion.Object:new(NPC, "npc_822", "fe03")
    solar02_fe03:Play(10, true)
    tlk:Message("f_d0502_0130_0050")
    tlk:MessageClose()
    INFO_GET_ITEM(24, 3)
    Qst.Main:Set(self.ID, self.STEP_100)
    self:Event_185(tlk)
    WaitFrame(30)
    FadeOutWithWait(0, 5)
    WaitFrame(25)
    tlk:EndTalk()
    Obj:new(NPC, "npc_820"):Invisible(10)
    Obj:new(NPC, "npc_821"):Invisible(10)
    Obj:new(NPC, "npc_822"):Invisible(10)
    Cam.Inst:Clear(30)
    WaitFrame(25)
    FadeInWithWait(0, 5)
  end
end

function M150:Event_180BA()
  local flags = {
    "FLAG_MAIN_04_081",
    "FLAG_MAIN_04_082",
    "FLAG_MAIN_04_083"
  }
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_105) and Flg.AllCheck(flags) and not Flg.Check("FLAG_MAIN_04_086") then
    Obj:new(MOB, "rumor_001"):Invisible(10)
    Obj:new(NPC, "npc_827"):CancelInvisible(10)
    Obj:new(FLD_OBJ_GIMMICK, "fa_obstacles_03"):SetEnableCheckAndFieldAttack(true)
    FieldObjectSync(FLD_OBJ_SYMBOL_ENEMY, false)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message("f_d0502_0140_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_04_086")
  end
end

function M150:Event_180BB()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_105) then
    WaitFrame(30)
    Cam.Inst:Set(-65.611, -19.535, -43.097, -55.916, -17.094, -43.312, default, 30)
    WaitFrame(30)
    local digimon_index = GetIndex(NPC, "npc_823")
    Field.ObjectLoadMotion(NPC, digimon_index, "bn01")
    Field.ObjectLoadMotion(NPC, digimon_index, "fq01")
    Field.ObjectLoadMotion(NPC, digimon_index, "fe02")
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fe02", 10, 10)
    tlk:Message("f_d0502_0140_0020")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq01", 10, 10)
    tlk:Message("f_d0502_0140_0030")
    tlk:MessageClose()
    INFO_GET_ITEM(29, 1)
    Flg.Set("FLAG_MAIN_04_071")
    Qst.Main:Set(self.ID, self.STEP_105)
    self:Event_186(tlk)
    WaitFrame(30)
    FadeOutWithWait(0, 5)
    WaitFrame(25)
    FieldObjectSync(FOR_ALL, false)
    tlk:EndTalk()
    Obj:new(NPC, "npc_823"):Invisible()
    Obj:new(NPC, "npc_827"):Invisible()
    Field_InvisibleObjects(MOB, 37, 44)
    Cam.Inst:Clear(1)
    WaitFrame(25)
    FadeInWithWait(0, 5)
  end
end

function M150:Event_180CA()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_110) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    local nani_bn01 = Motion.Object:new(NPC, "npc_824", "bn01")
    local nani_fe03 = Motion.Object:new(NPC, "npc_824", "fe03")
    nani_bn01:Play(10, true)
    tlk:Message("f_d0502_0150_0010")
    tlk:Message("f_d0502_0150_0020")
    tlk:MessageClose()
    local result = tlk:Select(2, "f_d0502_0150_0030")
    if result == RESULT_TALK00 then
      nani_fe03:Play(10, true)
      PlaySE(400017, 100)
      WaitFrame(15)
      tlk:Message("f_d0502_0150_0040")
    elseif result == RESULT_TALK01 then
      tlk:Message("f_d0502_0150_0060")
      tlk:Message("f_d0502_0150_0065")
      nani_fe03:Play(10, true)
      tlk:EndTalk()
      goto lbl_201
    end
    nani_bn01:Play(10, true)
    tlk:Message("f_d0502_0150_0050")
    result = tlk:Select(2, "f_d0502_0150_0070")
    if result == RESULT_TALK00 then
      nani_fe03:Play(10, true)
      local SEslot_1 = Sound.PlaySE(400017, 100)
      WaitFrame(15)
      local SEslot_3 = Sound.PlaySE(400017, 100)
      WaitFrame(15)
      tlk:Message("f_d0502_0150_0080")
      tlk:EndTalk()
      BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(FADE_TIME)
      WaitFrame(15)
      PlaySE(401022, 100)
      WaitFrame(15)
      local nani = Obj:new(NPC, "npc_824")
      local aegio = Obj:new(PLAYER, "")
      FieldObjectSync(FOR_ALL, false)
      nani:Invisible()
      nani:SetEnableCheckAndFieldAttack(false)
      Flg.Set("FLAG_MAIN_04_092")
      ColOff("plan_cl_0001")
      local nani2 = Obj:new(NPC, "npc_825")
      nani2:SetPos(-37.766, -19.536, -66.395)
      nani2:SetRotationY(32.948, 0)
      aegio:SetPos(-36.542, -18.322, -63.134, false)
    elseif result == RESULT_TALK01 then
      tlk:Message("f_d0502_0150_0060")
      tlk:Message("f_d0502_0150_0065")
      nani_fe03:Play(10, true)
      tlk:EndTalk()
    end
  end
  ::lbl_201::
end

function M150:Event_180CB()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_110) then
    FadeOutWithWait(0, 10)
    WaitFrame(15)
    Cam.Inst:Set(-46.171854, -19.535633, -67.187668, -36.326553, -18.542725, -65.750854, default, 10)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 300, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -37.166, -19.536, -65.554)
    FieldObjectSync(FOR_ALL, false)
    local nanimon = Obj:new(NPC, "npc_825")
    nanimon:SetPos(-38.596, -19.536, -66.593)
    nanimon:SetRotationY(120, 0)
    nanimon:SetEnableCheckAndFieldAttack(true)
    WaitFrame(30)
    FadeInWithWait(0, 30)
    local tlk = Tlk:new("d05", 1, true)
    local nani_bn01 = Motion.Object:new(NPC, "npc_825", "bn01")
    local nani_fe02 = Motion.Object:new(NPC, "npc_825", "fe02")
    local nani_fe03 = Motion.Object:new(NPC, "npc_825", "fe03")
    tlk:StartTalkAndCancelDigimonRide()
    nani_fe03:Play(10, true)
    tlk:Message("f_d0502_0150_0090")
    Motion.Player:PlayWithMoveMotion("e006", 5, 5)
    tlk:Message("f_d0502_0150_0100")
    nani_bn01:Play(10, true)
    tlk:Message("f_d0502_0150_0110")
    Motion.Player:PlayWithMoveMotion("e018", 5, 5)
    tlk:Message("f_d0502_0150_0120")
    nani_fe02:Play(10, true)
    tlk:Message("f_d0502_0150_0130")
    nani_bn01:Play(10, true)
    tlk:Message("f_d0502_0150_0140")
    Motion.Player:PlayWithMoveMotion("e033", 5, 5)
    tlk:Message("f_d0502_0150_0150")
    nani_fe02:Play(10, true)
    tlk:Message("f_d0502_0150_0160")
    nani_bn01:Play(10, true)
    tlk:Message("f_d0502_0150_0170")
    tlk:MessageClose()
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    INFO_GET_ITEM(354, 1)
    Flg.Set("FLAG_MAIN_04_072")
    Qst.Main:Set(self.ID, self.STEP_110)
    self:Event_187(tlk)
    WaitFrame(30)
    FadeOutWithWait(0, 5)
    tlk:EndTalk()
    WaitFrame(25)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Cam.Inst:Clear(30)
    WaitFrame(25)
    FadeInWithWait(0, 5)
  end
end

function M150:Event_185(tlk)
  local flags = {
    self.STEP_100,
    self.STEP_105,
    self.STEP_110
  }
  if Qst.Main:AllCheck(self.ID, flags) and not Qst.Main:Check(self.ID, self.STEP_115) then
    tlk:Message("f_d0502_0130_0060")
    tlk:MessageClose()
    INFO_GET_ITEM(727, 1)
    tlk:Message("f_d0502_0170_0010")
    tlk:Message("f_d0502_0170_0020")
    tlk:MessageClose()
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
  end
end

function M150:Event_186(tlk)
  local flags = {
    self.STEP_100,
    self.STEP_105,
    self.STEP_110
  }
  if Qst.Main:AllCheck(self.ID, flags) and not Qst.Main:Check(self.ID, self.STEP_115) then
    tlk:Message("f_d0502_0140_0050")
    tlk:MessageClose()
    INFO_GET_ITEM(727, 1)
    tlk:Message("f_d0502_0170_0010")
    tlk:Message("f_d0502_0170_0020")
    tlk:MessageClose()
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
  end
end

function M150:Event_187(tlk)
  local flags = {
    self.STEP_100,
    self.STEP_105,
    self.STEP_110
  }
  if Qst.Main:AllCheck(self.ID, flags) and not Qst.Main:Check(self.ID, self.STEP_115) then
    tlk:Message("f_d0502_0150_0180")
    tlk:MessageClose()
    INFO_GET_ITEM(727, 1)
    tlk:Message("f_d0502_0170_0010")
    tlk:Message("f_d0502_0170_0020")
    tlk:MessageClose()
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
  end
end

function M150:Event_190()
  local flags = {
    self.STEP_100,
    self.STEP_105,
    self.STEP_110
  }
  if Qst.Main:AllCheck(self.ID, flags) and not Qst.Main:Check(self.ID, self.STEP_115) then
    Qst.Main:Set(self.ID, self.STEP_115)
    Flg.Set("FLAG_GIMMICK_D05_030")
    Flg.Set("FLAG_MAIN_04_093")
  end
end

function M150:Event_195()
  if Qst.Main:Check(self.ID, self.STEP_115, self.STEP_118) then
    Qst.Main:Set(self.ID, self.STEP_118, false)
    Digimon.RestoreAllParty()
  end
end

function M150:Event_200()
  if Qst.Main:Check(self.ID, self.STEP_118, self.STEP_120) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0501_0150_0080")
    tlk:Message("f_d0501_0150_0090")
    tlk:Message("f_d0501_0150_0100")
    tlk:Message("f_d0501_0150_0110")
    FadeOutWithWait(0, 5)
    WaitFrame(25)
    tlk:EndTalk()
    Obj:new(NPC, "kokuwa_a"):Invisible(15)
    Flg.Set("FLAG_MAIN_04_094")
    SetEnableGimmickCheck("gim_0002", true)
    Guest.Delete(GST_KOKUWAMON_UN)
    Guest.Add(GST_KOKUWAMON_UN)
    Guest.Add(GST_KOKUWAMON_A)
    INFO_WINDOW(7040)
    FollowerSync()
    WaitFrame(25)
    FadeInWithWait(0, 5)
    Qst.Main:Set(self.ID, self.STEP_120)
  end
end

function M150:Event_210()
  if Qst.Main:Check(self.ID, self.STEP_120, self.STEP_125) and not Flg.Check("FLAG_MAIN_04_091") then
    Flg.Clear("TUT_FLAG_4517")
    EncountFromField(10400100, 10578, false)
  end
end

function M150:Event_220()
  if Qst.Main:Check(self.ID, self.STEP_120, self.STEP_125) and Flg.Check("FLAG_MAIN_04_091") then
    Flg.Set("TUT_FLAG_4517")
    FieldObjectSync(FOR_ALL, false)
    Execute("m150_120")
    Qst.Main:Set(self.ID, self.STEP_125)
    Digimon.RestoreAllParty()
  end
end

function M150:Event_230()
  if Qst.Main:Check(self.ID, self.STEP_125, self.STEP_130) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    Cam.Inst:Set(0.03, 2.304, 26.898, 0.317, 0.36, 36.703, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0505_0030_0010")
    local result = tlk:Select(2, "f_d0505_0030_0020")
    if result == RESULT_TALK00 then
      tlk:Message("f_d0505_0020_0010")
      tlk:Message("f_d0505_0020_0020")
      tlk:Message("f_d0505_0020_0030")
      tlk:MessageClose()
      Guest.Delete(GST_KOKUWAMON_A)
      Guest.Delete(GST_KOKUWAMON_UN)
      tlk:EndTalk()
      return true
    else
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      return false
    end
  end
end

function M150:Event_240()
  if Qst.Main:Check(self.ID, self.STEP_125, self.STEP_130) and not Flg.Check("FLAG_MAIN_04_121") then
    Field_InvisibleFollowerAllGuest(1, 0, false)
    Field_InvisibleFollowerAllPartyMember(1, 0, false)
    Execute("m150_130")
    EncountFromField_NoEffect(10400200, 10574)
  end
end

function M150:Event_250()
  if Qst.Main:Check(self.ID, self.STEP_125, self.STEP_130) and Flg.Check("FLAG_MAIN_04_121") then
    Flg.Set("FLAG_MAIN_04_123")
    FieldObjectSync(OGIM, false)
    self:Event_260()
    Digimon.RestoreAllParty()
  end
end

function M150:Event_260()
  if Qst.Main:Check(self.ID, self.STEP_125, self.STEP_130) then
    Field_CancelInvisibleFollowerAllGuest(1, 0, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(1, 0, false, false)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-29.505, 2.62, -11.998, -20.249, 4.7, -8.834, default, 45)
    WaitFrame(45)
    tlk:Message("f_d0505_0010_0010")
    Cam.Inst:Clear(45)
    WaitFrame(45)
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_130)
  end
end

function M150:Event_270()
  if Qst.Main:Check(self.ID, self.STEP_130, self.STEP_135) then
    WaitFrame(90)
    local tlk = Tlk:new("d05")
    tlk:StartTalkActionAndZoom("npc_0901")
    WaitFrame(50)
    Field_Talk_Start("d05", 1)
    tlk:Message("f_d0501_0010_0010")
    local result = tlk:Select(3, "f_d0501_0010_0020")
    if result == RESULT_TALK00 then
      tlk:Message("f_d0501_0010_0030")
    end
    if result == RESULT_TALK01 then
      tlk:Message("f_d0501_0010_0040")
    end
    if result == RESULT_TALK02 then
      tlk:Message("f_d0501_0010_0050")
    end
    tlk:Message("f_d0501_0010_0070")
    Field_Talk_End()
    tlk:EndTalkActionAndZoom()
    Map:OpenArea(102, true)
    Map:OpenArea(105, true)
    Map:OpenPlace(10201, true)
    Map:OpenPlace(10501, true)
    Flg.Set("FLAG_MAIN_04_130")
    Qst.Main:Set(self.ID, self.STEP_135)
  end
end

function M150:Event_280()
  if Qst.Main:Check(self.ID, self.STEP_135, self.STEP_140) and not Flg.Check("FLAG_MAIN_04_140") then
    Field.WaitForBeingPrepared()
    Flg.Set("FLAG_MAIN_04_140")
    Execute("m150_160")
  end
end

function M150:Event_290()
  if Qst.Main:Check(self.ID, self.STEP_135, self.STEP_140) then
    Execute("m150_170")
    Flg.Set("FLAG_MAIN_04_990")
    Flg.Set("FLAG_MAIN_04_150")
    Map:OpenArea(106, true)
    Map:OpenPlace(10606, true)
    Map:OpenPlace(10206, true)
    Qst.Main:Set(self.ID, self.STEP_140)
  end
end

function M150:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 30 <= progress then
    step[#step + 1] = self.STEP_005
    step[#step + 1] = self.STEP_006
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 45 <= progress then
    step[#step + 1] = self.STEP_020
  end
  if 80 <= progress then
    step[#step + 1] = self.STEP_025
    step[#step + 1] = self.STEP_030
  end
  if 95 <= progress then
    step[#step + 1] = self.STEP_035
  end
  if 100 <= progress then
    step[#step + 1] = self.STEP_037
    step[#step + 1] = self.STEP_040
  end
  if 101 <= progress then
    step[#step + 1] = self.STEP_045
    step[#step + 1] = self.STEP_050
  end
  if 102 <= progress then
    step[#step + 1] = self.STEP_055
    step[#step + 1] = self.STEP_058
  end
  if 103 <= progress then
    step[#step + 1] = self.STEP_060
    step[#step + 1] = self.STEP_065
    Item.Add(727, 1)
  end
  if 104 <= progress then
    step[#step + 1] = self.STEP_070
    step[#step + 1] = self.STEP_072
    step[#step + 1] = self.STEP_073
    step[#step + 1] = self.STEP_075
    Item.Delete(727, 1)
  end
  if 105 <= progress then
    step[#step + 1] = self.STEP_080
    step[#step + 1] = self.STEP_085
    step[#step + 1] = self.STEP_088
    step[#step + 1] = self.STEP_090
    Item.Add(727, 1)
  end
  if 110 <= progress then
    step[#step + 1] = self.STEP_095
    step[#step + 1] = self.STEP_100
    step[#step + 1] = self.STEP_105
    step[#step + 1] = self.STEP_110
    step[#step + 1] = self.STEP_115
    step[#step + 1] = self.STEP_118
    step[#step + 1] = self.STEP_120
  end
  if 130 <= progress then
    step[#step + 1] = self.STEP_125
  end
  if 160 <= progress then
    step[#step + 1] = self.STEP_130
    step[#step + 1] = self.STEP_135
  end
  Qst.Main:Chapter(step, self.ID)
end
