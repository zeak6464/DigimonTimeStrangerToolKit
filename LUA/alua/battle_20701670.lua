require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(577, 0)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
end

function Battle_Start(info)
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
  Flg.Set("FLAG_SUB_070_167_005")
end

function Battle_Lose(info)
  Battle.ForceEnd()
end

function Battle_Ending(info)
end
