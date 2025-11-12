require("include_battle")
EFF_IN_00 = 0
EFF_IN_01 = 0
EFF_IN_02 = 0
Dissolve_cnt = 0
Change_cnt = 0
Change_max = 9
BASE_LEVEL = 70

function Battle_Before_Setup()
  Battle.PrepareQueueExchangeByEnemyID(17403, BASE_LEVEL)
end

function Battle_After_Setup()
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 1, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 2, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Battle.PlayBGM(206, 0)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  local round_count = info.round
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local digimon_id0 = Battle.GetDigimonId(ENEMY_DIGIMON, 0)
  local digimon_id1 = Battle.GetDigimonId(ENEMY_DIGIMON, 1)
  local digimon_id2 = Battle.GetDigimonId(ENEMY_DIGIMON, 2)
  if 2 <= round_count and digimon_id0 == 973 and 0 < enemy_now_hp then
    Battle.SetFieldEffectSkill(21734, -1, -1)
  end
  if digimon_id0 == 170 or digimon_id1 == 170 or digimon_id2 == 170 then
    Battle.SetFieldEffectSkill(21704, -1, -1)
  end
end

function Battle_Turn_Start(info)
  local digimon_id0 = Battle.GetDigimonId(ENEMY_DIGIMON, 0)
  local digimon_id1 = Battle.GetDigimonId(ENEMY_DIGIMON, 1)
  local digimon_id2 = Battle.GetDigimonId(ENEMY_DIGIMON, 2)
  if Flg.Check("Battle5000") then
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, false)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 0, 0, 0)
    WaitFrame(10)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_00 = Dissolve_cnt
    Battle.LoadDissolveChangeIn(EFF_IN_00, ENEMY_DIGIMON, 0)
    while Battle.IsLoadingDissolve(EFF_IN_00) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_00)
    WaitFrame(40)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
    Flg.Clear("Battle5000")
  end
  if Flg.Check("Battle5001") then
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, false)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0, 0, 0)
    WaitFrame(10)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_01 = Dissolve_cnt
    Battle.LoadDissolveChangeIn(EFF_IN_01, ENEMY_DIGIMON, 1)
    while Battle.IsLoadingDissolve(EFF_IN_01) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_01)
    WaitFrame(40)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 1, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
    Flg.Clear("Battle5001")
  end
  if Flg.Check("Battle5002") then
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, false)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 0, 0, 0)
    WaitFrame(10)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_02 = Dissolve_cnt
    Battle.LoadDissolveChangeIn(EFF_IN_02, ENEMY_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_02) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_02)
    WaitFrame(40)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 2, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
    Flg.Clear("Battle5002")
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  local digimon_id0 = Battle.GetDigimonId(ENEMY_DIGIMON, 0)
  local digimon_id1 = Battle.GetDigimonId(ENEMY_DIGIMON, 1)
  local digimon_id2 = Battle.GetDigimonId(ENEMY_DIGIMON, 2)
  if Flg.Check("Battle5108") then
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 1, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 2, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
  end
  if enemy_id == 7501 then
    math.randomseed(os.time())
    local random = math.random(1, 2)
    if digimon_id0 == 172 or digimon_id1 == 172 or digimon_id2 == 172 then
      if random == 1 then
        if digimon_id0 == 75 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 20751)
        elseif digimon_id1 == 75 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 20751)
        elseif digimon_id2 == 75 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 20751)
        end
      elseif random == 2 then
        if digimon_id0 == 75 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 20752)
        elseif digimon_id1 == 75 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 1, 20752)
        elseif digimon_id2 == 75 then
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 2, 20752)
        end
      end
    end
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
  local enemy0_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy1_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP)
  local enemy2_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP)
  local digimon_id0 = Battle.GetDigimonId(ENEMY_DIGIMON, 0)
  local digimon_id1 = Battle.GetDigimonId(ENEMY_DIGIMON, 1)
  local digimon_id2 = Battle.GetDigimonId(ENEMY_DIGIMON, 2)
  if Flg.Check("Battle5108") then
    if 0 < enemy0_now_hp and enemy1_now_hp == 0 and 0 < enemy2_now_hp then
      if digimon_id0 == 973 and digimon_id2 == 999 and Flg.Check("Battle5110") == false then
        Battle.PrepareQueueExchangeByEnemyID(83501, BASE_LEVEL)
        Flg.Set("Battle5111")
      end
    elseif digimon_id0 ~= 973 or digimon_id2 ~= 999 then
      if Flg.Check("Battle5110") == false and Flg.Check("Battle5111") == false then
        Battle.PrepareQueueExchangeByEnemyID(83401, BASE_LEVEL)
        Flg.Set("Battle5110")
      end
    elseif digimon_id0 == 973 and digimon_id2 == 999 and Flg.Check("Battle5110") == false and Flg.Check("Battle5111") == false and enemy0_now_hp == 0 and 0 < enemy1_now_hp and enemy2_now_hp == 0 then
      Battle.PrepareQueueExchangeByEnemyID(83401, BASE_LEVEL)
      Flg.Set("Battle5110")
    end
  end
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local enemy0_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy1_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 1, STATUS_TYPE_HP)
  local enemy2_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 2, STATUS_TYPE_HP)
  local digimon_id0 = Battle.GetDigimonId(ENEMY_DIGIMON, 0)
  local digimon_id1 = Battle.GetDigimonId(ENEMY_DIGIMON, 1)
  local digimon_id2 = Battle.GetDigimonId(ENEMY_DIGIMON, 2)
  local hp1_num = 0
  if enemy0_now_hp == 1 then
    hp1_num = hp1_num + 1
  end
  if enemy1_now_hp == 1 then
    hp1_num = hp1_num + 1
  end
  if enemy2_now_hp == 1 then
    hp1_num = hp1_num + 1
  end
  if 2 < hp1_num then
    if Change_max - Change_cnt == 2 then
      Flg.Set("Battle5113")
    elseif Change_max - Change_cnt == 1 then
      Flg.Set("Battle5113")
      Flg.Set("Battle5114")
    end
  end
  print(Dissolve_cnt)
  if enemy0_now_hp == 1 and Flg.Check("Battle5110") == false and Flg.Check("Battle5111") == false then
    print("####################index_0##########################")
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 30.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, true)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 0, 0, 0)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_00 = Dissolve_cnt
    Battle.LoadDissolveChangeOut(EFF_IN_00, ENEMY_DIGIMON, 0)
    while Battle.IsPlayingDissolve(EFF_IN_00) do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_00)
    while Battle.IsPlayingDissolve(EFF_IN_00) do
      WaitFrame(1)
    end
    Battle.ExchangeQueueMember(ENEMY_DIGIMON, 0)
    Flg.Set("Battle5000")
    if Flg.Check("Battle5100") == false then
      Flg.Set("Battle5100")
    elseif Flg.Check("Battle5101") == false then
      Flg.Set("Battle5101")
      Battle.PrepareQueueExchangeByEnemyID(97101, BASE_LEVEL)
    elseif Flg.Check("Battle5101") and Flg.Check("Battle5102") == false then
      Flg.Set("Battle5102")
      Battle.PrepareQueueExchangeByEnemyID(86701, BASE_LEVEL)
    elseif Flg.Check("Battle5102") and Flg.Check("Battle5103") == false then
      Flg.Set("Battle5103")
      Battle.PrepareQueueExchangeByEnemyID(17001, BASE_LEVEL)
    elseif Flg.Check("Battle5103") and Flg.Check("Battle5104") == false then
      Flg.Set("Battle5104")
      Battle.PrepareQueueExchangeByEnemyID(17201, BASE_LEVEL)
    elseif Flg.Check("Battle5104") and Flg.Check("Battle5105") == false then
      Flg.Set("Battle5105")
      Battle.PrepareQueueExchangeByEnemyID(7501, BASE_LEVEL)
    elseif Flg.Check("Battle5105") and Flg.Check("Battle5106") == false then
      Flg.Set("Battle5106")
      Battle.PrepareQueueExchangeByEnemyID(17901, BASE_LEVEL)
    elseif Flg.Check("Battle5106") and Flg.Check("Battle5107") == false then
      Flg.Set("Battle5107")
      Battle.PrepareQueueExchangeByEnemyID(17601, BASE_LEVEL)
    elseif Flg.Check("Battle5107") and Flg.Check("Battle5108") == false then
      Flg.Set("Battle5108")
      Battle.PrepareQueueExchangeByEnemyID(97601, BASE_LEVEL)
    end
    Change_cnt = Change_cnt + 1
  end
  if enemy1_now_hp == 1 and Flg.Check("Battle5110") == false and Flg.Check("Battle5111") == false then
    print("####################index_1##########################")
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, true)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0, 0, 0)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_01 = Dissolve_cnt
    Battle.LoadDissolveChangeOut(EFF_IN_01, ENEMY_DIGIMON, 1)
    while Battle.IsLoadingDissolve(EFF_IN_01) do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_01)
    while Battle.IsPlayingDissolve(EFF_IN_01) do
      WaitFrame(1)
    end
    if Flg.Check("Battle5113") == true then
      Flg.Clear("Battle5113")
      Battle.DeleteMember(ENEMY_DIGIMON, 1)
    else
      Battle.ExchangeQueueMember(ENEMY_DIGIMON, 1)
      Flg.Set("Battle5001")
      if Flg.Check("Battle5100") == false then
        Flg.Set("Battle5100")
      elseif Flg.Check("Battle5101") == false then
        Flg.Set("Battle5101")
        Battle.PrepareQueueExchangeByEnemyID(97101, BASE_LEVEL)
      elseif Flg.Check("Battle5101") and Flg.Check("Battle5102") == false then
        Flg.Set("Battle5102")
        Battle.PrepareQueueExchangeByEnemyID(86701, BASE_LEVEL)
      elseif Flg.Check("Battle5102") and Flg.Check("Battle5103") == false then
        Flg.Set("Battle5103")
        Battle.PrepareQueueExchangeByEnemyID(17001, BASE_LEVEL)
      elseif Flg.Check("Battle5103") and Flg.Check("Battle5104") == false then
        Flg.Set("Battle5104")
        Battle.PrepareQueueExchangeByEnemyID(17201, BASE_LEVEL)
      elseif Flg.Check("Battle5104") and Flg.Check("Battle5105") == false then
        Flg.Set("Battle5105")
        Battle.PrepareQueueExchangeByEnemyID(7501, BASE_LEVEL)
      elseif Flg.Check("Battle5105") and Flg.Check("Battle5106") == false then
        Flg.Set("Battle5106")
        Battle.PrepareQueueExchangeByEnemyID(17901, BASE_LEVEL)
      elseif Flg.Check("Battle5106") and Flg.Check("Battle5107") == false then
        Flg.Set("Battle5107")
        Battle.PrepareQueueExchangeByEnemyID(17601, BASE_LEVEL)
      elseif Flg.Check("Battle5107") and Flg.Check("Battle5108") == false then
        Flg.Set("Battle5108")
        Battle.PrepareQueueExchangeByEnemyID(97601, BASE_LEVEL)
      end
    end
    Change_cnt = Change_cnt + 1
  end
  if enemy2_now_hp == 1 and Flg.Check("Battle5110") == false and Flg.Check("Battle5111") == false then
    print("####################index_2##########################")
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 27.71, 0, 28.56)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, true)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 0, 0, 0)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_02 = Dissolve_cnt
    Battle.LoadDissolveChangeOut(EFF_IN_02, ENEMY_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_02) do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_02)
    while Battle.IsPlayingDissolve(EFF_IN_02) do
      WaitFrame(1)
    end
    if Flg.Check("Battle5114") == true then
      Flg.Clear("Battle5114")
      Battle.DeleteMember(ENEMY_DIGIMON, 2)
    else
      Battle.ExchangeQueueMember(ENEMY_DIGIMON, 2)
      Flg.Set("Battle5002")
      if Flg.Check("Battle5100") == false then
        Flg.Set("Battle5100")
      elseif Flg.Check("Battle5101") == false then
        Flg.Set("Battle5101")
        Battle.PrepareQueueExchangeByEnemyID(97101, BASE_LEVEL)
      elseif Flg.Check("Battle5101") and Flg.Check("Battle5102") == false then
        Flg.Set("Battle5102")
        Battle.PrepareQueueExchangeByEnemyID(86701, BASE_LEVEL)
      elseif Flg.Check("Battle5102") and Flg.Check("Battle5103") == false then
        Flg.Set("Battle5103")
        Battle.PrepareQueueExchangeByEnemyID(17001, BASE_LEVEL)
      elseif Flg.Check("Battle5103") and Flg.Check("Battle5104") == false then
        Flg.Set("Battle5104")
        Battle.PrepareQueueExchangeByEnemyID(17201, BASE_LEVEL)
      elseif Flg.Check("Battle5104") and Flg.Check("Battle5105") == false then
        Flg.Set("Battle5105")
        Battle.PrepareQueueExchangeByEnemyID(7501, BASE_LEVEL)
      elseif Flg.Check("Battle5105") and Flg.Check("Battle5106") == false then
        Flg.Set("Battle5106")
        Battle.PrepareQueueExchangeByEnemyID(17901, BASE_LEVEL)
      elseif Flg.Check("Battle5106") and Flg.Check("Battle5107") == false then
        Flg.Set("Battle5107")
        Battle.PrepareQueueExchangeByEnemyID(17601, BASE_LEVEL)
      elseif Flg.Check("Battle5107") and Flg.Check("Battle5108") == false then
        Flg.Set("Battle5108")
        Battle.PrepareQueueExchangeByEnemyID(97601, BASE_LEVEL)
      end
    end
    Change_cnt = Change_cnt + 1
  end
  if Flg.Check("Battle5109") == false and Flg.Check("Battle5111") and 0 < enemy0_now_hp and 0 < enemy2_now_hp and enemy1_now_hp == 0 then
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 1, 30.02, 0, 28.56)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, true)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 2, true)
    Battle.SetModelPosition(ENEMY_DIGIMON, 0, 10, 0, 0)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, -10, 0, 0)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_00 = Dissolve_cnt
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_02 = Dissolve_cnt
    Battle.LoadDissolveChangeOut(EFF_IN_00, ENEMY_DIGIMON, 0)
    Battle.LoadDissolveChangeOut(EFF_IN_02, ENEMY_DIGIMON, 2)
    while Battle.IsPlayingDissolve(EFF_IN_00) and Battle.IsPlayingDissolve(EFF_IN_02) do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_00)
    Battle.PlayDissolve(EFF_IN_02)
    while Battle.IsPlayingDissolve(EFF_IN_00) and Battle.IsPlayingDissolve(EFF_IN_02) do
      WaitFrame(1)
    end
    Battle.ExchangeQueueMember(ENEMY_DIGIMON, 1)
    Flg.Set("Battle5109")
    Flg.Set("Battle5001")
    if Flg.Check("Battle5112") == false then
      Battle.DeleteMember(ENEMY_DIGIMON, 0)
      Battle.DeleteMember(ENEMY_DIGIMON, 2)
      Flg.Set("Battle5112")
    end
  end
  if Flg.Check("Battle5109") == false and digimon_id0 == 976 then
    if 0 < enemy0_now_hp and enemy1_now_hp == 0 and enemy2_now_hp == 0 then
      Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
      Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, true)
      Battle.SetModelPosition(ENEMY_DIGIMON, 0, 0, 0, 0)
      Dissolve_cnt = Dissolve_cnt + 1
      EFF_IN_00 = Dissolve_cnt
      Battle.LoadDissolveChangeOut(EFF_IN_00, ENEMY_DIGIMON, 0)
      while Battle.IsLoadingDissolve(EFF_IN_00) do
        WaitFrame(1)
      end
      Battle.PlayDissolve(EFF_IN_00)
      while Battle.IsPlayingDissolve(EFF_IN_00) do
        WaitFrame(1)
      end
      Battle.ExchangeQueueMember(ENEMY_DIGIMON, 0)
      Flg.Set("Battle5000")
      Flg.Set("Battle5109")
    end
  elseif Flg.Check("Battle5109") == false and digimon_id1 == 976 then
    if enemy0_now_hp == 0 and 0 < enemy1_now_hp and enemy2_now_hp == 0 then
      Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
      Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
      Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
      Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
      Battle.SetVisibleCharacter(ENEMY_DIGIMON, 1, true)
      Battle.SetModelPosition(ENEMY_DIGIMON, 1, 0, 0, 0)
      Dissolve_cnt = Dissolve_cnt + 1
      EFF_IN_01 = Dissolve_cnt
      Battle.LoadDissolveChangeOut(EFF_IN_01, ENEMY_DIGIMON, 1)
      while Battle.IsLoadingDissolve(EFF_IN_01) do
        WaitFrame(1)
      end
      Battle.PlayDissolve(EFF_IN_01)
      while Battle.IsPlayingDissolve(EFF_IN_01) do
        WaitFrame(1)
      end
      Battle.ExchangeQueueMember(ENEMY_DIGIMON, 1)
      Flg.Set("Battle5001")
      Flg.Set("Battle5109")
    end
  elseif Flg.Check("Battle5109") == false and digimon_id2 == 976 and enemy0_now_hp == 0 and enemy1_now_hp == 0 and 0 < enemy2_now_hp then
    Battle.SetCamera(0.18, 6.66, 14.88, 0.18, 4.69, 5.07, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, 40.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, 21.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, 27.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, 35.02, 0, 28.56)
    Battle.SetVisibleCharacter(ENEMY_DIGIMON, 0, true)
    Battle.SetModelPosition(ENEMY_DIGIMON, 2, 0, 0, 0)
    Dissolve_cnt = Dissolve_cnt + 1
    EFF_IN_02 = Dissolve_cnt
    Battle.LoadDissolveChangeOut(EFF_IN_02, ENEMY_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_02) do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_02)
    while Battle.IsPlayingDissolve(EFF_IN_02) do
      WaitFrame(1)
    end
    Battle.ExchangeQueueMember(ENEMY_DIGIMON, 2)
    Flg.Set("Battle5002")
    Flg.Set("Battle5109")
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_SUB_900_217_025")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(80, DIGIMON_GRASP_FLAG_SCAN)
  Common.SetDigimonGraspState(168, DIGIMON_GRASP_FLAG_SCAN)
  if Flg.Check("Battle5110") then
    Common.SetDigimonGraspState(169, DIGIMON_GRASP_FLAG_SCAN)
  elseif Flg.Check("Battle5109") then
    Common.SetDigimonGraspState(604, DIGIMON_GRASP_FLAG_SCAN)
  end
end
