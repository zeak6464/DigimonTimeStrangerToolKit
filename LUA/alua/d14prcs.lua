gGimText = "field_text"

function Prcs_d1401_ElvEvent()
  if not Flg.Check("FLAG_MAIN_01_185") then
    Cam.Inst:Set(59.18, 2.01, -23.71, 50.84, 2.69, -18.24, default, 30)
    WaitFrame(30)
    Cam.Inst:Clear(30)
  end
end

function Prcs_d1401_ElvGim(gim_loc)
  Prcs_d1401_GetOnElv_Fade("change_0001", "d", 1403, "start_02")
end

function Prcs_d1401_GetOnElv_Fade(gim_loc, prifix, map_num, locator)
  PlayerTurnToObject(FLD_OBJ_LOCATOR, "gim_0001", true, false, 0, 0)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  PlaySE(200025, 100)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Motion.Gimmick:Play(gim_loc, "e001", false)
  PlaySE(200013, 100)
  WaitFrame(15)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  Motion.Gimmick:PlayFinishedAnim(gim_loc, "e001")
  Obj:new(PLAYER, ""):SetPos(56.95, 1, -21.62, true)
  Obj:new(PLAYER, ""):SetRotationY(270, 0)
  if Common.IsExistGuest(10012) then
    Obj:new(NPC, "npc_elv0001"):CancelInvisible()
  end
  if Flg.Check("FLAG_MAIN_01_170", "FLAG_MAIN_01_180") then
    SetControlScriptExternalVariable("heroine_elv_state", "move_wait")
  end
  Cam.Inst:Set(60.48, 1.25, -20.28, 50.96, 3.41, -22.43, default, 0)
  PlayerObjectResetAim()
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  Motion.Gimmick:Play(gim_loc, "e002", false)
  PlaySE(200011, 100)
  WaitFrame(30)
  local slot_num = Sound.PlaySE(200012, 100)
  Work.Set(99, slot_num)
  Flg.Set("FLAG_GIMMICK_D14_370")
  Fade_OutNoLoadingWithWait(FADE_BLACK, 30)
  if not Flg.Check("FLAG_MAIN_01_210") then
    MapChangeWithTimeTravel(prifix, map_num, locator, AXIS_ORIGINAL, "X2028_daft_21", EVENING)
  else
    MapChange(prifix, map_num, locator, false, 0, 30)
  end
end

function Prcs_d1402_ElvGim(gim_loc)
end

function Prcs_d1402_CheckSwitchBoard()
end

function Prcs_d1402_TurnOnSwitchBoard()
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  Field_InvisibleFollowerAllGuest(0, 30, false)
  WaitFrame(10)
  Cam.Inst:Set(-42.01, -4.404, -21.93, -32.31, -4.87, -24.334, default, 30)
  local index = GetIndex(FLD_OBJ_LOCATOR, "sp_0004")
  WaitFrame(30)
  AttachAndStartEffectScript(FLD_OBJ_LOCATOR, index, "ef_b_hit_140_thunder", false, 1, false, false, false, false)
  WaitFrame(45)
  Motion.Gimmick:PlayFinishedAnim("gim_0003", "")
  PlaySE(200014, 100)
  Quake_Start(0.02, 0, 30)
  WaitFrame(30)
  local player = Obj:new(PLAYER, "")
  player:SetPos(-31.73, -6, -23.838, false)
  player:SetRotationY(90, 0)
  Cam.Inst:Set(4, 2, 0, -2, 2.5, 0, DEFAULT_ANGLE, 0)
  WaitFrame(10)
  Motion.Gimmick:Play("obj_0001", "", false)
  WaitFrame(60)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, false)
end

