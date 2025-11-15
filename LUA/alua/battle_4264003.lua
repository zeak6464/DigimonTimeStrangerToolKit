require("include_battle")

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  SetEndrollMember(4264003)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(931, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
end

function Battle_Round_Start(info)
  if Flg.Check("FLAG_IS_CLEAR_S070_056") and Flg.Check("Battle5001") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(0.87, 0.92, 8.36, 0.14, 2.04, -1.54, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 1.29, 0, 7.46)
    Battle.SetModelRotationY(GUEST_DIGIMON, 0, 190)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 28.48, 0, 9.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -20.39, 0, 7.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -29.25, 0, 9.06)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -10.45, 0, 16.8)
    Battle.SetModelPosition(GUEST_AEGIOMON, 0, -11.44, 0, 14.56)
    Battle.MessageTalk(426400301)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5001")
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
  Flg.Set("FLAG_MAIN_22_495")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(775, DIGIMON_GRASP_FLAG_SCAN)
end
