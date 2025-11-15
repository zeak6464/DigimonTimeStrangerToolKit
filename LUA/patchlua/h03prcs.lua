gGimText = "field_text"

function OpenRoad(col_name, obj_name, aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, is_long_dist)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Motion.Gimmick:PlayFinishedAnim(obj_name, "e001")
  ColOff(col_name)
  if not Flg.Check("FLAG_GIMMICK_H03_160") then
    FadeInWithWait(0, 30)
  else
    Flg.Clear("FLAG_GIMMICK_H03_160")
  end
  WaitFrame(15)
  if is_long_dist == true then
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 60)
    WaitFrame(65)
  else
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 30)
    WaitFrame(35)
  end
  Motion.Gimmick:Play(obj_name, "e002", false)
  WaitFrame(90)
  Cam.Inst:Clear(0)
  WaitFrame(10)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
end

function Prcs_DestroyEnemyByFA()
  if Flg.Check("FLAG_GIMMICK_H03_010") and not Flg.Check("FLAG_GIMMICK_H03_060") then
    Flg.Set("FLAG_GIMMICK_H03_060")
    OpenRoad("plan_cl_0001", "obj_0001", 26.3, 1.5, 40.9, 26.3, 5.1, 50.3, false)
    Field_InvisibleGimmick("gim_0001", 0, 0, false)
    MiniMapChange(2)
  end
  if Flg.Check("FLAG_GIMMICK_H03_020") and not Flg.Check("FLAG_GIMMICK_H03_070") then
    Flg.Set("FLAG_GIMMICK_H03_070")
    OpenRoad("plan_cl_0003", "obj_0003", 1.4, 2.8, -34, 1.4, 6.8, -24.8, false)
    Field_InvisibleGimmick("gim_0004", 0, 0, false)
    MiniMapChange(4)
  end
  if Flg.Check("FLAG_GIMMICK_H03_030") and not Flg.Check("FLAG_GIMMICK_H03_080") then
    Flg.Set("FLAG_GIMMICK_H03_080")
    OpenRoad("plan_cl_0002", "obj_0002", 26.3, 3.5, 1.2, 26.4, 7.1, 10.5, false)
    Field_InvisibleGimmick("gim_0003", 0, 0, false)
    MiniMapChange(3)
  end
  if Flg.Check("FLAG_GIMMICK_H03_040") and not Flg.Check("FLAG_GIMMICK_H03_090") then
    Flg.Set("FLAG_GIMMICK_H03_090")
    OpenRoad("plan_cl_0004", "obj_0004", -14.33, 3.794, 42.963, -14.267, 8.176, 51.951, false)
    Field_InvisibleGimmick("gim_0002", 0, 0, false)
    MiniMapChange(3)
  end
end

function M100_Event_085()
  WaitFrame(30)
  M100:Event_085()
end

function Prcs_H03RaceKeepOut()
  local beda_fe04 = Motion.Object:new(NPC, "npc_001", "fe04")
  local beda_bn01 = Motion.Object:new(NPC, "npc_001", "bn01")
  local tlk = Tlk:new("h03", 1)
  tlk:StartTalk()
  beda_fe04:Play(10, true)
  tlk:Message("f_h0310_0010_0010")
  local pc = Obj:new(PLAYER, "")
  local beda = Obj:new(NPC, "npc_001")
  local angle = GetAngleToTarget2D(pc.pos.x, pc.pos.z, beda.pos.x, beda.pos.z)
  pc:SetRotationYToObject(beda.type, beda.name, 30)
  SetFollowerCameraOperateRotation(0, angle - 10, 30)
  WaitFrame(30)
  tlk:Message("f_h0310_0010_0020")
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  beda_bn01:Play(10, true)
  local distance = 1.5
  local vec = GetUnitVector2D(beda.rot_y)
  local pc_pox_x, pc_pos_z = beda.pos.x + vec.x * distance, beda.pos.z + vec.z * distance
  pc:SetPos(pc_pox_x, beda.pos.y, pc_pos_z)
  angle = GetAngleToTarget2D(pc.nowpos.x, pc.nowpos.z, beda.pos.x, beda.pos.z)
  pc:SetRotationY(angle, 0)
  SetFollowerCameraOperateRotation(0, angle - 10)
  tlk:EndTalk()
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
end

