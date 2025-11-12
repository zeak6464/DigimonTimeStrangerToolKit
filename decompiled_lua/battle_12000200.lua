require("include_battle")
Round = 0
Round_cp = 0
Round_ph = 0
Round_ph3 = 0
Round_ph4 = 0
Round_ph0 = 0
OBJ_01 = 1
OBJ_02 = 2
EFF_01 = 1
EFF_03 = 2
EFF_05 = 3
EFF_07 = 4
EFF_09 = 5
EFF_11 = 6
EFF_13 = 7
EFF_15 = 8
EFF_17 = 9
EFF_19 = 10
EFF_21 = 11
EFF_IN_00 = 21
EFF_IN_01 = 22
EFF_IN_02 = 23
EFF_IN_03 = 24
EFF_IN_04 = 25
EFF_IN_05 = 26
EFF_IN_06 = 27
EFF_IN_07 = 28
EFF_IN_08 = 29
EFF_IN_09 = 30
EFF_OUT_00 = 31
EFF_OUT_01 = 32
EFF_OUT_02 = 33
EFF_OUT_03 = 34
EFF_OUT_04 = 35
EFF_OUT_05 = 36
EFF_OUT_06 = 37
EFF_OUT_07 = 38
EFF_OUT_08 = 39
BOSS_ID = 80401
AEGIOMON_ID = 183
AEGIOCHUSMON_ID = 184
AEGIOCHUSMON_DARK_ID = 185
AEGIOCHUSMON_HOLLY_ID = 186
AEGIOCHUSMON_BLUE_ID = 187
AEGIOCHUSMON_GREEN_ID = 188

function Battle_Before_Setup()
  Battle.LoadObject(OBJ_01, "d0990floor00")
  Battle.LoadObject(OBJ_02, "t3003f")
  Battle.LoadEffectScript(EFF_01, "ef_b_bos_200")
  Battle.LoadEffectScript(EFF_03, "ef_b_bos_202")
  Battle.LoadEffectScript(EFF_05, "ef_b_bos_204")
  Battle.LoadEffectScript(EFF_07, "ef_b_bos_206")
  Battle.LoadEffectScript(EFF_09, "ef_b_bos_208")
  Battle.LoadEffectScript(EFF_11, "ef_b_bos_210")
  Battle.LoadEffectScript(EFF_13, "ef_b_bos_212")
  Battle.LoadEffectScript(EFF_15, "ef_b_bos_214")
  Battle.LoadEffectScript(EFF_17, "ef_b_bos_216")
  Battle.LoadEffectScript(EFF_19, "ef_b_bos_218")
  Battle.LoadEffectScript(EFF_21, "ef_b_bos_220")
  Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 27474)
  Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "ba02_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bb01_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bb02_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bb03_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bb04_01")
  Battle.AddLoadMotion(ENEMY_DIGIMON, 0, "bb05_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_IDLE, "bn01_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_DAMAGE, "bn01_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_COMMON_SKILL, "ba02_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_TIRED, "bn01_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_CHARGE_IDLE, "bb01_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_CHARGE_DAMAGE, "bb02_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_CHARGE_BREAK, "bb03_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_CHARGE_IN, "bb04_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_CHARGE_END, "bb05_01")
  Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_AVOID, "bn01_01")
  Battle.LoadAnimation_ForIsPriorExchange(ENEMY_DIGIMON, 0, "bd01_01", true)
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_BATTLE_IN_DIRECTION, true)
  SetEndrollMember(12000200)
end

function Battle_After_Build()
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
end

function Battle_Opening(info)
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.SetObjectPosition(OBJ_01, 0, 0, 0)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m440_030")
    Battle.ResetFormation(false)
    Battle.SetCamera(-8.6836, 24.2429, -66.9905, -1.4508, 38.519, -79.7624, 35, 0, MODE_QUADRATIC_IN_OUT)
  elseif Flg.Check("Battle5499") then
    Battle.RemoveBuff(PLAYER_DIGIMON, 0, 48001)
    Battle.RemoveBuff(PLAYER_DIGIMON, 1, 48001)
    Battle.RemoveBuff(PLAYER_DIGIMON, 2, 48001)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  Sound.PlayBGM(950, 0)
end

