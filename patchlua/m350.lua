gGimText = "field_text"
M350 = {
  ID = 350,
  STEP_001 = 1,
  STEP_010 = 10,
  STEP_013 = 13,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_040 = 40,
  STEP_045 = 45,
  STEP_050 = 50,
  STEP_055 = 55,
  STEP_060 = 60,
  STEP_065 = 65,
  STEP_255 = 255
}

function M350:Event_010()
  if Flg.Check("FLAG_MAIN_13_080", "FLAG_MAIN_13_085") then
    Flg.Set("FLAG_MAIN_13_085")
    FadeAllInWithWait(FADE_WHITE, 120)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M350:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_010) then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    local door = Motion.Object:new(FLD_OBJ_GIMMICK, "theater_0002", "e005")
    Cam.Inst:Set(18.475, 0.981, 48.056, 11.145, 1.185, 41.258, default, 0)
    local pc = Obj:new(PLAYER, "")
    pc:SetPos(15.311, 0, 44.936, true)
    pc:SetRotationY(315, 0)
    PlaySE(401055, 100)
    WaitFrame(45)
    door:Play(0, false)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(80)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_13_090")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    WaitFrame(30)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M350:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_013) and not Flg.Check("FLAG_MAIN_13_095") then
    Flg.Set("FLAG_MAIN_13_095")
    Execute("m350_010")
  end
end

function M350:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_013) then
    Flg.Set("FLAG_MAIN_13_100")
    Execute("m350_020")
    Execute("m350_050")
    Execute("m350_090")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Obj:new(PLAYER, ""):SetPos(0, 0, 0, true)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    SetFollowerCameraOperateRotation(0, 180)
    Qst.Main:Set(self.ID, self.STEP_013)
  end
end

function M350:Event_043()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) and not Flg.Check("FLAG_MAIN_13_110") then
    Fade_OutNoLoadingWithWait(FADE_WHITE, 0)
    Cam.Inst:Set(-0.03, 1.049, 3.127, 0.612, 1.365, 13.08, default, 0)
    Flg.Set("FLAG_MAIN_13_110")
    Obj:new(PLAYER, ""):SetPos(0, 0.01, 8.684, true)
    Obj:new(PLAYER, ""):MoveToTarget2D(0.041, 9.959, 2, 20)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    SetFollowerCameraOperateRotation(0, Obj:new(PLAYER, "").rot_y)
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M350:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) then
    Digitter.Send(1350010020)
  end
end

function M350:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) and not Flg.Check("FLAG_MAIN_13_140") then
    Flg.Set("FLAG_MAIN_13_140")
    Execute("m350_100")
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M350:Event_051()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_13_140", "FLAG_MAIN_13_141") then
    local tlk = Tlk:new("d02", 1, true)
    Cam.Inst:Set(-24.36, 2.1, 52.75, -20.65, 3.96, 61.85, default, 30)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0201_880_0010")
    tlk:EndTalk(true)
    Guest.Add(GST_KNIGHTMON)
    Guest.Add(GST_SHOUTMON)
    FieldObjectSync(FOR_ALL, true)
    EncountFromField_WithNormalEffect(11200050, 10271, false)
  end
end

