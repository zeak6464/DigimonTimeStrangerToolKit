require("function_control")
DEFINE_FLAG("FLAG_GIMMICK_D06_060")
DEFINE_FLAG("FLAG_GIMMICK_D06_020")
DEFINE_FLAG("FLAG_GIMMICK_D06_070")
DEFINE_FLAG("FLAG_GIMMICK_D06_030")
DEFINE_FLAG("FLAG_GIMMICK_D06_080")
DEFINE_FLAG("FLAG_GIMMICK_D06_040")
DEFINE_FLAG("FLAG_FIELD_D0609_010")
DEFINE_FLAG("FLAG_FIELD_D0609_020")
DEFINE_FLAG("FLAG_FIELD_D0609_030")
DEFINE_FLAG("FLAG_MAIN_19_010")
DEFINE_FLAG("FLAG_MAIN_19_015")
DEFINE_FLAG("FLAG_MAIN_19_063")
DEFINE_FLAG("FLAG_MAIN_19_065")
DEFINE_FLAG("FLAG_MAIN_19_078")
DEFINE_FLAG("FLAG_MAIN_19_079")
DEFINE_FLAG("FLAG_MAIN_19_080")
DEFINE_FLAG("FLAG_MAIN_19_083")
DEFINE_FLAG("FLAG_MAIN_19_052")
DEFINE_FLAG("FLAG_MAIN_19_065")
DEFINE_FLAG("FLAG_MAIN_20_015")
DEFINE_FLAG("FLAG_MAIN_20_016")
DEFINE_FLAG("FLAG_MAIN_20_017")
DEFINE_FLAG("FLAG_MAIN_20_018")
DEFINE_FLAG("FLAG_MAIN_20_019")
DEFINE_FLAG("FLAG_MAIN_20_021")
DEFINE_FLAG("FLAG_MAIN_20_022")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gThunderBoltTimer1 = 0
gThunderBoltTimer2 = 0
gThunderBoltTimer3 = 0
gThunderBoltTimer4 = 0
gThunderBoltTimer5 = 0
gEnemyCountForVoice = 0
witchmon_speed = 9
aim_a = 0
cam_a = 0
speed_a = 0
cam_time = 0
aim_a2 = 0
cam_a2 = 0
g_SearchEye = {}
g_x = {}
g_y = {}
g_z = {}
g_angle = {}

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  if gMapNum == 602 then
    LoadLocatorModel(gPlanData)
    AddCameraLoad("d0607_railcam")
    LoadEffectScript("ef_b_bos_111", 5)
  elseif gMapNum == 603 then
    LoadRailMove(gRailMoveFile)
    local oga = GetIndex(NPC, "npc_0042")
    Npc(oga).LoadMoveMotion("symbol01")
    local huga = GetIndex(NPC, "npc_0043")
    Npc(huga).LoadMoveMotion("symbol01")
    local hyoga = GetIndex(NPC, "npc_0044")
    Npc(hyoga).LoadMoveMotion("symbol01")
  elseif gMapNum == 604 then
    LoadRailMove(gRailMoveFile)
    local fake = GetIndex(NPC, "npc_129")
    Npc(fake).LoadMoveMotion("symbol01")
  elseif gMapNum == 607 then
    Player().LoadExpression("E04_M14")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 601 then
  elseif gMapNum == 602 then
  elseif gMapNum == 603 then
    SetExternalVariable("tunomon_state", "Initialize")
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 602 then
    if FlagCheck(FLAG_MAIN_19_010) and not FlagCheck(FLAG_MAIN_19_015) then
    elseif FlagCheck(FLAG_MAIN_19_063) and not FlagCheck(FLAG_MAIN_19_065) then
    else
      DisableLinkCollisionInNowFrame("col_d0601_start_01_1")
    end
  elseif gMapNum == 603 then
  elseif gMapNum == 607 then
    local prohibited = GetExternalVariable("Operation_prohibited")
    if prohibited == "On" then
      DisableMenuInNowFrame()
    end
  end
end

