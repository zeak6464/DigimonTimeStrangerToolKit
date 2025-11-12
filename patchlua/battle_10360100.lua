require("include_battle")
CP_Round = 0
Round = 0
EFF_01 = 1
EFF_02 = 2
EFF_03 = 3
EFF_04 = 4
EFF_05 = 5
EFF_06 = 6
EFF_10 = 10
OBJ_01 = 1
OBJ_02 = 2
local is_high_difficulty = false

function Battle_Before_Setup()
  print("=========== Battle_Before_Setup ===========")
  Battle.SetBattleBGM(-1)
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 20801)
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadObject(OBJ_01, "d0276floor00")
  Battle.LoadObject(OBJ_02, "d0276floor01")
  Battle.LoadEffectScript(EFF_01, "ef_b_bos_116")
  Battle.LoadEffectScript(EFF_02, "ef_b_bos_115")
  Battle.LoadEffectScript(EFF_03, "ef_b_bos_116")
  Battle.LoadEffectScript(EFF_04, "ef_b_bos_116")
  Battle.LoadEffectScript(EFF_05, "ef_b_bos_115")
  Battle.LoadEffectScript(EFF_06, "ef_b_bos_115")
  Battle.LoadEffectScript(EFF_10, "ef_b_bos_117")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  print("=========== Battle_After_Setup ===========")
  Battle.LoadAnimation(GUEST_AEGIOMON, 0, "ba02")
  Battle.LoadAnimation(GUEST_DIGIMON, 2, "e002")
  Battle.LoadAnimation(GUEST_DIGIMON, 2, "e004")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "e501")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  SetEndrollMember(10360100)
end

function Battle_After_Build()
  print("=========== Battle_After_Build ===========")
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.SetObjectVisible(OBJ_02, false)
  Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
  if Flg.Check("Battle5499") == true then
    Battle.SetObjectVisible(OBJ_01, false)
    Battle.SetObjectPosition(OBJ_02, 0, 0, -7)
    Battle.SetObjectVisible(OBJ_02, true)
  end
end

function Battle_Opening(info)
  print("=========== Battle_Opening ===========")
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m140_050")
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(806, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  print("=========== Battle_Start ===========")
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.SetEffectScriptLoopInterval(EFF_01, 29)
  Battle.PlayEffectScript(EFF_01, 0)
  Battle.SetEffectScriptPosition(EFF_01, -103.3, 72.7, -133.9)
  Battle.SetEffectScriptLoopInterval(EFF_02, 14)
  Battle.PlayEffectScript(EFF_02, 0)
  Battle.SetEffectScriptPosition(EFF_02, 35.9, 0, -27.8)
  Battle.SetEffectScriptLoopInterval(EFF_03, 20.5)
  Battle.PlayEffectScript(EFF_03, 0)
  Battle.SetEffectScriptPosition(EFF_03, -36.1, 22.6, -59.2)
  Battle.SetEffectScriptLoopInterval(EFF_04, 37)
  Battle.PlayEffectScript(EFF_04, 0)
  Battle.SetEffectScriptPosition(EFF_04, 122.8, 72.5, -102.6)
  Battle.SetEffectScriptLoopInterval(EFF_05, 18.5)
  Battle.PlayEffectScript(EFF_05, 0)
  Battle.SetEffectScriptPosition(EFF_05, -32.5, 0, -4.1)
  Battle.SetEffectScriptLoopInterval(EFF_06, 10)
  Battle.PlayEffectScript(EFF_06, 0)
  Battle.SetEffectScriptPosition(EFF_06, 33.7, 0, -80.2)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    is_high_difficulty = true
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30302, 30303)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 29271, 29273)
  end
end

function Battle_Round_Start(info)
  print("=========== Battle_Round_Start round = ", info.round, " ===========")
  local round_count = info.round
  local stock_num = Battle.GetCPStockNum()
  if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
    CP_Round = CP_Round + 1
    print("##### CP_Round: ", CP_Round, " ROUND #####")
  end
  if Flg.Check("Battle5053") then
    Round = Round + 1
    print("##### Round: ", Round, " ROUND #####")
  end
  if Flg.Check("Battle5120") then
    Flg.Clear("Battle5120")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70007 then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    CP_Round = 0
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
  end
end

