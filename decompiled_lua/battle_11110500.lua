require("include_battle")
Round = 0
EFF_01 = 1
EFF_02 = 2
EFF_03 = 3

function Battle_Before_Setup()
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 21741)
  Battle.LoadEffectScript(EFF_02, "ef_b_sta_250")
  Battle.LoadEffectScript(EFF_03, "ef_b_buf_100")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  SetEndrollMember(11110500)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m320_040")
    Fade.In(1, Util.SecondFromFrame(30))
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(15))
  end
  Sound.PlayBGM(806, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
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
  if enemy_id == 49201 and Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if Flg.Check("Battle5053") then
    math.randomseed(os.time())
    local random = math.random(1, 3)
    local round_count = info.round
    if info.group == 2 and info.index == 0 then
      if Flg.Check("Battle5103") == false then
        Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
      else
        Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
        if round_count % 2 == 0 then
          if random == 1 then
            Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10011)
          elseif random == 2 then
            Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 21741)
          elseif random == 3 then
            Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 21742)
          end
        elseif random == 1 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 21741)
        elseif random == 2 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 21741)
        elseif random == 3 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 21742)
        end
      end
    end
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and info.group == 2 and info.index == 0 and Flg.Check("Battle5103") == false then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 24923)
    Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    if Flg.Check("Battle5104") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(1.03, 2.43, 0.98, -0.35, 1.7, -8.89, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(31)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 0, false)
      Battle.PlayEffectScript(EFF_02, 0)
      Battle.SetEffectScriptPosition(EFF_02, 0, 0, -5.96)
      Battle.MessageTalk(1111050002)
      WaitFrame(70)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      if Battle.GetDigimonId(GUEST_AEGIOMON, 0) == 183 then
        Battle.MessageTalk(1111050008)
      else
        Battle.MessageTalk(1111050003)
      end
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
  if enemy_id == 49201 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(200)
    else
      Battle.AddEnemyCP(400)
    end
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5053") == false and enemy_id == 49201 and Battle.IsTurnCharacterExtraTurn() == false then
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, false)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.SetupCPCharge(70003, 94001, ENEMY_DIGIMON, 0, "FP01", 2)
    Flg.Set("Battle5053")
    Round = 0
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, true)
    if Flg.Check("Battle5102") == false then
      Flg.Set("Battle5102")
    end
  end
  if Round == 2 and Flg.Check("Battle5053") and enemy_id == 49201 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
end

function Battle_Action_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 49201 and Flg.Check("Battle5104") then
    Battle.StopEffectScript(EFF_02, 0.1)
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
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  if round_count == 6 and Flg.Check("Battle5101") == false then
    Flg.Set("Battle5011")
  end
  if Round == 6 then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, ENEMY_DIGIMON, 0, 3) then
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
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_MAGIC, 3, ENEMY_DIGIMON, 0, 3) then
    Flg.Set("Battle5017")
  end
  print("stock_num:", stock_num)
  if stock_num == 1 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32201)
  elseif stock_num == 1 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 10011)
  elseif stock_num == 2 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30223)
  elseif stock_num == 2 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 10011)
  elseif stock_num == 3 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33031)
  elseif stock_num == 3 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 10011)
  elseif stock_num == 4 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30245)
  elseif stock_num == 4 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30185)
  elseif 5 <= stock_num and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30306)
  elseif 5 <= stock_num and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30283)
  end
  if stock_num == 0 or Flg.Check("Battle5053") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(1.03, 2.43, 0.98, -0.35, 1.7, -8.89, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
    if Battle.GetDigimonId(GUEST_AEGIOMON, 0) == 183 then
      Battle.MessageTalk(1111050007)
    else
      Battle.MessageTalk(1111050001)
    end
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if enemy_now_hp / enemy_max_hp <= 0.8 and Flg.Check("Battle5201") == false and Flg.Check("Battle5053") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 549201)
    Flg.Set("Battle5201")
    if Flg.Check("Battle5105") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(1.03, 2.43, 0.98, -0.35, 1.7, -8.89, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(31)
      Battle.MessageTalk(1111050004)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 0, false)
      Battle.AttatchEffectScriptToModel(EFF_03, ENEMY_DIGIMON, 0)
      Battle.PlayEffectScript(EFF_03, 0)
      slot = Sound.PlaySE(300301, 100, false)
      WaitFrame(70)
      Sound.StopSE(slot, 0)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      if Battle.GetDigimonId(GUEST_AEGIOMON, 0) == 183 then
        Battle.MessageTalk(1111050009)
      else
        Battle.MessageTalk(1111050005)
      end
      WaitMessage()
      Battle.MessageTalk(1111050006)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5105")
    end
  elseif enemy_now_hp / enemy_max_hp <= 0.6 and Flg.Check("Battle5202") == false then
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 549201)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 549202)
    Flg.Set("Battle5202")
  elseif enemy_now_hp / enemy_max_hp <= 0.4 and Flg.Check("Battle5203") == false then
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 549202)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 549203)
    Flg.Set("Battle5203")
  elseif enemy_now_hp / enemy_max_hp <= 0.2 and Flg.Check("Battle5204") == false then
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 549203)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 549204)
    Flg.Set("Battle5204")
  end
  if enemy_now_hp / enemy_max_hp <= 0.5 and Flg.Check("Battle5103") == false and Flg.Check("Battle5053") == false then
    Battle.DeleteMember(GUEST_DIGIMON, 0)
    Battle.ExchangeMember(GUEST_DIGIMON, 0)
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m320_050")
    Fade.In(1, Util.SecondFromFrame(30))
    Flg.Set("Battle5103")
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
  else
    if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 24923 then
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
      Flg.Clear("Battle5104")
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
      Flg.Clear("Battle5053")
      Flg.Clear("Battle5054")
      Flg.Clear("Battle5104")
      Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
      flgcount = 0
      Round = 0
      Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
      Battle.ClearCPCharge()
    end
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
  Flg.Set("FLAG_MAIN_12_040")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  if Flg.Check("FLAG_MAIN_12_040", "FLAG_MAIN_12_050") then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Sound.StopBGM(0)
    Execute("m320_060")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
  end
end
