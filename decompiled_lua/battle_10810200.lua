require("include_battle")
Round = 0
CP_Round = 0
flgcountcp = 0
EFF_01 = 1
EFF_02 = 2
EFF_03 = 3
OBJ_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadEffectScript(EFF_01, "ef_b_bos_132")
  Battle.LoadEffectScript(EFF_02, "ef_b_bos_135")
  Battle.LoadEffectScript(EFF_03, "ef_b_hit_140_thunder")
  Battle.LoadTalk("battle")
  Battle.LoadObject(OBJ_01, "f00barrier02")
  Battle.LoadObjectAnimation(OBJ_01, "e001")
  Battle.LoadObjectAnimation(OBJ_01, "e002")
end

function Battle_After_Setup()
  local Enemy_Lv = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  print("####### Enemy_Lv = ", Enemy_Lv, " #######")
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 0, 93001, Enemy_Lv + 10)
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bd01")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e503")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e008")
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e202")
  SetEndrollMember(10810200)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
end

function Battle_Opening(info)
  print("####### Battle_Opening #######")
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m210_030")
    Battle.ReadyNextSceneForVista()
    Execute("m210_031")
    Fade.AllIn(1, Util.SecondFromFrame(30))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(206, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  print("####### Battle_Start #######")
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
end

function Battle_Round_Start(info)
  print("####### Battle_Round_Start #######")
  if Flg.Check("Battle5002") then
    if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
      CP_Round = CP_Round + 1
      print("####### Count CP_Round = ", CP_Round, " #######")
    end
    if Flg.Check("Battle5053") then
      Round = Round + 1
      print("####### Count Round = ", Round, " #######")
    end
  end
end

function Battle_Turn_Start(info)
  print("####### Battle_Turn_Start #######")
  if Battle.IsTurnCharacterExtraTurn() then
    print("####### Extra_Turn_Start #######")
  end
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if Flg.Check("Battle5001") and Flg.Check("Battle5103") == false then
    print("####### PHASE2 TAITAMON INITIALIZE #######")
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
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
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5204")
    Flg.Clear("Battle5205")
    Flg.Clear("Battle5206")
    Flg.Clear("Battle5207")
    Flg.Clear("Battle5208")
    Flg.Clear("Battle5209")
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_PLAYER_SIDE_TOTAL_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30305, -1)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593001)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593003)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593004)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593005)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593006)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593007)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
    Flg.Set("Battle5103")
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5002") then
    print("####### SetNextCommandSkill = 70004 #######")
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
end

