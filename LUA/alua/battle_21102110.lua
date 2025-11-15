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
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  print("stock_num:", stock_num)
  if stock_num == 1 and Flg.Check("Battle5001") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597208)
    Flg.Set("Battle5001")
  elseif stock_num == 2 and Flg.Check("Battle5002") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597208)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597203)
    Flg.Set("Battle5002")
  elseif stock_num == 3 and Flg.Check("Battle5003") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597208)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597203)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597209)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597210)
    Flg.Set("Battle5003")
  elseif stock_num == 4 and Flg.Check("Battle5004") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597208)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597203)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597209)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597210)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597201)
    Flg.Set("Battle5004")
  elseif 5 <= stock_num and Flg.Check("Battle5005") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597208)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597203)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597209)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597210)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597201)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597207)
    Flg.Set("Battle5005")
  end
end

function Battle_Turn_Start(info)
end

function Battle_Command_Start(info)
  local Highest_HP_INDEX = Check_HP_INDEX()
  if Battle.IsTurnCharacterExtraTurn() == true then
    print("####### Extra_Turn_Start #######")
    if enemy_id == 97201 then
      if Flg.Check("Battle5001") or Flg.Check("Battle5002") == true then
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 20887)
        if Highest_HP_INDEX == 0 then
          Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 0)
        elseif Highest_HP_INDEX == 1 then
          Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 1)
        else
          Battle.SetNextCommandTarget(ENEMY_DIGIMON, 0, PLAYER_DIGIMON, 2)
        end
      else
        Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 20886)
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 20886)
      end
    end
  end
end

function Battle_Action_Start(info)
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local stock_num = Battle.GetCPStockNum()
  print("stock_num:", stock_num)
  if 1 <= stock_num then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
  elseif stock_num == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if Battle.IsTurnCharacterExtraTurn() == true then
    if Flg.Check("Battle5001") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597208)
      Flg.Clear("Battle5001")
    elseif Flg.Check("Battle5002") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597208)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597203)
      Flg.Clear("Battle5002")
    elseif Flg.Check("Battle5003") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597208)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597203)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597209)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597210)
      Flg.Clear("Battle5003")
    elseif Flg.Check("Battle5004") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597208)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597203)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597209)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597210)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597201)
      Flg.Clear("Battle5004")
    elseif Flg.Check("Battle5005") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597208)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597203)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597209)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597210)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597201)
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597207)
      Flg.Clear("Battle5005")
    end
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_SUB_110_211_001")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(88, DIGIMON_GRASP_FLAG_SCAN)
end

function Check_HP_INDEX()
  local now_HP_0 = Battle.GetStatus(PLAYER_DIGIMON, 0, STATUS_TYPE_HP)
  local now_HP_1 = Battle.GetStatus(PLAYER_DIGIMON, 1, STATUS_TYPE_HP)
  local now_HP_2 = Battle.GetStatus(PLAYER_DIGIMON, 2, STATUS_TYPE_HP)
  local Check_HP = 0
  if 0 < now_HP_0 and now_HP_0 >= now_HP_1 and now_HP_0 >= now_HP_2 then
    Check_HP = 0
  elseif 0 < now_HP_1 and now_HP_0 <= now_HP_1 and now_HP_1 >= now_HP_2 then
    Check_HP = 1
  elseif 0 < now_HP_2 and now_HP_0 <= now_HP_2 and now_HP_1 <= now_HP_2 then
    Check_HP = 2
  end
  print("Check_HP_INDEX:", Check_HP)
  return Check_HP
end
