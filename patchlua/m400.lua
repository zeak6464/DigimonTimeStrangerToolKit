gGimText = "field_text"
M400 = {
  ID = 400,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_040 = 40,
  STEP_045 = 45,
  STEP_255 = 255
}

function M400:Event_010()
  if Flg.Check("FLAG_MAIN_17_090", "FLAG_MAIN_18_010") then
    Flg.Set("FLAG_MAIN_18_010")
    Flg.Set("FLAG_MAIN_18_015")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Cam.Inst:Set(13.499, 1.98, 2.8, 4.748, 1.204, -1.975, default, 0)
    InitializeTheaterDoorEvt()
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(90)
    Cam.Inst:Set(-4.225, -3.355, -3.922, 4.287, 1.808, -2.984, default, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d12", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1204_0640_0010")
    tlk:Message("f_d1204_0640_0020")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    local rot = Field.ObjectGetRotationTargetY(PLAYER, 1)
    Field.SetFollowerCameraOperateRotationY(320, 0)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M400:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_18_015", "FLAG_MAIN_18_018") then
    Flg.Set("FLAG_MAIN_18_018")
    Execute("m400_010")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Map:OpenArea(101, true)
    Map:OpenPlace(10101, true)
    Qst.Main:Set(self.ID, self.STEP_005)
    MapChange("d", 201, "start_30", false, FADE_BLACK, FADE_TIME)
  end
end

function M400:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_18_018", "FLAG_MAIN_18_020") then
    Flg.Set("FLAG_MAIN_18_020")
    Guest.Add(GST_PUMPMON)
    Common.SetDigimonGraspState(596, DIGIMON_GRASP_FLAG_SCAN)
    Execute("m400_011")
    INFO_WINDOW(7047)
  end
end

function M400:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_18_022", "FLAG_MAIN_18_023") then
    Flg.Set("FLAG_MAIN_18_023")
    local S_e002 = Motion.Object:new(NPC, "npc_0003", "e002")
    local S_fe04 = Motion.Object:new(NPC, "npc_0003", "fe04")
    local S_bn01 = Motion.Object:new(NPC, "npc_0003", "bn01")
    local U_e002 = Motion.Object:new(NPC, "npc_0002", "e002")
    local P_fe02 = Motion.Object:new(NPC, "npc_0006", "fe02")
    local P_fq01 = Motion.Object:new(NPC, "npc_0006", "fq01")
    local P_e002 = Motion.Object:new(NPC, "npc_0006", "e002")
    local P_bn01 = Motion.Object:new(NPC, "npc_0006", "bn01")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(0.196, 0.149, -44.025, 0.584, 1.597, -34.138, default, 0)
    FieldObjectSync(NPC, false)
    Obj:new(PLAYER, ""):SetPos(0.624, -0.203, -36.245, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    WaitFrame(1)
    local rotY = Field.ObjectGetRotationY(PLAYER, 1)
    SetFollowerCameraOperateRotation(0, rotY + 5, 0)
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    U_e002:Play(10, true)
    tlk:Message("f_d0101_0040_0010")
    S_bn01:Play(10, true)
    P_fe02:Play(10, true)
    tlk:Message("f_d0101_0040_0030")
    P_bn01:Play(10, true)
    tlk:Message("f_d0101_0040_0040")
    P_fq01:Play(10, true)
    tlk:Message("f_d0101_0040_0050")
    P_bn01:Play(10, true)
    U_e002:Play(10, true)
    tlk:Message("f_d0101_0040_0070")
    P_e002:Play(10, true)
    tlk:Message("f_d0101_0040_0080")
    S_e002:Play(10, true)
    tlk:Message("f_d0101_0040_0090")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_18_057")
    Cam.Inst:Clear(30)
    Obj:new(NPC, "npc_0006"):Invisible(15)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M400:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_18_023", "FLAG_MAIN_18_024") then
    Flg.Set("FLAG_MAIN_18_024")
    local tlk = Tlk:new("d01", 1, true)
    local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0101_0050_0010")
    tlk:Message("f_d0101_0050_0020")
    tlk:Message("f_d0101_0050_0040")
    tlk:EndTalk()
    SetFollowerCameraOperateRotation(0, rot, 0)
    Cam.Inst:Clear(30)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "elv_0001"), true)
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M400:Event_055()
  if Flg.Check("FLAG_MAIN_18_023", "FLAG_MAIN_18_027") then
    Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
    WaitFrame(10)
    local P_fq02 = Motion.Object:new(NPC, "npc_003", "fq02")
    Obj:new(PLAYER, ""):SetPos(71.637, -1.677, 47.261, true)
    Obj:new(PLAYER, ""):SetRotationY(280, 0)
    Cam.Inst:Set(65.245, 1.022, 42.837, 74.044, -0.816, 47.218, default, 0)
    Obj:new(NPC, "npc_003"):CancelInvisible()
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    P_fq02:Play(10, true)
    tlk:Message("f_d0106_0010_0010")
    tlk:Message("f_d0106_0010_0020")
    tlk:EndTalk()
    Obj:new(NPC, "npc_003"):Invisible(15)
    MapChange("d", 101, "start_01", true, FADE_BLACK, FADE_TIME)
  end
