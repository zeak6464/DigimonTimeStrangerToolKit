gGimText = "field_text"
M390 = {
  ID = 390,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_018 = 18,
  STEP_020 = 20,
  STEP_023 = 23,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_040 = 40,
  STEP_050 = 50,
  STEP_055 = 55,
  STEP_060 = 60,
  STEP_065 = 65,
  STEP_068 = 68,
  STEP_070 = 70,
  STEP_071 = 71,
  STEP_072 = 72,
  STEP_073 = 73,
  STEP_074 = 74,
  STEP_075 = 75,
  STEP_080 = 80,
  STEP_083 = 83,
  STEP_085 = 85,
  STEP_087 = 87,
  STEP_090 = 90,
  STEP_255 = 255
}

function M390:Event_005()
  if Flg.Check("FLAG_MAIN_15_050", "FLAG_MAIN_17_010") then
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M390:Event_010()
  if Flg.Check("FLAG_MAIN_15_050", "FLAG_MAIN_17_010") then
    Flg.Set("FLAG_MAIN_17_010")
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "Z2028_daft_390"
    TIME_ZONE = NOON
  end
end

function M390:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_17_020")
    Execute("m390_010")
    FieldObjectSync(NPC, false)
    Guest.Add(GST_SIMONS)
    Guest.Add(GST_ASUKA_B)
    Guest.Add(GST_BEELSTARMON)
    FollowerSync()
    INFO_WINDOW(7041)
    Common.SetDigimonGraspState(195, DIGIMON_GRASP_FLAG_SCAN)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M390:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new("d12", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1204_0600_0010")
    tlk:Message("f_d1204_0600_0020")
    local result = tlk:Select(2, "f_d1204_0600_0030")
    if result == RESULT_TALK00 then
      tlk:Message("f_d1204_0600_0040")
      tlk:EndTalk()
      Qst.Main:Set(self.ID, self.STEP_010)
      WaitFrame(30)
      Flg.Set("FLAG_MAIN_17_030")
      MapChange("d", 1304, "start_00", true, FADE_BLACK, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MovePlayerToRelativePosFrame(-1, -1, 20)
      WaitFrame(25)
    end
    tlk:EndTalk()
  end
end

function M390:Event_031()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_17_030", "FLAG_MAIN_17_035") then
    Flg.Set("FLAG_MAIN_17_035")
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1304_0020_0010")
    tlk:Message("f_d1304_0020_0020")
    tlk:EndTalk()
  end
end

function M390:Event_032()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_17_035", "FLAG_MAIN_17_036") then
    Flg.Set("FLAG_MAIN_17_036")
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1301_0020_0020")
    tlk:EndTalk()
  end
end

function M390:Event_033()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_17_036", "FLAG_MAIN_17_037") then
    Flg.Set("FLAG_MAIN_17_037")
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1301_0030_0010")
    tlk:MessageClose()
    Cam.Inst:Set(9.302, 0, 5.571, 19.218, 1.145, 4.97, default, 30)
    Field.ObjectAdjustSpeedFrameMoveToTargetPos2D(ENEMY, GetIndex(ENEMY, "enemy_001"), 12.42, 9.86, 90)
    WaitFrame(100)
    tlk:Message("f_d1301_0030_0020")
    tlk:Message("f_d1301_0030_0030")
    Cam.Inst:Clear(30)
    WaitFrame(30)
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M390:Event_033A()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_018) then
    Qst.Main:Set(self.ID, self.STEP_018)
  end
end

function M390:Event_034()
  if Qst.Main:Check(self.ID, self.STEP_018, self.STEP_020) then
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Obj:new(PLAYER, ""):Invisible(15)
    Cam.Inst:Set(-17.94, -0.11, -32.39, -17.88, 1.82, -22.58, default, 30)
    WaitFrame(30)
    tlk:Message("f_d1301_0040_0010")
    Cam.Inst:Set(-17.438, 0.01, -33.492, -17.441, 1.973, -23.686, default, 30)
    WaitFrame(30)
    tlk:Message("f_d1301_0040_0020")
    tlk:Message("f_d1301_0040_0030")
    tlk:Message("f_d1301_0040_0040")
    tlk:Message("f_d1301_0040_0050")
    tlk:Message("f_d1301_0040_0060")
    Obj:new(PLAYER, ""):CancelInvisible(10)
    Cam.Inst:Clear(30)
    WaitFrame(30)
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_17_028")
    Qst.Main:Set(self.ID, self.STEP_020)
  else
    local tlk = Tlk:new("d13", 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Obj:new(PLAYER, ""):Invisible(15)
    Cam.Inst:Set(-17.438, 0.01, -33.492, -17.441, 1.973, -23.686, default, 30)
    WaitFrame(90)
    Obj:new(PLAYER, ""):CancelInvisible(10)
    Cam.Inst:Clear(30)
    WaitFrame(30)
    tlk:EndTalk()
  end
end

function M390:Event_034A()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_023) then
    Qst.Main:Set(self.ID, self.STEP_023)
  end
end

function M390:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Flg.Set("FLAG_MAIN_17_029")
    local simons = GetIndex(NPC, "npc_0002")
    Field.ObjectLoadMotion(NPC, simons, "e012")
    Field.ObjectLoadMotion(NPC, simons, "e002")
    Field.ObjectLoadMotion(NPC, simons, "e007")
    Field.ObjectLoadMotion(NPC, simons, "fn01_01")
    Field.ObjectLoadExpression(NPC, simons, "F01")
    local siroki = GetIndex(NPC, "npc_0035")
    Field.ObjectLoadMotion(NPC, siroki, "e002")
    Field.ObjectLoadMotion(NPC, siroki, "e008")
    Field.ObjectLoadMotion(NPC, siroki, "e013")
    Field.ObjectLoadMotion(NPC, siroki, "fn01_01")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    FieldObjectSync(NPC, false)
    WaitFrame(1)
    Cam.Inst:Set(-29.44, -0.649, -7.395, -19.95, 1.875, -5.51, default, 0)
    Obj:new(PLAYER, ""):SetPos(-22.667, 0, -6.499)
    Obj:new(PLAYER, ""):SetRotationY(270, 0)
    Obj:new(NPC, "npc_0035"):SetPos(-22.999, 0, -5.601)
    Obj:new(NPC, "npc_0035"):SetRotationY(320, 0)
    Obj:new(NPC, "npc_0036"):SetPos(-22.315, 0, -4.847)
    Obj:new(NPC, "npc_0036"):SetRotationY(300, 0)
    Field.ObjectPlayMotion(NPC, simons, "fn01_01", 0, true)
    Field.ObjectPlayMotion(NPC, siroki, "fn01_01", 0, true)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1301_0050_0010")
    tlk:Message("f_d1301_0050_0020")
    Field.ObjectPlayMotion(NPC, simons, "e012", 10, true)
    Field.ObjectChangeExpression(NPC, simons, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1301_0050_0030")
    Field.ObjectPlayMotion(NPC, simons, "e002", 10, true)
    tlk:Message("f_d1301_0050_0050")
    Field.ObjectPlayMotion(NPC, simons, "fn01_01", 10, true)
    Field.ObjectChangeExpression(NPC, simons, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotion(NPC, siroki, "e002", 10, true)
    tlk:Message("f_d1301_0050_0070")
    Field.ObjectPlayMotion(NPC, siroki, "e013", 10, true)
    tlk:Message("f_d1301_0050_0080")
    Field.ObjectPlayMotion(NPC, simons, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, simons, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1301_0050_0090")
    Field.ObjectPlayMotion(NPC, simons, "fn01_01", 10, true)
    Field.ObjectChangeExpression(NPC, simons, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    Qst.Main:Set(self.ID, self.STEP_025)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    tlk:EndTalk()
    Guest.Delete(GST_SIMONS)
    Guest.Delete(GST_ASUKA_B)
    Guest.Delete(GST_BEELSTARMON)
    FieldObjectSync(NPC, false)
    WaitFrame(1)
    FieldObjectSync(OGIM, false)
    WaitFrame(1)
    FollowerSync()
    Cam.Inst:Clear(0)
    SetFollowerCameraOperateRotation(0, 270)
    Obj:new(NPC, "npc_0035"):SetPos(-20.253, 0, -1.604)
    Obj:new(NPC, "npc_0035"):SetRotationY(180, 0)
    Obj:new(NPC, "npc_0036"):SetPos(-19.113, 0.001, -7.145)
    Obj:new(NPC, "npc_0036"):SetRotationY(90, 0)
    Field.ObjectPlayMotion(NPC, simons, "e012", 10, true)
    Field.ObjectPlayMotion(NPC, siroki, "e013", 10, true)
    Digimon.RestoreAllParty()
    WaitFrame(5)
    INFO_WINDOW(7042)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
  end
end

function M390:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Qst.Main:Set(self.ID, self.STEP_030)
    Digitter.Send(1390010010)
    Digimon.RestoreAllParty()
  end
end

function M390:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_040) then
    Qst.Main:Set(self.ID, self.STEP_040)
    Digitter.Send(1390010020)
    Digimon.RestoreAllParty()
  end
end

function M390:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_050) then
    Qst.Main:Set(self.ID, self.STEP_050)
    Digitter.Send(1390010030)
    Digimon.RestoreAllParty()
  end
end

function M390:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_055) and not Flg.Check("FLAG_GIMMICK_D13_110") and Flg.Check("FLAG_MAIN_17_031", "FLAG_MAIN_17_038") then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_17_038")
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(20)
    INFO_GET_ITEM(793, 1)
    WaitFrame(20)
    Field.ObjectPlayMotion(PLAYER, 1, "e503", 10, true)
    WaitFrame(20)
    tlk:Message("f_d1301_0330_0010")
    tlk:Message("f_d1301_0330_0020")
    tlk:EndTalk()
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fn01_01", 20, 20)
    Flg.Set("FLAG_GIMMICK_D13_110")
    Qst.Main:Set(self.ID, self.STEP_055)
  end
end

function M390:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_060) and Flg.Check("FLAG_MAIN_17_038", "FLAG_MAIN_17_032") then
    Flg.Set("FLAG_MAIN_17_043")
    local npc01_index = GetIndex(NPC, "npc_0002")
    Field.ObjectLoadMotion(NPC, npc01_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc01_index, "e002")
    Field.ObjectLoadMotion(NPC, npc01_index, "e005")
    Field.ObjectLoadMotion(NPC, npc01_index, "e006")
    Field.ObjectLoadMotion(NPC, npc01_index, "e008")
    Field.ObjectLoadMotion(NPC, npc01_index, "e017")
    Field.ObjectLoadMotion(NPC, npc01_index, "e018")
    Field.ObjectLoadExpression(NPC, npc01_index, "F01")
    Field.ObjectLoadMotion(PLAYER, 1, "bn01")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    local npc02_index = GetIndex(NPC, "npc_0010")
    Field.ObjectLoadMotion(NPC, npc02_index, "e012")
    Field.ObjectLoadMotion(NPC, npc02_index, "e018")
    local npc03_index = GetIndex(NPC, "npc_0011")
    Field.ObjectLoadMotion(NPC, npc03_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc03_index, "fe02")
    Guest.Add(GST_ASUKA_B)
    Guest.Add(GST_BEELSTARMON)
    Item.Delete(793, 1)
    Digimon.RestoreAllParty()
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Talk.NextNoVoice()
    tlk:Message("f_d1301_0090_0010")
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    Field.ObjectResetAim(NPC, npc01_index, 10)
    Field.ObjectPlayMotion(NPC, npc01_index, "e017", 10, true)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    FieldObjectSync(ENEMY, true)
    FieldObjectSync(NPC, false)
    WaitFrame(1)
    Obj:new(NPC, "npc_0010"):Invisible()
    Obj:new(NPC, "npc_0011"):Invisible()
    Obj:new(NPC, "npc_0012"):Invisible()
    Obj:new(NPC, "npc_0013"):Invisible()
    Obj:new(NPC, "npc_0018"):Invisible()
    Obj:new(NPC, "npc_0019"):Invisible()
    Obj:new(NPC, "npc_0020"):Invisible()
    Obj:new(NPC, "npc_0021"):Invisible()
    Obj:new(NPC, "npc_0022"):Invisible()
    Obj:new(NPC, "npc_0023"):Invisible()
    Obj:new(NPC, "npc_0024"):Invisible()
    Obj:new(NPC, "npc_0027"):Invisible()
    Obj:new(NPC, "npc_0028"):Invisible()
    Obj:new(NPC, "npc_0029"):Invisible()
    Obj:new(NPC, "npc_0030"):Invisible()
    Obj:new(NPC, "npc_0031"):Invisible()
    Field.ObjectPlayMotion(NPC, npc01_index, "fn01_01", 10, true)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.LoadEffectScript("ef_f_enc_110_rp", 5)
    local enemy1_index = GetIndex(NPC, "npc_0027")
    local enemy1_pos = Field.ObjectGetPosition(NPC, enemy1_index)
    local enemy2_index = GetIndex(NPC, "npc_0028")
    local enemy2_pos = Field.ObjectGetPosition(NPC, enemy2_index)
    local enemy3_index = GetIndex(NPC, "npc_0029")
    local enemy3_pos = Field.ObjectGetPosition(NPC, enemy3_index)
    local enemy4_index = GetIndex(NPC, "npc_0030")
    local enemy4_pos = Field.ObjectGetPosition(NPC, enemy4_index)
    local enemy5_index = GetIndex(NPC, "npc_0031")
    local enemy5_pos = Field.ObjectGetPosition(NPC, enemy5_index)
    local slot = Sound.PlaySE(402012, 100)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e006", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e006", 10, 10)
    tlk:Message("f_d1301_0090_0030")
    tlk:MessageClose()
    WaitFrame(15)
    Cam.Inst:Set(9.22, 0.13, -12.99, -0.27, 2.94, -11.67, default, 0)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy1_pos.x, enemy1_pos.y, enemy1_pos.z, 0, 1)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy2_pos.x, enemy2_pos.y, enemy2_pos.z, 0, 1)
    PlaySE(101017, 100)
    WaitFrame(10)
    Obj:new(NPC, "npc_0027"):CancelInvisible(15)
    Obj:new(NPC, "npc_0028"):CancelInvisible(15)
    WaitFrame(60)
    Cam.Inst:Set(9.11, 0.88, 13.26, -0.3, 2.92, 10.59, default, 0)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy3_pos.x, enemy3_pos.y, enemy3_pos.z, 0, 1)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy4_pos.x, enemy4_pos.y, enemy4_pos.z, 0, 1)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy5_pos.x, enemy5_pos.y, enemy5_pos.z, 0, 1)
    PlaySE(101017, 100)
    WaitFrame(10)
    Obj:new(NPC, "npc_0029"):CancelInvisible(15)
    Obj:new(NPC, "npc_0030"):CancelInvisible(15)
    Obj:new(NPC, "npc_0031"):CancelInvisible(15)
    WaitFrame(60)
    Cam.Inst:Clear(0)
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, npc01_index, "e008", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1301_0090_0040")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e018", 10, 10)
    tlk:Message("f_d1301_0090_0050")
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk()
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    Flg.Clear("FLAG_GIMMICK_D13_190")
    FieldObjectSync(FLD_OBJ_LOCATOR, false)
    WaitFrame(5)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -12.883, 0, -4.26)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 175, 0)
    Field.ObjectPlayMotion(PLAYER, 1, "bn01", 10, true)
    Cam.Inst:Set(-13.51, 0.02, -4.24, -10.8, 3.81, 4.6, default, 0)
    Obj:new(NPC, "npc_0010"):CancelInvisible()
    Obj:new(NPC, "npc_0011"):CancelInvisible()
    Obj:new(NPC, "npc_0012"):CancelInvisible()
    Obj:new(NPC, "npc_0013"):CancelInvisible()
    Obj:new(NPC, "npc_0018"):CancelInvisible()
    Obj:new(NPC, "npc_0019"):CancelInvisible()
    Obj:new(NPC, "npc_0020"):CancelInvisible()
    Obj:new(NPC, "npc_0021"):CancelInvisible()
    Obj:new(NPC, "npc_0022"):CancelInvisible()
    Obj:new(NPC, "npc_0023"):CancelInvisible()
    Obj:new(NPC, "npc_0024"):CancelInvisible()
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    Field.ObjectPlayMotion(NPC, npc02_index, "e018", 10, true)
    Field.ObjectPlayMotion(NPC, npc03_index, "fe02", 10, true)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
    WaitFrame(30)
    Guest.Add(GST_SIMONS)
    Sound.StopSE(slot, 1)
    EncountFromField_WithNormalEffect(4140011, 11373, true)
  end
