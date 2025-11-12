S200_150 = {
  ID = 150,
  STEP_001 = 1,
  STEP_003 = 3,
  STEP_005 = 5,
  STEP_255 = 255,
  Flag001 = "FLAG_IS_S200_150_001",
  Flag002 = "FLAG_IS_S200_150_002",
  Flag003 = "FLAG_IS_S200_150_003",
  Flag004 = "FLAG_IS_S200_150_004",
  Flag005 = "FLAG_IS_S200_150_005",
  Flag006 = "FLAG_IS_S200_150_006"
}
local text_file = "s200_150"
local base = text_file .. "_"
local tlk = Tlk:new(text_file, 1, true)

function S200_150:Event_010()
  local wanya_index = GetIndex(NPC, "s200_150_001")
  Field.ObjectLoadMotion(NPC, wanya_index, "bn01")
  Field.ObjectLoadMotion(NPC, wanya_index, "fe02")
  Field.ObjectLoadMotion(NPC, wanya_index, "fe04")
  Field.ObjectLoadMotion(NPC, wanya_index, "fq01")
  Field.ObjectLoadMotion(NPC, wanya_index, "fq02")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
    tlk:Message(base .. "010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
    tlk:Message(base .. "020")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
    tlk:Message(base .. "030")
    tlk:EndTalk(true)
    Qst.Sub:Start(self.ID, 1, false)
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:Set(self.ID, self.STEP_005)
    Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    goto lbl_613
  elseif Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_003) then
    tlk:StartTalkAndCancelDigimonRide()
    local pc = Common.GetPlayerModelName()
    local heroine_index = Field.GetFollowerIndexByGuestID(GST_HEROINE)
    local aegio_index = Field.GetFollowerIndexForAegiomon()
    local heroine = Field.ObjectGetModelName(FLD_OBJ_FOLLOWER, heroine_index)
    local aegio = Field.ObjectGetModelName(FLD_OBJ_FOLLOWER, aegio_index)
    local num = 0
    if pc == "pc001qa010101" or pc == "pc002qa010101" then
      num = num + 1
    end
    if heroine == "npc001qa010101" then
      num = num + 1
    end
    if aegio == "chr183qa010101" then
      num = num + 1
    end
    if num == 0 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
      tlk:Message(base .. "030")
      goto lbl_610
    elseif num == 1 or num == 2 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
      tlk:Message(base .. "050")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
      tlk:Message(base .. "060")
      goto lbl_610
    elseif num == 3 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
      tlk:Message(base .. "040")
      local result = tlk:Select(3, base .. "070")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fe02", 10, 10)
        tlk:Message(base .. "080")
      elseif result == RESULT_TALK01 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
        tlk:Message(base .. "090")
        goto lbl_610
      else
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
        tlk:Message(base .. "100")
        goto lbl_610
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
      tlk:Message(base .. "110")
      result = tlk:Select(2, base .. "120")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fe02", 10, 10)
        tlk:Message(base .. "130")
        Qst.Sub:Set(self.ID, self.STEP_003)
      else
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
        tlk:Message(base .. "140")
        Qst.Sub:Set(self.ID, self.STEP_003)
        goto lbl_610
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
      tlk:Message(base .. "150")
      local tlk = Tlk:new(text_file, 1, true, false)
      tlk:EndTalk(true)
      END_TALK_ACTION_AND_ZOOM("s200_150_001", true, true)
      Flg.Set("FLAG_IS_S200_150_007")
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      MapChange("d", 301, "start_21", true, FADE_BLACK, FADE_TIME)
    end
  elseif Qst.Sub:Check(self.ID, self.STEP_003, self.STEP_255) then
    local pc = Common.GetPlayerModelName()
    local heroine_index = Field.GetFollowerIndexByGuestID(GST_HEROINE)
    local aegio_index = Field.GetFollowerIndexForAegiomon()
    tlk:StartTalkAndCancelDigimonRide()
    local num = 0
    if pc == "pc001qa010101" or pc == "pc002qa010101" then
      num = num + 1
    end
    if num == 0 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
      tlk:Message(base .. "030")
      goto lbl_610
    elseif num == 2 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
      tlk:Message(base .. "050")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
      tlk:Message(base .. "060")
      goto lbl_610
    elseif 1 <= num then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
      tlk:Message(base .. "110")
      local result = tlk:Select(2, base .. "120")
      WaitFrame(15)
      if result == RESULT_TALK00 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fe02", 10, 10)
        tlk:Message(base .. "130")
      else
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq02", 10, 10)
        tlk:Message(base .. "140")
        goto lbl_610
      end
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
      tlk:Message(base .. "150")
      Flg.Set("FLAG_IS_S200_150_007")
      local tlk = Tlk:new(text_file, 1, true, false)
      END_TALK_ACTION_AND_ZOOM("s200_150_001", true, true)
      tlk:EndTalk(true)
      Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
      MapChange("d", 301, "start_21", true, FADE_BLACK, FADE_TIME)
    end
  end
  ::lbl_610::
  tlk:EndTalk()
  ::lbl_613::
