S110_211 = {
  ID = 211,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_255 = 255,
  Flgs = {
    Flg01 = "FLAG_SUB_110_211_013",
    Flg02 = "FLAG_SUB_110_211_014",
    Flg03 = "FLAG_SUB_110_211_015",
    Flg04 = "FLAG_SUB_110_211_016",
    Flg05 = "FLAG_SUB_110_211_017",
    Flg06 = "FLAG_SUB_110_211_018",
    Flg07 = "FLAG_SUB_110_211_019",
    Flg08 = "FLAG_SUB_110_211_020",
    Flg09 = "FLAG_SUB_110_211_021",
    Flg10 = "FLAG_SUB_110_211_022",
    Flg11 = "FLAG_SUB_110_211_023",
    Flg12 = "FLAG_SUB_110_211_024",
    Flg13 = "FLAG_SUB_110_211_026"
  }
}
local text_file = "s110_211"
local base = "s110_211_"
local tlk = Tlk:new(text_file, 1, true)

function S110_211:Event_010()
  local agumon_index = GetIndex(NPC, "agumon_knight_01")
  Field.ObjectLoadMotion(NPC, agumon_index, "e002")
  Field.ObjectLoadMotion(NPC, agumon_index, "e004")
  Field.ObjectLoadMotion(NPC, agumon_index, "e006")
  Field.ObjectLoadMotion(NPC, agumon_index, "e008")
  Field.ObjectLoadMotion(NPC, agumon_index, "fq01")
  Field.ObjectLoadMotion(NPC, agumon_index, "fq02")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
    tlk:Message(base .. "010")
    Talk.CloseLetterBox()
    Qst.Sub:Start(self.ID, 1, false)
    Talk.OpenLetterBox()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
    tlk:Message(base .. "020")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e008", 10, 10)
    tlk:Message(base .. "030")
    local result = tlk:Select(3, base .. "040")
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e002", 10, 10)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "060")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "070")
      tlk:EndTalk()
      local result = Field.StartCardGameWithNPC(1250, true)
      if result == CARD_GAME_WIN then
      else
        if result == CARD_GAME_LOSE then
        else
        end
      end
      tlk:StartTalkAndCancelDigimonRide()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "100")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e008", 10, 10)
      tlk:Message(base .. "110")
      Qst.Sub:Set(self.ID, self.STEP_005)
      tlk:EndTalk()
      goto lbl_579
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
    tlk:Message(base .. "080")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e008", 10, 10)
    tlk:Message(base .. "090")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
    tlk:Message(base .. "095")
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_005)
    Qst.Sub:End(self.ID, self.STEP_255)
    Obj:new(NPC, "RoyalKights_DUKEMON"):SetIcon(ICO_TALK)
    Obj:new(NPC, "RoyalKnights_CRANIAMON"):SetIcon(ICO_TALK)
    tlk:EndTalk()
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
    tlk:Message(base .. "120")
    local result = tlk:Select(3, base .. "040")
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e002", 10, 10)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "050")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "060")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "070")
      tlk:EndTalk()
      local result = Field.StartCardGameWithNPC(1250, true)
      if result == CARD_GAME_WIN then
      else
        if result == CARD_GAME_LOSE then
        else
        end
      end
      tlk:StartTalkAndCancelDigimonRide()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
      tlk:Message(base .. "100")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e008", 10, 10)
      tlk:Message(base .. "110")
      tlk:EndTalk()
      goto lbl_579
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
    tlk:Message(base .. "080")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e008", 10, 10)
    tlk:Message(base .. "090")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
    tlk:Message(base .. "095")
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Obj:new(NPC, "RoyalKights_DUKEMON"):SetIcon(ICO_TALK)
    Obj:new(NPC, "RoyalKnights_CRANIAMON"):SetIcon(ICO_TALK)
    tlk:EndTalk()
  end
  ::lbl_579::
end

function S110_211:Event_030()
  local npc_index = GetIndex(NPC, "agumon_knight_01")
  Field.ObjectLoadMotion(NPC, npc_index, "e002")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e002", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_013") then
      tlk:Message(base .. "140")
    else
      tlk:Message(base .. "145")
    end
    local result = tlk:Select(3, base .. "130")
    if result == RESULT_TALK00 then
      local tlk2 = Tlk:new("S100_087", 1, false)
      tlk2:StartTalk()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk2:Message("s100_087_465")
      tlk:EndTalk()
      tlk2:EndTalk()
      local result = Field.StartCardGameWithNPC(1250, true)
      tlk:StartTalkAndCancelDigimonRide()
      if result == CARD_GAME_WIN then
        tlk:Message(base .. "620")
      else
        if result == CARD_GAME_LOSE then
          tlk:Message(base .. "630")
        else
        end
      end
      tlk:EndTalk()
      goto lbl_160
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "150")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102110, 10276, false)
    else
      if result == RESULT_TALK02 then
        tlk:EndTalk()
      else
      end
    end
  end
  ::lbl_160::
