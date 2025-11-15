S050_038 = {
  ID = 38,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}
local base = "s050_038_"
local text_file = "s050_038"

function S050_038:Event_010()
  local zudo_index = GetIndex(NPC, "zudo_01")
  Field.ObjectLoadMotion(NPC, zudo_index, "bn01")
  Field.ObjectLoadMotion(NPC, zudo_index, "bn02")
  Field.ObjectLoadMotion(NPC, zudo_index, "fq01")
  Field.ObjectLoadMotion(NPC, zudo_index, "fq02")
  Field.ObjectLoadMotion(NPC, zudo_index, "fe02")
  Field.ObjectLoadMotion(NPC, zudo_index, "fe03")
  Field.ObjectLoadMotion(NPC, zudo_index, "fe04")
  local zudo_01 = Motion.Object:new(NPC, "zudo_01", "f000")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  if Qst.Main:IsCompleted(M140.ID) and not Qst.Sub:IsCompleted(self.ID) and Flg.Check("FLAG_SUB_S050_038_001") and not Qst.Sub:Check(self.ID, self.STEP_005) then
    do
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 0)
      HideMinimap(true)
      HideGuide(true)
      Obj:new(PLAYER, ""):SetPos(5.98, 2, 32.17, true)
      WaitFrame(1)
      Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 0)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zudo_index, 0)
      Obj:new(PLAYER, ""):SetRotationY(30, 0)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      tlk:Message(base .. "0160")
      tlk:MessageClose()
      local result = tlk:Select(2, base .. "0170")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe04", 10, 10)
        tlk:Message(base .. "0180")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "0190")
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
        tlk:Message(base .. "0140")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
        tlk:Message(base .. "0150")
        tlk:EndTalk(true)
        Qst.Sub:Start(self.ID, 1, false)
        HideMinimap(false)
        HideGuide(false)
        Qst.Sub:Set(self.ID, self.STEP_005)
        Flg.Set("FLAG_SUB_S050_038_002")
        Field.ObjectResetAim(NPC, zudo_index, 30)
        Cam.Inst:Clear(30)
        Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
        Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
        if 1 > Item.GetNum(312) then
          zudo_01:Play(15, true)
        end
      end
    end
  elseif Qst.Main:IsCompleted(M140.ID) and not Qst.Sub:IsCompleted(self.ID) then
    if not Flg.Check("FLAG_SUB_S050_038_001") and not Qst.Sub:Check(self.ID, self.STEP_005) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 0)
      HideMinimap(true)
      HideGuide(true)
      Obj:new(PLAYER, ""):SetPos(5.98, 2, 32.17, true)
      WaitFrame(1)
      Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 0)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zudo_index, 0)
      Obj:new(PLAYER, ""):SetRotationY(30, 0)
      HideMinimap(true)
      HideGuide(true)
      Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 0)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      tlk:Message(base .. "0010")
      tlk:MessageClose()
      local result = tlk:Select(3, base .. "0020")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
        tlk:Message(base .. "0030")
      end
      if result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
        tlk:Message(base .. "0040")
      end
      if result == RESULT_TALK02 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
        tlk:Message(base .. "0050")
      end
      tlk:Message(base .. "0060")
      tlk:Message(base .. "0070")
      Field.ObjectResetAim(NPC, zudo_index, 10)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fq02", 10, 10)
      tlk:Message(base .. "0080")
      Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 30)
      tlk:MessageClose()
      result = tlk:Select(3, base .. "0090")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
        tlk:Message(base .. "0100")
      end
      if result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
        tlk:Message(base .. "0110")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "0120")
        Flg.Set("FLAG_SUB_S050_038_001")
        Cam.Inst:Clear(30)
        tlk:EndTalk()
        HideMinimap(false)
        HideGuide(false)
        zudo_01:Play(15, true)
        Field.ObjectResetAim(NPC, zudo_index, 30)
      else
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe04", 10, 10)
        tlk:Message(base .. "0130")
        tlk:Message(base .. "0140")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
        tlk:Message(base .. "0150")
        tlk:EndTalk(true)
        Qst.Sub:Start(self.ID, 1, false)
        HideMinimap(false)
        HideGuide(false)
        Qst.Sub:Set(self.ID, self.STEP_005)
        Flg.Set("FLAG_SUB_S050_038_002")
        Field.ObjectResetAim(NPC, zudo_index, 30)
        Cam.Inst:Clear(30)
        Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
        Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
        if 1 > Item.GetNum(312) then
          zudo_01:Play(15, true)
        end
      end
    elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and 1 > Item.GetNum(312) then
      local tlk = Tlk:new(text_file, 1, true)
      Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 30)
      Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 15)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "0140")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
      tlk:Message(base .. "0150")
      Cam.Inst:Clear(30)
      Field.ObjectResetAim(NPC, zudo_index, 30)
      tlk:EndTalk()
      zudo_01:Play(15, true)
    end
  end