end

function M390:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_060) and Flg.Check("FLAG_MAIN_17_032", "FLAG_MAIN_17_033") then
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Field.ObjectLoadMotion(PLAYER, 1, "bn01")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    local npc02_index = GetIndex(NPC, "npc_0010")
    Field.ObjectLoadMotion(NPC, npc02_index, "e012")
    Field.ObjectLoadMotion(NPC, npc02_index, "e018")
    local npc03_index = GetIndex(NPC, "npc_0011")
    Field.ObjectLoadMotion(NPC, npc03_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc03_index, "fe02")
    Field.ObjectPlayMotion(NPC, npc02_index, "e012", 10, true)
    Field.ObjectPlayMotion(NPC, npc03_index, "bn01", 10, true)
    Field.ObjectPlayMotion(PLAYER, 1, "bn01", 10, true)
    Digimon.RestoreAllParty()
    FieldObjectSync(NPC, false)
    WaitFrame(2)
    Field.LoadEffectScript("ef_f_enc_110_rp", 2)
    local enemy1_index = GetIndex(NPC, "npc_0014")
    local enemy1_pos = Field.ObjectGetPosition(NPC, enemy1_index)
    local enemy2_index = GetIndex(NPC, "npc_0015")
    local enemy2_pos = Field.ObjectGetPosition(NPC, enemy2_index)
    local enemy3_index = GetIndex(NPC, "npc_0025")
    local enemy3_pos = Field.ObjectGetPosition(NPC, enemy3_index)
    WaitFrame(1)
    Obj:new(NPC, "npc_0014"):Invisible()
    Obj:new(NPC, "npc_0015"):Invisible()
    Obj:new(NPC, "npc_0025"):Invisible()
    Cam.Inst:Set(-13.51, 0.02, -4.24, -10.8, 3.81, 4.6, default, 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local slot = Sound.PlaySE(402012, 100)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy1_pos.x, enemy1_pos.y, enemy1_pos.z, 0, 1)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy2_pos.x, enemy2_pos.y, enemy2_pos.z, 0, 1)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy3_pos.x, enemy3_pos.y, enemy3_pos.z, 0, 1)
    WaitFrame(10)
    Obj:new(NPC, "npc_0014"):CancelInvisible(15)
    Obj:new(NPC, "npc_0015"):CancelInvisible(15)
    Obj:new(NPC, "npc_0025"):CancelInvisible(15)
    WaitFrame(60)
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1301_0100_0010")
    tlk:EndTalk()
    WaitFrame(30)
    Field.ObjectPlayMotion(NPC, npc02_index, "e018", 10, true)
    Field.ObjectPlayMotion(NPC, npc03_index, "fe02", 10, true)
    Field.ObjectPlayMotion(PLAYER, 1, "bc01", 10, true)
    WaitFrame(15)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Sound.StopSE(slot, 1)
    EncountFromField_WithNormalEffect(4140012, 11373, true)
  end
