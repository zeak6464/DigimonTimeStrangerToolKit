S020_015 = {
  ID = 15,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_020_015_001",
  Flg02 = "FLAG_SUB_020_015_002",
  Flg03 = "FLAG_SUB_020_015_003",
  Flg04 = "FLAG_SUB_020_015_004",
  Flg05 = "FLAG_SUB_020_015_005"
}
local text_file = "s020_015"
local base = "s020_015_"

function S020_015:Event_010()
  if Qst.Sub:IsCompleted(13) and not Qst.Sub:IsCompleted(self.ID) and not Flg.Check(self.Flg01) then
    Flg.Set(self.Flg01)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    tlk:Message(base .. "030")
    tlk:Message(base .. "040")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S020_015:Event_020()
  if Qst.Sub:IsCompleted(13) and not Qst.Sub:IsCompleted(self.ID) then
    if Flg.Check(self.Flg01, self.Flg02) then
      Flg.Set(self.Flg02)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "050")
      local result = tlk:Select(3, base .. "060")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "070")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "080")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "090")
      end
      tlk:Message(base .. "100")
      tlk:Message(base .. "110")
      tlk:Message(base .. "120")
      result = tlk:Select(3, base .. "130")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "140")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "150")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "160")
      end
      tlk:Message(base .. "170")
      tlk:Message(base .. "180")
      tlk:Message(base .. "190")
      result = tlk:Select(3, base .. "200")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "210")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "220")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "230")
        tlk:EndTalk()
        goto lbl_274
      end
      Flg.Set(self.Flg05)
      tlk:Message(base .. "280")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_005)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, true)
      WaitFrame(25)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    else
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "240")
      local result = tlk:Select(2, base .. "250")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "260")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "270")
        tlk:EndTalk()
        goto lbl_274
      end
      Flg.Set(self.Flg05)
      tlk:Message(base .. "280")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_005)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, true)
      WaitFrame(25)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    end
  end
  ::lbl_274::
end

function S020_015:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check(self.Flg03) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "290")
    tlk:Message(base .. "300")
    tlk:EndTalk()
    Flg.Set(self.Flg03)
    EncountFromField_PlaySound(20200150, 10373, false)
  end
end

function S020_015:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check(self.Flg03, self.Flg04) then
    FieldObjectSync(NPC, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set(self.Flg04)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "330")
    tlk:Message(base .. "340")
    tlk:Message(base .. "350")
    tlk:Message(base .. "360")
    tlk:Message(base .. "370")
    tlk:Message(base .. "380")
    tlk:Message(base .. "390")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_TIME, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S020_015:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "400")
    local _ = tlk:Select(2, base .. "410")
    tlk:Message(base .. "420")
    tlk:Message(base .. "430")
    tlk:Message(base .. "440")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_TIME, FADE_TIME)
  end
end
