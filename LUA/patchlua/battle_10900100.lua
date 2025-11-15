require("include_battle")
CP_Round = 0
Round = 0
cphp = 0
Form_Round = 0
EFF_01 = 1
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadEffectScript(EFF_01, "ef_b_bos_116")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "fe02")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bt01_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bt01_02")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bt02_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bt02_02")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bt03_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bt03_02")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bg02")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bg02_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bg02_02")
  Battle.LoadCameraAnimation("Cam_bt_change01")
  SetEndrollMember(10900100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m260_090")
    Fade.AllIn(0, Util.SecondFromFrame(15))
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(930, 0)
end

function Battle_Start(info)
  print("=========== Battle_Start ===========")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590903)
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(-0.61, 4.37, -0.34, -1.23, 4.44, -10.32, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
  WaitFrame(30)
  Battle.MessageTalk(1090010001)
  WaitMessage()
  Battle.MessageTalk(1090010002)
  WaitMessage()
  Battle.MessageTalk(1090010003)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  Battle.AddBuff(GUEST_DIGIMON, 0, 114100)
  Flg.Set("Battle5120")
  math.randomseed(os.time())
  local random = math.random(1, 100)
  if 1 <= random and random <= 40 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30062)
  elseif 41 <= random and random <= 80 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30302)
  elseif 81 <= random and random <= 100 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30125)
  end
  Flg.Set("Battle5105")
  Form_Round = info.round
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 70 < enemy_level then
    is_high_difficulty = true
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30102, 30103)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30112, 30113)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30125, 30126)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30052, 30053)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30065, 30066)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30062, 30063)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30302, 30303)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30132, 30133)
  end
end

function Battle_Round_Start(info)
  print("=========== Battle_Round_Start round = ", info.round, " ===========")
  local round_count = info.round
  if Flg.Check("Battle5053") == false then
    CP_Round = CP_Round + 1
    print("##### CP_Round: ", CP_Round, " ROUND #####")
  end
  if Flg.Check("Battle5053") then
    Round = Round + 1
    print("##### Round: ", Round, " ROUND #####")
  end
  if Flg.Check("Battle5124") then
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590907)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 590903)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Form_Round = round_count
    Flg.Clear("Battle5124")
  end
end

