gGimText = "field_text"
M330 = {
  ID = 330,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255
}

function M330:Event_010()
  if Flg.Check("FLAG_MAIN_12_050", "FLAG_MAIN_12_060") then
    Flg.Set("FLAG_MAIN_12_060")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M330:Event_013()
  if Flg.Check("FLAG_MAIN_12_060", "FLAG_MAIN_12_063") then
    Digitter.Send(1330000010)
  end
end

function M330:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_12_060", "FLAG_MAIN_12_063") then
    Flg.Set("FLAG_MAIN_12_063")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-13.083, 3.301, -55.46, -17.524, 3.844, -64.403, default, 0)
    local pc = Obj:new(PLAYER, "")
    local inori = Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest")
    local aegio = Field.GetFollowerIndexForAegiomon()
    pc:SetPos(-16.686, 2.484, -63.078)
    pc:SetRotationY(170, 0)
    WaitFrame(5)
    inori:SetPos(-16.295, 2.484, -63.277)
    inori:SuspendAutoTransparentForCamera()
    WaitFrame(5)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, aegio, -17.123, 2.484, -62.973)
    Field.ObjectSuspendAutoTransparentForCamera(FLD_OBJ_FOLLOWER, aegio)
    WaitFrame(5)
    inori:SetRotationY(170, 0)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio, 170, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d12", 1, true, false)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1204_0520_0010")
    tlk:Message("f_d1204_0520_0020")
    tlk:Message("f_d1204_0520_0030")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Obj:new(PLAYER, ""):SetRotationY(350, 0)
    Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest"):SetRotationY(350, 0)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio, 350, 0)
    SetFollowerCameraOperateRotation(0, 350)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M330:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_12_070")
    Execute("m330_010")
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M330:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(84)
    end
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_12_130")
    Execute("m330_080")
    Digitter.Send(1340010010)
    Qst.Main:End(self.ID, self.STEP_255)
    M340:Event_010()
  end
end
