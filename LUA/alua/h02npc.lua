function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  local player_index = GetIndex(PLAYER, "")
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 201 then
  end
  if gMapNum == 210 and talk_id == 1 then
    DotTalk(10000, 590, 15, 4021010, 0, 0, 30)
  end
  if gMapNum == 211 and talk_id == 1 then
    DotTalk(10000, 375, 25, 4021110, PERSONAL_HIYORIMI, 0, 35)
  end
  if gMapNum == 212 and talk_id == 1 then
    DotTalk(10000, 21, 30, 4021210, 0, 0, 40)
  end
  if gMapNum == 213 and talk_id == 1 then
    DotTalk(10000, 310, 60, 4021310, 0, 0, 100)
  end
  if gMapNum == 220 and talk_id == 2 then
    local fldtxt = "h02"
    local npc_004_bn01 = Motion.Object:new(NPC, "npc_004", "bn01")
    local npc_004_fe02 = Motion.Object:new(NPC, "npc_004", "fe02")
    START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Message("f_h0220_0010_0010")
    MessageClose()
    MessageTalkSel(2, "f_h0220_0010_0020")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Restore.PartyWithInfoWindow()
      npc_004_fe02:Play(10, true)
      Message("f_h0220_0010_0030")
      npc_004_bn01:Play(10, true)
    elseif result == RESULT_TALK01 then
    end
    Field_Talk_End_Not_LetterBox()
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  end
  if gMapNum == 221 and talk_id == 2 then
    local fldtxt = "h02"
    local npc_004_bn01 = Motion.Object:new(NPC, "npc_004", "bn01")
    local npc_004_fe02 = Motion.Object:new(NPC, "npc_004", "fe02")
    START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Message("f_h0220_0010_0010")
    MessageClose()
    MessageTalkSel(2, "f_h0220_0010_0020")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Restore.PartyWithInfoWindow()
      npc_004_fe02:Play(10, true)
      Message("f_h0220_0010_0030")
      npc_004_bn01:Play(10, true)
    elseif result == RESULT_TALK01 then
    end
    Field_Talk_End_Not_LetterBox()
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  end
  if gMapNum == 222 and talk_id == 2 then
    local fldtxt = "h02"
    local npc_004_bn01 = Motion.Object:new(NPC, "npc_004", "bn01")
    local npc_004_fe02 = Motion.Object:new(NPC, "npc_004", "fe02")
    START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Message("f_h0220_0010_0010")
    MessageClose()
    MessageTalkSel(2, "f_h0220_0010_0020")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Restore.PartyWithInfoWindow()
      npc_004_fe02:Play(10, true)
      Message("f_h0220_0010_0030")
      npc_004_bn01:Play(10, true)
    elseif result == RESULT_TALK01 then
    end
    Field_Talk_End_Not_LetterBox()
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  end
end
