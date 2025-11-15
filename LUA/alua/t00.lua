function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  InitializeObject()
  MapNameDisp()
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
    HideMinimap(true)
    if Field.IsJustAfterMapChangeNow() == true then
      start_loc = GetLastPlayerSetLocator()
      print("##### start_locator = " .. start_loc .. " #####")
      ProcessIfNeedByStartLocator(start_loc)
    end
    if Flg.Check("FLAG_MAIN_01_000") then
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      gReturnPrefix, gReturnNum = GetAddress()
      gReturnLocator = Work.GetString(Field_Shop_Temp_Locator)
      Cam.Inst:Set(1.13, 0.3, -6.6, -4.15, 3.38, 0, default, 0)
      FadeInWithWait(0, 40)
      if gReturnNum == 102 then
        ShopConvenienceStore(1, "shop_0001", "e007", "e002")
      elseif gReturnNum == 203 then
        ShopConvenienceStore(2, "shop_0001", "e007", "e002")
      elseif gReturnNum == 401 then
        ShopConvenienceStore(4, "shop_0001", "e007", "e002")
      end
      local y_degree = Field.GetLocatorRotationYDegree("script_out")
      MovePlayerFrame(y_degree, 2, 20)
      FadeOutWithWait(0, 20)
      MapChange(gReturnPrefix, gReturnNum, gReturnLocator, false, -1, -1)
      MapNameDisp()
    end
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
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
end
