local gGimText = "field_text"
M080 = {
  ID = 80,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_010 = 10,
  STEP_011 = 11,
  STEP_012 = 12,
  STEP_015 = 15,
  STEP_016 = 16,
  STEP_018 = 18,
  STEP_019 = 19,
  STEP_020 = 20,
  STEP_021 = 21,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_255 = 255
}

function M080:Event_010()
  if Flg.Check("FLAG_MAIN_03_150", "FLAG_MAIN_03_160") then
    Flg.Set("FLAG_MAIN_03_160")
    PlayRestJingle()
    Execute("m080_010")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M080:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_03_170")
    Execute("m080_020")
    local player = Obj:new(PLAYER, "")
    SetFollowerCameraOperateRotation(5, player.rot_y + 190)
    Guest.Add(10012)
    Field.ObjectCheckSync(FOR_ALL, false)
    WaitFrame(10)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M080:Event_015()
  if Flg.Check("FLAG_MAIN_03_170", "FLAG_MAIN_03_175") then
    Flg.Set("TUT_FLAG_4726")
    Flg.Set("FLAG_MAIN_03_175")
    OpenTutorial(3026)
  end
end

function M080:Evetn_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_006) then
    Flg.Set("FLAG_MAIN_03_180")
    Cam.Inst:Set(28, -0.4, 1.42, 25.59, 1.78, 10.88, default, 30)
    START_TALK_ACTION_AND_ZOOM("npc_mother", true, false)
    WaitFrame(30)
    local npc_mother = Obj:new(NPC, "npc_mother")
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAction("npc_0001")
    npc_mother:ChangeExpression("F04", EYE_BLINK, true, 10)
    tlk:Message("f_t0303_0050_0010")
    npc_mother:ChangeExpression("F04", EYE_BLINK, false, 10)
    tlk:MessageClose()
    local result = tlk:Select(3, "f_t0303_0050_0020")
    npc_mother:ChangeExpression("F01", EYE_BLINK, true, 10)
    if result == RESULT_TALK00 then
      tlk:Message("f_t0303_0050_0030")
    end
    if result == RESULT_TALK01 then
      tlk:Message("f_t0303_0050_0040")
    end
    if result == RESULT_TALK02 then
      tlk:Message("f_t0303_0050_0050")
      tlk:Message("f_t0303_0050_0060")
    end
    npc_mother:ChangeExpression("F01", EYE_BLINK, false, 10)
    tlk:Message("f_t0303_0050_0070")
    tlk:Message("f_t0303_0050_0080")
    tlk:Message("f_t0303_0050_0090")
    npc_mother:ChangeExpression("F04", EYE_BLINK, true, 10)
    tlk:Message("f_t0303_0050_0100")
    tlk:Message("f_t0303_0050_0110")
    npc_mother:ChangeExpression("F04", EYE_BLINK, false, 10)
    tlk:EndTalkAction()
    END_TALK_ACTION_AND_ZOOM("npc_mother", true, false)
    npc_mother:ChangeExpression("F01", EYE_BLINK, false, 10)
    Cam.Inst:Clear(30)
    Field.ObjectCheckSync(FOR_ALL, true)
    SetEnableGimmickCheck("gim_0001", true)
    Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):CancelInvisible()
    Qst.Main:Set(self.ID, self.STEP_006)
  end
end

