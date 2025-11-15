require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
end

function Battle_After_Build()
  SetEndrollMember(10320200)
end

function Battle_Opening(info)
  Fade.OutNotLoading(1, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m080_075")
    Sound.PlayBGM(201, 0.5)
    Fade.In(1, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(201, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
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
  Flg.Set("FLAG_MAIN_03_210")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m080_080")
end