end

function S110_211:Event_035()
  local npc_index = GetIndex(NPC, "agumon_knight_01")
  Field.ObjectLoadMotion(NPC, npc_index, "e004")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_001") then
    if not Flg.Check("FLAG_SUB_110_211_013") then
      Flg.Set("FLAG_SUB_110_211_013")
    end
    tlk:StartTalkAndCancelDigimonRide()
    START_TALK_ACTION_AND_ZOOM("agumon_knight_01", true, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e004", 10, 10)
    tlk:Message(base .. "160")
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("agumon_knight_01", true, true)
    Flg.Clear("FLAG_SUB_110_211_001")
  end
end

function S110_211:Event_040()
  local npc_index = GetIndex(NPC, "RoyalKights_ULFORCEVDRAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_014") then
      tlk:Message(base .. "180")
    else
      tlk:Message(base .. "175")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "190")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102111, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "170")
    tlk:EndTalk()
    goto lbl_116
  end
  ::lbl_116::
end

function S110_211:Event_045()
  local npc_index = GetIndex(NPC, "RoyalKights_ULFORCEVDRAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_002") then
    if not Flg.Check("FLAG_SUB_110_211_014") then
      Flg.Set("FLAG_SUB_110_211_014")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(5.91, 40.324, 10.986, 3, 39.4, 20.51, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "200")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_002")
  end
end

function S110_211:Event_050()
  local npc_index = GetIndex(NPC, "RoyalKights_MAGNAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_015") then
      tlk:Message(base .. "220")
    else
      tlk:Message(base .. "215")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "230")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102112, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "210")
    tlk:EndTalk()
    goto lbl_116
  end
  ::lbl_116::
end

function S110_211:Event_055()
  local npc_index = GetIndex(NPC, "RoyalKights_MAGNAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_003") then
    if not Flg.Check("FLAG_SUB_110_211_015") then
      Flg.Set("FLAG_SUB_110_211_015")
    end
    Cam.Inst:Set(-7.55, 40.424, 12.784, -3.49, 40.39, 21.92, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "240")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_003")
  end
end

function S110_211:Event_060()
  local npc_index = GetIndex(NPC, "RoyalKights_LOADKNIGHTMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_016") then
      tlk:Message(base .. "260")
    else
      tlk:Message(base .. "255")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "270")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102113, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "250")
    tlk:EndTalk()
    goto lbl_108
  end
  ::lbl_108::
end

function S110_211:Event_065()
  local npc_index = GetIndex(NPC, "RoyalKights_LOADKNIGHTMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_004") then
    if not Flg.Check("FLAG_SUB_110_211_016") then
      Flg.Set("FLAG_SUB_110_211_016")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(7.44, 33.59, 27.1, 2.45, 33.92, 35.75, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "280")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_004")
  end
end

function S110_211:Event_070()
  local npc_index = GetIndex(NPC, "RoyalKights_DUKEMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_017") then
      tlk:Message(base .. "300")
    else
      tlk:Message(base .. "295")
    end
    local result = tlk:Select(3, base .. "130")
    if result == RESULT_TALK00 then
      local tlk2 = Tlk:new("s110_099", 1, false)
      tlk2:StartTalk()
      tlk2:Message("s110_099_470")
      tlk2:EndTalk()
      tlk:EndTalk()
      local card_result = Field.StartCardGameWithNPC(1254, true)
      tlk:StartTalkAndCancelDigimonRide()
      if card_result == CARD_GAME_WIN then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq02", 10, 10)
        tlk:Message(base .. "640")
      else
        if card_result == CARD_GAME_LOSE then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
          tlk:Message(base .. "650")
        else
        end
      end
      tlk:EndTalk()
      goto lbl_168
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "310")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102114, 10276, false)
    else
      if result == RESULT_TALK02 then
        tlk:EndTalk()
      else
      end
    end
  else
    require("S110_099")
    S110_099:Event_060()
    goto lbl_168
  end
  ::lbl_168::
