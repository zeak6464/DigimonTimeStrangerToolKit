S020_173 = {
  ID = 173,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_020_173_001",
  Flg02 = "FLAG_SUB_020_173_002",
  Flg03 = "FLAG_SUB_020_173_003",
  Flg04 = "FLAG_SUB_020_173_004",
  Flg05 = "FLAG_SUB_020_173_005",
  Flg06 = "FLAG_SUB_020_173_006",
  Flg07 = "FLAG_SUB_020_173_007",
  Flg10 = "FLAG_SUB_020_173_010",
  Flg11 = "FLAG_SUB_020_173_011",
  Flg12 = "FLAG_SUB_020_173_012",
  Flg13 = "FLAG_SUB_020_173_013",
  Flg14 = "FLAG_SUB_020_173_014",
  Flg15 = "FLAG_SUB_020_173_015",
  Flg16 = "FLAG_SUB_020_173_016"
}
local text_file = "s020_173"
local base = text_file .. "_"
local tlk = Tlk:new(text_file, 1, true)

function S020_173:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local marine = Obj:new(NPC, "s020_173_001")
    local marine_index01 = GetIndex(NPC, "s020_173_001")
    local fq01 = Motion.Object:new(NPC, "s020_173_001", "fq01")
    local fq02 = Motion.Object:new(NPC, "s020_173_001", "fq02")
    local fe02 = Motion.Object:new(NPC, "s020_173_001", "fe02")
    local fe04 = Motion.Object:new(NPC, "s020_173_001", "fe04")
    local bn01 = Motion.Object:new(NPC, "s020_173_001", "bn01")
    local e002 = Motion.Object:new(PLAYER, "", "e002")
    local e004 = Motion.Object:new(PLAYER, "", "e004")
    local e008 = Motion.Object:new(PLAYER, "", "e008")
    local e012 = Motion.Object:new(PLAYER, "", "e012")
    local e023 = Motion.Object:new(PLAYER, "", "e023")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    Field.ObjectLookAtTheObject(NPC, marine_index01, PLAYER, 1, 30)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, marine_index01, 30)
    tlk:StartTalkActionAndZoom("s020_173_001")
    HideMinimap(true)
    HideGuide(true)
    WaitFrame(30)
    fq02:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "010")
    fe04:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "020")
    fq02:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
    tlk:Message(base .. "030")
    marine:ChangeExpression("F01", EYE_BLINK, false, 10)
    local result = tlk:Select(3, base .. "040")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      fe04:PlayWithStartMoveMotion(10, 10)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      fe04:PlayWithStartMoveMotion(10, 10)
      marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      tlk:Message(base .. "060")
    else
      WaitFrame(15)
      fe04:PlayWithStartMoveMotion(10, 10)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "070")
    end
    fq02:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
    tlk:Message(base .. "080")
    marine:ChangeExpression("F02", EYE_BLINK, false, 10)
    fq01:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "090")
    marine:ChangeExpression("F02", EYE_BLINK, false, 10)
    result = tlk:Select(3, base .. "100")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      fq01:PlayWithStartMoveMotion(10, 10)
      marine:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "110")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "120")
    else
      WaitFrame(15)
      marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "130")
    end
    marine:ChangeExpression("F01", EYE_BLINK, false, 10)
    fe04:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F03", EYE_BLINK, true, 10)
    tlk:Message(base .. "140")
    marine:ChangeExpression("F03", EYE_BLINK, false, 10)
    tlk:MessageClose()
    INFO_GET_ITEM(759, 1)
    fq01:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "150")
    marine:ChangeExpression("F01", EYE_BLINK, false, 10)
    tlk:EndTalkActionAndZoom()
    Qst.Sub:Start(self.ID, 1, false)
    Flg.Set(self.Flg01)
    Qst.Sub:Set(self.ID, self.STEP_005)
    HideMinimap(false)
    HideGuide(false)
  end
end

