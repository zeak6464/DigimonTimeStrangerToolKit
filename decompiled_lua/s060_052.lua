S060_052 = {
  ID = 52,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_060_052_001",
  Flg02 = "FLAG_SUB_060_052_002",
  Flg03 = "FLAG_SUB_060_052_003",
  Flg04 = "FLAG_SUB_060_052_004",
  Flg05 = "FLAG_SUB_060_052_005",
  Flg06 = "FLAG_SUB_060_052_006",
  Flg07 = "FLAG_SUB_060_052_007",
  Flg08 = "FLAG_SUB_060_052_008",
  Flg09 = "FLAG_SUB_060_052_009",
  Flg10 = "FLAG_SUB_060_052_010",
  Flg11 = "FLAG_SUB_060_052_011",
  Flg12 = "FLAG_SUB_060_052_012",
  Flg13 = "FLAG_SUB_060_052_013",
  Flg14 = "FLAG_SUB_060_052_014"
}
local text_file = "s060_052"
local base = "s060_052_"

function S060_052:Event_010()
  if Qst.Main:IsCompleted(M360.ID) and not Qst.Sub:IsCompleted(self.ID) then
    if not Flg.Check(self.Flg10) then
      if not Flg.Check(self.Flg06) then
        Flg.Set(self.Flg10)
        local tlk = Tlk:new(text_file, 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message(base .. "010")
        tlk:Message(base .. "020")
        local result = tlk:Select(3, base .. "030")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "040")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "050")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "060")
        end
        tlk:Message(base .. "070")
        tlk:Message(base .. "080")
        tlk:Message(base .. "090")
        result = tlk:Select(3, base .. "100")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "110")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "120")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "130")
          tlk:EndTalk()
          goto lbl_397
        end
        tlk:Message(base .. "175")
        tlk:Message(base .. "180")
        tlk:Message(base .. "190")
        Flg.Set(self.Flg05)
        Qst.Sub:Set(self.ID, self.STEP_005)
        result = tlk:Select(2, base .. "200")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "210")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "220")
          tlk:EndTalk()
          goto lbl_397
        end
        tlk:Message(base .. "270")
        tlk:Message(base .. "280")
        tlk:EndTalk()
        Flg.Set(self.Flg06)
        EncountFromField_PlaySound(20600520, 10771, false)
      end
    elseif not Flg.Check(self.Flg05) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "140")
      local result = tlk:Select(2, base .. "150")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "160")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "170")
        tlk:EndTalk()
        goto lbl_397
      end
      Flg.Set(self.Flg05)
      Qst.Sub:Set(self.ID, self.STEP_005)
      tlk:Message(base .. "175")
      tlk:Message(base .. "180")
      tlk:Message(base .. "190")
      result = tlk:Select(2, base .. "200")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "210")
        Flg.Set(self.Flg06)
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "220")
        tlk:EndTalk()
        goto lbl_397
      end
      tlk:Message(base .. "270")
      tlk:Message(base .. "280")
      tlk:EndTalk()
      Flg.Set(self.Flg06)
      EncountFromField_PlaySound(20600520, 10771, false)
    elseif Flg.Check(self.Flg05, self.Flg06) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "230")
      local result = tlk:Select(2, base .. "240")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "250")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "260")
        tlk:EndTalk()
        goto lbl_397
      end
      tlk:Message(base .. "270")
      tlk:Message(base .. "280")
      tlk:EndTalk()
      Flg.Set(self.Flg06)
      EncountFromField_PlaySound(20600520, 10771, false)
    end
  end
  ::lbl_397::
end

function S060_052:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Field.IsUsingStoredField() and (Flg.Check(self.Flg06, self.Flg01) or Flg.Check(self.Flg07, self.Flg02) or Flg.Check(self.Flg08, self.Flg03) or Flg.Check(self.Flg09, self.Flg04)) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "290")
    tlk:EndTalk()
  end
end

