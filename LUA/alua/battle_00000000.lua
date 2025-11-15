require("include_battle")
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
EFF_IN_03 = 4

function Battle_Before_Setup()
  print("=========== Battle_Before_Setup ===========")
end

function Battle_After_Setup()
  print("=========== Battle_After_Setup ===========")
end

function Battle_After_Build()
  print("=========== Battle_After_Build ===========")
end

function Battle_Opening(info)
  print("=========== Battle_Opening ===========")
  if Flg.Check("Battle5499") == false then
    math.randomseed(os.time())
    local random = math.random(1, 10000)
    print("random:", random)
    if 1 <= random and random <= 35 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 6902, 35)
      Flg.Set("Battle5001")
      Flg.Set("Battle5491")
    elseif 36 <= random and random <= 65 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 11302, 35)
      Flg.Set("Battle5001")
      Flg.Set("Battle5492")
    elseif 66 <= random and random <= 85 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 75302, 35)
      Flg.Set("Battle5001")
      Flg.Set("Battle5493")
    elseif 86 <= random and random <= 100 then
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 37402, 50)
      Flg.Set("Battle5001")
      Flg.Set("Battle5494")
    end
  elseif Flg.Check("Battle5491") then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 6902, 35)
    Flg.Set("Battle5001")
  elseif Flg.Check("Battle5492") then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 11302, 35)
    Flg.Set("Battle5001")
  elseif Flg.Check("Battle5493") then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 75302, 35)
    Flg.Set("Battle5001")
  elseif Flg.Check("Battle5494") then
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 37402, 50)
    Flg.Set("Battle5001")
  end
  if Flg.Check("Battle5001") then
    print("=========== SetVisibleCharacter ===========")
    Battle.CloseUI()
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
  end
end

function Battle_Start(info)
  print("=========== Battle_Start ===========")
  if Flg.Check("Battle5001") then
    print("=========== SetVisibleCharacter ===========")
    Battle.CloseUI()
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
  end
end

function Battle_Round_Start(info)
  print("=========== Battle_Round_Start ===========")
  if Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    Battle.CloseUI()
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
    Battle.SetCamera(3.33, 1.24, -0.04, 3.33, 0, -9.96, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.ExchangeMemberForDeleteTimingNextTurn(ENEMY_DIGIMON, 2)
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 2, BATTLE_INTERRUPT_TYPE_NORMAL, true)
    Flg.Set("Battle5002")
  end
end

function Battle_Turn_Start(info)
  print("=========== Battle_Turn_Start digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " group = ", info.group, " ===========")
  if Flg.Check("Battle5002") and Flg.Check("Battle5003") == false then
    Battle.CloseUI()
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
    Battle.SetCamera(3.33, 1.24, -0.04, 3.33, 0, -9.96, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 3.36, 0, -4.82)
    Battle.SetModelRotationY(ENEMY_DIGIMON, 2, 0)
    WaitFrame(15)
    Battle.LoadDissolveChangeIn(EFF_IN_01, ENEMY_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_01) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_01)
    WaitFrame(35)
    Flg.Set("Battle5003")
    Battle.ResetModelRotationY(ENEMY_DIGIMON, 2)
    Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_SELF, ENEMY_DIGIMON, 2)
    WaitFrame(10)
  end
end

function Battle_Command_Start(info)
  if Flg.Check("Battle5003") and Flg.Check("Battle5201") == false then
    Battle.CloseUI()
    if Flg.Check("Battle5491") then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 40011)
      Battle.AddBuff(ENEMY_DIGIMON, 2, 194090)
      Battle.AddBuff(ENEMY_DIGIMON, 2, 131090)
    elseif Flg.Check("Battle5492") then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 40010)
      Battle.AddBuff(ENEMY_DIGIMON, 2, 131090)
    elseif Flg.Check("Battle5493") then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 40012)
      Battle.AddBuff(ENEMY_DIGIMON, 2, 194090)
    elseif Flg.Check("Battle5494") then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 40013)
    end
    Flg.Set("Battle5201")
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local enemy0_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy1_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP)
  local enemy2_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP)
  local enemy_id = info.enemy_id
  if (enemy_id == 6902 or enemy_id == 11302 or enemy_id == 75302 or enemy_id == 37402) and Flg.Check("TUT_FLAG_4550") == false then
    Battle.CloseUI()
    OpenTutorial(1038)
    Flg.Set("TUT_FLAG_4550")
  end
  if Flg.Check("Battle5494") and enemy0_now_hp == 0 and enemy1_now_hp == 0 and 0 < enemy2_now_hp then
    Battle.RemoveBuff(ENEMY_DIGIMON, 2, 194090)
  end
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
