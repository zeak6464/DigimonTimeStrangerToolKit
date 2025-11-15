S080_062 = {
  ID = 62,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255
}
local base = "s080_062_"
local text_file = "s080_062"
local tlk = Tlk:new(text_file, 1, true)

function S080_062:Event_000()
  Qst.Sub:Start(self.ID, self.STEP_001, true)
end

function S080_062:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    local result = tlk:Select(4, base .. "020")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "030")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "040")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "050")
    end
    if result == RESULT_TALK03 then
      tlk:Message(base .. "060")
      tlk:Message(base .. "070")
      tlk:Message(base .. "080")
      tlk:EndTalk()
    else
      tlk:Message(base .. "090")
      tlk:Message(base .. "100")
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
        tlk:Message(base .. "160")
      end
      tlk:Message(base .. "170")
      tlk:Message(base .. "180")
      tlk:Message(base .. "190")
      tlk:Message(base .. "200")
      Qst.Sub:Set(self.ID, self.STEP_005)
      Flg.Set("FLAG_SUB_080_062_001")
      tlk:EndTalk()
    end
  end
end

function S080_062:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "210")
    tlk:Message(base .. "220")
    local result = tlk:Select(2, base .. "230")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "240")
      tlk:Message(base .. "260")
      tlk:Message(base .. "270")
      tlk:Message(base .. "280")
      tlk:EndTalk()
    else
      if result == RESULT_TALK01 then
        tlk:Message(base .. "250")
        tlk:EndTalk()
      else
      end
    end
  end
end

function S080_062:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "290")
    tlk:Message(base .. "300")
    tlk:Message(base .. "310")
    tlk:Message(base .. "320")
    tlk:Message(base .. "330")
    tlk:Message(base .. "340")
    tlk:Message(base .. "350")
    tlk:Message(base .. "360")
    tlk:Message(base .. "370")
    tlk:Message(base .. "380")
    tlk:Message(base .. "390")
    tlk:Message(base .. "400")
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
    local correct = false
    while correct ~= true do
      local result = tlk:Select(3, base .. "430")
      if result == RESULT_TALK00 then
        correct = true
        tlk:Message(base .. "440")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "450")
        tlk:Message(base .. "470")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "460")
        tlk:Message(base .. "470")
      end
    end
    tlk:Message(base .. "480")
    tlk:Message(base .. "490")
    Qst.Sub:End(self.ID, self.STEP_255)
    tlk:EndTalk()
    goto lbl_279
  elseif Qst.Sub:Check(self.ID, self.STEP_255) and not Flg.Check("FLAG_SUB_080_062_002") then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "500")
    tlk:Message(base .. "510")
    local correct = false
    while correct ~= true do
      local result = tlk:Select(3, base .. "520")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "530")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "540")
      end
      if result == RESULT_TALK02 then
        correct = true
        tlk:Message(base .. "550")
        tlk:Message(base .. "560")
        tlk:Message(base .. "570")
        Flg.Set("FLAG_SUB_080_062_002")
      end
    end
    tlk:EndTalk()
    goto lbl_279
  else
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "580")
    tlk:Message(base .. "590")
    tlk:EndTalk()
    goto lbl_279
  end
  ::lbl_279::
end

function S080_062:Event_040()
  if Flg.Check("FLAG_SUB_080_062_002") then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "600")
    tlk:Message(base .. "610")
    local result = tlk:Select(2, base .. "620")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "630")
      tlk:Message(base .. "650")
      tlk:Message(base .. "660")
      tlk:EndTalk()
    else
      if result == RESULT_TALK01 then
        tlk:Message(base .. "640")
        tlk:EndTalk()
      else
      end
    end
  end
end
