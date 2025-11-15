require("include_battle")
EFF_01 = 1

function Battle_Before_Setup()
  Battle.LoadEffectScript(EFF_01, "ef_b_hit_140_thunder")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn02")
  SetEndrollMember(11020030)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Sound.PlayBGM(928, 0)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
  Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 23792)
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
  Battle.SetRecoilMassage(23792, 25)
end

function Battle_Action_End(info)
  local enemy_id = info.enemy_id
  if enemy_id == 98502 then
    Battle.AttatchEffectScriptToModel(EFF_01, ENEMY_DIGIMON, 0)
    Battle.PlayEffectScript(EFF_01, 0)
  end
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 23792 and Flg.Check("FLAG_MAIN_10_045") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(1.85, 1.18, 10.33, 0.99, 3.54, 0.65, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn02", 0, true)
    Battle.MessageTalk(1102003001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("FLAG_MAIN_10_009")
    Battle.ForceEnd()
  end
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
