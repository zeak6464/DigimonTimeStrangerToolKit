require("function_control")
DEFINE_FLAG("FLAG_GIMMICK_D14_380")
DEFINE_FLAG("FLAG_MAIN_01_240")
DEFINE_FLAG("FLAG_MAIN_01_253")
DEFINE_FLAG("FLAG_MAIN_01_254")
DEFINE_FLAG("FLAG_MAIN_01_241")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gRubbleTimer = 0
gBigRoboEffectTiming = 175

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 1401 then
    LoadRailMove(gRailMoveFile)
    LoadLocatorModel(gPlanData)
  end
  if gMapNum == 1402 then
    LoadRailMove(gRailMoveFile)
    LoadLocatorModel(gPlanData)
  end
  if gMapNum == 1403 then
    LoadRailMove(gRailMoveFile)
    CtrlLoadNPCMotion("npc_0001", "bn01", "br01")
  elseif gMapNum == 1405 then
    local breakrubble = GetIndex(GIM, "fa_0005")
    LocatorObject(breakrubble).LoadMotion("e001")
    LoadEffectScript("ef_f_com_300_sm", 1)
  elseif gMapNum == 1406 then
    LoadRailMove(gRailMoveFile)
    LoadEffectScript("ef_f_chu_010_sm", 1)
  elseif gMapNum == 1409 then
    LoadRailMove(gRailMoveFile)
    local chrono = GetIndex(NPC, "test_chrono")
    Npc(chrono).LoadMoveMotion("")
    Npc(chrono).LoadMotion("bv01")
    Npc(chrono).LoadMotion("bn01")
    Npc(chrono).LoadMotion("ba01")
    Npc(chrono).LoadMotion("ba02")
    local building1 = GetIndex(GIM, "obj_0001")
    local building2 = GetIndex(GIM, "obj_0002")
    local building101 = GetIndex(GIM, "obj_0101")
    local building102 = GetIndex(GIM, "obj_0102")
    local building103 = GetIndex(GIM, "obj_0103")
    local building104 = GetIndex(GIM, "obj_0104")
    local building105 = GetIndex(GIM, "obj_0105")
    local building106 = GetIndex(GIM, "obj_0106")
    local building107 = GetIndex(GIM, "obj_0107")
    local building108 = GetIndex(GIM, "obj_0108")
    LocatorObject(building1).LoadMotion("e002")
    LocatorObject(building2).LoadMotion("e001")
    LocatorObject(building101).LoadMotion("e001")
    LocatorObject(building102).LoadMotion("e001")
    LocatorObject(building103).LoadMotion("e001")
    LocatorObject(building104).LoadMotion("e001")
    LocatorObject(building105).LoadMotion("e001")
    LocatorObject(building106).LoadMotion("e001")
    LocatorObject(building107).LoadMotion("e001")
    LocatorObject(building108).LoadMotion("e001")
    LoadEffectScript("ef_f_com_300_sm", 20)
    LoadEffectScript("ef_f_tes_001_be", 1)
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  if gMapNum == 1401 then
  end
  if gMapNum == 1402 then
  end
  if gMapNum == 1403 then
    SetExternalVariable("piyo_state", "init")
  elseif gMapNum == 1405 then
    SetExternalVariable("breakrubble_state", "init")
    local breakrubble = GetIndex(GIM, "fa_0005")
    LocatorObject(breakrubble).AttachEffectScript("ef_f_com_300_sm", false, 1, false, false, false, false)
    gRubbleTimer = 0
  elseif gMapNum == 1406 then
    SetExternalVariable("bigrobo_effect", "init")
    SetExternalVariable("bigrobo_effect_timing", 0)
    SetExternalVariable("bigrobo_impact_frame", 0)
  elseif gMapNum == 1409 then
    SetExternalVariable("player_state", "initialize")
    SetExternalVariable("test_chrono_state", "initialize")
    SetExternalVariable("test_act_no", "initialize")
    SetExternalVariable("break_eff_state", "Initialize")
    SetExternalVariable("beam_state", "Initialize")
    local chrono = GetIndex(NPC, "test_chrono")
    Npc(chrono).LinkToRailMove(gRailMoveFile, 1)
    Npc(chrono).SetRailMoveInDimension3d()
    Npc(chrono).SetRailMoveSpeed(10)
    gChronoBa01End = Npc(chrono).GetMotionDefaultEndFrame("ba01")
    gChronoBa02End = Npc(chrono).GetMotionDefaultEndFrame("ba02")
    gChronoBv01End = Npc(chrono).GetMotionDefaultEndFrame("bv01")
    gChronoBn01End = Npc(chrono).GetMotionDefaultEndFrame("bn01")
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 1401 then
    DisableLinkCollisionInNowFrame("col_d1402_start_00_0")
  elseif gMapNum == 1409 then
  end
