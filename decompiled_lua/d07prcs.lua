gGimText = "field_text"

function Prcs_d0701_RideFly(start_loc, landing_loc)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
  local landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc))
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  Field.ObjectSetPos(FLD_OBJ_PLAYER, 1, landing_pos.x, landing_pos.y, landing_pos.z)
  Field.ObjectResetMotion(PLAYER, 1, 10)
  WaitFrame(15)
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d07_GekoWarp(map_id, start_loc, landing_loc1, landing_loc2)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
  local message1 = 0
  local message2 = 0
  local message3 = 0
  local message4 = 0
  local message5 = 0
  local message6_1 = 0
  local message6_2 = 0
  local correct_flag = 0
  local correct_warp = 0
  local select_warp = 0
  local cam_rot = 0
  local cam_rot_a = 0
  local cam_rot_b = 0
  local npc_geko, npc_geko_a, npc_geko_b, npc_geko_end
  if map_id == 701 and start_loc == "ride_start_01" then
    message1 = "f_d0701_0070_0010"
    message2 = "f_d0701_0070_0020"
    message3 = "f_d0701_0070_0030"
    message4 = "f_d0701_0070_0040"
    message5 = "f_d0701_0070_0050"
    message6_1 = "f_d0701_0070_0060"
    message6_2 = "f_d0701_0070_0061"
    correct_flag = "FLAG_GIMMICK_D07_010"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 210
    npc_geko = "npc_1000"
    npc_geko_a = "npc_1001"
    npc_geko_b = "npc_1002"
  elseif map_id == 701 and start_loc == "ride_start_02" then
    message1 = "f_d0701_0080_0010"
    message2 = "f_d0701_0080_0020"
    message3 = "f_d0701_0080_0030"
    message4 = "f_d0701_0080_0040"
    message5 = "f_d0701_0080_0050"
    message6_1 = "f_d0701_0080_0060"
    message6_2 = "f_d0701_0080_0061"
    correct_flag = "FLAG_GIMMICK_D07_020"
    correct_warp = 0
    cam_rot_a = 210
    cam_rot_b = 180
    npc_geko = "npc_1003"
    npc_geko_a = "npc_1004"
    npc_geko_b = "npc_1005"
  elseif map_id == 701 and start_loc == "ride_start_03" then
    message1 = "f_d0701_0090_0010"
    message2 = "f_d0701_0090_0020"
    message3 = "f_d0701_0090_0030"
    message4 = "f_d0701_0090_0040"
    message5 = "f_d0701_0090_0050"
    message6_1 = "f_d0701_0090_0060"
    message6_2 = "f_d0701_0090_0061"
    correct_flag = "FLAG_GIMMICK_D07_030"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1006"
    npc_geko_a = "npc_1007"
    npc_geko_b = "npc_1008"
  elseif map_id == 701 and start_loc == "ride_start_04" then
    message1 = "f_d0701_0100_0010"
    message2 = "f_d0701_0100_0020"
    message3 = "f_d0701_0100_0030"
    message4 = "f_d0701_0100_0040"
    message5 = "f_d0701_0100_0050"
    message6_1 = "f_d0701_0100_0060"
    message6_2 = "f_d0701_0100_0061"
    correct_flag = "FLAG_GIMMICK_D07_040"
    correct_warp = 1
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1009"
    npc_geko_a = "npc_1010"
    npc_geko_b = "npc_1011"
  elseif map_id == 701 and start_loc == "ride_start_05" then
    message1 = "f_d0701_0110_0010"
    message2 = "f_d0701_0110_0020"
    message3 = "f_d0701_0110_0020"
    message4 = "f_d0701_0110_0040"
    message5 = "f_d0701_0110_0050"
    message6_1 = "f_d0701_0110_0060"
    message6_2 = "f_d0701_0110_0061"
    correct_warp = 1
    cam_rot_a = 150
    cam_rot_b = 100
    npc_geko = "npc_1012"
    npc_geko_a = "npc_1013"
    npc_geko_b = "npc_1014"
  elseif map_id == 701 and start_loc == "ride_start_06" then
    message1 = "f_d0701_0120_0010"
    message2 = "f_d0701_0120_0020"
    message3 = "f_d0701_0120_0020"
    message4 = "f_d0701_0120_0040"
    message5 = "f_d0701_0120_0050"
    message6_1 = "f_d0701_0120_0060"
    message6_2 = "f_d0701_0120_0061"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 100
    npc_geko = "npc_1015"
    npc_geko_a = "npc_1016"
    npc_geko_b = "npc_1017"
  elseif map_id == 701 and start_loc == "ride_start_07" then
    message1 = "f_d0701_0130_0010"
    message2 = "f_d0701_0130_0020"
    message3 = "f_d0701_0130_0020"
    message4 = "f_d0701_0130_0040"
    message5 = "f_d0701_0130_0050"
    message6_1 = "f_d0701_0120_0060"
    message6_2 = "f_d0701_0120_0061"
    correct_flag = "FLAG_GIMMICK_D07_120"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1018"
    npc_geko_a = "npc_1016"
    npc_geko_b = "npc_1010"
  elseif map_id == 703 and start_loc == "ride_start_01" then
    message1 = "f_d0703_0140_0010"
    message2 = "f_d0703_0140_0020"
    message3 = "f_d0703_0140_0030"
    message4 = "f_d0703_0140_0040"
    message5 = "f_d0703_0140_0050"
    message6_1 = "f_d0703_0140_0060"
    message6_2 = "f_d0703_0140_0061"
    correct_flag = "FLAG_GIMMICK_D07_050"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1000"
    npc_geko_a = "npc_1001"
    npc_geko_b = "npc_1002"
  elseif map_id == 703 and start_loc == "ride_start_02" then
    message1 = "f_d0703_0150_0010"
    message2 = "f_d0703_0150_0020"
    message3 = "f_d0703_0150_0030"
    message4 = "f_d0703_0150_0040"
    message5 = "f_d0703_0150_0050"
    message6_1 = "f_d0703_0150_0060"
    message6_2 = "f_d0703_0150_0061"
    correct_flag = "FLAG_GIMMICK_D07_060"
    correct_warp = 1
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1003"
    npc_geko_a = "npc_1004"
    npc_geko_b = "npc_1005"
  elseif map_id == 703 and start_loc == "ride_start_03" then
    message1 = "f_d0703_0160_0010"
    message2 = "f_d0703_0160_0020"
    message3 = "f_d0703_0160_0030"
    message4 = "f_d0703_0160_0040"
    message5 = "f_d0703_0160_0050"
    message6_1 = "f_d0703_0160_0060"
    message6_2 = "f_d0703_0160_0061"
    correct_flag = "FLAG_GIMMICK_D07_070"
    correct_warp = 0
    cam_rot_a = 250
    cam_rot_b = 150
    npc_geko = "npc_1006"
    npc_geko_a = "npc_1007"
    npc_geko_b = "npc_1008"
  elseif map_id == 703 and start_loc == "ride_start_04" then
    message1 = "f_d0703_0170_0010"
    message2 = "f_d0703_0170_0020"
    message3 = "f_d0703_0170_0030"
    message4 = "f_d0703_0170_0040"
    message5 = "f_d0703_0170_0050"
    message6_1 = "f_d0703_0170_0060"
    message6_2 = "f_d0703_0170_0061"
    correct_flag = "FLAG_GIMMICK_D07_090"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1009"
    npc_geko_a = "npc_1010"
    npc_geko_b = "npc_1011"
  elseif map_id == 703 and start_loc == "ride_start_05" then
    message1 = "f_d0703_0180_0010"
    message2 = "f_d0703_0180_0020"
    message3 = "f_d0703_0180_0030"
    message4 = "f_d0703_0180_0040"
    message5 = "f_d0703_0180_0050"
    message6_1 = "f_d0703_0180_0060"
    message6_2 = "f_d0703_0180_0061"
    correct_flag = "FLAG_GIMMICK_D07_100"
    correct_warp = 1
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1012"
    npc_geko_a = "npc_1013"
    npc_geko_b = "npc_1014"
  elseif map_id == 703 and start_loc == "ride_start_06" then
    message1 = "f_d0703_0190_0010"
    message2 = "f_d0703_0190_0020"
    message4 = "f_d0703_0190_0040"
    message5 = "f_d0703_0190_0050"
    message6_1 = "f_d0703_0190_0060"
    message6_2 = "f_d0703_0190_0061"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1015"
    npc_geko_a = "npc_1016"
    npc_geko_b = "npc_1017"
  elseif map_id == 703 and start_loc == "ride_start_07" then
    message1 = "f_d0703_0200_0010"
    message2 = "f_d0703_0200_0020"
    message4 = "f_d0703_0200_0040"
    message5 = "f_d0703_0200_0050"
    message6_1 = "f_d0703_0200_0060"
    message6_2 = "f_d0703_0200_0061"
    correct_warp = 1
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1018"
    npc_geko_a = "npc_1019"
    npc_geko_b = "npc_1020"
  elseif map_id == 703 and start_loc == "ride_start_08" then
    message1 = "f_d0703_0210_0010"
    message2 = "f_d0703_0210_0020"
    message4 = "f_d0703_0210_0040"
    message5 = "f_d0703_0210_0050"
    message6_1 = "f_d0703_0210_0060"
    message6_2 = "f_d0703_0210_0061"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1021"
    npc_geko_a = "npc_1022"
    npc_geko_b = "npc_1023"
  elseif map_id == 703 and start_loc == "ride_start_09" then
    message1 = "f_d0703_0220_0010"
    message2 = "f_d0703_0220_0020"
    message4 = "f_d0703_0220_0040"
    message5 = "f_d0703_0220_0050"
    message6_1 = "f_d0703_0220_0060"
    message6_2 = "f_d0703_0220_0061"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 30
    npc_geko = "npc_1024"
    npc_geko_a = "npc_1025"
    npc_geko_b = "npc_1026"
  elseif map_id == 703 and start_loc == "ride_start_10" then
    message1 = "f_d0703_0230_0010"
    message2 = "f_d0703_0230_0020"
    message4 = "f_d0703_0230_0040"
    message5 = "f_d0703_0230_0050"
    message6_1 = "f_d0703_0230_0060"
    message6_2 = "f_d0703_0230_0061"
    correct_warp = 1
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1027"
    npc_geko_a = "npc_1028"
    npc_geko_b = "npc_1029"
  elseif map_id == 703 and start_loc == "ride_start_11" then
    message1 = "f_d0703_0240_0010"
    message2 = "f_d0703_0240_0020"
    message4 = "f_d0703_0240_0040"
    message5 = "f_d0703_0240_0050"
    message6_1 = "f_d0703_0240_0060"
    message6_2 = "f_d0703_0240_0061"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1030"
    npc_geko_a = "npc_1028"
    npc_geko_b = "npc_1029"
  elseif map_id == 703 and start_loc == "ride_start_12" then
    message1 = "f_d0703_0250_0010"
    message2 = "f_d0703_0250_0020"
    message4 = "f_d0703_0250_0040"
    message5 = "f_d0703_0250_0050"
    message6_1 = "f_d0703_0250_0060"
    message6_2 = "f_d0703_0250_0061"
    correct_warp = 0
    cam_rot_a = 150
    cam_rot_b = 150
    npc_geko = "npc_1032"
    npc_geko_a = "npc_1022"
    npc_geko_b = "npc_1023"
  end
  if Flg.Check("FLAG_MAIN_15_015") then
    message1 = "f_d0701_0150_0010"
  end
  Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
  WaitFrame(10)
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
  tlk:StartTalk()
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, geko_index, "ba01", 10, 10)
  tlk:Message(message1)
  Field.ObjectPlayMotion(NPC, geko_index, "fe01", 10, true)
  local landing_pos = 0
  local result = 0
  if map_id == 701 then
    if start_loc == "ride_start_01" or start_loc == "ride_start_02" or start_loc == "ride_start_03" or start_loc == "ride_start_04" then
      if Flg.Check(correct_flag) then
        result = tlk:Select(3, message3)
      else
        result = tlk:Select(3, message2)
      end
    else
      result = tlk:Select(3, message2)
    end
  elseif map_id == 703 then
    if start_loc == "ride_start_01" or start_loc == "ride_start_02" or start_loc == "ride_start_03" or start_loc == "ride_start_04" or start_loc == "ride_start_05" then
      if Flg.Check(correct_flag) then
        result = tlk:Select(3, message3)
      else
        result = tlk:Select(3, message2)
      end
    elseif start_loc == "ride_start_11" then
      result = tlk:Select(2, message2)
    else
      result = tlk:Select(3, message2)
    end
  end
  if result == RESULT_TALK00 then
    landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc1))
    if map_id == 701 then
      if start_loc == "ride_start_01" then
        Flg.Set(correct_flag)
      end
      if start_loc == "ride_start_02" then
        Flg.Set(correct_flag)
      end
      if start_loc == "ride_start_03" then
        Flg.Set(correct_flag)
      end
      if start_loc == "ride_start_07" then
        Flg.Set(correct_flag)
      end
    elseif map_id == 703 then
      if start_loc == "ride_start_01" then
        Flg.Set(correct_flag)
      elseif start_loc == "ride_start_03" then
        Flg.Set(correct_flag)
      elseif start_loc == "ride_start_04" then
        Flg.Set(correct_flag)
      end
    end
    npc_geko_end = npc_geko_a
    cam_rot = cam_rot_a
    select_warp = RESULT_TALK00
  elseif result == RESULT_TALK01 then
    landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc2))
    if map_id == 701 then
      if start_loc == "ride_start_04" then
        Flg.Set(correct_flag)
      end
    elseif map_id == 703 then
      if start_loc == "ride_start_02" then
        Flg.Set(correct_flag)
      elseif start_loc == "ride_start_05" then
        Flg.Set(correct_flag)
      elseif start_loc == "ride_start_11" then
        tlk:EndTalk()
        Obj:new(NPC, npc_geko):Invisible(30)
        SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
        Cam.Inst:Clear(30)
        Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
        Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
        return
      end
    end
    npc_geko_end = npc_geko_b
    cam_rot = cam_rot_b
    select_warp = RESULT_TALK01
  else
    tlk:EndTalk()
    Obj:new(NPC, npc_geko):Invisible(30)
    SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
    Cam.Inst:Clear(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    return
  end
  Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "bc01", 10, 10)
  WaitFrame(15)
  Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, false)
  Sound.PlayVoice("f_d0701_0070_0050")
  Talk.Message_Auto(message5, 5)
  WaitFrame(30)
  vector2d = Field.GetUnitVector2D(obj1_to_obj2_rot)
  PlayEffectScript("ef_f_mov_111_wa", player_pos.x + vector2d.x, player_pos.y + 1, player_pos.z + vector2d.z, 0, 1)
  PlaySE(200006, 100)
  WaitFrame(20)
  Obj:new(PLAYER, ""):Invisible(5)
  Obj:new(NPC, npc_geko):Invisible(5)
  WaitFrame(30)
  if map_id == 701 and start_loc == "ride_start_07" then
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Flg.Set("FLAG_FIELD_D07_010")
      MapChange("d", 703, "start_00", true, FADE_BLACK, FADE_TIME)
    end
  elseif map_id == 703 and start_loc == "ride_start_11" then
    tlk:EndTalk()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Flg.Set("FLAG_FIELD_D07_010")
    MapChange("d", 701, "start_02", true, FADE_BLACK, FADE_TIME)
  end
  Fade_OutNoLoadingWithWait(FADE_BLACK, 10)
  WaitFrame(10)
  Talk.Close()
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
  FadeInWithWaitNotFlgCheck(FADE_BLACK, 10)
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
  if correct_warp == select_warp then
  else
    tlk:Message(message6_1)
  end
  Field.ObjectPlayMotion(NPC, geko_index, "fe04", 10, true)
  Obj:new(OGIM, "eff_geko_01"):CancelInvisible(5)
  WaitFrame(10)
  Field.ObjectPlayMotion(PLAYER, 1, "e017", 15, false)
  WaitFrame(10)
  if correct_warp == select_warp then
  else
  end
  WaitFrame(20)
  tlk:EndTalk()
  Field.ObjectResetMotion(PLAYER, 1, 30)
  Obj:new(NPC, npc_geko_end):Invisible(30)
  Obj:new(OGIM, "eff_geko_01"):Invisible(30)
  SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
  Cam.Inst:Clear(30)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d07_GekoWarpMapChange(map_id, landing_loc)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  local npc_geko
  local cam_rot = 0
  local message1 = 0
  if map_id == 701 and landing_loc == "ride_landing_08" then
    npc_geko = "npc_1019"
    cam_rot = 150
    message1 = "f_d0701_0140_0010"
  elseif map_id == 703 and landing_loc == "ride_landing_12" then
    npc_geko = "npc_1031"
    cam_rot = 150
    message1 = "f_d0703_0130_0010"
  end
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
  tlk:StartTalk()
  tlk:Message(message1)
  tlk:EndTalk()
  Field.ObjectResetMotion(PLAYER, 1, 30)
  Obj:new(NPC, npc_geko):Invisible(30)
  Obj:new(OGIM, "eff_geko_01"):Invisible(30)
  SetFollowerCameraOperateRotation(0, obj1_to_obj2_rot, 0)
  Cam.Inst:Clear(30)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d0701_RideFlyMapChange(start_loc, landing_loc, map_id, mapstart_loc)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  local start_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, start_loc))
  local landing_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, landing_loc))
  MapChange("d", map_id, mapstart_loc, false, 0, 15)
