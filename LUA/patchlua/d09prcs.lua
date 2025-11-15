gGimText = "field_text"

function Prcs_d0901_ride_end()
  SetEnableCameraOperate(true)
  Motion.Player:ResetMoveAnim()
  M440:Event_508()
end

function Prcs_d09_GekoWarpMapChange()
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  local npc_geko = "npc0007"
  local cam_rot = 270
  local message1 = "f_d0902_0050_0010"
  local geko_index = GetIndex(NPC, npc_geko)
  Field.ObjectResetMotion(NPC, geko_index, 0)
  Obj:new(PLAYER, ""):Invisible()
  Obj:new(NPC, npc_geko):Invisible()
  Field.ObjectLoadMotion(NPC, geko_index, "bn01")
  Field.ObjectLoadMotion(NPC, geko_index, "ba01")
  Field.ObjectLoadMotion(NPC, geko_index, "fe01")
  Field.ObjectLoadMotion(NPC, geko_index, "fe04")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e017")
  Obj:new(PLAYER, ""):SetPos(-0.041, 0.299, 22.724)
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
  local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
  Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
  PlayerLookAtObject(NPC, npc_geko)
  local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
  Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot + 210, 0)
  vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 210)
  Field.ObjectSetPos(OGIM, GetIndex(OGIM, "eff_geko_01"), geko_pos.x + vector2d.x * 1, geko_pos.y, geko_pos.z + vector2d.z * 1)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
  PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
  PlaySE(200006, 100)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Obj:new(NPC, npc_geko):CancelInvisible(10)
  WaitFrame(30)
  Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, true)
  Obj:new(OGIM, "eff_geko_01"):CancelInvisible(5)
  WaitFrame(10)
  local tlk = Tlk:new("d09", 1, true)
  tlk:StartTalk()
  tlk:Message(message1)
  Field.ObjectPlayMotion(PLAYER, 1, "e017", 15, false)
  WaitFrame(10)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Field.ObjectResetMotion(PLAYER, 1, 0)
  Obj:new(NPC, npc_geko):Invisible(0)
  Obj:new(OGIM, "eff_geko_01"):Invisible(0)
  SetFollowerCameraOperateRotation(-10, obj1_to_obj2_rot - 5, 0)
  Cam.Inst:Clear(1)
  local fq02 = Motion.Object:new(NPC, npc_geko, "fq02")
  fq02:Play(15, true)
  Obj:new(NPC, npc_geko):SetPos(1.7, 0, 21.133, true)
  Obj:new(NPC, npc_geko):SetRotationY(-90, 0)
  Obj:new(NPC, npc_geko):CancelInvisible(0)
  tlk:EndTalk()
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d0903_JumpRide(start_loc, landing_loc, camrot_x, landing_height)
  PlayerObjectResetAim()
  WaitFrame(15)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
  local landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc))
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, landing_pos.x, landing_pos.z)
  if landing_height == "high" then
  elseif landing_height == "low" then
  elseif landing_height == "same" or landing_height == nil then
  end
  local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, landing_pos.x, landing_pos.z)
  SetFollowerCameraOperateRotation(5, obj1_to_obj2_rot + 200, 15)
  PlayerTurnToObject(OGIM, landing_loc, true, false, camrot_x, -25)
  WaitFrame(15)
  Field.PlayCameraAnimation("Cam_r03_in01", 15, LINEAR, true, true)
  Motion.Player:Play("r348_in01", 5, false)
  Field.ObjectShowAttachment(FLD_OBJ_PLAYER, 1, 1)
  Field.ObjectPlayAttachmentMotion(FLD_OBJ_PLAYER, 1, 1, "r348_in01", 5, false)
  WaitFrame(20)
  PlaySE(200027, 100)
  WaitFrame(17)
  Field.ObjectHideAttachment(FLD_OBJ_PLAYER, 1, 1)
  Field.ObjectShowAttachment(FLD_OBJ_PLAYER, 1, 2)
  Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, landing_pos.x, landing_pos.y, landing_pos.z)
  Motion.Player:Play("r348_out01", 5, false)
  Field.ObjectPlayAttachmentMotion(FLD_OBJ_PLAYER, 1, 2, "r348_out01", 5, false)
  WaitFrame(1)
  Field.PlayCameraAnimation("Cam_r03_out01", 5, LINEAR, true, true, 30, LINEAR)
  while Field.ObjectIsPlayingMotion(FLD_OBJ_PLAYER, 1, "r348_out01") do
    WaitFrame(1)
  end
  Field.ObjectHideAttachment(FLD_OBJ_PLAYER, 1, 2)
  local rot_y = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
  local rot_x = Field.GetCameraRotationX()
  SetFollowerCameraOperateRotation(rot_x, rot_y, 0)
  Field.CameraSwitchChange("followcam_default_loc", true)
  Field.FollowerWarp()
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d0903_JumpRideAccess(is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0001"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0002"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0003"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0004"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0005"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0006"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0007"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0008"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0009"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0010"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0011"), is_check)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "ride_whip_0012"), is_check)
end

function Prcs_d0903_DropNuts(gim_name)
  local aim_x, aim_y, aim_z = 0, 0, 0
  local pos_x, pos_y, pos_z = 0, 0, 0
  local dorop_f = 75
  local tlk = Tlk:new("d09", 1, true)
  Field_InvisibleFollowerAllPartyMember(1, 10, false)
  Field_InvisibleFollowerAllGuest(1, 10, false)
  if gim_name == "fa_shocknuts_correct" then
    Flg.Set("FLAG_GIMMICK_D09_210")
    aim_x, aim_y, aim_z = 13.08, 6.93, 78.01
    pos_x, pos_y, pos_z = 9.69, 10.15, 69.17
    Field.ObjectInvisible(OGIM, GetIndex(OGIM, "obj_beehive2"), 0, 30, true)
    local pos = Field.ObjectGetPosition(OGIM, GetIndex(OGIM, "obj_beehive2"))
    Field.PlayEffectScript("ef_f_com_300_sm", pos.x, pos.y, pos.z, 0, 3)
    tlk:StartTalk()
    tlk:MessageAuto("f_d0903_0045_0010", dorop_f + 10)
  elseif gim_name == "fa_firenuts_correct" then
    Flg.Set("FLAG_GIMMICK_D09_220")
    FieldObjectSync(NPC, true)
    aim_x, aim_y, aim_z = 16.392, 32.118, -3.615
    pos_x, pos_y, pos_z = 17.69, 41.054, -7.912
    tlk:StartTalk()
    tlk:MessageAuto("f_d0903_0025_0080", dorop_f + 10)
  elseif gim_name == "fa_icenuts_correct" then
    Flg.Set("FLAG_GIMMICK_D09_230")
    FieldObjectSync(NPC, true)
    aim_x, aim_y, aim_z = 53.91, 9.9, 67.07
    pos_x, pos_y, pos_z = 51.99, 17.47, 60.82
    tlk:StartTalk()
    tlk:MessageAuto("f_d0903_0035_0010", dorop_f + 10)
  elseif gim_name == "fa_beehive" then
    aim_x, aim_y, aim_z = 48.5, 4.22, 36.49
    pos_x, pos_y, pos_z = 52.07, 8.33, 44.88
    dorop_f = 60
    Field.ObjectInvisible(OGIM, GetIndex(OGIM, "obj_beehive"), 0, 30, true)
  end
  WaitFrame(dorop_f)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  if tlk:IsTalkStart() then
    tlk:EndTalk()
  end
  WaitFrame(5)
  if gim_name == "fa_shocknuts_correct" then
    Flg.Set("FLAG_GIMMICK_D09_210")
    Field.ObjectInvisible(OGIM, GetIndex(OGIM, "fa_shocknuts_correct"), 0, 0, true)
    Cam.Inst:Set(5.78, 78.84, 75.5, -0.6, 84.88, 80.27, default, 0)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy100"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy101"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy108"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy102"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy103"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy104"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy105"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy106"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy107"), false, true)
    Field.SymbolForceRespawn(GetIndex(ENEMY, "enemy108"), false, true)
    WaitFrame(30)
    local p_pos = Field.ObjectGetPosition(PLAYER, 1)
    local e1_pos = Field.ObjectGetPosition(ENEMY, GetIndex(ENEMY, "enemy100"))
    local e2_pos = Field.ObjectGetPosition(ENEMY, GetIndex(ENEMY, "enemy101"))
    local e3_pos = Field.ObjectGetPosition(ENEMY, GetIndex(ENEMY, "enemy102"))
    local e4_pos = Field.ObjectGetPosition(ENEMY, GetIndex(ENEMY, "enemy103"))
    local e5_pos = Field.ObjectGetPosition(ENEMY, GetIndex(ENEMY, "enemy104"))
    local y1 = Field.GetAngleToTarget2D(e1_pos.x, e1_pos.z, p_pos.x, p_pos.z)
    local y2 = Field.GetAngleToTarget2D(e2_pos.x, e2_pos.z, p_pos.x, p_pos.z)
    local y3 = Field.GetAngleToTarget2D(e3_pos.x, e3_pos.z, p_pos.x, p_pos.z)
    local y4 = Field.GetAngleToTarget2D(e4_pos.x, e4_pos.z, p_pos.x, p_pos.z)
    local y5 = Field.GetAngleToTarget2D(e5_pos.x, e5_pos.z, p_pos.x, p_pos.z)
    Field.ObjectSetRotationY(ENEMY, GetIndex(ENEMY, "enemy100"), y1, 15)
    Field.ObjectSetRotationY(ENEMY, GetIndex(ENEMY, "enemy101"), y2, 15)
    Field.ObjectSetRotationY(ENEMY, GetIndex(ENEMY, "enemy102"), y3, 15)
    Field.ObjectSetRotationY(ENEMY, GetIndex(ENEMY, "enemy103"), y4, 15)
    Field.ObjectSetRotationY(ENEMY, GetIndex(ENEMY, "enemy104"), y5, 15)
    WaitFrame(30)
    Field.ObjectPlayMotion(ENEMY, GetIndex(ENEMY, "enemy100"), "ba01", 15, false)
    Field.ObjectPlayMotion(ENEMY, GetIndex(ENEMY, "enemy101"), "ba01", 15, false)
    Field.ObjectPlayMotion(ENEMY, GetIndex(ENEMY, "enemy102"), "ba01", 15, false)
    Field.ObjectPlayMotion(ENEMY, GetIndex(ENEMY, "enemy103"), "ba01", 15, false)
    Field.ObjectPlayMotion(ENEMY, GetIndex(ENEMY, "enemy104"), "ba01", 15, false)
    Field.ObjectPlayMotion(ENEMY, GetIndex(ENEMY, "enemy108"), "ba01", 15, false)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  end
  Cam.Inst:Set(aim_x, aim_y, aim_z, pos_x, pos_y, pos_z, default, 0)
  FieldObjectSync(FOR_ALL, false)
  WaitFrame(5)
  if gim_name == "fa_shocknuts_correct" then
    Flg.Set("FLAG_GIMMICK_D09_250")
    M440:Event_668()
  end
  WaitFrame(10)
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  if gim_name == "fa_icenuts_correct" then
  end
  if gim_name == "fa_firenuts_correct" then
    M440:Event_638()
  end
  if gim_name == "fa_icenuts_correct" then
    M440:Event_648()
  end
  WaitFrame(30)
  Cam.Inst:Clear(0)
  Field_CancelInvisibleFollowerAllPartyMember(1, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(1, 30, false, true)
end

function Prcs_d0903_PickUpNuts(gim_name, attachment)
  Field.DisableMenu()
  Common.ProhibitSave()
  Field.SetProhibitAnywhereDigimonRide(true)
  Field.SetProhibitDigimonRide(true)
  Field.DisableAnalyzeAndFieldAttack()
  Flg.Set("FLAG_IS_CARRY_OBJECT")
  Field.ObjectLoadAttachment(PLAYER, 1, attachment)
  PlayerTurnToObject(OGIM, gim_name, true, false, 0, 0)
  Motion.Player:Play("fg02_d01", 0, false)
  WaitFrame(10)
  Field.ObjectInvisible(OGIM, GetIndex(OGIM, gim_name), 0, 30, true)
  WaitFrame(15)
  Field.ObjectShowAttachment(PLAYER, 1, attachment)
  Motion.Player:ChangeMoveAnim("hold", 3.5)
  local array = {
    "ride_whip_0001",
    "ride_whip_0002",
    "ride_whip_0003",
    "ride_whip_0004",
    "ride_whip_0005",
    "ride_whip_0006",
    "ride_whip_0007",
    "ride_whip_0008",
    "ride_whip_0009",
    "ride_whip_0010",
    "ride_whip_0011",
    "ride_whip_0012",
    "firenuts_correct",
    "icenuts_correct",
    "shocknuts_correct"
  }
  for no = 1, #array do
    Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, array[no]), false)
  end
