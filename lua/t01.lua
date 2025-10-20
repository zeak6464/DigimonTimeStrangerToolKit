function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  if load_map_prefix == "t" and load_map_num == 103 then
    Field.LoadPlayerScriptDigimonRideDigimon(146)
  end
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  InitializeObject()
  MapNameDisp()
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
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if start_loc == "start_50" then
    if Flg.Check("FLAG_IS_THEATER_FIRSTOUT") then
      InitializeTheaterDoorEvt()
    else
      Flg.Set("FLAG_IS_THEATER_FIRSTOUT")
    end
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if gMapNum == 102 and start_loc == "start_05" then
    SetFollowerCameraOperateRotation(10, 0)
  end
  if gMapNum == 103 and start_loc == "start_22" then
    Common.ProhibitSave()
    HideMinimap(true)
    HideGuide(true)
    SetControlScriptExternalVariable("ride_state", "start_setting")
    Field.PlayerScriptDigimonRideStartFromID(146, false, "", 0)
    SetFollowerCameraOperateRotation(0, 270, 0)
    SetEnableCameraOperate(false)
    SetControlScriptExternalVariable("ride_state", "start_arrival")
  end
  if gMapNum == 104 then
    Flg.Clear("FLAG_t0105_InLine")
    Flg.Clear("FLAG_t0105_InPlatform")
    if start_loc == "start_03" then
      SetFollowerCameraOperateRotation(20, default)
    elseif start_loc == "start_04" then
      SetFollowerCameraOperateRotation(20, default)
    end
  end
  if gMapNum == 105 then
    if start_loc == "start_00" then
      SetFollowerCameraOperateRotation(12, default)
      Flg.Clear("FLAG_t0105_InLine")
      Flg.Set("FLAG_t0105_InPlatform")
    elseif start_loc == "start_01" then
      SetFollowerCameraOperateRotation(12, default)
      Flg.Clear("FLAG_t0105_InLine")
      Flg.Set("FLAG_t0105_InPlatform")
    elseif start_loc == "start_02" then
      HideMinimap(true)
      Flg.Set("FLAG_IS_DISPLAYED_MAP_NAME_UI")
      Flg.Set("FLAG_t0105_InLine")
      Flg.Clear("FLAG_t0105_InPlatform")
    elseif start_loc == "start_03" then
      HideMinimap(true)
      Flg.Set("FLAG_IS_DISPLAYED_MAP_NAME_UI")
      if not Flg.Check("FLAG_MAIN_03_404") then
        local npc_blackshadow = Obj:new(NPC, "npc_blackshadow")
        npc_blackshadow:SetPos(36.29, -6.413, 232.227)
        npc_blackshadow:SetRotationY(90, 0)
        npc_blackshadow:CancelInvisible()
      elseif not Flg.Check("FLAG_MAIN_03_405") then
        local npc_blackshadow = Obj:new(NPC, "npc_blackshadow")
        npc_blackshadow:SetPos(36.29, -6.413, 232.227)
        npc_blackshadow:SetRotationY(90, 0)
        npc_blackshadow:CancelInvisible()
      end
    elseif start_loc == "start_04" then
      MiniMapChange(2)
    elseif start_loc == "start_05" then
      Flg.Clear("FLAG_t0105_InLine")
      Flg.Set("FLAG_t0105_InPlatform")
    end
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
    M010:Event_030()
  end
  if gMapNum == 103 then
    local start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_40" then
    end
  end
  if gMapNum == 104 then
  end
  if gMapNum == 105 then
    local start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_20" then
    end
  end
  if gMapNum == 106 then
  end
  if gMapNum == 107 then
    M010:Event_040()
  end
  if gMapNum == 108 then
    M010:Event_039()
  end
  if gMapNum == 109 then
    local start_loc = GetLastPlayerSetLocator()
  end
  if gMapNum == 121 then
    AddChallengerNotice(false)
  end
  if gMapNum == 173 then
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 101 then
  end
  if gMapNum == 102 then
  end
  if gMapNum == 103 then
  end
  if gMapNum == 104 then
  end
  if gMapNum == 105 then
  end
  if gMapNum == 106 then
  end
  if gMapNum == 107 then
  end
  if gMapNum == 108 then
  end
  if gMapNum == 109 then
  end
  if gMapNum == 110 then
  end
  if gMapNum == 111 then
  end
end
