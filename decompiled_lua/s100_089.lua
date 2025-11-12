S100_089 = {
  ID = 89,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flag001 = "FLAG_SUB_100_089_001",
  Flag002 = "FLAG_SUB_100_089_002",
  Flag003 = "FLAG_SUB_100_089_003"
}
local text_file = "s100_089"
local base = text_file .. "_"
local tlk = Tlk:new(text_file, 1, true)

function S100_089:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local kotemon = {
      fq01 = Motion.Object:new(NPC, "s100_089_001", "fq01"),
      fq02 = Motion.Object:new(NPC, "s100_089_001", "fq02"),
      fe02 = Motion.Object:new(NPC, "s100_089_001", "fe02"),
      fe04 = Motion.Object:new(NPC, "s100_089_001", "fe04"),
      bn01 = Motion.Object:new(NPC, "s100_089_001", "bn01")
    }
    local kotemon_index = GetIndex(NPC, "s100_089_001")
    local musyamon = {
      fq01 = Motion.Object:new(NPC, "s100_089_002", "fq01"),
      fq02 = Motion.Object:new(NPC, "s100_089_002", "fq02"),
      fe02 = Motion.Object:new(NPC, "s100_089_002", "fe02"),
      fe04 = Motion.Object:new(NPC, "s100_089_002", "fe04"),
      bn01 = Motion.Object:new(NPC, "s100_089_002", "bn01")
    }
    local musyamon_index = GetIndex(NPC, "s100_089_002")
    local zambamon = {
      fq01 = Motion.Object:new(NPC, "s100_089_003", "fq01"),
      fq02 = Motion.Object:new(NPC, "s100_089_003", "fq02"),
      fe02 = Motion.Object:new(NPC, "s100_089_003", "fe02"),
      fe04 = Motion.Object:new(NPC, "s100_089_003", "fe04"),
      bn01 = Motion.Object:new(NPC, "s100_089_003", "bn01")
    }
    local zambamon_index = GetIndex(NPC, "s100_089_003")
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(18.15, 0.73, 81.03, 10.61, 1.6, 87.542, default, 0)
    Obj:new(PLAYER, ""):SetPos(12.75, 0, 85.698, true)
    Obj:new(PLAYER, ""):SetRotationY(30, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, kotemon_index, 15)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    kotemon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      kotemon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "030")
    elseif result == RESULT_TALK01 then
      kotemon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "040")
    else
      kotemon.fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "050")
    end
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, musyamon_index, 30)
    musyamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "060")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, kotemon_index, 30)
    kotemon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "070")
    kotemon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "080")
    result = tlk:Select(3, base .. "090")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      kotemon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "100")
    elseif result == RESULT_TALK01 then
      kotemon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "110")
    else
      kotemon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "120")
    end
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, musyamon_index, 30)
    musyamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "130")
    musyamon.fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "140")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zambamon_index, 30)
    zambamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "150")
    zambamon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "160")
    kotemon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "170")
    musyamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "180")
    zambamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "190")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, kotemon_index, 30)
    kotemon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "200")
    result = tlk:Select(3, base .. "210")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      kotemon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "220")
    elseif result == RESULT_TALK01 then
      kotemon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "230")
    else
      kotemon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "240")
    end
    kotemon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "250")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, musyamon_index, 30)
    musyamon.fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "260")
    musyamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "270")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zambamon_index, 30)
    zambamon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "280")
    kotemon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "290")
    tlk:EndTalk()
    Flg.Set(self.Flag003)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    Cam.Inst:Clear(0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_005)
    Flg.Set("FLAG_FREEARENA_RELEASE_019")
    AddChallengerNotice(false)
    require("S100_088")
    Qst.Sub:Set(S100_088.ID, S100_088.STEP_013)
  end
end

