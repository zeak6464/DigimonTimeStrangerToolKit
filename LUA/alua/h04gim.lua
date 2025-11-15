gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  AddLoadList(FLD_OBJ_PLAYER, {
    "",
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
  if load_map_num == 415 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  PlayerObjectResetAim()
  if gMapNum == 401 then
    if not (col_name == "evt_0001" and Quest.CheckFlag(1602, 2)) or not Quest.CheckFlag(1602, 3) then
    end
  elseif (gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418) and col_name == "evt_0100" then
    Prcs_h04_BossBattle()
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 401 then
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418 or gMapNum == 420 or gMapNum == 421 or gMapNum == 422 or gMapNum == 423 then
    if gim_name == "log_message" then
      HazamaMessage(tonumber(gim_tag), gim_index)
    elseif gim_name == "way_out" then
      PlayerLookAtGimmickObject(gim_name)
      HazamaWayout(gim_name)
    end
  end
  if gMapNum == 415 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(945)
    end
  elseif gMapNum == 416 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(946)
    end
  elseif gMapNum == 417 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(947)
    end
  elseif gMapNum == 418 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(948)
    end
  elseif gMapNum == 420 then
    if gim_name == "control_panel" then
      Field.HideMinimap(true)
      Field.HideGuide(true)
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess2(960)
      Field.HideGuide(false)
      Field.HideMinimap(false)
    end
  elseif gMapNum == 421 then
    if gim_name == "control_panel" then
      Field.HideMinimap(true)
      Field.HideGuide(true)
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess2(961)
      Field.HideGuide(false)
      Field.HideMinimap(false)
    end
  elseif gMapNum == 422 then
    if gim_name == "control_panel" then
      Field.HideMinimap(true)
      Field.HideGuide(true)
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess2(962)
      Field.HideGuide(false)
      Field.HideMinimap(false)
    end
  elseif gMapNum == 423 and gim_name == "control_panel" then
    Field.HideMinimap(true)
    Field.HideGuide(true)
    PlayerLookAtGimmickObject(gim_name)
    TerminalAccsess2(963)
    Field.HideGuide(false)
    Field.HideMinimap(false)
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
  if (gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418) and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnCheckActModel(act)
end
