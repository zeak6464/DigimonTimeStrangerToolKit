S010_156 = {
  ID = 156,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flg001 = "FLAG_SUB_010_156_001",
  Flg002 = "FLAG_SUB_010_156_002",
  Flg003 = "FLAG_SUB_010_156_003"
}
local fldtxt = "s010_156"
local base = "s010_156_"
local tlk = Tlk:new(fldtxt, 1, true)

function S010_156:Event_010()
  local hiroko_index = GetIndex(NPC, "hiroko_sub")
  Field.ObjectLoadMotion(NPC, hiroko_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e002")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e004")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e006")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e008")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e010")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e018")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  Field.ObjectLoadExpression(NPC, hiroko_index, "F05")
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectLoadExpression(NPC, hiroko_index, "F01")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "010")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e008", 10, 10)
      tlk:Message(base .. "030")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e008", 10, 10)
      tlk:Message(base .. "040")
    elseif result == RESULT_TALK02 then
      Field.ObjectChangeExpression(NPC, hiroko_index, "F05", EYES_BLINK_TYPE_BLINK, true, FACE_BLENDTIME, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e018", 10, 10)
      tlk:Message(base .. "050")
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, FACE_BLENDTIME, AUTO_CANCEL_NONE, 15)
      goto lbl_501
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "063")
    Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
    tlk:Message(base .. "065")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    result = tlk:Select(3, base .. "070")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
      tlk:Message(base .. "080")
    elseif result == RESULT_TALK01 then
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
      tlk:Message(base .. "090")
    elseif result == RESULT_TALK02 then
      Field.ObjectChangeExpression(NPC, hiroko_index, "F05", EYES_BLINK_TYPE_BLINK, true, FACE_BLENDTIME, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e018", 10, 10)
      tlk:Message(base .. "100")
    end
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, FACE_BLENDTIME, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e008", 10, 10)
    tlk:Message(base .. "180")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "190")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:EndTalk(true)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Flg.Set(self.Flg001)
    Qst.Sub:Set(self.ID, self.STEP_005)
    WaitFrame(90)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChange("t", 105, "start_20", true, FADE_BLACK, FADE_TIME)
  end
  ::lbl_501::
end

function S010_156:Event_020()
  local hiroko_index = GetIndex(NPC, "sub010_156_001")
  Field.ObjectLoadMotion(NPC, hiroko_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e002")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e004")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e006")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e008")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e010")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e018")
  Field.ObjectLoadMotion(NPC, hiroko_index, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    WaitFrame(10)
    Cam.Inst:Set(8.604, 8.4, 8.04, 14.96, 11.13, 0.813, default, 0)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectLoadExpression(NPC, hiroko_index, "F01")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectLookAtTheObject(NPC, hiroko_index, PLAYER, 1, 30)
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, hiroko_index, 30)
    tlk:Message(base .. "200")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "210")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(60)
    ObjectSetRotationY(FLD_OBJ_NPC, hiroko_index, 0, 0)
    ObjectSetRotationY(PLAYER, 1, 180, 0)
    Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
    Field.ObjectPlayMotion(PLAYER, 1, "e012", 15, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message(base .. "220")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    local result = tlk:Select(3, base .. "230")
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "240")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "250")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "260")
    end
    Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
    tlk:Message(base .. "270")
    tlk:Message(base .. "280")
    Field.ObjectPlayMotion(NPC, hiroko_index, "e010", 15, true)
    tlk:Message(base .. "290")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    result = tlk:Select(3, base .. "300")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
      tlk:Message(base .. "310")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
      tlk:Message(base .. "320")
    elseif result == RESULT_TALK02 then
      Field.ObjectPlayMotion(NPC, hiroko_index, "e012", 15, true)
      tlk:Message(base .. "330")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "340")
    Field.ObjectPlayMotion(NPC, hiroko_index, "e012", 15, true)
    tlk:Message(base .. "350")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    result = tlk:Select(3, base .. "360")
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "370")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "380")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "390")
    end
    Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
    tlk:Message(base .. "400")
    tlk:Message(base .. "410")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "420")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    result = tlk:Select(3, base .. "430")
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "440")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "450")
    elseif result == RESULT_TALK02 then
      tlk:Message(base .. "460")
    end
    tlk:Message(base .. "470")
    tlk:Message(base .. "480")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "490")
    Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Flg.Set(self.Flg002)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    Cam.Inst:Clear(0)
    WaitFrame(30)
    tlk:EndTalk()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_010)
  end
