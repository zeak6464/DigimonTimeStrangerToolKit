function FieldLoadRequest()
  print("##### FieldLoadRequest #####")
  
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 607 then
    local disp_name = true
    if Flg.Check("FLAG_MAIN_20_011", "FLAG_MAIN_20_022") then
      disp_name = false
    end
    if Flg.Check("FLAG_MAIN_22_435", "FLAG_MAIN_22_445") then
      disp_name = false
    end
    if disp_name == true then
      MapNameDisp()
    end
  else
    MapNameDisp()
  end
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
  if Flg.Check("FLAG_MAIN_20_016", "FLAG_MAIN_20_020") and gMapNum == 607 then
    Sound.StopBGM(0)
  end
  local is_map_changed_now = args.map_changed_now
  if is_map_changed_now then
    UpdateMinimap(start_loc)
  end
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    local start_loc = GetLastPlayerSetLocator()
    MovePlayerToStartPosition(start_loc)
  else
    StartEventBeforeFadeIn()
    if Field.IsJustAfterMapChangeNow() == true then
      local start_loc = GetLastPlayerSetLocator()
      ProcessIfNeedByStartLocator(start_loc)
    end
    BackFade_In(0, 0)
    FadeInWithWait(0, 0)
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if gMapNum == 601 and start_loc == "start_00" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") then
    PlayStopBlimpSound()
    AddChallengerNotice(false)
  end
  if gMapNum == 602 then
    if start_loc == "start_00" then
      if Flg.Check("FLAG_MAIN_19_010", "FLAG_MAIN_19_015") then
        SetPlayerLocator("start_20")
      elseif Flg.Check("FLAG_MAIN_19_063", "FLAG_MAIN_19_065") then
        SetPlayerLocator("start_20")
      end
    end
    if start_loc == "start_00" or start_loc == "start_06" then
      Flg.Clear("FLAG_GIMMICK_D06_160")
    elseif Flg.Check("QUEST_M410_CLEAR") then
      Flg.Clear("FLAG_GIMMICK_D06_160")
    else
      Flg.Set("FLAG_GIMMICK_D06_160")
    end
    if start_loc == "start_50" then
      Flg.Clear("FLAG_GIMMICK_D06_160")
    end
  end
  if gMapNum == 603 and start_loc == "start_00" then
    Field.ObjectInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "access_door01"), 0, 0, false)
  end
  if gMapNum == 604 and start_loc == "start_00" then
    Field.ObjectInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "access_door02"), 0, 0, false)
  end
  if not (gMapNum == 606 and start_loc == "start_00" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_LOCOMON")) or Flg.Check("FLAG_MAIN_07_010", "FLAG_MAIN_07_015") then
  elseif Flg.Check("FLAG_MAIN_05_010", "FLAG_MAIN_05_020") then
  elseif Flg.Check("FLAG_MAIN_05_020", "FLAG_MAIN_05_030") then
  else
    PlayStopLocomonSound()
  end
  if start_loc == "start_50" then
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    if start_loc == "start_50" then
      InitializeTheaterDoorEvt()
    elseif start_loc == "start_51" then
      InitializeTheaterDoorEvt(51, "theater_0002")
    end
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 601 then
  elseif gMapNum == 602 then
    M410:Event_225()
  elseif gMapNum == 603 then
  elseif gMapNum == 604 then
    M410:Event_040()
    M410:Event_080()
    M410:Event_210()
    M410:Event_138_flagctrl()
  end
  if gMapNum == 605 then
    M410:Event_240()
  end
  if gMapNum == 606 then
    M160:Event_010()
    M170:Event_260()
    M190:Event_030()
    M190:Event_040()
  end
  if gMapNum == 607 then
  end
  if gMapNum == 608 then
    M190:Event_050()
    M190:Event_060()
  end
  if gMapNum == 609 then
    M190:Event_010()
    M190:Event_025()
    Digitter.Send(3060100, false, true)
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 601 then
    M410:Event_020()
  elseif gMapNum == 602 then
  elseif gMapNum == 604 then
    if Flg.Check("FLAG_MAIN_19_060", "FLAG_MAIN_19_061") then
      Obj:new(NPC, "npc_1037"):Invisible()
    end
  elseif gMapNum == 607 and Flg.Check("FLAG_MAIN_20_015", "FLAG_MAIN_20_022") then
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
  end
end

function UpdateMinimap(start_loc)
  if Field.IsJustAfterMapChangeNow() == true then
    if gMapNum == 602 then
      MiniMapChange(MAP_LAYER_LOW)
      if start_loc == "start_07" or start_loc == "start_08" then
        MiniMapChange(MAP_LAYER_MIDDLE)
      end
    end
    if gMapNum == 603 then
      MiniMapChange(MAP_LAYER_LOW)
      if start_loc == "start_02" then
        MiniMapChange(MAP_LAYER_MIDDLE)
      end
    end
    if gMapNum == 604 then
      MiniMapChange(MAP_LAYER_LOW)
      if start_loc == "start_00" or start_loc == "start_02" or start_loc == "start_03" then
        MiniMapChange(MAP_LAYER_MIDDLE)
      elseif start_loc == "start_20" then
        MiniMapChange(MAP_LAYER_HIGH)
      elseif start_loc == "start_21" then
        MiniMapChange(MAP_LAYER_HIGH)
      elseif start_loc == "start_22" then
        MiniMapChange(MAP_LAYER_HIGH)
      elseif start_loc == "start_50" then
        MiniMapChange(MAP_LAYER_HIGH)
      else
        if start_loc == "start_51" then
          MiniMapChange(MAP_LAYER_MIDDLE)
        else
        end
      end
    end
  end
end
