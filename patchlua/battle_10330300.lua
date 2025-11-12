require("include_battle")
EFF_01 = 1
EFF_02 = 2
EFF_03 = 3
EFF_04 = 4
Round = 0
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.LoadEffectScript(EFF_01, "ef_f_mov_130_ga")
  Battle.LoadEffectScript(EFF_02, "ef_e_com_170")
  Battle.LoadEffectScript(EFF_03, "ef_e_com_171")
  Battle.LoadEffectScript(EFF_04, "ef_e_com_172")
  Battle.LoadTalk("battle")
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(10330300)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m110_060")
    Battle.ReadyNextSceneForVista()
    Execute("m110_070")
    Fade.In(0, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(206, 0)
  Battle.PlayEffectScript(EFF_01, 0)
  Battle.SetEffectScriptPosition(EFF_01, 5.55, 26, -65.5)
  Battle.PlayEffectScript(EFF_02, 0)
  Battle.SetEffectScriptPosition(EFF_02, 5.55, 26, -65.5)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    is_high_difficulty = true
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 209003)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30162, 30163)
  end
end

function Battle_Round_Start(info)
  local round_count = info.round
  if info.round == 2 and is_high_difficulty == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 209003)
  end
  if info.round == 8 then
    Battle.StopEffectScript(EFF_02, 0)
    Battle.PlayEffectScript(EFF_03, 0)
    Battle.SetEffectScriptPosition(EFF_03, 5.55, 26, -65.5)
  end
  Round = Round + 1
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 24403 then
    if is_high_difficulty then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 209003)
    else
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    end
  end
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_id == 95401 and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(2.45, 0.46, 0.82, 0.6, 5.95, -7.32, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1033030001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if enemy_now_hp / enemy_max_hp <= 0.4 and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 24403 and Flg.Check("Battle5001") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.StopEffectScript(EFF_03, 0)
    Battle.PlayEffectScript(EFF_04, 0)
    Battle.SetEffectScriptPosition(EFF_04, 5.55, 26, -65.5)
    Battle.SetCamera(12.63, 19.75, -35.39, 10.69, 21.65, -45.01, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1033030003)
    WaitMessage()
    Battle.SetCamera(-0.18, 0.81, 11.96, -0.42, 0.24, 21.94, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 0.78, 0, 14.92)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -1.44, 0, 14.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -0.45, 0, 16.8)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 28.48, 0, 9.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
    Battle.MessageTalk(1033030004)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5001")
  end
  if 1 <= Flgcount() then
    Flg.Set("Battle5051")
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_id == 95401 and Flg.Check("Battle5051") and Flg.Check("Battle5108") == false and Flg.Check("Battle5113") == false and Round >= 3 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 44401)
    Flg.Set("Battle5108")
  end
  if enemy_id == 95401 and Flg.Check("Battle5001") and enemy_now_hp / enemy_max_hp <= 0.1 and Flg.Check("Battle5113") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 44401)
    Flg.Set("Battle5113")
  end
  if enemy_id == 95401 then
    if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 44401 then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 24403)
    elseif Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 24403 and Battle.IsBuff(ENEMY_DIGIMON, 0, 31054, BUFF_CHECK_OR_WITHOUT_ID) then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 34081)
    end
  end
  if Flg.Check("Battle5113") and Flg.Check("Battle5201") == false and info.group == 2 and info.index == 0 then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10011)
    Flg.Set("Battle5201")
  end
end

function Battle_Action_Start(info)
  if info.group == ENEMY_DIGIMON and info.enemy_id == 95401 then
    local skill_id = Battle.GetLastCommandSkillID()
    if skill_id == 24403 and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if info.round == 2 then
    if enemy_id == 95401 and Flg.Check("Battle5104") and Flg.Check("Battle5105") == false then
      if not is_high_difficulty then
        Battle.RemoveBuff(ENEMY_DIGIMON, 0, 209003)
      end
      Flg.Set("Battle5105")
    elseif enemy_id == 95401 and Flg.Check("Battle5103") and Flg.Check("Battle5104") == false then
      Flg.Set("Battle5104")
    elseif enemy_id == 95401 and Flg.Check("Battle5103") == false then
      Flg.Set("Battle5103")
    end
  end
  if enemy_id == 95401 and Flg.Check("Battle5106") == false and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 44401 then
    if is_high_difficulty then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 209003)
    else
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 209003)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
    end
    Flg.Set("Battle5106")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 24403 then
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5106")
    Flg.Clear("Battle5108")
    flgcount = 0
    Round = 0
  end
  if enemy_now_hp == 1 then
    BtlSetInterruptCharacter(GUEST_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Flg.Set("Battle5113")
  end
  if Flg.Check("Battle5201") and info.group == 2 and info.index == 0 then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m110_090")
    Flg.Set("FLAG_MAIN_03_440")
    Battle.ForceEnd()
  end
  if Round >= 6 and Flg.Check("Battle5011") == false then
    Flg.Set("Battle5011")
  end
  local damage_num = enemy_max_hp * 0.17
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 7, ENEMY_DIGIMON, 0, damage_num) then
    Flg.Set("Battle5012")
  end
end

function Flgcount()
  local flgcount = 0
  if Flg.Check("Battle5011") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5012") then
    flgcount = flgcount + 1
  end
  return flgcount
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_03_440")
end

function Battle_Lose(info)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m110_090")
  Flg.Set("FLAG_MAIN_03_440")
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(440, DIGIMON_GRASP_FLAG_SCAN)
end
