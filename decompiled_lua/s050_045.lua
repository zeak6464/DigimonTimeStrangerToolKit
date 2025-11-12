S050_045 = {
  ID = 45,
  STEP_001 = 1,
  STEP_255 = 255
}
local base = "s050_045_"
local text_file = "s050_045"

function S050_045:Event_010()
  if not Qst.Sub:Check(self.ID, self.STEP_001) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0010")
    tlk:Message(base .. "0020")
    tlk:Message(base .. "0030")
    local result = tlk:Select(1, base .. "0040")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "0050")
    end
    tlk:Message(base .. "0060")
    tlk:Message(base .. "0070")
    tlk:Message(base .. "0080")
    tlk:EndTalk()
    Qst.Sub:Start(self.ID, self.STEP_001, true)
  end
end

function S050_045:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_255) and not Flg.Check("FLAG_SUB_S050_045_001") then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0090")
    tlk:Message(base .. "0100")
    tlk:Message(base .. "0110")
    local result = tlk:Select(3, base .. "0120")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "0130")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "0140")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "0150")
    end
    tlk:Message(base .. "0160")
    tlk:Message(base .. "0170")
    tlk:Message(base .. "0180")
    tlk:Message(base .. "0190")
    result = tlk:Select(3, base .. "0200")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "0210")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "0220")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "0230")
    end
    tlk:Message(base .. "0240")
    tlk:Message(base .. "0250")
    tlk:EndTalk()
    EncountFromField_PlaySound(20500450, 10274, false)
  end
end

function S050_045:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_255) and Flg.Check("FLAG_SUB_S050_045_001") then
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0260")
    tlk:Message(base .. "0270")
    tlk:Message(base .. "0280")
    tlk:Message(base .. "0290")
    tlk:Message(base .. "0300")
    tlk:Message(base .. "0310")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end
