local gGimText = "field_text"
M020 = {
  ID = 20,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_013 = 13,
  STEP_015 = 15,
  STEP_016 = 16,
  STEP_017 = 17,
  STEP_018 = 18,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_060 = 60,
  STEP_065 = 65,
  STEP_070 = 70,
  STEP_072 = 72,
  STEP_075 = 75,
  STEP_076 = 76,
  STEP_080 = 80,
  STEP_085 = 85,
  STEP_090 = 90,
  STEP_095 = 95,
  STEP_100 = 100,
  STEP_102 = 102,
  STEP_105 = 105,
  STEP_255 = 255,
  Battle = {
    Enemy = {e01 = 10110100},
    Map = {m01 = 11072}
  }
}

function M020:Event_010()
  if not Qst.Main:Check(self.ID, self.STEP_001) and Flg.Check("FLAG_MAIN_01_110") then
    Flg.Set("FLAG_MAIN_01_120")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M020:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    if not Flg.Check("FLAG_MAIN_01_130") then
      local npc_0010 = Obj:new(NPC, "npc_0010")
      local e002 = Motion.Object:new(NPC, "npc_0010", "e002")
      local e008 = Motion.Object:new(NPC, "npc_0010", "e008")
      local e012 = Motion.Object:new(NPC, "npc_0010", "e012")
      local _ = Motion.Object:new(NPC, "npc_0010", "fn01_01")
      local tlk = Tlk:new("d10", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      e008:PlayWithStartMoveMotion(10, 10)
      npc_0010:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_d1001_0030_0010")
      e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message("f_d1001_0030_0020")
      e012:Play(10, true)
      npc_0010:ResetExporession(10)
      tlk:EndTalk()
      Flg.Set("FLAG_MAIN_01_130")
      Qst.Main:Set(self.ID, self.STEP_005)
      local obj = Obj:new(FLD_OBJ_LOCATOR, "gim_0004")
      obj:SetEnableGimmick(true)
      Field.ObjectOverwriteFieldAttackableRange(obj.type, obj.index, 0, 0, 0)
    else
      local npc_0010 = Obj:new(NPC, "npc_0010")
      local e002 = Motion.Object:new(NPC, "npc_0010", "e002")
      local tlk = Tlk:new("d10")
      tlk:StartTalkAndCancelDigimonRide()
      npc_0010:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_d1001_0030_0030")
      npc_0010:ResetExporession(10)
      tlk:EndTalk()
    end
  end
end

function M020:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_105) then
    local tlk = Tlk:new("d10", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1001_0010_0010")
    MovePlayerToRelativePosFrame(0.5, -2, 15)
    tlk:EndTalk()
  end
end

function M020:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_105) then
    local tlk = Tlk:new("d10", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1001_0010_0010")
    MovePlayerToRelativePosFrame(-0.5, 2, 15)
    tlk:EndTalk()
  end
end

function M020:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Qst.Main:Set(self.ID, self.STEP_010)
    Flg.Set("FLAG_MAIN_01_140")
    local obj = Obj:new(FLD_OBJ_LOCATOR, "gim_0004")
    obj:SetEnableCheckAndFieldAttack(true)
    Field.ObjectClearOverwriteFieldAttackableRange(obj.type, obj.index)
  end
end

function M020:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Flg.Set("FLAG_MAIN_01_150")
    local heroine = Obj:new(NPC, "npc_0010")
    local hr_e002 = Motion.Object:new(heroine.type, heroine.name, "e002")
    local hr_e006 = Motion.Object:new(heroine.type, heroine.name, "e006")
    local hr_e007 = Motion.Object:new(heroine.type, heroine.name, "e007")
    hr_e006:Play(15, true)
    Cam.Inst:Set(-36.861, -1.96, 7.07, -27.26, 0.172, 8.881, default, 30)
    WaitFrame(60)
    local tlk = Tlk:new("d10", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    hr_e007:Play(15, true)
    tlk:Message("f_d1001_0030_0040")
    hr_e002:Play(15, false)
    tlk:Message("f_d1001_0030_0050")
    Guest.Add(GST_HEROINE)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(FADE_TIME)
    tlk:EndTalk()
    Cam.Inst:Clear(0)
    FollowerSync()
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.SetPlayerStealthFromSymbolEnemy(false)
    Qst.Main:Set(self.ID, self.STEP_013)
  end
end

function M020:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) then
    Digitter.Send(1020030010)
    if SystemFlag.CheckProhibitAutoRegeneration() then
      SystemFlag.ClearProhibitAutoRegeneration()
    end
    Flg.Set("TUT_FLAG_4712")
  end
end

function M020:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) and not Flg.Check("FLAG_MAIN_01_160") then
    Field_StopBGM()
    StopSE(Work.Get(Field_BackSE_Slot_Num), 15)
    Guest.Add(20881)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    EncountFromField(self.Battle.Enemy.e01, self.Battle.Map.m01, false)
  end
