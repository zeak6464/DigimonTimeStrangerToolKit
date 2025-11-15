function FieldLoadRequest()
  print("##### FieldLoadRequest #####")
  
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  if load_map_num == 901 then
  elseif load_map_num == 902 then
    Field.LoadPlayerScriptDigimonRideDigimon(146)
  elseif load_map_num == 903 then
    Field.LoadCameraAnimation("Cam_r03_in01")
    Field.LoadCameraAnimation("Cam_r03_out01")
    Field.ObjectLoadAttachment(FLD_OBJ_PLAYER, 1, 1)
    Field.ObjectLoadAttachment(FLD_OBJ_PLAYER, 1, 2)
    Field.ObjectLoadAttachmentMotion(FLD_OBJ_PLAYER, 1, 1, "r348_in01")
    Field.ObjectLoadAttachmentMotion(FLD_OBJ_PLAYER, 1, 2, "r348_out01")
    Field.LoadPlayerScriptDigimonRideDigimon(146)
  elseif load_map_num == 905 then
    Field.LoadPlayerScriptDigimonRideDigimon(145)
  end
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  MapNameDisp()
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
end

function OnEndLoad()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  SaveSequenceAfterChapterChange()
  PlayDungeonBGM()
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
    FadeInWithWait(0, 0)
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
  if gMapNum == 901 then
  elseif gMapNum == 902 then
  elseif gMapNum == 903 then
    if start_loc == "start_10" then
      HideMinimap(true)
      HideGuide(true)
      Common.ProhibitSave()
      Field.PlayerScriptDigimonRideStartFromID(146, false, "", 0)
      WaitFrame(1)
      SetEnableCameraOperate(false)
      SetControlScriptExternalVariable("ride_state", "start_arrival")
    end
  elseif gMapNum == 905 and start_loc == "start_10" then
    Field.PlayerScriptDigimonRideStartFromID(145, false, "", 0)
    WaitFrame(1)
    SetEnableCameraOperate(false)
    SetControlScriptExternalVariable("ride_state", "start_arrival")
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 900 then
    M430:Event_030()
    M440:Event_010()
  end
  if gMapNum == 901 then
    M440:Event_508()
    M440:Event_570()
  end
  if gMapNum == 902 then
    if Flg.Check("FLAG_FIELD_D09_001") and GetLastPlayerSetLocator() == "start_00" then
      Prcs_d09_GekoWarpMapChange()
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_FIELD_D09_001")
    end
    M440:Event_590()
    M440:Event_600()
  end
  if gMapNum == 903 then
    if Flg.Check("FLAG_IS_CARRY_OBJECT") then
      if Flg.Check("FLAG_MAIN_22_240") and not Flg.Check("FLAG_MAIN_22_250") then
        Prcs_d0903_KeepNuts(11)
      elseif Flg.Check("FLAG_MAIN_22_260") and not Flg.Check("FLAG_MAIN_22_270") then
        Prcs_d0903_KeepNuts(12)
      elseif Flg.Check("FLAG_MAIN_22_275") and not Flg.Check("FLAG_MAIN_22_276") then
        Prcs_d0903_KeepNuts(13)
      elseif Flg.Check("FLAG_MAIN_22_280") and not Flg.Check("FLAG_MAIN_22_290") then
        Prcs_d0903_KeepNuts(14)
      end
    end
    M440:Event_672()
    M440:Event_690_3()
  end
  if gMapNum == 904 then
    M440:Event_710()
    M440:Event_745()
    M440:Event_770()
    M440:Event_780()
    M440:Event_782_3()
  end
  if gMapNum == 905 then
    M440:Event_785()
    M440:Event_798()
    M440:Event_795()
    M440:Event_800_3()
  end
  if gMapNum == 906 then
    M440:Event_820()
    M440:Event_825_3()
  end
  if gMapNum == 907 then
    M440:Event_850()
    M440:Event_865()
    M440:Event_900()
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 990 then
    M430:Event_020()
  end
end
