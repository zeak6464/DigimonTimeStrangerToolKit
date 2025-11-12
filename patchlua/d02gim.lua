gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 201 then
    AddLoadList(FLD_OBJ_NPC, {
      "outlaw",
      motion = {"fq01", "fe02"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "bakemon001",
      motion = {"ba01", "bn01"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "bakemon002",
      motion = {"ba01", "bn01"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "bakemon003",
      motion = {"ba01", "bn01"}
    })
  elseif load_map_num == 202 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"door"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0003",
      motion = {"e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e002"}
    })
    AddLoadList(FLD_OBJ_NPC, {
      "outlaw",
      motion = {"fq01", "fe02"}
    })
  elseif load_map_num == 204 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"door"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
  elseif load_map_num == 205 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0003",
      motion = {"e001"}
    })
  elseif load_map_num == 206 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
  elseif load_map_num == 207 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"fg02_fn01"},
      move_motion = {"hold"},
      attach = {3},
      attach_motion = {
        {3, "fg02_fn01"}
      }
    })
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
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0004",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0004",
      motion = {"e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0005",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0006",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0006",
      motion = {"e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0007",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0008",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0009",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0010",
      motion = {"e001"}
    })
  elseif load_map_num == 209 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"fg02_fn01"},
      move_motion = {"hold"},
      attach = {3},
      attach_motion = {
        {3, "fg02_fn01"}
      }
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0005",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0006",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0007",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0008",
      motion = {"e001"}
    })
  elseif load_map_num == 210 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "fa_0001",
      motion = {"e001"}
    })
  elseif load_map_num == 211 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 217 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001", "e002"}
    })
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if Flg.Check("FLAG_IS_FLIGHT_RIDE") then
    StartRideFly(false, "", 0)
  else
    Field.CancelPlayerFixedMaxSpeed()
  end
  PlayerObjectResetAim()
  if gMapNum == 201 then
    if Flg.Check("FLAG_GIMMICK_D02_440") then
      Obj:new(FLD_OBJ_LOCATOR, "change_9999"):Invisible()
    end
    if not Flg.Check("FLAG_COLLAPSE_d02") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0006"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0007"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0014"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0003"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0005"):CancelInvisible()
    elseif Flg.Check("FLAG_COLLAPSE_d02") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0003"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0005"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0015"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Field.DisableSystemLadder()
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall01"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall02"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall03"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall04"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall05"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall06"))
      Field.ObjectDisableCulling(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "wall07"))
      Field.ObjectInvisible(NPC, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(FLD_OBJ_POP_POINT, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Field_InvisibleFollowerAllPartyMember(1, 0, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon01"), 1, 0, true, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon02"), 1, 0, true, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon03"), 1, 0, true, false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0003"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0004"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0005"):SetEnableCheckAndFieldAttack(false)
      if Flg.Check("FLAG_MAIN_22_517") then
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_01"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_02"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_03"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_04"), true, FOREVER)
      end
    end
    local npc_index = GetIndex(NPC, "M_burinpu_01")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
    local npc_index2 = GetIndex(NPC, "burinpu_01")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index2, AUTO_TRANSPARENT_TYPE_ALL)
  elseif gMapNum == 202 then
    if Qst.Main:Check(M120.ID, M120.STEP_001, M120.STEP_015) then
      Obj:new(NPC, "npc_0013"):Invisible()
    end
    if not Flg.Check("FLAG_MAIN_03_520") then
      Obj:new(RUMOR_NPC, "guide_lunamon"):Invisible()
      Obj:new(RUMOR_NPC, "guide_lunamon2"):Invisible()
      SetControlScriptExternalVariable("Rumer_state", "invisible")
    end
    if not Flg.Check("FLAG_MAIN_03_522") then
      SetControlScriptExternalVariable("Rumer_state2", "invisible")
    end
    if not Flg.Check("FLAG_MAIN_03_520") then
      Obj:new(NPC, "npc_0015"):Invisible()
    end
    SetControlScriptExternalVariable("Party_state", "display")
    if Flg.Check("FLAG_MAIN_03_525") then
      if Flg.Check("FLAG_GIMMICK_D02_460") then
        SetEnableGimmickCheck("gim_0006", false)
        SetEnableGimmickCheck("gim_0005", true)
      else
        SetEnableGimmickCheck("gim_0006", true)
        SetEnableGimmickCheck("gim_0005", false)
      end
    else
      SetEnableGimmickCheck("gim_0006", false)
      SetEnableGimmickCheck("gim_0005", false)
    end
    if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_199") then
    else
      Field.LinkColOff("mapborder_3")
    end
  elseif gMapNum == 203 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
    if Flg.Check("FLAG_SUB_200_148_002", "FLAG_IS_CLEAR_S200_148") then
      Motion.Object:new(NPC, "s200_148_003", "fe02"):Play(10, true)
    elseif not Flg.Check("FLAG_SUB_200_148_004") then
      Obj:new(NPC, "s200_148_003"):SetIcon(ICO_NONE)
    end
    if Flg.Check("FLAG_SUB_200_148_003", "FLAG_IS_CLEAR_S200_148") then
      Motion.Object:new(NPC, "s200_148_004", "fe02"):Play(10, true)
    elseif not Flg.Check("FLAG_SUB_200_148_004") then
      Obj:new(NPC, "s200_148_004"):SetIcon(ICO_NONE)
    end
  elseif gMapNum == 204 then
    Field.PlayerLoadMoveAnimation("door")
    if Flg.Check("FLAG_GIMMICK_D02_430") then
      SetEnableGimmickCheck("gim_0001", false)
      Motion.Gimmick:PlayFinishedAnim("gim_0001", "e001")
      ColOff("wall_cl_0001")
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Field.ObjectInvisible(NPC, FOR_ALL, 0, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Obj:new(NPC, "npc_900"):CancelInvisible()
      Obj:new(NPC, "npc_904"):CancelInvisible()
      Obj:new(NPC, "npc_905"):CancelInvisible()
      Obj:new(NPC, "npc_906"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):SetEnableCheckAndFieldAttack(false)
    elseif Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_555") then
      Field.ObjectInvisible(NPC, FOR_ALL, 0, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Obj:new(NPC, "npc_901"):CancelInvisible()
      Obj:new(NPC, "npc_902"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):SetEnableCheckAndFieldAttack(false)
    end
  elseif gMapNum == 205 then
    Field.MinimapDisplayHeight(20, 5)
  elseif gMapNum == 206 then
    if Flg.Check("FLAG_MAIN_03_660") then
      ColOff("evt_2006")
      ColOff("evt_2007")
      ColOff("cliff_cl_0001")
      Obj:new(NPC, "npc_0013"):Invisible()
    else
      Icon:new(FLD_OBJ_NPC, "npc_0005"):SetNone()
    end
    if Flg.Check("FLAG_GIMMICK_D02_420") then
      local elv_0003 = Obj:new(FLD_OBJ_LOCATOR, "elv_0003")
      elv_0003:CancelInvisible()
      elv_0003:SetEnableGimmick(true)
      Motion.Gimmick:Play("obj_0002", "e001", true, true)
      Motion.Gimmick:ResetFrame("obj_0002", "e001", 60, 60, 150, true)
      ColOff("cliff_cl_1000")
      SetEnableGimmickCheck("gim_0001", false)
    else
      local elv_0003 = Obj:new(FLD_OBJ_LOCATOR, "elv_0003")
      elv_0003:Invisible()
      elv_0003:SetEnableGimmick(false)
    end
  elseif gMapNum == 207 then
    Field.MinimapDisplayHeight(5, 25)
    if not Flg.Check("FLAG_GIMMICK_D02_260") then
      Flg.Set("FLAG_GIMMICK_D02_220")
    end
    if Flg.Check("FLAG_IS_CARRY_OBJECT") then
      Obj:new(RUMOR_NPC, "rumor_d0207_hagurumon02"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_210") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001")
      Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001")
      Obj:new(NPC, "npc_0001"):Invisible()
      ColOff("cliff_cl_1000")
    end
    if Flg.Check("FLAG_GIMMICK_D02_220") then
      Motion.Gimmick:PlayFinishedAnim("obj_0003", "e001")
      Motion.Gimmick:PlayFinishedAnim("obj_0004", "e001")
      ColOff("cliff_cl_1002")
    end
    if Flg.Check("FLAG_GIMMICK_D02_230") then
      Motion.Gimmick:PlayFinishedAnim("obj_0005", "e001")
      Motion.Gimmick:PlayFinishedAnim("obj_0006", "e001")
      ColOff("cliff_cl_1003")
    end
    if Flg.Check("FLAG_GIMMICK_D02_270") then
      Motion.Gimmick:Play("obj_0008", "e001", true)
      Motion.Gimmick:ResetFrame("obj_0008", "e001", 300, 300, 600, true)
      Obj:new(FLD_OBJ_LOCATOR, "obj_0010"):CancelInvisible()
    else
      Obj:new(FLD_OBJ_LOCATOR, "obj_0010"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_280") then
      Motion.Gimmick:Play("obj_0009", "e001", true)
      Motion.Gimmick:Play("obj_0007", "e001", true)
      Motion.Gimmick:ResetFrame("obj_0009", "e001", 300, 300, 600, true)
      Motion.Gimmick:ResetFrame("obj_0007", "e001", 300, 300, 600, true)
      Obj:new(GIM, "obj_0010"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_200") then
      SetEnableGimmickCheck("wall_along_0001", true)
      SetEnableGimmickCheck("wall_along_0002", false)
    else
      SetEnableGimmickCheck("wall_along_0001", false)
      SetEnableGimmickCheck("wall_along_0002", false)
    end
  elseif gMapNum == 208 then
    Field.MinimapDisplayHeight(50, 50)
    Field.SetControlScriptExternalVariable("info_board", 1)
  elseif gMapNum == 209 then
    Field.MinimapDisplayHeight(5, 15)
    if Flg.Check("FLAG_IS_CARRY_OBJECT") then
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_310") then
      Motion.Gimmick:PlayFinishedAnim("obj_0001", "e001", true)
      Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001", true)
      Obj:new(NPC, "npc_0001"):Invisible()
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon01"):Invisible()
      ColOff("cliff_cl_1000")
    end
    if Flg.Check("FLAG_GIMMICK_D02_330") then
      Motion.Gimmick:PlayFinishedAnim("obj_0005", "e001", true)
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon01"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_360") then
      Motion.Gimmick:Play("obj_0008", "e001", true, true)
      Motion.Gimmick:ResetFrame("obj_0008", "e001", 300, 300, 600, true)
      Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):CancelInvisible()
    else
      Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_370") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):Invisible()
      Motion.Gimmick:Play("obj_0006", "e001", true, true)
      Motion.Gimmick:Play("obj_0007", "e001", true, true)
      Motion.Gimmick:ResetFrame("obj_0006", "e001", 300, 300, 600, true)
      Motion.Gimmick:ResetFrame("obj_0007", "e001", 300, 300, 600, true)
    end
    if Flg.Check("FLAG_GIMMICK_D02_140") then
      local gim1 = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_02")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim1, true)
      local gim2 = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_03")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim2, false)
    else
      local gim1 = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_02")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim1, false)
      local gim2 = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_03")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim2, false)
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
      Obj:new(NPC, "npc_0001"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_150") then
      local gim = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_03")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim, true)
    else
      local gim = GetIndex(FLD_OBJ_GIMMICK, "fa_obstacles_03")
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, gim, false)
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D02_330") then
      Obj:new(NPC, "npc_0001"):Invisible()
      SetEnableGimmickCheck("gim_0001", false)
      SetEnableGimmickCheck("obj_0001", false)
      SetEnableGimmickCheck("elv_0003", true)
    else
      local elv_0003 = Obj:new(FLD_OBJ_LOCATOR, "elv_0003")
      elv_0003:Invisible()
      elv_0003:SetEnableGimmick(false)
    end
  elseif gMapNum == 210 then
    if not Flg.Check("FLAG_MAIN_03_680") then
      Motion.Gimmick:Play("obj_0001", "e001", true, true)
    end
    if not Flg.Check("FLAG_GIMMICK_D02_420") then
      SetEnableGimmickCheck("elv_0002", false)
    end
    if Flg.Check("FLAG_GIMMICK_D02_420") then
      Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001")
      SetEnableGimmickCheck("gim_0002", false)
    end
    if not Flg.Check("FLAG_GIMMICK_D02_425") then
      SetEnableGimmickCheck("theater_0001", false)
    end
    ColOff("evt_5000")
    if Flg.Check("FLAG_IS_CLEAR_S110_101") or Flg.Check("FLAG_IS_CLEAR_S110_099") then
      ColOn("evt_5000")
      ColOff("evt_1000")
      ColOff("evt_1001")
      ColOff("evt_1002")
    elseif Flg.Check("FLAG_IS_CLEAR_S110_105") or Flg.Check("FLAG_IS_CLEAR_S110_102") then
      ColOn("evt_5000")
      ColOff("evt_1000")
      ColOff("evt_1001")
      ColOff("evt_1002")
    elseif Flg.Check("FLAG_IS_CLEAR_S110_108") then
      ColOn("evt_5000")
      ColOff("evt_1000")
      ColOff("evt_1001")
      ColOff("evt_1002")
    end
    local npc_index = GetIndex(NPC, "M_burinpu_01")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
  elseif gMapNum == 211 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 212 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 213 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
    if Flg.Check("FLAG_IS_CHECK_D0213_DOLL_4") then
      Motion.NPC:Play("chr001_hide", "bn01", 0, true)
    else
      Flg.Clear("FLAG_IS_CHECK_D0213_DOLL_4")
      Flg.Clear("FLAG_IS_CHECK_D0213_DOLL_2")
      Flg.Clear("FLAG_IS_CHECK_D0213_DOLL_3")
    end
  elseif gMapNum == 215 then
    Field.PlayerFixedMaxSpeed(MOVE_SPEED_WALK)
  elseif gMapNum == 216 then
    local npc_warp01 = GetIndex(NPC, "npc_warp01")
    local npc_warp02 = GetIndex(NPC, "npc_warp02")
    Field.ObjectSuspendAutoTransparent(NPC, npc_warp01, AUTO_TRANSPARENT_TYPE_OVERLAPPING_WITH_PLAYER)
    Field.ObjectSuspendAutoTransparent(NPC, npc_warp02, AUTO_TRANSPARENT_TYPE_OVERLAPPING_WITH_PLAYER)
  elseif gMapNum == 217 and not Flg.Check("FLAG_GIMMICK_D02_455") then
    SetEnableGimmickCheck("theater_0001", false)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 201 then
    if col_name == "evt_0001" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_0002" then
      M120:Event_050()
    end
    if col_name == "evt_3500" then
      M350:Event_051()
    end
    if col_name == "evt_3501" then
      M350:Event_053()
    end
    if col_name == "evt_3502" then
      M350:Event_057()
    end
    if col_name == "evt_3503" and Flg.Check("FLAG_MAIN_13_146", "FLAG_MAIN_13_153") then
      Field_InvisibleFollowerAllPartyMember(3503, 0, false)
      MovePlayerToLocatorFrame("gim_0005", 20)
      SetPlayerRotationByLocator("gim_0005", 5)
      M350:Event_058()
    end
    if col_name == "evt_4000" then
      M150:Event_030()
    end
    if col_name == "evt_6000" and Flg.Check("FLAG_MAIN_03_460", "FLAG_MAIN_03_490") then
      M120:Event_040()
    end
    if col_name == "evt_4001" then
      M150:Event_290()
    end
    if col_name == "evt_6001" and Flg.Check("FLAG_MAIN_10_000", "FLAG_MAIN_10_001") then
      M290:Event_020()
    end
    if col_name == "evt_9900" then
      M350:Event_057A()
      MiniMapChange(MAP_LAYER_MIDDLE)
    elseif col_name == "evt_9901" then
      M350:Event_057B()
    elseif col_name == "evt_9903" then
      M350:Event_057C()
    end
  elseif gMapNum == 202 then
    if col_name == "evt_3000" and not Flg.Check("FLAG_MAIN_03_640") then
      local talk = Tlk:new("d02")
      talk:StartTalkActionAndZoom("npc_0005")
      talk:Message("f_d0202_0170_0010")
      talk:EndActionAndZoom()
      Field.MovePlayerToRelativePosFrame(2, 0, 30)
      talk:EndTalk()
    end
    if col_name == "evt_3009" and not Flg.Check("FLAG_MAIN_03_640") then
      local talk = Tlk:new("d02")
      talk:StartTalkActionAndZoom("npc_0803")
      talk:Message("f_d0202_0170_0010")
      talk:EndActionAndZoom()
      Field.MovePlayerToRelativePosFrame(1, 3, 30)
      talk:EndTalk()
    end
    if col_name == "evt_3010" and Flg.Check("FLAG_MAIN_13_149") and not Flg.Check("FLAG_MAIN_13_160") then
      Cam.Inst:Set(26.89, 3.1, -4.54, 17.35, 1.21, -7.22, default, 30)
      WaitFrame(30)
      local talk = Tlk:new("d02")
      talk:StartTalk()
      talk:Message("f_d0202_0730_0010")
      Cam.Inst:Clear(30)
      Field.MovePlayerToRelativePosFrame(-4, -1, 30)
      talk:EndTalk()
    end
    if col_name == "evt_3500" and Flg.Check("FLAG_MAIN_13_143", "FLAG_MAIN_13_144") then
      MovePlayerToLocatorFrame("gim_0010", 20)
      SetPlayerRotationByLocator("gim_0010", 5)
      local npc_0668 = GetIndex(NPC, "npc_0668")
      Field.ObjectLookAtTheObject(NPC, npc_0668, PLAYER, 1, 30)
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, npc_0668, 30)
      M350:Event_055()
    end
    if col_name == "evt_3501" then
      M350:Event_059()
    end
    if col_name == "evt_4000" then
      M350:Event_060()
    end
    if col_name == "evt_9000" and Field.IsPlayerScriptDigimonRiding() == true then
      Flg.Clear("FLAG_IS_FLIGHT_RIDE")
      ColOff("cliff_cl_3000")
      MovePlayerToLocatorFrame("ride_fly_0003", 20)
      ColOn("cliff_cl_3000")
      Field.FollowerWarp()
      EndRide(true, "ride_fly_0003", 30)
    end
    if col_name == "evt_9001" or col_name == "evt_9004" or col_name == "evt_9006" then
      MiniMapChange(MAP_LAYER_LOW)
    elseif col_name == "evt_9002" or col_name == "evt_9003" or col_name == "evt_9005" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_1000" or col_name == "evt_1001" or col_name == "evt_1002" then
      local Party_state = GetControlScriptExternalVariableString("Party_state")
      if Party_state == "invisible" then
        Field.FollowerWarp()
        SetControlScriptExternalVariable("Party_state", "display")
      end
    end
    if Flg.Check("FLAG_MAIN_03_525") then
      if col_name == "evt_1000" then
        SetEnableGimmickCheck("gim_0006", false)
        SetEnableGimmickCheck("gim_0005", true)
      elseif col_name == "evt_1001" or col_name == "evt_1002" then
        SetEnableGimmickCheck("gim_0006", true)
        SetEnableGimmickCheck("gim_0005", false)
      end
    end
    if col_name == "evt_3008" then
      M120:Event_090()
    end
  elseif gMapNum == 204 then
    if col_name == "evt_0001" then
      M150:Event_020()
      M440:Event_843()
    end
    if col_name == "evt_0003" then
      M440:Event_841()
    end
    if col_name == "evt_0004" then
      M440:Event_842()
    end
  elseif gMapNum == 205 then
    if col_name == "evt_9003" then
      KeepRideZip("ride_zip_0034", 900)
    end
    if col_name == "evt_1002" and not Flg.Check("FLAG_MAIN_03_648") then
      Flg.Set("FLAG_MAIN_03_648")
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_1001" then
      Field.LinkColOn("col_d0206_start_00_0")
      ColOff("evt_1002")
    end
  elseif gMapNum == 206 then
    if col_name == "evt_0001" then
      M140:Event_040()
    end
    if col_name == "evt_1001" then
      Field.LinkColOn("col_d0210_start_01_0")
    elseif col_name == "evt_1002" then
      Field.LinkColOn("col_d0207_start_00_0")
    elseif col_name == "evt_1003" then
      Field.LinkColOn("col_d0205_start_01_0")
      if not Flg.Check("FLAG_MAIN_03_650") and not Flg.Check("FLAG_MAIN_03_651") then
        Field_Talk_Start("d02", 1)
        Message("f_d0206_0020_0010")
        Field_Talk_End()
        Digimon.RestoreAllParty()
        Flg.Set("FLAG_MAIN_03_651")
      end
    end
    if col_name == "evt_2000" then
      Field_InvisibleFollowerAllPartyMember(0, 30, false)
      Field_InvisibleFollowerAllGuest(0, 30, false)
      Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    end
    if col_name == "evt_2001" and Flg.Check("FLAG_FIELD_D02_INVISIBLEFOLLOWER") then
      Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
      Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
      Flg.Clear("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    end
    if col_name == "evt_2002" and Flg.Check("FLAG_MAIN_03_660") then
      Field_InvisibleFollowerAllPartyMember(0, 30, false)
      Field_InvisibleFollowerAllGuest(0, 30, false)
      Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    end
    if col_name == "evt_2003" and Flg.Check("FLAG_MAIN_03_660") and Flg.Check("FLAG_FIELD_D02_INVISIBLEFOLLOWER") then
      Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
      Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
      Flg.Clear("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    end
    if col_name == "evt_2004" and Flg.Check("FLAG_GIMMICK_D02_420") then
      Field_InvisibleFollowerAllPartyMember(0, 30, false)
      Field_InvisibleFollowerAllGuest(0, 30, false)
      Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    end
    if col_name == "evt_2005" and Flg.Check("FLAG_GIMMICK_D02_420") and Flg.Check("FLAG_FIELD_D02_INVISIBLEFOLLOWER") then
      Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
      Field_CancelInvisibleFollowerAllGuest(0, 20, true, false)
      Flg.Clear("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    end
    if col_name == "evt_2006" or col_name == "evt_2007" then
      M140:Event_050()
    end
    if col_name == "evt_3001" then
      Field.SetInstantCamera(-37.64, 3.799, 16.241, -36.06, 8.343, 25.007, DEFAULT_ANGLE, 30, LINEAR)
    end
    if col_name == "evt_3002" then
      Field.ClearInstantCamera(30, LINEAR)
    end
  elseif gMapNum == 207 then
    if col_name == "evt_1000" then
      Field.LinkColOn("col_d0206_start_01_0")
    end
    if col_name == "evt_3000" then
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
    end
    if col_name == "evt_1001" then
      M140:Event_051()
    end
    if col_name == "evt_1002" then
      M140:Event_052()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
      Field.MinimapDisplayHeight(5, 25)
    elseif col_name == "evt_9901" or col_name == "evt_9902" then
      MiniMapChange(MAP_LAYER_MIDDLE)
      Field.MinimapDisplayHeight(5, 5)
    elseif col_name == "evt_9903" then
      MiniMapChange(MAP_LAYER_HIGH)
      if Flg.Check("FLAG_GIMMICK_D02_200") then
        SetEnableGimmickCheck("wall_along_0001", true)
        SetEnableGimmickCheck("wall_along_0002", false)
      else
        SetEnableGimmickCheck("wall_along_0001", false)
        SetEnableGimmickCheck("wall_along_0002", false)
      end
    end
    if col_name == "evt_9904" then
      SetEnableGimmickCheck("wall_along_0001", true)
      SetEnableGimmickCheck("wall_along_0002", false)
    elseif col_name == "evt_9905" then
      SetEnableGimmickCheck("wall_along_0002", true)
      SetEnableGimmickCheck("wall_along_0001", false)
    end
    if not Flg.Check("FLAG_GIMMICK_D02_210") then
      if col_name == "evt_2001" then
        Obj:new(RUMOR_NPC, "rumor_d0207_hagurumon01"):Invisible()
      elseif col_name == "evt_2002" and not Flg.Check("FLAG_IS_CARRY_OBJECT") then
        Obj:new(RUMOR_NPC, "rumor_d0207_hagurumon01"):CancelInvisible()
      end
    end
    if not Flg.Check("FLAG_GIMMICK_D02_230") then
      if col_name == "evt_2003" then
        Obj:new(RUMOR_NPC, "rumor_d0207_hagurumon02"):Invisible()
      elseif col_name == "evt_2004" and not Flg.Check("FLAG_IS_CARRY_OBJECT") then
        Obj:new(RUMOR_NPC, "rumor_d0207_hagurumon02"):CancelInvisible()
      end
    end
  elseif gMapNum == 208 then
    if col_name == "evt_1000" then
      Field.LinkColOn("col_d0209_start_00_0")
    end
    if col_name == "evt_3000" then
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
    end
  elseif gMapNum == 209 then
    if col_name == "evt_1000" then
      Field.LinkColOn("col_d0208_start_01_0")
    elseif col_name == "evt_1001" then
      Field.LinkColOn("col_d0210_start_00_0")
    end
    if col_name == "evt_3000" or col_name == "evt_3001" or col_name == "evt_3002" then
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
    end
    if col_name == "evt_1002" then
      M140:Event_053()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
      Field.MinimapDisplayHeight(5, 15)
    elseif col_name == "evt_9901" or col_name == "evt_9902" or col_name == "evt_9904" then
      MiniMapChange(MAP_LAYER_MIDDLE)
      Field.MinimapDisplayHeight(5, 5)
      SetEnableGimmickCheck("wall_along_0001", true)
      SetEnableGimmickCheck("wall_along_0002", false)
      if Flg.Check("FLAG_GIMMICK_D02_330") then
        SetEnableGimmickCheck("elv_0003", true)
      else
        SetEnableGimmickCheck("elv_0003", false)
      end
    elseif col_name == "evt_9903" or col_name == "evt_9905" then
      MiniMapChange(MAP_LAYER_HIGH)
      Field.MinimapDisplayHeight(20, 5)
    end
    if col_name == "evt_9908" then
      SetEnableGimmickCheck("wall_along_0001", true)
      SetEnableGimmickCheck("wall_along_0002", false)
    end
    if col_name == "evt_9909" then
      SetEnableGimmickCheck("wall_along_0001", false)
      SetEnableGimmickCheck("wall_along_0002", true)
    end
    if col_name == "evt_9910" then
      SetEnableGimmickCheck("wall_along_0003", true)
      SetEnableGimmickCheck("wall_along_0004", false)
    end
    if col_name == "evt_9911" then
      SetEnableGimmickCheck("wall_along_0003", false)
      SetEnableGimmickCheck("wall_along_0004", true)
    end
    if col_name == "evt_2001" then
      if Flg.Check("FLAG_GIMMICK_D02_390") and not Flg.Check("FLAG_GIMMICK_D02_310") then
        Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
      end
    elseif not (col_name == "evt_2002" and Flg.Check("FLAG_GIMMICK_D02_390")) or Flg.Check("FLAG_GIMMICK_D02_310") or Flg.Check("FLAG_IS_CARRY_OBJECT") or Flg.Check("FLAG_GIMMICK_D02_310") or Flg.Check("FLAG_GIMMICK_D02_330") then
    else
      local index = Field.GetRumorNpcIndex("rumor_d0209_hagurumon02")
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):CancelInvisible()
    end
  elseif gMapNum == 210 then
    if col_name == "evt_1000" or col_name == "evt_1001" or col_name == "evt_1002" then
      M140:Event_070()
    end
    if col_name == "evt_2000" and not Flg.Check("FLAG_GIMMICK_D02_410") then
      M140:Event_060()
      Flg.Set("FLAG_GIMMICK_D02_410")
    end
    if col_name == "evt_3000" or col_name == "evt_3001" then
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
      Digitter.Send(3140500)
    end
    if col_name == "evt_9902" or col_name == "evt_9903" then
      TIME_ZONE = NOON
    end
    if col_name == "evt_9904" then
      Field.LinkColOn("col_d0209_start_01_0")
    end
    if col_name == "evt_9905" then
      Field.LinkColOn("col_d0206_start_02_0")
    end
  end
  if gMapNum == 216 then
    if col_name == "evt_0002" then
      M120:Event_020()
    elseif col_name == "evt_0001" and Flg.Check("FLAG_MAIN_13_100") and not Flg.Check("FLAG_MAIN_13_120") then
      Digitter.Send(1350010020)
    end
    if col_name == "evt_0010" then
      M350:Event_045()
    end
  end
  if gMapNum == 217 then
    if col_name == "evt_0001" then
      M130:Event_050()
    end
    if col_name == "evt_0003" then
      M130:Event_060()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9902" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if col_name == "evt_9903" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if col_name == "evt_0004" and Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_199") then
      require("S050_043")
      S050_043:Event_020()
    end
    if col_name == "evt_0005" and Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_199") then
      require("S050_043")
      S050_043:Event_057()
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 201 then
  end
  if gMapNum == 203 then
    if gim_name == "gim_access_1" then
      PlayerLookAtGimmickObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0203_0010_0060")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_name == "gim_access_2" then
      PlayerLookAtGimmickObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0203_0010_0050")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_name == "gim_access_3" then
      PlayerLookAtGimmickObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0203_0010_0080")
      if not Flg.Check("FLAG_IS_CHECK_D0203_BOTTLE") then
        Flg.Set("FLAG_IS_CHECK_D0203_BOTTLE")
        WaitFrame(30)
        Message("f_d0203_0010_0085")
        Field_Talk_End_Not_LetterBox()
        INFO_GET_ITEM(1, 1)
      else
        Field_Talk_End_Not_LetterBox()
      end
    end
    if gim_name == "gim_access_4" then
      PlayerLookAtGimmickObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0203_0010_0070")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_name == "gim_access_5" then
      if Flg.Check("FLAG_MAIN_13_180") then
        PlayerLookAtGimmickObject(gim_name)
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Sound.PlayVoice("vo_mpc999_Greeting_001_b")
        Message("f_d0203_0010_0087")
        WaitFrame(30)
        Message("f_d0203_0010_0089")
        Field_Talk_End_Not_LetterBox()
      else
        PlayerLookAtGimmickObject(gim_name)
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Message("f_d0203_0010_0083")
        Field_Talk_End_Not_LetterBox()
      end
    end
  end
  if gMapNum == 206 and gim_name == "s050_038_pop" then
    require("S050_038")
    S050_038:Event_025()
  end
  if gMapNum == 210 then
    if gim_name == "access_brinp_01" then
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
    if gim_name == "sub_050_042_01" then
      require("s050_042")
      S050_042:Event_030(gim_name)
    end
    if gim_name == "sub_050_042_02" then
      require("s050_042")
      S050_042:Event_030(gim_name)
    end
    if gim_name == "sub_050_042_03" then
      require("s050_042")
      S050_042:Event_040(gim_name)
    end
    if gim_name == "sub_050_042_04" then
      require("s050_042")
      S050_042:Event_030(gim_name)
    end
    if gim_name == "sub_050_042_05" then
      require("s050_042")
      S050_042:Event_030(gim_name)
    end
    if gim_name == "s110_108_002" then
      require("S110_108")
      S110_108:Event_010()
    end
  end
  if gMapNum == 216 and gim_name == "merc_gate01" then
    if Flg.Check("FLAG_MAIN_09_082B", "FLAG_MAIN_09_083") then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject(gim_name)
      M285:Event_040()
    else
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject(gim_name)
      Prcs_d0216_DageGate()
    end
  end
  if gMapNum == 217 and gim_name == "flyer_access01" then
    PlayerLookAtGimmickObject(gim_name)
    local tlk = Tlk:new("d02", 1, true, false)
    tlk:StartTalk()
    tlk:Message("f_d0202_0780_0010")
    tlk:Message("f_d0202_0780_0020")
    tlk:Message("f_d0202_0780_0030")
    tlk:EndTalk()
  end
  if gMapNum == 217 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 202 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 216 and gim_name == "hazama_gate01" then
    print("====== gate_access ======")
    PlayerLookAtGimmickObject(gim_name)
    GoToHazamaWithEvt(gim)
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 201 then
    if gim_name == "gim_0001" then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtGimmickObject("lookat_01")
      if Flg.Check("FLAG_MAIN_04_000", "FLAG_MAIN_04_005") then
        M150:Event_035()
      elseif Flg.Check("FLAG_MAIN_08_040") then
        local tlk = Tlk:new("field_text", 1, true)
        tlk:StartTalk()
        tlk:Message("g_wm_0030_0010")
        tlk:EndTalk()
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_BLIMP")
        OpenWorldMap(DW, BLIMPMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_BLIMP")
      end
    end
    if gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
        OpenDoor_NoFade(gim_loc, "", true, "gim_8001")
        M440:Event_831()
      else
        OpenDoor(gim_loc, "", true, "gim_8001")
        DoorMapChange("d", 213, "start_00")
      end
    elseif gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "", true, "gim_8000")
      DoorMapChange("d", 211, "start_00")
    elseif gim_id == 402 then
      OpenDoor(gim_loc, "", true, "gim_8002")
      DoorMapChange("d", 212, "start_00")
    elseif gim_id == 403 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "", true, "gim_8003")
      DoorMapChange("d", 203, "start_00")
    elseif gim_id == 404 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0201_1240_0010")
      Field_Talk_End_Not_LetterBox()
    elseif gim_id == 405 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      MapChange("d", 216, "start_00", true, 0, 15)
    end
  elseif gMapNum == 202 then
    if gim_id == 5 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      SetControlScriptExternalVariable("Party_state", "invisible")
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      ColOff("cliff_cl_0002")
      Cam.Inst:Set(-29.997, 2.115, -5.778, -29.97, 3.119, 4.182, DEFAULT_ANGLE, 30)
      SetFollowerCameraOperateRotation(5, 0, 15)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      Field.MovePlayerToLocatorFrame("sp_0001", 30)
      WaitFrame(30)
      Field.MovePlayerToLocatorFrame("sp_0002", 15)
      WaitFrame(15)
      Motion.Player:ResetMoveAnimWithBlend(15)
      Field.MovePlayerToLocatorFrame("sp_0003", 45)
      WaitFrame(15)
      Cam.Inst:Set(-29.997, 2.015, -5.778, -30.3, 3.219, 1.75, DEFAULT_ANGLE, 30)
      WaitFrame(30)
      Cam.Inst:Clear(30)
      Flg.Clear("FLAG_GIMMICK_D02_460")
      SetEnableGimmickCheck("gim_0006", true)
      SetEnableGimmickCheck("gim_0005", false)
      ColOn("cliff_cl_0002")
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 30, false, true)
      M350:Event_085()
    end
    if gim_id == 6 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      SetControlScriptExternalVariable("Party_state", "invisible")
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      ColOff("cliff_cl_0002")
      Cam.Inst:Set(-30.96, 2.115, 10.747, -30.51, 3.119, 0.797, DEFAULT_ANGLE, 30)
      SetFollowerCameraOperateRotation(0, 180, 15)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      Field.MovePlayerToLocatorFrame("sp_0001", 30)
      WaitFrame(30)
      Field.MovePlayerToLocatorFrame("sp_0004", 15)
      WaitFrame(15)
      Motion.Player:ResetMoveAnimWithBlend(15)
      Field.MovePlayerToLocatorFrame("sp_0005", 45)
      WaitFrame(15)
      Cam.Inst:Set(-30.96, 2.015, 10.747, -30.01, 3.219, 3.297, DEFAULT_ANGLE, 30)
      WaitFrame(30)
      Cam.Inst:Clear(30)
      Flg.Set("FLAG_GIMMICK_D02_460")
      SetEnableGimmickCheck("gim_0006", false)
      SetEnableGimmickCheck("gim_0005", true)
      ColOn("cliff_cl_0002")
      Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field.CancelInvisibleFollowerAllGuest(0, 30, false, true)
    end
    if gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0202_AreaChangeGim()
    elseif gim_id == 401 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      OpenDoor(gim_loc, "", true, "gim_8000")
      DoorMapChange("d", 215, "start_00")
    elseif gim_id == 402 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      ColOff("cliff_cl_0001")
      local loc_pos = Field.GetLocatorPosition("change_0003")
      local loc_rot = Field.GetLocatorRotationYDegree("change_0003")
      local player = Obj:new(PLAYER, "")
      loc_rot = loc_rot - 90
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      Field.SetFollowerCameraOperateRotationY(loc_rot, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      Field.SetFollowerCameraOperateRotationX(0, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      WaitFrame(10)
      local dis_x = math.abs(loc_pos.x - player.pos.x)
      local dis_z = math.abs(loc_pos.z - player.pos.z)
      if 0.15 <= dis_x and 0.15 <= dis_z then
        local move_pos_x = -32.01
        local move_pos_z = 18.267
        local move_point_x = move_pos_x - player.pos.x
        local move_point_z = move_pos_z - player.pos.z
        MovePlayerToRelativePosFrame(move_point_x, move_point_z, 20)
      end
      WaitFrame(20)
      player:SetRotationY(loc_rot, 10)
      WaitFrame(7)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      MovePlayerFrame(-90, 0.75, 45)
      WaitFrame(30)
      MapChange("d", 217, "start_00", true, 0, 15)
    elseif gim_id == 403 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 203 then
    sp_text = "d02"
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0203_HangerRack()
    end
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start(sp_text, 1)
      Message("f_d0203_0010_0010")
      Message("f_d0203_0010_0020")
      Message("f_d0203_0010_0030")
      Message("f_d0203_0010_0040")
      Field_Talk_End()
    end
    if gim_id == 3 then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d0203_Bed()
    end
    if gim_id == 400 then
      if Flg.Check("FLAG_MAIN_03_715", "FLAG_MAIN_04_000") then
        M150:Event_015()
      end
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 201, "start_04")
    end
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 204 then
    if gim_id == 1 then
      local npc_1001 = Obj:new(NPC, "npc_1001")
      if Flg.Check("FLAG_MAIN_03_630") then
        Prcs_d0204_ThroughDoor()
        Flg.Set("FLAG_GIMMICK_D02_430")
        FieldObjectSync(FOR_ALL, false)
        Fade_OutNoLoadingWithWait(FADE_BLACK, 5)
        SetEnableGimmickCheck("gim_0001", false)
        ColOff("wall_cl_0001")
        MapChangeWithTimeTravel("d", 204, "start_00", AXIS_ORIGINAL, "A2020_dbef_141", NOON)
      elseif Flg.Check("FLAG_MAIN_03_610") then
        Field.StartPlayerAndNpcTalkAction("npc_1001")
        Cam.Inst:Set(0.334, 0.849, -9.089, 0.744, 2.297, -1.486, DEFAULT_ANGLE, 30)
        Field_Talk_Start("d02", 1)
        Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "npc_1001"), PLAYER, 1, 30)
        Message("f_d0204_0030_0010")
        Message("f_d0204_0050_0010")
        Field_Talk_End()
        FadeOutWithWait(0, 30)
        WaitFrame(30)
        Field.ObjectLookAt(NPC, GetIndex(NPC, "npc_1001"), 0.62, 0, -2.6, 0)
        M140:Event_020()
        Cam.Inst:Clear(15)
      elseif Flg.Check("FLAG_MAIN_03_495") then
        Field.StartPlayerAndNpcTalkAction("npc_1001")
        Cam.Inst:Set(0.334, 0.849, -9.089, 0.744, 2.297, -1.486, DEFAULT_ANGLE, 30)
        Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "npc_1001"), PLAYER, 1, 30)
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Message("f_d0204_0040_0010")
        Message("f_d0204_0040_0020")
        END_TALK_ACTION_AND_ZOOM("npc_1001", true, true)
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(15)
        WaitFrame(15)
        Field.ObjectResetAim(NPC, GetIndex(NPC, "npc_1001"), 10)
      else
        Cam.Inst:Set(0.334, 0.849, -9.089, 0.744, 2.297, -1.486, DEFAULT_ANGLE, 30)
        Field_Talk_Start("d02", 1)
        Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "npc_1001"), PLAYER, 1, 30)
        Message("f_d0204_0030_0010")
        Field_Talk_End()
        FadeOutWithWait(0, 30)
        WaitFrame(30)
        Field.ObjectResetAim(NPC, GetIndex(NPC, "npc_1001"), 0)
        M120:Event_060()
        Cam.Inst:Clear(15)
        WaitFrame(60)
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Message("f_d0204_0100_0010")
        Field_Talk_End_Not_LetterBox()
      end
    end
    if gim_id == 400 then
      M360:Event_010()
      M390:Event_010()
      Prcs_d0204_AreaChangeGim()
    end
    if gim_id == 450 then
      PlayerLookAtLccatorObject(gim_name)
      M440:Event_845()
    end
  elseif gMapNum == 205 then
    if gim_id == 302 then
      StartRideZip("ride_zip_0021", 901)
    elseif gim_id == 306 then
      StartRideZip("ride_zip_0031", 902)
    end
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_MAIN_03_710") then
        if Flg.Check("FLAG_GIMMICK_D02_020") then
          Field_Talk_Start_Not_LetterBox(gGimText, 1)
          Message("g_d0205_0020_0010")
          Field_Talk_End_Not_LetterBox()
        else
          Field.CancelPlayerAnywhereDigimonRide(false, true)
          Prcs_d0205_StartMoveTown_01()
        end
      else
        Field_Talk_Start_Not_LetterBox(gGimText, 1)
        Message("g_d0205_0010_0010")
        Field_Talk_End_Not_LetterBox()
      end
    end
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      if Flg.Check("FLAG_GIMMICK_D02_030") then
        Field_Talk_Start_Not_LetterBox(gGimText, 1)
        Message("g_d0205_0020_0010")
        Field_Talk_End_Not_LetterBox()
      else
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d0205_StartMoveTown_02()
      end
    end
    if gim_id == 3 then
      PlayerLookAtLccatorObject(gim_name)
      if not Flg.Check("FLAG_GIMMICK_D02_040") then
        Prcs_d0205_OpenShutter()
      end
    end
    if gim_id == 400 and Quest.CheckFlag(1602, 1) and Quest.CheckFlag(1602, 2) then
      Field_Talk_Start_Not_LetterBox(gGimText, 1)
      Message("g_crevice_0010_0010")
      MessageClose()
      MessageTalkSel(2, "g_sel_0010_0010")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Field_Talk_End_Not_LetterBox()
        MapChange("h", 401, "start_00", true, 1, 30)
      elseif result == RESULT_TALK01 then
        Field_Talk_End_Not_LetterBox()
      end
    end
  elseif gMapNum == 206 then
    if gim_id == 4 and not Flg.Check("FLAG_GIMMICK_D02_420") then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(gGimText, 1)
      Message("g_d0206_0010_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 207 then
    if gim_id == 1 then
      if Flg.Check("FLAG_GIMMICK_D02_210") then
        Cam.Inst:Set(-23.3, 4, -14.5, -18, 5.1, -6.1, default, 30)
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Message("f_d0207_0020_0010")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(20)
      elseif Flg.Check("FLAG_IS_CARRY_OBJECT") then
        MovePlayerToLocatorFrame("gim_0001", 20)
        SetPlayerRotationByLocator("gim_0002", 10)
        Field.CancelDisableSystemFieldAttack()
        SetEnableAllCheckPoint(true)
        Prcs_d0207_PutHagurumonEvent()
      else
        Cam.Inst:Set(-23.3, 4, -14.5, -18, 5.1, -6.1, default, 30)
        Field_Talk_Start_Not_LetterBox(gGimText, 1)
        Message("g_d0207_0010_0010")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(20)
      end
    end
    if gim_id == 2 then
      if Flg.Check("FLAG_GIMMICK_D02_220") then
        if not Flg.Check("FLAG_GIMMICK_D02_260") then
          Field_InvisibleFollowerAllPartyMember(0, 10, false)
          Field_InvisibleFollowerAllGuest(0, 10, false)
          Flg.Set("FLAG_GIMMICK_D02_260")
          MovePlayerToLocatorFrame("gim_0002", 20)
          SetPlayerRotationByLocator("gim_0002", 10)
          Field_Talk_Start_Not_LetterBox("d02", 1)
          Cam.Inst:Set(44.328, 11.95, -21.739, 38.082, 12.818, -13.99, default, 20)
          Message("f_d0207_0030_0010")
          Message("f_d0207_0030_0020")
          Message("f_d0207_0030_0030")
          MessageClose()
          MessageTalkSel(2, "f_d0207_0050_0010")
          local result = Talk.GetResultSelectedNum()
          if result == RESULT_TALK00 then
            Cam.Inst:Clear(20)
            PlaySE(200044, 100)
            Motion.Gimmick:ResetFrame("obj_0003", "e002", 0, 0, 300, false)
            Motion.Gimmick:Play("obj_0004", "e002", false)
            WaitFrame(45)
            Quake_Start(0.1, 0, 20)
            Field.DisableSystemFieldAttack()
            SetEnableAllCheckPoint(false)
            Prcs_d0207_CarryingHagurumon_01()
            Field_Talk_End_Not_LetterBox()
          elseif result == RESULT_TALK01 then
            Field_Talk_End_Not_LetterBox()
            Cam.Inst:Clear(20)
          end
        else
          Field_Talk_Start_Not_LetterBox("d02", 1)
          Cam.Inst:Set(44.328, 11.95, -21.739, 38.082, 12.818, -13.99, default, 20)
          Field_InvisibleFollowerAllPartyMember(0, 10, false)
          Field_InvisibleFollowerAllGuest(0, 10, false)
          Message("f_d0207_0040_0010")
          MessageClose()
          MessageTalkSel(2, "f_d0207_0050_0010")
          local result = Talk.GetResultSelectedNum()
          if result == RESULT_TALK00 then
            Motion.Gimmick:ResetFrame("obj_0003", "e002", 0, 0, 300, false)
            Motion.Gimmick:Play("obj_0004", "e002", false)
            Cam.Inst:Clear(20)
            PlaySE(200044, 100)
            Quake_Start(0.1, 0, 20)
            WaitFrame(70)
            MovePlayerToLocatorFrame("gim_0002", 20)
            SetPlayerRotationByLocator("gim_0002", 10)
            Field.DisableSystemFieldAttack()
            SetEnableAllCheckPoint(false)
            Prcs_d0207_CarryingHagurumon_01()
            Field_Talk_End_Not_LetterBox()
            Cam.Inst:Clear(20)
          elseif result == RESULT_TALK01 then
            Field_Talk_End_Not_LetterBox()
            Cam.Inst:Clear(20)
          end
        end
      elseif Flg.Check("FLAG_IS_CARRY_OBJECT") then
        MovePlayerToLocatorFrame("gim_0002", 20)
        SetPlayerRotationByLocator("gim_0002", 10)
        Prcs_d02_PutHagurumon("gim_0002", "obj_0003")
        local tlk = Tlk:new("d02")
        tlk:StartTalk()
        Cam.Inst:Set(44.328, 11.95, -21.739, 38.082, 12.818, -13.99, default, 20)
        tlk:Message("f_d0207_0010_0010")
        tlk:EndTalk(true)
        Cam.Inst:Clear(20)
        PlaySE(200044, 100)
        Motion.Gimmick:ResetFrame("obj_0003", "e001", 0, 0, 300, false)
        Motion.Gimmick:Play("obj_0004", "e001", false)
        WaitFrame(70)
        Quake_Start(0.1, 0, 20)
        ColOff("cliff_cl_1002")
        Flg.Set("FLAG_GIMMICK_D02_220")
        MovePlayerToLocatorFrame("gim_0002", 20)
        SetPlayerRotationByLocator("gim_0002", 10)
        tlk:StartTalk()
        tlk:Message("f_d0207_0010_0020")
        Cam.Inst:Clear(20)
        tlk:EndTalk()
        Field.CancelDisableSystemFieldAttack()
        SetEnableAllCheckPoint(true)
      else
        MovePlayerToLocatorFrame("gim_0002", 20)
        SetPlayerRotationByLocator("gim_0002", 10)
        Field_Talk_Start_Not_LetterBox(gGimText, 1)
        Cam.Inst:Set(44.328, 11.95, -21.739, 38.082, 12.818, -13.99, default, 20)
        Message("g_d0207_0010_0010")
        Cam.Inst:Clear(20)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if gim_id == 3 then
      if Flg.Check("FLAG_GIMMICK_D02_230") then
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Cam.Inst:Set(22.683, 14.736, -9.625, 15.365, 16.552, -3.056, default, 20)
        Message("f_d0207_0040_0010")
        MessageClose()
        MessageTalkSel(2, "f_d0207_0050_0010")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Cam.Inst:Clear(20)
          Motion.Gimmick:ResetFrame("obj_0005", "e002", 0, 0, 300, false)
          Motion.Gimmick:Play("obj_0006", "e002", false)
          PlaySE(200044, 100)
          WaitFrame(15)
          MovePlayerToLocatorFrame("gim_0003", 20)
          SetPlayerRotationByLocator("gim_0003", 10)
          Field.DisableSystemFieldAttack()
          SetEnableAllCheckPoint(false)
          Prcs_d0207_CarryingHagurumon_02()
          Field_Talk_End_Not_LetterBox()
          Cam.Inst:Clear(20)
        elseif result == RESULT_TALK01 then
          Field_Talk_End_Not_LetterBox()
          Cam.Inst:Clear(20)
        end
      elseif Flg.Check("FLAG_IS_CARRY_OBJECT") then
        MovePlayerToLocatorFrame("gim_0003", 20)
        SetPlayerRotationByLocator("gim_0003", 10)
        Prcs_d02_PutHagurumon("gim_0003", "obj_0005")
        local tlk = Tlk:new("d02")
        tlk:StartTalk()
        Cam.Inst:Set(22.683, 14.736, -9.625, 15.365, 16.552, -3.056, default, 20)
        tlk:Message("f_d0207_0010_0010")
        tlk:EndTalk(true)
        Cam.Inst:Clear(20)
        Prcs_d02_HagurumonGimStart("obj_0005", "obj_0006", "obj_0009", "obj_0007")
        Flg.Set("FLAG_GIMMICK_D02_280")
        Flg.Set("FLAG_GIMMICK_D02_290")
        Cam.Inst:Clear(30)
        ColOff("cliff_cl_1003")
        Flg.Set("FLAG_GIMMICK_D02_230")
        Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
        Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
        tlk:StartTalk()
        tlk:Message("f_d0207_0010_0020")
        tlk:EndTalk()
        Cam.Inst:Clear(20)
        Field.CancelDisableSystemFieldAttack()
        SetEnableAllCheckPoint(true)
      else
        MovePlayerToLocatorFrame("gim_0003", 20)
        SetPlayerRotationByLocator("gim_0003", 10)
        Field_Talk_Start_Not_LetterBox(gGimText, 1)
        Cam.Inst:Set(22.683, 14.736, -9.625, 15.365, 16.552, -3.056, default, 20)
        Message("g_d0207_0010_0010")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(20)
      end
    end
    if gim_id == 7 and not Flg.Check("FLAG_GIMMICK_D02_455") then
      Field.PlayerLoadAnimation("e519")
      while Field.IsLoadingPlayerAnimation("e519") do
        WaitFrame(1)
      end
      require("treasure_d207")
      treasure_d207()
      Field.PlayerPlayAnimation("e519", 0, false)
      ShowGetItemLog(32101, 1)
      while Field.IsPlayerPlayingAnimation("e519") do
        WaitFrame(1)
      end
      Flg.Set("FLAG_GIMMICK_D02_455")
    end
  elseif gMapNum == 208 then
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      local info_board = Field.GetControlScriptExternalVariableNumber("info_board")
      if info_board == 0 then
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Message("f_d0208_0030_0010")
        Field_Talk_End_Not_LetterBox()
        Field.SetControlScriptExternalVariable("info_board", 1)
      elseif info_board == 1 then
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Message("f_d0208_0010_0010")
        Field_Talk_End_Not_LetterBox()
        Field.SetControlScriptExternalVariable("info_board", 2)
      elseif info_board == 2 then
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Message("f_d0208_0020_0010")
        Field_Talk_End_Not_LetterBox()
        Field.SetControlScriptExternalVariable("info_board", 0)
      end
    end
  elseif gMapNum == 209 then
    if gim_id == 1 then
      if Flg.Check("FLAG_GIMMICK_D02_310") then
        MovePlayerToLocatorFrame("gim_0001", 20)
        SetPlayerRotationByLocator("gim_0001", 10)
        local tlk = Tlk:new("d02")
        tlk:StartTalk()
        Cam.Inst:Set(6.508, 10.7995, -7.1346, 12.6759, 11.6956, 0.6854, default, 20)
        tlk:Message("f_d0209_0010_0010")
        local result = tlk:Select(2, "f_d0209_0020_0010")
        if result == RESULT_TALK00 then
          Field.DisableSystemFieldAttack()
          SetEnableAllCheckPoint(false)
          Prcs_d0209_CarryingHagurumon_01(tlk)
          Cam.Inst:Clear(20)
        elseif result == RESULT_TALK01 then
          tlk:EndTalk()
          Cam.Inst:Clear(20)
        end
      elseif Flg.Check("FLAG_IS_CARRY_OBJECT") then
        MovePlayerToLocatorFrame("gim_0001", 20)
        SetPlayerRotationByLocator("gim_0001", 10)
        Prcs_d02_PutHagurumon("gim_0001", "obj_0001")
        local tlk = Tlk:new("d02")
        tlk:StartTalk()
        Cam.Inst:Set(6.508, 10.7995, -7.1346, 12.6759, 11.6956, 0.6854, default, 20)
        tlk:Message("f_d0209_0030_0010")
        tlk:EndTalk(true)
        Field.CancelDisableSystemFieldAttack()
        SetEnableAllCheckPoint(true)
        Cam.Inst:Clear(20)
        if not Flg.Check("FLAG_GIMMICK_D02_360") then
          Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):CancelInvisible()
          Prcs_d02_HagurumonGimStart("obj_0001", "obj_0002", "obj_0008", "")
          Flg.Set("FLAG_GIMMICK_D02_360")
        else
          Prcs_d02_HagurumonGimStart("obj_0001", "obj_0002", "obj_0008", "")
          Cam.Inst:Clear(30)
          Motion.Gimmick:ResetFrame("obj_0001", "e001", 0, 0, 300, false)
        end
        ColOff("cliff_cl_1000")
        Flg.Set("FLAG_GIMMICK_D02_310")
        Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
        Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
        tlk:StartTalk()
        tlk:Message("f_d0209_0030_0020")
        tlk:EndTalk()
      else
        MovePlayerToLocatorFrame("gim_0001", 20)
        SetPlayerRotationByLocator("gim_0001", 10)
        local tlk = Tlk:new(gGimText)
        tlk:StartTalk()
        Cam.Inst:Set(6.508, 10.7995, -7.1346, 12.6759, 11.6956, 0.6854, default, 20)
        tlk:Message("g_d0207_0010_0010")
        tlk:EndTalk()
        Cam.Inst:Clear(20)
      end
    end
    if gim_id == 3 then
      if Flg.Check("FLAG_GIMMICK_D02_330") then
        Field_Talk_Start_Not_LetterBox("d02", 1)
        Cam.Inst:Set(23.444, 21.099, -8.326, 18.724, 21.274, 0.487, default, 20)
        Message("f_d0209_0040_0010")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(20)
      elseif Flg.Check("FLAG_IS_CARRY_OBJECT") then
        MovePlayerToLocatorFrame("gim_0003", 20)
        SetPlayerRotationByLocator("gim_0003", 10)
        Prcs_d02_PutHagurumon("gim_0003", "obj_0005")
        local tlk = Tlk:new("d02")
        tlk:StartTalk()
        Cam.Inst:Set(23.444, 21.099, -8.326, 18.724, 21.274, 0.487, default, 20)
        tlk:Message("f_d0209_0030_0010")
        local elv_0003 = Obj:new(FLD_OBJ_LOCATOR, "elv_0003")
        elv_0003:CancelInvisible()
        elv_0003:SetEnableGimmick(true)
        tlk:EndTalk(true)
        Field.CancelDisableSystemFieldAttack()
        SetEnableAllCheckPoint(true)
        Cam.Inst:Clear(20)
        PlaySE(200044, 100)
        if not Flg.Check("FLAG_GIMMICK_D02_370") then
          Prcs_d02_HagurumonGimStart("obj_0005", "", "obj_0007", "obj_0006")
          Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):Invisible()
          Flg.Set("FLAG_GIMMICK_D02_370")
          Flg.Set("FLAG_GIMMICK_D02_380")
        end
        SetEnableGimmickCheck("gim_0001", false)
        SetEnableGimmickCheck("obj_0001", false)
        Flg.Set("FLAG_GIMMICK_D02_330")
        Cam.Inst:Clear(20)
        MovePlayerToLocatorFrame("gim_0003", 20)
        SetPlayerRotationByLocator("gim_0003", 10)
        tlk:StartTalk()
        tlk:Message("f_d0209_0030_0020")
        tlk:EndTalk()
        M140:Event_055()
      else
        MovePlayerToLocatorFrame("gim_0003", 20)
        SetPlayerRotationByLocator("gim_0003", 10)
        Field_Talk_Start_Not_LetterBox(gGimText, 1)
        Cam.Inst:Set(23.444, 21.099, -8.326, 18.724, 21.274, 0.487, default, 20)
        Message("g_d0207_0010_0010")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(20)
      end
    end
  elseif gMapNum == 210 then
    if gim_id == 1 then
      Motion.Gimmick:Play("gim_0001", "e001", false)
    end
    if gim_id == 4 and not Flg.Check("FLAG_GIMMICK_D02_420") then
      Field_Talk_Start_Not_LetterBox(gGimText, 1)
      Message("g_d0210_0030_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 211 then
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      if Common.CheckTimeAxis("A2020_dbef_120", "A2020_dbef_200") then
        if not Flg.Check("FLAG_IS_CHECK_D0211_ICEBOX") then
          Prcs_d0211_CheckFridge()
        else
          Field_Talk_Start_Not_LetterBox("d02", 1)
          Message("f_d0211_0020_0010")
          Field_Talk_End_Not_LetterBox()
        end
      elseif Common.CheckTimeAxis("A2028_daft_200", "A2028_daft_450") then
        if not Flg.Check("FLAG_IS_CHECK_D0211_ICEBOX_01") then
          Prcs_d0211_CheckFridge()
        else
          Field_Talk_Start_Not_LetterBox("d02", 1)
          Message("f_d0211_0050_0020")
          Field_Talk_End_Not_LetterBox()
        end
      end
    end
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      MapChange("d", 201, "start_02", true, 0, 15)
    end
  elseif gMapNum == 212 then
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      MapChange("d", 201, "start_03", true, 0, 15)
    end
  elseif gMapNum == 213 then
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200001, 100)
      MapChange("d", 201, "start_06", true, 0, 15)
    end
  elseif gMapNum == 215 then
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      Motion.Gimmick:Play("obj_0001", "e001", false)
      Motion.Gimmick:WaitFrame("obj_0001", "e001", 0)
      Motion.Gimmick:Play("obj_0001", "e002", false)
    end
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0020_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 3 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0070_0010")
      MessageClose()
      MessageTalkSel(2, "f_d0215_0070_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Message("f_d0215_0070_0030")
        MessageClose()
        MessageTalkSel(2, "f_d0215_0070_0040")
        result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_d0215_0070_0050")
          MessageClose()
          MessageTalkSel(2, "f_d0215_0070_0060")
          result = Talk.GetResultSelectedNum()
          if result == RESULT_TALK00 then
            Message("f_d0215_0070_0070")
            MessageClose()
            MessageTalkSel(2, "f_d0215_0070_0080")
            result = Talk.GetResultSelectedNum()
            if result == RESULT_TALK00 then
              Message("f_d0215_0070_0090")
              Message("f_d0215_0070_0100")
              MessageClose()
              WaitFrame(20)
              Message("f_d0215_0070_0110")
              Field_Talk_End_Not_LetterBox()
            end
          else
            Field_Talk_End_Not_LetterBox()
          end
        else
          Field_Talk_End_Not_LetterBox()
        end
      else
        Field_Talk_End_Not_LetterBox()
      end
    end
    if gim_id == 4 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0090_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 5 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0080_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 6 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      Message("f_d0215_0060_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 400 then
      if Flg.Check("FLAG_MAIN_03_495", "FLAG_MAIN_03_515") then
        M120:Event_068()
      end
      PlayerLookAtLccatorObject(gim_name)
      Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
      OpenDoor(gim_loc, "")
      DoorMapChange("d", 202, "start_01")
    end
  elseif gMapNum == 216 then
    if gim_id == 401 then
    end
  elseif gMapNum == 217 then
    if gim_id == 1 then
      if not Flg.Check("FLAG_GIMMICK_D02_450") then
        Field.PlayerLoadAnimation("e519")
        while Field.IsLoadingPlayerAnimation("e519") do
          WaitFrame(1)
        end
        require("treasure_d217")
        treasure_d217()
        Field.PlayerPlayAnimation("e519", 0, false)
        ShowGetItemLog(30011, 1)
        while Field.IsPlayerPlayingAnimation("e519") do
          WaitFrame(1)
        end
        Flg.Set("FLAG_GIMMICK_D02_450")
      end
    elseif gim_id == 400 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      WaitFrame(5)
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
      SetControlScriptExternalVariable("player_state", "pass")
      WaitFrame(5)
      ColOff("cliff_cl_0001")
      local loc_pos = Field.GetLocatorPosition("change_0001")
      local loc_rot = Field.GetLocatorRotationYDegree("change_0001")
      local player = Obj:new(PLAYER, "")
      Field.SetFollowerCameraOperateRotationY(loc_rot, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      Field.SetFollowerCameraOperateRotationX(0, 60, EASING_MODE_QUADRATIC_IN_OUT, 20)
      WaitFrame(10)
      local dis_x = math.abs(loc_pos.x - player.pos.x)
      local dis_z = math.abs(loc_pos.z - player.pos.z)
      if 0.15 <= dis_x and 0.15 <= dis_z then
        local move_pos_x = -54.314
        local move_pos_z = -27.296
        local move_point_x = move_pos_x - player.pos.x
        local move_point_z = move_pos_z - player.pos.z
        MovePlayerToRelativePosFrame(move_point_x, move_point_z, 20)
      end
      WaitFrame(20)
      player:SetRotationY(loc_rot, 10)
      WaitFrame(7)
      Motion.Player:ChangeMoveAnimWithBlend("hide", 15, 0.75)
      WaitFrame(15)
      MovePlayerFrame(180, 0.75, 45)
      WaitFrame(30)
      MapChange("d", 202, "start_06", true, 0, 15)
    end
    if gim_id == 401 then
      GoToTheaterWithEvt()
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
  if gMapNum == 205 then
  elseif gMapNum == 207 then
  elseif gMapNum == 208 then
  elseif gMapNum == 209 then
  elseif gMapNum == 210 then
  elseif gMapNum == 217 then
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
  if gMapNum == 201 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      if gim_name == "fa_m350_01" then
      end
    end
  elseif gMapNum == 202 then
    if gim_tag == "fa_obj_ele" and gim_name == "fa_obstacles_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_d0202_0010_0010") then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D02_240")
      FieldObjectSync(OGIM, false)
    end
  elseif gMapNum == 203 then
  elseif gMapNum == 204 then
  elseif gMapNum == 205 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 206 then
  elseif gMapNum == 207 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_02" then
      SetEnableGimmickCheck("wall_along_0001", true)
      Flg.Set("FLAG_GIMMICK_D02_200")
    end
  elseif gMapNum == 208 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 209 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_01" then
      Obj:new(FLD_OBJ_GIMMICK, "fa_obstacles_02"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_GIMMICK, "fa_obstacles_03"):SetEnableCheckAndFieldAttack(false)
      Flg.Set("FLAG_GIMMICK_D02_140")
    end
    if gim_name == "fa_obstacles_02" then
      Obj:new(FLD_OBJ_GIMMICK, "fa_obstacles_03"):SetEnableCheckAndFieldAttack(true)
      Flg.Set("FLAG_GIMMICK_D02_150")
    end
    if gim_name == "fa_obstacles_03" then
      Flg.Set("FLAG_GIMMICK_D02_390")
      FieldObjectSync(RUMOR_NPC, false)
      Obj:new(NPC, "npc_0001"):CancelInvisible()
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon01"):Invisible()
    end
  elseif gMapNum == 210 then
    if gim_name == "fa_obstacles_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_d0210_0010_0010") then
      BreakFieldAttackGim(gim_name, true)
      Prcs_d0210_Elvlamp()
      Flg.Set("FLAG_GIMMICK_D02_420")
      SetEnableGimmickCheck("gim_0002", false)
    end
    if gim_name == "fa_obstacles_02" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D02_425")
      SetEnableGimmickCheck("theater_0001", true)
    end
    if gim_name == "fa_treasure_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
    if gim_name == "fa_treasure_02" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
    if gim_name == "fa_treasure_03" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
  elseif gMapNum == 216 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 217 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_tag == "fa_obj_hazama" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D02_180")
      FieldObjectSync(OGIM, false)
    end
    if gim_name == "fa_obstacles_03" then
      Flg.Set("FLAG_GIMMICK_D02_455")
      SetEnableGimmickCheck("theater_0001", true)
    end
  end
end

function OnCheckActModel(act)
end

function OnCheckLocatorWallAlong(wall_along)
  local start_loc = wall_along.locator
  Field.OperateStartLocatorWallAlong(start_loc)
end

function Prcs_d0201_shop_0001Cam()
  Cam.Inst:Set(-28.75, 3.045, 28.764, -20.791, 3.949, 34.75, default, 20)
end

function Prcs_d0201_shop_0002Cam()
  Cam.Inst:Set(-29.655, 3.049, 29.766, -21.642, 4.076, 35.66, default, 20)
end

function Prcs_d0201_merukuri_0001Cam()
  Cam.Inst:Set(1.569696, 8.146063, -58.078457, 0.245783, 4.867414, -67.43248, default, 40)
end