function M350:Event_052()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_13_141", "FLAG_MAIN_13_142") then
    FieldObjectSync(MOB, false)
    Cam.Inst:Set(-21.16, 2.25, 53.81, -24.46, 4.02, 63.08, default, 1)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Guest.Delete(GST_KNIGHTMON)
    Guest.Delete(GST_SHOUTMON)
    local tlk = Tlk:new("d02", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0201_890_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_13_142")
    Cam.Inst:Clear(30)
    if not Flg.Check("FLAG_MAIN_13_151") then
      SetControlScriptExternalVariable("tagrun01_state", "run")
    end
  end
end

function M350:Event_053()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_13_142", "FLAG_MAIN_13_143") then
    local npc_index02 = GetIndex(MOB, "m350_0003")
    local npc_index03 = GetIndex(NPC, "npc_762")
    local bf01 = Motion.Object:new(MOB, "m350_0003", "bf01")
    local p_bf01 = Motion.Object:new(NPC, "npc_762", "bf01")
    local tlk = Tlk:new("d02", 1, true)
    Cam.Inst:Set(5.4, 3.22, 28.6, -3.28, 4.13, 33.45, default, 30)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0201_1000_0010")
    p_bf01:Play(10, true)
    WaitFrame(15)
    PlaySE(300201, 100)
    Fade_OutNoLoadingWithWait(1, 5)
    Flg.Set("FLAG_MAIN_13_143")
    WaitFrame(5)
    Cam.Inst:Set(5.31, 2.86, 27.53, -3.3, 3.54, 32.55, default, 1)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(5)
    FadeAllInWithWait(1, 5)
    tlk:Message("f_d0201_1000_0020")
    tlk:Message("f_d0201_1000_0030")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    if not Flg.Check("FLAG_MAIN_13_152") then
      SetControlScriptExternalVariable("tagrun02_state", "run2")
    end
  end
end

function M350:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_13_143", "FLAG_MAIN_13_144") then
    local break_fe04 = Motion.Object:new(NPC, "npc_0668", "fe04")
    local break_bn01 = Motion.Object:new(NPC, "npc_0668", "bn01")
    local pc_e018 = Motion.Object:new(PLAYER, "", "e018")
    local tlk = Tlk:new("d02", 1, true)
    break_bn01:Play(10, true)
    Cam.Inst:Set(34.477, 3.3161, 27.338, 29.673, 1.9097, 36, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0202_0710_0010")
    tlk:Message("f_d0202_0710_0020")
    pc_e018:Play(10, false)
    WaitFrame(30)
    Cam.Inst:Set(35.266, 5.9249, 20.421, 31.931, 3.6773, 29.576, default, 20)
    break_fe04:Play(10, false)
    WaitFrame(10)
    tlk:EndTalk(true)
    Guest.Add(GST_STARMON)
    Guest.Add(GST_PANDAMON)
    EncountFromField_WithNormalEffect(11200060, 10272, false)
  end
end

function M350:Event_056()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_13_144", "FLAG_MAIN_13_145") then
    Cam.Inst:Clear(0)
    Guest.Delete(GST_STARMON)
    Guest.Delete(GST_PANDAMON)
    FieldObjectSync(FOR_ALL, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d02", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0202_0720_0010")
    tlk:Message("f_d0202_0720_0020")
    tlk:Message("f_d0202_0720_0030")
    tlk:Message("f_d0202_0720_0040")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_13_145")
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M350:Event_057()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_13_145", "FLAG_MAIN_13_146") then
    local tlk = Tlk:new("d02", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Quake_Start(0.5, 0, 20)
    PlaySE(202001, 100)
    WaitFrame(20)
    Flg.Set("FLAG_MAIN_13_130")
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    Obj:new(PLAYER, ""):MoveToTarget2D(4.204, -7.633, 7, 30)
    WaitFrame(40)
    SetFollowerCameraOperateRotation(0, 0, 20)
    WaitFrame(20)
    tlk:Message("f_d0201_1010_0010")
    tlk:Message("f_d0201_1010_0020")
    tlk:MessageClose()
    WaitFrame(20)
    tlk:Message("f_d0201_1040_0010")
    SetFollowerCameraOperateRotation(0, 270, 20)
    WaitFrame(20)
    FieldObjectSync(NPC, true)
    FieldObjectSync(RUMOR_NPC, true)
    FieldObjectSync(MOB, true)
    WaitFrame(20)
    Cam.Inst:Set(-7.6, 4.23, -9, 2.35, 4.24, -8.1, default, 30)
    WaitFrame(30)
    tlk:Message("f_d0201_1040_0020")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    WaitFrame(30)
    Flg.Set("FLAG_MAIN_13_146")
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M350:Event_057A()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Qst.Main:Set(self.ID, self.STEP_030)
  end
end

function M350:Event_057B()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    Qst.Main:Set(self.ID, self.STEP_035)
  end
end

function M350:Event_057C()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) then
    Qst.Main:Set(self.ID, self.STEP_040)
  end
end

function M350:Event_058()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_13_146", "FLAG_MAIN_13_147") then
    CancelPlayerAnywhereDigimonRide()
    WaitFrame(20)
    Field.DisableMenu()
    Common.ProhibitSave()
    Field.DisableAnalyzeAndFieldAttack()
    Field.DisableSystemDigimonChat()
    Field.SetProhibitAnywhereDigimonRide(true)
    Field.SetProhibitDigimonRide(true)
    Field.SetProhibitPlayerMoveOperate(true)
    local pc = Obj:new(PLAYER, "")
    local rvec = Field.GetUnitVector2D(pc.rot_y - 200)
    local rvec_x, rvec_z = rvec.x * 2, rvec.z * 2
    local tlk = Tlk:new("d02", 1, true)
    Cam.Inst:Set(17.141, 17.12, -17.654, 15.776, 18.481, -27.467, default, 30)
    Field_Talk_Start_Not_LetterBox("d02", 1)
    Field.HideMinimap(true)
    Field.HideGuide(true)
    Talk.OpenLetterBox()
    Message("f_d0201_1030_0010")
    Message("f_d0201_1030_0020")
    MessageClose()
    Motion.Object:new(PLAYER, "", "e201"):Play(10, false)
    WaitFrame(30)
    Flg.Set("FLAG_MAIN_13_147")
    FieldObjectSync(NPC, true)
    if not Flg.Check("FLAG_MAIN_13_153") then
      SetControlScriptExternalVariable("tagrun03_state", "run3")
      Flg.Set("FLAG_MAIN_13_153")
    end
    Field_Talk_End_Not_LetterBox()
  end
end

function M350_Event_058_E()
  if not Flg.Check("FLAG_MAIN_13_148") then
    local pc = Obj:new(PLAYER, "")
    local rvec = Field.GetUnitVector2D(pc.rot_y - 200)
    local rvec_x, rvec_z = rvec.x * 2, rvec.z * 2
    Motion.Object:new(PLAYER, "", "fn01_01"):Play(10, true)
    Cam.Inst:Set(13.237, 20.594, -16.627, 18.659, 16.876, -24.852, 50, 30)
    WaitFrame(15)
    local m350_chimaera = GetIndex(ENEMY, "m350_chimaera")
    Field.ObjectLookAtTheObject(ENEMY, m350_chimaera, PLAYER, 1, 30)
    Field.ObjectLookAtTheObject(PLAYER, 1, ENEMY, m350_chimaera, 30)
    Motion.Object:new(ENEMY, "m350_chimaera", "fe04"):Play(10, false)
    Motion.Object:new(PLAYER, "", "bn01"):Play(10, false)
    WaitFrame(40)
    Talk.CloseLetterBox()
    EncountFromField_WithNormalEffect(11200020, 10271, true)
  end
end

function M350:Event_058A()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) and Flg.Check("FLAG_MAIN_13_148", "FLAG_MAIN_13_149") then
    Motion.Object:new(PLAYER, "", "fn01_01"):Play(0, true)
    Obj:new(PLAYER, ""):SetPos(17.184, 15.059, -18.111, true)
    Obj:new(PLAYER, ""):SetRotationY(75, 5)
    SetFollowerCameraOperateRotation(0, 90)
    Field_CancelInvisibleFollowerAllPartyMember(3503, 10, true, false)
    Field.SetProhibitPlayerMoveOperate(false)
    Field.HideMinimap(false)
    Field.HideGuide(false)
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_13_153")
    Field.CancelDisableMenu()
    Common.CancelProhibitSave()
    Field.CancelDisableAnalyzeAndFieldAttack()
    Field.CancelDisableSystemDigimonChat()
    Field.SetProhibitAnywhereDigimonRide(false)
    Field.SetProhibitDigimonRide(false)
    FieldObjectSync(FOR_ALL, true)
    Qst.Main:Set(self.ID, self.STEP_045)
  end
end

function M350:Event_059()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_MAIN_13_148", "FLAG_MAIN_13_149") then
    Flg.Set("FLAG_MAIN_13_149")
    FieldObjectSync(FOR_ALL, true)
    Field.SetProhibitPlayerMoveOperate(true)
    Cam.Inst:Set(1.958, 17.387, 14.312, -7.396, 20.717, 15.493, default, 30)
    WaitFrame(30)
    if not Flg.Check("FLAG_MAIN_13_154") then
      SetControlScriptExternalVariable("memberrun01_state", "run4")
    end
    local tlk = Tlk:new("d02", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0202_0740_0010")
    tlk:EndTalk()
    WaitFrame(60)
    Cam.Inst:Clear(30)
    Flg.Set("FLAG_MAIN_13_154")
    FieldObjectSync(FOR_ALL, true)
    Field.SetProhibitPlayerMoveOperate(false)
    Qst.Main:Set(self.ID, self.STEP_050)
  end
end

function M350:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_055) and Flg.Check("FLAG_MAIN_13_140", "FLAG_MAIN_13_150") then
    Guest.Add(GST_MERCRIUS_350)
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    EncountFromField(11200040, 10272, false)
  end
end

function M350:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_055) and Flg.Check("FLAG_MAIN_13_150", "FLAG_MAIN_13_160") then
    Flg.Set("FLAG_MAIN_13_160")
    Execute("m350_130")
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_055)
    Guest.Delete(GST_MERCRIUS_350)
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    MapChangeWithTimeTravel("t", 3001, "start_01", AXIS_ORIGINAL, "A2028_daft_350", NIGHT)
  end
