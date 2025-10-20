gGimText = "field_text"
BRK1101 = {
  obj1 = {
    loc = "fa_0001",
    col = "plan_cl_2000",
    text = "g_d1101_0050_0010",
    flag = "FLAG_GIMMICK_D11_030",
    se = 202001
  }
}

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 1101 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_2000",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    Field.LoadEffectScript("ef_f_mov_122_ga", 5)
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
  elseif load_map_num == 1102 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
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
  elseif load_map_num == 1103 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001"}
    })
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
    AddLoadList(FLD_OBJ_GIMMICK, {
      "barrierdevice_access04",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_GIMMICK, {
      "barrierdevice_access05",
      motion = {"e001"}
    })
  elseif load_map_num == 1104 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d11_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 1101 then
    if not Flg.Check("FLAG_GIMMICK_D11_020") then
      ColOff("plan_cl_0001")
      ColOff("plan_cl_0002")
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOff("wall_cl_0009")
    else
      Motion.Gimmick:Play("gim_0002", "e001", false)
      Motion.Gimmick:ResetFrame("gim_0002", "e001", 240, 240, 240, false)
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOff("wall_cl_0009")
    end
    if not Flg.Check("FLAG_GIMMICK_D11_237") then
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):Invisible()
    elseif Flg.Check("FLAG_GIMMICK_D11_237") and not Flg.Check("FLAG_GIMMICK_D11_030") then
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):CancelInvisible()
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "", false)
      ColOn("wall_cl_0009")
    elseif Flg.Check("FLAG_GIMMICK_D11_230") and not Flg.Check("FLAG_GIMMICK_D11_080") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "", false)
      ColOn("wall_cl_0009")
    else
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):Invisible()
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOff("wall_cl_0009")
    end
    if Flg.Check("FLAG_GIMMICK_D11_080") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOff("wall_cl_0009")
    end
    if Flg.Check("FLAG_GIMMICK_D11_020") then
      Obj:new(FLD_OBJ_LOCATOR, "gim_0005"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):Invisible()
    end
    if Flg.Check("FLAG_FIELD_D11_014") then
      ColOff("evt_1009")
    end
    if not Flg.Check("FLAG_FIELD_D11_010") then
      SetControlScriptExternalVariable("elecmon_state", "initialize")
      SetControlScriptExternalVariable("elecmon_pos", "0")
    end
    if Field.IsUsingStoredField() == false then
      if not Flg.Check("FLAG_FIELD_D11_010") then
        SetControlScriptExternalVariable("elecmon_state", "initialize")
        SetControlScriptExternalVariable("elecmon_pos", "0")
      elseif Flg.Check("FLAG_FIELD_D11_014") then
        Obj:new(NPC, "npc_elecmon"):SetPos(135.771, -3.896, 18, true)
        Obj:new(NPC, "npc_elecmon"):Invisible()
      elseif Flg.Check("FLAG_FIELD_D11_022") then
        SetControlScriptExternalVariable("elecmon_state", "relocation4")
      elseif Flg.Check("FLAG_FIELD_D11_013") then
        SetControlScriptExternalVariable("elecmon_state", "relocation13")
      elseif Flg.Check("FLAG_GIMMICK_D11_220") then
        SetControlScriptExternalVariable("elecmon_state", "relocation20")
      elseif Flg.Check("FLAG_GIMMICK_D11_221") then
        SetControlScriptExternalVariable("elecmon_state", "relocation21")
      elseif Flg.Check("FLAG_GIMMICK_D11_223") then
        SetControlScriptExternalVariable("elecmon_state", "relocation23")
      elseif Flg.Check("FLAG_GIMMICK_D11_224") then
        SetControlScriptExternalVariable("elecmon_state", "relocation24")
      elseif Flg.Check("FLAG_FIELD_D11_012") then
        SetControlScriptExternalVariable("elecmon_state", "relocation3")
      elseif Flg.Check("FLAG_FIELD_D11_020") then
        SetControlScriptExternalVariable("elecmon_state", "relocation11")
      elseif Flg.Check("FLAG_FIELD_D11_021") then
        SetControlScriptExternalVariable("elecmon_state", "relocation10")
      elseif Flg.Check("FLAG_FIELD_D11_019") then
        SetControlScriptExternalVariable("elecmon_state", "relocation9")
      elseif Flg.Check("FLAG_FIELD_D11_018") then
        SetControlScriptExternalVariable("elecmon_state", "relocation8")
      elseif Flg.Check("FLAG_FIELD_D11_017") then
        SetControlScriptExternalVariable("elecmon_state", "relocation7")
      elseif Flg.Check("FLAG_GIMMICK_D11_060") then
        SetControlScriptExternalVariable("elecmon_state", "relocation6")
      elseif Flg.Check("FLAG_FIELD_D11_016") then
        SetControlScriptExternalVariable("elecmon_state", "relocation5")
      elseif Flg.Check("FLAG_FIELD_D11_015") then
        SetControlScriptExternalVariable("elecmon_state", "relocation2")
      elseif Flg.Check("FLAG_FIELD_D11_011") then
        SetControlScriptExternalVariable("elecmon_state", "relocation1")
      elseif Flg.Check("FLAG_FIELD_D11_010") then
        SetControlScriptExternalVariable("elecmon_state", "relocation0")
      end
    end
    SetControlScriptExternalVariable("elc_state", "off")
    SetControlScriptExternalVariable("chase_count", 0)
    for key in pairs(BRK1101) do
      if Flg.Check(BRK1101[key].flag) then
        Obj:new(FLD_OBJ_LOCATOR, BRK1101[key].loc):Invisible()
        ColOff(BRK1101[key].col)
      end
    end
    if not Flg.Check("FLAG_S001_000") then
      Obj:new(NPC, "npc_0601"):Invisible()
    end
    if not Flg.Check("FLAG_MAIN_03_390") then
      ColOff("wall_cl_0010")
    end
    if Common.CheckTimeAxis("A2020_dbef_119") then
      ColOff("wall_cl_0010")
    end
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      if Flg.Check("FLAG_GIMMICK_D11_231") then
        Motion.Gimmick:PlayFinishedAnim("obj_2000", "e001")
        ColOff("wall_cl_0008")
        Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):Invisible()
        Obj:new(FLD_OBJ_GIMMICK, "panel_access01"):CancelInvisible()
        Motion.Gimmick:Play("gim_0002", "e002", false)
        Motion.Gimmick:ResetFrame("gim_0002", "e002", 240, 240, 240, false)
        ColOff("plan_cl_0001")
        ColOff("plan_cl_0002")
      else
        Motion.Gimmick:Play("gim_0002", "e001", false)
        Motion.Gimmick:ResetFrame("gim_0002", "e001", 240, 240, 240, false)
        Motion.Gimmick:PlayFinishedAnim("obj_2000", "")
        ColOn("wall_cl_0008")
        Obj:new(FLD_OBJ_GIMMICK, "panel_access01"):Invisible()
      end
      if Flg.Check("FLAG_GIMMICK_D11_233") then
        Field.ObjectInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "shutter_access01"), 0, 0, false)
        Field.ObjectInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "duct_access01"), 0, 0, false)
      end
      if Flg.Check("FLAG_GIMMICK_D11_232") then
        Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
        ColOff("wall_cl_0009")
        Field.ObjectInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "panel_access01"), 0, 0, false)
      else
        Motion.Gimmick:PlayFinishedAnim("obj_0001", "")
        ColOn("wall_cl_0009")
      end
      if Flg.Check("FLAG_MAIN_07_070B") then
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "")
      else
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "e001")
      end
    end
    if not Flg.Check("FLAG_MAIN_07_057") then
      Obj:new(NPC, "npc_0709"):Invisible()
      Obj:new(NPC, "blacktail_002"):Invisible()
    end
  elseif gMapNum == 1102 then
    local start_loc = GetLastPlayerSetLocator()
    if Flg.Check("FLAG_GIMMICK_D11_040") then
      ColOff("plan_cl_0001")
      ColOff("wall_cl_0003")
    end
    if not Flg.Check("FLAG_MAIN_03_320") then
      ColOff("evt_2000")
      ColOff("evt_2001")
      ColOff("evt_2002")
      ColOff("evt_2003")
    end
    if Flg.Check("FLAG_MAIN_07_030") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOff("wall_cl_0001")
    else
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "")
    end
    if Common.CheckTimeAxis("A2020_dbef_119") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "")
      ColOn("wall_cl_0001")
    end
    if Flg.Check("FLAG_MAIN_03_182") and not Flg.Check("FLAG_MAIN_03_210") then
      local index = GetIndex(FLD_OBJ_LOCATOR, "obj_0002")
      Field.ObjectPlayMotionAndSetting(FLD_OBJ_LOCATOR, index, "e001", 0, 9, 9, 9, 1, false)
      ColOn("wall_cl_0002")
    elseif Flg.Check("FLAG_MAIN_03_182") and Flg.Check("FLAG_MAIN_03_210") then
      Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001")
      ColOff("wall_cl_0002")
    end
    if Flg.Check("FLAG_MAIN_02_025", "FLAG_MAIN_02_070") then
      Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001")
      ColOff("wall_cl_0002")
    end
    if Flg.Check("FLAG_MAIN_03_191") then
      SetEnableGimmickCheck("obj_0002", false)
    end
    if Flg.Check("FLAG_MAIN_03_192") then
      if not Flg.Check("FLAG_MAIN_03_193") then
        SetEnableGimmickCheck("obj_1001", true)
        Obj:new(FLD_OBJ_LOCATOR, "obj_1001"):CancelInvisible()
      else
      end
    else
      SetEnableGimmickCheck("obj_1001", false)
      Obj:new(FLD_OBJ_LOCATOR, "obj_1001"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_03_193") then
      if not Flg.Check("FLAG_MAIN_03_194") then
        SetEnableGimmickCheck("obj_1002", true)
        Obj:new(FLD_OBJ_LOCATOR, "obj_1002"):CancelInvisible()
      else
        Obj:new(FLD_OBJ_LOCATOR, "obj_1002"):Invisible()
      end
    else
      SetEnableGimmickCheck("obj_1002", false)
      Obj:new(FLD_OBJ_LOCATOR, "obj_1002"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_03_194") then
      if not Flg.Check("FLAG_MAIN_03_195") then
        SetEnableGimmickCheck("obj_1003", true)
        Obj:new(FLD_OBJ_LOCATOR, "obj_1003"):CancelInvisible()
      else
        Obj:new(FLD_OBJ_LOCATOR, "obj_1003"):Invisible()
      end
    else
      SetEnableGimmickCheck("obj_1003", false)
      Obj:new(FLD_OBJ_LOCATOR, "obj_1003"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_03_192") and not Flg.Check("FLAG_MAIN_03_210") then
      ColOff("plan_cl_0002")
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):CancelInvisible()
    elseif Flg.Check("FLAG_MAIN_03_192") and Flg.Check("FLAG_MAIN_03_210") then
      ColOff("plan_cl_0002")
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):Invisible()
    else
      ColOn("plan_cl_0002")
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):Invisible()
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
    end
  elseif gMapNum == 1103 then
    if Flg.Check("FLAG_GIMMICK_D11_110") then
      SetEnableGimmickCheck("gim_0002", false)
      ColOff("wall_cl_0002")
      Motion.Gimmick:PlayFinishedAnim("gim_0002", "e001")
    end
    if Flg.Check("FLAG_MAIN_01_010") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      Motion.Gimmick:PlayFinishedAnim("gim_0003", "e001")
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e001")
    end
    if Common.CheckTimeAxis("A2020_dbef_119") then
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e001")
      ColOn("wall_cl_0006")
    elseif Flg.Check("FLAG_MAIN_03_400") then
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "")
      ColOff("wall_cl_0006")
    end
    if Flg.Check("FLAG_MAIN_03_425") then
      local wall = Obj:new(FLD_OBJ_LOCATOR, "obj_0001")
      wall:Invisible()
      SetEnableGimmickCheck("gim_0001", false)
      ColOff("wall_cl_0001")
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(false)
    else
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOn("wall_cl_0001")
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):CancelInvisible()
      if Flg.Check("FLAG_MAIN_03_422") then
        Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(true)
      else
        Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(false)
      end
    end
    if Common.CheckTimeAxis("A2020_dbef_119") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0001"):CancelInvisible()
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOn("wall_cl_0001")
      SetEnableGimmickCheck("gim_0001", false)
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(false)
    end
    if not Flg.Check("FLAG_FIELD_D11_BSStart") then
      SetControlScriptExternalVariable("shadow_state", "initialize")
      SetControlScriptExternalVariable("shadow_pos", "0")
    end
    if Field.IsUsingStoredField() == false then
      if Flg.Check("FLAG_FIELD_D11_BSStart") then
        SetControlScriptExternalVariable("shadow_state", "relocation2")
        SetControlScriptExternalVariable("shadow_pos", "2")
      end
      if Flg.Check("FLAG_FIELD_D11_BS01") then
        SetControlScriptExternalVariable("shadow_state", "relocation2")
        SetControlScriptExternalVariable("shadow_pos", "2")
      end
      if Flg.Check("FLAG_FIELD_D11_BS02") then
        SetControlScriptExternalVariable("shadow_state", "relocation3")
        SetControlScriptExternalVariable("shadow_pos", "3")
      end
      if Flg.Check("FLAG_FIELD_D11_BSEnd") then
        SetControlScriptExternalVariable("shadow_state", "end")
        SetControlScriptExternalVariable("shadow_pos", "0")
        Obj:new(NPC, "npc_blackshadow"):Invisible()
      end
    end
    if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      local wall = Obj:new(FLD_OBJ_LOCATOR, "gim_0003")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      wall:Invisible()
      ColOff("wall_cl_0007")
      if Flg.Check("FLAG_MAIN_07_070B") then
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access04"), 0, "")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access05"), 0, "")
      else
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access01"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access02"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access03"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access04"), 0, "e001")
        Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "barrierdevice_access05"), 0, "e001")
      end
    end
  elseif gMapNum == 1104 then
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 1101 then
    if col_name == "evt_4000" then
      M210:Event_050()
    end
    if Flg.Check("FLAG_MAIN_03_060", "FLAG_FIELD_D11_014") and not Flg.Check("FLAG_MAIN_03_100") then
      local base_num = "200"
      for num = 2, 9 do
        local num_str = tostring(num)
        local col_num = "evt_" .. base_num .. num_str
        if col_name == col_num then
          local elc_state = GetControlScriptExternalVariableString("elc_state")
          if elc_state == "on" then
            M060:Event_060()
            SetControlScriptExternalVariable("elc_state", "off")
            SetControlScriptExternalVariable("chase_count", 0)
          end
        end
      end
    end
    if Flg.Check("FLAG_FIELD_D11_014") and col_name == "evt_1009" then
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1101_0090_0010")
      tlk:EndTalk()
      ColOff("evt_1009")
    end
    if Flg.Check("FLAG_MAIN_03_060") and not Flg.Check("FLAG_FIELD_D11_014") then
      local elecmon_state = GetControlScriptExternalVariableString("elecmon_state")
      local elecmon_pos = GetControlScriptExternalVariableString("elecmon_pos")
      if col_name == "evt_1009" and not Flg.Check("FLAG_FIELD_D11_013") then
        local tlk = Tlk:new("d11", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1101_0010_0020")
        tlk:EndTalk()
        MovePlayerToRelativePosFrame(-1, 0, 20)
        WaitFrame(20)
      end
      if col_name == "evt_1010" then
        if not Flg.Check("FLAG_FIELD_D11_010") then
          Cam.Inst:Set(-85.624, 3, -5.373, -85.624, 5, -20.373, default, 30)
          WaitFrame(45)
          local tlk = Tlk:new("d11", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d1101_0010_0010")
          tlk:EndTalk()
          Cam.Inst:Clear(30)
          MovePlayerToRelativePosFrame(-1, 0, 20)
          WaitFrame(20)
        elseif not Flg.Check("FLAG_FIELD_D11_016") then
          local tlk = Tlk:new("d11", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d1101_0010_0010")
          tlk:EndTalk()
          MovePlayerToRelativePosFrame(-1, 0, 20)
          WaitFrame(20)
        end
      end
      if col_name == "evt_3000" then
        if elecmon_state == "initialize" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to1")
          SetControlScriptExternalVariable("elecmon_pos", "1")
          Flg.Set("FLAG_FIELD_D11_010")
        elseif elecmon_state == "standby0" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to1")
          SetControlScriptExternalVariable("elecmon_pos", "1")
          Flg.Set("FLAG_FIELD_D11_010")
        end
      elseif col_name == "evt_3002" then
        if elecmon_pos == "1" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to2")
          SetControlScriptExternalVariable("elecmon_pos", "2")
          Flg.Set("FLAG_FIELD_D11_011")
        elseif elecmon_state == "standby1" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to2")
          SetControlScriptExternalVariable("elecmon_pos", "2")
          Flg.Set("FLAG_FIELD_D11_011")
        end
      elseif col_name == "evt_3001" then
        if elecmon_pos == "2" then
          Flg.Set("FLAG_FIELD_D11_015")
          SetControlScriptExternalVariable("elecmon_state", "escape_to3")
          SetControlScriptExternalVariable("elecmon_pos", "3")
        elseif elecmon_state == "standby1" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to3")
          SetControlScriptExternalVariable("elecmon_pos", "3")
          Flg.Set("FLAG_FIELD_D11_015")
        end
      elseif col_name == "evt_3003" then
        if elecmon_pos == "3" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to4")
          SetControlScriptExternalVariable("elecmon_pos", "6")
          Flg.Set("FLAG_FIELD_D11_016")
          local tlk = Tlk:new("d11", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d1101_0060_0010")
          tlk:EndTalk()
        elseif elecmon_state == "standby2" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to4")
          SetControlScriptExternalVariable("elecmon_pos", "6")
          Flg.Set("FLAG_FIELD_D11_016")
          local tlk = Tlk:new("d11", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d1101_0060_0010")
          tlk:EndTalk()
        end
      elseif col_name == "evt_3004" then
        if elecmon_pos == "8" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to9")
          SetControlScriptExternalVariable("elecmon_pos", "9")
          Flg.Set("FLAG_FIELD_D11_017")
        elseif elecmon_state == "standby6" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to9")
          SetControlScriptExternalVariable("elecmon_pos", "9")
          Flg.Set("FLAG_FIELD_D11_017")
        end
      elseif col_name == "evt_3005" then
        if elecmon_pos == "9" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to10")
          SetControlScriptExternalVariable("elecmon_pos", "10")
          Flg.Set("FLAG_FIELD_D11_018")
        elseif elecmon_state == "standby7" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to10")
          SetControlScriptExternalVariable("elecmon_pos", "10")
          Flg.Set("FLAG_FIELD_D11_018")
        end
      elseif col_name == "evt_3006" then
        if elecmon_pos == "10" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to11")
          SetControlScriptExternalVariable("elecmon_pos", "11")
          Flg.Set("FLAG_FIELD_D11_019")
          CheckSymbolEnemySet("FLAG_FIELD_D11_019", false)
        elseif elecmon_state == "standby8" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to11")
          SetControlScriptExternalVariable("elecmon_pos", "11")
          Flg.Set("FLAG_FIELD_D11_019")
          CheckSymbolEnemySet("FLAG_FIELD_D11_019", false)
        end
      elseif col_name == "evt_3017" then
        if elecmon_pos == "11" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to11_2")
          SetControlScriptExternalVariable("elecmon_pos", "11_2")
          Flg.Set("FLAG_FIELD_D11_021")
        elseif elecmon_state == "standby9" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to11_2")
          SetControlScriptExternalVariable("elecmon_pos", "11_2")
          Flg.Set("FLAG_FIELD_D11_021")
        end
      elseif col_name == "evt_3007" then
        if elecmon_pos == "11_2" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to12")
          SetControlScriptExternalVariable("elecmon_pos", "12")
          Flg.Set("FLAG_FIELD_D11_020")
          CheckSymbolEnemySet("FLAG_FIELD_D11_020", false)
          Flg.Set("FLAG_FIELD_D11_012")
        elseif elecmon_state == "standby10" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to12")
          SetControlScriptExternalVariable("elecmon_pos", "12")
          Flg.Set("FLAG_FIELD_D11_020")
          CheckSymbolEnemySet("FLAG_FIELD_D11_020", false)
          Flg.Set("FLAG_FIELD_D11_012")
        end
      elseif col_name == "evt_3008" then
        if not Flg.Check("FLAG_GIMMICK_D11_030") and not Flg.Check("FLAG_GIMMICK_D11_237") then
          Prcs_d1101_DoorClose_elec()
        end
      elseif col_name == "evt_3009" then
        if Flg.Check("FLAG_GIMMICK_D11_030") then
          if elecmon_pos == "12" then
            SetControlScriptExternalVariable("elecmon_state", "escape_to110")
            SetControlScriptExternalVariable("elecmon_pos", "110")
            Flg.Clear("FLAG_GIMMICK_D11_220")
            Flg.Set("FLAG_GIMMICK_D11_221")
            Flg.Clear("FLAG_GIMMICK_D11_222")
            Flg.Clear("FLAG_GIMMICK_D11_223")
            Flg.Clear("FLAG_GIMMICK_D11_224")
          elseif elecmon_state == "standby3" then
            SetControlScriptExternalVariable("elecmon_state", "escape_to110")
            SetControlScriptExternalVariable("elecmon_pos", "110")
            Flg.Clear("FLAG_GIMMICK_D11_220")
            Flg.Set("FLAG_GIMMICK_D11_221")
            Flg.Clear("FLAG_GIMMICK_D11_222")
            Flg.Clear("FLAG_GIMMICK_D11_223")
            Flg.Clear("FLAG_GIMMICK_D11_224")
          end
        end
      elseif col_name == "evt_3015" or col_name == "evt_3016" then
        if not Flg.Check("FLAG_GIMMICK_D11_230") then
          Prcs_d1101_DoorClose()
          Flg.Set("FLAG_GIMMICK_D11_230")
        end
      elseif col_name == "evt_2006" then
        if elecmon_pos == "140" or elecmon_pos == "360" or elecmon_state == "standby20" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to110")
          SetControlScriptExternalVariable("elecmon_pos", "110")
          Prcs_d1101_ChaseCounter()
          Flg.Clear("FLAG_GIMMICK_D11_220")
          Flg.Set("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        elseif elecmon_pos == "300" or elecmon_state == "standby24" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to350")
          SetControlScriptExternalVariable("elecmon_pos", "130")
          Prcs_d1101_ChaseCounter()
          Flg.Clear("FLAG_GIMMICK_D11_220")
          Flg.Clear("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Set("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        end
      elseif col_name == "evt_2005" then
        if not Flg.Check("FLAG_GIMMICK_D11_020") then
          if elecmon_pos == "140" or elecmon_pos == "360" or elecmon_state == "standby20" then
            SetControlScriptExternalVariable("elecmon_state", "escape_to180")
            SetControlScriptExternalVariable("elecmon_pos", "130")
            Prcs_d1101_ChaseCounter()
            Flg.Clear("FLAG_GIMMICK_D11_220")
            Flg.Clear("FLAG_GIMMICK_D11_221")
            Flg.Clear("FLAG_GIMMICK_D11_222")
            Flg.Set("FLAG_GIMMICK_D11_223")
            Flg.Clear("FLAG_GIMMICK_D11_224")
          end
        elseif not Flg.Check("FLAG_GIMMICK_D11_080") then
          HideMinimap(true)
          HideGuide(true)
          local tlk = Tlk:new("d11", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d1101_0080_0010")
          tlk:EndTalk(true)
          Prcs_d1101_Elecmon_RunAway_Evt()
          SetControlScriptExternalVariable("elecmon_state", "escape_to19")
          SetControlScriptExternalVariable("elecmon_pos", "19")
          Flg.Set("FLAG_FIELD_D11_013")
          Flg.Clear("FLAG_GIMMICK_D11_220")
          Flg.Clear("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
          local tlk = Tlk:new("d11", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d1101_0080_0020")
          WaitFrame(5)
          tlk:EndTalk()
          HideMinimap(false)
          HideGuide(false)
          Digitter.Send(1060080040)
        end
      elseif col_name == "evt_2004" then
        if elecmon_pos == "110" or elecmon_state == "standby21" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to120")
          SetControlScriptExternalVariable("elecmon_pos", "130")
          Prcs_d1101_ChaseCounter()
          Flg.Clear("FLAG_GIMMICK_D11_220")
          Flg.Clear("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Set("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        elseif (elecmon_pos == "140" or elecmon_state == "standby21") and Flg.Check("FLAG_GIMMICK_D11_020") then
          SetControlScriptExternalVariable("elecmon_state", "escape_to360")
          SetControlScriptExternalVariable("elecmon_pos", "360")
          Flg.Clear("FLAG_GIMMICK_D11_220")
          Flg.Clear("FLAG_GIMMICK_D11_221")
          Flg.Set("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        end
      elseif col_name == "evt_2003" then
        if elecmon_pos == "110" or elecmon_state == "standby21" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to150")
          SetControlScriptExternalVariable("elecmon_pos", "140")
          Prcs_d1101_ChaseCounter()
          Flg.Set("FLAG_GIMMICK_D11_220")
          Flg.Clear("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        end
      elseif col_name == "evt_2002" then
        if elecmon_pos == "120" then
        end
      elseif col_name == "evt_2009" then
        if elecmon_pos == "120" then
        end
      elseif col_name == "evt_2008" then
        if elecmon_pos == "130" or elecmon_state == "standby23" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to140")
          SetControlScriptExternalVariable("elecmon_pos", "140")
          Prcs_d1101_ChaseCounter()
          Flg.Set("FLAG_GIMMICK_D11_220")
          Flg.Clear("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        end
      elseif col_name == "evt_2007" then
        if elecmon_pos == "130" or elecmon_state == "standby23" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to170")
          SetControlScriptExternalVariable("elecmon_pos", "110")
          Prcs_d1101_ChaseCounter()
          Flg.Clear("FLAG_GIMMICK_D11_220")
          Flg.Set("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        elseif elecmon_pos == "300" or elecmon_state == "standby24" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to340")
          SetControlScriptExternalVariable("elecmon_pos", "140")
          Prcs_d1101_ChaseCounter()
          Flg.Set("FLAG_GIMMICK_D11_220")
          Flg.Clear("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        end
      elseif col_name == "evt_3013" then
        if not Flg.Check("FLAG_GIMMICK_D11_020") then
          if elecmon_pos == "120" then
            SetControlScriptExternalVariable("elecmon_state", "escape_to320")
            SetControlScriptExternalVariable("elecmon_pos", "300")
            Flg.Clear("FLAG_GIMMICK_D11_220")
            Flg.Clear("FLAG_GIMMICK_D11_221")
            Flg.Clear("FLAG_GIMMICK_D11_222")
            Flg.Clear("FLAG_GIMMICK_D11_223")
            Flg.Set("FLAG_GIMMICK_D11_224")
          elseif elecmon_pos == "130" or elecmon_state == "standby23" then
            SetControlScriptExternalVariable("elecmon_state", "escape_to330")
            SetControlScriptExternalVariable("elecmon_pos", "300")
            Flg.Clear("FLAG_GIMMICK_D11_220")
            Flg.Clear("FLAG_GIMMICK_D11_221")
            Flg.Clear("FLAG_GIMMICK_D11_222")
            Flg.Clear("FLAG_GIMMICK_D11_223")
            Flg.Set("FLAG_GIMMICK_D11_224")
          elseif elecmon_pos == "110" or elecmon_state == "standby21" then
            SetControlScriptExternalVariable("elecmon_state", "escape_to300")
            SetControlScriptExternalVariable("elecmon_pos", "300")
            Flg.Clear("FLAG_GIMMICK_D11_220")
            Flg.Clear("FLAG_GIMMICK_D11_221")
            Flg.Clear("FLAG_GIMMICK_D11_222")
            Flg.Clear("FLAG_GIMMICK_D11_223")
            Flg.Set("FLAG_GIMMICK_D11_224")
          end
        end
      elseif col_name == "evt_3014" then
        if not Flg.Check("FLAG_GIMMICK_D11_020") then
          if elecmon_pos == "140" or elecmon_state == "standby20" then
            SetControlScriptExternalVariable("elecmon_state", "escape_to310")
            SetControlScriptExternalVariable("elecmon_pos", "300")
            Flg.Clear("FLAG_GIMMICK_D11_220")
            Flg.Clear("FLAG_GIMMICK_D11_221")
            Flg.Clear("FLAG_GIMMICK_D11_222")
            Flg.Clear("FLAG_GIMMICK_D11_223")
            Flg.Set("FLAG_GIMMICK_D11_224")
          end
        elseif elecmon_pos == "130" or elecmon_state == "standby23" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to401")
          SetControlScriptExternalVariable("elecmon_pos", "110")
          Flg.Clear("FLAG_GIMMICK_D11_220")
          Flg.Set("FLAG_GIMMICK_D11_221")
          Flg.Clear("FLAG_GIMMICK_D11_222")
          Flg.Clear("FLAG_GIMMICK_D11_223")
          Flg.Clear("FLAG_GIMMICK_D11_224")
        end
      elseif col_name == "evt_3010" then
        if elecmon_pos == "19" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to20")
          SetControlScriptExternalVariable("elecmon_pos", "20")
          Flg.Set("FLAG_FIELD_D11_022")
        elseif elecmon_state == "standby13" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to20")
          SetControlScriptExternalVariable("elecmon_pos", "20")
          Flg.Set("FLAG_FIELD_D11_022")
        end
      elseif col_name == "evt_3011" then
        if elecmon_state == "standby4" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to21")
          SetControlScriptExternalVariable("elecmon_pos", "21")
          Flg.Set("FLAG_FIELD_D11_014")
        end
      elseif col_name == "evt_3012" then
        if elecmon_pos == "20" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to21")
          SetControlScriptExternalVariable("elecmon_pos", "21")
          Flg.Set("FLAG_FIELD_D11_014")
        elseif elecmon_state == "standby4" then
          SetControlScriptExternalVariable("elecmon_state", "escape_to21")
          SetControlScriptExternalVariable("elecmon_pos", "21")
          Flg.Set("FLAG_FIELD_D11_014")
        end
      end
    end
    if col_name == "evt_5000" and not Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
      require("S010_001")
      S010_001:Event_030()
    end
    if col_name == "evt_6000" and Flg.Check("FLAG_MAIN_07_058", "FLAG_MAIN_07_063") then
      M210:Event_080()
    end
  elseif gMapNum == 1102 then
    if col_name == "evt_1005" then
    end
    if col_name == "evt_1001" then
      M040:Event_070()
    end
    if col_name == "evt_1002" then
      Motion.Gimmick:Play("gim_0001", "e001", false)
      ColOff("wall_cl_0001")
    end
    if col_name == "evt_1003" and Flg.Check("FLAG_MAIN_03_180") and not Flg.Check("FLAG_MAIN_03_210") then
      local tlk = Tlk:new("t04", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_t0401_0050_0010")
      tlk:MessageClose()
      MovePlayerToRelativePosFrame(-2, 0, 30)
      WaitFrame(30)
      tlk:EndTalk()
    end
    if col_name == "evt_1005" then
      M040:Event_060()
    end
    if col_name == "evt_1006" and not Flg.Check("FLAG_MAIN_02_060") then
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1102_0030_0010")
      tlk:EndTalk()
      MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
    end
    if col_name == "evt_2004" then
    end
    if col_name == "evt_3000" and Flg.Check("FLAG_MAIN_03_192") and not Flg.Check("FLAG_MAIN_03_194") then
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1102_0080_0010")
      tlk:EndTalk()
      MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
    end
    if col_name == "evt_5000" then
    end
    if col_name == "evt_5001" then
    end
    if col_name == "evt_7000" then
    end
    if col_name == "evt_7001" then
    end
    if col_name == "evt_7002" then
    end
    if col_name == "evt_7003" then
    end
  elseif gMapNum == 1103 then
    if col_name == "evt_2001" or col_name == "evt_2005" then
      M060:Event_090()
    end
    if col_name == "evt_2002" then
      M060:Event_100()
    end
    if col_name == "evt_2003" then
      M060:Event_110()
    end
    if col_name == "evt_2004" and Flg.Check("FLAG_MAIN_03_090", "FLAG_MAIN_03_100") then
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1103_0010_0010")
      tlk:EndTalk()
      Field.MovePlayerToRelativePosFrame(0, 2, 15)
      WaitFrame(20)
    end
    if Flg.Check("FLAG_MAIN_03_400") and not Flg.Check("FLAG_FIELD_D11_BSEnd") then
      local shadow_state = GetControlScriptExternalVariableString("shadow_state")
      local shadow_pos = GetControlScriptExternalVariableString("shadow_pos")
      if col_name == "evt_4000" then
        if shadow_state == "initialize" then
          SetControlScriptExternalVariable("shadow_state", "move_to1")
          SetControlScriptExternalVariable("shadow_pos", "1")
          Flg.Set("FLAG_FIELD_D11_BSStart")
        end
      elseif col_name == "evt_4001" then
        if shadow_pos == "1" then
          SetControlScriptExternalVariable("shadow_state", "move_to2a")
          SetControlScriptExternalVariable("shadow_pos", "2")
          Flg.Set("FLAG_FIELD_D11_BS01")
        end
      elseif col_name == "evt_4002" then
        if shadow_pos == "2" then
          SetControlScriptExternalVariable("shadow_state", "move_to3a")
          SetControlScriptExternalVariable("shadow_pos", "3")
          Flg.Set("FLAG_FIELD_D11_BS02")
        end
      elseif col_name == "evt_4003" and shadow_pos == "3" then
        SetControlScriptExternalVariable("shadow_state", "move_to4a")
        SetControlScriptExternalVariable("shadow_pos", "4")
        Flg.Set("FLAG_FIELD_D11_BSEnd")
      end
    end
    if col_name == "evt_5000" then
      M110:Event_030()
    end
    if col_name == "evt_5001" then
      M110:Event_033()
    end
    if col_name == "evt_5002" then
      M110:Event_035()
    end
    if col_name == "evt_7000" then
      M210:Event_145()
    end
    if col_name == "evt_7001" then
      M210:Event_148()
    end
    if col_name == "evt_4100" and Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_220") and not Flg.Check("FLAG_MAIN_07_060") then
      local name = "npc_001"
      local tlk = Tlk:new("d11")
      tlk:StartTalkAction(name)
      tlk:Message("f_d1103_0030_0010")
      tlk:MessageClose()
      local obj = Obj:new(NPC, name)
      local move_pos_x = obj.vec.x * 2
      local move_pos_z = obj.vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_pos_x, move_pos_z, 20)
      WaitFrame(20)
      tlk:EndTalkAction()
    end
  elseif gMapNum == 1104 and col_name == "evt_0002" then
    M110:Event_090()
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 1101 then
    if gim_id == 1 then
      if Common.CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d1101_ControlPanel_210()
      else
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        PlayerLookAtLccatorObject(gim_name)
        Prcs_d1101_CheckControlPanel()
      end
    end
    if Flg.Check("FLAG_MAIN_03_060") and not Flg.Check("FLAG_FIELD_D11_014") then
      if gim_id == 3 then
        PlayerLookAtLccatorObject(gim_name)
        local tlk = Tlk:new("d11", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1101_0040_0010")
        tlk:EndTalk()
      end
      if gim_id == 4 then
        PlayerLookAtLccatorObject(gim_name)
        local tlk = Tlk:new("d11", 1, false)
        tlk:StartTalk()
        tlk:Message("f_d1101_0050_0010")
        tlk:EndTalk()
      end
    end
  elseif gMapNum == 1102 then
    if gim_id == 100 or gim_id == 402 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      M080:Event_080()
      GoToOuter("change_0001", 0, -1)
      MapChange("h", 201, "start_00", true, 1, FADE_TIME)
    end
    if gim_id == 102 then
      PlayerLookAtLccatorObject(gim_name)
    end
    if gim_id == 103 then
      PlayerLookAtLccatorObject(gim_name)
      M080:Event_077()
    end
    if gim_id == 105 then
      PlayerLookAtLccatorObject(gim_name)
      M080:Event_079()
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 1103 then
    if gim_id == 1 then
      if Flg.Check("FLAG_MAIN_03_420", "FLAG_MAIN_03_425") then
        M110:Event_040()
      else
        PlayerLookAtLccatorObject(gim_name)
        local tlk = Tlk:new("d11", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1103_0020_0010")
        tlk:EndTalk()
      end
    end
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      Motion.Gimmick:Play("gim_0002", "e001", false)
      SetEnableGimmickCheck("gim_0002", false)
      WaitFrame(40)
      ColOff("wall_cl_0002")
      Flg.Set("FLAG_GIMMICK_D11_110")
    end
    if gim_id == 5 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1103_0020_0010")
      tlk:EndTalk()
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 1104 and gim_id == 400 then
    GoToTheaterWithEvt()
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 1101 then
    if gim_name == "shutter_access01" then
      PlayerLookAtGimmickObject(gim_name)
      M210:Event_030()
    elseif gim_name == "duct_access01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      M210:Event_040()
      Prcs_d1101_Duct()
      M210:Event_045()
    elseif gim_name == "panel_access01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject(gim_name)
      M210:Event_090()
      Prcs_d1101_DoorPanel()
    end
  elseif gMapNum == 1102 then
  elseif gMapNum == 1103 then
  elseif gMapNum == 1104 and gim_name == "egg_access01" then
    PlayerLookAtGimmickObject(gim_name)
    Field_Talk_Start_Not_LetterBox("d11", 1)
    Message("f_d1104_0020_0010")
    Field_Talk_End_Not_LetterBox()
  end
end

function OnCheckActModel(act)
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 1101 then
    if gim_id == 200 then
      if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1101.obj1.text) then
        BreakFieldAttackObj_NoQuake(BRK1101.obj1.loc, BRK1101.obj1.col, 30, BRK1101.obj1.se, "ef_f_com_300_sm")
        Flg.Set(BRK1101.obj1.flag)
        Prcs_d1101_DoorOpen_FA()
      else
        OpenTutorial(3003)
      end
    end
  elseif gMapNum == 1102 then
  elseif gMapNum == 1103 and gim_id == 200 then
    local index = GetIndex(FLD_OBJ_LOCATOR, "fa_0001")
    AttachAndStartEffectScript(FLD_OBJ_LOCATOR, index, "ef_f_com_300_sm", false, 1, false, false, false, false)
    Quake_Start(0.2, 0, 20)
    PlaySE(202002, 100)
    WaitFrame(60)
    Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(false)
    M110:Event_080()
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
  if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
  if gMapNum == 1101 then
    if gim_name == "fa_obstacles_01" then
      SetControlScriptExternalVariable("elecmon_state", "escape_to7")
      SetControlScriptExternalVariable("elecmon_pos", "8")
      Flg.Set("FLAG_GIMMICK_D11_060")
      WaitFrame(60)
      local tlk = Tlk:new("d11", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1101_0070_0010")
      tlk:MessageClose()
      AnswerTheCall()
      WaitFrame(30)
      tlk:Message("f_d1101_0070_0020")
      tlk:Message("f_d1101_0070_0030")
      tlk:Message("f_d1101_0070_0040")
      EndTheCall()
      tlk:EndTalk()
      Digitter.Send(1060080030)
    end
  elseif gMapNum == 1102 then
    if gim_name == "fa_obstacles_01" then
      ColOff("plan_cl_0001")
      ColOff("wall_cl_0003")
      Flg.Set("FLAG_GIMMICK_D11_040")
    end
  elseif gMapNum == 1103 then
  elseif gMapNum == 1104 then
  end
  if gim_tag == "fa_sub201" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
    require("Sow_201")
    if gMapNum == 1101 then
      SeekEtemon_D1101(gim_name)
    elseif gMapNum == 1102 then
      SeekEtemon_D1102(gim_name)
    elseif gMapNum == 1103 then
      SeekEtemon_D1103(gim_name)
    end
  end
end
