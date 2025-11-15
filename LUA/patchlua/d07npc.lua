function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 701 then
    if talk_id == 2 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0701_0020_0010")
      Message("f_d0701_0020_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_1000_rumor" then
      if Flg.Check("FLAG_MAIN_14_010", "FLAG_MAIN_14_011") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        M360:Event_012()
      elseif Flg.Check("FLAG_MAIN_14_040", "FLAG_MAIN_14_041") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        M360:Event_046()
      else
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d07_GekoWarp(701, "ride_start_01", "ride_landing_01a", "ride_landing_01b")
      end
    end
    if npc_name == "card_001" then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0701_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0701_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1701, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0701_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0701_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0701_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
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
      tlk:StartTalk()
      tlk:Message("f_d0107_0100_0010")
      local result = tlk:Select(2, "f_d0107_0100_0060")
      if result == RESULT_TALK00 then
        tlk:Message("f_d0107_0100_0030")
        tlk:MessageClose()
        WarpNpcPerformance(npc_name)
        Flg.Set("FLAG_FIELD_D07_020")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("d", 702, "start_30", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 702 then
    if npc_name == "npc_0002" then
      require("S110_092")
      require("S110_094")
      if Qst.Sub:Check(S110_092.ID, S110_092.STEP_020, S110_092.STEP_255) then
        S110_092:Event_080()
      elseif Qst.Sub:Check(S110_094.ID, S110_094.STEP_010, S110_094.STEP_255) then
        S110_094:Event_020()
      else
        local fldtxt = "d07"
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0702_0030_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc_0022" then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0702_0040_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    elseif npc_name == "npc_0020" then
      Flg.Set("FLAG_MAIN_14_016")
      local tlk = Tlk:new("d07", 1, false)
      local npc_index = GetIndex(NPC, npc_name)
      local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
      local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
      tlk:StartTalk()
      Field.ObjectPlayMotion(FLD_OBJ_PLAYER, 1, "e202", 5, true)
      WaitFrame(30)
      tlk:Message("f_d0702_0060_0010")
      tlk:EndTalk()
      WaitFrame(8)
      PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
      Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
      WaitFrame(60)
      Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "fg09_out01", 5, 5)
      WaitFrame(15)
    end
    if npc_name == "npc_0023" then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      if Flg.Check("FLAG_MAIN_15_015") then
        Message("f_d0702_0080_0010")
      else
        Message("f_d0702_0050_0010")
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    elseif npc_name == "npc_0021" then
      Flg.Set("FLAG_MAIN_14_017")
      local tlk = Tlk:new("d07", 1, false)
      local npc_index = GetIndex(NPC, npc_name)
      local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
      local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
      tlk:StartTalk()
      Field.ObjectPlayMotion(FLD_OBJ_PLAYER, 1, "e202", 5, true)
      WaitFrame(30)
      tlk:Message("f_d0702_0070_0010")
      tlk:EndTalk()
      WaitFrame(8)
      PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
      Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
      WaitFrame(60)
      Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "fg09_out01", 5, 5)
      WaitFrame(15)
    end
    if npc_name == "s020_014_001" then
      require("S020_014")
      S020_014:Event_050()
    end
    if npc_name == "s020_016_001" then
      require("S020_016")
      S020_016:Event_060()
    end
    if npc_name == "s110_094_001" then
      require("S110_094")
      S110_094:Event_010()
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD07(npc_name)
    end
    if npc_name == "s110_093_cra_01" then
      require("S110_093")
      S110_093:Event_010()
    end
    if npc_name == "s110_094_005" then
      require("S110_094")
      S110_094:Event_040()
      S110_094:Event_030()
      S110_094:Event_008()
      S110_094:Event_005()
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
      tlk:StartTalk()
      tlk:Message("f_d0107_0100_0010")
      local result = tlk:Select(2, "f_d0107_0100_0020")
      if result == RESULT_TALK00 then
        tlk:Message("f_d0107_0100_0030")
        tlk:MessageClose()
        WarpNpcPerformance(npc_name)
        Flg.Set("FLAG_FIELD_D07_020")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("d", 701, "start_10", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 703 then
    if talk_id == 14 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0010_0010")
      MessageClose()
      MessageTalkSel(2, "f_d0703_0010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Message("f_d0703_0010_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
        MapChange("d", 701, "start_02", true, 0, FADE_TIME)
      elseif result == RESULT_TALK01 then
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 2 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0020_0010")
      Message("f_d0703_0020_0020")
      Message("f_d0703_0020_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 3 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0030_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 6 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0040_0010")
      Message("f_d0703_0040_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 7 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0050_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 8 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0070_0010")
      Message("f_d0703_0070_0020")
      Message("f_d0703_0070_0030")
      Message("f_d0703_0070_0040")
      MessageClose()
      local correct = false
      while not correct do
        MessageTalkSel(5, "f_d0703_0070_0050")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_d0703_0070_0100")
          Message("f_d0703_0070_0110")
          Message("f_d0703_0070_0120")
          Message("f_d0703_0070_0130")
          Message("f_d0703_0070_0140")
          Message("f_d0703_0070_0150")
          Message("f_d0703_0070_0600")
          MessageClose()
        elseif result == RESULT_TALK01 then
          Message("f_d0703_0070_0200")
          Message("f_d0703_0070_0210")
          Message("f_d0703_0070_0220")
          Message("f_d0703_0070_0230")
          Message("f_d0703_0070_0240")
          Message("f_d0703_0070_0600")
          MessageClose()
        elseif result == RESULT_TALK02 then
          Message("f_d0703_0070_0300")
          Message("f_d0703_0070_0310")
          Message("f_d0703_0070_0320")
          Message("f_d0703_0070_0330")
          Message("f_d0703_0070_0340")
          Message("f_d0703_0070_0350")
          Message("f_d0703_0070_0360")
          Message("f_d0703_0070_0370")
          Message("f_d0703_0070_0600")
          MessageClose()
        elseif result == RESULT_TALK03 then
          Message("f_d0703_0070_0400")
          Message("f_d0703_0070_0410")
          Message("f_d0703_0070_0420")
          Message("f_d0703_0070_0430")
          Message("f_d0703_0070_0440")
          Message("f_d0703_0070_0500")
          Message("f_d0703_0070_0510")
          Message("f_d0703_0070_0520")
          Message("f_d0703_0070_0530")
          Message("f_d0703_0070_0540")
          Message("f_d0703_0070_0550")
          Message("f_d0703_0070_0600")
          MessageClose()
        elseif result == RESULT_TALK04 then
          Message("f_d0703_0070_0610")
          MessageClose()
          correct = true
        end
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 9 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 10 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0090_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 11 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0100_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 12 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0110_0010")
      Message("f_d0703_0110_0020")
      Message("f_d0703_0110_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 13 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0120_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 15 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0260_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 16 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0060_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 17 then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_0270_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_001" then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0703_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1702, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0703_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0703_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0703_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "d07"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0703_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0703_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1703, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0703_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0703_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0703_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
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
      tlk:StartTalk()
      tlk:Message("f_d0107_0100_0010")
      local result = tlk:Select(2, "f_d0107_0100_0020")
      if result == RESULT_TALK00 then
        tlk:Message("f_d0107_0100_0030")
        tlk:MessageClose()
        WarpNpcPerformance(npc_name)
        Flg.Set("FLAG_FIELD_D07_020")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("d", 701, "start_10", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
    if npc_name == "card_shop_0001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      CommonShopStart_NoZoomCam(npc_name, 171, "fe02", "fe04", "fe04", "bn01")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "s020_014_001" then
      require("S020_014")
      S020_014:Event_030()
    end
    if npc_name == "s020_016_001" then
      require("S020_016")
      S020_016:Event_040()
    end
  end
end
