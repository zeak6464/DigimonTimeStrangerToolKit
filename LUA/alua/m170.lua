gGimText = "field_text"
M170 = {
  ID = 170,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_007 = 7,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_016 = 16,
  STEP_017 = 17,
  STEP_020 = 20,
  STEP_021 = 21,
  STEP_022 = 22,
  STEP_023 = 23,
  STEP_024 = 24,
  STEP_025 = 25,
  STEP_026 = 26,
  STEP_030 = 30,
  STEP_031 = 31,
  STEP_035 = 35,
  STEP_040 = 40,
  STEP_045 = 45,
  STEP_050 = 50,
  STEP_055 = 55,
  STEP_060 = 60,
  STEP_065 = 65,
  STEP_070 = 70,
  STEP_071 = 71,
  STEP_075 = 75,
  STEP_080 = 80,
  STEP_085 = 85,
  STEP_090 = 90,
  STEP_095 = 95,
  STEP_100 = 100,
  STEP_105 = 105,
  STEP_255 = 255
}

function M170:Event_010()
  if Flg.Check("FLAG_MAIN_05_030", "FLAG_MAIN_05_060") then
    Qst.Main:Start(self.ID, self.STEP_001)
    MapChangeWithTimeTravel("d", 606, "start_20", AXIS_ORIGINAL, "A2020_dbef_170", NOON)
  end
end

function M170:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_05_030", "FLAG_MAIN_05_060") then
    Execute("m170_010")
    Qst.Main:Set(self.ID, self.STEP_003)
  end
end

function M170:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m170_020")
    Flg.Set("FLAG_MAIN_05_060")
    FieldObjectSync(NPC, true)
    Qst.Main:Set(self.ID, self.STEP_005)
    Digitter.Send(1170010010)
  end
end

function M170:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_007) then
    Qst.Main:Set(self.ID, self.STEP_007)
  end
end

function M170:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_007, self.STEP_010) then
    Execute("m170_030")
    Flg.Set("FLAG_MAIN_05_070")
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M170:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new("d03", 1, true)
    local digimon_index = GetIndex(NPC, "npc_0004")
    Field.ObjectLoadMotion(NPC, digimon_index, "bn01")
    Field.ObjectLoadMotion(NPC, digimon_index, "fq01")
    Field.ObjectLoadMotion(NPC, digimon_index, "fq02")
    Field.ObjectLoadMotion(NPC, digimon_index, "fe04")
    tlk:StartTalkActionAndZoom("npc_0004")
    WaitFrame(40)
    tlk:Message("f_d0302_0120_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq01", 10, 10)
    tlk:Message("f_d0302_0120_0020")
    tlk:Message("f_d0302_0120_0030")
    tlk:Message("f_d0302_0120_0040")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq01", 10, 10)
    tlk:Message("f_d0302_0120_0050")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq02", 10, 10)
    tlk:Message("f_d0302_0120_0060")
    tlk:Message("f_d0302_0120_0070")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, digimon_index, "fq01", 10, 10)
    tlk:Message("f_d0302_0120_0080")
    tlk:Message("f_d0302_0120_0090")
    tlk:Message("f_d0302_0120_0100")
    tlk:EndTalkActionAndZoom()
    Flg.Set("FLAG_MAIN_05_075")
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M170:Event_043()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_016) then
    Qst.Main:Set(self.ID, self.STEP_016)
  end
end

function M170:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_016, self.STEP_017) then
    Qst.Main:Set(self.ID, self.STEP_017)
  end
end

function M170:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_017, self.STEP_020) then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Execute("m170_050")
    if Flg.Check("FLAG_MAIN_05_080") then
      FieldObjectSync(FLD_OBJ_SYMBOL_ENEMY, true)
      Qst.Main:Set(self.ID, self.STEP_020)
    end
  end
end

function M170:Event_053()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_021) then
    Qst.Main:Set(self.ID, self.STEP_021)
  end
end

function M170:Event_055()
  local mozya = Obj:new(NPC, "npc_0400")
  local mozya_bn01 = Motion.Object:new(NPC, "npc_0400", "bn01")
  local mozya_bn02 = Motion.Object:new(NPC, "npc_0400", "bn02")
  local mozya_fq02 = Motion.Object:new(NPC, "npc_0400", "fq02")
  if Qst.Main:Check(self.ID, self.STEP_021, self.STEP_022) then
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    mozya:SetRotationYToPlayer(15)
    tlk:Message("f_d0301_0040_0010")
    mozya_bn02:Play(10, true)
    tlk:Message("f_d0301_0040_0020")
    MessageClose()
    Cam.Inst:Set(53.833801, 2.904886, 78.764824, 47.618252, 8.311781, 73.096275, default, 45)
    WaitFrame(40)
    mozya_bn01:Play(10, true)
    tlk:Message("f_d0301_0040_0030")
    tlk:Message("f_d0301_0040_0040")
    MessageClose()
    Cam.Inst:Clear(45)
    WaitFrame(40)
    mozya_fq02:Play(10, true)
    tlk:Message("f_d0301_0040_0050")
    mozya_bn01:Play(10, true)
    tlk:Message("f_d0301_0040_0060")
    tlk:Message("f_d0301_0040_0070")
    tlk:EndTalk()
    Flg.Set("FLAG_FIELD_D0303_150")
    Qst.Main:Set(self.ID, self.STEP_022)
  end