end

function M390:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_060) and Flg.Check("FLAG_MAIN_17_033", "FLAG_MAIN_17_034") then
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Field.ObjectLoadMotion(PLAYER, 1, "bn01")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    local npc02_index = GetIndex(NPC, "npc_0010")
    Field.ObjectLoadMotion(NPC, npc02_index, "e012")
    Field.ObjectLoadMotion(NPC, npc02_index, "e018")
    local npc03_index = GetIndex(NPC, "npc_0011")
    Field.ObjectLoadMotion(NPC, npc03_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc03_index, "fe02")
    Field.ObjectPlayMotion(NPC, npc02_index, "e012", 10, true)
    Field.ObjectPlayMotion(NPC, npc03_index, "bn01", 10, true)
    Field.ObjectPlayMotion(PLAYER, 1, "bn01", 10, true)
    Digimon.RestoreAllParty()
    FieldObjectSync(NPC, false)
    WaitFrame(2)
    Field.LoadEffectScript("ef_f_enc_110_rp", 2)
    local enemy1_index = GetIndex(NPC, "npc_0016")
    local enemy1_pos = Field.ObjectGetPosition(NPC, enemy1_index)
    local enemy2_index = GetIndex(NPC, "npc_0017")
    local enemy2_pos = Field.ObjectGetPosition(NPC, enemy2_index)
    local enemy3_index = GetIndex(NPC, "npc_0026")
    local enemy3_pos = Field.ObjectGetPosition(NPC, enemy3_index)
    WaitFrame(5)
    Obj:new(NPC, "npc_0016"):Invisible()
    Obj:new(NPC, "npc_0017"):Invisible()
    Obj:new(NPC, "npc_0026"):Invisible()
    Cam.Inst:Set(-13.51, 0.02, -4.24, -10.8, 3.81, 4.6, default, 0)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local slot = Sound.PlaySE(402012, 100)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy1_pos.x, enemy1_pos.y, enemy1_pos.z, 0, 1)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy2_pos.x, enemy2_pos.y, enemy2_pos.z, 0, 1)
    Field.PlayEffectScript("ef_f_enc_110_rp", enemy3_pos.x, enemy3_pos.y, enemy3_pos.z, 0, 1)
    WaitFrame(10)
    Obj:new(NPC, "npc_0016"):CancelInvisible(15)
    Obj:new(NPC, "npc_0017"):CancelInvisible(15)
    Obj:new(NPC, "npc_0026"):CancelInvisible(15)
    WaitFrame(60)
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1301_0110_0010")
    tlk:EndTalk()
    WaitFrame(30)
    Field.ObjectPlayMotion(NPC, npc02_index, "e018", 10, true)
    Field.ObjectPlayMotion(NPC, npc03_index, "fe02", 10, true)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
    WaitFrame(15)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Sound.StopSE(slot, 1)
    EncountFromField_WithNormalEffect(4140013, 11373, true)
  end