function Battle_Turn_Start(info)
  print("=========== Battle_Turn_Start digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " group = ", info.group, " ===========")
  local digimon_id = info.digimon_id
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if Battle.IsTurnCharacterExtraTurn() then
    print("####### Extra_Turn_Start #######")
  end
  if Flg.Check("FLAG_MAIN_03_690") and Flg.Check("Battle5104") == false then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 20805)
    Battle.AddBuff(GUEST_DIGIMON, 1, 114100)
    if is_high_difficulty then
      Battle.SetStatus(GUEST_DIGIMON, 1, STATUS_TYPE_LV, 99)
    end
    Flg.Set("Battle5104")
  end
  if Flg.Check("Battle5053") then
    print("##### Charging Turn #####")
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
    if info.group == 2 then
      print("##### info group turn index = ", info.index, "#####")
      if info.index == 0 then
        Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
      elseif info.index == 1 then
        print("##### Merukurimon turn addtarget #####")
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 20805)
        Battle.SetNextCommandTarget(GUEST_DIGIMON, 1, ADD_TARGET, 0)
      end
    end
  end
  if enemy_last_skill_id == 70005 and info.group == 2 then
    print("##### info group turn index = ", info.index, "#####")
    if info.index == 0 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
    elseif info.index == 1 then
      print("##### Merukurimon turn guardact #####")
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 10012)
    end
  end
  local status = Battle.IsBuff(ENEMY_DIGIMON, 0, 205200, BUFF_CHECK_AND_WITH_ID)
  if status then
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  end
  if Flg.Check("Battle5117") and status == false and Flg.Check("Battle5301") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.34, 9.47, -0.27, -0.15, 13, -9.62, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
    WaitFrame(30)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "e501", 0, false)
    Battle.MessageTalk(1036010010)
    WaitFrame(60)
    Battle.AddMotionScheduleIdleByStatus(ENEMY_DIGIMON, 0, true)
    WaitMessage()
    slot = Sound.PlaySE(500006, 100, false)
    WaitFrame(35)
    Sound.StopSE(slot, 0)
    Battle.MessageTalk(1036010023)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5301")
  end
end

function Battle_Command_Start(info)
  print("=========== Battle_Command_Start digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " group = ", info.group, " ===========")
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local round_count = info.round
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  print("##### enemy_last_skill_id = ", enemy_last_skill_id, " #####")
  if round_count == 4 and Flg.Check("Battle5103") == false then
    Flg.Set("Battle5011")
  end
  if 4 <= CP_Round then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
    Flg.Set("Battle5014")
  end
  local weak_damage_num = enemy_max_hp * 0.1
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, weak_damage_num) then
    Flg.Set("Battle5015")
  end
  local total_damage_num = enemy_max_hp * 0.12
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, total_damage_num) then
    Flg.Set("Battle5016")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_HIT_COUNT_OVER, 6, ENEMY_DIGIMON, 0, 15) then
    Flg.Set("Battle5017")
  end
  if enemy_id == 92601 then
    if Battle.IsBreakCPCharge() == false then
      if Flg.Check("FLAG_MAIN_03_690") == false and Flg.Check("Battle5053") == false then
        Battle.AddEnemyCP(300)
      else
        Battle.AddEnemyCP(500)
      end
    end
    if 3 <= Flgcount() and 3 <= round_count and Battle.IsBuff(ENEMY_DIGIMON, 0, 205200, BUFF_CHECK_AND_WITH_ID) == false then
      Flg.Set("Battle5051")
    end
    if Flg.Check("Battle5051") and Flg.Check("Battle5052") == false then
      if is_high_difficulty then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29276)
      else
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29268)
      end
      Flg.Set("Battle5052")
    end
    if (enemy_last_skill_id == 29268 or enemy_last_skill_id == 29276) and Flg.Check("Battle5053") == false then
      Battle.SetupCPCharge(70003, 92701, ENEMY_DIGIMON, 0, "FP01", 2)
      Round = 0
      print("##### Round = 0 ")
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
      Flg.Set("Battle5053")
    end
    if Flg.Check("Battle5053") then
      if 2 <= Round and Flg.Check("Battle5055") == false then
        AddTarget_nobreakHP()
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
        Battle.CompleteCPCharge(70005)
        Flg.Set("Battle5055")
      end
      if enemy_last_skill_id == 70001 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
      end
      if enemy_last_skill_id == 70005 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29261)
        Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
      end
    end
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
  if info.group == GUEST_DIGIMON and info.digimon_id == 971 then
    if Battle.GetLastCommandSkillID() == 20805 and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
  elseif info.group == ENEMY_DIGIMON and info.enemy_id == 92601 then
    local skill_id = Battle.GetLastCommandSkillID()
    if skill_id == 29261 and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
  print("=========== Battle_Command_End ===========")
end