end

function M170:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_022, self.STEP_023) then
    local flags = {
      "FLAG_MAIN_05_081",
      "FLAG_MAIN_05_084",
      "FLAG_MAIN_05_086",
      "FLAG_MAIN_05_088",
      "FLAG_MAIN_05_089"
    }
    local count = 0
    local mozya_bn01 = Motion.Object:new(NPC, "npc_0400", "bn01")
    local mozya_fe02 = Motion.Object:new(NPC, "npc_0400", "fe02")
    for _, flag in pairs(flags) do
      if Flg.Check(flag) then
        count = count + 1
      end
    end
    if 3 <= count then
      FadeInWithWaitNotFlgCheck(FADE_BLACK, 0)
      Flg.Set("FLAG_MAIN_05_076")
      BackFade_OutNoLoadingWithWait(FADE_BLACK, 0)
      Prcs_d03_ResetMoveMotion()
      Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 180, 0)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 47.722, 1.484, 67)
      Cam.Inst:Set(47.944534, 1.935262, 71.734627, 42.218975, 5.896653, 64.556511, default, 0)
      WaitFrame(30)
      Field.FollowerWarp()
      INFO_GET_ITEM(728, 1)
      Field.ObjectCheckSync(FOR_ALL, true)
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d0301_0040_0080")
      local npc_index1 = Field.GetNpcIndex("npc_0400")
      ObjectSetRotationY(FLD_OBJ_NPC, npc_index1, 80, 0)
      mozya_fe02:Play(10, true)
      WaitFrame(30)
      BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Motion.Player:PlayWithMoveMotion("e004", 5, 5)
      tlk:Message("f_d0301_0040_0090")
      tlk:Message("f_d0301_0040_0100")
      FadeOutWithWait(0, 5)
      WaitFrame(15)
      tlk:EndTalk()
      mozya_bn01:Play(10, true)
      ObjectSetRotationY(FLD_OBJ_NPC, npc_index1, 0, 0)
      Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 140, 0)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 45.185, 1.32, 68.251)
      SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
      for _, flag in pairs(flags) do
        Flg.Set(flag)
      end
      Field.ObjectCheckSync(FLD_OBJ_SYMBOL_ENEMY, false)
      Cam.Inst:Clear(1)
      Flg.Set("FLAG_MAIN_05_082")
      Field.FollowerWarp()
      Field.ObjectCheckSync(FOR_ALL, true)
      WaitFrame(15)
      FadeInWithWait(0, 5)
      Qst.Main:Set(self.ID, self.STEP_023)
    end
  end
end

function M170:Event_061()
  if Qst.Main:Check(self.ID, self.STEP_023, self.STEP_024) then
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0301_0050_0010")
    tlk:Message("f_d0301_0050_0020")
    tlk:Message("f_d0301_0050_0030")
    tlk:MessageClose()
    Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
    tlk:Message("f_d0301_0050_0040")
    Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
    tlk:Message("f_d0301_0050_0050")
    Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
    tlk:Message("f_d0301_0050_0060")
    tlk:EndTalk()
    Item.Delete(728, 1)
    Flg.Set("FLAG_MAIN_05_094")
    Qst.Main:Set(self.ID, self.STEP_024)
  end
end

function M170:Event_062()
  if Qst.Main:Check(self.ID, self.STEP_024, self.STEP_025) and not Flg.Check("FLAG_MAIN_05_091") then
    Flg.Set("FLAG_MAIN_05_091")
  end
end

