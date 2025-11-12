gGimText = "field_text"
M320 = {
  ID = 320,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_255 = 255
}

function M320:Event_010()
  if Flg.Check("FLAG_MAIN_11_070", "FLAG_MAIN_11_080") then
    BackFade_OutNoLoadingWithWait(FADE_BLACK, 0)
    Flg.Set("FLAG_MAIN_11_080")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Cam.Inst:Set(-13.35, 1.45, 3.864, -6.751, 0.932, -3.63, default, 0)
    local pc = Obj:new(PLAYER, "")
    local inori_index = GetIndex(FLD_OBJ_FOLLOWER, "guest", GST_HEROINE)
    local aegio_index = Field.GetFollowerIndexForAegiomon()
    pc:SetRotationY(45, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, inori_index, -10.388, 0, -1.221, true)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, inori_index, 45, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, aegio_index, -9.017, 0, 0.208, true)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio_index, 45, 0)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(80)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    SetFollowerCameraOperateRotation(-10, pc.rot_y + 180)
    FieldObjectSync(FLD_OBJ_GIMMICK, true)
    WaitFrame(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false, true)
    Digitter.Send(1320010010)
  end
end

function M320:Event_015()
  if Flg.Check("FLAG_MAIN_11_080", "FLAG_MAIN_11_085") then
    Flg.Set("FLAG_MAIN_11_085")
    Execute("m320_011")
    Guest.Add(GST_GRAPLEO)
    FieldObjectSync(FOR_ALL, false)
    Common.SetDigimonGraspState(403, DIGIMON_GRASP_FLAG_SCAN)
    INFO_WINDOW(7048)
    SetFollowerCameraOperateRotation(0, 225)
    local pc = Obj:new(PLAYER, "")
    pc:SetPos(10.479, 0, -3.648)
    pc:SetRotationY(225, 0)
    Field.FollowerWarp()
    WaitFrame(10)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M320:Event_018()
  if Flg.Check("FLAG_MAIN_11_085", "FLAG_MAIN_12_010") then
    Digitter.Send(1320015010)
  end
end

function M320:Event_019()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) then
    local fldtxt = "d05"
    local bn01 = Motion.Object:new(NPC, "npc_0662", "bn01")
    local fq01 = Motion.Object:new(NPC, "npc_0662", "fq01")
    local fq02 = Motion.Object:new(NPC, "npc_0662", "fq02")
    local npc_name = "npc_0662"
    START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Message("f_d0501_0270_0020")
    fq01:Play(20, true)
    Message("f_d0501_0270_0030")
    bn01:Play(20, true)
    Flg.Set("FLAG_MAIN_11_086")
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_End_Not_LetterBox()
    BackFade_OutNoLoadingWithWait(FADE_BLACK, 10)
    WaitFrame(20)
    Obj:new(NPC, "npc_0662"):Invisible(30, true)
    FieldObjectSync(FOR_ALL, false)
    BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_003)
  end
end

