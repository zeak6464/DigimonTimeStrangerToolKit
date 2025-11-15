require("include_battle")
Round = 0

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "fe04")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "e514")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
  Battle.LoadAnimation(GUEST_DIGIMON, 1, "fe02")
  Battle.LoadAnimation(GUEST_DIGIMON, 1, "bn01")
  SetEndrollMember(10510900)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(929, 0)
end

function Battle_Start(info)
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(3.668, 4.113, 15.105, 0.86, 1.996, 5.744, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.MessageTalk(1051090001)
  WaitMessage()
  Battle.SetCamera(-2.23, 0.21, 22.95, 2.18, 1.89, 31.76, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.SetModelPosition(GUEST_DIGIMON, 0, -1.16, -0.25, 27.62)
  Battle.SetModelRotationY(GUEST_DIGIMON, 0, 180)
  Battle.SetModelPosition(GUEST_DIGIMON, 1, 1.06, 1.05, 28.1)
  Battle.SetModelRotationY(GUEST_DIGIMON, 1, 180)
  WaitFrame(1)
  BtlPlayAnimation(GUEST_DIGIMON, 0, "fe04", 0, false)
  WaitFrame(17)
  BtlPlayAnimation(GUEST_DIGIMON, 0, "e514", 0, false)
  Battle.SetLoopFrameAnimation(GUEST_DIGIMON, 0, "e514", 0, 60)
  Battle.MessageTalk(1051090002)
  WaitMessage()
  Battle.MessageTalk(1051090003)
  WaitMessage()
  Battle.ClearLoopFrameAnimation(GUEST_DIGIMON, 0, "e514")
  BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 10, true)
  BtlPlayAnimation(GUEST_DIGIMON, 1, "fe02", 0, false)
  WaitFrame(42)
  BtlPlayAnimation(GUEST_DIGIMON, 1, "bn01", 10, true)
  Battle.MessageTalk(1051090004)
  WaitMessage()
  Battle.MessageTalk(1051090005)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
end

function Battle_Round_Start(info)
  local round_count = info.round
  if round_count == 1 then
    BtlSetInterruptCharacter(GUEST_DIGIMON, 1, BATTLE_INTERRUPT_TYPE_NORMAL)
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 21451)
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
  if Flg.Check("Battle5101") == false and info.group == 2 and info.index == 1 then
    BtlSetInterruptCharacter(GUEST_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 26061)
    Flg.Set("Battle5101")
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_05_098")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(605, DIGIMON_GRASP_FLAG_SCAN)
end
