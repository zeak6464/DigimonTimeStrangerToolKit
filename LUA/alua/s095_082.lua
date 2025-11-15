S095_082 = {
  ID = 82,
  STEP_001 = 1,
  STEP_004 = 4,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}
local base = "s095_082_"
local text_file = "s095_082"

function S095_082:Event_010()
  if Qst.Main:IsCompleted(M150.ID) then
    local vul_index = GetIndex(NPC, "vulcanus")
    Field.ObjectLoadMotion(NPC, vul_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, vul_index, "bn01")
    Field.ObjectLoadMotion(NPC, vul_index, "bn02")
    Field.ObjectLoadMotion(NPC, vul_index, "fe02")
    Field.ObjectLoadMotion(NPC, vul_index, "fe04")
    Field.ObjectLoadMotion(NPC, vul_index, "fq01")
    Field.ObjectLoadMotion(NPC, vul_index, "fq02")
    Field.ObjectLoadMotion(NPC, vul_index, "e002")
    Field.ObjectLoadMotion(NPC, vul_index, "e004")
    Field.ObjectLoadMotion(NPC, vul_index, "e005")
    Field.ObjectLoadMotion(NPC, vul_index, "e006")
    Field.ObjectLoadMotion(NPC, vul_index, "e012")
    Field.ObjectLoadMotion(NPC, vul_index, "e013")
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
    if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_004) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      HideMinimap(true)
      HideGuide(true)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(-2.91, 2.99, -5.14, -8.45, 2.75, 3.18, default, 0)
      Obj:new(PLAYER, ""):SetPos(-0.64, -0.26, -3.17, true)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fn01_01", 10, 10)
      Obj:new(PLAYER, ""):SetRotationY(0, 0)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      if not Flg.Check("FLAG_MAIN_05_015") then
        Flg.Set("FLAG_MAIN_05_015")
        local bn01 = Motion.Object:new(NPC, "vulcanus", "bn01")
        local fn01_01 = Motion.Object:new(NPC, "vulcanus", "fn01_01")
        local e002 = Motion.Object:new(NPC, "vulcanus", "e002")
        local fq01 = Motion.Object:new(NPC, "vulcanus", "fq01")
        bn01:Play(10, true)
        tlk:Message("s095_082_010")
        fq01:PlayWithStartMoveMotion(10, 10)
        tlk:Message("s095_082_020")
        tlk:Message("s095_082_030")
      else
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
        tlk:Message(base .. "035")
      end
      local result = tlk:Select(3, base .. "040")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        do
          tlk:Message(base .. "050")
          local cam_npc = {
            -0.188,
            8.387,
            -17.826,
            -0.1317,
            7.899,
            -7.838
          }
          local cam_shop = {
            -3.223,
            8.587,
            -16.975,
            -1.256,
            8.444,
            -7.1718
          }
          tlk:EndTalk()
          DevelopShopStart("vulcanus", 152, "fe04", "fq01", "fq01", cam_npc, cam_shop, nil, "fe02")
          Cam.Inst:Clear(30)
          HideMinimap(false)
          HideGuide(false)
          if 1 <= Item.GetNum(904) and not Qst.Sub:Check(152, 6) then
            Qst.Sub:Set(152, 6)
          end
        end
      else
        if result == RESULT_TALK01 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq01", 10, 10)
          tlk:Message(base .. "060")
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
          tlk:Message(base .. "070")
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
          tlk:Message(base .. "080")
        end
        if result == RESULT_TALK02 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq01", 10, 10)
          tlk:Message(base .. "090")
          tlk:EndTalk()
          Cam.Inst:Clear(30)
          HideMinimap(false)
          HideGuide(false)
        else
          result = tlk:Select(3, base .. "100")
          WaitFrame(15)
          if result == RESULT_TALK00 then
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
            tlk:Message(base .. "110")
          elseif result == RESULT_TALK01 then
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq02", 10, 10)
            tlk:Message(base .. "120")
          elseif result == RESULT_TALK02 then
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
            tlk:Message(base .. "130")
          end
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq01", 10, 10)
          tlk:Message(base .. "140")
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
          tlk:Message(base .. "150")
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
          tlk:Message(base .. "160")
          result = tlk:Select(3, base .. "170")
          WaitFrame(15)
          if result == RESULT_TALK00 then
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
            tlk:Message(base .. "180")
          elseif result == RESULT_TALK01 then
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e012", 10, 10)
            tlk:Message(base .. "190")
          elseif result == RESULT_TALK02 then
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq01", 10, 10)
            tlk:Message(base .. "200")
            Qst.Sub:Set(self.ID, self.STEP_004)
            tlk:EndTalk()
            HideMinimap(false)
            HideGuide(false)
            Cam.Inst:Clear(30)
            goto lbl_1004
          end
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
          tlk:Message(base .. "250")
          INFO_GET_ITEM(782, 1)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq01", 10, 10)
          tlk:Message(base .. "260")
          tlk:Message(base .. "270")
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
          tlk:Message(base .. "280")
          tlk:EndTalk(true)
          Qst.Sub:Start(self.ID, 1, false)
          HideMinimap(false)
          HideGuide(false)
          Qst.Sub:Set(self.ID, self.STEP_004)
          Qst.Sub:Set(self.ID, self.STEP_005)
          Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
          Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
          Cam.Inst:Clear(30)
          Flg.Set("FLAG_S095_082_001")
        end
      end
    elseif Qst.Sub:Check(self.ID, self.STEP_004, self.STEP_005) then
      local tlk = Tlk:new(text_file, 1, true)
      HideMinimap(true)
      HideGuide(true)
      tlk:StartTalkAndCancelDigimonRide()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(-2.91, 2.99, -5.14, -8.45, 2.75, 3.18, default, 0)
      Obj:new(PLAYER, ""):SetPos(-0.64, -0.26, -3.17, true)
      Obj:new(PLAYER, ""):SetRotationY(0, 0)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
      tlk:Message(base .. "210")
      local result = tlk:Select(3, base .. "220")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
        tlk:Message(base .. "230")
      end
      if result == RESULT_TALK01 then
        do
          tlk:Message(base .. "050")
          local cam_npc = {
            -0.188,
            8.387,
            -17.826,
            -0.1317,
            7.899,
            -7.838
          }
          local cam_shop = {
            -3.223,
            8.587,
            -16.975,
            -1.256,
            8.444,
            -7.1718
          }
          tlk:EndTalk()
          DevelopShopStart("vulcanus", 152, "fe04", "fq01", "fq01", cam_npc, cam_shop, nil, "fe02")
          HideMinimap(false)
          HideGuide(false)
          if 1 <= Item.GetNum(904) and not Qst.Sub:Check(152, 6) then
            Qst.Sub:Set(152, 6)
          end
        end
      elseif result == RESULT_TALK02 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq02", 10, 10)
        tlk:Message(base .. "240")
        tlk:EndTalk()
        HideMinimap(false)
        HideGuide(false)
        Cam.Inst:Clear(30)
      else
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
        tlk:Message(base .. "250")
        INFO_GET_ITEM(782, 1)
        tlk:Message(base .. "260")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq01", 10, 10)
        tlk:Message(base .. "270")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
        tlk:Message(base .. "280")
        tlk:EndTalk(true)
        Qst.Sub:Start(self.ID, 1, false)
        HideMinimap(false)
        HideGuide(false)
        Qst.Sub:Set(self.ID, self.STEP_005)
        Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
        Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
        Cam.Inst:Clear(30)
        Flg.Set("FLAG_S095_082_001")
      end
    end
  end
  ::lbl_1004::
