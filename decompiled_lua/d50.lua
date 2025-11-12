function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function OnEndLoad()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  SaveSequenceAfterChapterChange()
  PlayDungeonBGM()
  InitializeObject()
  StartEventBeforeFadeIn()
  if Field.IsJustAfterMapChangeNow() == true then
    local start_loc = GetLastPlayerSetLocator()
    ProcessIfNeedByStartLocator(start_loc)
  end
  if Flg.Check("FLAG_DLC_EP02_BTL010") and not Flg.Check("FLAG_DLC_EP02_005") then
    MapChange("d", 5004, "start_00", true, 0, 30)
  end
  MapNameDisp()
  FadeInWithWait(0, 0)
  StartEventAfterFadeIn()
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  require("dlc020")
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5004 then
    local start_loc = GetLastPlayerSetLocator()
    if gLoopCount == nil then
      gLoopCount = 0
    end
  elseif gMapNum == 5005 then
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  local start_loc = GetLastPlayerSetLocator()
  if gMapNum == 5001 then
  elseif gMapNum == 5002 then
  elseif gMapNum == 5003 then
  elseif gMapNum == 5004 then
  elseif gMapNum == 5005 then
  end
end
