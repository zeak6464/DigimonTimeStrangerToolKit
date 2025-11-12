require("include_battle")
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
EXCHANGE_COUNT = 0
local reinforce_enemy_lv = 25
local is_high_difficulty = false
local REINFORCE_RATE_961 = 1
local REINFORCE_RATE_960 = 3
local REINFORCE_RATE_586 = 1
local REINFORCE_RATE_393 = 1
local REINFORCE_RATE_058 = 6
local REINFORCE_RATE_399 = 1
local RANDOM_RANGE_961 = REINFORCE_RATE_961
local RANDOM_RANGE_960 = RANDOM_RANGE_961 + REINFORCE_RATE_960
local RANDOM_RANGE_586 = RANDOM_RANGE_960 + REINFORCE_RATE_586
local RANDOM_RANGE_393 = RANDOM_RANGE_586 + REINFORCE_RATE_393
local RANDOM_RANGE_058 = RANDOM_RANGE_393 + REINFORCE_RATE_058
local RANDOM_RANGE_399 = RANDOM_RANGE_393 + REINFORCE_RATE_399

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  SetEndrollMember(10600100)
end

function Battle_After_Build()
  Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
end

function Battle_Opening(info)
  Fade.OutNotLoading(1, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m180_070")
    FadeAllIn(FADE_WHITE, FADE_TIME)
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(207, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    is_high_difficulty = true
    reinforce_enemy_lv = enemy_level - 2
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.UpgradeSkill(GUEST_DIGIMON, 0, 30212, 30213)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30155, 30156)
  end
  math.randomseed(os.time())
  local random = math.random(1, RANDOM_RANGE_058)
  if random <= RANDOM_RANGE_960 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96001, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_961 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96101, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_586 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 58601, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_393 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 39302, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_058 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 5801, reinforce_enemy_lv)
  end
  random = math.random(1, RANDOM_RANGE_399)
  if random <= RANDOM_RANGE_960 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96001, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_961 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96101, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_586 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 58601, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_393 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39302, reinforce_enemy_lv)
  elseif random <= RANDOM_RANGE_399 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39901, reinforce_enemy_lv)
  end
end

function Battle_Round_Start(info)
  math.randomseed(os.time())
  local random = math.random(1, 5)
  if EXCHANGE_COUNT <= 7 and Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP) == 0 then
    Battle.ExchangeMember(ENEMY_DIGIMON, 1)
    Flg.Set("Battle5002")
    local random = math.random(1, RANDOM_RANGE_058)
    if random <= RANDOM_RANGE_960 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96001, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_961 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96101, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_586 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 58601, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_393 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 39302, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_058 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 5801, reinforce_enemy_lv)
    end
  end
  if EXCHANGE_COUNT <= 7 and Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP) == 0 then
    Battle.ExchangeMember(ENEMY_DIGIMON, 2)
    Flg.Set("Battle5003")
    random = math.random(1, RANDOM_RANGE_399)
    if random <= RANDOM_RANGE_960 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96001, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_961 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96101, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_586 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 58601, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_393 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39302, reinforce_enemy_lv)
    elseif random <= RANDOM_RANGE_399 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39901, reinforce_enemy_lv)
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
  if Flg.Check("Battle5002") or Flg.Check("Battle5003") then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    WaitFrame(1)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(PLAYER_DIGIMON, 2, false)
    if Flg.Check("Battle5002") then
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
      Battle.SetModelPosition(ENEMY_DIGIMON, 1, -5.83, 0, -8.77)
    end
    if Flg.Check("Battle5003") then
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
      Battle.SetModelPosition(ENEMY_DIGIMON, 2, 5.83, 0, -8.77)
    end
    Battle.SetCamera(0.07, 1.81, 3.8, 0.03, 1.29, -6.18, DEFAULT_ANGLE, 40, MODE_QUADRATIC_IN_OUT)
    WaitFrame(41)
    if Flg.Check("Battle5002") then
      Battle.LoadDissolveChangeIn(EFF_IN_01, ENEMY_DIGIMON, 1)
    end
    if Flg.Check("Battle5003") then
      Battle.LoadDissolveChangeIn(EFF_IN_02, ENEMY_DIGIMON, 2)
    end
    while Battle.IsLoadingDissolve(EFF_IN_00) ~= false or Battle.IsLoadingDissolve(EFF_IN_01) ~= false or Battle.IsLoadingDissolve(EFF_IN_02) ~= false do
      WaitFrame(1)
    end
    if Flg.Check("Battle5002") then
      BtlPlayDissolve(EFF_IN_01)
      EXCHANGE_COUNT = EXCHANGE_COUNT + 1
    end
    if Flg.Check("Battle5003") then
      BtlPlayDissolve(EFF_IN_02)
      EXCHANGE_COUNT = EXCHANGE_COUNT + 1
    end
    if Flg.Check("Battle5101") == false then
      Battle.MessageTalk(1060010001)
      WaitMessage()
      Flg.Set("Battle5101")
    elseif Flg.Check("Battle5101") and Flg.Check("Battle5102") == false then
      Battle.MessageTalk(1060010002)
      WaitMessage()
      Flg.Set("Battle5102")
    elseif Flg.Check("Battle5102") and Flg.Check("Battle5103") == false then
      Battle.MessageTalk(1060010003)
      WaitMessage()
      Battle.MessageTalk(1060010004)
      WaitMessage()
      Flg.Set("Battle5103")
    elseif Flg.Check("Battle5103") then
      WaitFrame(40)
    end
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
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
  Flg.Clear("Battle5002")
  Flg.Clear("Battle5003")
  if Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP) == 0 then
    Battle.ForceWin()
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_06_050")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(401, DIGIMON_GRASP_FLAG_SCAN)
end
