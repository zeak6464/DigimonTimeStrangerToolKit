S090_071 = {
  ID = 71,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_020 = 20,
  STEP_030 = 30,
  STEP_255 = 255
}
local base = "s090_071_"
local text_file = "s090_071"

function S090_071:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_003, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "280")
    tlk:MessageClose()
    local result = tlk:Select(2, base .. "290")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "300")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "310")
      tlk:EndTalk()
    else
      tlk:Message(base .. "320")
      tlk:Message(base .. "330")
      tlk:Message(base .. "340")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003, true)
      Qst.Sub:Set(self.ID, self.STEP_005, true)
      Flg.Set("FLAG_SUB_090_071_001")
      S090_071:Event_015()
      MapChange("t", 102, "start_00", true, FADE_BLACK, FADE_TIME)
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "030")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "040")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "050")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "060")
    end
    tlk:Message(base .. "070")
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
    tlk:Message(base .. "160")
    tlk:MessageClose()
    local result2 = tlk:Select(3, base .. "170")
    if result2 == RESULT_TALK00 then
      tlk:Message(base .. "180")
    end
    if result2 == RESULT_TALK01 then
      tlk:Message(base .. "190")
    end
    if result2 == RESULT_TALK02 then
      tlk:Message(base .. "200")
    end
    tlk:Message(base .. "210")
    tlk:Message(base .. "220")
    tlk:Message(base .. "230")
    tlk:MessageClose()
    local result3 = tlk:Select(3, base .. "240")
    if result3 == RESULT_TALK00 then
      tlk:Message(base .. "250")
    end
    if result3 == RESULT_TALK01 then
      tlk:Message(base .. "260")
    end
    if result3 == RESULT_TALK02 then
      tlk:Message(base .. "270")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003, true)
    else
      tlk:Message(base .. "320")
      tlk:Message(base .. "330")
      tlk:Message(base .. "340")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_003, true)
      Qst.Sub:Set(self.ID, self.STEP_005, true)
      Flg.Set("FLAG_SUB_090_071_001")
      S090_071:Event_015()
      MapChange("t", 102, "start_00", true, FADE_BLACK, FADE_TIME)
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_030, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "770")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "780")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "790")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "800")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "810")
    end
    tlk:Message(base .. "820")
    tlk:Message(base .. "830")
    tlk:Message(base .. "840")
    Qst.Sub:End(self.ID, self.STEP_255)
    tlk:Message(base .. "850")
    tlk:EndTalk()
    Flg.Set("FLAG_IS_CLEAR_S090_071")
  end
end

function S090_071:Event_015()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    Digitter.Send(2071020)
  end
end

function S090_071:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "360")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_010, true)
    Flg.Set("FLAG_SUB_090_071_002")
    MapChange("t", 106, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function S090_071:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_020) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    tlk:Message(base .. "370")
    tlk:Message(base .. "380")
    tlk:Message(base .. "390")
    tlk:Message(base .. "400")
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
    tlk:Message(base .. "430")
    tlk:Message(base .. "440")
    tlk:Message(base .. "450")
    tlk:Message(base .. "460")
    tlk:Message(base .. "470")
    Flg.Set("FLAG_SUB_090_071_003")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "480")
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "490")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "500")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "510")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "520")
    end
    tlk:Message(base .. "530")
    tlk:Message(base .. "540")
    tlk:Message(base .. "550")
    tlk:MessageClose()
    local result1 = tlk:Select(3, base .. "560")
    if result1 == RESULT_TALK00 then
      tlk:Message(base .. "570")
    end
    if result1 == RESULT_TALK01 then
      tlk:Message(base .. "580")
    end
    if result1 == RESULT_TALK02 then
      tlk:Message(base .. "590")
    end
    tlk:Message(base .. "600")
    tlk:Message(base .. "610")
    tlk:MessageClose()
    local result2 = tlk:Select(3, base .. "620")
    if result2 == RESULT_TALK00 then
      tlk:Message(base .. "630")
    end
    if result2 == RESULT_TALK01 then
      tlk:Message(base .. "640")
    end
    if result2 == RESULT_TALK02 then
      tlk:Message(base .. "650")
    end
    tlk:Message(base .. "660")
    tlk:Message(base .. "670")
    tlk:Message(base .. "680")
    tlk:Message(base .. "690")
    tlk:MessageClose()
    local result3 = tlk:Select(3, base .. "700")
    if result3 == RESULT_TALK00 then
      tlk:Message(base .. "710")
    end
    if result3 == RESULT_TALK01 then
      tlk:Message(base .. "720")
    end
    if result3 == RESULT_TALK02 then
      tlk:Message(base .. "730")
    end
    tlk:Message(base .. "740")
    tlk:Message(base .. "750")
    tlk:Message(base .. "760")
    tlk:EndTalk()
    Flg.Set("FLAG_SUB_090_071_004")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_020, true)
  end
end

function S090_071:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_030) then
    Flg.Set("FLAG_SUB_090_071_005")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_030, true)
    MapChange("d", 608, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end
