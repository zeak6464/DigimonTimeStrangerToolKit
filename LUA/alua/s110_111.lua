S110_111 = {
  ID = 111,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_110_111_001",
  Flg02 = "FLAG_SUB_110_111_002",
  Flg03 = "FLAG_SUB_110_111_003",
  Flg04 = "FLAG_SUB_110_111_004",
  Flg05 = "FLAG_SUB_110_111_005",
  Flg06 = "FLAG_SUB_110_111_006"
}
local text_file = "s110_111"
local base = text_file .. "_"

function S110_111:Event_010()
  if Qst.Main:IsCompleted(M340.ID) and Flg.Check("FLAG_SUB_100_087_015") and not Qst.Sub:IsCompleted(self.ID) then
    local fe02 = Motion.Object:new(NPC, "s110_111_003", "fe02")
    local fe03 = Motion.Object:new(NPC, "s110_111_003", "fe03")
    local fe04 = Motion.Object:new(NPC, "s110_111_003", "fe04")
    local fq01 = Motion.Object:new(NPC, "s110_111_003", "fq01")
    local fq02 = Motion.Object:new(NPC, "s110_111_003", "fq02")
    local bn01 = Motion.Object:new(NPC, "s110_111_003", "bn01")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local p_e004 = Motion.Object:new(PLAYER, "", "e004")
    local p_e012 = Motion.Object:new(PLAYER, "", "e012")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local npc01_index = GetIndex(NPC, "s110_111_003")
    Field.ObjectResetAim(NPC, npc01_index, 15)
    if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
      HideMinimap(true)
      HideGuide(true)
      Flg.Set(self.Flg01)
      local tlk = Tlk:new(text_file, 1, true)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Obj:new(PLAYER, ""):SetPos(2.192, -0.02, 76.916, true)
      Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s110_111_003", 0)
      tlk:StartTalkAndCancelDigimonRide()
      Cam.Inst:Set(8.95, 1.18, 72.97, 0.056, 1.32, 77.524, default, 0)
      WaitFrame(5)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc01_index, 15, 10)
      WaitFrame(15)
      fe03:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "010")
      local result = tlk:Select(3, base .. "020")
      WaitFrame(30)
      if result == RESULT_TALK00 then
        fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "030")
      elseif result == RESULT_TALK01 then
        fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "040")
      elseif result == RESULT_TALK02 then
        fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "050")
      end
      fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "060")
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "070")
      fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "080")
      result = tlk:Select(3, base .. "090")
      WaitFrame(30)
      if result == RESULT_TALK00 then
        fq01:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "100")
      elseif result == RESULT_TALK01 then
        fq01:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "110")
      elseif result == RESULT_TALK02 then
        fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "120")
      end
      fe03:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "130")
      fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "140")
      tlk:EndTalk()
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Qst.Sub:Start(self.ID, 1, false)
      Qst.Sub:Set(self.ID, self.STEP_005)
      HideMinimap(false)
      HideGuide(false)
      Cam.Inst:Clear(30)
      WaitFrame(15)
    end
  end
end

function S110_111:Event_015()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local fe03 = Motion.Object:new(NPC, "s110_111_003", "fe03")
    local fq01 = Motion.Object:new(NPC, "s110_111_003", "fq01")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalk()
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "560")
    tlk:EndTalk()
  end
end

function S110_111:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    local g_fe02 = Motion.Object:new(NPC, "s110_111_004", "fe02")
    local g_fe03 = Motion.Object:new(NPC, "s110_111_004", "fe03")
    local g_fe04 = Motion.Object:new(NPC, "s110_111_004", "fe04")
    local g_fq01 = Motion.Object:new(NPC, "s110_111_004", "fq01")
    local g_fq02 = Motion.Object:new(NPC, "s110_111_004", "fq02")
    local g_bn01 = Motion.Object:new(NPC, "s110_111_004", "bn01")
    local j_fe02 = Motion.Object:new(NPC, "s110_111_005", "fe02")
    local j_fe04 = Motion.Object:new(NPC, "s110_111_005", "fe04")
    local j_fq01 = Motion.Object:new(NPC, "s110_111_005", "fq01")
    local j_fq02 = Motion.Object:new(NPC, "s110_111_005", "fq02")
    local j_bn01 = Motion.Object:new(NPC, "s110_111_005", "bn01")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local p_e004 = Motion.Object:new(PLAYER, "", "e004")
    local p_e012 = Motion.Object:new(PLAYER, "", "e012")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local npc01_index = GetIndex(NPC, "s110_111_004")
    local npc02_index = GetIndex(NPC, "s110_111_005")
    Flg.Set(self.Flg02)
    local tlk = Tlk:new(text_file, 1, true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(8.09, 2.575, 74.06, -0.829, 1.25, 78.39, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectResetAim(NPC, npc01_index, 15)
    Field.ObjectResetAim(NPC, npc02_index, 15)
    Field.ObjectLookAtTheObject(NPC, npc02_index, PLAYER, 1, 10, 10)
    Obj:new(PLAYER, ""):SetPos(2.192, -0.02, 76.916, true)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s110_111_003", 0)
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc01_index, 15, 10)
    WaitFrame(15)
    g_fe03:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "160")
    g_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "170")
    local result = tlk:Select(3, base .. "180")
    WaitFrame(30)
    if result == RESULT_TALK00 then
      g_fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "190")
    elseif result == RESULT_TALK01 then
      g_fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "200")
    elseif result == RESULT_TALK02 then
      g_fe04:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "210")
    end
    j_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "220")
    g_fe03:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "230")
    g_fe04:PlayWithStartMoveMotion(10, 10)
    Field.ObjectLookAtTheObject(NPC, npc01_index, NPC, npc02_index, 15, 10)
    tlk:Message(base .. "240")
    tlk:MessageClose()
    Flg.Set(self.Flg04)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    Cam.Inst:Set(9.12, 3.28, 78.15, -0.31, 0.981, 75.72, default, 0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc02_index, 15, 10)
    j_fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "250")
    tlk:MessageClose()
    Flg.Set(self.Flg05)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    Field.ObjectResetAim(PLAYER, 1, 0)
    WaitFrame(30)
    Cam.Inst:Clear(0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_FREEARENA_RELEASE_017")
    tlk:EndTalk()
    AddChallengerNotice(false)
    Qst.Sub:Set(self.ID, self.STEP_015)
  end
end

function S110_111:Event_025()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    local j_fq01 = Motion.Object:new(NPC, "s110_111_005", "fq01")
    local j_bn01 = Motion.Object:new(NPC, "s110_111_005", "bn01")
    local tlk = Tlk:new(text_file, 1, true)
    START_TALK_ACTION_AND_ZOOM("s110_111_005", false, true)
    tlk:StartTalkAndCancelDigimonRide()
    j_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "150")
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("s110_111_005", false, true)
  end