end

function S010_156:Event_030()
  local hiroko_index = GetIndex(NPC, "S010_156_hiroko_01")
  if Guest.IsExistNum(3) then
    INFO_WINDOW(10050)
  elseif Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    Field.ObjectLoadMotion(NPC, hiroko_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e002")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e004")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e006")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e008")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e010")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e018")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e006")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    if not Flg.Check(self.Flg003) then
      HideMinimap(true)
      HideGuide(true)
      tlk:StartTalkAndCancelDigimonRide()
      Flg.Set("FLAG_SUB_010_156_008")
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(-40.21, 1, 7.41, -30.221, 1.5219, 7.49, default, 0)
      Obj:new(PLAYER, ""):SetPos(-31.43, 0, 8.08)
      FieldObjectSync(FOR_ALL, false)
      Obj:new(PLAYER, ""):SetRotationY(270, 0)
      WaitFrame(1)
      Obj:new(NPC, "S010_156_hiroko_01"):SetRotationY(230, 0)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Field_PlayBGM(305)
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "500")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e012", 10, 10)
      tlk:Message(base .. "510")
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      local result = tlk:Select(3, base .. "520")
      Field.ObjectLookAtTheObject(PLAYER, 1, NPC, hiroko_index, 15)
      WaitFrame(15)
      Field.ObjectLookAtTheObject(NPC, hiroko_index, PLAYER, 1, 15)
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "530")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "540")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "550")
      end
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      Flg.Set(self.Flg003)
      local slot_id = PlaySE(405002, 100)
      Quake_Start(0.1, 0.3, 20)
      Field.ObjectResetAim(PLAYER, 1, 15)
      Field.ObjectResetAim(NPC, hiroko_index, 15)
      Field.ObjectPlayMotion(NPC, hiroko_index, "e006", 15, true)
      Field.ObjectPlayMotion(PLAYER, 1, "e006", 15, true)
      WaitFrame(20)
      StopSE(slot_id, 30)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Obj:new(PLAYER, ""):SetRotationY(330, 0)
      Obj:new(NPC, "S010_156_hiroko_01"):SetRotationY(330, 0)
      FieldObjectSync(FOR_ALL, false)
      Cam.Inst:Set(-34.656, 1.605, 0.155, -31.433, 1.3518, 9.62, default, 0)
      Obj:new(PLAYER, ""):SetPos(-32.711, 0, 7.95)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      Field.ObjectPlayMotion(PLAYER, 1, "e018", 15, true)
      WaitFrame(15)
      tlk:Message(base .. "560")
      Flg.Set("FLAG_SUB_010_156_007")
      FieldObjectSync(FOR_ALL, false)
      PlaySE(404038, 100)
      WaitFrame(60)
      tlk:EndTalk(true)
      PlaySE(200006, 100)
      Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      MapChange("h", 420, "start_20", true, FADE_WHITE, FADE_TIME)
    end
  end
end

