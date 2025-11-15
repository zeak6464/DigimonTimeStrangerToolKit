S020_018 = {
  ID = 18,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_255 = 255
}
local base = "s020_018_"
local text_file = "s020_018"
local tlk = Tlk:new(text_file, 1, true)

function S020_018:Event_000()
  Qst.Sub:Start(self.ID, self.STEP_001, true)
end

function S020_018:Event_010()
  local npc_index01 = GetIndex(NPC, "s020_018_npc01")
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index01)
  local y_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
  Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
  Field.ObjectLoadMotion(NPC, npc_index01, "bn02")
  Field.ObjectLoadMotion(NPC, npc_index01, "ba02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index01, "f004")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    Field.ObjectResetAim(NPC, npc_index01, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "030")
    local result = tlk:Select(3, base .. "040")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "050")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "060")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "070")
    end
    tlk:Message(base .. "080")
    Field.ObjectPlayMotion(NPC, npc_index01, "bn02", 10, true)
    tlk:Message(base .. "090")
    local result = tlk:Select(3, base .. "100")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "110")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "120")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "f004", 10, 10)
      tlk:Message(base .. "130")
    end
    tlk:Message(base .. "140")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
    tlk:Message(base .. "150")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "160")
    local result = tlk:Select(3, base .. "170")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
      tlk:Message(base .. "180")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "190")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "200")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "210")
    Field.ObjectPlayMotion(NPC, npc_index01, "bn02", 10, true)
    tlk:Message(base .. "220")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "bn01", 10, 10)
    tlk:Message(base .. "230")
    local result = tlk:Select(3, base .. "240")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "250")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "260")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
      tlk:Message(base .. "270")
    end
    tlk:Message(base .. "280")
    tlk:Message(base .. "290")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "300")
    local result = tlk:Select(3, base .. "310")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
      tlk:Message(base .. "320")
      Qst.Sub:Set(self.ID, self.STEP_005)
      Qst.Sub:Set(self.ID, self.STEP_010)
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "330")
      Qst.Sub:Set(self.ID, self.STEP_005)
      Qst.Sub:Set(self.ID, self.STEP_010)
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "340")
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_005)
      tlk:EndTalk()
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "350")
    local result = tlk:Select(2, base .. "360")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
      tlk:Message(base .. "370")
      Qst.Sub:Set(self.ID, self.STEP_010)
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "380")
      tlk:EndTalk()
    end
  end
  if Qst.Sub:Check(self.ID, self.STEP_010) then
    tlk:Message(base .. "390")
    tlk:EndTalk()
    Qst.Sub:Start(self.ID, 1, false)
    Flg.Set("FLAG_SUB_020_018_001")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChange("d", 308, "start_20", true, FADE_BLACK, FADE_TIME)
  end
end

function S020_018:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010) then
    local npc_index01 = GetIndex(NPC, "s020_018_npc01")
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local npc_pos = Field.ObjectGetPosition(NPC, npc_index01)
    local y_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
    Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index01, "bn02")
    Field.ObjectLoadMotion(NPC, npc_index01, "ba02")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index01, "f004")
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectSetRotationY(NPC, npc_index01, y_degree, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "400")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
    tlk:Message(base .. "410")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "420")
    tlk:EndTalk()
  end
end

function S020_018:Event_030()
  local npc_index01 = GetIndex(NPC, "s020_018_npc01")
  tlk:StartTalkAndCancelDigimonRide()
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
  tlk:Message(base .. "1140")
  tlk:EndTalk()
end

function S020_018:Event_040()
  local npc_index01 = GetIndex(NPC, "s020_018_npc01")
  tlk:StartTalkAndCancelDigimonRide()
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
  tlk:Message(base .. "430")
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
  tlk:Message(base .. "440")
  tlk:EndTalk()
end

function S020_018:Event_050()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "450")
  tlk:Message(base .. "460")
  tlk:Message(base .. "470")
  tlk:EndTalk()
end

