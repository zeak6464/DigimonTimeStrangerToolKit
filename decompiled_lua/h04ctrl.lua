require("function_control")
require("function_hazama")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_HAZAMA04_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_TRIP_H415")
DEFINE_FLAG("FLAG_IS_TRIP_H416")
DEFINE_FLAG("FLAG_IS_TRIP_H417")
DEFINE_FLAG("FLAG_IS_TRIP_H418")
DEFINE_FLAG("FLAG_IS_HAZAMA_NPC_VISIBLE")
DEFINE_FLAG("FLAG_IS_HAZAMA_BOSS_CALL")
DEFINE_FLAG("FLAG_IS_NOT_HIT_ENCOUNT")
DEFINE_FLAG("FLAG_IS_NOT_FA_ENCOUNT")
DEFINE_FLAG("FLAG_IS_H418_SHUTDOWN")
DEFINE_FLAG("FLAG_IS_HAZAMA_RESERVE_DIGITTER")
DEFINE_FLAG("FLAG_SUB_900_163_002")
DEFINE_FLAG("FLAG_SUB_900_164_002")
DEFINE_FLAG("FLAG_SUB_900_165_002")
DEFINE_FLAG("FLAG_SUB_900_166_002")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile, gMapId = "", 0, "", "", 0
RAILMOVE_FRAME = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  gMapId = string.format("%d", string.sub(gMapNum, 1, 1))
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  LoadEffectScript("ef_f_mov_111_wa", 1)
  LoadEffectScript("ef_f_mov_112_wa", 1)
  Player().AttachEffectScript("ef_f_mov_112_wa", true, 1, false, false, true, true)
  if gMapNum == 416 or gMapNum == 417 or gMapNum == 418 then
    local tmpPlanData, tmpRailMoveFile
    tmpPlanData = gMapPrefix .. string.format("%02d", gMapId) .. "15p"
    tmpRailMoveFile = gMapPrefix .. string.format("%02d", gMapId) .. "15_railmove"
    LoadLocatorModel(tmpPlanData)
    LoadRailMove(tmpRailMoveFile)
  elseif gMapNum == 420 or gMapNum == 421 or gMapNum == 422 or gMapNum == 423 then
    local tmpPlanData, tmpRailMoveFile
    tmpPlanData = gMapPrefix .. string.format("%02d", gMapId) .. "20p"
    tmpRailMoveFile = gMapPrefix .. string.format("%02d", gMapId) .. "20_railmove"
    LoadLocatorModel(tmpPlanData)
    LoadRailMove(tmpRailMoveFile)
  else
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418 then
    SetExternalVariable("g_hazama_quest_status", QST_INITIALIZE)
    FlagClear(FLAG_IS_HAZAMA_BOSS_CALL)
    FlagClear(FLAG_IS_HAZAMA_NPC_VISIBLE)
    FlagClear(FLAG_IS_H418_SHUTDOWN)
    print("##### ENEMY_NUM GetSymbolEnemyExistsNumInSpawnPattern = ", SymbolEnemySystem.GetSymbolEnemyExistsNumInSpawnPattern(-1), " #####")
    SetExternalVariable("g_reserve_boss_battle", false)
    SetExternalVariable("g_dot_talk_candel", false)
    SetExternalVariable("g_fa_defeat", 0)
  end
  if gMapNum == 420 or gMapNum == 421 or gMapNum == 422 or gMapNum == 423 then
    gMaXNum = 6
    Player().SetRailMoveInDimension3d()
    Player().SetRailMoveSpeed(15)
    Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(20)
    SetExternalVariable("rail_set", "rail_00")
    SetExternalVariable("effect_play", "Initialize")
    SetExternalVariable("rail_move_dir", "Initialize")
  end
  if gMapNum == 415 then
    if not FlagCheck(FLAG_IS_TRIP_H415) then
      FlagSet(FLAG_IS_TRIP_H415)
    end
  elseif gMapNum == 416 then
    if not FlagCheck(FLAG_IS_TRIP_H416) then
      FlagSet(FLAG_IS_TRIP_H416)
    end
  elseif gMapNum == 417 then
    if not FlagCheck(FLAG_IS_TRIP_H417) then
      FlagSet(FLAG_IS_TRIP_H417)
    end
  elseif gMapNum == 418 then
    if not FlagCheck(FLAG_IS_TRIP_H418) then
      FlagSet(FLAG_IS_TRIP_H418)
    end
  elseif gMapNum == 420 then
    if FlagCheck(FLAG_SUB_900_163_002) then
      FlagClear(FLAG_SUB_900_163_002)
    end
  elseif gMapNum == 421 then
    if FlagCheck(FLAG_SUB_900_164_002) then
      FlagClear(FLAG_SUB_900_164_002)
    end
  elseif gMapNum == 422 then
    if FlagCheck(FLAG_SUB_900_165_002) then
      FlagClear(FLAG_SUB_900_165_002)
    end
  elseif gMapNum == 423 and FlagCheck(FLAG_SUB_900_166_002) then
    FlagClear(FLAG_SUB_900_166_002)
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
end

