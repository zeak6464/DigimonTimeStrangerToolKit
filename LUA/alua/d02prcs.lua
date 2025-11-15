gGimText = "field_text"

function Prcs_d0201_gawappaCam()
  Cam.Inst:Set(-23.654, 3.541, 32.698, -21.763, 4.057, 34.248, DEFAULT_ANGLE, 20)
  Obj:new(PLAYER, ""):Invisible(10)
end

function Prcs_d0201_mashCam()
  Cam.Inst:Set(-3.2999, 4.142, -13.894, -0.551, 4.214, -13.856, DEFAULT_ANGLE, 20)
  Obj:new(PLAYER, ""):Invisible(10)
end

function Prcs_d0201_zudoCam()
  Cam.Inst:Set(11.966, 4.56, 26.222, 4.5, 4.42, 33, DEFAULT_ANGLE, 20)
  Obj:new(PLAYER, ""):Invisible(10)
end

function Prcs_d0201_bedaCam()
  Cam.Inst:Set(5.875, 3.758, 4.469, 2.928, 4.315, 4.53, DEFAULT_ANGLE, 20)
  Obj:new(PLAYER, ""):Invisible(10)
end

function Prcs_d0201_ropCam()
  Cam.Inst:Set(-10.949, 18.472, -27.722, -8.683, 18.425, -28.778, DEFAULT_ANGLE, 20)
  Obj:new(PLAYER, ""):Invisible(10)
end

function Prcs_d0202_AreaChangeGim()
  Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
  Motion.Player:ChangeMoveAnim("door", 0.75)
  MovePlayerFrame(70, 0.25, 30)
  WaitFrame(10)
  PlaySE(200001, 100)
  MapChange("d", 204, "start_00", true, 0, 15)
end

function Prcs_d0202_OutlawEvent()
  local npc_name = "outlaw"
  Talk.Load("d0202")
  Field_Talk_Start_Not_LetterBox("d02", 1)
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  if not Flg.Check("AREA_CLOSE_DEBUG") then
    Message(50001010)
    Message(50001020)
    MessageTalkSel(2, 50002010)
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Motion.NPC:Play(npc_name, "fq01", 30, true)
      Message(50003010)
      SetControlScriptExternalVariable("outlaw_state", "initialize")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Flg.Set("AREA_CLOSE_DEBUG")
    elseif result == RESULT_TALK01 then
      Message(50004010)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Motion.NPC:Play(npc_name, "fe02", 30, false)
      WaitFrame(60)
      EncountFromField(90406, 10272, false)
      Flg.Set("AREA_OPEN_DEBUG")
    end
  else
    Message(50005010)
    MessageTalkSel(2, 50006010)
    Message(50004010)
    Field_Talk_End_Not_LetterBox()
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Motion.NPC:Play(npc_name, "fe02", 30, false)
    WaitFrame(60)
    EncountFromField(90406, 10272, false)
    Flg.Set("AREA_OPEN_DEBUG")
  end
  WaitFrame(1)
end

function Prcs_d0202_WarpGim(move_in, exit, move_out, col_in, col_out, door1, door2, set_loc)
  if move_in == "script_in1F" then
    Cam.Inst:Set(-7.8, 1.7, 0.1, -0.7, 6.7, -5.1, default, 50)
  else
    Cam.Inst:Set(-8.3, 7.9, 6.4, -1.3, 11.6, 0.4, default, 50)
  end
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field.MovePlayerToLocatorFrame(set_loc, 10)
  WaitFrame(10)
  SetPlayerRotationToLocator(move_in, 10)
  Motion.Gimmick:Play(door1, "e001", false)
  PlaySE(200001, 100)
  WaitFrame(35)
  ColOff(col_in)
  ColOff(col_out)
  Field.MovePlayerToLocatorFrame(move_in, 40)
  WaitFrame(20)
  Motion.Gimmick:Play(door1, "e002", false)
  WaitFrame(14)
  Obj:new(PLAYER, ""):Invisible(10)
  WaitFrame(5)
  if move_in == "script_in1F" then
    Cam.Inst:Set(-8.3, 7.9, 6.4, -1.3, 11.6, 0.4, default, 50)
  else
    Cam.Inst:Set(-7.8, 1.7, 0.1, -0.7, 6.7, -5.1, default, 50)
  end
  SetPlayerLocator(exit)
  WaitFrame(20)
  Motion.Gimmick:Play(door2, "e001", false)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Field.MovePlayerToLocatorFrame(move_out, 50)
  WaitFrame(50)
  Motion.Gimmick:Play(door2, "e002", false)
  WaitFrame(30)
  PlaySE(200002, 100)
  ColOn(col_in)
  ColOn(col_out)
  GimmickZoom_Out()
  if move_in == "script_in1F" then
    SetFollowerCameraOperateRotation(20, -125)
    Field.MinimapDisplayHeight(2, 2)
  else
    SetFollowerCameraOperateRotation(20, 220)
    Field.MinimapDisplayHeight(5, 15)
  end
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  Cam.Inst:Clear(30)
  WaitFrame(10)
end

