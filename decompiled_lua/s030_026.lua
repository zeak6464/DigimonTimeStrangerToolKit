S030_026 = {
  ID = 26,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_020 = 20,
  STEP_255 = 255
}
local base = "s030_026_"
local text_file = "s030_026"

function S030_026:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_003, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "190")
    tlk:MessageClose()
    local result = tlk:Select(2, base .. "200")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "220")
      tlk:Message(base .. "240")
      Qst.Sub:Set(self.ID, self.STEP_005)
      Flg.Set("FLAG_SUB_030_026_001")
      tlk:EndTalk()
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "230")
      tlk:EndTalk()
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_003) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
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
    end
    tlk:Message(base .. "080")
    tlk:Message(base .. "090")
    tlk:MessageClose()
    local result1 = tlk:Select(3, base .. "100")
    if result1 == RESULT_TALK00 then
      tlk:Message(base .. "110")
    end
    if result1 == RESULT_TALK01 then
      tlk:Message(base .. "120")
    end
    if result1 == RESULT_TALK02 then
      tlk:Message(base .. "130")
    end
    tlk:Message(base .. "140")
    tlk:Message(base .. "150")
    tlk:MessageClose()
    local result2 = tlk:Select(2, base .. "160")
    if result2 == RESULT_TALK00 then
      tlk:Message(base .. "170")
      tlk:Message(base .. "240")
      Qst.Sub:Set(self.ID, self.STEP_003)
      Qst.Sub:Set(self.ID, self.STEP_005)
      Flg.Set("FLAG_SUB_030_026_001")
      tlk:EndTalk()
    end
    if result2 == RESULT_TALK01 then
      tlk:Message(base .. "180")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003)
    else
    end
    tlk:EndTalk()
  elseif not Qst.Sub:Check(self.ID, self.STEP_001) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    tlk:EndTalk()
  end
end

function S030_026:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
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
      tlk:Message(base .. "340")
    end
    if result1 == RESULT_TALK01 then
      tlk:Message(base .. "350")
    end
    if result1 == RESULT_TALK02 then
      tlk:Message(base .. "360")
    end
    tlk:Message(base .. "370")
    tlk:Message(base .. "380")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "390")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_010)
    Flg.Set("FLAG_SUB_030_026_002")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function S030_026:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_020) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "420")
    tlk:EndTalk()
    INFO_GET_ITEM(772, 1)
    Qst.Sub:Set(self.ID, self.STEP_020)
    Flg.Set("FLAG_SUB_030_026_003")
    FieldObjectSync(FOR_ALL, false)
  end
end

function S030_026:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Item.Delete(772, 1)
    tlk:Message(base .. "430")
    tlk:Message(base .. "440")
    tlk:MessageClose()
    local result = tlk:Select(2, base .. "450")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "460")
      tlk:Message(base .. "470")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "480")
      tlk:Message(base .. "490")
    end
    tlk:Message(base .. "500")
    tlk:Message(base .. "510")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_IS_CLEAR_S030_026")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end
