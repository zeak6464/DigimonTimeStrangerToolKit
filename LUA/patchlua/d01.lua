function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
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
    if gMapNum == 101 then
      if start_loc == "start_01" then
        ColOff("evt_9000")
      end
    elseif gMapNum == 102 then
      if start_loc == "start_00" then
        Field.LinkColOff("col_d0101_start_01_0")
      end
    elseif gMapNum == 106 and start_loc == "start_00" then
      Field.LinkColOff("col_d0101_start_01_0")
    end
  else
    StartEventBeforeFadeIn()
    if gMapNum == 102 and start_loc == "start_00" then
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
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
  if gMapNum == 101 then
    if start_loc == "start_00" then
      local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
      SetFollowerCameraOperateRotation(0, rot - 10, 0)
      if Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") then
        PlayStopBlimpSound()
        AddChallengerNotice(false)
      end
    elseif start_loc == "start_01" then
      ColOff("evt_9000")
    end
  end
  if gMapNum == 102 and start_loc == "start_00" then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field.LinkColOff("col_d0101_start_01_0")
  end
  if gMapNum == 104 then
    if start_loc == "start_01" then
      Flg.Set("FLAG_GIMMICK_D01_290")
    else
      Flg.Clear("FLAG_GIMMICK_D01_290")
      FieldObjectSync(ENEMY, false)
    end
  end
  if gMapNum == 106 and start_loc == "start_00" then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field.LinkColOff("col_d0101_start_01_0")
  end
  if gMapNum == 107 and start_loc == "start_70" then
    Obj:new(FLD_OBJ_GIMMICK, "elv_icon_03"):CancelInvisible()
    Obj:new(FLD_OBJ_GIMMICK, "elv_icon_02"):CancelInvisible()
  end
  if gMapNum == 108 then
    if start_loc == "start_01" then
      Flg.Set("FLAG_GIMMICK_D01_300")
    else
      Flg.Clear("FLAG_GIMMICK_D01_300")
      FieldObjectSync(ENEMY, false)
    end
  end
  if start_loc == "start_50" then
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 101 then
    M410:Event_010()
  end
  if gMapNum == 102 and Flg.Check("FLAG_FIELD_D01_IS_WARP") and GetLastPlayerSetLocator() == "start_30" then
    WarpNpcArrival()
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Clear("FLAG_FIELD_D01_IS_WARP")
  end
  if gMapNum == 105 then
    M400:Event_240()
  end
  if gMapNum == 106 and Flg.Check("FLAG_FIELD_D01_IS_WARP") and GetLastPlayerSetLocator() == "start_30" then
    WarpNpcArrival()
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Clear("FLAG_FIELD_D01_IS_WARP")
  end
  if gMapNum == 107 and Flg.Check("FLAG_FIELD_D01_IS_WARP") and GetLastPlayerSetLocator() == "start_30" then
    WarpNpcArrival()
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Clear("FLAG_FIELD_D01_IS_WARP")
  end
  if gMapNum == 108 then
    M400:Event_320()
  end
  if gMapNum == 109 then
    M400:Event_340()
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 101 then
  elseif gMapNum == 102 then
    if start_loc == "start_00" then
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
  elseif gMapNum == 103 then
    M400:Event_250()
  elseif gMapNum == 104 then
    M400:Event_220()
  elseif gMapNum == 106 then
  elseif gMapNum == 108 then
  end
end

function UpdateMinimap(start_loc)
  if start_loc == "start_00" then
  end
  if gMapNum ~= 103 or start_loc == "start_01" then
  end
  if gMapNum == 107 and Field.IsJustAfterMapChangeNow() == true then
    if start_loc == "start_00" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_01" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  end
end
