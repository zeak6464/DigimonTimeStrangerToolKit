S030_027 = {
  ID = 27,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_007 = 7,
  STEP_010 = 10,
  STEP_020 = 20,
  STEP_021 = 21,
  STEP_022 = 22,
  STEP_255 = 255,
  Flag001 = "FLAG_SUB_030_027_001"
}
local base = "s030_027_"
local text_file = "s030_027"

function S030_027:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_003, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "080")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "040")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "050")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "060")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "070")
    else
      tlk:Message(base .. "090")
      Qst.Sub:Set(self.ID, self.STEP_005, true)
      Flg.Set("FLAG_SUB_030_027_001")
    end
    tlk:EndTalk()
  elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    tlk:Message(base .. "030")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "040")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "050")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "060")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "070")
      Qst.Sub:Set(self.ID, self.STEP_003, true)
    else
      tlk:Message(base .. "090")
      Qst.Sub:Set(self.ID, self.STEP_003, true)
      Qst.Sub:Set(self.ID, self.STEP_005, true)
      Flg.Set("FLAG_SUB_030_027_001")
    end
    tlk:EndTalk()
  end
end

function S030_027:Event_020()
  local bn01 = Motion.Object:new(NPC, "sub027_001", "bn01")
  local fq01 = Motion.Object:new(NPC, "sub027_001", "fq01")
  local fq02 = Motion.Object:new(NPC, "sub027_001", "fq02")
  local fe02 = Motion.Object:new(NPC, "sub027_001", "fe02")
  if Qst.Sub:Check(self.ID, self.STEP_007, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    fq01:Play(10, true)
    tlk:Message(base .. "210")
    tlk:MessageClose()
    bn01:Play(10, true)
    local result = tlk:Select(3, base .. "170")
    if result == RESULT_TALK00 then
      fe02:Play(10, true)
      tlk:Message(base .. "180")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_010, true)
      Flg.Set("FLAG_SUB_030_027_002")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(FOR_ALL, false)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -107.079, 72.534, -40.775)
      WaitFrame(1)
      Field.SetPlayerRotation(200, 0)
      SetFollowerCameraOperateRotation(5, 200, 0)
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      bn01:Play(10, true)
    end
    if result == RESULT_TALK01 then
      fq02:Play(10, true)
      tlk:Message(base .. "190")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_010, true)
      Flg.Set("FLAG_SUB_030_027_002")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(FOR_ALL, false)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 16.491, 72.156, -91.093)
      WaitFrame(1)
      Field.SetPlayerRotation(200, 0)
      SetFollowerCameraOperateRotation(5, 200, 0)
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      bn01:Play(10, true)
    end
    if result == RESULT_TALK02 then
      fq02:Play(10, true)
      tlk:Message(base .. "200")
      tlk:EndTalk()
    else
      bn01:Play(10, true)
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    fq01:Play(10, true)
    tlk:Message(base .. "100")
    tlk:MessageClose()
    bn01:Play(10, true)
    local result = tlk:Select(3, base .. "110")
    if result == RESULT_TALK00 then
      fq01:Play(10, true)
      tlk:Message(base .. "120")
    end
    if result == RESULT_TALK01 then
      fq01:Play(10, true)
      tlk:Message(base .. "130")
    end
    if result == RESULT_TALK02 then
      fq01:Play(10, true)
      tlk:Message(base .. "140")
    end
    fq02:Play(10, true)
    tlk:Message(base .. "150")
    bn01:Play(10, true)
    tlk:Message(base .. "160")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "170")
    if result == RESULT_TALK00 then
      fe02:Play(10, true)
      tlk:Message(base .. "180")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_007, true)
      Qst.Sub:Set(self.ID, self.STEP_010, true)
      Flg.Set("FLAG_SUB_030_027_002")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(FOR_ALL, false)
      WaitFrame(1)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -107.079, 72.534, -40.775)
      WaitFrame(1)
      Field.SetPlayerRotation(200, 0)
      SetFollowerCameraOperateRotation(5, 200, 0)
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      bn01:Play(10, true)
    end
    if result == RESULT_TALK01 then
      fq02:Play(10, true)
      tlk:Message(base .. "190")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_007, true)
      Qst.Sub:Set(self.ID, self.STEP_010, true)
      Flg.Set("FLAG_SUB_030_027_002")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(FOR_ALL, false)
      WaitFrame(1)
      Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 16.491, 72.156, -91.093)
      WaitFrame(1)
      Field.SetPlayerRotation(200, 0)
      SetFollowerCameraOperateRotation(5, 200, 0)
      WaitFrame(15)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      bn01:Play(10, true)
    end
    if result == RESULT_TALK02 then
      fq02:Play(10, true)
      tlk:Message(base .. "200")
      Qst.Sub:Set(self.ID, self.STEP_007, true)
      tlk:EndTalk()
      bn01:Play(10, true)
    else
    end
  end
end

