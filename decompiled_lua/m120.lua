gGimText = "field_text"
M120 = {
  ID = 120,
  STEP_001 = 1,
  STEP_005 = 5,
  STEP_010 = 10,
  STEP_011 = 11,
  STEP_012 = 12,
  STEP_013 = 13,
  STEP_015 = 15,
  STEP_020 = 20,
  STEP_025 = 25,
  STEP_030 = 30,
  STEP_255 = 255
}

function M120:Event_010()
  if Flg.Check("FLAG_MAIN_03_450", "FLAG_MAIN_03_460") then
    if Common.GetGameClearNum() < 1 then
      Common.SetAegiomonFriendship(21)
      Common.SetAegiomonGiftPoint(20000)
    end
    Flg.Set("FLAG_MAIN_03_460")
    Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest"):SuspendAutoTransparentForCamera()
    Execute("m120_010")
    Cam.Follower:ResetFromRotation(180)
    Qst.Main:Start(self.ID, self.STEP_001)
    WaitFrame(Util.SecondFromFrame(660))
    Obj:new(FLD_OBJ_FOLLOWER, GST_HEROINE, "guest"):CancelSuspendAutoTransParentForCamera()
  end
end

function M120:Event_020()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) and not Flg.Check("FLAG_MAIN_03_470") then
    Execute("m120_020")
    Field_StopBGM()
    MapChange("d", 201, "start_00", false, 1, FADE_TIME)
  end
end

function M120:Event_030()
  if Qst.Main:Check(self.ID, self.STEP_001, self.STEP_005) then
    Execute("m120_030")
    Flg.Set("FLAG_MAIN_03_470")
    WaitFrame(30)
    PlayDungeonBGM()
    Execute("m120_040")
    Cam.Follower:ResetFromLocateAndPlayerRotate("start_01")
    Qst.Main:Set(self.ID, self.STEP_005)
  end
end