function Prcs_d1402_GetOnElv(gim_loc, prifix, map_num, locator)
  PlayerObjectResetAim()
  Cam.Inst:Set(0.48, 1.76, -1.26, -1.16, 2.26, -4.26, default, 30)
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 10, false)
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Field.MovePlayerToLocatorFrame("sp_0002", 45)
  SetPlayerRotationByLocator("sp_0003", 15)
  Motion.Gimmick:Play(gim_loc, "e001", false)
  PlaySE(200013, 100)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  if Flg.Check("FLAG_MAIN_01_170", "FLAG_MAIN_01_180") then
    SetControlScriptExternalVariable("heroine_elv_state", "move_wait")
  end
  WaitFrame(30)
  Field.MovePlayerToLocatorFrame("sp_0003", 45)
  Motion.Gimmick:WaitFrame(gim_loc, "e001", 0)
  Motion.Gimmick:Play(gim_loc, "e002", false)
  PlaySE(200011, 100)
  WaitFrame(30)
  local slot_num = Sound.PlaySE(200012, 100)
  Work.Set(99, slot_num)
  Flg.Set("FLAG_GIMMICK_D14_370")
  MapChange(prifix, map_num, locator, true, 0, 30)
end

function Prcs_d1402_GetOnElv_Fade(gim_loc, prifix, map_num, locator)
  PlayerCheckGimmick("gim_0002", 15, "fg07_m01", 10, false)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Motion.Gimmick:Play(gim_loc, "e001", false)
  PlaySE(200013, 100)
  WaitFrame(15)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  Motion.Gimmick:PlayFinishedAnim(gim_loc, "e001")
  SetPlayerLocator("sp_0005")
  if Common.IsExistGuest(10012) then
    Obj:new(NPC, "npc_elv0001"):CancelInvisible()
  end
  if Flg.Check("FLAG_MAIN_01_170", "FLAG_MAIN_01_180") then
    SetControlScriptExternalVariable("heroine_elv_state", "move_wait")
  end
  Cam.Inst:Set(0.48, 1.76, -1.26, -1.16, 2.26, -4.26, default, 0)
  PlayerObjectResetAim()
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  Motion.Gimmick:Play(gim_loc, "e002", false)
  PlaySE(200011, 100)
  WaitFrame(30)
  local slot_num = Sound.PlaySE(200012, 100)
  Work.Set(99, slot_num)
  Flg.Set("FLAG_GIMMICK_D14_370")
  Fade_OutNoLoadingWithWait(FADE_BLACK, 30)
  MapChangeWithTimeTravel(prifix, map_num, locator, AXIS_ORIGINAL, "X2028_daft_21", EVENING)
end

function Prcs_d1403_FindHeroineEvent()
  Cam.Inst:Set(-13.4, 1.2, 10.7, -3.5, 2, 9.6, default, 60)
  WaitFrame(120)
  SetPlayerLocator("sp_0001")
  SetControlScriptExternalVariable("test01_Run_state", "move_start_pos")
  Flg.Set("AREA_OPEN_DEBUG")
  Cam.Inst:Clear(60)
end

function Prcs_d1403_ElvGim(gim_loc)
  Prcs_d1403_GetOnElv_Fade("change_0001", "d", 1401, "start_02")
end

function Prcs_d1403_GetOnElv(gim_loc, prifix, map_num, locator)
  PlayerObjectResetAim()
  Cam.Inst:Set(0.48, 1.76, -1.26, -1.16, 2.26, -4.26, default, 30)
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 10, false)
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Field.MovePlayerToLocatorFrame("sp_0002", 45)
  SetPlayerRotationByLocator("sp_0003", 15)
  Motion.Gimmick:Play(gim_loc, "e001", false)
  PlaySE(200013, 100)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  if Flg.Check("FLAG_MAIN_01_170", "FLAG_MAIN_01_180") then
    SetControlScriptExternalVariable("heroine_elv_state", "move_wait")
  end
  WaitFrame(30)
  Field.MovePlayerToLocatorFrame("sp_0003", 45)
  Motion.Gimmick:WaitFrame(gim_loc, "e001", 0)
  Motion.Gimmick:Play(gim_loc, "e002", false)
  PlaySE(200011, 100)
  WaitFrame(30)
  local slot_num = Sound.PlaySE(200012, 100)
  Work.Set(99, slot_num)
  Flg.Set("FLAG_GIMMICK_D14_370")
  MapChange(prifix, map_num, locator, true, 0, 30)
end

