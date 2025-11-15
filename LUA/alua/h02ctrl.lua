require("function_control")
require("function_common")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_HAZAMA02_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_TRIP_H210")
DEFINE_FLAG("FLAG_IS_TRIP_H211")
DEFINE_FLAG("FLAG_IS_TRIP_H212")
DEFINE_FLAG("FLAG_IS_TRIP_H213")
DEFINE_FLAG("FLAG_IS_HAZAMA_NPC_VISIBLE")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE1")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE2")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE3")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE4")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE5")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE6")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE7")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE8")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE9")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE10")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE11")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE12")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE13")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE14")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE15")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE16")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE17")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE18")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE19")
DEFINE_FLAG("FLAG_IS_HAZAMA_WAVE20")
DEFINE_FLAG("FLAG_IS_H210_PERFECT_CLEAR")
DEFINE_FLAG("FLAG_IS_H211_PERFECT_CLEAR")
DEFINE_FLAG("FLAG_IS_H212_PERFECT_CLEAR")
DEFINE_FLAG("FLAG_IS_H213_PERFECT_CLEAR")
DEFINE_FLAG("FLAG_IS_NOT_HIT_ENCOUNT")
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
  if gMapNum == 210 then
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    local tmpRailMoveFile
    tmpRailMoveFile = gMapPrefix .. string.format("%02d", gMapId) .. "10_railmove"
    LoadRailMove(tmpRailMoveFile)
  elseif gMapNum == 220 or gMapNum == 221 or gMapNum == 222 then
  else
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  end
  if gMapNum == 201 then
  elseif gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    AddCameraLoad("cam01_railcam")
    AddCameraLoad("cam06_railcam")
    print("====== HAZAMA OBJ EFFECT SET============")
    obj1 = GetIndex(GIMMICK, "panel01")
    obj2 = GetIndex(GIMMICK, "panel02")
    obj3 = GetIndex(GIMMICK, "panel03")
    obj4 = GetIndex(GIMMICK, "panel04")
    obj5 = GetIndex(GIMMICK, "panel05")
    obj6 = GetIndex(GIMMICK, "panel06")
    obj7 = GetIndex(GIMMICK, "panel07")
    obj8 = GetIndex(GIMMICK, "panel08")
    local obj = {
      obj1,
      obj2,
      obj3,
      obj4,
      obj5,
      obj6,
      obj7,
      obj8
    }
    for i = 1, 8 do
      local index = obj[i]
      if index == nil then
        print("====== index nil ============")
      else
        print("====== obj = ", index, " ============")
      end
      LoadEffectScript("ef_f_mov_111_wa", i + 1)
      LoadEffectScript("ef_f_mov_112_wa", i + 1)
      Gimmick(index).AttachEffectScript("ef_f_mov_112_wa", false, i + 1, false, false, false, true)
    end
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 201 then
    gMaXNum = 6
    Player().SetRailMoveInDimension3d()
    Player().SetRailMoveSpeed(15)
    Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(20)
    SetExternalVariable("rail_set", "rail_00")
    SetExternalVariable("effect_play", "Initialize")
    SetExternalVariable("rail_move_dir", "Initialize")
  end
  if gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    print("##### Hazama Flag Initialize #####")
    SetExternalVariable("g_hazama_quest_status", QST_INITIALIZE)
    FlagClear(FLAG_IS_HAZAMA_WAVE1)
    FlagClear(FLAG_IS_HAZAMA_WAVE2)
    FlagClear(FLAG_IS_HAZAMA_WAVE3)
    FlagClear(FLAG_IS_HAZAMA_WAVE4)
    FlagClear(FLAG_IS_HAZAMA_WAVE5)
    FlagClear(FLAG_IS_HAZAMA_WAVE6)
    FlagClear(FLAG_IS_HAZAMA_WAVE7)
    FlagClear(FLAG_IS_HAZAMA_WAVE8)
    FlagClear(FLAG_IS_HAZAMA_WAVE9)
    FlagClear(FLAG_IS_HAZAMA_WAVE10)
    FlagClear(FLAG_IS_HAZAMA_WAVE11)
    FlagClear(FLAG_IS_HAZAMA_WAVE12)
    FlagClear(FLAG_IS_HAZAMA_WAVE13)
    FlagClear(FLAG_IS_HAZAMA_WAVE14)
    FlagClear(FLAG_IS_HAZAMA_WAVE15)
    FlagClear(FLAG_IS_HAZAMA_WAVE16)
    FlagClear(FLAG_IS_HAZAMA_WAVE17)
    FlagClear(FLAG_IS_HAZAMA_WAVE18)
    FlagClear(FLAG_IS_HAZAMA_WAVE19)
    FlagClear(FLAG_IS_HAZAMA_WAVE20)
    FlagClear(FLAG_IS_HAZAMA_NPC_VISIBLE)
    SetExternalVariable("g_wait", "Initialize")
    SetExternalVariable("g_dot_talk_candel", false)
    SetExternalVariable("g_encount_num", 0)
  end
  if gMapNum == 210 then
    if not FlagCheck(FLAG_IS_TRIP_H210) then
      FlagSet(FLAG_IS_TRIP_H210)
    end
  elseif gMapNum == 211 then
    if not FlagCheck(FLAG_IS_TRIP_H211) then
      FlagSet(FLAG_IS_TRIP_H211)
    end
  elseif gMapNum == 212 then
    if not FlagCheck(FLAG_IS_TRIP_H212) then
      FlagSet(FLAG_IS_TRIP_H212)
    end
  elseif gMapNum == 213 and not FlagCheck(FLAG_IS_TRIP_H213) then
    FlagSet(FLAG_IS_TRIP_H213)
  end
  if gMapNum == 220 or gMapNum == 221 or gMapNum == 222 then
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 201 then
    local rail_move_dir = GetExternalVariable("rail_move_dir")
    if rail_move_dir == "forward" or rail_move_dir == "backward" then
      DisableMenuInNowFrame()
      DisableAnalyzeAndFieldAttackOnlyThisFrame()
    end
  end
  if gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    print("##### HAZAMA02 ctrl preparation before reaction to field script #####")
    local QuestTimer = 0
    local quest_status = GetExternalVariable("g_hazama_quest_status")
    if quest_status == QST_PROGRESS then
      print("##### HAZAMA02 ctrl uppdate script START #####")
      if gMapNum == 210 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 920, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      elseif gMapNum == 211 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 921, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      elseif gMapNum == 212 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 922, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      elseif gMapNum == 213 then
        QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, 923, -1))
        print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
      end
      if QuestTimer == 99 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE1) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE1)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 1)
          print("========= WAVE1 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 95 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE2) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE2)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 2)
          print("========= WAVE2 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 91 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE3) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE3)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 3)
          print("========= WAVE3 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 87 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE4) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE4)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 4)
          print("========= WAVE4 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 83 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE5) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE5)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 5)
          print("========= WAVE5 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 79 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE6) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE6)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 6)
          print("========= WAVE6 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 75 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE7) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE7)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 7)
          print("========= WAVE7 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 71 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE8) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE8)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 8)
          print("========= WAVE8 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 67 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE9) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE9)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 9)
          print("========= WAVE9 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 63 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE10) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE10)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 10)
          print("========= WAVE10 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 59 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE11) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE11)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 11)
          print("========= WAVE11 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 55 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE12) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE12)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 12)
          print("========= WAVE12 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 51 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE13) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE13)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 13)
          print("========= WAVE13 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 47 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE14) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE14)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 14)
          print("========= WAVE14 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 43 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE15) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE15)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 15)
          print("========= WAVE15 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 39 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE16) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE16)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 16)
          print("========= WAVE16 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 35 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE17) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE17)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 17)
          print("========= WAVE17 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 31 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE18) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE18)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 18)
          print("========= WAVE18 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 27 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE19) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE19)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 19)
          print("========= WAVE19 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 23 then
        if not FlagCheck(FLAG_IS_HAZAMA_WAVE20) then
          SetExternalVariable("g_wait", "Initialize")
          FlagSet(FLAG_IS_HAZAMA_WAVE20)
          CallEventScriptFunction("Prcs_h02_FieldObjectSync", 20)
          print("========= WAVE20 quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
        end
      elseif QuestTimer == 0 and EnableOperatePlayer() then
        CallEventScriptFunction("Prcs_h02_StageClear")
      end
    end
  end
end

function Update(elapsed_frame)
  if gMapNum == 201 then
    local rail_move_dir = GetExternalVariable("rail_move_dir")
    if rail_move_dir == "forward" or rail_move_dir == "backward" then
      RAILMOVE_FRAME = RAILMOVE_FRAME + elapsed_frame
    end
    local rail_set = GetExternalVariable("rail_set")
    local num = tonumber(string.sub(rail_set, -2))
    if 0 < num then
      Player().LinkToRailMove(gRailMoveFile, num)
    end
    local x, y, z = Player().GetPosition()
    local rotateY = Player().GetRotationY()
    local effect_state = GetExternalVariable("effect_state")
    if effect_state == "play" then
      PlayEffectScript("ef_f_mov_111_wa", x, y + 1.7, z, rotateY, 1)
      PlaySE(200006, 100)
      SetExternalVariable("effect_state", "Initialize")
    elseif effect_state == "end" then
      PlayEffectScript("ef_f_mov_111_wa", x, y, z, rotateY, 1)
      PlaySE(200006, 100)
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
  if gMapNum == 201 then
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
        CallEventScriptFunction("Prcs_h02_RailMoveEnd")
        local index1 = GetIndex(GIM, "gim_0001")
        local index2 = GetIndex(GIM, "gim_0002")
        LocatorObject(index1).SetEnablePlayerCheck(true)
        LocatorObject(index2).SetEnablePlayerCheck(true)
      end
    end
  end
  if gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
  else
    print("##### ctrl uppdate script #####")
  end
  if gMapNum == 220 or gMapNum == 221 or gMapNum == 222 then
  end
end

function OnCheckLocatorObject(gimmick_index)
  print("=============== OnCheckLocatorObject =====================")
  local tag = LocatorObject(gimmick_index).GetTag()
  if tag ~= "" and tonumber(tag) <= 100 then
    local x, y, z = LocatorObject(gimmick_index).GetPosition()
    local rotateY = LocatorObject(gimmick_index).GetRotationY()
    local frame = 25
    if gMapNum == 201 then
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
  if gMapNum == 201 and col_name ~= "evt_1000" then
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

function OnDefeatedSymbolEnemy(symbol_index, args)
  print("=============== OnDefeatedSymbolEnemy =====================")
  local is_fa = args.by_field_attack
  if gMapNum == 201 then
  elseif gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    local quest_status = GetExternalVariable("g_hazama_quest_status")
    local quest_id = 0
    if quest_status == QST_PROGRESS then
      if gMapNum == 210 then
        quest_id = 920
      elseif gMapNum == 211 then
        quest_id = 921
      elseif gMapNum == 212 then
        quest_id = 922
      elseif gMapNum == 213 then
        quest_id = 923
      end
      QuestTimer = math.floor(QuestGetTimer(QUEST_GUIDE_SUB, quest_id, -1))
      print("========= SUCCESS quest_timer = ", QuestTimer, " quest_status = ", quest_status, " =========")
    end
    if QuestTimer <= 23 then
      local enemy_num = 0
      for i = 1, 20 do
        enemy_num = enemy_num + SymbolEnemySystem.GetSymbolEnemyExistsNumInSpawnPattern(i)
      end
      print("##### enemy_num = ", tostring(enemy_num), " #####")
      if enemy_num <= 0 then
        print("##### PERFECT CLEAR #####")
        if gMapNum == 210 then
          FlagSet(FLAG_IS_H210_PERFECT_CLEAR)
        elseif gMapNum == 211 then
          FlagSet(FLAG_IS_H211_PERFECT_CLEAR)
        elseif gMapNum == 212 then
          FlagSet(FLAG_IS_H212_PERFECT_CLEAR)
        elseif gMapNum == 213 then
          FlagSet(FLAG_IS_H213_PERFECT_CLEAR)
        end
        CallEventScriptFunction("Prcs_h02_StageClear")
      end
    end
  elseif gMapNum == 220 or gMapNum == 221 or gMapNum == 222 then
  end
end

function OnEncountSymbolEnemy(symbol_index, args)
  print("=============== OnEncountSymbolEnemy =====================")
  if gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
    local encount_num = GetExternalVariable("g_encount_num")
    encount_num = encount_num + 1
    SetExternalVariable("g_encount_num", encount_num)
    print("##### encount_num = ", tostring(encount_num), " #####")
    local encount_status = true
    if FlagCheck(FLAG_IS_NOT_HIT_ENCOUNT) then
      if args.back_attack then
        encount_status = false
      else
        encount_status = false
      end
    end
  end
  return encount_status
end
