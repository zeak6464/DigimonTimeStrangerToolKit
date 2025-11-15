require("include_battle")
Round = 0
Round_syn = 0
EFF_01 = 1
EFF_02 = 2
EFF_03 = 3
EFF_04 = 4
EFF_05 = 5

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "f000")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba01")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe01")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe04")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "fe04")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e002")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e008")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e203")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e017")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "bn01")
  Battle.LoadEffectScript(EFF_01, "ef_b_gda_a02")
  Battle.LoadEffectScript(EFF_02, "ef_b_bos_142")
  Battle.LoadEffectScript(EFF_03, "ef_b_bos_148")
  Battle.LoadEffectScript(EFF_04, "ef_f_mov_111_wa")
  Battle.SetEffectScriptPosition(EFF_04, 0, 1, 9.07)
  Battle.LoadEffectScript(EFF_05, "ef_f_mov_111_wa")
  Battle.SetEffectScriptPosition(EFF_05, 0, 1, 9.07)
  Battle.LoadTalk("battle")
  SetEndrollMember(11200010)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.SetIsRecoveryInvalidationAddCountdownDeath(true)
  Battle.SetupRecoveryInvalidationAddCountdownDeathEffect()
end

function Battle_Opening(info)
  Fade.In(1, Util.SecondFromFrame(30))
  Sound.PlayBGM(931, 0.5)
end

function Battle_Start(info)
  basemax_hp_enemy = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  if Flg.Check("Battle5114") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(7.98, 0.48, 5.75, 2.25, 2.7, -2.13, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 7.74, 0, 4.65)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.MessageTalk(1120001021)
    WaitMessage()
    Battle.MessageTalk(1120001022)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5114")
  end
  if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
    Round = Round + 1
  end
  if Flg.Check("Battle5053") then
    Round = Round + 1
    print("Round:", Round)
  end
  if Flg.Check("Battle5113") then
    Round_syn = Round_syn + 1
    print("Round:", Round)
  end
  if Round_syn == 6 then
    Flg.Clear("Battle5112")
    Flg.Clear("Battle5113")
    Flg.Clear("Battle5122")
  end
end