function Battle_Turn_End(info)
  print("=========== Battle_Turn_End ===========")
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  local skill_id = Battle.GetLastActionSkillID()
  print("##### enemy_last_skill_id = ", enemy_last_skill_id, " #####")
  print("##### skill_id = ", skill_id, " #####")
  if enemy_id == 92601 then
    if enemy_last_skill_id == 70001 then
      BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    end
    if enemy_last_skill_id == 70005 and Flg.Check("Battle5115") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(-0.34, 9.47, -0.27, -0.15, 13, -9.62, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
      WaitFrame(30)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "e501", 0, false)
      Battle.MessageTalk(1036010010)
      Battle.PlayEffectScript(EFF_10, 0)
      Battle.AttatchEffectScriptToModel(EFF_10, ENEMY_DIGIMON, 0)
      WaitFrame(60)
      Battle.AddMotionScheduleIdleByStatus(ENEMY_DIGIMON, 0, true)
      WaitMessage()
      Battle.MessageTalk(1036010011)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5115")
    end
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false and enemy_last_skill_id == 70003 then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  if Flg.Check("Battle5053") then
    ThunderboltStop()
  end
  if enemy_id == 92601 and Flg.Check("Battle5118") and enemy_last_skill_id ~= 70007 then
    ThunderboltPlay()
    Flg.Clear("Battle5118")
  end
  if Flg.Check("Battle5119") and Flg.Check("Battle5116") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(8.57, 1.48, 17.36, 6.05, 5.24, 8.44, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
    slot = Sound.PlaySE(500006, 100, false)
    WaitFrame(35)
    Sound.StopSE(slot, 0)
    Battle.MessageTalk(1036010020)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5116")
  end
  if enemy_id == 92601 and Flg.Check("Battle5053") == false and Flg.Check("Battle5118") == false and Flg.Check("Battle5120") == false then
    local target_list = {}
    for idx = 0, 2 do
      if IsCheckTarget(PLAYER_DIGIMON, idx, REGION_FLAG_TYPE_MECHANICAL) == true or IsCheckTarget(PLAYER_DIGIMON, idx, REGION_FLAG_TYPE_STEEL) == true then
        local player_data = {
          group = PLAYER_DIGIMON,
          index = idx
        }
        target_list[#target_list + 1] = player_data
      end
    end
    print("FieldEfectTarget:", target_list)
    local max_cnt = 0
    if Flg.Check("Battle5301") == false then
      if 0.75 < enemy_now_hp / enemy_max_hp then
        max_cnt = 1
      else
        max_cnt = 2
      end
    else
      max_cnt = 3
    end
    for cnt = 1, max_cnt do
      if 0 < #target_list then
        local target_idx = math.random(1, #target_list)
        if is_high_difficulty then
          Battle.SetFieldEffectSkill(29275, target_list[target_idx].group, target_list[target_idx].index)
        else
          Battle.SetFieldEffectSkill(29264, target_list[target_idx].group, target_list[target_idx].index)
        end
      elseif math.random(1, 2) == 1 then
        for idx = 0, 2 do
          if IsCheckTarget_Alive(PLAYER_DIGIMON, idx) == true then
            local player_data = {
              group = PLAYER_DIGIMON,
              index = idx
            }
            target_list[#target_list + 1] = player_data
          end
          if IsCheckTarget_Alive(GUEST_DIGIMON, idx) == true then
            local player_data = {
              group = GUEST_DIGIMON,
              index = idx
            }
            target_list[#target_list + 1] = player_data
          end
        end
        local target_idx = math.random(1, #target_list)
        if is_high_difficulty then
          Battle.SetFieldEffectSkill(29275, target_list[target_idx].group, target_list[target_idx].index)
        else
          Battle.SetFieldEffectSkill(29264, target_list[target_idx].group, target_list[target_idx].index)
        end
      else
        if is_high_difficulty then
          Battle.SetFieldEffectSkill(29274, ENEMY_DIGIMON, 0)
        else
          Battle.SetFieldEffectSkill(29263, ENEMY_DIGIMON, 0)
        end
        Battle.AddEnemyCP(200)
        if Flg.Check("Battle5119") == false then
          Flg.Set("Battle5119")
        end
      end
    end
    Flg.Set("Battle5120")
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5103") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(0.48, 1.61, 9.04, 0.47, 4.34, -0.57, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1036010001)
    WaitMessage()
    Battle.SetCamera(1.36, 11.14, 21.57, 1.4, 19.19, 15.65, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
    WaitFrame(60)
    Battle.MessageTalk(1036010019)
    WaitMessage()
    Battle.MessageTalk(1036010002)
    WaitMessage()
    Battle.SetCamera(0.05, 11.59, 7, 0.1, 11.64, 0, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1036010003)
    WaitMessage()
    Battle.MessageTalk(1036010004)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5103")
  end
  if Flg.Check("FLAG_MAIN_03_690") == false and enemy_now_hp / enemy_max_hp <= 0.65 and (enemy_last_skill_id == 29268 or enemy_last_skill_id == 29276 or enemy_now_hp == 1 or enemy_now_hp / enemy_max_hp <= 0.3 and Flg.Check("Battle5053") == false) then
    Battle.ExchangeMember(GUEST_DIGIMON, 1)
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m140_060")
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    BtlSetInterruptCharacter(GUEST_DIGIMON, 1, BATTLE_INTERRUPT_TYPE_NORMAL, true)
    Fade.AllIn(0, Util.SecondFromFrame(15))
    Flg.Set("FLAG_MAIN_03_690")
  end
  if 1 <= stock_num and Flg.Check("Battle5102") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(0.01, 4.11, 6.97, -0.05, 8.2, -2.15, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1036010005)
    WaitMessage()
    Battle.MessageTalk(1036010006)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5102")
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 592601)
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 592602)
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30301, 30302)
    end
    Flg.Set("Battle5203")
  end
  if 4 <= stock_num and Flg.Check("Battle5204") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 592604)
    Flg.Set("Battle5204")
  end
  if 5 <= stock_num and Flg.Check("Battle5205") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 592605)
    Flg.Set("Battle5205")
  end
  print("stock_num:", stock_num)
  if Flg.Check("Battle5052") == false then
    if stock_num == 1 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      if is_high_difficulty then
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29273)
      else
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29272)
      end
    elseif stock_num == 2 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      if is_high_difficulty then
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30213)
      else
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30212)
      end
    elseif stock_num == 3 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      if is_high_difficulty then
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30153)
      else
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30152)
      end
    elseif stock_num == 4 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32031)
    elseif 5 <= stock_num then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30303)
    end
  elseif Flg.Check("Battle5052") or stock_num == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if enemy_last_skill_id == 29261 then
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
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5110")
    Flg.Clear("Battle5111")
    Flg.Clear("Battle5112")
    Flg.Clear("Battle5115")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Round = 0
    CP_Round = 0
    ThunderboltPlay()
    Battle.StopEffectScript(EFF_10, 0)
  end
  if Battle.IsBreakCPCharge() then
    if Flg.Check("Battle5117") == false and 1 < enemy_now_hp then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0, 7.11, 8.86, 0, 11.74, 0, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      slot = Sound.PlaySE(500006, 100, false)
      WaitFrame(35)
      Sound.StopSE(slot, 0)
      Battle.MessageTalk(1036010021)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5117")
    end
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
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5110")
    Flg.Clear("Battle5111")
    Flg.Clear("Battle5112")
    Flg.Clear("Battle5115")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5204")
    Flg.Clear("Battle5205")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 592602)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 592604)
    Battle.RemoveBuff(ENEMY_DIGIMON, 1, 592605)
    Battle.RemoveBuff(ENEMY_DIGIMON, 2, 592605)
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30301, -1)
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 29271, -1)
    end
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Round = 0
    CP_Round = 0
    Battle.ClearCPCharge()
    Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    ThunderboltStop()
    Battle.StopEffectScript(EFF_10, 0)
    Flg.Set("Battle5118")
  end
