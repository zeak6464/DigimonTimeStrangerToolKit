function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum ~= 3004 then
    MapNameDisp()
  end
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
end

function OnEndLoad()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  local start_loc = GetLastPlayerSetLocator()
  SaveSequenceAfterChapterChange()
  PlayDungeonBGM()
  UpdateMinimap(start_loc)
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    MovePlayerToStartPosition(start_loc)
  else
    StartEventBeforeFadeIn()
    if Field.IsJustAfterMapChangeNow() == true then
      ProcessIfNeedByStartLocator(start_loc)
    end
    if gMapNum == 3001 then
      if Flg.Check("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER") then
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
      elseif Flg.Check("FLAG_GIMMICK_T30_010", "FLAG_IS_SKIP_FADE_010") then
        Flg.Set("FLAG_IS_SKIP_FADE_010")
      elseif Flg.Check("FLAG_MAIN_13_160", "FLAG_IS_SKIP_FADE_020") then
        Flg.Set("FLAG_IS_SKIP_FADE_020")
      elseif Flg.Check("FLAG_IS_SKIP_FADE_030") then
        Flg.Clear("FLAG_IS_SKIP_FADE_030")
      else
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      end
    elseif gMapNum == 3002 then
      FadeInWithWait(0, 0)
    elseif gMapNum == 3003 then
      if Qst.Sub:Check(87, 1, 5) then
      else
        FadeInWithWait(0, 30)
      end
    elseif gMapNum == 3004 then
      FadeInWithWait(0, 0)
    end
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    if gMapNum == 3001 then
      if start_loc == "start_01" then
        SetFollowerCameraOperateRotation(0, 175)
      end
      if start_loc == "start_02" then
        Move:PlayerIsDoorOut()
        SetFollowerCameraOperateRotation(0, 270)
      else
        if start_loc == "start_00" then
          if Flg.Check("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER") then
            Digimon.RestoreAllParty()
            Digitter.Send(9999004, false, false)
          end
        elseif start_loc == "start_05" and Flg.Check("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER") then
          Digimon.RestoreAllParty()
          Digitter.Send(9999004, false, false)
        end
        elseif gMapNum == 3002 then
          Digimon.RestoreAllParty()
        elseif gMapNum == 3003 then
          Digimon.RestoreAllParty()
        end
        MovePlayerToStartPosition(start_loc)
      end
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 3001 then
    if not Flg.Check("FLAG_GIMMICK_T30_010") then
      Execute("m050_050")
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Set("FLAG_GIMMICK_T30_010")
      Flg.Set("FLAG_MAIN_03_030")
    end
    if not Flg.Check("FLAG_MAIN_03_030") then
      Flg.Set("FLAG_MAIN_03_030")
    end
    local mirei_icon = Icon:new(NPC, "farm_0001")
    if Qst.Main:Check(M050.ID, M050.STEP_015, M050.STEP_020) then
      mirei_icon:SetScenarioTarget()
    end
  end
  if gMapNum == 3002 then
    M010:Event_020()
  end
  if gMapNum == 3003 then
    M030:Event_030()
    t3003_SetCamera(0)
    Obj:new(PLAYER, ""):SetPos(7.64, 0, -7.62, true)
    WaitFrame(5)
  end
  if gMapNum == 3004 then
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if not Common.CheckTimeAxis("A2028_daft_220") then
    Prcs_t30_InvisibleFollower()
  else
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
  end
  if gMapNum == 3001 and not Flg.Check("FLAG_OPEN_TIMEJUMP") and Flg.Check("FLAG_IS_CLEAR_S100_178") then
    Flg.Set("FLAG_OPEN_TIMEJUMP")
    Flg.Set("TUT_FLAG_4721")
  end
  if gMapNum == 3003 then
    SetControlScriptExternalVariable("player_state", "center")
  end
  if gMapNum == 3004 then
    FadeInWithWait(0, 0)
  end
end

function UpdateMinimap(start_loc)
end
