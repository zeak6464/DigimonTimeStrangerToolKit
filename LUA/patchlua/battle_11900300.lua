require("include_battle")

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
end

function Battle_After_Setup()
  SetEndrollMember(11900300)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  FadeAllInWithWait(FADE_BLACK, Util.SecondFromFrame(FADE_TIME))
  Battle.PlayBGM(931, 0)
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 90 < enemy_level then
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.SetStatus(GUEST_DIGIMON, 1, STATUS_TYPE_LV, 99)
  end
end

function Battle_Round_Start(info)
end

function Battle_Turn_Start(info)
  if info.group == GUEST_DIGIMON and info.index == 0 and not Battle.IsBuff(ENEMY_DIGIMON, 0, 114100, BUFF_CHECK_OR_WITHOUT_ID) then
    math.randomseed(os.time())
    local random = math.random(1, 2)
    if random == 1 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30253)
    else
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 30313)
    end
  end
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
  Flg.Set("FLAG_MAIN_22_465")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(435, DIGIMON_GRASP_FLAG_SCAN)
end