function Battle_Start(info)
  Battle.SetCameraMove(120, MODE_QUADRATIC_OUT)
  Battle.SetCameraMoveStart()
  Battle.SetBattleCamera(3, PLAYER_CHARA, 0)
  WaitFrame(120)
  Battle.SetIsIntervalDamage(false)
  BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 580417)
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  print("##### stock_num:", stock_num, " #####")
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5053") then
    Round = Round + 1
    print("##### Round: ", Round, " CHARGING ROUND #####")
  end
  if Flg.Check("Battle5003") and Flg.Check("Battle5004") == false or Flg.Check("Battle5400") == true then
    if Battle.IsChronodevolution() == true then
      Round_ph3 = Round_ph3 + 1
      print("##### Round_ph3:", Round_ph3, " #####")
    elseif Flg.Check("Battle5400") == true then
      Flg.Clear("Battle5400")
    end
    if Round_ph3 == 1 then
      if Flg.Check("Battle5132") == false then
        Battle.EntryAnnouncementMessage(Get_Aegiomon_Announcement_Id(119))
        Flg.Set("Battle5132")
      end
    elseif Battle.IsEndAnnouncementMessage(Get_Aegiomon_Announcement_Id(119)) == true and Flg.Check("Battle5230") == false then
      Battle.EntryAnnouncementMessage(Get_Aegiomon_Announcement_Id(126))
      Flg.Set("Battle5230")
    end
    if Flg.Check("Battle5012") == false then
      Round_cp = Round_cp + 1
      print("##### Round_cp: ", Round_cp, " #####")
    end
  end
  if Flg.Check("Battle5004") then
    Round_ph4 = Round_ph4 + 1
    print("##### Round_ph4:", Round_ph4, " #####")
  end
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local digimon_id = info.digimon_id
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if Flg.Check("Battle5403") then
    Battle.CloseUI()
    WaitFrame(1)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
    Battle.ForceEndAnnouncementMessage()
    Battle.SetCamera(0.09, 1.14, 43.33, 0, 0.8, 45.54, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -0.07, 0, 46.45)
    WaitFrame(30)
    Battle.LoadDissolveChangeIn(EFF_IN_00, GUEST_DIGIMON, 0)
    while Battle.IsLoadingDissolve(EFF_IN_00) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_00)
    WaitFrame(35)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 0, false)
    Talk.OpenLetterBox()
    Battle.MessageTalk(1200020033)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    CoverFireStart()
    Battle.SetIsIntervalDamage(true)
    Flg.Clear("Battle5403")
  elseif Flg.Check("Battle5404") then
    Battle.CloseUI()
    WaitFrame(1)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 2, false)
    Battle.ForceEndAnnouncementMessage()
    Battle.SetCamera(0.38, 3.85, 34.08, 0.25, 3.59, 43.83, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -3.6, 0, 46.25)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -0.07, 0, 46.45)
    Battle.SetModelPosition(GUEST_DIGIMON, 2, 4.98, 0, 46.73)
    WaitFrame(30)
    Battle.LoadDissolveChangeIn(EFF_IN_01, GUEST_DIGIMON, 0)
    Battle.LoadDissolveChangeIn(EFF_IN_02, GUEST_DIGIMON, 1)
    Battle.LoadDissolveChangeIn(EFF_IN_03, GUEST_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_01) ~= false or Battle.IsLoadingDissolve(EFF_IN_02) ~= false or Battle.IsLoadingDissolve(EFF_IN_03) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_01)
    Battle.PlayDissolve(EFF_IN_02)
    Battle.PlayDissolve(EFF_IN_03)
    WaitFrame(35)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "ba02", 0, false)
    BtlPlayAnimation(GUEST_DIGIMON, 2, "ba02", 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 1, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 2, false)
    Talk.OpenLetterBox()
    Battle.MessageTalk(1200020026)
    WaitMessage()
    Battle.MessageTalk(1200020031)
    WaitMessage()
    Battle.MessageTalk(1200020030)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Clear("Battle5404")
  elseif Flg.Check("Battle5405") then
    Battle.CloseUI()
    WaitFrame(1)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 2, false)
    Battle.ForceEndAnnouncementMessage()
    Battle.SetCamera(0, 3.05, 35.94, -0.07, 3.02, 46.45, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -5.38, 0, 46.25)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -0.07, 0, 46.45)
    Battle.SetModelPosition(GUEST_DIGIMON, 2, 4.98, 0, 46.73)
    WaitFrame(30)
    Battle.LoadDissolveChangeIn(EFF_IN_04, GUEST_DIGIMON, 0)
    Battle.LoadDissolveChangeIn(EFF_IN_05, GUEST_DIGIMON, 1)
    Battle.LoadDissolveChangeIn(EFF_IN_06, GUEST_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_04) ~= false or Battle.IsLoadingDissolve(EFF_IN_05) ~= false or Battle.IsLoadingDissolve(EFF_IN_06) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_04)
    Battle.PlayDissolve(EFF_IN_05)
    Battle.PlayDissolve(EFF_IN_06)
    WaitFrame(35)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "ba02", 0, false)
    BtlPlayAnimation(GUEST_DIGIMON, 2, "ba02", 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 1, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 2, false)
    Talk.OpenLetterBox()
    Battle.MessageTalk(1200020032)
    WaitMessage()
    Battle.MessageTalk(1200020029)
    WaitMessage()
    Battle.MessageTalk(1200020036)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Clear("Battle5405")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580424)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 580425)
  elseif Flg.Check("Battle5406") then
    Battle.CloseUI()
    WaitFrame(1)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, false)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, false)
    Battle.SetVisibleCharacter(GUEST_DIGIMON, 2, false)
    Battle.ForceEndAnnouncementMessage()
    Battle.SetCamera(-2.6, 1.99, 37.62, -3.1, 2.07, 46.86, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.SetModelPosition(GUEST_DIGIMON, 0, -5.38, 0, 46.25)
    Battle.SetModelPosition(GUEST_DIGIMON, 1, -0.07, 0, 46.45)
    Battle.SetModelPosition(GUEST_DIGIMON, 2, 5.57, 0, 46.73)
    WaitFrame(30)
    Battle.LoadDissolveChangeIn(EFF_IN_07, GUEST_DIGIMON, 0)
    Battle.LoadDissolveChangeIn(EFF_IN_08, GUEST_DIGIMON, 1)
    Battle.LoadDissolveChangeIn(EFF_IN_09, GUEST_DIGIMON, 2)
    while Battle.IsLoadingDissolve(EFF_IN_07) ~= false or Battle.IsLoadingDissolve(EFF_IN_08) ~= false or Battle.IsLoadingDissolve(EFF_IN_09) ~= false do
      WaitFrame(1)
    end
    Battle.PlayDissolve(EFF_IN_07)
    Battle.PlayDissolve(EFF_IN_08)
    Battle.PlayDissolve(EFF_IN_09)
    WaitFrame(35)
    BtlPlayAnimation(GUEST_DIGIMON, 0, "ba02", 0, false)
    BtlPlayAnimation(GUEST_DIGIMON, 1, "ba02", 0, false)
    BtlPlayAnimation(GUEST_DIGIMON, 2, "ba02", 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 0, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 1, false)
    Battle.AddMotionScheduleIdleByStatus(GUEST_DIGIMON, 2, false)
    Talk.OpenLetterBox()
    Battle.MessageTalk(1200020034)
    WaitMessage()
    Battle.MessageTalk(1200020039)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Clear("Battle5406")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580425)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 580426)
  elseif Flg.Check("Battle5411") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28041)
  end
  if Flg.Check("Battle5001") == false then
    if enemy_id == BOSS_ID and Flg.Check("Battle5101") == false then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28046)
      Flg.Set("Battle5101")
    end
    if enemy_id == BOSS_ID and Flg.Check("Battle5102") == false and Flg.Check("Battle5215") then
      Battle.SetBattleSpeed(BATTLE_SPEED_NORMAL)
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28041)
    end
    if Flg.Check("Battle5102") and enemy_last_skill_id == 28050 then
      Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_DAMAGE, "bn01_01")
      Flg.Set("Battle5410")
    end
    if Flg.Check("Battle5102") and Flg.Check("Battle5410") and Flg.Check("Battle5005") == false then
      Flg.Set("Battle5005")
    end
  end
  if Battle.IsChronodevolution() == true then
    if Round_ph3 == 1 and info.group == GUEST_AEGIOMON and Battle.GetDigimonId(GUEST_AEGIOMON, 0) == AEGIOCHUSMON_ID then
      Battle.MotionNameOverwrite(GUEST_AEGIOMON, 0, MOTION_TYPE_SPECIAL_SKILL03, "bs03")
      Battle.AddLoadMotion(GUEST_AEGIOMON, 0, "bs03")
    end
    if 1 <= Round_ph3 then
      if Battle.GetDigimonId(GUEST_AEGIOMON, 0) == AEGIOMON_ID then
        Battle.SetNextCommandSkill(GUEST_AEGIOMON, 0, 21833)
      else
        Battle.SetNextCommandSkill(GUEST_AEGIOMON, 0, 21834)
      end
    end
    if Battle.IsEndAnnouncementMessage(117) == true and Battle.IsEndAnnouncementMessage(118) == false and (info.group == PLAYER_DIGIMON or info.group == GUEST_AEGIOMON) then
      Battle.EntryAnnouncementMessage(118)
    end
  end
  local flg_count = Flgcount()
  if 6 <= flg_count and Flg.Check("Battle5003") and Flg.Check("Battle5117") and Flg.Check("Battle5004") == false and Battle.IsTurnCharacterExtraTurn() == false then
    Flg.Set("Battle5051")
  elseif 3 <= flg_count and Flg.Check("Battle5004") and Battle.IsTurnCharacterExtraTurn() == false then
    Flg.Set("Battle5051")
  end
  if enemy_id == BOSS_ID and Flg.Check("Battle5053") and Flg.Check("Battle5057") == false then
    print("##### POWER CHARGE #####")
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if info.digimon_id == 747 then
    print("... round_count = " .. round_count)
    if round_count <= 1 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10011)
    elseif 2 <= round_count then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 27471)
      Flg.Set("Battle5214")
    end
  end
  if Flg.Check("Battle5004") and Flg.Check("Battle5053") then
    if info.group == 2 and info.index == 0 then
      Battle.SetNextCommandTarget(GUEST_DIGIMON, 0, ADD_TARGET, 0)
    end
    if info.group == 2 and info.index == 0 and Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70008 then
      Battle.SetNextCommandSkill(GUEST_DIGIMON, 0, 10012)
    end
  end
  if Flg.Check("Battle5001") and Battle.IsEndAnnouncementMessage(92) == false then
    Battle.EntryAnnouncementMessage(92)
  elseif Flg.Check("Battle5002") and Battle.IsEndAnnouncementMessage(110) == false then
    Battle.EntryAnnouncementMessage(110)
  elseif Flg.Check("Battle5010") and Battle.IsEndAnnouncementMessage(109) == false then
    Battle.EntryAnnouncementMessage(109)
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  local skill_id = Battle.GetLastActionSkillID()
  if enemy_id == BOSS_ID then
    if Flg.Check("Battle5004") == false and Flg.Check("Battle5053") == false and Battle.IsBreakCPCharge() == false then
      Battle.AddEnemyCP(200)
    else
      Battle.AddEnemyCP(400)
    end
  end
  if Flg.Check("Battle5001") == false and Flg.Check("Battle5105") and Flg.Check("Battle5106") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28047)
    Flg.Set("Battle5106")
  end
  if Flg.Check("Battle5003") and enemy_id == BOSS_ID then
    print("===== PHASE3 Chronomon TURN =====")
    if Flg.Check("Battle5051") and Flg.Check("Battle5053") == false and Battle.IsTurnCharacterExtraTurn() == false then
      print("##### SETUP CHARGE #####")
      print("##### 2 ACTION BUFFS REMOVED #####")
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
      Battle.SetupCPCharge(70003, 88602, ENEMY_DIGIMON, 0, "FP07", 2)
      Round = 0
      Flg.Set("Battle5053")
    end
  end
  if Flg.Check("Battle5053") then
    if 2 <= Round and Flg.Check("Battle5001") == false and Flg.Check("Battle5055") == false then
      if enemy_id == BOSS_ID then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
        Battle.CompleteCPCharge(70005)
        Flg.Set("Battle5055")
      end
    elseif 2 <= Round and Flg.Check("Battle5003") and Flg.Check("Battle5055") == false and enemy_id == BOSS_ID then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
      Battle.CompleteCPCharge(70005)
      Flg.Set("Battle5055")
    end
  end
  if skill_id == 70001 and Flg.Check("Battle5056") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
    Flg.Set("Battle5056")
  end
  if enemy_last_skill_id == 70005 or skill_id == 70005 then
    if Flg.Check("Battle5003") == true and Flg.Check("Battle5004") == false then
      if Flg.Check("Battle5118") == false then
        if Flg.Check("Battle5232") == false then
          print("##### PHASE3 CHARGE GENERATION NOT BACK #####")
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28042)
        elseif Flg.Check("Battle5232") == true then
          print("##### PHASE3 EVENT CHARGE GENERATION BACK #####")
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28048)
          Battle.ClearCPCharge()
          Flg.Set("Battle5118")
        end
      end
    elseif Flg.Check("Battle5004") == true then
      print("##### PHASE4 CHARGE #####")
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28042)
    end
  end
