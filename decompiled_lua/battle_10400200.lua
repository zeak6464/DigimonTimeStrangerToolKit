require("include_battle")
Round = 0
OBJ_01 = 1
EFF_01 = 1
EFF_02 = 2
EFF_03 = 3
EFF_04 = 4
EFF_05 = 5
EFF_06 = 6
BOSS_ID = 88501
Enemy_Lv = 20
extra_turn_unit_index = nil

function Battle_Before_Setup()
  print("=========== Battle_Before_Setup ===========")
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadObject(OBJ_01, "d0505hatch00")
  Battle.LoadObjectAnimation(OBJ_01, "e001")
  Battle.LoadObjectAnimation(OBJ_01, "e002")
  Battle.LoadEffectScript(EFF_01, "ef_b_bos_105")
  Battle.LoadEffectScript(EFF_02, "ef_b_bos_105")
  Battle.LoadEffectScript(EFF_03, "ef_b_bos_106")
  Battle.LoadEffectScript(EFF_04, "ef_b_bos_106")
  Battle.LoadEffectScript(EFF_05, "ef_b_bos_106")
  Battle.LoadEffectScript(EFF_06, "ef_b_bos_106")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  print("=========== Battle_After_Setup ===========")
  Battle.LoadAnimation(GUEST_AEGIOMON, 0, "e007")
  Battle.SetupAnalyzeEffect(ENEMY_DIGIMON, 0)
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_IDLE, "bn01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_TIRED, "bn02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_ATTACK, "ba02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_ATTACK02, "ba02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_ATTACK03, "ba02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_COMMON_SKILL, "ba01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_DAMAGE, "bd01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_DAMAGE02, "bd01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_DAMAGE03, "bd01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_DOWN, "bd02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_UP, "bd03")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_GUARD, "bg01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bn03")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 1, "changeout01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 2, "changeout01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 1, "bn02")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 2, "bn02")
  Battle.AddLoadMotion_ExchangeMember(ENEMY_DIGIMON, "bn02")
  Battle.LoadCameraAnimation("Cam_ArmBig_changein01")
  Battle.LoadCameraAnimation("Cam_ArmBig_changeout01")
  Battle.LoadCameraAnimation("Cam_ArmSmall_changein01")
  Battle.LoadCameraAnimation("Cam_ArmSmall_changeout01")
  Battle.AddLoadMotion_ExchangeMember(ENEMY_DIGIMON, "changein01")
  Battle.AddLoadMotion_ExchangeMember(ENEMY_DIGIMON, "changein02")
  Battle.AddLoadMotion_ExchangeMember(ENEMY_DIGIMON, "changeout01")
  Battle.AddLoadMotion_ExchangeMember(ENEMY_DIGIMON, "changeout02")
  Enemy_Lv = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  print("####### Enemy_Lv = ", Enemy_Lv, " #######")
  SetEndrollMember(10400200)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  print("=========== Battle_Opening ===========")
  Fade.In(0, Util.SecondFromFrame(30))
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.SetObjectPosition(OBJ_01, 0, 11.3, -19.72)
  if Flg.Check("Battle5499") then
    Sound.PlayBGM(932, 0.5)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  print("=========== Battle_Start ===========")
  Battle.SetIsAudienceTarget(885, false)
  Flg.Set("Battle5130")
end

function Battle_Round_Start(info)
  print("=========== Battle_Round_Start Round = ", Round, " ===========")
  if Flg.Check("Battle5053") then
    Round = Round + 1
  else
    extra_turn_unit_index = nil
  end
end

function Battle_Turn_Start(info)
  print("=========== Battle_Turn_Start digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " group = ", info.group, " ===========")
  if Flg.Check("Battle5108") == false then
    if Flg.Check("Battle5110") then
      EntranceEvent_ArmBig()
      Flg.Set("Battle5108")
      Flg.Clear("Battle5110")
      Flg.Clear("Battle5020")
    elseif Flg.Check("Battle5111") then
      EntranceEvent_ArmSmall()
      Flg.Set("Battle5108")
      Flg.Clear("Battle5111")
      Flg.Clear("Battle5020")
    end
  end
  if Flg.Check("Battle5002") and Flg.Check("Battle5052") == false then
    EventPlay_Phase2_Clear()
    Battle.SetCameraMove(0, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_PLAYER_ALL, PLAYER_DIGIMON, -1)
    WaitFrame(30)
    Battle.PlayAnalyzeEffect()
    WaitFrame(40)
    Flg.Set("Battle5052")
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 41786)
  end
end

