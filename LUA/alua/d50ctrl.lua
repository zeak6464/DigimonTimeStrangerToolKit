require("function_control")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
DEFINE_FLAG("FLAG_GIMMICK_D50_010")

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
  elseif gMapNum == 5005 then
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
  elseif gMapNum == 5005 then
  end
end

function Update(elapsed_frame)
  local player_state = GetExternalVariable("player_state")
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
  elseif gMapNum == 5005 then
  end
end