end

function Battle_Action_Start(info)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local enemy_id = info.enemy_id
  local skill_id = Battle.GetLastActionSkillID()
  Battle.SetSkillShootDirectionInvisibleTarget(ENEMY_DIGIMON, 0)
  Battle.SetSkillShootDirectionInvisibleObject(OBJ_01, true)
  if Flg.Check("Battle5001") == false and skill_id == 28046 then
    Battle.EntryAnnouncementMessage(1)
  end
  if enemy_id == BOSS_ID then
    if Flg.Check("Battle5112") and skill_id == 28041 then
      Battle.EntryAnnouncementMessage(58)
      Battle.SkipSkillHitDirection(ENEMY_DIGIMON, 0, 28041)
    elseif Flg.Check("Battle5115") and Flg.Check("Battle5122") == false and skill_id == 28048 then
      Battle.SkipSkillHitDirection(ENEMY_DIGIMON, 0, 28048)
      Flg.Set("Battle5122")
    elseif Flg.Check("Battle5118") and Flg.Check("Battle5125") == false then
      Battle.SkipSkillHitDirection(ENEMY_DIGIMON, 0, 28048)
      Flg.Set("Battle5125")
    end
  end
  if Flg.Check("Battle5120") then
    print("##### Last X Arts Stand by #####")
    Battle.SetObjectVisible(OBJ_01, false)
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m440_110")
    Battle.SetObjectVisible(OBJ_01, true)
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m440_120")
    Flg.Set("FLAG_MAIN_22_565")
    Battle.ForceEnd()
  end
  local AddTarget_HP_MAX = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  local AddTarget_HP = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5004") and Flg.Check("Battle5053") and Flg.Check("Battle5300") == false and Flg.Check("Battle5399") and Round == 0 then
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
end

