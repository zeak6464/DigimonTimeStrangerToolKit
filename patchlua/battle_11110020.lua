require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(11110020)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(FADE_WHITE, Util.SecondFromFrame(15), 1, 0)
  Battle.PlayBGM(221, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 70 < enemy_level then
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30292, 30293)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30302, 30303)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 30292, 30293)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 30302, 30303)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 30292, 30293)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 30302, 30303)
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
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_11_022")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
