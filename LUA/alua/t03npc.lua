function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = "t03"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 301 then
    if npc_name == "npc_0005" then
      local tlk = Tlk:new("t03", 1, true)
      tlk:StartTalk()
      local Mob03_e013 = Motion.Object:new(NPC, "npc_0005", "e013")
      local Mob03_e012 = Motion.Object:new(NPC, "npc_0005", "e012")
      local Mob03_e006 = Motion.Object:new(NPC, "npc_0005", "e006")
      Mob03_e012:Play(10, true)
      tlk:Message("f_t0302_0100_0010")
      START_TALK_ACTION_AND_ZOOM("npc_0005", true, false)
      tlk:Message("f_t0302_0100_0020")
      Mob03_e006:Play(10, true)
      tlk:Message("f_t0302_0100_0030")
      Mob03_e013:Play(10, true)
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0005", true, false)
    end
    if npc_name == "sub072_007" then
      require("S090_072")
      S090_072:Event_050()
    end
  elseif gMapNum == 302 then
    if npc_name == "npc_0300" then
      local npc_0300 = Obj:new(NPC, "npc_0300")
      local e015 = Motion.Object:new(NPC, "npc_0300", "e015")
      local e012 = Motion.Object:new(NPC, "npc_0300", "e012")
      local fldtxt = "t03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e015:Play(10, true)
      npc_0300:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0010_0010")
      npc_0300:ResetExporession(10)
      e012:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0301" then
      local npc_0301 = Obj:new(NPC, "npc_0301")
      local fldtxt = "t03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0301:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0020_0010")
      npc_0301:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0307" then
      local npc_0307 = Obj:new(NPC, "npc_0307")
      local fldtxt = "t03"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0307:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0040_0010")
      npc_0307:ResetExporession(10)
      Message("f_t0302_0040_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "npc_0311" then
      local fldtxt = "t03"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      local npc_0310 = Obj:new(NPC, "npc_0310")
      local npc_0311 = Obj:new(NPC, "npc_0311")
      local KOAN01_e002 = Motion.Object:new(NPC, "npc_0310", "e002")
      local KOAN01_e008 = Motion.Object:new(NPC, "npc_0310", "e008")
      local KOAN01_e012 = Motion.Object:new(NPC, "npc_0310", "e012")
      local KOAN02_e008 = Motion.Object:new(NPC, npc_name, "e008")
      local KOAN02_e012 = Motion.Object:new(NPC, npc_name, "e012")
      KOAN01_e008:Play(10, true)
      npc_0310:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0050_0010")
      npc_0310:ResetExporession(10)
      KOAN02_e012:Play(10, true)
      npc_0311:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0060_0010")
      KOAN02_e008:Play(10, true)
      Message("f_t0302_0060_0020")
      npc_0311:ResetExporession(10)
      KOAN01_e002:Play(10, true)
      npc_0310:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0050_0020")
      npc_0310:ResetExporession(10)
      KOAN01_e012:Play(10, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "father02" then
      local father02 = Obj:new(NPC, "father02")
      local fldtxt = "t03"
      START_TALK_ACTION_AND_ZOOM("father02", true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      father02:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0150_0010")
      father02:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM("father02", true, false)
    end
    if npc_name == "npc_0316" then
      local fldtxt = "t03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      M100:Event_030()
      if Flg.Check("FLAG_MAIN_03_370", "FLAG_MAIN_03_380") then
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_t0302_0180_0010")
        Field_Talk_End_Not_LetterBox()
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0317" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      M100:Event_120()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_0318" then
      local npc_0318 = Obj:new(NPC, "npc_0318")
      local fldtxt = "t03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0318:ChangeExpression("F01", EYE_BLINK, true, 10)
      Message("f_t0302_0190_0010")
      npc_0318:ResetExporession(10)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_mother" then
      if not Flg.Check("FLAG_MAIN_03_180") then
        M080:Evetn_030()
      else
        local npc_mother = Obj:new(NPC, "npc_mother")
        local fldtxt = "t03"
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_mother:ChangeExpression("F04", EYE_BLINK, true, 10)
        Message("f_t0302_0070_0010")
        npc_mother:ResetExporession(10)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_001" then
      local fldtxt = "t03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_t0302_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_t0302_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(30, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0302_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_t0302_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_t0302_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "npc_0500" then
      require("S010_003")
      S010_003:Event_010()
    end
    if npc_name == "npc_0501" then
      if Flg.Check("FLAG_S003_001") then
        require("S010_003")
        S010_003:Event_020()
      else
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_t0302_0050_0010")
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "S200_147_hiroko_01" then
      require("S200_147")
      S200_147:Event_010()
    end
    if npc_name == "s910_171_002" then
      require("S910_171")
      S910_171:Event_020()
    end
  elseif gMapNum == 303 then
    if talk_id == 304 then
      M040:Event_040()
      M040:Event_030()
    end
    if npc_name == "Aegio_02" then
      local tlk = Tlk:new("t03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0303_0010_0010")
      tlk:EndTalk()
    end
    if npc_name == "Giru_01" then
      require("S010_003")
      S010_003:Event_040()
    end
  elseif gMapNum == 304 and npc_name == "npc_0002" then
    local fe04 = Motion.Object:new(NPC, "npc_0002", "fe04")
    local npc_0002 = Obj:new(NPC, "npc_0002")
    Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0002"), "F03")
    START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_Start_Not_LetterBox(npc_text, 1)
    fe04:Play(20, true)
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0002"), "F03", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Message("f_t0304_0010_0010")
    Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0002"), 10)
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Field_Talk_End_Not_LetterBox()
  end
end
