require("function_control")
MOTION_1 = "f000"
MOTION_2 = "fn01"
MOTION_3 = "f001"
BLEND_FRAME = 30
WAIT_ARRIVE = 300
WAIT_TAKEOFF = 300
INVISIBLE_FRAME = 30

function LoadRequest()
  print("===============LoadRequest [mob_19_takeoff_1] =====================")
  Self().LoadMotion(MOTION_1)
  Self().LoadMotion(MOTION_2)
  Self().LoadMotion(MOTION_3)
end

function Initialize()
  print("===============Initialize [mob_19_takeoff_1] =====================")
  SetExternalVariable("state", "Initialize")
end

function Update(elapsed_frame)
  self_state = GetExternalVariable("state")
  distance = GetDistanceToObject(SELF, "")
  if distance <= 5 then
    SetExternalVariable("state", "move")
    if GetExternalVariable("state") == "move" then
      Self().Motion_PlayMotion("f001", 0, false)
      MotionFrame = Self().GetMotionEvalFrame("f001")
      Self().Invisible(80, false)
    end
  end
end

function EventStartCheckNpc(npc_index)
end

function EventEndCheckNpc(npc_index)
end
