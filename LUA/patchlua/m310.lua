gGimText = "field_text"
M310 = {
  ID = 310,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_008 = 8,
  STEP_010 = 10,
  STEP_013 = 13,
  STEP_015 = 15,
  STEP_025 = 25,
  STEP_026 = 26,
  STEP_027 = 27,
  STEP_028 = 28,
  STEP_030 = 30,
  STEP_035 = 35,
  STEP_040 = 40,
  STEP_045 = 45,
  STEP_050 = 50,
  STEP_255 = 255
}

function M310:Event_010()
  if Flg.Check("FLAG_MAIN_10_058", "FLAG_MAIN_10_060") then
    PlayDungeonBGM()
    Flg.Set("FLAG_MAIN_10_060")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Field_InvisibleFollowerAllPartyMember(0, 30, false)
    Field_InvisibleFollowerAllGuest(0, 20, false)
    Field.ResetPlayer(1.2, 0, -7, 0)
    local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
    local tlk = Tlk:new("d04", 1, true, false)
    Field.ObjectLookAtTheObject(PLAYER, 1, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "bacchus_01"), 0)
    Cam.Inst:Set(1.793, 2.15, -12.49, 4.362, 1.76, -2.842, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0404_0510_0010")
    tlk:Message("f_d0404_0510_0020")
    tlk:Message("f_d0404_0510_0030")
    tlk:Message("f_d0404_0510_0040")
    tlk:MessageClose()
    player_e002_01:Play(10, false)
    Motion.Player:Wait()
    tlk:Message("f_d0404_0510_0050")
    tlk:Message("f_d0404_0510_0060")
    tlk:Message("f_d0404_0510_0070")
    tlk:Message("f_d0404_0510_0080")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Qst.Main:End(M300.ID, M300.STEP_255)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(5)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M310:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_10_060", "FLAG_MAIN_10_070") then
    Flg.Set("FLAG_MAIN_10_070")
    Execute("m310_010")
    SetFollowerCameraOperateRotation(0, 160)
    Map:OpenArea(105, true)
    Map:CloseArea(105, false)
    Map:ClosePlace(10501, true)
    Map:OpenPlace(10521, true)
    Map:ClosePlace(10521, false)
    Map:OpenPlace(10211, true)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M310:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_008) then
    local tlk = Tlk:new("d05", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0501_0390_0010")
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_008)
  end
end