end

function M350:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_060) and Flg.Check("FLAG_MAIN_13_160", "FLAG_MAIN_13_170") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Prcs_t3001_12GodsReliefInvisible(true)
    Execute("m350_140")
    PlayDungeonBGM()
    Prcs_t3001_12GodsReliefInvisible(false)
    Flg.Set("FLAG_GIMMICK_T0301_006")
    Prcs_t3001_12GodsReliefSeting()
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    local org_prefix = "d"
    local org_number = 202
    local org_locator = "start_50"
    local org_time_zone = evening
    Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
    Flg.Set("FLAG_MAIN_13_170")
  end
end

function M350:Event_083()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_060) then
    Fade_OutNoLoading(FADE_WHITE, 0)
    Cam.Inst:Set(-28.572, 1.852, 28.059, -29.747, 1.313, 18.143, default, 0)
    WaitFrame(70)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(60)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Qst.Main:Set(self.ID, self.STEP_060)
    WaitFrame(20)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_13_171")
  end
end

function M350:Event_085()
  if Qst.Main:Check(self.ID, self.STEP_060, self.STEP_065) and Flg.Check("FLAG_MAIN_13_170", "FLAG_MAIN_13_175") then
    local e002 = Motion.Object:new(NPC, "npc_0754", "e002")
    local fn01_01 = Motion.Object:new(NPC, "npc_0754", "fn01_01")
    Flg.Set("FLAG_MAIN_13_175")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Set(-25.09, 2.13, -10.56, -28.79, 3.6, -1.39, default, 15)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 30, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -28.79, 1.985, -3.1)
    Obj:new(NPC, "npc_0754"):SetRotationY(240, 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d02", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    e002:Play(10, true)
    tlk:Message("f_d0202_0750_0010")
    fn01_01:Play(10, true)
    tlk:Message("f_d0202_0750_0020")
    e002:Play(10, true)
    tlk:Message("f_d0202_0750_0030")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(1)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 80, 0)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_065)
  end
end

function M350:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_065, self.STEP_255) then
    Flg.Set("FLAG_MAIN_13_180")
    Execute("m350_150")
    FieldObjectSync(NPC, true)
    WaitFrame(5)
    Qst.Main:End(self.ID, self.STEP_255)
    M360:Event_005()
  end
end

function M350:ChapterFlagSet(progress)
  local step = {}
  if 10 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 80 <= progress then
    step[#step + 1] = self.STEP_013
    step[#step + 1] = self.STEP_015
  end
  if 90 <= progress then
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_025
    step[#step + 1] = self.STEP_030
    step[#step + 1] = self.STEP_035
    step[#step + 1] = self.STEP_040
    step[#step + 1] = self.STEP_045
    step[#step + 1] = self.STEP_050
  end
  if 100 <= progress then
    step[#step + 1] = self.STEP_055
  end
  if 110 <= progress then
    step[#step + 1] = self.STEP_060
    step[#step + 1] = self.STEP_065
  end
  Qst.Main:Chapter(step, self.ID)
end
