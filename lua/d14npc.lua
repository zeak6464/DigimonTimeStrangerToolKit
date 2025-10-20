function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 1401 then
  end
  if gMapNum == 1403 then
    if npc_name == "rumor_d1403_piyomon01" then
      Flg.Set("FLAG_MAIN_01_230")
      M020:Event_300()
    end
  elseif gMapNum == 1405 then
    local npc_0001_fq01 = Motion.Object:new(NPC, "npc_0001", "fq01")
    local npc_0001_fe03 = Motion.Object:new(NPC, "npc_0001", "fe03")
    if talk_id == 1 then
      local tlk = Tlk:new("d1405")
      local fldtxt = "d14"
      tlk:StartTalkActionAndZoom("npc_0001")
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0001_fq01:Play(10, true)
      tlk:Message("f_d1405_0010_0010")
      npc_0001_fe03:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      tlk:EndTalkActionAndZoom()
    end
    if npc_name == "npc_0002" then
      local tlk = Tlk:new("d14", 1, true)
      local npc_index = GetIndex(NPC, npc_name)
      local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
      local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
      Field.ObjectLoadMotion(PLAYER, 1, "e202")
      Field.ObjectLoadMotion(PLAYER, 1, "fg09_out01")
      tlk:StartTalk()
      Field.ObjectPlayMotion(FLD_OBJ_PLAYER, 1, "e202", 5, true)
      WaitFrame(30)
      tlk:Message("f_d1405_0050_0010")
      tlk:EndTalk()
      Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "fg09_out01", 15, 15)
      WaitFrame(15)
    end
    if npc_name == "npc_0003" then
      local tlk = Tlk:new("d14", 1, true)
      local npc_index = GetIndex(NPC, npc_name)
      local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
      local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
      Field.ObjectLoadMotion(PLAYER, 1, "e202")
      tlk:StartTalk()
      Field.ObjectPlayMotion(FLD_OBJ_PLAYER, 1, "e202", 5, true)
      Field.ObjectLoadMotion(PLAYER, 1, "fg09_out01")
      WaitFrame(30)
      tlk:Message("f_d1405_0060_0010")
      tlk:EndTalk()
      Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "fg09_out01", 15, 15)
      WaitFrame(15)
    end
    if npc_name == "npc_0004" then
      local tlk = Tlk:new("d14", 1, true)
      local npc_index = GetIndex(NPC, npc_name)
      local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
      local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
      Field.ObjectLoadMotion(PLAYER, 1, "e202")
      tlk:StartTalk()
      Field.ObjectPlayMotion(FLD_OBJ_PLAYER, 1, "e202", 5, true)
      Field.ObjectLoadMotion(PLAYER, 1, "fg09_out01")
      WaitFrame(30)
      tlk:Message("f_d1405_0070_0010")
      tlk:EndTalk()
      Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "fg09_out01", 15, 15)
      WaitFrame(15)
    end
  elseif gMapNum == 1406 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message(1000)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End()
    elseif talk_id == 301 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message(1100)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End()
    end
  end
end
