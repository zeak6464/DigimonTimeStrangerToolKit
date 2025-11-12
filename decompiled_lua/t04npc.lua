function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = "t04"
  local field_text = "field_text"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 401 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Get_CatItem()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 301 then
      if Quest.CheckFlag(1202, 0) and not Quest.CheckFlag(1202, 1) then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start(npc_text, 1)
        Message(40100000)
        Message(40100001)
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Qst.Sub:Set(1202, 1)
        MapChange("t", 401, "start_00", true, 0, 15)
      else
        local cam_npc = {
          -11.55,
          0.45,
          -5.91,
          -1.76,
          1.62,
          -7.58
        }
        local cam_shop = {
          -9.59,
          -1.1,
          -0.63,
          -2.24,
          1.67,
          -7.63
        }
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        CommonShopStart_NoZoomCam(npc_name, 8, "e012", "e012", "e012", "fn01_10")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    elseif talk_id == 503 then
      local cam_npc = {
        -11.55,
        0.45,
        -5.91,
        -1.76,
        1.62,
        -7.58
      }
      local cam_shop = {
        -11.31,
        -0.08,
        -3.71,
        -2.23,
        1.6,
        -7.52
      }
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      CommonShopStart_NoZoomCam(npc_name, 8, "e012", "e012", "e012", "fn01_10")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 451 then
      local fldtxt = "t04"
      if Qst.Sub:Check(1, 10, 15) then
        if Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0401_0010_0010")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          require("S010_001")
          S010_001:Event_020()
        end
      elseif Flg.Check("FLAG_S001_000") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0401_0030_0010")
        Message("f_t0401_0030_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      elseif Flg.Check("FLAG_S001_001") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0401_0020_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0401_0010_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "shop_0003" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      CommonShopStart_NoZoomCam(npc_name, 11, "e002", "e004", "e019", "fn01_02")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 460 and not Flg.Check("FLAG_MAIN_03_260") then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      FieldTalk(gGimText, 1, 1000)
      Flg.Set("FLAG_MAIN_03_260")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 504 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0401_0110_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 505 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0401_0120_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 506 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0401_0130_0010")
      Message("f_t0401_0130_0020")
      Message("f_t0401_0130_0030")
      Message("f_t0401_0130_0040")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 507 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0401_0140_0010")
      Message("f_t0401_0140_0020")
      Message("f_t0401_0140_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 508 then
      local fldtxt = "t04"
      local fe02 = Motion.Object:new(NPC, "npc_508", "fe02")
      local fe04 = Motion.Object:new(NPC, "npc_508", "fe04")
      local bn01 = Motion.Object:new(NPC, "npc_508", "bn01")
      local e002 = Motion.Object:new(NPC, "npc_509", "e002")
      local npc_508 = GetIndex(NPC, "npc_508")
      local npc_509 = GetIndex(NPC, "npc_509")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe04:Play(10, true)
      Message("f_t0401_0150_0010")
      bn01:Play(10, true)
      e002:Play(10, true)
      Field.ObjectLookAtTheObject(NPC, npc_509, NPC, npc_508, 30)
      Message("f_t0401_0150_0020")
      fe02:Play(10, true)
      Message("f_t0401_0150_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 510 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0401_0160_0010")
      Message("f_t0401_0160_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 511 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0401_0170_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "card_001" then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0401_9000_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "card_001"), 30)
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0401_9000_0100")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(40, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F02", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0401_9000_0040")
          Field.ObjectResetMotion(NPC, GetIndex(NPC, "card_001"), 30)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F03", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_t0401_9000_0050")
          Field.ObjectResetMotion(NPC, GetIndex(NPC, "card_001"), 30)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "card_001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_t0401_9000_0030")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "card_001"), 30)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_tutorial" then
      local npc_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
      Field.ObjectLoadMotion(NPC, npc_index, "e018")
      Field.ObjectLoadMotion(NPC, npc_index, "e004")
      Field.ObjectLoadMotion(NPC, npc_index, "e006")
      Field.ObjectLoadMotion(NPC, npc_index, "e007")
      Field.ObjectLoadMotion(NPC, npc_index, "e015")
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      ObjectTurnToPlayer(NPC, npc_name)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0401_9000_0060")
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      MessageClose()
      local result = 0
      local correct = false
      WaitFrame(15)
      while not correct do
        MessageTalkSel(3, "f_t0401_9000_0020")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          correct = true
          local result = Field.StartCardGameWithNPC(41, true)
          Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, npc_name), PLAYER, 1, 30)
          if result == CARD_GAME_WIN then
            START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
            Field_Talk_Start_Not_LetterBox(fldtxt, 1)
            Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e006", 10, 10)
            Message("f_t0401_9000_0080")
            Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
            Field_Talk_End_Not_LetterBox()
            END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          elseif result == CARD_GAME_LOSE then
            START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
            Field_Talk_Start_Not_LetterBox(fldtxt, 1)
            Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e004", 10, 10)
            Message("f_t0401_9000_0090")
            Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
            Field_Talk_End_Not_LetterBox()
            END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          else
            END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          end
          Field.ObjectResetAim(NPC, GetIndex(NPC, npc_name), 10)
        elseif result == RESULT_TALK01 then
          OpenTutorial(4011)
          OpenTutorial(4012)
        elseif result == RESULT_TALK02 then
          correct = true
          Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e015", 10, 10)
          Message("f_t0401_9000_0070")
          Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      end
    end
    if npc_name == "s900_162_trueking" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      require("S900_162")
      S900_162:Event_040()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  elseif gMapNum == 402 then
    if talk_id == 300 then
      local fldtxt = "t04"
      if Flg.Check("FLAG_MAIN_03_280") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0402_0040_0010")
        Message("f_t0402_0040_0020")
        Message("f_t0402_0040_0030")
        Message("f_t0402_0040_0040")
        Message("f_t0402_0040_0050")
        Message("f_t0402_0040_0060")
        Message("f_t0402_0040_0070")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0402_0030_0020")
        Message("f_t0402_0030_0030")
        Message("f_t0402_0030_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 301 then
    end
    if talk_id == 500 then
      if Qst.Sub:Check(1, 1, 10) and not Flg.Check("FLAG_IS_CLEAR_S010_001") then
        require("S010_001")
        S010_001:Event_010()
      elseif Qst.Sub:Check(2, 1, 10) and not Flg.Check("FLAG_IS_CLEAR_S010_002") then
        require("S010_002")
        S010_002:Event_010()
      else
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_t0402_0020_0010")
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "s010_156_001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      require("S010_156")
      S010_156:Event_010()
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if npc_name == "s110_103_010" then
    end
    if npc_name == "s910_169_001" then
    end
    if npc_name == "hiroko_sub" then
      local id, num, rk_id, w_id = Prcs_t04_HirokoQuest()
      local tlk = Tlk:new(npc_text, 1, true)
      tlk:StartTalk()
      ObjectTurnToPlayer(NPC, "hiroko_sub")
      WaitFrame(15)
      if "0000" ~= id then
        require("S110_103")
        require("S010_156")
        require("S910_169")
        require("S910_170")
        require("S910_171")
        local result = tlk:Select(num, "f_t0402_0900_" .. id)
        if num == 2 then
          if result == RESULT_TALK00 then
            tlk:EndTalk()
            if w_id == 10 then
              S910_169:Event_020()
              S910_169:Event_010()
            elseif w_id == 20 then
              S910_170:Event_080()
              S910_170:Event_010()
            elseif w_id == 30 then
              S910_171:Event_015()
              S910_171:Event_010()
            elseif rk_id == 100 then
              S110_103:Event_010()
            elseif rk_id == 200 then
              START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
              S010_156:Event_010()
              END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
            end
          else
            tlk:EndTalk()
          end
        elseif result == RESULT_TALK00 then
          tlk:EndTalk()
          if w_id == 10 then
            S910_169:Event_020()
            S910_169:Event_010()
          elseif w_id == 20 then
            S910_170:Event_120()
            S910_170:Event_080()
            S910_170:Event_010()
          elseif w_id == 30 then
            S910_171:Event_015()
            S910_171:Event_010()
          end
        elseif result == RESULT_TALK01 then
          tlk:EndTalk()
          if rk_id == 100 then
            S110_103:Event_010()
          elseif rk_id == 200 then
            START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
            S010_156:Event_010()
            END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          end
        else
          tlk:EndTalk()
        end
      else
        tlk:Message("f_t0402_0900_0300")
        tlk:EndTalk()
      end
    end
  elseif gMapNum == 403 then
    if talk_id == 320 then
      local heroine01_e002 = Motion.Object:new(NPC, "npc_0020", "e002")
      local heroine01_fn01_01 = Motion.Object:new(NPC, "npc_0020", "fn01_01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      heroine01_e002:Play(10, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0020"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0110_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0020"), 30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 403 then
      local heroine01_e002 = Motion.Object:new(NPC, "npc_0403", "e002")
      local heroine01_e012 = Motion.Object:new(NPC, "npc_0403", "e012")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      heroine01_e002:Play(10, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0403"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0230_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0403"), 30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_0018" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "npc_0018"), NPC, GetIndex(NPC, "npc_0019"), 30)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0018"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0260_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0018"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0019" then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0019"), "F01_T01")
      Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "npc_0019"), NPC, GetIndex(NPC, "npc_0018"), 30)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0019"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0270_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0019"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 600 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0016"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0240_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0016"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 601 then
      local fldtxt = "t04"
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0017"), "F01_T01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0017"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0250_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0017"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 308 then
      local fldtxt = "t04"
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadExpression(NPC, npc01_index, "E02_M13")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, npc01_index, "E02_M13", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0190_0010")
      Field.ObjectChangeExpression(NPC, npc01_index, "E02_M13", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 309 then
      local e052 = Motion.Object:new(NPC, "npc_0010", "e052")
      local e053 = Motion.Object:new(NPC, "npc_0010", "e053")
      local e058 = Motion.Object:new(NPC, "npc_0010", "e058")
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadExpression(NPC, npc01_index, "E02_M02")
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e058:Play(10, true)
      Field.ObjectChangeExpression(NPC, npc01_index, "E02_M02", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0200_0010")
      e052:Play(10, true)
      Message("f_t0403_0200_0020")
      Message("f_t0403_0200_0030")
      MessageClose()
      Field.ObjectChangeExpression(NPC, npc01_index, "E02_M02", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      WaitFrame(30)
      Field.ObjectChangeExpression(NPC, npc01_index, "E02_M02", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0200_0040")
      Field.ObjectChangeExpression(NPC, npc01_index, "E02_M02", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      e053:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 307 then
      local e053 = Motion.Object:new(NPC, "npc_0008", "e053")
      local e058 = Motion.Object:new(NPC, "npc_0008", "e058")
      local npc01_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadExpression(NPC, npc01_index, "F01_T01")
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e058:Play(20, true)
      Field.ObjectChangeExpression(NPC, npc01_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t0403_0180_0010")
      Message("f_t0403_0180_0020")
      e053:Play(10, true)
      Message("f_t0403_0180_0030")
      Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 312 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0403_0220_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 402 then
      M060:Event_030()
    end
    if talk_id == 350 then
      local e004 = Motion.Object:new(NPC, "npc_0030", "e004")
      local e022 = Motion.Object:new(NPC, "npc_0030", "e022")
      local npc_index = GetIndex(NPC, "npc_0030")
      local tlk = Tlk:new("t04", 1, true)
      Field.ObjectLoadExpression(NPC, npc_index, "F04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      tlk:StartTalk()
      Field.ObjectChangeExpression(NPC, npc_index, "F04", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message("f_t0403_0120_0010")
      Field.ObjectChangeExpression(NPC, npc_index, "F04", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:MessageClose()
      local result = tlk:Select(1, "f_t0403_0130_0010")
      Field.ObjectChangeExpression(NPC, npc_index, "F04", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      if result == RESULT_TALK00 then
        e004:Play(10, true)
        tlk:Message("f_t0403_0140_0010")
      end
      if result == RESULT_TALK01 or result == RESULT_TALK02 then
        e022:Play(10, true)
        tlk:Message("f_t0403_0140_0020")
      end
      tlk:Message("f_t0403_0140_0030")
      Field.ObjectChangeExpression(NPC, npc_index, "F04", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      tlk:MessageClose()
      FadeOutWithWait(0, 5)
      WaitFrame(15)
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      M080:Event_130()
    end
  elseif gMapNum == 404 then
    if talk_id == 302 then
      local fldtxt = "t04"
      if Flg.Check("FLAG_MAIN_03_240") then
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0404_030_050")
        Field_Talk_End_Not_LetterBox()
      end
      if Flg.Check("FLAG_MAIN_03_220", "FLAG_MAIN_03_240") then
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0404_030_010")
        MessageClose()
        MessageTalkSel(2, "f_t0404_030_020")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_t0404_030_030")
        elseif result == RESULT_TALK01 then
          Message("f_t0404_030_040")
        end
        Message("f_t0404_030_050")
        Field_Talk_End_Not_LetterBox()
        Flg.Set("FLAG_MAIN_03_240")
      end
    end
    if talk_id == 303 then
      local fldtxt = "t04"
      local tlk = Tlk:new(fldtxt)
      tlk:StartTalkActionAndZoom("heroine")
      Message("f_t0404_060_010")
      tlk:EndTalkActionAndZoom()
    end
  elseif gMapNum == 408 then
    if talk_id == 100 then
      local fldtxt = "t04"
      if not Flg.Check("FLAG_MAIN_03_220") then
        local tlk = Tlk:new(fldtxt)
        tlk:StartTalk("npc_0003")
        tlk:Message("f_t0408_0010_0010")
        tlk:EndTalk()
      end
    end
    if npc_name == "npc_0200" then
      if Flg.Check("FLAG_MAIN_17_041", "FLAG_MAIN_17_050") then
        M390:Event_620()
      else
        local tlk = Tlk:new("t04", 1, true)
        tlk:StartTalk()
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        tlk:Message("f_t0408_0020_0010")
        local result = tlk:Select(2, "f_t0408_0020_0020")
        if result == RESULT_TALK00 then
          tlk:EndTalk()
          MapChange("d", 1204, "start_21", true, FADE_BLACK, FADE_TIME)
        end
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 201 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0408_0040_0010")
      Message("f_t0408_0040_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 202 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0408_0030_0010")
      Message("f_t0408_0030_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 203 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0408_0050_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 204 then
      local fldtxt = "t04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0408_0060_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  end
end
