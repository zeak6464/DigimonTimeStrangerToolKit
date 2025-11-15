gGimText = "field_text"
room1 = {
  "pc_access_08",
  "wb_access_04",
  "wb_access_07",
  "rack_access_04"
}
room2 = {
  "security_access"
}
room3 = {
  "pc_access_09",
  "pc_access_10",
  "wb_access_05",
  "wb_access_06",
  "rack_access_01"
}
room4 = {
  "rack_access_05",
  "server_room_access",
  "rack_access_06"
}
room5 = {
  "pc_access_01",
  "pc_access_02",
  "pc_access_03",
  "pc_access_04",
  "wb_access_01",
  "wb_access_02",
  "rack_access_03",
  "rack_access_07"
}
room6 = {
  "pc_access_05",
  "pc_access_06",
  "pc_access_07",
  "wb_access_03",
  "rack_access_02"
}

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 1301 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {
        "e503",
        "fn01_01",
        "e006"
      }
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0005",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0006",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0007",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0008",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0009",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0010",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0011",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "change_0001",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 1302 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0005",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0006",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0007",
      motion = {"e001"}
    })
    Field.ObjectLoadMotion(OGIM, GetIndex(OGIM, "elv_shutter_01"), "e001")
    Field.ObjectLoadMotion(OGIM, GetIndex(OGIM, "elv_shutter_01"), "e002")
  elseif load_map_num == 1303 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001"}
    })
  elseif load_map_num == 1304 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"hide"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "change_0002",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 1305 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"fg09_n01"}
    })
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d13_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 1301 then
    Obj:new(NPC, "npc_0032"):Invisible()
    Obj:new(NPC, "npc_0033"):Invisible()
    Obj:new(NPC, "npc_0034"):Invisible()
    if Flg.Check("FLAG_MAIN_17_039") and Flg.Check("FLAG_GIMMICK_D13_070") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0008"), 0, "e001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0009"), false)
      ColOff("wall_cl_0002")
    else
    end
    if not Flg.Check("FLAG_GIMMICK_D13_100") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "security_01"), false)
    end
    if Flg.Check("FLAG_GIMMICK_D13_110") or Flg.Check("FLAG_GIMMICK_D13_120") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "security_01"), false)
    end
    if Flg.Check("FLAG_MAIN_17_035") and not Flg.Check("FLAG_MAIN_17_090") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "change_0001"), false)
    end
    if not Flg.Check("FLAG_GIMMICK_D13_160") then
      Prcs_d1301_SwitchingGimmickAccess(room1, false)
    else
      Prcs_d1301_SwitchingGimmickAccess(room1, true)
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if not Flg.Check("FLAG_GIMMICK_D13_170") then
      Prcs_d1301_SwitchingGimmickAccess(room2, false)
    else
      Prcs_d1301_SwitchingGimmickAccess(room2, true)
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if not Flg.Check("FLAG_GIMMICK_D13_180") then
      Prcs_d1301_SwitchingGimmickAccess(room3, false)
    else
      Prcs_d1301_SwitchingGimmickAccess(room3, true)
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if not Flg.Check("FLAG_GIMMICK_D13_190") then
      Prcs_d1301_SwitchingGimmickAccess(room4, false)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0002"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0035"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0036"), false)
    else
      Prcs_d1301_SwitchingGimmickAccess(room4, true)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0002"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0035"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0036"), true)
    end
    if not Flg.Check("FLAG_GIMMICK_D13_200") then
      Prcs_d1301_SwitchingGimmickAccess(room5, false)
    else
      Prcs_d1301_SwitchingGimmickAccess(room5, true)
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if not Flg.Check("FLAG_GIMMICK_D13_210") then
      Prcs_d1301_SwitchingGimmickAccess(room6, false)
    else
      Prcs_d1301_SwitchingGimmickAccess(room6, true)
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
  elseif gMapNum == 1302 then
    if Flg.Check("FLAG_MAIN_17_041") and not Flg.Check("FLAG_MAIN_17_070") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "door_access_01"), false)
    end
    if Flg.Check("FLAG_GIMMICK_D13_130") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), 0, "e001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "door_access_01"), false)
      ColOff("wall_cl_0004")
    end
    if Flg.Check("FLAG_GIMMICK_D13_140") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0004"), 0, "e001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "door_access_02"), false)
      ColOff("wall_cl_0002")
    end
    if Flg.Check("FLAG_GIMMICK_D13_070") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0002"), 0, "e001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0006"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0005"), false)
      ColOff("wall_cl_0003")
    end
    Obj:new(FLD_OBJ_GIMMICK, "elv_access"):SetEnableGimmick(false)
    Obj:new(FLD_OBJ_GIMMICK, "elv_access"):Invisible()
    if Flg.Check("FLAG_GIMMICK_D13_220") then
      Motion.Object:PlayFinishedAnim(OGIM, GetIndex(OGIM, "elv_shutter_01"), 0, "e001")
      Obj:new(FLD_OBJ_GIMMICK, "elv_shutter_col"):Invisible()
      Obj:new(FLD_OBJ_GIMMICK, "elv_open_access"):Invisible()
      Obj:new(FLD_OBJ_GIMMICK, "elv_open_access"):SetEnableGimmick(false)
      Obj:new(FLD_OBJ_GIMMICK, "elv_access"):CancelInvisible()
      Obj:new(FLD_OBJ_GIMMICK, "elv_access"):SetEnableGimmick(true)
    end
  elseif gMapNum == 1303 then
    if Flg.Check("FLAG_GIMMICK_D13_240") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0004"), 0, "e001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), 0, "e001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0002"), 0, "e001")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0004"), false)
      ColOff("wall_cl_0001")
      ColOff("wall_cl_0002")
    end
    Obj:new(FLD_OBJ_GIMMICK, "s200_149_002"):Invisible()
    Obj:new(FLD_OBJ_GIMMICK, "s200_149_003"):Invisible()
  elseif gMapNum == 1304 then
    if Flg.Check("FLAG_MAIN_08_025", "FLAG_MAIN_08_043") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "change_0002"), false)
    end
    if not Flg.Check("FLAG_MAIN_08_028") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "duct_0002"), false)
    end
    if Flg.Check("FLAG_MAIN_13_010") and not Flg.Check("FLAG_MAIN_13_045") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "duct_0002"), false)
    end
    if Flg.Check("FLAG_MAIN_17_030") and not Flg.Check("FLAG_MAIN_17_090") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "duct_0002"), false)
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 1301 then
    if col_name == "evt_0001" then
      Prcs_d1301_SwitchingGimmickAccess(room1, false)
      Flg.Clear("FLAG_GIMMICK_D13_160")
      Field.SetPlayerStealthFromSymbolEnemy(false)
    elseif col_name == "evt_0002" then
      Prcs_d1301_SwitchingGimmickAccess(room1, true)
      Flg.Set("FLAG_GIMMICK_D13_160")
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if col_name == "evt_0003" then
      Prcs_d1301_SwitchingGimmickAccess(room2, false)
      Flg.Clear("FLAG_GIMMICK_D13_170")
      Field.SetPlayerStealthFromSymbolEnemy(false)
    elseif col_name == "evt_0004" then
      Prcs_d1301_SwitchingGimmickAccess(room2, true)
      Flg.Set("FLAG_GIMMICK_D13_170")
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if col_name == "evt_0005" then
      Prcs_d1301_SwitchingGimmickAccess(room3, false)
      Flg.Clear("FLAG_GIMMICK_D13_180")
      Field.SetPlayerStealthFromSymbolEnemy(false)
    elseif col_name == "evt_0006" then
      Prcs_d1301_SwitchingGimmickAccess(room3, true)
      Flg.Set("FLAG_GIMMICK_D13_180")
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if col_name == "evt_0007" then
      Prcs_d1301_SwitchingGimmickAccess(room4, false)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0002"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0035"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0036"), false)
      Flg.Clear("FLAG_GIMMICK_D13_190")
      Field.SetPlayerStealthFromSymbolEnemy(false)
    elseif col_name == "evt_0008" then
      Prcs_d1301_SwitchingGimmickAccess(room4, true)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0002"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0035"), true)
      Field.ObjectSetEnableCheckAndFieldAttack(NPC, GetIndex(NPC, "npc_0036"), true)
      Flg.Set("FLAG_GIMMICK_D13_190")
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if col_name == "evt_0009" then
      Prcs_d1301_SwitchingGimmickAccess(room5, false)
      Flg.Clear("FLAG_GIMMICK_D13_200")
      Field.SetPlayerStealthFromSymbolEnemy(false)
    elseif col_name == "evt_0010" then
      Prcs_d1301_SwitchingGimmickAccess(room5, true)
      Flg.Set("FLAG_GIMMICK_D13_200")
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if col_name == "evt_0011" then
      Prcs_d1301_SwitchingGimmickAccess(room6, false)
      Flg.Clear("FLAG_GIMMICK_D13_210")
      Field.SetPlayerStealthFromSymbolEnemy(false)
    elseif col_name == "evt_0012" then
      Prcs_d1301_SwitchingGimmickAccess(room6, true)
      Flg.Set("FLAG_GIMMICK_D13_210")
      Field.SetPlayerStealthFromSymbolEnemy(true)
    end
    if col_name == "evt_1000" then
      M390:Event_033()
      M390:Event_671()
    end
    if (col_name == "evt_2000" or col_name == "evt_2001") and Flg.Check("FLAG_MAIN_17_060", "FLAG_MAIN_17_090") then
      local tlk = Tlk:new("d13", 1, true)
      local x, z = 0, 0
      tlk:StartTalk()
      if col_name == "evt_2000" then
        x, z = 0, 1
        Cam.Inst:Set(12.396, 0.04, -15.409, 14.012, 2.083, -5.751, default, 30)
        WaitFrame(30)
      else
        x, z = 1, 0
        Cam.Inst:Set(-1.278, 0.04, 12.564, 8.493, 1.936, 11.595, default, 30)
        WaitFrame(30)
      end
      tlk:Message("f_d1301_0340_0010")
      Cam.Inst:Clear(30)
      MovePlayerToRelativePosFrame(x, z, 20)
      tlk:EndTalk()
    end
  elseif gMapNum == 1302 then
  elseif gMapNum == 1303 then
    if col_name == "evt_0001" then
      M390:Event_600()
      M390:Event_680()
    end
  elseif gMapNum == 1304 then
    if col_name == "evt_0001" then
      M340:Event_040()
    end
    if col_name == "evt_9001" then
      Prcs_d1304_DuctEnd()
    end
    if col_name == "evt_9002" then
      MapChange("d", 1305, "start_01", true, 0, 15)
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 1301 then
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d1301_EnterElv()
    end
    if gim_id == 9 then
      if not Flg.Check("FLAG_MAIN_17_028") then
        local tlk = Tlk:new("d13", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1301_0350_0010")
        tlk:EndTalk()
      elseif not Flg.Check("FLAG_MAIN_17_029") then
        local tlk = Tlk:new("d13", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1301_0360_0010")
        tlk:EndTalk()
      elseif not Flg.Check("FLAG_MAIN_17_039") then
        local tlk = Tlk:new("d13", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1301_0370_0010")
        tlk:EndTalk()
      elseif not Flg.Check("FLAG_MAIN_17_044") then
        M390:Event_130()
      else
        Field.SetEnableGimmickCheck("gim_0009", false)
        PlayerCheckGimmick("gim_0009", 10, "fg07_m01", 0, false)
        WaitFrame(15)
        PlaySE(200025, 100)
        WaitFrame(15)
        Motion.Gimmick:Play("gim_0009", "e001", false)
        Motion.Gimmick:Play("gim_0008", "e001", false)
        ColOff("wall_cl_0002")
        PlaySE(200024, 50)
        WaitFrame(135)
        MapChange("d", 1302, "start_00", true, FADE_BLACK, FADE_TIME)
      end
    end
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 1302 then
    if gim_id == 1 then
    elseif gim_id == 4 then
    elseif gim_id == 5 then
      Field.SetEnableGimmickCheck("gim_0005", false)
      PlayerCheckGimmick("gim_0005", 10, "fg07_m01", 0, false)
      WaitFrame(30)
      Motion.Gimmick:Play("gim_0005", "e001", false)
      Motion.Gimmick:Play("gim_0002", "e001", false)
      ColOff("wall_cl_0003")
      WaitFrame(60)
    end
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 1303 then
    if gim_id == 4 then
      M390:Event_150()
      M390:Event_675()
      Field.SetEnableGimmickCheck("gim_0004", false)
      PlayerCheckGimmick("gim_0004", 10, "fg07_m01", 0, false)
      WaitFrame(15)
      PlaySE(200025, 100)
      WaitFrame(15)
      Motion.Gimmick:Play("gim_0004", "e001", false)
      Motion.Gimmick:Play("gim_0001", "e001", false)
      Motion.Gimmick:Play("gim_0002", "e001", false)
      ColOff("wall_cl_0001")
      ColOff("wall_cl_0002")
      PlaySE(200024, 50)
      WaitFrame(60)
      Flg.Set("FLAG_GIMMICK_D13_240")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0004"), false)
    end
  elseif gMapNum == 1304 then
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      M235:Event_040()
    end
    if gim_id ~= 401 or Flg.Check("FLAG_MAIN_08_025", "FLAG_MAIN_08_043") then
    elseif Flg.Check("FLAG_MAIN_17_030", "FLAG_MAIN_17_035") then
      M390:Event_031()
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d1304_EnterElv()
    else
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d1304_EnterElv()
    end
  elseif gMapNum == 1305 and gim_id == 400 then
    PlayerLookAtLccatorObject(gim_name)
    MapChange("d", 1304, "start_00", true, 0, 15)
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 1301 then
    PlayerLookAtGimmickObject(gim_name)
    if gim_name == "door_access_01" then
      if Flg.Check("FLAG_MAIN_17_062") then
        Prcs_d1301_ClosedDoor(2)
      elseif Flg.Check("FLAG_MAIN_17_029") then
        Prcs_d1301_OpenDoor("gim_0003", "wall_cl_0001", "door_access_01")
        Flg.Set("FLAG_GIMMICK_D13_010")
      else
        Prcs_d1301_ClosedDoor(1)
      end
    elseif gim_name == "door_access_02" then
      M390:Event_033A()
      if Flg.Check("FLAG_MAIN_17_062") then
        Prcs_d1301_ClosedDoor(2)
      else
        Prcs_d1301_OpenDoor("gim_0004", "wall_cl_0006", "door_access_02")
        Flg.Set("FLAG_GIMMICK_D13_020")
      end
    elseif gim_name == "door_access_03" then
      if Flg.Check("FLAG_MAIN_17_062") then
        Prcs_d1301_ClosedDoor(2)
      elseif Flg.Check("FLAG_MAIN_17_029") then
        Prcs_d1301_OpenDoor("gim_0005", "wall_cl_0003", "door_access_03")
        Flg.Set("FLAG_GIMMICK_D13_030")
      else
        Prcs_d1301_ClosedDoor(1)
      end
    elseif gim_name == "door_access_04" then
      M390:Event_034A()
      if Flg.Check("FLAG_MAIN_17_062") then
        Prcs_d1301_ClosedDoor(2)
      elseif Flg.Check("FLAG_MAIN_17_028") then
        Prcs_d1301_OpenDoor("gim_0006", "wall_cl_0004", "door_access_04")
        Flg.Set("FLAG_GIMMICK_D13_040")
      else
        Prcs_d1301_ClosedDoor(1)
      end
    elseif gim_name == "door_access_05" then
      if Flg.Check("FLAG_MAIN_17_062") then
        Prcs_d1301_ClosedDoor(2)
      elseif Flg.Check("FLAG_MAIN_17_029") then
        Prcs_d1301_OpenDoor("gim_0007", "wall_cl_0005", "door_access_05")
        Flg.Set("FLAG_GIMMICK_D13_050")
      else
        Prcs_d1301_ClosedDoor(1)
      end
    elseif gim_name == "door_access_06" then
      if Flg.Check("FLAG_MAIN_17_062") then
        Prcs_d1301_ClosedDoor(2)
      elseif Flg.Check("FLAG_MAIN_17_029") then
        Prcs_d1301_OpenDoor("gim_0011", "wall_cl_0007", "door_access_06")
        Flg.Set("FLAG_GIMMICK_D13_060")
      else
        Prcs_d1301_ClosedDoor(1)
      end
    end
    if gim_name == "security_01" then
      Flg.Set("FLAG_GIMMICK_D13_110")
      Flg.Set("FLAG_GIMMICK_D13_120")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, gim_name), false)
      FieldObjectSync(OGIM, false)
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      WaitFrame(20)
      INFO_GET_ITEM(793, 1)
      WaitFrame(20)
      AnswerTheCall()
      tlk:Message("f_d1301_0320_0010")
      tlk:Message("f_d1301_0320_0020")
      tlk:EndTalk()
      EndTheCall()
      Flg.Set("FLAG_MAIN_17_038")
      Qst.Main:Set(M390.ID, M390.STEP_055)
    end
    if gim_name == "pc_access_01" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0140_0010")
      tlk:Message("f_d1301_0140_0020")
      tlk:EndTalk()
    elseif gim_name == "pc_access_02" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0430_0010")
      tlk:Message("f_d1301_0430_0020")
      tlk:Message("f_d1301_0430_0030")
      tlk:Message("f_d1301_0430_0040")
      tlk:Message("f_d1301_0430_0050")
      tlk:EndTalk()
    elseif gim_name == "pc_access_03" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0160_0010")
      tlk:EndTalk()
    elseif gim_name == "pc_access_04" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0170_0010")
      tlk:Message("f_d1301_0170_0020")
      if not Flg.Check("FLAG_MAIN_17_029") then
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_17_029") and not Flg.Check("FLAG_GIMMICK_D13_080") then
        AnswerTheCall()
        tlk:Message("f_d1301_0170_0030")
        tlk:EndTalk()
        EndTheCall()
      else
        tlk:EndTalk()
      end
    elseif gim_name == "pc_access_05" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0180_0010")
      tlk:Message("f_d1301_0180_0020")
      tlk:EndTalk()
    elseif gim_name == "pc_access_06" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0450_0010")
      tlk:Message("f_d1301_0450_0020")
      tlk:Message("f_d1301_0450_0030")
      tlk:EndTalk()
    elseif gim_name == "pc_access_07" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0200_0010")
      tlk:Message("f_d1301_0200_0020")
      tlk:Message("f_d1301_0200_0030")
      tlk:EndTalk()
    elseif gim_name == "pc_access_08" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0210_0010")
      tlk:Message("f_d1301_0210_0020")
      tlk:EndTalk()
    elseif gim_name == "pc_access_09" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0060_0010")
      if not Flg.Check("FLAG_MAIN_17_029") then
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_17_029") and not Flg.Check("FLAG_GIMMICK_D13_090") then
        AnswerTheCall()
        tlk:Message("f_d1301_0060_0070")
        tlk:Message("f_d1301_0060_0080")
        EndTheCall()
        if not Flg.Check("FLAG_GIMMICK_D13_080") then
          Talk.Close()
          local enemy_index1 = GetIndex(ENEMY, "enemy_001")
          local enemy_index2 = GetIndex(ENEMY, "enemy_002")
          local enemy_index3 = GetIndex(ENEMY, "enemy_003")
          local enemy_index4 = GetIndex(ENEMY, "enemy_004")
          Field.SymbolForceLeave(enemy_index1, false)
          Field.SymbolForceLeave(enemy_index2, false)
          Field.SymbolForceLeave(enemy_index3, false)
          Field.SymbolForceLeave(enemy_index4, false)
          WaitFrame(30)
          Flg.Set("FLAG_GIMMICK_D13_080")
          FieldObjectSync(ENEMY, false)
          WaitFrame(1)
          local enemy_index = GetIndex(ENEMY, "enemy_005")
          Field.SymbolForceLeave(enemy_index, false)
          WaitFrame(10)
          local slot = Sound.PlaySE(402012, 100)
          Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "e006", 15, 15)
          Prcs_d1301_SwitchingGimmickAccess(room3, true)
          WaitFrame(15)
          Cam.Inst:Set(11.27, 0.62, -6.98, 13.67, 1.72, 2.66, default, 0)
          WaitFrame(15)
          Field.SymbolForceRespawn(enemy_index, false, true)
          Sound.PlaySE(101017, 100)
          Field.ObjectPlayMotionWithStartMoveMotion(ENEMY, enemy_index, "ba02", 10, 10)
          WaitFrame(60)
          Cam.Inst:Clear(0)
          Sound.StopSE(slot, 3)
          tlk:EndTalk()
          M390:Event_040()
        else
          tlk:EndTalk()
        end
      else
        tlk:EndTalk()
      end
    elseif gim_name == "pc_access_10" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0150_0010")
      tlk:Message("f_d1301_0150_0020")
      tlk:EndTalk()
    end
    if gim_name == "wb_access_01" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0220_0010")
      tlk:Message("f_d1301_0220_0020")
      tlk:Message("f_d1301_0220_0030")
      tlk:EndTalk()
    elseif gim_name == "wb_access_02" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0230_0010")
      tlk:Message("f_d1301_0230_0020")
      tlk:Message("f_d1301_0230_0030")
      tlk:EndTalk()
    elseif gim_name == "wb_access_03" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0070_0010")
      tlk:Message("f_d1301_0070_0030")
      if not Flg.Check("FLAG_GIMMICK_D13_080") then
        tlk:EndTalk()
      elseif Flg.Check("FLAG_GIMMICK_D13_080") and not Flg.Check("FLAG_GIMMICK_D13_100") then
        AnswerTheCall()
        tlk:Message("f_d1301_0070_0040")
        tlk:Message("f_d1301_0070_0050")
        EndTheCall()
        if not Flg.Check("FLAG_GIMMICK_D13_090") then
          Talk.Close()
          local enemy_index1 = GetIndex(ENEMY, "enemy_005")
          local enemy_index2 = GetIndex(ENEMY, "enemy_006")
          local enemy_index3 = GetIndex(ENEMY, "enemy_007")
          local enemy_index4 = GetIndex(ENEMY, "enemy_008")
          Field.SymbolForceLeave(enemy_index1, false)
          Field.SymbolForceLeave(enemy_index2, false)
          Field.SymbolForceLeave(enemy_index3, false)
          Field.SymbolForceLeave(enemy_index4, false)
          WaitFrame(30)
          Flg.Set("FLAG_GIMMICK_D13_090")
          FieldObjectSync(ENEMY, false)
          WaitFrame(1)
          Prcs_d1301_SwitchingGimmickAccess(room6, true)
          local enemy_index = GetIndex(ENEMY, "enemy_011")
          Field.SymbolForceLeave(enemy_index, false)
          WaitFrame(10)
          local slot = Sound.PlaySE(402012, 100)
          Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "e006", 15, 15)
          WaitFrame(15)
          Cam.Inst:Set(-9.74, 1.02, 1.53, -13.31, 1.61, -7.78, default, 0)
          WaitFrame(15)
          Field.SymbolForceRespawn(enemy_index, false, true)
          Field.ObjectPlayMotionWithStartMoveMotion(ENEMY, enemy_index, "ba02", 10, 10)
          WaitFrame(60)
          Cam.Inst:Clear(0)
          Sound.StopSE(slot, 3)
          tlk:EndTalk()
          M390:Event_050()
        else
          tlk:EndTalk()
        end
      else
        tlk:EndTalk()
      end
    elseif gim_name == "wb_access_04" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0240_0010")
      tlk:Message("f_d1301_0240_0020")
      tlk:Message("f_d1301_0240_0030")
      tlk:EndTalk()
    elseif gim_name == "wb_access_05" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0440_0010")
      tlk:Message("f_d1301_0440_0020")
      tlk:Message("f_d1301_0440_0030")
      tlk:EndTalk()
    elseif gim_name == "wb_access_06" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0260_0010")
      tlk:Message("f_d1301_0260_0020")
      tlk:Message("f_d1301_0260_0030")
      if Flg.Check("FLAG_GIMMICK_D13_090") then
        tlk:EndTalk()
      else
        AnswerTheCall()
        tlk:Message("f_d1301_0260_0040")
        tlk:Message("f_d1301_0260_0050")
        tlk:EndTalk()
        EndTheCall()
      end
    elseif gim_name == "wb_access_07" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0270_0010")
      tlk:Message("f_d1301_0270_0020")
      tlk:Message("f_d1301_0270_0030")
      tlk:EndTalk()
    end
    if gim_name == "rack_access_01" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0280_0010")
      tlk:Message("f_d1301_0280_0020")
      tlk:Message("f_d1301_0280_0030")
      if Flg.Check("FLAG_GIMMICK_D13_100") then
        tlk:EndTalk()
      else
        AnswerTheCall()
        tlk:Message("f_d1301_0280_0040")
        tlk:Message("f_d1301_0280_0050")
        tlk:EndTalk()
        EndTheCall()
      end
    elseif gim_name == "rack_access_02" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0290_0010")
      tlk:Message("f_d1301_0290_0020")
      tlk:EndTalk()
    elseif gim_name == "rack_access_03" then
      local slot = 0
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0080_0010")
      tlk:Message("f_d1301_0080_0020")
      if not Flg.Check("FLAG_GIMMICK_D13_080") then
        tlk:EndTalk()
      else
        if not Flg.Check("FLAG_GIMMICK_D13_100") then
          Flg.Set("FLAG_GIMMICK_D13_230")
          FieldObjectSync(ENEMY, false)
          WaitFrame(2)
          local enemy_index1 = GetIndex(ENEMY, "enemy_009")
          local enemy_index2 = GetIndex(ENEMY, "enemy_010")
          local enemy_index3 = GetIndex(ENEMY, "enemy_011")
          local enemy_index4 = GetIndex(ENEMY, "enemy_012")
          Field.SymbolForceLeave(enemy_index1, false)
          Field.SymbolForceLeave(enemy_index2, false)
          Field.SymbolForceLeave(enemy_index3, false)
          Field.SymbolForceLeave(enemy_index4, false)
          local enemy_index1 = GetIndex(ENEMY, "enemysecurity_02")
          local enemy_index2 = GetIndex(ENEMY, "enemysecurity_04")
          Field.SymbolForceLeave(enemy_index1, false)
          Field.SymbolForceLeave(enemy_index2, false)
          local enemy_index3 = GetIndex(ENEMY, "enemysecurity_01")
          local enemy_index4 = GetIndex(ENEMY, "enemysecurity_03")
          Field.SymbolForceLeave(enemy_index3, false)
          Field.SymbolForceLeave(enemy_index4, false)
          slot = Sound.PlaySE(402012, 100)
          Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, 1, "e006", 15, 15)
          WaitFrame(30)
          tlk:Message("f_d1301_0080_0030")
          Talk.Close()
          local enemy_index = GetIndex(ENEMY, "enemysecurity_02")
          local enemy_index2 = GetIndex(ENEMY, "enemysecurity_04")
          Cam.Inst:Set(11.28, 1.48, -15.31, 13.65, 1.44, -5.59, default, 0)
          WaitFrame(5)
          Field.SymbolForceRespawn(enemy_index, false, true)
          Field.SymbolForceRespawn(enemy_index2, false, true)
          Sound.PlaySE(101017, 100)
          Field.ObjectPlayMotionWithStartMoveMotion(ENEMY, enemy_index, "ba02", 10, 10)
          WaitFrame(45)
          local enemy_index = GetIndex(ENEMY, "enemysecurity_01")
          local enemy_index2 = GetIndex(ENEMY, "enemysecurity_03")
          Cam.Inst:Set(-16.36, 2.24, -9.57, -7.48, 0.75, -13.91, default, 0)
          WaitFrame(5)
          Field.SymbolForceRespawn(enemy_index, false, true)
          Sound.PlaySE(101017, 100)
          Field.ObjectPlayMotionWithStartMoveMotion(ENEMY, enemy_index, "ba02", 10, 10)
          WaitFrame(10)
          Field.SymbolForceRespawn(enemy_index2, false, true)
          WaitFrame(60)
          Cam.Inst:Clear(0)
          Sound.StopSE(slot, 3)
        end
        if not Flg.Check("FLAG_GIMMICK_D13_110") then
          AnswerTheCall()
          tlk:Message("f_d1301_0080_0040")
          tlk:Message("f_d1301_0080_0050")
          tlk:EndTalk()
          EndTheCall()
          Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "security_01"), true)
          Flg.Set("FLAG_GIMMICK_D13_100")
          M390:Event_060()
        else
          tlk:EndTalk()
        end
      end
    elseif gim_name == "rack_access_04" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0300_0010")
      tlk:Message("f_d1301_0300_0020")
      tlk:Message("f_d1301_0300_0030")
      tlk:EndTalk()
    elseif gim_name == "rack_access_05" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1301_0310_0010")
      tlk:Message("f_d1301_0310_0020")
      tlk:Message("f_d1301_0310_0030")
      tlk:EndTalk()
    elseif gim_name == "rack_access_06" then
    elseif gim_name == "rack_access_07" then
    end
    if gim_name == "security_access" then
      M390:Event_034()
    end
    if gim_name == "server_room_access" then
      M390:Event_035()
    end
  elseif gMapNum == 1302 then
    if gim_name == "door_access_01" then
      M390:Event_602()
      M390:Event_685()
      Prcs_d1302_OpenDoor("gim_0001", "wall_cl_0004", "door_access_01")
      ColOff("wall_cl_0004")
      Flg.Set("FLAG_GIMMICK_D13_130")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "door_access_01"), false)
    elseif gim_name == "door_access_02" then
      Prcs_d1302_OpenDoor("gim_0004", "wall_cl_0002", "door_access_02")
      Flg.Set("FLAG_GIMMICK_D13_140")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "door_access_02"), false)
      MapChange("d", 1303, "start_00", true, FADE_BLACK, FADE_TIME)
    end
    if gim_name == "elv_open_access" then
      M390:Event_603()
      if not Flg.Check("FLAG_MAIN_17_070") then
        Prcs_d1302_OpenShutter()
      else
        Prcs_d1302_OpenShutter_Evt()
        M390:Event_690()
      end
    end
    if gim_name == "elv_access" then
      M390:Event_604()
      Prcs_d1302_CloseShutter()
      if Flg.Check("FLAG_MAIN_17_040", "FLAG_MAIN_17_060") then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        MapChangeWithTimePasses("t", 203, "start_20", NIGHT)
      else
        MapChange("t", 203, "start_20", true, FADE_BLACK, FADE_TIME)
      end
    end
  elseif gMapNum == 1303 then
    if gim_name == "door_access" then
      Flg.Clear("FLAG_GIMMICK_D13_140")
      Prcs_d1302_OpenDoor("gim_0003", "wall_cl_0002", "door_access")
      MapChange("d", 1302, "start_01", true, FADE_BLACK, FADE_TIME)
    end
  elseif gMapNum == 1304 then
    if gim_name == "access_duct_01" then
      local tlk = Tlk:new("d13", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d1304_0040_0010")
      tlk:EndTalk()
    end
    if gim_name == "obj_waepon_01" then
      Cam.Inst:Set(-7.283, 12.1, 7.721, -5.347, 12.997, 17.49, default, 30)
      WaitFrame(30)
      if Flg.Check("FLAG_MAIN_17_061", "FLAG_MAIN_17_070") then
        local tlk = Tlk:new("d13", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1304_0030_0010")
        tlk:EndTalk()
      else
        local tlk = Tlk:new("d13", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1304_0050_0010")
        tlk:EndTalk()
      end
      Cam.Inst:Clear(30)
      WaitFrame(30)
    end
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 1301 then
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
  if gMapNum == 1301 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 1304 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
    if gim_name == "fa_duct_01" then
      M235:Event_035()
    end
  end
end

function OnCheckActModel(act)
end
