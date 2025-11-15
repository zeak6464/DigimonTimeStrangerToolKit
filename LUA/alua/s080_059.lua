S080_059 = {
  ID = 59,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_007 = 7,
  STEP_008 = 8,
  STEP_009 = 9,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}
local base = "s080_059_"
local text_file = "s080_059"
local tlk = Tlk:new(text_file, 1, true)

function S080_059:Event_000()
  Qst.Sub:Start(self.ID, self.STEP_001, true)
end

function S080_059:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local corona_index = GetIndex(NPC, "s080_059_001")
    local luna_index = GetIndex(NPC, "s080_059_002")
    Field.ObjectLoadMotion(NPC, corona_index, "bn01")
    Field.ObjectLoadMotion(NPC, corona_index, "e002")
    Field.ObjectLoadMotion(NPC, corona_index, "e004")
    Field.ObjectLoadMotion(NPC, corona_index, "e005")
    Field.ObjectLoadMotion(NPC, corona_index, "e006")
    Field.ObjectLoadMotion(NPC, corona_index, "e007")
    Field.ObjectLoadMotion(NPC, corona_index, "e008")
    Field.ObjectLoadMotion(NPC, corona_index, "br01")
    Field.ObjectLoadMotion(NPC, corona_index, "fe02")
    Field.ObjectLoadMotion(NPC, corona_index, "fq01")
    Field.ObjectLoadMotion(NPC, corona_index, "fq02")
    Field.ObjectLoadMotion(NPC, luna_index, "bn01")
    Field.ObjectLoadMotion(NPC, luna_index, "e002")
    Field.ObjectLoadMotion(NPC, luna_index, "e004")
    Field.ObjectLoadMotion(NPC, luna_index, "e005")
    Field.ObjectLoadMotion(NPC, luna_index, "e006")
    Field.ObjectLoadMotion(NPC, luna_index, "e007")
    Field.ObjectLoadMotion(NPC, luna_index, "e008")
    Field.ObjectLoadMotion(NPC, luna_index, "br01")
    Field.ObjectLoadMotion(NPC, luna_index, "fe02")
    Field.ObjectLoadMotion(NPC, luna_index, "fq01")
    Field.ObjectLoadMotion(NPC, luna_index, "fq02")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e010_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(9.55, 3.81, 50.23, 1.26, 2.986, 44.71, default, 0)
    Obj:new(PLAYER, ""):SetPos(4.67, 3, 48.57, false)
    Obj:new(PLAYER, ""):SetRotationY(130, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, corona_index, 15)
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e004", 10, 10)
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    Field.ObjectPlayMotion(NPC, corona_index, "e002", 15, true)
    tlk:Message(base .. "030")
    local result = tlk:Select(3, base .. "040")
    Field.ObjectLookAtTheObject(NPC, corona_index, PLAYER, 1, 15)
    if result == RESULT_TALK00 then
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "fq01", 10, 10)
      tlk:Message(base .. "050")
    end
    if result == RESULT_TALK01 then
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e008", 10, 10)
      tlk:Message(base .. "060")
    end
    if result == RESULT_TALK02 then
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e008", 10, 10)
      tlk:Message(base .. "070")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e004", 10, 10)
    tlk:Message(base .. "080")
    local result = tlk:Select(3, base .. "090")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "100")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "110")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "120")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e002", 10, 10)
    tlk:Message(base .. "130")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e007", 10, 10)
    tlk:Message(base .. "140")
    Obj:new(NPC, "s080_059_002"):SetRotationY(130, 15)
    Field.ObjectPlayMotion(NPC, luna_index, "br01", 15, true)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e008", 10, 10)
    tlk:Message(base .. "150")
    tlk:Message(base .. "160")
    Field.ObjectResetAim(NPC, corona_index, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e008", 10, 10)
    tlk:Message(base .. "170")
    tlk:Message(base .. "180")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e006", 10, 10)
    tlk:Message(base .. "190")
    tlk:Message(base .. "200")
    tlk:Message(base .. "210")
    tlk:Message(base .. "220")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e005", 10, 10)
    tlk:Message(base .. "230")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e008", 10, 10)
    tlk:Message(base .. "240")
    Obj:new(NPC, "s080_059_001"):SetRotationY(-120, 15)
    Field.ObjectPlayMotion(NPC, corona_index, "br01", 15, true)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e002", 10, 10)
    tlk:Message(base .. "250")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e004", 10, 10)
    tlk:Message(base .. "260")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e002", 10, 10)
    tlk:Message(base .. "270")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e004", 10, 10)
    tlk:Message(base .. "280")
    Field.ObjectPlayMotion(NPC, corona_index, "e005", 15, true)
    tlk:Message(base .. "290")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e002", 10, 10)
    tlk:Message(base .. "300")
    tlk:Message(base .. "310")
    FadeOutWithWait(0, 15)
    Obj:new(NPC, "s080_059_001"):Invisible()
    Obj:new(NPC, "s080_059_002"):Invisible()
    PlayerObjectResetAim()
    FadeInWithWait(0, 15)
    Cam.Inst:Set(7.59, 4.11, 53.23, -0.76, 2.85, 47.88, default, 30)
    WaitFrame(30)
    tlk:Message(base .. "320")
    local result = tlk:Select(3, base .. "330")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "340")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "350")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "360")
    end
    tlk:Message(base .. "370")
    tlk:Message(base .. "380")
    local correct = false
    while not correct do
      local result = tlk:Select(3, base .. "390")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        correct = true
        tlk:Message(base .. "400")
        tlk:Message(base .. "410")
        tlk:Message(base .. "420")
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "430")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "440")
      end
    end
    local correct = false
    while not correct do
      local result = tlk:Select(3, base .. "450")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        correct = true
        tlk:Message(base .. "460")
        tlk:Message(base .. "470")
        tlk:EndTalk(true)
        Qst.Sub:Start(self.ID, 1, false)
        HideMinimap(false)
        HideGuide(false)
        Qst.Sub:Set(self.ID, self.STEP_005)
        Flg.Set("FLAG_SUB_080_059_001")
        Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
        Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "480")
      end
      if result == RESULT_TALK02 then
        tlk:Message(base .. "490")
      end
    end
    Cam.Inst:Clear(30)
  end
