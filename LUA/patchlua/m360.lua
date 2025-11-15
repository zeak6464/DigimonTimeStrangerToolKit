gGimText = "field_text"
M360 = {
  ID = 360,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}

function M360:Event_005()
  if Flg.Check("FLAG_MAIN_13_180", "FLAG_MAIN_14_010") then
    WaitFrame(30)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M360:Event_010()
  if Flg.Check("FLAG_MAIN_13_180", "FLAG_MAIN_14_010") then
    Flg.Set("FLAG_MAIN_14_010")
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2028_daft_360"
    TIME_ZONE = NOON
    Map:OpenArea(107, true)
    Map:OpenPlace(10701, true)
    Map:CloseArea(107, false)
  end
end

function M360:Event_011()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) then
    Flg.Set("FLAG_MAIN_14_015")
    Qst.Main:Set(self.ID, self.STEP_003)
  end
end

function M360:Event_012()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_14_010", "FLAG_MAIN_14_011") then
    local cam_rot_a = 150
    local npc_geko = "npc_1000"
    local npc_geko_a = "npc_1001"
    local start_loc = "ride_start_01"
    local landing_loc1 = "ride_landing_01a"
    local npc_geko_end = npc_geko_a
    local cam_rot = cam_rot_a
    Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
    WaitFrame(10)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
    local landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc1))
    local geko_index = GetIndex(NPC, npc_geko)
    Field.ObjectResetMotion(NPC, geko_index, 0)
    Obj:new(NPC, npc_geko):CancelInvisible()
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectLoadMotion(NPC, geko_index, "bn02")
    Field.ObjectLoadMotion(NPC, geko_index, "ba01")
    Field.ObjectLoadMotion(NPC, geko_index, "fq01")
    Field.ObjectLoadMotion(NPC, geko_index, "fq02")
    Field.ObjectLoadMotion(NPC, geko_index, "fe01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e017")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectLoadMotion(PLAYER, 1, "e032")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, start_pos.x, start_pos.y, start_pos.z)
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot, 0)
    Field.ObjectSetPos(NPC, geko_index, -4.69, 2.258, 58.521)
    local vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 165)
    local aim_x = geko_pos.x + vector2d.x * 2
    local aim_y = geko_pos.y + 0.05
    local aim_z = geko_pos.z + vector2d.z * 2
    local vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + 145)
    local cam_x = player_pos.x + vector2d.x * 1.1
    local cam_y = player_pos.y + 1.55
    local cam_z = player_pos.z + vector2d.z * 1.1
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, 10)
    Flg.Set("FLAG_MAIN_14_011")
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0701_0015_0010")
    local result = tlk:Select(1, "f_d0701_0015_0020")
    Field.ObjectPlayMotion(NPC, geko_index, "fq02", 10, 10)
    tlk:Message("f_d0701_0015_0030")
    Field.ObjectPlayMotion(NPC, geko_index, "fq01", 10, 10)
    tlk:Message("f_d0701_0010_0380")
    Field.ObjectPlayMotion(NPC, geko_index, "fq02", 10, 10)
    tlk:Message("f_d0701_0010_0390")
    Field.ObjectPlayMotion(NPC, geko_index, "bn02", 10, 10)
    tlk:Message("f_d0701_0015_0040")
    local result = tlk:Select(1, "f_d0701_0015_0050")
    tlk:Message("f_d0701_0015_0060")
    Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, 10)
    tlk:Message("f_d0701_0015_0070")
    Field.ObjectPlayMotion(NPC, geko_index, "fq01", 10, 10)
    tlk:Message("f_d0701_0010_0410")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
    tlk:Message("f_d0701_0010_0040")
    tlk:Message("f_d0701_0010_0050")
    tlk:Message("f_d0701_0010_0060")
    tlk:MessageClose()
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e032", 10, 10)
    WaitFrame(60)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
    tlk:Message("f_d0701_0010_0070")
    tlk:Message("f_d0701_0010_0080")
    tlk:Message("f_d0701_0010_0090")
    tlk:MessageClose()
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e008", 10, 10)
    WaitFrame(60)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
    tlk:Message("f_d0701_0010_0140")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
    tlk:Message("f_d0701_0010_0150")
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 15, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
    tlk:Message("f_d0701_0010_0160")
    tlk:MessageClose()
    while true do
      local result = tlk:Select(3, "f_d0701_0010_0170")
      if result == RESULT_TALK00 or result == RESULT_TALK01 then
        break
      end
      Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e008", 10, 10)
      WaitFrame(30)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "fq02", 10, 10)
      tlk:Message("f_d0701_0010_0255")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, false)
    Sound.PlayVoice("f_d0701_0010_0180")
    Talk.Message_Auto("f_d0701_0010_0180", 4)
    WaitFrame(60)
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
    PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    Obj:new(PLAYER, ""):Invisible(5)
    Obj:new(NPC, npc_geko):Invisible(5)
    WaitFrame(30)
    BackFade_Out(FADE_BLACK, 10)
    WaitFrame(10)
    geko_index = GetIndex(NPC, npc_geko_end)
    Field.ObjectResetMotion(NPC, geko_index, 30)
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, landing_pos.x, landing_pos.y, landing_pos.z)
    Obj:new(NPC, npc_geko):Invisible()
    player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko_end)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot + 210, 0)
    vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 210)
    Field.ObjectSetPos(OGIM, GetIndex(OGIM, "eff_geko_01"), geko_pos.x + vector2d.x * 1, geko_pos.y, geko_pos.z + vector2d.z * 1)
    vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 180)
    aim_x = geko_pos.x + vector2d.x * 2
    aim_y = geko_pos.y + 0.5
    aim_z = geko_pos.z + vector2d.z * 2
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + cam_rot)
    cam_x = player_pos.x + vector2d.x * 8
    cam_y = player_pos.y + 3
    cam_z = player_pos.z + vector2d.z * 8
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    BackFade_In(FADE_BLACK, 10)
    Talk.Close()
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
    PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 180)
    aim_x = geko_pos.x + vector2d.x * 2
    aim_y = geko_pos.y + 0.5
    aim_z = geko_pos.z + vector2d.z * 2
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + 150)
    cam_x = player_pos.x + vector2d.x * 1
    cam_y = player_pos.y + 1.4
    cam_z = player_pos.z + vector2d.z * 1
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    WaitFrame(5)
    Obj:new(PLAYER, ""):CancelInvisible(10)
    Obj:new(NPC, npc_geko_end):CancelInvisible(10)
    WaitFrame(30)
    Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, true)
    Obj:new(OGIM, "eff_geko_01"):CancelInvisible(5)
    WaitFrame(10)
    Field.ObjectPlayMotion(PLAYER, 1, "e017", 15, false)
    WaitFrame(10)
    tlk:Message("f_d0701_0010_0190")
    tlk:Message("f_d0701_0010_0200")
    tlk:Message("f_d0701_0010_0210")
    tlk:Message("f_d0701_0010_0220")
    tlk:Message("f_d0701_0010_0230")
    tlk:Message("f_d0701_0010_0240")
    tlk:Message("f_d0701_0010_0250")
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, false)
    Flg.Set("FLAG_GIMMICK_D07_010")
    Field.ObjectResetMotion(PLAYER, 1, 30)
    Obj:new(NPC, npc_geko_end):Invisible(30)
    Obj:new(OGIM, "eff_geko_01"):Invisible(30)
    SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    Guest.Add(GST_GEKO)
    INFO_WINDOW(7039)
    Common.SetDigimonGraspState(399, DIGIMON_GRASP_FLAG_SCAN)
    Field.CheckSyncFollower()
  end
