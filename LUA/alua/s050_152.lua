S050_152 = {
  ID = 152,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_255 = 255,
  lux = 0,
  amicitia = 1,
  courage = 2,
  Flg001 = "FLAG_SUB_050_152_001",
  Flg002 = "FLAG_SUB_050_152_002",
  Flg003 = "FLAG_SUB_050_152_003",
  Flg004 = "FLAG_SUB_050_152_004",
  Flg005 = "FLAG_SUB_050_152_005",
  Flg006 = "FLAG_SUB_050_152_006",
  Flg007 = "FLAG_SUB_050_152_007",
  Flg008 = "FLAG_SUB_050_152_008",
  Flg009 = "FLAG_SUB_050_152_009",
  Flg010 = "FLAG_SUB_050_152_010",
  Flg011 = "FLAG_SUB_050_152_011",
  Flg012 = "FLAG_SUB_050_152_012",
  Flg015 = "FLAG_SUB_050_152_015",
  Flg016 = "FLAG_SUB_050_152_016",
  Flg017 = "FLAG_SUB_050_152_017",
  Flg018 = "FLAG_SUB_050_152_018",
  Flg019 = "FLAG_SUB_050_152_019"
}
local base = "s050_152_"
local text_file = "s050_152"
local tlk = Tlk:new(text_file)

function S050_152:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check(self.Flg011) then
    local player = {
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01"),
      e002 = Motion.Object:new(PLAYER, "", "e002"),
      e004 = Motion.Object:new(PLAYER, "", "e004"),
      e008 = Motion.Object:new(PLAYER, "", "e008"),
      e010 = Motion.Object:new(PLAYER, "", "e010")
    }
    local pegasmon = {
      bn01 = Motion.Object:new(NPC, "ride_pegasmon", "bn01"),
      fq01 = Motion.Object:new(NPC, "ride_pegasmon", "fq01"),
      fq02 = Motion.Object:new(NPC, "ride_pegasmon", "fq02"),
      fe02 = Motion.Object:new(NPC, "ride_pegasmon", "fe02")
    }
    HideMinimap(true)
    HideGuide(true)
    Flg.Set(self.Flg011)
    Talk.OpenLetterBox()
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_CLOSE, false, 30, AUTO_CANCEL_NONE, 15)
    pegasmon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "010")
    pegasmon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "020")
    local result = tlk:Select(3, base .. "030")
    if result == RESULT_TALK00 then
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F03", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      pegasmon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK01 then
      pegasmon.fe02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "050")
    else
      pegasmon.fq01:PlayWithStartMoveMotion(10, 10)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "060")
    end
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "070")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_CLOSE, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "080")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "090")
    result = tlk:Select(3, base .. "100")
    if result == RESULT_TALK00 then
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      pegasmon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "110")
    elseif result == RESULT_TALK01 then
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      pegasmon.fq01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "120")
    else
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_CLOSE, false, 30, AUTO_CANCEL_NONE, 15)
      pegasmon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "130")
    end
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "140")
    if Item.GetNum(904) >= 1 then
      Qst.Sub:Set(self.ID, self.STEP_006)
    end
    local num = Item.GetNum(904) >= 1 and 2 or 1
    local id = Item.GetNum(904) >= 1 and "150" or "151"
    result = tlk:Select(num, base .. id)
    if result == RESULT_TALK00 then
      if num == 1 then
        pegasmon.fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "170")
        tlk:MessageClose()
        Talk.CloseLetterBox()
        Qst.Sub:Start(self.ID, 1, false)
        Qst.Sub:Set(self.ID, self.STEP_005)
        tlk:EndTalk()
      else
        Qst.Sub:Set(self.ID, self.STEP_005)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        pegasmon.fe02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "160")
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        tlk:EndTalk(true)
        Field.ClearNpcTalkZoomCamera(0, 1)
        require("S050_152")
        S050_152:Event_012()
        S050_152:Event_019()
        Talk.CloseLetterBox()
        Qst.Sub:End(self.ID, self.STEP_255)
        Cam.Inst:Clear(30)
      end
    else
      pegasmon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "170")
      tlk:MessageClose()
      Talk.CloseLetterBox()
      Qst.Sub:Start(self.ID, 1, false)
      Qst.Sub:Set(self.ID, self.STEP_005)
      tlk:EndTalk()
    end
    HideMinimap(false)
    HideGuide(false)
  end
