function Field_PlayBGM(bgm_id)
  local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
  
  local fade_in_time = Util.SecondFromFrame(FIELD_BGM_FADEIN_FRAME)
  if not Sound.IsPlayingBGM(bgm_id) and not Flg.Check("FLAG_IS_KEEP_BGM") then
    Sound.StopBGM(fade_out_time)
    for i = 0, 89 do
      Field.StopGlobalManageSE(i, fade_out_time)
    end
    local playing_backse = Work.Get(Field_BackSE_Slot_Num)
    print(playing_backse)
    if playing_backse then
      Sound.StopAmbientSE(fade_out_time)
    end
    WaitFrame(1)
    Sound.LoadBGM(bgm_id)
    while Sound.IsLoadingBGM() do
      WaitFrame(1)
    end
    Sound.PlayBGM(bgm_id, fade_in_time)
    SelectorChange(bgm_id)
  end
  Flg.Clear("FLAG_IS_KEEP_BGM")
end

function Field_StopBGM()
  local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
  if not Flg.Check("FLAG_IS_KEEP_BGM") then
    Sound.StopBGM(fade_out_time)
    for i = 0, 89 do
      Field.StopGlobalManageSE(i, fade_out_time)
    end
    WaitFrame(1)
  end
  Flg.Clear("FLAG_IS_KEEP_BGM")
end

function PlaySE(se_id, volume_percent)
  slot_num = Sound.PlaySE(se_id, volume_percent)
  return slot_num
end

function StopSE(slot_num, fade_frame)
  Sound.StopSE(slot_num, Util.SecondFromFrame(fade_frame))
end

function Field_PlayBackSE(se_id)
  local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
  local fade_in_time = Util.SecondFromFrame(FIELD_BGM_FADEIN_FRAME)
  if not Flg.Check("FLAG_IS_KEEP_BGM") then
    Sound.StopBGM(fade_out_time)
  end
  local playing_backse = Work.Get(Field_BackSE_Slot_Num)
  if playing_backse then
    Sound.StopAmbientSE(fade_out_time)
  end
  WaitFrame(1)
  Sound.PlayAmbientSE(se_id, fade_in_time)
  Work.Set(Field_BackSE_Slot_Num, se_id)
  Flg.Clear("FLAG_IS_KEEP_BGM")
end

function Field_PlayBGM_BackSE(bgm_id, se_id, bgm_volume)
  local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
  local fade_in_time = Util.SecondFromFrame(FIELD_BGM_FADEIN_FRAME)
  bgm_volume = bgm_volume or 100
  if not Sound.IsPlayingBGM(bgm_id) and not Flg.Check("FLAG_IS_KEEP_BGM") then
    Sound.StopBGM(fade_out_time)
    WaitFrame(1)
    Sound.LoadBGM(bgm_id)
    while Sound.IsLoadingBGM() do
      WaitFrame(1)
    end
    Sound.PlayBGM(bgm_id, fade_in_time)
    SelectorChange(bgm_id)
  end
  for i = 0, 89 do
    Field.StopGlobalManageSE(i, fade_out_time)
  end
  local playing_backse = Work.Get(Field_BackSE_Slot_Num)
  if playing_backse then
    Sound.StopAmbientSE(fade_out_time)
  end
  WaitFrame(1)
  Sound.PlayAmbientSE(se_id, fade_in_time)
  Work.Set(Field_BackSE_Slot_Num, se_id)
  Flg.Clear("FLAG_IS_KEEP_BGM")
end

function WaitVoicePlay()
  WaitFrame(1)
  local waittime = 300
  while Sound.IsPlaying(CATEGORY_ID_VOICE) and not (waittime <= 0) do
    WaitFrame(1)
    if 0 < waittime then
      waittime = waittime - 1
    end
  end
  WaitFrame(3)
end

function PlayDungeonBGM()
  local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
  local fade_in_time = Util.SecondFromFrame(FIELD_BGM_FADEIN_FRAME)
  Vista.ResetSoundMonopoly(fade_out_time)
  local map_prefix = Field.GetMapPrefix()
  local map_num = Field.GetMapNumber()
  local BGM, SE = Field.GetCurrentMapDefaultBGM()
  print("===================== PlayDungeonBGM =====================")
  print("========== BGM: ", BGM, " / SE: ", SE, " ==========")
  if Flg.Check("FLAG_SKIP_CHANGE_BGM") then
    Flg.Clear("FLAG_SKIP_CHANGE_BGM")
  else
    if Flg.Check("FLAG_SKIP_PLAYBGM_MAPCHANGE") then
      print("========== FLAG_SKIP_PLAYBGM_MAPCHANGE ==========")
      Flg.Clear("FLAG_SKIP_PLAYBGM_MAPCHANGE")
      Sound.StopBGM(0)
      if SE ~= nil then
        Field_PlayBackSE(SE)
      end
    elseif BGM ~= nil and SE ~= nil then
      Field_PlayBGM_BackSE(BGM, SE)
    elseif BGM ~= nil and SE == nil then
      Field_PlayBGM(BGM)
    elseif BGM == nil and SE ~= nil then
      Field_PlayBackSE(SE)
    elseif map_prefix == "t" and map_num == 1 then
    else
      Field_StopBGM()
      Sound.StopAmbientSE(fade_out_time)
    end
    if map_prefix == "d" and map_num == 201 and not Flg.Check("FLAG_MAIN_03_470") then
      Field_StopBGM()
    end
  end
end

function PlayRestJingle()
  Common.DeleteAllLog()
  Sound.StopBGM(1)
  Sound.StopAmbientSE(1)
  WaitFrame(30)
  PlaySE(500020, 100)
  WaitFrame(120)
  Digimon.RestoreAllParty()
  INFO_WINDOW(5051)
  PlayDungeonBGM()
end

function SelectorChange(bgm)
  local map_prefix = Field.GetMapPrefix()
  local map_num = Field.GetMapNumber()
  if bgm == nil then
    return
  end
  if map_prefix == "d" and (map_num == 304 or map_num == 305) then
    print("========== Change Selector 02 ==========")
    Sound.SetBGMSelectorLabel(bgm, Selector_2)
  end
  if map_prefix == "d" and map_num == 404 then
    if Flg.Check("FLAG_MAIN_10_054", "FLAG_MAIN_10_058") then
      print("========== Change Selector 01 ==========")
      Sound.SetBGMSelectorLabel(bgm, Selector_1)
    else
      print("========== Change Selector 00 ==========")
      Sound.SetBGMSelectorLabel(bgm, Selector_0)
    end
  end
  if map_prefix == "d" and map_num == 506 then
    print("========== Change Selector 00 ==========")
    Sound.SetBGMSelectorLabel(bgm, Selector_0)
  end
end
