gGimText = "field_text"
M260 = {
  ID = 260,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_255 = 255
}

function M260:Event_010()
  if Flg.Check("FLAG_MAIN_09_005", "FLAG_MAIN_09_027") then
    Flg.Set("FLAG_MAIN_09_027")
    Execute("m260_020")
    Map:CloseArea(103, false)
    Map:ClosePlace(10302, false)
    Qst.Main:Start(self.ID, self.STEP_001)
    Guest.Add(GST_RANA)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("d", 306, "start_00", AXIS_ORIGINAL, "A2028_daft_260", NOON)
  end
end

function M260:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_09_027", "FLAG_MAIN_09_028") then
    Flg.Set("FLAG_MAIN_09_028")
    Execute("m260_030")
    Execute("m260_040")
    Execute("m260_050")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    MapChangeWithTimePasses("d", 302, "start_20", MORNING)
  end
end

function M260:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_09_028", "FLAG_MAIN_09_029") then
    Flg.Set("FLAG_NOT_USE_FIELD_FADE")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
    Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    Execute("m260_060")
    Obj:new(PLAYER, ""):SetRotationY(45, 0)
  end
end

function M260:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and Flg.Check("FLAG_MAIN_09_028", "FLAG_MAIN_09_029") then
    Flg.Set("FLAG_MAIN_09_029")
    Field.CancelInvisibleFollowerAllPartyMember(0, 0, true, true)
    WaitFrame(15)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M260:Event_040()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M260:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_09_029", "FLAG_MAIN_09_030") then
    Flg.Set("FLAG_MAIN_09_030")
    Execute("m260_070")
    MapChange("d", 308, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M260:Event_060()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) and Flg.Check("FLAG_MAIN_09_030", "FLAG_MAIN_09_033") then
    Flg.Set("FLAG_MAIN_09_033")
    Execute("m260_080")
    Digimon.RestoreAllParty()
    Guest.Delete(GST_RANA)
    Field.ResetPlayer(0, 0, 2, 180)
    Qst.Main:Set(self.ID, self.STEP_010)
    Digitter.Send(1260080010)
  end
end

function M260:Event_063()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_09_034") then
    Flg.Set("FLAG_MAIN_09_034")
  end
end

function M260:Event_062()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_09_035") then
    Flg.Set("FLAG_MAIN_09_035")
    Field.SetProhibitPlayerMoveOperate(true)
    WaitFrame(20)
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0304_0030_0010")
    tlk:MessageClose()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Cam.Inst:Set(-78.54, 4.91, 65.85, -69.91, 7.63, 70.11, 50, 0)
    local sub = Obj:new(NPC, "npc_0006")
    local sub_index = GetIndex(NPC, "npc_0006")
    local fe01 = Motion.Object:new(NPC, "npc_0006", "fe01")
    local fq01 = Motion.Object:new(NPC, "npc_0006", "fq01")
    local bn01 = Motion.Object:new(NPC, "npc_0006", "bn01")
    local player = Obj:new(PLAYER, "")
    local player_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
    local player_e002_01 = Motion.Object:new(PLAYER, "", "e002_01")
    player:SetPos(-74, 4.751, 67.3, true)
    player_fn01_01:Play(5, true)
    sub:SetPos(-77.296, 4.751, 67.379, true)
    sub:SetRotationYToPlayer()
    Field.ObjectLookAtTheObject(PLAYER, 1, NPC, sub_index, 0)
    WaitFrame(60)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0006"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
    fe01:Play(10, true)
    tlk:Message("f_d0304_0030_0020")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0006"), "F01", EYES_BLINK_TYPE_BLINK, false, 0)
    bn01:Play(10, true)
    tlk:Message("f_d0304_0030_0030")
    tlk:MessageClose()
    player_e002_01:Play(10, false)
    WaitFrame(40)
    player_fn01_01:Play(10, true)
    tlk:Message("f_d0304_0030_0040")
    Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0006"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
    fq01:Play(10, true)
    tlk:Message("f_d0304_0030_0050")
    tlk:MessageClose()
    BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    INFO_WINDOW(7031)
    Flg.Set("FLAG_FIELD_D0304_SubMarineJoin")
    Guest.Add(GST_SUBMARINE2)
    tlk:EndTalk()
    Cam.Inst:Clear(0)
    FieldObjectSync(FOR_ALL, true)
    WaitFrame(60)
    Field.SetProhibitPlayerMoveOperate(false)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M260:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and not Flg.Check("FLAG_MAIN_09_040") then
    EncountFromField(10900100, 10379, false)
  end
end

function M260:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_09_040", "FLAG_MAIN_09_043") then
    Flg.Set("FLAG_MAIN_09_043")
    Digimon.RestoreAllParty()
  end