function Battle_Command_Start(info)
  print("=========== Battle_Command_Start ===========")
  local enemy_id = info.enemy_id
  print("##### enemy last skill id :", Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0), " #####")
  if enemy_id == BOSS_ID then
    Battle.AddEnemyCP(400)
    if Flg.Check("Battle5002") then
      if Flg.Check("Battle5053") == false then
        print("##### NOT CPCharge #####")
        if Flg.Check("Battle5020") then
          print("##### CommandStart ALL DESTROY #####")
          local stock_num = Battle.GetCPStockNum()
          if stock_num <= 1 then
            print("##### CPCharge SETUP 3R #####")
            Battle.SetupCPCharge(41786, 93501, ENEMY_DIGIMON, 0, "FP01", 3)
            Flg.Set("Battle5023")
          elseif stock_num == 2 then
            print("##### CPCharge SETUP 2R #####")
            Battle.SetupCPCharge(41786, 93501, ENEMY_DIGIMON, 0, "FP01", 2)
            Flg.Set("Battle5022")
          elseif 3 <= stock_num then
            print("##### CPCharge SETUP 1R #####")
            Battle.SetupCPCharge(41786, 93501, ENEMY_DIGIMON, 0, "FP01", 1)
            Flg.Set("Battle5021")
          end
          Round = 0
          Flg.Set("Battle5053")
          if Flg.Check("Battle5102") == false then
            EventPlay_FirstCPCharge()
            Flg.Set("Battle5102")
          else
            EventPlay_Phase3_CPCharge()
          end
        end
      else
        local is_Complete_charge = false
        if Flg.Check("Battle5023") and Round == 3 then
          is_Complete_charge = true
        elseif Flg.Check("Battle5022") and Round == 2 then
          is_Complete_charge = true
        elseif Flg.Check("Battle5021") and Round == 1 then
          is_Complete_charge = true
        end
        print("##### is_Complete_charge = ", is_Complete_charge, " #####")
        if is_Complete_charge then
          print("##### CreateAttributeArm #####")
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 41781)
          CreateAttributeArm()
        end
      end
    end
  end
  print("Round:", Round)
  if Flg.Check("Battle5053") == false then
    if Battle.IsBuff(ENEMY_DIGIMON, 1, 203100, BUFF_CHECK_OR_WITHOUT_ID) or Battle.IsBuff(ENEMY_DIGIMON, 3, 203100, BUFF_CHECK_OR_WITHOUT_ID) then
      if info.group == 1 then
        if info.index == 1 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 50005)
        elseif info.index == 3 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 3, 50005)
        end
      end
    elseif (Battle.IsBuff(ENEMY_DIGIMON, 2, 203100, BUFF_CHECK_OR_WITHOUT_ID) or Battle.IsBuff(ENEMY_DIGIMON, 4, 203100, BUFF_CHECK_OR_WITHOUT_ID)) and info.group == 1 then
      if info.index == 2 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 50003)
      elseif info.index == 4 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 4, 50003)
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
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
  print("=========== Battle_Command_End ===========")
  local boss_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if 0 < boss_hp and Battle.IsBreakCPCharge() then
    print("##### IsBreakCPCharge = true #####")
    math.randomseed(os.time())
    local random = math.random(1, 2)
    if random == 1 then
      print("##### BIG ARM PrepareExchange #####")
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 80101, Enemy_Lv)
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 80001, Enemy_Lv)
      Flg.Set("Battle5110")
    else
      print("##### SMALL ARM PrepareExchange #####")
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 81001, Enemy_Lv)
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 80901, Enemy_Lv)
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 3, 81001, Enemy_Lv)
      Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 4, 80901, Enemy_Lv)
      Flg.Set("Battle5111")
    end
    EventPlay_CPChargeBreak()
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 41780)
  end
  local arm1_hp = Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP)
  local arm2_hp = Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP)
  local arm3_hp = Battle.GetStatus(ENEMY_DIGIMON, 3, STATUS_TYPE_HP)
  local arm4_hp = Battle.GetStatus(ENEMY_DIGIMON, 4, STATUS_TYPE_HP)
  print("##### arm1_hp = ", arm1_hp, " #####")
  print("##### arm2_hp = ", arm2_hp, " #####")
  print("##### arm3_hp = ", arm3_hp, " #####")
  print("##### arm4_hp = ", arm4_hp, " #####")
  if Flg.Check("Battle5001") == false and arm1_hp == 0 and arm2_hp == 0 then
    print("##### PHASE1 SMALL ARM PrepareExchange #####")
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 81001, Enemy_Lv)
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 80901, Enemy_Lv)
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 3, 81001, Enemy_Lv)
    Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 4, 80901, Enemy_Lv)
  end
end

