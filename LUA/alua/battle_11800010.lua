require("include_battle")

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "e008")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "e007")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
  SetEndrollMember(11800010)
end

function Battle_After_Build()
  Sound.PlayBGM(931, 0.5)
end

function Battle_Opening(info)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 561301)
  Battle.AddBuff(PLAYER_DIGIMON, 3, 561303)
  Battle.AddBuff(PLAYER_DIGIMON, 4, 561303)
  Battle.AddBuff(PLAYER_DIGIMON, 5, 561303)
  Battle.SetEscapeRate(100)
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
    Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_ESCAPE, true)
  end
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Round_Start(info)
  if Flg.Check("Battle5102") == false then
    Battle.SetFieldEffectSkill(29697, -1, -1)
    Flg.Set("Battle5102")
  end
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) then
    Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_ESCAPE, false)
  end
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
    Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_ESCAPE, true)
  end
  if Flg.Check("Battle5001") == false and (round_count == 3 or enemy_now_hp / enemy_max_hp <= 0.5 or enemy_now_hp == 1) and info.group == 2 and info.index == 1 then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 27331)
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
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_now_hp == 1 then
    BtlSetInterruptCharacter(GUEST_DIGIMON, 1, BATTLE_INTERRUPT_TYPE_NORMAL)
  end
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) then
    Battle.ForceEscape()
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(12.36, 7.17, 10.92, 4.76, 4.6, 4.95, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -11.37, 0, 5.61)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "e008", 0, false)
    Battle.SetLoopFrameAnimation(GUEST_DIGIMON, 0, "e008", 30, 70)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 10.06, 0, 20.08)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 12, 0, 20.08)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 15.06, 0, 20.08)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, 4.1, 0, 6.91)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -5.34, 0, 7.46)
    Battle.MessageTalk(1180001001)
    WaitMessage()
    Battle.MessageTalk(1180001002)
    WaitMessage()
    Battle.MessageTalk(1180001003)
    WaitMessage()
    Battle.MessageTalk(1180001004)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "e007", 0, false)
    Battle.SetLoopFrameAnimation(GUEST_DIGIMON, 0, "e007", 30, 70)
    Battle.MessageTalk(1180001005)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Battle.EndTalk()
    Flg.Set("Battle5001")
    Flg.Set("FLAG_MAIN_19_051")
  end
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(613, DIGIMON_GRASP_FLAG_SCAN)
end
