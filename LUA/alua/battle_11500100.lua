require("include_battle")
Round = 0
EFF_01 = 1
EFF_02 = 2

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadEffectScript(EFF_02, "ef_b_sta_250")
  Battle.LoadTalk("battle")
end

function Battle_After_Setup()
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "ba02")
  Battle.LoadAnimation(ENEMY_DIGIMON, 0, "bn01")
  Battle.LoadEffectScript(EFF_01, "ef_b_buf_100")
  SetEndrollMember(11500100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m400_012")
    Fade.In(1, Util.SecondFromFrame(30))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(932, 1)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
end

function Battle_Start(info)
  Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
end

function Battle_Round_Start(info)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Flg.Check("Battle5012") == false and Flg.Check("Battle5053") == false then
    Round = Round + 1
  end
  if Flg.Check("Battle5053") then
    Round = Round + 1
    print("Round:", Round)
  end
  if Flg.Check("Battle5053") and Round <= 2 then
    if 0.6 <= enemy_now_hp / enemy_max_hp then
      Battle.SetFieldEffectSkill(21734, -1, -1)
    elseif enemy_now_hp / enemy_max_hp < 0.6 and 0.3 <= enemy_now_hp / enemy_max_hp then
      Battle.SetFieldEffectSkill(21735, -1, -1)
    elseif enemy_now_hp / enemy_max_hp < 0.3 then
      Battle.SetFieldEffectSkill(21736, -1, -1)
    end
  end
end

function Battle_Turn_Start(info)
  local enemy_id = info.enemy_id
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Flgcount() >= 3 then
    Flg.Set("Battle5051")
  end
  if Flg.Check("Battle5053") then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70004)
  end
  if enemy_now_hp / enemy_max_hp < 0.6 and Flg.Check("Battle5105") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-4.35, 2.65, 2.67, 0.1, 5.74, -5.71, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    WaitFrame(1)
    Battle.SetCamera(-1.71, 5.75, -3.06, 2.75, 8.84, -11.46, DEFAULT_ANGLE, 90, MODE_QUADRATIC_IN_OUT)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 0, false)
    Battle.PlayEffectScript(EFF_01, 0)
    Battle.SetEffectScriptPosition(EFF_01, 0.02, 0, -5.42)
    WaitFrame(70)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
    WaitFrame(91)
    Battle.MessageTalk(1150010004)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5105")
  elseif enemy_now_hp / enemy_max_hp < 0.3 and Flg.Check("Battle5106") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCamera(-4.35, 2.65, 2.67, 0.1, 5.74, -5.71, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
    WaitFrame(1)
    Battle.SetCamera(-1.71, 5.75, -3.06, 2.75, 8.84, -11.46, DEFAULT_ANGLE, 90, MODE_QUADRATIC_IN_OUT)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 0, false)
    Battle.PlayEffectScript(EFF_01, 0)
    Battle.SetEffectScriptPosition(EFF_01, 0.02, 0, -5.42)
    WaitFrame(70)
    BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
    WaitFrame(91)
    Battle.MessageTalk(1150010004)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5106")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70005 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 21733)
    Battle.SetTargetCursor(ENEMY_DIGIMON, 0)
    if Flg.Check("Battle5104") == false then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(0.02, 4.63, 0.52, 0.31, 5.45, -9.43, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      WaitFrame(15)
      Battle.MessageTalk(1150010002)
      WaitMessage()
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "ba02", 0, false)
      Battle.PlayEffectScript(EFF_02, 0)
      Battle.SetEffectScriptPosition(EFF_02, 0.19, 0, -6.19)
      WaitFrame(80)
      BtlPlayAnimation(ENEMY_DIGIMON, 0, "bn01", 10, true)
      Battle.MessageTalk(1150010003)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Flg.Set("Battle5104")
    end
  end
end

function Battle_Command_Start(info)
  local enemy_id = info.enemy_id
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if enemy_id == 97301 and Battle.IsBreakCPCharge() == false then
    if Flg.Check("Battle5053") == false then
      Battle.AddEnemyCP(200)
    else
      Battle.AddEnemyCP(400)
    end
  end
  if enemy_id == 97301 and enemy_now_hp / enemy_max_hp <= 0.6 and Flg.Check("Battle5051") == false and Flg.Check("Battle5001") == false then
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
    Flg.Set("Battle5001")
  end
  if Flg.Check("Battle5051") and Flg.Check("Battle5052") == false then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 41731)
    Flg.Set("Battle5052")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 41731 and enemy_id == 97301 then
    Battle.SetupCPCharge(70003, 94201, ENEMY_DIGIMON, 0, "FP01", 2)
    Flg.Set("Battle5053")
    Round = 0
    if Flg.Check("Battle5102") == false then
      Flg.Set("Battle5102")
    end
    if Flg.Check("Battle5001") == false then
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208002)
    else
      Battle.RemoveBuff(ENEMY_DIGIMON, 0, 208003)
    end
  end
  print("Round:", Round)
  if Round == 2 and Flg.Check("Battle5053") and enemy_id == 97301 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70001)
    Battle.CompleteCPCharge(70005)
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70005)
  end
end

function Battle_Action_Start(info)
  local enemy_id = info.enemy_id
  if enemy_id == 97301 and Flg.Check("Battle5104") then
    Battle.StopEffectScript(EFF_02, 0.1)
  end
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
end

function Battle_Action_End(info)
end

function Battle_Command_End(info)
  if Flg.Check("Battle5053") and Flg.Check("Battle5055") == false then
    Battle.AddBuff(ADD_TARGET, 0, 21733)
    Flg.Set("Battle5055")
  end
