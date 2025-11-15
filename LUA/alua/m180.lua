gGimText = "field_text"
M180 = {
  ID = 180,
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
  STEP_050 = 50,
  STEP_255 = 255
}

function M180:Event_010()
  if Flg.Check("FLAG_MAIN_05_990", "FLAG_MAIN_06_000") then
    Map:OpenArea(104, true)
    Map:OpenPlace(10401, true)
    Qst.Main:Start(self.ID, self.STEP_001)
    Flg.Set("FLAG_MAIN_06_000")
    MapChangeWithTimeTravel("d", 606, "start_20", AXIS_ORIGINAL, "A2020_dbef_180", NOON)
  end
end

function M180:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check("FLAG_MAIN_06_010") then
    Execute("m180_010")
    MapChange("d", 401, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M180:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check("FLAG_MAIN_06_010") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m180_020")
    Flg.Set("FLAG_MAIN_06_010")
    Qst.Main:Set(self.ID, self.STEP_005)
    Digitter.Send(1180010010)
  end
end

function M180:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check("FLAG_MAIN_06_020") then
    Execute("m180_030")
    EncountFromField(10600010, BTL_MAP_BACCHUS_FOREST1, false)
  end
end

function M180:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_06_020") then
    FieldObjectSync(FOR_ALL, false)
    local player = Obj:new(PLAYER, "")
    local y_degree = Field.GetAngleToTarget2D(-47.61, 96.665, -44.256, 87.261)
    player:SetPos(-44.914, 2.269, 89.778, true)
    player:SetRotationY(y_degree, 0)
    SetFollowerCameraOperateRotation(0, y_degree)
    Execute("m180_040")
    WaitFrame(25)
    OpenInfoWindow(7032)
    Guest.Add(GST_PALMON)
    Common.SetDigimonGraspState(348, DIGIMON_GRASP_FLAG_SCAN)
    WaitFrame(25)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M180:Event_072()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_06_021") then
    Cam.Inst:Set(-32.486, 9.449, 65.674, -37.651, 7.426, 73.994, default, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0401_0020_0010")
    tlk:Message("f_d0401_0020_0020")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function M180:Event_075()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_06_021") then
    local tlk = Tlk:new("d04", 1, true)
    local paru00_bn02 = Motion.Object:new(NPC, "palmon_03", "bn02")
    local paru00_fe02 = Motion.Object:new(NPC, "palmon_03", "fe02")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Set(-28.285077, 5.477235, 50.64875, -28.793343, 6.215768, 60.608528, default, 1)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Flg.Set("FLAG_MAIN_06_019")
    FieldObjectSync(FOR_ALL, false)
    Motion.Player:PlayWithMoveMotion("fn01_01", 5, 5)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0401_0030_0010")
    tlk:MessageClose()
    local palmon_01 = Obj:new(NPC, "palmon_03")
    palmon_01:SetRotationYToPlayerAndAnimRun(10)
    tlk:Message("f_d0401_0030_0020")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "palmon_03"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
    paru00_bn02:Play(10, true)
    tlk:Message("f_d0401_0030_0030")
    tlk:MessageClose()
    WaitFrame(30)
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "palmon_03"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
    paru00_fe02:Play(10, true)
    tlk:Message("f_d0401_0030_0040")
    Motion.Player:PlayWithMoveMotion("e013", 5, 5)
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "palmon_03"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
    paru00_bn02:Play(10, true)
    tlk:Message("f_d0401_0030_0050")
    tlk:MessageClose()
    Flg.Set("FLAG_MAIN_06_021")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(1)
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, false)
    Motion.Player:PlayWithMoveMotion("fn01_01", 5, 5)
    Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
    Field_CancelInvisibleFollowerAllGuest(0, 0, false, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M180:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and not Flg.Check("FLAG_MAIN_06_022") then
    local tlk = Tlk:new("d04", 1, true)
    local hawk_01_bn01 = Motion.Object:new(NPC, "hawk_01", "bn01")
    local hawk_01_fe02 = Motion.Object:new(NPC, "hawk_01", "fe02")
    local hawk_01_fq01 = Motion.Object:new(NPC, "hawk_01", "fq01")
    local flora00_fq01 = Motion.Object:new(NPC, "flora_01", "fq01")
    local flora00_bn01 = Motion.Object:new(NPC, "flora_01", "bn01")
    local flora00_fe02 = Motion.Object:new(NPC, "flora_01", "fe02")
    Cam.Inst:Set(-9.38, 19.59, -35.02, -3.32, 19.7, -27.07, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_MAIN_06_022")
    tlk:Message("f_d0401_0040_0010")
    tlk:Message("f_d0401_0040_0020")
    tlk:Message("f_d0401_0040_0030")
    tlk:Message("f_d0401_0040_0040")
    flora00_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0401_0040_0050")
    flora00_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0401_0040_0060")
    tlk:Message("f_d0401_0040_0070")
    tlk:Message("f_d0401_0040_0080")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-6.214817, 17.967373, -24.710529, -2.323303, 17.597088, -15.506236, default, 45)
    WaitFrame(45)
    tlk:Message("f_d0401_0040_0090")
    tlk:Message("f_d0401_0040_0100")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M180:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    if not Flg.Check("FLAG_GIMMICK_D04_070") then
      local tlk = Tlk:new("d04", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d0401_0050_0010")
      tlk:Message("f_d0401_0050_0020")
      tlk:EndTalk()
    end
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M180:Event_091()
  if not Flg.Check("FLAG_GIMMICK_D04_030") and not Flg.Check("FLAG_MAIN_06_026") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0401_0050_0010")
    tlk:Message("f_d0401_0050_0020")
    tlk:EndTalk()
  end
end

function M180:Event_093()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_06_023") then
    SetControlScriptExternalVariable("badboys_state", "run")
    Flg.Set("FLAG_MAIN_06_023")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M180:Event_095()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_06_028") then
    Flg.Set("FLAG_MAIN_06_015")
    Flg.Set("FLAG_MAIN_06_028")
  end
end

function M180:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_06_024") then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    local hawk_bn01 = Motion.Object:new(NPC, "hawk_03", "bn01")
    local hawk_fe02 = Motion.Object:new(NPC, "hawk_03", "fe02")
    local hawk_fe04 = Motion.Object:new(NPC, "hawk_03", "fe04")
    local hawk_fq01 = Motion.Object:new(NPC, "hawk_03", "fq01")
    local flora_fq01 = Motion.Object:new(NPC, "flora_03", "fq01")
    local flora_bn01 = Motion.Object:new(NPC, "flora_03", "bn01")
    local flora_fe02 = Motion.Object:new(NPC, "flora_03", "fe02")
    local flora_fe04 = Motion.Object:new(NPC, "flora_03", "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    WaitFrame(15)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 360, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -45.797, 0.175, 72.139)
    Cam.Inst:Set(-47.50174, 3.575332, 63.71048, -44.962452, 1.460416, 73.148659, default, 1)
    Field.ObjectPlayMotion(PLAYER, 1, "e012", 10, true)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0403_0010_0010")
    flora_fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0403_0010_0020")
    Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "hawk_03"), NPC, GetIndex(NPC, "flora_03"), 30)
    tlk:Message("f_d0403_0010_0030")
    Field.ObjectResetAim(NPC, GetIndex(NPC, "hawk_03"), 10)
    Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "flora_03"), NPC, GetIndex(NPC, "hawk_03"), 30)
    flora_fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0403_0010_0040")
    Field.ObjectResetAim(NPC, GetIndex(NPC, "flora_03"), 10)
    flora_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0403_0010_0050")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_06_024")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    FieldObjectSync(FOR_ALL, false)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 10, true)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(45)
  end
