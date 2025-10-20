require("include")

function m010_001()
  Fade_Out(1, 0)
  BackFade_Out(1, 0)
  EVENT_BEGIN()
  Talk.Load("m010")
  SetEventCutNo(2)
  if Debug.IsEventView() then
    SetTimeZone("Noon")
    SetTimeAxis("X2028_daft_10")
    LoadMap("e0001")
  end
  LoadModel("HERO_01", "pc001aa010101")
  LoadModel("HERO_02", "pc002aa010101")
  LoadModel("HERO_03", "pc001bb010101")
  LoadModel("HERO_04", "pc002bb010101")
  LoadModel("HERO_05", "pc001bb010101")
  LoadModel("HERO_06", "pc002bb010101")
  LoadModel("HERO_07", "pc001bb010101")
  LoadModel("HERO_08", "pc002bb010101")
  LoadModel("HERO_09", "pc001bb010101")
  LoadModel("HERO_10", "pc002bb010101")
  LoadModel("HERO_11", "pc001bb010101")
  LoadModel("HERO_12", "pc002bb010101")
  LoadModel("HERO_13", "pc001bb010101")
  LoadModel("HERO_14", "pc002bb010101")
  LoadModel("HERO_15", "pc001bb010101")
  LoadModel("HERO_21", "pc001ab020201")
  LoadModel("HERO_22", "pc002ab020201")
  Vista.LoadAnimationFaceBlend("HERO_01", "e561")
  Vista.LoadAnimationFaceBlend("HERO_02", "e561")
  LoadSceneViewerResource("c1.0", "e0001f_za")
  LoadSceneViewerResource("c2.0", "e0001f_za")
  LoadEnvironmentFile("c1.0", "es_m010_001_c1.0")
  LoadEnvironmentFile("c2.0", "es_m010_001_c2.0")
  WaitVistaLoad()
  Event_PlayBGM(113, 0.5, 0)
  SetPosition("HERO_01", -0.5, 4.15, 415, "LINEAR", 0, 0)
  SetRotation("HERO_01", 6.5, 6.5, 0, "LINEAR", 0, 0)
  SetPosition("HERO_21", -0.5, 4.15, 415, "LINEAR", 0, 0)
  SetRotation("HERO_21", 6.5, 6.5, 0, "LINEAR", 0, 0)
  BlendEye("HERO_01", 0, 0, "SCURVE", 0, 0)
  BlendFace("HERO_01", 0, 0, 0, false, "SCURVE", 0, 0)
  SetPosition("HERO_02", 0.5, 4.15, 415, "LINEAR", 0, 0)
  SetRotation("HERO_02", 6.5, -5.5, 0, "LINEAR", 0, 0)
  SetPosition("HERO_22", 0.5, 4.15, 415, "LINEAR", 0, 0)
  SetRotation("HERO_22", 6.5, -5.5, 0, "LINEAR", 0, 0)
  BlendEye("HERO_02", 0, 0, "SCURVE", 0, 0)
  BlendFace("HERO_02", 0, 0, 0, false, "SCURVE", 0, 0)
  SetFace("HERO_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  SetFace("HERO_02", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("HERO_01", "fn01_01", 0, true, 0)
  PlayMotion("HERO_02", "fn01_01", 0, true, 0)
  PlayMotion("HERO_21", "fn01_01", 0, true, 0)
  PlayMotion("HERO_22", "fn01_01", 0, true, 0)
  PlayMotion("HERO_03", "e012", 0, true, 0)
  PlayMotion("HERO_04", "e013_01", 0, true, 0)
  PlayMotion("HERO_05", "e008", 0, true, 0)
  PlayMotion("HERO_06", "e032", 0, true, 0)
  PlayMotion("HERO_07", "e012", 0, true, 0)
  PlayMotion("HERO_08", "e013", 0, true, 0)
  PlayMotion("HERO_09", "e007", 0, true, 0)
  PlayMotion("HERO_10", "e006", 0, true, 0)
  PlayMotion("HERO_11", "e021", 0, true, 0)
  PlayMotion("HERO_12", "e015", 0, true, 0)
  PlayMotion("HERO_13", "fn01_01", 0, true, 0)
  PlayMotion("HERO_14", "fn01_01", 0, true, 0)
  PlayMotion("HERO_15", "fn01_01", 0, true, 0)
  SetPosition("HERO_04", -3.24, 4.15, 405.918, "LINEAR", 0, 0)
  SetPosition("HERO_05", -0.984, 4.25, 400, "LINEAR", 0, 0)
  SetPosition("HERO_06", 0.859, 4.25, 400, "LINEAR", 0, 0)
  SetPosition("HERO_07", 3.055, 4.15, 405.987, "LINEAR", 0, 0)
  SetPosition("HERO_03", -5.017, 4.15, 416.572, "LINEAR", 0, 0)
  SetPosition("HERO_12", 4.998, 4.479, 417.348, "LINEAR", 0, 0)
  SetPosition("HERO_11", 2.577, 4.479, 437.933, "LINEAR", 0, 0)
  SetPosition("HERO_08", 1.823, 4.479, 458.56, "LINEAR", 0, 0)
  SetPosition("HERO_09", -1.415, 4.479, 437.874, "LINEAR", 0, 0)
  SetPosition("HERO_10", -3.624, 4.479, 448.197, "LINEAR", 0, 0)
  SetPosition("HERO_13", 3.506, 4.479, 473.361, "LINEAR", 0, 0)
  SetPosition("HERO_14", -6.213, 4.479, 461.741, "LINEAR", 0, 0)
  SetPosition("HERO_15", -2.801, 4.479, 478.997, "LINEAR", 0, 0)
  SetCamera(3.5, 5.37, 1656.905, 0, 20, "LINEAR", 0, false, 0)
  SetCameraTarget(0, 5.37, 400, "LINEAR", 0, false, 0)
  SetCamera(0, 5.37, 500, 0, 20, "LINEAR", 300, true, 0)
  SetCameraTarget(0, 5.37, 400, "LINEAR", 300, true, 0)
  SetCamera(0, 5.37, 418.783, 0, 20, "DECEL_B", 90, true, 270)
  SetCameraTarget(0, 5.37, 400, "DECEL_B", 90, true, 270)
  ModelVisible("HERO_01", false, 0, 0)
  ModelVisible("HERO_02", false, 0, 0)
  FIELD_SET()
  Vista.Play()
  Vista.SetSkip(false, true)
  SetMobTransparentRange(20, 20, 20)
  Vista.SetButtonHelpInvisible(true)
  CUT("1.0")
  SetEnv_All("c1.0", 0)
  Fade_In(1, 0)
  BackFade_In(1, 70)
  WaitFrame(110)
  Talk.OpenNarrationHomeostasis("m010_001_010", 130)
  WaitFrame(130)
  WaitFrame(10)
  Talk.OpenNarrationHomeostasis("m010_001_011", 130)
  WaitFrame(130)
  Talk.CloseNarration()
  WaitFrame(30)
  Vista.SetButtonHelpInvisible(false)
  Story.OpenAvatarSelect()
  avatar_input = -1
  result = -1
  while not correct do
    WaitFrame(Util.SecondFromFrame(1))
    avatar_input = Story.GetAvatarSelectInput()
    if avatar_input == 0 then
      result = 0
      local random = math.random(1, 9)
      if random == 1 then
        Event_PlayVoice("vo_pcm001_Accept_002", 0)
      elseif random == 2 then
        Event_PlayVoice("vo_pcm001_Joy_001", 0)
      elseif random == 3 then
        Event_PlayVoice("vo_pcm001_Happy_001", 0)
      elseif random == 4 then
        Event_PlayVoice("vo_pcm001_EventSuspicious_002", 0)
      elseif random == 5 then
        Event_PlayVoice("vo_pcm001_Encourage_001", 0)
      elseif random == 6 then
        Event_PlayVoice("vo_pcm001_Empathy_001", 0)
      elseif random == 7 then
        Event_PlayVoice("vo_pcm001_EventOther_002", 0)
      elseif random == 8 then
        Event_PlayVoice("vo_pcm001_Fun_001", 0)
      elseif random == 9 then
        Event_PlayVoice("vo_pcm001_Accept_001", 0)
      end
      Event_PlaySE(101003, 100, true, 0, 0)
      Story.PlayAvatarSelectCardIn(result)
      ModelVisible("HERO_21", false, 10, 0)
      ModelVisible("HERO_22", false, 10, 0)
      ModelVisible("HERO_03", false, 5, 0)
      ModelVisible("HERO_04", false, 5, 0)
      ModelVisible("HERO_05", false, 5, 0)
      ModelVisible("HERO_06", false, 5, 0)
      ModelVisible("HERO_07", false, 5, 0)
      ModelVisible("HERO_08", false, 5, 0)
      ModelVisible("HERO_09", false, 5, 0)
      ModelVisible("HERO_10", false, 5, 0)
      ModelVisible("HERO_11", false, 5, 0)
      ModelVisible("HERO_12", false, 5, 0)
      ModelVisible("HERO_13", false, 5, 0)
      ModelVisible("HERO_14", false, 5, 0)
      ModelVisible("HERO_15", false, 5, 0)
      SetPosition("HERO_21", 3.5, 5.37, 1656.9, "LINEAR", 0, 10)
      SetPosition("HERO_22", 3.5, 5.37, 1656.9, "LINEAR", 0, 10)
      SetPosition("HERO_04", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_05", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_06", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_07", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_03", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_12", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_11", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_08", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_09", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_10", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_13", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_14", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_15", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      ModelVisible("HERO_01", true, 10, 0)
      PlayMotion("HERO_01", "e008", 0, true, 0)
      SetFace("HERO_01", "E15_M01", 0, 1, FACE_BLENDTIME, 0)
      SetPosition("HERO_01", 0.09, 3.95, 417.14, "SCURVE", 30, 0)
      SetRotation("HERO_01", -0.5, 0, 0, "SCURVE", 30, 0)
      BlendEye("HERO_01", 23, -40, "SCURVE", 20, 0)
      BlendFace("HERO_01", -15, 45, 0, false, "SCURVE", 20, 0)
      ModelVisible("HERO_02", false, 0, 0)
      SetPosition("HERO_02", -0.2, 3.94, 417.12, "LINEAR", 30, 0)
      SetRotation("HERO_02", -1, -11, 0, "LINEAR", 30, 0)
      PlayMotion("HERO_02", "fn01_01", 0, true, 0)
      WaitFrame(30)
    elseif avatar_input == 1 then
      result = 1
      local random = math.random(1, 9)
      if random == 1 then
        Event_PlayVoice("vo_pcf001_Accept_002", 0)
      elseif random == 2 then
        Event_PlayVoice("vo_pcf001_Happy_002", 0)
      elseif random == 3 then
        Event_PlayVoice("vo_pcf001_Inspire_001", 0)
      elseif random == 4 then
        Event_PlayVoice("vo_pcf001_Joy_001", 0)
      elseif random == 5 then
        Event_PlayVoice("vo_pcf001_Accept_001", 0)
      elseif random == 6 then
        Event_PlayVoice("vo_pcf001_Encourage_001", 0)
      elseif random == 7 then
        Event_PlayVoice("vo_pcf001_Ask_001", 0)
      elseif random == 8 then
        Event_PlayVoice("vo_pcf001_EventJoy_003", 0)
      elseif random == 9 then
        Event_PlayVoice("vo_pcf001_Fun_001", 0)
      end
      Event_PlaySE(101003, 100, true, 0, 0)
      Story.PlayAvatarSelectCardIn(result)
      ModelVisible("HERO_21", false, 10, 0)
      ModelVisible("HERO_22", false, 10, 0)
      ModelVisible("HERO_03", false, 5, 0)
      ModelVisible("HERO_04", false, 5, 0)
      ModelVisible("HERO_05", false, 5, 0)
      ModelVisible("HERO_06", false, 5, 0)
      ModelVisible("HERO_07", false, 5, 0)
      ModelVisible("HERO_08", false, 5, 0)
      ModelVisible("HERO_09", false, 5, 0)
      ModelVisible("HERO_10", false, 5, 0)
      ModelVisible("HERO_11", false, 5, 0)
      ModelVisible("HERO_12", false, 5, 0)
      ModelVisible("HERO_13", false, 5, 0)
      ModelVisible("HERO_14", false, 5, 0)
      ModelVisible("HERO_15", false, 5, 0)
      SetPosition("HERO_21", 3.5, 5.37, 1656.9, "LINEAR", 0, 10)
      SetPosition("HERO_22", 3.5, 5.37, 1656.9, "LINEAR", 0, 10)
      SetPosition("HERO_04", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_05", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_06", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_07", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_03", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_12", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_11", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_08", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_09", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_10", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_13", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_14", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      SetPosition("HERO_15", 3.5, 5.37, 1656.9, "LINEAR", 0, 5)
      ModelVisible("HERO_02", true, 10, 0)
      SetPosition("HERO_02", -0.2, 3.94, 417.12, "LINEAR", 30, 0)
      SetRotation("HERO_02", -1, -11, 0, "LINEAR", 30, 0)
      PlayMotion("HERO_02", "e013", 0, true, 0)
      SetFace("HERO_02", "E15_M01", 0, 1, FACE_BLENDTIME, 0)
      BlendEye("HERO_02", 8, 37, "SCURVE", 20, 0)
      BlendFace("HERO_02", 42, -12, 0, true, "SCURVE", 20, 0)
      ModelVisible("HERO_01", false, 0, 0)
      SetPosition("HERO_01", 0.09, 3.95, 417.14, "SCURVE", 30, 0)
      SetRotation("HERO_01", -0.5, 0, 0, "SCURVE", 30, 0)
      PlayMotion("HERO_01", "fn01_01", 0, true, 0)
      WaitFrame(30)
    end
    if Work.IsPushKey("DECIDE") then
      if result == 0 then
        Flg.Clear("SELECT_FEMALE")
        Flg.Set("SELECT_MALE")
        avater_type = PLAYER_AVATAR_TYPE_HERO
        Common.SetPlayerAvatarType(avater_type)
        Common.SetPlayerDefaultName()
        WindowRenamePlayer()
        if Window.IsCanceledRenamePlayer() == false then
          Story.DecideAvatarSelect()
          WaitFrame(45)
          Window.OpenYesNoInfo(20139)
          while true do
            yesno_result = Window.GetResultYesNoInfo()
            if yesno_result == 0 then
              WaitFrame(Util.SecondFromFrame(1))
            elseif yesno_result == 1 then
              correct = true
              Event_PlayVoice("vo_pcm001_Xarts_003", 0)
              break
            else
              Story.RestartAvatarSelect()
              break
            end
          end
          Window.CloseYesNoInfo()
        end
      elseif result == 1 then
        Flg.Clear("SELECT_MALE")
        Flg.Set("SELECT_FEMALE")
        avater_type = PLAYER_AVATAR_TYPE_HEROINE
        Common.SetPlayerAvatarType(avater_type)
        Common.SetPlayerDefaultName()
        WindowRenamePlayer()
        if Window.IsCanceledRenamePlayer() == false then
          Story.DecideAvatarSelect()
          WaitFrame(45)
          Window.OpenYesNoInfo(20139)
          while true do
            yesno_result = Window.GetResultYesNoInfo()
            if yesno_result == 0 then
              WaitFrame(Util.SecondFromFrame(1))
            elseif yesno_result == 1 then
              correct = true
              Event_PlayVoice("vo_pcf001_Xarts_003", 0)
              break
            else
              Story.RestartAvatarSelect()
              break
            end
          end
          Window.CloseYesNoInfo()
        end
      end
    end
  end
  Story.CloseAvatarSelect()
  while true do
    Field.StartAutoSave(true)
    WaitFrame(1)
    save_result = Field.IsEndAutoSave()
    if save_result == 0 then
      WaitFrame(1)
      while true do
        save_result = Field.IsEndAutoSave()
        if save_result == 0 then
          WaitFrame(1)
        else
          break
        end
      end
    end
    if 0 > save_result then
      Window.OpenAutoSaveError(save_result, true)
      WaitFrame(1)
      while not Window.IsNextInfo() do
        WaitFrame(1)
      end
      Window.CloseInfo()
      WaitFrame(1)
      while not Window.IsEndCloseInfo() do
        WaitFrame(1)
      end
    else
      break
    end
  end
  Event_PlaySE(101009, 100, true, 0, 0)
  CUT("2.0")
  SetEnv_All("c2.0", 0)
  SetPosition("HERO_01", 0.01, 3.94, 416.89, "SCURVE", 30, 0)
  SetRotation("HERO_01", 0, 0, 0, "SCURVE", 30, 0)
  SetPosition("HERO_01", 0.01, 4.16, 413.12, "SCURVE", 70, 110)
  SetRotation("HERO_01", 0, 0, 0, "SCURVE", 70, 110)
  PlayMotion("HERO_01", "e561", 10, false, 0)
  Vista.PlayModelAnimationFaceBlend("HERO_01", "e561", 0, false, 0)
  BlendEye("HERO_01", 0, 0, "SCURVE", 30, 0)
  BlendFace("HERO_01", 0, 0, 0, false, "SCURVE", 30, 0)
  SetPosition("HERO_02", 0.01, 3.94, 416.89, "SCURVE", 30, 0)
  SetRotation("HERO_02", 0, 0, 0, "SCURVE", 30, 0)
  SetPosition("HERO_02", 0.01, 4.16, 413.12, "SCURVE", 70, 110)
  SetRotation("HERO_02", 0, 0, 0, "SCURVE", 70, 110)
  PlayMotion("HERO_02", "e561", 10, false, 0)
  Vista.PlayModelAnimationFaceBlend("HERO_02", "e561", 0, false, 0)
  BlendEye("HERO_02", 0, 0, "SCURVE", 30, 0)
  BlendFace("HERO_02", 0, 0, 0, false, "SCURVE", 30, 0)
  WaitFrame(140)
  ModelVisible("HERO_01", false, 4, 0)
  ModelVisible("HERO_02", false, 4, 0)
  WaitFrame(4)
  SetPosition("HERO_01", 0.01, 3.94, 90, "LINEAR", 0, 0)
  SetRotation("HERO_01", -2.5, 180, 0, "LINEAR", 0, 0)
  SetPosition("HERO_01", 0.01, 3.94, 72.5, "LINEAR", 400, 0)
  MotionSpeed(0.5)
  PlayMotion("HERO_01", "fw01_01", 0, true, 0)
  SetPosition("HERO_02", 0.01, 3.94, 90, "LINEAR", 0, 0)
  SetRotation("HERO_02", -2.5, 180, 0, "LINEAR", 0, 0)
  SetPosition("HERO_02", 0.01, 3.94, 72.5, "LINEAR", 400, 0)
  MotionSpeed(0.5)
  PlayMotion("HERO_02", "fw01_01", 0, true, 0)
  if Flg.Check("SELECT_MALE") then
    ModelVisible("HERO_01", true, 5, 0)
  else
    ModelVisible("HERO_02", true, 5, 0)
  end
  SetCamera(0, 5, 95.4, 0, 35, "LINEAR", 0, false, 0)
  SetCameraTarget(0, 5.37, 50, "LINEAR", 0, false, 0)
  SetCamera(0, 5, 95.4, -10, 35, "SCURVE", 300, false, 0)
  SetCameraTarget(0, 5.37, 50, "SCURVE", 300, false, 0)
  WaitFrame(150)
  Event_StopBGM(3, 0)
  BackFade_OutNoLoadingWithWait(1, 80)
  Fade_OutNoLoadingWithWait(1, 30)
  Story.CloseAvatarSelect()
  if Vista.IsSkipping() then
    Vista.SetSkip(false, true)
    Flg.Clear("FLAG_IS_LETTERBOX")
    print("===================================")
    print("FLAG_IS_LETTERBOX_OFF")
    print("===================================")
  else
    Vista.SetSkip(false, true)
    if param == nil then
      Flg.Clear("FLAG_IS_LETTERBOX")
      print("===================================")
      print("FLAG_IS_LETTERBOX_OFF")
      print("===================================")
    else
      print("===================================")
      print("FLAG_IS_LETTERBOX_CONTINUE")
      print("===================================")
    end
  end
  Vista.ClearMobTransparentRange()
  TalkExit()
  VistaExit()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleMob(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
  local field_player_index = Field.GetPlayerIndex()
  if field_player_index then
    Field.ObjectResetAim(FLD_OBJ_PLAYER, field_player_index, 0)
  end
  if Debug.IsEventView() then
    Event_StopBGM(0, 0)
    Event_StopAllSE(0, 0)
  end
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m010_001()
end
