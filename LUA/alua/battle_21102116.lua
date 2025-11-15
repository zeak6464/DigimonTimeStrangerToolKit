require("include_battle")
OBJ_01 = 1
OBJ_02 = 2

function Battle_Before_Setup()
  Battle.LoadObject(OBJ_01, "d0276floor00")
  Battle.LoadObject(OBJ_02, "d0276floor01")
end

function Battle_After_Setup()
end

function Battle_After_Build()
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.SetObjectVisible(OBJ_02, false)
end

function Battle_Opening(info)
  Battle.PlayBGM(215, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208004)
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  if Flgcount() >= 3 then
    Flg.Set("Battle5051")
  end
end

function Battle_Command_Start(info)
  if Flg.Check("Battle5051") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 27343)
    Flg.Clear("Battle5051")
    flgcount = 0
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
    Flg.Set("Battle5014")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_PHYSICAL, 0, ENEMY_DIGIMON, 0, 5) then
    Flg.Set("Battle5015")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_PLAYER_SIDE_TOTAL_DAMAGE_VALUE_OVER, 0, ENEMY_DIGIMON, 0, 10000) then
    Flg.Set("Battle5016")
  end
  for idx = 0, 2 do
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_HEAL_COUNT_OVER, 3, PLAYER_DIGIMON, idx, 3) then
      print("##### HP RECOVERY TWICE index = ", idx, " #####")
      Flg.Set("Battle5017")
      break
    end
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 27343 then
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
  end
end

function Flgcount()
  local flgcount = 0
  if Flg.Check("Battle5014") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5015") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5016") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5017") then
    flgcount = flgcount + 1
  end
  return flgcount
end

function Battle_Win(info)
  Flg.Set("FLAG_SUB_110_211_007")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(734, DIGIMON_GRASP_FLAG_SCAN)
end
