M060 = {
  ID = 60,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_016 = 16,
  STEP_017 = 17,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_027 = 27,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_255 = 255
}

function M060:Event_010()
  if not Qst.Main:Check(self.ID, self.STEP_001) and Flg.Check("FLAG_MAIN_03_037", "FLAG_MAIN_03_040") then
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
    PlayRestJingle()
    Execute("m060_010")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    local player = Obj:new(PLAYER, "")
    SetFollowerCameraOperateRotation(0, player.rot_y + 10)
    Qst.Main:Start(self.ID, self.STEP_001)
    AnswerTheCall()
    local tlk = Tlk:new("t04", 1, true)
    tlk:StartTalk()
    tlk:Message("f_t0404_0240_0010")
    tlk:Message("f_t0404_0240_0020")
    tlk:Message("f_t0404_0240_0030")
    tlk:Message("f_t0404_0240_0040")
    tlk:EndTalk()
    EndTheCall()
    Field.OpenRequestDigiviceTamerSkill()
    Flg.Set("TUT_FLAG_4618")
    Flg.Set("TUT_FLAG_4620")
    Flg.Set("TUT_FLAG_4621")
  end
end

function M060:Event_015()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_03_037", "FLAG_MAIN_03_041") then
    local tlk = Tlk:new("t04", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0404_0250_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_MAIN_03_041")
  end
end

function M060:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_03_040")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    FieldObjectSync(RUMOR_NPC, true)
    Execute("m060_020")
    Obj:new(NPC, "npc_0402"):CancelInvisible()
    SetFollowerCameraOperateRotation(0, -90)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M060:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Execute("m060_030")
    Flg.Set("FLAG_MAIN_03_050")
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(FADE_TIME)
    Guest.Add(10012)
    TIME_ZONE = NOON
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M060:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Execute("m060_040")
    Guest.Add(30031)
    MapChange("d", 1101, "start_00", false, 0, FADE_TIME)
  end
end

function M060:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Flg.Set("FLAG_MAIN_03_060")
    Flg.Set("FLAG_MAIN_03_070")
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
    Execute("m060_050")
    Field.ObjectCheckSync(FOR_ALL, true)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Obj:new(NPC, "npc_elecmon"):CancelInvisible(nil, true)
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M060:Event_051()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_016) then
    Qst.Main:Set(self.ID, self.STEP_016)
  end
end

function M060:Event_052()
  if Qst.Main:Check(self.ID, self.STEP_016, self.STEP_017) then
    Qst.Main:Set(self.ID, self.STEP_017)
  end
end

function M060:Event_060()
  if not Flg.Check("FLAG_GIMMICK_D11_020") then
    local tlk = Tlk:new("d11", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1101_0020_0010")
    tlk:EndTalk()
  end
  if Qst.Main:Check(self.ID, self.STEP_017, self.STEP_020) then
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M060:Event_065()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M060:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_03_065") then
    Qst.Main:Set(self.ID, self.STEP_027)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_03_065")
    Execute("m060_070")
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end

function M060:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_027, self.STEP_030) then
    Flg.Set("FLAG_MAIN_03_080")
    Execute("m060_080")
    Field.ObjectCheckSync(FOR_ALL, true)
    WaitFrame(FADE_TIME)
    FadeInWithWaitNotFlgCheck(0, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_030)
  end
end

function M060:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    Flg.Set("FLAG_MAIN_03_090")
    Execute("m060_090")
    Guest.Delete(30031)
    Field.ObjectCheckSync(FOR_ALL, true)
    WaitFrame(FADE_TIME)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_035)
  end
end

function M060:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_255) and not Flg.Check("FLAG_MAIN_03_100") then
    Flg.Set("FLAG_IS_KEEP_BGM")
    Execute("m060_100")
    Guest.Add(GST_ELEC)
    Battle.Encount(10310100, 11172, false)
  end
end

function M060:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_255) and Flg.Check("FLAG_MAIN_03_100") then
    Execute("m060_150")
    Common.SetDigimonGraspState(183, DIGIMON_GRASP_FLAG_JOIN)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("t", 403, "start_00", AXIS_ORIGINAL, "A2020_dbef_61", NIGHT)
  end
end

function M060:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_255) then
    Flg.Set("FLAG_MAIN_03_110")
    Execute("m060_160")
    Guest.Delete(10012)
    if Party.Aegiomon.IsExist() then
      Party.Aegiomon.SetExist(false)
    end
    Qst.Main:End(self.ID, self.STEP_255)
    Restore.Party()
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(0)
    end
    MapChangeWithTimeTravel("t", 404, "start_01", AXIS_ORIGINAL, "A2020_dbef_70", NOON)
  end
end

function M060:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
    step[#step + 1] = self.STEP_005
  end
  if 40 <= progress then
    step[#step + 1] = self.STEP_010
  end
  if 70 <= progress then
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_016
    step[#step + 1] = self.STEP_017
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_025
  end
  if 80 <= progress then
    step[#step + 1] = self.STEP_027
  end
  if 90 <= progress then
    step[#step + 1] = self.STEP_030
  end
  if 100 <= progress then
    step[#step + 1] = self.STEP_035
  end
  Qst.Main:Chapter(step, self.ID)
end
