function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 301 then
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
    end
    if talk_id == 602 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0190_0030")
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
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0230_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 605 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0301_0240_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
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
  end
  if gMapNum == 302 then
    if npc_name == "npc_0303" then
      M280:Event_060()
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
      M280:Event_020()
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
      M280:Event_030()
    end
    if npc_name == "npc_0309" then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0320_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      M280:Event_040()
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
        -38.581,
        4.777,
        57.115,
        -29.995,
        5.446,
        62.198
      }
      CommonShopStart(npc_name, 112, "fq01", "fe02", "fq01", cam_npc, cam_shop)
    end
    if talk_id == 103 then
      local fldtxt = "d03"
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
    if talk_id == 104 then
      local fldtxt = "d03"
      local tlk = Tlk:new(fldtxt, 1, true)
      tlk:StartTalkActionAndZoom(npc_name)
      tlk:Message("f_d0302_0200_0010")
      tlk:Message("f_d0302_0200_0020")
      tlk:EndTalkActionAndZoom()
    end
    if npc_name == "npc_5001" then
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0302_0220_0010")
      tlk:Message("f_d0302_0220_0020")
      tlk:EndTalk()
    end
    if npc_name == "npc_5000" then
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0302_0210_0010")
      tlk:Message("f_d0302_0210_0020")
      tlk:EndTalk()
    end
    if talk_id == 110 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(46.378513, 4.800456, 53.53155, 37.75769, 4.362429, 58.610264, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0420_0010")
      Message("f_d0302_0420_0020")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 117 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0430_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 118 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0400_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
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
      Message("f_d0302_0390_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0311"), "F01", EYES_BLINK_TYPE_CLOSE, false, 10)
      fq01:Play(20, true)
      Message("f_d0302_0390_0020")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0311"), 10)
      Message("f_d0302_0390_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
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
    if talk_id == 310 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0302_0330_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_shop_0001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      CommonShopStart_NoZoomCam(npc_name, 167, "fe02", "fe04", "fe04", "bn01")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
  end
  if gMapNum == 303 then
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
      Message("f_d0302_0080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
  end
  if gMapNum == 305 then
    if talk_id == 1 then
      local fldtxt = "d03"
      if not Flg.Check("FLAG_MAIN_09_070") then
        Cam.Inst:Set(0.399349, 48.764767, -129.08287, 0.488961, 45.564533, -119.6092, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0305_0010_0010")
        Message("f_d0305_0010_0020")
        Message("f_d0305_0010_0030")
        Message("f_d0305_0010_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Clear(30)
      elseif Qst.Sub:Check(19, 5, 255) or Qst.Sub:Check(13, 1, 255) or Qst.Sub:Check(102, 5, 255) then
        require("S020_019")
        S020_019:Event_020()
        require("S020_013")
        S020_013:Event_010()
        require("S110_102")
        S110_102:Event_025()
      elseif Flg.Check("FLAG_MAIN_09_070") then
        Cam.Inst:Set(0.399349, 48.764767, -129.08287, 0.488961, 45.564533, -119.6092, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0305_0080_0010")
        Message("f_d0305_0080_0020")
        Message("f_d0305_0080_0030")
        Message("f_d0305_0080_0040")
        Message("f_d0305_0080_0050")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Cam.Inst:Clear(30)
      end
    end
    if talk_id == 2 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(-4.369479, 5.754385, 67.142807, -4.080557, 5.320717, 77.129219, default, 30)
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
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(8.341629, 3.302795, 36.594944, 6.114846, 2.42454, 46.304222, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0040_0010")
      Message("f_d0305_0040_0020")
      Message("f_d0305_0040_0030")
      Message("f_d0305_0040_0040")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 5 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(23.298401, 25.057878, -44.307274, 19.225245, 21.701305, -35.813583, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0050_0010")
      Message("f_d0305_0050_0020")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_0008" then
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0305_0090_0020")
      tlk:MessageClose()
      MessageTalkSel(2, "f_d0305_0090_0030")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        MapChange("d", 302, "start_42", true, FADE_BLACK, FADE_TIME)
      elseif result == RESULT_TALK01 then
        tlk:EndTalk()
      end
    end
    if talk_id == 8 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(1.8104, 11.8501, 61.302, 1.4992, 12.4506, 71.279, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0060_0010")
      Message("f_d0305_0060_0020")
      Message("f_d0305_0060_0030")
      Message("f_d0305_0060_0040")
      Message("f_d0305_0060_0050")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 7 then
      local fldtxt = "d03"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(6.6677, 13.25, 54.782, -0.0389, 13.1222, 62.199, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0305_0070_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
  end
  if gMapNum == 306 and npc_name == "npc_0500" then
    M280:Event_090()
  end
  if gMapNum == 308 then
  end
end
