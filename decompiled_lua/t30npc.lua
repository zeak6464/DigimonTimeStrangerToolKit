function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = "t30"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 3001 then
    if talk_id == 501 then
      local cam_npc = {
        19.34,
        0.62,
        0.41,
        9.15,
        2.11,
        0.14
      }
      local cam_shop = {
        19.34,
        0.62,
        0.41,
        9.15,
        2.11,
        0.14
      }
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      if Common.GetGameClearNum() >= 1 then
        CommonShopStart_NoZoomCam(npc_name, 96, "e002", "e002", "e002", "fn01_10")
      elseif Common.CheckTimeAxis("A2020_dbef_10", "A2020_dbef_119") or Common.CheckTimeAxis("P2020_dbef_10", "P2020_dbef_110") or Common.CheckTimeAxis("Z2020_dbef_10", "Z2020_dbef_110") then
        CommonShopStart_NoZoomCam(npc_name, 91, "e002", "e002", "e002", "fn01_10")
      elseif Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_220") or Common.CheckTimeAxis("P2020_dbef_120", "P2020_dbef_220") or Common.CheckTimeAxis("Z2020_dbef_120", "Z2020_dbef_220") then
        CommonShopStart_NoZoomCam(npc_name, 92, "e002", "e002", "e002", "fn01_10")
      elseif Common.CheckTimeAxis("A2028_daft_230", "A2028_daft_290") or Common.CheckTimeAxis("P2028_daft_230", "P2028_daft_290") or Common.CheckTimeAxis("Z2028_daft_230", "Z2028_daft_290") then
        CommonShopStart_NoZoomCam(npc_name, 93, "e002", "e002", "e002", "fn01_10")
      elseif Common.CheckTimeAxis("A2028_daft_300", "A2028_daft_390") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_390") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_390") then
        CommonShopStart_NoZoomCam(npc_name, 94, "e002", "e002", "e002", "fn01_10")
      elseif Common.CheckTimeAxis("A2028_daft_400", "A2028_daft_10000") or Common.CheckTimeAxis("P2028_daft_400", "P2028_daft_10000") or Common.CheckTimeAxis("Z2028_daft_400", "Z2028_daft_10000") then
        CommonShopStart_NoZoomCam(npc_name, 95, "e002", "e002", "e002", "fn01_10")
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Prcs_t30_InvisibleFollower()
    elseif talk_id == 502 then
      local m050_flgs = {
        M050.STEP_015,
        M050.STEP_016,
        M050.STEP_017,
        M050.STEP_018
      }
      require("S900_216")
      S900_216:Event_010()
      if Flg.Check("FLAG_SUB_910_170_013", "FLAG_SUB_910_170_014") then
        require("S910_170")
        S910_170:Event_100()
      end
      if Qst.Main:Check(M050.ID, M050.STEP_020, M050.STEP_025) and Qst.Main:AllCheck(M050.ID, m050_flgs) then
        M050:Event_100()
        Prcs_t3001_MireiShop(npc_name, npc_text)
      else
        Prcs_t3001_MireiShop(npc_name, npc_text)
      end
      Prcs_t30_InvisibleFollower()
    elseif talk_id == 503 then
      local fldtxt = "t30"
      local tlk = Tlk:new("t30", 1, false)
      tlk:StartTalk()
      tlk:Message("f_t3001_0130_0010")
      local result = tlk:Select(3, "f_t3001_0130_0020")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        OpenDlcStore()
        Prcs_t30_InvisibleFollower()
      elseif result == RESULT_TALK01 then
        Field.OpenItemPackMenu()
        WaitFrame(1)
        while not Field.IsClosedItemPackMenu() do
          WaitFrame(1)
        end
        tlk:EndTalk()
        Prcs_t30_InvisibleFollower()
      else
        tlk:EndTalk()
        Prcs_t30_InvisibleFollower()
      end
    end
    if talk_id == 504 then
      local fldtxt = "t30"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_t3001_0120_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
      Prcs_t30_InvisibleFollower()
    end
    if npc_name == "npc_008" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      local npc_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
      Field.ObjectLoadMotion(NPC, npc_index, "e021")
      local tlk = Tlk:new("t30", 0, false)
      tlk:StartTalk()
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_008"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotion(NPC, npc_index, "e021", 10, true)
      tlk:Message("f_t3001_0210_0010")
      tlk:Message("f_t3001_0210_0020")
      tlk:Message("f_t3001_0210_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_008"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      tlk:EndTalk()
      Prcs_t30_InvisibleFollower()
    end
    if npc_name == "s090_072_001" then
      local npc_index = GetIndex(NPC, npc_name)
      local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
      local player_pos = Field.ObjectGetPosition(PLAYER, 1)
      local y_degree = GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
      Field.ObjectLookAtTheObject(NPC, npc_index, PLAYER, 1, 30)
      if 0 < y_degree and y_degree < 180 then
        Field.ObjectSetRotationY(NPC, npc_index, 70, 30)
      elseif 180 < y_degree and y_degree < 360 then
        Field.ObjectSetRotationY(NPC, npc_index, 105, 30)
      end
      Field.ObjectLoadMotion(NPC, npc_index, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index, "br01")
      Field_Talk_Start_Not_LetterBox("s090_072", 1)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Message("s090_072_1270")
      Message("s090_072_1280")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field.ObjectSetRotationY(NPC, npc_index, 90, 30)
      Field.ObjectResetAim(NPC, npc_index, 15)
      Prcs_t30_InvisibleFollower()
    end
  elseif gMapNum == 3003 then
    if talk_id == 300 then
      local tlk = Tlk:new("t30", 1, true)
      tlk:StartTalkActionAndZoom(npc_name)
      tlk:Message("f_t3003_0010_0010")
      tlk:EndTalkActionAndZoom()
    end
    if talk_id == 301 then
      local npc_index_y = GetIndex(NPC, "npc_0002")
      require("S100_087")
      if Qst.Sub:Check(S100_087.ID, S100_087.STEP_003, S100_087.STEP_004) then
        S100_087:Event_010()
      elseif Qst.Sub:Check(S100_087.ID, S100_087.STEP_004, S100_087.STEP_005) then
        local tlk = Tlk:new("s100_087", 1, true)
        tlk:StartTalkActionAndZoom(npc_name)
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message("s100_087_250")
        tlk:Message("s100_087_255")
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        tlk:EndTalkActionAndZoom()
      elseif Qst.Sub:Check(S100_087.ID, S100_087.STEP_010, S100_087.STEP_255) then
        S100_087:Event_015()
      elseif not Qst.Sub:IsCompleted(S100_087.ID) then
        S100_087:Event_017()
      elseif Qst.Sub:IsCompleted(S100_178.ID) then
        local tlk = Tlk:new("s100_178", 1, true)
        tlk:StartTalkActionAndZoom(npc_name)
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        tlk:Message("s100_178_190")
        tlk:Message("s100_178_200")
        Field.ObjectChangeExpression(NPC, npc_index_y, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        tlk:EndTalkActionAndZoom()
      end
    end
    if talk_id == 302 then
      require("S100_088")
      if Qst.Sub:Check(S100_088.ID, S100_088.STEP_020, S100_088.STEP_255) then
        S100_088:Event_030()
      elseif Qst.Sub:Check(S100_088.ID, S100_088.STEP_010, S100_088.STEP_020) then
        S100_088:Event_020()
      elseif Qst.Sub:Check(S100_088.ID, S100_088.STEP_001, S100_088.STEP_010) and Qst.Main:IsCompleted(M260.ID) then
        S100_088:Event_010()
      elseif Qst.Sub:IsCompleted(88) then
        S100_088:Event_050()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        Message(302100)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
      end
    end
  elseif gMapNum == 3004 then
    if npc_name == "dlc_elvmob_01" then
      if not Flg.Check("FLAG_DLC_PATCH001_IS_INDICATIONS") then
        MapChange("t", 3001, "start_04", false, 0, 0)
      else
        require("dpt01m010")
        DLCPATCH0001:Door001Access()
        Prcs_t30_InvisibleFollower()
      end
    end
    if npc_name == "dlc_elvmob_02" then
      if not Flg.Check("FLAG_DLC_PATCH001_IS_INDICATIONS") then
        MapChange("t", 3001, "start_04", false, 0, 0)
      else
        require("dpt01m010")
        DLCPATCH0001:Door002Access()
        Prcs_t30_InvisibleFollower()
      end
    end
    if npc_name == "dlc_elvmob_03" then
      if not Flg.Check("FLAG_DLC_PATCH001_IS_INDICATIONS") then
        MapChange("t", 3001, "start_04", false, 0, 0)
      else
        require("dpt01m010")
        DLCPATCH0001:Door003Access()
        Prcs_t30_InvisibleFollower()
      end
    end
  end
end