function Update(elapsed_frame)
  if gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418 then
    CtlDigitterSendCheck(4000401, FLAG_IS_HAZAMA_RESERVE_DIGITTER, 120)
    local quest_status = GetExternalVariable("g_hazama_quest_status")
    local QuestTimer = 0
    if quest_status == QST_PROGRESS then
      if gMapNum == 415 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 945, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      elseif gMapNum == 416 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 946, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      elseif gMapNum == 417 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 947, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      elseif gMapNum == 418 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 948, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      end
      if QuestTimer == 0 and EnableOperatePlayer() then
        CallEventScriptFunction("Prcs_h04_GameOver")
      end
    end
  else
  end
  if gMapNum == 420 or gMapNum == 421 or gMapNum == 422 or gMapNum == 423 then
    local rail_move_dir = GetExternalVariable("rail_move_dir")
    if rail_move_dir == "forward" or rail_move_dir == "backward" then
      RAILMOVE_FRAME = RAILMOVE_FRAME + elapsed_frame
    end
    Player().LinkToRailMove("h0420_railmove", "rail_move_05")
    local x, y, z = Player().GetPosition()
    local rotateY = Player().GetRotationY()
    local effect_state = GetExternalVariable("effect_state")
    if effect_state == "play" then
      PlayEffectScript("ef_f_mov_111_wa", x, y + 1.7, z, rotateY, 1)
      SetExternalVariable("effect_state", "Initialize")
    elseif effect_state == "end" then
      PlayEffectScript("ef_f_mov_111_wa", x, y, z, rotateY, 1)
      SetExternalVariable("effect_state", "Initialize")
    end
    local gim_check_state = GetExternalVariable("gim_check_state")
    if gim_check_state == "false" then
      for i = 1, gMaXNum do
        if GetIndex(FLD_OBJ_LOCATOR, "gim_00" .. string.format("%02d", i)) ~= nil then
          LocatorObject(GetIndex(FLD_OBJ_LOCATOR, "gim_00" .. string.format("%02d", i))).SetEnablePlayerCheck(false)
        end
      end
      SetExternalVariable("gim_check_state", "waiting")
    elseif gim_check_state == "true" then
      for i = 1, gMaXNum do
        if GetIndex(FLD_OBJ_LOCATOR, "gim_00" .. string.format("%02d", i)) ~= nil then
          LocatorObject(GetIndex(FLD_OBJ_LOCATOR, "gim_00" .. string.format("%02d", i))).SetEnablePlayerCheck(true)
        end
      end
      SetExternalVariable("gim_check_state", "Initialize")
    end
  end
  if gMapNum == 420 or gMapNum == 421 or gMapNum == 422 or gMapNum == 423 then
    local rail_move_dir = GetExternalVariable("rail_move_dir")
    if rail_move_dir == "forward" or rail_move_dir == "backward" then
      if rail_move_dir == "forward" then
        Player().SetRailMoveDirection(true)
        SetFollowerCameraOperateRotationX(5)
        SetFollowerCameraOperateRotationY(300)
      elseif rail_move_dir == "backward" then
        Player().SetRailMoveDirection(false)
        SetFollowerCameraOperateRotationX(10)
        SetFollowerCameraOperateRotationY(240)
      end
      Player().StartEffectScript(1)
      Player().RailMoveGo()
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
      local rail_set = GetExternalVariable("rail_set")
      if rail_set == "rail_04" then
        if RAILMOVE_FRAME > 100 and RAILMOVE_FRAME <= 250 then
          SetInstantCamera(141.9, 72.1, -138.7, 151.4, 71.2, -142.1, DEFAULT_ANGLE, 180)
        elseif RAILMOVE_FRAME > 250 then
          ClearInstantCamera(0)
        else
          ClearInstantCamera(10)
        end
      else
        ClearInstantCamera(10)
      end
      if Player().IsArrivalRailBothEnds() then
        RAILMOVE_FRAME = 0
        Player().EndEffectScript(1)
        ClearInstantCamera(10)
        SetExternalVariable("rail_move_dir", "Initialize")
        SetExternalVariable("effect_state", "end")
        CallEventScriptFunction("Prcs_h04_RailMoveEnd")
        local index1 = GetIndex(GIM, "gim_0001")
        local index2 = GetIndex(GIM, "gim_0002")
        LocatorObject(index1).SetEnablePlayerCheck(true)
        LocatorObject(index2).SetEnablePlayerCheck(true)
      end
    end
  end
end

