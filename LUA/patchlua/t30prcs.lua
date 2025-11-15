gGimText = "field_text"

function Prcs_t3001_TheaterEntrance()
  if not Flg.Check("FLAG_MAIN_03_032") then
    Field_Talk_Start_Not_LetterBox("t30", 1)
    Message("f_t3001_0060_0010")
    Field_Talk_End_Not_LetterBox()
    Prcs_t30_InvisibleFollower()
  elseif Flg.Check("FLAG_MAIN_09_075", "FLAG_MAIN_09_080") or Flg.Check("FLAG_MAIN_10_053", "FLAG_MAIN_10_055") then
    local prefix, number, locator, time_zone = Common.GetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType())
    Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    print("mapchange prefix = ", prefix, " map_num = ", number, " loc = ", locator)
    PlaySE(200006, 100)
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
    FadeOutWithWait(1, 30)
    WaitFrame(30)
    Flg.Clear("FLAG_IS_MIREI_ADULT")
    if TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE == nil then
      MapChange(prefix, number, locator, false, FADE_WHITE, FADE_TIME)
    elseif TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE ~= nil then
      MapChangeWithTimePasses(prefix, number, locator, TIME_ZONE)
    else
      MapChangeWithTimeTravel(prefix, number, locator, TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
    end
  else
    Field_Talk_Start_Not_LetterBox(gGimText, 1)
    if Flg.Check("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER") then
      if Flg.Check("FLAG_OPEN_TIMEJUMP") then
        MessageClose()
        MessageTalkSel(3, "g_t3001_0040_0020")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK01 then
          local prefix, number, locator, time_zone = Common.GetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType())
          Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
          Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
          Field_Talk_End_Not_LetterBox()
          Prcs_t30_InvisibleFollower()
          print("prefix = ", prefix, " map_num = ", number, " loc = ", locator)
          PlaySE(200006, 100)
          Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
          FadeOutWithWait(1, 30)
          WaitFrame(90)
          if Common.CheckTimeAxis("A2020_dbef_119") then
            Digitter.Send(6020010)
          elseif Common.CheckTimeAxis("A2020_dbef_199") then
            Digitter.Send(6030010)
          elseif Common.CheckTimeAxis("A2028_daft_419") then
            if prefix == "t" then
              Digitter.Send(6040010)
            else
              Digitter.Send(6050010)
            end
          else
            Digitter.Send(6010010)
          end
          if prefix == "d" and 201 <= number and number <= 217 and Flg.Check("FLAG_MAIN_07_040") and not Common.CheckTimeAxis("P2028_daft_350") then
            MapChangeWithTimePasses(prefix, number, locator, EVENING)
          end
          Flg.Clear("FLAG_IS_MIREI_ADULT")
          if TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE == nil then
            MapChange(prefix, number, locator, false, FADE_WHITE, FADE_TIME)
          elseif TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE ~= nil then
            MapChangeWithTimePasses(prefix, number, locator, TIME_ZONE)
          else
            MapChangeWithTimeTravel(prefix, number, locator, TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
          end
        elseif result == RESULT_TALK00 then
          TimeTravel.Create()
          TimeTravel.Open()
          while not TimeTravel.IsClosed() do
            WaitFrame(1)
          end
          if TimeTravel.IsCanceled() then
            Field_Talk_End_Not_LetterBox()
            TimeTravel.End()
            Prcs_t30_InvisibleFollower()
          elseif TimeTravel.IsBackOriginal() then
            Field_Talk_End_Not_LetterBox()
            Prcs_t30_InvisibleFollower()
            Map:OpenPlace(10601, false)
            Map:CloseArea(3, true)
            Map:ClosePlace(10402, true)
            Map:CloseArea(106, true)
            Map:ClosePlace(103, false)
            PlaySE(200006, 100)
            Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
            FadeOutWithWait(1, 30)
            WaitFrame(90)
            Digitter.Send(6010010)
            Flg.Clear("FLAG_IS_USED_TIMEJUMP_TO_BEFORE")
            local prefix, number, locator, time_zone = Common.GetHazamaTheaterExitData(TIME_TRAVEL_RECORD_ORIGINAL)
            Common.RequestMapChangeWithTimeTravelFromRecord(prefix, number, locator, TIME_TRAVEL_RECORD_ORIGINAL)
          else
            Field_Talk_End_Not_LetterBox()
            Prcs_t30_InvisibleFollower()
            local prifix = TimeTravel.GetPrefix()
            local number = TimeTravel.GetMapNumber()
            local locator = TimeTravel.GetLocator()
            local time_axis = TimeTravel.GetTimeAxis()
            local time_zone = TimeTravel.GetTimeZone()
            Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
            Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
            if time_axis == "A2020_dbef_119" then
              Map:ClosePlace(103, true)
              Map:CloseArea(3, false)
              Flg.Clear("FLAG_IS_USED_TIMEJUMP_TO_AFTER")
              Flg.Set("FLAG_IS_USED_TIMEJUMP_TO_BEFORE")
            elseif time_axis == "A2020_dbef_199" then
              Map:OpenArea(102, true)
              Map:OpenPlace(10201, true)
              Map:OpenPlace(10206, true)
              Map:OpenArea(103, true)
              Map:OpenPlace(10301, true)
              Map:OpenArea(104, true)
              Map:CloseArea(104, false)
              Map:ClosePlace(10401, false)
              Map:OpenPlace(10401, true)
              Map:OpenArea(105, true)
              Map:OpenPlace(10501, true)
              Map:ClosePlace(10501, false)
              Map:OpenArea(106, true)
              Map:CloseArea(106, false)
              Map:OpenPlace(10606, true)
              Map:ClosePlace(10606, false)
              Map:OpenPlace(10601, false)
              Flg.Clear("FLAG_IS_USED_TIMEJUMP_TO_AFTER")
              Flg.Set("FLAG_IS_USED_TIMEJUMP_TO_BEFORE")
            elseif time_axis == "A2028_daft_419" then
              Map:CloseArea(3, true)
              Map:ClosePlace(103, false)
              Map:OpenArea(101, true)
              Map:ClosePlace(10101, false)
              Map:OpenPlace(10101, true)
              Map:OpenArea(102, true)
              Map:ClosePlace(10211, false)
              Map:ClosePlace(10212, false)
              Map:OpenPlace(10211, true)
              Map:OpenPlace(10212, true)
              Map:OpenArea(103, true)
              Map:ClosePlace(10312, false)
              Map:OpenPlace(10312, true)
              Map:OpenArea(104, true)
              Map:ClosePlace(10412, false)
              Map:OpenPlace(10412, true)
              Map:OpenArea(105, true)
              Map:ClosePlace(10521, false)
              Map:OpenPlace(10521, true)
              Map:OpenArea(106, true)
              Map:CloseArea(106, false)
              Map:OpenPlace(10601, false)
              Map:OpenPlace(10607, true)
              Map:ClosePlace(10607, false)
              Map:OpenArea(107, true)
              Map:ClosePlace(10701, false)
              Map:OpenPlace(10701, true)
              Flg.Set("FLAG_IS_USED_TIMEJUMP_TO_AFTER")
              Flg.Clear("FLAG_IS_USED_TIMEJUMP_TO_BEFORE")
            end
            Field_Talk_End_Not_LetterBox()
            Prcs_t30_InvisibleFollower()
            if time_axis == "A2020_dbef_119" then
              Digitter.Send(6020010)
            elseif time_axis == "A2020_dbef_199" then
              Digitter.Send(6030010)
            elseif time_axis == "A2028_daft_419" then
              if prifix == "t" then
                Digitter.Send(6040010)
              elseif prifix == "d" and number == 1204 then
                Digitter.Send(6060010)
              else
                Digitter.Send(6050010)
              end
            elseif time_axis == "P2028_daft_440" then
              Digitter.Send(6010010)
            end
            Flg.Clear("FLAG_IS_MIREI_ADULT")
            Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
            PlaySE(200006, 100)
            Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
            FadeOutWithWait(1, 30)
            WaitFrame(90)
            Common.RequestMapChangeWithTimeTravel(prifix, number, locator, time_axis, time_zone)
          end
          TimeTravel.End()
        elseif result == RESULT_TALK02 then
          Field_Talk_End_Not_LetterBox()
          Prcs_t30_InvisibleFollower()
        end
      else
        MessageClose()
        MessageTalkSel(2, "g_t3001_0020_0010")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          local prefix, number, locator, time_zone = Common.GetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType())
          Flg.Clear("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
          Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
          Field_Talk_End_Not_LetterBox()
          Prcs_t30_InvisibleFollower()
          print("prefix = ", prefix, " map_num = ", number, " loc = ", locator)
          PlaySE(200006, 100)
          Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
          FadeOutWithWait(1, 30)
          WaitFrame(30)
          if prefix == "d" and 201 <= number and number <= 217 and Flg.Check("FLAG_MAIN_07_040") and not Common.CheckTimeAxis("P2028_daft_350") then
            if Flg.Check("FLAG_MAIN_15_010", "FLAG_MAIN_15_040") then
              MapChangeWithTimeTravel("d", 202, "start_50", AXIS_ORIGINAL, "A2028_daft_361", EVENING)
            else
              MapChangeWithTimePasses(prefix, number, locator, EVENING)
            end
          end
          if Flg.Check("FLAG_MAIN_03_032", "FLAG_MAIN_03_035") then
            MapChangeWithTimeTravel("t", 109, "start_50", TIME_TRAVEL_RECORD_ORIGINAL, "A2020_dbef_51", EVENING)
          end
          Flg.Clear("FLAG_IS_MIREI_ADULT")
          if TIME_AXIS == nil and TIME_AXIS_SET == "" and time_zone == nil then
            MapChange(prefix, number, locator, false, FADE_WHITE, FADE_TIME)
          elseif TIME_AXIS == nil and TIME_AXIS_SET == "" and time_zone ~= nil then
            MapChangeWithTimePasses(prefix, number, locator, time_zone)
          else
            MapChangeWithTimeTravel(prefix, number, locator, TIME_AXIS, TIME_AXIS_SET, time_zone)
          end
        elseif result == RESULT_TALK01 then
          Field_Talk_End_Not_LetterBox()
          Prcs_t30_InvisibleFollower()
        end
      end
    else
      Message("g_t3001_0030_0010")
      Field_Talk_End_Not_LetterBox()
      Prcs_t30_InvisibleFollower()
    end
  end
end

function Prcs_t3001_MireiShop(npc_name, npc_text)
  SetControlScriptExternalVariable("player_state", "shopping")
  SetControlScriptExternalVariable("shop_name", npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  Field.ObjectLoadExpression(NPC, npc01_index, "F01")
  Field.ObjectLoadMotion(NPC, npc01_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, npc01_index, "e551")
  Field.ObjectLoadMotion(NPC, npc01_index, "e550")
  Field.ObjectLoadMotion(NPC, npc01_index, "e002")
  Field.ObjectLoadMotion(NPC, npc01_index, "e003")
  Field.ObjectLoadMotionBlend(NPC, npc01_index, "blend05")
  HideMinimap(true)
  HideGuide(true)
  Cam.Inst:Set(-11.885, 1.37, 0, -9.39, 1.37, -0.15, default, 30)
  Obj:new(PLAYER, ""):Invisible(30)
  WaitFrame(30)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  if Flg.Check("FLAG_IS_MIREI_ADULT", "FLAG_IS_MIREI_ADULT_FIRSTTALK") then
    Flg.Set("FLAG_IS_MIREI_ADULT_FIRSTTALK")
    WaitFrame(15)
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e003", 10, 10)
    Message("f_t3001_0200_0010")
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e002", 10, 10)
    Message("f_t3001_0200_0020")
    Field.ObjectPlayMotionBlend(NPC, npc01_index, "blend05", 10, true)
    Message("f_t3001_0200_0030")
    Field.ObjectEndMotionBlend(NPC, npc01_index, 10)
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e003", 10, 10)
    Message("f_t3001_0200_0040")
    Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
    MessageClose()
    WaitFrame(15)
  end
  Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e002", 10, 10)
  Message("f_t3001_0010_0010")
  Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
  MessageClose()
  if Flg.Check("FLAG_IS_HAZAMA_FIRST_GATE") or DLC.FlagCheck(10) then
    MessageTalkSel(3, "f_t3001_0020_0020")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Field_Talk_End_Not_LetterBox()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e550", 10, 10)
      require("t3001_01")
      t3001_01("obj_0001")
      ShopClose()
      SetControlScriptExternalVariable("player_state", "Initialize")
      SetControlScriptExternalVariable("shop_name", nil)
      SetControlScriptExternalVariable("shop_dist_adjust", nil)
      Cam.Inst:Clear(0)
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
      Field.FarmSceneChange()
      Obj:new(PLAYER, ""):CancelInvisible(5)
    elseif result == RESULT_TALK01 then
      Field_Talk_End_Not_LetterBox()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e550", 10, 10)
      WaitFrame(45)
      local prefix, map_num, locator
      prefix, map_num, locator = OpenHazmaMenu()
      SetControlScriptExternalVariable("player_state", "Initialize")
      SetControlScriptExternalVariable("shop_name", nil)
      SetControlScriptExternalVariable("shop_dist_adjust", nil)
      if prefix == nil then
        Cam.Inst:Set(-11.885, 1.37, 0, -9.39, 1.37, -0.15, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e551", 10, 10)
        Message("f_t3001_0030_0010")
        Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
        Obj:new(PLAYER, ""):CancelInvisible(5)
      else
        Obj:new(PLAYER, ""):CancelInvisible(5)
        MapChange(prefix, map_num, locator, true, FADE_WHITE, FADE_TIME)
      end
    elseif result == RESULT_TALK02 then
      ShopClose()
      SetControlScriptExternalVariable("player_state", "Initialize")
      SetControlScriptExternalVariable("shop_name", nil)
      SetControlScriptExternalVariable("shop_dist_adjust", nil)
      Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e551", 10, 10)
      Message("f_t3001_0030_0010")
      Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      Obj:new(PLAYER, ""):CancelInvisible(5)
    end
  else
    MessageTalkSel(2, "f_t3001_0020_0010")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      Field_Talk_End_Not_LetterBox()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e550", 10, 10)
      require("t3001_01")
      t3001_01("obj_0001")
      ShopClose()
      SetControlScriptExternalVariable("player_state", "Initialize")
      SetControlScriptExternalVariable("shop_name", nil)
      SetControlScriptExternalVariable("shop_dist_adjust", nil)
      Cam.Inst:Clear(0)
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
      Field.FarmSceneChange()
      Obj:new(PLAYER, ""):CancelInvisible(5)
    elseif result == RESULT_TALK01 then
      ShopClose()
      SetControlScriptExternalVariable("player_state", "Initialize")
      SetControlScriptExternalVariable("shop_name", nil)
      SetControlScriptExternalVariable("shop_dist_adjust", nil)
      Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc01_index, "e551", 10, 10)
      Message("f_t3001_0030_0010")
      Field.ObjectChangeExpression(NPC, npc01_index, "F01", EYES_BLINK_TYPE_BLINK, false, 10, AUTO_CANCEL_NONE, 15)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      Obj:new(PLAYER, ""):CancelInvisible(5)
    end
  end
  HideMinimap(false)
  HideGuide(false)
end

function Prcs_t3001_MireiShop_S154(npc_name, npc_text)
  SetControlScriptExternalVariable("player_state", "shopping")
  SetControlScriptExternalVariable("shop_name", npc_name)
  HideMinimap(true)
  HideGuide(true)
  Cam.Inst:Set(-11.885, 1.37, 0, -9.39, 1.37, -0.15, default, 30)
  WaitFrame(30)
  Field_Talk_Start_Not_LetterBox(npc_text, 1)
  Message("f_t3001_0010_0010")
  MessageClose()
  MessageTalkSel(4, "f_t3001_0070_0010")
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
  elseif result == RESULT_TALK01 then
    Field_Talk_End_Not_LetterBox()
    require("t3001_01")
    t3001_01("obj_0001")
    ShopClose()
    SetControlScriptExternalVariable("player_state", "Initialize")
    SetControlScriptExternalVariable("shop_name", nil)
    SetControlScriptExternalVariable("shop_dist_adjust", nil)
    Cam.Inst:Clear(0)
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_FROM_THEATER")
    Field.FarmSceneChange()
  elseif result == RESULT_TALK02 then
    Field_Talk_End_Not_LetterBox()
    Prcs_t30_InvisibleFollower()
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
    FadeOutWithWait(0, 30)
    Field_Talk_Start_Not_LetterBox(npc_text, 1)
    Digimon.RestoreAllParty()
    PlaySE(200007, 100)
    INFO_WINDOW(5051)
    WaitFrame(60)
    FadeInWithWait(0, 30)
    ShopClose()
    SetControlScriptExternalVariable("player_state", "Initialize")
    SetControlScriptExternalVariable("shop_name", nil)
    SetControlScriptExternalVariable("shop_dist_adjust", nil)
    Cam.Inst:Clear(30)
    Field_Talk_End_Not_LetterBox()
    Prcs_t30_InvisibleFollower()
  elseif result == RESULT_TALK03 then
    ShopClose()
    SetControlScriptExternalVariable("player_state", "Initialize")
    SetControlScriptExternalVariable("shop_name", nil)
    SetControlScriptExternalVariable("shop_dist_adjust", nil)
    Cam.Inst:Clear(30)
    Field_Talk_End_Not_LetterBox()
    Prcs_t30_InvisibleFollower()
  end
  ShopClose()
  SetControlScriptExternalVariable("player_state", "Initialize")
  SetControlScriptExternalVariable("shop_name", nil)
  SetControlScriptExternalVariable("shop_dist_adjust", nil)
  Cam.Inst:Clear(30)
  HideMinimap(false)
  HideGuide(false)
end

function Prcs_t3001_UnmannedAndObjectAccessOff(is_theater, is_vip, is_entrance1, is_mirei)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "change_0001"), is_theater)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "change_0002"), is_vip)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "change_0003"), is_entrance1)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "DLC_elv"), false)
  if is_mirei == nil or is_mirei == false then
    Obj:new(NPC, "farm_0001"):Invisible()
  end
  Obj:new(NPC, "shop_0002"):Invisible()
  Obj:new(NPC, "shop0003"):Invisible()
  Obj:new(NPC, "s090_072_001"):Invisible()
  Obj:new(NPC, "farm_0002"):Invisible()
  local mob_num = Field.GetObjectExistsNum(MOB)
  for index_num = 1, mob_num do
    local mob_name = Field.ObjectGetUniqueName(MOB, index_num)
    Obj:new(MOB, mob_name):Invisible()
  end
