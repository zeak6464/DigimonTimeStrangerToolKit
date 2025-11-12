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
    Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(932, 0)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 70 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.SetStatus(GUEST_DIGIMON, 1, STATUS_TYPE_LV, 99)
  end
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
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70007 then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Round = 0
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5051")
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
  if info.group == GUEST_DIGIMON then
    if info.index == 0 then
      if Flg.Check("Battle5053") then
        Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30292)
      end
      if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
      elseif Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70004 then
        local target_list = {}
        local is_all_sleep = true
        for index = 0, 2 do
          if 0 < Battle.GetDigimonId(PLAYER_DIGIMON, index) and 0 < Battle.GetStatus(PLAYER_DIGIMON, index, STATUS_TYPE_HP) then
            target_list[#target_list + 1] = index
          end
        end
        if #target_list == 0 then
          is_all_sleep = false
        else
          for idx = 1, #target_list do
            if Battle.IsBuff(PLAYER_DIGIMON, target_list[idx], 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
              is_all_sleep = false
            end
          end
        end
        if is_all_sleep then
          math.randomseed(os.time())
          local random = math.random(1, #target_list)
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 31041)
          Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, PLAYER_DIGIMON, target_list[random])
        end
      end
    elseif info.index == 1 then
      if Flg.Check("Battle5053") then
        Battle.SetNextCommandTarget(GUEST_DIGIMON, 1, ADD_TARGET, 0)
        if round_count % 4 == 0 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 21731)
        else
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 21732)
        end
      end
      if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 10012)
      end
    end
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
  if info.group == ENEMY_DIGIMON and info.enemy_id == 99901 then
    local skill_id = Battle.GetLastCommandSkillID()
    if (skill_id == 27333 or skill_id == 27334 or skill_id == 47334) and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
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
  local weak_damage_num = enemy_max_hp * 0.13
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, weak_damage_num) then
    Flg.Set("Battle5015")
  end
  local total_damage_num = enemy_max_hp * 0.2
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, total_damage_num) then
    Flg.Set("Battle5016")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_PHYSICAL, 3, ENEMY_DIGIMON, 0, 4) then
    Flg.Set("Battle5017")
  end
  print("stock_num:", stock_num)
  if stock_num == 1 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
  elseif stock_num == 1 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30113)
  elseif stock_num == 2 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
  elseif stock_num == 2 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30063)
  elseif stock_num == 3 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32191)
  elseif stock_num == 3 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30123)
  elseif stock_num == 4 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
  elseif stock_num == 4 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30123)
  elseif 5 <= stock_num and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
  elseif 5 <= stock_num and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32061)
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
    if stock_num < 1 and Flg.Check("Battle5201") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 599901)
      Flg.Clear("Battle5201")
    end
    if stock_num < 2 and Flg.Check("Battle5202") then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 27331, -1)
      Flg.Clear("Battle5202")
    end
    if stock_num < 3 and Flg.Check("Battle5203") then
      Flg.Clear("Battle5203")
    end
    if stock_num < 4 and Flg.Check("Battle5204") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 599904)
      Flg.Clear("Battle5204")
    end
    if stock_num < 5 and Flg.Check("Battle5205") then
      Flg.Clear("Battle5205")
    end
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