function Prcs_H03PecmonShop(npc_name, shop_id)
  local beda_bv01 = Motion.Object:new(NPC, "npc_001", "bv01")
  local cam_npc = {
    5.98,
    30.84,
    46.51,
    4.51,
    31.29,
    46.55
  }
  local cam_shop = {
    6.24,
    30.91,
    46.05,
    4.82,
    31.32,
    46.44
  }
  local Purchased_flg = false
  Purchased_flg = PecmonShopStart(npc_name, shop_id, "ba02", "fq01", "fe01", "fe02", cam_npc, cam_shop, nil)
  if Purchased_flg == true and not Flg.Check("FLAG_IS_H03_OPEN_TUTRIAL") then
    Flg.Set("FLAG_IS_H03_OPEN_TUTRIAL")
    local tlk = Tlk:new("h03", 1)
    tlk:StartTalk()
    tlk:Message("f_h0310_0090_0010")
    beda_bv01:Play2Move(10, 10)
    Digitter.Send(4000601)
    tlk:EndTalk()
  else
  end
end

function Prcs_H03RaceExitKeepOut()
  if Flg.Check("FLAG_IS_H03_JOIN_RACE") then
    local penduram = Obj:new(FLD_OBJ_GIMMICK, "terminal")
    local pc = Obj:new(PLAYER, "")
    local beda = Obj:new(NPC, "npc_001")
    local beda_fe02 = Motion.Object:new(NPC, "npc_001", "fe02")
    local beda_bn01 = Motion.Object:new(NPC, "npc_001", "bn01")
    local angle = GetAngleToTarget2D(pc.pos.x, pc.pos.z, beda.pos.x, beda.pos.z)
    SetFollowerCameraOperateRotation(10, angle - 10, 20)
    local tlk = Tlk:new("h03", 1)
    tlk:StartTalk()
    beda_fe02:Play(10, true)
    tlk:Message("f_h0310_0050_0010")
    beda_bn01:Play(10, true)
    local angle = GetAngleToTarget2D(pc.pos.x, pc.pos.z, penduram.pos.x, penduram.pos.z)
    local vec = GetUnitVector2D(angle)
    local move_point_x, move_point_z = pc.pos.x + vec.x * 2, pc.pos.z + vec.z * 2
    SetFollowerCameraOperateRotation(0, angle - 10, 30)
    WaitFrame(30)
    pc:MoveToTarget2D(move_point_x, move_point_z, 2, 20)
    tlk:EndTalk()
  end
end

function Prcs_H03TouchMechanorimon()
  local tlk = Tlk:new("h03", 1)
  tlk:StartTalk()
  if not Flg.Check("FLAG_IS_H03_JOIN_RACE") then
    local pc = Obj:new(PLAYER, "")
    local beda = Obj:new(NPC, "npc_001")
    local angle = GetAngleToTarget2D(pc.pos.x, pc.pos.z, beda.pos.x, beda.pos.z)
    SetFollowerCameraOperateRotation(0, angle - 10, 30)
    WaitFrame(20)
  end
  tlk:Message("f_h0310_0060_0010")
  tlk:EndTalk()
end

function Prcs_H03RaceSet()
  print("##### Prcs_H03RaceSet #####")
  local set_pos = Obj:new(FLD_OBJ_GIMMICK, "set_pos")
  local rival_setpos_x = GetControlScriptExternalVariable("rival_setpos_x", "number")
  local rival_setpos_y = GetControlScriptExternalVariable("rival_setpos_y", "number")
  local rival_setpos_z = GetControlScriptExternalVariable("rival_setpos_z", "number")
  local state = "race_set"
  SetControlScriptExternalVariable("race_state", state)
  Field.SetProhibitPlayerMoveOperate(true)
  Field.PlayerScriptForceDefeatDigimonRideStartFromID(HAZAMA_RIDE_DIGIMON, true, "rail_move_001", 0)
  local pc = Obj:new(PLAYER, "")
  local rival = Obj:new(NPC, "rival")
  pc:SetPos(set_pos.pos.x, set_pos.pos.y, set_pos.pos.z)
  pc:SetRotationY(90, 0)
  MiniMapChange(MAP_LAYER_LOW)
  rival:SetPos(rival_setpos_x, rival_setpos_y, rival_setpos_z, false)