end

function Prcs_d0903_PassNuts(attachment)
  Motion.Player:Play("fg02_d02", 0, false)
  WaitFrame(35)
  Field.ObjectHideAttachment(PLAYER, 1, attachment)
  Motion.Player:ResetMoveAnimWithBlend(15)
  WaitFrame(15)
  Flg.Clear("FLAG_IS_CARRY_OBJECT")
  Field.CancelDisableMenu()
  Common.CancelProhibitSave()
  Field.CancelDisableAnalyzeAndFieldAttack()
  Field.SetProhibitAnywhereDigimonRide(false)
  Field.SetProhibitDigimonRide(false)
  local array = {
    "ride_whip_0001",
    "ride_whip_0002",
    "ride_whip_0003",
    "ride_whip_0004",
    "ride_whip_0005",
    "ride_whip_0006",
    "ride_whip_0007",
    "ride_whip_0008",
    "ride_whip_0009",
    "ride_whip_0010",
    "ride_whip_0011",
    "ride_whip_0012",
    "firenuts_correct",
    "icenuts_correct",
    "shocknuts_correct"
  }
  for no = 1, #array do
    Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, array[no]), true)
  end
end

function Prcs_d0903_KeepNuts(attachment)
  Field.DisableMenu()
  Common.ProhibitSave()
  Field.SetProhibitAnywhereDigimonRide(true)
  Field.SetProhibitDigimonRide(true)
  Field.DisableAnalyzeAndFieldAttack()
  Flg.Set("FLAG_IS_CARRY_OBJECT")
  Field.ObjectLoadAttachment(PLAYER, 1, attachment)
  local array = {
    "ride_whip_0001",
    "ride_whip_0002",
    "ride_whip_0003",
    "ride_whip_0004",
    "ride_whip_0005",
    "ride_whip_0006",
    "ride_whip_0007",
    "ride_whip_0008",
    "ride_whip_0009",
    "ride_whip_0010",
    "ride_whip_0011",
    "ride_whip_0012",
    "firenuts_correct",
    "icenuts_correct",
    "shocknuts_correct"
  }
  for no = 1, #array do
    Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, array[no]), false)
  end
  Field.ObjectShowAttachment(PLAYER, 1, attachment)
  Motion.Player:ChangeMoveAnim("hold", 3.5)
