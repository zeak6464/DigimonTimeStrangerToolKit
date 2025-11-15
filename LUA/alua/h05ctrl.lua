require("function_control")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_HAZAMA05_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_TRIP_H510")
DEFINE_FLAG("FLAG_IS_TRIP_H511")
DEFINE_FLAG("FLAG_IS_TRIP_H512")
DEFINE_FLAG("FLAG_IS_TRIP_H513")
DEFINE_FLAG("FLAG_IS_HAZAMA_NPC_VISIBLE")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gresporn_timer = 1
g_time = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  gMapId = string.format("%d", string.sub(gMapNum, 1, 1))
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 511 or gMapNum == 512 or gMapNum == 513 then
    local tmpPlanData, tmpRailMoveFile
    tmpPlanData = gMapPrefix .. string.format("%02d", gMapId) .. "10p"
    gPlanData = tmpPlanData
    tmpRailMoveFile = gMapPrefix .. string.format("%02d", gMapId) .. "10_railmove"
    gRailMoveFile = tmpRailMoveFile
    LoadLocatorModel(tmpPlanData)
    LoadRailMove(tmpRailMoveFile)
  elseif gMapNum ~= 520 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  end
  LoadEffectScript("ef_f_mov_111_wa", 1)
  LoadEffectScript("ef_f_mov_112_wa", 1)
  Player().AttachEffectScript("ef_f_mov_112_wa", true, 1, false, false, true, true)
  if gMapNum == 501 then
    Player().LoadAttachment(1)
    Player().LoadAttachmentMotion(1, "r348_in02")
    Player().LoadAttachmentMotion(1, "r348_loop02")
    Player().LoadAttachmentMotion(1, "r348_out02")
    PlayerSystem.PlayerAlwaysLoadMotion("r348_in02")
    PlayerSystem.PlayerAlwaysLoadMotion("r348_loop02")
    PlayerSystem.PlayerAlwaysLoadMotion("r348_out02")
    PlayerSystem.PlayerAlwaysLoadMotion("r096_in01")
    Player().LoadMotion("bn01")
    Player().LoadMoveMotion("npc01")
    AddCameraLoad("cam53_railcam")
    AddCameraLoad("cam01_railcam")
  elseif gMapNum == 503 then
    Player().LoadMoveMotion("")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 501 then
    Player().SetRailMoveInDimension3d()
    Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(20)
    SetExternalVariable("rail_set", "rail_00")
    SetExternalVariable("rail_move_dir", "Initialize")
    SetExternalVariable("speed_switch", 7)
    SetExternalVariable("playerstate", "Initialize")
    gPlayer_State = GetExternalVariable("g_player_state")
  end
  if gMapNum == 510 or gMapNum == 511 or gMapNum == 512 or gMapNum == 513 then
    print("##### Hazama Flag Initialize #####")
    SetExternalVariable("g_hazama_quest_status", QST_INITIALIZE)
    SetExternalVariable("g_game_timer", 0)
    SetExternalVariable("g_enemy_cnt", 0)
    SetExternalVariable("g_tmp_root_num", 0)
    SetExternalVariable("g_player_state", "initialize")
    SetExternalVariable("g_game_state", "initialize")
    SetExternalVariable("g_dot_talk_candel", false)
    SetExternalVariable("g_symbol_index", 0)
    SetExternalVariable("g_encount_num", 0)
    g_time = 0
    g_rail_name_tbl = {}
    FlagClear(FLAG_IS_HAZAMA_NPC_VISIBLE)
    enemy_tbl = {}
    enemy_tbl.chr466 = {}
    enemy_tbl.chr466.type = "speeder"
    enemy_tbl.chr466.speed = 5
    enemy_tbl.chr055 = {}
    enemy_tbl.chr055.type = "fighter"
    enemy_tbl.chr055.speed = 3
    enemy_tbl.chr759 = {}
    enemy_tbl.chr759.type = "tanker"
    enemy_tbl.chr759.speed = 2
    enemy_tbl.chr307 = {}
    enemy_tbl.chr307.type = "flyspeeder"
    enemy_tbl.chr307.speed = 4
    enemy_tbl.chr015 = {}
    enemy_tbl.chr015.type = "flytanker"
    enemy_tbl.chr015.speed = 1.5
    enemy_tbl.chr317 = {}
    enemy_tbl.chr317.type = "speeder"
    enemy_tbl.chr317.speed = 4
    enemy_tbl.chr052 = {}
    enemy_tbl.chr052.type = "tanker"
    enemy_tbl.chr052.speed = 4
    enemy_tbl.chr191 = {}
    enemy_tbl.chr191.type = "flyfighter"
    enemy_tbl.chr191.speed = 6
    enemy_tbl.chr705 = {}
    enemy_tbl.chr705.type = "speeder"
    enemy_tbl.chr705.speed = 8
    enemy_tbl.chr308 = {}
    enemy_tbl.chr308.type = "flyfighter"
    enemy_tbl.chr308.speed = 6
    enemy_tbl.chr222 = {}
    enemy_tbl.chr222.type = "fighter"
    enemy_tbl.chr222.speed = 5
    enemy_tbl.chr461 = {}
    enemy_tbl.chr461.type = "center"
    enemy_tbl.chr461.speed = 1
    enemy_tbl.chr457 = {}
    enemy_tbl.chr457.type = "fighter"
    enemy_tbl.chr457.speed = 4
    enemy_tbl.chr574 = {}
    enemy_tbl.chr574.type = "flyfighter"
    enemy_tbl.chr574.speed = 2
    enemy_tbl.chr013 = {}
    enemy_tbl.chr013.type = "bakemon"
    enemy_tbl.chr013.speed = 2
    enemy_tbl.chr346 = {}
    enemy_tbl.chr346.type = "center"
    enemy_tbl.chr346.speed = 1
    enemy_tbl.chr370 = {}
    enemy_tbl.chr370.type = "speeder"
    enemy_tbl.chr370.speed = 6
    enemy_tbl.chr730 = {}
    enemy_tbl.chr730.type = "flyfighter"
    enemy_tbl.chr730.speed = 4
    enemy_tbl.chr210 = {}
    enemy_tbl.chr210.type = "hi-flyspeeder"
    enemy_tbl.chr210.speed = 2
    enemy_tbl.chr409 = {}
    enemy_tbl.chr409.type = "fighter"
    enemy_tbl.chr409.speed = 4
  end
  if gMapNum == 510 then
    if not FlagCheck(FLAG_IS_TRIP_H510) then
      FlagSet(FLAG_IS_TRIP_H510)
    end
  elseif gMapNum == 511 then
    if not FlagCheck(FLAG_IS_TRIP_H511) then
      FlagSet(FLAG_IS_TRIP_H511)
    end
  elseif gMapNum == 512 then
    if not FlagCheck(FLAG_IS_TRIP_H512) then
      FlagSet(FLAG_IS_TRIP_H512)
    end
  elseif gMapNum == 513 and not FlagCheck(FLAG_IS_TRIP_H513) then
    FlagSet(FLAG_IS_TRIP_H513)
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
end

