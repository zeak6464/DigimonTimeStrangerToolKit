require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleBGM(-1)
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
end

function Battle_After_Build()
  Battle.SetTargetCursor(ENEMY_DIGIMON, 1)
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  Sound.SetBGMSelectorLabel(222, "SelectorLabel_0")
  Battle.PlayBGM(222, 0.5)
  Fade.AllIn(0, Util.SecondFromFrame(15))
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  if Flg.Check("TUT_FLAG_4503") == false then
    Battle.CloseUI()
    OpenTutorial(1003)
    Flg.Set("TUT_FLAG_4503")
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
  Battle.SetWinBGM(-1)
  Flg.Set("FLAG_MAIN_03_590")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
