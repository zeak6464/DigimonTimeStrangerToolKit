require("include_battle")

function Battle_Before_Setup()
  BtlSetFlexiblePartyByAegiomonOnly(true)
end

function Battle_After_Setup()
  SetEndrollMember(10400030)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.AllIn(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  Sound.PlayBGM(929, 0)
end

function Battle_Start(info)
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
  Flg.Set("FLAG_MAIN_04_085")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(341, DIGIMON_GRASP_FLAG_SCAN)
  Battle.ResetFlexibleParty()
end