end

function S050_152:Event_011()
  local pegasmon = {
    bn01 = Motion.Object:new(NPC, "ride_pegasmon", "bn01"),
    fq01 = Motion.Object:new(NPC, "ride_pegasmon", "fq01"),
    fq02 = Motion.Object:new(NPC, "ride_pegasmon", "fq02"),
    fe02 = Motion.Object:new(NPC, "ride_pegasmon", "fe02")
  }
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flg011) then
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    Talk.OpenLetterBox()
    tlk:Message(base .. "140")
    local num = 1 <= Item.GetNum(904) and 2 or 1
    local id = 1 <= Item.GetNum(904) and "150" or "151"
    result = tlk:Select(num, base .. id)
    if result == RESULT_TALK00 then
      if num == 1 then
        pegasmon.fq02:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "170")
        Talk.CloseLetterBox()
        tlk:EndTalk()
      else
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message(base .. "160")
        tlk:MessageClose()
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        tlk:EndTalk(true)
        Field.ClearNpcTalkZoomCamera(0, 1)
        self:Event_012()
        self:Event_019()
        Talk.CloseLetterBox()
        Qst.Sub:End(self.ID, self.STEP_255)
        Cam.Inst:Clear(30)
      end
    else
      pegasmon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "170")
      Talk.CloseLetterBox()
      tlk:EndTalk()
    end
    HideMinimap(false)
    HideGuide(false)
  end
end

function S050_152:Event_012()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    local hawkmon = {
      fq01 = Motion.Object:new(NPC, "s050_152_013", "fq01"),
      fe02 = Motion.Object:new(NPC, "s050_152_013", "fe02"),
      bn01 = Motion.Object:new(NPC, "s050_152_013", "bn01")
    }
    local shurimon = {
      ba01 = Motion.Object:new(NPC, "s050_152_002", "ba01"),
      bn01 = Motion.Object:new(NPC, "s050_152_002", "bn01")
    }
    local p_bn01 = Motion.Object:new(NPC, "s050_152_pegas_01", "bn01")
    local p_fq01 = Motion.Object:new(NPC, "s050_152_pegas_01", "fq01")
    local p_fe02 = Motion.Object:new(NPC, "s050_152_pegas_01", "fe02")
    Flg.Set(self.Flg001)
    Obj:new(PLAYER, ""):SetPos(20.648, 0, -10.653)
    Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s050_152_013", 0)
    SetFollowerCameraOperateRotation(0, 20)
    Cam.Inst:Set(22.26, 1.0066, -17.31, 18.3256, 1.686, -8.1415, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "180")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_pegas_01"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    p_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "190")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_pegas_01"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_013"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    hawkmon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "200")
    tlk:MessageClose()
    Flg.Set(self.Flg006)
    PlaySE(404005, 100)
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    shurimon.ba01:PlayWithStartMoveMotion(10, 10)
    while shurimon.ba01:IsPlayingMotion() do
      WaitFrame(Util.SecondFromFrame(1))
    end
    Flg.Set("FLAG_SUB_050_152_021")
    p_fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "210")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_pegas_01"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    p_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "220")
    tlk:MessageClose()
    tlk:EndTalk(true)
    Warp_Pegasu()
  end
end

