require("function_control")
DEFINE_FLAG("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
DEFINE_FLAG("AREA_OPEN_DEBUG")
DEFINE_FLAG("FLAG_IS_FLIGHT_RIDE")
DEFINE_FLAG("FLAG_GIMMICK_D04_310")
DEFINE_FLAG("FLAG_GIMMICK_D04_300")
DEFINE_FLAG("FLAG_MAIN_06_015")
DEFINE_FLAG("FLAG_MAIN_06_016")
DEFINE_FLAG("FLAG_MAIN_06_017")
DEFINE_FLAG("FLAG_MAIN_06_026")
DEFINE_FLAG("FLAG_MAIN_06_028")
DEFINE_FLAG("FLAG_MAIN_06_029")
DEFINE_FLAG("FLAG_MAIN_06_044")
DEFINE_FLAG("FLAG_MAIN_06_045")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H418")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H510")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H811")
DEFINE_FLAG("FLAG_SUB_110_109_002")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
CAMERA_FRAME = 0
Y_POS = 40
X_POS = 36
Z_POS = 75
SPEED = 0
ACCEL_FRAME = 0
SPEED_DOWN = 0
DELAY_FRAME = 0
Add_Rotate = 0
Add_Rotate2 = 0

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  PlayerSystem.PlayerAlwaysLoadMotion("fn01_01")
  Player().LoadAttachment(1)
  Player().LoadMotion("bn01")
  Player().LoadMoveMotion("npc01")
  AddCameraLoad("cam53_railcam")
  AddCameraLoad("cam01_railcam")
  LoadLocatorModel(gPlanData)
  if gMapNum == 401 or gMapNum == 402 or gMapNum == 403 or gMapNum == 404 or gMapNum == 405 then
    LoadRailMove(gRailMoveFile)
  end
  if gMapNum == 401 then
  elseif gMapNum == 403 then
    LoadEffectScript("ef_b_buf_100", 1)
    LoadEffectScript("ef_b_com_120_rock", 1)
  elseif gMapNum == 404 then
    LoadLocatorModel(gPlanData)
    local Door_1F = GetIndex(GIM, "obj_0001")
    LocatorObject(Door_1F).LoadMotion("e001")
    local Door_2F = GetIndex(GIM, "obj_0002")
    LocatorObject(Door_2F).LoadMotion("e001")
  elseif gMapNum == 405 then
    LoadLocatorModel(gPlanData)
    LoadRailMove("d0405_railmove")
    Player().LoadMoveMotion("")
    LoadEffectScript("ef_f_com_131_sm", 1)
  elseif gMapNum == 407 then
    local jureimon = GetIndex(GIMMICK, "fa_jureimon")
    Gimmick(jureimon).LoadMotion("fe02")
    Gimmick(jureimon).LoadMotion("bn01")
    Gimmick(jureimon).LoadMotion("bv01")
    Gimmick(jureimon).LoadMotion("fq01")
    Gimmick(jureimon).LoadMotion("fq02")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  if gMapNum == 401 then
    SetExternalVariable("focus_camera", "initialize")
    SetExternalVariable("guest_palmon02_state", "Initialize")
    CameraSwitchChange("followcam_default_loc", true)
  elseif gMapNum == 403 then
    SetExternalVariable("speed", "Initialize")
  elseif gMapNum == 404 then
  elseif map_num == 405 then
    Player().LinkToRailMove("d0405_railmove", 99)
    Player().SetRailMoveInDimension3d()
    Player().SetRailMoveSpeed(20)
    Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(20)
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 401 then
  end
end

