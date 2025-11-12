M050 = {
  ID = 50,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_016 = 16,
  STEP_018 = 18,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_040 = 40,
  STEP_255 = 255
}

function M050:Event_010()
  if Flg.Check("FLAG_MAIN_02_070", "FLAG_MAIN_03_010") and not Qst.Main:Check(self.ID, self.STEP_001) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Map:OpenPlace(103, true)
    Map:OpenPlace(301, true)
    Restore.Party()
    Execute("m050_010")
    PlayDungeonBGM()
    Flg.Set("FLAG_MAIN_03_005")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M050:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_03_010")
    Obj:new(NPC, "npc_0020"):SuspendAutoTransparentForCamera()
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Execute("m050_020")
    local door = Obj:new(FLD_OBJ_LOCATOR, "change_0001")
    door:CancelInvisible()
    SetEnableGimmickCheck("change_0001", true)
    local player = Obj:new(PLAYER, "")
    SetFollowerCameraOperateRotation(0, player.rot_y + 20)
    WaitFrame(5)
    Qst.Main:Set(self.ID, self.STEP_005)
    WaitFrame(Util.SecondFromFrame(660))
    Obj:new(NPC, "npc_0020"):CancelSuspendAutoTransParentForCamera()
  end
end

function M050:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local father = GetIndex(NPC, "npc_0001")
    Flg.Clear("FLAG_IS_MAPCHANGE_USING_DOOR")
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Map:OpenArea(3, true)
    Map:OpenPlace(301, true)
    Map:OpenPlace(302, true)
    Execute("m050_030")
    Field.ObjectInvisible(NPC, father, 0, 0, false)
    local player = Obj:new(PLAYER, "")
    SetFollowerCameraOperateRotation(0, player.rot_y + 10)
    Qst.Main:Set(self.ID, self.STEP_010)
    Flg.Set("FLAG_MAIN_03_020")
    Digitter.Send(1050020010)
  end
end

function M050:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new("t01", 1, true)
    local npc_0006 = Obj:new(NPC, "npc_0006")
    local Mob01_e013 = Motion.Object:new(NPC, "npc_0006", "e013")
    local Mob01_e012 = Motion.Object:new(NPC, "npc_0006", "e012")
    local Mob01_e006 = Motion.Object:new(NPC, "npc_0006", "e006")
    local Mob01_e002 = Motion.Object:new(NPC, "npc_0006", "e002")
    local Mob01_e004 = Motion.Object:new(NPC, "npc_0006", "e004")
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    Digitter.Send(1050035005, true, true)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Obj:new(PLAYER, ""):SetPos(33.223, 0, -13, true)
    Obj:new(PLAYER, ""):SetRotationY(330, 0)
    Obj:new(PLAYER, ""):LookAtTheObject(NPC, "npc_0006", 15)
    SetFollowerCameraOperateRotation(0, 150, 0)
    Cam.Inst:Set(34.565, 1.696, -3.844, 32.823, 1.462, -13.69, default, 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Mob01_e012:Play(10, false)
    npc_0006:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message("f_t0108_0010_0010")
    tlk:Message("f_t0108_0010_0020")
    Mob01_e006:Play(10, false)
    tlk:Message("f_t0108_0010_0030")
    Mob01_e002:Play(10, false)
    tlk:Message("f_t0108_0010_0040")
    Mob01_e004:Play(10, false)
    tlk:Message("f_t0108_0010_0050")
    Mob01_e013:Play(10, false)
    npc_0006:ResetExporession(10)
    Flg.Set("FLAG_MAIN_03_021")
    Cam.Inst:Clear(30)
    Qst.Main:Set(self.ID, self.STEP_015)
    tlk:EndTalk()
    Digitter.Send(1050035010)
  end
end

function M050:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_016) then
    local tlk = Tlk:new("t01", 1, true)
    local NPC0002_e002 = Motion.Object:new(NPC, "npc_0002", "e002")
    local NPC0002_e004 = Motion.Object:new(NPC, "npc_0002", "e004")
    local NPC0002_e011 = Motion.Object:new(NPC, "npc_0002", "e011")
    local NPC0002_e013 = Motion.Object:new(NPC, "npc_0002", "e013")
    local NPC0002_bn01 = Motion.Object:new(NPC, "npc_0002", "fn01_01")
    local Mob01_e013 = Motion.Object:new(NPC, "npc_0002_mob01", "e013")
    local Mob01_e030 = Motion.Object:new(NPC, "npc_0002_mob01", "e030")
    local Mob01_bn01 = Motion.Object:new(NPC, "npc_0002_mob01", "fn01_01")
    local Mob02_e020 = Motion.Object:new(NPC, "npc_0002_mob02", "e020")
    local Mob02_e012 = Motion.Object:new(NPC, "npc_0002_mob02", "e012")
    local Mob02_bn01 = Motion.Object:new(NPC, "npc_0002_mob02", "fn01_01")
    local npc_0002 = GetIndex(NPC, "npc_0002")
    local n_01 = Obj:new(NPC, "npc_0002")
    local npc_0002_mob01 = GetIndex(NPC, "npc_0002_mob01")
    local n_mob01 = Obj:new(NPC, "npc_0002_mob01")
    local npc_0002_mob02 = GetIndex(NPC, "npc_0002_mob02")
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    Digitter.Send(1050038005, true, true)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Obj:new(PLAYER, ""):SetPos(19.399, 0, -15.909, true)
    Obj:new(PLAYER, ""):SetRotationY(80, 0)
    Obj:new(PLAYER, ""):LookAtTheObject(NPC, "npc_0002", 15)
    Cam.Inst:Set(10.14, 1.884, -16.612, 20.124, 1.747, -16.065, default, 0)
    SetFollowerCameraOperateRotation(0, 260, 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_0002_mob01, "e013", 10, 10)
    n_mob01:ChangeExpression("F01", EYE_BLINK, true, 10)
    WaitFrame(10)
    tlk:Message("f_t0108_0020_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_0002_mob02, "e020", 10, 10)
    n_mob01:ChangeExpression("F01", EYE_BLINK, true, 10)
    WaitFrame(10)
    tlk:Message("f_t0108_0020_0020")
    n_mob01:ResetExporession(10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_0002, "e002", 10, 10)
    n_01:ChangeExpression("F01", EYE_BLINK, true, 10)
    WaitFrame(10)
    tlk:Message("f_t0108_0020_0030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_0002, "e011", 10, 10)
    n_01:ChangeExpression("F01", EYE_BLINK, true, 10)
    WaitFrame(10)
    tlk:Message("f_t0108_0020_0040")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_0002, "e004", 10, 10)
    n_01:ChangeExpression("F01", EYE_BLINK, true, 10)
    WaitFrame(10)
    tlk:Message("f_t0108_0020_0050")
    n_01:ResetExporession(10)
    Flg.Set("FLAG_MAIN_03_022")
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_016)
    Cam.Inst:Clear(30)
    Digitter.Send(1050038010)
    Field.ObjectPlayMotion(NPC, npc_0002, "e013", 10, true)
    Field.ObjectPlayMotion(NPC, npc_0002_mob01, "e030", 10, true)
    Field.ObjectPlayMotion(NPC, npc_0002_mob02, "e012", 10, true)
  end