end

function M260:Event_085()
  if Flg.Check("FLAG_MAIN_09_043") and Flg.Check("FLAG_FIELD_D0304_SubMarineJoin") then
    Flg.Clear("FLAG_FIELD_D0304_SubMarineJoin")
    Flg.Set("FLAG_MAIN_09_036")
    local tlk = Tlk:new("d03", 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    tlk:Message("f_d0304_0040_0040")
    tlk:Message("f_d0304_0040_0050")
    tlk:EndTalk()
    Guest.Delete(GST_SUBMARINE2)
  end
end

function M260:Event_090()
  if Qst.Main:Check(self.ID, self.STEP_010, self.STEP_015) and Flg.Check("FLAG_MAIN_09_043", "FLAG_MAIN_09_045") then
    Execute("m260_110")
    Flg.Set("FLAG_MAIN_09_045")
    Item.Add(790, -1)
    Qst.Main:Set(self.ID, self.STEP_015)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  end
end

function M260:Event_092()
  local loc = Field.GetLastPlayerSetLocator()
  if loc == "start_01" and not Flg.Check("FLAG_FIELD_D0304_SubMarineJoin") then
    if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) then
      if not Flg.Check("FLAG_MAIN_09_046") then
        Flg.Set("FLAG_MAIN_09_046")
        local tlk = Tlk:new("d03", 1, true)
        local fe01 = Motion.Object:new(NPC, "npc_0011", "fe01")
        local bn01 = Motion.Object:new(NPC, "npc_0011", "bn01")
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message("f_d0304_0040_0060")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0011"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
        fe01:Play(10, true)
        tlk:Message("f_d0304_0040_0070")
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0011"), "F01", EYES_BLINK_TYPE_BLINK, false, 0)
        bn01:Play(10, true)
        tlk:Message("f_d0304_0040_0075")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0011"), 30)
        tlk:MessageClose()
        tlk:EndTalk()
        MapChange("d", 301, "start_30", true, FADE_BLACK, FADE_TIME)
      else
        local tlk = Tlk:new("d03", 1, true)
        tlk:StartTalkAndCancelDigimonRide()
        tlk:Message("f_d0304_0040_0065")
        tlk:Message("f_d0304_0040_0078")
        tlk:MessageClose()
        BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        Flg.Set("FLAG_FIELD_D0304_SubMarineJoin")
        INFO_WINDOW(7031)
        Guest.Add(GST_SUBMARINE2)
        tlk:EndTalk()
        FieldObjectSync(NPC, true)
        WaitFrame(30)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      end
    else
      local tlk = Tlk:new("d03", 1, true)
      tlk:StartTalkAndCancelDigimonRide()
      tlk:Message("f_d0304_0040_0065")
      tlk:Message("f_d0304_0040_0078")
      tlk:MessageClose()
      BackFade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
      Flg.Set("FLAG_FIELD_D0304_SubMarineJoin")
      INFO_WINDOW(7031)
      Guest.Add(GST_SUBMARINE2)
      tlk:EndTalk()
      FieldObjectSync(NPC, true)
      WaitFrame(30)
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    end
  end
end

function M260:Event_100()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_255) and Flg.Check("FLAG_MAIN_09_045", "FLAG_MAIN_09_047") then
    Flg.Set("FLAG_MAIN_09_047")
    Execute("m260_120")
    Item.Add(789, -1)
    Qst.Main:Set(self.ID, self.STEP_020)
    Flg.Set("FLAG_IS_KEEP_BGM")
    MapChangeWithTimeTravel("d", 305, "start_00", AXIS_ORIGINAL, "Z2028_daft_260", MORNING)
  end
end

function M260:Event_110()
  if Flg.Check("FLAG_MAIN_09_047", "FLAG_MAIN_09_048") then
    Flg.Set("FLAG_MAIN_09_048")
    Execute("m260_130")
    Sound.StopBGM(0)
    Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
    MapChangeWithTimeTravel("d", 301, "start_20", AXIS_ORIGINAL, "A2028_daft_260", MORNING)
  end
end

function M260:Event_120()
  if Flg.Check("FLAG_MAIN_09_048", "FLAG_MAIN_09_049") then
    Flg.Set("FLAG_MAIN_09_049")
    Execute("m260_140")
    Sound.StopBGM(0)
    MapChange("d", 302, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M260:Event_130()
  if Flg.Check("FLAG_MAIN_09_049", "FLAG_MAIN_09_051") then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(60)
    end
    Flg.Set("FLAG_MAIN_09_051")
    Execute("m260_150")
    Sound.StopBGM(0)
    MapChangeWithTimeTravel("t", 3001, "start_00", AXIS_ORIGINAL, "A2028_daft_270", NIGHT)
  end
end
