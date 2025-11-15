function BtlPlayAnimation(group, index, animation_name, blend_frame, is_loop, start_frame)
  if blend_frame == nil then
    blend_frame = 0
  end
  if is_loop == nil then
    is_loop = false
  end
  if start_frame == nil then
    start_frame = -1
  end
  Battle.PlayAnimation(group, index, animation_name, blend_frame, is_loop, start_frame)
end

function BattleCommon_PlayEventAnimation(group, index, animation_name)
  Battle.ModelReset(group, index)
  BtlPlayAnimation(group, index, animation_name, 0, false)
end

function BattleCommon_PlayEventAnimationSeamless(group, index, animation_name)
  BattleCommon_PlayEventAnimation(group, index, animation_name)
  Battle.AddMotionScheduleIdleByStatus(group, index, true)
end

function BattleCommon_WaitCameraEnd(wait_frame)
  while not Battle.IsEndCamera(wait_frame) do
    WaitFrame(Util.SecondFromFrame(1))
  end
end

function BattleCommon_SetVisibleAll(is_visible)
  BattleCommon_SetVisiblePartyDigimon(is_visible)
  BattleCommon_SetVisibleEnemyDigimon(is_visible)
  BattleCommon_SetVisibleGuestDigimon(is_visible)
  BattleCommon_SetVisiblePartyPlayer(is_visible)
  BattleCommon_SetVisibleEnemyPlayer(is_visible)
  BattleCommon_SetVisibleGuestPlayer(is_visible)
end

function BattleCommon_SetVisiblePartyDigimon(is_visible)
  for i = 0, 2 do
    Battle.SetVisibleCharacter(0, i, is_visible)
  end
end

function BattleCommon_SetVisibleEnemyDigimon(is_visible)
  for i = 0, 5 do
    Battle.SetVisibleCharacter(1, i, is_visible)
  end
end

function BattleCommon_SetVisibleGuestDigimon(is_visible)
  for i = 0, 2 do
    Battle.SetVisibleCharacter(2, i, is_visible)
  end
end

function BattleCommon_SetVisiblePartyPlayer(is_visible)
  Battle.SetVisibleCharacter(3, 0, is_visible)
end

function BattleCommon_SetVisibleEnemyPlayer(is_visible)
  Battle.SetVisibleCharacter(4, 0, is_visible)
end

function BattleCommon_SetVisibleGuestPlayer(is_visible)
  for i = 0, 2 do
    Battle.SetVisibleCharacter(5, i, is_visible)
  end
end

function BattleCommon_SetStatusRatio(group, index, status, ratio)
  local value = Battle.GetStatus(group, index, status) * ratio / 100
  Battle.SetStatus(group, index, status, value)
end

function BattleCommon_SetStatusAll(group, status, value)
  local groupNum = 0
  if group == PLAYER_DIGIMON then
    groupNum = 6
  elseif group == ENEMY_DIGIMON then
    groupNum = 6
  elseif group == GUEST_DIGIMON then
    groupNum = 3
  end
  for i = 0, groupNum - 1 do
    Battle.SetStatus(group, i, status, value)
  end
end

function BattleCommon_SetStatusRatioAll(group, status, ratio)
  local groupNum = 0
  if group == PLAYER_DIGIMON then
    groupNum = 6
  elseif group == ENEMY_DIGIMON then
    groupNum = 6
  elseif group == GUEST_DIGIMON then
    groupNum = 3
  end
  for i = 0, groupNum - 1 do
    BattleCommon_SetStatusRatio(group, i, status, ratio)
  end
end

function BattleCommon_SetEnemyBpMax(index)
  Battle.SetStatus(ENEMY_DIGIMON, index, STATUS_TYPE_BREAK_NOW, Battle.GetStatus(ENEMY_DIGIMON, index, STATUS_TYPE_BREAK_MAX))
end

function IsBuffGroup(group, id, check_mode)
  for i = 0, 2 do
    if Battle.IsBuff(group, i, id, check_mode) then
      return true
    end
  end
  return false
end

function GetEnemyHPRatio(index)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, index, STATUS_TYPE_HP)
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, index, STATUS_TYPE_HP_MAX)
  return enemy_now_hp / enemy_max_hp
end

function MotionNameOverwrite(index, motion_type, motion_name)
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, index, motion_type, motion_name)
end

function BtlFlagCheck(is_true_flag, is_false_flag)
  if is_true_flag ~= nil then
    local is_true = Flag.Check(is_true_flag)
    if is_false_flag ~= nil then
      local is_false = Flag.Check(is_false_flag)
      if is_true and not is_false then
        print("BtlFlagCheck returned [ true ]")
        return true
      else
        print("BtlFlagCheck returned [ false ]")
        return false
      end
    else
      return is_true
    end
  end
  print("BtlFlagCheck returned [ nil ]")
  print("Please Check Your Scripts and Flags")
  return nil
end

function BtlCheckMainQuest(quest_id, current_flag, next_flag)
  if current_flag ~= nil then
    local is_current = Quest.CheckMainFlag(quest_id, current_flag)
    if next_flag ~= nil then
      local is_next = Quest.CheckMainFlag(quest_id, next_flag)
      if is_current and not is_next then
        print("BtlCheckMainQuest returned [ true ]")
        return true
      else
        print("BtlCheckMainQuest returned [ false ]")
        return false
      end
    else
      return is_current
    end
  end
  print("BtlCheckMainQuest returned [ nil ]")
  print("Please Check Your Scripts and Flags")
  return nil
end

function BtlAddLoadMotion(enemy_index, data)
  if type(data) == "string" then
    Battle.AddLoadMotion(ENEMY_DIGIMON, enemy_index, data)
  end
  if type(data) == "table" then
    for key in pairs(data) do
      Battle.AddLoadMotion(ENEMY_DIGIMON, enemy_index, data[key])
    end
  end
end

function BtlSetFlexiblePartyByAegiomonOnly(is_none_guest)
  if is_none_guest == nil then
    Battle.SetFlexiblePartyByAegiomonOnly(false)
  else
    Battle.SetFlexiblePartyByAegiomonOnly(is_none_guest)
  end
end

function SetEndrollMember(encount_id)
  if encount_id == nil then
    Battle.SetEndrollMember(-1)
  else
    Battle.SetEndrollMember(encount_id)
  end
end

function BtlSetInterruptCharacter(group, index, interrupt_type, is_prior_exchange)
  if is_prior_exchange == nil then
    is_prior_exchange = false
  end
  Battle.SetInterruptCharacter(group, index, interrupt_type, is_prior_exchange)
end

function IsHpFullCheck(group)
  for i = 0, 2 do
    local now_hp = Battle.GetStatus(group, i, STATUS_TYPE_HP)
    local max_hp = Battle.GetStatus(group, i, STATUS_TYPE_HP_MAX)
    if max_hp ~= 0 then
      local hp_rate = now_hp / max_hp
      if hp_rate ~= 1 then
        return BATTLE_STATUS_HP_NOTFULL
      end
    end
  end
  return BATTLE_STATUS_HP_FULL
end

function IsCheckTarget_Alive(area, index)
  if Battle.GetDigimonId(area, index) > 0 and 0 < Battle.GetStatus(area, index, STATUS_TYPE_HP) then
    return true
  end
  return false
end
