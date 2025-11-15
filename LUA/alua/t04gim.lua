GimText = "field_text"
g_t04roomspeed = 2.5
g_t04stepspeed = 1.2

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    local index = Field.GetPlayerIndex()
    Motion.Object:Load(FLD_OBJ_PLAYER, index, PC_GENERAL_MOTION[i])
  end
  if load_map_num == 401 then
  elseif load_map_num == 402 then
  elseif load_map_num == 403 then
    Field.LoadMovie("tv_news_m090_020", 4096, 2048)
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
  if gMapNum == 401 then
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "map_0001"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0005"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0006"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0007"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0008"):SetEnableCheckAndFieldAttack(false)
      Obj:new(FLD_OBJ_LOCATOR, "shop_0001"):SetEnableCheckAndFieldAttack(false)
      Field.LinkColOff("mapborder_1")
      Field.LinkColOff("mapborder_2")
      Field.ObjectInvisible(NPC, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(MOB, FOR_ALL, 1, 0, false)
      Field.ObjectInvisible(RUMOR_NPC, FOR_ALL, 1, 0, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon01"), 1, 0, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon02"), 1, 0, false)
      Field.ObjectCancelInvisible(NPC, GetIndex(NPC, "m440_nanimon03"), 1, 0, false)
      Field_InvisibleFollowerAllPartyMember(1, 0, false)
      Field.ObjectInvisible(OGIM, GetIndex(OGIM, "fa_obstacles_01"), 1, 0, true, false)
      Field.ObjectInvisible(OGIM, GetIndex(OGIM, "hazama_gate01"), 1, 0, true, false)
      if Flg.Check("FLAG_MAIN_22_517") then
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_01"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_02"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_03"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_04"), true, FOREVER)
      end
    else
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "map_0001"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0005"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0006"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0007"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0008"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "shop_0001"):SetEnableCheckAndFieldAttack(true)
      Field.ObjectCancelInvisible(NPC, FOR_ALL, 1, 0, true, false)
      Field.ObjectCancelInvisible(MOB, FOR_ALL, 1, 0, true, false)
      Field.ObjectCancelInvisible(RUMOR_NPC, FOR_ALL, 1, 0, true, false)
    end
  elseif gMapNum == 402 then
    Field.PlayerChangeMoveAnimation("walk")
    Field.PlayerFixedMaxSpeed(g_t04roomspeed)
  elseif gMapNum == 403 then
    if Flg.Check("FLAG_MAIN_03_230", "FLAG_MAIN_03_280") then
      Field.MapModelChangeMovie("asset_signboard_012", "tv_news_m090_020")
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Field.PlayerChangeMoveAnimation("walk")
      if Flg.Check("FLAG_T0403_MOVESPEEDUP") then
        Field.PlayerFixedMaxSpeed(g_t04stepspeed)
      else
        Field.PlayerFixedMaxSpeed(g_t04roomspeed)
      end
    else
      Field.PlayerChangeMoveAnimation("walk")
      if Flg.Check("FLAG_T0403_MOVESPEEDUP") then
        Field.PlayerFixedMaxSpeed(g_t04stepspeed)
      else
        Field.PlayerFixedMaxSpeed(g_t04roomspeed)
      end
    end
    if Flg.Check("FLAG_T0403_ACCESS_ON") then
      Prcs_t0403_LivingAccessOn()
    else
      Prcs_t0403_LivingAccessOff()
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_550") then
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0005"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0006"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0007"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0008"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0009"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0010"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0011"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0012"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):Invisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):Invisible()
      Field_InvisibleFollowerAllPartyMember(1, 0, false)
      if Flg.Check("FLAG_MAIN_22_517") then
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_01"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_02"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_03"), true, FOREVER)
        Field.SymbolForceLeave(GetIndex(ENEMY, "berufe_04"), true, FOREVER)
      end
    end
    if Flg.Check("FLAG_MAIN_22_550") then
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0004"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0005"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0006"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0007"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0008"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0009"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0010"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0011"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0012"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0001"):CancelInvisible()
      Obj:new(FLD_OBJ_LOCATOR, "change_0002"):CancelInvisible()
    end
    if not Flg.Check("FLAG_MAIN_03_010") then
      local door = Obj:new(FLD_OBJ_LOCATOR, "change_0001")
      SetEnableGimmickCheck("change_0001", false)
      door:Invisible()
      MinimapMarkerOff("change_0001", 2)
    else
      SetEnableGimmickCheck("change_0001", true)
    end
  elseif gMapNum == 404 then
    Field.PlayerChangeMoveAnimation("walk")
    Field.PlayerFixedMaxSpeed(2)
    if not Flg.Check("AREA_OPEN_DEBUG") then
      Field_InvisibleGimmick("gim_0003", 0, 0, false)
      Field_InvisibleGimmick("gim_0004", 0, 0, false)
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 401 then
    if col_name == "evt_1000" then
      Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
      if not Flg.Check("FLAG_MAIN_03_260") then
        M090:Event_030()
      end
      if Flg.Check("FLAG_MAIN_03_010", "FLAG_MAIN_03_021") then
        Digitter.Send(1050030010)
      end
    end
    if col_name == "evt_2000" then
    end
    if col_name == "evt_3001" and Flg.Check("FLAG_MAIN_03_010", "FLAG_MAIN_03_020") then
      local tlk = Tlk:new("t04")
      tlk:StartTalk()
      tlk:Message("f_t0401_0040_0010")
      tlk:MessageClose()
      local vec = Field.GetUnitVector2D(150)
      local move_x = vec.x * 2
      local move_z = vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_x, move_z, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if (col_name == "evt_3002" or col_name == "evt_3003") and Flg.Check("FLAG_MAIN_03_010", "FLAG_MAIN_03_020") then
      local tlk = Tlk:new("t04")
      tlk:StartTalk()
      tlk:Message("f_t0401_0040_0010")
      tlk:MessageClose()
      local vec = Field.GetUnitVector2D(210)
      local move_x = vec.x * 2
      local move_z = vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_x, move_z, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_3004" then
      if not Flg.Check("FLAG_MAIN_03_025") then
        local tlk = Tlk:new("t04")
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        local vec = Field.GetUnitVector2D(90)
        local move_x = vec.x * 2
        local move_z = vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_x, move_z, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
      if Flg.Check("FLAG_MAIN_03_210", "FLAG_MAIN_03_220") then
        local tlk = Tlk:new("t04")
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        local vec = Field.GetUnitVector2D(90)
        local move_x = vec.x * 2
        local move_z = vec.z * 2
        Field.MovePlayerToRelativePosFrame(move_x, move_z, 20)
        WaitFrame(20)
        tlk:EndTalk()
      end
    end
    if col_name == "evt_3005" and Flg.Check("FLAG_MAIN_03_010", "FLAG_MAIN_03_020") then
      local tlk = Tlk:new("t04")
      tlk:StartTalk()
      tlk:Message("f_t0401_0040_0010")
      tlk:MessageClose()
      local vec = Field.GetUnitVector2D(0)
      local move_x = vec.x * 2
      local move_z = vec.z * 2
      Field.MovePlayerToRelativePosFrame(move_x, move_z, 20)
      WaitFrame(20)
      tlk:EndTalk()
    end
    if col_name == "evt_1001" then
      M080:Event_015()
    end
    if col_name == "evt_9000" then
      Prcs_t0401_StairsZoom(true, 15)
      Prcs_t0401_TownAccessOff()
    elseif col_name == "evt_9001" then
      Field_InvisibleFollowerAllGuest(0, 10, false)
      Prcs_t0401_StairsZoom(false)
      Prcs_t0401_TownAccessOn()
    end
    if col_name == "evt_5000" then
    end
    if col_name == "evt_5001" then
    end
    if col_name == "evt_5002" then
    end
    if col_name == "evt_5003" then
    end
    if col_name == "evt_5004" then
    end
    if col_name == "evt_5005" then
    end
  elseif gMapNum == 402 then
  end
  if gMapNum == 403 then
    if col_name == "evt_0001" then
      M050:Event_020()
      M060:Event_020()
      M070:Event_020()
      M080:Event_020()
      M090:Event_020()
      if not Flg.Check("FLAG_MAIN_03_010") then
        SetEnableGimmickCheck("change_0001", false)
      else
        SetEnableGimmickCheck("change_0001", true)
      end
      Prcs_t0403_LivingAccessOn()
    end
    if col_name == "evt_0003" then
      M100:Event_020()
    end
    if col_name == "evt_1000" then
      Prcs_t0403_LivingAccessOff()
    elseif col_name == "evt_1001" then
    end
    if col_name == "evt_1003" then
      M090:Event_080()
    end
    if col_name == "evt_2000" or col_name == "evt_2002" then
      Field.PlayerFixedMaxSpeed(g_t04stepspeed)
      Flg.Set("FLAG_T0403_MOVESPEEDUP")
    elseif col_name == "evt_2001" or col_name == "evt_2003" then
      Field.PlayerFixedMaxSpeed(g_t04roomspeed)
      Flg.Clear("FLAG_T0403_MOVESPEEDUP")
    end
  end
  if gMapNum == 404 and col_name == "evt_0001" then
    M060:Event_015()
  end
  if gMapNum == 409 and col_name == "evt_1000" then
    if Flg.Check("FLAG_MAIN_03_090", "FLAG_MAIN_03_120") then
      Field_Talk_Start("field_text", 1)
      Message(95)
      MovePlayerToRelativePosFrame(2, 0, 30)
      Field_Talk_End()
    end
    if Flg.Check("FLAG_MAIN_03_320", "FLAG_MAIN_03_450") then
      Field_Talk_Start("field_text", 1)
      Message(95)
      MovePlayerToRelativePosFrame(2, 0, 30)
      Field_Talk_End()
    end
  end