function S010_156:Event_035()
  local hiroko_index = GetIndex(NPC, "s010_156_hiroko")
  local boss_index = GetIndex(NPC, "s010_156_boss")
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) and Flg.Check(self.Flg003) and not Flg.Check("FLAG_SUB_010_156_004") then
    local o_index = GetIndex(NPC, "s010_156_omega")
    local a_index = GetIndex(NPC, "s010_156_arufa")
    local z_index = GetIndex(NPC, "s010_156_zies")
    local g_index = GetIndex(NPC, "s010_156_ganku")
    local l_index = GetIndex(NPC, "s010_156_load")
    local d_index = GetIndex(NPC, "s010_156_duke")
    local m_index = GetIndex(NPC, "s010_156_magna")
    local e_index = GetIndex(NPC, "s010_156_exa")
    local u_index = GetIndex(NPC, "s010_156_ulforce")
    local c_index = GetIndex(NPC, "s010_156_craniam")
    local s_index = GetIndex(NPC, "s010_156_sleip")
    local dy_index = GetIndex(NPC, "s010_156_dynas")
    local du_index = GetIndex(NPC, "s010_156_duft")
    Field.ObjectLoadMotion(NPC, hiroko_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e002")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e004")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e006")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e008")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e010")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e018")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Field.ObjectLoadMotion(NPC, boss_index, "bn01")
    Field.ObjectLoadMotion(NPC, boss_index, "bn02")
    Field.ObjectLoadMotion(NPC, boss_index, "fq01")
    Field.ObjectLoadMotion(NPC, boss_index, "fq02")
    Field.ObjectLoadMotion(NPC, boss_index, "fe02")
    Field.ObjectLoadMotion(NPC, boss_index, "fe04")
    Field.ObjectLoadMotion(NPC, o_index, "bn01")
    Field.ObjectLoadMotion(NPC, o_index, "fq01")
    Field.ObjectLoadMotion(NPC, o_index, "fq02")
    Field.ObjectLoadMotion(NPC, a_index, "bn01")
    Field.ObjectLoadMotion(NPC, a_index, "fq01")
    Field.ObjectLoadMotion(NPC, z_index, "bn01")
    Field.ObjectLoadMotion(NPC, z_index, "fe02")
    Field.ObjectLoadMotion(NPC, g_index, "bn01")
    Field.ObjectLoadMotion(NPC, g_index, "fe02")
    Field.ObjectLoadMotion(NPC, l_index, "bn01")
    Field.ObjectLoadMotion(NPC, l_index, "fq01")
    Field.ObjectLoadMotion(NPC, d_index, "bn01")
    Field.ObjectLoadMotion(NPC, d_index, "fq01")
    Field.ObjectLoadMotion(NPC, m_index, "bn01")
    Field.ObjectLoadMotion(NPC, m_index, "fe02")
    Field.ObjectLoadMotion(NPC, e_index, "bn01")
    Field.ObjectLoadMotion(NPC, e_index, "fq01")
    Field.ObjectLoadMotion(NPC, u_index, "bn01")
    Field.ObjectLoadMotion(NPC, u_index, "fe02")
    Field.ObjectLoadMotion(NPC, c_index, "bn01")
    Field.ObjectLoadMotion(NPC, c_index, "fe02")
    Field.ObjectLoadMotion(NPC, s_index, "bn01")
    Field.ObjectLoadMotion(NPC, s_index, "fq01")
    Field.ObjectLoadMotion(NPC, dy_index, "bn01")
    Field.ObjectLoadMotion(NPC, dy_index, "fq01")
    Field.ObjectLoadMotion(NPC, du_index, "bn01")
    Field.ObjectLoadMotion(NPC, du_index, "fq01")
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 15, true)
    local add_x = 0.77
    local add_y = 17.999
    local add_z = -2.5
    HideMinimap(true)
    HideGuide(true)
    Field_StopBGM()
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectResetAim(PLAYER, 1, 0)
    Cam.Inst:Set(-0.63, 22.146, 7, -0.754, 18.31, 16.235, default, 0)
    Obj:new(PLAYER, ""):SetPos(-2.44 + add_x, 0.001 + add_y, 15.52 + add_z, true)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    WaitFrame(5)
    Field_InvisibleFollowerAllGuest(0, 15, false)
    Field_InvisibleFollowerAllPartyMember(0, 15, false)
    Field_PlayBGM(309)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, boss_index, "fe02", 10, 10)
    tlk:Message(base .. "570")
    Field.ObjectLookAtTheObject(NPC, hiroko_index, PLAYER, 1, 30)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "580")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, boss_index, "fe04", 10, 10)
    tlk:Message(base .. "590")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e010", 10, 10)
    tlk:Message(base .. "600")
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
    tlk:Message(base .. "605")
    tlk:Message(base .. "610")
    Field.ObjectResetAim(NPC, hiroko_index, 15)
    Field.ObjectPlayMotion(NPC, hiroko_index, "e006", 15, true)
    tlk:Message(base .. "620")
    Field_StopBGM()
    tlk:EndTalk(true)
    Flg.Set("FLAG_SUB_010_156_006")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Field_InvisibleFollowerAllGuest(0, 15, false)
    Field_InvisibleFollowerAllPartyMember(0, 15, false)
    Obj:new(PLAYER, ""):SetPos(-2.88 + add_x, 0.001 + add_y, 15.52 + add_z, true)
    FieldObjectSync(NPC, true)
    Cam.Inst:Set(-0.79, 22.147, 7.58, -1.137, 18.31, 16.804, default, 0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:StartTalkAndCancelDigimonRide()
    Field_PlayBGM(401)
    tlk:Message(base .. "630")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, o_index, "fq01", 10, 10)
    tlk:Message(base .. "640")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, o_index, "fq02", 10, 10)
    tlk:Message(base .. "650")
    local cnt = 0
    while true do
      if cnt == 0 then
        result = tlk:Select(4, base .. "660")
        if result == RESULT_TALK00 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, o_index, "fq01", 10, 10)
          tlk:Message(base .. "670")
          Guest.Add(GST_S010_156_OMEGA)
          break
        elseif result == RESULT_TALK01 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, d_index, "fq01", 10, 10)
          tlk:Message(base .. "680")
          Guest.Add(GST_S010_156_DUKE)
          break
        elseif result == RESULT_TALK02 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, m_index, "fe02", 10, 10)
          tlk:Message(base .. "690")
          Guest.Add(GST_S010_156_MAGNA)
          break
        elseif result == RESULT_TALK03 then
          cnt = 1
          tlk:Message(base .. "700")
        end
      elseif cnt == 1 then
        result = tlk:Select(4, base .. "710")
        if result == RESULT_TALK00 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, dy_index, "fq01", 10, 10)
          tlk:Message(base .. "720")
          Guest.Add(GST_S010_156_DYNAS)
          break
        elseif result == RESULT_TALK01 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, l_index, "fq01", 10, 10)
          tlk:Message(base .. "730")
          Guest.Add(GST_S010_156_LOADKNIGHT)
          break
        elseif result == RESULT_TALK02 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, u_index, "fe02", 10, 10)
          tlk:Message(base .. "740")
          Guest.Add(GST_S010_156_ULFORCEVDRA)
          break
        elseif result == RESULT_TALK03 then
          cnt = 2
          tlk:Message(base .. "750")
        end
      elseif cnt == 2 then
        result = tlk:Select(4, base .. "760")
        if result == RESULT_TALK00 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, c_index, "fe02", 10, 10)
          tlk:Message(base .. "770")
          Guest.Add(GST_S010_156_CRANIA)
          break
        elseif result == RESULT_TALK01 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, s_index, "fq01", 10, 10)
          tlk:Message(base .. "780")
          Guest.Add(GST_S010_156_SLEIP)
          break
        elseif result == RESULT_TALK02 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, du_index, "fq01", 10, 10)
          tlk:Message(base .. "790")
          Guest.Add(GST_S010_156_DUFT)
          break
        elseif result == RESULT_TALK03 then
          cnt = 3
          tlk:Message(base .. "800")
        end
      elseif cnt == 3 then
        result = tlk:Select(5, base .. "810")
        if result == RESULT_TALK00 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, e_index, "fq01", 10, 10)
          tlk:Message(base .. "820")
          Guest.Add(GST_S010_156_EXA)
          break
        elseif result == RESULT_TALK01 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, g_index, "fe02", 10, 10)
          tlk:Message(base .. "830")
          Guest.Add(GST_S010_156_GANKOO)
          break
        elseif result == RESULT_TALK02 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, z_index, "fe02", 10, 10)
          tlk:Message(base .. "840")
          Guest.Add(GST_S010_156_JES)
          break
        elseif result == RESULT_TALK03 then
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, a_index, "fq01", 10, 10)
          tlk:Message(base .. "850")
          Guest.Add(GST_S010_156_ALPHA)
          break
        elseif result == RESULT_TALK04 then
          cnt = 0
          tlk:Message(base .. "860")
        end
      end
    end
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(20101560, 20471, false)
  end