function Battle_Turn_End(info)
  print("=========== Battle_Turn_End digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " ===========")
  print("##### group = ", info.group, " index = ", info.index, " #####")
  local enemy_id = info.enemy_id
  local last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  print("##### last_skill_id = ", last_skill_id, " #####")
  local last_skill_id1 = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 1)
  local last_skill_id2 = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 2)
  local last_skill_id3 = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 3)
  local last_skill_id4 = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 4)
  print("##### arm1_hp_last_skill_id = ", last_skill_id1, " #####")
  print("##### arm2_hp_last_skill_id = ", last_skill_id2, " #####")
  print("##### arm3_hp_last_skill_id = ", last_skill_id3, " #####")
  print("##### arm4_hp_last_skill_id = ", last_skill_id4, " #####")
  print("======================================================")
  local skill_id = Battle.GetLastActionSkillID()
  print("##### skill_id = ", skill_id, " #####")
  print("======================================================")
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local arm1_hp = Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP)
  local arm2_hp = Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP)
  local arm3_hp = Battle.GetStatus(ENEMY_DIGIMON, 3, STATUS_TYPE_HP)
  local arm4_hp = Battle.GetStatus(ENEMY_DIGIMON, 4, STATUS_TYPE_HP)
  print("##### enemy_now_hp = ", enemy_now_hp, " #####")
  print("##### arm1_hp = ", arm1_hp, " #####")
  print("##### arm2_hp = ", arm2_hp, " #####")
  print("##### arm3_hp = ", arm3_hp, " #####")
  print("##### arm4_hp = ", arm4_hp, " #####")
  if Flg.Check("Battle5053") == false then
    if Flg.Check("Battle5130") then
      if arm1_hp == 0 and Flg.Check("Battle5121") == false then
        print("##### KEMURI BIG RIGHT ARM #####")
        Battle.AttatchEffectScriptToModelJoint(EFF_01, ENEMY_DIGIMON, 1, "J_hand")
        Battle.SetEffectScriptLoop(EFF_01, true)
        Battle.PlayEffectScript(EFF_01, 0.1)
        Battle.MotionNameOverwrite(ENEMY_DIGIMON, 1, MOTION_TYPE_IDLE, "bn02")
        Flg.Set("Battle5121")
      end
      if arm2_hp == 0 and Flg.Check("Battle5122") == false then
        print("##### KEMURI BIG LEFT ARM #####")
        Battle.AttatchEffectScriptToModelJoint(EFF_02, ENEMY_DIGIMON, 2, "J_hand")
        Battle.SetEffectScriptLoop(EFF_02, true)
        Battle.PlayEffectScript(EFF_02, 0.1)
        Battle.MotionNameOverwrite(ENEMY_DIGIMON, 2, MOTION_TYPE_IDLE, "bn02")
        Flg.Set("Battle5122")
      end
    elseif Flg.Check("Battle5131") then
      if arm1_hp == 0 and Flg.Check("Battle5121") == false then
        print("##### KEMURI SMALL RIGHT ARM1 #####")
        Battle.AttatchEffectScriptToModelJoint(EFF_03, ENEMY_DIGIMON, 1, "J_hand")
        Battle.SetEffectScriptLoop(EFF_03, true)
        Battle.PlayEffectScript(EFF_03, 0.1)
        Battle.MotionNameOverwrite(ENEMY_DIGIMON, 1, MOTION_TYPE_IDLE, "bn02")
        Flg.Set("Battle5121")
      end
      if arm2_hp == 0 and Flg.Check("Battle5122") == false then
        print("##### KEMURI SMALL LEFT ARM1 #####")
        Battle.AttatchEffectScriptToModelJoint(EFF_04, ENEMY_DIGIMON, 2, "J_hand")
        Battle.SetEffectScriptLoop(EFF_04, true)
        Battle.PlayEffectScript(EFF_04, 0.1)
        Battle.MotionNameOverwrite(ENEMY_DIGIMON, 2, MOTION_TYPE_IDLE, "bn02")
        Flg.Set("Battle5122")
      end
      if arm3_hp == 0 and Flg.Check("Battle5123") == false then
        print("##### KEMURI SMALL RIGHT ARM2 #####")
        Battle.AttatchEffectScriptToModelJoint(EFF_05, ENEMY_DIGIMON, 3, "J_hand")
        Battle.SetEffectScriptLoop(EFF_05, true)
        Battle.PlayEffectScript(EFF_05, 0.1)
        Battle.MotionNameOverwrite(ENEMY_DIGIMON, 3, MOTION_TYPE_IDLE, "bn02")
        Flg.Set("Battle5123")
      end
      if arm4_hp == 0 and Flg.Check("Battle5124") == false then
        print("##### KEMURI SMALL LEFT ARM2 #####")
        Battle.AttatchEffectScriptToModelJoint(EFF_06, ENEMY_DIGIMON, 4, "J_hand")
        Battle.SetEffectScriptLoop(EFF_06, true)
        Battle.PlayEffectScript(EFF_06, 0.1)
        Battle.MotionNameOverwrite(ENEMY_DIGIMON, 4, MOTION_TYPE_IDLE, "bn02")
        Flg.Set("Battle5124")
      end
    end
  end
  local stock_num = Battle.GetCPStockNum()
  local digimon1_id = Battle.GetDigimonId(ENEMY_DIGIMON, 1)
  local digimon2_id = Battle.GetDigimonId(ENEMY_DIGIMON, 2)
  local digimon3_id = Battle.GetDigimonId(ENEMY_DIGIMON, 3)
  local digimon4_id = Battle.GetDigimonId(ENEMY_DIGIMON, 4)
  if Flg.Check("Battle5053") == false and 1 <= stock_num then
    LotteryExtraTurnUnit()
  end
  if stock_num == 0 or Flg.Check("Battle5053") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if Flg.Check("Battle5001") == false then
    if arm1_hp == 0 and arm2_hp == 0 then
      print("##### PHASE1 CLEAR #####")
      EventPlay_Phase1_Clear()
      ExitEvent_ArmBig()
      Battle.ExchangeMember(ENEMY_DIGIMON, 1)
      Battle.ExchangeMember(ENEMY_DIGIMON, 2)
      Battle.ExchangeMember(ENEMY_DIGIMON, 3)
      Battle.ExchangeMember(ENEMY_DIGIMON, 4)
      Flg.Clear("Battle5108")
      Flg.Set("Battle5111")
      Flg.Set("Battle5001")
      BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
    end
  elseif Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    if arm1_hp == 0 and arm2_hp == 0 and arm3_hp == 0 and arm4_hp == 0 then
      print("##### PHASE2 CLEAR #####")
      ExitEvent_ArmSmall()
      Flg.Set("Battle5002")
      Flg.Set("Battle5020")
      BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
    end
  elseif Flg.Check("Battle5002") and 0 < enemy_now_hp then
    if Flg.Check("Battle5053") == false then
      if Flg.Check("Battle5150") then
        if arm1_hp == 0 and arm2_hp == 0 then
          print("##### PHASE3 BIG ARM ALL DESTROY #####")
          EventPlay_BeforeCPCharge()
          ExitEvent_ArmBig()
          Flg.Clear("Battle5150")
          Flg.Clear("Battle5151")
          Flg.Clear("Battle5152")
          Flg.Set("Battle5020")
          BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
        end
      elseif (Flg.Check("Battle5151") or Flg.Check("Battle5152")) and arm1_hp == 0 and arm2_hp == 0 and arm3_hp == 0 and arm4_hp == 0 then
        print("##### PHASE3 SMALL ARM ALL DESTROY #####")
        EventPlay_BeforeCPCharge()
        ExitEvent_ArmSmall()
        Flg.Clear("Battle5150")
        Flg.Clear("Battle5151")
        Flg.Clear("Battle5152")
        Flg.Set("Battle5020")
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
      end
    end
    if Battle.IsBreakCPCharge() then
      print("##### IsBreakCPCharge = true #####")
      if Flg.Check("Battle5110") then
        print("##### Exchange BIG ARM #####")
        Battle.ExchangeMember(ENEMY_DIGIMON, 1)
        Battle.ExchangeMember(ENEMY_DIGIMON, 2)
        Flg.Set("Battle5150")
      elseif Flg.Check("Battle5111") then
        print("##### Exchange SMALL ARM #####")
        Battle.ExchangeMember(ENEMY_DIGIMON, 1)
        Battle.ExchangeMember(ENEMY_DIGIMON, 2)
        Battle.ExchangeMember(ENEMY_DIGIMON, 3)
        Battle.ExchangeMember(ENEMY_DIGIMON, 4)
        Flg.Set("Battle5151")
      end
      Flg.Clear("Battle5053")
      Flg.Clear("Battle5021")
      Flg.Clear("Battle5022")
      Flg.Clear("Battle5023")
      Flg.Clear("Battle5201")
      Flg.Clear("Battle5202")
      Flg.Clear("Battle5203")
      Flg.Clear("Battle5204")
      Flg.Clear("Battle5205")
      Flg.Clear("Battle5300")
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 126020)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 128030)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 187100)
      Flg.Clear("Battle5108")
      Battle.ClearCPCharge()
    end
    if enemy_id == BOSS_ID and last_skill_id == 41781 then
      print("##### Exchange SMALL ARM #####")
      AddTarget_nobreakHP()
      Battle.ExchangeMember(ENEMY_DIGIMON, 1)
      Battle.ExchangeMember(ENEMY_DIGIMON, 2)
      Battle.ExchangeMember(ENEMY_DIGIMON, 3)
      Battle.ExchangeMember(ENEMY_DIGIMON, 4)
      Flg.Clear("Battle5021")
      Flg.Clear("Battle5022")
      Flg.Clear("Battle5023")
      Flg.Clear("Battle5053")
      Flg.Clear("Battle5108")
      Flg.Set("Battle5152")
      Flg.Clear("Battle5300")
      EventPlay_FirstCreateAttributeArm()
      Battle.ClearCPCharge()
    end
  end
  local stock_num = Battle.GetCPStockNum()
  if 1 <= stock_num and Flg.Check("Battle5201") == false and Flg.Check("Battle5053") then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 126020)
    Flg.Set("Battle5201")
  end
  if not (2 <= stock_num) or Flg.Check("Battle5202") == false then
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false and Flg.Check("Battle5053") == false and (Flg.Check("Battle5130") or Flg.Check("Battle5131")) then
    Battle.AddBuff(ENEMY_DIGIMON, 1, 125020)
    Battle.AddBuff(ENEMY_DIGIMON, 2, 126020)
    Battle.AddBuff(ENEMY_DIGIMON, 3, 127020)
    Battle.AddBuff(ENEMY_DIGIMON, 4, 128020)
    Flg.Set("Battle5203")
  end
  if 4 <= stock_num and Flg.Check("Battle5204") == false and Flg.Check("Battle5053") then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 128030)
    Flg.Set("Battle5204")
  end
  if 5 <= stock_num and Flg.Check("Battle5205") == false and Flg.Check("Battle5053") then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 187100)
    Flg.Set("Battle5205")
  end
