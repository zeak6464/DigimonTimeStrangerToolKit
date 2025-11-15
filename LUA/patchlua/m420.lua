gGimText = "field_text"
M420 = {
  ID = 420,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_255 = 255
}

function M420:Event_010()
  if Flg.Check("FLAG_MAIN_19_066", "FLAG_MAIN_20_010") then
    Flg.Set("FLAG_MAIN_20_010")
    Execute("m420_010")
    Obj:new(PLAYER, ""):SetRotationY(15, 0)
    FieldObjectSync(FOR_ALL, false)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M420:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_003) then
    local npc_0027 = GetIndex(NPC, "npc_0027")
    Field.ObjectLoadMotion(NPC, npc_0027, "e002")
    Field.ObjectLoadMotion(NPC, npc_0027, "bn01")
    Field.ObjectLoadMotionBlend(NPC, npc_0027, "blend02")
    local tlk = Tlk:new("d06", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_0027, "e002", 10, 10)
    tlk:Message("f_d0607_0010_0010")
    Field.ObjectPlayMotion(NPC, npc_0027, "bn01", 20, true)
    Field.ObjectPlayMotionBlend(NPC, npc_0027, "blend02", 10, false)
    tlk:Message("f_d0607_0010_0015")
    tlk:Message("f_d0607_0010_0020")
    local result = tlk:Select(2, "f_d0607_0010_0030")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("npc_0027", true, true)
      Cam.Inst:Set(7.508, 1.28, -20.634, 9.996, 1.575, -10.954, default, 30)
      WaitFrame(15)
      Field.ObjectFrameMoveToTarget2D(PLAYER, 1, 9.805, -14.055, 2, 15)
      WaitFrame(25)
      Field.ObjectFrameMoveToTarget2D(PLAYER, 1, 8.55, -16.666, 2, 30)
      WaitFrame(15)
      Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
      WaitFrame(15)
      PlaySE(200006, 100)
      WaitFrame(30)
      Flg.Set("FLAG_MAIN_20_011")
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      Qst.Main:Set(self.ID, self.STEP_003)
      MapChange("h", 101, "start_00", false, FADE_WHITE, FADE_TIME)
    end
    tlk:EndTalk()
  end
end

function M420:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_010", "FLAG_MAIN_20_015") then
    Flg.Set("FLAG_MAIN_20_015")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field.HideGuide(true)
    SetProhibitPlayerOnlyOperate(true)
    local rotY = Field.ObjectGetRotationY(PLAYER, 1)
    Field.MovePlayerFrame(rotY, 7.5, 30)
  end
end

