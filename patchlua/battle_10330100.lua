require("include_battle")
CP_Round = 0
Round = 0
OBJ_01 = 1
local is_high_difficulty = false

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(PLAYER_CHARA, 0, "e004")
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn02")
  Battle.LoadObject(OBJ_01, "t0171walltile00")
  Battle.LoadObjectAnimation(OBJ_01, "e001")
  Battle.LoadObjectAnimation(OBJ_01, "e002")
  SetEndrollMember(10330100)
end

function Battle_After_Build()
  if Common.GetGameClearNum() == 0 then
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  end
end

function Battle_Opening(info)
  Sound.StopBGM(0)
  if Flg.Check("Battle5499") == false then
    Fade.OutNotLoading(0, Util.SecondFromFrame(0))
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m090_040")
    Battle.SetObjectVisible(OBJ_01, true)
    Battle.PlayObjectAnimation(OBJ_01, "e002", false)
    Battle.SetObjectPosition(OBJ_01, 16.8, 16.2, -3.3)
    Battle.SetCharacterSettingFlag(GUEST_DIGIMON, 0, BATTLE_CHARACTER_SETTING_TURN_ORDER_BOTTOM, true)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_TURN_ORDER_BOTTOM, true)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29132)
    FadeAllIn(FADE_BLACK, FADE_TIME)
  elseif Flg.Check("Battle5499") then
    Battle.SetObjectVisible(OBJ_01, true)
    Battle.PlayObjectAnimation(OBJ_01, "e002", false)
    Battle.SetObjectPosition(OBJ_01, 16.8, 16.2, -3.3)
    Battle.SetCharacterSettingFlag(GUEST_DIGIMON, 0, BATTLE_CHARACTER_SETTING_TURN_ORDER_BOTTOM, true)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_TURN_ORDER_BOTTOM, true)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29132)
    Battle.PlayBGM(204, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  local enemy_level = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_LV)
  if 50 < enemy_level then
    is_high_difficulty = true
    Battle.SetStatus(GUEST_DIGIMON, 0, STATUS_TYPE_LV, 99)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30184, 30186)
  end
end

function Battle_Round_Start(info)
  print("=========== Battle_Round_Start round = ", info.round, " ===========")
  if Flg.Check("Battle5105") and Flg.Check("Battle5101") and Flg.Check("Battle5102") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.91, 0.14, 17.64, -0.47, 3, 9.06, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 27.16, 0, 15.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -21.71, 0, 13.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -30.57, 0, 15.06)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -1.89, 0, 13.95)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -0.32, 0, 14.95)
    Battle.MessageTalk(1033010006)
    WaitMessage()
    Battle.MessageTalk(1033010007)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    if Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP) == 1 then
      Flg.Set("Battle5051")
    end
    Flg.Set("Battle5102")
  end
  if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
    CP_Round = CP_Round + 1
  end
  if Flg.Check("Battle5053") then
    Round = Round + 1
  end
  if is_high_difficulty == true and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70007 then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  end
end

function Battle_Turn_Start(info)
  print("=========== Battle_Turn_Start digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " group = ", info.group, " ===========")
  if Flgcount() >= 3 and info.round > 2 then
    Flg.Set("Battle5051")
  end
  local enemy_id = info.enemy_id
  if enemy_id == 91301 and Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  local guest_id = info.digimon_id
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 27471)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 and info.group == 2 and info.index == 0 then
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 29131)
    if Flg.Check("Battle5109") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
      Battle.SetCameraMoveStart()
      Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
      Battle.MessageTalk(1033010013)
      WaitMessage()
      Battle.MessageTalk(1033010014)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5109")
    end
  end
end

