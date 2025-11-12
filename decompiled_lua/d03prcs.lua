gGimText = "field_text"

function Prcs_d0301_CallWhamon_01()
  Field.MovePlayerToLocatorFrame("change_0001", 10)
  WaitFrame(10)
  SetPlayerRotationByLocator("change_0001", 10)
  Cam.Inst:Set(-25, 5, 35.2, -19.7, 4.2, 43.6, default, 30)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  if not Flg.Check("FLAG_IS_COMING_WHAMON") then
    Motion.NPC:Play("npc_0001", "f000", 0, false)
    local npc_0001 = Obj:new(NPC, "npc_0001")
    npc_0001:CancelInvisible()
    WaitFrame(45)
    Motion.NPC:Play("npc_0001", "f001", 10, true)
    Flg.Set("FLAG_IS_COMING_WHAMON")
  end
  Field_Talk_Start(gGimText, 1)
  Message(1030100000)
  MessageTalkSel(3, 1030100020)
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Motion.NPC:Play("npc_0001", "f004", 10, false)
    WaitFrame(50)
    Field_Talk_End()
    MovePlayerFrame(0, 2, 30)
    FadeOutWithWait(0, 20)
    Flg.Set("FLAG_AREACHANGE_WITH_WHAMON")
    Flg.Clear("FLAG_IS_COMING_WHAMON")
    MapChange("d", 303, "start_00", false, -1, -1)
  elseif result == RESULT_TALK01 then
    Motion.NPC:Play("npc_0001", "f004", 10, false)
    WaitFrame(50)
    Field_Talk_End()
    MovePlayerFrame(0, 2, 30)
    FadeOutWithWait(0, 20)
    Flg.Set("FLAG_AREACHANGE_WITH_WHAMON")
    Flg.Clear("FLAG_IS_COMING_WHAMON")
    MapChange("d", 304, "start_03", false, -1, -1)
  elseif result == RESULT_TALK02 then
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
    Field_Talk_End()
  end
  Cam.Inst:Clear(30)
end