end

function M360:Event_014()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_011", "FLAG_MAIN_14_012") then
    local npc_geko = "npc_1018"
    local start_loc = "ride_start_07"
    local landing_loc1 = "ride_landing_07"
    local npc_geko_end = "npc_1010"
    local cam_rot = 150
    Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
    WaitFrame(10)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
    local landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc1))
    local geko_index = GetIndex(NPC, npc_geko)
    Field.ObjectResetMotion(NPC, geko_index, 0)
    Obj:new(NPC, npc_geko):CancelInvisible()
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectLoadMotion(NPC, geko_index, "ba01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e017")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, start_pos.x, start_pos.y, start_pos.z)
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot, 0)
    local vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 165)
    local aim_x = geko_pos.x + vector2d.x * 2
    local aim_y = geko_pos.y + 0.05
    local aim_z = geko_pos.z + vector2d.z * 2
    local vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + 145)
    local cam_x = player_pos.x + vector2d.x * 1.1
    local cam_y = player_pos.y + 1.55
    local cam_z = player_pos.z + vector2d.z * 1.1
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, 10)
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0701_0010_0260")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
    tlk:Message("f_d0701_0010_0270")
    result = tlk:Select(3, "f_d0701_0010_0280")
    if result == RESULT_TALK00 or result == RESULT_TALK01 then
      Flg.Set("FLAG_MAIN_14_012")
      Flg.Set("FLAG_FIELD_D07_010")
      Flg.Set("FLAG_GIMMICK_D07_120")
      Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
      WaitFrame(15)
      Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, false)
      Sound.PlayVoice("f_d0701_0010_0290")
      Talk.Message_Auto("f_d0701_0010_0290", 5)
      vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
      PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
      PlaySE(200006, 100)
      WaitFrame(20)
      Obj:new(PLAYER, ""):Invisible(5)
      Obj:new(NPC, npc_geko):Invisible(5)
      WaitFrame(30)
      tlk:EndTalk()
      MapChange("d", 703, "start_00", true, FADE_BLACK, FADE_TIME)
    else
      Obj:new(NPC, npc_geko):Invisible(30)
      SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
      Cam.Inst:Clear(30)
      Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
      tlk:EndTalk()
    end
  end
