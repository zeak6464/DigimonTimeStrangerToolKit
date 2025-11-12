gGimText = "field_text"
M235 = {
  ID = 235,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_255 = 255
}

function M235:Event_010()
  if Flg.Check("FLAG_MAIN_08_010", "FLAG_MAIN_08_020") then
    Flg.Set("FLAG_MAIN_08_020")
    Sound.StopBGM(0)
    Execute("m235_010")
    Qst.Main:Start(self.ID, self.STEP_001)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChange("d", 1301, "start_20", false, FADE_BLACK, FADE_TIME)
  end
end

function M235:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_08_025")
    Execute("m235_020")
    Guest.Add(GST_ASUKA_B)
    MapChange("d", 1303, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M235:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_08_025", "FLAG_MAIN_08_026") then
    Flg.Set("FLAG_MAIN_08_026")
    Execute("m235_030")
    MapChange("d", 1304, "start_01", false, FADE_BLACK, FADE_TIME)
  end
end

function M235:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_08_026", "FLAG_MAIN_08_027") then
    Flg.Set("FLAG_MAIN_08_027")
    WaitFrame(50)
    Cam.Inst:Set(17.056, 2.933, 13.098, 7.681, 0.227, 10.911, default, 20)
    WaitFrame(20)
    local tlk = Tlk:new("d13", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d1304_0010_0010")
    tlk:EndTalk()
    Cam.Inst:Clear(20)
    WaitFrame(20)
  end
end

function M235:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_08_028")
    Cam.Inst:Set(22.58, 3.09, 19.26, 16.99, 1.56, 10.21, default, 0)
    WaitFrame(10)
    WaitFrame(60)
    Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "duct_0002"), true)
    Cam.Inst:Clear(20)
    WaitFrame(20)
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M235:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChange("d", 1202, "start_20", true, FADE_BLACK, FADE_TIME)
  end
end

function M235:Event_045()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and not Flg.Check("FLAG_MAIN_08_030") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    WaitFrame(60)
    Execute("m235_040")
    Flg.Set("FLAG_MAIN_08_030")
  end
end

function M235:Event_046()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) and Flg.Check("FLAG_MAIN_08_030") and not Flg.Check("FLAG_MAIN_08_031") then
    FieldObjectSync(FOR_ALL, false)
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Field.ObjectLoadMoveMotion(NPC, GetIndex(NPC, "aigio"), "fn01_01")
    Field.ObjectLoadMoveMotion(NPC, GetIndex(NPC, "inori"), "fn01_01")
    Field.ObjectLoadMoveMotion(NPC, GetIndex(NPC, "asuna"), "fn01_01")
    SetFollowerCameraOperateRotation(0, 350)
    Cam.Inst:Set(-0.768, 4.4637, -37.9, 0.63, 4.612, -28, default, 0)
    Obj:new(PLAYER, ""):SetRotationY(0, 0)
    Obj:new(PLAYER, ""):SetPos(0.131, 3.1093, -29.327, true)
    WaitFrame(30)
    local tlk = Tlk:new("d12", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    FadeAllInWithWait(FADE_BLACK, 30)
    Field.ObjectFrameMove2D(NPC, GetIndex(NPC, "aigio"), 0, 2, 40)
    Field.ObjectFrameMove2D(NPC, GetIndex(NPC, "inori"), 0, 1, 40)
    Field.ObjectFrameMove2D(NPC, GetIndex(NPC, "asuna"), 0, 1, 40)
    WaitFrame(40)
    tlk:Message("f_d1202_0020_0010")
    tlk:MessageClose()
    Cam.Inst:Set(2.321, 8.466, -73.75, 2.451, 7.483, -63.8, default, 30)
    WaitFrame(40)
    tlk:Message("f_d1202_0020_0020")
    tlk:EndTalk()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_MAIN_08_031")
    FieldObjectSync(FOR_ALL, false)
    Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_010)
  end
end

function M235:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_255) and not Flg.Check("FLAG_MAIN_08_035") then
    local asuna = Obj:new(FLD_OBJ_FOLLOWER, GST_ASUKA_B, "guest")
    Flg.Set("FLAG_MAIN_08_035")
    Execute("m240_010")
  end
end

