DLCPATCH0001 = {
  ID = 500,
  STEP_001 = 1,
  STEP_255 = 255
}
local text_file = "dlc000"

function DLCPATCH0001:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_255) then
    Flg.Set("FLAG_DLC_EP00_002")
    local dlc_npc_001 = GetIndex(NPC, "dlc_npc_001")
    local elv_e001 = Motion.Object:new(OGIM, "elv_obj", "e001")
    local elv_e002 = Motion.Object:new(OGIM, "elv_obj", "e002")
    Field.ObjectLoadMotion(NPC, dlc_npc_001, "e002")
    Field.ObjectLoadMotion(NPC, dlc_npc_001, "fn01_01")
    Field.ObjectLoadMotion(NPC, dlc_npc_001, "e551")
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(1)
    Cam.Inst:Set(-17.874, 0.204, -8.767, -7.949, 1.385, -8.437, default, 0)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalk()
    Obj:new(PLAYER, ""):SetPos(-11.228, 0, -9.095, true)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    WaitFrame(10)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    PlayerLookAtObject(NPC, "dlc_npc_001")
    Field.ObjectLookAtTheObject(NPC, dlc_npc_001, FLD_OBJ_PLAYER, 1, 30, 10)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, dlc_npc_001, "e002", 10, 10)
    tlk:Message("dlc000_010_010")
    tlk:EndTalk()
    Field_InvisibleFollowerAllPartyMember(0, 0, false)
    Field_InvisibleFollowerAllGuest(0, 0, false)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(5)
    Qst.DLC:End(self.ID, self.STEP_255)
    Field.ObjectResetAim(NPC, dlc_npc_001, 1)
    PlayerObjectResetAim()
    Motion.Object:PlayFinishedAnim(OGIM, GetIndex(OGIM, "elv_obj"), 0, "e001")
    ColOff("plan_cl_1000")
    ColOff("wall_cl_1000")
    Obj:new(PLAYER, ""):SetPos(-13.62, 0, -8.38, true)
    Obj:new(PLAYER, ""):SetRotationY(90, 0)
    Cam.Inst:Set(-16.14, -0.08, -10.72, -7.55, 2.73, -6.43, default, 0)
    Obj:new(NPC, "dlc_npc_001"):SetRotationY(300, 0)
    WaitFrame(1)
    WaitFrame(30)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    WaitFrame(15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, dlc_npc_001, "e551", 10, 10)
    WaitFrame(15)
    elv_e002:Play(10, false)
    PlaySE(200011, 100)
    WaitFrame(30)
    Fade_OutNoLoadingWithWait(FADE_WHITE, 30)
    MapChange("t", 3004, "start_00", false, 0, 0)
  else
  end
end

function DLCPATCH0001:GetDigitter()
  if Flg.Check("FLAG_DLC_EP00_002") then
    Digitter.Send(5000020)
  end
end

