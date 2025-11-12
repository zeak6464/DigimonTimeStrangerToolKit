S100_087 = {
  ID = 87,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_004 = 4,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_100_087_001",
  Flg14 = "FLAG_SUB_100_087_014",
  Flg15 = "FLAG_SUB_100_087_015",
  Flg16 = "FLAG_SUB_100_087_016",
  Flgs = {
    Flg02 = "FLAG_SUB_100_087_002",
    Flg03 = "FLAG_SUB_100_087_003",
    Flg04 = "FLAG_SUB_100_087_004",
    Flg05 = "FLAG_SUB_100_087_005",
    Flg06 = "FLAG_SUB_100_087_006",
    Flg07 = "FLAG_SUB_100_087_007",
    Flg08 = "FLAG_SUB_100_087_008",
    Flg09 = "FLAG_SUB_100_087_009",
    Flg10 = "FLAG_SUB_100_087_010",
    Flg11 = "FLAG_SUB_100_087_011",
    Flg12 = "FLAG_SUB_100_087_012"
  }
}
local text_file = "s100_087"
local base = "s100_087_"

function S100_087:Event_010()
  if Qst.Main:IsCompleted(M220.ID) and Qst.Sub:IsAllCompleted({
    90,
    91,
    178
  }) and not Qst.Sub:IsCompleted(self.ID) then
    local agumon_index = GetIndex(NPC, "s100_087_001")
    local gabumon_index = GetIndex(NPC, "s100_087_002")
    local npc_index_y = GetIndex(NPC, "npc_0002")
    Field.ObjectLoadMotion(NPC, agumon_index, "e002")
    Field.ObjectLoadMotion(NPC, agumon_index, "e004")
    Field.ObjectLoadMotion(NPC, agumon_index, "e006")
    Field.ObjectLoadMotion(NPC, agumon_index, "fq01")
    Field.ObjectLoadMotion(NPC, agumon_index, "fq02")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e002")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e004")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e006")
    Field.ObjectLoadMotion(NPC, gabumon_index, "fq01")
    Field.ObjectLoadMotion(NPC, gabumon_index, "fq02")
    if not Flg.Check(self.Flg01) then
      Cam.Inst:Set(6.995, -1.049, -15.647, 8.599, 1.927, -6.236, default, 0)
      Flg.Set(self.Flg01)
      local tlk = Tlk:new(text_file, 1, true)
      HideMinimap(true)
      HideGuide(true)
      tlk:StartTalkAndCancelDigimonRide()
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e004", 10, 10)
      tlk:Message(base .. "010")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
      tlk:Message(base .. "020")
      Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "030")
      tlk:Message(base .. "040")
      Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      local result = tlk:Select(3, base .. "050")
      WaitFrame(15)
      Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "060")
        tlk:Message(base .. "070")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "080")
        tlk:Message(base .. "090")
        tlk:Message(base .. "100")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "110")
        tlk:Message(base .. "120")
      end
      tlk:Message(base .. "130")
      Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      result = tlk:Select(3, base .. "140")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
        tlk:Message(base .. "150")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "fq01", 10, 10)
        tlk:Message(base .. "160")
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message(base .. "170")
        tlk:Message(base .. "180")
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
        tlk:Message(base .. "190")
      elseif result == RESULT_TALK02 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "fq01", 10, 10)
        tlk:Message(base .. "200")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
        tlk:Message(base .. "210")
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e004", 10, 10)
      tlk:Message(base .. "220")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
      tlk:Message(base .. "230")
      result = tlk:Select(2, base .. "240")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message(base .. "250")
        tlk:Message(base .. "255")
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Qst.Sub:Set(self.ID, self.STEP_003)
        Qst.Sub:Set(self.ID, self.STEP_004)
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message(base .. "260")
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Qst.Sub:Set(self.ID, self.STEP_003)
        tlk:EndTalk()
        HideMinimap(false)
        HideGuide(false)
        t3003_SetCamera(30)
        goto lbl_794
      end
      Flg.Set(self.Flg14)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e002", 10, 10)
      tlk:Message(base .. "270")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
      tlk:Message(base .. "280")
      t3003_SetCamera(30)
      tlk:EndTalk()
      WaitFrame(30)
      Qst.Sub:Start(self.ID, 1, false)
      Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
      HideMinimap(false)
      HideGuide(false)
    elseif Qst.Sub:Check(87, 3, 4) then
      Cam.Inst:Set(6.995, -1.049, -15.647, 8.599, 1.927, -6.236, default, 30)
      local tlk = Tlk:new(text_file, 1, true)
      HideMinimap(true)
      HideGuide(true)
      tlk:StartTalkAndCancelDigimonRide()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e004", 10, 10)
      tlk:Message(base .. "220")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
      tlk:Message(base .. "230")
      local result = tlk:Select(2, base .. "240")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message(base .. "250")
        tlk:Message(base .. "255")
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Qst.Sub:Set(self.ID, self.STEP_004)
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message(base .. "260")
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        tlk:EndTalk()
        HideMinimap(false)
        HideGuide(false)
        t3003_SetCamera(30)
        goto lbl_794
      end
      Flg.Set(self.Flg14)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e002", 10, 10)
      tlk:Message(base .. "270")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
      tlk:Message(base .. "280")
      t3003_SetCamera(30)
      tlk:EndTalk()
      WaitFrame(30)
      Qst.Sub:Start(self.ID, 1, false)
      Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
      HideMinimap(false)
      HideGuide(false)
    end
  end
  ::lbl_794::