end

function S200_150:Event_020()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_IS_S200_150_007") and not Flg.Check(self.Flag006) and not Flg.Check(self.Flag001) then
    local seadora_index = GetIndex(NPC, "S200_150_seadora_02")
    local inori_index = GetIndex(NPC, "s200_150_inori_01")
    local wanya_index = GetIndex(NPC, "s200_150_wanya_01")
    local aigio_index = GetIndex(NPC, "s200_150_aigio_01")
    Field.ObjectLoadMotion(NPC, seadora_index, "bn01")
    Field.ObjectLoadMotion(NPC, seadora_index, "fe02")
    Field.ObjectLoadMotion(NPC, seadora_index, "f002")
    Field.ObjectLoadMotion(NPC, seadora_index, "fe04")
    Field.ObjectLoadMotion(NPC, seadora_index, "fq01")
    Field.ObjectLoadMotion(NPC, seadora_index, "fq02")
    require("S200_150")
    S200_150.loadmotion()
    HideMinimap(true)
    HideGuide(true)
    Obj:new(PLAYER, ""):SetPos(47.5156, 1.4734, 70.52)
    Cam.Inst:Set(52.41, 1.4632, 74.65, 44.81, 2.941, 68.33, default, 0)
    Field_InvisibleAllSymbolEnemy(0, 0, false)
    tlk:StartTalkAndCancelDigimonRide()
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    WaitFrame(20)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, wanya_index, "fe02", 15, true)
    tlk:Message(base .. "160")
    Field.ObjectPlayMotion(NPC, aigio_index, "e004", 15, true)
    tlk:Message(base .. "170")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, inori_index, "e002", 10, 10)
    tlk:Message(base .. "180")
    local result = tlk:Select(3, base .. "190")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, inori_index, "e014", 10, 10)
      tlk:Message(base .. "200")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotion(NPC, inori_index, "e008", 15, true)
      tlk:Message(base .. "210")
    else
      Field.ObjectPlayMotion(NPC, inori_index, "e008", 15, true)
      tlk:Message(base .. "220")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 15, true)
    tlk:Message(base .. "230")
    Cam.Inst:Set(52.09, 1.363, 74.375, 44.59, 3.76, 68.21, default, 30)
    ObjectTurnToObject(NPC, "s200_150_aigio_01", NPC, "S200_150_seadora_01")
    ObjectTurnToObject(NPC, "s200_150_inori_01", NPC, "S200_150_seadora_01")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, aigio_index, "e002_01", 10, 10)
    tlk:Message(base .. "240")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, inori_index, "e006", 10, 10)
    tlk:Message(base .. "250")
    Flg.Set(self.Flag006)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    Obj:new(NPC, "s200_150_inori_01"):SetRotationY(120, 0)
    Cam.Inst:Set(51.05, 2.514, 75.404, 45.783, 2.412, 66.9, default, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, seadora_index, "f002", 15, true)
    Field.ObjectPlayMotion(NPC, inori_index, "e006", 15, true)
    Field.ObjectPlayMotion(NPC, aigio_index, "e018", 15, true)
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 15, true)
    tlk:Message(base .. "290")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(22001500, 10377, false)
  end
