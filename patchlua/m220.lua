gGimText = "field_text"
M220 = {
  ID = 220,
  STEP_001 = 1,
  STEP_255 = 255
}

function M220:Event_010()
  if Flg.Check("FLAG_MAIN_07_069", "FLAG_MAIN_07_070") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m220_001")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 3001, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M220:Event_020()
  if Flg.Check("FLAG_MAIN_07_069", "FLAG_MAIN_07_070") then
    Flg.Set("FLAG_MAIN_07_070")
    FollowerSync()
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m220_010")
    PlayDungeonBGM()
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M220:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) then
    Flg.Set("FLAG_MAIN_07_080")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m220_020")
    MapChangeWithTimeTravel("e", 7, "start_00", AXIS_ORIGINAL, "A2028_daft_230", NOON)
  end
end

function M220:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) and Flg.Check("FLAG_MAIN_07_080", "FLAG_MAIN_07_085") then
    Field_StopBGM()
    Execute("m220_030")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    Flg.Set("TUT_FLAG_4615")
    Qst.Main:End(self.ID, self.STEP_255)
    MapChangeWithTimeTravel("t", 101, "start_20", AXIS_ORIGINAL, "A2028_daft_230", NOON)
  end
end
