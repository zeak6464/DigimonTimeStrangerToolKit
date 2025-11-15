require("function_control")
DEFINE_FLAG("FLAG_MAIN_22_530")
DEFINE_FLAG("FLAG_MAIN_22_540")
DEFINE_FLAG("FLAG_MAIN_22_532")
DEFINE_FLAG("FLAG_MAIN_22_542")
DEFINE_FLAG("FLAG_MAIN_22_533")
DEFINE_FLAG("FLAG_MAIN_22_543")
DEFINE_FLAG("FLAG_MAIN_22_546")
DEFINE_FLAG("FLAG_MAIN_22_547")
RAIL_FILE = "t0401_railmove"
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
  if FlagCheck(FLAG_MAIN_22_532) and not FlagCheck(FLAG_MAIN_22_533) then
    FlagSet(FLAG_MAIN_22_533)
    PlayVoiceFromName("vo_mpc375_preparation_002")
  end
  if FlagCheck(FLAG_MAIN_22_542) and not FlagCheck(FLAG_MAIN_22_543) then
    FlagSet(FLAG_MAIN_22_543)
    PlayVoiceFromName("vo_mpc375_Frustrating_001")
  end
  if FlagCheck(FLAG_MAIN_22_546) and not FlagCheck(FLAG_MAIN_22_547) then
    FlagSet(FLAG_MAIN_22_547)
    PlayVoiceFromName("vo_mpc375_Sadness_001")
  end
  if nani_state == "move" then
    Self().Motion_PlayMotion("br01", 15, true)
    Self().SetRailMoveInDimension3d()
    Self().Physics_SetGravity(0)
    Self().Physics_SetCollisionContactForNotHit()
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
