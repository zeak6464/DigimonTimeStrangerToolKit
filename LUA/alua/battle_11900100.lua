require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.SetFlexiblePartyByControlGuestOnly(11691)
end

function Battle_After_Setup()
  SetEndrollMember(11900100)
  Battle.SetCharacterSettingFlag(PLAYER_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_After_Build()
  Battle.SetIsGiantWeaponBattle(true)
end

function Battle_Opening(info)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m430_030")
  Battle.ResetFormation(false)
  Fade.AllIn(FADE_WHITE, Util.SecondFromFrame(30), 1, 0)
  Battle.SetCamera(19.7615, 119.8661, 4.1582, 2.7345, 135.8341, -37.1493, 60, 0, 11)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  local player_HP_MAX = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local player_HP = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_HP)
  local player_ATTACK = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_ATTACK)
  local player_DEFFENCE = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_DEFFENCE)
  local player_INTELIGENCE = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_INTELIGENCE)
  local player_MENTAL = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_MENTAL)
  local player_SPEED = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_SPEED)
  if 60 < enemy_level then
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_LV, enemy_level)
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_HP_MAX, player_HP_MAX * 6)
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_HP, player_HP * 6)
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_ATTACK, player_ATTACK * 6)
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_DEFFENCE, player_DEFFENCE * 1.6)
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_INTELIGENCE, player_INTELIGENCE * 6)
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_MENTAL, player_MENTAL * 1.6)
    Battle.SetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_SPEED, player_SPEED * 3)
  end
  Battle.SetCameraMove(60, MODE_QUADRATIC_IN_OUT)
  Battle.SetCameraMoveStart()
  Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_DIGIMON, 0)
  WaitFrame(60)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
  Battle.SetBattleSpeed(BATTLE_SPEED_NORMAL)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_21_040")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m430_040")
  Battle.ResetFlexibleParty()
end
