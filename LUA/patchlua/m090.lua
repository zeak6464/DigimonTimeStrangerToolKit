M090 = {
  ID = 90,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_255 = 255
}

function M090:Event_010()
  if Flg.Check("FLAG_MAIN_03_220", "FLAG_MAIN_03_230") then
    Flg.Set("FLAG_MAIN_03_230")
    Execute("m090_010")
    PlayDungeonBGM()
    SetFollowerCameraOperateRotation(0, 85)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M090:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_03_250")
    Execute("m090_020")
    Field.ObjectCheckSync(FOR_ALL, true)
    WaitFrame(30)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M090:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check("FLAG_MAIN_03_260") then
    Flg.Set("FLAG_MAIN_03_260")
    Execute("m090_030")
    BackFade_In(0, FADE_TIME)
    local pc = Obj:new(PLAYER, "")
    pc:SetPos(0, 0.1, -29.2, false)
    pc:SetRotationY(180, 0)
    SetFollowerCameraOperateRotation(0, 180, 0)
    Obj:new(NPC, "npc_0040"):Invisible()
    FieldObjectSync(NPC, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    OpenTutorial(4011)
    Flg.Set("TUT_FLAG_4811")
    Flg.Set("TUT_FLAG_4812")
  end
end

function M090:Event_031()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M090:Event_032()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0103_0010_0010")
    tlk:Message("f_t0103_0010_0020")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_03_263")
    local npc_0001 = Obj:new(NPC, "npc_0001")
    Field.ObjectLoadMoveMotion(FLD_OBJ_NPC, npc_0001.index, "fr01_01")
    Field.ObjectStandbyMoveMotion(FLD_OBJ_NPC, npc_0001.index, "fr01_01")
    Field.ObjectReleaseMonopolyOnPhysics(FLD_OBJ_NPC, npc_0001.index)
    ColOff("plan_cl_1000")
    npc_0001:SetEnableCheckAndFieldAttack(false)
    if GetControlScriptExternalVariableString("npc0001_state") == "initialize" then
      SetControlScriptExternalVariable("npc0001_state", "move")
      SetControlScriptExternalVariable("player_move_state", "wait")
    end
    if Flg.Check("FLAG_MAIN_03_260", "FLAG_MAIN_03_270") then
      Flg.Set("FLAG_GIMMICK_T01_020")
    end
    SetProhibitPlayerOnlyOperate(true)
    Qst.Main:Set(self.ID, self.STEP_015, false)
  end
end

function M090:Event_033()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) then
    SetControlScriptExternalVariable("player_move_state", "talk_wait")
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0103_0020_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_03_265")
    local npc_0002 = Obj:new(NPC, "npc_0002")
    Field.ObjectLoadMoveMotion(FLD_OBJ_NPC, npc_0002.index, "fr01_01")
    Field.ObjectStandbyMoveMotion(FLD_OBJ_NPC, npc_0002.index, "fr01_01")
    npc_0002:SetEnableCheckAndFieldAttack(false)
    ColOff("plan_cl_1001")
    if GetControlScriptExternalVariableString("npc0002_state") == "initialize" then
      SetControlScriptExternalVariable("npc0002_state", "move")
    end
    Qst.Main:Set(self.ID, self.STEP_020, false)
    SetControlScriptExternalVariable("player_move_state", "move")
  end
end

function M090:Event_034()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    SetControlScriptExternalVariable("player_move_state", "talk_wait")
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0103_0030_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_03_267")
    local npc_0003 = Obj:new(NPC, "npc_0003")
    Field.ObjectLoadMoveMotion(FLD_OBJ_NPC, npc_0003.index, "fr01_01")
    Field.ObjectStandbyMoveMotion(FLD_OBJ_NPC, npc_0003.index, "fr01_01")
    Field.ObjectReleaseMonopolyOnPhysics(FLD_OBJ_NPC, npc_0003.index)
    ColOff("plan_cl_1002")
    npc_0003:SetEnableCheckAndFieldAttack(false)
    if GetControlScriptExternalVariableString("npc0003_state") == "initialize" then
      SetControlScriptExternalVariable("npc0003_state", "move")
    end
    Qst.Main:Set(self.ID, self.STEP_025, false)
    SetControlScriptExternalVariable("player_move_state", "move")
  end
end

function M090:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_03_270") then
    Flg.Set("FLAG_MAIN_03_270")
    Guest.Add(27471)
    SetProhibitPlayerOnlyOperate(false)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(10330100, 171, false)
  end
end

function M090:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and Flg.Check("FLAG_MAIN_03_280") then
    Map:ClosePlace(103, true)
    Guest.Delete(27471)
    Common.SetDigimonGraspState(747, DIGIMON_GRASP_FLAG_SCAN)
    Flg.Set("TUT_FLAG_4510")
    Flg.Set("TUT_FLAG_4511")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 403, "start_03", false, 0, FADE_TIME)
  end
end

function M090:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and Flg.Check("FLAG_MAIN_03_280", "FLAG_MAIN_03_290") then
    Flg.Set("FLAG_MAIN_03_290")
    Execute("m090_070")
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChangeWithTimeTravel("t", 403, "start_03", AXIS_ORIGINAL, "A2020_dbef_91", NIGHT)
  end
end

function M090:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_03_300") then
    Flg.Set("FLAG_MAIN_03_300")
    Obj:new(GIM, "obj_0002"):Invisible()
    Execute("m090_080")
    PlayDungeonBGM()
    local pc = Obj:new(PLAYER, "")
    SetFollowerCameraOperateRotation(10, pc.rot_y + 30)
    Obj:new(GIM, "obj_0002"):CancelInvisible()
    pc:SetPos(0.914, 0, 0.102)
    pc:SetRotationY(pc.rot_y + 20, 0)
    FieldObjectSync(FOR_ALL, true)
    Fade_In(0, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_030)
    Digitter.Send(1090060010)
  end
end

function M090:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) then
    local tlk = Tlk:new("t04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0403_0210_0010")
    tlk:MessageClose()
    tlk:Select(2, "f_t0403_0210_0020")
    Flg.Set("PLACE_CLOSE_ALTA")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      Flg.Set("FLAG_MAIN_03_310")
      Field.ObjectCheckSync(FOR_ALL, true)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Qst.Main:End(self.ID, self.STEP_255)
      Restore.Party()
      if 1 > Common.GetGameClearNum() then
        Common.SetAegiomonFriendship(9)
      end
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      MapChangeWithTimeTravel("t", 404, "start_01", AXIS_ORIGINAL, "A2020_dbef_100", NOON)
    else
      MovePlayerToRelativePosFrame(-2, 0, 30)
      Field_Talk_End()
    end
  end
end

function M090:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 41 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_025
  end
  if 81 <= progress then
    step[#step + 1] = self.STEP_030
  end
  Qst.Main:Chapter(step, self.ID)
end