function M120:Event_033()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_010) then
    local Gawappa = Obj:new(NPC, "shop_0003")
    local Deno = Obj:new(NPC, "shop_0002")
    local dino_index = GetIndex(NPC, "shop_0002")
    local gawappa_index = GetIndex(NPC, "shop_0003")
    local rotate = Field.ObjectGetRotationY(GIM, GetIndex(GIM, "script_position_01"))
    local shop_0003_fe02 = Motion.Object:new(NPC, "shop_0003", "fe02")
    local shop_0003_bn01 = Motion.Object:new(NPC, "shop_0003", "bn01")
    local shop_0003_fq02 = Motion.Object:new(NPC, "shop_0003", "fq02")
    local shop_0002_fq02 = Motion.Object:new(NPC, "shop_0002", "fq02")
    local shop_0002_bn01 = Motion.Object:new(NPC, "shop_0002", "bn01")
    Field.ObjectResetAim(NPC, dino_index, 20)
    Flg.Set("FLAG_MAIN_03_480")
    Field.MovePlayerToLocatorFrame("script_position_01", 15)
    WaitFrame(15)
    Field.SetPlayerRotation(rotate, 10)
    Field_Talk_Start("d02", 1)
    Cam.Inst:Set(-29.211, 2.899, 29.102, -21.445, 3.871, 35.327, default, 20)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gawappa_index, "fe02", 10, 10)
    Message("f_d0201_0060_0010")
    Message("f_d0201_0060_0020")
    Gawappa:SetRotationY(-150, 30)
    Field.ObjectLookAtTheObject(NPC, dino_index, FLD_OBJ_NPC, GetIndex(FLD_OBJ_NPC, "shop_0003"), 20)
    Message("f_d0201_0060_0030")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, gawappa_index, "fe02", 10, 10)
    Message("f_d0201_0060_0040")
    Message("f_d0201_0060_0050")
    Field.ObjectResetAim(NPC, dino_index, 20)
    Message("f_d0201_0060_0060")
    END_TALK_ACTION_AND_ZOOM("shop_0002", false, false)
    shop_0003_bn01:Play(10, true)
    Gawappa:SetRotationY(-230, 30)
    Field_Talk_End()
    Flg.Set("FLAG_MAIN_03_480")
    Qst.Main:Set(self.ID, self.STEP_010)
  end
  local flg = {
    self.STEP_010,
    self.STEP_011,
    self.STEP_012,
    self.STEP_013
  }
  if Qst.Main:AllCheck(self.ID, flg) and not Flg.Check("FLAG_MAIN_03_496") then
    Flg.Set("FLAG_MAIN_03_496")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M120:Event_035()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_011) then
    Flg.Set("FLAG_MAIN_03_485")
    Qst.Main:Set(self.ID, self.STEP_011)
  end
  local flg = {
    self.STEP_010,
    self.STEP_011,
    self.STEP_012,
    self.STEP_013
  }
  if Qst.Main:AllCheck(self.ID, flg) and not Flg.Check("FLAG_MAIN_03_496") then
    Flg.Set("FLAG_MAIN_03_496")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M120:Event_038()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_012) then
    Flg.Set("FLAG_MAIN_03_488")
    Qst.Main:Set(self.ID, self.STEP_012)
  end
  local flg = {
    self.STEP_010,
    self.STEP_011,
    self.STEP_012,
    self.STEP_013
  }
  if Qst.Main:AllCheck(self.ID, flg) and not Flg.Check("FLAG_MAIN_03_496") then
    Flg.Set("FLAG_MAIN_03_496")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M120:Event_040()
  if not Flg.Check("FLAG_MAIN_03_490") then
    Field_Talk_Start("d02", 1)
    Cam.Inst:Set(-8.521, 2.914, -14.467, 1.193, 5.271, -14.4, default, 45)
    Message("f_d0201_0300_0010")
    Flg.Set("FLAG_MAIN_03_490")
    Field_Talk_End()
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(10)
    WaitFrame(5)
    Execute("m120_050")
    Debug.AllUIOn()
    local cam_npc = {
      -10.52,
      2.23,
      -14.94,
      -0.83,
      4.62,
      -14.32
    }
    local cam_shop = {
      -10.66,
      1.38,
      -12.35,
      -1.42,
      4.75,
      -14.15
    }
    CommonShopStart("shop_0005", 103, "bv01", "fe04", "fe02", cam_npc, cam_shop, "f000", "fe02")
  end
end

function M120:Event_050()
  if Qst.Main:Check(self.ID, self.STEP_005, self.STEP_013) then
    Field.MovePlayerToRelativePosFrame(0, -2, 30)
    Cam.Inst:Set(1.75, 4.786, -67.783, 2.459, 4.36, -64.344, 50, 120)
    WaitFrame(120)
    Execute("m120_060")
    Flg.Set("FLAG_MAIN_03_493")
    local player_index = GetIndex(PLAYER, "")
    local loc_pos = Field.GetLocatorPosition("start_01")
    local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
    local rotate = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, loc_pos.x, loc_pos.z)
    Cam.Inst:Clear(0)
    Field.SetPlayerRotationToLocator("start_01", 0)
    Field.SetFollowerCameraOperateRotationY(rotate, 60, EASING_MODE_QUADRATIC_IN_OUT, 45)
    Field.SetFollowerCameraOperateRotationX(0, 60, EASING_MODE_QUADRATIC_IN_OUT, 45)
    WaitFrame(45)
    Debug.AllUIOn()
    Qst.Main:Set(self.ID, self.STEP_013)
    WaitFrame(30)
    OpenTutorial(3010)
  end
  local flg = {
    self.STEP_010,
    self.STEP_011,
    self.STEP_012,
    self.STEP_013
  }
  if Qst.Main:AllCheck(self.ID, flg) and not Flg.Check("FLAG_MAIN_03_496") then
    Flg.Set("FLAG_MAIN_03_496")
    FieldObjectSync(FOR_ALL, false)
  end