end

function S200_150:Event_030()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flag001, self.Flag002) then
    require("S200_150")
    S200_150.loadmotion()
    HideMinimap(true)
    HideGuide(true)
    local waru_index = GetIndex(NPC, "S200_150_warudora_02")
    local mega_index = GetIndex(NPC, "S200_150_megadora_02")
    local seadora_index = GetIndex(NPC, "S200_150_seadora_02")
    local inori_index = GetIndex(NPC, "s200_150_inori_01")
    local wanya_index = GetIndex(NPC, "s200_150_wanya_01")
    local aigio_index = GetIndex(NPC, "s200_150_aigio_01")
    Field.ObjectLoadMotion(NPC, seadora_index, "bn02")
    Field.ObjectLoadMotion(NPC, seadora_index, "fq02")
    Field.ObjectLoadMotion(NPC, waru_index, "bn01")
    Field.ObjectLoadMotion(NPC, waru_index, "bn02")
    Field.ObjectLoadMotion(NPC, waru_index, "fe02")
    Field.ObjectLoadMotion(NPC, waru_index, "f002")
    Field.ObjectLoadMotion(NPC, waru_index, "fe04")
    Field.ObjectLoadMotion(NPC, waru_index, "fq01")
    Field.ObjectLoadMotion(NPC, waru_index, "fq02")
    Field.ObjectLoadMotion(NPC, mega_index, "bn01")
    Field.ObjectLoadMotion(NPC, mega_index, "bn02")
    Field.ObjectLoadMotion(NPC, mega_index, "fe02")
    Field.ObjectLoadMotion(NPC, mega_index, "f002")
    Field.ObjectLoadMotion(NPC, mega_index, "fe04")
    Field.ObjectLoadMotion(NPC, mega_index, "fq01")
    Field.ObjectLoadMotion(NPC, mega_index, "fq02")
    tlk:StartTalkAndCancelDigimonRide()
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, seadora_index, "bn02", 15, true)
    tlk:Message(base .. "300")
    Flg.Set(self.Flag002)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Set(52.09, 1.363, 74.375, 44.59, 3.76, 68.21, default, 0)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, inori_index, "fn01_01", 15, true)
    Field.ObjectPlayMotion(NPC, aigio_index, "fn01_01", 15, true)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 15, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fe02", 10, 10)
    tlk:Message(base .. "310")
    Field.ObjectPlayMotion(NPC, inori_index, "e035", 15, true)
    tlk:Message(base .. "320")
    Flg.Set("FLAG_IS_S200_150_008")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(51.49, 1.864, 74.59, 45.93, 3.47, 66.44, default, 0)
    FieldObjectSync(FOR_ALL, false)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, aigio_index, "e018", 15, true)
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 15, true)
    Field.ObjectPlayMotion(NPC, mega_index, "f002", 15, true)
    tlk:Message(base .. "330")
    Field.ObjectPlayMotion(NPC, waru_index, "f002", 15, true)
    tlk:Message(base .. "340")
    Field.ObjectPlayMotion(NPC, inori_index, "e006", 15, true)
    tlk:Message(base .. "350")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(22001501, 10377, false)
  end
end

