require("include_battle")
EFF_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "fn01_01")
  Battle.LoadEffectScript(EFF_01, "ef_b_bos_550")
  SetEndrollMember(11600200)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  Sound.PlayBGM(930, 0)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  Flg.Clear("Battle5003")
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_id == 80601 and enemy_now_hp / enemy_max_hp < 0.3 and Flg.Check("Battle5001") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(0.5, 5.14, -5.49, -1.13, 3.9, -15.27, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    WaitFrame(1)
    Battle.SetCamera(0.1, 5.1, -7.22, -2.14, 6.95, -16.79, DEFAULT_ANGLE, 30, MODE_QUADRATIC_IN_OUT)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "fn01_01", 0, true)
    WaitFrame(31)
    Battle.MessageTalk(1160020001)
    WaitMessage()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Battle.SetCamera(6.45, 3.62, -2.98, -0.26, 2.39, -10.28, DEFAULT_ANGLE, 90, MODE_QUADRATIC_IN_OUT)
    WaitFrame(50)
    Sound.PlaySE(200015, 100)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 10, false, 50)
    WaitFrame(40)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
    Battle.MessageTalk(1160020002)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28064)
    Flg.Set("Battle5001")
  end
  if enemy_id == 80601 and Flg.Check("Battle5002") then
    if round_count % 4 == 0 and Flg.Check("Battle5003") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28063)
      Flg.Set("Battle5003")
    else
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28061)
    end
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 28064 and Flg.Check("Battle5002") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(4.91, 3.29, -3.32, -0.74, 3.3, -11.57, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetEffectScriptLoop(EFF_01, true)
    Battle.PlayEffectScript(EFF_01, 0.4)
    Battle.AttatchEffectScriptToModelJoint(EFF_01, ENEMY_DIGIMON, 0, "J_weapon_l")
    Battle.MessageTalk(1160020003)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5002")
  end
end

function Battle_Turn_End(info)
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_17_080")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m390_100")
end
