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
    Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_ESCAPE, true)
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m010_120")
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m010_130")
    Battle.ResetFormation(false)
    Battle.ModelSetBattleScale(PLAYER_DIGIMON, 0)
    BtlPlayAnimation(PLAYER_DIGIMON, 0, "bn01", 0, true)
    BtlPlayAnimation(PLAYER_CHARA, 0, "bn01", 0, true)
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(927, 0)
  end
end

function Battle_Start(info)
  if Common.GetGameClearNum() == 0 then
    if Flg.Check("FLAG_MAIN_01_070") == false then
      Battle.SetCamera(1.699301, 1.170352, 3.758456, -0.006511, 1.039225, 4.421243, 36, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetCameraMove(90, 11)
      Battle.SetCameraMoveStart()
      Battle.SetBattleCamera(3, PLAYER_CHARA, 0)
      WaitFrame(90)
    end
  elseif Common.GetGameClearNum() >= 1 then
    WaitFrame(60)
    Fade.In(1, Util.SecondFromFrame(30))
  end
end

function Battle_Round_Start(info)
  if Flg.Check("TUT_FLAG_4503") == false then
    Battle.CloseUI()
    OpenTutorial(1003)
    Flg.Set("TUT_FLAG_4503")
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
  if Flg.Check("FLAG_MAIN_01_070") == false then
    Flg.Set("FLAG_MAIN_01_070")
  end
  Flg.Set("TUT_FLAG_4503")
  Flg.Set("TUT_FLAG_4505")
  Flg.Set("TUT_FLAG_4506")
  Flg.Set("TUT_FLAG_4507")
  Flg.Set("TUT_FLAG_4515")
  Flg.Set("TUT_FLAG_4517")
  Flg.Set("TUT_FLAG_4518")
  Flg.Set("TUT_FLAG_4519")
  Flg.Set("TUT_FLAG_4502")
  Flg.Set("TUT_FLAG_4530")
  Flg.Set("TUT_FLAG_4602")
  Flg.Set("TUT_FLAG_4604")
  Flg.Set("TUT_FLAG_4624")
  Flg.Set("TUT_FLAG_4625")
  Flg.Set("TUT_FLAG_4520")
  Flg.Set("TUT_FLAG_4521")
  Flg.Set("TUT_FLAG_4522")
  Flg.Set("TUT_FLAG_4523")
  Flg.Set("TUT_FLAG_4525")
  Flg.Set("TUT_FLAG_4526")
  Flg.Set("TUT_FLAG_4527")
  Flg.Set("TUT_FLAG_4528")
  Flg.Set("TUT_FLAG_4529")
  Flg.Set("TUT_FLAG_4531")
  Flg.Set("TUT_FLAG_4532")
  Flg.Set("TUT_FLAG_4533")
  Flg.Set("TUT_FLAG_4534")
  Flg.Set("TUT_FLAG_4535")
  Flg.Set("TUT_FLAG_4537")
  Flg.Set("TUT_FLAG_4538")
  Flg.Set("TUT_FLAG_4539")
  Flg.Set("TUT_FLAG_4540")
  Flg.Set("TUT_FLAG_4541")
  Flg.Set("TUT_FLAG_4606")
  Flg.Set("TUT_FLAG_4607")
  Flg.Set("TUT_FLAG_4608")
  Flg.Set("TUT_FLAG_4609")
  Flg.Set("TUT_FLAG_4610")
  Flg.Set("TUT_FLAG_4611")
  Flg.Set("TUT_FLAG_4616")
  Flg.Set("TUT_FLAG_4617")
  Flg.Set("TUT_FLAG_4623")
  Flg.Set("TUT_FLAG_4701")
  Flg.Set("TUT_FLAG_4710")
  Flg.Set("TUT_FLAG_4734")
  Flg.Set("TUT_FLAG_4903")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