end

function IsCheckTarget(area, index, region_flag_type)
  if Battle.GetDigimonId(area, index) > 0 and 0 < Battle.GetStatus(area, index, STATUS_TYPE_HP) and Battle.IsBelong(area, index, region_flag_type) == true then
    return true
  end
  return false
end

function CreateAttributeArm()
  local resistance_element = Battle.GetPartyWeaknessDataResistanceElement()
  local attack_element = Battle.GetPartyWeaknessDataAttackElement()
  local unfavorable_type = Battle.GetPartyWeaknessDataUnfavorableType()
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 81001, Enemy_Lv)
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 2, 80901, Enemy_Lv)
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 3, 81001, Enemy_Lv)
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 4, 80901, Enemy_Lv)
  SetDigimonType(unfavorable_type)
  SetColorAndBuff(resistance_element)
  SetUpgradeSkill(attack_element)
  Flg.Set("Battle5111")
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_04_121")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(178, DIGIMON_GRASP_FLAG_SCAN)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m150_150")
end

function SetDigimonType(digimon_type)
  Battle.SetExchangeDigimonType(ENEMY_DIGIMON, 1, digimon_type)
  Battle.SetExchangeDigimonType(ENEMY_DIGIMON, 2, digimon_type)
  Battle.SetExchangeDigimonType(ENEMY_DIGIMON, 3, digimon_type)
  Battle.SetExchangeDigimonType(ENEMY_DIGIMON, 4, digimon_type)
