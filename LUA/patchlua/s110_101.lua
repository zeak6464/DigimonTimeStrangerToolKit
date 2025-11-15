S110_101 = {
  ID = 101,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_110_101_001",
  Flg02 = "FLAG_SUB_110_101_002",
  Flg03 = "FLAG_SUB_110_101_003",
  Flg04 = "FLAG_SUB_110_101_004",
  Flg05 = "FLAG_SUB_110_101_005",
  Flg06 = "FLAG_SUB_110_101_006"
}
local text_file = "s110_101"
local base = "s110_101_"

function S110_101:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    if Guest.IsExistNum(3) then
      INFO_WINDOW(10050)
      return
    end
    local magnamon = {
      bn01 = Motion.Object:new(NPC, "s110_101_002", "bn01"),
      fq01 = Motion.Object:new(NPC, "s110_101_002", "fq01"),
      fq02 = Motion.Object:new(NPC, "s110_101_002", "fq02"),
      fe02 = Motion.Object:new(NPC, "s110_101_002", "fe02"),
      fe04 = Motion.Object:new(NPC, "s110_101_002", "fe04"),
      fe03 = Motion.Object:new(NPC, "s110_101_002", "fe03")
    }
    local gardromon = {
      bn01 = Motion.Object:new(NPC, "s095_077_mirai", "bn01"),
      fq01 = Motion.Object:new(NPC, "s095_077_mirai", "fq01"),
      fq02 = Motion.Object:new(NPC, "s095_077_mirai", "fq02"),
      fe02 = Motion.Object:new(NPC, "s095_077_mirai", "fe02"),
      fe04 = Motion.Object:new(NPC, "s095_077_mirai", "fe04"),
      fe03 = Motion.Object:new(NPC, "s095_077_mirai", "fe03")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Field.ObjectLoadMotionBlend(PLAYER, 1, "blend01")
    if not Flg.Check(self.Flg01) then
      Flg.Set(self.Flg01)
      local magnamon_index = GetIndex(NPC, "s110_101_002")
      local gardromon_index = GetIndex(NPC, "s095_077_mirai")
      HideMinimap(true)
      HideGuide(true)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(-110.485, -8.56, 77.5985, -100.851, -11.244, 77.57, default, 0)
      Obj:new(PLAYER, ""):SetPos(-102.471, -12.313, 76.982, true)
      Obj:new(PLAYER, ""):SetRotationY(270, 0)
      WaitFrame(10)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, magnamon_index, 15, 10)
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
      tlk:Message(base .. "010")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe03", 10, 10)
      tlk:Message(base .. "020")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe02", 10, 10)
      tlk:Message(base .. "030")
      local result = tlk:Select(3, base .. "040")
      WaitFrame(30)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe04", 10, 10)
        tlk:Message(base .. "050")
        tlk:Message(base .. "060")
      elseif result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe04", 10, 10)
        tlk:Message(base .. "070")
        tlk:Message(base .. "080")
      elseif result == RESULT_TALK02 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe04", 10, 10)
        tlk:Message(base .. "090")
        tlk:Message(base .. "100")
      end
      tlk:MessageClose()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
      tlk:Message(base .. "110")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq02", 10, 10)
      tlk:Message(base .. "120")
      tlk:MessageClose()
      Cam.Inst:Set(-107.02, -10.813, 75.788, -97.527, -8.919, 78.296, default, 30)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, gardromon_index, 15, 10)
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gardromon_index, "fe04", 10, 10)
      tlk:Message(base .. "460")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gardromon_index, "fq01", 10, 10)
      tlk:Message(base .. "470")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gardromon_index, "fq02", 10, 10)
      tlk:Message(base .. "480")
      tlk:MessageClose()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
      tlk:Message(base .. "490")
      tlk:Message(base .. "500")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gardromon_index, "fq01", 10, 10)
      tlk:Message(base .. "510")
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, magnamon_index, 15, 10)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
      tlk:Message(base .. "520")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe04", 10, 10)
      tlk:Message(base .. "530")
      result = tlk:Select(3, base .. "540")
      WaitFrame(30)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
        tlk:Message(base .. "550")
      elseif result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
        tlk:Message(base .. "560")
      else
        tlk:Message(base .. "570")
      end
      tlk:Message(base .. "580")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe02", 10, 10)
      tlk:Message(base .. "590")
      tlk:MessageClose()
      Talk.CloseLetterBox()
      Qst.Sub:Start(self.ID, 1, false)
      Talk.OpenLetterBox()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Obj:new(NPC, "s110_101_002"):Invisible()
      Cam.Inst:Set(-109.87, -12.91, 74.352, -100.442, -10.58, 76.74, default, 0)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, gardromon_index, 15, 10)
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gardromon_index, "fq01", 10, 10)
      tlk:Message(base .. "600")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gardromon_index, "fe04", 10, 10)
      tlk:Message(base .. "610")
      tlk:MessageClose()
      HideMinimap(false)
      HideGuide(false)
      Flg.Set(self.Flg06)
      Qst.Sub:Set(self.ID, self.STEP_005)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(30)
      PlaySE(201005, 100)
      WaitFrame(60)
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      tlk:EndTalk(true)
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      MapChange("d", 503, "start_22", false, FADE_BLACK, FADE_TIME)
    end
  end