function M170:Event_063()
  if Qst.Main:Check(self.ID, self.STEP_024, self.STEP_025) and Flg.Check("FLAG_MAIN_05_091", "FLAG_MAIN_05_092") then
    local kame01_ba02 = Motion.Object:new(NPC, "npc_0200", "ba02")
    local kame01_fq01 = Motion.Object:new(NPC, "npc_0200", "fq01")
    local kame01_fq02 = Motion.Object:new(NPC, "npc_0200", "fq02")
    local kame01_fe04 = Motion.Object:new(NPC, "npc_0200", "fe04")
    local kame01_f004 = Motion.Object:new(NPC, "npc_0200", "f004")
    local kame01_bn01 = Motion.Object:new(NPC, "npc_0200", "bn01")
    local kame01_bn02 = Motion.Object:new(NPC, "npc_0200", "bn02")
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    kame01_f004:Play(10, true)
    tlk:Message("f_d0302_0160_0010")
    tlk:MessageClose()
    Cam.Inst:Set(-6.054896, 18.379477, 10.983944, -7.536894, 14.786848, 23.130035, default, 45)
    WaitFrame(45)
    tlk:Message("f_d0302_0160_0020")
    kame01_fq02:Play(10, true)
    tlk:Message("f_d0302_0160_0030")
    kame01_fq01:Play(10, true)
    tlk:Message("f_d0302_0160_0040")
    kame01_bn01:Play(10, true)
    tlk:MessageClose()
    WaitFrame(30)
    kame01_ba02:Play(10, true)
    tlk:Message("f_d0302_0160_0110")
    tlk:Message("f_d0302_0160_0050")
    kame01_fq02:Play(10, true)
    tlk:Message("f_d0302_0160_0060")
    kame01_bn02:Play(10, true)
    tlk:Message("f_d0302_0160_0070")
    kame01_fq01:Play(10, true)
    tlk:Message("f_d0302_0160_0080")
    tlk:MessageClose()
    kame01_bn01:Play(10, true)
    WaitFrame(60)
    kame01_fe04:Play(10, true)
    tlk:Message("f_d0302_0160_0090")
    tlk:MessageClose()
    Cam.Inst:Clear(45)
    WaitFrame(45)
    tlk:Message("f_d0302_0160_0100")
    tlk:EndTalk()
    kame01_bn01:Play(10, true)
    Flg.Set("FLAG_MAIN_05_092")
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M170:Event_065()
  if Qst.Main:Check(self.ID, self.STEP_024, self.STEP_026) then
    local tlk = Tlk:new("d03", 1, true)
    BackFade_OutNoLoadingWithWait(FADE_BLACK, 10)
    if Qst.Main:Check(self.ID, self.STEP_024, self.STEP_025) then
      Qst.Main:Set(self.ID, self.STEP_025)
    end
    Flg.Set("FLAG_MAIN_05_077")
    WaitFrame(10)
    PlaySE(401022, 100)
    WaitFrame(10)
    Field.ObjectCheckSync(FOR_ALL, true)
    Cam.Inst:Set(-17.240341, 5.39, 19.025568, -11.330248, 7.230559, 26.879429, default, 1)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 0, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -12.7, 5.749, 26.3)
    WaitFrame(30)
    PlaySE(404009, 100)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0302_0180_0010")
    tlk:Message("f_d0302_0180_0020")
    tlk:MessageClose()
    BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local nani01_fe02 = Motion.Object:new(NPC, "npc_0202", "fe02")
    local nani01_fe03 = Motion.Object:new(NPC, "npc_0202", "fe03")
    local nani01_fe04 = Motion.Object:new(NPC, "npc_0202", "fe04")
    local nani01_fq01 = Motion.Object:new(NPC, "npc_0202", "fq01")
    local nani01_bn01 = Motion.Object:new(NPC, "npc_0202", "bn01")
    local kame02_ba02 = Motion.Object:new(NPC, "npc_0201", "ba02")
    local kame02_fq01 = Motion.Object:new(NPC, "npc_0201", "fq01")
    local kame02_fq02 = Motion.Object:new(NPC, "npc_0201", "fq02")
    local kame02_fe04 = Motion.Object:new(NPC, "npc_0201", "fe04")
    local kame02_bn01 = Motion.Object:new(NPC, "npc_0201", "bn01")
    nani01_fe03:Play(10, true)
    tlk:Message("f_d0302_0180_0030")
    kame02_fq02:Play(10, true)
    tlk:Message("f_d0302_0180_0040")
    nani01_fe02:Play(10, true)
    tlk:Message("f_d0302_0180_0050")
    kame02_fe04:Play(10, true)
    tlk:Message("f_d0302_0180_0060")
    tlk:Message("f_d0302_0180_0070")
    kame02_ba02:Play(10, true)
    tlk:Message("f_d0302_0180_0080")
    nani01_fe04:Play(10, true)
    tlk:Message("f_d0302_0180_0090")
    tlk:Message("f_d0302_0180_0100")
    tlk:Message("f_d0302_0180_0110")
    BackFade_OutNoLoadingWithWait(FADE_BLACK, 5)
    tlk:Message("f_d0302_0180_0100")
    tlk:Message("f_d0302_0180_0110")
    tlk:MessageClose()
    nani01_bn01:Play(10, true)
    kame02_fq01:Play(10, true)
    local npc_index1 = Field.GetNpcIndex("npc_0202")
    Field.ObjectSetPos(FLD_OBJ_NPC, npc_index1, -12.782, 6.002, 23.679)
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index1, 200, 0)
    local npc_index2 = Field.GetNpcIndex("npc_0201")
    Field.ObjectSetPos(FLD_OBJ_NPC, npc_index2, -13.88, 6.052, 24.014)
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index2, 110, 0)
    WaitFrame(60)
    BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message("f_d0302_0180_0120")
    nani01_fe03:Play(10, true)
    tlk:Message("f_d0302_0180_0130")
    kame02_fe04:Play(10, true)
    tlk:Message("f_d0302_0180_0140")
    nani01_fq01:Play(10, true)
    kame02_bn01:Play(10, true)
    tlk:Message("f_d0302_0180_0150")
    local npc_0201 = Obj:new(NPC, "npc_0201")
    npc_0201:SetRotationYToPlayerAndAnimRun(5)
    tlk:Message("f_d0302_0180_0160")
    tlk:MessageClose()
    INFO_GET_ITEM(730, 1)
    Flg.Set("FLAG_MAIN_05_093")
    BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    tlk:EndTalk()
    Cam.Inst:Clear(1)
    Field.ObjectCheckSync(FOR_ALL, true)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    WaitFrame(30)
    BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_026)
  end