end

function M120:Event_060()
  Execute("m120_080")
  local flg = {
    self.STEP_010,
    self.STEP_011,
    self.STEP_012,
    self.STEP_013
  }
  if Qst.Main:AllCheck(self.ID, flg) and not Qst.Main:Check(self.ID, self.STEP_015) then
    Flg.Set("FLAG_MAIN_03_495")
    Qst.Main:Set(self.ID, self.STEP_015)
  end
end

function M120:Event_063()
  if Qst.Main:Check(self.ID, self.STEP_015, self.STEP_020) then
    if Flg.Check("FLAG_MAIN_03_495", "FLAG_MAIN_03_515") then
      WaitFrame(10)
      START_TALK_ACTION_AND_ZOOM("npc_0031", true, true)
      Field_Talk_Start("d02", 1)
      Message("f_d0202_0020_0010")
      Message("f_d0202_0020_0020")
      END_TALK_ACTION_AND_ZOOM("npc_0031", true, true)
      Field_Talk_End()
    end
    Qst.Main:Set(self.ID, self.STEP_020)
  end
end

function M120:Event_065()
  if Flg.Check("FLAG_MAIN_03_495", "FLAG_MAIN_03_515") and not Flg.Check("FLAG_MAIN_03_498") then
    local npc_0003_bn01 = Motion.Object:new(NPC, "npc_0003", "bn01")
    local npc_0003_fe04 = Motion.Object:new(NPC, "npc_0003", "fe04")
    local npc_0003_fq01 = Motion.Object:new(NPC, "npc_0003", "fq01")
    local npc_0003_br01 = Motion.Object:new(NPC, "npc_0003", "br01")
    START_TALK_ACTION_AND_ZOOM("npc_0003", true, false)
    Cam.Inst:Set(-1.91, -0.099, -7.191, 0.6736, 0.4343, 2.455, default, 30)
    WaitFrame(30)
    Field_Talk_Start("d02", 1)
    npc_0003_fe04:PlayWithStartMoveMotion(10, 10)
    Message("f_d0215_0010_0010")
    Message("f_d0215_0010_0020")
    npc_0003_fq01:PlayWithStartMoveMotion(10, 10)
    Message("f_d0215_0010_0030")
    Cam.Inst:Clear(30)
    Field_Talk_End()
    END_TALK_ACTION_AND_ZOOM("npc_0003", true, false)
    Flg.Set("FLAG_MAIN_03_498")
    WaitFrame(30)
  end
  if Qst.Main:Check(self.ID, self.STEP_020, self.STEP_025) then
    Qst.Main:Set(self.ID, self.STEP_025)
  end
end

function M120:Event_066()
  if Flg.Check("FLAG_MAIN_03_498") then
    local npc_0003_bn01 = Motion.Object:new(NPC, "npc_0003", "bn01")
    local npc_0003_br01 = Motion.Object:new(NPC, "npc_0003", "br01")
    local npc_0003_fq01 = Motion.Object:new(NPC, "npc_0003", "fq01")
    START_TALK_ACTION_AND_ZOOM("npc_0003", true, false)
    Cam.Inst:Set(-1.91, -0.099, -7.191, 0.6736, 0.4343, 2.455, default, 30)
    WaitFrame(30)
    Field_Talk_Start("d02", 1)
    npc_0003_fq01:PlayWithStartMoveMotion(10, 10)
    Message("f_d0215_0010_0030")
    Field_Talk_End()
    END_TALK_ACTION_AND_ZOOM("npc_0003", true, false)
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function M120:Event_068()
  if Flg.Check("FLAG_MAIN_03_495", "FLAG_MAIN_03_500") then
    print("TIME_AXIS_SET")
    TIME_AXIS = AXIS_ORIGINAL
    TIME_AXIS_SET = "A2020_dbef_130"
    TIME_ZONE = NOON
  end
