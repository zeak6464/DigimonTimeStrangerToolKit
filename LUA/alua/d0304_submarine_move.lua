require("function_control")
CURRENT_FRAME = 0

function LoadRequest()
  CtrlLoadSelfMotion("bn01", "br01")
end

function Initialize()
  SetExternalVariable("move_state", "init")
end

function Update(elapsed_frame)
  local move_state = GetExternalVariable("move_state")
  Self().Physics_SetGravity(0)
  Self().Physics_SetCollisionContactForNotHit()
  if move_state == "init" then
    print("init")
    if FlagCheck(GET_FLAG("FLAG_MAIN_09_034")) then
      SetExternalVariable("move_state", "move_right")
    end
  end
  if move_state == "move_right" then
    print("right move")
    Self().Move_Move2DToTarget(-88.394, 55.049, 20)
    CURRENT_FRAME = CURRENT_FRAME + 1
    if CURRENT_FRAME >= 100 then
      SetExternalVariable("move_state", "wait")
    end
  end
  if move_state == "wait" then
    print("wait")
    CURRENT_FRAME = 0
    if FlagCheck(GET_FLAG("FLAG_MAIN_09_035")) then
      SetExternalVariable("move_state", "move_left")
    end
  end
  if move_state == "move_left" then
    print("right move")
    Self().Move_Move2DToTarget(-87.928, 68.409, 20)
    CURRENT_FRAME = CURRENT_FRAME + 1
    if CURRENT_FRAME >= 40 then
      SetExternalVariable("move_state", "turn")
    end
  end
  if move_state == "turn" then
    local sub_x, _, sub_z = Self().GetPosition()
    local pc_x, _, pc_z = Player().GetPosition()
    local y_degree = GetAngleToTarget2D(sub_x, sub_z, pc_x, pc_z)
    Self().Move_SetRotationY(y_degree, 20)
    local now_y_rot = Self().GetRotationY()
    if math.floor(y_degree) == math.floor(now_y_rot) then
      SetExternalVariable("move_state", "end")
    end
  end
end