end

function M020:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) and Flg.Check("FLAG_MAIN_01_160", "FLAG_MAIN_01_170") then
    Flg.Set("FLAG_MAIN_01_170")
    Guest.Delete(20881)
    Digimon.RestoreAllParty()
    Common.SetDigimonGraspState(88, DIGIMON_GRASP_FLAG_SCAN)
    WaitFrame(1)
    SetPlayerLocator("start_03")
    Field.FollowerWarp()
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M020:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_016) then
    Qst.Main:Set(self.ID, self.STEP_016)
  end
end

function M020:Event_111()
  if Qst.Main:Check(self.ID, self.STEP_016, self.STEP_017) then
    Qst.Main:Set(self.ID, self.STEP_017)
  end
end

function M020:Event_112()
  if Qst.Main:Check(self.ID, self.STEP_017, self.STEP_018) then
    Qst.Main:Set(self.ID, self.STEP_018)
  end
end

function M020:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_018, self.STEP_020) and not Flg.Check("FLAG_MAIN_01_180") then
    Common.ProhibitSave()
    Field.LinkColOff("mapborder_1")
    Flg.Set("FLAG_MAIN_01_180")
    Execute("m020_070")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Field.LinkColOn("mapborder_1")
    Flg.Clear("FLAG_IS_LOCK_STRIKE_PLUS")
    Qst.Main:Set(self.ID, self.STEP_020, false)
  end
end

function M020:Event_125()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_01_180", "FLAG_MAIN_01_184") then
    WaitFrame(30)
    local tlk = Tlk:new("d14", 1, true)
    tlk:StartTalk()
    AnswerTheCall()
    tlk:Message("f_d1401_0040_0010")
    tlk:Message("f_d1401_0040_0020")
    tlk:Message("f_d1401_0040_0030")
    tlk:Message("f_d1401_0040_0040")
    tlk:EndTalk()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    EndTheCall()
    Common.SetDigimonScanValue(322, 200)
    Field.OpenRequestDigiviceConvert()
    SetControlScriptExternalVariable("AfterConvertTutorialEvent", "on")
  end
end

