require("include_battle")

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
end

function Battle_After_Build()
end

function Battle_Opening(info)
end

function Battle_Start(info)
  local power_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  Round_HP = power_hp
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
  local power_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if power_hp < Round_HP and Flg.Check("Battle5001") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(3.73, 1.46, 4.93, 0.43, 3.25, -4.33, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(2010157001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5001")
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_SUB_010_157_002")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