end

function SetColor(r, g, b)
  Battle.SetExchangeModelColor(ENEMY_DIGIMON, 1, r, g, b)
  Battle.SetExchangeModelColor(ENEMY_DIGIMON, 2, r, g, b)
  Battle.SetExchangeModelColor(ENEMY_DIGIMON, 3, r, g, b)
  Battle.SetExchangeModelColor(ENEMY_DIGIMON, 4, r, g, b)
end

function SetBuff(buff_id)
  Battle.SetExchangeAddBuff(ENEMY_DIGIMON, 1, buff_id)
  Battle.SetExchangeAddBuff(ENEMY_DIGIMON, 2, buff_id)
  Battle.SetExchangeAddBuff(ENEMY_DIGIMON, 3, buff_id)
  Battle.SetExchangeAddBuff(ENEMY_DIGIMON, 4, buff_id)
end

function SetColorAndBuff(resistance_element)
  print("##### SetColorAndBuff = ", resistance_element, " #####")
  if resistance_element == DIGIMON_ELEMENT_NONE then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_NONE #####")
    SetBuff(141000)
    SetColor(0.61, 0.61, 0.61)
  elseif resistance_element == DIGIMON_ELEMENT_FIRE then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_FIRE #####")
    SetBuff(142000)
    SetColor(1, 0.25, 0)
  elseif resistance_element == DIGIMON_ELEMENT_ICE then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_ICE #####")
    SetBuff(143000)
    SetColor(0.5, 0.75, 1)
  elseif resistance_element == DIGIMON_ELEMENT_PLANTS then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_PLANTS #####")
    SetBuff(144000)
    SetColor(0.39, 0.78, 0)
  elseif resistance_element == DIGIMON_ELEMENT_WATER then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_WATER #####")
    SetBuff(145000)
    SetColor(0, 0.65, 1)
  elseif resistance_element == DIGIMON_ELEMENT_ELECTRIC then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_ELECTRIC #####")
    SetBuff(146000)
    SetColor(1, 0.9, 0)
  elseif resistance_element == DIGIMON_ELEMENT_STEEL then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_STEEL #####")
    SetBuff(147000)
    SetColor(0.78, 0.78, 0.78)
  elseif resistance_element == DIGIMON_ELEMENT_WIND then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_WIND #####")
    SetBuff(148000)
    SetColor(0.71, 1, 1)
  elseif resistance_element == DIGIMON_ELEMENT_EARTH then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_EARTH #####")
    SetBuff(149000)
    SetColor(0.71, 0.5, 0.04)
  elseif resistance_element == DIGIMON_ELEMENT_LIGHT then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_LIGHT #####")
    SetBuff(150000)
    SetColor(1, 0.98, 0.9)
  elseif resistance_element == DIGIMON_ELEMENT_DARK then
    print("##### SetColorAndBuff = DIGIMON_ELEMENT_DARK #####")
    SetBuff(151000)
    SetColor(0.35, 0.24, 0.78)
  end
end