end

function M170:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_026, self.STEP_030) then
    Execute("m170_060")
    Item.Delete(730, 1)
    MapChange("d", 308, "start_00", false, FADE_BLACK, 15)
  end
end

function M170:Event_071()
  if Qst.Main:Check(self.ID, self.STEP_026, self.STEP_030) then
    FadeAllInWithWait(FADE_BLACK, 0)
    Execute("m170_065")
    Flg.Set("FLAG_MAIN_05_083")
    Qst.Main:Set(self.ID, self.STEP_030)
    Obj:new(PLAYER, ""):SetPos(-2.177, 0, -0.213, true)
    Obj:new(PLAYER, ""):SetRotationY(170, 0)
    SetFollowerCameraOperateRotation(0, 180, 0)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true, true)
  end
end

function M170:Event_072()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_171"
    TIME_ZONE = NOON
  end
end

function M170:Event_073()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_031) then
    Qst.Main:Set(self.ID, self.STEP_031)
  end
end

function M170:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_031, self.STEP_035) then
    Execute("m170_070")
    Qst.Main:Set(self.ID, self.STEP_035)
  end
end

function M170:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) then
    local tlk = Tlk:new("d03", 1, true)
    local npc_index01 = GetIndex(NPC, "npc_0008")
    local npc_index02 = GetIndex(NPC, "inori_02")
    local npc_index03 = GetIndex(NPC, "aigio_02")
    local fq02 = Motion.Object:new(NPC, "npc_0008", "fq02")
    local bn02 = Motion.Object:new(NPC, "npc_0008", "bn02")
    local inori_e002 = Motion.Object:new(NPC, "inori_02", "e002")
    local inori_e005 = Motion.Object:new(NPC, "inori_02", "e005")
    local inori_fn01_01 = Motion.Object:new(NPC, "inori_02", "fn01_01")
    local inori_blend01 = Motion.Object:new(NPC, "inori_02", "blend01")
    local aigio_e009 = Motion.Object:new(NPC, "aigio_02", "e009")
    local aigio_fn01_01 = Motion.Object:new(NPC, "aigio_02", "fn01_01")
    local aigio_e002 = Motion.Object:new(NPC, "aigio_02", "e002")
    local aigio_blend01 = Motion.Object:new(NPC, "aigio_02", "blend01")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_05_078")
    Field.CancelPlayerAnywhereDigimonRide(false)
    WaitFrame(15)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 270, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -52.932, 1.573, 84.663)
    Cam.Inst:Set(-57.13, 0.82, 89.21, -52.94, 3.68, 80.6, default, 1)
    FieldObjectSync(FOR_ALL, false)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    aigio_e009:Play(10, true)
    tlk:Message("f_d0302_0130_0010")
    tlk:MessageClose()
    local result = tlk:Select(3, "f_d0302_0130_0020")
    if result == RESULT_TALK00 then
      tlk:Message("f_d0302_0130_0030")
    end
    if result == RESULT_TALK01 then
      tlk:Message("f_d0302_0130_0040")
    end
    aigio_fn01_01:Play(15, true)
    START_TALK_ACTION_AND_ZOOM("npc_0008", true, false)
    tlk:Message("f_d0302_0130_0050")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d0302_0130_0060")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    aigio_e002:Play(10, true)
    tlk:Message("f_d0302_0130_0070")
    tlk:Message("f_d0302_0130_0080")
    tlk:Message("f_d0302_0130_0090")
    START_TALK_ACTION_AND_ZOOM("npc_0008", false, false)
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    inori_e005:Play(10, true)
    tlk:Message("f_d0302_0130_0110")
    Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, NPC, npc_index02, 10, 10)
    Field.ObjectLookAtTheObject(NPC, npc_index02, FLD_OBJ_PLAYER, 1, 10, 10)
    inori_e002:Play(20, true)
    tlk:Message("f_d0302_0130_0120")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_05_085")
    WaitFrame(15)
    Cam.Inst:Clear(1)
    Field_Talk_End()
    END_TALK_ACTION_AND_ZOOM("npc_0008", true, true)
    FieldObjectSync(FOR_ALL, false)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_040)
  end
end

function M170:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m170_090")
    Flg.Set("FLAG_MAIN_05_087")
    WaitFrame(15)
    Common.SetDigimonGraspState(606, DIGIMON_GRASP_FLAG_JOIN)
    OpenInfoWindow(7030)
    Guest.Add(GST_HANGYO)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_045)
  end
