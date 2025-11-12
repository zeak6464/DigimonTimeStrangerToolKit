require("function_control")
require("function_hazama")
DEFINE_FLAG("FLAG_GIMMICK_H03_010")
DEFINE_FLAG("FLAG_GIMMICK_H03_020")
DEFINE_FLAG("FLAG_GIMMICK_H03_030")
DEFINE_FLAG("FLAG_GIMMICK_H03_040")
DEFINE_FLAG("FLAG_GIMMICK_H03_050")
DEFINE_FLAG("FLAG_GIMMICK_H03_060")
DEFINE_FLAG("FLAG_GIMMICK_H03_070")
DEFINE_FLAG("FLAG_GIMMICK_H03_080")
DEFINE_FLAG("FLAG_GIMMICK_H03_090")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_HAZAMA03_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_TRIP_H310")
DEFINE_FLAG("FLAG_IS_TRIP_H311")
DEFINE_FLAG("FLAG_IS_TRIP_H312")
DEFINE_FLAG("FLAG_IS_TRIP_H313")
DEFINE_FLAG("FLAG_IS_HAZAMA_NPC_VISIBLE")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile, gMapId = "", 0, "", "", 0
RAILMOVE_FRAME = 0
RacePlayer = nil
RaceRival = nil
RaceField = nil
RaceTime = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  gMapId = string.format("%d", string.sub(gMapNum, 1, 1))
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  if gMapNum == 311 or gMapNum == 312 or gMapNum == 313 then
    local tmpPlanData, tmpRailMoveFile
    tmpPlanData = gMapPrefix .. string.format("%02d", gMapId) .. "10p"
    gPlanData = tmpPlanData
    tmpRailMoveFile = gMapPrefix .. string.format("%02d", gMapId) .. "10_railmove"
    gRailMoveFile = tmpRailMoveFile
    LoadLocatorModel(tmpPlanData)
    LoadRailMove(tmpRailMoveFile)
  elseif gMapNum == 310 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  end
  if gMapNum == 301 then
    LoadRailMove(gRailMoveFile)
  end
  if gMapNum >= 310 and gMapNum <= 313 then
    Player().LoadAttachment(7)
    Player().AttachEffectScript("ef_b_buf_100", false, 1, false, false, false, false)
    print("Load Rail Move File :", gRailMoveFile)
    Npc(GetIndex(NPC, "companion")).LoadMotion("ba02")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 301 then
    SetExternalVariable("enemy_state", "init")
    SetExternalVariable("enemy_state_bef", "init")
  end
  if gMapNum >= 310 and gMapNum <= 313 then
    print("##### Hazama Flag Initialize #####")
    SetExternalVariable("g_hazama_quest_status", QST_INITIALIZE)
    FlagClear(FLAG_IS_HAZAMA_NPC_VISIBLE)
    SetExternalVariable("race_state", "init")
    SetExternalVariable("npc_state", "visible")
    SetExternalVariable("beda_pos_x", 0)
    SetExternalVariable("beda_pos_y", 0)
    SetExternalVariable("beda_pos_z", 0)
    SetExternalVariable("is_corner", false)
    RaceTime = 0
    SetExternalVariable("g_hit_num", 0)
    SetExternalVariable("start_call", "wait")
    local x2, y2, z2 = GetRailStartPos(gRailMoveFile, "rail_move_002")
    SetExternalVariable("rival_setpos_x", x2)
    SetExternalVariable("rival_setpos_y", y2)
    SetExternalVariable("rival_setpos_z", z2)
  end
  if gMapNum == 310 then
    if not FlagCheck(FLAG_IS_TRIP_H310) then
      FlagSet(FLAG_IS_TRIP_H310)
    end
  elseif gMapNum == 311 then
    if not FlagCheck(FLAG_IS_TRIP_H311) then
      FlagSet(FLAG_IS_TRIP_H311)
    end
  elseif gMapNum == 312 then
    if not FlagCheck(FLAG_IS_TRIP_H312) then
      FlagSet(FLAG_IS_TRIP_H312)
    end
  elseif gMapNum == 313 and not FlagCheck(FLAG_IS_TRIP_H313) then
    FlagSet(FLAG_IS_TRIP_H313)
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
end

