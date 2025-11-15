gGimText = "field_text"
M210 = {
  ID = 210,
  STEP_001 = 1,
  STEP_003 = 3,
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

function M210:Event_010()
  if Flg.Check("FLAG_MAIN_07_053", "FLAG_MAIN_07_054") then
    Flg.Set("FLAG_MAIN_07_054")
    Qst.Main:Start(self.ID, self.STEP_001)
    INFO_WINDOW(7038)
    Guest.Add(GST_BLACKTAIL)
    FollowerSync()
    Common.SetDigimonGraspState(43, DIGIMON_GRASP_FLAG_SCAN)
    Obj:new(PLAYER, ""):SetRotationY(250, 0)
    SetFollowerCameraOperateRotation(5, 230)
    Digitter.Send(1210010010)
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
    MapChange("t", 102, "start_04", false, FADE_WHITE, 0)
  end
end

function M210:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and not Flg.Check("FLAG_MAIN_07_054B") then
    Flg.Set("FLAG_MAIN_07_054B")
    local tlk = Tlk:new("t01", 1, true)
    Field.StartPlayerAndNpcTalkAction("npc_3126")
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0102_0210_0030")
    tlk:Message("f_t0102_0210_0040")
    tlk:MessageClose()
    ColOff("cliff_cl_0001")
    Obj:new(OGIM, "obj_shield_f01"):Invisible(15)
    Obj:new(OGIM, "obj_shield_f02"):Invisible(15)
    Obj:new(OGIM, "obj_shield_f03"):Invisible(15)
    Obj:new(OGIM, "obj_shield_f04"):Invisible(15)
    WaitFrame(30)
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_003)
  end
end

function M210:Event_017()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_210"
    TIME_ZONE = NOON
  end
end

function M210:Event_018()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Digitter.Send(1210010020)
  end
end

function M210:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Flg.Set("FLAG_MAIN_07_055")
    Obj:new(FLD_OBJ_LOCATOR, "change_0002"):SetEnableCheckAndFieldAttack(true)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_005)
    Digitter.Send(1210020010)
  end
end

function M210:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Digitter.Send(1210020020)
  end
end

function M210:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    if not Flg.Check("FLAG_MAIN_07_056") then
      Flg.Set("FLAG_MAIN_07_056")
      Cam.Inst:Set(-36.09, 3.2, 13.15, -46.03, 2.1, 13.41, default, 30)
      WaitFrame(30)
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d1101_0100_0010")
      tlk:Message("f_d1101_0100_0020")
      tlk:Message("f_d1101_0100_0040")
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      FieldObjectSync(FOR_ALL, false)
      Digitter.Send(1210020030)
    else
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d1101_0100_0050")
      tlk:EndTalk()
    end
  end
end

