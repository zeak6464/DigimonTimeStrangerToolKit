S020_012 = {
  ID = 12,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}
local base = "s020_012_"
local text_file = "s020_012"
local tlk = Tlk:new(text_file, 1, true)

function S020_012:Event_000()
  Qst.Sub:Start(self.ID, self.STEP_001, true)
end

function S020_012:Event_010()
  if not Qst.Sub:Check(self.ID, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    tlk:Message(base .. "020")
    tlk:Message(base .. "030")
    tlk:Message(base .. "040")
    local result = tlk:Select(3, base .. "050")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "060")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "070")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "080")
    end
    tlk:Message(base .. "090")
    tlk:Message(base .. "100")
    tlk:Message(base .. "110")
    local result = tlk:Select(3, base .. "120")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "130")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "140")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "150")
    end
    tlk:Message(base .. "160")
    local result = tlk:Select(3, base .. "170")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "180")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "190")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "200")
    end
    tlk:Message(base .. "210")
    tlk:Message(base .. "220")
    tlk:Message(base .. "230")
    Qst.Sub:Set(self.ID, self.STEP_005)
    Flg.Set("FLAG_SUB_020_012_001")
    tlk:EndTalk()
  end
end

function S020_012:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "240")
    tlk:EndTalk()
  end
end

function S020_012:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "250")
    tlk:EndTalk()
  end
end

function S020_012:Event_040()
  if not Qst.Sub:Check(self.ID, self.STEP_005) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "020")
    tlk:EndTalk()
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "260")
    tlk:EndTalk()
  end
end

function S020_012:Event_050()
  if not Qst.Sub:Check(self.ID, self.STEP_010) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    local result = tlk:Select(3, base .. "290")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "300")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "310")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "320")
    end
    tlk:Message(base .. "330")
    local result = tlk:Select(3, base .. "340")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "350")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "360")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "370")
    end
    tlk:Message(base .. "380")
    tlk:Message(base .. "390")
    FadeOutWithWait(0, 15)
    Obj:new(NPC, "s020_012_npc50"):CancelInvisible()
    FadeInWithWait(0, 15)
    tlk:Message(base .. "400")
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
    local result = tlk:Select(3, base .. "430")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "440")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "450")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "460")
    end
    tlk:Message(base .. "470")
    tlk:Message(base .. "480")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_010)
    EncountFromField_PlaySound(20200120, BTL_MAP_NEPVENUS_INSEA1, false)
  elseif not Flg.Check("FLAG_SUB_020_012_010") then
    EncountFromField_PlaySound(20200120, BTL_MAP_NEPVENUS_INSEA1, false)
  end
end

function S020_012:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_SUB_020_012_010") then
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "490")
    FadeOutWithWait(0, 15)
    Obj:new(NPC, "s020_012_npc50"):Invisible()
    FadeInWithWait(0, 15)
    tlk:Message(base .. "500")
    local result = tlk:Select(3, base .. "510")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "520")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "530")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "540")
    end
    tlk:Message(base .. "540")
    INFO_GET_ITEM(761, 1)
    Qst.Sub:Set(self.ID, self.STEP_015)
    Flg.Set("FLAG_SUB_020_012_002")
    tlk:EndTalk()
  end
end

function S020_012:Event_070()
  if Flg.Check("FLAG_SUB_020_012_002") and Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "560")
    local result = tlk:Select(3, base .. "570")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "580")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "590")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "600")
    end
    tlk:Message(base .. "610")
    tlk:Message(base .. "620")
    INFO_RELEASE_ITEM(761, 1)
    FadeOutWithWait(0, 15)
    FadeInWithWait(0, 15)
    tlk:Message(base .. "630")
    tlk:Message(base .. "640")
    FadeOutWithWait(0, 15)
    FadeInWithWait(0, 15)
    tlk:Message(base .. "650")
    tlk:Message(base .. "660")
    FadeOutWithWait(0, 15)
    Obj:new(NPC, "s020_012_npc04"):CancelInvisible()
    Obj:new(NPC, "s020_012_npc03"):Invisible()
    FadeInWithWait(0, 15)
    tlk:Message(base .. "670")
    tlk:Message(base .. "680")
    Qst.Sub:End(self.ID, self.STEP_255)
    tlk:EndTalk()
  end
end

function S020_012:Event_080()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    Obj:new(NPC, "s020_012_npc50"):Invisible()
  end
end

function S020_012:Event_090()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    Obj:new(NPC, "s020_012_npc04"):Invisible()
  end
end
