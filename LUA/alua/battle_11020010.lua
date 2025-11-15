require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 20831)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
  SetEndrollMember(11020010)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  Sound.PlayBGM(928, 0)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  if Flg.Check("Battle5001") == false then
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 10011)
    Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 0)
    Flg.Set("Battle5001")
  end
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5005") and Flg.Check("Battle5006") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(18.75, 1.07, 12.95, 23.55, 3.3, 21.43, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 21.3, 0.48, 17.32)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 0, false)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 0, true)
    Battle.MessageTalk(1102001001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 20831)
    Flg.Set("Battle5006")
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
  local enemy_id = info.enemy_id
  if enemy_id == 72701 then
    if Flg.Check("Battle5002") == false then
      BtlSetInterruptCharacter(ENEMY_DIGIMON, 1, BATTLE_INTERRUPT_TYPE_NORMAL)
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 10011)
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 1, PLAYER_DIGIMON, 1)
      Flg.Set("Battle5002")
    elseif Flg.Check("Battle5002") and Flg.Check("Battle5003") == false then
      if 0 < Battle.GetStatus(GUEST_AEGIOMON, 0, STATUS_TYPE_HP) then
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 2, BATTLE_INTERRUPT_TYPE_NORMAL)
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 30132)
        Battle.SetNextCommandTarget(ENEMY_DIGIMON, 2, GUEST_AEGIOMON, 0)
        Battle.ExchangeMember(GUEST_DIGIMON, 0)
        Flg.Set("Battle5003")
      elseif Battle.GetStatus(GUEST_AEGIOMON, 0, STATUS_TYPE_HP) == 0 then
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 2, BATTLE_INTERRUPT_TYPE_NORMAL)
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 32071)
        Battle.ExchangeMember(GUEST_DIGIMON, 0)
        Flg.Set("Battle5003")
      end
    elseif Flg.Check("Battle5003") and Flg.Check("Battle5004") == false then
      Flg.Set("Battle5004")
    end
  end
  if Flg.Check("Battle5004") and Flg.Check("Battle5005") == false then
    BtlSetInterruptCharacter(GUEST_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
    Flg.Set("Battle5005")
  end
end

function Battle_Win(info)
  Battle.DeleteMember(GUEST_DIGIMON, 0)
  Flg.Set("FLAG_MAIN_10_007")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
