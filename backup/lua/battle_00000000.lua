require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  print("=========== Battle_Round_Start ===========")
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
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
