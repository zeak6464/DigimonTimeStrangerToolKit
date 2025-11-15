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
  SetExternalVariable("effect_state", "Initialize")
  SetExternalVariable("animation_state", "Initialize")
end

function Update(elapsed_frame)
  local effect_state = GetExternalVariable("effect_state")
  local animation_state = GetExternalVariable("animation_state")
  if animation_state == "play" then
    Self().Motion_PlayMotion("e001", 0, false)
  elseif animation_state == "end" then
    Self().Motion_PlayMotion("", 0, false)
  end
  if effect_state == "play" then
    gElvEffectPlayCount = gElvEffectPlayCount + elapsed_frame
    if gElvEffectPlayCount % (8 + gElvEffectPlayOffset) <= 1 then
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
