S110_109 = {
  ID = 109,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_110_109_001",
  Flg02 = "FLAG_SUB_110_109_002",
  Flg03 = "FLAG_SUB_110_109_003"
}
local text_file = "s110_109"
local base = "s110_109_"

function S110_109:Event_010()
  if Flg.Check("FLAG_SUB_100_087_015") and not Qst.Sub:IsCompleted(self.ID) and Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    HideMinimap(true)
    HideGuide(true)
    local npc01_index = GetIndex(NPC, "s110_109_001")
    local p_fe02 = Motion.Object:new(NPC, "s110_109_001", "fe02")
    local p_fe04 = Motion.Object:new(NPC, "s110_109_001", "fe04")
    local p_fq01 = Motion.Object:new(NPC, "s110_109_001", "fq01")
    local p_fq02 = Motion.Object:new(NPC, "s110_109_001", "fq02")
    local p_bn01 = Motion.Object:new(NPC, "s110_109_001", "bn01")
    local e002 = Motion.Object:new(PLAYER, "", "e002")
    local e004 = Motion.Object:new(PLAYER, "", "e004")
    local e008 = Motion.Object:new(PLAYER, "", "e008")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    Flg.Set(self.Flg01)
    local tlk = Tlk:new(text_file, 1, true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Obj:new(PLAYER, ""):SetPos(33.86, 72.097, -99.423, true)
    WaitFrame(1)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s110_109_001", 0)
    Obj:new(NPC, "s110_109_001"):SetRotationYToObject(PLAYER, "", 0)
    Cam.Inst:Set(28.359, 71.76, -95.036, 36.528, 73.5828, -100.51, default, 0)
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc01_index, 15, 10)
    p_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    if result == RESULT_TALK00 then
      p_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "030")
    elseif result == RESULT_TALK01 then
      p_fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK02 then
      p_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "050")
    end
    tlk:Message(base .. "060")
    p_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "070")
    tlk:EndTalk()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Qst.Sub:Start(self.ID, 1, false)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Set(self.ID, self.STEP_005)
    FieldObjectSync(NPC, false)
    WaitFrame(1)
    FieldObjectSync(ENEMY, false)
    Cam.Inst:Clear(0)
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    HideMinimap(false)
    HideGuide(false)
  end
end

function S110_109:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check(self.Flg02) then
    EncountFromField_WithNormalEffect(21101090, 10471, false)
  end
end

function S110_109:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg02) then
    local npc01_index = GetIndex(NPC, "s110_109_002")
    local npc02_index = GetIndex(NPC, "s110_109_003")
    local bn01 = Motion.Object:new(NPC, "s110_109_002", "bn01")
    local fq02 = Motion.Object:new(NPC, "s110_109_002", "fq02")
    local fe02 = Motion.Object:new(NPC, "s110_109_002", "fe02")
    local fe04 = Motion.Object:new(NPC, "s110_109_002", "fe04")
    local d_fq01 = Motion.Object:new(NPC, "s110_109_003", "fq01")
    local d_fq02 = Motion.Object:new(NPC, "s110_109_003", "fq02")
    local d_bn01 = Motion.Object:new(NPC, "s110_109_003", "bn01")
    local d_fe02 = Motion.Object:new(NPC, "s110_109_003", "fe02")
    local d_fe03 = Motion.Object:new(NPC, "s110_109_003", "fe03")
    local d_fe04 = Motion.Object:new(NPC, "s110_109_003", "fe04")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local p_e004 = Motion.Object:new(PLAYER, "", "e004")
    local p_e008 = Motion.Object:new(PLAYER, "", "e008")
    local p_e012 = Motion.Object:new(PLAYER, "", "e012")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    HideMinimap(true)
    HideGuide(true)
    Field_InvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false)
    Cam.Inst:Set(-105.56, 74.66, -54.284, -106.41, 73.046, -44.452, default, 0)
    FieldObjectSync(NPC, false)
    WaitFrame(5)
    Obj:new(PLAYER, ""):SetPos(-105.421, 72.334, -47.459)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s110_109_002", 0)
    WaitFrame(5)
    Obj:new(NPC, "s110_109_002"):SetRotationYToObject(PLAYER, "", 0)
    SetFollowerCameraOperateRotation(0, 180)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(5)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "100")
    local result = tlk:Select(3, base .. "110")
    if result == RESULT_TALK00 then
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "120")
    elseif result == RESULT_TALK01 then
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "130")
    elseif result == RESULT_TALK02 then
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "140")
    end
    fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "150")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set(self.Flg03)
    FieldObjectSync(NPC, false)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    d_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "160")
    d_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "170")
    result = tlk:Select(3, base .. "180")
    if result == RESULT_TALK00 then
      d_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "190")
    elseif result == RESULT_TALK01 then
      d_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "200")
    elseif result == RESULT_TALK02 then
      d_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "210")
    end
    d_fe03:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "220")
    d_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "230")
    result = tlk:Select(3, base .. "240")
    if result == RESULT_TALK00 then
      d_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "250")
    elseif result == RESULT_TALK01 then
      d_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "260")
    elseif result == RESULT_TALK02 then
      d_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "270")
    end
    d_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "280")
    d_fe03:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "290")
    d_fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "300")
    tlk:MessageClose()
    Flg.Set("FLAG_IS_CLEAR_S110_109")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    FieldObjectSync(NPC, true)
    Cam.Inst:Clear(0)
    Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 30, false, false)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:End(self.ID, self.STEP_255)
    HideMinimap(false)
    HideGuide(false)
  end
end

function S110_109:Event_035()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg02) then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    self:Event_030()
  end
end

function S110_109:Event_040()
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "310")
  tlk:Message(base .. "320")
  tlk:EndTalk()
end