function M235:Event_055()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) then
    local tlk = Tlk:new("d12", 1, true)
    local npc_index01 = GetIndex(NPC, "asuna_02")
    local npc_index02 = GetIndex(NPC, "inori_01")
    local npc_index03 = GetIndex(NPC, "simonzu_01")
    local asuna_e006 = Motion.Object:new(NPC, "asuna_02", "e006")
    local asuna_fn01_01 = Motion.Object:new(NPC, "asuna_02", "fn01_01")
    local simonzu_e002 = Motion.Object:new(NPC, "simonzu_01", "e002")
    local simonzu_e019 = Motion.Object:new(NPC, "simonzu_01", "e019")
    local simonzu_e021 = Motion.Object:new(NPC, "simonzu_01", "e021")
    local simonzu_fn01_01 = Motion.Object:new(NPC, "simonzu_01", "fn01_01")
    local inori_e032 = Motion.Object:new(NPC, "inori_01", "e032")
    local inori_e511 = Motion.Object:new(NPC, "inori_01", "e511")
    local inori_fn01_01 = Motion.Object:new(NPC, "inori_01", "fn01_01")
    local player = Obj:new(PLAYER, "")
    local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
    local player_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    Flg.Set("FLAG_MAIN_08_036")
    FieldObjectSync(FOR_ALL, false)
    Field.ObjectLookAtTheObject(NPC, npc_index01, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "simonzu_01"), 0)
    tlk:StartTalkAndCancelDigimonRide()
    Cam.Inst:Set(-2.66, -0.35, -4.752, 0.752, 1.451, 4.473, default, 1)
    WaitFrame(30)
    simonzu_e019:Play(10, false)
    Field.ObjectChangeExpression(NPC, npc_index03, "F05", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0010")
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0020")
    tlk:Message("f_d1206_0040_0030")
    tlk:Message("f_d1206_0040_0040")
    simonzu_e002:Play(10, false)
    tlk:Message("f_d1206_0040_0050")
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, 120)
    WaitFrame(60)
    FadeAllInWithWait(FADE_BLACK, 120)
    simonzu_e019:Play(10, false)
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0060")
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    inori_e511:Play(10, true)
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0070")
    tlk:Message("f_d1206_0040_0080")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    inori_fn01_01:Play(10, true)
    local _ = tlk:Select(3, "f_d1206_0040_0090")
    tlk:MessageClose()
    player_e002_01:Play2Wait(10, false)
    player_fn01_01:Play(10, true)
    simonzu_e021:Play(10, true)
    Field.ObjectChangeExpression(NPC, npc_index03, "F02", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0100")
    tlk:Message("f_d1206_0040_0110")
    simonzu_fn01_01:Play(10, true)
    Field.ObjectLookAtTheObject(NPC, npc_index03, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "asuna_02"), 30)
    tlk:Message("f_d1206_0040_0120")
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectLookAtTheObject(NPC, npc_index02, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "asuna_02"), 30)
    Field.ObjectLookAtTheObject(PLAYER, 1, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "asuna_02"), 30)
    asuna_e006:Play(10, true)
    tlk:Message("f_d1206_0040_0130")
    asuna_fn01_01:Play(10, true)
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0140")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0150")
    Field.ObjectResetAim(NPC, npc_index03, 30)
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0160")
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectResetAim(NPC, npc_index02, 30)
    Field.ObjectResetAim(PLAYER, 1, 30)
    ObjectSetRotationY(FLD_OBJ_NPC, npc_index02, 45, 10)
    inori_e032:Play(10, true)
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0170")
    Field.ObjectChangeExpression(NPC, npc_index02, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    inori_fn01_01:Play(10, true)
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    tlk:Message("f_d1206_0040_0180")
    simonzu_e002:Play(10, true)
    tlk:Message("f_d1206_0040_0190")
    tlk:Message("f_d1206_0040_0200")
    simonzu_e019:Play(10, false)
    tlk:Message("f_d1206_0040_0210")
    simonzu_fn01_01:Play(10, true)
    tlk:Message("f_d1206_0040_0220")
    simonzu_e002:Play(10, true)
    tlk:Message("f_d1206_0040_0230")
    tlk:Message("f_d1206_0040_0240")
    simonzu_fn01_01:Play(10, true)
    Field.ObjectChangeExpression(NPC, npc_index03, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Flg.Set("FLAG_MAIN_08_037")
    WaitFrame(15)
    Cam.Inst:Clear(1)
    tlk:EndTalk()
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M235:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) then
    Fade_OutNoLoadingWithWait(FADE_BLACK, 0)
    Guest.Delete(GST_ASUKA_B)
    FieldObjectSync(FOR_ALL, true)
    Execute("m240_020")
    Fade_OutNoLoadingWithWait(FADE_BLACK, 0)
    Qst.Main:End(self.ID, self.STEP_255)
  end
end

function M235:ChapterFlagSet(progress)
  local step = {}
  if 50 <= progress then
    step[#step + 1] = self.STEP_001
  end
  if 52 <= progress then
    step[#step + 1] = self.STEP_005
    step[#step + 1] = self.STEP_010
  end
  if 53 <= progress then
    step[#step + 1] = self.STEP_015
  end
  Qst.Main:Chapter(step, self.ID)
end
