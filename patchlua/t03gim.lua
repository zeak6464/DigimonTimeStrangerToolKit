gGimText = "field_text"
BRK0303 = {
  obj1 = {
    loc = "fa_0001",
    col = "plan_cl_2000",
    text = -1,
    flag = "FLAG_GIMMICK_T03_010",
    se = 202001
  },
  obj2 = {
    loc = "fa_0002",
    col = "plan_cl_2001",
    text = -1,
    flag = "FLAG_GIMMICK_T03_011",
    se = 202001
  }
}

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 301 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0001",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0002",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0003",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0004",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0051",
      motion = {"e001", "e002"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "signal_0052",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 302 then
  elseif load_map_num == 303 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0003",
      motion = {"e001", "e002"}
    })
  elseif load_map_num == 304 then
    Motion.Object:Load(FLD_OBJ_LOCATOR, "obj_0001", "e001")
    LoadEffefctScript("ef_f_com_300_sm", 2)
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if Common.IsPlayerModelChanged(true) and Common.IsPlayerModelChanged(2) then
    SetEnableMenu(false)
  end
  if gMapNum == 301 then
    Prcs_t03_SettingSignal()
    if Flg.Check("FLAG_SUB_090_072_007") then
      Obj:new(FLD_OBJ_GIMMICK, "s090_072_001"):SetIcon(ICO_NONE)
    end
  elseif gMapNum == 302 then
    if Flg.Check("FLAG_MAIN_02_060") and not Flg.Check("FLAG_MAIN_03_280") then
      ColOff("wall_cl_0001")
    end
    if Flg.Check("FLAG_MAIN_03_230", "FLAG_MAIN_03_280") then
      ColOff("wall_cl_0001")
    end
    if Flg.Check("FLAG_MAIN_03_450") then
      ColOff("wall_cl_0001")
    end
    if not Flg.Check("FLAG_MAIN_03_125") then
      ColOff("evt_7000")
    end
    if Flg.Check("FLAG_MAIN_02_020", "FLAG_MAIN_02_030") then
      ColOff("evt_4000")
    end
    if Flg.Check("FLAG_MAIN_02_030") then
      ColOff("evt_2000")
    end
    if Flg.Check("FLAG_MAIN_03_125", "FLAG_MAIN_03_130") then
      ColOff("evt_2000")
      ColOff("evt_4000")
    end
    if Flg.Check("FLAG_MAIN_03_130") then
      ColOff("evt_7000")
    end
    if Flg.Check("FLAG_MAIN_03_180") and not Flg.Check("FLAG_MAIN_03_181") then
      SetEnableGimmickCheck("gim_0001", true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):CancelInvisible()
    else
      SetEnableGimmickCheck("gim_0001", false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):Invisible()
    end
    if not Flg.Check("FLAG_MAIN_03_130", "FLAG_MAIN_03_150") then
      ColOff("wall_cl_0002")
    end
    if not Flg.Check("FLAG_MAIN_02_030") then
      Field_InvisibleObjects(RUMOR_NPC, 10, 11)
      Field_InvisibleObjects(MOB, 128, 131)
    end
    if not Flg.Check("FLAG_MAIN_02_070") then
      SetEnableGimmickCheck("map_0001", false)
      SetEnableGimmickCheck("map_0002", false)
      SetEnableGimmickCheck("map_0003", false)
      local map_0001 = Obj:new(FLD_OBJ_LOCATOR, "map_0001")
      local map_0002 = Obj:new(FLD_OBJ_LOCATOR, "map_0002")
      local map_0003 = Obj:new(FLD_OBJ_LOCATOR, "map_0003")
      map_0001:Invisible()
      map_0002:Invisible()
      map_0003:Invisible()
      Field.LinkColOff("mapborder_2")
    end
    Field.InvisibleGimmick("obj_0001", 0, 0, false)
    Field.InvisibleGimmick("obj_0002", 0, 0, false)
  elseif gMapNum == 303 then
    Field.InvisibleGimmick("obj_0001", 0, 0, false)
    ColOff("evt_1000")
    if not Flg.Check("FLAG_MAIN_02_070") then
      SetEnableGimmickCheck("map_0001", false)
    end
    if not Flg.Check("FLAG_MAIN_02_070") then
      SetEnableGimmickCheck("map_0001", false)
      local map_0001 = Obj:new(FLD_OBJ_LOCATOR, "map_0001")
      map_0001:Invisible()
    end
    if not Flg.Check("FLAG_GIMMICK_T03_010") then
      Motion.Gimmick:PlayFinishedAnim("obj_0003", "e002")
      SetEnableGimmickCheck("map_0002", false)
    else
      Motion.Gimmick:PlayFinishedAnim("obj_0003", "e001")
      SetEnableGimmickCheck("map_0002", true)
      SetEnableGimmickCheck("gim_0001", false)
    end
    if not Flg.Check("FLAG_MAIN_02_040") then
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(false)
    else
      Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(true)
    end
    if not Flg.Check("FLAG_MAIN_03_181") then
      ColOff("plan_cl_2001")
    else
      ColOn("plan_cl_2001")
    end
    if Flg.Check("FLAG_MAIN_03_182") and not Flg.Check("FLAG_MAIN_03_185") then
      SetEnableGimmickCheck("obj_1000", true)
      Obj:new(FLD_OBJ_LOCATOR, "obj_1000"):CancelInvisible()
    else
      SetEnableGimmickCheck("obj_1000", false)
      Obj:new(FLD_OBJ_LOCATOR, "obj_1000"):Invisible()
    end
    if Flg.Check("FLAG_MAIN_03_185") and not Flg.Check("FLAG_MAIN_03_190") then
      SetEnableGimmickCheck("obj_1001", true)
      Obj:new(FLD_OBJ_LOCATOR, "obj_1001"):CancelInvisible()
    else
      SetEnableGimmickCheck("obj_1001", false)
      Obj:new(FLD_OBJ_LOCATOR, "obj_1001"):Invisible()
    end
    for key in pairs(BRK0303) do
      if Flg.Check(BRK0303[key].flag) then
        Obj:new(FLD_OBJ_LOCATOR, BRK0303[key].loc):Invisible()
        ColOff(BRK0303[key].col)
      end
    end
    if not Flg.Check("FLAG_S003_004") then
      Obj:new(NPC, "Hiroko_03"):Invisible()
      Obj:new(NPC, "Koan_03"):Invisible()
    end
  elseif gMapNum == 304 then
    ColOff("wall_cl_0001")
    ColOff("wall_cl_0002")
    ColOff("wall_cl_0003")
    if Flg.Check("FLAG_MAIN_07_040") and not Flg.Check("FLAG_MAIN_07_070") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_9001"):CancelInvisible()
    else
      Obj:new(FLD_OBJ_LOCATOR, "obj_9001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_9001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_9002"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_9003"):Invisible()
    end
    local flags = {
      "FLAG_MAIN_07_040",
      "FLAG_MAIN_07_055"
    }
    if Flg.AllCheck(flags) and not Flg.Check("FLAG_MAIN_07_070") then
      Obj:new(FLD_OBJ_LOCATOR, "gim_9010"):CancelInvisible()
    else
      Obj:new(FLD_OBJ_LOCATOR, "gim_9010"):Invisible()
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 301 then
    if col_name == "evt_1000" and Flg.Check("FLAG_MAIN_03_010", "FLAG_MAIN_03_037") and not Common.CheckTimeAxis("A2020_dbef_51") then
      local tlk = Tlk:new("t03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0301_0010_0010")
      tlk:Message("f_t0301_0010_0020")
      tlk:MessageClose()
      MovePlayerToRelativePosFrame(0, 1, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
  elseif gMapNum == 302 then
    if col_name == "evt_1000" then
      if not Flg.Check("FLAG_MAIN_02_030") then
        local tlk = Tlk:new("t03")
        tlk:StartTalk()
        tlk:Message("f_t0302_0080_0010")
        tlk:MessageClose()
        Field.MovePlayerToRelativePosFrame(1, 0, 25)
        WaitFrame(25)
        tlk:EndTalk()
      elseif not Flg.Check("FLAG_MAIN_02_070") then
        local tlk = Tlk:new("t03")
        tlk:StartTalk()
        tlk:Message("f_t0302_0140_0010")
        tlk:MessageClose()
        Field.MovePlayerToRelativePosFrame(1, 0, 25)
        WaitFrame(25)
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_03_180") and not Flg.Check("FLAG_MAIN_03_191") then
        local tlk = Tlk:new("t03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0303_0090_0010")
        Field.MovePlayerToRelativePosFrame(1, 0, 25)
        WaitFrame(25)
        tlk:EndTalk()
      end
      require("S200_147")
      S200_147:Event_031()
      require("S200_149")
      S200_149:Event_070(col_name)
      require("S010_003")
      S010_003:Event_091()
    end
    if col_name == "evt_1001" or col_name == "evt_1002" then
      require("S200_149")
      S200_149:Event_070(col_name)
    end
    if col_name == "evt_2000" then
      M040:Event_020()
    end
    if col_name == "evt_3100" or col_name == "evt_3101" then
      M050:Event_070()
    end
    if col_name == "evt_4001" and Flg.Check("FLAG_SUB_200_147_001") then
      local player_model_name = Common.GetPlayerModelName()
      print(player_model_name)
      if player_model_name == "pc001na010101" or player_model_name == "pc002na010101" then
        require("S200_147")
        S200_147:Event_030()
      end
    end
    if col_name == "evt_7000" then
      M070:Event_030()
    end
    if col_name == "evt_6000" then
      require("S200_147")
      S200_147:Event_032()
    end
    if col_name == "evt_8000" and not Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
      require("S010_003")
      S010_003:Event_020()
    end
  elseif gMapNum == 303 then
    if col_name == "evt_1000" then
    end
    if col_name == "evt_2000" then
      M070:Event_090()
    end
    if col_name == "evt_1001" then
      if Flg.Check("FLAG_MAIN_03_181") and not Flg.Check("FLAG_MAIN_03_191") then
        local tlk = Tlk:new("t03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0303_0090_0010")
        Field.MovePlayerToRelativePosFrame(1, 0, 25)
        WaitFrame(25)
        tlk:EndTalk()
      elseif Qst.Sub:Check(3, 20, 25) then
        require("S010_003")
        S010_003:Event_035()
      end
    end
  elseif gMapNum == 304 then
    if col_name == "evt_0003" then
      M340:Event_055()
    end
    if col_name == "evt_0004" then
      M340:Event_060()
    end
    if col_name == "evt_0005" then
      M340:Event_056()
    end
    if col_name == "evt_0006" then
      M340:Event_057()
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 301 then
    if gim_name == "change_0001" then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(gGimText, 1)
      Message("g_t0301_0010_0010")
      MessageClose()
      MessageTalkSel(2, "g_sel_0040_0010")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Field_Talk_End_Not_LetterBox()
        MapChange("d", 1102, "start_03", true, 0, 15)
      elseif result == RESULT_TALK01 then
      end
      Field_Talk_End_Not_LetterBox()
    end
    if gim_name == "map_0001" then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    elseif gim_name == "gim_0002" then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    end
    if gim_name == "gim_0001" then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapAutoTransition(RW)
    end
  elseif gMapNum == 302 then
    if gim_name == "gim_0001" and not Flg.Check("FLAG_MAIN_03_181") then
      PlayerLookAtLccatorObject(gim_name)
      M080:Evetn_035()
    end
    if (gim_name == "map_0001" or gim_name == "map_0002" or gim_name == "map_0003") and Qst.Sub:Check(147, 15, 20) then
      require("S200_147")
      S200_147:Event_033()
    elseif not Flg.Check("FLAG_MAIN_03_180") then
      if gim_name == "map_0001" then
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapDirection()
      elseif gim_name == "map_0002" then
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapDirection()
      elseif gim_name == "map_0003" then
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapDirection()
      end
    elseif Flg.Check("FLAG_MAIN_03_180") and Flg.Check("FLAG_MAIN_03_191") then
      if gim_name == "map_0001" then
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapDirection()
      elseif gim_name == "map_0002" then
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapDirection()
      elseif gim_name == "map_0003" then
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapDirection()
      end
    elseif gim_name == "map_0001" or gim_name == "map_0002" or gim_name == "map_0003" then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t03", 1, true)
      tlk:StartTalk()
      tlk:Message("f_t0303_0090_0010")
      tlk:EndTalk()
    end
    if gim_name == "theater_0001" then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 303 then
    if gim_name == "gim_0001" then
      PlayerLookAtLccatorObject(gim_name)
      if not Flg.Check("FLAG_MAIN_02_040") then
        Field_Talk_Start_Not_LetterBox(gGimText, 1)
        Message("g_t0303_0010_0010")
        Field_Talk_End_Not_LetterBox()
      else
        Field_Talk_Start(gGimText, 1)
        Message("g_t0303_0020_0010")
        Field_Talk_End()
        Obj:new(FLD_OBJ_LOCATOR, "fa_0001"):SetEnableCheckAndFieldAttack(true)
      end
    end
    if gim_name == "map_0001" then
      PlayerLookAtLccatorObject(gim_name)
      if Qst.Sub:Check(3, 20, 25) then
        require("S010_003")
        S010_003:Event_037()
      elseif Flg.Check("FLAG_MAIN_03_180") and not Flg.Check("FLAG_MAIN_03_191") then
        local tlk = Tlk:new("t03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0303_0090_0010")
        tlk:EndTalk()
      else
        OpenWorldMapDirection()
      end
    end
    if gim_name == "map_0002" then
      PlayerLookAtLccatorObject(gim_name)
      if Qst.Sub:Check(3, 20, 25) then
        require("S010_003")
        S010_003:Event_037()
      elseif Flg.Check("FLAG_MAIN_02_040") and not Flg.Check("FLAG_MAIN_02_048") then
        local tlk = Tlk:new("t03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0303_0030_0010")
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_03_160") and not Flg.Check("FLAG_MAIN_03_180") then
        local tlk = Tlk:new("t03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0303_0100_0010")
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_03_180", "FLAG_MAIN_03_190") then
        local tlk = Tlk:new("t03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0303_0090_0010")
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_03_190") and not Flg.Check("FLAG_MAIN_03_210") then
        Prcs_t0303_EnterCulvert()
      elseif Flg.Check("FLAG_MAIN_03_210") then
        Prcs_t0303_EnterCulvert()
      else
        local tlk = Tlk:new("t03", 1, true)
        tlk:StartTalk()
        tlk:Message("f_t0303_0040_0010")
        tlk:EndTalk()
      end
    end
    if gim_name == "obj_1000" then
      PlayerLookAtLccatorObject(gim_name)
      M080:Event_050()
    end
    if gim_name == "obj_1001" then
      PlayerLookAtLccatorObject(gim_name)
      M080:Event_060()
    end
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
  if gMapNum == 303 then
    if gim_name == "fa_0001" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK0303.obj1.text) then
      BreakFieldAttackObj(BRK0303.obj1.loc, BRK0303.obj1.col, 30, BRK0303.obj1.se, "ef_f_com_300_sm")
      Flg.Set(BRK0303.obj1.flag)
      Motion.Gimmick:Play("obj_0003", "e001", false, true)
      SetEnableGimmickCheck("map_0002", true)
      SetEnableGimmickCheck("gim_0001", false)
      Flg.Set("FLAG_MAIN_02_045")
      M040:Event_040()
    end
    if gim_name == "fa_0002" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, BRK0303.obj2.text) then
      BreakFieldAttackObj_NoQuake(BRK0303.obj2.loc, BRK0303.obj2.col, 30, BRK0303.obj2.se, "ef_f_com_300_sm")
      Flg.Set(BRK0303.obj2.flag)
      M080:Event_040()
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 301 and gim_name == "s090_072_001" then
    require("S090_072")
    S090_072:Event_050()
  end
  if gMapNum == 302 then
    if gim_name == "s200_149_item_01" then
      require("S200_149")
      S200_149:Event_080()
    end
    if gim_name == "s200_147_start" then
      if Qst.Sub:Check(3, 10, 25) then
        require("S010_003")
        S010_003:Event_092()
      elseif Qst.Sub:Check(147, 15, 255) then
        require("S200_147")
        S200_147:Event_092()
      else
        require("S200_147")
        S200_147:Event_001()
      end
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
  if gMapNum == 301 and gim_tag == "fa_obj" then
    BreakFieldAttackGim(gim_name, true)
  end
  if gim_tag == "fa_sub201" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
    require("Sow_201")
    if gMapNum == 301 then
      SeekEtemon_T0301(gim_name)
    elseif gMapNum == 302 then
      SeekEtemon_T0302(gim_name)
    end
  end
end
