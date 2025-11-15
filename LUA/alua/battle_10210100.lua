require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(10210100)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Fade.OutNotLoading(1, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m040_080")
    Fade.In(1, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(804, 0)
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
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_now_hp / enemy_max_hp <= 0.9 and Flg.Check("Battle5001") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m040_090")
    Fade.In(1, Util.SecondFromFrame(10))
    Battle.DeleteMember(GUEST_DIGIMON, 0)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    Flg.Set("Battle5001")
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_02_060")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.DeleteGuest(15631)
  Common.SetDigimonGraspState(590, DIGIMON_GRASP_FLAG_SCAN)
end