end

function Prcs_d0109_shop_0002Cam()
  Cam.Inst:Set(-8.735079, 0.329995, 0.269069, 0.704083, 1.536277, -2.804544, default, 20)
end

function OnCheckLocatorObject(gim)
  local gim_name = gim.unique_name
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 401 then
    local def_text = "t04"
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0401_0060_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 2 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0401_0070_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 3 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0401_0080_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 4 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0401_0090_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 5 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0401_0100_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      GoToTheaterWithEvt()
    elseif gim_id == 401 then
      if Flg.Check("FLAG_MAIN_03_190", "FLAG_MAIN_03_200") then
        local tlk = Tlk:new("t04")
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_03_200", "FLAG_MAIN_03_210") then
        local tlk = Tlk:new("t04")
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        tlk:EndTalk()
      elseif Flg.Check("FLAG_MAIN_03_210", "FLAG_MAIN_03_220") then
        local tlk = Tlk:new("t04")
        tlk:StartTalk()
        tlk:Message("f_t0401_0050_0010")
        tlk:EndTalk()
      else
        OpenDoor(gim_loc, "", "gim_7000")
        DoorMapChange("t", 402, "start_00")
      end
    elseif gim_id == 402 then
      if Flg.Check("FLAG_MAIN_03_190", "FLAG_MAIN_03_200") then
        Field_Talk_Start("field_text", 1)
        Message(263)
        Field_Talk_End()
      elseif Flg.Check("FLAG_MAIN_03_200", "FLAG_MAIN_03_210") then
        Field_Talk_Start("field_text", 1)
        Message(265)
        Field_Talk_End()
      else
        OpenDoor(gim_loc, "", true, "gim_7001")
        DoorMapChange("t", 403, "start_00")
      end
    elseif gim_id == 403 then
      OpenDoor_NoFade(gim_loc, "")
      M440:Event_834()
    elseif gim_id == 404 then
      Cam.Inst:Set(6.6, 0.2, 7.6, 0, 4.5, 13.7, default, 40)
      Prcs_t0401_EnterCvs()
    end
    if gim_id == 490 then
      if Flg.Check("FLAG_MAIN_03_210", "FLAG_MAIN_03_220") then
        do
          local tlk = Tlk:new("t04")
          tlk:StartTalk()
          tlk:Message("f_t0401_0050_0010")
          tlk:EndTalk()
        end
      else
        PlayerLookAtLccatorObject(gim_name)
        OpenWorldMapDirection()
      end
    elseif gim_id == 491 then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    elseif gim_id == 492 then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    end
  elseif gMapNum == 402 then
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox("t04", 1)
      Message("f_t0402_0010_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 400 then
      OpenDoor(gim_loc, "", true, "gim_7000")
      DoorMapChange("t", 401, "start_07")
    end
  elseif gMapNum == 403 then
    local def_text = "t04"
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      if GetTimeZone() == TIME_ZONE_MORNING then
        Field_Talk_Start_Not_LetterBox(def_text, 1)
        Message("f_t0403_0010_0010")
        Field_Talk_End_Not_LetterBox()
      elseif GetTimeZone() == TIME_ZONE_NOON then
        Field_Talk_Start_Not_LetterBox(def_text, 1)
        Message("f_t0403_0011_0010")
        Field_Talk_End_Not_LetterBox()
      else
        Field_Talk_Start_Not_LetterBox(def_text, 1)
        Message("f_t0403_0010_0010")
        Field_Talk_End_Not_LetterBox()
      end
    end
    if gim_id == 4 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0020_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 5 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0030_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 6 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0040_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 7 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0050_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 8 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0060_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 9 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0070_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 10 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0080_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 11 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0090_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 12 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start_Not_LetterBox(def_text, 1)
      Message("f_t0403_0100_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if gim_id == 400 then
      if Qst.Main:Check(M040.ID, M040.STEP_007, M040.STEP_100) then
        FieldTalk("field_text", 1, 205)
      elseif Qst.Main:Check(M060.ID, M060.STEP_001, M060.STEP_005) then
        Field_Talk_Start(def_text, 1)
        AnswerTheCall()
        Message("f_t0403_0150_0010")
        EndTheCall()
        Field_Talk_End()
      elseif Qst.Main:Check(M070.ID, M070.STEP_001, M070.STEP_005) then
        Field_Talk_Start(def_text, 1)
        AnswerTheCall()
        Message("f_t0403_0150_0010")
        EndTheCall()
        Field_Talk_End()
      elseif Qst.Main:Check(M080.ID, M080.STEP_001, M080.STEP_005) then
        Field_Talk_Start(def_text, 1)
        AnswerTheCall()
        Message("f_t0403_0150_0010")
        EndTheCall()
        Field_Talk_End()
      elseif Qst.Main:Check(M090.ID, M090.STEP_001, M090.STEP_005) then
        Field_Talk_Start(def_text, 1)
        AnswerTheCall()
        Message("f_t0403_0150_0010")
        EndTheCall()
        Field_Talk_End()
      elseif Qst.Main:Check(M100.ID, M100.STEP_001, M100.STEP_005) then
        Field_Talk_Start(def_text, 1)
        AnswerTheCall()
        Message("f_t0403_0150_0010")
        EndTheCall()
        Field_Talk_End()
      else
        OpenDoor(gim_loc, "", true, "gim_7000")
        DoorMapChange("t", 401, "start_08")
      end
    elseif gim_id == 401 then
      OpenDoor(gim_loc, "", true, "gim_7001")
      DoorMapChange("t", 404, "start_00")
    elseif gim_id == 402 then
      OpenDoor_NoFade(gim_loc, "", true, "change_0003")
      M440:Event_832()
    end
  elseif gMapNum == 404 then
    local def_text = "t0404"
    if gim_id == 1 then
      PlayerLookAtLccatorObject(gim_name)
      Prcs_t0404_Bed()
    end
    if gim_id == 5 and Flg.Check("FLAG_MAIN_03_035", "FLAG_MAIN_03_036") then
      M050:Event_118()
      Obj:new(FLD_OBJ_LOCATOR, "gim_0005"):SetEnableCheckAndFieldAttack(false)
    end
    if gim_id == 400 then
      OpenDoor(gim_loc, "", true, "gim_7000")
      DoorMapChange("t", 403, "start_01")
    end
  elseif gMapNum == 408 then
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      OpenDoor(gim_loc, "")
      DoorMapChange("t", 401, "start_11")
    end
  elseif gMapNum == 409 then
    if gim_id == 400 then
      PlayerLookAtLccatorObject(gim_name)
      OpenWorldMapDirection()
    end
    if gim_id == 401 then
      Field_Talk_Start(gGimText, 1)
      Message(1030)
      MessageTalkSel(2, 1020501000)
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Field_Talk_End()
        MapChange("h", 301, "start_00", true, 1, 30)
      elseif result == RESULT_TALK01 then
        Field_Talk_End()
      end
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 401 and gim_name == "hazama_gate01" then
    print("====== gate_access ======")
    PlayerLookAtGimmickObject(gim_name)
    GoToHazamaWithEvt(gim)
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
end

function OnFieldAttackGimmick(att_gim)
  local gim_name = att_gim.unique_name
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  local gim_tag = att_gim.tag
  print("gimName = ", gim_name, "gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 401 and gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
    Flg.Set("FLAG_GIMMICK_T04_020")
    FieldObjectSync(OGIM, false)
  end
  if gim_tag == "fa_sub201" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    BreakFieldAttackGim(gim_name, true)
    require("Sow_201")
    if gMapNum == 401 then
      SeekEtemon_T0401(gim_name)
    end
  end
end
