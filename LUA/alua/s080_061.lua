S080_061 = {
  ID = 61,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255
}
local base = "s080_061_"
local text_file = "s080_061"
local tlk = Tlk:new(text_file, 1, true)

function S080_061:Event_000()
  Qst.Sub:Start(self.ID, self.STEP_001, true)
end

function S080_061:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "030")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "040")
      tlk:EndTalk()
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "050")
      tlk:EndTalk()
    else
      tlk:Message(base .. "060")
      tlk:Message(base .. "070")
      local result = tlk:Select(2, base .. "080")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "090")
        Qst.Sub:Set(self.ID, self.STEP_005)
        Qst.Sub:Set(self.ID, self.STEP_010)
        tlk:EndTalk()
      else
        if result == RESULT_TALK01 then
          tlk:Message(base .. "100")
          Qst.Sub:Set(self.ID, self.STEP_005)
          tlk:EndTalk()
        else
        end
      end
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "070")
    local result = tlk:Select(2, base .. "080")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "090")
      Qst.Sub:Set(self.ID, self.STEP_010)
      tlk:EndTalk()
    else
      if result == RESULT_TALK01 then
        tlk:Message(base .. "100")
        tlk:EndTalk()
      else
      end
    end
  end
end

function S080_061:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "110")
    local correct = false
    while correct ~= true do
      local result = tlk:Select(3, base .. "120")
      if result == RESULT_TALK00 then
        correct = true
        tlk:Message(base .. "130")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "140")
        tlk:Message(base .. "150")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "160")
        tlk:Message(base .. "170")
      end
    end
    tlk:Message(base .. "180")
    local result = tlk:Select(3, base .. "190")
    if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 then
      tlk:Message(base .. "200")
      tlk:Message(base .. "210")
      tlk:Message(base .. "220")
      Qst.Sub:Set(self.ID, self.STEP_015)
      Flg.Set("FLAG_SUB_080_061_001")
      tlk:EndTalk()
    end
  end
end

function S080_061:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "230")
    local result = tlk:Select(4, base .. "240")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "250")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "260")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "270")
    else
      if result == RESULT_TALK03 then
        tlk:Message(base .. "280")
        tlk:Message(base .. "290")
        tlk:Message(base .. "300")
        Flg.Set("FLAG_SUB_080_061_002")
        Qst.Sub:Set(self.ID, self.STEP_020)
      else
      end
    end
    tlk:EndTalk()
  end
end

function S080_061:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_020) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "310")
    tlk:Message(base .. "320")
    local result = tlk:Select(4, base .. "330")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "340")
      tlk:Message(base .. "380")
      Qst.Sub:End(self.ID, self.STEP_255)
      tlk:Message(base .. "390")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "350")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "360")
    else
      if result == RESULT_TALK03 then
        tlk:Message(base .. "370")
      else
      end
    end
    tlk:EndTalk()
  end
end
