gGimText = "field_text"
M380 = {
  ID = 380,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255
}

function M380:Event_010()
  if Flg.Check("FLAG_MAIN_15_040", "FLAG_MAIN_16_010") then
    Map:CloseArea(106, false)
    Map:OpenPlace(10606, false)
    Map:OpenPlace(10601, true)
    Flg.Set("FLAG_MAIN_16_010")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M380:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Map:CloseArea(101, true)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M380:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check("FLAG_MAIN_16_020") then
    Flg.Set("FLAG_MAIN_16_020")
    local dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m380_0010")
    dmy:EndTalk()
    Fade_OutNoLoading(FADE_BLACK, FADE_TIME)
    Obj:new(FLD_OBJ_GIMMICK, "obj_barricade03"):Invisible()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M380:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) then
    Flg.Set("FLAG_MAIN_16_030")
    local dmy = Tlk:new(gGimText)
    dmy:StartTalk()
    dmy:Message("dummy_m380_0020")
    dmy:EndTalk()
    Qst.Main:End(self.ID, self.STEP_255)
  end
end