end

function Prcs_t3001_GetOnElv_Fade(gim_loc, icon_loc, prifix, map_num, start_loc)
  local e001 = Motion.Object:new(OGIM, gim_loc, "e001")
  local e002 = Motion.Object:new(OGIM, gim_loc, "e002")
  PlayerTurnToObject(OGIM, icon_loc, true, false, 0, 0)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  PlaySE(200025, 100)
  e001:Play(10, false)
  PlaySE(200013, 100)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  Obj:new(PLAYER, ""):SetPos(-13.62, 0, -8.38, true)
  Obj:new(PLAYER, ""):SetRotationY(90, 0)
  Cam.Inst:Set(-16.14, -0.08, -10.72, -7.55, 2.73, -6.43, default, 0)
  PlayerObjectResetAim()
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  e002:Play(10, false)
  PlaySE(200011, 100)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, 30)
  MapChange(prifix, map_num, start_loc, false, 0, 0)
end

function Prcs_t3004_GetOnElv_Fade_01(gim_loc, icon_loc, prifix, map_num, start_loc)
  local e001 = Motion.Object:new(OGIM, gim_loc, "e001")
  local e002 = Motion.Object:new(OGIM, gim_loc, "e002")
  PlayerTurnToObject(OGIM, icon_loc, true, false, 0, 0)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  PlaySE(200025, 100)
  e001:Play(10, false)
  PlaySE(200013, 100)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  Obj:new(PLAYER, ""):SetPos(-0.03, 0, 12.6, true)
  Obj:new(PLAYER, ""):SetRotationY(0, 0)
  Cam.Inst:Set(-0.12, 1.046, 12.29, 1.91, 3.99, 6.56, default, 0)
  PlayerObjectResetAim()
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  e002:Play(10, false)
  PlaySE(200011, 100)
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_BLACK, 30)
  MapChange(prifix, map_num, start_loc, false, 0, 0)
