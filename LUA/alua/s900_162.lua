S900_162 = {
  ID = 162,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255
}
local base = "s900_162_"
local text_file = "s900_162"
local tlk = Tlk:new(text_file, 1, true)

function S900_162:Event_010()
  local king_index = GetIndex(NPC, "s900_162_001")
  local king_index_2 = GetIndex(NPC, "s900_162_002")
  Field.ObjectLoadMotion(NPC, king_index_2, "bn01")
  Field.ObjectLoadMotion(NPC, king_index_2, "bn02")
  Field.ObjectLoadMotion(NPC, king_index_2, "fe02")
  Field.ObjectLoadMotion(NPC, king_index_2, "fe04")
  Field.ObjectLoadMotion(NPC, king_index_2, "fq01")
  Field.ObjectLoadMotion(NPC, king_index_2, "fq02")
  Field.ObjectLoadMotion(NPC, king_index, "e002")
  Field.ObjectLoadMotion(NPC, king_index, "e004")
  Field.ObjectLoadMotion(NPC, king_index, "e005")
  Field.ObjectLoadMotion(NPC, king_index, "e012")
  Field.ObjectLoadMotion(NPC, king_index, "fn01_01")
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
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    START_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
    PlayerTurnToObject(NPC, "s900_162_001", true, false, 0, 0)
    Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    ObjectTurnToPlayer(NPC, "s900_162_001")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "010")
    Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "030")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "040")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "050")
    end
    Qst.Sub:Set(self.ID, self.STEP_005)
  end
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_20) then
    if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
      tlk:StartTalkAndCancelDigimonRide()
      PlayerTurnToObject(NPC, "s900_162_001", true, false, 0, 0)
      HideMinimap(true)
      HideGuide(true)
      Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
      START_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
      ObjectTurnToPlayer(NPC, "s900_162_001")
      WaitFrame(15)
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e004", 10, 10)
    tlk:Message(base .. "060")
    Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(2, base .. "070")
    Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "080")
      Qst.Sub:Set(self.ID, self.STEP_010)
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "090")
      tlk:EndTalk()
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM("s900_162_001", true, true)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
    else
      tlk:Message(base .. "100")
      tlk:EndTalk(true)
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      Qst.Sub:Start(self.ID, 1, false)
      END_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
      local result = Field.StartCardGameWithNPC(901, true)
      if result == CARD_GAME_WIN then
        tlk:StartTalkAndCancelDigimonRide()
        Cam.Inst:Set(13.54, 0, -26.03, 4.33, 1.61, -22.48, default, 0)
        Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
        Obj:new(PLAYER, ""):SetPos(6.59, 0, -23.89, true)
        Obj:new(PLAYER, ""):SetRotationY(90, 0)
        Obj:new(NPC, "s900_162_001"):SetRotationY(270, 0)
        WaitFrame(15)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e005", 10, 10)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message(base .. "130")
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Qst.Sub:Set(self.ID, self.STEP_015)
      elseif result == CARD_GAME_LOSE then
        tlk:StartTalkAndCancelDigimonRide()
        START_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e004", 10, 10)
        tlk:Message(base .. "110")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
        tlk:Message(base .. "120")
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        END_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
        tlk:EndTalk()
        goto lbl_924
      else
        tlk:StartTalkAndCancelDigimonRide()
        START_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e004", 10, 10)
        tlk:Message(base .. "110")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
        tlk:Message(base .. "120")
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        END_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
        tlk:EndTalk()
        goto lbl_924
      end
      FadeOutWithWait(0, 15)
      Obj:new(NPC, "s900_162_001"):Invisible()
      Obj:new(NPC, "s900_162_002"):CancelInvisible()
      Cam.Inst:Set(9.45, 2.65, -24.28, -0.08, 1.75, -21.35, default, 0)
      FadeInWithWait(0, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index_2, "fe04", 10, 10)
      tlk:Message(base .. "140")
      local result = tlk:Select(3, base .. "150")
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index_2, "fq01", 10, 10)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "160")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "170")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "180")
      end
      tlk:Message(base .. "200")
      tlk:Message(base .. "210")
      FadeOutWithWait(0, 15)
      Obj:new(NPC, "s900_162_002"):Invisible()
      Obj:new(NPC, "s900_162_001"):CancelInvisible()
      Cam.Inst:Set(13.54, 0, -26.03, 4.33, 1.61, -22.48, default, 0)
      FadeInWithWait(0, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "215")
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_020)
      Field.ClearMobTransparentFrontOfCamera(0)
      Cam.Inst:Clear(30)
      Flg.Set("FLAG_SUB_900_162_005")
    end
  end
  ::lbl_924::
  Field.ClearMobTransparentFrontOfCamera(0)
