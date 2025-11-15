S050_042 = {
  ID = 42,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_009 = 9,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}
local base = "s050_042_"
local text_file = "s050_042"

function S050_042:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    local solar_index = GetIndex(NPC, "sub_050_042_solar")
    Field.ObjectLoadMotion(NPC, solar_index, "bn01")
    Field.ObjectLoadMotion(NPC, solar_index, "bn02")
    Field.ObjectLoadMotion(NPC, solar_index, "br01")
    Field.ObjectLoadMotion(NPC, solar_index, "fq01")
    Field.ObjectLoadMotion(NPC, solar_index, "fq02")
    Field.ObjectLoadMotion(NPC, solar_index, "fe02")
    Field.ObjectLoadMotion(NPC, solar_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    HideMinimap(true)
    HideGuide(true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    local solar_rot = Field.ObjectGetRotationY(NPC, solar_index)
    Cam.Inst:Set(16.2854, -0.0122, 2.4985, 26.151, 1.55, 2.01, default, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, solar_index, 0, 0)
    WaitFrame(1)
    Obj:new(PLAYER, ""):SetPos(24.47, -0.012178, 2.547, true)
    WaitFrame(1)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "sub_050_042_solar", 0)
    Obj:new(NPC, "npc_warp01"):Invisible(15)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq02", 10, 10)
    tlk:Message(base .. "0010")
    local result = tlk:Select(3, base .. "0020")
    if result == RESULT_TALK00 then
      Obj:new(NPC, "sub_050_042_solar"):SetRotationYToObject(PLAYER, "", 15)
      Field.ObjectPlayMotion(NPC, solar_index, "br01", 10, true)
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0030")
    end
    if result == RESULT_TALK01 then
      Obj:new(NPC, "sub_050_042_solar"):SetRotationYToObject(PLAYER, "", 15)
      Field.ObjectPlayMotion(NPC, solar_index, "br01", 10, true)
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0040")
    end
    if result == RESULT_TALK02 then
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq02", 10, 10)
      tlk:Message(base .. "0045")
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
      Cam.Inst:Clear(30)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
      tlk:Message(base .. "0050")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq02", 10, 10)
      tlk:Message(base .. "0060")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0070")
      tlk:EndTalk(true)
      Qst.Sub:Start(self.ID, 1, false)
      Flg.Set("FLAG_SUB_S050_042_001")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, false)
      Cam.Inst:Clear(0)
      WaitFrame(25)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_005)
      Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    end
  end
  Obj:new(NPC, "npc_warp01"):CancelInvisible(15)
end

function S050_042:Event_020()
  local solar_index = GetIndex(NPC, "sub_050_042_01")
  Field.ObjectLoadMotion(NPC, solar_index, "bn01")
  Field.ObjectLoadMotion(NPC, solar_index, "bn02")
  Field.ObjectLoadMotion(NPC, solar_index, "fq01")
  Field.ObjectLoadMotion(NPC, solar_index, "fq02")
  Field.ObjectLoadMotion(NPC, solar_index, "fe02")
  Field.ObjectLoadMotion(NPC, solar_index, "fe04")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  local tlk = Tlk:new(text_file, 1, true)
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-4.545, -6.3328, -34.766, -1.8341, -3.8447, -25.468, default, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, solar_index, 0, 0)
    Field.ObjectLookAtTheObject(NPC, solar_index, PLAYER, 1, 0, 0)
    Obj:new(PLAYER, ""):SetPos(-2.1675, -5.2, -28.0855, true)
    Obj:new(PLAYER, ""):SetRotationY(330, 0)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe02", 10, 10)
    tlk:Message(base .. "0190")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
    tlk:Message(base .. "0210")
    HideMinimap(false)
    HideGuide(false)
    tlk:EndTalk()
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_009) then
    local tlk = Tlk:new(text_file, 1, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe02", 10, 10)
    tlk:Message(base .. "0080")
    local result = tlk:Select(3, base .. "0090")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0100")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0110")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0120")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
    tlk:Message(base .. "0130")
    tlk:Message(base .. "0140")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq02", 10, 10)
    tlk:Message(base .. "0150")
    result = tlk:Select(3, base .. "0160")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
      tlk:Message(base .. "0170")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
      tlk:Message(base .. "0180")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0185")
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_009)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe02", 10, 10)
      tlk:Message(base .. "0190")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0200")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
      tlk:Message(base .. "0210")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_009)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_009, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
    tlk:Message(base .. "0370")
    result = tlk:Select(2, base .. "0380")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
      tlk:Message(base .. "0390")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq02", 10, 10)
      tlk:Message(base .. "0400")
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe02", 10, 10)
      tlk:Message(base .. "0190")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
      tlk:Message(base .. "0200")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
      tlk:Message(base .. "0210")
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
    end
  end
  SetFollowerCameraOperateRotation(0, 0, 0)
  Field.ObjectResetAim(FLD_OBJ_PLAYER, 1, 10)
  Field.ObjectResetAim(NPC, solar_index, 10)
  HideMinimap(false)
  HideGuide(false)
  Cam.Inst:Clear(30)
