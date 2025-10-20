M040 = {
  ID = 40,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_255 = 255,
  Battle = {
    Enemy = {e01 = 10210100},
    Map = {m01 = 11174}
  }
}

function M040:Event_010()
  if Flg.Check("FLAG_MAIN_02_020", "FLAG_MAIN_02_030") and not Flg.Check("FLAG_MAIN_02_025") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_02_025")
    Execute("m040_010")
    Map:OpenPlace(302, true)
    Map:OpenArea(4, true)
    Map:OpenPlace(401, true)
    Map:OpenPlace(404, true)
    Map:OpenPlace(408, true)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M040:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_02_030")
    Execute("m040_020")
    Qst.Main:Set(self.ID, self.STEP_005)
    local player = Obj:new(PLAYER, "")
    player:SetPos(-3, 0, 1, true)
    player:SetRotationY(0, 0)
    Field.ObjectCheckSync(FOR_ALL, true)
    Obj:new(RUMOR_NPC, "rumor_0012"):Invisible()
    Field_CancelInvisibleObjects(MOB, 128, 131)
    Field_CancelInvisibleObjects(RUMOR_NPC, 10, 11)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function M040:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_02_045") then
    local father01 = Obj:new(NPC, "father01")
    local tlk = Tlk:new("t03", 1, true)
    START_TALK_ACTION_AND_ZOOM("father01", true, false)
    tlk:StartTalkAndCancelDigimonRide()
    father01:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message("f_t0303_0120_0010")
    father01:ResetExporession(10)
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("father01", true, false)
  end
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_02_040")
    WaitFrame(15)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(15)
    Execute("m040_030")
    local father01_e012 = Motion.Object:new(NPC, "father01", "e012")
    father01_e012:Play(10, true)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M040:Event_040()
  if Flg.Check("FLAG_MAIN_02_030") then
    local father = Obj:new(NPC, "father01")
    local father_icon = Icon:new(NPC, "father01")
    local father_e006 = Motion.Object:new(father.type, father.name, "e006")
    local father_e002 = Motion.Object:new(father.type, father.name, "e002")
    local father_e005 = Motion.Object:new(father.type, father.name, "e005")
    local father_e004 = Motion.Object:new(father.type, father.name, "e004")
    local father_e015 = Motion.Object:new(father.type, father.name, "e015")
    local father_e012 = Motion.Object:new(father.type, father.name, "e012")
    local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, GetIndex(NPC, "father01"), 30)
    if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_02_045") and Flg.Check("FLAG_MAIN_02_047") then
      local tlk = Tlk:new("t03", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      father_e002:PlayWithStartMoveMotion(10, 10)
      father:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0303_0140_0010")
      father_e015:PlayWithStartMoveMotion(10, 10)
      tlk:Message("f_t0303_0140_0020")
      father:ResetExporession(10)
      while true do
        tlk:MessageClose()
        local result = tlk:Select(3, "f_t0303_0130_0060")
        father:ChangeExpression("F01", EYE_BLINK, true, 10)
        if result == RESULT_TALK00 then
          HideMinimap(true)
          HideGuide(true)
          player_e002_01:Play(10, false)
          Motion.Player:Wait()
          Field.ObjectResetMotion(PLAYER, 1, 30)
          father_e004:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0070")
          father_e002:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0080")
          father:ResetExporession(10)
          tlk:EndTalk()
          father_icon.SetNone()
          MapChange("d", 1102, "start_00", true, FADE_BLACK, FADE_TIME)
        end
        if result == RESULT_TALK01 then
          father_e002:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0090")
          father_e005:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0100")
          father:ResetExporession(10)
        end
        if result == RESULT_TALK02 then
          tlk:Message("f_t0303_0130_0110")
          father:ResetExporession(10)
          tlk:EndTalk()
          break
        end
      end
      father_e012:PlayWithStartMoveMotion(10, 10)
    end
    if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_02_045") and not Flg.Check("FLAG_MAIN_02_047") then
      Flg.Set("FLAG_MAIN_02_047")
      local tlk = Tlk:new("t03", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      PlayerObjectResetAim()
      father_e006:PlayWithStartMoveMotion(10, 10)
      father:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0303_0130_0010")
      father:ResetExporession(10)
      ObjectTurnToPlayer(NPC, father.name)
      ObjectTurnToObject(PLAYER, "", NPC, father.name)
      father_e002:PlayWithStartMoveMotion(10, 10)
      father:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0303_0130_0020")
      father_e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message("f_t0303_0130_0030")
      father_e005:PlayWithStartMoveMotion(10, 10)
      tlk:Message("f_t0303_0130_0040")
      tlk:Message("f_t0303_0130_0050")
      father:ResetExporession(10)
      while true do
        tlk:MessageClose()
        local result = tlk:Select(3, "f_t0303_0130_0060")
        father:ChangeExpression("F01", EYE_BLINK, true, 10)
        if result == RESULT_TALK00 then
          HideMinimap(true)
          HideGuide(true)
          father_e004:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0070")
          father_e002:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0080")
          father:ResetExporession(10)
          tlk:EndTalk()
          father_icon.SetNone()
          MapChange("d", 1102, "start_00", true, FADE_BLACK, FADE_TIME)
        end
        if result == RESULT_TALK01 then
          father_e002:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0090")
          father_e005:PlayWithStartMoveMotion(10, 10)
          tlk:Message("f_t0303_0130_0100")
          father:ResetExporession(10)
        end
        if result == RESULT_TALK02 then
          father_e015:PlayWithStartMoveMotion(10, 10)
          Qst.Main:Set(self.ID, self.STEP_015)
          tlk:Message("f_t0303_0130_0110")
          father:ResetExporession(10)
          tlk:EndTalk()
          break
        end
      end
      father_e012:Play(10, true)
    end
  end
end

function M040:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_020) and not Flg.Check("FLAG_MAIN_02_048") then
    Guest.Add(30021)
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, 0)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_02_048")
    Execute("m040_040")
    Qst.Main:Set(self.ID, self.STEP_015)
    Qst.Main:Set(self.ID, self.STEP_020)
    local player = Obj:new(PLAYER, "")
    SetFollowerCameraOperateRotation(5, player.rot_y)
  end