function OnCheckLocatorObject(gimmick_index)
  print("=============== OnCheckLocatorObject =====================")
  local tag = LocatorObject(gimmick_index).GetTag()
  if tag ~= "" and tonumber(tag) <= 100 then
    local x, y, z = LocatorObject(gimmick_index).GetPosition()
    local rotateY = LocatorObject(gimmick_index).GetRotationY()
    local frame = 25
    if gMapNum == 420 or gMapNum == 421 or gMapNum == 422 or gMapNum == 423 then
      if gimmick_index == 1 then
        SetInstantCamera(x, y + 1.2, z - 2, x + 4, y + 1, z + 4, DEFAULT_ANGLE, frame)
        local index1 = GetIndex(GIM, "gim_0001")
        local index2 = GetIndex(GIM, "gim_0002")
        LocatorObject(index1).SetEnablePlayerCheck(false)
        LocatorObject(index2).SetEnablePlayerCheck(false)
      elseif gimmick_index == 2 then
        SetInstantCamera(x, y + 1.2, z + 2, x + 5, y + 1, z - 4, DEFAULT_ANGLE, frame)
        local index1 = GetIndex(GIM, "gim_0001")
        local index2 = GetIndex(GIM, "gim_0002")
        LocatorObject(index1).SetEnablePlayerCheck(false)
        LocatorObject(index2).SetEnablePlayerCheck(false)
      end
    elseif rotateY < 5 or 355 < rotateY then
      SetInstantCamera(x, y + 1.2, z - 2, x, y + 1, z + 6, DEFAULT_ANGLE, frame)
    elseif rotateY < 185 and 175 < rotateY then
      SetInstantCamera(x, y + 1.2, z + 2, x, y + 1, z - 6, DEFAULT_ANGLE, frame)
    elseif rotateY < 95 and 85 < rotateY then
      SetInstantCamera(x + 2, y + 1.2, z, x - 6, y + 1, z, DEFAULT_ANGLE, frame)
    elseif rotateY < 275 and 265 < rotateY then
      SetInstantCamera(x - 2, y + 1.2, z, x + 6, y + 1, z, DEFAULT_ANGLE, frame)
    end
  end
end

function OnTouchCollision(col_name)
  print("=============== OnTouchCollision =====================")
  print("========= col_name = ", col_name, " =========")
  if (gMapNum == 420 or gMapNum == 421 or gMapNum == 422 or gMapNum == 423) and col_name ~= "evt_1000" then
    local num = string.sub(col_name, -2)
    if tonumber(num) % 2 == 0 then
      OBJ1 = tonumber(num)
      OBJ2 = tonumber(num) - 1
      SetExternalVariable("motion_set_state", "start")
    else
      OBJ1 = tonumber(num)
      OBJ2 = tonumber(num) + 1
      SetExternalVariable("motion_set_state", "start")
    end
  end
end

function OnAwayFromCollision(col_name)
end

function OnEncountSymbolEnemy(symbol_index, args)
  print("=============== OnEncountSymbolEnemy =====================")
  local encount_status = true
  if FlagCheck(FLAG_IS_NOT_HIT_ENCOUNT) then
    if args.back_attack then
      encount_status = false
    else
      encount_status = false
    end
  end
  return encount_status
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  print("=============== OnDefeatedSymbolEnemy =====================")
  local is_fa = args.by_field_attack
  if gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418 then
    if not FlagCheck(FLAG_IS_HAZAMA_BOSS_CALL) then
      local is_defeated = SymbolEnemy(symbol_index).IsSymbolDefeated()
      local enemy_num = SymbolEnemySystem.GetSymbolEnemyExistsNumInSpawnPattern(-1)
      if is_defeated then
        print("##### is_defeated = SUCCSES #####")
      else
        enemy_num = enemy_num - 1
        print("##### is_defeated = FAILED #####")
      end
      print("##### enemy_num = ", enemy_num, " #####")
      if enemy_num <= 0 then
        print("##### Call H04BossBattle() #####")
        SetExternalVariable("g_reserve_boss_battle", true)
      end
    end
    if is_fa == true then
      local fa_defeat = GetExternalVariable("g_fa_defeat")
      fa_defeat = fa_defeat + 1
      SetExternalVariable("g_fa_defeat", fa_defeat)
      print("##### fa_defeat = ", tostring(fa_defeat), " #####")
    end
  end
end

function OnFieldAttackSymbolEnemy(symbol_index, args)
  print("=============== OnFieldAttackSymbolEnemy =====================")
  local encount_status = 0
  if FlagCheck(FLAG_IS_NOT_FA_ENCOUNT) then
    if args.defeat then
      encount_status = REACTION_TO_ATTACK_ALL_BIT
    else
      encount_status = BIT_OR(REACTION_TO_ATTACK_NO_MOTION_BIT, REACTION_TO_ATTACK_NO_DAMAGE_BIT, REACTION_TO_ATTACK_NO_ENCOUNT_BIT)
    end
  end
  print("##### encount_status == ", encount_status, " args.defeat == ", args.defeat, " #####")
  return encount_status
end
