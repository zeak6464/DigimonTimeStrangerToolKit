local gGimText = "field_text"
M010 = {
  ID = 10,
  STEP_001 = 1,
  STEP_002 = 2,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_007 = 7,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_016 = 16,
  STEP_017 = 17,
  STEP_018 = 18,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_255 = 255,
  Battle = {
    Enemy = {
      gotu = 10101300,
      inp = 10101200,
      mono = 10101100
    },
    Map = {m01 = 11071}
  }
}

function M010:Event_010()
  if not Flg.Check("FLAG_MAIN_01_010") and not Qst.Main:Check(self.ID, self.STEP_001) then
    Flg.Set("FLAG_MAIN_01_000")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
    if Common.GetGameClearNum() >= 1 then
      Common.SetExistPartyAegiomon(false)
    end
    SystemFlag.SetFieldKeyHelpForNewGame()
    SystemFlag.SetProhibitAutoRegeneration()
    Map:OpenArea(1, true)
    Map:OpenArea(3, true)
    Map:OpenPlace(101, true)
    Map:OpenPlace(102, true)
    Map:OpenPlace(151, true)
    Map:OpenPlace(152, true)
    Map:OpenPlace(153, true)
    Map:OpenPlace(351, true)
    FadeAllIn(FADE_WHITE, FADE_TIME)
    Field_StopBGM()
    Execute("m010_001")
    MapChangeWithTimeTravel("t", 3002, "start_00", AXIS_ORIGINAL, "X2028_daft_10", NOON)
  end
end

function M010:Event_020()
  if not Flg.Check("FLAG_MAIN_01_010") and not Qst.Main:Check(self.ID, self.STEP_001) then
    Sound.StopBGM(0)
    Sound.StopSE(Work.Get(Field_BackSE_Slot_Num), 0)
    Flg.Set("FLAG_MAIN_01_010")
    FadeAllIn(FADE_WHITE, FADE_TIME)
    Field.OverrideSeamlessTargetMap("t", 101)
    Execute("m010_010")
    Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
    MapChange("t", 101, "start_20", false, FADE_BLACK, FADE_TIME)
  end
end

function M010:Event_030()
  if Flg.Check("FLAG_MAIN_01_000", "FLAG_MAIN_01_020") and not Qst.Main:Check(self.ID, self.STEP_001) then
    Flg.Set("FLAG_MAIN_01_020")
    Field_StopBGM()
    Execute("m010_020")
    Qst.Main:Start(self.ID, self.STEP_001)
    PlayDungeonBGM()
  end
end

function M010:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_002) then
    Qst.Main:Set(self.ID, self.STEP_002)
    Digitter.Send(1010010010)
  end
end

function M010:Event_038()
  if Qst.Main:Check(self.ID, self.STEP_002, self.STEP_003) then
    Qst.Main:Set(self.ID, self.STEP_003)
  end
end

function M010:Event_039()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Digitter.Send(1010020010)
  end
end

function M010:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_002, self.STEP_005) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m010_040")
    Flg.Set("FLAG_MAIN_01_030")
    Qst.Main:Set(self.ID, self.STEP_005)
    local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
    SetFollowerCameraOperateRotation(0, rot, 30)
  end
end

function M010:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_007) then
    Field.DisableMenu()
    Common.ProhibitSave()
    Qst.Main:Set(self.ID, self.STEP_007, false)
  end
end

function M010:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_007, self.STEP_010) then
    Flg.Set("FLAG_MAIN_01_050")
    Field.ObjectCancelSuspendAutoTransparentForCamera(PLAYER, 1)
    FieldObjectSync(FLD_OBJ_GIMMICK, false)
    Execute("m010_060")
    Flg.Clear("FLAG_GIMMICK_T01_070")
    Obj:new(NPC, "npc_0008"):Invisible()
    Obj:new(NPC, "npc_0001"):Invisible()
    Obj:new(NPC, "npc_0002"):Invisible()
    Obj:new(NPC, "npc_0006"):Invisible()
    Obj:new(NPC, "npc_0008"):Invisible()
    Obj:new(NPC, "npc_0009"):Invisible()
    Obj:new(NPC, "npc_0007"):CancelInvisible()
    Obj:new(NPC, "npc_0011"):CancelInvisible()
    Execute("m010_070")
    FieldObjectSync(OGIM, false)
    Field.CancelDisableMenu()
    Common.CancelProhibitSave()
    Qst.Main:Set(self.ID, self.STEP_010)
    FieldObjectSync(FOR_ALL, false)
    Obj:new(MOB, "AfterQuakeMob_1"):CancelInvisible()
  end
end