function M020:Event_126()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_01_180", "FLAG_MAIN_01_184") then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    SetControlScriptExternalVariable("AfterConvertTutorialEvent", "off")
    Flg.Set("FLAG_MAIN_01_184")
    local tlk = Tlk:new(gGimText, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    Motion.Player:Play("e503", 15, true)
    WaitFrame(15)
    tlk:Message("g_tutorial_1000_0010")
    tlk:Message("g_tutorial_1000_0020")
    tlk:Message("g_tutorial_1000_0030")
    tlk:Message("g_tutorial_1000_0040")
    tlk:EndTalk()
    Field.FollowerWarp()
    EndTheCall()
    Digitter.Send(1020070020)
    Flg.Set("TUT_FLAG_4612")
    Flg.Set("TUT_FLAG_4613")
    Common.CancelProhibitSave()
    Field.StartAutoSave(false, false)
  end
end

function M020:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Qst.Main:Set(self.ID, self.STEP_025)
    local tlk = Tlk:new("d14", 1, true)
    tlk:StartTalk()
    local pc = Obj:new(PLAYER, "")
    Field.SetFollowerCameraOperateRotationX(-10, 30, EASING_MODE_LINEAR)
    Field.SetFollowerCameraOperateRotationY(0, 30, EASING_MODE_LINEAR)
    AnswerTheCall()
    tlk:Message("f_d1401_0060_0010")
    tlk:MessageClose()
    Field.SetFollowerCameraOperateRotationX(-10, 150, EASING_MODE_LINEAR)
    Field.SetFollowerCameraOperateRotationY(35, 150, EASING_MODE_LINEAR)
    WaitFrame(30)
    tlk:Message("f_d1401_0060_0015")
    tlk:Message("f_d1401_0060_0020")
    tlk:Message("f_d1401_0060_0030")
    tlk:Message("f_d1401_0060_0040")
    SetFollowerCameraOperateRotation(-10, 35, 30)
    WaitFrame(30)
    tlk:EndTalk()
    EndTheCall()
  end
end

function M020:Event_143()
  if not Flg.Check("FLAG_MAIN_01_253") then
    Flg.Set("FLAG_MAIN_01_253")
    Digitter.Send(1020070030, true)
  end
end

function M020_Event143()
  M020:Event_143()
end

function M020:Event_145()
  if Flg.Check("FLAG_MAIN_01_184", "FLAG_MAIN_01_254") and Common.IsHigherDigimonScanValue(100) then
    Flg.Set("FLAG_MAIN_01_254")
    local tlk = Tlk:new(gGimText, 1, true)
    tlk:StartTalk()
    tlk:Message("g_tutorial_1001_0010")
    tlk:Message("g_tutorial_1001_0020")
    tlk:Message("g_tutorial_1001_0030")
    tlk:Message("g_tutorial_1001_0040")
    tlk:Message("g_tutorial_1001_0050")
    tlk:EndTalk()
    EndTheCall()
  end
end

function M020:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_060) then
    Flg.Set("FLAG_MAIN_01_185")
    local tlk = Tlk:new("d14", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1401_0050_0010")
    tlk:Message("f_d1401_0050_0020")
    tlk:EndTalk()
  end
end

function M020:Event_240()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_060) and Flg.Check("FLAG_MAIN_01_185", "FLAG_MAIN_01_210") then
    StopSE(Work.Get(Field_BackSE_Slot_Num), 15)
    Flg.Set("FLAG_MAIN_01_210")
    Field_InvisibleFollowerAllGuest(10, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Flg.Clear("FLAG_GIMMICK_D14_370")
    Motion.Gimmick:PlayFinishedAnim("change_0001", "e001")
    local slot_num = Work.Get(99)
    Sound.StopSE(slot_num, 0)
    Execute("m020_100")
    local pc = Obj:new(PLAYER, "")
    local y_degree = pc.rot_y
    SetFollowerCameraOperateRotation(5, 205, 30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Qst.Main:Set(self.ID, self.STEP_060)
  end
end

function M020:Event_245()
  if Flg.Check("FLAG_MAIN_01_210", "FLAG_MAIN_01_211") then
    Flg.Set("FLAG_MAIN_01_211")
    local tlk = Tlk:new("d14", 1, true)
    Cam.Inst:Set(-8.667, 2.05, 11.372, 1.009, 2.148, 8.853, default, 30)
    tlk:StartTalk()
    tlk:Message("f_d1403_0010_0010")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
  end
end

function M020:Event_250()
  if Qst.Main:Check(self.ID, self.STEP_060, self.STEP_065) then
    local tlk = Tlk:new("d14", 1, true)
    tlk:StartTalk()
    AnswerTheCall()
    tlk:Message("f_d1403_0020_0010")
    tlk:Message("f_d1403_0020_0020")
    tlk:Message("f_d1403_0020_0030")
    tlk:EndTalk()
    EndTheCall()
    Flg.Set("FLAG_MAIN_01_212")
    Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_obstacles_03"), true)
    Digitter.Send(3140402)
    Qst.Main:Set(self.ID, self.STEP_065)
  end
end

function M020:Event_260()
  if Qst.Main:Check(self.ID, self.STEP_065, self.STEP_070) then
    Qst.Main:Set(self.ID, self.STEP_070)
  end
end

function M020:Event_265()
  if Qst.Main:Check(self.ID, self.STEP_070, self.STEP_072) then
    Qst.Main:Set(self.ID, self.STEP_072)
  end
end

function M020:Event_270()
  if Qst.Main:Check(self.ID, self.STEP_072, self.STEP_075) then
    FadeOutWithWaitNotFlgCheck(0, FADE_TIME)
    Execute("m020_110")
    Obj:new(FLD_OBJ_LOCATOR, "obj_0003"):Invisible()
    self:Event_280()
  end
end

function M020:Event_280()
  if Qst.Main:Check(self.ID, self.STEP_072, self.STEP_075) then
    Sound.PlayBGM(317, 0.3)
    Execute("m020_120")
    Guest.Delete(GST_HEROINE)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):CancelInvisible()
    Flg.Set("FLAG_MAIN_01_220")
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(60)
    Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001")
    Motion.Gimmick:PlayFinishedAnim("obj_0004", "e001")
    Motion.Gimmick:PlayFinishedAnim("obj_0005", "e001")
    Obj:new(OGIM, "fa_obstacles_02"):CancelInvisible()
    ColOn("wall_cl_1003")
    Obj:new(NPC, "npc_0001"):CancelInvisible(nil, true)
    Obj:new(FLD_OBJ_LOCATOR, "obj_0008"):CancelInvisible()
    Obj:new(FLD_OBJ_LOCATOR, "obj_0001"):Invisible()
    Obj:new(OGIM, "fa_obstacles_01"):CancelInvisible()
    WaitFrame(10)
    Qst.Main:Set(self.ID, self.STEP_075)
    Obj:new(NPC, "rumor_d1403_piyomon01"):Invisible()
    MapChangeWithTimeTravel("d", 1403, "start_05", AXIS_ORIGINAL, "X2028_daft_22", EVENING)
  end
end

function M020:Event_285()
  if Qst.Main:Check(self.ID, self.STEP_075, self.STEP_080) and Flg.Check("FLAG_MAIN_01_220", "FLAG_MAIN_01_221") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_01_221")
    FadeInWithWait(FADE_BLACK, 30)
  end
end

function M020:Event_290()
  if Qst.Main:Check(self.ID, self.STEP_075, self.STEP_076) then
    Obj:new(NPC, "rumor_d1403_piyomon01"):CancelInvisible()
    Cam.Inst:Set(30.304, 1, -9.673, 24.304, 2, -9.673, default, 45)
    WaitFrame(60)
    Cam.Inst:Clear(45)
    WaitFrame(45)
    Flg.Set("FLAG_FIELD_D14_020")
    Qst.Main:Set(self.ID, self.STEP_076)
  end
end

function M020:Event_300()
  if Qst.Main:Check(self.ID, self.STEP_076, self.STEP_080) then
    Execute("m020_130")
    SetControlScriptExternalVariable("piyo_state", "stop")
    Flg.Set("FLAG_MAIN_01_230")
    Field.ObjectClearIcon(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"))
    Common.SetDigimonGraspState(307, DIGIMON_GRASP_FLAG_SCAN)
    Obj:new(NPC, "rumor_d1403_piyomon01"):Invisible()
    Qst.Main:Set(self.ID, self.STEP_080)
  end
end

function M020:Event_310()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_085) then
    Execute("m020_140")
    if not Flg.Check("FLAG_MAIN_01_225") then
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    else
      self:Event_320()
      Flg.Set("FLAG_IS_KEEP_BGM")
    end
  end
end

function M020:Event_320()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_085) then
    Flg.Set("FLAG_FIELD_D14_030")
  end
