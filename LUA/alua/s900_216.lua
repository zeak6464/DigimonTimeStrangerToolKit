S900_216 = {
  ID = 216,
  STEP_001 = 1,
  STEP_255 = 255
}
local text_file = "s900_216"
local base = text_file .. "_"
local tlk = Tlk:new(text_file, 1, true)

function S900_216:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_255) then
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(PLAYER, ""):SetPos(-9.925, 0, 0.5, true)
    Obj:new(PLAYER, ""):SetRotationY(270, 0)
    Cam.Inst:Set(-18.548, 0, 0.05, -8.679, 1.61, -0.11, default, 0)
    local mirei_index = GetIndex(NPC, "farm_0001")
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(10)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectChangeExpression(NPC, mirei_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    Field.ObjectChangeExpression(NPC, mirei_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(3, base .. "030")
    Field.ObjectChangeExpression(NPC, mirei_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "050")
    else
      tlk:Message(base .. "060")
    end
    tlk:Message(base .. "070")
    tlk:Message(base .. "080")
    Field.ObjectChangeExpression(NPC, mirei_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_SUB_900_172_001")
    Cam.Inst:Clear(30)
    WaitFrame(120)
  end
end