function S200_150:Event_040()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flag003, self.Flag004) then
    require("S200_150")
    S200_150.loadmotion()
    HideMinimap(true)
    HideGuide(true)
    local waru_index = GetIndex(NPC, "S200_150_warudora_02")
    local mega_index = GetIndex(NPC, "S200_150_megadora_02")
    local metal_index = GetIndex(NPC, "S200_150_metaldora_01")
    local inori_index = GetIndex(NPC, "s200_150_inori_01")
    local wanya_index = GetIndex(NPC, "s200_150_wanya_01")
    local aigio_index = GetIndex(NPC, "s200_150_aigio_01")
    Field.ObjectLoadMotion(NPC, waru_index, "bn02")
    Field.ObjectLoadMotion(NPC, waru_index, "fq01")
    Field.ObjectLoadMotion(NPC, waru_index, "fq02")
    Field.ObjectLoadMotion(NPC, mega_index, "bn02")
    Field.ObjectLoadMotion(NPC, mega_index, "fq01")
    Field.ObjectLoadMotion(NPC, mega_index, "fq02")
    Field.ObjectLoadMotion(NPC, metal_index, "bn01")
    Field.ObjectLoadMotion(NPC, metal_index, "bn02")
    Field.ObjectLoadMotion(NPC, metal_index, "fe02")
    Field.ObjectLoadMotion(NPC, metal_index, "f002")
    Field.ObjectLoadMotion(NPC, metal_index, "fe04")
    Field.ObjectLoadMotion(NPC, metal_index, "fq01")
    Field.ObjectLoadMotion(NPC, metal_index, "fq02")
    Flg.Set(self.Flag004)
    tlk:StartTalkAndCancelDigimonRide()
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 0, true)
    Field.ObjectPlayMotion(NPC, inori_index, "e035", 15, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, mega_index, "fq02", 15, true)
    tlk:Message(base .. "360")
    Field.ObjectPlayMotion(NPC, waru_index, "fq01", 15, true)
    tlk:Message(base .. "370")
    Flg.Set("FLAG_IS_S200_150_009")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    FieldObjectSync(FOR_ALL, false)
    Cam.Inst:Set(51.59, 2.163, 75.279, 45.926, 2.71, 67.06, default, 0)
    Field.ObjectPlayMotion(NPC, mega_index, "bn02", 15, true)
    Field.ObjectPlayMotion(NPC, waru_index, "bn02", 15, true)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "fq02", 10, 10)
    tlk:Message(base .. "380")
    local result = tlk:Select(3, base .. "390")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "fq01", 10, 10)
      tlk:Message(base .. "400")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "fq02", 10, 10)
      tlk:Message(base .. "410")
    else
      Field.ObjectPlayMotionWithStartMoveMotion(PLAYER, 1, "e201", 10, 10)
      WaitFrame(60)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "fq01", 10, 10)
      tlk:Message(base .. "420")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "f002", 10, 10)
    Field.ObjectPlayMotion(PLAYER, 1, "e018", 15, true)
    tlk:Message(base .. "430")
    tlk:EndTalk()
    EncountFromField_WithNormalEffect(22001502, 10377, false)
  end
end