end

function M120:Event_070()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) and not Flg.Check("FLAG_MAIN_03_500") then
    Flg.Set("FLAG_MAIN_03_500")
    self:Event_080()
  end
end

function M120:Event_080()
  if Qst.Main:Check(self.ID, self.STEP_025, self.STEP_030) then
    Flg.Set("FLAG_MAIN_03_515")
    Execute("m120_100")
    Obj:new(NPC, "npc_0031"):Invisible()
    Field.ResetPlayer(33.963, 0, -8.72, -100)
    local luna = Obj:new(NPC, "npc_0013")
    luna:CancelInvisible()
    luna:SetPos(23.662, 0, -8.174)
    luna:SetRotationY(90, 0)
    SetControlScriptExternalVariable("leave_house_1", "end")
    WaitFrame(20)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    Qst.Main:Set(self.ID, self.STEP_030)
  end
end

function M120:Event_090()
  if Flg.Check("FLAG_MAIN_03_520", "FLAG_MAIN_03_530") then
    Flg.Set("FLAG_MAIN_03_530")
    local luna = Obj:new(NPC, "npc_0013")
    Obj:new(RUMOR_NPC, "guide_lunamon2"):Invisible()
    Execute("m130_010")
    local y_degree = GetAngleToTarget2D(-28.8, 16.29, -34.49, 24.31)
    SetFollowerCameraOperateRotation(10, y_degree - 10, 20)
    luna:Invisible(15)
  end
  if Qst.Main:Check(self.ID, self.STEP_030, self.STEP_255) then
    Fade_Out(0, FADE_TIME)
    WaitFrame(FADE_TIME)
    local luna = Obj:new(NPC, "npc_0013")
    Execute("m120_110")
    if not Flg.Check("FLAG_MAIN_03_520") then
      luna:CancelInvisible()
      Obj:new(RUMOR_NPC, "guide_lunamon"):Invisible()
      Obj:new(RUMOR_NPC, "guide_lunamon2"):Invisible()
      Cam.Follower:ResetFromObject(NPC, "npc_0013")
    end
    if Flg.Check("FLAG_MAIN_03_520") then
      Cam.Follower:ResetFromObject(NPC, "npc_0013")
      Obj:new(RUMOR_NPC, "guide_lunamon"):CancelInvisible()
      Obj:new(RUMOR_NPC, "guide_lunamon2"):CancelInvisible()
      SetControlScriptExternalVariable("Rumer_state", "display")
      SetControlScriptExternalVariable("Rumer_state2", "invisible")
      if GetControlScriptExternalVariableString("luna_state") == "initialize" then
        SetControlScriptExternalVariable("luna_state", "move_wait")
      end
      Obj:new(NPC, "npc_0013"):SetEnableCheckAndFieldAttack(false)
      Obj:new(NPC, "npc_0012"):Invisible()
      Obj:new(NPC, "npc_0015"):CancelInvisible()
      if Common.GetGameClearNum() < 1 then
        Common.SetAegiomonFriendship(18)
      end
      Qst.Main:End(self.ID, self.STEP_255)
      M130:Event_010()
    end
  end
end

function M120:ChapterFlagSet(progress)
  local step = {}
  if 20 <= progress then
    step[#step + 1] = self.STEP_001
    step[#step + 1] = self.STEP_005
  end
  if 80 <= progress then
    step[#step + 1] = self.STEP_010
    step[#step + 1] = self.STEP_011
    step[#step + 1] = self.STEP_012
    step[#step + 1] = self.STEP_013
  end
  if 81 <= progress then
    step[#step + 1] = self.STEP_015
    step[#step + 1] = self.STEP_020
  end
  if 100 <= progress then
    step[#step + 1] = self.STEP_025
  end
  if 110 <= progress then
    step[#step + 1] = self.STEP_030
  end
  Qst.Main:Chapter(step, self.ID)
end