end

function M390:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_055, self.STEP_060) and Flg.Check("FLAG_MAIN_17_034", "FLAG_MAIN_17_039") then
    local rot = Field.ObjectGetRotationTargetY(PLAYER, 1)
    Field.SetFollowerCameraOperateRotationY(rot + 180, 0)
    Digimon.RestoreAllParty()
    FieldObjectSync(NPC, false)
    Cam.Inst:Clear(0)
    Field.ObjectResetMotion(PLAYER, 1, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1301_0120_0010")
    tlk:Message("f_d1301_0120_0020")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Flg.Set("FLAG_GIMMICK_D13_040")
    Flg.Set("FLAG_MAIN_17_039")
    Guest.Add(GST_SIMONS)
    FieldObjectSync(NPC, false)
    Field.FollowerWarp()
    WaitFrame(15)
    INFO_WINDOW(7041)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0009"), true)
    Qst.Main:Set(self.ID, self.STEP_060)
  end
end

function M390:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_060, self.STEP_065) then
    Flg.Set("FLAG_MAIN_17_044")
    Field.SetEnableGimmickCheck("gim_0009", false)
    PlayerCheckGimmick("gim_0009", 10, "fg07_m01", 0, false)
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1301_0130_0010")
    Motion.Gimmick:Play("gim_0009", "e001", false)
    Motion.Gimmick:Play("gim_0008", "e001", false)
    ColOff("wall_cl_0002")
    WaitFrame(60)
    Flg.Set("FLAG_GIMMICK_D13_150")
    tlk:Message("f_d1301_0130_0020")
    tlk:MessageClose()
    WaitFrame(20)
    INFO_GET_ITEM(794, 1)
    WaitFrame(20)
    tlk:EndTalk()
    MapChange("d", 1302, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function M390:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_060, self.STEP_065) then
    Qst.Main:Set(self.ID, self.STEP_065)
  end
