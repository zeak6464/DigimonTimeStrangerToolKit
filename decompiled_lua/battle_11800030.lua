require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
  SetEndrollMember(11800030)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Sound.PlayBGM(931, 0)
end

function Battle_Start(info)
  if Flg.Check("Battle5102") == false then
    Battle.SetFieldEffectSkill(29697, -1, -1)
    Flg.Set("Battle5102")
  end
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
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
  Flg.Set("FLAG_MAIN_19_061")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(613, DIGIMON_GRASP_FLAG_SCAN)
end
