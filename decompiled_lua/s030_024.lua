S030_024 = {
  ID = 24,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flag001 = "FLAG_SUB_030_024_001",
  Flag002 = "FLAG_SUB_030_024_002",
  Flag011 = "FLAG_SUB_030_024_011",
  Flag012 = "FLAG_SUB_030_024_012",
  Flag013 = "FLAG_SUB_030_024_013",
  Flag014 = "FLAG_SUB_030_024_014",
  Flag015 = "FLAG_SUB_030_024_015",
  Flag016 = "FLAG_SUB_030_024_016",
  Flag017 = "FLAG_SUB_030_024_017",
  Flag018 = "FLAG_SUB_030_024_018",
  Flag019 = "FLAG_SUB_030_024_019"
}
local base = "s030_024_"
local text_file = "s030_024"

function S030_024:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check(self.Flag001) then
    Flg.Set(self.Flag001)
    local muucho = Obj:new(NPC, "sub024_001")
    local m_index = GetIndex(NPC, "sub024_001")
    local ba01 = Motion.Object:new(NPC, "sub024_001", "ba01")
    local bn01 = Motion.Object:new(NPC, "sub024_001", "bn01")
    local bn02 = Motion.Object:new(NPC, "sub024_001", "bn02")
    local fe01 = Motion.Object:new(NPC, "sub024_001", "fe01")
    local fe02 = Motion.Object:new(NPC, "sub024_001", "fe02")
    local fe04 = Motion.Object:new(NPC, "sub024_001", "fe04")
    local fq01 = Motion.Object:new(NPC, "sub024_001", "fq01")
    local fq02 = Motion.Object:new(NPC, "sub024_001", "fq02")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local p_e004 = Motion.Object:new(PLAYER, "", "e004")
    local p_e008 = Motion.Object:new(PLAYER, "", "e008")
    local p_e012 = Motion.Object:new(PLAYER, "", "e012")
    local p_e015 = Motion.Object:new(PLAYER, "", "e015")
    HideMinimap(true)
    HideGuide(true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(PLAYER, ""):SetPos(19.154, 9.485, 38.87)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "sub024_001", 0)
    Cam.Inst:Set(24.268, 7.283, 33.293, 18.37, 11.415, 40.231, default, 0)
    WaitFrame(30)
    Field.ObjectLookAtTheObject(NPC, m_index, PLAYER, 1, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, m_index, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    muucho:ChangeExpression("F01_T01", EYE_BLINK, false, 10)
    tlk:Message(base .. "020")
    bn02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "030")
    muucho:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
    fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "040")
    muucho:ChangeExpression("F03_T01", EYE_BLINK, false, 10)
    local result = tlk:Select(3, base .. "050")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "060")
      muucho:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      bn02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "070")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "080")
      muucho:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      bn02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "090")
    else
      WaitFrame(15)
      fe01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "100")
      muucho:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      bn02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "110")
    end
    muucho:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "120")
    tlk:Message(base .. "130")
    muucho:ChangeExpression("F01_T01", EYE_BLINK, false, 10)
    result = tlk:Select(3, base .. "140")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      muucho:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "150")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      muucho:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "160")
    else
      WaitFrame(15)
      muucho:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "170")
    end
    muucho:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "180")
    tlk:Message(base .. "182")
    tlk:Message(base .. "184")
    muucho:ChangeExpression("F01_T01", EYE_BLINK, false, 10)
    result = tlk:Select(2, base .. "190")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      muucho:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
      fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "200")
    else
      WaitFrame(15)
      muucho:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      bn02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "210")
      tlk:MessageClose()
      tlk:EndTalk()
      goto lbl_574
    end
    Flg.Set(self.Flag002)
    muucho:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "220")
    ba01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "230")
    muucho:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "240")
    tlk:MessageClose()
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_005)
    Qst.Sub:Start(self.ID, 1, false)
    ::lbl_574::
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    muucho:ChangeExpression("F01_T01", EYE_BLINK, false, 10)
    WaitFrame(30)
    Cam.Inst:Clear(0)
    HideMinimap(false)
    HideGuide(false)
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    FieldObjectSync(ENEMY, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S030_024:Event_015()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check(self.Flag001) then
    local muucho = Obj:new(NPC, "sub024_001")
    local m_index = GetIndex(NPC, "sub024_001")
    local ba01 = Motion.Object:new(NPC, "sub024_001", "ba01")
    local bn01 = Motion.Object:new(NPC, "sub024_001", "bn01")
    local bn02 = Motion.Object:new(NPC, "sub024_001", "bn02")
    local fe02 = Motion.Object:new(NPC, "sub024_001", "fe02")
    local fq01 = Motion.Object:new(NPC, "sub024_001", "fq01")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local p_e015 = Motion.Object:new(PLAYER, "", "e015")
    HideMinimap(true)
    HideGuide(true)
    local tlk = Tlk:new(text_file, 1, true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(PLAYER, ""):SetPos(19.154, 9.485, 38.87)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "sub024_001", 0)
    Cam.Inst:Set(24.268, 7.283, 33.293, 18.37, 11.415, 40.231, default, 0)
    WaitFrame(30)
    Field.ObjectLookAtTheObject(NPC, m_index, PLAYER, 1, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, m_index, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    muucho:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "180")
    tlk:Message(base .. "182")
    tlk:Message(base .. "184")
    muucho:ChangeExpression("F01_T01", EYE_BLINK, false, 10)
    local result = tlk:Select(2, base .. "190")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      muucho:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
      fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "200")
    else
      WaitFrame(15)
      muucho:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      bn02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "210")
      tlk:MessageClose()
      tlk:EndTalk()
      goto lbl_296
    end
    Flg.Set(self.Flag002)
    muucho:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "220")
    ba01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "230")
    muucho:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "240")
    tlk:MessageClose()
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_005)
    Qst.Sub:Start(self.ID, 1, false)
    ::lbl_296::
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    muucho:ChangeExpression("F01_T01", EYE_BLINK, false, 10)
    WaitFrame(30)
    Cam.Inst:Clear(0)
    HideMinimap(false)
    HideGuide(false)
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    FieldObjectSync(ENEMY, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S030_024:Event_018()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flag002) then
    local ba01 = Motion.Object:new(NPC, "sub024_001", "ba01")
    local bn01 = Motion.Object:new(NPC, "sub024_001", "bn01")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("sub024_001")
    ba01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "250")
    tlk:EndTalkActionAndZoom()
  end
