S200_149 = {
  ID = 149,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255,
  Flg001 = "FLAG_SUB_200_149_001",
  Flg002 = "FLAG_SUB_200_149_002",
  Flg003 = "FLAG_SUB_200_149_003",
  Flg004 = "FLAG_SUB_200_149_004",
  Flg005 = "FLAG_SUB_200_149_005",
  Flg006 = "FLAG_SUB_200_149_006",
  Flg007 = "FLAG_SUB_200_149_007",
  Flg008 = "FLAG_SUB_200_149_008"
}
local text_file = "s200_149"
local base = text_file .. "_"
local tlk = Tlk:new(text_file, 1, true)

function S200_149:Event_001()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message("s200_149_1150")
  local result = tlk:Select(2, "s200_149_1160")
  if result == RESULT_TALK00 then
    require("S200_149")
    tlk:EndTalk()
    S200_149:Event_010()
  else
    tlk:EndTalk()
  end
end

function S200_149:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local hiroko_index = GetIndex(NPC, "S200_149_hiroko_01")
    local hiroko = {
      obj = Obj:new(NPC, "S200_149_hiroko_01"),
      e002 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e002"),
      e004 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e004"),
      e008 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e008"),
      e010 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e010"),
      e012 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e012"),
      fn01_01 = Motion.Object:new(NPC, "S200_149_hiroko_01", "fn01_01")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Fade_OutNoLoadingWithWait(FADE_BLACK, 30)
    Cam.Inst:Set(3.2458, 0.8037, -7.375, 2.144, 2.1902, 2.466, default, 0)
    HideMinimap(true)
    HideGuide(true)
    Flg.Set("FLAG_SUB_200_149_009")
    Flg.Set("FLAG_SUB_200_149_010")
    FieldObjectSync(FOR_ALL, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Obj:new(PLAYER, ""):SetPos(1.817, 0.68, 1.2954)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    player.fn01_01:Play(15, true)
    WaitFrame(30)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, hiroko_index, 0)
    Field.ObjectLookAtTheObject(NPC, hiroko_index, PLAYER, 1, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    hiroko.e012:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "010")
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "020")
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, false, 10)
    local result = tlk:Select(3, base .. "030")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "050")
    else
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F03", EYE_BLINK, true, 10)
      hiroko.e012:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "060")
    end
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "070")
    tlk:Message(base .. "080")
    hiroko.e012:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "090")
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, false, 10)
    result = tlk:Select(3, base .. "100")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "110")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "120")
    else
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e012:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "130")
    end
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "140")
    tlk:Message(base .. "150")
    hiroko.e010:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F04", EYE_BLINK, true, 10)
    tlk:Message(base .. "160")
    hiroko.obj:ChangeExpression("F04", EYE_BLINK, false, 10)
    result = tlk:Select(3, base .. "170")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "180")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "190")
    else
      WaitFrame(15)
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "200")
    end
    hiroko.e012:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "210")
    hiroko.e008:Play(10, true)
    tlk:Message(base .. "220")
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, false, 10)
    tlk:MessageClose()
    Talk.CloseLetterBox()
    Qst.Sub:Start(self.ID, 1, false)
    Talk.OpenLetterBox()
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "230")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectResetMotion(NPC, GetIndex(NPC, "S200_149_hiroko_01"), 0)
    tlk:EndTalk()
    Cam.Inst:Clear(0)
    WaitFrame(30)
    Field.ClearMobTransparentFrontOfCamera(0)
    HideMinimap(false)
    HideGuide(false)
    FieldObjectSync(FOR_ALL, false)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_005)
  end
end

