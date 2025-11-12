require("function_control")
CURRENT_FRAME = 0

function LoadRequest()
  CtrlLoadSelfMotion("bn01", "br01")
end

function Initialize()
  SetExternalVariable("left_state", "init")
end

function Update(elapsed_frame)
  local left_state = GetExternalVariable("left_state")
  if left_state == "init" and FlagCheck(GET_FLAG("FLAG_MAIN_03_351")) then
    SetExternalVariable("left_state", "move")
  end
  if left_state == "move" then
    print("left move")
    Self().Move_Move2D(-90, 10)
    CURRENT_FRAME = CURRENT_FRAME + elapsed_frame
    if CURRENT_FRAME >= 30 then
      SetExternalVariable("left_state", "end")
    end
  end
  if left_state == "end" then
    Self().InvisibleInNowFrame(0, 0, false)
  end
end
