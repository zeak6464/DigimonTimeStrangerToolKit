function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  Field.LoadPlayerScriptDigimonRideDigimon(HAZAMA_RIDE_DIGIMON)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  gMapId = string.format("%d", string.sub(gMapNum, 1, 1))
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  MapNameDisp()
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
  if gMapNum == 310 or gMapNum == 311 or gMapNum == 312 or gMapNum == 313 then
    Field.DisableAnalyzeAndFieldAttack()
  end
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
    if gMapNum == 301 then
      FadeInWithWait(0, 0)
    else
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    end
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if gMapNum == 301 then
    if start_loc == "start_00" and not Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
      Move.PlayerIsDegeGateOut()
    end
  elseif gMapNum == 310 or gMapNum == 311 or gMapNum == 312 or gMapNum == 313 then
    if start_loc == "start_00" then
      print("##### START LOC 00 #####")
      Move.PlayerIsDegeGateOut()
    end
    if start_loc == "start_01" then
      print("##### START LOC 01 #####")
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
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 301 then
    local start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_21" then
      require("S200_146")
      S200_146:Event_060()
      S200_146:Event_050()
    else
      M100:Event_080()
      M100:Event_100()
      if start_loc == "start_20" then
        require("S910_170")
        S910_170:Event_040()
        S910_170:Event_050()
        S910_170:Event_085()
        S910_170:Event_090()
      end
    end
  elseif gMapNum == 302 then
    if Flg.Check("FLAG_GIMMICK_H03_010") and not Flg.Check("FLAG_GIMMICK_H03_060") then
      Flg.Set("FLAG_GIMMICK_H03_060")
      OpenRoad("plan_cl_0003", "obj_0003", 35.9, 2.4, 63.7, 35.9, 7.5, 72.3, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_030") and not Flg.Check("FLAG_GIMMICK_H03_070") then
      Flg.Set("FLAG_GIMMICK_H03_070")
      OpenRoad("plan_cl_0001", "obj_0001", 0.1, 3.6, 64.3, 0.1, 9.2, 72.6, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_020") and not Flg.Check("FLAG_GIMMICK_H03_080") then
      Flg.Set("FLAG_GIMMICK_H03_080")
      OpenRoad("plan_cl_0002", "obj_0002", 4, 8.3, -3.8, -1.8, 13.8, 2, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_040") and not Flg.Check("FLAG_GIMMICK_H03_090") then
      Flg.Set("FLAG_GIMMICK_H03_090")
      OpenRoad("plan_cl_0004", "obj_0004", -22.3, 10.3, -23.5, -22.3, 13.9, -14.2, false)
    end
    require("S110_090")
    S110_090:Event_030()
  elseif gMapNum == 303 then
    if Flg.Check("FLAG_GIMMICK_H03_030") and not Flg.Check("FLAG_GIMMICK_H03_060") then
      Flg.Set("FLAG_GIMMICK_H03_060")
      OpenRoad("plan_cl_0001", "obj_0001", 5, 7.3, 55.4, 5, 12, 64.2, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_010") and not Flg.Check("FLAG_GIMMICK_H03_070") then
      Flg.Set("FLAG_GIMMICK_H03_070")
      OpenRoad("plan_cl_0002", "obj_0002", -17.1, 5.7, -37.8, -17.2, 11.9, -30, true)
    elseif Flg.Check("FLAG_GIMMICK_H03_040") and not Flg.Check("FLAG_GIMMICK_H03_080") then
      Flg.Set("FLAG_GIMMICK_H03_080")
      OpenRoad("plan_cl_0003", "obj_0003", -37, 3.9, -37.1, -37.2, 7.1, -27.6, false)
    end
  elseif gMapNum == 304 then
    if Flg.Check("FLAG_GIMMICK_H03_030") and not Flg.Check("FLAG_GIMMICK_H03_060") then
      Flg.Set("FLAG_GIMMICK_H03_060")
      OpenRoad("plan_cl_0001", "obj_0001", -27.4, -1.3, 62.4, -27.4, 2.2, 71.8, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_010") and not Flg.Check("FLAG_GIMMICK_H03_070") then
      Flg.Set("FLAG_GIMMICK_H03_070")
      OpenRoad("plan_cl_0002", "obj_0002", -16.8, 4.3, 28.1, -18.6, 9.8, 36.2, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_020") and not Flg.Check("FLAG_GIMMICK_H03_080") then
      Flg.Set("FLAG_GIMMICK_H03_080")
      OpenRoad("plan_cl_0003", "obj_0003", 7.9, 7.7, -8, 1.2, 11.3, -1.4, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_040") and not Flg.Check("FLAG_GIMMICK_H03_090") then
      Flg.Set("FLAG_GIMMICK_H03_090")
      OpenRoad("plan_cl_0004", "obj_0004", -27.7, 8.4, -34.6, -33.7, 13.1, -28.2, false)
    end
  elseif gMapNum == 305 then
    if Flg.Check("FLAG_GIMMICK_H03_030") and not Flg.Check("FLAG_GIMMICK_H03_060") then
      Flg.Set("FLAG_GIMMICK_H03_060")
      OpenRoad("plan_cl_0002", "obj_0002", -34.9, 9.2, 39.5, -34.9, 13.8, 48.4, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_010") and not Flg.Check("FLAG_GIMMICK_H03_070") then
      Flg.Set("FLAG_GIMMICK_H03_070")
      OpenRoad("plan_cl_0003", "obj_0003", 0, 5.4, 34.1, 0, 10.8, 42.5, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_040") and not Flg.Check("FLAG_GIMMICK_H03_080") then
      Flg.Set("FLAG_GIMMICK_H03_080")
      OpenRoad("plan_cl_0001", "obj_0001", 25.1, -0.7, 62.5, 25.2, 3.6, 53.5, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_020") and not Flg.Check("FLAG_GIMMICK_H03_090") then
      Flg.Set("FLAG_GIMMICK_H03_090")
      OpenRoad("plan_cl_0004", "obj_0004", 1.8, 17.5, -27.8, 1.6, 22.5, -19.2, false)
    elseif Flg.Check("FLAG_GIMMICK_H03_050") and not Flg.Check("FLAG_GIMMICK_H03_100") then
      Flg.Set("FLAG_GIMMICK_H03_100")
      OpenRoad("plan_cl_0005", "obj_0005", -10.6, 21.6, -21.7, -6.1, 26.7, -14.3, true)
    end
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 301 then
    M100:Event_085()
  end
  if gMapNum == 310 or gMapNum == 311 or gMapNum == 312 or gMapNum == 313 then
    if not Flg.Check("FLAG_IS_HAZAMA_FIRST_TRIP") then
      HazamaFirstTripEvent()
    end
    SetControlScriptExternalVariable("start_call", "standby")
  end
end
