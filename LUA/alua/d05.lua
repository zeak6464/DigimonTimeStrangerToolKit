function FieldLoadRequest()
  print("##### FieldLoadRequest #####")
  
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if Flg.Check("FLAG_SUB_050_176_002") then
    Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
  end
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
    if Field.IsJustAfterMapChangeNow() == true then
      ProcessIfNeedByStartLocator(start_loc)
    end
    StartEventBeforeFadeIn()
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
  if gMapNum == 501 then
    if start_loc == "start_00" then
      if Flg.Check("FLAG_ISAREA_CHANGE_FOR_LOCOMON") then
        PlayStopLocomonSound()
      end
    elseif start_loc == "start_09" then
      if Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") then
        PlayStopBlimpSound()
        AddChallengerNotice(false)
      end
    elseif start_loc == "start_10" or start_loc == "start_11" or start_loc == "start_12" then
      M440:Event_838()
    elseif start_loc == "start_13" then
    elseif start_loc == "start_20" then
    elseif start_loc == "start_50" then
    end
    if start_loc == "start_01" then
      Flg.Set("FLAG_FIELD_D501_FACTORY_OUT")
    else
      Flg.Clear("FLAG_FIELD_D501_FACTORY_OUT")
    end
  elseif gMapNum == 502 then
    if start_loc == "start_00" then
      Flg.Set("FLAG_GIMMICK_D05_480")
      Prcs_d0502_DuctAccessIsEntrance(true)
    elseif start_loc == "start_01" then
      Flg.Set("FLAG_GIMMICK_D05_480")
      Prcs_d0502_DuctAccessIsEntrance(true)
    end
  elseif gMapNum == 505 then
    if start_loc == "start_03" then
      SetFollowerCameraOperateRotation(0, -25, 0)
    end
  elseif gMapNum == 506 then
    M320:Event_100()
    M330:Event_010()
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
    print("////////////////////////////////////////////////////")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 501 then
    if Flg.Check("FLAG_FIELD_D05_IS_WARP") and (start_loc == "start_31" or start_loc == "start_32") then
      WarpNpcArrival()
      Flg.Clear("FLAG_FIELD_D05_IS_WARP")
    end
    M150:Event_040()
    M150:Event_220()
    M250:Event_020()
    M320:Event_018()
    Field_InvisibleObjects(MOB, 147, 155)
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_540") then
      local berufe_01 = GetIndex(ENEMY, "berufe_01")
      local berufe_02 = GetIndex(ENEMY, "berufe_02")
      if Field.IsSymbolDefeated(berufe_02) then
        Field.SymbolForceLeave(berufe_01, true, FOREVER)
      end
    end
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_560") and Common.CheckTimeAxis("P2028_daft_440") then
      Field.HideMinimap(true)
      Field.HideGuide(true)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
    if Flg.Check("FLAG_FIELD_D05_ARENAWARP") and GetLastPlayerSetLocator() == "start_04" then
      Prcs_d05_ArenaWarpOut()
    end
    local start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_60" then
      require("S070_167")
      S070_167:Event_010()
    end
    if start_loc == "start_30" then
      require("S095_077")
      S095_077:Event_040()
    end
    require("S110_101")
    S110_101:Event_070()
  elseif gMapNum == 502 then
    M150:Event_120()
    M150:Event_135()
    M150:Event_168()
    M150:Event_180AB()
    M150:Event_180BA()
    Field_InvisibleObjects(MOB, 7, 14)
    local guard_index_1 = GetIndex(NPC, "npc_826")
    local guard_index_2 = GetIndex(MOB, "mob_0024")
    Field.ObjectAttachEffectScript(NPC, guard_index_1, "ef_f_chu_005_sm", true, 1, false, false, true, false, "J_mune")
    Field.ObjectAttachEffectScript(MOB, guard_index_2, "ef_f_chu_005_sm", true, 2, false, false, true, false, "J_mune")
    Field.ObjectStartEffectScript(NPC, guard_index_1, 1)
    Field.ObjectStartEffectScript(MOB, guard_index_2, 2)
    Field_InvisibleObjects(MOB, 25, 36)
  elseif gMapNum == 503 then
    local start_loc = GetLastPlayerSetLocator()
    require("S095_077")
    require("S110_099")
    if start_loc == "start_20" then
      S095_077:Event_020()
    elseif start_loc == "start_21" then
      S110_099:Event_030()
    end
    require("S110_101")
    S110_101:Event_050()
    S110_101:Event_060()
    require("S110_099")
    S110_099:Event_040()
    S110_099:Event_050()
  end
  if gMapNum == 505 then
    if Flg.Check("FLAG_FIELD_D05_IS_WARP") and start_loc == "start_30" then
      WarpNpcArrival()
      Flg.Clear("FLAG_FIELD_D05_IS_WARP")
    end
    M150:Event_250()
    require("S095_082")
    S095_082:Event_050()
    if Flg.Check("FLAG_MAIN_04_091", "FLAG_MAIN_04_140") then
      Obj:new(NPC, "vulcanus"):SetIcon(ICO_TALK)
    end
  end
  if gMapNum == 506 then
    if Flg.Check("FLAG_FIELD_D05_IS_WARP") and start_loc == "start_30" then
      WarpNpcArrival()
      Flg.Clear("FLAG_FIELD_D05_IS_WARP")
    end
    require("S050_176")
    S050_176:Event_030()
    if Flg.Check("FLAG_FIELD_D05_ARENAWARP") then
      if GetLastPlayerSetLocator() == "start_00" then
        Prcs_d05_ArenaWarpOut()
      elseif GetLastPlayerSetLocator() == "start_01" then
        Prcs_d05_ArenaWarpOut()
      end
    end
    M320:Event_019A()
    M320:Event_045A()
    M320:Event_048A()
    M320:Event_060()
    M330:Event_010()
    require("S110_106")
    S110_106:Event_050()
    S110_106:Event_015()
    require("S100_088")
    S100_088:Event_014()
    require("S100_089")
    S100_089:Event_020()
    require("S110_113")
    S110_113:Event_030()
    S110_113:Event_020()
    require("S110_208")
    S110_208:Event_020()
    ArenaCheckWin()
    Prcs_d0506_ArenaAppearMarusumonEvent()
    Prcs_d0513_ArenaWinMarusumonEvent()
    GetArenaReward()
    require("S110_111")
    S110_111:Event_040()
    S110_111:Event_050()
    AddChallengerNotice(false)
  end
  if gMapNum == 507 then
    M320:Event_040()
    M320:Event_045()
    require("S070_167")
    Obj:new(NPC, "s070_167_minerva"):Invisible()
    Obj:new(NPC, "s070_167_beelze"):Invisible()
    if Flg.Check("FLAG_SUB_070_167_007") then
      if not Flg.Check("FLAG_SUB_070_167_009") then
        Obj:new(NPC, "s070_167_minerva"):CancelInvisible()
        Obj:new(NPC, "s070_167_beelze"):CancelInvisible()
        S070_167:Event_040()
      else
        Obj:new(NPC, "s070_167_minerva"):CancelInvisible()
        Obj:new(NPC, "s070_167_beelze"):CancelInvisible()
        S070_167:Event_050()
      end
    end
  end
  if gMapNum == 508 then
    M320:Event_047()
    M320:Event_048()
  end
  if gMapNum == 509 then
    M320:Event_050()
    M320:Event_055()
  end
  if gMapNum == 513 then
    M320:Event_065()
    M320:Event_070()
    M320:Event_080()
    SetArenaBattle()
    if GetLastPlayerSetLocator() == "start_01" then
      Prcs_d0513_RingEvent0001()
    end
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 501 then
    M150:Event_270()
    M310:Event_025()
  elseif gMapNum == 503 then
    require("S095_077")
    S095_077:Event_030()
  elseif gMapNum == 505 then
    if start_loc == "start_25" then
    end
  elseif gMapNum == 506 then
  end
end

function UpdateMinimap(start_loc)
  if gMapNum == 501 then
    if start_loc == "start_00" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_01" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_02" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if start_loc == "start_03" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_04" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_05" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if start_loc == "start_09" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_10" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_11" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_12" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_13" then
      MiniMapChange(MAP_LAYER_HIGH)
    end
    if start_loc == "start_20" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_70" then
      MiniMapChange(MAP_LAYER_LOW)
    end
  end
end