end

function M360:Event_016()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_012", "FLAG_MAIN_14_013") then
    Flg.Set("FLAG_MAIN_14_013")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    local landing_loc = "ride_landing_12"
    local npc_geko = "npc_1031"
    local cam_rot = 150
    local landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc))
    local geko_index = GetIndex(NPC, npc_geko)
    Field.ObjectResetMotion(NPC, geko_index, 0)
    Obj:new(PLAYER, ""):Invisible()
    Obj:new(NPC, npc_geko):Invisible()
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectLoadMotion(NPC, geko_index, "ba01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e017")
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, landing_pos.x, landing_pos.y, landing_pos.z)
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot + 210, 0)
    vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 210)
    Field.ObjectSetPos(OGIM, GetIndex(OGIM, "eff_geko_01"), geko_pos.x + vector2d.x * 1, geko_pos.y, geko_pos.z + vector2d.z * 1)
    vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 180)
    aim_x = geko_pos.x + vector2d.x * 2
    aim_y = geko_pos.y + 0.5
    aim_z = geko_pos.z + vector2d.z * 2
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + cam_rot)
    cam_x = player_pos.x + vector2d.x * 8
    cam_y = player_pos.y + 3
    cam_z = player_pos.z + vector2d.z * 8
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
    PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 180)
    aim_x = geko_pos.x + vector2d.x * 2
    aim_y = geko_pos.y + 0.5
    aim_z = geko_pos.z + vector2d.z * 2
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + 150)
    cam_x = player_pos.x + vector2d.x * 1
    cam_y = player_pos.y + 1.4
    cam_z = player_pos.z + vector2d.z * 1
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    WaitFrame(5)
    Obj:new(PLAYER, ""):CancelInvisible(10)
    Obj:new(NPC, npc_geko):CancelInvisible(10)
    WaitFrame(30)
    Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, true)
    Obj:new(OGIM, "eff_geko_01"):CancelInvisible(5)
    WaitFrame(10)
    Field.ObjectPlayMotion(PLAYER, 1, "e017", 15, false)
    WaitFrame(10)
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0703_0130_0010")
    tlk:EndTalk()
    Field.ObjectResetMotion(PLAYER, 1, 30)
    Obj:new(NPC, npc_geko):Invisible(30)
    Obj:new(OGIM, "eff_geko_01"):Invisible(30)
    SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  end
end

function M360:Event_018()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_013", "FLAG_MAIN_14_014") then
    Flg.Set("FLAG_MAIN_14_014")
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0702_0010_0010")
    tlk:Message("f_d0702_0010_0020")
    tlk:EndTalk()
  end
end

function M360:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_014", "FLAG_MAIN_14_020") then
    Execute("m360_010")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Battle.Encount(11200010, 10772, false)
  end
end

