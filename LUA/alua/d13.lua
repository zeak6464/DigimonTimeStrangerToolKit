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
  PlayDungeonBGM()
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    local start_loc = GetLastPlayerSetLocator()
    MovePlayerToStartPosition(start_loc)
    if gMapNum == 1301 and start_loc == "start_00" then
      Prcs_d1301_ExitElv()
    end
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
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if gMapNum == 1301 then
    if start_loc == "start_00" then
      Prcs_d1301_ExitElv()
      goto lbl_97
    end
  elseif gMapNum == 1304 then
    if start_loc == "start_01" then
      Prcs_d1304_ExitElv()
      goto lbl_97
    elseif start_loc == "start_02" then
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Motion.Player:ChangeMoveAnim("hide", 1.5)
      SetPlayerLocator("start_02")
    end
  elseif gMapNum == 1305 and start_loc == "start_01" then
    SetFollowerCameraOperateRotation(20, -140)
    Motion.Player:ChangeMoveAnimWithBlend("hide", 0, 0)
    PlaySE(210022, 100)
    WaitFrame(30)
    Motion.Player:ResetMoveAnimationWithBlend(40)
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
  ::lbl_97::
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 1301 then
    M235:Event_020()
    M390:Event_080()
    M390:Event_100()
    M390:Event_110()
    M390:Event_120()
  end
  if gMapNum == 1302 then
    M390:Event_140()
    M390:Event_605()
    M390:Event_700()
  end
  if gMapNum == 1303 then
    M235:Event_025()
    M390:Event_601A()
  end
  if gMapNum == 1304 then
    M390:Event_670()
  end
  if gMapNum == 1305 then
    M340:Event_030()
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 1301 then
    M390:Event_032()
  elseif gMapNum == 1302 then
  end
  if gMapNum == 1304 then
    M235:Event_030()
  end
end
