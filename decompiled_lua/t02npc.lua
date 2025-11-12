function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = "t02"
  local field_text = "field_text"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 201 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      FieldTalk(npc_text, 1, "f_t0201_0010_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    elseif talk_id == 301 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Shop.Open(10)
      WaitCloseShopWindow()
      ShopClose()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    elseif talk_id == 302 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Shop.Open(5)
      WaitCloseShopWindow()
      ShopClose()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    elseif talk_id == 305 then
      local fldtxt = "t02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0201_0020_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 306 then
      local otaku = Obj:new(NPC, npc_name)
      local fldtxt = "t02"
      if not Flg.Check("FLAG_MAIN_03_335") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        otaku:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0030_0010")
        Message("f_t0201_0030_0020")
        otaku:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        otaku:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0030_0030")
        otaku:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 307 then
      local meid = Obj:new(NPC, npc_name)
      local fldtxt = "t02"
      if Flg.Check("FLAG_MAIN_03_335") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        meid:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0170_0050")
        meid:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      elseif not Flg.Check("FLAG_MAIN_03_336") then
        M100:Event_047()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        meid:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0170_0040")
        meid:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 308 then
      local meid = Obj:new(NPC, npc_name)
      local fldtxt = "t02"
      if not Flg.Check("FLAG_MAIN_03_335") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        meid:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0140_0010")
        meid:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        meid:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0140_0020")
        meid:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 309 then
      local large_man = Obj:new(NPC, npc_name)
      local fldtxt = "t02"
      if not Flg.Check("FLAG_MAIN_03_335") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        large_man:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0150_0010")
        large_man:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        large_man:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0150_0020")
        large_man:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 310 then
      local man = Obj:new(NPC, npc_name)
      local fldtxt = "t02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      man:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0201_0160_0010")
      man:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 311 then
      local otaku = Obj:new(NPC, npc_name)
      local fldtxt = "t02"
      if not Flg.Check("FLAG_MAIN_03_335") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        otaku:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0180_0010")
        otaku:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        START_TALK_ACTION_AND_ZOOM(fldtxt, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        otaku:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0180_0020")
        otaku:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 312 then
      local woman = Obj:new(NPC, npc_name)
      local fldtxt = "t02"
      if not Flg.Check("FLAG_MAIN_03_335") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        woman:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0190_0010")
        Field.StartPlayerAndNpcTalkAction(npc_name)
        Message("f_t0201_0190_0020")
        woman:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        woman:ChangeExpression("F01", EYE_BLINK, true, 10)
        Message("f_t0201_0190_0010")
        woman:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_001" then
      local fldtxt = "t02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0201_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0201_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(20, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0201_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0201_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_t0201_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "t02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0201_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0201_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(21, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0201_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0201_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_t0201_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_003" then
      local fldtxt = "t02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0201_9020_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0201_9020_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(22, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0201_9020_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0201_9020_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_t0201_9020_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "npc_0500" then
      require("S095_082")
      S095_082:Event_020()
      S095_082:Event_040()
    end
    if npc_name == "npc_0501" then
      require("S095_082")
      S095_082:Event_030()
    end
    if npc_name == "s110_104_001" then
      require("S110_104")
      S110_104:Event_010()
    end
    if npc_name == "s200_146_001" then
      require("S200_146")
      S200_146:Event_015()
      S200_146:Event_010()
    end
    if npc_name == "s010_180_tomoyo" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      require("S010_180")
      S010_180:Event_010()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "s900_162_001" then
      require("S900_162")
      if Flg.Check("FLAG_SUB_900_162_005") then
        S900_162:Event_030()
      else
        S900_162:Event_010()
      end
    end
  elseif gMapNum == 203 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Shop.Open(9)
      WaitCloseShopWindow()
      ShopClose()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "card_shop_0001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      CommonShopStart_NoZoomCam(npc_name, 154, "e002", "e004", "e004", "e013")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0010" then
      local fldtxt = "t02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0203_0040_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 303 then
      if Flg.Check("FLAG_MAIN_03_336") then
        M100:Event_055()
      else
        M100:Event_050()
      end
    end
    if npc_name == "card_001" then
      local fldtxt = "t02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0203_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0203_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(23, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0203_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0203_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_t0203_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 500 then
      if Flg.Check("FLAG_S002_008") then
        require("S010_002")
        S010_002:Event_050()
      else
        require("S010_002")
        S010_002:Event_020()
      end
    end
    if npc_name == "sub110_90_003" then
    end
    if talk_id == 502 then
      require("S010_002")
      S010_002:Event_020()
    end
    if npc_name == "s110_104_001" then
      require("S110_104")
      S110_104:Event_070()
      S110_104:Event_060()
      S110_104:Event_050()
      S110_104:Event_040()
    end
    if npc_name == "s110_104_007" then
      require("S110_104")
      S110_104:Event_070()
    end
    if npc_name == "s110_105_001" then
      require("S110_105")
      S110_105:Event_024()
      S110_105:Event_020()
    end
    if npc_name == "s110_105_002" then
      require("S110_105")
      S110_105:Event_027()
    end
    if npc_name == "s110_112_001" then
      require("S110_112")
      S110_112:Event_020()
    end
    if npc_name == "s110_112_002" then
      local tlk = Tlk:new("s110_112")
      tlk:StartTalkActionAndZoom(npc_name)
      tlk:Message("s110_112_010")
      tlk:EndTalkActionAndZoom()
    end
    if npc_name == "s110_113_001" then
      require("S110_113")
      S110_113:Event_010()
    end
  end
end