end

function S050_038:Event_025()
  INFO_GET_ITEM(312, 1)
  Flg.Set("FLAG_SUB_S050_038_003")
  WaitFrame(1)
  FieldObjectSync(FOR_ALL, true)
  WaitFrame(1)
end

function S050_038:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local zudo_index = GetIndex(NPC, "zudo_01")
    local zudo_index_2 = GetIndex(NPC, "shop_0004")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn01")
    Field.ObjectLoadMotion(NPC, zudo_index, "bn02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq01")
    Field.ObjectLoadMotion(NPC, zudo_index, "fq02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe02")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe03")
    Field.ObjectLoadMotion(NPC, zudo_index, "fe04")
    Field.ObjectLoadMotion(NPC, zudo_index_2, "bn01")
    Field.ObjectLoadMotion(NPC, zudo_index_2, "bn02")
    Field.ObjectLoadMotion(NPC, zudo_index_2, "fq01")
    Field.ObjectLoadMotion(NPC, zudo_index_2, "fq02")
    Field.ObjectLoadMotion(NPC, zudo_index_2, "fe02")
    Field.ObjectLoadMotion(NPC, zudo_index_2, "fe04")
    local shop_0004 = Motion.Object:new(NPC, "shop_0004", "f000")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    if 1 <= Item.GetNum(312) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 0)
      HideMinimap(true)
      HideGuide(true)
      Obj:new(PLAYER, ""):SetPos(5.98, 2, 32.17, true)
      WaitFrame(1)
      Field.ObjectLookAtTheObject(NPC, zudo_index, PLAYER, 1, 0)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zudo_index, 0)
      Obj:new(PLAYER, ""):SetRotationY(30, 0)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      tlk:Message(base .. "0200")
      tlk:Message(base .. "0210")
      INFO_RELEASE_ITEM(312, 1)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index, "fe02", 10, 10)
      tlk:Message(base .. "0220")
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Flg.Set("FLAG_IS_CLEAR_S050_038")
      FieldObjectSync(FOR_ALL, false)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index_2, "bn01", 10, 10)
      PlaySE(200015, 100)
      WaitFrame(30)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Field.ObjectLookAtTheObject(NPC, zudo_index_2, PLAYER, 1, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index_2, "fe02", 10, 10)
      tlk:Message(base .. "0230")
      tlk:Message(base .. "0240")
      tlk:EndTalk()
      local cam_npc = {
        13.615,
        3.701,
        26.697,
        5.997,
        5.477,
        32.927
      }
      local cam_shop = {
        11.75,
        6.04,
        23.979,
        6.192,
        5.202,
        32.25
      }
      DevelopShopStart_OnlySub("shop_0004", 150, "fe04", "fq01", "fq01", cam_npc, cam_shop, "f000", "fe02")
      tlk:StartTalkAndCancelDigimonRide()
      Cam.Inst:Set(9.2, 3.9687, 28.18, 5.934, 3.61077, 37.6236, default, 30)
      tlk:Message(base .. "0250")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index_2, "fe04", 10, 10)
      tlk:Message(base .. "0260")
      tlk:Message(base .. "0270")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zudo_index_2, "fe02", 10, 10)
      tlk:Message(base .. "0280")
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      Field.ObjectResetAim(NPC, zudo_index_2, 30)
      shop_0004:Play(15, true)
      HideMinimap(false)
      HideGuide(false)
      Flg.Set("FLAG_SUB_S050_038_003")
      Qst.Sub:End(self.ID, self.STEP_255)
    end
  end
end