function DLCPATCH0001:Door001Access()
  local npc_index = GetIndex(NPC, "dlc_elvmob_01")
  if DLC.FlagCheck(1) then
    if not Flg.Check("FLAG_DLC_EP00_LOOK_DOOR001_FIRSTTALK") then
      if not Flg.Check("FLAG_DLC_EP00_LOOK_FIRSTTALK") then
        Field.ObjectResetAim(NPC, npc_index, 15)
        DoorAccessFirstTalk(1)
        Flg.Set("FLAG_DLC_EP00_LOOK_FIRSTTALK")
        Flg.Set("FLAG_DLC_EP00_LOOK_DOOR001_FIRSTTALK")
      else
        DoorAccessSecondTalk(1)
        Flg.Set("FLAG_DLC_EP00_LOOK_DOOR001_FIRSTTALK")
      end
    else
      START_TALK_ACTION_AND_ZOOM("dlc_elvmob_01", false, true)
      Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_PLAYER, 1, 30, 10)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalk()
      tlk:Message("dlc000_050_010")
      tlk:Message("dlc000_050_040")
      local result = tlk:Select(2, "dlc000_050_050")
      if result == RESULT_TALK00 then
        Prcs_DLC_SetFollowerInfo()
        tlk:Message("dlc000_050_060")
        tlk:MessageClose()
        INFO_GET_ITEM(40001, 1)
        tlk:Message("dlc000_050_090")
        tlk:EndTalk()
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Field.ObjectResetAim(NPC, npc_index, 30)
        END_TALK_ACTION_AND_ZOOM("dlc_elvmob_01", false, true)
        Prcs_DLC_GetOnElv_Fade("dlc001_elv")
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
        local prifix = "dep01d"
        local number = 5001
        local locator = "start_00"
        local time_axis = "DLC001_dbef_10"
        local time_zone = NOON
        Common.SetTimeTravelRecord(TIME_TRAVEL_RECORD_QUEST, time_axis, time_zone, 1)
        Common.RequestMapChangeWithTimeTravelFromRecord(prifix, number, locator, TIME_TRAVEL_RECORD_QUEST, 1)
      elseif result == RESULT_TALK01 then
        tlk:Message("dlc000_050_100")
        tlk:EndTalk()
        Field.ObjectResetAim(NPC, npc_index, 30)
        END_TALK_ACTION_AND_ZOOM("dlc_elvmob_01", false, true)
      end
    end
  else
    START_TALK_ACTION_AND_ZOOM("dlc_elvmob_01", false, true)
    Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_PLAYER, 1, 30, 10)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalk()
    tlk:Message("dlc000_020_010")
    tlk:Message("dlc000_020_020")
    tlk:Message("dlc000_020_030")
    local result = tlk:Select(2, "dlc000_020_060")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      Field.ObjectResetAim(NPC, npc_index, 30)
      END_TALK_ACTION_AND_ZOOM("dlc_elvmob_01", false, true)
      OpenDlcStore()
    elseif result == RESULT_TALK01 then
      tlk:EndTalk()
      Field.ObjectResetAim(NPC, npc_index, 30)
      END_TALK_ACTION_AND_ZOOM("dlc_elvmob_01", false, true)
    end
  end
end

function DLCPATCH0001:Door002Access()
  local npc_index = GetIndex(NPC, "dlc_elvmob_02")
  if not Flg.Check("FLAG_DLC_PATCH002_IS_INDICATIONS") then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalk()
    tlk:Message("dlc000_110_010")
    tlk:EndTalk()
  elseif DLC.FlagCheck(2) then
    if not Flg.Check("FLAG_DLC_EP00_LOOK_DOOR002_FIRSTTALK") then
      if not Flg.Check("FLAG_DLC_EP00_LOOK_FIRSTTALK") then
        Field.ObjectResetAim(NPC, npc_index, 15)
        DoorAccessFirstTalk(2)
        Flg.Set("FLAG_DLC_EP00_LOOK_FIRSTTALK")
        Flg.Set("FLAG_DLC_EP00_LOOK_DOOR002_FIRSTTALK")
      else
        DoorAccessSecondTalk(2)
        Flg.Set("FLAG_DLC_EP00_LOOK_DOOR002_FIRSTTALK")
      end
    else
      Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_PLAYER, 1, 30, 10)
      START_TALK_ACTION_AND_ZOOM("dlc_elvmob_02", false, true)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalk()
      tlk:Message("dlc000_060_010")
      tlk:Message("dlc000_060_040")
      local result = tlk:Select(2, "dlc000_060_050")
      if result == RESULT_TALK00 then
        Prcs_DLC_SetFollowerInfo()
        tlk:Message("dlc000_060_060")
        tlk:MessageClose()
        INFO_GET_ITEM(41001, 1)
        tlk:Message("dlc000_060_090")
        tlk:EndTalk()
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Field.ObjectResetAim(NPC, npc_index, 30)
        END_TALK_ACTION_AND_ZOOM("dlc_elvmob_02", false, true)
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
        Prcs_DLC_GetOnElv_Fade("dlc002_elv")
        local prifix = "dep02d"
        local number = 5001
        local locator = "start_00"
        local time_axis = "DLC002_dbef_10"
        local time_zone = NOON
        Common.SetTimeTravelRecord(TIME_TRAVEL_RECORD_QUEST, time_axis, time_zone, 1)
        Common.RequestMapChangeWithTimeTravelFromRecord(prifix, number, locator, TIME_TRAVEL_RECORD_QUEST, 1)
      elseif result == RESULT_TALK01 then
        tlk:Message("dlc000_060_100")
        tlk:EndTalk()
        Field.ObjectResetAim(NPC, npc_index, 30)
        END_TALK_ACTION_AND_ZOOM("dlc_elvmob_02", false, true)
      end
    end
  else
    Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_PLAYER, 1, 30, 10)
    START_TALK_ACTION_AND_ZOOM("dlc_elvmob_02", false, true)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalk()
    tlk:Message("dlc000_030_010")
    tlk:Message("dlc000_030_020")
    tlk:Message("dlc000_030_030")
    local result = tlk:Select(2, "dlc000_030_060")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      Field.ObjectResetAim(NPC, npc_index, 30)
      END_TALK_ACTION_AND_ZOOM("dlc_elvmob_02", false, true)
      OpenDlcStore()
    elseif result == RESULT_TALK01 then
      tlk:EndTalk()
      Field.ObjectResetAim(NPC, npc_index, 30)
      END_TALK_ACTION_AND_ZOOM("dlc_elvmob_02", false, true)
    end
  end
