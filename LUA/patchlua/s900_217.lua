S900_217 = {
  ID = 217,
  STEP_001 = 1,
  STEP_255 = 255
}
local text_file = "s900_217"
local base = text_file .. "_"
local tlk = Tlk:new(text_file, 1, true)

function S900_217:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_255) then
    local minerva_index = GetIndex(NPC, "s900_217_minerva")
    Field.ObjectLoadMotion(NPC, minerva_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, minerva_index, "e002")
    Field.ObjectLoadMotion(NPC, minerva_index, "e003")
    Field.ObjectLoadMotion(NPC, minerva_index, "e004")
    Field.ObjectLoadMotion(NPC, minerva_index, "e008")
    Field.ObjectLoadMotion(NPC, minerva_index, "e012")
    Field.ObjectLoadMotion(NPC, minerva_index, "e013")
    Field.ObjectLoadMotion(NPC, minerva_index, "e018")
    Field.ObjectLoadMotion(NPC, minerva_index, "e513")
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
    HideMinimap(true)
    HideGuide(true)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(94.03, 0.55, -7.56, 84.62, 1.527, -10.8, default, 0)
    Obj:new(PLAYER, ""):SetPos(86.89, 0, -9.232, true)
    Obj:new(PLAYER, ""):SetRotationY(90, 0)
    ObjectTurnToPlayer(NPC, "s900_217_minerva")
    WaitFrame(15)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, minerva_index, "e008", 15, true)
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, minerva_index, "e012", 10, 10)
      tlk:Message(base .. "030")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, minerva_index, "e002", 10, 10)
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, minerva_index, "e002", 10, 10)
      tlk:Message(base .. "050")
    end
    Field.ObjectPlayMotion(NPC, minerva_index, "e013", 15, true)
    tlk:Message(base .. "060")
    Field.ObjectPlayMotion(NPC, minerva_index, "e012", 15, true)
    tlk:Message(base .. "070")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, minerva_index, "e002", 10, 10)
    tlk:Message(base .. "080")
    Flg.Set("FLAG_IS_CLEAR_S900_217")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Clear(0)
    WaitFrame(30)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S900_217:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_255) then
    GoToHazamaWithEvt("s900_216_hazama")
  end
end

function S900_217:Event_030()
end

function S900_217:Event_040()
  local mars_index = GetIndex(NPC, "OP_Marus")
  Field.ObjectLoadMotion(NPC, mars_index, "bn01")
  Field.ObjectLoadMotion(NPC, mars_index, "fq01")
  Field.ObjectLoadMotion(NPC, mars_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-15.998, 31.449, 5.047, -6.299, 32.3, 2.77, default, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, mars_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_013") then
      tlk:Message(base .. "100")
    else
      tlk:Message(base .. "105")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, mars_index, "fe02", 10, 10)
      tlk:Message(base .. "110")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_001")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_045()
  local mars_index = GetIndex(NPC, "OP_Marus")
  Field.ObjectLoadMotion(NPC, mars_index, "bn01")
  Field.ObjectLoadMotion(NPC, mars_index, "fq01")
  Field.ObjectLoadMotion(NPC, mars_index, "fe02")
  if Flg.Check("FLAG_SUB_900_217_001") then
    Flg.Set("FLAG_SUB_900_217_013")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, mars_index, "fe02", 10, 10)
    tlk:Message(base .. "120")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_001")
  end
end

function S900_217:Event_050()
  local npc_index = GetIndex(NPC, "OP_Neptune")
  Field.ObjectLoadMotion(NPC, npc_index, "bn01")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  if Qst.Sub:IsCompleted(self.ID) then
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-13.07, 33.6, -1.782, -3.437, 31, -2.41, default, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_014") then
      tlk:Message(base .. "130")
    else
      tlk:Message(base .. "135")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "140")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_002")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_055()
  if Flg.Check("FLAG_SUB_900_217_002") then
    Flg.Set("FLAG_SUB_900_217_014")
    local npc_index = GetIndex(NPC, "OP_Neptune")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
    tlk:Message(base .. "150")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_002")
  end
end