end

function Battle_Win(info)
  ThunderboltStop()
  Battle.DeleteMember(GUEST_DIGIMON, 2)
  Flg.Set("FLAG_MAIN_03_680")
end

function Battle_Lose(info)
  Flg.Clear("FLAG_MAIN_03_690")
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(414, DIGIMON_GRASP_FLAG_SCAN)
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.SetObjectVisible(OBJ_02, false)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m140_065")
end

function IsCheckTarget(area, index, region_flag_type)
  if IsCheckTarget_Standard(area, index) == true and Battle.IsBelong(area, index, region_flag_type) == true then
    return true
  end
  return false
end

function IsCheckTarget_Standard(area, index)
  if Battle.GetDigimonId(area, index) > 0 and 0 < Battle.GetStatus(area, index, STATUS_TYPE_HP) then
    return true
  end
  return false
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
  print("##### Flgcount = ", flgcount, " #####")
  return flgcount
end

function ThunderboltStop()
  Battle.SetEffectScriptLoop(EFF_01, false)
  Battle.SetEffectScriptLoop(EFF_02, false)
  Battle.SetEffectScriptLoop(EFF_03, false)
  Battle.SetEffectScriptLoop(EFF_04, false)
  Battle.SetEffectScriptLoop(EFF_05, false)
  Battle.SetEffectScriptLoop(EFF_06, false)
end

function ThunderboltPlay()
  Battle.SetEffectScriptLoop(EFF_01, true)
  Battle.SetEffectScriptLoop(EFF_02, true)
  Battle.SetEffectScriptLoop(EFF_03, true)
  Battle.SetEffectScriptLoop(EFF_04, true)
  Battle.SetEffectScriptLoop(EFF_05, true)
  Battle.SetEffectScriptLoop(EFF_06, true)
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
