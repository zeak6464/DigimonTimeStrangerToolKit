function OpenWorldMap(field_type, transportation)
  local prefix = ""
  
  local map_num = 0
  local locator = ""
  local time_travel_type
  local time_axis_define = ""
  local time_zone
  local is_not_play_se = false
  WorldMap.Open(field_type, false, transportation)
  while not WorldMap.IsSelected() and not WorldMap.IsClosed() do
    WaitFrame(1)
  end
  if WorldMap.IsCanceled() then
    WorldMap.Close()
    while true do
      if WorldMap.IsClosed() then
        Field.WaitForBeingPrepared()
        WorldMap.End()
        break
      end
      WaitFrame(1)
    end
  else
    prefix = WorldMap.GetPrefix()
    map_num = WorldMap.GetMapNumber()
    locator = WorldMap.GetLocator()
    WorldMap.End()
    if prefix == "d" then
      time_zone = NOON
      if map_num == 201 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, 0)
        Field.WaitForBeingPrepared()
        M150:Event_280()
        if Flg.Check("FLAG_MAIN_09_081", "FLAG_MAIN_09_082") then
          prefix = "d"
          map_num = 306
          locator = "start_00"
        end
      end
      if 201 <= map_num and map_num <= 217 then
        if Common.CheckTimeAxis("A2020_dbef_199") then
          time_zone = NOON
        elseif Flg.Check("FLAG_MAIN_07_040") and not Common.CheckTimeAxis("P2028_daft_350") then
          time_zone = EVENING
        elseif Flg.Check("FLAG_MAIN_05_083", "FLAG_MAIN_08_000") then
          time_zone = NOON
        end
      end
      if Qst.Main:Check(170, 1, 3) then
        Field.WaitForBeingPrepared()
        M170:Event_015()
        is_not_play_se = true
      end
      if 301 <= map_num and map_num <= 302 and (Flg.Check("FLAG_MAIN_05_083", "FLAG_MAIN_08_000") or Common.CheckTimeAxis("A2020_dbef_199")) then
        time_zone = EVENING
      end
      if map_num == 401 and Flg.Check("FLAG_MAIN_05_990", "FLAG_MAIN_06_010") then
        Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
        prefix = "e"
        map_num = 5
        locator = "start_00"
      end
      if map_num == 402 and Flg.Check("FLAG_MAIN_10_001", "FLAG_MAIN_10_002") then
        Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
      end
      if 501 <= map_num and map_num <= 502 and Flg.Check("FLAG_MAIN_05_083", "FLAG_MAIN_08_000") then
        time_zone = NOON
      end
      if map_num == 606 then
        if Qst.Main:Check(150, 140, 255) and not Flg.Check("FLAG_MAIN_05_010") then
          Flg.Set("FLAG_MAIN_05_000")
          Flg.Set("FLAG_MAIN_05_010")
          time_travel_type = AXIS_ORIGINAL
          time_axis_define = "A2020_dbef_160"
          time_zone = NOON
        end
        if Flg.Check("FLAG_MAIN_07_000", "FLAG_MAIN_07_010") then
          BackFade_OutNoLoadingWithWait(FADE_BLACK, 0)
          WorldMap.Close()
          while true do
            if WorldMap.IsClosed() then
              Field.WaitForBeingPrepared()
              WorldMap.End()
              break
            end
            WaitFrame(1)
          end
          local tlk = Tlk:new("field_text", 1, true)
          tlk:StartTalk()
          OpenInfoWindow(20020)
          local result = tlk:Select(2, "g_confirmation_1000_0040")
          if result == RESULT_TALK01 then
            tlk:EndTalk()
            PlayerObjectResetAim()
            Digimon.RestoreAllParty()
            prefix = "e"
            map_num = 5
            locator = "start_00"
            time_travel_type = AXIS_ORIGINAL
            time_axis_define = "A2020_dbef_190"
            time_zone = NOON
            FadeAllInWithWait(FADE_BLACK, 0)
          elseif result == RESULT_TALK00 then
            tlk:EndTalk()
            FadeAllInWithWait(FADE_BLACK, FADE_TIME)
            Digitter.Send(2500040)
            goto lbl_360
          end
        end
      end
    end
    if Flg.Check("FLAG_ISAREA_CHANGE_FOR_LOCOMON") and is_not_play_se == false then
      PlayDapatureLocomonSound()
    end
    if Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") and is_not_play_se == false then
      PlayDapatureBlimpSound()
    end
    if time_travel_type ~= nil then
      MapChangeWithTimeTravel(prefix, map_num, locator, time_travel_type, time_axis_define, time_zone)
    elseif time_travel_type == nil and time_zone ~= nil then
      MapChangeWithTimePasses(prefix, map_num, locator, time_zone)
    else
      MapChange(prefix, map_num, locator, false, FADE_BLACK, FADE_TIME)
    end
  end
  ::lbl_360::
end

function OpenWorldMapAutoTransition(field_type)
  WorldMap.Open(field_type, true)
  while not WorldMap.IsClosed() do
    WaitFrame(1)
  end
  Field.WaitForBeingPrepared()
end

function mapmessagestart()
  if map_num == 201 then
    MessageTalk(500000)
  elseif map_num == 206 then
    MessageTalk(500002)
  elseif map_num == 302 then
    MessageTalk(500002)
  elseif map_num == 402 then
    MessageTalk(500002)
  elseif map_num == 501 then
    MessageTalk(500002)
  end
end

function mapmessageend()
  if map_num == 201 then
    MessageTalk(500001)
  elseif map_num == 206 then
    MessageTalk(500003)
  elseif map_num == 302 then
    MessageTalk(500003)
  elseif map_num == 402 then
    MessageTalk(500003)
  elseif map_num == 501 then
    MessageTalk(500003)
  end
  Field_Talk_End()
end

function mapmessagestop()
  if Flag.Check(1501) and not Flag.Check(1509) then
    if map_num == 201 then
      MessageTalk(500051)
    else
      MessageTalk(500061)
    end
  elseif Flag.Check(1616) and not Flag.Check(1626) then
    if map_num == 402 then
      MessageTalk(500062)
    end
  elseif Common.IsExistGuest(4) then
    Message(500052)
  elseif Common.IsExistGuest(5) then
    Message(500054)
  elseif map_num == 201 then
    MessageTalk(500050)
  else
    MessageTalk(500060)
  end
end