function Battle_Turn_Start(info)
  print("=========== Battle_Turn_Start digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " group = ", info.group, " ===========")
  local digimon_id = info.digimon_id
  local enemy_id = info.enemy_id
  if enemy_id == 90901 and Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if info.group == 2 and info.index == 0 then
    if Flg.Check("Battle5053") then
      Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
    end
    if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70008 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
    end
  end
  if Flg.Check("Battle5106") then
    if Flg.Check("Battle5011") == false and Flg.Check("Battle5108") == false then
      Battle.AddMotionScheduleIdleByStatus(ENEMY_DIGIMON, 0, true)
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(7.48, 3.75, -3.03, 4.77, 3.5, -12.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.MessageTalk(1090010014)
      WaitMessage()
      Battle.MessageTalk(1090010012)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5108")
      Flg.Set("Battle5109")
    elseif Flg.Check("Battle5011") and Flg.Check("Battle5109") == false then
      Battle.AddMotionScheduleIdleByStatus(ENEMY_DIGIMON, 0, true)
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(7.48, 3.75, -3.03, 4.77, 3.5, -12.66, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.MessageTalk(1090010009)
      WaitMessage()
      Battle.MessageTalk(1090010010)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5108")
      Flg.Set("Battle5109")
    end
  end
end

function Battle_Command_Start(info)
  print("=========== Battle_Command_Start ===========")
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local round_count = info.round
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  print("##### enemy_last_skill_id = ", enemy_last_skill_id, " #####")
  if enemy_id == 90901 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5001") == false and Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(200)
    else
      Battle.AddEnemyCP(400)
    end
  end
  print("use skill:", enemy_last_skill_id)
  if enemy_id == 90901 then
    if Flg.Check("Battle5053") == false then
      if Flg.Check("Battle5111") or Flg.Check("Battle5112") then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29098)
      end
      if Flg.Check("Battle5051") then
        Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP03")
        if Flg.Check("Battle5111") == false and Flg.Check("Battle5112") == false then
          Battle.SetupCPCharge(70003, 93401, ENEMY_DIGIMON, 0, "CP01", 2)
        else
          Battle.SetupCPCharge(70003, 93401, ENEMY_DIGIMON, 0, "CP01", 1)
        end
        Battle.SetOverwriteCamera("camera_big_SSeadra02")
        Flg.Set("Battle5053")
        Round = 0
      end
    elseif Flg.Check("Battle5053") then
      if Flg.Check("Battle5111") == false and Flg.Check("Battle5112") == false then
        if Round == 2 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
          AddTarget_nobreakHP()
          Battle.CompleteCPCharge(70008)
        end
      elseif Round == 1 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
        AddTarget_nobreakHP()
        Battle.CompleteCPCharge(70008)
      end
    end
    if enemy_last_skill_id == 70001 then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70008)
    end
    if enemy_last_skill_id == 70008 then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29091)
      Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    end
  end
  if info.group == 2 and info.index == 0 then
    math.randomseed(os.time())
    local random = math.random(1, 3)
    if Flg.Check("Battle5104") then
      if random == 1 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10011)
      elseif random == 2 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30013)
      elseif random == 3 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30253)
      end
    elseif Flg.Check("Battle5105") then
      if random == 1 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30322)
      else
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30232)
      end
    elseif Flg.Check("Battle5106") then
      if random == 1 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10011)
      elseif random == 2 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30013)
      elseif random == 3 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30253)
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
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX * 0.5)
      Flg.Clear("Battle5353")
      Flg.Clear("Battle5399")
    end
    Flg.Set("Battle5300")
  end
  if info.group == ENEMY_DIGIMON and info.enemy_id == 90901 and Battle.GetLastCommandSkillID() == 29091 and info.use_count == 0 then
    Battle.SetBattleSpeedToNormalForTurn()
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  print("=========== Battle_Turn_End ===========")
  local enemy_id = info.enemy_id
  local round_count = info.round
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  local skill_id = Battle.GetLastActionSkillID()
  print("##### enemy_last_skill_id = ", enemy_last_skill_id, " #####")
  print("##### skill_id = ", skill_id, " #####")
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local is_break = Battle.IsBreakCPCharge()
  if enemy_last_skill_id == 70001 then
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  if 0 < enemy_now_hp and Flg.Check("Battle5105") and Battle.IsBuff(ENEMY_DIGIMON, 0, 590907, BUFF_CHECK_AND_WITH_ID) == false then
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_MAGIC, 3, ENEMY_DIGIMON, 0, 5) == true then
      if Flg.Check("Battle5126") then
        MoveFromBodyToHead()
      else
        Form_Round = round_count
        MoveFromBodyToTail()
      end
    elseif round_count - Form_Round > 2 then
      Flg.Set("Battle5011")
      if Flg.Check("Battle5012") then
        MoveFromBodyToHead()
      else
        Form_Round = round_count
        MoveFromBodyToTail()
      end
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_COUNTER_PHYSICAL, 3, ENEMY_DIGIMON, 0, 1) and Flg.Check("Battle5110") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(1.79, 4.5, -1.03, 0.31, 4.34, -10.92, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.MessageTalk(1090010008)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5110")
    end
    if Flg.Check("Battle5001") and Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_COUNTER_PHYSICAL, 3, ENEMY_DIGIMON, 0, 3) == true then
      Form_Round = round_count
      MoveFromBodyToTail()
    end
  elseif 0 < enemy_now_hp and Flg.Check("Battle5104") then
    if Flg.Check("Battle5126") == false then
      Flg.Set("Battle5126")
    end
    local is_weekhit = Battle.IsAccomplishConditionType2(BATTLE_CONDITION_TYPE_DAMAGE_MAGNIFICATION_OVER, 3, ENEMY_DIGIMON, 0, 5, 150, true)
    local is_physical = Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_PHYSICAL, 3, ENEMY_DIGIMON, 0, 8)
    local is_resist = Battle.IsAccomplishConditionType2(BATTLE_CONDITION_TYPE_DAMAGE_MAGNIFICATION_BELOW, 3, ENEMY_DIGIMON, 0, 3, 50, false)
    local is_big_fail = Flg.Check("Battle5011") and Flg.Check("Battle5012")
    local is_fail = Flg.Check("Battle5011") or Flg.Check("Battle5012")
    if is_weekhit or is_physical or Flg.Check("Battle5111") or Flg.Check("Battle5112") then
      print("##### Charge Start #####")
      Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590904)
      if Flg.Check("Battle5111") or Flg.Check("Battle5112") then
        print("##### BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT #####")
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
      else
        print("##### Success #####")
      end
      Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bb01")
      Flg.Set("Battle5051")
      Flg.Clear("Battle5104")
    elseif is_big_fail or is_resist == true and Flg.Check("Battle5112") == false then
      print("##### Big Failed #####")
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(8.12, 5.82, -0.61, 3.38, 6.31, -9.4, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(30)
      Battle.MessageTalk(1090010006)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      print("##### BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT #####")
      BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
      Flg.Set("Battle5112")
    elseif is_fail or CP_Round == 3 and Flg.Check("Battle5111") == false then
      print("##### Failed #####")
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(8.12, 5.82, -0.61, 3.38, 6.31, -9.4, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(30)
      Battle.MessageTalk(1090010006)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      print("##### BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT #####")
      BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
      Flg.Set("Battle5111")
    end
  elseif 0 < enemy_now_hp and Flg.Check("Battle5106") then
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_REFLECT_MAGIC, 3, ENEMY_DIGIMON, 0, 1) then
      Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_HIT_COUNT_OVER, 3, ENEMY_DIGIMON, 0, 9) then
      if Flg.Check("Battle5011") or Flg.Check("Battle5126") == false then
        MoveFromTailToHead()
      else
        Form_Round = round_count
        MoveFromTailToBody()
      end
    elseif Battle.IsAccomplishConditionType2(BATTLE_CONDITION_TYPE_DAMAGE_MAGNIFICATION_OVER, 3, ENEMY_DIGIMON, 0, 4, 300, false) then
      MoveFromTailToHead()
    elseif CP_Round == 9 then
      MoveFromTailToHead()
    elseif round_count - Form_Round > 2 then
      Flg.Set("Battle5012")
      if Flg.Check("Battle5011") or Flg.Check("Battle5126") == false then
        MoveFromTailToHead()
      else
        Form_Round = round_count
        MoveFromTailToBody()
      end
    end
  end
  if enemy_last_skill_id == 70001 then
    print("##### BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT #####")
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  if enemy_last_skill_id == 70008 then
    print("##### Change Damage Reaction #####")
    Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, 55, "bb02")
    Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bb01")
    if Flg.Check("Battle5103") == false and Flg.Check("Battle5111") and Flg.Check("Battle5112") then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(8.12, 5.82, -0.61, 3.38, 6.31, -9.4, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
      WaitFrame(30)
      Battle.MessageTalk(1090010006)
      WaitMessage()
      Battle.MessageTalk(1090010007)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5103")
    end
  end
  if 0 < enemy_now_hp and enemy_last_skill_id == 29091 then
    Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, 55, "bd01_02")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5020")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5103")
    Flg.Clear("Battle5300")
    Round = 0
    CP_Round = 0
    Form_Round = round_count
    if Flg.Check("Battle5112") == true then
      ReturnTail()
      if Flg.Check("Battle5011") == false and Flg.Check("Battle5012") == false then
        Battle.AddMotionScheduleIdleByStatus(ENEMY_DIGIMON, 0, true)
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(7.48, 3.75, -3.03, 4.77, 3.5, -12.66, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
        Battle.MessageTalk(1090010009)
        WaitMessage()
        Battle.MessageTalk(1090010010)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
      end
    else
      ReturnBody()
    end
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5111")
    Flg.Clear("Battle5112")
  end
  if 0 < enemy_now_hp and is_break then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5020")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5103")
    Flg.Clear("Battle5300")
    Flg.Clear("Battle5111")
    Flg.Clear("Battle5112")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30065, -1)
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30132, -1)
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30302, -1)
    end
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Round = 0
    CP_Round = 0
    Battle.ClearCPCharge()
    Form_Round = round_count
    ReturnBody()
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590903)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 590907)
    Flg.Set("Battle5123")
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(1.19, 8.46, 6.04, -0.2, 7.6, -3.82, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 31.71, 0, 8.6)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 37.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 47.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 57.71, 0, 28.56)
    Battle.MessageTalk(1090010004)
    WaitMessage()
    Battle.MessageTalk(1090010005)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if enemy_last_skill_id == 70007 and Flg.Check("Battle5123") then
    Flg.Clear("Battle5123")
    Flg.Set("Battle5124")
  end
  if Flg.Check("Battle5051") == false and Flg.Check("Battle5111") == false and Flg.Check("Battle5112") == false then
    math.randomseed(os.time())
    local random = math.random(1, 100)
    if Flg.Check("Battle5123") then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    elseif Flg.Check("Battle5106") then
      if 1 <= random and random <= 15 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 32141)
      elseif 16 <= random and random <= 30 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 32161)
      elseif 31 <= random and random <= 50 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29095)
      elseif 51 <= random and random <= 85 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29092)
      elseif 86 <= random and random <= 100 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29093)
      end
    elseif Flg.Check("Battle5105") then
      if 1 <= random and random <= 40 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30062)
      elseif 41 <= random and random <= 80 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30302)
      elseif 81 <= random and random <= 100 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30125)
      end
    elseif Flg.Check("Battle5104") then
      if round_count % 2 == 0 then
        if 1 <= random and random <= 40 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30053)
        elseif 41 <= random and random <= 80 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30293)
        elseif 81 <= random and random <= 100 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29096)
        end
      elseif round_count % 2 == 1 then
        if 1 <= random and random <= 50 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29094)
        elseif 51 <= random and random <= 70 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30053)
        elseif 71 <= random and random <= 90 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30293)
        elseif 91 <= random and random <= 100 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29096)
        end
      end
    end
  end
  local stock_num = Battle.GetCPStockNum()
  print("stock_num:", stock_num)
  if Flg.Check("Battle5053") == false and Flg.Check("Battle5111") == false and Flg.Check("Battle5112") == false then
    if stock_num == 1 and info.round % 2 == 1 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30282)
    elseif stock_num == 1 and info.round % 2 == 0 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
    elseif stock_num == 2 and info.round % 2 == 1 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30052)
    elseif stock_num == 2 and info.round % 2 == 0 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32201)
    elseif stock_num == 3 and info.round % 2 == 1 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30112)
    elseif stock_num == 3 and info.round % 2 == 0 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32221)
    elseif 4 <= stock_num and info.round % 2 == 1 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30302)
    elseif 4 <= stock_num and info.round % 2 == 0 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32031)
    end
  elseif stock_num == 0 or Flg.Check("Battle5053") or Flg.Check("Battle5111") or Flg.Check("Battle5112") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30065, 30066)
    end
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30132, 30133)
    end
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30302, 30303)
    end
    Flg.Set("Battle5203")
  end
  if Flg.Check("Battle5113") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    Form_Round = round_count
    MoveFromHeadToBody()
    Flg.Clear("Battle5113")
  elseif Flg.Check("Battle5114") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    MoveFromTailToHead()
    Flg.Clear("Battle5114")
  elseif Flg.Check("Battle5115") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    Form_Round = round_count
    MoveFromBodyToTail()
    Flg.Clear("Battle5115")
  elseif Flg.Check("Battle5116") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    Form_Round = round_count
    MoveFromHeadToTail()
    Flg.Clear("Battle5116")
  elseif Flg.Check("Battle5117") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    MoveFromBodyToHead()
    Flg.Clear("Battle5117")
  elseif Flg.Check("Battle5118") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    Form_Round = round_count
    MoveFromTailToBody()
    Flg.Clear("Battle5118")
  elseif Flg.Check("Battle5119") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    Form_Round = round_count
    ReturnBody()
    Flg.Clear("Battle5119")
  elseif Flg.Check("Battle5121") then
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5105")
    Flg.Clear("Battle5106")
    Form_Round = round_count
    ReturnTail()
    Flg.Clear("Battle5121")
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_09_040")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(908, DIGIMON_GRASP_FLAG_SCAN)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m260_100")
end

