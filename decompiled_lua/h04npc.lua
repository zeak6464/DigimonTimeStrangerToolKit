function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  local player_index = GetIndex(PLAYER, "")
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 415 and talk_id == 1 then
    DotTalk(10000, 77, 15, 4041510, 0, 0, 30)
  end
  if gMapNum == 416 and talk_id == 1 then
    DotTalk(10000, 344, 25, 4041610, PERSONAL_SENRYAKU, 0, 35)
  end
  if gMapNum == 417 and talk_id == 1 then
    DotTalk(10000, 364, 30, 4041710, 0, 0, 40)
  end
  if gMapNum == 418 and talk_id == 1 then
    DotTalk(10000, 128, 60, 4041810, 0, 0, 100)
  end
end