function Battle_Action_End(info)
  local skill_id = Battle.GetLastActionSkillID()
  if info.enemy_id == BOSS_ID and skill_id == 28046 then
    Battle.SetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Flg.Set("Battle5105")
  end
  if skill_id == 28041 or skill_id == 28042 or skill_id == 28043 or skill_id == 28044 or skill_id == 28048 then
    CoverFirePlay()
  end
end

function Battle_Command_End(info)
end

function Battle_Turn_End(info)
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local digimon_id = info.digimon_id
  local enemy_id = info.enemy_id
  local round_count = info.round
  local skill_id = Battle.GetLastActionSkillID()
  local enemy_last_skill_id = Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0)
  if enemy_last_skill_id == 70003 or skill_id == 70003 then
    if Flg.Check("Battle5103") and Flg.Check("Battle5128") == false then
      print("##### ADD_TARGET BATTLE_CHARACTER_SETTING_REMAIN_HP_1 #####")
      Battle.SetCharacterSettingFlag(ADD_TARGET, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
      Flg.Set("Battle5128")
    elseif Flg.Check("Battle5003") and Flg.Check("Battle5004") == false and Battle.IsChronodevolution() == false and Flg.Check("Battle5129") == false then
      print("##### ADD_TARGET BATTLE_CHARACTER_SETTING_REMAIN_HP_1 #####")
      Battle.SetCharacterSettingFlag(ADD_TARGET, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
      Flg.Set("Battle5129")
    end
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  if Flg.Check("Battle5001") == false then
    if Flg.Check("Battle5106") and skill_id == 28047 then
      Battle.ExchangeMember(GUEST_DIGIMON, 0)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 21724)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 20803)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 2, 20752)
      Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
      Flg.Set("Battle5403")
    end
    if Flg.Check("Battle5102") == false then
      if Flg.Check("Battle5215") == true then
        CoverFireStop()
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m440_040")
        if Flg.Check("FLAG_IS_CLEAR_S110_098") == false then
          Battle.CloseUI()
          Battle.ReadyNextSceneForVista()
          Execute("m440_050")
        else
          Battle.CloseUI()
          Battle.ReadyNextSceneForVista()
          Execute("m440_060")
        end
        Battle.SetObjectVisible(OBJ_01, false)
        Battle.SetObjectVisible(OBJ_02, true)
        Battle.SetObjectPosition(OBJ_02, 0, 0, 0)
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m440_070")
        Battle.SetObjectVisible(OBJ_02, false)
        Battle.SetObjectVisible(OBJ_01, true)
        if Flg.Check("FLAG_IS_CLEAR_S110_098") == false then
          Battle.CloseUI()
          Battle.ReadyNextSceneForVista()
          Execute("m440_080")
          Fade.In(1, Util.SecondFromFrame(30))
          local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
          local hp = enemy_now_hp - 1800
          Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
          Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580401)
          Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580402)
          Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580417)
          BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28050)
        else
          Battle.CloseUI()
          Battle.ReadyNextSceneForVista()
          Execute("m440_091")
          Fade.In(1, Util.SecondFromFrame(30))
          local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
          local hp = enemy_now_hp - 4500
          Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, hp)
          Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580401)
          Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580402)
          Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580417)
          BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
          Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28050)
        end
        Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_DAMAGE, "bd01_01")
        ChangeBGM(950, 0.5, 0.5)
        Battle.SetIsStopIntervalDamage(false)
        CoverFirePlay()
        Flg.Set("Battle5102")
      end
      if digimon_id == 747 and Flg.Check("Battle5214") == true and Flg.Check("Battle5215") == false then
        Battle.SetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
        Flg.Set("Battle5215")
      end
    elseif Flg.Check("Battle5102") == true and enemy_last_skill_id == 28050 and Flg.Check("Battle5008") == false then
      Battle.SetCamera(0.38, 3.85, 34.08, 0.25, 3.59, 43.83, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, -0.07, 0, 46.25)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, true)
      Battle.LoadDissolveChangeOut(EFF_OUT_00, GUEST_DIGIMON, 0)
      while Battle.IsLoadingDissolve(EFF_OUT_00) do
        WaitFrame(1)
      end
      Battle.PlayDissolve(EFF_OUT_00)
      WaitFrame(30)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 0)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 1)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 2)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 28672)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 21792)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 2, 21742)
      Flg.Set("Battle5404")
      Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
      Battle.LoadAnimation(GUEST_DIGIMON, 1, "ba02")
      Battle.LoadAnimation(GUEST_DIGIMON, 2, "ba02")
      Battle.AddBuff(ENEMY_DIGIMON, 0, 580424)
      Flg.Set("Battle5008")
    end
    if skill_id == 28047 and Flg.Check("Battle5107") == false then
      print("##### CP INNITIALIZE #####")
      Battle.SetPlayerCPGaugeMaxValue(0)
      Flg.Set("Battle5107")
    end
  end
  if Flg.Check("Battle5010") and Flg.Check("Battle5116") == false then
    print("##### Phase3 setup #####")
    Fade.OutNotLoading(0, Util.SecondFromFrame(30))
    WaitFrame(30)
    Battle.ForceEndAnnouncementMessage()
    Battle.AllClearAttachUnit()
    CoverFireStop()
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.SetCamera(-0.75, 1.52, -24.13, -0.88, 5.59, -33.26, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Fade.In(0, Util.SecondFromFrame(30))
    Battle.SetBattleSpeed(BATTLE_SPEED_NORMAL)
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.MessageTalk(1200020111)
    WaitMessage()
    Battle.MessageTalk(1200020112)
    WaitMessage()
    Battle.MessageTalk(1200020113)
    WaitMessage()
    Battle.MessageTalk(1200020114)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Fade.OutNotLoading(0, Util.SecondFromFrame(30))
    WaitFrame(30)
    Reset()
    Battle.SetOverwriteCamera("camera_big_Last")
    Battle.SetEnemyFormationId(300)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 28045)
    Round_cp = 0
    Fade.In(0, Util.SecondFromFrame(30))
    ChangeBGM(951, 0.5, 0.5)
    Flg.Set("Battle5116")
    Flg.Set("Battle5003")
  end
  if Flg.Check("Battle5003") and Flg.Check("Battle5004") == false then
    if Flg.Check("Battle5117") == false then
      if skill_id == 28045 and Flg.Check("Battle5117") == false then
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m440_100")
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m440_033")
        Battle.SetBattleCamera(73, ENEMY_DIGIMON, 0)
        Fade.In(1, Util.SecondFromFrame(30))
        CoverFirePlay()
        Battle.ExchangeMember(GUEST_DIGIMON, 1)
        Battle.ExchangeMember(GUEST_DIGIMON, 2)
        Battle.DeleteMember(GUEST_DIGIMON, 0)
        Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 27474)
        Battle.EntryAnnouncementMessage(116)
        WaitFrame(15)
        Battle.SetFieldEffectSkill(21738, -1, -1)
        Flg.Set("Battle5117")
      end
    elseif Flg.Check("Battle5232") == false then
      local IsChronodevolution = Battle.IsChronodevolution()
      print("##### IsChronodevolution = ", IsChronodevolution, " #####")
      if IsChronodevolution == true then
        if Flg.Check("Battle5133") == false then
          Flg.Set("Battle5133")
        end
      elseif IsChronodevolution == false then
        Battle.EntryAnnouncementMessage(Get_Aegiomon_Announcement_Id(147))
        Flg.Set("Battle5232")
      end
    end
    if Flg.Check("Battle5125") or Flg.Check("Battle5400") == true then
      if Flg.Check("Battle5400") == true then
        Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
      end
      if enemy_id == BOSS_ID or Flg.Check("Battle5400") == true then
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m440_034")
        Fade.In(0, Util.SecondFromFrame(30))
        ChangeBGM(952, 0.5, 0.5)
        Battle.DeleteMember(GUEST_DIGIMON, 1)
        Battle.DeleteMember(GUEST_DIGIMON, 2)
        Battle.EntryAnnouncementMessage(149)
        Battle.ExchangeMember(GUEST_DIGIMON, 1)
        Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 21811)
        Flg.Clear("Battle5011")
        Flg.Clear("Battle5012")
        Flg.Clear("Battle5013")
        Flg.Clear("Battle5014")
        Flg.Clear("Battle5015")
        Flg.Clear("Battle5016")
        Flg.Clear("Battle5017")
        Flg.Clear("Battle5018")
        Flg.Clear("Battle5019")
        Flg.Clear("Battle5020")
        Flg.Clear("Battle5021")
        Flg.Clear("Battle5022")
        Flg.Clear("Battle5051")
        Flg.Clear("Battle5053")
        Flg.Clear("Battle5054")
        Flg.Clear("Battle5055")
        Flg.Clear("Battle5056")
        Flg.Clear("Battle5300")
        Flg.Set("Battle5004")
        Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
        Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
        Round = 0
        Round_cp = 0
      end
    end
  end
  if Flg.Check("Battle5004") then
    if Flg.Check("Battle5119") == false then
      if Battle.IsEndAnnouncementMessage(150) == true and digimon_id == 27473 and Battle.IsEndAnnouncementMessage(151) == false then
        Battle.EntryAnnouncementMessage(151)
      end
      if (2 <= Round_ph4 or enemy_now_hp / enemy_max_hp <= 0.5) and info.group == GUEST_DIGIMON then
        Battle.ExchangeMember(GUEST_DIGIMON, 1)
        Battle.CloseUI()
        Battle.ReadyNextSceneForVista()
        Execute("m440_090")
        Fade.In(1, Util.SecondFromFrame(30))
        Flg.Set("Battle5119")
      end
    end
    if enemy_now_hp == 1 and Flg.Check("Battle5119") == true then
      print("##### SETUP LAST X-ARTS #####")
      Battle.SetBattleSpeed(BATTLE_SPEED_NORMAL)
      Battle.CloseUI()
      Battle.ReadyNextSceneForVista()
      Execute("m440_105")
      Battle.ClearCPCharge()
      Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_IDLE, "bn01_03")
      Battle.MotionNameOverwrite(ENEMY_DIGIMON, 0, MOTION_TYPE_CHARGE_IDLE, "bn01_03")
      Fade.In(1, Util.SecondFromFrame(30))
      Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, false)
      BtlSetInterruptCharacter(GUEST_AEGIOMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
      Battle.SetPlayerCPGaugeMaxValue(1200)
      Battle.SetIsLastCrossArts(true)
      Flg.Set("Battle5120")
    end
  end
  if skill_id == 70001 then
    print("##### CHARGE COMPLETION INTERCEPT #####")
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
    if Flg.Check("Battle5004") then
      AddTarget_nobreakHP()
    end
    Flg.Set("Battle5057")
  end
  if Flg.Check("Battle5117") and Flg.Check("Battle5004") == false then
    if Battle.IsChronodevolution() == true then
      if Round_cp >= 7 then
        Flg.Set("Battle5012")
      end
    elseif Round_cp >= 3 then
      Flg.Set("Battle5012")
    end
    if Battle.GetStatus(GUEST_AEGIOMON, 0, STATUS_TYPE_HP) == 0 then
      Flg.Set("Battle5021")
    end
    if Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP) <= 0.8 then
      Flg.Set("Battle5022")
    end
  end
  if Flg.Check("Battle5004") then
    if 5 <= round_count and Flg.Check("Battle5001") then
      Flg.Set("Battle5011")
    end
    if Round_cp >= 5 then
      Flg.Set("Battle5012")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
      Flg.Set("Battle5014")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 3000) then
      Flg.Set("Battle5015")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, 5000) then
      Flg.Set("Battle5016")
    end
    if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_HIT_COUNT_OVER, 0, ENEMY_DIGIMON, 0, 25) then
      Flg.Set("Battle5017")
    end
  end
  if Battle.IsTurnCharacterExtraTurn() == false then
    if Flg.Check("Battle5008") and Flg.Check("Battle5001") == false then
      math.randomseed(os.time())
      local random = math.random(1, 100)
      if 1 <= random and random <= 15 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48043)
      elseif 16 <= random and random <= 50 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48131)
      elseif 51 <= random and random <= 85 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48132)
      elseif 86 <= random and random <= 100 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48041)
      end
    elseif Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
      local random = math.random(1, 100)
      if 1 <= random and random <= 40 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48043)
      elseif 41 <= random and random <= 65 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48044)
      elseif 66 <= random and random <= 90 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48041)
      elseif random >= 91 and random <= 100 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30033)
      end
    elseif Flg.Check("Battle5002") and Flg.Check("Battle5010") == false then
      local random = math.random(1, 100)
      if 1 <= random and random <= 40 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48141)
      elseif 41 <= random and random <= 60 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48044)
      elseif random >= 61 and random <= 80 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48041)
      elseif random >= 81 and random <= 90 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30273)
      elseif random >= 91 and random <= 100 then
        Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30303)
      end
    end
  end
  if Flg.Check("Battle5117") and Battle.IsChronodevolution() == true then
    if random == 1 then
      print("#### SetNextCommandSkill = ", 48041, " ####")
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48041)
    elseif random == 2 then
      print("#### SetNextCommandSkill = ", 30216, " ####")
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30203)
    elseif random == 3 then
      print("#### SetNextCommandSkill = ", 30093, " ####")
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30093)
    elseif random == 4 then
      print("#### SetNextCommandSkill = ", 48043, " ####")
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48043)
    end
  elseif Flg.Check("Battle5117") and Battle.IsChronodevolution() == false then
    if random == 1 then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 30336)
    elseif random == 2 then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48043)
    elseif random == 3 then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48041)
    elseif random == 4 then
      Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 48141)
    end
  end
  local stock_num = Battle.GetCPStockNum()
  print("#### stock_num:", stock_num, "CHARGE = ", Flg.Check("Battle5053"), " ####")
  if stock_num == 0 or Flg.Check("Battle5053") then
    print("##### ExtraTurn_OFF #####")
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  elseif stock_num == 1 and Flg.Check("Battle5053") == false and round_count % 3 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 48045)
  elseif stock_num == 1 and Flg.Check("Battle5053") == false and round_count % 3 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30293)
  elseif stock_num == 1 and Flg.Check("Battle5053") == false and round_count % 3 == 2 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
  elseif stock_num == 2 and Flg.Check("Battle5053") == false and round_count % 3 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32031)
  elseif stock_num == 2 and Flg.Check("Battle5053") == false and round_count % 3 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30336)
  elseif stock_num == 2 and Flg.Check("Battle5053") == false and round_count % 3 == 2 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 48045)
  elseif stock_num == 3 and Flg.Check("Battle5053") == false and round_count % 3 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 48045)
  elseif stock_num == 3 and Flg.Check("Battle5053") == false and round_count % 3 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30063)
  elseif stock_num == 3 and Flg.Check("Battle5053") == false and round_count % 3 == 2 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32061)
  elseif stock_num == 4 and Flg.Check("Battle5053") == false and round_count % 3 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
  elseif stock_num == 4 and Flg.Check("Battle5053") == false and round_count % 3 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 48045)
  elseif stock_num == 4 and Flg.Check("Battle5053") == false and round_count % 3 == 2 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30216)
  elseif 5 <= stock_num and Flg.Check("Battle5053") == false and round_count % 3 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 48045)
  elseif 5 <= stock_num and Flg.Check("Battle5053") == false and round_count % 3 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30186)
  elseif 5 <= stock_num and Flg.Check("Battle5053") == false and round_count % 3 == 2 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30093)
  end
  if Flg.Check("Battle5003") then
    if 1 <= stock_num and Flg.Check("Battle5301") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 580414)
      Flg.Set("Battle5301")
    end
    if 2 <= stock_num and Flg.Check("Battle5302") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 580415)
      Flg.Set("Battle5302")
    end
    if 3 <= stock_num and Flg.Check("Battle5303") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 580416)
      Flg.Set("Battle5303")
    end
    if 4 <= stock_num and Flg.Check("Battle5304") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 580417)
      Flg.Set("Battle5304")
    end
    if 5 <= stock_num and Flg.Check("Battle5305") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 580418)
      Flg.Set("Battle5305")
    end
  end
  if enemy_last_skill_id == 28041 or skill_id == 28041 then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5056")
    Flg.Clear("Battle5057")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Round = 0
    Round_cp = 0
  end
  if skill_id == 28042 or skill_id == 28043 or skill_id == 28044 or skill_id == 28048 or enemy_last_skill_id == 28042 or enemy_last_skill_id == 28043 or enemy_last_skill_id == 28044 or enemy_last_skill_id == 28048 then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5018")
    Flg.Clear("Battle5019")
    Flg.Clear("Battle5020")
    Flg.Clear("Battle5021")
    Flg.Clear("Battle5022")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5056")
    Flg.Clear("Battle5057")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Round = 0
    Round_cp = 0
  end
  if Flg.Check("Battle5003") and Battle.IsBreakCPCharge() then
    print("##### CHARAGE BRAKE #####")
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5018")
    Flg.Clear("Battle5019")
    Flg.Clear("Battle5020")
    Flg.Clear("Battle5021")
    Flg.Clear("Battle5022")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5056")
    Flg.Clear("Battle5057")
    Flg.Clear("Battle5301")
    Flg.Clear("Battle5302")
    Flg.Clear("Battle5303")
    Flg.Clear("Battle5304")
    Flg.Clear("Battle5305")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580414)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580415)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580416)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580417)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580418)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    print("##### 2 ACTION BUFFS ADDED #####")
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    Round = 0
    Round_cp = 0
    Battle.ClearCPCharge()
  end
  if Flg.Check("Battle5411") then
    if Flg.Check("Battle5001") == false then
      Battle.SetCamera(0, 3.05, 35.94, -0.07, 3.02, 46.45, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, -5.38, 0, 46.25)
      Battle.SetModelPosition(GUEST_DIGIMON, 1, -0.07, 0, 46.45)
      Battle.SetModelPosition(GUEST_DIGIMON, 2, 7.57, 0, 46.73)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, true)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, true)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 2, true)
      Battle.LoadDissolveChangeOut(EFF_OUT_01, GUEST_DIGIMON, 0)
      Battle.LoadDissolveChangeOut(EFF_OUT_02, GUEST_DIGIMON, 1)
      Battle.LoadDissolveChangeOut(EFF_OUT_03, GUEST_DIGIMON, 2)
      while Battle.IsLoadingDissolve(EFF_OUT_01) and Battle.IsLoadingDissolve(EFF_OUT_02) and Battle.IsLoadingDissolve(EFF_OUT_03) do
        WaitFrame(1)
      end
      Battle.PlayDissolve(EFF_OUT_01)
      Battle.PlayDissolve(EFF_OUT_02)
      Battle.PlayDissolve(EFF_OUT_03)
      WaitFrame(30)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 0)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 1)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 2)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 0, 21702)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 21802)
      Flg.Set("Battle5405")
      Battle.LoadAnimation(GUEST_DIGIMON, 0, "ba02")
      Battle.LoadAnimation(GUEST_DIGIMON, 1, "ba02")
      Battle.LoadAnimation(GUEST_DIGIMON, 2, "ba02")
      Flg.Set("Battle5001")
    elseif Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
      Battle.SetCamera(0, 3.05, 35.94, -0.07, 3.02, 46.45, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(GUEST_DIGIMON, 0, -5.38, 0, 46.25)
      Battle.SetModelPosition(GUEST_DIGIMON, 1, -0.07, 0, 46.45)
      Battle.SetModelPosition(GUEST_DIGIMON, 2, 7.57, 0, 46.73)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 0, true)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 1, true)
      Battle.SetVisibleCharacter(GUEST_DIGIMON, 2, true)
      Battle.LoadDissolveChangeOut(EFF_OUT_04, GUEST_DIGIMON, 0)
      Battle.LoadDissolveChangeOut(EFF_OUT_05, GUEST_DIGIMON, 1)
      Battle.LoadDissolveChangeOut(EFF_OUT_06, GUEST_DIGIMON, 2)
      while Battle.IsLoadingDissolve(EFF_OUT_04) and Battle.IsLoadingDissolve(EFF_OUT_05) and Battle.IsLoadingDissolve(EFF_OUT_06) do
        WaitFrame(1)
      end
      Battle.PlayDissolve(EFF_OUT_04)
      Battle.PlayDissolve(EFF_OUT_05)
      Battle.PlayDissolve(EFF_OUT_06)
      WaitFrame(30)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 0)
      Battle.ExchangeMemberForDeleteTimingNextTurn(GUEST_DIGIMON, 1)
      Battle.DeleteMember(GUEST_DIGIMON, 2)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 1, 21732)
      Battle.PrepareExchangeByGuestID(GUEST_DIGIMON, 2, 27333)
      Battle.SetIsIntervalDamage(false)
      Flg.Set("Battle5406")
      Flg.Set("Battle5002")
    elseif Flg.Check("Battle5010") == false then
      Battle.DeleteMember(GUEST_DIGIMON, 0)
      Battle.DeleteMember(GUEST_DIGIMON, 1)
      Flg.Set("Battle5010")
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 580426)
    end
    Flg.Clear("Battle5411")
  end
  local enemy_max_hp_f1 = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp_f1 = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_now_hp_f1 / enemy_max_hp_f1 <= 0.6 then
    print("##### enemy_now_hp = ", enemy_now_hp_f1, " enemy_max_hp = ", enemy_max_hp_f1, " #####")
    if Flg.Check("Battle5008") and Flg.Check("Battle5404") == false and Flg.Check("Battle5001") == false then
      Recover()
      Battle.SetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
      Flg.Set("Battle5411")
    elseif Flg.Check("Battle5001") and Flg.Check("Battle5002") == false then
      Recover()
      Battle.SetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
      Flg.Set("Battle5411")
    elseif Flg.Check("Battle5002") and Flg.Check("Battle5010") == false then
      Recover()
      Battle.SetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
      Flg.Set("Battle5411")
    end
  end
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_22_565")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
end

