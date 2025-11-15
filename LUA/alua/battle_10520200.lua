require("include_battle")
Round = 0

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  SetEndrollMember(10520200)
end

function Battle_After_Build()
  Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  Sound.PlayBGM(930, 0.5)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
    Round = Round + 1
  end
  if Flg.Check("Battle5053") then
    Round = Round + 1
    print("Round:", Round)
  end
end

function Battle_Turn_Start(info)
  if Flgcount() >= 3 then
    Flg.Set("Battle5051")
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if Flg.Check("Battle5053") and info.group == 2 then
    if info.index == 0 then
      Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
    elseif info.index == 1 then
      Battle.SetNextCommandTarget(GUEST_DIGIMON, 1, ADD_TARGET, 0)
    end
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and info.group == 2 then
    if info.index == 0 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
    elseif info.index == 1 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 10012)
    end
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29061)
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 90601 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(400)
    else
      Battle.AddEnemyCP(600)
    end
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5053") == false and enemy_id == 90601 then
    Battle.SetupCPCharge(70003, 92801, ENEMY_DIGIMON, 0, "FP01", 2)
    Flg.Set("Battle5053")
    Round = 0
    if Battle.IsBuff(ENEMY_DIGIMON, 0, 208003, BUFF_CHECK_AND_WITH_ID) then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208003)
      Flg.Set("Battle5018")
    end
    if Flg.Check("Battle5102") == false then
      Flg.Set("Battle5102")
    end
  end
  print("Round:", Round)
  if Round == 2 and Flg.Check("Battle5053") and enemy_id == 90601 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Flg.Check("Battle5053") and info.group == 1 then
    if info.index == 1 then
      if Battle.IsBuff(ENEMY_DIGIMON, 1, 203100, BUFF_CHECK_AND_WITH_ID) == false and Battle.IsBuff(ENEMY_DIGIMON, 2, 203100, BUFF_CHECK_AND_WITH_ID) == false then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 34011)
      end
    elseif info.index == 2 and Battle.IsBuff(ENEMY_DIGIMON, 1, 203100, BUFF_CHECK_AND_WITH_ID) == false and Battle.IsBuff(ENEMY_DIGIMON, 2, 203100, BUFF_CHECK_AND_WITH_ID) == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 34011)
    end
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
end

function Battle_Action_Start(info)
  local AddTarget_HP_MAX = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5053") and Flg.Check("Battle5300") == false and Flg.Check("Battle5399") and Round == 0 then
    if Flg.Check("Battle5351") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX * 0.75)
      Flg.Clear("Battle5351")
      Flg.Clear("Battle5399")
    elseif Flg.Check("Battle5352") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX * 0.5)
      Flg.Clear("Battle5352")
      Flg.Clear("Battle5399")
    elseif Flg.Check("Battle5353") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX * 0.25)
      Flg.Clear("Battle5353")
      Flg.Clear("Battle5399")
    end
    Flg.Set("Battle5300")
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    AddTarget_nobreakHP()
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  if Round == 4 then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 1000) then
    Flg.Set("Battle5013")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
    Flg.Set("Battle5014")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 3000) then
    Flg.Set("Battle5015")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, 3500) then
    Flg.Set("Battle5016")
  end
  print("stock_num:", stock_num)
  if stock_num == 1 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32071)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif stock_num == 1 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32211)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif stock_num == 2 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32191)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif stock_num == 2 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33021)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif stock_num == 3 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 34041)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif stock_num == 3 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 34021)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif stock_num == 4 and Flg.Check("Battle5052") == false then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30065)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif 5 <= stock_num and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33051)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  elseif 5 <= stock_num and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    if 0.2 <= enemy_now_hp / enemy_max_hp then
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32201)
    else
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    end
  end
  if stock_num == 0 or Flg.Check("Battle5051") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
    Battle.MessageTalk(105202001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 590601)
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 590602)
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30245, 30246)
    Flg.Set("Battle5203")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 29061 then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    flgcount = 0
    Round = 0
    if Flg.Check("Battle5018") then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
      Flg.Clear("Battle5018")
    end
  end
  if Battle.IsBreakCPCharge() then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590601)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590602)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30245, -1)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30245)
    flgcount = 0
    Round = 0
    if Flg.Check("Battle5018") then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
      Flg.Clear("Battle5018")
    end
    Battle.ClearCPCharge()
  end
  if Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP) == 0 then
    Battle.ForceWin()
  end
end

function Flgcount()
  local flgcount = 0
  if Flg.Check("Battle5011") then
    flgcount = flgcount + 3
  end
  if Flg.Check("Battle5012") then
    flgcount = flgcount + 3
  end
  if Flg.Check("Battle5013") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5014") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5015") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5016") then
    flgcount = flgcount + 1
  end
  return flgcount
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_05_101")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(907, DIGIMON_GRASP_FLAG_SCAN)
end

function AddTarget_nobreakHP()
  local AddTarget_HP_MAX = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  local AddTarget_HP_ratio = AddTarget_HP / AddTarget_HP_MAX
  if AddTarget_HP_ratio < 0.25 then
    Flg.Set("Battle5353")
    Flg.Set("Battle5399")
  elseif AddTarget_HP_ratio < 0.5 then
    Flg.Set("Battle5352")
    Flg.Set("Battle5399")
  elseif AddTarget_HP_ratio < 0.75 then
    Flg.Set("Battle5351")
    Flg.Set("Battle5399")
  end
end
