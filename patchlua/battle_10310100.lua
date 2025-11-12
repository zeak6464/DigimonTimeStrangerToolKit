require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(10310100)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Fade.OutNotLoading(1, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m060_110")
    Fade.In(0, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(804, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30184, 30186)
  end
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5005") and Flg.Check("Battle5006") == false then
    if Common.GetGameClearNum() == 0 then
      Battle.SetAegiomonSkill(0, -1)
    end
    Flg.Set("Battle5006")
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if (3 <= round_count or enemy_now_hp / enemy_max_hp <= 0.5) and enemy_id == 95701 and Flg.Check("Battle5004") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 24521)
    Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_DIGIMON, 0)
    Flg.Set("Battle5001")
  end
end

function Battle_Action_Start(info)
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if Flg.Check("Battle5001") == true and Flg.Check("Battle5004") == false and enemy_id == 95701 and enemy_last_skill_id == 24521 then
    Battle.SkipSkillHitDirection(ENEMY_DIGIMON, 0, 24521)
  end
end

function Battle_Action_End(info)
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if Flg.Check("Battle5001") == true and Flg.Check("Battle5004") == false and enemy_id == 95701 and enemy_last_skill_id == 24521 then
    Battle.DeleteMember(GUEST_DIGIMON, 0)
    Battle.PrepareAddAegiomon(7, 7, 21)
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m060_120")
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m060_140")
    FadeAllIn(FADE_WHITE, FADE_TIME)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    Flg.Set("Battle5004")
  end
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  if Flg.Check("Battle5004") and Flg.Check("Battle5005") == false then
    Battle.ExchangeMember(GUEST_AEGIOMON, 0)
    Flg.Set("Battle5005")
  end
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_now_hp == 1 and Flg.Check("Battle5004") == false then
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
  end
end

function Battle_Win(info)
  Battle.DeleteMember(GUEST_AEGIOMON, 0)
  Flg.Set("FLAG_MAIN_03_100")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.DeleteGuest(15631)
  Common.SetDigimonGraspState(452, DIGIMON_GRASP_FLAG_SCAN)
end
