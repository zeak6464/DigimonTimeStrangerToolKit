function HazamaWayout(gim_name)
  print("Test_Sequence01")
  
  Field.CancelPlayerAnywhereDigimonRide(true)
  WaitFrame(1)
  print("##### INVISINVISIBLE DEGIMON #####")
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 10, false)
  Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 10, false)
  local obj = Obj:new(FLD_OBJ_GIMMICK, gim_name)
  local prefix, number = GetHazamaAddress()
  local locator_num = Work.Get(Field_Hazama_Locator)
  local locator = "start_" .. string.format("%02d", locator_num)
  local player = Obj:new(PLAYER, "")
  player:SetObjRotation(FLD_OBJ_GIMMICK, "way_out", 30)
  local tlk = Tlk:new("field_text")
  tlk:StartTalk()
  print("Test_Sequence02")
  tlk:Message("g_crevice_0020_0010")
  print("Test_Sequence03")
  tlk:MessageClose()
  print("Test_Sequence04")
  local result = tlk:Select(2, "g_sel_0020_0010")
  print("Test_Sequence05")
  if result == RESULT_TALK00 then
    print("Test_Sequence06")
    tlk:EndTalk(true)
    if Flg.Check("FLAG_IS_HAZAMA_AREACHANGE_MOVE") then
      print("####### REGULAR ROOT #######")
      GoToGimmickOuter(gim_name, "start_00")
      if gMapNum == 420 then
        Quest.SubReset(960)
        print("####### Reset 960 #######")
      elseif gMapNum == 421 then
        Quest.SubReset(961)
        print("####### Reset 961 #######")
      elseif gMapNum == 422 then
        Quest.SubReset(962)
        print("####### Reset 962 #######")
      elseif gMapNum == 423 then
        Quest.SubReset(963)
        print("####### Reset 963 #######")
      elseif gMapNum == 220 then
        Quest.SubReset(970)
        print("####### Reset 970 #######")
      elseif gMapNum == 221 then
        Quest.SubReset(971)
        print("####### Reset 971 #######")
      elseif gMapNum == 222 then
        Quest.SubReset(972)
        print("####### Reset 972 #######")
      end
      print("####### ANOTHER ROOT FLG CLEAR #######")
      Flg.Clear("FLAG_IS_HAZAMA_AREACHANGE_MOVE")
      Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
      MapChange(prefix, number, locator, true, FADE_WHITE, FADE_TIME)
    else
      print("####### ANOTHER ROOT #######")
      print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
      GoToGimmickOuter(gim_name, "start_00")
      if gMapNum == 420 then
        Quest.SubReset(960)
        print("####### Reset 960 #######")
      elseif gMapNum == 421 then
        Quest.SubReset(961)
        print("####### Reset 961 #######")
      elseif gMapNum == 422 then
        Quest.SubReset(962)
        print("####### Reset 962 #######")
      elseif gMapNum == 423 then
        Quest.SubReset(963)
        print("####### Reset 963 #######")
      elseif gMapNum == 220 then
        Quest.SubReset(970)
        print("####### Reset 970 #######")
      elseif gMapNum == 221 then
        Quest.SubReset(971)
        print("####### Reset 971 #######")
      elseif gMapNum == 222 then
        Quest.SubReset(972)
        print("####### Reset 972 #######")
      end
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
      MapChange("t", 3001, "start_05", true, FADE_WHITE, FADE_TIME)
    end
  elseif result == RESULT_TALK01 then
    print("Test_Sequence07")
    tlk:EndTalk()
  end
end

function HazamaQuestClearCount(map_id)
  local clear_count = 0
  if map_id == HAZAMA_H02 then
    if Flg.Check("FLAG_IS_CLEAR_H210") then
      clear_count = clear_count + 1
      print("##### IsCompleted 920 #####")
    end
    if Flg.Check("FLAG_IS_CLEAR_H211") then
      clear_count = clear_count + 1
      print("##### IsCompleted 921 #####")
    end
    if Flg.Check("FLAG_IS_CLEAR_H212") then
      clear_count = clear_count + 1
      print("##### IsCompleted 922 #####")
    end
    if Flg.Check("FLAG_IS_CLEAR_H213") then
      clear_count = clear_count + 1
      print("##### IsCompleted 923 #####")
    end
  end
  if map_id == HAZAMA_H03 then
    if Flg.Check("FLAG_IS_CLEAR_H310") then
      clear_count = clear_count + 1
      print("##### IsCompleted 930 #####")
    end
    if Flg.Check("FLAG_IS_CLEAR_H311") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H312") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H313") then
      clear_count = clear_count + 1
    end
  end
  if map_id == HAZAMA_H04 then
    if Flg.Check("FLAG_IS_CLEAR_H415") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H416") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H417") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H418") then
      clear_count = clear_count + 1
    end
  end
  if map_id == HAZAMA_H05 then
    if Flg.Check("FLAG_IS_CLEAR_H510") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H511") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H512") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H513") then
      clear_count = clear_count + 1
    end
  end
  if map_id == HAZAMA_H08 then
    if Flg.Check("FLAG_IS_CLEAR_H810") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H811") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H812") then
      clear_count = clear_count + 1
    end
    if Flg.Check("FLAG_IS_CLEAR_H813") then
      clear_count = clear_count + 1
    end
  end
  print("##### HazamaQuestClearCount = ", clear_count, " #####")
  return clear_count
end

function HazamaSeriesClearCount()
  local clear_count = 0
  if Flg.Check("FLAG_IS_CLEAR_H02") then
    clear_count = clear_count + 1
  end
  if Flg.Check("FLAG_IS_CLEAR_H03") then
    clear_count = clear_count + 1
  end
  if Flg.Check("FLAG_IS_CLEAR_H04") then
    clear_count = clear_count + 1
  end
  if Flg.Check("FLAG_IS_CLEAR_H05") then
    clear_count = clear_count + 1
  end
  if Flg.Check("FLAG_IS_CLEAR_H08") then
    clear_count = clear_count + 1
  end
  print("##### HazamaSeriesClearCount = ", clear_count, " #####")
  return clear_count
end

function HazamaItemCount()
  local Item_count = 0
  for i = 22101, 22156 do
    if 0 < Item.GetNum(i) then
      Item_count = Item_count + 1
    end
  end
  print("##### Item_count = ", tostring(i), " #####")
  return Item_count
end

function IsSettingRideDigimonHazama(ride_type)
  local degimon1 = Digimon.GetUniqueIDInPartyMember(DEGIMON_1)
  local degimon2 = Digimon.GetUniqueIDInPartyMember(DEGIMON_2)
  local degimon3 = Digimon.GetUniqueIDInPartyMember(DEGIMON_3)
  gim_text = "field_text"
  if degimon1 ~= nil and Digimon.GetDigimonRideType(degimon1) == ride_type then
    return DEGIMON_1
  elseif degimon2 ~= nil and Digimon.GetDigimonRideType(degimon2) == ride_type then
    return DEGIMON_2
  elseif degimon3 ~= nil and Digimon.GetDigimonRideType(degimon3) == ride_type then
    return DEGIMON_3
  else
    Field_Talk_Start(gGimText, 1)
    Message("g_f0401_0020_0010")
    Field_Talk_End()
    return false
  end
end

