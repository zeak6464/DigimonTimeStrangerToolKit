require("function_control")
EFFECT = "ef_f_dun_500_sp"
EFFECT_NUM = 0
OFFSET_MIN = 16
OFFSET_MAX = 48
gElvEffectPlayOffset = 10
gElvEffectPlayCount = 0
AMIMATION = "e001"

function LoadRequest()
  print("===============LoadRequest [d05elv_play_effect] =====================")
  Self().AttachEffectScript(EFFECT, false, EFFECT_NUM, false, false, true, false)
  Self().LoadMotion("e001")
end

function Initialize()
  print("===============Initialize [d05elv_play_effect] =====================")
  local drive_state = GetExternalVariable("drive_state")
  if drive_state == "nil" then
    SetExternalVariable("effect_state", "Initialize")
    SetExternalVariable("drive_state", "Initialize")
  end
end

function Update(elapsed_frame)
  local effect_state = GetExternalVariable("effect_state")
  local drive_state = GetExternalVariable("drive_state")
  local eval_frame = Self().GetMotionEvalFrame("e001")
  if drive_state == "start" then
    Self().Motion_PlayMotionAndSetting("e001", 0, 0, 0, 35, 1, false)
    SetExternalVariable("drive_state", "standby_close")
  elseif drive_state == "standby_close" then
    if 34 <= eval_frame then
      SetExternalVariable("drive_state", "moving")
    end
  elseif drive_state == "moving" then
    Self().Motion_PlayMotionAndSetting("e001", 10, 35, 35, 105, 1, true)
    SetExternalVariable("drive_state", "standby_arrive")
  elseif drive_state == "arrive" then
    Self().Motion_PlayMotionAndSetting("e001", 10, 105, 105, 140, 1, false)
    PlaySE(200010, 100)
    SetExternalVariable("drive_state", "standby_open")
  elseif drive_state == "standby_open" then
    if Self().IsPlayingMotion("e001") == false then
      SetExternalVariable("drive_state", "arrived")
    end
  elseif drive_state == "arrived" then
    Self().Motion_PlayMotion("", 0, false)
  end
  if effect_state == "play" then
    gElvEffectPlayCount = gElvEffectPlayCount + elapsed_frame
    if (drive_state == "moving" or drive_state == "standby_arrive") and 1 >= gElvEffectPlayCount % (8 + gElvEffectPlayOffset) then
      Self().StartEffectScript(EFFECT_NUM)
      gElvEffectPlayOffset = math.random(OFFSET_MIN, OFFSET_MAX)
      gElvEffectPlayCount = 0
    end
  elseif effect_state == "end" then
    gElvEffectPlayOffset = 10
    gElvEffectPlayCount = 0
    SetExternalVariable("effect_state", "Initialize")
  end
end
