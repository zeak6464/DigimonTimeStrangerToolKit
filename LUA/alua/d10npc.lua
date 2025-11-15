function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 1001 then
    if talk_id == 1 then
      if Flg.Check("FLAG_MAIN_03_360") then
        M100:Event_070()
      else
        local e005 = Motion.Object:new(NPC, "npc_0001", "e005")
        local e007 = Motion.Object:new(NPC, "npc_0001", "e007")
        local npc_index = GetIndex(NPC, "npc_0001")
        local npc_index_1 = GetIndex(NPC, "npc_0004")
        Field.ObjectLoadExpression(NPC, npc_index, "F01")
        Field.ObjectLoadExpression(NPC, npc_index_1, "F01")
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox("d10", 1)
        e007:Play(20, true)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Field.ObjectChangeExpression(NPC, npc_index_1, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1001_0100_0010")
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field.ObjectChangeExpression(NPC, npc_index_1, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        e005:Play(20, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 2 then
      local npc_index = GetIndex(NPC, "npc_0002")
      Field.ObjectLoadExpression(NPC, npc_index, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox("d10", 1)
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1001_0080_0010")
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      MessageClose()
      MessageTalkSel(2, "f_d1001_0080_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        MapChange("t", 105, "start_05", true, 1, FADE_TIME)
      end
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 3 then
      local e005 = Motion.Object:new(NPC, "npc_0003", "e005")
      local e007 = Motion.Object:new(NPC, "npc_0003", "e008")
      local npc_index = GetIndex(NPC, "npc_0003")
      Field.ObjectLoadExpression(NPC, npc_index, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox("d10", 1)
      e007:Play(20, true)
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1001_0090_0010")
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      e005:Play(20, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 5 then
      local e005 = Motion.Object:new(NPC, "npc_0005", "e005")
      local e002 = Motion.Object:new(NPC, "npc_0005", "e002")
      local npc_index = GetIndex(NPC, "npc_0005")
      Field.ObjectLoadExpression(NPC, npc_index, "F01")
      if Flg.Check("FLAG_MAIN_07_055") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox("d10", 1)
        e002:Play(10, true)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1001_0110_0010")
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        e005:Play(10, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 10 then
      if not Flg.Check("FLAG_MAIN_01_130") then
        M020:Event_020()
      else
        local npc_0010 = Obj:new(NPC, "npc_0010")
        local tlk = Tlk:new("d10")
        tlk:StartTalk()
        npc_0010:ChangeExpression("F01", EYE_BLINK, true, 10)
        tlk:Message("f_d1001_0030_0030")
        npc_0010:ResetExporession(10)
        tlk:EndTalk()
      end
    end
  elseif gMapNum == 1002 then
    if talk_id == 1 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox("d10", 1)
      Message("f_d1002_0010_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 2 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox("d10", 1)
      Message("f_d1002_0020_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "royal_knights_crania" then
      require("S110_092")
      S110_092:Event_010()
    end
  elseif gMapNum == 1003 then
  end
end