end

function S050_042:Event_030(gim_unique)
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    if gim_unique == "sub_050_042_01" then
      tlk:Message(base .. "0220")
    end
    if gim_unique == "sub_050_042_02" then
      tlk:Message(base .. "0230")
    end
    if gim_unique == "sub_050_042_04" then
      tlk:Message(base .. "0240")
    end
    if gim_unique == "sub_050_042_05" then
      tlk:Message(base .. "0250")
    end
    tlk:EndTalk()
  end
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0260")
    tlk:EndTalk()
  end
end

function S050_042:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    INFO_GET_ITEM(765, 1)
    Flg.Set("FLAG_SUB_S050_042_002")
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    Qst.Sub:Set(self.ID, self.STEP_015)
  end
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0260")
    tlk:EndTalk()
  end
end

function S050_042:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local solar_index = GetIndex(NPC, "sub_050_042_01")
    Field.ObjectLoadMotion(NPC, solar_index, "bn01")
    Field.ObjectLoadMotion(NPC, solar_index, "bn02")
    Field.ObjectLoadMotion(NPC, solar_index, "fq01")
    Field.ObjectLoadMotion(NPC, solar_index, "fq02")
    Field.ObjectLoadMotion(NPC, solar_index, "fe02")
    Field.ObjectLoadMotion(NPC, solar_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    Cam.Inst:Set(-4.545, -6.3328, -34.766, -1.8341, -3.8447, -25.468, default, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, solar_index, 0, 0)
    Field.ObjectLookAtTheObject(NPC, solar_index, PLAYER, 1, 0, 0)
    Obj:new(PLAYER, ""):SetPos(-2.1675, -5.2, -28.0855, true)
    Obj:new(PLAYER, ""):SetRotationY(330, 0)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
    tlk:Message(base .. "0270")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe02", 10, 10)
    tlk:Message(base .. "0275")
    INFO_RELEASE_ITEM(765, 1)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq01", 10, 10)
    tlk:Message(base .. "0280")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe02", 10, 10)
    tlk:Message(base .. "0290")
    tlk:EndTalk(true)
    Flg.Set("FLAG_IS_CLEAR_S050_042")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, false)
    Field.ObjectResetAim(FLD_OBJ_PLAYER, 1, 10)
    Field.ObjectResetAim(NPC, solar_index, 10)
    WaitFrame(25)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(30)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
  end
end

function S050_042:Event_060()
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message("s050_042_0300")
  tlk:Message("s050_042_0310")
  tlk:Message("s050_042_0320")
  tlk:Message("s050_042_0330")
  tlk:Message("s050_042_0340")
  tlk:EndTalk()
end

function S050_042:Event_070()
  local solar_index = GetIndex(NPC, "npc_0036")
  Field.ObjectLoadMotion(NPC, solar_index, "bn01")
  Field.ObjectLoadMotion(NPC, solar_index, "br01")
  Field.ObjectLoadMotion(NPC, solar_index, "fe02")
  Field.ObjectLoadMotion(NPC, solar_index, "fe04")
  local rotate = Field.ObjectGetRotationY(NPC, solar_index)
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message("s050_042_0350")
  Obj:new(NPC, "npc_0036"):SetRotationYToObject(PLAYER, "", 15)
  Field.ObjectPlayMotion(NPC, solar_index, "br01", 10, true)
  WaitFrame(15)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe04", 10, 10)
  tlk:Message("s050_042_0360")
  tlk:EndTalk()
  Obj:new(NPC, "npc_0036"):SetRotationY(rotate, 15)
  Field.ObjectPlayMotion(NPC, solar_index, "br01", 10, true)
  WaitFrame(15)
end