function Update(elapsed_frame)
  if gMapNum == 501 then
    gPlayer_State = GetExternalVariable("g_player_state")
    StartSeamlessJumpRideh05()
  elseif gMapNum == 510 or gMapNum == 511 or gMapNum == 512 or gMapNum == 513 then
    local quest_status = GetExternalVariable("g_hazama_quest_status")
    if quest_status == QST_PROGRESS and GetExternalVariable("g_game_state") == "initialize" then
      SetExternalVariable("g_enemy_max", SymbolEnemySystem.GetSymbolEnemyExistsNumInSpawnPattern(-1))
      SetExternalVariable("g_game_state", "ingame")
    end
    if GetExternalVariable("g_game_state") == "ingame" then
      local root_max
      if gMapNum == 510 then
        root_max = 5
      elseif gMapNum == 511 then
        root_max = 9
      elseif gMapNum == 512 then
        root_max = 12
      elseif gMapNum == 513 then
        root_max = 14
      end
      g_time = g_time + elapsed_frame
      local second = math.floor(SecondFromFrame(g_time))
      local timer = GetExternalVariable("g_game_timer")
      SetExternalVariable("g_game_timer", second)
      local sec_timer = (timer - timer % gresporn_timer) / gresporn_timer
      local enemy_cnt = GetExternalVariable("g_enemy_cnt")
      if timer % gresporn_timer == 0 then
        enemy_cnt = enemy_cnt + 1
        if enemy_cnt <= GetExternalVariable("g_enemy_max") then
          local enemy_index = GetIndex(ENEMY, enemy_cnt)
          local sporn_time = SymbolEnemy(enemy_index).GetTag(2)
          if type(sporn_time) == "string" then
            print("##### TYPE string #####")
          elseif type(sporn_time) == "number" then
            print("##### TYPE number #####")
            sporn_time = tostring(sporn_time)
          end
          print("##### ENEMY SPORN CHECK timer = ", sec_timer, " GetUniqueName = ", sporn_time, " enemy_index = ", enemy_index, " enemy_cnt = ", enemy_cnt, " g_enemy_max = ", GetExternalVariable("g_enemy_max"), " #####")
          if sec_timer == tonumber(sporn_time) then
            print("##### ENEMY SPORN OK #####")
            local tag = SymbolEnemy(enemy_index).GetTag()
            local type = enemy_tbl[tag].type
            local root_num = 0
            math.randomseed(os.time())
            if type == "flyspeeder" or type == "flyfighter" or type == "flytanker" then
              print("##### ENEMY TYPE FLY #####")
              root_num = math.random(0, 4) + 15
              if root_num == GetExternalVariable("g_tmp_root_num") then
                root_num = (root_num - 14) % 5 + 15
              end
            elseif type == "center" then
              print("##### ENEMY TYPE CENTER #####")
              root_num = 3
            elseif type == "bakemon" then
              print("##### ENEMY TYPE BAKEMON #####")
              root_num = math.random(0, 4) + 20
              if root_num == GetExternalVariable("g_tmp_root_num") then
                root_num = (root_num - 14) % 5 + 20
              end
            elseif type == "hi-flyspeeder" then
              print("##### ENEMY TYPE HI-FLYSPEEDER #####")
              root_num = math.random(0, 4) + 25
              if root_num == GetExternalVariable("g_tmp_root_num") then
                root_num = (root_num - 14) % 5 + 25
              end
            else
              print("##### ENEMY TYPE LAND #####")
              root_num = math.random(1, root_max)
              if root_num == GetExternalVariable("g_tmp_root_num") then
                root_num = root_num % root_max + 1
              end
            end
            SetExternalVariable("g_tmp_root_num", root_num)
            print("##### root_num = ", root_num, " #####")
            local pos_x, pos_y, pos_z = 0, 0, 0
            if root_num == 1 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_001"
            elseif root_num == 2 then
              pos_x = -5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_002"
            elseif root_num == 3 then
              pos_x = 0
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_003"
            elseif root_num == 4 then
              pos_x = 5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_004"
            elseif root_num == 5 then
              pos_x = 10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_005"
            elseif root_num == 6 then
              pos_x = 0
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_006"
            elseif root_num == 7 then
              pos_x = 10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_007"
            elseif root_num == 8 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_008"
            elseif root_num == 9 then
              pos_x = 0
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_009"
            elseif root_num == 10 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_010"
            elseif root_num == 11 then
              pos_x = 5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_011"
            elseif root_num == 12 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_012"
            elseif root_num == 13 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_013"
            elseif root_num == 14 then
              pos_x = 10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_014"
            elseif root_num == 15 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_015"
            elseif root_num == 16 then
              pos_x = -5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_016"
            elseif root_num == 17 then
              pos_x = 0
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_017"
            elseif root_num == 18 then
              pos_x = 5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_018"
            elseif root_num == 19 then
              pos_x = 10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_019"
            elseif root_num == 20 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_020"
            elseif root_num == 21 then
              pos_x = -5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_021"
            elseif root_num == 22 then
              pos_x = 0
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_022"
            elseif root_num == 23 then
              pos_x = 5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_023"
            elseif root_num == 24 then
              pos_x = 10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_024"
            elseif root_num == 25 then
              pos_x = -10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_025"
            elseif root_num == 26 then
              pos_x = -5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_026"
            elseif root_num == 27 then
              pos_x = 0
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_027"
            elseif root_num == 28 then
              pos_x = 5
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_028"
            elseif root_num == 29 then
              pos_x = 10
              pos_y = 30
              pos_z = -105.5
              g_rail_name_tbl[enemy_index] = "rail_move_029"
            end
            print("##### SymbolForceRespawnAndWarp #####")
            SymbolEnemy(enemy_index).SymbolForceRespawnAndWarp(pos_x, pos_y, pos_z, false, true)
            SymbolEnemy(enemy_index).Move_SetRotationY(0, 0)
            SetExternalVariable("g_enemy_cnt", enemy_cnt)
          end
        else
        end
      end
      enemy_cnt = GetExternalVariable("g_enemy_cnt")
      if 0 < enemy_cnt then
        for i = 1, enemy_cnt do
          local current_index = GetIndex(ENEMY, i)
          if SymbolEnemy(current_index).Exists() then
            local tag = SymbolEnemy(current_index).GetTag()
            local speed = enemy_tbl[tag].speed
            if enemy_tbl[tag].type == "hi-flyspeeder" then
              local pos_x, pos_y, pos_z = SymbolEnemy(current_index).GetPosition()
              if 3 <= pos_z then
                speed = speed + 20
              elseif -24 <= pos_z then
                speed = speed + 18
              elseif -51 <= pos_z then
                speed = speed + 5
              elseif -78 <= pos_z then
                speed = speed + 3
              elseif -92 <= pos_z then
                speed = speed + 2
              end
            end
            if timer % gresporn_timer == 0 then
              print("##### enemy_no = ", current_index, "tag = ", tag, " type = ", enemy_tbl[tag].type, " speed = ", speed, " root = ", g_rail_name_tbl[current_index], " #####")
            else
            end
            local distance_to_player = GetDistanceToObject(ENEMY, current_index)
            if enemy_tbl[tag].type == "fighter" and distance_to_player < 20 then
              SymbolEnemy(current_index).SymbolForcedDiscovery(true)
            elseif enemy_tbl[tag].type == "flyfighter" and distance_to_player < 20 then
              SymbolEnemy(current_index).SymbolForcedDiscovery(true)
            else
              SymbolEnemy(current_index).LinkToRailMove("h0510_railmove", g_rail_name_tbl[current_index])
              SymbolEnemy(current_index).SetRailMoveSpeed(speed)
              if 5 < distance_to_player then
                SymbolEnemy(current_index).Physics_SetCollisionContactForNotHit()
              else
                SymbolEnemy(current_index).Physics_ResetCollisionContact()
              end
              SymbolEnemy(current_index).Physics_SetGravity(0)
              SymbolEnemy(current_index).SetRailMoveInDimension3d()
              SymbolEnemy(current_index).RailMoveGo()
            end
            if SymbolEnemy(current_index).IsArrivalRailBothEnds() then
              if GetExternalVariable("g_game_state") == "ingame" then
                SetExternalVariable("g_game_state", "end")
                SetExternalVariable("g_symbol_index", current_index)
                break
              end
              print("##### GAME STATE = ", GetExternalVariable("g_game_state"), " #####")
            end
          end
        end
      end
      if GetExternalVariable("g_player_state") == "damage" then
        print("##### PLAYER DAMAGE SEQUENCE #####")
        if Player().IsPlayingMotion("bd01") == false then
          SetExternalVariable("g_player_state", "initialize")
          Player().Motion_ResetPlayMotion(10)
        else
          Player().Motion_Monopoly()
          Player().Move_Stop()
        end
      end
      local enemy_num = SymbolEnemySystem.GetSymbolEnemyExistsNumInSpawnPattern(-1)
      if enemy_num <= 0 then
        print("##### enemy_num = ", enemy_num, " #####")
        if GetExternalVariable("g_game_state") == "ingame" and EnableOperatePlayer() then
          local result = false
          result = CallEventScriptFunction("Prcs_h05_StageClear")
          if result then
            SetExternalVariable("g_game_state", "clear")
            g_time = 0
          else
            print("##### call failed Prcs_h05_StageClear #####")
          end
        end
      end
    end
    if GetExternalVariable("g_game_state") == "end" then
      print("##### PLAYER GAME OVER SEQUENCE #####")
      if EnableOperatePlayer() then
        CallEventScriptFunction("Prcs_h05_GameOver", GetExternalVariable("g_symbol_index"))
        g_time = 0
      end
    end
  end
end

function OnCheckLocatorObject(gimmick_index)
  print("=============== OnCheckLocatorObject =====================")
end

function OnEncountSymbolEnemy(symbol_index, args)
  print("=============== OnEncountSymbolEnemy =====================")
  local encount_status = true
  if gMapNum == 510 or gMapNum == 511 or gMapNum == 512 or gMapNum == 513 then
    local encount_num = GetExternalVariable("g_encount_num")
    encount_num = encount_num + 1
    SetExternalVariable("g_encount_num", encount_num)
    print("##### encount_num = ", tostring(encount_num), " #####")
  end
  if args.back_attack then
  else
  end
  return encount_status
end

function OnFieldAttackSymbolEnemy(symbol_index, args)
  print("=============== OnFieldAttackSymbolEnemy =====================")
  local encount_status = REACTION_TO_ATTACK_NO_ENCOUNT_BIT
  print("##### encount_status == ", encount_status, " args.defeat == ", args.defeat, " #####")
  return encount_status
end

function OnTouchCollision(col_name)
  print("=============== OnTouchCollision =====================")
  print("========= col_name = ", col_name, " =========")
end
