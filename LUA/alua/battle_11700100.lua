require("include_battle")
Round = 0
EFF_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bs01")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  Battle.LoadEffectScript(EFF_01, "ef_b_sta_250")
  SetEndrollMember(11700100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(1, Util.SecondFromFrame(10))
end

function Battle_Start(info)
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m400_030")
    Fade.In(1, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(932, 0.5)
    Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(15))
  end
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local enemy_id = info.enemy_id
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
  if Flgcount() >= 3 then
    Flg.Set("Battle5051")
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    if Flg.Check("Battle5203") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 27333)
    elseif Flg.Check("Battle5203") and Flg.Check("Battle5205") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 27334)
    elseif Flg.Check("Battle5205") then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 47334)
    end
    Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    if Flg.Check("Battle5104") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0.21, 2.22, 4.08, 0.21, 4.5, -5.64, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      WaitFrame(15)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bs01", 0, false)
      Battle.PlayEffectScript(EFF_01, 0)
      Battle.SetEffectScriptPosition(EFF_01, 0.19, 0, -6.19)
      Battle.MessageTalk(1170010006)
      WaitFrame(80)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      WaitMessage()
      Battle.MessageTalk(1170010007)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5104")
    end
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 99901 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(200)
    else
      Battle.AddEnemyCP(400)
    end
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5052") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 47337)
    Flg.Set("Battle5052")
  end
  if enemy_id == 99901 and Flg.Check("Battle5052") and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 47337 then
    Battle.SetupCPCharge(70003, 94301, ENEMY_DIGIMON, 0, "FP01", 2)
    Flg.Set("Battle5053")
    Round = 0
    if Flg.Check("Battle5102") == false then
      Flg.Set("Battle5102")
    end
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
  end
  print("Round:", Round)
  if Round == 2 and Flg.Check("Battle5053") and enemy_id == 99901 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
end

function Battle_Action_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 99901 and Flg.Check("Battle5104") then
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
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    AddTarget_nobreakHP()
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70007 then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  end
  if round_count == 5 and Flg.Check("Battle5001") == false then
    Flg.Set("Battle5011")
  end
  if Round == 5 then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 1000) then
    Flg.Set("Battle5013")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
    Flg.Set("Battle5014")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 4000) then
    Flg.Set("Battle5015")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, 6000) then
    Flg.Set("Battle5016")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_PHYSICAL, 3, ENEMY_DIGIMON, 0, 3) then
    Flg.Set("Battle5017")
  end
  print("stock_num:", stock_num)
  if stock_num == 1 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32201)
  elseif stock_num == 1 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32231)
  elseif stock_num == 2 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30113)
  elseif stock_num == 2 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32161)
  elseif stock_num == 3 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32191)
  elseif stock_num == 3 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32131)
  elseif stock_num == 4 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30123)
  elseif stock_num == 4 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
  elseif 5 <= stock_num and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 34041)
  elseif 5 <= stock_num and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32241)
  end
  if stock_num == 0 or Flg.Check("Battle5052") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
    Battle.MessageTalk(1170010008)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 599901)
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 27331, 47333)
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    Flg.Set("Battle5203")
  end
  if 4 <= stock_num and Flg.Check("Battle5204") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 599904)
    Flg.Set("Battle5204")
  end
  if 5 <= stock_num and Flg.Check("Battle5205") == false then
    Flg.Set("Battle5205")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 27333 or Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 27334 or Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 47334 then
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
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    flgcount = 0
    Round = 0
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
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
    Flg.Clear("Battle5052")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5204")
    Flg.Clear("Battle5205")
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 599901)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 599902)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 599904)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 27331, -1)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    flgcount = 0
    Round = 0
    Battle.ClearCPCharge()
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
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
  Flg.Set("FLAG_MAIN_18_050")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(733, DIGIMON_GRASP_FLAG_SCAN)
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