end

function Prcs_d0903_ride_end()
  M440:Event_608()
  WaitFrame(15)
  Field.PlayerScriptDigimonRideEnd(true, "", 5)
  WaitFrame(20)
  SetEnableCameraOperate(true)
  M440:Event_610()
end

function Prcs_d0903_EventBeforFA()
  M440:Event_625()
end

function Prcs_d0904_WaterFlowStart(gim_name, landing_loc, rail_name, rail_direction)
  local RideDegiID = 145
  local r_flame = 15
  SetControlScriptExternalVariable("ride_rail", rail_name)
  SetControlScriptExternalVariable("rail_direction", rail_direction)
  local landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc))
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, landing_pos.x, landing_pos.z)
  if gim_name == "WaterFlow_Obverse01" then
    local tlk = Tlk:new("d09", 1, true)
    tlk:StartTalk()
    tlk:Message("f_d0904_0110_0010")
    tlk:EndTalk()
    Obj:new(NPC, "npc0040"):Invisible(15)
    Flg.Set("FLAG_GIMMICK_D09_270")
  elseif gim_name == "WaterFlow_Obverse02" then
    local tlk = Tlk:new("d09", 1, true)
    tlk:StartTalk()
    tlk:Message("f_d0904_0110_0030")
    tlk:EndTalk()
  elseif gim_name == "WaterFlow_Reverse01" then
    local tlk = Tlk:new("d09", 1, true)
    tlk:StartTalk()
    tlk:Message("f_d0904_0110_0020")
    tlk:EndTalk()
  elseif gim_name == "WaterFlow_Reverse02" then
    local tlk = Tlk:new("d09", 1, true)
    tlk:StartTalk()
    tlk:Message("f_d0904_0110_0040")
    tlk:EndTalk()
    Obj:new(NPC, "npc0041"):Invisible(15)
    Flg.Set("FLAG_GIMMICK_D09_270")
  end
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  SetFollowerCameraOperateRotation(5, rot, 30)
  PlayerTurnToObject(OGIM, landing_loc, true, false, 0, 0)
  WaitFrame(30)
  SetEnableCameraOperate(false)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Obverse01"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Obverse02"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Reverse01"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Reverse02"), false)
  Field.PlayerScriptDigimonRideStartFromID(145, true, "", 5)
  SetControlScriptExternalVariable("ride_submarimon", "riding")
  local se_slot = PlaySE(201002, 100)
  SetControlScriptExternalVariable("se_slot", se_slot)
