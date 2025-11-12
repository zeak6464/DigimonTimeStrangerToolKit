require("include_battle")

function Battle_Before_Setup()
end

function Battle_After_Setup()
  SetEndrollMember(11800020)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Battle.PlayBGM(931, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 561301)
  Battle.AddBuff(PLAYER_DIGIMON, 3, 561303)
  Battle.AddBuff(PLAYER_DIGIMON, 4, 561303)
  Battle.AddBuff(PLAYER_DIGIMON, 5, 561303)
  Battle.AddBuff(GUEST_DIGIMON, 0, 561303)
  Battle.AddBuff(GUEST_DIGIMON, 1, 561303)
  Battle.AddBuff(GUEST_DIGIMON, 2, 561303)
  Battle.SetEscapeRate(100)
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
    Battle.SetForceEscapeFlag(false)
  end
end

function Battle_Round_Start(info)
  if Flg.Check("Battle5102") == false then
    Battle.SetFieldEffectSkill(29697, -1, -1)
    Flg.Set("Battle5102")
  end
end

function Battle_Turn_Start(info)
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) then
    Battle.SetForceEscapeFlag(true)
  end
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) == false then
    Battle.SetForceEscapeFlag(false)
  end
end

function Battle_Command_Start(info)
  local round_count = info.round
  if Battle.IsBuff(ENEMY_DIGIMON, 0, 107000, BUFF_CHECK_OR_WITHOUT_ID) then
    if info.group == 2 then
      if info.index == 0 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 46131)
      elseif info.index == 1 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 1, 46132)
      elseif info.index == 2 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 2, 46133)
      end
    end
  elseif info.group == 2 and info.index == 2 and round_count % 2 == 0 then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 2, 26015)
  end
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
  Common.SetDigimonGraspState(613, DIGIMON_GRASP_FLAG_SCAN)
end
