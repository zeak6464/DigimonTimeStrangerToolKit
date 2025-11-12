M110 = {
  ID = 110,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_007 = 7,
  STEP_010 = 10,
  STEP_011 = 11,
  STEP_012 = 12,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_255 = 255
}

function M110:Event_010()
  if Flg.Check("FLAG_MAIN_03_380", "FLAG_MAIN_03_390") then
    Execute("m110_010")
    Flg.Set("FLAG_MAIN_03_390")
    WaitFrame(15)
    Field.ObjectCheckSync(FOR_ALL, true)
    Qst.Main:Start(self.ID, self.STEP_001)
    SetFollowerCameraOperateRotation(0, 85)
    Obj:new(PLAYER, ""):SetRotationY(90, 0)
    Flg.Clear("FLAG_IS_MAPCHANGE_USING_DOOR")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M110:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) then
    Qst.Main:Set(self.ID, self.STEP_003)
    Fade_OutNoLoadingWithWait(FADE_BLACK, 30)
    MapChangeWithTimeTravel("t", 404, "start_01", AXIS_ORIGINAL, "A2020_dbef_111", NIGHT)
  end
end

function M110:Event_018()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and not Flg.Check("FLAG_MAIN_03_401") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    PlayRestJingle()
    Fade_OutNoLoadingWithWait(FADE_BLACK, 0)
    Party.Aegiomon.SetExist(true)
    Flg.Set("FLAG_MAIN_03_395")
    Flg.Set("FLAG_MAIN_03_401")
    WaitFrame(150)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("t04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0403_0170_0010")
    tlk:Message("f_t0403_0170_0015")
    tlk:EndTalk()
  end
end

