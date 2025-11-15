gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 101 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
  end
  if load_map_num == 103 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {
        "e001",
        "e002",
        "e003"
      }
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {
        "e001",
        "e002",
        "e003"
      }
    })
  end
  if load_map_num == 107 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0005",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0006",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0007",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0008",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0009",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {
        "e001",
        "e002",
        "e003"
      }
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {
        "e001",
        "e002",
        "e003"
      }
    })
    Field.ObjectLoadMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "ice_crystal_01"), "e001")
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d01_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 101 then
    if not Flg.Check("FLAG_GIMMICK_D01_010") and not Flg.Check("FLAG_GIMMICK_D01_011") then
      Flg.Set("FLAG_GIMMICK_D01_011")
    end
    if Flg.Check("FLAG_GIMMICK_D01_011") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), 0, "e001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), 0, "e001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0002"), 0, "e001")
    end
    if not Flg.Check("FLAG_MAIN_18_010") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0002"), false)
    end
    if not Flg.Check("FLAG_MAIN_18_024") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "elv_0001"), false)
    end
    local npc_index = GetIndex(NPC, "M_burinpu_01")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
  elseif gMapNum == 102 then
    Obj:new(NPC, "npc_0001"):Invisible()
  elseif gMapNum == 103 then
    if not Flg.Check("FLAG_GIMMICK_D01_390") then
      Flg.Set("FLAG_GIMMICK_D01_390")
    end
    if Flg.Check("FLAG_MAIN_18_029E", "FLAG_MAIN_18_055") then
    end
    if Flg.Check("FLAG_GIMMICK_D01_413") then
    end
    if Flg.Check("FLAG_GIMMICK_D01_060") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0003"), 0, "e003")
    else
      local index = GetIndex(FLD_OBJ_LOCATOR, "gim_0003")
      Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, index, "e001", 5, true)
    end
    if Flg.Check("FLAG_GIMMICK_D01_070") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0004"), 0, "e003")
    else
      local index = GetIndex(FLD_OBJ_LOCATOR, "gim_0004")
      Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, index, "e001", 5, true)
    end
  elseif gMapNum == 104 then
  elseif gMapNum == 105 then
  elseif gMapNum == 106 then
    if not Flg.Check("FLAG_MAIN_18_026") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_icepwall_01"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_icepwall_02"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_icepwall_03"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_icepwall_04"), false)
    end
    Obj:new(NPC, "npc_003"):Invisible()
  elseif gMapNum == 107 then
    SetEnableGimmickCheck("elv_0012", false)
    Field.PlayerLoadMoveAnimation("slide")
    Field.PlayerLoadMoveAnimation("slide_end")
    while Field.IsLoadingPlayerMoveAnimation("slide") do
      WaitFrame(Util.SecondFromFrame(1))
    end
    while Field.IsLoadingPlayerMoveAnimation("slide_end") do
      WaitFrame(Util.SecondFromFrame(1))
    end
    if Flg.Check("FLAG_GIMMICK_D01_250") then
      Field.SetEnableGimmickCheck("fa_0017", false)
      ColOff("wall_cl_9000")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0003"), 0, "e001")
    end
    if not Flg.Check("FLAG_MAIN_18_029B") then
    end
    if Flg.Check("FLAG_GIMMICK_D01_090") then
      ColOff("plan_cl_1000")
      Obj:new(FLD_OBJ_LOCATOR, "obj_0001"):Invisible()
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0002"), 0, "e001")
    end
    Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0003"), 0, "e001")
    Flg.Clear("FLAG_GIMMICK_D01_200")
    Flg.Clear("FLAG_GIMMICK_D01_210")
    Flg.Clear("FLAG_GIMMICK_D01_220")
    if Flg.Check("FLAG_MAIN_18_029E") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "ice_crystal_01"), false)
      Field.ObjectPlayMotion(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "ice_crystal_01"), "e001", 5, true)
    end
    if Flg.Check("FLAG_MAIN_18_029B") then
      ColOff("wall_cl_9000")
      ColOff("wall_cl_9001")
      ColOff("wall_cl_9002")
    end
  elseif gMapNum == 108 then
  elseif gMapNum == 109 and Flg.Check("FLAG_FIELD_D01_010") then
    Cam.Inst:Set(0.36, 16.77, -37.02, 0.36, 14.82, -27.18, default, 0)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 101 then
    if col_name == "evt_0001" then
      M400:Event_030()
      M400:Event_040()
      if not Flg.Check("FLAG_MAIN_18_022") then
        Flg.Set("FLAG_MAIN_18_022")
      end
    end
    if col_name == "evt_9000" then
      if Flg.Check("FLAG_GIMMICK_D01_010") then
        MapChange("d", 102, "start_00", true, 0, 15)
      elseif Flg.Check("FLAG_GIMMICK_D01_011") then
        MapChange("d", 106, "start_00", true, 0, 15)
      end
    end
    if col_name == "evt_9001" then
      ColOn("evt_9000")
      Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
      Cam.Inst:Clear(30)
      M400:Event_270()
    end
  elseif gMapNum == 102 then
    if col_name == "evt_9000" then
      Field.LinkColOn("col_d0101_start_01_0")
      Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
    end
  elseif gMapNum == 103 then
    if col_name == "evt_1000" or col_name == "evt_1001" then
      M400:Event_080()
    end
    if col_name == "evt_1002" then
      M400:Event_260()
    end
    if col_name == "evt_3000" then
      if not Flg.Check("FLAG_GIMMICK_D01_060") then
        local tlk = Tlk:new("d01", 1, false)
        tlk:StartTalk()
        tlk:Message("f_d0103_0060_0010")
        tlk:MessageClose()
        Field.MovePlayerToRelativePosFrame(2, 4, 30)
        WaitFrame(30)
        tlk:EndTalk()
        Field.FollowerWarp()
      end
    elseif col_name == "evt_3001" then
      if not Flg.Check("FLAG_GIMMICK_D01_060") then
        local tlk = Tlk:new("d01", 1, false)
        tlk:StartTalk()
        tlk:Message("f_d0103_0060_0010")
        tlk:MessageClose()
        Field.MovePlayerToRelativePosFrame(-3, -4, 30)
        WaitFrame(30)
        tlk:EndTalk()
        Field.FollowerWarp()
      end
    elseif col_name == "evt_3002" then
      if not Flg.Check("FLAG_GIMMICK_D01_070") then
        local tlk = Tlk:new("d01", 1, false)
        tlk:StartTalk()
        tlk:Message("f_d0103_0060_0010")
        tlk:MessageClose()
        Field.MovePlayerToRelativePosFrame(2, 4, 30)
        WaitFrame(30)
        tlk:EndTalk()
        Field.FollowerWarp()
      end
    elseif col_name == "evt_3003" and not Flg.Check("FLAG_GIMMICK_D01_070") then
      local tlk = Tlk:new("d01", 1, false)
      tlk:StartTalk()
      tlk:Message("f_d0103_0060_0010")
      tlk:MessageClose()
      Field.MovePlayerToRelativePosFrame(-4, -1, 30)
      WaitFrame(30)
      tlk:EndTalk()
      Field.FollowerWarp()
    end
    if col_name == "evt_9004" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9005" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9010" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9011" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  elseif gMapNum == 104 then
    if col_name == "evt_0001" then
      if not Flg.Check("FLAG_MAIN_18_029G") then
        M400:Event_190()
      end
    elseif col_name == "evt_0002" then
      if not Flg.Check("FLAG_MAIN_18_029H") then
        M400:Event_200()
      end
    elseif col_name == "evt_0003" then
      M400:Event_210()
    end
    if col_name == "evt_6000" then
    elseif col_name == "evt_6001" then
    end
  elseif gMapNum == 105 then
    if col_name == "evt_0001" then
      M400:Event_230()
    end
  elseif gMapNum == 106 then
    if col_name == "evt_9000" then
      Field.LinkColOn("col_d0101_start_01_0")
      Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
      Cam.Inst:Clear(30)
    end
  elseif gMapNum == 107 then
    if col_name == "evt_1000" then
      M400:Event_100()
    end
    if col_name == "evt_1001" then
      M400:Event_110()
    end
    if col_name == "evt_1003" then
      M400:Event_280()
    end
    if col_name == "evt_9000" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      Field.MovePlayerToTargetPosFrame2D(21.594, 13.457, 2, 15)
      WaitFrame(10)
      Field.MovePlayerToTargetPosFrame2D(22.081, 13.197, 2, 15)
      WaitFrame(20)
      Prcs_d0107_IceSlide("elv10_state", 52)
    elseif col_name == "evt_9001" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      Field.MovePlayerToTargetPosFrame2D(-14.076, -47.372, 2, 15)
      WaitFrame(10)
      Field.MovePlayerToTargetPosFrame2D(-13.303, -47.917, 2, 15)
      WaitFrame(20)
      Prcs_d0107_IceSlide("elv11_state", 62)
    elseif col_name == "evt_9002" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      Field.MovePlayerToTargetPosFrame2D(-93.933, -48.806, 2, 25)
      WaitFrame(20)
      Field.MovePlayerToTargetPosFrame2D(-94.261, -49.87, 2, 20)
      WaitFrame(25)
      Prcs_d0107_IceSlide("elv12_state", 334)
    end
    if not Flg.Check("FLAG_GIMMICK_D01_190") then
      if col_name == "evt_9003" then
        Prcs_d0107_ForceSlide(0, 7)
      elseif col_name == "evt_9004" then
        Prcs_d0107_ForceSlide(120, 7)
      elseif col_name == "evt_9005" then
        Prcs_d0107_ForceSlide(120, 7)
      end
    end
    if col_name == "evt_9007" or col_name == "evt_9008" then
      Prcs_d0107_IceSlideEnd()
    end
    if col_name == "evt_9902" then
      MiniMapChange(MAP_LAYER_LOW)
    elseif col_name == "evt_9903" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9934" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    elseif col_name == "evt_9935" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if col_name == "evt_9932" then
      MiniMapChange(MAP_LAYER_HIGH)
    elseif col_name == "evt_9933" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9922" then
      MiniMapChange(MAP_LAYER_HIGH)
    elseif col_name == "evt_9923" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9924" then
      MiniMapChange(MAP_LAYER_HIGH)
    elseif col_name == "evt_9925" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    elseif col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if col_name == "evt_9926" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    elseif col_name == "evt_9927" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9920" then
      MiniMapChange(MAP_LAYER_HIGH)
    elseif col_name == "evt_9921" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9928" then
      MiniMapChange(MAP_LAYER_HIGH)
    elseif col_name == "evt_9929" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9930" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    elseif col_name == "evt_9931" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
  elseif gMapNum == 108 then
    if col_name == "evt_0001" then
      M400:Event_290()
    end
    if col_name == "evt_0004" then
      M400:Event_300()
    end
    if col_name == "evt_1000" then
      M400:Event_310()
    end
  elseif gMapNum == 109 then
    if col_name == "evt_9000" then
      M400:Event_330()
    end
    if col_name == "evt_0001" then
      if Flg.Check("FLAG_MAIN_18_048", "FLAG_MAIN_18_050") then
        Flg.Clear("FLAG_FIELD_D01_010")
        Cam.Inst:Clear(30)
      end
    elseif not (col_name == "evt_0002" and Flg.Check("FLAG_MAIN_18_048", "FLAG_MAIN_18_050")) or Flg.Check("FLAG_FIELD_D01_010") then
    else
      Flg.Set("FLAG_FIELD_D01_010")
      Cam.Inst:Set(0.36, 16.77, -37.02, 0.36, 14.82, -27.18, default, 30)
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  local gim_name = gim.unique_name
  if gMapNum == 101 then
    if gim_id == 2 then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_GIMMICK_D01_010") then
        Prcs_d0101_AreaChangeEvent("e001")
        Flg.Set("FLAG_GIMMICK_D01_011")
        Flg.Clear("FLAG_GIMMICK_D01_010")
      elseif Flg.Check("FLAG_GIMMICK_D01_011") then
        Prcs_d0101_AreaChangeEvent("e002")
        Flg.Set("FLAG_GIMMICK_D01_010")
        Flg.Clear("FLAG_GIMMICK_D01_011")
        M400:Event_050()
      end
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 102 then
  elseif gMapNum == 103 then
  elseif gMapNum == 104 then
  elseif gMapNum == 105 then
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 106 then
  elseif gMapNum == 107 then
    if gim_id == 16 then
      Prcs_d0107_CheckBrokenSlide()
    end
  elseif gMapNum == 108 then
  elseif gMapNum == 109 and gim_id == 400 then
    GoToTheaterWithEvt()
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 101 then
    if gim_name == "access_icon_01" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject("lookat_01")
      local tlk = Tlk:new("field_text", 1, true)
      tlk:StartTalk()
      tlk:Message("g_wm_0030_0010")
      tlk:EndTalk()
      Flg.Set("FLAG_ISAREA_CHANGE_FOR_BLIMP")
      OpenWorldMap(DW, BLIMPMON)
      Flg.Clear("FLAG_ISAREA_CHANGE_FOR_BLIMP")
    end
  elseif gMapNum == 102 then
    if gim_name == "obj_barricade01" then
      if Flg.Check("FLAG_MAIN_18_029E") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing(OGIM, gim_name)
        Flg.Set("FLAG_GIMMICK_D01_110")
      else
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing_Not()
      end
    elseif gim_name == "obj_barricade02" then
      if Flg.Check("FLAG_MAIN_18_029E") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing(OGIM, gim_name)
        Flg.Set("FLAG_GIMMICK_D01_120")
      else
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing_Not()
      end
    elseif gim_name == "obj_barricade03" then
      if Flg.Check("FLAG_MAIN_18_029E") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing(OGIM, gim_name)
        Flg.Set("FLAG_GIMMICK_D01_130")
      else
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing_Not()
      end
    elseif gim_name == "obj_barricade04" then
      if Flg.Check("FLAG_MAIN_18_029E") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing(OGIM, gim_name)
        Flg.Set("FLAG_GIMMICK_D01_140")
      else
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing_Not()
      end
    elseif gim_name == "obj_barricade05" then
      if Flg.Check("FLAG_MAIN_18_029E") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing(OGIM, gim_name)
        Flg.Set("FLAG_GIMMICK_D01_150")
      else
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_FireExtinguishing_Not()
      end
    end
  elseif gMapNum == 103 then
    if gim_name == "gear_access_01" then
      if Flg.Check("FLAG_GIMMICK_D01_060") then
        PlayerLookAtGimmickObject(gim_name)
        local tlk = Tlk:new("d01", 1, true)
        tlk:StartTalk()
        if Flg.Check("FLAG_MAIN_19_020") then
          tlk:Message("f_d0103_0080_0010")
        else
          tlk:Message("f_d0103_0100_0010")
        end
        tlk:EndTalk()
      else
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d0103_StopGear(gim_name, "gim_0003")
        INFO_GET_ITEM(791, 1)
        Flg.Set("FLAG_GIMMICK_D01_060")
        Flg.Set("FLAG_GIMMICK_D01_020")
        M400:Event_070()
      end
    end
    if gim_name == "gear_access_02" then
      if Flg.Check("FLAG_GIMMICK_D01_070") then
        PlayerLookAtGimmickObject(gim_name)
        local tlk = Tlk:new("d01", 1, true)
        tlk:StartTalk()
        if Flg.Check("FLAG_MAIN_19_020") then
          tlk:Message("f_d0103_0080_0010")
        else
          tlk:Message("f_d0103_0100_0010")
        end
        tlk:EndTalk()
      else
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d0103_StopGear(gim_name, "gim_0004")
        Flg.Set("FLAG_GIMMICK_D01_070")
      end
    end
    if gim_name == "obj_bigfirewall_01" then
      if Flg.Check("FLAG_MAIN_18_029E") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        M400:Event_170()
        M400:Event_180()
      else
        local tlk = Tlk:new("d01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0103_0020_0030")
        tlk:EndTalk()
      end
    end
    if gim_name == "firewall_01" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Flg.Set("FLAG_GIMMICK_D01_320")
      Prcs_d01_FireExtinguishing(OGIM, "firewall_01", 2.5)
    end
    if gim_name == "firewall_02" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Flg.Set("FLAG_GIMMICK_D01_330")
      Prcs_d01_FireExtinguishing(OGIM, "firewall_02", 2.5)
    end
    if gim_name == "firewall_03" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Flg.Set("FLAG_GIMMICK_D01_340")
      Prcs_d01_FireExtinguishing(OGIM, "firewall_03", 2.5)
    end
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 104 then
  elseif gMapNum == 106 then
    if gim_name == "obj_icepwall_01" then
      if Flg.Check("FLAG_MAIN_18_026") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_IceMelt(OGIM, gim_name, 2)
        Flg.Set("FLAG_GIMMICK_D01_230")
      end
    elseif gim_name == "obj_icepwall_02" then
      if Flg.Check("FLAG_MAIN_18_026") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_IceMelt(OGIM, gim_name, 2)
        Flg.Set("FLAG_GIMMICK_D01_240")
      end
    elseif gim_name == "obj_icepwall_03" then
      if Flg.Check("FLAG_MAIN_18_026") then
        CancelPlayerAnywhereDigimonRide()
        PlayerLookAtGimmickObject(gim_name)
        Prcs_d01_IceMelt(OGIM, gim_name, 2)
        Flg.Set("FLAG_GIMMICK_D01_260")
      end
    elseif gim_name == "obj_icepwall_04" and Flg.Check("FLAG_MAIN_18_026") then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Prcs_d01_IceMelt(OGIM, gim_name, 2)
      Flg.Set("FLAG_GIMMICK_D01_270")
    end
  elseif gMapNum == 107 then
    if gim_name == "gear_access_01" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      M400:Event_120()
    end
    if gim_name == "ice_access_01" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      M400:Event_140()
      M400:Event_150()
    end
    if gim_name == "ice_crystal_01" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      M400:Event_160()
    end
    if gim_name == "ice_access_02" then
      PlayerLookAtGimmickObject(gim_name)
      if Flg.Check("FLAG_MAIN_18_029B", "FLAG_MAIN_18_029C") then
        M400:Event_130()
      else
        local tlk = Tlk:new("d01", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0107_0020_0035")
        tlk:EndTalk()
      end
    end
    if gim_name == "firewall_01" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Prcs_d01_FireExtinguishing(OGIM, gim_name, 2)
      Flg.Set("FLAG_GIMMICK_D01_160")
    elseif gim_name == "firewall_02" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Prcs_d01_FireExtinguishing(OGIM, gim_name, 2)
      Flg.Set("FLAG_GIMMICK_D01_170")
    elseif gim_name == "firewall_03" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Prcs_d01_FireExtinguishing(OGIM, gim_name, 1.4)
      Flg.Set("FLAG_GIMMICK_D01_180")
    elseif gim_name == "firewall_04" then
      CancelPlayerAnywhereDigimonRide()
      PlayerLookAtGimmickObject(gim_name)
      Prcs_d01_FireExtinguishing(OGIM, gim_name, 2)
      Flg.Set("FLAG_GIMMICK_D01_310")
    end
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 108 then
  elseif gMapNum == 109 and gim_name == "hazama_gate01" then
    print("====== gate_access ======")
    PlayerLookAtGimmickObject(gim_name)
    GoToHazamaWithEvt(gim)
  end
end

function OnFieldAttackGimmick(att_gim)
  local gim_name = att_gim.unique_name
  local gim_tag = att_gim.tag
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimName = ", gim_name, "gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 101 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 102 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 103 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_tag == "fa_obj_h" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D01_400")
      FieldObjectSync(OGIM, false)
    end
  elseif gMapNum == 104 then
  elseif gMapNum == 105 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 106 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 107 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_tag == "fa_obj_ele" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 108 then
  elseif gMapNum == 109 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 103 then
  elseif gMapNum == 107 then
  end
end

function OnCheckActModel(act)
end

function OnCheckLocatorWallAlong(wall_along)
  local start_loc = wall_along.locator
end