end

function M040:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and not Flg.Check("FLAG_MAIN_02_050") then
    Flg.Set("FLAG_MAIN_02_050")
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Execute("m040_050")
    Story.OpenGameClearBG()
    WaitFrame(10)
    HideMinimap(true)
    HideGuide(true)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    local player = Obj:new(PLAYER, "")
    player:SetPos(-120.816, 4.999, -38.244, false)
    player:SetRotationY(90, 0)
    SetFollowerCameraOperateRotation(0, 90, 0)
    Field.ObjectCheckSync(FOR_ALL, true)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_025)
    local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
    Sound.StopBGM(fade_out_time)
    for i = 0, 89 do
      Field.StopGlobalManageSE(i, fade_out_time)
    end
    Sound.StopAmbientSE(fade_out_time)
    Obj:new(OGIM, "obj_0100"):Invisible()
    Obj:new(OGIM, "obj_0101"):Invisible()
    Obj:new(OGIM, "obj_0102"):Invisible()
    Window.OpenInfoByString("info_message_demo_07")
    WaitFrame(1)
    while not Window.IsNextInfo() do
      WaitFrame(1)
    end
    Window.CloseInfo()
    WaitFrame(1)
    while not Window.IsEndCloseInfo() do
      WaitFrame(1)
    end
    Field.StartAutoSave(true)
    while Save.IsOpenEnable() == false do
      WaitFrame(1)
    end
    Save.Open(1)
    WaitFrame(1)
    while not Save.IsClosed() do
      WaitFrame(1)
    end
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Story.CloseGameClearBG()
    WaitFrame(1)
    Sound.StopBGM(0)
    Sound.StopSE(Work.Get(Field_BackSE_Slot_Num), 0)
    Execute("m991_010")
    Display_ThankYouForPlaying()
    WaitFrame(30)
    Field.ToTitle()
  end
end

function M040:Event_PlayableClear()
  if Flg.Check("FLAG_MAIN_02_050") and Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) then
    local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
    Sound.StopBGM(fade_out_time)
    for i = 0, 89 do
      Field.StopGlobalManageSE(i, fade_out_time)
    end
    Sound.StopAmbientSE(fade_out_time)
    Obj:new(OGIM, "obj_0100"):Invisible()
    Obj:new(OGIM, "obj_0101"):Invisible()
    Obj:new(OGIM, "obj_0102"):Invisible()
    Sound.StopBGM(0)
    Sound.StopSE(Work.Get(Field_BackSE_Slot_Num), 0)
    Execute("m991_010")
    Display_ThankYouForPlaying()
    WaitFrame(30)
    Field.ToTitle()
  end
end

function M040:Event_070()
  if Flg.Check("FLAG_MAIN_02_060") or Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) then
  end
end

function M040:Event_080()
  if not Flg.Check("FLAG_MAIN_02_060") or Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) then
  end
end

function M040:Event_090()
  if Flg.Check("FLAG_MAIN_02_070") or Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) then
  end
end

function M040:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
    step[#step + 1] = self.STEP_005
  end
  if 31 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
  end
  if 60 <= progress then
    step[#step + 1] = self.STEP_025
  end
  Qst.Main:Chapter(step, self.ID)
end
