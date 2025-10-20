require("function_common")
require("function_field")
require("define")

function ChangeChapterMap(prefix, number, locator, time_axis, time_axis_set, time_zone)
  print("##### ChangeChapterMap #####")
  print("chapter change map prefix: ", prefix, "/ map_num: ", map_num, "/ locator: ", locator)
  if time_zone == MORNING then
    print("time zone MORNING")
  elseif time_zone == NOON then
    print("time zone NOON")
  elseif time_zone == EVENING then
    print("time zone EVENING")
  elseif time_zone == NIGHT then
    print("time zone NIGHT")
  end
  MapChangeWithTimeTravel(prefix, number, locator, time_axis, time_axis_set, time_zone)
end

function ChangeChapter(chapter, chapter_progression, enable_map_change, is_use_bed, is_chapter_select)
  print("##### ChangeChapter #####")
  print("##### change to ", chapter, " #####")
  if enable_map_change then
    print("##### enable map change #####")
  else
    print("##### disable map change #####")
  end
  if is_chapter_select == nil then
    is_chapter_select = true
  end
  if chapter == 1 and enable_map_change == false then
    Flg.Set("FLAG_MAIN_01_010")
    Flg.Set("FLAG_MAIN_01_025")
    FieldWorldMapOpenAllArea()
  end
  local prefix, number, locator, is_keep_fadeout = "", 0, "", false
  Flag.SetByChapter(chapter, chapter_progression)
  Common.SetChapter(chapter)
  ChapterSelcetMapOpen(chapter, chapter_progression)
  SetAegiomonGiftandFriendship(chapter)
  Common.AddMoney(100000)
  if 10 <= chapter and chapter_progression ~= 10 then
    avater_type = Enum.PlayerAvatarTypeHeroine()
    Common.SetPlayerAvatarType(avater_type)
  end
  if chapter < 1000 then
    if 10 <= chapter then
      SystemFlag.SetHideEnemiesOnMiniMap()
      SystemFlag.SetProhibitAutoRegeneration()
      Flg.Set("FLAG_MAIN_01_000")
      if 1 > Item.GetNum(801) then
        Item.Add(801, 1)
      end
      Flg.Set("FLAG_IS_LOCK_STRIKE_PLUS")
      SystemFlag.SetFieldKeyHelpForNewGame()
      if 150 <= chapter_progression then
        SystemFlag.ClearFieldKeyHelpForNewGame()
        Item.Add(1, 1)
        Item.Add(7, 1)
      end
    end
    if 20 <= chapter then
      SystemFlag.ClearFieldKeyHelpForNewGame()
      if 30 <= chapter_progression then
        SystemFlag.ClearProhibitAutoRegeneration()
      end
      if 71 <= chapter_progression then
        Flg.Clear("FLAG_IS_LOCK_STRIKE_PLUS")
      end
    end
    if 30 <= chapter then
      SystemFlag.ClearProhibitAutoRegeneration()
      Flg.Clear("FLAG_IS_LOCK_STRIKE_PLUS")
    end
    if 50 <= chapter then
      if 50 <= chapter_progression then
        Flg.Set("FLAG_MAIN_03_025")
      end
      if 51 <= chapter_progression then
        local org_prefix = "t"
        local org_number = 109
        local org_locator = "start_50"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      end
      if 60 <= chapter_progression then
        local org_prefix = "t"
        local org_number = 109
        local org_locator = "start_50"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      end
    end
    if 60 <= chapter then
      Item.Add(30131, 1)
      Flg.Set("FLAG_IS_SKIP_FADE_010")
    end
    if 70 <= chapter then
      Common.SetDigimonGraspState(183, DIGIMON_GRASP_FLAG_JOIN)
      if 20 <= chapter_progression then
      end
      if 1 > Item.GetNum(803) then
      end
      if not (200 <= chapter) or not (chapter <= 210) then
        Common.SetAegiomonSkill(0, 21832)
        Common.SetAegiomonSkill(1, 0)
      end
    end
    if chapter == 80 and chapter_progression == 10 then
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    end
    if chapter == 90 and chapter_progression == 10 then
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    end
    if chapter == 100 and chapter_progression == 1 then
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    end
    if chapter == 110 and chapter_progression == 10 then
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    end
    if chapter == 80 and chapter_progression == 100 then
      Party.Aegiomon.SetExist(false)
    end
    if 90 <= chapter and 81 <= chapter_progression then
      Map:ClosePlace(103, true)
    end
    if chapter == 90 then
      Party.Aegiomon.SetExist(false)
    end
    if 100 <= chapter and 30 <= chapter_progression then
      Map:OpenArea(2, true)
      Map:OpenPlace(201, true)
    end
    if 110 <= chapter then
      SystemFlag.ClearHideEnemiesOnMiniMap()
    end
    if 120 <= chapter and chapter_progression == 10 then
      Common.AddTP(275)
      Common.LearnTamerSkill(204)
      Common.LearnTamerSkill(212)
      Common.LearnTamerSkill(201)
      Common.LearnTamerSkill(1)
      Common.LearnTamerSkill(51)
      Common.LearnTamerSkill(101)
      Common.LearnTamerSkill(151)
      Common.LearnTamerSkill(201)
      Common.LearnTamerSkill(23)
      Common.LearnTamerSkill(31)
      Common.LearnTamerSkill(29)
      Common.LearnTamerSkill(52)
      Common.LearnTamerSkill(69)
      Common.LearnTamerSkill(59)
      Common.LearnTamerSkill(102)
      Common.LearnTamerSkill(118)
      Common.LearnTamerSkill(127)
      Common.LearnTamerSkill(168)
      Common.LearnTamerSkill(181)
      Common.LearnTamerSkill(182)
      Common.LearnTamerSkill(203)
      Common.LearnTamerSkill(202)
      Common.AddPartyDigimon(343, 25, 4, 0, 25)
      Common.AddPartyDigimon(96, 25, 15, 0, 25)
      Common.AddPartyDigimon(12, 25, 11, 0, 25)
      Common.AddPartyDigimon(97, 25, 15, 0, 25)
      Common.AddPartyDigimon(50, 25, 3, 0, 25)
      Common.AddPartyDigimon(392, 25, 7, 0, 25)
      Common.AddBankDigimon(391, 25, 15, 0, 25)
      Common.AddBankDigimon(219, 25, 12, 0, 25)
      Common.AddBankDigimon(114, 25, 2, 0, 25)
      Common.SetDigimonScanValue(701, 100)
      Common.SetDigimonScanValue(687, 100)
      Common.SetDigimonScanValue(81, 100)
      Party.Aegiomon.Add(18)
      Guest.Add(10012)
    end
    if 140 <= chapter then
      Common.SetDigimonGraspState(136, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(234, DIGIMON_GRASP_FLAG_SCAN)
      if not (200 <= chapter) or not (chapter <= 210) then
        Common.SetAegiomonSkill(1, 21831)
      end
    end
    if 150 <= chapter then
      Common.SetDigimonGraspState(80, DIGIMON_GRASP_FLAG_SCAN)
      if 95 <= chapter_progression then
        Item.Add(750, 1)
      end
      if 101 <= chapter_progression then
        Item.Delete(750, 1)
      end
    end
    if 160 <= chapter then
      Common.SetDigimonGraspState(609, DIGIMON_GRASP_FLAG_SCAN)
    end
    if 180 <= chapter then
      Common.SetDigimonGraspState(606, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(145, DIGIMON_GRASP_FLAG_SCAN)
      Map:OpenArea(104, true)
      Map:OpenPlace(10401, true)
    end
    if 190 <= chapter then
      Common.SetDigimonGraspState(348, DIGIMON_GRASP_FLAG_SCAN)
    end
    if 200 <= chapter then
      Common.SetDigimonGraspState(184, DIGIMON_GRASP_FLAG_JOIN)
    end
    if 210 <= chapter and chapter == 210 and 18 <= chapter_progression then
      Item.Add(721, 1)
    end
    if 220 <= chapter then
      Common.SetDigimonGraspState(43, DIGIMON_GRASP_FLAG_SCAN)
    end
    if 230 <= chapter then
      Item.Add(723, 1)
      Flg.Set("FLAG_IS_USED_TIMEJUMP_TO_AFTER")
    end
    if 285 <= chapter then
      Item.Add(725, 1)
      Common.SetDigimonGraspState(187, DIGIMON_GRASP_FLAG_JOIN)
      Common.SetDigimonGraspState(172, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(75, DIGIMON_GRASP_FLAG_SCAN)
    end
    if 290 <= chapter and 10 <= chapter_progression then
      Map.AreaKeeoOut(104, false)
      Map:OpenPlace(10402, true)
      Map.PlaceKeepOut(10402, false)
    end
    if 300 <= chapter then
      Common.SetDigimonGraspState(83, DIGIMON_GRASP_FLAG_SCAN)
    end
    if chapter == 300 and chapter_progression == 51 then
      Guest.Add(GST_BACCHUS)
    end
    if 310 <= chapter then
      Item.Add(724, 1)
      Common.SetDigimonGraspState(188, DIGIMON_GRASP_FLAG_JOIN)
      Common.SetDigimonGraspState(742, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(179, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(232, DIGIMON_GRASP_FLAG_SCAN)
      Flg.Clear("FLAG_MAIN_10_059")
      if 1 <= chapter_progression then
        Flg.Set("FLAG_MAIN_10_060")
      end
    end
    if 320 <= chapter then
      if 10 <= chapter_progression then
        Flg.Set("FLAG_MAIN_11_070")
      end
      if 70 <= chapter_progression then
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
        local org_prefix = "d"
        local org_number = 506
        local org_locator = "start_50"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
      end
    end
    if 330 <= chapter then
      require("Sarena_300")
      Sarena_300:GreatestOmegaCarnival_Start()
      Common.SetDigimonGraspState(403, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(174, DIGIMON_GRASP_FLAG_SCAN)
    end
    if 340 <= chapter and chapter == 340 and 30 <= chapter_progression then
      Party.Aegiomon.SetExist(false)
    end
    if 350 <= chapter then
      Party.Aegiomon.SetExist(false)
      if 10 <= chapter_progression then
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
        local org_prefix = "d"
        local org_number = 1204
        local org_locator = "start_50"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
      end
      if 100 <= chapter_progression then
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
        local org_prefix = "d"
        local org_number = 202
        local org_locator = "start_50"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
      end
    end
    if 360 <= chapter then
      Flg.Set("FLAG_IS_SKIP_FADE_020")
      if 100 <= chapter_progression then
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
        local org_prefix = "d"
        local org_number = 202
        local org_locator = "start_50"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
      end
    end
    if 390 <= chapter then
      Common.SetDigimonGraspState(399, DIGIMON_GRASP_FLAG_SCAN)
      if 50 <= chapter_progression then
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
        local org_prefix = "d"
        local org_number = 1303
        local org_locator = "start_00"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
      end
    end
    if 400 <= chapter then
      Common.SetDigimonGraspState(195, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(178, DIGIMON_GRASP_FLAG_SCAN)
      if chapter == 400 and 38 <= chapter_progression then
        Item.Add(791, 1)
      end
      if chapter == 400 and 40 <= chapter_progression then
        Item.Add(792, 1)
      end
      if chapter_progression == 61 then
        Flg.Clear("FLAG_GIMMICK_D01_020")
        Flg.Clear("FLAG_GIMMICK_D01_030")
      end
    end
    if 410 <= chapter then
      Item.Add(791, 1)
      Item.Add(792, 1)
      Common.SetDigimonGraspState(596, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(173, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(733, DIGIMON_GRASP_FLAG_SCAN)
      Flg.Clear("FLAG_GIMMICK_D01_020")
      Flg.Clear("FLAG_GIMMICK_D01_030")
      Flg.Clear("FLAG_GIMMICK_D01_040")
      Flg.Clear("FLAG_GIMMICK_D01_050")
      Flg.Clear("FLAG_GIMMICK_D01_100")
      if 110 <= chapter_progression then
        Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
        local org_prefix = "d"
        local org_number = 1204
        local org_locator = "start_50"
        local org_time_zone = Common.GetTimeZone()
        Common.SetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL, org_prefix, org_number, org_locator, org_time_zone)
      end
    end
    if 420 <= chapter then
      Common.SetDigimonGraspState(601, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(438, DIGIMON_GRASP_FLAG_SCAN)
      Common.SetDigimonGraspState(466, DIGIMON_GRASP_FLAG_SCAN)
      if 30 <= chapter_progression then
        Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      end
    end
    if chapter == 430 then
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      if chapter_progression == 10 then
        Sound.PlayBGM(206, 2)
      end
    end
    if 440 <= chapter then
      Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
      Party.Aegiomon.SetExist(true)
      Flg.Set("FLAG_IS_HAZAMA_FIRST_GATE")
      Flg.Set("FLAG_IS_TRIP_H210")
      Flg.Set("FLAG_IS_TRIP_H211")
      Flg.Set("FLAG_IS_TRIP_H212")
      Flg.Set("FLAG_IS_TRIP_H213")
      Flg.Set("FLAG_IS_TRIP_H310")
      Flg.Set("FLAG_IS_TRIP_H311")
      Flg.Set("FLAG_IS_TRIP_H312")
      Flg.Set("FLAG_IS_TRIP_H313")
      Flg.Set("FLAG_IS_TRIP_H415")
      Flg.Set("FLAG_IS_TRIP_H416")
      Flg.Set("FLAG_IS_TRIP_H417")
      Flg.Set("FLAG_IS_TRIP_H418")
      Flg.Set("FLAG_IS_TRIP_H510")
      Flg.Set("FLAG_IS_TRIP_H511")
      Flg.Set("FLAG_IS_TRIP_H512")
      Flg.Set("FLAG_IS_TRIP_H513")
      Flg.Set("FLAG_IS_TRIP_H810")
      Flg.Set("FLAG_IS_TRIP_H811")
      Flg.Set("FLAG_IS_TRIP_H812")
      Flg.Set("FLAG_IS_TRIP_H813")
      if 30 <= chapter_progression then
        Item.Add(726, 1)
        Common.SetDigimonGraspState(186, DIGIMON_GRASP_FLAG_JOIN)
      end
      if 50 <= chapter_progression then
        Flg.Set("FLAG_OPEN_TIMEJUMP")
        Flg.Set("FLAG_IS_CLEAR_S100_178")
        Flg.Set("TUT_FLAG_4721")
        Flg.Set("FLAG_SUB_100_087_015")
      end
      if 170 <= chapter_progression then
        Flg.Set("TUT_FLAG_4502")
        Flg.Set("TUT_FLAG_4530")
        Flg.Set("TUT_FLAG_4706")
        Flg.Set("TUT_FLAG_4708")
        Flg.Set("TUT_FLAG_4715")
        Flg.Set("TUT_FLAG_4721")
        Flg.Set("TUT_FLAG_4725")
        Flg.Set("TUT_FLAG_4729")
        Flg.Set("TUT_FLAG_4732")
        Flg.Set("TUT_FLAG_4733")
        Flg.Set("TUT_FLAG_4901")
        Flg.Set("TUT_FLAG_4902")
        Flg.Set("TUT_FLAG_4904")
        Flg.Set("TUT_FLAG_4905")
      end
    end
    if is_chapter_select then
      SetQuestFlag(chapter, chapter_progression)
    end
  elseif chapter >= 3000 then
    if is_chapter_select then
      if chapter == 3100 then
        if DLC.FlagCheck(1) then
          require("dep01m010")
          DLCEP001:ChapterFlagSet(chapter_progression)
        end
      elseif chapter == 3200 then
        if DLC.FlagCheck(2) then
          require("dep02m010")
          DLCEP002:ChapterFlagSet(chapter_progression)
        end
      elseif chapter == 3300 and DLC.FlagCheck(3) then
        require("dep03m010")
        DLCEP003:ChapterFlagSet(chapter_progression)
      end
    end
    if chapter == 3000 then
      Flg.Set("FLAG_DLC_PATCH001_IS_INDICATIONS")
    elseif chapter == 3010 then
      Flg.Set("FLAG_DLC_PATCH001_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH002_IS_INDICATIONS")
    elseif chapter == 3020 then
      Flg.Set("FLAG_DLC_PATCH001_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH002_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH003_IS_INDICATIONS")
    elseif chapter == 3100 then
      Flg.Set("FLAG_DLC_PATCH001_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_PATCH002_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_PATCH003_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_DLC001_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_DLC002_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_DLC003_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_EP02_001")
      Flg.Clear("FLAG_DLC_EP03_001")
    elseif chapter == 3200 then
      Flg.Set("FLAG_DLC_PATCH001_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH002_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_PATCH003_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_DLC002_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_DLC001_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_DLC003_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_EP01_001")
      Flg.Clear("FLAG_DLC_EP03_001")
    elseif chapter == 3300 then
      Flg.Set("FLAG_DLC_PATCH001_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH002_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH003_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_DLC003_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_DLC001_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_DLC002_IS_INDICATIONS")
      Flg.Clear("FLAG_DLC_EP01_001")
      Flg.Clear("FLAG_DLC_EP02_001")
    elseif chapter == 3400 then
      Flg.Set("FLAG_DLC_PATCH001_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH002_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_PATCH003_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_DLC001_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_DLC002_IS_INDICATIONS")
      Flg.Set("FLAG_DLC_DLC003_IS_INDICATIONS")
      Flg.Clear("FLAG_IS_CLEAR_DLC010_010")
      local flag_num = 70
      for flag_no = 1, flag_num do
        local flag_name = "FLAG_DLC_EP01_" .. string.format("%03d", flag_no)
        Flg.Clear(flag_name)
      end
      Flg.Clear("FLAG_DLC_EP01_BTL010")
      Flg.Clear("FLAG_DLC_EP01_BTL015")
      Flg.Clear("FLAG_DLC_EP01_BTL020")
      Flg.Clear("FLAG_DLC_EP01_BTL025")
      Flg.Clear("FLAG_DLC_EP01_BTL030")
      Flg.Clear("FLAG_DLC_EP01_BTL035")
      Flg.Clear("FLAG_DLC_EP01_BTL040")
      Flg.Clear("FLAG_DLC_EP01_BTL045")
      Flg.Clear("FLAG_DLC_EP01_BTL050")
      Flg.Clear("FLAG_IS_CLEAR_DLC020_010")
      Flg.Clear("FLAG_DLC_EP02_BTL021")
      local flag_num = 70
      for flag_no = 1, flag_num do
        local flag_name = "FLAG_DLC_EP02_" .. string.format("%03d", flag_no)
        Flg.Clear(flag_name)
      end
      Flg.Clear("FLAG_DLC_EP02_BTL010")
      Flg.Clear("FLAG_DLC_EP02_BTL020")
      Flg.Clear("FLAG_DLC_EP02_BTL030")
      Flg.Clear("FLAG_DLC_EP02_BTL040")
      Flg.Clear("FLAG_DLC_EP02_BTL050")
      Flg.Clear("FLAG_DLC_EP02_BTL060")
      Flg.Clear("FLAG_DLC_EP02_BTL070")
      Flg.Clear("FLAG_IS_CLEAR_DLC030_010")
      local flag_num = 59
      for flag_no = 1, flag_num do
        local flag_name = "FLAG_DLC_EP03_" .. string.format("%03d", flag_no)
        Flg.Clear(flag_name)
      end
      Flg.Clear("FLAG_DLC_EP03_BTL010")
      Flg.Clear("FLAG_DLC_EP03_BTL020")
      Flg.Clear("FLAG_DLC_EP03_BTL030")
      Flg.Clear("FLAG_DLC_EP03_BTL040")
      Flg.Clear("FLAG_DLC_EP03_BTL050")
      Flg.Clear("FLAG_DLC_EP03_BTL060")
      Flg.Set("FLAG_DLC_EP00_001")
      Flg.Set("FLAG_DLC_EP01_001")
      Flg.Set("FLAG_DLC_EP02_001")
      Flg.Set("FLAG_DLC_EP03_001")
    end
    for c = 10, 440, 10 do
      print("Quest: ", c)
      Quest.Finished(c)
      if c == 240 then
        Quest.Finished(c - 5)
      end
      if c == 290 then
        Quest.Finished(c - 5)
      end
    end
  else
    Flg.Set("FLAG_IS_HAZAMA_AREACHANGE_MOVE")
    Flg.Set("FLAG_IS_HAZAMA_FIRST_GATE")
    if chapter == 1000 then
      if 10 <= chapter_progression and chapter_progression <= 19 then
        Work.Set(6, 70)
        Work.Set(5, 109)
      end
      if 20 <= chapter_progression and chapter_progression <= 29 then
        Work.Set(6, 70)
        Work.Set(5, 105)
      end
      if 30 <= chapter_progression and chapter_progression <= 39 then
        Work.Set(6, 70)
        Work.Set(5, 10304)
      end
      if 40 <= chapter_progression and chapter_progression <= 49 then
        Work.Set(6, 70)
        Work.Set(5, 10103)
      end
      if chapter_progression == 11 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H210")
        Flg.Set("FLAG_IS_CLEAR_H210")
        Flg.Set("FLAG_IS_EXTRA_H210")
      end
      if chapter_progression == 21 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H211")
        Flg.Set("FLAG_IS_CLEAR_H211")
        Flg.Set("FLAG_IS_EXTRA_H211")
      end
      if chapter_progression == 31 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H212")
        Flg.Set("FLAG_IS_CLEAR_H212")
        Flg.Set("FLAG_IS_EXTRA_H212")
      end
      if chapter_progression == 41 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H213")
        Flg.Set("FLAG_IS_CLEAR_H213")
        Flg.Set("FLAG_IS_EXTRA_H213")
      end
      if chapter_progression == 12 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H210")
        Flg.Set("FLAG_IS_CLEAR_H211")
        Flg.Set("FLAG_IS_CLEAR_H212")
        Flg.Set("FLAG_IS_CLEAR_H213")
      end
      if chapter_progression == 22 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H211")
        Flg.Set("FLAG_IS_CLEAR_H210")
        Flg.Set("FLAG_IS_CLEAR_H212")
        Flg.Set("FLAG_IS_CLEAR_H213")
      end
      if chapter_progression == 32 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H212")
        Flg.Set("FLAG_IS_CLEAR_H210")
        Flg.Set("FLAG_IS_CLEAR_H211")
        Flg.Set("FLAG_IS_CLEAR_H213")
      end
      if chapter_progression == 42 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA02_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H213")
        Flg.Set("FLAG_IS_CLEAR_H210")
        Flg.Set("FLAG_IS_CLEAR_H211")
        Flg.Set("FLAG_IS_CLEAR_H212")
      end
    end
    if chapter == 1010 then
      if 10 <= chapter_progression and chapter_progression <= 19 then
        Work.Set(6, 70)
        Work.Set(5, 10502)
      end
      if 20 <= chapter_progression and chapter_progression <= 29 then
        Work.Set(6, 70)
        Work.Set(5, 10501)
      end
      if 30 <= chapter_progression and chapter_progression <= 39 then
        Work.Set(6, 71)
        Work.Set(5, 10302)
      end
      if 40 <= chapter_progression and chapter_progression <= 49 then
        Work.Set(6, 70)
        Work.Set(5, 10506)
      end
      if chapter_progression == 11 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H310")
        Flg.Set("FLAG_IS_CLEAR_H310")
        Flg.Set("FLAG_IS_EXTRA_H310")
      end
      if chapter_progression == 21 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H311")
        Flg.Set("FLAG_IS_CLEAR_H311")
        Flg.Set("FLAG_IS_EXTRA_H311")
      end
      if chapter_progression == 31 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H312")
        Flg.Set("FLAG_IS_CLEAR_H312")
        Flg.Set("FLAG_IS_EXTRA_H312")
      end
      if chapter_progression == 41 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H313")
        Flg.Set("FLAG_IS_CLEAR_H313")
        Flg.Set("FLAG_IS_EXTRA_H313")
      end
      if chapter_progression == 12 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H310")
        Flg.Set("FLAG_IS_CLEAR_H311")
        Flg.Set("FLAG_IS_CLEAR_H312")
        Flg.Set("FLAG_IS_CLEAR_H313")
      end
      if chapter_progression == 22 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H311")
        Flg.Set("FLAG_IS_CLEAR_H310")
        Flg.Set("FLAG_IS_CLEAR_H312")
        Flg.Set("FLAG_IS_CLEAR_H313")
      end
      if chapter_progression == 32 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H312")
        Flg.Set("FLAG_IS_CLEAR_H310")
        Flg.Set("FLAG_IS_CLEAR_H311")
        Flg.Set("FLAG_IS_CLEAR_H313")
      end
      if chapter_progression == 42 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA03_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H313")
        Flg.Set("FLAG_IS_CLEAR_H310")
        Flg.Set("FLAG_IS_CLEAR_H311")
        Flg.Set("FLAG_IS_CLEAR_H312")
      end
    end
    if chapter == 1020 then
      if 10 <= chapter_progression and chapter_progression <= 19 then
        Work.Set(6, 70)
        Work.Set(5, 203)
      end
      if 20 <= chapter_progression and chapter_progression <= 29 then
        Work.Set(6, 70)
        Work.Set(5, 10302)
      end
      if 30 <= chapter_progression and chapter_progression <= 39 then
        Work.Set(6, 70)
        Work.Set(5, 401)
      end
      if 40 <= chapter_progression and chapter_progression <= 49 then
        Work.Set(6, 70)
        Work.Set(5, 10405)
      end
      if chapter_progression == 11 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H415")
        Flg.Set("FLAG_IS_CLEAR_H415")
        Flg.Set("FLAG_IS_EXTRA_H415")
      end
      if chapter_progression == 21 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H416")
        Flg.Set("FLAG_IS_CLEAR_H416")
        Flg.Set("FLAG_IS_EXTRA_H416")
      end
      if chapter_progression == 31 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H417")
        Flg.Set("FLAG_IS_CLEAR_H417")
        Flg.Set("FLAG_IS_EXTRA_H417")
      end
      if chapter_progression == 41 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H418")
        Flg.Set("FLAG_IS_CLEAR_H418")
        Flg.Set("FLAG_IS_EXTRA_H418")
      end
      if chapter_progression == 12 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H415")
        Flg.Set("FLAG_IS_CLEAR_H416")
        Flg.Set("FLAG_IS_CLEAR_H417")
        Flg.Set("FLAG_IS_CLEAR_H418")
      end
      if chapter_progression == 22 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H416")
        Flg.Set("FLAG_IS_CLEAR_H415")
        Flg.Set("FLAG_IS_CLEAR_H417")
        Flg.Set("FLAG_IS_CLEAR_H418")
      end
      if chapter_progression == 32 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H417")
        Flg.Set("FLAG_IS_CLEAR_H415")
        Flg.Set("FLAG_IS_CLEAR_H416")
        Flg.Set("FLAG_IS_CLEAR_H418")
      end
      if chapter_progression == 42 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA04_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H418")
        Flg.Set("FLAG_IS_CLEAR_H415")
        Flg.Set("FLAG_IS_CLEAR_H416")
        Flg.Set("FLAG_IS_CLEAR_H417")
      end
    end
    if chapter == 1030 then
      if 10 <= chapter_progression and chapter_progression <= 19 then
        Work.Set(6, 70)
        Work.Set(5, 10404)
      end
      if 20 <= chapter_progression and chapter_progression <= 29 then
        Work.Set(6, 70)
        Work.Set(5, 10216)
      end
      if 30 <= chapter_progression and chapter_progression <= 39 then
        Work.Set(6, 70)
        Work.Set(5, 10703)
      end
      if 40 <= chapter_progression and chapter_progression <= 49 then
        Work.Set(6, 70)
        Work.Set(5, 10109)
      end
      if chapter_progression == 11 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H510")
        Flg.Set("FLAG_IS_CLEAR_H510")
        Flg.Set("FLAG_IS_EXTRA_H510")
      end
      if chapter_progression == 21 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H511")
        Flg.Set("FLAG_IS_CLEAR_H511")
        Flg.Set("FLAG_IS_EXTRA_H511")
      end
      if chapter_progression == 31 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H512")
        Flg.Set("FLAG_IS_CLEAR_H512")
        Flg.Set("FLAG_IS_EXTRA_H512")
      end
      if chapter_progression == 41 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H513")
        Flg.Set("FLAG_IS_CLEAR_H513")
        Flg.Set("FLAG_IS_EXTRA_H513")
      end
      if chapter_progression == 12 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H510")
        Flg.Set("FLAG_IS_CLEAR_H511")
        Flg.Set("FLAG_IS_CLEAR_H512")
        Flg.Set("FLAG_IS_CLEAR_H513")
      end
      if chapter_progression == 22 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H511")
        Flg.Set("FLAG_IS_CLEAR_H510")
        Flg.Set("FLAG_IS_CLEAR_H512")
        Flg.Set("FLAG_IS_CLEAR_H513")
      end
      if chapter_progression == 32 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H512")
        Flg.Set("FLAG_IS_CLEAR_H510")
        Flg.Set("FLAG_IS_CLEAR_H511")
        Flg.Set("FLAG_IS_CLEAR_H513")
      end
      if chapter_progression == 42 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA05_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H513")
        Flg.Set("FLAG_IS_CLEAR_H510")
        Flg.Set("FLAG_IS_CLEAR_H511")
        Flg.Set("FLAG_IS_CLEAR_H512")
      end
    end
    if chapter == 1040 then
      if 10 <= chapter_progression and chapter_progression <= 19 then
        Work.Set(6, 70)
        Work.Set(5, 10217)
      end
      if 20 <= chapter_progression and chapter_progression <= 29 then
        Work.Set(6, 70)
        Work.Set(5, 10403)
      end
      if 30 <= chapter_progression and chapter_progression <= 39 then
        Work.Set(6, 70)
        Work.Set(5, 10202)
      end
      if 40 <= chapter_progression and chapter_progression <= 49 then
        Work.Set(6, 70)
        Work.Set(5, 10107)
      end
      if chapter_progression == 11 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H810")
        Flg.Set("FLAG_IS_CLEAR_H810")
      end
      if chapter_progression == 21 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H811")
        Flg.Set("FLAG_IS_CLEAR_H811")
      end
      if chapter_progression == 31 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H812")
        Flg.Set("FLAG_IS_CLEAR_H812")
      end
      if chapter_progression == 41 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H813")
        Flg.Set("FLAG_IS_CLEAR_H813")
      end
      if chapter_progression == 12 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H810")
        Flg.Set("FLAG_IS_CLEAR_H811")
        Flg.Set("FLAG_IS_CLEAR_H812")
        Flg.Set("FLAG_IS_CLEAR_H813")
      end
      if chapter_progression == 22 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H811")
        Flg.Set("FLAG_IS_CLEAR_H810")
        Flg.Set("FLAG_IS_CLEAR_H812")
        Flg.Set("FLAG_IS_CLEAR_H813")
      end
      if chapter_progression == 32 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H812")
        Flg.Set("FLAG_IS_CLEAR_H810")
        Flg.Set("FLAG_IS_CLEAR_H811")
        Flg.Set("FLAG_IS_CLEAR_H813")
      end
      if chapter_progression == 42 then
        Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
        Flg.Set("FLAG_IS_HAZAMA08_FIRST_TRIP")
        Flg.Set("FLAG_IS_TRIP_H813")
        Flg.Set("FLAG_IS_CLEAR_H810")
        Flg.Set("FLAG_IS_CLEAR_H811")
        Flg.Set("FLAG_IS_CLEAR_H812")
      end
    end
  end
  Flg.Set("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE")
  if is_keep_fadeout == true then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
  end
  if enable_map_change then
  else
    SaveSequenceAfterChapterChange()
    if not is_use_bed then
      Fade_In(0, FADE_TIME)
    end
  end
end

function SaveSequenceAfterChapterChange()
  if Flg.Check("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE")
    HideMinimap(true)
    BackFade_Out(0, 0)
    Fade_Out(0, 0)
    BackFade_In(0, 0)
    WaitFrame(30)
    HideMinimap(false)
  end
end

function SetQuestFlag(chapter, progress)
  local step = {}
  local file = "m" .. string.format("%03d", chapter)
  require(file)
  if chapter == 10 then
    M010:ChapterFlagSet(progress)
  elseif chapter == 20 then
    M020:ChapterFlagSet(progress)
  elseif chapter == 30 then
    M030:ChapterFlagSet(progress)
  elseif chapter == 40 then
    M040:ChapterFlagSet(progress)
  elseif chapter == 50 then
    M050:ChapterFlagSet(progress)
  elseif chapter == 60 then
    M060:ChapterFlagSet(progress)
  elseif chapter == 70 then
    M070:ChapterFlagSet(progress)
  elseif chapter == 80 then
    M080:ChapterFlagSet(progress)
  elseif chapter == 90 then
    M090:ChapterFlagSet(progress)
  elseif chapter == 100 then
    M100:ChapterFlagSet(progress)
  elseif chapter == 110 then
    M110:ChapterFlagSet(progress)
  elseif chapter == 120 then
    M120:ChapterFlagSet(progress)
  end
  if chapter == 130 and 40 <= progress then
    step[#step + 1] = 1
    step[#step + 1] = 5
  end
  if chapter == 140 then
    if 11 <= progress then
      step[#step + 1] = 1
      step[#step + 1] = 3
      step[#step + 1] = 5
    end
    if 30 <= progress then
      step[#step + 1] = 10
    end
    if 40 <= progress then
      step[#step + 1] = 15
      step[#step + 1] = 20
      step[#step + 1] = 25
      step[#step + 1] = 30
    end
  end
  if chapter == 150 then
    M150:ChapterFlagSet(progress)
  end
  if chapter == 160 and 10 <= progress then
    step[#step + 1] = 1
  end
  if chapter == 170 then
    if 10 <= progress then
      step[#step + 1] = 1
    end
    if 30 <= progress then
      step[#step + 1] = 3
      step[#step + 1] = 5
    end
    if 31 <= progress then
      step[#step + 1] = 7
      step[#step + 1] = 10
    end
    if 50 <= progress then
      step[#step + 1] = 15
      step[#step + 1] = 16
      step[#step + 1] = 17
    end
    if 51 <= progress then
      step[#step + 1] = 20
      step[#step + 1] = 21
      step[#step + 1] = 22
    end
    if 52 <= progress then
      step[#step + 1] = 23
    end
    if 53 <= progress then
      step[#step + 1] = 24
    end
    if 60 <= progress then
      step[#step + 1] = 25
      step[#step + 1] = 26
    end
    if 71 <= progress then
      step[#step + 1] = 30
      step[#step + 1] = 31
      step[#step + 1] = 35
    end
    if 90 <= progress then
      step[#step + 1] = 40
    end
    if 91 <= progress then
      step[#step + 1] = 45
    end
    if 111 <= progress then
      step[#step + 1] = 50
      step[#step + 1] = 55
      step[#step + 1] = 60
      step[#step + 1] = 65
      step[#step + 1] = 70
      step[#step + 1] = 71
    end
    if 130 <= progress then
      step[#step + 1] = 75
      step[#step + 1] = 80
      step[#step + 1] = 85
      step[#step + 1] = 90
    end
    if 170 <= progress then
      step[#step + 1] = 95
      step[#step + 1] = 100
    end
    if 200 <= progress then
      step[#step + 1] = 105
    end
  end
  if chapter == 180 then
    if 1 <= progress then
      step[#step + 1] = 1
    end
    if 30 <= progress then
      step[#step + 1] = 5
    end
    if 31 <= progress then
      step[#step + 1] = 10
    end
    if 32 <= progress then
      step[#step + 1] = 15
      step[#step + 1] = 20
      step[#step + 1] = 25
    end
    if 60 <= progress then
      step[#step + 1] = 30
    end
    if 61 <= progress then
      step[#step + 1] = 35
    end
    if 70 <= progress then
      step[#step + 1] = 40
      step[#step + 1] = 45
    end
  end
  if chapter == 190 then
    if 10 <= progress then
      step[#step + 1] = 1
    end
    if 40 <= progress then
      step[#step + 1] = 5
      step[#step + 1] = 10
      step[#step + 1] = 15
    end
  end
  if chapter == 200 and 10 <= progress then
    step[#step + 1] = 1
  end
  if chapter == 210 then
    M210:ChapterFlagSet(progress)
  end
  if chapter == 220 and 20 <= progress then
    step[#step + 1] = 1
  end
  if chapter == 230 then
    M230:ChapterFlagSet(progress)
  end
  if chapter == 235 then
    M235:ChapterFlagSet(progress)
  end
  if chapter == 240 and 30 <= progress then
    step[#step + 1] = 1
  end
  if chapter == 250 then
    if 20 <= progress then
      step[#step + 1] = 1
    end
    if 35 <= progress then
      step[#step + 1] = 5
    end
  end
  if chapter == 260 then
    if 30 <= progress then
      step[#step + 1] = 1
    end
    if 70 <= progress then
      step[#step + 1] = 5
    end
    if 100 <= progress then
      step[#step + 1] = 10
    end
    if 120 <= progress then
      step[#step + 1] = 15
    end
    if 130 <= progress then
      step[#step + 1] = 20
    end
  end
  if chapter == 280 then
    if 11 <= progress then
      step[#step + 1] = 1
    end
    if 12 <= progress then
      step[#step + 1] = 5
      step[#step + 1] = 10
      step[#step + 1] = 15
      step[#step + 1] = 20
    end
    if 40 <= progress then
      step[#step + 1] = 25
    end
    if 50 <= progress then
      step[#step + 1] = 30
      step[#step + 1] = 35
    end
    if 110 <= progress then
      step[#step + 1] = 255
    end
  end
  if chapter == 285 then
    if 20 <= progress then
      step[#step + 1] = 1
    end
    if 30 <= progress then
      step[#step + 1] = 5
      step[#step + 1] = 10
    end
  end
  if chapter == 290 then
    M290:ChapterFlagSet(progress)
  end
  if chapter == 300 then
    M300:ChapterFlagSet(progress)
  end
  if chapter == 310 then
    M310:ChapterFlagSet(progress)
  end
  if chapter == 320 then
    M320:ChapterFlagSet(progress)
  end
  if chapter == 330 then
    if 10 <= progress then
      step[#step + 1] = 1
    end
    if 50 <= progress then
      step[#step + 1] = 5
    end
  end
  if chapter == 340 and 10 <= progress then
    step[#step + 1] = 1
    step[#step + 1] = 5
  end
  if chapter == 350 then
    M350:ChapterFlagSet(progress)
  elseif chapter == 360 then
    M360:ChapterFlagSet(progress)
  end
  if chapter == 370 then
    if 20 <= progress then
      step[#step + 1] = 1
    end
    if 100 <= progress then
      step[#step + 1] = 5
    end
  end
  if chapter == 380 and 10 <= progress then
    step[#step + 1] = 1
    step[#step + 1] = 5
  end
  if chapter == 390 then
    M390:ChapterFlagSet(progress)
  end
  if chapter == 400 then
    M400:ChapterFlagSet(progress)
  end
  if chapter == 410 then
    M410:ChapterFlagSet(progress)
  end
  if chapter == 420 then
    if 30 <= progress then
      step[#step + 1] = 1
    end
    if 30 <= progress then
      step[#step + 1] = 5
    end
    if 110 <= progress then
      Flg.Clear("FLAG_FIELD_D406_CORELIGHTOFF")
      Flg.Clear("FLAG_FIELD_D406_CORESLOW")
    end
  end
  if chapter == 440 then
    M440:ChapterFlagSet(progress)
  end
  local SubQuestTable = {}
  SubQuestTable[80] = {1}
  SubQuestTable[90] = {72}
  SubQuestTable[100] = {2}
  SubQuestTable[110] = {3, 90}
  SubQuestTable[150] = {
    38,
    41,
    152
  }
  SubQuestTable[160] = {
    39,
    42,
    77,
    78
  }
  SubQuestTable[170] = {43, 59}
  SubQuestTable[180] = {
    91,
    18,
    24,
    32,
    60,
    172,
    183
  }
  SubQuestTable[290] = {19}
  SubQuestTable[310] = {30, 33}
  SubQuestTable[330] = {
    159,
    160,
    179,
    180
  }
  SubQuestTable[360] = {173}
  SubQuestTable[400] = {176}
  SubQuestTable[440] = {
    178,
    102,
    13,
    109,
    29,
    31,
    55,
    56,
    57,
    82,
    87,
    88,
    89,
    92,
    93,
    94,
    99,
    100,
    101,
    103,
    104,
    105,
    106,
    108,
    111,
    112,
    113,
    162,
    167,
    169,
    170,
    171,
    208,
    215,
    216,
    217
  }
  local skip_queset = false
  if chapter == 120 and progress == 10 then
    skip_queset = true
  end
  if skip_queset == false then
    for c = 10, chapter - 10, 10 do
      print("Quest: ", c)
      Quest.Finished(c)
      if c == 240 then
        Quest.Finished(c - 5)
      end
      if c == 290 then
        Quest.Finished(c - 5)
      end
    end
    for _, value in pairs(step) do
      print("Chapter: ", chapter, " step: ", value)
      if value == 1 then
        Qst.Main:Start(chapter, value)
      elseif value == 255 then
        Qst.Main:End(chapter, value)
      else
        Qst.Main:Set(chapter, value)
      end
    end
  end
  if chapter == 90 and progress == 41 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
  end
  if chapter == 110 and progress == 50 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
  end
  if chapter == 130 and progress == 50 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
  end
  if chapter == 140 and progress == 50 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(53)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(119)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
  end
  if chapter == 150 and (progress == 110 or progress == 130) then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(31)
    Common.LearnTamerSkill(25)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(53)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(60)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(119)
    Common.LearnTamerSkill(103)
    Common.LearnTamerSkill(127)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
  end
  if chapter == 170 and progress == 130 or chapter == 180 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(31)
    Common.LearnTamerSkill(25)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(53)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(60)
    Common.LearnTamerSkill(87)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(119)
    Common.LearnTamerSkill(103)
    Common.LearnTamerSkill(127)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
  end
  if chapter == 190 and progress == 40 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(31)
    Common.LearnTamerSkill(25)
    Common.LearnTamerSkill(32)
    Common.LearnTamerSkill(38)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(53)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(60)
    Common.LearnTamerSkill(87)
    Common.LearnTamerSkill(73)
    Common.LearnTamerSkill(74)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(119)
    Common.LearnTamerSkill(103)
    Common.LearnTamerSkill(127)
    Common.LearnTamerSkill(140)
    Common.LearnTamerSkill(128)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
    Common.LearnTamerSkill(191)
    Common.LearnTamerSkill(170)
  end
  if chapter == 210 and progress == 18 or chapter == 260 and progress == 100 or chapter == 280 and (progress == 40 or progress == 50) or chapter == 300 and (progress == 50 or progress == 60) then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(208)
    Common.LearnTamerSkill(218)
    Common.LearnTamerSkill(204)
    Common.LearnTamerSkill(203)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(31)
    Common.LearnTamerSkill(25)
    Common.LearnTamerSkill(32)
    Common.LearnTamerSkill(38)
    Common.LearnTamerSkill(40)
    Common.LearnTamerSkill(8)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(53)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(60)
    Common.LearnTamerSkill(87)
    Common.LearnTamerSkill(73)
    Common.LearnTamerSkill(74)
    Common.LearnTamerSkill(61)
    Common.LearnTamerSkill(69)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(119)
    Common.LearnTamerSkill(103)
    Common.LearnTamerSkill(127)
    Common.LearnTamerSkill(140)
    Common.LearnTamerSkill(128)
    Common.LearnTamerSkill(120)
    Common.LearnTamerSkill(130)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
    Common.LearnTamerSkill(191)
    Common.LearnTamerSkill(170)
    Common.LearnTamerSkill(153)
    Common.LearnTamerSkill(175)
  end
  if chapter == 320 and progress == 20 or chapter == 350 and progress == 90 or chapter == 360 and progress == 10 or chapter == 390 and progress == 70 or chapter == 400 and (progress == 60 or progress == 70) or chapter == 410 and (progress == 18 or progress == 20) or chapter == 440 and progress ~= 50 and progress ~= 170 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(208)
    Common.LearnTamerSkill(218)
    Common.LearnTamerSkill(204)
    Common.LearnTamerSkill(203)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(31)
    Common.LearnTamerSkill(25)
    Common.LearnTamerSkill(32)
    Common.LearnTamerSkill(38)
    Common.LearnTamerSkill(40)
    Common.LearnTamerSkill(8)
    Common.LearnTamerSkill(18)
    Common.LearnTamerSkill(20)
    Common.LearnTamerSkill(2)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(53)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(60)
    Common.LearnTamerSkill(87)
    Common.LearnTamerSkill(73)
    Common.LearnTamerSkill(74)
    Common.LearnTamerSkill(61)
    Common.LearnTamerSkill(69)
    Common.LearnTamerSkill(56)
    Common.LearnTamerSkill(57)
    Common.LearnTamerSkill(58)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(119)
    Common.LearnTamerSkill(103)
    Common.LearnTamerSkill(127)
    Common.LearnTamerSkill(140)
    Common.LearnTamerSkill(128)
    Common.LearnTamerSkill(120)
    Common.LearnTamerSkill(130)
    Common.LearnTamerSkill(135)
    Common.LearnTamerSkill(107)
    Common.LearnTamerSkill(141)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
    Common.LearnTamerSkill(191)
    Common.LearnTamerSkill(170)
    Common.LearnTamerSkill(153)
    Common.LearnTamerSkill(175)
    Common.LearnTamerSkill(171)
    Common.LearnTamerSkill(157)
    Common.LearnTamerSkill(182)
  end
  if chapter == 440 and progress == 170 then
    Common.LearnTamerSkill(1)
    Common.LearnTamerSkill(51)
    Common.LearnTamerSkill(101)
    Common.LearnTamerSkill(151)
    Common.LearnTamerSkill(201)
    Common.LearnTamerSkill(202)
    Common.LearnTamerSkill(206)
    Common.LearnTamerSkill(216)
    Common.LearnTamerSkill(207)
    Common.LearnTamerSkill(217)
    Common.LearnTamerSkill(208)
    Common.LearnTamerSkill(218)
    Common.LearnTamerSkill(204)
    Common.LearnTamerSkill(203)
    Common.LearnTamerSkill(205)
    Common.LearnTamerSkill(215)
    Common.LearnTamerSkill(210)
    Common.LearnTamerSkill(211)
    Common.LearnTamerSkill(220)
    Common.LearnTamerSkill(212)
    Common.LearnTamerSkill(209)
    Common.LearnTamerSkill(222)
    Common.LearnTamerSkill(221)
    Common.LearnTamerSkill(224)
    Common.LearnTamerSkill(214)
    Common.LearnTamerSkill(219)
    Common.LearnTamerSkill(223)
    Common.LearnTamerSkill(15)
    Common.LearnTamerSkill(23)
    Common.LearnTamerSkill(29)
    Common.LearnTamerSkill(31)
    Common.LearnTamerSkill(25)
    Common.LearnTamerSkill(32)
    Common.LearnTamerSkill(38)
    Common.LearnTamerSkill(40)
    Common.LearnTamerSkill(8)
    Common.LearnTamerSkill(18)
    Common.LearnTamerSkill(20)
    Common.LearnTamerSkill(2)
    Common.LearnTamerSkill(41)
    Common.LearnTamerSkill(43)
    Common.LearnTamerSkill(33)
    Common.LearnTamerSkill(35)
    Common.LearnTamerSkill(36)
    Common.LearnTamerSkill(11)
    Common.LearnTamerSkill(21)
    Common.LearnTamerSkill(22)
    Common.LearnTamerSkill(26)
    Common.LearnTamerSkill(27)
    Common.LearnTamerSkill(9)
    Common.LearnTamerSkill(12)
    Common.LearnTamerSkill(13)
    Common.LearnTamerSkill(3)
    Common.LearnTamerSkill(4)
    Common.LearnTamerSkill(52)
    Common.LearnTamerSkill(53)
    Common.LearnTamerSkill(59)
    Common.LearnTamerSkill(60)
    Common.LearnTamerSkill(87)
    Common.LearnTamerSkill(73)
    Common.LearnTamerSkill(74)
    Common.LearnTamerSkill(61)
    Common.LearnTamerSkill(69)
    Common.LearnTamerSkill(56)
    Common.LearnTamerSkill(57)
    Common.LearnTamerSkill(58)
    Common.LearnTamerSkill(70)
    Common.LearnTamerSkill(71)
    Common.LearnTamerSkill(81)
    Common.LearnTamerSkill(76)
    Common.LearnTamerSkill(79)
    Common.LearnTamerSkill(84)
    Common.LearnTamerSkill(85)
    Common.LearnTamerSkill(89)
    Common.LearnTamerSkill(90)
    Common.LearnTamerSkill(92)
    Common.LearnTamerSkill(93)
    Common.LearnTamerSkill(95)
    Common.LearnTamerSkill(68)
    Common.LearnTamerSkill(77)
    Common.LearnTamerSkill(80)
    Common.LearnTamerSkill(102)
    Common.LearnTamerSkill(118)
    Common.LearnTamerSkill(119)
    Common.LearnTamerSkill(103)
    Common.LearnTamerSkill(127)
    Common.LearnTamerSkill(140)
    Common.LearnTamerSkill(128)
    Common.LearnTamerSkill(120)
    Common.LearnTamerSkill(130)
    Common.LearnTamerSkill(135)
    Common.LearnTamerSkill(107)
    Common.LearnTamerSkill(141)
    Common.LearnTamerSkill(143)
    Common.LearnTamerSkill(144)
    Common.LearnTamerSkill(137)
    Common.LearnTamerSkill(138)
    Common.LearnTamerSkill(131)
    Common.LearnTamerSkill(132)
    Common.LearnTamerSkill(129)
    Common.LearnTamerSkill(108)
    Common.LearnTamerSkill(109)
    Common.LearnTamerSkill(110)
    Common.LearnTamerSkill(124)
    Common.LearnTamerSkill(125)
    Common.LearnTamerSkill(111)
    Common.LearnTamerSkill(113)
    Common.LearnTamerSkill(105)
    Common.LearnTamerSkill(181)
    Common.LearnTamerSkill(189)
    Common.LearnTamerSkill(190)
    Common.LearnTamerSkill(168)
    Common.LearnTamerSkill(173)
    Common.LearnTamerSkill(191)
    Common.LearnTamerSkill(170)
    Common.LearnTamerSkill(153)
    Common.LearnTamerSkill(175)
    Common.LearnTamerSkill(171)
    Common.LearnTamerSkill(157)
    Common.LearnTamerSkill(182)
    Common.LearnTamerSkill(183)
    Common.LearnTamerSkill(178)
    Common.LearnTamerSkill(179)
    Common.LearnTamerSkill(174)
    Common.LearnTamerSkill(192)
    Common.LearnTamerSkill(158)
    Common.LearnTamerSkill(159)
    Common.LearnTamerSkill(162)
    Common.LearnTamerSkill(164)
    Common.LearnTamerSkill(165)
    Common.LearnTamerSkill(167)
    Common.LearnTamerSkill(185)
    Common.LearnTamerSkill(186)
    Common.LearnTamerSkill(176)
    Common.LearnTamerSkill(163)
  end
  Digimon.RestoreAllParty()
end

function ChapterSelcetMapOpen(chapter, progress)
  if 10 <= chapter then
    Map:OpenArea(1, true)
    Map:OpenArea(3, true)
    Map:OpenPlace(101, true)
    Map:OpenPlace(102, true)
    Map:OpenPlace(151, true)
    Map:OpenPlace(152, true)
    Map:OpenPlace(153, true)
    Map:OpenPlace(351, true)
  end
  if 40 <= chapter then
    Map:OpenArea(4, true)
    Map:OpenPlace(302, true)
    Map:OpenPlace(401, true)
    Map:OpenPlace(404, true)
    Map:OpenPlace(408, true)
  end
  if 50 <= chapter then
    Map:OpenPlace(103, true)
    Map:OpenPlace(301, true)
  end
  if 90 <= chapter and 60 <= progress then
    Map:ClosePlace(103, true)
  end
  if 100 <= chapter then
    Map:ClosePlace(103, true)
    if 30 <= progress then
      Map:OpenArea(2, true)
      Map:OpenPlace(201, true)
      Map:OpenPlace(250, true)
    end
  end
  if 110 <= chapter then
    Map:OpenArea(2, true)
    Map:OpenPlace(201, true)
    Map:OpenPlace(250, true)
  end
  if 150 <= chapter then
    Map:OpenArea(2, true)
    Map:OpenPlace(201, true)
    Map:OpenPlace(250, true)
    Map:CloseArea(105, false)
    Map:OpenArea(102, true)
    Map:OpenArea(105, true)
    Map:OpenPlace(10201, true)
    Map:OpenPlace(10501, true)
  end
  if 160 <= chapter then
    Map:OpenArea(106, true)
    Map:OpenPlace(10606, true)
    if chapter == 160 and progress < 40 then
      Map:OpenArea(103, true)
      Map:OpenArea(106, true)
      Map:OpenPlace(10606, true)
      Map:OpenPlace(10206, true)
    else
      Map:OpenArea(103, true)
      Map:OpenArea(106, true)
      Map:OpenPlace(10606, true)
      Map:OpenPlace(10206, true)
      Map:OpenPlace(10302, true)
    end
  end
  if 200 <= chapter then
    Map:CloseArea(3, true)
    Map:ClosePlace(103, false)
    Map:OpenArea(106, false)
    Map:OpenPlace(10601, true)
    Map:ClosePlace(10601, true)
  end
  if 230 <= chapter then
    Map:CloseArea(103, true)
    Map:CloseArea(104, true)
    Map:CloseArea(105, true)
    Map:CloseArea(106, true)
    Map:OpenPlace(10211, true)
    Map:ClosePlace(10211, false)
  end
  if 260 <= chapter then
    Map:CloseArea(103, false)
    Map:ClosePlace(10302, false)
  end
  if 290 <= chapter then
    Map.AreaKeeoOut(104, false)
    Map.PlaceKeepOut(10401, true)
    Map.PlaceKeepOut(10402, false)
  end
  if 310 <= chapter then
    Map:OpenArea(104, true)
    Map:CloseArea(104, false)
    Map:OpenPlace(10402, true)
    if 310 <= chapter and 10 < progress then
      Map:OpenArea(105, true)
      Map:CloseArea(105, false)
      Map:OpenPlace(10521, true)
    end
  end
  if 320 <= chapter then
    Map:OpenArea(105, true)
    Map:CloseArea(105, false)
    Map:OpenPlace(10521, true)
  end
  if 350 <= chapter then
    Map:OpenArea(107, true)
    Map:OpenPlace(10701, true)
    Map:CloseArea(107, true)
  end
  if 360 <= chapter then
    Map:OpenArea(107, true)
    Map:CloseArea(107, false)
    Map:OpenPlace(10701, true)
  end
  if 370 <= chapter then
    Map:OpenArea(101, true)
    Map:OpenPlace(10101, true)
  end
  if 380 <= chapter then
    Map:ClosePlace(10601, false)
  end
  if 400 <= chapter then
    if 37 <= progress then
      Flg.Set("FLAG_GIMMICK_D01_010")
      Flg.Clear("FLAG_GIMMICK_D01_011")
    end
    if 38 <= progress then
      Flg.Clear("FLAG_GIMMICK_D01_010")
      Flg.Set("FLAG_GIMMICK_D01_011")
    end
    if 40 <= progress then
      Flg.Set("FLAG_GIMMICK_D01_010")
      Flg.Clear("FLAG_GIMMICK_D01_011")
    end
    if 63 <= progress then
      Flg.Clear("FLAG_GIMMICK_D01_010")
      Flg.Set("FLAG_GIMMICK_D01_011")
    end
    if 80 <= progress then
      Map:CloseArea(106, false)
      Map:OpenPlace(10601, true)
      Map:ClosePlace(10601, false)
      Map:OpenPlace(10606, false)
    end
  end
  if 410 <= chapter then
    Map:OpenArea(106, true)
    Map:CloseArea(106, false)
    Map:OpenPlace(10601, true)
    Map:ClosePlace(10601, false)
    Map:OpenPlace(10606, false)
  end
  if 420 <= chapter then
    Map:OpenPlace(10601, false)
    Map:ClosePlace(10601, treu)
    Map:OpenPlace(10606, true)
    Map:ClosePlace(10606, false)
    Map:OpenPlace(10607, true)
    Map:ClosePlace(10607, false)
  end
end

function SetAegiomonGiftandFriendship(chapter)
  if 70 <= chapter then
    local level = 30
    local friendship = 0
    if 70 <= chapter then
      friendship = 0
    end
    if 80 <= chapter then
      friendship = friendship + 1
    end
    if 90 <= chapter then
      friendship = friendship + 1
    end
    if 100 <= chapter then
      friendship = friendship + 1
    end
    if 110 <= chapter then
      friendship = friendship + 1
    end
    if 120 <= chapter then
      friendship = friendship + 1
      level = 30
    end
    if 130 <= chapter then
      friendship = friendship + 1
    end
    if 140 <= chapter then
      friendship = friendship + 1
    end
    if 150 <= chapter then
      friendship = friendship + 1
    end
    if 160 <= chapter then
      friendship = friendship + 1
    end
    if 170 <= chapter then
      friendship = friendship + 1
      level = 35
    end
    if 180 <= chapter then
      friendship = friendship + 1
    end
    if 190 <= chapter then
      friendship = friendship + 1
    end
    if 200 <= chapter then
      friendship = friendship + 1
    end
    if 210 <= chapter then
      friendship = friendship + 1
      level = 40
    end
    if 220 <= chapter then
      friendship = friendship + 1
    end
    if 230 <= chapter then
      friendship = friendship + 1
    end
    if 240 <= chapter then
      friendship = friendship + 1
    end
    if 250 <= chapter then
      friendship = friendship + 1
    end
    if 260 <= chapter then
      friendship = friendship + 1
    end
    if 270 <= chapter then
      friendship = friendship + 1
    end
    if 280 <= chapter then
      friendship = friendship + 1
      level = 50
    end
    if 285 <= chapter then
      friendship = friendship + 1
    end
    if 290 <= chapter then
      friendship = friendship + 1
    end
    if 300 <= chapter then
      friendship = friendship + 1
    end
    if 310 <= chapter then
      friendship = friendship + 1
    end
    if 320 <= chapter then
      friendship = friendship + 1
    end
    if 330 <= chapter then
      friendship = friendship + 1
    end
    if 340 <= chapter then
      friendship = friendship + 1
    end
    if 400 <= chapter then
      friendship = friendship + 1
      level = 60
    end
    if 410 <= chapter then
      friendship = friendship + 1
    end
    if 420 <= chapter then
      friendship = friendship + 1
    end
    if 430 <= chapter then
      friendship = friendship + 35
    end
    if 440 <= chapter then
      level = 99
    end
    local friend_param = friendship * 3
    if 100 <= friend_param then
      friend_param = 100
    end
    Common.SetAegiomonFriendship(friend_param)
    Common.SetAegiomonGiftPoint(level * 1000)
  end
end
