gGimText = "field_text"
M300 = {
  ID = 300,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_013 = 13,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_255 = 255
}

function M300:Event_001()
  if Flg.Check("FLAG_MAIN_10_015", "FLAG_MAIN_10_020") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_10_020")
    Flg.Set("FLAG_GIMMICK_D04_050")
    Execute("m300_010")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M300:Event_002()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_020", "FLAG_MAIN_10_021") then
    Flg.Set("FLAG_MAIN_10_021")
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(66.61, -2.12, 86.04, 66.11, -2.54, 96.01, DEFAULT_ANGLE, 30)
    WaitFrame(30)
    Cam.Inst:Set(68.01, 1.98, 75.68, 67.5, 1.56, 85.66, DEFAULT_ANGLE, 30)
    local index = GetIndex(FLD_OBJ_NPC, "npc_001")
    Field.ObjectLoadMotion(FLD_OBJ_NPC, index, "fe02")
    Field.ObjectLoadMotion(FLD_OBJ_NPC, index, "bn01")
    Field.ObjectPlayMotion(FLD_OBJ_NPC, index, "fe02", 5, true)
    tlk:Message("f_d0402_0090_0010")
    tlk:Message("f_d0402_0090_0020")
    Cam.Inst:Clear(30)
    WaitFrame(30)
    Field.ObjectPlayMotion(FLD_OBJ_NPC, index, "fe02", 5, true)
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_10_022")
  end
end

function M300:Event_003()
  if not Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) or Flg.Check("FLAG_MAIN_10_021", "FLAG_MAIN_10_022") then
  end
end

function M300:Event_004()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_022", "FLAG_MAIN_10_023") then
    Cam.Inst:Set(17.76, -4.19, -13.5, 19.68, -5.26, -3.74, default, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0402_0120_0010")
    tlk:Message("f_d0402_0120_0020")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    EncountFromField_WithNormalEffect(11020020, 10471, false)
  end
end

function M300:Event_005()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_023", "FLAG_MAIN_10_024") then
    Flg.Set("FLAG_MAIN_10_023")
    HideMinimap(true)
    HideGuide(true)
    local bn01 = Motion.Object:new(NPC, "npc_015", "bn01")
    local fe02 = Motion.Object:new(NPC, "npc_015", "fe02")
    local fe04 = Motion.Object:new(NPC, "npc_015", "fe04")
    local fq01 = Motion.Object:new(NPC, "npc_015", "fq01")
    local npc_index01 = GetIndex(NPC, "npc_015")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 255, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 8.672, -6.078, -14.723)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1) - 10)
    Motion.Player:Play("fn01_01", 0, true)
    Cam.Inst:Set(2.357232, -5.5288, -12.912234, 10.469398, -4.38208, -18.635069, default, 1)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe02", 10, 10)
    tlk:Message("f_d0402_0130_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message("f_d0402_0130_0020")
    WaitFrame(15)
    Motion.Player:PlayWithMoveMotion("e002", 5, 5)
    MessageClose()
    WaitFrame(90)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    tlk:Message("f_d0402_0130_0030")
    MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_003)
    Cam.Inst:Clear(0)
    HideMinimap(false)
    HideGuide(false)
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_10_024")
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    Guest.Add(GST_LOTUS)
    Common.SetDigimonGraspState(742, DIGIMON_GRASP_FLAG_SCAN)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function M300:Event_006()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_10_024", "FLAG_MAIN_10_025") then
    Flg.Set("FLAG_MAIN_10_025")
    local bn01 = Motion.Object:new(NPC, "npc_003", "bn01")
    local fe03 = Motion.Object:new(NPC, "npc_003", "fe03")
    Cam.Inst:Set(13.03, 74.574, -87.156, 22.865, 74.819, -88.267, default, 45)
    WaitFrame(45)
    Cam.Inst:Set(-85.15, 72.34, -117.42, -80.51, 75.63, -109.21, default, 60)
    WaitFrame(60)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    fe03:Play(10, true)
    tlk:Message("f_d0403_0040_0010")
    tlk:MessageClose()
    bn01:Play(10, true)
    Cam.Inst:Clear(45)
    WaitFrame(45)
    tlk:Message("f_d0403_0040_0020")
    tlk:EndTalk()
  end
