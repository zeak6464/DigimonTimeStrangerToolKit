gGimText = "field_text"
M370 = {
  ID = 370,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255
}

function M370:Event_010()
  if Flg.Check("FLAG_MAIN_14_070", "FLAG_MAIN_15_010") then
    Flg.Set("FLAG_MAIN_15_010")
    Map:OpenArea(101, true)
    Map:OpenPlace(10101, true)
    Map:CloseArea(107, true)
    local dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m370_0010")
    dmy:EndTalk()
    Qst.Main:Start(self.ID, self.STEP_001)
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2028_daft_370"
    TIME_ZONE = NOON
  end
end

function M370:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_15_020")
    local dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m370_0020")
    dmy:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M370:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_15_020", "FLAG_MAIN_15_030") then
    local dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m370_0100")
    dmy:EndTalk()
    Flg.Set("FLAG_MAIN_15_030")
    EncountFromField(11500100, 10174, false)
  end
end

function M370:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_15_030", "FLAG_MAIN_15_040") then
    Flg.Set("FLAG_MAIN_15_040")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m370_0110")
    dmy:EndTalk()
    Qst.Main:End(self.ID, self.STEP_255)
    Guest.Add(GST_APOLLO)
    MapChangeWithTimeTravel("d", 101, "start_20", AXIS_ORIGINAL, "Z2028_daft_380", NOON)
  end
end