function M210:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check("FLAG_MAIN_07_057") then
    Cam.Inst:Set(17.85, 8.54, -23.06, 9.27, 3.41, -22.88, default, 30)
    WaitFrame(45)
    local npc_index = GetIndex(NPC, "npc_0709")
    Field.ResetPlayer(9.9, 0, -23.725, 90)
    Obj:new(NPC, "npc_0709"):CancelInvisible()
    Obj:new(NPC, "blacktail_002"):CancelInvisible()
    WaitFrame(45)
    Field.ObjectLookAtTheObject(PLAYER, 1, FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "duct_aim"), 15)
    Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "duct_aim"), 15)
    Cam.Inst:Set(16.05, 4.39, -23.24, 6.5, 0.68, -23.15, default, 30)
    WaitFrame(60)
    local e002 = Motion.Object:new(NPC, "npc_0709", "e002")
    local e004 = Motion.Object:new(NPC, "npc_0709", "e004")
    local tlk = Tlk:new("d11", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    e004:Play(10, true)
    tlk:Message("f_d1101_0110_0010")
    tlk:Message("f_d1101_0110_0020")
    tlk:Message("f_d1101_0110_0030")
    tlk:EndTalk()
    Field.ObjectResetAim(PLAYER, 1, 15)
    Field.ObjectResetAim(NPC, npc_index, 15)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
  end
end

function M210:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local npc_index = GetIndex(NPC, "npc_0700")
    Field.ObjectLoadExpression(NPC, npc_index, "F01")
    if not Flg.Check("FLAG_MAIN_07_057") then
      Flg.Set("FLAG_MAIN_07_057")
      FieldObjectSync(FOR_ALL, false)
      Obj:new(NPC, "npc_0709"):Invisible()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
      Cam.Inst:Set(-14.681395, 2, 40.870102, -5.461701, 3.848161, 37.466923, default, 1)
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      local tlk = Tlk:new("d11", 1, true)
      local npc_0702_e018 = Motion.Object:new(NPC, "npc_0702", "e018")
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d1101_0120_0010")
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_0701"), 20)
      tlk:Message("f_d1101_0120_0020")
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      npc_0702_e018:Play(10, true)
      tlk:Message("f_d1101_0120_0030")
      tlk:EndTalk()
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      local aegio = Field.GetFollowerIndexForAegiomon()
      local heroine = Field.GetFollowerIndexByGuestID(GST_HEROINE)
      Field.ObjectInvisible(FLD_OBJ_FOLLOWER, heroine, 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_FOLLOWER, aegio, 0, 0, false)
      Cam.Inst:Clear(30)
      Obj:new(PLAYER, ""):SetRotationY(230, 0)
      SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
      WaitFrame(30)
    end
  end
end

function M210:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    if not Flg.Check("FLAG_MAIN_07_058") then
      EncountFromField_PlaySound(10800100, 11171, false)
    end
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
  end
end

function M210:Event_060()
  local asuna_index = GetIndex(NPC, "koan_0002")
  local tail_index = GetIndex(NPC, "blacktail_001")
  Field.ObjectLoadExpression(NPC, asuna_index, "F01")
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    if Flg.Check("FLAG_MAIN_07_058") then
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      local tlk = Tlk:new("d11", 1, true)
      local t_bn01 = Motion.Object:new(NPC, "blacktail_001", "bn01")
      local t_fe04 = Motion.Object:new(NPC, "blacktail_001", "fe04")
      local e012 = Motion.Object:new(NPC, "koan_0002", "e012")
      local e013 = Motion.Object:new(NPC, "koan_0002", "e013")
      local e020 = Motion.Object:new(NPC, "koan_0002", "e020")
      local e002 = Motion.Object:new(NPC, "koan_0002", "e002")
      local e006 = Motion.Object:new(NPC, "koan_0002", "e006")
      local e008 = Motion.Object:new(NPC, "koan_0002", "e008")
      FieldObjectSync(FOR_ALL, false)
      WaitFrame(15)
      Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 180, 0)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -23.044, 0, 40.736)
      Cam.Inst:Set(-19.66, 0, 45.11, -26.71, 1.62, 39.41, default, 1)
      WaitFrame(15)
      Field.ObjectLookAtTheObject(NPC, asuna_index, NPC, tail_index, 15, 10)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      tlk:StartTalkAndCancelDigimonRide()
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      e006:Play(10, true)
      tlk:Message("f_d1101_0130_0010")
      tlk:MessageClose()
      t_fe04:PlayWithStartMoveMotion(10, 10)
      WaitFrame(60)
      Field.ObjectResetAim(NPC, asuna_index, 30)
      e008:Play(10, true)
      tlk:Message("f_d1101_0130_0020")
      tlk:Message("f_d1101_0130_0025")
      e002:Play(10, true)
      tlk:Message("f_d1101_0130_0030")
      tlk:MessageClose()
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      Motion.Player:PlayWithMoveMotion("e002", 5, 5)
      WaitFrame(30)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(30)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      e012:Play(10, true)
      tlk:Message("f_d1101_0130_0040")
      tlk:Message("f_d1101_0130_0050")
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Flg.Set("FLAG_MAIN_07_058B")
      WaitFrame(15)
      tlk:EndTalk()
      FieldObjectSync(FOR_ALL, false)
      Cam.Inst:Clear(1)
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      local aegio = Field.GetFollowerIndexForAegiomon()
      local heroine = Field.GetFollowerIndexByGuestID(GST_HEROINE)
      Field.ObjectInvisible(FLD_OBJ_FOLLOWER, heroine, 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_FOLLOWER, aegio, 0, 0, false)
      WaitFrame(15)
      SetFollowerCameraOperateRotation(-5, 135)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Qst.Main:Set(self.ID, self.STEP_010)
    end
  elseif Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new("d11", 1, true)
    local e012 = Motion.Object:new(NPC, "koan_0002", "e012")
    local e002 = Motion.Object:new(NPC, "koan_0002", "e002")
    tlk:StartTalkAndCancelDigimonRide()
    Field.StartPlayerAndNpcTalkAction("koan_0002")
    e002:Play(10, true)
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1101_0130_0060")
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    e012:Play(10, true)
    tlk:EndTalk()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    local aegio = Field.GetFollowerIndexForAegiomon()
    local heroine = Field.GetFollowerIndexByGuestID(GST_HEROINE)
    Field.ObjectInvisible(FLD_OBJ_FOLLOWER, heroine, 0, 0, false)
    Field.ObjectInvisible(FLD_OBJ_FOLLOWER, aegio, 0, 0, false)
  end