function CoverFireStart()
  Battle.SetEffectScriptLoopInterval(EFF_01, 44)
  Battle.PlayEffectScript(EFF_01, 4.4)
  Battle.SetEffectScriptPosition(EFF_01, -18.58, 46.3, -99.55)
  Battle.SetEffectScriptLoopInterval(EFF_03, 35.5)
  Battle.PlayEffectScript(EFF_03, 3.5)
  Battle.SetEffectScriptPosition(EFF_03, -58.06, 48.85, -104.34)
  Battle.SetEffectScriptLoopInterval(EFF_05, 33.5)
  Battle.PlayEffectScript(EFF_05, 3.3)
  Battle.SetEffectScriptPosition(EFF_05, -78.94, 51.45, -169.85)
  Battle.SetEffectScriptLoopInterval(EFF_07, 25)
  Battle.PlayEffectScript(EFF_07, 2.5)
  Battle.SetEffectScriptPosition(EFF_07, -28.62, -3.59, -100.15)
  Battle.SetEffectScriptLoopInterval(EFF_09, 37)
  Battle.PlayEffectScript(EFF_09, 3.7)
  Battle.SetEffectScriptPosition(EFF_09, 39.52, -18.59, -108.45)
  Battle.SetEffectScriptLoopInterval(EFF_11, 29.5)
  Battle.PlayEffectScript(EFF_11, 2.9)
  Battle.SetEffectScriptPosition(EFF_11, 69.77, -13.34, -167.73)
  Battle.SetEffectScriptLoopInterval(EFF_13, 45.5)
  Battle.PlayEffectScript(EFF_13, 4.5)
  Battle.SetEffectScriptPosition(EFF_13, 66.21, 10.15, -66.76)
  Battle.SetEffectScriptLoopInterval(EFF_15, 50)
  Battle.PlayEffectScript(EFF_15, 5)
  Battle.SetEffectScriptPosition(EFF_15, 29.83, 41.4, -103.05)
  Battle.SetEffectScriptLoopInterval(EFF_17, 31.5)
  Battle.PlayEffectScript(EFF_17, 3.1)
  Battle.SetEffectScriptPosition(EFF_17, 73.52, 52.65, -168.98)
  Battle.SetEffectScriptLoopInterval(EFF_19, 26.5)
  Battle.PlayEffectScript(EFF_19, 2.6)
  Battle.SetEffectScriptPosition(EFF_19, 45.54, 80.85, -142.77)
  Battle.SetEffectScriptLoopInterval(EFF_21, 42)
  Battle.PlayEffectScript(EFF_21, 4.2)
  Battle.SetEffectScriptPosition(EFF_21, -60.61, 80.85, -127.57)
