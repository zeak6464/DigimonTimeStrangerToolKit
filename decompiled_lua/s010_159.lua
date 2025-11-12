S010_159 = {
  ID = 159,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_255 = 255,
  Flag001 = "FLAG_SUB_010_159_001",
  Flag002 = "FLAG_SUB_010_159_002",
  Flag003 = "FLAG_SUB_010_159_003"
}
local text_file = "s010_159"
local base = text_file .. "_"
local tlk = Tlk:new(text_file, 1, true)

function S010_159:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    local zupa_index = GetIndex(NPC, "s010_159_001")
    Field.ObjectLoadMotion(NPC, zupa_index, "bn01")
    Field.ObjectLoadMotion(NPC, zupa_index, "bn02")
    Field.ObjectLoadMotion(NPC, zupa_index, "fe02")
    Field.ObjectLoadMotion(NPC, zupa_index, "fe04")
    Field.ObjectLoadMotion(NPC, zupa_index, "fq01")
    Field.ObjectLoadMotion(NPC, zupa_index, "fq02")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e010_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(30.76, -0.25, -38.2989, 31.126, 1.363, -28.436, default, 0)
    Obj:new(PLAYER, ""):SetPos(30.39, 0, -30.61, true)
    Obj:new(PLAYER, ""):SetRotationY(15, 0)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq02", 10, 10)
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "030")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "040")
    else
      tlk:Message(base .. "050")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq02", 10, 10)
    tlk:Message(base .. "060")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
    tlk:Message(base .. "070")
    result = tlk:Select(3, base .. "080")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fe04", 10, 10)
      tlk:Message(base .. "090")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq02", 10, 10)
      tlk:Message(base .. "100")
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fe04", 10, 10)
      tlk:Message(base .. "110")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
    tlk:Message(base .. "120")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fe04", 10, 10)
    tlk:Message(base .. "130")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
    tlk:Message(base .. "140")
    tlk:EndTalk(true)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Cam.Inst:Clear(30)
    Qst.Sub:Set(self.ID, self.STEP_005)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
  end
end