end

function Battle_Turn_End(info)
  local stock_num = Battle.GetCPStockNum()
  local round_count = info.round
  local enemy_max_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP_MAX)
  local enemy_now_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70001 then
    AddTarget_nobreakHP()
    BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_ACT_NO_COUNT)
  end
  if Flg.Check("Battle5053") and Flg.Check("Battle5054") == false then
    Battle.SetTargetCursor(ADD_TARGET, 0)
    Flg.Set("Battle5054")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 70007 then
    if Flg.Check("Battle5001") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    else
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
    end
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if round_count == 4 and Flg.Check("Battle5001") == false then
    Flg.Set("Battle5011")
  end
  if Round == 4 then
    Flg.Set("Battle5012")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_CP_DECREASE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 1000) then
    Flg.Set("Battle5013")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_COUNT_OVER, 2, ENEMY_DIGIMON, 0, 6) then
    Flg.Set("Battle5014")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_WAKE_DAMAGE_VALUE_OVER, 3, ENEMY_DIGIMON, 0, 5000) then
    Flg.Set("Battle5015")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_VALUE_OVER, 4, ENEMY_DIGIMON, 0, 6000) then
    Flg.Set("Battle5016")
  end
  if Battle.IsAccomplishCondition(BATTLE_CONDITION_TYPE_DAMAGE_MAGIC, 3, ENEMY_DIGIMON, 0, 3) then
    Flg.Set("Battle5017")
  end
  print("stock_num:", stock_num)
  if stock_num == 1 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
  elseif stock_num == 1 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30013)
  elseif stock_num == 2 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32051)
  elseif stock_num == 2 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30036)
  elseif stock_num == 3 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 34021)
  elseif stock_num == 3 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 32011)
  elseif stock_num == 4 and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 21737)
  elseif stock_num == 4 and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30036)
  elseif 5 <= stock_num and round_count % 2 == 0 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30013)
  elseif 5 <= stock_num and round_count % 2 == 1 then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, true)
    Battle.SetExtraTurnNextCommandSkill(ENEMY_DIGIMON, 0, 30036)
  end
  if stock_num == 0 or Flg.Check("Battle5052") then
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
  end
  if Flg.Check("Battle5102") and Flg.Check("Battle5101") == false then
    Talk.OpenLetterBox()
    Battle.CloseUI()
    Battle.SetCameraMove(30, MODE_QUADRATIC_OUT)
    Battle.SetCameraMoveStart()
    Battle.SetBattleCamera(BATTLE_CAMERA_ID_TARGET_ENEMY_SINGLE, ENEMY_DIGIMON, 0)
    Battle.MessageTalk(1150010001)
    WaitMessage()
    Talk.CloseLetterBox()
    Battle.CloseTalk()
    while not Battle.IsCloseTalk() do
      WaitFrame(1)
    end
    Flg.Set("Battle5101")
  end
  if 1 <= stock_num and Flg.Check("Battle5201") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597301)
    Flg.Set("Battle5201")
  end
  if 2 <= stock_num and Flg.Check("Battle5202") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597302)
    Flg.Set("Battle5202")
  end
  if 3 <= stock_num and Flg.Check("Battle5203") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597303)
    Flg.Set("Battle5203")
  end
  if 4 <= stock_num and Flg.Check("Battle5204") == false then
    Battle.AddBuff(ENEMY_DIGIMON, 0, 597305)
    Flg.Set("Battle5204")
  end
  if Battle.GetCharacterLastCommandSkillID(ENEMY_DIGIMON, 0) == 21733 then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5052")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5300")
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    flgcount = 0
    Round = 0
    if Flg.Check("Battle5001") == false then
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208002)
    else
      Battle.AddBuff(ENEMY_DIGIMON, 0, 208003)
    end
  end
  if Battle.IsBreakCPCharge() then
    Flg.Clear("Battle5011")
    Flg.Clear("Battle5012")
    Flg.Clear("Battle5013")
    Flg.Clear("Battle5014")
    Flg.Clear("Battle5015")
    Flg.Clear("Battle5016")
    Flg.Clear("Battle5017")
    Flg.Clear("Battle5051")
    Flg.Clear("Battle5052")
    Flg.Clear("Battle5053")
    Flg.Clear("Battle5054")
    Flg.Clear("Battle5055")
    Flg.Clear("Battle5201")
    Flg.Clear("Battle5202")
    Flg.Clear("Battle5203")
    Flg.Clear("Battle5204")
    Flg.Clear("Battle5104")
    Flg.Clear("Battle5300")
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597301)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597302)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597303)
    Battle.RemoveBuff(ENEMY_DIGIMON, 0, 597305)
    Battle.ClearAccomplishCondition(0, ENEMY_DIGIMON, 0)
    Battle.SetExtraTurn(ENEMY_DIGIMON, 0, false)
    Battle.ClearCPCharge()
    flgcount = 0
    Round = 0
    Battle.SetNextCommandSkill(ENEMY_DIGIMON, 0, 70007)
    Battle.AddBuff(ENEMY_DIGIMON, 0, 205200)
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
  if Flg.Check("Battle5017") then
    flgcount = flgcount + 1
  end
  return flgcount
end

function Battle_Win(info)
  Flg.Set("FLAG_MAIN_18_030")
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Common.SetDigimonGraspState(173, DIGIMON_GRASP_FLAG_SCAN)
  Battle.CloseUI()
  Battle.ReadyNextSceneForVista()
  Execute("m400_013")
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