function S030_027:Event_030(unique_name)
  local fq01 = Motion.Object:new(NPC, unique_name, "fq01")
  local fq02 = Motion.Object:new(NPC, unique_name, "fq02")
  local fe02 = Motion.Object:new(NPC, unique_name, "fe02")
  local fe04 = Motion.Object:new(NPC, unique_name, "fe04")
  local ba02 = Motion.Object:new(NPC, unique_name, "ba02")
  local bn01 = Motion.Object:new(NPC, unique_name, "bn01")
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_020) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    ba02:Play(10, true)
    tlk:Message(base .. "220")
    fq01:Play(10, true)
    tlk:Message(base .. "230")
    tlk:MessageClose()
    bn01:Play(10, true)
    local result = tlk:Select(3, base .. "240")
    if result == RESULT_TALK00 then
      fq01:Play(10, true)
      tlk:Message(base .. "250")
    end
    if result == RESULT_TALK01 then
      fq02:Play(10, true)
      tlk:Message(base .. "260")
    end
    if result == RESULT_TALK02 then
      fq01:Play(10, true)
      tlk:Message(base .. "280")
    end
    bn01:Play(10, true)
    tlk:Message(base .. "290")
    ba02:Play(10, true)
    tlk:Message(base .. "300")
    bn01:Play(10, true)
    tlk:Message(base .. "310")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "320")
    if result == RESULT_TALK00 then
      fe04:Play(10, true)
      tlk:Message(base .. "330")
    end
    if result == RESULT_TALK01 then
      fe02:Play(10, true)
      tlk:Message(base .. "340")
    end
    if result == RESULT_TALK02 then
      fe04:Play(10, true)
      tlk:Message(base .. "350")
    end
    fq02:Play(10, true)
    tlk:Message(base .. "360")
    fq01:Play(10, true)
    tlk:EndTalk()
  end
end

function S030_027:Event_035()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_020) then
    local fq01 = Motion.Object:new(NPC, "sub027_004", "fq01")
    local fq02 = Motion.Object:new(NPC, "sub027_004", "fq02")
    local fe02 = Motion.Object:new(NPC, "sub027_004", "fe02")
    local fe04 = Motion.Object:new(NPC, "sub027_004", "fe04")
    local ba02 = Motion.Object:new(NPC, "sub027_004", "ba02")
    local bn01 = Motion.Object:new(NPC, "sub027_004", "bn01")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    ba02:Play(10, true)
    tlk:Message(base .. "220")
    fq01:Play(10, true)
    tlk:Message(base .. "230")
    tlk:MessageClose()
    bn01:Play(10, true)
    local result = tlk:Select(3, base .. "240")
    if result == RESULT_TALK00 then
      fq01:Play(10, true)
      tlk:Message(base .. "250")
    end
    if result == RESULT_TALK01 then
      fq02:Play(10, true)
      tlk:Message(base .. "260")
    end
    if result == RESULT_TALK02 then
      fq01:Play(10, true)
      tlk:Message(base .. "280")
    end
    bn01:Play(10, true)
    tlk:Message(base .. "290")
    ba02:Play(10, true)
    tlk:Message(base .. "300")
    bn01:Play(10, true)
    tlk:Message(base .. "310")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "320")
    if result == RESULT_TALK00 then
      fe04:Play(10, true)
      tlk:Message(base .. "330")
      tlk:Message(base .. "360")
      fq01:Play(10, true)
    end
    if result == RESULT_TALK01 then
      fe02:Play(10, true)
      tlk:Message(base .. "340")
      fq01:Play(10, true)
      tlk:Message(base .. "370")
      tlk:MessageClose()
      local result1 = tlk:Select(3, base .. "380")
      if result1 == RESULT_TALK00 then
        fe04:Play(10, true)
        tlk:Message(base .. "390")
      end
      if result1 == RESULT_TALK01 then
        fe02:Play(10, true)
        tlk:Message(base .. "400")
      end
      if result1 == RESULT_TALK02 then
        fe04:Play(10, true)
        tlk:Message(base .. "410")
      end
      fq01:Play(10, true)
      tlk:Message(base .. "420")
      tlk:EndTalk(true)
      Qst.Sub:Set(self.ID, self.STEP_020, true)
      Flg.Set(self.Flag001)
      MapChange("d", 404, "start_00", true, FADE_BLACK, FADE_TIME)
    end
    if result == RESULT_TALK02 then
      fe04:Play(10, true)
      tlk:Message(base .. "350")
      tlk:Message(base .. "360")
      fq01:Play(10, true)
    end
    tlk:EndTalk()
  end
end

function S030_027:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    local b_e004 = Motion.Object:new(NPC, "bacchus_01", "e004")
    local b_fq01 = Motion.Object:new(NPC, "bacchus_01", "fq01")
    local b_e100 = Motion.Object:new(NPC, "bacchus_01", "e100")
    local s_fe02 = Motion.Object:new(NPC, "s030_027_001", "fe02")
    local s_bn01 = Motion.Object:new(NPC, "s030_027_001", "bn01")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Obj:new(PLAYER, ""):SetPos(1.593, -0.178, -4.949)
    SetFollowerCameraOperateRotation(0, 0)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "430")
    b_e004:Play(10, true)
    tlk:Message(base .. "440")
    b_fq01:Play(10, true)
    s_fe02:Play(10, true)
    tlk:Message(base .. "450")
    tlk:EndTalk()
    s_bn01:Play(10, true)
    b_e100:Play(10, true)
    Qst.Sub:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_IS_CLEAR_S030_027")
    BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end
