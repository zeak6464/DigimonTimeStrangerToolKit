gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  AddLoadList(FLD_OBJ_PLAYER, {
    "",
    motion = {
      "fg14_w02",
      "e003",
      "e004"
    },
    attach = {9},
    attach_motion = {
      {9, "e200"}
    }
  })
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 501 then
  elseif gMapNum == 503 then
    Guest.Add(27211)
    Common.SetGuestToWaitForRide(27211)
    Field.CheckSyncFollower()
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 501 then
  elseif gMapNum == 503 then
    local state = GetControlScriptExternalVariableString("state")
    if state == "start" then
      SetControlScriptExternalVariable("rail_move_dir", "Initialize")
      SetControlScriptExternalVariable("state", "Initialize")
      local num = tonumber(string.sub(col_name, -4))
      local move_loc = "ride_fly_" .. num
      EndRide(true, move_loc, 5)
      Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
    end
  else
    if gMapNum == 510 or 511 or not 512 then
    end
    if col_name == "evt_0002" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_0004" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_0003" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_0005" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 501 then
    if gim_id == 100 then
      Prcs_StartSeamlessJumpRide("gim_0001", "gim_0002", "advance", 101, "mid")
    elseif gim_id == 101 then
      Prcs_StartSeamlessJumpRide("gim_0002", "gim_0001", "return", 101, "mid")
    elseif gim_id == 110 then
      Prcs_StartSeamlessJumpRide("gim_0003", "gim_0004", "advance", 102, "mid")
    elseif gim_id == 111 then
      Prcs_StartSeamlessJumpRide("gim_0004", "gim_0003", "return", 102, "mid")
    end
  elseif gMapNum == 502 then
    if gim_id == 300 then
      if IsSettingRideDigimon(RIDE_JUMP) then
        StartRideJump(gim_loc, "ride_whip_0002", "sp_0001")
      end
    elseif gim_id == 301 then
      if IsSettingRideDigimon(RIDE_JUMP) then
        StartRideJump(gim_loc, "ride_whip_0001", "sp_0002")
      end
    elseif gim_id == 302 then
      if IsSettingRideDigimon(RIDE_JUMP) then
        StartRideJump(gim_loc, "ride_whip_0004", "sp_0003")
      end
    elseif gim_id == 303 and IsSettingRideDigimon(RIDE_JUMP) then
      StartRideJump(gim_loc, "ride_whip_0003", "sp_0004")
    end
    if gim_id == 100 then
      Prcs_StartSeamlessJumpRide("gim_0001", "gim_0002", "advance", 100, "mid")
    elseif gim_id == 101 then
      Prcs_StartSeamlessJumpRide("gim_0002", "gim_0001", "return", 100, "mid")
    elseif gim_id == 110 then
      Prcs_StartSeamlessJumpRide("gim_0003", "gim_0004", "advance", 110, "mid")
    elseif gim_id == 111 then
      Prcs_StartSeamlessJumpRide("gim_0004", "gim_0003", "return", 110, "mid")
    elseif gim_id == 120 then
      Prcs_StartSeamlessJumpRide("gim_0005", "gim_0006", "advance", 120, "mid")
    elseif gim_id == 121 then
      Prcs_StartSeamlessJumpRide("gim_0006", "gim_0005", "return", 120, "mid")
    end
  elseif gMapNum == 503 then
    if gim_id == 800 or gim_id == 805 then
      SetControlScriptExternalVariable("speed_switch", 10)
      Motion.Gimmick:PlayFinishedAnim("gim_0001", "e001")
      Motion.Gimmick:Play("gim_0002", "", true)
      Motion.Gimmick:Play("gim_0003", "", true)
      Motion.Gimmick:Play("gim_0004", "", true)
      Motion.Gimmick:Play("gim_0005", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0006", "e001")
      Motion.Gimmick:Play("gim_0007", "", true)
      Motion.Gimmick:Play("gim_0008", "", true)
      Motion.Gimmick:Play("gim_0009", "", true)
      Motion.Gimmick:Play("gim_0010", "", true)
    elseif gim_id == 801 or gim_id == 806 then
      SetControlScriptExternalVariable("speed_switch", 20)
      Motion.Gimmick:Play("gim_0001", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0002", "e001")
      Motion.Gimmick:Play("gim_0003", "", true)
      Motion.Gimmick:Play("gim_0004", "", true)
      Motion.Gimmick:Play("gim_0005", "", true)
      Motion.Gimmick:Play("gim_0006", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0007", "e001")
      Motion.Gimmick:Play("gim_0008", "", true)
      Motion.Gimmick:Play("gim_0009", "", true)
      Motion.Gimmick:Play("gim_0010", "", true)
    elseif gim_id == 802 or gim_id == 807 then
      SetControlScriptExternalVariable("speed_switch", 30)
      Motion.Gimmick:Play("gim_0001", "", true)
      Motion.Gimmick:Play("gim_0002", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0003", "e001")
      Motion.Gimmick:Play("gim_0004", "", true)
      Motion.Gimmick:Play("gim_0005", "", true)
      Motion.Gimmick:Play("gim_0006", "", true)
      Motion.Gimmick:Play("gim_0007", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0008", "e001")
      Motion.Gimmick:Play("gim_0009", "", true)
      Motion.Gimmick:Play("gim_0010", "", true)
    elseif gim_id == 803 or gim_id == 808 then
      SetControlScriptExternalVariable("speed_switch", 40)
      Motion.Gimmick:Play("gim_0001", "", true)
      Motion.Gimmick:Play("gim_0002", "", true)
      Motion.Gimmick:Play("gim_0003", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e001")
      Motion.Gimmick:Play("gim_0005", "", true)
      Motion.Gimmick:Play("gim_0006", "", true)
      Motion.Gimmick:Play("gim_0007", "", true)
      Motion.Gimmick:Play("gim_0008", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0009", "e001")
      Motion.Gimmick:Play("gim_0010", "", true)
    elseif gim_id == 804 or gim_id == 809 then
      SetControlScriptExternalVariable("speed_switch", 50)
      Motion.Gimmick:Play("gim_0001", "", true)
      Motion.Gimmick:Play("gim_0002", "", true)
      Motion.Gimmick:Play("gim_0003", "", true)
      Motion.Gimmick:Play("gim_0004", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0005", "e001")
      Motion.Gimmick:Play("gim_0006", "", true)
      Motion.Gimmick:Play("gim_0007", "", true)
      Motion.Gimmick:Play("gim_0008", "", true)
      Motion.Gimmick:Play("gim_0009", "", true)
      Motion.Gimmick:PlayFinishedAnim("gim_0010", "e001")
    end
    if 900 <= gim_id then
      if gim_id == 900 or gim_id == 901 then
        SetControlScriptExternalVariable("rail_set", "rail_01")
      elseif gim_id == 902 or gim_id == 903 then
        SetControlScriptExternalVariable("rail_set", "rail_02")
      elseif gim_id == 904 or gim_id == 905 then
        SetControlScriptExternalVariable("rail_set", "rail_03")
      elseif gim_id == 906 or gim_id == 907 then
        SetControlScriptExternalVariable("rail_set", "rail_04")
      elseif gim_id == 908 or gim_id == 909 then
        SetControlScriptExternalVariable("rail_set", "rail_05")
      elseif gim_id == 910 or gim_id == 911 then
        SetControlScriptExternalVariable("rail_set", "rail_06")
      end
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field.PlayerScriptDigimonRideStartWithWaitingDigimon(true, gim_loc, 10)
      while Field.IsPlayerDigimonRideGettingOnAndOff() do
        WaitFrame(1)
      end
      if gim_id % 2 ~= 0 then
        SetControlScriptExternalVariable("rail_move_dir", "backward")
      else
        SetControlScriptExternalVariable("rail_move_dir", "forward")
      end
    end
  elseif gMapNum == 504 then
    if gim_id == 200 then
      if IsSettingRideDigimon(RIDE_JUMP) then
        StartRideJump(gim_loc, "ride_whip_0002", "whip_0001")
      end
    elseif gim_id == 201 and IsSettingRideDigimon(RIDE_JUMP) then
      StartRideJump(gim_loc, "ride_whip_0001", "whip_0002")
    end
    if gim_id == 202 and IsSettingRideDigimon(RIDE_FALL) then
      StartRideFall(gim_loc, "ride_fall_0002", "h", 504, 1)
    end
  elseif gMapNum == 505 then
    if gim_id == 200 then
      if IsSettingRideDigimon(RIDE_JUMP) then
        StartRideJump(gim_loc, "ride_whip_0002", "whip_0001")
      end
    elseif gim_id == 201 then
      if IsSettingRideDigimon(RIDE_JUMP) then
        StartRideJump(gim_loc, "ride_whip_0001", "whip_0002")
      end
    elseif gim_id == 202 then
      if IsSettingRideDigimon(RIDE_JUMP) then
        StartRideJump(gim_loc, "ride_whip_0004", "whip_0003")
      end
    elseif gim_id == 203 and IsSettingRideDigimon(RIDE_JUMP) then
      StartRideJump(gim_loc, "ride_whip_0003", "whip_0004")
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 510 or gMapNum == 511 or gMapNum == 512 or gMapNum == 513 then
    if gim_name == "log_message" then
      HazamaMessage(tonumber(gim_tag), gim_index)
    elseif gim_name == "way_out" then
      PlayerLookAtGimmickObject(gim_name)
      HazamaWayout(gim_name)
    end
  end
  if gMapNum == 510 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(950)
    end
  elseif gMapNum == 511 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(951)
    end
  elseif gMapNum == 512 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(952)
    end
  elseif gMapNum == 513 then
    if gim_name == "control_panel" then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(953)
    end
  elseif gMapNum == 520 then
    if gim_name == "talkpoint_ceres" then
      require("S900_217")
      S900_217:Event_090()
    end
    if gim_name == "way_out" then
      PlayerLookAtGimmickObject(gim_name)
      HazamaWayout(gim_name)
    end
  end
end

function OnCheckActModel(act)
end