function S060_052:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and (Flg.Check(self.Flg06, self.Flg01) or Flg.Check(self.Flg07, self.Flg02) or Flg.Check(self.Flg08, self.Flg03) or Flg.Check(self.Flg09, self.Flg04)) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "300")
    local result = tlk:Select(2, base .. "310")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "320")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "330")
      tlk:EndTalk()
      goto lbl_130
    end
    tlk:EndTalk()
    if Flg.Check(self.Flg06, self.Flg01) then
      EncountFromField_PlaySound(20600520, 10771, false)
    elseif Flg.Check(self.Flg07, self.Flg02) then
      EncountFromField_PlaySound(20600521, 10771, false)
    elseif Flg.Check(self.Flg08, self.Flg03) then
      EncountFromField_PlaySound(20600522, 10771, false)
    elseif Flg.Check(self.Flg09, self.Flg04) then
      EncountFromField_PlaySound(20600523, 10771, false)
    end
  end
  ::lbl_130::
end

function S060_052:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and (Flg.Check(self.Flg11, self.Flg07) or Flg.Check(self.Flg12, self.Flg08) or Flg.Check(self.Flg13, self.Flg09)) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "300")
    local result = tlk:Select(2, base .. "310")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "320")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "330")
      tlk:EndTalk()
      goto lbl_122
    end
    tlk:EndTalk()
    if Flg.Check(self.Flg11, self.Flg07) then
      Flg.Set(self.Flg07)
      EncountFromField_PlaySound(20600521, 10771, false)
    elseif Flg.Check(self.Flg12, self.Flg08) then
      Flg.Set(self.Flg08)
      EncountFromField_PlaySound(20600522, 10771, false)
    elseif Flg.Check(self.Flg13, self.Flg09) then
      Flg.Set(self.Flg09)
      EncountFromField_PlaySound(20600523, 10771, false)
    end
  end
  ::lbl_122::
end

function S060_052:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check(self.Flg01, self.Flg02) then
    Flg.Set(self.Flg11)
    Qst.Sub:Set(self.ID, self.STEP_010)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "340")
    tlk:Message(base .. "350")
    tlk:Message(base .. "360")
    local result = tlk:Select(2, base .. "370")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "380")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "390")
      tlk:EndTalk()
      goto lbl_97
    end
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:EndTalk()
    EncountFromField_PlaySound(20600521, 10771, false)
  end
  ::lbl_97::
end

function S060_052:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check(self.Flg02, self.Flg03) then
    Flg.Set(self.Flg12)
    Qst.Sub:Set(self.ID, self.STEP_015)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "400")
    tlk:Message(base .. "410")
    local result = tlk:Select(2, base .. "420")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "430")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "440")
      tlk:EndTalk()
      goto lbl_92
    end
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:EndTalk()
    EncountFromField_PlaySound(20600522, 10771, false)
  end
  ::lbl_92::
end

function S060_052:Event_070()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check(self.Flg03, self.Flg04) then
    Qst.Sub:Set(self.ID, self.STEP_020)
    Flg.Set(self.Flg13)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "450")
    tlk:Message(base .. "460")
    tlk:Message(base .. "470")
    local result = tlk:Select(2, base .. "480")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "490")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "500")
      tlk:EndTalk()
      goto lbl_97
    end
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:EndTalk()
    EncountFromField_PlaySound(20600523, 10771, false)
  end
  ::lbl_97::
end

function S060_052:Event_080()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) and Flg.Check(self.Flg04) then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "510")
    tlk:Message(base .. "520")
    tlk:Message(base .. "530")
    local result = tlk:Select(3, base .. "540")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "550")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "560")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "570")
    end
    tlk:Message(base .. "580")
    tlk:Message(base .. "590")
    tlk:Message(base .. "600")
    tlk:MessageClose()
    INFO_GET_ITEM(776, 1)
    result = tlk:Select(3, base .. "610")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "620")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "630")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "640")
    end
    tlk:Message(base .. "650")
    tlk:Message(base .. "660")
    tlk:Message(base .. "670")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end
