require("include_battle")

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(929, 0)
end

function Battle_Start(info)
  if Flg.Check("Battle5001") == false then
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 2, false)
    Battle.SetCamera(0, 3.06, 3.13, 0, 2.62, -1.85, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.MessageTalk(2110099101)
    WaitMessage()
    Battle.MessageTalk(2110099102)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5001")
  end
end

function Battle_Round_Start(info)
  if Flg.Check("Battle5002") == false then
    BtlSetInterruptCharacter(GUEST_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
    Battle.SetCharacterSettingFlag(GUEST_DIGIMON, 0, BATTLE_CHARACTER_SETTING_DAMAGE_ZERO, true)
  end
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
  local enemy_id = info.enemy_id
  if Flg.Check("Battle5002") == false and enemy_id == 42202 and Flg.Check("Battle5003") == true then
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 2, false)
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.MessageTalk(2110099103)
    WaitMessage()
    Battle.MessageTalk(2110099104)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Battle.SetCharacterSettingFlag(GUEST_DIGIMON, 0, BATTLE_CHARACTER_SETTING_DAMAGE_ZERO, false)
    Flg.Set("Battle5002")
    Battle.AddBuff(GUEST_DIGIMON, 0, 194200)
  end
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  if Flg.Check("Battle5002") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 24223)
    Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_DIGIMON, 0)
    Flg.Set("Battle5003")
    if info.group ~= 2 or info.index == 0 then
    end
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_SUB_110_099_003")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
