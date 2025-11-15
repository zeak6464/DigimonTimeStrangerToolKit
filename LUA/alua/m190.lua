gGimText = "field_text"
M190 = {
  ID = 190,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}

function M190:Event_005()
  if Flg.Check("FLAG_MAIN_07_000", "FLAG_MAIN_07_010") and not Qst.Main:Check(self.ID, self.STEP_001) then
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M190:Event_008()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Common.ProhibitSave()
    Sound.StopBGM(0)
    Execute("m190_010")
    MapChange("d", 609, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M190:Event_010()
  if Flg.Check("FLAG_MAIN_07_000", "FLAG_MAIN_07_010") and Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Obj:new(OGIM, "Grankuwaga"):CancelInvisible()
    Obj:new(OGIM, "trap01"):Invisible()
    Obj:new(OGIM, "trap02"):Invisible()
    Obj:new(OGIM, "trap03"):Invisible()
    Obj:new(OGIM, "trap04"):Invisible()
    Obj:new(OGIM, "trap05"):Invisible()
    Obj:new(OGIM, "trap06"):Invisible()
    Obj:new(OGIM, "trap07"):Invisible()
    Obj:new(OGIM, "trap08"):Invisible()
    Obj:new(OGIM, "trap09"):Invisible()
    Obj:new(OGIM, "trap10"):Invisible()
    Obj:new(OGIM, "trap11"):Invisible()
    Obj:new(OGIM, "trap12"):Invisible()
    Obj:new(OGIM, "trap13"):Invisible()
    Obj:new(OGIM, "trap14"):Invisible()
    Obj:new(OGIM, "fa_treasure_01"):Invisible()
    Obj:new(OGIM, "fa_treasure_02"):Invisible()
    Obj:new(OGIM, "fa_treasure_03"):Invisible()
    Obj:new(OGIM, "fa_treasure_04"):Invisible()
    Execute("m190_020")
    PlayDungeonBGM()
    Obj:new(PLAYER, ""):SetPlayerPosLocator("start_00")
    Obj:new(OGIM, "trap01"):CancelInvisible()
    Obj:new(OGIM, "trap02"):CancelInvisible()
    Obj:new(OGIM, "trap03"):CancelInvisible()
    Obj:new(OGIM, "trap04"):CancelInvisible()
    Obj:new(OGIM, "trap05"):CancelInvisible()
    Obj:new(OGIM, "trap06"):CancelInvisible()
    Obj:new(OGIM, "trap07"):CancelInvisible()
    Obj:new(OGIM, "trap08"):CancelInvisible()
    Obj:new(OGIM, "trap09"):CancelInvisible()
    Obj:new(OGIM, "trap10"):CancelInvisible()
    Obj:new(OGIM, "trap11"):CancelInvisible()
    Obj:new(OGIM, "trap12"):CancelInvisible()
    Obj:new(OGIM, "trap13"):CancelInvisible()
    Obj:new(OGIM, "trap14"):CancelInvisible()
    Obj:new(OGIM, "fa_treasure_01"):CancelInvisible()
    Obj:new(OGIM, "fa_treasure_02"):CancelInvisible()
    Obj:new(OGIM, "fa_treasure_03"):CancelInvisible()
    Obj:new(OGIM, "fa_treasure_04"):CancelInvisible()
    Obj:new(OGIM, "Grankuwaga"):Invisible()
    Flg.Set("FLAG_MAIN_07_010")
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M190:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M190:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_07_015") then
    EncountFromField(10700100, 10675, false)
  end
end

function M190:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_07_015") then
    Common.CancelProhibitSave()
    Qst.Main:Start(self.ID, self.STEP_015)
    MapChange("d", 606, "start_21", true, FADE_BLACK, FADE_TIME)
  end
end

function M190:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_07_015") then
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m190_0025")
    dmy:EndTalk()
    dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m190_0035")
    dmy:EndTalk()
  end
end

function M190:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_07_015") then
    Qst.Main:Start(self.ID, self.STEP_015)
  end
end

function M190:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) and not Flg.Check("FLAG_MAIN_07_020") then
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(10700200, BTL_MAO_JUNO_THRONE_GOLD, false)
  end
end

function M190:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) and Flg.Check("FLAG_MAIN_07_020") then
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("h", 101, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M190:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) then
    Execute("m190_090")
    Execute("m190_070")
    Flg.Set("FLAG_MAIN_07_030")
    Field.OverrideSeamlessTargetMap("t", 301)
    Execute("m190_080")
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(39)
    end
    Common.EvolutionAegiomon("AEGIOCHUSMON")
    Common.SetDigimonGraspState(184, DIGIMON_GRASP_FLAG_JOIN)
    Qst.Main:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("t", 301, "start_00", AXIS_ORIGINAL, "A2020_dbef_200", EVENING)
  end
end
