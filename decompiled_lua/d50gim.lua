gGimText = "field_text"

function LoadGimmickData(load_map_num)
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 5001 then
  elseif gMapNum == 5003 then
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 5001 then
    if col_name == "evt_0001" then
    end
  elseif gMapNum == 5002 then
    if col_name == "evt_0001" then
    elseif col_name == "evt_0002" then
    end
  elseif gMapNum == 5003 then
    if col_name == "evt_0001" then
    elseif col_name == "evt_0002" then
    elseif col_name == "evt_0003" then
    end
  elseif gMapNum == 5004 then
    if col_name == "evt_0001" then
    end
  elseif gMapNum == 5005 then
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  print("##### gim_unique_name = ", gim_name)
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
  elseif gMapNum == 5004 then
    if gim_name == "door_back" then
    elseif gim_name == "door_front_frontside" then
    else
      if gim_name == "door_front_backside" then
      else
      end
    end
  elseif gMapNum == 5005 then
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
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 5004 then
  elseif gMapNum == 5005 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "FAobj_escape_1" then
      SetControlScriptExternalVariable("escape_state_1", "dash_standby_1")
    end
    if gim_name == "FAobj_escape_2" then
      SetControlScriptExternalVariable("escape_state_2", "dash_standby_2")
    end
    if gim_name == "FAobj_escape_3" then
      SetControlScriptExternalVariable("escape_state_3", "dash_standby_3")
    end
    if gim_name == "FAobj_escape_4" then
      SetControlScriptExternalVariable("escape_state_4", "dash_standby_4")
    end
  end
end

function OnCheckActModel(act)
end
