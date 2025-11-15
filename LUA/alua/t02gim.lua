gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 201 then
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
  elseif load_map_num == 203 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 201 then
    Prcs_t0201_SettingSignal()
    if not Flg.Check("FLAG_MAIN_03_120") then
      ColOff("plan_cl_0013")
    end
  end
  if gMapNum == 203 then
    if Flg.Check("FLAG_MAIN_17_036") and not Flg.Check("FLAG_MAIN_17_046") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), false)
      Obj:new(FLD_OBJ_LOCATOR, "obj_0003"):Invisible()
    end
    if Flg.Check("FLAG_IS_PLACE_ENEMY_GROUP1") then
      Flg.Clear("FLAG_IS_PLACE_ENEMY_GROUP1")
    end
    if Qst.Sub:Check(2, 10, 255) then
      Field.ColOn("wall_cl_0001")
      Field.ColOn("wall_cl_0002")
      Field.ColOn("wall_cl_0003")
      Field.ColOn("wall_cl_0004")
      Field.ColOn("wall_cl_0005")
      Field.ObjectDisableCulling(NPC, GetIndex(NPC, "npc_0501"))
      Field.ObjectSuspendAutoTransparentForCamera(NPC, GetIndex(NPC, "npc_0501"))
    else
      Field.ColOff("wall_cl_0001")
      Field.ColOff("wall_cl_0002")
      Field.ColOff("wall_cl_0003")
      Field.ColOff("wall_cl_0004")
      Field.ColOff("wall_cl_0005")
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 203 then
    if col_name == "evt_2000" and Flg.Check("FLAG_SUB_110_104_006", "FLAG_IS_CLEAR_S110_104") then
      require("S110_104")
      S110_104:Event_015()
      MovePlayerToRelativePosFrame(0, 2, 20)
      WaitFrame(20)
    end
    if col_name == "evt_2001" and Flg.Check("FLAG_SUB_110_104_006", "FLAG_IS_CLEAR_S110_104") then
      require("S110_104")
      S110_104:Event_015()
      MovePlayerToRelativePosFrame(0, -2, 20)
      WaitFrame(20)
    end
    if col_name == "evt_5000" or col_name == "evt_5001" then
      M390:Event_610()
    end
    if col_name == "evt_4000" and not Flg.Check("FLAG_MAIN_03_401", "FLAG_OPEN_TIMEJUMP") then
      require("S110_090")
      S110_090:Event_010()
    end
    if col_name == "evt_6000" then
      require("S010_180")
      S010_180:Event_020()
    end
    if col_name == "evt_7000" and Common.CheckTimeAxis("A2028_daft_419", "A2028_daft_10000") then
      require("S900_217")
      S900_217:Event_010()
    end
  end
end

