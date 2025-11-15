require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
  SetEndrollMember(10930100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(204, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 70 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30052, 30053)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30062, 30063)
  end
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
  if info.group == GUEST_DIGIMON and info.digimon_id == 172 and Battle.GetLastCommandSkillID() == 21721 and info.use_count == 0 then
    Battle.SetBattleSpeedToNormalForTurn()
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_09_067")
  Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