function Prcs_d0301_CallWhamon_02()
  if not Flg.Check("FLAG_GIMMICK_D03_340") then
    Field_Talk_Start("d03", 1)
    Message("f_d0301_0080_0010")
    MessageClose()
    MessageTalkSel(2, "f_d0301_0080_0020")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Field_Talk_End()
      M170:Event_110()
      Flg.Set("FLAG_IS_COMING_WHAMON")
      Motion.NPC:Play("npc_0008", "f004", 10, false)
      WaitFrame(50)
      Flg.Set("FLAG_GIMMICK_D03_340")
      Flg.Set("FLAG_AREACHANGE_WITH_WHAMON")
      Flg.Clear("FLAG_IS_COMING_WHAMON")
      MapChange("d", 303, "start_00", false, -1, -1)
    else
      Field_Talk_End()
    end
  else
    Field_Talk_Start_Not_LetterBox("d03", 1)
    if not Flg.Check("FLAG_IS_COMING_WHAMON") then
      Message("f_d0301_0080_0010")
      MessageClose()
      MessageTalkSel(2, "f_d0301_0080_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        SetPlayerRotationByLocator("change_0002", 10)
        Cam.Inst:Set(-6.8, 4.6, 10, 2.2, 3.8, 14.1, default, 30)
        Field_InvisibleFollowerAllPartyMember(0, 30, false)
        if not Flg.Check("FLAG_IS_COMING_WHAMON") then
          local pc = Obj:new(PLAYER, "")
          local pc_fn01_01 = Motion.Object:new(pc.type, pc.name, "fn01_01")
          local pc_e212 = Motion.Object:new(pc.type, pc.name, "e212")
          local pc_e213 = Motion.Object:new(pc.type, pc.name, "e213")
          Field.ObjectLoadAttachment(pc.type, pc.index, 15)
          Field.ObjectShowAttachment(pc.type, pc.index, 15)
          pc_e213:Play(10, false)
          WaitFrame(35)
          local slot_1 = Sound.PlaySE(401036, 100)
          WaitFrame(40)
          Sound.StopSE(slot_1, 1)
          WaitFrame(30)
          pc_e212:Play(10, false)
          WaitFrame(10)
          Field.ObjectHideAttachment(pc.type, pc.index, 15)
          pc_fn01_01:Play(10, true)
          local npc_0008 = Obj:new(NPC, "npc_0008")
          local npc_index = GetIndex(NPC, "npc_0008")
          local pos = Field.ObjectGetPosition(NPC, npc_index)
          local rot = Field.ObjectGetRotationY(NPC, npc_index)
          local slot_2 = Sound.PlaySE(403059, 100)
          Field.PlayEffectScript("ef_e_com_105", pos.x, pos.y, pos.z, rot + 180, 1.5)
          WaitFrame(10)
          Motion.NPC:Play("npc_0008", "f000", 0, false)
          npc_0008:CancelInvisible()
          WaitFrame(50)
          Sound.StopSE(slot_2, 1)
          Motion.NPC:Play("npc_0008", "f001", 10, true)
          Flg.Set("FLAG_IS_COMING_WHAMON")
        end
        Message("f_d0301_0080_0030")
        MessageClose()
        Motion.NPC:Play("npc_0008", "f004", 10, false)
        WaitFrame(50)
        FadeOutWithWait(0, 20)
        Flg.Set("FLAG_AREACHANGE_WITH_WHAMON")
        Flg.Clear("FLAG_IS_COMING_WHAMON")
        Field_Talk_End_Not_LetterBox()
        MapChange("d", 303, "start_00", false, -1, -1)
      else
        Field_Talk_End_Not_LetterBox()
      end
    else
      Message("f_d0301_0080_0040")
      MessageClose()
      MessageTalkSel(2, "f_d0301_0080_0050")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Message("f_d0301_0080_0060")
        Field_Talk_End_Not_LetterBox()
        Motion.NPC:Play("npc_0008", "f004", 10, false)
        WaitFrame(50)
        FadeOutWithWait(0, 20)
        Flg.Set("FLAG_AREACHANGE_WITH_WHAMON")
        Flg.Clear("FLAG_IS_COMING_WHAMON")
        MapChange("d", 303, "start_00", false, -1, -1)
      else
        Field_Talk_End_Not_LetterBox()
      end
    end
  end
  Cam.Inst:Clear(30)
end

function Prcs_d0301_CallSubmarimon(point, gim_loc)
  if Flg.Check("FLAG_MAIN_05_101") then
    WaitFrame(10)
    SetPlayerRotationByLocator(gim_loc, 5)
    if point == 1 or point == 5 then
      Field_Talk_Start("d03", 1)
      Message("f_d0301_0020_0020")
      MessageClose()
      MessageTalkSel(2, "f_d0301_0020_0030")
    else
      Field_Talk_Start("d03", 1)
      Message("f_d0301_0020_0010")
      MessageClose()
      MessageTalkSel(2, "f_d0301_0020_0030")
    end
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Field_Talk_End()
      FadeOutWithWait(0, 20)
      if point == 1 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON01")
        MapChange("d", 301, "start_95", false, -1, -1)
      elseif point == 2 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON02")
        MapChange("d", 303, "start_92", false, -1, -1)
      elseif point == 3 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON03")
        MapChange("d", 303, "start_94", false, -1, -1)
      elseif point == 4 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON04")
        MapChange("d", 303, "start_95", false, -1, -1)
      elseif point == 5 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON05")
        MapChange("d", 301, "start_91", false, -1, -1)
      end
    elseif result == RESULT_TALK01 then
      Field_Talk_End()
    end
  end
end

function Prcs_d0303_CallSubmarimon(point, gim_loc)
  if Flg.Check("FLAG_MAIN_05_101") then
    WaitFrame(10)
    SetPlayerRotationByLocator(gim_loc, 5)
    Field_Talk_Start("d03", 1)
    Message("f_d0303_0030_0010")
    MessageClose()
    MessageTalkSel(2, "f_d0303_0030_0020")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Field_Talk_End()
      FadeOutWithWait(0, 20)
      if point == 1 then
      elseif point == 2 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON02")
        MapChange("d", 301, "start_92", false, -1, -1)
      elseif point == 3 then
      elseif point == 4 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON03")
        MapChange("d", 301, "start_93", false, -1, -1)
      elseif point == 5 then
        Flg.Set("FLAG_FIELD_D03_SUBMARIMON04")
        MapChange("d", 301, "start_94", false, -1, -1)
      end
    elseif result == RESULT_TALK01 then
      Field_Talk_End()
    end
  end
end

function Prcs_d0301_EnterShellmonHouse(door_loc, move_in, set_loc)
  local fade = true
  if Flg.Check("FLAG_MAIN_05_101", "FLAG_MAIN_05_107") then
    fade = false
    MapChange("d", 308, "start_00", fade, 0, 15)
  else
    OpenDoor("gim_0005", "")
    DoorMapChange("d", 308, "start_00")
  end
end

function Prcs_d0302_WarpGim_01()
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  SetFollowerCameraOperateRotation(0, 270)
  Field.MovePlayerToLocatorFrame("gim_0002", 50)
  Cam.Inst:Set(-58.16, 26.11, 33.55, -48.81, 29.57, 32.8, default, 45)
  WaitFrame(45)
  Obj:new(PLAYER, ""):Invisible(10)
  Cam.Inst:Set(-70.91, 35.64, -1.26, -61.91, 36.65, -5.51, default, 80)
  WaitFrame(60)
  SetPlayerLocator("gim_0003")
  WaitFrame(10)
  Field.MovePlayerToLocatorFrame("gim_0005", 50)
  WaitFrame(10)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Cam.Inst:Clear(40)
  WaitFrame(40)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d0302_WarpGim_02()
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  SetFollowerCameraOperateRotation(0, 210)
  Field.MovePlayerToLocatorFrame("gim_0003", 40)
  Cam.Inst:Set(-69.78, 35.65, 7.62, -64.69, 35.79, -0.97, default, 50)
  WaitFrame(40)
  Obj:new(PLAYER, ""):Invisible(10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Cam.Inst:Set(-58.16, 26.11, 33.55, -48.81, 29.57, 32.8, default, 80)
  WaitFrame(60)
  SetPlayerLocator("gim_0002")
  WaitFrame(10)
  Field.MovePlayerToLocatorFrame("gim_0004", 65)
  WaitFrame(10)
  SetFollowerCameraOperateRotation(0, 270)
  Cam.Inst:Clear(60)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  WaitFrame(40)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d0302_GarudamonEvent()
  Execute("fld_d0302_garudamon_app")
  SetControlScriptExternalVariable("chr309_GetFly_state", "landing")
  FadeInWithWait(0, 30)
  ColOff("evt_9002")
  Flg.Set("FLAG_GIMMICK_D03_260")
  Flg.Set("FLAG_GIMMICK_D03_270")
  SetNpcTalkZoomCamera("chr309_GetFly", 0.3, 2, 60, 1)
  Field_Talk_Start("d03", 1)
  Message(110)
  MessageTalkSel(2, 113)
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    END_TALK_ACTION_AND_ZOOM("d0302", true, true)
    Field_Talk_End()
    EncountFromField(30302199, 10371, true)
  elseif result == RESULT_TALK01 then
    Message(112)
    END_TALK_ACTION_AND_ZOOM("d0302", true, true)
    Field_Talk_End()
  end
end

function Prcs_d0303_CallWhamon(locator_name)
  Field.MovePlayerToLocatorFrame(locator_name, 10)
  WaitFrame(10)
  SetPlayerRotationByLocator(locator_name, 10)
  if locator_name == "change_0001" then
    Cam.Inst:Set(-71.5, 17.5, -133.3, -66.3, 17.6, -124.7, default, 30)
  end
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  if not Flg.Check("FLAG_IS_COMING_WHAMON") then
    WaitFrame(20)
    Motion.NPC:Play("npc_0004", "f002", 0, false)
    local npc_0004 = Obj:new(NPC, "npc_0004")
    npc_0004:CancelInvisible(nil, true)
    WaitFrame(130)
    Motion.NPC:Play("npc_0004", "f003", 10, true)
    Flg.Set("FLAG_IS_COMING_WHAMON")
  end
  Field_Talk_Start_Not_LetterBox("d03", 1)
  Message("f_d0301_0080_0040")
  MessageClose()
  MessageTalkSel(2, "f_d0301_0080_0050")
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Message("f_d0301_0080_0060")
    Field_Talk_End_Not_LetterBox()
    Motion.NPC:Play("npc_0004", "f005", 10, false)
    WaitFrame(50)
    FadeOutWithWait(0, 20)
    Flg.Set("FLAG_AREACHANGE_WITH_WHAMON")
    Flg.Clear("FLAG_IS_COMING_WHAMON")
    MapChange("d", 301, "start_07", false, -1, -1)
  else
    Field_Talk_End_Not_LetterBox()
  end
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  Cam.Inst:Clear(30)
end

function Prcs_d0303_WaterFlowCol(is_on)
  if is_on == true then
    ColOn("wall_cl_0001")
    ColOn("wall_cl_0002")
    ColOn("wall_cl_0003")
    ColOn("wall_cl_0004")
    ColOn("wall_cl_0005")
    ColOn("wall_cl_0006")
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse01"), true)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse02"), true)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse03"), true)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse04"), true)
    if Flg.Check("FLAG_MAIN_05_100") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse01"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse02"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse03"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse04"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse05"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse05"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse06"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse06"), true)
    end
    SetEnableCameraOperate(true)
  else
    ColOff("wall_cl_0001")
    ColOff("wall_cl_0002")
    ColOff("wall_cl_0003")
    ColOff("wall_cl_0004")
    ColOff("wall_cl_0005")
    ColOff("wall_cl_0006")
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse01"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse01"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse02"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse02"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse03"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse03"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse04"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse04"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse05"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse05"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse06"), false)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse06"), false)
  end
