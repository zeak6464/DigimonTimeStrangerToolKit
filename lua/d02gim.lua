gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 201 then
    AddLoadList(FLD_OBJ_NPC, {
      "outlaw",
      motion = {"fq01", "fe02"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "bakemon001",
      motion = {"ba01", "bn01"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "bakemon002",
      motion = {"ba01", "bn01"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "bakemon003",
      motion = {"ba01", "bn01"}
    })
  elseif load_map_num == 202 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"door"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e002"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "outlaw",
      motion = {"fq01", "fe02"}
    })
  elseif load_map_num == 204 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"door"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
  elseif load_map_num == 205 then
  elseif load_map_num == 206 then
  elseif load_map_num == 207 then
  elseif load_map_num == 209 then
  elseif load_map_num == 210 then
  elseif load_map_num == 211 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 217 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001", "e002"}
    })
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if Flg.Check("FLAG_IS_FLIGHT_RIDE") then
    StartRideFly(false, "", 0)
  else
    Field.CancelPlayerFixedMaxSpeed()
  end
  PlayerObjectResetAim()
  if gMapNum == 201 then
    if Flg.Check("FLAG_GIMMICK_D02_440") then
      Obj:new(FLD_OBJ_LOCATOR, "change_9999"):Invisible()
    end
    if not Flg.Check("FLAG_COLLAPSE_d02") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0006"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0007"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0014"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0003"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0005"):CancelInvisible()
    elseif Flg.Check("FLAG_COLLAPSE_d02") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0003"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0005"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0015"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Field.DisableSystemLadder()
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall01"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall02"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall03"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall04"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall05"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall06"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall07"))
      Field.ObjectInvisible(NPC, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(FLD_OBJ_POP_POINT, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Field_InvisibleFollowerAllPartyMember(1, 0, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon01"), 1, 0, true, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon02"), 1, 0, true, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon03"), 1, 0, true, false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0003"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0004"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0005"):SetEnableCheckAndFieldAttack(false)
      if Flg.Check("FLAG_MAIN_22_517") then
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_01"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_02"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_03"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_04"), true, FOREVER)
      end
    end
  elseif gMapNum == 202 then
    if Qst.Main:Check(M120.ID, M120.STEP_001, M120.STEP_015) then
      Obj:new(NPC, "npc_0013"):Invisible()
    end
    if not Flg.Check("FLAG_MAIN_03_520") then
      Obj:new(RUMOR_NPC, "guide_lunamon"):Invisible()
      Obj:new(RUMOR_NPC, "guide_lunamon2"):Invisible()
      SetControlScriptExternalVariable("Rumer_state", "invisible")
    end
    if not Flg.Check("FLAG_MAIN_03_522") then
      SetControlScriptExternalVariable("Rumer_state2", "invisible")
    end
    if not Flg.Check("FLAG_MAIN_03_520") then
    end
    SetControlScriptExternalVariable("Party_state", "display")
    if Flg.Check("FLAG_GIMMICK_D02_460") then
      SetEnableGimmickCheck("gim_0006", false)
      SetEnableGimmickCheck("gim_0005", true)
    else
      SetEnableGimmickCheck("gim_0006", true)
      SetEnableGimmickCheck("gim_0005", false)
    end
    if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_199") then
    else
      Field.LinkColOff("mapborder_3")
    end
  elseif gMapNum == 203 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
    if Flg.Check("FLAG_SUB_200_148_002", "FLAG_IS_CLEAR_S200_148") then
      Motion.Object:new(NPC, "s200_148_003", "fe02"):Play(10, true)
    elseif not Flg.Check("FLAG_SUB_200_148_004") then
      Obj:new(NPC, "s200_148_003"):SetIcon(ICO_NONE)
    end
    if Flg.Check("FLAG_SUB_200_148_003", "FLAG_IS_CLEAR_S200_148") then
      Motion.Object:new(NPC, "s200_148_004", "fe02"):Play(10, true)
    elseif not Flg.Check("FLAG_SUB_200_148_004") then
      Obj:new(NPC, "s200_148_004"):SetIcon(ICO_NONE)
    end
  elseif gMapNum == 204 then
    Field.PlayerLoadMoveAnimation("door")
    if Flg.Check("FLAG_GIMMICK_D02_430") then
      SetEnableGimmickCheck("gim_0001", false)
      Motion.Gimmick:PlayFinishedAnim("gim_0001", "e001")
      ColOff("wall_cl_0001")
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Field.ObjectInvisible(NPC, FOR_ALL, 0, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Obj:new(NPC, "npc_900"):CancelInvisible()
      Obj:new(NPC, "npc_904"):CancelInvisible()
      Obj:new(NPC, "npc_905"):CancelInvisible()
      Obj:new(NPC, "npc_906"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):SetEnableCheckAndFieldAttack(false)
    elseif Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_555") then
      Field.ObjectInvisible(NPC, FOR_ALL, 0, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Obj:new(NPC, "npc_901"):CancelInvisible()
      Obj:new(NPC, "npc_902"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):SetEnableCheckAndFieldAttack(false)
    end
  elseif gMapNum == 205 then
    Field.MinimapDisplayHeight(20, 5)
  elseif gMapNum == 206 then
  elseif gMapNum == 207 then
  elseif gMapNum == 208 then
  elseif gMapNum == 209 then
  elseif gMapNum == 210 then
  elseif gMapNum == 211 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 212 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 213 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
    if Flg.Check("FLAG_IS_CHECK_D0213_DOLL_4") then
      Motion.NPC:Play("chr001_hide", "bn01", 0, true)
    else
      Flg.Clear("FLAG_IS_CHECK_D0213_DOLL_4")
      Flg.Clear("FLAG_IS_CHECK_D0213_DOLL_2")
      Flg.Clear("FLAG_IS_CHECK_D0213_DOLL_3")
    end
  elseif gMapNum == 215 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 216 then
  elseif gMapNum == 217 and not Flg.Check("FLAG_GIMMICK_D02_455") then
    SetEnableGimmickCheck("theater_0001", false)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 201 then
    if col_name == "evt_0001" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_0002" then
    end
    if col_name == "evt_3500" then
    end
    if col_name == "evt_3501" then
    end
    if col_name == "evt_3502" then
    end
    if col_name == "evt_3503" and Flg.Check("FLAG_MAIN_13_146", "FLAG_MAIN_13_153") then
      Field_InvisibleFollowerAllPartyMember(3503, 0, false)
      MovePlayerToLocatorFrame("gim_0005", 20)
      SetPlayerRotationByLocator("gim_0005", 5)
    end
    if col_name == "evt_4000" then
    end
    if col_name == "evt_6000" then
    end
    if col_name == "evt_4001" then
    end
    if col_name ~= "evt_6001" or Flg.Check("FLAG_MAIN_10_000", "FLAG_MAIN_10_001") then
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    elseif col_name == "evt_9901" then
    elseif col_name == "evt_9903" then
    end
  elseif gMapNum == 202 then
    if col_name == "evt_3000" and not Flg.Check("FLAG_MAIN_03_640") then
      local talk = Tlk:new("d02")
      talk:StartTalkActionAndZoom("npc_0005")
      talk:Message("f_d0202_0170_0010")
      talk:EndActionAndZoom()
      Field.MovePlayerToRelativePosFrame(2, 0, 30)
      talk:EndTalk()
    end
    if col_name == "evt_3009" and not Flg.Check("FLAG_MAIN_03_640") then
      local talk = Tlk:new("d02")
      talk:StartTalkActionAndZoom("npc_0803")
      talk:Message("f_d0202_0170_0010")
      talk:EndActionAndZoom()
      Field.MovePlayerToRelativePosFrame(1, 3, 30)
      talk:EndTalk()
    end
    if col_name == "evt_9000" and Field.IsPlayerScriptDigimonRiding() == true then
      Flg.Clear("FLAG_IS_FLIGHT_RIDE")
      ColOff("cliff_cl_3000")
      MovePlayerToLocatorFrame("ride_fly_0003", 20)
      ColOn("cliff_cl_3000")
      Field.FollowerWarp()
      EndRide(true, "ride_fly_0003", 30)
    end
    if col_name == "evt_9001" or col_name == "evt_9004" or col_name == "evt_9006" then
      MiniMapChange(MAP_LAYER_LOW)
    elseif col_name == "evt_9002" or col_name == "evt_9003" or col_name == "evt_9005" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_1000" or col_name == "evt_1001" or col_name == "evt_1002" then
      local Party_state = GetControlScriptExternalVariableString("Party_state")
      if Party_state == "invisible" then
        Field.FollowerWarp()
        SetControlScriptExternalVariable("Party_state", "display")
      end
    end
    if Flg.Check("FLAG_MAIN_03_525") then
      if col_name == "evt_1000" then
        SetEnableGimmickCheck("gim_0006", false)
        SetEnableGimmickCheck("gim_0005", true)
      elseif col_name == "evt_1001" or col_name == "evt_1002" then
        SetEnableGimmickCheck("gim_0006", true)
        SetEnableGimmickCheck("gim_0005", false)
      end
    end
    if col_name == "evt_3008" then
    end
  elseif gMapNum == 204 then
    if col_name == "evt_0001" then
    end
    if col_name == "evt_0003" then
    end
    if col_name == "evt_0004" then
    end
  elseif gMapNum == 205 then
  elseif gMapNum == 206 then
  elseif gMapNum == 207 then
  elseif gMapNum == 208 then
  elseif gMapNum == 209 then
  elseif gMapNum == 210 then
  end
  if gMapNum == 216 then
  end
  if gMapNum == 217 then
    if col_name == "evt_0001" then
    end
    if col_name == "evt_0003" then
      M120:Event_PlayableBoss_Start()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9902" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9903" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 201 then
  end
  if gMapNum == 203 then
  end
  if gMapNum == 206 then
  end
  if gMapNum == 210 then
  end
  if gMapNum == 216 then
  end
  if gMapNum == 217 and gim_name == "flyer_access01" then
    PlayerLookAtGimmickObject(gim_name)
    local tlk = Tlk:new("d02", 1, true, false)
    tlk:StartTalk()
    tlk:Message("f_d0202_0780_0010")
    tlk:Message("f_d0202_0780_0020")
    tlk:Message("f_d0202_0780_0030")
    tlk:EndTalk()
  end
  if gMapNum == 217 then
  elseif gMapNum == 202 then
  elseif gMapNum == 216 then
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 201 then
    if gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "", true, "gim_8001")
      DoorMapChange("d", 213, "start_00")
    elseif gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "", true, "gim_8000")
      DoorMapChange("d", 211, "start_00")
    elseif gim_id == 402 then
      OpenDoor(gim_loc, "", true, "gim_8002")
      DoorMapChange("d", 212, "start_00")
    elseif gim_id == 403 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "", true, "gim_8003")
      DoorMapChange("d", 203, "start_00")
    elseif gim_id == 404 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0201_1240_0010")
      Field_Talk_End_Not_LetterBox()
    elseif gim_id == 405 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      MapChange("d", 216, "start_00", true, 0, 15)
    end
  elseif gMapNum == 202 then
    if gim_id == 5 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      SetControlScriptExternalVariable("Party_state", "invisible")
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      ColOff("cliff_cl_0002")
      Cam.Inst:Set(-29.997, 2.115, -5.778, -29.97, 3.119, 4.182, DEFAULT_ANGLE, 30)
      SetFollowerCameraOperateRotation(5, 0, 15)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      Field.MovePlayerToLocatorFrame("sp_0001", 30)
      WaitFrame(30)
      Field.MovePlayerToLocatorFrame("sp_0002", 15)
      WaitFrame(15)
      Motion.Player:ResetMoveAnimWithBlend(15)
      Field.MovePlayerToLocatorFrame("sp_0003", 45)
      WaitFrame(15)
      Cam.Inst:Set(-29.997, 2.015, -5.778, -30.3, 3.219, 1.75, DEFAULT_ANGLE, 30)
      WaitFrame(30)
      Cam.Inst:Clear(30)
      Flg.Clear("FLAG_GIMMICK_D02_460")
      SetEnableGimmickCheck("gim_0006", true)
      SetEnableGimmickCheck("gim_0005", false)
      ColOn("cliff_cl_0002")
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 30, false, true)
    end
    if gim_id == 6 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      SetControlScriptExternalVariable("Party_state", "invisible")
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      ColOff("cliff_cl_0002")
      Cam.Inst:Set(-30.96, 2.115, 10.747, -30.51, 3.119, 0.797, DEFAULT_ANGLE, 30)
      SetFollowerCameraOperateRotation(0, 180, 15)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      Field.MovePlayerToLocatorFrame("sp_0001", 30)
      WaitFrame(30)
      Field.MovePlayerToLocatorFrame("sp_0004", 15)
      WaitFrame(15)
      Motion.Player:ResetMoveAnimWithBlend(15)
      Field.MovePlayerToLocatorFrame("sp_0005", 45)
      WaitFrame(15)
      Cam.Inst:Set(-30.96, 2.015, 10.747, -30.01, 3.219, 3.297, DEFAULT_ANGLE, 30)
      WaitFrame(30)
      Cam.Inst:Clear(30)
      Flg.Set("FLAG_GIMMICK_D02_460")
      SetEnableGimmickCheck("gim_0006", false)
      SetEnableGimmickCheck("gim_0005", true)
      ColOn("cliff_cl_0002")
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 30, false, true)
    end
    if gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0202_AreaChangeGim()
    elseif gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "", true, "gim_8000")
      DoorMapChange("d", 215, "start_00")
    elseif gim_id == 402 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      ColOff("cliff_cl_0001")
      local loc_pos = Field.GetLocatorPosition("change_0003")
      local loc_rot = Field.GetLocatorRotationYDegree("change_0003")
      local player = Obj:new(PLAYER, "")
      loc_rot = loc_rot - 90
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      Field.SetFollowerCameraOperateRotationY(loc_rot, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      Field.SetFollowerCameraOperateRotationX(0, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      WaitFrame(10)
      local dis_x = math.abs(loc_pos.x - player.pos.x)
      local dis_z = math.abs(loc_pos.z - player.pos.z)
      if 0.15 <= dis_x and 0.15 <= dis_z then
        local move_pos_x = -32.01
        local move_pos_z = 18.267
        local move_point_x = move_pos_x - player.pos.x
        local move_point_z = move_pos_z - player.pos.z
        MovePlayerToRelativePosFrame(move_point_x, move_point_z, 20)
      end
      WaitFrame(20)
      player:SetRotationY(loc_rot, 10)
      WaitFrame(7)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      MovePlayerFrame(-90, 0.75, 45)
      WaitFrame(30)
      MapChange("d", 217, "start_00", true, 0, 15)
    elseif gim_id == 403 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 203 then
  elseif gMapNum == 204 then
    if gim_id == 1 then
      local npc_1001 = Obj:new(NPC, "npc_1001")
      Field.StartPlayerAndNpcTalkAction("npc_1001")
      Cam.Inst:Set(0.334, 0.849, -9.089, 0.744, 2.297, -1.486, DEFAULT_ANGLE, 30)
      Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "npc_1001"), PLAYER, 1, 30)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0204_0040_0010")
      END_TALK_ACTION_AND_ZOOM("npc_1001", true, true)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(15)
      WaitFrame(15)
      Field.ObjectResetAim(NPC, GetIndex(NPC, "npc_1001"), 10)
    end
    if gim_id == 400 then
      Prcs_d0204_AreaChangeGim()
    end
  elseif gMapNum == 205 then
  elseif gMapNum == 206 then
  elseif gMapNum == 207 then
  elseif gMapNum == 208 then
  elseif gMapNum == 209 then
  elseif gMapNum == 210 then
  elseif gMapNum == 211 then
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
        if not Flg.Check("FLAG_IS_CHECK_D0211_ICEBOX") then
          Prcs_d0211_CheckFridge()
        else
          Field_Talk_Start_Not_LetterBox("d02", 1)
          Message("f_d0211_0020_0010")
          Field_Talk_End_Not_LetterBox()
        end
      elseif Common.CheckTimeAxis("A2028_daft_200", "A2028_daft_450") then
        if not Flg.Check("FLAG_IS_CHECK_D0211_ICEBOX_01") then
          Prcs_d0211_CheckFridge()
        else
          Field_Talk_Start_Not_LetterBox("d02", 1)
          Message("f_d0211_0050_0020")
          Field_Talk_End_Not_LetterBox()
        end
      end
    end
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      MapChange("d", 201, "start_02", true, 0, 15)
    end
  elseif gMapNum == 212 then
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      MapChange("d", 201, "start_03", true, 0, 15)
    end
  elseif gMapNum == 213 then
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      MapChange("d", 201, "start_06", true, 0, 15)
    end
  elseif gMapNum == 215 then
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      Motion.Gimmick:Play("obj_0001", "e001", false)
      Motion.Gimmick:WaitFrame("obj_0001", "e001", 0)
      Motion.Gimmick:Play("obj_0001", "e002", false)
    end
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0020_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 3 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0070_0010")
      MessageClose()
      MessageTalkSel(2, "f_d0215_0070_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Message("f_d0215_0070_0030")
        MessageClose()
        MessageTalkSel(2, "f_d0215_0070_0040")
        result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_d0215_0070_0050")
          MessageClose()
          MessageTalkSel(2, "f_d0215_0070_0060")
          result = Talk.GetResultSelectedNum()
          if result == RESULT_TALK00 then
            Message("f_d0215_0070_0070")
            MessageClose()
            MessageTalkSel(2, "f_d0215_0070_0080")
            result = Talk.GetResultSelectedNum()
            if result == RESULT_TALK00 then
              Message("f_d0215_0070_0090")
              Message("f_d0215_0070_0100")
              MessageClose()
              WaitFrame(20)
              Message("f_d0215_0070_0110")
              Field_Talk_End_Not_LetterBox()
            end
          else
            Field_Talk_End_Not_LetterBox()
          end
        else
          Field_Talk_End_Not_LetterBox()
        end
      else
        Field_Talk_End_Not_LetterBox()
      end
    end
    if gim_id == 4 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0090_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 5 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0080_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 6 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0060_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 400 then
      if Flg.Check("FLAG_MAIN_03_495", "FLAG_MAIN_03_515") then
      end
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 202, "start_01")
    end
  elseif gMapNum == 216 then
  elseif gMapNum == 217 then
    if gim_id == 1 then
      if not Flg.Check("FLAG_GIMMICK_D02_450") then
        Field.PlayerLoadAnimation("e519")
        while Field.IsLoadingPlayerAnimation("e519") do
          WaitFrame(1)
        end
        require("treasure_d217")
        treasure_d217()
        Field.PlayerPlayAnimation("e519", 0, false)
        ShowGetItemLog(30011, 1)
        while Field.IsPlayerPlayingAnimation("e519") do
          WaitFrame(1)
        end
        Flg.Set("FLAG_GIMMICK_D02_450")
      end
    elseif gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      WaitFrame(5)
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      SetControlScriptExternalVariable("player_state", "pass")
      WaitFrame(5)
      ColOff("cliff_cl_0001")
      local loc_pos = Field.GetLocatorPosition("change_0001")
      local loc_rot = Field.GetLocatorRotationYDegree("change_0001")
      local player = Obj:new(PLAYER, "")
      Field.SetFollowerCameraOperateRotationY(loc_rot, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      Field.SetFollowerCameraOperateRotationX(0, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      WaitFrame(10)
      local dis_x = math.abs(loc_pos.x - player.pos.x)
      local dis_z = math.abs(loc_pos.z - player.pos.z)
      if 0.15 <= dis_x and 0.15 <= dis_z then
        local move_pos_x = -54.314
        local move_pos_z = -27.296
        local move_point_x = move_pos_x - player.pos.x
        local move_point_z = move_pos_z - player.pos.z
        MovePlayerToRelativePosFrame(move_point_x, move_point_z, 20)
      end
      WaitFrame(20)
      player:SetRotationY(loc_rot, 10)
      WaitFrame(7)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      MovePlayerFrame(180, 0.75, 45)
      WaitFrame(30)
      MapChange("d", 202, "start_06", true, 0, 15)
    end
    if gim_id == 401 then
      GoToTheaterWithEvt()
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
  if gMapNum == 205 then
  elseif gMapNum == 207 then
  elseif gMapNum == 208 then
  elseif gMapNum == 209 then
  elseif gMapNum == 210 then
  elseif gMapNum == 217 then
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
  if gMapNum == 201 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      if gim_name == "fa_m350_01" then
      end
    end
  elseif gMapNum == 202 then
    if gim_tag == "fa_obj_ele" and gim_name == "fa_obstacles_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_d0202_0010_0010") then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D02_240")
      FieldObjectSync(OGIM, false)
    end
  elseif gMapNum == 203 then
  elseif gMapNum == 204 then
  elseif gMapNum == 205 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 206 then
  elseif gMapNum == 207 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_02" then
      SetEnableGimmickCheck("wall_along_0001", true)
      Flg.Set("FLAG_GIMMICK_D02_200")
    end
  elseif gMapNum == 208 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 209 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_01" then
      Obj:new(FLD_OBJ_GIMMICK, "fa_obstacles_02"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "fa_obstacles_03"):SetEnableCheckAndFieldAttack(false)
      Flg.Set("FLAG_GIMMICK_D02_140")
    end
    if gim_name == "fa_obstacles_02" then
      Obj:new(FLD_OBJ_GIMMICK, "fa_obstacles_03"):SetEnableCheckAndFieldAttack(true)
      Flg.Set("FLAG_GIMMICK_D02_150")
    end
    if gim_name == "fa_obstacles_03" then
      Flg.Set("FLAG_GIMMICK_D02_390")
      FieldObjectSync(RUMOR_NPC, false)
      Obj:new(NPC, "npc_0001"):CancelInvisible()
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon01"):Invisible()
    end
  elseif gMapNum == 210 then
    if gim_name == "fa_obstacles_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_d0210_0010_0010") then
      BreakFieldAttackGim(gim_name, true)
      Prcs_d0210_Elvlamp()
      Flg.Set("FLAG_GIMMICK_D02_420")
      SetEnableGimmickCheck("gim_0002", false)
    end
    if gim_name == "fa_obstacles_02" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D02_425")
      SetEnableGimmickCheck("theater_0001", true)
    end
    if gim_name == "fa_treasure_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
    if gim_name == "fa_treasure_02" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
    if gim_name == "fa_treasure_03" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
  elseif gMapNum == 216 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 217 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_tag == "fa_obj_hazama" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D02_180")
      FieldObjectSync(OGIM, false)
    end
    if gim_name == "fa_obstacles_03" then
      Flg.Set("FLAG_GIMMICK_D02_455")
      SetEnableGimmickCheck("theater_0001", true)
    end
  end
end

function OnCheckActModel(act)
end

function OnCheckLocatorWallAlong(wall_along)
  local start_loc = wall_along.locator
  Field.OperateStartLocatorWallAlong(start_loc)
end

function Prcs_d0201_shop_0001Cam()
  Cam.Inst:Set(-28.75, 3.045, 28.764, -20.791, 3.949, 34.75, default, 20)
end

function Prcs_d0201_shop_0002Cam()
  Cam.Inst:Set(-29.655, 3.049, 29.766, -21.642, 4.076, 35.66, default, 20)
end

function Prcs_d0201_merukuri_0001Cam()
  Cam.Inst:Set(1.569696, 8.146063, -58.078457, 0.245783, 4.867414, -67.43248, default, 40)
end