function M010:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    RegularQuake_Stop()
    Qst.Main:Set(self.ID, self.STEP_015)
    Flg.Set("FLAG_MAIN_01_060")
    Common.SetDigimonGraspState(343, DIGIMON_GRASP_FLAG_JOIN)
    Common.SetDigimonGraspState(97, DIGIMON_GRASP_FLAG_JOIN)
    Common.SetDigimonGraspState(96, DIGIMON_GRASP_FLAG_JOIN)
    Flg.Set("TUT_FLAG_4724")
    Item.Add(1, 1)
    Item.Add(7, 1)
    Execute("m010_080")
    Execute("m010_090")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Obj:new(PLAYER, ""):SetRotationY(280, 0)
    SetFollowerCameraOperateRotation(0, 275)
    SystemFlag.SetProhibitAutoRegeneration()
    FollowerSync()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_016)
  end
end

function M010:Event_090()
  if Flg.Check("FLAG_MAIN_01_070", "FLAG_MAIN_01_080") then
    Flg.Set("FLAG_MAIN_01_080")
    Field.CancelDisableSystemFieldAttack()
    Field.CancelDisableAnalyzeAndFieldAttack()
    SystemFlag.ClearFieldKeyHelpForNewGame()
    Field.SetFollowerCameraOperateRotationX(12, 15)
    local tlk = Tlk:new("d10", 1, true)
    tlk:StartTalk()
    AnswerTheCall()
    tlk:Message("f_d1003_0020_0005")
    tlk:Message("f_d1003_0020_0010")
    tlk:Message("f_d1003_0020_0020")
    tlk:EndTalk()
    EndTheCall()
    OpenTutorial(3002)
    Flg.Set("TUT_FLAG_4702")
    Flg.Set("TUT_FLAG_4713")
    Flg.Set("TUT_FLAG_4703")
    Flg.Set("TUT_FLAG_4524")
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  end
end

function M010:Event_092()
  if Qst.Main:Check(self.ID, self.STEP_016, self.STEP_017) then
    Qst.Main:Set(self.ID, self.STEP_017)
  end
end

function M010:Event_094()
  if Qst.Main:Check(self.ID, self.STEP_017, self.STEP_018) then
    Qst.Main:Set(self.ID, self.STEP_018)
  end
end

function M010:Event_096()
  if Qst.Main:Check(self.ID, self.STEP_018, self.M020) then
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M010:Event_091()
end

function M010:Event_100()
  if not Flg.Check("FLAG_MAIN_01_090") and Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Flg.Set("FLAG_MAIN_01_090")
    Execute("m010_150")
    local pc = Obj:new(PLAYER, "")
    SetFollowerCameraOperateRotation(0, pc.rot_y, 30)
    Field.CancelDisableSystemFieldAttack()
    Field.CancelDisableAnalyzeAndFieldAttack()
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M010:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Qst.Main:Set(self.ID, self.STEP_030)
    Digitter.Send(1010080020)
    RegularQuake_Start(0.02, 0, 60, 120)
    SetQuakeEffect("ef_f_com_220_cr")
  end
end

function M010:Event_120()
  if Flg.Check("FLAG_MAIN_01_090") and not Flg.Check("FLAG_MAIN_01_250") then
    local tlk = Tlk:new("d10")
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1003_0010_0010")
    if not Flg.Check("FLAG_GIMMICK_D10_100") then
      Cam.Inst:Set(46.407, -0.141, 21.485, 55.667, 2.332, 24.337, DEFAULT_ANGLE, 30)
      WaitFrame(30)
      tlk:Message("f_d1003_0010_0020")
      Cam.Inst:Clear(30)
      WaitFrame(30)
    end
    Field.MovePlayerToRelativePosFrame(-2, 0, 20)
    tlk:EndTalk()
  end
end

function M010:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    RegularQuake_Stop()
    Cam.Inst:Set(41.796, 1.704, 4.418, 46.354, 1.725, -4.482, DEFAULT_ANGLE, 30)
    WaitFrame(40)
    Quake_Start(0.1, 0, 30)
    PlaySE(202001, 100)
    SetQuakeEffect("ef_f_com_220_cr")
    WaitFrame(30)
    ClearQuakeEffect()
    Quake_Stop()
    WaitFrame(30)
    Cam.Inst:Clear(30)
    WaitFrame(30)
    RegularQuake_Start(0.02, 0, 60, 120)
  end
end

function M010:Event_135()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and not Flg.Check("FLAG_MAIN_01_105") then
    Flg.Set("FLAG_MAIN_01_105")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_FIELD_D10_010")
    local rot = Obj:new(PLAYER, "").rot_y
    local vec = GetUnitVector2D(rot)
    MovePlayerToRelativePosFrame(vec.x * 3, vec.z * 3, 10)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    MapChangeWithTimeTravel("d", 1001, "start_00", AXIS_ORIGINAL, "X2028_daft_11", MORNING)
  end
end