function M360:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_020", "FLAG_MAIN_14_030") then
    Flg.Set("FLAG_MAIN_14_030")
    Motion.Object:Play(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_curtain01"), 0, "e002", true)
    Flg.Set("FLAG_GIMMICK_D07_110")
    Execute("m360_020")
    Guest.Delete(GST_GEKO)
    Flg.Set("FLAG_MAIN_14_016")
    Flg.Set("FLAG_MAIN_14_017")
    Flg.Set("TUT_FLAG_4516")
    Digimon.RestoreAllParty()
    MapChangeWithTimeTravel("t", 3001, "start_00", AXIS_ORIGINAL, "P2028_daft_360", NIGHT)
  end
end

function M360:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_030", "FLAG_MAIN_14_035") then
    Flg.Set("FLAG_MAIN_14_035")
    Obj:new(PLAYER, ""):SetPos(0, 0, 0)
    Obj:new(NPC, "farm_0001"):SetPos(0, 0, -1.345)
    Obj:new(NPC, "farm_0001"):SetRotationY(180, 0)
    Cam.Inst:Set(-1.867, -2.1, -8.18, 0.433, 1.822, 0.725, default, 0)
    local npc01_index = GetIndex(NPC, "farm_0001")
    Field.ObjectLoadMotion(NPC, npc01_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, npc01_index, "e002")
    Field.ObjectLoadMotion(NPC, npc01_index, "e003")
    Field.ObjectLoadMotion(NPC, npc01_index, "e021")
    Field.ObjectLoadExpression(NPC, npc01_index, "F01")
    HideMinimap(true)
    HideGuide(true)
    local tlk = Tlk:new("t30", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    FadeAllInWithWait(FADE_WHITE, 60)
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_t3001_0170_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e003", 10, 10)
    tlk:Message("f_t3001_0170_0020")
    Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
    tlk:Message("f_t3001_0170_0030")
    Field.ObjectPlayMotion(NPC, npc01_index, "e021", 10, true)
    tlk:Message("f_t3001_0170_0040")
    Field.ObjectPlayMotion(NPC, npc01_index, "e002", 10, true)
    tlk:Message("f_t3001_0170_0050")
    Field.ObjectPlayMotion(NPC, npc01_index, "fn01_01", 10, 10)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk()
    MapChange("t", 3002, "start_00", true, FADE_BLACK, FADE_TIME)
  end
end

function M360:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_030", "FLAG_MAIN_14_040") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_movechair02"), "e002", 10, true)
    Execute("m360_030")
    Execute("m360_040")
    Sound.StopBGM(0)
    Execute("m360_050")
    MapChangeWithTimeTravel("d", 701, "start_50", AXIS_ORIGINAL, "P2028_daft_361", NOON)
  end
end

function M360:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_14_030") then
    Flg.Set("FLAG_MAIN_14_040")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Cam.Inst:Set(-12.628, 1.868, 114.615, -7.845, 2.057, 105.835, default, 0)
    InitializeTheaterDoorEvt()
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(90)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M360:Event_046()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_14_040", "FLAG_MAIN_14_041") then
    local npc_geko = "npc_1000"
    local start_loc = "ride_start_01"
    local npc_geko_end = npc_geko_a
    Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
    WaitFrame(10)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
    local geko_index = GetIndex(NPC, npc_geko)
    Field.ObjectResetMotion(NPC, geko_index, 0)
    local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectLoadMotion(NPC, geko_index, "bn02")
    Field.ObjectLoadMotion(NPC, geko_index, "ba01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    Field.ObjectLoadMotion(NPC, geko_index, "br01")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e017")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, start_pos.x, start_pos.y, start_pos.z)
    Field.ObjectSetPos(NPC, geko_index, -4.489, 2.258, 58.957, true)
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot, 0)
    local vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 165)
    local aim_x = geko_pos.x + vector2d.x * 2
    local aim_y = geko_pos.y + 0.05
    local aim_z = geko_pos.z + vector2d.z * 2
    local vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + 145)
    local cam_x = player_pos.x + vector2d.x * 1.1
    local cam_y = player_pos.y + 1.55
    local cam_z = player_pos.z + vector2d.z * 1.1
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, 10)
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    result = tlk:Select(2, "f_d0701_0010_0300")
    Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
    WaitFrame(90)
    if result == RESULT_TALK00 then
      tlk:Message("f_d0701_0010_0310")
    elseif result == RESULT_TALK01 then
      tlk:Message("f_d0701_0010_0310")
    end
    tlk:MessageClose()
    vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
    PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    Obj:new(NPC, npc_geko):CancelInvisible()
    Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, true)
    WaitFrame(60)
    Field.ObjectPlayMotion(NPC, geko_index, "bn02", 10, true)
    tlk:Message("f_d0701_0010_0320")
    Field.ObjectPlayMotion(NPC, geko_index, "ba01", 10, true)
    tlk:Message("f_d0701_0010_0330")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(11200100, 10771, false)
  end
