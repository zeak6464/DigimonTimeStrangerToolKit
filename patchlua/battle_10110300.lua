require("include_battle")
require("define")

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
  Common.LearnTamerSkill(201)
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  Battle.LoadAnimation(PLAYER_CHARA, 0, "bn01")
  SetEndrollMember(10110300)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m020_175")
    BtlPlayAnimation(PLAYER_CHARA, 0, "bn01", 0, true)
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(804, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  Battle.SetCameraMove(60, MODE_QUADRATIC_OUT)
  Battle.SetCameraMoveStart()
  Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
  WaitFrame(60)
  if Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.MessageTalk(1011030004)
    WaitMessage()
    Battle.MessageTalk(1011030005)
    WaitMessage()
    Battle.MessageTalk(1011030006)
    WaitMessage()
    Battle.MessageTalk(1011030007)
    WaitMessage()
    Battle.AddPlayerCP(1000)
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 10 < enemy_level then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30191, 30193)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30215, 30216)
  end
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
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
  local skill_id = Battle.GetLastActionSkillID()
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if 0 < enemy_now_hp then
    print("##### ENEMY ALIVE")
    if enemy_now_hp / enemy_max_hp <= 0.5 and Flg.Check("Battle5001") == false then
      print("##### ENEMY FRENZY")
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
      Battle.AddBuff(ENEMY_DIGIMON, 0, 129031)
      Talk.OpenLetterBox()
      Battle.CloseUI()
      BtlPlayAnimation(PLAYER_CHARA, 0, "bn01", 0, true)
      Battle.MessageTalk(1011030002)
      WaitMessage()
      Battle.MessageTalk(1011030003)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5001")
    end
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_01_260")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(367, DIGIMON_GRASP_FLAG_SCAN)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Sound.StopBGM(1)
  Execute("m020_180")
end