function SetProhibitHazamaTestArea(is_prohibit, fa_type)
  print("##### SetProhibitHazamaTestArea #####")
  if is_prohibit == true then
    Field.HideMinimap(false)
    MiniMapChange(MAP_LAYER_MIDDLE)
    Field.DisableMenu(false)
    Field.DisableSystemDigimonChat()
    if fa_type == false then
      Field.DisableAnalyzeAndFieldAttack()
    end
    Field.SetProhibitAnywhereDigimonRide(true)
    Field.DisableAutoRegeneration()
    print("##### INVISINVISIBLE DEGIMON #####")
    Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 0, false)
    Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 0, false)
    Digitter.Send(4000501, false)
    print("##### prohibit_ON #####")
  else
    Field.HideMinimap(true)
    Field.CancelDisableMenu()
    if fa_type == false then
      Field.CancelDisableAnalyzeAndFieldAttack()
    end
    Field.CancelDisableSystemDigimonChat()
    Field.SetProhibitAnywhereDigimonRide(false)
    Field.CancelDisableAutoRegeneration()
    print("##### VISINVISIBLE DEGIMON #####")
    Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 30, false, false)
    Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 30, false, false)
    Digitter.Send(4000502, true)
    if not Flg.Check("FLAG_IS_HAZAMA_TUTORIAL1") then
      Digitter.Send(4000503, false)
      Flg.Set("FLAG_IS_HAZAMA_TUTORIAL1")
    end
    print("##### prohibit_OFF #####")
  end
end

function MoveToGimmick(gim_name, dis_x, dis_y)
  dis_x = dis_x or 0.5
  dis_y = dis_y or 0.5
  local player = Obj:new(PLAYER, "")
  local obj = Obj:new(FLD_OBJ_GIMMICK, gim_name)
  local gim_vec = Field.GetUnitVector2D(obj.rot_y)
  local loc_point_x = obj.pos.x + gim_vec.x * dis_x
  local loc_point_z = obj.pos.z + gim_vec.z * dis_y
  local point_x = loc_point_x - player.pos.x
  local point_z = loc_point_z - player.pos.z
  print("====== point_x = ", point_x, " ====== point_z = ", point_z, " ======")
  if 0.3 < point_x or 0.3 < point_z or point_x < -0.3 or point_z < -0.3 then
    MovePlayerToRelativePosFrame(point_x, point_z, 15)
    WaitFrame(15)
  end
  PlayerObjectResetAim()
  PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
end

FA_OK = true
FA_NG = false
H0510_BOSS = 27
H0511_BOSS = 28
H0512_BOSS = 15
H0513_BOSS = 1

function TerminalAccsess(quest_id)
  print("##### TerminalAccsess START #####")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  MoveToGimmick("control_panel", 1, 1)
  local player = Obj:new(PLAYER, "")
  local player_e003 = Motion.Object:new(PLAYER, "", "e003")
  local player_fg07_m01 = Motion.Object:new(PLAYER, "", "fg07_m01")
  local player_fn01_01 = Motion.Object:new(PLAYER, "", "fn01_01")
  player_fg07_m01:Play2Wait(10, false)
  Cam.Inst:Set(-0.376532, 31.301052, 35.824707, 2.035101, 32.085464, 45.497799, default, 60)
  player_fn01_01:Play(10, true)
  SetControlScriptExternalVariable("g_hazama_quest_status", QST_INITIALIZE)
  local tlk = Tlk:new("field_text", 1, true)
  tlk:StartTalk()
  PlaySE(401025, 100)
  Field.ObjectAttachEffectScript(PLAYER, player.index, "ef_f_sys_110_he", true, 2, false, false, false, false, "CP01")
  Field.ObjectStartEffectScript(PLAYER, player.index, 2)
  if gMapId == HAZAMA_H02 then
    tlk:MessageAuto("g_hazama_0020_0020", 40)
  elseif gMapId == HAZAMA_H03 then
    tlk:MessageAuto("g_hazama_0020_0030", 40)
  elseif gMapId == HAZAMA_H04 then
    tlk:MessageAuto("g_hazama_0020_0040", 40)
  elseif gMapId == HAZAMA_H05 then
    tlk:MessageAuto("g_hazama_0020_0050", 40)
  elseif gMapId == HAZAMA_H08 then
    tlk:MessageAuto("g_hazama_0020_0080", 40)
  end
  if Digimon.IsFullHpSpAllParty() then
    tlk:Message("g_hazama_0010_0010")
  else
    PlaySE(100008, 100)
    tlk:Message("g_hazama_0010_0020")
    PlaySE(300219, 100)
    Field.ObjectAttachEffectScript(PLAYER, player.index, "ef_b_hea_100", false, 2, false, false, false, false, "CP01")
    Field.ObjectStartEffectScript(PLAYER, player.index, 2)
    tlk:Message("g_hazama_0010_0030")
    Digimon.RestoreAllParty()
  end
  Field.ObjectEndEffectScript(PLAYER, player.index, 2)
  tlk:EndTalk(true)
  local is_orders = Qst.Hazama:Orders(quest_id)
  if is_orders then
    if gMapId == HAZAMA_H03 then
      local state = "setting"
      SetControlScriptExternalVariable("race_state", state)
      INFO_WINDOW(10021)
      Item.Delete(22010, 1)
    end
    SetControlScriptExternalVariable("g_hazama_quest_status", QST_ORDER)
    player_e003:Play(10, false)
    WaitFrame(20)
    PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    StartEffectScript(PLAYER, player.index, 1)
    WaitFrame(20)
    player:Invisible()
    WaitFrame(10)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Enemys.AllRespawn(true, true)
    ResetFAObject()
    WaitFrame(60)
    print("##### ENEMMY RESET #####")
    Common.SetHazamaQuestState(true)
    Field.SetPlayerLocator("start_01")
    Cam.Inst:Clear(0)
    player_e003:Reset(0)
    if gMapId == HAZAMA_H03 then
      SetProhibitHazamaTestArea(true, FA_NG)
    else
      SetProhibitHazamaTestArea(true, FA_OK)
    end
    if gMapId == HAZAMA_H02 then
      Field.CameraSwitchChangeByFileName("cam06_railcam", "followcam_default_loc", false)
      Cam.Follower:Reset2Clear(0, -1, 30)
      InitializeH02()
      MiniMapChange(MAP_LAYER_LOW)
    elseif gMapId == HAZAMA_H03 then
      InitializeH03()
      Prcs_H03RaceSet()
    elseif gMapId == HAZAMA_H04 then
      Cam.Follower:Reset2Clear(0, -1, 30)
      InitializeH04()
      MiniMapChange(MAP_LAYER_LOW)
    elseif gMapId == HAZAMA_H05 then
      Cam.Follower:Reset2Clear(0, -1, 0)
      InitializeH05()
    elseif gMapId == HAZAMA_H08 then
      Cam.Follower:Reset2Clear(0, -1, 30)
      InitializeH08()
      MiniMapChange(MAP_LAYER_LOW)
    end
    PlayerObjectResetAim()
    player.pos = Field.ObjectGetPosition(PLAYER, player.index)
    player.rot_y = Field.ObjectGetRotationY(PLAYER, player.index)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
    PlaySE(200006, 100)
    WaitFrame(30)
    Field.ObjectEndEffectScript(PLAYER, player.index, 1)
    player:CancelInvisible()
    WaitFrame(10)
    if gMapNum == 510 then
      Prcs_h05_QuestStartEvent(Field.GetSymbolEnemyIndex(H0510_BOSS))
    elseif gMapNum == 511 then
      Prcs_h05_QuestStartEvent(Field.GetSymbolEnemyIndex(H0511_BOSS))
    elseif gMapNum == 512 then
      Prcs_h05_QuestStartEvent(Field.GetSymbolEnemyIndex(H0512_BOSS))
    elseif gMapNum == 513 then
      Prcs_h05_QuestStartEvent(Field.GetSymbolEnemyIndex(H0513_BOSS))
    end
    if gMapId == HAZAMA_H02 then
      SetControlScriptExternalVariable("g_wait", "Initialize")
      Qst.Hazama:Start(quest_id, true)
    elseif gMapId == HAZAMA_H04 then
      Qst.Hazama:Start(quest_id, true)
    elseif gMapId == HAZAMA_H03 then
      Qst.Hazama:Start(quest_id)
      Prcs_H03CountStart()
    else
      Qst.Hazama:Start(quest_id)
    end
    SetControlScriptExternalVariable("g_hazama_quest_status", QST_PROGRESS)
    print("##### TerminalAccsess END ### g_hazama_quest_status = ", GetControlScriptExternalVariable("g_hazama_quest_status", "string"), " #####")
  else
    print("##### TerminalAccsess CANCEL #####")
    Cam.Follower:Reset2Clear(60, nil, 0, true)
    print("##### VISINVISIBLE DEGIMON #####")
    Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  end