function Update(elapsed_frame)
  if gMapNum == 301 then
    if FlagCheck(FLAG_GIMMICK_H03_010) then
      local black_tail_01 = GetIndex(ENEMY, "correct01")
      SymbolEnemy(black_tail_01).SymbolForceLeave(true)
    end
    if FlagCheck(FLAG_GIMMICK_H03_020) then
      local black_tail_02 = GetIndex(ENEMY, "correct02")
      SymbolEnemy(black_tail_02).SymbolForceLeave(true)
    end
    if FlagCheck(FLAG_GIMMICK_H03_030) then
      local black_tail_03 = GetIndex(ENEMY, "correct03")
      SymbolEnemy(black_tail_03).SymbolForceLeave(true)
    end
    if not FlagCheck(FLAG_GIMMICK_H03_010) then
      local enemy = GetIndex(ENEMY, "correct01")
      local rail_name = ""
      local speed = 12
      if GetExternalVariable("enemy_state") == "init" then
      elseif GetExternalVariable("enemy_state") == "stay" then
        local enemy_pos_x, enemy_pos_y, enemy_pos_z = GetPositionAnyObject(ENEMY, enemy)
        local player_x, player_y, player_z = GetPositionAnyObject(PLAYER, 1)
        local y_degree = GetAngleToTarget2D(enemy_pos_x, enemy_pos_z, player_x, player_z)
        SymbolEnemy(enemy).Move_SetRotationY(y_degree, 10)
      elseif GetExternalVariable("enemy_state") == "move_02" then
        rail_name = "rail_move_100"
      elseif GetExternalVariable("enemy_state") == "move_r_b" then
        rail_name = "rail_move_101"
        FlagSet(FLAG_GIMMICK_H03_040)
        FlagClear(FLAG_GIMMICK_H03_050)
      elseif GetExternalVariable("enemy_state") == "move_r_a_up" then
        rail_name = "rail_move_102"
        FlagClear(FLAG_GIMMICK_H03_040)
        FlagSet(FLAG_GIMMICK_H03_050)
      elseif GetExternalVariable("enemy_state") == "move_r_a_down" then
        rail_name = "rail_move_103"
        FlagClear(FLAG_GIMMICK_H03_040)
        FlagSet(FLAG_GIMMICK_H03_050)
      elseif GetExternalVariable("enemy_state") == "move_l_b" then
        rail_name = "rail_move_104"
        FlagClear(FLAG_GIMMICK_H03_040)
        FlagSet(FLAG_GIMMICK_H03_050)
      elseif GetExternalVariable("enemy_state") == "move_l_a_up" then
        rail_name = "rail_move_105"
        FlagSet(FLAG_GIMMICK_H03_040)
        FlagClear(FLAG_GIMMICK_H03_050)
      elseif GetExternalVariable("enemy_state") == "move_l_a_down" then
        rail_name = "rail_move_106"
        FlagSet(FLAG_GIMMICK_H03_040)
        FlagClear(FLAG_GIMMICK_H03_050)
      end
      if GetExternalVariable("enemy_state") ~= "init" and GetExternalVariable("enemy_state") ~= "stay" then
        SymbolEnemy(enemy).LinkToRailMove("h0301_railmove", rail_name)
        SymbolEnemy(enemy).SetRailMoveSpeed(speed)
        SymbolEnemy(enemy).SetRailMoveInDimension2d()
        SymbolEnemy(enemy).RailMoveGo()
        SetExternalVariable("enemy_state_bef", GetExternalVariable("enemy_state"))
        if SymbolEnemy(enemy).IsArrivalRailBothEnds() then
          SetExternalVariable("enemy_state", "stay")
        end
      end
    end
  end
  if gMapNum >= 310 and gMapNum <= 313 then
    local race_state = GetExternalVariable("race_state")
    if race_state == "setting" then
      print("=============== race_state = setting =====================")
      RaceTime = 0
      local param_field = {}
      local param_player = {}
      local param_rival = {}
      if gMapNum == 310 then
        param_field.final_lap = 2
        param_player.initial_velocity = 5
        param_player.acceleration = 2
        param_player.max_velocity = 10
        param_rival.velocity = 10.5
      elseif gMapNum == 311 then
        param_field.final_lap = 3
        param_player.initial_velocity = 5
        param_player.acceleration = 2
        param_player.max_velocity = 10
        param_rival.velocity = 11
      elseif gMapNum == 312 then
        param_field.final_lap = 3
        param_player.initial_velocity = 5
        param_player.acceleration = 2
        param_player.max_velocity = 10
        param_rival.velocity = 12.5
      elseif gMapNum == 313 then
        param_field.final_lap = 3
        param_player.initial_velocity = 5
        param_player.acceleration = 2
        param_player.max_velocity = 10
        param_rival.velocity = 13.5
      end
      RaceField = Hazama_Race.Field:new(param_field)
      RacePlayer = Hazama_Race.Player:new(param_player)
      RaceRival = Hazama_Race.Rival:new(param_rival)
      RaceField:GetFieldBoostItems()
      RaceField:GetFieldJammerItems()
      RaceField:GetFieldAudience()
      Player().LinkToRailMove(gRailMoveFile, "rail_move_101")
      Npc(RaceRival.index).LinkToRailMove(gRailMoveFile, "rail_move_002")
      Npc(RaceRival.index).Physics_SetGravity(0)
      local index = GetIndex(NPC, "npc_001")
      local bx, by, bz = Npc(index).GetPosition()
      local b_rot = Npc(index).GetRotationY()
      SetExternalVariable("beda_pos_x", bx)
      SetExternalVariable("beda_pos_y", by)
      SetExternalVariable("beda_pos_z", bz)
      SetExternalVariable("beda_rot_y", b_rot)
      race_state = "race_wait"
      SetExternalVariable("race_state", race_state)
    end
    if race_state == "race_wait" then
    end
    if race_state == "race_set" then
      print("=============== race_state = race_set =====================")
      Player().LinkToRailMove(gRailMoveFile, "rail_move_101")
      Player().ScriptDigimonRideStartFromIDOnlyThisFrame(HAZAMA_RIDE_DIGIMON, false, false)
      Player().SetRailMoveDirection(true)
      Player().DisableRailMoveLeftAxisMoveOperate()
      Npc(RaceRival.index).LinkToRailMove(gRailMoveFile, "rail_move_002")
      Npc(RaceRival.index).SetRailMoveDirection(true)
      Npc(RaceRival.index).SetRailMoveInDimension3d()
      Npc(RaceRival.index).Physics_SetGravity(0)
      RaceRival.lap_time = math.floor(SecondFromFrame(GetTotalElapsedFrame()))
      RaceField:CameraUpdate()
      SetExternalVariable("start_call", "init")
    end
    if race_state == "count" then
      print("=============== race_state = count =====================")
      local beda = GetIndex(NPC, "companion")
      local start_call = GetExternalVariable("start_call")
      if start_call == "init" then
        print("=============== companion call ready... =====================")
        Npc(beda).StartFloatMessage("r_h0310_0040_0010", 40)
        SetExternalVariable("start_call", "ready")
      end
      local x, y, z = GetRailStartPos(gRailMoveFile, "rail_move_101")
      local x2, y2, z2 = GetRailStartPos(gRailMoveFile, "rail_move_002")
      print("=============== race_state = count_player =====================")
      Player().Move_SetPosition(x, y, z)
      Player().ScriptDigimonRideStartFromIDOnlyThisFrame(HAZAMA_RIDE_DIGIMON, false, false)
      Player().LinkToRailMove(gRailMoveFile, "rail_move_101")
      Player().SetRailMoveDirection(true)
      Player().DisableRailMoveLeftAxisMoveOperate()
      print("=============== race_state = count_npc =====================")
      Npc(RaceRival.index).Move_SetPosition(x2, y2, z2)
      Npc(RaceRival.index).LinkToRailMove(gRailMoveFile, "rail_move_002")
      Npc(RaceRival.index).SetRailMoveDirection(true)
      Npc(RaceRival.index).SetRailMoveInDimension3d()
      Npc(RaceRival.index).Physics_SetGravity(0)
      RaceField:CameraUpdate()
      RaceTime = RaceTime + elapsed_frame
      if RaceTime > 45 then
        race_state = "in_race"
        SetExternalVariable("race_state", race_state)
        SetExternalVariable("start_call", "go")
        CallEventScriptFunction("Prcs_H03RaceStart")
      end
      pl_x, pl_y, pl_z = Player().GetPosition()
      npc_x, npc_y, npc_z = Npc(RaceRival.index).GetPosition()
      print("#### player pos x = ", pl_x, " z = ", pl_z, " ####")
      print("#### rival  pos x = ", npc_x, " z = ", npc_z, " ####")
    elseif race_state == "in_race" then
      local start_call = GetExternalVariable("start_call")
      if start_call == "go" then
        local companion = GetIndex(NPC, "companion")
        print("=============== companion call go! companion = ", companion, " =====================")
        Npc(companion).StartFloatMessage("r_h0310_0040_0020", 120)
        Npc(companion).Motion_PlayMotion("ba02", 5, false)
        start_call = "start_animation"
        SetExternalVariable("start_call", start_call)
      end
      if start_call == "start_animation" then
        local companion = GetIndex(NPC, "companion")
        print("=============== companion anim check companion = ", companion, " =====================")
        if Npc(companion).IsPlayingMotion("ba02") == false then
          print("=============== companion anim end =====================")
          Npc(companion).Motion_PlayMotion("bn01", 5, true)
          SetExternalVariable("start_call", "init")
        end
      end
      if GetExternalVariable("npc_state") == "invisible" then
        local companion = GetIndex(NPC, "companion")
        Npc(companion).InvisibleInNowFrame(0, 0, true)
      end
      RaceField:CheckWiner(RacePlayer, RaceRival)
      if RacePlayer:IsGoal(RaceField.final_lap) then
        local frame = GetTotalElapsedFrame()
        local second = math.floor(SecondFromFrame(frame))
        RacePlayer.goal_time = second
        RacePlayer.boost_power = 0
        race_state = "race_end"
        SetExternalVariable("race_state", race_state)
      elseif RaceRival:IsGoal(RaceField.final_lap) then
        RaceRival.velocity = 1
      end
      Player().LinkToRailMove(gRailMoveFile, "rail_move_101")
      Player().ScriptDigimonRideStartFromIDOnlyThisFrame(HAZAMA_RIDE_DIGIMON, false, false)
      Player().SetRailMoveDirection(true)
      RacePlayer:Accelerate()
      RacePlayer:BoostDecay()
      RacePlayer:VelocityUpdate()
      Npc(RaceRival.index).LinkToRailMove(gRailMoveFile, "rail_move_002")
      Npc(RaceRival.index).SetRailMoveDirection(true)
      Npc(RaceRival.index).SetRailMoveInDimension3d()
      Npc(RaceRival.index).Physics_SetGravity(0)
      RaceRival:Run()
      local x2, y2, z2 = GetRailStartPos(gRailMoveFile, "rail_move_002")
      local x, y, z = Npc(RaceRival.index).GetPosition()
      if math.floor(x + 0.5) == math.floor(x2 + 0.5) and math.floor(y + 0.5) == math.floor(y2 + 0.5) and math.floor(z + 0.5) == math.floor(z2 + 0.5) then
        RaceRival:AddLap(RaceField.final_lap)
      end
      RaceRival:LapCheck()
      RaceField:BoostItemUpdate()
      RaceField:JammerItemUpdate()
      RaceField:CameraUpdate()
      local mecha = GetIndex(NPC, "npc_010")
      Npc(mecha).InvisibleInNowFrame(1, 1, false)
    end
    if race_state == "race_end" then
      print("=============== race_state = race_end =====================")
      Player().ScriptDigimonRideStartFromIDOnlyThisFrame(HAZAMA_RIDE_DIGIMON, false, true)
      Player().LinkToRailMove(gRailMoveFile, "rail_move_101")
      Player().SetRailMoveDirection(true)
      Player().RailMoveGo()
      Npc(RaceRival.index).LinkToRailMove(gRailMoveFile, "rail_move_002")
      Npc(RaceRival.index).SetRailMoveDirection(true)
      Npc(RaceRival.index).SetRailMoveInDimension3d()
      Npc(RaceRival.index).Physics_SetGravity(0)
      Npc(RaceRival.index).RailMoveGo()
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      if 1 <= math.abs(RacePlayer.goal_time - second) then
        race_state = "end"
        SetExternalVariable("race_state", race_state)
      end
      SetExternalVariable("npc_state", "visible")
    end
    if race_state == "end" then
      print("=============== race_state = end =====================")
      CallEventScriptFunction("Prcs_H03RaceEnd", RaceField.winer)
    end
  end