end

function M210:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_07_059") then
    Flg.Set("FLAG_MAIN_07_059")
    local tlk = Tlk:new("d11", 1, true)
    local e004 = Motion.Object:new(NPC, "npc_0710", "e004")
    tlk:StartTalkAndCancelDigimonRide()
    e004:Play(10, true)
    tlk:Message("f_d1101_0140_0010")
    tlk:EndTalk()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
  end
end

function M210:Event_075()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M210:Event_080()
  local asuna_index = GetIndex(NPC, "koan_0003")
  local tail_index = GetIndex(NPC, "blacktail_003")
  Field.ObjectLoadExpression(NPC, asuna_index, "F01")
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and not Flg.Check("FLAG_MAIN_07_060") then
    Flg.Set("FLAG_MAIN_07_060")
    local tlk = Tlk:new("d11", 1, true)
    local e012 = Motion.Object:new(NPC, "koan_0003", "e012")
    local e013 = Motion.Object:new(NPC, "koan_0003", "e013")
    local e020 = Motion.Object:new(NPC, "koan_0003", "e020")
    local e002 = Motion.Object:new(NPC, "koan_0003", "e002")
    local t_bn01 = Motion.Object:new(NPC, "blacktail_003", "bn01")
    local t_fe04 = Motion.Object:new(NPC, "blacktail_003", "fe04")
    local t_fe02 = Motion.Object:new(NPC, "blacktail_003", "fe02")
    local t_fq01 = Motion.Object:new(NPC, "blacktail_003", "fq01")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-7.77, -4.66, 28.67, -3.25, -2.33, 37.28, default, 0)
    Obj:new(PLAYER, ""):SetPos(-5.49, -3.85, 34.945)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.StartPlayerAndNpcTalkAction("koan_0003")
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e013:Play(10, true)
    tlk:Message("f_d1101_0150_0010")
    tlk:Message("f_d1101_0150_0020")
    Field.ObjectLookAtTheObject(NPC, asuna_index, NPC, tail_index, 15, 10)
    tlk:Message("f_d1101_0150_0030")
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    t_fe02:PlayWithStartMoveMotion(15, 15)
    WaitFrame(60)
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1101_0150_0040")
    tlk:Message("f_d1101_0150_0050")
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    t_fq01:PlayWithStartMoveMotion(15, 15)
    WaitFrame(45)
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectResetAim(NPC, asuna_index, 30)
    e002:Play(10, true)
    tlk:Message("f_d1101_0150_0060")
    tlk:Message("f_d1101_0150_0070")
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    Guest.Add(GST_ASUKA)
    Flg.Set("FLAG_MAIN_07_063")
    FieldObjectSync(FOR_ALL, false)
    Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), 0, 0, false)
    Field.ObjectCancelInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "panel_access01"), 0, 0, false, false)
    Obj:new(PLAYER, ""):SetRotationY(100, 0)
    SetFollowerCameraOperateRotation(-5, 100)
    Cam.Inst:Clear(0)
    Party.Aegiomon.SetExist(true)
    Guest.Add(GST_BLACKTAIL)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_020)
    Digitter.Send(1210020040)
  end
