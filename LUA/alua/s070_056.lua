S070_056 = {
  ID = 56,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255
}
local base = "s070_056_"
local text_file = "s070_056"

function S070_056:Event_010()
  local minerva_index = GetIndex(NPC, "sub056_001")
  local minerva_rot = Field.ObjectGetRotationY(NPC, minerva_index)
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local e002 = Motion.Object:new(NPC, "sub056_001", "e002")
    local e008 = Motion.Object:new(NPC, "sub056_001", "e008")
    local e010 = Motion.Object:new(NPC, "sub056_001", "e010")
    local e012 = Motion.Object:new(NPC, "sub056_001", "e012")
    local e032 = Motion.Object:new(NPC, "sub056_001", "e032")
    local e033 = Motion.Object:new(NPC, "sub056_001", "e033")
    local fn01_01 = Motion.Object:new(NPC, "sub056_001", "fn01_01")
    local p_e002 = Motion.Object:new(PLAYER, "", "e002")
    local p_e004 = Motion.Object:new(PLAYER, "", "e004")
    local p_e008 = Motion.Object:new(PLAYER, "", "e008")
    local p_e012 = Motion.Object:new(PLAYER, "", "e012")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local tlk = Tlk:new(text_file, 1, true)
    Field.ObjectLoadExpression(NPC, minerva_index, "F01_T01")
    tlk:StartTalkActionAndZoom("sub056_001")
    HideMinimap(true)
    HideGuide(true)
    ObjectTurnToPlayer(NPC, "sub056_001")
    WaitFrame(15)
    e008:PlayWithStartMoveMotion(10, 10)
    Field.ObjectChangeExpression(NPC, minerva_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "010")
    Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, minerva_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "030")
    end
    if result == RESULT_TALK01 then
      e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "040")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "050")
      tlk:EndTalkActionAndZoom()
      HideMinimap(false)
      HideGuide(false)
      Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    else
      e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "060")
      e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "070")
      e032:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "080")
      tlk:MessageClose()
      Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      do
        local result1 = tlk:Select(3, base .. "090")
        WaitFrame(15)
        Field.ObjectChangeExpression(NPC, minerva_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        if result1 == RESULT_TALK00 then
          e002:PlayWithStartMoveMotion(10, 10)
          tlk:Message(base .. "100")
        end
        if result1 == RESULT_TALK01 then
          e002:PlayWithStartMoveMotion(10, 10)
          tlk:Message(base .. "110")
        end
        if result1 == RESULT_TALK02 then
          tlk:Message(base .. "120")
        end
        e012:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "130")
        tlk:Message(base .. "140")
        e008:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "150")
        Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        tlk:MessageClose()
        local result2 = tlk:Select(3, base .. "160")
        WaitFrame(15)
        Field.ObjectChangeExpression(NPC, minerva_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        if result2 == RESULT_TALK00 then
          e002:PlayWithStartMoveMotion(10, 10)
          tlk:Message(base .. "170")
        end
        if result2 == RESULT_TALK01 then
          e010:PlayWithStartMoveMotion(10, 10)
          tlk:Message(base .. "180")
        end
        if result2 == RESULT_TALK02 then
          e010:PlayWithStartMoveMotion(10, 10)
          tlk:Message(base .. "190")
        end
        e012:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "200")
        e032:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "210")
        Field.EndPlayerAndNpcTalkAction("sub056_001")
        Cam.Inst:Set(-33.865, -1.52, -47.33, -24.34, 1.085, -45.76, default, 30)
        Field.ClearNpcTalkZoomCamera(0, 1)
        WaitFrame(30)
        e002:PlayWithStartMoveMotion(10, 10)
        tlk:Message(base .. "220")
        Cam.Inst:Clear(30)
        WaitFrame(30)
        Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        tlk:EndTalk()
      end
      Flg.Set("FLAG_SUB_070_056_001")
      Qst.Sub:Start(self.ID, 1, false)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_005)
    end
    ObjectTurnToRotaitonY(NPC, "sub056_001", minerva_rot, true)
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local e002 = Motion.Object:new(NPC, "sub056_001", "e002")
    local e006 = Motion.Object:new(NPC, "sub056_001", "e006")
    local e008 = Motion.Object:new(NPC, "sub056_001", "e008")
    local e010 = Motion.Object:new(NPC, "sub056_001", "e010")
    local e032 = Motion.Object:new(NPC, "sub056_001", "e032")
    local e033 = Motion.Object:new(NPC, "sub056_001", "e033")
    local fn01_01 = Motion.Object:new(NPC, "sub056_001", "fn01_01")
    local fq02 = Motion.Object:new(NPC, "s070_056_010", "fq02")
    local minerva_index = GetIndex(NPC, "sub056_001")
    Field.ObjectLoadExpression(NPC, minerva_index, "F01_T01")
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("sub056_001")
    HideMinimap(true)
    HideGuide(true)
    ObjectTurnToPlayer(NPC, "sub056_001")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, minerva_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if not IsInPartyBeelzemon() then
      e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "300")
      e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "310")
      tlk:EndTalkActionAndZoom()
      Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      goto lbl_990
      HideMinimap(false)
      HideGuide(false)
    else
      e002:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "320")
      Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      local modelname = GetIDPartyBeelzemon()
      local branch = 0
      if modelname == "chr035" then
        Flg.Set("FLAG_SUB_070_056_003")
        branch = 1
      elseif modelname == "chr775" then
        Flg.Set("FLAG_SUB_070_056_005")
        branch = 2
      end
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      tlk:EndActionAndZoom()
      Cam.Inst:Set(-15.979, 0.627, -54.98, -21.425, 1.71, -46.66, default, 0)
      FieldObjectSync(NPC, false)
      if modelname == "chr035" then
        Obj:new(NPC, "sub056_001"):SetRotationYToObject(NPC, "s070_056_010", 0)
        Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "sub056_001", 0)
        Obj:new(PLAYER, ""):SetPos(-18.63, 0.02, -49.1)
      elseif modelname == "chr775" then
        Obj:new(NPC, "sub056_001"):SetRotationYToObject(NPC, "s070_056_020", 0)
        Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "sub056_001", 0)
        Obj:new(PLAYER, ""):SetPos(-18.63, 0.02, -49.1)
      end
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      if branch == 1 then
        tlk:Message(base .. "330")
      elseif branch == 2 then
        tlk:Message(base .. "331")
      end
      e008:PlayWithStartMoveMotion(10, 10)
      tlk:Message(base .. "340")
      e006:Play(10, true)
      tlk:Message(base .. "350")
      Flg.Set("FLAG_SUB_070_056_002")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      if branch == 1 then
        Cam.Inst:Set(-16.95, 1.07, -56.47, -17.811, 1.62, -46.52, default, 0)
      elseif branch == 2 then
        Cam.Inst:Set(-16.04, 0.63, -56.82, -18.273, 1.76, -47.135, default, 0)
      end
      Obj:new(NPC, "s070_056_010"):SetRotationYToObject(PLAYER, "", 0)
      Obj:new(NPC, "s070_056_020"):SetRotationYToObject(PLAYER, "", 0)
      WaitFrame(5)
      Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s070_056_010", 0)
      Obj:new(PLAYER, ""):SetRotationYToObject(NPC, "s070_056_020", 0)
      FieldObjectSync(FOR_ALL, false)
      WaitFrame(10)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      if branch == 1 then
        tlk:Message(base .. "360")
      elseif branch == 2 then
        tlk:Message(base .. "361")
      end
      Flg.Set("FLAG_SUB_070_056_004")
      Flg.Set("FLAG_SUB_070_056_006")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Clear(0)
      tlk:EndTalk()
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
      Digitter.Send(2056020)
    end
    ::lbl_990::
    ObjectTurnToRotaitonY(NPC, "sub056_001", minerva_rot, true)
  end