end

function DLCPATCH0001:Door003Access()
  local npc_index = GetIndex(NPC, "dlc_elvmob_03")
  if not Flg.Check("FLAG_DLC_PATCH003_IS_INDICATIONS") then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalk()
    tlk:Message("dlc000_120_010")
    tlk:EndTalk()
  elseif DLC.FlagCheck(3) then
    if not Flg.Check("FLAG_DLC_EP00_LOOK_DOOR003_FIRSTTALK") then
      if not Flg.Check("FLAG_DLC_EP00_LOOK_FIRSTTALK") then
        Field.ObjectResetAim(NPC, npc_index, 15)
        DoorAccessFirstTalk(3)
        Flg.Set("FLAG_DLC_EP00_LOOK_FIRSTTALK")
        Flg.Set("FLAG_DLC_EP00_LOOK_DOOR003_FIRSTTALK")
      else
        DoorAccessSecondTalk(3)
        Flg.Set("FLAG_DLC_EP00_LOOK_DOOR003_FIRSTTALK")
      end
    else
      Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_PLAYER, 1, 30, 10)
      START_TALK_ACTION_AND_ZOOM("dlc_elvmob_03", false, true)
      local tlk = Tlk:new(text_file, 1, true)
      tlk:StartTalk()
      tlk:Message("dlc000_070_010")
      tlk:Message("dlc000_070_040")
      local result = tlk:Select(2, "dlc000_070_050")
      if result == RESULT_TALK00 then
        Prcs_DLC_SetFollowerInfo()
        tlk:Message("dlc000_070_060")
        tlk:MessageClose()
        INFO_GET_ITEM(42001, 1)
        tlk:Message("dlc000_070_090")
        tlk:EndTalk()
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Field.ObjectResetAim(NPC, npc_index, 30)
        END_TALK_ACTION_AND_ZOOM("dlc_elvmob_03", false, true)
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Flg.Set("FLAG_SKIP_PLAYBGM_MAPCHANGE")
        Prcs_DLC_GetOnElv_Fade("dlc003_elv")
        local prifix = "dep03d"
        local number = 5001
        local locator = "start_00"
        local time_axis = "DLC003_dbef_10"
        local time_zone = NOON
        Common.SetTimeTravelRecord(TIME_TRAVEL_RECORD_QUEST, time_axis, time_zone, 1)
        Common.RequestMapChangeWithTimeTravelFromRecord(prifix, number, locator, TIME_TRAVEL_RECORD_QUEST, 1)
      elseif result == RESULT_TALK01 then
        tlk:Message("dlc000_060_100")
        tlk:EndTalk()
        Field.ObjectResetAim(NPC, npc_index, 30)
        END_TALK_ACTION_AND_ZOOM("dlc_elvmob_03", false, true)
      end
    end
  else
    Field.ObjectLookAtTheObject(NPC, npc_index, FLD_OBJ_PLAYER, 1, 30, 10)
    START_TALK_ACTION_AND_ZOOM("dlc_elvmob_03", false, true)
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalk()
    tlk:Message("dlc000_040_010")
    tlk:Message("dlc000_040_020")
    tlk:Message("dlc000_040_030")
    local result = tlk:Select(2, "dlc000_040_060")
    if result == RESULT_TALK00 then
      tlk:EndTalk()
      Field.ObjectResetAim(NPC, npc_index, 30)
      END_TALK_ACTION_AND_ZOOM("dlc_elvmob_03", false, true)
      OpenDlcStore()
    elseif result == RESULT_TALK01 then
      tlk:EndTalk()
      Field.ObjectResetAim(NPC, npc_index, 30)
      END_TALK_ACTION_AND_ZOOM("dlc_elvmob_03", false, true)
    end
  end