end

function Prcs_d0702_ThroughDoor()
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Cam.Inst:Set(0.049, 10.487, -93.095, 0.067, 9.507, -83.143, default, 40)
  WaitFrame(15)
  Motion.Gimmick:Play("gim_0001", "e001", false)
  WaitFrame(25)
  ColOff("wall_cl_0004")
  WaitFrame(5)
  local se_slot = PlaySE(201009, 100)
  WaitFrame(190)
  StopSE(se_slot, 30)
  PlaySE(201019, 100)
  WaitFrame(40)
  M360:Event_020()
  M360:Event_050()
  WaitFrame(10)
  Cam.Inst:Clear(40)
  WaitFrame(20)
  SetEnableGimmickCheck("gim_0001", false)
  ColOff("evt_9001")
  Flg.Set("FLAG_GIMMICK_D07_080")
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d07_EndRideFly(move_loc, cl_name)
  require("r01_020")
  Flg.Clear("FLAG_IS_FLIGHT_RIDE")
  ColOff(cl_name)
  r01_020(move_loc)
  ColOn(cl_name)
  Field.FollowerWarp()
  EndRide(true, move_loc, 30)
  SetControlScriptExternalVariable("fly_state", "Initialize")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(false)
end

function Prcs_d07_StartRideFly(start_loc, move_loc, gim_loc, cl_name)
  Field.MovePlayerToLocatorFrame(start_loc, 30)
  WaitFrame(30)
  SetPlayerRotationByLocator(start_loc, 10)
  Field.PlayerScriptDigimonRideStartFromID(721, true, "", 10)
  Field.PlayerFixedMaxSpeed(10)
  while Field.IsPlayerDigimonRideGettingOnAndOff() do
    WaitFrame(Util.SecondFromFrame(1))
  end
  require("r01_010")
  WaitFrame(15)
  ColOff(cl_name)
  r01_010(move_loc)
  ColOn(cl_name)
  Guest.Add(27211)
  Field.CheckSyncFollower()
