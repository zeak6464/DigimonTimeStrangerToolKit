gGimText = "field_text"

function Prcs_d0101_AreaChangeEvent(anim)
  local obj = Obj:new(NPC, "M_burinpu_01")
  obj:Invisible()
  SetProhibitDigimonRide(true)
  SetPlayerRotationToLocator("gim_0001", 10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(25)
  PlayerObjectResetAim()
  PlaySE(200002, 100)
  Motion.Gimmick:Play("gim_0001", anim, false)
  se_slot = PlaySE(220023, 100)
  WaitFrame(35)
  Cam.Inst:Set(-0.8, 38.9, 220.1, -0.8, 38.5, 230, default, 55)
  Motion.Gimmick:Play("obj_0001", anim, false)
  Motion.Gimmick:Play("obj_0002", anim, false)
  if anim == "e001" then
  else
  end
  Motion.Gimmick:WaitFrame("obj_0002", anim, 0)
  StopSE(se_slot, 0)
  Quake_Start(0.1, 0, 40)
  PlaySE(202007, 100)
  WaitFrame(60)
  Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, 0, 0, -42.89)
  Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 180, 0)
  local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
  if Flg.Check("FLAG_MAIN_18_023") and Flg.Check("FLAG_MAIN_18_024") then
    SetFollowerCameraOperateRotation(0, rot, 0)
  end
  if Flg.Check("FLAG_MAIN_18_023", "FLAG_MAIN_18_024") then
    Cam.Inst:Set(0, 5.5, -13.5, 0, 10.8, -5.1, default, 0)
    Motion.Gimmick:Play("elv_0001", anim, false)
    PlaySE(404005, 100)
    WaitFrame(100)
    Cam.Inst:Set(-1.314, 1.897, -55.487, 0.859, 0.9439, -45.77, default, 0)
    WaitFrame(30)
    obj:CancelInvisible()
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    SetProhibitDigimonRide(false)
  else
    Cam.Inst:Set(0, 5.5, -13.5, 0, 10.8, -5.1, default, 0)
    Motion.Gimmick:Play("elv_0001", anim, false)
    PlaySE(404005, 100)
    WaitFrame(100)
    Cam.Inst:Clear(30)
    WaitFrame(30)
    obj:CancelInvisible()
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    SetProhibitDigimonRide(false)
  end
end

function Prcs_d0102_HideToHole(gim_id)
  local locator_name = "Initialize"
  local col_name = "Initilize"
  if gim_id == 300 then
    locator_name = "sp_0001"
    col_name = "wall_cl_0001"
    Cam.Inst:Set(-18.67, 2.05, 22.98, -22.16, 5.51, 31.69, DEFAULT_ANGLE, 0)
  elseif gim_id == 301 then
    locator_name = "sp_0002"
    col_name = "wall_cl_0002"
    Cam.Inst:Set(5, 4.51, 41.76, 2.64, 7.63, 32.56, DEFAULT_ANGLE, 0)
  elseif gim_id == 302 then
    locator_name = "sp_0003"
    col_name = "wall_cl_0003"
    Cam.Inst:Set(23.2, 7.91, 11.07, 29.84, 11.42, 17.71, DEFAULT_ANGLE, 0)
  elseif gim_id == 303 then
    locator_name = "sp_0004"
    col_name = "wall_cl_0004"
    Cam.Inst:Set(41.03, 10.43, -3.35, 32.12, 13.9, -0.41, DEFAULT_ANGLE, 0)
  elseif gim_id == 304 then
    locator_name = "sp_0005"
    col_name = "wall_cl_0005"
    Cam.Inst:Set(26.03, 11.19, -20.06, 35.14, 14.69, -17.87, DEFAULT_ANGLE, 0)
  end
  ColOff(col_name)
  SetPlayerStealthFromSymbolEnemy(true)
  Field_InvisibleFollowerAllPartyMember(0, 5, false)
  WaitFrame(3)
  Motion.Player:ChangeMoveAnimWithBlend("hide", 6, 2.5)
  WaitFrame(6)
  Field.MovePlayerToLocatorFrame(locator_name, 45)
  Fade.Out(0, Util.SecondFromFrame(12))
  WaitFrame(15)
  if gim_id == 300 then
    Cam.Inst:Set(-20.62, 2.29, 29.91, -18.66, 3.53, 20.19, DEFAULT_ANGLE, 0)
  elseif gim_id == 301 then
    Cam.Inst:Set(3.89, 4.96, 34.4, 5.53, 6.6, 44.15, DEFAULT_ANGLE, 0)
  elseif gim_id == 302 then
    Cam.Inst:Set(29.25, 8.25, 15.36, 20.78, 9.4, 10, DEFAULT_ANGLE, 0)
  elseif gim_id == 303 then
    Cam.Inst:Set(34.31, 10.34, -3.14, 44.29, 11.47, -2.62, DEFAULT_ANGLE, 0)
  elseif gim_id == 304 then
    Cam.Inst:Set(32.55, 10.83, -19.53, 22.62, 11.97, -19.58, DEFAULT_ANGLE, 0)
  end
  SetPlayerLocator(locator_name)
  ColOn(col_name)
  Fade.In(0, Util.SecondFromFrame(10))
  WaitFrame(10)
  Flg.Set("FLAG_GIMMICK_D10_070")
