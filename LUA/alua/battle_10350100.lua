require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleBGM(-1)
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 27472)
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(10350100)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 1, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.SetTargetCursor(ENEMY_DIGIMON, 1)
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m130_050")
    Sound.SetBGMSelectorLabel(222, "SelectorLabel_0")
    Sound.PlayBGM(222, 0.5)
    Fade.AllIn(1, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(222, 0.5)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  Battle.SetFieldEffectSkill(23943, ENEMY_DIGIMON, 1)
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  if info.group == GUEST_DIGIMON and info.index == 0 then
    if Flg.Check("Battle5002") then
      if Flg.Check("Battle5003") == false then
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m130_080")
        Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 1, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 21361)
        Fade.AllIn(0, Util.SecondFromFrame(15))
        Flg.Set("Battle5003")
      end
    else
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 21362)
    end
  end
end

function Battle_Command_Start(info)
  if info.round == 1 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 23941)
    Battle.SetNextCommandTarget(ENEMY_DIGIMON, 1, GUEST_DIGIMON, 0)
  end
  if (info.round == 3 or Flg.Check("Battle5006") == true) and Flg.Check("Battle5001") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 23941)
    if Battle.GetStatus(GUEST_AEGIOMON, 0, STATUS_TYPE_HP) ~= 0 then
      Battle.SetNextCommandTarget(ENEMY_DIGIMON, 1, GUEST_AEGIOMON, 0)
    end
  end
  if info.round == 5 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 23941)
    Battle.SetNextCommandTarget(ENEMY_DIGIMON, 1, GUEST_DIGIMON, 0)
  end
  if Flg.Check("Battle5004") and Flg.Check("Battle5005") == false then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 27471)
    Battle.SetNextCommandTarget(GUEST_DIGIMON, 1, ENEMY_DIGIMON, 1)
    Flg.Set("Battle5005")
  end
  if Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    if 1 <= Common.GetGameClearNum() then
      Flg.Set("Battle5002")
    elseif info.group == GUEST_AEGIOMON then
      Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, GUEST_AEGIOMON, 0)
      Window.OpenInfo(10350100)
      WaitFrame(1)
      while not Window.IsNextInfo() do
        WaitFrame(1)
      end
      Window.CloseInfo()
      WaitFrame(1)
      while not Window.IsEndCloseInfo() do
        WaitFrame(1)
      end
      Flg.Set("Battle5002")
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
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP)
  local fuga_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local hyoga_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP)
  local hp_rate = enemy_now_hp / enemy_max_hp
  if info.group == PLAYER_DIGIMON or info.group == GUEST_AEGIOMON or info.group == GUEST_DIGIMON then
    if Flg.Check("Battle5004") == false then
      if hp_rate <= 0.9 then
        print("##### InterruptCharacter = 0.9 ")
        BtlSetInterruptCharacter(ENEMY_DIGIMON, 1, BATTLE_INTERRUPT_TYPE_NORMAL)
      end
    elseif Flg.Check("Battle5005") and Flg.Check("Battle5001") == false and Flg.Check("Battle5006") == false and hp_rate <= 0.5 then
      print("##### InterruptCharacter = 0.5 ")
      BtlSetInterruptCharacter(ENEMY_DIGIMON, 1, BATTLE_INTERRUPT_TYPE_NORMAL)
      Flg.Set("Battle5006")
    end
  end
  if info.enemy_id == 95101 then
    if info.round == 1 and Flg.Check("Battle5004") == false and not Flg.Check("FLAG_MAIN_03_580") then
      Battle.CloseUI()
      Flg.Set("FLAG_MAIN_03_580")
      Battle.ReadyNextSceneForVista()
      Execute("m130_060")
      local nowhp = math.ceil(enemy_now_hp * 0.9)
      Battle.SetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP, nowhp)
      Battle.ExchangeMember(GUEST_DIGIMON, 1)
      BtlSetInterruptCharacter(GUEST_DIGIMON, 1, BATTLE_INTERRUPT_TYPE_NORMAL, true)
      Fade.AllIn(0, Util.SecondFromFrame(15))
      Flg.Set("Battle5004")
    end
    if (info.round == 3 or hp_rate <= 0.5) and Flg.Check("Battle5001") == false and Flg.Check("Battle5005") then
      Battle.CloseUI()
      Battle.ReadyNextSceneForVista()
      Execute("m130_070")
      local now_hp = Battle.GetStatus(GUEST_AEGIOMON, 0, STATUS_TYPE_HP)
      local hp = 1
      local nowhp = math.ceil(enemy_now_hp * 0.9)
      Battle.SetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP, nowhp)
      if now_hp == 0 then
        Battle.SetStatus(GUEST_AEGIOMON, 0, STATUS_TYPE_HP, hp)
      end
      if 1 <= Common.GetGameClearNum() then
        Fade.AllIn(0, Util.SecondFromFrame(15))
        Flg.Set("Battle5001")
      else
        Battle.SetAegiomonSkill(-1, 21831)
        Fade.AllIn(0, Util.SecondFromFrame(15))
        Flg.Set("Battle5001")
      end
    end
    if enemy_now_hp == 1 and Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
      BtlSetInterruptCharacter(GUEST_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
      Flg.Set("Battle5002")
    end
  end
  if 1 < enemy_now_hp then
    if fuga_now_hp == 0 and hyoga_now_hp == 0 and Flg.Check("Battle5007") == false and Flg.Check("Battle5008") == false then
      Battle.SetFieldEffectSkill(23945, ENEMY_DIGIMON, 1)
      Flg.Set("Battle5007")
      Flg.Set("Battle5008")
    elseif fuga_now_hp == 0 and Flg.Check("Battle5007") == false then
      Battle.SetFieldEffectSkill(23944, ENEMY_DIGIMON, 1)
      Flg.Set("Battle5007")
    elseif hyoga_now_hp == 0 and Flg.Check("Battle5008") == false then
      Battle.SetFieldEffectSkill(23944, ENEMY_DIGIMON, 1)
      Flg.Set("Battle5008")
    end
  end
end

function Battle_Win(info)
  Battle.DeleteMember(GUEST_AEGIOMON, 0)
  Battle.DeleteMember(GUEST_DIGIMON, 0)
  Battle.SetWinBGM(-1)
  Flg.Set("FLAG_MAIN_03_590")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(394, DIGIMON_GRASP_FLAG_SCAN)
  Common.SetDigimonGraspState(579, DIGIMON_GRASP_FLAG_SCAN)
  Common.SetDigimonGraspState(580, DIGIMON_GRASP_FLAG_SCAN)
end