function Battle_Turn_Start(info)
  local skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if Flg.Check("Battle5120") and Flg.Check("Battle5121") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(7.98, 0.48, 5.75, 2.25, 2.7, -2.13, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 7.74, 0, 4.65)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.MessageTalk(1120001026)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5121")
  end
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_id = info.enemy_id
  if enemy_id == 91601 and (skill_id == 29165 or skill_id == 29166 or skill_id == 29166) and Battle.IsBuff(1, 0, 105000, BUFF_CHECK_OR_WITHOUT_ID) then
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 105100)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 110100)
  end
  if Flgcount() >= 3 then
    Flg.Set("Battle5051")
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and Flg.Check("Battle5102") == false and info.group == 2 and info.index == 0 then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  local skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if enemy_id == 91601 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(100)
    else
      Battle.AddEnemyCP(200)
    end
  end
  local target_list = {}
  for idx = 0, 2 do
    if 0 < Battle.GetDigimonId(PLAYER_DIGIMON, idx) and 0 < Battle.GetStatus(PLAYER_DIGIMON, idx, STATUS_TYPE_HP) then
      local player_data = {
        group = PLAYER_DIGIMON,
        index = idx
      }
      target_list[#target_list + 1] = player_data
    end
  end
  local target_idx = math.random(0, #target_list)
  local stock_num = Battle.GetCPStockNum()
  if enemy_id == 91601 and Flg.Check("Battle5052") and Flg.Check("Battle5053") == false then
    Battle.SetupCPCharge(70003, 93601, ENEMY_DIGIMON, 0, "FP01", 2)
    Battle.AddCPChargeParts(93701, ENEMY_DIGIMON, 0, "FP02")
    Battle.AddCPChargeParts(93801, ENEMY_DIGIMON, 0, "FP03")
    Battle.AddCPChargeParts(93901, ENEMY_DIGIMON, 0, "FP04")
    Battle.SetIsRecoveryInvalidationAddCountdownDeath(false)
    Flg.Set("Battle5053")
    Round = 0
    if Flg.Check("Battle5106") == false then
      Flg.Set("Battle5106")
    end
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5052") == false and enemy_id == 91601 then
    if stock_num == 0 then
      Flg.Set("Battle5052")
    elseif stock_num == 1 then
      if Battle.IsBuff(1, 0, 105000, BUFF_CHECK_OR_WITHOUT_ID) then
        print("##### confusion enemy #####")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29165)
        Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, ENEMY_DIGIMON, 0)
        Flg.Set("Battle5052")
        Flg.Set("Battle5116")
      else
        print("##### confusion player #####")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29165)
        Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, target_idx)
        Flg.Set("Battle5119")
        Flg.Set("Battle5052")
      end
    elseif stock_num == 2 then
      if Battle.IsBuff(1, 0, 105000, BUFF_CHECK_OR_WITHOUT_ID) then
        print("##### confusion enemy #####")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29166)
        Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, ENEMY_DIGIMON, 0)
        Flg.Set("Battle5052")
        Flg.Set("Battle5116")
      else
        print("##### confusion player #####")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29166)
        Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, target_idx)
        Flg.Set("Battle5119")
        Flg.Set("Battle5052")
      end
    elseif 3 <= stock_num then
      if Battle.IsBuff(1, 0, 105000, BUFF_CHECK_OR_WITHOUT_ID) then
        print("##### confusion enemy #####")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29166)
        Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, ENEMY_DIGIMON, 0)
        Flg.Set("Battle5052")
        Flg.Set("Battle5116")
      else
        print("##### confusion player #####")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29166)
        Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, target_idx)
        Flg.Set("Battle5119")
        Flg.Set("Battle5052")
      end
    end
  end
  print("Round:", Round)
  if Round == 2 and Flg.Check("Battle5053") and enemy_id == 91601 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70009)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70009 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and Flg.Check("Battle5102") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29161)
    Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    Battle.SetIsRecoveryInvalidationAddCountdownDeath(false)
    if Flg.Check("Battle5108") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(-0.05, 4.41, 5.26, -0.23, 4.25, -4.73, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      WaitFrame(30)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "fe04", 0, false)
      WaitFrame(50)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      Battle.PlayEffectScript(EFF_02, 0)
      Battle.AttatchEffectScriptToModel(EFF_02, ENEMY_DIGIMON, 0)
      Battle.MessageTalk(1120001010)
      WaitMessage()
      Battle.SetCamera(8.98, 0.69, 6.02, 9.29, 0.69, 16.01, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 9, 0, 7.4)
      Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "f000", 0, true)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, -28.48, 0, 9.06)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
      Battle.MessageTalk(1120001011)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5108")
    end
  end
  if Flg.Check("Battle5112") and Flg.Check("Battle5122") == false and info.group == 2 and info.index == 0 then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(5.28, 0.81, 2.59, 12.96, 0.3, 8.97, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 7.74, 0, 4.65)
    Battle.SetModelRotationY(GUEST_DIGIMON, 0, -135)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, true)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 10, true)
    Battle.MessageTalk(1120001020)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5122")
  end
  if enemy_id == 91601 then
    if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false and Flg.Check("Battle5105") == false then
      Battle.SetCamera(3.08, 6.95, 0.74, -1.16, 4.6, -7.99, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "fe04", 0, false)
      WaitFrame(70)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      Battle.PlayEffectScript(EFF_02, 0)
      Battle.AttatchEffectScriptToModel(EFF_02, ENEMY_DIGIMON, 0)
      WaitFrame(30)
      Flg.Set("Battle5105")
    end
    if Flg.Check("Battle5105") and Flg.Check("Battle5101") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(-0.16, 0.63, 11.31, -0.16, 1.65, 1.36, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 0.66, 0, 9.07)
      Battle.SetModelPosition(PLAYER_CHARA, 0, -0.79, 0, 9.07)
      Battle.SetModelRotationY(GUEST_DIGIMON, 0, 210)
      Battle.SetModelRotationY(PLAYER_CHARA, 0, 150)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "f000", 0, true)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, -28.48, 0, 9.06)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
      Battle.MessageTalk(1120001007)
      WaitMessage()
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 0.66, 0, 9.07)
      Battle.SetModelPosition(PLAYER_CHARA, 0, -0.79, 0, 9.07)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, -28.48, 0, 9.06)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
      Battle.MessageTalk(1120001017)
      WaitMessage()
      BtlPlayAnimation(GUEST_DIGIMON, 0, "ba01", 10, false)
      WaitFrame(15)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 10, true)
      Battle.MessageTalk(1120001018)
      WaitMessage()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Talk.MessageTalkSel(2, 1120001001)
      WaitMessage()
      result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Battle.SetCamera(-0.16, 0.63, 11.31, -0.16, 1.65, 1.36, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.SetModelPosition(GUEST_DIGIMON, 0, 0.66, 0, 9.07)
        Battle.SetModelPosition(PLAYER_CHARA, 0, -0.79, 0, 9.07)
        Battle.SetModelPosition(PLAYER_DIGIMON, 0, -28.48, 0, 9.06)
        Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
        Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
        BtlPlayAnimation(PLAYER_CHARA, 0, "e203", 10, true)
        WaitFrame(30)
        BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
        Battle.PlayEffectScript(EFF_04, 0)
        slot = Sound.PlaySE(200006, 100)
        WaitFrame(20)
        Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
        Battle.SetVisibleCharacter(PLAYER_CHARA, 0, false)
        WaitFrame(20)
        Sound.StopSE(slot, 0)
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Flg.Set("Battle5101")
        Flg.Set("Battle5001")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29163)
      elseif result == RESULT_TALK01 then
        Battle.SetCamera(-0.16, 0.63, 11.31, -0.16, 1.65, 1.36, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.SetModelPosition(GUEST_DIGIMON, 0, 0.66, 0, 9.07)
        Battle.SetModelPosition(PLAYER_CHARA, 0, -0.79, 0, 9.07)
        Battle.SetModelPosition(PLAYER_DIGIMON, 0, -28.48, 0, 9.06)
        Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
        Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
        BtlPlayAnimation(PLAYER_CHARA, 0, "e008", 10, true)
        WaitFrame(60)
        BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
        Battle.MessageTalk(1120001004)
        WaitMessage()
        Battle.MessageTalk(1120001006)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Flg.Set("Battle5101")
        Flg.Set("Battle5002")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29164)
      end
    end
  end
