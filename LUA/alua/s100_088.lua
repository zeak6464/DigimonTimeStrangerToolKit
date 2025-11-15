S100_088 = {
  ID = 88,
  STEP_001 = 1,
  STEP_010 = 10,
  STEP_013 = 13,
  STEP_014 = 14,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_255 = 255,
  Flg001 = "FLAG_SUB_100_088_001",
  Flg002 = "FLAG_SUB_100_088_002"
}
local text_file = "s100_088"
local base = "s100_088_"
local tlk = Tlk:new(text_file, 1, true)

function S100_088:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_010) and Qst.Main:IsCompleted(M260.ID) then
    local konron = Obj:new(NPC, "npc_0003")
    local e002 = Motion.Object:new(PLAYER, "", "e002")
    local e004 = Motion.Object:new(PLAYER, "", "e004")
    local e012 = Motion.Object:new(PLAYER, "", "e012")
    local fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    WaitFrame(30)
    Cam.Inst:Set(10.84, -0.05, -15.45, 7.66, 1.584, -6.11, default, 30)
    WaitFrame(30)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAction("npc_0003")
    konron:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "010")
    konron:ResetExporession(10)
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    konron:ChangeExpression("F01", EYE_BLINK, true, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "030")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "050")
    end
    tlk:Message(base .. "060")
    tlk:Message(base .. "070")
    tlk:Message(base .. "080")
    tlk:Message(base .. "090")
    tlk:Message(base .. "100")
    konron:ResetExporession(10)
    result = tlk:Select(3, base .. "120")
    WaitFrame(15)
    konron:ChangeExpression("F01", EYE_BLINK, true, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "130")
      tlk:Message(base .. "140")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "150")
      tlk:Message(base .. "160")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "170")
      tlk:Message(base .. "180")
    end
    tlk:Message(base .. "190")
    tlk:Message(base .. "192")
    konron:ResetExporession(10)
    result = tlk:Select(3, base .. "200")
    WaitFrame(15)
    konron:ChangeExpression("F01", EYE_BLINK, true, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "210")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "230")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "250")
    end
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:Message(base .. "290")
    konron:ResetExporession(10)
    tlk:EndTalkAction()
    t3003_SetCamera(30)
    WaitFrame(30)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_010)
    Flg.Set(self.Flg002)
  end
end

function S100_088:Event_014()
  if Qst.Sub:Check(self.ID, self.STEP_013, self.STEP_014) and Flg.Check("FLAG_SUB_100_089_001") then
    Qst.Sub:Set(self.ID, self.STEP_014)
  end
end

function S100_088:Event_015()
  if Qst.Sub:Check(self.ID, self.STEP_025, self.STEP_030) then
    Qst.Sub:Set(self.ID, self.STEP_030)
  end
end

function S100_088:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_030) then
    local konron = Obj:new(NPC, "npc_0003")
    tlk:StartTalkAndCancelDigimonRide()
    konron:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "300")
    konron:ResetExporession(10)
    tlk:EndTalk()
  end
end

function S100_088:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    local konron = Obj:new(NPC, "npc_0003")
    Cam.Inst:Set(10.84, -0.05, -15.45, 7.66, 1.584, -6.11, default, 30)
    WaitFrame(30)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAction("npc_0003")
    konron:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "310")
    tlk:Message(base .. "320")
    konron:ResetExporession(10)
    tlk:EndTalkAction()
    t3003_SetCamera(30)
    WaitFrame(30)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S100_088:Event_050()
  if Qst.Sub:IsCompleted(self.ID) then
    local konron = Obj:new(NPC, "npc_0003")
    Cam.Inst:Set(10.84, -0.05, -15.45, 7.66, 1.584, -6.11, default, 30)
    WaitFrame(30)
    tlk:StartTalkAction("npc_0003")
    konron:ChangeExpression("F01", EYE_BLINK, true, 10)
    tlk:Message(base .. "370")
    konron:ResetExporession(10)
    tlk:EndTalkAction()
    t3003_SetCamera(30)
    WaitFrame(30)
  end
end