function MoveFromBodyToHead()
  print("####### MoveFromBodyToHead #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590903)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, 31.71, 0, 8.6)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, 31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, 37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, 47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, 57.71, 0, 28.56)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt01_02", 0, false)
  WaitFrame(46)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt03_01", 0, false)
  WaitFrame(100)
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP03")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02_02")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590904)
  Flg.Set("Battle5104")
  Flg.Clear("Battle5105")
  CP_Round = 0
end

function MoveFromBodyToTail()
  print("####### MoveFromBodyToTail #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590903)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, 31.71, 0, 8.6)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, 31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, 37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, 47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, 57.71, 0, 28.56)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt01_02", 0, false)
  WaitFrame(46)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt02_01", 0, false)
  WaitFrame(210)
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02_01")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590906)
  Flg.Set("Battle5106")
  Flg.Clear("Battle5105")
  CP_Round = 0
end

function MoveFromTailToBody()
  print("####### MoveFromTailToBody #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590906)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, 31.71, 0, 8.6)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, 31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, 37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, 47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, 57.71, 0, 28.56)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt02_02", 0, false)
  WaitFrame(100)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt01_01", 0, false)
  WaitFrame(100)
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590903)
  Flg.Set("Battle5105")
  Flg.Clear("Battle5106")
  CP_Round = 0
