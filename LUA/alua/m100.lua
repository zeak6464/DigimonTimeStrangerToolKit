M100 = {
  ID = 100,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_013 = 13,
  STEP_014 = 14,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_040 = 40,
  STEP_255 = 255
}

function M100:Event_010()
  if Flg.Check("FLAG_MAIN_03_310", "FLAG_MAIN_03_315") then
    Flg.Set("FLAG_MAIN_03_315")
    PlayRestJingle()
    local player = Obj:new(PLAYER, "")
    player:SetPos(0, 0, 0, true)
    player:SetRotationY(80, 0)
    SetFollowerCameraOperateRotation(0, 65)
    WaitFrame(60)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("t04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0404_050_010")
    tlk:EndTalk()
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M100:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Execute("m100_010")
    Flg.Set("FLAG_MAIN_03_320")
    Field.ObjectCheckSync(FOR_ALL, true)
    Guest.Add(27472)
    Guest.Add(10012)
    Party.Aegiomon.SetExist(true)
    Qst.Main:Set(self.ID, self.STEP_005)
    Flg.Set("FLAG_MAIN_03_321")
    Cam.Inst:Set(0.772, 1.423, 0.433, -0.157, 1.461, 0.967, default, 30)
    local tlk = Tlk:new("d09", 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_MAIN_03_126")
    local result = tlk:Select(2, "f_d0900_0010_0070")
    if result == RESULT_TALK00 then
      tlk:EndTalk(true)
      MapChange("t", 302, "start_00", true, FADE_BLACK, FADE_TIME)
    elseif result == RESULT_TALK01 then
      tlk:EndTalk()
      Cam.Inst:Clear(30)
    end
  end
end

function M100:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local npc_0316 = Obj:new(NPC, "npc_0316")
    local Koanmob01_e013 = Motion.Object:new(NPC, "npc_0316", "e013")
    local Koanmob01_e012 = Motion.Object:new(NPC, "npc_0316", "e012")
    local Koanmob01_e007 = Motion.Object:new(NPC, "npc_0316", "e007")
    local Koanmob01_e006 = Motion.Object:new(NPC, "npc_0316", "e006")
    local tlk = Tlk:new("t03", 1, true)
    START_TALK_ACTION_AND_ZOOM("npc_0316", true, false)
    tlk:StartTalkAndCancelDigimonRide()
    npc_0316:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message("f_t0302_0110_0010")
    npc_0316:ResetExporession(10)
    tlk:MessageClose()
    local result = tlk:Select(2, "f_t0302_0110_0020")
    if result == RESULT_TALK00 then
      Koanmob01_e013:Play(10, true)
      npc_0316:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0302_0110_0030")
      tlk:Message("f_t0302_0110_0050")
      tlk:Message("f_t0302_0110_0060")
      npc_0316:ResetExporession(10)
      tlk:Message("f_t0302_0110_0070")
      Koanmob01_e006:Play(10, true)
      npc_0316:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0302_0110_0080")
      Koanmob01_e007:Play(10, true)
      tlk:Message("f_t0302_0110_0090")
      Koanmob01_e012:Play(10, true)
      tlk:Message("f_t0302_0110_0100")
      npc_0316:ResetExporession(10)
      tlk:Message("f_t0302_0110_0110")
      Flg.Set("FLAG_MAIN_03_325")
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0316", true, false)
      MapChange("t", 303, "start_00", true, 0, FADE_TIME)
    end
    if result == RESULT_TALK01 then
      npc_0316:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0302_0110_0040")
      npc_0316:ResetExporession(10)
      tlk:EndTalk()
    end
  end
end

function M100:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_03_325", "FLAG_MAIN_03_330") then
    Flg.Set("FLAG_MAIN_03_330")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest"):SuspendAutoTransparentForCamera()
    Execute("m100_020")
    Qst.Main:Set(self.ID, self.STEP_010)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function M100:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_013) then
    Field_Talk_Start("t01", 1, true)
    Message("f_t0110_0010_0010")
    Field_Talk_End()
    Qst.Main:Set(self.ID, self.STEP_013)
  end
end

function M100:Event_046()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_014) and not Flg.Check("FLAG_MAIN_03_331") then
    Field_Talk_Start("t02", 1, true)
    Message("f_t0201_0200_0010")
    Field_Talk_End()
    Flg.Set("FLAG_MAIN_03_331")
    Map:OpenArea(2, true)
    Map:OpenPlace(201, true)
    Map:OpenPlace(250, true)
    Qst.Main:Set(self.ID, self.STEP_013)
  end
end

function M100:Event_047()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_014) then
    local npc_0005 = Obj:new(NPC, "npc_0005")
    START_TALK_ACTION_AND_ZOOM("npc_0005", true, false)
    Field_Talk_Start("t02", 1, true)
    npc_0005:ChangeExpression("F01", EYE_BLINK, true, 10)
    Message("f_t0201_0170_0010")
    Message("f_t0201_0170_0020")
    npc_0005:ResetExporession(10)
    Field_Talk_End()
    Prcs_d0109_akiba_uradoriCam()
    WaitFrame(70)
    Field_Talk_Start_Not_LetterBox("t02", 1)
    Message("f_t0201_0170_0030")
    Field_Talk_End_Not_LetterBox()
    END_TALK_ACTION_AND_ZOOM("npc_0005", true, false)
    Cam.Inst:Clear(60)
    Flg.Set("FLAG_MAIN_03_336")
    Qst.Main:Set(self.ID, self.STEP_014)
  end
end