end

function OnCheckLocatorObject(gimmick_index)
  print("=============== OnCheckLocatorObject =====================")
end

function OnAwayFromCollision(col_name)
end

function OnFieldAttackSymbolEnemy(object_index, args)
  print("=============== OnFieldAttackSymbolEnemy =====================")
  if gMapNum == 301 then
  elseif gMapNum >= 310 and gMapNum <= 313 then
    local encount_status = REACTION_TO_ATTACK_NO_ENCOUNT_BIT
    RacePlayer:VelocityDownEnemy(object_index)
    local pos_x, pos_y, pos_z = SymbolEnemy(object_index).GetPosition()
    local rot = SymbolEnemy(object_index).GetRotationY()
    PlayEffectScript("ef_f_hit_200_nele", pos_x, pos_y + 1, pos_z, rot, 1)
    PlayAndManageSE(300206, 100, 0, 1, false, true)
    local hit_num = GetExternalVariable("g_hit_num")
    hit_num = hit_num + 1
    SetExternalVariable("g_hit_num", hit_num)
    print("##### hit_num = ", tostring(hit_num), " #####")
    print("##### encount_status == ", encount_status, " args.defeat == ", args.defeat, " #####")
    return encount_status
  end
end

function OnEncountSymbolEnemy(index, args)
  print("encount")
  if 310 <= gMapNum and gMapNum <= 313 then
    local race_state = GetExternalVariable("race_state")
    if race_state == "in_race" then
      return false
    end
  end
