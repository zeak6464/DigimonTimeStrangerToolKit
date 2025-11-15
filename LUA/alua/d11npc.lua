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
    if talk_id == 304 then
      local fldtxt = "d11"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "hiroko_2"), "F01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1102_0020_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "hiroko_2"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 312 then
      require("S010_003")
      S010_003:Event_050()
    end
    if npc_name == "koan_0001" then
      local fldtxt = "d11"
      local asuna_index = GetIndex(NPC, "koan_0001")
      Field.ObjectLoadExpression(NPC, asuna_index, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1102_0100_0020")
      Message("f_d1102_0100_0030")
      Message("f_d1102_0100_0040")
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "koan_0003" then
      local fldtxt = "d11"
      local asuna_index = GetIndex(NPC, "koan_0001")
      Field.ObjectLoadExpression(NPC, asuna_index, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1102_0120_0070")
      Message("f_d1102_0120_0080")
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "blacktail_0001" then
      local fldtxt = "d11"
      local asuna_index = GetIndex(NPC, "koan_0001")
      local tail_index = GetIndex(NPC, "blacktail_0001")
      local t_bn01 = Motion.Object:new(NPC, "blacktail_0001", "bn01")
      local t_fe04 = Motion.Object:new(NPC, "blacktail_0001", "fe04")
      local t_fe02 = Motion.Object:new(NPC, "blacktail_0001", "fe02")
      local t_fq01 = Motion.Object:new(NPC, "blacktail_0001", "fq01")
      Field.ObjectLoadExpression(NPC, asuna_index, "F01")
      Cam.Inst:Set(56.03, -0.45, -37.42, 46.47, 1.95, -39.1, default, 30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectLookAtTheObject(NPC, asuna_index, NPC, tail_index, 15, 10)
      Message("f_d1102_0100_0090")
      Message("f_d1102_0100_0100")
      MessageClose()
      t_fe02:PlayWithStartMoveMotion(15, 15)
      WaitFrame(60)
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      Cam.Inst:Clear(30)
      Field.ObjectResetAim(NPC, asuna_index, 30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "blacktail_0004" then
      local fldtxt = "d11"
      local asuna_index = GetIndex(NPC, "koan_0003")
      Field.ObjectLoadExpression(NPC, asuna_index, "F01")
      Cam.Inst:Set(55.784, 0.15, -42.75, 46.66, 1.61, -38.91, default, 30)
      START_TALK_ACTION_AND_ZOOM("koan_0003", true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1102_0190_0010")
      Message("f_d1102_0190_0020")
      Message("f_d1102_0190_0030")
      Field.ObjectChangeExpression(NPC, asuna_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM("koan_0003", true, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 1103 then
    if not (talk_id == 300 and Quest.CheckFlag(1204, 12)) or not Quest.CheckFlag(1204, 13) then
    end
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
