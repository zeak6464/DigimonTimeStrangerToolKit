S050_047 = {
  ID = 47,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_050_047_001",
  Flg02 = "FLAG_SUB_050_047_002",
  Flg03 = "FLAG_SUB_050_047_003"
}
local text_file = "s050_047"
local base = "s050_047_"

function S050_047:Event_010()
  if Qst.Main:IsCompleted(M360.ID) and not Qst.Sub:IsCompleted(self.ID) and not Flg.Check(self.Flg01) then
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
      goto lbl_145
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
    end
    tlk:Message(base .. "130")
    tlk:Message(base .. "140")
    tlk:Message(base .. "150")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_005)
  end
  ::lbl_145::
end

function S050_047:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set(self.Flg02)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "160")
    local result = tlk:Select(3, base .. "170")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "180")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "190")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "200")
    end
    tlk:Message(base .. "210")
    tlk:Message(base .. "220")
    tlk:EndTalk()
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S050_047:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    Flg.Set(self.Flg03)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "230")
    tlk:EndTalk()
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    Qst.Sub:Set(self.ID, self.STEP_015)
  end
end

function S050_047:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "240")
    tlk:Message(base .. "250")
    tlk:Message(base .. "260")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_020)
  end
end

function S050_047:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:Message(base .. "290")
    tlk:Message(base .. "300")
    tlk:Message(base .. "310")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    require("S050_046")
    Qst.Sub:Set(S050_046.ID, S050_046.STEP_005)
  end
end
