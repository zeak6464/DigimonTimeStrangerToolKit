require("include_battle")
OBJ_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadObject(OBJ_01, "chr774")
  Battle.LoadObjectAnimation(OBJ_01, "bn01")
end

function Battle_After_Setup()
  SetEndrollMember(11200040)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m350_110")
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(806, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.PlayObjectAnimation(OBJ_01, "bn01", true)
  Battle.SetObjectPosition(OBJ_01, -18.294, 30.08, -59.09)
end

function Battle_Start(info)
  FadeAllIn(FADE_WHITE, FADE_TIME)
end

function Battle_Round_Start(info)
  Flg.Clear("Battle5101")
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_id = info.enemy_id
  math.randomseed(os.time())
  local random = math.random(1, 2)
  if enemy_id == 88101 then
    if 0.75 <= enemy_now_hp / enemy_max_hp then
      if round_count % 2 == 0 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48823)
      elseif round_count % 2 == 1 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48822)
      end
    elseif 0.5 <= enemy_now_hp / enemy_max_hp and enemy_now_hp / enemy_max_hp < 0.75 then
      if round_count % 2 == 0 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48823)
      elseif round_count % 2 == 1 and Flg.Check("Battle5101") == false then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48824)
        Flg.Set("Battle5101")
      else
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48826)
      end
    elseif 0.25 <= enemy_now_hp / enemy_max_hp and enemy_now_hp / enemy_max_hp < 0.5 then
      if round_count % 2 == 0 and random == 1 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48822)
      elseif round_count % 2 == 0 and random == 2 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48821)
      elseif round_count % 2 == 1 and Flg.Check("Battle5101") and random == 1 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48827)
      elseif round_count % 2 == 1 and Flg.Check("Battle5101") and random == 2 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48828)
      elseif round_count % 2 == 1 and Flg.Check("Battle5101") == false then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48824)
        Flg.Set("Battle5101")
      end
    elseif enemy_now_hp / enemy_max_hp < 0.25 then
      if round_count % 2 == 0 and random == 1 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48823)
      elseif round_count % 2 == 0 and random == 2 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48821)
      elseif round_count % 2 == 1 and Flg.Check("Battle5101") then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48821)
      elseif round_count % 2 == 1 and Flg.Check("Battle5101") == false then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48824)
        Flg.Set("Battle5101")
      end
    end
  end
  if enemy_id == 88101 then
    if enemy_now_hp / enemy_max_hp <= 0.75 and Flg.Check("Battle5001") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 40001)
      Flg.Set("Battle5001")
    elseif enemy_now_hp / enemy_max_hp <= 0.5 and Flg.Check("Battle5002") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 40002)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
      Flg.Set("Battle5002")
    elseif enemy_now_hp / enemy_max_hp <= 0.25 and Flg.Check("Battle5003") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48825)
      Flg.Set("Battle5003")
    end
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_13_150")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(600, DIGIMON_GRASP_FLAG_SCAN)
  Battle.SetObjectVisible(OBJ_01, false)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m350_120")
end
