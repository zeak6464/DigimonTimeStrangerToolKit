require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(929, 0)
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 90 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.SetStatus(GUEST_DIGIMON, 1, STATUS_TYPE_LV, 99)
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