end

function M170:Event_100_2()
  if Flg.Check("FLAG_MAIN_05_087", "FLAG_MAIN_05_105") then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_172"
    TIME_ZONE = NOON
  end
end

function M170:Event_101()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and not Flg.Check("FLAG_MAIN_05_095") then
    Fade_OutNoLoadingWithWait(FADE_BLACK, 5)
    local npc_index1 = Field.GetNpcIndex("hanngyo_01")
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index1, 60, 0)
    local npc_index2 = Field.GetNpcIndex("hanngyo_02")
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index2, 40, 0)
    local npc_index3 = Field.GetNpcIndex("hanngyo_03")
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index3, 70, 0)
    local hanngyo01_fe02 = Motion.Object:new(NPC, "hanngyo_03", "fe02")
    local hangyo_index = GetIndex(NPC, "hanngyo_P01")
    Field.ObjectLoadMotion(NPC, npc_index1, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index1, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index1, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index1, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index2, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index2, "e002")
    Field.ObjectLoadMotion(NPC, npc_index2, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index2, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index2, "fe02")
    Field.ObjectLoadMotion(NPC, npc_index2, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index3, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index3, "e002")
    Field.ObjectLoadMotion(NPC, npc_index3, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index3, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index3, "fe02")
    Field.ObjectLoadMotion(NPC, npc_index3, "fe04")
    Field.ObjectLoadMotion(NPC, hangyo_index, "bn01")
    Field.ObjectLoadMotion(NPC, hangyo_index, "e002")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fq01")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fq02")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fe02")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Flg.Set("FLAG_MAIN_05_105")
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 260, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 62.774, 5.461, -17.898)
    Cam.Inst:Set(57.510929, 7.229131, -14.685856, 63.257671, 6.526011, -22.839417, default, 1)
    FieldObjectSync(FOR_ALL, false)
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(25)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, 5)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index1, "fe04", 10, 10)
    tlk:Message("f_d0301_0060_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index1, "fq01", 10, 10)
    tlk:Message("f_d0301_0060_0020")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index, "fq01", 10, 10)
    tlk:Message("f_d0301_0060_0030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index1, "fq01", 10, 10)
    tlk:Message("f_d0301_0060_0040")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index, "fq02", 10, 10)
    tlk:Message("f_d0301_0060_0050")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index1, "fq02", 10, 10)
    tlk:Message("f_d0301_0060_0060")
    hanngyo01_fe02:Play(10, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index3, "e002", 10, 10)
    tlk:Message("f_d0301_0060_0070")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index1, "fe04", 10, 10)
    tlk:Message("f_d0301_0060_0080")
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 10, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index, "fe04", 10, 10)
    tlk:Message("f_d0301_0060_0090")
    Field.ObjectResetAim(PLAYER, 1, 20)
    tlk:EndTalk()
    EncountFromField_PlaySound(10510600, BTL_MAP_NEPVENUS_GROUND1, false)
  end
end

function M170:Event_102()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_MAIN_05_095", "FLAG_MAIN_05_102") then
    local hangyo_index = GetIndex(NPC, "hanngyo_P02")
    local aigio_index = GetIndex(NPC, "aigio_0001")
    Field.ObjectLoadMotion(NPC, hangyo_index, "bn01")
    Field.ObjectLoadMotion(NPC, hangyo_index, "e002")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fq01")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fq02")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fe02")
    Field.ObjectLoadMotion(NPC, hangyo_index, "fe04")
    Field.ObjectLoadMotion(NPC, aigio_index, "e002_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    FieldObjectSync(FOR_ALL, false)
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    Field.ObjectPlayMotion(PLAYER, 1, "e012", 10, true)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 260, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 61.715, 5.471, -18.527)
    Cam.Inst:Set(56.839653, 6.050372, -15.033112, 63.59828, 6.919646, -22.378119, default, 1)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d03")
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, aigio_index, "e002_01", 10, 10)
    tlk:Message("f_d0301_0060_0100")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index, "e002", 10, 10)
    tlk:Message("f_d0301_0060_0110")
    Flg.Set("FLAG_MAIN_05_102")
    FadeOutWithWait(0, 5)
    WaitFrame(15)
    tlk:EndTalk()
    Cam.Inst:Clear(1)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 230, 0)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    FieldObjectSync(FOR_ALL, false)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 0, true)
    WaitFrame(15)
    FadeInWithWait(0, 5)
  end
end

