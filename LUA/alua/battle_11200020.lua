require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(11200020)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Sound.PlayBGM(928, 0)
  FadeAllIn(FADE_BLACK, FADE_TIME)
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
  Flg.Set("FLAG_MAIN_13_148")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
