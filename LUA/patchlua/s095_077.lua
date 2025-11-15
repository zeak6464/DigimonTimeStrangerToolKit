S095_077 = {
  ID = 77,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_095_077_001",
  Flg02 = "FLAG_SUB_095_077_002",
  Flg03 = "FLAG_SUB_095_077_003",
  Flg04 = "FLAG_SUB_095_077_004"
}
local text_file = "s095_077"
local base = "s095_077_"

function S095_077:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local npc_index01 = GetIndex(NPC, "s095_077_001")
    Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-106.04, -12.5135, 69.0476, -102.033, -10.7845, 78.04, default, 0)
    Obj:new(PLAYER, ""):SetPos(-102.51, -12.4, 75.766)
    WaitFrame(1)
    Obj:new(NPC, "s095_077_001"):SetRotationYToObject(PLAYER, "", 0)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s095_077_001", 0)
    Field.ObjectLookAtTheObject(NPC, npc_index01, PLAYER, 1, 0)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 0, 2)
    local tlk = Tlk:new(text_file, 1, true)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    if not Flg.Check(self.Flg03) then
      Flg.Set(self.Flg03)
      tlk:Message(base .. "010")
      local result = tlk:Select(3, base .. "020")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "030")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "040")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "050")
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "060")
      result = tlk:Select(3, base .. "070")
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "080")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "090")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "100")
      end
      tlk:Message(base .. "110")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "120")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
      tlk:Message(base .. "130")
      result = tlk:Select(3, base .. "140")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
        tlk:Message(base .. "150")
      elseif result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
        tlk:Message(base .. "160")
      elseif result == RESULT_TALK02 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
        tlk:Message(base .. "170")
      end
      tlk:Message(base .. "180")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
      tlk:Message(base .. "190")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "200")
      result = tlk:Select(2, base .. "210")
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe02", 10, 10)
        tlk:Message(base .. "220")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "230")
        tlk:EndTalk()
        HideMinimap(false)
        HideGuide(false)
        goto lbl_571
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "290")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "300")
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      tlk:EndTalk(true)
      Qst.Sub:Start(self.ID, 1, false)
      Flg.Set(self.Flg01)
      Qst.Sub:Set(self.ID, self.STEP_005)
      MapChange("d", 503, "start_20", true, FADE_BLACK, FADE_TIME)
    else
      tlk:Message(base .. "240")
      local result = tlk:Select(2, base .. "250")
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe02", 10, 10)
        tlk:Message(base .. "270")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "280")
        tlk:EndTalk()
        HideMinimap(false)
        HideGuide(false)
        goto lbl_571
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
      tlk:Message(base .. "290")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      tlk:Message(base .. "300")
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      tlk:EndTalk(true)
      Qst.Sub:Start(self.ID, 1, false)
      Flg.Set(self.Flg01)
      Qst.Sub:Set(self.ID, self.STEP_005)
      MapChange("d", 503, "start_20", true, FADE_BLACK, FADE_TIME)
    end
  end
  ::lbl_571::
  Cam.Inst:Clear(30)
end