function S200_149:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local hiroko_index = GetIndex(NPC, "S200_149_hiroko_01")
    local hiroko = {
      obj = Obj:new(NPC, "S200_149_hiroko_01"),
      e002 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e002"),
      e004 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e004"),
      e008 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e008"),
      e010 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e010"),
      e012 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e012"),
      fn01_01 = Motion.Object:new(NPC, "S200_149_hiroko_01", "fn01_01")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    if not self:IsCostumeChange() then
      Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, hiroko_index, 10)
      Field.ObjectLookAtTheObject(NPC, hiroko_index, PLAYER, 1, 10)
      tlk:StartTalkActionAndZoom("S200_149_hiroko_01")
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "240")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "S200_149_hiroko_01"), 30)
      Field.ObjectResetAim(PLAYER, 1, 10)
      tlk:EndTalkActionAndZoom()
      Field.ClearMobTransparentFrontOfCamera(0)
    elseif self:IsCostumeChange() then
      Fade_OutNoLoadingWithWait(FADE_BLACK, 30)
      Cam.Inst:Set(3.2458, 0.8037, -7.375, 2.144, 2.1902, 2.466, default, 0)
      HideMinimap(true)
      HideGuide(true)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Obj:new(PLAYER, ""):SetPos(1.817, 0.68, 1.2954)
      Obj:new(PLAYER, ""):SetRotationY(0, 0)
      player.fn01_01:Play(15, true)
      WaitFrame(30)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, hiroko_index, 0)
      Field.ObjectLookAtTheObject(NPC, hiroko_index, PLAYER, 1, 0)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      tlk:StartTalkAndCancelDigimonRide()
      hiroko.e004:PlayWithStartMoveMotion(10, 10)
      hiroko.obj:ChangeExpression("F02", EYE_CLOSE, true, 10)
      tlk:Message(base .. "250")
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "260")
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, false, 10)
      local result = tlk:Select(3, base .. "270")
      if result == RESULT_TALK00 then
        WaitFrame(15)
        hiroko.obj:ChangeExpression("F03", EYE_BLINK, true, 10)
        hiroko.e010:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "280")
      elseif result == RESULT_TALK01 then
        WaitFrame(15)
        hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
        hiroko.e008:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "290")
      else
        WaitFrame(15)
        hiroko.obj:ChangeExpression("F04", EYE_BLINK, true, 10)
        hiroko.e010:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "300")
      end
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
      hiroko.e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "310")
      tlk:Message(base .. "320")
      tlk:Message(base .. "330")
      hiroko.obj:ChangeExpression("F01", EYE_BLINK, false, 10)
      result = tlk:Select(3, base .. "340")
      if result == RESULT_TALK00 then
        WaitFrame(15)
        hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
        hiroko.e002:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "350")
      elseif result == RESULT_TALK01 then
        WaitFrame(15)
        hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
        hiroko.e012:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "360")
      else
        WaitFrame(15)
        hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
        hiroko.e012:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "370")
      end
      hiroko.obj:ChangeExpression("F02", EYE_CLOSE, true, 10)
      hiroko.e004:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "380")
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      hiroko.obj:ResetExporession(10)
      tlk:EndTalk()
      Cam.Inst:Clear(0)
      WaitFrame(30)
      Field.ClearMobTransparentFrontOfCamera(0)
      HideMinimap(false)
      HideGuide(false)
      Flg.Set(self.Flg001)
      FieldObjectSync(FOR_ALL, false)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Qst.Sub:Set(self.ID, self.STEP_010)
    end
  end
end