end

function S010_156:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) and Flg.Check("FLAG_SUB_010_156_004") then
    Guest.Delete(GST_S010_156_OMEGA)
    Guest.Delete(GST_S010_156_DUKE)
    Guest.Delete(GST_S010_156_MAGNA)
    Guest.Delete(GST_S010_156_DYNAS)
    Guest.Delete(GST_S010_156_LOADKNIGHT)
    Guest.Delete(GST_S010_156_ULFORCEVDRA)
    Guest.Delete(GST_S010_156_CRANIA)
    Guest.Delete(GST_S010_156_SLEIP)
    Guest.Delete(GST_S010_156_DUFT)
    Guest.Delete(GST_S010_156_EXA)
    Guest.Delete(GST_S010_156_GANKOO)
    Guest.Delete(GST_S010_156_JES)
    Guest.Delete(GST_S010_156_ALPHA)
    HideMinimap(true)
    HideGuide(true)
    Field_StopBGM()
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "870")
    tlk:EndTalk(true)
    Flg.Set("FLAG_SUB_010_156_005")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    PlaySE(200006, 100)
    Fade.Out(1, Util.SecondFromFrame(15))
    while not Fade.AllIsEndType(1) do
      WaitFrame(1)
    end
    MapChange("t", 107, "start_30", false, FADE_WHITE, FADE_TIME)
  end