function Prcs_d0202_TextRumorCtrl(num)
  if num == 1 then
    Obj:new(RUMOR_NPC, "guide_lunamon"):Invisible()
    SetControlScriptExternalVariable("Rumer_state", "invisible")
  else
    local pos = Obj:new(NPC, "npc_0013").pos
    local rumor_luna = Obj:new(RUMOR_NPC, "guide_lunamon")
    rumor_luna:CancelInvisible()
    rumor_luna:SetPos(pos.x, pos.y + 1, pos.z)
    SetControlScriptExternalVariable("Rumer_state", "display")
  end
end

function Prcs_d0202_TextRumorCtrl2(num)
  if num == 1 then
    Obj:new(RUMOR_NPC, "guide_lunamon2"):Invisible()
    SetControlScriptExternalVariable("Rumer_state2", "invisible")
  else
    local pos = Obj:new(NPC, "npc_0013").pos
    local rumor_luna = Obj:new(RUMOR_NPC, "guide_lunamon2")
    rumor_luna:CancelInvisible()
    rumor_luna:SetPos(pos.x, pos.y, pos.z)
    SetControlScriptExternalVariable("Rumer_state2", "display")
  end
end

function Prcs_d0203_Bed()
  Field_Talk_Start_Not_LetterBox(gGimText, 1)
  Message("g_bed_0010_0010")
  MessageClose()
  MessageTalkSel(2, "g_bed_0010_0020")
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Field_Talk_End_Not_LetterBox()
    FadeOutWithWait(0, 30)
    Digimon.RestoreAllParty()
    PlaySE(200007, 100)
    INFO_WINDOW(5051)
    FadeInWithWait(0, 30)
  elseif result == RESULT_TALK01 then
    Field_Talk_End_Not_LetterBox()
  end
end

function Prcs_d0203_HangerRack()
  local def_text = "field_text"
  Field_Talk_Start(def_text, 1)
  Message("g_closet_0010_0010")
  Field_Talk_End()
end

function Prcs_d0204_ThroughDoor()
  ColOff("wall_cl_0001")
  SetFollowerCameraOperateRotation(default, 0)
  Cam.Inst:Clear(0)
  Field.MovePlayerToLocatorFrame("script_door_open", 20)
  WaitFrame(25)
  SetPlayerRotationToLocator("gim_0001", 5)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  Field.ObjectLoadMotion(FLD_OBJ_PLAYER, 1, "fg06_w02")
  Motion.Object:Play(FLD_OBJ_PLAYER, 1, 5, "fg06_w02", false)
  WaitFrame(6)
  Motion.Gimmick:Play("gim_0001", "e001", false)
  local se_slot = PlaySE(201009, 100)
  WaitFrame(170)
  StopSE(se_slot, 30)
  PlaySE(201019, 100)
end