function M320:Event_019A()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M320:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new("d05", 1, true)
    local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
    local player_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local fq01 = Motion.Object:new(NPC, "npc_0001", "fq01")
    local bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
    local fe02 = Motion.Object:new(NPC, "npc_0001", "fe02")
    local fe04 = Motion.Object:new(NPC, "npc_0001", "fe04")
    START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    tlk:StartTalkAndCancelDigimonRide()
    if not Flg.Check("FLAG_MAIN_12_010") then
      Flg.Set("FLAG_MAIN_12_010")
      fq01:Play(20, true)
      tlk:Message("f_d0506_0140_0010")
      tlk:Message("f_d0506_0140_0020")
      bn01:Play(20, true)
      tlk:MessageClose()
      player_e002_01:Play(10, false)
      WaitFrame(40)
      player_fn01_01:Play(10, true)
      fq01:Play(20, true)
      tlk:Message("f_d0506_0140_0030")
      tlk:Message("f_d0506_0140_0040")
      tlk:Message("f_d0506_0140_0050")
      fe02:Play(20, true)
      tlk:Message("f_d0506_0140_0060")
      bn01:Play(20, true)
      tlk:Message("f_d0506_0140_0070")
      fe04:Play(20, true)
      tlk:Message("f_d0506_0140_0080")
      bn01:Play(20, true)
      tlk:Message("f_d0506_0140_0090")
      tlk:Message("f_d0506_0140_0100")
      tlk:Message("f_d0506_0140_0110")
      bn01:Play(20, true)
      local result = tlk:Select(2, "f_d0506_0140_0130")
      if result == RESULT_TALK00 then
        fq01:Play(20, true)
        tlk:Message("f_d0506_0140_0150")
        tlk:Message("f_d0506_0140_0160")
        bn01:Play(20, true)
        Flg.Set("FLAG_MAIN_12_015")
        Qst.Main:Set(self.ID, self.STEP_010)
        FieldObjectSync(FOR_ALL, false)
        Digimon.RestoreAllParty()
      else
        fe02:Play(20, true)
        tlk:Message("f_d0506_0140_0140")
        bn01:Play(20, true)
      end
    else
      tlk:Message("f_d0506_0140_0120")
      local result = tlk:Select(2, "f_d0506_0140_0130")
      if result == RESULT_TALK00 then
        fq01:Play(20, true)
        tlk:Message("f_d0506_0140_0150")
        tlk:Message("f_d0506_0140_0160")
        bn01:Play(20, true)
        Flg.Set("FLAG_MAIN_12_015")
        Qst.Main:Set(self.ID, self.STEP_010)
        FieldObjectSync(FOR_ALL, false)
        Digimon.RestoreAllParty()
      else
        fe02:Play(20, true)
        tlk:Message("f_d0506_0140_0140")
        bn01:Play(20, true)
      end
    end
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
  end
end

function M320:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_12_015", "FLAG_MAIN_12_020") then
    Sound.StopBGM(0)
    Execute("arena_m320_01")
    Fade_OutNoLoadingWithWait(FADE_WHITE, 0)
    EncountFromField(11110110, 10577, true)
  end
end

function M320:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_12_020", "FLAG_MAIN_12_025") then
    Flg.Set("FLAG_MAIN_12_025")
    M320Arena_Battle_After(1)
    MapChange("d", 506, "start_03", true, FADE_BLACK, FADE_TIME)
  end
end

function M320:Event_045A()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_12_025", "FLAG_MAIN_12_026") then
    Flg.Set("FLAG_MAIN_12_026")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0506_0170_0010")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M320:Event_047()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_12_026", "FLAG_MAIN_12_027") then
    Sound.StopBGM(0)
    Execute("arena_m320_02")
    Fade_OutNoLoadingWithWait(FADE_WHITE, 0)
    EncountFromField(11110120, 10579, true)
  end
end

function M320:Event_048()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_12_027", "FLAG_MAIN_12_028") then
    Flg.Set("FLAG_MAIN_12_028")
    M320Arena_Battle_After(2)
    MapChange("d", 506, "start_03", true, FADE_BLACK, FADE_TIME)
  end
end

function M320:Event_048A()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_MAIN_12_028", "FLAG_MAIN_12_029") then
    Flg.Set("FLAG_MAIN_12_029")
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0506_0170_0020")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M320:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_12_029", "FLAG_MAIN_12_030") then
    Sound.StopBGM(0)
    Execute("arena_m320_03")
    Fade_OutNoLoadingWithWait(FADE_WHITE, 0)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    EncountFromField(11110130, 10580, true)
  end
end

function M320:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_12_030", "FLAG_MAIN_12_031") then
    Flg.Set("FLAG_MAIN_12_031")
    Digimon.RestoreAllParty()
    MapChange("d", 506, "start_03", true, FADE_BLACK, 0)
  end
end

function M320:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) and Flg.Check("FLAG_MAIN_12_031", "FLAG_MAIN_12_032") then
    Flg.Set("FLAG_MAIN_12_032")
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0506_0170_0030")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M320:Event_065()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_12_032", "FLAG_MAIN_12_035") then
    Sound.StopBGM(0)
    Execute("arena_m320_04")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, 0)
    EncountFromField(11110140, 10576, true)
  end
end

function M320:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_12_035", "FLAG_MAIN_12_040") then
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    Digimon.RestoreAllParty()
    EncountFromField(11110500, 10576, false)
    WaitFrame(30)
  end
end

