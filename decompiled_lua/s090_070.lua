S090_070 = {
  ID = 70,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_020 = 20,
  STEP_255 = 255
}
local base = "s090_070_"
local text_file = "s090_070"

function S090_070:Event_010()
  if Flg.Check("FLAG_IS_CLEAR_S090_070") then
    S090_070:Event_050()
  elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) or Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_020) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    tlk:EndTalk()
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "230")
    tlk:Message(base .. "240")
    tlk:Message(base .. "250")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "260")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "270")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "280")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "290")
    end
    tlk:Message(base .. "300")
    tlk:Message(base .. "310")
    tlk:MessageClose()
    local result1 = tlk:Select(3, base .. "320")
    if result1 == RESULT_TALK00 then
      tlk:Message(base .. "330")
    end
    if result1 == RESULT_TALK01 then
      tlk:Message(base .. "340")
    end
    if result1 == RESULT_TALK02 then
      tlk:Message(base .. "350")
    end
    tlk:Message(base .. "360")
    tlk:Message(base .. "370")
    tlk:Message(base .. "380")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_010, true)
    Flg.Set("FLAG_SUB_090_070_002")
    MapChange("d", 1102, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function S090_070:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_003, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "090")
    tlk:MessageClose()
    local result = tlk:Select(2, base .. "100")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "120")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "130")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003, true)
    else
      tlk:Message(base .. "140")
      tlk:Message(base .. "150")
      tlk:Message(base .. "160")
      tlk:MessageClose()
      local result1 = tlk:Select(3, base .. "170")
      if result1 == RESULT_TALK00 then
        tlk:Message(base .. "180")
      end
      if result1 == RESULT_TALK01 then
        tlk:Message(base .. "190")
      end
      if result1 == RESULT_TALK02 then
        tlk:Message(base .. "200")
      end
      tlk:Message(base .. "210")
      tlk:Message(base .. "220")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003, true)
      Qst.Sub:Set(self.ID, self.STEP_005, true)
      Flg.Set("FLAG_SUB_090_070_001")
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "020")
    tlk:Message(base .. "030")
    tlk:Message(base .. "040")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "050")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "060")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "070")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "080")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003, true)
    else
      tlk:Message(base .. "140")
      tlk:Message(base .. "150")
      tlk:Message(base .. "160")
      tlk:MessageClose()
      local result1 = tlk:Select(3, base .. "170")
      if result1 == RESULT_TALK00 then
        tlk:Message(base .. "180")
      end
      if result1 == RESULT_TALK01 then
        tlk:Message(base .. "190")
      end
      if result1 == RESULT_TALK02 then
        tlk:Message(base .. "200")
      end
      tlk:Message(base .. "210")
      tlk:Message(base .. "220")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003, true)
      Qst.Sub:Set(self.ID, self.STEP_005, true)
      Flg.Set("FLAG_SUB_090_070_001")
    end
  end
end

function S090_070:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_020) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "390")
    tlk:Message(base .. "400")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "410")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "420")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "430")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "440")
    end
    tlk:Message(base .. "450")
    tlk:Message(base .. "460")
    tlk:Message(base .. "470")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_020, true)
    Flg.Set("FLAG_SUB_090_070_003")
    MapChange("d", 608, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function S090_070:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "480")
    tlk:Message(base .. "490")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "500")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "510")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "520")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "530")
    end
    tlk:Message(base .. "540")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_IS_CLEAR_S090_070")
  end
end

function S090_070:Event_050()
  if Flg.Check("FLAG_IS_CLEAR_S090_070") then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "550")
    tlk:Message(base .. "560")
    tlk:Message(base .. "570")
    tlk:Message(base .. "580")
    tlk:Message(base .. "590")
    tlk:Message(base .. "600")
    tlk:Message(base .. "610")
    tlk:EndTalk()
  end
end