end

function M210:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M210:Event_095()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_07_060B") then
    Flg.Set("FLAG_MAIN_07_060B")
    local tlk = Tlk:new("d11", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1102_0090_0010")
    tlk:Message("f_d1102_0090_0020")
    tlk:EndTalk()
  end
end

function M210:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    local tlk = Tlk:new("d11", 1, true)
    local e012 = Motion.Object:new(NPC, "koan_0001", "e012")
    local e013 = Motion.Object:new(NPC, "koan_0001", "e013")
    local e008 = Motion.Object:new(NPC, "koan_0001", "e020")
    local e006 = Motion.Object:new(NPC, "koan_0001", "e006")
    local e005 = Motion.Object:new(NPC, "koan_0001", "e005")
    local e002 = Motion.Object:new(NPC, "koan_0001", "e002")
    local aigo_e004 = Motion.Object:new(NPC, "aigio_0001", "e004")
    local aigo_e005 = Motion.Object:new(NPC, "aigio_0001", "e005")
    local aigo_e012 = Motion.Object:new(NPC, "aigio_0001", "e012")
    local aigo_e002 = Motion.Object:new(NPC, "aigio_0001", "e002")
    local blacktail_bn01 = Motion.Object:new(NPC, "blacktail_0001", "bn01")
    local blacktail_fq01 = Motion.Object:new(NPC, "blacktail_0001", "fq01")
    local blacktail_fe04 = Motion.Object:new(NPC, "blacktail_0001", "fe04")
    local npc_index01 = GetIndex(NPC, "koan_0001")
    local asuna_index = GetIndex(NPC, "koan_0001")
    Field.ObjectLoadExpression(NPC, asuna_index, "F01")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Flg.Set("FLAG_MAIN_07_061")
    FieldObjectSync(FOR_ALL, false)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(54.95, 0, -41.71, 46.8, 1.95, -36.25, default, 1)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e006:Play(10, true)
    tlk:Message("f_d1102_0100_0005")
    e013:Play(10, true)
    tlk:Message("f_d1102_0100_0007")
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "aigio_0001"), 20)
    aigo_e005:Play(10, true)
    Motion.Player:PlayWithMoveMotion("e008", 5, 5)
    tlk:Message("f_d1102_0100_0010")
    tlk:Message("f_d1102_0100_0015")
    aigo_e012:Play(10, true)
    tlk:Message("f_d1102_0100_0020")
    tlk:Message("f_d1102_0100_0025")
    tlk:Message("f_d1102_0100_0030")
    e012:Play(10, true)
    tlk:Message("f_d1102_0100_0035")
    tlk:Message("f_d1102_0100_0036")
    tlk:Message("f_d1102_0100_0037")
    tlk:Message("f_d1102_0100_0040")
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    MessageClose()
    blacktail_fe04:Play2Wait(10, false)
    blacktail_bn01:Play(10, true)
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e013:Play(10, true)
    tlk:Message("f_d1102_0100_0050")
    aigo_e002:Play(10, true)
    tlk:Message("f_d1102_0100_0060")
    e008:Play(10, true)
    tlk:Message("f_d1102_0100_0070")
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "aigio_0001"), 10)
    e006:Play(10, true)
    tlk:Message("f_d1102_0100_0075")
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    MessageClose()
    blacktail_fq01:Play2Wait(10, false)
    blacktail_bn01:Play(10, true)
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotion(NPC, npc_index01, "e002", 10, false)
    tlk:Message("f_d1102_0100_0080")
    tlk:MessageClose()
    Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_07_061B")
    Cam.Inst:Clear(1)
    WaitFrame(15)
    e012:Play(10, true)
    Guest.Delete(GST_BLACKTAIL)
    Guest.Delete(GST_ASUKA)
    FieldObjectSync(FOR_ALL, false)
    Qst.Main:Set(self.ID, self.STEP_030)
    WaitFrame(15)
    tlk:EndTalk()
    SetFollowerCameraOperateRotation(10, 45)
    Obj:new(PLAYER, ""):SetRotationY(270, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Digitter.Send(1210020050)
  end
end

function M210:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    local npc_index = GetIndex(NPC, "npc_0005")
    Field.ObjectLoadExpression(NPC, npc_index, "F01")
    Flg.Set("FLAG_MAIN_07_065")
    local tlk = Tlk:new("d10", 1, true)
    local npc_0005 = Obj:new(NPC, "npc_0005")
    local e002 = Motion.Object:new(NPC, "npc_0005", "e002")
    local fn01_01 = Motion.Object:new(NPC, "npc_0005", "fn01_01")
    local e008 = Motion.Object:new(NPC, "npc_0005", "e008")
    tlk:StartTalkAndCancelDigimonRide()
    ObjectTurnToPlayer(NPC, npc_0005.name)
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e002:Play(10, true)
    tlk:Message("f_d1001_0120_0010")
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    INFO_GET_ITEM(734, 1)
    e008:PlayWithStartMoveMotion(10, 10)
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1001_0120_0020")
    tlk:EndTalk(true)
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Qst.Main:Set(self.ID, self.STEP_035)
    AnswerTheCall()
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1001_0120_0030")
    tlk:Message("f_d1001_0120_0040")
    tlk:EndTalk(true)
    EndTheCall()
    MapChange("d", 1102, "start_02", true, FADE_BLACK, FADE_TIME)
  end
end

function M210:Event_143()
end

function M210:Event_145()
end

function M210:Event_148()
end

function M210:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and not Flg.Check("FLAG_MAIN_07_066") then
    Flg.Set("FLAG_MAIN_07_066")
    Cam.Inst:Set(47.598, 0.75, -38.25, 54.74, 0.86, -45.24, default, 20)
    WaitFrame(20)
    local tlk = Tlk:new("d11", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1102_0110_0010")
    tlk:EndTalk()
    Cam.Inst:Clear(20)
    WaitFrame(20)
    Digitter.Send(1210020090)
  end
end

function M210:Event_160()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and not Flg.Check("FLAG_MAIN_07_067") then
    EncountFromField_PlaySound(10810100, 11172, false)
  end
end

function M210:Event_165()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_07_067", "FLAG_MAIN_07_070B") then
    Cam.Inst:Clear(0)
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(15)
    M210:Event_170()
  end
end

function M210:Event_170()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_07_067") then
    local tlk = Tlk:new("d11", 1, true)
    local e012 = Motion.Object:new(NPC, "koan_0003", "e012")
    local e013 = Motion.Object:new(NPC, "koan_0003", "e013")
    local e007 = Motion.Object:new(NPC, "koan_0003", "e007")
    local e002 = Motion.Object:new(NPC, "koan_0003", "e002")
    local e005 = Motion.Object:new(NPC, "koan_0003", "e005")
    local aigo_br01 = Motion.Object:new(NPC, "aigio_0002", "br01")
    local aigo_e004 = Motion.Object:new(NPC, "aigio_0002", "e004")
    local aigo_e002 = Motion.Object:new(NPC, "aigio_0002", "e002")
    local aigo_e012 = Motion.Object:new(NPC, "aigio_0002", "e012")
    local npc_index01 = GetIndex(NPC, "koan_0003")
    Field.ObjectLoadExpression(NPC, npc_index01, "F01")
    local npc_index02 = GetIndex(NPC, "aigio_0002")
    local npc_pos02 = Field.ObjectGetPosition(NPC, npc_index02)
    local npc_Rot02 = Field.ObjectGetRotationY(NPC, npc_index02)
    Field.ObjectLoadExpression(NPC, npc_index02, "F01")
    local npc_index03 = GetIndex(NPC, "blacktail_0003")
    local npc_pos03 = Field.ObjectGetPosition(NPC, npc_index03)
    local black_pos = Field.ObjectGetPosition(FLD_OBJ_NPC, npc_index03)
    local aigio_pos = Field.ObjectGetPosition(FLD_OBJ_NPC, npc_index02)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(aigio_pos.x, aigio_pos.z, black_pos.x, black_pos.z)
    Cam.Inst:Set(53.33, -0, -42.38, 45.79, 2.05, -36.14, default, 1)
    Field.ObjectSetRotationY(NPC, npc_index02, obj2_to_obj1_rot, 0)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 80, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 47.677, 0, -39.863)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e005:Play(10, true)
    tlk:Message("f_d1102_0120_0010")
    Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectLookAtTheObject(NPC, npc_index02, NPC, npc_index01, 30)
    aigo_e002:Play(10, true)
    tlk:Message("f_d1102_0120_0020")
    tlk:MessageClose()
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectResetAim(NPC, npc_index02, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index02, "e004", 10, 10)
    WaitFrame(30)
    local npc_Rot02 = Field.ObjectGetRotationY(NPC, npc_index02)
    Field.PlayEffectScript("ef_b_act_100", npc_pos02.x, npc_pos02.y + 1, npc_pos02.z + 0.5, npc_Rot02, 0.5)
    WaitFrame(50)
    PlaySE(300219, 100)
    Field.PlayEffectScript("ef_b_hea_100", npc_pos03.x, npc_pos03.y + 0.25, npc_pos03.z, 0, 0.5)
    PlaySE(101017, 100)
    WaitFrame(30)
    Field.ObjectLookAtTheObject(NPC, npc_index02, NPC, npc_index01, 30)
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    aigo_e002:Play(10, true)
    Motion.Player:PlayWithMoveMotion("e004", 5, 5)
    tlk:Message("f_d1102_0120_0030")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e012:Play(10, true)
    tlk:Message("f_d1102_0120_0040")
    tlk:MessageClose()
    Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    WaitFrame(15)
    e002:Play(10, true)
    Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "aigio_0002"), 20)
    tlk:Message("f_d1102_0120_0050")
    Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    Item.Delete(734, 1)
    BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    PlaySE(200014, 100)
    WaitFrame(60)
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), "", 0, false)
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), "", 0, false)
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), "", 0, false)
    aigo_e004:Play(10, true)
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "aigio_0002"), 20)
    Cam.Inst:Set(54.71, 1.38, -41.7, 45.54, 1.44, -37.71, default, 1)
    Field.ObjectSetPos(FLD_OBJ_NPC, npc_index01, 52.431, 0, -39.402)
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index01, 0, 0)
    Field.ObjectSetPos(FLD_OBJ_NPC, npc_index02, 49.908, 0, -40.086)
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index02, 120, 0)
    WaitFrame(1)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e013:Play(10, true)
    Motion.Player:PlayWithMoveMotion("e012", 5, 5)
    tlk:Message("f_d1102_0120_0060")
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "blacktail_0002"), 20)
    tlk:Message("f_d1102_0120_0070")
    e002:Play(10, true)
    tlk:Message("f_d1102_0120_0080")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    e012:Play(10, true)
    Flg.Set("FLAG_MAIN_07_070B")
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(1)
    SetFollowerCameraOperateRotation(-3, 275)
    Obj:new(PLAYER, ""):SetRotationY(235, 0)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    WaitFrame(20)
    AnswerTheCall()
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message("f_d1102_0120_0100")
    tlk:Message("f_d1102_0120_0110")
    tlk:Message("f_d1102_0120_0115")
    tlk:Message("f_d1102_0120_0120")
    Motion.Player:PlayWithMoveMotion("fn01_01", 10, 10)
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_040)
    Prcs_d1102_210_DoorOpen()
    Digitter.Send(1210020100)
  end
