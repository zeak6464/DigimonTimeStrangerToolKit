require("function_control")
DEFINE_FLAG("FLAG_MAIN_22_530")
DEFINE_FLAG("FLAG_MAIN_22_540")
DEFINE_FLAG("FLAG_MAIN_22_532")
DEFINE_FLAG("FLAG_MAIN_22_542")
DEFINE_FLAG("FLAG_MAIN_22_544")
DEFINE_FLAG("FLAG_MAIN_22_546")
RAIL_FILE = "t0403_railmove"
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
  if nani_state == "init" then
    Self().Physics_SetGravity(0)
    Self().LinkToRailMove(RAIL_FILE, RAIL)
    Self().Motion_PlayMotion("bn01", 15, true)
  end
  if FlagCheck(FLAG_MAIN_22_530) and nani_state ~= "end" then
    SetExternalVariable("nani_state", "move")
  end
  if FlagCheck(FLAG_MAIN_22_530) and not FlagCheck(FLAG_MAIN_22_532) then
    FlagSet(FLAG_MAIN_22_532)
    PlayVoiceFromName("vo_mpc375_Sadness_001")
  end
  if FlagCheck(FLAG_MAIN_22_540) and not FlagCheck(FLAG_MAIN_22_542) then
    FlagSet(FLAG_MAIN_22_542)
    PlayVoiceFromName("vo_mpc375_preparation_002")
  end
  if FlagCheck(FLAG_MAIN_22_544) and not FlagCheck(FLAG_MAIN_22_546) then
    FlagSet(FLAG_MAIN_22_546)
    PlayVoiceFromName("vo_mpc375_Frustrating_001")
  end
  if nani_state == "move" then
    Self().Motion_PlayMotion("br01", 15, true)
    Self().SetRailMoveInDimension3d()
    Self().Physics_SetGravity(0)
    Self().Physics_SetCollisionContactForNotHit()
    Self().SetRailMoveSpeed(4)
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