end

function S080_059:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "500")
    tlk:Message(base .. "510")
    tlk:EndTalk()
  end
end

function S080_059:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005) then
    local luna_index = GetIndex(NPC, "s080_059_002")
    Field.ObjectLoadMotion(NPC, luna_index, "bn01")
    Field.ObjectLoadMotion(NPC, luna_index, "e002")
    Field.ObjectLoadMotion(NPC, luna_index, "e004")
    Field.ObjectLoadMotion(NPC, luna_index, "e005")
    Field.ObjectLoadMotion(NPC, luna_index, "e006")
    Field.ObjectLoadMotion(NPC, luna_index, "e007")
    Field.ObjectLoadMotion(NPC, luna_index, "e008")
    Field.ObjectLoadMotion(NPC, luna_index, "fe02")
    Field.ObjectLoadMotion(NPC, luna_index, "fq01")
    Field.ObjectLoadMotion(NPC, luna_index, "fq02")
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e004", 10, 10)
    tlk:Message(base .. "520")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e007", 10, 10)
    tlk:Message(base .. "530")
    tlk:EndTalk()
  end
end

function S080_059:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "540")
    tlk:Message(base .. "550")
    Qst.Sub:Set(self.ID, self.STEP_010)
    tlk:EndTalk()
  end
end

function S080_059:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "560")
    tlk:Message(base .. "570")
    tlk:EndTalk()
  end
end

