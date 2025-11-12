gGimText = "field_text"
BRK1201 = {
  obj1 = {
    loc = "fa_0001",
    col = "plan_cl_2000",
    text = -1,
    flag = "FLAG_GIMMICK_D12_010",
    se = 202001
  },
  obj2 = {
    loc = "fa_0002",
    col = "plan_cl_2001",
    text = -1,
    flag = "FLAG_GIMMICK_D12_011",
    se = 202001
  },
  obj3 = {
    loc = "fa_0003",
    col = "plan_cl_2002",
    text = -1,
    flag = "FLAG_GIMMICK_D12_012",
    se = 202001
  },
  obj4 = {
    loc = "fa_0004",
    col = "plan_cl_2003",
    text = -1,
    flag = "FLAG_GIMMICK_D12_013",
    se = 202001
  },
  obj5 = {
    loc = "fa_0005",
    col = "plan_cl_2004",
    text = -1,
    flag = "FLAG_GIMMICK_D12_014",
    se = 202001
  },
  obj6 = {
    loc = "fa_0006",
    col = "plan_cl_2005",
    text = -1,
    flag = "FLAG_GIMMICK_D12_015",
    se = 202001
  },
  obj7 = {
    loc = "fa_0007",
    col = "plan_cl_2006",
    text = -1,
    flag = "FLAG_GIMMICK_D12_016",
    se = 202001
  }
}
BRK1203 = {
  obj1 = {
    loc = "fa_0001",
    col = "plan_cl_2000",
    text = -1,
    flag = "FLAG_GIMMICK_D12_030",
    se = 202001
  }
}

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 1201 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
  elseif load_map_num == 1202 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
  elseif load_map_num == 1203 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d12_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 1201 then
    for key in pairs(BRK1201) do
      if Flg.Check(BRK1201[key].flag) then
        Obj:new(FLD_OBJ_LOCATOR, BRK1201[key].loc):Invisible()
        ColOff(BRK1201[key].col)
      end
    end
    if Flg.Check("FLAG_GIMMICK_D12_020") then
      SetEnableGimmickCheck("gim_0007", false)
      Motion.Gimmick:PlayFinishedAnim("gim_0007", "e002")
      ColOff("plan_cl_2009")
    end
  elseif gMapNum == 1203 then
    for key in pairs(BRK1203) do
      if Flg.Check(BRK1203[key].flag) then
        Obj:new(FLD_OBJ_LOCATOR, BRK1203[key].loc):Invisible()
        ColOff(BRK1203[key].col)
      end
    end
  elseif gMapNum == 1204 then
  elseif gMapNum == 1206 then
    Field.PlayerChangeMoveAnimation("walk")
    Field.PlayerFixedMaxSpeed(2)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  local npc_text = "d12"
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 1201 then
  elseif gMapNum == 1202 then
    if col_name == "evt_1000" and Flg.Check("FLAG_MAIN_08_030", "FLAG_MAIN_08_043") then
      local tlk = Tlk:new("d12", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1202_0010_0010")
      Field.MovePlayerToRelativePosFrame(0, -1, 20)
      WaitFrame(5)
      tlk:EndTalk()
    end
  elseif gMapNum == 1204 then
    if col_name == "evt_0001" and not Flg.Check("FLAG_MAIN_08_040") then
      local tlk = Tlk:new("d12", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1204_0010_0010")
      MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(5)
      tlk:EndTalk()
    end
    if col_name == "evt_0004" and not Flg.Check("FLAG_MAIN_08_040") then
      local tlk = Tlk:new("d12", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1204_0020_0010")
      MovePlayerToRelativePosFrame(-0.5, -1, 20)
      WaitFrame(5)
      tlk:EndTalk()
    end
    if col_name == "evt_0005" and Flg.Check("FLAG_MAIN_08_035") and not Flg.Check("FLAG_MAIN_08_037") then
      local tlk = Tlk:new("d12", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1204_0720_0010")
      tlk:EndTalk()
      MovePlayerToRelativePosFrame(0.5, 1, 20)
      WaitFrame(20)
    end
    if col_name == "evt_0002" then
      M235:Event_050()
    end
    if col_name == "evt_0008" then
      if Flg.Check("FLAG_MAIN_12_060") and not Flg.Check("FLAG_MAIN_12_063") then
        Digitter.Send(1330010020)
      elseif Flg.Check("FLAG_MAIN_13_090") and not Flg.Check("FLAG_MAIN_13_100") then
        Digitter.Send(1350010010)
      end
    end
    if col_name == "evt_0007" then
      M390:Event_030()
      if Flg.Check("FLAG_MAIN_08_035") and not Flg.Check("FLAG_MAIN_17_020") then
        local tlk = Tlk:new("d12", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1204_0030_0010")
        tlk:EndTalk()
        MovePlayerToRelativePosFrame(-1, -1, 20)
        WaitFrame(25)
      end
    end
    if col_name == "evt_0010" then
      M330:Event_015()
      M350:Event_035()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  elseif gMapNum == 1205 then
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 1201 then
    if gim_id == 900 then
    end
    if gim_id == 1 then
    end
    if gim_id == 2 then
      Motion.Gimmick:Play("gim_0002", "e001", false)
      ColOff("plan_cl_1000")
      SetEnableGimmickCheck("gim_0002", false)
    end
    if gim_id == 3 then
      Motion.Gimmick:Play("gim_0003", "e001", false)
      ColOff("plan_cl_1001")
      SetEnableGimmickCheck("gim_0003", false)
    elseif gim_id == 4 then
      Motion.Gimmick:Play("gim_0004", "e001", false)
      ColOff("plan_cl_1002")
      SetEnableGimmickCheck("gim_0004", false)
    elseif gim_id == 5 then
      Motion.Gimmick:Play("gim_0005", "e001", false)
      ColOff("plan_cl_1003")
      SetEnableGimmickCheck("gim_0005", false)
    elseif gim_id == 6 then
      Motion.Gimmick:Play("gim_0006", "e001", false)
      ColOff("plan_cl_1004")
      SetEnableGimmickCheck("gim_0006", false)
    elseif gim_id == 7 and not Flg.Check("FLAG_GIMMICK_D12_020") then
      Cam.Inst:Set(-99.5, -1, 62.17, -91.222, 4.532, 61.325, DEFAULT_ANGLE, 15)
      MovePlayerToLocatorFrame("gim_0008", 20)
      SetEnableGimmickCheck("gim_0007", false)
      Motion.Gimmick:Play("gim_0007", "e001", false)
      ColOff("plan_cl_2009")
      Cam.Inst:Clear(30)
      Flg.Set("FLAG_GIMMICK_D12_020")
    end
  elseif gMapNum == 1204 then
    sp_text = "d12"
    if gim_id == 1 then
    end
    if gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      GoToTheaterWithEvt()
    end
    if gim_id == 450 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      if Flg.Check("FLAG_MAIN_17_020", "FLAG_MAIN_17_036") then
        local tlk = Tlk:new("d12", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1204_0650_0010")
        tlk:EndTalk()
      else
        M240:Event_020()
        PlayerLookAtLccatorObject(gim_name)
        Prcs_d1204_DageGate()
      end
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 1201 then
  elseif gMapNum == 1202 and gim_name == "door_access01" then
    PlayerLookAtGimmickObject(gim_name)
    Motion.Gimmick:Play("gim_0001", "e001", false)
    ColOff("plan_cl_1001")
    Obj:new(FLD_OBJ_GIMMICK, "door_access01"):SetEnableCheckAndFieldAttack(false)
  end
  if gMapNum == 1204 and gim_name == "door" then
    Field.CancelPlayerAnywhereDigimonRide(false, true)
    OpenDoor(gim_name, "", true, "gim_8000", gim_type)
    DoorMapChange("d", 1206, "start_00")
  end
  if gMapNum == 1206 and gim_name == "door" then
    Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
    PlaySE(200001, 100)
    MapChange("d", 1204, "start_05", true, FADE_BLACK, FADE_TIME)
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 1201 then
    if gim_id == 206 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, 3300) then
      Prcs_d1201_TurnOnSwitchBoard()
    end
    if gim_id == 200 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1201.obj1.text) then
      BreakFieldAttackObj(BRK1201.obj1.loc, BRK1201.obj1.col, 30, BRK1201.obj1.se, "ef_f_com_300_sm")
      Flg.Set(BRK1201.obj1.flag)
    end
    if gim_id == 201 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1201.obj2.text) then
      BreakFieldAttackObj(BRK1201.obj2.loc, BRK1201.obj2.col, 30, BRK1201.obj2.se, "ef_f_com_300_sm")
      Flg.Set(BRK1201.obj2.flag)
    end
    if gim_id == 202 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1201.obj3.text) then
      BreakFieldAttackObj(BRK1201.obj3.loc, BRK1201.obj3.col, 30, BRK1201.obj3.se, "ef_f_com_300_sm")
      Flg.Set(BRK1201.obj3.flag)
    end
    if gim_id == 203 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1201.obj4.text) then
      BreakFieldAttackObj(BRK1201.obj4.loc, BRK1201.obj4.col, 30, BRK1201.obj4.se, "ef_f_com_300_sm")
      Flg.Set(BRK1201.obj4.flag)
    end
    if gim_id == 204 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1201.obj5.text) then
      BreakFieldAttackObj(BRK1201.obj5.loc, BRK1201.obj5.col, 30, BRK1201.obj5.se, "ef_f_com_300_sm")
      Flg.Set(BRK1201.obj5.flag)
    end
    if gim_id == 205 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1201.obj6.text) then
      BreakFieldAttackObj(BRK1201.obj6.loc, BRK1201.obj6.col, 30, BRK1201.obj6.se, "ef_f_com_300_sm")
      Flg.Set(BRK1201.obj6.flag)
    end
  elseif gMapNum == 1203 and gim_id == 200 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1203.obj1.text) then
    BreakFieldAttackObj(BRK1203.obj1.loc, BRK1203.obj1.col, 30, BRK1203.obj1.se, "ef_f_com_300_sm")
    Flg.Set(BRK1203.obj1.flag)
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
  if gMapNum == 1201 then
    if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 1202 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnCheckActModel(act)
end