end

function M180:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_06_027") then
    SetControlScriptExternalVariable("badboys_state", "run")
    Flg.Set("FLAG_MAIN_06_027")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M180:Event_115()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_06_029") then
    SetControlScriptExternalVariable("badboys_state", "run2")
    Flg.Set("FLAG_MAIN_06_029")
    Flg.Set("FLAG_MAIN_06_016")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M180:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    local flora01_bd01 = Motion.Object:new(NPC, "flora_04", "bd01")
    local flora01_fe02 = Motion.Object:new(NPC, "flora_04", "fe02")
    local flora01_fe04 = Motion.Object:new(NPC, "flora_04", "fe04")
    local hawk01_fe02 = Motion.Object:new(NPC, "hawk_04", "fe02")
    local hawk01_fq02 = Motion.Object:new(NPC, "hawk_04", "fq02")
    local hawk01_fe04 = Motion.Object:new(NPC, "hawk_04", "fe04")
    local hawk01_bn01 = Motion.Object:new(NPC, "hawk_04", "bn01")
    local tlk = Tlk:new("d04", 1, true)
    if not Flg.Check("FLAG_MAIN_06_025") then
      Flg.Set("FLAG_MAIN_06_017")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
      PlayerLookAtObject(NPC, "flora_04")
      Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 0, 0)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 40.642, 71.9, -79.201)
      Cam.Inst:Set(42.244309, 71.667488, -85.616959, 38.155293, 74.249031, -76.86396, default, 1)
      hawk01_bn01:Play(10, true)
      tlk:StartTalkAndCancelDigimonRide()
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Flg.Set("FLAG_MAIN_06_018")
      FieldObjectSync(FOR_ALL, false)
      tlk:Message("f_d0403_0020_0010")
      hawk01_fe04:Play(10, true)
      tlk:Message("f_d0403_0020_0020")
      flora01_fe04:Play(10, true)
      tlk:Message("f_d0403_0020_0030")
      local hawk_04 = Obj:new(NPC, "hawk_04")
      hawk_04:SetRotationYToCoordinateAndAnimRun(10, 19.59, 72.15, -98.565)
      hawk01_fe04:Play(10, true)
      tlk:Message("f_d0403_0500_0010")
      hawk01_fe02:Play(10, true)
      tlk:Message("f_d0403_0020_0040")
      tlk:MessageClose()
      local flora_04 = Obj:new(NPC, "flora_04")
      flora_04:SetRotationYToCoordinateAndAnimRun(10, 19.59, 72.15, -98.565)
      Cam.Inst:Set(34.774773, 73.861336, -85.19133, 42.359169, 73.030113, -78.727119, default, 45)
      PlayerLookAtObject(MOB, "mob_0010")
      WaitFrame(45)
      Field_InvisibleObjects(MOB, 1, 8)
      flora01_bd01:Play(10, true)
      tlk:Message("f_d0403_0020_0050")
      flora01_fe02:Play(10, true)
      tlk:Message("f_d0403_0020_0060")
      tlk:MessageClose()
      Cam.Inst:Set(42.244309, 71.667488, -85.616959, 38.155293, 74.249031, -76.86396, default, 45)
      hawk_04:SetRotationYToCoordinateAndAnimRun(10, 43.58, 72.15, -84.878)
      hawk01_bn01:Play(10, true)
      PlayerLookAtObject(NPC, "flora_04")
      WaitFrame(45)
      hawk01_fq02:Play(10, true)
      tlk:Message("f_d0403_0020_0070")
      flora_04:SetRotationYToPlayerAndAnimRun(10)
      WaitFrame(10)
      flora01_fe04:Play(10, true)
      tlk:Message("f_d0403_0020_0080")
      Motion.Player:Play("e013", 10, true)
      tlk:Message("f_d0403_0020_0090")
      tlk:EndTalk()
      Motion.Player:Play("fn01_01", 10, true)
      EncountFromField_PlaySound(10600020, BTL_MAP_BACCHUS_FOREST2, false)
    end
  end
