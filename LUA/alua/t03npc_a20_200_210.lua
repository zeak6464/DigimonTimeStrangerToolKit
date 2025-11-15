function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 301 then
  elseif gMapNum == 302 then
    if npc_name == "npc_0500" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      require("S010_003")
      S010_003:Event_010()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if npc_name == "npc_0501" then
      if Flg.Check("FLAG_S003_001") then
        require("S010_003")
        S010_003:Event_020()
      else
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_t0302_0050_0010")
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc_0600" then
      M210:Event_180()
    end
  elseif gMapNum == 303 then
  end
end