end

function M210:Event_172()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_45) then
  end
end

function M210:Event_174()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) then
    Digitter.Send(1210020120)
  end
end

function M210:Event_176()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) then
    Digitter.Send(1210020130)
  end
end

function M210:Event_178()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) then
    Digitter.Send(1210020140)
  end
end

function M210:Event_180()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) then
    Flg.Set("FLAG_MAIN_07_068")
    local e007 = Motion.Object:new(NPC, "npc_0600", "e007")
    local e012 = Motion.Object:new(NPC, "npc_0600", "e012")
    local e021 = Motion.Object:new(NPC, "npc_0600", "e021")
    local e023 = Motion.Object:new(NPC, "npc_0600", "e023")
    local npc_0600 = Obj:new(NPC, "npc_0600")
    local npc_index = GetIndex(NPC, "npc_0600")
    Field.ObjectLoadExpression(NPC, npc_index, "F01")
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    ObjectTurnToPlayer(NPC, npc_0600.name)
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    e007:Play(10, true)
    tlk:Message("f_t0302_0160_0010")
    tlk:Message("f_t0302_0160_0020")
    tlk:Message("f_t0302_0160_0030")
    e021:Play(10, true)
    tlk:Message("f_t0302_0160_0040")
    tlk:MessageClose()
    e023:Play(10, true)
    tlk:Message("f_t0302_0160_0050")
    e007:Play(10, true)
    tlk:Message("f_t0302_0160_0055")
    tlk:Message("f_t0302_0160_0060")
    tlk:Message("f_t0302_0160_0070")
    e012:Play(10, true)
    tlk:Message("f_t0302_0160_0080")
    tlk:Message("f_t0302_0160_0090")
    tlk:EndTalk()
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    WaitFrame(10)
    INFO_GET_ITEM(721, 1)
    WaitFrame(10)
    Qst.Main:Set(self.ID, self.STEP_045)
    Digimon.RestoreAllParty()
    Digitter.Send(1210020150)
  else
    local tlk = Tlk:new("t03")
    tlk:StartTalkAndCancelDigimonRide()
    local npc_0600 = Obj:new(NPC, "npc_0600")
    local npc_index = GetIndex(NPC, "npc_0600")
    Field.ObjectLoadExpression(NPC, npc_index, "F01")
    ObjectTurnToPlayer(NPC, npc_0600.name)
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_t0302_0160_0100")
    Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk()
  end
