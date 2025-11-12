S030_028 = {
  ID = 28,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255
}
local base = "s030_028_"
local text_file = "s030_028"

function S030_028:Event_010()
  if Flg.Check("FLAG_IS_CLEAR_S030_027") then
    if Qst.Sub:Check(self.ID, self.STEP_003, self.STEP_005) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "080")
      tlk:MessageClose()
      local result = tlk:Select(3, base .. "040")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "050")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "060")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "070")
      else
        tlk:Message(base .. "090")
        Qst.Sub:Set(self.ID, self.STEP_005, true)
        Flg.Set("FLAG_SUB_030_028_001")
        FieldObjectSync(FOR_ALL, false)
      end
      tlk:EndTalk()
    elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "010")
      tlk:Message(base .. "020")
      tlk:Message(base .. "030")
      tlk:MessageClose()
      local result = tlk:Select(3, base .. "040")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "050")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "060")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "070")
        Qst.Sub:Set(self.ID, self.STEP_003, true)
      else
        tlk:Message(base .. "090")
        Qst.Sub:Set(self.ID, self.STEP_003, true)
        Qst.Sub:Set(self.ID, self.STEP_005, true)
        Flg.Set("FLAG_SUB_030_028_001")
        FieldObjectSync(FOR_ALL, false)
      end
      tlk:EndTalk()
    elseif Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "100")
      tlk:MessageClose()
      local result = tlk:Select(3, base .. "110")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "120")
        S030_028:Event_011()
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "130")
      else
        if result == RESULT_TALK02 then
          tlk:Message(base .. "140")
        else
        end
      end
      tlk:EndTalk()
    end
  end
  
  function S030_028:Event_011()
    if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "160")
      tlk:Message(base .. "170")
      tlk:Message(base .. "180")
      tlk:Message(base .. "190")
      tlk:Message(base .. "200")
      tlk:MessageClose()
      local result1 = tlk:Select(3, base .. "210")
      if result1 == RESULT_TALK00 then
        tlk:Message(base .. "220")
        tlk:Message(base .. "230")
      end
      if result1 == RESULT_TALK01 then
        tlk:Message(base .. "240")
        tlk:Message(base .. "250")
      end
      if result1 == RESULT_TALK02 then
        tlk:Message(base .. "260")
        tlk:Message(base .. "270")
      end
      tlk:Message(base .. "280")
      tlk:Message(base .. "290")
      tlk:Message(base .. "300")
      tlk:Message(base .. "310")
      tlk:Message(base .. "320")
      tlk:MessageClose()
      local result2 = tlk:Select(3, base .. "330")
      if result2 == RESULT_TALK00 then
        tlk:Message(base .. "340")
      end
      if result2 == RESULT_TALK01 then
        tlk:Message(base .. "350")
      end
      if result2 == RESULT_TALK02 then
        tlk:Message(base .. "360")
      end
      tlk:Message(base .. "370")
      tlk:Message(base .. "380")
      tlk:Message(base .. "390")
      tlk:Message(base .. "400")
      tlk:MessageClose()
      local result3 = tlk:Select(3, base .. "410")
      if result3 == RESULT_TALK00 then
        tlk:Message(base .. "420")
      end
      if result3 == RESULT_TALK01 then
        tlk:Message(base .. "430")
      end
      if result3 == RESULT_TALK02 then
        tlk:Message(base .. "440")
      end
      tlk:Message(base .. "450")
      tlk:MessageClose()
      local result4 = tlk:Select(3, base .. "460")
      if result4 == RESULT_TALK00 then
        tlk:Message(base .. "470")
      end
      if result4 == RESULT_TALK01 then
        tlk:Message(base .. "480")
      end
      if result4 == RESULT_TALK02 then
        tlk:Message(base .. "490")
      end
      tlk:Message(base .. "500")
      tlk:Message(base .. "510")
      tlk:Message(base .. "520")
      tlk:Message(base .. "530")
      Qst.Sub:End(self.ID, self.STEP_255)
      Flg.Set("FLAG_IS_CLEAR_S030_028")
      FieldObjectSync(FOR_ALL, false)
      tlk:EndTalk()
    end
  end
end

function S030_028:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    Qst.Sub:Set(self.ID, self.STEP_010, true)
    Flg.Set("FLAG_SUB_030_028_002")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function S030_028:Event_040()
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "540")
  tlk:MessageClose()
  local result = tlk:Select(3, base .. "550")
  if result == RESULT_TALK00 then
    tlk:Message(base .. "560")
  end
  if result == RESULT_TALK01 then
    tlk:Message(base .. "570")
  end
  if result == RESULT_TALK02 then
    tlk:Message(base .. "580")
  end
  tlk:EndTalk()
end
