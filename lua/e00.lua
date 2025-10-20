function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  InitializeObject()
end

function OnEndLoad()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  SaveSequenceAfterChapterChange()
  PlayDungeonBGM()
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    local start_loc = GetLastPlayerSetLocator()
  else
    StartEventBeforeFadeIn()
    FadeInWithWait(0, 0)
    StartEventAfterFadeIn()
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
  if gMapNum == 1 then
    M010:Event_010()
    if Flg.Check("FLAG_MAIN_07_069", "FLAG_MAIN_07_070") then
      Debug.AllUIOff()
      Motion.Player:ChangeMoveAnim("cyberspace", 15)
      SetEnableCameraOperate(false)
      SetProhibitPlayerOnlyOperate(true)
      Field_InvisibleFollowerAllPartyMember(0, 10, false)
      Field_InvisibleFollowerAllGuest(0, 10, false)
    end
  end
  if gMapNum == 3 then
  end
  if gMapNum == 4 then
  end
  if gMapNum == 5 then
    M180:Event_020()
    M190:Event_008()
  end
  if gMapNum == 6 then
  end
  if gMapNum == 7 then
  end
  if gMapNum == 8 then
    M120:Event_010()
    M120:Event_PlayableThankYouForPlaying()
  end
end

function StartEventAfterFadeIn()
end