end

function S100_087:Event_011()
  if Qst.Sub:Check(87, 3, 5) then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S100_087:Event_012()
  if Qst.Sub:Check(self.ID, self.STEP_004) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    local prifix = "d"
    local number = 210
    local locator = "start_20"
    local time_axis = "A2028_daft_419"
    local time_zone = NOON
    Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
    Flg.Set("FLAG_IS_START_EVENT_BEFORE_MAPCHANGE")
    if time_axis == "A2028_daft_419" then
      Map:OpenPlace(10601, false)
      Map:ClosePlace(103, false)
      Map:CloseArea(3, true)
      Map:ClosePlace(10402, false)
      Map:CloseArea(106, false)
      Map:OpenPlace(10607, true)
      Map:OpenArea(106, true)
      Flg.Set("FLAG_IS_USED_TIMEJUMP_TO_AFTER")
      Flg.Clear("FLAG_IS_USED_TIMEJUMP_TO_BEFORE")
    end
    if time_axis == "A2020_dbef_119" then
      Digitter.Send(6020010)
    elseif time_axis == "A2020_dbef_199" then
      Digitter.Send(6030010)
    elseif time_axis == "A2028_daft_419" then
      if prifix == "t" then
        Digitter.Send(6040010)
      else
        Digitter.Send(6050010)
      end
    elseif time_axis == "P2028_daft_440" then
      Digitter.Send(6010010)
    end
    PlaySE(200006, 100)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    Common.RequestMapChangeWithTimeTravel(prifix, number, locator, time_axis, time_zone)
  end
end

function S100_087:Event_013()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check(self.Flg14, self.Flg15) then
    local agumon_index = GetIndex(NPC, "agumon_knight_01")
    local gabumon_index = GetIndex(NPC, "gabumon_knight_01")
    Field.ObjectLoadMotion(NPC, agumon_index, "e002")
    Field.ObjectLoadMotion(NPC, agumon_index, "e004")
    Field.ObjectLoadMotion(NPC, agumon_index, "e006")
    Field.ObjectLoadMotion(NPC, agumon_index, "fq01")
    Field.ObjectLoadMotion(NPC, agumon_index, "fq02")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e002")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e004")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e006")
    Field.ObjectLoadMotion(NPC, gabumon_index, "fq01")
    Field.ObjectLoadMotion(NPC, gabumon_index, "fq02")
    Cam.Inst:Set(-0.28, 31.04, 24.986, 0.222, 33.22, 34.73, default, 0)
    local tlk = Tlk:new(text_file, 1, true)
    HideMinimap(true)
    WaitFrame(1)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    Flg.Clear("FLAG_IS_MAPCHANGE_USING_DOOR")
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set(self.Flg15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e002", 10, 10)
    tlk:Message(base .. "290")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
    tlk:Message(base .. "300")
    local result = tlk:Select(3, base .. "310")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
      tlk:Message(base .. "320")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "fq01", 10, 10)
      tlk:Message(base .. "330")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "340")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "fq02", 10, 10)
      tlk:Message(base .. "350")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "360")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "fq01", 10, 10)
      tlk:Message(base .. "370")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "fq01", 10, 10)
      tlk:Message(base .. "380")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
      tlk:Message(base .. "390")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e002", 10, 10)
      tlk:Message(base .. "400")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fq01", 10, 10)
    tlk:Message(base .. "410")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "fq01", 10, 10)
    tlk:Message(base .. "420")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e002", 10, 10)
    tlk:Message(base .. "425")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
    tlk:Message(base .. "430")
    INFO_GET_ITEM(3, 5)
    Cam.Inst:Clear(30)
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_005)
  end
end

