gGimText = "field_text"
M230 = {
  ID = 230,
  STEP_001 = 1,
  STEP_255 = 255
}

function M230:Event_010()
  if Flg.Check("FLAG_MAIN_07_080", "FLAG_MAIN_08_000") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Clear("FLAG_t0105_InLine")
    Field_StopBGM()
    Execute("m230_010")
    Flg.Set("FLAG_MAIN_08_000")
    Flg.Set("FLAG_IS_USED_TIMEJUMP_TO_AFTER")
    SetFollowerCameraOperateRotation(0, 350)
    Qst.Main:Start(self.ID, self.STEP_001)
    PlayDungeonBGM()
    OpenTutorial(2015)
  end
end

function M230:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
    Common.ProhibitSave()
  end
end

function M230:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check("FLAG_MAIN_08_005") then
    local inori_e012 = Motion.Object:new(NPC, "npc_0100", "e012")
    local inori_e010 = Motion.Object:new(NPC, "npc_0100", "e010")
    local inori_e507 = Motion.Object:new(NPC, "npc_0100", "e507")
    local aigio_e033 = Motion.Object:new(NPC, "npc_0101", "e033")
    local npc_index = GetIndex(NPC, "npc_0100")
    local npc_index02 = GetIndex(NPC, "npc_0102")
    local npc_index03 = GetIndex(NPC, "npc_0101")
    local player_index = GetIndex(PLAYER, "")
    Field.ObjectLoadExpression(NPC, npc_index, "F06")
    Field.ObjectLoadExpression(NPC, npc_index, "F07")
    Field.ObjectLoadExpression(NPC, npc_index, "E13_M13")
    Field.ObjectLoadExpression(NPC, npc_index03, "F11")
    Field.ObjectLoadExpression(PLAYER, player_index, "F06")
    Field.ObjectLoadExpression(PLAYER, player_index, "F07")
    Field.ObjectLoadExpression(NPC, npc_index02, "F05")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Flg.Set("FLAG_MAIN_08_005")
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 20, 0)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -1.1949, 0, -63.56)
    Cam.Inst:Set(-9.516, 3.8, -64.756, 0.0223, 0.9316, -63.8655, default, 1)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(1)
    Field.ObjectChangeExpression(PLAYER, player_index, "F06", -1, false, 0)
    Field.ObjectChangeExpression(NPC, npc_index, "F06", -1, false, 0)
    Field.ObjectChangeExpression(NPC, npc_index03, "F11", -1, false, 0)
    Field.ObjectChangeExpression(NPC, npc_index02, "F05", -1, false, 0)
    Field.ObjectSuspendAutoTransparentForCamera(FLD_OBJ_NPC, npc_index)
    Field.ObjectSuspendAutoTransparentForCamera(FLD_OBJ_NPC, npc_index02)
    Field.ObjectSuspendAutoTransparentForCamera(FLD_OBJ_NPC, npc_index03)
    Field.ObjectSuspendAutoTransparentForCamera(NPC, npc_index)
    Field.ObjectSuspendAutoTransparentForCamera(NPC, npc_index02)
    Field.ObjectSuspendAutoTransparentForCamera(NPC, npc_index03)
    local tlk = Tlk:new("t01", 1, true)
    Motion.Player:Play("e012", 10, true)
    inori_e010:Play(10, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectChangeExpression(NPC, npc_index02, "F05", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_t0103_0050_0010")
    Field.ObjectLookAtTheObject(NPC, npc_index02, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_0101"), 20)
    tlk:Message("f_t0103_0050_0020")
    tlk:MessageClose()
    Field.ObjectChangeExpression(NPC, npc_index02, "F05", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    WaitFrame(45)
    Field.ObjectChangeExpression(NPC, npc_index02, "F05", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_t0103_0050_0030")
    tlk:Message("f_t0103_0050_0040")
    tlk:MessageClose()
    Field.ObjectChangeExpression(NPC, npc_index02, "F05", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    inori_e012:Play(10, true)
    Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_0101"), 20)
    WaitFrame(10)
    Field.ObjectChangeExpression(NPC, npc_index, "F06", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    WaitFrame(30)
    Field.ObjectChangeExpression(NPC, npc_index, "F06", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_t0103_0050_0050")
    tlk:MessageClose()
    Field.ObjectChangeExpression(NPC, npc_index, "F06", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    Motion.Player:PlayWithMoveMotion("e020", 5, 5)
    WaitFrame(30)
    Field.ObjectChangeExpression(NPC, npc_index02, "F05", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_t0103_0050_0060")
    tlk:MessageClose()
    Field.ObjectChangeExpression(NPC, npc_index02, "F05", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    tlk:EndTalk()
    Common.CancelProhibitSave()
    MapChange("t", 109, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M230:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) and not Flg.Check("FLAG_MAIN_08_007") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_08_007")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0109_0040_0010")
    tlk:Message("f_t0109_0040_0020")
    tlk:EndTalk()
  end
end

function M230:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_255) and Flg.Check("FLAG_MAIN_08_007", "FLAG_MAIN_08_010") then
    HideMinimap(true)
    HideGuide(true)
    Cam.Inst:Set(18.7123, 1.4286, 70.734, 16.782, 0.7259, 60.947, default, 20)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 403, "start_00", true, FADE_BLACK, 60)
  end
end

function M230:Event_050()
  if Flg.Check("FLAG_MAIN_08_007", "FLAG_MAIN_08_010") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_08_010")
    WaitFrame(150)
    Sound.StopBGM(0)
    Execute("m230_020")
    Execute("m230_030")
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(51)
    end
    Restore.Party()
    Qst.Main:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 401, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M230:ChapterFlagSet(progress)
  local step = {}
  if 11 <= progress then
    step[#step + 1] = self.STEP_001
  end
  Qst.Main:Chapter(step, self.ID)
end