end

function Prcs_t3004_GetOutElv_Fade()
  Obj:new(PLAYER, ""):SetPos(-0.03, 0, 12.6, true)
  Obj:new(PLAYER, ""):SetRotationY(0, 0)
  Cam.Inst:Set(-0.12, 1.046, 12.29, 1.91, 3.99, 6.56, default, 0)
  Sound.StopSE(slot_num, 0)
  PlaySE(200013, 100)
  ColOff("plan_cl_1000")
  ColOff("wall_cl_1000")
  Cam.Inst:Clear(0)
  WaitFrame(30)
  Fade.In(0, Util.SecondFromFrame(30))
  Motion.Gimmick:Play("elv_001", "e002", false)
  PlaySE(200011, 100)
  ColOn("plan_cl_1000")
  ColOn("wall_cl_1000")
  Field.SetFollowerCameraOperateRotationY(135)
  Prcs_t30_InvisibleFollower()
end

function Prcs_t30_InvisibleFollower()
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
end

function Prcs_t3001_12GodsReliefPlayMotion(gim_no)
  local gim_name, gim_name2, gim_name3
  if gim_no == 0 then
    Flg.Set("FLAG_GIMMICK_T0301_001")
    gim_name = "obj_movewall00"
    gim_name2 = nil
    gim_name3 = nil
  elseif gim_no == 1 then
    Flg.Set("FLAG_GIMMICK_T0301_002")
    gim_name = "obj_jewel01"
    gim_name2 = "obj_reliefparts01"
    gim_name3 = "obj_digi01"
  elseif gim_no == 2 then
    Flg.Set("FLAG_GIMMICK_T0301_003")
    gim_name = "obj_jewel02"
    gim_name2 = "obj_reliefparts02"
    gim_name3 = "obj_digi02"
  elseif gim_no == 3 then
    Flg.Set("FLAG_GIMMICK_T0301_004")
    gim_name = "obj_jewel03"
    gim_name2 = "obj_reliefparts03"
    gim_name3 = "obj_digi03"
  elseif gim_no == 4 then
    Flg.Set("FLAG_GIMMICK_T0301_005")
    gim_name = "obj_jewel04"
    gim_name2 = "obj_reliefparts04"
    gim_name3 = "obj_digi04"
  elseif gim_no == 5 then
    Flg.Set("FLAG_GIMMICK_T0301_006")
    gim_name = "obj_jewel05"
    gim_name2 = "obj_reliefparts05"
    gim_name3 = "obj_digi05"
  elseif gim_no == 6 then
    Flg.Set("FLAG_GIMMICK_T0301_007")
    gim_name = "obj_jewel06"
    gim_name2 = "obj_reliefparts06"
    gim_name3 = "obj_digi06"
  elseif gim_no == 7 then
    Flg.Set("FLAG_GIMMICK_T0301_008")
    gim_name = "obj_jewel07"
    gim_name2 = "obj_reliefparts07"
    gim_name3 = "obj_digi07"
  elseif gim_no == 8 then
    Flg.Set("FLAG_GIMMICK_T0301_009")
    gim_name = "obj_jewel08"
    gim_name2 = "obj_reliefparts08"
    gim_name3 = "obj_digi08"
  elseif gim_no == 9 then
    Flg.Set("FLAG_GIMMICK_T0301_010")
    gim_name = "obj_jewel09"
    gim_name2 = "obj_reliefparts09"
    gim_name3 = "obj_digi09"
  elseif gim_no == 10 then
    Flg.Set("FLAG_GIMMICK_T0301_011")
    gim_name = "obj_jewel10"
    gim_name2 = "obj_reliefparts10"
    gim_name3 = "obj_digi10"
  elseif gim_no == 11 then
    Flg.Set("FLAG_GIMMICK_T0301_012")
    gim_name = "obj_jewel11"
    gim_name2 = "obj_reliefparts11"
    gim_name3 = "obj_digi11"
  elseif gim_no == 12 then
    Flg.Set("FLAG_GIMMICK_T0301_013")
    gim_name = "obj_jewel12"
    gim_name2 = "obj_reliefparts12"
    gim_name3 = "obj_digi12"
  end
  Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
  WaitFrame(10)
  Cam.Inst:Set(0.02, 9.96, -25.03, 0.02, 9.89, -11.78, default, 0)
  WaitFrame(15)
  FadeAllInWithWait(FADE_WHITE, FADE_TIME)
  WaitFrame(15)
  if gim_name == "obj_movewall00" then
    local wait_f = Field.ObjectGetMotionEndFrame(OGIM, GetIndex(OGIM, gim_name), "e001")
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name), "e001", 5, false)
    WaitFrame(wait_f)
  else
    local wait_f = Field.ObjectGetMotionEndFrame(OGIM, GetIndex(OGIM, gim_name), "e001")
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name), "e001", 5, false)
    WaitFrame(wait_f)
    WaitFrame(10)
    local wait_f = Field.ObjectGetMotionEndFrame(OGIM, GetIndex(OGIM, gim_name2), "e001")
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name2), "e001", 5, false)
    WaitFrame(wait_f)
    WaitFrame(10)
    local wait_f = Field.ObjectGetMotionEndFrame(OGIM, GetIndex(OGIM, gim_name3), "e001")
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name3), "e001", 5, false)
    WaitFrame(wait_f)
  end
  WaitFrame(30)
  Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
  WaitFrame(10)
  Cam.Inst:Clear(0)
  if gim_name == "obj_movewall00" then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name), "e002", 5, false)
  else
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name2), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name3), "e002", 5, false)
  end
  WaitFrame(15)
  FadeAllInWithWait(FADE_WHITE, FADE_TIME)
