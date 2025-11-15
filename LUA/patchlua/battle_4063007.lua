require("include_battle")
Round = 0
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    is_high_difficulty = true
  end
end

function Battle_Round_Start(info)
  local round_count = info.round
  local target_list = {}
  if 2 <= round_count and Flg.Check("FLAG_MAIN_03_680") == false then
    for idx = 0, 2 do
      if IsCheckTarget(ENEMY_DIGIMON, idx, REGION_FLAG_TYPE_MECHANICAL) == true and 0 < Battle.GetStatus(ENEMY_DIGIMON, idx, STATUS_TYPE_HP) then
        local enemy_data = {
          group = ENEMY_DIGIMON,
          index = idx
        }
        target_list[#target_list + 1] = enemy_data
      end
      if IsCheckTarget(ENEMY_DIGIMON, idx, REGION_FLAG_TYPE_STEEL) == true and 0 < Battle.GetStatus(ENEMY_DIGIMON, idx, STATUS_TYPE_HP) then
        local enemy_data = {
          group = ENEMY_DIGIMON,
          index = idx
        }
        target_list[#target_list + 1] = enemy_data
      end
    end
    for idx = 0, 2 do
      if IsCheckTarget(PLAYER_DIGIMON, idx, REGION_FLAG_TYPE_MECHANICAL) == true and 0 < Battle.GetStatus(PLAYER_DIGIMON, idx, STATUS_TYPE_HP) then
        local player_data = {
          group = PLAYER_DIGIMON,
          index = idx
        }
        target_list[#target_list + 1] = player_data
      end
      if IsCheckTarget(PLAYER_DIGIMON, idx, REGION_FLAG_TYPE_STEEL) == true and 0 < Battle.GetStatus(PLAYER_DIGIMON, idx, STATUS_TYPE_HP) then
        local player_data = {
          group = PLAYER_DIGIMON,
          index = idx
        }
        target_list[#target_list + 1] = player_data
      end
    end
    print("FieldEfectTarget:", target_list)
    if 0 < #target_list then
      if Flg.Check("FLAG_IS_HIT_LIGHTNING") == false then
        Flg.Set("Battle5001")
      end
      local target_idx = math.random(1, #target_list)
      if is_high_difficulty then
        Battle.SetFieldEffectSkill(29277, target_list[target_idx].group, target_list[target_idx].index)
      else
        Battle.SetFieldEffectSkill(29265, target_list[target_idx].group, target_list[target_idx].index)
      end
    elseif math.random(1, 2) == 1 then
      for idx = 0, 2 do
        if Battle.GetDigimonId(PLAYER_DIGIMON, idx) ~= 0 and 0 < Battle.GetStatus(PLAYER_DIGIMON, idx, STATUS_TYPE_HP) then
          local player_data = {
            group = PLAYER_DIGIMON,
            index = idx
          }
          target_list[#target_list + 1] = player_data
        end
        if Battle.GetDigimonId(GUEST_DIGIMON, idx) ~= 0 and 0 < Battle.GetStatus(GUEST_DIGIMON, idx, STATUS_TYPE_HP) then
          local player_data = {
            group = GUEST_DIGIMON,
            index = idx
          }
          target_list[#target_list + 1] = player_data
        end
      end
      if Flg.Check("FLAG_IS_HIT_LIGHTNING") == false then
        Flg.Set("Battle5001")
      end
      local target_idx = math.random(1, #target_list)
      if is_high_difficulty then
        Battle.SetFieldEffectSkill(29277, target_list[target_idx].group, target_list[target_idx].index)
      else
        Battle.SetFieldEffectSkill(29265, target_list[target_idx].group, target_list[target_idx].index)
      end
    else
      for idx = 0, 2 do
        if Battle.GetDigimonId(ENEMY_DIGIMON, idx) ~= 0 and 0 < Battle.GetStatus(ENEMY_DIGIMON, idx, STATUS_TYPE_HP) then
          local enemy_data = {
            group = ENEMY_DIGIMON,
            index = idx
          }
          target_list[#target_list + 1] = enemy_data
        end
      end
      local target_idx = math.random(1, #target_list)
      if is_high_difficulty then
        Battle.SetFieldEffectSkill(29277, target_list[target_idx].group, target_list[target_idx].index)
      else
        Battle.SetFieldEffectSkill(29265, target_list[target_idx].group, target_list[target_idx].index)
      end
    end
  end
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5001") then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    slot = Sound.PlaySE(500006, 100, false)
    WaitFrame(35)
    Sound.StopSE(slot, 0)
    Battle.MessageTalk(1036010022)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("FLAG_IS_HIT_LIGHTNING")
    Flg.Clear("Battle5001")
  end
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
end

function IsCheckTarget(area, index, region_flag_type)
  if Battle.GetDigimonId(area, index) > 0 and 0 < Battle.GetStatus(area, index, STATUS_TYPE_HP) and Battle.IsBelong(area, index, region_flag_type) == true then
    return true
  end
  return false
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