function Update(elapsed_frame)
  if GetExternalVariable("theater_state") == "play" then
    local theater_loc = string.sub(GetExternalVariable("theater_place"), 10)
    local start_loc = string.sub(GetExternalVariable("theater_place"), 1, 8)
    TheaterDoorCam(theater_loc, start_loc, elapsed_frame)
  else
    for i = 1, 2 do
      local theater = GetIndex(GIM, "theater_00" .. string.format("%02d", i))
      if theater ~= nil and LocatorObject(theater).IsPlayingMotion("e001") == false then
        LocatorObject(theater).LoadMotion("e001")
        LocatorObject(theater).Motion_PlayMotion("e001", 0, true)
      end
    end
  end
  if gMapNum == 602 then
    local npc_0001 = GetIndex(NPC, "npc_0001")
    if GetExternalVariable("npc_ctrl_state") == "rotate01" then
      Npc(npc_0001).Move_SetRotationY(270, 0)
    end
    if FlagCheck(FLAG_MAIN_19_052) and not FlagCheck(FLAG_MAIN_19_063) then
      gThunderBoltTimer1 = gThunderBoltTimer1 + elapsed_frame
      gThunderBoltTimer2 = gThunderBoltTimer2 + elapsed_frame
      gThunderBoltTimer3 = gThunderBoltTimer3 + elapsed_frame
      gThunderBoltTimer4 = gThunderBoltTimer4 + elapsed_frame
      gThunderBoltTimer5 = gThunderBoltTimer5 + elapsed_frame
      local timer1 = 90
      local timer2 = 175
      local timer3 = 295
      local timer4 = 380
      local timer5 = 435
      if timer1 <= gThunderBoltTimer1 then
        local index = GetIndex(GIMMICK_OBJECT_TYPE, "tag_ThunderBolt01")
        local x, y, z = Gimmick(index).GetPosition()
        PlayEffectScript("ef_b_bos_111", x, y, z, 0, 1)
        PlaySE(300210, 75)
        gThunderBoltTimer1 = 0
      end
      if timer2 <= gThunderBoltTimer2 then
        local index = GetIndex(GIMMICK_OBJECT_TYPE, "tag_ThunderBolt01")
        local x, y, z = Gimmick(index).GetPosition()
        PlayEffectScript("ef_b_bos_111", x, y, z, 0, 1)
        PlaySE(300210, 75)
        gThunderBoltTimer2 = 0
      end
      if timer3 <= gThunderBoltTimer3 then
        local index = GetIndex(GIMMICK_OBJECT_TYPE, "tag_ThunderBolt03")
        local x, y, z = Gimmick(index).GetPosition()
        PlayEffectScript("ef_b_bos_111", x, y, z, 0, 1)
        PlaySE(300210, 75)
        gThunderBoltTimer3 = 0
      end
      if timer4 <= gThunderBoltTimer4 then
        local index = GetIndex(GIMMICK_OBJECT_TYPE, "tag_ThunderBolt04")
        local x, y, z = Gimmick(index).GetPosition()
        PlayEffectScript("ef_b_bos_111", x, y, z, 0, 1)
        PlaySE(300210, 75)
        gThunderBoltTimer4 = 0
      end
      if timer5 <= gThunderBoltTimer5 then
        local index = GetIndex(GIMMICK_OBJECT_TYPE, "tag_ThunderBolt05")
        local x, y, z = Gimmick(index).GetPosition()
        PlayEffectScript("ef_b_bos_111", x, y, z, 0, 1)
        PlaySE(300210, 75)
        gThunderBoltTimer5 = 0
      end
    end
  elseif gMapNum == 603 then
    local g_SearchEye = {}
    local g_x = {}
    local g_y = {}
    local g_z = {}
    local g_angle = {}
    g_SearchEye[1] = GetIndex(OGIM, "fa_searcheye_01")
    g_SearchEye[2] = GetIndex(OGIM, "fa_searcheye_02")
    g_SearchEye[3] = GetIndex(OGIM, "fa_searcheye_03")
    g_SearchEye[4] = GetIndex(OGIM, "fa_searcheye_04")
    g_SearchEye[5] = GetIndex(OGIM, "fa_searcheye_05")
    g_SearchEye[6] = GetIndex(OGIM, "fa_searcheye_06")
    g_x[1], g_y[1], g_z[1] = Gimmick(g_SearchEye[1]).GetPosition()
    g_x[2], g_y[2], g_z[2] = Gimmick(g_SearchEye[2]).GetPosition()
    g_x[3], g_y[3], g_z[3] = Gimmick(g_SearchEye[3]).GetPosition()
    g_x[4], g_y[4], g_z[4] = Gimmick(g_SearchEye[4]).GetPosition()
    g_x[5], g_y[5], g_z[5] = Gimmick(g_SearchEye[5]).GetPosition()
    g_x[6], g_y[6], g_z[6] = Gimmick(g_SearchEye[6]).GetPosition()
    for i = 1, 6 do
      local player_x, player_y, player_z = Player().GetPosition()
      g_angle[i] = GetAngleToTarget2D(g_x[i], g_z[i], player_x, player_z)
      Gimmick(g_SearchEye[i]).Move_SetRotationY(g_angle[i], 10)
    end
    local index = GetIndex(ENEMY, "enemy_01")
    if SymbolEnemy(index).Exists() then
      SymbolEnemy(index).SymbolForcedDiscovery(true)
    end
    local index = GetIndex(ENEMY, "enemy_02")
    if SymbolEnemy(index).Exists() then
      SymbolEnemy(index).SymbolForcedDiscovery(true)
    end
    local index = GetIndex(ENEMY, "enemy_03")
    if SymbolEnemy(index).Exists() then
      SymbolEnemy(index).SymbolForcedDiscovery(true)
    end
    local index = GetIndex(ENEMY, "enemy_04")
    if SymbolEnemy(index).Exists() then
      SymbolEnemy(index).SymbolForcedDiscovery(true)
    end
    local cam_state = GetExternalVariable("cam_state")
    if cam_state == "run" then
      local cam_add = 0
      cam_time = cam_time + elapsed_frame
      local second = SecondFromFrame(cam_time)
      local witchmon = GetIndex(NPC, "npc_0006")
      local pos_x, pos_y, pos_z = Npc(witchmon).GetPosition()
      Npc(witchmon).DisableCullingInNowFrame()
      Npc(witchmon).SuspendAutoTransparentForCameraInNowFrame()
      Npc(witchmon).LinkToRailMove("d0603_railmove", "rail_move_100")
      Npc(witchmon).Physics_SetCollisionContactForNotHit()
      Npc(witchmon).Physics_SetGravity(0)
      local add = 0
      local aim = 0
      local cam = 0
      if second <= 2 then
        aim = pos_z - 14.25
        cam = pos_z - 4.25
      elseif 2 < second then
        aim_a = aim_a + 0.1111111111111111
        cam_a = cam_a + 0.06666666666666667
        if -14.25 + aim_a > -7.75 then
          aim = pos_z - 7.75
        else
          aim = pos_z - 14.25 + aim_a
        end
        if -4.25 + cam_a > 1.75 then
          cam = pos_z + 1.75
        else
          cam = pos_z - 4.25 + cam_a
        end
        if Npc(witchmon).IsArrivalRailBothEnds() then
          aim_a2 = aim_a2 + 0.03
          cam_a2 = cam_a2 + 0.03
          aim = pos_z - 7.75 + aim_a2
          cam = pos_z + 1.75 + cam_a2
        end
      end
      SetInstantCameraInNowFrame(-8, 2.51, aim, -8, 1.5, cam, DEFAULT_ANGLE, 0, 0, false)
      if not Npc(witchmon).IsArrivalRailBothEnds() then
        if second <= 1.5 then
          witchmon_speed = witchmon_speed
        elseif 1.5 < second and second <= 2.5 then
          speed_a = speed_a + 0.005
          witchmon_speed = witchmon_speed + speed_a
        else
          witchmon_speed = witchmon_speed
        end
        Npc(witchmon).SetRailMoveInDimension2d()
        Npc(witchmon).SetRailMoveSpeed(witchmon_speed)
        Npc(witchmon).RailMoveGo()
      end
    end
    if FlagCheck(FLAG_MAIN_19_078) and not FlagCheck(FLAG_MAIN_19_079) then
      local ogarun01_state = GetExternalVariable("ogarun01_state")
      if ogarun01_state == "ogarun01" then
        local oga = GetIndex(NPC, "npc_0042")
        local huga = GetIndex(NPC, "npc_0043")
        local hyoga = GetIndex(NPC, "npc_0044")
        local speed = 10
        Npc(oga).LinkToRailMove("d0603_railmove", "rail_move_08")
        Npc(huga).LinkToRailMove("d0603_railmove", "rail_move_09")
        Npc(hyoga).LinkToRailMove("d0603_railmove", "rail_move_10")
        if not Npc(oga).IsArrivalRailBothEnds() then
          Npc(oga).Physics_SetCollisionContactForNotHit()
          Npc(oga).Physics_SetGravity(0)
          Npc(oga).SetRailMoveSpeed(speed)
          Npc(oga).SetRailMoveInDimension3d()
          Npc(oga).RailMoveGo()
        end
        if not Npc(huga).IsArrivalRailBothEnds() then
          Npc(huga).Physics_SetCollisionContactForNotHit()
          Npc(huga).Physics_SetGravity(0)
          Npc(huga).SetRailMoveSpeed(speed)
          Npc(huga).SetRailMoveInDimension3d()
          Npc(huga).RailMoveGo()
        end
        if not Npc(hyoga).IsArrivalRailBothEnds() then
          Npc(hyoga).Physics_SetCollisionContactForNotHit()
          Npc(hyoga).Physics_SetGravity(0)
          Npc(hyoga).SetRailMoveSpeed(speed)
          Npc(hyoga).SetRailMoveInDimension3d()
          Npc(hyoga).RailMoveGo()
        end
        if Npc(oga).IsArrivalRailBothEnds() and Npc(huga).IsArrivalRailBothEnds() and Npc(hyoga).IsArrivalRailBothEnds() then
          SetExternalVariable("ogarun01_state", "end")
        end
      elseif ogarun01_state == "end" then
        local oga = GetIndex(NPC, "npc_0042")
        local huga = GetIndex(NPC, "npc_0043")
        local hyoga = GetIndex(NPC, "npc_0044")
        Npc(oga).Move_SetRotationY(0, 10)
        Npc(huga).Move_SetRotationY(0, 10)
        Npc(hyoga).Move_SetRotationY(0, 10)
      end
    end
    if FlagCheck(FLAG_MAIN_19_078) and not FlagCheck(FLAG_MAIN_19_079) then
      local ogarun02_state = GetExternalVariable("ogarun02_state")
      if ogarun02_state == "ogarun02" then
        local oga = GetIndex(NPC, "npc_0042")
        local huga = GetIndex(NPC, "npc_0043")
        local hyoga = GetIndex(NPC, "npc_0044")
        local speed = 12
        Npc(oga).LinkToRailMove("d0603_railmove", "rail_move_11")
        Npc(huga).LinkToRailMove("d0603_railmove", "rail_move_12")
        Npc(hyoga).LinkToRailMove("d0603_railmove", "rail_move_13")
        if not Npc(oga).IsArrivalRailBothEnds() then
          Npc(oga).Physics_SetCollisionContactForNotHit()
          Npc(oga).Physics_SetGravity(0)
          Npc(oga).SetRailMoveSpeed(speed)
          Npc(oga).SetRailMoveInDimension3d()
          Npc(oga).RailMoveGo()
        end
        if not Npc(huga).IsArrivalRailBothEnds() then
          Npc(huga).Physics_SetCollisionContactForNotHit()
          Npc(huga).Physics_SetGravity(0)
          Npc(huga).SetRailMoveSpeed(speed)
          Npc(huga).SetRailMoveInDimension3d()
          Npc(huga).RailMoveGo()
        end
        if not Npc(hyoga).IsArrivalRailBothEnds() then
          Npc(hyoga).Physics_SetCollisionContactForNotHit()
          Npc(hyoga).Physics_SetGravity(0)
          Npc(hyoga).SetRailMoveSpeed(speed)
          Npc(hyoga).SetRailMoveInDimension3d()
          Npc(hyoga).RailMoveGo()
        end
        if Npc(oga).IsArrivalRailBothEnds() and Npc(huga).IsArrivalRailBothEnds() and Npc(hyoga).IsArrivalRailBothEnds() then
          SetExternalVariable("ogarun02_state", "end")
        end
      elseif ogarun02_state == "end" then
      end
    end
  elseif gMapNum == 604 then
    local index = GetIndex(ENEMY, "enemy_01")
    if SymbolEnemy(index).Exists() then
      SymbolEnemy(index).SymbolForcedDiscovery(true)
    end
    if FlagCheck(FLAG_MAIN_19_080) and not FlagCheck(FLAG_MAIN_19_083) then
      local fakerun01_state = GetExternalVariable("fakerun01_state")
      if fakerun01_state == "fakerun01" then
        local fake = GetIndex(NPC, "npc_129")
        local speed = 8
        Npc(fake).LinkToRailMove("d0604_railmove", "rail_move_06")
        Npc(fake).Physics_SetCollisionContactForNotHit()
        Npc(fake).Physics_SetGravity(0)
        Npc(fake).SetRailMoveSpeed(speed)
        Npc(fake).SetRailMoveInDimension3d()
        Npc(fake).RailMoveGo()
        if Npc(fake).IsArrivalRailBothEnds() then
          SetExternalVariable("fakerun01_state", "end")
        end
      elseif fakerun01_state == "end" then
      end
    end
    if FlagCheck(FLAG_MAIN_19_080) and not FlagCheck(FLAG_MAIN_19_083) then
      local ranarun01_state = GetExternalVariable("ranarun01_state")
      if ranarun01_state == "ranarun01" then
        local rana = GetIndex(NPC, "npc_131")
        local speed = 14
        Npc(rana).LinkToRailMove("d0604_railmove", "rail_move_07")
        Npc(rana).Physics_SetCollisionContactForNotHit()
        Npc(rana).Physics_SetGravity(0)
        Npc(rana).SetRailMoveSpeed(speed)
        Npc(rana).SetRailMoveInDimension3d()
        Npc(rana).RailMoveGo()
        if Npc(rana).IsArrivalRailBothEnds() then
          SetExternalVariable("ranarun01_state", "end")
        end
      elseif ranarun01_state == "end" then
      end
    end
    local tunomon_state = GetExternalVariable("tunomon_state")
    local tunomon_index = GetIndex(NPC, "npc_1049")
    local pos_x, pos_y, pos_z = Npc(tunomon_index).GetPosition()
    local player_x, player_y, player_z = Player().GetPosition()
    if tunomon_state == "turn" then
      local y_degree = GetAngleToTarget2D(pos_x, pos_z, player_x, player_z)
      Npc(tunomon_index).Move_SetRotationY(y_degree, 1)
    end
  elseif gMapNum == 607 then
    local m420_04 = GetExternalVariable("Prcs_d0607_M420_04")
    if m420_04 == "play" then
      SetExternalVariable("Prcs_d0607_M420_04", "end")
      CallEventScriptFunction("M420_Event_027")
      PlayVoiceOver("m420", "m420_015_060", 30, "m420_015_070", true)
    end
    local prohibited = GetExternalVariable("Operation_prohibited")
    if prohibited == "On" then
      Player().Move_Stop()
      if IsPlayingVoiceOver() == false then
        CallEventScriptFunction("M420_Event_028")
      end
    end
    local PlayVoice_m420_015_010 = GetExternalVariable("PlayVoice_m420_015_010")
    if PlayVoice_m420_015_010 == "play" then
      PlayVoiceFromName("m420_015_010")
      SetExternalVariable("PlayVoice_m420_015_010", "end")
    end
    local PlayVoice_m420_015_030 = GetExternalVariable("PlayVoice_m420_015_030")
    if PlayVoice_m420_015_030 == "play" then
      PlayVoiceFromName("m420_015_030")
      SetExternalVariable("PlayVoice_m420_015_030", "end")
    end
    local PlayVoice_m420_015_050 = GetExternalVariable("PlayVoice_m420_015_050")
    if PlayVoice_m420_015_050 == "play" then
      PlayVoiceFromName("m420_015_050")
      SetExternalVariable("PlayVoice_m420_015_050", "end")
    end
    if FlagCheck(FLAG_MAIN_20_016) and not FlagCheck(FLAG_MAIN_20_018) then
      local p_rot = Player().GetRotationY()
      local p_posx, p_posy, p_posz = Player().GetPosition()
      local vec_x, vec_z = GetUnitVector2D(p_rot)
      local aim_posx = p_posx + vec_x * 15
      local aim_posy = p_posy - 1
      local aim_posz = p_posz + vec_z * 15
      Player().Motion_AimOnlyThisFrame(aim_posx, aim_posy, aim_posz, 15, 15, 13)
      Player().Motion_ChangeExpression("E04_M14", EYES_BLINK_TYPE_OPEN, false, 5, AUTO_CANCEL_NEXT_FRAME, 5)
    elseif FlagCheck(FLAG_MAIN_20_018) and not FlagCheck(FLAG_MAIN_20_021) then
      local p_rot = Player().GetRotationY()
      local p_posx, p_posy, p_posz = Player().GetPosition()
      local vec_x, vec_z = GetUnitVector2D(p_rot)
      local aim_posx = p_posx + vec_x * 5
      local aim_posy = p_posy - 1
      local aim_posz = p_posz + vec_z * 5
      Player().Motion_AimOnlyThisFrame(aim_posx, aim_posy, aim_posz, 15, 15, 13)
      Player().Motion_ChangeExpression("E04_M14", EYES_BLINK_TYPE_OPEN, false, 5, AUTO_CANCEL_NEXT_FRAME, 5)
    end
  elseif gMapNum == 609 then
    local operatedegrees = GetLeftAxisMoveOperateDegrees()
    local speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
    if EnableOperatePlayer() and IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil then
      if 0 < operatedegrees and operatedegrees < 180 then
        Player().Move_Move2D(90, speed)
      else
        Player().Move_Move2D(270, speed)
      end
    end
  end