end

function Prcs_d0303_WaterFlowStart(degree_y, rail_name, rail_direction, ride_start, ride_flag)
  local RideDegiID = 145
  local r_flame = 15
  SetControlScriptExternalVariable("ride_rail", rail_name)
  SetControlScriptExternalVariable("rail_direction", rail_direction)
  SetFollowerCameraOperateRotation(5, degree_y, r_flame)
  SetEnableCameraOperate(false)
  WaitFrame(r_flame)
  Prcs_d0303_WaterFlowCol(false)
  Flg.Set(ride_flag)
  if Flg.Check("FLAG_FIELD_D0303_110") then
    Field.PlayerScriptDigimonRideStartFromID(RideDegiID, true, ride_start, 5)
  else
    SetProhibitPlayerOnlyOperate(true)
    Field.CancelPlayerAnywhereDigimonRide(false, true)
    Motion.Player:ChangeMoveAnimWithBlend("flow", 15, 15)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    Field_InvisibleFollowerAllGuest(0, 10, false)
  end
  SetControlScriptExternalVariable("ride_submarimon", "riding")
  SetControlScriptExternalVariable("se_slot", se_slot)
  SetControlScriptExternalVariable("se_start_waterflow", "start")
end

function Prcs_d0303_WaterFlowEnd(degree_y, ride_flag)
  local se_slot = GetControlScriptExternalVariableNumber("se_slot")
  SetControlScriptExternalVariable("se_start_waterflow", "end")
  SetControlScriptExternalVariable("ride_submarimon", "end")
  MovePlayerFrame(degree_y, 8, 15)
  WaitFrame(15)
  if Flg.Check("FLAG_FIELD_D0303_110") then
    Motion.Player:ResetMoveAnimWithBlend(5)
    Field.PlayerScriptDigimonRideEnd(true, "", 5)
  else
    Motion.Player:Play("fg08_w01_end01", 10, false)
    WaitFrame(15)
    Motion.Player:ResetMoveAnimWithBlend(5)
  end
  Flg.Clear(ride_flag)
  Field.PlayerScriptDigimonRideEnd(true, "", 5)
  Flg.Clear("FLAG_FIELD_D0303_110")
  SetProhibitPlayerOnlyOperate(false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  Prcs_d0303_WaterFlowCol(true)
end

function Prcs_d0303_SwitchStream(move_loc, gim_id)
  Field.MovePlayerToLocatorFrame(move_loc, 10)
  WaitFrame(10)
  SetPlayerRotationByLocator(move_loc, 10)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(30)
  if not Flg.Check("AREA_OPEN_DEBUG") then
    Motion.Gimmick:Play(gim_id, "e001", false)
  else
    Motion.Gimmick:Play(gim_id, "e002", false)
  end
  WaitFrame(30)
  if not Flg.Check("AREA_OPEN_DEBUG") then
    Flg.Set("AREA_OPEN_DEBUG")
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Set(78.96, 14.92, -33.99, 78.2, 15.34, -37.56, 60, 0)
    Fade.In(0, 0.4)
    WaitFrame(50)
    Field.InvisibleGimmick("obj_0001", 0, 25, true)
    WaitFrame(30)
    Field.CancelInvisibleGimmick("obj_0002", 1, 40, false, true)
    WaitFrame(80)
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Clear(0)
    Fade.In(0, 0.4)
    WaitFrame(24)
  else
    Flg.Clear("AREA_OPEN_DEBUG")
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Set(78.96, 14.92, -33.99, 78.2, 15.34, -37.56, 60, 0)
    Fade.In(0, 0.4)
    WaitFrame(50)
    Field.InvisibleGimmick("obj_0002", 1, 25, true)
    WaitFrame(25)
    Field.CancelInvisibleGimmick("obj_0001", 0, 40, false, true)
    WaitFrame(70)
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Clear(0)
    Fade.In(0, 0.4)
    WaitFrame(24)
  end
end

function Prcs_d03_SwitchStream(move_loc, gim_loc)
  Field.MovePlayerToLocatorFrame(move_loc, 10)
  WaitFrame(10)
  SetPlayerRotationByLocator(move_loc, 10)
  if not Flg.Check("AREA_OPEN_DEBUG") then
    Motion.Gimmick:Play("gim_0001", "e001", false)
    Motion.Gimmick:Play("gim_0002", "e001", false)
    Motion.Gimmick:Play("gim_0003", "e001", false)
    Motion.Gimmick:Play("gim_0004", "e001", false)
    Motion.Gimmick:Play("gim_0005", "e002", false)
    Motion.Gimmick:Play("obj_0003", "e001", true)
    Motion.Gimmick:Play("obj_0004", "e001", true)
    Motion.Gimmick:Play("obj_0005", "e001", true)
    Motion.Gimmick:Play("obj_0006", "e001", true)
    Motion.Gimmick:Play("obj_0007", "e001", true)
    Motion.Gimmick:Play("obj_0008", "e001", true)
    Motion.Gimmick:Play("obj_0009", "e001", true)
    Motion.Gimmick:Play("obj_0010", "e001", true)
    Motion.Gimmick:Play("obj_0011", "e001", true)
    Motion.Gimmick:Play("obj_0012", "e001", true)
    if gim_loc == "gim_0001" or gim_loc == "gim_0005" then
      Motion.Player:Play("fg11_l01", 0, false)
    else
      Motion.Player:Play("fg11_r01", 0, false)
    end
  else
    Motion.Gimmick:Play("gim_0001", "e002", false)
    Motion.Gimmick:Play("gim_0002", "e002", false)
    Motion.Gimmick:Play("gim_0003", "e002", false)
    Motion.Gimmick:Play("gim_0004", "e002", false)
    Motion.Gimmick:Play("gim_0005", "e001", false)
    Motion.Gimmick:Play("obj_0003", "e002", true)
    Motion.Gimmick:Play("obj_0004", "e002", true)
    Motion.Gimmick:Play("obj_0005", "e002", true)
    Motion.Gimmick:Play("obj_0006", "e002", true)
    Motion.Gimmick:Play("obj_0007", "e002", true)
    Motion.Gimmick:Play("obj_0008", "e002", true)
    Motion.Gimmick:Play("obj_0009", "e002", true)
    Motion.Gimmick:Play("obj_0010", "e002", true)
    Motion.Gimmick:Play("obj_0011", "e002", true)
    Motion.Gimmick:Play("obj_0012", "e002", true)
    if gim_loc == "gim_0001" or gim_loc == "gim_0005" then
      Motion.Player:Play("fg11_r01", 0, false)
    else
      Motion.Player:Play("fg11_l01", 0, false)
    end
  end
  WaitFrame(70)
  if not Flg.Check("AREA_OPEN_DEBUG") then
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Set(78.96, 14.92, -33.99, 78.2, 15.34, -37.56, 60, 0)
    Fade.In(0, 0.4)
    WaitFrame(50)
    Field.InvisibleGimmick("obj_0001", 0, 25, true)
    WaitFrame(30)
    Field.CancelInvisibleGimmick("obj_0002", 1, 40, true, true)
    WaitFrame(80)
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Clear(0)
    Fade.In(0, 0.4)
    WaitFrame(24)
    Flg.Set("AREA_OPEN_DEBUG")
  else
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Set(78.96, 14.92, -33.99, 78.2, 15.34, -37.56, 60, 0)
    Fade.In(0, 0.4)
    WaitFrame(50)
    Field.InvisibleGimmick("obj_0002", 1, 25, true)
    WaitFrame(25)
    Field.CancelInvisibleGimmick("obj_0001", 0, 40, true, true)
    WaitFrame(70)
    Fade.Out(0, 0.4)
    WaitFrame(24)
    Field.Cam.Inst:Clear(0)
    Fade.In(0, 0.4)
    WaitFrame(24)
    Flg.Clear("AREA_OPEN_DEBUG")
  end
end

function Prcs_d0304_CallWhamon()
  Field.MovePlayerToLocatorFrame("change_0001", 10)
  WaitFrame(10)
  SetPlayerRotationByLocator("change_0001", 10)
  Cam.Inst:Set(-34.037, 11.788, 91.466, -41.096, 4.72, 90.5, default, 30)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  if not Flg.Check("FLAG_IS_COMING_WHAMON") then
    WaitFrame(20)
    Motion.NPC:Play("npc_0001", "f002", 0, false)
    local npc_0001 = Obj:new(NPC, "npc_0001")
    npc_0001:CancelInvisible(nil, true)
    WaitFrame(130)
    Motion.NPC:Play("npc_0001", "f003", 10, true)
    Flg.Set("FLAG_IS_COMING_WHAMON")
  end
  local tlk = Tlk:new("d03", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0301_0080_0040")
  MessageClose()
  MessageTalkSel(2, "f_d0301_0080_0050")
  local result = Talk.GetResultSelectedNum()
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    if Flg.Check("FLAG_FIELD_D0304_SubMarineJoin") then
      tlk:Message("f_d0304_0040_0080")
      tlk:Message("f_d0301_0080_0060")
      tlk:EndTalk()
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Guest.Delete(GST_SUBMARINE2)
      Flg.Clear("FLAG_FIELD_D0304_SubMarineJoin")
    else
      tlk:Message("f_d0301_0080_0060")
      tlk:EndTalk()
    end
    Motion.NPC:Play("npc_0001", "f005", 10, false)
    WaitFrame(50)
    FadeOutWithWait(0, 20)
    Flg.Set("FLAG_AREACHANGE_WITH_WHAMON")
    Flg.Clear("FLAG_IS_COMING_WHAMON")
    MapChange("d", 301, "start_11", false, -1, -1)
  else
    tlk:EndTalk()
  end
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  Cam.Inst:Clear(30)
end

function Prcs_d0304_SwitchStream(move_loc, gim_id)
  Field.MovePlayerToLocatorFrame(move_loc, 10)
  WaitFrame(10)
  SetPlayerRotationByLocator(move_loc, 10)
  if not Flg.Check("FLAG_GIMMICK_D03_050") then
    Motion.Gimmick:Play("gim_0001", "e001", false)
    Motion.Gimmick:Play("gim_0002", "e001", false)
    Motion.Gimmick:Play("gim_0003", "e001", false)
    Motion.Gimmick:Play("gim_0004", "e001", false)
    Motion.Gimmick:Play("obj_0001", "e001", true)
    Motion.Gimmick:Play("obj_0002", "e001", true)
    Motion.Gimmick:Play("obj_0003", "e001", true)
    Motion.Gimmick:Play("obj_0004", "e001", true)
    Motion.Gimmick:Play("obj_0005", "e001", true)
    Motion.Gimmick:Play("obj_0006", "e001", true)
    Motion.Player:Play("fg11_l01", 0, false)
    Flg.Set("FLAG_GIMMICK_D03_050")
  else
    Motion.Gimmick:Play("gim_0001", "e002", false)
    Motion.Gimmick:Play("gim_0002", "e002", false)
    Motion.Gimmick:Play("gim_0003", "e002", false)
    Motion.Gimmick:Play("gim_0004", "e002", false)
    Motion.Gimmick:Play("obj_0001", "e002", true)
    Motion.Gimmick:Play("obj_0002", "e002", true)
    Motion.Gimmick:Play("obj_0003", "e002", true)
    Motion.Gimmick:Play("obj_0004", "e002", true)
    Motion.Gimmick:Play("obj_0005", "e002", true)
    Motion.Gimmick:Play("obj_0006", "e002", true)
    Motion.Player:Play("fg11_r01", 0, false)
    Flg.Clear("FLAG_GIMMICK_D03_050")
  end
  WaitFrame(70)
end

function Prcs_d0304_WaterFlowStart(degree_y, rail_name, rail_direction, ride_start)
  local RideDegiID = 145
  local r_flame = 15
  SetControlScriptExternalVariable("ride_rail", rail_name)
  SetControlScriptExternalVariable("rail_direction", rail_direction)
  Field_Talk_Start("d03", 1)
  if Flg.Check("FLAG_MAIN_10_001") then
    Message("f_d0304_0060_0010")
  else
    Message("f_d0304_0050_0010")
  end
  Field_Talk_End()
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse01"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse01"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse02"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse02"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse03"), false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse03"), false)
  Obj:new(OGIM, "col_01"):Invisible()
  Obj:new(OGIM, "col_02"):Invisible()
  Obj:new(OGIM, "col_03"):Invisible()
  Obj:new(OGIM, "col_04"):Invisible()
  Obj:new(OGIM, "col_05"):Invisible()
  Obj:new(OGIM, "col_06"):Invisible()
  Obj:new(OGIM, "col_07"):Invisible()
  Obj:new(OGIM, "col_08"):Invisible()
  Obj:new(OGIM, "col_09"):Invisible()
  Obj:new(OGIM, "col_10"):Invisible()
  Obj:new(OGIM, "col_11"):Invisible()
  Obj:new(OGIM, "col_12"):Invisible()
  Obj:new(OGIM, "col_13"):Invisible()
  Obj:new(OGIM, "col_14"):Invisible()
  Obj:new(OGIM, "col_15"):Invisible()
  Obj:new(OGIM, "col_16"):Invisible()
  Obj:new(OGIM, "col_17"):Invisible()
  Obj:new(OGIM, "col_18"):Invisible()
  Field.SetPlayerRotation(degree_y, 15)
  SetFollowerCameraOperateRotation(5, degree_y, r_flame)
  SetEnableCameraOperate(false)
  WaitFrame(r_flame)
  Flg.Set("FLAG_FIELD_D0303_110")
  Field.PlayerScriptDigimonRideStartFromID(RideDegiID, true, ride_start, 5)
  WaitFrame(30)
  SetControlScriptExternalVariable("ride_submarimon", "riding")
  local se_slot = PlaySE(201002, 100)
  SetControlScriptExternalVariable("se_slot", se_slot)