function M170:Event_103()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and not Flg.Check("FLAG_MAIN_05_096") then
    local hangyo_index_1 = GetIndex(NPC, "hanngyo_04")
    local hangyo_index_2 = GetIndex(NPC, "hanngyo_05")
    local hangyo_index_3 = GetIndex(NPC, "hanngyo_06")
    local hangyo_index_p = GetIndex(NPC, "hanngyo_P03")
    Field.ObjectLoadMotion(NPC, hangyo_index_1, "bn01")
    Field.ObjectLoadMotion(NPC, hangyo_index_1, "e002")
    Field.ObjectLoadMotion(NPC, hangyo_index_1, "fq01")
    Field.ObjectLoadMotion(NPC, hangyo_index_1, "fq02")
    Field.ObjectLoadMotion(NPC, hangyo_index_1, "fe02")
    Field.ObjectLoadMotion(NPC, hangyo_index_1, "fe04")
    Field.ObjectLoadMotion(NPC, hangyo_index_2, "bn01")
    Field.ObjectLoadMotion(NPC, hangyo_index_2, "e002")
    Field.ObjectLoadMotion(NPC, hangyo_index_2, "fq01")
    Field.ObjectLoadMotion(NPC, hangyo_index_2, "fq02")
    Field.ObjectLoadMotion(NPC, hangyo_index_2, "fe02")
    Field.ObjectLoadMotion(NPC, hangyo_index_2, "fe04")
    Field.ObjectLoadMotion(NPC, hangyo_index_3, "bn01")
    Field.ObjectLoadMotion(NPC, hangyo_index_3, "e002")
    Field.ObjectLoadMotion(NPC, hangyo_index_3, "fq01")
    Field.ObjectLoadMotion(NPC, hangyo_index_3, "fq02")
    Field.ObjectLoadMotion(NPC, hangyo_index_3, "fe02")
    Field.ObjectLoadMotion(NPC, hangyo_index_3, "fe04")
    Field.ObjectLoadMotion(NPC, hangyo_index_p, "bn01")
    Field.ObjectLoadMotion(NPC, hangyo_index_p, "e002")
    Field.ObjectLoadMotion(NPC, hangyo_index_p, "fq01")
    Field.ObjectLoadMotion(NPC, hangyo_index_p, "fq02")
    Field.ObjectLoadMotion(NPC, hangyo_index_p, "fe02")
    Field.ObjectLoadMotion(NPC, hangyo_index_p, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Fade_OutNoLoadingWithWait(FADE_BLACK, 5)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Flg.Set("FLAG_MAIN_05_106")
    WaitFrame(15)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 260, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 0.634, 1.156, 5.015)
    Cam.Inst:Set(-5.52, 1.65, 8.55, 3.42, 2.93, 4.25, default, 1)
    WaitFrame(1)
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(15)
    PlayerLookAtObject(NPC, "hanngyo_04")
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local hanngyo04_fq01 = Motion.Object:new(NPC, "hanngyo_04", "fq01")
    local hanngyo04_bn01 = Motion.Object:new(NPC, "hanngyo_04", "bn01")
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_1, "e002", 10, 10)
    tlk:Message("f_d0301_0070_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_1, "fq01", 10, 10)
    tlk:Message("f_d0301_0070_0020")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_1, "fe04", 10, 10)
    tlk:Message("f_d0301_0070_0030")
    tlk:MessageClose()
    WaitFrame(60)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_1, "fq01", 10, 10)
    tlk:Message("f_d0301_0070_0040")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_1, "fe04", 10, 10)
    tlk:Message("f_d0301_0070_0050")
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 10, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_p, "fe04", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_1, "e002", 10, 10)
    tlk:Message("f_d0301_0070_0060")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hangyo_index_1, "fe02", 10, 10)
    tlk:Message("f_d0301_0070_0070")
    tlk:EndTalk()
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 10, true)
    EncountFromField_PlaySound(10510700, BTL_MAP_NEPVENUS_GROUND1, false)
  end
end

function M170:Event_105()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_MAIN_05_096", "FLAG_MAIN_05_090") then
    Cam.Inst:Clear(0)
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(20)
  end
end

function M170:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) then
    Execute("m170_100")
  end
end

function M170:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) then
    Execute("m170_110")
    Flg.Set("FLAG_MAIN_05_090")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0303_0035_0010")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_050)
  end
end

function M170:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_055) then
    Qst.Main:Set(self.ID, self.STEP_055)
  end
end

function M170:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_060) then
    Qst.Main:Set(self.ID, self.STEP_060)
  end
end

function M170:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_060, self.STEP_065) then
    Cam.Inst:Set(63.62, 14.734, -39.489, 73.492, 13.442, -40.425, default, 30)
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0303_0040_0010")
    tlk:Message("f_d0303_0040_0020")
    tlk:Message("f_d0303_0040_0030")
    tlk:Message("f_d0303_0040_0040")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_065)
  end
end

function M170:Event_160()
  if Qst.Main:Check(self.ID, self.STEP_065, self.STEP_070) then
    Qst.Main:Set(self.ID, self.STEP_070)
  end
end

