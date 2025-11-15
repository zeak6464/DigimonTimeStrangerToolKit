require("function_control")
RAIL_FILE = "d0201_railmove"
RAIL = "rail_move_33"
DEFINE_FLAG("FLAG_MAIN_13_147")
DEFINE_FLAG("FLAG_MAIN_13_148")

function LoadRequest()
  CtrlLoadSelfMotion("bn01", "br01")
  LoadRailMove(RAIL_FILE)
end

function Initialize()
  SetExternalVariable("chimaera_state", "init")
end

function Update(elapsed_frame)
  local chimaera_state = GetExternalVariable("chimaera_state")
  local x, y, z = GetRailStartPos(RAIL_FILE, RAIL)
  if chimaera_state == "init" then
    Self().Move_SetPosition(x, y, z)
    Self().LinkToRailMove(RAIL_FILE, RAIL)
    Self().Motion_PlayMotion("bn01", 15, true)
    Self().Physics_SetGravity(0)
  end
  if chimaera_state == "init" and FlagCheck(FLAG_MAIN_13_147) then
    SetExternalVariable("chimaera_state", "move")
  end
  if chimaera_state == "move" then
    Self().Motion_PlayMotion("br01", 15, true)
    Self().SetRailMoveSpeed(7)
    Self().Physics_SetGravity(0)
    Self().Physics_SetCollisionContactForNotHit()
    Self().SetRailMoveDirection(true)
    Self().RailMoveGo()
    if Self().IsArrivalRailBothEnds() then
      SetExternalVariable("chimaera_state", "end")
    end
  end
  if chimaera_state == "end" then
    Self().Physics_ResetCollisionContact()
    Self().Physics_SetGravity(0)
    Self().Motion_PlayMotion("bn01", 10, true)
    if not IsRunningEventScript() and not FlagCheck(FLAG_MAIN_13_148) then
      CallEventScriptFunction("M350_Event_058_E")
    end
  end
end
