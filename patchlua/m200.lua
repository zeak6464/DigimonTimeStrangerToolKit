gGimText = "field_text"
M200 = {
  ID = 200,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_006 = 6,
  STEP_255 = 255
}

function M200:Event_010()
  if Flg.Check("FLAG_MAIN_07_030", "FLAG_MAIN_07_040") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Map:CloseArea(3, true)
    Sound.StopBGM(0)
    Execute("m200_010")
    Execute("m200_011")
    MapChange("t", 101, "start_00", false, FADE_BLACK, FADE_TIME)
  end
end

function M200:Event_015()
  if Flg.Check("FLAG_MAIN_07_030", "FLAG_MAIN_07_040") then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m200_020")
    Flg.Set("FLAG_MAIN_07_040")
    SetFollowerCameraOperateRotation(0, Obj:new(PLAYER, "").rot_y - 20)
    Qst.Main:Start(self.ID, self.STEP_001)
  end
end

function M200:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Flg.Set("FLAG_MAIN_07_050")
    local tlk = Tlk:new("t01", 1, true)
    local e008 = Motion.Object:new(NPC, "npc_3124", "e008")
    local e018 = Motion.Object:new(NPC, "npc_3124", "e018")
    local e030 = Motion.Object:new(NPC, "npc_3124", "e030")
    local bn01 = Motion.Object:new(NPC, "npc_3124", "bn01")
    START_TALK_ACTION_AND_ZOOM("npc_3124", true, false)
    tlk:StartTalkAndCancelDigimonRide()
    e018:Play(10, true)
    tlk:Message("f_t0102_0190_0010")
    e008:Play(10, true)
    tlk:Message("f_t0102_0190_0020")
    e030:Play(10, true)
    tlk:Message("f_t0102_0190_0030")
    tlk:MessageClose()
    Obj:new(OGIM, "obj_shield_e01"):Invisible(15)
    Obj:new(OGIM, "obj_shield_e02"):Invisible(15)
    Obj:new(OGIM, "obj_shield_e03"):Invisible(15)
    Obj:new(OGIM, "obj_shield_e04"):Invisible(15)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    tlk:EndTalk()
    END_TALK_ACTION_AND_ZOOM("npc_3124", true, false)
    bn01:Play(10, true)
    Execute("m200_030")
    local player = Obj:new(PLAYER, "")
    local npc = Obj:new(NPC, "npc_3123")
    local y_degree = Field.GetAngleToTarget2D(player.pos.x, player.pos.z, npc.pos.x, npc.pos.z)
    player:SetPos(-7.448, 0, -61.916, true)
    player:SetRotationYToObject(npc.type, npc.name, 0)
    SetFollowerCameraOperateRotation(10, y_degree - 10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_005)
    Digitter.Send(1200030010)
  end
end

function M200:Event_025()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_006) then
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_201"
    TIME_ZONE = EVENING
    Qst.Main:Set(self.ID, self.STEP_006)
  end
end

function M200:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_255) then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Execute("m210_010")
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(42)
      Common.SetAegiomonGiftPoint(40000)
    end
    Flg.Set("FLAG_MAIN_07_053")
    Qst.Main:End(self.ID, self.STEP_255)
    M210:Event_010()
  end
end