function M170:Event_163()
  if Qst.Main:Check(self.ID, self.STEP_070, self.STEP_071) then
    local hangyo_index = GetIndex(MOB, "mob_0031")
    Field.ObjectLoadMotion(MOB, hangyo_index, "bn01")
    Field.ObjectLoadMotion(MOB, hangyo_index, "e002")
    Field.ObjectLoadMotion(MOB, hangyo_index, "fq01")
    Field.ObjectLoadMotion(MOB, hangyo_index, "fq02")
    Field.ObjectLoadMotion(MOB, hangyo_index, "fe02")
    Field.ObjectLoadMotion(MOB, hangyo_index, "fe04")
    FadeOutWithWait(0, 5)
    WaitFrame(15)
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    Cam.Inst:Set(-61.969944, -10.761017, 97.870583, -52.688442, -8.828802, 101.051819, default, 1)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 250, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -55.98, -10.561, 99.127)
    Flg.Set("FLAG_MAIN_05_104")
    Field.ObjectCheckSync(FOR_ALL, true)
    WaitFrame(15)
    FadeInWithWait(0, 5)
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(MOB, hangyo_index, "e002", 10, 10)
    tlk:Message("f_d0303_0040_0050")
    Field.ObjectPlayMotionWithStartMoveMotion(MOB, hangyo_index, "e002", 10, 10)
    tlk:Message("f_d0303_0040_0070")
    tlk:MessageClose()
    Flg.Set("FLAG_FIELD_D0303_160")
    FadeOutWithWait(0, 5)
    WaitFrame(10)
    tlk:EndTalk()
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 280, 0)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    Guest.Delete(GST_HANGYO)
    Field.ObjectCheckSync(FOR_ALL, true)
    WaitFrame(25)
    FadeInWithWait(0, 5)
    Cam.Inst:Clear(45)
    Qst.Main:Set(self.ID, self.STEP_071)
  end
end

function M170:Event_165()
  if Qst.Main:Check(self.ID, self.STEP_071, self.STEP_075) and not Flg.Check("FLAG_MAIN_05_097") then
    local tlk = Tlk:new("d03", 1, true)
    local aigio_index = GetIndex(MOB, "mob_0032")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(MOB, aigio_index, "e018")
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0303_0070_0010")
    tlk:MessageClose()
    local result = tlk:Select(2, "f_d0303_0070_0020")
    if result == RESULT_TALK00 then
      BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Sound.StopBGM(1)
      WaitFrame(30)
      Flg.Set("FLAG_MAIN_05_103")
      Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 115, 0)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -79.54, -12.06, 95.405)
      SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
      Cam.Inst:Set(-72.951584, -10.064911, 97.225571, -82.881378, -11.247323, 97.193024, default, 1)
      FieldObjectSync(FOR_ALL, false)
      tlk:Message("f_d0303_0070_0030")
      tlk:MessageClose()
      WaitFrame(30)
      tlk:Message("f_d0303_0060_0010")
      tlk:MessageClose()
      Field_PlayBGM(928)
      BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
      Field.ObjectPlayMotion(MOB, aigio_index, "e018", 10, true)
      Field.ObjectPlayMotion(PLAYER, 1, "e018", 10, true)
      tlk:Message("f_d0303_0060_0020")
      tlk:EndTalk()
      EncountFromField_PlaySound(10510800, BTL_MAP_NEPVENUS_INSEA1, false)
    else
      tlk:EndTalk()
    end
  end
end

function M170:Event_167()
  if Qst.Main:Check(self.ID, self.STEP_071, self.STEP_075) and Flg.Check("FLAG_MAIN_05_097", "FLAG_MAIN_05_098") then
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    Field_PlayBGM(928)
    Motion.Player:Play("bn01", 0, true)
    Cam.Inst:Set(-72.951584, -10.064911, 97.225571, -82.881378, -11.247323, 97.193024, default, 1)
    FieldObjectSync(FOR_ALL, false)
    Field_InvisibleObjects(MOB, 1, 12)
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(30)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message("f_d0303_0080_0010")
    tlk:EndTalk()
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    Guest.Add(GST_HANGYO)
    Guest.Add(GST_SUBMARINE)
    EncountFromField_PlaySound(10510900, BTL_MAP_NEPVENUS_INSEA1, false)
  end
end