end

function S070_056:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local e002 = Motion.Object:new(NPC, "sub056_002", "e002")
    local e008 = Motion.Object:new(NPC, "sub056_002", "e008")
    local e010 = Motion.Object:new(NPC, "sub056_002", "e010")
    local e032 = Motion.Object:new(NPC, "sub056_002", "e032")
    local e033 = Motion.Object:new(NPC, "sub056_002", "e033")
    local fn01_01 = Motion.Object:new(NPC, "sub056_002", "fn01_01")
    local minerva_index = GetIndex(NPC, "sub056_002")
    Field.ObjectLoadExpression(NPC, minerva_index, "F01_T01")
    local tlk = Tlk:new(text_file, 1, true)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkActionAndZoom("sub056_002")
    ObjectTurnToPlayer(NPC, "sub056_002")
    WaitFrame(15)
    e002:PlayWithStartMoveMotion(10, 10)
    Field.ObjectChangeExpression(NPC, minerva_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "380")
    e008:PlayWithStartMoveMotion(10, 10)
    tlk:Message(base .. "390")
    tlk:Message(base .. "400")
    Field.ObjectChangeExpression(NPC, minerva_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Flg.Set("FLAG_IS_CLEAR_S070_056")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    tlk:EndTalkActionAndZoom()
    WaitFrame(30)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S070_056:Event_030()
  local fq01 = Motion.Object:new(NPC, "sub056_004", "fq01")
  local fq02 = Motion.Object:new(NPC, "sub056_004", "fq02")
  local fe02 = Motion.Object:new(NPC, "sub056_004", "fe02")
  local fe04 = Motion.Object:new(NPC, "sub056_004", "fe04")
  local bn01 = Motion.Object:new(NPC, "sub056_004", "bn01")
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("sub056_004")
    fq01:PlayWithStartMoveMotion(15, 15)
    tlk:Message(base .. "410")
    tlk:MessageClose()
    local result = tlk:Select(2, base .. "420")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      card_battle()
    else
      tlk:EndTalkActionAndZoom()
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("sub056_004")
    if not IsInPartyBeelzemon() then
      tlk:Message(base .. "230")
      fq01:PlayWithStartMoveMotion(15, 15)
      tlk:Message(base .. "240")
      tlk:MessageClose()
      local result = tlk:Select(2, base .. "420")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        card_battle()
      else
        tlk:EndTalkActionAndZoom()
      end
    else
      fe02:PlayWithStartMoveMotion(15, 15)
      tlk:Message(base .. "250")
      fq01:PlayWithStartMoveMotion(15, 15)
      tlk:Message(base .. "260")
      tlk:Message(base .. "270")
      local result = tlk:Select(2, base .. "420")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        card_battle()
      else
        tlk:EndTalkActionAndZoom()
      end
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_255) then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("sub056_004")
    if IsInPartyBeelzemon() then
      fe02:PlayWithStartMoveMotion(15, 15)
      tlk:Message(base .. "250")
      fq01:PlayWithStartMoveMotion(15, 15)
      tlk:Message(base .. "260")
      tlk:Message(base .. "270")
      local result = tlk:Select(2, base .. "420")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        card_battle()
      else
        tlk:EndTalkActionAndZoom()
      end
    else
      tlk:Message(base .. "410")
      tlk:MessageClose()
      local result = tlk:Select(2, base .. "420")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        card_battle()
      else
        tlk:EndTalkActionAndZoom()
      end
    end
  else
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkActionAndZoom("sub056_004")
    if IsInPartyBeelzemon() then
      fe02:PlayWithStartMoveMotion(15, 15)
      tlk:Message(base .. "250")
      fq01:PlayWithStartMoveMotion(15, 15)
      tlk:Message(base .. "260")
      tlk:Message(base .. "270")
      local result = tlk:Select(2, base .. "420")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        card_battle()
      else
        tlk:EndTalkActionAndZoom()
      end
    else
      tlk:Message(base .. "410")
      tlk:MessageClose()
      local result = tlk:Select(2, base .. "420")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        card_battle()
      else
        tlk:EndTalkActionAndZoom()
      end
    end
  end