function Battle_Command_Start(info)
  print("####### Battle_Command_Start #######")
  local enemy_id = info.enemy_id
  local round_count = info.round
  local count = (round_count - 2) % 3
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  print("use skill:", enemy_last_skill_id)
  print("Round:", Round)
  if enemy_id == 92901 then
    Battle.AddEnemyCP(800)
    if round_count % 3 == 0 then
      Flg.Clear("Battle5118")
    end
    if Flg.Check("Battle5118") == false then
      if round_count == 2 then
        print("####### SetNextCommandSkill = 29291 #######")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29291)
        Flg.Set("Battle5118")
      elseif 5 <= round_count and count == 0 then
        print("####### SetNextCommandSkill = 29291 #######")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29291)
        Flg.Set("Battle5118")
      end
    end
  elseif enemy_id == 93001 then
    math.randomseed(os.time())
    local random = 10
    if Flg.Check("Battle5053") then
      Battle.AddEnemyCP(1000)
    elseif Flg.Check("Battle5002") == false then
      random = math.random(6, 8)
      Battle.AddEnemyCP(random * 100)
    elseif Flg.Check("Battle5002") then
      random = math.random(8, 10)
      Battle.AddEnemyCP(random * 100)
    end
    if Battle.IsTurnCharacterExtraTurn() == false then
      if Flg.Check("Battle5051") and Flg.Check("Battle5052") == false then
        print("####### SetNextCommandSkill = 44401 #######")
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 44401)
        if Flg.Check("Battle5206") then
          print("####### skill call = 70003 RemoveBuff #######")
          Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
          Flg.Clear("Battle5206")
        end
        Flg.Set("Battle5052")
      end
      if Flg.Check("Battle5052") and enemy_last_skill_id == 44401 then
        Round = 0
        print("Round:", Round)
        if Flg.Check("Battle5002") == false then
          print("####### SetupCPCharge = 70003 #######")
          Battle.SetupCPCharge(70003, 93101, ENEMY_DIGIMON, 0, "FP02", 2)
          Flg.Set("Battle5053")
        elseif Flg.Check("Battle5002") == true then
          print("####### SetupCPCharge = 70003 #######")
          Battle.SetupCPCharge(70003, 93101, ENEMY_DIGIMON, 0, "FP02", 2)
          Flg.Set("Battle5053")
        end
      end
      if enemy_last_skill_id == 70003 then
        if Flg.Check("Battle5102") == false then
          print("####### Unused Program #######")
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29301)
          WaitFrame(20)
          Battle.SetMonochrome(true)
          Battle.SetNegative(true)
          Sound.PlaySE(404003, 100, false)
          Battle.CloseUI()
          Battle.StartScreenCaptureDraw()
          WaitFrame(105)
          Battle.EndScreenCaptureDraw()
          slot = Sound.PlaySE(300113, 100, false)
          Battle.PlayScreenCrackingEffect()
          Battle.SetMonochrome(false)
          Battle.SetNegative(false)
          WaitFrame(45)
          Sound.StopSE(slot, 0)
          Flg.Set("Battle5054")
          FlgcountCp()
          Battle.ClearCPCharge()
        elseif Flg.Check("Battle5102") == true and Flg.Check("Battle5002") == false then
          print("####### m210_045 #######")
          Battle.PlayObjectAnimation(OBJ_01, "e002", true)
          Battle.CloseUI()
          Battle.ClearCPCharge()
          Battle.ReadyNextSceneForVista()
          Execute("m210_045")
          Battle.SetBattleCamera(BATTLE_CAMERA_ID_DAMAGE_PLAYER_ALL, ENEMY_DIGIMON, 0)
          slot = Sound.PlaySE(300113, 100, false)
          Battle.PlayScreenCrackingEffect()
          Battle.SetMonochrome(false)
          Battle.SetNegative(false)
          Sound.StopSE(slot, 0)
          BtlPlayAnimation(ENEMY_DIGIMON, 0, "bd02", 0, false)
          Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_IDLE, "bn02")
          Battle.AddMotionScheduleIdleByStatus(ENEMY_DIGIMON, 0, true)
          Battle.PlayEffectScript(EFF_03, 0)
          Battle.SetEffectScriptPosition(EFF_03, -0.1, 4.56, -6.78)
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
          Flg.Set("Battle5108")
        end
      end
      if Flg.Check("Battle5053") and Flg.Check("Battle5002") and 2 <= Round then
        print("####### SetNextCommandSkill = 70001 #######")
        AddTarget_nobreakHP()
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
        Battle.CompleteCPCharge(70005)
      end
      if enemy_last_skill_id == 70001 then
        print("####### CP CHARGE FINISH SetNextCommandSkill = 70005 #######")
        AddTarget_nobreakHP()
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
      end
      if enemy_last_skill_id == 70005 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29302)
        Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
        if Flg.Check("Battle5113") == false then
          Battle.LoadAnimation(ENEMY_DIGIMON, 0, "fe02")
          Talk.OpenLetterBox()
          Battle.CloseUI()
          Battle.SetCamera(0, 1.9, 5.62, 0, 5.75, -3.62, DEFAULT_ANGLE, 60, MODE_QUADRATIC_IN_OUT)
          WaitFrame(30)
          BtlPlayAnimation(ENEMY_DIGIMON, 0, "fe02", 0, false)
          Battle.AddMotionScheduleIdleByStatus(ENEMY_DIGIMON, 0, true)
          Battle.AttatchEffectScriptToModel(EFF_01, ENEMY_DIGIMON, 0)
          Battle.PlayEffectScript(EFF_01, 0)
          Battle.MessageTalk(1081020014)
          WaitMessage()
          Battle.MessageTalk(1081020015)
          WaitMessage()
          Talk.CloseLetterBox()
          Battle.CloseTalk()
          while not Battle.IsCloseTalk() do
            WaitFrame(1)
          end
          Flg.Set("Battle5113")
        end
      end
    end
  end
