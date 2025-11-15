require("function_control")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== gMapNum = ", gMapNum, " ======")
  if gMapNum == 1201 then
  elseif gMapNum == 1204 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== gMapNum = ", gMapNum, " ======")
  if gMapNum == 1201 then
  elseif gMapNum == 1204 then
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 1201 then
  elseif gMapNum == 1204 then
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
  if gMapNum == 1201 then
  elseif gMapNum == 1204 then
  end
end
