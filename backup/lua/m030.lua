M030 = {
  ID = 30,
  STEP_001 = 1,
  STEP_255 = 255
}

function M030:Event_010()
  if Flg.Check("FLAG_MAIN_01_250") and not Flg.Check("FLAG_MAIN_02_010") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_02_010")
    WaitFrame(90)
    Execute("m030_010")
    FieldObjectSync(NPC, false)
    SetPlayerLocator("start_20")
    Qst.Main:Start(self.ID, self.STEP_001)
    PlayDungeonBGM()
  end
end

function M030:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) then
    FadeOutWithWaitNotFlgCheck(0, FADE_TIME)
    Execute("m030_050")
    Field.ObjectLoadMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "d08_floor"), "e002")
    Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "d08_floor"), "e002", 0, false)
    Obj:new(OGIM, "d08_bottomgear"):Invisible()
    Execute("m030_060")
    Execute("m030_070")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 3003, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M030:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) then
    Execute("m030_080")
    Qst.Main:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_MAIN_02_020")
    MapChangeWithTimeTravel("t", 302, "start_20", AXIS_ORIGINAL, "A2020_dbef_40", NIGHT)
  end
end

function M030:ChapterFlagSet(progress)
  local step = {}
  if 50 <= progress then
    step[#step + 1] = self.STEP_001
  end
  Qst.Main:Chapter(step, self.ID)
end
