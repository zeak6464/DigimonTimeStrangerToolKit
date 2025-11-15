require("include_battle")
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
EXCHANGE_COUNT = 0

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  math.randomseed(os.time())
  local random = math.random(1, 5)
  if random == 1 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96001, 23)
  elseif random == 2 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96101, 23)
  elseif random == 3 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 58601, 23)
  elseif random == 4 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 39302, 23)
  elseif random == 5 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 5801, 23)
  end
  random = math.random(1, 5)
  if random == 1 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96001, 23)
  elseif random == 2 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96101, 23)
  elseif random == 3 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 58601, 23)
  elseif random == 4 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39302, 23)
  elseif random == 5 then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39901, 23)
  end
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
    Sound.PlayBGM(207, 0.5)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  math.randomseed(os.time())
  local random = math.random(1, 5)
  if EXCHANGE_COUNT <= 6 and Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP) == 0 then
    Battle.ExchangeMember(ENEMY_DIGIMON, 1)
    Flg.Set("Battle5002")
    local random = math.random(1, 5)
    if random == 1 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96001, 23)
    elseif random == 2 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 96101, 23)
    elseif random == 3 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 58601, 23)
    elseif random == 4 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 39302, 23)
    elseif random == 5 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 5801, 23)
    end
  end
  if EXCHANGE_COUNT <= 6 and Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP) == 0 then
    Battle.ExchangeMember(ENEMY_DIGIMON, 2)
    Flg.Set("Battle5003")
    local random = math.random(1, 5)
    if random == 1 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96001, 23)
    elseif random == 2 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 96101, 23)
    elseif random == 3 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 58601, 23)
    elseif random == 4 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39302, 23)
    elseif random == 5 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 39901, 23)
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
      Battle.PlayDissolve(EFF_IN_01)
      EXCHANGE_COUNT = EXCHANGE_COUNT + 1
    end
    if Flg.Check("Battle5003") then
      Battle.PlayDissolve(EFF_IN_02)
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
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_06_050")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(401, DIGIMON_GRASP_FLAG_SCAN)
end