end

function S110_211:Event_075()
  local npc_index = GetIndex(NPC, "RoyalKights_DUKEMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_005") then
    if not Flg.Check("FLAG_SUB_110_211_017") then
      Flg.Set("FLAG_SUB_110_211_017")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(10.61, 41.074, 14.914, 4.776, 40.158, 22.98, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "320")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_005")
  end
end

function S110_211:Event_080()
  local npc_index = GetIndex(NPC, "RoyalKights_DYNASMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_018") then
      tlk:Message(base .. "340")
    else
      tlk:Message(base .. "335")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "350")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102115, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "330")
    tlk:EndTalk()
    goto lbl_122
  end
  ::lbl_122::
end

function S110_211:Event_085()
  local npc_index = GetIndex(NPC, "RoyalKights_DYNASMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_006") then
    if not Flg.Check("FLAG_SUB_110_211_018") then
      Flg.Set("FLAG_SUB_110_211_018")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(6.71, 33.89, 24.81, -1.38, 33.74, 30.69, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "360")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_006")
  end
end

function S110_211:Event_090()
  local npc_index = GetIndex(NPC, "RoyalKnights_CRANIAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_019") then
      tlk:Message(base .. "380")
    else
      tlk:Message(base .. "375")
    end
    local result = tlk:Select(3, base .. "130")
    if result == RESULT_TALK00 then
      local tlk2 = Tlk:new("s110_093", 1, false)
      tlk2:StartTalk()
      tlk2:Message("s110_093_560")
      tlk2:EndTalk()
      tlk:EndTalk()
      local card_result = Field.StartCardGameWithNPC(1252, true)
      tlk:StartTalkAndCancelDigimonRide()
      if card_result == CARD_GAME_WIN then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq02", 10, 10)
        tlk:Message(base .. "660")
      else
        if card_result == CARD_GAME_LOSE then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
          tlk:Message(base .. "670")
        else
        end
      end
      tlk:EndTalk()
      goto lbl_175
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "390")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102116, 10276, false)
    else
      if result == RESULT_TALK02 then
        tlk:EndTalk()
      else
      end
    end
  else
    require("S110_093")
    S110_093:Event_070()
  end
  ::lbl_175::
end

function S110_211:Event_095()
  local npc_index = GetIndex(NPC, "RoyalKnights_CRANIAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_007") then
    if not Flg.Check("FLAG_SUB_110_211_019") then
      Flg.Set("FLAG_SUB_110_211_019")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-6.36, 33.39, 21.01, -0.3, 34.68, 28.85, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "400")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_007")
  end
end

function S110_211:Event_100()
  local npc_index = GetIndex(NPC, "RoyalKnights_SLEIPMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_020") then
      tlk:Message(base .. "420")
    else
      tlk:Message(base .. "415")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "430")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102117, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "410")
    tlk:EndTalk()
    goto lbl_122
  end
  ::lbl_122::
end

function S110_211:Event_105()
  local npc_index = GetIndex(NPC, "RoyalKnights_SLEIPMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_008") then
    if not Flg.Check("FLAG_SUB_110_211_020") then
      Flg.Set("FLAG_SUB_110_211_020")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(12.82, 38.22, 19.84, 4.37, 38.91, 25.13, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "440")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_008")
  end
end

function S110_211:Event_110()
  local npc_index = GetIndex(NPC, "RoyalKights_DUFTMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_021") then
      tlk:Message(base .. "460")
    else
      tlk:Message(base .. "455")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "470")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102118, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "450")
    tlk:EndTalk()
    goto lbl_122
  end
  ::lbl_122::
end

function S110_211:Event_115()
  local npc_index = GetIndex(NPC, "RoyalKights_DUFTMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_009") then
    if not Flg.Check("FLAG_SUB_110_211_021") then
      Flg.Set("FLAG_SUB_110_211_021")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(4.41, 33.99, 21.39, -1.71, 33.99, 29.3, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "480")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_009")
  end
end

function S110_211:Event_120()
  local npc_index = GetIndex(NPC, "RoyalKights_EXAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_022") then
      tlk:Message(base .. "500")
    else
      tlk:Message(base .. "495")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "510")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102119, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "490")
    tlk:EndTalk()
    goto lbl_122
  end
  ::lbl_122::
end