end

FA_OK = true
FA_NG = false

function TerminalAccsess2(quest_id)
  print("##### TerminalAccsess START #####")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  print("##### INVISINVISIBLE DEGIMON #####")
  Field_InvisibleFollowerAllPartyMember(1, 30, false)
  Field_InvisibleFollowerAllGuest(1, 30, false)
  MoveToGimmick("control_panel", 1, 1)
  local player = Obj:new(PLAYER, "")
  local player_e003 = Motion.Object:new(PLAYER, "", "e003")
  Cam.Inst:Set(-1.2237, 29.398, 31.189, 1.372, 32.663, 40.277, default, 60)
  WaitFrame(50)
  local is_orders = Qst.Hazama:Orders(quest_id)
  if is_orders then
    player_e003:Play(10, false)
    WaitFrame(20)
    PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
    PlaySE(200006, 100)
    WaitFrame(20)
    StartEffectScript(PLAYER, player.index, 1)
    WaitFrame(20)
    player:Invisible()
    WaitFrame(10)
    Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
    Common.SetHazamaQuestState(true)
    Field.SetPlayerLocator("start_02")
    Cam.Inst:Clear(0)
    player_e003:Reset(0)
    Cam.Follower:Reset2Clear(0, -1, 0)
    MiniMapChange(MAP_LAYER_LOW)
    PlayerObjectResetAim()
    player.pos = Field.ObjectGetPosition(PLAYER, player.index)
    player.rot_y = Field.ObjectGetRotationY(PLAYER, player.index)
    FadeAllInWithWait(FADE_BLACK, FADE_TIME)
    PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
    PlaySE(200006, 100)
    WaitFrame(30)
    Field.ObjectEndEffectScript(PLAYER, player.index, 1)
    player:CancelInvisible()
    WaitFrame(10)
    Qst.Hazama:Start(quest_id)
    Prcs_h04_BossBattle2()
  else
    print("##### TerminalAccsess CANCEL #####")
    Cam.Follower:Reset2Clear(60, nil, 0, true)
    Field_CancelInvisibleFollowerAllPartyMember(1, 20, false, false)
    Field_CancelInvisibleFollowerAllGuest(1, 20, false, false)
  end
end

function HazamaFirstTripEvent()
  print("##### HazamaFirstTripEvent #####")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ====== map_id = ", gMapId, " ======")
  print("##### INVISINVISIBLE DEGIMON #####")
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 10, false)
  Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 10, false)
  local first_visited_flg = false
  local player = Obj:new(PLAYER, "")
  local player_e201 = Motion.Object:new(PLAYER, "", "e201")
  Cam.Inst:Set(-0.043474, 30.660185, 43.59124, 0.967627, 31.713772, 53.484047, default, 200)
  MovePlayerToRelativePosFrame(0, -2.5, 50)
  WaitFrame(50)
  player_e201:Play(10, true)
  WaitFrame(60)
  player_e201:Reset(10)
  WaitFrame(10)
  Digitter.Send(4000000, true)
  AnswerTheCall()
  WaitFrame(30)
  local tlk = Tlk:new("field_text", 1, false)
  tlk:StartNarration()
  tlk:Narration("g_hazama_0000_0010", 2)
  tlk:Narration("g_hazama_0000_0020", 2)
  tlk:Narration("g_hazama_0000_0030", 2)
  tlk:Narration("g_hazama_0000_0040", 2)
  tlk:Narration("g_hazama_0000_0050", 2)
  tlk:Narration("g_hazama_0000_0060", 2)
  tlk:Narration("g_hazama_0000_0070", 2)
  tlk:Narration("g_hazama_0000_0080", 2)
  tlk:NarrationClose()
  tlk:EndTalk(true)
  EndTheCall()
  Cam.Inst:Clear(60)
  Flg.Set("FLAG_IS_HAZAMA_FIRST_TRIP")
  print("##### VISINVISIBLE DEGIMON #####")
  Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field.CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function HazamaClearEvent(quest_id, line_num, is_clear_flg)
  print("=============== HazamaClearEvent quest_id = ", quest_id, " =====================")
  local tlk = Tlk:new("field_text", 1, true)
  local player = Obj:new(PLAYER, "")
  local player_e004 = Motion.Object:new(PLAYER, "", "e004")
  SetControlScriptExternalVariable("g_hazama_quest_status", QST_PREEND)
  WaitFrame(10)
  Qst.Hazama:Clear(quest_id)
  local HazamaQuest_clear_flg = "FLAG_IS_CLEAR_H" .. tostring(gMapNum)
  Flg.Set(HazamaQuest_clear_flg)
  tlk:StartTalk()
  tlk:Message("g_hazama_0030_0010")
  tlk:MessageClose()
  WaitFrame(10)
  player_e004:Play(10, false)
  WaitFrame(30)
  PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
  PlaySE(200006, 100)
  StartEffectScript(PLAYER, player.index, 1)
  WaitFrame(30)
  player:Invisible()
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(FADE_TIME)
  player:SetObjectPositionFromObject(FLD_OBJ_GIMMICK, "terminal", 0, 0, 5.5, false)
  WaitFrame(1)
  player:SetObjRotationWithCamera(FLD_OBJ_GIMMICK, "terminal", 0)
  Restore.Party()
  local dotnpc = Obj:new(NPC, "dot_npc")
  if not is_clear_flg then
    print("##### INVISIBLE NPC #####")
    Flg.Set("FLAG_IS_HAZAMA_NPC_VISIBLE")
    FieldObjectSync(NPC, false)
    dotnpc:Invisible()
  end
  Enemys.AllDespawn(false, FOREVER, 0)
  FieldObjectSync(FOR_ALL, false)
  if gMapId == HAZAMA_H02 then
    Field.CameraSwitchChangeByFileName("cam01_railcam", "followcam_default_loc", false)
    InitializeH02()
  elseif gMapId == HAZAMA_H03 then
    InitializeH03()
    local beda_x = Field.GetControlScriptExternalVariableNumber("beda_pos_x")
    local beda_y = Field.GetControlScriptExternalVariableNumber("beda_pos_y")
    local beda_z = Field.GetControlScriptExternalVariableNumber("beda_pos_z")
    local beda_rot_y = Field.GetControlScriptExternalVariableNumber("beda_rot_y")
    Obj:new(NPC, "npc_001"):SetPos(beda_x, beda_y, beda_z)
    Obj:new(NPC, "npc_001"):SetRotationY(beda_rot_y, 0)
    Obj:new(NPC, "rival"):SetPos(-25, 28.5, 18, false)
    Obj:new(NPC, "rival"):SetRotationY(0, 0)
  elseif gMapId == HAZAMA_H04 then
    InitializeH04()
  elseif gMapId == HAZAMA_H05 then
    InitializeH05()
    MiniMapChange(MAP_LAYER_LOW)
  elseif gMapId == HAZAMA_H08 then
    InitializeH08()
  end
  WaitFrame(1)
  Enemys.AllRespawn(false, true)
  ResetFAObject()
  print("##### ENEMMY RESET #####")
  Cam.Inst:Set(-1.76, 30.66, 38.45, 1.8, 32.18, 47.67, default, 0)
  FadeAllInWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(FADE_TIME)
  player.pos = Field.ObjectGetPosition(PLAYER, player.index)
  player.rot_y = Field.ObjectGetRotationY(PLAYER, player.index)
  PlayEffectScript("ef_f_mov_111_wa", player.pos.x, player.pos.y + 1.2, player.pos.z, player.rot_y, 1)
  PlaySE(200006, 100)
  player_e004:Reset(0)
  WaitFrame(30)
  Field.ObjectEndEffectScript(PLAYER, player.index, 1)
  player:CancelInvisible()
  if not is_clear_flg then
    print("##### ClearMessage #####")
    WaitFrame(20)
    Cam.Inst:Set(0, 31, 35.5, 0, 32, 45.5, default, 20)
    WaitFrame(10)
    tlk:Message("g_hazama_0030_0020")
    tlk:MessageClose()
    Cam.Inst:Set(0, 31, 33.5, 0, 32, 43.5, default, 90)
    local slot_num = PlaySE(200009, 100)
    WaitFrame(70)
    StopSE(slot_num, 10)
    PlaySE(200010, 100)
    local gim_terminal_e001_online = Motion.Object:new(FLD_OBJ_GIMMICK, "terminal", "e001")
    dotnpc:CancelInvisible(10)
    gim_terminal_e001_online:Play(15, false)
    WaitFrame(10)
    PlaySE(102007, 100)
    print("##### Complete Message #####")
    local clear_cnt = 0
    local item_id = 0
    local info_id = 0
    if gMapId == HAZAMA_H02 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H02)
      info_id = 10001
      item_id = 22001
    elseif gMapId == HAZAMA_H03 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H03)
      info_id = 10002
      item_id = 22002
    elseif gMapId == HAZAMA_H04 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H04)
      info_id = 10003
      item_id = 22003
    elseif gMapId == HAZAMA_H05 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H05)
      info_id = 10004
      item_id = 22004
    elseif gMapId == HAZAMA_H08 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H08)
      info_id = 10005
      item_id = 22005
    end
    if clear_cnt == 4 then
      tlk:Message("g_hazama_0040_0010")
      INFO_WINDOW(info_id)
      Item.Add(item_id, 1)
    end
    Flg.Clear("FLAG_IS_HAZAMA_NPC_VISIBLE")
  end
  tlk:EndTalk(true)
  WaitFrame(20)
  Qst.Hazama:End(quest_id, 255)
  SetControlScriptExternalVariable("g_hazama_quest_status", QST_INITIALIZE)
  FieldObjectSync(NPC, false)
  Common.SetHazamaQuestState(false)
  if not Flg.Check("FLAG_IS_HAZAMA_FIRST_CLEAR") then
    Flg.Set("FLAG_IS_HAZAMA_FIRST_CLEAR")
    ReserveDigitter("FLAG_IS_HAZAMA_RESERVE_DIGITTER")
  end
  if gMapId == HAZAMA_H02 or HAZAMA_H03 or HAZAMA_H04 or HAZAMA_H05 or HAZAMA_H08 then
    local clear_cnt = 0
    if gMapId == HAZAMA_H02 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H02)
    elseif gMapId == HAZAMA_H03 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H03)
    elseif gMapId == HAZAMA_H04 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H04)
    elseif gMapId == HAZAMA_H05 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H05)
    elseif gMapId == HAZAMA_H08 then
      clear_cnt = HazamaQuestClearCount(HAZAMA_H08)
    end
    if clear_cnt == 4 then
      local series_clear_flg = "FLAG_IS_CLEAR_H0" .. tostring(gMapId)
      if not Flg.Check(series_clear_flg) then
        Flg.Set(series_clear_flg)
        local siries_clear_cnt = HazamaSeriesClearCount()
        if siries_clear_cnt == 1 then
          Digitter.Send(4001001, true)
        elseif siries_clear_cnt == 2 then
          Digitter.Send(4001101, true)
        elseif siries_clear_cnt == 3 then
          Digitter.Send(4001201, true)
        elseif siries_clear_cnt == 4 then
          Digitter.Send(4001301, true)
        elseif siries_clear_cnt == 5 then
          Cam.Inst:Clear(60)
          Digitter.Send(4000000, true)
          AnswerTheCall()
          WaitFrame(30)
          local tlk = Tlk:new("field_text", 1, false)
          tlk:StartNarration()
          tlk:Narration("g_hazama_0000_0100", 2)
          tlk:Narration("g_hazama_0000_0110", 2)
          tlk:Narration("g_hazama_0000_0120", 2)
          tlk:Narration("g_hazama_0000_0130", 2)
          tlk:Narration("g_hazama_0000_0140", 2)
          tlk:Narration("g_hazama_0000_0150", 2)
          tlk:Narration("g_hazama_0000_0160", 2)
          tlk:Narration("g_hazama_0000_0170", 2)
          WaitFrame(10)
          tlk:Narration("g_hazama_0000_0180", 2)
          tlk:NarrationClose()
          tlk:EndTalk(true)
          EndTheCall()
          Flg.Set("FLAG_IS_HAZAMA_ALL_COMPLETE")
        end
      end
    end
  end
  SetProhibitHazamaTestArea(false, FA_OK)
  Cam.Inst:Clear(60)
  HideMinimap(false)
  HideGuide(false)