function S020_173:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local marine = Obj:new(NPC, "s020_173_001")
    local fq01 = Motion.Object:new(NPC, "s020_173_001", "fq01")
    local fq02 = Motion.Object:new(NPC, "s020_173_001", "fq02")
    local fe02 = Motion.Object:new(NPC, "s020_173_001", "fe02")
    local fe04 = Motion.Object:new(NPC, "s020_173_001", "fe04")
    local bn01 = Motion.Object:new(NPC, "s020_173_001", "bn01")
    if not self:IsHaveOceanWater() then
      tlk:StartTalkActionAndZoom("s020_173_001")
      marine:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "540")
      marine:ChangeExpression("F01", EYE_BLINK, false, 10)
      tlk:EndTalkActionAndZoom()
    end
  end
end

function S020_173:Event_015(gim_name)
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
    local fg07_d03 = Motion.Object:new(PLAYER, "", "fg07_d03")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    tlk:StartTalkAndCancelDigimonRide()
    if self:IsHaveOceanWater() then
      tlk:Message(base .. "530")
      local result = tlk:Select(2, base .. "531")
      if result == RESULT_TALK00 then
        fg07_d03:Play2Wait(10, false)
        fn01_01:Play(10, true)
        tlk:Message(base .. "520")
        Flg.Set(self.Flg06)
        Qst.Sub:Set(self.ID, self.STEP_010)
        Flg.Clear(self.Flg05)
        Flg.Clear(self.Flg10)
        Flg.Clear(S020_173.Flg11)
        Flg.Clear(S020_173.Flg12)
        Flg.Clear(S020_173.Flg13)
        Flg.Clear(S020_173.Flg14)
        Flg.Clear(S020_173.Flg15)
        Flg.Clear(S020_173.Flg16)
        if gim_name == "s020_173_002" then
          Flg.Set(S020_173.Flg11)
        end
        if gim_name == "s020_173_003" then
          Flg.Set(S020_173.Flg12)
        end
        if gim_name == "s020_173_004" then
          Flg.Set(S020_173.Flg13)
        end
        if gim_name == "s020_173_005" then
          Flg.Set(S020_173.Flg14)
        end
        if gim_name == "s020_173_006" then
          Flg.Set(S020_173.Flg15)
        end
        if gim_name == "s020_173_007" then
          Flg.Set(S020_173.Flg16)
        end
        FieldObjectSync(FLD_OBJ_GIMMICK, true)
        WaitFrame(Util.SecondFromFrame(5))
      elseif result == RESULT_TALK01 then
        tlk:EndTalk()
        goto lbl_249
      end
    else
      fg07_d03:Play2Wait(10, false)
      fn01_01:Play(10, true)
      tlk:Message(base .. "520")
      Flg.Set(self.Flg06)
      Qst.Sub:Set(self.ID, self.STEP_010)
      if gim_name == "s020_173_002" then
        Flg.Set(S020_173.Flg11)
      end
      if gim_name == "s020_173_003" then
        Flg.Set(S020_173.Flg12)
      end
      if gim_name == "s020_173_004" then
        Flg.Set(S020_173.Flg13)
      end
      if gim_name == "s020_173_005" then
        Flg.Set(S020_173.Flg14)
      end
      if gim_name == "s020_173_006" then
        Flg.Set(S020_173.Flg15)
      end
      if gim_name == "s020_173_007" then
        Flg.Set(S020_173.Flg16)
      end
      FieldObjectSync(FLD_OBJ_GIMMICK, true)
      WaitFrame(Util.SecondFromFrame(5))
    end
    tlk:EndTalk()
  end
  ::lbl_249::
end

function S020_173:Event_018()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
    local fg07_d03 = Motion.Object:new(PLAYER, "", "fg07_d03")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    tlk:StartTalkAndCancelDigimonRide()
    if self:IsHaveOceanWater() then
      tlk:Message(base .. "530")
      local result = tlk:Select(2, base .. "531")
      if result == RESULT_TALK00 then
        fg07_d03:Play2Wait(10, false)
        fn01_01:Play(10, true)
        tlk:Message(base .. "510")
        Flg.Clear(self.Flg06)
        Flg.Set(self.Flg05)
        Qst.Sub:Set(self.ID, self.STEP_010)
        Flg.Clear(S020_173.Flg11)
        Flg.Clear(S020_173.Flg12)
        Flg.Clear(S020_173.Flg13)
        Flg.Clear(S020_173.Flg14)
        Flg.Clear(S020_173.Flg15)
        Flg.Clear(S020_173.Flg16)
        FieldObjectSync(FLD_OBJ_GIMMICK, true)
        WaitFrame(Util.SecondFromFrame(5))
      else
        tlk:EndTalk()
        goto lbl_158
      end
    else
      fg07_d03:Play2Wait(10, false)
      fn01_01:Play(10, true)
      tlk:Message(base .. "510")
      Flg.Set(self.Flg05)
      Qst.Sub:Set(self.ID, self.STEP_010)
      FieldObjectSync(FLD_OBJ_GIMMICK, true)
      WaitFrame(Util.SecondFromFrame(5))
    end
    tlk:EndTalk()
  end
  ::lbl_158::