function M010:Event_140()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_01_105", "FLAG_MAIN_01_110") then
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0002"), false)
    Sound.StopBGM(3.75)
    StopSE(Work.Get(Field_BackSE_Slot_Num), 15)
    Sound.PlayBGM(10, 3)
    Execute("m010_180")
    SetPlayerLocator("start_51")
    SetPlayerRotationByLocator("sp_0004", 0)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    SetControlScriptExternalVariable("mgreymon_state", "start")
    SetFollowerCameraOperateRotation(-15, 90)
    Field.CameraZoomFrame(1, -0.5, 0, 0)
    SetEnableCameraOperate(false)
    RegularQuake_Stop()
    SetProhibitPlayerOnlyOperate(true)
    ColOn("wall_cl_1010")
    Obj:new(FLD_OBJ_LOCATOR, "obj_0013"):CancelInvisible()
    Obj:new(FLD_OBJ_LOCATOR, "obj_0014"):CancelInvisible()
    Obj:new(FLD_OBJ_LOCATOR, "obj_0001"):Invisible()
    ColOff("wall_cl_1000")
    Motion.Player:Play("fn01_01", 15, true)
    Qst.Main:Set(self.ID, self.STEP_035)
    Flg.Set("FLAG_FIELD_D10_012")
    Flg.Set("FLAG_FIELD_D10_013")
    local index = Field.GetSymbolEnemyIndex("chr327_chaser")
    Field.ObjectFrameMove2D(FLD_OBJ_SYMBOL_ENEMY, index, 270, 8, 30)
    RegularQuake_Start(0.035, 0, 10, 15)
    SetQuakeEffect("ef_f_com_220_cr")
  end
end

function M010:Event_150()
  if not Flg.Check("FLAG_MAIN_01_110") then
    Flg.Set("FLAG_GIMMICK_D10_060")
    local index = Field.GetSymbolEnemyIndex("chr327_chaser")
    Field.ObjectFrameMove2D(FLD_OBJ_SYMBOL_ENEMY, index, 285, 8, 30)
    Flg.Clear("FLAG_FIELD_D10_013")
    RegularQuake_Stop()
    Sound.StopBGM(1)
    Execute("m010_190")
    Flg.Set("FLAG_MAIN_01_110")
    Flg.Clear("FLAG_FIELD_D10_012")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChangeWithTimeTravel("d", 1001, "start_00", AXIS_ORIGINAL, "X2028_daft_20", NOON)
  end
end

function M010:Event_155()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_255) and Flg.Check("FLAG_MAIN_01_110") then
    SetFollowerCameraOperateRotation(10, 290)
    SetEnableCameraOperate(true)
    Field.CameraZoomUndo()
    SetProhibitPlayerOnlyOperate(false)
    Obj:new(FLD_OBJ_LOCATOR, "obj_0008"):Invisible()
    Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):Invisible()
    Obj:new(FLD_OBJ_LOCATOR, "obj_0010"):Invisible()
    Obj:new(FLD_OBJ_LOCATOR, "obj_0011"):Invisible()
    Obj:new(FLD_OBJ_LOCATOR, "obj_0012"):Invisible()
    ColOff("plan_cl_4000")
    ColOff("plan_cl_4001")
    ColOff("plan_cl_4002")
    ColOff("plan_cl_4003")
    ColOff("plan_cl_4004")
    self:Event_160()
  end
end

function M010:Event_160()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_255) and Flg.Check("FLAG_MAIN_01_110") then
    Field.SetPlayerStealthFromSymbolEnemy(true)
    Execute("m010_200")
    Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
    Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
    RegularQuake_Start(0.01, 0, 30, 180)
    SetQuakeEffect("ef_f_com_220_cr")
    SetControlScriptExternalVariable("mgreymon_state", "relocation")
    self:Event_170()
  end
end

function M010:Event_170()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_255) then
    Qst.Main:End(self.ID, self.STEP_255)
    Common.SetTimeTravelRecord(TIME_TRAVEL_RECORD_ORIGINAL, "X2028_daft_20", NOON, 2)
    M020:Event_010()
  end
end

function M010:ChapterFlagSet(progress)
  local step = {}
  if 40 <= progress then
    step[#step + 1] = self.STEP_001
    step[#step + 1] = self.STEP_002
    step[#step + 1] = self.STEP_003
  end
  if 80 <= progress then
    step[#step + 1] = self.STEP_005
    step[#step + 1] = self.STEP_007
    step[#step + 1] = self.STEP_010
  end
  if 150 <= progress then
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_016
    step[#step + 1] = self.STEP_017
    step[#step + 1] = self.STEP_018
    step[#step + 1] = self.STEP_020
  end
  if 160 <= progress then
    step[#step + 1] = self.STEP_025
    step[#step + 1] = self.STEP_030
  end
  if 200 <= progress then
    step[#step + 1] = self.STEP_035
  end
  Qst.Main:Chapter(step, self.ID)
end
