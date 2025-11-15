require("include_battle")
Round = 0
EFF_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bf01")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  SetEndrollMember(11020100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m300_050")
    Fade.In(1, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(930, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
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
  if Flg.Check("Battle5111") then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
    Flg.Clear("Battle5111")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Round = 0
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
  end
  if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
    Round = Round + 1
  end
  if Flg.Check("Battle5053") then
    ChargeRound = ChargeRound + 1
    print("ChargeRound:", ChargeRound)
  end
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  if Flgcount() >= 3 and Flg.Check("Battle5111") == false then
    Flg.Set("Battle5051")
  end
  if enemy_id == 60101 and Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
    Battle.SetNextCommandTarget(GUEST_DIGIMON, 1, ADD_TARGET, 0)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and info.group == 2 then
    if info.index == 0 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
    elseif info.index == 1 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 10012)
    end
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 26012)
    Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    if Flg.Check("Battle5104") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0.12, 1.68, -3.54, -0.65, 0.55, -13.45, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(30)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bf01", 0, false)
      WaitFrame(50)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      Battle.MessageTalk(1102010002)
      WaitMessage()
      if Battle.GetDigimonId(GUEST_AEGIOMON, 0) == 183 then
        Battle.MessageTalk(1102010006)
      else
        Battle.MessageTalk(1102010003)
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
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  if enemy_id == 60101 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(400)
    else
      Battle.AddEnemyCP(600)
    end
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5053") == false and enemy_id == 60101 and Battle.IsTurnCharacterExtraTurn() == false then
    if Battle.IsBuff(PLAYER_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) and Battle.IsBuff(PLAYER_DIGIMON, 1, 107000, BUFF_CHECK_OR_WITHOUT_ID) and Battle.IsBuff(PLAYER_DIGIMON, 2, 107000, BUFF_CHECK_OR_WITHOUT_ID) and Battle.IsBuff(GUEST_AEGIOMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) then
      Fade.BackOut(1, Util.SecondFromFrame(10))
      Battle.CloseUI()
      Battle.MessageTalk(1102010004)
      WaitMessage()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 26012)
      Fade.BackIn(1, Util.SecondFromFrame(10))
    else
      Battle.SetupCPCharge(70003, 94101, ENEMY_DIGIMON, 0, "FP01", 2)
      Flg.Set("Battle5053")
      Round = 0
      ChargeRound = 0
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208003)
      if Flg.Check("Battle5102") == false then
        Flg.Set("Battle5102")
      end
    end
  end
  print("Round:", Round)
  print("ChargeRound:", ChargeRound)
  if not (ChargeRound == 2 and Flg.Check("Battle5053")) or Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
  elseif enemy_id == 60101 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
  if Battle.IsTurnCharacterExtraTurn() == true then
    if enemy_id == 60101 and Flg.Check("Battle5020") == true then
      local target_list = {}
      for i = 0, 2 do
        if Battle.IsBuff(PLAYER_DIGIMON, i, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
          table.insert(target_list, i)
        end
      end
      if Battle.IsBuff(GUEST_AEGIOMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
        table.insert(target_list, 3)
      end
      if 0 < #target_list then
        local index = target_list[math.random(1, #target_list)]
        if index == 3 then
          Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_AEGIOMON, 0)
        else
          Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, index)
        end
      end
      Flg.Clear("Battle5020")
    end
  else
    local is_use_sleep = false
    if enemy_id == 60101 and Flg.Check("Battle5053") == false and Flg.Check("Battle5110") == false then
      if stock_num == 0 and round_count % 2 == 1 then
        is_use_sleep = IsUseSleep()
      elseif stock_num == 1 and round_count % 2 == 1 then
        is_use_sleep = IsUseSleep()
      elseif stock_num == 2 and round_count % 3 == 1 then
        is_use_sleep = IsUseSleep()
      elseif 3 <= stock_num and round_count % 3 == 1 then
        is_use_sleep = IsUseSleep()
      end
    end
    if is_use_sleep == true then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 33041)
    end
  end
end

function Battle_Action_Start(info)
  local AddTarget_HP_MAX = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5053") and Flg.Check("Battle5300") == false and Flg.Check("Battle5399") and ChargeRound == 0 then
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
  if info.group == GUEST_DIGIMON and info.digimon_id == 179 then
    local skill_id = Battle.GetLastCommandSkillID()
    if (skill_id == 21791 or skill_id == 21792) and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
  elseif info.group == ENEMY_DIGIMON and info.enemy_id == 60101 and Battle.GetLastCommandSkillID() == 26012 and info.use_count == 0 then
    Battle.SetBattleSpeedToNormalForTurn()
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
    Flg.Set("Battle5054")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70007 then
    Flg.Clear("Battle5110")
    Flg.Set("Battle5111")
  end
  local stock_num = Battle.GetCPStockNum()
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
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local weak_damage_num = enemy_max_hp * 0.12
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, weak_damage_num) then
    Flg.Set("Battle5015")
  end
  local total_damage_num = enemy_max_hp * 0.14
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, total_damage_num) then
    Flg.Set("Battle5016")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_PHYSICAL, 2, ENEMY_DIGIMON, 0, 3) then
    Flg.Set("Battle5017")
  end
  print("stock_num:", stock_num)
  if stock_num == 1 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
    Flg.Clear("Battle5020")
  elseif stock_num == 1 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 26013)
    Flg.Set("Battle5020")
  elseif stock_num == 2 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 26013)
    Flg.Set("Battle5020")
  elseif stock_num == 2 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30063)
    Flg.Clear("Battle5020")
  elseif stock_num == 3 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30213)
    Flg.Clear("Battle5020")
  elseif stock_num == 3 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 26013)
    Flg.Set("Battle5020")
  elseif stock_num == 4 and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 26013)
    Flg.Set("Battle5020")
  elseif stock_num == 4 and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 34031)
    Flg.Clear("Battle5020")
  elseif 5 <= stock_num and Flg.Check("Battle5052") == false and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 34031)
    Flg.Clear("Battle5020")
  elseif 5 <= stock_num and Flg.Check("Battle5052") == false and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 26013)
    Flg.Set("Battle5020")
  end
  if stock_num == 0 or Flg.Check("Battle5053") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Flg.Clear("Battle5020")
  end
  if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
    if Battle.GetDigimonId(GUEST_AEGIOMON, 0) == 183 then
      Battle.MessageTalk(1102010005)
    else
      Battle.MessageTalk(1102010001)
    end
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 26012 then
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
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    flgcount = 0
    Round = 0
    ChargeRound = 0
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
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Flg.Clear("Battle5020")
    flgcount = 0
    Round = 0
    ChargeRound = 0
    Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.ClearCPCharge()
    Flg.Set("Battle5110")
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
  Flg.Set("FLAG_MAIN_10_047")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m300_060")
end

function IsUseSleep()
  local is_use_sleep = false
  local target_list = {}
  for i = 0, 2 do
    if Battle.IsBuff(PLAYER_DIGIMON, i, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
      table.insert(target_list, i)
      is_use_sleep = true
    end
  end
  if Battle.IsBuff(GUEST_AEGIOMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
    table.insert(target_list, 3)
    is_use_sleep = true
  end
  if 0 < #target_list then
    local index = target_list[math.random(1, #target_list)]
    if index == 3 then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, GUEST_AEGIOMON, 0)
    else
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, index)
    end
  end
  return is_use_sleep
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
