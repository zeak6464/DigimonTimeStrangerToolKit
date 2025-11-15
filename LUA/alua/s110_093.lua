S110_093 = {
  ID = 93,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_110_093_001",
  Flg02 = "FLAG_SUB_110_093_002",
  Flg03 = "FLAG_SUB_110_093_003"
}
local text_file = "s110_093"
local base = "s110_093_"
local tlk = Tlk:new(text_file, 1, true)

function S110_093:Event_010()
  if Qst.Sub:IsCompleted(92) and not Qst.Sub:IsCompleted(self.ID) and Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local c_ba02 = Motion.Object:new(NPC, "s110_093_cra_01", "ba02")
    local c_fq01 = Motion.Object:new(NPC, "s110_093_cra_01", "fq01")
    local c_fq02 = Motion.Object:new(NPC, "s110_093_cra_01", "fq02")
    local c_bn01 = Motion.Object:new(NPC, "s110_093_cra_01", "bn01")
    local p_ba01 = Motion.Object:new(NPC, "s110_093_pluto_01", "ba01")
    local p_e002 = Motion.Object:new(NPC, "s110_093_pluto_01", "e002")
    local p_fq02 = Motion.Object:new(NPC, "s110_093_pluto_01", "fq02")
    local p_bn01 = Motion.Object:new(NPC, "s110_093_pluto_01", "bn01")
    if Guest.IsExistNum(2) then
      INFO_WINDOW(10050)
      return
    end
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_SUB_110_093_006")
    FieldObjectSync(NPC, false)
    Obj:new(PLAYER, ""):SetPos(-3.35, 0, -58.41, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    Cam.Inst:Set(-2.829, 3.27, -62.034, -3.852, 0.451, -52.495, default, 0)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    c_fq01:PlayWithStartMoveMotion(10, 15)
    tlk:Message(base .. "010")
    p_e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "020")
    Flg.Set(self.Flg01)
    tlk:EndTalk(true)
    Qst.Sub:Start(self.ID, 1, false)
    Guest.Add(GST_PLUTO)
    Guest.Add(GST_S010_156_CRANIA)
    Qst.Sub:Set(self.ID, self.STEP_005)
    MapChange("d", 701, "start_30", true, 0, FADE_TIME)
  end
end

function S110_093:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check(self.Flg03) then
    local c_ba02 = Motion.Object:new(NPC, "s110_093_cra_01", "ba02")
    local c_fq01 = Motion.Object:new(NPC, "s110_093_cra_01", "fq01")
    local c_fq02 = Motion.Object:new(NPC, "s110_093_cra_01", "fq02")
    local c_bn01 = Motion.Object:new(NPC, "s110_093_cra_01", "bn01")
    local a_ba01 = Motion.Object:new(NPC, "s110_093_002", "ba01")
    local a_fq01 = Motion.Object:new(NPC, "s110_093_002", "fq01")
    local a_fq02 = Motion.Object:new(NPC, "s110_093_002", "fq02")
    local a_bn01 = Motion.Object:new(NPC, "s110_093_002", "bn01")
    local p_bn01 = Motion.Object:new(NPC, "s110_093_pluto_02", "bn01")
    local p_fe02 = Motion.Object:new(NPC, "s110_093_pluto_02", "fe02")
    local p_e006 = Motion.Object:new(NPC, "s110_093_pluto_02", "e006")
    local p_e002 = Motion.Object:new(NPC, "s110_093_pluto_02", "e002")
    local p_fq01 = Motion.Object:new(NPC, "s110_093_pluto_02", "fq01")
    local p_fq02 = Motion.Object:new(NPC, "s110_093_pluto_02", "fq02")
    local e002 = Motion.Object:new(PLAYER, "", "e002")
    local e008 = Motion.Object:new(PLAYER, "", "e008")
    local e012 = Motion.Object:new(PLAYER, "", "e012")
    local e018 = Motion.Object:new(PLAYER, "", "e018")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    WaitFrame(5)
    HideGuide(true)
    WaitFrame(5)
    Obj:new(PLAYER, ""):SetPos(-0.1, 3.961, 29.985, true)
    Obj:new(PLAYER, ""):SetRotationY(150, 0)
    Cam.Inst:Set(1.945, 6.31, 30.35, -7.83, 6.175, 28.29, default, 0)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    c_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "260")
    a_ba01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "270")
    local result = tlk:Select(3, base .. "280")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, GetIndex(NPC, "s110_093_cra_01"), 30)
    WaitFrame(15)
    if result == RESULT_TALK00 then
      c_ba02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "290")
    elseif result == RESULT_TALK01 then
      c_ba02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "300")
    elseif result == RESULT_TALK02 then
      c_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "310")
    end
    Field.ObjectResetAim(NPC, GetIndex(NPC, "s110_093_cra_01"), 10)
    Field.ObjectResetAim(PLAYER, 1, 30)
    e018:Play(10, true)
    c_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "320")
    a_ba01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "330")
    tlk:EndTalk()
    EncountFromField_PlaySound(21100930, 10771, false)
  end
end