end

function S110_111:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check(self.Flg03) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Qst.Sub:Set(self.ID, self.STEP_020)
    WaitFrame(60)
    Guest.Delete(GST_S010_156_JES)
  end
end

function S110_111:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    local g_fe03 = Motion.Object:new(NPC, "s110_111_001", "fe03")
    local g_fe02 = Motion.Object:new(NPC, "s110_111_001", "fe02")
    local g_fe04 = Motion.Object:new(NPC, "s110_111_001", "fe04")
    local g_fq01 = Motion.Object:new(NPC, "s110_111_001", "fq01")
    local g_fq02 = Motion.Object:new(NPC, "s110_111_001", "fq02")
    local g_bn01 = Motion.Object:new(NPC, "s110_111_001", "bn01")
    local j_fe02 = Motion.Object:new(NPC, "s110_111_002", "fe02")
    local j_fq01 = Motion.Object:new(NPC, "s110_111_002", "fq01")
    local j_fq02 = Motion.Object:new(NPC, "s110_111_002", "fq02")
    local j_bn01 = Motion.Object:new(NPC, "s110_111_002", "bn01")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local p_e004 = Motion.Object:new(PLAYER, "", "e004")
    local p_e012 = Motion.Object:new(PLAYER, "", "e012")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local npc01_index = GetIndex(NPC, "s110_111_001")
    local npc02_index = GetIndex(NPC, "s110_111_002")
    HideMinimap(true)
    HideGuide(true)
    local tlk = Tlk:new(text_file, 1, true)
    Cam.Inst:Set(0.11, 2.53, 90.064, 0.076, 1.345, 99.99, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(30)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc01_index, 15, 10)
    WaitFrame(15)
    g_fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "290")
    j_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "300")
    g_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "310")
    g_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "320")
    local result = tlk:Select(3, base .. "330")
    WaitFrame(30)
    if result == RESULT_TALK00 then
      g_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "340")
    elseif result == RESULT_TALK01 then
      g_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "350")
      g_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "360")
    elseif result == RESULT_TALK02 then
      g_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "370")
      g_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "380")
    end
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc02_index, 15, 10)
    j_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "390")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc01_index, 15, 10)
    g_fe03:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "400")
    g_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "410")
    result = tlk:Select(3, base .. "420")
    WaitFrame(30)
    if result == RESULT_TALK00 then
      g_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "430")
    elseif result == RESULT_TALK01 then
      g_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "440")
    elseif result == RESULT_TALK02 then
      g_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "450")
    end
    g_fe03:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "460")
    g_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "470")
    g_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "480")
    result = tlk:Select(3, base .. "490")
    WaitFrame(30)
    if result == RESULT_TALK00 then
      g_fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "500")
    elseif result == RESULT_TALK01 then
      g_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "510")
    elseif result == RESULT_TALK02 then
      g_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "520")
    end
    g_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "530")
    tlk:MessageClose()
    Flg.Set(self.Flg06)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    tlk:EndTalk()
    WaitFrame(25)
    Cam.Inst:Clear(0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Obj:new(NPC, "s110_111_002"):SetIcon(ICO_TALK)
  end
end

function S110_111:Event_060()
  local j_fq01 = Motion.Object:new(NPC, "s110_111_002", "fq01")
  local j_fq02 = Motion.Object:new(NPC, "s110_111_002", "fq02")
  local j_bn01 = Motion.Object:new(NPC, "s110_111_002", "bn01")
  if Qst.Sub:Check(self.ID, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    START_TALK_ACTION_AND_ZOOM("s110_111_002", false, true)
    tlk:StartTalkAndCancelDigimonRide()
    j_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "540")
    j_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "550")
    j_bn01:PlayWithStartMoveMotion(10, 10)
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("s110_111_002", false, true)
  else
    local tlk = Tlk:new(text_file, 1, true)
    START_TALK_ACTION_AND_ZOOM("s110_111_002", false, true)
    tlk:StartTalkAndCancelDigimonRide()
    j_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "220")
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("s110_111_002", false, true)
  end
end
