gGimText = "field_text"
M140 = {
  ID = 140,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_255 = 255,
  Battle = {
    Enemy = {e01 = 10360100},
    Map = {m01 = 10276}
  }
}

function M140:Event_010()
  if Flg.Check("FLAG_MAIN_03_610", "FLAG_MAIN_03_630") and not Qst.Main:Check(self.ID, self.STEP_001) then
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M140:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) then
    Flg.Set("FLAG_MAIN_03_630")
    Execute("m120_090")
    SetEnableGimmickCheck("gim_0001", true)
    Qst.Main:Set(self.ID, self.STEP_003)
  end
end

function M140:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_GIMMICK_D02_430", "FLAG_MAIN_03_640") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_03_640")
    SetEnableGimmickCheck("gim_0001", false)
    ColOff("wall_cl_0001")
    Execute("m140_010")
    Cam.Follower:ResetFromLocateAndPlayerRotate("start_00")
    local mercurius_icon = Icon:new(NPC, "npc_0001")
    mercurius_icon.Clear()
    Field.ObjectCheckSync(FOR_ALL, true)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M140:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check("FLAG_MAIN_03_645") then
    Cam.Inst:Set(45.035, 1.51, 97.841, 43.55, 1.738, 87.954, default, 0)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_03_645")
    local tlk = Tlk:new("d02", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0205_0010_0010")
    tlk:Message("f_d0205_0010_0020")
    tlk:Message("f_d0205_0010_0030")
    tlk:Message("f_d0205_0010_0040")
    FadeOutWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
    Field_CancelInvisibleFollowerAllGuest(0, 0, false, false)
    Cam.Inst:Clear(0)
    tlk:EndTalk()
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function M140:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Cam.Inst:Set(8.8, 0.389, -5, 12.491, 0.682, -2.181, 40, 60)
    FadeOutWithWait(0, FADE_TIME)
    Cam.Inst:Clear(0)
    Execute("m140_020")
    Flg.Set("FLAG_MAIN_03_650")
    Qst.Main:Set(self.ID, self.STEP_010)
    WaitFrame(10)
    Debug.AllUIOn()
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function M140:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_255) then
    if Flg.Check("FLAG_MAIN_03_660") then
      local hagr_talk = Tlk:new("d02")
      hagr_talk:StartTalk()
      hagr_talk:Message("f_d0206_0010_0010")
      hagr_talk:Message("f_d0206_0010_0020")
      hagr_talk:EndTalk()
    end
    if not Flg.Check("FLAG_MAIN_03_660") then
      Flg.Set("FLAG_MAIN_03_661")
      Cam.Inst:Set(0.133, 0, -21.028, 0.082, 3.607, -14.216, DEFAULT_ANGLE, 60)
      FadeOutWithWait(0, FADE_TIME)
      WaitFrame(20)
      SetControlScriptExternalVariable("hagr_state", "stand_up")
      FieldObjectSync(NPC, true)
      Cam.Inst:Clear(0)
      Execute("m140_030")
      ColOff("evt_2006")
      ColOff("evt_2007")
      ColOff("cliff_cl_0001")
      if GetControlScriptExternalVariableString("hagr_state") == "stand_up" then
        SetControlScriptExternalVariable("hagr_state", "move")
      end
      Flg.Set("FLAG_MAIN_03_660")
    end
  end
end

function M140:Event_051()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M140:Event_052()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) then
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M140:Event_053()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M140:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Qst.Main:Set(self.ID, self.STEP_030)
  end
end

function M140:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) and not Flg.Check("FLAG_GIMMICK_D02_410") then
    Execute("m140_040")
  end
end

function M140:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) and not Flg.Check("FLAG_MAIN_03_680") then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field.InvisibleMapModel(1)
    Flg.Clear("TUT_FLAG_4510")
    Flg.Set("FLAG_MAIN_03_670")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(self.Battle.Enemy.e01, self.Battle.Map.m01, false)
  end
end

function M140:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) and Flg.Check("FLAG_MAIN_03_680") then
    Flg.Set("TUT_FLAG_4510")
    Common.SetDigimonGraspState(80, DIGIMON_GRASP_FLAG_SCAN)
    FieldObjectSync(FOR_ALL, true)
    Field.InvisibleMapModel(3)
    Sound.StopAmbientSE(0)
    Execute("m140_070")
    Flg.Set("FLAG_MAIN_03_710")
    Guest.Delete(M130.Guest.Minerva)
    Field.CancelInvisibleMapModel(3)
    Field_StopBGM()
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("e", 3, "start_00", AXIS_ORIGINAL, "A2020_dbef_141", EVENING)
  end
end

function M140:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) and Flg.Check("FLAG_MAIN_03_680", "FLAG_MAIN_03_700") then
    Execute("m140_080")
    Flg.Set("FLAG_MAIN_03_700")
    MapChangeWithTimeTravel("e", 3, "start_00", AXIS_ORIGINAL, "A2020_dbef_142", NIGHT)
  end
end

function M140:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) and Flg.Check("FLAG_MAIN_03_700", "FLAG_MAIN_03_705") then
    Flg.Set("FLAG_MAIN_03_705")
    Execute("m140_090")
    PlayRestJingle()
    MapChangeWithTimePasses("d", 203, "start_01", NOON)
  end
end

function M140:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) and Flg.Check("FLAG_MAIN_03_705", "FLAG_MAIN_03_708") then
    Flg.Set("FLAG_MAIN_03_708")
    Restore.Party()
    Execute("m140_100")
    Cam.Follower:ResetFromLocateAndPlayerRotate("start_00")
    Qst.Main:End(self.ID, self.STEP_255)
    FadeInWithWait(0, FADE_TIME)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(24)
    end
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_150"
    TIME_ZONE = NOON
  end
end
