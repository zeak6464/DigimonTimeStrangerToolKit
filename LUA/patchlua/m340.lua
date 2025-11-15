gGimText = "field_text"
M340 = {
  ID = 340,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_255 = 255
}

function M340:Event_010()
  if Flg.Check("FLAG_MAIN_12_130", "FLAG_MAIN_13_010") then
    Flg.Set("FLAG_MAIN_13_010")
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M340:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    local tlk = Tlk:new("d12", 1, true)
    local simonzu_e019 = Motion.Object:new(NPC, "simonzu_01", "e019")
    local simonzu_e002 = Motion.Object:new(NPC, "simonzu_01", "e002")
    Field.ObjectLoadExpression(NPC, GetIndex(NPC, "simonzu_01"), "F01")
    tlk:StartTalkAndCancelDigimonRide()
    simonzu_e002:Play(10, true)
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "simonzu_01"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1204_0050_0010")
    Field.ObjectResetMotion(NPC, GetIndex(NPC, "simonzu_01"), 30)
    local result = tlk:Select(2, "f_d1204_0050_0020")
    if result == RESULT_TALK00 then
      simonzu_e019:Play(10, false)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "simonzu_01"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message("f_d1204_0050_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "simonzu_01"), 30)
      tlk:EndTalk()
      Flg.Set("FLAG_MAIN_13_020")
      self:Event_030()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
      MapChangeWithTimeTravel("d", 1304, "start_00", AXIS_ORIGINAL, "A2028_daft_341", NOON)
    end
    tlk:EndTalk()
  end
end

function M340:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M340:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set("FLAG_MAIN_13_030")
    Execute("m340_010")
    Guest.Delete(GST_HEROINE)
    Common.SetExistPartyAegiomon(false)
    Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
    MapChangeWithTimeTravel("t", 304, "start_00", AXIS_ORIGINAL, "A2028_daft_342", NIGHT)
  end
end

function M340:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set("FLAG_MAIN_13_040")
    Execute("m340_020")
    PlayDungeonBGM()
    Obj:new(PLAYER, ""):SetPosLocator("start_00", true)
    SetFollowerCameraOperateRotation(0, 0)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M340:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_13_040", "FLAG_MAIN_13_045") then
    Cam.Inst:Set(-14.53, 0.308, 58.92, -12.38, 1.804, 67.79, default, 30)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_13_045")
    Execute("m340_021")
    Cam.Inst:Clear(0)
    FieldObjectSync(NPC, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M340:Event_056()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and not Flg.Check("FLAG_MAIN_13_046") then
    Flg.Set("FLAG_MAIN_13_046")
    Field_Talk_Start("t03", 1)
    AnswerTheCall()
    Cam.Inst:Set(-22.166, 3.513, -5.4581, -12.911, 0.9456, -2.6754, default, 45)
    Message("f_t0304_0030_0010")
    Message("f_t0304_0030_0020")
    Message("f_t0304_0030_0030")
    Message("f_t0304_0030_0040")
    Message("f_t0304_0030_0050")
    Cam.Inst:Clear(45)
    EndTheCall()
    Field_Talk_End()
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M340:Event_057()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and not Flg.Check("FLAG_MAIN_13_047") then
    Flg.Set("FLAG_MAIN_13_047")
    Field_Talk_Start("t03", 1)
    AnswerTheCall()
    Cam.Inst:Set(31.345, 4.7047, -1.0051, 22.4106, 2.5577, 2.9404, default, 45)
    Message("f_t0304_0040_0010")
    Message("f_t0304_0040_0020")
    Message("f_t0304_0040_0030")
    Message("f_t0304_0040_0040")
    Message("f_t0304_0040_0050")
    Message("f_t0304_0040_0060")
    Cam.Inst:Clear(45)
    EndTheCall()
    Field_Talk_End()
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M340:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) then
    Flg.Set("FLAG_MAIN_13_050")
    Execute("m340_030")
    MapChange("d", 1407, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M340:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) then
    Execute("m340_040")
    Sound.StopAmbientSE(0.3)
    Execute("m340_041")
    Guest.Delete(GST_HEROINE)
    Party.Aegiomon.SetExist(false)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("t", 3002, "start_01", AXIS_ORIGINAL, "P2028_daft_350", NIGHT)
  end
end

function M340:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_13_050", "FLAG_MAIN_13_070") then
    Flg.Set("FLAG_MAIN_13_070")
    Execute("m340_050")
    SetFollowerCameraOperateRotation(0, 0, 15)
    Flg.Set("FLAG_IS_SKIP_FADE_030")
    self:Event_090()
  end
end

function M340:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) then
    Flg.Set("FLAG_MAIN_13_080")
    Execute("m340_052")
    Execute("m340_053")
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    local org_prefix = "d"
    local org_number = 1204
    local org_locator = "start_00"
    local org_time_zone = noon
    Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
    Qst.Main:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChange("t", 3001, "start_01", false, FADE_BLACK, FADE_TIME)
  end
end