end

function CoverFireStop()
  Battle.StopEffectScript(EFF_01, 0)
  Battle.StopEffectScript(EFF_03, 0)
  Battle.StopEffectScript(EFF_05, 0)
  Battle.StopEffectScript(EFF_07, 0)
  Battle.StopEffectScript(EFF_09, 0)
  Battle.StopEffectScript(EFF_11, 0)
  Battle.StopEffectScript(EFF_13, 0)
  Battle.StopEffectScript(EFF_15, 0)
  Battle.StopEffectScript(EFF_17, 0)
  Battle.StopEffectScript(EFF_19, 0)
  Battle.StopEffectScript(EFF_21, 0)
end

function CoverFirePlay()
  if Flg.Check("Battle5008") == false then
    Battle.PlayEffectScript(EFF_03, 0)
    Battle.PlayEffectScript(EFF_07, 0)
    Battle.PlayEffectScript(EFF_05, 0)
  end
  if Flg.Check("Battle5001") == false then
    Battle.PlayEffectScript(EFF_01, 0)
    Battle.PlayEffectScript(EFF_11, 0)
  end
  if Flg.Check("Battle5002") == false then
    Battle.PlayEffectScript(EFF_09, 0)
    Battle.PlayEffectScript(EFF_13, 0)
  end
  if Flg.Check("Battle5003") == false then
    Battle.PlayEffectScript(EFF_17, 0)
    Battle.PlayEffectScript(EFF_19, 0)
  end
  if Flg.Check("Battle5004") == false then
    Battle.PlayEffectScript(EFF_15, 0)
  end
  if Flg.Check("Battle5008") == true and Flg.Check("Battle5004") == false then
    Battle.PlayEffectScript(EFF_21, 0)
  end