end

function InitializeH02()
  print("##### InitializeH02 #####")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE1")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE2")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE3")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE4")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE5")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE6")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE7")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE8")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE9")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE10")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE11")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE12")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE13")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE14")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE15")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE16")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE17")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE18")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE19")
  Flg.Clear("FLAG_IS_HAZAMA_WAVE20")
  SetControlScriptExternalVariable("g_wait", "Initialize")
  SetControlScriptExternalVariable("g_encount_num", 0)
end

function InitializeH03()
  print("##### InitializeH03 #####")
  SetControlScriptExternalVariable("g_hit_num", 0)
end

function InitializeH04()
  print("##### InitializeH04 #####")
  Flg.Clear("FLAG_IS_HAZAMA_BOSS_CALL")
  SetControlScriptExternalVariable("g_reserve_boss_battle", false)
  SetControlScriptExternalVariable("g_fa_defeat", 0)
end

function InitializeH05()
  print("##### InitializeH05 #####")
  SetControlScriptExternalVariable("g_game_state", "initialize")
  SetControlScriptExternalVariable("g_player_state", "initialize")
  SetControlScriptExternalVariable("g_game_timer", 0)
  SetControlScriptExternalVariable("g_enemy_cnt", 0)
  SetControlScriptExternalVariable("g_tmp_root_num", 0)
  SetControlScriptExternalVariable("g_symbol_index", 0)
  SetControlScriptExternalVariable("g_encount_num", 0)
end

function InitializeH08()
  print("##### InitializeH08 #####")
  SetControlScriptExternalVariable("g_enemy_count", 0)
end

function OpenHazmaMenu()
  print("##### OpenHazmaMenu #####")
  local prefix, map_num, locator
  Field.ObjectSuspendAutoTransparentForCamera(NPC, FOR_ALL)
  Cam.Inst:Set(-19.65, 0.249, 2.2, -9.996, 1.447, -0.099, default, 20)
  print("##### IsAbleDungeonFront = true #####")
  Quest.OpenDungeonFront()
  while true do
    if Quest.IsSelectedDungeonFront() then
      print("##### IsSelectedDungeonFront #####")
      prefix = Quest.GetDungeonFrontPrefix()
      map_num = Quest.GetDungeonFrontMapNumber()
      locator = Quest.GetDungeonFrontLocator()
      print("##### prefix = ", prefix, " map_num = ", map_num, " locator = ", locator, " #####")
      break
    end
    WaitFrame(1)
  end
  print("##### IsSelectedDungeonFront #####")
  if Quest.IsCanceledDungeonFront() then
    print("##### CanselDungeonFront #####")
    Quest.CloseDungeonFront()
    while true do
      if Quest.IsClosedDungeonFront() then
        Quest.EndDungeonFront()
        break
      end
      WaitFrame(1)
    end
    Field.WaitForBeingPrepared()
  else
    print("##### SelectDungeonFront #####")
    Quest.CloseDungeonFront()
    print("##### CloseDungeonFront #####")
    while true do
      if Quest.IsClosedDungeonFront() then
        Quest.EndDungeonFront()
        break
      end
      WaitFrame(1)
    end
  end
  return prefix, map_num, locator