end

function S110_101:Event_045()
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkActionAndZoom("s110_101_003")
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) then
    tlk:Message(base .. "420")
    tlk:Select(1, base .. "432")
  elseif Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    tlk:Message(base .. "600")
    tlk:Message(base .. "610")
  end
  tlk:EndTalkActionAndZoom()
end

function S110_101:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check(self.Flg03) then
    local tlk = Tlk:new(text_file, 1, true)
    Cam.Inst:Set(18.58, 1.95, 52.594, 28.5, 2.426, 53.78, default, 0)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    local magnamon_index = GetIndex(NPC, "s110_101_magnamon_01")
    local breakdoramon_index = GetIndex(NPC, "s110_101_breakdoramon_01")
    local obj_index = GetIndex(OGIM, "s110_101_obj")
    Field.ObjectLoadMotion(NPC, magnamon_index, "bn01")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fq01")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fq02")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fe02")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fe03")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fe04")
    Field.ObjectLoadMotion(NPC, breakdoramon_index, "bn01")
    Field.ObjectLoadMotion(NPC, breakdoramon_index, "ba01")
    Field.ObjectLoadMotion(NPC, breakdoramon_index, "fe01")
    Field.ObjectLoadMotion(NPC, breakdoramon_index, "fe02")
    Field.ObjectLoadMotion(NPC, breakdoramon_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectLoadMotion(PLAYER, 1, "bn01")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotionBlend(PLAYER, 1, "blend01")
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, magnamon_index, 15, 10)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe02", 10, 10)
    tlk:Message(base .. "620")
    Field.ObjectLookAtTheObject(NPC, magnamon_index, OGIM, obj_index, 15, 10)
    tlk:Message(base .. "630")
    tlk:MessageClose()
    Field.ObjectLookAtTheObject(PLAYER, 1, OGIM, obj_index, 30, 30)
    WaitFrame(45)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, magnamon_index, 30, 30)
    WaitFrame(60)
    Field.ObjectResetAim(NPC, magnamon_index, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe03", 10, 10)
    tlk:Message(base .. "640")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectResetAim(NPC, magnamon_index, 0)
    PlaySE(202001, 100)
    WaitFrame(60)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
    tlk:Message(base .. "650")
    tlk:MessageClose()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq02", 10, 10)
    WaitFrame(30)
    tlk:Message(base .. "660")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe02", 10, 10)
    tlk:Message(base .. "670")
    tlk:MessageClose()
    Flg.Set("FLAG_SUB_110_101_007")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field_StopBGM()
    FieldObjectSync(NPC, false)
    Cam.Inst:Set(23.2525, 2.9465, 53.51, 14.486, 0.7458, 49.231, default, 0)
    Obj:new(PLAYER, ""):SetRotationY(90, 0)
    Obj:new(NPC, "s110_101_magnamon_01"):SetRotationY(90, 0)
    Field.ObjectPlayMotion(PLAYER, 1, "bn01", 10, true)
    PlaySE(202007, 100)
    WaitFrame(45)
    PlaySE(202007, 100)
    WaitFrame(45)
    PlaySE(202007, 100)
    WaitFrame(45)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field_PlayBGM(309)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, breakdoramon_index, 15, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe04", 10, 10)
    tlk:Message(base .. "680")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
    tlk:Message(base .. "690")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe02", 10, 10)
    tlk:Message(base .. "700")
    Field.ObjectPlayMotion(NPC, breakdoramon_index, "fe04", 10, true)
    tlk:Message(base .. "710")
    Field.ObjectPlayMotion(NPC, breakdoramon_index, "bn01", 10, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq02", 10, 10)
    tlk:Message(base .. "720")
    local result = tlk:Select(3, base .. "730")
    Field.ObjectPlayMotionBlend(PLAYER, 1, "blend01", 10, false)
    WaitFrame(30)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq02", 10, 10)
      tlk:Message(base .. "740")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq01", 10, 10)
      tlk:Message(base .. "750")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fq02", 10, 10)
      tlk:Message(base .. "760")
    end
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, magnamon_index, 15, 10)
    WaitFrame(15)
    Field.ObjectLookAtTheObject(NPC, magnamon_index, PLAYER, 1, 15, 10)
    tlk:Message(base .. "770")
    Field.ObjectResetAim(NPC, magnamon_index, 5)
    tlk:Message(base .. "780")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe02", 10, 10)
    tlk:Message(base .. "790")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectResetAim(PLAYER, 1, 0)
    Cam.Inst:Set(24.96, 3.14, 52.44, 15.87, 0.51136, 49.22, default, 0)
    Obj:new(NPC, "s110_101_magnamon_01"):Invisible()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe04", 10, 10)
    tlk:Message(base .. "800")
    result = tlk:Select(3, base .. "810")
    WaitFrame(30)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe01", 10, 10)
      tlk:Message(base .. "820")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe01", 10, 10)
      tlk:Message(base .. "830")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe01", 10, 10)
      tlk:Message(base .. "840")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe04", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bn01", 10, 10)
    tlk:Message(base .. "850")
    tlk:MessageClose()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, breakdoramon_index, "fe02", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
    WaitFrame(30)
    tlk:EndTalk(true)
    EncountFromField_WithNormalEffect(21101010, 10572, false)
  end
