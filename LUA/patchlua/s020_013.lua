S020_013 = {
  ID = 13,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}
local base = "s020_013_"
local text_file = "s020_013"
local tlk = Tlk:new(text_file, 1, true)

function S020_013:Event_010()
  local nepu_index = GetIndex(NPC, "npc_0001")
  Field.ObjectLoadMotion(NPC, nepu_index, "e101")
  Field.ObjectLoadMotion(NPC, nepu_index, "e104")
  Field.ObjectLoadMotion(NPC, nepu_index, "e105")
  Field.ObjectLoadMotion(NPC, nepu_index, "e106")
  Field.ObjectLoadMotion(NPC, nepu_index, "e108")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  if Qst.Sub:Check(self.ID, self.STEP_005, self.STEP_010) then
    Cam.Inst:Set(1.89, 40.55, -114.513, 3.973, 37.28, -105.29, default, 30)
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
    tlk:Message(base .. "310")
    local result = tlk:Select(2, base .. "320")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "280")
      Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
      tlk:Message(base .. "340")
      INFO_GET_ITEM(762, 1)
      tlk:EndTalk(true)
      Qst.Sub:Start(self.ID, 1, false)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_010)
      Flg.Set("FLAG_SUB_020_013_001")
      Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
      tlk:Message(base .. "330")
      tlk:EndTalk()
      HideMinimap(false)
      HideGuide(false)
    end
    Cam.Inst:Clear(30)
  elseif Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    Cam.Inst:Set(1.89, 40.55, -114.513, 3.973, 37.28, -105.29, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    tlk:Message(base .. "340")
    tlk:EndTalk()
    Cam.Inst:Clear(30)
  elseif Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_005) then
    Cam.Inst:Set(1.89, 40.55, -114.513, 3.973, 37.28, -105.29, default, 30)
    tlk:StartTalkAndCancelDigimonRide()
    HideMinimap(true)
    HideGuide(true)
    Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
    tlk:Message(base .. "010")
    local result = tlk:Select(3, base .. "020")
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "030")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "040")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "050")
    end
    local result = tlk:Select(3, base .. "060")
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "070")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "080")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "090")
    end
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    tlk:Message(base .. "100")
    tlk:Message(base .. "110")
    local result = tlk:Select(3, base .. "120")
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "130")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "140")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "150")
    end
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    tlk:Message(base .. "160")
    local result = tlk:Select(3, base .. "170")
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "180")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "190")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "200")
    end
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    tlk:Message(base .. "210")
    local result = tlk:Select(3, base .. "220")
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "230")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "240")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "250")
    end
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    tlk:Message(base .. "260")
    local result = tlk:Select(3, base .. "270")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      tlk:Message(base .. "280")
      Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
      tlk:Message(base .. "340")
      INFO_GET_ITEM(762, 1)
      tlk:EndTalk(true)
      Qst.Sub:Start(self.ID, 1, false)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_005)
      Qst.Sub:Set(self.ID, self.STEP_010)
      Flg.Set("FLAG_SUB_020_013_001")
      Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
      tlk:Message(base .. "290")
      tlk:Message(base .. "340")
      INFO_GET_ITEM(762, 1)
      tlk:EndTalk(true)
      Qst.Sub:Start(self.ID, 1, false)
      HideMinimap(false)
      HideGuide(false)
      Qst.Sub:Set(self.ID, self.STEP_005)
      Qst.Sub:Set(self.ID, self.STEP_010)
      Flg.Set("FLAG_SUB_020_013_001")
      Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
      tlk:Message(base .. "300")
      Qst.Sub:Set(self.ID, self.STEP_005)
      tlk:EndTalk()
    end
    Cam.Inst:Clear(30)
  end
end