function S200_149:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fg07_d03 = Motion.Object:new(PLAYER, "", "fg07_d03"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
    HideMinimap(true)
    HideGuide(true)
    player.fn01_01:Play(15, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "390")
    player.fg07_d03:Play2Wait(10, false)
    player.fn01_01:Play(15, true)
    tlk:Message(base .. "400")
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
    tlk:Message(base .. "430")
    tlk:Message(base .. "440")
    local result = tlk:Select(3, base .. "450")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      tlk:Message(base .. "460")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      tlk:Message(base .. "470")
    else
      WaitFrame(15)
      tlk:Message(base .. "480")
    end
    tlk:Message(base .. "490")
    tlk:Message(base .. "500")
    tlk:EndTalk(true)
    Flg.Set(self.Flg002)
    Field.ClearMobTransparentFrontOfCamera(0)
    Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
    MapChange("t", 302, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function S200_149:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check(self.Flg002, self.Flg003) then
    local hiroko = {
      obj = Obj:new(NPC, "S200_149_hiroko_01"),
      e002 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e002"),
      e004 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e004"),
      e008 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e008"),
      e010 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e010"),
      e012 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e012"),
      fn01_01 = Motion.Object:new(NPC, "S200_149_hiroko_01", "fn01_01")
    }
    local koan = {
      e018 = Motion.Object:new(NPC, "S200_149_koan_001", "e018")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Field.ObjectInvisible(NPC, FOR_ALL, 0, 0, false)
    Field.ObjectInvisible(MOB, FOR_ALL, 0, 0, false)
    Obj:new(NPC, "S200_149_hiroko_01"):CancelInvisible()
    Obj:new(NPC, "S200_149_koan_001"):CancelInvisible()
    Obj:new(PLAYER, ""):SetPos(8.031, 0, 27.248)
    Obj:new(PLAYER, ""):SetRotationY(350, 0)
    HideMinimap(true)
    HideGuide(true)
    Cam.Inst:Set(6.997, 0.938, 18.596, 8.012, 1.549, 28.525, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    hiroko.e010:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "510")
    hiroko.e008:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "520")
    hiroko.obj:ResetExporession(10)
    tlk:Message(base .. "550")
    koan.e018:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "560")
    tlk:MessageClose()
    Flg.Set(self.Flg003)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(60)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "570")
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "580")
    tlk:Message(base .. "590")
    hiroko.obj:ResetExporession(10)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(NPC, "S200_149_hiroko_01"):SetPos(1.262, 0, -3.662)
    Obj:new(NPC, "S200_149_hiroko_01"):SetRotationY(-40, 0)
    Obj:new(PLAYER, ""):SetPos(1.276, 0, -2.889)
    Obj:new(PLAYER, ""):SetRotationY(-40, 0)
    Cam.Inst:Set(-4.647, 3.887, -7.72, 2.97, 1.18, -1.8348, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    hiroko.e012:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "600")
    hiroko.e008:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "610")
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "620")
    hiroko.obj:ResetExporession(10)
    tlk:Message(base .. "630")
    hiroko.e010:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "640")
    hiroko.e008:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "650")
    hiroko.obj:ResetExporession(10)
    local result = tlk:Select(3, base .. "660")
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    if result == RESULT_TALK00 then
      WaitFrame(15)
      tlk:Message(base .. "670")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      hiroko.e012:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "680")
    else
      WaitFrame(15)
      hiroko.e012:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "690")
    end
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "700")
    hiroko.e004:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "710")
    hiroko.obj:ResetExporession(10)
    tlk:EndTalk()
    Flg.Set(self.Flg004)
    MapChange("e", 4, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function S200_149:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check(self.Flg004, self.Flg005) then
    local hiroko = {
      obj = Obj:new(NPC, "S200_149_hiroko_01"),
      e002 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e002"),
      e004 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e004"),
      e008 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e008"),
      e010 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e010"),
      e012 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e012"),
      e020 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e020"),
      e032 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e032"),
      e033 = Motion.Object:new(NPC, "S200_149_hiroko_01", "e033"),
      fn01_01 = Motion.Object:new(NPC, "S200_149_hiroko_01", "fn01_01")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Obj:new(PLAYER, ""):SetPos(0.281, 0, -1.892)
    Obj:new(PLAYER, ""):SetRotationY(-80, 0)
    Obj:new(NPC, "S200_149_hiroko_01"):SuspendAutoTransparentForCamera()
    Cam.Inst:Set(-4.893, -1.322, -0.532, 1.128, 2.099, -2.626, default, 0)
    HideMinimap(true)
    HideGuide(true)
    Field_PlayBGM(405)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    hiroko.e008:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "720")
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "730")
    hiroko.e010:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "750")
    hiroko.obj:ResetExporession(10)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:MessageClose()
    hiroko.fn01_01:PlayWithStartMoveMotion(0, 0)
    WaitFrame(45)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field_StopBGM()
    WaitFrame(15)
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "760")
    Field_PlayBGM(305)
    hiroko.e008:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "770")
    hiroko.obj:ResetExporession(10)
    local result = tlk:Select(3, base .. "780")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      hiroko.e032:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "790")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      hiroko.e033:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "800")
    else
      WaitFrame(15)
      hiroko.e020:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "810")
    end
    hiroko.e008:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "820")
    tlk:Message(base .. "830")
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "840")
    hiroko.obj:ResetExporession(10)
    result = tlk:Select(3, base .. "850")
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    if result == RESULT_TALK00 then
      WaitFrame(15)
      hiroko.e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "860")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      hiroko.e012:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "870")
    else
      WaitFrame(15)
      hiroko.e012:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "880")
    end
    hiroko.obj:ResetExporession(10)
    tlk:Message(base .. "890")
    tlk:Message(base .. "900")
    hiroko.e010:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "910")
    hiroko.obj:ResetExporession(10)
    tlk:Message(base .. "920")
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "930")
    hiroko.e012:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "940")
    hiroko.obj:ResetExporession(10)
    tlk:EndTalk()
    Flg.Set(self.Flg005)
    MapChange("t", 302, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function S200_149:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check(self.Flg005, self.Flg006) then
    local hiroko = {
      obj = Obj:new(NPC, "S200_149_hiroko_02"),
      e002 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e002"),
      e004 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e004"),
      e008 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e008"),
      e010 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e010"),
      e012 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e012"),
      e020 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e020"),
      e032 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e032"),
      e033 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e033"),
      fn01_01 = Motion.Object:new(NPC, "S200_149_hiroko_02", "fn01_01")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Field.ObjectInvisible(NPC, FOR_ALL, 0, 0, false)
    Field.ObjectInvisible(MOB, FOR_ALL, 0, 0, false)
    Obj:new(NPC, "S200_149_hiroko_02"):CancelInvisible()
    SetEnableGimmickCheck("map_0001", false)
    SetEnableGimmickCheck("map_0002", false)
    SetEnableGimmickCheck("map_0003", false)
    Obj:new(PLAYER, ""):SetPos(-7.274, 0, -6.799)
    Obj:new(PLAYER, ""):SetRotationY(-45, 0)
    Cam.Inst:Set(-10.287, 0, -14.9036, -7.082, 1.563, -5.5607, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    Common.ProhibitSave()
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    hiroko.e004:PlayWithStartMoveMotion(10, 10)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "950")
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "960")
    hiroko.e012:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "970")
    hiroko.obj:ResetExporession(10)
    Flg.Set(self.Flg006)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_015)
    Guest.Add(GST_HIROKO_AFTER)
    FieldObjectSync(FOR_ALL, false)
    Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    Cam.Inst:Clear(0)
    WaitFrame(30)
  end