end

function S110_101:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg03) then
    Obj:new(NPC, "s110_101_magnamon_01"):CancelInvisible()
    Digimon.RestoreAllParty()
    local magnamon_index = GetIndex(NPC, "s110_101_magnamon_01")
    local breakdoramon_index = GetIndex(NPC, "s110_101_breakdoramon_01")
    Field.ObjectLoadMotion(NPC, magnamon_index, "bn01")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fq01")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fq02")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fe02")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fe03")
    Field.ObjectLoadMotion(NPC, magnamon_index, "fe04")
    Field.ObjectLoadMotion(NPC, breakdoramon_index, "bn01")
    Field.ObjectLoadMotion(NPC, breakdoramon_index, "bn02")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectLoadMotion(PLAYER, 1, "bn01")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotionBlend(PLAYER, 1, "blend01")
    Field.ObjectPlayMotion(NPC, breakdoramon_index, "bn02", 10, true)
    Field.ObjectPlayMotion(PLAYER, 1, "bn01", 10, true)
    HideMinimap(true)
    HideGuide(true)
    Cam.Inst:Set(23.2525, 2.9465, 53.51, 14.486, 0.7458, 49.231, default, 0)
    WaitFrame(30)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(30)
    FadeInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "880")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, false)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    Obj:new(NPC, "s110_101_magnamon_01"):SetRotationY(0, 0)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 10, true)
    PlaySE(202007, 100)
    WaitFrame(45)
    PlaySE(202007, 100)
    WaitFrame(45)
    PlaySE(202007, 100)
    WaitFrame(45)
    Cam.Inst:Set(25.43, 2.645, 56.43, 17.57, 1.172, 50.433, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, magnamon_index, 15, 10)
    Field.ObjectLookAtTheObject(NPC, magnamon_index, PLAYER, 1, 15, 10)
    WaitFrame(30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe03", 10, 10)
    tlk:Message(base .. "890")
    Field.ObjectPlayMotion(NPC, magnamon_index, "fq01", 10, true)
    tlk:Message(base .. "900")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe02", 10, 10)
    tlk:Message(base .. "910")
    Field.ObjectPlayMotion(NPC, magnamon_index, "fq01", 10, true)
    tlk:Message(base .. "920")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, magnamon_index, "fe02", 10, 10)
    tlk:Message(base .. "930")
    tlk:EndTalk(true)
    Flg.Set("FLAG_IS_CLEAR_S110_101")
    Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
    MapChange("d", 501, "start_09", true, FADE_BLACK, FADE_TIME)
  end
end

function S110_101:Event_070()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_IS_CLEAR_S110_101") then
    HideMinimap(false)
    HideGuide(false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:End(self.ID, self.STEP_255)
    require("S100_087")
    Flg.Set(S100_087.Flgs.Flg03)
    S100_087.AddReturnRoyalKnightsNum()
    S100_087:Event_020()
  end
end
