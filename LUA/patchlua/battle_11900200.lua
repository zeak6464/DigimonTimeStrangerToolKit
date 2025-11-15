require("include_battle")
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
EFF_IN_03 = 4
local reinforce_enemy_lv = 53
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
  SetEndrollMember(11900200)
end

function Battle_After_Build()
  Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
end

function Battle_Opening(info)
  Battle.PlayBGM(931, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 90 < enemy_level then
    is_high_difficulty = true
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.SetStatus(GUEST_DIGIMON, 1, STATUS_TYPE_LV, 99)
    reinforce_enemy_lv = 99
  end
  math.randomseed(os.time())
  local random = math.random(1, 2)
  if random == 1 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 87101, reinforce_enemy_lv)
  elseif random == 2 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 87201, reinforce_enemy_lv)
  end
  random = math.random(1, 2)
  if random == 1 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 87101, reinforce_enemy_lv)
  elseif random == 2 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 87201, reinforce_enemy_lv)
  end
end

function Battle_Round_Start(info)
  local round_count = info.round
  if 2 <= round_count then
    if round_count % 3 == 1 then
      Battle.SetCamera(12.26, 1.29, -2.57, 17.93, 1.2, 5.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 16.12, 0, 2.81)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, true)
      Battle.LoadDissolveChangeOut(EFF_IN_03, GUEST_DIGIMON, 0)
      while Battle.IsLoadingDissolve(EFF_IN_03) do
        WaitFrame(1)
      end
      BtlPlayDissolve(EFF_IN_03)
      while Battle.IsPlayingDissolve(EFF_IN_03) do
        WaitFrame(1)
      end
      Battle.ExchangeMember(GUEST_DIGIMON, 0)
      Flg.Set("Battle5004")
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 23941)
      Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
    elseif round_count % 3 == 2 then
      Battle.SetCamera(12.26, 1.29, -2.57, 17.93, 1.2, 5.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 16.12, 0, 2.81)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, true)
      Battle.LoadDissolveChangeOut(EFF_IN_03, GUEST_DIGIMON, 0)
      while Battle.IsLoadingDissolve(EFF_IN_03) do
        WaitFrame(1)
      end
      BtlPlayDissolve(EFF_IN_03)
      while Battle.IsPlayingDissolve(EFF_IN_03) do
        WaitFrame(1)
      end
      Common.DeleteGuest(23941)
      Battle.ExchangeMember(GUEST_DIGIMON, 0)
      Flg.Set("Battle5005")
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 25791)
      Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba01")
    elseif round_count % 3 == 0 then
      Battle.SetCamera(12.26, 1.29, -2.57, 17.93, 1.2, 5.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 16.12, 0, 2.81)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, true)
      Battle.LoadDissolveChangeOut(EFF_IN_03, GUEST_DIGIMON, 0)
      while Battle.IsLoadingDissolve(EFF_IN_03) do
        WaitFrame(1)
      end
      BtlPlayDissolve(EFF_IN_03)
      while Battle.IsPlayingDissolve(EFF_IN_03) do
        WaitFrame(1)
      end
      Battle.ExchangeMember(GUEST_DIGIMON, 0)
      Flg.Set("Battle5006")
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 25801)
      Battle.LoadAnimation(GUEST_DIGIMON, 0, "bs01")
    end
  end
  math.randomseed(os.time())
  local random = math.random(1, 2)
  if Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP) == 0 then
    Battle.ExchangeMember(ENEMY_DIGIMON, 1)
    Flg.Set("Battle5002")
    local random = math.random(1, 2)
    if random == 1 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 87101, reinforce_enemy_lv)
    elseif random == 2 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 87201, reinforce_enemy_lv)
    end
  end
  if Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP) == 0 then
    Battle.ExchangeMember(ENEMY_DIGIMON, 2)
    Flg.Set("Battle5003")
    local random = math.random(1, 2)
    if random == 1 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 87101, reinforce_enemy_lv)
    elseif random == 2 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 87201, reinforce_enemy_lv)
    end
  end
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5002") then
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
  end
  if Flg.Check("Battle5003") then
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
  end
  if Flg.Check("Battle5004") then
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
  end
  if Flg.Check("Battle5005") then
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
  end
  if Flg.Check("Battle5006") then
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
  end
  local round_count = info.round
  if Flg.Check("Battle5004") or Flg.Check("Battle5005") or Flg.Check("Battle5006") then
    Battle.CloseUI()
    WaitFrame(1)
    if Flg.Check("Battle5004") then
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
      Battle.SetCamera(12.26, 1.29, -2.57, 17.93, 1.2, 5.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 16.12, 0, 2.81)
      WaitFrame(30)
      Battle.LoadDissolveChangeIn(EFF_IN_00, GUEST_DIGIMON, 0)
      while Battle.IsLoadingDissolve(EFF_IN_00) ~= false do
        WaitFrame(1)
      end
      BtlPlayDissolve(EFF_IN_00)
      WaitFrame(35)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, true)
      Talk.OpenLetterBox()
      Battle.MessageTalk(1190020001)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Clear("Battle5004")
    elseif Flg.Check("Battle5005") then
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
      Battle.SetCamera(12.26, 1.29, -2.57, 17.93, 1.2, 5.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 16.12, 0, 2.81)
      WaitFrame(30)
      if Flg.Check("Battle5005") then
        Battle.LoadDissolveChangeIn(EFF_IN_00, GUEST_DIGIMON, 0)
      end
      while Battle.IsLoadingDissolve(EFF_IN_00) ~= false do
        WaitFrame(1)
      end
      if Flg.Check("Battle5005") then
        BtlPlayDissolve(EFF_IN_00)
      end
      WaitFrame(35)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "ba01", 0, true)
      Talk.OpenLetterBox()
      Battle.MessageTalk(1190020002)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Clear("Battle5005")
    elseif Flg.Check("Battle5006") then
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
      Battle.SetCamera(12.26, 1.29, -2.57, 17.93, 1.2, 5.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 16.12, 0, 2.81)
      WaitFrame(30)
      if Flg.Check("Battle5006") then
        Battle.LoadDissolveChangeIn(EFF_IN_00, GUEST_DIGIMON, 0)
      end
      while Battle.IsLoadingDissolve(EFF_IN_00) ~= false do
        WaitFrame(1)
      end
      if Flg.Check("Battle5006") then
        BtlPlayDissolve(EFF_IN_00)
      end
      WaitFrame(35)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "bs01", 0, true)
      Talk.OpenLetterBox()
      Battle.MessageTalk(1190020003)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Clear("Battle5006")
    end
    if is_high_difficulty then
      Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    end
  end
  if Flg.Check("Battle5002") or Flg.Check("Battle5003") then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    WaitFrame(1)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 2, false)
    if Flg.Check("Battle5002") then
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
      Battle.SetModelPosition(ENEMY_DIGIMON, 1, -8.58, 0, -7.07)
    end
    if Flg.Check("Battle5003") then
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
      Battle.SetModelPosition(ENEMY_DIGIMON, 2, 7.38, 0, -7.1)
    end
    Battle.SetCamera(0.69, 6.5, 13.14, 0.69, 5.75, 3.17, DEFAULT_ANGLE, 40, MODE_QUADRATIC_IN_OUT)
    WaitFrame(41)
    if Flg.Check("Battle5002") then
      Battle.LoadDissolveChangeIn(EFF_IN_02, ENEMY_DIGIMON, 1)
    end
    if Flg.Check("Battle5003") then
      Battle.LoadDissolveChangeIn(EFF_IN_03, ENEMY_DIGIMON, 2)
    end
    while Battle.IsLoadingDissolve(EFF_IN_02) ~= false or Battle.IsLoadingDissolve(EFF_IN_03) ~= false do
      WaitFrame(1)
    end
    if Flg.Check("Battle5002") then
      BtlPlayDissolve(EFF_IN_02)
    end
    if Flg.Check("Battle5003") then
      BtlPlayDissolve(EFF_IN_03)
    end
    WaitFrame(65)
    Talk.CloseLetterBox()
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
  Flg.Clear("Battle5002")
  Flg.Clear("Battle5003")
  if Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP) == 0 then
    Battle.ForceWin()
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_22_150")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(36, DIGIMON_GRASP_FLAG_SCAN)
  Common.SetDigimonGraspState(627, DIGIMON_GRASP_FLAG_SCAN)
  Common.SetDigimonGraspState(404, DIGIMON_GRASP_FLAG_SCAN)
end