function S050_152:Event_013()
  tlk:StartTalkAndCancelDigimonRide()
  Talk.OpenLetterBox()
  tlk:Message(base .. "280")
  local bflg = BitFlag:new()
  if 1 <= Item.GetNum(908) then
    bflg:Set(self.lux)
  end
  if 1 <= Item.GetNum(902) then
    bflg:Set(self.amicitia)
  end
  if 1 <= Item.GetNum(901) then
    bflg:Set(self.courage)
  end
  local s_num = not ((not bflg:Check(self.lux) or Flg.Check(self.Flg002)) and (not bflg:Check(self.amicitia) or Flg.Check(self.Flg003)) and (not bflg:Check(self.courage) or Flg.Check(self.Flg005))) and 2 or 1
  local s_id = not ((not bflg:Check(self.lux) or Flg.Check(self.Flg002)) and (not bflg:Check(self.amicitia) or Flg.Check(self.Flg003)) and (not bflg:Check(self.courage) or Flg.Check(self.Flg005))) and "290" or "291"
  local result = tlk:Select(s_num, base .. s_id)
  if result == RESULT_TALK00 then
    if s_num == 1 then
      tlk:Message(base .. "310")
      Talk.CloseLetterBox()
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("ride_pegasmon", true, true)
      goto lbl_319
    else
      tlk:Message(base .. "300")
    end
  else
    tlk:Message(base .. "310")
    Talk.CloseLetterBox()
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("ride_pegasmon", true, true)
    goto lbl_319
  end
  do
    local num, text_id = self:TextIDGenerate(bflg)
    result = tlk:Select(num, base .. text_id)
    tlk:Message(base .. "160")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:MessageClose()
    END_TALK_ACTION_AND_ZOOM("ride_pegasmon", true, true)
    tlk:EndTalk(true)
    if num == 1 then
      if bflg:Check(self.lux) and not Flg.Check(self.Flg002) then
        self:Event_014()
      end
      if bflg:Check(self.amicitia) and not Flg.Check(self.Flg003) then
        self:Event_015()
      end
      if bflg:Check(self.courage) and not Flg.Check(self.Flg005) then
        self:Event_016()
      end
    elseif num == 2 then
      if result == RESULT_TALK00 then
        if not Flg.Check(self.Flg002) then
          self:Event_014()
        elseif Flg.Check(self.Flg002) then
          self:Event_015()
        end
      elseif result == RESULT_TALK01 then
        if not Flg.Check(self.Flg005) then
          self:Event_016()
        elseif Flg.Check(self.Flg005) then
          self:Event_015()
        end
      end
    elseif num == 3 then
      if result == RESULT_TALK00 then
        self:Event_014()
      end
      if result == RESULT_TALK01 then
        self:Event_015()
      end
      if result == RESULT_TALK02 then
        self:Event_016()
      end
    end
    self:Event_017()
    Talk.CloseLetterBox()
    Cam.Inst:Clear(30)
  end
  ::lbl_319::
end

function S050_152:Event_014()
  local tailmon = {
    fe02 = Motion.Object:new(NPC, "s050_152_014", "fe02"),
    bn01 = Motion.Object:new(NPC, "s050_152_014", "bn01")
  }
  local nefeltymon = {
    ba01 = Motion.Object:new(NPC, "s050_152_003", "ba01"),
    fe02 = Motion.Object:new(NPC, "s050_152_003", "fe02"),
    fq01 = Motion.Object:new(NPC, "s050_152_003", "fq01"),
    bn01 = Motion.Object:new(NPC, "s050_152_003", "bn01")
  }
  local p_bn01 = Motion.Object:new(NPC, "s050_152_pegas_03", "bn01")
  local p_fq01 = Motion.Object:new(NPC, "s050_152_pegas_03", "fq01")
  local p_fe02 = Motion.Object:new(NPC, "s050_152_pegas_03", "fe02")
  Flg.Set(self.Flg002)
  Obj:new(PLAYER, ""):SetPos(9.031, 0, -7.861)
  Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s050_152_014", 0)
  Cam.Inst:Set(9.31, -0.0434, -2, 11.423, 1.944, -11.59, default, 0)
  FieldObjectSync(NPC, true)
  tlk:StartTalkAndCancelDigimonRide()
  WaitFrame(30)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  tlk:Message(base .. "320")
  Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_pegas_03"), "F03", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  p_fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "330")
  Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_014"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  tailmon.fe02:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "340")
  tlk:MessageClose()
  Flg.Set(self.Flg007)
  PlaySE(404005, 100)
  Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
  FieldObjectSync(NPC, true)
  WaitFrame(30)
  FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  Flg.Set("FLAG_SUB_050_152_023")
  nefeltymon.fq01:PlayWithStartMoveMotion(10, 10)
  while nefeltymon.ba01:IsPlayingMotion() do
    WaitFrame(Util.SecondFromFrame(1))
  end
  p_fe02:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "410")
  tlk:MessageClose()
  tlk:EndTalk(true)
  Warp_Pegasu()
end

