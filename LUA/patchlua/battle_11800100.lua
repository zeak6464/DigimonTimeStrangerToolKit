require("include_battle")
Round = 0
EFF_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadEffectScript(EFF_01, "ef_b_sta_250")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "e513")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
  SetEndrollMember(11800100)
end

function Battle_After_Build()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bv01")
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m410_040")
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m410_050")
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(931, 0)
end

function Battle_Start(info)
  FadeAllIn(FADE_WHITE, FADE_TIME)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 70 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
  end
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local enemy_id = info.enemy_id
  if Flg.Check("Battle5109") == false then
    Battle.SetCamera(0.35, 10.91, 7.87, 0.07, 15.29, -1.1, DEFAULT_ANGLE, 0, EASING_MODE_LINEAR)
    WaitFrame(1)
    Battle.SetCamera(-0.11, 0.81, 32.38, -0.04, 3.84, 22.85, DEFAULT_ANGLE, 60, EASING_MODE_LINEAR)
    WaitFrame(60)
    Battle.SetFieldEffectSkill(29697, -1, -1)
    Flg.Set("Battle5109")
  end
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
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and info.group == 2 and info.index == 0 then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
  end
  if Flg.Check("Battle5110") == false and Flg.Check("Battle5105") then
    if info.group == 0 then
      if info.index == 0 then
        Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
      elseif info.index == 1 then
        Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
      elseif info.index == 2 then
        Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
      end
      Window.OpenInfo(11800100)
      WaitFrame(1)
      while not Window.IsNextInfo() do
        WaitFrame(1)
      end
      Window.CloseInfo()
      WaitFrame(1)
      while not Window.IsEndCloseInfo() do
        WaitFrame(1)
      end
    elseif info.group == 1 then
      if info.index == 0 then
        Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
      end
      Window.OpenInfo(11800100)
      WaitFrame(1)
      while not Window.IsNextInfo() do
        WaitFrame(1)
      end
      Window.CloseInfo()
      WaitFrame(1)
      while not Window.IsEndCloseInfo() do
        WaitFrame(1)
      end
    elseif info.group == 2 then
      if info.index == 0 then
        Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
      end
      Window.OpenInfo(11800100)
      WaitFrame(1)
      while not Window.IsNextInfo() do
        WaitFrame(1)
      end
      Window.CloseInfo()
      WaitFrame(1)
      while not Window.IsEndCloseInfo() do
        WaitFrame(1)
      end
    else
      Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
      Window.OpenInfo(11800100)
      WaitFrame(1)
      while not Window.IsNextInfo() do
        WaitFrame(1)
      end
      Window.CloseInfo()
      WaitFrame(1)
      while not Window.IsEndCloseInfo() do
        WaitFrame(1)
      end
    end
    Flg.Set("Battle5110")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    if Flg.Check("Battle5205") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 21713)
    else
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 21714)
    end
    Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    if Flg.Check("Battle5104") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0, 0.96, 4.26, 0, 3.09, -5.5, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(31)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 0, false)
      Battle.PlayEffectScript(EFF_01, 0)
      Battle.SetEffectScriptPosition(EFF_01, 0.19, 0, -6.19)
      Battle.MessageTalk(1180010002)
      WaitFrame(60)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      WaitFrame(30)
      Battle.SetCamera(6.1143, 1.4563, 9.83, 4.501, 0.8504, 12.575, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 4.501, 0, 12.57)
      Battle.SetModelRotationY(GUEST_DIGIMON, 0, 180)
      Battle.SetModelPosition(PLAYER_CHARA, 0, 4, 0, 15)
      Battle.SetModelRotationY(PLAYER_CHARA, 0, 180)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, 27.16, 0, -15.06)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.71, 0, -13.5)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, 30.57, 0, -15.06)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
      WaitFrame(60)
      BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 10, true)
      Battle.MessageTalk(1180010003)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Battle.ResetModelRotationY(GUEST_DIGIMON, 0)
      Flg.Set("Battle5104")
    end
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 96901 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(200)
    else
      Battle.AddEnemyCP(400)
    end
  end
  if Battle.IsTurnCharacterExtraTurn() == false and Flg.Check("Battle5051") and Flg.Check("Battle5053") == false and enemy_id == 96901 then
    Battle.SetupCPCharge(70003, 94401, ENEMY_DIGIMON, 0, "FP01", 2)
    Flg.Set("Battle5053")
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, false)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
    Round = 0
    if Flg.Check("Battle5102") == false then
      Flg.Set("Battle5102")
    end
  end
  if Round == 2 and Flg.Check("Battle5053") and Flg.Check("Battle5104") == false and enemy_id == 96901 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
end

function Battle_Action_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 96901 and Flg.Check("Battle5104") then
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
  if info.group == ENEMY_DIGIMON and info.enemy_id == 96901 then
    local skill_id = Battle.GetLastCommandSkillID()
    if (skill_id == 21713 or skill_id == 21714) and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
  if Flg.Check("Battle5105") == false and Flg.Check("Battle5106") then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(0.2416, 1.5966, 4.7998, -6.8908, -2.0511, 10.563, DEFAULT_ANGLE, 0, EASING_MODE_LINEAR)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -1.5207, 0, 6.2255)
    Battle.SetModelRotationY(GUEST_DIGIMON, 0, 150)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 27.16, 0, -15.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.71, 0, -13.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 30.57, 0, -15.06)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "e513", 0, true)
    WaitFrame(15)
    Battle.MessageTalk(1180010004)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bv01", 10, false, 30)
    WaitFrame(50)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 10, true)
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5105")
    Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_ITEM, true)
    Battle.ClearLoopFrameAnimation(GUEST_DIGIMON, 0, "bn01")
    Battle.ResetModelRotationY(GUEST_DIGIMON, 0)
  end
