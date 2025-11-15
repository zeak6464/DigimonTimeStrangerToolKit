gGimText = "field_text"

function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  local npc_text = "d04"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 401 then
    local gGimText = "field_text"
    if talk_id == 100 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0401_0010_0010")
      Message("f_d0401_0010_0020")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 101 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0401_0010_0010")
      Message("f_d0401_0010_0020")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 104 then
      local bn01 = Motion.Object:new(NPC, "palmon_02", "bn01")
      local fq01 = Motion.Object:new(NPC, "palmon_02", "fq01")
      local fq02 = Motion.Object:new(NPC, "palmon_02", "fq02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0401_0070_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "hawkmon_01" then
      local bn01 = Motion.Object:new(NPC, "hawkmon_01", "bn01")
      local e002 = Motion.Object:new(NPC, "hawkmon_01", "e002")
      local fq01 = Motion.Object:new(NPC, "hawkmon_01", "fq01")
      local fq02 = Motion.Object:new(NPC, "hawkmon_01", "fq02")
      local fe02 = Motion.Object:new(NPC, "hawkmon_01", "fe02")
      local fe04 = Motion.Object:new(NPC, "hawkmon_01", "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      e002:PlayWithStartMoveMotion(10, 10)
      Message("f_d0401_0500_0010")
      fq01:PlayWithStartMoveMotion(10, 10)
      Message("f_d0401_0500_0020")
      e002:PlayWithStartMoveMotion(10, 10)
      Message("f_d0401_0500_0030")
      fe04:PlayWithStartMoveMotion(10, 10)
      Message("f_d0401_0500_0040")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 500 then
      local bn01 = Motion.Object:new(NPC, "map_0001", "bn01")
      local fq01 = Motion.Object:new(NPC, "map_0001", "fq01")
      local fq02 = Motion.Object:new(NPC, "map_0001", "fq02")
      local fe02 = Motion.Object:new(NPC, "map_0001", "fe02")
      local fe04 = Motion.Object:new(NPC, "map_0001", "fe04")
      if Flg.Check("FLAG_MAIN_06_060", "FLAG_FIELD_D0401_001") then
        Field_Talk_Start(npc_text, 1)
        fq02:PlayWithStartMoveMotion(10, 10)
        Message("f_d0401_0500_0010")
        Message("f_d0401_0500_0020")
        Message("f_d0401_0500_0030")
        fq01:PlayWithStartMoveMotion(10, 10)
        Message("f_d0401_0500_0040")
        Field_Talk_End()
        Flg.Set("FLAG_FIELD_D0401_001")
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        OpenWorldMap(DW, LOCOMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      else
        Field_Talk_Start(npc_text, 1)
        fq01:PlayWithStartMoveMotion(10, 10)
        Message("f_d0401_0060_0010")
        Field_Talk_End()
        Flg.Clear("FLAG_GIMMICK_D03_220")
        Guest.Delete(23481)
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        OpenWorldMap(DW, LOCOMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      end
    end
    if talk_id == 501 then
      if not Flg.Check("FLAG_GIMMICK_D04_250") and not Flg.Check("FLAG_GIMMICK_D04_270") then
        Field_Talk_Start(npc_text, 1)
        Message(202)
        Field_Talk_End()
      end
      if Flg.Check("FLAG_GIMMICK_D04_270") then
        Pros_d0401_ParumonAlsoJoin()
      end
    end
    if talk_id == 502 then
      SetControlScriptExternalVariable("ride_fly", "start")
    end
    if talk_id == 900 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message(9001)
      Message(9002)
      Message(9003)
      Message(9004)
      if Common.IsSettingWaitForRide() == true then
        MessageTalkSel(3, 9201)
      else
        MessageTalkSel(2, 9201)
      end
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Message(9011)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        Guest.Add(23481)
        Common.ClearWaitForRide()
        Common.SetGuestToWaitForRide(23481)
        FadeOutWithWait(0, 30)
        Field.CheckSyncFollower(true)
        Obj:new(NPC, "guest_palmon02"):Invisible()
        FadeInWithWait(0, 30)
      elseif result == RESULT_TALK01 then
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        FadeOutWithWait(0, 30)
        Common.ClearWaitForRide()
        Guest.Add(23481)
        Field.CheckSyncFollower(true)
        FadeInWithWait(0, 30)
      else
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        Common.ClearWaitForRide()
        FadeOutWithWait(0, 30)
        Field.CheckSyncFollower(true)
        FadeInWithWait(0, 30)
      end
    end
    if talk_id == 901 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message(9101)
      Message(9102)
      Message(9103)
      Message(9104)
      if Common.IsSettingWaitForRide() == true then
        MessageTalkSel(4, 9204)
      else
        MessageTalkSel(3, 9204)
      end
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Message(9111)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        Guest.Add(23041)
        Common.ClearWaitForRide()
        Common.SetGuestToWaitForRide(23041)
        FadeOutWithWait(0, 30)
        Field.CheckSyncFollower(true)
        Obj:new(NPC, "Guest_kabuteri"):Invisible()
        FadeInWithWait(0, 30)
      elseif result == RESULT_TALK01 then
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        FadeOutWithWait(0, 30)
        Common.ClearWaitForRide()
        Common.SetPartyDigimonToWaitForRide(Digimon.GetUniqueIDInPartyMember(5))
        Field.CheckSyncFollower(true)
        FadeInWithWait(0, 30)
      elseif result == RESULT_TALK02 then
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        FadeOutWithWait(0, 30)
        Common.ClearWaitForRide()
        Common.SetPartyDigimonToWaitForRide(Digimon.GetUniqueIDInPartyMember(6))
        Field.CheckSyncFollower(true)
        FadeInWithWait(0, 30)
      else
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        Common.ClearWaitForRide()
        FadeOutWithWait(0, 30)
        Field.CheckSyncFollower(true)
        FadeInWithWait(0, 30)
      end
    end
    if talk_id == 200 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0401_0150_0010")
      Message("f_d0401_0150_0020")
      Message("f_d0401_0150_0030")
      Message("f_d0401_0150_0040")
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
      Message("f_d0401_0100_0030")
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
    if npc_name == "s040_032_002" or npc_name == "s040_032_001" then
      require("S040_032")
      S040_032:Event_015()
      S040_032:Event_010()
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD04(npc_name)
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After(npc_name)
    end
  end
  if gMapNum == 402 then
    if talk_id == 1 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0402_0030_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 2 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0402_0040_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 3 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0402_0050_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s040_033_001" then
      require("S040_033")
      S040_033:Event_010()
    end
    if npc_name == "s040_033_004" then
      require("S040_033")
      S040_033:Event_020()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After(npc_name)
    end
  end
  if gMapNum == 403 then
    if talk_id == 300 then
      if not Flg.Check("FLAG_GIMMICK_D04_300") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        Message(101)
        Message(102)
        MessageTalkSel(2, 111)
        Field_Talk_End()
        Motion.Object:PlayWithStartMoveMotion("e015", 10, 10)
        WaitFrame(60)
        Field_Talk_Start(npc_text, 1)
        Message(103)
        Message(104)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        Flg.Set("FLAG_GIMMICK_D04_300")
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        Message(104)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
      end
    end
    if talk_id == 301 then
      SetControlScriptExternalVariable("ride_fly", "start")
    end
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
      Message("f_d0403_0070_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_001" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0403_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0403_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1402, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0403_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0403_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0403_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "s040_032_003" then
      require("S040_032")
      S040_032:Event_020()
    end
    if npc_name == "s040_032_007" or npc_name == "s040_032_006" then
      require("S040_032")
      S040_032:Event_040()
    end
    if npc_name == "s040_032_011" then
      S040_032:Event_060()
    end
    if npc_name == "s040_033_001" or npc_name == "s040_033_002" then
      require("S040_033")
      S040_033:Event_060()
    end
    if npc_name == "s110_109_001" then
      require("S110_109")
      S110_109:Event_010()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After(npc_name)
    end
  end
  if gMapNum == 404 then
    if talk_id == 900 then
      require("exchange_npc")
      Exchange_chr611()
    end
    if talk_id == 305 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start("d0404", 1)
      Message(113)
      MessageTalkSel(2, 201)
      local result = Talk.GetResultSelectedNum()
      if result == 0 then
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
      elseif result == 1 then
        Message(111)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        Flg.Set("FLAG_GIMMICK_D04_320")
        Guest.Add(23041)
        FadeOutWithWait(0, 30)
        Obj:new(NPC, "npc_0007"):Invisible()
        Field.CheckSyncFollower()
        FadeInWithWait(0, 30)
      end
    end
    if talk_id == 100 then
      require("S030_029")
      local flags = {
        "FLAG_MAIN_10_030",
        "FLAG_MAIN_10_031"
      }
      local time_axis = TimeTravel.GetTimeAxis()
      if Qst.Sub:Check(S030_029.ID, S030_029.STEP_001, S030_029.STEP_010) and Common.CheckTimeAxis("A2028_daft_419") then
        S030_029:Event_010()
      elseif Flg.AllCheck(flags) and not Flg.Check("FLAG_MAIN_10_040") then
        M300:Event_050()
      elseif Flg.Check("FLAG_MAIN_06_060", "FLAG_MAIN_07_010") then
        Cam.Inst:Set(3.2826275, 2.582027, -15.271922, 4.498428, 1.588274, -5.395529, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0010_0020")
        Message("f_d0404_0010_0030")
        Message("f_d0404_0010_0040")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
      elseif Flg.Check("FLAG_MAIN_06_040", "FLAG_MAIN_06_050") then
        local e115 = Motion.Object:new(NPC, "bacchus_01", "e115")
        local e100 = Motion.Object:new(NPC, "bacchus_01", "e100")
        Cam.Inst:Set(3.2826275, 2.582027, -15.271922, 4.498428, 1.588274, -5.395529, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        e115:Play(10, true)
        Message("f_d0404_0010_0010")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
        WaitFrame(30)
        e100:Play(10, true)
      elseif Flg.Check("FLAG_MAIN_10_055", "FLAG_MAIN_10_058") then
        local tlk = Tlk:new("d04", 1, true)
        local e101 = Motion.Object:new(NPC, "bacchus_01", "e101")
        local e100 = Motion.Object:new(NPC, "bacchus_01", "e100")
        Cam.Inst:Set(3.2826275, 2.582027, -15.271922, 4.498428, 1.588274, -5.395529, default, 30)
        WaitFrame(30)
        tlk:StartTalk()
        Field.ObjectLookAtTheObject(PLAYER, 1, NPC, GetIndex(NPC, "bacchus_01"), 30)
        e101:Play(10, true)
        tlk:Message("f_d0404_0230_0020")
        local result = tlk:Select(2, "f_d0404_0230_0021")
        if result == RESULT_TALK00 then
          e100:Play(10, true)
          Fade_OutNoLoadingWithWait(FADE_BLACK, 90)
          tlk:EndTalk()
          M300:Event_200()
        else
          Cam.Inst:Clear(30)
          e100:Play(10, true)
          tlk:EndTalk()
        end
      elseif Flg.Check("FLAG_MAIN_06_030", "FLAG_MAIN_06_040") then
        M180:Event_150()
      else
        local e101 = Motion.Object:new(NPC, "bacchus_01", "e101")
        local e100 = Motion.Object:new(NPC, "bacchus_01", "e100")
        Cam.Inst:Set(3.2826275, 2.582027, -15.271922, 4.498428, 1.588274, -5.395529, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        e101:Play(10, true)
        Message("f_d0404_0230_0010")
        e100:Play(10, true)
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
      end
    end
    if talk_id == 101 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0020_0010")
      Message("f_d0404_0020_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 104 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0050_0020")
        Message("f_d0404_0050_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0050_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 105 then
      if Flg.Check("FLAG_MAIN_06_060") then
        Cam.Inst:Set(47.564301, -0.399573, 32.529652, 41.19281, -2.701823, 25.174126, default, 45)
        WaitFrame(40)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0060_0060")
        Message("f_d0404_0060_0070")
        Message("f_d0404_0060_0080")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(45)
      else
        Cam.Inst:Set(47.564301, -0.399573, 32.529652, 41.19281, -2.701823, 25.174126, default, 45)
        WaitFrame(40)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0060_0010")
        Message("f_d0404_0060_0020")
        Message("f_d0404_0060_0030")
        Message("f_d0404_0060_0040")
        Message("f_d0404_0060_0050")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(45)
      end
    end
    if talk_id == 106 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0070_0020")
        Message("f_d0404_0070_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0070_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 107 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0080_0010")
      Message("f_d0404_0080_0020")
      Message("f_d0404_0080_0030")
      Message("f_d0404_0080_0040")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 108 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0080_0010")
      Message("f_d0404_0080_0020")
      Message("f_d0404_0080_0030")
      Message("f_d0404_0080_0040")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 109 then
      Cam.Inst:Set(74.395813, 1.260965, 12.20602, 64.909874, 0.402578, 15.252352, default, 45)
      WaitFrame(40)
      Flg.Set("FLAG_MAIN_02_030")
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0090_0010")
      Message("f_d0404_0090_0020")
      Message("f_d0404_0090_0030")
      Message("f_d0404_0090_0040")
      Message("f_d0404_0090_0050")
      Message("f_d0404_0090_0060")
      Message("f_d0404_0090_0070")
      MessageClose()
      BackFade_OutNoLoadingWithWait(FADE_BLACK, 10)
      WaitFrame(20)
      Message("f_d0404_0090_0080")
      Obj:new(NPC, "npc_0008"):Invisible()
      Obj:new(NPC, "npc_0009"):Invisible()
      Obj:new(NPC, "fanbi_01"):Invisible()
      Obj:new(NPC, "fanbi_02"):Invisible()
      Obj:new(NPC, "fanbi_03"):Invisible()
      Obj:new(NPC, "fanbi_04"):Invisible()
      Field_Talk_End_Not_LetterBox()
      WaitFrame(20)
      BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Cam.Inst:Clear(45)
    end
    if talk_id == 110 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0100_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0100_0010")
        Message("f_d0404_0100_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 111 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0110_0050")
        Message("f_d0404_0110_0060")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0110_0010")
        Message("f_d0404_0110_0020")
        Message("f_d0404_0110_0030")
        Message("f_d0404_0110_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 112 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0120_0040")
        Message("f_d0404_0120_0050")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0120_0010")
        Message("f_d0404_0120_0020")
        Message("f_d0404_0120_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 113 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0130_0010")
        Message("f_d0404_0130_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0130_0010")
        Message("f_d0404_0130_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 114 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0140_0010")
        Message("f_d0404_0140_0020")
        Message("f_d0404_0140_0030")
        Message("f_d0404_0140_0040")
        Message("f_d0404_0140_0050")
        Message("f_d0404_0140_0060")
        Message("f_d0404_0140_0070")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0140_0010")
        Message("f_d0404_0140_0020")
        Message("f_d0404_0140_0030")
        Message("f_d0404_0140_0040")
        Message("f_d0404_0140_0050")
        Message("f_d0404_0140_0060")
        Message("f_d0404_0140_0070")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 117 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0030_0010")
      Message("f_d0404_0030_0020")
      Message("f_d0404_0030_0030")
      Message("f_d0404_0030_0040")
      Message("f_d0404_0030_0050")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 118 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0040_0010")
      Message("f_d0404_0040_0020")
      Message("f_d0404_0040_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 119 then
      if Flg.Check("FLAG_FIELD_D404_010") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0170_0010")
        Message("f_d0404_0170_0020")
        Message("f_d0404_0170_0030")
        Message("f_d0404_0170_0040")
        Message("f_d0404_0170_0050")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        Cam.Inst:Set(9.353534, -0.484488, 36.027805, 2.94591, 2.347601, 43.163746, default, 45)
        WaitFrame(40)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0160_0010")
        Message("f_d0404_0160_0020")
        Message("f_d0404_0160_0030")
        Message("f_d0404_0160_0040")
        Message("f_d0404_0160_0050")
        BackFade_OutNoLoadingWithWait(FADE_BLACK, 10)
        WaitFrame(20)
        Flg.Set("FLAG_FIELD_D404_010")
        Message("f_d0404_0160_0060")
        Message("f_d0404_0160_0070")
        MessageClose()
        FieldObjectSync(FOR_ALL, false)
        WaitFrame(20)
        BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
        Message("f_d0404_0160_0080")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(45)
      end
    end
    if talk_id == 121 then
      if Flg.Check("FLAG_MAIN_06_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0150_0030")
        Message("f_d0404_0150_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0404_0150_0010")
        Message("f_d0404_0150_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 122 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0180_0010")
      Message("f_d0404_0180_0020")
      Message("f_d0404_0180_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 115 then
      local cam_npc = {
        31.183,
        0.123,
        5.011,
        22.469,
        1.88,
        9.591
      }
      local cam_shop = {
        30.877,
        0.123,
        4.429,
        22.163,
        1.88,
        9.009
      }
      CommonShopStart(npc_name, 112, "fq01", "fe02", "fq01", cam_npc, cam_shop, nil, "fq01")
    end
    if talk_id == 116 then
      local cam_npc = {
        31.811,
        -0.132,
        8.327,
        22.786,
        2.028,
        12.052
      }
      local cam_shop = {
        31.766,
        -0.532,
        7.293,
        22.9,
        1.886,
        11.237
      }
      CommonShopStart(npc_name, 123, "ba02", "fe02", "fe04", cam_npc, cam_shop, nil, "fe02")
    end
    if npc_name == "npc_0024" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0404_0390_0010")
      Message("f_d0404_0390_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "card_001" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0404_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1403, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0404_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0404_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1404, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0404_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "card_003" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_9020_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0404_9020_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1405, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9020_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9020_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0404_9020_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "card_004" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_9030_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0404_9030_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1406, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9030_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9030_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0404_9030_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "card_005" then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_9040_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0404_9040_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1407, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9040_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0404_9040_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0404_9040_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 232 then
      local fldtxt = "d04"
      Cam.Inst:Set(55.9, 5.609, -39.16, 46.27, 7.294, -37.05, default, 30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0410_0010")
      Message("f_d0404_0420_0010")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 239 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0430_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 240 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0440_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 241 then
      local fldtxt = "d04"
      Cam.Inst:Set(-2.930393, 9.901006, -71.757195, 3.065772, 8.205527, -63.935982, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0450_0010")
      Message("f_d0404_0450_0020")
      Message("f_d0404_0450_0030")
      Message("f_d0404_0450_0040")
      Message("f_d0404_0450_0050")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 242 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0460_0010")
      Message("f_d0404_0460_0020")
      Message("f_d0404_0460_0030")
      Message("f_d0404_0460_0040")
      MessageClose()
      WaitFrame(20)
      Message("f_d0404_0460_0050")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 243 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0470_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 245 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0480_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 247 then
      local fldtxt = "d04"
      Cam.Inst:Set(56.798607, 0.716658, 15.738917, 47.463009, -2.273914, 17.714544, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0490_0010")
      Message("f_d0404_0490_0020")
      Message("f_d0404_0490_0030")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 248 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0500_0010")
      Message("f_d0404_0500_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 203 then
      local fldtxt = "d04"
      local fq01 = Motion.Object:new(NPC, "npc_0203", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0203"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      Message("f_d0404_0280_0010")
      Message("f_d0404_0280_0020")
      fq01:Play(20, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0203"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
      Message("f_d0404_0280_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0203"), 30)
    end
    if talk_id == 204 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0290_0010")
      Message("f_d0404_0290_0020")
      Message("f_d0404_0290_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 205 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0400_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 206 then
      local cam_npc = {
        31.183,
        0.123,
        5.011,
        22.469,
        1.88,
        9.591
      }
      local cam_shop = {
        30.877,
        0.123,
        4.429,
        22.163,
        1.88,
        9.009
      }
      CommonShopStart(npc_name, 112, "fq01", "fe02", "fq01", cam_npc, cam_shop, nil, "fq01")
    end
    if talk_id == 207 then
      local cam_npc = {
        31.811,
        -0.132,
        8.327,
        22.786,
        2.028,
        12.052
      }
      local cam_shop = {
        31.766,
        -0.532,
        7.293,
        22.9,
        1.886,
        11.237
      }
      CommonShopStart(npc_name, 123, "ba02", "fe02", "fe04", cam_npc, cam_shop, nil, "fe02")
    end
    if talk_id == 208 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0300_0010")
      Message("f_d0404_0300_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 209 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0310_0010")
      Message("f_d0404_0310_0020")
      Message("f_d0404_0310_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 210 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0380_0010")
      Message("f_d0404_0380_0020")
      Message("f_d0404_0380_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 213 then
      local fldtxt = "d04"
      local fq01 = Motion.Object:new(NPC, "npc_0213", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0320_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0213"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      Message("f_d0404_0320_0020")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0213"), "F03", EYES_BLINK_TYPE_BLINK, false, 0)
      fq01:Play(20, true)
      Message("f_d0404_0320_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0213"), 30)
    end
    if talk_id == 234 then
      local fldtxt = "d04"
      local bn02 = Motion.Object:new(NPC, "npc_0234", "bn02")
      local bn01 = Motion.Object:new(NPC, "npc_0234", "bn01")
      local fq01 = Motion.Object:new(NPC, "npc_0234", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0234"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      bn02:Play(20, true)
      Message("f_d0404_0340_0010")
      Message("f_d0404_0340_0020")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0234"), "F01", EYES_BLINK_TYPE_BLINK, false, 0)
      bn01:Play(20, true)
      Message("f_d0404_0340_0030")
      Message("f_d0404_0340_0040")
      fq01:Play(20, true)
      Message("f_d0404_0340_0050")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0234"), 30)
    end
    if npc_name == "sub030_001" then
      require("S030_030")
      S030_030:Event_010()
    end
    if npc_name == "sub030_002" then
      require("S030_030")
      S030_030:Event_040()
    end
    if talk_id == 227 then
      local fldtxt = "d04"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0404_0270_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "sub029_001" then
      require("S030_029")
      S030_029:Event_010()
    end
    if npc_name == "sub029_003" then
      require("S110_109")
      require("S030_029")
      if Qst.Sub:Check(S030_029.ID, S030_029.STEP_001, S030_029.STEP_003) then
        S030_029:Event_010()
      else
        S110_109.Event_040()
      end
    end
    if npc_name == "sub031_001" then
      require("S030_031")
      S030_031:Event_020()
    end
    if npc_name == "s030_183_001" then
      require("S030_183")
      S030_183:Event_010()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After(npc_name)
    end
  end
  if gMapNum == 405 then
    if talk_id == 301 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start("d0405", 1)
      Message(91)
      MessageTalkSel(2, 92)
      local result = Talk.GetResultSelectedNum()
      if result == 0 then
        Flg.Clear("AREA_CLOSE_DEBUG")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        Obj:new(NPC, "npc_0001"):Invisible(15)
        SetFollowerCameraOperateRotation(-8, 120)
        WaitFrame(10)
        Field.MovePlayerToLocatorFrame("ride_fly_0012", 10)
        WaitFrame(10)
        SetPlayerRotationByLocator("ride_fly_0012", 5)
        WaitFrame(5)
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field.PlayerScriptDigimonRideStartFromID(304, true, "", 10)
        WaitFrame(75)
        SetControlScriptExternalVariable("force_ride_fly", "play_effect")
        WaitFrame(5)
        Quake_Start(0.1, 0, 6)
        WaitFrame(1)
        Cam.Inst:Clear(0)
        SetControlScriptExternalVariable("force_ride_fly", "start")
      elseif result == 1 then
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
      end
    end
    if talk_id == 998 then
      local board = GetIndex(FLD_OBJ_LOCATOR, "fa_0003")
      Cam.Inst:Set(-27.5, 3.1, 0.3, -31.2, 4.1, 2.7, default, 30)
      Field_Talk_Start(gGimText, 1)
      Message(1040501000)
      Message(1040501010)
      FadeOutWithWait(0, 30)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, board, 0, 0, false)
      ColOff("plan_cl_2003")
      FadeInWithWait(0, 30)
      Message(1040501020)
      Cam.Inst:Clear(30)
      Field_Talk_End()
    elseif talk_id == 999 then
      local board = GetIndex(FLD_OBJ_LOCATOR, "fa_0004")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(gGimText, 1)
      Message(1040502000)
      Message(1040502010)
      FadeOutWithWait(0, 60)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, board, 0, 0, false)
      ColOff("plan_cl_2004")
      FadeInWithWait(0, 60)
      Message(1040502020)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End()
    end
    if npc_name == "s040_033_001" then
      require("S040_033")
      S040_033:Event_040()
    end
    if npc_name == "sub024_001" then
      require("S030_024")
      S030_024:Event_040()
      S030_024:Event_030()
      S030_024:Event_018()
      S030_024:Event_015()
      S030_024:Event_010()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After(npc_name)
    end
  end
  if gMapNum == 406 then
    if npc_name == "s110_100_001" then
      require("S110_100")
      S110_100:Event_010()
    end
    if npc_name == "sub029_001" or npc_name == "sub029_002" then
      require("S030_029")
      S030_029:Event_020()
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_BeforeD04(npc_name)
    end
    if npc_name == "s030_183_001" then
      require("S030_183")
      S030_183:Event_060()
    end
    if npc_name == "npc_warp01" then
      D04_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      D04_WarpNPC_After(npc_name)
    end
  end
  if gMapNum == 407 then
    if talk_id == 1 then
      require("S030_183")
      if Qst.Sub:Check(S030_183.ID, S030_183.STEP_005, S030_183.STEP_010) then
        S030_183:Event_023()
      elseif Flg.Check("FLAG_MAIN_06_060") then
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
      Cam.Inst:Set(5.967, 4.4, 6.82, 12.72, 2.36, 13.91, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0407_0080_0010")
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

function D04_WarpNPC_Before(npc_name)
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

function D04_WarpNPC_After(npc_name)
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