function M110:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and not Flg.Check("FLAG_MAIN_03_402") then
    Flg.Clear("FLAG_IS_MAPCHANGE_USING_DOOR")
    Fade_OutNoLoadingWithWait(FADE_BLACK, 0)
    WaitFrame(90)
    Flg.Set("FLAG_MAIN_03_402")
    local tlk = Tlk:new("t04", 1, true)
    local pc = Obj:new(PLAYER, "")
    local minelva = Obj:new(NPC, "npc_0011")
    local heroine = Obj:new(NPC, "npc_0012")
    local aegio = Obj:new(NPC, "npc_0013")
    local npc01_index = GetIndex(NPC, "npc_0022")
    Field.ObjectLoadMotion(NPC, npc01_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc01_index, "e007")
    Field.ObjectLoadMotion(NPC, npc01_index, "e008")
    Field.ObjectLoadMotion(NPC, npc01_index, "e006")
    Field.ObjectLoadMotion(NPC, npc01_index, "e021")
    Field.ObjectLoadMotion(NPC, npc01_index, "e002")
    Field.ObjectLoadMotion(NPC, npc01_index, "e033")
    Field.ObjectLoadExpression(NPC, npc01_index, "E02_M08")
    Field.ObjectLoadExpression(NPC, npc01_index, "E02_M01")
    Field.ObjectLoadExpression(NPC, npc01_index, "E05_M07")
    local npc02_index = GetIndex(NPC, "npc_0012")
    Field.ObjectLoadMotion(NPC, npc02_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc02_index, "e021")
    local npc03_index = GetIndex(NPC, "npc_0011")
    Field.ObjectLoadMotion(NPC, npc03_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc03_index, "e002")
    Field.ObjectLoadMotion(NPC, npc03_index, "e012")
    Field.ObjectLoadMotion(NPC, npc03_index, "e004")
    local npc04_index = GetIndex(NPC, "npc_0013")
    Field.ObjectLoadMotion(NPC, npc04_index, "fn01_01")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.DisableMenu()
    Field.DisableSystemFieldAttack()
    Field.DisableSystemDigimonChat()
    Cam.Inst:Set(8.273, 0.65, 3.51, -0.828, 1.342, -0.573, default, 0)
    minelva:SuspendAutoTransparentForCamera()
    local hiroko = Obj:new(NPC, "npc_0022")
    pc:SetPos(0.03, 0, 0.29, false)
    Field.ObjectPlayMotion(PLAYER, 1, "e012", 10, true)
    Field.ObjectPlayMotion(NPC, npc01_index, "fn01_01", 10, true)
    Field.ObjectPlayMotion(NPC, npc03_index, "fn01_01", 10, true)
    local p_y_degree = GetAngleToTarget2D(0.03, 0.29, hiroko.pos.x, hiroko.pos.z)
    local m_y_degree = GetAngleToTarget2D(minelva.pos.x, minelva.pos.z, hiroko.pos.x, hiroko.pos.z)
    local h_y_degree = GetAngleToTarget2D(heroine.pos.x, heroine.pos.z, hiroko.pos.x, hiroko.pos.z)
    local a_y_degree = GetAngleToTarget2D(aegio.pos.x, aegio.pos.z, aegio.pos.x, aegio.pos.z)
    minelva:SetRotationY(m_y_degree, 0)
    heroine:SetRotationY(h_y_degree, 0)
    aegio:SetRotationY(a_y_degree, 0)
    pc:SetRotationY(p_y_degree, 0)
    WaitFrame(40)
    FadeAllInWithWait(FADE_BLACK, FADE_BLACK)
    tlk:StartTalkAndCancelDigimonRide()
    Field.CancelDisableMenu()
    Field.CancelDisableSystemFieldAttack()
    Field.CancelDisableSystemDigimonChat()
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, npc01_index, "e007", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M08", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0403_0170_0020")
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    Field.ObjectPlayMotion(NPC, npc03_index, "e012", 10, true)
    tlk:Message("f_t0403_0170_0030")
    Field.ObjectPlayMotion(NPC, npc03_index, "e004", 10, true)
    tlk:Message("f_t0403_0170_0040")
    Field.ObjectPlayMotion(NPC, npc03_index, "fn01_01", 10, true)
    Field.ObjectPlayMotion(NPC, npc01_index, "e008", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M08", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0403_0170_0050")
    Field.ObjectPlayMotion(NPC, npc01_index, "e006", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E05_M07", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0403_0170_0060")
    Field.ObjectChangeExpression(NPC, npc01_index, "E05_M07", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    Field.ObjectPlayMotion(NPC, npc02_index, "e021", 10, true)
    tlk:Message("f_t0403_0170_0070")
    Field.ObjectPlayMotion(NPC, npc02_index, "fn01_01", 10, true)
    Field.ObjectPlayMotion(NPC, npc01_index, "e007", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M08", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0403_0170_0080")
    Field.ObjectPlayMotion(NPC, npc01_index, "e021", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M08", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0403_0170_0090")
    Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M08", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0403_0170_0100")
    Field.ObjectPlayMotion(NPC, npc01_index, "fn01_01", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    Field.ObjectPlayMotion(NPC, npc03_index, "e002", 10, true)
    tlk:Message("f_t0403_0170_0110")
    Field.ObjectPlayMotion(NPC, npc03_index, "fn01_01", 10, true)
    Field.ObjectPlayMotion(NPC, npc01_index, "e033", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M08", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:Message("f_t0403_0170_0120")
    Field.ObjectChangeExpression(NPC, npc01_index, "E02_M01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_SYNC_WITH_MOTION, 15)
    tlk:MessageClose()
    WaitFrame(15)
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_03_400")
    Guest.Add(GST_HIROKO)
    Guest.Add(GST_HEROINE)
    Guest.Add(GST_MINERVAMON_2)
    Cam.Inst:Clear(0)
    tlk:EndTalk()
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 10, true)
    SetFollowerCameraOperateRotation(0, 85)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    INFO_WINDOW(7010)
    FieldObjectSync(FOR_ALL, true)
    minelva:CancelSuspendAutoTransParentForCamera()
    minelva:Invisible()
    hiroko:Invisible()
    heroine:Invisible()
    aegio:Invisible()
    Qst.Main:Set(self.ID, self.STEP_005)
    WaitFrame(90)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M110:Event_023()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_006) and not Flg.Check("FLAG_MAIN_03_403") then
    Flg.Set("FLAG_MAIN_03_403")
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0105_0030_0010")
    tlk:EndTalk()
  end
end

function M110:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_006) then
    Qst.Main:Set(self.ID, self.STEP_006)
  end