end

function M360:Event_047()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_14_041", "FLAG_MAIN_14_042") then
    Flg.Set("FLAG_MAIN_14_042")
    local npc_geko = "npc_1000"
    local start_loc = "ride_start_01"
    local npc_geko_end = npc_geko_a
    Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
    WaitFrame(10)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
    local geko_index = GetIndex(NPC, npc_geko)
    Field.ObjectResetMotion(NPC, geko_index, 0)
    Obj:new(NPC, npc_geko):CancelInvisible()
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectLoadMotion(NPC, geko_index, "bn02")
    Field.ObjectLoadMotion(NPC, geko_index, "ba01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e017")
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, start_pos.x, start_pos.y, start_pos.z)
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot, 0)
    local vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 165)
    local aim_x = geko_pos.x + vector2d.x * 2
    local aim_y = geko_pos.y + 0.05
    local aim_z = geko_pos.z + vector2d.z * 2
    local vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot + 145)
    local cam_x = player_pos.x + vector2d.x * 1.1
    local cam_y = player_pos.y + 1.55
    local cam_z = player_pos.z + vector2d.z * 1.1
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 0)
    Field.ObjectPlayMotion(NPC, geko_index, "bn02", 10, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0701_0010_0340")
    tlk:Message("f_d0701_0010_0350")
    tlk:Select(2, "f_d0701_0010_0360")
    Field.ObjectPlayMotion(NPC, geko_index, "fe01", 10, true)
    tlk:Message("f_d0701_0010_0370")
    tlk:Message("f_d0701_0010_0380")
    tlk:Message("f_d0701_0010_0390")
    tlk:Message("f_d0701_0010_0400")
    tlk:Message("f_d0701_0010_0410")
    tlk:EndTalk()
    SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
    Cam.Inst:Clear(30)
    Obj:new(NPC, npc_geko):Invisible(30)
    Guest.Add(GST_GEKO)
    Field.CheckSyncFollower()
  end
end

function M360:Event_048()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_14_042", "FLAG_MAIN_14_043") then
    Flg.Set("FLAG_MAIN_14_043")
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
    WaitFrame(10)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(1)
    local npc_geko = "npc_0003"
    local geko_index = GetIndex(NPC, npc_geko)
    local geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectLoadMotion(NPC, geko_index, "ba01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e017")
    Field.ObjectLoadMotion(PLAYER, 1, "bc01")
    Obj:new(NPC, "npc_0004"):Invisible()
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -11.463, -0.154, 15.889)
    local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot, 0)
    Cam.Inst:Set(-8.2, -0.98, 9.06, -11.9, 1.7, 17.95, default, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, 10)
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0702_0010_0030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
    tlk:Message("f_d0702_0010_0040")
    tlk:Select(2, "f_d0702_0010_0050")
    Field.ObjectPlayMotion(PLAYER, 1, "bc01", 10, false)
    WaitFrame(60)
    Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, false)
    Sound.PlayVoice("f_d0702_0010_0060")
    Talk.Message_Auto("f_d0702_0010_0060", 5)
    local vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
    PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    Obj:new(PLAYER, ""):Invisible(5)
    Obj:new(NPC, npc_geko):Invisible(5)
    BackFade_Out(FADE_BLACK, 10)
    WaitFrame(10)
    Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, -6.586, -0.11, -66.806)
    local npc_geko = "npc_0004"
    local geko_index = GetIndex(NPC, npc_geko)
    Field.ObjectLoadMotion(NPC, geko_index, "bn01")
    Field.ObjectLoadMotion(NPC, geko_index, "ba01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe01")
    Field.ObjectLoadMotion(NPC, geko_index, "fe04")
    player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    geko_pos = Field.ObjectGetPosition(NPC, geko_index)
    local obj1_to_obj2_rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, geko_pos.x, geko_pos.z)
    Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, obj1_to_obj2_rot, 0)
    PlayerLookAtObject(NPC, npc_geko)
    local obj2_to_obj1_rot = Field.GetAngleToTarget2D(geko_pos.x, geko_pos.z, player_pos.x, player_pos.z)
    Field.ObjectSetRotationY(NPC, geko_index, obj2_to_obj1_rot + 210, 0)
    vector2d = Field.GetUnitVector2D(obj2_to_obj1_rot + 210)
    Field.ObjectSetPos(OGIM, GetIndex(OGIM, "eff_geko_01"), geko_pos.x + vector2d.x * 1, geko_pos.y, geko_pos.z + vector2d.z * 1)
    Cam.Inst:Set(-4.4, 1.73, -67.34, -3.02, 4.6, -76.82, default, 0)
    BackFade_In(FADE_BLACK, 10)
    local vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
    PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    Cam.Inst:Set(-5.09, -1.43, -74.9, -6.32, 1.53, -65.44, default, 0)
    WaitFrame(5)
    Obj:new(PLAYER, ""):CancelInvisible(10)
    Obj:new(NPC, npc_geko):CancelInvisible(10)
    WaitFrame(30)
    Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, true)
    Obj:new(OGIM, "eff_geko_01"):CancelInvisible(5)
    WaitFrame(10)
    Field.ObjectPlayMotion(PLAYER, 1, "e017", 15, false)
    WaitFrame(10)
    tlk:Message("f_d0702_0010_0070")
    tlk:Message("f_d0702_0010_0080")
    tlk:EndTalk()
    Field.ObjectResetMotion(PLAYER, 1, 30)
    Obj:new(NPC, npc_geko):Invisible(30)
    Obj:new(OGIM, "eff_geko_01"):Invisible(30)
    SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    Flg.Set("FLAG_MAIN_14_044")
  end