end

function S020_173:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and self:IsHaveOceanWater() then
    local marine = Obj:new(NPC, "s020_173_001")
    local marine_index01 = GetIndex(NPC, "s020_173_001")
    local fq01 = Motion.Object:new(NPC, "s020_173_001", "fq01")
    local fq02 = Motion.Object:new(NPC, "s020_173_001", "fq02")
    local fe02 = Motion.Object:new(NPC, "s020_173_001", "fe02")
    local fe04 = Motion.Object:new(NPC, "s020_173_001", "fe04")
    local bn01 = Motion.Object:new(NPC, "s020_173_001", "bn01")
    local e002 = Motion.Object:new(PLAYER, "", "e002")
    local e004 = Motion.Object:new(PLAYER, "", "e004")
    local e008 = Motion.Object:new(PLAYER, "", "e008")
    local e012 = Motion.Object:new(PLAYER, "", "e012")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    Field.ObjectLookAtTheObject(NPC, marine_index01, PLAYER, 1, 30)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, marine_index01, 30)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkActionAndZoom("s020_173_001")
    WaitFrame(30)
    fq02:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
    tlk:Message(base .. "160")
    fq01:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "170")
    if Flg.Check(self.Flg05) then
      Flg.Clear(self.Flg05)
      Item.Add(759, -1)
      marine:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "180")
      marine:ChangeExpression("F02", EYE_BLINK, false, 10)
      tlk:MessageClose()
      BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      bn01:PlayWithStartMoveMotion(10, 10)
      WaitFrame(60)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      fe04:PlayWithStartMoveMotion(10, 10)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "190")
      tlk:Message(base .. "200")
      local result = tlk:Select(3, base .. "210")
      if result == RESULT_TALK00 then
        WaitFrame(15)
        fe04:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "220")
      elseif result == RESULT_TALK01 then
        WaitFrame(15)
        fe04:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "230")
      else
        WaitFrame(15)
        fe04:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "240")
      end
      marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
      fq02:PlayWithStartMoveMotion(10, 10)
      marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
      tlk:Message(base .. "250")
      tlk:Message(base .. "260")
      marine:ChangeExpression("F01", EYE_BLINK, false, 10)
      tlk:EndTalkActionAndZoom()
      Flg.Set(self.Flg10)
      Flg.Set(self.Flg11)
      Flg.Set(self.Flg12)
      Flg.Set(self.Flg13)
      Flg.Set(self.Flg14)
      Flg.Set(self.Flg15)
      Flg.Set(self.Flg16)
      Flg.Set(self.Flg03)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, true)
      HideMinimap(false)
      HideGuide(false)
      Cam.Inst:Clear(0)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Qst.Sub:Set(self.ID, self.STEP_015)
    elseif Flg.Check(self.Flg06) then
      Flg.Set(self.Flg07)
      marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "185")
      marine:ChangeExpression("F01", EYE_BLINK, false, 10)
      tlk:MessageClose()
      BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      bn01:PlayWithStartMoveMotion(10, 10)
      WaitFrame(60)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      fe04:PlayWithStartMoveMotion(10, 10)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      tlk:Message(base .. "195")
      tlk:Message(base .. "205")
      tlk:Message(base .. "208")
      marine:ChangeExpression("F01", EYE_BLINK, false, 10)
      tlk:EndTalkActionAndZoom()
      Cam.Inst:Clear(30)
      Flg.Clear(self.Flg06)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Retreat(self.ID, 20, true)
    end
  end
end