end

function Battle_Action_Start(info)
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 29164 then
    Battle.SetStatus(PLAYER_DIGIMON, 3, STATUS_TYPE_HP, 0)
    Battle.SetStatus(PLAYER_DIGIMON, 4, STATUS_TYPE_HP, 0)
    Battle.SetStatus(PLAYER_DIGIMON, 5, STATUS_TYPE_HP, 0)
  end
  local enemy_id = info.enemy_id
  if enemy_id == 91601 and (Flg.Check("Battle5108") or Flg.Check("Battle5001") or Flg.Check("Battle5002")) then
    Battle.StopEffectScript(EFF_02, 0)
  end
  local AddTarget_HP_MAX_1 = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_1 = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  local AddTarget_HP_MAX_2 = Battle.GetStatus(ADD_TARGET, 1, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_2 = Battle.GetStatus(ADD_TARGET, 1, STATUS_TYPE_HP)
  local AddTarget_HP_MAX_3 = Battle.GetStatus(ADD_TARGET, 2, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_3 = Battle.GetStatus(ADD_TARGET, 2, STATUS_TYPE_HP)
  local AddTarget_HP_MAX_4 = Battle.GetStatus(ADD_TARGET, 3, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_4 = Battle.GetStatus(ADD_TARGET, 3, STATUS_TYPE_HP)
  local nowmax_hp_enemy = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local maxhprate = nowmax_hp_enemy / basemax_hp_enemy
  if Flg.Check("Battle5053") and Flg.Check("Battle5300") == false and Flg.Check("Battle5399") and Round == 0 then
    if Flg.Check("Battle5351") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX_1 * 0.75 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 1, STATUS_TYPE_HP, AddTarget_HP_MAX_2 * 0.75 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 2, STATUS_TYPE_HP, AddTarget_HP_MAX_3 * 0.75 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 3, STATUS_TYPE_HP, AddTarget_HP_MAX_4 * 0.75 * maxhprate)
      Flg.Clear("Battle5351")
      Flg.Clear("Battle5399")
    elseif Flg.Check("Battle5352") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX_1 * 0.5 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 1, STATUS_TYPE_HP, AddTarget_HP_MAX_2 * 0.5 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 2, STATUS_TYPE_HP, AddTarget_HP_MAX_3 * 0.5 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 3, STATUS_TYPE_HP, AddTarget_HP_MAX_4 * 0.5 * maxhprate)
      Flg.Clear("Battle5352")
      Flg.Clear("Battle5399")
    elseif Flg.Check("Battle5353") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX_1 * 0.25 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 1, STATUS_TYPE_HP, AddTarget_HP_MAX_2 * 0.25 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 2, STATUS_TYPE_HP, AddTarget_HP_MAX_3 * 0.25 * maxhprate)
      Battle.SetStatus(ADD_TARGET, 3, STATUS_TYPE_HP, AddTarget_HP_MAX_4 * 0.25 * maxhprate)
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
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local group = info.group
  local index = info.index
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70009 then
    AddTarget_nobreakHP()
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  local skill_id = Battle.GetCharacterLastCommandSkillID(GUEST_DIGIMON, 0)
  if skill_id == 43993 then
    Round_syn = 0
    Flg.Set("Battle5113")
  end
  if Flg.Check("Battle5112") == false and Flg.Check("Battle5053") == false then
    math.randomseed(os.time())
    local random = 0
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, GUEST_DIGIMON, 0, 1) then
      random = math.random(1, 3)
    elseif Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, GUEST_DIGIMON, 0, 2) then
      random = math.random(1, 2)
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, GUEST_DIGIMON, 0, 3) then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43993)
      Flg.Set("Battle5112")
    elseif random == 1 and info.round >= 6 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43993)
      Flg.Set("Battle5112")
    end
  end
  local nowmax_hp_enemy = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local maxhprate = nowmax_hp_enemy / basemax_hp_enemy
  local maxhp = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local hp = maxhp * maxhprate
  if Flg.Check("Battle5120") == false then
    for idx = 0, 2 do
      if 0 < Battle.GetDigimonId(PLAYER_DIGIMON, idx) and Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_HEAL_COUNT_OVER, 0, PLAYER_DIGIMON, idx, 2) then
        print("##### HP RECOVERY TWICE index = ", idx, " #####")
        Flg.Set("Battle5120")
        break
      end
    end
  end
  if enemy_now_hp == 1 and Flg.Check("Battle5102") == false then
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
    Flg.Set("Battle5102")
    if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
      Battle.StopEffectScript(EFF_02, 0)
    end
    Battle.ClearCPCharge()
  end
  if round_count == 4 and Flg.Check("Battle5001") == false then
    Flg.Set("Battle5011")
  end
  if Round == 4 then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
    Flg.Set("Battle5014")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 3000) then
    Flg.Set("Battle5015")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, 4000) then
    Flg.Set("Battle5016")
  end
  if Flg.Check("Battle5106") and Flg.Check("Battle5107") == false and Flg.Check("Battle5001") == false and Flg.Check("Battle5002") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.57, 4.93, 5.73, -0.14, 4.54, -4.24, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1120001009)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5107")
  end
  if Flg.Check("Battle5115") == false and Battle.IsBuff(1, 0, 105000, BUFF_CHECK_OR_WITHOUT_ID) then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(7.98, 0.48, 5.75, 2.25, 2.7, -2.13, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 7.74, 0, 4.65)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.MessageTalk(1120001023)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5115")
  end
  if Flg.Check("Battle5116") and Flg.Check("Battle5117") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(7.98, 0.48, 5.75, 2.25, 2.7, -2.13, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 7.74, 0, 4.65)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.MessageTalk(1120001024)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5117")
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30301, 30303)
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 591602)
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30131, 30133)
    Flg.Set("Battle5203")
  end
  if 4 <= stock_num and Flg.Check("Battle5204") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 591604)
    Flg.Set("Battle5204")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 29161 then
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
    Flg.Clear("Battle5124")
    Flg.Clear("Battle5108")
    Flg.Clear("Battle5300")
    Battle.SetIsRecoveryInvalidationAddCountdownDeath(true)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    flgcount = 0
    Round = 0
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
    Flg.Clear("Battle5209")
    Flg.Clear("Battle5124")
    Flg.Clear("Battle5108")
    Flg.Clear("Battle5300")
    Battle.SetIsRecoveryInvalidationAddCountdownDeath(true)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 591602)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 591604)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30131, -1)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30301, -1)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    flgcount = 0
    Round = 0
    Battle.ClearCPCharge()
    if Flg.Check("Battle5118") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(6.79, 0.83, 2.83, 11.35, -0.1, 11.68, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 7.74, 0, 4.65)
      Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
      Battle.MessageTalk(1120001025)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5118")
    end
  end
  if Flg.Check("Battle5001") and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 29163 then
    Battle.SetCameraMove(0, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_DAMAGE_ENEMY_ALL, PLAYER_DIGIMON, -1)
    Battle.SetVisibleCharacter(0, 0, false)
    Battle.SetVisibleCharacter(0, 1, false)
    Battle.SetVisibleCharacter(0, 2, false)
    Battle.SetVisibleCharacter(1, 0, false)
    Battle.SetVisibleCharacter(2, 0, false)
    Battle.SetVisibleCharacter(2, 1, false)
    Battle.SetVisibleCharacter(3, 0, false)
    WaitFrame(5)
    Battle.SetEffectScriptPosition(EFF_01, -2, 0, 6)
    Battle.PlayEffectScript(EFF_01, 0)
    WaitFrame(60)
    Battle.SetCamera(0.11, 1.14, 14.22, -0.03, 1.59, 4.23, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, true)
    Battle.SetEffectScriptPosition(EFF_05, 0, 1, 9.07)
    Battle.PlayEffectScript(EFF_05, 0)
    slot = Sound.PlaySE(200006, 100)
    WaitFrame(20)
    Sound.StopSE(slot, 0)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, true)
    Battle.SetVisibleCharacter(PLAYER_CHARA, 0, true)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 0.66, 0, 9.07)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -0.79, 0, 9.07)
    WaitFrame(60)
    Flg.Set("Battle5104")
    if Flg.Check("Battle5104") then
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, -28.48, 0, 9.06)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
      WaitFrame(30)
      Flg.Set("FLAG_MAIN_14_020")
      Battle.ForceWin()
    end
  end
  if Flg.Check("Battle5002") and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 29164 then
    Battle.ForceLose()
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

