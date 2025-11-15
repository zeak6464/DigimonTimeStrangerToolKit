require("function_control")
DEFINE_FLAG("FLAG_GIMMICK_D09_040")
DEFINE_FLAG("FLAG_GIMMICK_D09_050")
DEFINE_FLAG("FLAG_GIMMICK_D09_060")
DEFINE_FLAG("FLAG_GIMMICK_D09_070")
DEFINE_FLAG("FLAG_GIMMICK_D09_200")
DEFINE_FLAG("FLAG_MAIN_22_470")
DEFINE_FLAG("FLAG_GIMMICK_D09_080")
DEFINE_FLAG("FLAG_MAIN_22_191")
DEFINE_FLAG("FLAG_MAIN_22_210")
DEFINE_FLAG("FLAG_MAIN_22_230")
DEFINE_FLAG("FLAG_MAIN_22_235")
DEFINE_FLAG("FLAG_MAIN_22_275")
DEFINE_FLAG("FLAG_MAIN_22_227")
DEFINE_FLAG("FLAG_MAIN_22_276")
DEFINE_FLAG("FLAG_MAIN_22_260")
DEFINE_FLAG("FLAG_MAIN_22_270")
DEFINE_FLAG("FLAG_MAIN_22_221")
DEFINE_FLAG("FLAG_MAIN_22_222")
DEFINE_FLAG("FLAG_MAIN_22_223")
DEFINE_FLAG("FLAG_MAIN_22_224")
DEFINE_FLAG("FLAG_MAIN_22_225")
DEFINE_FLAG("FLAG_MAIN_22_226")
DEFINE_FLAG("FLAG_MAIN_22_227")
DEFINE_FLAG("FLAG_MAIN_22_228")
DEFINE_FLAG("FLAG_MAIN_22_310")
DEFINE_FLAG("FLAG_MAIN_22_320")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gd0905FallDownTimer = 0
gd0906gimTime = 0
gd0906gimTime_preliminary = 0
gd0906gimDamageCount = 0
gd0906gimGeneratTime = 0
gd0906gimGeneratTime2 = 0
gd0906gimGeneratTime_preliminary = 0
gd0906gimAporoFloatMessage = 0
gd0906gimDianaFloatMessage = 0
gd0906gimInoriFloatMessage = 0
gd0906gimAigioFloatMessage = 0
gd0906gimMinervaFloatMessage = 0
gd0906gimAigioFloatMessageTimer = 0
gd0906gimAporoFloatMessage_Is = false
gd0906gimDianaFloatMessage_Is = false
gd0906gimAporoFloatMessage_Timer = 0
gd0906gimDianaFloatMessage_Timer = 0
gd0906gimEventTimer = 0
gd0906gimFAProcessDelay = 0
gd0906gimEnemyCounter = 0
gd0906gimEnemyGeneratCounter = 0
gd0906gimChargeTime = 0
gd0906gimChargeLv = 0
gd0906gimChargeDamageCoun = 0
BigEnemyHP_table = {}
d0906EnemyEffect_Attack = "ef_f_hit_200_nele"
d0906EnemyEffect_Vanish = "ef_b_van_100"