end

function S200_149:Event_070(col)
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "980")
    if col == "evt_1000" then
      MovePlayerToRelativePosFrame(1, 0, 15)
    elseif col == "evt_1001" then
      MovePlayerToRelativePosFrame(-1, 0, 15)
    elseif col == "evt_1002" then
      MovePlayerToRelativePosFrame(0, -1, 15)
    end
    WaitFrame(15)
    tlk:EndTalk()
  end
end

function S200_149:Event_080()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local kyoko = {
      obj = Obj:new(NPC, "S200_149_kyoko_01"),
      e012 = Motion.Object:new(NPC, "S200_149_kyoko_01", "e012"),
      e013 = Motion.Object:new(NPC, "S200_149_kyoko_01", "e013"),
      blend01 = Motion.Object:new(NPC, "S200_149_kyoko_01", "blend01", true),
      fn01_01 = Motion.Object:new(NPC, "S200_149_kyoko_01", "fn01_01", true)
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Guest.Delete(GST_HIROKO_AFTER)
    tlk:Message(base .. "990")
    tlk:Message(base .. "1000")
    local result = tlk:Select(3, base .. "1010")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      tlk:Message(base .. "1020")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      tlk:Message(base .. "1030")
    else
      WaitFrame(15)
      tlk:Message(base .. "1040")
    end
    tlk:Message(base .. "1050")
    tlk:Message(base .. "1060")
    tlk:Message(base .. "1070")
    tlk:MessageClose()
    Flg.Set(self.Flg007)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(NPC, "S200_149_kyoko_01"):CancelInvisible()
    Obj:new(NPC, "S200_149_kyoko_01"):SuspendAutoTransparentForCamera()
    FieldObjectSync(NPC, true)
    WaitFrame(30)
    Obj:new(PLAYER, ""):Invisible()
    Cam.Inst:Set(-27.671, 2.036, -9.021, -34.792, 3.197, -9.573, default, 0)
    WaitFrame(30)
    Cam.Inst:Set(-27.525, 2.877, -9.14, -34.646, 4.038, -9.692, default, 60, ACCEL)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(75)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-37.614, 3.156, -14.295, -32.58, 3.985, -9.164, default, 0)
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectLoadMotion(NPC, GetIndex(NPC, "S200_149_kyoko_01"), "fn01_01")
    kyoko.e012:PlayWithStartMoveMotion(10, 10)
    kyoko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "1080")
    kyoko.e013:PlayWithStartMoveMotion(10, 10)
    kyoko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "1090")
    kyoko.e012:PlayWithStartMoveMotion(10, 10)
    kyoko.blend01:PlayMotionBlend(10, false)
    kyoko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "1100")
    kyoko.obj:ChangeExpression("F01", EYE_BLINK, false, 10)
    tlk:EndTalk()
    Flg.Set(self.Flg008)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChange("t", 101, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function S200_149:Event_090()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) and Flg.Check(self.Flg008) and not Qst.Sub:IsCompleted(self.ID) then
    local hiroko_index = GetIndex(NPC, "S200_149_hiroko_01")
    local hiroko = {
      obj = Obj:new(NPC, "S200_149_hiroko_02"),
      e002 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e002"),
      e004 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e004"),
      e008 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e008"),
      e010 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e010"),
      e012 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e012"),
      e020 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e020"),
      e032 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e032"),
      e033 = Motion.Object:new(NPC, "S200_149_hiroko_02", "e033"),
      fn01_01 = Motion.Object:new(NPC, "S200_149_hiroko_02", "fn01_01")
    }
    local player = {
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Obj:new(PLAYER, ""):SetPos(1.817, 0.68, 1.2954)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    player.fn01_01:Play(15, true)
    WaitFrame(30)
    Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
    Cam.Inst:Set(3.2458, 0.8037, -7.375, 2.144, 2.1902, 2.466, default, 0)
    HideMinimap(true)
    HideGuide(true)
    hiroko.fn01_01:Play(0, true)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, hiroko_index, 0)
    Field.ObjectLookAtTheObject(NPC, hiroko_index, PLAYER, 1, 0)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    hiroko.e008:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "1110")
    hiroko.obj:ChangeExpression("F02", EYE_CLOSE, true, 10)
    hiroko.e004:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "1120")
    hiroko.obj:ChangeExpression("F01", EYE_BLINK, true, 10)
    hiroko.e010:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "1130")
    hiroko.obj:ChangeExpression("F02", EYE_CLOSE, true, 10)
    hiroko.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "1140")
    Qst.Sub:End(self.ID, self.STEP_255)
    Flg.Clear("FLAG_SUB_200_149_010")
    Field.ClearMobTransparentFrontOfCamera(0)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    FieldObjectSync(NPC, true)
    Cam.Inst:Clear(0)
    HideMinimap(false)
    HideGuide(false)
    Common.CancelProhibitSave()
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S200_149:IsCostumeChange()
  local player_model_name = Common.GetPlayerModelName()
  print(player_model_name)
  return player_model_name == "pc001ka010101" or player_model_name == "pc002ka010101"
end