end

function S095_082:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local shop_index = GetIndex(NPC, "npc_0500")
    Field.ObjectLoadMotion(NPC, shop_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, shop_index, "e002")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e002", 10, 10)
    Field.ObjectLookAtTheObject(NPC, shop_index, PLAYER, 1, 30)
    if not Flg.Check("FLAG_S095_082_002") then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      START_TALK_ACTION_AND_ZOOM("npc_0500", true, true)
      Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "290")
      tlk:Message(base .. "300")
      tlk:Message(base .. "310")
      Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:EndTalk()
      Flg.Set("FLAG_S095_082_002")
      END_TALK_ACTION_AND_ZOOM("npc_0500", true, true)
    else
      local tlk = Tlk:new(text_file, 1, true)
      START_TALK_ACTION_AND_ZOOM("npc_0500", true, true)
      Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "300")
      tlk:Message(base .. "310")
      Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0500", true, true)
    end
    Field.ObjectResetAim(NPC, shop_index, 10)
  end
end

function S095_082:Event_030()
  local simons_index = GetIndex(NPC, "npc_0501")
  Field.ObjectLoadMotion(NPC, simons_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, simons_index, "e002")
  Field.ObjectLoadMotion(NPC, simons_index, "e004")
  Field.ObjectLoadMotion(NPC, simons_index, "e005")
  Field.ObjectLoadMotion(NPC, simons_index, "e006")
  Field.ObjectLoadMotion(NPC, simons_index, "e007")
  Field.ObjectLoadMotion(NPC, simons_index, "e008")
  Field.ObjectLoadMotion(NPC, simons_index, "e009")
  Field.ObjectLoadMotion(NPC, simons_index, "e012")
  Field.ObjectLoadMotion(NPC, simons_index, "e013")
  Field.ObjectLoadMotion(NPC, simons_index, "e014")
  Field.ObjectLoadMotion(NPC, simons_index, "e021")
  Field.ObjectLoadMotion(NPC, simons_index, "e023")
  Field.ObjectLoadMotion(NPC, simons_index, "e510")
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
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
    HideMinimap(true)
    HideGuide(true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-16.26, -0.95, -51.74, -7.32, 1.864, -48.247, default, 0)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "fn01_01", 0, 10)
    Obj:new(PLAYER, ""):SetPos(-9.49, 0.054, -48.22, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    PlayerLookAtObject(NPC, "npc_0501")
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    ObjectTurnToPlayer(NPC, "npc_0501")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "320")
    Field.ObjectPlayMotion(NPC, simons_index, "e006", 15, true)
    tlk:Message(base .. "330")
    tlk:Message(base .. "340")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(3, base .. "350")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotion(NPC, simons_index, "e012", 15, true)
      tlk:Message(base .. "360")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotion(NPC, simons_index, "e023", 15, true)
      tlk:Message(base .. "370")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotion(NPC, simons_index, "e008", 15, true)
      tlk:Message(base .. "380")
    end
    Field.ObjectPlayMotion(NPC, simons_index, "e004", 15, true)
    tlk:Message(base .. "390")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e002", 10, 10)
    tlk:Message(base .. "400")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e023", 10, 10)
    tlk:Message(base .. "410")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk()
    Field.ClearMobTransparentFrontOfCamera(0)
    Cam.Inst:Clear(30)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_010)
  else
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e002", 10, 10)
    tlk:Message(base .. "415")
    tlk:EndTalk()
  end
