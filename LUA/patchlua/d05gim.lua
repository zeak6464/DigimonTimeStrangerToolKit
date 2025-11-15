gGimText = "field_text"
BRK0501 = {}
BRK0503 = {
  obj1 = {
    loc = "fa_0001",
    col = "plan_cl_2000",
    text = -1,
    flag = "FLAG_GIMMICK_D05_260",
    se = 202003
  },
  obj3 = {
    loc = "fa_0003",
    col = "plan_cl_2002",
    text = -1,
    flag = "FLAG_GIMMICK_D05_280",
    se = 202003
  },
  obj50 = {
    loc = "fa_0050",
    col = -1,
    text = -1,
    flag = "FLAG_GIMMICK_D05_390",
    se = 202001
  }
}
BRK0504 = {
  obj1 = {
    loc = "fa_0001",
    col = "plan_cl_2000",
    text = -1,
    flag = "FLAG_GIMMICK_D05_330",
    se = 202003
  },
  obj2 = {
    loc = "fa_0002",
    col = "plan_cl_2001",
    text = -1,
    flag = "FLAG_GIMMICK_D05_340",
    se = 202003
  }
}

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 501 then
    AddLoadList(FLD_OBJ_NPC, {
      "npc_0008",
      motion = {"f001", "f002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0050",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0051",
      motion = {"e001"}
    })
  elseif load_map_num == 502 then
    AddLoadList("camera", {
      CAM_FILE_DUCT
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0011",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0013",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0018",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0017",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0016",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 503 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"e018"},
      move_motion = {
        "hide",
        "cover",
        "cover_end"
      }
    })
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"duct"}
    })
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"ev006_1"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "chr214_observe",
      motion = {"ba02"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "chr595_miner_02",
      motion = {"bn01"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "chr595_miner_03",
      motion = {"bn01"}
    })
    AddLoadList("camera", {
      CAM_FILE_DUCT
    })
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
      motion = {"e001"}
    })
  elseif load_map_num == 504 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"duct"}
    })
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"ev006_1"}
    })
    AddLoadList("camera", {
      CAM_FILE_DUCT
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
  elseif load_map_num == 505 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "Kokuwa_A",
      motion = {"f001"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "Kokuwa_UN",
      motion = {"f001"}
    })
  elseif load_map_num == 506 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d05_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if Flg.Check("FLAG_IS_CHANGE_AEGIOMON") then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
  end
  if gMapNum == 501 then
    if not Flg.Check("FLAG_MAIN_04_094") then
      SetEnableGimmickCheck("gim_0002", false)
    end
    if Flg.Check("FLAG_MAIN_04_091") then
      Obj:new(NPC, "npc_9000"):CancelInvisible(nil, true)
      SetEnableGimmickCheck("change_9001", true)
      SetEnableGimmickCheck("gim_0002", false)
    else
      Obj:new(NPC, "npc_9000"):Invisible()
      SetEnableGimmickCheck("change_9001", false)
    end
    Field.ObjectDisableCulling(FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_9000"))
    if Flg.Check("FLAG_GIMMICK_D05_030") then
      SetEnableGimmickCheck("gim_0050", false)
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0050"), 0, "e001")
      SetEnableGimmickCheck("gim_0051", false)
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0051"), 0, "e001")
      ColOff("wall_cl_8000")
    end
    if Flg.Check("FLAG_MAIN_04_121") then
    else
      SetEnableGimmickCheck("elv_0004", false)
      Obj:new(OGIM, "elv_icon3"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D05_040") then
    else
      Obj:new(OGIM, "elv_icon2"):Invisible()
    end
    SetEnableGimmickCheck("elv_0003", false)
    if Common.CheckTimeAxis("A2028_daft_220", "A2028_daft_10000") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_10000") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_10000") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0050"), 0, "")
      ColOn("wall_cl_8000")
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_540") then
      Obj:new(FLD_OBJ_LOCATOR, "change_0005"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0003"):Invisible()
      Field.ObjectInvisible(NPC, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(FLD_OBJ_POP_POINT, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(FLD_OBJ_TREASURE, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Field_InvisibleFollowerAllPartyMember(1, 0, false)
      Obj:new(FLD_OBJ_LOCATOR, "elv_0001"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "elv_0002"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "elv_icon1"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "elv_icon2"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_GIMMICK, "elv_icon3"):SetEnableCheckAndFieldAttack(false)
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0050"), 0, "")
      ColOn("wall_cl_8000")
      if Flg.Check("FLAG_MAIN_22_517") then
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_01"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_02"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_03"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_04"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_05"), true, FOREVER)
      end
    else
      Field.ObjectCancelInvisible(NPC, FOR_ALL, 1, 0, true, false)
      Field.ObjectCancelInvisible(MOB, FOR_ALL, 1, 0, true, false)
      Field.ObjectCancelInvisible(RUMOR_NPC, FOR_ALL, 1, 0, true, false)
    end
    local npc_index = GetIndex(NPC, "burinp_100")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
    local npc_index = GetIndex(NPC, "M_burinp_100")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
  elseif gMapNum == 502 then
    Obj:new(NPC, "hero_door_0001"):Invisible()
    Obj:new(NPC, "heroine_door_0001"):Invisible()
    Obj:new(NPC, "hero_door_0002"):Invisible()
    Obj:new(NPC, "heroine_door_0002"):Invisible()
    Obj:new(NPC, "hero_door_0003"):Invisible()
    Obj:new(NPC, "heroine_door_0003"):Invisible()
    Obj:new(NPC, "hero_door_0004"):Invisible()
    Obj:new(NPC, "heroine_door_0004"):Invisible()
    Obj:new(NPC, "npc_801"):Invisible()
    Obj:new(NPC, "npc_812"):Invisible()
    Obj:new(NPC, "npc_813"):Invisible()
    Obj:new(NPC, "npc_814"):Invisible()
    Obj:new(NPC, "npc_806"):Invisible()
    Obj:new(NPC, "npc_817"):Invisible()
    Obj:new(NPC, "npc_818"):Invisible()
    Obj:new(NPC, "npc_820"):Invisible()
    Obj:new(NPC, "npc_821"):Invisible()
    Obj:new(NPC, "npc_822"):Invisible()
    if Flg.Check("FLAG_MAIN_04_076") then
      Obj:new(RUMOR_NPC, "rumer_kokuwa"):Invisible()
      Obj:new(NPC, "npc_801"):Invisible()
      Obj:new(NPC, "npc_802"):Invisible()
      Obj:new(NPC, "npc_803"):Invisible()
      Obj:new(NPC, "npc_804"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_04_079") then
      Obj:new(NPC, "npc_807"):Invisible(10)
      Obj:new(NPC, "npc_808"):Invisible(10)
      Obj:new(NPC, "npc_809"):Invisible(10)
      Obj:new(NPC, "npc_810"):Invisible(10)
      Obj:new(NPC, "npc_811"):Invisible(10)
      Obj:new(NPC, "npc_812"):Invisible(10)
      Obj:new(NPC, "npc_813"):Invisible(10)
      Obj:new(NPC, "npc_814"):Invisible(10)
    end
    if Flg.Check("FLAG_MAIN_04_087") then
      Obj:new(RUMOR_NPC, "rumor_0005"):Invisible()
      Obj:new(RUMOR_NPC, "rumor_0006"):Invisible()
      Obj:new(NPC, "npc_805"):Invisible(10)
      Obj:new(NPC, "npc_806"):Invisible(10)
    end
    if Flg.Check("FLAG_MAIN_04_085") then
      Obj:new(RUMOR_NPC, "rumor_0003"):Invisible()
      Obj:new(RUMOR_NPC, "rumor_0007"):Invisible()
      Obj:new(NPC, "npc_816"):Invisible()
      Obj:new(NPC, "npc_817"):Invisible()
      Obj:new(NPC, "npc_818"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_04_088") then
      Obj:new(NPC, "npc_815"):Invisible()
    end
    if not Flg.Check("FLAG_MAIN_04_086") then
      Obj:new(NPC, "npc_827"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_04_092") then
      ColOff("plan_cl_0001")
      local npc_824 = Obj:new(NPC, "npc_824")
      npc_824:Invisible()
      npc_824:SetEnableCheckAndFieldAttack(false)
    end
    if Flg.Check("FLAG_GIMMICK_D05_030") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0018"), 0, "e001")
    else
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0018"), 0, "")
    end
    if Common.CheckTimeAxis("A2028_daft_220", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_10000") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0018"), 0, "")
    end
    if Flg.Check("FLAG_GIMMICK_D05_090") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), 0, "e001")
      ColOff("wall_cl_1001")
      ColOff("wall_cl_1011")
    else
      ColOff("wall_cl_1000")
    end
    if Flg.Check("FLAG_GIMMICK_D05_100") then
      ColOff("wall_cl_1003")
    else
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0002"), 0, "e001")
      ColOff("wall_cl_1002")
      ColOff("wall_cl_1012")
    end
    if Flg.Check("FLAG_GIMMICK_D05_090") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), 0, "e001")
      ColOn("wall_cl_1000")
      ColOff("wall_cl_1001")
      ColOff("wall_cl_1011")
    end
    if Flg.Check("FLAG_GIMMICK_D05_100") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0002"), 0, "e001")
      ColOn("wall_cl_1003")
      ColOff("wall_cl_1002")
      ColOff("wall_cl_1012")
    end
    if Flg.Check("FLAG_GIMMICK_D05_110") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), 0, "e001")
    end
    if Flg.Check("FLAG_GIMMICK_D05_180") then
      print("kiudouzumiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii")
      if Flg.Check("FLAG_GIMMICK_D05_100") then
        Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0002"), 0, "e002")
        ColOff("wall_cl_1003")
        ColOn("wall_cl_1002")
        ColOn("wall_cl_1012")
      else
        Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0002"), 0, "e001")
      end
    else
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0002"), 0, "e002")
      ColOff("wall_cl_1003")
      ColOn("wall_cl_1002")
      ColOn("wall_cl_1012")
      Flg.Set("FLAG_GIMMICK_D05_100")
    end
    if Common.CheckTimeAxis("A2028_daft_220", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_10000") then
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), 0, "e001")
      ColOn("wall_cl_1000")
      ColOff("wall_cl_1001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0002"), 0, "e001")
      ColOff("wall_cl_1002")
      ColOn("wall_cl_1003")
    end
    if not Flg.Check("FLAG_MAIN_04_076") then
      SetEnableGimmickCheck("gim_0007", false)
    end
    if Flg.Check("FLAG_GIMMICK_D05_140") then
      SetEnableGimmickCheck("gim_0005", false)
      SetEnableGimmickCheck("gim_0008", false)
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0011"), 0, "e001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0003"), 0, "e001")
      ColOff("wall_cl_0001")
    end
    if Flg.Check("FLAG_GIMMICK_D05_060") then
      SetEnableGimmickCheck("gim_0006", false)
      SetEnableGimmickCheck("gim_0010", false)
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0017"), 0, "e001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0016"), 0, "e001")
      ColOff("wall_cl_0005")
    end
    if Flg.Check("FLAG_GIMMICK_D05_190") then
      SetEnableGimmickCheck("gim_0013", false)
      ColOff("wall_cl_0003")
    end
    if Flg.Check("FLAG_GIMMICK_D05_500") then
      Obj:new(NPC, "chr341_enemy"):Invisible()
      ColOff("evt_8000")
      if not Flg.Check("FLAG_GIMMICK_D05_170") then
        local gender = GetGender()
        if gender == HERO then
          Obj:new(NPC, "hero_door_0002"):CancelInvisible()
        elseif gender == HEROINE then
          Obj:new(NPC, "heroine_door_0002"):CancelInvisible()
        end
      end
    end
    if Flg.Check("FLAG_GIMMICK_D05_480") then
      Prcs_d0502_DuctAccessIsEntrance(true)
    else
      Prcs_d0502_DuctAccessIsEntrance(false)
    end
    if Flg.Check("FLAG_IS_DUCT") then
      SetEnableGimmickCheck("gim_0050", false)
      SetEnableGimmickCheck("gim_0057", false)
      SetEnableGimmickCheck("gim_0060", false)
      SetEnableGimmickCheck("gim_0051", false)
      SetEnableGimmickCheck("gim_0058", false)
      SetEnableGimmickCheck("gim_0059", false)
      SetEnableGimmickCheck("gim_0061", false)
      SetProhibitPlayerOnlyOperate(true)
    end
    if Flg.Check("FLAG_IS_CHANGE_AEGIOMON") then
      SetProhibitPlayerOnlyOperate(true)
    end
    if Flg.Check("FLAG_MAIN_04_081") and Flg.Check("FLAG_MAIN_04_082") and Flg.Check("FLAG_MAIN_04_083") then
      FieldObjectSync(MOB, false)
      local gim = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_03")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim, true)
    else
      local gim = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_03")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim, false)
    end
    if not Flg.Check("FLAG_MAIN_04_095") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_01"), false)
    end
  elseif gMapNum == 503 then
  elseif gMapNum == 504 then
    if Flg.Check("FLAG_GIMMICK_D05_290") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      ColOff("plan_cl_1000")
      ColOn("plan_cl_1001")
    else
      ColOff("plan_cl_1001")
      ColOn("plan_cl_1000")
    end
    for key in pairs(BRK0504) do
      if Flg.Check(BRK0504[key].flag) then
        Obj:new(FLD_OBJ_LOCATOR, BRK0504[key].loc):Invisible()
        ColOff(BRK0504[key].col)
      end
    end
  elseif gMapNum == 505 then
    Field.ObjectDisableCulling(FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "npc_9000"))
    Field.ObjectDisableCulling(OGIM, GetIndex(OGIM, "L_hand"))
    Field.ObjectDisableCulling(OGIM, GetIndex(OGIM, "R_hand"))
    if Flg.Check("FLAG_GIMMICK_D05_360") then
      SetEnableGimmickCheck("gim_0001", false)
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), 0, "e001")
      ColOff("wall_cl_0001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0002"), 0, "e001")
      Motion.Object:PlayFinishedAnim(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0003"), 0, "e001")
    end
    if not Flg.Check("FLAG_GIMMICK_D05_160") then
      Obj:new(NPC, "npc_0002"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D05_360") and not Flg.Check("FLAG_MAIN_04_121") then
      local pos = Field.GetLocatorPosition("gim_0002")
      local index = GetIndex(FLD_OBJ_NPC, "Kokuwa_A")
      Field.ObjectSetRotationY(FLD_OBJ_NPC, index, 180, 0)
      Field.ObjectSetPos(FLD_OBJ_NPC, index, pos.x, pos.y, pos.z + 1.2)
      Field.ObjectPlayMotion(FLD_OBJ_NPC, index, "f001", 5, true)
      local pos = Field.GetLocatorPosition("gim_0003")
      local index = GetIndex(FLD_OBJ_NPC, "Kokuwa_UN")
      Field.ObjectSetRotationY(FLD_OBJ_NPC, index, 180, 0)
      Field.ObjectSetPos(FLD_OBJ_NPC, index, pos.x, pos.y, pos.z + 1.2)
      Field.ObjectLoadMotion(FLD_OBJ_NPC, index, "f001")
      Field.ObjectPlayMotion(FLD_OBJ_NPC, index, "f001", 5, true)
    else
      Obj:new(NPC, "Kokuwa_UN"):Invisible()
      Obj:new(NPC, "Kokuwa_A"):Invisible()
    end
  elseif gMapNum == 506 then
  elseif gMapNum == 507 then
    Obj:new(NPC, "npc0008"):Invisible()
  elseif gMapNum == 508 then
    Obj:new(NPC, "npc0008"):Invisible()
  elseif gMapNum == 509 then
    Obj:new(NPC, "npc0008"):Invisible()
  elseif gMapNum == 513 then
    Obj:new(NPC, "npc0008"):Invisible()
    Obj:new(NPC, "npc0009"):Invisible()
  elseif gMapNum == 550 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 551 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 552 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  local npc_text = "d05"
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 501 then
    if col_name == "evt_0100" then
      require("S110_099")
      S110_099:Event_030()
    end
    if col_name == "evt_1001" then
      M150:Event_115()
    end
    if col_name == "evt_1002" then
      M150:Event_195()
    end
    if col_name == "evt_4004" then
      M150:Event_050()
      M310:Event_030()
    end
    if col_name == "evt_4000" then
      M150:Event_060()
    end
    if col_name == "evt_4001" then
      M150:Event_070()
    end
    if col_name == "evt_9904" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9902" or col_name == "evt_9905" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9903" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if Common.CheckTimeAxis("A2028_daft_220", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_300", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_300", "Z2028_daft_10000") then
      if col_name == "evt_3000" then
        Prcs_d05_ParkGate_In(100, 30, 280, 30, 1, "evt_3000", "evt_3001")
      elseif col_name == "evt_3001" then
        Prcs_d05_ParkGate_Out(280, 30, 1, "evt_3000", "evt_3001")
      end
      if col_name == "evt_3002" then
        Prcs_d05_ParkGate_In(180, 30, 0, 30, 2, "evt_3002", "evt_3003")
      elseif col_name == "evt_3003" then
        Prcs_d05_ParkGate_Out(0, 30, 2, "evt_3002", "evt_3003")
      end
      if col_name == "evt_3004" then
      elseif col_name == "evt_1001" then
      end
    end
    if col_name == "evt_5001" then
      M310:Event_110()
    end
  elseif gMapNum == 502 then
    if col_name == "evt_0100" then
      M150:Event_180AA()
    end
    if col_name == "evt_1100" then
      M150:Event_118()
    end
    if col_name == "evt_1102" then
      M150:Event_180()
    end
    if col_name == "evt_4000" and not Flg.Check("FLAG_MAIN_04_075") then
      Flg.Set("FLAG_MAIN_04_075")
      local tlk = Tlk:new("d05", 1, true)
      tlk:StartTalk()
      Cam.Inst:Set(33.07, 0.96, 68.29, 24.04, 4.87, 70.11, default, 30)
      WaitFrame(30)
      Talk.NextNoVoice()
      tlk:Message("f_d0502_0010_0010")
      tlk:Message("f_d0502_0010_0015")
      tlk:EndTalk()
      Cam.Inst:Clear(30)
    end
    if col_name == "evt_2000" or col_name == "evt_2001" or col_name == "evt_2002" then
      Field.CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
      Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
    end
    if not Flg.Check("FLAG_MAIN_04_079") and col_name == "evt_1101" then
      Cam.Inst:Set(85.737, -2.245, 79.121, 75.832, -0.889, 78.88, default, 30)
      local mekanori01_bn02 = Motion.Object:new(NPC, "npc_807", "bn02")
      local mekanori02_e500 = Motion.Object:new(NPC, "npc_807", "e500")
      local kame01_bn02 = Motion.Object:new(NPC, "npc_808", "bn02")
      local kame02_fe04 = Motion.Object:new(NPC, "npc_808", "fe04")
      local clock01_bn02 = Motion.Object:new(NPC, "npc_809", "bn02")
      local clock02_fq02 = Motion.Object:new(NPC, "npc_809", "fq02")
      Field_Talk_Start("d05", 1)
      Flg.Set("FLAG_FIELD_D502_020")
      mekanori02_e500:Play(10, true)
      Message("f_d0502_0090_0030")
      kame02_fe04:Play(10, true)
      Message("f_d0502_0090_0040")
      clock02_fq02:Play(10, true)
      Message("f_d0502_0090_0050")
      Field_Talk_End()
      mekanori01_bn02:Play(10, true)
      kame01_bn02:Play(10, true)
      clock01_bn02:Play(10, true)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
    end
    if Flg.Check("FLAG_MAIN_04_089") and not Flg.Check("FLAG_MAIN_04_087") then
      if col_name == "evt_2003" then
        Field_Talk_Start("d05", 1)
        Message("f_d0502_0100_0070")
        MovePlayerToRelativePosFrame(0, -1, 20)
        Field_Talk_End()
        WaitFrame(20)
      end
      if col_name == "evt_2004" then
        Field_Talk_Start("d05", 1)
        Message("f_d0502_0100_0070")
        MovePlayerToRelativePosFrame(1, 0, 20)
        Field_Talk_End()
      end
    end
    if col_name == "evt_9002" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0006", "duct_0005", "followcam_default_loc", 130, false)
        Field.FollowerWarp()
        Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
        Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
        Flg.Clear("FLAG_IS_DUCT")
        Obj:new(NPC, "hero_door_0002"):Invisible(30)
        Obj:new(NPC, "heroine_door_0002"):Invisible(30)
        Prcs_d0502_DuctAccessIsEntrance(true)
      end
    elseif col_name == "evt_9003" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0005", "duct_0006", "followcam_default_loc", -50, true)
        Field.FollowerWarp()
        Field_InvisibleFollowerAllPartyMember(0, 20, false)
        Field_InvisibleFollowerAllGuest(0, 20, false)
        Flg.Clear("FLAG_IS_DUCT")
        Prcs_d0502_DuctAccessIsEntrance(false)
        if not Flg.Check("FLAG_MAIN_04_085") then
          SetFollowerCameraOperateRotation(10, 90, 45)
        end
      end
    elseif col_name == "evt_9008" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0005", "duct_0017", "followcam_default_loc", -50, true)
        Field.FollowerWarp()
        Field_InvisibleFollowerAllPartyMember(0, 20, false)
        Field_InvisibleFollowerAllGuest(0, 20, false)
        Flg.Clear("FLAG_IS_DUCT")
        Prcs_d0502_DuctAccessIsEntrance(false)
      end
    elseif col_name == "evt_9009" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0019", "duct_0025", "followcam_default_loc", -50, false)
        Field.FollowerWarp()
        Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
        Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
        Flg.Clear("FLAG_IS_DUCT")
        Prcs_d0502_DuctAccessIsEntrance(true)
      end
    elseif col_name == "evt_9010" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0025", "duct_0019", "followcam_default_loc", -50, true)
        Field.FollowerWarp()
        Field_InvisibleFollowerAllPartyMember(0, 20, false)
        Field_InvisibleFollowerAllGuest(0, 20, false)
        Flg.Clear("FLAG_IS_DUCT")
        Prcs_d0502_DuctAccessIsEntrance(false)
        M150:Event_180CB()
      end
    elseif col_name == "evt_9011" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0030", "duct_0028", "followcam_default_loc", -50, false)
        Field.FollowerWarp()
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Flg.Clear("FLAG_IS_DUCT")
        Obj:new(NPC, "hero_door_0001"):Invisible()
        Obj:new(NPC, "heroine_door_0001"):Invisible()
        Prcs_d0502_DuctAccessIsEntrance(true)
      end
    elseif col_name == "evt_9012" and Flg.Check("FLAG_IS_DUCT") then
      EndDuct("duct_0028", "duct_0030", "followcam_default_loc", -50, true)
      Field.FollowerWarp()
      Field_InvisibleFollowerAllPartyMember(0, 20, false)
      Field_InvisibleFollowerAllGuest(0, 20, false)
      Flg.Clear("FLAG_IS_DUCT")
      Prcs_d0502_DuctAccessIsEntrance(false)
      M150:Event_133()
    end
    if col_name == "evt_1003" and not Flg.Check("FLAG_GIMMICK_D05_490") then
      Flg.Set("FLAG_GIMMICK_D05_490")
      M150:Event_130()
    end
    if col_name == "evt_1000" then
      M150:Event_160()
    end
    if col_name == "evt_1005" then
      M150:Event_140()
    end
    if col_name == "evt_1006" then
      M150:Event_150()
    end
    if col_name == "evt_3000" then
      M150:Event_165()
    end
  elseif gMapNum == 503 then
    if col_name == "evt_0100" and Flg.Check("FLAG_GIMMICK_D05_220") and not Flg.Check("FLAG_GIMMICK_D05_400") then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start(npc_text, 1)
      Message(40505010)
      MessageTalkSel(2, 406100)
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_End()
        EncountFromField(30503297, 10572, false)
      elseif result == RESULT_TALK01 then
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        MovePlayerFrame(-40, 6, 15)
        Field_Talk_End()
      end
    end
    if (col_name == "evt_0101" or col_name == "evt_0102") and Flg.Check("FLAG_GIMMICK_D05_220") and not Flg.Check("FLAG_GIMMICK_D05_420") then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start(npc_text, 1)
      Message(40507010)
      MessageTalkSel(2, 406100)
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_End()
        EncountFromField(30503298, 10572, false)
      elseif result == RESULT_TALK01 then
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        if col_name == "evt_0101" then
          MovePlayerFrame(-100, 6, 15)
        elseif col_name == "evt_0102" then
          MovePlayerFrame(170, 6, 15)
        end
        Field_Talk_End()
      end
    end
    if col_name == "evt_9000" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0002", "duct_0001", "followcam_default_loc", 300, false)
        Flg.Clear("FLAG_IS_DUCT")
      end
    elseif col_name == "evt_9001" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0001", "duct_0002", "followcam_default_loc", 120, true)
        Flg.Clear("FLAG_IS_DUCT")
      end
    elseif col_name == "evt_9003" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0008", "duct_0007", "followcam_default_loc", 120, true)
        Flg.Clear("FLAG_IS_DUCT")
      end
    elseif col_name == "evt_9004" and Flg.Check("FLAG_IS_DUCT") then
      EndDuct("duct_0007", "duct_0008", "followcam_default_loc", 120, true)
      Flg.Clear("FLAG_IS_DUCT")
    end
    if col_name == "evt_9500" and not Flg.Check("FLAG_IS_CHANGE_AEGIOMON") then
      if not Flg.Check("FLAG_GIMMICK_D05_050") then
        Field_Talk_Start(gGimText, 1)
        MessageAuto(1050300005, 30)
        Cam.Inst:Set(-31.59, 6.04, 32.02, -24.03, 7.45, 38.41, default, 30)
        WaitFrame(30)
        MessageAuto(1050300006, 30)
        Cam.Inst:Clear(30)
        WaitFrame(30)
        MessageAuto(1050300007, 30)
        Field_Talk_End()
      else
        Field_Talk_Start(gGimText, 1)
        MessageAuto(1050300008, 30)
        Field_Talk_End()
      end
      Motion.Player:ResetMoveAnim()
      PlayerModelChange(AEGIOMON)
      FadeOutWithWait(0, 15)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field.SetPlayerLocator("script_aegiostart01")
      Field.CheckSyncPlayerModel(true)
      Flg.Set("FLAG_IS_CHANGE_AEGIOMON")
      local gender = GetGender()
      if gender == HERO then
        Obj:new(NPC, "hero_waiting"):CancelInvisible(nil, true)
        if Flg.Check("FLAG_GIMMICK_D05_050") then
          Obj:new(NPC, "hero_waiting02"):CancelInvisible(nil, true)
        end
      elseif gender == HEROINE then
        Obj:new(NPC, "heroine_waiting"):CancelInvisible(nil, true)
        if Flg.Check("FLAG_GIMMICK_D05_050") then
          Obj:new(NPC, "heroine_waiting02"):CancelInvisible(nil, true)
        end
      end
      FadeInWithWait(0, 15)
    end
    if col_name == "evt_9501" and Flg.Check("FLAG_IS_CHANGE_AEGIOMON") then
      Field_Talk_Start(gGimText, 1)
      MessageAuto(1050300009, 30)
      Motion.Player:ResetMoveAnim()
      CancelPlayerModelChange()
      FadeOutWithWait(0, 15)
      Field.CheckSyncPlayerModel(false)
      Field_CancelInvisibleFollowerAllGuest(0, 0, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
      Field.SetPlayerLocator("script_playerstart01")
      Field.CheckSyncPlayerModel(false)
      Flg.Clear("FLAG_IS_CHANGE_AEGIOMON")
      Flg.Set("FLAG_GIMMICK_D05_050")
      Field_Talk_End()
      local gender = GetGender()
      if gender == HERO then
        Obj:new(NPC, "hero_waiting"):Invisible()
        Obj:new(NPC, "hero_waiting02"):Invisible()
      elseif gender == HEROINE then
        Obj:new(NPC, "heroine_waiting"):Invisible()
        Obj:new(NPC, "heroine_waiting02"):Invisible()
      end
      FadeInWithWait(0, 15)
      ColOff("evt_9503")
    end
    if col_name == "evt_9502" and Flg.Check("FLAG_IS_CHANGE_AEGIOMON") then
      if not Flg.Check("FLAG_GIMMICK_D05_050") then
        Field_Talk_Start("d05", 1)
        Message(408101)
        Field_Talk_End()
        MovePlayerFrame(360, 6, 15)
        WaitFrame(15)
      else
        Field_Talk_Start(gGimText, 1)
        MessageAuto(1050300009, 30)
        Motion.Player:ResetMoveAnim()
        CancelPlayerModelChange()
        FadeOutWithWait(0, 15)
        Field.CheckSyncPlayerModel(false)
        Field_CancelInvisibleFollowerAllGuest(0, 0, false, false)
        Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
        Field.SetPlayerLocator("script_playerstart02")
        Field.CheckSyncPlayerModel(false)
        Flg.Clear("FLAG_IS_CHANGE_AEGIOMON")
        Field_Talk_End()
        local gender = GetGender()
        if gender == HERO then
          Obj:new(NPC, "hero_waiting"):Invisible()
          Obj:new(NPC, "hero_waiting02"):Invisible()
        elseif gender == HEROINE then
          Obj:new(NPC, "heroine_waiting"):Invisible()
          Obj:new(NPC, "heroine_waiting02"):Invisible()
        end
        FadeInWithWait(0, 15)
        ColOff("evt_9503")
      end
    elseif col_name == "evt_9503" and Flg.Check("FLAG_IS_CHANGE_AEGIOMON") and not Flg.Check("FLAG_GIMMICK_D05_210") then
      Field_Talk_Start("d05", 1)
      Message(408102)
      Field_Talk_End()
      MovePlayerFrame(150, 6, 15)
      WaitFrame(15)
    end
    if col_name == "evt_3000" then
      Field_Talk_Start("d05", 1)
      Message(408100)
      Field_Talk_End()
      MovePlayerFrame(270, 6, 15)
      WaitFrame(15)
    end
  elseif gMapNum == 504 then
    if col_name == "evt_9000" then
      if Flg.Check("FLAG_IS_DUCT") then
        EndDuct("duct_0002", "duct_0001", "followcam_default_loc", 180, false)
        Flg.Clear("FLAG_IS_DUCT")
      end
    elseif col_name == "evt_9001" and Flg.Check("FLAG_IS_DUCT") then
      EndDuct("duct_0001", "duct_0002", "followcam_default_loc", 15, true)
      Flg.Clear("FLAG_IS_DUCT")
    end
  elseif gMapNum == 505 then
    if col_name == "evt_1000" and Flg.Check("FLAG_MAIN_04_123", "FLAG_MAIN_04_130") then
      local tlk = Tlk:new("d05", 1, true)
      tlk:StartTalk()
      Cam.Inst:Set(-29.505, 2.62, -11.998, -20.249, 4.7, -8.834, default, 45)
      WaitFrame(45)
      tlk:Message("f_d0505_0010_0010")
      Cam.Inst:Clear(45)
      WaitFrame(45)
      MovePlayerToRelativePosFrame(0, -1, 20)
      WaitFrame(10)
      tlk:EndTalk()
    end
  elseif gMapNum == 506 and col_name == "evt_0001" and not Flg.Check("FLAG_MAIN_12_015") then
    local npc_index01 = GetIndex(NPC, "npc_0015")
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_PLAYER, 1, 1)
    Cam.Inst:Set(0.364, 0.529, 61.63, -2.984, 2.2629, 70.89, default, 1)
    Field_Talk_Start("d05", 1)
    Message("f_d0506_0180_0010")
    MovePlayerToRelativePosFrame(0, 2, 30)
    WaitFrame(40)
    Field_Talk_End()
    Cam.Inst:Clear(0)
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 501 then
    if gim_id == 404 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      Fade_OutNoLoadingWithWait(FADE_BLACK, 15)
      WaitFrame(10)
      local SEslot_1 = Sound.PlaySE(403006, 100)
      WaitFrame(10)
      MapChange("d", 505, "start_03", false, 0, 0)
    end
    if gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 550, "start_00")
    elseif gim_id == 402 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 551, "start_00")
    elseif gim_id == 403 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 552, "start_00")
    elseif gim_id == 406 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor_NoFade(gim_loc, "")
      M440:Event_833()
    elseif gim_id == 407 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor_NoFade(gim_loc, "")
      M440:Event_835()
    end
    if gim_name == "gim_0002" then
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_MAIN_04_091") then
        Field_Talk_Start_Not_LetterBox("d05", 1)
        Message("f_d0501_0210_0010")
        Field_Talk_End_Not_LetterBox()
      else
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        M150:Event_210()
      end
    end
    if gim_id == 50 then
    end
    if gim_id ~= 51 or not Flg.Check("FLAG_MAIN_04_060") then
    end
    if Common.IsExistGuest(21391) then
      Obj:new(NPC, "Guest_raidramon"):Invisible()
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
    if gim_id == 408 then
      GoToTheaterWithEvt(51, "theater_0002")
    end
    if gim_name == "gim_1101" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject("lookat_01")
      local tlk = Tlk:new("field_text", 1, true)
      tlk:StartTalk()
      tlk:Message("g_wm_0030_0010")
      tlk:EndTalk()
      Flg.Set("FLAG_ISAREA_CHANGE_FOR_BLIMP")
      OpenWorldMap(DW, BLIMPMON)
      Flg.Clear("FLAG_ISAREA_CHANGE_FOR_BLIMP")
    end
  elseif gMapNum == 502 then
    if gim_id == 352 then
      StartDuct("duct_0001", "duct_0003", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
    elseif gim_id == 357 then
      PlayerLookAtLccatorObject(gim_name)
      StartDuct("duct_0005", "duct_0007", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
      Field_InvisibleFollowerAllPartyMember(0, 20, false)
      Field_InvisibleFollowerAllGuest(0, 20, false)
      Prcs_d0502_DuctAccessAllOff()
    elseif gim_id == 358 then
      PlayerLookAtLccatorObject(gim_name)
      StartDuct("duct_0006", "duct_0008", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
      Prcs_d0502_DuctAccessAllOff()
    elseif gim_id == 359 then
      PlayerLookAtLccatorObject(gim_name)
      StartDuct("duct_0017", "duct_0018", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
      Field_InvisibleFollowerAllPartyMember(0, 20, false)
      Field_InvisibleFollowerAllGuest(0, 20, false)
      Prcs_d0502_DuctAccessAllOff()
    elseif gim_id == 361 then
      PlayerLookAtLccatorObject(gim_name)
      StartDuct("duct_0019", "duct_0020", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
      Field_InvisibleFollowerAllPartyMember(0, 20, false)
      Field_InvisibleFollowerAllGuest(0, 20, false)
      Prcs_d0502_DuctAccessAllOff()
    elseif gim_id == 360 then
      PlayerLookAtLccatorObject(gim_name)
      StartDuct("duct_0025", "duct_0026", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
      Field_InvisibleFollowerAllPartyMember(0, 20, false)
      Field_InvisibleFollowerAllGuest(0, 20, false)
      Prcs_d0502_DuctAccessAllOff()
    elseif gim_id == 350 then
      PlayerLookAtLccatorObject(gim_name)
      StartDuct("duct_0031", "duct_0027", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
      Field_InvisibleFollowerAllPartyMember(0, 20, false)
      Field_InvisibleFollowerAllGuest(0, 20, false)
      Prcs_d0502_DuctAccessAllOff()
    elseif gim_id == 351 then
      PlayerLookAtLccatorObject(gim_name)
      StartDuct("duct_0032", "duct_0029", "es_d0502_duct01")
      Flg.Set("FLAG_IS_DUCT")
      Field_InvisibleFollowerAllPartyMember(0, 20, false)
      Field_InvisibleFollowerAllGuest(0, 20, false)
      Prcs_d0502_DuctAccessAllOff()
    end
    if gim_id == 13 then
      PlayerLookAtLccatorObject(gim_name)
      if not Flg.Check("FLAG_GIMMICK_D05_190") then
        Prcs_d05_OpenSlideDoor("gim_0013", "wall_cl_0003")
        Flg.Set("FLAG_GIMMICK_D05_190")
      end
    end
    if gim_id == 6 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start("d05", 1)
      Message("f_d0502_0100_0040")
      Field_Talk_End()
    end
    if gim_id == fa_obstacles_03 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start("d05", 1)
      Message("f_d0502_0100_0040")
      Field_Talk_End()
    end
    if gim_id == 7 then
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_MAIN_04_076") then
        if not Flg.Check("FLAG_GIMMICK_D05_110") then
          if 1 <= Item.GetNum(727) then
            local tlk = Tlk:new("d05", 1, true)
            tlk:StartTalk()
            tlk:Message("f_d0502_0050_0010")
            tlk:EndTalk()
            PlaySE(300219, 100)
            INFO_USE_ITEM(727, 1)
            WaitFrame(40)
            Flg.Set("FLAG_GIMMICK_D05_070")
            Prcs_d0502_MoveCraneEvent_01()
            local tlk = Tlk:new("d05", 1, true)
            tlk:StartTalk()
            tlk:Message("f_d0502_0050_0020")
            tlk:EndTalk()
            Flg.Set("FLAG_GIMMICK_D05_110")
            Obj:new(NPC, "npc_801"):Invisible(30)
            M150:Event_125()
          else
            local tlk = Tlk:new("d05", 1, true)
            tlk:StartTalk()
            tlk:Message("f_d0502_0020_0010")
            tlk:EndTalk()
          end
        else
          Prcs_d0502_MoveCraneEvent_01()
        end
      else
        local tlk = Tlk:new("d05", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0502_0060_0010")
        tlk:EndTalk()
      end
    elseif gim_id == 8 then
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_MAIN_04_076") then
        if 1 <= Item.GetNum(727) then
          local tlk = Tlk:new("d05", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d0502_0050_0010")
          tlk:EndTalk()
          PlaySE(300219, 100)
          INFO_USE_ITEM(727, 1)
          WaitFrame(40)
          Item.Add(727, -1)
          Prcs_d0502_OpenShutter_05()
          M150:Event_190()
        else
          local tlk = Tlk:new("d05", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d0502_0020_0010")
          tlk:EndTalk()
        end
      else
        local tlk = Tlk:new("d05", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0502_0060_0010")
        tlk:EndTalk()
      end
    elseif gim_id == 9 then
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_MAIN_04_076") then
        if not Flg.Check("FLAG_GIMMICK_D05_180") then
          if 1 <= Item.GetNum(727) then
            local tlk = Tlk:new("d05", 1, true)
            tlk:StartTalk()
            tlk:Message("f_d0502_0050_0010")
            tlk:EndTalk()
            PlaySE(300219, 100)
            WaitFrame(40)
            INFO_USE_ITEM(727)
            Prcs_d0502_MoveCraneEvent_02()
            local tlk = Tlk:new("d05", 1, true)
            tlk:StartTalk()
            tlk:Message("f_d0502_0050_0020")
            tlk:EndTalk()
            Flg.Set("FLAG_GIMMICK_D05_180")
            Obj:new(NPC, "npc_801"):Invisible(30)
            M150:Event_175()
          else
            local tlk = Tlk:new("d05", 1, true)
            tlk:StartTalk()
            tlk:Message("f_d0502_0020_0010")
            tlk:EndTalk()
          end
        else
          Prcs_d0502_MoveCraneEvent_02()
        end
      else
        local tlk = Tlk:new("d05", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0502_0060_0010")
        tlk:EndTalk()
      end
    elseif gim_id == 10 then
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_MAIN_04_076") then
        if 1 <= Item.GetNum(727) then
          local tlk = Tlk:new("d05", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d0502_0050_0010")
          tlk:EndTalk()
          PlaySE(300219, 100)
          INFO_USE_ITEM(727, 1)
          WaitFrame(40)
          Item.Add(727, -1)
          Prcs_d0502_OpenShutter_04()
          M150:Event_145()
        else
          local tlk = Tlk:new("d05", 1, true)
          tlk:StartTalk()
          tlk:Message("f_d0502_0020_0010")
          tlk:EndTalk()
        end
      else
        local tlk = Tlk:new("d05", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0502_0060_0010")
        tlk:EndTalk()
      end
    end
  elseif gMapNum == 503 then
    if gim_id == 1 or gim_id == 2 or gim_id == 3 then
      Prcs_d0503_OperateShaftGim(gim_id)
    end
    if gim_id == 5 then
      Field_Talk_Start(gGimText, 1)
      Message(1050300011)
      Field_Talk_End()
    end
    if gim_id == 20 then
      Prcs_d0503_CoverAction(40, "right", gim_loc)
    elseif gim_id == 23 then
      Prcs_d0503_CoverAction(220, "right", gim_loc)
    elseif gim_id == 22 then
      Prcs_d0503_CoverAction(-14, "left", gim_loc)
    elseif gim_id == 25 then
      Prcs_d0503_CoverAction(165, "left", gim_loc)
    end
    if gim_id == 101 then
      if not Flg.Check("FLAG_GIMMICK_D05_220") then
        Field_Talk_Start(gGimText, 1)
        Message(2000)
        Field_Talk_End()
      end
    elseif gim_id == 102 and not Flg.Check("FLAG_GIMMICK_D05_230") then
      Field_Talk_Start(gGimText, 1)
      Message(2000)
      Field_Talk_End()
    end
    if gim_id == 13 then
      if 1 <= Item.GetNum(721) then
        Prcs_d0503_OpenSteamEngineDoor_03()
      else
        Field_Talk_Start(gGimText, 1)
        Message(1050300003)
        Field_Talk_End()
      end
    end
    if gim_id == 350 then
      StartDuct("duct_0001", "duct_0003")
      Flg.Set("FLAG_IS_DUCT")
    elseif gim_id == 351 then
      StartDuct("duct_0002", "duct_0004")
      Flg.Set("FLAG_IS_DUCT")
    elseif gim_id == 353 then
      StartDuct("duct_0007", "duct_0009")
      Flg.Set("FLAG_IS_DUCT")
    elseif gim_id == 352 then
      StartDuct("duct_0008", "duct_0010")
      Flg.Set("FLAG_IS_DUCT")
    elseif gim_id == 500 then
      Prcs_d05_Digmonride("script_digpoint01", 1, 1)
    elseif gim_id == 501 then
      Prcs_d05_Digmonride("script_digpoint02", 3, 3)
    elseif gim_id == 502 then
      Prcs_d05_Digmonride("script_digpoint03", 3, 3)
    end
  elseif gMapNum == 504 then
    if gim_id == 350 then
      StartDuct("duct_0001", "duct_0003")
      Flg.Set("FLAG_IS_DUCT")
    elseif gim_id == 351 then
      StartDuct("duct_0002", "duct_0004")
      Flg.Set("FLAG_IS_DUCT")
    elseif gim_id == 501 then
      Prcs_d05_Digmonride("script_digpoint01", 1, 1)
    elseif gim_id == 502 then
      Prcs_d05_Digmonride("script_digpoint02", 2, 1)
    elseif gim_id == 504 then
      Prcs_d05_Digmonride("script_digpoint04", 3, 3)
    end
  elseif gMapNum == 505 then
    if gim_id == 1 then
      PlayerLookAtGimmickObject("lookat_door")
      if not Flg.Check("FLAG_GIMMICK_D05_360") and M150:Event_230() then
        Prcs_d0505_OpenControlRoomDoor()
        Sound.StopBGM(3)
        M150:Event_240()
      end
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 506 then
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 550 then
    if gim_id == 400 then
      FadeOutWithWait(0, 15)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      DoorMapChange("d", 501, "start_10")
    end
  elseif gMapNum == 551 then
    if gim_id == 400 then
      FadeOutWithWait(0, 15)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      DoorMapChange("d", 501, "start_11")
    end
  elseif gMapNum == 552 and gim_id == 400 then
    FadeOutWithWait(0, 15)
    Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
    PlaySE(200001, 100)
    DoorMapChange("d", 501, "start_12")
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 501 then
    if gim_name == "access_arena01" then
      Prcs_d05_ArenaWarpIn("access_arena01")
      MapChange("d", 506, "start_00", true, 0, 15)
    end
    if gim_name == "access_door01" then
      if Flg.Check("FLAG_FIELD_D501_FACTORY_OUT") then
        Prcs_d05_ParkGate_Out(272, 75, 3, "evt_3004", "evt_1001")
        Flg.Clear("FLAG_FIELD_D501_FACTORY_OUT")
      else
        Prcs_d05_ParkGate_In(90, 50, 272, 30, 3, "evt_3004", "evt_3005")
      end
    elseif gim_name == "access_rokomon01" then
      local tlk = Tlk:new("d05", 1, false)
      tlk:StartTalk()
      tlk:Message("f_d0501_0410_0010")
      tlk:EndTalk()
    end
  end
  if gMapNum == 502 and gim_name == "fa_obstacles_01" then
    PlayerLookAtGimmickObject(gim_name)
    Field_Talk_Start("d05", 1)
    Message("f_d0502_0160_0010")
    Field_Talk_End()
  end
  if gMapNum == 505 and gim_name == "arubura_access" then
    PlayerLookAtGimmickObject("lookat_arubura")
    Fade_OutNoLoadingWithWait(FADE_BLACK, 15)
    WaitFrame(10)
    local SEslot_1 = Sound.PlaySE(400010, 100)
    WaitFrame(10)
    MapChange("d", 501, "start_13", false, 0, 0)
  end
  if gMapNum == 506 then
    if gim_name == "access_factory01" then
      Prcs_d05_ArenaWarpIn("access_factory01")
      MapChange("d", 501, "start_04", true, 0, 15)
    end
    if gim_name == "access_battlefield01" then
      Prcs_d05_ArenaWarpIn("access_battlefield01")
      if not Flg.Check("FLAG_MAIN_12_055") then
        Flg.Clear("FLAG_FIELD_D05_ARENAWARP")
        if Flg.Check("FLAG_MAIN_12_015", "FLAG_MAIN_12_020") then
          MapChange("d", 507, "start_00", true, 0, 15)
        elseif Flg.Check("FLAG_MAIN_12_026", "FLAG_MAIN_12_027") then
          MapChange("d", 508, "start_00", true, 0, 15)
        elseif Flg.Check("FLAG_MAIN_12_029", "FLAG_MAIN_12_030") then
          MapChange("d", 509, "start_00", true, 0, 15)
        elseif Flg.Check("FLAG_MAIN_12_032", "FLAG_MAIN_12_035") then
          MapChange("d", 513, "start_00", true, 0, 15)
        end
      else
        Flg.Set("FLAG_FIELD_D05_ARENARINGEVENT")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        MapChange("d", 513, "start_01", true, 0, 15)
      end
    end
  end
  if gMapNum == 501 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 502 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 506 and gim_name == "hazama_gate01" then
    print("====== gate_access ======")
    PlayerLookAtGimmickObject(gim_name)
    GoToHazamaWithEvt(gim)
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local gim_name = att_gim.unique_name
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 501 then
  elseif gMapNum == 502 then
  elseif gMapNum == 503 then
    if gim_id == 200 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK0503.obj1.text) then
      BreakFieldAttackObj(BRK0503.obj1.loc, BRK0503.obj1.col, 30, BRK0503.obj1.se, "ef_f_com_300_sm")
      Flg.Set(BRK0503.obj1.flag)
    elseif gim_id == 202 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK0503.obj3.text) then
      BreakFieldAttackObj(BRK0503.obj3.loc, BRK0503.obj3.col, 30, BRK0503.obj3.se, "ef_f_com_300_sm")
      Flg.Set(BRK0503.obj3.flag)
    elseif gim_id == 250 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK0503.obj50.text) then
      BreakFieldAttackObj(BRK0503.obj50.loc, BRK0503.obj50.col, 30, BRK0503.obj50.se, "ef_f_com_300_sm")
      Flg.Set(BRK0503.obj50.flag)
      Qst.Sub:Set(104, 4)
      ShowGetItemLog(703, 1)
    end
  elseif gMapNum == 504 then
    if gim_id == 200 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK0504.obj1.text) then
      BreakFieldAttackObj(BRK0504.obj1.loc, BRK0504.obj1.col, 30, BRK0504.obj1.se, "ef_f_com_300_sm")
      Flg.Set(BRK0504.obj1.flag)
    elseif gim_id == 201 and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK0504.obj2.text) then
      BreakFieldAttackObj(BRK0504.obj2.loc, BRK0504.obj2.col, 30, BRK0504.obj2.se, "ef_f_com_300_sm")
      Flg.Set(BRK0504.obj2.flag)
    end
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
  if gMapNum == 501 then
    if gim_tag == "fa_obj_hazama" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D05_510")
      FieldObjectSync(OGIM, false)
    end
  elseif gMapNum == 502 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_01" then
      Flg.Set("FLAG_GIMMICK_D05_120")
      M150:Event_155()
    end
    if gim_name == "fa_obstacles_03" then
      Flg.Set("FLAG_GIMMICK_D05_150")
      M150:Event_180BB()
    end
  elseif gMapNum == 503 then
  elseif gMapNum == 504 then
  elseif gMapNum == 505 then
  end
end

function OnCheckActModel(act)
end

function OnCheckLocatorWallAlong(wall_along)
  Field.OperateStartLocatorWallAlong(wall_along.locator)
end

function Prcs_d0501_burinp_talkCam()
  Cam.Inst:Set(-116.097, -6.545, 86.156, -107.824, -9.18, 81.194, default, 60)
end
