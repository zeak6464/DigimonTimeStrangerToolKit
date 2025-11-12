S050_048 = {
  ID = 48,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_050_048_001",
  Flg02 = "FLAG_SUB_050_048_002",
  Flg03 = "FLAG_SUB_050_048_003",
  Flg04 = "FLAG_SUB_050_048_004",
  Flg05 = "FLAG_SUB_050_048_005",
  Flg06 = "FLAG_SUB_050_048_006"
}
local text_file = "s050_048"
local base = "s050_048_"

function S050_048:Event_010()
  if Qst.Main:IsCompleted(M360.ID) and not Qst.Sub:IsCompleted(self.ID) then
    if not Qst.Sub:Check(self.ID, self.STEP_005) then
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "010")
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
        goto lbl_129
      end
      tlk:Message(base .. "080")
      tlk:Message(base .. "090")
      tlk:EndTalk()
      Qst.Sub:Set(self.ID, self.STEP_005)
      Flg.Set(self.Flg06)
      FieldObjectSync(FLD_OBJ_LOCATOR, true)
    else
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "100")
      tlk:Message(base .. "110")
      tlk:EndTalk()
    end
  end
  ::lbl_129::
end

function S050_048:Event_020(gim_name)
  if Qst.Sub:Check(self.ID, self.STEP_005) then
    local tlk = Tlk:new("d02")
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0202_0390_0020")
    tlk:EndTalk()
    Obj:new(FLD_OBJ_LOCATOR, gim_name):Invisible()
    Item.Add(775, 1)
    if gim_name == "gim_1000" then
      Flg.Set(self.Flg01)
      Qst.Sub:Set(self.ID, self.STEP_010)
    elseif gim_name == "gim_1001" then
      Flg.Set(self.Flg02)
      Qst.Sub:Set(self.ID, self.STEP_015)
    elseif gim_name == "gim_1002" then
      Flg.Set(self.Flg03)
      Qst.Sub:Set(self.ID, self.STEP_020)
    elseif gim_name == "gim_1003" then
      Flg.Set(self.Flg04)
      Qst.Sub:Set(self.ID, self.STEP_025)
    elseif gim_name == "gim_1004" then
      Flg.Set(self.Flg05)
      Qst.Sub:Set(self.ID, self.STEP_030)
    end
  else
    local tlk = Tlk:new("d02")
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0202_0390_0010")
    tlk:EndTalk()
  end
end

function S050_048:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_030, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "120")
    tlk:Message(base .. "130")
    tlk:Message(base .. "140")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    require("S050_046")
    Qst.Sub:Set(S050_046.ID, S050_046.STEP_010)
  end
end