function SetUpgradeSkill(attack_element)
  if attack_element == DIGIMON_ELEMENT_NONE then
    print("##### attack_element = DIGIMON_ELEMENT_NONE #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50007)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50008)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50009)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50010)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50007)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50008)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50009)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50010)
  elseif attack_element == DIGIMON_ELEMENT_FIRE then
    print("##### attack_element = DIGIMON_ELEMENT_FIRE #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50011)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50012)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50013)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50014)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50011)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50012)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50013)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50014)
  elseif attack_element == DIGIMON_ELEMENT_ICE then
    print("##### attack_element = DIGIMON_ELEMENT_ICE #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50015)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50016)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50017)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50018)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50015)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50016)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50017)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50018)
  elseif attack_element == DIGIMON_ELEMENT_PLANTS then
    print("##### attack_element = DIGIMON_ELEMENT_PLANTS #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50019)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50020)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50021)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50022)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50019)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50020)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50021)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50022)
  elseif attack_element == DIGIMON_ELEMENT_WATER then
    print("##### attack_element = DIGIMON_ELEMENT_WATER #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50023)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50024)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50025)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50026)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50023)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50024)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50025)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50026)
  elseif attack_element == DIGIMON_ELEMENT_ELECTRIC then
    print("##### attack_element = DIGIMON_ELEMENT_ELECTRIC #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50027)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50028)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50029)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50030)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50027)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50028)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50029)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50030)
  elseif attack_element == DIGIMON_ELEMENT_STEEL then
    print("##### attack_element = DIGIMON_ELEMENT_STEEL #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50031)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50032)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50033)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50034)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50031)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50032)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50033)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50034)
  elseif attack_element == DIGIMON_ELEMENT_WIND then
    print("##### attack_element = DIGIMON_ELEMENT_WIND #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50035)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50036)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50037)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50038)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50035)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50036)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50037)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50038)
  elseif attack_element == DIGIMON_ELEMENT_EARTH then
    print("##### attack_element = DIGIMON_ELEMENT_EARTH #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50039)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50040)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50041)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50042)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50039)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50040)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50041)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50042)
  elseif attack_element == DIGIMON_ELEMENT_LIGHT then
    print("##### attack_element = DIGIMON_ELEMENT_LIGHT #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50043)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50044)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50045)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50046)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50043)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50044)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50045)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50046)
  elseif attack_element == DIGIMON_ELEMENT_DARK then
    print("##### attack_element = DIGIMON_ELEMENT_DARK #####")
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, 50047)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, 50048)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, 50049)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, 50050)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, 50047)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, 50048)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, 50049)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, 50050)
  end
end

function GetSpecialWeakAttackSkillId()
  local attack_element = Battle.GetPartyWeaknessDataAttackElement()
  if attack_element == DIGIMON_ELEMENT_NONE then
    print("##### CPattack_element = DIGIMON_ELEMENT_NONE #####")
    return 50053
  elseif attack_element == DIGIMON_ELEMENT_FIRE then
    print("##### CPattack_element = DIGIMON_ELEMENT_FIRE #####")
    return 50054
  elseif attack_element == DIGIMON_ELEMENT_ICE then
    print("##### CPattack_element = DIGIMON_ELEMENT_ICE #####")
    return 50055
  elseif attack_element == DIGIMON_ELEMENT_PLANTS then
    print("##### CPattack_element = DIGIMON_ELEMENT_PLANTS #####")
    return 50056
  elseif attack_element == DIGIMON_ELEMENT_WATER then
    print("##### CPattack_element = DIGIMON_ELEMENT_WATER #####")
    return 50057
  elseif attack_element == DIGIMON_ELEMENT_ELECTRIC then
    print("##### CPattack_element = DIGIMON_ELEMENT_ELECTRIC #####")
    return 50058
  elseif attack_element == DIGIMON_ELEMENT_STEEL then
    print("##### CPattack_element = DIGIMON_ELEMENT_STEEL #####")
    return 50059
  elseif attack_element == DIGIMON_ELEMENT_WIND then
    print("##### CPattack_element = DIGIMON_ELEMENT_WIND #####")
    return 50060
  elseif attack_element == DIGIMON_ELEMENT_EARTH then
    print("##### CPattack_element = DIGIMON_ELEMENT_EARTH #####")
    return 50061
  elseif attack_element == DIGIMON_ELEMENT_LIGHT then
    print("##### CPattack_element = DIGIMON_ELEMENT_LIGHT #####")
    return 50062
  elseif attack_element == DIGIMON_ELEMENT_DARK then
    print("##### CPattack_element = DIGIMON_ELEMENT_DARK #####")
    return 50063
  end
  print("##### CPattack_element = NOT FOUND #####")
  return 50053
end

function EntranceEvent_ArmBig()
  print("=========== EntranceEvent_ArmBig ===========")
  Battle.SetCameraAnimation("Cam_ArmBig_changein01")
  Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 2, 0, 0, 0)
  slot = Sound.PlaySE(300114, 100, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 1, "changein01", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 2, "changein01", 0, false)
  while not Battle.IsEndCamera(1) do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Sound.StopSE(slot, 0)
  print("##### camera_big_Vulcanus01 #####")
  Battle.SetOverwriteCamera("camera_big_Vulcanus01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 1, MOTION_TYPE_IDLE, "bn01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 2, MOTION_TYPE_IDLE, "bn01")
  Flg.Set("Battle5130")
end

function ExitEvent_ArmBig()
  print("=========== ExitEvent_ArmBig ===========")
  Battle.ClearAttatchEffectScript(EFF_01)
  Battle.ClearAttatchEffectScript(EFF_02)
  Battle.SetCameraAnimation("Cam_ArmBig_changeout01")
  Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 2, 0, 0, 0)
  slot = Sound.PlaySE(300115, 100, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 1, "changeout01", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 2, "changeout01", 0, false)
  while not Battle.IsEndCamera(1) do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Sound.StopSE(slot, 0)
  Flg.Clear("Battle5203")
  Battle.RemoveBuff(ENEMY_DIGIMON, 1, 125020)
  Battle.RemoveBuff(ENEMY_DIGIMON, 2, 126020)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, -1)
  Battle.StopEffectScript(EFF_01, 0)
  Battle.StopEffectScript(EFF_02, 0)
  Flg.Clear("Battle5121")
  Flg.Clear("Battle5122")
  Flg.Clear("Battle5123")
  Flg.Clear("Battle5124")
  Battle.DeleteMember(ENEMY_DIGIMON, 1)
  Battle.DeleteMember(ENEMY_DIGIMON, 2)
  Flg.Clear("Battle5130")