function Battle_Command_Start(info)
  print("=========== Battle_Command_Start digimon_id = ", info.digimon_id, " enemy_id = ", info.enemy_id, " group = ", info.group, " ===========")
  local enemy_id = info.enemy_id
  if info.group == 2 and info.index == 0 and Flg.Check("Battle5107") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.91, 0.14, 17.64, -0.47, 3, 9.06, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 27.16, 0, 15.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -21.71, 0, 13.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -30.57, 0, 15.06)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -1.89, 0, 13.95)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 0, false)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -0.32, 0, 14.95)
    Battle.MessageTalk(1033010010)
    WaitMessage()
    Battle.MessageTalk(1033010011)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5107")
    Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 27471)
    Battle.SetBattleSpeedToNormalForTurn()
    Battle.SetCharacterSettingFlag(GUEST_DIGIMON, 0, BATTLE_CHARACTER_SETTING_TURN_ORDER_BOTTOM, false)
    Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_TURN_ORDER_BOTTOM, false)
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5053") == false and enemy_id == 91301 and Battle.IsTurnCharacterExtraTurn() == false then
    Battle.SetupCPCharge(70003, 91401, ENEMY_DIGIMON, 0, "FP01", 2)
    Flg.Set("Battle5053")
    Round = 0
    if Flg.Check("Battle5106") == false then
      Flg.Set("Battle5106")
    end
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
  end
  if enemy_id == 91301 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(400)
    else
      Battle.AddEnemyCP(800)
    end
  end
  print("Round:", Round)
  if Round == 2 and Flg.Check("Battle5053") and enemy_id == 91301 then
    AddTarget_nobreakHP()
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
end

function Battle_Action_Start(info)
  local AddTarget_HP_MAX = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5053") and Flg.Check("Battle5300") == false and Flg.Check("Battle5399") and Round == 0 then
    if Flg.Check("Battle5351") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX * 0.75)
      Flg.Clear("Battle5351")
      Flg.Clear("Battle5399")
    elseif Flg.Check("Battle5352") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX * 0.5)
      Flg.Clear("Battle5352")
      Flg.Clear("Battle5399")
    elseif Flg.Check("Battle5353") then
      Battle.SetStatus(ADD_TARGET, 0, STATUS_TYPE_HP, AddTarget_HP_MAX * 0.25)
      Flg.Clear("Battle5353")
      Flg.Clear("Battle5399")
    end
    Flg.Set("Battle5300")
  end
  if info.group == ENEMY_DIGIMON and info.enemy_id == 91301 then
    local skill_id = Battle.GetLastCommandSkillID()
    if skill_id == 29131 and info.use_count == 0 then
      Battle.SetBattleSpeedToNormalForTurn()
    end
  end
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  local enemy_id = info.enemy_id
  if enemy_last_skill_id == 70001 then
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  if Battle.GetCharacterLastCommandSkillID(GUEST_DIGIMON, 0) == 27471 and Flg.Check("Battle5108") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-1.83, 1.09, 20.74, -2.75, 0, 30.8, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -1.99, 0, 21.96)
    Battle.SetModelTargetRotation(GUEST_DIGIMON, 0, ENEMY_DIGIMON, 0)
    Battle.MessageTalk(1033010012)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Battle.ResetModelRotationY(GUEST_DIGIMON, 0)
    Flg.Set("Battle5108")
  end
  if enemy_id == 91301 and enemy_last_skill_id == 29132 then
    print("##### AddEnemyCP #####")
    Battle.AddEnemyCP(1000)
  end
end

