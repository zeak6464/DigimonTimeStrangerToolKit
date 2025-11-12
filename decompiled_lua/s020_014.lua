S020_014 = {
  ID = 14,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255,
  Flg01 = "FLAG_SUB_020_014_001",
  Flg02 = "FLAG_SUB_020_014_002",
  Flg03 = "FLAG_SUB_020_014_003",
  Flg04 = "FLAG_SUB_020_014_004",
  Flg05 = "FLAG_SUB_020_014_005"
}
local text_file = "s020_014"
local base = "s020_014_"

function S020_014:Event_010()
  if Qst.Sub:IsCompleted(13) and not Qst.Sub:IsCompleted(self.ID) and Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set(self.Flg01)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "030")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "050")
    end
    tlk:Message(base .. "060")
    tlk:Message(base .. "070")
    result = tlk:Select(3, base .. "080")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "090")
      tlk:Message(base .. "100")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "110")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "120")
    end
    tlk:Message(base .. "130")
    tlk:Message(base .. "140")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_005)
  end
end

function S020_014:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_015) then
    if not Flg.Check(self.Flg02) then
      Flg.Set(self.Flg02)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "150")
      tlk:Message(base .. "160")
      local result = tlk:Select(3, base .. "170")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "180")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "190")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "200")
      end
      tlk:Message(base .. "210")
      result = tlk:Select(3, base .. "220")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "230")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "240")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "250")
      end
      tlk:Message(base .. "260")
      tlk:Message(base .. "270")
      tlk:Message(base .. "280")
      result = tlk:Select(3, base .. "290")
      if result == RESULT_TALK00 then
        tlk:Message(base .. "300")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "310")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "320")
      end
      tlk:Message(base .. "330")
      Qst.Sub:Set(self.ID, self.STEP_010)
      if 1 <= Item.GetNum(763) then
        result = tlk:Select(3, base .. "350")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "360")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "370")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "380")
        end
        Flg.Set(self.Flg03)
        tlk:Message(base .. "390")
        tlk:Message(base .. "400")
        tlk:Message(base .. "410")
        Qst.Sub:Set(self.ID, self.STEP_015)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        FieldObjectSync(NPC, true)
        WaitFrame(25)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      end
      tlk:EndTalk()
    else
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "340")
      if 1 <= Item.GetNum(763) then
        result = tlk:Select(3, base .. "350")
        if result == RESULT_TALK00 then
          tlk:Message(base .. "360")
        elseif result == RESULT_TALK01 then
          tlk:Message(base .. "370")
        elseif result == RESULT_TALK02 then
          tlk:Message(base .. "380")
        end
        Flg.Set(self.Flg03)
        tlk:Message(base .. "390")
        tlk:Message(base .. "400")
        tlk:Message(base .. "410")
        Qst.Sub:Set(self.ID, self.STEP_015)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        FieldObjectSync(NPC, true)
        WaitFrame(25)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      end
      tlk:EndTalk()
    end
  end
end

function S020_014:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check("FLAG_SUB_060_053_001") then
    text_file = "s060_053"
    base = "s060_053_"
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "110")
    tlk:Message(base .. "120")
    tlk:Message(base .. "130")
    tlk:Message(base .. "140")
    tlk:Message(base .. "150")
    tlk:Message(base .. "160")
    tlk:Message(base .. "170")
    tlk:Message(base .. "180")
    tlk:Message(base .. "190")
    tlk:Message(base .. "200")
    tlk:Message(base .. "210")
    tlk:EndTalk()
    Flg.Set(self.Flg04)
    Guest.Add(GST_HANGYO)
    EncountFromField_PlaySound(20600530, 10771, false)
  end
end

function S020_014:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_020) and Flg.Check(self.Flg04) then
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    text_file = "s060_053"
    base = "s060_053_"
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "220")
    tlk:Message(base .. "230")
    tlk:Message(base .. "240")
    tlk:Message(base .. "250")
    tlk:Message(base .. "260")
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    tlk:Message(base .. "290")
    tlk:Message(base .. "300")
    tlk:Message(base .. "310")
    tlk:Message(base .. "320")
    tlk:Message(base .. "330")
    tlk:EndTalk()
    Qst.Sub:Set(self.ID, self.STEP_020)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function S020_014:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    Flg.Set(self.Flg05)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "450")
    tlk:Message(base .. "460")
    tlk:Message(base .. "470")
    tlk:Message(base .. "480")
    tlk:Message(base .. "490")
    tlk:Message(base .. "500")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    Obj:new(PLAYER, ""):SetPos(0.716, -0.008, -62.33, true)
    local h_pos = Obj:new(NPC, "s020_014_002").pos
    local y_degree = GetAngleToTarget2D(0.716, -62.33, h_pos.x, h_pos.z)
    Obj:new(PLAYER, ""):SetRotationY(y_degree, 0)
    SetFollowerCameraOperateRotation(0, y_degree - 10, 0)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "510")
    tlk:Message(base .. "520")
    tlk:Message(base .. "530")
    tlk:EndTalk()
    Qst.Sub:End(self.ID, self.STEP_255)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(25)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end