function S900_217:Event_060()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Meruki")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    Cam.Inst:Set(12.328, 32.25, 4, 2.904, 31.93, 0.673, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_015") then
      tlk:Message(base .. "160")
    else
      tlk:Message(base .. "165")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "170")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_003")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_065()
  if Flg.Check("FLAG_SUB_900_217_003") then
    Flg.Set("FLAG_SUB_900_217_015")
    local npc_index = GetIndex(NPC, "OP_Meruki")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    Cam.Inst:Set(12.328, 32.25, 4, 2.904, 31.93, 0.673, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "180")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_003")
  end
end

function S900_217:Event_070()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Minerva")
    Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc_index, "e012")
    Field.ObjectLoadMotion(NPC, npc_index, "e018")
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e012", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_016") then
      tlk:Message(base .. "190")
    else
      tlk:Message(base .. "195")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e018", 10, 10)
      tlk:Message(base .. "200")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_004")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  end
end

function S900_217:Event_075()
  if Flg.Check("FLAG_SUB_900_217_004") then
    Flg.Set("FLAG_SUB_900_217_016")
    local npc_index = GetIndex(NPC, "OP_Minerva")
    Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc_index, "e012")
    Field.ObjectLoadMotion(NPC, npc_index, "e018")
    Cam.Inst:Set(-10.658, 29.55, -11.59, -8.361, 31.8, -2.12, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e012", 10, 10)
    tlk:Message(base .. "210")
    tlk:EndTalk()
    Flg.Clear("FLAG_SUB_900_217_004")
  end
end

function S900_217:Event_080()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Juno")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_017") then
      tlk:Message(base .. "220")
    else
      tlk:Message(base .. "225")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "230")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_005")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  end
end

function S900_217:Event_085()
  if Flg.Check("FLAG_SUB_900_217_005") then
    Flg.Set("FLAG_SUB_900_217_017")
    local npc_index = GetIndex(NPC, "OP_Juno")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "240")
    tlk:EndTalk()
    Flg.Clear("FLAG_SUB_900_217_005")
  end
end

function S900_217:Event_090()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Ceres")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-1.489, 35.35, 11.464, -2.122, 30.01, 3.032, default, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_018") then
      tlk:Message(base .. "250")
    else
      tlk:Message(base .. "255")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "260")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_006")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_095()
  if Flg.Check("FLAG_SUB_900_217_006") then
    Flg.Set("FLAG_SUB_900_217_018")
    local npc_index = GetIndex(NPC, "OP_Ceres")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "270")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_006")
  end
end

function S900_217:Event_100()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Apollo")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(6.25, 32.95, -9.85, 3.77, 31.07, -0.35, default, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_019") then
      tlk:Message(base .. "280")
    else
      tlk:Message(base .. "285")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "290")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_007")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_105()
  if Flg.Check("FLAG_SUB_900_217_007") then
    Flg.Set("FLAG_SUB_900_217_019")
    local npc_index = GetIndex(NPC, "OP_Apollo")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq02")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq02", 10, 10)
    tlk:Message(base .. "300")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_007")
  end
end

function S900_217:Event_110()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Diana")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-10.29, 32.55, 9.1, -0.8, 31.53, 6.12, default, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_020") then
      tlk:Message(base .. "310")
    else
      tlk:Message(base .. "315")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "320")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_008")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_115()
  if Flg.Check("FLAG_SUB_900_217_008") then
    Flg.Set("FLAG_SUB_900_217_020")
    local npc_index = GetIndex(NPC, "OP_Diana")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "330")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_008")
  end
end

function S900_217:Event_120()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Venus")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_021") then
      tlk:Message(base .. "340")
    else
      tlk:Message(base .. "345")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "350")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_009")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
      else
      end
    end
  end
end

function S900_217:Event_125()
  if Flg.Check("FLAG_SUB_900_217_009") then
    Flg.Set("FLAG_SUB_900_217_021")
    local npc_index = GetIndex(NPC, "OP_Venus")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(15.81, 29.99, 3.4, 8.728, 31.74, -3.44, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "360")
    tlk:EndTalk()
    Flg.Clear("FLAG_SUB_900_217_009")
  end
end