end

function M390:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_065, self.STEP_068) then
    Qst.Main:Set(self.ID, self.STEP_068)
  end
end

function M390:Event_600()
  if Qst.Main:Check(self.ID, self.STEP_068, self.STEP_070) then
    Flg.Set("FLAG_MAIN_17_040")
    Execute("m390_020")
    MapChangeWithTimePasses("t", 3001, "start_00", NIGHT)
  end
end

function M390:Event_601()
  if Qst.Main:Check(self.ID, self.STEP_068, self.STEP_070) then
    Obj:new(PLAYER, ""):SetPos(0, 0, 0)
    Obj:new(NPC, "farm_0001"):SetPos(0, 0, -1.345)
    Obj:new(NPC, "farm_0001"):SetRotationY(180, 0)
    Cam.Inst:Set(-1.867, -2.1, -8.18, 0.433, 1.822, 0.725, default, 0)
    local npc01_index = GetIndex(NPC, "farm_0001")
    Field.ObjectLoadMotion(NPC, npc01_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc01_index, "e002")
    Field.ObjectLoadMotion(NPC, npc01_index, "e003")
    Field.ObjectLoadMotion(NPC, npc01_index, "e021")
    Field.ObjectLoadExpression(NPC, npc01_index, "F01")
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    local tlk = Tlk:new("t30", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t3001_0180_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e003", 10, 10)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t3001_0180_0020")
    Field.ObjectPlayMotion(NPC, npc01_index, "e021", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t3001_0180_0030")
    Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t3001_0180_0040")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e003", 10, 10)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t3001_0180_0050")
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 5, AUTO_CANCEL_SYNC_WITH_MOTION, 5)
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(30)
    Execute("m390_030")
    Execute("m390_040")
    Execute("m390_041")
    MapChangeWithTimePasses("d", 1303, "start_00", NOON)
  end