function S110_211:Event_125()
  local npc_index = GetIndex(NPC, "RoyalKights_EXAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_010") then
    if not Flg.Check("FLAG_SUB_110_211_022") then
      Flg.Set("FLAG_SUB_110_211_022")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-12.761, 41.174, 24, -9.51, 42.451, 33.37, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "520")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_010")
  end
end

function S110_211:Event_130()
  local npc_index = GetIndex(NPC, "RoyalKnights_GANKOOMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_023") then
      tlk:Message(base .. "540")
    else
      tlk:Message(base .. "535")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "550")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102120, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "530")
    tlk:EndTalk()
    goto lbl_122
  end
  ::lbl_122::
end

function S110_211:Event_135()
  local npc_index = GetIndex(NPC, "RoyalKnights_GANKOOMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_011") then
    if not Flg.Check("FLAG_SUB_110_211_023") then
      Flg.Set("FLAG_SUB_110_211_023")
    end
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "560")
    tlk:EndTalk()
    Flg.Clear("FLAG_SUB_110_211_011")
  end
end

function S110_211:Event_140()
  local npc_index = GetIndex(NPC, "RoyalKnights_JESMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_024") then
      tlk:Message(base .. "580")
    else
      tlk:Message(base .. "575")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "590")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102121, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "570")
    tlk:EndTalk()
    goto lbl_122
  end
  ::lbl_122::
end

function S110_211:Event_145()
  local npc_index = GetIndex(NPC, "RoyalKnights_JESMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Flg.Check("FLAG_SUB_110_211_012") then
    if not Flg.Check("FLAG_SUB_110_211_024") then
      Flg.Set("FLAG_SUB_110_211_024")
    end
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-6.27, 34.194, 26.675, 1.654, 35.19, 32.69, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq02", 10, 10)
    tlk:Message(base .. "600")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "610")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_012")
  end
end

function S110_211:Event_150()
  local npc_index = GetIndex(NPC, "RoyalKights_ALFAMON")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_110_211_026") then
      tlk:Message(base .. "720")
    else
      tlk:Message(base .. "750")
    end
    local result = tlk:Select(2, base .. "131")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "730")
      tlk:EndTalk()
      EncountFromField_PlaySound(21102122, 10276, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  else
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "720")
    tlk:EndTalk()
  end
end

function S110_211:Event_155()
  if Flg.Check("FLAG_SUB_110_211_025") then
    local npc_index = GetIndex(NPC, "RoyalKights_ALFAMON")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    if not Flg.Check("FLAG_SUB_110_211_026") then
      Flg.Set("FLAG_SUB_110_211_026")
    end
    Cam.Inst:Set(0.05, 34.474, 15.996, -0.1978, 32.8, 25.85, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "740")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    Flg.Clear("FLAG_SUB_110_211_025")
  end
end

function S110_211:Event_160()
  if Flg.AllCheck(self.Flgs) and not Flg.Check("FLAG_SUB_110_211_030") then
    local agumon_index = GetIndex(NPC, "agumon_knight_01")
    local gabumon_index = GetIndex(NPC, "gabumon_knight_01")
    Field.ObjectLoadMotion(NPC, agumon_index, "e002")
    Field.ObjectLoadMotion(NPC, agumon_index, "e004")
    Field.ObjectLoadMotion(NPC, agumon_index, "e006")
    Field.ObjectLoadMotion(NPC, agumon_index, "fq01")
    Field.ObjectLoadMotion(NPC, agumon_index, "fe02")
    Field.ObjectLoadMotion(NPC, agumon_index, "fq02")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e002")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e004")
    Field.ObjectLoadMotion(NPC, gabumon_index, "e006")
    Field.ObjectLoadMotion(NPC, gabumon_index, "fq01")
    Field.ObjectLoadMotion(NPC, gabumon_index, "fq02")
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-0.28, 31.04, 24.986, 0.222, 33.22, 34.73, default, 0)
    Obj:new(PLAYER, ""):SetPos(-0.089, 31.542, 29.998, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_110_211_030")
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e004", 10, 10)
    tlk:Message(base .. "760")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e004", 10, 10)
    tlk:Message(base .. "770")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gabumon_index, "e002", 10, 10)
    tlk:Message(base .. "780")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "e002", 10, 10)
    tlk:Message(base .. "790")
    Cam.Inst:Set(-0.02, 34.1, 30.336, -0.088, 32.22, 40.16, default, 30)
    WaitFrame(30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, agumon_index, "fe02", 10, 10)
    tlk:Message(base .. "800")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    WaitFrame(30)
    Cam.Inst:Clear(0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  end
end
