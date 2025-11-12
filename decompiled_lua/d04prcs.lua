gGimText = "field_text"

function Prcs_d0401_GuideMessage()
  Cam.Inst:Set(43.2, 23, 53.1, 33.9, 23.2, 56.6, default, 30)
  WaitFrame(30)
  Field_Talk_Start(gGimText, 1)
  Message("g_f0401_0010_0010")
  Field_Talk_End()
  Cam.Inst:Clear(30)
  WaitFrame(20)
end

function Prcs_d0401_GuideMessage2()
  Cam.Inst:Set(-32.9, 5.7, 74.1, -30.3, 11.2, 82.1, default, 30)
  WaitFrame(30)
  Field_Talk_Start(gGimText, 1)
  Message(1040100001)
  Obj:new(NPC, "Guest_palmon"):CancelInvisible()
  Field.CancelInvisibleGimmick("obj_0001", 0, 30, false, false)
  Field.CancelInvisibleGimmick("obj_0002", 0, 30, false, false)
  WaitFrame(30)
  Message(1040101000)
  WaitFrame(30)
  Field.SetFollowerCameraOperateRotationY(250)
  Cam.Inst:Clear(30)
  WaitFrame(30)
  Message(1040101010)
  Field_Talk_End()
end

function Prcs_d0401_AttackKuwagamon()
  SetControlScriptExternalVariable("chr367_state", "damaged")
  Motion.Gimmick:Play("obj_0001", "bd01", false)
  WaitFrame(35)
  Motion.Gimmick:Play("obj_0001", "br01", true)
  local index = Field.GetLocatorObjectIndex("obj_0001")
  Field.ObjectReleaseMonopolyOnAll(FLD_OBJ_LOCATOR, index)
  print(index)
  SetControlScriptExternalVariable("chr367_state", "run_away")
  Flg.Set("FLAG_GIMMICK_D04_270")
  WaitFrame(25)
  FadeOutWithWait(0, 30)
  Field.InvisibleGimmick("obj_0001", 0, 0, false)
  Cam.Inst:Set(-52, 0.3, 88.6, -46.3, 5.2, 81.9, default, 0)
  SetControlScriptExternalVariable("palmon_state", "evt_start")
  SetControlScriptExternalVariable("chr367_state", "Initialize")
  Motion.NPC:Play("Guest_palmon", "bn01", 10, true)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  WaitFrame(30)
  FadeInWithWait(0, 30)
  Field_Talk_Start("d04", 1)
  Message(203)
  Message(204)
  Message(205)
  Message(206)
  Message(207)
  Message(208)
  MessageTalkSel(2, 301)
  result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK01 then
    Message(212)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
    Field_Talk_End()
    Flg.Set("FLAG_GIMMICK_D04_250")
  elseif result == RESULT_TALK00 then
    Message(211)
    Field_Talk_End()
    WaitFrame(10)
    Guest.Add(23481)
    FadeOutWithWait(0, 30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
    SetFollowerCameraOperateRotation(5, -90)
    Cam.Inst:Clear(0)
    Obj:new(NPC, "Guest_palmon"):Invisible()
    Field.CheckSyncFollower()
    FadeInWithWait(0, 30)
    Flg.Set("FLAG_GIMMICK_D04_240")
    Flg.Set("FLAG_GIMMICK_D04_250")
  end
end

function Prcs_d0401_ParumonJoin()
  Guest.Add(23481)
  Field.CheckSyncFollower()
  Flg.Set("FLAG_GIMMICK_D04_240")
end

function Pros_d0401_ParumonAlsoJoin()
  FadeOutWithWait(0, 30)
  Cam.Inst:Set(-52, 0.3, 88.6, -46.3, 5.2, 81.9, default, 0)
  SetControlScriptExternalVariable("palmon_state", "evt_start")
  SetControlScriptExternalVariable("chr367_state", "Initialize")
  Motion.NPC:Play("Guest_palmon", "bn01", 10, true)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  WaitFrame(30)
  FadeInWithWait(0, 30)
  Field_Talk_Start("d04", 1)
  Message(213)
  MessageTalkSel(2, 301)
  result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK01 then
    Message(212)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
    Field_Talk_End()
  elseif result == RESULT_TALK00 then
    Message(211)
    Field_Talk_End()
    WaitFrame(10)
    Guest.Add(23481)
    FadeOutWithWait(0, 30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
    SetFollowerCameraOperateRotation(5, -90)
    Cam.Inst:Clear(0)
    Obj:new(NPC, "Guest_palmon"):Invisible()
    Field.CheckSyncFollower()
    FadeInWithWait(0, 30)
    Flg.Set("FLAG_GIMMICK_D04_240")
  end
end

function Prcs_StartSeamlessJumpRide(start_locator, end_locator, direction, rail_id, speed, camera_direction)
  local startpos = Field.GetLocatorPosition(start_locator)
  local endpos = Field.GetLocatorPosition(end_locator)
  local rotate = Field.GetAngleToTarget2D(startpos.x, startpos.z, endpos.x, endpos.z)
  Field.SetFollowerCameraOperateRotationY(rotate)
  Field.SetFollowerCameraOperateRotationX(0)
  Field.MovePlayerToLocatorFrame(start_locator, 10)
  SetEnableGimmickCheck(start_locator, false)
  SetEnableGimmickCheck(end_locator, false)
  WaitFrame(10)
  Field.SetPlayerRotation(rotate, 10)
  WaitFrame(10)
  Field_InvisibleFollowerAllPartyMember(0, 15, false)
  Field_InvisibleFollowerAllGuest(0, 15, false)
  SetProhibitDigimonRide(true)
  local index = Field.GetPlayerIndex()
  Field.ObjectReleaseMonopolyOnAll(FLD_OBJ_PLAYER, index)
  print(index)
  SetControlScriptExternalVariable("jump_rail", rail_id)
  SetControlScriptExternalVariable("player_state", "jump_start")
  if camera_direction == "downward" then
    SetControlScriptExternalVariable("camera_state", "downward")
  elseif camera_direction == "normal" then
    SetControlScriptExternalVariable("camera_state", "normal")
  else
    SetControlScriptExternalVariable("camera_state", "normal")
  end
  if speed == "low" then
    SetControlScriptExternalVariable("loop_speed", "low")
  elseif speed == "mid" then
    SetControlScriptExternalVariable("loop_speed", "mid")
  elseif speed == "high" then
    SetControlScriptExternalVariable("loop_speed", "high")
  end
  SetControlScriptExternalVariable("direct_state", direction)
  while GetControlScriptExternalVariableString("player_state") ~= "Initialize" do
    WaitFrame(1)
  end
  Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
  SetProhibitDigimonRide(false)
  SetEnableGimmickCheck(start_locator, true)
  SetEnableGimmickCheck(end_locator, true)
  print("seamless jump end")
end

function Prcs_d0403_RescueTentomonEvt_Intro()
  Cam.Inst:Set(-93.7, 74.6, -38.3, -84.1, 76.4, -36.3, default, 40)
  WaitFrame(60)
  Field_Talk_Start("d04", 1)
  Message(121)
  Message(122)
  MessageTalkSel(2, 203)
  Message(123)
  Message(124)
  Field_Talk_End()
  SetFollowerCameraOperateRotation(25, 220)
  Field.SetPlayerLocator("ride_fly_0008")
  Cam.Inst:Clear(30)
  WaitFrame(35)
  Flg.Set("FLAG_GIMMICK_D04_330")
  Flg.Set("FLAG_IS_FLIGHT_RIDE")
  Field.PlayerScriptDigimonRideStartFromID(304, true, "", 10)
  Field.PlayerFixedMaxSpeed(10)
  Obj:new(NPC, "npc_0001"):Invisible(10)
  SetControlScriptExternalVariable("fly_state", "start")
  Common.SetGuestToWaitForRide(23041)
  while Field.IsPlayerDigimonRideGettingOnAndOff() do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Field.SetEnableGimmickCheck("ride_fly_0008", true)
  require("r01_010")
  WaitFrame(15)
  ColOff("plan_cl_2003")
  r01_010("ride_fly_0009")
  ColOn("plan_cl_2003")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(true)
end

function Prcs_d0403_RescueTentomonEvt()
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Obj:new(NPC, "npc_0006"):CancelInvisible()
  Field.ResetPlayer(-105, 72.3, -49.1, 177)
  Cam.Inst:Set(-104.5, 73.6, -44.5, -96.4, 78.3, -40.8, default, 0)
  Field_Talk_Start("d04", 1)
  Message(201)
  Field_Talk_End()
  Cam.Inst:Set(-106.1, 73.5, -46, -101.9, 76.1, -54.7, default, 0)
  SetControlScriptExternalVariable("kuwaga_evt", "start")
  Field_Talk_Start("d04", 1)
  Message(211)
  Message(212)
  Message(213)
  Message(214)
  Field_Talk_End()
  Flg.Set("FLAG_GIMMICK_D04_340")
  EncountFromField(90367, 10472, false)
end

function S110_109_Event_035()
  WaitFrame(30)
  require("S110_109")
  S110_109:Event_035()
end

function Prcs_d0404_WarpGim_01()
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  Cam.Inst:Set(26.15, 3.1, -0.6, 17, 5.6, -4, default, 60)
  SetControlScriptExternalVariable("player_state", "enter_1fdoor")
  while GetControlScriptExternalVariableString("player_state") ~= "enter" do
    WaitFrame(1)
  end
  Cam.Inst:Set(30.7, 11.5, -10.7, 23.4, 14.6, -16.7, default, 30)
  WaitFrame(30)
  SetControlScriptExternalVariable("player_state", "exit_2fdoor")
  while GetControlScriptExternalVariableString("player_state") ~= "exit" do
    WaitFrame(1)
  end
  Cam.Inst:Clear(60)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  SetControlScriptExternalVariable("player_state", "initialize")
  SetProhibitDigimonRide(false)
end

function Prcs_d0404_WarpGim_02()
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  Cam.Inst:Set(30.7, 11.5, -10.7, 23.4, 14.6, -16.7, default, 30)
  SetControlScriptExternalVariable("player_state", "enter_2fdoor")
  while GetControlScriptExternalVariableString("player_state") ~= "enter" do
    WaitFrame(1)
  end
  Cam.Inst:Set(26.15, 3.1, -0.6, 17, 5.6, -4, default, 30)
  WaitFrame(30)
  SetControlScriptExternalVariable("player_state", "exit_1fdoor")
  while GetControlScriptExternalVariableString("player_state") ~= "exit" do
    WaitFrame(1)
  end
  Cam.Inst:Clear(60)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  SetControlScriptExternalVariable("player_state", "initialize")
  SetProhibitDigimonRide(false)
end

function Prcs_d0404_kabuteri_evt()
  Field_Talk_Start("d04", 1)
  Flg.Set("FLAG_GIMMICK_D04_310")
  Message(101)
  Message(102)
  Message(103)
  Field_Talk_End()
  Motion.Object:PlayWithStartMoveMotion("e002", 10, 10)
  WaitFrame(70)
  Field_Talk_Start("d04", 1)
  Message(104)
  Message(105)
  MessageTalkSel(2, 201)
  result = Talk.GetResultSelectedNum()
  if result == 0 then
    Message(111)
    Field_Talk_End()
    Flg.Set("FLAG_GIMMICK_D04_320")
    Guest.Add(23041)
    FadeOutWithWait(0, 30)
    Obj:new(NPC, "npc_0007"):Invisible()
    Field.CheckSyncFollower()
    FadeInWithWait(0, 30)
  elseif result == 1 then
    Message(112)
    Field_Talk_End()
  end
end

function Prcs_d0405_WarpGim(move_in, exit, move_out, warp_num)
  Cam.Inst:Set(start_cam[warp_num][1], start_cam[warp_num][2], start_cam[warp_num][3], start_cam[warp_num][4], start_cam[warp_num][5], start_cam[warp_num][6], default, 0)
  WaitFrame(1)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field.MovePlayerToLocatorFrame(move_in, 40)
  WaitFrame(25)
  Obj:new(PLAYER, ""):Invisible(10)
  Cam.Inst:Set(warp_cam[warp_num][1], warp_cam[warp_num][2], warp_cam[warp_num][3], warp_cam[warp_num][4], warp_cam[warp_num][5], warp_cam[warp_num][6], default, 60)
  WaitFrame(60)
  SetPlayerLocator(exit)
  WaitFrame(10)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Field.MovePlayerToLocatorFrame(move_out, 35)
  WaitFrame(35)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetFollowerCameraOperateRotation(warp_cam[warp_num][7], warp_cam[warp_num][8])
  Cam.Inst:Clear(30)
end

function Prcs_d04_RideFly_Start(start_loc, map_id)
  local degimon1 = Digimon.GetUniqueIDInPartyMember(1)
  local degimon2 = Digimon.GetUniqueIDInPartyMember(2)
  local degimon3 = Digimon.GetUniqueIDInPartyMember(3)
  local ride_start = false
  if degimon1 ~= nil and Digimon.GetDigimonRideType(degimon1) == DIGIMON_RIDE_TYPE_FLYING then
    Common.SetPartyDigimonToWaitForRide(degimon1)
    ride_start = true
  elseif degimon2 ~= nil and Digimon.GetDigimonRideType(degimon2) == DIGIMON_RIDE_TYPE_FLYING then
    Common.SetPartyDigimonToWaitForRide(degimon2)
    ride_start = true
  elseif degimon3 ~= nil and Digimon.GetDigimonRideType(degimon3) == DIGIMON_RIDE_TYPE_FLYING then
    Common.SetPartyDigimonToWaitForRide(degimon3)
    ride_start = true
  else
    Field_Talk_Start(gGimText, 1)
    Message("g_f0401_0020_0010")
    Field_Talk_End()
  end
  if ride_start == true then
    SetPlayerRotationToLocator(start_loc, 15)
    SetFollowerCameraOperateRotation(5, Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1), 15)
    WaitFrame(20)
    Field.PlayerScriptDigimonRideStartWithWaitingDigimon(true, "", 5)
    SetProhibitPlayerOnlyOperate(true)
    Flg.Set("FLAG_IS_FLIGHT_RIDE")
    SetControlScriptExternalVariable("fly_root", start_loc)
    SetControlScriptExternalVariable("map_id", map_id)
    if map_id == 401 then
      ColOff("wall_cl_0002")
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0001"):SetEnableGimmickCheck(false)
    elseif map_id == 402 then
      ColOff("plan_cl_0001")
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0001"):SetEnableGimmickCheck(false)
    elseif map_id == 403 then
      ColOff("plan_cl_2003")
      ColOff("plan_cl_2006")
      ColOff("plan_cl_2007")
      ColOff("plan_cl_2010")
      ColOff("plan_cl_2011")
      ColOff("plan_cl_2014")
      ColOff("plan_cl_2015")
      ColOff("plan_cl_1000")
      ColOff("plan_cl_1001")
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0001"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0004"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0008"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0011"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0014"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0017"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0020"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0023"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "ride_fly_0029"):SetEnableCheckAndFieldAttack(false)
    end
  end
