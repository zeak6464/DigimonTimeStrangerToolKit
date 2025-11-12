gGimText = "field_text"
M285 = {
  ID = 285,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255
}

function M285:Event_010()
  if Flg.Check("FLAG_MAIN_09_075", "FLAG_MAIN_09_080") then
    Field.SetMobTransparentFrontOfCamera(0, 10, 10, 10)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_09_077")
    FollowerSync()
    WaitFrame(1)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    local door = Motion.Object:new(FLD_OBJ_GIMMICK, "theaterdoor_01", "e005")
    Cam.Inst:Set(-53.335, 2.072, 88.239, -45.493, 3.177, 82.133, default, 0)
    local pc = Obj:new(PLAYER, "")
    local heroine = Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest")
    local aegio = Field.GetFollowerIndexForAegiomon()
    pc:SetPos(-49.464, 1.592, 84.304, true)
    pc:SetRotationY(70, 0)
    heroine:SetPos(-49.098, 1.602, 85.064, true)
    heroine:SetRotationY(70, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, aegio, -48.721, 1.592, 85.702)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio, 70, 0)
    PlaySE(401055, 100)
    WaitFrame(45)
    door:Play(0, false)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(80)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field.ClearMobTransparentFrontOfCamera(0)
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_09_080")
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    WaitFrame(30)
    Execute("m285_010")
    Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false, true)
    Qst.Main:Start(self.ID, self.STEP_001)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M285:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_09_080")
    Qst.Main:Check(self.ID, self.STEP_005)
  end
end

function M285:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set("FLAG_MAIN_09_081")
    Execute("m285_020")
    Guest.Add(GST_VENUS)
    FollowerSync()
    FieldObjectSync(NPC, true)
    local pc = Obj:new(PLAYER, "")
    pc:SetPos(-25.814, 3.83, 72.7, true)
    pc:SetRotationY(225, 0)
    SetFollowerCameraOperateRotation(6, 228)
    Qst.Main:Set(self.ID, self.STEP_010)
    INFO_WINDOW(7035)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M285:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_09_081", "FLAG_MAIN_09_082") then
    Flg.Set("FLAG_MAIN_09_082")
    Execute("m285_030")
    MapChangeWithTimePasses("d", 201, "start_20", EVENING)
  end
end

function M285:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_09_082", "FLAG_MAIN_09_082B") then
    Flg.Set("FLAG_MAIN_09_082B")
    Execute("m285_040")
    Obj:new(PLAYER, ""):SetRotationY(225, 0)
    SetFollowerCameraOperateRotation(0, 240)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M285:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_09_082B", "FLAG_MAIN_09_083") then
    Flg.Set("FLAG_MAIN_09_083")
    Execute("m285_050")
    MapChangeWithTimePasses("d", 1204, "start_20", NOON)
  end
end

function M285:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_09_083", "FLAG_MAIN_09_084") then
    Flg.Set("FLAG_MAIN_09_084")
    Execute("m285_060")
    Obj:new(PLAYER, ""):SetRotationY(10, 0)
    SetFollowerCameraOperateRotation(0, -20)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
  end
end

function M285:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_09_084", "FLAG_MAIN_09_090") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_09_090")
    Execute("m285_070")
    Digimon.RestoreAllParty()
    local pc = Obj:new(PLAYER, "")
    pc:SetPos(-0.301, 0, 2.028, true)
    pc:SetRotationY(170, 0)
    SetFollowerCameraOperateRotation(0, 160)
    FieldObjectSync(FOR_ALL, true)
    Qst.Main:End(self.ID, self.STEP_255)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end
