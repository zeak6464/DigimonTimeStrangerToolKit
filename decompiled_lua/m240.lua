gGimText = "field_text"
M240 = {
  ID = 240,
  STEP_001 = 1,
  STEP_255 = 255
}

function M240:Event_010()
  if Flg.Check("FLAG_MAIN_08_035", "FLAG_MAIN_08_040") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_08_040")
    Qst.Main:Start(self.ID, self.STEP_001)
    Obj:new(PLAYER, ""):SetPos(6.162, 0, 6.932, true)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    SetFollowerCameraOperateRotation(0, 180)
    FieldObjectSync(FOR_ALL, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M240:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) and Flg.Check("FLAG_MAIN_08_035", "FLAG_MAIN_08_043") then
    Flg.Set("FLAG_MAIN_08_043")
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(54)
    end
    Execute("m240_030")
    Qst.Main:End(self.ID, self.STEP_255)
    MapChangeWithTimeTravel("d", 216, "start_01", AXIS_ORIGINAL, "A2028_daft_250", EVENING)
  end
end
