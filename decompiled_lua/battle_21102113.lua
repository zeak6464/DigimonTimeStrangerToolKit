require("include_battle")
EFF_IN_01 = 1
EFF_IN_02 = 2
OBJ_01 = 1
OBJ_02 = 2

function Battle_Before_Setup()
  Battle.LoadObject(OBJ_01, "d0276floor00")
  Battle.LoadObject(OBJ_02, "d0276floor01")
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 71802, 80)
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 71802, 80)
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 1, "ba02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 2, "ba02")
end

function Battle_After_Build()
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.SetObjectVisible(OBJ_02, false)
end

function Battle_Opening(info)
  Battle.PlayBGM(215, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208004)
end

function Battle_Round_Start(info)
  local round_count = info.round
  if round_count % 4 == 0 then
    if Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP) == 0 then
      Battle.ExchangeMember(ENEMY_DIGIMON, 1)
      Flg.Set("Battle5001")
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 71802, 80)
    end
    if Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP) == 0 then
      Battle.ExchangeMember(ENEMY_DIGIMON, 2)
      Flg.Set("Battle5002")
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 71802, 80)
    end
  end
end

function Battle_Turn_Start(info)
  if Flgcount() >= 3 then
    Flg.Set("Battle5051")
  end
  if Flg.Check("Battle5001") then
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
  end
  if Flg.Check("Battle5002") then
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
  end
end

function Battle_Command_Start(info)
  if Flg.Check("Battle5051") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 27033)
    Flg.Clear("Battle5051")
    flgcount = 0
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
    Flg.Set("Battle5014")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, ENEMY_DIGIMON, 0, 2) then
    Flg.Set("Battle5015")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_PLAYER_SIDE_TOTAL_DAMAGE_VALUE_OVER, 0, ENEMY_DIGIMON, 0, 10000) then
    Flg.Set("Battle5016")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_MAGIC, 3, ENEMY_DIGIMON, 0, 5) then
    Flg.Set("Battle5017")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 27033 then
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  end
  if Flg.Check("Battle5001") or Flg.Check("Battle5002") then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    WaitFrame(1)
    if Flg.Check("Battle5001") then
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
      Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0.23, 0, -5.6)
    end
    if Flg.Check("Battle5002") then
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
      Battle.SetModelPosition(ENEMY_DIGIMON, 2, 5.17, 0, -5.6)
    end
    Battle.SetCamera(0.64, 2.1, 3.78, 0.19, 2.14, -6.21, DEFAULT_ANGLE, 40, MODE_QUADRATIC_IN_OUT)
    WaitFrame(41)
    Battle.LoadTalk("battle")
    if Flg.Check("Battle5001") then
      Battle.LoadDissolveChangeIn(EFF_IN_01, ENEMY_DIGIMON, 1)
    end
    if Flg.Check("Battle5002") then
      Battle.LoadDissolveChangeIn(EFF_IN_02, ENEMY_DIGIMON, 2)
    end
    while Battle.IsLoadingDissolve(EFF_IN_01) ~= false or Battle.IsLoadingDissolve(EFF_IN_02) ~= false do
      WaitFrame(1)
    end
    if Flg.Check("Battle5001") then
      Battle.PlayDissolve(EFF_IN_01)
    end
    if Flg.Check("Battle5002") then
      Battle.PlayDissolve(EFF_IN_02)
    end
    WaitFrame(25)
    if Flg.Check("Battle5001") then
      BtlPlayAnimation(ENEMY_DIGIMON, 1, "ba02", 10, true)
    end
    if Flg.Check("Battle5002") then
      BtlPlayAnimation(ENEMY_DIGIMON, 2, "ba02", 10, true)
    end
    Talk.CloseLetterBox()
    Flg.Clear("Battle5001")
    Flg.Clear("Battle5002")
  end
end

function Flgcount()
  local flgcount = 0
  if Flg.Check("Battle5014") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5015") then
    flgcount = flgcount + 3
  end
  if Flg.Check("Battle5016") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5017") then
    flgcount = flgcount + 1
  end
  return flgcount
end

function Battle_Win(info)
  Flg.Set("FLAG_SUB_110_211_004")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(703, DIGIMON_GRASP_FLAG_SCAN)
end