end

function _ENV:M400_055_90()
  M400:Event_055()
  M400:Event_090()
end

function M400:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_18_024", "FLAG_MAIN_18_025") then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    local P_e002 = Motion.Object:new(NPC, "npc_0001", "e002")
    Obj:new(PLAYER, ""):SetPos(-71.627, -1.979, 47.309, true)
    Obj:new(PLAYER, ""):SetRotationY(80, 0)
    Flg.Set("FLAG_MAIN_18_025")
    Cam.Inst:Set(-65.411, 0.52, 43.232, -74.427, -1.29, 47.162, default, 0)
    Obj:new(NPC, "npc_0001"):CancelInvisible()
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    P_e002:Play(10, true)
    tlk:Message("f_d0102_0010_0010")
    tlk:Message("f_d0102_0010_0020")
    tlk:EndTalk()
    Obj:new(NPC, "npc_0001"):Invisible(15)
    Cam.Inst:Clear(30)
  end
end

function _ENV:M400_060()
  M400:Event_060()
end

function M400:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_18_025", "FLAG_MAIN_18_026") then
    FieldObjectSync(NPC, false)
    Cam.Inst:Set(4.651, -14.57, 56.15, 9.704, -11.44, 64, default, 20)
    WaitFrame(30)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    local P_e002 = Motion.Object:new(NPC, "npc_0001", "e002")
    local P_e021 = Motion.Object:new(NPC, "npc_0001", "e021")
    tlk:Message("f_d0103_0010_0010")
    tlk:Message("f_d0103_0010_0020")
    P_e002:Play(10, true)
    tlk:Message("f_d0103_0010_0030")
    P_e021:Play(10, true)
    tlk:Message("f_d0103_0010_0040")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_18_026")
    FieldObjectSync(NPC, true)
    Cam.Inst:Clear(30)
  end
end

function M400:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_18_025", "FLAG_MAIN_18_027") then
    Flg.Set("FLAG_MAIN_18_027")
    Cam.Inst:Set(-80.604, 21.041, -49.633, -76.721, 22.373, -40.515, default, 30)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0103_0020_0010")
    tlk:Message("f_d0103_0020_0020")
    tlk:Message("f_d0103_0020_0030")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M400:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_18_027", "FLAG_MAIN_18_028") then
    Flg.Set("FLAG_MAIN_18_028")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    local P_e002 = Motion.Object:new(NPC, "npc_003", "e002")
    Obj:new(PLAYER, ""):SetPos(71.637, -1.677, 47.261, false)
    Obj:new(PLAYER, ""):SetRotationY(280, 0)
    Cam.Inst:Set(65.245, 1.022, 42.837, 74.044, -0.816, 47.218, default, 0)
    Obj:new(NPC, "npc_003"):CancelInvisible()
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    P_e002:Play(10, true)
    tlk:Message("f_d0106_0020_0010")
    tlk:Message("f_d0106_0020_0020")
    tlk:EndTalk()
    Obj:new(NPC, "npc_003"):Invisible(15)
    Cam.Inst:Clear(30)
  end