function Prcs_d1403_GetOnElv_Fade(gim_loc, prifix, map_num, locator)
  PlayerTurnToObject(FLD_OBJ_LOCATOR, "gim_0002", true, false, 0, 0)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  PlaySE(200025, 100)
  WaitFrame(30)
  ColOff("wall_cl_1000")
  Obj:new(OGIM, "elv_col01"):Invisible()
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  Motion.Gimmick:Play(gim_loc, "e001", false)
  PlaySE(200013, 100)
  WaitFrame(15)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Motion.Gimmick:PlayFinishedAnim(gim_loc, "e001")
  WaitFrame(1)
  Obj:new(PLAYER, ""):SetPos(4.829, 0, -0, true)
  Obj:new(PLAYER, ""):SetRotationY(270, 0)
  if Common.IsExistGuest(10012) then
    Obj:new(NPC, "npc_elv0001"):CancelInvisible()
  end
  if Flg.Check("FLAG_MAIN_01_170", "FLAG_MAIN_01_180") then
    SetControlScriptExternalVariable("heroine_elv_state", "move_wait")
  end
  Cam.Inst:Set(9.046, 0.327, 1.759, -0.342, 2.383, -1, default, 0)
  PlayerObjectResetAim()
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  Motion.Gimmick:Play(gim_loc, "e002", false)
  PlaySE(200011, 100)
  WaitFrame(30)
  local slot_num = Sound.PlaySE(200012, 100)
  Work.Set(99, slot_num)
  Flg.Set("FLAG_GIMMICK_D14_370")
  MapChange(prifix, map_num, locator, true, 0, 30)
end

function Prcs_d1403_RideFall()
  if not Flg.Check("FLAG_MAIN_01_230") then
    Cam.Inst:Set(-78.088, 2.4, -2.231, -68.323, 4.102, -3.554, default, 30)
    WaitFrame(30)
    Field_Talk_Start(gGimText, 1)
    Message("g_d1403_0010_0010")
    Field_Talk_End()
    Cam.Inst:Clear(30)
  else
    PlayerObjectResetAim()
    M020:Event_310()
    if Flg.Check("FLAG_MAIN_01_225") then
      local prefix, map_num, locator = "", 0, ""
      prefix, map_num, locator = "d", 1405, "start_00"
      Sound.PlayBGM(708, 0)
      MapChange(prefix, map_num, locator, false, 0, 0)
    end
  end
end

function Prcs_d1404_ElvGim(gim_loc)
  Field_Talk_Start(gGimText, 1)
  Message(1140100010)
  MessageClose()
  MessageTalkSel(4, 1140400000)
  local result = Talk.GetResultSelectedNum()
  Field_Talk_End()
  if result == RESULT_TALK00 then
    Prcs_d14_GetOnElv(gim_loc, "d", 1403, "start_02")
  elseif result == RESULT_TALK01 then
    Prcs_d14_GetOnElv(gim_loc, "d", 1401, "start_00")
  elseif result == RESULT_TALK02 then
    Prcs_d14_GetOnElv(gim_loc, "d", 1402, "start_01")
  elseif result == RESULT_TALK03 then
  end
end

function Prcs_d1405_BreakRubble2()
  local index = GetIndex(FLD_OBJ_LOCATOR, "fa_0005")
  AttachAndStartEffectScript(FLD_OBJ_LOCATOR, index, "ef_f_com_300_sm", false, 1, false, false, false, false)
  Motion.Gimmick:Play("fa_0005", "e002", false)
  ColOff("wall_cl_2004")
  SetEnableGimmickCheck("fa_0005", false)
  PlaySE(202001, 100)
  WaitFrame(15)
  PlaySE(202007, 100)
  Quake_Start(0.05, 0, 60)
  Flg.Set("FLAG_GIMMICK_D14_320")
  WaitFrame(30)
  Obj:new(FLD_OBJ_LOCATOR, "fa_0005"):Invisible()
  Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):CancelInvisible()
  Motion.Gimmick:PlayFinishedAnim("obj_0002", "e002")
end

