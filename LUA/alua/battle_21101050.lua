require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(929, 0.5)
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
  if not Flg.Check("FLAG_SUB_110_105_010") then
    Flg.Set("FLAG_SUB_110_105_010")
  elseif Flg.Check("FLAG_SUB_110_105_010", "FLAG_SUB_110_105_011") then
    Flg.Set("FLAG_SUB_110_105_011")
  elseif Flg.Check("FLAG_SUB_110_105_011", "FLAG_SUB_110_105_012") then
    Flg.Set("FLAG_SUB_110_105_012")
  end
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