function S020_173:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) then
    local marine = Obj:new(NPC, "s020_173_001")
    local fq01 = Motion.Object:new(NPC, "s020_173_001", "fq01")
    local fq02 = Motion.Object:new(NPC, "s020_173_001", "fq02")
    local fe02 = Motion.Object:new(NPC, "s020_173_001", "fe02")
    local fe04 = Motion.Object:new(NPC, "s020_173_001", "fe04")
    local bn01 = Motion.Object:new(NPC, "s020_173_001", "bn01")
    local e002 = Motion.Object:new(PLAYER, "", "e002")
    local e004 = Motion.Object:new(PLAYER, "", "e004")
    local e008 = Motion.Object:new(PLAYER, "", "e008")
    local e012 = Motion.Object:new(PLAYER, "", "e012")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-14.7135, 2.6, 82.681, -21.15, 3.71, 75.11, default, 0)
    fn01_01:Play(10, true)
    Obj:new(PLAYER, ""):SetPos(-20.34, 2, 76.57, true)
    Obj:new(PLAYER, ""):SetRotationY(120, 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "270")
    local result = tlk:Select(3, base .. "280")
    marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
    if result == RESULT_TALK00 then
      WaitFrame(15)
      Obj:new(NPC, "s020_173_001"):SetRotationYToObject(PLAYER, "", 20)
      WaitFrame(20)
      fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "290")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      Obj:new(NPC, "s020_173_001"):SetRotationYToObject(PLAYER, "", 20)
      WaitFrame(20)
      fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "300")
    else
      WaitFrame(15)
      Obj:new(NPC, "s020_173_001"):SetRotationYToObject(PLAYER, "", 20)
      WaitFrame(20)
      fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "310")
    end
    marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
    fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "320")
    tlk:Message(base .. "330")
    marine:ChangeExpression("F01", EYE_CLOSE, false, 10)
    result = tlk:Select(3, base .. "340")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "350")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "360")
    else
      WaitFrame(15)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "370")
    end
    bn01:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
    tlk:Message(base .. "380")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "390")
    fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "400")
    marine:ChangeExpression("F01", EYE_BLINK, false, 10)
    result = tlk:Select(3, base .. "410")
    if result == RESULT_TALK00 then
      WaitFrame(15)
      marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "420")
    elseif result == RESULT_TALK01 then
      WaitFrame(15)
      marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
      fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "430")
    else
      WaitFrame(15)
      marine:ChangeExpression("F03_T01", EYE_BLINK, true, 10)
      fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "440")
    end
    fq01:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_CLOSE, true, 10)
    tlk:Message(base .. "450")
    fq02:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "460")
    fq01:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "470")
    marine:ChangeExpression("F01", EYE_BLINK, false, 10)
    tlk:EndTalkZoom()
    Flg.Set(self.Flg04)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    HideMinimap(false)
    HideGuide(false)
    WaitFrame(30)
    Cam.Inst:Clear(0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_020)
  end
end

function S020_173:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    local marine = Obj:new(NPC, "s020_173_001")
    local fq01 = Motion.Object:new(NPC, "s020_173_001", "fq01")
    local fq02 = Motion.Object:new(NPC, "s020_173_001", "fq02")
    local fe02 = Motion.Object:new(NPC, "s020_173_001", "fe02")
    local fe04 = Motion.Object:new(NPC, "s020_173_001", "fe04")
    local bn01 = Motion.Object:new(NPC, "s020_173_001", "bn01")
    local br01 = Motion.Object:new(NPC, "s020_173_001", "br01")
    tlk:StartTalk()
    fq01:PlayWithStartMoveMotion(10, 10)
    marine:ChangeExpression("F02_T01", EYE_BLINK, true, 10)
    tlk:Message(base .. "480")
    tlk:Message(base .. "490")
    fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "500")
    marine:ChangeExpression("F02", EYE_BLINK, false, 10)
    tlk:EndTalk()
    local obj = Obj:new(NPC, "s020_173_001")
    Field.ObjectOverwriteCheckableRange(NPC, obj.index, 0, 0, 0)
    Field.ObjectResetMotion(NPC, GetIndex(NPC, "s020_173_001"), 30)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S020_173:IsHaveOceanWater()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
    return Flg.Check(self.Flg05) or Flg.Check(self.Flg06)
  end
end

function S020_173:SaveWaterPoint()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
    return
  end
end
