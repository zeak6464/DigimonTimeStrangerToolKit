require("function_control")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_HAZAMA08_FIRST_TRIP")
DEFINE_FLAG("FLAG_IS_TRIP_H810")
DEFINE_FLAG("FLAG_IS_TRIP_H811")
DEFINE_FLAG("FLAG_IS_TRIP_H812")
DEFINE_FLAG("FLAG_IS_TRIP_H813")
DEFINE_FLAG("FLAG_IS_HAZAMA_NPC_VISIBLE")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile, gMapId = "", 0, "", "", 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gMapId = string.format("%d", string.sub(gMapNum, 1, 1))
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  if gMapNum == 811 or gMapNum == 812 or gMapNum == 813 then
    local tmpPlanData
    tmpPlanData = gMapPrefix .. string.format("%02d", gMapId) .. "10p"
    LoadLocatorModel(tmpPlanData)
  else
    LoadLocatorModel(gPlanData)
  end
  LoadEffectScript("ef_f_mov_111_wa", 1)
  LoadEffectScript("ef_f_mov_112_wa", 1)
  Player().AttachEffectScript("ef_f_mov_112_wa", true, 1, false, false, true, true)
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 802 then
    SetExternalVariable("elv_0002_state", "initialize")
  end
  if gMapNum == 810 or gMapNum == 811 or gMapNum == 812 or gMapNum == 813 then
    print("##### Hazama Flag Initialize #####")
    SetExternalVariable("g_hazama_quest_status", QST_INITIALIZE)
    FlagClear(FLAG_IS_HAZAMA_NPC_VISIBLE)
    SetExternalVariable("g_enemy_count", 0)
    SetExternalVariable("g_dot_talk_candel", false)
  end
  if gMapNum == 810 then
    if not FlagCheck(FLAG_IS_TRIP_H810) then
      FlagSet(FLAG_IS_TRIP_H810)
    end
  elseif gMapNum == 811 then
    if not FlagCheck(FLAG_IS_TRIP_H811) then
      FlagSet(FLAG_IS_TRIP_H811)
    end
  elseif gMapNum == 812 then
    if not FlagCheck(FLAG_IS_TRIP_H812) then
      FlagSet(FLAG_IS_TRIP_H812)
    end
  elseif gMapNum == 813 and not FlagCheck(FLAG_IS_TRIP_H813) then
    FlagSet(FLAG_IS_TRIP_H813)
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
  if gMapNum == 801 then
  end
end

function Update(elapsed_frame)
end

function OnCheckLocatorLift(gimmick_index, args)
end

function CheckMoveEndGimmickLift(gimmick_index, args)
  print("=============== CheckMoveEndGimmickLift =====================")
end

function OnTouchCollision(col_name)
  print("=============== OnTouchCollision =====================")
  print("========= col_name = ", col_name, " =========")
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  print("=============== OnDefeatedSymbolEnemy =====================")
  local is_fa = args.by_field_attack
  if is_fa == true then
  end
  if gMapNum == 801 then
  elseif gMapId == HAZAMA_H08 then
  end
end
