require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
end

function Battle_Start(info)
  if Flg.Check("FLAG_MAIN_19_064") == false then
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, true)
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 1, true)
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 2, true)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 561302)
    Battle.AddBuff(ENEMY_DIGIMON, 1, 561302)
    Battle.AddBuff(ENEMY_DIGIMON, 2, 561302)
    Battle.AddBuff(PLAYER_DIGIMON, 0, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 1, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 2, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 3, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 4, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 5, 561303)
    Battle.AddBuff(GUEST_DIGIMON, 1, 561303)
    Battle.AddBuff(GUEST_DIGIMON, 2, 561303)
  end
end

function Battle_Round_Start(info)
  if Flg.Check("FLAG_MAIN_19_064") == false and Flg.Check("Battle5102") == false then
    Battle.SetFieldEffectSkill(29697, -1, -1)
    Flg.Set("Battle5102")
  end
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
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