function M320:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_12_040", "FLAG_MAIN_12_050") then
    Guest.Delete(GST_GRAPLEO)
    Common.SetDigimonGraspState(174, DIGIMON_GRASP_FLAG_SCAN)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("t", 3002, "start_00", AXIS_ORIGINAL, "A2028_daft_330", NIGHT)
  end
end

function M320:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_12_040", "FLAG_MAIN_12_050") then
    Flg.Set("FLAG_MAIN_12_050")
    Execute("m320_070")
    MapChange("t", 3001, "start_01", false, FADE_BLACK, FADE_TIME)
  end
end

function M320:Event_093()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) and Flg.Check("FLAG_MAIN_12_050", "FLAG_MAIN_12_053") then
    Flg.Set("FLAG_MAIN_12_053")
    Prcs_t3001_12GodsReliefInvisible(true)
    Execute("m320_080")
    Prcs_t3001_12GodsReliefInvisible(false)
    Flg.Set("FLAG_GIMMICK_T0301_005")
    Prcs_t3001_12GodsReliefSeting()
    MapChangeWithTimeTravel("d", 506, "start_50", AXIS_ORIGINAL, "A2028_daft_330", NOON)
  end
end

function M320:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_255) and Flg.Check("FLAG_MAIN_12_053", "FLAG_MAIN_12_055") then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(81)
    end
    local npc_index01 = GetIndex(NPC, "npc_0001")
    local fe04 = Motion.Object:new(NPC, "npc_0001", "fe04")
    local bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
    Qst.Main:End(self.ID, self.STEP_255)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Cam.Inst:Set(-17.825, 1.079, 113.162, -10.523, 0.897, 106.332, default, 0)
    local pc = Obj:new(PLAYER, "")
    local heroine = Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest")
    local aegio = Field.GetFollowerIndexForAegiomon()
    pc:SetRotationY(45, 0)
    heroine:SetPos(-13.909, 0, 108.709, true)
    heroine:SetRotationY(45, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, aegio, -12.904, 0, 109.794)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio, 45, 0)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(80)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-7.853, 0.529, 102.564, -14.005, 1.583, 110.376, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0506_0190_0010")
    tlk:Message("f_d0506_0190_0020")
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index01, 185, 0)
    Cam.Inst:Set(-5.611, 1.18, 76.496, -9.669, 2.089, 85.59, default, 0)
    fe04:Play(20, true)
    tlk:Message("f_d0506_0190_0030")
    tlk:Message("f_d0506_0190_0040")
    bn01:Play(20, true)
    tlk:MessageClose()
    INFO_WINDOW(7049)
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    ObjectResetRotation(FLD_OBJ_NPC, npc_index01, 0, true)
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_12_055")
    require("Sarena_300")
    Sarena_300:GreatestOmegaCarnival_Start()
    Flg.Set("FLAG_FREEARENA_RELEASE_001")
    Flg.Set("FLAG_FREEARENA_RELEASE_002")
    Flg.Set("FLAG_FREEARENA_RELEASE_003")
    Flg.Set("FLAG_FREEARENA_RELEASE_004")
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(30)
  end
end

function M320Arena_Battle_After(battle_num)
  Digimon.RestoreAllParty()
  local tlk = Tlk:new("arena01", 1, true, false)
  tlk:StartTalkAndCancelDigimonRide()
  Cam.Inst:Set(3.331, 0.9, -18.929, -1.304, 1.786, -7.085, default, 0)
  InvisibleNpcInArena()
  Obj:new(PLAYER, ""):SetPos(0, -0.001, -10, true)
  Obj:new(PLAYER, ""):SetRotationY(180, 0)
  Field.ObjectLoadMotion(PLAYER, 1, "e004")
  FollowerSync()
  WaitFrame(5)
  Field.FollowerWarp()
  WaitFrame(5)
  SetHeroine_m320("e004_01", -1.296, 0, -10.784, 180)
  SetAegio_m320("e004", -0.595, 0, -10.322, 180)
  SetPartyMember_m320("ba01", -0.416, -0.001, -13.342, 180, 1)
  SetPartyMember_m320("ba01", 1.011, 0, -13.035, 180, 2)
  SetPartyMember_m320("ba01", -2.341, 0, -13.176, 180, 3)
  Field.ObjectLoadMotion(NPC, GetIndex(NPC, "npc0008"), "e004")
  Obj:new(NPC, "npc0008"):CancelInvisible()
  local party = Field.GetFollowerIndexByGuestID(GST_GRAPLEO)
  Field.ObjectInvisible(FLD_OBJ_FOLLOWER, party, 0, 0, true)
  FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  WaitFrame(15)
  Field.ObjectPlayMotion(PLAYER, 1, "e004", 5, true)
  PlayHeroineMotion_m320("e004_01")
  PlayAegioMotion_m320("e004")
  PlayPartyMemberMotion_m320("ba01", 1)
  PlayPartyMemberMotion_m320("ba01", 2)
  PlayPartyMemberMotion_m320("ba01", 3)
  Field.ObjectPlayMotion(NPC, GetIndex(NPC, "npc0008"), "e004", 5, true)
  local win_message = "arena01_m320_010_060"
  if battle_num == 1 then
    win_message = "arena01_m320_010_060"
  elseif battle_num == 2 then
    win_message = "arena01_m320_020_060"
  elseif battle_num == 3 then
    win_message = "arena01_m320_030_060"
  elseif battle_num == 4 then
    win_message = "arena01_m320_040_060"
  end
  tlk:Message(win_message)
  tlk:EndTalk()
