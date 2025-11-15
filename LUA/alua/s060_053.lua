S060_053 = {
  ID = 53,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_060_053_001",
  Flg02 = "FLAG_SUB_060_053_002",
  Flg03 = "FLAG_SUB_060_053_003",
  Flg04 = "FLAG_SUB_060_053_004",
  Flg05 = "FLAG_SUB_060_053_005",
  Flg06 = "FLAG_SUB_060_053_006",
  Flg07 = "FLAG_SUB_060_053_007",
  Flg08 = "FLAG_SUB_060_053_008",
  Flg09 = "FLAG_SUB_060_053_009",
  Flg10 = "FLAG_SUB_060_053_010",
  Flg11 = "FLAG_SUB_060_053_011",
  Flg12 = "FLAG_SUB_060_053_012"
}
local text_file = "s060_053"
local base = "s060_053_"

function S060_053:Event_010()
  if Qst.Main:IsCompleted(M360.ID) and Qst.Sub:IsCompleted(52) and not Qst.Sub:IsCompleted(self.ID) and not Flg.Check(self.Flg01) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    if result == RESULT_TALK00 then
      Flg.Set(self.Flg01)
      tlk:Message(base .. "030")
      tlk:Message(base .. "040")
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "055")
      tlk:Message(base .. "060")
      tlk:Message(base .. "070")
      tlk:EndTalk()
      goto lbl_137
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "080")
      tlk:EndTalk()
      goto lbl_137
    end
    tlk:Message(base .. "090")
    tlk:Message(base .. "100")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_005)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
  ::lbl_137::
end

function S060_053:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    if not Flg.Check(self.Flg02) and not Flg.Check(self.Flg03) then
      Flg.Set(self.Flg02)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "850")
      local result = tlk:Select(3, base .. "860")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "870")
        Flg.Set(self.Flg03)
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "880")
        Flg.Set(self.Flg03)
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "890")
        tlk:EndTalk()
        goto lbl_172
      end
      tlk:Message(base .. "940")
      tlk:Message(base .. "950")
      tlk:EndTalk()
      EncountFromField_PlaySound(20600530, 10771, false)
    elseif Flg.Check(self.Flg02) and not Flg.Check(self.Flg03) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "900")
      local result = tlk:Select(2, base .. "910")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "920")
        Flg.Set(self.Flg03)
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "930")
        tlk:EndTalk()
        goto lbl_172
      end
      tlk:Message(base .. "940")
      tlk:Message(base .. "950")
      tlk:EndTalk()
      EncountFromField_PlaySound(20600530, 10771, false)
    end
  end
  ::lbl_172::
end

function S060_053:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    FieldObjectSync(NPC, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "960")
    tlk:Message(base .. "970")
    tlk:EndTalk()
  end
end

