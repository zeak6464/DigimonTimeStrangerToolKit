gGimText = "field_text"
M430 = {}

function M430:Event_010()
  if Flg.Check("FLAG_MAIN_20_090", "FLAG_MAIN_21_010") then
    Execute("m430_010")
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChange("t", 107, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M430:Event_011()
  if Flg.Check("FLAG_MAIN_20_090", "FLAG_MAIN_21_010") then
    Execute("m430_011")
    Execute("m430_020")
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChange("e", 6, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M430:Event_013()
  if Flg.Check("FLAG_MAIN_20_090", "FLAG_MAIN_21_010") then
    Flg.Set("FLAG_MAIN_21_010")
    Flg.Set("FLAG_MAIN_21_020")
    Flg.Set("FLAG_MAIN_21_030")
    Execute("m430_021")
    self:Event_015()
  end
end

function M430:Event_015()
  if Flg.Check("FLAG_MAIN_21_030", "FLAG_MAIN_21_050") then
    Flg.Set("FLAG_IS_KEEP_BGM")
    EncountFromField(11900100, 10991, false)
  end
end

function M430:Event_020()
  if Flg.Check("FLAG_MAIN_21_040", "FLAG_MAIN_21_050") then
    Flg.Set("FLAG_MAIN_21_050")
    Flg.Set("FLAG_MAIN_21_060")
    Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
    Common.SetExistPartyAegiomon(true)
    Flg.Clear("FLAG_IS_KEEP_BGM")
    MapChangeWithTimeTravel("d", 900, "start_00", AXIS_ORIGINAL, "P2028_daft_440", NOON)
  end
end

function M430:Event_030()
  if Flg.Check("FLAG_MAIN_21_060", "FLAG_MAIN_22_010") then
    Guest.Add(GST_HEROINE)
    if not Common.ExistPartyAegiomon() then
      Party.Aegiomon.SetExist(true)
    end
    FollowerSync()
    Field.FollowerWarp()
    PlayDungeonBGM()
    Execute("m430_050")
  end
end
