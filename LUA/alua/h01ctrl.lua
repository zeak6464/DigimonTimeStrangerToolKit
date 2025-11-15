require("function_control")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 101 then
    LoadLocatorModel(gPlanData)
  end
end

function FirstPeriodDeployLift()
  print("=============== FirstPeriodDeployLift =====================")
  local start_loc = GetLastPlayerSetLocator()
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 101 then
    PlayerSystem.PlayerAlwaysLoadMoveMotion("flow")
    SetExternalVariable("elv01_state", "Initialize")
  end
end

function PreparationBeforeReactionToField(elapsed_frame)
end

function Update(elapsed_frame)
end

function OnCheckLocatorLift(gimmick_index, args)
  print("=============== OnCheckLocatorLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
end

function CheckMoveStartGimmickLift(gimmick_index, args)
  print("=============== CheckMoveStartGimmickLift =====================")
  local elv_index, is_forward = gimmick_index, args.is_forward
  local elv_name = LocatorObject(elv_index).GetLocatorName()
end

function CheckMoveEndGimmickLift(gimmick_index, args)
  print("=============== CheckMoveEndGimmickLift =====================")
  elv_index, was_forward, is_carry_player = gimmick_index, args.was_forward, args.is_carrying_the_player
  local elv_name = LocatorObject(elv_index).GetLocatorName()
  print("====== elv_index = ", elv_index, " ====== elv_name = ", elv_name, " ======")
  print("====== was_forward = ", was_forward, " ====== is_carry_player =", is_carry_player, "======")
  local elv01_state = GetExternalVariable("elv01_state")
  if gMapNum == 101 and elv01_state == "moving" then
    SetExternalVariable("elv01_state", "end")
  end
end
