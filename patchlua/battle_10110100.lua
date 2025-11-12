require("include_battle")
require("define")

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(10110100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m020_030")
    Battle.ResetFormation(false)
  elseif Flg.Check("Battle5499") then
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  Battle.PlayBGM(204, 0)
  Battle.SetCamera(17.1298, 6.6255, 13.541, 12.8461, 10.0216, 3.1739, 45, 0, MODE_QUADRATIC_IN_OUT)
  Battle.SetCameraMove(90, 11)
  Battle.SetCameraMoveStart()
  Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_CHARA, 0)
  WaitFrame(90)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 10 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.UpgradeSkill(GUEST_DIGIMON, 0, 20883, 20886)
  end
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70010 and info.group == 0 and Flg.Check("Battle5001") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_ACTION_ENEMY_NET, PLAYER_DIGIMON, 0)
    Battle.MessageTalk(1011010001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Window.OpenInfo(10110100)
    WaitFrame(1)
    while not Window.IsNextInfo() do
      WaitFrame(1)
    end
    Window.CloseInfo()
    WaitFrame(1)
    while not Window.IsEndCloseInfo() do
      WaitFrame(1)
    end
    Item.Add(1, 5)
    Battle.CloseUI()
    OpenTutorial(1027)
    Flg.Set("Battle5001")
  end
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
  if info.group == GUEST_DIGIMON and info.digimon_id == 972 then
    local skill_id = Battle.GetLastCommandSkillID()
    if (skill_id == 20883 or skill_id == 20885) and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_01_160")
  Battle.DeleteMember(GUEST_DIGIMON, 0)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(88, DIGIMON_GRASP_FLAG_SCAN)
  if Flg.Check("FLAG_DLC17_IS_INDICATIONS") then
    Common.SetDigimonGraspState(327, DIGIMON_GRASP_FLAG_SCAN)
  end
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Sound.StopBGM(1)
  Execute("m020_050")
end