end

function S900_162:Event_030()
  local king_index = GetIndex(NPC, "s900_162_001")
  Field.ObjectLoadMotion(NPC, king_index, "e002")
  Field.ObjectLoadMotion(NPC, king_index, "e004")
  Field.ObjectLoadMotion(NPC, king_index, "e005")
  Field.ObjectLoadMotion(NPC, king_index, "e012")
  Field.ObjectLoadMotion(NPC, king_index, "fn01_01")
  if Flg.Check("FLAG_SUB_900_162_005") then
    tlk:StartTalkAndCancelDigimonRide()
    START_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
    Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
    ObjectTurnToPlayer(NPC, "s900_162_001")
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
    tlk:Message(base .. "220")
    local result = tlk:Select(2, base .. "230")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "240")
      tlk:EndTalk()
      local result = Field.StartCardGameWithNPC(901, true)
      if result == CARD_GAME_WIN then
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message(base .. "270")
      else
        if result == CARD_GAME_LOSE then
          tlk:StartTalkAndCancelDigimonRide()
          tlk:Message(base .. "260")
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
          goto lbl_161
        else
        end
      end
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "250")
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("s900_162_001", false, true)
    else
      tlk:EndTalk()
      Field.ClearMobTransparentFrontOfCamera(0)
    end
  end
  ::lbl_161::
end