end

function M400:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_18_028", "FLAG_MAIN_18_029") then
    Flg.Set("FLAG_MAIN_18_029")
    Field.ObjectFrameMoveToTarget2D(PLAYER, 1, -84.204, 36.229, 6.5, 60)
    WaitFrame(60)
    SetFollowerCameraOperateRotation(5, 140, 30)
    PlayerTurnToObject(FLD_OBJ_GIMMICK, "ice_crystal_01", true, false, 0, 0)
    WaitFrame(30)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0107_0010_0005")
    tlk:MessageClose()
    Cam.Inst:Set(-19.522, -9.672, 108.522, -27.389, -8.435, 102.473, default, 50)
    WaitFrame(60)
    tlk:Message("f_d0107_0010_0010")
    tlk:EndTalk()
    Cam.Inst:Clear(50)
    WaitFrame(40)
  end
end

function M400:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_18_029", "FLAG_MAIN_18_029A") then
    Flg.Set("FLAG_MAIN_18_029A")
    Cam.Inst:Set(-78.847, 4.013, 29.547, -84.172, 2.046, 37.78, default, 50)
    local tlk = Tlk:new("d01", 1, true)
    local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0107_0010_0020")
    tlk:Message("f_d0107_0010_0030")
    tlk:MessageClose()
    Cam.Inst:Set(-68.519, 0.463, 26.594, -78.183, 2.89, 25.754, default, 30)
    WaitFrame(30)
    PlayerTurnToObject(FLD_OBJ_GIMMICK, "gear_access_01", false, false, 0, 0)
    SetFollowerCameraOperateRotation(0, 90, 0)
    tlk:Message("f_d0107_0010_0040")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    WaitFrame(30)
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M400:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and Flg.Check("FLAG_MAIN_18_029A", "FLAG_MAIN_18_029B") then
    local pamp = GetIndex(NPC, "npc_005")
    local pamp_e002 = Motion.Object:new(NPC, "npc_005", "e002")
    Field.ObjectLoadMotionBlend(PLAYER, 1, "blend01")
    Flg.Set("FLAG_GIMMICK_D01_250")
    FieldObjectSync(NPC, true)
    PlayerObjectResetAim()
    Cam.Inst:Set(-64.29, 0.016, 24.37, -55.23, 1.866, 28.18, default, 30)
    PlayerTurnToObject(NPC, "npc_005", true, false, 0, 0)
    WaitFrame(15)
    Field.ObjectLookAtTheObject(NPC, pamp, PLAYER, 1, 10)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0107_0010_0050")
    tlk:MessageClose()
    Field.ObjectPlayMotionBlend(PLAYER, 1, "blend01", 10, false)
    WaitFrame(30)
    PlayerTurnToObject(FLD_OBJ_GIMMICK, "gear_access_01", true, false, 0, 0)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
    WaitFrame(15)
    Cam.Inst:Set(-58.15, 2.52, 17.41, -57.39, 5.73, 7.97, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0106_0030_0010")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_WHITE, 10)
    WaitFrame(12)
    PlaySE(202005, 100)
    Motion.Gimmick:Play("gim_0003", "e002", false)
    Field.PlayAndManageSE(200017, 100, 5, 1, true, true)
    WaitFrame(45)
    Field.PlayEffectScript("ef_f_dun_136_ic", -60.535, -0.5, 25.974, 0, 2)
    Field.PlayEffectScript("ef_f_dun_136_ic", -50.713, -0.183, 35.286, 0, 3)
    FadeInWithWaitNotFlgCheck(FADE_WHITE, 10)
    SetControlScriptExternalVariable("elv_0008_se", "stop")
    SetControlScriptExternalVariable("elv_0008", "move")
    WaitFrame(100)
    Fade_OutNoLoadingWithWait(FADE_BLACK, 15)
    WaitFrame(10)
    Cam.Inst:Set(-62.883, 3.116, 23.463, -57.965, 0.387, 31.731, default, 0)
    PlayerObjectResetAim()
    Obj:new(PLAYER, ""):SetRotationY(330, 0)
    Obj:new(NPC, "npc_005"):SetRotationY(330, 0)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, 15)
    WaitFrame(105)
    Field.StopManageSE(1, 5)
    PlaySE(200010, 100)
    pamp_e002:Play(10, true)
    tlk:Message("f_d0107_0010_0060")
    tlk:EndTalk()
    ColOff("wall_cl_9000")
    ColOff("wall_cl_9001")
    ColOff("wall_cl_9002")
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "gear_access_01"), false)
    Flg.Set("FLAG_MAIN_18_029B")
    Cam.Inst:Clear(30)
    FieldObjectSync(NPC, true)
    Qst.Main:Set(self.ID, self.STEP_030)
  end