end

function EntranceEvent_ArmSmall()
  print("=========== EntranceEvent_ArmSmall ===========")
  Battle.SetCameraAnimation("Cam_ArmSmall_changein01")
  Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 2, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 3, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 4, 0, 0, 0)
  slot = Sound.PlaySE(300116, 100, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 1, "changein01", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 2, "changein01", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 3, "changein02", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 4, "changein02", 0, false)
  while not Battle.IsEndCamera(1) do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Sound.StopSE(slot, 0)
  print("##### camera_big_Vulcanus02 #####")
  Battle.SetOverwriteCamera("camera_big_Vulcanus02")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 1, MOTION_TYPE_IDLE, "bn01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 2, MOTION_TYPE_IDLE, "bn01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 3, MOTION_TYPE_IDLE, "bn01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 4, MOTION_TYPE_IDLE, "bn01")
  Flg.Set("Battle5131")
end

function ExitEvent_ArmSmall()
  print("=========== ExitEvent_ArmSmall ===========")
  Battle.ClearAttatchEffectScript(EFF_03)
  Battle.ClearAttatchEffectScript(EFF_04)
  Battle.ClearAttatchEffectScript(EFF_05)
  Battle.ClearAttatchEffectScript(EFF_06)
  Battle.SetCameraAnimation("Cam_ArmSmall_changeout01")
  Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 2, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 3, 0, 0, 0)
  Battle.SetModelPosition(ENEMY_DIGIMON, 4, 0, 0, 0)
  slot = Sound.PlaySE(300117, 100, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 1, "changeout01", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 2, "changeout01", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 3, "changeout02", 0, false)
  BtlPlayAnimation(ENEMY_DIGIMON, 4, "changeout02", 0, false)
  while not Battle.IsEndCamera(1) do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Sound.StopSE(slot, 0)
  Flg.Clear("Battle5203")
  Battle.RemoveBuff(ENEMY_DIGIMON, 1, 125020)
  Battle.RemoveBuff(ENEMY_DIGIMON, 2, 126020)
  Battle.RemoveBuff(ENEMY_DIGIMON, 3, 127020)
  Battle.RemoveBuff(ENEMY_DIGIMON, 4, 128020)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50003, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 1, 50004, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50005, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 2, 50006, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50003, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 3, 50004, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50005, -1)
  Battle.UpgradeSkill(ENEMY_DIGIMON, 4, 50006, -1)
  Battle.StopEffectScript(EFF_03, 0)
  Battle.StopEffectScript(EFF_04, 0)
  Battle.StopEffectScript(EFF_05, 0)
  Battle.StopEffectScript(EFF_06, 0)
  Flg.Clear("Battle5121")
  Flg.Clear("Battle5122")
  Flg.Clear("Battle5123")
  Flg.Clear("Battle5124")
  Battle.DeleteMember(ENEMY_DIGIMON, 1)
  Battle.DeleteMember(ENEMY_DIGIMON, 2)
  Battle.DeleteMember(ENEMY_DIGIMON, 3)
  Battle.DeleteMember(ENEMY_DIGIMON, 4)
  Flg.Clear("Battle5131")
end