end

function OnTouchCollision(col_name)
  print("=============== OnTouchCollision =====================")
  print("========= col_name = ", col_name, " =========")
  if 310 <= gMapNum and gMapNum <= 313 then
    local race_state = GetExternalVariable("race_state")
    if race_state == "in_race" then
      local splt = ctrl_StringSplit(col_name, "_")
      local num = tonumber(splt[2])
      if 2 <= num and num <= 9 then
        for i = 1, #RaceField.audience do
          if num == RaceField.audience[i].sort then
            local mess = ""
            if RaceField.winer == nil then
              mess = string.format("r_%s%04d_0010_%d_%d", gMapPrefix, gMapNum, RacePlayer.lap, RaceField.audience[i].mess)
            elseif RaceField.winer == "player" then
              mess = string.format("r_%s%04d_0010_%d_%d", gMapPrefix, gMapNum, RaceField.final_lap, RaceField.audience[i].mess)
              mess = mess .. "_w"
            elseif RaceField.winer == "rival" then
              mess = string.format("r_%s%04d_0010_%d_%d", gMapPrefix, gMapNum, RaceField.final_lap, RaceField.audience[i].mess)
              mess = mess .. "_l"
            end
            print("#### num = ", num, " i = ", i, "mess = ", mess, " ####")
            Npc(RaceField.audience[i].index).StartFloatMessage(mess, 1000)
          end
        end
      end
      if 300 == num or 320 == num or 340 == num or 360 == num then
        RacePlayer:UpdateCheckPoint()
      end
      if 310 == num or 330 == num or 350 == num or 370 == num then
        RacePlayer:UpdateCheckPointEnd()
      end
    end
    if col_name == "evt_0002" and RacePlayer.lap == 0 then
      SetExternalVariable("npc_state", "invisible")
    end
    if col_name == "evt_0200" then
      RacePlayer:AddLap()
    end
  end