end

function M180:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    local flora02_fe02 = Motion.Object:new(NPC, "flora_05", "fe02")
    local flora02_fe04 = Motion.Object:new(NPC, "flora_05", "fe04")
    local flora02_fq01 = Motion.Object:new(NPC, "flora_05", "fq01")
    local flora02_bn01 = Motion.Object:new(NPC, "flora_05", "bn01")
    local flora02_bn02 = Motion.Object:new(NPC, "flora_05", "bn02")
    local hawk02_fe02 = Motion.Object:new(NPC, "hawk_05", "fe02")
    local hawk02_fq01 = Motion.Object:new(NPC, "hawk_05", "fq01")
    local hawk02_fq02 = Motion.Object:new(NPC, "hawk_05", "fq02")
    local hawk02_fe04 = Motion.Object:new(NPC, "hawk_05", "fe04")
    local hawk02_bn01 = Motion.Object:new(NPC, "hawk_05", "bn01")
    local paru01_bn01 = Motion.Object:new(NPC, "paru_01", "bn01")
    local paru01_fq02 = Motion.Object:new(NPC, "paru_01", "fq02")
    if Flg.Check("FLAG_MAIN_06_025", "FLAG_MAIN_06_026") then
      local tlk = Tlk:new("d04", 1, true)
      Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 30, 0)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 32.452, 71.9, -89.343)
      Cam.Inst:Set(36.707809, 72.180313, -94.408592, 32.101551, 74.130699, -85.749588, default, 1)
      FieldObjectSync(FOR_ALL, false)
      tlk:StartTalkAndCancelDigimonRide()
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      tlk:Message("f_d0403_0030_0010")
      tlk:Message("f_d0403_0030_0020")
      local npc_index2 = Field.GetNpcIndex("hawk_04")
      ObjectSetRotationY(FLD_OBJ_NPC, npc_index2, 340, 0)
      tlk:Message("f_d0403_0030_0030")
      tlk:MessageClose()
      local npc_index3 = Field.GetNpcIndex("flora_04")
      ObjectSetRotationY(FLD_OBJ_NPC, npc_index3, 340, 0)
      tlk:Message("f_d0403_0030_0040")
      tlk:MessageClose()
      WaitFrame(30)
      flora02_fe02:Play(10, true)
      tlk:Message("f_d0403_0030_0050")
      tlk:Message("f_d0403_0030_0060")
      hawk02_fe02:Play(10, true)
      tlk:Message("f_d0403_0030_0070")
      tlk:Message("f_d0403_0030_0080")
      tlk:Message("f_d0403_0030_0090")
      flora02_fq01:Play(10, true)
      tlk:Message("f_d0403_0030_0100")
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
      Obj:new(NPC, "flora_05"):Invisible()
      Obj:new(NPC, "hawk_05"):Invisible()
      Obj:new(NPC, "paru_01"):SetRotationY(260, 0)
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
      paru01_fq02:Play(10, true)
      tlk:Message("f_d0403_0030_0110")
      paru01_bn01:Play(10, true)
      tlk:Message("f_d0403_0030_0120")
      tlk:Message("f_d0403_0030_0130")
      tlk:EndTalk()
      Flg.Set("FLAG_MAIN_06_026")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
      FieldObjectSync(FOR_ALL, false)
      Cam.Inst:Clear(1)
      SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
      Field.ObjectResetAim(PLAYER, 1, 10)
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    end
  end
