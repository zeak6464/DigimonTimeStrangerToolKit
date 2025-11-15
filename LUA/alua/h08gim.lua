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
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 801 then
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 801 then
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 801 then
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 810 or gMapNum == 811 or gMapNum == 812 or gMapNum == 813 then
    if gim_name == "way_out" then
      PlayerLookAtGimmickObject(gim_name)
      HazamaWayout(gim_name)
    elseif gim_name == "log_message" then
      local item_cnt = HazamaItemCount()
      if 10 <= item_cnt and not Flg.Check("FLAG_IS_EXTRA_H810") then
        Flg.Set("FLAG_IS_EXTRA_H810")
      end
      if 20 <= item_cnt and not Flg.Check("FLAG_IS_EXTRA_H811") then
        Flg.Set("FLAG_IS_EXTRA_H811")
      end
      if 30 <= item_cnt and not Flg.Check("FLAG_IS_EXTRA_H812") then
        Flg.Set("FLAG_IS_EXTRA_H812")
      end
      if 40 <= item_cnt and not Flg.Check("FLAG_IS_EXTRA_H813") then
        Flg.Set("FLAG_IS_EXTRA_H813")
      end
      HazamaMessage(tonumber(gim_tag), gim_index)
    elseif gim_name == "warp01" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp02" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp03" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp04" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp05" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp06" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp07" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp08" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp09" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp10" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp11" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp12" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp13" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    elseif gim_name == "warp14" then
      PlayerLookAtGimmickObject(gim_name)
      Prcs_h08_Warp(gim_tag)
    end
  end
  if gMapNum == 810 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(980)
    end
  elseif gMapNum == 811 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(981)
    end
  elseif gMapNum == 812 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(982)
    end
  elseif gMapNum == 813 and gim_name == "control_panel" then
    PlayerLookAtGimmickObject(gim_name)
    TerminalAccsess(983)
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
  if gMapNum == 810 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 801 then
  end
end

function OnCheckActModel(act)
end

function OnCheckLocatorLift(gimmick_index, args)
end