end

function Prcs_d0701_StartRideFly(start_loc, move_loc, gim_loc, cl_name)
  Field.MovePlayerToLocatorFrame(start_loc, 30)
  WaitFrame(30)
  SetPlayerRotationByLocator(start_loc, 10)
  StartRideFly(true, gim_loc, 10)
  require("r01_010")
  WaitFrame(15)
  ColOff(cl_name)
  r01_010(move_loc)
  ColOn(cl_name)
  Field.CheckSyncFollower()
  SetControlScriptExternalVariable("fly_state", "start")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(true)
end

function Prcs_d0702_StartRideFly(start_loc, move_loc, gim_loc, cl_name)
  Field.MovePlayerToLocatorFrame(start_loc, 30)
  WaitFrame(30)
  SetPlayerRotationByLocator(start_loc, 10)
  StartRideFly(true, gim_loc, 10)
  require("r01_010")
  WaitFrame(15)
  ColOff(cl_name)
  r01_010(move_loc)
  ColOn(cl_name)
  MovePlayerFrame(185, 6, 200)
  Cam.Inst:Set(-11.3, -3.5, 51.6, -9.7, -3, 41.8, default, 150)
  WaitFrame(55)
  SetControlScriptExternalVariable("fly_state", "start")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(true)
  MapChange("d", 701, "start_02", true, 0, 30)
