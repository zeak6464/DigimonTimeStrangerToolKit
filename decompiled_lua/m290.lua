gGimText = "field_text"
M290 = {
  ID = 290,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}

function M290:Event_010()
  if Flg.Check("FLAG_MAIN_09_090", "FLAG_MAIN_10_000") then
    Flg.Set("FLAG_MAIN_10_000")
    Map:OpenArea(104, true)
    Map:CloseArea(104, false)
    Map:OpenPlace(10401, false)
    Map:OpenPlace(10412, true)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M290:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) then
    Digitter.Send(1285070010)
  end
end

function M290:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_000", "FLAG_MAIN_10_001") then
    Flg.Set("FLAG_MAIN_10_001")
    Execute("m290_010")
    Guest.Delete(GST_VENUS)
    SetFollowerCameraOperateRotation(0, 160)
  end
end

function M290:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_001", "FLAG_MAIN_10_002") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_10_002")
    Execute("m290_020")
    Execute("m290_030")
    PlayDungeonBGM()
    SetFollowerCameraOperateRotation(0, 20)
  end
end

function M290:Event_033()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_002", "FLAG_MAIN_10_006") then
    Flg.Set("FLAG_MAIN_10_006")
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
  end
end

function M290:Event_036()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_006", "FLAG_MAIN_10_007") then
    Cam.Inst:Set(17.76, -4.19, -13.5, 19.68, -5.26, -3.74, default, 30)
    WaitFrame(30)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0402_0100_0010")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    EncountFromField_PlaySound(11020010, 10471, false)
  end
end

function M290:Event_037()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) and Flg.Check("FLAG_MAIN_10_007", "FLAG_MAIN_10_008") then
    WaitFrame(15)
    Field_InvisibleFollowerAllGuest(0, 1, false)
    Field_InvisibleFollowerAllPartyMember(0, 1, false)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 80, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 16.691, -6.073, -17.775)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(PLAYER, 1), 0)
    Motion.Player:Play("fn01_01", 0, true)
    Cam.Inst:Set(21.495691, -4.338181, -21.391273, 15.409416, -5.465409, -13.517191, default, 1)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0402_0100_0020")
    tlk:Message("f_d0402_0100_0030")
    tlk:Message("f_d0402_0100_0040")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(PLAYER, ""):SetRotationY(45, 0)
    SetFollowerCameraOperateRotation(0, 20)
    WaitFrame(15)
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_10_008")
    Guest.Add(GST_GRIFFIN)
    Common.SetDigimonGraspState(83, DIGIMON_GRASP_FLAG_SCAN)
    INFO_WINDOW(7034)
    FieldObjectSync(FOR_ALL, true)
    Cam.Inst:Clear(1)
    WaitFrame(15)
    Qst.Main:Set(self.ID, self.STEP_003)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Digitter.Send(1290030010)
  end
end

function M290:Event_038A()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Digitter.Send(1290040010)
  end
end

function M290:Event_038B()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Digitter.Send(1290050010)
  end
end

function M290:Event_038C()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Digitter.Send(1290060010)
  end
end