end

function S030_024:Event_020()
  Flg.Set(self.Flag011)
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_021()
  Flg.Set(self.Flag012)
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_022()
  Flg.Set(self.Flag013)
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_023()
  Flg.Set(self.Flag014)
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_024()
  Flg.Set(self.Flag015)
  local tlk = Tlk:new(text_file, 1, true)
  local s1_ba01 = Motion.Object:new(ENEMY, "sub24_bee_04", "ba01")
  local s1_bn01 = Motion.Object:new(ENEMY, "sub24_bee_04", "bn01")
  local s2_ba01 = Motion.Object:new(ENEMY, "sub24_bee_05", "ba01")
  local s2_bn01 = Motion.Object:new(ENEMY, "sub24_bee_05", "bn01")
  local s3_ba01 = Motion.Object:new(ENEMY, "sub24_bee_06", "ba01")
  local s3_bn01 = Motion.Object:new(ENEMY, "sub24_bee_06", "bn01")
  tlk:StartTalkAndCancelDigimonRide()
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Cam.Inst:Set(15.901, -2.937, -25.781, 19.816, 1.693, -17.829, default, 0)
  FieldObjectSync(ENEMY, true)
  WaitFrame(30)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  s1_ba01:PlayWithStartMoveMotion(10, 10)
  s2_ba01:PlayWithStartMoveMotion(10, 10)
  s3_ba01:PlayWithStartMoveMotion(10, 10)
  while s3_ba01:IsPlayingMotion() do
    WaitFrame(1)
  end
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Cam.Inst:Clear(0)
  WaitFrame(30)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  tlk:EndTalk()
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_025()
  Flg.Set(self.Flag016)
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_026()
  Flg.Set(self.Flag017)
  local tlk = Tlk:new(text_file, 1, true)
  local s1_ba01 = Motion.Object:new(ENEMY, "sub24_bee_01", "ba01")
  local s1_bn01 = Motion.Object:new(ENEMY, "sub24_bee_01", "bn01")
  local s2_ba01 = Motion.Object:new(ENEMY, "sub24_bee_02", "ba01")
  local s2_bn01 = Motion.Object:new(ENEMY, "sub24_bee_02", "bn01")
  local s3_ba01 = Motion.Object:new(ENEMY, "sub24_bee_03", "ba01")
  local s3_bn01 = Motion.Object:new(ENEMY, "sub24_bee_03", "bn01")
  tlk:StartTalkAndCancelDigimonRide()
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Cam.Inst:Set(15.901, -2.937, -25.781, 19.816, 1.693, -17.829, default, 0)
  FieldObjectSync(ENEMY, true)
  WaitFrame(30)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  s1_ba01:PlayWithStartMoveMotion(10, 10)
  s2_ba01:PlayWithStartMoveMotion(10, 10)
  s3_ba01:PlayWithStartMoveMotion(10, 10)
  while s3_ba01:IsPlayingMotion() do
    WaitFrame(1)
  end
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Cam.Inst:Clear(0)
  WaitFrame(30)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  tlk:EndTalk()
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_027()
  Flg.Set(self.Flag018)
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_028()
  Flg.Set(self.Flag019)
  if self:Event_100() then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S030_024:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local muucho = Obj:new(NPC, "sub024_001")
    local m_index = GetIndex(NPC, "sub024_001")
    local fe04 = Motion.Object:new(NPC, "sub024_001", "fe04")
    local fq01 = Motion.Object:new(NPC, "sub024_001", "fq01")
    local bn01 = Motion.Object:new(NPC, "sub024_001", "bn01")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(PLAYER, ""):SetPos(19.154, 9.485, 38.87)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "sub024_001", 0)
    Cam.Inst:Set(24.268, 7.283, 33.293, 18.37, 11.415, 40.231, default, 0)
    WaitFrame(30)
    Field.ObjectLookAtTheObject(NPC, m_index, PLAYER, 1, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, m_index, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    muucho:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
    fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "260")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "290")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    muucho:ChangeExpression("F01_T01", EYE_BLINK, false, 10)
    WaitFrame(30)
    Cam.Inst:Clear(0)
    tlk:EndTalk()
    FieldObjectSync(NPC, true)
    FieldObjectSync(ENEMY, true)
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S030_024:Event_040()
  if Flg.Check("FLAG_IS_CLEAR_S030_024") then
    local tlk = Tlk:new(text_file, 1, true)
    local muucho = Obj:new(NPC, "sub024_001")
    local m_index = GetIndex(NPC, "sub024_001")
    local bn01 = Motion.Object:new(NPC, "sub024_001", "bn01")
    local fe04 = Motion.Object:new(NPC, "sub024_001", "fe04")
    local fq02 = Motion.Object:new(NPC, "sub024_001", "fq02")
    Field.ObjectLookAtTheObject(NPC, m_index, PLAYER, 1, 30)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, m_index, 30)
    tlk:StartTalkAndCancelDigimonRide()
    muucho:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
    fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "300")
    muucho:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
    fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "310")
    tlk:EndTalk()
    Field.ObjectResetMotion(NPC, GetIndex(NPC, "sub024_001"), 30)
  end
end

function S030_024:Event_100()
  local flgs = {
    self.Flag011,
    self.Flag012,
    self.Flag013,
    self.Flag014,
    self.Flag015,
    self.Flag016,
    self.Flag017,
    self.Flag018,
    self.Flag019
  }
  return Flg.AllCheck(flgs)
end