end

function Prcs_d04_RideFly_End(end_loc, map_id)
  if Field.IsPlayerScriptDigimonRiding() then
    end_loc = ""
    Field.PlayerScriptDigimonRideEnd(true, end_loc, 5)
    SetProhibitPlayerOnlyOperate(false)
    Flg.Clear("FLAG_IS_FLIGHT_RIDE")
    SetControlScriptExternalVariable("fly_root", "")
    SetControlScriptExternalVariable("map_id", "")
    if map_id == 401 then
      ColOn("wall_cl_0002")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0001"), true)
    elseif map_id == 402 then
      ColOn("plan_cl_0001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0001"), true)
    elseif map_id == 403 then
      ColOn("plan_cl_2003")
      ColOn("plan_cl_2006")
      ColOn("plan_cl_2007")
      ColOn("plan_cl_2010")
      ColOn("plan_cl_2011")
      ColOn("plan_cl_2014")
      ColOn("plan_cl_2015")
      ColOn("plan_cl_1000")
      ColOn("plan_cl_1001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0001"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0004"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0008"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0011"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0014"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0017"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0020"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0023"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_fly_0029"), true)
    end
  end
end

function Prcs_d04_JumpRide(start_loc, landing_loc, camrot_x, landing_height)
  local is_ride_execution = true
  PlayerObjectResetAim()
  if Common.CheckTimeAxis("A2028_daft_290", "A2028_daft_450") then
    if not Flg.Check("FLAG_FIELD_D04_PalRide_290") then
    elseif not Prcs_d04_PalumonRideCollectMoney(100) == true then
      is_ride_execution = false
    end
  elseif Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") then
    if not Flg.Check("FLAG_FIELD_D04_PalRide_300") then
    elseif not Prcs_d04_PalumonRideCollectMoney(100) == true then
      is_ride_execution = false
    end
  elseif Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_450") then
    if not Prcs_d04_PalumonRideCollectMoney(100) == true then
      is_ride_execution = false
    end
  elseif not Flg.Check("FLAG_GIMMICK_D04_AFTRER180_FIRSTJUMP") and Flg.Check("FLAG_MAIN_07_000") then
    Flg.Set("FLAG_GIMMICK_D04_AFTRER180_FIRSTJUMP")
    local tlk = Tlk:new("d04", 1, false)
    tlk:StartTalk()
    tlk:Message("f_d0401_0160_0010")
    tlk:EndTalk()
  end
  if is_ride_execution == true then
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    local start_pos = Field.ObjectGetPosition(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, start_loc))
    local landing_pos = Field.ObjectGetPosition(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, landing_loc))
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, landing_pos.x, landing_pos.z)
    if landing_height == "high" then
    elseif landing_height == "low" then
    elseif landing_height == "same" or landing_height == nil then
    end
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, landing_pos.x, landing_pos.z)
    SetFollowerCameraOperateRotation(5, obj1_to_obj2_rot + 200, 30)
    PlayerTurnToObject(FLD_OBJ_LOCATOR, landing_loc, true, false, camrot_x, 0)
    WaitFrame(30)
    Field.PlayCameraAnimation("Cam_r03_in01", 15, LINEAR, true, true)
    Motion.Player:Play("r348_in01", 5, false)
    Field.ObjectShowAttachment(FLD_OBJ_PLAYER, 1, 1)
    Field.ObjectPlayAttachmentMotion(FLD_OBJ_PLAYER, 1, 1, "r348_in01", 5, false)
    WaitFrame(27)
    PlaySE(200027, 100)
    WaitFrame(23)
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
    if Common.CheckTimeAxis("A2028_daft_290", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_450") then
      Prcs_d04_PalumonRideSlip()
    end
  end
end

function Prcs_d04_JumpRideAndMapChangeOut(start_loc, landing_loc, camrot_x, landing_height, map_id, mapstart_loc)
  local is_ride_execution = true
  PlayerObjectResetAim()
  if (Common.CheckTimeAxis("A2028_daft_290", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_450")) and not Prcs_d04_PalumonRideCollectMoney(100) == true then
    is_ride_execution = false
  else
  end
  if is_ride_execution == true then
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    local start_pos = Field.ObjectGetPosition(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, start_loc))
    local landing_pos = Field.ObjectGetPosition(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, landing_loc))
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, landing_pos.x, landing_pos.z)
    if landing_height == "high" then
    elseif landing_height == "low" then
    elseif landing_height == "same" or landing_height == nil then
    end
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, landing_pos.x, landing_pos.z)
    SetFollowerCameraOperateRotation(5, obj1_to_obj2_rot + 200, 30)
    PlayerTurnToObject(FLD_OBJ_LOCATOR, landing_loc, true, false, camrot_x, -25)
    WaitFrame(30)
    Field.PlayCameraAnimation("Cam_r03_in01", 15, LINEAR, true)
    Motion.Player:Play("r348_in01", 5, false)
    Field.ObjectShowAttachment(FLD_OBJ_PLAYER, 1, 1)
    Field.ObjectPlayAttachmentMotion(FLD_OBJ_PLAYER, 1, 1, "r348_in01", 5, false)
    WaitFrame(27)
    PlaySE(200027, 100)
    WaitFrame(23)
    Flg.Set("FLAG_GIMMICK_D04_100")
    MapChange("d", map_id, mapstart_loc, true, FADE_BLACK, FADE_TIME)
  end
