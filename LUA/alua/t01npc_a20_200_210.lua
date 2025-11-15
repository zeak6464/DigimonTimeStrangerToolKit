function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  local field_text = "field_text"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 101 then
  elseif gMapNum == 102 then
    if npc_name == "npc_3019" then
      local e008 = Motion.Object:new(NPC, "npc_3019", "e008")
      local e013 = Motion.Object:new(NPC, "npc_3019", "e013")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e013:Play(10, true)
      Message("f_t0102_0100_0010")
      e008:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3123" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0102_0170_0010")
      Message("f_t0102_0170_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3124" then
      local fldtxt = "t01"
      if Flg.Check("FLAG_MAIN_07_050") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0102_0180_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        M200:Event_020()
      end
    end
    if npc_name == "npc_3125" then
      local e008 = Motion.Object:new(NPC, "npc_3125", "e008")
      local e013 = Motion.Object:new(NPC, "npc_3125", "e013")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e013:Play(10, true)
      Message("f_t0102_0110_0020")
      Message("f_t0102_0110_0010")
      e008:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3126" then
      local fldtxt = "t01"
      if Flg.Check("FLAG_MAIN_07_053") and not Flg.Check("FLAG_MAIN_07_054B") then
        M210:Event_015()
      elseif Flg.Check("FLAG_MAIN_07_054B") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0102_0210_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0102_0160_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "npc_3127" then
      local e018 = Motion.Object:new(NPC, "npc_3127", "e018")
      local e013 = Motion.Object:new(NPC, "npc_3127", "e013")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e018:Play(10, true)
      Message("f_t0102_0210_0010")
      Message("f_t0102_0210_0020")
      e013:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3128" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0102_0200_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "m210_001" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0102_0210_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
  elseif gMapNum == 103 then
  elseif gMapNum == 104 then
    local fldtxt = "t01"
    if npc_name == "npc_011" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0104_0010_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
  elseif gMapNum == 105 then
    if npc_name == "npc_0004" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0105_0050_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      MapChange("d", 1001, "start_04", true, 1, FADE_TIME)
    end
  elseif gMapNum == 106 then
  elseif gMapNum == 107 then
  elseif gMapNum == 108 then
    local fldtxt = "t01"
    if npc_name == "npc_0010" then
      local fldtxt = "t01"
      local tlk = Tlk:new("t01", 1, true)
      local simons_index = GetIndex(NPC, "npc_0010")
      Field.ObjectLoadMotion(NPC, simons_index, "fn01_01")
      Field.ObjectLoadMotion(NPC, simons_index, "e002")
      Field.ObjectLoadMotion(NPC, simons_index, "e004")
      Field.ObjectLoadMotion(NPC, simons_index, "e005")
      Field.ObjectLoadMotion(NPC, simons_index, "e006")
      Field.ObjectLoadMotion(NPC, simons_index, "e007")
      Field.ObjectLoadMotion(NPC, simons_index, "e008")
      Field.ObjectLoadMotion(NPC, simons_index, "e009")
      Field.ObjectLoadMotion(NPC, simons_index, "e012")
      Field.ObjectLoadMotion(NPC, simons_index, "e013")
      Field.ObjectLoadMotion(NPC, simons_index, "e014")
      Field.ObjectLoadMotion(NPC, simons_index, "e021")
      Field.ObjectLoadMotion(NPC, simons_index, "e023")
      Field.ObjectLoadMotion(NPC, simons_index, "e510")
      Field.ObjectLoadExpression(NPC, simons_index, "F01")
      tlk:StartTalk()
      Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0108_0110_0010")
      Message("f_t0108_0110_0020")
      Message("f_t0108_0110_0030")
      Message("f_t0108_0110_0040")
      Field_Talk_End_Not_LetterBox()
      Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:EndTalk()
    end
    if npc_name == "npc_0011" then
      local fldtxt = "t01"
      local kuga_index = GetIndex(NPC, "npc_0011")
      Field.ObjectLoadExpression(NPC, kuga_index, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, kuga_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0108_0120_0010")
      Field_Talk_End_Not_LetterBox()
      Field.ObjectChangeExpression(NPC, kuga_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
  elseif gMapNum == 109 then
    local fldtxt = "t01"
    if npc_name == "npc_0003" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0109_0020_0010")
      Message("f_t0109_0020_0020")
      FieldTalkEndWithoutLetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0050" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0109_0030_0010")
      Message("f_t0109_0030_0020")
      Message("f_t0109_0030_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0053" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0109_0050_0010")
      Message("f_t0109_0050_0020")
      Message("f_t0109_0050_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
  end
end