function S060_053:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    if Flg.Check(self.Flg03, self.Flg04) or Flg.Check(self.Flg05, self.Flg06) or Flg.Check(self.Flg07, self.Flg08) or Flg.Check(self.Flg09, self.Flg10) or Flg.Check(self.Flg11, self.Flg12) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "980")
      local result = tlk:Select(2, base .. "990")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "1010")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "1020")
        tlk:EndTalk()
        goto lbl_323
      end
      tlk:Message(base .. "940")
      tlk:Message(base .. "950")
      if Flg.Check(self.Flg03, self.Flg04) then
        EncountFromField_PlaySound(20600530, 10771, false)
      elseif Flg.Check(self.Flg05, self.Flg06) then
        Flg.Set(self.Flg05)
        EncountFromField_PlaySound(20600531, 10771, false)
      elseif Flg.Check(self.Flg07, self.Flg08) then
        Flg.Set(self.Flg07)
        EncountFromField_PlaySound(20600532, 10771, false)
      elseif Flg.Check(self.Flg09, self.Flg10) then
        Flg.Set(self.Flg09)
        EncountFromField_PlaySound(20600533, 10771, false)
      elseif Flg.Check(self.Flg11, self.Flg12) then
        Flg.Set(self.Flg11)
        EncountFromField_PlaySound(20600534, 10771, false)
      end
      tlk:EndTalk()
    elseif Flg.Check(self.Flg04, self.Flg05) or Flg.Check(self.Flg06, self.Flg07) or Flg.Check(self.Flg08, self.Flg09) or Flg.Check(self.Flg10, self.Flg11) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "980")
      local result = tlk:Select(2, base .. "990")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "1010")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "1020")
        tlk:EndTalk()
        goto lbl_323
      end
      tlk:Message(base .. "940")
      tlk:Message(base .. "950")
      if Flg.Check(self.Flg04, self.Flg05) then
        Flg.Set(self.Flg05)
        EncountFromField_PlaySound(20600531, 10771, false)
      elseif Flg.Check(self.Flg06, self.Flg07) then
        Flg.Set(self.Flg07)
        EncountFromField_PlaySound(20600532, 10771, false)
      elseif Flg.Check(self.Flg08, self.Flg09) then
        Flg.Set(self.Flg09)
        EncountFromField_PlaySound(20600533, 10771, false)
      elseif Flg.Check(self.Flg10, self.Flg11) then
        Flg.Set(self.Flg11)
        EncountFromField_PlaySound(20600534, 10771, false)
      end
      tlk:EndTalk()
    end
  end
  ::lbl_323::
end

function S060_053:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check(self.Flg04) then
    FieldObjectSync(NPC, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_010)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "1030")
    local result = tlk:Select(2, base .. "1040")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "1050")
      Flg.Set(self.Flg05)
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "1060")
      tlk:EndTalk()
      goto lbl_90
    end
    tlk:Message(base .. "940")
    tlk:Message(base .. "950")
    tlk:EndTalk()
    EncountFromField_PlaySound(20600531, 10771, false)
  end
  ::lbl_90::
end

function S060_053:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check(self.Flg06) then
    FieldObjectSync(NPC, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_015)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "1070")
    local result = tlk:Select(2, base .. "1040")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "1090")
      Flg.Set(self.Flg07)
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "1100")
      tlk:EndTalk()
      goto lbl_90
    end
    tlk:Message(base .. "940")
    tlk:Message(base .. "950")
    tlk:EndTalk()
    EncountFromField_PlaySound(20600532, 10771, false)
  end
  ::lbl_90::
end

function S060_053:Event_070()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check(self.Flg08) then
    FieldObjectSync(NPC, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_020)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "1110")
    local result = tlk:Select(2, base .. "1120")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "1130")
      Flg.Set(self.Flg09)
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "1140")
      tlk:EndTalk()
      goto lbl_90
    end
    tlk:Message(base .. "940")
    tlk:Message(base .. "950")
    tlk:EndTalk()
    EncountFromField_PlaySound(20600533, 10771, false)
  end
  ::lbl_90::
end

function S060_053:Event_080()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check(self.Flg10) then
    FieldObjectSync(NPC, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_025)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "1150")
    tlk:Message(base .. "1160")
    tlk:Message(base .. "1170")
    local result = tlk:Select(2, base .. "1180")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "1190")
      Flg.Set(self.Flg11)
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "1200")
      tlk:EndTalk()
      goto lbl_102
    end
    tlk:Message(base .. "940")
    tlk:Message(base .. "950")
    tlk:EndTalk()
    tlk:EndTalk()
    EncountFromField_PlaySound(20600534, 10771, false)
  end
  ::lbl_102::
end

function S060_053:Event_090()
  if Qst.Sub:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check(self.Flg12) then
    FieldObjectSync(NPC, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "1210")
    tlk:Message(base .. "1220")
    local result = tlk:Select(3, base .. "1230")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "1240")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "1250")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "1260")
    end
    tlk:Message(base .. "1270")
    tlk:Message(base .. "1280")
    tlk:Message(base .. "1290")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end