end

function Prcs_d04_JumpRideAndMapChangeIn(landing_loc, camrot_x, landing_height)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  local landing_pos = Field.ObjectGetPosition(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, landing_loc))
  Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, landing_pos.x, landing_pos.y, landing_pos.z)
  Field.ObjectShowAttachment(FLD_OBJ_PLAYER, 1, 2)
  Motion.Player:Play("r348_out01", 5, false)
  Field.ObjectPlayAttachmentMotion(FLD_OBJ_PLAYER, 1, 2, "r348_out01", 5, false)
  WaitFrame(1)
  Field.PlayCameraAnimation("Cam_r03_out01", 0, LINEAR, true, true, 30, LINEAR)
  FadeAllInWithWait(FADE_BLACK, 5)
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
  if Common.CheckTimeAxis("A2028_daft_290", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_450") then
    Prcs_d04_PalumonRideSlip()
  end
end

function Prcs_d04_PalumonRideCollectMoney(fee)
  local money = Common.GetMoney()
  if fee <= money then
    Common.AddMoney(-1 * fee)
    return true
  else
    local tlk = Tlk:new("d04", 1, false)
    tlk:StartTalk()
    tlk:Message("f_d0402_0020_0010")
    tlk:EndTalk()
    return false
  end
end

function Prcs_d04_PalumonRideSlip()
  if Common.CheckTimeAxis("A2028_daft_290", "A2028_daft_450") then
    if not Flg.Check("FLAG_FIELD_D04_PalRide_290") then
      Flg.Set("FLAG_FIELD_D04_PalRide_290")
      Digitter.Send(1290020010)
    else
      Digitter.Send(1290020020)
      PlaySE(101012, 100)
    end
  elseif Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") then
    if not Flg.Check("FLAG_FIELD_D04_PalRide_300") then
      Flg.Set("FLAG_FIELD_D04_PalRide_300")
      Digitter.Send(1300000010)
    else
      Digitter.Send(1300000020)
      PlaySE(101012, 100)
    end
  elseif Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_450") then
    Digitter.Send(1300000020)
    PlaySE(101012, 100)
  end
end

function Prcs_d04_StartRideFly(start_loc, move_loc, gim_loc, cl_name)
  Field.MovePlayerToLocatorFrame(start_loc, 10)
  WaitFrame(10)
  SetPlayerRotationByLocator(start_loc, 10)
  StartRideFly(true, gim_loc, 10)
  require("r01_010")
  WaitFrame(15)
  ColOff(cl_name)
  r01_010(move_loc)
  ColOn(cl_name)
  SetControlScriptExternalVariable("fly_state", "start")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(true)
end

function Prcs_d04_EndRideFly(move_loc, cl_name)
  require("r01_020")
  Flg.Clear("FLAG_IS_FLIGHT_RIDE")
  ColOff(cl_name)
  r01_020(move_loc)
  ColOn(cl_name)
  Field.FollowerWarp()
  EndRide(true, move_loc, 30)
  SetControlScriptExternalVariable("fly_state", "Initialize")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(false)
end

function Prcs_d0403_StartRideFly(start_loc, move_loc, gim_loc, cl_name)
  Field.MovePlayerToLocatorFrame(start_loc, 10)
  WaitFrame(10)
  SetPlayerRotationByLocator(start_loc, 10)
  Field.PlayerScriptDigimonRideStartFromID(304, true, "", 10)
  Field.PlayerFixedMaxSpeed(10)
  while Field.IsPlayerDigimonRideGettingOnAndOff() do
    WaitFrame(Util.SecondFromFrame(1))
  end
  require("r01_010")
  WaitFrame(15)
  ColOff(cl_name)
  r01_010(move_loc)
  ColOn(cl_name)
  SetControlScriptExternalVariable("fly_state", "start")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(true)
end

function Prcs_d04_EndRideFlyMultiCol(move_loc, col_start, col_end)
  require("r01_020")
  Flg.Clear("FLAG_IS_FLIGHT_RIDE")
  for i = col_start, col_end do
    ColOff("plan_cl_" .. i)
  end
  r01_020(move_loc)
  for i = col_start, col_end do
    ColOn("plan_cl_" .. i)
  end
  Field.FollowerWarp()
  EndRide(true, move_loc, 30)
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(false)
end

function ZoomBlur(state)
  if state == "fade_in" then
    PostEffect.SetZoomBlur(true)
    PostEffect.SetOvrZoomBlur(0.5, 0.5, 0, 8, 0.1, 0.9, 1.2)
    PostEffect.SetOvrZoomBlur(0.5, 0.5, 0.15, 8, 0.1, 0.9, 1.2)
    PostEffect.RegistOvrZoomBlur(0, 0.3, false, 0, false)
  elseif state == "fade_out" then
    PostEffect.SetOvrZoomBlur(0.5, 0.5, 0, 8, 0.1, 0.9, 1.2)
    PostEffect.RegistOvrZoomBlur(0, 1, false, 0, false)
  elseif state == "end" then
    PostEffect.SetZoomBlur(false)
  end
end

function test_accel(PLAYER_SPEED)
  if PLAYER_SPEED <= 15.5 then
    Field.PlayerFixedMaxSpeed(PLAYER_SPEED + 1.2)
  end
end