end

function S095_082:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new(text_file, 1, true)
    local shop_index = GetIndex(NPC, "npc_0500")
    local simons_index = GetIndex(NPC, "npc_0501")
    Field.ObjectLoadMotion(NPC, simons_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, simons_index, "e002")
    Field.ObjectLoadMotion(NPC, simons_index, "e004")
    Field.ObjectLoadMotion(NPC, simons_index, "e005")
    Field.ObjectLoadMotion(NPC, simons_index, "e006")
    Field.ObjectLoadMotion(NPC, simons_index, "e007")
    Field.ObjectLoadMotion(NPC, simons_index, "e008")
    Field.ObjectLoadMotion(NPC, simons_index, "e009")
    Field.ObjectLoadMotion(NPC, simons_index, "e012")
    Field.ObjectLoadMotion(NPC, simons_index, "e013")
    Field.ObjectLoadMotion(NPC, simons_index, "e014")
    Field.ObjectLoadMotion(NPC, simons_index, "e021")
    Field.ObjectLoadMotion(NPC, simons_index, "e023")
    Field.ObjectLoadMotion(NPC, simons_index, "e510")
    Field.ObjectLoadMotion(NPC, shop_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, shop_index, "e002")
    Field.ObjectLoadMotion(NPC, shop_index, "e004")
    Field.ObjectLoadMotion(NPC, shop_index, "e005")
    Field.ObjectLoadMotion(NPC, shop_index, "e006")
    Field.ObjectLoadMotion(NPC, shop_index, "e008")
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
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
    Cam.Inst:Set(-17.38, 0.1543, -46.647, -7.497, 1.674, -46.56, default, 0)
    Obj:new(PLAYER, ""):SetPos(-8.63, 0.05, -46.29, true)
    Obj:new(PLAYER, ""):SetRotationY(-60, 0)
    PlayerLookAtObject(NPC, "npc_0500")
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    Field.ObjectLookAtTheObject(NPC, shop_index, PLAYER, 1, 30)
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e006", 10, 10)
    tlk:Message(base .. "420")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e004", 10, 10)
    tlk:Message(base .. "430")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e002", 10, 10)
    tlk:Message(base .. "440")
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(3, base .. "450")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e008", 10, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "460")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "470")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "480")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e002", 10, 10)
    tlk:Message(base .. "490")
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-16.55, 0.1543, -48, -6.76, 1.674, -46.69, default, 0)
    Obj:new(NPC, "npc_0501"):SetPos(-8.69, 0.054, -47.59, true)
    WaitFrame(30)
    Field.ObjectLookAtTheObject(NPC, shop_index, NPC, simons_index, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    ObjectTurnToObject(NPC, "npc_0501", NPC, "npc_0500")
    PlayerLookAtObject(NPC, "npc_0501")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e002", 10, 10)
    tlk:Message(base .. "500")
    Field.ObjectLookAtTheObject(NPC, simons_index, PLAYER, 1, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e008", 10, 10)
    tlk:Message(base .. "510")
    Field.ObjectLookAtTheObject(NPC, simons_index, NPC, shop_index, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e002", 10, 10)
    tlk:Message(base .. "520")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e002", 10, 10)
    tlk:Message(base .. "530")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e004", 10, 10)
    tlk:Message(base .. "540")
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e021", 10, 10)
    tlk:Message(base .. "550")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectResetAim(NPC, shop_index, 30)
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, shop_index, "e002", 10, 10)
    tlk:Message(base .. "560")
    Field.ObjectChangeExpression(NPC, shop_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e002", 10, 10)
    Field.ObjectLookAtTheObject(NPC, simons_index, PLAYER, 1, 30)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "570")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    ObjectTurnToPlayer(NPC, "npc_0501")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e012", 10, 10)
    tlk:Message(base .. "580")
    Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    INFO_GET_ITEM(784, 1)
    Flg.Set("FLAG_S095_082_003")
    Qst.Sub:Set(self.ID, self.STEP_015)
    BackFadeOutWithWait(FADE_BLACK, 15)
    WaitFrame(30)
    tlk:Message(base .. "590")
    tlk:EndTalk()
    Field.ClearMobTransparentFrontOfCamera(0)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    local prifix = "d"
    local number = 505
    local locator = "start_25"
    local time_axis = "A2020_dbef_199"
    local time_zone = MORNING
    Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
    Flg.Set("FLAG_IS_START_EVENT_BEFORE_MAPCHANGE")
    Common.RequestMapChangeWithTimeTravel(prifix, number, locator, time_axis, time_zone)
  end
end

function S095_082:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local vul_index = GetIndex(NPC, "vulcanus")
    Field.ObjectLoadMotion(NPC, vul_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, vul_index, "bn01")
    Field.ObjectLoadMotion(NPC, vul_index, "bn02")
    Field.ObjectLoadMotion(NPC, vul_index, "fe02")
    Field.ObjectLoadMotion(NPC, vul_index, "fe04")
    Field.ObjectLoadMotion(NPC, vul_index, "fq01")
    Field.ObjectLoadMotion(NPC, vul_index, "fq02")
    Field.ObjectLoadMotion(NPC, vul_index, "e002")
    Field.ObjectLoadMotion(NPC, vul_index, "e004")
    Field.ObjectLoadMotion(NPC, vul_index, "e005")
    Field.ObjectLoadMotion(NPC, vul_index, "e006")
    Field.ObjectLoadMotion(NPC, vul_index, "e012")
    Field.ObjectLoadMotion(NPC, vul_index, "e013")
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
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(10)
    HideMinimap(true)
    WaitFrame(5)
    HideGuide(true)
    WaitFrame(5)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Cam.Inst:Set(-2.91, 2.99, -5.14, -8.45, 2.75, 3.18, default, 0)
    Obj:new(PLAYER, ""):SetPos(-0.64, -0.26, -3.17, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fn01_01", 10, 10)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
    tlk:Message(base .. "600")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
    tlk:Message(base .. "610")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fe04", 10, 10)
    tlk:Message(base .. "620")
    local result = tlk:Select(3, base .. "630")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
      tlk:Message(base .. "640")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
      tlk:Message(base .. "650")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
      tlk:Message(base .. "660")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e012", 10, 10)
    tlk:Message(base .. "670")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "fq01", 10, 10)
    tlk:Message(base .. "680")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e002", 10, 10)
    tlk:Message(base .. "690")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, vul_index, "e004", 10, 10)
    tlk:Message(base .. "700")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end
