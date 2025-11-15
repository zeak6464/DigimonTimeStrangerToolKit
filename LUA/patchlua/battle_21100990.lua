require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "fe02")
  Battle.LoadEffectScript(1, "ef_b_van_205")
end

function Battle_Opening(info)
  Battle.PlayBGM(929, 0)
end

function Battle_Start(info)
  Flg.Set("FLAG_SUB_110_099_007")
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 90 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
  end
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
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
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local pos = Battle.GetModelPosition(ENEMY_DIGIMON, 0)
  if enemy_now_hp / enemy_max_hp <= 0.5 then
    Flg.Set("FLAG_SUB_110_099_005")
    WaitFrame(30)
    Battle.ForceEnd()
  end
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
