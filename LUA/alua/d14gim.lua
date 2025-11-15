gGimText = "field_text"
BRK1402 = {
  obj8 = {
    loc = "fa_0009",
    col = "",
    text = "g_d1402_0010_0010",
    flag = "FLAG_GIMMICK_D14_190",
    se = 202001
  }
}
BRK1404 = {
  obj1 = {
    loc = "fa_0001",
    col = "plan_cl_2000",
    text = -1,
    flag = "FLAG_GIMMICK_D14_290",
    se = 202001
  },
  obj2 = {
    loc = "fa_0002",
    col = "plan_cl_2001",
    text = -1,
    flag = "FLAG_GIMMICK_D14_300",
    se = 202001
  }
}

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 1401 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {"obj_0002"})
    AddLoadList(FLD_OBJ_LOCATOR, {
      "change_0001",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 1402 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "change_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "npc_0001",
      motion = {"e002", "fn01_01"}
    })
  elseif load_map_num == 1403 then
    AddLoadList(FLD_OBJ_NPC, {
      "npc_0001",
      motion = {"ba02"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "npc_0001",
      motion = {"f000"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "change_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0004",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0005",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0010",
      motion = {"e001"}
    })
  elseif load_map_num == 1404 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "change_0001",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 1405 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "fa_0005",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "fa_0005",
      motion = {"e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e002"}
    })
  elseif load_map_num == 1406 then
    AddLoadList(FLD_OBJ_MOB, {
      "giantweapon",
      motion = {"e500"}
    })
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d14_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 1401 then
    SetQuakeEffect("ef_f_com_220_cr")
    Obj:new(NPC, "npc_elv0001"):Invisible()
    if Common.CheckTimeAxis("P2028_daft_420") then
      Field.LinkColOff("mapborder_1")
    end
  elseif gMapNum == 1402 then
    ColOff("wall_cl_0001")
    Obj:new(GIM, "obj_0002"):Invisible()
    Obj:new(GIM, "obj_0003"):Invisible()
    Obj:new(GIM, "obj_0004"):Invisible()
    Obj:new(GIM, "obj_0005"):Invisible()
    for key in pairs(BRK1402) do
      if Flg.Check(BRK1402[key].flag) then
        Obj:new(FLD_OBJ_LOCATOR, BRK1402[key].loc):Invisible()
        ColOff(BRK1402[key].col)
      end
    end
    Obj:new(NPC, "npc_elv0001"):Invisible()
  elseif gMapNum == 1403 then
    if Flg.Check("FLAG_MAIN_01_220") then
      Obj:new(GIM, "obj_0003"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):CancelInvisible()
      Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001")
      Motion.Gimmick:PlayFinishedAnim("obj_0004", "e001")
      Motion.Gimmick:PlayFinishedAnim("obj_0005", "e001")
      Obj:new(OGIM, "fa_obstacles_02"):CancelInvisible()
      ColOn("wall_cl_1003")
      Obj:new(FLD_OBJ_LOCATOR, "obj_0008"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0001"):Invisible()
      Obj:new(OGIM, "fa_obstacles_01"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):CancelInvisible()
      local OBJ = GetIndex(FLD_OBJ_LOCATOR, "obj_0004")
      Field.ObjectDisableCulling(FLD_OBJ_LOCATOR, OBJ)
      if not Flg.Check("FLAG_MAIN_01_230") then
        Obj:new(NPC, "npc_0001"):CancelInvisible()
        if not Flg.Check("FLAG_FIELD_D14_020") then
          Obj:new(NPC, "rumor_d1403_piyomon01"):Invisible()
        else
          Obj:new(NPC, "rumor_d1403_piyomon01"):CancelInvisible()
        end
      else
        Obj:new(NPC, "rumor_d1403_piyomon01"):Invisible()
        if not Flg.Check("FLAG_FIELD_D14_030") then
          SetControlScriptExternalVariable("piyo_state", "warp")
        else
          Obj:new(NPC, "npc_0001"):Invisible()
        end
      end
    else
      Obj:new(NPC, "rumor_d1403_piyomon01"):Invisible()
      local wall = GetIndex(FLD_OBJ_LOCATOR, "obj_0001")
      Motion.Object:Play(FLD_OBJ_LOCATOR, wall, 0, "e001", false)
      Field.ObjectDisableCulling(FLD_OBJ_LOCATOR, wall)
      Obj:new(FLD_OBJ_LOCATOR, "obj_0010"):Invisible()
      ColOff("wall_cl_0001")
      Obj:new(OGIM, "fa_obstacles_02"):Invisible()
      Obj:new(NPC, "npc_0001"):Invisible()
      ColOff("wall_cl_1003")
      Obj:new(GIM, "obj_0008"):Invisible()
      Obj:new(OGIM, "fa_obstacles_01"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D14_230") then
    end
    if not Flg.Check("FLAG_MAIN_01_230") then
      Motion.NPC:Play("npc_0001", "f000", 0, true)
      Field.ObjectSetIcon(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), FLD_ICON_PC_CHECK)
    end
    if not Flg.Check("FLAG_MAIN_01_212") then
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_obstacles_03"), false)
    end
    Obj:new(NPC, "npc_elv0001"):Invisible()
  elseif gMapNum == 1404 then
    if Flg.Check("FLAG_GIMMICK_D14_300") then
      ld_InvisibleGimmick("fa_0002", 0, 0, false)
      ColOff("plan_cl_2000")
    end
    for key in pairs(BRK1404) do
      if Flg.Check(BRK1404[key].flag) then
        Obj:new(FLD_OBJ_LOCATOR, BRK1404[key].loc):Invisible()
        ColOff(BRK1404[key].col)
      end
    end
  elseif gMapNum == 1405 then
    if Flg.Check("FLAG_GIMMICK_D14_320") then
      Obj:new(FLD_OBJ_LOCATOR, "fa_0005"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):CancelInvisible()
      Motion.Gimmick:PlayFinishedAnim("obj_0002", "e002")
      ColOff("wall_cl_2004")
      SetEnableGimmickCheck("fa_0005", false)
    else
      ColOff("plan_cl_2004")
      ColOff("wall_cl_0002")
      ColOff("wall_cl_0001")
      SetEnableGimmickCheck("fa_0005", false)
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D14_380") and not Flg.Check("FLAG_GIMMICK_D14_320") then
      Motion.Gimmick:PlayFinishedAnim("fa_0005", "e001")
      ColOn("plan_cl_2004")
      ColOn("wall_cl_0002")
      ColOn("wall_cl_0001")
      SetEnableGimmickCheck("fa_0005", true)
    end
  elseif gMapNum == 1406 then
    Obj:new(MOB, "giantweapon"):Invisible()
    if Flg.Check("FLAG_FIELD_D14_030", "FLAG_GIMMICK_D14_010") then
      RegularQuake_Start(0.02, 0, 60, 105)
    end
  elseif gMapNum == 1409 then
    Field.PlayerScriptDigimonRideStartFromID(146, false, "", 0)
    Field.PlayerFixedMaxSpeed(10)
    SetControlScriptExternalVariable("player_state", "focus1")
    SetControlScriptExternalVariable("test_chrono_state", "start")
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 1401 then
    if col_name == "evt_2000" then
      M020:Event_140()
    end
    if col_name == "evt_4000" then
    end
    if col_name == "evt_1003" and Flg.Check("FLAG_MAIN_01_210", "FLAG_MAIN_02_010") then
      local tlk = Tlk:new("d14", 1, true)
      tlk:StartTalk()
      AnswerTheCall()
      tlk:Message("f_d1401_0070_0010")
      tlk:MessageClose()
      EndTheCall()
      Field.MovePlayerToRelativePosFrame(-1.5, 0, 30)
      WaitFrame(30)
      tlk:EndTalk()
    end
  end
  if gMapNum == 1402 then
    if col_name == "evt_0002" and Flg.Check("FLAG_MAIN_01_185") then
      SetEnableGimmickCheck("fa_0009", true)
    end
    if col_name == "evt_2100" then
      M020:Event_151()
    end
    if col_name == "evt_9000" then
      MiniMapChange(3)
    elseif col_name == "evt_9001" then
      MiniMapChange(1)
    elseif col_name == "evt_9002" then
      MiniMapChange(1)
    elseif col_name == "evt_9003" then
      MiniMapChange(2)
    elseif col_name == "evt_9004" then
      MiniMapChange(2)
    elseif col_name == "evt_9005" then
      MiniMapChange(3)
    end
  end
  if gMapNum == 1403 then
    if col_name == "evt_1000" then
      M020:Event_245()
    end
    if col_name == "evt_3000" then
      M020:Event_250()
    end
    if col_name == "evt_3001" then
      M020:Event_265()
    end
    if col_name == "evt_9000" then
      M020:Event_270()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):CancelInvisible()
    end
    if Flg.Check("FLAG_MAIN_01_220") and not Flg.Check("FLAG_MAIN_01_230") then
      if col_name == "evt_2000" then
        Obj:new(RUMOR_NPC, "rumor_d1403_piyomon01"):Invisible(1)
      elseif col_name == "evt_2001" then
        Obj:new(RUMOR_NPC, "rumor_d1403_piyomon01"):CancelInvisible(1)
      end
    end
    if col_name == "evt_2002" then
      M020:Event_290()
    end
  elseif gMapNum == 1405 then
    if col_name == "evt_0001" and not Flg.Check("FLAG_GIMMICK_D14_380") then
      Flg.Set("FLAG_GIMMICK_D14_380")
      ColOn("plan_cl_2004")
      ColOn("wall_cl_0002")
      ColOn("wall_cl_0001")
      SetControlScriptExternalVariable("breakrubble_state", "break_start")
      SetEnableGimmickCheck("fa_0005", true)
      M020:Event_332()
    end
    if col_name == "evt_0002" then
      Field_Talk_Start("d14", 1)
      Message("f_d1405_0020_0010")
      Field_Talk_End()
      MovePlayerToLocatorFrame("sp_0001", 30)
    end
    if col_name == "evt_0003" then
      M020:Event_331()
    end
    if col_name == "evt_9000" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    elseif col_name == "evt_9001" then
      MiniMapChange(MAP_LAYER_LOW)
    end
  end
  if gMapNum == 1406 then
    if col_name == "evt_0001" then
      M020:Event_350()
    end
    if col_name == "evt_0003" then
      Field.SetControlScriptExternalVariable("bigrobo_effect", "quake_change")
      Prcs_d1406_GiantWeaponMotion()
      M020:Event_334()
    end
  end
  if gMapNum == 1407 then
    if col_name == "evt_0001" then
      M020:Event_370()
    end
    if col_name == "evt_0002" then
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 1401 then
    if gim_id == 202 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      M020:Event_150()
      Prcs_d1401_ElvGim(gim_loc)
    end
    if gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 1402 then
    if gim_id == 3 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d1402_ElvGim(gim_loc)
    end
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d1402_CheckSwitchBoard()
    end
  elseif gMapNum == 1403 then
    if gim_id == 2 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d1403_ElvGim(gim_loc)
    end
    if gim_id == 300 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d1403_RideFall()
    end
  elseif gMapNum == 1404 then
    if gim_id == 1 then
      Prcs_d1404_ElvGim(gim_loc)
    end
  elseif gMapNum == 1405 then
    if gim_name == "fa_0005" then
      local tlk = Tlk:new("d14", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1405_0030_0010")
      tlk:EndTalk()
    end
  elseif gMapNum == 1407 then
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 1401 then
  elseif gMapNum == 1402 then
    if gim_id == 208 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1402.obj8.text) then
      Prcs_d1402_TurnOnSwitchBoard()
      SetEnableGimmickCheck("gim_0001", false)
      Flg.Set(BRK1402.obj8.flag)
      local fa_obstacles_05 = Obj:new(OGIM, "fa_obstacles_05")
      fa_obstacles_05:SetEnableCheckAndFieldAttack(true)
      fa_obstacles_05:CancelInvisible()
      local index4 = Obj:new(FLD_OBJ_LOCATOR, "obj_0007")
      index4:Invisible()
    end
  elseif gMapNum == 1403 then
  elseif gMapNum == 1404 then
    if gim_id == 200 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1404.obj1.text) then
      BreakFieldAttackObj(BRK1404.obj1.loc, BRK1404.obj1.col, 30, BRK1404.obj1.se, "ef_f_com_300_sm")
      Flg.Set(BRK1404.obj1.flag)
    end
    if gim_id == 201 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK1404.obj2.text) then
      BreakFieldAttackObj(BRK1404.obj2.loc, BRK1404.obj2.col, 30, BRK1404.obj2.se, "ef_f_com_300_sm")
      Flg.Set(BRK1404.obj2.flag)
    end
  elseif gMapNum == 1405 then
    if gim_id == 204 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      Prcs_d1405_BreakRubble2()
      M020:Event_333()
    end
  elseif gMapNum == 1406 then
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 1401 then
  end
  if gMapNum == 1403 and gim_name == "fa_obstacles_03" then
    local tlk = Tlk:new("d14", 1, true)
    tlk:StartTalk()
    tlk:Message("f_d1403_0030_0010")
    tlk:EndTalk()
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
  if gMapNum == 1401 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 1402 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_03" then
    end
    if gim_name == "fa_obstacles_05" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_04" then
      local obj = Obj:new(FLD_OBJ_LOCATOR, "obj_0008")
      obj:Invisible()
      Flg.Set("FLAG_GIMMICK_D14_180")
    end
  elseif gMapNum == 1403 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_01" then
      Flg.Set("FLAG_GIMMICK_D14_230")
    end
    if gim_name == "fa_obstacles_03" then
      M020:Event_260()
    end
  elseif gMapNum == 1405 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 1406 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end
