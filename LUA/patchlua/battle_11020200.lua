require("include_battle")
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
EFF_IN_03 = 4
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadTalk("battle")
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 27671)
end

function Battle_After_Setup()
  SetEndrollMember(11020200)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m300_080")
    Fade.In(1, Util.SecondFromFrame(30))
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(806, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 70 < enemy_level then
    is_high_difficulty = true
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.SetStatus(GUEST_DIGIMON, 1, STATUS_TYPE_LV, 99)
    Battle.UpgradeSkill(GUEST_DIGIMON, 1, 30212, 30213)
  end
end

function Battle_Round_Start(info)
  local round_count = info.round
  if round_count == 1 and Flg.Check("Battle5007") == false then
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_TURN_ORDER_TOP, true)
  end
  if round_count % 4 == 1 then
    Flg.Clear("Battle5006")
  end
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  if round_count == 1 and enemy_id == 87701 and Flg.Check("Battle5007") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30073)
    Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_DIGIMON, 0)
    Flg.Set("Battle5007")
  end
  if Flg.Check("Battle5004") and Flg.Check("Battle5005") == false then
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 9.55, 0, 7.5)
    Battle.SetCamera(5.36, 1.94, -1.02, 11.51, 2.69, 6.28, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 10.07, 0, 5.27)
    WaitFrame(30)
    Battle.LoadDissolveChangeIn(EFF_IN_01, GUEST_DIGIMON, 0)
    while Battle.IsLoadingDissolve(EFF_IN_00) ~= false or Battle.IsLoadingDissolve(EFF_IN_01) ~= false do
      WaitFrame(1)
    end
    BtlPlayDissolve(EFF_IN_01)
    WaitFrame(35)
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 27671)
    if is_high_difficulty then
      Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    end
    Flg.Set("Battle5005")
  end
end

function Battle_Command_Start(info)
  local round_count = info.round
  if info.enemy_id == 87701 then
    if Battle.IsBuff(ENEMY_DIGIMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) or Battle.IsBuff(ENEMY_DIGIMON, 0, 105000, BUFF_CHECK_OR_WITHOUT_ID) or Battle.IsBuff(ENEMY_DIGIMON, 0, 106000, BUFF_CHECK_OR_WITHOUT_ID) or Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) or Battle.IsBuff(ENEMY_DIGIMON, 0, 205000, BUFF_CHECK_OR_WITHOUT_ID) then
      Battle.AddEnemyCP(0)
    else
      Battle.AddEnemyCP(500)
    end
    if round_count % 4 == 0 and Flg.Check("Battle5006") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 21284)
      Flg.Set("Battle5006")
    end
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local stock_num = Battle.GetCPStockNum()
  local enemy_id = info.enemy_id
  local digimon_id = info.digimon_id
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_now_hp / enemy_max_hp <= 0.5 and Flg.Check("Battle5008") == false then
    Flg.Set("Battle5008")
  end
  if enemy_id == 87701 and Flg.Check("Battle5001") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m300_090")
    Fade.In(1, Util.SecondFromFrame(10))
    Flg.Set("Battle5001")
  end
  if (round_count == 2 or Flg.Check("Battle5008")) and info.group == 2 and digimon_id == 232 and Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m300_091")
    Fade.In(1, Util.SecondFromFrame(10))
    Flg.Set("Battle5002")
  end
  if (round_count == 3 or Flg.Check("Battle5008")) and info.group == 2 and digimon_id == 179 and Flg.Check("Battle5002") and Flg.Check("Battle5003") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m300_092")
    Fade.In(1, Util.SecondFromFrame(10))
    Flg.Set("Battle5003")
  end
  if Flg.Check("Battle5003") and Flg.Check("Battle5008") and info.group == 2 and digimon_id == 179 and Flg.Check("Battle5004") == false and 1 <= enemy_now_hp then
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, false)
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m300_093")
    Fade.In(1, Util.SecondFromFrame(10))
    Battle.SetCamera(5.36, 1.94, -1.02, 11.51, 2.69, 6.28, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 10.07, 0, 5.27)
    Battle.LoadDissolveChangeOut(EFF_IN_03, GUEST_DIGIMON, 0)
    while Battle.IsPlayingDissolve(EFF_IN_03) do
      WaitFrame(1)
    end
    BtlPlayDissolve(EFF_IN_03)
    while Battle.IsPlayingDissolve(EFF_IN_03) do
      WaitFrame(1)
    end
    Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 0)
    BtlSetInterruptCharacter(GUEST_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL, true)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    Flg.Set("Battle5004")
  end
  print("stock_num:", stock_num)
  if 2 <= stock_num or Flg.Check("Battle5006") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 21283)
  elseif 1 <= stock_num then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
  else
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_10_050")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(128, DIGIMON_GRASP_FLAG_SCAN)
end