end

function M300:Event_007A()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_10_024", "FLAG_MAIN_10_026") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0402_0140_0010")
    Field.MovePlayerToRelativePosFrame(-1, 0.5, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_007B()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_10_024", "FLAG_MAIN_10_026") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0402_0140_0010")
    Field.MovePlayerToRelativePosFrame(-1, -1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_010()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_10_025", "FLAG_MAIN_10_026") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_10_026")
    Execute("m300_020")
    SetFollowerCameraOperateRotation(0, 0)
    Qst.Main:Start(self.ID, self.STEP_005)
  end
end

function M300:Event_015A()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0350_0010")
    Field.MovePlayerToRelativePosFrame(-0.5, -1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_015B()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0350_0010")
    Field.MovePlayerToRelativePosFrame(1, -0.5, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_015C()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0350_0010")
    Field.MovePlayerToRelativePosFrame(-0.5, 1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_015D()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0350_0010")
    Field.MovePlayerToRelativePosFrame(0.5, 1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_015E()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0350_0010")
    Field.MovePlayerToRelativePosFrame(1, -0.5, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check("FLAG_MAIN_10_030") then
    local npc_index01 = GetIndex(NPC, "npc_0212")
    local npc_index02 = GetIndex(NPC, "npc_0211")
    local f_fe04 = Motion.Object:new(NPC, "npc_0212", "fe04")
    local f_bn01 = Motion.Object:new(NPC, "npc_0212", "bn01")
    local f_bn02 = Motion.Object:new(NPC, "npc_0212", "bn02")
    local t_bn02 = Motion.Object:new(NPC, "npc_0211", "bn02")
    Cam.Inst:Set(4.06, -2.6, 67.41, -1.33, -0.31, 75.5, default, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_MAIN_10_030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    tlk:Message("f_d0404_0190_0010")
    t_bn02:Play(10, true)
    tlk:Message("f_d0404_0190_0020")
    tlk:Message("f_d0404_0190_0030")
    f_bn02:Play(10, true)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Set(5.08, -4.22, 66.29, -0.42, -1.25, 74.09, default, 15)
    WaitFrame(15)
    tlk:Message("f_d0404_0190_0040")
    Cam.Inst:Clear(30)
    tlk:EndTalk()
  end
end

function M300:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check("FLAG_MAIN_10_031") then
    local npc_index01 = GetIndex(NPC, "npc_0238")
    local fq01 = Motion.Object:new(NPC, "npc_0238", "fq01")
    local bn02 = Motion.Object:new(NPC, "npc_0238", "bn02")
    Cam.Inst:Set(7.18, 0.54, 29.97, 4.63, 1.77, 39.56, default, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_0225"), 10)
    Flg.Set("FLAG_MAIN_10_031")
    tlk:Message("f_d0404_0200_0010")
    bn02:Play(10, true)
    tlk:Message("f_d0404_0200_0020")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Set(7.6, -1.05, 32.39, 5.14, 1.83, 41.34, default, 15)
    WaitFrame(15)
    tlk:Message("f_d0404_0200_0030")
    tlk:Message("f_d0404_1000_0010")
    Cam.Inst:Clear(30)
    tlk:EndTalk()
  end
end

function M300:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local flags = {
      "FLAG_MAIN_10_030",
      "FLAG_MAIN_10_031"
    }
    if Flg.AllCheck(flags) then
      Execute("m300_030")
      Guest.Delete(GST_LOTUS)
      MapChange("h", 601, "start_00", false, FADE_BLACK, FADE_TIME)
    end
  end
end

function M300:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Guest.Delete(GST_LOTUS)
    Execute("m300_040")
    Flg.Set("FLAG_MAIN_10_040")
    Guest.Add(GST_LOTUS)
    Work.Set(Field_H06_LoopCount, 0)
    local lotus = Obj:new(FLD_OBJ_FOLLOWER, GST_LOTUS, "guest")
    Obj:new(NPC, "npc_0002"):Invisible()
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, lotus.index, "fq01")
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, lotus.index, "fq02")
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, lotus.index, "fe02")
    local tlk = Tlk:new("h06", 1, true, false)
    local aegio = Field.GetFollowerIndexForAegiomon()
    local heroine = Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest")
    local pc = Obj:new(PLAYER, "")
    Cam.Inst:Set(-62.952, 21.292, 18.691, -62.947, 21.722, 28.682, default, 0)
    pc:SetPos(-64.543, 20.843, 22.19)
    Field.FollowerWarp()
    lotus:CancelInvisible()
    lotus:CancelSuspendAutoTransParentForCamera()
    lotus:SetPos(-61.83, 20.742, 22.19)
    lotus:SetRotationY(-140, 0)
    heroine:SetPos(-64.543, 20.843, 22.863, true)
    heroine:SetRotationY(90, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, aegio, -63.986, 20.843, 21.538)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio, 90, 0)
    pc:SetRotationY(90, 0)
    lotus:SuspendAutoTransparentForCamera()
    Digimon.RestoreAllParty()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_FOLLOWER, lotus.index, "fq01", 10, 10)
    tlk:Message("f_h0601_0040_0010")
    tlk:Message("f_h0601_0040_0020")
    Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_FOLLOWER, lotus.index, "fq02", 10, 10)
    tlk:Message("f_h0601_0030_0010")
    tlk:Message("f_h0601_0030_0020")
    Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_FOLLOWER, lotus.index, "fe02", 10, 10)
    tlk:Message("f_h0601_0030_0030")
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, true)
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M300:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_013) and Flg.Check("FLAG_MAIN_10_040", "FLAG_MAIN_10_045") then
    local npc_0001 = Obj:new(NPC, "npc_0001")
    local e004 = Motion.Object:new(NPC, "npc_0001", "e004")
    local e007 = Motion.Object:new(NPC, "npc_0001", "e007")
    Cam.Inst:Set(-14.925, 23.092, 22.416, -14.925, 23.092, 32.416, default, 30)
    Field.SetProhibitPlayerMoveOperate(true)
    Flg.Set("FLAG_MAIN_10_045")
    local tlk = Tlk:new("h06", 1, true)
    npc_0001:SetRotationY(250, 20)
    WaitFrame(20)
    tlk:StartTalkAndCancelDigimonRide()
    e004:Play(10, true)
    tlk:Message("f_h0601_0070_0010")
    e007:Play(10, true)
    tlk:Message("f_h0601_0070_0020")
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(10)
    Guest.Add(GST_BACCHUS)
    FollowerSync()
    Common.SetDigimonGraspState(179, DIGIMON_GRASP_FLAG_SCAN)
    Qst.Main:Set(self.ID, self.STEP_013)
    Field.SetProhibitPlayerMoveOperate(false)
    Cam.Inst:Clear(30)
  end