end

function Prcs_t3001_12GodsReliefSeting()
  if Flg.Check("FLAG_GIMMICK_T0301_001") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_movewall00"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_002") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel01"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts01"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi01"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_003") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel02"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts02"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi02"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_004") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel03"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts03"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi03"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_005") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel04"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts04"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi04"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_006") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel05"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts05"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi05"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_007") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel06"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts06"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi06"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_008") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel07"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts07"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi07"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_009") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel08"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts08"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi08"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_010") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel09"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts09"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi09"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_011") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel10"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts10"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi10"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_012") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts11"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_014") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi11"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel11"), "e002", 5, false)
  end
  if Flg.Check("FLAG_GIMMICK_T0301_013") then
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_jewel12"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_reliefparts12"), "e002", 5, false)
    Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, "obj_digi12"), "e002", 5, false)
  end
end

function Prcs_t3001_12GodsReliefInvisible(is_invisible)
  if is_invisible == true then
    Obj:new(OGIM, "obj_movewall00"):Invisible()
    for i = 1, 12 do
      local gim_name = "obj_jewel" .. string.format("%02d", i)
      Obj:new(OGIM, gim_name):Invisible()
      gim_name = "obj_reliefparts" .. string.format("%02d", i)
      Obj:new(OGIM, gim_name):Invisible()
      gim_name = "obj_digi" .. string.format("%02d", i)
      Obj:new(OGIM, gim_name):Invisible()
    end
  elseif is_invisible == false then
    Obj:new(OGIM, "obj_movewall00"):CancelInvisible()
    for i = 1, 12 do
      local gim_name = "obj_jewel" .. string.format("%02d", i)
      Obj:new(OGIM, gim_name):CancelInvisible()
      gim_name = "obj_reliefparts" .. string.format("%02d", i)
      Obj:new(OGIM, gim_name):CancelInvisible()
      gim_name = "obj_digi" .. string.format("%02d", i)
      Obj:new(OGIM, gim_name):CancelInvisible()
    end
  end
end