function S020_018:Event_060()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "480")
  tlk:Message(base .. "490")
  tlk:EndTalk()
end

function S020_018:Event_070()
  local npc_index01 = GetIndex(NPC, "s020_018_npc01")
  Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
  Field.ObjectLoadMotion(NPC, npc_index01, "bn02")
  Field.ObjectLoadMotion(NPC, npc_index01, "ba02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index01, "f004")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  tlk:StartTalkAndCancelDigimonRide()
  HideMinimap(true)
  HideGuide(true)
  FadeOutWithWait(0, 15)
  Obj:new(NPC, "s020_018_npc01"):SetPos(3.22, 0, -4.64)
  Obj:new(PLAYER, ""):SetPos(3.58, 0, -3.64)
  Obj:new(NPC, "s020_018_npc01"):SetRotationY(100, 0)
  Cam.Inst:Set(7.917, -0.99, -6.686, -0.276, 2.04, -1.83, default, 0)
  FadeInWithWait(0, 15)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
  tlk:Message(base .. "500")
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
  tlk:Message(base .. "510")
  local result = tlk:Select(3, base .. "520")
  WaitFrame(15)
  if result == RESULT_TALK00 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "530")
  end
  if result == RESULT_TALK01 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "540")
  end
  if result == RESULT_TALK02 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
    tlk:Message(base .. "550")
  end
  tlk:Message(base .. "560")
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
  tlk:Message(base .. "570")
  tlk:Message(base .. "580")
  local result = tlk:Select(3, base .. "590")
  WaitFrame(15)
  if result == RESULT_TALK00 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "600")
  end
  if result == RESULT_TALK01 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "610")
  end
  if result == RESULT_TALK02 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
    tlk:Message(base .. "620")
  end
  tlk:Message(base .. "630")
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
  tlk:Message(base .. "640")
  Qst.Sub:Set(self.ID, self.STEP_015)
  tlk:EndTalk()
  Flg.Set("FLAG_SUB_020_018_002")
  Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
  MapChange("d", 301, "start_21", true, 0, FADE_TIME)
end

function S020_018:Event_080()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) and not Flg.Check("FLAG_SUB_020_018_005") then
    local tlk = Tlk:new(text_file, 1, true, false)
    local npc_index01 = GetIndex(NPC, "s020_018_npc01")
    Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index01, "bn02")
    Field.ObjectLoadMotion(NPC, npc_index01, "ba02")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index01, "f004")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Obj:new(PLAYER, ""):SetRotationY(-60, 0)
    Cam.Inst:Set(46.57, 1.67, 68.61, 51.47, 2.69, 77.27, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "650")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
    tlk:Message(base .. "660")
    local result = tlk:Select(3, base .. "670")
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "680")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "690")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "700")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
    tlk:Message(base .. "710")
    Flg.Set("FLAG_SUB_020_018_005")
    PlayerTurnToObject(GIM, "gim_0004", true, false, 0, 0)
    SetFollowerCameraOperateRotation(0, 120, 0)
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Cam.Inst:Clear(30)
    Flg.Set("FLAG_SUB_020_018_003")
  end
end

function S020_018:Event_090()
  local npc_index01 = GetIndex(NPC, "s020_018_npc01")
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index01)
  local y_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
  Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
  Field.ObjectLoadMotion(NPC, npc_index01, "bn02")
  Field.ObjectLoadMotion(NPC, npc_index01, "ba02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index01, "f004")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_025) then
    tlk:StartTalkAndCancelDigimonRide()
    START_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "920")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
    tlk:Message(base .. "930")
    tlk:Message(base .. "940")
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
    Field.MovePlayerToRelativePosFrame(1, 1, 30)
    WaitFrame(30)
    goto lbl_471
  elseif Qst.Sub:Check(self.ID, self.STEP_025, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    START_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "950")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba02", 10, 10)
    tlk:Message(base .. "960")
    tlk:Message(base .. "970")
    local result = tlk:Select(3, base .. "980")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "990")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "1010")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "1020")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "1030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
    tlk:Message(base .. "1040")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "1050")
    tlk:Message(base .. "1060")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "1070")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "1080")
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Obj:new(OGIM, "gim_access50"):Invisible()
    Obj:new(OGIM, "gim_access51"):Invisible()
    Obj:new(OGIM, "gim_access52"):Invisible()
    Obj:new(OGIM, "gim_access53"):Invisible()
    END_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
  elseif Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) then
    tlk:StartTalkAndCancelDigimonRide()
    START_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
    tlk:Message(base .. "720")
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
    Field.MovePlayerToRelativePosFrame(1, 1, 30)
    WaitFrame(30)
  end
  ::lbl_471::