function S050_152:Event_015()
  local vmon = {
    fq01 = Motion.Object:new(NPC, "s050_152_012", "fq01"),
    fq02 = Motion.Object:new(NPC, "s050_152_012", "fq02"),
    bn01 = Motion.Object:new(NPC, "s050_152_012", "bn01")
  }
  local ridramon = {
    ba01 = Motion.Object:new(NPC, "s050_152_004", "ba01"),
    fe04 = Motion.Object:new(NPC, "s050_152_004", "fe04"),
    bn01 = Motion.Object:new(NPC, "s050_152_004", "bn01")
  }
  local p_bn01 = Motion.Object:new(NPC, "s050_152_pegas_02", "bn01")
  local p_fq01 = Motion.Object:new(NPC, "s050_152_pegas_02", "fq01")
  local p_fe02 = Motion.Object:new(NPC, "s050_152_pegas_02", "fe02")
  Flg.Set(self.Flg003)
  Obj:new(PLAYER, ""):SetPos(38.438, 0, 3.62)
  Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s050_152_012", 0)
  SetFollowerCameraOperateRotation(0, 100)
  Cam.Inst:Set(43.56, 0.293, 1.79, 33.77, 1.574, 3.382, default, 0)
  tlk:StartTalkAndCancelDigimonRide()
  FieldObjectSync(NPC, true)
  WaitFrame(30)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  vmon.fq02:PlayWithStartMoveMotion(10, 10)
  Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_012"), "F03", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  tlk:Message(base .. "350")
  p_fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "360")
  Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_012"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  vmon.fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "370")
  tlk:MessageClose()
  Flg.Set(self.Flg008)
  PlaySE(404005, 100)
  Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
  FieldObjectSync(NPC, true)
  WaitFrame(30)
  FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  ridramon.fe04:PlayWithStartMoveMotion(10, 10)
  while ridramon.ba01:IsPlayingMotion() do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Flg.Set("FLAG_SUB_050_152_022")
  p_fe02:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "410")
  tlk:MessageClose()
  tlk:EndTalk(true)
  Warp_Pegasu()
end

function S050_152:Event_017()
  local player = {
    fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01"),
    e002 = Motion.Object:new(PLAYER, "", "e002"),
    e004 = Motion.Object:new(PLAYER, "", "e004"),
    e008 = Motion.Object:new(PLAYER, "", "e008"),
    e010 = Motion.Object:new(PLAYER, "", "e010")
  }
  local pegasmon = {
    bn01 = Motion.Object:new(NPC, "ride_pegasmon", "bn01"),
    fq01 = Motion.Object:new(NPC, "ride_pegasmon", "fq01"),
    fq02 = Motion.Object:new(NPC, "ride_pegasmon", "fq02"),
    fe02 = Motion.Object:new(NPC, "ride_pegasmon", "fe02")
  }
  tlk:StartTalkAndCancelDigimonRide()
  if self:CheckGiveDigimental() then
    tlk:Message(base .. "430")
    tlk:MessageClose()
    INFO_GET_ITEM(1021, 1)
    Flg.Set(self.Flg012)
  else
    pegasmon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "420")
  end
  tlk:EndTalk()
end

function S050_152:Event_016()
  local gilmon = {
    fq01 = Motion.Object:new(NPC, "s050_152_011", "fq01"),
    fe02 = Motion.Object:new(NPC, "s050_152_011", "fe02"),
    bn01 = Motion.Object:new(NPC, "s050_152_011", "bn01")
  }
  local fraydramon = {
    ba01 = Motion.Object:new(NPC, "s050_152_005", "ba01"),
    fe02 = Motion.Object:new(NPC, "s050_152_005", "fe02"),
    bn01 = Motion.Object:new(NPC, "s050_152_005", "bn01")
  }
  local p_bn01 = Motion.Object:new(NPC, "s050_152_pegas_02", "bn01")
  local p_fq01 = Motion.Object:new(NPC, "s050_152_pegas_02", "fq01")
  local p_fe02 = Motion.Object:new(NPC, "s050_152_pegas_02", "fe02")
  Flg.Set(self.Flg005)
  Obj:new(PLAYER, ""):SetPos(37.042, 0, 17.705)
  Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s050_152_011", 0)
  SetFollowerCameraOperateRotation(0, 90)
  Cam.Inst:Set(42.1, -0.35, 19.74, 34.16, 2.24, 14.25, default, 0)
  tlk:StartTalkAndCancelDigimonRide()
  FieldObjectSync(NPC, true)
  WaitFrame(30)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  gilmon.fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "380")
  Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_pegas_02"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  p_fq01:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "390")
  Field.ObjectChangeExpression(NPC, GetIndex(NPC, "s050_152_011"), "F03", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  gilmon.fe02:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "400")
  tlk:MessageClose()
  Flg.Set(self.Flg010)
  PlaySE(404005, 100)
  Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
  FieldObjectSync(NPC, false)
  WaitFrame(30)
  FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  fraydramon.fe02:PlayWithStartMoveMotion(10, 10)
  while fraydramon.ba01:IsPlayingMotion() do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Flg.Set("FLAG_SUB_050_152_024")
  p_fe02:PlayWithStartMoveMotion(10, 10)
  tlk:Message(base .. "410")
  tlk:MessageClose()
  tlk:EndTalk(true)
  Warp_Pegasu()
