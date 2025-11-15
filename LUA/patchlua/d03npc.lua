function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  print("map num" .. gMapNum)
  if gMapNum == 301 then
    local npc_text = "d0301"
    if npc_name == "npc_0400" then
      local fldtxt = "d03"
      local mozya_bn01 = Motion.Object:new(NPC, "npc_0400", "bn01")
      local mozya_fq02 = Motion.Object:new(NPC, "npc_0400", "fq02")
      if Flg.Check("FLAG_MAIN_05_082") then
        START_TALK_ACTION_AND_ZOOM("npc_0400", true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        mozya_fq02:Play(10, true)
        Message("f_d0301_0040_0100")
        mozya_bn01:Play(10, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM("npc_0400", true, true)
      elseif Qst.Main:Check(170, 22, 23) then
        local tlk = Tlk:new("d03", 1, true)
        START_TALK_ACTION_AND_ZOOM("npc_0400", true, true)
        tlk:StartTalk()
        tlk:Message("f_d0301_0040_0030")
        mozya_fq02:Play(10, true)
        tlk:Message("f_d0301_0040_0070")
        mozya_bn01:Play(10, true)
        tlk:EndTalk()
        END_TALK_ACTION_AND_ZOOM("npc_0400", true, true)
      else
        START_TALK_ACTION_AND_ZOOM("npc_0400", true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0301_0040_0070")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM("npc_0400", true, true)
      end
    end
    if talk_id == 500 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0090_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 501 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0100_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 502 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0110_0010")
      Message("f_d0301_0110_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "card_001" then
      local fldtxt = "d03"
      local okuta = GetIndex(NPC, "card_001")
      local okuta01 = Obj:new(NPC, "card_001")
      local player = Field.GetPlayerIndex()
      local card_001_pos = Field.ObjectGetPosition(NPC, okuta)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(card_001_pos.x, card_001_pos.z, player_pos.x, player_pos.z)
      local card_001_bn01 = Motion.Object:new(NPC, "card_001", "bn01")
      local card_001_fe02 = Motion.Object:new(NPC, "card_001", "fe02")
      local card_001_fe04 = Motion.Object:new(NPC, "card_001", "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_9000_0010")
      Field.ObjectSetRotationY(FLD_OBJ_NPC, okuta, y_degree, 30)
      WaitFrame(30)
      card_001_fe02:Play(10, true)
      Message("f_d0301_9000_0020")
      card_001_bn01:Play(10, true)
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0301_9000_0030")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1306, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0301_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0301_9000_0060")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0301_9000_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
      okuta01:ClearRotationY(30)
    end
    if talk_id == 504 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0130_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 505 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0140_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 506 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0150_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 600 then
      local bn02 = Motion.Object:new(NPC, "npc_0600", "bn02")
      local f004 = Motion.Object:new(NPC, "npc_0600", "f004")
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0600"), "F02", EYES_BLINK_TYPE_BLINK, false, 30)
      f004:Play(20, true)
      Message("f_d0301_0180_0010")
      Message("f_d0301_0180_0020")
      bn02:Play(20, true)
      Message("f_d0301_0180_0030")
      Message("f_d0301_0180_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0600"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 601 then
      local fldtxt = "d03"
      local bn01 = Motion.Object:new(NPC, "npc_0601", "bn01")
      local bn02 = Motion.Object:new(NPC, "npc_0601", "bn02")
      local f004 = Motion.Object:new(NPC, "npc_0601", "f004")
      local fq01 = Motion.Object:new(NPC, "npc_0601", "fq01")
      local fq02 = Motion.Object:new(NPC, "npc_0601", "fq02")
      local player = Obj:new(PLAYER, "")
      local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
      if Flg.Check("FLAG_MAIN_09_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        bn02:Play(20, true)
        Message("f_d0301_0250_0010")
        f004:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0601"), "F03", EYES_BLINK_TYPE_BLINK, false, 30)
        Message("f_d0301_0250_0020")
        Message("f_d0301_0250_0030")
        fq01:Play(20, true)
        Message("f_d0301_0250_0040")
        bn01:Play(20, true)
        MessageClose()
        player_e002_01:Play(10, false)
        WaitFrame(30)
        fq01:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0601"), "F02", EYES_BLINK_TYPE_BLINK, false, 30)
        Message("f_d0301_0250_0050")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0601"), "F01", EYES_BLINK_TYPE_BLINK, false, 30)
        bn02:Play(20, true)
        Message("f_d0301_0250_0060")
        Message("f_d0301_0250_0070")
        f004:Play(20, true)
        Message("f_d0301_0250_0080")
        Message("f_d0301_0250_0090")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0601"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        fq01:Play(20, true)
        Message("f_d0301_0180_0090")
        Message("f_d0301_0180_0100")
        f004:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0601"), "F02", EYES_BLINK_TYPE_BLINK, false, 30)
        Message("f_d0301_0180_0110")
        bn02:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0601"), "F01", EYES_BLINK_TYPE_BLINK, false, 30)
        Message("f_d0301_0180_0120")
        Message("f_d0301_0180_0130")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0601"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 602 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0190_0010")
      Message("f_d0301_0190_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 603 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0190_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 604 then
      local fldtxt = "d03"
      if Flg.Check("FLAG_MAIN_09_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0301_0230_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0301_0200_0010")
        Message("f_d0301_0200_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 605 then
      local fldtxt = "d03"
      if Flg.Check("FLAG_MAIN_09_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0301_0240_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0301_0210_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 606 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0220_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 607 then
      local fldtxt = "d03"
      local fe04 = Motion.Object:new(NPC, "npc_0607", "fe04")
      local bn02 = Motion.Object:new(NPC, "npc_0607", "bn02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0260_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0607"), "F03", EYES_BLINK_TYPE_BLINK, false, 30)
      fe04:Play(10, true)
      Message("f_d0301_0260_0020")
      bn02:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s020_018_npc02" then
      require("S020_018")
      S020_018:Event_160()
    end
    if npc_name == "s020_018_npc01" then
      require("S020_018")
      if not Flg.Check("FLAG_IS_CLEAR_S020_018") then
        local swim
        if Flg.Check("FLAG_SUB_020_018_002") and swim == nil and Flg.Check("FLAG_SUB_020_018_004") then
          require("S020_018")
          swim = S020_018:Event_100()
          if swim == true then
            Flg.Set("FLAG_SUB_020_018_003")
            MovePlayerToLocatorFrame("evt_9000", 75)
            Field_InvisibleFollowerAllGuest(0, 0, false)
            Field_InvisibleFollowerAllPartyMember(0, 0, false)
            if not Flg.Check("FLAG_IS_SWIM") then
              Prcs_d03_ResetMoveMotion()
            end
            Flg.Clear("FLAG_SUB_020_018_004")
          end
        end
      else
        S020_018:Event_145()
      end
    end
    if npc_name == "npc_warp01" then
      D03_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      D03_WarpNPC_After(npc_name)
    end
  end
  if gMapNum == 302 then
    local npc_text = "d03"
    if npc_name == "map_0001" then
      local tlk = Tlk:new(npc_text, 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0302_0070_0010")
      tlk:EndTalk()
      Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      OpenWorldMap(DW, LOCOMON)
      Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
    end
    if npc_name == "Shop_001" then
      local cam_npc = {
        -33.97,
        5.28,
        53.28,
        -27.22,
        5.28,
        60.66
      }
      local cam_shop = {
        -35.71,
        5.28,
        54.53,
        -27.76,
        5.33,
        60.6
      }
      CommonShopStart(npc_name, 122, "ba02", "fe02", "fe04", cam_npc, cam_shop)
    end
    if npc_name == "Shop_002" then
      local cam_npc = {
        -36.06,
        5.41,
        54.34,
        -29.97,
        5.27,
        62.27
      }
      local cam_shop = {
        -39.98,
        6.9,
        55.63,
        -30.33,
        5.39,
        61.82
      }
      CommonShopStart(npc_name, 112, "fq01", "fe02", "fq01", cam_npc, cam_shop)
    end
    if npc_name == "npc_5001" then
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0302_0220_0010")
      tlk:Message("f_d0302_0220_0020")
      tlk:EndTalk()
      M280:Event_030()
    end
    if npc_name == "npc_5000" then
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0302_0210_0010")
      tlk:Message("f_d0302_0210_0020")
      tlk:EndTalk()
      M280:Event_040()
    end
    local fldtxt = "d03"
    if npc_name == "npc_0001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0020_0010")
      Message("f_d0302_0020_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 102 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0260_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 103 then
      local fldtxt = "d03"
      if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0270_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        if Flg.Check("FLAG_IS_SWIM") then
          Field_InvisibleFollowerAllPartyMember(0, 0, false)
          Field_InvisibleFollowerAllGuest(0, 0, false)
        end
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0450_0010")
        Message("f_d0302_0450_0020")
        Message("f_d0302_0450_0030")
        Message("f_d0302_0450_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        if Flg.Check("FLAG_IS_SWIM") then
          Field_InvisibleFollowerAllPartyMember(0, 0, false)
          Field_InvisibleFollowerAllGuest(0, 0, false)
        end
      end
    end
    if npc_name == "npc_0004" then
      local fldtxt = "d03"
      if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
        if Flg.Check("FLAG_MAIN_05_075") then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_0010_0010")
          Message("f_d0302_0010_0020")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          M170:Event_040()
        end
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0410_0010")
        Message("f_d0302_0410_0020")
        Message("f_d0302_0410_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "npc_0008" then
      local fldtxt = "d03"
      if Flg.Check("FLAG_MAIN_05_085") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0140_0010")
        Message("f_d0302_0140_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        M170:Event_090()
      end
    end
    if talk_id == 106 then
      local fldtxt = "d03"
      Cam.Inst:Set(-60.380051, 5.600083, 84.990944, -51.363537, 4.449427, 80.022109, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0030_0010")
      Message("f_d0302_0030_0020")
      Message("f_d0302_0030_0030")
      Message("f_d0302_0030_0040")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
      if Flg.Check("FLAG_IS_SWIM") then
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
    end
    if talk_id == 119 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(46.554058, 4.901892, 60.199127, 51.964676, 4.091996, 68.56987, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0040_0010")
      Message("f_d0302_0040_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 112 then
      local fldtxt = "d03"
      Cam.Inst:Set(-98.307198, 5.726264, 61.512619, -87.695488, 2.542855, 69.424919, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0050_0010")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 113 then
      local fldtxt = "d03"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0060_0010")
      Message("f_d0302_0060_0020")
      Cam.Inst:Set(-98.307198, 5.726264, 61.512619, -87.695488, 2.542855, 69.424919, default, 30)
      WaitFrame(30)
      Message("f_d0302_0060_0030")
      Message("f_d0302_0060_0040")
      Message("f_d0302_0050_0010")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(45)
    end
    if talk_id == 114 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0080_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 115 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0090_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 116 then
      local fldtxt = "d03"
      if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0100_0010")
        Message("f_d0302_0100_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      elseif Common.CheckTimeAxis("A2028_daft_200", "A2028_daft_450") then
        if not Flg.Check("FLAG_MAIN_09_068") then
          M280:Event_050()
        else
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_0100_0010")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      end
    end
    if talk_id == 117 then
      local fldtxt = "d03"
      if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0110_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      elseif Common.CheckTimeAxis("A2028_daft_200", "A2028_daft_450") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0430_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "roko_01" then
      local fldtxt = "d02"
      Cam.Inst:Set(67.53, 4.903, 86.68, 76.09, 6.252, 81.69, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0630_0040")
      Message("f_d0201_0630_0050")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_0018" then
      local fldtxt = "d03"
      if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0190_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0400_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "npc_0200" then
      M170:Event_063()
    end
    if npc_name == "card_001" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0302_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1301, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0302_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0302_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1302, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0302_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "card_003" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_9020_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0302_9020_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1303, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_9020_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0302_9020_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0302_9020_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "s200_150_001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      require("S200_150")
      if not Qst.Sub:Check(150, 255) then
        S200_150:Event_010()
      else
        S200_150:Event_065()
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "hoe_01" then
      M280:Event_116()
    end
    if npc_name == "npc_0305" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0280_0010")
      Message("f_d0302_0280_0020")
      Message("f_d0302_0280_0030")
      Message("f_d0302_0280_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0307" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(47.384922, 5.320691, 55.164619, 38.966343, 4.104876, 60.422882, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0300_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 309 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      PlayerLookAtObject(NPC, "npc_0309")
      Message("f_d0302_0320_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 310 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0330_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 110 then
      local fldtxt = "d03"
      if not Flg.Check("FLAG_MAIN_09_063") then
        M280:Event_040()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Set(46.378513, 4.800456, 53.53155, 37.75769, 4.362429, 58.610264, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0302_0420_0010")
        Message("f_d0302_0420_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Clear(30)
      end
    end
    if talk_id == 306 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0290_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 308 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0310_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 311 then
      local fldtxt = "d03"
      local fq01 = Motion.Object:new(NPC, "npc_0311", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      if Flg.Check("FLAG_IS_SWIM") then
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
      Cam.Inst:Set(-65.120102, 3.699553, 75.861771, -55.477104, 2.333471, 73.593193, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0340_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0311"), "F01", EYES_BLINK_TYPE_CLOSE, false, 10)
      fq01:Play(20, true)
      Message("f_d0302_0340_0020")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0311"), 10)
      Message("f_d0302_0340_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Cam.Inst:Clear(30)
      if Flg.Check("FLAG_IS_SWIM") then
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
    end
    if talk_id == 312 then
      local fldtxt = "d03"
      local bn02 = Motion.Object:new(NPC, "npc_0312", "bn02")
      local bv01 = Motion.Object:new(NPC, "npc_0312", "bv01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0312"), "F01", EYES_BLINK_TYPE_CLOSE, false, 30)
      bn02:Play(20, true)
      Message("f_d0302_0370_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0312"), "F03", EYES_BLINK_TYPE_BLINK, false, 30)
      bv01:Play(20, true)
      Message("f_d0302_0370_0020")
      Message("f_d0302_0370_0030")
      Message("f_d0302_0370_0040")
      Field.ObjectClearExpression(NPC, GetIndex(NPC, "npc_0312"), 30)
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0312"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 313 then
      local fldtxt = "d03"
      local fe04 = Motion.Object:new(NPC, "npc_0313", "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(-105.072777, 3.357205, 56.077614, -97.948563, 2.334902, 62.797424, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe04:Play(20, true)
      Message("f_d0302_0380_0010")
      Message("f_d0302_0380_0020")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0313"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if npc_name == "Shop_003" then
      local cam_npc = {
        -33.97,
        5.28,
        53.28,
        -27.22,
        5.28,
        60.66
      }
      local cam_shop = {
        -35.71,
        5.28,
        54.53,
        -27.76,
        5.33,
        60.6
      }
      CommonShopStart(npc_name, 122, "ba02", "fe02", "fe04", cam_npc, cam_shop)
    end
    if npc_name == "Shop_004" then
      local cam_npc = {
        -36.06,
        5.41,
        54.34,
        -29.97,
        5.27,
        62.27
      }
      local cam_shop = {
        -39.98,
        6.9,
        55.63,
        -30.33,
        5.39,
        61.82
      }
      CommonShopStart(npc_name, 112, "fq01", "fe02", "fq01", cam_npc, cam_shop)
    end
    if npc_name == "npc_0500" then
      local tlk = Tlk:new("d03", 1, true)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      tlk:Message("f_d0302_0480_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s020_173_001" then
    end
    if npc_name == "s020_018_npc01" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      require("S020_018")
      S020_018:Event_010()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "s020_018_npc02" then
      require("S020_018")
      S020_018:Event_150()
    end
    if npc_name == "s020_173_001" then
      require("S020_173")
      S020_173:Event_050()
    end
    if npc_name == "npc_warp01" then
      D03_WarpNPC_After(npc_name)
    end
    if npc_name == "card_shop_0001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      CommonShopStart_NoZoomCam(npc_name, 167, "fe02", "fe04", "fe04", "bn01")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
  end
  if gMapNum == 303 then
    if npc_name == "ride_submarine" then
      M170:Event_170()
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_BeforeD03(npc_name)
    end
    if npc_name == "s020_172_001" then
      require("S020_172")
      S020_172:Event_010()
    end
    if npc_name == "s020_172_003" then
      require("S020_172")
      S020_172:Event_020()
    end
    if npc_name == "npc_warp01" then
      D03_WarpNPC_Before(npc_name)
    end
  end
  if gMapNum == 304 then
    if talk_id == 3 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 4 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0304_0020_0010")
      Message("f_d0304_0020_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s020_019_001" then
      require("S020_019")
      S020_019:Event_050()
      S020_019:Event_010()
    end
    if npc_name == "s020_019_nepu_02" then
      require("S020_019")
      S020_019:Event_030()
    end
    if npc_name == "s110_102_001" then
      require("S110_102")
      S110_102:Event_010()
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD03(npc_name)
    end
    if npc_name == "npc_warp01" or npc_name == "npc_warp02" then
      if Qst.Sub:Check(19, 10, 255) then
        require("S020_019")
        S020_019:Event_045()
      else
        D03_WarpNPC_After(npc_name)
      end
    end
  end
  if gMapNum == 305 then
    if talk_id == 1 then
      local fldtxt = "d03"
      local e101 = Motion.Object:new(NPC, "npc_0001", "e101")
      local e105 = Motion.Object:new(NPC, "npc_0001", "e105")
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01")
      if Qst.Sub:Check(19, 5, 255) or Qst.Sub:Check(13, 1, 255) or Qst.Sub:Check(102, 5, 255) then
        require("S020_019")
        S020_019:Event_020()
        require("S020_013")
        S020_013:Event_010()
        require("S110_102")
        S110_102:Event_025()
      elseif not Flg.Check("FLAG_MAIN_09_070") then
        Cam.Inst:Set(-0.146, 49.77, -130.27, 2.448, 47.17, -120.97, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e101:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d0305_0010_0010")
        e105:Play(20, true)
        Message("f_d0305_0010_0020")
        e101:Play(20, true)
        Message("f_d0305_0010_0030")
        Message("f_d0305_0010_0040")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001"), 30)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Clear(30)
      elseif Flg.Check("FLAG_MAIN_09_070") then
        Cam.Inst:Set(0.399349, 48.764767, -129.08287, 0.488961, 45.564533, -119.6092, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e101:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d0305_0080_0010")
        Message("f_d0305_0080_0020")
        Message("f_d0305_0080_0030")
        e105:Play(20, true)
        Message("f_d0305_0080_0040")
        Message("f_d0305_0080_0050")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001"), 30)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Clear(30)
      end
    end
    if talk_id == 2 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(-7.9299, 10.743, 59.272, -8.6307, 8.9719, 69.089, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0020_0010")
      Message("f_d0305_0020_0020")
      Message("f_d0305_0020_0030")
      Message("f_d0305_0020_0040")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 3 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(-9.838309, 12.59178, -13.233348, -6.443927, 9.905894, -4.218682, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0003"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      Message("f_d0305_0030_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0003"), 30)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 4 then
      local fldtxt = "d03"
      local bn01 = Motion.Object:new(NPC, "npc_0004", "bn01")
      local fq01 = Motion.Object:new(NPC, "npc_0004", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(8.341629, 3.302795, 36.594944, 6.114846, 2.42454, 46.304222, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      bn01:Play(20, true)
      Message("f_d0305_0040_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0004"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
      fq01:Play(20, true)
      Message("f_d0305_0040_0020")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0004"), "F01", EYES_BLINK_TYPE_BLINK, false, 0)
      bn01:Play(20, true)
      Message("f_d0305_0040_0030")
      fq01:Play(20, true)
      Message("f_d0305_0040_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0004"), 30)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 5 then
      local fldtxt = "d03"
      local fq01 = Motion.Object:new(NPC, "npc_0005", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(23.298401, 25.057878, -44.307274, 19.225245, 21.701305, -35.813583, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0050_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0005"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
      fq01:Play(20, true)
      Message("f_d0305_0050_0020")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0005"), 30)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if npc_name == "card_001" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0305_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1304, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0305_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0305_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0305_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 8 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(0.974821, 7.217247, 70.651382, 0.068696, 7.309839, 80.609818, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0060_0010")
      Message("f_d0305_0060_0020")
      Message("f_d0305_0060_0030")
      Message("f_d0305_0060_0040")
      Message("f_d0305_0060_0050")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 7 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(5.745755, 4.180442, 66.184929, -0.536771, 1.545268, 73.505157, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0070_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
  end
  if npc_name == "S020_019_game_01" then
    require("S020_019")
    require("S110_102")
    if Qst.Sub:Check(S110_102.ID, S110_102.STEP_010, S110_102.STEP_015) then
      S110_102:Event_030()
    else
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      SetNpcTalkZoomCamera(npc_name, 0.4, 2, 45, 1)
      S020_019:Event_060()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      ClearNpcTalkZoomCamera(45, 1)
    end
  end
  if gMapNum == 306 and talk_id == 500 then
    local fldtxt = "d03"
    START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_Start_Not_LetterBox(fldtxt, 1)
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0500"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Message("f_d0306_0020_0010")
    Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0500"), 30)
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_End_Not_LetterBox()
  end
  if gMapNum == 308 then
    if talk_id == 101 then
      local fldtxt = "d03"
      if Flg.Check("FLAG_MAIN_05_087") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0308_0010_0030")
        Message("f_d0308_0010_0040")
        Message("f_d0308_0010_0050")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0308_0010_0010")
        Message("f_d0308_0010_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "npc_0003" then
      local fldtxt = "d03"
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0003"), "F01_T01")
      START_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0003"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d0308_0100_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0003"), 30)
      END_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s020_013_venus" then
    end
    if npc_name == "card_001" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0308_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0308_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1305, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0308_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0308_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0308_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "s020_018_npc01" then
      require("S020_018")
      S020_018:Event_040()
    end
  end
end

function D03_WarpNPC_After(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  local map_id = Field.GetMapNumber()
  if map_id == 304 or map_id == 303 then
    Cam.Inst:Set(pos.x, pos.y + 1.7, pos.z, cam_x, cam_y + 1.5, cam_z, DEFAULT_ANGLE, 15)
  else
    Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  end
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(5, "f_d0107_0100_0120")
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 or result == RESULT_TALK03 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_FIELD_D03_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 302, "start_41", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 301, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 304, "start_10", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK03 then
      MapChange("d", 305, "start_30", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function D03_WarpNPC_Before(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  local map_id = Field.GetMapNumber()
  if map_id == 304 or map_id == 303 then
    Cam.Inst:Set(pos.x, pos.y + 1.7, pos.z, cam_x, cam_y + 1.5, cam_z, DEFAULT_ANGLE, 15)
  else
    Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  end
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(4, "f_d0107_0100_0110")
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_FIELD_D03_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 302, "start_40", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 301, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 303, "start_00", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end