function M290:Event_039A()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_10_008", "FLAG_MAIN_10_003") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0402_0110_0010")
    Field.MovePlayerToRelativePosFrame(1, -0.5, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M290:Event_039B()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_10_008", "FLAG_MAIN_10_003") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0402_0110_0010")
    Field.MovePlayerToRelativePosFrame(0, -1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M290:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_10_002", "FLAG_MAIN_10_003") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_10_003")
    Execute("m290_040")
    Guest.Delete(GST_GRIFFIN)
    FollowerSync()
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M290:Event_045A()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_10_003", "FLAG_MAIN_10_004") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0260_0010")
    Field.MovePlayerToRelativePosFrame(-0.5, -1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M290:Event_045B()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_10_003", "FLAG_MAIN_10_004") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0260_0010")
    Field.MovePlayerToRelativePosFrame(1, -1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M290:Event_045C()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_10_003", "FLAG_MAIN_10_004") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0260_0010")
    Field.MovePlayerToRelativePosFrame(-0.5, 1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M290:Event_045D()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_10_003", "FLAG_MAIN_10_004") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0260_0010")
    Field.MovePlayerToRelativePosFrame(0.5, 1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M290:Event_045E()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_10_003", "FLAG_MAIN_10_004") then
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0260_0010")
    Field.MovePlayerToRelativePosFrame(1, -0.5, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M290:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_10_003", "FLAG_MAIN_10_004") then
    Flg.Set("FLAG_MAIN_10_004")
    Execute("m290_050")
    FieldObjectSync(NPC, false)
    SetFollowerCameraOperateRotation(5, 10)
    Qst.Main:Set(self.ID, self.STEP_010)
    Obj:new(FLD_OBJ_GIMMICK, "access_point_1"):Invisible()
    Digitter.Send(1290070010)
  end
end

function M290:Event_051()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Digitter.Send(1290080010)
  end
end

function M290:Event_053()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_10_004", "FLAG_MAIN_10_009") then
    local tlk = Tlk:new("d04", 1, true)
    HideMinimap(true)
    HideGuide(true)
    local bn01 = Motion.Object:new(NPC, "npc_0003", "bn01")
    local bn02 = Motion.Object:new(NPC, "npc_0003", "bn02")
    local fe02 = Motion.Object:new(NPC, "npc_0003", "fe02")
    Cam.Inst:Set(-1.394368, 4.649992, -14.283975, -1.805789, 2.489369, -24.039099, default, 30)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    bn02:Play(30, true)
    tlk:Message("f_d0407_0070_0010")
    MessageClose()
    WaitFrame(30)
    fe02:Play2Wait(10, false)
    bn01:Play(10, true)
    tlk:Message("f_d0407_0070_0020")
    WaitFrame(20)
    tlk:Message("f_d0407_0070_0030")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_10_009")
    EncountFromField_PlaySound(11020030, BTL_MAP_BACCHUS_FOREST3, true)
  end
end

function M290:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_10_009", "FLAG_MAIN_10_009B") then
    HideMinimap(true)
    HideGuide(true)
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Set(9.707, 3.856, 11.75, 17.439, 0.7145, 17.25, default, 1)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    local bn01 = Motion.Object:new(NPC, "npc_0004", "bn01")
    local bn02 = Motion.Object:new(NPC, "npc_0004", "bn02")
    local fe02 = Motion.Object:new(NPC, "npc_0004", "fe02")
    Obj:new(NPC, "npc_0004"):SetRotationY(0, 0)
    Obj:new(PLAYER, ""):SetPos(13.183, 0.04, 16.114, true)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "npc_0004", 0)
    Obj:new(NPC, "npc_0004"):SetRotationYToObject(PLAYER, "", 0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_10_009B")
    local tlk = Tlk:new("d04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0407_0070_0040")
    tlk:Message("f_d0407_0070_0050")
    MessageClose()
    WaitFrame(30)
    fe02:Play2Wait(10, false)
    bn01:Play(20, true)
    tlk:Message("f_d0407_0070_0060")
    bn02:Play(20, true)
    Cam.Inst:Clear(30)
    SetFollowerCameraOperateRotation(5, -20, 0)
    WaitFrame(30)
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    FieldObjectSync(FOR_ALL, false)
    Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  end
end

function M290:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_10_004", "FLAG_MAIN_10_005") then
    Flg.Set("FLAG_MAIN_10_005")
    Execute("m290_060")
    Qst.Main:Set(self.ID, self.STEP_015)
    MapChangeWithTimePasses("t", 3001, "start_00", NIGHT)
  end
end

function M290:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) and Flg.Check("FLAG_MAIN_10_005", "FLAG_MAIN_10_010") then
    Flg.Set("FLAG_MAIN_10_010")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m290_070")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M290:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) and Flg.Check("FLAG_MAIN_10_010", "FLAG_MAIN_10_015") then
    Qst.Main:End(self.ID, self.STEP_255)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(72)
    end
    Flg.Set("FLAG_MAIN_10_015")
    Execute("m290_080")
    Execute("m290_090")
    Execute("m290_100")
    MapChangeWithTimeTravel("d", 402, "start_07", AXIS_ORIGINAL, "P2028_daft_300", NOON)
  end
end

function M290:ChapterFlagSet(progress)
  local step = {}
  if 10 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_003
  end
  if 50 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 60 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 70 <= progress then
    step[#step + 1] = self.STEP_015
  end
  Qst.Main:Chapter(step, self.ID)
end
