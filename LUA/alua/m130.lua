gGimText = "field_text"
M130 = {
  ID = 130,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255,
  Battle = {
    Enemy = {e01 = 10350100},
    Map = {m01 = 10278}
  },
  Guest = {Minerva = 27472, Colona = 21361}
}

function M130:Event_010()
  if Flg.Check("FLAG_MAIN_03_520", "FLAG_MAIN_03_525") and not Qst.Main:Check(self.ID, self.STEP_001) then
    local p_rot = Field.ObjectGetRotationY(PLAYER, 1)
    SetFollowerCameraOperateRotation(0, p_rot - 5, 60)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M130:Event_020()
  if not Flg.Check("FLAG_MAIN_03_520") then
    local talk = Tlk:new("d02")
    talk:StartTalkActionAndZoom("npc_0012")
    talk:Message("f_d0202_0180_0010")
    talk:EndTalkActionAndZoom()
  end
  if Flg.Check("FLAG_MAIN_03_520", "FLAG_MAIN_03_525") then
    FadeOutWithWait(0, 15)
    Flg.Set("FLAG_MAIN_03_525")
    Execute("m120_120")
    SetControlScriptExternalVariable("luna_state", "move_point4")
    SetControlScriptExternalVariable("Rumer_state2", "invisible")
    Qst.Main:Set(self.ID, self.STEP_005)
    SetEnableGimmickCheck("gim_0006", true)
    SetEnableGimmickCheck("gim_0005", false)
  end
end

function M130:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check("FLAG_MAIN_03_560") then
    Flg.Set("FLAG_MAIN_03_560")
    Execute("m130_020")
    Flg.Set("FLAG_IS_START_EVENT_BEFORE_MAPCHANGE")
    Cam.Follower:ResetFromLocateAndPlayerRotate("start_00", true)
  end
end

function M130:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check("FLAG_MAIN_03_570") then
    Field_InvisibleObjects(RUMOR_NPC, 1, 1)
    Flg.Set("FLAG_MAIN_03_570")
    local bear_index = GetIndex(NPC, "npc_0120")
    Field.ObjectLoadMotion(NPC, bear_index, "bn01")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, bear_index, "bn01", 15, 15)
    Execute("m130_040")
    SetControlScriptExternalVariable("bear_br_state", "stop")
  end
end

function M130:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check("FLAG_MAIN_03_580") and not Flg.Check("FLAG_MAIN_03_590") then
    Guest.Add(self.Guest.Colona)
    Battle.RequestBattleBGMNotPlay()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(self.Battle.Enemy.e01, self.Battle.Map.m01, false)
  end
end

function M130:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_03_590") then
    Execute("m130_090")
    Flg.Clear("FLAG_GIMMICK_D02_460")
    Guest.Delete(self.Guest.Colona)
    Guest.Add(self.Guest.Minerva)
    Common.SetDigimonGraspState(136, DIGIMON_GRASP_FLAG_SCAN)
    Common.SetDigimonGraspState(234, DIGIMON_GRASP_FLAG_SCAN)
    MapChangeWithTimeTravel("d", 202, "start_10", AXIS_ORIGINAL, "A2020_dbef_140", NOON)
  end
end

function M130:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_03_590", "FLAG_MAIN_03_610") then
    Flg.Set("FLAG_MAIN_03_610")
    Execute("m130_100")
    Cam.Follower:ResetFromLocate("start_02")
    Qst.Main:End(self.ID, self.STEP_255)
    M140:Event_010()
  end
end

function M130:Event_990()
  if Flg.Check("FLAG_MAIN_03_460", "FLAG_MAIN_03_620") then
    if Flg.Check("FLAG_MAIN_07_010") then
      Flg.Set("FLAG_MAIN_03_620")
    else
      Flg.Set("FLAG_MAIN_03_620")
      Execute("m130_030")
    end
  end
end