function Prcs_d0109_akiba_uradoriCam()
  Cam.Inst:Set(42.354843, 0.778368, -97.013237, 38.55574, 2.716314, -87.968277, default, 60)
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 201 then
    if gim_id == 301 then
      Cam.Inst:Set(13.63, 1.41, -51.24, 6.42, 2.84, -44.46, default, 60)
      ShopOpenTypeEnter("enter_otakushop", "exit_otakushop", 10)
      Cam.Inst:Clear(30)
      WaitFrame(30)
    elseif gim_id == 302 then
      Cam.Inst:Set(39.41, 0.59, -101, 31.8, 4.53, -96.72, default, 60)
      ShopOpenTypeEnter("enter_drugshop", "exit_drugshop", 5)
      Cam.Inst:Clear(30)
      WaitFrame(30)
    end
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    end
    if gim_id == 700 or gim_id == 701 then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapAutoTransition(RW)
    end
    if gim_id == 800 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      tlk:Message("f_t0201_0040_0010")
      tlk:Message("f_t0201_0040_0020")
      tlk:EndTalk()
    end
    if gim_id == 801 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      tlk:Message("f_t0201_0050_0010")
      tlk:EndTalk()
    end
    if gim_id == 802 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      tlk:Message("f_t0201_0070_0010")
      tlk:Message("f_t0201_0070_0020")
      tlk:EndTalk()
    end
    if gim_id == 803 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      if Common.CheckTimeAxis("A2020_dbef_10", "A2020_dbef_10000") then
        local check = GetControlScriptExternalVariableString("sweets_store")
        if check == "non_check" then
          tlk:StartTalk()
          tlk:Message("f_t0201_0060_0010")
          if Common.IsExistGuest(10012) then
            tlk:Message("f_t0201_0060_0040")
          else
            tlk:Message("f_t0201_0060_0020")
          end
          tlk:EndTalk()
          SetControlScriptExternalVariable("sweets_store", "check")
        else
          tlk:StartTalk()
          tlk:Message("f_t0201_0060_0010")
          if Common.IsExistGuest(10012) then
            tlk:Message("f_t0201_0060_0040")
          else
            local no_eat = 70
            local eat = 30
            math.randomseed(os.time())
            local rand = math.random(no_eat + eat)
            if 0 < rand and no_eat >= rand then
              tlk:Message("f_t0201_0060_0020")
            end
            if no_eat < rand and rand <= no_eat + eat then
              tlk:Message("f_t0201_0060_0030")
            end
          end
          tlk:EndTalk()
        end
      else
        tlk:StartTalk()
        tlk:Message("f_t0201_0060_0050")
        tlk:EndTalk()
      end
    end
    if gim_id == 804 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      local e007 = Motion.Object:new(PLAYER, 1, "e007")
      tlk:StartTalk()
      if Common.CheckTimeAxis("A2020_dbef_10", "A2020_dbef_10000") then
        e007:Play(10, false)
        tlk:Message("f_t0201_0080_0010")
        Field.ObjectResetMotion(PLAYER, 1, 30)
        if Common.IsExistGuest(27472) then
          tlk:Message("f_t0201_0080_0020")
        end
      else
        tlk:Message("f_t0201_0080_0030")
      end
      tlk:EndTalk()
    end
    if gim_id == 805 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      tlk:Message("f_t0201_0090_0010")
      tlk:EndTalk()
    end
    if gim_id == 806 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      tlk:Message("f_t0201_0100_0010")
      tlk:EndTalk()
    end
    if gim_id == 807 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      tlk:Message("f_t0201_0110_0010")
      tlk:EndTalk()
    end
    if gim_id == 808 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      tlk:Message("f_t0201_0120_0010")
      tlk:Message("f_t0201_0120_0020")
      tlk:EndTalk()
    end
    if gim_id == 809 then
      PlayerLookAtLccatorObject(gim_name)
      local tlk = Tlk:new("t02")
      tlk:StartTalk()
      if Common.IsExistGuest(10012) and Common.IsExistGuest(27472) then
        tlk:Message("f_t0201_0130_0020")
        tlk:Message("f_t0201_0130_0030")
      else
        tlk:Message("f_t0201_0130_0010")
      end
      tlk:EndTalk()
    end
  elseif gMapNum == 203 then
    if gim_id == 400 then
      Cam.Inst:Set(-31.9, 0.3, 27, -39.8, 4.6, 31.4, default, 40)
      Prcs_t0203_EnterCvs()
    end
    if gim_id == 401 then
      Cam.Inst:Set(-47.36, 1.43, -24.74, -41.87, 1.387, -18.96, default, 40)
      ShopOpenTypeEnter("enter_junkshop", "exit_junkshop", 9)
      Cam.Inst:Clear(60)
    end
    if gim_id == 402 then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    end
    if gim_id == 403 then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapAutoTransition(RW)
    end
    if gim_id == 600 then
      PlayerLookAtLccatorObject(gim_name)
      require("S010_002")
      S010_002:Event_030()
    end
    if gim_id == 601 then
      PlayerLookAtLccatorObject(gim_name)
      require("S010_002")
      S010_002:Event_040()
    end
    if gim_id == 800 then
      require("S110_090")
      S110_090:Event_005()
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 203 then
    if gim_name == "s110_105_002" then
    end
    if gim_name == "s110_113_001" then
      local tlk = Tlk:new("s110_113", 1, true)
      tlk:StartTalk()
      tlk:Message("s110_113_200")
      tlk:EndTalk()
      Guest.Add(GST_S010_156_GANKOO)
      Guest.Add(GST_S010_156_JES)
      Flg.Set("FLAG_SUB_110_113_002")
      MapChange("h", 201, "start_00", true, FADE_BLACK, FADE_TIME)
    end
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
    if gim_name == "s200_146_001" then
      MapChange("h", 201, "start_00", true, FADE_BLACK, FADE_TIME)
    end
    if gim_name == "s900_216_hazama" then
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
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
  if gMapNum == 101 then
  end
  if gim_tag == "fa_sub201" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
    require("Sow_201")
    if gMapNum == 201 then
      SeekEtemon_T0201(gim_name)
    elseif gMapNum == 203 then
      SeekEtemon_T0203(gim_name)
    end
  end
end