function S080_059:Event_065(npc_name)
  local vader_index = GetIndex(NPC, npc_name)
  local vader_rot = Field.ObjectGetRotationY(NPC, vader_index)
  Field.ObjectLoadMotion(NPC, vader_index, "bn01")
  Field.ObjectLoadMotion(NPC, vader_index, "bn02")
  Field.ObjectLoadMotion(NPC, vader_index, "e501")
  Field.ObjectLoadMotion(NPC, vader_index, "bd03")
  Field.ObjectLoadMotion(NPC, vader_index, "fq01")
  Field.ObjectLoadMotion(NPC, vader_index, "fq02")
  Field.ObjectLoadMotion(NPC, vader_index, "fe02")
  Field.ObjectLoadMotion(NPC, vader_index, "fe04")
  Field.ObjectLoadMotion(NPC, vader_index, "e500")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e005")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e010")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local money = Common.GetMoney()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(50.66, -37.44, 58.646, 43.123, -34.4314, 64.485, default, 0)
    Obj:new(PLAYER, ""):SetPos(43.96, -36, 63.42, true)
    Obj:new(PLAYER, ""):SetRotationY(45, 0)
    Obj:new(NPC, npc_name):SetRotationY(250, 0)
    Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, NPC, vader_index, 0, 0)
    WaitFrame(1)
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "1100")
    local result = tlk:Select(3, base .. "1110")
    if result == RESULT_TALK00 then
      if Qst.Sub:Check(self.ID, self.STEP_006, self.STEP_007) then
        require("S080_059")
        S080_059:Event_069(npc_name)
        goto lbl_534
      elseif Qst.Sub:Check(self.ID, self.STEP_007, self.STEP_008) then
        require("S080_059")
        S080_059:Event_066(npc_name)
        goto lbl_534
      elseif Qst.Sub:Check(self.ID, self.STEP_008, self.STEP_009) then
        require("S080_059")
        S080_059:Event_067(npc_name)
        goto lbl_534
      elseif Qst.Sub:Check(self.ID, self.STEP_009, self.STEP_010) then
        require("S080_059")
        S080_059:Event_068(npc_name)
        goto lbl_534
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fq01", 10, 10)
      tlk:Message(base .. "930")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
      tlk:Message(base .. "940")
      local result = tlk:Select(3, base .. "950")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        if 10000000 <= money then
          Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e004", 10, 10)
          WaitFrame(30)
          PlaySE(101012, 100)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
          tlk:Message(base .. "1060")
          Common.AddMoney(-10000000)
          INFO_GET_ITEM(779, 1)
          HideMinimap(false)
          HideGuide(false)
          Qst.Sub:Set(self.ID, self.STEP_010)
          tlk:EndTalk(true)
          WaitFrame(30)
          MapChange("d", 201, "start_21", true, FADE_BLACK, FADE_TIME)
        else
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fq02", 10, 10)
          tlk:Message(base .. "1065")
          tlk:EndTalk()
          goto lbl_534
        end
      elseif result == RESULT_TALK01 then
        Field.ObjectPlayMotion(PLAYER, 1, "e008", 15, true)
        WaitFrame(30)
        Qst.Sub:Set(self.ID, self.STEP_006)
        require("S080_059")
        S080_059:Event_069(npc_name)
        goto lbl_534
      else
        if result == RESULT_TALK02 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
          tlk:Message(base .. "1090")
          tlk:EndTalk()
        else
        end
      end
    elseif result == RESULT_TALK01 then
      local cam_npc = {
        52.38,
        -36.86,
        57.71,
        44.82,
        -34.83,
        63.93
      }
      local cam_shop = {
        51.44,
        -38.39,
        57.14,
        44.68,
        -34.46,
        63.37
      }
      tlk:EndTalk()
      CommonShopStart(npc_name, 140, "ba02", "bs01", "fq02", cam_npc, cam_shop)
      goto lbl_534
    else
      if result == RESULT_TALK02 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
        tlk:Message(base .. "1090")
        tlk:EndTalk()
      else
      end
    end
  end
  ::lbl_534::
  HideMinimap(false)
  HideGuide(false)
  PlayerObjectResetAim()
  Field.ObjectResetAim(NPC, vader_index, 10)
  Obj:new(NPC, npc_name):SetRotationY(vader_rot, 15)
  Field.ObjectPlayMotion(NPC, vader_index, "bn01", 10, true)
  Cam.Inst:Clear(30)