function M310:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_008, self.STEP_010) then
    Flg.Set("FLAG_MAIN_11_000")
    Execute("m310_020")
    Qst.Main:Set(self.ID, self.STEP_010)
    FieldObjectSync(FOR_ALL, false)
    Obj:new(PLAYER, ""):SetPos(-69.282, -10.376, 56.196)
    Obj:new(PLAYER, ""):SetRotationY(45, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d09", 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    local result = tlk:Select(2, "f_d0900_0010_0070")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      Digitter.Send(1310005010)
      MapChange("d", 216, "start_10", true, FADE_BLACK, FADE_TIME)
    elseif result == RESULT_TALK01 then
      tlk:EndTalk()
    end
  end
end

function M310:Event_035()
  if Flg.Check("FLAG_MAIN_11_000", "FLAG_MAIN_11_005") then
    Digitter.Send(1310005010)
  end
end

function M310:Event_038()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_013) and Flg.Check("FLAG_MAIN_11_000", "FLAG_MAIN_11_003") then
    Flg.Set("FLAG_MAIN_11_003")
    local tlk = Tlk:new("d12", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1204_0700_0010")
    tlk:Message("f_d1204_0700_0020")
    Cam.Inst:Set(4.213, -0.836, -68.089, 1.13, 1.085, -58.772, default, 20)
    WaitFrame(20)
    tlk:Message("f_d1204_0700_0030")
    Cam.Inst:Clear(20)
    WaitFrame(20)
    tlk:EndTalk()
    Qst.Main:Set(self.ID, self.STEP_013)
  end
end

function M310:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_013, self.STEP_015) then
    Flg.Set("FLAG_MAIN_11_005")
    local tlk = Tlk:new("d12", 1, true)
    local npc_index01 = GetIndex(NPC, "npc_0222")
    local bn01 = Motion.Object:new(NPC, "npc_0222", "bn01")
    local bn02 = Motion.Object:new(NPC, "npc_0222", "bn02")
    local fe02 = Motion.Object:new(NPC, "npc_0222", "fe02")
    local fq01 = Motion.Object:new(NPC, "npc_0222", "fq01")
    local fq02 = Motion.Object:new(NPC, "npc_0222", "fq02")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Set(0.935, -1.991, -68.843, 1.442, 1.896, -59.644, default, 0)
    Obj:new(PLAYER, ""):SetPos(0.972, 0.03, -60.73, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    START_TALK_ACTION_AND_ZOOM("npc_0222", true, false)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message("f_d1204_0530_0010")
    Field.ObjectResetAim(NPC, npc_index01, 10)
    fq01:Play(10, true)
    tlk:Message("f_d1204_0530_0020")
    START_TALK_ACTION_AND_ZOOM("npc_0222", true, false)
    bn01:Play(10, true)
    tlk:Message("f_d1204_0530_0030")
    tlk:Message("f_d1204_0530_0040")
    tlk:Message("f_d1204_0530_0050")
    fe02:Play(10, true)
    tlk:Message("f_d1204_0530_0060")
    bn01:Play(10, true)
    tlk:Message("f_d1204_0530_0070")
    Field.ObjectResetAim(NPC, npc_index01, 10)
    fq02:Play(10, true)
    tlk:Message("f_d1204_0530_0080")
    START_TALK_ACTION_AND_ZOOM("npc_0222", true, false)
    bn01:Play(10, true)
    tlk:Message("f_d1204_0530_0090")
    tlk:Message("f_d1204_0530_0100")
    Cam.Inst:Set(-0.408, 0.731, -68.27, 1.953, 1.747, -58.606, default, 20)
    WaitFrame(20)
    tlk:Message("f_d1204_0530_0130")
    Field.SetPlayerRotation(220, 30)
    Cam.Inst:Set(-4.9597, 0.7428, -56.175, -5.966, 2.415, -46.36, default, 20)
    tlk:Message("f_d1204_0530_0140")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    END_TALK_ACTION_AND_ZOOM("npc_0222", true, false)
    Cam.Inst:Clear(0)
    SetFollowerCameraOperateRotation(0, 220)
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_015)
    Digitter.Send(1310015010)
  end
end

function M310:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_025) then
    local pc_ride_in01 = Motion.Object:new(PLAYER, "", "ride_in01")
    local tlk = Tlk:new("d12", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    if not Flg.Check("FLAG_MAIN_11_008") then
      Flg.Set("FLAG_MAIN_11_008")
      tlk:Message("f_d1204_0710_0010")
      tlk:Message("f_d1204_0710_0020")
    else
      tlk:Message("f_d1204_0710_0040")
    end
    local result = tlk:Select(2, "f_d1204_0710_0050")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      Map:ClosePlace(103, false)
      pc_ride_in01:Play(10, false)
      WaitFrame(5)
      MapChange("t", 103, "start_22", true, FADE_BLACK, FADE_TIME)
    end
    tlk:EndTalk()
  end
end

function M310:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_025) and not Flg.Check("FLAG_MAIN_11_009") then
    local pos = Field.ObjectGetPosition(PLAYER, 1)
    Cam.Inst:Set(pos.x, pos.y + 2, pos.z + 2, pos.x + 3, pos.y + 2, pos.z + 4, default, 30)
    Flg.Set("FLAG_MAIN_11_009")
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectLookAtTheObject(PLAYER, 1, FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "icon_arena01"), 30)
    tlk:Message("f_t0103_0110_0010")
    tlk:Message("f_t0103_0110_0020")
    tlk:EndTalk()
    Common.CancelProhibitSave()
  end
end