function Battle_Turn_End(info)
  print("=========== Battle_Turn_End ===========")
  local enemy_id = info.enemy_id
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  local skill_id = Battle.GetLastActionSkillID()
  print("##### enemy_last_skill_id = ", enemy_last_skill_id, " #####")
  print("##### skill_id = ", skill_id, " #####")
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local AddTarget_HP_MAX = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  if enemy_id == 91301 and Flg.Check("Battle5111") and enemy_last_skill_id ~= 70007 then
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Flg.Clear("Battle5111")
  end
  local stock_num = Battle.GetCPStockNum()
  if stock_num == 0 or Flg.Check("Battle5051") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  elseif stock_num == 1 and Flg.Check("Battle5053") == false then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 10011)
    if Flg.Check("Battle5105") == false then
      Flg.Set("Battle5105")
    end
  elseif stock_num == 2 and Flg.Check("Battle5053") == false then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30184)
  elseif 3 <= stock_num and Flg.Check("Battle5053") == false then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 29132)
  end
  local round_count = info.round
  if round_count == 6 and Flg.Check("Battle5103") == false then
    Flg.Set("Battle5011")
  end
  if CP_Round == 6 then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 4) then
    Flg.Set("Battle5014")
  end
  local weak_damage_num = enemy_max_hp * 0.13
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, weak_damage_num) then
    Flg.Set("Battle5015")
  end
  local all_damage_num = enemy_max_hp * 0.2
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, all_damage_num) then
    Flg.Set("Battle5016")
  end
  if enemy_id == 91301 and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.91, 0.14, 17.64, -0.47, 3, 9.06, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 27.16, 0, 15.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -21.71, 0, 13.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -30.57, 0, 15.06)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -1.89, 0, 13.95)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 0, false)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -0.32, 0, 14.95)
    Battle.MessageTalk(1033010005)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if Flg.Check("Battle5106") and Flg.Check("Battle5103") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.91, 0.14, 17.64, -0.47, 3, 9.06, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(PLAYER_DIGIMON, 0, 27.16, 0, 15.06)
    Battle.SetModelPosition(PLAYER_DIGIMON, 1, -21.71, 0, 13.5)
    Battle.SetModelPosition(PLAYER_DIGIMON, 2, -30.57, 0, 15.06)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -1.89, 0, 13.95)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 0, false)
    Battle.SetModelPosition(PLAYER_CHARA, 0, -0.32, 0, 14.95)
    Battle.MessageTalk(1033010001)
    WaitMessage()
    Battle.MessageTalk(1033010003)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5103")
    if Common.GetGameClearNum() == 0 then
      Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
    end
  end
  if 1 <= enemy_now_hp and Battle.IsBreakCPCharge() and Flg.Check("Battle5104") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn02", 0, true)
    Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
    Battle.MessageTalk(1033010009)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5104")
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 591301)
    Flg.Set("Battle5201")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30184, 30185)
    end
    Flg.Set("Battle5203")
  end
  if enemy_last_skill_id == 29131 then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5052")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Round = 0
    CP_Round = 0
    if stock_num < 1 and Flg.Check("Battle5201") then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 591301)
      Flg.Clear("Battle5201")
    end
    if stock_num < 3 and Flg.Check("Battle5203") then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30184, -1)
      Flg.Clear("Battle5203")
    end
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  end
  if Battle.IsBreakCPCharge() then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5052")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 591301)
    if not is_high_difficulty then
      Battle.UpgradeSkill(ENEMY_DIGIMON, 0, 30184, -1)
    end
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Round = 0
    CP_Round = 0
    Battle.ClearCPCharge()
    Flg.Set("Battle5111")
  end
end

function Flgcount()
  local flgcount = 0
  if Flg.Check("Battle5011") then
    flgcount = flgcount + 3
  end
  if Flg.Check("Battle5012") then
    flgcount = flgcount + 3
  end
  if Flg.Check("Battle5013") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5014") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5015") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5016") then
    flgcount = flgcount + 1
  end
  return flgcount
end

function AddTarget_nobreakHP()
  local AddTarget_HP_MAX = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  local AddTarget_HP_ratio = AddTarget_HP / AddTarget_HP_MAX
  if AddTarget_HP_ratio < 0.25 then
    Flg.Set("Battle5353")
    Flg.Set("Battle5399")
  elseif AddTarget_HP_ratio < 0.5 then
    Flg.Set("Battle5352")
    Flg.Set("Battle5399")
  elseif AddTarget_HP_ratio < 0.75 then
    Flg.Set("Battle5351")
    Flg.Set("Battle5399")
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_03_280")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  if Flg.Check("FLAG_DLC17_IS_INDICATIONS") then
    Common.SetDigimonGraspState(712, DIGIMON_GRASP_FLAG_SCAN)
  end
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m090_060")
end