end

function GoToHazamaWithEvt(gim)
  print("====== GoToHazamaWithEvt ======")
  local gim_name = gim.unique_name
  local gim_tag = gim.tag
  local loc_num = string.sub(gim_tag, -2)
  local hazama_mapid = string.sub(gim.tag, 2, 4)
  local start_loc_name = "start_" .. loc_num
  print("====== loc_num = ", loc_num, "hazama_mapid = ", hazama_mapid, "start_loc_name = ", start_loc_name, " ======")
  local player = Obj:new(PLAYER, "")
  SetControlScriptExternalVariable("hazama_place", start_loc_name .. "#" .. gim_name)
  player:SetObjRotation(FLD_OBJ_GIMMICK, gim_name, 0)
  local tlk = Tlk:new("field_text")
  tlk:StartTalk()
  tlk:Message("g_crevice_0010_0010")
  tlk:MessageClose()
  local result = tlk:Select(2, "g_sel_0010_0010")
  print("Test_Sequence05")
  if result == RESULT_TALK00 then
    print("Test_Sequence06")
    tlk:EndTalk(true)
    print("set start_", loc_num)
    Work.Set(Field_Hazama_Locator, loc_num)
    CreateHazamaAddress()
    Flg.Set("FLAG_IS_HAZAMA_AREACHANGE_MOVE")
    GoToGimmickOuter(gim_name, start_loc_name)
    MapChange("h", hazama_mapid, "start_00", true, FADE_WHITE, FADE_TIME)
  elseif result == RESULT_TALK01 then
    print("Test_Sequence07")
    tlk:EndTalk()
  end
end

function CreateHazamaAddress()
  local map_num, map_prefix = Field.GetMapNumber(), Field.GetMapPrefix()
  local map_id = 0
  if map_prefix == "t" then
    map_id = map_num
  elseif map_prefix == "d" then
    map_id = 10000 + map_num
  elseif map_prefix == "h" then
    map_id = 20000 + map_num
  end
  print("Created Hazama Address = ", map_id)
  Work.Set(Field_Hazama_Created_Address, map_id)
end

function GetHazamaAddress()
  local address = Work.Get(Field_Hazama_Created_Address)
  local prefix, number
  if address < 10000 then
    prefix = "t"
    number = address
  elseif address < 20000 then
    prefix = "d"
    number = address - 10000
  elseif address < 30000 then
    prefix = "h"
    number = address - 20000
  end
  return prefix, number
end

function GoToGimmickOuter(gim_name, loc_name)
  local player = Obj:new(PLAYER, "")
  local obj = Obj:new(FLD_OBJ_GIMMICK, gim_name)
  print("====== gim_name = ", gim_name, " ======")
  print("====== loc_name = ", loc_name, " ======")
  local gim_vec = Field.GetUnitVector2D(obj.rot_y)
  local loc_point_x = obj.pos.x + gim_vec.x * 1
  local loc_point_z = obj.pos.z + gim_vec.z * 1
  local y_degree = Field.GetAngleToTarget2D(obj.pos.x, obj.pos.z, loc_point_x, loc_point_z)
  local point_x = loc_point_x - player.pos.x
  local point_z = loc_point_z - player.pos.z
  local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
  local loc_to_cam_ydegree = Field.GetAngleToTarget2D(loc_point_x, loc_point_z, cam_pos_x, cam_pos_z)
  local gim_to_loc_ydegree = Field.GetAngleToTarget2D(obj.pos.x, obj.pos.z, loc_point_x, loc_point_z)
  local gim_to_loc_vec
  if loc_to_cam_ydegree < gim_to_loc_ydegree or loc_to_cam_ydegree > gim_to_loc_ydegree + 180 then
    print("====== campos = RIGHT pc_to_cam_ydegree = ", loc_to_cam_ydegree, "gim_to_pc_ydegree = ", gim_to_loc_ydegree, " ======")
    gim_to_loc_vec = Field.GetUnitVector2D(gim_to_loc_ydegree - 60)
  else
    print("====== campos = LEFT pc_to_cam_ydegree = ", loc_to_cam_ydegree, "gim_to_pc_ydegree = ", gim_to_loc_ydegree, " ======")
    gim_to_loc_vec = Field.GetUnitVector2D(gim_to_loc_ydegree + 60)
  end
  if gim_to_loc_vec ~= nil then
    local aim_pos_x = (player.pos.x + obj.pos.x) / 2
    local aim_pos_z = (player.pos.z + obj.pos.z) / 2
    local dis_point_x = loc_point_x + gim_to_loc_vec.x * 2
    local dis_point_y = obj.pos.y + 1.5
    local dis_point_z = loc_point_z + gim_to_loc_vec.z * 2
    Cam.Inst:Set(aim_pos_x, obj.pos.y + 1.3, aim_pos_z, dis_point_x, dis_point_y, dis_point_z, DEFAULT_ANGLE, 30)
  end
  PlayerObjectResetAim()
  MovePlayerToRelativePosFrame(point_x, point_z, 15)
  WaitFrame(20)
  Field.ObjectResetMotion(PLAYER, 1, 10)
  WaitFrame(10)
  PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
  WaitFrame(10)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  obj:Invisible(10)
  Field_SetEnvironmentSettings("es_d1101_gateIn")
  PlayEffectScript("ef_f_mov_145_ga", obj.pos.x, obj.pos.y, obj.pos.z, y_degree, 1)
  PlaySE(404005, 100)
  WaitFrame(30)
  Field.AdjustSpeedMovePlayerToTargetFrame2D(obj.pos.x, obj.pos.z, 30)
  WaitFrame(10)
  PlaySE(200006, 100)
end

