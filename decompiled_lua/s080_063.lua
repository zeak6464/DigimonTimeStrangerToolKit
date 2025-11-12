S080_063 = {
  ID = 63,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255
}
local base = "s080_063_"
local text_file = "s080_063"
local tlk = Tlk:new(text_file, 1, true)

function S080_063:Event_000()
  Qst.Sub:Start(self.ID, self.STEP_001, true)
end

function S080_063:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_010) then
    tlk:StartTalkAndCancelDigimonRide()
    if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
      tlk:Message(base .. "010")
      local result = tlk:Select(3, base .. "020")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "030")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "040")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "050")
      end
    end
    tlk:Message(base .. "060")
    local result = tlk:Select(3, base .. "070")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "080")
      Qst.Sub:Set(self.ID, self.STEP_005)
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "090")
      Qst.Sub:Set(self.ID, self.STEP_005)
      tlk:EndTalk()
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "100")
      Qst.Sub:Set(self.ID, self.STEP_005)
      tlk:EndTalk()
    else
      tlk:Message(base .. "110")
      local result = tlk:Select(3, base .. "120")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "130")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "140")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "150")
      end
      tlk:Message(base .. "160")
      tlk:Message(base .. "170")
      Qst.Sub:Set(self.ID, self.STEP_010)
      Flg.Set("FLAG_SUB_080_063_002")
      tlk:EndTalk()
    end
  end
end

function S080_063:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "180")
    local result = tlk:Select(2, base .. "190")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "200")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "210")
      tlk:EndTalk()
    else
      tlk:EndTalk()
    end
  end
end

function S080_063:Event_030()
  if not Flg.Check("FLAG_IS_CLEAR_S080_063") then
    tlk:StartTalkAndCancelDigimonRide()
    if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_010) then
      tlk:Message(base .. "250")
      tlk:Message(base .. "260")
      tlk:EndTalk()
    elseif Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
      tlk:Message(base .. "270")
      tlk:Message(base .. "280")
      tlk:Message(base .. "290")
      local result = tlk:Select(3, base .. "300")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "310")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "320")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "330")
      end
    end
    tlk:Message(base .. "340")
    tlk:Message(base .. "350")
    local result = tlk:Select(2, base .. "360")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "370")
      Qst.Sub:Set(self.ID, self.STEP_015)
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "380")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_015)
    else
      tlk:Message(base .. "390")
      local result = tlk:Select(3, base .. "400")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "410")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "420")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "430")
      end
      tlk:Message(base .. "440")
      Qst.Sub:End(self.ID, self.STEP_255)
      tlk:EndTalk()
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "470")
    local result = tlk:Select(2, base .. "480")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "490")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "500")
      tlk:EndTalk()
    else
      tlk:Message(base .. "510")
      tlk:EndTalk()
    end
  end
end
