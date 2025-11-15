function FieldLoadRequest()
  print("##### FieldLoadRequest #####")
  
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  Field.LoadCameraAnimation("Cam_r03_in01")
  Field.LoadCameraAnimation("Cam_r03_out01")
  Field.ObjectLoadAttachment(FLD_OBJ_PLAYER, 1, 1)
  Field.ObjectLoadAttachment(FLD_OBJ_PLAYER, 1, 2)
  Field.ObjectLoadAttachmentMotion(FLD_OBJ_PLAYER, 1, 1, "r348_in01")
  Field.ObjectLoadAttachmentMotion(FLD_OBJ_PLAYER, 1, 2, "r348_out01")
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  MapNameDisp()
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
end

function OnEndLoad(args)
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  local start_loc = GetLastPlayerSetLocator()
  SaveSequenceAfterChapterChange()
  PlayDungeonBGM()
  local is_map_changed_now = args.map_changed_now
  if is_map_changed_now then
    UpdateMinimap(start_loc)
  end
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    MovePlayerToStartPosition(start_loc)
  else
    StartEventBeforeFadeIn()
    if Field.IsJustAfterMapChangeNow() == true then
      ProcessIfNeedByStartLocator(start_loc)
    end
    FadeInWithWait(0, 0)
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if start_loc == "start_50" then
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if gMapNum == 401 then
    if start_loc == "start_00" then
      if not Flg.Check("FLAG_ISAREA_CHANGE_FOR_LOCOMON") or Flg.Check("FLAG_MAIN_06_010", "FLAG_MAIN_06_020") then
      else
        PlayStopLocomonSound()
      end
    elseif start_loc == "start_02" then
      ColOff("wall_cl_0002")
    end
  elseif gMapNum == 402 then
    if start_loc == "start_00" then
      SetFollowerCameraOperateRotation(20, 160)
    elseif start_loc == "start_01" then
      ColOff("plan_cl_0001")
    elseif start_loc == "start_50" then
      SetFollowerCameraOperateRotation(default, 160)
    elseif not (start_loc == "start_05" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP")) or Flg.Check("FLAG_MAIN_10_015", "FLAG_MAIN_10_020") then
    elseif Flg.Check("FLAG_MAIN_10_002", "FLAG_MAIN_10_006") then
    else
      PlayStopBlimpSound()
      AddChallengerNotice(false)
    end
  elseif gMapNum == 403 then
    if start_loc == "start_00" then
      SetFollowerCameraOperateRotation(-10, 0)
    end
  elseif gMapNum == 404 then
    M180:Event_140()
  elseif gMapNum == 405 and start_loc == "start_00" then
    SetFollowerCameraOperateRotation(25, -10)
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 401 then
    if Flg.Check("FLAG_GIMMICK_D04_100") then
      if GetLastPlayerSetLocator() == "start_04" then
        Prcs_d04_JumpRideAndMapChangeIn("ride_whiplanding_0016", 5, "same")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Flg.Clear("FLAG_GIMMICK_D04_100")
      end
    elseif Flg.Check("FLAG_MAIN_10_059") then
      Obj:new(PLAYER, ""):Invisible(0)
    end
    if Flg.Check("FLAG_FIELD_D04_IS_WARP") and GetLastPlayerSetLocator() == "start_30" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D04_IS_WARP")
    end
    M180:Event_030()
    M180:Event_070()
  end
  if gMapNum == 402 then
    if Flg.Check("FLAG_GIMMICK_D04_100") then
      if GetLastPlayerSetLocator() == "start_06" then
        Prcs_d04_JumpRideAndMapChangeIn("start_06", 5, "same")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Flg.Clear("FLAG_GIMMICK_D04_100")
      end
    elseif Flg.Check("FLAG_MAIN_10_059") then
      Obj:new(PLAYER, ""):Invisible(0)
      Obj:new(PLAYER, ""):SetRotationY(120, 0)
      SetFollowerCameraOperateRotation(0, 120, 0)
    end
    if Flg.Check("FLAG_FIELD_D04_IS_WARP") and (GetLastPlayerSetLocator() == "start_07" or GetLastPlayerSetLocator() == "start_30") then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D04_IS_WARP")
    end
    M290:Event_030()
    M290:Event_037()
    M300:Event_001()
    M300:Event_005()
  end
  if gMapNum == 403 then
    M180:Event_095()
    M180:Event_130()
    require("S040_032")
    S040_032:Event_020()
    S040_032:Event_030()
    S040_032:Event_050()
    require("S110_109")
    S110_109:Event_030()
    if Qst.Sub:Check(109, 1, 5) then
      Obj:new(ENEMY, "s040_033_invisible_01"):Invisible(0)
      Obj:new(ENEMY, "s040_033_invisible_02"):Invisible(0)
    end
  end
  if gMapNum == 404 then
    if Flg.Check("FLAG_FIELD_D04_IS_WARP") and GetLastPlayerSetLocator() == "start_30" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D04_IS_WARP")
    end
    M180:Event_210()
    M290:Event_040()
    M300:Event_010()
    M300:Event_150()
    M300:Event_190()
    M310:Event_010()
    require("S030_029")
    S030_029:Event_040()
  end
  if gMapNum == 405 then
    M290:Event_038A()
    require("S030_030")
    S030_030:Event_030()
  end
  if gMapNum == 406 then
    if Flg.Check("FLAG_FIELD_D04_IS_WARP") and GetLastPlayerSetLocator() == "start_01" then
      WarpNpcArrival()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D04_IS_WARP")
    end
    M180:Event_180()
    M180:Event_190()
    M290:Event_060()
    M300:Event_160()
    M300:Event_170()
    M420:Event_101()
    M420:Event_110()
    M440:Event_890()
    require("S030_029")
    S030_029:Event_030()
    require("S030_031")
    S030_031:Event_050()
    require("S030_183")
    S030_183:Event_050()
    S030_183:Event_040()
    require("S110_100")
    S110_100:Event_030()
  end
  if gMapNum == 407 then
    M180:Event_175()
    M180:Event_178()
    M290:Event_051()
    M290:Event_055()
    require("S030_183")
    S030_183:Event_030()
    S030_183:Event_020()
    if Qst.Sub:Check(183, 5, 255) then
      local obj = Obj:new(NPC, "npc_0001")
      Field.ObjectOverwriteFieldAttackableRange(NPC, obj.index, 30, 5, 5)
      Obj:new(NPC, "npc_0001"):SetEnableCheckAndFieldAttack(true)
      Obj:new(OGIM, "obj_barricade1"):CancelInvisible()
      Obj:new(OGIM, "obj_barricade2"):CancelInvisible()
    end
    if not Flg.Check("FLAG_MAIN_06_046") then
      Field.HideMinimap(true)
    end
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 401 and Flg.Check("FLAG_MAIN_10_059") then
    player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
    PlayEffectScript("ef_f_mov_111_wa", player_pos.x, player_pos.y + 1, player_pos.z, 0, 1)
    PlaySE(200006, 100)
    WaitFrame(5)
    Obj:new(PLAYER, ""):CancelInvisible(10)
    WaitFrame(30)
    Flg.Clear("FLAG_MAIN_10_059")
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
  end
  if gMapNum == 402 then
    require("S040_033")
    S040_033:Event_030()
    if Flg.Check("FLAG_MAIN_10_059") then
      player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
      PlayEffectScript("ef_f_mov_111_wa", player_pos.x, player_pos.y + 1, player_pos.z, 0, 1)
      PlaySE(200006, 100)
      WaitFrame(5)
      Obj:new(PLAYER, ""):CancelInvisible(10)
      WaitFrame(30)
      Flg.Clear("FLAG_MAIN_10_059")
      Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
      Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
    end
  end
  if gMapNum == 403 then
    require("S040_033")
    S040_033:Event_070()
  end
  if gMapNum == 404 then
  end
  if gMapNum == 405 then
    require("S040_033")
    S040_033:Event_050()
  end
end

function UpdateMinimap(start_loc)
  if gMapNum == 401 then
    if start_loc == "start_01" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if start_loc == "start_02" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_03" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_04" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
  end
  if gMapNum == 405 and Field.IsJustAfterMapChangeNow() == true then
    if start_loc == "start_00" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_01" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  end
end

function OnFieldAttackNpc(args)
  local npc_name = args.unique_name
  print("##### StartEventBeforeFadeIn #####")
  print("npc_name: ", npc_name)
  if gMapNum == 403 and npc_name == "s110_109_002" then
    require("S110_109")
    S110_109:Event_020()
  end
  if gMapNum == 407 and npc_name == "npc_0001" then
    require("S030_183")
    S030_183:Event_025()
  end
end
