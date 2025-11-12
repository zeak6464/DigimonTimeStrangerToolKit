gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 601 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 601 then
    local index = GetIndex(NPC, "npc_0001")
    Field.ObjectSuspendAutoTransparent(NPC, index, AUTO_TRANSPARENT_TYPE_ALL)
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 601 then
    if col_name == "evt_0001" then
      M300:Event_130()
    end
    if col_name == "evt_0002" then
      M300:Event_070()
    end
    if col_name == "evt_0003" then
      Field.SetProhibitPlayerMoveOperate(true)
      local count = Field.GetControlScriptExternalVariableNumber("loop_count")
      if count ~= Work.Get(Field_H06_LoopCount) then
        count = Work.Get(Field_H06_LoopCount)
      end
      if count == 2 then
        if Flg.Check("FLAG_MAIN_10_040", "FLAG_MAIN_10_041") then
          local tlk = Tlk:new("h06", 1, true, false)
          tlk:StartTalk()
          tlk:Message("f_h0601_0030_0031")
          tlk:Message("f_h0601_0030_0040")
          tlk:EndTalk()
          Field.SetProhibitPlayerMoveOperate(false)
          Flg.Set("FLAG_MAIN_10_041")
        end
      elseif count == 3 then
        if Flg.Check("FLAG_MAIN_10_041", "FLAG_MAIN_10_042") then
          Field.SetProhibitPlayerMoveOperate(true)
          local tlk = Tlk:new("h06", 1, true, false)
          tlk:StartTalk()
          tlk:Message("f_h0601_0060_0010")
          tlk:Message("f_h0601_0060_0020")
          tlk:EndTalk()
          Field.SetProhibitPlayerMoveOperate(false)
          Flg.Set("FLAG_MAIN_10_042")
        end
      elseif count == 4 and Flg.Check("FLAG_MAIN_10_042", "FLAG_MAIN_10_043") then
        Field.SetProhibitPlayerMoveOperate(true)
        local tlk = Tlk:new("h06", 1, true, false)
        tlk:StartTalk()
        tlk:Message("f_h0601_0030_0050")
        tlk:Message("f_h0601_0030_0060")
        tlk:Message("f_h0601_0030_0070")
        tlk:EndTalk()
        Field.SetProhibitPlayerMoveOperate(false)
        Field.ObjectSetRotationY(FLD_OBJ_PLAYER, 1, 260, 15)
        Flg.Set("FLAG_MAIN_10_043")
      end
    end
    if col_name == "evt_1000" then
      Prcs_h0601_TowerWarp(col_name, "script_tower1exit2", "script_tower1exit1", "script_t1_U_R")
    elseif col_name == "evt_1001" then
      Prcs_h0601_TowerWarp(col_name, "script_tower1exit2", "script_tower1exit1", "script_t1_U_R")
    elseif col_name == "evt_1002" then
      Prcs_h0601_TowerWarp(col_name, "script_tower1exit1", "script_tower2exit2", "script_t2_U_L")
    elseif col_name == "evt_1003" then
      Prcs_h0601_TowerWarp(col_name, "script_tower1exit1", "script_tower3exit2", "script_t3_B_R")
    elseif col_name == "evt_1004" then
      Prcs_h0601_TowerWarp(col_name, "script_tower2exit2", "script_tower2exit1", "script_t2_B_R")
    elseif col_name == "evt_1005" then
      Prcs_h0601_TowerWarp(col_name, "script_tower2exit2", "script_tower3exit2", "script_t3_B_L")
    elseif col_name == "evt_1006" then
      Prcs_h0601_TowerWarp(col_name, "script_tower2exit1", "script_tower3exit1", "script_t3_U_R")
    elseif col_name == "evt_1007" then
      Prcs_h0601_TowerWarp(col_name, "script_tower2exit1", "script_tower1exit1", "script_t1_U_L")
    elseif col_name == "evt_1008" then
      Prcs_h0601_TowerWarp(col_name, "script_tower3exit2", "script_tower1exit2", "script_t1_B_L")
      local count = Field.GetControlScriptExternalVariableNumber("loop_count")
      if count ~= Work.Get(Field_H06_LoopCount) then
        count = Work.Get(Field_H06_LoopCount)
      end
      Field.SetControlScriptExternalVariable("loop_count", count + 1)
      count = Field.GetControlScriptExternalVariableNumber("loop_count")
      Work.Set(Field_H06_LoopCount, count)
      if count == 1 then
        Field.SetProhibitPlayerMoveOperate(true)
        local tlk = Tlk:new("h06", 1, true, false)
        tlk:StartTalk()
        tlk:Message("f_h0601_0050_0010")
        tlk:Message("f_h0601_0050_0020")
        tlk:EndTalk()
        Field.SetProhibitPlayerMoveOperate(false)
      end
    elseif col_name == "evt_1009" then
      Prcs_h0601_TowerWarp(col_name, "script_tower3exit2", "script_tower1exit2", "script_t1_B_R")
    elseif col_name == "evt_1010" then
      Prcs_h0601_TowerWarp(col_name, "script_tower3exit1", "script_tower2exit2", "script_t2_U_R")
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 601 then
  elseif gMapNum == 602 then
    if gim_id == 1 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0001", "obj_0002", "plan_cl_1000", "plan_cl_1001", "switch01")
    end
    if gim_id == 11 then
      Prcs_h06_WarpGim("gim_0011", "gim_0012", "script_tower1exit2", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 12 then
      Prcs_h06_WarpGim("gim_0012", "gim_0011", "script_tower1exit1", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 13 then
      Prcs_h06_WarpGim("gim_0013", "gim_0014", "script_tower2exit1", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 14 then
      Prcs_h06_WarpGim("gim_0014", "gim_0013", "script_tower2exit2", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 15 then
      Prcs_h06_WarpGim("gim_0015", "gim_0016", "script_tower3exit2", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 16 then
      Prcs_h06_WarpGim("gim_0016", "gim_0015", "script_tower3exit1", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 17 then
      Prcs_h06_WarpGim("gim_0017", "gim_0018", "script_tower4exit2", "plan_cl_1016", "plan_cl_1017")
    elseif gim_id == 18 then
      Prcs_h06_WarpGim("gim_0018", "gim_0017", "script_tower4exit1", "plan_cl_1016", "plan_cl_1017")
    end
  elseif gMapNum == 603 then
    if gim_id == 1 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0001", "obj_0002", "plan_cl_1000", "plan_cl_1001", "switch01")
    elseif gim_id == 2 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0003", "obj_0004", "plan_cl_1003", "plan_cl_1002", "switch02")
    end
    if gim_id == 11 then
      Prcs_h06_WarpGim("gim_0011", "gim_0012", "script_tower1exit1", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 12 then
      Prcs_h06_WarpGim("gim_0012", "gim_0011", "script_tower1exit2", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 13 then
      Prcs_h06_WarpGim("gim_0013", "gim_0014", "script_tower2exit1", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 14 then
      Prcs_h06_WarpGim("gim_0014", "gim_0013", "script_tower2exit2", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 15 then
      Prcs_h06_WarpGim("gim_0015", "gim_0016", "script_tower3exit1", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 16 then
      Prcs_h06_WarpGim("gim_0016", "gim_0015", "script_tower3exit2", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 17 then
      Prcs_h06_WarpGim("gim_0017", "gim_0018", "script_tower4exit1", "plan_cl_1016", "plan_cl_1017")
    elseif gim_id == 18 then
      Prcs_h06_WarpGim("gim_0018", "gim_0017", "script_tower4exit2", "plan_cl_1016", "plan_cl_1017")
    elseif gim_id == 19 then
      Prcs_h06_WarpGim("gim_0019", "gim_0020", "script_tower5exit1", "plan_cl_1018", "plan_cl_1019")
    elseif gim_id == 20 then
      Prcs_h06_WarpGim("gim_0020", "gim_0019", "script_tower5exit2", "plan_cl_1018", "plan_cl_1019")
    elseif gim_id == 21 then
      Prcs_h06_WarpGim("gim_0021", "gim_0022", "script_tower6exit1", "plan_cl_1020", "plan_cl_1021")
    elseif gim_id == 22 then
      Prcs_h06_WarpGim("gim_0022", "gim_0021", "script_tower6exit2", "plan_cl_1020", "plan_cl_1021")
    end
  elseif gMapNum == 604 then
    if gim_id == 1 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0001", "obj_0002", "plan_cl_1000", "plan_cl_1001", "switch01")
    elseif gim_id == 2 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0003", "obj_0004", "plan_cl_1002", "plan_cl_1003", "switch02")
    elseif gim_id == 3 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0005", "obj_0006", "plan_cl_1004", "plan_cl_1005", "switch03")
    end
    if gim_id == 11 then
      Prcs_h06_WarpGim("gim_0011", "gim_0012", "script_tower1exit2", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 12 then
      Prcs_h06_WarpGim("gim_0012", "gim_0011", "script_tower1exit1", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 13 then
      Prcs_h06_WarpGim("gim_0013", "gim_0014", "script_tower2exit2", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 14 then
      Prcs_h06_WarpGim("gim_0014", "gim_0013", "script_tower2exit1", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 15 then
      Prcs_h06_WarpGim("gim_0015", "gim_0016", "script_tower3exit2", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 16 then
      Prcs_h06_WarpGim("gim_0016", "gim_0015", "script_tower3exit1", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 17 then
      Prcs_h06_WarpGim("gim_0017", "gim_0018", "script_tower4exit2", "plan_cl_1016", "plan_cl_1017")
    elseif gim_id == 18 then
      Prcs_h06_WarpGim("gim_0018", "gim_0017", "script_tower4exit1", "plan_cl_1016", "plan_cl_1017")
    elseif gim_id == 19 then
      Prcs_h06_WarpGim("gim_0019", "gim_0020", "script_tower5exit2", "plan_cl_1018", "plan_cl_1019")
    elseif gim_id == 20 then
      Prcs_h06_WarpGim("gim_0020", "gim_0019", "script_tower5exit1", "plan_cl_1018", "plan_cl_1019")
    end
  elseif gMapNum == 605 then
    if gim_id == 1 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0001", "obj_0002", "plan_cl_1000", "plan_cl_1001", "switch01")
    elseif gim_id == 2 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0003", "obj_0004", "plan_cl_1002", "plan_cl_1003", "switch02")
    elseif gim_id == 3 then
      Prcs_h06_SwitchGim(gim_loc, "obj_0005", "obj_0006", "plan_cl_1004", "plan_cl_1005", "switch03")
    end
    if gim_id == 11 then
      Prcs_h06_WarpGim("gim_0011", "gim_0012", "script_tower1exit2", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 12 then
      Prcs_h06_WarpGim("gim_0012", "gim_0011", "script_tower1exit1", "plan_cl_1010", "plan_cl_1011")
    elseif gim_id == 13 then
      Prcs_h06_WarpGim("gim_0013", "gim_0014", "script_tower2exit2", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 14 then
      Prcs_h06_WarpGim("gim_0014", "gim_0013", "script_tower2exit1", "plan_cl_1012", "plan_cl_1013")
    elseif gim_id == 15 then
      Prcs_h06_WarpGim("gim_0015", "gim_0016", "script_tower3exit2", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 16 then
      Prcs_h06_WarpGim("gim_0016", "gim_0015", "script_tower3exit1", "plan_cl_1014", "plan_cl_1015")
    elseif gim_id == 17 then
      Prcs_h06_WarpGim("gim_0017", "gim_0018", "script_tower4exit2", "plan_cl_1016", "plan_cl_1017")
    elseif gim_id == 18 then
      Prcs_h06_WarpGim("gim_0018", "gim_0017", "script_tower4exit1", "plan_cl_1016", "plan_cl_1017")
    end
  end
end

function OnCheckActModel(act)
end
