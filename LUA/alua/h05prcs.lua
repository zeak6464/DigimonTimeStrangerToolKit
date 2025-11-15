gGimText = "field_text"

function Prcs_StartSeamlessJumpRide(start_locator, end_locator, direction, rail_id, speed, camera_direction)
  print("------start seamless jumride------")
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

function Prcs_h05_StageClear()
  print("##### Prcs_h05_StageClear #####")
  local encount_num = GetControlScriptExternalVariable("g_encount_num", "number")
  local is_clear_flg
  if gMapNum == 510 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H510")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H510") then
      Flg.Set("FLAG_IS_EXTRA_H510")
    end
    HazamaClearEvent(950, 4, is_clear_flg)
  elseif gMapNum == 511 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H511")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H511") then
      Flg.Set("FLAG_IS_EXTRA_H511")
    end
    HazamaClearEvent(951, 4, is_clear_flg)
  elseif gMapNum == 512 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H512")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H512") then
      Flg.Set("FLAG_IS_EXTRA_H512")
    end
    HazamaClearEvent(952, 4, is_clear_flg)
  elseif gMapNum == 513 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H513")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H513") then
      Flg.Set("FLAG_IS_EXTRA_H513")
    end
    HazamaClearEvent(953, 4, is_clear_flg)
  end
end

function Prcs_h05_VisitMessage(tlk)
  print("##### Prcs_h05_VisitMessage #####")
  tlk:Message("g_event_0020_0410")
  local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
  gim_terminal_e001_online:Play(0, true)
  WaitFrame(1)
  gim_terminal_e001_online:Reset(10)
  WaitFrame(1)
  gim_terminal_e001_online:Play(0, true)
  WaitFrame(1)
  gim_terminal_e001_online:Reset(10)
  WaitFrame(1)
  gim_terminal_e001_online:Play(0, true)
  WaitFrame(10)
  gim_terminal_e001_online:Reset(10)
  tlk:Message("g_event_0020_0420")
  tlk:Message("g_event_0020_0430")
end

function Prcs_h05_GameOver(symbol_index)
  print("##### Prcs_h05_GameOver #####")
  print("##### symbolindex =", symbol_index, " #####")
  print("##### INVISINVISIBLE DEGIMON #####")
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 10, false)
  local player = Obj:new(PLAYER, "")
  local set_obj = Obj:new(OGIM, "ene_pos")
  local enemy = Obj:new(FLD_OBJ_SYMBOL_ENEMY, tonumber(symbol_index))
  player:SetObjRotation(FLD_OBJ_SYMBOL_ENEMY, enemy.name, 10)
  Cam.Follower:ResetFromObject(FLD_OBJ_SYMBOL_ENEMY, enemy.name, 10)
  WaitFrame(15)
  if player.pos.z >= -40 then
    FollowObjectCamera(FLD_OBJ_SYMBOL_ENEMY, enemy.name, 30)
    WaitFrame(45)
  end
  WaitFrame(15)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(FADE_TIME)
  print("##### plyaer_pos x =", player.pos.x, " y = ", player.pos.y, " z = ", player.pos.z, " #####")
  print("##### enemy_pos x =", enemy.pos.x, " y = ", enemy.pos.y, " z = ", enemy.pos.z, " #####")
  print("##### set_obj_pos x =", set_obj.pos.x, " y = ", set_obj.pos.y, " z = ", set_obj.pos.z, " #####")
  WaitFrame(1)
  enemy:SetPos(set_obj.pos.x, set_obj.pos.y, set_obj.pos.z, true)
  WaitFrame(1)
  player:SetObjectPositionFromObject(OGIM, "ene_pos", 0, 0, -2.5, true)
  WaitFrame(1)
  Cam.Follower:Reset2Clear(10, -1)
  enemy:SetObjRotation(FLD_OBJ_GIMMICK, "meat", 1)
  player:SetObjRotationWithCamera(FLD_OBJ_GIMMICK, "meat", 1)
  WaitFrame(3)
  local cam_pos_x, cam_pos_y, cam_pos_z = player.nowpos.x, player.nowpos.y, player.nowpos.z
  local aim_pos_x, aim_pos_y, aim_pos_z = set_obj.nowpos.x, set_obj.nowpos.y, set_obj.nowpos.z
  Cam.Inst:Set(aim_pos_x, aim_pos_y, aim_pos_z, cam_pos_x + 2, cam_pos_y + 1.5, cam_pos_z - 2, default, 1)
  WaitFrame(1)
  local enemy_eat = Motion.Object:new(ENEMY, enemy.name, "fe01")
  local player_down = Motion.Object:new(PLAYER, "", "bl01")
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  Cam.Inst:Set(aim_pos_x, aim_pos_y, aim_pos_z, cam_pos_x + 2, cam_pos_y + 1.5, cam_pos_z - 7, default, 140)
  enemy_eat:Play(15, true)
  WaitFrame(30)
  player_down:Play(15, false)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, 60)
  WaitFrame(60)
  Field.OpenGameOver()
  Cam.Inst:Clear(0)
  print("##### VISINVISIBLE DEGIMON #####")
  Field.CancelInvisibleFollowerAllPartyMember(0, 0, false, true)
end

function Prcs_h05_QuestStartEvent(symbol_index)
  local boss = Obj:new(FLD_OBJ_SYMBOL_ENEMY, symbol_index)
  local player = Obj:new(PLAYER, "")
  local cam_pos_x, cam_pos_y, cam_pos_z = boss.pos.x, player.pos.y + 1.5, boss.pos.z + 5
  local aim_pos_x, aim_pos_y, aim_pos_z = boss.pos.x, boss.pos.y + 1.75, boss.pos.z
  MiniMapChange(MAP_LAYER_LOW)
  Cam.Inst:Set(aim_pos_x, aim_pos_y, aim_pos_z, cam_pos_x, cam_pos_y, cam_pos_z, default, 15)
  WaitFrame(1)
  local boss_bn01 = Motion.Object:new(FLD_OBJ_SYMBOL_ENEMY, boss.name, "bn01")
  boss_bn01:PlayWithStartMoveMotion(10, 10)
  Cam.Inst:Set(aim_pos_x, aim_pos_y, aim_pos_z, cam_pos_x, cam_pos_y, cam_pos_z + 5, default, 60)
  WaitFrame(60)
  Fade_OutNoLoadingWithWait(FADE_BLACK, 29)
  WaitFrame(30)
  Cam.Inst:Clear(0)
  WaitFrame(1)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(FADE_TIME)
end
