function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum >= 310 and gMapNum <= 313 then
    if npc_name == "npc_001" then
      Prcs_H03PecmonShop(npc_name, gMapNum)
    end
    if npc_name == "npc_010" then
      Prcs_H03TouchMechanorimon()
    end
    if gMapNum == 310 and talk_id == 1 then
      DotTalk(10000, 56, 15, 4031010, 0, 0, 25)
    end
    if gMapNum == 311 and talk_id == 1 then
      DotTalk(10000, 601, 25, 4031110, PERSONAL_TENKEI, 0, 35)
    end
    if gMapNum == 312 and talk_id == 1 then
      DotTalk(10000, 210, 30, 4031210, 0, 0, 40)
    end
    if gMapNum == 313 and talk_id == 1 then
      DotTalk(10000, 678, 40, 4031310, 0, 0, 100)
    end
  end
end
