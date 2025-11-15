gGimText = "field_text"
local T0107_MOBCOL = {
  "plan_cl_0001",
  "plan_cl_0002",
  "plan_cl_0006",
  "plan_cl_0007",
  "plan_cl_0009",
  "plan_cl_0010",
  "plan_cl_0011",
  "plan_cl_0012",
  "plan_cl_0013",
  "plan_cl_0014",
  "plan_cl_0015",
  "plan_cl_0016"
}

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 101 then
    AddLoadList(FLD_OBJ_MOB, {
      "hato_001_fly",
      motion = {
        "f000",
        "f001",
        "fn01"
      }
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0005",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0006",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0051",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0052",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0053",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0054",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0055",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0056",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0057",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0058",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0059",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0060",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0061",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 102 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0005",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0006",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0051",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0052",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0053",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0054",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0055",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0056",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0057",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0058",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 105 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
    Field.LoadEffectScript("ef_e_com_115", 1)
  elseif load_map_num == 108 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0005",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0006",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0007",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0008",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0009",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0010",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0051",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0052",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0053",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0054",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0055",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0056",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0057",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0058",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0059",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0060",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0061",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0062",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 109 then
    AddLoadList(FLD_OBJ_GIMMICK, {
      "barrierdevice_access01",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_GIMMICK, {
      "barrierdevice_access02",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_GIMMICK, {
      "barrierdevice_access03",
      motion = {"e001"}
    })
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  Motion.Player:ResetMoveAnim()
  PlayerObjectResetAim()
  if not Flg.Check("FLAG_MAIN_01_090") then
    Field.DisableAnalyzeAndFieldAttack()
  end
  if Common.IsPlayerModelChanged(true) and Common.IsPlayerModelChanged(2) then
    SetEnableMenu(false)
  end
  if gMapNum == 101 then
    Prcs_t0101_SettingSignal()
    if not Flg.Check("FLAG_MAIN_02_020") then
      Field.LinkColOff("mapborder_2")
      Field.LinkColOff("mapborder_3")
      Field.LinkColOff("mapborder_4")
      Field.LinkColOff("mapborder_5")
    end
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      Field.LinkColOff("mapborder_4")
    end
  elseif gMapNum == 102 then
    Prcs_t0102_SettingSignal()
    if Flg.Check("FLAG_MAIN_01_250") then
      ColOff("plan_cl_1000")
      ColOff("plan_cl_1001")
      ColOff("plan_cl_1002")
    end
    if not Flg.Check("FLAG_MAIN_07_053", "FLAG_MAIN_07_054B") then
      ColOff("cliff_cl_0001")
    end
    if not Flg.Check("FLAG_MAIN_02_020") then
      Field.LinkColOff("mapborder_2")
      Field.LinkColOff("mapborder_3")
      Field.LinkColOff("mapborder_4")
      Field.LinkColOff("mapborder_7")
    end
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      if Flg.Check("FLAG_MAIN_07_070B") then
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "")
      else
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "e001")
      end
      if Flg.Check("FLAG_MAIN_07_050") then
        Obj:new(OGIM, "obj_shield_e01"):Invisible()
        Obj:new(OGIM, "obj_shield_e02"):Invisible()
        Obj:new(OGIM, "obj_shield_e03"):Invisible()
        Obj:new(OGIM, "obj_shield_e04"):Invisible()
      end
      if Flg.Check("FLAG_MAIN_07_054B") then
        Obj:new(OGIM, "obj_shield_f01"):Invisible()
        Obj:new(OGIM, "obj_shield_f02"):Invisible()
        Obj:new(OGIM, "obj_shield_f03"):Invisible()
        Obj:new(OGIM, "obj_shield_f04"):Invisible()
      end
      Field.LinkColOff("mapborder_5")
    end
  elseif gMapNum == 103 then
    if not Flg.Check("FLAG_MAIN_03_025") then
      Field.LinkColOff("col_t0109_start_00_0")
      Field.LinkColOff("mapborder_2")
    else
      ColOff("evt_2000")
    end
    if not Flg.Check("FLAG_MAIN_03_250") then
      ColOff("evt_0002")
      ColOff("evt_0003")
      ColOff("evt_0004")
      ColOff("evt_0005")
      ColOff("plan_cl_1000")
      ColOff("plan_cl_1001")
      ColOff("plan_cl_1002")
      ColOff("plan_cl_2001")
      ColOff("plan_cl_2002")
      ColOff("plan_cl_2100")
      ColOff("plan_cl_2101")
      ColOff("plan_cl_2110")
      ColOff("plan_cl_2111")
      ColOff("plan_cl_2112")
      ColOff("plan_cl_2113")
      ColOff("plan_cl_2114")
      ColOff("plan_cl_2115")
      ColOff("plan_cl_2116")
      ColOff("plan_cl_2117")
      ColOff("plan_cl_2118")
      ColOff("plan_cl_2119")
      ColOff("plan_cl_2200")
      ColOff("plan_cl_2201")
      ColOff("plan_cl_2210")
      ColOff("plan_cl_2211")
      ColOff("plan_cl_2212")
      ColOff("plan_cl_2213")
      ColOff("plan_cl_2214")
      ColOff("plan_cl_2215")
      ColOff("plan_cl_2216")
      ColOff("plan_cl_2217")
      ColOff("plan_cl_2218")
      ColOff("plan_cl_2219")
      ColOff("plan_cl_2220")
      ColOff("plan_cl_2221")
      ColOff("plan_cl_2300")
      ColOff("plan_cl_2301")
    elseif Flg.Check("FLAG_MAIN_03_280") then
      ColOff("evt_0002")
      ColOff("evt_0003")
      ColOff("evt_0004")
      ColOff("evt_0005")
      ColOff("plan_cl_1000")
      ColOff("plan_cl_1001")
      ColOff("plan_cl_1002")
      ColOff("plan_cl_2001")
      ColOff("plan_cl_2002")
      ColOff("plan_cl_2100")
      ColOff("plan_cl_2101")
      ColOff("plan_cl_2110")
      ColOff("plan_cl_2111")
      ColOff("plan_cl_2112")
      ColOff("plan_cl_2113")
      ColOff("plan_cl_2114")
      ColOff("plan_cl_2115")
      ColOff("plan_cl_2116")
      ColOff("plan_cl_2117")
      ColOff("plan_cl_2118")
      ColOff("plan_cl_2119")
      ColOff("plan_cl_2200")
      ColOff("plan_cl_2201")
      ColOff("plan_cl_2210")
      ColOff("plan_cl_2211")
      ColOff("plan_cl_2212")
      ColOff("plan_cl_2213")
      ColOff("plan_cl_2214")
      ColOff("plan_cl_2215")
      ColOff("plan_cl_2216")
      ColOff("plan_cl_2217")
      ColOff("plan_cl_2218")
      ColOff("plan_cl_2219")
      ColOff("plan_cl_2220")
      ColOff("plan_cl_2221")
      ColOff("plan_cl_2300")
      ColOff("plan_cl_2301")
    end
    if Flg.Check("FLAG_MAIN_03_263") then
      ColOff("plan_cl_1000")
    end
    if Flg.Check("FLAG_MAIN_03_265") then
      ColOff("plan_cl_1001")
    end
    if Flg.Check("FLAG_MAIN_03_267") then
      ColOff("plan_cl_1002")
    end
    if Common.CheckTimeAxis("A2028_daft_310", "A2028_daft_10000") then
    elseif Common.CheckTimeAxis("P2028_daft_310", "P2028_daft_10000") then
    else
      Field.LinkColOff("col_t0121_start_00_0")
      Field.LinkColOff("mapborder_3")
    end
    if Flg.Check("FLAG_SUB_110_103_002") then
      ColOff("evt_5000")
    end
  elseif gMapNum == 104 then
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      Field.LinkColOff("mapborder_1")
    end
    if not Common.CheckTimeAxis("A2020_dbef_50") then
      ColOff("evt_2000")
    end
    if Flg.Check("FLAG_MAIN_03_021") then
      ColOff("evt_2000")
    end
  elseif gMapNum == 105 then
    if Flg.Check("FLAG_MAIN_01_030") then
      local index = GetIndex(FLD_OBJ_LOCATOR, "gim_9001")
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, index, INVISIBLE_KEY_FIELD, 0, false)
    end
    Field.StopSignalAddSwitchTime(1, true, 10)
    Field.StopSignalAddSwitchTime(1, false, 120)
    Field.StopSignalAddSwitchTime(2, true, 10)
    Field.StopSignalAddSwitchTime(2, false, 120)
    if Flg.Check("FLAG_MAIN_03_406") then
      if Flg.Check("FLAG_GIMMICK_T01_010") then
        Motion.Gimmick:PlayFinishedAnim("gim_0001", "e001")
        local gim_index = GetIndex(FLD_OBJ_LOCATOR, "gim_0001")
        Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, gim_index, false)
        ColOff("wall_cl_0001")
      end
    else
      local gim_index = GetIndex(FLD_OBJ_LOCATOR, "gim_0001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, gim_index, false)
      Field.LinkColOff("mapborder_4")
    end
    if Common.CheckTimeAxis("A2020_dbef_119") then
      SetEnableGimmickCheck("gim_0001", false)
      Field.LinkColOff("mapborder_4")
    end
    if Common.CheckTimeAxis("A2028_daft_310", "A2028_daft_419") then
      SetEnableGimmickCheck("gim_0001", false)
      Field.LinkColOff("mapborder_4")
    end
    if Common.CheckTimeAxis("P2028_daft_310", "P2028_daft_450") then
      SetEnableGimmickCheck("gim_0001", false)
      Field.LinkColOff("mapborder_4")
    end
    if Common.CheckTimeAxis("Z2028_daft_310", "Z2028_daft_450") then
      SetEnableGimmickCheck("gim_0001", false)
      Field.LinkColOff("mapborder_4")
    end
    if not Flg.Check("FLAG_MAIN_03_405") then
      Obj:new(NPC, "npc_blackshadow"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_03_404") and not Flg.Check("FLAG_MAIN_03_405") then
      local obj = Obj:new(NPC, "npc_blackshadow")
      obj:SetPos(36.29, -6.413, 232.227)
      obj:SetRotationY(90, 0)
      Obj:new(NPC, "npc_blackshadow"):CancelInvisible()
    end
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      ColOff("plan_cl_0002")
      ColOff("plan_cl_0003")
      ColOff("evt_9000")
      ColOff("evt_9001")
      ColOff("evt_9002")
      ColOff("evt_9003")
      ColOff("evt_9004")
      ColOff("evt_9005")
    end
  elseif gMapNum == 106 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    HideMinimap(true)
  elseif gMapNum == 107 then
    if Flg.Check("FLAG_MAIN_01_230") then
      ColOffWithTable(T0107_MOBCOL)
    end
    if Flg.Check("FLAG_MAIN_01_050") then
      ColOff("plan_cl_0020")
    end
    if not Flg.Check("FLAG_MAIN_01_050") then
      Obj:new(NPC, "npc_0007"):Invisible()
      Obj:new(NPC, "npc_0011"):Invisible()
    end
    Obj:new(MOB, "AfterQuakeMob_1"):Invisible()
    if not Flg.Check("FLAG_MAIN_01_050") then
      ColOff("plan_cl_0001")
    end
    if Flg.Check("FLAG_MAIN_01_060") then
      ColOff("plan_cl_0002")
      ColOff("plan_cl_0003")
      ColOff("plan_cl_0006")
      ColOff("plan_cl_0007")
      ColOff("plan_cl_0008")
      ColOff("plan_cl_0011")
      ColOff("evt_0010")
      ColOff("evt_0011")
      ColOff("evt_0020")
      ColOff("evt_0021")
    end
    if Flg.Check("FLAG_MAIN_02_020") then
      Field.LinkColOff("mapborder_2")
    end
  elseif gMapNum == 108 then
    print("######################")
    Prcs_t0108_SettingSignal()
    if Common.CheckTimeAxis("X2028_daft_0", "X2028_daft_20") then
      ColOff("wall_cl_0020")
      ColOff("wall_cl_0021")
    else
      ColOff("wall_cl_0020")
      ColOn("wall_cl_0021")
    end
    if not Flg.Check("FLAG_MAIN_02_020") then
      Field.LinkColOff("mapborder_3")
    end
    if not Common.CheckTimeAxis("A2020_dbef_50") then
      ColOff("evt_2000")
    end
    if Flg.Check("FLAG_MAIN_03_022") then
      ColOff("evt_2000")
    end
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      if Flg.Check("FLAG_MAIN_07_070B") then
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "")
      else
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "e001")
      end
      Field.LinkColOff("mapborder_6")
      Field.LinkColOff("mapborder_8")
    end
  elseif gMapNum == 109 then
    if Flg.Check("FLAG_MAIN_01_010") then
      Field_InvisibleGimmick("change_0001", 0, 0, false)
    end
    if not Flg.Check("FLAG_MAIN_03_070") then
      Field_InvisibleGimmick("change_0002", 0, 0, false)
      Field.SetEnableGimmickCheck("change_0002", false)
      MinimapMarkerOff("change_0002", 2)
    end
    if not Flg.Check("FLAG_MAIN_03_250") then
      ColOff("plan_cl_0004")
    end
    if Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_055") then
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):SetEnableCheckAndFieldAttack(false)
    end
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      if Flg.Check("FLAG_MAIN_07_070B") then
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "")
      else
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "e001")
      end
      if Flg.Check("FLAG_MAIN_07_054B") then
        Obj:new(OGIM, "obj_shield_b01"):Invisible()
      end
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 101 then
    if col_name == "evt_1000" then
      if not Flg.Check("FLAG_MAIN_01_250") then
        local npc_0010 = Obj:new(NPC, "npc_0010")
        local fn01_01 = Motion.Object:new(NPC, "npc_0010", "fn01_01")
        local e013 = Motion.Object:new(NPC, "npc_0010", "e013")
        local name = "npc_0010"
        local tlk = Tlk:new("t01")
        tlk:StartTalkAction(name)
        e013:Play(20, true)
        npc_0010:ChangeExpression("F01", EYE_BLINK, true, 10)
        tlk:Message("f_t0101_0100_0010")
        npc_0010:ResetExporession(10)
        fn01_01:Play(20, true)
        tlk:MessageClose()
        local obj = Obj:new(NPC, name)
        local move_pos_x = obj.vec.x * 2
        local move_pos_z = obj.vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
        WaitFrame(20)
        tlk:EndTalkAction()
      elseif Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0140_0010")
        Field.MovePlayerToRelativePosFrame(0, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0150_0010")
        Field.MovePlayerToRelativePosFrame(0, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
      if Flg.Check("FLAG_SUB_200_149_010") then
        local tlk = Tlk:new("t04", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        Field.MovePlayerToRelativePosFrame(0, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_1001" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0008 = Obj:new(NPC, "npc_0008")
      local e009 = Motion.Object:new(NPC, "npc_0008", "e009")
      local e030 = Motion.Object:new(NPC, "npc_0008", "e030")
      local name = "npc_0008"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e009:Play(15, true)
      npc_0008:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0101_0080_0010")
      npc_0008:ResetExporession(10)
      e030:Play(15, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_1002" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0006 = Obj:new(NPC, "npc_0006")
      local e015 = Motion.Object:new(NPC, "npc_0006", "e015")
      local e013 = Motion.Object:new(NPC, "npc_0006", "e013")
      local name = "npc_0006"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e015:Play(20, true)
      npc_0006:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0101_0120_0010")
      npc_0006:ResetExporession(10)
      e013:Play(20, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_1003" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0007 = Obj:new(NPC, "npc_0007")
      local e015 = Motion.Object:new(NPC, "npc_0007", "e015")
      local e013 = Motion.Object:new(NPC, "npc_0007", "e013")
      local name = "npc_0007"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e013:Play(20, true)
      npc_0007:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0101_0090_0010")
      npc_0007:ResetExporession(10)
      e015:Play(20, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_1004" then
      if not Flg.Check("FLAG_MAIN_01_250") then
        local npc_0005 = Obj:new(NPC, "npc_0005")
        local e012 = Motion.Object:new(NPC, "npc_0005", "e012")
        local e002 = Motion.Object:new(NPC, "npc_0005", "e002")
        local name = "npc_0005"
        local tlk = Tlk:new("t01")
        tlk:StartTalkAction(name)
        e002:Play(10, true)
        npc_0005:ChangeExpression("F01", EYE_BLINK, true, 10)
        tlk:Message("f_t0101_0110_0010")
        npc_0005:ResetExporession(10)
        e012:Play(10, true)
        tlk:MessageClose()
        local obj = Obj:new(NPC, name)
        local move_pos_x = obj.vec.x * 2
        local move_pos_z = obj.vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
        WaitFrame(20)
        tlk:EndTalkAction()
      end
      if Flg.Check("FLAG_SUB_200_149_010") then
        local tlk = Tlk:new("t04", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        Field.MovePlayerToRelativePosFrame(-1, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_1005" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0009 = Obj:new(NPC, "npc_0009")
      local fn01_02 = Motion.Object:new(NPC, "npc_0009", "fn01_02")
      local e009 = Motion.Object:new(NPC, "npc_0009", "e009")
      local name = "npc_0009"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e009:Play(10, true)
      npc_0009:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0101_0130_0010")
      npc_0009:ResetExporession(10)
      fn01_02:Play(20, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_2000" then
      if Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0140_0010")
        Field.MovePlayerToRelativePosFrame(1, 0, 20)
        WaitFrame(20)
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0150_0010")
        Field.MovePlayerToRelativePosFrame(1, 0, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
      if Flg.Check("FLAG_SUB_200_149_010") then
        local tlk = Tlk:new("t04", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        Field.MovePlayerToRelativePosFrame(1, 0.5, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_2001" then
      if Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0140_0010")
        Field.MovePlayerToRelativePosFrame(-1, 0, 20)
        WaitFrame(20)
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0150_0010")
        Field.MovePlayerToRelativePosFrame(-1, 0, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_2002" then
      if Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0140_0010")
        Field.MovePlayerToRelativePosFrame(1, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0150_0010")
        Field.MovePlayerToRelativePosFrame(1, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_2003" then
      if Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0140_0010")
        Field.MovePlayerToRelativePosFrame(0, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0150_0010")
        Field.MovePlayerToRelativePosFrame(0, -1, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_3000" and Flg.Check("FLAG_SUB_200_149_010") then
      local tlk = Tlk:new("t04", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0401_0050_0010")
      Field.MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
  elseif gMapNum == 102 then
    if col_name == "evt_1000" then
      if not Flg.Check("FLAG_MAIN_01_250") then
        local npc_0310 = Obj:new(NPC, "npc_0310")
        local e009 = Motion.Object:new(NPC, "npc_0310", "e009")
        local e012 = Motion.Object:new(NPC, "npc_0310", "e012")
        local name = "npc_0310"
        local tlk = Tlk:new("t01")
        tlk:StartTalkAction(name)
        e009:Play(10, true)
        npc_0310:ChangeExpression("F01", EYE_BLINK, true, 10)
        tlk:Message("f_t0102_0050_0010")
        npc_0310:ResetExporession(10)
        e012:Play(20, true)
        tlk:MessageClose()
        local obj = Obj:new(NPC, name)
        local move_pos_x = obj.vec.x * 2
        local move_pos_z = obj.vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
        WaitFrame(20)
        tlk:EndTalkAction()
      elseif Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0102_0150_0010")
        Field.MovePlayerToRelativePosFrame(1, 0, 20)
        WaitFrame(20)
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0150_0010")
        Field.MovePlayerToRelativePosFrame(1, 0, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_1001" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0311 = Obj:new(NPC, "npc_0311")
      local e002 = Motion.Object:new(NPC, "npc_0311", "e002")
      local e013 = Motion.Object:new(NPC, "npc_0311", "e013")
      local name = "npc_0311"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e002:Play(10, true)
      npc_0311:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0102_0060_0010")
      npc_0311:ResetExporession(10)
      e013:Play(10, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_1002" then
      if not Flg.Check("FLAG_MAIN_01_250") then
        local npc_0312 = Obj:new(NPC, "npc_0312")
        local e015 = Motion.Object:new(NPC, "npc_0312", "e015")
        local e012 = Motion.Object:new(NPC, "npc_0312", "e012")
        local name = "npc_0312"
        local tlk = Tlk:new("t01")
        tlk:StartTalkAction(name)
        e015:Play(10, true)
        npc_0312:ChangeExpression("F01", EYE_BLINK, true, 10)
        tlk:Message("f_t0102_0070_0010")
        npc_0312:ResetExporession(10)
        e012:Play(10, true)
        tlk:MessageClose()
        local obj = Obj:new(NPC, name)
        local move_pos_x = obj.vec.x * 2
        local move_pos_z = obj.vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
        WaitFrame(20)
        tlk:EndTalkAction()
      end
      if Flg.Check("FLAG_MAIN_07_030") and not Flg.Check("FLAG_MAIN_07_053") then
        local e507 = Motion.Object:new(NPC, "npc_3123", "e507")
        local e002 = Motion.Object:new(NPC, "npc_3123", "e002")
        local name = "npc_3123"
        local tlk = Tlk:new("t01")
        tlk:StartTalkAction(name)
        e002:Play(10, true)
        tlk:Message("f_t0102_0160_0020")
        e507:Play(10, true)
        Field.MovePlayerToRelativePosFrame(1, 5, 20)
        WaitFrame(20)
        tlk:EndTalkAction()
      elseif Flg.Check("FLAG_MAIN_03_280") and not Flg.Check("FLAG_MAIN_07_053") then
        local e015 = Motion.Object:new(NPC, "npc_0313", "e015")
        local e012 = Motion.Object:new(NPC, "npc_0313", "e012")
        local name = "npc_0313"
        local tlk = Tlk:new("t01")
        tlk:StartTalkAction(name)
        e015:Play(10, true)
        tlk:Message("f_t0102_0090_0010")
        e012:Play(10, true)
        local obj = Obj:new(NPC, name)
        local move_pos_x = obj.vec.x * 2
        local move_pos_z = obj.vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
        WaitFrame(20)
        tlk:EndTalkAction()
      elseif Common.CheckTimeAxis("A2020_dbef_119") then
        local npc_0313 = Obj:new(NPC, "npc_0313")
        local e015 = Motion.Object:new(NPC, "npc_0313", "e015")
        local e012 = Motion.Object:new(NPC, "npc_0313", "e012")
        local name = "npc_0313"
        local tlk = Tlk:new("t01")
        tlk:StartTalkAction(name)
        e015:Play(10, true)
        npc_0313:ChangeExpression("F01", EYE_BLINK, true, 10)
        tlk:Message("f_t0102_0090_0010")
        npc_0313:ResetExporession(10)
        e012:Play(10, true)
        local obj = Obj:new(NPC, name)
        local move_pos_x = obj.vec.x * 2
        local move_pos_z = obj.vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
        WaitFrame(20)
        tlk:EndTalkAction()
      end
    end
    if col_name == "evt_1005" then
      M010:Event_035()
    end
    if col_name == "evt_1006" then
      M010:Event_038()
    end
    if col_name == "evt_1004" and Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0101_0150_0010")
      Field.MovePlayerToRelativePosFrame(1, 0, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_1007" and Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0101_0150_0010")
      Field.MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
  elseif gMapNum == 103 then
    if col_name == "evt_0004" and Flg.Check("FLAG_MAIN_03_260", "FLAG_MAIN_03_270") then
      SetControlScriptExternalVariable("player_move_state", "lastcamera")
    end
    if col_name == "evt_0005" and Flg.Check("FLAG_MAIN_03_260", "FLAG_MAIN_03_270") then
      Flg.Set("FLAG_GIMMICK_T01_040")
    end
    if col_name == "evt_0007" and Flg.Check("FLAG_MAIN_03_260", "FLAG_MAIN_03_270") then
      Flg.Set("FLAG_GIMMICK_T01_030")
      SetControlScriptExternalVariable("player_move_state", "lastmove")
    end
    if col_name == "evt_1000" then
      M230:Event_020()
    end
    if col_name == "evt_1001" then
      M090:Event_040()
    end
    if col_name == "evt_2000" then
      Field_Talk_Start_Not_LetterBox("t01", 1)
      Message("f_t0103_0040_0010")
      MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
      Field_Talk_End_Not_LetterBox()
    end
    if col_name == "evt_3000" and Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_08_020") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0101_0150_0010")
      Field.MovePlayerToRelativePosFrame(0, -1, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_3001" then
      if not Flg.Check("FLAG_GIMMICK_T01_080") and Flg.Check("FLAG_MAIN_08_000") then
        Flg.Set("FLAG_GIMMICK_T01_080")
        SetControlScriptExternalVariable("douger_state_1", "invisible")
        SetControlScriptExternalVariable("douger_move_state", "move_1")
      end
    elseif col_name == "evt_3002" then
      if not Flg.Check("FLAG_GIMMICK_T01_090") and Flg.Check("FLAG_MAIN_08_000") then
        Flg.Set("FLAG_GIMMICK_T01_090")
        SetControlScriptExternalVariable("douger_state_2", "invisible")
        SetControlScriptExternalVariable("douger_move_state", "move_2")
      end
    elseif col_name == "evt_3003" then
      if not Flg.Check("FLAG_GIMMICK_T01_100") and Flg.Check("FLAG_MAIN_08_000") then
        Flg.Set("FLAG_GIMMICK_T01_100")
        SetControlScriptExternalVariable("douger_state_3", "invisible")
        SetControlScriptExternalVariable("douger_move_state", "move_3")
      end
    elseif col_name == "evt_3004" and not Flg.Check("FLAG_GIMMICK_T01_110") and Flg.Check("FLAG_MAIN_08_000") then
      Flg.Set("FLAG_GIMMICK_T01_110")
      SetControlScriptExternalVariable("douger_state_4", "invisible")
      SetControlScriptExternalVariable("douger_move_state", "move_4")
    end
    if col_name == "evt_5000" then
    end
  elseif gMapNum == 104 then
    if col_name == "evt_1000" and Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0101_0140_0010")
      Field.MovePlayerToRelativePosFrame(1, 0, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_1001" and Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0101_0140_0010")
      Field.MovePlayerToRelativePosFrame(0, -1, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_1002" and Flg.Check("FLAG_MAIN_07_040", "FLAG_MAIN_07_053") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0101_0140_0010")
      Field.MovePlayerToRelativePosFrame(1, 0, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_2000" then
      M050:Event_040()
    end
    if col_name == "evt_3000" then
      require("S910_171")
      S910_171:Event_030()
    end
    if col_name == "evt_5000" then
      if Qst.Sub:Check(171, 10, 15) then
        require("S910_171")
        S910_171:Event_100()
      end
    elseif col_name == "evt_5001" then
      if Qst.Sub:Check(171, 10, 15) then
        require("S910_171")
        S910_171:Event_100()
      end
    elseif col_name == "evt_5002" then
      if Qst.Sub:Check(171, 10, 15) then
        require("S910_171")
        S910_171:Event_100()
      end
    elseif col_name == "evt_5003" then
      if Qst.Sub:Check(171, 10, 15) then
        require("S910_171")
        S910_171:Event_100()
      end
    elseif col_name == "evt_5004" then
      if Qst.Sub:Check(171, 10, 15) then
        require("S910_171")
        S910_171:Event_101()
      end
    elseif col_name == "evt_5005" then
      if Qst.Sub:Check(171, 10, 15) then
        require("S910_171")
        S910_171:Event_102()
      end
    elseif col_name == "evt_5006" and Qst.Sub:Check(171, 10, 15) then
      require("S910_171")
      S910_171:Event_103()
    end
  elseif gMapNum == 105 then
    if col_name == "evt_0001" and Flg.Check("FLAG_MAIN_03_010", "FLAG_MAIN_03_037") and not Common.CheckTimeAxis("A2020_dbef_51") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0105_0060_0010")
      tlk:Message("f_t0105_0060_0020")
      tlk:Message("f_t0105_0060_0030")
      tlk:Message("f_t0105_0060_0040")
      tlk:Message("f_t0105_0060_0050")
      tlk:Message("f_t0105_0060_0060")
      tlk:MessageClose()
      MovePlayerToRelativePosFrame(0, -1, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_2001" then
      if not Flg.Check("FLAG_MAIN_03_404") then
        local obj = Obj:new(NPC, "npc_blackshadow")
        obj:SetPos(36.29, -6.413, 232.227)
        obj:SetRotationY(90, 0)
        Flg.Set("FLAG_MAIN_03_404")
      end
    elseif col_name == "evt_2000" and not Flg.Check("FLAG_MAIN_03_405") then
      local obj = Obj:new(NPC, "npc_blackshadow")
      local bs_index = GetIndex(NPC, "npc_blackshadow")
      bs_pos = Field.ObjectGetPosition(NPC, bs_index)
      PlayEffectScript("ef_e_com_115", bs_pos.x, bs_pos.y + 1.5, bs_pos.z, 0, 1)
      PlaySE(300214, 100)
      obj:Invisible(10)
      Flg.Set("FLAG_MAIN_03_405")
    end
    if col_name == "evt_4002" then
      M110:Event_028()
    end
    if col_name == "evt_4000" or col_name == "evt_4003" then
      M110:Event_025()
    end
    if col_name == "evt_4001" or col_name == "evt_4004" then
      M110:Event_027()
    end
    if col_name == "evt_7000" then
      M210:Event_143()
    end
    if col_name == "evt_9000" then
      Prcs_t01_ThroughGate(180)
    elseif col_name == "evt_9001" then
      Prcs_t01_ThroughGate(0)
    elseif col_name == "evt_9002" then
      Prcs_t01_ThroughGate(270)
    elseif col_name == "evt_9003" then
      Prcs_t01_ThroughGate(90)
    elseif col_name == "evt_9004" then
      Prcs_t01_ThroughGate(90)
    elseif col_name == "evt_9005" then
      Prcs_t01_ThroughGate(270)
    end
    if col_name == "evt_9900" or col_name == "evt_9902" then
      MiniMapChange(1)
    elseif col_name == "evt_9901" or col_name == "evt_9903" then
      MiniMapChange(2)
    end
  elseif gMapNum == 107 then
    if col_name == "evt_0002" and Flg.Check("FLAG_MAIN_01_030", "FLAG_MAIN_01_060") then
      SetControlScriptExternalVariable("player_state", "fast")
    end
    if col_name ~= "evt_0003" or Flg.Check("FLAG_MAIN_01_030", "FLAG_MAIN_01_060") then
    end
    if col_name == "evt_0010" then
    end
    if col_name == "evt_0020" and Flg.Check("FLAG_MAIN_01_030", "FLAG_MAIN_01_060") then
      Flg.Set("FLAG_GIMMICK_T01_070")
    end
    if col_name == "evt_0021" and Flg.Check("FLAG_MAIN_01_030", "FLAG_MAIN_01_060") then
      ColOn("plan_cl_0001")
      RegularQuake_Stop()
      M010:Event_050()
      Flg.Clear("FLAG_GIMMICK_T01_070")
    end
  elseif gMapNum == 108 then
    if col_name == "evt_1000" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0008 = Obj:new(NPC, "npc_0008")
      local fn01_05 = Motion.Object:new(NPC, "npc_0008", "fn01_05")
      local e017 = Motion.Object:new(NPC, "npc_0008", "e017")
      local name = "npc_0008"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e017:Play(20, true)
      npc_0008:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0108_0080_0010")
      npc_0008:ResetExporession(10)
      fn01_05:Play(20, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_1001" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0007 = Obj:new(NPC, "npc_0007")
      local e030 = Motion.Object:new(NPC, "npc_0007", "e030")
      local e013 = Motion.Object:new(NPC, "npc_0007", "e013")
      local name = "npc_0007"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e013:Play(10, true)
      npc_0007:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0108_0070_0010")
      npc_0007:ResetExporession(10)
      e030:Play(20, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_1002" and not Flg.Check("FLAG_MAIN_01_250") then
      local npc_0009 = Obj:new(NPC, "npc_0009")
      local fn01_06 = Motion.Object:new(NPC, "npc_0009", "fn01_06")
      local e002 = Motion.Object:new(NPC, "npc_0009", "e002")
      local name = "npc_0009"
      local tlk = Tlk:new("t01")
      tlk:StartTalkAction(name)
      e002:Play(10, true)
      npc_0009:ChangeExpression("F01", EYE_BLINK, true, 10)
      tlk:Message("f_t0108_0090_0010")
      npc_0009:ResetExporession(10)
      fn01_06:Play(20, true)
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
    if col_name == "evt_2000" then
      M050:Event_050()
    end
  elseif gMapNum == 109 then
    if col_name ~= "evt_4000" or Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
    elseif Flg.Check("FLAG_S001_001") and not Flg.Check("FLAG_S001_002") then
      require("S010_001")
      S010_001:Event_025()
    end
    if col_name == "evt_5000" and Flg.Check("FLAG_MAIN_07_054") and not Flg.Check("FLAG_MAIN_07_055") then
      Execute("m210_020")
      M210:Event_020()
    end
    if col_name == "evt_1001" and Flg.Check("FLAG_MAIN_08_007", "FLAG_MAIN_08_020") then
      local tlk = Tlk:new("t01", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0101_0150_0010")
      Field.MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_2000" then
      if Flg.Check("FLAG_MAIN_08_007", "FLAG_MAIN_08_020") then
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0101_0150_0010")
        Field.MovePlayerToRelativePosFrame(1, 0, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
      if Qst.Sub:Check(169, 5, 255) then
        require("S910_169")
        S910_169:Event_100()
      elseif Qst.Sub:Check(171, 15, 20) then
        require("S910_171")
        S910_171:Event_110()
      end
    end
    if col_name == "evt_2002" then
      if Qst.Sub:Check(169, 5, 255) then
        require("S910_169")
        S910_169:Event_101()
      elseif Qst.Sub:Check(171, 15, 20) then
        require("S910_171")
        S910_171:Event_111()
      end
    end
    if col_name == "evt_2001" then
      require("S910_171")
      S910_171:Event_040()
    end
    if col_name == "evt_5001" then
      require("S910_169")
      S910_169:Event_060()
    end
  end
  if gMapNum == 121 then
    if col_name == "evt_0001" then
      if not Flg.Check("FLAG_MAIN_11_029") then
        Cam.Inst:Set(-11.51, -0.5, -17.85, -15.64, 2.39, -9.215, default, 1)
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0121_080_0010")
        Field.MovePlayerToRelativePosFrame(0, 1, 20)
        WaitFrame(20)
        tlk:EndTalk()
        Cam.Inst:Clear(1)
      elseif Flg.Check("FLAG_MAIN_11_050") then
        Cam.Inst:Set(-11.51, -0.5, -17.85, -15.64, 2.39, -9.215, default, 1)
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0121_080_0030")
        Field.MovePlayerToRelativePosFrame(0, 1, 20)
        WaitFrame(20)
        tlk:EndTalk()
        Cam.Inst:Clear(1)
      end
    elseif col_name == "evt_0002" then
      if not Flg.Check("FLAG_MAIN_11_029") then
        Cam.Inst:Set(11.51, 0.5, -17.85, 15.64, 2.39, -9.215, default, 1)
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0121_080_0010")
        Field.MovePlayerToRelativePosFrame(0, 1, 20)
        WaitFrame(20)
        tlk:EndTalk()
        Cam.Inst:Clear(1)
      elseif Flg.Check("FLAG_MAIN_11_050") then
        Cam.Inst:Set(11.51, 0.5, -17.85, 15.64, 2.39, -9.215, default, 1)
        local tlk = Tlk:new("t01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0121_080_0030")
        Field.MovePlayerToRelativePosFrame(0, 1, 20)
        WaitFrame(20)
        tlk:EndTalk()
        Cam.Inst:Clear(1)
      end
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 101 then
    if gim_name == "gim_0001" or gim_name == "gim_0002" then
      if Flg.Check("FLAG_SUB_200_149_010") then
        do
          local tlk = Tlk:new("t04", 1, true)
          tlk:StartTalk()
          tlk:Message("f_t0401_0050_0010")
          tlk:EndTalk()
        end
      else
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapAutoTransition(RW)
      end
    end
  elseif gMapNum == 102 then
    if gim_name == "shop_0001" then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_t0102_EnterCvs()
    end
    if gim_name == "gim_0002" or gim_name == "gim_0003" then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapAutoTransition(RW)
    end
  elseif gMapNum == 103 then
    if gim_name == "map_0001" then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    elseif gim_name == "map_0003" then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    end
  elseif gMapNum == 104 then
  elseif gMapNum == 105 then
    if gim_name == "gim_0001" then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_t0105_OpenPlatformDoor()
    end
  elseif gMapNum == 107 then
  elseif gMapNum == 108 then
    if gim_name == "gim_0002" or gim_name == "gim_0003" or gim_name == "gim_0004" then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapAutoTransition(RW)
    end
  elseif gMapNum == 109 then
    if gim_name == "map_0001" then
      PlayerLookAtLccatorObject(gim_name)
      if Qst.Sub:Check(169, 5, 255) then
        require("S910_169")
        S910_169:Event_102()
        goto lbl_163
      elseif Qst.Sub:Check(171, 15, 20) then
        require("S910_171")
        S910_171:Event_112()
        goto lbl_163
      end
      OpenWorldMapDirection()
    end
    ::lbl_163::
    if gim_name == "change_0001" then
      if Qst.Sub:Check(169, 5, 255) then
        require("S910_169")
        S910_169:Event_102()
        goto lbl_212
      elseif Qst.Sub:Check(171, 15, 20) then
        require("S910_171")
        S910_171:Event_112()
        goto lbl_212
      end
      require("fld_common_gate_in")
      fld_common_gate_in(gim_loc)
      MapChange("h", 202, "start_00", false, -1, -1)
    end
    ::lbl_212::
    if gim_name == "change_0002" then
      if Qst.Sub:Check(171, 15, 20) then
        require("S910_171")
        S910_171:Event_112()
      else
        PlayerLookAtLccatorObject(gim_name)
        Prcs_t0109_EnterCulvert()
      end
    end
    if gim_name == "gim_0010" then
      if Qst.Sub:Check(169, 5, 255) then
        require("S910_169")
        S910_169:Event_102()
        goto lbl_276
      elseif Qst.Sub:Check(171, 15, 20) then
        require("S910_171")
        S910_171:Event_112()
        goto lbl_276
      end
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapAutoTransition(RW)
    end
    ::lbl_276::
    if gim_name == "theater_0001" then
      if Qst.Sub:Check(169, 5, 255) then
        require("S910_169")
        S910_169:Event_102()
        goto lbl_313
      elseif Qst.Sub:Check(171, 15, 20) then
        require("S910_171")
        S910_171:Event_112()
        goto lbl_313
      end
      GoToTheaterWithEvt()
    end
  end
  ::lbl_313::
  if gMapNum == 110 and gim_name == "map_0001" then
    if not Flg.Check("AREA_OPEN_AKIHABARA") then
      Map:OpenArea(2, true)
      Map:OpenPlace(201, true)
      M100:Event_045()
      MapChange("t", 201, "start_00", true, FADE_BLACK, FADE_TIME)
    end
    PlayerLookAtLccatorObject(gim_name)
    OpenWorldMapDirection()
  end
  if gMapNum == 121 and gim_name == "theater_0001" then
    GoToTheaterWithEvt()
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 101 then
    if gim_name == "s200_149_item_01" then
      require("S200_149")
      S200_149:Event_030()
    end
    if gim_name == "s200_149_start" then
      require("S200_149")
      S200_149:Event_001()
    end
  end
  if gMapNum == 102 then
  end
  if gMapNum == 105 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 106 then
    if gim_name == "s010_179_toilet" then
      require("S010_179")
      S010_179:Event_020()
    end
  elseif gMapNum == 107 then
    if gim_name == "s010_156_start" then
      require("S010_156")
      S010_156:Event_030()
    end
  elseif gMapNum == 109 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
    if gim_name == "gate_s910_169" then
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      GoToOuterGimmickObj("gate_s910_169", 1.5, 0)
      MapChange("h", 415, "start_00", true, FADE_BLACK, FADE_TIME)
    end
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
  if gMapNum == 101 then
  end
  if gim_tag == "fa_sub201" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
    require("Sow_201")
    if gMapNum == 101 then
      SeekEtemon_T0101(gim_name)
    elseif gMapNum == 102 then
      SeekEtemon_T0102(gim_name)
    elseif gMapNum == 104 then
      SeekEtemon_T0104(gim_name)
    elseif gMapNum == 105 then
      SeekEtemon_T0105(gim_name)
    elseif gMapNum == 106 then
      SeekEtemon_T0106(gim_name)
    elseif gMapNum == 108 then
      SeekEtemon_T0108(gim_name)
    elseif gMapNum == 109 then
      SeekEtemon_T0109(gim_name)
    elseif gMapNum == 110 then
      SeekEtemon_T0110(gim_name)
    elseif gMapNum == 111 then
      SeekEtemon_T0111(gim_name)
    end
  end
end
