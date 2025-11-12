gGimText = "field_text"

function Prcs_h02_RailMoveStart(gim_id, gim_loc)
  Field.CameraZoomFrame(0, 0, 20, 1)
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Motion.Player:ChangeMoveAnimWithBlend("flow", 15, 10)
  SetPlayerRotationByLocator("gim_00" .. string.format("%02d", gim_id), 10)
  SetControlScriptExternalVariable("effect_state", "play")
  SetControlScriptExternalVariable("gim_check_state", "false")
  WaitFrame(30)
  Field.InvisiblePlayer(0, 0, true)
  WaitFrame(7)
  if gim_id % 2 == 0 then
    SetControlScriptExternalVariable("rail_move_dir", "backward")
  else
    SetControlScriptExternalVariable("rail_move_dir", "forward")
  end
end

function Prcs_h02_RailMoveEnd()
  Field.CameraZoomUndo()
  Motion.Player:ResetMoveAnimWithBlend(15)
  WaitFrame(30)
  Field.CancelInvisiblePlayer(0, 0, false, true)
  WaitFrame(10)
  SetControlScriptExternalVariable("gim_check_state", "true")
  Field.FollowerWarp()
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
end

function Prcs_h02_WarpEffectPlay(pattern_num)
  print("##### Prcs_h02_WarpEffectPlay #####")
  for i = 1, 8 do
    local num = string.format("%02d", i)
    local panel = "panel" .. num
    local obj = Obj:new(FLD_OBJ_GIMMICK, panel)
    local pos = obj.pos
    local index = obj.index
    print("##### Gimmick_name = ", panel, " pos x = ", pos.x, " y = ", pos.y, " z = ", pos.z, " #####")
  end
end

function Prcs_h02_FieldObjectSync(pattern_num)
  print("##### Prcs_h02_FieldObjectSync #####")
  Prcs_h02_PatternRespawn(pattern_num, false, true)
  local enemy_num = 0
  for i = 1, 8 do
    enemy_num = enemy_num + Field.GetSymbolEnemyExistsNumInSpawnPattern(i)
  end
  print("##### enemy_num = ", tostring(enemy_num), " #####")
end

function Prcs_h02_StageClear()
  print("##### Prcs_h02_StageClear #####")
  local encount_num = GetControlScriptExternalVariable("g_encount_num", "number")
  local is_clear_flg
  if gMapNum == 210 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H210")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H210") then
      Flg.Set("FLAG_IS_EXTRA_H210")
    end
    HazamaClearEvent(920, 2, is_clear_flg)
  elseif gMapNum == 211 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H211")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H211") then
      Flg.Set("FLAG_IS_EXTRA_H211")
    end
    HazamaClearEvent(921, 2, is_clear_flg)
  elseif gMapNum == 212 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H212")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H212") then
      Flg.Set("FLAG_IS_EXTRA_H212")
    end
    HazamaClearEvent(922, 2, is_clear_flg)
  elseif gMapNum == 213 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H213")
    if encount_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H213") then
      Flg.Set("FLAG_IS_EXTRA_H213")
    end
    HazamaClearEvent(923, 2, is_clear_flg)
  elseif gMapNum == 220 then
    local player = Obj:new(PLAYER, "")
    local player_e004 = Motion.Object:new(PLAYER, "", "e004")
  elseif gMapNum == 221 then
  elseif gMapNum == 222 then
  end
end

function Prcs_h02_VisitMessage(tlk)
  print("##### Prcs_h02_VisitMessage #####")
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

function Prcs_h02_PatternRespawn(pattern_num, is_effect_skip, is_force)
  local enemy_num = Field.GetObjectNum(FLD_OBJ_SYMBOL_ENEMY)
  for num = 1, enemy_num do
    if Field.ObjectGetSpawnPattern(FLD_OBJ_SYMBOL_ENEMY, num) == pattern_num then
      local panel_name = Field.ObjectGetTag(FLD_OBJ_SYMBOL_ENEMY, num)
      if Field.SymbolForceRespawnAndWarp(num, g_obj[panel_name].x, g_obj[panel_name].y - 2, g_obj[panel_name].z, is_effect_skip, is_force) then
        print("SymbolForceRespawnAndWarp Successed : index", num)
      else
        print("SymbolForceRespawnAndWarp Failed : index", num)
      end
    end
  end
end
