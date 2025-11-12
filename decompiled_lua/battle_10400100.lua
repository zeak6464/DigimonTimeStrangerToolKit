require("include_battle")
EFF_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadEffectScript(EFF_01, "ef_b_buf_110")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  SetEndrollMember(10400100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m150_110")
    Fade.In(1, Util.SecondFromFrame(30))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(207, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 591904)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  math.randomseed(os.time())
  local random = math.random(1, 3)
  if Flg.Check("Battle5001") and info.group == 2 then
    if info.index == 0 then
      if Flg.Check("Battle5002") == false then
        if random == 1 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30201)
        elseif random == 2 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30321)
        elseif random == 3 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30141)
        end
      elseif Flg.Check("Battle5002") and Flg.Check("Battle5003") == false then
        if random == 1 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30081)
        elseif random == 2 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30201)
        elseif random == 3 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 26091)
        end
      elseif Flg.Check("Battle5003") then
        if random == 1 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10011)
        elseif random == 2 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 26091)
        elseif random == 3 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30191)
        end
      end
    elseif info.index == 1 then
      if Flg.Check("Battle5002") == false then
        if random == 1 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 30321)
        elseif random == 2 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 30141)
        elseif random == 3 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 30081)
        end
      elseif Flg.Check("Battle5002") and Flg.Check("Battle5003") == false then
        if random == 1 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 26091)
        elseif random == 2 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 30081)
        elseif random == 3 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 30201)
        end
      elseif Flg.Check("Battle5003") then
        if random == 1 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 30071)
        elseif random == 2 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 10011)
        elseif random == 3 then
          Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 26091)
        end
      end
    end
  end
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_PHYSICAL, 0, ENEMY_DIGIMON, 0, 1) and Flg.Check("Battle5001") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-1.34, 2.22, 11.31, 0.94, 2.87, 1.59, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -10.26, 0, 15.23)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -0.45, 0, 36.8)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 3.88, 0, 4.46)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, 5.54, 0, 4.4)
    Battle.SetModelRotationY(ENEMY_DIGIMON, 0, 10)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 28.48, 0, 29.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 27.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 29.06)
    Battle.SetModelRotationY(ENEMY_DIGIMON, 0, 0)
    Battle.MessageTalk(1040010001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5001")
  end
  if Flg.Check("Battle5101") == false then
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_MAGIC, 0, ENEMY_DIGIMON, 0, 4) and enemy_now_hp / enemy_max_hp < 0.7 then
      Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, false)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 591904)
      Battle.AddBuff(ENEMY_DIGIMON, 0, 591905)
      Battle.AddBuff(ENEMY_DIGIMON, 0, 591901)
      Flg.Set("Battle5101")
      if Flg.Check("Battle5002") == false then
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(-1.34, 2.22, 11.31, 0.94, 2.87, 1.59, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.SetModelRotationY(ENEMY_DIGIMON, 0, 10)
        Battle.SetModelPosition(GUEST_AEGIOMON, 0, -10.26, 0, 15.23)
        Battle.SetModelPosition(PLAYER_CHARA, 0, -0.45, 0, 36.8)
        Battle.SetModelPosition(GUEST_DIGIMON, 0, 3.88, 0, 4.46)
        Battle.SetModelPosition(GUEST_DIGIMON, 1, 5.54, 0, 4.4)
        Battle.SetModelPosition(PLAYER_DIGIMON, 0, 28.48, 0, 29.06)
        Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 27.5)
        Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 29.06)
        Battle.AttatchEffectScriptToModel(EFF_01, ENEMY_DIGIMON, 0)
        Battle.PlayEffectScript(EFF_01, 0)
        slot = Sound.PlaySE(300301, 100, false)
        WaitFrame(50)
        Sound.StopSE(slot, 0)
        Battle.MessageTalk(1040010002)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Battle.SetModelRotationY(ENEMY_DIGIMON, 0, 0)
        Flg.Set("Battle5002")
      end
    end
  elseif Flg.Check("Battle5102") == false and Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_MAGIC, 0, ENEMY_DIGIMON, 0, 14) and enemy_now_hp / enemy_max_hp < 0.3 then
    Battle.SetIsDisableBuffRemoval(ENEMY_DIGIMON, 0, false)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 591901)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 591905)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 591902)
    Flg.Set("Battle5102")
    if Flg.Check("Battle5003") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(-1.34, 2.22, 11.31, 0.94, 2.87, 1.59, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_AEGIOMON, 0, -10.26, 0, 15.23)
      Battle.SetModelPosition(PLAYER_CHARA, 0, -0.45, 0, 36.8)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, 3.88, 0, 4.46)
      Battle.SetModelPosition(GUEST_DIGIMON, 1, 5.54, 0, 4.4)
      Battle.SetModelRotationY(ENEMY_DIGIMON, 0, 10)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, 28.48, 0, 29.06)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 27.5)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 29.06)
      Battle.AttatchEffectScriptToModel(EFF_01, ENEMY_DIGIMON, 0)
      Battle.PlayEffectScript(EFF_01, 0)
      slot = Sound.PlaySE(300301, 100, false)
      WaitFrame(50)
      Sound.StopSE(slot, 0)
      Battle.MessageTalk(1040010003)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Battle.SetModelRotationY(ENEMY_DIGIMON, 0, 0)
      Flg.Set("Battle5003")
    end
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_04_091")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(725, DIGIMON_GRASP_FLAG_SCAN)
end
