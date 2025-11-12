function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  local player_index = GetIndex(PLAYER, "")
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 510 and talk_id == 1 then
    DotTalk(10000, 377, 15, 4051010, 0, 0, 30)
  end
  if gMapNum == 511 and talk_id == 1 then
    DotTalk(10000, 474, 25, 4051110, 0, 0, 35)
  end
  if gMapNum == 512 and talk_id == 1 then
    DotTalk(10000, 149, 40, 4051210, PERSONAL_KISAKU, 0, 50)
  end
  if gMapNum == 513 and talk_id == 1 then
    DotTalk(10000, 197, 60, 4051310, PERSONAL_HOUYO, 0, 100)
  end
  if gMapNum == 520 then
    if npc_name == "OP_Marus" then
      require("S900_217")
      S900_217:Event_040()
    end
    if npc_name == "OP_Neptune" then
      require("S900_217")
      S900_217:Event_050()
    end
    if npc_name == "OP_Meruki" then
      require("S900_217")
      S900_217:Event_060()
    end
    if npc_name == "OP_Minerva" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      require("S900_217")
      S900_217:Event_070()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "OP_Juno" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      require("S900_217")
      S900_217:Event_080()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "OP_Apollo" then
      require("S900_217")
      S900_217:Event_100()
    end
    if npc_name == "OP_Diana" then
      require("S900_217")
      S900_217:Event_110()
    end
    if npc_name == "OP_Venus" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      require("S900_217")
      S900_217:Event_120()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "OP_Vulcanus" then
      require("S900_217")
      S900_217:Event_130()
    end
    if npc_name == "OP_Bacchus" then
      require("S900_217")
      S900_217:Event_140()
    end
    if npc_name == "OP_Jupiter" then
      require("S900_217")
      S900_217:Event_150()
    end
  end
end
