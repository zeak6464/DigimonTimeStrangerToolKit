require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
  SetEndrollMember(11900500)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  Battle.PlayBGM(204, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 90 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
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
  Flg.Set("FLAG_MAIN_22_200")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(385, DIGIMON_GRASP_FLAG_SCAN)
end
