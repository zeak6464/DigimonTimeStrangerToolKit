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
  if Guest.IsExist(GST_HANGYO) then
    Flg.Set("FLAG_SUB_020_014_004")
  else
    Flg.Set("FLAG_SUB_060_053_004")
  end
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