end

function M180:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    PlayDungeonBGM()
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Guest.Delete(GST_PALMON)
    FieldObjectSync(FOR_ALL, true)
    Execute("m180_050")
    Flg.Set("FLAG_MAIN_06_030")
    Qst.Main:Set(self.ID, self.STEP_030)
    Digimon.RestoreAllParty()
  end
end

function M180:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    Flg.Set("FLAG_MAIN_06_040")
    Execute("m180_060")
    Guest.Add(GST_SIREN)
    OpenInfoWindow(7033)
    FieldObjectSync(FOR_ALL, true)
    Qst.Main:Set(self.ID, self.STEP_035)
  end
end

function M180:Event_153()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and not Flg.Check("FLAG_MAIN_06_041") then
    Obj:new(OGIM, "obj_barricade2"):CancelInvisible()
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalk()
    tlk:Message("f_d0407_0040_0010")
    Field_Talk_End()
    Flg.Set("FLAG_MAIN_06_041")
  end
end

function M180:Event_155()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_06_041", "FLAG_MAIN_06_042") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalk()
    tlk:Message("f_d0407_0040_0020")
    Field_Talk_End()
    Flg.Set("FLAG_MAIN_06_042")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M180:Event_160()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_06_042", "FLAG_MAIN_06_043") then
    Flg.Set("FLAG_MAIN_06_043")
  end
end

function M180:Event_163()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_06_043", "FLAG_MAIN_06_044") then
    Obj:new(FLD_OBJ_GIMMICK, "fa_jureimon"):SetEnableCheckAndFieldAttack(true)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalk()
    AnswerTheCall()
    tlk:Message("f_d0407_0040_0030")
    Field_Talk_End()
    EndTheCall()
    Qst.Main:Set(self.ID, self.STEP_040)
    Flg.Set("FLAG_MAIN_06_044")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M180:Event_170()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and not Flg.Check("FLAG_MAIN_06_045", "FLAG_MAIN_06_046") then
    Flg.Set("FLAG_MAIN_06_045")
    local jureimon_index = GetIndex(FLD_OBJ_GIMMICK, "fa_jureimon")
    Field.ObjectLoadMotion(FLD_OBJ_GIMMICK, jureimon_index, "fe02")
    Field.ObjectLoadMotion(FLD_OBJ_GIMMICK, jureimon_index, "bn01")
    Field.ObjectLoadMotion(FLD_OBJ_GIMMICK, jureimon_index, "br01")
    local y_degree = Field.ObjectGetRotationY(PLAYER, 1)
    SetFollowerCameraOperateRotation(-15, y_degree, 30)
    Field_InvisibleFollowerAllGuest(0, 1, true)
    Obj:new(FLD_OBJ_GIMMICK, "fa_jureimon")
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, jureimon_index, "fe02", 10, false)
    WaitFrame(45)
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, jureimon_index, "bn01", 10, true)
    WaitFrame(30)
    Field_InvisibleFollowerAllPartyMember(0, 1, true)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0407_0010_0010")
    tlk:Message("f_d0407_0010_0030")
    tlk:MessageClose()
    local jureimon = Obj:new(FLD_OBJ_GIMMICK, "fa_jureimon")
    jureimon:SetRotationYToPlayerAndAnimRun_big(46)
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, jureimon_index, "bn01", 10, true)
    tlk:Message("f_d0407_0010_0040")
    tlk:EndTalk()
    EncountFromField_PlaySound(10600050, BTL_MAP_BACCHUS_FOREST3, false)
  end
