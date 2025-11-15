gGimText = "field_text"

function Prcs_h04_RailMoveStart(gim_id, gim_loc)
  Field.CameraZoomFrame(0, 0, 20, 1)
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Motion.Player:ChangeMoveAnimWithBlend("flow", 15, 10)
  SetPlayerRotationByLocator("gim_00" .. string.format("%02d", gim_id), 10)
  SetControlScriptExternalVariable("effect_state", "play")
  SetControlScriptExternalVariable("gim_check_state", "false")
  WaitFrame(30)
  Field.InvisiblePlayer(0, 0, true)
  WaitFrame(7)
  if gim_id % 2 == 0 then
    SetControlScriptExternalVariable("rail_move_dir", "backward")
  else
    SetControlScriptExternalVariable("rail_move_dir", "forward")
  end
end

function Prcs_h04_RailMoveEnd()
  Field.CameraZoomUndo()
  Motion.Player:ResetMoveAnimWithBlend(15)
  WaitFrame(30)
  Field.CancelInvisiblePlayer(0, 0, false, true)
  WaitFrame(10)
  SetControlScriptExternalVariable("gim_check_state", "true")
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
end

function Prcs_h04_StageClear()
  print("##### Prcs_h04_StageClear #####")
  local fa_defeat = GetControlScriptExternalVariable("g_fa_defeat", "number")
  local is_clear_flg
  if gMapNum == 415 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H415")
    if 10 <= fa_defeat and not Flg.Check("FLAG_IS_EXTRA_H415") then
      Flg.Set("FLAG_IS_EXTRA_H415")
    end
    HazamaClearEvent(945, 4, is_clear_flg)
  elseif gMapNum == 416 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H416")
    if 10 <= fa_defeat and not Flg.Check("FLAG_IS_EXTRA_H416") then
      Flg.Set("FLAG_IS_EXTRA_H416")
    end
    HazamaClearEvent(946, 4, is_clear_flg)
  elseif gMapNum == 417 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H417")
    if 10 <= fa_defeat and not Flg.Check("FLAG_IS_EXTRA_H417") then
      Flg.Set("FLAG_IS_EXTRA_H417")
    end
    HazamaClearEvent(947, 4, is_clear_flg)
  elseif gMapNum == 418 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H418")
    if 10 <= fa_defeat and not Flg.Check("FLAG_IS_EXTRA_H418") then
      Flg.Set("FLAG_IS_EXTRA_H418")
    end
    HazamaClearEvent(948, 4, is_clear_flg)
  end
end

function Prcs_h04_VisitMessage(tlk)
  print("##### Prcs_h04_VisitMessage #####")
  tlk:Message("g_event_0020_0410")
  local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
  gim_terminal_e001_online:Play(0, true)
  WaitFrame(1)
  gim_terminal_e001_online:Reset(10)
  WaitFrame(1)
  gim_terminal_e001_online:Play(0, true)
  WaitFrame(1)
  gim_terminal_e001_online:Reset(10)
  WaitFrame(1)
  gim_terminal_e001_online:Play(0, true)
  WaitFrame(10)
  gim_terminal_e001_online:Reset(10)
  tlk:Message("g_event_0020_0420")
  tlk:Message("g_event_0020_0430")
end

function Prcs_h04_BossBattle()
  print("=============== Prcs_h04_BossBattle =====================")
  local player_index = GetIndex(PLAYER, "")
  local boss_pos = Field.ObjectGetPosition(FLD_OBJ_SYMBOL_ENEMY, GetIndex(FLD_OBJ_SYMBOL_ENEMY, "boss"))
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  print("##### INVISINVISIBLE DEGIMON #####")
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 20, false)
  Flg.Set("FLAG_IS_HAZAMA_BOSS_CALL")
  Field.ObjectSetPos(FLD_OBJ_PLAYER, player_index, -1.079, 21.999, -78.04)
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  print("##### BOSS POS X =", boss_pos.x, " Z = ", boss_pos.z, "PLAYER POS X =", player_pos.x, " Z = ", player_pos.z, " #####")
  local rotate = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, boss_pos.x, boss_pos.z)
  Field.SetPlayerRotation(rotate, 0)
  print("##### !!! PLAYER_Y !!!", rotate, " #####")
  Cam.Inst:Set(0.131092, 24.891962, -85.484398, -0.402585, 22.80319, -76.489136, default, 1)
  WaitFrame(3)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  print("##### !!! BOSS appearance !!! #####")
  WaitFrame(15)
  local player_ba01 = Motion.Object:new(PLAYER, "", "ba01")
  local player_fa01 = Motion.Object:new(PLAYER, "", "fa01")
  local boss_fe04 = Motion.Object:new(FLD_OBJ_SYMBOL_ENEMY, "boss", "fe04")
  boss_fe04:Play(5, false)
  WaitFrame(30)
  player_fa01:Play(5, false)
  Cam.Inst:Set(0.131092, 24.891962, -87.300003, -0.402585, 23.80319, -78.27655, default, 20)
  PostEffect.SetZoomBlur(true)
  PostEffect.SetOvrZoomBlur(0.5, 0.5, 2, 10, 10, 20, 30)
  PostEffect.RegistOvrZoomBlur(0, 40, false, 0, false)
  WaitFrame(30)
  if gMapNum == 415 then
    EncountFromField_PlaySound(5041507, 20471, true)
  elseif gMapNum == 416 then
    EncountFromField_PlaySound(5041604, 20471, true)
  elseif gMapNum == 417 then
    EncountFromField_PlaySound(5041704, 20471, true)
  elseif gMapNum == 418 then
    EncountFromField_PlaySound(5041805, 20471, true)
  end
  Enemys.AllDespawn(false, FOREVER, 0)
  Cam.Follower:ResetFromRotation(0)
  Cam.Inst:Clear(0)
  PostEffect.SetZoomBlur(false)
  print("##### VISINVISIBLE DEGIMON #####")
  Field.CancelInvisibleFollowerAllPartyMember(0, 0, false, true)
  print("##### !!! BOSS BATTLE END !!! #####")