function S100_089:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check(self.Flag001) then
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S100_089:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) and Flg.Check(self.Flag001) then
    local kotemon = {
      fq01 = Motion.Object:new(NPC, "s100_089_001", "fq01"),
      fq02 = Motion.Object:new(NPC, "s100_089_001", "fq02"),
      fe02 = Motion.Object:new(NPC, "s100_089_001", "fe02"),
      fe04 = Motion.Object:new(NPC, "s100_089_001", "fe04"),
      bn01 = Motion.Object:new(NPC, "s100_089_001", "bn01")
    }
    local kotemon_index = GetIndex(NPC, "s100_089_001")
    local musyamon = {
      fq01 = Motion.Object:new(NPC, "s100_089_002", "fq01"),
      fq02 = Motion.Object:new(NPC, "s100_089_002", "fq02"),
      fe02 = Motion.Object:new(NPC, "s100_089_002", "fe02"),
      fe04 = Motion.Object:new(NPC, "s100_089_002", "fe04"),
      bn01 = Motion.Object:new(NPC, "s100_089_002", "bn01")
    }
    local musyamon_index = GetIndex(NPC, "s100_089_002")
    local zambamon = {
      fq01 = Motion.Object:new(NPC, "s100_089_003", "fq01"),
      fq02 = Motion.Object:new(NPC, "s100_089_003", "fq02"),
      fe02 = Motion.Object:new(NPC, "s100_089_003", "fe02"),
      fe04 = Motion.Object:new(NPC, "s100_089_003", "fe04"),
      bn01 = Motion.Object:new(NPC, "s100_089_003", "bn01")
    }
    local zambamon_index = GetIndex(NPC, "s100_089_003")
    local player = {
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e012 = Motion.Object:new(PLAYER, "", "e012"),
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    }
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(18.15, 0.73, 81.03, 10.61, 1.6, 87.542, default, 0)
    Obj:new(PLAYER, ""):SetPos(12.75, 0, 85.698, true)
    Obj:new(PLAYER, ""):SetRotationY(30, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, musyamon_index, 15)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    musyamon.fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "300")
    local result = tlk:Select(3, base .. "310")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      musyamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "320")
    elseif result == RESULT_TALK01 then
      musyamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "330")
    else
      musyamon.fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "340")
    end
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, kotemon_index, 30)
    kotemon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "350")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zambamon_index, 30)
    zambamon.fe04:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "360")
    result = tlk:Select(3, base .. "370")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      zambamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "380")
    elseif result == RESULT_TALK01 then
      zambamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "390")
    else
      zambamon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "400")
    end
    zambamon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "410")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, kotemon_index, 30)
    kotemon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "420")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, musyamon_index, 30)
    WaitFrame(30)
    musyamon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "430")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zambamon_index, 30)
    zambamon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "440")
    zambamon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "450")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, kotemon_index, 30)
    kotemon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "460")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, musyamon_index, 30)
    musyamon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "470")
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, zambamon_index, 30)
    zambamon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "480")
    tlk:EndTalk(true)
    Cam.Inst:Clear(30)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    WaitFrame(90)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    require("S100_088")
    Qst.Sub:Set(S100_088.ID, S100_088.STEP_015)
  end
end

function S100_089:Event_035()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check(self.Flag002) then
    Qst.Sub:Set(self.ID, self.STEP_020)
  end
end

function S100_089:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local fq01 = Motion.Object:new(NPC, "s100_089_001", "fq01")
    local bn01 = Motion.Object:new(NPC, "s100_089_001", "bn01")
    Obj:new(PLAYER, ""):SetPos(-16.046, 31.577, 24.395)
    Cam.Inst:Set(-18.451, 33.469, 20.67, -13.706, 33.358, 29.472, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "340")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "350")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S100_089:Event_500()
  local fq01 = Motion.Object:new(NPC, "s100_089_001", "fq01")
  local fq02 = Motion.Object:new(NPC, "s100_089_001", "fq02")
  local fe02 = Motion.Object:new(NPC, "s100_089_001", "fe02")
  local bn01 = Motion.Object:new(NPC, "s100_089_001", "bn01")
  local e002 = Motion.Object:new(PLAYER, "", "e002")
  local e004 = Motion.Object:new(PLAYER, "", "e004")
  local e012 = Motion.Object:new(PLAYER, "", "e012")
  local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
  Cam.Inst:Set(-3.2686, 27.51, 53.675, -8.376, 24.577, 45.592, default, 30)
  WaitFrame(30)
  tlk:StartTalkAndCancelDigimonRide()
  fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "540")
  local result = tlk:Select(3, base .. "550")
  WaitFrame(15)
  if result == RESULT_TALK00 then
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "560")
    tlk:Message(base .. "570")
  elseif result == RESULT_TALK01 then
    fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "580")
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "590")
  else
    fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "600")
  end
  Cam.Inst:Clear(30)
  WaitFrame(30)
  tlk:EndTalk()
end

function S100_089:Event_510()
  local fq01 = Motion.Object:new(NPC, "s100_089_002", "fq01")
  local bn01 = Motion.Object:new(NPC, "s100_089_002", "bn01")
  tlk:StartTalkActionAndZoom("s100_089_002")
  fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "530")
  tlk:EndTalkActionAndZoom()
end

function S100_089:Event_520()
  local fq01 = Motion.Object:new(NPC, "s100_089_003", "fq01")
  local bn01 = Motion.Object:new(NPC, "s100_089_003", "bn01")
  tlk:StartTalkActionAndZoom("s100_089_003")
  fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "520")
  tlk:EndTalkActionAndZoom()
end

function S100_089:Event_530()
  local fq02 = Motion.Object:new(NPC, "s100_089_004", "fq02")
  local bn01 = Motion.Object:new(NPC, "s100_089_004", "bn01")
  tlk:StartTalkActionAndZoom("s100_089_004")
  fq02:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "510")
  tlk:EndTalkActionAndZoom()
end

function S100_089:Event_600()
  if Flg.Check("FLAG_IS_CLEAR_S100_089", "FLAG_IS_CLEAR_S110_208") then
    tlk:StartTalkActionAndZoom("s100_089_001")
    tlk:Message(base .. "610")
    tlk:EndTalkActionAndZoom()
  end
end

function S100_089:Event_610()
  if Flg.Check("FLAG_IS_CLEAR_S100_089", "FLAG_IS_CLEAR_S110_208") then
    tlk:StartTalkActionAndZoom("s100_089_002")
    tlk:Message(base .. "620")
    tlk:EndTalkActionAndZoom()
  end
end

function S100_089:Event_620()
  if Flg.Check("FLAG_IS_CLEAR_S100_089", "FLAG_IS_CLEAR_S110_208") then
    tlk:StartTalkActionAndZoom("s100_089_003")
    tlk:Message(base .. "630")
    tlk:EndTalkActionAndZoom()
  end
end