function M420:Event_025B()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_010", "FLAG_MAIN_20_015") then
    Field_StopBGM()
    Flg.Set("FLAG_MAIN_20_015")
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field.HideGuide(true)
    Execute("m420_015")
    Flg.Set("FLAG_MAIN_20_016")
    Flg.Set("FLAG_MAIN_20_017")
    Flg.Set("FLAG_MAIN_20_018")
    Flg.Set("FLAG_MAIN_20_019")
    Flg.Set("FLAG_MAIN_20_021")
    Flg.Set("FLAG_MAIN_20_022")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_SKIP_PLAYBGMSE_MAPCHANGE")
    MapChange("d", 1401, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_026A()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_015", "FLAG_MAIN_20_016") then
    Flg.Set("FLAG_MAIN_20_016")
  end
end

function M420:Event_026B()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_016", "FLAG_MAIN_20_017") then
    Flg.Set("FLAG_MAIN_20_017")
  end
end

function M420:Event_026C()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_017", "FLAG_MAIN_20_018") then
    Flg.Set("FLAG_MAIN_20_018")
  end
end

function M420:Event_026D()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_018", "FLAG_MAIN_20_019") then
    Flg.Set("FLAG_MAIN_20_019")
  end
end

function M420:Event_026E()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_019", "FLAG_MAIN_20_021") then
    Flg.Set("FLAG_MAIN_20_021")
  end
end

function M420:Event_027()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_021", "FLAG_MAIN_20_022") then
    SetControlScriptExternalVariable("Operation_prohibited", "On")
    Flg.Set("FLAG_MAIN_20_022")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_028()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) and Flg.Check("FLAG_MAIN_20_022", "FLAG_MAIN_20_020") then
    Fade_OutNoLoadingWithWait(FADE_WHITE, 0)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    Field.HideGuide(false)
    SetProhibitPlayerOnlyOperate(false)
    BackFade_In(FADE_WHITE, 0)
    MapChange("d", 1401, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    BackFade_In(FADE_WHITE, 0)
    Field.HideGuide(false)
    Execute("m420_020")
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    Flg.Set("FLAG_MAIN_20_026")
    MapChange("e", 7, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_003, self.STEP_005) then
    Execute("m420_030")
    Flg.Set("FLAG_MAIN_20_020")
    FieldObjectSync(FOR_ALL, false)
    Obj:new(PLAYER, ""):SetPos(0, 0.506, 9.5, true)
    Qst.Main:Set(self.ID, self.STEP_005)
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChange("h", 701, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_020", "FLAG_MAIN_20_025") then
    Flg.Set("FLAG_MAIN_20_025")
    Execute("m420_040")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(FOR_ALL, true)
    Obj:new(PLAYER, ""):SetPos(0.114, 0.506, 94.074, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_025", "FLAG_MAIN_20_030") then
    Flg.Set("FLAG_MAIN_20_030")
    Execute("m420_050")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(FOR_ALL, true)
    Obj:new(PLAYER, ""):SetPos(0.114, 0.506, 94.074, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_030", "FLAG_MAIN_20_040") then
    Flg.Set("FLAG_MAIN_20_040")
    Execute("m420_060")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(FOR_ALL, true)
    Obj:new(PLAYER, ""):SetPos(0, 0.506, 40.619, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_040", "FLAG_MAIN_20_050") then
    Flg.Set("FLAG_MAIN_20_050")
    Execute("m420_070")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(FOR_ALL, true)
    Obj:new(PLAYER, ""):SetPos(0, 0.506, -11.636, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_050", "FLAG_MAIN_20_060") then
    Flg.Set("FLAG_MAIN_20_060")
    Execute("m420_080")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(FOR_ALL, true)
    Obj:new(PLAYER, ""):SetPos(0, 0.506, -63.91, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_060", "FLAG_MAIN_20_070") then
    Flg.Set("FLAG_MAIN_20_070")
    Flg.Set("FLAG_MAIN_20_075")
    FieldObjectSync(FOR_ALL, false)
    Execute("m420_090")
    Obj:new(PLAYER, ""):SetPos(0, 0.506, 9.5, true)
    Common.LODEnable(false)
    Sound.StopBGM(1)
  end
end

function M420:Event_091()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_070", "FLAG_MAIN_20_080") then
    Flg.Set("FLAG_MAIN_20_076")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(1)
    Obj:new(NPC, "npc_aigio03"):Invisible()
    Obj:new(NPC, "npc_aigio04"):Invisible()
    Field.ObjectCancelInvisible(MOB, FOR_ALL, 0, 0, true, true)
    Obj:new(PLAYER, ""):SetPos(0.017, 0.505, 111.145, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    Field.DisableFunMotion()
    SetControlScriptExternalVariable("Cam_M420_100", "cam_01")
    Execute("m420_101")
    WaitFrame(30)
    SetControlScriptExternalVariable("PlayVoice_M420_100_01", "open")
    SetControlScriptExternalVariable("PlayVoice_M420_100_01", "start")
  end
end

function M420:Event_092()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_076", "FLAG_MAIN_20_080") then
    Obj:new(OGIM, "col_01"):Invisible(0)
    Execute("m420_102")
    Obj:new(PLAYER, ""):SetPos(0.017, 0.505, 84.212, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    SetControlScriptExternalVariable("Cam_M420_100", "cam_02")
    WaitFrame(30)
    local pos = Field.ObjectGetPosition(NPC, GetIndex(NPC, "npc_aigio03"))
    Field.PlayEffectScript("ef_e_com_115", pos.x, pos.y + 1.8, pos.z, 0, 0.5)
    PlaySE(403006, 100)
    Obj:new(NPC, "npc_aigio03"):CancelInvisible(30)
    SetControlScriptExternalVariable("PlayVoice_M420_100_02", "open")
  end
end

function M420:Event_093()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_076", "FLAG_MAIN_20_080") then
    local p_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    Field.ObjectLoadExpression(PLAYER, 1, "F01")
    Field.ObjectLoadExpression(PLAYER, 1, "F15")
    local tlk = Tlk:new("m420", 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(15)
    p_e002_01:PlayWithStartMoveMotion(15, 15)
    Field.ObjectChangeExpression(PLAYER, 1, "F15", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    WaitFrame(60)
    tlk:Message("m420_100_080")
    tlk:MessageClose()
    WaitFrame(30)
    Obj:new(NPC, "npc_aigio03"):Invisible(15)
    Obj:new(OGIM, "col_02"):Invisible(0)
    local pos = Field.ObjectGetPosition(NPC, GetIndex(NPC, "npc_aigio03"))
    Field.PlayEffectScript("ef_e_com_115", pos.x, pos.y + 1, pos.z, 0, 0.5)
    PlaySE(403006, 100)
    WaitFrame(15)
    tlk:EndTalk()
    Field.CameraSwitchChangeByFileName("h0701_railcam", "railcam_col_01_01", true)
    Obj:new(PLAYER, ""):SetPos(0.017, 0.506, 29.857, false)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    SetControlScriptExternalVariable("Cam_M420_100", "cam_03")
    WaitFrame(30)
    local pos = Field.ObjectGetPosition(NPC, GetIndex(NPC, "npc_aigio04"))
    Field.PlayEffectScript("ef_e_com_115", pos.x, pos.y + 1, pos.z, 0, 0.5)
    PlaySE(403006, 100)
    Obj:new(NPC, "npc_aigio04"):CancelInvisible(30)
    SetControlScriptExternalVariable("PlayVoice_M420_100_03", "open")
    Cam.Inst:Clear(0)
  end
end

function M420:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_070", "FLAG_MAIN_20_080") then
    Flg.Set("FLAG_MAIN_20_080")
    local p_e216 = Motion.Object:new(PLAYER, "", "e216")
    local p_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    Field.ObjectLoadExpression(PLAYER, 1, "F01")
    Field.ObjectLoadExpression(PLAYER, 1, "F15")
    WaitFrame(15)
    p_e216:Play(15, true)
    Field.ObjectChangeExpression(PLAYER, 1, "F15", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    WaitFrame(30)
    Obj:new(OGIM, "col_03"):Invisible(0)
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    Field.ObjectResetMotion(PLAYER, 1, 5, true)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(1)
    Execute("m420_103")
    Common.LODEnable(treu)
    Execute("m420_110")
    Field.CancelDisableFunMotion()
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChange("d", 406, "start_00", true, FADE_WHITE, 0)
  end
end

function M420:Event_101()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_080", "FLAG_MAIN_20_085") then
    Field.OverrideSeamlessTargetMap("t", 3001)
    Obj:new(OGIM, "obj_germination01"):Invisible(0)
    Execute("m420_112")
    Obj:new(OGIM, "obj_germination01"):CancelInvisible(0)
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChange("t", 3001, "start_00", false, FADE_WHITE, FADE_TIME)
  end
end

function M420:Event_105()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_080", "FLAG_MAIN_20_085") then
    Prcs_t3001_12GodsReliefInvisible(true)
    Field.OverrideSeamlessTargetMap("d", 406)
    Execute("m420_111")
    Prcs_t3001_12GodsReliefInvisible(false)
    Flg.Set("FLAG_GIMMICK_T0301_013")
    Flg.Set("FLAG_GIMMICK_T0301_014")
    Prcs_t3001_12GodsReliefSeting()
    Flg.Set("FLAG_MAIN_20_085")
    Flg.Clear("FLAG_FIELD_D406_CORELIGHTOFF")
    Flg.Clear("FLAG_FIELD_D406_CORESLOW")
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChange("d", 406, "start_00", true, FADE_WHITE, 0)
  end
end

function M420:Event_110()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_085", "FLAG_MAIN_20_090") then
    Flg.Set("FLAG_MAIN_20_090")
    Obj:new(OGIM, "obj_germination01"):Invisible()
    Field.OverrideSeamlessTargetMap("d", 1407)
    Execute("m420_120")
    Qst.Main:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChangeWithTimeTravel("d", 1407, "start_00", AXIS_ORIGINAL, "A2028_daft_430", NIGHT)
  end
end

function M420:Event_045_A()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_026", "FLAG_MAIN_20_040") then
    Flg.Set("FLAG_MAIN_20_025")
    Flg.Set("FLAG_MAIN_20_030")
    Flg.Set("FLAG_MAIN_20_040")
    Execute("m420_040")
    Execute("m420_050")
    Execute("m420_060")
    MapChange("t", 403, "start_00", false, FADE_WHITE, 0)
  end
end

function M420:Event_045_A02()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_040", "FLAG_MAIN_20_050") then
    Flg.Set("FLAG_MAIN_20_050")
    Execute("m420_070")
    MapChange("h", 701, "start_00", false, FADE_WHITE, 0)
  end
end

function M420:Event_045_A03()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_20_050", "FLAG_MAIN_20_060") then
    Flg.Set("FLAG_MAIN_20_060")
    Field.ObjectInvisible(MOB, FOR_ALL, 0, 0, false)
    Execute("m420_080")
    self:Event_090()
  end
end