end

function Prcs_d0102_CanselHideToHole(gim_id)
  local locator_name = "Initialize"
  local col_name = "Initilize"
  if gim_id == 300 then
    locator_name = "gim_0001"
    col_name = "wall_cl_0001"
  elseif gim_id == 301 then
    locator_name = "gim_0002"
    col_name = "wall_cl_0002"
  elseif gim_id == 302 then
    locator_name = "gim_0003"
    col_name = "wall_cl_0003"
  elseif gim_id == 303 then
    locator_name = "gim_0004"
    col_name = "wall_cl_0004"
  elseif gim_id == 304 then
    locator_name = "gim_0005"
    col_name = "wall_cl_0005"
  end
  ColOff(col_name)
  Fade.Out(0, Util.SecondFromFrame(12))
  Field.MovePlayerToLocatorFrame(locator_name, 15)
  WaitFrame(10)
  SetPlayerLocator(locator_name)
  SetFollowerCameraOperateRotation(0, 10)
  Cam.Inst:Clear(0)
  WaitFrame(2.5)
  Fade.In(0, Util.SecondFromFrame(12))
  Motion.Player:ResetMoveAnimationWithBlend(10)
  WaitFrame(10)
  SetPlayerStealthFromSymbolEnemy(false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
  ColOn(col_name)
  Flg.Clear("FLAG_GIMMICK_D10_070")
end

function Prcs_d0103_StopGear(gim_name, obj_name)
  if gim_name == "gear_access_01" then
    Flg.Set("FLAG_GIMMICK_D01_060")
  elseif gim_name == "gear_access_02" then
    Flg.Set("FLAG_GIMMICK_D01_070")
  end
  PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
  local tlk = Tlk:new("d01", 1, true)
  tlk:StartTalk()
  tlk:Message("f_d0103_0110_0010")
  tlk:MessageClose()
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  PlaySE(200015, 100)
  if gim_name == "gear_access_01" then
    Cam.Inst:Set(7.95, -9.18, 68.28, 7.52, -11.57, 77.98, default, 30)
  elseif gim_name == "gear_access_02" then
    Cam.Inst:Set(-47.82, 19.44, -19.75, -42.79, 16.64, -11.58, default, 30)
  end
  WaitFrame(10)
  Motion.Gimmick:Play(obj_name, "e002", false)
  WaitFrame(100)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(5)
  PlaySE(200010, 100)
  Cam.Inst:Clear(0)
  Motion.Gimmick:Play(obj_name, "e003", false)
  WaitFrame(10)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  if gim_name == "gear_access_01" then
    tlk:Message("f_d0103_0110_0020")
    tlk:EndTalk()
  else
    tlk:EndTalk()
  end
end

function Prcs_d0103_StopElv0001Icon()
  if not Flg.Check("FLAG_GIMMICK_D01_411") then
    Flg.Set("FLAG_GIMMICK_D01_411")
  else
    Flg.Clear("FLAG_GIMMICK_D01_411")
  end
end

function Prcs_d0103_StopElv0002Icon()
  if not Flg.Check("FLAG_GIMMICK_D01_410") then
    Flg.Set("FLAG_GIMMICK_D01_410")
  else
    Flg.Clear("FLAG_GIMMICK_D01_410")
  end
end

function Prcs_d0103_StopElvMessage()
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0103_0070_0010")
  tlk:EndTalk()
end

function Prcs_d0107_IceSlide(elv_state, rotate_y)
  Field.ObjectLoadMotion(PLAYER, 1, "fg10_w01")
  Field.ObjectPlayMotion(PLAYER, 1, "fg10_w01", 15, true)
  Field.SetPlayerRotation(rotate_y, 0)
  Field.SetFollowerCameraOperateRotationY(rotate_y, 15, EASING_MODE_LINEAR)
  WaitFrame(20)
  Field.CancelPlayerAnywhereDigimonRide(false, true)
  SetControlScriptExternalVariable(elv_state, "slide_start")
  Field.SetProhibitPlayerMoveOperate(true)
  SetProhibitDigimonRide(true)
  Flg.Set("FLAG_GIMMICK_D01_190")
end

function Prcs_d0107_IceSlideEnd()
  Field.SetProhibitPlayerMoveOperate(false)
  Flg.Clear("FLAG_GIMMICK_D01_190")
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  SetProhibitDigimonRide(false)
end

function Prcs_d0107_ForceSlide(degree_y, wait_frame)
  Field.CancelPlayerAnywhereDigimonRide(false, true)
  speed = 10
  SetProhibitDigimonRide(true)
  Motion.Player:ChangeMoveAnim("slide", speed)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  MovePlayerFrame(degree_y, speed, wait_frame)
  WaitFrame(wait_frame + 1)
  Motion.Player:ChangeMoveAnim("slide_end", 3)
  MovePlayerFrame(degree_y, 3, 35)
  WaitFrame(35)
  Motion.Player:ResetMoveAnimWithBlend(30)
  MovePlayerFrame(degree_y, 3, 35)
  WaitFrame(30)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  SetProhibitDigimonRide(false)
end

function Prcs_d0107_StuckElvEvent_02()
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Cam.Inst:Set(-73.1, 4.9, 24.2, -80.6, 10.9, 26.8, default, 30)
  WaitFrame(30)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0050_0010")
  tlk:EndTalk()
  Cam.Inst:Clear(30)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  WaitFrame(30)
  SetControlScriptExternalVariable("lift_se_state", "broken")
end

function Prcs_d01_FireExtinguishing(gim_type, gim_name, scale)
  if scale == nil then
    scale = 1
  end
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local gim_index = GetIndex(gim_type, gim_name)
  local gim_pos = Field.ObjectGetPosition(gim_type, gim_index)
  local gim_rot = Field.ObjectGetRotationY(gim_type, gim_index)
  local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, gim_pos.x, gim_pos.z)
  SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 30)
  PlayerObjectResetAim()
  PlayerTurnToObject(gim_type, gim_name, true, false, 0, 0)
  WaitFrame(15)
  local tlk = Tlk:new("d01", 1, true)
  tlk:StartTalk()
  tlk:Message("f_d0102_0020_0010")
  tlk:MessageClose()
  Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
  WaitFrame(25)
  Fade_OutNoLoadingWithWait(FADE_WHITE, 10)
  PlaySE(202006, 100)
  Obj:new(gim_type, gim_name):Invisible()
  WaitFrame(15)
  Field.PlayEffectScript("ef_f_dun_135_fi", gim_pos.x, gim_pos.y, gim_pos.z, gim_rot, scale)
  FadeInWithWaitNotFlgCheck(FADE_WHITE, 10)
  WaitFrame(15)
  tlk:Message("f_d0102_0020_0020")
  tlk:EndTalk()
