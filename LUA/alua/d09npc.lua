function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 900 then
    if npc_name == "npc0000" then
      M440:Event_505()
      M440:Event_500()
    end
    if npc_name == "npc0001" then
      local fldtxt = "d09"
      local e005 = Motion.Object:new(NPC, "npc0001", "e005")
      local bn01 = Motion.Object:new(NPC, "npc0001", "bn01")
      local npc_0001 = GetIndex(NPC, "npc0001")
      Cam.Inst:Set(-0.959, 4.972, 52.5, -2.71, 3.798, 42.73, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e005:Play(20, false)
      Message("f_d0900_0090_0010")
      bn01:Play(20, true)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc0002" then
      local fldtxt = "d09"
      local e005 = Motion.Object:new(NPC, "npc0002", "e005")
      local fn01_01 = Motion.Object:new(NPC, "npc0002", "fn01_01")
      local npc_0002 = GetIndex(NPC, "npc0002")
      Cam.Inst:Set(-4.345, 4.372, 53.93, -9.74, 4.582, 45.51, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, npc_0002, "F01", EYES_BLINK_TYPE_CLOSE, false, 10)
      e005:Play(20, true)
      Message("f_d0900_0100_0010")
      fn01_01:Play(20, true)
      Field_Talk_End_Not_LetterBox()
      Field.ObjectClearExpression(NPC, npc_0002, 10)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc0003" then
      local fldtxt = "d09"
      local npc_0004 = Obj:new(NPC, "npc0004")
      local npc_index01 = GetIndex(NPC, "npc0004")
      local fq01 = Motion.Object:new(NPC, "npc0004", "fq01")
      local bn01 = Motion.Object:new(NPC, "npc0004", "bn01")
      local npc_index02 = GetIndex(NPC, "npc0003")
      local e007 = Motion.Object:new(NPC, "npc0003", "e007")
      local e005 = Motion.Object:new(NPC, "npc0003", "e005")
      Field.ObjectLoadMotionBlend(NPC, npc_index02, "blend02")
      Field.ObjectLoadExpression(NPC, npc_index02, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectLookAtTheObject(NPC, npc_index02, PLAYER, 1, 30)
      Field.ObjectPlayMotionBlend(NPC, npc_index02, "blend02", 10, false)
      Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d0900_0060_0010")
      Field.ObjectEndPlayingMotionBlend(NPC, npc_index02)
      Field.ObjectPlayMotion(NPC, npc_index02, "e007", 10, true)
      Message("f_d0900_0060_0020")
      Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "fq01", 10, true)
      Message("f_d0900_0060_0030")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Field.ObjectPlayMotionBlend(NPC, npc_index02, "blend02", 10, false)
      Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d0900_0060_0040")
      Field.ObjectEndPlayingMotionBlend(NPC, npc_index02)
      Field.ObjectPlayMotion(NPC, npc_index02, "e005", 10, true)
      Message("f_d0900_0060_0050")
      Field.ObjectResetExpression(NPC, npc_index01, 10)
      Field.ObjectResetExpression(NPC, npc_index02, 10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  end
  if gMapNum == 901 then
    if npc_name == "npc0007" then
      M440:Event_540()
    end
    if npc_name == "npc0009" then
      local fldtxt = "d09"
      Cam.Inst:Set(-36.59, -12.8, -63.5, -27.63, -16.8, -61.54, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0901_0070_0040")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0003" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0901_0100_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0004" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0901_0100_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0005" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0901_0100_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0006" then
      M440:Event_530()
    end
    if npc_name == "npc0011" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0901_0110_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
  end
  if gMapNum == 902 then
    if npc_name == "npc0011" then
      M440:Event_605()
    end
    if npc_name == "npc0007" then
      local ba01 = Motion.Object:new(NPC, "npc0007", "ba01")
      local bn01 = Motion.Object:new(NPC, "npc0007", "bn01")
      local bn02 = Motion.Object:new(NPC, "npc0007", "bn02")
      local geko_index = GetIndex(NPC, "npc0007")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      bn02:Play(20, true)
      Message("f_d0902_0040_0010")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
      Message("f_d0902_0040_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
  end
  if npc_name == "npc0013" then
    local fldtxt = "d09"
    START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Message("f_d0902_0090_0010")
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_End_Not_LetterBox()
  end
  if npc_name == "npc0014" then
    local fldtxt = "d09"
    Cam.Inst:Set(3.158, 10.498, -9.979, 3.865, 8.364, -0.234, default, 45)
    START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    WaitFrame(45)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Message("f_d0902_0100_0010")
    Cam.Inst:Clear(30)
    END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    Field_Talk_End_Not_LetterBox()
  end
  if gMapNum == 903 then
    if npc_name == "npc0001" then
      local npc_index01 = GetIndex(NPC, "npc0001")
      local e004 = Motion.Object:new(NPC, "npc0001", "e004")
      local e008 = Motion.Object:new(NPC, "npc0001", "e008")
      local e005 = Motion.Object:new(NPC, "npc0001", "e005")
      local bn01 = Motion.Object:new(NPC, "npc0001", "bn01")
      local fldtxt = "d09"
      if Flg.Check("FLAG_MAIN_22_276") then
        Cam.Inst:Set(26.516, 3.511, -16.264, 17.746, 0.107, -12.875, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e008:Play(15, true)
        Message("f_d0903_0300_0010")
        bn01:Play(10, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Clear(30)
      elseif Flg.Check("FLAG_MAIN_22_275") then
        Cam.Inst:Set(26.516, 3.511, -16.264, 17.746, 0.107, -12.875, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e005:Play(15, true)
        Message("f_d0903_0300_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        bn01:Play(10, true)
        Cam.Inst:Clear(30)
      elseif Flg.Check("FLAG_MAIN_22_284") then
        M440:Event_680()
      elseif Flg.Check("FLAG_MAIN_22_225") then
        Cam.Inst:Set(26.516, 3.511, -16.264, 17.746, 0.107, -12.875, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e005:Play(15, true)
        Message("f_d0903_0230_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        bn01:Play(10, true)
        Cam.Inst:Clear(30)
      elseif Flg.Check("FLAG_MAIN_22_261") then
        M440:Event_660()
      elseif Flg.Check("FLAG_MAIN_22_250") then
        Cam.Inst:Set(26.516, 3.511, -16.264, 17.746, 0.107, -12.875, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e005:Play(15, true)
        Message("f_d0903_0180_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        bn01:Play(10, true)
        Cam.Inst:Clear(30)
      elseif Flg.Check("FLAG_MAIN_22_240") then
        M440:Event_640()
      elseif Flg.Check("FLAG_MAIN_22_221") then
        Cam.Inst:Set(26.516, 3.511, -16.264, 17.746, 0.107, -12.875, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e004:Play(15, true)
        Message("f_d0903_0120_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        bn01:Play(10, true)
        Cam.Inst:Clear(30)
      elseif Flg.Check("FLAG_MAIN_22_212") then
        Cam.Inst:Set(26.516, 3.511, -16.264, 17.746, 0.107, -12.875, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e004:Play(15, true)
        Message("f_d0903_0120_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        bn01:Play(15, true)
        Cam.Inst:Clear(30)
      else
        Cam.Inst:Set(26.516, 3.511, -16.264, 17.746, 0.107, -12.875, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e004:Play(15, true)
        Message("f_d0903_0120_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        bn01:Play(15, true)
        Cam.Inst:Clear(30)
      end
    end
    if npc_name == "npc0004" then
      M440:Event_700()
    end
    if npc_name == "npc0006" then
      local fldtxt = "d09"
      if Flg.Check("FLAG_MAIN_22_276") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0310_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_22_275") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0310_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_22_225") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0240_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_22_223") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0190_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0130_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc0015" then
      local fldtxt = "d09"
      if Flg.Check("FLAG_MAIN_22_276") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0320_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_22_275") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0320_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_22_225") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0250_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_22_223") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0200_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0903_0140_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc0021" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0160_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0022" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0150_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0051" then
      local fldtxt = "d09"
      local e022 = Motion.Object:new(NPC, "npc0051", "e022")
      local e013 = Motion.Object:new(NPC, "npc0051", "e013")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e022:Play(10, true)
      Message("f_d0903_0160_0020")
      e013:Play(10, true)
      Message("f_d0903_0160_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0052" then
      local fldtxt = "d09"
      local e004 = Motion.Object:new(NPC, "npc0052", "e004")
      local e002 = Motion.Object:new(NPC, "npc0052", "e002")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(10, true)
      Message("f_d0903_0150_0020")
      e004:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0027" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0210_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0028" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0220_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0031" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0260_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0030" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0270_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0050" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0280_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0055" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0903_0290_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0014" then
      local tlk = Tlk:new("d09", 1, true)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      tlk:StartTalk()
      tlk:Message("f_d0900_0050_0010")
      local result = tlk:Select(2, "f_d0900_0050_0020")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        MapChange("d", 1204, "start_23", true, FADE_BLACK, FADE_TIME)
      elseif result == RESULT_TALK01 then
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
  end
  if gMapNum == 904 then
    if npc_name == "npc0004" then
      local npc01_index = GetIndex(NPC, "npc0004")
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe04")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0904_0420_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fe04", 10, true)
      Message("f_d0904_0420_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0010" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0904_0430_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0049" then
      local fldtxt = "d09"
      local e002 = Motion.Object:new(NPC, "npc0049", "e002")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(20, true)
      Message("f_d0904_0440_0010")
      Message("f_d0904_0440_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0073" then
      local fldtxt = "d09"
      local npc01_index = GetIndex(NPC, "npc0073")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe04")
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      local npc02_index = GetIndex(NPC, "npc0042")
      Field.ObjectLoadMotion(NPC, npc02_index, "fe02")
      Field.ObjectLoadMotion(NPC, npc02_index, "bn01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fe04", 10, true)
      Message("f_d0904_0450_0010")
      Field.ObjectPlayMotion(NPC, npc02_index, "fe02", 10, true)
      Message("f_d0904_0450_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      Field.ObjectPlayMotion(NPC, npc02_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0039" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0904_0460_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0011" then
      local fldtxt = "d09"
      local fq01 = Motion.Object:new(NPC, "npc0011", "fq01")
      local bn01 = Motion.Object:new(NPC, "npc0011", "bn01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq01:Play(20, false)
      Message("f_d0904_0470_0010")
      bn01:Play(20, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0037" then
      local fldtxt = "d09"
      local fq01 = Motion.Object:new(NPC, "npc0037", "fq01")
      local bn01 = Motion.Object:new(NPC, "npc0037", "bn01")
      Cam.Inst:Set(29.1, 4.046, 5.18, 28.75, 1.887, -4.577, default, 30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq01:Play(20, true)
      Message("f_d0904_0480_0010")
      bn01:Play(20, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0060" then
      local fldtxt = "d09"
      Cam.Inst:Set(39.34, 3.743, 1.177, 31.23, 1.246, -4.114, default, 30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0904_0490_0010")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0040" or npc_name == "npc0041" then
      local fldtxt = "d09"
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fe02", 10, true)
      Message("f_d0904_0500_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0021" then
      local fldtxt = "d09"
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0904_0510_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0019" then
      local fldtxt = "d09"
      Cam.Inst:Set(39.144, 4.102, -14.238, 29.468, 1.766, -15.191, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe04")
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fe01", 10, true)
      Message("f_d0904_0520_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fe04", 10, true)
      Message("f_d0904_0520_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      WaitFrame(15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
      WaitFrame(15)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0015" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0904_0530_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0050" then
      local fldtxt = "d09"
      local fq01 = Motion.Object:new(NPC, "npc0050", "fq01")
      local bn01 = Motion.Object:new(NPC, "npc0050", "bn01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq01:Play(20, true)
      Message("f_d0904_0550_0010")
      bn01:Play(20, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0051" then
      local fldtxt = "d09"
      local fq01 = Motion.Object:new(NPC, "npc0051", "fq01")
      local bn01 = Motion.Object:new(NPC, "npc0051", "bn01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq01:Play(20, true)
      Message("f_d0904_0540_0010")
      bn01:Play(20, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0055" then
      local fldtxt = "d09"
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Cam.Inst:Set(-18.802, 10.979, -30.456, -28.091, 7.782, -32.326, default, 30)
      WaitFrame(45)
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0904_0560_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fe04", 10, true)
      Message("f_d0904_0560_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      WaitFrame(15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
      WaitFrame(15)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0058" then
      local fldtxt = "d09"
      local fq01 = Motion.Object:new(NPC, "npc0058", "fq01")
      local bn01 = Motion.Object:new(NPC, "npc0058", "bn01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq01:Play(20, true)
      Message("f_d0904_0570_0010")
      Message("f_d0904_0570_0020")
      bn01:Play(20, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0059" then
      local fldtxt = "d09"
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fe02", 10, true)
      Message("f_d0904_0580_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0063" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0904_0590_0010")
      Message("f_d0904_0590_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0072" then
      local fldtxt = "d09"
      Cam.Inst:Set(-23.729, 6.41, -37.105, -30.265, 3.294, -30.208, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0904_0600_0010")
      Message("f_d0904_0600_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      WaitFrame(15)
    end
  end
  if gMapNum == 905 then
    if npc_name == "npc0001" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe04")
      Field.ObjectLoadMotion(NPC, npc01_index, "e012")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fe04", 10, true)
      Message("f_d0905_0100_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "e012", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0002" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe02")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq02")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fe02", 10, true)
      Message("f_d0905_0120_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0905_0120_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "fq02", 10, true)
      Message("f_d0905_0120_0030")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0003" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe02")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq02")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0905_0130_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fe02", 10, true)
      Message("f_d0905_0130_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0905_0130_0030")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0004" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "e002")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
      Message("f_d0905_0110_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0905_0110_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0009" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0905_0160_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0010" then
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0905_0170_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0011" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "e013")
      Field.ObjectLoadMotion(NPC, npc01_index, "fe04")
      Field.ObjectLoadMotion(NPC, npc01_index, "e012")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "e013", 10, true)
      Message("f_d0905_0140_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fe04", 10, true)
      Message("f_d0905_0140_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "e012", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc0012" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      Field.ObjectLoadMotion(NPC, npc01_index, "e002")
      local fldtxt = "d09"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
      Message("f_d0905_0150_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "fq01", 10, true)
      Message("f_d0905_0150_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "bn01", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
  end
  if gMapNum == 906 then
    if npc_name == "npc_0009" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq01")
      Field.ObjectLoadMotion(NPC, npc01_index, "fq02")
      Field.ObjectLoadMotion(NPC, npc01_index, "e013")
      Field.ObjectLoadMotion(NPC, npc01_index, "e007")
      Field.ObjectLoadMotion(NPC, npc01_index, "e002")
      local tlk = Tlk:new("d09", 1, true)
      tlk:StartTalk()
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
      tlk:Message("f_d0906_0110_0010")
      tlk:Message("f_d0906_0110_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "e013", 10, true)
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if npc_name == "npc_0007" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "e002")
      Field.ObjectLoadMotion(NPC, npc01_index, "e004")
      Field.ObjectLoadMotion(NPC, npc01_index, "e013")
      local tlk = Tlk:new("d09", 1, true)
      tlk:StartTalk()
      Cam.Inst:Set(-9.287, 5.938, 3.882, -6.117, 5.999, -5.601, default, 30)
      WaitFrame(45)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e002", 10, 10)
      tlk:Message("f_d0906_0120_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "e004", 10, true)
      tlk:Message("f_d0906_0120_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "e013", 10, true)
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      WaitFrame(30)
    end
    if npc_name == "npc_0008" then
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc01_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc01_index, "e002")
      Field.ObjectLoadMotion(NPC, npc01_index, "e004")
      Field.ObjectLoadMotion(NPC, npc01_index, "e013")
      local tlk = Tlk:new("d09", 1, true)
      tlk:StartTalk()
      Cam.Inst:Set(9.451, 5.288, 4.433, 3.51, 5.349, -3.609, default, 30)
      WaitFrame(45)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e002", 10, 10)
      tlk:Message("f_d0906_0130_0010")
      Field.ObjectPlayMotion(NPC, npc01_index, "e004", 10, true)
      tlk:Message("f_d0906_0130_0020")
      Field.ObjectPlayMotion(NPC, npc01_index, "e013", 10, true)
      tlk:EndTalk()
      Cam.Inst:Clear(30)
      WaitFrame(30)
    end
  end
  if gMapNum == 907 then
    if npc_name == "npc_0012" then
      local npc_index01 = GetIndex(NPC, "npc_0012")
      local player_index = GetIndex(PLAYER, "")
      local npc_0012 = Obj:new(NPC, "npc_0012")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e002")
      Field.ObjectLoadMotion(NPC, npc_index01, "e005")
      Field.ObjectLoadMotion(NPC, npc_index01, "e007")
      PlayerTurnToObject(NPC, "npc_0012", true, false, 0, 0)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "br01", 10, true)
      npc_0012:SetRotationYToPlayer(15)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Cam.Inst:Set(59.16, 2.4, -5.489, 56.28, 1.969, 4.076, default, 30)
      START_PlAYER_AND_NPC_TALK_ACTION(npc_name)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "e002", 10, true)
      Message("f_d0907_0090_0010")
      Message("f_d0907_0090_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e005", 10, true)
      Message("f_d0907_0090_0030")
      Field.ObjectPlayMotion(NPC, npc_index01, "e007", 10, true)
      Message("f_d0907_0090_0040")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "br01", 10, true)
      ObjectResetRotation(FLD_OBJ_NPC, npc_index01, 15, true)
      Cam.Inst:Clear(30)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      WaitFrame(15)
      END_PLAYER_AND_NPC_TALK_ACTION(npc_name)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0005" then
      local npc_index01 = GetIndex(NPC, "npc_0005")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e002")
      Field.ObjectLoadMotion(NPC, npc_index01, "e012")
      local npc_index02 = GetIndex(NPC, "npc_0008")
      Field.ObjectLoadMotion(NPC, npc_index02, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index02, "br01")
      Field.ObjectLoadMotion(NPC, npc_index02, "e100")
      Field.ObjectLoadMotion(NPC, npc_index02, "e104")
      PlayerTurnToObject(NPC, "npc_0005", true, false, 0, 0)
      Cam.Inst:Set(46.91, 3.702, -7.223, 43.67, 1.221, 1.905, default, 30)
      Field.ObjectLookAtTheObject(NPC, npc_index01, NPC, npc_index02, 30, 2)
      Field.ObjectLookAtTheObject(NPC, npc_index02, NPC, npc_index01, 30, 2)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "e002", 10, true)
      Message("f_d0907_0080_0010")
      Message("f_d0907_0080_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e012", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "e104", 10, true)
      Message("f_d0907_0080_0030")
      Message("f_d0907_0080_0040")
      Message("f_d0907_0080_0050")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index02, "e100", 10, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0002" then
      local npc_index01 = GetIndex(NPC, "npc_0002")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e005")
      Field.ObjectLoadMotion(NPC, npc_index01, "e007")
      local npc_index02 = GetIndex(NPC, "npc_0001")
      Field.ObjectLoadMotion(NPC, npc_index02, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index02, "br01")
      Field.ObjectLoadMotion(NPC, npc_index02, "e008")
      Field.ObjectLoadMotion(NPC, npc_index02, "e013")
      local aporo_e008 = Motion.Object:new(NPC, "npc_0001", "e008")
      local aporo_e013 = Motion.Object:new(NPC, "npc_0001", "e013")
      local diana_e005 = Motion.Object:new(NPC, "npc_0002", "e005")
      local diana_e007 = Motion.Object:new(NPC, "npc_0002", "e007")
      PlayerTurnToObject(NPC, "npc_0002", true, false, 0, 0)
      Cam.Inst:Set(33.38, 2.9, -4.672, 34.86, 1.402, 5.102, default, 30)
      Field.ObjectLookAtTheObject(NPC, npc_index02, PLAYER, 1, 30, 2)
      START_PlAYER_AND_NPC_TALK_ACTION(npc_name)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Message("f_d0907_0060_0010")
      Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      Message("f_d0907_0060_0020")
      Field.ObjectPlayMotion(NPC, npc_index02, "e008", 10, true)
      Message("f_d0907_0060_0030")
      Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, false, 10)
      Field.ObjectPlayMotion(NPC, npc_index01, "e005", 10, true)
      Message("f_d0907_0060_0040")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "e007", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "e013", 10, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      END_PLAYER_AND_NPC_TALK_ACTION(npc_name)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0011" then
      local npc_index01 = GetIndex(NPC, "npc_0011")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e002")
      Field.ObjectLoadMotion(NPC, npc_index01, "e004")
      Field.ObjectLoadMotion(NPC, npc_index01, "e005")
      Field.ObjectLoadMotion(NPC, npc_index01, "e012")
      PlayerTurnToObject(NPC, "npc_0011", true, false, 0, 0)
      Cam.Inst:Set(17.38, 3.509, -5.958, 18.86, 1.589, 3.744, default, 30)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "e002", 10, true)
      Message("f_d0907_0050_0010")
      Message("f_d0907_0050_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e005", 10, true)
      Message("f_d0907_0050_0030")
      Field.ObjectPlayMotion(NPC, npc_index01, "e004", 10, true)
      Message("f_d0907_0050_0040")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "e012", 10, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0010" then
      local npc_index01 = GetIndex(NPC, "npc_0010")
      local npc_0010 = Obj:new(NPC, "npc_0010")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e004")
      PlayerTurnToObject(NPC, "npc_0010", true, false, 0, 0)
      Field.ObjectPlayMotion(NPC, npc_index01, "br01", 10, true)
      npc_0010:SetRotationYToPlayer(15)
      Cam.Inst:Set(-2.062, 0.879, -7.101, -4.588, 2.136, 2.492, default, 30)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      WaitFrame(15)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      START_PlAYER_AND_NPC_TALK_ACTION(npc_name)
      Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_CLOSE, false, 30)
      Message("f_d0907_0040_0010")
      Message("f_d0907_0040_0020")
      Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, false, 30)
      Field.ObjectPlayMotion(NPC, npc_index01, "e004", 10, true)
      Message("f_d0907_0040_0030")
      MessageClose()
      END_PLAYER_AND_NPC_TALK_ACTION(npc_name)
      Field.ObjectPlayMotion(NPC, npc_index01, "br01", 10, true)
      ObjectResetRotation(FLD_OBJ_NPC, npc_index01, 15, true)
      Cam.Inst:Clear(30)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      WaitFrame(15)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0003" then
      local npc_0003 = Obj:new(NPC, "npc_0003")
      local npc_index01 = GetIndex(NPC, "npc_0003")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e002")
      Field.ObjectLoadMotion(NPC, npc_index01, "e007")
      Field.ObjectLoadMotion(NPC, npc_index01, "e008")
      PlayerTurnToObject(NPC, "npc_0003", true, false, 0, 0)
      npc_0003:SetRotationYToPlayer(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "br01", 10, true)
      Cam.Inst:Set(-5.197, 1.25, -7.096, -7.345, 1.564, 2.664, default, 30)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      WaitFrame(15)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      START_PlAYER_AND_NPC_TALK_ACTION(npc_name)
      Field.ObjectPlayMotion(NPC, npc_index01, "e008", 10, true)
      Message("f_d0907_0020_0010")
      Message("f_d0907_0020_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e007", 10, true)
      Message("f_d0907_0020_0030")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "e002", 10, true)
      END_PLAYER_AND_NPC_TALK_ACTION(npc_name)
      ObjectResetRotation(FLD_OBJ_NPC, npc_index01, 15, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0006" then
    end
    if npc_name == "npc_0007" then
    end
    if npc_name == "npc_0009" then
      local npc_index01 = GetIndex(NPC, "npc_0009")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e008")
      Field.ObjectLoadMotion(NPC, npc_index01, "e010")
      Field.ObjectLoadMotion(NPC, npc_index01, "e013")
      Field.ObjectLoadMotion(NPC, npc_index01, "e021")
      PlayerTurnToObject(NPC, "npc_0009", true, false, 0, 0)
      Cam.Inst:Set(28.05, 2.974, -5.465, 24.76, 0.517, 3.651, default, 30)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 30, 2)
      Field.ObjectDisableCulling(FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_0009"))
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Message("f_d0907_0070_0010")
      Field.ObjectPlayMotion(NPC, npc_index01, "e021", 10, true)
      Message("f_d0907_0070_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e010", 10, true)
      Message("f_d0907_0070_0030")
      Field.ObjectPlayMotion(NPC, npc_index01, "e008", 10, true)
      Message("f_d0907_0070_0040")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "e013", 10, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
    end
    if npc_name == "npc_0014" then
    end
    if npc_name == "npc_0013" then
    end
  end
end