function IsGivenCountdownDeath()
  local isCountdownDeath = false
  for idx = 0, 3 do
    if Battle.IsBuff(PLAYER_DIGIMON, idx, 591611, BUFF_CHECK_OR_WITHOUT_ID) then
      isCountdownDeath = true
    end
  end
  for idx = 0, 3 do
    if Battle.IsBuff(GUEST_DIGIMON, idx, 591611, BUFF_CHECK_OR_WITHOUT_ID) then
      isCountdownDeath = true
    end
  end
  for idx = 0, 3 do
    if Battle.IsBuff(ENEMY_DIGIMON, idx, 591611, BUFF_CHECK_OR_WITHOUT_ID) then
      isCountdownDeath = true
    end
  end
  return isCountdownDeath
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_14_020")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(912, DIGIMON_GRASP_FLAG_SCAN)
  Battle.EndTalk()
end

function AddTarget_nobreakHP()
  local AddTarget_HP_MAX_1 = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_1 = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  local AddTarget_HP_MAX_2 = Battle.GetStatus(ADD_TARGET, 1, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_2 = Battle.GetStatus(ADD_TARGET, 1, STATUS_TYPE_HP)
  local AddTarget_HP_MAX_3 = Battle.GetStatus(ADD_TARGET, 2, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_3 = Battle.GetStatus(ADD_TARGET, 2, STATUS_TYPE_HP)
  local AddTarget_HP_MAX_4 = Battle.GetStatus(ADD_TARGET, 3, STATUS_TYPE_HP_MAX)
  local AddTarget_HP_4 = Battle.GetStatus(ADD_TARGET, 3, STATUS_TYPE_HP)
  local AddTarget_HP_MAX_Average = AddTarget_HP_MAX_1 + AddTarget_HP_MAX_2 + AddTarget_HP_MAX_3 + AddTarget_HP_MAX_4
  local AddTarget_HP_Average = AddTarget_HP_1 + AddTarget_HP_2 + AddTarget_HP_3 + AddTarget_HP_4
  local AddTarget_HP_ratio = AddTarget_HP_Average / AddTarget_HP_MAX_Average
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