end

function OnFieldAttackGimmick(obj_index, args)
  if 310 <= gMapNum and gMapNum <= 313 then
    local race_state = GetExternalVariable("race_state")
    if race_state == "in_race" then
      local unique_name = Gimmick(obj_index).GetUniqueName()
      print("gim_name: ", unique_name)
      if unique_name ~= nil then
        if string.find(unique_name, "meat") ~= nil then
          print("boost")
          RacePlayer:Boost()
          RaceField:BoostItemInvisible(obj_index)
        end
        if string.find(unique_name, "jammer") ~= nil then
          RacePlayer:VelocityDownGimmick(obj_index)
          RaceField:JammerItemInvisible(obj_index)
          local hit_num = GetExternalVariable("g_hit_num")
          hit_num = hit_num + 1
          SetExternalVariable("g_hit_num", hit_num)
          print("##### hit_num = ", tostring(hit_num), " #####")
        end
      end
    end
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local is_fa = args.by_field_attack
  if gMapNum == 301 and is_fa == true then
    local name = SymbolEnemy(symbol_index).GetUniqueName()
    if name == "correct01" then
      FlagSet(FLAG_GIMMICK_H03_010)
      CallEventScriptFunction("M100_Event_085")
    elseif name == "correct02" then
      FlagSet(FLAG_GIMMICK_H03_020)
      CallEventScriptFunction("M100_Event_085")
    elseif name == "correct03" then
      FlagSet(FLAG_GIMMICK_H03_030)
      CallEventScriptFunction("M100_Event_085")
    end
  end
end