function S020_013:Event_020()
  local venus_index = GetIndex(NPC, "npc_0001")
  local venus = Obj:new(NPC, "npc_0001")
  Field.ObjectLoadMotion(NPC, venus_index, "bn01")
  Field.ObjectLoadMotion(NPC, venus_index, "br01")
  Field.ObjectLoadMotion(NPC, venus_index, "e002")
  Field.ObjectLoadMotion(NPC, venus_index, "e004")
  Field.ObjectLoadMotion(NPC, venus_index, "e008")
  Field.ObjectLoadMotion(NPC, venus_index, "e502")
  Field.ObjectLoadMotion(NPC, venus_index, "fq01")
  Field.ObjectLoadMotion(NPC, venus_index, "fq02")
  local venus_pos = Field.ObjectGetPosition(NPC, venus_index)
  local player_pos = Field.ObjectGetPosition(PLAYER, 1)
  local y_degree = GetAngleToTarget2D(venus_pos.x, venus_pos.z, player_pos.x, player_pos.z)
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_015) then
    HideMinimap(true)
    HideGuide(true)
    Field.ObjectResetAim(NPC, venus_index, 15)
    tlk:StartTalkZoom("npc_0001")
    Field.ObjectSetRotationY(NPC, venus_index, y_degree, 15)
    Field.ObjectPlayMotion(NPC, venus_index, "br01", 15, true)
    WaitFrame(20)
    Field.ObjectPlayMotion(NPC, venus_index, "e008", 15, true)
    tlk:Message(base .. "350")
    INFO_RELEASE_ITEM(762, 1)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, venus_index, "fq02", 10, 10)
    tlk:Message(base .. "360")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, venus_index, "e008", 10, 10)
    local result = tlk:Select(3, base .. "370")
    if result == RESULT_TALK00 then
      tlk:Message(base .. "380")
    end
    if result == RESULT_TALK01 then
      tlk:Message(base .. "390")
    end
    if result == RESULT_TALK02 then
      tlk:Message(base .. "400")
    end
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, venus_index, "e002", 10, 10)
    tlk:Message(base .. "410")
    tlk:Message(base .. "420")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, venus_index, "e502", 10, 10)
    tlk:Message(base .. "430")
    INFO_GET_ITEM(763, 1)
    Qst.Sub:Set(self.ID, self.STEP_015)
    tlk:EndTalk()
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChange("d", 305, "start_01", true, FADE_BLACK, FADE_TIME)
  end
end

function S020_013:Event_030()
  local nepu_index = GetIndex(NPC, "npc_0001")
  Field.ObjectLoadMotion(NPC, nepu_index, "e100")
  Field.ObjectLoadMotion(NPC, nepu_index, "e101")
  Field.ObjectLoadMotion(NPC, nepu_index, "e104")
  Field.ObjectLoadMotion(NPC, nepu_index, "e105")
  Field.ObjectLoadMotion(NPC, nepu_index, "e106")
  Field.ObjectLoadMotion(NPC, nepu_index, "e108")
  Field.ObjectLoadMotion(PLAYER, 1, "e002")
  Field.ObjectLoadMotion(PLAYER, 1, "e004_01")
  Field.ObjectLoadMotion(PLAYER, 1, "e008")
  Field.ObjectLoadMotion(PLAYER, 1, "e012")
  Field.ObjectLoadMotion(PLAYER, 1, "e013")
  Field.ObjectLoadMotion(PLAYER, 1, "e015")
  Field.ObjectLoadMotion(PLAYER, 1, "e018")
  Field.ObjectLoadMotion(PLAYER, 1, "e019")
  if Qst.Sub:Check(self.ID, self.STEP_015, self.STEP_255) then
    HideMinimap(true)
    HideGuide(true)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(1.89, 40.55, -114.513, 3.973, 37.28, -105.29, default, 0)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    tlk:Message(base .. "440")
    local result = tlk:Select(3, base .. "450")
    WaitFrame(15)
    if result == RESULT_TALK00 then
      Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
      tlk:Message(base .. "460")
    end
    if result == RESULT_TALK01 then
      Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
      tlk:Message(base .. "470")
    end
    if result == RESULT_TALK02 then
      Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
      tlk:Message(base .. "480")
    end
    Field.ObjectPlayMotion(NPC, nepu_index, "e105", 15, true)
    tlk:Message(base .. "490")
    Field.ObjectPlayMotion(NPC, nepu_index, "e108", 15, true)
    tlk:Message(base .. "500")
    Field.ObjectPlayMotion(NPC, nepu_index, "e101", 15, true)
    tlk:Message(base .. "520")
    MessageClose()
    INFO_RELEASE_ITEM(763, 1)
    WaitFrame(15)
    Field.ObjectPlayMotion(NPC, nepu_index, "e100", 15, true)
    tlk:EndTalk()
    HideMinimap(false)
    HideGuide(false)
    Qst.Sub:End(self.ID, self.STEP_255)
  end
  Cam.Inst:Clear(30)
end