function M170:Event_170()
  if Qst.Main:Check(self.ID, self.STEP_071, self.STEP_075) and Flg.Check("FLAG_MAIN_05_098") then
    FieldObjectSync(FOR_ALL, false)
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    Cam.Inst:Set(-65.423233, -11.572155, 98.775551, -75.28611, -10.004575, 99.291618, default, 1)
    Motion.Player:Play("fn01_01", 0, true)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -71.554, -11.719, 97.558)
    Field_InvisibleObjects(MOB, 31, 32)
    Field_InvisibleObjects(MOB, 13, 21)
    WaitFrame(30)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local hanngyomon01_bn01 = Motion.Object:new(MOB, "mob_0022", "bn01")
    local hanngyomon01_e002 = Motion.Object:new(MOB, "mob_0022", "e002")
    local hanngyomon01_fq02 = Motion.Object:new(MOB, "mob_0022", "fq02")
    local sabumari01_bn01 = Motion.Object:new(MOB, "mob_0023", "bn01")
    local sabumari01_fq01 = Motion.Object:new(MOB, "mob_0023", "fq01")
    local sabumari01_fe02 = Motion.Object:new(MOB, "mob_0023", "fe02")
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    sabumari01_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0303_0060_0070")
    sabumari01_fe02:Play(10, true)
    hanngyomon01_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0303_0060_0090")
    hanngyomon01_e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message("f_d0303_0060_0100")
    tlk:MessageClose()
    Flg.Set("FLAG_MAIN_05_100")
    Field.ObjectCheckSync(FLD_OBJ_GIMMICK, false)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse01"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse02"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse03"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse04"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse05"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse05"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse06"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse06"):SetEnableCheckAndFieldAttack(true)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse01"):SetIcon(FLD_ICON_DIGIMON_RIDE)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse02"):SetIcon(FLD_ICON_DIGIMON_RIDE)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse03"):SetIcon(FLD_ICON_DIGIMON_RIDE)
    Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse04"):SetIcon(FLD_ICON_DIGIMON_RIDE)
    Qst.Main:Set(self.ID, self.STEP_075)
    FadeOutWithWait(0, 5)
    WaitFrame(25)
    tlk:EndTalk()
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 95, 0)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    Cam.Inst:Clear(1)
    OpenInfoWindow(7031)
    Common.SetDigimonGraspState(145, DIGIMON_GRASP_FLAG_SCAN)
    Field.ObjectCheckSync(FOR_ALL, true)
    WaitFrame(25)
    Digimon.RestoreAllParty()
    FadeInWithWait(0, 5)
  end
end

function M170:Event_180()
  if Qst.Main:Check(self.ID, self.STEP_075, self.STEP_080) then
    Qst.Main:Set(self.ID, self.STEP_080)
  end
end

function M170:Event_190()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_085) then
    Qst.Main:Set(self.ID, self.STEP_085)
  end
end

function M170:Event_200()
  if Qst.Main:Check(self.ID, self.STEP_085, self.STEP_090) then
    Qst.Main:Set(self.ID, self.STEP_090, false)
  end
end

function M170:Event_210()
  if Qst.Main:Check(self.ID, self.STEP_090, self.STEP_095) and not Flg.Check("FLAG_MAIN_05_101") then
    Execute("m170_130")
    Flg.Set("FLAG_IS_KEEP_BGM")
    EncountFromField(10520200, 10380, false)
  end
end

function M170:Event_220()
  if Qst.Main:Check(self.ID, self.STEP_090, self.STEP_095) and Flg.Check("FLAG_MAIN_05_101") then
    Field_InvisibleObjects(MOB, 24, 30)
    WaitFrame(30)
    Execute("m170_150")
    Qst.Main:Set(self.ID, self.STEP_095)
    Guest.Delete(GST_SUBMARINE)
    Digimon.RestoreAllParty()
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_173"
    TIME_ZONE = NOON
    MapChangeWithTimeTravel("d", 301, "start_20", TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
  end
end

function M170:Event_225()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_100) then
    Execute("m170_160")
    HideMinimap(false)
    HideGuide(false)
    MapChange("d", 308, "start_00", false, FADE_BLACK, 15)
  end
end

function M170:Event_230()
  if Qst.Main:Check(self.ID, self.STEP_095, self.STEP_100) then
    Flg.Set("FLAG_MAIN_05_107")
    Execute("m170_165")
    Qst.Main:Set(self.ID, self.STEP_100)
    MapChange("d", 301, "start_10", false, FADE_BLACK, FADE_TIME)
  end
end

function M170:Event_240()
  if Qst.Main:Check(self.ID, self.STEP_100, self.STEP_105) then
    Execute("m170_170")
    Flg.Set("FLAG_MAIN_05_110")
    Qst.Main:Set(self.ID, self.STEP_105)
    self:Event_250()
  end
end

function M170:Event_250()
  if Qst.Main:Check(self.ID, self.STEP_105, self.STEP_255) and not Flg.Check("FLAG_MAIN_05_120") then
    Execute("m170_180")
    Guest.Delete(GST_HANGYO)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("d", 303, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M170:Event_255()
  if Qst.Main:Check(self.ID, self.STEP_105, self.STEP_255) and not Flg.Check("FLAG_MAIN_05_120") then
    Flg.Set("FLAG_MAIN_05_120")
    Execute("m170_190")
    MapChange("d", 606, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M170:Event_260()
  if Qst.Main:Check(self.ID, self.STEP_105, self.STEP_255) and not Flg.Check("FLAG_MAIN_05_130") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m170_200")
    Flg.Set("FLAG_MAIN_05_130")
  end
end

function M170:Event_270()
  if Qst.Main:Check(self.ID, self.STEP_105, self.STEP_255) then
    Execute("m170_210")
    Flg.Set("FLAG_MAIN_05_990")
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(33)
    end
    Qst.Main:End(self.ID, self.STEP_255)
    M180:Event_010()
  end
end
