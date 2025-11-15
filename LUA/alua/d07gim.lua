gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 701 then
    AddLoadList("camera", {
      "cam02_railcam"
    })
  elseif load_map_num == 702 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"door"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
    Field.LoadEffectScript("ef_b_van_100", 1)
    Field.ObjectLoadMotion(PLAYER, 1, "e005")
    Field.ObjectLoadMotion(PLAYER, 1, "e005_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "e006_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e202")
    Field.ObjectLoadMotion(PLAYER, 1, "fg09_in01")
    Field.ObjectLoadMotion(PLAYER, 1, "fg09_n01")
    Field.ObjectLoadMotion(PLAYER, 1, "fg09_out01")
    Field.ObjectLoadMotion(OGIM, GetIndex(OGIM, "obj_curtain01"), "e001")
    Field.ObjectLoadMotion(OGIM, GetIndex(OGIM, "obj_curtain01"), "e002")
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d07_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  gCollisionTable = {}
  PlayerObjectResetAim()
  if Flg.Check("FLAG_IS_FLIGHT_RIDE") then
    StartRideFly(false, "", 0)
  else
    Field.CancelPlayerFixedMaxSpeed()
  end
  if gMapNum == 701 then
    local array = {
      "npc_1000",
      "npc_1001",
      "npc_1002",
      "npc_1003",
      "npc_1004",
      "npc_1005",
      "npc_1006",
      "npc_1007",
      "npc_1008",
      "npc_1009",
      "npc_1010",
      "npc_1011",
      "npc_1012",
      "npc_1013",
      "npc_1014",
      "npc_1015",
      "npc_1016",
      "npc_1017",
      "npc_1018",
      "npc_1019"
    }
    for num = 1, #array do
      Obj:new(NPC, array[num]):Invisible()
    end
    Obj:new(OGIM, "eff_geko_01"):Invisible()
    if not Flg.Check("FLAG_MAIN_14_011") then
      Obj:new(NPC, "npc_1000"):CancelInvisible()
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "ride_access_01"), false)
    end
    local npc_index = GetIndex(NPC, "M_burinp_100")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
  elseif gMapNum == 702 then
    Motion.Object:LoadMove(FLD_OBJ_PLAYER, "", "door")
    if Flg.Check("FLAG_GIMMICK_D07_080") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "door_access_01"), false)
      Motion.Gimmick:PlayFinishedAnim("gim_0001", "e001")
      ColOff("wall_cl_0004")
    end
    Obj:new(OGIM, "eff_geko_01"):Invisible()
    if Flg.Check("FLAG_GIMMICK_D07_110") then
      Motion.Object:Play(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_curtain01"), 0, "e002", true)
    else
      Motion.Object:Play(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_curtain01"), 0, "", true)
    end
  elseif gMapNum == 703 then
    local array = {
      "npc_1000",
      "npc_1001",
      "npc_1002",
      "npc_1003",
      "npc_1004",
      "npc_1005",
      "npc_1006",
      "npc_1007",
      "npc_1008",
      "npc_1009",
      "npc_1010",
      "npc_1011",
      "npc_1012",
      "npc_1013",
      "npc_1014",
      "npc_1015",
      "npc_1016",
      "npc_1017",
      "npc_1018",
      "npc_1019",
      "npc_1020",
      "npc_1021",
      "npc_1022",
      "npc_1023",
      "npc_1024",
      "npc_1025",
      "npc_1026",
      "npc_1027",
      "npc_1028",
      "npc_1029",
      "npc_1030",
      "npc_1031",
      "npc_1032"
    }
    for num = 1, #array do
      Obj:new(NPC, array[num]):Invisible()
    end
    Obj:new(OGIM, "eff_geko_01"):Invisible()
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 701 then
    if col_name == "evt_5000" then
    end
  elseif gMapNum == 702 then
    if col_name == "evt_0002" then
      require("S110_093")
      S110_093:Event_050()
    end
    if col_name == "evt_0003" then
      M360:Event_018()
      M360:Event_048()
    end
    if col_name == "evt_0004" then
      M360:Event_049()
    end
    if col_name == "evt_9001" then
    end
  elseif gMapNum == 703 then
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 701 then
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 702 and gim_id == 401 then
    GoToTheaterWithEvt()
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 701 then
    if gim_name == "acess_icon_01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      if Flg.Check("FLAG_MAIN_14_030", "FLAG_MAIN_15_015") then
        local tlk = Tlk:new("d07", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0701_0160_0010")
        tlk:EndTalk()
      else
        local tlk = Tlk:new("field_text", 1, true)
        tlk:StartTalk()
        tlk:Message("g_wm_0030_0010")
        tlk:EndTalk()
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_BLIMP")
        OpenWorldMap(DW, BLIMPMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_BLIMP")
      end
    end
    if gim_name == "ride_access_01" then
    elseif gim_name == "ride_access_02" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(701, "ride_start_02", "ride_landing_02a", "ride_landing_02b")
    elseif gim_name == "ride_access_03" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(701, "ride_start_03", "ride_landing_03a", "ride_landing_03b")
    elseif gim_name == "ride_access_04" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(701, "ride_start_04", "ride_landing_04a", "ride_landing_04b")
    elseif gim_name == "ride_access_05" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(701, "ride_start_05", "ride_landing_05a", "ride_landing_05b")
    elseif gim_name == "ride_access_06" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(701, "ride_start_06", "ride_landing_06a", "ride_landing_06b")
    elseif gim_name == "ride_access_07" then
      if Flg.Check("FLAG_MAIN_14_011", "FLAG_MAIN_14_012") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        M360:Event_014()
      else
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d07_GekoWarp(701, "ride_start_07", "ride_landing_07", "ride_landing_04a")
      end
    elseif gim_name == "ride_access_08" then
      if Flg.Check("FLAG_MAIN_14_040", "FLAG_MAIN_14_041") then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        M360:Event_046()
      else
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d07_GekoWarp(701, "ride_start_01", "ride_landing_01a", "ride_landing_01b")
      end
    end
  elseif gMapNum == 702 then
    if gim_name == "door_access_01" then
      Prcs_d0702_ThroughDoor()
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "door_access_01"), false)
    end
  elseif gMapNum == 703 then
    if gim_name == "ride_access_01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_01", "ride_landing_01a", "ride_landing_01b")
    elseif gim_name == "ride_access_02" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_02", "ride_landing_02a", "ride_landing_02b")
    elseif gim_name == "ride_access_03" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_03", "ride_landing_03a", "ride_landing_03b")
    elseif gim_name == "ride_access_04" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_04", "ride_landing_04a", "ride_landing_04b")
    elseif gim_name == "ride_access_05" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_05", "ride_landing_05a", "ride_landing_05b")
    elseif gim_name == "ride_access_06" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_06", "ride_landing_06a", "ride_landing_06b")
    elseif gim_name == "ride_access_07" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_07", "ride_landing_07a", "ride_landing_07b")
    elseif gim_name == "ride_access_08" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_08", "ride_landing_08a", "ride_landing_08b")
    elseif gim_name == "ride_access_09" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_09", "ride_landing_09a", "ride_landing_09b")
    elseif gim_name == "ride_access_10" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_10", "ride_landing_10a", "ride_landing_10b")
    elseif gim_name == "ride_access_11" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_11", "ride_landing_11", "ride_landing_11")
    elseif gim_name == "ride_access_12" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d07_GekoWarp(703, "ride_start_12", "ride_landing_08a", "ride_landing_08b")
    end
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
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
  if gMapNum == 701 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 702 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 703 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnCheckActModel(act)
end
