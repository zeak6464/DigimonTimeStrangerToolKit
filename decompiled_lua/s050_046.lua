S050_046 = {
  ID = 46,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_050_046_001",
  Flg02 = "FLAG_SUB_050_046_002"
}
local text_file = "s050_046"
local base = "s050_046_"

function S050_046:Event_010()
  if Qst.Main:IsCompleted(M360.ID) and not Qst.Sub:IsCompleted(self.ID) and not Qst.Sub:Check(self.ID, self.STEP_005) then
    if not Flg.Check(self.Flg01) then
      Flg.Set(self.Flg01)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "010")
      tlk:Message(base .. "020")
      tlk:Message(base .. "030")
      local result = tlk:Select(3, base .. "040")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "050")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "060")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "070")
      end
      tlk:Message(base .. "080")
      tlk:Message(base .. "090")
      result = tlk:Select(3, base .. "100")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "110")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "120")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "130")
      end
      tlk:Message(base .. "140")
      tlk:Message(base .. "150")
      result = tlk:Select(3, base .. "160")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "170")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "180")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "190")
        tlk:EndTalk()
        goto lbl_325
      end
      tlk:Message(base .. "240")
      tlk:Message(base .. "250")
      result = tlk:Select(3, base .. "260")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "270")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "280")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "290")
      end
      Flg.Set(self.Flg02)
      tlk:Message(base .. "300")
      tlk:Message(base .. "310")
      tlk:Message(base .. "320")
      tlk:Message(base .. "330")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003)
    else
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "200")
      local result = tlk:Select(2, base .. "210")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "220")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "230")
        tlk:EndTalk()
        goto lbl_325
      end
      Flg.Set(self.Flg02)
      tlk:Message(base .. "300")
      tlk:Message(base .. "310")
      tlk:Message(base .. "320")
      tlk:Message(base .. "330")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003)
    end
  end
  ::lbl_325::
end

function S050_046:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005) and Qst.Sub:Check(self.ID, self.STEP_010) and Qst.Sub:Check(self.ID, self.STEP_015) and Qst.Sub:Check(self.ID, self.STEP_020) and not Qst.Sub:Check(self.ID, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "340")
    tlk:Message(base .. "350")
    tlk:Message(base .. "360")
    local result = tlk:Select(3, base .. "370")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "380")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "390")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "400")
    end
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
    tlk:Message(base .. "430")
    tlk:Message(base .. "440")
    tlk:Message(base .. "450")
    tlk:Message(base .. "460")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
  elseif Flg.Check(self.Flg02) then
    local tlk = Tlk:new(text_file)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "310")
    tlk:Message(base .. "320")
    tlk:EndTalk()
  end
end
