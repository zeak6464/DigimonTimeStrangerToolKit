function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = "d50"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
  elseif gMapNum == 5004 then
  elseif gMapNum == 5005 then
  end
end
