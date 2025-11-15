S050_039 = {
  ID = 39,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_050_039_001",
  Flg02 = "FLAG_SUB_050_039_002",
  Flg03 = "FLAG_SUB_050_039_003"
}
local base = "s050_039_"
local text_file = "s050_039"

function S050_039:Event_001()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check(self.Flg01) then
    local zudo_index = GetIndex(NPC, "shop_0004")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn01")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq01")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe04")
    local zudo_01 = Motion.Object:new(NPC, "shop_0004", "f000")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Flg.Set(self.Flg01)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 0)
    Obj:new(PLAYER, ""):SetPos(5.98, 2, 32.17, true)
    WaitFrame(1)
    Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zudo_index, 0)
    Obj:new(PLAYER, ""):SetRotationY(30, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
    tlk:Message(base .. "020")
    tlk:Message(base .. "030")
    Field.ObjectResetAim(NPC, zudo_index, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fq02", 10, 10)
    tlk:Message(base .. "040")
    local result = tlk:Select(3, base .. "050")
    WaitFrame(15)
    Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 30)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "060")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "070")
    else
      tlk:Message(base .. "080")
    end
    tlk:Message(base .. "090")
    tlk:Message(base .. "100")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
    tlk:Message(base .. "110")
    result = tlk:Select(3, base .. "120")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe04", 10, 10)
      tlk:Message(base .. "130")
    elseif result == RESULT_TALK01 then
      Field.ObjectResetAim(NPC, zudo_index, 10)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fq02", 10, 10)
      tlk:Message(base .. "140")
      Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 30)
    else
      tlk:Message(base .. "150")
      HideMinimap(false)
      HideGuide(false)
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      goto lbl_439
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
    tlk:Message(base .. "200")
    tlk:Message(base .. "210")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe04", 10, 10)
    tlk:Message(base .. "220")
    tlk:EndTalk(true)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Flg.Set(self.Flg02)
    Qst.Sub:Set(self.ID, self.STEP_005)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    Cam.Inst:Clear(30)
    ::lbl_439::
    zudo_01:Play(15, true)
  end
end

function S050_039:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check(self.Flg01) then
    local zudo_index = GetIndex(NPC, "shop_0004")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn01")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq01")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe04")
    local zudo_01 = Motion.Object:new(NPC, "shop_0004", "f000")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 0)
    Obj:new(PLAYER, ""):SetPos(5.98, 2, 32.17, true)
    WaitFrame(1)
    Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zudo_index, 0)
    Obj:new(PLAYER, ""):SetRotationY(30, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "160")
    local result = tlk:Select(2, base .. "170")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe04", 10, 10)
      tlk:Message(base .. "180")
    else
      tlk:Message(base .. "190")
      HideMinimap(false)
      HideGuide(false)
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      goto lbl_308
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
    tlk:Message(base .. "200")
    tlk:Message(base .. "210")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe04", 10, 10)
    tlk:Message(base .. "220")
    tlk:EndTalk(true)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Flg.Set(self.Flg02)
    Qst.Sub:Set(self.ID, self.STEP_005)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
  end
  ::lbl_308::
end

function S050_039:Event_015()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    INFO_GET_ITEM(774, 1)
    Qst.Sub:Set(self.ID, self.STEP_010)
    Flg.Set(self.Flg03)
  end
end

function S050_039:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) and Flg.Check(self.Flg03) then
    local zudo_index = GetIndex(NPC, "shop_0004")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn01")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq01")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe04")
    local zudo_01 = Motion.Object:new(NPC, "shop_0004", "f000")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 0)
    Obj:new(PLAYER, ""):SetPos(5.98, 2, 32.17, true)
    WaitFrame(1)
    Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zudo_index, 0)
    Obj:new(PLAYER, ""):SetRotationY(30, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
    tlk:Message(base .. "230")
    INFO_RELEASE_ITEM(774, 1)
    tlk:Message(base .. "240")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe04", 10, 10)
    tlk:Message(base .. "250")
    tlk:Message(base .. "260")
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Cam.Inst:Clear(30)
    zudo_01:Play(15, true)
  end
end