function M100:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) then
    Flg.Set("FLAG_MAIN_03_335")
    Execute("m100_030")
    Obj:new(NPC, "npc_0004"):Invisible()
    Qst.Main:Set(self.ID, self.STEP_014)
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M100:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_014, self.STEP_015) then
    Flg.Set("FLAG_MAIN_03_335")
    Execute("m100_030")
    Obj:new(NPC, "npc_0004"):Invisible()
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M100:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) then
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M100:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_03_340")
    Field.ObjectCheckSync(FOR_ALL, true)
    Execute("m100_040")
    Qst.Main:Set(self.ID, self.STEP_025)
    SetFollowerCameraOperateRotation(0, 30)
  end
end

function M100:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_03_350") then
    Flg.Set("FLAG_MAIN_03_350")
    Execute("m100_050")
    SetFollowerCameraOperateRotation(10, Obj:new(PLAYER, "").rot_y)
  end
end

function M100:Event_082()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Cam.Inst:Set(5.871, -0.02, 48.89, 5.998, 1.307, 58.801, default, 15)
    Field.SetProhibitPlayerMoveOperate(true)
    local tlk = Tlk:new("h03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_h0301_0020_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_03_351")
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_h0301_0020_0020")
    tlk:Message("f_h0301_0020_0030")
    tlk:Message("f_h0301_0020_0040")
    tlk:EndTalk()
    Field.SetProhibitPlayerMoveOperate(false)
    Obj:new(NPC, "black_tail_left"):Invisible()
    Obj:new(NPC, "black_tail_right"):Invisible()
    Cam.Inst:Clear(15)
    Qst.Main:Set(self.ID, self.STEP_030)
    Flg.Set("FLAG_MAIN_03_355")
  end
end

function M100:Event_085()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    local flgs = {
      "FLAG_GIMMICK_H03_010",
      "FLAG_GIMMICK_H03_020",
      "FLAG_GIMMICK_H03_030"
    }
    local num = 0
    for _, value in ipairs(flgs) do
      if Flg.Check(value) then
        num = num + 1
      end
    end
    if num == 1 then
      if not Flg.Check("FLAG_MAIN_03_352") then
        Flg.Set("FLAG_MAIN_03_352")
        local tlk = Tlk:new("h03", 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        AnswerTheCall()
        tlk:Message("f_h0301_0030_0010")
        tlk:EndTalk()
        EndTheCall()
      end
    elseif num == 2 then
      if not Flg.Check("FLAG_MAIN_03_353") then
        Flg.Set("FLAG_MAIN_03_353")
        local tlk = Tlk:new("h03", 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        AnswerTheCall()
        tlk:Message("f_h0301_0030_0020")
        tlk:EndTalk()
        EndTheCall()
      end
    elseif num == 3 and not Flg.Check("FLAG_MAIN_03_354") then
      Flg.Set("FLAG_MAIN_03_354")
      FieldObjectSync(NPC, true)
      FieldObjectSync(MOB, true)
      local tlk = Tlk:new("h03", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      AnswerTheCall()
      tlk:Message("f_h0301_0030_0030")
      tlk:MessageClose()
      Cam.Inst:Set(2.133, -0.2, -63.389, 2.368, 1.931, -53.622, default, 15)
      WaitFrame(15)
      tlk:Message("f_h0301_0030_0040")
      tlk:Message("f_h0301_0030_0050")
      tlk:EndTalk()
      EndTheCall()
      Cam.Inst:Clear(15)
      Qst.Main:Set(self.ID, self.STEP_035)
    end
  end
end

function M100:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and not Flg.Check("FLAG_MAIN_03_360") then
    Execute("m100_060")
    EncountFromField(10330200, 20371, false)
  end
end

function M100:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_03_360") then
    Execute("m100_070")
    Digimon.RestoreAllParty()
    MapChange("d", 1001, "start_05", false, 0, FADE_TIME)
  end
end

function M100:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) and Flg.Check("FLAG_MAIN_03_360", "FLAG_MAIN_03_370") then
    Flg.Set("FLAG_MAIN_03_370")
    Execute("m100_080")
    Qst.Main:Set(self.ID, self.STEP_040)
    MapChangeWithTimeTravel("t", 302, "start_00", AXIS_ORIGINAL, "A2020_dbef_101", EVENING)
  end
end

function M100:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_255) then
    local tlk = Tlk:new("t03", 1, true)
    tlk:StartTalkAction("npc_0015")
    tlk:Message("f_t0302_0120_0010")
    Flg.Set("FLAG_MAIN_03_380")
    tlk:EndTalkAction()
    FadeOutWithWaitNotFlgCheck(0, FADE_TIME)
    SystemFlag.ClearHideEnemiesOnMiniMap()
    MapChange("e", 4, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M100:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_255) then
    Execute("m100_090")
    Guest.Delete(27472)
    Guest.Delete(10012)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(12)
    end
    Common.SetExistPartyAegiomon(false)
    Qst.Main:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChangeWithTimeTravel("t", 403, "start_02", AXIS_ORIGINAL, "A2020_dbef_110", NOON)
  end
end

function M100:ChapterFlagSet(progress)
  local step = {}
  if 10 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 11 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 30 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_013
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_014
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
  end
  if 50 <= progress then
    step[#step + 1] = self.STEP_025
  end
  if 90 <= progress then
    step[#step + 1] = self.STEP_030
    step[#step + 1] = self.STEP_035
    step[#step + 1] = self.STEP_040
  end
  Qst.Main:Chapter(step, self.ID)
end