end

function M300:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) and Flg.Check("FLAG_MAIN_10_045", "FLAG_MAIN_10_047") then
    Flg.Set("FLAG_IS_KEEP_BGM")
    EncountFromField(11020100, 20671, false)
  end
end

function M300:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) and Flg.Check("FLAG_MAIN_10_047") then
    Digimon.RestoreAllParty()
    MapChange("d", 404, "start_09", false, FADE_WHITE, FADE_TIME)
  end
end

function M300:Event_150()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) and Flg.Check("FLAG_MAIN_10_047", "FLAG_MAIN_10_048") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_10_048")
    Execute("m300_070")
    SetFollowerCameraOperateRotation(0, 20)
    Work.Set(Field_H06_LoopCount, 0)
    Guest.Delete(GST_LOTUS)
    FieldObjectSync(FOR_ALL, true)
    Qst.Main:Set(self.ID, self.STEP_015)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Digitter.Send(1300070010)
  end
end

function M300:Event_160()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and not Flg.Check("FLAG_MAIN_10_050") then
    Guest.Add(GST_SIREN)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(11020200, 10475, false)
  end
end

function M300:Event_170()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_10_050") then
    Execute("m300_100")
    Guest.Delete(GST_SIREN)
    Guest.Delete(GST_BACCHUS)
    Common.SetDigimonGraspState(232, DIGIMON_GRASP_FLAG_SCAN)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("t", 3002, "start_01", AXIS_ORIGINAL, "A2028_daft_300", EVENING)
  end