end

function M180:Event_175()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_06_046", "FLAG_MAIN_06_048") then
    Flg.Set("FLAG_MAIN_06_048")
    Digimon.RestoreAllParty()
    MapChangeWithTimeTravel("d", 407, "start_00", AXIS_ORIGINAL, "A2020_dbef_181", NOON)
  end
end

function M180:Event_178()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_06_046") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    local player_index = GetIndex(FLD_OBJ_PLAYER, "")
    local GetIndex_index = GetIndex(FLD_OBJ_GIMMICK, "fa_jureimon")
    Cam.Inst:Set(1.084563, 2.311506, 15.343401, 4.401495, 1.092329, 24.698162, default, 1)
    FieldObjectSync(FOR_ALL, false)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, player_index, 0, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, player_index, 1.876, 0, 20.206)
    Field.ObjectSetRotationY(FLD_OBJ_GIMMICK, GetIndex_index, 180, 0)
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d04", 1, true)
    local Seiren01_e007 = Motion.Object:new(RUMOR_NPC, "rumor_0033", "e007")
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0407_0020_0010")
    Seiren01_e007:Play(10, true)
    tlk:Message("f_d0407_0020_0020")
    tlk:Message("f_d0407_0020_0030")
    tlk:MessageClose()
    Flg.Set("FLAG_MAIN_06_047")
    Fade_OutNoLoadingWithWait(FADE_BLACK, 15)
    Field.HideMinimap(false)
    WaitFrame(15)
    Field_Talk_End()
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(1)
    Qst.Main:Set(self.ID, self.STEP_045)
    Obj:new(OGIM, "obj_barricade1"):Invisible()
    Obj:new(OGIM, "obj_barricade2"):Invisible()
    local fa_jureimon = Obj:new(OGIM, "fa_jureimon")
    fa_jureimon:SetEnableCheckAndFieldAttack(false)
    fa_jureimon:Invisible()
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function M180:Event_180()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and not Flg.Check("FLAG_MAIN_06_050") then
    EncountFromField(10600100, BTL_MAP_BACCHUS_SANCTUARY, false)
  end
end

function M180:Event_190()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_MAIN_06_050", "FLAG_MAIN_06_060") then
    Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):Invisible()
    Flg.Set("FLAG_FIELD_D406_CORELIGHTOFF")
    Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), "e002", 5, true)
    Flg.Set("FLAG_FIELD_D406_CORESLOW")
    Execute("m180_080")
    self:Event_200()
  end
end

function M180:Event_200()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_MAIN_06_050", "FLAG_MAIN_06_060") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Guest.Delete(GST_SIREN)
    MapChangeWithTimeTravel("d", 404, "start_00", AXIS_ORIGINAL, "A2020_dbef_182", NOON)
  end
end

function M180:Event_210()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_MAIN_06_050", "FLAG_MAIN_06_060") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    PlayDungeonBGM()
    Execute("m180_100")
    Guest.Add(GST_PALMON)
    Qst.Main:Set(self.ID, self.STEP_050)
    Flg.Set("FLAG_MAIN_06_060")
    FieldObjectSync(NPC, true)
    WaitFrame(5)
  end
end

function M180:Event_220()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_255) then
    Flg.Set("FLAG_MAIN_07_000")
    Sound.LoadBGM(309)
    Execute("m180_110")
    Sound.PlayBGM(309, 0)
    Guest.Delete(GST_PALMON)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(36)
    end
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(30)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    Qst.Main:End(self.ID, self.STEP_255)
    FieldObjectSync(FOR_ALL, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    M190:Event_005()
  end
end
