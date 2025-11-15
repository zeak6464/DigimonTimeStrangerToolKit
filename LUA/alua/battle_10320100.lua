require("include_battle")
Round = 0
OBJ_01 = 1
OBJ_02 = 2
OBJ_03 = 3
OBJ_04 = 4
OBJ_05 = 5
EFF_01 = 1

function Battle_Before_Setup()
  Battle.SetBattleSettingFlag(BATTLE_SETTING_NOT_SYSTEM_FADE_IN, true)
  Battle.LoadObject(OBJ_01, "npc006aa010101")
  Battle.LoadObject(OBJ_02, "npc007aa010101")
  Battle.LoadObject(OBJ_03, "npc002aa010101")
  Battle.LoadObject(OBJ_04, "*MalePlayer")
  Battle.LoadObject(OBJ_05, "*FemalePlayer")
  Battle.LoadObjectAnimation(OBJ_01, "bn01")
  Battle.LoadObjectAnimation(OBJ_02, "bn01")
  Battle.LoadObjectAnimation(OBJ_03, "e013")
  Battle.LoadObjectAnimation(OBJ_04, "e004")
  Battle.LoadObjectAnimation(OBJ_05, "e004")
  Battle.LoadTalk("battle")
  BtlSetFlexiblePartyByAegiomonOnly(true)
  Battle.LoadEffectScript(EFF_01, "ef_b_bar_123")
end

function Battle_After_Setup()
  SetEndrollMember(10320100)
end

function Battle_After_Build()
end

function Battle_Opening(info)
  Fade.OutNotLoading(0, Util.SecondFromFrame(0))
  Sound.PlayBGM(801, 0)
  if Flg.Check("Battle5499") == false then
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m070_060")
    Fade.In(1, Util.SecondFromFrame(10))
  elseif Flg.Check("Battle5499") then
    Sound.PlayBGM(801, 0)
    Fade.AllIn(0, Util.SecondFromFrame(15))
  end
  local player = Common.GetPlayerAvatarType()
  Battle.SetObjectVisible(OBJ_01, true)
  Battle.SetObjectVisible(OBJ_02, true)
  Battle.SetObjectVisible(OBJ_03, true)
  Battle.PlayObjectAnimation(OBJ_01, "bn01", true)
  Battle.PlayObjectAnimation(OBJ_02, "bn01", true)
  Battle.PlayObjectAnimation(OBJ_03, "e013", true)
  Battle.SetObjectPosition(OBJ_01, 0.45, 0, -10.77)
  Battle.SetObjectPosition(OBJ_02, -1.56, 0, -10.77)
  Battle.SetObjectPosition(OBJ_03, -6.74, 0, 13.63)
  Battle.SetObjectRotation(OBJ_03, 0, 150, 0)
  if player == PLAYER_AVATAR_TYPE_HERO then
    Battle.SetObjectVisible(OBJ_04, true)
    Battle.PlayObjectAnimation(OBJ_04, "e004", true)
    Battle.SetObjectPosition(OBJ_04, -5.9, 0, 14.38)
    Battle.SetObjectRotation(OBJ_04, 0, 155, 0)
  else
    Battle.SetObjectVisible(OBJ_05, true)
    Battle.PlayObjectAnimation(OBJ_05, "e004", true)
    Battle.SetObjectPosition(OBJ_05, -5.9, 0, 14.38)
    Battle.SetObjectRotation(OBJ_05, 0, 155, 0)
  end
end

function Battle_Start(info)
  Battle.SetCharacterSettingFlag(ENEMY_DIGIMON, 0, BATTLE_CHARACTER_SETTING_REMAIN_HP_1, true)
  Battle.AttatchEffectScriptToModel(EFF_01, ENEMY_DIGIMON, 0)
  Battle.PlayEffectScript(EFF_01, 0)
end

function Battle_Round_Start(info)
  local kouan1_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  Round_HP = kouan1_hp
  BtlSetInterruptCharacter(ENEMY_DIGIMON, 0, BATTLE_INTERRUPT_TYPE_NORMAL)
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
  local belong_type = info.group
  local kouan1_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if belong_type == PLAYER_DIGIMON or belong_type == GUEST_AEGIOMON then
    if Flg.Check("Battle5001") == false then
      if kouan1_hp < Round_HP then
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(-0.45, 1.16, -7.16, -0.49, 1.43, -7.98, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.SetModelPosition(ENEMY_PLAYER, 0, -0.52, 0, -8.06)
        Battle.MessageTalk(1032010001)
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
      if kouan1_hp < Round_HP then
        Talk.OpenLetterBox()
        Battle.CloseUI()
        Battle.SetCamera(-0.45, 1.16, -7.16, -0.49, 1.43, -7.98, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
        Battle.SetModelPosition(ENEMY_PLAYER, 0, -0.52, 0, -8.06)
        Battle.MessageTalk(1032010002)
        WaitMessage()
        Talk.CloseLetterBox()
        Battle.CloseTalk()
        while not Battle.IsCloseTalk() do
          WaitFrame(1)
        end
        Round_HP = 0
        Flg.Set("Battle5002")
      end
    elseif Flg.Check("Battle5002") and Flg.Check("Battle5003") == false and kouan1_hp < Round_HP then
      Talk.OpenLetterBox()
      Battle.CloseUI()
      Battle.SetCamera(-0.45, 1.16, -7.16, -0.49, 1.43, -7.98, DEFAULT_ANGLE, 0, MODE_QUADRATIC_IN_OUT)
      Battle.SetModelPosition(ENEMY_PLAYER, 0, -0.52, 0, -8.06)
      Battle.MessageTalk(1032010003)
      WaitMessage()
      Talk.CloseLetterBox()
      Battle.CloseTalk()
      while not Battle.IsCloseTalk() do
        WaitFrame(1)
      end
      Round_HP = 0
      Flg.Set("Battle5003")
    end
  end
end

function Battle_Turn_End(info)
  local belong_type = info.group
  local kouan1_hp = Battle.GetStatus(ENEMY_DIGIMON, 0, STATUS_TYPE_HP)
  if (Flg.Check("Battle5003") or kouan1_hp == 1) and (belong_type == PLAYER_DIGIMON or belong_type == GUEST_AEGIOMON) then
    Flg.Set("FLAG_MAIN_03_140")
    Battle.CloseUI()
    Battle.ReadyNextSceneForVista()
    Execute("m070_070")
    Battle.ForceEnd()
  end
end

function Battle_Win(info)
end

function Battle_Lose(info)
end

function Battle_Ending(info)
  Battle.ResetFlexibleParty()
end
