require("function_control")
DEFINE_FLAG("FLAG_MAIN_22_530")
DEFINE_FLAG("FLAG_MAIN_22_540")
DEFINE_FLAG("FLAG_MAIN_22_531")
DEFINE_FLAG("FLAG_MAIN_22_541")
DEFINE_FLAG("FLAG_MAIN_22_544")
DEFINE_FLAG("FLAG_MAIN_22_545")
RAIL_FILE = "d0201_railmove"
RAIL = "rail_move_500"

function LoadRequest()
  CtrlLoadSelfMotion("bn01", "br01")
  LoadRailMove(RAIL_FILE)
end

function Initialize()
  SetExternalVariable("nani_state", "init")
end

function Update(elapsed_frame)
  local nani_state = GetExternalVariable("nani_state")
  local nani_voice = GetExternalVariable("nani_voice")
  if nani_state == "init" then
    Self().LinkToRailMove(RAIL_FILE, RAIL)
    Self().Motion_PlayMotion("bn01", 15, true)
  end
  if FlagCheck(FLAG_MAIN_22_530) and nani_state ~= "end" then
    SetExternalVariable("nani_state", "move")
  end
  if FlagCheck(FLAG_MAIN_22_530) and not FlagCheck(FLAG_MAIN_22_531) then
    FlagSet(FLAG_MAIN_22_531)
    PlayVoiceFromName("vo_mpc375_Frustrating_001")
  end
  if FlagCheck(FLAG_MAIN_22_540) and not FlagCheck(FLAG_MAIN_22_541) then
    FlagSet(FLAG_MAIN_22_541)
    PlayVoiceFromName("vo_mpc375_Sadness_001")
  end
  if FlagCheck(FLAG_MAIN_22_544) and not FlagCheck(FLAG_MAIN_22_545) then
    FlagSet(FLAG_MAIN_22_545)
    PlayVoiceFromName("vo_mpc375_preparation_002")
  end
  if nani_state == "move" then
    Self().Motion_PlayMotion("br01", 15, true)
    Self().SetRailMoveSpeed(7)
    Self().SetRailMoveDirection(true)
    Self().RailMoveGo()
    if Self().IsArrivalRailBothEnds() then
      SetExternalVariable("nani_state", "end_set")
    end
  end
  if nani_state == "end_set" then
    Self().Motion_PlayMotion("bn01", 10, true)
    Self().Invisible(20, false)
    PlaySE(200002, 100)
    SetExternalVariable("nani_state", "end")
  end
end