end

function Prcs_d01_FireExtinguishingNoMessage(gim_type, gim_name, scale)
  if scale == nil then
    scale = 1
  end
  local gim_index = GetIndex(gim_type, gim_name)
  local gim_pos = Field.ObjectGetPosition(gim_type, gim_index)
  local gim_rot = Field.ObjectGetRotationY(gim_type, gim_index)
  PlayerTurnToObject(gim_type, gim_name, true, false, 0, 0)
  WaitFrame(15)
  PlayerObjectResetAim()
  Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
  WaitFrame(25)
  Fade_OutNoLoadingWithWait(FADE_WHITE, 10)
  PlaySE(202006, 100)
  Obj:new(gim_type, gim_name):Invisible()
  WaitFrame(15)
  Field.PlayEffectScript("ef_f_dun_135_fi", gim_pos.x, gim_pos.y, gim_pos.z, gim_rot, scale)
  FadeInWithWaitNotFlgCheck(FADE_WHITE, 10)
  WaitFrame(15)
end

function Prcs_d01_FireExtinguishing_Not()
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0102_0030_0010")
  tlk:EndTalk()
end

function Prcs_d01_IceMelt(gim_type, gim_name, scale)
  if scale == nil then
    scale = 1
  end
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local gim_index = GetIndex(gim_type, gim_name)
  local gim_pos = Field.ObjectGetPosition(gim_type, gim_index)
  local gim_rot = Field.ObjectGetRotationY(gim_type, gim_index)
  local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, gim_pos.x, gim_pos.z)
  SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 30)
  PlayerObjectResetAim()
  PlayerTurnToObject(gim_type, gim_name, true, false, 0, 0)
  WaitFrame(15)
  local tlk = Tlk:new("d01", 1, true)
  tlk:StartTalk()
  tlk:Message("f_d0106_0030_0010")
  tlk:MessageClose()
  Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "fg07_m01", 10, 10)
  WaitFrame(25)
  Fade_OutNoLoadingWithWait(FADE_WHITE, 10)
  PlaySE(202005, 100)
  Obj:new(gim_type, gim_name):Invisible()
  WaitFrame(15)
  Field.PlayEffectScript("ef_f_dun_136_ic", gim_pos.x, gim_pos.y, gim_pos.z, gim_rot, scale)
  FadeInWithWaitNotFlgCheck(FADE_WHITE, 10)
  WaitFrame(15)
  tlk:Message("f_d0106_0030_0020")
  tlk:EndTalk()
