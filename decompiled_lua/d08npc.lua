function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 801 then
    if talk_id == 1 then
      local fldtxt = "d08"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0801_0010_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if talk_id == 2 then
      local colona = Obj:new(NPC, npc_name)
      local korona_e006 = Motion.Object:new(NPC, "npc_0002", "e006")
      local korona_e007 = Motion.Object:new(NPC, "npc_0002", "e007")
      local fldtxt = "d08"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      korona_e006:Play(10, true)
      colona:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
      Message("f_d0801_0020_0010")
      korona_e007:Play(10, true)
      Message("f_d0801_0020_0020")
      colona:ChangeExpression("F01", EYE_BLINK, false, 10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if talk_id == 3 then
      local fldtxt = "d08"
      local runa_01 = Obj:new(NPC, "npc_0003")
      local e004 = Motion.Object:new(NPC, "npc_0003", "e004")
      local e008 = Motion.Object:new(NPC, "npc_0003", "e008")
      runa_01:SetRotationYToPlayer(15)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e004:Play(10, true)
      runa_01:ChangeExpression("F01_T01", EYE_BLINK, true, 10)
      Message("f_d0801_0030_0010")
      Message("f_d0801_0030_0020")
      runa_01:ChangeExpression("F01", EYE_BLINK, false, 10)
      e008:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  end
end