function DotTalk(info_id, digimon_id, level, digitter_id, personality_id, personality_skill_id, gift)
  local name_tbl = {
    [590] = "char_RAREMON",
    [375] = "char_NANIMON",
    [21] = "char_WHAMON",
    [310] = "char_HOUOUMON",
    [56] = "char_LALAMON",
    [601] = "char_WITCHMON",
    [210] = "char_WINGDRAMON",
    [678] = "char_MAGNAGARURUMON",
    [77] = "char_REPPAMON",
    [344] = "char_IKKAKUMON",
    [364] = "char_METALTYRANNOMON",
    [128] = "char_TYRANTKABUTERIMON",
    [377] = "char_WIZARDMON",
    [474] = "char_DINOHUMON",
    [149] = "char_OROCHIMON",
    [197] = "char_CROSSMON",
    [387] = "char_BUBBMON",
    [342] = "char_ANDROMON",
    [44] = "char_CATCHMAMEMON",
    [213] = "char_SLAYERDRAMON"
  }
  print("##### TALK START  #####")
  level = level or 1
  personality_id = personality_id or 0
  personality_skill_id = personality_skill_id or 0
  gift = gift or -1
  local flag_name = "FLAG_IS_BONUS_H" .. tostring(gMapNum)
  local message_id = "g_degi_h0" .. tostring(gMapNum) .. "_"
  local dotnpc = Obj:new(NPC, "dot_npc")
  local player_e200 = Motion.Object:new(PLAYER, "", "e200")
  local npc_talk = Motion.Object:new(NPC, "dot_npc", "bn01")
  local npc_fan = Motion.Object:new(NPC, "dot_npc", "ba01")
  local npc_sad = Motion.Object:new(NPC, "dot_npc", "bn02")
  npc_talk:PlaySetting(0, 0, 0, 1, 1, false)
  if not Flg.Check(flag_name) then
    local tlk = Tlk:new("field_text", 1)
    tlk:StartTalk()
    local now_num = Common.GetBankDigimonNum()
    local max_num = Common.GetBankDigimonMaxNum()
    if not GetControlScriptExternalVariable("g_dot_talk_candel", "boolean") then
      tlk:Message(message_id .. "0010")
    end
    tlk:Message(message_id .. "0030")
    tlk:MessageClose()
    local result = tlk:Select(2, message_id .. "0040")
    if result == RESULT_TALK00 then
      if now_num < max_num then
        tlk:EndTalk()
        Bank.Digimon.Add(digimon_id, level, personality_id, personality_skill_id, gift)
        npc_fan:Play(0, true)
        player_e200:PlaySetting(5, 0, 0, 65, 1, false)
        player_e200:PlayAttachment(9, 5, false)
        WaitFrame(65)
        player_e200:PlaySetting(20, 150, 150, player_e200.end_frame, 1, false)
        PlaySE(102009, 100)
        dotnpc:Invisible(10)
        local digimon_name
        digimon_name = name_tbl[digimon_id]
        Window.SetReplaceStringInfo("char_name", digimon_name)
        INFO_WINDOW(info_id)
        player_e200:Wait()
        player_e200:HideAttachment(9)
        player_e200:Reset(10)
        Flg.Set(flag_name)
        FieldObjectSync(NPC, false)
        Digitter.Send(digitter_id)
      else
        tlk:Message(message_id .. "0020")
        tlk:EndTalk()
        npc_talk:Reset(0)
      end
    elseif result == RESULT_TALK01 then
      npc_sad:PlaySetting(0, 30, 30, 30, 1, false)
      tlk:EndTalk()
      SetControlScriptExternalVariable("g_dot_talk_candel", true)
    end
  else
    print("##### TALK FAILED  #####")
  end
end

function HazamaMessage(digitter_id, gim_index)
  local mes_flg = "FLAG_IS_MESSAGE_H" .. tostring(gMapNum)
  local extra_flg = "FLAG_IS_EXTRA_H" .. tostring(gMapNum)
  if not Flg.Check(mes_flg) then
    local obj = Obj:new(FLD_OBJ_GIMMICK, "log_message")
    local player_fg07_m01 = Motion.Object:new(PLAYER, "", "fg07_m01")
    player_fg07_m01:Play(5, false)
    WaitFrame(15)
    if Flg.Check(extra_flg) then
      PlaySE(402008, 100)
      WaitFrame(30)
      Field.ObjectAttachEffectScript(FLD_OBJ_GIMMICK, obj.index, "ef_f_tre_120_ge", false, 1, false, false, false, false)
      Field.ObjectStartEffectScript(FLD_OBJ_GIMMICK, obj.index, 1)
      Field.ObjectSetIcon(FLD_OBJ_GIMMICK, gim_index, FLD_ICON_NONE)
      local gim_log_message_open = Motion.Object:new(FLD_OBJ_GIMMICK, "log_message", "e001")
      gim_log_message_open:Play(10, false)
      WaitFrame(10)
      if gMapNum == 210 or gMapNum == 310 or gMapNum == 415 or gMapNum == 510 or gMapNum == 810 then
        INFO_GET_ITEM(59, 1)
      elseif gMapNum == 211 or gMapNum == 311 or gMapNum == 416 or gMapNum == 511 or gMapNum == 811 then
        INFO_GET_ITEM(59, 2)
      elseif gMapNum == 212 or gMapNum == 312 or gMapNum == 417 or gMapNum == 512 or gMapNum == 812 then
        INFO_GET_ITEM(59, 3)
      elseif gMapNum == 213 or gMapNum == 313 or gMapNum == 418 or gMapNum == 513 or gMapNum == 813 then
        INFO_GET_ITEM(59, 5)
      end
      WaitFrame(10)
      INFO_WINDOW(10020)
      WaitFrame(10)
      Digitter.Send(digitter_id)
      Flg.Set(mes_flg)
      Field.ObjectEndEffectScript(FLD_OBJ_GIMMICK, obj.index, 1)
    else
      PlaySE(100008, 100)
      if gMapNum == 210 or gMapNum == 211 or gMapNum == 212 or gMapNum == 213 then
        INFO_WINDOW(10006)
      elseif gMapNum == 310 or gMapNum == 311 or gMapNum == 312 or gMapNum == 313 then
        INFO_WINDOW(10007)
      elseif gMapNum == 415 or gMapNum == 416 or gMapNum == 417 or gMapNum == 418 then
        INFO_WINDOW(10008)
      elseif gMapNum == 510 or gMapNum == 511 or gMapNum == 512 or gMapNum == 513 then
        INFO_WINDOW(10009)
      elseif gMapNum == 810 then
        INFO_WINDOW(10010)
      elseif gMapNum == 811 then
        INFO_WINDOW(10011)
      elseif gMapNum == 812 then
        INFO_WINDOW(10012)
      elseif gMapNum == 813 then
        INFO_WINDOW(10013)
      end
    end
  end
end

Hazama_Race = {
  Field = {},
  Player = {},
  Rival = {}
}