function S100_087:Event_015()
  if Flg.Check(self.Flg14) and Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    local npc_index_y = GetIndex(NPC, "npc_0002")
    Cam.Inst:Set(6.995, -1.049, -15.647, 8.599, 1.927, -6.236, default, 30)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "630")
    Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk()
    t3003_SetCamera(30)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S100_087:Event_017()
  if not Qst.Sub:IsCompleted(self.ID) then
    Cam.Inst:Set(6.995, -1.049, -15.647, 8.599, 1.927, -6.236, default, 30)
    local tlk = Tlk:new(text_file, 1, true)
    local npc_index_y = GetIndex(NPC, "npc_0002")
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "510")
    tlk:Message(base .. "520")
    tlk:Message(base .. "530")
    Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(3, base .. "540")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "550")
      tlk:Message(base .. "560")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "570")
      tlk:Message(base .. "580")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "590")
      tlk:Message(base .. "600")
      tlk:Message(base .. "610")
    end
    Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    t3003_SetCamera(30)
    tlk:EndTalk()
  end
end

function S100_087:Event_020()
  if Flg.AllCheck(self.Flgs) then
    Digitter.Send(2087020)
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S100_087:Event_030()
  require("S100_087")
  local agumon_index = GetIndex(NPC, "agumon_knight_01")
  Field.ObjectLoadMotion(NPC, agumon_index, "fe02")
  Field.ObjectLoadMotion(NPC, agumon_index, "e002")
  Field.ObjectLoadMotion(NPC, agumon_index, "e004")
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  if S100_087:IsIncreaseRoyalKnights() == true then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
    tlk:Message(base .. "440")
  end
  tlk:Message(base .. "450")
  local result = tlk:Select(2, base .. "460")
  WaitFrame(15)
  if result == RESULT_TALK00 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fe02", 10, 10)
    tlk:Message(base .. "465")
    tlk:EndTalk()
  elseif result == RESULT_TALK01 then
    tlk:EndTalk()
    goto lbl_123
  end
  local result = Field.StartCardGameWithNPC(1250, true)
  local tlk2 = Tlk:new("S110_211", 1, true)
  tlk2:StartTalk()
  if result == CARD_GAME_WIN then
    tlk2:Message("s110_211_620")
  elseif result == CARD_GAME_LOSE then
    tlk2:Message("s110_211_630")
  else
    tlk2:Message("s110_211_630")
  end
  tlk2:EndTalk()
  ::lbl_123::
end

function S100_087:Event_040()
  local gabumon_index = GetIndex(NPC, "gabumon_knight_01")
  Field.ObjectLoadMotion(NPC, gabumon_index, "e002")
  Field.ObjectLoadMotion(NPC, gabumon_index, "fq01")
  Field.ObjectLoadMotion(NPC, gabumon_index, "e004")
  require("S100_087")
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalkAndCancelDigimonRide()
  if S100_087:IsIncreaseRoyalKnights() == true then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e004", 10, 10)
    tlk:Message(base .. "470")
  end
  tlk:Message(base .. "480")
  local result = tlk:Select(2, base .. "490")
  WaitFrame(15)
  if result == RESULT_TALK00 then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e004", 10, 10)
    tlk:Message(base .. "500")
    tlk:EndTalk()
  elseif result == RESULT_TALK01 then
    tlk:EndTalk()
    goto lbl_123
  end
  local result = Field.StartCardGameWithNPC(1251, true)
  local tlk2 = Tlk:new("S110_211", 1, true)
  tlk2:StartTalk()
  if result == CARD_GAME_WIN then
    tlk2:Message("s110_211_700")
  elseif result == CARD_GAME_LOSE then
    tlk2:Message("s110_211_710")
  else
    tlk2:Message("s110_211_710")
  end
  tlk2:EndTalk()
  ::lbl_123::
end

function S100_087:IsIncreaseRoyalKnights()
  local save_num = Work.Get(SubQuestRoyalKnightsNum)
  print(self:CheckCurrentRoyalKnightsNum())
  print(save_num)
  if save_num < self:CheckCurrentRoyalKnightsNum() then
    Work.Set(SubQuestRoyalKnightsNum, self:CheckCurrentRoyalKnightsNum())
    print(Work.Get(SubQuestRoyalKnightsNum))
    return true
  end
  return false
end

function S100_087:CheckCurrentRoyalKnightsNum()
  local num = 0
  for _, value in pairs(self.Flgs) do
    if Flg.Check(value) then
      num = num + 1
    end
  end
  return num
end

function S100_087:AddReturnRoyalKnightsNum()
  local current_num = Work.Get(SubQuestRoyalKnightsNum)
  local save_num = current_num + 1
end