end

function Prcs_d0904_WaterFlowEnd(degree_y)
  local se_slot = GetControlScriptExternalVariableNumber("se_slot")
  StopSE(se_slot, 15)
  SetControlScriptExternalVariable("ride_submarimon", "end")
  local ride_rail = GetControlScriptExternalVariableString("ride_rail")
  local rail_direction = GetControlScriptExternalVariableBool("rail_direction")
  Motion.Player:ResetMoveAnimWithBlend(5)
  Field.PlayerScriptDigimonRideEnd(true, "", 5)
  SetProhibitPlayerOnlyOperate(false)
  SetEnableCameraOperate(true)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Obverse01"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Obverse02"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Reverse01"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, "WaterFlow_Reverse02"), true)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  if ride_rail == "rail_move_001" and rail_direction == false then
    Obj:new(NPC, "npc0040"):CancelInvisible(15)
    Flg.Clear("FLAG_GIMMICK_D09_260")
    Flg.Clear("FLAG_GIMMICK_D09_270")
  elseif ride_rail == "rail_move_002" and rail_direction == true then
    Obj:new(NPC, "npc0041"):CancelInvisible(15)
    Flg.Set("FLAG_GIMMICK_D09_260")
    Flg.Clear("FLAG_GIMMICK_D09_270")
    M440:Event_755()
  end