function M080:Evetn_035()
  if Qst.Main:Check(self.ID, self.STEP_006, self.STEP_010) then
    Flg.Set("FLAG_MAIN_03_181")
    SetEnableGimmickCheck("gim_0001", false)
    Cam.Inst:Set(29.037, 1.5, -7.79, 19.94, 2.5, -3.69, default, 60)
    WaitFrame(60)
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    SetEnableGimmickCheck("gim_0001", false)
    Field.InvisibleGimmick("gim_0001", 0, 0, false)
    tlk:Message("f_t0302_0090_0010")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    WaitFrame(30)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M080:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_011) then
    Flg.Set("FLAG_MAIN_03_182")
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0303_0060_0010")
    tlk:Message("f_t0303_0060_0020")
    tlk:EndTalk()
    SetEnableGimmickCheck("obj_1000", true)
    Obj:new(FLD_OBJ_LOCATOR, "obj_1000"):CancelInvisible()
    Qst.Main:Set(self.ID, self.STEP_011)
    BackFadeOutWithWait(0, FADE_TIME)
    Obj:new(NPC, "Aegio_02"):Invisible(5)
    Party.Aegiomon.SetExist(true)
    FieldObjectSync(FOR_ALL, true)
    FollowerSync()
    WaitFrame(5)
    SetPlayerLocator("start_00")
    SetPlayerLocator("sp_0001")
    WaitFrame(FADE_TIME)
    BackFadeInWithWait(0, FADE_TIME)
  end
end

function M080:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_011, self.STEP_012) then
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-0.217, 1.5, -3.12, -6.36, 2.5, 4.56, default, 60)
    WaitFrame(60)
    tlk:Message("f_t0303_0070_0010")
    tlk:Message("f_t0303_0070_0020")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    WaitFrame(30)
    SetEnableGimmickCheck("obj_1000", false)
    Field.InvisibleGimmick("obj_1000", 0, 0, false)
    SetEnableGimmickCheck("obj_1001", true)
    Obj:new(FLD_OBJ_LOCATOR, "obj_1001"):CancelInvisible()
    Flg.Set("FLAG_MAIN_03_185")
    Qst.Main:Set(self.ID, self.STEP_012)
  end
end

function M080:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_012, self.STEP_015) then
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0303_0080_0010")
    tlk:EndTalk()
    SetEnableGimmickCheck("obj_1001", false)
    Field.InvisibleGimmick("obj_1001", 0, 0, false)
    Flg.Set("FLAG_MAIN_03_186")
    self:Event_070()
  end
end

function M080:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_012, self.STEP_015) then
    Flg.Set("FLAG_MAIN_03_190")
    Execute("m080_040")
    Qst.Main:Set(self.ID, self.STEP_015)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_03_192")
  end
end

function M080:Event_077()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_016) then
    Flg.Set("FLAG_MAIN_03_191")
    local tlk = Tlk:new("d11", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1102_0140_0010")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    SetEnableGimmickCheck("obj_1001", false)
    Field.InvisibleGimmick("obj_1001", 0, 0, false)
    SetEnableGimmickCheck("obj_1002", true)
    Obj:new(FLD_OBJ_LOCATOR, "obj_1002"):CancelInvisible()
    Flg.Set("FLAG_MAIN_03_193")
    Obj:new(PLAYER, ""):SetPos(-120.745, 9.142, -63.796, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1102_0150_0010")
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_016)
  elseif Qst.Main:Check(self.ID, self.STEP_016, self.STEP_025) then
    local tlk = Tlk:new("d11", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1102_0140_0010")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    SetEnableGimmickCheck("obj_1001", false)
    Field.InvisibleGimmick("obj_1001", 0, 0, false)
    Obj:new(PLAYER, ""):SetPos(-120.745, 9.142, -63.796, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M080:Event_078()
  if Qst.Main:Check(self.ID, self.STEP_016, self.STEP_018) then
    local tlk = Tlk:new("d11", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1102_0160_0010")
    Cam.Inst:Set(-115.11, 5.545, -39.78, -124.83, 7.517, -41.02, default, 30)
    WaitFrame(60)
    tlk:EndTalk()
    SetEnableGimmickCheck("obj_1002", false)
    Field.InvisibleGimmick("obj_1002", 0, 0, false)
    SetEnableGimmickCheck("obj_1003", true)
    Obj:new(FLD_OBJ_LOCATOR, "obj_1003"):CancelInvisible()
    Flg.Set("FLAG_MAIN_03_194")
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_018)
  end
end

function M080:Event_079()
  if Qst.Main:Check(self.ID, self.STEP_018, self.STEP_019) then
    local tlk = Tlk:new("d11", 1, true)
    Flg.Set("FLAG_MAIN_03_195")
    SetEnableGimmickCheck("obj_1003", false)
    Field.InvisibleGimmick("obj_1003", 0, 0, false)
    FieldObjectSync(FOR_ALL, false)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1102_0170_0010")
    AnswerTheCall()
    tlk:Message("f_d1102_0170_0020")
    tlk:Message("f_d1102_0170_0030")
    tlk:Message("f_d1102_0170_0040")
    EndTheCall()
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_019)
  end
end

function M080:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_019, self.STEP_020) and not Flg.Check("FLAG_MAIN_03_200") then
    Execute("m080_050")
    MapChange("h", 201, "start_00", false, 0, FADE_TIME)
  end
end

function M080:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_019, self.STEP_020) and not Flg.Check("FLAG_MAIN_03_200") then
    Flg.Set("FLAG_MAIN_03_200")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m080_060")
    local pc = Obj:new(PLAYER, "")
    pc:SetRotationY(0, 0)
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M080:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_021) and not Flg.Check("FLAG_MAIN_03_210") and not Flg.Check("FLAG_MAIN_03_205") then
    Field.MovePlayerToLocatorFrame("sp_0001", 30)
    WaitFrame(30)
    Cam.Inst:Set(-12.92, -0.9, -6.08, -9.03, 2.5, 2.5, default, 30)
    WaitFrame(30)
    Flg.Set("FLAG_MAIN_03_205")
    Execute("m080_070")
    Cam.Inst:Clear(0)
    SetPlayerLocator("sp_0001")
    Qst.Main:Set(self.ID, self.STEP_021)
  end
