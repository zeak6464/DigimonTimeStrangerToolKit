gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 301 or load_map_num == 302 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"fg07_d01"},
      move_motion = {"swim"},
      attach = {3},
      attach_motion = {
        {3, "fg02_fn01"}
      },
      attach_effect = {
        {
          "ef_f_dun_500_sp",
          true,
          3
        }
      }
    })
  end
  if load_map_num == 303 then
    Motion.Object:Load(FLD_OBJ_PLAYER, "", "fg11_l01")
    Motion.Object:Load(FLD_OBJ_PLAYER, "", "fg11_r01")
    Motion.Object:Load(FLD_OBJ_PLAYER, "", "e015")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0003", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0004", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0005", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0006", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0007", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0008", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0009", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0010", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0011", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0012", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0003", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0004", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0005", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0006", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0007", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0008", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0009", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0010", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0011", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0012", "e002")
  elseif load_map_num == 304 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"fg11_l01", "fg11_r01"},
      move_motion = {
        "hide",
        "cover",
        "cover_end"
      }
    })
    Motion.Object:Load(FLD_OBJ_PLAYER, "", "fg11_l01")
    Motion.Object:Load(FLD_OBJ_PLAYER, "", "fg11_r01")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0001", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0002", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0003", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0004", "e001")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0001", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0002", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0003", "e002")
    Motion.Object:Load(FLD_OBJ_LOCATOR, "gim_0004", "e002")
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 301 then
    if Field.IsJustAfterMapChangeNow() == true then
      if Flg.Check("FLAG_AREACHANGE_WITH_WHAMON") then
        if Common.CheckTimeAxis("A2028_daft_220", "A2028_daft_330") then
          Flg.Clear("FLAG_AREACHANGE_WITH_WHAMON")
          Flg.Set("FLAG_IS_COMING_WHAMON")
        else
          Obj:new(NPC, "npc_0001"):Invisible()
          Flg.Clear("FLAG_AREACHANGE_WITH_WHAMON")
          Flg.Set("FLAG_IS_COMING_WHAMON")
        end
        Obj:new(NPC, "npc_0001"):Invisible()
      else
        Obj:new(NPC, "npc_0001"):Invisible()
        Obj:new(NPC, "npc_0008"):Invisible()
        Flg.Clear("FLAG_IS_COMING_WHAMON")
      end
    elseif not Flg.Check("FLAG_IS_COMING_WHAMON") then
      Obj:new(NPC, "npc_0001"):Invisible()
      Obj:new(NPC, "npc_0008"):Invisible()
    else
      Obj:new(NPC, "npc_0001"):Invisible()
    end
    Obj:new(FLD_OBJ_LOCATOR, "change_0001"):SetEnableGimmick(false)
  elseif gMapNum == 302 then
    Motion.Gimmick:Play("obj_chr465", "fn01", true)
    if not Flg.Check("FLAG_MAIN_09_071") then
      Obj:new(NPC, "hoe_001"):Invisible()
    end
    if Flg.Check("FLAG_IS_CLEAR_S020_173") then
      local obj = Obj:new(NPC, "s020_173_001")
      Field.ObjectOverwriteCheckableRange(NPC, obj.index, 0, 0, 0)
    end
    if Common.CheckTimeAxis("A2020_dbef_170", "A2020_dbef_200") then
      Field.LinkColOff("mapborder_4")
      Field.LinkColOff("mapborder_5")
    end
    local npc_index = GetIndex(NPC, "M_burinp_100")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
    local s110_108_001 = GetIndex(MOB, "s110_108_001")
    local s110_108_003 = GetIndex(MOB, "s110_108_003")
    Field.ObjectSuspendAutoTransparent(MOB, s110_108_001, AUTO_TRANSPARENT_TYPE_ALL)
    Field.ObjectSuspendAutoTransparent(MOB, s110_108_003, AUTO_TRANSPARENT_TYPE_ALL)
  elseif gMapNum == 303 then
    SetControlScriptExternalVariable("se_slot", nil)
    if Flg.Check("FLAG_MAIN_05_100") then
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse01"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse02"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse03"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse04"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse05"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse05"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse06"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse06"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse01"):SetIcon(FLD_ICON_DIGIMON_RIDE)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse02"):SetIcon(FLD_ICON_DIGIMON_RIDE)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse03"):SetIcon(FLD_ICON_DIGIMON_RIDE)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse04"):SetIcon(FLD_ICON_DIGIMON_RIDE)
    else
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse01"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse02"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse03"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse04"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse05"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse05"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Reverse06"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "WaterFlow_Obverse06"):SetEnableCheckAndFieldAttack(false)
    end
    if Flg.Check("FLAG_FIELD_D0303_010") or Flg.Check("FLAG_FIELD_D0303_020") or Flg.Check("FLAG_FIELD_D0303_030") or Flg.Check("FLAG_FIELD_D0303_040") or Flg.Check("FLAG_FIELD_D0303_050") or Flg.Check("FLAG_FIELD_D0303_060") or Flg.Check("FLAG_FIELD_D0303_070") or Flg.Check("FLAG_FIELD_D0303_080") or Flg.Check("FLAG_FIELD_D0303_090") or Flg.Check("FLAG_FIELD_D0303_100") then
      SetControlScriptExternalVariable("se_start_waterflow", "start")
      SetControlScriptExternalVariable("se_slot", se_slot)
      if not Flg.Check("FLAG_FIELD_D0303_110") then
        Motion.Player:ChangeMoveAnim("flow", 15)
      else
      end
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      SetProhibitPlayerOnlyOperate(true)
      SetEnableCameraOperate(false)
      Prcs_d0303_WaterFlowCol(false)
    end
    if Field.IsJustAfterMapChangeNow() == true then
      if Flg.Check("FLAG_AREACHANGE_WITH_WHAMON") then
        Flg.Clear("FLAG_AREACHANGE_WITH_WHAMON")
        Flg.Set("FLAG_IS_COMING_WHAMON")
      else
        Obj:new(NPC, "npc_0004"):Invisible()
        Flg.Clear("FLAG_IS_COMING_WHAMON")
      end
    elseif not Flg.Check("FLAG_IS_COMING_WHAMON") then
      Obj:new(NPC, "npc_0004"):Invisible()
    end
    Motion.Gimmick:Play("obj_0003", "e002", true, true)
    Motion.Gimmick:Play("obj_0004", "e002", true, true)
    Motion.Gimmick:Play("obj_0005", "e002", true, true)
    Motion.Gimmick:Play("obj_0006", "e002", true, true)
    Motion.Gimmick:Play("obj_0007", "e001", true, true)
    Motion.Gimmick:Play("obj_0008", "e002", true, true)
    Motion.Gimmick:Play("obj_0009", "e001", true, true)
    Motion.Gimmick:Play("obj_0010", "e001", true, true)
    Motion.Gimmick:Play("obj_0011", "e002", true, true)
    Motion.Gimmick:Play("obj_0012", "e002", true, true)
  elseif gMapNum == 304 then
    if Field.IsJustAfterMapChangeNow() == true then
      if Flg.Check("FLAG_AREACHANGE_WITH_WHAMON") then
        Flg.Clear("FLAG_AREACHANGE_WITH_WHAMON")
        Flg.Set("FLAG_IS_COMING_WHAMON")
      else
        Obj:new(NPC, "npc_0001"):Invisible()
        Flg.Clear("FLAG_IS_COMING_WHAMON")
      end
    elseif not Flg.Check("FLAG_IS_COMING_WHAMON") then
      Obj:new(NPC, "npc_0001"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D03_390") then
      Obj:new(NPC, "pass_skullseadra"):Invisible()
    end
    Obj:new(NPC, "skullseadra_swim"):Invisible()
    Obj:new(NPC, "pass_skullseadra_2"):Invisible()
    if not Flg.Check("FLAG_MAIN_09_043") then
      Common.LODEnable(false)
    end
  elseif gMapNum == 305 then
  elseif gMapNum == 306 then
  elseif gMapNum == 308 then
    local index = GetIndex(MOB, "s110_108_001")
    local index2 = GetIndex(MOB, "s110_108_003")
    Field.ObjectSuspendAutoTransparent(MOB, index, AUTO_TRANSPARENT_TYPE_ALL)
    Field.ObjectSuspendAutoTransparent(MOB, index2, AUTO_TRANSPARENT_TYPE_ALL)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 301 then
    if col_name == "evt_1000" then
      M170:Event_101()
    end
    if col_name == "evt_1001" then
      M170:Event_103()
    end
    if col_name == "evt_1002" and not Flg.Check("FLAG_FIELD_D0303_150") then
      M170:Event_055()
    end
    if col_name == "evt_4000" then
      M260:Event_050()
    end
    if col_name == "evt_8000" then
      M170:Event_045()
    end
    if col_name == "evt_8001" then
      M170:Event_053()
    end
    if col_name == "evt_8002" then
      M170:Event_073()
    end
    if col_name == "evt_1003" then
      if Common.CheckTimeAxis("A2028_daft_220", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_10000") then
        local tlk = Tlk:new("d03", 1, false)
        tlk:StartTalk()
        tlk:Message("f_d0301_0170_0010")
        Field.MovePlayerToRelativePosFrame(-1, -1, 20)
        WaitFrame(5)
        tlk:EndTalk()
      end
      require("S020_018")
      S020_018:Event_090()
    end
    if (col_name == "evt_9000" or col_name == "evt_9001" or col_name == "evt_9002" or col_name == "evt_9003" or col_name == "evt_9004" or col_name == "evt_9005") and not Flg.Check("FLAG_IS_SWIM") then
      Prcs_d03_ChangeMoveMotion()
    end
    if (col_name == "evt_9100" or col_name == "evt_9101" or col_name == "evt_9102" or col_name == "evt_9103") and Flg.Check("FLAG_IS_SWIM") then
      Prcs_d03_ResetMoveMotion()
    end
    if col_name == "evt_9200" or col_name == "evt_9201" or col_name == "evt_9202" then
      SetProhibitDigimonRide(false)
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    elseif col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_3000" or col_name == "evt_3002" or col_name == "evt_3004" or col_name == "evt_3006" or col_name == "evt_3008" or col_name == "evt_3010" or col_name == "evt_3012" or col_name == "evt_3014" then
      Flg.Clear("FLAG_FIELD_D0303_140")
    elseif col_name == "evt_3001" or col_name == "evt_3003" or col_name == "evt_3005" or col_name == "evt_3007" or col_name == "evt_3009" or col_name == "evt_3011" or col_name == "evt_3013" or col_name == "evt_3015" then
      Flg.Set("FLAG_FIELD_D0303_140")
    end
  elseif gMapNum == 302 then
    if col_name == "evt_0001" then
      M170:Event_030()
      M170:Event_240()
    end
    if col_name == "evt_0003" then
      M170:Event_025()
    end
    if col_name == "evt_8000" then
      M170:Event_043()
    end
    if col_name == "evt_9015" then
      M170:Event_062()
    end
    if col_name == "evt_9016" then
      M170:Event_063()
    end
    if col_name == "evt_8000" or col_name == "evt_8001" then
      M260:Event_040()
    end
    if col_name == "evt_0004" or col_name == "evt_0008" then
      M285:Event_020()
    end
    if col_name == "evt_9100" and Flg.Check("FLAG_MAIN_09_060", "FLAG_MAIN_09_068") then
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0302_0470_0010")
      tlk:EndTalk()
      MovePlayerToRelativePosFrame(-0.2, 2, 10)
    end
    if col_name == "evt_9101" and Flg.Check("FLAG_MAIN_09_060", "FLAG_MAIN_09_068") then
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0302_0470_0010")
      tlk:EndTalk()
      MovePlayerToRelativePosFrame(2, 2, 10)
    end
    if col_name == "evt_9002" then
      Prcs_d0302_WarpGim_01()
    elseif col_name == "evt_9003" then
      Prcs_d0302_WarpGim_02()
    end
    if col_name == "evt_9004" or col_name == "evt_9011" or col_name == "evt_9012" or col_name == "evt_9017" or col_name == "evt_9018" or col_name == "evt_9020" or col_name == "evt_9021" then
      if not Flg.Check("FLAG_IS_SWIM") then
        Prcs_d03_ChangeMoveMotion()
      end
    elseif (col_name == "evt_9007" or col_name == "evt_9008" or col_name == "evt_9009" or col_name == "evt_9013" or col_name == "evt_9014" or col_name == "evt_9019" or col_name == "evt_9022") and Flg.Check("FLAG_IS_SWIM") then
      Prcs_d03_ResetMoveMotion()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    elseif col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_7000" then
      require("S110_091")
      S110_091:Event_015()
    end
  elseif gMapNum == 303 then
    if col_name == "evt_9006" then
      if Flg.Check("FLAG_FIELD_D0303_020") then
        Prcs_d0303_WaterFlowEnd(270, "FLAG_FIELD_D0303_020")
      else
      end
    elseif col_name == "evt_9007" then
      if Flg.Check("FLAG_FIELD_D0303_010") then
        Prcs_d0303_WaterFlowEnd(89, "FLAG_FIELD_D0303_010")
      elseif not Flg.Check("FLAG_FIELD_D0303_020") then
        Prcs_d0302_ForceFlow(90, 10)
        if Flg.Check("FLAG_MAIN_05_100") then
        else
          Field_Talk_Start("d03", 1)
          Message("f_d0303_0010_0010")
          Field_Talk_End()
        end
      end
    elseif col_name == "evt_9000" then
      if Flg.Check("FLAG_FIELD_D0303_040") then
        Prcs_d0303_WaterFlowEnd(3, "FLAG_FIELD_D0303_040")
      else
      end
    elseif col_name == "evt_9001" then
      if Flg.Check("FLAG_FIELD_D0303_030") then
        Prcs_d0303_WaterFlowEnd(183, "FLAG_FIELD_D0303_030")
      elseif not Flg.Check("FLAG_FIELD_D0303_040") then
        Prcs_d0302_ForceFlow(183, 10)
        if Flg.Check("FLAG_MAIN_05_100") then
        else
          Field_Talk_Start("d03", 1)
          Message("f_d0303_0010_0010")
          Field_Talk_End()
        end
      end
    elseif col_name == "evt_9002" then
      if Flg.Check("FLAG_FIELD_D0303_060") then
        Prcs_d0303_WaterFlowEnd(35, "FLAG_FIELD_D0303_060")
      else
      end
    elseif col_name == "evt_9003" then
      if Flg.Check("FLAG_FIELD_D0303_050") then
        Prcs_d0303_WaterFlowEnd(215, "FLAG_FIELD_D0303_050")
      elseif not Flg.Check("FLAG_FIELD_D0303_060") then
        Prcs_d0302_ForceFlow(214, 10)
        if Flg.Check("FLAG_MAIN_05_100") then
        else
          Field_Talk_Start("d03", 1)
          Message("f_d0303_0010_0010")
          Field_Talk_End()
        end
      end
    elseif col_name == "evt_9004" then
      if Flg.Check("FLAG_FIELD_D0303_080") then
        Prcs_d0303_WaterFlowEnd(72, "FLAG_FIELD_D0303_080")
      else
      end
    elseif col_name == "evt_9005" then
      if Flg.Check("FLAG_FIELD_D0303_070") then
        Prcs_d0303_WaterFlowEnd(252, "FLAG_FIELD_D0303_070")
      elseif not Flg.Check("FLAG_FIELD_D0303_080") then
        Prcs_d0302_ForceFlow(252, 10)
        if Flg.Check("FLAG_MAIN_05_100") then
        else
          Field_Talk_Start("d03", 1)
          Message("f_d0303_0010_0010")
          Field_Talk_End()
        end
      end
    elseif col_name == "evt_9008" then
      if Flg.Check("FLAG_FIELD_D0303_130") then
        Prcs_d0303_WaterFlowEnd(93, "FLAG_FIELD_D0303_130")
      elseif not Flg.Check("FLAG_FIELD_D0303_120") then
        Prcs_d0302_ForceFlow(93, 10)
        if Flg.Check("FLAG_MAIN_05_100") then
        else
          Field_Talk_Start("d03", 1)
          Message("f_d0303_0010_0010")
          Field_Talk_End()
        end
      end
    elseif col_name == "evt_9009" then
      if Flg.Check("FLAG_FIELD_D0303_120") then
        Prcs_d0303_WaterFlowEnd(273, "FLAG_FIELD_D0303_120")
      else
      end
    elseif col_name == "evt_9903" then
      if Flg.Check("FLAG_FIELD_D0303_100") then
        Prcs_d0303_WaterFlowEnd(113, "FLAG_FIELD_D0303_100")
      elseif not Flg.Check("FLAG_FIELD_D0303_090") then
        Prcs_d0302_ForceFlow(113, 10)
        if Flg.Check("FLAG_MAIN_05_100") then
        else
          Field_Talk_Start("d03", 1)
          Message("f_d0303_0010_0010")
          Field_Talk_End()
        end
      end
    else
      if col_name == "evt_9904" and Flg.Check("FLAG_FIELD_D0303_090") then
        Prcs_d0303_WaterFlowEnd(293, "FLAG_FIELD_D0303_090")
      else
      end
    end
    if col_name == "evt_9905" then
      require("S020_172")
      S020_172:Event_013()
    end
    if col_name == "evt_4000" then
      M170:Event_130()
    end
    if col_name == "evt_4001" then
      M170:Event_140()
    end
    if col_name == "evt_4002" then
      M170:Event_200()
    end
    if col_name == "evt_4003" then
      M170:Event_160()
      M170:Event_180()
    end
    if col_name == "evt_4004" then
      M170:Event_210()
    end
    if col_name == "evt_4005" then
      M170:Event_163()
    end
    if col_name == "evt_4006" then
      M170:Event_150()
    end
    if col_name == "evt_4007" then
      M170:Event_190()
    end
  elseif gMapNum == 304 then
    if col_name == "evt_9100" and not Flg.Check("FLAG_GIMMICK_D03_390") and not Flg.Check("FLAG_MAIN_09_040") then
      SetControlScriptExternalVariable("pass_skullseadra_state", "start")
      Flg.Set("FLAG_GIMMICK_D03_390")
    end
    if col_name == "evt_9007" and not Flg.Check("FLAG_GIMMICK_D03_400") and not Flg.Check("FLAG_MAIN_09_040") then
      Obj:new(NPC, "skullseadra_swim"):CancelInvisible()
      SetControlScriptExternalVariable("rise_skullseadra_state", "start")
      Flg.Set("FLAG_GIMMICK_D03_400")
    end
    if col_name == "evt_0002" and not Flg.Check("FLAG_GIMMICK_D03_410") and not Flg.Check("FLAG_MAIN_09_040") then
      Obj:new(NPC, "pass_skullseadra_2"):CancelInvisible()
      SetControlScriptExternalVariable("pass_skullseadra_2_state", "start")
      Flg.Set("FLAG_GIMMICK_D03_410")
    end
    if col_name == "evt_9008" and not Flg.Check("FLAG_MAIN_09_081") then
      local player = Obj:new(PLAYER, "")
      local hangyo = Obj:new(NPC, "npc_0004")
      local hangyo_index = GetIndex(NPC, "npc_0004")
      Cam.Inst:Set(107.008, -4.344, -84.39, 103.399, -4.858, -79.399, 50, 30)
      WaitFrame(30)
      player:SetPos(83.824, -4.98, -60.747, true)
      hangyo:SetRotationYToPlayer()
      local tlk = Tlk:new("d03", 1, true)
      local e510 = Motion.Object:new(NPC, "npc_0004", "e510")
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, hangyo_index, 0)
      tlk:StartTalk()
      tlk:Message("f_d0304_0010_0010")
      tlk:Message("f_d0304_0010_0020")
      Cam.Inst:Set(90.836, -4.786, -64.626, 82.745, -3.4113, -58.913, default, 0)
      tlk:Message("f_d0304_0010_0030")
      e510:Play(20, true)
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0004"), 30)
      tlk:MessageClose()
      Cam.Inst:Clear(30)
      WaitFrame(30)
      MovePlayerToRelativePosFrame(-2, 2, 20)
      tlk:EndTalk()
    end
    if col_name == "evt_1000" then
      M260:Event_070()
    end
    if col_name == "evt_1001" then
      M260:Event_062()
    end
    if col_name == "evt_1002" then
      M260:Event_063()
    end
    if Flg.Check("FLAG_FIELD_D0303_110") then
      if col_name == "evt_9001" then
        Prcs_d0304_WaterFlowEnd(180)
      elseif col_name == "evt_9002" then
        Prcs_d0304_WaterFlowEnd(0)
      elseif col_name == "evt_9003" then
        Prcs_d0304_WaterFlowEnd(330)
      elseif col_name == "evt_9004" then
        Prcs_d0304_WaterFlowEnd(150)
      elseif col_name == "evt_9005" then
        Prcs_d0304_WaterFlowEnd(15)
      elseif col_name == "evt_9006" then
        Prcs_d0304_WaterFlowEnd(195)
      end
    end
    if col_name == "evt_5000" then
      require("S020_019")
      S020_019:Event_040()
    end
  end
  if gMapNum == 305 and col_name == "evt_0001" then
    M260:Event_090()
    M280:Event_120()
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 301 then
    if gim_id == 500 then
      GoToTheaterWithEvt()
    end
    if gim_name == "gim_0001" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_MAIN_09_045", "FLAG_MAIN_09_047") then
        Flg.Set("FLAG_IS_KEEP_BGM")
        Prcs_d0301_EnterShellmonHouse("gim_0001", "gim_0003", "gim_0002")
      elseif Flg.Check("FLAG_MAIN_05_083") then
        Prcs_d0301_EnterShellmonHouse("gim_0001", "gim_0003", "gim_0002")
      elseif Flg.Check("FLAG_MAIN_05_093") then
        M170:Event_070()
      elseif Flg.Check("FLAG_MAIN_05_094") then
        Field_Talk_Start_Not_LetterBox("d03", 1)
        Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
        Message("f_d0301_0010_0040")
        Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
        Message("f_d0301_0010_0050")
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_05_082") then
        M170:Event_061()
      elseif Flg.Check("FLAG_MAIN_05_080") then
        Field_Talk_Start_Not_LetterBox("d03", 1)
        Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
        Message("f_d0301_0010_0010")
        Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
        Message("f_d0301_0010_0020")
        Vista.ApplyVoiceSnapshot(SOUND_SNAPSHOT_DOOR)
        Message("f_d0301_0010_0030")
        Field_Talk_End_Not_LetterBox()
      else
        M170:Event_050()
      end
    end
    if gim_id == 2 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0301_CallSubmarimon(1, gim_loc)
    elseif gim_id == 3 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0301_CallSubmarimon(2, gim_loc)
    elseif gim_id == 4 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0301_CallSubmarimon(3, gim_loc)
    elseif gim_id == 5 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0301_CallSubmarimon(4, gim_loc)
    elseif gim_id == 6 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0301_CallSubmarimon(5, gim_loc)
    end
    if gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0301_CallWhamon_02()
    end
  elseif gMapNum == 302 then
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
    if gim_id == 905 then
      PlayerLookAtLccatorObject(gim_name)
      MapChange("d", 303, "start_95", true, 0, 0)
    elseif gim_id == 906 then
      PlayerLookAtLccatorObject(gim_name)
      MapChange("d", 303, "start_96", true, 0, 0)
    end
  elseif gMapNum == 303 then
    if gim_id == 500 then
      GoToTheaterWithEvt()
    end
    if gim_id == 502 then
      GoToTheaterWithEvt(51, "theater_0002")
    end
    if gim_id == 8 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0303_CallSubmarimon(1, gim_loc)
    elseif gim_id == 9 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0303_CallSubmarimon(2, gim_loc)
    elseif gim_id == 10 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0303_CallSubmarimon(3, gim_loc)
    elseif gim_id == 11 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0303_CallSubmarimon(4, gim_loc)
    elseif gim_id == 12 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0303_CallSubmarimon(5, gim_loc)
    end
    if gim_id == 7 then
    end
    if gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0303_CallWhamon("change_0001")
    elseif gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0303_CallWhamon("change_0002")
    end
    if gim_name == "gim_0007" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      M170:Event_163()
    end
  elseif gMapNum == 304 then
    if gim_id == 1 or gim_id == 2 or gim_id == 3 or gim_id == 4 then
      if gim_id == 1 then
        Prcs_d0304_SwitchStream("sp_0001", "gim_0001")
      elseif gim_id == 2 then
        Prcs_d0304_SwitchStream("sp_0002", "gim_0002")
      elseif gim_id == 3 then
        Prcs_d0304_SwitchStream("sp_0003", "gim_0003")
      elseif gim_id == 4 then
        Prcs_d0304_SwitchStream("sp_0004", "gim_0004")
      end
    end
    if gim_id == 401 then
      if Qst.Sub:Check(19, 10, 255) then
        require("S020_019")
        S020_019:Event_045()
      else
        PlayerLookAtObject(NPC, "npc_0001")
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d0304_CallWhamon()
      end
    end
    if gim_id == 500 then
      if Qst.Sub:Check(19, 10, 255) then
        require("S020_019")
        S020_019:Event_045()
      else
        GoToTheaterWithEvt()
      end
    end
  elseif gMapNum == 305 then
    if gim_id == 400 then
      if Qst.Sub:Check(19, 10, 255) then
        require("S020_019")
        S020_019:Event_045()
      else
        GoToTheaterWithEvt()
      end
    end
  elseif gMapNum == 306 then
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
    if gim_id == 401 then
      SetPlayerRotationToLocator("change_0001", 5)
      Motion.Player:Play("fg07_m03", 0, false)
      WaitFrame(15)
      PlaySE(200001, 100)
      MapChange("d", 302, "start_20", true, 0, 15)
    end
    if gim_name == "elv_0001" then
      PlayerLookAtLccatorObject(gim_name)
      M280:Event_110()
    end
  elseif gMapNum == 308 and gim_id == 1 then
    if Flg.Check("FLAG_SUB_020_018_001") and not Flg.Check("FLAG_SUB_020_018_002") then
      require("S020_018")
      S020_018:Event_030()
    elseif Flg.Check("FLAG_MAIN_05_083", "FLAG_MAIN_05_078") then
      M170:Event_072()
      if not Flg.Check("FLAG_MAIN_05_079") then
        Flg.Set("FLAG_MAIN_05_079")
        OpenDoor(gim_loc, "")
        DoorMapChange("d", 302, "start_30")
      else
        OpenDoor(gim_loc, "")
        DoorMapChange("d", 301, "start_10")
      end
    elseif Flg.Check("FLAG_MAIN_05_087", "FLAG_MAIN_05_105") then
      M170:Event_100_2()
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 301, "start_10")
    else
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 301, "start_10")
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 301 then
    if gim_name == "obj_barricade02" or gim_name == "obj_barricade03" then
      PlayerLookAtGimmickObject(gim_name)
      Field_Talk_Start("d03", 1)
      Message("f_d0301_0030_0010")
      Message("f_d0301_0500_0010")
      Field_Talk_End()
    end
    if gim_name == "gim_access01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtObject(NPC, "hoe_01")
      local tlk = Tlk:new("d03", 1, true)
      local e500 = Motion.Object:new(NPC, "hoe_01", "e500")
      local f001 = Motion.Object:new(NPC, "hoe_01", "f001")
      local f004 = Motion.Object:new(NPC, "hoe_01", "f004")
      local player = Obj:new(PLAYER, "")
      local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
      Cam.Inst:Set(81.12, 4.19, -41.88, 79.6, 5.4, -32.07, 50, 30)
      WaitFrame(30)
      tlk:StartTalk()
      if Flg.Check("FLAG_MAIN_10_001") then
      else
        f004:Play(10, true)
        tlk:Message("f_d0301_0160_0010")
        tlk:Message("f_d0301_0160_0020")
        e500:Play(30, true)
        tlk:Message("f_d0301_0160_0030")
        tlk:MessageClose()
        player_e002_01:Play2Wait(5, false)
        tlk:Message("f_d0301_0160_0040")
      end
      f001:Play(30, true)
      tlk:Message("f_d0301_0080_0040")
      local result = tlk:Select(2, "f_d0301_0080_0050")
      if result == RESULT_TALK00 then
        tlk:EndTalk()
        f004:Play(10, true)
        WaitFrame(60)
        MapChange("d", 304, "start_20", true, FADE_BLACK, FADE_TIME)
      end
      tlk:EndTalk()
      Cam.Inst:Clear(30)
    end
    require("S020_018")
    if gim_name == "gim_access50" then
      PlayerLookAtGimmickObject(gim_name)
      S020_018:Event_110()
    elseif gim_name == "gim_access51" then
      PlayerLookAtGimmickObject(gim_name)
      S020_018:Event_120()
    elseif gim_name == "gim_access52" then
      PlayerLookAtGimmickObject(gim_name)
      S020_018:Event_130()
    elseif gim_name == "gim_access53" then
      PlayerLookAtGimmickObject(gim_name)
      S020_018:Event_140()
    end
    if gim_name == "s020_173_001" then
      require("S020_173")
      Flg.Set(S020_173.Flg10)
      S020_173:Event_018()
    end
    if gim_name == "s020_173_002" or gim_name == "s020_173_003" or gim_name == "s020_173_004" or gim_name == "s020_173_005" or gim_name == "s020_173_006" or gim_name == "s020_173_007" then
      require("S020_173")
      S020_173:Event_015(gim_name)
    end
  elseif gMapNum == 302 then
    if gim_name == "access_icon_01" then
      if Flg.Check("FLAG_MAIN_09_064", "FLAG_MAIN_09_065") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        PlayerLookAtGimmickObject("lookat_01")
        M280:Event_070()
      elseif Flg.Check("FLAG_MAIN_09_060", "FLAG_MAIN_09_064") then
        local tlk = Tlk:new("d03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0302_0490_0010")
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_09_064", "FLAG_MAIN_09_075") then
        local tlk = Tlk:new("d03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0302_0490_0020")
        tlk:EndTalk()
      else
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        local tlk = Tlk:new("field_text", 1, true)
        tlk:StartTalk()
        if Flg.Check("FLAG_MAIN_09_077", "FLAG_FIELD_D03_IS_BRINP_FIRSTTALK") then
          tlk:Message("g_wm_0030_0020")
          tlk:Message("g_wm_0030_0030")
          tlk:Message("g_wm_0030_0040")
          Flg.Set("FLAG_FIELD_D03_IS_BRINP_FIRSTTALK")
        end
        tlk:Message("g_wm_0030_0010")
        tlk:EndTalk()
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_BLIMP")
        OpenWorldMap(DW, BLIMPMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_BLIMP")
      end
    end
    if gim_name == "hoe_gim" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtObject(NPC, "hoe_001")
      M280:Event_116()
    end
  elseif gMapNum == 303 then
    local RideDegiID = 145
    local r_flame = 15
    if gim_tag == "WaterFlow_Ride" then
      if Flg.Check("FLAG_MAIN_05_100") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Field_Talk_Start("d03", 1)
        if Flg.Check("FLAG_MAIN_05_130") then
          Message("f_d0303_0090_0010")
        else
          Message("f_d0303_0020_0010")
        end
        Field_Talk_End()
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Flg.Set("FLAG_FIELD_D0303_110")
        if gim_name == "WaterFlow_Reverse01" then
          Prcs_d0303_WaterFlowStart(270, "rail_move_101", true, "script_ride_01b", "FLAG_FIELD_D0303_020")
        elseif gim_name == "WaterFlow_Reverse02" then
          Prcs_d0303_WaterFlowStart(3, "rail_move_103", true, "script_ride_02b", "FLAG_FIELD_D0303_040")
        elseif gim_name == "WaterFlow_Reverse03" then
          Prcs_d0303_WaterFlowStart(35, "rail_move_105", true, "script_ride_03b", "FLAG_FIELD_D0303_060")
        elseif gim_name == "WaterFlow_Reverse04" then
          Prcs_d0303_WaterFlowStart(72, "rail_move_107", true, "script_ride_04b", "FLAG_FIELD_D0303_080")
        elseif gim_name == "WaterFlow_Obverse05" then
          Prcs_d0303_WaterFlowStart(293, "rail_move_108", true, "script_ride_05a", "FLAG_FIELD_D0303_090")
        elseif gim_name == "WaterFlow_Reverse05" then
          Prcs_d0303_WaterFlowStart(113, "rail_move_109", true, "script_ride_05b", "FLAG_FIELD_D0303_100")
        elseif gim_name == "WaterFlow_Obverse06" then
          Prcs_d0303_WaterFlowStart(273, "rail_move_110", true, "script_ride_06a", "FLAG_FIELD_D0303_120")
        elseif gim_name == "WaterFlow_Reverse06" then
          Prcs_d0303_WaterFlowStart(93, "rail_move_111", true, "script_ride_06b", "FLAG_FIELD_D0303_130")
        end
      else
        Field_Talk_Start("d03", 1)
        Message("f_d0303_0010_0010")
        Field_Talk_End()
      end
    elseif gim_tag == "WaterFlow_Human" then
      if Flg.Check("FLAG_MAIN_05_100") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Field_Talk_Start("d03", 1)
        if Flg.Check("FLAG_MAIN_05_130") then
          Message("f_d0303_0090_0010")
        else
          Message("f_d0303_0020_0010")
        end
        Field_Talk_End()
        Flg.Set("FLAG_FIELD_D0303_110")
        if gim_name == "WaterFlow_Obverse01" then
          Field.SetPlayerRotation(89, 15)
          Prcs_d0303_WaterFlowStart(89, "rail_move_100", true, "script_ride_01a", "FLAG_FIELD_D0303_010")
        elseif gim_name == "WaterFlow_Obverse02" then
          Field.SetPlayerRotation(183, 15)
          Prcs_d0303_WaterFlowStart(183, "rail_move_102", true, "script_ride_02a", "FLAG_FIELD_D0303_030")
        elseif gim_name == "WaterFlow_Obverse03" then
          Field.SetPlayerRotation(215, 15)
          Prcs_d0303_WaterFlowStart(215, "rail_move_104", true, "script_ride_03a", "FLAG_FIELD_D0303_050")
        elseif gim_name == "WaterFlow_Obverse04" then
          Field.SetPlayerRotation(252, 15)
          Prcs_d0303_WaterFlowStart(252, "rail_move_106", true, "script_ride_04a", "FLAG_FIELD_D0303_070")
        end
      else
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        if gim_name == "WaterFlow_Obverse01" then
          Prcs_d0303_WaterFlowStart(89, "rail_move_100", true, "", "FLAG_FIELD_D0303_010")
        elseif gim_name == "WaterFlow_Obverse02" then
          Prcs_d0303_WaterFlowStart(183, "rail_move_102", true, "", "FLAG_FIELD_D0303_030")
        elseif gim_name == "WaterFlow_Obverse03" then
          Prcs_d0303_WaterFlowStart(215, "rail_move_104", true, "", "FLAG_FIELD_D0303_050")
        elseif gim_name == "WaterFlow_Obverse04" then
          Prcs_d0303_WaterFlowStart(252, "rail_move_106", true, "", "FLAG_FIELD_D0303_070")
        end
      end
    end
    if gim_name == "gim_access01" then
      PlayerLookAtGimmickObject(gim_name)
      M170:Event_165()
    end
  elseif gMapNum == 304 then
    if gim_name == "WaterFlow_Obverse01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0304_WaterFlowStart(0, "rail_move_100", true, "script_ride_start01O")
    elseif gim_name == "WaterFlow_Reverse01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0304_WaterFlowStart(180, "rail_move_100", false, "script_ride_start01R")
    end
    if gim_name == "WaterFlow_Obverse02" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0304_WaterFlowStart(150, "rail_move_101", true, "script_ride_start02O")
    elseif gim_name == "WaterFlow_Reverse02" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0304_WaterFlowStart(330, "rail_move_101", false, "script_ride_start02R")
    end
    if gim_name == "WaterFlow_Obverse03" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0304_WaterFlowStart(195, "rail_move_102", true, "script_ride_start03O")
    elseif gim_name == "WaterFlow_Reverse03" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0304_WaterFlowStart(15, "rail_move_102", false, "script_ride_start03R")
    end
    if gim_name == "s020_173_001" then
      require("S020_173")
      S020_173:Event_015()
    end
  elseif gMapNum == 306 then
    if gim_name == "gim_access01" then
      PlayerLookAtGimmickObject(gim_name)
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0306_0010_0010")
      tlk:EndTalk()
    elseif gim_name == "gim_access02" then
      PlayerLookAtGimmickObject(gim_name)
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0306_0010_0010")
      tlk:EndTalk()
    elseif gim_name == "gim_access03" then
      PlayerLookAtGimmickObject(gim_name)
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0306_0010_0010")
      tlk:EndTalk()
    elseif gim_name == "gim_access04" then
      PlayerLookAtGimmickObject(gim_name)
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0306_0010_0010")
      tlk:EndTalk()
    end
  elseif gMapNum == 308 then
    if Flg.Check("FLAG_SUB_020_018_001") and not Flg.Check("FLAG_SUB_020_018_002") then
      if gim_name == "gim_access_1" then
        PlayerLookAtGimmickObject(gim_name)
        require("S020_018")
        S020_018:Event_050()
      elseif gim_name == "gim_access_2" then
        PlayerLookAtGimmickObject(gim_name)
        require("S020_018")
        S020_018:Event_070()
      elseif gim_name == "gim_access_3" then
        PlayerLookAtGimmickObject(gim_name)
        require("S020_018")
        S020_018:Event_060()
      end
    elseif gim_name == "gim_access_1" then
      if Common.CheckTimeAxis("A2020_dbef_170", "A2020_dbef_10000") then
        Field_Talk_Start_Not_LetterBox("d03", 1)
        Message("f_d0308_0050_0010")
        if not Flg.Check("FLAG_MAIN_05_101") then
          START_TALK_ACTION_AND_ZOOM("npc_0002", true, true)
          Message("f_d0308_0050_0020")
          Message("f_d0308_0050_0030")
          END_TALK_ACTION_AND_ZOOM("npc_0002", true, true)
        end
        Field_Talk_End_Not_LetterBox()
      else
        Field_Talk_Start_Not_LetterBox("d03", 1)
        Message("f_d0308_0110_0010")
        if Flg.Check("FLAG_MAIN_09_030", "FLAG_MAIN_09_049") then
          START_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
          Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0003"), "F01_T01")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0003"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_d0308_0110_0020")
          Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0003"), 30)
          END_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
        end
        Field_Talk_End_Not_LetterBox()
      end
    elseif gim_name == "gim_access_2" then
      if Common.CheckTimeAxis("A2020_dbef_170", "A2020_dbef_10000") then
        PlayerLookAtGimmickObject(gim_name)
        Field_Talk_Start_Not_LetterBox("d03", 1)
        Message("f_d0308_0070_0010")
        if not Flg.Check("FLAG_MAIN_05_101") then
          START_TALK_ACTION_AND_ZOOM("npc_0002", true, true)
          Message("f_d0308_0070_0020")
          END_TALK_ACTION_AND_ZOOM("npc_0002", true, true)
        end
        Field_Talk_End_Not_LetterBox()
      else
        Field_Talk_Start_Not_LetterBox("d03", 1)
        Message("f_d0308_0120_0010")
        if Flg.Check("FLAG_MAIN_09_030", "FLAG_MAIN_09_049") then
          START_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
          Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0003"), "F01_T01")
          Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0003"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_d0308_0120_0020")
          Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0003"), 30)
          END_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
        end
        Field_Talk_End_Not_LetterBox()
      end
    end
  end
  if gMapNum == 302 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    elseif gim_name == "hazama_gate02" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 304 and gim_name == "hazama_gate01" then
    print("====== gate_access ======")
    PlayerLookAtGimmickObject(gim_name)
    GoToHazamaWithEvt(gim)
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 301 then
  elseif gMapNum == 302 then
  elseif gMapNum == 303 then
  elseif gMapNum == 304 then
  end
end

function OnFieldAttackGimmick(att_gim)
  local gim_name = att_gim.unique_name
  local gim_tag = att_gim.tag
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimName = ", gim_name, "gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 301 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 302 then
    if gim_tag == "fa_obj" then
      if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
        BreakFieldAttackGim(gim_name, true)
      end
      if gim_name == "fa_kamemonobj" then
        M170:Event_065()
      end
    end
  elseif gMapNum == 303 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 304 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 305 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnCheckActModel(act)
end

function OnCheckLocatorWallAlong(wall_along)
  local start_loc = wall_along.locator
  if start_loc == "wall_along_0001" or start_loc == "wall_along_0002" then
    Field.SetFollowerCameraOperateRotationY(150)
  elseif start_loc == "wall_along_0003" or start_loc == "wall_along_0004" then
    Field.SetFollowerCameraOperateRotationY(240)
  end
  Field.OperateStartLocatorWallAlong(start_loc)
end