function S200_150:Event_050()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flag005) then
    require("S200_150")
    S200_150.loadmotion()
    HideMinimap(true)
    HideGuide(true)
    local waru_index = GetIndex(NPC, "S200_150_warudora_02")
    local mega_index = GetIndex(NPC, "S200_150_megadora_02")
    local metal_index = GetIndex(NPC, "S200_150_metaldora_01")
    local inori_index = GetIndex(NPC, "s200_150_inori_01")
    local wanya_index = GetIndex(NPC, "s200_150_wanya_01")
    local aigio_index = GetIndex(NPC, "s200_150_aigio_01")
    local wanya_index_2 = GetIndex(NPC, "s200_150_wanya_02")
    Field.ObjectLoadMotion(NPC, waru_index, "bn02")
    Field.ObjectLoadMotion(NPC, waru_index, "fq01")
    Field.ObjectLoadMotion(NPC, waru_index, "fq02")
    Field.ObjectLoadMotion(NPC, mega_index, "bn02")
    Field.ObjectLoadMotion(NPC, mega_index, "fq01")
    Field.ObjectLoadMotion(NPC, mega_index, "fq02")
    Field.ObjectLoadMotion(NPC, metal_index, "bn01")
    Field.ObjectLoadMotion(NPC, metal_index, "bn02")
    Field.ObjectLoadMotion(NPC, metal_index, "fe02")
    Field.ObjectLoadMotion(NPC, metal_index, "f002")
    Field.ObjectLoadMotion(NPC, metal_index, "fe04")
    Field.ObjectLoadMotion(NPC, metal_index, "fq01")
    Field.ObjectLoadMotion(NPC, metal_index, "fq02")
    Field.ObjectLoadMotion(NPC, wanya_index_2, "fe01")
    tlk:StartTalkAndCancelDigimonRide()
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field.ObjectPlayMotion(NPC, metal_index, "bn02", 0, true)
    Field.ObjectPlayMotion(NPC, inori_index, "fn01_01", 0, true)
    Field.ObjectPlayMotion(NPC, aigio_index, "fn01_01", 0, true)
    Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 0, true)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    tlk:Message(base .. "440")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, aigio_index, "e002", 10, 10)
    tlk:Message(base .. "450")
    Field.ObjectPlayMotion(NPC, metal_index, "bn01", 15, true)
    tlk:Message(base .. "460")
    local result = tlk:Select(3, base .. "470")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "fq01", 10, 10)
      tlk:Message(base .. "480")
    elseif result == RESULT_TALK01 then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "fq01", 10, 10)
      tlk:Message(base .. "490")
    else
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "f002", 10, 10)
      tlk:Message(base .. "500")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, metal_index, "fq02", 10, 10)
    tlk:Message(base .. "510")
    Flg.Set("FLAG_IS_S200_150_010")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(51.95376, 0.81316, 75.36, 45.77, 2.974, 67.8, default, 0)
    Obj:new(NPC, "s200_150_wanya_01"):SetRotationY(280, 0)
    FieldObjectSync(FOR_ALL, false)
    FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, wanya_index, "fe02", 15, true)
    tlk:Message(base .. "520")
    tlk:Message(base .. "530")
    Flg.Set("FLAG_IS_S200_150_011")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(53.62, 1.013, 76.33, 46.76, 3.536, 69.5, default, 0)
    Obj:new(PLAYER, ""):SetPos(52.89, 0.963, 77.215)
    Field.ObjectPlayMotion(PLAYER, 1, "fg05_n01", 15, true)
    Obj:new(NPC, "s200_150_wanya_01"):Invisible()
    WaitFrame(30)
    FieldObjectSync(FOR_ALL, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, aigio_index, "e004", 15, true)
    Field.ObjectPlayMotion(NPC, inori_index, "e018", 15, true)
    Field.ObjectPlayMotion(NPC, wanya_index_2, "fe01", 15, true)
    tlk:Message(base .. "640")
    tlk:MessageClose()
    BackFade_OutNoLoading(FADE_BLACK, FADE_TIME)
    WaitFrame(30)
    PlaySE(201001, 100)
    WaitFrame(30)
    tlk:Message(base .. "650")
    result = tlk:Select(3, base .. "660")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "670")
    elseif result == RESULT_TALK01 then
      tlk:Message(base .. "680")
    else
      tlk:Message(base .. "690")
    end
    WaitFrame(45)
    tlk:Message(base .. "700")
    tlk:EndTalk(true)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_IS_S200_150_012")
    Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
    MapChange("d", 302, "start_25", false, FADE_BLACK, FADE_TIME)
  end
end

function S200_150:Event_060()
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check(self.Flag005, "FLAG_IS_CLEAR_S200_150") then
    local wanya_index = GetIndex(NPC, "s200_150_001")
    Field.ObjectLoadMotion(NPC, wanya_index, "bn01")
    Field.ObjectLoadMotion(NPC, wanya_index, "fe02")
    Field.ObjectLoadMotion(NPC, wanya_index, "fe04")
    Field.ObjectLoadMotion(NPC, wanya_index, "fq01")
    Field.ObjectLoadMotion(NPC, wanya_index, "fq02")
    Cam.Inst:Set(38.804, 3.0951, 72.174, 48.72, 4.287, 72.698, default, 0)
    tlk:StartTalkAndCancelDigimonRide()
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    START_TALK_ACTION_AND_ZOOM("s200_150_001", true, true)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fe02", 10, 10)
    tlk:Message(base .. "710")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, wanya_index, "fq01", 10, 10)
    tlk:Message(base .. "720")
    tlk:Message(base .. "730")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
    HideMinimap(false)
    HideGuide(false)
    END_TALK_ACTION_AND_ZOOM("s200_150_001", true, true)
    Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
    WaitFrame(1)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end