end

function DoorAccessFirstTalk(dlc_id)
  local tlk = Tlk:new(text_file, 1, true)
  tlk:StartTalk()
  tlk:Message("dlc000_080_010")
  tlk:EndTalk()
  if dlc_id == 1 then
    Execute("d010_010")
  elseif dlc_id == 2 then
    Execute("d010_020")
  elseif dlc_id == 3 then
    Execute("d010_030")
  end
end

function DoorAccessSecondTalk(dlc_id)
  if dlc_id == 1 then
    Execute("d010_010")
  elseif dlc_id == 2 then
    Execute("d010_020")
  elseif dlc_id == 3 then
    Execute("d010_030")
  end
end

function Prcs_DLC_GetOnElv_Fade(gim_loc)
  local e001 = Motion.Object:new(OGIM, gim_loc, "e001")
  local e002 = Motion.Object:new(OGIM, gim_loc, "e002")
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Motion.Object:PlayFinishedAnim(OGIM, GetIndex(OGIM, gim_loc), 0, "e001")
  if gim_loc == "dlc001_elv" then
    Obj:new(PLAYER, ""):SetPos(-9.302, 0, -8.547, true)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    Cam.Inst:Set(-7.91, 0.218, -11.591, -10.997, 3.153, -2.283, default, 0)
  elseif gim_loc == "dlc002_elv" then
    Obj:new(PLAYER, ""):SetPos(0, 0, -8.547, true)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    Cam.Inst:Set(0.735, 0.218, -11.591, -1.679, 3.153, -2.283, default, 0)
  elseif gim_loc == "dlc003_elv" then
    Obj:new(PLAYER, ""):SetPos(9.237, 0, -8.547, true)
    Obj:new(PLAYER, ""):SetRotationY(180, 0)
    Cam.Inst:Set(9.704, 0.218, -11.591, 7.529, 3.153, -2.283, default, 0)
  end
  PlayerObjectResetAim()
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  e002:Play(10, false)
  PlaySE(200011, 100)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_WHITE, 15)
end

function Prcs_DLC_SetFollowerInfo()
  if Common.ExistPartyAegiomon() == true then
    Work.Set(Field_DLC_ReturnAegiomon, 1)
    Party.Aegiomon.SetExist(false)
  else
    Work.Set(Field_DLC_ReturnAegiomon, 0)
  end
  local guest_max_num = Common.GetGuestMaxNum()
  for i = 1, guest_max_num do
    local guest_id = Common.GetGuestIdByIndex(i)
    print("*******guest_id********")
    print(i, ":", guest_id)
    print("***************")
    if i == 1 then
      if guest_id ~= nil then
        Work.Set(Field_DLC_ReturnFollower01, guest_id)
      else
        Work.Set(Field_DLC_ReturnFollower01, 0)
      end
    elseif i == 2 then
      if guest_id ~= nil then
        Work.Set(Field_DLC_ReturnFollower02, guest_id)
      else
        Work.Set(Field_DLC_ReturnFollower02, 0)
      end
    elseif i == 3 then
      if guest_id ~= nil then
        Work.Set(Field_DLC_ReturnFollower03, guest_id)
      else
        Work.Set(Field_DLC_ReturnFollower03, 0)
      end
    elseif i == 4 then
      if guest_id ~= nil then
        Work.Set(Field_DLC_ReturnFollower04, guest_id)
      else
        Work.Set(Field_DLC_ReturnFollower04, 0)
      end
    elseif i == 5 then
      if guest_id ~= nil then
        Work.Set(Field_DLC_ReturnFollower05, guest_id)
      else
        Work.Set(Field_DLC_ReturnFollower05, 0)
      end
    elseif i == 6 then
      if guest_id ~= nil then
        Work.Set(Field_DLC_ReturnFollower06, guest_id)
      else
        Work.Set(Field_DLC_ReturnFollower06, 0)
      end
    end
  end
end
