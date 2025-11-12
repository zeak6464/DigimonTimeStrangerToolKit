require("include_battle")
Round = 0
OBJ_01 = 1

function Battle_Before_Setup()
end

function Battle_After_Setup()
  Battle.LoadObject(OBJ_01, "t0171walltile00")
  Battle.LoadObjectAnimation(OBJ_01, "e001")
  Battle.LoadObjectAnimation(OBJ_01, "e002")
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.PlayObjectAnimation(OBJ_01, "e001", false)
  Battle.SetObjectPosition(OBJ_01, 16.8, 16.2, -3.3)
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
  Flg.Set("FLAG_SUB_SEEKDRKUGA_103")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