end

function Prcs_d01_ElvStop(elv_name)
  local cam = false
  if elv_name == "elv_0004" then
    if not Flg.Check("FLAG_MAIN_18_041") then
      Cam.Inst:Set(-0.516, 8.6, 26.407, -1.141, 12.116, 35.748, default, 30)
      WaitFrame(30)
      cam = true
    else
      Cam.Inst:Set(2.209, -9.3, 17.552, 5.227, -6.514, 8.434, default, 30)
      WaitFrame(30)
      cam = true
    end
  end
  if elv_name == "elv_0001" then
    Cam.Inst:Set(104.913, 21.149, 61.447, 109.22, 26.059, 71.514, default, 30)
    WaitFrame(30)
    cam = true
  end
  if elv_name == "elv_0003" then
    Cam.Inst:Set(34.898, 43.449, -24.468, 46.982, 47.946, -27.521, default, 30)
    WaitFrame(30)
    cam = true
  end
  if elv_name == "elv_0005" then
    Cam.Inst:Set(-84.099, 24.724, 1.596, -83.417, 28.878, 10.667, default, 30)
    WaitFrame(30)
    cam = true
  end
  if elv_name == "elv_0002" then
    Cam.Inst:Set(60.244, 2.699, 94.911, 51.2, 6.182, 92.445, default, 30)
    WaitFrame(30)
    cam = true
  end
  if not Flg.Check("FLAG_FIELD_D0103_ELVSTOPTALK_FIRST") then
    local tlk = Tlk:new("d01", 1, false)
    tlk:StartTalk()
    Talk.NextNoVoice()
    tlk:Message("f_d0103_0090_0010")
    tlk:EndTalk()
    Flg.Set("FLAG_FIELD_D0103_ELVSTOPTALK_FIRST")
  else
    WaitFrame(45)
  end
  if cam == true then
    Cam.Inst:Clear(15)
  end
end
