gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 1001 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      move_motion = {"hide"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0004",
      motion = {"e001", "e002"}
    })
    Motion.Object:LoadMove(FLD_OBJ_PLAYER, "", "hide")
  elseif load_map_num == 1002 then
  elseif load_map_num == 1003 then
    AddLoadList(FLD_OBJ_PLAYER, {
      "",
      motion = {"e013"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "gim_0001",
      motion = {"e001"}
    })
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d10_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if not Flg.Check("FLAG_MAIN_01_090") then
    Field.DisableAnalyzeAndFieldAttack()
  end
  if gMapNum == 1001 then
    ColOff("cliff_cl_1000")
    ColOff("cliff_cl_1001")
    ColOff("wall_cl_1001")
    if not Flg.Check("FLAG_MAIN_01_130") then
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):SetEnableCheckAndFieldAttack(false)
    end
    if not Flg.Check("FLAG_MAIN_01_140") then
      local index = GetIndex(FLD_OBJ_LOCATOR, "gim_0004")
      Field.ObjectOverwriteFieldAttackableRange(FLD_OBJ_LOCATOR, index, 0, 0, 0)
    end
    if Flg.Check("FLAG_MAIN_01_080", "FLAG_MAIN_01_170") then
      RegularQuake_Start(0.01, 0, 60, 120)
      SetQuakeEffect("ef_f_com_220_cr")
    end
    if Flg.Check("FLAG_GIMMICK_D10_010") then
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e001")
      Motion.Gimmick:PlayFinishedAnim("gim_0001", "e002")
    else
      Motion.Gimmick:Play("gim_0001", "e001", true)
    end
    if Flg.Check("FLAG_GIMMICK_D10_020") then
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e002")
      SetEnableGimmickCheck("gim_0004", false)
      ColOff("cliff_cl_0001")
    end
    if Flg.Check("FLAG_MAIN_01_110") then
      ColOff("wall_cl_1000")
      Obj:new(FLD_OBJ_LOCATOR, "obj_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0008"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0009"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0010"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0011"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0012"):Invisible()
      ColOff("plan_cl_4000")
      ColOff("plan_cl_4001")
      ColOff("plan_cl_4002")
      ColOff("plan_cl_4003")
      ColOff("plan_cl_4004")
    end
    if Flg.Check("FLAG_MAIN_01_110") and not Flg.Check("FLAG_MAIN_01_160") then
      if Flg.Check("FLAG_MAIN_01_130") then
        SetControlScriptExternalVariable("mgreymon_state", "relocation2")
      elseif not Flg.Check("FLAG_MAIN_01_130") then
        SetControlScriptExternalVariable("mgreymon_state", "relocation")
      end
      ColOn("wall_cl_1010")
      Obj:new(FLD_OBJ_LOCATOR, "obj_0013"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0014"):CancelInvisible()
    else
      ColOff("wall_cl_1010")
      Obj:new(FLD_OBJ_LOCATOR, "obj_0013"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0014"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_D10_116") and not Flg.Check("FLAG_MAIN_01_160") then
      ColOn("wall_cl_1002")
    else
      ColOff("wall_cl_1002")
    end
    if Flg.Check("FLAG_MAIN_03_320", "FLAG_MAIN_03_380") then
      ColOn("cliff_cl_1000")
      ColOn("cliff_cl_1001")
      ColOn("wall_cl_1001")
      Field.LinkColOff("col_d1002_start_00_0")
      Field.LinkColOff("col_d1103_start_02_0")
      Field.LinkColOff("col_d1101_start_00_0")
      Field.LinkColOff("col_d1003_start_01_0")
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e001")
      ColOn("wall_cl_2001")
      ColOn("cliff_cl_0001")
    elseif Flg.Check("FLAG_MAIN_07_030") then
      ColOn("cliff_cl_1000")
      ColOn("wall_cl_1001")
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e001")
      ColOn("wall_cl_2001")
      ColOn("cliff_cl_0001")
    end
    if Common.CheckTimeAxis("P2028_daft_0", "P2028_daft_10000") or Common.CheckTimeAxis("A2028_daft_310", "A2028_daft_10000") then
      Motion.Gimmick:PlayFinishedAnim("gim_0004", "e002")
      ColOff("wall_cl_2001")
      ColOff("cliff_cl_0001")
      ColOff("cliff_cl_1000")
      ColOff("cliff_cl_1001")
      ColOff("wall_cl_1001")
    end
  elseif gMapNum == 1003 then
    if Flg.Check("FLAG_MAIN_01_000", "FLAG_MAIN_01_080") then
      Field.DisableSystemFieldAttack()
    else
      Field.CancelDisableSystemFieldAttack()
      Field.CancelDisableAnalyzeAndFieldAttack()
    end
    if Common.CheckTimeAxis("X2028_daft_0", "X2028_daft_20") or Common.CheckTimeAxis("P2028_daft_0", "P2028_daft_10000") or Common.CheckTimeAxis("A2028_daft_310", "A2028_daft_10000") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):Invisible()
      ColOff("evt_3000")
      ColOff("evt_3001")
      ColOff("wall_cl_0002")
      ColOff("wall_cl_0003")
    else
      Obj:new(FLD_OBJ_LOCATOR, "obj_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0004"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "obj_0005"):Invisible()
      ColOn("wall_cl_0001")
      ColOff("wall_cl_0002")
      ColOff("wall_cl_0003")
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 1001 then
    if col_name == "evt_1000" then
      M010:Event_135()
    end
    if col_name == "evt_1001" then
      M010:Event_150()
    end
    if col_name == "evt_1100" then
      M010:Event_100()
    end
    if col_name == "evt_1005" then
      M020:Event_030()
    end
    if col_name == "evt_1006" then
      M020:Event_040()
    end
    if col_name == "evt_1014" then
      M020:Event_060()
    end
    if col_name == "evt_1009" and Flg.Check("FLAG_MAIN_01_150") and not Flg.Check("FLAG_GIMMICK_D10_116") then
      Field_Talk_Start_Not_LetterBox("d10", 1)
      Message("f_d1001_0050_0010")
      Field_Talk_End_Not_LetterBox()
      Field.MovePlayerToLocatorFrame("sp_0005", 30)
    end
    if col_name == "evt_1010" and Flg.Check("FLAG_MAIN_01_140") and not Flg.Check("FLAG_MAIN_01_150") then
      Field_Talk_Start_Not_LetterBox("d10", 1)
      Message("f_d1001_0060_0010")
      Field_Talk_End_Not_LetterBox()
      Field.MovePlayerToLocatorFrame("sp_0006", 30)
    end
    if col_name == "evt_1012" and Flg.Check("FLAG_MAIN_01_150") and not Flg.Check("FLAG_FIELD_D10_011") then
      SetControlScriptExternalVariable("mgreymon_state", "roaming3")
      Cam.Inst:Set(-17.51, -2, 33.1, -7.51, -1.5, 33.1, default, 30)
      WaitFrame(60)
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Flg.Set("FLAG_FIELD_D10_011")
    end
    if col_name ~= "evt_1013" or not Flg.Check("FLAG_MAIN_03_360") then
    end
    if col_name == "evt_2000" then
      if not Flg.Check("FLAG_GIMMICK_D10_070") then
        Prcs_d1001_HideToHole()
      elseif Flg.Check("FLAG_GIMMICK_D10_070") then
        Prcs_d1001_CanselHideToHole()
      end
    end
    if col_name == "evt_9000" and Flg.Check("FLAG_MAIN_01_110") and not Flg.Check("FLAG_MAIN_01_140") then
      M020:Event_060()
      Flg.Set("FLAG_MAIN_01_140")
      ColOff("wall_cl_1000")
    end
  elseif gMapNum == 1002 then
    if col_name == "evt_1000" then
      M020:Event_090()
    end
    if col_name == "evt_3000" then
    end
    if col_name == "evt_2000" then
      M020:Event_110()
    end
    if col_name == "evt_2001" then
      M020:Event_111()
    end
    if col_name == "evt_2002" then
      M020:Event_112()
    end
    if col_name == "evt_1001" and Flg.Check("FLAG_MAIN_01_170", "FLAG_MAIN_02_010") then
      local tlk = Tlk:new("d10", 1, true)
      tlk:StartTalk()
      AnswerTheCall()
      tlk:Message("f_d1002_0030_0010")
      tlk:MessageClose()
      EndTheCall()
      Field.MovePlayerToRelativePosFrame(-1.5, 0, 30)
      WaitFrame(30)
      tlk:EndTalk()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  elseif gMapNum == 1003 then
    if col_name == "evt_1001" then
      M010:Event_091()
    end
    if col_name == "evt_1003" then
      M010:Event_120()
    end
    if col_name == "evt_1004" then
    end
    if col_name == "evt_2000" then
      M010:Event_090()
      M010:Event_092()
    end
    if col_name == "evt_2001" then
      M010:Event_093()
      M020:Event_143()
      M010:Event_094()
    end
    if col_name == "evt_2002" then
      M010:Event_096()
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 1001 then
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d1001_Breaker()
    end
    if gim_id == 4 then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_d1001_OpenGrateDoor()
    end
    if gim_id == 300 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      PlayerLookAtLccatorObject(gim_name)
      GoToOuter("change_0001", -0.8, 1)
      if not Flg.Check("FLAG_MAIN_03_350") then
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      end
      MapChange("h", 301, "start_00", true, 1, FADE_TIME)
    end
    if gim_name == "gim_0002" then
      PlayerLookAtLccatorObject(gim_name)
      M010:Event_130()
    end
  elseif gMapNum == 1003 then
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 1001 and gim_name == "shutter_access" then
    Field.CancelPlayerAnywhereDigimonRide(false, true)
    PlayerLookAtGimmickObject(gim_name)
    MapChange("t", 105, "start_05", true, 0, FADE_TIME)
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
  if gMapNum == 1001 then
    if gim_name == "gim_0004" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      local obj = Obj:new(att_gim.obj_type, gim_name)
      Field.LoadEffectScript("ef_f_com_300_sm", 1)
      Quake_Start(0.2, 0.5, 20)
      Field.PlayEffectScript("ef_f_com_300_sm", obj.pos.x, obj.pos.y, obj.pos.z, 0, 1)
      PlaySE(202002, 100)
      Motion.Gimmick:Play("gim_0004", "e002", false)
      SetEnableGimmickCheck("gim_0004", false)
      WaitFrame(20)
      Quake_Stop()
      ColOff("cliff_cl_0001")
      Flg.Set("FLAG_GIMMICK_D10_020")
      M020:Event_055()
    end
  elseif gMapNum == 1003 then
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
  if gMapNum == 1001 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
    if gim_name == "fa_obstacles_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
      Flg.Set("FLAG_GIMMICK_D10_100")
      M010:Event_110()
    end
  elseif gMapNum == 1002 then
  elseif gMapNum == 1003 and gim_name == "fa_treasure_01" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
  end
end

function OnCheckActModel(act)
end