function S200_150:Event_065()
  if Qst.Sub:Check(self.ID, self.STEP_255) then
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message(base .. "730")
    tlk:EndTalk()
  end
end

function S200_150:Event_070()
  if Qst.Sub:Check(self.ID, self.STEP_255) then
    local pc = Common.GetPlayerModelName()
    local num = 0
    if pc == "pc001qa010101" or pc == "pc002qa010101" then
      num = num + 1
    end
    tlk:StartTalkAndCancelDigimonRide()
    if 1 <= num then
      tlk:Message(base .. "740")
      tlk:Message(base .. "750")
    else
      tlk:Message(base .. "760")
    end
    tlk:EndTalk()
  end
end

function S200_150:loadmotion()
  local inori_index = GetIndex(NPC, "s200_150_inori_01")
  local wanya_index = GetIndex(NPC, "s200_150_wanya_01")
  local aigio_index = GetIndex(NPC, "s200_150_aigio_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e006")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e009")
  Field.ObjectLoadMotion(PLAYER, 1, "e010")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  Field.ObjectLoadMotion(PLAYER, 1, "e020")
  Field.ObjectLoadMotion(PLAYER, 1, "e201")
  Field.ObjectLoadMotion(PLAYER, 1, "fg05_n01")
  Field.ObjectLoadMotion(NPC, inori_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, inori_index, "e002")
  Field.ObjectLoadMotion(NPC, inori_index, "e003")
  Field.ObjectLoadMotion(NPC, inori_index, "e004")
  Field.ObjectLoadMotion(NPC, inori_index, "e005")
  Field.ObjectLoadMotion(NPC, inori_index, "e006")
  Field.ObjectLoadMotion(NPC, inori_index, "e007")
  Field.ObjectLoadMotion(NPC, inori_index, "e008")
  Field.ObjectLoadMotion(NPC, inori_index, "e009")
  Field.ObjectLoadMotion(NPC, inori_index, "e010")
  Field.ObjectLoadMotion(NPC, inori_index, "e012")
  Field.ObjectLoadMotion(NPC, inori_index, "e014")
  Field.ObjectLoadMotion(NPC, inori_index, "e018")
  Field.ObjectLoadMotion(NPC, inori_index, "e020")
  Field.ObjectLoadMotion(NPC, inori_index, "e035")
  Field.ObjectLoadMotion(NPC, aigio_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, aigio_index, "e002")
  Field.ObjectLoadMotion(NPC, aigio_index, "e002_01")
  Field.ObjectLoadMotion(NPC, aigio_index, "e004")
  Field.ObjectLoadMotion(NPC, aigio_index, "e006")
  Field.ObjectLoadMotion(NPC, aigio_index, "e008")
  Field.ObjectLoadMotion(NPC, aigio_index, "e010")
  Field.ObjectLoadMotion(NPC, aigio_index, "e011")
  Field.ObjectLoadMotion(NPC, aigio_index, "e012")
  Field.ObjectLoadMotion(NPC, aigio_index, "e018")
  Field.ObjectLoadMotion(NPC, aigio_index, "e031")
  Field.ObjectLoadMotion(NPC, wanya_index, "bn01")
  Field.ObjectLoadMotion(NPC, wanya_index, "fe02")
  Field.ObjectLoadMotion(NPC, wanya_index, "fe04")
  Field.ObjectLoadMotion(NPC, wanya_index, "fq01")
  Field.ObjectLoadMotion(NPC, wanya_index, "fq02")
end