function Hazama_Race.Field:new(param)
  local obj = {}
  obj.boost_item = {}
  obj.jammer_item = {}
  obj.audience = {}
  obj.final_lap = param.final_lap or 3
  obj.winer = nil
  
  function obj:CheckWiner(player, rival)
    if player == nil or rival == nil then
      return
    end
    if self.winer == nil then
      if player:IsGoal(self.final_lap) then
        print("win player")
        self.winer = "player"
        return
      elseif rival:IsGoal(self.final_lap) then
        print("win rival")
        self.winer = "rival"
        return
      end
    end
  end
  
  function obj:GetFieldBoostItems()
    local gim_num = GimmickSystem.GetObjectNum()
    self.boost_item = {}
    for i = 1, gim_num do
      local name = Gimmick(i).GetUniqueName()
      if string.find(name, "meat") ~= nil then
        self.boost_item[#self.boost_item + 1] = {
          index = i,
          is_inv = false,
          new_duration = 0,
          duration = 5
        }
      end
    end
    print("meat num: ", #self.boost_item)
  end
  
  function obj:GetFieldJammerItems()
    local gim_num = GimmickSystem.GetObjectNum()
    self.jammer_item = {}
    for i = 1, gim_num do
      local name = Gimmick(i).GetUniqueName()
      if string.find(name, "jammer") ~= nil then
        self.jammer_item[#self.jammer_item + 1] = {
          index = i,
          is_inv = false,
          now_duration = 0,
          duration = 5
        }
      end
    end
    print("jammer num: ", #self.jammer_item)
  end
  
  function obj:GetFieldAudience()
    local npc_num = NpcSystem.GetObjectNum()
    for i = 1, npc_num do
      local name = Npc(i).GetUniqueName()
      if string.find(name, "audience") ~= nil then
        local sort_str = ctrl_StringSplit(name, "_")
        local sort_num = tonumber(sort_str[2])
        local mess_num = tonumber(sort_str[3])
        self.audience[#self.audience + 1] = {
          index = i,
          sort = sort_num,
          mess = mess_num
        }
        print("#### Audience tbl sort = ", sort_num, " mess = ", mess_num, " ####")
      end
    end
    print("#### Audience num = ", #self.audience, " ####")
  end
  
  function obj:BoostItemInvisible(index)
    for i = 1, #self.boost_item do
      if self.boost_item[i].index == index then
        local frame = GetTotalElapsedFrame()
        local second = math.floor(SecondFromFrame(frame))
        self.boost_item[i].new_duration = second
        self.boost_item[i].is_inv = true
      end
    end
  end
  
  function obj:JammerItemInvisible(index)
    for i = 1, #self.jammer_item do
      if self.jammer_item[i].index == index then
        local frame = GetTotalElapsedFrame()
        local second = math.floor(SecondFromFrame(frame))
        self.jammer_item[i].now_duration = second
        self.jammer_item[i].is_inv = true
      end
    end
  end
  
  function obj:BoostItemUpdate()
    for i = 1, #self.boost_item do
      if self.boost_item[i].is_inv then
        local name = Gimmick(self.boost_item[i].index).GetUniqueName()
        local frame = GetTotalElapsedFrame()
        local second = math.floor(SecondFromFrame(frame))
        if self.boost_item[i].duration <= math.abs(self.boost_item[i].new_duration - second) then
          self.boost_item[i].is_inv = false
        else
          Gimmick(self.boost_item[i].index).InvisibleInNowFrame(1, 1, false)
        end
      end
    end
  end
  
  function obj:JammerItemUpdate()
    for i = 1, #self.jammer_item do
      if self.jammer_item[i].is_inv then
        local name = Gimmick(self.jammer_item[i].index).GetUniqueName()
        local frame = GetTotalElapsedFrame()
        local second = math.floor(SecondFromFrame(frame))
        if self.jammer_item[i].duration <= math.abs(self.jammer_item[i].now_duration - second) then
          self.jammer_item[i].is_inv = false
        else
          Gimmick(self.jammer_item[i].index).InvisibleInNowFrame(1, 1, false)
        end
      end
    end
  end
  
  function obj:CameraUpdate(input, cancel)
    input = input or false
    cancel = cancel or false
    local rot_y = Player().GetRotationY() + 180
    local frame = 2
    local angle = 45
    local race_state = GetExternalVariable("race_state")
    if race_state == "in_race" then
      if RacePlayer.boost_mode then
        angle = 60
      end
      if input then
        rot_y = Player().GetRotationY()
      end
      if cancel then
        frame = 0
      end
    end
    local pc_pos_x, pc_pos_y, pc_pos_z = Player().GetPosition()
    local vec_x, vec_z = GetUnitVector2D(rot_y)
    local cam_pos_x, cam_pos_z = pc_pos_x + vec_x * 7, pc_pos_z + vec_z * 7
    SetInstantCameraInNowFrame(pc_pos_x, pc_pos_y + 3, pc_pos_z, cam_pos_x, pc_pos_y + 4, cam_pos_z, angle, frame, 1)
  end
  
  return obj
end

function Hazama_Race.Player:new(param)
  local obj = {}
  param = param or {}
  obj.initial_velocity = param.initial_velocity or 2
  obj.velocity = obj.initial_velocity
  obj.acceleration = param.acceleration or 0.065
  obj.max_velocity = param.max_velocity or 10
  obj.max_boost_velocity = param.max_boost_velocity or 16
  obj.move_velocity = param.move_velocity or 5
  obj.move_wide = param.move_wide or 10
  obj.boost_power = 0
  obj.boost_decay = param.boost_decay or 1
  obj.boost_time = param.boost_time or 3
  obj.boost_mode = false
  obj.lap = -1
  obj.time = 0
  obj.goal_time = 0
  obj.boost_start_time = 0
  obj.check_time = 0
  obj.check_flag = false
  
  function obj:VelocityUpdate()
    local move_wide
    if self.check_flag then
      print("#### corner ####")
      Player().EnableRailMoveLeftAxisMoveOperate(self.move_velocity / 2, true, 5)
      move_wide = 5
    else
      Player().EnableRailMoveLeftAxisMoveOperate(self.move_velocity, true, 30)
      move_wide = 5
    end
    Player().SetRailMoveSpeed(self.velocity)
    Player().SetRailMoveDistanceToTheRailMovingAlongTheRail(move_wide + 1)
    Player().SetRailMoveMaximumLeftAndRightDistanceAwayFromTheRail(move_wide)
    Player().RailMoveGo()
  end
  
  function obj:Accelerate()
    if not self.boost_mode then
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      if second > self.time then
        self.time = second
        self.velocity = self.velocity + self.acceleration
        if self.velocity >= self.max_velocity then
          self.velocity = self.max_velocity
        end
      end
    end
  end
  
  function obj:Boost()
    local frame = GetTotalElapsedFrame()
    self.boost_mode = true
    self.boost_power = 100
    self.boost_start_time = math.floor(SecondFromFrame(frame))
    self.velocity = self.max_boost_velocity * (self.boost_power / 100)
  end
  
  function obj:BoostDecay()
    if self.boost_mode then
      Player().StartEffectScript(1)
      Player().StartEffectScript(2)
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      if self.boost_time <= math.abs(second - self.boost_start_time) then
        self.boost_power = self.boost_power - self.boost_decay
        self.velocity = (self.max_boost_velocity - self.max_velocity) * (self.boost_power / 100) + self.max_velocity
        if self.boost_power <= 0 then
          print("boost end")
          Player().EndEffectScript(1)
          Player().EndEffectScript(2)
          self.boost_power = 0
          self.boost_mode = false
          self.velocity = self.max_velocity
        end
      end
    end
  end
  
  function obj:VelocityDownGimmick(obj_index)
    local tag = Gimmick(obj_index).GetTag()
    local decay_num = tonumber(tag) / 100
    if not self.boost_mode then
      self.velocity = self.velocity - self.velocity * decay_num
    else
      self.boost_power = self.boost_power - self.boost_power * decay_num
    end
  end
  
  function obj:VelocityDownEnemy(obj_index)
    local tag = SymbolEnemy(obj_index).GetTag()
    local decay_num = tonumber(tag) / 100
    if not self.boost_mode then
      self.velocity = self.velocity - self.velocity * decay_num
    else
      self.boost_power = self.boost_power - self.boost_power * decay_num
    end
  end
  
  function obj:AddLap()
    self.lap = self.lap + 1
    print("lap: ", self.lap)
  end
  
  function obj:UpdateCheckPoint()
    if not self.check_flag then
      self.check_flag = true
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      self.check_time = second
      print("#### check point time :", self.check_time)
    end
  end
  
  function obj:UpdateCheckPointEnd()
    if self.check_flag then
      self.check_flag = false
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      print("#### check point End time :", second)
    end
  end
  
  function obj:UpdateCheck()
    if self.check_flag then
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      if 2 <= math.abs(self.check_time - second) then
        self.check_flag = false
      end
    end
  end
  
  function obj:IsGoal(final_lap)
    return final_lap <= self.lap
  end
  
  return obj
end

function Hazama_Race.Rival:new(param)
  local obj = {}
  param = param or {}
  
  function GetNpcName()
    local num = NpcSystem.GetObjectNum()
    for i = 1, num do
      local name = Npc(i).GetUniqueName()
      print("name :", name)
      if string.find(name, "rival") ~= nil then
        return name
      end
    end
  end
  
  obj.velocity = param.velocity or 12
  obj.name = GetNpcName()
  obj.index = GetIndex(NPC, obj.name)
  obj.lap_time = 0
  obj.lap_flag = false
  obj.lap_duration = 5
  obj.lap = -1
  
  function obj:Run()
    Npc(self.index).SetRailMoveSpeed(self.velocity)
    if RaceRival:IsGoal(RaceField.final_lap) then
      Npc(self.index).RailMoveGo()
      Npc(self.index).Move_SetRotationY(90, 1)
    else
      Npc(self.index).RailMoveGo()
    end
  end
  
  function obj:AddLap(final_lap)
    if not self.lap_flag then
      self.lap_flag = true
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      self.lap_time = second
      self.lap = self.lap + 1
      print("rival lap :", self.lap)
    end
  end
  
  function obj:LapCheck()
    if self.lap_flag then
      local frame = GetTotalElapsedFrame()
      local second = math.floor(SecondFromFrame(frame))
      if self.lap_duration <= math.abs(self.lap_time - second) then
        self.lap_flag = false
      end
    end
  end
  
  function obj:IsGoal(final_lap)
    return final_lap <= self.lap
  end
  
  return obj
end

function FirstDiscovery_HazamaGate(object_index)
  AnswerTheCall()
  local tlk = Tlk:new("field_text")
  tlk:StartTalk()
  tlk:Message("g_hazama_0100_0010")
  tlk:Message("g_hazama_0100_0020")
  tlk:EndTalk()
  EndTheCall()
  Digitter.Send(4000203, true)
  AddHazamaMenu(object_index)
end

function AddHazamaMenu(object_index)
  local tag_name = Field.ObjectGetTag(FLD_OBJ_GIMMICK, object_index)
  local flag_name = "FLAG_IS_TRIP_H" .. string.sub(tag_name, 2, 4)
  print("##### AddHazamaMenu flag = ", flag_name, " #####")
  if not Flg.Check(flag_name) then
    Flg.Set(flag_name)
    print("##### flag set = ", flag_name, " #####")
  end
  if Flg.Check("FLAG_IS_DISCOVERY_H210") and Flg.Check("FLAG_IS_DISCOVERY_H211") and Flg.Check("FLAG_IS_DISCOVERY_H212") and Flg.Check("FLAG_IS_DISCOVERY_H213") and Flg.Check("FLAG_IS_DISCOVERY_H310") and Flg.Check("FLAG_IS_DISCOVERY_H311") and Flg.Check("FLAG_IS_DISCOVERY_H312") and Flg.Check("FLAG_IS_DISCOVERY_H313") and Flg.Check("FLAG_IS_DISCOVERY_H415") and Flg.Check("FLAG_IS_DISCOVERY_H416") and Flg.Check("FLAG_IS_DISCOVERY_H417") and Flg.Check("FLAG_IS_DISCOVERY_H418") and Flg.Check("FLAG_IS_DISCOVERY_H510") and Flg.Check("FLAG_IS_DISCOVERY_H511") and Flg.Check("FLAG_IS_DISCOVERY_H512") and Flg.Check("FLAG_IS_DISCOVERY_H513") and Flg.Check("FLAG_IS_DISCOVERY_H810") and Flg.Check("FLAG_IS_DISCOVERY_H811") and Flg.Check("FLAG_IS_DISCOVERY_H812") and Flg.Check("FLAG_IS_DISCOVERY_H813") then
    Flg.Set("FLAG_IS_HAZAMA_GATE_ALL_UNLOCK")
    print("#### HAZAMA_GATE_ALL_UNLOCK ####")
  end
end

function PecmonShopStart(npc_name, shop_id, enter_mot, buy_mot, sell_mot, exit_mot, cam_npc, cam_shop, default_mot)
  local Purchased_flg = false
  if exit_mot == nil then
    exit_mot = enter_mot
  end
  local npc_index = GetIndex(NPC, npc_name)
  Field.ObjectResetAim(NPC, npc_index, 15)
  Field.ObjectLoadMotion(NPC, npc_index, enter_mot)
  Field.ObjectLoadMotion(NPC, npc_index, buy_mot)
  Field.ObjectLoadMotion(NPC, npc_index, sell_mot)
  Field.ObjectLoadMotion(NPC, npc_index, exit_mot)
  Field.ObjectLoadMotion(NPC, npc_index, "bn01")
  if default_mot ~= nil then
    Field.ObjectLoadMotion(NPC, npc_index, default_mot)
  end
  Field.ObjectSuspendAutoTransparentForCamera(NPC, npc_index)
  local message1 = "g_shop" .. string.format("%03d", shop_id) .. "_0010_0010"
  local message2 = "g_shop" .. string.format("%03d", shop_id) .. "_0010_0020"
  local message3 = "g_shop" .. string.format("%03d", shop_id) .. "_0010_0030"
  local message4 = "g_shop" .. string.format("%03d", shop_id) .. "_0020_0010"
  local message5 = "g_shop" .. string.format("%03d", shop_id) .. "_0030_0010"
  local message6 = "g_shop" .. string.format("%03d", shop_id) .. "_0040_0010"
  local message7 = "g_shop" .. string.format("%03d", shop_id) .. "_0040_0020"
  local message8 = "g_shop" .. string.format("%03d", shop_id) .. "_0050_0010"
  local pc = Obj:new(PLAYER, "")
  pc:Invisible(10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field.HideGuide(true)
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, enter_mot, 10, 10)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  local u_prefix = string.upper(Field.GetMapPrefix())
  local map_num_3 = string.format("%03d", Field.GetMapNumber())
  if not Flg.Check("FLAG_IS_CLEAR_" .. u_prefix .. map_num_3) then
    if not Flg.Check("FLAG_IS_H03_CLEAR_RACE") then
      Message(message1)
    else
      Message(message2)
    end
  else
    Message(message3)
  end
  Talk.Close()
  Cam.Inst:Set(cam_shop[1], cam_shop[2], cam_shop[3], cam_shop[4], cam_shop[5], cam_shop[6], default, 20)
  Shop.Open(shop_id)
  WaitFrame(1)
  while not Shop.IsClosed() do
    WaitFrame(1)
    if Shop.IsDealDone() then
      Shop.ResetDeal()
      if Shop.GetDealType() == 0 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, buy_mot, 10, 10)
        Shop.Message(message4)
        Purchased_flg = true
      elseif Shop.GetDealType() == 1 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, sell_mot, 10, 10)
        Shop.Message(message5)
      end
    end
    if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
      Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
    end
  end
  ShopClose()
  local beda = Obj:new(NPC, "npc_001")
  local distance = 1.5
  local vec = GetUnitVector2D(beda.rot_y)
  local pc_pox_x, pc_pos_z = beda.pos.x + vec.x * distance, beda.pos.z + vec.z * distance
  pc:SetPos(pc_pox_x, beda.pos.y, pc_pos_z)
  angle = GetAngleToTarget2D(pc.nowpos.x, pc.nowpos.z, beda.pos.x, beda.pos.z)
  pc:SetRotationY(angle, 0)
  SetFollowerCameraOperateRotation(0, angle - 10)
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  WaitFrame(15)
  if Purchased_flg then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, exit_mot, 10, 10)
    if not Flg.Check("FLAG_IS_CLEAR_" .. u_prefix .. map_num_3) then
      Message(message6)
    else
      Message(message7)
    end
  else
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, exit_mot, 10, 10)
    Message(message8)
  end
  Field_Talk_End_Not_LetterBox()
  Field.HideGuide(false)
  pc:CancelInvisible(10)
  Cam.Inst:Clear(30)
  if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
    Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
  end
  Field.ObjectCancelSuspendAutoTransparentForCamera(NPC, npc_index)
  Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
  return Purchased_flg
end

function ReserveDigitter(reserve_flg)
  local status = false
  if not Flg.Check(reserve_flg) then
    Flg.Set(reserve_flg)
    status = true
  end
  return status
end

function CtlDigitterSendCheck(digitter_id, reserve_flg, wait)
  if FlagCheck(reserve_flg) then
    local wait_count = GetExternalVariable("g_DigitterWaitTime")
    local send_status = false
    if wait_count == nil then
      print("#### Set DigitterSendCount ####")
      SetExternalVariable("g_DigitterWaitTime", wait)
      SetExternalVariable("g_DigitterId", digitter_id)
      wait_count = wait
    else
      wait_count = wait_count - 1
      SetExternalVariable("g_DigitterWaitTime", wait_count)
    end
    print("#### wait_count", wait_count, " ####")
    if wait_count <= 0 then
      send_status = DigitterSend(digitter_id)
      if send_status then
        print("#### DigitterSendSuccess ####")
        FlagClear(reserve_flg)
        SetExternalVariable("g_DigitterWaitTime", nil)
      else
        print("#### DigitterSendFailed ####")
      end
    end
  end
end
