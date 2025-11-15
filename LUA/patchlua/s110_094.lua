S110_094 = {
  ID = 94,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_110_094_001",
  Flg02 = "FLAG_SUB_110_094_002"
}
local text_file = "s110_094"
local base = "s110_094_"

function S110_094:Event_005()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local fq01 = Motion.Object:new(NPC, "s110_094_005", "fq01")
    local fe02 = Motion.Object:new(NPC, "s110_094_005", "fe02")
    local fq02 = Motion.Object:new(NPC, "s110_094_005", "fq02")
    local bn01 = Motion.Object:new(NPC, "s110_094_005", "bn01")
    local pl_e002 = Motion.Object:new(PLAYER, "", "e002")
    local pl_e004 = Motion.Object:new(PLAYER, "", "e004")
    local pl_e012 = Motion.Object:new(PLAYER, "", "e012")
    local pl_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local tlk = Tlk:new(text_file, 1, true)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkActionAndZoom("s110_094_005")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "500")
    fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "510")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "520")
    local result = tlk:Select(3, base .. "530")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "540")
    elseif result == RESULT_TALK01 then
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "550")
    else
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "560")
    end
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "570")
    Flg.Set(self.Flg01)
    tlk:EndTalkActionAndZoom()
    FieldObjectSync(NPC, true)
    WaitFrame(5)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_005)
  end
end

function S110_094:Event_008()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local fq01 = Motion.Object:new(NPC, "s110_094_005", "fq01")
    local fq02 = Motion.Object:new(NPC, "s110_094_005", "fq02")
    local bn01 = Motion.Object:new(NPC, "s110_094_005", "bn01")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("s110_094_005")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "580")
    bn01:PlayWithStartMoveMotion(10, 10)
    tlk:EndTalkActionAndZoom()
  end
end

function S110_094:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local i_fq01 = Motion.Object:new(NPC, "s110_094_001", "fq01")
    local i_fq02 = Motion.Object:new(NPC, "s110_094_001", "fq02")
    local i_fe02 = Motion.Object:new(NPC, "s110_094_001", "fe02")
    local i_fe03 = Motion.Object:new(NPC, "s110_094_001", "fe03")
    local i_bn01 = Motion.Object:new(NPC, "s110_094_001", "bn01")
    local pl_e002 = Motion.Object:new(PLAYER, "", "e002")
    local pl_e004 = Motion.Object:new(PLAYER, "", "e004")
    local pl_e012 = Motion.Object:new(PLAYER, "", "e012")
    local pl_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local tlk = Tlk:new(text_file, 1, true)
    Cam.Inst:Set(-2.616, 9.568, -160.968, 0.614, 7.709, -151.689, default, 30)
    WaitFrame(30)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    tlk:Message(base .. "010")
    i_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "020")
    tlk:Message(base .. "030")
    local result = tlk:Select(3, base .. "040")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "060")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "070")
    end
    tlk:Message(base .. "080")
    i_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "090")
    result = tlk:Select(3, base .. "100")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      i_fe03:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "110")
    elseif result == RESULT_TALK01 then
      i_fe03:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "120")
    elseif result == RESULT_TALK02 then
      i_fe03:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "130")
    end
    tlk:Message(base .. "140")
    tlk:Message(base .. "150")
    i_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "160")
    tlk:Message(base .. "170")
    tlk:Message(base .. "180")
    tlk:MessageClose()
    INFO_GET_ITEM(3, 5)
    Flg.Set(self.Flg02)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    Cam.Inst:Set(-0.892, 8.199, -167.24, 1.64, 8.634, -157.58, default, 0)
    Obj:new(PLAYER, ""):SetPos(-0.88, 7.15, -161.03, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "190")
    result = tlk:Select(3, base .. "200")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "210")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "220")
    else
      tlk:Message(base .. "230")
    end
    tlk:Message(base .. "240")
    tlk:Message(base .. "250")
    Cam.Inst:Clear(30)
    WaitFrame(30)
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S110_094:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "260")
    tlk:EndTalk()
  end
end

function S110_094:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local fq01 = Motion.Object:new(NPC, "s110_094_005", "fq01")
    local fq02 = Motion.Object:new(NPC, "s110_094_005", "fq02")
    local bn01 = Motion.Object:new(NPC, "s110_094_005", "bn01")
    local pl_e002 = Motion.Object:new(PLAYER, "", "e002")
    local pl_e004 = Motion.Object:new(PLAYER, "", "e004")
    local pl_e012 = Motion.Object:new(PLAYER, "", "e012")
    local pl_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("s110_094_005")
    HideMinimap(true)
    HideGuide(true)
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "590")
    local result = tlk:Select(3, base .. "600")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "610")
    elseif result == RESULT_TALK01 then
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "620")
    else
      fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "630")
    end
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "640")
    fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "650")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "660")
    tlk:EndTalkActionAndZoom()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S110_094:Event_040()
  if Flg.Check("FLAG_IS_CLEAR_S110_094") then
    local fq01 = Motion.Object:new(NPC, "s110_094_005", "fq01")
    local fq02 = Motion.Object:new(NPC, "s110_094_005", "fq02")
    local bn01 = Motion.Object:new(NPC, "s110_094_005", "bn01")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("s110_094_005")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "660")
    tlk:EndTalkActionAndZoom()
  end
end