end

function ChangeBGM(bgm_id, fade_out_time, fade_in_time)
  if not Sound.IsPlayingBGM(bgm_id) then
    Sound.StopBGM(fade_out_time)
    Sound.LoadBGM(bgm_id)
    while Sound.IsLoadingBGM() do
      WaitFrame(1)
    end
    Sound.PlayBGM(bgm_id, fade_in_time)
  end
end

function Flgcount()
  local flgcount = 0
  if Flg.Check("Battle5011") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5012") then
    flgcount = flgcount + 6
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
  if Flg.Check("Battle5017") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5018") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5019") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5020") then
    flgcount = flgcount + 1
  end
  if Flg.Check("Battle5021") then
    flgcount = flgcount + 6
  end
  if Flg.Check("Battle5022") then
    flgcount = flgcount + 6
  end
  print("##### Flgcount = ", flgcount, " #####")
  return flgcount
end

function Reset()
  print("##### Reset #####")
  Flg.Clear("Battle5011")
  Flg.Clear("Battle5012")
  Flg.Clear("Battle5013")
  Flg.Clear("Battle5014")
  Flg.Clear("Battle5015")
  Flg.Clear("Battle5016")
  Flg.Clear("Battle5017")
  Flg.Clear("Battle5018")
  Flg.Clear("Battle5019")
  Flg.Clear("Battle5020")
  Flg.Clear("Battle5021")
  Flg.Clear("Battle5022")
  Flg.Clear("Battle5051")
  Flg.Clear("Battle5054")
  Flg.Clear("Battle5300")
  Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
