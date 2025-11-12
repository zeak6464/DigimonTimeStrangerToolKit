gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 901 then
    local index = GetIndex(OGIM, "obj_door_01")
    Field.ObjectLoadMotion(OGIM, index, "e001")
    Field.ObjectLoadMotion(OGIM, index, "e002")
  elseif load_map_num == 903 then
    Field.LoadEffectScript("ef_f_com_300_sm", 1)
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy003"), "fe02")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy004"), "fe02")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy005"), "fe02")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy006"), "fe02")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy007"), "fe02")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy006"), "fe01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy007"), "fe01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy100"), "ba01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy101"), "ba01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy102"), "ba01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy103"), "ba01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy104"), "ba01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy105"), "ba01")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "enemy108"), "ba01")
    local bakkas_index = GetIndex(NPC, "npc0001")
    Field.ObjectLoadMotion(NPC, bakkas_index, "fe01")
    Field.ObjectLoadMotion(NPC, bakkas_index, "fe02")
    Field.ObjectLoadMotion(NPC, bakkas_index, "bn01")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
  elseif load_map_num == 905 then
    obj_index = GetIndex(OGIM, "road01")
    Field.ObjectLoadMotion(OGIM, obj_index, "e001")
    Field.ObjectLoadMotion(OGIM, obj_index, "e002")
  elseif load_map_num == 906 then
    Field.ObjectLoadAttachment(NPC, GetIndex(NPC, "npc_0001"), 3)
    Field.ObjectLoadAttachment(NPC, GetIndex(NPC, "npc_0002"), 3)
    Field.LoadEffectScript("ef_f_com_300_sm", 1)
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d09_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 900 then
    Common.CancelProhibitSave()
    if Flg.Check("FLAG_MAIN_21_060", "FLAG_MAIN_22_015") then
      Obj:new(NPC, "npc0000"):Invisible()
    end
    if Flg.Check("FLAG_FIELD_D09_PROHIBIT_RIDE") then
      Field.CancelPlayerAnywhereDigimonRide(false, false)
      Field.SetProhibitAnywhereDigimonRide(true, true)
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
    end
  end
  if gMapNum == 901 then
    if Flg.Check("FLAG_MAIN_22_110") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_door_01"), 0, "e002")
      Obj:new(OGIM, "obj_door_01"):SetEnableCheckAndFieldAttack(false)
    end
    Obj:new(OGIM, "eff_geko_01"):Invisible()
    Obj:new(OGIM, "eff_geko_02"):Invisible()
    Obj:new(OGIM, "eff_geko_03"):Invisible()
    if Flg.Check("FLAG_MAIN_22_100", "FLAG_MAIN_22_120") then
      Obj:new(NPC, "npc0006"):Invisible()
    end
  end
  if gMapNum == 902 then
    Obj:new(NPC, "npc0007"):Invisible()
    Obj:new(OGIM, "eff_geko_01"):Invisible()
    Obj:new(NPC, "npc0005"):Invisible()
  end
  if gMapNum == 903 then
    if Flg.Check("FLAG_MAIN_22_290") then
      Obj:new(GIM, "d09blackwall")
    end
    if not Flg.Check("FLAG_MAIN_22_230") then
      Prcs_d0903_JumpRideAccess(false)
    else
      Prcs_d0903_JumpRideAccess(true)
    end
    if not Flg.Check("FLAG_MAIN_22_220") then
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_firenuts_correct"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_icenuts_correct"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_shocknuts_correct"), false)
    end
    if Flg.Check("FLAG_MAIN_22_220") then
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_firenuts_correct"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_icenuts_correct"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_shocknuts_correct"), false)
    end
    if Flg.Check("FLAG_MAIN_22_250") then
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_icenuts_correct"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_shocknuts_correct"), false)
    end
    if Flg.Check("FLAG_MAIN_22_270") then
      Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "fa_shocknuts_correct"), true)
    end
    if not Flg.Check("FLAG_MAIN_22_265") then
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy003"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy004"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy005"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy006"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy007"), true, FOREVER)
    end
    if not Flg.Check("FLAG_MAIN_22_270") then
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy008"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy009"), true, FOREVER)
    end
    if not Flg.Check("FLAG_GIMMICK_D09_210") then
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy100"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy101"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy108"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy102"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy103"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy104"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy105"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy106"), true, FOREVER)
      Field.SymbolForceLeave(GetIndex(ENEMY, "enemy107"), true, FOREVER)
    end
  end
  if gMapNum == 904 then
    if Flg.Check("FLAG_GIMMICK_D09_270") then
      Obj:new(NPC, "npc0040"):Invisible()
      Obj:new(NPC, "npc0041"):Invisible()
    elseif not Flg.Check("FLAG_GIMMICK_D09_260") and not Flg.Check("FLAG_GIMMICK_D09_270") then
      Obj:new(NPC, "npc0041"):Invisible()
    elseif Flg.Check("FLAG_GIMMICK_D09_260") and not Flg.Check("FLAG_GIMMICK_D09_270") then
      Obj:new(NPC, "npc0040"):Invisible()
    end
  end
  if gMapNum == 905 then
    if Flg.Check("FLAG_MAIN_22_460") then
      local pos = Field.GetLocatorPosition("gim_0004")
      local index = GetIndex(FLD_OBJ_NPC, "npc0002")
      Field.ObjectSetRotationY(FLD_OBJ_NPC, index, 180, 0)
      Field.ObjectSetPos(FLD_OBJ_NPC, index, pos.x, pos.y, pos.z + 1.2)
      Field.ObjectPlayMotion(FLD_OBJ_NPC, index, "f001", 5, true)
      local pos = Field.GetLocatorPosition("gim_0005")
      local index = GetIndex(FLD_OBJ_NPC, "npc0003")
      Field.ObjectSetRotationY(FLD_OBJ_NPC, index, 180, 0)
      Field.ObjectSetPos(FLD_OBJ_NPC, index, pos.x, pos.y, pos.z + 1.2)
      Field.ObjectLoadMotion(FLD_OBJ_NPC, index, "f001")
      Field.ObjectPlayMotion(FLD_OBJ_NPC, index, "f001", 5, true)
      obj_index = GetIndex(OGIM, "road01")
      Field.ObjectPlayMotion(OGIM, obj_index, "e002", 5, false)
    end
    if Flg.Check("FLAG_GIMMICK_D09_140") then
      Field_InvisibleFollowerAllGuest(1, 0, false)
      Field_InvisibleFollowerAllPartyMember(1, 0, false)
      Field.SetProhibitAnywhereDigimonRide(true)
    end
  end
  if gMapNum == 906 then
    Field.ObjectDisableCulling(FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_0002"))
    Common.LODEnable(false)
    Obj:new(OGIM, "enemy_gate02"):Invisible()
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 900 then
    if col_name == "evt_0001" then
      M440:Event_496()
    end
    if col_name == "evt_1000" or col_name == "evt_1002" then
      Field.CancelPlayerAnywhereDigimonRide(false, false)
      Field.SetProhibitAnywhereDigimonRide(true, true)
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Flg.Set("FLAG_FIELD_D09_PROHIBIT_RIDE")
    elseif col_name == "evt_1001" or col_name == "evt_1003" then
      Field.SetProhibitAnywhereDigimonRide(false, true)
      Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Flg.Clear("FLAG_FIELD_D09_PROHIBIT_RIDE")
    end
  elseif gMapNum == 901 then
    if col_name == "evt_0003" then
    end
    if col_name == "evt_0001" then
      M440:Event_520()
    end
    if col_name == "evt_0004" then
      M440:Event_515()
    end
  elseif gMapNum == 902 then
    if col_name == "evt_0001" then
      M440:Event_580()
    end
    if col_name == "evt_0002" then
      local tlk = Tlk:new("d09", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0902_0070_0010")
      MovePlayerToRelativePosFrame(0, 2, 20)
      tlk:EndTalk()
    end
  elseif gMapNum == 903 then
    if col_name == "evt_0002" then
      M440:Event_690()
    end
    if col_name == "evt_0003" then
      M440:Event_620()
    end
    if col_name == "evt_0005" then
      M440:Event_655()
    end
    if col_name == "evt_0006" then
      M440:Event_615()
      M440:Event_662()
    end
    if col_name == "evt_0007" then
      M440:Event_663()
    end
    if col_name == "evt_0008" then
      M440:Event_664()
    end
  elseif gMapNum == 904 then
    if col_name == "evt_0001" then
      M440:Event_720()
    end
    if col_name == "evt_0002" then
      M440:Event_730()
    end
    if col_name == "evt_0003" then
      M440:Event_740()
    end
    if col_name == "evt_0004" then
      M440:Event_750()
    end
    if col_name == "evt_0006" then
      M440:Event_760()
    end
    if col_name == "evt_0007" then
      M440:Event_775()
    end
    if col_name == "evt_0008" then
      Digimon.RestoreAllParty()
      SetControlScriptExternalVariable("player_walk", "start")
      Field.ObjectFrameMoveToTarget2D(PLAYER, 1, -34.627, -64.668, 6.5, 60)
      PlaySE(200006, 100)
      Fade_OutNoLoadingWithWait(FADE_WHITE, 10)
      WaitFrame(10)
      Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      MapChangeWithTimeTravel("d", 905, "start_00", AXIS_ORIGINAL, "P2028_daft_444", NOON)
    end
  elseif gMapNum == 905 then
    if col_name == "evt_0001" then
      if Flg.Check("FLAG_GIMMICK_D09_150") then
        MapChange("d", 905, "start_02", true, 0, 15)
      elseif Flg.Check("FLAG_GIMMICK_D09_160") then
        MapChange("d", 905, "start_03", true, 0, 15)
      elseif Flg.Check("FLAG_GIMMICK_D09_170") then
        MapChange("d", 905, "start_04", true, 0, 15)
      elseif Flg.Check("FLAG_GIMMICK_D09_180") then
        MapChange("d", 905, "start_05", true, 0, 15)
      elseif Flg.Check("FLAG_GIMMICK_D09_190") then
        MapChange("d", 905, "start_06", true, 0, 15)
      else
        MapChange("d", 905, "start_01", true, 0, 15)
      end
    end
    if col_name == "evt_0002" then
    end
    if col_name == "evt_0003" and Flg.Check("FLAG_MAIN_22_460") then
      Digimon.RestoreAllParty()
      Field.MovePlayerToRelativePosFrame(0, -15, 220)
      Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
      Flg.Set("FLAG_MAIN_22_470")
      M440:Event_805()
      SetControlScriptExternalVariable("player_walk", "start")
      Field.ObjectFrameMoveToTarget2D(PLAYER, 1, 0, -160, 6.5, 60)
      PlaySE(200006, 100)
      WaitFrame(10)
      Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
      MapChangeWithTimeTravel("d", 906, "start_00", AXIS_ORIGINAL, "P2028_daft_445", NOON)
    end
    if col_name == "evt_5000" then
      Field_CancelInvisibleFollowerAllGuest(1, 15, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(1, 15, false, false, false)
      Flg.Clear("FLAG_GIMMICK_D09_140")
      Field.SetProhibitAnywhereDigimonRide(false)
      Flg.Clear("FLAG_GIMMICK_D09_150")
      Flg.Clear("FLAG_GIMMICK_D09_160")
      Flg.Clear("FLAG_GIMMICK_D09_170")
      Flg.Clear("FLAG_GIMMICK_D09_180")
      Flg.Clear("FLAG_GIMMICK_D09_190")
    end
    if col_name == "evt_5001" then
      Field_InvisibleFollowerAllGuest(1, 15, false)
      Field_InvisibleFollowerAllPartyMember(1, 15, false)
      Flg.Set("FLAG_GIMMICK_D09_140")
      Field.CancelPlayerAnywhereDigimonRide()
      Field.SetProhibitAnywhereDigimonRide(true)
    end
    if col_name == "evt_1000" or col_name == "evt_1013" then
      Flg.Clear("FLAG_GIMMICK_D09_150")
      Flg.Clear("FLAG_GIMMICK_D09_160")
      Flg.Clear("FLAG_GIMMICK_D09_170")
      Flg.Clear("FLAG_GIMMICK_D09_180")
      Flg.Clear("FLAG_GIMMICK_D09_190")
    end
    if col_name == "evt_1001" or col_name == "evt_1003" then
      Flg.Set("FLAG_GIMMICK_D09_150")
      Flg.Clear("FLAG_GIMMICK_D09_160")
      Flg.Clear("FLAG_GIMMICK_D09_170")
      Flg.Clear("FLAG_GIMMICK_D09_180")
      Flg.Clear("FLAG_GIMMICK_D09_190")
    end
    if col_name == "evt_1004" or col_name == "evt_1002" or col_name == "evt_1006" or col_name == "evt_1007" or col_name == "evt_1012" then
      Flg.Clear("FLAG_GIMMICK_D09_150")
      Flg.Set("FLAG_GIMMICK_D09_160")
      Flg.Clear("FLAG_GIMMICK_D09_170")
      Flg.Clear("FLAG_GIMMICK_D09_180")
      Flg.Clear("FLAG_GIMMICK_D09_190")
    end
    if col_name == "evt_1005" or col_name == "evt_1008" then
      Flg.Clear("FLAG_GIMMICK_D09_150")
      Flg.Clear("FLAG_GIMMICK_D09_160")
      Flg.Set("FLAG_GIMMICK_D09_170")
      Flg.Clear("FLAG_GIMMICK_D09_180")
      Flg.Clear("FLAG_GIMMICK_D09_190")
    end
    if col_name == "evt_1009" or col_name == "evt_1010" then
      Flg.Clear("FLAG_GIMMICK_D09_150")
      Flg.Clear("FLAG_GIMMICK_D09_160")
      Flg.Clear("FLAG_GIMMICK_D09_170")
      Flg.Set("FLAG_GIMMICK_D09_180")
      Flg.Clear("FLAG_GIMMICK_D09_190")
    end
    if col_name == "evt_1011" then
      Flg.Clear("FLAG_GIMMICK_D09_150")
      Flg.Clear("FLAG_GIMMICK_D09_160")
      Flg.Clear("FLAG_GIMMICK_D09_170")
      Flg.Clear("FLAG_GIMMICK_D09_180")
      Flg.Set("FLAG_GIMMICK_D09_190")
    end
    if col_name == "evt_0004" then
      M440:Event_800()
    end
  elseif gMapNum == 906 then
    if col_name == "evt_0001" then
      M440:Event_830()
    end
    if col_name == "evt_0002" then
      M440:Event_810()
      M440:Event_815()
    end
    if col_name == "evt_0003" then
      M440:Event_825()
    end
    if col_name == "evt_0004" then
      M440:Event_827()
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 900 then
  elseif gMapNum == 901 then
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 902 then
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 903 then
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 904 then
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 905 then
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 906 then
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum ~= 907 or gim_name == "theater_0001" then
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 900 then
  elseif gMapNum == 901 then
    if gim_name == "obj_door_01" then
      M440:Event_510()
    end
  elseif gMapNum == 902 then
  elseif gMapNum == 903 then
    if gim_name == "d09blackwall_col" then
      local tlk = Tlk:new("d09", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0903_0400_0010")
      tlk:Message("f_d0903_0400_0020")
      tlk:EndTalk()
    end
    if gim_name == "firenuts_correct" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject(gim_name)
      M440:Event_630()
    end
    if gim_name == "icenuts_correct" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject(gim_name)
      M440:Event_650()
    end
    if gim_name == "windnuts_correct" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject(gim_name)
    end
    if gim_name == "shocknuts_correct" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject(gim_name)
      M440:Event_670()
    end
    if gim_name == "ride_whip_0001" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0001", "ride_whiplanding_0001", 5, "same")
    elseif gim_name == "ride_whip_0002" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0002", "ride_whiplanding_0002", 5, "same")
      M440:Event_649()
    elseif gim_name == "ride_whip_0003" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0003", "ride_whiplanding_0003", 5, "same")
    elseif gim_name == "ride_whip_0004" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0004", "ride_whiplanding_0004", 5, "same")
    elseif gim_name == "ride_whip_0005" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0005", "ride_whiplanding_0005", 5, "same")
    elseif gim_name == "ride_whip_0006" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0006", "ride_whiplanding_0006", 5, "same")
    elseif gim_name == "ride_whip_0007" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0007", "ride_whiplanding_0007", 5, "same")
    elseif gim_name == "ride_whip_0008" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0008", "ride_whiplanding_0008", 5, "same")
    elseif gim_name == "ride_whip_0009" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0009", "ride_whiplanding_0009", 5, "same")
    elseif gim_name == "ride_whip_0010" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0010", "ride_whiplanding_0010", 5, "same")
    elseif gim_name == "ride_whip_0011" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0011", "ride_whiplanding_0011", 5, "same")
    elseif gim_name == "ride_whip_0012" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0903_JumpRide("ride_whip_0012", "ride_whiplanding_0012", 5, "same")
    end
  elseif gMapNum == 904 then
    if gim_name == "WaterFlow_Obverse01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0904_WaterFlowStart(gim_name, "WaterFlow_Reverse01", "rail_move_001", true)
    elseif gim_name == "WaterFlow_Obverse02" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0904_WaterFlowStart(gim_name, "WaterFlow_Reverse02", "rail_move_002", true)
    elseif gim_name == "WaterFlow_Reverse01" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0904_WaterFlowStart(gim_name, "WaterFlow_Obverse01", "rail_move_001", false)
    elseif gim_name == "WaterFlow_Reverse02" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0904_WaterFlowStart(gim_name, "WaterFlow_Obverse02", "rail_move_002", false)
    end
  elseif gMapNum == 905 then
  elseif gMapNum == 906 then
  elseif gMapNum == 907 then
    if gim_name == "theater_access" then
      Obj:new(OGIM, "col_stop01"):Invisible()
      Obj:new(OGIM, "col_stop02"):Invisible()
      GoToTheaterWithEvt()
      Obj:new(OGIM, "col_stop01"):CancelInvisible()
      Obj:new(OGIM, "col_stop02"):CancelInvisible()
    end
    if gim_name == "npc_0013_access" then
      M440:Event_860()
    end
    if gim_name == "npc_0014_access" then
      local npc_index01 = GetIndex(NPC, "npc_0014")
      Field.ObjectLoadMotion(NPC, npc_index01, "fn01_01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e012")
      Field.ObjectLoadMotion(NPC, npc_index01, "e013")
      Field.ObjectLoadMotion(NPC, npc_index01, "e008")
      Field.ObjectLoadMotion(NPC, npc_index01, "e005_01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e007_01")
      Field.ObjectSuspendAutoTransparent(NPC, npc_index01, AUTO_TRANSPARENT_TYPE_ALL)
      local npc_index02 = GetIndex(NPC, "npc_0013")
      Field.ObjectLoadMotion(NPC, npc_index02, "fn01_01")
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Cam.Inst:Set(7.681, 0, -18.547, 7.88, 1.53, -8.667, default, 30)
      WaitFrame(45)
      Field.ObjectPlayMotion(NPC, npc_index01, "e013", 10, true)
      Message("f_d0907_0100_0010")
      Field.ObjectPlayMotion(NPC, npc_index01, "e008", 10, true)
      Message("f_d0907_0100_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e005_01", 10, true)
      Message("f_d0907_0100_0030")
      Field.ObjectPlayMotion(NPC, npc_index01, "e007_01", 10, true)
      Message("f_d0907_0100_0040")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "e012", 10, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Field_Talk_End_Not_LetterBox()
    end
    if gim_name == "npc_0004_access" then
      local npc_index01 = GetIndex(NPC, "npc_0004")
      local npc_index02 = GetIndex(NPC, "npc_0007")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "br01")
      Field.ObjectLoadMotion(NPC, npc_index01, "e002")
      Field.ObjectLoadMotion(NPC, npc_index01, "e008")
      Field.ObjectLoadMotion(NPC, npc_index02, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index02, "br01")
      Field.ObjectLoadMotion(NPC, npc_index02, "e002")
      Field.ObjectLoadMotion(NPC, npc_index02, "e008")
      Field.ObjectLoadMotion(NPC, npc_index02, "e006")
      PlayerTurnToObject(OGIM, "npc_0004_access", true, false, 0, 0)
      Cam.Inst:Set(-31.621, 3.199, -7.795, -31.476, 1.373, 2.035, default, 30)
      Field.ObjectLookAtTheObject(NPC, npc_index01, NPC, npc_index02, 30, 2)
      Field.ObjectLookAtTheObject(NPC, npc_index02, NPC, npc_index01, 30, 2)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_index02, 30, 2)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "e002", 10, true)
      Message("f_d0907_0010_0010")
      Field.ObjectPlayMotion(NPC, npc_index02, "e006", 10, true)
      Message("f_d0907_0010_0020")
      Message("f_d0907_0010_0030")
      Field.ObjectPlayMotion(NPC, npc_index02, "e008", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index01, "e008", 10, true)
      Message("f_d0907_0010_0040")
      Field.ObjectPlayMotion(NPC, npc_index02, "e002", 10, true)
      Message("f_d0907_0010_0050")
      Message("f_d0907_0010_0060")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "e008", 10, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Field_Talk_End_Not_LetterBox()
    end
    if gim_name == "npc_0006_access" then
      local npc_index01 = GetIndex(NPC, "npc_0006")
      Field.ObjectLoadMotion(NPC, npc_index01, "e503")
      Field.ObjectLoadMotion(NPC, npc_index01, "e504")
      PlayerTurnToObject(OGIM, "npc_0006_access", true, false, 0, 0)
      Cam.Inst:Set(-16.61, 0.85, -6.234, -18.469, 2.729, 3.41, default, 30)
      Field.ObjectLookAtTheObject(NPC, npc_index01, PLAYER, 1, 30, 2)
      START_PlAYER_AND_NPC_TALK_ACTION(gim_name)
      Field_Talk_Start_Not_LetterBox("d09", 1)
      Message("f_d0907_0030_0010")
      Message("f_d0907_0030_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e504", 10, true)
      Message("f_d0907_0030_0030")
      MessageClose()
      Field.ObjectPlayMotion(NPC, npc_index01, "e503", 10, true)
      END_PLAYER_AND_NPC_TALK_ACTION(gim_name)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Field_Talk_End_Not_LetterBox()
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
  if gMapNum == 901 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
  if gMapNum == 902 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
  if gMapNum == 903 then
    if gim_tag == "fa_nuts" then
      if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
        BreakFieldAttackGim(gim_name, true)
        if gim_name == "fa_firenuts_correct" then
          Prcs_d0903_DropNuts(gim_name)
          Qst.Main:Set(M440.ID, M440.STEP_025)
        elseif gim_name == "fa_icenuts_correct" then
          Prcs_d0903_DropNuts(gim_name)
          Qst.Main:Set(M440.ID, M440.STEP_040)
        elseif gim_name == "fa_windnuts_correct" then
          Prcs_d0903_DropNuts(gim_name)
          Qst.Main:Set(M440.ID, M440.STEP_055)
        elseif gim_name == "fa_shocknuts_correct" then
          Prcs_d0903_DropNuts(gim_name)
          Qst.Main:Set(M440.ID, M440.STEP_075)
        end
      end
    elseif gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      if gim_name == "fa_beehive" then
        Field.ObjectPlayMotionAndSetting(OGIM, GetIndex(OGIM, "nuts_on_beehive"), "e001", 0, 57, 57, 90, 0.8, false)
        Prcs_d0903_DropNuts(gim_name)
        Qst.Main:Set(M440.ID, M440.STEP_060)
      end
    end
  end
  if gMapNum == 904 and gim_tag == "fa_obj" then
    if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_01" then
      M440:Event_735()
    end
    if gim_name == "fa_obstacles_05" then
      M440:Event_765()
    end
  end
end

function OnCheckActModel(act)
end
