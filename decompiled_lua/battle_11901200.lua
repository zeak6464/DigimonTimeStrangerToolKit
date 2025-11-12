require("include_battle")
Round = 0
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
EFF_IN_03 = 4

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 0, 87001, 60)
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 20802)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "f000")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fq01")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fq02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe04")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bs01")
  Battle.LoadAnimation(GUEST_DIGIMON, 1, "bn01")
  Battle.LoadAnimation(GUEST_DIGIMON, 1, "fe02")
  Battle.LoadAnimation(GUEST_DIGIMON, 1, "fe04")
  SetEndrollMember(11901200)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  local now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  if Flg.Check("FLAG_MAIN_22_511") and Flg.Check("FLAG_MAIN_22_512") == false then
    local hp = max_hp * 0.75
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  elseif Flg.Check("FLAG_MAIN_22_512") and Flg.Check("FLAG_MAIN_22_513") == false then
    local hp = max_hp * 0.5
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  elseif Flg.Check("FLAG_MAIN_22_513") and Flg.Check("FLAG_MAIN_22_514") == false then
    local hp = max_hp * 0.25
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  elseif Flg.Check("FLAG_MAIN_22_514") then
    local hp = 100
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  end
  Sound.PlayBGM(931, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
  if Flg.Check("Battle5003") then
    Round = Round + 1
  end
  if Flg.Check("Battle5004") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(8.895, 0.945, 3.302, 6.893, -0.399, 13.007, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 8.41, 0, 5.8)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -47.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -47.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 0, true)
    Battle.MessageTalk(1190120001)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
    Battle.MessageTalk(1190120002)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5004")
  end
  if Round == 3 and Flg.Check("Battle5003") and Flg.Check("Battle5005") == false then
    Battle.ExchangeMember(GUEST_DIGIMON, 1)
    Flg.Set("Battle5005")
  end
  if Round == 1 and Flg.Check("Battle5005") and Flg.Check("Battle5006") == false then
    Talk.OpenLetterBox()
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 9.74628, 0, 4.43)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, 5.519155, 0, 5.883)
    Battle.SetCamera(14.046, 2.14, 11.541, 7.454, 1.9, 4.025, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.CloseUI()
    WaitFrame(1)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, GUEST_DIGIMON, 1)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 1, GUEST_DIGIMON, 0)
    WaitFrame(1)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "fe04", 10, true)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "bn01", 10, true)
    Battle.MessageTalk(1190120009)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 10, true)
    Battle.MessageTalk(1190120010)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
    Battle.MessageTalk(1190120011)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Round = 0
    Flg.Set("Battle5006")
  end
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, false)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 9.55, 0, 7.5)
    Battle.SetCamera(-0.58, 2.87, 8.11, -0.34, 4.4, -1.76, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    WaitFrame(30)
    Battle.LoadDissolveChangeIn(EFF_IN_01, ENEMY_DIGIMON, 0)
    while Battle.IsLoadingDissolve(EFF_IN_00) ~= false or Battle.IsLoadingDissolve(EFF_IN_01) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_01)
    WaitFrame(40)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 10, true)
    Round = 0
    Flg.Set("Battle5002")
  end
  if Flg.Check("Battle5002") and Flg.Check("Battle5003") == false then
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(8.895, 0.945, 3.302, 6.893, -0.399, 13.007, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 8.41, 0, 5.8)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -47.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -47.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fq02", 10, true)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 10, true)
    Battle.MessageTalk(1190120003)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
    Battle.MessageTalk(1190120004)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 10, true)
    Battle.MessageTalk(1190120005)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5003")
  end
  if Flg.Check("Battle5005") and Flg.Check("Battle5011") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    slot = Sound.PlaySE(404003, 100)
    Fade_OutNoLoadingWithWait(FADE_WHITE, 5)
    WaitFrame(30)
    Sound.StopSE(slot, 0)
    Battle.SetCamera(7.52, 3.61, 2.02, 12.55, 4.95, 10.56, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, 9.27, 0, 5.49)
    Battle.SetModelRotationY(GUEST_DIGIMON, 1, 210)
    WaitFrame(15)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "fe02", 0, false)
    WaitFrame(15)
    Fade.AllIn(FADE_WHITE, Util.SecondFromFrame(5))
    slot = Sound.PlaySE(400006, 100)
    WaitFrame(35)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "bn01", 10, true)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -47.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -47.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
    Battle.MessageTalk(1190120006)
    WaitMessage()
    Battle.MessageTalk(1190120007)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 1, "fe04", 10, true)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "bn01", 10, true)
    Battle.MessageTalk(1190120008)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Round = 0
    Flg.Set("Battle5011")
    Sound.StopSE(slot, 0)
  end