end

function M020:Event_330()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_085) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m020_160")
    PlayDungeonBGM()
    local y_degree = Field.GetLocatorRotationYDegree("start_00")
    SetFollowerCameraOperateRotation(0, y_degree, 0)
    Qst.Main:Set(self.ID, self.STEP_085)
  end
end

function M020:Event_331()
  if Qst.Main:Check(self.ID, self.STEP_085, self.STEP_090) then
    Flg.Set("FLAG_MAIN_01_235")
    local tlk = Tlk:new("d14", 1, true)
    tlk:StartTalk()
    AnswerTheCall()
    tlk:Message("f_d1405_0040_0010")
    tlk:Message("f_d1405_0040_0020")
    tlk:Message("f_d1405_0040_0030")
    tlk:Message("f_d1405_0040_0040")
    tlk:Message("f_d1405_0040_0050")
    tlk:EndTalk()
    EndTheCall()
    Field.OpenRequestDigiviceEvolve()
    SetControlScriptExternalVariable("AfterEvolveTutorialEvent", "on")
  end
end

function M020:Event_331B()
  if Qst.Main:Check(self.ID, self.STEP_085, self.STEP_090) then
    SetControlScriptExternalVariable("AfterEvolveTutorialEvent", "off")
    OpenTutorial(2005)
    Flg.Set("TUT_FLAG_4628")
    Qst.Main:Set(self.ID, self.STEP_090)
  end
