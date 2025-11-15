require("include_battle")

function Battle_Before_Setup()
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 24171)
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(932, 0.5)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  Battle.ExchangeMember(GUEST_DIGIMON, 0)
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
  Battle.DeleteMember(GUEST_DIGIMON, 0)
  Flg.Set("FLAG_SUB_110_102_002")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
