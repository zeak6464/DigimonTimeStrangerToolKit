require("battle_define")

function Battle_Before_Setup_Base()
  Battle_Before_Setup()
end

function Battle_After_Setup_Base()
  Battle_After_Setup()
end

function Battle_After_Build_Base()
  Battle_After_Build()
end

function Battle_Opening_Base(info)
  for i = 0, 489 do
    Flg.Clear("Battle5" .. string.format("%03d", i))
  end
  Battle_Opening(info)
end

function Battle_Start_Base(info)
  Battle_Start(info)
end

function Battle_Round_Start_Base(info)
  Battle_Round_Start(info)
end

function Battle_Turn_Start_Base(info)
  Battle_Turn_Start(info)
end

function Battle_Command_Start_Base(info)
  Battle_Command_Start(info)
end

function Battle_Action_Start_Base(info)
  Battle_Action_Start(info)
end

function Battle_Action_End_Base(info)
  Battle_Action_End(info)
end

function Battle_Command_End_Base(info)
  Battle_Command_End(info)
end

function Battle_Turn_End_Base(info)
  Battle_Turn_End(info)
end

function Battle_Win_Base(info)
  Battle_Win(info)
end

function Battle_Lose_Base(info)
  Battle_Lose(info)
end

function Battle_Ending_Base(info)
  Battle_Ending(info)
end