end

function Battle_Action_Start(info)
  print("####### Battle_Action_Start #######")
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  local skill_id = Battle.GetLastActionSkillID()
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_hp_ratio = enemy_now_hp / enemy_max_hp
  print("####### enemy_id = ", enemy_id, " skill_id = ", skill_id, " #######")
  print("####### enemy_last_skill_id = ", enemy_last_skill_id, " #######")
  print("####### enemy_now_hp = ", enemy_now_hp, " enemy_hp_ratio = ", enemy_hp_ratio, " #######")
  if enemy_id == 93001 then
    if enemy_last_skill_id == 29301 or enemy_last_skill_id == 29302 then
      Battle.StopEffectScript(EFF_01, 0)
    end
    if Flg.Check("Battle5054") and Flg.Check("Battle5002") == false then
      Battle.SkipSkillDirection(ENEMY_DIGIMON, 0, 29301)
    end
  end
  if 0.4 < enemy_hp_ratio and Flg.Check("Battle5001") == false and Flg.Check("Battle5109") == false and info.group == GUEST_AEGIOMON and skill_id == 21842 then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-9.31, 1.16, 9.84, -5.47, 3.73, 2.06, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -9.34, 0, 9.04)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 0, 0, -7)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 10.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 1.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -7.71, 0, 28.56)
    Battle.SetModelTargetRotation(GUEST_AEGIOMON, 0, ENEMY_DIGIMON, 0)
    Battle.MessageTalk(1081020020)
    WaitMessage()
    Battle.MessageTalk(1081020021)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Battle.ResetModelRotationY(GUEST_AEGIOMON, 0)
    Flg.Set("Battle5109")
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
  print("####### Battle_Action_End #######")
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if info.enemy_id == 93001 then
    if enemy_last_skill_id == 29301 or enemy_last_skill_id == 29302 then
      Flg.Set("Battle5056")
    elseif enemy_last_skill_id == 70007 then
      Flg.Set("Battle5057")
    end
  end
end

function Battle_Command_End(info)
  print("####### Battle_Command_End #######")
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if enemy_id == 93001 then
    if Flg.Check("Battle5002") == false then
      if enemy_last_skill_id == 44401 then
        print("####### skill call = 44401 SetInterruptCharacter #######")
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
      end
      if enemy_last_skill_id == 70003 then
        print("####### skill call = 70003 SetInterruptCharacter #######")
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
      end
    else
      if enemy_last_skill_id == 44401 then
        print("####### skill call = 44401 SetInterruptCharacter #######")
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
      end
      if enemy_last_skill_id == 70003 and Flg.Check("Battle5206") then
        print("####### skill call = 70003 RemoveBuff #######")
        Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
        Flg.Clear("Battle5206")
      end
      if enemy_last_skill_id == 70001 then
        print("####### skill call = 70001 SetInterruptCharacter #######")
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
      end
    end
  end
  if Flg.Check("Battle5102") == false and Battle.GetLastActionItemID() == 721 then
    print("####### ItemUsed #######")
    if Flg.Check("Battle5110") == false then
      print("####### ItemMissed #######")
      Battle.SetObjectVisible(OBJ_01, true)
      Battle.SetObjectPosition(OBJ_01, -0.41, 0, 1.87)
      Battle.SetObjectRotation(OBJ_01, 0, 270, 0)
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0.85, 0.16, 0.03, -3.35, 1.5, 8.99, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
      BtlPlayAnimation(PLAYER_CHARA, 0, "e008", 0, false)
      Battle.SetModelRotationY(PLAYER_CHARA, 0, 180)
      Battle.SetModelPosition(PLAYER_CHARA, 0, -0.59, 0, 2.95)
      Battle.MessageTalk(1081020022)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Battle.SetObjectVisible(OBJ_01, false)
      Item.Add(721, 1)
      Battle.ResetModelRotationY(PLAYER_CHARA, 0)
      Flg.Set("Battle5119")
    elseif Flg.Check("Battle5110") then
      print("####### ItemUseSuccess #######")
      Battle.SkipSkillDirection(ENEMY_DIGIMON, 0, 0)
      if Flg.Check("Battle5119") then
        Battle.SetObjectVisible(OBJ_01, true)
      else
        Battle.SetObjectVisible(OBJ_01, true)
        Battle.SetObjectPosition(OBJ_01, -0.41, 0, 1.87)
        Battle.SetObjectRotation(OBJ_01, 0, 270, 0)
      end
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0.55, 2.33, 4.44, -3.43, -3.4, -2.44, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      WaitFrame(1)
      Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
      Battle.SetModelPosition(ENEMY_DIGIMON, 0, 27.71, 0, 28.56)
      Battle.SetModelRotationY(PLAYER_CHARA, 0, 180)
      Battle.SetModelPosition(PLAYER_CHARA, 0, -0.59, 0, 2.95)
      BtlPlayAnimation(PLAYER_CHARA, 0, "e202", 0, false)
      Battle.SetCamera(-0.13, 1.12, 3.46, -2.94, -2.79, -5.31, DEFAULT_ANGLE, 90, MODE_QUADRATIC_IN_OUT)
      WaitFrame(20)
      Battle.PlayObjectAnimation(OBJ_01, "e001", true)
      WaitFrame(60)
      Battle.PlayObjectAnimation(OBJ_01, "e002", true)
      WaitFrame(1)
      WaitFrame(60)
      Talk.CloseLetterBox()
      Battle.ResetModelRotationY(PLAYER_CHARA, 0)
      Flg.Set("Battle5102")
    end
  end