end

function Prcs_H03CountStart()
  print("##### Prcs_H03CountStart #####")
  state = "count"
  SetControlScriptExternalVariable("race_state", state)
end

function Prcs_H03RaceStart()
  print("##### Prcs_H03RaceStart #####")
  Field.SetProhibitPlayerMoveOperate(false)
end

function Prcs_H03RaceEnd(winner)
  Flg.Clear("FLAG_IS_H03_JOIN_RACE")
  if winner == "player" then
    Flg.Set("FLAG_IS_H03_CLEAR_RACE")
    if Field.IsPlayerScriptDigimonRiding() then
      print("##### Prcs_H03 ScriptRide now #####")
      Field.PlayerScriptDigimonRideEnd(true, "", 0)
    else
      print("##### Prcs_H03 NotScriptRide #####")
    end
    race_state = "init"
    SetControlScriptExternalVariable("race_state", race_state)
    Prcs_h03_StageClear()
  else
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    if Field.IsPlayerScriptDigimonRiding() then
      print("##### Prcs_H03 ScriptRide now #####")
      Field.PlayerScriptDigimonRideEnd(true, "", 0)
    else
      print("##### Prcs_H03 NotScriptRide #####")
    end
    local beda = Obj:new(NPC, "npc_001")
    local mecha = Obj:new(NPC, "npc_010")
    local pc = Obj:new(PLAYER, "")
    local beda_fq01 = Motion.Object:new(beda.type, beda.name, "fq01")
    local pc_bl01 = Motion.Object:new(pc.type, pc.name, "bl01")
    local pc_fn01_01 = Motion.Object:new(pc.type, pc.name, "fn01_01")
    local mecha_f02 = Motion.Object:new(mecha.type, mecha.name, "fq02")
    WaitFrame(30)
    Field.PlayerScriptDigimonRideEnd(false, "", 0)
    race_state = "setting"
    SetControlScriptExternalVariable("race_state", race_state)
    local vec = GetUnitVector2D(beda.rot_y)
    local pos_x, pos_z = beda.pos.x + vec.x * 4, beda.pos.z + vec.z * 4
    mecha:SetRotationY(beda.rot_y - 30, 0)
    pc:SetRotationY(beda.rot_y - 180, 0)
    pc:SetPos(pos_x, beda.pos.y, pos_z)
    Cam.Inst:Set(8.8, 30, 47.86, 0, 31.76, 43.47, default, 0)
    SetFollowerCameraOperateRotation(0, 0)
    beda_fq01:Play(10, true)
    mecha_f02:Play(10, true)
    pc_fn01_01:Play(10, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    local tlk = Tlk:new("h03", 1)
    tlk:StartTalk()
    tlk:Message("f_h0310_0070_0010")
    pc_bl01:Play(10, true)
    tlk:EndTalk(true)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Field.OpenGameOver()
  end
  FadeAllIn(FADE_BLACK, FADE_TIME)
end

function Prcs_h03_StageClear()
  print("##### Prcs_h03_StageClear #####")
  local is_clear_flg
  local hit_num = GetControlScriptExternalVariable("g_hit_num", "number")
  if gMapNum == 310 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H310")
    if hit_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H310") then
      Flg.Set("FLAG_IS_EXTRA_H310")
    end
    HazamaClearEvent(930, 2, is_clear_flg)
  elseif gMapNum == 311 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H311")
    if hit_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H311") then
      Flg.Set("FLAG_IS_EXTRA_H311")
    end
    HazamaClearEvent(931, 2, is_clear_flg)
  elseif gMapNum == 312 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H312")
    if hit_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H312") then
      Flg.Set("FLAG_IS_EXTRA_H312")
    end
    HazamaClearEvent(932, 2, is_clear_flg)
  elseif gMapNum == 313 then
    is_clear_flg = Flg.Check("FLAG_IS_CLEAR_H313")
    if hit_num == 0 and not Flg.Check("FLAG_IS_EXTRA_H313") then
      Flg.Set("FLAG_IS_EXTRA_H313")
    end
    HazamaClearEvent(933, 2, is_clear_flg)
  end
end

function Prcs_h03_VisitMessage(tlk)
  print("##### Prcs_h03_VisitMessage #####")
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