end

function M080:Event_105()
  if Qst.Main:Check(self.ID, self.STEP_021, self.STEP_025) and not Flg.Check("FLAG_MAIN_03_210") then
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(10320200, 20272, false)
  end
end

function M080:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_021, self.STEP_025) and Flg.Check("FLAG_MAIN_03_210") then
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    Digimon.RestoreAllParty()
    MapChangeWithTimeTravel("t", 303, "start_00", AXIS_ORIGINAL, "A2020_dbef_81", EVENING)
  end
end

function M080:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_021, self.STEP_025) and Flg.Check("FLAG_MAIN_03_210") then
    Execute("m080_090")
    Qst.Main:Set(self.ID, self.STEP_025)
    Guest.Delete(GST_HEROINE)
    Party.Aegiomon.SetExist(false)
    MapChangeWithTimeTravel("t", 403, "start_01", AXIS_ORIGINAL, "A2020_dbef_82", NIGHT)
  end
end

function M080:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    local heroine = Obj:new(NPC, "npc_0030")
    heroine:Invisible(1)
    Flg.Set("FLAG_MAIN_03_215")
    WaitFrame(10)
    FadeInWithWait(0, 5)
    Qst.Main:Set(self.ID, self.STEP_030)
  end
end

function M080:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) and Flg.Check("FLAG_MAIN_03_215", "FLAG_MAIN_03_220") then
    Flg.Set("FLAG_MAIN_03_220")
    Execute("m080_110")
    Qst.Main:End(self.ID, self.STEP_255)
    Restore.Party()
    Party.Aegiomon.SetExist(false)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(6)
    end
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChangeWithTimeTravel("t", 404, "start_01", AXIS_ORIGINAL, "A2020_dbef_90", NOON)
  end
end

function M080:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 21 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 22 <= progress then
    step[#step + 1] = self.STEP_006
  end
  if 41 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_011
    step[#step + 1] = self.STEP_012
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_016
  end
  if 75 <= progress then
    step[#step + 1] = self.STEP_017
    step[#step + 1] = self.STEP_018
    step[#step + 1] = self.STEP_019
  end
  if 100 <= progress then
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_021
    step[#step + 1] = self.STEP_025
  end
  Qst.Main:Chapter(step, self.ID)
end