end

function M400:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_18_029B", "FLAG_MAIN_18_029C") then
    Flg.Set("FLAG_MAIN_18_029C")
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0107_0020_0010")
    tlk:Message("f_d0107_0020_0020")
    tlk:Message("f_d0107_0020_0030")
    tlk:EndTalk()
  end
end

function M400:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_18_029B", "FLAG_MAIN_18_029D") then
    local pamp = GetIndex(NPC, "npc_006")
    local pamp_fe02 = Motion.Object:new(NPC, "npc_006", "fe02")
    local pamp_e021 = Motion.Object:new(NPC, "npc_006", "e021")
    Field.ObjectLoadMotionBlend(PLAYER, 1, "blend01")
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_GIMMICK_D01_090")
    FieldObjectSync(NPC, true)
    Cam.Inst:Set(109.079, 21.545, 16.001, 99.316, 20.585, 14.06, default, 30)
    WaitFrame(15)
    PlayerObjectResetAim()
    PlayerTurnToObject(NPC, "npc_006", true, false, 0, 0)
    Field.ObjectLookAtTheObject(NPC, pamp, PLAYER, 1, 10)
    tlk:Message("f_d0107_0030_0010")
    tlk:MessageClose()
    Field.ObjectPlayMotionBlend(PLAYER, 1, "blend01", 10, false)
    WaitFrame(30)
    local index = GetIndex(FLD_OBJ_LOCATOR, "obj_0001")
    local index2 = GetIndex(FLD_OBJ_LOCATOR, "obj_0002")
    local pos = Field.ObjectGetPosition(FLD_OBJ_LOCATOR, index2)
    local y_degree = Field.ObjectGetRotationY(FLD_OBJ_LOCATOR, index2)
    PlayerTurnToObject(FLD_OBJ_GIMMICK, "icepiller00_01", true, false, 0, 0)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
    WaitFrame(25)
    tlk:Message("f_d0106_0030_0010")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_WHITE, 15)
    WaitFrame(10)
    PlaySE(202005, 100)
    Cam.Inst:Set(108.597, 23.637, 12.016, 96.962, 20.551, 8.711, default, 0)
    Obj:new(FLD_OBJ_GIMMICK, "icepiller00_01"):Invisible()
    WaitFrame(5)
    Field.PlayEffectScript("ef_f_dun_136_ic", 116.723, 19.045, 18.922, 0, 4.5)
    FadeInWithWaitNotFlgCheck(FADE_WHITE, 15)
    Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, index, "e001", 5, false)
    WaitFrame(15)
    local slot1 = PlaySE(202002, 100)
    Quake.Start(0, 0.5, 5)
    WaitFrame(5)
    StopSE(slot1, 1)
    local slot2 = PlaySE(202007, 100)
    Quake.Start(0, 0.25, 120)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_WHITE, 15)
    WaitFrame(15)
    Quake.Stop()
    Cam.Inst:Set(5.968, -0.314, 78.148, 13.931, 3.756, 70.122, default, 0)
    Field.ObjectSetPos(FLD_OBJ_LOCATOR, index, -8.813, 7.38, 96.365997)
    Field.ObjectPlayMotionAndSetting(FLD_OBJ_LOCATOR, index, "e001", 5, 15, 15, 90, 1, false)
    WaitFrame(1)
    Quake.Start(0, 0.25, 60)
    FadeInWithWaitNotFlgCheck(FADE_WHITE, 15)
    StopSE(slot2, 1)
    WaitFrame(1)
    PlaySE(202001, 100)
    PlayEffectScript("ef_f_com_300_sm", pos.x, pos.y, pos.z, y_degree, 5)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_WHITE, 15)
    WaitFrame(20)
    Quake.Stop()
    FieldObjectSync(OGIM, false)
    Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):CancelInvisible()
    Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, index2, 0, "e001")
    Obj:new(PLAYER, ""):SetPos(108.396, 19.595, 17.86, true)
    Obj:new(PLAYER, ""):SetRotationY(260, 0)
    Obj:new(NPC, "npc_006"):SetPos(107.554, 19.595, 16.906, true)
    Obj:new(NPC, "npc_006"):SetRotationY(260, 0)
    Field.ObjectInvisible(FLD_OBJ_LOCATOR, index, 0, 0, true)
    ColOff("plan_cl_1000")
    Cam.Inst:Set(109.205, 21.545, 16.005, 115.578, 24.16, 8.757, default, 0)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_WHITE, 15)
    WaitFrame(15)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "ice_access_01"), false)
    tlk:EndTalk()
  end