end

function SetHeroine_m320(motion_name, posx, posy, posz, rot)
  local heroine = Field.GetFollowerIndexByGuestID(GST_HEROINE)
  if heroine ~= nil then
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, heroine, motion_name)
    Field.ObjectCancelInvisible(FLD_OBJ_FOLLOWER, heroine, 0, 0, true)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, heroine, rot, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, heroine, posx, posy, posz, true)
  end
end

function PlayHeroineMotion_m320(motion_name)
  local heroine = Field.GetFollowerIndexByGuestID(GST_HEROINE)
  if heroine ~= nil then
    Field.ObjectPlayMotion(FLD_OBJ_FOLLOWER, heroine, motion_name, 5, true)
  end
end

function SetAegio_m320(motion_name, posx, posy, posz, rot)
  local aegio = Field.GetFollowerIndexForAegiomon()
  if aegio ~= nil then
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, aegio, motion_name)
    Field.ObjectCancelInvisible(FLD_OBJ_FOLLOWER, aegio, 0, 0, true)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio, rot, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, aegio, posx, posy, posz, true)
  end
end

function PlayAegioMotion_m320(motion_name)
  local aegio = Field.GetFollowerIndexForAegiomon()
  if aegio ~= nil then
    Field.ObjectPlayMotion(FLD_OBJ_FOLLOWER, aegio, motion_name, 5, true)
  end
end

function SetPartyMember_m320(motion_name, posx, posy, posz, rot, partypos)
  local index = Digimon.GetUniqueIDInPartyMember(partypos)
  if index ~= nil then
    local party = Field.GetFollowerIndexByPartyUniqueID(index)
    Field.ObjectCancelInvisible(FLD_OBJ_FOLLOWER, party, 0, 0, true)
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, party, motion_name)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, party, rot, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, party, posx, posy, posz, true)
  end
end

function PlayPartyMemberMotion_m320(motion_name, partypos)
  local index = Digimon.GetUniqueIDInPartyMember(partypos)
  if index ~= nil then
    local party = Field.GetFollowerIndexByPartyUniqueID(index)
    Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_FOLLOWER, party, motion_name, 5, 10)
  end
end

function SetGrapleomon_m320(motion_name, posx, posy, posz, rot)
  if Common.IsExistGuest(GST_GRAPLEO) then
    local party = Field.GetFollowerIndexByGuestID(GST_GRAPLEO)
    Field.ObjectCancelInvisible(FLD_OBJ_FOLLOWER, party, 0, 0, true)
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, party, motion_name)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, party, rot, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, party, posx, posy, posz, true)
  end
end

function PlayGrapleomonMotion_m320(motion_name)
  if Common.IsExistGuest(GST_GRAPLEO) then
    local party = Field.GetFollowerIndexByGuestID(GST_GRAPLEO)
    Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_FOLLOWER, party, motion_name, 5, 10)
  end
end

function M320:ChapterFlagSet(progress)
  local step = {}
  if 10 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 20 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 70 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
    step[#step + 1] = self.STEP_025
  end
  Qst.Main:Chapter(step, self.ID)
end
