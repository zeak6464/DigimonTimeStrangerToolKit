require("include_battle")
JYUREIMON = 98501
GUARD = 10012

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Battle.PlayBGM(928, 0)
end

function Battle_Start(info)
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(0.64, 4.14, 11.07, 0.17, 5.89, 1.23, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.MessageTalk(2030183001)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  if info.enemy_id == JYUREIMON then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, GUARD)
  end
end

function Battle_Command_Start(info)
end

function Battle_Action_Start(info)
  local kouan1_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  Round_HP = kouan1_hp
end

function Battle_Action_End(info)
  local belong_type = info.group
  local kouan1_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if belong_type == 0 or belong_type == 2 then
    if Flg.Check("Battle5001") == false then
      if kouan1_hp < Round_HP or kouan1_hp == 1 then
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(0.64, 4.14, 11.07, 0.17, 5.89, 1.23, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.MessageTalk(2030183002)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Round_HP = 0
        Flg.Set("Battle5001")
      end
    elseif Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
      if kouan1_hp < Round_HP or kouan1_hp == 1 then
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(0.64, 4.14, 11.07, 0.17, 5.89, 1.23, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.MessageTalk(2030183003)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Round_HP = 0
        Flg.Set("Battle5002")
      end
    elseif Flg.Check("Battle5002") and Flg.Check("Battle5003") == false and (kouan1_hp < Round_HP or kouan1_hp == 1) then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0.64, 4.14, 11.07, 0.17, 5.89, 1.23, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.MessageTalk(2030183004)
      WaitMessage()
      Battle.MessageTalk(2030183005)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Round_HP = 0
      Flg.Set("Battle5003")
      Flg.Set("FLAG_SUB_030_183_001")
      Battle.ForceEnd()
    end
  end
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
