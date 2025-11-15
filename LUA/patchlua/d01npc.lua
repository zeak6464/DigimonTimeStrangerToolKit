function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 101 then
    if talk_id == 2 then
      local fldtxt = "d01"
      if Flg.Check("FLAG_MAIN_18_055") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0120_0010")
        Message("f_d0101_0120_0020")
        Message("f_d0101_0120_0030")
        Message("f_d0101_0120_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_18_040") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0100_0010")
        Message("f_d0101_0100_0020")
        Message("f_d0101_0100_0030")
        Message("f_d0101_0100_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_18_029E") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0150_0010")
        Message("f_d0101_0150_0020")
        Message("f_d0101_0150_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_18_027") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0130_0010")
        Message("f_d0101_0130_0020")
        Message("f_d0101_0130_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0080_0010")
        Message("f_d0101_0080_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 3 then
      local fldtxt = "d01"
      if Flg.Check("FLAG_MAIN_18_055") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0110_0010")
        Message("f_d0101_0110_0020")
        Message("f_d0101_0110_0030")
        Message("f_d0101_0110_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_18_040") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0090_0010")
        Message("f_d0101_0090_0020")
        Message("f_d0101_0090_0030")
        Message("f_d0101_0090_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_18_029E") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0160_0010")
        START_TALK_ACTION_AND_ZOOM("npc_0002", true, true)
        Message("f_d0101_0160_0011")
        Message("f_d0101_0160_0012")
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Message("f_d0101_0160_0013")
        Message("f_d0101_0160_0014")
        Message("f_d0101_0160_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_18_027") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0140_0010")
        Message("f_d0101_0140_0020")
        Message("f_d0101_0140_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0101_0070_0010")
        Message("f_d0101_0070_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
  elseif gMapNum == 103 then
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
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(5)
        PlayerObjectResetAim()
        Cam.Inst:Clear(0)
        Obj:new(PLAYER, ""):SetPos(99.704, 0.201, 97.173, true)
        Obj:new(PLAYER, ""):SetRotationY(165, 0)
        SetFollowerCameraOperateRotation(0, 165, 0)
        tlk:EndTalk()
        WaitFrame(15)
        FadeInWithWaitNotFlgCheck(FADE_WHITE, FADE_TIME)
        player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
        Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
        Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 105 then
    if npc_name == "npc_0001" then
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
        Flg.Set("FLAG_FIELD_D01_IS_WARP")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("d", 102, "start_30", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 106 then
    if npc_name == "npc_001" then
      local fldtxt = "d01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0106_0040_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_002" then
      local fldtxt = "d01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0106_0050_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 107 then
    if npc_name == "npc_001" then
      local fldtxt = "d01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0107_0060_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_002" then
      local fldtxt = "d01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0107_0070_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_003" then
      local fldtxt = "d01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0107_0080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_004" then
      local fldtxt = "d01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0107_0090_0010")
      Message("f_d0107_0090_0020")
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
      tlk:StartTalk()
      tlk:Message("f_d0107_0100_0010")
      local result = tlk:Select(2, "f_d0107_0100_0020")
      if result == RESULT_TALK00 then
        tlk:Message("f_d0107_0100_0030")
        tlk:MessageClose()
        WarpNpcPerformance(npc_name)
        Flg.Set("FLAG_FIELD_D01_IS_WARP")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("d", 107, "start_30", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 108 then
    if talk_id == 2 then
      local fldtxt = "d01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0108_0020_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 109 then
    if npc_name == "npc_0001" then
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD01(npc_name)
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
        Flg.Set("FLAG_FIELD_D01_IS_WARP")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("d", 106, "start_30", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  end
end