end

function M440_Event_770()
  Flg.Set("FLAG_MAIN_22_420")
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  M440:Event_770()
end

function Prcs_d0905_ride_end()
  WaitFrame(15)
  Field.PlayerScriptDigimonRideEnd(true, "", 5)
  WaitFrame(20)
  SetEnableCameraOperate(true)
  M440:Event_785()
end

function Prcs_d0905_ThiefCaptured(num)
  if num == 1 then
    Flg.Set("FLAG_MAIN_22_451")
  elseif num == 2 then
    Flg.Set("FLAG_MAIN_22_452")
  elseif num == 3 then
    Flg.Set("FLAG_MAIN_22_453")
  elseif num == 4 then
    Flg.Set("FLAG_MAIN_22_454")
  elseif num == 5 then
    Flg.Set("FLAG_MAIN_22_455")
    M440:Event_795()
  end
end

function Prcs_d0905_WaitElv()
  WaitFrame(150)
end

function Prcs_d0906_FailureTowerDefense(enemy_num, rail_num)
  Prcs_d0906_AllEnemyLeave(enemy_num, 100, rail_num)
  Prcs_d0906_AllEnemyLeave(1, 200, 203)
  M440:Event_816()
end

function Prcs_d0906_CompletedTowerDefense(enemy_num, rail_num)
  Prcs_d0906_AllEnemyLeave(enemy_num, 100, rail_num)
  Prcs_d0906_AllEnemyLeave(1, 200, 203)
  M440:Event_819()
end

function Prcs_d0906_AllEnemyLeave(enemy_num, rail_start, rail_num)
  for rail_no = rail_start, rail_num do
    if rail_no == 100 then
      enemy_num = 2
    elseif rail_no == 101 then
      enemy_num = 2
    elseif rail_no == 102 then
      enemy_num = 3
    elseif rail_no == 103 then
      enemy_num = 3
    elseif rail_no == 104 then
      enemy_num = 2
    elseif rail_no == 105 then
      enemy_num = 2
    elseif rail_no == 200 then
      enemy_num = 1
    elseif rail_no == 201 then
      enemy_num = 1
    elseif rail_no == 203 then
      enemy_num = 1
    end
    for enemy_no = 1, enemy_num do
      local enemy_index = "enemy_" .. string.format("%d", rail_no) .. "_" .. string.format("%02d", enemy_no)
      local end_rail_pos_index = "end_rail_move_" .. string.format("%d", rail_no)
      local enemy = GetIndex(ENEMY, enemy_index)
      Field.SymbolForceLeave(enemy, true)
    end
  end
end

function Prcs_d0906_ChargeLvUp(lv)
  Flg.Clear("FLAG_GIMMICK_D09_040")
  if lv == 1 then
    M440:Event_817()
  elseif lv == 2 then
    M440:Event_818()
  end
  Flg.Set("FLAG_GIMMICK_D09_040")
end