end

function S080_059:Event_069(npc_name)
  local vader_index = GetIndex(NPC, npc_name)
  local money = Common.GetMoney()
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fq02", 10, 10)
  if not Flg.Check("FLAG_SUB_080_059_010") then
    tlk:Message(base .. "960")
    tlk:Message(base .. "965")
    Flg.Set("FLAG_SUB_080_059_010")
  else
    tlk:Message(base .. "1120")
    tlk:Message(base .. "1130")
  end
  local result = tlk:Select(3, base .. "970")
  if result == RESULT_TALK01 then
    require("S080_059")
    Field.ObjectPlayMotion(PLAYER, 1, "e012", 15, true)
    WaitFrame(30)
    Qst.Sub:Set(self.ID, self.STEP_007)
    S080_059:Event_066(npc_name)
  elseif result == RESULT_TALK00 then
    if 10000 <= money then
      Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e004", 10, 10)
      WaitFrame(30)
      PlaySE(101012, 100)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
      tlk:Message(base .. "1060")
      Common.AddMoney(-10000)
      INFO_GET_ITEM(779, 1)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
      tlk:EndTalk(true)
      WaitFrame(30)
      MapChange("d", 201, "start_21", true, FADE_BLACK, FADE_TIME)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fq02", 10, 10)
      tlk:Message(base .. "1065")
    end
    tlk:EndTalk()
    goto lbl_196
  else
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
      tlk:Message(base .. "1090")
      tlk:EndTalk()
    else
    end
  end
  ::lbl_196::
  HideMinimap(false)
  HideGuide(false)
  Cam.Inst:Clear(30)
end

function S080_059:Event_066(npc_name)
  local vader_index = GetIndex(NPC, npc_name)
  local money = Common.GetMoney()
  Field.ObjectPlayMotion(NPC, vader_index, "bn02", 15, true)
  if not Flg.Check("FLAG_SUB_080_059_011") then
    tlk:Message(base .. "980")
    Flg.Set("FLAG_SUB_080_059_011")
  else
    tlk:Message(base .. "1140")
    tlk:Message(base .. "1130")
  end
  local result = tlk:Select(3, base .. "990")
  if result == RESULT_TALK01 then
    Field.ObjectPlayMotion(PLAYER, 1, "e004_01", 15, true)
    WaitFrame(30)
    Qst.Sub:Set(self.ID, self.STEP_008)
    require("S080_059")
    S080_059:Event_067(npc_name)
  elseif result == RESULT_TALK00 then
    if 5000 <= money then
      Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e004", 10, 10)
      WaitFrame(30)
      PlaySE(101012, 100)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
      tlk:Message(base .. "1060")
      Common.AddMoney(-5000)
      INFO_GET_ITEM(779, 1)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
      tlk:EndTalk(true)
      WaitFrame(30)
      MapChange("d", 201, "start_21", true, FADE_BLACK, FADE_TIME)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fq02", 10, 10)
      tlk:Message(base .. "1065")
    end
    tlk:EndTalk()
    goto lbl_190
  else
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
      tlk:Message(base .. "1090")
      tlk:EndTalk()
    else
    end
  end
  ::lbl_190::
  HideMinimap(false)
  HideGuide(false)
  Cam.Inst:Clear(30)
end