end

function M400:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_18_029B", "FLAG_MAIN_18_029D") then
    local pamp = GetIndex(NPC, "npc_006")
    local pamp_e002 = Motion.Object:new(NPC, "npc_006", "e002")
    local pamp_bn01 = Motion.Object:new(NPC, "npc_006", "bn01")
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    pamp_e002:Play(10, true)
    tlk:Message("f_d0107_0030_0040")
    tlk:Message("f_d0107_0030_0050")
    tlk:EndTalk()
    local rotY = Field.ObjectGetRotationY(PLAYER, 1)
    SetFollowerCameraOperateRotation(0, rotY - 10, 0)
    Flg.Set("FLAG_MAIN_18_029D")
    Cam.Inst:Clear(30)
    FieldObjectSync(NPC, true)
  end
end

function M400:Event_160()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_18_029D", "FLAG_MAIN_18_029E") then
    Flg.Set("FLAG_MAIN_18_029E")
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    PlayerTurnToObject(FLD_OBJ_GIMMICK, "ice_crystal_01", true, false, 0, 0)
    WaitFrame(15)
    PlayerObjectResetAim()
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
    WaitFrame(25)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "ice_crystal_01"), false)
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "ice_crystal_01"), "e001", 15, true)
    WaitFrame(20)
    INFO_GET_ITEM(792, 1)
    tlk:Message("f_d0107_0030_0060")
    tlk:Message("f_d0107_0030_0070")
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_035)
    MapChange("d", 101, "start_01", true, FADE_BLACK, FADE_TIME)
  end
end

function M400:Event_170()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_18_029E", "FLAG_MAIN_18_029F") then
    Obj:new(NPC, "npc_0002"):Invisible(0)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0103_0030_0010")
    tlk:EndTalk()
  end
end

