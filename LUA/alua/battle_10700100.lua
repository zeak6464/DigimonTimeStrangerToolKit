require("include_battle")
EFF_01 = 1

function Battle_Before_Setup()
  Battle.LoadEffectScript(EFF_01, "ef_b_bos_119")
  Battle.LoadTalk("battle")
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(10700100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m190_021")
    Battle.SetCameraMove(60, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
    WaitFrame(60)
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(15))
  end
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local hp = math.ceil(enemy_max_hp * 0.7)
  Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
  Sound.PlayBGM(207, 0.5)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  local round_count = info.round
  if 2 <= round_count and Flg.Check("Battle5001") == false then
    local turn_group = Battle.GetTurnCharacterGroup()
    if turn_group == 0 then
      Talk.OpenLetterBox()
      Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
      Battle.CloseUI()
      Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
      Battle.MessageTalk(1070010001)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Battle.SetEffectScriptLoop(EFF_01, false)
      Battle.PlayEffectScript(EFF_01, 0)
      Battle.SetEffectScriptPosition(EFF_01, 0.11, 0, -7.57)
      Battle.SetFieldEffectSkill(29621, ENEMY_DIGIMON, 0)
      Flg.Set("Battle5001")
    end
  end
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
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_07_015")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(423, DIGIMON_GRASP_FLAG_SCAN)
end