end

function S050_152:Event_019()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    local pegasmon = {
      bn01 = Motion.Object:new(NPC, "ride_pegasmon", "bn01"),
      fq01 = Motion.Object:new(NPC, "ride_pegasmon", "fq01"),
      fq02 = Motion.Object:new(NPC, "ride_pegasmon", "fq02"),
      fe02 = Motion.Object:new(NPC, "ride_pegasmon", "fe02")
    }
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    pegasmon.fe02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "230")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_CLOSE, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "240")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    pegasmon.fq02:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "250")
    local result = tlk:Select(3, base .. "700")
    if result == RESULT_TALK00 then
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "710")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "720")
    else
      tlk:Message(base .. "730")
    end
    tlk:Message(base .. "260")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    pegasmon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "270")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "ride_pegasmon"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk()
  end
end

function S050_152:Event_020()
  if not Flg.Check(self.Flg015) then
    local player = {
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01"),
      e002 = Motion.Object:new(PLAYER, "", "e002")
    }
    local shurimon = {
      bn01 = Motion.Object:new(NPC, "s050_152_002", "bn01"),
      ba01 = Motion.Object:new(NPC, "s050_152_002", "ba01"),
      fq01 = Motion.Object:new(NPC, "s050_152_002", "fq01"),
      fq02 = Motion.Object:new(NPC, "s050_152_002", "fq02")
    }
    tlk:StartTalkAndCancelDigimonRide()
    shurimon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "440")
    local result = tlk:Select(2, base .. "450")
    if result == RESULT_TALK00 then
      shurimon.ba01:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "460")
      Common.AddBankDigimon(142, 20, 0, 0, 20)
      Flg.Set(self.Flg015)
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      INFO_WINDOW(7050)
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    else
      shurimon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "470")
    end
    tlk:EndTalk()
  end
end

function S050_152:Event_030()
  if not Flg.Check(self.Flg016) then
    local player = {
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01"),
      e002 = Motion.Object:new(PLAYER, "", "e002")
    }
    local nefeltymon = {
      bn01 = Motion.Object:new(NPC, "s050_152_003", "bn01"),
      ba02 = Motion.Object:new(NPC, "s050_152_003", "ba02"),
      fq01 = Motion.Object:new(NPC, "s050_152_003", "fq01"),
      fq02 = Motion.Object:new(NPC, "s050_152_003", "fq02")
    }
    tlk:StartTalkAndCancelDigimonRide()
    nefeltymon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "480")
    local result = tlk:Select(2, base .. "490")
    if result == RESULT_TALK00 then
      nefeltymon.ba02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "500")
      Common.AddBankDigimon(147, 20, 0, 0, 20)
      Flg.Set(self.Flg016)
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      INFO_WINDOW(7051)
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    else
      nefeltymon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "510")
    end
    tlk:EndTalk()
  end
end

function S050_152:Event_040()
  if not Flg.Check(self.Flg017) then
    local player = {
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01"),
      e002 = Motion.Object:new(PLAYER, "", "e002")
    }
    local ridramon = {
      bn01 = Motion.Object:new(NPC, "s050_152_004", "bn01"),
      ba02 = Motion.Object:new(NPC, "s050_152_004", "ba02"),
      fq01 = Motion.Object:new(NPC, "s050_152_004", "fq01"),
      fq02 = Motion.Object:new(NPC, "s050_152_004", "fq02")
    }
    tlk:StartTalkAndCancelDigimonRide()
    ridramon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "520")
    local result = tlk:Select(2, base .. "530")
    if result == RESULT_TALK00 then
      player.e002:PlayWithStartMoveMotion(10, 10)
      ridramon.ba02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "540")
      Common.AddBankDigimon(139, 20, 0, 0, 20)
      Flg.Set(self.Flg017)
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      player.fn01_01:PlayWithStartMoveMotion(10, 10)
      INFO_WINDOW(7052)
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    else
      player.e002:PlayWithStartMoveMotion(10, 10)
      ridramon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "550")
    end
    tlk:EndTalk()
  end