end

function Battle_Command_Start(info)
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5003") == false then
    if info.group == 2 and info.index == 0 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43751)
    end
  elseif Flg.Check("Battle5003") and Flg.Check("Battle5007") == false and info.group == 2 and info.index == 0 then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43752)
  end
  if Flg.Check("Battle5008") then
    if enemy_now_hp / enemy_max_hp <= 0.5 and Flg.Check("Battle5009") == false then
      if info.group == 2 and info.index == 0 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43753)
        Flg.Set("Battle5009")
      end
    elseif enemy_now_hp / enemy_max_hp <= 0.25 and Flg.Check("Battle5010") == false and info.group == 2 and info.index == 0 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43753)
      Flg.Set("Battle5010")
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
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_now_hp == 1 and Flg.Check("Battle5001") == false then
    Battle.SetCamera(-0.58, 2.87, 8.11, -0.34, 4.4, -1.76, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.LoadDissolveChangeOut(EFF_IN_03, ENEMY_DIGIMON, 0)
    while Battle.IsLoadingDissolve(EFF_IN_02) ~= false or Battle.IsLoadingDissolve(EFF_IN_03) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_03)
    Battle.ExchangeMemberForDeleteTimingNextTurn(ENEMY_DIGIMON, 0)
    Battle.LoadAnimation(ENEMY_DIGIMON, 0, "ba02")
    Flg.Set("Battle5001")
  end
  if Flg.Check("Battle5006") and Flg.Check("Battle5007") == false and info.group == 0 and Battle.IsLastCommandSkillTarget(GUEST_DIGIMON, 0) then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -47.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -47.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 8.41, 0, 5.8)
    Battle.SetCamera(8.1978, 1.1492, 1.4325, 12.755, -0.85, 10.106, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
    Battle.MessageTalk(1190120012)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bs01", 10, true)
    Battle.MessageTalk(1190120013)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    BtlSetInterruptCharacter(GUEST_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43753)
    Flg.Set("Battle5007")
  end
  if Flg.Check("Battle5007") and Flg.Check("Battle5008") == false and info.group == 2 and info.index == 0 and Battle.GetCharacterLastCommandSkillID(GUEST_DIGIMON, 0) == 43753 then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(8.4, 0.31, 7.89, 4.63, 2.19, -1.17, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 8.41, 0, 5.8)
    Battle.SetModelRotationY(GUEST_DIGIMON, 0, 245)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -47.71, 0, 28.56)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -47.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 10, true)
    Battle.MessageTalk(1190120014)
    WaitMessage()
    Battle.MessageTalk(1190120015)
    WaitMessage()
    BtlPlayAnimation(GUEST_DIGIMON, 0, "fe02", 10, true)
    Battle.MessageTalk(1190120016)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5008")
    Battle.ResetModelRotationY(GUEST_DIGIMON, 0)
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_22_516")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(439, DIGIMON_GRASP_FLAG_SCAN)
  Common.SetDigimonGraspState(40, DIGIMON_GRASP_FLAG_SCAN)
  Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
end