function S080_059:Event_067(npc_name)
  local money = Common.GetMoney()
  local vader_index = GetIndex(NPC, npc_name)
  Field.ObjectPlayMotion(NPC, vader_index, "e500", 15, true)
  if not Flg.Check("FLAG_SUB_080_059_012") then
    tlk:Message(base .. "1000")
    Flg.Set("FLAG_SUB_080_059_012")
  else
    tlk:Message(base .. "1150")
    tlk:Message(base .. "1160")
  end
  local result = tlk:Select(3, base .. "1020")
  if result == RESULT_TALK00 then
    Qst.Sub:Set(self.ID, self.STEP_009)
    require("S080_059")
    S080_059:Event_068(npc_name)
  elseif result == RESULT_TALK01 then
    if 1000 <= money then
      Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e004", 10, 10)
      WaitFrame(30)
      PlaySE(101012, 100)
      tlk:Message(base .. "1060")
      Common.AddMoney(-1000)
      INFO_GET_ITEM(779, 1)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
      tlk:EndTalk(true)
      WaitFrame(30)
      MapChange("d", 201, "start_21", true, FADE_BLACK, FADE_TIME)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fq02", 10, 10)
      tlk:Message(base .. "1065")
    end
    tlk:EndTalk()
    goto lbl_171
  else
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
      tlk:Message(base .. "1090")
      tlk:EndTalk()
    else
    end
  end
  ::lbl_171::
  HideMinimap(false)
  HideGuide(false)
  Cam.Inst:Clear(30)
end

function S080_059:Event_068(npc_name)
  local money = Common.GetMoney()
  local vader_index = GetIndex(NPC, npc_name)
  Field.ObjectPlayMotion(NPC, vader_index, "bn02", 15, true)
  tlk:Message(base .. "1030")
  Field.ObjectPlayMotion(PLAYER, 1, "e005", 15, true)
  WaitFrame(45)
  tlk:Message(base .. "1040")
  local result = tlk:Select(2, base .. "1050")
  if result == RESULT_TALK00 then
    if 10000 <= money then
      Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e010", 10, 10)
      WaitFrame(30)
      PlaySE(101012, 100)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fe02", 10, 10)
      tlk:Message(base .. "1170")
      Common.AddMoney(-10000)
      INFO_GET_ITEM(779, 1)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
      tlk:EndTalk(true)
      WaitFrame(30)
      MapChange("d", 201, "start_21", true, FADE_BLACK, FADE_TIME)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, vader_index, "fq02", 10, 10)
      tlk:Message(base .. "1065")
    end
    tlk:EndTalk()
    goto lbl_148
  else
    if result == RESULT_TALK01 then
      tlk:Message(base .. "1070")
      tlk:EndTalk()
    else
    end
  end
  ::lbl_148::
  HideMinimap(false)
  HideGuide(false)
  Cam.Inst:Clear(30)
end

function S080_059:Event_070()
  Qst.Sub:Set(self.ID, self.STEP_010)
  Flg.Set("FLAG_SUB_080_059_002")
end

function S080_059:Event_080()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
    Cam.Inst:Set(5.35, 3.61, 51.49, -2.694, 3.5, 45.55, default, 30)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "580")
    if Qst.Sub:Check(self.ID, self.STEP_010) then
      local result = tlk:Select(3, base .. "590")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "600")
        tlk:Message(base .. "610")
        tlk:MessageClose()
        INFO_RELEASE_ITEM(779, 1)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(30)
        PlaySE(200015, 100)
        WaitFrame(30)
        FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
        tlk:Message(base .. "640")
        tlk:Message(base .. "650")
        tlk:Message(base .. "660")
        Qst.Sub:Set(self.ID, self.STEP_015)
        Flg.Set("FLAG_SUB_080_059_003")
        tlk:EndTalk()
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        MapChange("d", 202, "start_20", true, FADE_BLACK, FADE_TIME)
      end
      if result == RESULT_TALK01 then
        tlk:Message(base .. "620")
        tlk:Message(base .. "630")
        tlk:EndTalk()
      end
      if result == RESULT_TALK02 then
        tlk:EndTalk()
      end
    else
      local result = tlk:Select(2, base .. "591")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "620")
        tlk:Message(base .. "630")
        tlk:EndTalk()
      end
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      end
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_0255) then
    Cam.Inst:Set(8.24, 3.61, 53.46, -4.34, 5.5, 50.76, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "660")
    tlk:EndTalk()
  end
  Cam.Inst:Clear(30)
  HideMinimap(false)
  HideGuide(false)
end