function M310:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_025) and not Flg.Check("FLAG_MAIN_11_015") then
    local npc_name = "npc_0203"
    local fldtxt = "t01"
    local npc_index01 = GetIndex(NPC, "npc_0203")
    local kouan_e005 = Motion.Object:new(NPC, "npc_0203", "e005")
    local kouan_e008 = Motion.Object:new(NPC, "npc_0203", "e008")
    local kouan_e004 = Motion.Object:new(NPC, "npc_0203", "e004")
    Field.ObjectLoadExpression(NPC, npc_index01, "F03_T01")
    Cam.Inst:Set(-15.43, 0.099, -36.523, -6.154, 2.105, -39.677, default, 30)
    WaitFrame(45)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 30)
    Field.ObjectChangeExpression(NPC, npc_index01, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    kouan_e005:Play(20, true)
    Message("f_t0103_0120_0010")
    kouan_e008:Play(20, true)
    Message("f_t0103_0120_0020")
    Message("f_t0103_0120_0030")
    kouan_e004:Play(20, true)
    Message("f_t0103_0120_0040")
    Field.ObjectResetMotion(NPC, npc_index01, 30)
    Field_Talk_End_Not_LetterBox()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_11_015")
    FieldObjectSync(FOR_ALL, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_025) then
    if not Flg.Check("FLAG_MAIN_11_020") then
      Flg.Set("FLAG_MAIN_11_020")
      local npc_index01 = GetIndex(NPC, "npc_0001")
      local bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
      local fe02 = Motion.Object:new(NPC, "npc_0001", "fe02")
      local fe04 = Motion.Object:new(NPC, "npc_0001", "fe04")
      local fq01 = Motion.Object:new(NPC, "npc_0001", "fq01")
      local player = Obj:new(PLAYER, "")
      local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
      local player_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
      local tlk = Tlk:new("t01", 1, true)
      START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_t0121_050_0010")
      fq01:Play(20, false)
      tlk:Message("f_t0121_050_0020")
      bn01:Play(20, true)
      tlk:MessageClose()
      player_e002_01:Play(10, false)
      WaitFrame(40)
      player_fn01_01:Play(10, true)
      fe04:Play(20, false)
      tlk:Message("f_t0121_050_0030")
      bn01:Play(20, true)
      tlk:Message("f_t0121_050_0040")
      fq01:Play(20, false)
      tlk:Message("f_t0121_050_0050")
      bn01:Play(20, true)
      tlk:Message("f_t0121_050_0060")
      fe02:Play(20, false)
      tlk:Message("f_t0121_0010_0010")
      local result = tlk:Select(2, "f_t0121_0010_0020")
      if result == RESULT_TALK00 then
        Qst.Main:Set(self.ID, self.STEP_025)
        Flg.Set("FLAG_MAIN_11_029")
        fq01:Play(20, false)
        tlk:Message("f_t0121_060_0010")
        bn01:Play(20, true)
      else
        tlk:Message("f_t0121_0010_0040")
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    else
      local bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
      local fe02 = Motion.Object:new(NPC, "npc_0001", "fe02")
      local fq01 = Motion.Object:new(NPC, "npc_0001", "fq01")
      local tlk = Tlk:new("t01", 1, true)
      START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
      tlk:StartTalkAndCancelDigimonRide()
      fe02:Play(20, false)
      tlk:Message("f_t0121_0010_0010")
      local result = tlk:Select(2, "f_t0121_0010_0020")
      if result == RESULT_TALK00 then
        Qst.Main:Set(self.ID, self.STEP_025)
        Flg.Set("FLAG_MAIN_11_029")
        fq01:Play(20, false)
        tlk:Message("f_t0121_060_0010")
        bn01:Play(20, true)
        Digimon.RestoreAllParty()
      else
        tlk:Message("f_t0121_0010_0040")
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    end
    FieldObjectSync(FOR_ALL, false)
  end
end

function M310:Event_065A()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_026) and Flg.Check("FLAG_MAIN_11_029", "FLAG_MAIN_11_021") then
    local tlk = Tlk:new("t01", 1, true)
    START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0121_0010_0050")
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
  end
end

function M310:Event_065B()
  if Qst.Main:Check(self.ID, self.STEP_026, self.STEP_027) then
    local flg = {
      "FLAG_MAIN_11_021"
    }
    if Flg.AllCheck(flg) and Flg.Check("FLAG_MAIN_11_029", "FLAG_MAIN_11_022") then
      local tlk = Tlk:new("t01", 1, true)
      START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_t0121_060_0020")
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    end
  end
end

function M310:Event_065C()
  if Qst.Main:Check(self.ID, self.STEP_027, self.STEP_028) then
    local flg = {
      "FLAG_MAIN_11_021",
      "FLAG_MAIN_11_022"
    }
    if Flg.AllCheck(flg) and Flg.Check("FLAG_MAIN_11_029", "FLAG_MAIN_11_023") then
      local tlk = Tlk:new("t01", 1, true)
      START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_t0121_060_0030")
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    end
  end
end

