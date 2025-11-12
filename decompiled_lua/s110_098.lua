S110_098 = {
  ID = 98,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_110_098_001",
  Flg02 = "FLAG_SUB_110_098_002",
  Flg03 = "FLAG_SUB_110_098_003",
  Flg04 = "FLAG_SUB_110_098_004"
}
local text_file = "s110_098"
local base = text_file .. "_"

function S110_098:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local alphamon = {
      fe04 = Motion.Object:new(NPC, "s110_098_001", "fe04"),
      fq01 = Motion.Object:new(NPC, "s110_098_001", "fq01"),
      fq02 = Motion.Object:new(NPC, "s110_098_001", "fq02"),
      bn01 = Motion.Object:new(NPC, "s110_098_001", "bn01"),
      e009 = Motion.Object:new(NPC, "s110_098_001", "e009"),
      e010 = Motion.Object:new(NPC, "s110_098_001", "e010")
    }
    local agumon = {
      fe02 = Motion.Object:new(NPC, "agumon_knight_01", "fe02"),
      fe04 = Motion.Object:new(NPC, "agumon_knight_01", "fe04"),
      fq01 = Motion.Object:new(NPC, "agumon_knight_01", "fq01"),
      fq02 = Motion.Object:new(NPC, "agumon_knight_01", "fq02"),
      e002 = Motion.Object:new(NPC, "agumon_knight_01", "e002"),
      bn01 = Motion.Object:new(NPC, "agumon_knight_01", "bn01")
    }
    local gabumon = {
      fe04 = Motion.Object:new(NPC, "gabumon_knight_01", "fe04"),
      fq01 = Motion.Object:new(NPC, "gabumon_knight_01", "fq01"),
      fq02 = Motion.Object:new(NPC, "gabumon_knight_01", "fq02"),
      e002 = Motion.Object:new(NPC, "gabumon_knight_01", "e002"),
      bn01 = Motion.Object:new(NPC, "gabumon_knight_01", "bn01")
    }
    local omegamon = {
      fq01 = Motion.Object:new(NPC, "s110_098_004", "fq01"),
      fe02 = Motion.Object:new(NPC, "s110_098_004", "fe02"),
      bn01 = Motion.Object:new(NPC, "s110_098_004", "bn01")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e018 = Motion.Object:new(PLAYER, "", "e018"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    if not Flg.Check(self.Flg01) then
      local tlk = Tlk:new(text_file, 1, true)
      Flg.Set(self.Flg01)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      tlk:StartTalkAndCancelDigimonRide()
      HideMinimap(true)
      HideGuide(true)
      WaitFrame(15)
      Cam.Inst:Set(-0.155, 34.34, 32.99, 0.011, 33.266, 42.936, default, 0)
      Obj:new(PLAYER, ""):SetPos(-0.144, 31.541, 30.61, true)
      Obj:new(PLAYER, ""):SetRotationY(0, 0)
      WaitFrame(5)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      agumon.fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "010")
      gabumon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "020")
      tlk:Message(base .. "030")
      gabumon.fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "040")
      tlk:MessageClose()
      PlaySE(404005, 100)
      Fade_OutNoLoadingWithWait(FADE_WHITE, 30)
      gabumon.bn01:PlayWithStartMoveMotion(10, 10)
      FieldObjectSync(NPC, true)
      WaitFrame(5)
      Cam.Inst:Set(0.09, 33.74, 25.13, -0.031, 32.0698, 34.992, default, 0)
      Obj:new(NPC, "agumon_knight_01"):SetRotationYToObject(NPC, "s110_098_001", 0)
      Obj:new(NPC, "gabumon_knight_01"):SetRotationYToObject(NPC, "s110_098_001", 0)
      WaitFrame(30)
      FadeAllInWithWait(FADE_WHITE, FADE_TIME)
      Field_PlayBGM(322)
      agumon.fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "050")
      local result = tlk:Select(3, base .. "060")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        agumon.fq01:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "070")
      elseif result == RESULT_TALK01 then
        agumon.fq01:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "080")
      elseif result == RESULT_TALK02 then
        alphamon.fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "090")
        agumon.fq01:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "100")
      end
      gabumon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "110")
      alphamon.fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "120")
      agumon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "130")
      result = tlk:Select(3, base .. "140")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        alphamon.e010:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "150")
      elseif result == RESULT_TALK01 then
        alphamon.e010:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "160")
      elseif result == RESULT_TALK02 then
        alphamon.e010:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "170")
        tlk:EndTalk()
        Cam.Inst:Clear(30)
        Qst.Sub:Set(self.ID, self.STEP_005)
        WaitFrame(30)
        HideMinimap(false)
        HideGuide(false)
        goto lbl_1419
      end
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "180")
      alphamon.e009:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "190")
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "200")
      gabumon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "210")
      alphamon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "220")
      result = tlk:Select(3, base .. "230")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        agumon.fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "240")
      elseif result == RESULT_TALK01 then
        alphamon.fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "250")
      elseif result == RESULT_TALK02 then
        gabumon.fq01:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "260")
      end
      agumon.e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "270")
      gabumon.e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "280")
      agumon.fe04:PlayWithStartMoveMotion(10, 10)
      gabumon.fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "290")
      tlk:MessageClose()
      PlaySE(404032, 100)
      Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
      Flg.Set(self.Flg03)
      Cam.Inst:Set(-0.39, 33.69, 26.943, 4.65, 33.83, 35.576, default, 0)
      FieldObjectSync(NPC, false)
      WaitFrame(90)
      FadeAllInWithWait(FADE_WHITE, FADE_TIME)
      omegamon.fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "300")
      alphamon.fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "310")
      tlk:EndTalk(true)
      player.e018:Play(10, true)
      WaitFrame(30)
      Qst.Sub:Start(self.ID, 1, false)
      Guest.Add(GST_S010_156_OMEGA)
      Qst.Sub:Set(self.ID, self.STEP_005)
      Qst.Sub:Set(self.ID, self.STEP_006)
      EncountFromField_PlaySound(21100980, 10276, false)
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_006) then
    local alphamon = {
      fe04 = Motion.Object:new(NPC, "s110_098_001", "fe04"),
      fq01 = Motion.Object:new(NPC, "s110_098_001", "fq01"),
      fq02 = Motion.Object:new(NPC, "s110_098_001", "fq02"),
      bn01 = Motion.Object:new(NPC, "s110_098_001", "bn01"),
      e009 = Motion.Object:new(NPC, "s110_098_001", "e009"),
      e010 = Motion.Object:new(NPC, "s110_098_001", "e010")
    }
    local agumon = {
      e002 = Motion.Object:new(NPC, "agumon_knight_01", "e002"),
      fe02 = Motion.Object:new(NPC, "agumon_knight_01", "fe02"),
      fe04 = Motion.Object:new(NPC, "agumon_knight_01", "fe04"),
      fq01 = Motion.Object:new(NPC, "agumon_knight_01", "fq01"),
      fq02 = Motion.Object:new(NPC, "agumon_knight_01", "fq02"),
      bn01 = Motion.Object:new(NPC, "agumon_knight_01", "bn01")
    }
    local gabumon = {
      e002 = Motion.Object:new(NPC, "gabumon_knight_01", "e002"),
      fe02 = Motion.Object:new(NPC, "gabumon_knight_01", "fe02"),
      fe04 = Motion.Object:new(NPC, "gabumon_knight_01", "fe04"),
      fq01 = Motion.Object:new(NPC, "gabumon_knight_01", "fq01"),
      fq02 = Motion.Object:new(NPC, "gabumon_knight_01", "fq02"),
      bn01 = Motion.Object:new(NPC, "gabumon_knight_01", "bn01")
    }
    local omegamon = {
      fq01 = Motion.Object:new(NPC, "s110_098_004", "fq01"),
      fe02 = Motion.Object:new(NPC, "s110_098_004", "fe02"),
      bn01 = Motion.Object:new(NPC, "s110_098_004", "bn01")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e018 = Motion.Object:new(PLAYER, "", "e018"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    local tlk = Tlk:new(text_file, 1, true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    WaitFrame(15)
    Cam.Inst:Set(0.09, 33.74, 25.13, -0.031, 32.0698, 34.992, default, 0)
    Obj:new(PLAYER, ""):SetPos(-0.144, 31.541, 30.61, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    Obj:new(NPC, "agumon_knight_01"):SetRotationYToObject(NPC, "s110_098_001", 0)
    Obj:new(NPC, "gabumon_knight_01"):SetRotationYToObject(NPC, "s110_098_001", 0)
    WaitFrame(5)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field_PlayBGM(322)
    gabumon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "110")
    alphamon.fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "120")
    agumon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "130")
    local result = tlk:Select(3, base .. "140")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "150")
    elseif result == RESULT_TALK01 then
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "160")
    elseif result == RESULT_TALK02 then
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "170")
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      WaitFrame(30)
      HideMinimap(false)
      HideGuide(false)
      goto lbl_1419
    end
    alphamon.e010:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "180")
    alphamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "190")
    alphamon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "200")
    gabumon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "210")
    alphamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "220")
    result = tlk:Select(3, base .. "230")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      agumon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "240")
    elseif result == RESULT_TALK01 then
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "250")
    elseif result == RESULT_TALK02 then
      gabumon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "260")
    end
    agumon.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "270")
    gabumon.e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "280")
    agumon.fe04:PlayWithStartMoveMotion(10, 10)
    gabumon.fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "290")
    tlk:MessageClose()
    PlaySE(404032, 100)
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    Flg.Set(self.Flg03)
    Cam.Inst:Set(-0.39, 33.69, 26.943, 4.65, 33.83, 35.576, default, 0)
    FieldObjectSync(NPC, true)
    WaitFrame(90)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    omegamon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "300")
    alphamon.fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "310")
    tlk:EndTalk(true)
    player.e018:Play(10, true)
    WaitFrame(30)
    Qst.Sub:Start(self.ID, 1, false)
    Qst.Sub:Set(self.ID, self.STEP_006)
    Guest.Add(GST_S010_156_OMEGA)
    EncountFromField_PlaySound(21100980, 10276, false)
  end
  ::lbl_1419::