end

function OnEncountSymbolEnemy(object_index, args)
  if gMapNum == 601 then
  elseif gMapNum == 609 then
    CallEventScriptFunction("Prcs_d0609_Restart")
    return false
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  if gMapNum == 601 then
  elseif gMapNum == 609 then
    if SymbolEnemy(symbol_index).GetUniqueName() == "enemy_15_01" then
      FlagSet(FLAG_FIELD_D0609_010)
    end
    if SymbolEnemy(symbol_index).GetUniqueName() == "enemy_15_02" then
      FlagSet(FLAG_FIELD_D0609_020)
    end
    if FlagCheck(FLAG_FIELD_D0609_010) and FlagCheck(FLAG_FIELD_D0609_020) then
      CallEventScriptFunction("Prcs_d0609_BossCam")
    end
  end
end

function OnFieldAttackSymbolEnemy(object_index, args)
  if gMapNum == 609 then
    local unique_name = SymbolEnemy(object_index).GetUniqueName()
    gEnemyCountForVoice = gEnemyCountForVoice + 1
    if unique_name == "enemy_Grankuwaga02" then
      CallEventScriptFunction("M190_Event_020")
    elseif gEnemyCountForVoice % 2 == 0 then
      math.randomseed(os.time())
      local random = math.random(1, 100)
      if random <= 50 then
        PlayVoiceFromName("vo_npc001_Joy_001")
      elseif 51 < random then
        PlayVoiceFromName("vo_mpc183_Joy_001")
      end
    end
    return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
  end