function M310:Event_065D()
  if Qst.Main:Check(self.ID, self.STEP_028, self.STEP_030) then
    local flg = {
      "FLAG_MAIN_11_021",
      "FLAG_MAIN_11_022",
      "FLAG_MAIN_11_023"
    }
    if Flg.AllCheck(flg) and Flg.Check("FLAG_MAIN_11_029", "FLAG_MAIN_11_024") then
      local tlk = Tlk:new("t01", 1, true)
      START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_t0121_060_0040")
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    end
  end
end

function M310:Event_065E()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    local flg = {
      "FLAG_MAIN_11_021",
      "FLAG_MAIN_11_022",
      "FLAG_MAIN_11_023",
      "FLAG_MAIN_11_024"
    }
    if Flg.AllCheck(flg) and Flg.Check("FLAG_MAIN_11_029", "FLAG_MAIN_11_025") then
      local tlk = Tlk:new("t01", 1, true)
      local fe02 = Motion.Object:new(NPC, "npc_0001", "fe02")
      local bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
      START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
      tlk:StartTalkAndCancelDigimonRide()
      fe02:Play(20, false)
      tlk:Message("f_t0121_060_0050")
      bn01:Play(20, true)
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    end
  end
end

function M310:Event_065F()
  local flg = {
    "FLAG_MAIN_11_021",
    "FLAG_MAIN_11_022",
    "FLAG_MAIN_11_023",
    "FLAG_MAIN_11_024",
    "FLAG_MAIN_11_025"
  }
  if Flg.AllCheck(flg) then
    local tlk = Tlk:new("t01", 1, true)
    local fe02 = Motion.Object:new(NPC, "npc_0001", "fe02")
    local bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
    START_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
    tlk:StartTalkAndCancelDigimonRide()
    fe02:Play(20, false)
    tlk:Message("f_t0121_060_0060")
    bn01:Play(20, true)
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("npc_0001", true, false)
  end
end

function M310:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_026) and Flg.Check("FLAG_MAIN_11_020", "FLAG_MAIN_11_021") then
    Flg.Clear("FLAG_MAIN_11_029")
    Execute("arena_m310_01")
    EncountFromField_NoEffect(11110010, 173)
    WaitFrame(10)
  end
end

function M310:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_026) and Flg.Check("FLAG_MAIN_11_021", "FLAG_MAIN_11_022") then
    Flg.Set("FLAG_MAIN_11_029")
    M310Arena_Battle_After(1)
    MapChange("t", 121, "start_20", true, FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_080A()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_026) and Flg.Check("FLAG_MAIN_11_021", "FLAG_MAIN_11_022") then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0121_070_0010")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_026)
  end
end

function M310:Event_081()
  if Qst.Main:Check(self.ID, self.STEP_026, self.STEP_027) and Flg.Check("FLAG_MAIN_11_021", "FLAG_MAIN_11_022") then
    Flg.Clear("FLAG_MAIN_11_029")
    Execute("arena_m310_02")
    EncountFromField_NoEffect(11110020, 173)
    WaitFrame(10)
  end
end

