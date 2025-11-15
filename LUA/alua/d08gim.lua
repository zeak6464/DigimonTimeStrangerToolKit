gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 801 then
  end
  if load_map_num == 802 then
    AddLoadList(FLD_OBJ_GIMMICK, {
      "d08_floor",
      motion = {"e002"}
    })
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d08_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 801 then
  end
  if gMapNum == 802 then
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  gCollisionTable = {}
  if gMapNum == 801 and col_name == "evt_1000" then
    Field_Talk_Start_Not_LetterBox("d08", 1)
    Message("f_d0801_0040_0010")
    MovePlayerToRelativePosFrame(0, -2, 30)
    Field_Talk_End_Not_LetterBox()
  end
  if gMapNum == 802 and col_name == "evt_0002" then
    M030:Event_020()
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 801 then
  elseif gMapNum == 802 then
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
end

function OnCheckActModel(act)
end