function S110_093:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg03) then
    local c_ba02 = Motion.Object:new(NPC, "s110_093_cra_01", "ba02")
    local c_fq01 = Motion.Object:new(NPC, "s110_093_cra_01", "fq01")
    local c_fq02 = Motion.Object:new(NPC, "s110_093_cra_01", "fq02")
    local c_bn01 = Motion.Object:new(NPC, "s110_093_cra_01", "bn01")
    local a_ba01 = Motion.Object:new(NPC, "s110_093_002", "ba01")
    local a_fq01 = Motion.Object:new(NPC, "s110_093_002", "fq01")
    local a_fq02 = Motion.Object:new(NPC, "s110_093_002", "fq02")
    local a_bn01 = Motion.Object:new(NPC, "s110_093_002", "bn01")
    local ca_ba01 = Motion.Object:new(NPC, "s110_093_02", "ba01")
    local ca_fe02 = Motion.Object:new(NPC, "s110_093_02", "fe02")
    local ca_fq01 = Motion.Object:new(NPC, "s110_093_02", "fq01")
    local ca_fq02 = Motion.Object:new(NPC, "s110_093_02", "fq02")
    local ca_bn01 = Motion.Object:new(NPC, "s110_093_02", "bn01")
    local p_bn01 = Motion.Object:new(NPC, "s110_093_pluto_02", "bn01")
    local p_fe02 = Motion.Object:new(NPC, "s110_093_pluto_02", "fe02")
    local p_e006 = Motion.Object:new(NPC, "s110_093_pluto_02", "e006")
    local p_e002 = Motion.Object:new(NPC, "s110_093_pluto_02", "e002")
    local p_fq01 = Motion.Object:new(NPC, "s110_093_pluto_02", "fq01")
    local p_fq02 = Motion.Object:new(NPC, "s110_093_pluto_02", "fq02")
    local e002 = Motion.Object:new(PLAYER, "", "e002")
    local e008 = Motion.Object:new(PLAYER, "", "e008")
    local e012 = Motion.Object:new(PLAYER, "", "e012")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    tlk:StartTalkAndCancelDigimonRide()
    Guest.Delete(GST_PLUTO)
    Guest.Delete(GST_S010_156_CRANIA)
    HideMinimap(true)
    WaitFrame(5)
    HideGuide(true)
    WaitFrame(5)
    fn01_01:Play(0, true)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk = Tlk:new(text_file, 1, true)
    c_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "340")
    a_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "350")
    p_e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "360")
    local result = tlk:Select(3, base .. "370")
    Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, NPC, GetIndex(NPC, "s110_093_cra_01"), 30)
    WaitFrame(15)
    if result == RESULT_TALK00 then
      c_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "380")
    elseif result == RESULT_TALK01 then
      a_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "390")
    elseif result == RESULT_TALK02 then
      c_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "400")
    end
    a_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "410")
    p_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "412")
    p_e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "414")
    c_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "416")
    a_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "418")
    c_fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "420")
    Flg.Set("FLAG_SUB_110_093_004")
    BackFadeOutWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectResetAim(PLAYER, 1, 30)
    local SEslot_1 = Sound.PlaySE(403006, 100)
    Obj:new(PLAYER, ""):SetRotationY(120, 0)
    WaitFrame(30)
    Cam.Inst:Set(4.75, 6.88, 31.46, -4.98, 4.9434, 30.21, default, 0)
    FieldObjectSync(NPC, false)
    tlk:Message(base .. "430")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "440")
    ca_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "450")
    tlk:Message(base .. "460")
    result = tlk:Select(3, base .. "470")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      ca_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "480")
    elseif result == RESULT_TALK01 then
      ca_fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "490")
    elseif result == RESULT_TALK02 then
      ca_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "500")
    end
    p_e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "510")
    p_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "520")
    ObjectTurnToObject(PLAYER, "", NPC, "s110_093_pluto_02")
    result = tlk:Select(3, base .. "600")
    WaitFrame(15)
    p_fq02:PlayWithStartMoveMotion(10, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "610")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "620")
    else
      tlk:Message(base .. "630")
    end
    p_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "640")
    p_e002:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "650")
    ca_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "660")
    ca_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "670")
    tlk:EndTalk(true)
    Guest.Delete(GST_PLUTO)
    Flg.Set("FLAG_IS_CLEAR_S110_093")
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    require("S100_087")
    Flg.Set(S100_087.Flgs.Flg07)
    S100_087.AddReturnRoyalKnightsNum()
    S100_087:Event_020()
    WaitFrame(75)
    MapChange("d", 702, "start_10", true, 0, FADE_TIME)
  end
end

function S110_093:Event_070()
  tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "540")
  local result = tlk:Select(2, base .. "550")
  if result == RESULT_TALK00 then
    tlk:Message(base .. "560")
    Field.StartCardGameWithNPC(1252, true)
  end
  tlk:EndTalk()
end

function S110_093:Event_080()
  tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "570")
  local result = tlk:Select(2, base .. "580")
  WaitFrame(15)
  if result == RESULT_TALK00 then
    tlk:Message(base .. "590")
    tlk:EndTalk()
    result = Field.StartCardGameWithNPC(1253, true)
    local tlk2 = Tlk:new("S110_211", 1, true)
    tlk2:StartTalk()
    if result == CARD_GAME_WIN then
      tlk2:Message("s110_211_680")
    else
      if result == CARD_GAME_LOSE then
        tlk2:Message("s110_211_690")
      else
      end
    end
    tlk2:EndTalk()
  else
    tlk:EndTalk()
  end
end
