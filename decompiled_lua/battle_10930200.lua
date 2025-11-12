require("include_battle")
Round = 0
EFF_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleBGM(-1)
  Battle.LoadTalk("battle")
  Battle.LoadEffectScript(EFF_01, "ef_b_sta_250")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  SetEndrollMember(10930200)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  Sound.PlayBGM(806, 0)
end

function Battle_Start(info)
  Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, true)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 209002)
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local enemy_id = info.enemy_id
  Battle.AddBuffForRegionType(PLAYER_DIGIMON, 11, 507501)
  if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
    Round = Round + 1
  end
  if Flg.Check("Battle5053") then
    Round = Round + 1
    print("Round:", Round)
  end
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  if 2 <= round_count and Flgcount() >= 3 then
    Flg.Set("Battle5051")
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30263)
    Battle.SetNextCommandTarget(GUEST_DIGIMON, 1, ADD_TARGET, 0)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and info.group == 2 then
    if info.index == 0 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
    elseif info.index == 1 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 10012)
    end
  end
  if round_count == 2 and enemy_id == 95601 and Flg.Check("Battle5103") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m280_090")
    Flg.Set("Battle5103")
    Fade.In(1, Util.SecondFromFrame(30))
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 95601 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(200)
    else
      Battle.AddEnemyCP(400)
    end
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5052") == false then
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, false)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29562)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 209002)
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, true)
    Flg.Set("Battle5052")
  end
  if enemy_id == 95601 and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 29562 then
    Battle.SetupCPCharge(70003, 93301, ENEMY_DIGIMON, 0, "FP01", 2)
    Flg.Set("Battle5053")
    Round = 0
    if Flg.Check("Battle5102") == false then
      Flg.Set("Battle5102")
    end
  end
  print("Round:", Round)
  if Round == 2 and Flg.Check("Battle5053") and enemy_id == 95601 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29561)
    Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    if Flg.Check("Battle5104") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(1.03, 2.43, 0.98, -0.35, 1.7, -8.89, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(31)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 0, false)
      Battle.PlayEffectScript(EFF_01, 0)
      Battle.SetEffectScriptPosition(EFF_01, 0, 0, -8.43)
      Battle.MessageTalk(1093020011)
      WaitFrame(70)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5104")
    end
  end
end

function Battle_Action_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 95601 and Flg.Check("Battle5104") then
    Battle.StopEffectScript(EFF_01, 0.1)
  end
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
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Battle.AddBuff(ADD_TARGET, 0, 595603)
    Flg.Set("Battle5054")
  end
  local round_count = info.round
  if round_count == 6 and Flg.Check("Battle5101") == false then
    Flg.Set("Battle5011")
  end
  if Round == 6 and Flg.Check("Battle5101") then
    Flg.Set("Battle5012")
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
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_PHYSICAL, 2, ENEMY_DIGIMON, 0, 3) then
    Flg.Set("Battle5017")
  end
  if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
    Battle.MessageTalk(1093020010)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  local stock_num = Battle.GetCPStockNum()
  print("stock_num:", stock_num)
  if stock_num == 1 and Flg.Check("Battle5052") == false and round_count % 5 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29563)
  elseif stock_num == 1 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30053)
  elseif stock_num == 1 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33011)
    if Battle.IsBuff(PLAYER_DIGIMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 0)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 1, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 1)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 2, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 2)
    elseif Battle.IsBuff(GUEST_AEGIOMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_AEGIOMON, 0)
    end
  elseif stock_num == 2 and Flg.Check("Battle5052") == false and round_count % 5 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29563)
  elseif stock_num == 2 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32041)
  elseif stock_num == 2 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33011)
    if Battle.IsBuff(PLAYER_DIGIMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 0)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 1, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 1)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 2, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 2)
    elseif Battle.IsBuff(GUEST_AEGIOMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_AEGIOMON, 0)
    end
  elseif stock_num == 3 and Flg.Check("Battle5052") == false and round_count % 4 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29563)
  elseif stock_num == 3 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30303)
  elseif stock_num == 3 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33011)
    if Battle.IsBuff(PLAYER_DIGIMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 0)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 1, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 1)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 2, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 2)
    elseif Battle.IsBuff(GUEST_AEGIOMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_AEGIOMON, 0)
    end
  elseif stock_num == 4 and Flg.Check("Battle5052") == false and round_count % 4 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29563)
  elseif stock_num == 4 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30063)
  elseif stock_num == 4 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33011)
    if Battle.IsBuff(PLAYER_DIGIMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 0)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 1, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 1)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 2, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 2)
    elseif Battle.IsBuff(GUEST_AEGIOMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_AEGIOMON, 0)
    end
  elseif 5 <= stock_num and Flg.Check("Battle5052") == false and round_count % 4 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29563)
  elseif 5 <= stock_num and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
  elseif 5 <= stock_num and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33011)
    if Battle.IsBuff(PLAYER_DIGIMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 0)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 1, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 1)
    elseif Battle.IsBuff(PLAYER_DIGIMON, 2, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 2)
    elseif Battle.IsBuff(GUEST_AEGIOMON, 0, 103000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_AEGIOMON, 0)
    end
  end
  if stock_num == 0 or Flg.Check("Battle5052") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 595601)
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 595602)
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30062, 30063)
    Flg.Set("Battle5203")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 29561 then
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, false)
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5052")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 595603)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 209002)
    flgcount = 0
    Round = 0
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, true)
  end
  if Battle.IsBreakCPCharge() then
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, false)
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5052")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 595601)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 595602)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 595603)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30245, -1)
    flgcount = 0
    Round = 0
    Battle.ClearCPCharge()
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, true)
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
  if Flg.Check("Battle5017") then
    flgcount = flgcount + 1
  end
  return flgcount
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_09_070")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(163, DIGIMON_GRASP_FLAG_SCAN)
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
