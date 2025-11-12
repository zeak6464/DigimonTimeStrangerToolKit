S050_050 = {
  ID = 50,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_050_050_001",
  Flg02 = "FLAG_SUB_050_050_002",
  Flg03 = "FLAG_SUB_050_050_003",
  Flg04 = "FLAG_SUB_050_050_004",
  Flg05 = "FLAG_SUB_050_050_005"
}
local text_file = "s050_050"
local base = "s050_050_"

function S050_050:Event_010()
  if Qst.Main:IsCompleted(M360.ID) and not Qst.Sub:IsCompleted(self.ID) then
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
          tlk:EndTalk()
          goto lbl_259
        end
        Flg.Set(self.Flg01)
        tlk:Message(base .. "060")
        tlk:Message(base .. "070")
        tlk:Message(base .. "080")
        result = tlk:Select(3, base .. "090")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "100")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "110")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "120")
          tlk:EndTalk()
          goto lbl_259
        end
        tlk:Message(base .. "180")
        tlk:Message(base .. "190")
        tlk:Message(base .. "200")
        tlk:EndTalk()
        Qst.Sub:Set(self.ID, self.STEP_005)
      else
        local tlk = Tlk:new(text_file, 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message(base .. "130")
        tlk:Message(base .. "140")
        local result = tlk:Select(2, base .. "150")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "160")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "170")
          tlk:EndTalk()
          goto lbl_259
        end
        tlk:Message(base .. "180")
        tlk:Message(base .. "190")
        tlk:Message(base .. "200")
        tlk:EndTalk()
        Qst.Sub:Set(self.ID, self.STEP_005)
      end
    elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_025) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "210")
      tlk:Message(base .. "220")
      tlk:Message(base .. "230")
      tlk:EndTalk()
    end
  end
  ::lbl_259::
end

function S050_050:Event_020()
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "240")
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    tlk:Message(base .. "250")
    tlk:Message(base .. "260")
    local result = tlk:Select(3, base .. "270")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "280")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "290")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "300")
      tlk:EndTalk()
      goto lbl_175
    end
    Flg.Set(self.Flg02)
    tlk:Message(base .. "310")
    tlk:Message(base .. "320")
    tlk:Message(base .. "330")
    result = tlk:Select(3, base .. "340")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "350")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "360")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "370")
    end
    tlk:Message(base .. "380")
    tlk:Message(base .. "390")
    tlk:Message(base .. "400")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_010)
    FieldObjectSync(NPC, true)
  elseif Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
  end
  ::lbl_175::
  tlk:EndTalk()
end

function S050_050:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    if not Flg.Check(self.Flg03) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "430")
      local result = tlk:Select(3, base .. "440")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "450")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "460")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "470")
        tlk:EndTalk()
        goto lbl_236
      end
      Flg.Set(self.Flg03)
      tlk:Message(base .. "480")
      tlk:Message(base .. "490")
      tlk:Message(base .. "500")
      result = tlk:Select(3, base .. "510")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "520")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "530")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "540")
      end
      tlk:Message(base .. "590")
      tlk:Message(base .. "600")
      tlk:Message(base .. "610")
      tlk:EndTalk()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, true)
      WaitFrame(15)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Qst.Sub:Set(self.ID, self.STEP_015)
    else
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "550")
      local result = tlk:Select(2, base .. "560")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "570")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "580")
        tlk:EndTalk()
        goto lbl_236
      end
      Flg.Set(self.Flg03)
      tlk:Message(base .. "590")
      tlk:Message(base .. "600")
      tlk:Message(base .. "610")
      tlk:EndTalk()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, true)
      WaitFrame(15)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Qst.Sub:Set(self.ID, self.STEP_015)
    end
  end
  ::lbl_236::
end

function S050_050:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) then
    local tlk = Tlk:new(text_file, 1, true)
    Flg.Set(self.Flg04)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "620")
    tlk:Message(base .. "630")
    tlk:Message(base .. "640")
    tlk:Message(base .. "650")
    tlk:Message(base .. "660")
    tlk:Message(base .. "670")
    tlk:Message(base .. "680")
    tlk:Message(base .. "690")
    tlk:Message(base .. "700")
    tlk:Message(base .. "710")
    tlk:Message(base .. "720")
    tlk:Message(base .. "730")
    tlk:Message(base .. "740")
    tlk:Message(base .. "750")
    tlk:Message(base .. "760")
    tlk:Message(base .. "770")
    tlk:Message(base .. "780")
    tlk:Message(base .. "790")
    tlk:Message(base .. "800")
    tlk:Message(base .. "810")
    tlk:Message(base .. "820")
    tlk:Message(base .. "830")
    tlk:Message(base .. "840")
    tlk:Message(base .. "850")
    tlk:Message(base .. "860")
    tlk:Message(base .. "870")
    tlk:Message(base .. "880")
    tlk:Message(base .. "890")
    local result = tlk:Select(3, base .. "900")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "910")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "920")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "930")
    end
    tlk:Message(base .. "940")
    tlk:Message(base .. "950")
    tlk:Message(base .. "960")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_020)
  end
end

function S050_050:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_025) then
    Flg.Set(self.Flg05)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "970")
    tlk:Message(base .. "980")
    tlk:Message(base .. "990")
    tlk:Message(base .. "1000")
    tlk:Message(base .. "1010")
    tlk:Message(base .. "1020")
    tlk:Message(base .. "1030")
    tlk:Message(base .. "1040")
    tlk:Message(base .. "1050")
    tlk:Message(base .. "1060")
    tlk:Message(base .. "1070")
    tlk:Message(base .. "1080")
    tlk:Message(base .. "1090")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_025)
  end
end

function S050_050:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_025, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "1100")
    tlk:Message(base .. "1110")
    tlk:Message(base .. "1120")
    tlk:Message(base .. "1130")
    tlk:Message(base .. "1140")
    tlk:Message(base .. "1150")
    tlk:Message(base .. "1160")
    tlk:Message(base .. "1170")
    tlk:Message(base .. "1180")
    tlk:Message(base .. "1190")
    tlk:Message(base .. "1200")
    tlk:Message(base .. "1210")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    require("S100_088")
    Qst.Sub:Set(S100_088.ID, S100_088.STEP_015)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    require("S050_046")
    Qst.Sub:Set(S050_046.ID, S050_046.STEP_020)
  elseif Qst.Sub:IsCompleted(self.ID) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "1220")
    tlk:Message(base .. "1230")
    tlk:Message(base .. "1240")
    tlk:EndTalk()
  end
end