end

function Battle_Turn_End(info)
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
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  if enemy_id == 96901 and Flg.Check("Battle5118") and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) ~= 70007 then
    Battle.AddBuff(PLAYER_DIGIMON, 0, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 1, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 2, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 3, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 4, 561303)
    Battle.AddBuff(PLAYER_DIGIMON, 5, 561303)
    Battle.AddBuff(GUEST_DIGIMON, 0, 561303)
    Flg.Clear("Battle5118")
  end
  if 0 < enemy_now_hp then
    if enemy_now_hp / enemy_max_hp < 0.75 and Flg.Check("Battle5106") == false then
      Battle.SetCamera(0.35, 10.91, 7.87, 0.07, 15.29, -1.1, DEFAULT_ANGLE, 0, EASING_MODE_LINEAR)
      WaitFrame(1)
      Battle.SetCamera(-0.11, 0.81, 32.38, -0.04, 3.84, 22.85, DEFAULT_ANGLE, 60, EASING_MODE_LINEAR)
      WaitFrame(30)
      Battle.SetFieldEffectSkill(29695, -1, -1)
      Battle.AddBuff(PLAYER_DIGIMON, 3, 561304)
      Battle.AddBuff(PLAYER_DIGIMON, 4, 561304)
      Battle.AddBuff(PLAYER_DIGIMON, 5, 561304)
      Flg.Set("Battle5106")
    elseif enemy_now_hp / enemy_max_hp < 0.5 and Flg.Check("Battle5106") and Flg.Check("Battle5107") == false then
      Battle.SetCamera(0.35, 10.91, 7.87, 0.07, 15.29, -1.1, DEFAULT_ANGLE, 0, EASING_MODE_LINEAR)
      WaitFrame(1)
      Battle.SetCamera(-0.11, 0.81, 32.38, -0.04, 3.84, 22.85, DEFAULT_ANGLE, 60, EASING_MODE_LINEAR)
      WaitFrame(30)
      Battle.SetFieldEffectSkill(29698, -1, -1)
      Battle.AddBuff(PLAYER_DIGIMON, 3, 561305)
      Battle.AddBuff(PLAYER_DIGIMON, 4, 561305)
      Battle.AddBuff(PLAYER_DIGIMON, 5, 561305)
      Flg.Set("Battle5107")
    elseif enemy_now_hp / enemy_max_hp < 0.25 and Flg.Check("Battle5107") and Flg.Check("Battle5108") == false then
      Battle.SetCamera(0.35, 10.91, 7.87, 0.07, 15.29, -1.1, DEFAULT_ANGLE, 0, EASING_MODE_LINEAR)
      WaitFrame(1)
      Battle.SetCamera(-0.11, 0.81, 32.38, -0.04, 3.84, 22.85, DEFAULT_ANGLE, 60, EASING_MODE_LINEAR)
      WaitFrame(30)
      Battle.SetFieldEffectSkill(29699, -1, -1)
      Battle.AddBuff(PLAYER_DIGIMON, 3, 561306)
      Battle.AddBuff(PLAYER_DIGIMON, 4, 561306)
      Battle.AddBuff(PLAYER_DIGIMON, 5, 561306)
      Flg.Set("Battle5108")
    end
  end
  if round_count == 6 and Flg.Check("Battle5101") == false then
    Flg.Set("Battle5011")
  end
  if Round == 6 and Flg.Check("Battle5101") then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 1000) then
    Flg.Set("Battle5013")
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
  if Battle.IsAccomplishConditionType2(BATTLE_CONDITION_TYPE_DAMAGE_MAGNIFICATION_OVER, 3, ENEMY_DIGIMON, 0, 4, 200, false) then
    Flg.Set("Battle5017")
  end
  if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.01, 1.92, 4.65, 0.58, 2.4, -5.31, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1180010001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.SetSkill(ENEMY_DIGIMON, 0, -1, 30263)
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 596902)
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    Battle.SetSkill(ENEMY_DIGIMON, 0, -1, 30273)
    Flg.Set("Battle5203")
  end
  if 4 <= stock_num and Flg.Check("Battle5204") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 596904)
    Flg.Set("Battle5204")
  end
  if 5 <= stock_num and Flg.Check("Battle5205") == false then
    Flg.Set("Battle5205")
  end
  print("stock_num:", stock_num)
  if stock_num == 1 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33041)
  elseif stock_num == 1 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33011)
  elseif stock_num == 2 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30273)
  elseif stock_num == 2 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30293)
  elseif stock_num == 3 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33021)
  elseif stock_num == 3 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33031)
  elseif stock_num == 4 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30303)
  elseif stock_num == 4 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30273)
  elseif 5 <= stock_num and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33031)
  elseif 5 <= stock_num and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 33011)
  end
  if stock_num == 0 or Flg.Check("Battle5051") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 21713 then
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
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    flgcount = 0
    Round = 0
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
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
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 596902)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 596904)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Battle.SetSkill(ENEMY_DIGIMON, 0, 3, -1)
    Battle.SetSkill(ENEMY_DIGIMON, 0, 4, -1)
    flgcount = 0
    Round = 0
    Battle.ClearCPCharge()
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, true)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
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
  Flg.Set("FLAG_MAIN_19_064")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(171, DIGIMON_GRASP_FLAG_SCAN)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m410_060")
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
