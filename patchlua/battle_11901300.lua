require("include_battle")
Round = 0
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 27422)
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 20571)
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 2, 20832)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
  Battle.LoadAnimation(GUEST_DIGIMON, 1, "bf01")
  Battle.LoadAnimation(GUEST_DIGIMON, 1, "bn01")
  Battle.LoadAnimation(GUEST_DIGIMON, 2, "fe02")
  Battle.LoadAnimation(GUEST_DIGIMON, 2, "bn01")
  SetEndrollMember(11901300)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(931, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 90 < enemy_level then
    is_high_difficulty = true
  end
end

function Battle_Round_Start(info)
  local round_count = info.round
  if round_count == 2 and Flg.Check("Battle5001") == false then
    Battle.ExchangeMember(GUEST_DIGIMON, 0)
    Battle.ExchangeMember(GUEST_DIGIMON, 1)
    Battle.ExchangeMember(GUEST_DIGIMON, 2)
    Flg.Set("Battle5001")
  end
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    Talk.OpenLetterBox()
    Battle.LoadAnimation(GUEST_DIGIMON, 1, "bf01")
    Battle.LoadAnimation(GUEST_DIGIMON, 1, "bn01")
    Battle.CloseUI()
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
    Battle.SetCamera(-3.57, 1.72, 0.81, -2.84, 1.54, 10.79, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -3.22, 0, 6.15)
    Battle.SetModelRotationY(GUEST_DIGIMON, 0, 180)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -60.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -61.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -67.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -67.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 2, -77.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -62.49, 0, 9.24)
    WaitFrame(15)
    Battle.LoadDissolveChangeIn(EFF_IN_00, GUEST_DIGIMON, 0)
    while Battle.IsLoadingDissolve(EFF_IN_00) ~= false do
      WaitFrame(1)
    end
    BtlPlayDissolve(EFF_IN_00)
    WaitFrame(25)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 0, false)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 0, true)
    Battle.MessageTalk(1190130001)
    WaitMessage()
    Battle.MessageTalk(1190130002)
    WaitMessage()
    Battle.CloseTalk()
    Battle.SetCamera(-2.68, 1.4, 1.63, -5.97, 1.54, 11.07, DEFAULT_ANGLE, 20, MODE_QUADRATIC_IN_OUT)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, false)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -5.8, 0, 5.78)
    Battle.SetModelRotationY(GUEST_DIGIMON, 1, 140)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -60.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -61.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -67.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -62.49, 0, 9.24)
    WaitFrame(21)
    Battle.LoadDissolveChangeIn(EFF_IN_01, GUEST_DIGIMON, 1)
    while Battle.IsLoadingDissolve(EFF_IN_01) ~= false do
      WaitFrame(1)
    end
    BtlPlayDissolve(EFF_IN_01)
    WaitFrame(25)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "bf01", 0, false)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "bn01", 0, true)
    Battle.MessageTalk(1190130003)
    WaitMessage()
    Battle.CloseTalk()
    Battle.SetCamera(-3.41, 1.43, -0.57, -3.19, 1.54, 9.42, DEFAULT_ANGLE, 20, MODE_QUADRATIC_IN_OUT)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 2, false)
    Battle.SetModelPosition(GUEST_DIGIMON, 2, -0.16, 0, 6.14)
    Battle.SetModelRotationY(GUEST_DIGIMON, 2, -130)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -60.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -61.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -67.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -62.49, 0, 9.24)
    WaitFrame(21)
    Battle.LoadDissolveChangeIn(EFF_IN_02, GUEST_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_02) ~= false do
      WaitFrame(1)
    end
    BtlPlayDissolve(EFF_IN_02)
    WaitFrame(25)
    BtlPlayAnimation(GUEST_DIGIMON, 2, "fe02", 0, false)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 2, "bn01", 0, true)
    Battle.MessageTalk(1190130004)
    WaitMessage()
    Battle.CloseTalk()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5002")
    Battle.ResetModelRotationY(GUEST_DIGIMON, 0)
    Battle.ResetModelRotationY(GUEST_DIGIMON, 1)
    Battle.ResetModelRotationY(GUEST_DIGIMON, 2)
    if is_high_difficulty then
      Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
      Battle.SetStatus(GUEST_DIGIMON, 1, STATUS_TYPE_LV, 99)
      Battle.SetStatus(GUEST_DIGIMON, 2, STATUS_TYPE_LV, 99)
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
  Flg.Set("FLAG_MAIN_22_284")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
