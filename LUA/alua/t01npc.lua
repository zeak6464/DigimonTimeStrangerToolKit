function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = "t01"
  local field_text = "field_text"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 101 then
    if npc_name == "npc_3014" then
      local npc_3014 = Obj:new(NPC, "npc_3014")
      local npc_3010 = Obj:new(NPC, "npc_3010")
      local e002 = Motion.Object:new(NPC, "npc_3014", "e002")
      local e013 = Motion.Object:new(NPC, "npc_3014", "e013")
      local e012 = Motion.Object:new(NPC, "npc_3014", "e012")
      local npc_index01 = GetIndex(NPC, "npc_3014")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e013:Play(20, true)
      npc_3014:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0010_0020")
      e002:Play(10, true)
      Message("f_t0101_0010_0030")
      Message("f_t0101_0010_0040")
      npc_3014:ChangeExpression("F01", EYE_BLINK, false, 10)
      Field.ObjectResetAim(NPC, npc_index01, 15)
      npc_3010:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0010_0010")
      npc_3010:ChangeExpression("F01", EYE_BLINK, false, 10)
      e012:Play(10, true)
      npc_3014:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0010_0050")
      npc_3014:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "npc_3011" then
      local npc_3011 = Obj:new(NPC, "npc_3011")
      local e002 = Motion.Object:new(NPC, "npc_3011", "e002")
      local e013 = Motion.Object:new(NPC, "npc_3011", "e013")
      local e015 = Motion.Object:new(NPC, "npc_3011", "e015")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(20, true)
      npc_3011:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0020_0010")
      e015:Play(20, true)
      Message("f_t0101_0020_0020")
      npc_3011:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      e013:Play(20, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3012" then
      local npc_3012 = Obj:new(NPC, "npc_3012")
      local e012 = Motion.Object:new(NPC, "npc_3012", "e012")
      local e002 = Motion.Object:new(NPC, "npc_3012", "e002")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(20, true)
      npc_3012:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0030_0010")
      npc_3012:ResetExporession(10)
      e012:Play(20, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3013" then
      local npc_3013 = Obj:new(NPC, "npc_3013")
      local e010 = Motion.Object:new(NPC, "npc_3013", "e010")
      local e030 = Motion.Object:new(NPC, "npc_3013", "e030")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e010:Play(10, true)
      npc_3013:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0040_0010")
      npc_3013:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      e030:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3015" then
      local npc_3015 = Obj:new(NPC, "npc_3015")
      local e007 = Motion.Object:new(NPC, "npc_3015", "e007")
      local e005 = Motion.Object:new(NPC, "npc_3015", "e005")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e005:Play(10, true)
      npc_3015:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0160_0010")
      npc_3015:ResetExporession(10)
      e007:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "npc_3016" then
      local npc_3016 = Obj:new(NPC, "npc_3016")
      local e012 = Motion.Object:new(NPC, "npc_3016", "e012")
      local e015 = Motion.Object:new(NPC, "npc_3016", "e015")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e015:Play(20, true)
      npc_3016:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0101_0170_0010")
      npc_3016:ResetExporession(10)
      e012:Play(20, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "card_001" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0101_9000_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0101_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(10, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0101_9000_0080")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0101_9000_0090")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0101_9000_0100")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0101_9000_0030")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0101_9000_0040")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(11, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0101_9000_0060")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0101_9000_0070")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0101_9000_0050")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_002"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "npc_0031" then
      local fldtxt = "t01"
      if Flg.Check("FLAG_MAIN_11_054") then
        local e002 = Motion.Object:new(NPC, "npc_0031", "e002")
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0101_0180_0010")
        e002:Play(10, true)
        Message("f_t0101_0180_0020")
        Message("f_t0101_0180_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        M310:Event_108()
      end
    end
    if npc_name == "S200_149_hiroko_01" then
      require("S200_149")
      S200_149:Event_020()
      S200_149:Event_010()
    end
    if npc_name == "sub072_005" then
      require("S090_072")
      S090_072:Event_030()
    end
    if npc_name == "s090_072_001" then
      require("S090_072")
      S090_072:Event_100()
    end
    if npc_name == "npc_0032" then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0032")
      local e002 = Motion.Object:new(NPC, "npc_0032", "e002")
      local e014 = Motion.Object:new(NPC, "npc_0032", "e014")
      Field.ObjectLoadExpression(NPC, npc_index01, "F01_T01")
      Field.ObjectLoadExpression(NPC, npc_index01, "F02_T01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      if Common.CheckTimeAxis("X2028_daft_10", "X2028_daft_440") then
        Field.ObjectChangeExpression(NPC, npc_index01, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0101_0190_0010")
        Message("f_t0101_0190_0020")
        e014:Play(20, true)
        Message("f_t0101_0190_0030")
      else
        Field.ObjectChangeExpression(NPC, npc_index01, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0101_0200_0010")
        Message("f_t0101_0200_0020")
        Message("f_t0101_0200_0030")
        e002:Play(20, true)
        Message("f_t0101_0200_0040")
      end
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0032"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
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
      local result = tlk:Select(2, "f_d0107_0100_0080")
      if result == RESULT_TALK00 then
        tlk:Message("f_d0107_0100_0030")
        tlk:MessageClose()
        WarpNpcPerformance(npc_name)
        Flg.Set("FLAG_T0408_IS_WARP")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("t", 408, "start_30", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 102 then
    if npc_name == "npc_3014" then
      local npc_3014 = Obj:new(NPC, "npc_3014")
      local e007 = Motion.Object:new(NPC, "npc_3014", "e007")
      local e008 = Motion.Object:new(NPC, "npc_3014", "e008")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e008:Play(10, true)
      npc_3014:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0010_0010")
      npc_3014:ResetExporession(10)
      e007:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3015" then
      local npc_3015 = Obj:new(NPC, "npc_3015")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_3015:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0020_0010")
      npc_3015:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3016" then
      local npc_3016 = Obj:new(NPC, "npc_3016")
      local npc_3017 = Obj:new(NPC, "npc_3017")
      local Mob01_e004 = Motion.Object:new(NPC, "npc_3016", "e004")
      local Mob01_e013 = Motion.Object:new(NPC, "npc_3016", "e013")
      local Mob02_e010 = Motion.Object:new(NPC, "npc_3017", "e010")
      local Mob02_e012 = Motion.Object:new(NPC, "npc_3017", "e012")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Mob01_e004:Play(10, true)
      npc_3016:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0030_0010")
      npc_3016:ResetExporession(10)
      Mob01_e013:Play(10, true)
      Mob02_e010:Play(10, true)
      npc_3017:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0030_0020")
      npc_3017:ResetExporession(10)
      Mob02_e012:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3018" then
      local npc_3018 = Obj:new(NPC, "npc_3018")
      local e013 = Motion.Object:new(NPC, "npc_3018", "e013")
      local e005 = Motion.Object:new(NPC, "npc_3018", "e005")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e005:Play(10, true)
      npc_3018:ChangeExpression("F04", EYE_BLINK, true, 10)
      Message("f_t0102_0040_0010")
      npc_3018:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      e013:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3120" then
      local npc_3120 = Obj:new(NPC, "npc_3120")
      local e012 = Motion.Object:new(NPC, "npc_3120", "e012")
      local e018 = Motion.Object:new(NPC, "npc_3120", "e018")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e018:Play(10, true)
      npc_3120:ChangeExpression("F03", EYE_BLINK, true, 10)
      Message("f_t0102_0120_0010")
      npc_3120:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      e012:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3121" then
      local npc_3121 = Obj:new(NPC, "npc_3121")
      local e008 = Motion.Object:new(NPC, "npc_3121", "e008")
      local e015 = Motion.Object:new(NPC, "npc_3121", "e015")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_3121:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0130_0010")
      e015:Play(10, true)
      Message("f_t0102_0130_0020")
      npc_3121:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      e008:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3122" then
      local npc_3122 = Obj:new(NPC, "npc_3122")
      local e002 = Motion.Object:new(NPC, "npc_3122", "e002")
      local fn01_01 = Motion.Object:new(NPC, "npc_3122", "fn01_01")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(10, true)
      npc_3122:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0140_0010")
      npc_3122:ResetExporession(10)
      fn01_01:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3129" then
      local npc_3129 = Obj:new(NPC, "npc_3129")
      local e002 = Motion.Object:new(NPC, "npc_3129", "e002")
      local e030 = Motion.Object:new(NPC, "npc_3129", "e030")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(10, true)
      npc_3129:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0220_0010")
      npc_3129:ResetExporession(10)
      e030:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3130" then
      local npc_3130 = Obj:new(NPC, "npc_3130")
      local e002 = Motion.Object:new(NPC, "npc_3130", "e002")
      local e012 = Motion.Object:new(NPC, "npc_3130", "e012")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(10, true)
      npc_3130:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0230_0010")
      npc_3130:ResetExporession(10)
      e012:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3131" then
      local npc_3131 = Obj:new(NPC, "npc_3131")
      local e015 = Motion.Object:new(NPC, "npc_3131", "e015")
      local e012 = Motion.Object:new(NPC, "npc_3131", "e012")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e015:Play(10, true)
      npc_3131:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0102_0240_0010")
      npc_3131:ResetExporession(10)
      e012:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_3019" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0102_0100_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "s090_072_001" then
      require("S090_072")
      S090_072:Event_005()
    end
  elseif gMapNum == 103 then
    if npc_name == "npc_0001" then
      M090:Event_032()
    end
    if npc_name == "npc_0002" then
      M090:Event_033()
    end
    if npc_name == "npc_0003" then
      M090:Event_034()
    end
    if npc_name == "card_001" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0103_9000_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0103_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(12, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0103_9000_0050")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F02", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0103_9000_0040")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        end
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0103_9000_0030")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      end
    end
    if talk_id == 4 then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0004")
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0103_0060_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0004"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 7 then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0103_0070_0010")
      Message("f_t0103_0070_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 8 then
      local fldtxt = "t01"
      Cam.Inst:Set(-2.03, 3.14, -53.05, 6.44, 0.98, -48.21, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0103_0080_0010")
      Message("f_t0103_0080_0020")
      Message("f_t0103_0080_0030")
      Message("f_t0103_0080_0040")
      Message("f_t0103_0080_0050")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
      WaitFrame(30)
    end
    if talk_id == 11 then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0011")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, npc_index01, "F02", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0103_0090_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0011"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 111 then
      if Flg.Check("FLAG_FIELD_t01_010") then
        local fldtxt = "t01"
        Cam.Inst:Set(-25.49, 2.36, -55.46, -15.44, 1.86, -56.7, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0103_0100_0040")
        Message("f_t0103_0100_0050")
        Message("f_t0103_0100_0060")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
      else
        local fldtxt = "t01"
        Cam.Inst:Set(-25.49, 2.36, -55.46, -15.44, 1.86, -56.7, default, 30)
        WaitFrame(30)
        Flg.Set("FLAG_FIELD_t01_010")
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0103_0100_0010")
        Message("f_t0103_0100_0020")
        Message("f_t0103_0100_0030")
        Message("f_t0103_0100_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
      end
    end
    if npc_name == "npc_0112" then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0112")
      local e005 = Motion.Object:new(NPC, "npc_0112", "e005")
      Field.ObjectLoadExpression(NPC, npc_index01, "F03_T01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 30)
      Field.ObjectChangeExpression(NPC, npc_index01, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      e005:Play(20, true)
      Message("f_t0103_0120_0010")
      Message("f_t0103_0120_0020")
      Message("f_t0103_0120_0030")
      Message("f_t0103_0120_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0112"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0005" then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0005")
      Field.ObjectLoadExpression(NPC, npc_index01, "F03_T01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 30)
      Field.ObjectChangeExpression(NPC, npc_index01, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0103_0130_0010")
      Message("f_t0103_0130_0020")
      Message("f_t0103_0130_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0005"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0006" then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0006")
      Field.ObjectLoadExpression(NPC, npc_index01, "F03_T01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 30)
      Field.ObjectChangeExpression(NPC, npc_index01, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0103_0140_0010")
      Message("f_t0103_0140_0020")
      Field.ObjectChangeExpression(NPC, npc_index01, "F03_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0103_0140_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0006"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0012" then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0012")
      Field.ObjectLoadExpression(NPC, npc_index01, "F03_T01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index01, 30)
      Field.ObjectChangeExpression(NPC, npc_index01, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0103_0150_0010")
      Message("f_t0103_0150_0020")
      Message("f_t0103_0150_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0012"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s110_103_001" then
      require("S110_103")
      S110_103:Event_025()
    end
    if npc_name == "s110_103_002" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      require("S110_103")
      S110_103:Event_022(npc_name)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if npc_name == "s110_103_010" then
      require("S110_103")
      S110_103:Event_010()
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
      local result = tlk:Select(2, "f_d0107_0100_0080")
      if result == RESULT_TALK00 then
        tlk:Message("f_d0107_0100_0030")
        tlk:MessageClose()
        WarpNpcPerformance(npc_name)
        Flg.Set("FLAG_T0408_IS_WARP")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        PlayerObjectResetAim()
        tlk:EndTalk()
        MapChange("t", 408, "start_30", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 104 then
    if npc_name == "npc_0006" then
      M050:Event_040()
    end
    if npc_name == "npc_0001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(field_text, 1)
      Message(9999)
      Field_Talk_End()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "card_001" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0104_9000_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0104_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(13, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0104_9000_0040")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0104_9000_0050")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0104_9000_0030")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "s110_100_005" then
      require("S110_100")
    end
    if npc_name == "s110_092_001" then
      require("S110_092")
      S110_092:Event_050()
      S110_092:Event_040()
    end
    if npc_name == "s110_092_002" then
      require("S110_092")
      S110_092:Event_060()
      S110_092:Event_040()
    end
    if npc_name == "s110_098_001" then
      require("S110_098")
      S110_098:Event_030()
    end
  elseif gMapNum == 105 then
    if npc_name == "npc_0001" then
      local fldtxt = "t01"
      local npc_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadExpression(NPC, npc_index, "F01")
      if not Flg.Check("FLAG_MAIN_03_339") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0105_0020_0020")
        Message("f_t0105_0020_0030")
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Flg.Set("FLAG_MAIN_03_339")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        M100:Event_060()
        MapChange("d", 1001, "start_04", true, 0, FADE_TIME)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0105_0010_0010")
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        MessageClose()
        MessageTalkSel(2, "f_t0105_0020_0010")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          MapChange("d", 1001, "start_04", true, 0, FADE_TIME)
        end
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "npc_0004" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0105_0050_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "sub010_156_001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      require("S010_156")
      S010_156:Event_020()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  elseif gMapNum == 106 then
    if npc_name == "npc_0001" then
      if not Flg.Check("FLAG_MAIN_02_030") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_t0106_0010_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_t0106_0020_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "sub072_001" then
      require("S090_072")
      S090_072:Event_018()
      S090_072:Event_013()
    end
    if npc_name == "s010_179_001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S010_179")
      S010_179:Event_010()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "s110_092_002" then
      require("S110_092")
      S110_092:Event_030()
    end
    if npc_name == "s110_092_002" then
      require("S110_092")
      S110_092:Event_020()
    end
  elseif gMapNum == 107 then
    if npc_name == "npc_0001" then
      local npc_0001 = Obj:new(NPC, "npc_0001")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0001:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0107_0010_0010")
      npc_0001:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0002" then
      Field.DisableMenu()
      Common.ProhibitSave()
      local npc_0002 = Obj:new(NPC, "npc_0002")
      local index = GetIndex(FLD_OBJ_NPC, "npc_0002")
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalkActionAndZoom("npc_0002")
      Field.ObjectLoadMotion(NPC, index, "e018")
      Field.ObjectPlayMotion(NPC, index, "e018", 10, true)
      npc_0002:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0107_0020_0010")
      Field.ObjectLoadMotion(NPC, index, "e004")
      Field.ObjectPlayMotion(NPC, index, "e004", 10, true)
      tlk:Message("f_t0107_0080_0010")
      npc_0002:ResetExporession(10)
      tlk:EndTalkActionAndZoom()
      Field.ObjectLoadMoveMotion(FLD_OBJ_NPC, index, "fr01_01")
      Field.ObjectStandbyMoveMotion(FLD_OBJ_NPC, index, "fr01_01")
      Field.ObjectReleaseMonopolyOnPhysics(FLD_OBJ_NPC, index)
      Field.ObjectSuspendAutoTransparentForCamera(PLAYER, 1)
      if GetControlScriptExternalVariableString("npc_state") == "initialize" then
        SetControlScriptExternalVariable("npc_state", "move")
      end
      ColOff("plan_cl_0011")
      ColOff("plan_cl_0008")
      M010:Event_045()
      if Flg.Check("FLAG_MAIN_01_030", "FLAG_MAIN_01_060") then
        SetControlScriptExternalVariable("player_move_state", "wait")
        Flg.Set("FLAG_GIMMICK_T01_070")
      end
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0002"), false)
    end
    if npc_name == "npc_0003" then
      local npc_0003 = Obj:new(NPC, "npc_0003")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0003:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0107_0030_0010")
      npc_0003:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0004" then
      local npc_0004 = Obj:new(NPC, "npc_0004")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0004:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0107_0040_0010")
      npc_0004:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0005" then
      local npc_0005 = Obj:new(NPC, "npc_0005")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0005:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0107_0050_0010")
      npc_0005:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0006" then
      local npc_0006 = Obj:new(NPC, "npc_0006")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0006:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0107_0060_0010")
      npc_0006:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0007" then
      local npc_0007 = Obj:new(NPC, "npc_0007")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0007:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0107_0070_0010")
      npc_0007:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "S010_156_hiroko_01" then
      require("S010_156")
      S010_156:Event_030()
    end
  elseif gMapNum == 108 then
    if npc_name == "npc_0002" then
      M050:Event_050()
    end
    if npc_name == "npc_0003" then
      local npc_0003 = Obj:new(NPC, "npc_0003")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0003:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0030_0010")
      npc_0003:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_0004" then
      local npc_0004 = Obj:new(NPC, "npc_0004")
      local e010 = Motion.Object:new(NPC, "npc_0004", "e010")
      local e002 = Motion.Object:new(NPC, "npc_0004", "e002")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(10, true)
      npc_0004:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0040_0010")
      npc_0004:ResetExporession(10)
      e010:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_0005" then
      local npc_0005 = Obj:new(NPC, "npc_0005")
      local e015 = Motion.Object:new(NPC, "npc_0005", "e015")
      local e030 = Motion.Object:new(NPC, "npc_0005", "e030")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e015:Play(10, true)
      npc_0005:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0050_0010")
      npc_0005:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      e030:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_0006" then
      local npc_0006 = Obj:new(NPC, "npc_0006")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0006:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0060_0010")
      npc_0006:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_0012" then
      local npc_0012 = Obj:new(NPC, "npc_0012")
      local e002 = Motion.Object:new(NPC, "npc_0012", "e002")
      local e012 = Motion.Object:new(NPC, "npc_0012", "e012")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0012:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0150_0010")
      npc_0012:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_0013" then
      local npc_0013 = Obj:new(NPC, "npc_0013")
      local e004 = Motion.Object:new(NPC, "npc_0013", "e004")
      local e018 = Motion.Object:new(NPC, "npc_0013", "e018")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e018:Play(10, true)
      npc_0013:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0160_0010")
      npc_0013:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      e004:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if npc_name == "npc_0014" then
      local npc_0014 = Obj:new(NPC, "npc_0014")
      local npc_0015 = Obj:new(NPC, "npc_0015")
      local npc_0016 = Obj:new(NPC, "npc_0016")
      local npc_0014_e013 = Motion.Object:new(NPC, "npc_0014", "e013")
      local npc_0014_e004 = Motion.Object:new(NPC, "npc_0014", "e004")
      local npc_0014_e002 = Motion.Object:new(NPC, "npc_0014", "e002")
      local npc_0015_e030 = Motion.Object:new(NPC, "npc_0015", "e030")
      local npc_0015_e002 = Motion.Object:new(NPC, "npc_0015", "e002")
      local npc_0015_e006 = Motion.Object:new(NPC, "npc_0015", "e006")
      local npc_0016_e012 = Motion.Object:new(NPC, "npc_0016", "e012")
      local npc_0016_e013 = Motion.Object:new(NPC, "npc_0016", "e013")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0014_e004:Play(10, true)
      npc_0014:ChangeExpression("F02", EYE_BLINK, true, 10)
      Message("f_t0108_0180_0010")
      npc_0014:ChangeExpression("F02", EYE_BLINK, false, 10)
      npc_0015_e002:Play(10, true)
      npc_0015:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0180_0020")
      npc_0015:ChangeExpression("F01", EYE_BLINK, false, 10)
      npc_0016_e013:Play(10, true)
      npc_0016:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0180_0030")
      npc_0016:ChangeExpression("F01", EYE_BLINK, false, 10)
      npc_0014_e002:Play(10, true)
      npc_0014:ChangeExpression("F02", EYE_BLINK, true, 10)
      Message("f_t0108_0180_0040")
      npc_0014:ChangeExpression("F02", EYE_BLINK, false, 10)
      npc_0015_e006:Play(10, true)
      npc_0015:ChangeExpression("F05", EYE_BLINK, true, 10)
      Message("f_t0108_0180_0050")
      npc_0015:ChangeExpression("F01", EYE_BLINK, false, 10)
      npc_0016_e012:Play(10, true)
      npc_0016:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0180_0060")
      npc_0016:ChangeExpression("F01", EYE_BLINK, false, 10)
      npc_0015_e030:Play(10, true)
      npc_0014_e013:Play(10, true)
      npc_0014:ChangeExpression("F01", EYE_BLINK, false, 10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if npc_name == "npc_0017" then
      local n017 = Obj:new(NPC, "npc_0017")
      local n018 = Obj:new(NPC, "npc_0018")
      local npc_0017 = GetIndex(NPC, "npc_0017")
      local npc_0018 = GetIndex(NPC, "npc_0018")
      local npc_0017_e005 = Motion.Object:new(NPC, "npc_0017", "e005")
      local npc_0017_e010 = Motion.Object:new(NPC, "npc_0017", "e010")
      local npc_0017_e018 = Motion.Object:new(NPC, "npc_0017", "e018")
      local npc_0018_e013 = Motion.Object:new(NPC, "npc_0018", "e013")
      local npc_0018_e002 = Motion.Object:new(NPC, "npc_0018", "e002")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectLookAtTheObject(NPC, npc_0017, NPC, npc_0018, 30)
      Field.ObjectLookAtTheObject(NPC, npc_0018, NPC, npc_0017, 30)
      npc_0017_e010:Play(10, true)
      n017:ChangeExpression("F03", EYE_BLINK, true, 10)
      Message("f_t0108_0170_0010")
      npc_0017_e018:Play(10, true)
      Message("f_t0108_0170_0020")
      n017:ResetExporession(10)
      END_TALK_ACTION_AND_ZOOM("npc_0017", false, true)
      START_TALK_ACTION_AND_ZOOM("npc_0018", false, true)
      npc_0018_e002:Play(10, true)
      n018:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0108_0170_0030")
      n018:ResetExporession(10)
      npc_0017_e005:Play(10, true)
      npc_0018_e013:Play(10, true)
      n018:ChangeExpression("F04", EYE_BLINK, true, 10)
      Message("f_t0108_0170_0040")
      n018:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM("npc_0018", false, true)
    end
    if npc_name == "npc_0010" then
      local fldtxt = "t01"
      local simons_index = GetIndex(NPC, "npc_0010")
      Field.ObjectLoadMotion(NPC, simons_index, "e002")
      Field.ObjectLoadMotion(NPC, simons_index, "e004")
      Field.ObjectLoadMotion(NPC, simons_index, "e005")
      Field.ObjectLoadMotion(NPC, simons_index, "e006")
      Field.ObjectLoadMotion(NPC, simons_index, "e007")
      Field.ObjectLoadMotion(NPC, simons_index, "e008")
      Field.ObjectLoadMotion(NPC, simons_index, "e009")
      Field.ObjectLoadMotion(NPC, simons_index, "e012")
      Field.ObjectLoadMotion(NPC, simons_index, "e013")
      Field.ObjectLoadMotion(NPC, simons_index, "e014")
      Field.ObjectLoadMotion(NPC, simons_index, "e021")
      Field.ObjectLoadMotion(NPC, simons_index, "e023")
      Field.ObjectLoadMotion(NPC, simons_index, "e510")
      Field.ObjectLoadExpression(NPC, simons_index, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0108_0110_0010")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, simons_index, "e014", 0, 10)
      Field.pal(NPC, simons_index, "e002", 10, true)
      Message("f_t0108_0110_0020")
      Field.ObjectPlayMotion(NPC, simons_index, "e008", 15, true)
      Message("f_t0108_0110_0030")
      Field.ObjectPlayMotion(NPC, simons_index, "e012", 15, true)
      Message("f_t0108_0110_0040")
      Field_Talk_End_Not_LetterBox()
      Field.ObjectChangeExpression(NPC, simons_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0011" then
      local fldtxt = "t01"
      local kuga_index = GetIndex(NPC, "npc_0010")
      Field.ObjectLoadExpression(NPC, kuga_index, "F01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, kuga_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0108_0120_0010")
      Field_Talk_End_Not_LetterBox()
      Field.ObjectChangeExpression(NPC, kuga_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "s910_171_001" then
      require("S910_171")
      S910_171:Event_080()
    end
    if npc_name == "sub072_003" then
      require("S090_072")
      S090_072:Event_020()
    end
  elseif gMapNum == 109 then
    if npc_name == "hiroko" then
      M060:Event_040()
    end
    if npc_name == "npc_0010" then
      local npc_index01 = GetIndex(NPC, "npc_0010")
      local kuroi_e012 = Motion.Object:new(NPC, "npc_0010", "e012")
      local kuroi_e008 = Motion.Object:new(NPC, "npc_0010", "e008")
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      kuroi_e008:Play(20, true)
      tlk:Message("f_t0105_0060_0020")
      tlk:Message("f_t0105_0060_0030")
      tlk:Message("f_t0105_0060_0040")
      kuroi_e012:Play(20, true)
      tlk:Message("f_t0105_0060_0050")
      tlk:Message("f_t0105_0060_0060")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0010"), 30)
      tlk:EndTalk()
    end
    if npc_name == "npc_0002" then
      local fldtxt = "t01"
      local npc_index01 = GetIndex(NPC, "npc_0002")
      local e014 = Motion.Object:new(NPC, "npc_0002", "e014")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, npc_index01, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      e014:Play(20, false)
      Message("f_t0109_0010_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0002"), 30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "card_001" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0109_9000_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0109_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(14, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0109_9000_0050")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0109_9000_0040")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0109_9000_0030")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "rumor_001" then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0109_0020_0010")
      FieldTalkEndWithoutLetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "s010_159_001" then
      require("S010_159")
      S010_159:Event_020()
      S010_159:Event_010()
    end
    if npc_name == "s910_171_001" then
      require("S910_171")
      S910_171:Event_060()
    end
    if npc_name == "s910_171_006" then
      require("S910_171")
      S910_171:Event_070()
    end
  end
  if gMapNum == 110 and npc_name == "sub072_001" then
    require("S090_072")
    S090_072:Event_040()
  end
  if gMapNum == 121 then
    if npc_name == "npc_0001" then
      M310:Event_065A()
      M310:Event_065B()
      M310:Event_065C()
      M310:Event_065D()
      M310:Event_065E()
      M310:Event_065F()
      M310:Event_060()
    end
    if talk_id == 2 then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0121_020_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 3 then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0121_030_0010")
      Message("f_t0121_030_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 6 then
      local g_fe02 = Motion.Object:new(NPC, "npc_0006", "fe02")
      local g_bn01 = Motion.Object:new(NPC, "npc_0006", "bn01")
      local g_fq01 = Motion.Object:new(NPC, "npc_0006", "fq01")
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      g_fe02:Play(10, true)
      Message("f_t0121_040_0010")
      g_bn01:Play(10, true)
      Message("f_t0121_040_0020")
      g_fq01:Play(10, true)
      Message("f_t0121_040_0030")
      g_bn01:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 8 then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0121_080_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 9 then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0121_080_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 10 then
      local fldtxt = "t01"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0121_090_0010")
      Message("f_t0121_090_0020")
      Message("f_t0121_090_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s040_160_001" then
      require("S040_160")
      S040_160:Event_030()
    end
  end
end