function M310:Event_082()
  if Qst.Main:Check(self.ID, self.STEP_026, self.STEP_027) and Flg.Check("FLAG_MAIN_11_022", "FLAG_MAIN_11_023") then
    Flg.Set("FLAG_MAIN_11_029")
    M310Arena_Battle_After(2)
    MapChange("t", 121, "start_20", true, FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_082A()
  if Qst.Main:Check(self.ID, self.STEP_026, self.STEP_027) and Flg.Check("FLAG_MAIN_11_022", "FLAG_MAIN_11_023") then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0121_070_0020")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_027)
  end
end

function M310:Event_083()
  if Qst.Main:Check(self.ID, self.STEP_027, self.STEP_028) and Flg.Check("FLAG_MAIN_11_022", "FLAG_MAIN_11_023") then
    Flg.Clear("FLAG_MAIN_11_029")
    Execute("arena_m310_03")
    EncountFromField_NoEffect(11110030, 173)
    WaitFrame(10)
  end
end

function M310:Event_084()
  if Qst.Main:Check(self.ID, self.STEP_027, self.STEP_028) and Flg.Check("FLAG_MAIN_11_023", "FLAG_MAIN_11_024") then
    Flg.Set("FLAG_MAIN_11_029")
    M310Arena_Battle_After(3)
    MapChange("t", 121, "start_20", true, FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_084A()
  if Qst.Main:Check(self.ID, self.STEP_027, self.STEP_028) and Flg.Check("FLAG_MAIN_11_023", "FLAG_MAIN_11_024") then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0121_070_0030")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_028)
  end
end

function M310:Event_085()
  if Qst.Main:Check(self.ID, self.STEP_028, self.STEP_030) and Flg.Check("FLAG_MAIN_11_023", "FLAG_MAIN_11_024") then
    Flg.Clear("FLAG_MAIN_11_029")
    Execute("arena_m310_04")
    EncountFromField_NoEffect(11110040, 173)
    WaitFrame(10)
  end
end

function M310:Event_086()
  if Qst.Main:Check(self.ID, self.STEP_028, self.STEP_030) and Flg.Check("FLAG_MAIN_11_024", "FLAG_MAIN_11_025") then
    Flg.Set("FLAG_MAIN_11_029")
    M310Arena_Battle_After(4)
    MapChange("t", 121, "start_20", true, FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_086A()
  if Qst.Main:Check(self.ID, self.STEP_028, self.STEP_030) and Flg.Check("FLAG_MAIN_11_024", "FLAG_MAIN_11_025") then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("t01", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_t0121_070_0040")
    tlk:EndTalk()
    Digimon.RestoreAllParty()
    Qst.Main:Set(self.ID, self.STEP_030)
  end
end

function M310:Event_087()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_11_024", "FLAG_MAIN_11_045") then
    Flg.Clear("FLAG_MAIN_11_029")
    Execute("arena_m310_05")
    EncountFromField_NoEffect(11110100, 173)
    WaitFrame(10)
  end
end

function M310:Event_088()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_11_045", "FLAG_MAIN_11_050") then
    Flg.Set("FLAG_MAIN_11_029")
    Flg.Set("FLAG_MAIN_11_025")
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    MapChange("t", 121, "start_20", false, FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) and Flg.Check("FLAG_MAIN_11_045", "FLAG_MAIN_11_050") then
    Flg.Set("FLAG_MAIN_11_050")
    FieldObjectSync(NPC, true)
    self:Event_105()
  end
end

function M310:Event_105()
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_035) then
    Execute("m310_031")
    Flg.Set("FLAG_MAIN_11_055")
    Qst.Main:Set(self.ID, self.STEP_035)
    FieldObjectSync(NPC, true)
    Digimon.RestoreAllParty()
    SetFollowerCameraOperateRotation(0, 220)
  end
end

function M310:Event_108()
  if Qst.Main:Check(self.ID, self.STEP_035, self.STEP_040) then
    Execute("m310_032")
    Flg.Set("FLAG_MAIN_11_054")
    Qst.Main:Set(self.ID, self.STEP_040)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_109()
  if Qst.Main:Check(self.ID, self.STEP_040, self.STEP_045) then
    local npc_index01 = GetIndex(NPC, "npc_0223")
    local bn01 = Motion.Object:new(NPC, "npc_0223", "bn01")
    local bn02 = Motion.Object:new(NPC, "npc_0223", "bn02")
    local fe04 = Motion.Object:new(NPC, "npc_0223", "fe04")
    local npc_index02 = GetIndex(NPC, "npc_0224")
    local a_e005 = Motion.Object:new(NPC, "npc_0224", "e005")
    local a_e007 = Motion.Object:new(NPC, "npc_0224", "e007")
    local a_fn01_01 = Motion.Object:new(NPC, "npc_0224", "fn01_01")
    local npc_index03 = GetIndex(NPC, "npc_0225")
    local i_e004 = Motion.Object:new(NPC, "npc_0225", "e004")
    local pc_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local pc_e002 = Motion.Object:new(PLAYER, "", "e002_01")
    WaitFrame(15)
    Obj:new(PLAYER, ""):SetPos(-8.628, -0.073, -51.102, true)
    Obj:new(PLAYER, ""):SetRotationY(60, 0)
    Flg.Set("FLAG_MAIN_11_056")
    Cam.Inst:Set(-5.115, -0.787, -33.668, -10.23, 1.538, -41.949, default, 0)
    FieldObjectSync(FOR_ALL, false)
    local tlk = Tlk:new("d12", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    bn01:Play(10, true)
    Obj:new(NPC, "npc_0223"):SetPos(-9.165, 0.28, -33.082, true)
    Obj:new(NPC, "npc_0223"):SetRotationY(0, 0)
    Obj:new(NPC, "npc_0225"):Invisible()
    Obj:new(NPC, "npc_0224"):Invisible()
    Cam.Inst:Set(-8.375, -0.073, -44.4, -7.816, 1.892, -54.189, default, 0)
    pc_e002:Play(10, true)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    Cam.Inst:Set(-8.94, -1.282, -26.634, -9.309, 1.47, -36.241, default, 30)
    WaitFrame(45)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    WaitFrame(30)
    bn01:Play(10, true)
    WaitFrame(15)
    Field.ObjectFrameMove2D(NPC, npc_index01, 0, 4, 45)
    WaitFrame(15)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Obj:new(NPC, "npc_0223"):SetPos(-9.511, -0.089, -38.115, true)
    Obj:new(NPC, "npc_0223"):SetRotationY(20, 0)
    Obj:new(PLAYER, ""):SetPos(-8.297, -0.089, -40.264, true)
    Obj:new(PLAYER, ""):SetRotationY(200, 0)
    WaitFrame(1)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 0)
    Field.ObjectLookAtTheObject(NPC, npc_index02, NPC, npc_index01, 0)
    Field.ObjectLookAtTheObject(NPC, npc_index03, NPC, npc_index01, 0)
    bn02:Play(0, true)
    pc_fn01_01:Play(10, true)
    Obj:new(NPC, "npc_0225"):CancelInvisible()
    Obj:new(NPC, "npc_0224"):CancelInvisible()
    Obj:new(PLAYER, ""):CancelInvisible()
    Cam.Inst:Set(-5.115, -0.787, -33.668, -10.23, 1.538, -41.949, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    tlk:Message("f_d1204_0670_0010")
    bn01:Play(20, true)
    tlk:Message("f_d1204_0670_0020")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index02, "e007", 5, 10)
    tlk:Message("f_d1204_0670_0030")
    i_e004:Play(10, true)
    tlk:Message("f_d1204_0670_0040")
    local _ = tlk:Select(3, "f_d1204_0670_0050")
    a_e005:Play(10, true)
    tlk:Message("f_d1204_0670_0060")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Flg.Set("FLAG_MAIN_11_057")
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(0)
    WaitFrame(15)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_045)
  end
end

function M310:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) then
    Flg.Set("FLAG_MAIN_11_060")
    Execute("m310_040")
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    MapChangeWithTimeTravel("t", 3001, "start_00", AXIS_ORIGINAL, "A2028_daft_311", MORNING)
  end
end

function M310:Event_120()
  if Qst.Main:Check(self.ID, self.STEP_045, self.STEP_050) and Flg.Check("FLAG_MAIN_11_060") and not Flg.Check("FLAG_MAIN_11_070") then
    Field.HideGuide(true)
    Flg.Set("FLAG_MAIN_11_070")
    Execute("m310_050")
    Qst.Main:Set(self.ID, self.STEP_050)
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    MapChange("t", 3002, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M310:Event_130()
  if Qst.Main:Check(self.ID, self.STEP_050, self.STEP_255) then
    Field.HideGuide(true)
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(78)
    end
    Execute("m310_060")
    Execute("m310_070")
    Fade_OutNoLoadingWithWait(FADE_WHITE, 0)
    Qst.Main:End(self.ID, self.STEP_255)
    MapChangeWithTimeTravel("t", 121, "start_50", AXIS_ORIGINAL, "P2028_daft_320", NOON)
  end
end

function M310Arena_Battle_After(battle_num)
  Digimon.RestoreAllParty()
  local tlk = Tlk:new("arena01", 1, true, false)
  tlk:StartTalkAndCancelDigimonRide()
  Cam.Inst:Set(-1.342, -0.449, 16.806, 0.498, 1.556, 7.184, default, 0)
  InvisibleNpcInArena()
  Obj:new(PLAYER, ""):SetPos(0, -0.001, 10, true)
  Obj:new(PLAYER, ""):SetRotationY(0, 0)
  Field.ObjectLoadMotion(PLAYER, 1, "e004")
  FollowerSync()
  WaitFrame(5)
  Field.FollowerWarp()
  WaitFrame(5)
  SetHeroine("e004_01", 0.875, 0, 10.682, 0)
  SetAegio("e004", -0.7989, 0, 10.753, 0)
  SetPartyMember("ba01", -0.973, -0.001, 13.342, 0, 1)
  SetPartyMember("ba01", -3.516, 0, 13.035, 0, 2)
  SetPartyMember("ba01", 1.649, 0, 13.176, 0, 3)
  FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  WaitFrame(15)
  Field.ObjectPlayMotion(PLAYER, 1, "e004", 5, true)
  PlayHeroineMotion("e004_01")
  PlayAegioMotion("e004")
  PlayPartyMemberMotion("ba01", 1)
  PlayPartyMemberMotion("ba01", 2)
  PlayPartyMemberMotion("ba01", 3)
  local win_message = "arena01_m310_010_060"
  if battle_num == 1 then
    win_message = "arena01_m310_010_060"
  elseif battle_num == 2 then
    win_message = "arena01_m310_020_060"
  elseif battle_num == 3 then
    win_message = "arena01_m310_030_060"
  elseif battle_num == 4 then
    win_message = "arena01_m310_040_060"
  elseif battle_num == 5 then
    win_message = "arena01_m310_050_060"
  end
  tlk:Message(win_message)
  tlk:EndTalk()
end

function SetHeroine(motion_name, posx, posy, posz, rot)
  local heroine = Field.GetFollowerIndexByGuestID(GST_HEROINE)
  if heroine ~= nil then
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, heroine, motion_name)
    Field.ObjectCancelInvisible(FLD_OBJ_FOLLOWER, heroine, 0, 0, true)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, heroine, rot, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, heroine, posx, posy, posz, true)
  end