function S080_059:Event_090()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local corona_index = GetIndex(NPC, "s080_059_001")
    local luna_index = GetIndex(NPC, "s080_059_002")
    Field.ObjectLoadMotion(NPC, corona_index, "bn01")
    Field.ObjectLoadMotion(NPC, corona_index, "e002")
    Field.ObjectLoadMotion(NPC, corona_index, "e004")
    Field.ObjectLoadMotion(NPC, corona_index, "e005")
    Field.ObjectLoadMotion(NPC, corona_index, "e006")
    Field.ObjectLoadMotion(NPC, corona_index, "e007")
    Field.ObjectLoadMotion(NPC, corona_index, "e008")
    Field.ObjectLoadMotion(NPC, corona_index, "fe02")
    Field.ObjectLoadMotion(NPC, corona_index, "fq01")
    Field.ObjectLoadMotion(NPC, corona_index, "fq02")
    Field.ObjectLoadMotion(NPC, luna_index, "bn01")
    Field.ObjectLoadMotion(NPC, luna_index, "e002")
    Field.ObjectLoadMotion(NPC, luna_index, "e004")
    Field.ObjectLoadMotion(NPC, luna_index, "e005")
    Field.ObjectLoadMotion(NPC, luna_index, "e006")
    Field.ObjectLoadMotion(NPC, luna_index, "e007")
    Field.ObjectLoadMotion(NPC, luna_index, "e008")
    Field.ObjectLoadMotion(NPC, luna_index, "fe02")
    Field.ObjectLoadMotion(NPC, luna_index, "fq01")
    Field.ObjectLoadMotion(NPC, luna_index, "fq02")
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(5)
    HideMinimap(true)
    WaitFrame(5)
    HideGuide(true)
    Cam.Inst:Set(21.964594, 0.102, -17.757, 26.46, 1.2706, -8.9, default, 0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e006", 10, 10)
    tlk:Message(base .. "670")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e004", 10, 10)
    tlk:Message(base .. "680")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e006", 10, 10)
    Field.ObjectResetAim(NPC, corona_index, 10)
    tlk:Message(base .. "690")
    Field.ObjectLookAtTheObject(NPC, corona_index, NPC, luna_index, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e002", 10, 10)
    tlk:Message(base .. "700")
    Flg.Set("FLAG_SUB_080_059_004")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    tlk:EndTalk(true)
    BackFadeOutWithWait(FADE_BLACK, 15)
    MapChange("d", 201, "start_20", true, FADE_BLACK, FADE_TIME)
  end
end

function S080_059:Event_100()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    local corona_index = GetIndex(NPC, "s080_059_001_02")
    local luna_index = GetIndex(NPC, "s080_059_002_02")
    Field.ObjectLoadMotion(NPC, corona_index, "bn01")
    Field.ObjectLoadMotion(NPC, corona_index, "e002")
    Field.ObjectLoadMotion(NPC, corona_index, "e004")
    Field.ObjectLoadMotion(NPC, corona_index, "e005")
    Field.ObjectLoadMotion(NPC, corona_index, "e006")
    Field.ObjectLoadMotion(NPC, corona_index, "e007")
    Field.ObjectLoadMotion(NPC, corona_index, "e008")
    Field.ObjectLoadMotion(NPC, corona_index, "fe02")
    Field.ObjectLoadMotion(NPC, corona_index, "fq01")
    Field.ObjectLoadMotion(NPC, corona_index, "fq02")
    Field.ObjectLoadMotion(NPC, luna_index, "bn01")
    Field.ObjectLoadMotion(NPC, luna_index, "e002")
    Field.ObjectLoadMotion(NPC, luna_index, "e004")
    Field.ObjectLoadMotion(NPC, luna_index, "e005")
    Field.ObjectLoadMotion(NPC, luna_index, "e006")
    Field.ObjectLoadMotion(NPC, luna_index, "e007")
    Field.ObjectLoadMotion(NPC, luna_index, "e008")
    Field.ObjectLoadMotion(NPC, luna_index, "fe02")
    Field.ObjectLoadMotion(NPC, luna_index, "fq01")
    Field.ObjectLoadMotion(NPC, luna_index, "fq02")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e010_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Obj:new(PLAYER, ""):SetPos(4.67, 2.106, 48.57, true)
    Obj:new(PLAYER, ""):SetRotationY(130, 0)
    Cam.Inst:Set(9.55, 3.81, 50.23, 1.26, 2.986, 44.71, default, 0)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e008", 10, 10)
    tlk:Message(base .. "710")
    tlk:Message(base .. "720")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e004", 10, 10)
    tlk:Message(base .. "730")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e005", 10, 10)
    tlk:Message(base .. "740")
    Field.ObjectLookAtTheObject(NPC, corona_index, NPC, luna_index, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e002", 10, 10)
    tlk:Message(base .. "750")
    Field.ObjectLookAtTheObject(NPC, luna_index, NPC, corona_index, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e006", 10, 10)
    tlk:Message(base .. "760")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e004", 10, 10)
    tlk:Message(base .. "770")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e007", 10, 10)
    tlk:Message(base .. "780")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e008", 10, 10)
    tlk:Message(base .. "790")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e002", 10, 10)
    tlk:Message(base .. "800")
    Field.ObjectResetAim(NPC, corona_index, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, corona_index, "e004", 10, 10)
    tlk:Message(base .. "810")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e002", 10, 10)
    tlk:Message(base .. "820")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(NPC, "s080_059_001_02"):Invisible()
    Obj:new(NPC, "s080_059_003"):Invisible()
    Field.ObjectResetAim(NPC, luna_index, 15)
    local start_sound = Sound.PlaySE(403053, 100)
    while Sound.IsPlaySE(403053) do
      WaitFrame(1)
    end
    Sound.StopSE(start_sound, 1)
    WaitFrame(30)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    Cam.Inst:Set(10.97, 1.61, 45.94, 1.51, 3.43, 48.62, default, 30)
    WaitFrame(30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e005", 10, 10)
    tlk:Message(base .. "830")
    PlayerTurnToObject(NPC, "s080_059_002_02", true, false, 0, 0)
    local result = tlk:Select(3, base .. "840")
    Field.ObjectLookAtTheObject(NPC, luna_index, PLAYER, 1, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e002", 10, 10)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e008", 10, 10)
      tlk:Message(base .. "850")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e008", 10, 10)
      tlk:Message(base .. "860")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e008", 10, 10)
      tlk:Message(base .. "870")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "fq01", 10, 10)
    tlk:Message(base .. "880")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e005", 10, 10)
    tlk:Message(base .. "890")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e007", 10, 10)
    tlk:Message(base .. "900")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e004", 10, 10)
    tlk:Message(base .. "910")
    Field.ObjectResetAim(NPC, luna_index, 15)
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Obj:new(OGIM, "s080_blimp_col_1"):Invisible()
    Cam.Inst:Clear(30)
  end
end

function S080_059:Event_110()
  local luna_index = GetIndex(NPC, "s080_059_002_02")
  Field.ObjectLoadMotion(NPC, luna_index, "bn01")
  Field.ObjectLoadMotion(NPC, luna_index, "e002")
  Field.ObjectLoadMotion(NPC, luna_index, "e004")
  Field.ObjectLoadMotion(NPC, luna_index, "e005")
  Field.ObjectLoadMotion(NPC, luna_index, "e006")
  Field.ObjectLoadMotion(NPC, luna_index, "e007")
  Field.ObjectLoadMotion(NPC, luna_index, "e008")
  Field.ObjectLoadMotion(NPC, luna_index, "fe02")
  Field.ObjectLoadMotion(NPC, luna_index, "fq01")
  Field.ObjectLoadMotion(NPC, luna_index, "fq02")
  tlk:StartTalkAndCancelDigimonRide()
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e005", 10, 10)
  tlk:Message(base .. "890")
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e007", 10, 10)
  tlk:Message(base .. "900")
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, luna_index, "e004", 10, 10)
  tlk:Message(base .. "910")
  tlk:EndTalk()
end