end

function M110:Event_027()
  if Qst.Main:Check(self.ID, self.STEP_006, self.STEP_007) then
    Qst.Main:Set(self.ID, self.STEP_007)
  end
end

function M110:Event_028()
  if Qst.Main:Check(self.ID, self.STEP_007, self.STEP_010) then
    Execute("m110_030")
    Guest.Delete(GST_HIROKO)
    Flg.Set("FLAG_MAIN_03_406")
    FieldObjectSync(FOR_ALL, true)
    Qst.Main:Set(self.ID, self.STEP_010)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local gim_index = GetIndex(FLD_OBJ_LOCATOR, "gim_0001")
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, gim_index, true)
    Digitter.Send(1110030010)
  end
end

function M110:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_011) and Flg.Check("FLAG_MAIN_03_400", "FLAG_MAIN_03_410") then
    Execute("m110_020")
    Flg.Set("FLAG_MAIN_03_410")
    Flg.Set("FLAG_MAIN_03_420")
    Qst.Main:Set(self.ID, self.STEP_011)
  end
end

function M110:Event_033()
  if Qst.Main:Check(self.ID, self.STEP_011, self.STEP_012) then
    Qst.Main:Set(self.ID, self.STEP_012)
  end
end

function M110:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_012, self.STEP_015) then
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M110:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) then
    if Common.IsChunkLoaded() == false then
      OpenInfoWindow(90000)
    elseif Flg.Check("FLAG_MAIN_03_420", "FLAG_MAIN_03_425") then
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d1103_0020_0010")
      tlk:Message("f_d1103_0020_0020")
      tlk:EndTalk()
      Flg.Set("FLAG_MAIN_03_422")
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(true)
    end
  end
end

function M110:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_03_420", "FLAG_MAIN_03_425") then
    local wall = Obj:new(FLD_OBJ_LOCATOR, "obj_0001")
    wall:Invisible()
    ColOff("wall_cl_0001")
    SetEnableGimmickCheck("obj_0001", false)
    SetEnableGimmickCheck("gim_0001", false)
    Execute("m110_040")
    Flg.Set("FLAG_MAIN_03_425")
    Qst.Main:Set(self.ID, self.STEP_020)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M110:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_255) then
    Flg.Set("FLAG_MAIN_03_430")
    Execute("m110_050")
    self:Event_100()
  end
end

function M110:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_255) and not Flg.Check("FLAG_MAIN_03_440") then
    EncountFromField(10330300, 11173, false)
  end
end

function M110:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_255) and Flg.Check("FLAG_MAIN_03_440", "FLAG_MAIN_03_450") then
    Field_StopBGM()
    Fade_OutNoLoadingWithWait(FADE_BLACK, 0)
    Flg.Set("FLAG_MAIN_03_450")
    Guest.Delete(27472)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(15)
    end
    Qst.Main:End(self.ID, self.STEP_255)
    MapChangeWithTimeTravel("d", 216, "start_01", AXIS_ORIGINAL, "A2020_dbef_120", NOON)
  end
end

function M110:ChapterFlagSet(progress)
  local step = {}
  if 11 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 20 <= progress then
    step[#step + 1] = self.STEP_003
    step[#step + 1] = self.STEP_005
    step[#step + 1] = self.STEP_006
    step[#step + 1] = self.STEP_007
    step[#step + 1] = self.STEP_010
  end
  if 50 <= progress then
    step[#step + 1] = self.STEP_011
    step[#step + 1] = self.STEP_012
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_025
    step[#step + 1] = self.STEP_030
    step[#step + 1] = self.STEP_035
  end
  Qst.Main:Chapter(step, self.ID)
end
