function Display_ThankYouForPlaying()
  Fade_Out(0, 0)
  
  Field_StopBGM()
  local fade_out_time = Util.SecondFromFrame(FIELD_BGM_FADEOUT_FRAME)
  Sound.StopAmbientSE(fade_out_time)
  Story.CreateThankYouForPlaying()
  while Story.IsLoadingThankYouForPlaying() do
    WaitFrame(1)
  end
  Story.OpenThankYouForPlaying()
  Fade_In(0, 30)
  while not Story.IsClosedThankYouForPlaying() do
    WaitFrame(1)
  end
  Fade_OutNoLoadingWithWait(0, 30)
  Story.EndThankYouForPlaying()
end