function Prcs_d1405_BreakRubble1()
  local index = GetIndex(FLD_OBJ_LOCATOR, "fa_0005")
  AttachAndStartEffectScript(FLD_OBJ_LOCATOR, index, "ef_f_com_300_sm", false, 1, false, false, false, false)
  Motion.Gimmick:Play("fa_0005", "e001", false)
  PlaySE(202001, 100)
  WaitFrame(15)
  PlaySE(202007, 100)
  Quake_Start(0.05, 0, 60)
  Flg.Set("FLAG_GIMMICK_D14_380")
end

function Prcs_d1406_GiantWeaponMotion()
  if not Flg.Check("FLAG_FIELD_D1406_MOVEGIANTWEAPON") then
    local giantweapon = Obj:new(MOB, "giantweapon")
    local e500 = Motion.Object:new(giantweapon.type, giantweapon.name, "e500")
    giantweapon:DisableCulling()
    giantweapon:CancelInvisible()
    e500:Play(0, false)
    Flg.Set("FLAG_FIELD_D1406_MOVEGIANTWEAPON")
  end
end

function Prcs_d14_GetOnElv(gim_loc, prifix, map_num, locator)
  if gMapNum == 1401 then
    Cam.Inst:Set(50.85, 3.27, -24.24, 49.83, 3.43, -25.27, default, 30)
  else
    Cam.Inst:Set(0.48, 1.76, -1.26, -1.16, 2.26, -4.26, default, 30)
  end
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 10, false)
  Motion.Gimmick:Play(gim_loc, "e001", false)
  PlaySE(200013, 100)
  ColOff("plan_cl_1000")
  if Flg.Check("FLAG_MAIN_01_170", "FLAG_MAIN_01_180") then
    SetControlScriptExternalVariable("heroine_elv_state", "move_wait")
  end
  WaitFrame(30)
  MovePlayerFrame(90, 2, 30)
  Motion.Gimmick:WaitFrame(gim_loc, "e001", 0)
  Motion.Gimmick:Play(gim_loc, "e002", false)
  PlaySE(200011, 100)
  WaitFrame(30)
  local slot_num = Sound.PlaySE(200012, 100)
  Work.Set(99, slot_num)
  Flg.Set("FLAG_GIMMICK_D14_370")
  MapChange(prifix, map_num, locator, true, 0, 30)
end

function Prcs_d14_GetOutElv(start_loc)
  SetPlayerLocator("sp_0002")
  SetPlayerLocator(start_loc)
  if gMapNum == 1401 then
    Cam.Inst:Set(50.85, 3.27, -24.24, 49.83, 3.43, -25.27, default, 0)
  else
    Cam.Inst:Set(0.48, 1.76, -1.26, -1.16, 2.26, -4.26, default, 0)
  end
  Flg.Clear("FLAG_GIMMICK_D14_370")
  local slot_num = Work.Get(99)
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Fade.In(0, Util.SecondFromFrame(30))
  Sound.StopSE(slot_num, 0)
  PlaySE(200013, 100)
  Motion.Gimmick:Play("change_0001", "e001", false)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  WaitFrame(30)
  MovePlayerFrame(270, 2, 30)
  Motion.Gimmick:WaitFrame("change_0001", "e001", 0)
  Motion.Gimmick:Play("change_0001", "e002", false)
  PlaySE(200011, 100)
  ColOn("plan_cl_1000")
  ColOn("wall_cl_1000")
  Field.SetFollowerCameraOperateRotationY(135)
  Cam.Inst:Clear(30)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
end

function Prcs_d14_GetOutElv_Fade()
  SetPlayerLocator("sp_0002")
  Flg.Clear("FLAG_GIMMICK_D14_370")
  local slot_num = Work.Get(99)
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Sound.StopSE(slot_num, 0)
  PlaySE(200013, 100)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  ColOn("plan_cl_1000")
  ColOn("wall_cl_1000")
  Motion.Gimmick:Play("change_0001", "e002", false)
  PlaySE(200011, 100)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
  WaitFrame(30)
  Field.SetFollowerCameraOperateRotationY(135, 0)
end

function M020_Event_126()
  M020:Event_126()
end

function M020_Event_331B()
  M020:Event_331B()
end

function M020_Event_145()
  M020:Event_145()
end
