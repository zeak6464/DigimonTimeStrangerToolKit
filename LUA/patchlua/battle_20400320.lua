require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(928, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
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
  Flg.Set("FLAG_SUB_040_032_003")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
