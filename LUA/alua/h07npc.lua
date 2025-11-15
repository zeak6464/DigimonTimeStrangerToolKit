function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 701 then
    if npc_name == "npc_aigio02" then
      M420:Event_092()
    end
    if npc_name == "npc_aigio03" then
      M420:Event_093()
    end
    if npc_name == "npc_aigio04" then
      M420:Event_100()
    end
  end
end