function Prcs_d0204_AreaChangeGim()
  Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
  Motion.Player:ChangeMoveAnim("door", 0.75)
  MovePlayerFrame(180, 0.25, 30)
  WaitFrame(10)
  PlaySE(200001, 100)
  if TIME_AXIS ~= nil then
    MapChangeWithTimeTravel("d", 202, "start_02", TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
  else
    MapChange("d", 202, "start_02", true, 0, 15)
  end
end

function Prcs_d0205_StartMoveTown_01()
  PlayerCheckGimmick("gim_0001", 10, "fg07_m02", 0, false)
  WaitFrame(30)
  PlaySE(200005, 100)
  Motion.Gimmick:Play("gim_0001", "e001", false)
  Motion.Gimmick:ResetFrame("gim_0001", "e001", 30, 30, 60, false)
  SetControlScriptExternalVariable("townelv00_state", "move")
  Flg.Set("FLAG_GIMMICK_D02_020")
end

function Prcs_d0205_StartMoveTown_02()
  PlayerCheckGimmick("gim_0002", 10, "fg07_m02", 0, false)
  WaitFrame(30)
  PlaySE(200005, 100)
  Motion.Gimmick:Play("gim_0002", "e001", false)
  Motion.Gimmick:ResetFrame("gim_0002", "e001", 30, 30, 60, false)
  SetControlScriptExternalVariable("townelv01_state", "move")
  Flg.Set("FLAG_GIMMICK_D02_030")
end

function Prcs_d0205_OpenShutter()
  SetEnableGimmickCheck("gim_0003", false)
  PlayerCheckGimmick("gim_0003", 10, "fg07_m01", 0, false)
  WaitFrame(30)
  PlaySE(200005, 100)
  Motion.Gimmick:Play("gim_0003", "e001", false)
  Motion.Gimmick:ResetFrame("gim_0003", "e001", 20, 20, 30, true)
  Motion.Gimmick:Play("obj_0003", "e001", false)
  WaitFrame(40)
  Motion.Gimmick:ResetFrame("gim_0003", "e001", 60, 60, 65, false)
  ColOff("wall_cl_1000")
  Flg.Set("FLAG_GIMMICK_D02_040")
end

function Prcs_d0207_PutHagurumonEvent()
  local tlk = Tlk:new("d02")
  Prcs_d02_PutHagurumon("gim_0001", "obj_0001")
  tlk:StartTalk()
  Cam.Inst:Set(-23.3, 4, -14.5, -18, 5.1, -6.1, default, 30)
  tlk:Message("f_d0207_0010_0010")
  tlk:EndTalk(true)
  Cam.Inst:Clear(30)
  WaitFrame(30)
  Motion.Gimmick:ResetFrame("obj_0001", "e001", 0, 0, 150, false)
  Motion.Gimmick:Play("obj_0002", "e001", false)
  Motion.Gimmick:Play("obj_0008", "e001", false)
  Obj:new(FLD_OBJ_LOCATOR, "obj_0010"):CancelInvisible()
  PlaySE(200018, 100)
  Quake_Start(0.1, 0, 20)
  Motion.Gimmick:ResetFrame("obj_0008", "e001", GetGimmickAnimeFrame("obj_0008", "e001"), 300, 600, true)
  WaitFrame(70)
  Quake_Start(0.1, 0, 20)
  PlaySE(200018, 100)
  WaitFrame(20)
  Flg.Set("FLAG_GIMMICK_D02_270")
  ColOff("cliff_cl_1000")
  ColOff("cliff_cl_1001")
  Flg.Set("FLAG_GIMMICK_D02_210")
  tlk:StartTalk()
  tlk:Message("f_d0207_0010_0020")
  tlk:Message("f_d0207_0010_0030")
  tlk:EndTalk()
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  SetProhibitDigimonRide(false)
end

function Prcs_d0207_CarryingHagurumon_01()
  Field_Talk_End_Not_LetterBox()
  Cam.Inst:Clear(20)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Prcs_d02_PickUpHagurumon("gim_0002", false, "obj_0003")
  ColOn("cliff_cl_1002")
  Flg.Clear("FLAG_GIMMICK_D02_220")
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Flg.Set("FLAG_IS_CARRY_OBJECT")
end

function Prcs_d0207_CarryingHagurumon_02()
  Field_Talk_End_Not_LetterBox()
  Cam.Inst:Clear(20)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Prcs_d02_PickUpHagurumon("gim_0003", false, "obj_0005")
  ColOn("cliff_cl_1003")
  PlaySE(200018, 100)
  Flg.Clear("FLAG_GIMMICK_D02_230")
  Flg.Set("FLAG_IS_CARRY_OBJECT")
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
end

function Prcs_d0209_CarryingHagurumon_01(tlk)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  tlk:EndTalk()
  Cam.Inst:Clear(20)
  Prcs_d02_PickUpHagurumon("gim_0001", false, "obj_0001")
  Motion.Gimmick:Play("obj_0002", "e002", false)
  PlaySE(200018, 100)
  ColOn("cliff_cl_1000")
  Flg.Clear("FLAG_GIMMICK_D02_310")
  Flg.Clear("FLAG_GIMMICK_D02_360")
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
end

function Prcs_d0211_CheckFridge()
  if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
    Flg.Set("FLAG_IS_CHECK_D0211_ICEBOX")
    Motion.Gimmick:Play("obj_0001", "e001", false)
    Motion.Gimmick:WaitFrame("obj_0001", "e001", 0)
    Field_Talk_Start_Not_LetterBox("d02", 1)
    Message("f_d0211_0010_0010")
    Field_Talk_End_Not_LetterBox()
    Motion.Gimmick:Play("obj_0001", "e002", false)
    WaitFrame(15)
    INFO_GET_ITEM(1, 1)
  elseif Common.CheckTimeAxis("A2028_daft_200", "A2028_daft_450") then
    Flg.Set("FLAG_IS_CHECK_D0211_ICEBOX_01")
    Motion.Gimmick:Play("obj_0001", "e001", false)
    Motion.Gimmick:WaitFrame("obj_0001", "e001", 0)
    Field_Talk_Start_Not_LetterBox("d02", 1)
    Message("f_d0211_0050_0010")
    Field_Talk_End_Not_LetterBox()
    Motion.Gimmick:Play("obj_0001", "e002", false)
  end
end

function Prcs_d0216_DageGate()
  local tlk = Tlk:new("field_text", 1, true)
  tlk:StartTalk()
  tlk:Message("g_d0216_0010_0010")
  tlk:MessageClose()
  local result = tlk:Select(2, "g_d0216_0010_0011")
  if result == RESULT_TALK00 then
    tlk:EndTalk()
    MoveGateBlueGimmickObj("merc_gate01", 0, 1)
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    MapChangeWithTimePasses("d", 1204, "start_20", NOON)
  else
    tlk:EndTalk()
  end
end

function S050_043_Event_073()
  WaitFrame(30)
  require("S050_043")
  S050_043:Event_073()
end

function Prcs_d02_PickUpHagurumon(loc1, is_npc, loc2, npc_name)
  local attachment_haguru = 3
  Field.DisableMenu()
  Common.ProhibitSave()
  SetProhibitDigimonRide(true)
  Field.CancelPlayerAnywhereDigimonRide(true, false)
  Field.DisableSystemLadder()
  Field.DisableAnalyze()
  PlayerLoadAttachment(attachment_haguru, "fg02_fn01")
  PlayerPlayAttachmentAnimation(attachment_haguru, "fg02_fn01", 0, true)
  if is_npc == true then
    SetPlayerRotationToLocator(loc1, 10)
  else
    MovePlayerToLocatorFrame(loc1, 20)
    SetPlayerRotationByLocator(loc1, 10)
  end
  Motion.Player:Play("fg02_d01", 0, false)
  WaitFrame(10)
  if is_npc == true then
    Obj:new(NPC, npc_name):Invisible()
  elseif loc2 ~= -1 then
    Motion.Gimmick:Play(loc2, "", true)
    PlaySE(200016, 100)
  end
  WaitFrame(7)
  PlayerShowAttachment(attachment_haguru)
  Motion.Player:ChangeMoveAnim("hold", 2.5)
  Flg.Set("FLAG_IS_CARRY_OBJECT")
end

function Prcs_d02_PutHagurumon(loc, obj)
  local attachment_haguru = 3
  Motion.Player:Play("fg02_d02", 0, false)
  WaitFrame(35)
  PlaySE(200015, 100)
  PlayerHideAttachment(attachment_haguru)
  Motion.Gimmick:Play(obj, "e001", false)
  Motion.Gimmick:ResetFrame(obj, "e001", 0, 0, 0, true)
  WaitFrame(15)
  Motion.Player:ResetMoveAnim()
  Field.CancelDisableMenu()
  Common.CancelProhibitSave()
  SetProhibitDigimonRide(false)
  Field.CancelDisableSystemLadder()
  Field.CancelDisableAnalyze()
  Flg.Clear("FLAG_IS_CARRY_OBJECT")
end

function Prcs_d02_HagurumonGimStart(obj1, obj2, obj3, obj4)
  local gear2 = {
    aim_x = 15.1,
    aim_y = 18.7,
    aim_z = 5.4,
    x = 17,
    y = 22.5,
    z = 14.5
  }
  local gear3 = {
    aim_x = 4.3,
    aim_y = 13.9,
    aim_z = 2.6,
    x = 0.6,
    y = 16.4,
    z = 11.6
  }
  local gear4 = {
    aim_x = 13.1,
    aim_y = 22.1,
    aim_z = -2.1,
    x = 9,
    y = 26.6,
    z = 3.1
  }
  local cam
  if gMapNum == 207 then
    if obj1 == "obj_0005" then
      cam = gear2
    end
  elseif gMapNum == 209 then
    if obj1 == "obj_0001" then
      cam = gear3
    elseif obj1 == "obj_0005" then
      cam = gear4
    end
  end
  Motion.Gimmick:ResetFrame(obj1, "e001", 0, 0, 150, false)
  if obj2 ~= "" then
    Motion.Gimmick:Play(obj2, "e001", false)
  end
  if obj4 ~= "" then
    Motion.Gimmick:Play(obj3, "e001", false)
    Motion.Gimmick:Play(obj4, "e001", false)
    if cam == gear4 then
      WaitFrame(20)
      SetControlScriptExternalVariable("is_coming_elv_to_d0210", true)
      WaitFrame(45)
      Quake_Start(0.1, 0, 20)
      WaitFrame(30)
    else
      PlaySE(200018, 100)
      WaitFrame(70)
      Quake_Start(0.1, 0, 20)
    end
    Motion.Gimmick:ResetFrame(obj3, "e001", GetGimmickAnimeFrame(obj3, "e001"), 300, 600, true)
    Motion.Gimmick:ResetFrame(obj4, "e001", GetGimmickAnimeFrame(obj4, "e001"), 300, 600, true)
  else
    Motion.Gimmick:Play(obj3, "e001", false)
    PlaySE(200018, 100)
    WaitFrame(70)
    Motion.Gimmick:ResetFrame(obj3, "e001", 80, 300, 600, true)
    Quake_Start(0.1, 0, 20)
  end
  Cam.Inst:Clear(30)
  SetProhibitDigimonRide(false)
end

function Prcs_d02_HagurumonGimEnd(obj1, obj2, obj3, obj4)
  local gear2 = {
    aim_x = 15.1,
    aim_y = 18.7,
    aim_z = 5.4,
    x = 17,
    y = 22.5,
    z = 14.5
  }
  local gear3 = {
    aim_x = 4.3,
    aim_y = 13.9,
    aim_z = 2.6,
    x = 0.6,
    y = 16.4,
    z = 11.6
  }
  local gear4 = {
    aim_x = 11.1,
    aim_y = 24.1,
    aim_z = -2.1,
    x = 6,
    y = 21.6,
    z = 6.1
  }
  local cam
  if gMapNum == 207 then
    if obj1 == "obj_0005" then
      cam = gear2
    end
  elseif gMapNum == 209 then
    if obj1 == "obj_0001" then
      cam = gear3
    elseif obj1 == "obj_0005" then
      cam = gear4
    end
  end
  Cam.Inst:Set(cam.aim_x, cam.aim_y, cam.aim_z, cam.x, cam.y, cam.z, default, 20)
end

function Prcs_d02_keepCarryingHagurumon()
  local attachment_haguru = 3
  Field.DisableMenu()
  Common.ProhibitSave()
  SetProhibitDigimonRide(true)
  Field.DisableSystemLadder()
  Field.DisableAnalyze()
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  PlayerLoadAttachment(attachment_haguru, "fg02_fn01")
  PlayerPlayAttachmentAnimation(attachment_haguru, "fg02_fn01", 0, true)
  Obj:new(NPC, "npc_0001"):Invisible()
  PlayerShowAttachment(attachment_haguru)
  Motion.Player:ChangeMoveAnim("hold", 2.5)
end

function Prcs_d0210_Elvlamp()
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  WaitFrame(10)
  local fa_obstacles_01 = Obj:new(OGIM, "fa_obstacles_01")
  AttachAndStartEffectScript(FLD_OBJ_GIMMICK, fa_obstacles_01.index, "ef_b_hit_110_water", false, 1, false, false, false, false)
  Motion.Gimmick:Play("obj_0002", "e001", true)
  PlaySE(200014, 100)
  Quake_Start(0.02, 0, 30)
  WaitFrame(30)
  fa_obstacles_01:Invisible(1)
  Field_Talk_Start_Not_LetterBox(gGimText, 1)
  Message("g_d0210_0020_0010")
  Field_Talk_End_Not_LetterBox()
  SetEnableGimmickCheck("elv_0002", true)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
end

function Prcs_d0201_patamonride_id900()
  local npc_name = "patamon_ride1"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0201_0140_0010")
  MessageClose()
  MessageTalkSel(6, "f_d0201_0170_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  else
  end
  if result ~= RESULT_TALK05 then
    Message("f_d0201_0150_0010")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0201_0160_0010")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0201_patamonride_id900_2()
  local npc_name = "patamon_ride1"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0201_0140_0010")
  MessageClose()
  MessageTalkSel(7, "f_d0201_0180_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  elseif result == RESULT_TALK05 then
    prefix, map_num, locator = "d", 206, "start_04"
  else
  end
  if result ~= RESULT_TALK06 then
    Message("f_d0201_0150_0010")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0201_0160_0010")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0201_patamonride_id901()
  local npc_name = "patamon_ride2"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0201_0140_0010")
  MessageClose()
  MessageTalkSel(6, "f_d0201_0180_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  else
  end
  if result ~= RESULT_TALK05 then
    Message("f_d0201_0150_0010")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0201_0160_0010")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0201_patamonride_id901_2()
  local npc_name = "patamon_ride2"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0201_0140_0010")
  MessageClose()
  MessageTalkSel(7, "f_d0201_0200_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  elseif result == RESULT_TALK05 then
    prefix, map_num, locator = "d", 206, "start_04"
  else
  end
  if result ~= RESULT_TALK06 then
    Message("f_d0201_0150_0010")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0201_0160_0010")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0201_patamonride_id902()
  local npc_name = "patamon_ride3"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0201_0140_0010")
  MessageClose()
  MessageTalkSel(6, "f_d0201_0210_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  else
  end
  if result ~= RESULT_TALK05 then
    Message("f_d0201_0150_0010")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0201_0160_0010")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0201_patamonride_id902_2()
  local npc_name = "patamon_ride3"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0201_0140_0010")
  MessageClose()
  MessageTalkSel(7, "f_d0201_0220_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 207, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  elseif result == RESULT_TALK05 then
    prefix, map_num, locator = "d", 206, "start_04"
  else
  end
  if result ~= RESULT_TALK06 then
    Message("f_d0201_0150_0010")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0201_0160_0010")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0202_patamonride_id800()
  local npc_name = "patamon_ride1"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0202_0100_0010")
  MessageClose()
  MessageTalkSel(6, "f_d0202_0110_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  else
  end
  if result ~= RESULT_TALK05 then
    Message("f_d0202_0100_0020")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0202_0100_0030")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0202_patamonride_id800_2()
  local npc_name = "patamon_ride1"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0202_0100_0010")
  MessageClose()
  MessageTalkSel(7, "f_d0202_0120_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  elseif result == RESULT_TALK05 then
    prefix, map_num, locator = "d", 206, "start_04"
  else
  end
  if result ~= RESULT_TALK06 then
    Message("f_d0202_0100_0020")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0202_0100_0030")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End_Not_LetterBox()
end

function Prcs_d0202_patamonride_id801()
  local npc_name = "patamon_ride2"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0202_0100_0010")
  MessageClose()
  MessageTalkSel(6, "f_d0202_0130_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  else
  end
  if result ~= RESULT_TALK05 then
    Message("f_d0202_0100_0020")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0202_0100_0030")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End()
end

function Prcs_d0202_patamonride_id801_2()
  local npc_name = "patamon_ride2"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0202_0100_0010")
  MessageClose()
  MessageTalkSel(7, "f_d0202_0140_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_04"
  elseif result == RESULT_TALK05 then
    prefix, map_num, locator = "d", 206, "start_04"
  else
  end
  if result ~= RESULT_TALK06 then
    Message("f_d0202_0100_0020")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0202_0100_0030")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End()
end

function Prcs_d0202_patamonride_id802()
  local npc_name = "patamon_ride3"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0202_0100_0010")
  MessageClose()
  MessageTalkSel(6, "f_d0202_0150_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_91"
  else
  end
  if result ~= RESULT_TALK05 then
    Message("f_d0202_0100_0020")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0202_0100_0030")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End()
end

function Prcs_d0202_patamonride_id802_2()
  local npc_name = "patamon_ride3"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0202_0100_0010")
  MessageClose()
  MessageTalkSel(7, "f_d0202_0160_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 201, "start_90"
  elseif result == RESULT_TALK01 then
    prefix, map_num, locator = "d", 201, "start_91"
  elseif result == RESULT_TALK02 then
    prefix, map_num, locator = "d", 201, "start_92"
  elseif result == RESULT_TALK03 then
    prefix, map_num, locator = "d", 202, "start_90"
  elseif result == RESULT_TALK04 then
    prefix, map_num, locator = "d", 202, "start_91"
  elseif result == RESULT_TALK05 then
    prefix, map_num, locator = "d", 206, "start_04"
  else
  end
  if result ~= RESULT_TALK06 then
    Message("f_d0202_0100_0020")
    Field_Talk_End_Not_LetterBox()
    MapChange(prefix, map_num, locator, true, 0, 10)
  end
  Message("f_d0202_0100_0030")
  END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Cam.Inst:Clear(30)
  Field_Talk_End()
end

function Prcs_d0206_patamonride_id900()
  local npc_name = "patamon_ride"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0206_0030_0010")
  MessageClose()
  MessageTalkSel(2, "f_d0206_0040_0010")
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Message("f_d0206_0030_0020")
    Field_Talk_End()
    if not Flg.Check("FLAG_GIMMICK_D02_190") then
      Flg.Set("FLAG_GIMMICK_D02_190")
    end
    if Qst.Main:Check(M140.ID, M140.STEP_010, M140.STEP_015) then
      TIME_ZONE = NOON
    end
    MapChange("d", 201, "start_00", true, 0, 10)
  elseif result == RESULT_TALK01 then
    Message("f_d0206_0030_0030")
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Cam.Inst:Clear(30)
    Field_Talk_End()
    if not Flg.Check("FLAG_GIMMICK_D02_190") then
      Flg.Set("FLAG_GIMMICK_D02_190")
    end
  end
end

function Prcs_d0201_ShopTut()
  Field_Talk_Start_Not_LetterBox("d02", 1)
  Message(500)
  Cam.Inst:Set(-25.58, 3.192, 30.678, -15.993, 4.191, 33.339, DEFAULT_ANGLE, 30)
  WaitFrame(30)
  Field.SetPlayerLocator("start_93")
  Move:ToNPC("shop_0003", 0.5)
  Prcs_d0201_gawappaCam()
  Message(501)
  Field_Talk_End()
  Shop.Open(108)
  WaitCloseShopWindow()
  EndShop()
  Cam.Follower:ResetFromObject(NPC, "shop_0003")
  FieldTalk("d0201", 1, 502)
end

function NPCtalk_npc_0003()
  local npc_name = GetIndex(NPC, "npc_0003")
  local npc_0003_bn01 = Motion.Object:new(NPC, "npc_0003", "bn01")
  local npc_0003_fq01 = Motion.Object:new(NPC, "npc_0003", "fq01")
  START_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
  Field_Talk_Start_Not_LetterBox("d02", 1)
  npc_0003_bn01:Play(15, true)
  Message(104)
  npc_0003_fq01:Play(15, true)
  Message(105)
  END_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
  Field_Talk_End_Not_LetterBox()
end

function NPCtalk_npc_3021and3022()
  local tanepuni = GetIndex(NPC, "npc_3021")
  local npc_3021_bn01 = Motion.Object:new(NPC, "npc_3021", "bn01")
  local npc_3021_fq02 = Motion.Object:new(NPC, "npc_3021", "fq02")
  local npc_3022_bn01 = Motion.Object:new(NPC, "npc_3022", "bn01")
  local npc_3022_fq01 = Motion.Object:new(NPC, "npc_3022", "fq01")
  local fldtxt = "d02"
  START_TALK_ACTION_AND_ZOOM("npc_3021", true, true)
  Field_Talk_Start_Not_LetterBox("d02", 1)
  npc_3021_fq02:Play(15, true)
  Message("f_d0201_0440_0010")
  npc_3021_bn01:Play(15, true)
  npc_3022_fq01:Play(15, true)
  Message("f_d0201_0440_0020")
  npc_3022_bn01:Play(15, true)
  END_TALK_ACTION_AND_ZOOM("npc_3021", true, true)
  Field_Talk_End_Not_LetterBox()
end

function NPCtalk_npc_0313and0314()
  local starpanda = GetIndex(NPC, "npc_0313")
  local npc_0313_fe04 = Motion.Object:new(NPC, "npc_0313", "fe04")
  local npc_0313_fq02 = Motion.Object:new(NPC, "npc_0313", "fq02")
  local npc_0314_bn01 = Motion.Object:new(NPC, "npc_0314", "bn01")
  local npc_0314_fq02 = Motion.Object:new(NPC, "npc_0314", "fq02")
  local npc_0314_fe04 = Motion.Object:new(NPC, "npc_0314", "fe04")
  local fldtxt = "d02"
  if Flg.Check("FLAG_MAIN_03_630") then
    Cam.Inst:Set(11.618629, 2.818202, -12.609294, 7.796159, 6.536711, -4.149896, default, 45)
    WaitFrame(40)
    START_TALK_ACTION_AND_ZOOM("npc_0313", false, false)
    Field_Talk_Start_Not_LetterBox("d02", 1)
    npc_0313_fq02:Play(15, true)
    Message("f_d0201_0490_0030")
    npc_0314_fe04:Play(15, true)
    Message("f_d0201_0490_0040")
    npc_0313_fe04:Play(15, true)
    npc_0314_fq02:Play(15, true)
    Cam.Inst:Clear(45)
    END_TALK_ACTION_AND_ZOOM("npc_0313", false, false)
    Field_Talk_End_Not_LetterBox()
  else
    Cam.Inst:Set(11.618629, 2.818202, -12.609294, 7.796159, 6.536711, -4.149896, default, 45)
    WaitFrame(40)
    START_TALK_ACTION_AND_ZOOM("npc_0313", false, false)
    Field_Talk_Start_Not_LetterBox("d02", 1)
    npc_0313_fq02:Play(15, true)
    Message("f_d0201_0490_0010")
    npc_0314_bn01:Play(15, true)
    Message("f_d0201_0490_0020")
    npc_0313_fe04:Play(15, true)
    npc_0314_fq02:Play(15, true)
    Cam.Inst:Clear(45)
    END_TALK_ACTION_AND_ZOOM("npc_0313", false, false)
    Field_Talk_End_Not_LetterBox()
  end
end

function Prcs_d0202_ride_pegasmon()
  local npc_name = "ride_pegasmon"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  if not Flg.Check("FLAG_MAIN_03_645") then
    Flg.Clear("FLAG_IS_START_EVENT_BEFORE_MAPCHANGE")
    Field_Talk_Start(npc_text, 1)
    Message("f_d0202_0080_0010")
    MessageClose()
    if not Flg.Check("TUT_FLAG_4711") then
      OpenTutorial(3011)
      Flg.Set("TUT_FLAG_4711")
    end
    MessageTalkSel(2, "f_d0202_0080_0020")
    local prefix, map_num, locator = "", 0, ""
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      prefix, map_num, locator = "d", 205, "start_00"
      Message("f_d0202_0080_0040")
      Field_Talk_End()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Cam.Inst:Clear(15)
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Field.CancelPlayerAnywhereDigimonRide(false, false)
      SetProhibitDigimonRide(true)
      WaitFrame(1)
      SetProhibitDigimonRide(false)
      Obj:new(NPC, "ride_pegasmon"):Invisible(15)
      Field.PlayerScriptDigimonRideStartFromID(146, true, "script_ride_01", 5)
      SetFollowerCameraOperateRotation(5, 270, 15)
      SetEnableCameraOperate(false)
      WaitFrame(15)
      SetControlScriptExternalVariable("pegas_state", "start_move")
      Flg.Set("FLAG_GIMMICK_D02_010")
    else
      Message("f_d0202_0080_0090")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Cam.Inst:Clear(30)
      Field_Talk_End()
    end
  elseif Flg.Check("FLAG_MAIN_03_715") then
    require("S050_152")
    Field_Talk_Start_Not_LetterBox(npc_text, 1)
    Message("f_d0202_0080_0060")
    Message("f_d0202_0080_0065")
    MessageClose()
    local num = 2
    local mes = 760
    if Qst.Sub:Check(S050_152.ID, S050_152.STEP_005, S050_152.STEP_255) then
      num = 3
    end
    if Qst.Sub:IsCompleted(S050_152.ID) and not S050_152:CheckGiveDigimental() then
      num = 3
    end
    mes = Qst.Sub:IsCompleted(S050_152.ID) and not S050_152:CheckGiveDigimental() and 770 or mes
    local id = string.format("f_d0202_%04d_0010", mes)
    MessageTalkSel(num, id)
    local prefix, map_num, locator = "", 0, ""
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      prefix, map_num, locator = "d", 205, "start_00"
      Message("f_d0202_0080_0080")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Cam.Inst:Clear(30)
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Field.CancelPlayerAnywhereDigimonRide(false, false)
      SetProhibitDigimonRide(true)
      WaitFrame(1)
      SetProhibitDigimonRide(false)
      Obj:new(NPC, "ride_pegasmon"):Invisible(15)
      Field.PlayerScriptDigimonRideStartFromID(146, true, "script_ride_01", 5)
      SetFollowerCameraOperateRotation(5, 270, 15)
      SetEnableCameraOperate(false)
      WaitFrame(15)
      SetControlScriptExternalVariable("pegas_state", "start_move")
      Flg.Set("FLAG_GIMMICK_D02_010")
    elseif result == RESULT_TALK01 then
      Message("f_d0202_0080_0090")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    elseif result == RESULT_TALK02 then
      Field_Talk_End_Not_LetterBox()
      require("S050_152")
      if not Qst.Sub:IsCompleted(S050_152.ID) then
        S050_152:Event_011()
      else
        S050_152:Event_013()
      end
    end
  else
    Field_Talk_Start_Not_LetterBox(npc_text, 1)
    Message("f_d0202_0080_0060")
    Message("f_d0202_0080_0065")
    MessageClose()
    MessageTalkSel(2, "f_d0202_0080_0070")
    local prefix, map_num, locator = "", 0, ""
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      prefix, map_num, locator = "d", 205, "start_00"
      Message("f_d0202_0080_0080")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Cam.Inst:Clear(30)
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Field.CancelPlayerAnywhereDigimonRide(false, false)
      SetProhibitDigimonRide(true)
      WaitFrame(1)
      SetProhibitDigimonRide(false)
      Obj:new(NPC, "ride_pegasmon"):Invisible(15)
      Field.PlayerScriptDigimonRideStartFromID(146, true, "script_ride_01", 5)
      SetFollowerCameraOperateRotation(5, 270, 15)
      SetEnableCameraOperate(false)
      WaitFrame(15)
      SetControlScriptExternalVariable("pegas_state", "start_move")
      Flg.Set("FLAG_GIMMICK_D02_010")
    elseif result == RESULT_TALK01 then
      Message("f_d0202_0080_0090")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
  end
end

function Prcs_d0205_ride_pegasmon()
  local npc_name = "ride_pegasmon"
  local npc_text = "d02"
  START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_d0205_0020_0010")
  MessageClose()
  MessageTalkSel(2, "f_d0205_0030_0010")
  local prefix, map_num, locator = "", 0, ""
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    prefix, map_num, locator = "d", 202, "start_93"
    Message("f_d0205_0020_0020")
    Field_Talk_End_Not_LetterBox()
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Cam.Inst:Clear(30)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field.CancelPlayerAnywhereDigimonRide(false, false)
    SetProhibitDigimonRide(true)
    WaitFrame(1)
    SetProhibitDigimonRide(false)
    Obj:new(NPC, "ride_pegasmon"):Invisible(15)
    Field.PlayerScriptDigimonRideStartFromID(146, true, "script_ride_01", 5)
    Common.ProhibitSave()
    SetFollowerCameraOperateRotation(5, 180, 15)
    SetEnableCameraOperate(false)
    WaitFrame(15)
    SetControlScriptExternalVariable("pegas_state", "start_move")
    Flg.Set("FLAG_GIMMICK_D02_010")
  elseif result == RESULT_TALK01 then
    Message("f_d0205_0020_0030")
    END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    Cam.Inst:Clear(30)
    Field_Talk_End_Not_LetterBox()
  end
end

function Prcs_d0202_ride_pegasmon_end()
  WaitFrame(15)
  Field.PlayerScriptDigimonRideEnd(true, "", 5)
  Flg.Clear("FLAG_GIMMICK_D02_010")
  WaitFrame(20)
  SetEnableCameraOperate(true)
  local ride_pegasmon = Obj:new(NPC, "ride_pegasmon")
  ride_pegasmon:CancelInvisible(10)
  Common.CancelProhibitSave()
  Field.FollowerWarp()
end

function Prcs_d0205_ride_pegasmon_end()
  WaitFrame(15)
  Field.PlayerScriptDigimonRideEnd(true, "", 5)
  Flg.Clear("FLAG_GIMMICK_D02_010")
  WaitFrame(20)
  local ride_pegasmon = Obj:new(NPC, "ride_pegasmon")
  ride_pegasmon:CancelInvisible(10)
  WaitFrame(15)
  SetEnableCameraOperate(true)
  M140:Event_035()
  Field.FollowerWarp()
end

function NPCtalk_npc_0024and0025()
  local GalgoRevol = GetIndex(NPC, "npc_0024")
  local Revol = GetIndex(NPC, "npc_0025")
  local npc_0024_bn01 = Motion.Object:new(NPC, "npc_0024", "bn01")
  local npc_0024_fe01 = Motion.Object:new(NPC, "npc_0024", "fe01")
  local npc_0024_fq02 = Motion.Object:new(NPC, "npc_0024", "fq02")
  local npc_0025_bn01 = Motion.Object:new(NPC, "npc_0025", "bn01")
  local npc_0025_fe01 = Motion.Object:new(NPC, "npc_0025", "fe01")
  local npc_0025_fe04 = Motion.Object:new(NPC, "npc_0025", "fe04")
  local npc_0025_fq01 = Motion.Object:new(NPC, "npc_0025", "fq01")
  local npc_0025_fq02 = Motion.Object:new(NPC, "npc_0025", "fq02")
  Cam.Inst:Set(18.780499, 0.007133, 1.334458, 12.099147, 2.103679, -5.804452, default, 45)
  WaitFrame(40)
  Field_Talk_Start_Not_LetterBox("d02", 1)
  npc_0024_fq02:PlayWithStartMoveMotion(10, 10)
  Message("f_d0202_0260_0010")
  npc_0025_fq02:PlayWithStartMoveMotion(10, 10)
  Message("f_d0202_0260_0030")
  npc_0025_fe04:Play(10, true)
  Message("f_d0202_0260_0040")
  npc_0024_fq02:PlayWithStartMoveMotion(10, 10)
  Message("f_d0202_0260_0020")
  npc_0024_fe01:Play(10, true)
  Cam.Inst:Clear(45)
  Field_Talk_End_Not_LetterBox()
end

function NPCtalk_npc_0026and0027()
  local GalgoRevol01 = GetIndex(NPC, "npc_0026")
  local npc_0026_fe01 = Motion.Object:new(NPC, "npc_0026", "fe01")
  local npc_0026_fe03 = Motion.Object:new(NPC, "npc_0026", "fe03")
  local npc_0026_fq02 = Motion.Object:new(NPC, "npc_0026", "fq02")
  Cam.Inst:Set(18.780499, 0.007133, 1.334458, 12.099147, 2.103679, -5.804452, default, 45)
  WaitFrame(40)
  Field_Talk_Start_Not_LetterBox("d02", 1)
  npc_0026_fe01:Play(10, true)
  Message("f_d0202_0260_0050")
  Message("f_d0202_0260_0070")
  npc_0026_fq02:Play(10, true)
  Message("f_d0202_0260_0060")
  npc_0026_fe03:Play(10, true)
  Cam.Inst:Clear(45)
  Field_Talk_End_Not_LetterBox()
end