end

function M390:Event_601A()
  if Qst.Main:Check(self.ID, self.STEP_068, self.STEP_070) and Flg.Check("FLAG_MAIN_17_040", "FLAG_MAIN_17_040A") then
    Flg.Set("FLAG_MAIN_17_040A")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m390_050")
    Obj:new(PLAYER, ""):SetPos(-6.728, 0, -2.251)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_070)
  end
end

function M390:Event_602()
  if Qst.Main:Check(self.ID, self.STEP_070, self.STEP_071) then
    Qst.Main:Set(self.ID, self.STEP_071)
  end
end

function M390:Event_603()
  if Qst.Main:Check(self.ID, self.STEP_071, self.STEP_072) then
    Qst.Main:Set(self.ID, self.STEP_072)
  end
end

function M390:Event_604()
  if Qst.Main:Check(self.ID, self.STEP_072, self.STEP_073) then
    Qst.Main:Set(self.ID, self.STEP_073)
  end
end

function M390:Event_605()
  if Qst.Main:Check(self.ID, self.STEP_070, self.STEP_071) and Flg.Check("FLAG_MAIN_17_040", "FLAG_MAIN_17_047") then
    Flg.Set("FLAG_MAIN_17_047")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m390_055")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M390:Event_610()
  if Qst.Main:Check(self.ID, self.STEP_073, self.STEP_074) and Flg.Check("FLAG_MAIN_17_040", "FLAG_MAIN_17_041") then
    Flg.Set("FLAG_MAIN_17_041")
    local simons_index = GetIndex(NPC, "npc_1001")
    Field.ObjectLoadMotion(NPC, simons_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, simons_index, "e023")
    Field.ObjectLoadMotion(NPC, simons_index, "e002")
    Field.ObjectLoadMotion(NPC, simons_index, "e018")
    Field.ObjectLoadMotion(NPC, simons_index, "e021")
    Field.ObjectLoadMotion(NPC, simons_index, "e003")
    Field.ObjectLoadMotion(NPC, simons_index, "e013")
    Field.ObjectLoadExpression(NPC, simons_index, "F01")
    local asuka_index = GetIndex(NPC, "npc_1002")
    Field.ObjectLoadMotion(NPC, asuka_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, asuka_index, "e008")
    Field.ObjectLoadMotion(NPC, asuka_index, "e002")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    FieldObjectSync(NPC, false)
    Field.ObjectSetPos(PLAYER, 1, -34.55, 0, 10.95)
    Field.ObjectSetRotationY(PLAYER, 1, -30, 0)
    Cam.Inst:Set(-39.58, 0.25, 5.03, -32.57, 1.6, 12.04, default, 0)
    local tlk = Tlk:new("t02", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, simons_index, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0203_0030_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e018", 10, 10)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0203_0030_0020")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    Field.ObjectPlayMotion(NPC, asuka_index, "e002", 10, true)
    tlk:Message("f_t0203_0030_0030")
    Field.ObjectPlayMotion(NPC, simons_index, "e021", 10, true)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0203_0030_0040")
    Field.ObjectPlayMotion(NPC, simons_index, "fn01_01", 10, true)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    Field.ObjectPlayMotion(NPC, asuka_index, "e008", 10, true)
    tlk:Message("f_t0203_0030_0050")
    Field.ObjectPlayMotion(NPC, asuka_index, "fn01_01", 10, true)
    Field.ObjectPlayMotion(NPC, simons_index, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0203_0030_0070")
    Field.ObjectPlayMotion(NPC, simons_index, "e013", 10, true)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0203_0030_0090")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    Flg.Clear("FLAG_GIMMICK_D13_070")
    Flg.Clear("FLAG_GIMMICK_D13_130")
    Flg.Clear("FLAG_GIMMICK_D13_240")
    Flg.Set("FLAG_MAIN_17_046")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    FieldObjectSync(NPC, false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), true)
    Obj:new(FLD_OBJ_LOCATOR, "obj_0003"):CancelInvisible()
    Obj:new(PLAYER, ""):SetPos(-38.483, 0, 10.452)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    SetFollowerCameraOperateRotation(0, 180)
    WaitFrame(5)
    Guest.Delete(GST_SIMONS)
    Guest.Delete(GST_ASUKA_B)
    Guest.Delete(GST_BEELSTARMON)
    FollowerSync()
    Cam.Inst:Clear(0)
    tlk:EndTalk()
    WaitFrame(5)
    INFO_WINDOW(7042)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_074)
  end