end

function S050_152:Event_050()
  if not Flg.Check(self.Flg018) then
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local t_bn01 = Motion.Object:new(NPC, "s050_152_005", "bn01")
    local t_ba02 = Motion.Object:new(NPC, "s050_152_005", "ba02")
    local t_fq01 = Motion.Object:new(NPC, "s050_152_005", "fq01")
    local t_fq02 = Motion.Object:new(NPC, "s050_152_005", "fq02")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    t_fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "560")
    local result = tlk:Select(2, base .. "570")
    if result == RESULT_TALK00 then
      p_e002:PlayWithStartMoveMotion(10, 10)
      t_ba02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "580")
      Common.AddBankDigimon(751, 20, 0, 0, 20)
      Flg.Set(self.Flg018)
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      p_fn01_01:PlayWithStartMoveMotion(10, 10)
      INFO_WINDOW(7053)
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    else
      p_e002:PlayWithStartMoveMotion(10, 10)
      t_fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "590")
    end
    tlk:EndTalk()
  end
end

function S050_152:Event_060()
  if not Flg.Check(self.Flg019) then
    local player = {
      fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01"),
      e002 = Motion.Object:new(PLAYER, "", "e002")
    }
    local flaydramon = {
      bn01 = Motion.Object:new(NPC, "s050_152_006", "bn01"),
      ba02 = Motion.Object:new(NPC, "s050_152_006", "ba02"),
      fq01 = Motion.Object:new(NPC, "s050_152_006", "fq01"),
      fq02 = Motion.Object:new(NPC, "s050_152_006", "fq02")
    }
    tlk:StartTalkAndCancelDigimonRide()
    flaydramon.fq01:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "560")
    local result = tlk:Select(2, base .. "570")
    if result == RESULT_TALK00 then
      player.e002:PlayWithStartMoveMotion(10, 10)
      flaydramon.ba02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "580")
      Common.AddBankDigimon(716, 20, 0, 0, 20)
      Flg.Set(self.Flg019)
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      player.fn01_01:PlayWithStartMoveMotion(10, 10)
      INFO_WINDOW(7054)
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    else
      player.e002:PlayWithStartMoveMotion(10, 10)
      flaydramon.fq02:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "590")
    end
    tlk:EndTalk()
  end
end

function Warp_Pegasu()
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Cam.Inst:Clear(0)
  SetFollowerCameraOperateRotation(0, 300)
  END_TALK_ACTION_AND_ZOOM("ride_pegasmon", true, true)
  Cam.Inst:Set(-98.51, -0.1443, -15.06, -91.95, -0.304, -7.5, default, 0)
  Obj:new(PLAYER, ""):SetPos(-93.398, -1.469, -9.956)
  Obj:new(PLAYER, ""):SetRotationY(-81.715, 0)
  FieldObjectSync(NPC, false)
  WaitFrame(60)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
end

function S050_152:TextIDGenerate(flg)
  local flg_num = flg:CheckNum()
  local id = 0
  flg_num = Flg.Check(self.Flg002) and flg_num - 1 or flg_num
  flg_num = Flg.Check(self.Flg003) and flg_num - 1 or flg_num
  flg_num = Flg.Check(self.Flg005) and flg_num - 1 or flg_num
  id = not Flg.Check(self.Flg002) and flg:Check(self.lux) and id + 1 or id
  id = not Flg.Check(self.Flg003) and flg:Check(self.amicitia) and id + 10 or id
  id = not Flg.Check(self.Flg005) and flg:Check(self.courage) and id + 100 or id
  return flg_num, string.format("%d%03d", flg_num, id)
end

function S050_152:CheckGiveDigimental()
  local give_flg = {
    self.Flg002,
    self.Flg003,
    self.Flg005
  }
  local cnt = 0
  for _, flg in pairs(give_flg) do
    cnt = Flg.Check(flg) and cnt + 1 or cnt
  end
  if 3 <= cnt then
    return true
  end
  return false
end
