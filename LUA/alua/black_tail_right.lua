require("function_control")
CURRENT_FRAME = 0

function LoadRequest()
  CtrlLoadSelfMotion("bn01", "br01")
end

function Initialize()
  SetExternalVariable("right_state", "init")
end

function Update(elapsed_frame)
  local right_state = GetExternalVariable("right_state")
  if right_state == "init" and FlagCheck(GET_FLAG("FLAG_MAIN_03_351")) then
    SetExternalVariable("right_state", "move")
  end
  if right_state == "move" then
    print("right move")
    Self().Move_Move2D(90, 10)
    CURRENT_FRAME = CURRENT_FRAME + elapsed_frame
    if CURRENT_FRAME >= 30 then
      SetExternalVariable("right_state", "end")
    end
  end
  if right_state == "end" then
    Self().InvisibleInNowFrame(0, 0, false)
  end
end
