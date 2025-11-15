gGimText = "field_text"

function Prcs_h08_StageClear()
  print("##### Prcs_h08_StageClear #####")
  local is_clear_flg
  if gMapNum == 810 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H810")
    HazamaClearEvent(980, 5, is_clear_flg)
  elseif gMapNum == 811 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H811")
    HazamaClearEvent(981, 5, is_clear_flg)
  elseif gMapNum == 812 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H812")
    HazamaClearEvent(982, 5, is_clear_flg)
  elseif gMapNum == 813 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H813")
    HazamaClearEvent(983, 5, is_clear_flg)
  end
end

function Prcs_h08_VisitMessage(tlk)
  print("##### Prcs_h08_VisitMessage #####")
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

function Prcs_h08_Warp(enemy_id)
  print("##### Prcs_h08_Warp #####")
  local player = Obj:new(PLAYER, "")
  local tlk = Tlk:new("field_text", 1)
  local deji_size = string.sub(enemy_id, -1)
  print("##### deji_size = ", deji_size, " enemy_id = ", enemy_id, "type = ", type(enemy_id), " #####")
  local distance_offset = 0
  local offset_cam_y = 0
  local offset_obj_y = 0
  if deji_size == "S" then
    distance_offset = 3
    offset_cam_y = 0.3
    offset_obj_y = 0.6
  elseif deji_size == "M" then
    distance_offset = 5.5
    offset_cam_y = 0.4
    offset_obj_y = 1.4
  elseif deji_size == "L" then
    distance_offset = 7
    offset_cam_y = 1
    offset_obj_y = 2.5
  end
  player:SetObjRotation(FLD_OBJ_SYMBOL_ENEMY, enemy_id, 20)
  FollowObjectCamera(FLD_OBJ_SYMBOL_ENEMY, enemy_id, 30, offset_cam_y, distance_offset, false, 0, offset_obj_y, 0)
  tlk:StartTalk()
  local result = tlk:Select(2, "g_sel_h08_0010_0010")
  tlk:EndTalk()
  Cam.Follower:Reset2Clear(20, -1, 0, true)
  WaitFrame(20)
  if result == RESULT_TALK00 then
    PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    StartEffectScript(PLAYER, player.index, 1)
    WaitFrame(20)
    player:Invisible()
    SetObjectPositionFromObject(FLD_OBJ_GIMMICK, enemy_id, PLAYER, player.index, 0, 0, 0, true)
    WaitFrame(30)
    player.pos = Field.ObjectGetPosition(PLAYER, player.index)
    player.rot_y = Field.ObjectGetRotationY(PLAYER, player.index)
    PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
    PlaySE(200006, 100)
    WaitFrame(30)
    Field.ObjectEndEffectScript(PLAYER, player.index, 1)
    player:CancelInvisible()
    WaitFrame(20)
    Field_InvisiblePlayer(10, 10, true)
    FollowObjectCamera(FLD_OBJ_SYMBOL_ENEMY, enemy_id, 10, offset_cam_y, distance_offset, false, 0, offset_obj_y, 0)
    local enemy_fe02 = Motion.Object:new(FLD_OBJ_SYMBOL_ENEMY, enemy_id, "fe02")
    enemy_fe02:Play2Move(10, 10)
    WaitFrame(10)
    Field_CancelInvisiblePlayer(10, 10, true, true)
    local encount_group_id = Field.ObjectGetTag(FLD_OBJ_SYMBOL_ENEMY, Field.GetSymbolEnemyIndex(enemy_id))
    EncountFromField_NormalEffect(encount_group_id, 20871, true)
    Cam.Inst:Clear(1)
    Enemys.Despawn(enemy_id, false, FOREVER)
    local enemy_count = GetControlScriptExternalVariable("g_enemy_count", "number")
    enemy_count = enemy_count + 1
    SetControlScriptExternalVariable("g_enemy_count", enemy_count)
    print("##### enemy_count = ", tostring(enemy_count), " #####")
  elseif result == RESULT_TALK01 then
    print("##### TALK END #####")
  end
end
