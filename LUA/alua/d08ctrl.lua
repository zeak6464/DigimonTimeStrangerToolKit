require("function_control")
DEFINE_FLAG("FLAG_MAIN_02_010")
DEFINE_FLAG("FLAG_MAIN_02_020")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""

function LoadRequest()
  print("===============LoadRequest=====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 801 then
  elseif gMapNum == 802 then
    LoadRailMove(gRailMoveFile)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 801 then
  elseif gMapNum == 802 then
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 802 and FlagCheck(FLAG_MAIN_02_010) and not FlagCheck(FLAG_MAIN_02_020) then
    DisableMenuInNowFrame()
    DisableAnalyzeAndFieldAttackOnlyThisFrame()
  end
end

function Update(elapsed_frame)
  if gMapNum == 801 then
  elseif gMapNum == 802 and FlagCheck(FLAG_MAIN_02_010) and not FlagCheck(FLAG_MAIN_02_020) then
    local operatedegrees = GetLeftAxisDegrees()
    local speed = GetLeftAxisPlayerMoveMaxSpeed() * GetLeftAxisPlayerMoveOperateRate()
    local rail_direction = true
    if IsPadTrigger(PAD_INPUT_L2) == false and IsPadTrigger(PAD_INPUT_R2) == false and operatedegrees ~= nil then
      if 0 <= operatedegrees and operatedegrees < 180 then
        rail_direction = true
      elseif 330 <= operatedegrees and operatedegrees < 360 then
      else
        rail_direction = false
      end
    end
    Player().LinkToRailMove("d0802_railmove", "rail_move_001")
    Player().SetRailMoveDirection(rail_direction)
    Player().SetRailMoveSpeed(speed)
    Player().SetRailMoveInDimension2d()
    Player().RailMoveGo()
  end
end

function EventStartCheckNpc(npc_index)
end

function EventEndCheckNpc(npc_index)
end
