S095_078 = {
  ID = 78,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_095_078_001",
  Flg02 = "FLAG_SUB_095_078_002",
  Flg03 = "FLAG_SUB_095_078_003",
  Flg04 = "FLAG_SUB_095_078_004"
}
local text_file = "s095_078"
local base = "s095_078_"
local tlk = Tlk:new(text_file, 1, true)

function S095_078:Event_010()
  local burimp_index = GetIndex(NPC, "burinp_100")
  Field.ObjectLoadMotion(NPC, burimp_index, "bn01")
  Field.ObjectLoadMotion(NPC, burimp_index, "bn02")
  Field.ObjectLoadMotion(NPC, burimp_index, "fe02")
  Field.ObjectLoadMotion(NPC, burimp_index, "fe04")
  Field.ObjectLoadMotion(NPC, burimp_index, "fq01")
  Field.ObjectLoadMotion(NPC, burimp_index, "fq02")
  Cam.Inst:Set(-108.47, -9.39, 82.31, -99.58, -10.13, 77.8, default, 30)
  tlk:StartTalkAndCancelDigimonRide()
  if not Qst.Sub:Check(self.ID, self.STEP_015) then
    tlk:Message(base .. "010")
  elseif Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    HideMinimap(true)
    HideGuide(true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, burimp_index, "fe02", 10, 10)
    tlk:Message(base .. "110")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, burimp_index, "fq01", 10, 10)
    tlk:Message(base .. "120")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, burimp_index, "fe02", 10, 10)
    tlk:Message(base .. "130")
    Flg.Set("FLAG_IS_CLEAR_S095_078")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    local start_sound = Sound.PlaySE(403053, 100)
    while Sound.IsPlaySE(403053) do
      WaitFrame(1)
    end
    Sound.StopSE(start_sound, 1)
    FieldObjectSync(FOR_ALL, false)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
  tlk:EndTalk()
  Cam.Inst:Clear(30)
end

function S095_078:Event_020()
  local andro_index = GetIndex(NPC, "s095_078_001")
  Field.ObjectLoadMotion(NPC, andro_index, "bn01")
  Field.ObjectLoadMotion(NPC, andro_index, "bn02")
  Field.ObjectLoadMotion(NPC, andro_index, "fe02")
  Field.ObjectLoadMotion(NPC, andro_index, "fe04")
  Field.ObjectLoadMotion(NPC, andro_index, "fq01")
  Field.ObjectLoadMotion(NPC, andro_index, "fq02")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e010_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  tlk:StartTalkAndCancelDigimonRide()
  HideMinimap(true)
  HideGuide(true)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Cam.Inst:Set(-112.17, -11.44, 87.19, -102.94, -10.67, 83.43, default, 0)
  Obj:new(PLAYER, ""):SetPos(-107.75, -12.34, 84.25, true)
  Obj:new(PLAYER, ""):SetRotationY(220, 0)
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq02", 10, 10)
  tlk:Message(base .. "020")
  Field.ObjectLookAtTheObject(PLAYER, 1, NPC, andro_index, 15)
  if CheckItemNum(781, 1) and Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local result = tlk:Select(3, base .. "030")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq01", 10, 10)
      tlk:Message(base .. "040")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fe02", 10, 10)
      tlk:Message(base .. "050")
      HideMinimap(false)
      HideGuide(false)
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq02", 10, 10)
      tlk:Message(base .. "060")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq01", 10, 10)
      tlk:Message(base .. "070")
      HideMinimap(false)
      HideGuide(false)
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fe02", 10, 10)
      tlk:Message(base .. "080")
      INFO_RELEASE_ITEM(781, 1)
      Flg.Set("FLAG_SUB_095_078_005")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(FOR_ALL, false)
      local burinp_100_bn01 = Motion.Object:new(NPC, "burinp_100", "bn01")
      burinp_100_bn01:Play(0, true)
      PlaySE(200015, 100)
      WaitFrame(30)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq01", 10, 10)
      tlk:Message(base .. "090")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fe02", 10, 10)
      tlk:Message(base .. "100")
      Flg.Set("FLAG_SUB_095_078_002")
      FadeOutWithWait(0, 15)
      FieldObjectSync(FOR_ALL, false)
      Cam.Inst:Clear(0)
      tlk:EndTalk()
      WaitFrame(10)
      Field.ObjectResetAim(PLAYER, 1, 0)
      FadeInWithWait(0, 15)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_015)
      goto lbl_620
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, andro_index, 15)
    local result = tlk:Select(2, base .. "035")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq01", 10, 10)
      tlk:Message(base .. "040")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fe02", 10, 10)
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq02", 10, 10)
      tlk:Message(base .. "060")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq01", 10, 10)
      tlk:Message(base .. "070")
    end
    Talk.CloseLetterBox()
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_005)
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, andro_index, 15)
    local result = tlk:Select(2, base .. "030")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq01", 10, 10)
      tlk:Message(base .. "040")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fe02", 10, 10)
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq02", 10, 10)
      tlk:Message(base .. "060")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_index, "fq01", 10, 10)
      tlk:Message(base .. "070")
    end
    HideMinimap(false)
    HideGuide(false)
  end
  tlk:EndTalk()
  Cam.Inst:Clear(30)
  ::lbl_620::
end

function S095_078:Event_030()
  INFO_GET_ITEM(781, 1)
  Qst.Sub:Set(self.ID, self.STEP_010)
  Flg.Set("FLAG_SUB_095_078_001")
end

function S095_078:Event_040()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "140")
  tlk:EndTalk()
end

function S095_078:Event_050()
  if not Flg.Check("FLAG_SUB_095_078_006") then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "180")
    tlk:EndTalk()
    Flg.Set("FLAG_SUB_095_078_006")
  end
end

function S095_078:Event_060()
  if not Flg.Check("FLAG_SUB_095_078_007") then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "190")
    tlk:EndTalk()
    Flg.Set("FLAG_SUB_095_078_007")
  end
end

function S095_078:Event_070()
  if not Flg.Check("FLAG_SUB_095_078_008") then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "200")
    tlk:EndTalk()
    Flg.Set("FLAG_SUB_095_078_008")
  end
end