end

function S110_098:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg02) then
    local alphamon = {
      fe04 = Motion.Object:new(NPC, "s110_098_001", "fe04"),
      fq01 = Motion.Object:new(NPC, "s110_098_001", "fq01"),
      fq02 = Motion.Object:new(NPC, "s110_098_001", "fq02"),
      bn01 = Motion.Object:new(NPC, "s110_098_001", "bn01"),
      e009 = Motion.Object:new(NPC, "s110_098_001", "e009"),
      e010 = Motion.Object:new(NPC, "s110_098_001", "e010")
    }
    local agumon = {
      fe02 = Motion.Object:new(NPC, "agumon_knight_01", "fe02"),
      fe04 = Motion.Object:new(NPC, "agumon_knight_01", "fe04"),
      fq01 = Motion.Object:new(NPC, "agumon_knight_01", "fq01"),
      fq02 = Motion.Object:new(NPC, "agumon_knight_01", "fq02"),
      bn01 = Motion.Object:new(NPC, "agumon_knight_01", "bn01")
    }
    local gabumon = {
      fe04 = Motion.Object:new(NPC, "gabumon_knight_01", "fe04"),
      fq01 = Motion.Object:new(NPC, "gabumon_knight_01", "fq01"),
      fq02 = Motion.Object:new(NPC, "gabumon_knight_01", "fq02"),
      bn01 = Motion.Object:new(NPC, "gabumon_knight_01", "bn01")
    }
    local omegamon = {
      fq01 = Motion.Object:new(NPC, "s110_098_004", "fq01"),
      fe02 = Motion.Object:new(NPC, "s110_098_004", "fe02"),
      bn01 = Motion.Object:new(NPC, "s110_098_004", "bn01")
    }
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    local tlk = Tlk:new(text_file, 1, true)
    Guest.Delete(GST_S010_156_OMEGA)
    Cam.Inst:Set(-0.39, 33.69, 26.943, 4.65, 33.83, 35.576, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    player.fn01_01:Play(10, true)
    Obj:new(PLAYER, ""):SetPos(-0.144, 31.541, 30.61, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    alphamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "320")
    gabumon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "330")
    alphamon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "340")
    alphamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "350")
    local result = tlk:Select(3, base .. "360")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "370")
    elseif result == RESULT_TALK01 then
      alphamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "380")
    elseif result == RESULT_TALK02 then
      alphamon.e009:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "390")
    end
    alphamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "400")
    omegamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "410")
    alphamon.e009:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "420")
    PlaySE(404005, 100)
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    Flg.Set(self.Flg04)
    Cam.Inst:Set(0.09, 33.74, 25.13, -0.031, 32.0698, 34.992, default, 0)
    Obj:new(NPC, "agumon_knight_01"):SetRotationYToObject(PLAYER, "", 0)
    Obj:new(NPC, "gabumon_knight_01"):SetRotationYToObject(PLAYER, "", 0)
    Obj:new(PLAYER, ""):SetPos(-0.144, 31.541, 30.61, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    FieldObjectSync(NPC, true)
    WaitFrame(30)
    Field.ObjectClearIcon(NPC, GetIndex(NPC, "agumon_knight_01"))
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    agumon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "430")
    gabumon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "440")
    agumon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "450")
    agumon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "460")
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Cam.Inst:Clear(30)
    WaitFrame(30)
    require("S100_087")
    Flg.Set(S100_087.Flgs.Flg13)
    S100_087:Event_020()
  end
end

function S110_098:Event_030()
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkActionAndZoom("s110_098_001")
  tlk:Message(base .. "470")
  tlk:Message(base .. "480")
  tlk:Message(base .. "490")
  tlk:EndTalkActionAndZoom()
end
