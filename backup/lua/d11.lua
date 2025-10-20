function FieldLoadRequest()
  print("##### FieldLoadRequest #####")
  
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

function OnEndLoad()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  SaveSequenceAfterChapterChange()
  if Flg.Check("FLAG_MAIN_02_050") then
  else
    PlayDungeonBGM()
  end
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    local start_loc = GetLastPlayerSetLocator()
    MovePlayerToStartPosition(start_loc)
  else
    if gMapNum == 1102 then
      Flg.Set("FLAG_FIELD_D11_IS02")
    else
      Flg.Clear("FLAG_FIELD_D11_IS02")
    end
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
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    if gMapNum == 1102 and start_loc == "start_01" then
      Move.PlayerIsDegeGateOut()
    end
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
  end
  if Flg.Check("FLAG_GIMMICK_D11_130", "FLAG_GIMMICK_D11_160") then
    SetControlScriptExternalVariable("shadow_state", "lost")
  end
  if Flg.Check("FLAG_GIMMICK_D11_160", "FLAG_GIMMICK_D11_170") then
    SetControlScriptExternalVariable("shadow_state", "lost")
  end
  if Flg.Check("FLAG_GIMMICK_D11_170") then
    SetControlScriptExternalVariable("shadow_state", "lost")
  end
  if gMapNum == 1101 then
  end
  if gMapNum == 1102 then
    M040:Event_050()
    M040:Event_PlayableClear()
    M040:Event_080()
  end
  if gMapNum == 1103 then
    Flg.Clear("FLAG_t0105_InLine")
    Flg.Clear("FLAG_t0105_InPlatform")
  end
  if gMapNum == 1104 then
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 1101 then
  elseif gMapNum == 1102 then
  elseif gMapNum == 1103 then
  end
end