function Update(elapsed_frame)
  gPlayer_State = GetExternalVariable("player_state")
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
  if gMapNum == 401 then
    StartSeamlessJumpRide()
    local chr367_state = GetExternalVariable("chr367_state")
    local chr367 = GetIndex(GIM, "obj_0001")
    if chr367_state == "run_away" then
      local x, y, z = LocatorObject(chr367).GetPosition()
      StartFocusCamera(x, y, z, 30, 0, 5)
      LocatorObject(chr367).LinkToRailMove("d0401_railmove", 101)
      LocatorObject(chr367).SetRailMoveSpeed(18)
      LocatorObject(chr367).RailMoveGo()
      LocatorObject(chr367).Physics_SetCollisionContactForNotHit()
      LocatorObject(chr367).Physics_SetGravity(0)
    elseif chr367_state == "damaged" then
      local x, y, z = LocatorObject(chr367).GetPosition()
      StartFocusCamera(x, y, z, 30, 0, 5)
    end
    local focus_camera = GetExternalVariable("focus_camera")
    if focus_camera == "start" then
      StartFocusCamera(-33.2, 9.1, 66, 20, 0, 5)
    elseif focus_camera == "end" then
      EndFocusCamera(-33.2, 66, 15)
      SetExternalVariable("focus_camera", "Initialize")
    end
    if FlagCheck(FLAG_IS_FLIGHT_RIDE) then
      local map_id = GetExternalVariable("map_id")
      local fly_root = GetExternalVariable("fly_root")
      local speed = 10
      local rail_move
      if map_id == 401 then
        if fly_root == "ride_fly_0002" then
          rail_move = "rail_move_200"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "start_02" then
          rail_move = "rail_move_200"
          Player().SetRailMoveDirection(false)
        end
        Player().LinkToRailMove("d0401_railmove", rail_move)
        Player().SetRailMoveSpeed(speed)
        Player().SetRailMoveInDimension2d()
        Player().RailMoveGo()
        if Player().IsArrivalRailBothEnds() then
          SetExternalVariable("fly_root", "")
          SetExternalVariable("map_id", "")
          FlagClear(FLAG_IS_FLIGHT_RIDE)
        end
      end
    end
    if not FlagCheck(FLAG_MAIN_06_028) then
      if not FlagCheck(FLAG_MAIN_06_015) then
        local badboys_state = GetExternalVariable("badboys_state")
        if badboys_state == "run" then
          local hokumon = GetIndex(RUMOR, "rumor_0001")
          local floramon = GetIndex(RUMOR, "rumor_0002")
          local speed = 10
          RumorNpc(hokumon).LinkToRailMove("d0401_railmove", "rail_move_102")
          RumorNpc(hokumon).Physics_SetCollisionContactForNotHit()
          RumorNpc(hokumon).Physics_SetGravity(0)
          RumorNpc(hokumon).SetRailMoveSpeed(speed)
          RumorNpc(hokumon).SetRailMoveInDimension2d()
          RumorNpc(hokumon).RailMoveGo()
          RumorNpc(floramon).LinkToRailMove("d0401_railmove", "rail_move_103")
          RumorNpc(floramon).Physics_SetCollisionContactForNotHit()
          RumorNpc(floramon).Physics_SetGravity(0)
          RumorNpc(floramon).SetRailMoveSpeed(speed)
          RumorNpc(floramon).SetRailMoveInDimension2d()
          RumorNpc(floramon).RailMoveGo()
          if RumorNpc(floramon).IsArrivalRailBothEnds() and RumorNpc(hokumon).IsArrivalRailBothEnds() then
            SetExternalVariable("badboys_state", "end")
            FlagSet(FLAG_MAIN_06_015)
          end
        end
      else
        local hokumon = GetIndex(RUMOR, "rumor_0001")
        local floramon = GetIndex(RUMOR, "rumor_0002")
        RumorNpc(hokumon).InvisibleInNowFrame(0, 0, true)
        RumorNpc(floramon).InvisibleInNowFrame(0, 0, true)
      end
    end
  elseif gMapNum == 402 then
    StartSeamlessJumpRide()
    if FlagCheck(FLAG_IS_FLIGHT_RIDE) then
      local map_id = GetExternalVariable("map_id")
      local fly_root = GetExternalVariable("fly_root")
      local speed = 10
      local rail_move
      if map_id == 402 then
        if fly_root == "ride_fly_0002" then
          rail_move = "rail_move_200"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "start_01" then
          rail_move = "rail_move_200"
          Player().SetRailMoveDirection(false)
        end
        Player().LinkToRailMove("d0402_railmove", rail_move)
        Player().SetRailMoveSpeed(speed)
        Player().SetRailMoveInDimension2d()
        Player().RailMoveGo()
        if Player().IsArrivalRailBothEnds() then
          SetExternalVariable("fly_root", "")
          SetExternalVariable("map_id", "")
          FlagClear(FLAG_IS_FLIGHT_RIDE)
        end
      end
    end
  elseif gMapNum == 403 then
    StartSeamlessJumpRide()
    if FlagCheck(FLAG_IS_FLIGHT_RIDE) then
      local map_id = GetExternalVariable("map_id")
      local fly_root = GetExternalVariable("fly_root")
      local speed = 9
      local rail_move
      if map_id == 403 then
        if fly_root == "ride_fly_0002" then
          rail_move = "rail_move_105"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "ride_fly_0005" then
          rail_move = "rail_move_105"
          Player().SetRailMoveDirection(false)
        elseif fly_root == "ride_fly_0009" then
          rail_move = "rail_move_100"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "ride_fly_0012" then
          rail_move = "rail_move_100"
          Player().SetRailMoveDirection(false)
        elseif fly_root == "ride_fly_0015" then
          rail_move = "rail_move_104"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "ride_fly_0018" then
          rail_move = "rail_move_101"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "ride_fly_0021" then
          rail_move = "rail_move_106"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "ride_fly_0024" then
          rail_move = "rail_move_103"
          Player().SetRailMoveDirection(true)
        elseif fly_root == "ride_fly_0030" then
          rail_move = "rail_move_102"
          Player().SetRailMoveDirection(false)
        end
        Player().LinkToRailMove("d0403_railmove", rail_move)
        Player().SetRailMoveSpeed(speed)
        Player().SetRailMoveInDimension2d()
        Player().RailMoveGo()
        SetFollowerCameraOperateRotationY(Player().GetRotationY())
        SetFollowerCameraOperateRotationX(10)
        if Player().IsArrivalRailBothEnds() then
          SetExternalVariable("fly_root", "")
          SetExternalVariable("map_id", "")
          FlagClear(FLAG_IS_FLIGHT_RIDE)
        end
      end
    end
    if not FlagCheck(FLAG_MAIN_06_026) then
      if not FlagCheck(FLAG_MAIN_06_016) then
        local badboys_state = GetExternalVariable("badboys_state")
        if badboys_state == "run" then
          local hokumon = GetIndex(RUMOR, "rumor_0001")
          local floramon = GetIndex(MOB, "mob_0501")
          local speed = 10
          RumorNpc(hokumon).LinkToRailMove("d0403_railmove", "rail_move_107")
          RumorNpc(hokumon).Physics_SetCollisionContactForNotHit()
          RumorNpc(hokumon).Physics_SetGravity(0)
          RumorNpc(hokumon).SetRailMoveSpeed(speed)
          RumorNpc(hokumon).SetRailMoveInDimension2d()
          RumorNpc(hokumon).RailMoveGo()
          Mob(floramon).LinkToRailMove("d0403_railmove", "rail_move_108")
          Mob(floramon).Physics_SetCollisionContactForNotHit()
          Mob(floramon).Physics_SetGravity(0)
          Mob(floramon).SetRailMoveSpeed(speed)
          Mob(floramon).SetRailMoveInDimension2d()
          Mob(floramon).RailMoveGo()
          if Mob(floramon).IsArrivalRailBothEnds() and RumorNpc(hokumon).IsArrivalRailBothEnds() then
            SetExternalVariable("badboys_state", "end")
            FlagSet(FLAG_MAIN_06_016)
          end
        end
      else
        local badboys_state = GetExternalVariable("badboys_state")
        if badboys_state == "end" then
          local hokumon = GetIndex(RUMOR, "rumor_0001")
          local floramon = GetIndex(MOB, "mob_0501")
          RumorNpc(hokumon).InvisibleInNowFrame(0, 0, true)
          Mob(floramon).InvisibleInNowFrame(0, 0, true)
        end
      end
      if FlagCheck(FLAG_MAIN_06_016) and not FlagCheck(FLAG_MAIN_06_017) then
        local badboys_state = GetExternalVariable("badboys_state")
        if badboys_state == "run2" then
          local hokumon = GetIndex(MOB, "mob_0500")
          local floramon = GetIndex(RUMOR, "rumor_0002")
          local speed = 10
          Mob(hokumon).LinkToRailMove("d0403_railmove", "rail_move_110")
          Mob(hokumon).Physics_SetCollisionContactForNotHit()
          Mob(hokumon).Physics_SetGravity(0)
          Mob(hokumon).SetRailMoveSpeed(speed)
          Mob(hokumon).SetRailMoveInDimension2d()
          Mob(hokumon).RailMoveGo()
          RumorNpc(floramon).LinkToRailMove("d0403_railmove", "rail_move_109")
          RumorNpc(floramon).Physics_SetCollisionContactForNotHit()
          RumorNpc(floramon).Physics_SetGravity(0)
          RumorNpc(floramon).SetRailMoveSpeed(speed)
          RumorNpc(floramon).SetRailMoveInDimension2d()
          RumorNpc(floramon).RailMoveGo()
          if RumorNpc(floramon).IsArrivalRailBothEnds() and Mob(hokumon).IsArrivalRailBothEnds() then
            SetExternalVariable("badboys_state", "end2")
            FlagSet(FLAG_MAIN_06_017)
          end
        end
      else
        local badboys_state = GetExternalVariable("badboys_state")
        if badboys_state == "end2" then
          local hokumon = GetIndex(MOB, "mob_0500")
          local floramon = GetIndex(RUMOR, "rumor_0002")
          Mob(hokumon).InvisibleInNowFrame(0, 0, true)
          RumorNpc(floramon).InvisibleInNowFrame(0, 0, true)
        end
      end
    end
  elseif gMapNum == 404 then
    local kabuteri = GetIndex(NPC, "npc_0007")
    local distance = GetDistanceToObject(NPC, kabuteri)
    local x1, y1, z1 = Npc(kabuteri).GetPosition()
    local player_x, player_y, player_z = Player().GetPosition()
    local player_angle = GetAngleToTarget2D(x1, z1, player_x, player_z)
    local kabuteri_angle = GetAngleToTarget2D(player_x, player_z, x1, z1)
    if not FlagCheck(FLAG_GIMMICK_D04_310) and FlagCheck(FLAG_GIMMICK_D04_300) and distance < 8 then
      Npc(kabuteri).Move_SetRotationY(player_angle, 8)
      Player().Move_SetRotationY(kabuteri_angle, 8)
      CallEventScriptFunction("Prcs_d0404_kabuteri_evt")
    end
    local Door_1F = GetIndex(GIM, "obj_0001")
    local Door_2F = GetIndex(GIM, "obj_0002")
    local Doorpoint_1F = GetIndex(GIM, "gim_0001")
    local Doorpoint_2F = GetIndex(GIM, "gim_0002")
    gPlayer_State = GetExternalVariable("player_state")
    if LocatorObject(Door_1F).IsPlayingMotion("e001") == true or LocatorObject(Door_2F).IsPlayingMotion("e001") == true then
      LocatorObject(Doorpoint_1F).SetEnablePlayerCheck(false)
      LocatorObject(Doorpoint_2F).SetEnablePlayerCheck(false)
    else
      LocatorObject(Doorpoint_1F).SetEnablePlayerCheck(true)
      LocatorObject(Doorpoint_2F).SetEnablePlayerCheck(true)
    end
    if gPlayer_State == "enter_1fdoor" then
      EnterWarpDoor("gim_0001", "script_1fdoor", 30, Door_1F, "e001")
    elseif gPlayer_State == "exit_2fdoor" then
      ExitWarpDoor("script_2fdoor", "gim_0002", 30, Door_2F, "e001")
      SetFollowerCameraOperateRotation(0, 150)
    elseif gPlayer_State == "enter_2fdoor" then
      EnterWarpDoor("gim_0002", "script_2fdoor", 30, Door_2F, "e001")
    elseif gPlayer_State == "exit_1fdoor" then
      ExitWarpDoor("script_1fdoor", "gim_0001", 30, Door_1F, "e001")
      SetFollowerCameraOperateRotation(0, 120)
    elseif gPlayer_State == "enter" then
      Player().Physics_SetGravity(0)
    end
  elseif gMapNum == 405 then
    StartSeamlessJumpRide()
  elseif gMapNum == 407 and not FlagCheck(FLAG_MAIN_06_045) then
    local jyureimon = GetIndex(GIMMICK, "fa_jureimon")
    local x1, y1, z1 = Gimmick(jyureimon).GetPosition()
    local player_x, player_y, player_z = Player().GetPosition()
    local player_angle = GetAngleToTarget2D(x1, z1, player_x, player_z)
    local distance = GetDistanceBetweenTwoObject2D(player_x, player_z, x1, z1)
    local player_rotate = Player().GetRotationY()
    local jurei_rotate = Gimmick(jyureimon).GetRotationY()
    local relative_rotate = math.abs(player_rotate - jurei_rotate)
    local cam_x, cam_y, cam_z = GetCameraPos(CAMERA_OPERATED_BY_PLAYER)
    local camera_angle = GetAngleToTarget2D(x1, z1, cam_x, cam_z)
    local camera_rotate = GetCameraRotationY(CAMERA_OPERATED_BY_PLAYER)
    local RightAxisDegrees = GetRightAxisDegrees()
    local LeftAxisDegrees = GetLeftAxisDegrees()
    if distance < 30 then
      Gimmick(jyureimon).Move_SetRotationY(player_angle + 180, 0)
    end
    if FlagCheck(FLAG_MAIN_06_044) then
      if relative_rotate <= 240 and 130 <= relative_rotate then
        Gimmick(jyureimon).Motion_PlayMotion("bv01", 30, true)
      else
        Gimmick(jyureimon).Motion_PlayMotion("bn01", 30, true)
      end
    end
  end