end

function Battle_Turn_End(info)
  print("####### Battle_Turn_End #######")
  local stock_num = Battle.GetCPStockNum()
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_hp_ratio = enemy_now_hp / enemy_max_hp
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  local skill_id = Battle.GetLastActionSkillID()
  print("####### enemy_id = ", enemy_id, " skill_id = ", skill_id, " #######")
  print("####### enemy_last_skill_id = ", enemy_last_skill_id, " #######")
  print("####### enemy_now_hp = ", enemy_now_hp, " enemy_hp_ratio = ", enemy_hp_ratio, " #######")
  if Flg.Check("Battle5002") and Flg.Check("Battle5053") and Flg.Check("Battle5055") == false then
    print("####### SetTargetCursor ADD_TARGET #######")
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5055")
  end
  if Flg.Check("Battle5001") == false then
    if 1 < enemy_now_hp then
      if enemy_hp_ratio <= 0.75 and Flg.Check("Battle5115") == false then
        print("####### m210_032 #######")
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m210_032")
        Fade.In(1, Util.SecondFromFrame(30))
        Flg.Set("Battle5115")
      elseif 0.4 < enemy_hp_ratio and enemy_hp_ratio <= 0.6 and Flg.Check("Battle5105") == false then
        print("####### PLN EVENT #######")
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(5.16, 2.98, -2.9, 1.61, 5.74, -11.83, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn02", 0, true)
        Battle.MessageTalk(1081020018)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Flg.Set("Battle5105")
      end
      if enemy_last_skill_id == 49291 and Flg.Check("Battle5106") == false then
        print("####### PLN EVENT #######")
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(5.16, 2.98, -2.9, 1.61, 5.74, -11.83, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn02", 0, true)
        Battle.MessageTalk(1081020019)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208003)
        Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
        Flg.Set("Battle5106")
      end
      if enemy_hp_ratio <= 0.5 and Flg.Check("Battle5116") == false then
        print("####### m210_033 #######")
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m210_033")
        Fade.In(1, Util.SecondFromFrame(30))
        Flg.Set("Battle5116")
      end
      if enemy_hp_ratio <= 0.3 and Flg.Check("Battle5117") == false then
        print("####### m210_034 #######")
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m210_034")
        Fade.In(1, Util.SecondFromFrame(30))
        Flg.Set("Battle5117")
      end
    end
    if enemy_now_hp == 1 and Flg.Check("Battle5001") == false then
      print("####### PHASE1 END m210_040 #######")
      Battle.ClearTarget()
      Battle.CloseUI()
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
      Battle.ExchangeMember(ENEMY_DIGIMON, 0)
      Battle.ReadyNextSceneForVista()
      Execute("m210_040")
      Flg.Clear("Battle5011")
      Flg.Clear("Battle5012")
      Flg.Clear("Battle5013")
      Flg.Clear("Battle5014")
      Flg.Clear("Battle5015")
      Flg.Clear("Battle5016")
      Flg.Clear("Battle5017")
      Flg.Set("Battle5001")
      Battle.SetOverwriteCamera("camera_big_Tita02")
      Fade.AllIn(0, Util.SecondFromFrame(FADE_TIME))
    end
  else
    if Flg.Check("Battle5101") == false and (info.group == PLAYER_DIGIMON or info.group == GUEST_AEGIOMON) and 1 <= enemy_now_hp and enemy_now_hp / enemy_max_hp <= 0.4 and Battle.IsBreakCPCharge() == false then
      print("####### m210_050 #######")
      Battle.CloseUI()
      Battle.ReadyNextSceneForVista()
      Execute("m210_050")
      Battle.ResetFormation(false)
      Fade.AllIn(0, Util.SecondFromFrame(FADE_TIME))
      Flg.Set("Battle5101")
    end
    if Flg.Check("Battle5056") and Flg.Check("Battle5002") == false then
      if Flg.Check("Battle5110") == false then
        print("####### PLN EVENT CPSkill 1 #######")
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(-2.12, 1.27, 10.23, -2.3, 2.4, 0.29, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.SetModelPosition(GUEST_AEGIOMON, 0, -1.71, 0, 8.6)
        Battle.SetModelPosition(PLAYER_DIGIMON, 0, 10.02, 0, 28.56)
        Battle.SetModelPosition(PLAYER_DIGIMON, 1, 1.16, 0, 27)
        Battle.SetModelPosition(PLAYER_DIGIMON, 2, -7.71, 0, 28.56)
        Battle.SetModelPosition(PLAYER_CHARA, 0, -2.49, 0, 9.24)
        slot = Sound.PlaySE(500006, 100, false)
        WaitFrame(35)
        Sound.StopSE(slot, 0)
        BtlPlayAnimation(PLAYER_CHARA, 0, "e503", 10, true)
        Battle.SetLoopFrameAnimation(PLAYER_CHARA, 0, "e503", 50, 126)
        Battle.SetModelTargetRotation(PLAYER_CHARA, 0, ENEMY_DIGIMON, 0)
        WaitFrame(30)
        Battle.MessageTalk(1081020001)
        WaitMessage()
        Battle.MessageTalk(1081020002)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Battle.ResetModelRotationY(PLAYER_CHARA, 0)
        Flg.Set("Battle5110")
      elseif flgcountcp == 2 then
        if Flg.Check("Battle5111") == false and Flg.Check("Battle5102") == false then
          print("####### PLN EVENT CPSkill 2 #######")
          Talk.OpenLetterBox()
          Battle.CloseUI()
          Battle.SetCamera(-2.12, 1.27, 10.23, -2.3, 2.4, 0.29, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
          Battle.SetModelPosition(GUEST_AEGIOMON, 0, -1.71, 0, 8.6)
          Battle.SetModelPosition(PLAYER_DIGIMON, 0, 10.02, 0, 28.56)
          Battle.SetModelPosition(PLAYER_DIGIMON, 1, 1.16, 0, 27)
          Battle.SetModelPosition(PLAYER_DIGIMON, 2, -7.71, 0, 28.56)
          Battle.SetModelPosition(PLAYER_CHARA, 0, -2.49, 0, 9.24)
          slot = Sound.PlaySE(500006, 100, false)
          WaitFrame(35)
          Sound.StopSE(slot, 0)
          BtlPlayAnimation(PLAYER_CHARA, 0, "e503", 10, true)
          Battle.SetLoopFrameAnimation(PLAYER_CHARA, 0, "e503", 50, 126)
          Battle.SetModelTargetRotation(PLAYER_CHARA, 0, ENEMY_DIGIMON, 0)
          WaitFrame(30)
          Battle.MessageTalk(1081020003)
          WaitMessage()
          Battle.MessageTalk(1081020004)
          WaitMessage()
          Battle.MessageTalk(1081020005)
          WaitMessage()
          Battle.MessageTalk(1081020009)
          WaitMessage()
          Battle.SetModelTargetRotation(ENEMY_DIGIMON, 0, PLAYER_CHARA, 0)
          Battle.MessageTalk(1081020010)
          WaitMessage()
          Talk.CloseLetterBox()
          Battle.CloseTalk()
          while not Battle.IsCloseTalk() do
            WaitFrame(1)
          end
          Battle.ResetModelRotationY(PLAYER_CHARA, 0)
          Battle.ResetModelRotationY(ENEMY_DIGIMON, 0)
          Flg.Set("Battle5111")
        end
      elseif flgcountcp >= 3 and Flg.Check("Battle5102") == false then
        print("####### PLN EVENT CPSkill 3 #######")
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(-2.12, 1.27, 10.23, -2.3, 2.4, 0.29, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.SetModelPosition(GUEST_AEGIOMON, 0, -1.71, 0, 8.6)
        Battle.SetModelPosition(PLAYER_CHARA, 0, -2.49, 0, 9.24)
        Battle.SetModelPosition(PLAYER_DIGIMON, 0, 10.02, 0, 28.56)
        Battle.SetModelPosition(PLAYER_DIGIMON, 1, 1.16, 0, 27)
        Battle.SetModelPosition(PLAYER_DIGIMON, 2, -7.71, 0, 28.56)
        slot = Sound.PlaySE(500006, 100, false)
        WaitFrame(35)
        Sound.StopSE(slot, 0)
        BtlPlayAnimation(PLAYER_CHARA, 0, "e503", 0, true)
        Battle.SetLoopFrameAnimation(PLAYER_CHARA, 0, "e503", 50, 126)
        Battle.SetModelTargetRotation(PLAYER_CHARA, 0, ENEMY_DIGIMON, 0)
        Battle.SetModelTargetRotation(ENEMY_DIGIMON, 0, PLAYER_CHARA, 0)
        WaitFrame(30)
        Battle.MessageTalk(1081020010)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Battle.ResetModelRotationY(PLAYER_CHARA, 0)
        Battle.ResetModelRotationY(ENEMY_DIGIMON, 0)
      end
    end
    if Flg.Check("Battle5108") and Flg.Check("Battle5002") == false then
      print("####### m210_046 #######")
      Battle.CloseUI()
      Battle.ClearCPCharge()
      Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_IDLE, "bn01")
      Battle.ReadyNextSceneForVista()
      Execute("m210_046")
      Battle.AddEnemyCP(1200)
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
      Flg.Clear("Battle5055")
      Flg.Clear("Battle5201")
      Flg.Clear("Battle5202")
      Flg.Clear("Battle5203")
      Flg.Clear("Battle5204")
      Flg.Clear("Battle5205")
      Flg.Clear("Battle5206")
      Flg.Clear("Battle5207")
      Flg.Clear("Battle5208")
      Flg.Clear("Battle5209")
      Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, ENEMY_DIGIMON, 0)
      Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
      Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
      Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, ENEMY_DIGIMON, 0)
      Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_PLAYER_SIDE_TOTAL_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30305, -1)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593001)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593003)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593004)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593005)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593006)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593007)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
      Round = 0
      CP_Round = 0
      Battle.AddBuff(ENEMY_DIGIMON, 0, 593008)
      Flg.Set("Battle5002")
    end
  end
  local round_count = info.round
  if Flg.Check("Battle5001") and Flg.Check("Battle5103") then
    if Flg.Check("Battle5002") == false then
      if CP_Round >= 4 then
        Flg.Set("Battle5012")
      end
    elseif 3 <= CP_Round then
      Flg.Set("Battle5012")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 800) then
      Flg.Set("Battle5013")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
      Flg.Set("Battle5014")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 1500) then
      Flg.Set("Battle5015")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 3000) then
      Flg.Set("Battle5016")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_PLAYER_SIDE_TOTAL_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 3000) then
      Flg.Set("Battle5017")
    end
    if 2 <= Flgcount() and Flg.Check("Battle5051") == false then
      print("===== CHARGE PRESTART =====")
      Flg.Set("Battle5051")
    end
  end
  print("stock_num:", stock_num)
  if Flg.Check("Battle5001") == false or Flg.Check("Battle5103") then
    if Flg.Check("Battle5053") == false then
      print("####### Extra Turn #######")
      if stock_num == 1 then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30162)
      elseif stock_num == 2 then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 34021)
      elseif stock_num == 3 and Flg.Check("Battle5001") == false then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
      elseif stock_num == 3 and Flg.Check("Battle5001") and round_count % 3 == 1 then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30283)
      elseif stock_num == 3 and Flg.Check("Battle5001") and round_count % 3 == 2 then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30163)
      elseif stock_num == 3 and Flg.Check("Battle5001") and round_count % 3 == 0 then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 44402)
      elseif stock_num == 4 and round_count % 2 == 0 then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
      elseif stock_num == 4 and round_count % 2 == 1 then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32201)
      elseif 5 <= stock_num then
        Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30305)
      end
    end
    if stock_num == 0 or Flg.Check("Battle5053") then
      print("####### Reset Extra Turn #######")
      Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    end
    if 2 <= stock_num and Flg.Check("Battle5202") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 593007)
      Flg.Set("Battle5202")
    end
    if 5 <= stock_num and Flg.Check("Battle5205") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 593005)
      Flg.Set("Battle5205")
    end
    if Flg.Check("Battle5001") == false then
      if 1 <= stock_num and Flg.Check("Battle5201") == false then
        Battle.AddBuff(ENEMY_DIGIMON, 0, 593001)
        Flg.Set("Battle5201")
      end
      if 3 <= stock_num and Flg.Check("Battle5203") == false then
        Battle.AddBuff(ENEMY_DIGIMON, 0, 593003)
        Flg.Set("Battle5203")
      end
      if 4 <= stock_num and Flg.Check("Battle5204") == false then
        Battle.AddBuff(ENEMY_DIGIMON, 0, 593004)
        Flg.Set("Battle5204")
      end
    else
      if 1 <= stock_num and Flg.Check("Battle5206") == false and Flg.Check("Battle5051") == false then
        Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
        Flg.Set("Battle5206")
      end
      if 3 <= stock_num and Flg.Check("Battle5208") == false then
        Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30305, 30306)
        Flg.Set("Battle5208")
      end
      if 4 <= stock_num and Flg.Check("Battle5209") == false then
        Battle.AddBuff(ENEMY_DIGIMON, 0, 593006)
        Flg.Set("Battle5209")
      end
    end
  end
  if Flg.Check("Battle5056") then
    print("####### CPSkill INITIALIZE #######")
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
    Flg.Clear("Battle5056")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_PLAYER_SIDE_TOTAL_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Round = 0
    CP_Round = 0
    Battle.StopEffectScript(EFF_01, 0)
  end
  if Flg.Check("Battle5057") then
    print("####### ClearCPCharge #######")
    Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_IDLE, "bn01")
    Flg.Clear("Battle5057")
  end
  if Battle.IsBreakCPCharge() then
    print("####### IsBreakCPCharge = true #######")
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
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5300")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5204")
    Flg.Clear("Battle5205")
    Flg.Clear("Battle5206")
    Flg.Clear("Battle5207")
    Flg.Clear("Battle5208")
    Flg.Clear("Battle5209")
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.ClearAccomplishCondition(BATTLE_CONDITION_TYPE_PLAYER_SIDE_TOTAL_DAMAGE_VALUE_OVER, ENEMY_DIGIMON, 0)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_IDLE, "bn02")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30305, -1)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593001)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593003)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593004)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593005)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593006)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 593007)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
    Round = 0
    CP_Round = 0
    Battle.ClearCPCharge()
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

function FlgcountCp()
  if Flg.Check("Battle5054") then
    flgcountcp = flgcountcp + 1
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_07_069")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(915, DIGIMON_GRASP_FLAG_SCAN)
  Battle.SetObjectVisible(OBJ_01, false)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m210_060")
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m210_070")
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