end

function card_battle()
  local fq01 = Motion.Object:new(NPC, "sub056_004", "fq01")
  local fq02 = Motion.Object:new(NPC, "sub056_004", "fq02")
  local fe02 = Motion.Object:new(NPC, "sub056_004", "fe02")
  local fe04 = Motion.Object:new(NPC, "sub056_004", "fe04")
  local bn01 = Motion.Object:new(NPC, "sub056_004", "bn01")
  local tlk = Tlk:new(text_file, 1, true)
  local result = Field.StartCardGameWithNPC(11202, true)
  if result == CARD_GAME_WIN then
    tlk:StartTalkActionAndZoom("sub056_004")
    fq02:PlayWithStartMoveMotion(15, 15)
    tlk:Message(base .. "430")
    tlk:EndTalkActionAndZoom()
  elseif result == CARD_GAME_LOSE then
    tlk:StartTalkActionAndZoom("sub056_004")
    fe02:PlayWithStartMoveMotion(15, 15)
    tlk:Message(base .. "440")
    tlk:EndTalkActionAndZoom()
  else
    tlk:StartTalkActionAndZoom("sub056_004")
    fe02:PlayWithStartMoveMotion(15, 15)
    tlk:Message(base .. "440")
    tlk:EndTalkActionAndZoom()
  end
end

function IsInPartyBeelzemon()
  for i = 1, 6 do
    local unique_id = Digimon.GetUniqueIDInPartyMember(i)
    local index = Digimon.GetPartyMemberIndexByUniqueID(unique_id)
    local modelname = Field.ObjectGetModelName(FLD_OBJ_FOLLOWER, index)
    if modelname == "chr035" or modelname == "chr775" then
      print(modelname)
      print("true")
      return true
    else
      print(modelname)
      print("false")
    end
  end
  return false
end

function GetIDPartyBeelzemon()
  for i = 1, 6 do
    local unique_id = Digimon.GetUniqueIDInPartyMember(i)
    local index = Digimon.GetPartyMemberIndexByUniqueID(unique_id)
    local modelname = Field.ObjectGetModelName(FLD_OBJ_FOLLOWER, index)
    if modelname == "chr035" or modelname == "chr775" then
      print(modelname)
      print("true")
      return modelname
    else
      print(modelname)
      print("false")
    end
  end
  return false
end
