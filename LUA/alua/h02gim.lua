gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    local index = Field.GetPlayerIndex()
    Motion.Object:Load(FLD_OBJ_PLAYER, index, PC_GENERAL_MOTION[i])
  end
  AddLoadList(FLD_OBJ_PLAYER, {
    "",
    move_motion = {"flow"},
    motion = {
      "fg14_w02",
      "e003",
      "e004"
    },
    attach = {9},
    attach_motion = {
      {9, "e200"}
    }
  })
  if load_map_num == 201 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 201 then
    if Flg.Check("FLAG_GIMMICK_H02_010") then
      Obj:new(NPC, "boss"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_H02_070") then
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):SetEnableCheckAndFieldAttack(true)
    else
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):SetEnableCheckAndFieldAttack(false)
    end
  elseif gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    print("====== HAZAMA OBJ ZAHYOU SET============")
    g_obj = {}
    local pos1 = {}
    local pos2 = {}
    local pos3 = {}
    local pos4 = {}
    local pos5 = {}
    local pos6 = {}
    local pos7 = {}
    local pos8 = {}
    pos1 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel01"))
    pos2 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel02"))
    pos3 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel03"))
    pos4 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel04"))
    pos5 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel05"))
    pos6 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel06"))
    pos7 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel07"))
    pos8 = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, Field.GetGimmickIndex("panel08"))
    g_obj.panel01 = pos1
    g_obj.panel02 = pos2
    g_obj.panel03 = pos3
    g_obj.panel04 = pos4
    g_obj.panel05 = pos5
    g_obj.panel06 = pos6
    g_obj.panel07 = pos7
    g_obj.panel08 = pos8
    print("#### g_obj tbl ####")
    printTable(g_obj)
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    if gim_name == "log_message" then
      HazamaMessage(tonumber(gim_tag), gim_index)
    elseif gim_name == "way_out" then
      PlayerLookAtGimmickObject(gim_name)
      HazamaWayout(gim_name)
    end
  end
  if gMapNum == 210 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(920)
    end
  elseif gMapNum == 211 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(921)
    end
  elseif gMapNum == 212 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(922)
    end
  elseif gMapNum == 213 and gim_name == "control_panel" then
    PlayerLookAtGimmickObject(gim_name)
    TerminalAccsess(923)
  end
  if (gMapNum == 220 or gMapNum == 221 or gMapNum == 222) and gim_name == "way_out" then
    PlayerLookAtGimmickObject(gim_name)
    HazamaWayout(gim_name)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 201 then
    if col_name == "evt_0500" then
      M080:Event_100()
    end
    if col_name == "evt_0502" then
    end
    if col_name == "evt_1000" then
      M080:Event_105()
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 201 then
    if gim_id == 1 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      SetControlScriptExternalVariable("rail_set", "rail_05")
    end
    if gim_id == 2 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      SetControlScriptExternalVariable("rail_set", "rail_05")
    end
    if gim_id <= 2 then
      Prcs_h02_RailMoveStart(gim_id)
    end
    if gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Field_Talk_Start_Not_LetterBox(gGimText, 1)
      Message("g_crevice_0020_0010")
      MessageClose()
      MessageTalkSel(2, "g_sel_0020_0010")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Field_Talk_End_Not_LetterBox()
        GoToOuter("change_0001", 0, -1)
        if Flg.Check("S110_090_004") and not Flg.Check("S110_090_002") then
          MapChange("t", 203, "start_06", true, 1, 30)
        elseif Flg.Check("FLAG_SUB_910_169_004", "FLAG_SUB_910_169_006") then
          MapChange("t", 109, "start_22", true, 1, 30)
        elseif Flg.Check("FLAG_SUB_110_113_002") then
          Guest.Delete(GST_S010_156_GANKOO)
          Guest.Delete(GST_S010_156_JES)
          Flg.Clear("FLAG_SUB_110_113_002")
          MapChange("t", 203, "start_11", true, 1, 30)
        elseif Flg.Check("FLAG_IS_S200_146_001", "FLAG_IS_S200_146_002") then
          MapChange("t", 203, "start_11", true, 1, 30)
        else
          MapChange("d", 1102, "start_01", true, 1, 30)
        end
      elseif result == RESULT_TALK01 then
        Field_Talk_End_Not_LetterBox()
      end
    end
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 201 then
  end
end

function OnFieldAttackGimmick(att_gim)
  local gim_name = att_gim.unique_name
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  local gim_tag = att_gim.tag
  print("gimName = ", gim_name, "gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 201 then
    if gim_name == "fa_obstacles_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):SetEnableCheckAndFieldAttack(true)
      Flg.Set("FLAG_GIMMICK_H02_070")
    end
  elseif (gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213) and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnCheckActModel(act)
end
