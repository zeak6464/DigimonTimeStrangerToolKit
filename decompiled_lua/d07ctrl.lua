require("function_control")
DEFINE_FLAG("FLAG_IS_HAZAMA_FIRST_GATE")
DEFINE_FLAG("FLAG_IS_DISCOVERY_H512")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""
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
  print("====== map_prefix = ", gMapPrefix, " ====== gMapNum = ", gMapNum, " ======")
  if gMapNum == 701 then
    LoadLocatorModel(gPlanData)
    LoadRailMove(gRailMoveFile)
  elseif gMapNum == 702 then
    LoadLocatorModel(gPlanData)
    Player().LoadMoveMotion("")
    local theater_door = GetIndex(GIM, "theater_0001")
    LocatorObject(theater_door).LoadMotion("e001")
    LocatorObject(theater_door).LoadMotion("e002")
    LocatorObject(theater_door).LoadMotion("e003")
    LocatorObject(theater_door).LoadMotion("e004")
    LocatorObject(theater_door).LoadMotion("e005")
  elseif gMapNum == 703 then
    LoadLocatorModel(gPlanData)
    Player().LoadMoveMotion("")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== gMapNum = ", gMapNum, " ======")
  if gMapNum == 701 then
    SetExternalVariable("speed", "Initialize")
  elseif gMapNum == 704 then
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 701 then
  elseif gMapNum == 704 then
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
  if gMapNum == 701 then
    local mapchange_event = GetExternalVariable("mapchange_event")
    if mapchange_event == "start" then
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    end
    local fly_state = GetExternalVariable("fly_state")
    local accel_state = GetExternalVariable("accel_state")
    if RIDE_SPEED == nil then
      RIDE_SPEED = 10
    elseif RIDE_SPEED < 30 then
      RIDE_SPEED = RIDE_SPEED + 2
    else
      RIDE_SPEED = 30
    end
    if 0 < GetPadAxis(PAD_AXIS_LEFT_X) then
      Add_Rotate = GetPadAxis(PAD_AXIS_LEFT_X) / 1.5
      Add_Rotate2 = GetPadAxis(PAD_AXIS_LEFT_X) / 4
    elseif 0 > GetPadAxis(PAD_AXIS_LEFT_X) then
      Add_Rotate = GetPadAxis(PAD_AXIS_LEFT_X) / 1.5
      Add_Rotate2 = GetPadAxis(PAD_AXIS_LEFT_X) / 4
    elseif GetPadAxis(PAD_AXIS_LEFT_X) == 0 then
      Add_Rotate = 0
      Add_Rotate2 = 0
    end
    local x, y, z = Player().GetPosition()
    local rotateY = Player().GetRotationY()
    if fly_state == "start" then
      if IsPadTrigger(PAD_INPUT_L2) then
        print("####L2!####")
        SetExternalVariable("accel_state", "start")
      elseif IsPadTrigger(PAD_INPUT_L1) then
        print("####cross!####")
        SetExternalVariable("accel_state", "start02")
      end
      PLAYER_SPEED = Player().GetLastMoveSpeed()
      if 8 >= PLAYER_SPEED then
        PLAYER_SPEED = 8
      end
      print(Player().GetLastMoveSpeed())
      if PLAYER_SPEED > 15 then
        Player().ShowAttachment(7)
      else
        Player().HideAttachment(7)
      end
      if GetPadAxis(PAD_AXIS_LEFT_Y) ~= 0 or GetPadAxis(PAD_AXIS_LEFT_X) ~= 0 then
        if RIDE_SPEED2 == nil then
          RIDE_SPEED2 = 10
        elseif RIDE_SPEED2 < 17 then
          RIDE_SPEED2 = RIDE_SPEED2 + 0.2
        else
          RIDE_SPEED2 = 17
        end
        if PLAYER_SPEED > 14 then
          SetExternalVariable("speed", tostring(string.sub(PLAYER_SPEED, 1, 2)))
        else
          SetExternalVariable("speed", "Initialize")
        end
        SPEED_DOWN = 0
        if not FlagCheck(9999) then
          CallEventScriptFunction("test_accel", PLAYER_SPEED)
        else
          Player().Move_Move2D(rotateY + Add_Rotate, RIDE_SPEED2)
          SetFollowerCameraOperateRotationY(rotateY)
        end
      else
        if GetExternalVariable("speed") ~= "Initialize" then
          local speed_state = GetExternalVariable("speed")
          local speed = tonumber(speed_state) - SPEED_DOWN
          if 0 < speed then
            SPEED_DOWN = SPEED_DOWN + (speed / 25 + 0.3)
          else
            SetExternalVariable("speed", "Initialize")
          end
          Player().Move_Move2D(rotateY, speed)
          RIDE_SPEED2 = 10
        end
        if FlagCheck(9999) then
          SetFollowerCameraOperateRotationY(rotateY)
        end
      end
      if accel_state == "start" and accel_state ~= "start02" then
        ACCEL_FRAME = ACCEL_FRAME + elapsed_frame
        if 0 < ACCEL_FRAME and ACCEL_FRAME < 5 then
          SetFollowerCameraOperateRotationY(rotateY)
          PlayEffectScript("ef_b_com_080_wind", x, y + 2, z, rotateY, 2)
          Player().Move_Move2D(rotateY + Add_Rotate2, 35)
        elseif ACCEL_FRAME > 5 and ACCEL_FRAME < 40 then
          SetFollowerCameraOperateRotationY(rotateY)
          CameraSwitchChangeByFile("cam02_railcam", "followcam_default_loc", false)
          Player().Move_Move2D(rotateY + Add_Rotate2, 35)
        elseif ACCEL_FRAME >= 40 then
          CameraSwitchChangeByFile("cam01_railcam", "followcam_default_loc", false)
          PLAYER_SPEED = Player().GetLastMoveSpeed()
          SetExternalVariable("accel_state", "end")
        end
      elseif accel_state == "start02" and accel_state ~= "start" then
        ACCEL_FRAME = ACCEL_FRAME + elapsed_frame
        if 0 < ACCEL_FRAME and ACCEL_FRAME < 5 then
          SetFollowerCameraOperateRotationY(rotateY)
          PlayEffectScript("ef_b_com_080_wind", x, y + 2, z, rotateY, 2)
          Player().Move_Move2D(rotateY + Add_Rotate, 35)
        elseif ACCEL_FRAME > 5 and ACCEL_FRAME < 20 then
          SetFollowerCameraOperateRotationY(rotateY)
          Player().Move_Move2D(rotateY + Add_Rotate, 35)
        elseif ACCEL_FRAME >= 20 then
          PLAYER_SPEED = Player().GetLastMoveSpeed()
          SetExternalVariable("accel_state", "end")
        end
      elseif accel_state == "end" then
        ACCEL_FRAME = ACCEL_FRAME + elapsed_frame
        if ACCEL_FRAME >= 100 then
          PlayEffectScript("ef_b_buf_100", x, y, z, rotateY, 0.8)
          ACCEL_FRAME = 0
          SetExternalVariable("accel_state", "Initialize")
        end
      end
    end
  elseif gMapNum == 702 then
  elseif gMapNum == 703 then
    local mapchange_event = GetExternalVariable("mapchange_event")
    if mapchange_event == "start" then
      Player().Physics_SetCollisionContactForNotHit()
      Player().Physics_SetGravity(0)
    end
  end
end

function OnTouchCollision(col_name)
  if gMapNum == 701 and col_name == "evt_9006" then
    SetExternalVariable("mapchange_event", "start")
  end
end

function CheckHazamaGateFound(object_type, object_index, args)
  print("=============== CheckHazamaGateFound object_type = ", object_type, "=====================")
  if object_type == OGIM then
    print("=============== CheckHazamaGateFound GIMMICK_OBJECT_TYPE =====================")
    local name = Gimmick(object_index).GetUniqueName()
    if string.find(name, "hazama_gate") ~= nil then
      local first_discovery = true
      if gMapNum == 703 and not FlagCheck(FLAG_IS_DISCOVERY_H512) then
        FlagSet(FLAG_IS_DISCOVERY_H512)
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