end

function M360:Event_049()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_14_044", "FLAG_MAIN_14_050") then
    local tlk = Tlk:new("d07", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0702_0020_0010")
    Field.MovePlayerToRelativePosFrame(0, -1, 20)
    WaitFrame(20)
    tlk:EndTalk()
  end
end

function M360:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set("FLAG_MAIN_14_050")
    Flg.Set("FLAG_MAIN_14_060")
    Execute("m360_070")
    Execute("m360_080")
    Execute("m360_090")
    Guest.Delete(GST_GEKO)
    MapChangeWithTimePasses("d", 204, "start_00", EVENING)
  end
end

function M360:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_14_060", "FLAG_MAIN_15_010") then
    Flg.Set("FLAG_MAIN_15_010")
    Execute("m360_100")
    Execute("m360_110")
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    local org_prefix = "d"
    local org_number = 202
    local org_locator = "start_50"
    local org_time_zone = evening
    Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
    MapChangeWithTimeTravel("t", 3001, "start_01", AXIS_ORIGINAL, "P2028_daft_360", NIGHT)
  end
end

function M360:Event_065()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_15_010", "FLAG_MAIN_15_040") then
    Execute("m360_120")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_MAIN_15_015")
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M360:Event_068()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    Flg.Set("FLAG_MAIN_15_040")
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M360:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) then
    Flg.Set("FLAG_MAIN_15_050")
    Execute("m360_130")
    Qst.Main:End(self.ID, self.STEP_255)
    WaitFrame(30)
    M390:Event_005()
  end
end

function M360:ChapterFlagSet(progress)
  local step = {}
  if 1 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 10 <= progress then
    step[#step + 1] = self.STEP_003
  end
  if 37 <= progress then
    Flg.Set("FLAG_GIMMICK_D01_010")
    Flg.Clear("FLAG_GIMMICK_D01_011")
  end
  if 38 <= progress then
    Flg.Clear("FLAG_GIMMICK_D01_010")
    Flg.Set("FLAG_GIMMICK_D01_011")
  end
  if 40 <= progress then
    Flg.Set("FLAG_GIMMICK_D01_010")
    Flg.Clear("FLAG_GIMMICK_D01_011")
  end
  if 50 <= progress then
    step[#step + 1] = self.STEP_005
  end
  if 63 <= progress then
    Flg.Clear("FLAG_GIMMICK_D01_010")
    Flg.Set("FLAG_GIMMICK_D01_011")
  end
  if 130 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_015
  end
  Qst.Main:Chapter(step, self.ID)
end
