require("function_control")

function LoadRequest()
  print("===============LoadRequest [t3001_wait_mirei] =====================")
  LoadLocatorModel("t3001p")
  Self().LoadMotion("e003")
  Self().LoadMotion("fn01_01")
end

function Initialize()
  print("===============Initialize [t3001_wait_mirei] =====================")
  local state_name = Self().GetUniqueName() .. "_state"
  SetExternalVariable(state_name, "Initialize")
  SetExternalVariable("frame", 0)
end

function Update(elapsed_frame)
  local state_name = Self().GetUniqueName() .. "_state"
  local state = GetExternalVariable(state_name)
  local frame = GetExternalVariable("frame")
  local distance = GetDistanceToObject(SELF, "")
  local pos_x, pos_y, pos_z = Player().GetPosition()
  if frame < 750 then
    SetExternalVariable("frame", frame + 1)
  else
    Self().Motion_PlayMotion("e003", 5, false)
    if Self().IsPlayingMotion("e003") == false then
      Self().Motion_ResetPlayMotion(5)
      SetExternalVariable("frame", 0)
    end
  end
end
