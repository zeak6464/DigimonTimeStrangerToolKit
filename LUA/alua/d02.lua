function FieldLoadRequest()
  local load_map_prefix, load_map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  
  print("##### load_map_prefix = ", load_map_prefix, " ##### load_map_num = ", load_map_num, " #####")
  LoadGimmickData(load_map_num)
  Field.LoadPlayerScriptDigimonRideDigimon(146)
  if load_map_num == 201 then
  elseif load_map_num == 203 then
    Motion.Object:Load(NPC, "s200_148_003", "fe02")
    Motion.Object:Load(NPC, "s200_148_004", "fe02")
  elseif load_map_num == 206 then
    Motion.Object:Load(FLD_OBJ_NPC, "npc_0005", "bn01")
  end
end

function StandbyField()
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  MapNameDisp()
  InitializeObject()
  Dlc_InstallCheck()
  SubQuestDigitterCheck()
end

function OnEndLoad(args)
  gMapPrefix, gMapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  local start_loc = GetLastPlayerSetLocator()
  SaveSequenceAfterChapterChange()
  GetGender()
  PlayDungeonBGM()
  if Flg.Check("FLAG_MAIN_03_460", "FLAG_MAIN_03_470") and gMapNum == 216 then
    Field_PlayBGM(702)
  end
  local is_map_changed_now = args.map_changed_now
  if is_map_changed_now then
    UpdateMinimap(start_loc)
  end
  if Debug.RunningFromFieldSelect() == true then
    FadeInWithWait(0, 0)
    MovePlayerToStartPosition(start_loc)
    if gMapNum == 205 then
      if start_loc == "start_01" then
        Field.LinkColOff("col_d0206_start_00_0")
      end
      if start_loc == "start_04" then
        SetEnableCameraOperate(false)
        Obj:new(NPC, "ride_pegasmon"):Invisible()
        Field.PlayerScriptDigimonRideStartFromID(146, false, "", 5)
        WaitFrame(1)
        SetControlScriptExternalVariable("pegas_state", "start_arrival")
      else
        SetControlScriptExternalVariable("pegas_state", "Initialize")
      end
    elseif gMapNum == 206 then
      if start_loc == "start_00" then
        Field.LinkColOff("col_d0205_start_01_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
      elseif start_loc == "start_01" then
        Field.LinkColOff("col_d0207_start_00_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
      elseif start_loc == "start_02" then
        Field.LinkColOff("col_d0210_start_01_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
        Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
      end
    elseif gMapNum == 207 then
      if start_loc == "start_00" then
        Field.LinkColOff("col_d0206_start_01_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
    elseif gMapNum == 208 then
      if start_loc == "start_01" then
        Field.LinkColOff("col_d0209_start_00_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
    elseif gMapNum == 209 then
      if start_loc == "start_01" then
        SetEnableGimmickCheck("wall_along_0001", true)
        SetEnableGimmickCheck("wall_along_0002", false)
        SetEnableGimmickCheck("wall_along_0003", false)
        SetEnableGimmickCheck("wall_along_0004", true)
        Field.LinkColOff("col_d0210_start_00_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      elseif start_loc == "start_00" then
        SetEnableGimmickCheck("wall_along_0001", true)
        SetEnableGimmickCheck("wall_along_0002", false)
        SetEnableGimmickCheck("wall_along_0003", true)
        SetEnableGimmickCheck("wall_along_0004", false)
        Field.LinkColOff("col_d0208_start_01_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
    elseif gMapNum == 210 then
      if start_loc == "start_00" then
        Field.LinkColOff("col_d0209_start_01_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
      if start_loc == "start_01" then
        Field.LinkColOff("col_d0206_start_02_0")
        Field_InvisibleFollowerAllPartyMember(0, 0, false)
        Field_InvisibleFollowerAllGuest(0, 0, false)
      end
    end
  else
    if Field.IsJustAfterMapChangeNow() == true then
      ProcessIfNeedByStartLocator(start_loc)
    end
    StartEventBeforeFadeIn()
    if Flg.Check("FLAG_IS_MAPCHANGE_USING_DOOR") then
      Flg.Clear("FLAG_IS_MAPCHANGE_USING_DOOR")
      PlaySE(200002, 100)
      FadeInWithWait(0, 10)
    elseif not Flg.Check("FLAG_IS_START_EVENT_BEFORE_MAPCHANGE") then
      FadeInWithWait(0, 0)
    else
      Flg.Clear("FLAG_IS_START_EVENT_BEFORE_MAPCHANGE")
    end
    StartEventAfterFadeIn()
  end
end

function ProcessIfNeedByStartLocator(start_loc)
  print("##### ProcessIfNeedByStartLocator #####")
  print("##### start_locator = ", start_loc, " #####")
  if start_loc == "start_50" then
    InitializeTheaterDoorEvt()
  elseif start_loc == "start_51" then
    InitializeTheaterDoorEvt(51, "theater_0002")
  end
  if gMapNum == 201 then
    if start_loc == "start_00" then
      local rot = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
      SetFollowerCameraOperateRotation(0, rot + 12, 0)
      if not Flg.Check("FLAG_MAIN_03_470") then
        M120:Event_030()
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        Flg.Set("FLAG_MAIN_03_470")
      end
    end
    if start_loc == "start_01" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_LOCOMON") then
      PlayStopLocomonSound()
    end
    if start_loc == "start_02" then
      Move:PlayerIsDoorOut()
      M440:Event_836()
    end
    if start_loc == "start_03" then
      Move:PlayerIsDoorOut()
    end
    if start_loc == "start_04" then
      Move:PlayerIsDoorOut()
      SetFollowerCameraOperateRotation(10, 30)
    end
    if start_loc == "start_06" then
      Move:PlayerIsDoorOut()
    end
    if start_loc == "start_20" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") then
      PlayStopBlimpSound()
      AddChallengerNotice(false)
    end
  elseif gMapNum == 202 then
    if start_loc == "start_00" then
    elseif start_loc == "start_07" then
      local y_degree = Field.GetLocatorRotationYDegree(start_loc)
      y_degree = y_degree + 180
      SetFollowerCameraOperateRotation(0, y_degree)
    elseif start_loc == "start_08" then
      Field.MinimapDisplayHeight(5, 15)
    end
    if start_loc == "start_01" then
      Move:PlayerIsDoorOut()
    end
    if start_loc == "start_07" and Flg.Check("FLAG_MAIN_13_149", "FLAG_MAIN_13_150") then
      Obj:new(PLAYER, ""):SetRotationY(280, 0)
      SetFollowerCameraOperateRotation(0, 260)
      WaitFrame(10)
    end
    if start_loc == "start_50" then
      Digitter.Send(1130030010)
    end
    if start_loc == "start_90" then
      Move:PlayerIsDoorOut()
    end
    if start_loc == "start_93" then
      SetEnableCameraOperate(false)
      Obj:new(NPC, "ride_pegasmon"):Invisible()
      Field.PlayerScriptDigimonRideStartFromID(146, false, "", 5)
      WaitFrame(1)
      SetControlScriptExternalVariable("pegas_state", "start_arrival")
    else
      SetControlScriptExternalVariable("pegas_state", "Initialize")
    end
    if start_loc == "start_04" or start_loc == "start_06" then
      Flg.Set("FLAG_GIMMICK_D02_460")
    else
      Flg.Clear("FLAG_GIMMICK_D02_460")
    end
    if start_loc == "start_30" then
      require("S050_043")
      S050_043:Event_060()
    end
  elseif gMapNum == 204 then
    if start_loc == "start_00" and not Flg.Check("FLAG_MAIN_03_510") then
      Execute("m120_070")
      Flg.Set("FLAG_MAIN_03_510")
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
      Flg.Clear("FLAG_IS_MAPCHANGE_USING_DOOR")
    end
  elseif gMapNum == 205 then
    if start_loc == "start_00" then
    end
    if start_loc == "start_01" then
      Field.LinkColOff("col_d0206_start_00_0")
    end
    if start_loc == "start_03" then
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    end
    if start_loc == "start_04" then
      SetEnableCameraOperate(false)
      Obj:new(NPC, "ride_pegasmon"):Invisible()
      Field.PlayerScriptDigimonRideStartFromID(146, false, "", 5)
      WaitFrame(1)
      SetControlScriptExternalVariable("pegas_state", "start_arrival")
    else
      SetControlScriptExternalVariable("pegas_state", "Initialize")
    end
  elseif gMapNum == 206 then
    if start_loc == "start_00" then
      Field.LinkColOff("col_d0205_start_01_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    elseif start_loc == "start_01" then
      Field.LinkColOff("col_d0207_start_00_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    elseif start_loc == "start_02" then
      Field.LinkColOff("col_d0210_start_01_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
      Flg.Set("FLAG_FIELD_D02_INVISIBLEFOLLOWER")
    end
  elseif gMapNum == 207 then
    if start_loc == "start_00" then
      Field.LinkColOff("col_d0206_start_01_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
  elseif gMapNum == 208 then
    if start_loc == "start_01" then
      Field.LinkColOff("col_d0209_start_00_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
  elseif gMapNum == 209 then
    if start_loc == "start_01" then
      SetEnableGimmickCheck("wall_along_0001", true)
      SetEnableGimmickCheck("wall_along_0002", false)
      SetEnableGimmickCheck("wall_along_0003", false)
      SetEnableGimmickCheck("wall_along_0004", true)
      Field.LinkColOff("col_d0210_start_00_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    elseif start_loc == "start_00" then
      SetEnableGimmickCheck("wall_along_0001", true)
      SetEnableGimmickCheck("wall_along_0002", false)
      SetEnableGimmickCheck("wall_along_0003", true)
      SetEnableGimmickCheck("wall_along_0004", false)
      Field.LinkColOff("col_d0208_start_01_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
  elseif gMapNum == 210 then
    if start_loc == "start_00" then
      Field.LinkColOff("col_d0209_start_01_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
    if start_loc == "start_01" then
      Field.LinkColOff("col_d0206_start_02_0")
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
    if start_loc == "start_02" and Flg.Check("FLAG_ISAREA_CHANGE_FOR_BLIMP") then
      PlayStopBlimpSound()
      AddChallengerNotice(false)
    end
  end
  if gMapNum == 211 then
    Move:PlayerIsDoorOut()
  end
  if gMapNum == 212 then
    Move:PlayerIsDoorOut()
  end
  if gMapNum == 213 then
    Move:PlayerIsDoorOut()
  end
  if gMapNum == 215 and start_loc == "start_00" then
    Move:PlayerIsDoorOut()
  end
  if gMapNum == 216 and start_loc == "start_01" then
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Clear("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE")
    Move.PlayerIsDegeGateOut()
  end
  if gMapNum == 217 then
    if start_loc == "start_00" and not Flg.Check("FLAG_MAIN_03_560") then
      Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    end
    require("S050_043")
    if Qst.Sub:Check(43, 5, 10) then
      S050_043:Event_015()
    end
  end
  if Flg.Check("FLAG_SKIP_AREACHANGE_MOVE") then
    Flg.Clear("FLAG_SKIP_AREACHANGE_MOVE")
  else
    MovePlayerToStartPosition(start_loc)
  end
end

function StartEventBeforeFadeIn()
  print("##### StartEventBeforeFadeIn #####")
  if gMapNum == 201 then
    if Flg.Check("FLAG_D12_D02_IS_WARP") and (GetLastPlayerSetLocator() == "start_30" or GetLastPlayerSetLocator() == "start_90" or GetLastPlayerSetLocator() == "start_31") then
      WarpNpcArrival()
      Flg.Clear("FLAG_D12_D02_IS_WARP")
    end
    M250:Event_020()
    M250:Event_040()
    M260:Event_010()
    M285:Event_035()
    M310:Event_035()
    M350:Event_050()
    M350:Event_052()
    M350:Event_058A()
    if Flg.Check("FLAG_MAIN_22_510", "FLAG_MAIN_22_560") and Common.CheckTimeAxis("P2028_daft_440") then
      Field.HideMinimap(true)
      Field.HideGuide(true)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
    local start_loc = Field.GetLastPlayerSetLocator()
    if start_loc == "start_20" then
      require("S080_059")
      S080_059:Event_100()
    end
    if Qst.Sub:Check(91, 15, 255) then
      require("S110_091")
      S110_091:Event_040()
    end
    local zudo_index_1 = GetIndex(NPC, "zudo_01")
    local zudo_index_2 = GetIndex(NPC, "shop_0004")
    local zudo_01 = Motion.Object:new(NPC, "zudo_01", "f000")
    local shop_0004 = Motion.Object:new(NPC, "shop_0004", "f000")
    zudo_01:Play(15, true)
    shop_0004:Play(15, true)
  elseif gMapNum == 202 then
    if Flg.Check("FLAG_D12_D02_IS_WARP") and GetLastPlayerSetLocator() == "start_31" then
      WarpNpcArrival()
      Flg.Clear("FLAG_D12_D02_IS_WARP")
    end
    M120:Event_070()
    if Flg.Check("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE") and not Flg.Check("FLAG_MAIN_03_610") then
      Flg.Clear("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE")
      if Flg.Check("FLAG_MAIN_03_520") then
        Cam.Follower:ResetFromObject(NPC, "npc_0013")
        if GetControlScriptExternalVariableString("luna_state") == "initialize" then
          SetControlScriptExternalVariable("luna_state", "move_wait")
        end
        local npc_0012 = Obj:new(NPC, "npc_0012")
        local npc_0015 = Obj:new(NPC, "npc_0015")
        npc_0012:Invisible()
        npc_0015:CancelInvisible()
        M130:Event_010()
      end
      M130:Event_010()
    end
    if Flg.Check("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE") and not Flg.Check("FLAG_MAIN_03_720") then
      Flg.Clear("FLAG_IS_MAPCHANGE_BY_CHAPTERCHANGE")
      M140:Event_010()
    end
    M130:Event_010()
    M130:Event_080()
    M140:Event_010()
    M350:Event_056()
    M350:Event_070()
    M350:Event_083()
    M360:Event_068()
    local start_loc = GetLastPlayerSetLocator()
    if start_loc == "start_20" then
      require("s080_059")
      S080_059:Event_090()
    end
  end
  if gMapNum == 203 then
    if Flg.Check("FLAG_MAIN_ASSISTANT_3") then
      Flg.Clear("FLAG_MAIN_ASSISTANT_3")
    end
    M140:Event_110()
    M150:Event_010()
  end
  if gMapNum == 204 then
    if Flg.Check("FLAG_D12_D02_IS_WARP") and GetLastPlayerSetLocator() == "start_00" then
      WarpNpcArrival()
      Flg.Clear("FLAG_D12_D02_IS_WARP")
    end
    local mercurius_icon = Icon:new(NPC, "npc_0001")
    if not Flg.Check("FLAG_MAIN_03_720") then
      mercurius_icon.SetTalk()
    end
    if Flg.Check("FLAG_MAIN_03_720") then
      mercurius_icon.Clear()
    end
    M140:Event_030()
    M250:Event_030()
    M360:Event_060()
    M440:Event_845()
  end
  if gMapNum == 206 and Flg.Check("FLAG_D12_D02_IS_WARP") and GetLastPlayerSetLocator() == "start_04" then
    WarpNpcArrival()
    Flg.Clear("FLAG_D12_D02_IS_WARP")
  end
  if gMapNum == 207 and Flg.Check("FLAG_IS_CARRY_OBJECT") then
    Prcs_d02_keepCarryingHagurumon()
  end
  if gMapNum == 209 then
    if Flg.Check("FLAG_IS_CARRY_OBJECT") then
      Prcs_d02_keepCarryingHagurumon()
    end
    if not Flg.Check("FLAG_GIMMICK_D02_390") then
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
    elseif Flg.Check("FLAG_GIMMICK_D02_310") or Flg.Check("FLAG_GIMMICK_D02_330") then
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):Invisible()
    else
      local index = Field.GetRumorNpcIndex("rumor_d0209_hagurumon02")
      Obj:new(RUMOR_NPC, "rumor_d0209_hagurumon02"):CancelInvisible()
    end
  end
  if gMapNum == 210 then
    if Flg.Check("FLAG_D12_D02_IS_WARP") and GetLastPlayerSetLocator() == "start_02" then
      WarpNpcArrival()
      Flg.Clear("FLAG_D12_D02_IS_WARP")
    end
    if not Qst.Sub:IsCompleted(98) and Qst.Sub:Check(98, 1) then
      Obj:new(NPC, "agumon_knight_01"):SetIcon(ICO_TALK)
    end
    if Qst.Sub:Check(211, 1) then
      Obj:new(NPC, "agumon_knight_01"):SetIcon(ICO_TALK)
    end
    if Qst.Sub:IsCompleted(211) then
      Obj:new(NPC, "RoyalKights_DUKEMON"):SetIcon(ICO_TALK)
      Obj:new(NPC, "RoyalKnights_CRANIAMON"):SetIcon(ICO_TALK)
    end
    M140:Event_080()
    require("S100_087")
    S100_087:Event_013()
    require("S100_089")
    S100_089:Event_050()
    require("s110_098")
    S110_098:Event_020()
    if Flg.Check("FLAG_IS_CLEAR_S110_211") then
      require("S110_211")
      S110_211:Event_035()
      S110_211:Event_045()
      S110_211:Event_055()
      S110_211:Event_065()
      S110_211:Event_075()
      S110_211:Event_085()
      S110_211:Event_095()
      S110_211:Event_105()
      S110_211:Event_115()
      S110_211:Event_125()
      S110_211:Event_135()
      S110_211:Event_145()
      S110_211:Event_155()
      S110_211:Event_160()
    end
  end
  if gMapNum == 215 then
    require("S070_055")
    S070_055:Event_040()
  end
  if gMapNum == 216 then
    if not Flg.Check("FLAG_MAIN_03_470") then
      Field.HideMinimap(true)
    end
    M120:Event_010()
    M250:Event_010()
    M350:Event_043()
  end
  if gMapNum == 217 then
    M130:Event_040()
    M130:Event_070()
    require("S050_043")
    S050_043:Event_040()
    S050_043:Event_070()
    if Flg.Check("FLAG_MAIN_03_570", "FLAG_MAIN_03_590") then
      SetControlScriptExternalVariable("bear_br_state", "warp")
    end
  end
  if Flg.Check("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE") then
    Flg.Clear("FLAG_IS_PLAY_EVENT_AFTER_CHAPTERCHANGE")
    Fade.Out(0, 0)
  end
end

function StartEventAfterFadeIn()
  print("##### StartEventAfterFadeIn #####")
  if gMapNum == 201 then
    if start_loc == "start_04" and not Flg.Check("FLAG_MAIN_03_716") then
      WaitFrame(30)
      Flg.Set("FLAG_MAIN_03_716")
      SetFollowerCameraOperateRotation(10, 120, 30)
    end
    M440:Event_830_ArrivalEvent()
  elseif gMapNum == 202 then
    M120:Event_063()
    if Flg.Check("FLAG_SUB_080_060_007") then
      require("S080_060")
      S080_060:Event_120()
    end
    require("S080_060")
    S080_060:Event_075()
    S080_060:Event_085()
  elseif gMapNum == 203 then
    if not Flg.Check("FLAG_SUB_080_060_009") then
      require("S080_060")
      S080_060:Event_020()
    end
  elseif gMapNum == 204 then
  elseif gMapNum == 205 then
  elseif gMapNum == 206 then
  elseif gMapNum == 207 then
  elseif gMapNum == 209 then
  elseif gMapNum == 210 then
    local start_loc = Field.GetLastPlayerSetLocator()
  elseif gMapNum == 211 then
    if not Flg.Check("FLAG_SUB_080_060_010") then
      require("S080_060")
      S080_060:Event_030()
    end
  elseif gMapNum == 212 then
  elseif gMapNum == 213 then
    if not Flg.Check("FLAG_SUB_080_060_011") then
      require("S080_060")
      S080_060:Event_040()
    end
  elseif gMapNum == 215 then
    M120:Event_065()
    if not Flg.Check("FLAG_SUB_080_060_012") then
      require("S080_060")
      S080_060:Event_050()
    end
  elseif gMapNum == 216 then
  end
end

function OnFieldAttackNpc(npc)
  local npc_name = npc.unique_name
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== OnFieldAttackNpc ======")
  print("====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
end

function UpdateMinimap(start_loc)
  if gMapNum == 201 then
    if start_loc == "start_03" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_04" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_08" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_91" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  end
  if gMapNum == 202 then
    MiniMapChange(MAP_LAYER_LOW)
    if start_loc == "start_00" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_07" then
      MiniMapChange(MAP_LAYER_LOW)
    end
    if start_loc == "start_05" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_08" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  end
  if gMapNum == 205 then
    MiniMapChange(MAP_LAYER_LOW)
    if start_loc == "start_02" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
    if start_loc == "start_03" then
      MiniMapChange(MAP_LAYER_LOW)
    end
  end
  if gMapNum == 207 and start_loc == "start_01" then
    MiniMapChange(MAP_LAYER_HIGH)
  end
  if gMapNum == 208 then
  end
  if gMapNum == 209 and start_loc == "start_01" then
    MiniMapChange(MAP_LAYER_HIGH)
  end
  if gMapNum == 210 then
  end
  if gMapNum == 217 and start_loc == "start_50" then
    MiniMapChange(MAP_LAYER_HIGH)
  end
end
