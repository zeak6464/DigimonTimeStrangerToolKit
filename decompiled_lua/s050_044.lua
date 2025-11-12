S050_044 = {
  ID = 44,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255
}
local base = "s050_044_"
local text_file = "s050_044"

function S050_044:Event_010()
  if not Qst.Sub:Check(self.ID, self.STEP_001) and Flg.Check("FLAG_S044_002") then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0080")
    tlk:MessageClose()
    local result = tlk:Select(2, base .. "0040")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "0050")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "0060")
    else
      tlk:Message(base .. "0070")
      Qst.Sub:Start(self.ID, self.STEP_001, true)
    end
    tlk:EndTalk()
  end
  if not Qst.Sub:Check(self.ID, self.STEP_001) and not Flg.Check("FLAG_S044_002") then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0010")
    tlk:Message(base .. "0020")
    tlk:Message(base .. "0030")
    tlk:MessageClose()
    local result = tlk:Select(2, base .. "0040")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "0050")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "0060")
      Flg.Set("FLAG_S044_002")
    else
      tlk:Message(base .. "0070")
      Qst.Sub:Start(self.ID, self.STEP_001, true)
    end
    tlk:EndTalk()
  end
end

function S050_044:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0090")
    tlk:Message(base .. "0100")
    tlk:Message(base .. "0110")
    tlk:Message(base .. "0120")
    tlk:EndTalk()
    Item.Delete(203, 10)
    Qst.Sub:End(self.ID, self.STEP_255)
    if Flg.Check("QUEST_M160_CLEAR") then
      require("s050_045")
      Qst.Sub:QuickStart(S050_045.ID)
    end
  end
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "0070")
    tlk:EndTalk()
  end
end