end

function Prcs_d0304_WaterFlowEnd(degree_y)
  MovePlayerFrame(degree_y, 8, 15)
  WaitFrame(15)
  Flg.Clear("FLAG_FIELD_D0303_110")
  Motion.Player:ResetMoveAnimWithBlend(5)
  Field.PlayerScriptDigimonRideEnd(true, "", 5)
  SetProhibitPlayerOnlyOperate(false)
  local se_slot = GetControlScriptExternalVariableNumber("se_slot")
  StopSE(se_slot, 15)
  Obj:new(OGIM, "col_01"):CancelInvisible()
  Obj:new(OGIM, "col_02"):CancelInvisible()
  Obj:new(OGIM, "col_03"):CancelInvisible()
  Obj:new(OGIM, "col_04"):CancelInvisible()
  Obj:new(OGIM, "col_05"):CancelInvisible()
  Obj:new(OGIM, "col_06"):CancelInvisible()
  Obj:new(OGIM, "col_07"):CancelInvisible()
  Obj:new(OGIM, "col_08"):CancelInvisible()
  Obj:new(OGIM, "col_09"):CancelInvisible()
  Obj:new(OGIM, "col_10"):CancelInvisible()
  Obj:new(OGIM, "col_11"):CancelInvisible()
  Obj:new(OGIM, "col_12"):CancelInvisible()
  Obj:new(OGIM, "col_13"):CancelInvisible()
  Obj:new(OGIM, "col_14"):CancelInvisible()
  Obj:new(OGIM, "col_15"):CancelInvisible()
  Obj:new(OGIM, "col_16"):CancelInvisible()
  Obj:new(OGIM, "col_17"):CancelInvisible()
  Obj:new(OGIM, "col_18"):CancelInvisible()
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  SetEnableCameraOperate(true)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse01"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse01"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse02"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse02"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Obverse03"), true)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "WaterFlow_Reverse03"), true)
  SetControlScriptExternalVariable("ride_submarimon", "end")
end

function Prcs_d0302_ForceFlow(degree_y, wait_frame)
  local speed = 15
  SetProhibitDigimonRide(true)
  Motion.Player:ChangeMoveAnim("flow", speed)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  SetFollowerCameraOperateRotation(0, degree_y, 15)
  MovePlayerFrame(degree_y, speed, wait_frame)
  WaitFrame(wait_frame + 1)
  Motion.Player:ResetMoveAnimWithBlend(5)
  MovePlayerFrame(degree_y, 8, 15)
  WaitFrame(15)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  SetProhibitDigimonRide(false)
end

function Prcs_d03_ChangeMoveMotion()
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  SetProhibitPlayerOnlyOperate(true)
  Flg.Set("FLAG_IS_SWIM")
end

function Prcs_d03_ResetMoveMotion()
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
  SetProhibitPlayerOnlyOperate(false)
  Flg.Clear("FLAG_IS_SWIM")
end
