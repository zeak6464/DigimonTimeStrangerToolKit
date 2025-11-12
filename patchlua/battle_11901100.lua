require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(11901100)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  local max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  if Flg.Check("FLAG_MAIN_22_511") and Flg.Check("FLAG_MAIN_22_512") == false then
    local hp = max_hp * 0.75
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  elseif Flg.Check("FLAG_MAIN_22_512") and Flg.Check("FLAG_MAIN_22_513") == false then
    local hp = max_hp * 0.5
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  elseif Flg.Check("FLAG_MAIN_22_513") and Flg.Check("FLAG_MAIN_22_514") == false then
    local hp = max_hp * 0.25
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  elseif Flg.Check("FLAG_MAIN_22_514") then
    local hp = 100
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  end
  Flg.Set("FLAG_MAIN_22_517")
  Battle.PlayBGM(931, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  local round_count = info.round
  local enemy_id = info.enemy_id
  if round_count == 3 and Flg.Check("Battle5001") == false and enemy_id == 86801 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 10013)
  end
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
  if enemy_now_hp / enemy_max_hp <= 0.75 and Flg.Check("FLAG_MAIN_22_511") == false then
    Flg.Set("FLAG_MAIN_22_511")
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 10013)
  elseif enemy_now_hp / enemy_max_hp <= 0.5 and Flg.Check("FLAG_MAIN_22_512") == false then
    Flg.Set("FLAG_MAIN_22_512")
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 10013)
  elseif enemy_now_hp / enemy_max_hp <= 0.25 and Flg.Check("FLAG_MAIN_22_513") == false then
    Flg.Set("FLAG_MAIN_22_513")
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 10013)
  elseif enemy_now_hp == 1 and Flg.Check("FLAG_MAIN_22_514") == false then
    Flg.Set("FLAG_MAIN_22_514")
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 10013)
  end
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(439, DIGIMON_GRASP_FLAG_SCAN)
  Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
end