end

function M300:Event_180()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_10_050", "FLAG_MAIN_10_053") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_10_053")
    Execute("m300_110")
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    local org_prefix = "d"
    local org_number = 404
    local org_locator = "start_09"
    local org_time_zone = Common.GetTimeZone()
    Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 3001, "start_01", false, FADE_BLACK, FADE_TIME)
  end
end

function M300:Event_185()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_10_053", "FLAG_MAIN_10_054") then
    Flg.Set("FLAG_MAIN_10_054")
    Prcs_t3001_12GodsReliefInvisible(true)
    Execute("m300_120")
    Prcs_t3001_12GodsReliefInvisible(false)
    Flg.Set("FLAG_GIMMICK_T0301_004")
    Flg.Set("FLAG_GIMMICK_T0301_012")
    Prcs_t3001_12GodsReliefSeting()
    Obj:new(PLAYER, ""):SetPos(0, 0, 0)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    SetFollowerCameraOperateRotation(0, 190)
    INFO_GET_ITEM(724, 1)
    Common.SetDigimonGraspState(188, DIGIMON_GRASP_FLAG_JOIN)
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M300:Event_190()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_10_050", "FLAG_MAIN_10_055") then
    Flg.Set("FLAG_MAIN_10_055")
    HideMinimap(true)
    HideGuide(true)
    Obj:new(PLAYER, ""):SetPos(7.17, 6.767, -74.52)
    Obj:new(PLAYER, ""):SetRotationY(200, 0)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    local door_index = GetIndex(FLD_OBJ_LOCATOR, "theater_0001")
    Field.ObjectLoadMotion(FLD_OBJ_LOCATOR, door_index, "e005")
    Cam.Inst:Set(10.404, 7.414, -80.805, 5.736, 8.007, -71.981, default, 0)
    PlaySE(401055, 100)
    WaitFrame(45)
    Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, door_index, "e005", 10, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(80)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Execute("m300_130")
    SetFollowerCameraOperateRotation(0, 10)
    Qst.Main:Set(self.ID, self.STEP_025)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    HideMinimap(false)
    HideGuide(false)
  end
end

function M300:Event_195A()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_10_055", "FLAG_MAIN_10_058") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0360_0010")
    Field.MovePlayerToRelativePosFrame(-0.5, -1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_195B()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_10_055", "FLAG_MAIN_10_058") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0360_0010")
    Field.MovePlayerToRelativePosFrame(1, -0.5, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_195C()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_10_055", "FLAG_MAIN_10_058") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0360_0010")
    Field.MovePlayerToRelativePosFrame(-0.5, 1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M300:Event_200()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_10_055", "FLAG_MAIN_10_058") then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(75)
    end
    Flg.Set("FLAG_MAIN_10_058")
    FieldObjectSync(FOR_ALL, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_StopBGM()
    Execute("m300_135")
    Execute("m300_140")
    MapChangeWithTimeTravel("d", 404, "start_00", AXIS_ORIGINAL, "A2028_daft_310", NOON)
  end
end

function M300:ChapterFlagSet(progress)
  local step = {}
  if 40 <= progress then
    step[#step + 1] = self.STEP_001
    step[#step + 1] = self.STEP_003
    step[#step + 1] = self.STEP_005
  end
  if 41 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 50 <= progress then
    step[#step + 1] = self.STEP_013
  end
  if 60 <= progress then
    step[#step + 1] = self.STEP_015
  end
  Qst.Main:Chapter(step, self.ID)
end
