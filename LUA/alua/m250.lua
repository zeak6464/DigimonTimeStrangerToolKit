gGimText = "field_text"
M250 = {
  ID = 250,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255
}

function M250:Event_010()
  if Flg.Check("FLAG_MAIN_08_043", "FLAG_MAIN_08_045") then
    Flg.Set("FLAG_MAIN_08_045")
    Execute("m250_010")
    SetFollowerCameraOperateRotation(10, 210)
    Map:CloseArea(103, true)
    Map:CloseArea(104, true)
    Map:CloseArea(105, true)
    Map:CloseArea(106, true)
    Map:OpenPlace(10211, true)
    Map:ClosePlace(10211, false)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M250:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_08_045", "FLAG_MAIN_08_050") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_08_050")
    Execute("m250_020")
    SetFollowerCameraOperateRotation(10, 30)
  end
end

function M250:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_08_050", "FLAG_MAIN_08_060") then
    Flg.Set("FLAG_MAIN_08_060")
    Execute("m250_030")
    Qst.Main:Set(self.ID, self.STEP_005)
    MapChangeWithTimePasses("d", 201, "start_00", EVENING)
  end
end

function M250:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_08_060", "FLAG_MAIN_09_005") then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(57)
    end
    Flg.Set("FLAG_MAIN_09_005")
    Execute("m250_035")
    Qst.Main:End(self.ID, self.STEP_255)
    M260:Event_010()
  end
end