end

function M020:Event_332()
  if Qst.Main:Check(self.ID, self.STEP_090, self.STEP_095) then
    Qst.Main:Set(self.ID, self.STEP_095)
  end
end

function M020:Event_333()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_100) then
    Qst.Main:Set(self.ID, self.STEP_100)
  end
end

function M020:Event_334()
  if Qst.Main:Check(self.ID, self.STEP_100, self.STEP_102) then
    Qst.Main:Set(self.ID, self.STEP_102)
  end
end

function M020:Event_350()
  if not Flg.Check("FLAG_MAIN_01_240") and Qst.Main:Check(self.ID, self.STEP_102, self.STEP_105) then
    Execute("m020_170")
    Flg.Set("FLAG_MAIN_01_240")
    Flg.Set("FLAG_MAIN_01_241")
    Qst.Main:Set(self.ID, self.STEP_105)
  end
end

function M020:Event_360()
  if Qst.Main:Check(self.ID, self.STEP_105, self.STEP_255) and not Flg.Check("FLAG_MAIN_01_255") then
    Flg.Set("FLAG_MAIN_01_255")
    SetProhibitPlayerOnlyOperate(true)
    local tlk = Tlk:new("d14", 1, true)
    tlk:StartTalk()
    AnswerTheCall()
    tlk:Message("f_d1407_0050_0010")
    tlk:Message("f_d1407_0050_0020")
    tlk:Message("f_d1407_0050_0030")
    tlk:Message("f_d1407_0050_0040")
    tlk:Message("f_d1407_0050_0050")
    tlk:EndTalk()
    EndTheCall()
    SetProhibitPlayerOnlyOperate(false)
  end
end

function M020:Event_370()
  if Qst.Main:Check(self.ID, self.STEP_105, self.STEP_255) and not Flg.Check("FLAG_MAIN_01_260") then
    Flg.Set("FLAG_MAIN_01_250")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    EncountFromField(10110300, BTL_MAP_SHINJUKU_BUILDING_ROOFTOP, false)
  end
end

function M020:Event_380()
  if Flg.Check("FLAG_MAIN_01_260", "FLAG_MAIN_02_010") then
    Execute("m020_190")
    Guest.Delete(GST_HEROINE)
    Qst.Main:End(self.ID, self.STEP_255)
    Sound.StopBGM(0.5)
    Flg.Set("TUT_FLAG_4504")
    Flg.Set("TUT_FLAG_4512")
    Flg.Set("TUT_FLAG_4513")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("d", 801, "start_20", AXIS_ORIGINAL, "A2020_dbef_30", NOON)
  end
end

function M020:ChapterFlagSet(progress)
  local step = {}
  if 1 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 10 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 30 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_013
  end
  if 70 <= progress then
    step[#step + 1] = self.STEP_015
  end
  if 71 <= progress then
    step[#step + 1] = self.STEP_016
    step[#step + 1] = self.STEP_017
    step[#step + 1] = self.STEP_018
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_025
  end
  if 80 <= progress then
    step[#step + 1] = self.STEP_030
  end
  if 100 <= progress then
  end
  if 110 <= progress then
    step[#step + 1] = self.STEP_060
  end
  if 130 <= progress then
    step[#step + 1] = self.STEP_065
    step[#step + 1] = self.STEP_070
    step[#step + 1] = self.STEP_072
    step[#step + 1] = self.STEP_075
  end
  if 170 <= progress then
    step[#step + 1] = self.STEP_076
    step[#step + 1] = self.STEP_080
    step[#step + 1] = self.STEP_085
    step[#step + 1] = self.STEP_090
    step[#step + 1] = self.STEP_095
    step[#step + 1] = self.STEP_100
    step[#step + 1] = self.STEP_102
  end
  if 180 <= progress then
    step[#step + 1] = self.STEP_105
  end
  Qst.Main:Chapter(step, self.ID)
end
