function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 1101 then
    if talk_id == 700 then
      M210:Event_080()
      M210:Event_060()
    end
    if talk_id == 703 then
      local fldtxt = "d11"
      local e012 = Motion.Object:new(NPC, "npc_0708", "e012")
      local e002 = Motion.Object:new(NPC, "npc_0708", "e002")
      local e006 = Motion.Object:new(NPC, "npc_0708", "e006")
      if Flg.Check("FLAG_MAIN_07_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e002:Play(5, true)
        Message("f_d1101_0170_0030")
        e006:Play(5, true)
        Message("f_d1101_0170_0040")
        MessageClose()
        WaitFrame(30)
        e002:Play(8, true)
        Message("f_d1101_0170_0050")
        e012:Play(8, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1101_0170_0010")
        Message("f_d1101_0170_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
  elseif gMapNum == 1102 then
    if npc_name == "koan_0001" then
      local fldtxt = "d11"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1102_0100_0020")
      Message("f_d1102_0100_0030")
      Message("f_d1102_0100_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "koan_0003" then
      local fldtxt = "d11"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1102_0120_0070")
      Message("f_d1102_0120_0080")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 1103 then
  elseif gMapNum == 1104 and npc_name == "npc_001" then
    local fldtxt = "d11"
    START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Message("f_d1104_0010_0010")
    Field.EndPlayerAndNpcTalkAction(npc_name)
    Message("f_d1104_0010_0020")
    Message("f_d1104_0010_0030")
    Field.StartPlayerAndNpcTalkAction(npc_name)
    Message("f_d1104_0010_0040")
    Field_Talk_End_Not_LetterBox()
    END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
  end
end