function M400:Event_180()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_18_029E", "FLAG_MAIN_18_029F") then
    local pamp = GetIndex(NPC, "npc_0002")
    local pamp_e002 = Motion.Object:new(NPC, "npc_0002", "e002")
    local pamp_fe02 = Motion.Object:new(NPC, "npc_0002", "fe02")
    Field.ObjectLookAtTheObject(NPC, pamp, PLAYER, 1, 10)
    Prcs_d01_FireExtinguishingNoMessage(OGIM, "obj_bigfirewall_01", 3)
    WaitFrame(20)
    Obj:new(NPC, "npc_0002"):CancelInvisible(30)
    Cam.Inst:Set(-83.24, 18.936, -54.59, -78.73, 20.48, -45.8, default, 30)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, pamp, 10)
    pamp_e002:Play(10, true)
    tlk:Message("f_d0103_0030_0030")
    tlk:Message("f_d0103_0030_0040")
    pamp_fe02:Play2Wait(10, false)
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_18_029F")
    FieldObjectSync(NPC, true)
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_040)
  end
end

function M400:Event_190()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_18_029F", "FLAG_MAIN_18_029G") then
    Cam.Inst:Set(-40.49, 27.14, -3.53, -45.65, 28.86, 4.92, default, 0)
    WaitFrame(5)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0104_0010_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_18_029G")
    WaitFrame(10)
    Cam.Inst:Clear(30)
    SetControlScriptExternalVariable("enemy_001_state", "start")
    SetControlScriptExternalVariable("enemy_002_state", "start")
    SetControlScriptExternalVariable("enemy_003_state", "start")
    SetControlScriptExternalVariable("enemy_007_state", "start")
  end
end

function M400:Event_200()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_18_029G", "FLAG_MAIN_18_029H") then
    Cam.Inst:Set(99.6, 62.73, -70.06, 91.58, 62.85, -64.09, default, 0)
    WaitFrame(5)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0104_0010_0020")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_18_029H")
    WaitFrame(10)
    Cam.Inst:Clear(30)
    SetControlScriptExternalVariable("enemy_004_state", "start")
    SetControlScriptExternalVariable("enemy_005_state", "start")
    SetControlScriptExternalVariable("enemy_006_state", "start")
    SetControlScriptExternalVariable("enemy_008_state", "start")
    SetControlScriptExternalVariable("enemy_009_state", "start")
  end
end

function M400:Event_210()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_18_029H", "FLAG_MAIN_18_029I") then
    Flg.Set("FLAG_GIMMICK_D01_290")
    local tlk = Tlk:new("d01", 1, true)
    local fe04 = Motion.Object:new(NPC, "npc_001", "fe04")
    Cam.Inst:Set(91.28, 63.29, -94.41, 94.86, 61.3, -85.28, default, 30)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0104_0020_0010")
    tlk:Message("f_d0104_0020_0020")
    fe04:Play(10, true)
    tlk:Message("f_d0104_0020_0030")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(11500010, 10178, false)
  end
end

function M400:Event_220()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_18_029I", "FLAG_MAIN_18_029J") then
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_18_029J")
    FieldObjectSync(FOR_ALL, false)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0104_0020_0050")
    tlk:Message("f_d0104_0020_0060")
    tlk:EndTalk()
  end
end

function M400:Event_230()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_18_029J", "FLAG_MAIN_18_030") then
    Flg.Clear("FLAG_GIMMICK_D01_020")
    Flg.Clear("FLAG_GIMMICK_D01_030")
    EncountFromField(11500100, 10174, false)
  end
end

function M400:Event_240()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_18_030", "FLAG_MAIN_18_040") then
    Flg.Set("FLAG_MAIN_18_040")
    Digimon.RestoreAllParty()
    FieldObjectSync(FOR_ALL, false)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    SetFollowerCameraOperateRotation(-5, 0, 0)
    WaitFrame(1)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Talk.NextNoVoice()
    tlk:Message("f_d0105_0010_0010")
    Talk.NextNoVoice()
    tlk:Message("f_d0105_0010_0020")
    Qst.Main:Set(self.ID, self.STEP_045)
    tlk:EndTalk()
    MapChange("d", 103, "start_01", true, FADE_BLACK, FADE_TIME)
  end