end

function PlayHeroineMotion(motion_name)
  local heroine = Field.GetFollowerIndexByGuestID(GST_HEROINE)
  if heroine ~= nil then
    Field.ObjectPlayMotion(FLD_OBJ_FOLLOWER, heroine, motion_name, 5, true)
  end
end

function SetAegio(motion_name, posx, posy, posz, rot)
  local aegio = Field.GetFollowerIndexForAegiomon()
  if aegio ~= nil then
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, aegio, motion_name)
    Field.ObjectCancelInvisible(FLD_OBJ_FOLLOWER, aegio, 0, 0, true)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, aegio, rot, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, aegio, posx, posy, posz, true)
  end
end

function PlayAegioMotion(motion_name)
  local aegio = Field.GetFollowerIndexForAegiomon()
  if aegio ~= nil then
    Field.ObjectPlayMotion(FLD_OBJ_FOLLOWER, aegio, motion_name, 5, true)
  end
end

function SetPartyMember(motion_name, posx, posy, posz, rot, partypos)
  local index = Digimon.GetUniqueIDInPartyMember(partypos)
  if index ~= nil then
    local party = Field.GetFollowerIndexByPartyUniqueID(index)
    Field.ObjectCancelInvisible(FLD_OBJ_FOLLOWER, party, 0, 0, true)
    Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, party, motion_name)
    Field.ObjectSetRotationY(FLD_OBJ_FOLLOWER, party, rot, 0)
    Field.ObjectSetPos(FLD_OBJ_FOLLOWER, party, posx, posy, posz, true)
  end
end

function PlayPartyMemberMotion(motion_name, partypos)
  local index = Digimon.GetUniqueIDInPartyMember(partypos)
  if index ~= nil then
    local party = Field.GetFollowerIndexByPartyUniqueID(index)
    Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_FOLLOWER, party, motion_name, 5, 10)
  end
end

function M310:ChapterFlagSet(progress)
  local step = {}
  if 1 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 20 <= progress then
    step[#step + 1] = self.STEP_005
    step[#step + 1] = self.STEP_008
  end
  if 30 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_013
  end
  if 31 <= progress then
    step[#step + 1] = self.STEP_015
  end
  if 41 <= progress then
    step[#step + 1] = self.STEP_025
    step[#step + 1] = self.STEP_026
    step[#step + 1] = self.STEP_027
    step[#step + 1] = self.STEP_028
    step[#step + 1] = self.STEP_030
  end
  if 50 <= progress then
    step[#step + 1] = self.STEP_035
  end
  if 70 <= progress then
    step[#step + 1] = self.STEP_040
    step[#step + 1] = self.STEP_045
  end
  if 80 <= progress then
  end
  Qst.Main:Chapter(step, self.ID)
end
