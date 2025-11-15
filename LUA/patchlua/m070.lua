M070 = {
  ID = 70,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}

function M070:Event_010()
  if Flg.Check("FLAG_MAIN_03_110", "FLAG_MAIN_03_120") then
    Flg.Set("FLAG_MAIN_03_120")
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    PlayRestJingle()
    Execute("m070_010")
    PlayDungeonBGM()
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M070:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_03_125")
    Execute("m070_020")
    Field_InvisibleObjects(MOB, 1, 2)
    FieldObjectSync(FOR_ALL, false)
    Obj:new(RUMOR_NPC, "aegio_02"):Invisible()
    Guest.Add(30021)
    if 1 > Common.GetGameClearNum() then
      Party.Aegiomon.Add(8)
    elseif Party.Aegiomon.IsExist() == false then
      Party.Aegiomon.SetExist(true)
    end
    Qst.Main:Set(self.ID, self.STEP_005)
    Obj:new(NPC, "npc_0018"):Invisible(0)
    Cam.Inst:Set(9.602, 0.35, 0.949, -0.3225, 1.558, 0.752, default, 30)
    local tlk = Tlk:new("d09", 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_MAIN_03_126")
    local result = tlk:Select(2, "f_d0900_0010_0070")
    if result == RESULT_TALK00 then
      tlk:EndTalk(true)
      MapChange("t", 302, "start_00", true, FADE_BLACK, FADE_TIME)
    elseif result == RESULT_TALK01 then
      tlk:EndTalk()
      local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
      SetFollowerCameraOperateRotation(0, rot + 20, 0)
      Cam.Inst:Clear(30)
      Obj:new(NPC, "npc_0018"):CancelInvisible(15)
    end
  end
end

function M070:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and not Flg.Check("FLAG_MAIN_03_130") then
    Flg.Set("FLAG_MAIN_03_130")
    Sound.StopBGM(0.5)
    Execute("m070_030")
    self:Event_040()
  end
end

function M070:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Execute("m070_040")
    self:Event_045()
  end
end

function M070:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    self:Event_050()
  end
end

function M070:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 109, "start_20", false, 0, FADE_TIME)
  end
end

function M070:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_03_130", "FLAG_MAIN_03_140") then
    EncountFromField_WithNormalEffect(10320100, 172, false)
  end
end

function M070:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_03_140") then
    Sound.StopBGM(0)
    Guest.Delete(30021)
    Party.Aegiomon.SetExist(false)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("t", 302, "start_00", AXIS_ORIGINAL, "A2020_dbef_71", EVENING)
  end
end

function M070:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_03_140", "FLAG_MAIN_03_143") then
    Party.Aegiomon.SetExist(false)
    Execute("m070_080")
    Qst.Main:Set(self.ID, self.STEP_010)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_03_143")
    FieldObjectSync(FOR_ALL, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M070:Event_085()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Digitter.Send(1070090010, true)
  end
end

function M070:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    FadeOutWithWait(0, 30)
    Obj:new(NPC, "Girlchild_01"):Invisible()
    Field_InvisibleObjects(RUMOR_NPC, 1, 1)
    Execute("m070_090")
    Qst.Main:Set(self.ID, self.STEP_015)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("t", 404, "start_01", false, 0, FADE_TIME)
  end
end

function M070:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) then
    Flg.Set("FLAG_MAIN_03_150")
    Execute("m070_100")
    Qst.Main:End(self.ID, self.STEP_255)
    Party.Aegiomon.SetExist(true)
    Restore.Party()
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(3)
    end
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChangeWithTimeTravel("t", 404, "start_01", AXIS_ORIGINAL, "A2020_dbef_80", NOON)
  end
end

function M070:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 30 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 90 <= progress then
    step[#step + 1] = self.STEP_010
  end
  Qst.Main:Chapter(step, self.ID)
end