end

function M050:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_016, self.STEP_018) then
    Execute("m050_040")
    Flg.Set("FLAG_MAIN_03_024")
    Field.ObjectLoadMotion(PLAYER, 1, "e503")
    FieldObjectSync(NPC, false)
    Motion.Player:Play("e503", 0, true)
    WaitFrame(30)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0302_0170_0010")
    tlk:Message("f_t0302_0170_0020")
    tlk:Message("f_t0302_0170_0030")
    tlk:Message("f_t0302_0170_0040")
    tlk:Message("f_t0302_0170_0050")
    tlk:EndTalk()
    Field.ObjectResetMotion(PLAYER, 1, 15)
    Flg.Set("FLAG_MAIN_03_025")
    Qst.Main:Set(self.ID, self.STEP_018)
  end
end

function M050:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_018, self.STEP_020) then
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M050:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Flg.Set("FLAG_MAIN_03_032")
    Execute("m050_055")
    Flg.Set("TUT_FLAG_4804")
    if Common.GetGameClearNum() < 1 then
      Item.Add(29001, 1)
      Item.Add(29002, 1)
      Item.Add(29003, 1)
      Item.Add(29005, 1)
      Item.Add(29006, 1)
      Item.Add(29007, 1)
      Item.Add(29008, 1)
      Item.Add(203, 5)
      Item.Add(210, 5)
      Item.Add(211, 5)
      Item.Add(213, 5)
      Item.Add(222, 5)
      Item.Add(223, 5)
    end
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M050:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m050_060")
    local player = Obj:new(PLAYER, "")
    local y_degree = player.rot_y
    player:SetPos(player.pos.x, player.pos.y, player.pos.z, true)
    SetFollowerCameraOperateRotation(0, y_degree)
    Qst.Main:Set(self.ID, self.STEP_030)
    Map:OpenPlace(155, true)
    Flg.Set("FLAG_MAIN_03_035")
    Flg.Set("PLACE_OPEN_ROAD_SHINJUKU_BACK_STREET")
    Flg.Set("TUT_FLAG_4707")
    Dlc_InstallCheck()
  end
end

function M050:Event_115()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    AnswerTheCall()
    local tlk = Tlk:new("t04", 1, true)
    tlk:StartTalk()
    tlk:Message("f_t0404_0230_0010")
    tlk:Message("f_t0404_0230_0020")
    tlk:EndTalk()
    EndTheCall()
    Qst.Main:Set(self.ID, self.STEP_035)
  end
end

function M050:Event_118()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_03_035", "FLAG_MAIN_03_036") then
    INFO_GET_ITEM(803, 1)
    Field.OpenRequestDigiviceCostume()
    SetControlScriptExternalVariable("AfterCostumeTutorialEvent", "on")
  end
end

function M050:Event_118B()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_03_035", "FLAG_MAIN_03_036") then
    Flg.Set("FLAG_MAIN_03_036")
    SetControlScriptExternalVariable("AfterCostumeTutorialEvent", "off")
    Qst.Main:Set(self.ID, self.STEP_040)
  end
end

function M050:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_255) then
    Flg.Set("FLAG_MAIN_03_037")
    Qst.Main:End(self.ID, self.STEP_255)
  end
end

function M050:ChapterFlagSet(progress)
  local step = {}
  if 30 <= progress then
    step[#step + 1] = self.STEP_001
    step[#step + 1] = self.STEP_005
  end
  if 31 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 32 <= progress then
    step[#step + 1] = self.STEP_015
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_016
  end
  if 50 <= progress then
    step[#step + 1] = self.STEP_017
    step[#step + 1] = self.STEP_018
  end
  if 51 <= progress then
    step[#step + 1] = self.STEP_020
  end
  if 60 <= progress then
    step[#step + 1] = self.STEP_025
  end
  if 61 <= progress then
    step[#step + 1] = self.STEP_030
  end
  Qst.Main:Chapter(step, self.ID)
end
