S050_040 = {
  ID = 40,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_S050_040_001"
}
local base = "s050_040_"
local text_file = "s050_040"

function S050_040:Event_010()
  if Qst.Main:IsCompleted(M140.ID) and not Qst.Sub:IsCompleted(self.ID) then
    if not Qst.Sub:Check(self.ID, self.STEP_005) then
      if not Flg.Check(self.Flg01) then
        local tlk = Tlk:new(text_file, 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message(base .. "010")
        local result = tlk:Select(3, base .. "020")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "030")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "040")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "050")
        end
        tlk:Message(base .. "060")
        tlk:Message(base .. "070")
        tlk:Message(base .. "080")
        result = tlk:Select(2, base .. "090")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "100")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "110")
          tlk:EndTalk()
          goto lbl_220
        end
        Flg.Set(self.Flg01)
        tlk:Message(base .. "120")
        tlk:Message(base .. "130")
        tlk:Message(base .. "140")
        tlk:EndTalk()
        Qst.Sub:Set(self.ID, self.STEP_005)
      else
        local tlk = Tlk:new(text_file, 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message(base .. "150")
        local result = tlk:Select(2, base .. "090")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "100")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "110")
        end
        tlk:Message(base .. "120")
        tlk:Message(base .. "130")
        tlk:Message(base .. "140")
        tlk:EndTalk()
        Qst.Sub:Set(self.ID, self.STEP_005)
      end
    else
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "140")
      tlk:EndTalk()
    end
  end
  ::lbl_220::
end

function S050_040:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "160")
    tlk:Message(base .. "170")
    tlk:Message(base .. "180")
    local result = tlk:Select(2, base .. "190")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "200")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "210")
      tlk:EndTalk()
      goto lbl_131
    end
    tlk:Message(base .. "220")
    tlk:Message(base .. "230")
    tlk:Message(base .. "240")
    tlk:Message(base .. "250")
    tlk:Message(base .. "260")
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:Message(base .. "290")
    Qst.Sub:Set(self.ID, self.STEP_010)
    tlk:EndTalk()
  elseif Qst.Sub:Check(self.ID, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "290")
    tlk:EndTalk()
  end
  ::lbl_131::
end

function S050_040:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "300")
    tlk:Message(base .. "310")
    tlk:Message(base .. "320")
    tlk:Message(base .. "330")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end
