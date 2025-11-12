S020_016 = {
  ID = 16,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_020_016_001",
  Flg02 = "FLAG_SUB_020_016_002",
  Flg03 = "FLAG_SUB_020_016_003",
  Flg04 = "FLAG_SUB_020_016_004",
  Flg05 = "FLAG_SUB_020_016_005"
}
local text_file = "s020_016"
local base = "s020_016_"

function S020_016:Event_010()
  if Qst.Sub:IsAllCompleted({14, 15}) and Flg.Check("FLAG_SUB_060_053_001") and not Qst.Sub:IsCompleted(self.ID) and Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set(self.Flg01)
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
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_005)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S020_016:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check(self.Flg02) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "080")
    tlk:Message(base .. "090")
    tlk:Message(base .. "100")
    tlk:Message(base .. "110")
    tlk:Message(base .. "120")
    local result = tlk:Select(3, base .. "130")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "140")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "150")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "160")
    end
    tlk:Message(base .. "170")
    tlk:EndTalk()
    Flg.Set(self.Flg02)
    EncountFromField_PlaySound(20200160, 10771, false)
  end
end

function S020_016:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check(self.Flg02) then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "190")
    tlk:Message(base .. "200")
    tlk:Message(base .. "210")
    local result = tlk:Select(3, base .. "220")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "230")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "240")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "250")
    end
    tlk:Message(base .. "260")
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:Message(base .. "290")
    tlk:Message(base .. "300")
    result = tlk:Select(3, base .. "310")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "320")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "330")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "340")
    end
    tlk:Message(base .. "350")
    tlk:Message(base .. "360")
    tlk:Message(base .. "370")
    tlk:Message(base .. "380")
    tlk:Message(base .. "390")
    tlk:Message(base .. "400")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_010)
    Flg.Set(self.Flg03)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S020_016:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check(self.Flg04) then
    text_file = "s060_053"
    base = "s060_053_"
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "620")
    tlk:Message(base .. "630")
    tlk:Message(base .. "640")
    tlk:Message(base .. "650")
    tlk:Message(base .. "660")
    tlk:Message(base .. "670")
    tlk:Message(base .. "680")
    tlk:Message(base .. "690")
    tlk:Message(base .. "700")
    tlk:EndTalk()
    Flg.Set(self.Flg04)
    EncountFromField_PlaySound(20600531, 10771, false)
  end
end

function S020_016:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check(self.Flg04) then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "760")
    tlk:Message(base .. "770")
    tlk:Message(base .. "780")
    tlk:Message(base .. "790")
    tlk:Message(base .. "800")
    tlk:Message(base .. "810")
    tlk:Message(base .. "820")
    tlk:Message(base .. "830")
    tlk:Message(base .. "840")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_015)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S020_016:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
    tlk:Message(base .. "430")
    tlk:Message(base .. "440")
    tlk:Message(base .. "450")
    tlk:Message(base .. "460")
    tlk:Message(base .. "470")
    tlk:EndTalk()
    Flg.Set(self.Flg05)
    Qst.Sub:End(self.ID, self.STEP_255)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end
