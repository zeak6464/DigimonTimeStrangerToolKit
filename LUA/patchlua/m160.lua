gGimText = "field_text"
M160 = {
  ID = 160,
  STEP_001 = 1,
  STEP_255 = 255
}

function M160:Event_010()
  if Flg.Check("FLAG_MAIN_05_010", "FLAG_MAIN_05_020") then
    Flg.Set("FLAG_MAIN_05_020")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m160_010")
    Execute("m160_020")
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(27)
    end
    Qst.Main:End(150, 255)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(30)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M160:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) then
    Execute("m160_040")
    Execute("m160_050")
    Execute("m160_060")
    Flg.Set("FLAG_MAIN_05_030")
    Map:OpenArea(103, true)
    Map:OpenPlace(10302, true)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(30)
      Common.SetAegiomonGiftPoint(35000)
    end
    Qst.Main:End(self.ID, self.STEP_255)
    M170:Event_010()
  end
end
