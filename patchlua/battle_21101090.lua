require("include_battle")
local Is_Talk = "Battle5301"

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "fe04")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(215, 0)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Start(info)
  if not Flg.Check(Is_Talk) then
    Flg.Set(Is_Talk)
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(2.22, 1.63, -0.34, -1.7, 1.15, -9.53, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "fe04", 0, false)
    WaitFrame(70)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
    Battle.MessageTalk(2110109001)
    WaitMessage()
    Battle.MessageTalk(2110109002)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
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
  Flg.Set("FLAG_SUB_110_109_002")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
