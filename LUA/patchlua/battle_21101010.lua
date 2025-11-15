require("include_battle")
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 23821)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Battle.PlayBGM(929, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 90 < enemy_level then
    is_high_difficulty = true
  end
end

function Battle_Round_Start(info)
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if (round_count == 3 or enemy_now_hp / enemy_max_hp < 0.5) and Flg.Check("Battle5001") == false then
    Battle.ExchangeMember(GUEST_DIGIMON, 0)
    Flg.Set("Battle5001")
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
  end
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(0.85, 1.34, 26.7, 0.47, 2.69, 36.6, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 0.54, 0, 35.24)
    Battle.SetModelRotationY(GUEST_DIGIMON, 0, 180)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 0, false)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 0, true)
    Battle.MessageTalk(2110101001)
    WaitMessage()
    Battle.MessageTalk(2110101002)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5002")
    if is_high_difficulty then
      Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    end
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
end

function Battle_Win(info)
  Battle.DeleteMember(GUEST_DIGIMON, 0)
  Flg.Set("FLAG_SUB_110_101_003")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(214, DIGIMON_GRASP_FLAG_SCAN)
end