end

function M400:Event_250()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_040", "FLAG_MAIN_18_041") then
    Flg.Set("FLAG_MAIN_18_041")
    local index = GetIndex(NPC, "npc_0003")
    Field.ObjectLoadMotion(NPC, index, "fe02")
    Field.ObjectLoadMotion(NPC, index, "e209")
    local aporo_pos = Field.ObjectGetPosition(NPC, index)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-74.74, 23.062, -40.719, -82, 25.201, -47.256, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0103_0040_0010")
    tlk:MessageClose()
    SetControlScriptExternalVariable("aporo_npc0003", "start_fe02")
    WaitFrame(10)
    Cam.Inst:Set(-47.624, 19.694, -16.375, -55.358, 21.536, -22.442, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0103_0040_0020")
    tlk:MessageClose()
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    SetControlScriptExternalVariable("aporo_npc0003", "end")
    Obj:new(NPC, "npc_0003"):Invisible()
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(0)
    Field.SetFollowerCameraOperateRotationY(140, 0)
    tlk:EndTalk()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    SetControlScriptExternalVariable("aporo_npc0003", "end")
  end
end

function M400:Event_260()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_041", "FLAG_MAIN_18_042") then
    Flg.Set("FLAG_MAIN_18_042")
    SetControlScriptExternalVariable("aporo_npc0004", "start")
    FieldObjectSync(FOR_ALL, false)
    local index = GetIndex(NPC, "npc_0004")
    Field.ObjectLoadMotion(NPC, index, "fe02")
    Field.ObjectLoadMotion(NPC, index, "e209")
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    Field.SetFollowerCameraOperateRotationY(140, 30)
    Field.SetFollowerCameraOperateRotationX(5, 30)
    WaitFrame(30)
    tlk:Message("f_d0103_0050_0010")
    tlk:MessageClose()
    SetControlScriptExternalVariable("aporo_npc0004", "start_fe02")
    WaitFrame(15)
    Cam.Inst:Set(106.227, 4.65, 104.245, 97.673, 6.409, 99.372, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0103_0050_0020")
    tlk:MessageClose()
    Flg.Set("FLAG_MAIN_18_049")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    SetControlScriptExternalVariable("aporo_npc0004", "end")
    Obj:new(NPC, "npc_0004"):Invisible()
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(0)
    Field.SetFollowerCameraOperateRotationY(140, 0)
    tlk:EndTalk()
    SetControlScriptExternalVariable("aporo_npc0004", "end")
    Flg.Set("FLAG_GIMMICK_D01_020")
    Flg.Set("FLAG_GIMMICK_D01_030")
    Flg.Set("FLAG_GIMMICK_D01_340")
    MapChange("d", 101, "start_01", false, FADE_BLACK, FADE_TIME)
  end
end

function M400:Event_270()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_042", "FLAG_MAIN_18_043") then
    WaitFrame(30)
    Cam.Inst:Set(-0.007, 0.273, -48.76, -0.016, 1.455, -38.83, default, 30)
    WaitFrame(30)
    Flg.Set("FLAG_MAIN_18_043")
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0101_0060_0010")
    tlk:Message("f_d0101_0060_0020")
    tlk:Message("f_d0101_0060_0030")
    Cam.Inst:Clear(30)
    tlk:EndTalk()
  end
end

function M400:Event_280()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_043", "FLAG_MAIN_18_044") then
    Cam.Inst:Set(89.43, 26.97, -67.3, 81.72, 27.19, -60.94, default, 30)
    Flg.Set("FLAG_MAIN_18_044")
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0107_0040_0010")
    tlk:Message("f_d0107_0040_0020")
    Cam.Inst:Clear(30)
    tlk:EndTalk()
  end
end

function M400:Event_290()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_044", "FLAG_MAIN_18_045") then
    Flg.Set("FLAG_MAIN_18_045")
    Cam.Inst:Set(42.3, 11.544, -0.31, 48.55, 14.85, 6.75, default, 0)
    WaitFrame(5)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0108_0010_0010")
    tlk:EndTalk()
    WaitFrame(10)
    Cam.Inst:Clear(30)
    SetControlScriptExternalVariable("mpenmons_state1", "start")
  end
end

function M400:Event_300()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_045", "FLAG_MAIN_18_046") then
    Flg.Set("FLAG_MAIN_18_046")
    Cam.Inst:Set(13.797, 18.834, -27.788, 11.778, 21.286, -18.305, default, 0)
    WaitFrame(5)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0108_0030_0010")
    tlk:EndTalk()
    WaitFrame(10)
    Cam.Inst:Clear(30)
    SetControlScriptExternalVariable("mpenmons_state4", "start")
  end
end

function M400:Event_310()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_046", "FLAG_MAIN_18_047") then
    Flg.Set("FLAG_GIMMICK_D01_300")
    local tlk = Tlk:new("d01", 1, true)
    local fe04 = Motion.Object:new(NPC, "npc_001", "fe04")
    local fe02 = Motion.Object:new(NPC, "npc_001", "fe02")
    Cam.Inst:Set(-48.35, 29.66, 18.67, -41.18, 28.76, 11.76, default, 30)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0108_0040_0010")
    tlk:Message("f_d0108_0040_0020")
    fe04:Play(10, true)
    tlk:Message("f_d0108_0040_0030")
    fe02:Play(10, true)
    tlk:Message("f_d0108_0040_0050")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(11700010, 10176, true)
  end
end

function M400:Event_320()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_047", "FLAG_MAIN_18_048") then
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_18_048")
    FieldObjectSync(FOR_ALL, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0108_0050_0010")
    tlk:Message("f_d0108_0050_0020")
    tlk:EndTalk()
  end
end

function M400:Event_330()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_048", "FLAG_MAIN_18_050") then
    Execute("m400_020")
    Guest.Add(GST_APOLLO)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(11700100, 10177, true)
  end
end

function M400:Event_340()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_18_050", "FLAG_MAIN_18_055") then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(90)
    end
    Flg.Set("FLAG_MAIN_18_055")
    Flg.Set("FLAG_FREEARENA_RELEASE_010")
    Cam.Inst:Clear(0)
    Flg.Clear("FLAG_FIELD_D01_010")
    Execute("m400_040")
    Guest.Add(GST_DIANA)
    Qst.Main:End(self.ID, self.STEP_255)
    Common.SetDigimonGraspState(173, DIGIMON_GRASP_FLAG_SCAN)
    Common.SetDigimonGraspState(733, DIGIMON_GRASP_FLAG_SCAN)
    Flg.Clear("FLAG_GIMMICK_D01_020")
    Flg.Clear("FLAG_GIMMICK_D01_030")
    Flg.Clear("FLAG_GIMMICK_D01_040")
    Flg.Clear("FLAG_GIMMICK_D01_050")
    Flg.Clear("FLAG_GIMMICK_D01_100")
    Flg.Set("FLAG_GIMMICK_D01_160")
    Flg.Set("FLAG_GIMMICK_D01_170")
    Flg.Set("FLAG_GIMMICK_D01_180")
    Flg.Set("FLAG_GIMMICK_D01_310")
    MapChangeWithTimeTravel("d", 101, "start_03", AXIS_ORIGINAL, "A2028_daft_410", NOON)
  end
end

function M400:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 30 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 36 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 37 <= progress then
    step[#step + 1] = self.STEP_015
  end
  if 38 <= progress then
    step[#step + 1] = self.STEP_020
  end
  if 39 <= progress then
    step[#step + 1] = self.STEP_025
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_030
    step[#step + 1] = self.STEP_035
  end
  if 41 <= progress then
    step[#step + 1] = self.STEP_040
  end
  if 61 <= progress then
    step[#step + 1] = self.STEP_045
  end
  Qst.Main:Chapter(step, self.ID)
end