end

function M390:Event_620()
  if Qst.Main:Check(self.ID, self.STEP_074, self.STEP_075) and Flg.Check("FLAG_MAIN_17_041", "FLAG_MAIN_17_050") then
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    local tlk = Tlk:new("t04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    if not Flg.Check("FLAG_MAIN_17_045") then
      tlk:Message("f_t0408_0070_0010")
      tlk:MessageClose()
      Field.ObjectPlayMotion(PLAYER, 1, "e002", 10, false)
      WaitFrame(60)
      tlk:Message("f_t0408_0070_0020")
      tlk:Message("f_t0408_0070_0030")
      Flg.Set("FLAG_MAIN_17_045")
    end
    tlk:Message("f_t0408_0070_0040")
    local result = tlk:Select(2, "f_t0408_0070_0050")
    if result == RESULT_TALK00 then
      tlk:Message("f_t0408_0070_0060")
      tlk:EndTalk()
      FadeOutWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(90)
      MapChange("d", 1002, "start_03", false, FADE_BLACK, FADE_TIME)
    elseif result == RESULT_TALK01 then
      tlk:Message("f_t0408_0070_0080")
      tlk:EndTalk()
    end
  end
end

function M390:Event_625()
  if Qst.Main:Check(self.ID, self.STEP_074, self.STEP_075) then
    Execute("m390_057")
    MapChange("d", 1401, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M390:Event_650()
  if Qst.Main:Check(self.ID, self.STEP_074, self.STEP_075) then
    Flg.Set("FLAG_MAIN_17_050")
    Execute("m390_060")
    MapChangeWithTimeTravel("t", 3002, "start_00", AXIS_ORIGINAL, "Z2028_daft_390", NIGHT)
  end
end

function M390:Event_660()
  if Qst.Main:Check(self.ID, self.STEP_074, self.STEP_075) and Flg.Check("FLAG_MAIN_17_050", "FLAG_MAIN_17_060") then
    Flg.Set("FLAG_MAIN_17_060")
    Flg.Clear("FLAG_GIMMICK_D13_140")
    WaitFrame(30)
    Execute("m390_070")
    Qst.Main:Set(self.ID, self.STEP_075)
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    local org_prefix = "d"
    local org_number = 1304
    local org_locator = "start_03"
    local org_time_zone = noon
    Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
    MapChange("t", 3001, "start_01", false, FADE_BLACK, FADE_TIME)
  end
end

function M390:Event_670()
  if Qst.Main:Check(self.ID, self.STEP_075, self.STEP_080) then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    local door = Motion.Object:new(FLD_OBJ_GIMMICK, "theater_0001", "e005")
    Cam.Inst:Set(-14.866, 2.399, -15.708, -14.65, 1.098, -5.796, default, 0)
    local pc = Obj:new(PLAYER, "")
    pc:SetPos(-14.674, 0, -8.308, true)
    pc:SetRotationY(180, 0)
    PlaySE(401055, 100)
    WaitFrame(45)
    door:Play(0, false)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(80)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    SetFollowerCameraOperateRotation(-10, pc.rot_y + 180)
    Flg.Set("FLAG_MAIN_17_061")
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    pc:SetRotationY(0, 0)
    WaitFrame(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false, true)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    Cam.Inst:Set(-7.283, 12.1, 7.721, -5.347, 12.997, 17.49, default, 30)
    WaitFrame(30)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1304_0030_0010")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    WaitFrame(30)
    Qst.Main:Set(self.ID, self.STEP_080)
  end
end

function M390:Event_671()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_085) and Flg.Check("FLAG_MAIN_17_061", "FLAG_MAIN_17_062") then
    SetControlScriptExternalVariable("researcher_state", "start")
    Cam.Inst:Set(9.302, 0, 5.571, 19.218, 1.145, 4.97, default, 30)
    WaitFrame(120)
    Cam.Inst:Clear(30)
    Obj:new(NPC, "npc_0003"):Invisible(5)
    Flg.Set("FLAG_MAIN_17_062")
  end
end

function M390:Event_675()
  if Qst.Main:Check(self.ID, self.STEP_080, self.STEP_083) then
    Qst.Main:Set(self.ID, self.STEP_083)
  end
end

function M390:Event_680()
  if Qst.Main:Check(self.ID, self.STEP_083, self.STEP_085) then
    Flg.Set("FLAG_MAIN_17_070")
    FieldObjectSync(FOR_ALL, true)
    Execute("m390_080")
    Qst.Main:Set(self.ID, self.STEP_085)
    Guest.Add(GST_VULCANUS)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    INFO_WINDOW(7043)
    Common.SetDigimonGraspState(178, DIGIMON_GRASP_FLAG_SCAN)
    Flg.Set("FLAG_MAIN_17_071")
  end
end

function M390:Event_685()
  if Qst.Main:Check(self.ID, self.STEP_085, self.STEP_087) then
    Qst.Main:Set(self.ID, self.STEP_087)
  end
end

function M390:Event_690()
  if Qst.Main:Check(self.ID, self.STEP_087, self.STEP_090) and Flg.Check("FLAG_MAIN_17_070", "FLAG_MAIN_17_080") then
    Field.ObjectInvisible(OGIM, GetIndex(OGIM, "elv_shutter_01"), 0, 0, true)
    Execute("m390_090")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(11600200, 11371, false)
  end
end

function M390:Event_700()
  if Qst.Main:Check(self.ID, self.STEP_087, self.STEP_090) and Flg.Check("FLAG_MAIN_17_080", "FLAG_MAIN_17_090") then
    Flg.Set("FLAG_MAIN_17_090")
    Field.ObjectCancelInvisible(OGIM, GetIndex(OGIM, "elv_shutter_01"), 0, 0, true, true)
    Guest.Delete(GST_VULCANUS)
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    local org_prefix = "d"
    local org_number = 1204
    local org_locator = "start_50"
    local org_time_zone = noon
    Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("t", 3001, "start_00", AXIS_ORIGINAL, "A2028_daft_400", NIGHT)
  end
end

function M390:Event_710()
  if Qst.Main:Check(self.ID, self.STEP_087, self.STEP_090) and Flg.Check("FLAG_MAIN_17_090", "FLAG_MAIN_17_100") then
    Execute("m390_120")
    Prcs_t3001_12GodsReliefInvisible(true)
    Execute("m390_130")
    Flg.Set("FLAG_MAIN_17_100")
    Prcs_t3001_12GodsReliefInvisible(false)
    Flg.Set("FLAG_GIMMICK_T0301_007")
    Prcs_t3001_12GodsReliefSeting()
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(87)
      Common.SetAegiomonGiftPoint(60000)
    end
    Qst.Main:Set(self.ID, self.STEP_090)
    Field.SetFollowerCameraOperateRotationY(0, 0)
    Field.SetFollowerCameraOperateRotationX(-15, 0)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
  end
end

function M390:Event_720()
  if Qst.Main:Check(self.ID, self.STEP_090, self.STEP_255) then
    Qst.Main:End(self.ID, self.STEP_255)
  end
end

function M390:ChapterFlagSet(progress)
  local step = {}
  if 1 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 11 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 12 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 14 <= progress then
    step[#step + 1] = self.STEP_015
  end
  if 20 <= progress then
    step[#step + 1] = self.STEP_018
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_023
    step[#step + 1] = self.STEP_025
    step[#step + 1] = self.STEP_030
    step[#step + 1] = self.STEP_040
    step[#step + 1] = self.STEP_050
    step[#step + 1] = self.STEP_055
    step[#step + 1] = self.STEP_060
  end
  if 25 <= progress then
    step[#step + 1] = self.STEP_065
    step[#step + 1] = self.STEP_068
    step[#step + 1] = self.STEP_070
    step[#step + 1] = self.STEP_071
    step[#step + 1] = self.STEP_072
    step[#step + 1] = self.STEP_073
  end
  if 27 <= progress then
    step[#step + 1] = self.STEP_074
  end
  if 60 <= progress then
    step[#step + 1] = self.STEP_075
    step[#step + 1] = self.STEP_080
    step[#step + 1] = self.STEP_083
  end
  if 70 <= progress then
    step[#step + 1] = self.STEP_085
  end
  Qst.Main:Chapter(step, self.ID)
end