function S010_159:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    local player_model_name = Common.GetPlayerModelName()
    local check = 0
    print(player_model_name)
    print(check)
    if player_model_name == "pc001ea030101" or player_model_name == "pc002ea030101" then
      check = 1
    elseif player_model_name == "pc001ea040101" or player_model_name == "pc002ea040101" then
      check = 1
    elseif player_model_name == "pc001ea050101" or player_model_name == "pc002ea050101" then
      check = 1
    elseif player_model_name == "pc001ea060101" or player_model_name == "pc002ea060101" then
      check = 1
    elseif player_model_name == "pc001ea070101" or player_model_name == "pc002ea070101" then
      check = 1
    elseif player_model_name == "pc001ea080101" or player_model_name == "pc002ea080101" then
      check = 1
    elseif player_model_name == "pc001ea090101" or player_model_name == "pc002ea090101" then
      check = 1
    elseif player_model_name == "pc001ea100101" or player_model_name == "pc002ea100101" then
      check = 1
    end
    print(check)
    if check == 1 then
      local zupa_index = GetIndex(NPC, "s010_159_001")
      local dura_index = GetIndex(NPC, "s010_159_002")
      Field.ObjectLoadMotion(NPC, zupa_index, "bn01")
      Field.ObjectLoadMotion(NPC, zupa_index, "bn02")
      Field.ObjectLoadMotion(NPC, zupa_index, "fe02")
      Field.ObjectLoadMotion(NPC, zupa_index, "fe04")
      Field.ObjectLoadMotion(NPC, zupa_index, "fq01")
      Field.ObjectLoadMotion(NPC, zupa_index, "fq02")
      Field.ObjectLoadMotion(NPC, dura_index, "bn01")
      Field.ObjectLoadMotion(NPC, dura_index, "bn02")
      Field.ObjectLoadMotion(NPC, dura_index, "fe02")
      Field.ObjectLoadMotion(NPC, dura_index, "fe04")
      Field.ObjectLoadMotion(NPC, dura_index, "fq01")
      Field.ObjectLoadMotion(NPC, dura_index, "fq02")
      Field.ObjectLoadMotion(PLAYER, 1, "e002")
      Field.ObjectLoadMotion(PLAYER, 1, "e004")
      Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
      Field.ObjectLoadMotion(PLAYER, 1, "e008")
      Field.ObjectLoadMotion(PLAYER, 1, "e010_01")
      Field.ObjectLoadMotion(PLAYER, 1, "e012")
      Field.ObjectLoadMotion(PLAYER, 1, "e013")
      Field.ObjectLoadMotion(PLAYER, 1, "e015")
      Field.ObjectLoadMotion(PLAYER, 1, "e018")
      Field.ObjectLoadMotion(PLAYER, 1, "e019")
      tlk:StartTalkAndCancelDigimonRide()
      HideMinimap(true)
      HideGuide(true)
      Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Cam.Inst:Set(30.76, -0.25, -38.2989, 31.126, 1.363, -28.436, default, 0)
      Obj:new(PLAYER, ""):SetPos(30.39, 0, -30.61, true)
      Obj:new(PLAYER, ""):SetRotationY(15, 0)
      FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fe04", 10, 10)
      tlk:Message(base .. "160")
      local result = tlk:Select(3, base .. "170")
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
      if result == RESULT_TALK00 then
        tlk:Message(base .. "180")
      elseif result == RESULT_TALK01 then
        tlk:Message(base .. "190")
      else
        tlk:Message(base .. "200")
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fe04", 10, 10)
      tlk:Message(base .. "210")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq02", 10, 10)
      tlk:Message(base .. "220")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
      tlk:Message(base .. "230")
      result = tlk:Select(3, base .. "240")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
        tlk:Message(base .. "250")
      elseif result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq01", 10, 10)
        tlk:Message(base .. "260")
      else
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fq02", 10, 10)
        tlk:Message(base .. "270")
      end
      tlk:Message(base .. "280")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, zupa_index, "fe04", 10, 10)
      tlk:Message(base .. "290")
      tlk:MessageClose()
      Flg.Set(self.Flag001)
      PlaySE(404032, 100)
      BackFade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
      FieldObjectSync(NPC, true)
      Cam.Inst:Set(32.2, 1.75, -37.115, 30.42, 0.67, -27.34, default, 0)
      WaitFrame(120)
      FadeAllInWithWait(FADE_WHITE, FADE_TIME)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, dura_index, "fe04", 10, 10)
      tlk:Message(base .. "300")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, dura_index, "fq01", 10, 10)
      tlk:Message(base .. "310")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, dura_index, "fe04", 10, 10)
      tlk:Message(base .. "320")
      Flg.Set(self.Flag003)
      MessageClose()
      BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
      Cam.Inst:Clear(30)
      Qst.Sub:Set(self.ID, self.STEP_010)
    else
      START_TALK_ACTION_AND_ZOOM("s010_159_001", true, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message(base .. "150")
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM("s010_159_001", true, true)
    end
  end
end

function S010_159:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_255) then
    local dura_index = GetIndex(NPC, "s010_159_dura_01")
    local grade_index = GetIndex(NPC, "s010_159_grade_01")
    local zuba_index = GetIndex(NPC, "s010_159_zuba_01")
    Field.ObjectLoadMotion(NPC, dura_index, "bn01")
    Field.ObjectLoadMotion(NPC, dura_index, "bn02")
    Field.ObjectLoadMotion(NPC, dura_index, "fe02")
    Field.ObjectLoadMotion(NPC, dura_index, "fe04")
    Field.ObjectLoadMotion(NPC, dura_index, "fq01")
    Field.ObjectLoadMotion(NPC, dura_index, "fq02")
    Field.ObjectLoadMotion(NPC, grade_index, "bn01")
    Field.ObjectLoadMotion(NPC, grade_index, "bn02")
    Field.ObjectLoadMotion(NPC, grade_index, "fe02")
    Field.ObjectLoadMotion(NPC, grade_index, "fe04")
    Field.ObjectLoadMotion(NPC, grade_index, "fq01")
    Field.ObjectLoadMotion(NPC, grade_index, "fq02")
    Field.ObjectLoadMotion(NPC, zuba_index, "bn01")
    Field.ObjectLoadMotion(NPC, zuba_index, "fq01")
    Field.ObjectLoadMotion(NPC, zuba_index, "fe04")
    Field.ObjectLoadMotion(PLAYER, 1, "e002")
    Field.ObjectLoadMotion(PLAYER, 1, "e004")
    Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e008")
    Field.ObjectLoadMotion(PLAYER, 1, "e010_01")
    Field.ObjectLoadMotion(PLAYER, 1, "e012")
    Field.ObjectLoadMotion(PLAYER, 1, "e013")
    Field.ObjectLoadMotion(PLAYER, 1, "e015")
    Field.ObjectLoadMotion(PLAYER, 1, "e018")
    Field.ObjectLoadMotion(PLAYER, 1, "e019")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Obj:new(PLAYER, ""):SetPos(-11.57, 0, 91.25, true)
    Obj:new(PLAYER, ""):SetRotationY(-60, 0)
    Cam.Inst:Set(-15.613, 1.73, 86.01, -10.24, 0.98, 94.5, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "330")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, dura_index, "fq02", 10, 10)
    tlk:Message(base .. "340")
    Flg.Set("FLAG_SUB_010_159_005")
    PlaySE(404005, 100)
    MessageClose()
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    FieldObjectSync(NPC, true)
    Cam.Inst:Set(-17.22, -0.02, 86.84, -9.874, 1.099, 93.54, default, 0)
    WaitFrame(30)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zuba_index, "fq01", 10, 10)
    tlk:Message(base .. "350")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, zuba_index, "fe04", 10, 10)
    tlk:Message(base .. "355")
    WaitFrame(45)
    Flg.Set("FLAG_SUB_010_159_004")
    PlaySE(404032, 100)
    MessageClose()
    Fade_OutNoLoadingWithWait(FADE_WHITE, 30)
    FieldObjectSync(NPC, true)
    Cam.Inst:Set(-17.05, 2.92, 85.83, -10.499, 0.615, 93.02, default, 0)
    WaitFrame(120)
    FadeAllInWithWait(FADE_WHITE, 30)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, grade_index, "fe02", 10, 10)
    tlk:Message(base .. "360")
    local result = tlk:Select(3, base .. "370")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, grade_index, "fq01", 10, 10)
      tlk:Message(base .. "380")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, grade_index, "fq01", 10, 10)
      tlk:Message(base .. "390")
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, grade_index, "fq01", 10, 10)
      tlk:Message(base .. "400")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, grade_index, "fe02", 10, 10)
    tlk:Message(base .. "410")
    tlk:EndTalk(true)
    Flg.Set("FLAG_IS_CLEAR_S010_159")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(NPC, true)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_FREEARENA_RELEASE_022")
    Cam.Inst:Clear(30)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    WaitFrame(30)
    AddChallengerNotice(false)
  end
end