end

function S020_018:Event_100()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "760")
  local result = tlk:Select(2, base .. "770")
  if result == RESULT_TALK00 then
    tlk:Message(base .. "780")
    tlk:EndTalk()
    return true
  end
  if result == RESULT_TALK01 then
    tlk:Message(base .. "790")
    tlk:EndTalk()
    return false
  end
end

function S020_018:Event_110()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "800")
  local result = tlk:Select(2, base .. "840")
  if result == RESULT_TALK00 then
    tlk:Message(base .. "850")
    if not Qst.Sub:Check(self.ID, self.STEP_020) then
      Qst.Sub:Set(self.ID, self.STEP_020)
    end
    tlk:EndTalk(true)
    INFO_GET_ITEM(768, 1)
    Obj:new(OGIM, "gim_access50"):Invisible()
  end
  if result == RESULT_TALK01 then
    tlk:EndTalk(true)
  end
end

function S020_018:Event_120()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "810")
  local result = tlk:Select(2, base .. "840")
  if result == RESULT_TALK00 then
    tlk:Message(base .. "860")
    if not Qst.Sub:Check(self.ID, self.STEP_020) then
      Qst.Sub:Set(self.ID, self.STEP_020)
    end
    tlk:EndTalk(true)
    INFO_GET_ITEM(769, 1)
    Obj:new(OGIM, "gim_access51"):Invisible()
  end
  if result == RESULT_TALK01 then
    tlk:EndTalk(true)
  end
end

function S020_018:Event_130()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "820")
  local result = tlk:Select(2, base .. "840")
  if result == RESULT_TALK00 then
    tlk:Message(base .. "870")
    if not Qst.Sub:Check(self.ID, self.STEP_020) then
      Qst.Sub:Set(self.ID, self.STEP_020)
    end
    INFO_GET_ITEM(770, 1)
    tlk:EndTalk(true)
    Obj:new(OGIM, "gim_access52"):Invisible()
  end
  if result == RESULT_TALK01 then
    tlk:EndTalk(true)
  end
end

function S020_018:Event_140()
  tlk:StartTalkAndCancelDigimonRide()
  tlk:Message(base .. "830")
  local result = tlk:Select(2, base .. "840")
  if result == RESULT_TALK00 then
    tlk:Message(base .. "880")
    if not Qst.Sub:Check(self.ID, self.STEP_020) then
      Qst.Sub:Set(self.ID, self.STEP_020)
    end
    Qst.Sub:Set(self.ID, self.STEP_025)
    INFO_GET_ITEM(771, 1)
    tlk:EndTalk(true)
    Obj:new(OGIM, "gim_access53"):Invisible()
  end
  if result == RESULT_TALK01 then
    tlk:EndTalk(true)
  end
end

function S020_018:Event_145()
  local npc_index01 = GetIndex(NPC, "s020_018_npc01")
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index01)
  local y_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
  Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
  Field.ObjectLoadMotion(NPC, npc_index01, "bn02")
  Field.ObjectLoadMotion(NPC, npc_index01, "ba02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
  Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index01, "f004")
  START_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
  tlk:StartTalkAndCancelDigimonRide()
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
  tlk:Message(base .. "1080")
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM("s020_018_npc01", true, true)
end
