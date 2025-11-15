require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(10700200)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m190_040")
    FadeAllIn(FADE_WHITE, FADE_TIME)
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(207, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30011, 30013)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 30124, 30126)
  end
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
  local round_count = info.round
  local enemy_id = info.enemy_id
  if round_count == 2 and Flg.Check("Battle5001") == false and enemy_id == 95102 then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    Execute("m190_050")
    FadeAllIn(FADE_WHITE, FADE_TIME)
    Flg.Set("Battle5001")
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.AddBuff(ENEMY_DIGIMON, 1, 208002)
    Battle.AddBuff(ENEMY_DIGIMON, 2, 208002)
  end
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
  Flg.Set("FLAG_MAIN_07_020")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m190_060")
end