function S095_077:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check(self.Flg04) then
    Field.ObjectLoadMotion(PLAYER, 1, "e201")
    Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e009")
    Field.ObjectLoadMotion(PLAYER, 1, "e009_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    local npc_index01 = GetIndex(NPC, "s095_077_loaderleomon_01")
    Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index01, "br01")
    Field.ObjectLoadMotion(NPC, npc_index01, "ba01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index01, "bd01")
    local npc_pos = Field.ObjectGetPosition(NPC, npc_index01)
    local player_pos = Field.ObjectGetPosition(PLAYER, 1)
    local y_degree = GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
    Field.ObjectLoadExpression(PLAYER, 1, "F16")
    local tlk = Tlk:new(text_file, 1, true)
    Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
    WaitFrame(5)
    HideMinimap(true)
    WaitFrame(5)
    HideGuide(true)
    WaitFrame(5)
    tlk:StartTalkAndCancelDigimonRide()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Cam.Inst:Set(8.864, 0.036, 65.982, 18.6146, 1.5689, 64.3768, default, 0)
    local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
    MovePlayerFrame(rot, 6, 25)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e201", 10, 10)
    WaitFrame(90)
    local slot1 = PlaySE(403003, 100)
    Quake.Start(0, 0.5, 5)
    WaitFrame(15)
    StopSE(slot1, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fn01_01", 10, 10)
    Field.ObjectChangeExpression(PLAYER, 1, "F16", -1, false, 0)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    RegularQuake_Start(0.02, 0, 60, 120)
    Cam.Inst:Set(34.95, 0.55, 60.79, 25.049, 1.86, 61.29, default, 0)
    Obj:new(PLAYER, ""):SetPos(25.4, 0, 64.05)
    Obj:new(PLAYER, ""):SetRotationY(75, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
    MovePlayerFrame(60, 6, 20)
    WaitFrame(40)
    Flg.Set(self.Flg02)
    Field.ObjectLookAtTheObject(NPC, npc_index01, PLAYER, 1, 30, 2)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    Obj:new(NPC, "s095_077_loaderleomon_01"):SetRotationYToObject(PLAYER, "", 15)
    tlk:Message(base .. "310")
    local result = tlk:Select(3, base .. "320")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba01", 10, 10)
      tlk:Message(base .. "330")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba01", 10, 10)
      tlk:Message(base .. "340")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "ba01", 10, 10)
      tlk:Message(base .. "350")
    end
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s095_077_loaderleomon_01", 15)
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 10, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    tlk:Message(base .. "360")
    tlk:EndTalk()
    RegularQuake_Stop()
    EncountFromField_WithNormalEffect(20950770, 10572, false)
  end
end

function S095_077:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg04) then
    local tlk = Tlk:new(text_file, 1, true)
    local npc_index01 = GetIndex(NPC, "s095_077_loaderleomon_01")
    Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index01, "br01")
    Field.ObjectLoadMotion(NPC, npc_index01, "ba01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index01, "bd01")
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
    tlk:Message(base .. "370")
    local result = tlk:Select(3, base .. "380")
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "390")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "400")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "410")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "br01", 10, 10)
    WaitFrame(5)
    Field.ObjectSetRotationY(NPC, npc_index01, 60, 30)
    WaitFrame(30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "bn01", 10, 10)
    tlk:Message(base .. "420")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "430")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "br01", 10, 10)
    WaitFrame(5)
    Field.ObjectSetRotationY(NPC, npc_index01, 220, 30)
    WaitFrame(30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    tlk:Message(base .. "440")
    tlk:EndTalk()
    MapChange("d", 501, "start_30", true, FADE_BLACK, FADE_TIME)
  end
end

function S095_077:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg04) then
    local npc_index01 = GetIndex(NPC, "s095_077_003")
    Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index01, "br01")
    Field.ObjectLoadMotion(NPC, npc_index01, "ba01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index01, "bd01")
    local npc_index02 = GetIndex(NPC, "s095_077_002")
    Field.ObjectLoadMotion(NPC, npc_index02, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index02, "fe04")
    Field.ObjectLoadMotion(NPC, npc_index02, "fe02")
    Field.ObjectLoadMotion(NPC, npc_index02, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index02, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index02, "bd01")
    Cam.Inst:Set(-104.3, -12.46, 71.63, -99.05, -10.38, 79.881, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new(text_file, 1, true)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    tlk:Message(base .. "450")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index02, "fe02", 10, 10)
    tlk:Message(base .. "460")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
    tlk:Message(base .. "470")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
    tlk:Message(base .. "480")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index02, "fq01", 10, 10)
    tlk:Message(base .. "490")
    Flg.Set("FLAG_SUB_095_077_005")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    Cam.Inst:Clear(1)
    WaitFrame(1)
    local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
    SetFollowerCameraOperateRotation(0, rot, 0)
    Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S095_077:Event_050()
  if Qst.Sub:IsCompleted(self.ID) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    if not Flg.Check("FLAG_SUB_095_077_010") then
      tlk:Message(base .. "570")
      tlk:Message(base .. "580")
      Flg.Set("FLAG_SUB_095_077_010")
    else
      tlk:Message(base .. "500")
    end
    if Flg.Check("FLAG_SUB_050_039_002") and Qst.Sub:Check(78, 5) and not Flg.Check("FLAG_SUB_050_039_003") and not Flg.Check("FLAG_SUB_095_078_001") then
      local result = tlk:Select(3, base .. "510")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "520")
        tlk:Message(base .. "530")
        require("S050_039")
        S050_039:Event_015()
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "540")
        tlk:Message(base .. "550")
        if not Flg.Check("FLAG_SUB_095_078_001") then
          require("S095_078")
          S095_078:Event_030()
        end
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "560")
      end
    elseif Flg.Check("FLAG_SUB_050_039_002") and not Flg.Check("FLAG_SUB_050_039_003") then
      local result = tlk:Select(2, base .. "515")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "520")
        tlk:Message(base .. "530")
        require("S050_039")
        S050_039:Event_015()
      else
        if result == RESULT_TALK02 then
          tlk:Message(base .. "560")
        else
        end
      end
    elseif Qst.Sub:Check(78, 5) and not Flg.Check("FLAG_SUB_095_078_001") then
      local result = tlk:Select(2, base .. "511")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "540")
        tlk:Message(base .. "550")
        require("S095_078")
        S095_078:Event_030()
      else
        if result == RESULT_TALK02 then
          tlk:Message(base .. "560")
        else
        end
      end
    else
      local result = tlk:Select(1, base .. "512")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "560")
      end
    end
    tlk:EndTalk()
  end
end

function S095_077:Event_060()
  if Qst.Sub:IsCompleted(self.ID) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "570")
    tlk:Message(base .. "580")
    tlk:EndTalk()
  end
end