function LoadRequest()
  print("===============LoadRequest=====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  if gMapNum == 900 then
    CtrlLoadNPCMotion("npc0000", "r307_loop01")
    Player().LoadMotion("r307_loop01")
  end
  if gMapNum == 901 then
  elseif gMapNum == 902 then
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 903 then
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 904 then
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 905 then
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 906 then
    LoadRailMove(gRailMoveFile)
    LoadEffectScript("ef_f_mov_112_wa", 6)
    Npc(GetIndex(NPC, "npc_0001")).LoadMotion("f003")
    Npc(GetIndex(NPC, "npc_0002")).LoadMotion("bd01")
    Npc(GetIndex(NPC, "npc_0001")).LoadMotion("f000")
    Npc(GetIndex(NPC, "npc_0002")).LoadMotion("e210")
    Npc(GetIndex(NPC, "npc_0004")).LoadMotion("ba01")
    Npc(GetIndex(NPC, "npc_0005")).LoadMotion("ba01")
    Npc(GetIndex(NPC, "npc_0003")).LoadMotion("ba01")
    Npc(GetIndex(NPC, "npc_0006")).LoadMotion("ba01")
    Npc(GetIndex(NPC, "npc_0001")).LoadAttachment(1)
    Npc(GetIndex(NPC, "npc_0001")).LoadAttachment(2)
    Npc(GetIndex(NPC, "npc_0001")).LoadAttachment(3)
    Npc(GetIndex(NPC, "npc_0002")).LoadAttachment(1)
    Npc(GetIndex(NPC, "npc_0002")).LoadAttachment(2)
    Npc(GetIndex(NPC, "npc_0002")).LoadAttachment(3)
    Npc(GetIndex(NPC, "npc_0010")).LoadMotion("ba01")
    Npc(GetIndex(NPC, "npc_0010")).LoadMotion("bn01")
    Npc(GetIndex(NPC, "npc_0011")).LoadMotion("e006")
    Npc(GetIndex(NPC, "npc_0011")).LoadMotion("fn01_01")
    Npc(GetIndex(NPC, "npc_0011")).LoadMotion("e018")
    Npc(GetIndex(NPC, "npc_0011")).LoadMotion("e004_01")
  elseif gMapNum == 907 then
    LoadRailMove(gRailMoveFile)
  end
end

function FirstPeriodDeployLift()
  print("=============== FirstPeriodDeployLift =====================")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 905 then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    local start_loc = GetLastPlayerSetLocator()
    if IsJustAfterMapChangeNow() == true and (start_loc == "start_02" or start_loc == "start_03" or start_loc == "start_04" or start_loc == "start_05" or start_loc == "start_06") then
      LocatorObject(elv_0001).DeployLift(false)
    end
  end
end

function Initialize()
  print("===============Initialize=====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 900 then
    SetExternalVariable("piyo_state", "init")
  end
  if gMapNum == 901 then
    SetExternalVariable("piyo_state", "init")
  elseif gMapNum == 902 then
  elseif gMapNum == 904 then
    GetExternalVariable("player_walk", nil)
  elseif gMapNum == 905 then
    GetExternalVariable("player_walk", nil)
    gd0905FallDownTimer = 0
  elseif gMapNum == 906 then
    if not FlagCheck(FLAG_GIMMICK_D09_040) then
      gd0906gimTime = 0
      gd0906gimTime_preliminary = 0
      gd0906gimDamageCount = 0
      gd0906gimGeneratTime = 0
      gd0906gimGeneratTime2 = 0
      gd0906gimGeneratTime_preliminary = 0
      gd0906gimChargeTime = 0
      gd0906gimChargeLv = 0
      gd0906gimChargeDamageCoun = 0
      BigEnemyHP_table = {}
      SetExternalVariable("aporo_state", "charge_start")
      SetExternalVariable("diana_state", "charge_start")
      SetExternalVariable("minerva_state", "stay")
      SetExternalVariable("aporo_preliminary_state", "stay")
      SetExternalVariable("diana_preliminary_state", "stay")
      SetExternalVariable("minerva_preliminary_state", "stay")
      SetExternalVariable("gim_player_state", "usual")
      SetExternalVariable("gim_inori_state", "usual")
    end
    GetExternalVariable("player_walk", nil)
  end
end

function PreparationBeforeReactionToField()
  if GetExternalVariable("move_elv") == "moveing" then
    DisableMenuInNowFrame()
    DisableAnalyzeAndFieldAttackOnlyThisFrame()
  end
  if gMapNum == 901 then
  elseif gMapNum == 903 then
    if FlagCheck(FLAG_MAIN_22_230) and not FlagCheck(FLAG_MAIN_22_235) and (IsPadTrigger(PAD_INPUT_R2) or IsPadTrigger(PAD_INPUT_L2)) then
      local obj_pos_x, obj_pos_y, obj_pos_z = Gimmick(GetIndex(FLD_OBJ_GIMMICK, "fa_firenuts_correct")).GetPosition()
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      local distance_to_player = GetDistanceBetweenTwoObject2D(obj_pos_x, obj_pos_z, p_pos_x, p_pos_z)
      if distance_to_player <= 10 then
        CallEventScriptFunction("Prcs_d0903_EventBeforFA")
      end
    end
  elseif not (gMapNum == 906 and FlagCheck(FLAG_GIMMICK_D09_040)) or FlagCheck(FLAG_GIMMICK_D09_050) or GetExternalVariable("gim_player_state") ~= "damage" or Player().IsPlayingMotion("bd01") == false then
  else
    DisableAnalyzeAndFieldAttackOnlyThisFrame()
  end
end

function Update(elapsed_frame)
  player_state = GetExternalVariable("player_state")
  if GetExternalVariable("move_elv") == "moveing" then
    Player().Move_Stop()
  end
  if GetExternalVariable("theater_state") == "play" then
    local theater_loc = string.sub(GetExternalVariable("theater_place"), 10)
    local start_loc = string.sub(GetExternalVariable("theater_place"), 1, 8)
    TheaterDoorCam(theater_loc, start_loc, elapsed_frame)
    if gMapNum == 907 then
      local theater_door = GetIndex(FLD_OBJ_GIMMICK, "theater_access")
      Gimmick(theater_door).SetEnablePlayerCheck(false)
    end
  else
    if gMapNum == 907 then
      local theater_door = GetIndex(FLD_OBJ_GIMMICK, "theater_access")
      Gimmick(theater_door).SetEnablePlayerCheck(true)
    end
    for i = 1, 2 do
      local theater = GetIndex(GIM, "theater_00" .. string.format("%02d", i))
      if theater ~= nil and LocatorObject(theater).IsPlayingMotion("e001") == false then
        LocatorObject(theater).LoadMotion("e001")
        LocatorObject(theater).Motion_PlayMotion("e001", 0, true)
      end
    end
  end
  if gMapNum == 900 then
    local piyo_state = GetExternalVariable("piyo_state")
    if piyo_state == "fly" then
      local piyo = GetIndex(NPC, "npc0000")
      Npc(piyo).Physics_SetGravity(0)
      Player().Physics_SetGravity(0)
      Npc(piyo).Physics_SetCollisionContactForNotHit()
      Player().Physics_SetCollisionContactForNotHit()
      Npc(piyo).Move_SetPosition(-46.315, -15.477, -117.924)
      Player().Move_SetPosition(-46.315, -15.477, -117.924)
      Npc(piyo).Move_SetRotationY(330, 0)
      Player().Move_SetRotationY(330, 0)
      Npc(piyo).Motion_PlayMotion("r307_loop01", 0, true)
      Player().Motion_PlayMotion("r307_loop01", 0, true)
    end
  end
  if gMapNum == 901 then
    if GetExternalVariable("PlayVoice_Event_530_1") == "start" then
      PlayVoiceFromName("vo_mpc394_preparation_002")
      SetExternalVariable("PlayVoice_Event_530_1", "end")
    end
    if GetExternalVariable("PlayVoice_Event_530_2") == "start" then
      PlayVoiceFromName("vo_mpc579_preparation_002")
      SetExternalVariable("PlayVoice_Event_530_2", "end")
    end
    if GetExternalVariable("PlayVoice_Event_530_3") == "start" then
      PlayVoiceFromName("vo_mpc580_preparation_002")
      SetExternalVariable("PlayVoice_Event_530_3", "end")
    end
  elseif gMapNum == 902 then
    local pegas_state = GetExternalVariable("pegas_state")
    if pegas_state == "pegas_arrival" then
      local pegas = GetIndex(NPC, "npc0007")
      Npc(pegas).LinkToRailMove("d0902_railmove", "rail_move_001")
      Npc(pegas).SetRailMoveSpeed(10)
      Npc(pegas).SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Npc(pegas).SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Npc(pegas).SetRailMoveInDimension3d()
      Npc(pegas).Physics_SetCollisionContactForNotHit()
      Npc(pegas).Physics_SetGravity(0)
      Npc(pegas).RailMoveGo()
      if Npc(pegas).IsArrivalRailBothEnds() then
        SetExternalVariable("pegas_state", "stop")
      end
      Player().LinkToRailMove("d0902_railmove", "rail_move_003")
      if not Player().IsArrivalRailBothEnds() then
        Player().SetRailMoveSpeed(10)
        Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
        Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
        Player().SetRailMoveInDimension2d()
        Player().Physics_SetCollisionContactForNotHit()
        Player().Physics_SetGravity(0)
        Player().RailMoveGo()
      end
    elseif pegas_state == "pegas_departure" then
      Player().ScriptDigimonRideStartFromIDOnlyThisFrame(146, true, false)
      Player().LinkToRailMove("d0902_railmove", "rail_move_002")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveInDimension3d()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().RailMoveGo()
      if Player().IsArrivalRailBothEnds() then
        SetExternalVariable("pegas_departure", "stop")
      end
    end
    if FlagCheck(FLAG_MAIN_22_191) and not FlagCheck(FLAG_MAIN_22_210) then
      local daemonrun01_state = GetExternalVariable("daemonrun01_state")
      if daemonrun01_state == "daemonrun01" then
        local daemon = GetIndex(NPC, "npc0002")
        local speed = 6
        Npc(daemon).LinkToRailMove("d0902_railmove", "rail_move_004")
        Npc(daemon).Physics_SetCollisionContactForNotHit()
        Npc(daemon).Physics_SetGravity(0)
        Npc(daemon).SetRailMoveSpeed(speed)
        Npc(daemon).SetRailMoveInDimension3d()
        Npc(daemon).RailMoveGo()
        if Npc(daemon).IsArrivalRailBothEnds() then
          SetExternalVariable("daemonrun01_state", "end")
        end
      elseif daemonrun01_state == "end" then
      end
    end
    if GetExternalVariable("PlayVoice_Event_590") == "karis00" then
      PlayVoiceFromName("vo_mpc492_Attack_002")
      SetExternalVariable("PlayVoice_Event_590", "end")
    elseif GetExternalVariable("PlayVoice_Event_590") == "karis01" then
      PlayVoiceFromName("vo_mpc492_preparation_002")
      SetExternalVariable("PlayVoice_Event_590", "end")
    elseif GetExternalVariable("PlayVoice_Event_590") == "demon01" then
      PlayVoiceFromName("vo_yma008_Fun_001")
      SetExternalVariable("PlayVoice_Event_590", "end")
    elseif GetExternalVariable("PlayVoice_Event_590") == "karis02" then
      PlayVoiceFromName("vo_mpc174_preparation_002")
      PlayVoiceFromName("vo_mpc492_preparation_002")
      SetExternalVariable("PlayVoice_Event_590", "end")
    end
    if GetExternalVariable("PlayVoice_Event_600") == "karis01" then
      PlayVoiceFromName("vo_mpc174_preparation_002")
      PlayVoiceFromName("vo_mpc492_preparation_002")
      SetExternalVariable("PlayVoice_Event_600", "end")
    end
  elseif gMapNum == 903 then
    if FlagCheck(FLAG_MAIN_22_275) and not FlagCheck(FLAG_MAIN_22_276) then
      local pikoro = GetIndex(NPC, "npc0065")
      Npc(pikoro).Physics_SetCollisionContactForNotHit()
      Npc(pikoro).Physics_SetGravity(0)
      local Bacchus = GetIndex(NPC, "npc0053")
      Npc(Bacchus).Physics_SetCollisionContactForNotHit()
      Npc(Bacchus).Physics_SetGravity(0)
    end
    if FlagCheck(FLAG_MAIN_22_275) and not FlagCheck(FLAG_MAIN_22_227) then
      local Bacchusrun01_state = GetExternalVariable("Bacchusrun01_state")
      if Bacchusrun01_state == "Bacchusrun01" then
        local Bacchus = GetIndex(NPC, "npc0053")
        local speed = 1
        Npc(Bacchus).LinkToRailMove("d0903_railmove", "rail_move_006")
        Npc(Bacchus).Physics_SetCollisionContactForNotHit()
        Npc(Bacchus).Physics_SetGravity(0)
        Npc(Bacchus).SetRailMoveSpeed(speed)
        Npc(Bacchus).SetRailMoveInDimension3d()
        Npc(Bacchus).RailMoveGo()
        if Npc(Bacchus).IsArrivalRailBothEnds() then
          SetExternalVariable("Bacchusrun01_state", "end")
        end
      elseif Bacchusrun01_state == "end" then
      end
    end
    local raide_state = GetExternalVariable("ride_state")
    if raide_state == "start_arrival" then
      Player().LinkToRailMove("d0903_railmove", "rail_move_004")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().SetRailMoveInDimension3d()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().RailMoveGo()
      PlayAndManageSE(211010, 100, 0.5, 1, false, true)
      if Player().IsArrivalRailBothEnds() then
        StopManageSE(1, 1)
        SetExternalVariable("ride_state", "stop")
        CallEventScriptFunction("Prcs_d0903_ride_end")
      end
    end
    if GetExternalVariable("PlayVoice_Event_670") == "start_01" then
      PlayVoiceFromName("vo_yfc001_Fun_001")
      SetExternalVariable("PlayVoice_Event_670", "end")
    end
    if GetExternalVariable("PlayVoice_Event_670") == "start_02" then
      PlayVoiceFromName("vo_yfc001_preparation_001")
      SetExternalVariable("PlayVoice_Event_670", "end")
    end
    if GetExternalVariable("PlayVoice_Event_680_1") == "start_01" then
      PlayVoiceFromName("vo_mpc179_preparation_002")
      SetExternalVariable("PlayVoice_Event_680_1", "end")
    elseif GetExternalVariable("PlayVoice_Event_680_1") == "start_00" then
      PlayVoiceFromName("vo_mpc179_preparation_001")
      SetExternalVariable("PlayVoice_Event_680_1", "end")
    elseif GetExternalVariable("PlayVoice_Event_680_1") == "start_02" then
      PlayVoiceFromName("vo_mpc179_Attack_001")
      SetExternalVariable("PlayVoice_Event_680_1", "end")
    elseif GetExternalVariable("PlayVoice_Event_680_1") == "start_03" then
      PlayVoiceFromName("vo_mpc179_Attack_003")
      SetExternalVariable("PlayVoice_Event_680_1", "end")
    elseif GetExternalVariable("PlayVoice_Event_680_1") == "start_04" then
      PlayVoiceFromName("vo_mpc179_Attack_002")
      SetExternalVariable("PlayVoice_Event_680_1", "end")
    elseif GetExternalVariable("PlayVoice_Event_680_1") == "start_05" then
      PlayVoiceFromName("vo_mpc179_preparation_002")
      SetExternalVariable("PlayVoice_Event_680_1", "end")
    end
  elseif gMapNum == 904 then
    if FlagCheck(FLAG_MAIN_22_310) and not FlagCheck(FLAG_MAIN_22_320) then
      local marinengl = GetIndex(NPC, "npc0003")
      Npc(marinengl).Physics_SetCollisionContactForNotHit()
      Npc(marinengl).Physics_SetGravity(0)
    end
    if GetExternalVariable("player_walk") == "start" then
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    end
    local ride_submarimon = GetExternalVariable("ride_submarimon")
    local ride_rail = GetExternalVariable("ride_rail")
    local rail_direction = GetExternalVariable("rail_direction")
    local speed = 12
    local speed_LR = 3
    if ride_submarimon == "riding" then
      Player().LinkToRailMove("d0904_railmove", ride_rail)
      Player().SetRailMoveDirection(rail_direction)
      Player().SetRailMoveSpeed(speed)
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().SetRailMoveInDimension3d()
      Player().RailMoveGo()
      if Player().IsArrivalRailBothEnds() then
        if ride_rail == "rail_move_001" then
          CallEventScriptFunction("Prcs_d0904_WaterFlowEnd", 0)
        elseif ride_rail == "rail_move_002" then
          CallEventScriptFunction("Prcs_d0904_WaterFlowEnd", 90)
        end
      end
      for enemy_no = 1, 4 do
        local enemy_name = "enemy_" .. string.format("%02d", enemy_no)
        local enemy = GetIndex(ENEMY, enemy_name)
        if SymbolEnemy(enemy).Exists() then
          local distance_to_player = GetDistanceToObject(ENEMY, enemy)
          if distance_to_player <= 2 then
            local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
            PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, 0, 1)
            PlayEffectScript(d0906EnemyEffect_Vanish, pos_x, pos_y, pos_z, 0, 1)
            SymbolEnemy(enemy).SymbolForceLeave(false)
          end
        end
      end
    end
    if GetExternalVariable("PlayMotion_Event_775") == "nepu01" then
      local nepu = GetIndex(NPC, "npc0067")
      Npc(nepu).Motion_PlayMotion("ba01", 10, false)
      SetExternalVariable("PlayMotion_Event_775", "play_ba01")
    elseif GetExternalVariable("PlayMotion_Event_775") == "play_ba01" then
      local nepu = GetIndex(NPC, "npc0067")
      if Npc(nepu).IsPlayingMotion("ba01") == false then
        Npc(nepu).Motion_PlayMotion("fe02", 10, true)
        SetExternalVariable("PlayMotion_Event_775", "end")
      end
    end
    if GetExternalVariable("PlayVoice_Event_760") == "start" then
      PlayVoiceFromName("vo_yma009_preparation_002")
      PlayVoiceFromName("vo_ymb002_preparation_002")
      SetExternalVariable("PlayVoice_Event_760", "end")
    end
    if GetExternalVariable("PlayVoice_Event_770") == "start" then
      PlayVoiceFromName("vo_ymb002_Attack_001")
      PlayVoiceFromName("vo_ymc008_Attack_003")
      SetExternalVariable("PlayVoice_Event_770", "end")
    end
  elseif gMapNum == 905 then
    local raide_state = GetExternalVariable("ride_state")
    if raide_state == "start_arrival" then
      Player().LinkToRailMove("d0905_railmove", "rail_move_001")
      Player().SetRailMoveSpeed(10)
      Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(3)
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(3)
      Player().SetRailMoveInDimension3d()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      Player().RailMoveGo()
      if Player().IsArrivalRailBothEnds() then
        SetExternalVariable("ride_state", "stop")
        CallEventScriptFunction("Prcs_d0905_ride_end")
      end
    end
    local move_elv_single = GetExternalVariable("move_elv_single")
    if move_elv_single == "moveing" then
      local elv_0001 = GetIndex(GIM, "elv_0001")
      local elv_name = LocatorObject(elv_0001).GetLocatorName()
      local drive_state = LocatorObject(elv_0001).GetSelfObjectScriptExternalVariable("drive_state")
      if drive_state == "moving" or drive_state == "standby_arrive" then
        if not LocatorObject(elv_0001).IsMovingLift() then
          LocatorObject(elv_0001).MoveStartLift(false)
        end
      elseif drive_state == "arrived" then
        GetExternalVariable("move_elv_single", "end")
      end
    end
    if Player().IsPlayingMotion("ff01_01") == true and 10 >= gd0905FallDownTimer then
      gd0905FallDownTimer = gd0905FallDownTimer + elapsed_frame
      Player().Physics_SetCollisionContactForNotHit()
    elseif Player().IsPlayingMotion("ff01_01") == false then
      gd0905FallDownTimer = 0
    end
    if GetExternalVariable("player_walk") == "start" then
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    end
  elseif gMapNum == 906 then
    if not FlagCheck(FLAG_GIMMICK_D09_080) and FlagCheck(FLAG_MAIN_22_470) then
      math.randomseed(os.time())
      gd0906gimTime_preliminary = gd0906gimTime_preliminary + elapsed_frame
      local time = SecondFromFrame(gd0906gimTime_preliminary)
      local enemy_num = 1
      local rail_num = 302
      local aporo = GetIndex(NPC, "npc_0004")
      local diana = GetIndex(NPC, "npc_0005")
      local minerva = GetIndex(NPC, "npc_0006")
      for rail_no = 300, rail_num do
        for enemy_no = 1, enemy_num do
          local enemy_name = "enemy_" .. string.format("%d", rail_no) .. "_" .. string.format("%02d", enemy_no)
          local end_rail_pos_index = "end_rail_move_" .. string.format("%d", rail_no)
          local rail_name = "rail_move_" .. string.format("%d", rail_no)
          local enemy = GetIndex(ENEMY, enemy_name)
          local end_rail = GetIndex(FLD_OBJ_GIMMICK, end_rail_pos_index)
          local enemy_state_name = enemy_name
          local tag = SymbolEnemy(enemy).GetTag()
          local speed = 6
          if time <= 1 then
            SymbolEnemy(enemy).SymbolForceLeave(true)
          end
          if SymbolEnemy(enemy).Exists() then
            SymbolEnemy(enemy).Physics_SetCollisionContactForNotHit()
            SymbolEnemy(enemy).Physics_SetGravity(0)
            local enemy_pos_x, enemy_pos_y, enemy_pos_z = SymbolEnemy(enemy).GetPosition()
            local aporo_pos_x, aporo_pos_y, aporo_pos_z = Npc(aporo).GetPosition()
            local diana_pos_x, diana_pos_y, diana_pos_z = Npc(diana).GetPosition()
            local minerva_pos_x, minerva_pos_y, minerva_pos_z = Npc(minerva).GetPosition()
            local distance1 = GetDistanceBetweenTwoObject2D(enemy_pos_x, enemy_pos_z, aporo_pos_x, aporo_pos_z)
            local distance2 = GetDistanceBetweenTwoObject2D(enemy_pos_x, enemy_pos_z, diana_pos_x, diana_pos_z)
            local distance3 = GetDistanceBetweenTwoObject2D(enemy_pos_x, enemy_pos_z, minerva_pos_x, minerva_pos_z)
            if GetExternalVariable(enemy_state_name) == "move" then
              SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
              SymbolEnemy(enemy).SetRailMoveSpeed(speed)
              SymbolEnemy(enemy).SetRailMoveInDimension2d()
              SymbolEnemy(enemy).RailMoveGo()
              if tag == "tag_pre_aporo" and distance1 <= 7 then
                SetExternalVariable("aporo_preliminary_state", "attack")
                SetExternalVariable(enemy_state_name, "aporo_damage")
              end
              if tag == "tag_pre_diana" and distance2 <= 8 then
                SetExternalVariable("diana_preliminary_state", "attack")
                SetExternalVariable(enemy_state_name, "diana_damage")
              end
              if tag == "tag_pre_minerva" and distance3 <= 5 then
                SetExternalVariable("minerva_preliminary_state", "attack")
                SetExternalVariable(enemy_state_name, "minerva_damage")
              end
            elseif GetExternalVariable(enemy_state_name) == "aporo_damage" then
              if 5 < distance1 then
                SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
                SymbolEnemy(enemy).SetRailMoveSpeed(speed)
                SymbolEnemy(enemy).SetRailMoveInDimension2d()
                SymbolEnemy(enemy).RailMoveGo()
              else
                SymbolEnemy(enemy).Motion_PlayMotion("bd01", 10, false)
                local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
                local rot = SymbolEnemy(enemy).GetRotationY()
                PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, rot, 1)
                SetExternalVariable(enemy_state_name, "damage")
              end
            elseif GetExternalVariable(enemy_state_name) == "diana_damage" then
              if 5 < distance2 then
                SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
                SymbolEnemy(enemy).SetRailMoveSpeed(speed)
                SymbolEnemy(enemy).SetRailMoveInDimension2d()
                SymbolEnemy(enemy).RailMoveGo()
              else
                SymbolEnemy(enemy).Motion_PlayMotion("bd01", 10, false)
                local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
                local rot = SymbolEnemy(enemy).GetRotationY()
                PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, rot, 1)
                SetExternalVariable(enemy_state_name, "damage")
              end
            elseif GetExternalVariable(enemy_state_name) == "minerva_damage" then
              if 2 < distance3 then
                SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
                SymbolEnemy(enemy).SetRailMoveSpeed(speed)
                SymbolEnemy(enemy).SetRailMoveInDimension2d()
                SymbolEnemy(enemy).RailMoveGo()
              else
                SymbolEnemy(enemy).Motion_PlayMotion("bd01", 10, false)
                local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
                local rot = SymbolEnemy(enemy).GetRotationY()
                PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, rot, 1)
                SetExternalVariable(enemy_state_name, "damage")
              end
            elseif GetExternalVariable(enemy_state_name) == "damage" and SymbolEnemy(enemy).IsPlayingMotion("bd01") == false then
              local rot = SymbolEnemy(enemy).GetRotationY()
              local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
              PlayEffectScript(d0906EnemyEffect_Vanish, pos_x, pos_y, pos_z, rot, 1)
              SymbolEnemy(enemy).SymbolForceLeave(false)
            end
          else
            local generattimer = time - gd0906gimGeneratTime_preliminary
            local genetime = 1
            if time <= 1 then
            elseif generattimer >= genetime then
              local random = math.random(0, 99)
              if random < 5 then
                SymbolEnemy(enemy).SymbolForceRespawn(true)
                gd0906gimGeneratTime_preliminary = time
                SetExternalVariable(enemy_state_name, "move")
              end
            end
          end
        end
      end
      if GetExternalVariable("aporo_preliminary_state") == "attack" then
        Npc(aporo).Motion_PlayMotion("ba01", 10, false)
        if Npc(aporo).IsPlayingMotion("ba01") == false then
          Npc(aporo).Motion_ResetPlayMotion(10)
          SetExternalVariable("aporo_preliminary_state", "stay")
        end
      end
      if GetExternalVariable("diana_preliminary_state") == "attack" then
        Npc(diana).Motion_PlayMotion("ba01", 10, false)
        if Npc(diana).IsPlayingMotion("ba01") == false then
          Npc(diana).Motion_ResetPlayMotion(10)
          SetExternalVariable("diana_preliminary_state", "stay")
        end
      end
      if GetExternalVariable("minerva_preliminary_state") == "attack" then
        Npc(minerva).Motion_PlayMotion("ba01", 10, false)
        if Npc(minerva).IsPlayingMotion("ba01") == false then
          Npc(minerva).Motion_ResetPlayMotion(10)
          SetExternalVariable("minerva_preliminary_state", "stay")
        end
      end
    end
    if FlagCheck(FLAG_GIMMICK_D09_040) and not FlagCheck(FLAG_GIMMICK_D09_050) and GetExternalVariable("Gim_Event_815") == "start" then
      math.randomseed(os.time())
      local enemy_num = 1
      local rail_num = 105
      local MaxDamage = 10
      local GimTime = 120
      local aporo = GetIndex(NPC, "npc_0001")
      local diana = GetIndex(NPC, "npc_0002")
      local minerva = GetIndex(NPC, "npc_0003")
      local aigio = GetIndex(NPC, "npc_0010")
      local inori = GetIndex(NPC, "npc_0011")
      gd0906gimTime = gd0906gimTime + elapsed_frame
      local time = SecondFromFrame(gd0906gimTime)
      gd0906gimChargeTime = gd0906gimChargeTime + elapsed_frame
      local Chargetime = SecondFromFrame(gd0906gimChargeTime)
      if gd0906gimAporoFloatMessage_Is == true then
        gd0906gimAporoFloatMessage_Timer = gd0906gimAporoFloatMessage_Timer + elapsed_frame
      end
      if gd0906gimDianaFloatMessage_Is == true then
        gd0906gimDianaFloatMessage_Timer = gd0906gimDianaFloatMessage_Timer + elapsed_frame
      end
      if 90 <= gd0906gimAporoFloatMessage_Timer then
        gd0906gimAporoFloatMessage_Timer = 0
        gd0906gimAporoFloatMessage_Is = false
      end
      if 90 <= gd0906gimDianaFloatMessage_Timer then
        gd0906gimDianaFloatMessage_Timer = 0
        gd0906gimDianaFloatMessage_Is = false
      end
      local p_pos_x, p_pos_y, p_pos_z = Player().GetPosition()
      if p_pos_x <= -4 then
        p_pos_x = -4
      elseif 4 <= p_pos_x then
        p_pos_x = 4
      end
      SetInstantCameraInNowFrame(p_pos_x, 3.59, 1.44, p_pos_x, 6.4, 10.15, DEFAULT_ANGLE, 0, 30)
      if GetExternalVariable("aporo_state") == "charge_start" then
        Npc(aporo).Motion_PlayMotion("f000", 15, true)
        SetExternalVariable("aporo_state", "charge")
        if gd0906gimChargeLv == 0 then
          Npc(aporo).ShowAttachment(1)
        elseif gd0906gimChargeLv == 1 then
          Npc(aporo).ShowAttachment(2)
        elseif gd0906gimChargeLv == 2 then
          Npc(aporo).ShowAttachment(3)
        elseif gd0906gimChargeLv == 3 then
          Npc(aporo).ShowAttachment(3)
        end
      end
      if GetExternalVariable("diana_state") == "charge_start" then
        Npc(diana).Motion_PlayMotion("e210", 15, true)
        SetExternalVariable("diana_state", "charge")
        if gd0906gimChargeLv == 0 then
          Npc(diana).ShowAttachment(1)
        elseif gd0906gimChargeLv == 1 then
          Npc(diana).ShowAttachment(2)
        elseif gd0906gimChargeLv == 2 then
          Npc(diana).ShowAttachment(3)
        elseif gd0906gimChargeLv == 3 then
          Npc(diana).ShowAttachment(3)
        end
      end
      for rail_no = 100, rail_num do
        if rail_no == 100 then
          enemy_num = 2
        elseif rail_no == 101 then
          enemy_num = 2
        elseif rail_no == 102 then
          enemy_num = 3
        elseif rail_no == 103 then
          enemy_num = 3
        elseif rail_no == 104 then
          enemy_num = 2
        elseif rail_no == 105 then
          enemy_num = 2
        end
        for enemy_no = 1, enemy_num do
          local enemy_name = "enemy_" .. string.format("%d", rail_no) .. "_" .. string.format("%02d", enemy_no)
          local end_rail_pos_index = "end_rail_move_" .. string.format("%d", rail_no)
          local rail_name = "rail_move_" .. string.format("%d", rail_no)
          local enemy = GetIndex(ENEMY, enemy_name)
          local end_rail = GetIndex(FLD_OBJ_GIMMICK, end_rail_pos_index)
          local enemy_state_name = enemy_name
          local tag = SymbolEnemy(enemy).GetTag()
          local speed = 6
          if tag == "tag_doramon" then
            speed = 7.5
          elseif tag == "tag_zanba" then
            speed = 10
          elseif tag == "tag_scal" then
            speed = 3
          elseif tag == "tag_beruzebu" then
            speed = 10
          end
          if time <= 1 then
            SymbolEnemy(enemy).SymbolForceLeave(true)
            gd0906gimFAProcessDelay = 0
          elseif 3 <= time then
            gd0906gimFAProcessDelay = 1
          end
          if SymbolEnemy(enemy).Exists() then
            local enemy_pos_x, enemy_pos_y, enemy_pos_z = SymbolEnemy(enemy).GetPosition()
            local end_pos_x, end_pos_y, end_pos_z = Gimmick(end_rail).GetPosition()
            local distance = GetDistanceBetweenTwoObject2D(enemy_pos_x, enemy_pos_z, end_pos_x, end_pos_z)
            local distance_to_player = GetDistanceToObject(ENEMY, enemy)
            SymbolEnemy(enemy).Physics_SetCollisionContactForNotHit()
            SymbolEnemy(enemy).Physics_SetGravity(0)
            if GetExternalVariable(enemy_state_name) == "move" then
              if distance <= 3 then
                SetExternalVariable(enemy_state_name, "attack_start")
              elseif distance_to_player <= 2 then
                SetExternalVariable(enemy_state_name, "attack_start_p")
              else
                SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
                SymbolEnemy(enemy).SetRailMoveSpeed(speed)
                SymbolEnemy(enemy).SetRailMoveInDimension2d()
                SymbolEnemy(enemy).RailMoveGo()
              end
            elseif tag ~= "tag_beruzebu" then
              local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
              local rot = SymbolEnemy(enemy).GetRotationY()
              if GetExternalVariable(enemy_state_name) == "damage" then
                if SymbolEnemy(enemy).IsPlayingMotion("bd01") == false then
                  SetExternalVariable(enemy_state_name, "move")
                end
              elseif GetExternalVariable(enemy_state_name) == "damage2" then
                if SymbolEnemy(enemy).IsPlayingMotion("bd01") == false then
                  SetExternalVariable(enemy_state_name, "end")
                end
              elseif GetExternalVariable(enemy_state_name) == "attack_start" then
                SymbolEnemy(enemy).Motion_PlayMotion("ba01", 10, false)
                local MotionEndFrame = SymbolEnemy(enemy).GetMotionEndFrame("ba01") / 3
                if MotionEndFrame <= SymbolEnemy(enemy).GetMotionEvalFrame("ba01") then
                  SetExternalVariable(enemy_state_name, "attack_hit")
                end
              elseif GetExternalVariable(enemy_state_name) == "attack_hit" then
                SetExternalVariable(enemy_state_name, "attack_end")
                if rail_name == "rail_move_100" or rail_name == "rail_move_101" or rail_name == "rail_move_102" then
                  Npc(aporo).HideAttachment(2)
                  Npc(aporo).HideAttachment(1)
                  Npc(aporo).HideAttachment(3)
                  SetExternalVariable("aporo_state", "damage_start")
                  local pos_x, pos_y, pos_z = Npc(aporo).GetPosition()
                  local rot = Npc(aporo).GetRotationY()
                  PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 3.5, pos_z, 0, 1.5)
                elseif rail_name == "rail_move_103" or rail_name == "rail_move_104" or rail_name == "rail_move_105" then
                  Npc(diana).HideAttachment(2)
                  Npc(diana).HideAttachment(1)
                  Npc(diana).HideAttachment(3)
                  SetExternalVariable("diana_state", "damage_start")
                  local pos_x, pos_y, pos_z = Npc(diana).GetPosition()
                  local rot = Npc(diana).GetRotationY()
                  PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 4, pos_z, 0, 1.5)
                end
                if tag == "tag_doramon" then
                  PlayAndManageSE(300201, 100, 0, 1, false, true)
                  gd0906gimDamageCount = gd0906gimDamageCount + 1
                  gd0906gimChargeDamageCoun = gd0906gimChargeDamageCoun + 1
                elseif tag == "tag_scal" then
                  PlayAndManageSE(300201, 100, 0, 1, false, true)
                  gd0906gimDamageCount = gd0906gimDamageCount + 10
                  gd0906gimChargeDamageCoun = gd0906gimChargeDamageCoun + 10
                elseif tag == "tag_zanba" then
                  PlayAndManageSE(300201, 100, 0, 2, false, true)
                  gd0906gimDamageCount = gd0906gimDamageCount + 5
                  gd0906gimChargeDamageCoun = gd0906gimChargeDamageCoun + 5
                end
              elseif GetExternalVariable(enemy_state_name) == "attack_end" then
                if SymbolEnemy(enemy).IsPlayingMotion("ba01") == false then
                  SetExternalVariable(enemy_state_name, "end")
                end
              elseif GetExternalVariable(enemy_state_name) == "end" then
                PlayEffectScript(d0906EnemyEffect_Vanish, pos_x, pos_y, pos_z, rot, 1)
                SymbolEnemy(enemy).Motion_ResetPlayMotion(10)
                gd0906gimEnemyCounter = gd0906gimEnemyCounter + 1
                SymbolEnemy(enemy).SymbolForceLeave(false)
              elseif GetExternalVariable(enemy_state_name) == "attack_start_p" then
                SymbolEnemy(enemy).Motion_PlayMotion("ba01", 10, false)
                local MotionEndFrame = SymbolEnemy(enemy).GetMotionEndFrame("ba01") / 3
                if MotionEndFrame <= SymbolEnemy(enemy).GetMotionEvalFrame("ba01") then
                  SetExternalVariable(enemy_state_name, "attack_hit_p")
                end
              elseif GetExternalVariable(enemy_state_name) == "attack_hit_p" then
                SetExternalVariable(enemy_state_name, "attack_end_p")
                local pos_x, pos_y, pos_z = Player().GetPosition()
                local rot = Player().GetRotationY()
                PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, 0, 1)
                if tag == "tag_doramon" then
                  PlayAndManageSE(300201, 100, 0, 1, false, true)
                elseif tag == "tag_scal" then
                  PlayAndManageSE(300201, 100, 0, 1, false, true)
                elseif tag == "tag_zanba" then
                  PlayAndManageSE(300201, 100, 0, 2, false, true)
                end
                if GetExternalVariable("gim_player_state") == "usual" then
                  SetExternalVariable("gim_player_state", "damage_start")
                  SetExternalVariable("gim_inori_state", "damage_start")
                end
              elseif GetExternalVariable(enemy_state_name) == "attack_end_p" then
                if SymbolEnemy(enemy).IsPlayingMotion("ba01") == false then
                  SetExternalVariable(enemy_state_name, "end_p")
                end
              elseif GetExternalVariable(enemy_state_name) == "end_p" then
                PlayEffectScript(d0906EnemyEffect_Vanish, pos_x, pos_y, pos_z, rot, 1)
                SymbolEnemy(enemy).Motion_ResetPlayMotion(10)
                gd0906gimEnemyCounter = gd0906gimEnemyCounter + 1
                SymbolEnemy(enemy).SymbolForceLeave(false)
              end
            end
          else
            local generattimer = time - gd0906gimGeneratTime
            local genetime = 1
            if gd0906gimChargeLv == 0 and 10 > gd0906gimEnemyGeneratCounter then
              if Chargetime > 22 then
                if enemy_name == "enemy_104_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 20 then
                if enemy_name == "enemy_100_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_103_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 16 then
                if enemy_name == "enemy_101_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_105_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 13 then
                if enemy_name == "enemy_102_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif 10 < Chargetime then
                if enemy_name == "enemy_101_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_104_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif 6 < Chargetime then
                if enemy_name == "enemy_103_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif 2 < Chargetime and enemy_name == "enemy_101_01" then
                SymbolEnemy(enemy).SymbolForceRespawn(true)
                d0906_SetEnemyHP(enemy, tag)
                SetExternalVariable(enemy_name, "move")
              end
            elseif gd0906gimChargeLv == 1 and 10 > gd0906gimEnemyGeneratCounter then
              if Chargetime > 19 then
                if enemy_name == "enemy_100_02" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 17 then
                if enemy_name == "enemy_102_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_105_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 14 then
                if enemy_name == "enemy_103_02" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 13 then
                if enemy_name == "enemy_101_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 9 then
                if enemy_name == "enemy_101_02" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  gd0906gimGeneratTime = time
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_state_name, "move")
                end
              elseif 7 < Chargetime then
                if enemy_name == "enemy_103_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_105_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif 3 < Chargetime then
                if enemy_name == "enemy_104_02" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  gd0906gimGeneratTime = time
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_state_name, "move")
                end
              elseif 2 < Chargetime and enemy_name == "enemy_101_01" then
                SymbolEnemy(enemy).SymbolForceRespawn(true)
                d0906_SetEnemyHP(enemy, tag)
                SetExternalVariable(enemy_name, "move")
              end
            elseif gd0906gimChargeLv == 2 and 8 > gd0906gimEnemyGeneratCounter then
              if Chargetime > 23 then
                if enemy_name == "enemy_100_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_105_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 18 then
                if enemy_name == "enemy_100_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_105_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif Chargetime > 15 then
                if enemy_name == "enemy_102_03" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif 5 < Chargetime then
                if enemy_name == "enemy_100_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
                if enemy_name == "enemy_105_01" then
                  SymbolEnemy(enemy).SymbolForceRespawn(true)
                  d0906_SetEnemyHP(enemy, tag)
                  SetExternalVariable(enemy_name, "move")
                end
              elseif 2 < Chargetime and enemy_name == "enemy_103_03" then
                SymbolEnemy(enemy).SymbolForceRespawn(true)
                d0906_SetEnemyHP(enemy, tag)
                SetExternalVariable(enemy_name, "move")
              end
            end
          end
        end
      end
      if GetExternalVariable("aporo_state") == "damage_start" then
        Npc(aporo).Motion_PlayMotion("f003", 10, false)
        SetExternalVariable("aporo_state", "damage")
        local floatobj = GetIndex(GIMMICK, "aporofloatmessage")
        gd0906gimAporoFloatMessage = gd0906gimAporoFloatMessage + 1
        if 1 <= gd0906gimAporoFloatMessage and gd0906gimAporoFloatMessage_Is == false then
          PlayVoiceFromName("vo_mpc173_Frustrating_001")
          local random = math.random(1, 5)
          if random == 1 then
            Gimmick(floatobj).StartFloatMessage("r_d0906_0010_0010", 60)
          elseif random == 2 then
            Gimmick(floatobj).StartFloatMessage("r_d0906_0010_0020", 60)
          elseif random == 3 then
            Gimmick(floatobj).StartFloatMessage("r_d0906_0010_0030", 60)
          elseif random == 4 then
            Gimmick(floatobj).StartFloatMessage("r_d0906_0010_0040", 60)
          elseif random == 5 then
            Gimmick(floatobj).StartFloatMessage("r_d0906_0010_0050", 60)
          end
          gd0906gimAporoFloatMessage = 0
          gd0906gimAporoFloatMessage_Is = true
        end
      elseif GetExternalVariable("aporo_state") == "damage" and Npc(aporo).IsPlayingMotion("f003") == false then
        Npc(aporo).Motion_ResetPlayMotion(10)
        SetExternalVariable("aporo_state", "charge_start")
      end
      if GetExternalVariable("diana_state") == "damage_start" then
        Npc(diana).Motion_PlayMotion("bd01", 10, false)
        SetExternalVariable("diana_state", "damage")
        gd0906gimDianaFloatMessage = gd0906gimDianaFloatMessage + 1
        if 1 <= gd0906gimDianaFloatMessage and gd0906gimDianaFloatMessage_Is == false then
          PlayVoiceFromName("vo_mpc733_Frustrating_001")
          local random = math.random(1, 5)
          if random == 1 then
            Npc(diana).StartFloatMessage("r_d0906_0020_0010", 60)
          elseif random == 2 then
            Npc(diana).StartFloatMessage("r_d0906_0020_0020", 60)
          elseif random == 3 then
            Npc(diana).StartFloatMessage("r_d0906_0020_0030", 60)
          elseif random == 4 then
            Npc(diana).StartFloatMessage("r_d0906_0020_0040", 60)
          elseif random == 5 then
            Npc(diana).StartFloatMessage("r_d0906_0020_0050", 60)
          end
          gd0906gimDianaFloatMessage = 0
          gd0906gimDianaFloatMessage_Is = true
        end
      elseif GetExternalVariable("diana_state") == "damage" and Npc(diana).IsPlayingMotion("bd01") == false then
        Npc(diana).Motion_ResetPlayMotion(10)
        SetExternalVariable("diana_state", "charge_start")
      end
      if GetExternalVariable("gim_player_state") == "damage_start" then
        SetExternalVariable("gim_player_state", "damage")
        Player().Motion_PlayMotion("bd01", 10, false)
      elseif GetExternalVariable("gim_player_state") == "damage" then
        if Player().IsPlayingMotion("bd01") == false then
          SetExternalVariable("gim_player_state", "usual")
          Player().Motion_ResetPlayMotion(10)
        else
          Player().Motion_Monopoly()
          Player().Move_Stop()
        end
      end
      if GetExternalVariable("gim_inori_state") == "damage_start" then
        SetExternalVariable("gim_inori_state", "damage")
        Npc(inori).Motion_PlayMotionAndSetting("e006", 10, 0, 0, 60, 1, false)
        gd0906gimInoriFloatMessage = gd0906gimInoriFloatMessage + 1
        if 1 <= gd0906gimInoriFloatMessage then
          PlayVoiceFromName("vo_npc001_CallPC_003")
          local random = math.random(1, 5)
          if random == 1 then
            Npc(inori).StartFloatMessage("r_d0906_0030_0010", 60)
          elseif random == 2 then
            Npc(inori).StartFloatMessage("r_d0906_0030_0020", 60)
          elseif random == 3 then
            Npc(inori).StartFloatMessage("r_d0906_0030_0030", 60)
          elseif random == 4 then
            Npc(inori).StartFloatMessage("r_d0906_0030_0040", 60)
          elseif random == 5 then
            Npc(inori).StartFloatMessage("r_d0906_0030_0050", 60)
          end
          gd0906gimInoriFloatMessage = 0
        end
      elseif GetExternalVariable("gim_inori_state") == "damage" then
        if Npc(inori).IsPlayingMotion("e006") == false then
          SetExternalVariable("gim_inori_state", "usual")
          Npc(inori).Motion_PlayMotion("e018", 10, true)
        end
      elseif GetExternalVariable("gim_inori_state") == "attack_start" then
        SetExternalVariable("gim_inori_state", "attack")
        Npc(inori).Motion_PlayMotionAndSetting("e004_01", 10, 0, 0, 60, 1, false)
      elseif GetExternalVariable("gim_inori_state") == "attack" and Npc(inori).IsPlayingMotion("e004_01") == false then
        SetExternalVariable("gim_inori_state", "usual")
        Npc(inori).Motion_PlayMotion("e018", 10, true)
      end
      if gd0906gimChargeLv == 0 and MaxDamage > gd0906gimDamageCount then
        if 10 <= gd0906gimEnemyCounter then
          gd0906gimEventTimer = gd0906gimEventTimer + elapsed_frame
          if gd0906gimEventTimer >= 45 then
            gd0906gimEventTimer = 0
            gd0906gimChargeTime = 0
            gd0906gimChargeLv = 1
            gd0906gimChargeDamageCoun = 0
            gd0906gimEnemyCounter = 0
            gd0906gimEnemyGeneratCounter = 0
            Npc(aporo).ShowAttachment(2)
            Npc(diana).ShowAttachment(2)
            Npc(aporo).HideAttachment(1)
            Npc(diana).HideAttachment(1)
            local enemy = GetIndex(ENEMY, "enemy_200_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            local enemy = GetIndex(ENEMY, "enemy_201_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            local enemy = GetIndex(ENEMY, "enemy_202_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            local enemy = GetIndex(ENEMY, "enemy_203_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            if not FlagCheck(FLAG_GIMMICK_D09_060) then
              CallEventScriptFunction("Prcs_d0906_ChargeLvUp", 1)
            end
          end
        end
      elseif gd0906gimChargeLv == 1 and MaxDamage > gd0906gimDamageCount then
        if 10 <= gd0906gimEnemyCounter then
          gd0906gimEventTimer = gd0906gimEventTimer + elapsed_frame
          if gd0906gimEventTimer >= 45 then
            gd0906gimEventTimer = 0
            gd0906gimChargeTime = 0
            gd0906gimChargeLv = 2
            gd0906gimChargeDamageCoun = 0
            gd0906gimEnemyCounter = 0
            gd0906gimEnemyGeneratCounter = 0
            Npc(aporo).ShowAttachment(3)
            Npc(diana).ShowAttachment(3)
            Npc(aporo).HideAttachment(2)
            Npc(diana).HideAttachment(2)
            local enemy = GetIndex(ENEMY, "enemy_200_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            local enemy = GetIndex(ENEMY, "enemy_201_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            local enemy = GetIndex(ENEMY, "enemy_202_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            local enemy = GetIndex(ENEMY, "enemy_203_01")
            SymbolEnemy(enemy).SymbolForceLeave(true)
            if not FlagCheck(FLAG_GIMMICK_D09_070) then
              CallEventScriptFunction("Prcs_d0906_ChargeLvUp", 2)
            end
          end
        end
      elseif gd0906gimChargeLv == 2 and MaxDamage > gd0906gimDamageCount and 8 <= gd0906gimEnemyCounter then
        gd0906gimEventTimer = gd0906gimEventTimer + elapsed_frame
        if gd0906gimEventTimer >= 45 then
          gd0906gimEventTimer = 0
          gd0906gimChargeTime = 0
          gd0906gimChargeLv = 3
          gd0906gimChargeDamageCoun = 0
          gd0906gimEnemyCounter = 0
          gd0906gimEnemyGeneratCounter = 0
        end
      end
      if gd0906gimChargeLv == 3 then
        FlagSet(FLAG_GIMMICK_D09_050)
        gd0906gimTime = 0
        gd0906gimDamageCount = 0
        gd0906gimGeneratTime = 0
        gd0906gimGeneratTime2 = 0
        gd0906gimEnemyCounter = 0
        gd0906gimEnemyGeneratCounter = 0
        gd0906gimChargeTime = 0
        gd0906gimChargeLv = 0
        gd0906gimChargeDamageCoun = 0
        gd0906gimFAProcessDelay = 0
        Npc(aporo).HideAttachment(2)
        Npc(aporo).HideAttachment(1)
        Npc(aporo).HideAttachment(3)
        Npc(diana).HideAttachment(2)
        Npc(diana).HideAttachment(1)
        Npc(diana).HideAttachment(3)
        CallEventScriptFunction("Prcs_d0906_CompletedTowerDefense", enemy_num, rail_num)
      elseif MaxDamage <= gd0906gimDamageCount then
        gd0906gimEventTimer = gd0906gimEventTimer + elapsed_frame
        if gd0906gimEventTimer >= FrameFromSecond(1.5) then
          gd0906gimEventTimer = 0
          FlagClear(FLAG_GIMMICK_D09_040)
          gd0906gimTime = 0
          gd0906gimDamageCount = 0
          gd0906gimGeneratTime = 0
          gd0906gimGeneratTime2 = 0
          gd0906gimEnemyCounter = 0
          gd0906gimEnemyGeneratCounter = 0
          gd0906gimEventTimer = 0
          gd0906gimAigioFloatMessage = 0
          gd0906gimAporoFloatMessage = 0
          gd0906gimDianaFloatMessage = 0
          gd0906gimInoriFloatMessage = 0
          gd0906gimAgioFloatMessage = 0
          gd0906gimMinervaFloatMessage = 0
          gd0906gimChargeTime = 0
          gd0906gimChargeLv = 0
          gd0906gimChargeDamageCoun = 0
          gd0906gimFAProcessDelay = 0
          BigEnemyHP_table = {}
          Player().Motion_ResetPlayMotion(10)
          Npc(aporo).Motion_ResetPlayMotion(10)
          Npc(diana).Motion_ResetPlayMotion(10)
          Npc(aporo).HideAttachment(2)
          Npc(aporo).HideAttachment(1)
          Npc(aporo).HideAttachment(3)
          Npc(diana).HideAttachment(2)
          Npc(diana).HideAttachment(1)
          Npc(diana).HideAttachment(3)
          CallEventScriptFunction("Prcs_d0906_FailureTowerDefense", enemy_num, rail_num)
        end
      end
      local enemy_num = 1
      local rail_num = 203
      for rail_no = 200, rail_num do
        for enemy_no = 1, enemy_num do
          local enemy_name = "enemy_" .. string.format("%d", rail_no) .. "_" .. string.format("%02d", enemy_no)
          local end_rail_pos_index = "end_rail_move_" .. string.format("%d", rail_no)
          local rail_name = "rail_move_" .. string.format("%d", rail_no)
          local enemy = GetIndex(ENEMY, enemy_name)
          local end_rail = GetIndex(FLD_OBJ_GIMMICK, end_rail_pos_index)
          local enemy_state_name = enemy_name
          local tag = SymbolEnemy(enemy).GetTag()
          local speed = 6
          if time <= 2 then
            SymbolEnemy(enemy).SymbolForceLeave(true)
          end
          if SymbolEnemy(enemy).Exists() then
            local enemy_pos_x, enemy_pos_y, enemy_pos_z = SymbolEnemy(enemy).GetPosition()
            local minerva_pos_x, minerva_pos_y, minerva_pos_z = Npc(minerva).GetPosition()
            local aigio_pos_x, aigio_pos_y, aigio_pos_z = Npc(aigio).GetPosition()
            local distance = GetDistanceBetweenTwoObject2D(enemy_pos_x, enemy_pos_z, minerva_pos_x, minerva_pos_z)
            local distance2 = GetDistanceBetweenTwoObject2D(enemy_pos_x, enemy_pos_z, aigio_pos_x, aigio_pos_z)
            SymbolEnemy(enemy).Physics_SetCollisionContactForNotHit()
            SymbolEnemy(enemy).Physics_SetGravity(0)
            if GetExternalVariable(enemy_state_name) == "move" then
              SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
              SymbolEnemy(enemy).SetRailMoveSpeed(speed)
              SymbolEnemy(enemy).SetRailMoveInDimension2d()
              SymbolEnemy(enemy).RailMoveGo()
              if distance <= 3 then
                SetExternalVariable("minerva_state", "attack_start")
                SetExternalVariable(enemy_state_name, "damage_minerva")
              end
              if distance2 <= 3 then
                SetExternalVariable("aigio_state", "attack_start")
                SetExternalVariable(enemy_state_name, "damage_aigio")
              end
            elseif GetExternalVariable(enemy_state_name) == "damage_minerva" then
              if 2 < distance then
                SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
                SymbolEnemy(enemy).SetRailMoveSpeed(speed)
                SymbolEnemy(enemy).SetRailMoveInDimension2d()
                SymbolEnemy(enemy).Physics_SetCollisionContactForNotHit()
                SymbolEnemy(enemy).Physics_SetGravity(0)
                SymbolEnemy(enemy).RailMoveGo()
              else
                SetExternalVariable(enemy_state_name, "damage")
                SymbolEnemy(enemy).Motion_PlayMotion("bd01", 10, false)
                local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
                local rot = SymbolEnemy(enemy).GetRotationY()
                PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, rot, 1)
              end
            elseif GetExternalVariable(enemy_state_name) == "damage_aigio" then
              if 2 < distance2 then
                SymbolEnemy(enemy).LinkToRailMove("d0906_railmove", rail_name)
                SymbolEnemy(enemy).SetRailMoveSpeed(speed)
                SymbolEnemy(enemy).SetRailMoveInDimension2d()
                SymbolEnemy(enemy).Physics_SetCollisionContactForNotHit()
                SymbolEnemy(enemy).Physics_SetGravity(0)
                SymbolEnemy(enemy).RailMoveGo()
              else
                SetExternalVariable(enemy_state_name, "damage")
                SymbolEnemy(enemy).Motion_PlayMotion("bd01", 10, false)
                local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
                local rot = SymbolEnemy(enemy).GetRotationY()
                PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, rot, 1)
              end
            elseif GetExternalVariable(enemy_state_name) == "damage" and SymbolEnemy(enemy).IsPlayingMotion("bd01") == false then
              local rot = SymbolEnemy(enemy).GetRotationY()
              local pos_x, pos_y, pos_z = SymbolEnemy(enemy).GetPosition()
              PlayEffectScript(d0906EnemyEffect_Vanish, pos_x, pos_y, pos_z, rot, 1)
              SymbolEnemy(enemy).SymbolForceLeave(false)
            end
          else
            local generattimer = time - gd0906gimGeneratTime2
            local genetime = 3
            if time <= 3 then
            elseif generattimer >= genetime and tag == "tag_doramon" then
              local random = math.random(0, 99)
              if random < 6 then
                SymbolEnemy(enemy).SymbolForceRespawn(true)
                SetExternalVariable(enemy_name, "move")
                gd0906gimGeneratTime2 = time
              end
            end
          end
        end
      end
      if GetExternalVariable("minerva_state") == "attack_start" then
        Npc(minerva).Motion_PlayMotion("ba01", 10, false)
        local random = math.random(1, 3)
        if random == 1 then
          PlayVoiceFromName("vo_mpc747_Attack_001")
        elseif random == 2 then
          PlayVoiceFromName("vo_mpc747_Attack_002")
        elseif random == 3 then
          PlayVoiceFromName("vo_mpc747_Attack_003")
        end
        SetExternalVariable("minerva_state", "attack")
        gd0906gimMinervaFloatMessage = gd0906gimMinervaFloatMessage + 1
        if 4 <= gd0906gimMinervaFloatMessage then
          PlayVoiceFromName("vo_mpc747_Joy_001")
          local random = math.random(1, 5)
          if random == 1 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0010", 60)
          elseif random == 2 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0020", 60)
          elseif random == 3 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0030", 60)
          elseif random == 4 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0040", 60)
          elseif random == 5 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0050", 60)
          end
          gd0906gimMinervaFloatMessage = 0
        end
      elseif GetExternalVariable("minerva_state") == "attack" and Npc(minerva).IsPlayingMotion("ba01") == false then
        Npc(minerva).Motion_ResetPlayMotion(10)
        SetExternalVariable("minerva_state", "stay")
      end
      if GetExternalVariable("aigio_state") == "attack_start" then
        Npc(aigio).Motion_PlayMotion("ba01", 10, false)
        local random = math.random(1, 3)
        if random == 1 then
          PlayVoiceFromName("vo_mpc183_Attack_001")
        elseif random == 2 then
          PlayVoiceFromName("vo_mpc183_Attack_002")
        elseif random == 3 then
          PlayVoiceFromName("vo_mpc183_Attack_003")
        end
        SetExternalVariable("aigio_state", "attack")
        gd0906gimMinervaFloatMessage = gd0906gimMinervaFloatMessage + 1
        if 4 <= gd0906gimMinervaFloatMessage then
          PlayVoiceFromName("vo_mpc747_Joy_001")
          local random = math.random(1, 5)
          if random == 1 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0010", 60)
          elseif random == 2 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0020", 60)
          elseif random == 3 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0030", 60)
          elseif random == 4 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0040", 60)
          elseif random == 5 then
            Npc(minerva).StartFloatMessage("r_d0906_0050_0050", 60)
          end
          gd0906gimMinervaFloatMessage = 0
        end
      elseif GetExternalVariable("aigio_state") == "attack" and Npc(aigio).IsPlayingMotion("ba01") == false then
        Npc(aigio).Motion_ResetPlayMotion(10)
        SetExternalVariable("aigio_state", "stay")
      end
      if 3 <= gd0906gimAigioFloatMessage then
        gd0906gimAigioFloatMessageTimer = gd0906gimAigioFloatMessageTimer + elapsed_frame
        if gd0906gimAigioFloatMessageTimer >= 15 then
          PlayVoiceFromName("vo_mpc183_Inspire_004")
          local random = math.random(1, 5)
          if random == 1 then
            Npc(aigio).StartFloatMessage("r_d0906_0040_0030", 60)
          elseif random == 2 then
            Npc(aigio).StartFloatMessage("r_d0906_0040_0040", 60)
          elseif random == 3 then
            Npc(aigio).StartFloatMessage("r_d0906_0040_0030", 60)
          elseif random == 4 then
            Npc(aigio).StartFloatMessage("r_d0906_0040_0040", 60)
          elseif random == 5 then
            Npc(aigio).StartFloatMessage("r_d0906_0040_0050", 60)
          else
            Npc(aigio).StartFloatMessage("r_d0906_0040_0050", 60)
          end
          gd0906gimAigioFloatMessage = 0
          gd0906gimAigioFloatMessageTimer = 0
        end
      end
    end
    if GetExternalVariable("PlayVoice_Event_816") == "voice_start" then
      PlayVoiceFromName("vo_mpc173_preparation_002")
      PlayVoiceFromName("vo_mpc733_preparation_002")
      SetExternalVariable("PlayVoice_Event_816", "end")
    end
    if GetExternalVariable("PlayVoice_Event_819") == "beelze_start" then
      PlayVoiceFromName("vo_ymb006_Order_002")
      SetExternalVariable("PlayVoice_Event_819", "end")
    end
    if GetExternalVariable("PlayVoice_Event_820") == "diana_start" then
      PlayVoiceFromName("vo_chr733_special_002")
      SetExternalVariable("PlayVoice_Event_820", "end")
    elseif GetExternalVariable("PlayVoice_Event_820") == "aporo_start" then
      PlayVoiceFromName("vo_chr173_special_001")
      SetExternalVariable("PlayVoice_Event_820", "end")
    end
    if FlagCheck(FLAG_GIMMICK_D09_050) and GetExternalVariable("invisible_attachmen") == "invisible" then
      local aporo = GetIndex(NPC, "npc_0001")
      local diana = GetIndex(NPC, "npc_0002")
      Npc(aporo).HideAttachment(3)
      Npc(diana).HideAttachment(3)
      SetExternalVariable("invisible_attachmen", "end")
    end
    if GetExternalVariable("player_walk") == "start" then
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    end
  elseif gMapNum == 907 then
    local operatedegrees = GetLeftAxisMoveOperateDegrees()
    local speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
    if EnableOperatePlayer() and IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil then
      if 0 < operatedegrees and operatedegrees < 45 then
        Player().Move_SetRotationY(0, 5)
      elseif operatedegrees >= 45 and operatedegrees < 180 then
        Player().Move_Move2D(90, speed)
      elseif operatedegrees >= 180 and operatedegrees < 315 then
        Player().Move_Move2D(270, speed)
      else
        Player().Move_SetRotationY(0, 5)
      end
    end
    local ulcun = GetIndex(NPC, "npc_0006")
    Npc(ulcun).Physics_SetCollisionContactForNotHit()
    Npc(ulcun).DisableCullingInNowFrame()
    if GetExternalVariable("PlayerMove_Event_860") == "start" then
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    end
  end
end

function BeforeCameraPose(elapsed_frame)
  if gMapNum == 907 then
    local aim_x = 0
    local aim_y = 0
    local aim_z = 0
    local cam_x = 0
    local cam_y = 0
    local cam_z = 0
    local vector2d_x, vector2d_z = GetUnitVector2D(180)
    aim_x, aim_y, aim_z = Player().GetPosition()
    cam_x = aim_x + 9 * vector2d_x
    cam_y = aim_y
    cam_z = aim_z + 9 * vector2d_z
    local door_state = GetExternalVariable("theater_door_state")
    if door_state == "intro" or door_state == "walk_in" or door_state == "create" or door_state == "open" then
    else
      SetInstantCameraInNowFrame(aim_x, aim_y + 3, aim_z, cam_x, cam_y + 3.5, cam_z, DEFAULT_ANGLE, 0, 30)
    end
  end
end

function OnFieldAttackSymbolEnemy(object_index, args)
  if gMapNum == 905 then
    local tag = SymbolEnemy(object_index).GetTag()
    if tag == "tag_enemy1" then
      CallEventScriptFunction("Prcs_d0905_ThiefCaptured", 1)
      return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
    elseif tag == "tag_enemy2" then
      CallEventScriptFunction("Prcs_d0905_ThiefCaptured", 2)
      return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
    elseif tag == "tag_enemy3" then
      CallEventScriptFunction("Prcs_d0905_ThiefCaptured", 3)
      return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
    elseif tag == "tag_enemy4" then
      CallEventScriptFunction("Prcs_d0905_ThiefCaptured", 4)
      return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
    elseif tag == "tag_enemy5" then
      CallEventScriptFunction("Prcs_d0905_ThiefCaptured", 5)
      return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
    end
  elseif gMapNum == 906 then
    if FlagCheck(FLAG_GIMMICK_D09_040) and not FlagCheck(FLAG_GIMMICK_D09_050) and gd0906gimFAProcessDelay == 1 then
      if args.defeat == false then
        local tag = SymbolEnemy(object_index).GetTag()
        if GetExternalVariable("gim_inori_state") == "usual" then
          SetExternalVariable("gim_inori_state", "attack_start")
        end
        if tag == "tag_beruzebu" then
          local action = BIT_OR(REACTION_TO_ATTACK_NO_MOTION_BIT, REACTION_TO_ATTACK_NO_ENCOUNT_BIT)
          return action
        else
          BigEnemyHP_table[object_index] = BigEnemyHP_table[object_index] - 1
          if BigEnemyHP_table[object_index] == 0 then
            local enemy_name = SymbolEnemy(object_index).GetUniqueName()
            SetExternalVariable(enemy_name, "dead")
            local rot = SymbolEnemy(object_index).GetRotationY()
            local pos_x, pos_y, pos_z = SymbolEnemy(object_index).GetPosition()
            PlayEffectScript(d0906EnemyEffect_Vanish, pos_x, pos_y, pos_z, rot, 1)
            SymbolEnemy(object_index).SymbolForceLeave(false)
            gd0906gimEnemyCounter = gd0906gimEnemyCounter + 1
            gd0906gimAigioFloatMessage = gd0906gimAigioFloatMessage + 1
            if 3 > gd0906gimAigioFloatMessage then
              local random = math.random(1, 3)
              if random == 1 then
                PlayVoiceFromName("vo_mpc173_Joy_001")
              elseif random == 2 then
                PlayVoiceFromName("vo_mpc733_Joy_001")
              elseif random == 3 then
                PlayVoiceFromName("vo_npc001_Joy_001")
              end
            end
            return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
          else
            local enemy_name = SymbolEnemy(object_index).GetUniqueName()
            local state = GetExternalVariable(enemy_name)
            if state == "move" then
              return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
            elseif state == "attack_start_p" or state == "attack_start" then
              SetExternalVariable(enemy_name, "damage")
              return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
            elseif state == "attack_hit" or state == "attack_end" or state == "attack_hit_p" or state == "attack_end_p" then
              SetExternalVariable(enemy_name, "damage2")
              local bit = BIT_OR(REACTION_TO_ATTACK_NO_MOTION_BIT, REACTION_TO_ATTACK_NO_ENCOUNT_BIT)
              return bit
            end
          end
        end
      else
        local enemy_name = SymbolEnemy(object_index).GetUniqueName()
        SetExternalVariable(enemy_name, "dead")
        local rot = SymbolEnemy(object_index).GetRotationY()
        local pos_x, pos_y, pos_z = SymbolEnemy(object_index).GetPosition()
        PlayEffectScript(d0906EnemyEffect_Vanish, pos_x, pos_y, pos_z, rot, 1)
        SymbolEnemy(object_index).SymbolForceLeave(false)
        gd0906gimEnemyCounter = gd0906gimEnemyCounter + 1
        gd0906gimAigioFloatMessage = gd0906gimAigioFloatMessage + 1
        return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
      end
    end
    return REACTION_TO_ATTACK_NO_ENCOUNT_BIT
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  if gMapNum == 904 then
    local name = SymbolEnemy(symbol_index).GetUniqueName()
    if name == "enemy_06" then
      CallEventScriptFunction("M440_Event_770")
    end
  end
end

function OnEncountSymbolEnemy(object_index, args)
  if gMapNum == 904 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    if enemy_name == "enemy_01" or enemy_name == "enemy_02" or enemy_name == "enemy_03" or enemy_name == "enemy_04" then
      SymbolEnemy(object_index).SymbolForceLeave(true)
      return false
    end
    if enemy_name == "enemy_05" then
      return REACTION_TO_ENCOUN_FORCE_NORMAL_ENCOUNT
    end
  elseif gMapNum == 905 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    if enemy_name == "enemy_05" then
      return false
    end
  elseif gMapNum == 906 then
    return false
  end
end

function OnCheckLocatorLift(gimmick_index, args)
  print("=============== OnCheckLocatorLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  local drive_state = LocatorObject(elv_index).GetSelfObjectScriptExternalVariable("drive_state")
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== is_forward = ", is_forward, " ======")
  PlaySE(200008, 100)
  PlayAndGlobalManageSE(200009, 100, 60, 90, true, true)
  SetExternalVariable("move_elv", "moveing")
  if gMapNum == 905 then
  end
  LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("drive_state", "start")
  LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("effect_state", "play")
  if is_forward == "true" then
    LocatorObject(elv_index).MoveStartLift(true)
  elseif is_forward == "false" then
    LocatorObject(elv_index).MoveStartLift(false)
  end
end

function CheckMoveStartGimmickLift(gimmick_index, args)
  print("=============== CheckMoveStartGimmickLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  local drive_state = LocatorObject(elv_index).GetSelfObjectScriptExternalVariable("drive_state")
  SetExternalVariable("move_elv", "moveing")
  if drive_state == nil then
    return true
  elseif drive_state == "moving" or drive_state == "standby_arrive" then
    print("elevator moving")
    return true
  else
    return false
  end
end

function CheckMoveEndGimmickLift(gimmick_index, args)
  print("=============== CheckMoveEndGimmickLift =====================")
  elv_index, was_forward, is_carry_player = gimmick_index, args.was_forward, args.is_carrying_the_player
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== was_forward = ", was_forward, " ====== is_carry_player =", is_carry_player, "======")
  local start_loc = GetLastPlayerSetLocator()
  local drive_state = LocatorObject(elv_index).GetSelfObjectScriptExternalVariable("drive_state")
  StopGlobalManageSE(90, 15)
  SetExternalVariable("play_elavator_se", "initialize")
  if drive_state == "standby_arrive" then
    LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("drive_state", "arrive")
  end
  SetExternalVariable("move_elv", "stop")
  LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("effect_state", "end")
  ClearInstantCamera(45, LINEAR)
  if drive_state == nil then
    return true
  elseif drive_state ~= "arrived" then
    return false
  else
    print("elevator arrived")
    return true
  end
end

function OnTouchCollision(col_name)
  if gMapNum == 905 and col_name == "evt_1014" then
    local elv_0001 = GetIndex(GIM, "elv_0001")
    if LocatorObject(elv_0001).ExistingLift(false) then
      LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("drive_state", "start")
      LocatorObject(elv_index).SetSelfObjectScriptExternalVariable("effect_state", "play")
      SetExternalVariable("move_elv_single", "moveing")
      CallEventScriptFunction("Prcs_d0905_WaitElv")
      PlaySE(200008, 100)
      PlayAndGlobalManageSE(200009, 100, 60, 90, true, true)
    end
  end
end

function d0906_SetEnemyHP(index, tag)
  if tag == "tag_doramon" then
    BigEnemyHP_table[index] = 1
  elseif tag == "tag_zanba" then
    BigEnemyHP_table[index] = 2
  elseif tag == "tag_scal" then
    BigEnemyHP_table[index] = 5
  elseif tag == "tag_beruzebu" then
    BigEnemyHP_table[index] = 99
  end
  gd0906gimEnemyGeneratCounter = gd0906gimEnemyGeneratCounter + 1
end
