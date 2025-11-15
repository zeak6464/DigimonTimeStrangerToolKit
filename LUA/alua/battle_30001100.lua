require("include_battle")
Round = 0
EFF_IN_00 = 1
EFF_IN_01 = 2
EFF_IN_02 = 3
EFF_IN_03 = 4
EFF_IN_04 = 5

function Battle_Before_Setup()
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 0, 45901, 70)
  Battle.PrepareExchangeByEnemyID(ENEMY_DIGIMON, 1, 46601, 70)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn02")
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Sound.PlayBGM(201, 0.5)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
end

function Battle_Round_Start(info)
  if info.round == 6 and Flg.Check("Battle5001") == false then
    EnemyChangeEvent()
  end
end

function Battle_Turn_Start(info)
  if Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(0, 1.06, 1.09, 0, 0.19, -8.86, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    WaitFrame(15)
    Battle.LoadDissolveChangeIn(EFF_IN_01, ENEMY_DIGIMON, 0)
    Battle.LoadDissolveChangeIn(EFF_IN_02, ENEMY_DIGIMON, 1)
    while Battle.IsLoadingDissolve(EFF_IN_00) ~= false or Battle.IsLoadingDissolve(EFF_IN_01) ~= false or Battle.IsLoadingDissolve(EFF_IN_02) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_01)
    Battle.PlayDissolve(EFF_IN_02)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, -1.72, 0, -4.86)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 1.72, 0, -4.25)
    WaitFrame(40)
    Battle.MessageTalk(300011002)
    WaitMessage()
    Battle.MessageTalk(300011003)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5002")
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    Battle.SetOverwriteCamera("battle_camera_setting")
    Battle.SetEnemyFormationId(1)
  end
end

function Battle_Command_Start(info)
  local round_count = info.round
  local enemy_id = info.enemy_id
  if Flg.Check("Battle5002") and enemy_id == 45901 and round_count % 5 == 0 and Flg.Check("Battle5101") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 24382)
    Battle.SetCamera(0, 0.62, -2.9, -3.75, 0.1, -6.4, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "fe04", 0, false)
    WaitFrame(50)
    Battle.SetMonochrome(true)
    Battle.SetNegative(true)
    Sound.PlaySE(404003, 100, false)
    Battle.CloseUI()
    Battle.StartScreenCaptureDraw()
    WaitFrame(75)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
    Battle.EndScreenCaptureDraw()
    Battle.PlayScreenCrackingEffect()
    Battle.SetMonochrome(false)
    Battle.SetNegative(false)
    Sound.PlaySE(404003, 100, false)
    WaitFrame(30)
    Flg.Set("Battle5101")
  end
end

function Battle_Action_Start(info)
  local enemy_id = info.enemy_id
  if Flg.Check("Battle5101") and enemy_id == 45901 then
    Battle.SkipSkillDirection(ENEMY_DIGIMON, 0, 24382)
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_now_hp == 1 and Flg.Check("Battle5001") == false then
    EnemyChangeEvent()
  end
  Flg.Clear("Battle5101")
end

function Battle_Win(info)
  Flg.Set("FLAG_FREEARENA_WIN_011")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end

function EnemyChangeEvent()
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(0.02, 6.25, 6.07, 0.02, 6.25, -3.91, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn02", 0, true)
  Battle.MessageTalk(300011001)
  Battle.LoadDissolveChangeOut(EFF_IN_04, ENEMY_DIGIMON, 0)
  while Battle.IsLoadingDissolve(EFF_IN_03) ~= false or Battle.IsLoadingDissolve(EFF_IN_04) ~= false do
    WaitFrame(1)
  end
  Battle.PlayDissolve(EFF_IN_04)
  WaitFrame(30)
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  Battle.ExchangeMemberForDeleteTimingNextTurn(ENEMY_DIGIMON, 0)
  Battle.ExchangeMemberForDeleteTimingNextTurn(ENEMY_DIGIMON, 1)
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "fe04")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  Flg.Set("Battle5001")
end