end

function Prcs_h04_BossBattle2()
  print("=============== Prcs_h04_BossBattle2 =====================")
  local player_index = GetIndex(PLAYER, "")
  local boss_pos = Field.ObjectGetPosition(FLD_OBJ_SYMBOL_ENEMY, GetIndex(FLD_OBJ_SYMBOL_ENEMY, "boss"))
  Flg.Set("FLAG_IS_HAZAMA_BOSS_CALL")
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  print("##### BOSS POS X =", boss_pos.x, " Z = ", boss_pos.z, "PLAYER POS X =", player_pos.x, " Z = ", player_pos.z, " #####")
  local rotate = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, boss_pos.x, boss_pos.z)
  Field.SetPlayerRotation(rotate, 0)
  print("##### !!! PLAYER_Y !!!", rotate, " #####")
  Cam.Inst:Set(-0.5594, 20.489, 10.112, 2.6171, 18.6833, 19.421, default, 30)
  WaitFrame(3)
  print("##### !!! BOSS appearance !!! #####")
  WaitFrame(15)
  local player_fa01 = Motion.Object:new(PLAYER, "", "fa01")
  local boss_fe04 = Motion.Object:new(FLD_OBJ_SYMBOL_ENEMY, "boss", "fe04")
  local boss_fe02 = Motion.Object:new(FLD_OBJ_SYMBOL_ENEMY, "boss", "fe02")
  player_fa01:Play(5, false)
  WaitFrame(30)
  if gMapNum == 423 then
    Cam.Inst:Set(0.1404, 21.342, 1.8955, 3.3285, 21.7431, 11.237, default, 20)
  else
    Cam.Inst:Set(0.1404, 23.342, 1.8955, 3.3285, 21.7431, 11.237, default, 20)
  end
  WaitFrame(30)
  if gMapNum == 423 then
    boss_fe02:Play(5, false)
  else
    boss_fe04:Play(5, false)
  end
  PostEffect.SetZoomBlur(true)
  PostEffect.SetOvrZoomBlur(0.5, 0.5, 2, 10, 10, 20, 30)
  PostEffect.RegistOvrZoomBlur(0, 40, false, 0, false)
  WaitFrame(30)
  if gMapNum == 420 then
    EncountFromField_PlaySound(29001630, 20471, true)
  elseif gMapNum == 421 then
    EncountFromField_PlaySound(29001640, 20471, true)
  elseif gMapNum == 422 then
    EncountFromField_PlaySound(29001650, 20471, true)
  elseif gMapNum == 423 then
    EncountFromField_PlaySound(29001660, 20471, true)
  end
  Cam.Follower:ResetFromRotation(0)
  Cam.Inst:Clear(0)
  PostEffect.SetZoomBlur(false)
  print("##### !!! BOSS BATTLE END !!! #####")
end

function Prcs_h04_GameOver(symbol_index)
  print("##### Prcs_h05_GameOver #####")
  print("##### symbolindex =", symbol_index, " #####")
  print("##### INVISINVISIBLE DEGIMON #####")
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 10, false)
  local player = Obj:new(PLAYER, "")
  local player_down = Motion.Object:new(PLAYER, "", "bl01")
  WaitFrame(30)
  player_down:Play(15, false)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, 60)
  WaitFrame(60)
  Field.OpenGameOver()
  Cam.Inst:Clear(0)
  print("##### VISINVISIBLE DEGIMON #####")
  Field.CancelInvisibleFollowerAllPartyMember(0, 0, false, true)
end

function Prcs_h04_StartRideFly(start_loc, move_loc, gim_loc, cl_name)
  Field.MovePlayerToLocatorFrame(start_loc, 10)
  WaitFrame(10)
  SetPlayerRotationByLocator(start_loc, 10)
  StartRideFly(true, gim_loc, 10)
  require("r01_010")
  WaitFrame(15)
  ColOff(cl_name)
  r01_010(move_loc)
  ColOn(cl_name)
end

function Prcs_h04_EndRideFly(move_loc, cl_name)
  require("r01_020")
  Flg.Clear("FLAG_IS_FLIGHT_RIDE")
  ColOff(cl_name)
  r01_020(move_loc)
  ColOn(cl_name)
  Field.FollowerWarp()
  EndRide(true, move_loc, 30)
end