function S900_217:Event_130()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Vulcanus")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(11.41, 31.7, -7.454, 7.08, 31.85, 1.56, default, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_022") then
      tlk:Message(base .. "370")
    else
      tlk:Message(base .. "375")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "380")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_010")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_135()
  if Flg.Check("FLAG_SUB_900_217_010") then
    Flg.Set("FLAG_SUB_900_217_022")
    Flg.Set("FLAG_SUB_900_217_022")
    local npc_index = GetIndex(NPC, "OP_Vulcanus")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    tlk:Message(base .. "390")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_010")
  end
end

function S900_217:Event_140()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Bacchus")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(6.22, 33.35, 8.5, -0.23, 30.85, 1.28, default, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fq01", 10, 10)
    if not Flg.Check("FLAG_SUB_900_217_023") then
      tlk:Message(base .. "400")
    else
      tlk:Message(base .. "405")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message(base .. "410")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_011")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_145()
  if Flg.Check("FLAG_SUB_900_217_011") then
    Flg.Set("FLAG_SUB_900_217_023")
    local npc_index = GetIndex(NPC, "OP_Bacchus")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fq01")
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
    tlk:Message(base .. "420")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_011")
  end
end

function S900_217:Event_150()
  if Qst.Sub:IsCompleted(self.ID) then
    local npc_index = GetIndex(NPC, "OP_Jupiter")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc_index, "ba02")
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(0.2697, 34.15, -10.25, 1.235, 30.476, -0.996, default, 30)
    if not Flg.Check("FLAG_SUB_900_217_024") then
      tlk:Message(base .. "430")
    else
      tlk:Message(base .. "435")
    end
    local result = tlk:Select(2, base .. "090")
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "ba02", 10, 10)
      tlk:Message(base .. "440")
      tlk:EndTalk()
      Flg.Set("FLAG_SUB_900_217_012")
      EncountFromField_WithNormalEffect(29002160, 20571, false)
    else
      if result == RESULT_TALK01 then
        tlk:EndTalk()
        Cam.Inst:Clear(30)
      else
      end
    end
  end
end

function S900_217:Event_155()
  if Flg.Check("FLAG_SUB_900_217_012") then
    Flg.Set("FLAG_SUB_900_217_024")
    local npc_index = GetIndex(NPC, "OP_Jupiter")
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc_index, "ba02")
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "450")
    if Flg.Check("FLAG_SUB_900_217_026") then
      tlk:EndTalk()
    else
      tlk:EndTalk(true)
    end
    Flg.Clear("FLAG_SUB_900_217_012")
  end
end

function S900_217:Event_160()
  if Flg.Check("FLAG_SUB_900_217_025") and not Flg.Check("FLAG_SUB_900_217_026") then
    Flg.Set("FLAG_SUB_900_217_026")
    local npc_index = GetIndex(NPC, "OP_Minerva")
    local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
    local npc_rot = Field.ObjectGetRotationY(NPC, npc_index)
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
    Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc_index, "ba02")
    Field.ObjectLoadMotion(NPC, npc_index, "e002")
    Field.ObjectLoadMotion(NPC, npc_index, "e006")
    Field.ObjectLoadMotion(NPC, npc_index, "e012")
    Field.ObjectLoadMotion(NPC, npc_index, "e013")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-0.02, 29.79, -12.17, -0.798, 31.47, -2.34, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotion(NPC, npc_index, "fn01_01", 10, true)
    Obj:new(PLAYER, ""):SetPos(-1.03, 30, -5.12)
    Obj:new(PLAYER, ""):SetRotationY(30, 0)
    Obj:new(NPC, "OP_Minerva"):SetPos(0.12, 30, -6.11)
    Obj:new(NPC, "OP_Minerva"):SetRotationY(200, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, npc_index, "e006", 10, true)
    tlk:Message(base .. "460")
    Field.ObjectPlayMotion(NPC, npc_index, "e002", 10, true)
    tlk:Message(base .. "470")
    Field.ObjectPlayMotion(NPC, npc_index, "e013", 10, true)
    tlk:Message(base .. "480")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    tlk:EndTalk()
    Obj:new(NPC, "OP_Minerva"):SetRotationY(npc_rot, 0)
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, npc_index, "bn01", 10, true)
    Obj:new(NPC, "OP_Minerva"):SetPos(npc_pos.x, npc_pos.y, npc_pos.z)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    SetFollowerCameraOperateRotation(5, 0, 0)
    Flg.Clear("FLAG_SUB_900_217_012")
  end
end
