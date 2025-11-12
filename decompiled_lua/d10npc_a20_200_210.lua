function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 1001 then
    if npc_name == "npc_0005" then
      local fldtxt = "d10"
      local npc_0005 = Obj:new(NPC, "npc_0005")
      local npc_index = GetIndex(NPC, "npc_0005")
      Field.ObjectLoadExpression(NPC, npc_index, "F01")
      if Flg.Check("FLAG_MAIN_07_065") then
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        ObjectTurnToPlayer(NPC, npc_0005.name)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1001_0110_0030")
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_07_061") then
        M210:Event_110()
      else
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1001_0110_0010")
        Message("f_d1001_0110_0020")
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
      end
    end
  elseif gMapNum == 1002 then
  end
end