end

function Chrono_first_Recover()
  if Flg.Check("Battle5023") == false then
    WaitFrame(60)
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-0.75, 1.52, -24.13, -0.88, 5.59, -33.26, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    Battle.MessageTalk(1200020220)
    WaitMessage()
    Battle.MessageTalk(1200020221)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5023")
  end
end

function Recover()
  print("##### Recover #####")
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  local max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local add_max_hp = 0
  if Flg.Check("Battle5053") then
    add_max_hp = Battle.GetStatus(ADD_TARGET, 0, STATUS_TYPE_HP_MAX)
  end
  CoverFireStop()
  Battle.ForceEndAnnouncementMessage()
  Battle.SetMonochrome(true)
  Battle.SetNegative(true)
  Talk.OpenLetterBox()
  Battle.CloseUI()
  Battle.SetCamera(-0.75, 1.52, -24.13, -0.88, 5.59, -33.26, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
  Battle.MessageTalk(1200020217)
  WaitMessage()
  Talk.CloseLetterBox()
  Battle.CloseTalk()
  while not Battle.IsCloseTalk() do
    WaitFrame(1)
  end
  Battle.StartScreenCaptureDraw()
  WaitFrame(50)
  if Flg.Check("Battle5002") == false then
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, enemy_now_hp + max_hp * 0.6)
  elseif Flg.Check("Battle5002") and Flg.Check("Battle5010") == false then
    Battle.SetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP, max_hp)
  end
  if Flg.Check("Battle5001") == false then
    print("##### ResetIntervalDamage #####")
    Battle.ResetIntervalDamage()
  end
  Battle.EndScreenCaptureDraw()
  slot = Sound.PlaySE(300113, 100, false)
  Battle.PlayScreenCrackingEffect()
  Battle.SetMonochrome(false)
  Battle.SetNegative(false)
  WaitFrame(10)
  Sound.StopSE(slot, 0)
  Chrono_first_Recover()
  CoverFirePlay()
  if Flg.Check("Battle5001") == false then
    Battle.SetIsStopIntervalDamage(false)
  end
  print("##### Recover End #####")
end

function Get_Aegiomon_Announcement_Id(aegiomon_announcement_id)
  local aegiomon_degimon_id = Battle.GetDigimonId(GUEST_AEGIOMON, 0)
  if aegiomon_degimon_id == AEGIOCHUSMON_ID then
    aegiomon_announcement_id = aegiomon_announcement_id + 200
  elseif aegiomon_degimon_id == AEGIOCHUSMON_DARK_ID then
    aegiomon_announcement_id = aegiomon_announcement_id + 300
  elseif aegiomon_degimon_id == AEGIOCHUSMON_HOLLY_ID then
    aegiomon_announcement_id = aegiomon_announcement_id + 400
  elseif aegiomon_degimon_id == AEGIOCHUSMON_BLUE_ID then
    aegiomon_announcement_id = aegiomon_announcement_id + 500
  elseif aegiomon_degimon_id == AEGIOCHUSMON_GREEN_ID then
    aegiomon_announcement_id = aegiomon_announcement_id + 600
  end
  return aegiomon_announcement_id
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
