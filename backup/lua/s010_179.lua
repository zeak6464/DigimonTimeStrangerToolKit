S010_179 = {
  ID = 179,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_007 = 7,
  STEP_010 = 10,
  STEP_255 = 255
}
local text_file = "s010_179"
local base = text_file .. "_"
local f = 30
local tlk = Tlk:new(text_file, 1, true)

function S010_179:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    tlk:Message(base .. "030")
    local result = tlk:Select(3, base .. "040")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "060")
    else
      tlk:Message(base .. "070")
    end
    tlk:Message(base .. "080")
    tlk:Message(base .. "090")
    tlk:EndTalk(true)
    Qst.Sub:Start(self.ID, 1, false)
    Flg.Set("FLAG_SUB_010_179_001")
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(1)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_005)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "100")
    tlk:EndTalk()
  end
end

function S010_179:Event_020()
  Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e005")
  Field.ObjectLoadMotion(PLAYER, 1, "e005_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e010")
  Field.ObjectLoadMotion(PLAYER, 1, "e011_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  Field.ObjectLoadMotion(PLAYER, 1, "e033")
  Field.ObjectLoadMotion(PLAYER, 1, "fg07_m01")
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_006) then
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
    WaitFrame(15)
    HideMinimap(true)
    HideGuide(true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-6.34, 0.35, 10.74, -0.32, 1.66, 2.85, default, 0)
    PlaySE(401001, 100)
    Obj:new(PLAYER, ""):SetPos(-1.48, 0, 5.02, true)
    Obj:new(PLAYER, ""):SetRotationY(-90, 0)
    Field.ObjectPlayMotion(PLAYER, 1, "e012", 15, true)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "110")
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e015", 10, 10)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Qst.Sub:Set(self.ID, self.STEP_006)
    tlk:EndTalk()
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fn01_01", 10, 10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    goto lbl_731
  elseif Qst.Sub:Check(self.ID, self.STEP_006, self.STEP_007) then
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
    WaitFrame(15)
    HideMinimap(true)
    HideGuide(true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-6.34, 0.35, 10.74, -0.32, 1.66, 2.85, default, 0)
    PlaySE(401001, 100)
    Obj:new(PLAYER, ""):SetPos(-1.48, 0, 5.02, true)
    Obj:new(PLAYER, ""):SetRotationY(-90, 0)
    Field.ObjectPlayMotion(PLAYER, 1, "e012", 15, true)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "120")
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e033", 10, 10)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    tlk:EndTalk()
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fn01_01", 10, 10)
    Qst.Sub:Set(self.ID, self.STEP_007)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    goto lbl_731
  elseif Qst.Sub:Check(self.ID, self.STEP_007, self.STEP_010) then
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
    WaitFrame(15)
    HideMinimap(true)
    HideGuide(true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-6.34, 0.35, 10.74, -0.32, 1.66, 2.85, default, 0)
    PlaySE(401001, 100)
    Obj:new(PLAYER, ""):SetPos(-1.48, 0, 5.02, true)
    Obj:new(PLAYER, ""):SetRotationY(-90, 0)
    Field.ObjectPlayMotion(PLAYER, 1, "e013", 15, true)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "130")
    local result = tlk:Select(3, base .. "140")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "150")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "160")
    else
      tlk:Message(base .. "170")
    end
    tlk:Message(base .. "180")
    tlk:Message(base .. "190")
    tlk:Message(base .. "200")
    local result = tlk:Select(3, base .. "210")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "220")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "230")
    else
      tlk:Message(base .. "240")
    end
    tlk:Message(base .. "250")
    tlk:Message(base .. "260")
    tlk:Message(base .. "270")
    local result = tlk:Select(3, base .. "280")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "290")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "300")
    else
      tlk:Message(base .. "310")
    end
    tlk:Message(base .. "320")
    tlk:Message(base .. "330")
    local result = tlk:Select(3, base .. "340")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "350")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "360")
    else
      tlk:Message(base .. "370")
    end
    tlk:Message(base .. "380")
    tlk:Message(base .. "390")
    tlk:Message(base .. "400")
    Flg.Set("FLAG_SUB_010_179_002")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    Cam.Inst:Clear(0)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fn01_01", 10, 10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_010)
  elseif Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "410")
    tlk:EndTalk()
  end
  ::lbl_731::
end

function S010_179:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local shop_index = GetIndex(NPC, "s010_179_shop")
    Field.ObjectLoadMotion(NPC, shop_index, "e002")
    Field.ObjectLoadMotion(NPC, shop_index, "e008")
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "420")
    Talk.Close()
    WaitCloseTalkWindow()
    Flg.Set("FLAG_SUB_010_179_003")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-3.614, -0.13, -77.54, -9.5, 1.59, -69.65, default, 0)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    FieldObjectSync(FOR_ALL, false)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e002", 10, 10)
    tlk:Message(base .. "430")
    tlk:Message(base .. "440")
    tlk:Message(base .. "450")
    Flg.Set("FLAG_SUB_010_179_004")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(0)
    tlk:EndTalk(true)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
  end
end
