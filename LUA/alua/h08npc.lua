function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  local player_index = GetIndex(PLAYER, "")
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 810 and talk_id == 1 then
    DotTalk(10000, 387, 50, 4081010, PERSONAL_WARUJIE, 0, 100)
  end
  if gMapNum == 811 and talk_id == 1 then
    DotTalk(10000, 342, 25, 4081110, 0, 0, 35)
  end
  if gMapNum == 812 and talk_id == 1 then
    DotTalk(10000, 44, 30, 4081210, 0, 0, 40)
  end
  if gMapNum == 813 and talk_id == 1 then
    DotTalk(10000, 213, 60, 4081310, 0, 0, 100)
  end
end
