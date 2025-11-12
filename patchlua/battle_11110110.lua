require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(11110110)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(FADE_WHITE, Util.SecondFromFrame(15), 1, 0)
  Battle.PlayBGM(221, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 131040)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 70 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
  end
end

function Battle_Round_Start(info)
  Flg.Clear("Battle5001")
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  if round_count % 7 == 0 and Flg.Check("Battle5001") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 20312)
    Flg.Set("Battle5001")
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

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_12_020")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
