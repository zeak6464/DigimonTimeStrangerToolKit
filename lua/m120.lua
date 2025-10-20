gGimText = "field_text"
M120 = {
  ID = 120,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_011 = 11,
  STEP_012 = 12,
  STEP_013 = 13,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_255 = 255
}

function M120:Event_010()
  if Flg.Check("FLAG_MAIN_03_450", "FLAG_MAIN_03_460") then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(21)
      Common.SetAegiomonGiftPoint(30000)
    end
    Flg.Set("FLAG_MAIN_03_460")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Common.ProhibitSave()
    Field.OverrideSeamlessTargetMap("d", 201)
    Flg.Clear("TUT_FLAG_4538")
    Flg.Clear("TUT_FLAG_4726")
    Flg.Clear("TUT_FLAG_4811")
    Flg.Clear("TUT_FLAG_4812")
    Flg.Clear("TUT_FLAG_4511")
    Flg.Set("TUT_FLAG_4552")
    Flg.Set("TUT_FLAG_4530")
    Flg.Set("TUT_FLAG_4606")
    Flg.Set("TUT_FLAG_4503")
    Flg.Set("TUT_FLAG_4504")
    Flg.Set("TUT_FLAG_4551")
    Item.Add(1, 10)
    Item.Add(2, 10)
    Item.Add(4, 5)
    Item.Add(7, 10)
    Item.Add(8, 10)
    Item.Add(10, 5)
    Item.Add(13, 5)
    Item.Add(26, 10)
    Item.Add(803, 1)
    Item.Add(30011, 5)
    Item.Add(30021, 5)
    Item.Add(30031, 5)
    Item.Add(30041, 5)
    Item.Add(30051, 5)
    Item.Add(30064, 5)
    Item.Add(30071, 5)
    Item.Add(30081, 5)
    Item.Add(30094, 5)
    Item.Add(30101, 5)
    Item.Add(30111, 5)
    Item.Add(30124, 5)
    Item.Add(30131, 5)
    Item.Add(30141, 5)
    Item.Add(30151, 5)
    Item.Add(30161, 5)
    Item.Add(30171, 5)
    Item.Add(30181, 5)
    Item.Add(30191, 5)
    Item.Add(30201, 5)
    Item.Add(30211, 5)
    Item.Add(30221, 5)
    Item.Add(30231, 5)
    Item.Add(30241, 5)
    Item.Add(30251, 5)
    Item.Add(30261, 5)
    Item.Add(30271, 5)
    Item.Add(30281, 5)
    Item.Add(30291, 5)
    Item.Add(30301, 5)
    Item.Add(30311, 5)
    Item.Add(30321, 5)
    Item.Add(30331, 5)
    Item.Add(31011, 3)
    Item.Add(31021, 3)
    Item.Add(32071, 3)
    Item.Add(32081, 3)
    Item.Add(33061, 3)
    Item.Add(34021, 3)
    Item.Add(34031, 3)
    Common.SetAegiomonSkill(1, 21831)
    FadeAllIn(FADE_BLACK, 0)
    Fade_Out(FADE_BLACK, 0)
    Field_StopBGM()
    Qst.Main:Start(self.ID, self.STEP_001)
    MapChange("d", 201, "start_00", false, 1, FADE_TIME)
  end
end

function M120:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_03_470")
    Execute("m120_030")
    PlayDungeonBGM()
    Obj:new(PLAYER, ""):SetPos(-24.49, 2.216, 79.718, true)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    Cam.Follower:ResetFromLocateAndPlayerRotate("start_01")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
  end
end

function M120:Event_Playable_DigeAttackTutorial()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check("FLAG_MAIN_03_560") then
    Flg.Set("FLAG_MAIN_03_560")
    WaitFrame(15)
  end
end

function M120:Event_PlayableBoss_Start()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    HideMinimap(true)
    HideGuide(true)
    local orga_index = GetIndex(NPC, "npc_orga01")
    local fuga_index = GetIndex(NPC, "npc_fuga01")
    local hyoga_index = GetIndex(NPC, "npc_hyoga01")
    Field.ObjectLoadMotion(NPC, orga_index, "bn01")
    Field.ObjectLoadMotion(NPC, orga_index, "f003")
    Field.ObjectLoadMotion(NPC, fuga_index, "bn01")
    Field.ObjectLoadMotion(NPC, fuga_index, "f003")
    Field.ObjectLoadMotion(NPC, hyoga_index, "bn01")
    Field.ObjectLoadMotion(NPC, hyoga_index, "f003")
    Field.ObjectLoadMotion(PLAYER, 1, "bn01")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Cam.Inst:Set(-1.434, -34.6, -1.813, 0.813, -32.999, 7.798, default, 20)
    Obj:new(PLAYER, ""):Invisible(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, orga_index, "bn01", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, fuga_index, "bn01", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hyoga_index, "bn01", 10, 10)
    WaitFrame(15)
    Obj:new(PLAYER, ""):SetPos(0.212, -34.6, 8.857, true)
    WaitFrame(5)
    Field.ObjectFrameMoveToTarget2D(PLAYER, 1, -0.076, 6.488, 6, 30)
    Obj:new(PLAYER, ""):CancelInvisible()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, orga_index, "f003", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, fuga_index, "f003", 10, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hyoga_index, "f003", 10, 10)
    WaitFrame(30)
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 10, true)
    WaitFrame(45)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
    Sound.PlayVoice("vo_mpc394_Attack_003")
    Sound.PlayVoice("vo_mpc579_Attack_003")
    Sound.PlayVoice("vo_mpc580_Attack_003")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    WaitFrame(30)
    EncountFromField_PlaySound(10350100, 10278, true)
  end
end

function M120:Event_PlayableBoss_End()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_03_590") then
    Cam.Inst:Clear(0)
    MapChange("e", 8, "start_00", false, 1, FADE_TIME)
  end
end

function M120:Event_PlayableThankYouForPlaying()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_03_590") then
    Display_ThankYouForPlaying()
    WaitFrame(30)
    Field.ToTitle()
  end
end

function M120:Event_020()
end

function M120:Event_033()
end

function M120:Event_035()
end

function M120:Event_038()
end

function M120:Event_040()
end

function M120:Event_050()
end

function M120:Event_060()
end

function M120:Event_063()
end

function M120:Event_065()
end

function M120:Event_066()
end

function M120:Event_068()
end

function M120:Event_070()
end

function M120:Event_080()
end

function M120:Event_090()
end

function M120:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
    step[#step + 1] = self.STEP_005
  end
  if 80 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_011
    step[#step + 1] = self.STEP_012
    step[#step + 1] = self.STEP_013
  end
  if 81 <= progress then
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
  end
  if 100 <= progress then
    step[#step + 1] = self.STEP_025
  end
  if 110 <= progress then
    step[#step + 1] = self.STEP_030
  end
  Qst.Main:Chapter(step, self.ID)
end
