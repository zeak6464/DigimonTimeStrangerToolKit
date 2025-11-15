require("include_battle")
Round = 0

function Battle_Before_Setup()
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
end

function Battle_After_Build()
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "bn01")
end

function Battle_Opening(info)
end

function Battle_Start(info)
end

function Battle_Round_Start(info)
  if Common.IsExistGuest(23991) then
    if Flg.Check("Battle5002") then
      Round = Round + 1
      print("Round:", Round)
    end
    if Round == 6 then
      Flg.Clear("Battle5001")
      Flg.Clear("Battle5002")
      Flg.Clear("Battle5003")
    end
  end
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
  print("##### Battle_Command_Start #####")
  print("#### Round:", info.round, " ####")
  print("#### group:", info.group, " ####")
  print("#### index:", info.index, " ####")
  if Common.IsExistGuest(23991) and Flg.Check("Battle5001") and Flg.Check("Battle5003") == false and info.group == 2 and info.index == 0 then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(5.28, 0.81, 2.59, 12.96, 0.3, 8.97, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, 7.74, 0, 4.65)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, -30.02, 0, 28.56)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -31.16, 0, 27)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -37.71, 0, 28.56)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -32.49, 0, 9.24)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, true)
    WaitFrame(60)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "bn01", 10, true)
    Battle.MessageTalk(1120001020)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5003")
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  if Common.IsExistGuest(23991) then
    local skill_id = Battle.GetCharacterLastCommandSkillID(GUEST_DIGIMON, 0)
    if skill_id == 43992 then
      Round = 0
      Flg.Set("Battle5002")
    end
    if Flg.Check("FLAG_MAIN_14_020") == false and Flg.Check("Battle5001") == false then
      math.randomseed(os.time())
      local random = 0
      if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, GUEST_DIGIMON, 0, 1) then
        random = math.random(1, 3)
      elseif Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, GUEST_DIGIMON, 0, 2) then
        random = math.random(1, 2)
      end
      if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_BUFF_COUNT_OVER, 0, GUEST_DIGIMON, 0, 3) then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43992)
        Flg.Set("Battle5001")
      elseif random == 1 then
        Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 43992)
        Flg.Set("Battle5001")
      end
    end
  end
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end