end

function MoveFromTailToHead()
  print("####### MoveFromTailToHead #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590906)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, 31.71, 0, 8.6)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, 31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, 37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, 47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, 57.71, 0, 28.56)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt02_02", 0, false)
  WaitFrame(100)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt03_01", 0, false)
  WaitFrame(100)
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP03")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590904)
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02_02")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590904)
  Flg.Set("Battle5104")
  Flg.Clear("Battle5106")
  CP_Round = 0
  if Flg.Check("Battle5011") == false and Flg.Check("Battle5012") == false then
    Flg.Set("Battle5122")
  end
end

function MoveFromHeadToBody()
  print("####### MoveFromHeadToBody #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590904)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, 31.71, 0, 8.6)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, 31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, 37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, 47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, 57.71, 0, 28.56)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt03_02", 0, false)
  WaitFrame(100)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt01_01", 0, false)
  WaitFrame(100)
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590903)
  Flg.Set("Battle5105")
  Flg.Clear("Battle5104")
  CP_Round = 0
end

function MoveFromHeadToTail()
  print("####### MoveFromHeadToTail #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.RemoveBuff(ENEMY_DIGIMON, 0, 590904)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, 31.71, 0, 8.6)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, 31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, 37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, 47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, 57.71, 0, 28.56)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt03_02", 0, false)
  WaitFrame(100)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt02_01", 0, false)
  WaitFrame(210)
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02_01")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590906)
  Flg.Set("Battle5106")
  Flg.Clear("Battle5104")
  CP_Round = 0
end

function ReturnBody()
  print("####### ReturnBody #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, -47.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, -47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP01")
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt01_01", 0, false)
  WaitFrame(100)
  Battle.SetOverwriteCamera("camera_big_SSeadra01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590903)
  Flg.Set("Battle5105")
  CP_Round = 0
  if Flg.Check("Battle5001") == false and Flg.Check("Battle5011") == false and Flg.Check("Battle5012") == false then
    Flg.Set("Battle5001")
  end
end

function ReturnTail()
  print("####### ReturnTail #######")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, -47.71, 0, 28.56)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, -47.71, 0, 28.56)
  Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
  Battle.SetCameraAnimation("Cam_bt_change01")
  Battle.SetTargetCursorPositionModelJointName(ENEMY_DIGIMON, 0, "FP02")
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bt02_01", 0, false)
  WaitFrame(210)
  Battle.SetOverwriteCamera("camera_big_SSeadra01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bg02_01")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 590906)
  Flg.Set("Battle5106")
  CP_Round = 0
  if Flg.Check("Battle5001") == false and Flg.Check("Battle5011") == false and Flg.Check("Battle5012") == false then
    Flg.Set("Battle5001")
  end
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