end

function Update(elapsed_frame)
  if GetExternalVariable("theater_state") == "play" then
    local theater_loc = string.sub(GetExternalVariable("theater_place"), 10)
    local start_loc = string.sub(GetExternalVariable("theater_place"), 1, 8)
    TheaterDoorCam(theater_loc, start_loc, elapsed_frame)
  else
    for i = 1, 2 do
      local theater = GetIndex(GIM, "theater_00" .. string.format("%02d", i))
      if theater ~= nil and LocatorObject(theater).IsPlayingMotion("e001") == false then
        LocatorObject(theater).LoadMotion("e001")
        LocatorObject(theater).Motion_PlayMotion("e001", 0, true)
      end
    end
  end
  if gMapNum == 1401 and GetExternalVariable("AfterConvertTutorialEvent") == "on" then
    CallEventScriptFunction("M020_Event_126")
  end
  if gMapNum == 1402 then
    local elv_door = GetIndex(GIM, "change_0001")
    local elv_panel = GetIndex(GIM, "gim_0002")
    if LocatorObject(elv_door).IsPlayingMotion("e002") == false then
      LocatorObject(elv_panel).SetEnablePlayerCheck(true)
    else
      LocatorObject(elv_panel).SetEnablePlayerCheck(false)
    end
  end
  if gMapNum == 1403 then
    local elv_door = GetIndex(GIM, "change_0001")
    local elv_panel = GetIndex(GIM, "gim_0002")
    if LocatorObject(elv_door).IsPlayingMotion("e002") == false then
      LocatorObject(elv_panel).SetEnablePlayerCheck(true)
    else
      LocatorObject(elv_panel).SetEnablePlayerCheck(false)
    end
    AdulationDigiNPC("piyo_state", "npc_0001")
  elseif gMapNum == 1405 then
    local system_type, obj_index = GetCurrentFieldAttackTargetMarker()
    local unique_name
    if system_type ~= nil then
      unique_name = Object(system_type, obj_index).GetUniqueName()
    end
    if unique_name == "fa_0005" then
      SetInstantCameraInNowFrame(-21.7, 1.5, 5, -19.7, 1.6, 15, DEFAULT_ANGLE, 20, 20)
    end
    if FlagCheck(FLAG_GIMMICK_D14_380) then
      if GetExternalVariable("breakrubble_state") == "break_start" then
        local breakrubble = GetIndex(GIM, "fa_0005")
        LocatorObject(breakrubble).Motion_PlayMotion("e001", 10, false)
        PlaySE(202001, 100)
        SetExternalVariable("breakrubble_state", "break_middle")
      elseif GetExternalVariable("breakrubble_state") == "break_middle" then
        local breakrubble = GetIndex(GIM, "fa_0005")
        gRubbleTimer = gRubbleTimer + elapsed_frame
        if 5 <= gRubbleTimer then
          LocatorObject(breakrubble).StartEffectScript(1)
          SetExternalVariable("breakrubble_state", "break_end")
        end
      elseif GetExternalVariable("breakrubble_state") == "break_end" then
        local breakrubble = GetIndex(GIM, "fa_0005")
        if LocatorObject(breakrubble).IsPlayingMotion("e001") == false then
          PlaySE(202007, 100)
          SetExternalVariable("breakrubble_state", "end")
        end
      end
    end
    if GetExternalVariable("AfterEvolveTutorialEvent") == "on" then
      CallEventScriptFunction("M020_Event_331B")
    end
  elseif gMapNum == 1406 then
    local bigrobo_effect = GetExternalVariable("bigrobo_effect")
    local bigrobo_effect_timing = GetExternalVariable("bigrobo_effect_timing")
    if bigrobo_effect == "init" and not FlagCheck(FLAG_MAIN_01_240) then
      SetExternalVariable("bigrobo_effect", "wait")
    elseif bigrobo_effect == "wait" and not FlagCheck(FLAG_MAIN_01_240) then
    elseif bigrobo_effect == "quake_change" and not FlagCheck(FLAG_MAIN_01_240) then
      QuakeStop()
      QuakeStart(0.05, 0.1, 15)
      SetExternalVariable("bigrobo_effect", "move")
    elseif bigrobo_effect == "move" and not FlagCheck(FLAG_MAIN_01_241) then
      SetExternalVariable("bigrobo_effect_timing", bigrobo_effect_timing + elapsed_frame)
      if bigrobo_effect_timing >= gBigRoboEffectTiming then
        SetExternalVariable("bigrobo_effect", "impact")
        FlagSet(FLAG_MAIN_01_241)
      end
    elseif bigrobo_effect == "impact" and 0 < elapsed_frame then
      local impact_frame = GetExternalVariable("bigrobo_impact_frame")
      QuakeStop()
      QuakeStart(0.05, 0.125, 15)
      PlayEffectScript("ef_f_chu_010_sm", 35.3, 0.5, -25, 0, 1)
      SetExternalVariable("bigrobo_impact_frame", impact_frame + elapsed_frame)
      if 30 <= impact_frame then
        QuakeStop()
        SetExternalVariable("bigrobo_effect", "wait")
      end
    end
  elseif gMapNum == 1409 then
    local chrono = GetIndex(NPC, "test_chrono")
    local chrono_state = GetExternalVariable("test_chrono_state")
    local act_no = GetExternalVariable("test_act_no")
    Npc(chrono).Physics_SetGravity(0)
    Npc(chrono).Physics_SetCollisionContactForNotHit()
    if chrono_state == "start" then
      gWaitFrame = 0
      Npc(chrono).Motion_PlayMotionAndSetting("bv01", 0, 0, 0, gChronoBv01End, 0.5, false)
      SetExternalVariable("test_chrono_state", "wait")
      SetExternalVariable("test_act_no", 1)
    elseif chrono_state == "wait" then
      gWaitFrame = gWaitFrame + elapsed_frame
      if act_no == 1 then
        if gWaitFrame >= 60 then
          QuakeStart(0.5, 0, 90)
          gWaitFrame = 0
          SetExternalVariable("test_act_no", 1.5)
        end
      elseif act_no == 1.5 then
        if Npc(chrono).IsPlayingMotion("bv01") == false then
          SetExternalVariable("test_chrono_state", "ready")
        end
      elseif act_no == 2 then
        gWaitFrame = gWaitFrame + elapsed_frame
        if 30 <= gWaitFrame then
          gWaitFrame = 0
          SetExternalVariable("test_chrono_state", "walk_1")
        end
      elseif act_no == 3 then
        gWaitFrame = gWaitFrame + elapsed_frame
        if gWaitFrame >= 60 then
          SetExternalVariable("building_state", "break_1")
          SetExternalVariable("test_act_no", 3.5)
        end
      elseif act_no == 3.5 then
        if Npc(chrono).IsPlayingMotion("ba01") == false then
          gWaitFrame = 0
          SetExternalVariable("test_chrono_state", "ready2")
        end
      elseif act_no == 4 then
        gWaitFrame = gWaitFrame + elapsed_frame
        if 30 <= gWaitFrame then
          gWaitFrame = 0
          Npc(chrono).LinkToRailMove(gRailMoveFile, 2)
          SetExternalVariable("test_chrono_state", "walk_2")
        end
      elseif act_no == 5 then
        gWaitFrame = gWaitFrame + elapsed_frame
        if 100 <= gWaitFrame then
          SetExternalVariable("beam_state", "fire")
          SetExternalVariable("building_state", "break_3")
          SetExternalVariable("test_act_no", 5.5)
        end
      elseif act_no == 5.5 then
        if Npc(chrono).IsPlayingMotion("ba02") == false then
          gWaitFrame = 0
          SetExternalVariable("test_chrono_state", "ready3")
        end
      elseif act_no == 6 then
        gWaitFrame = gWaitFrame + elapsed_frame
        if gWaitFrame >= 120 then
          gWaitFrame = 0
          Npc(chrono).LinkToRailMove(gRailMoveFile, 3)
          SetExternalVariable("test_chrono_state", "walk_3")
        end
      end
    elseif chrono_state == "ready" then
      Npc(chrono).Motion_PlayMotionAndSetting("bn01", 30, 0, 0, gChronoBn01End, 0.5, true)
      SetExternalVariable("test_chrono_state", "wait")
      SetExternalVariable("test_act_no", 2)
    elseif chrono_state == "walk_1" then
      Npc(chrono).MoveMotion_StandbyMoveMotionSet("")
      Npc(chrono).RailMoveGo()
      if Npc(chrono).IsArrivalRailBothEnds() then
        SetExternalVariable("test_chrono_state", "attack_1")
      end
    elseif chrono_state == "attack_1" then
      Npc(chrono).Motion_PlayMotionAndSetting("ba01", 30, 0, 0, gChronoBa01End, 0.5, false)
      SetExternalVariable("test_chrono_state", "wait")
      SetExternalVariable("test_act_no", 3)
    elseif chrono_state == "ready2" then
      Npc(chrono).Motion_PlayMotionAndSetting("bn01", 30, 0, 0, gChronoBn01End, 0.5, true)
      SetExternalVariable("test_chrono_state", "wait")
      SetExternalVariable("test_act_no", 4)
    elseif chrono_state == "walk_2" then
      Npc(chrono).RailMoveGo()
      if act_no == 4 then
        gWaitFrame = gWaitFrame + elapsed_frame
        if gWaitFrame >= 500 then
          gWaitFrame = 0
          SetExternalVariable("building_state", "break_2")
          SetExternalVariable("test_act_no", 4.5)
        end
      end
      if Npc(chrono).IsArrivalRailBothEnds() then
        SetExternalVariable("test_chrono_state", "attack_2")
        local elv = GetIndex(GIM, "gim_0001")
        LocatorObject(elv).MoveStartLift(true)
        SetExternalVariable("player_state", "focus2")
      end
    elseif chrono_state == "attack_2" then
      Npc(chrono).Motion_PlayMotionAndSetting("ba02", 30, 0, 0, gChronoBa02End, 0.5, false)
      SetExternalVariable("test_chrono_state", "wait")
      SetExternalVariable("test_act_no", 5)
    elseif chrono_state == "ready3" then
      Npc(chrono).Motion_PlayMotionAndSetting("bn01", 30, 0, 0, gChronoBn01End, 0.5, true)
      SetExternalVariable("test_chrono_state", "wait")
      SetExternalVariable("test_act_no", 6)
    elseif chrono_state == "walk_3" then
      Npc(chrono).RailMoveGo()
      if Npc(chrono).IsArrivalRailBothEnds() then
        SetExternalVariable("player_state", "focus3")
        SetExternalVariable("test_chrono_state", "end_loop")
      end
    elseif chrono_state == "end_loop" then
      Npc(chrono).Motion_PlayMotionAndSetting("bn01", 30, 0, 0, gChronoBn01End, 0.5, true)
      SetExternalVariable("test_chrono_state", "Initialize")
    end
    local beam_state = GetExternalVariable("beam_state")
    if beam_state == "fire" then
      local chrono_r = Npc(chrono).GetRotationY()
      PlayEffectScript("ef_f_tes_001_be", -248, -305, -210, chrono_r, 1)
      SetExternalVariable("beam_state", "Initialize")
    end
    local building_state = GetExternalVariable("building_state")
    if building_state == "break_1" then
      local building1 = GetIndex(GIM, "obj_0001")
      LocatorObject(building1).Motion_PlayMotion("e002", 0, false)
      SetExternalVariable("building_state", "Initialize")
      SetExternalVariable("break_eff_state", "break_1")
    elseif building_state == "break_2" then
      local building2 = GetIndex(GIM, "obj_0002")
      LocatorObject(building2).Motion_PlayMotion("e001", 0, false)
      SetExternalVariable("building_state", "Initialize")
      SetExternalVariable("break_eff_state", "break_2")
    elseif building_state == "break_3" then
      local building101 = GetIndex(GIM, "obj_0101")
      local building102 = GetIndex(GIM, "obj_0102")
      local building103 = GetIndex(GIM, "obj_0103")
      local building104 = GetIndex(GIM, "obj_0104")
      local building105 = GetIndex(GIM, "obj_0105")
      local building106 = GetIndex(GIM, "obj_0106")
      local building107 = GetIndex(GIM, "obj_0107")
      local building108 = GetIndex(GIM, "obj_0108")
      LocatorObject(building101).Motion_PlayMotion("e001", 0, false)
      LocatorObject(building102).Motion_PlayMotion("e001", 0, false)
      LocatorObject(building103).Motion_PlayMotion("e001", 0, false)
      LocatorObject(building104).Motion_PlayMotion("e001", 0, false)
      LocatorObject(building105).Motion_PlayMotion("e001", 0, false)
      LocatorObject(building106).Motion_PlayMotion("e001", 0, false)
      LocatorObject(building107).Motion_PlayMotion("e001", 0, false)
      LocatorObject(building108).Motion_PlayMotion("e001", 0, false)
      SetExternalVariable("building_state", "Initialize")
      SetExternalVariable("break_eff_state", "break_3")
    end
    local break_eff_state = GetExternalVariable("break_eff_state")
    if break_eff_state == "break_1" then
      local building = GetIndex(GIM, "obj_0001")
      local building_x, building_y, building_z = LocatorObject(building).GetPosition()
      PlayEffectScript("ef_f_com_300_sm", building_x, building_y, building_z, 0, 50)
      gEffWait = 0
      SetExternalVariable("break_eff_state", "break_1a")
    elseif break_eff_state == "break_1a" then
      gEffWait = gEffWait + elapsed_frame
      if 15 <= gEffWait then
        local building = GetIndex(GIM, "obj_0001")
        local building_x, building_y, building_z = LocatorObject(building).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x + 30, building_y + 80, building_z + 20, 0, 50)
        PlayEffectScript("ef_f_com_300_sm", building_x - 20, building_y + 50, building_z + 30, 0, 50)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "break_1b")
      end
    elseif break_eff_state == "break_1b" then
      gEffWait = gEffWait + elapsed_frame
      if 15 <= gEffWait then
        local building = GetIndex(GIM, "obj_0001")
        local building_x, building_y, building_z = LocatorObject(building).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x + 30, building_y + 50, building_z + 20, 0, 50)
        PlayEffectScript("ef_f_com_300_sm", building_x - 20, building_y + 20, building_z + 30, 0, 50)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "break_1c")
      end
    elseif break_eff_state == "break_1c" then
      gEffWait = gEffWait + elapsed_frame
      if 15 <= gEffWait then
        local building = GetIndex(GIM, "obj_0001")
        local building_x, building_y, building_z = LocatorObject(building).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x + 30, building_y + 20, building_z + 20, 0, 50)
        PlayEffectScript("ef_f_com_300_sm", building_x - 20, building_y + 0, building_z + 30, 0, 50)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "Initialize")
      end
    elseif break_eff_state == "break_2" then
      local building = GetIndex(GIM, "obj_0002")
      local building_x, building_y, building_z = LocatorObject(building).GetPosition()
      PlayEffectScript("ef_f_com_300_sm", building_x + 33, building_y + 48, building_z + 16, 0, 50)
      PlayEffectScript("ef_f_com_300_sm", building_x - 16, building_y + 156, building_z - 33, 0, 30)
      gEffWait = 0
      SetExternalVariable("break_eff_state", "break_2a")
    elseif break_eff_state == "break_2a" then
      gEffWait = gEffWait + elapsed_frame
      if 10 <= gEffWait then
        local building = GetIndex(GIM, "obj_0002")
        local building_x, building_y, building_z = LocatorObject(building).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x + 33, building_y + 48, building_z + 16, 0, 50)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "break_2b")
      end
    elseif break_eff_state == "break_2b" then
      gEffWait = gEffWait + elapsed_frame
      if 10 <= gEffWait then
        local building = GetIndex(GIM, "obj_0002")
        local building_x, building_y, building_z = LocatorObject(building).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x - 16, building_y + 156, building_z - 33, 0, 30)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "break_2c")
      end
    elseif break_eff_state == "break_2c" then
      gEffWait = gEffWait + elapsed_frame
      if gEffWait >= 70 then
        local building = GetIndex(GIM, "obj_0002")
        local building_x, building_y, building_z = LocatorObject(building).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x - 73, building_y, building_z + 73, 0, 30)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "break_2d")
      end
    elseif break_eff_state == "break_2d" then
      gEffWait = gEffWait + elapsed_frame
      if 10 <= gEffWait then
        local building = GetIndex(GIM, "obj_0002")
        local building_x, building_y, building_z = LocatorObject(building).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x - 136, building_y, building_z + 136, 0, 50)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "Initialize")
      end
    elseif break_eff_state == "break_3" then
      local building101 = GetIndex(GIM, "obj_0101")
      local building_x, building_y, building_z = LocatorObject(building101).GetPosition()
      PlayEffectScript("ef_f_com_300_sm", building_x, building_y, building_z, 0, 5)
      PlayEffectScript("ef_f_com_300_sm", building_x + 20, building_y, building_z + 20, 0, 50)
      PlayEffectScript("ef_f_com_300_sm", building_x + 30, building_y, building_z + 30, 0, 50)
      PlayEffectScript("ef_f_com_300_sm", building_x + 50, building_y, building_z + 50, 0, 50)
      SetExternalVariable("break_eff_state", "break_3a")
    elseif break_eff_state == "break_3a" then
      gEffWait = gEffWait + elapsed_frame
      if 90 <= gEffWait then
        local building101 = GetIndex(GIM, "obj_0101")
        local building_x, building_y, building_z = LocatorObject(building101).GetPosition()
        PlayEffectScript("ef_f_com_300_sm", building_x + 30, building_y, building_z + 20, 0, 50)
        PlayEffectScript("ef_f_com_300_sm", building_x - 20, building_y, building_z + 30, 0, 50)
        gEffWait = 0
        SetExternalVariable("break_eff_state", "Initialize")
      end
    end
    local chrono_x, chrono_y, chrono_z = Npc(chrono).GetPosition()
    local player_state = GetExternalVariable("player_state")
    if player_state == "focus1" then
      gCamWait = 0
      StartFocusCamera(chrono_x, chrono_y + 230, chrono_z, 9999, 0, nil, 5, 10, 0)
    elseif player_state == "focus2" then
      StartFocusCamera(chrono_x, chrono_y + 200, chrono_z, 9999, 0, nil, 5, 10, 60)
      gCamWait = gCamWait + elapsed_frame
      if gCamWait >= 300 then
        SetExternalVariable("player_state", "focus2.5")
      end
    elseif player_state == "focus2.5" then
      StartFocusCamera(chrono_x, chrono_y + 80, chrono_z, 9999, 0, nil, 5, 10, 120)
    elseif player_state == "focus3" then
      StartFocusCamera(chrono_x, chrono_y + 120, chrono_z, 9999, 0, nil, 2, 1, 120)
    elseif player_state == "focus_end" then
      EndFocusCamera(chrono_x, chrono_z, 30, nil)
      SetExternalVariable("player_state", "Initialize")
    end
  end
end

function OnFieldAttackSymbolEnemy(index, args)
  if args.defeat and not FlagCheck(FLAG_MAIN_01_254) then
    CallEventScriptFunction("M020_Event_145")
  end
end