end

function Prcs_d0703_StartRideFly(start_loc, move_loc, gim_loc, cl_name)
  SetControlScriptExternalVariable("mapchange_event", "start")
  Field.MovePlayerToLocatorFrame(start_loc, 30)
  WaitFrame(30)
  SetPlayerRotationByLocator(start_loc, 10)
  StartRideFly(true, gim_loc, 10)
  require("r01_010")
  WaitFrame(15)
  ColOff(cl_name)
  r01_010(move_loc)
  ColOn(cl_name)
  MovePlayerFrame(185, 6, 200)
  Cam.Inst:Set(-27.2, 5.6, 129.6, -28, 6.3, 119.7, default, 150)
  WaitFrame(55)
  SetControlScriptExternalVariable("fly_state", "start")
  Field.SetEnableEffectCausedByPlayerCollidingWithWall(true)
  MapChange("d", 701, "start_02", true, 0, 30)
end

function test_accel(PLAYER_SPEED)
  if PLAYER_SPEED <= 15.5 then
    Field.PlayerFixedMaxSpeed(PLAYER_SPEED + 1.2)
  end
end

function test_slowdown(PLAYER_SPEED)
  if 10 <= PLAYER_SPEED then
    Field.PlayerFixedMaxSpeed(PLAYER_SPEED - 1)
  else
    Field.PlayerFixedMaxSpeed(10)
    ACCEL_FRAME = 0
    SetControlScriptExternalVariable("accel_state", "end")
  end
end

function test_wait()
  WaitFrame(15)
end