end

function M210:Event_300()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and not Flg.Check("FLAG_MAIN_07_069") then
    EncountFromField(10810200, 381, false)
  end
end

function M210:Event_310()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_07_069") then
    Sound.StopBGM(0)
    MapChange("e", 7, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M210:Event_311()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_07_069") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m220_001")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 381, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M210:Event_320()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_255) and Flg.Check("FLAG_MAIN_07_069") then
    Sound.StopBGM(0)
    Execute("m210_080")
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(45)
    end
    Item.Delete(721, 1)
    Qst.Main:End(self.ID, self.STEP_255)
    Common.DegenerationAegiomon()
    MapChangeWithTimeTravel("t", 3001, "start_00", AXIS_ORIGINAL, "A2028_daft_220", NOON)
  end
end

function M210:ChapterFlagSet(progress)
  local step = {}
  if 10 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 12 <= progress then
    step[#step + 1] = self.STEP_003
    step[#step + 1] = self.STEP_005
  end
  if 13 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_025
  end
  if 15 <= progress then
    step[#step + 1] = self.STEP_030
  end
  if 16 <= progress then
    step[#step + 1] = self.STEP_035
  end
  if 17 <= progress then
    step[#step + 1] = self.STEP_040
  end
  if 18 <= progress then
    step[#step + 1] = self.STEP_045
  end
  Qst.Main:Chapter(step, self.ID)
end
