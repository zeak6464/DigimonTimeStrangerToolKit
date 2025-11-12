require("include_battle")

function Battle_Before_Setup()
  if Flg.Check("FLAG_MAIN_01_070") == false then
    Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_FIRST_BACK_ATTACK, true)
    Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_BATTLE_IN_DIRECTION, true)
  end
end

function Battle_After_Setup()
  if Flg.Check("FLAG_MAIN_01_070") == false then
    Battle.SetPlayerFormationId(804)
  else
    Battle.SetOverwriteCamera("battle_camera_setting")
  end
end

function Battle_After_Build()
end

function Battle_Opening(info)
  if Flg.Check("FLAG_MAIN_01_070") == false and Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m010_120")
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m010_130")
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(927, 0)
  end
end

function Battle_Start(info)
  if Flg.Check("FLAG_MAIN_01_070") == false then
    Battle.SetCamera(1.699301, 0.576839, 3.758456, -0.006511, 0.445711, 4.421243, 36, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetCameraMove(90, 11)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(3, PLAYER_CHARA, 0)
    WaitFrame(90)
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
end

function Battle_Win(info)
  if Flg.Check("FLAG_MAIN_01_070") == false then
    Flg.Set("FLAG_MAIN_01_070")
  end
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