end

function OnTouchCollision(col_name)
  if gMapNum == 607 then
    if col_name == "evt_1000" then
      if FlagCheck(FLAG_MAIN_20_015) and not FlagCheck(FLAG_MAIN_20_016) then
        FlagSet(FLAG_MAIN_20_016)
        CallEventScriptFunction("Prcs_d0607_M420_01", Player().GetLastMoveSpeed())
      end
    elseif col_name == "evt_1001" then
      if FlagCheck(FLAG_MAIN_20_016) and not FlagCheck(FLAG_MAIN_20_017) then
        PlayVoiceFromName("m420_015_020")
        FlagSet(FLAG_MAIN_20_017)
      end
    elseif col_name == "evt_1002" then
      if FlagCheck(FLAG_MAIN_20_017) and not FlagCheck(FLAG_MAIN_20_018) then
        FlagSet(FLAG_MAIN_20_018)
        CallEventScriptFunction("Prcs_d0607_M420_02", Player().GetLastMoveSpeed())
      end
    elseif col_name == "evt_1003" then
      if FlagCheck(FLAG_MAIN_20_018) and not FlagCheck(FLAG_MAIN_20_019) then
        PlayVoiceFromName("m420_015_040")
        FlagSet(FLAG_MAIN_20_019)
      end
    elseif col_name == "evt_1004" then
      if FlagCheck(FLAG_MAIN_20_019) and not FlagCheck(FLAG_MAIN_20_021) then
        FlagSet(FLAG_MAIN_20_021)
        CallEventScriptFunction("Prcs_d0607_M420_03", Player().GetLastMoveSpeed())
      end
    elseif col_name == "evt_1005" and FlagCheck(FLAG_MAIN_20_021) and not FlagCheck(FLAG_MAIN_20_022) then
      SetExternalVariable("Operation_prohibited", "On")
      CallEventScriptFunction("M420_Event_027")
      PlayVoiceOver("m420", "m420_015_060", 30, "m420_015_070", true)
    end
  end
end