function S900_162:Event_040()
  local king_index = GetIndex(NPC, "s900_162_trueking")
  Field.ObjectLoadMotion(NPC, king_index, "e002")
  Field.ObjectLoadMotion(NPC, king_index, "e004")
  Field.ObjectLoadMotion(NPC, king_index, "e005")
  Field.ObjectLoadMotion(NPC, king_index, "e008")
  Field.ObjectLoadMotion(NPC, king_index, "e010")
  Field.ObjectLoadMotion(NPC, king_index, "e012")
  Field.ObjectLoadMotion(NPC, king_index, "e018")
  Field.ObjectLoadMotion(NPC, king_index, "fn01_01")
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
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    if not Flg.Check("FLAG_SUB_900_162_002") and not Flg.Check("FLAG_SUB_900_162_001") then
      tlk:StartTalkAndCancelDigimonRide()
      HideMinimap(true)
      HideGuide(true)
      START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "420")
      Field.ObjectPlayMotion(NPC, king_index, "e012", 15, true)
      tlk:Message(base .. "430")
      Field.ObjectPlayMotion(NPC, king_index, "e004", 15, true)
      tlk:Message(base .. "440")
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      local result = tlk:Select(3, base .. "450")
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "460")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "470")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "480")
      end
      Field.ObjectPlayMotion(NPC, king_index, "e012", 15, true)
      tlk:Message(base .. "490")
      Field.ObjectPlayMotion(NPC, king_index, "e005", 15, true)
      tlk:Message(base .. "500")
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      local result = tlk:Select(2, base .. "510")
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotion(NPC, king_index, "e004", 15, true)
        tlk:Message(base .. "520")
      end
      if result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e010", 10, 10)
        tlk:Message(base .. "530")
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Flg.Set("FLAG_SUB_900_162_002")
      else
        Field.ObjectPlayMotion(NPC, king_index, "e018", 15, true)
        tlk:Message(base .. "540")
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        tlk:EndTalk(true)
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        local result = Field.StartCardGameWithNPC(903, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Field.ObjectLookAtTheObject(NPC, king_index, PLAYER, 1, 30)
        if result == CARD_GAME_WIN then
          tlk:StartTalkAndCancelDigimonRide()
          START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e004", 10, 10)
          tlk:Message(base .. "560")
        elseif result == CARD_GAME_LOSE then
          tlk:StartTalkAndCancelDigimonRide()
          START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
          tlk:Message(base .. "550")
          Flg.Set("FLAG_SUB_900_162_002")
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          goto lbl_1277
        else
          tlk:StartTalkAndCancelDigimonRide()
          START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
          tlk:Message(base .. "550")
          Flg.Set("FLAG_SUB_900_162_002")
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          goto lbl_1277
        end
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
        tlk:Message(base .. "570")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e018", 10, 10)
        tlk:Message(base .. "580")
        tlk:EndTalk(true)
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        HideMinimap(false)
        HideGuide(false)
        Qst.Sub:End(self.ID, self.STEP_255)
        Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
        Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
        Flg.Set("FLAG_SUB_900_162_001")
        Flg.Set("FLAG_SUB_900_162_002")
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      end
    elseif Flg.Check("FLAG_SUB_900_162_002") and not Flg.Check("FLAG_SUB_900_162_001") then
      tlk:StartTalkAndCancelDigimonRide()
      HideMinimap(true)
      HideGuide(true)
      START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
      Field.ObjectPlayMotion(NPC, king_index, "e012", 15, true)
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "490")
      Field.ObjectPlayMotion(NPC, king_index, "e005", 15, true)
      tlk:Message(base .. "500")
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      local result = tlk:Select(2, base .. "510")
      WaitFrame(15)
      Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotion(NPC, king_index, "e004", 15, true)
        tlk:Message(base .. "520")
      end
      if result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e010", 10, 10)
        tlk:Message(base .. "530")
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      else
        Field.ObjectPlayMotion(NPC, king_index, "e018", 15, true)
        tlk:Message(base .. "540")
        tlk:EndTalk(true)
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        local result = Field.StartCardGameWithNPC(903, true)
        Field.ObjectLookAtTheObject(NPC, king_index, PLAYER, 1, 30)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        if result == CARD_GAME_WIN then
          tlk:StartTalkAndCancelDigimonRide()
          START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Flg.Set("FLAG_SUB_900_162_001")
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e004", 10, 10)
          tlk:Message(base .. "560")
        elseif result == CARD_GAME_LOSE then
          tlk:StartTalkAndCancelDigimonRide()
          START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
          tlk:Message(base .. "550")
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          goto lbl_1277
        else
          tlk:StartTalkAndCancelDigimonRide()
          START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
          tlk:Message(base .. "550")
          Flg.Set("FLAG_SUB_900_162_002")
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          goto lbl_1277
        end
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e002", 10, 10)
        tlk:Message(base .. "570")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e018", 10, 10)
        tlk:Message(base .. "580")
        tlk:EndTalk(true)
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        HideMinimap(false)
        HideGuide(false)
        Qst.Sub:End(self.ID, self.STEP_255)
        Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
        Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      end
    end
  elseif Flg.Check("FLAG_SUB_900_162_001") then
    tlk:StartTalkAndCancelDigimonRide()
    START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
    Field.ObjectPlayMotion(NPC, king_index, "e004", 15, true)
    Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "590")
    repeat
      local result = tlk:Select(2, base .. "600")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotion(NPC, king_index, "e018", 15, true)
        tlk:Message(base .. "610")
      end
      if result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e010", 10, 10)
        tlk:Message(base .. "620")
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      else
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        local result = Field.StartCardGameWithNPC(903, true)
        Field.ObjectLookAtTheObject(NPC, king_index, PLAYER, 1, 30)
        Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        if result == CARD_GAME_WIN then
          tlk:StartTalkAndCancelDigimonRide()
          START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e004", 10, 10)
          tlk:Message(base .. "640")
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
          Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        else
          if result == CARD_GAME_LOSE then
            tlk:StartTalkAndCancelDigimonRide()
            START_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, king_index, "e004", 10, 10)
            tlk:Message(base .. "630")
            tlk:EndTalk()
            END_TALK_ACTION_AND_ZOOM("s900_162_trueking", true, true)
            Field.ObjectChangeExpression(NPC, king_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          else
          end
          break -- pseudo-goto
        end
      end
    until true
  end
  ::lbl_1277::
  Field.ObjectResetAim(NPC, king_index, 10)
end
