S050_049 = {
  ID = 49,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_050_049_001"
}
local text_file = "s050_049"
local base = "s050_049_"

function S050_049:Event_010()
  if Qst.Main:IsCompleted(M360.ID) and not Qst.Sub:IsCompleted(self.ID) then
    if not Qst.Sub:Check(self.ID, self.STEP_005) then
      if not Flg.Check(self.Flg01) then
        local tlk = Tlk:new(text_file, 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message(base .. "020")
        tlk:Message(base .. "030")
        local result = tlk:Select(3, base .. "040")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "050")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "060")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "070")
          tlk:EndTalk()
          goto lbl_244
        end
        tlk:Message(base .. "080")
        tlk:Message(base .. "090")
        tlk:Message(base .. "100")
        Flg.Set(self.Flg01)
        result = tlk:Select(3, base .. "110")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "120")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "130")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "140")
          tlk:EndTalk()
          goto lbl_244
        end
        tlk:Message(base .. "190")
        tlk:Message(base .. "200")
        tlk:EndTalk()
        Qst.Sub:Set(self.ID, self.STEP_005)
      else
        local tlk = Tlk:new(text_file, 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message(base .. "150")
        local result = tlk:Select(2, base .. "160")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "170")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "180")
          tlk:EndTalk()
          goto lbl_244
        end
        tlk:Message(base .. "190")
        tlk:Message(base .. "200")
        tlk:EndTalk()
        Qst.Sub:Set(self.ID, self.STEP_005)
      end
    elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "210")
      tlk:Message(base .. "220")
      tlk:EndTalk()
    end
  end
  ::lbl_244::
end

function S050_049:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "230")
    local result = tlk:Select(3, base .. "240")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "250")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "260")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "270")
      tlk:EndTalk()
      goto lbl_129
    end
    tlk:Message(base .. "280")
    tlk:Message(base .. "290")
    tlk:Message(base .. "300")
    result = tlk:Select(3, base .. "310")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "320")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "330")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "340")
    end
    tlk:Message(base .. "350")
    tlk:Message(base .. "360")
    tlk:Message(base .. "370")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
  ::lbl_129::
end

function S050_049:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "380")
    local result = tlk:Select(3, base .. "390")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "400")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "410")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "420")
    end
    tlk:Message(base .. "430")
    result = tlk:Select(3, base .. "450")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "460")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "470")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "480")
    end
    tlk:Message(base .. "490")
    tlk:Message(base .. "500")
    tlk:Message(base .. "510")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_015)
  end
end

function S050_049:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "520")
    local result = tlk:Select(3, base .. "530")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "540")
      tlk:Message(base .. "550")
      tlk:Message(base .. "560")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "570")
      tlk:Message(base .. "580")
      tlk:Message(base .. "590")
      goto lbl_104
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "600")
      tlk:Message(base .. "610")
      tlk:Message(base .. "620")
      goto lbl_104
    end
    Qst.Sub:End(self.ID, self.STEP_255)
    require("S050_046")
    Qst.Sub:Set(S050_046.ID, S050_046.STEP_015)
    ::lbl_104::
    tlk:EndTalk()
  elseif Qst.Sub:IsCompleted(self.ID) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "630")
    tlk:EndTalk()
  end
end
