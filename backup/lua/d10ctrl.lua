require("function_control")
DEFINE_FLAG("FLAG_FIELD_D10_010")
DEFINE_FLAG("FLAG_MAIN_01_110")
DEFINE_FLAG("FLAG_MAIN_01_080")
DEFINE_FLAG("FLAG_GIMMICK_D10_110")
DEFINE_FLAG("FLAG_GIMMICK_D10_111")
DEFINE_FLAG("FLAG_GIMMICK_D10_112")
DEFINE_FLAG("FLAG_GIMMICK_D10_113")
DEFINE_FLAG("FLAG_GIMMICK_D10_114")
DEFINE_FLAG("FLAG_GIMMICK_D10_115")
DEFINE_FLAG("FLAG_GIMMICK_D10_116")
DEFINE_FLAG("FLAG_FIELD_D10_012")
DEFINE_FLAG("FLAG_FIELD_D10_013")
DEFINE_FLAG("FLAG_GIMMICK_D10_060")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
gTimer = 0
gExpression = "F05"

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== gMapNum = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  if gMapNum == 1001 then
    LoadRailMove(gRailMoveFile)
    Player().LoadExpression(gExpression)
    Player().LoadExpression("F14")
    local mgreymon = GetIndex(ENEMY, "chr327_chaser")
    SymbolEnemy(mgreymon).LoadMoveMotion("symbol01")
    SymbolEnemy(mgreymon).LoadMotion("bn01")
    SymbolEnemy(mgreymon).LoadMotion("ba02")
    SymbolEnemy(mgreymon).LoadMotion("fe02")
    local obj1 = GetIndex(GIM, "obj_0008")
    local obj2 = GetIndex(GIM, "obj_0009")
    local obj3 = GetIndex(GIM, "obj_0010")
    local obj4 = GetIndex(GIM, "obj_0011")
    local obj5 = GetIndex(GIM, "obj_0012")
    LocatorObject(obj1).AttachEffectScript("ef_f_com_300_sm", false, 1, false, false, false, false)
    LocatorObject(obj2).AttachEffectScript("ef_f_com_300_sm", false, 2, false, false, false, false)
    LocatorObject(obj3).AttachEffectScript("ef_f_com_300_sm", false, 3, false, false, false, false)
    LocatorObject(obj4).AttachEffectScript("ef_f_com_300_sm", false, 4, false, false, false, false)
    LocatorObject(obj5).AttachEffectScript("ef_f_com_300_sm", false, 5, false, false, false, false)
  elseif gMapNum == 1002 then
  elseif gMapNum == 1003 then
  elseif gMapNum == 1004 then
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== gMapNum = ", gMapNum, " ======")
  gWaitCount = 0
  if gMapNum == 1001 then
    if FlagCheck(FLAG_FIELD_D10_010) then
      local mgreymon = GetIndex(ENEMY, "chr327_chaser")
      SetExternalVariable("player_state", "initialize")
      SetExternalVariable("mgreymon_state", "initialize")
      SetExternalVariable("encounter_state", "initialize")
      SymbolEnemy(mgreymon).LinkToRailMove(gRailMoveFile, "rail_move_100")
      SymbolEnemy(mgreymon).SetRailMoveInDimension2d()
      gTimer = 0
    end
  elseif gMapNum == 1004 then
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 1001 then
    local mgreymon = GetIndex(ENEMY, "chr327_chaser")
  elseif gMapNum == 1004 then
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
  if gMapNum == 1001 then
    if FlagCheck(FLAG_FIELD_D10_010) then
      local mgreymon = GetIndex(ENEMY, "chr327_chaser")
      SymbolEnemy(mgreymon).SymbolDiscoveryCheck()
      local mgreymon_state = GetExternalVariable("mgreymon_state")
      local direction = SymbolEnemy(mgreymon).GetRailMoveDirection()
      if not SymbolEnemy(mgreymon).IsSymbolOfDiscoveryInAction() == true then
        SymbolEnemy(mgreymon).MoveMotion_StandbyMoveMotionSet("symbol01")
        if mgreymon_state == "relocation" then
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_relocation", 0)
          SymbolEnemy(mgreymon).Move_SetPosition(33.467, 0.152, -4.235)
          SymbolEnemy(mgreymon).SetRailMoveDirection(false)
          SetExternalVariable("mgreymon_state", "roaming")
        elseif mgreymon_state == "relocation2" then
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_relocation2", 0)
          SymbolEnemy(mgreymon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          SetExternalVariable("mgreymon_state", "standby")
          SymbolEnemy(mgreymon).Move_SetRotationY(270, 0)
        elseif mgreymon_state == "relocation3" then
          SymbolEnemy(mgreymon).Move_Stop()
          SymbolEnemy(mgreymon).SymbolForcedDiscovery(true)
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_relocation3", 0)
          SymbolEnemy(mgreymon).Move_SetRotationY(270, 0)
          SymbolEnemy(mgreymon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          SetExternalVariable("mgreymon_state", "standby")
        elseif mgreymon_state == "standby" then
          SymbolEnemy(mgreymon).Move_Stop()
          if FlagCheck(FLAG_GIMMICK_D10_115) then
          end
        elseif mgreymon_state == "roaming" then
          SymbolEnemy(mgreymon).SetRailMoveInDimension2d()
          SymbolEnemy(mgreymon).SetRailMoveSpeed(6)
          SymbolEnemy(mgreymon).LinkToRailMove("d1001_railmove", "rail_move_100")
          SymbolEnemy(mgreymon).RailMoveGo()
          if SymbolEnemy(mgreymon).IsArrivalRailBothEnds() then
            if direction == true then
              SymbolEnemy(mgreymon).SetRailMoveDirection(false)
            elseif direction == false then
              SymbolEnemy(mgreymon).SetRailMoveDirection(true)
            end
            SetExternalVariable("mgreymon_state", "railend_standby")
          end
        elseif mgreymon_state == "railend_standby" then
          SymbolEnemy(mgreymon).Move_Stop()
          gWaitCount = gWaitCount + elapsed_frame
          if gWaitCount >= 180 then
            SetExternalVariable("mgreymon_state", "roaming")
            gWaitCount = 0
          end
        elseif mgreymon_state == "roaming2" then
          SymbolEnemy(mgreymon).SetRailMoveInDimension2d()
          SymbolEnemy(mgreymon).SetRailMoveSpeed(6)
          SymbolEnemy(mgreymon).LinkToRailMove("d1001_railmove", "rail_move_101")
          SymbolEnemy(mgreymon).SetRailMoveDirection(true)
          SymbolEnemy(mgreymon).RailMoveGo()
          if SymbolEnemy(mgreymon).IsArrivalRailBothEnds() then
            SymbolEnemy(mgreymon).Move_Stop()
          end
        elseif mgreymon_state == "roaming3" then
          SymbolEnemy(mgreymon).SetRailMoveInDimension2d()
          SymbolEnemy(mgreymon).SetRailMoveSpeed(6)
          SymbolEnemy(mgreymon).LinkToRailMove("d1001_railmove", "rail_move_103")
          SymbolEnemy(mgreymon).RailMoveGo()
          if SymbolEnemy(mgreymon).IsArrivalRailBothEnds() then
            if direction == true then
              SymbolEnemy(mgreymon).SetRailMoveDirection(false)
            elseif direction == false then
              SymbolEnemy(mgreymon).SetRailMoveDirection(true)
            end
            SetExternalVariable("mgreymon_state", "railend_standby3")
          end
        elseif mgreymon_state == "railend_standby3" then
          SymbolEnemy(mgreymon).Move_Stop()
          gWaitCount = gWaitCount + elapsed_frame
          if gWaitCount >= 5 then
            SetExternalVariable("mgreymon_state", "roaming3")
            gWaitCount = 0
          end
        elseif mgreymon_state == "roaming4" then
          SymbolEnemy(mgreymon).SetRailMoveInDimension2d()
          SymbolEnemy(mgreymon).SetRailMoveSpeed(6)
          SymbolEnemy(mgreymon).LinkToRailMove("d1001_railmove", "rail_move_102")
          SymbolEnemy(mgreymon).RailMoveGo()
          if SymbolEnemy(mgreymon).IsArrivalRailBothEnds() then
            if direction == true then
              SymbolEnemy(mgreymon).SetRailMoveDirection(false)
            elseif direction == false then
              SymbolEnemy(mgreymon).SetRailMoveDirection(true)
            end
            SetExternalVariable("mgreymon_state", "railend_standby2")
          end
        elseif mgreymon_state == "railend_standby2" then
          SymbolEnemy(mgreymon).Move_Stop()
          gWaitCount = gWaitCount + elapsed_frame
          if gWaitCount >= 60 then
            SetExternalVariable("mgreymon_state", "roaming4")
            gWaitCount = 0
          end
        end
        if mgreymon_state == "undiscovery" then
          SymbolEnemy(mgreymon).Move_Stop()
          gWaitCount = gWaitCount + elapsed_frame
          if gWaitCount >= 120 then
            SetExternalVariable("mgreymon_state", "roaming4")
            gWaitCount = 0
          end
        end
        local time = SymbolEnemy(mgreymon).GetMotionEvalFrame("br01")
        local footef_x, footef_y, footef_z = SymbolEnemy(mgreymon).GetPosition()
        local se_vol = 0
        local move_obj_x, move_obj_y, move_obj_z = GetPositionAnyObjectIndex(ENEMY, mgreymon)
        local target_x, target_y, target_z = GetPositionAnyObjectIndex(PLAYER, 1)
        local foot_dist = GetDistanceBetweenTwoObject2D(move_obj_x, move_obj_z, target_x, target_z)
        if foot_dist <= 15 then
          se_vol = 100
        elseif foot_dist <= 20 then
          se_vol = 30
        elseif foot_dist <= 25 then
          se_vol = 10
        else
          se_vol = 0
        end
        if 3 <= time and time <= 5 then
          PlayAndGlobalManageSE("403105", se_vol, 0, 1, true, true)
        elseif 14 <= time and time <= 16 then
          PlayAndGlobalManageSE("403105", se_vol, 0, 2, true, true)
        end
      else
        if mgreymon_state == "undiscovery" then
          SymbolEnemy(mgreymon).Move_Stop()
          gWaitCount = gWaitCount + elapsed_frame
          if gWaitCount >= 120 then
            SetExternalVariable("mgreymon_state", "roaming4")
            gWaitCount = 0
          end
        end
        local time = SymbolEnemy(mgreymon).GetMotionEvalFrame("br01")
        local footef_x, footef_y, footef_z = SymbolEnemy(mgreymon).GetPosition()
        if 3 <= time and time <= 5 then
          if FlagCheck(FLAG_FIELD_D10_013) == true then
            PlayAndGlobalManageSE("403105", 100, 0, 1, true, true)
            PlayEffectScript("ef_f_com_300_sm", footef_x, footef_y - 0.5, footef_z, 0, 1)
          end
        elseif 14 <= time and time <= 16 and FlagCheck(FLAG_FIELD_D10_013) == true then
          PlayAndGlobalManageSE("403105", 100, 0, 2, true, true)
        end
        if mgreymon_state == "relocation" then
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_relocation", 0)
          SymbolEnemy(mgreymon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          SetExternalVariable("mgreymon_state", "roaming")
        elseif mgreymon_state == "relocation2" then
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_relocation2", 0)
          SymbolEnemy(mgreymon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          SetExternalVariable("mgreymon_state", "standby")
        elseif mgreymon_state == "relocation3" then
          SymbolEnemy(mgreymon).Move_Stop()
          SymbolEnemy(mgreymon).SymbolForcedDiscovery(true)
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_relocation3", 0)
          SymbolEnemy(mgreymon).Move_SetRotationY(270, 0)
          SymbolEnemy(mgreymon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          SetExternalVariable("mgreymon_state", "standby")
        end
      end
    end
    if FlagCheck(FLAG_FIELD_D10_010) == true and FlagCheck(FLAG_MAIN_01_110) == false then
      local mgreymon = GetIndex(ENEMY, "chr327_chaser")
      local obj1 = GetIndex(GIM, "obj_0008")
      local obj2 = GetIndex(GIM, "obj_0009")
      local obj3 = GetIndex(GIM, "obj_0010")
      local obj4 = GetIndex(GIM, "obj_0011")
      local obj5 = GetIndex(GIM, "obj_0012")
      if SymbolEnemy(mgreymon).Exists() then
        SymbolEnemy(mgreymon).SymbolForcedDiscovery(true)
      end
      if not FlagCheck(FLAG_GIMMICK_D10_110) and IsArrivalPosition(ENEMY, mgreymon, GIM, obj1, 5) then
        PlaySE(202003, 60)
        LocatorObject(obj1).StartEffectScript(1)
        LocatorObject(obj1).Invisible(30, false)
        FlagSet(FLAG_GIMMICK_D10_110)
      end
      if not FlagCheck(FLAG_GIMMICK_D10_111) and IsArrivalPosition(ENEMY, mgreymon, GIM, obj2, 5) then
        PlaySE(202003, 60)
        LocatorObject(obj2).StartEffectScript(2)
        LocatorObject(obj2).Invisible(30, false)
        FlagSet(FLAG_GIMMICK_D10_111)
      end
      if not FlagCheck(FLAG_GIMMICK_D10_112) and IsArrivalPosition(ENEMY, mgreymon, GIM, obj3, 5) then
        PlaySE(202003, 60)
        LocatorObject(obj3).StartEffectScript(3)
        LocatorObject(obj3).Invisible(30, false)
        FlagSet(FLAG_GIMMICK_D10_112)
      end
      if not FlagCheck(FLAG_GIMMICK_D10_113) and IsArrivalPosition(ENEMY, mgreymon, GIM, obj4, 5) then
        PlaySE(202003, 60)
        LocatorObject(obj4).StartEffectScript(4)
        LocatorObject(obj4).Invisible(30, false)
        FlagSet(FLAG_GIMMICK_D10_113)
      end
      if not FlagCheck(FLAG_GIMMICK_D10_114) and IsArrivalPosition(ENEMY, mgreymon, GIM, obj5, 5) then
        PlaySE(202003, 60)
        LocatorObject(obj5).StartEffectScript(5)
        LocatorObject(obj5).Invisible(30, false)
        FlagSet(FLAG_GIMMICK_D10_114)
      end
    end
    if FlagCheck(FLAG_FIELD_D10_010) and not FlagCheck(FLAG_MAIN_01_110) then
      if FlagCheck(FLAG_FIELD_D10_012) then
        Player().Motion_ChangeExpression(gExpression, EYES_BLINK_TYPE_OPEN, false, 0, false, 0)
        local obj1 = GetIndex(GIMMICK, "lookat_01")
        local obj2 = GetIndex(GIMMICK, "lookat_02")
        local obj3 = GetIndex(GIMMICK, "lookat_03")
        local pos_x, pos_y, pos_z = Gimmick(obj1).GetPosition()
        if IsArrivalPosition(GIMMICK, obj1, PLAYER, 1, 10) then
          local mgreymon = GetIndex(ENEMY, "chr327_chaser")
          pos_x, pos_y, pos_z = SymbolEnemy(mgreymon).GetPosition()
          Player().Motion_AimOnlyThisFrame(pos_x, pos_y + 2, pos_z + 5, 10, 15, 100)
        elseif IsArrivalPosition(GIMMICK, obj3, PLAYER, 1, 10) then
          local mgreymon = GetIndex(ENEMY, "chr327_chaser")
          pos_x, pos_y, pos_z = SymbolEnemy(mgreymon).GetPosition()
          Player().Motion_AimOnlyThisFrame(pos_x, pos_y + 2, pos_z, 10, 15, 100)
        end
      else
        Player().Motion_ChangeExpression("F14", EYES_BLINK_TYPE_OPEN, false, 0, false, 0)
      end
    end
    if FlagCheck(FLAG_FIELD_D10_010) and not FlagCheck(FLAG_GIMMICK_D10_060) then
      local mgreymon = GetIndex(ENEMY, "chr327_chaser")
      if IsArrivalPosition(ENEMY, mgreymon, PLAYER, 1, 5) then
        gTimer = 0
        Player().Motion_ChangeExpression("F14", EYES_BLINK_TYPE_OPEN, false, 0, false, 0)
        CallEventScriptFunction("Prcs_d1001_CatchedGreymon")
      end
    end
    if FlagCheck(FLAG_FIELD_D10_012) and not FlagCheck(FLAG_MAIN_01_110) then
      local operatedegrees = GetLeftAxisDegrees()
      local speed = 0
      local rail_direction = true
      if operatedegrees ~= nil then
        if 90 < operatedegrees and operatedegrees < 270 then
          rail_direction = true
          speed = GetLeftAxisPlayerMoveMaxSpeed(false) * GetLeftAxisPlayerMoveOperateRate()
        else
          rail_direction = false
          speed = GetLeftAxisPlayerMoveMaxSpeed(false) * GetLeftAxisPlayerMoveOperateRate()
        end
      elseif 30 >= gTimer then
        speed = 8
        rail_direction = true
        gTimer = gTimer + elapsed_frame
      end
      Player().LinkToRailMove("d1001_railmove", "rail_move_200")
      Player().SetRailMoveDirection(rail_direction)
      Player().SetRailMoveSpeed(speed * 0.85)
      Player().SetRailMoveInDimension2d()
      Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(0.3)
      Player().RailMoveGo()
    end
  elseif gMapNum == 1004 then
  end
end

function OnEncountSymbolEnemy(object_index, args)
  if gMapNum == 1003 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    if not FlagCheck(FLAG_MAIN_01_080) then
      return REACTION_TO_ENCOUN_FORCE_NORMAL_ENCOUNT
    end
  end
end