end

function S010_156:Event_045()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local hiroko_index = GetIndex(NPC, "S010_156_hiroko_01")
    local aigio_index = GetIndex(NPC, "S010_156_aigio_01")
    Field.ObjectLoadMotion(NPC, hiroko_index, "fn01_01")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e002")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e004")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e006")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e008")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e010")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e018")
    Field.ObjectLoadMotion(NPC, hiroko_index, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Field.ObjectLoadExpression(NPC, hiroko_index, "F04")
    if Flg.Check("FLAG_SUB_010_156_005") then
      HideMinimap(true)
      HideGuide(true)
      tlk:StartTalkAndCancelDigimonRide()
      Cam.Inst:Set(-28.038, 0.5548, 0.04, -33.36, 1.5873, 8.44, default, 0)
      Obj:new(NPC, "S010_156_hiroko_01"):SetRotationY(240, 0)
      Obj:new(PLAYER, ""):SetRotationY(60, 0)
      Field.ObjectPlayMotion(NPC, hiroko_index, "fn01_01", 0, true)
      Obj:new(NPC, "S010_156_hiroko_01"):ChangeExpression("F04", EYES_BLINK_TYPE_BLINK, false, 0)
      WaitFrame(10)
      FadeAllInWithWait(FADE_WHITE, FADE_TIME)
      Field.ObjectChangeExpression(NPC, hiroko_index, "F04", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      tlk:Message(base .. "880")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
      tlk:Message(base .. "890")
      Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
      tlk:Message(base .. "900")
      Field.ObjectChangeExpression(NPC, hiroko_index, "F04", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      WaitFrame(30)
      local result = tlk:Select(3, base .. "910")
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "920")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "930")
      elseif result == RESULT_TALK02 then
        tlk:Message(base .. "940")
      end
      Field_PlayBGM(402)
      Field.ObjectPlayMotion(NPC, hiroko_index, "e008", 15, true)
      tlk:Message(base .. "950")
      tlk:Message(base .. "960")
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      result = tlk:Select(3, base .. "970")
      WaitFrame(15)
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotion(NPC, hiroko_index, "e002", 15, true)
        tlk:Message(base .. "980")
      elseif result == RESULT_TALK01 then
        Field.ObjectPlayMotion(NPC, hiroko_index, "e002", 15, true)
        tlk:Message(base .. "990")
      elseif result == RESULT_TALK02 then
        Field.ObjectPlayMotion(NPC, hiroko_index, "e012", 15, true)
        tlk:Message(base .. "1000")
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e008", 10, 10)
      tlk:Message(base .. "1010")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e002", 10, 10)
      tlk:Message(base .. "1020")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, hiroko_index, "e012", 10, 10)
      tlk:Message(base .. "1030")
      Field.ObjectChangeExpression(NPC, hiroko_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      Flg.Set("FLAG_IS_CLEAR_S010_156")
      tlk:MessageClose()
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, false)
      Cam.Inst:Clear(0)
      SetFollowerCameraOperateRotation(0, 60, 0)
      PlayerObjectResetAim()
      WaitFrame(30)
      tlk:EndTalk()
      Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:End(self.ID, self.STEP_255)
      Field_StopBGM()
    end
  end
end
