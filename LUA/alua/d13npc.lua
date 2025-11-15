function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 1301 then
    if npc_name == "npc_0002" then
      if not Flg.Check("FLAG_MAIN_17_038") then
        local npc01_index = GetIndex(NPC, npc_name)
        Field.ObjectLoadMotion(NPC, npc01_index, "e033")
        Field.ObjectLoadMotion(NPC, npc01_index, "e002")
        local tlk = Tlk:new("d13", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1301_0400_0010")
        tlk:EndTalk()
      else
        M390:Event_090()
      end
    end
    if npc_name == "npc_0035" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "e013")
      Field.ObjectLoadMotion(NPC, npc01_index, "e002")
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
      tlk:Message("f_d1301_0380_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "e013", 10, true)
      tlk:EndTalk()
    end
    if npc_name == "npc_0036" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      Field.ObjectPlayMotion(NPC, npc01_index, "fe02", 10, true)
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      tlk:Message("f_d1301_0390_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      tlk:EndTalk()
    end
  end
end
