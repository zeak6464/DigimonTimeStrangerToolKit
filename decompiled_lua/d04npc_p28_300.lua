gGimText = "field_text"

function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 401 then
    if talk_id == 200 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0080_0010")
      Message("f_d0401_0080_0020")
      Message("f_d0401_0080_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 201 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(-41.62772, -21.070126, 5.027689, -33.179218, -24.758684, 8.902908, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0090_0010")
      Message("f_d0401_0090_0020")
      Message("f_d0401_0090_0030")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 202 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0100_0010")
      Message("f_d0401_0100_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 203 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0110_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 205 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0120_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 206 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0130_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 207 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0140_0010")
      Message("f_d0401_0140_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_001" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0401_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1401, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0401_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0401_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0401_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "s040_032_002" then
      require("S040_032")
      S040_032:Event_015()
      S040_032:Event_010()
    end
    if npc_name == "s040_033_002" then
      require("S040_033")
      S040_033:Event_020()
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD04(npc_name)
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before_P300(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After_P300(npc_name)
    end
  elseif gMapNum == 402 then
    if npc_name == "npc_016" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0402_0060_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_017" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0402_0070_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_018" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0402_0080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s040_033_001" then
      require("S040_033")
      S040_033:Event_010()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before_P300(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After_P300(npc_name)
    end
  end
  if gMapNum == 403 then
    if npc_name == "npc_003" then
      local fldtxt = "d04"
      local fq01 = Motion.Object:new(NPC, "npc_003", "fq01")
      local fe02 = Motion.Object:new(NPC, "npc_003", "fe02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0403_0060_0010")
      fq01:Play(20, true)
      Message("f_d0403_0060_0020")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_003"), 30)
      Message("f_d0403_0060_0030")
      fe02:Play(20, true)
      Message("f_d0403_0060_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_003"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_004" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0403_0050_0010")
      Message("f_d0403_0050_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s040_033_001" or npc_name == "s040_033_002" then
      require("S040_033")
      S040_033:Event_060()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before_P300(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After_P300(npc_name)
    end
  end
  if gMapNum == 404 then
    if npc_name == "bacchus_01" then
      M300:Event_050()
      M300:Event_200()
    end
    if talk_id == 228 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0210_0010")
      Message("f_d0404_0210_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_warp01" then
      local npc01_index = GetIndex(NPC, npc_name)
      local pos = Field.ObjectGetPosition(NPC, npc01_index)
      local rot = Field.ObjectGetRotationY(NPC, npc01_index)
      local vector2d = Field.GetUnitVector2D(rot)
      local cam_x = pos.x + vector2d.x * 5
      local cam_y = pos.y
      local cam_z = pos.z + vector2d.z * 5
      Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
      PlayerLookAtObject(NPC, npc_name)
      local tlk = Tlk:new("d01", 1, false)
      local ba01 = Motion.Object:new(NPC, "npc_warp01", "ba01")
      tlk:StartTalk()
      tlk:Message("f_d0107_0100_0010")
      local result = tlk:Select(2, "f_d0107_0100_0020")
      if result == RESULT_TALK00 then
        tlk:Message("f_d0107_0100_0030")
        ba01:Play(20, false)
        tlk:EndTalk()
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        WaitFrame(20)
        local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
        WaitFrame(5)
        PlayEffectScript("ef_f_mov_111_wa", player_pos.x, player_pos.y + 1, player_pos.z, 0, 1)
        PlaySE(200006, 100)
        WaitFrame(15)
        Obj:new(PLAYER, ""):Invisible(5)
        WaitFrame(15)
        Flg.Set("FLAG_MAIN_10_059")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        if Common.CheckTimeAxis("A2020_dbef_190", "A2020_dbef_199") then
          MapChange("d", 401, "start_00", true, FADE_WHITE, FADE_TIME)
        elseif Common.CheckTimeAxis("A2028_daft_310", "A2028_daft_450") then
          MapChange("d", 402, "start_07", true, FADE_WHITE, FADE_TIME)
        elseif Common.CheckTimeAxis("P2028_daft_310", "P2028_daft_450") then
          MapChange("d", 402, "start_07", true, FADE_WHITE, FADE_TIME)
        end
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
    if talk_id == 216 then
      local fldtxt = "d04"
      if Flg.Check("FLAG_MAIN_10_048") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0404_0330_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0404_0370_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 224 then
      local fldtxt = "d04"
      if Flg.Check("FLAG_MAIN_10_048") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0404_0330_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0404_0370_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 226 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0330_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 237 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0330_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before_P300(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After_P300(npc_name)
    end
  end
  if gMapNum == 405 then
    if npc_name == "s040_033_001" then
      require("S040_033")
      S040_033:Event_040()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before_P300(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After_P300(npc_name)
    end
  end
  if gMapNum == 406 then
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before_P300(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After_P300(npc_name)
    end
  end
  if gMapNum == 407 then
    npc_text = "d0407"
    if talk_id == 1 then
      if Flg.Check("FLAG_MAIN_06_060") then
        Cam.Inst:Set(1.710574, 4.200014, 14.400941, 3.082507, 1.448842, 23.916656, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0407_0050_0030")
        Message("f_d0407_0050_0040")
        Message("f_d0407_0050_0050")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
      else
        Cam.Inst:Set(1.710574, 4.200014, 14.400941, 3.082507, 1.448842, 23.916656, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0407_0050_0010")
        Message("f_d0407_0050_0020")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
      end
    end
    if talk_id == 2 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0407_0060_0010")
      WaitFrame(20)
      Message("f_d0407_0060_0020")
      Message("f_d0407_0060_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 4 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(-2.658535, 3.249969, -14.197862, -5.477218, 1.334921, -23.599331, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0407_0070_0070")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if gMapNum == 407 then
      if talk_id == 5 then
        local fldtxt = "d04"
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Set(1.710574, 4.200014, 14.400941, 3.082507, 1.448842, 23.916656, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0407_0090_0010")
        Cam.Inst:Clear(30)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
      if talk_id == 6 then
        local fldtxt = "d04"
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Set(1.710574, 4.200014, 14.400941, 3.082507, 1.448842, 23.916656, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0407_0100_0010")
        Cam.Inst:Clear(30)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
  end
end

function D04_WarpNPC_Before_P300(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(5, "f_d0107_0100_0130")
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 or result == RESULT_TALK03 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_FIELD_D04_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 401, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 404, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 406, "start_01", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK03 then
      MapChange("d", 402, "start_07", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function D04_WarpNPC_After_P300(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(5, "f_d0107_0100_0140")
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 or result == RESULT_TALK03 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_FIELD_D04_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 402, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 404, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 406, "start_01", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK03 then
      MapChange("d", 401, "start_30", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end
