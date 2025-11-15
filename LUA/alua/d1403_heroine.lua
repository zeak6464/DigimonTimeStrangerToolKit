require("function_control")
HEROINE_WAIT_FRAME = 60
HEROINE_WAIT_FRAME2 = 300
CURRENT_FRAME = 0
RAIL_FILE = "d1403_railmove"
RAIL = "rail_move_101"
DEFINE_FLAG("FLAG_MAIN_01_220")
DEFINE_FLAG("FLAG_MAIN_01_223")

function LoadRequest()
  CtrlLoadSelfMotion("fn01_01", "fr01_01", "e205")
  LoadRailMove(RAIL_FILE)
end

function Initialize()
  SetExternalVariable("heroine_state", "init")
end

function Update(elapsed_frame)
  local heroine_state = GetExternalVariable("heroine_state")
  if heroine_state == "init" then
    Self().Physics_SetGravity(0)
    Self().Motion_PlayMotion("fn01_01", 15, true)
    if FlagCheck(FLAG_MAIN_01_220) then
      SetExternalVariable("heroine_state", "wait")
    end
  end
  if heroine_state == "wait" then
    Self().Physics_SetGravity(0)
    Self().Motion_PlayMotion("fn01_01", 15, true)
    local rail_start_x, rail_start_y, rail_start_z = GetRailStartPos(RAIL_FILE, RAIL)
    Self().Move_SetPosition(rail_start_x, rail_start_y, rail_start_z)
    CURRENT_FRAME = CURRENT_FRAME + elapsed_frame
    if CURRENT_FRAME >= HEROINE_WAIT_FRAME then
      CURRENT_FRAME = 0
      SetExternalVariable("heroine_state", "wait2")
    end
  end
  if heroine_state == "wait2" then
    local player_x, _, player_z = Player().GetPosition()
    local heroine_x, _, heroine_z = Self().GetPosition()
    local y_degree = GetAngleToTarget2D(heroine_x, heroine_z, player_x, player_z)
    Self().Physics_SetGravity(0)
    Self().LinkToRailMove(RAIL_FILE, RAIL)
    Self().Move_SetRotationY(y_degree, 15)
    Self().Motion_PlayMotion("e205", 15, true)
    CURRENT_FRAME = CURRENT_FRAME + elapsed_frame
    if CURRENT_FRAME >= HEROINE_WAIT_FRAME2 then
      SetExternalVariable("heroine_state", "move")
    end
  end
  if heroine_state == "move" then
    Self().SetRailMoveSpeed(7)
    Self().Physics_SetGravity(0)
    Self().Physics_SetCollisionContactForNotHit()
    Self().SetRailMoveDirection(true)
    Self().RailMoveGo()
    if Self().IsArrivalRailBothEnds() then
      SetExternalVariable("heroine_state", "end")
      FlagSet(FLAG_MAIN_01_223)
    end
  end
  if heroine_state == "end" then
    Self().Motion_PlayMotion("fn01_01", 10, true)
    Self().InvisibleInNowFrame(0, 0, false)
  end
end