end

function OnAwayFromCollision(col_name)
  if gMapNum == 401 and col_name == "evt_9002" then
    SetExternalVariable("ride_fly", "play_out_motion")
  end
  if gMapNum == 403 and col_name == "evt_9004" then
    SetExternalVariable("ride_fly", "play_out_motion")
  end
end

function OnDefeatedSymbolEnemy(symbol_index, args)
  local is_fa = args.by_field_attack
  if gMapNum == 403 and is_fa == true then
    local name = SymbolEnemy(symbol_index).GetUniqueName()
    if name == "s110_109_005" then
      FlagSet(FLAG_SUB_110_109_002)
      CallEventScriptFunction("S110_109_Event_035")
    end
  end
end

function CheckHazamaGateFound(object_type, object_index, args)
  print("=============== CheckHazamaGateFound object_type = ", object_type, "=====================")
  if object_type == OGIM then
    print("=============== CheckHazamaGateFound GIMMICK_OBJECT_TYPE =====================")
    local name = Gimmick(object_index).GetUniqueName()
    if string.find(name, "hazama_gate") ~= nil then
      local first_discovery = true
      if gMapNum == 405 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H418) then
          FlagSet(FLAG_IS_DISCOVERY_H418)
        end
      elseif gMapNum == 404 then
        if not FlagCheck(FLAG_IS_DISCOVERY_H510) then
          FlagSet(FLAG_IS_DISCOVERY_H510)
        end
      elseif gMapNum == 403 and not FlagCheck(FLAG_IS_DISCOVERY_H811) then
        FlagSet(FLAG_IS_DISCOVERY_H811)
      end
      if not FlagCheck(FLAG_IS_HAZAMA_FIRST_GATE) then
        print("#### FIRST_GATE ####")
        FlagSet(FLAG_IS_HAZAMA_FIRST_GATE)
        HazamaGateFoundFlagSet(args.hazama_gate_found_flag_id)
        CallEventScriptFunction("FirstDiscovery_HazamaGate", object_index)
        first_discovery = false
      else
        print("#### NOT FIRST GATE ####")
        CallEventScriptFunction("AddHazamaMenu", object_index)
      end
      return first_discovery
    end
  end
end