function EventPlay_Phase1_Clear()
  print("=========== EventPlay_Phase1_Clear ===========")
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(-10.12, 0.73, 16.44, -7.41, 1, 6.82, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.SetModelPosition(GUEST_AEGIOMON, 0, -10.26, 0, 15.23)
  Battle.SetModelPosition(PLAYER_CHARA, 0, -0.45, 0, 16.8)
  Battle.SetModelPosition(PLAYER_DIGIMON, 0, 28.48, 0, 9.06)
  Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
  Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
  Battle.MessageTalk(1040020001)
  WaitMessage()
  Battle.SetCamera(1.91, 7.97, -16.52, -5.23, 6.75, -23.4, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.MessageTalk(1040020003)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
end

function EventPlay_Phase2_Clear()
  print("=========== EventPlay_Phase2_Clear ===========")
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(1.91, 7.97, -16.52, -5.23, 6.75, -23.4, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.MessageTalk(1040020004)
  WaitMessage()
  Battle.MessageTalk(1040020009)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
end

function EventPlay_FirstCPCharge()
  print("=========== EventPlay_FirstCPCharge ===========")
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(-8.67, 14.27, -8.71, -2.56, 10.7, -15.78, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  slot = Sound.PlaySE(300118, 100, false)
  Battle.PlayObjectAnimation(OBJ_01, "e001", false)
  Battle.MessageTalk(1040020007)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  Sound.StopSE(slot, 0)
end

function EventPlay_Phase3_CPCharge()
  print("=========== EventPlay_Phase3_CPCharge ===========")
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(-8.67, 14.27, -8.71, -2.56, 10.7, -15.78, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  slot = Sound.PlaySE(300118, 100, false)
  Battle.PlayObjectAnimation(OBJ_01, "e001", false)
  Battle.MessageTalk(1040020002)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  Sound.StopSE(slot, 0)
end

function EventPlay_FirstCreateAttributeArm()
  print("=========== EventPlay_FirstCreateAttributeArm ===========")
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
  Battle.SetCameraMoveStart()
  Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
  Battle.MessageTalk(1040020005)
  WaitMessage()
  slot = Sound.PlaySE(300119, 100, false)
  Battle.PlayObjectAnimation(OBJ_01, "e002", false)
  WaitFrame(30)
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  Sound.StopSE(slot, 0)
end

function EventPlay_CPChargeBreak()
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(1.91, 7.97, -16.52, -5.23, 6.75, -23.4, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.MessageTalk(1040020006)
  WaitMessage()
  slot = Sound.PlaySE(300119, 100, false)
  Battle.PlayObjectAnimation(OBJ_01, "e002", false)
  WaitFrame(30)
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  Sound.StopSE(slot, 0)
end

function EventPlay_BeforeCPCharge()
  print("=========== EventPlay_BeforeCPCharge ===========")
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(1.91, 7.97, -16.52, -5.23, 6.75, -23.4, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.MessageTalk(1040020008)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
end

function LotteryExtraTurnUnit()
  print("=========== LotteryExtraTurnUnit ===========")
  LotteryEnemyArm()
end

function LotteryEnemyArm()
  print("=========== LotteryEnemyArm ===========")
  local target_idx
  local extra_turn_skill_id = 50052
  local target_list = {}
  print("stock_num:", stock_num)
  for idx = 1, 4 do
    if IsCheckTarget(ENEMY_DIGIMON, idx, REGION_FLAG_TYPE_MECHANICAL) == true then
      local enemy_data = {
        group = ENEMY_DIGIMON,
        index = idx
      }
      target_list[#target_list + 1] = enemy_data
    end
  end
  print("##### target_list_cnt:", #target_list, " #####")
  print("##### target_list_chk:", 1 < #target_list, " #####")
  if #target_list == 0 then
    print("##### All Destroy not ExtraTurn #####")
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  else
    local is_random_check = false
    if extra_turn_unit_index == nil then
      is_random_check = true
    else
      local hp = Battle.GetStatus(ENEMY_DIGIMON, extra_turn_unit_index, STATUS_TYPE_HP)
      if hp == 0 then
        is_random_check = true
      end
    end
    if is_random_check then
      math.randomseed(os.time())
      target_idx = math.random(1, #target_list)
      extra_turn_unit_index = target_list[target_idx].index
    end
    if 2 <= #target_list then
      if Flg.Check("Battle5001") == false then
        extra_turn_skill_id = 50051
      elseif Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
        extra_turn_skill_id = 50052
      elseif Flg.Check("Battle5002") then
        if Flg.Check("Battle5150") then
          extra_turn_skill_id = 50051
        elseif Flg.Check("Battle5151") then
          extra_turn_skill_id = 50052
        elseif Flg.Check("Battle5152") then
          extra_turn_skill_id = GetSpecialWeakAttackSkillId()
        end
      end
      Battle.SetExtraTurn(ENEMY_DIGIMON, extra_turn_unit_index, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, extra_turn_unit_index, extra_turn_skill_id)
    elseif #target_list == 1 then
      Battle.SetExtraTurn(ENEMY_DIGIMON, extra_turn_unit_index, true)
      Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, extra_turn_unit_index, 50064)
    end
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
