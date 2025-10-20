function Field_CancelInvisiblePlayer(key, fade_frame, is_force_cancel, is_zero_alpha_start)
  Field.CancelInvisiblePlayer(key, fade_frame, is_force_cancel, is_zero_alpha_start)
end

function Field_InvisiblePlayer(key, fade_frame, is_max_alpha_start)
  Field.InvisiblePlayer(key, fade_frame, is_max_alpha_start)
end

function Field_CancelInvisibleFollowerAllPartyMember(key, fade_frame, is_force_cancel, is_zero_alpha_start, is_warp)
  is_warp = is_warp or false
  if is_warp then
    Field.FollowerWarp()
  end
  Field.CancelInvisibleFollowerAllPartyMember(key, fade_frame, is_force_cancel, is_zero_alpha_start)
end

function Field_InvisibleFollowerAllPartyMember(key, fade_frame, is_max_alpha_start)
  Field.InvisibleFollowerAllPartyMember(key, fade_frame, is_max_alpha_start)
end

function Field_CancelInvisibleFollowerAllGuest(key, fade_frame, is_force_cancel, is_zero_alpha_start)
  Field.CancelInvisibleFollowerAllGuest(key, fade_frame, is_force_cancel, is_zero_alpha_start)
end

function Field_InvisibleFollowerAllGuest(key, fade_frame, is_max_alpha_start)
  Field.InvisibleFollowerAllGuest(key, fade_frame, is_max_alpha_start)
end

function Field_CancelInvisibleNpc(unique_name, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  if unique_name ~= "" then
    Field.CancelInvisibleNpc(unique_name, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  else
    Field.CancelInvisibleNpc("", priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  end
end

function Field_InvisibleNpc(unique_name, priority, fade_frame, is_max_alpha_start)
  if unique_name ~= "" then
    Field.InvisibleNpc(unique_name, priority, fade_frame, is_max_alpha_start)
  else
    Field.InvisibleNpc("", priority, fade_frame, is_max_alpha_start)
  end
end

function Field_CancelInvisibleRumorNpc(unique_name, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  if unique_name ~= FOR_ALL then
    local index = Field.GetRumorNpcIndex(unique_name)
    Field.ObjectCancelInvisible(FLD_OBJ_RUMOR_NPC, index, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  else
    Field.ObjectCancelInvisible(FLD_OBJ_RUMOR_NPC, FOR_ALL, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  end
end

function Field_InvisibleRumorNpc(unique_name, priority, fade_frame, is_max_alpha_start)
  if unique_name ~= FOR_ALL then
    local index = Field.GetRumorNpcIndex(unique_name)
    Field.ObjectInvisible(FLD_OBJ_RUMOR_NPC, index, priority, fade_frame, is_max_alpha_start)
  else
    Field.ObjectInvisible(FLD_OBJ_RUMOR_NPC, FOR_ALL, priority, fade_frame, is_max_alpha_start)
  end
end

function Field_CancelInvisibleGimmick(locator, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  Field.CancelInvisibleGimmick(locator, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
end

function Field_InvisibleGimmick(locator, priority, fade_frame, is_max_alpha_start)
  Field.InvisibleGimmick(locator, priority, fade_frame, is_max_alpha_start)
end

function Field_CancelInvisibleAllSymbolEnemy(priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  Field.CancelInvisibleAllSymbolEnemy(priority, fade_frame, is_force_cancel, is_zero_alpha_start)
end

function Field_InvisibleAllSymbolEnemy(priority, fade_frame, is_max_alpha_start)
  Field.InvisibleAllSymbolEnemy(priority, fade_frame, is_max_alpha_start)
end

function Field_CancelInvisibleMob(unique_name, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
  if Debug.IsEventView() == false then
    if unique_name ~= FOR_ALL then
      local index = Field.GetMobIndex(unique_name)
      Field.ObjectCancelInvisible(FLD_OBJ_MOB, index, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
    else
      Field.ObjectCancelInvisible(FLD_OBJ_MOB, FOR_ALL, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
    end
  else
    print("===Event View===")
    if unique_name ~= FOR_ALL then
      local index = Vista.GetMobIndex_EventView(unique_name)
      Vista.CancelInvisibleMobChar_EventView(index, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
    else
      Vista.CancelInvisibleMobChar_EventView(FOR_ALL, priority, fade_frame, is_force_cancel, is_zero_alpha_start)
    end
  end
end

function Field_InvisibleMob(unique_name, priority, fade_frame, is_max_alpha_start)
  if Debug.IsEventView() == false then
    if unique_name ~= FOR_ALL then
      local index = Field.GetMobIndex(unique_name)
      Field.ObjectInvisible(FLD_OBJ_MOB, index, priority, fade_frame, is_max_alpha_start)
    else
      Field.ObjectInvisible(FLD_OBJ_MOB, FOR_ALL, priority, fade_frame, is_max_alpha_start)
    end
  else
    print("===Event View===")
    if unique_name ~= FOR_ALL then
      local index = Vista.GetMobIndex_EventView(unique_name)
      Vista.InvisibleMobChar_EventView(index, priority, fade_frame, is_max_alpha_start)
    else
      Vista.InvisibleMobChar_EventView(FOR_ALL, priority, fade_frame, is_max_alpha_start)
    end
  end
end

function Field_CancelInvisibleMapModel(key)
  Field.CancelInvisibleMapModel(key)
end

function Field_InvisibleMapModel(key)
  Field.InvisibleMapModel(key)
end

function CheckSyncPlayerModel(with_effect)
  Field.CheckSyncPlayerModel(with_effect)
  while Field.IsSyncingPlayerModel() do
    WaitFrame(1)
  end
end

function Field_InvisibleObjects(type, start_num, end_num, unique_end_num)
  local type_str = ""
  if unique_end_num == nil then
    unique_end_num = 4
  end
  if type == NPC then
    type_str = "npc_"
  end
  if type == MOB then
    type_str = "mob_"
  end
  if type == GIM then
    type_str = "gim_"
  end
  if type == RUMOR_NPC then
    type_str = "rumor_"
  end
  local num_opt = string.format("%02d", unique_end_num)
  local opt = "%" .. num_opt .. "d"
  for num = start_num, end_num do
    local unique_name = type_str .. string.format(opt, num)
    local obj = Obj:new(type, unique_name)
    obj:Invisible()
  end
end

function Field_CancelInvisibleObjects(type, start_num, end_num, unique_end_num)
  local type_str = ""
  if unique_end_num == nil then
    unique_end_num = 4
  end
  if type == NPC then
    type_str = "npc_"
  end
  if type == MOB then
    type_str = "mob_"
  end
  if type == GIM then
    type_str = "gim_"
  end
  if type == RUMOR_NPC then
    type_str = "rumor_"
  end
  local num_opt = string.format("%02d", unique_end_num)
  local opt = "%" .. num_opt .. "d"
  for num = start_num, end_num do
    local unique_name = type_str .. string.format(opt, num)
    Obj:new(type, unique_name):CancelInvisible()
  end
end

Enemys = {}

function Enemys.AllRespawn(is_effect_skip, is_force, pos_x, pos_y, pos_z)
  local enemy_num = Field.GetObjectNum(FLD_OBJ_SYMBOL_ENEMY)
  for num = 1, enemy_num do
    if pos_x == nil and pos_y == nil and pos_z == nil then
      if Field.SymbolForceRespawn(num, is_effect_skip, is_force) then
        print("SymbolForceRespawn Successed : index", num)
      else
        print("SymbolForceRespawn Failed : index", num)
      end
    else
      if pos_x == nil then
        pos_x = 0
      end
      if pos_y == nil then
        pos_y = 0
      end
      if pos_z == nil then
        pos_z = 0
      end
      if Field.SymbolForceRespawnAndWarp(num, pos_x, pos_y, pos_z, is_effect_skip, is_force) then
        print("SymbolForceRespawnAndWarp Successed : index", num)
      else
        print("SymbolForceRespawnAndWarp Failed : index", num)
      end
    end
  end
end

function Enemys.AllDespawn(is_effect_skip, respawn_time, respawn_distance)
  local enemy_num = Field.GetObjectNum(FLD_OBJ_SYMBOL_ENEMY)
  for num = 1, enemy_num do
    if respawn_time == nil then
      respawn_time = -1
    end
    if respawn_distance == nil then
      respawn_distance = -1
    end
    Field.SymbolForceLeave(num, is_effect_skip, respawn_time, respawn_distance)
  end
end

function Enemys.PatternRespawn(pattern_num, is_effect_skip, is_force, pos_x, pos_y, pos_z)
  local enemy_num = Field.GetObjectNum(FLD_OBJ_SYMBOL_ENEMY)
  for num = 1, enemy_num do
    if Field.ObjectGetSpawnPattern(FLD_OBJ_SYMBOL_ENEMY, num) == pattern_num then
      if pos_x == nil and pos_y == nil and pos_z == nil then
        if Field.SymbolForceRespawn(num, is_effect_skip, is_force) then
          print("SymbolForceRespawn Successed : index", num)
        else
          print("SymbolForceRespawn Failed : index", num)
        end
      else
        if pos_x == nil then
          pos_x = 0
        end
        if pos_y == nil then
          pos_y = 0
        end
        if pos_z == nil then
          pos_z = 0
        end
        if Field.SymbolForceRespawnAndWarp(num, pos_x, pos_y, pos_z, is_effect_skip, is_force) then
          print("SymbolForceRespawnAndWarp Successed : index", num)
        else
          print("SymbolForceRespawnAndWarp Failed : index", num)
        end
      end
    end
  end
end

function Enemys.PatternDespawn(pattern_num, is_effect_skip, respawn_time, respawn_distance)
  local enemy_num = Field.GetObjectNum(FLD_OBJ_SYMBOL_ENEMY)
  for num = 1, enemy_num do
    if Field.ObjectGetSpawnPattern(FLD_OBJ_SYMBOL_ENEMY, num) == pattern_num then
      if respawn_time == nil then
        respawn_time = -1
      end
      if respawn_distance == nil then
        respawn_distance = -1
      end
      Field.SymbolForceLeave(num, is_effect_skip, respawn_time, respawn_distance)
    end
  end
end

function Enemys.Respawn(unipue_name, is_effect_skip, is_force, pos_x, pos_y, pos_z)
  local index = GetIndex(FLD_OBJ_SYMBOL_ENEMY, unipue_name)
  if pos_x == nil and pos_y == nil and pos_z == nil then
    if Field.SymbolForceRespawn(index, is_effect_skip, is_force) then
      print("SymbolForceRespawn Successed : index", index)
    else
      print("SymbolForceRespawn Failed : index", index)
    end
  else
    if pos_x == nil then
      pos_x = 0
    end
    if pos_y == nil then
      pos_y = 0
    end
    if pos_z == nil then
      pos_z = 0
    end
    if Field.SymbolForceRespawnAndWarp(index, pos_x, pos_y, pos_z, is_effect_skip, is_force) then
      print("SymbolForceRespawnAndWarp Successed : index", index)
    else
      print("SymbolForceRespawnAndWarp Failed : index", index)
    end
  end
end

function Enemys.Despawn(unique_name, is_effect_skip, respawn_time, respawn_distance)
  local index = GetIndex(FLD_OBJ_SYMBOL_ENEMY, unique_name)
  if respawn_time == nil then
    respawn_time = -1
  end
  if respawn_distance == nil then
    respawn_distance = -1
  end
  Field.SymbolForceLeave(index, is_effect_skip, respawn_time, respawn_distance)
end

function FieldObjectSync(object_type, with_effect)
  Field.ObjectCheckSync(object_type, with_effect)
  while Field.ObjectIsSyncing(object_type) do
    WaitFrame(1)
  end
end

function FollowerSync()
  Field.CheckSyncFollower(true)
  while Field.IsSyncingFollower() do
    WaitFrame(1)
  end
end

function PlayerLookAtObject(gim_type, gim_name)
  if Field.IsPlayerAnywhereDigimonRiding() then
    Field.CancelPlayerAnywhereDigimonRide(false)
    WaitFrame(15)
  end
  Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, gim_type, GetIndex(gim_type, gim_name), 10, 10)
end

function PlayerLookAtObject_360(gim_type, gim_name)
  if Field.IsPlayerAnywhereDigimonRiding() then
    Field.CancelPlayerAnywhereDigimonRide(false)
    WaitFrame(15)
  end
  Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, gim_type, GetIndex(gim_type, gim_name), 10, 12)
end

function PlayerLookAtLccatorObject(gim_name)
  if Field.IsPlayerAnywhereDigimonRiding() then
    Field.CancelPlayerAnywhereDigimonRide(false)
    WaitFrame(15)
  end
  Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, gim_name), 10, 10)
end

function PlayerLookAtGimmickObject(gim_name)
  if Field.IsPlayerAnywhereDigimonRiding() then
    Field.CancelPlayerAnywhereDigimonRide(false)
    WaitFrame(15)
  end
  Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, gim_name), 10, 10)
end

function PlayerLookAtSymbolEnemy(enemy_name)
  if Field.IsPlayerAnywhereDigimonRiding() then
    Field.CancelPlayerAnywhereDigimonRide(false)
    WaitFrame(15)
  end
  Field.ObjectLookAtTheObject(FLD_OBJ_PLAYER, 1, FLD_OBJ_SYMBOL_ENEMY, GetIndex(FLD_OBJ_SYMBOL_ENEMY, enemy_name), 10, 10)
end

function PlayerObjectResetAim()
  Field.ObjectResetAim(FLD_OBJ_PLAYER, 1, 10)
end

function SetProhibitPlayerOnlyOperate(is_prohibit)
  if is_prohibit == true then
    Field.DisableMenu()
    Field.DisableAnalyzeAndFieldAttack()
    Field.DisableSystemDigimonChat()
    Field.SetProhibitAnywhereDigimonRide(true)
    Field.SetProhibitDigimonRide(true)
    Common.ProhibitSave()
  else
    Field.CancelDisableMenu()
    Field.CancelDisableAnalyzeAndFieldAttack()
    Field.CancelDisableSystemDigimonChat()
    Field.SetProhibitAnywhereDigimonRide(false)
    Field.SetProhibitDigimonRide(false)
    Common.CancelProhibitSave()
  end
end

function MapChange(prefix, map_num, locator, is_fade, fade_type, wait_frame)
  if is_fade == true then
    FadeOutWithWait(fade_type, wait_frame)
  end
  Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
  Common.RequestMapChange(prefix, map_num, locator)
end

function DoorMapChange(prefix, map_num, locator)
  Flg.Clear("FLAG_IS_DISPLAYED_MAP_NAME_UI")
  if TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE == nil then
    MapChange(prefix, map_num, locator, false, FADE_BLACK, FADE_TIME)
  elseif TIME_AXIS == nil and TIME_AXIS_SET == "" and TIME_ZONE ~= nil then
    MapChangeWithTimePasses(prefix, map_num, locator, TIME_ZONE)
  else
    MapChangeWithTimeTravel(prefix, map_num, locator, TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
  end
end

function SetPlayerLocator(locator)
  Field.SetPlayerLocator(locator)
  Field.FollowerWarp()
end

function MovePlayerFrame(degree_y, speed, frame)
  Field.MovePlayerFrame(degree_y, speed, frame)
end

function MovePlayerToLocatorFrame(locator, frame)
  Field.MovePlayerToLocatorFrame(locator, frame)
  WaitFrame(frame)
end

function SetPlayerRotationByLocator(locator, blend_frame)
  local blend_time = Util.SecondFromFrame(blend_frame)
  Field.SetPlayerRotationByLocator(locator, blend_time)
  WaitFrame(blend_frame)
end

function SetPlayerRotationToLocator(locator, blend_frame)
  local blend_time = Util.SecondFromFrame(blend_frame)
  Field.SetPlayerRotationToLocator(locator, blend_time)
  WaitFrame(blend_frame)
end

function ObjectSetRotationY(object_type, index, y_degree, blend_frame)
  Field.ObjectSetRotationY(object_type, index, y_degree, blend_frame)
end

function ObjectResetRotation(object_type, index, blend_frame, original_standing_pos)
  Field.ObjectResetRotation(object_type, index, blend_frame, original_standing_pos)
end

function PlayerStopper(file_name, message_id, pos_x, pos_z)
  Talk.Load(file_name)
  Talk.SetMode(1)
  Message(message_id)
  MessageClose()
  TalkExit()
  Field.MovePlayerToRelativePosFrame(pos_x, pos_z, 30)
  WaitFrame(6)
end

function MovePlayerToRelativePosFrame(pos_x, pos_z, frame)
  Field.MovePlayerToRelativePosFrame(pos_x, pos_z, frame)
end

function GoToTheater(...)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  Message("g_theater_0010_0010")
  MessageClose()
  MessageTalkSel(2, "g_theater_0020_0010")
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    local start_loc = {
      ...
    }
    if 1 < #start_loc then
      print("some locator. use start_50")
    elseif #start_loc == 1 then
      print("set start_", start_loc[1])
    else
      print("set start_50")
    end
    Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
    local org_prefix = Field.GetMapPrefix()
    local org_number = Field.GetMapNumber()
    local org_locator = "start_" .. string.format("%02d", org_locator_num)
    local org_time_zone = Common.GetTimeZone()
    Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
    MessageClose()
    PlaySE(200006, 100)
    FadeOutWithWait(1, 30)
    WaitFrame(30)
    Field_Talk_End_Not_LetterBox()
    MapChange("t", 3001, "start_00", false, -1, -1)
  elseif result == RESULT_TALK01 then
    Field_Talk_End_Not_LetterBox()
  end
end

function GoToTheaterWithEvt(...)
  FadeOutWithWait(0, 5)
  Field.CancelPlayerAnywhereDigimonRide(true)
  WaitFrame(1)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  local start_loc = {
    ...
  }
  if 2 <= #start_loc then
    SetPlayerLocator("start_" .. start_loc[1])
    SetPlayerRotationToLocator(start_loc[2], 0)
    SetControlScriptExternalVariable("theater_place", "start_" .. start_loc[1] .. "#" .. start_loc[2])
  else
    SetPlayerLocator("start_50")
    SetPlayerRotationToLocator("theater_0001", 0)
    SetControlScriptExternalVariable("theater_place", "start_50#theater_0001")
  end
  SetControlScriptExternalVariable("theater_state", "play")
  SetControlScriptExternalVariable("theater_door_state", "intro")
  Fade_In(0, 5)
  if Flg.Check("FLAG_MAIN_03_030") then
    Message("g_theater_0010_0010")
    MessageClose()
    MessageTalkSel(2, "g_theater_0020_0010")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      local org_locator_num = 50
      local start_loc = {
        ...
      }
      if #start_loc == 2 then
        print("set start_", start_loc[1])
        org_locator_num = start_loc[1]
        for i = 2, 4 do
          Motion.Object:Load(FLD_OBJ_LOCATOR, start_loc[2], "e" .. string.format("%03d", i))
        end
      else
        print("set start_50")
        org_locator_num = 50
        for i = 2, 4 do
          Motion.Object:Load(FLD_OBJ_LOCATOR, "theater_0001", "e" .. string.format("%03d", i))
        end
      end
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      if Flg.Check("FLAG_MAIN_03_620") then
        math.randomseed(os.time())
        local random = math.random(1, 100)
        if random <= 50 then
          Flg.Set("FLAG_IS_MIREI_ADULT")
        elseif 51 < random then
          Flg.Clear("FLAG_IS_MIREI_ADULT")
        end
        if Qst.Sub:Check(170, 15, 20) then
          Flg.Clear("FLAG_IS_MIREI_ADULT")
        end
        if Qst.Sub:Check(216, 1, 255) then
          Flg.Clear("FLAG_IS_MIREI_ADULT")
        end
        if Qst.Sub:Check(178, 1, 255) then
          Flg.Clear("FLAG_IS_MIREI_ADULT")
        end
      end
      local org_prefix = Field.GetMapPrefix()
      local org_number = Field.GetMapNumber()
      local org_locator = "start_" .. string.format("%02d", org_locator_num)
      local org_time_zone = Common.GetTimeZone()
      Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
      MessageClose()
      Field.ObjectCancelInvisible(FLD_OBJ_PLAYER, Field.GetPlayerIndex(), 0, 0, true, true)
      PlaySE(401054, 100)
      SetControlScriptExternalVariable("theater_state", "play")
      SetControlScriptExternalVariable("theater_door_state", "create")
      WaitFrame(110)
      SetControlScriptExternalVariable("theater_door_state", "open")
      WaitFrame(30)
      if 2 <= #start_loc then
        Field.MovePlayerToLocatorFrame(start_loc[2], 60)
      else
        Field.MovePlayerToLocatorFrame("theater_0001", 60)
      end
      WaitFrame(20)
      FadeOutWithWait(1, 20)
      WaitFrame(20)
      Field_Talk_End_Not_LetterBox()
      MapChange("t", 3001, "start_00", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      FadeOutWithWait(0, 5)
      Field.ResetEnvironmentSettings()
      Field.ObjectCancelInvisible(FLD_OBJ_PLAYER, Field.GetPlayerIndex(), 0, 0, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 30, false, false)
      Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 30, false, false)
      SetControlScriptExternalVariable("theater_door_state", "cancel")
      Field_Talk_End_Not_LetterBox()
      Fade_In(0, 5)
      Digimon.RestoreAllParty()
      Digitter.Send(9999004, false, false)
    end
  else
    Message("g_theater_0030_0010")
    MessageClose()
    MessageTalkSel(2, "g_theater_0040_0010")
    local result = Talk.GetResultSelectedNum()
    if result == RESULT_TALK00 then
      local start_loc = {
        ...
      }
      if #start_loc == 2 then
        print("set start_", start_loc[1])
        org_locator_num = start_loc[1]
        for i = 2, 4 do
          Motion.Object:Load(FLD_OBJ_LOCATOR, start_loc[2], "e" .. string.format("%03d", i))
        end
      else
        print("set start_50")
        org_locator_num = 50
        for i = 2, 4 do
          Motion.Object:Load(FLD_OBJ_LOCATOR, "theater_0001", "e" .. string.format("%03d", i))
        end
      end
      local org_prefix = Field.GetMapPrefix()
      local org_number = Field.GetMapNumber()
      local org_locator = "start_" .. string.format("%02d", org_locator_num)
      local org_time_zone = Common.GetTimeZone()
      Common.SetHazamaTheaterExitData(Common.GetCurrentTimeTravelRecordType(), org_prefix, org_number, org_locator, org_time_zone)
      Flg.Set("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER")
      MessageClose()
      Field.ObjectCancelInvisible(FLD_OBJ_PLAYER, Field.GetPlayerIndex(), 0, 0, true, true)
      PlaySE(401054, 100)
      SetControlScriptExternalVariable("theater_state", "play")
      SetControlScriptExternalVariable("theater_door_state", "create")
      WaitFrame(110)
      SetControlScriptExternalVariable("theater_door_state", "open")
      WaitFrame(30)
      if 2 <= #start_loc then
        Field.MovePlayerToLocatorFrame(start_loc[2], 60)
      else
        Field.MovePlayerToLocatorFrame("theater_0001", 60)
      end
      WaitFrame(20)
      FadeOutWithWait(1, 20)
      WaitFrame(20)
      Field_Talk_End_Not_LetterBox()
      MapChange("t", 3001, "start_00", false, 0, 5)
    elseif result == RESULT_TALK01 then
      FadeOutWithWait(0, 5)
      Field.ResetEnvironmentSettings()
      Field.ObjectCancelInvisible(FLD_OBJ_PLAYER, Field.GetPlayerIndex(), 0, 0, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 30, false, false)
      Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 30, false, false)
      SetControlScriptExternalVariable("theater_door_state", "cancel")
      Field_Talk_End_Not_LetterBox()
      Fade_In(0, 5)
    end
  end
end

function InitializeTheaterDoorEvt(...)
  print("InitializeTheaterDoorEvt")
  local start_loc = {
    ...
  }
  if #start_loc == 2 then
    SetControlScriptExternalVariable("theater_place", "start_" .. start_loc[1] .. "#" .. start_loc[2])
    SetControlScriptExternalVariable("theater_state", "play")
    SetControlScriptExternalVariable("theater_door_state", "loading")
    for i = 4, 5 do
      Motion.Object:Load(FLD_OBJ_LOCATOR, start_loc[2], "e" .. string.format("%03d", i))
    end
    SetControlScriptExternalVariable("theater_door_state", "start")
  else
    SetControlScriptExternalVariable("theater_place", "start_50#theater_0001")
    SetControlScriptExternalVariable("theater_state", "play")
    SetControlScriptExternalVariable("theater_door_state", "loading")
    for i = 4, 5 do
      Motion.Object:Load(FLD_OBJ_LOCATOR, "theater_0001", "e" .. string.format("%03d", i))
    end
    SetControlScriptExternalVariable("theater_door_state", "start")
  end
end

function CreateAddress()
  local map_num, map_prefix = Field.GetMapNumber(), Field.GetMapPrefix()
  local map_id = 0
  if map_prefix == "t" then
    map_id = map_num
  elseif map_prefix == "d" then
    map_id = 10000 + map_num
  elseif map_prefix == "h" then
    map_id = 20000 + map_num
  end
  print("Created Address = ", map_id)
  Work.Set(Field_Created_Address, map_id)
end

function GetAddress()
  local address = Work.Get(Field_Created_Address)
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

function GetLastPlayerSetLocator()
  local loc_name = Field.GetLastPlayerSetLocator()
  return loc_name
end

function OpenWorldMapDirection()
  OpenWorldMapAutoTransition(RW)
end

MoveLock = {
  Area = {},
  Place = {}
}

function ColOff(col_name)
  Field.ColOff(col_name)
end

function ColOn(col_name)
  Field.ColOn(col_name)
end

function ColOffWithTable(col_table)
  for i = 1, #col_table do
    ColOff(col_table[i])
  end
end

function ColOnWithTable(col_table)
  for i = 1, #col_table do
    ColOn(col_table[i])
  end
end

Motion = {
  Object = {},
  NPC = {},
  Gimmick = {},
  Player = {},
  Follower = {}
}

function Motion.Object:new(object_type, unique_name, motion_name, is_blend_motion)
  local obj = {}
  obj.type = object_type
  obj.index = 0
  if unique_name == "" then
    obj.index = Field.GetPlayerIndex()
  else
    obj.index = GetIndex(object_type, unique_name)
  end
  obj.mot_name = motion_name
  obj.is_blend_motion = is_blend_motion or false
  if obj.is_blend_motion then
    Field.ObjectLoadMotionBlend(obj.type, obj.index, obj.mot_name)
  else
    Field.ObjectLoadMotion(obj.type, obj.index, obj.mot_name)
  end
  obj.end_frame = Field.ObjectGetMotionEndFrame(obj.type, obj.index, obj.mot_name)
  
  function obj:PlayMotionBlend(blend_frame, is_loop)
    if self.is_blend_motion then
      Field.ObjectPlayMotionBlend(self.type, self.index, self.mot_name, blend_frame, is_loop)
    else
      error("\233\128\154\229\184\184 \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 PlayMotionBlend() \227\129\175 Blend\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    end
  end
  
  function obj:EndMotionBlend()
    if self.is_blend_motion then
      Field.ObjectEndMotionBlend(self.type, self.index)
    else
      error("\233\128\154\229\184\184 \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 EndMotionBlend() \227\129\175 Blend\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    end
  end
  
  function obj:Play(blend_frame, loop)
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 Play() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      Field.ObjectPlayMotion(self.type, self.index, self.mot_name, blend_frame, loop)
    end
  end
  
  function obj:PlayWithStartMoveMotion(blend_frame, move_blend_frame)
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 PlayWithStartMoveMotion() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(self.type, self.index, self.mot_name, blend_frame, move_blend_frame)
    end
  end
  
  function obj:Play2Wait(blend_frame, loop)
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 Play2Wait() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      Field.ObjectPlayMotion(self.type, self.index, self.mot_name, blend_frame, loop)
      local end_frame = Field.ObjectGetMotionEndFrame(self.type, self.index, self.mot_name)
      WaitFrame(end_frame)
    end
  end
  
  function obj:Play2Move(blend_frame, move_blend_frame)
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 Play2Move() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      Field.ObjectPlayMotionWithStartMoveMotion(self.type, self.index, self.mot_name, blend_frame, move_blend_frame)
      local end_frame = Field.ObjectGetMotionEndFrame(self.type, self.index, self.mot_name)
      WaitFrame(end_frame)
    end
  end
  
  function obj:PlaySetting(blend_frame, eval_frame, start_frame, end_frame, speed, is_loop)
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 PlaySetting() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      Field.ObjectPlayMotionAndSetting(self.type, self.index, self.mot_name, blend_frame, eval_frame, start_frame, end_frame, speed, is_loop)
    end
  end
  
  function obj:Reset(blend_frame)
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 Reset() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      blend_frame = blend_frame or 0
      Field.ObjectResetMotion(self.type, self.index, blend_frame)
    end
  end
  
  function obj:IsPlayingMotion()
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 IsPlayingMotion() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      return Field.ObjectIsPlayingMotion(self.type, self.index, self.mot_name)
    end
  end
  
  function obj:GetEndFrame()
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 GetEndFrame() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      return Field.ObjectGetMotionEndFrame(self.type, self.index, self.mot_name)
    end
  end
  
  function obj:Wait()
    if self.is_blend_motion then
      error("Blend \227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\140\230\140\135\229\174\154\227\129\149\227\130\140\227\129\166\227\129\132\227\129\190\227\129\153\227\128\130 Wait() \227\129\175\233\128\154\229\184\184\227\131\162\227\131\188\227\130\183\227\131\167\227\131\179\227\129\167\228\189\191\227\129\132\227\129\190\227\129\153", 2)
    else
      while Field.ObjectIsPlayingMotion(self.type, self.index, self.mot_name) do
        WaitFrame(1)
      end
    end
  end
  
  function obj:LoadAttachment(attachment_id)
    motion_name = motion_name or ""
    Field.ObjectLoadAttachment(self.type, self.index, attachment_id)
    if self.mot_name ~= "" then
      Field.ObjectLoadAttachmentMotion(self.type, self.index, attachment_id, self.mot_name)
    end
  end
  
  function obj:HideAttachment(attachment_id)
    Field.ObjectHideAttachment(self.type, self.index, attachment_id)
  end
  
  function obj:ShowAttachment(attachment_id)
    Field.ObjectShowAttachment(self.type, self.index, attachment_id)
  end
  
  function obj:PlayAttachmentMotion(attachment_id, blend_frame, is_loop)
    Field.ObjectPlayAttachmentMotion(self.type, self.index, attachment_id, self.mot_name, blend_frame, is_loop)
  end
  
  function obj:PlayAttachment(attachment_id, blend_frame, is_loop)
    self:ShowAttachment(attachment_id)
    self:PlayAttachmentMotion(attachment_id, blend_frame, is_loop)
  end
  
  return obj
end

function Motion.Object:Load(object_type, object_index, motion_name)
  local index
  if type(object_index) == "string" then
    index = GetIndex(object_type, object_index)
  else
    index = object_index
  end
  if index ~= nil then
    Field.ObjectLoadMotion(object_type, index, motion_name)
  else
    print("[Motion.Object:Load]:Err Object Index nil!")
  end
end

function Motion.Object:Play(object_type, object_index, blend_frame, motion_name, loop)
  local index
  if type(object_index) == "string" then
    index = GetIndex(object_type, object_index)
  else
    index = object_index
  end
  Field.ObjectPlayMotion(object_type, index, motion_name, blend_frame, loop)
end

function Motion.Object:Reset(object_type, object_index, blend_frame)
  local index
  if type(object_index) == "string" then
    index = GetIndex(object_type, object_index)
  else
    index = object_index
  end
  Field.ObjectResetMotion(object_type, index, blend_frame)
end

function Motion.Object:PlayAfterBn01(object_type, object_index, blend_frame, motion_name)
  local index
  if type(object_index) == "string" then
    index = GetIndex(object_type, object_index)
  else
    index = object_index
  end
  Field.ObjectPlayMotion(object_type, index, motion_name, blend_frame, false)
  local end_frame = Field.ObjectGetMotionEndFrame(object_type, index, motion_name)
  WaitFrame(end_frame)
  Field.ObjectPlayMotion(object_type, index, "bn01", blend_frame, true)
end

function Motion.Object:PlayFinishedAnim(object_type, object_index, blend_frame, motion_name)
  local index
  if type(object_index) == "string" then
    index = GetIndex(object_type, object_index)
  else
    index = object_index
  end
  Field.ObjectPlayMotion(object_type, index, motion_name, blend_frame, false)
  local end_frame = Field.ObjectGetMotionEndFrame(object_type, index, motion_name)
  Field.ObjectPlayMotionAndSetting(object_type, index, motion_name, blend_frame, end_frame, end_frame, end_frame, 0, false)
end

function Motion.Object:LoadMove(object_type, object_index, move_motion_set)
  local index
  if type(object_index) == "string" then
    index = GetIndex(object_type, object_index)
  else
    index = object_index
  end
  Field.ObjectLoadMoveMotion(object_type, index, move_motion_set)
end

function Motion.Player:Play(anim_name, blend_frame, is_loop, limit_target)
  local index = Field.GetPlayerIndex()
  if limit_target then
    Field.ObjectLoadMotion(FLD_OBJ_PLAYER, index, anim_name, limit_target)
  else
    Field.ObjectLoadMotion(FLD_OBJ_PLAYER, index, anim_name)
  end
  Field.ObjectPlayMotion(FLD_OBJ_PLAYER, index, anim_name, Util.SecondFromFrame(blend_frame), is_loop)
end

function Motion.Player:PlayWithMoveMotion(anim_name, blend_frame1, blend_frame2)
  local index = Field.GetPlayerIndex()
  Field.ObjectLoadMotion(FLD_OBJ_PLAYER, index, anim_name)
  Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, index, anim_name, blend_frame1, blend_frame2)
end

function Motion.Player:Wait()
  while Field.IsPlayerPlayingSomeAnimation() do
    WaitFrame(1)
  end
end

function Motion.Player:ChangeMoveAnim(animation_set_name, max_speed, is_stand_by_field)
  if is_stand_by_field == nil then
    is_stand_by_field = false
  end
  if is_stand_by_field then
    Field.PlayerLoadMoveAnimation(animation_set_name)
  end
  Field.PlayerLoadMoveAnimation(animation_set_name)
  while Field.IsLoadingPlayerMoveAnimation(animation_set_name) do
    WaitFrame(1)
  end
  Field.PlayerChangeMoveAnimation(animation_set_name)
  Field.PlayerFixedMaxSpeed(max_speed)
end

function Motion.Player:ChangeMoveAnimWithBlend(animation_set_name, blend_frame, max_speed)
  Field.PlayerLoadMoveAnimation(animation_set_name)
  while Field.IsLoadingPlayerMoveAnimation(animation_set_name) do
    WaitFrame(1)
  end
  Field.PlayerChangeMoveAnimationWithBlend(animation_set_name, blend_frame)
  Field.PlayerFixedMaxSpeed(max_speed)
end

function Motion.Player:ResetMoveAnim()
  Field.PlayerResetMoveAnimation()
  Field.CancelPlayerFixedMaxSpeed()
end

function Motion.Player:ResetMoveAnimWithBlend(blend_frame)
  Field.PlayerResetMoveAnimationWithBlend(blend_frame)
  Field.CancelPlayerFixedMaxSpeed()
end

function Motion.NPC:Play(unique_name, animation_name, blend_frame, is_loop)
  Motion.NPC:Load(unique_name, animation_name)
  Field.NpcPlayAnime(unique_name, animation_name, Util.SecondFromFrame(blend_frame), is_loop)
end

function Motion.NPC:Load(unique_name, animation_name)
  if animation_name ~= "" then
    Field.NpcLoadAnime(unique_name, animation_name)
    while Field.IsLoadingNpcAnime(unique_name, animation_name) do
      WaitFrame(1)
    end
  end
end

function Motion.NPC:PlayAnimWithStartMoveMotion(unique_name, anim_name, blend_frame1, blend_frame2)
  local index = Field.GetPlayerIndex(unique_name)
  Field.ObjectLoadMotion(FLD_OBJ_PLAYER, index, anim_name)
  while Field.ObjectIsPlayingMotion(FLD_OBJ_PLAYER, index, anim_name) do
    WaitFrame(1)
  end
  Field.ObjectPlayMotionWithStartMoveMotion(FLD_OBJ_PLAYER, index, anim_name, blend_frame1, blend_frame2)
end

function Motion.Gimmick:Play(locator, animation_name, is_loop, is_stand_by_field)
  if is_stand_by_field == nil then
    is_stand_by_field = false
  end
  if is_stand_by_field then
    Motion.Gimmick:LoadNoWait(locator, animation_name)
  else
    Motion.Gimmick:Load(locator, animation_name)
  end
  Field.GimmickPlayAnime(locator, animation_name, is_loop)
end

function Motion.Gimmick:Load(locator, animation_name)
  if animation_name ~= "" then
    Field.GimmickLoadAnime(locator, animation_name)
    while Field.IsLoadingGimmickAnime(locator, animation_name) do
      WaitFrame(1)
    end
  end
end

function Motion.Gimmick:LoadNoWait(locator, animation_name)
  if animation_name ~= nil or animation_name ~= "" then
    Field.GimmickLoadAnime(locator, animation_name)
  end
end

function Motion.Gimmick:PlayFinishedAnim(locator, animation_name, is_stand_by_field)
  if is_stand_by_field == nil then
    is_stand_by_field = false
  end
  if is_stand_by_field then
    Motion.Gimmick:LoadNoWait(locator, animation_name)
  else
    Motion.Gimmick:Load(locator, animation_name)
  end
  Field.GimmickPlayAnime(locator, animation_name, false)
  local end_time = Field.GetGimmickAnimeDefaultEndTime(locator, animation_name)
  Field.GimmickAnimeResetTime(locator, animation_name, end_time, end_time, end_time, false)
end

function Motion.Gimmick:ResetFrame(locator, anim_name, eval_frame, start_frame, end_frame, is_loop)
  Field.GimmickAnimeResetFrame(locator, anim_name, eval_frame, start_frame, end_frame, is_loop)
end

function Motion.Gimmick:WaitFrame(locator, anim_name, adjust_frame)
  local gim_anim_end_time = Util.FrameFromSecond(Field.GetGimmickAnimeEndTime(locator, anim_name))
  local frame = gim_anim_end_time + adjust_frame
  WaitFrame(frame)
end

function Motion.Follower:Load(follower_id, follower_type, anim_name)
  local index = GetIndex(FLD_OBJ_FOLLOWER, follower_type, follower_id)
  Field.ObjectLoadMotion(FLD_OBJ_FOLLOWER, index, anim_name)
end

function Motion.Follower:Play(follower_id, follower_type, anim_name, blend_frame, is_loop)
  local index = GetIndex(FLD_OBJ_FOLLOWER, follower_type, follower_id)
  Field.ObjectPlayMotion(FLD_OBJ_FOLLOWER, index, anim_name, blend_frame, is_loop)
end

function PlayerCheckGimmick(locator, rotate_frame, anim_name, blend_frame, is_loop)
  if not Field.IsPlayerAnywhereDigimonRiding() then
    SetPlayerRotationToLocator(locator, rotate_frame)
    Motion.Player:Play(anim_name, blend_frame, is_loop)
  end
end

function GetGimmickAnimeFrame(locator, anim_name)
  local eval_frame = Util.FrameFromSecond(Field.GetGimmickAnimeEvalTime(locator, anim_name))
  return eval_frame
end

function OpenDoor(a_locator, door_anim_name, is_cam_move, base_gim, locator_type)
  locator_type = locator_type or FLD_OBJ_LOCATOR
  Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
  local player = Obj:new(PLAYER, "")
  local gim
  if is_cam_move == nil then
    is_cam_move = false
  end
  if base_gim == nil or not is_cam_move then
    gim = Obj:new(locator_type, a_locator)
  else
    gim = Obj:new(FLD_OBJ_LOCATOR, base_gim)
  end
  PlayerObjectResetAim()
  local cam_rot = gim.rot_y + 180
  if 360 < cam_rot then
    cam_rot = cam_rot - 360
  end
  if is_cam_move then
    local gim_vec = Field.GetUnitVector2D(gim.rot_y)
    local new_player_pos_x = gim.pos.x + gim_vec.x * 0.5
    local new_player_pos_z = gim.pos.z + gim_vec.z * 0.5
  end
  if base_gim == nil then
  else
  end
  Motion.Player:Play("fg07_m03", 0, false)
  FadeOutWithWait(0, 15)
  PlaySE(200001, 100)
  WaitFrame(15)
  if door_anim_name ~= "" or door_anim_name ~= nil then
    Motion.Gimmick:Play(a_locator, door_anim_name, false)
  end
end

function OpenDoor_NoFade(a_locator, door_anim_name, is_cam_move, base_gim, locator_type)
  locator_type = locator_type or FLD_OBJ_LOCATOR
  Flg.Set("FLAG_IS_MAPCHANGE_USING_DOOR")
  local player = Obj:new(PLAYER, "")
  local gim
  if is_cam_move == nil then
    is_cam_move = false
  end
  if base_gim == nil or not is_cam_move then
    gim = Obj:new(locator_type, a_locator)
  else
    gim = Obj:new(FLD_OBJ_LOCATOR, base_gim)
  end
  PlayerObjectResetAim()
  local cam_rot = gim.rot_y + 180
  if 360 < cam_rot then
    cam_rot = cam_rot - 360
  end
  if is_cam_move then
    local gim_vec = Field.GetUnitVector2D(gim.rot_y)
    local new_player_pos_x = gim.pos.x + gim_vec.x * 0.5
    local new_player_pos_z = gim.pos.z + gim_vec.z * 0.5
  end
  if base_gim == nil then
  else
  end
  Motion.Player:Play("fg07_m03", 0, false)
  PlaySE(200001, 100)
  if door_anim_name ~= "" or door_anim_name ~= nil then
    Motion.Gimmick:Play(a_locator, door_anim_name, false)
  end
end

function ObjectTurnToPlayer(obj_type, unique_name)
  local obj = Obj:new(obj_type, unique_name)
  local player = Obj:new(PLAYER, "")
  local obj_wait = Motion.Object:new(obj_type, unique_name, "fn01_01")
  local obj_turn_left1 = Motion.Object:new(obj_type, unique_name, "ft01_02")
  local obj_turn_right1 = Motion.Object:new(obj_type, unique_name, "ft01_01")
  local obj_turn_left2 = Motion.Object:new(obj_type, unique_name, "ft02_02")
  local obj_turn_right2 = Motion.Object:new(obj_type, unique_name, "ft02_01")
  local obj_to_pc_rot = Field.GetAngleToTarget2D(obj.pos.x, obj.pos.z, player.pos.x, player.pos.z)
  local pos_rot = obj_to_pc_rot - obj.rot_y
  if pos_rot < 0 then
    pos_rot = pos_rot + 360
  end
  obj:SetRotationY(obj_to_pc_rot, 30)
  if 30 < pos_rot and pos_rot < 90 then
    obj_turn_right1:PlaySetting(10, 0, 0, 15, 1, false)
    local f = math.floor(obj_turn_right1:GetEndFrame())
    WaitFrame(f)
  end
  if 90 <= pos_rot and pos_rot <= 180 then
    obj_turn_right2:PlaySetting(10, 0, 0, 20, 1, false)
    local f = math.floor(obj_turn_right2:GetEndFrame())
    WaitFrame(f)
  end
  if 180 <= pos_rot and pos_rot <= 270 then
    obj_turn_left2:PlaySetting(10, 0, 0, 20, 1, false)
    local f = math.floor(obj_turn_left2:GetEndFrame())
    WaitFrame(f)
  end
  if 270 < pos_rot then
    obj_turn_left1:PlaySetting(10, 0, 0, 15, 1, false)
    local f = math.floor(obj_turn_left1:GetEndFrame())
    WaitFrame(f)
  end
  obj_wait:Play(15, true)
end

function ObjectTurnToObject(obj_type_1, unique_name_1, obj_type_2, unique_name_2, is_wait)
  if is_wait == nil then
    is_wait = true
  end
  local obj_1 = Obj:new(obj_type_1, unique_name_1)
  local obj_2 = Obj:new(obj_type_2, unique_name_2)
  local obj_wait = Motion.Object:new(obj_type_1, unique_name_1, "fn01_01")
  local obj_turn_left1 = Motion.Object:new(obj_type_1, unique_name_1, "ft01_02")
  local obj_turn_right1 = Motion.Object:new(obj_type_1, unique_name_1, "ft01_01")
  local obj_turn_left2 = Motion.Object:new(obj_type_1, unique_name_1, "ft02_02")
  local obj_turn_right2 = Motion.Object:new(obj_type_1, unique_name_1, "ft02_01")
  local obj1_to_obj2_rot = Field.GetAngleToTarget2D(obj_1.pos.x, obj_1.pos.z, obj_2.pos.x, obj_2.pos.z)
  local pos_rot = obj1_to_obj2_rot - obj_1.rot_y
  if pos_rot < 0 then
    pos_rot = pos_rot + 360
  end
  obj_1:SetRotationY(obj1_to_obj2_rot, 45)
  if pos_rot < 90 then
    obj_turn_right1:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_right1:GetEndFrame() - 0.5)
      WaitFrame(f)
    end
  end
  if 90 <= pos_rot and pos_rot <= 180 then
    obj_turn_right2:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_right2:GetEndFrame() - 35)
      WaitFrame(f)
    end
  end
  if 180 <= pos_rot and pos_rot <= 270 then
    obj_turn_left2:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_left2:GetEndFrame() - 35)
      WaitFrame(f)
    end
  end
  if 270 < pos_rot then
    obj_turn_left1:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_left1:GetEndFrame() - 0.5)
      WaitFrame(f)
    end
  end
  obj_wait:Play(15, true)
end

function PlayerTurnToObject(obj_type_2, unique_name_2, is_wait, is_follocam, offsetcam_x, offsetcam_y)
  if is_wait == nil then
    is_wait = true
  end
  local obj_1 = Obj:new(PLAYER, "")
  local obj_2 = Obj:new(obj_type_2, unique_name_2)
  local obj_wait = Motion.Object:new(PLAYER, "", "fn01_01")
  local obj_turn_left1 = Motion.Object:new(PLAYER, "", "ft01_02")
  local obj_turn_right1 = Motion.Object:new(PLAYER, "", "ft01_01")
  local obj_turn_left2 = Motion.Object:new(PLAYER, "", "ft02_02")
  local obj_turn_right2 = Motion.Object:new(PLAYER, "", "ft02_01")
  local obj1_to_obj2_rot = Field.GetAngleToTarget2D(obj_1.pos.x, obj_1.pos.z, obj_2.pos.x, obj_2.pos.z)
  local pos_rot = obj1_to_obj2_rot - obj_1.rot_y
  if pos_rot < 0 then
    pos_rot = pos_rot + 360
  end
  obj_1:SetRotationY(obj1_to_obj2_rot, 30)
  if 30 < pos_rot and pos_rot < 90 then
    obj_turn_right1:PlaySetting(10, 0, 0, 15, 1, false)
    if is_wait then
      local f = math.floor(obj_turn_right1:GetEndFrame())
      if is_follocam then
        SetFollowerCameraOperateRotation(offsetcam_x, obj1_to_obj2_rot + offsetcam_y, f)
      end
      WaitFrame(f)
    end
  end
  if 90 <= pos_rot and pos_rot <= 180 then
    obj_turn_right2:PlaySetting(10, 0, 0, 20, 1, false)
    if is_wait then
      local f = math.floor(obj_turn_right2:GetEndFrame())
      if is_follocam then
        SetFollowerCameraOperateRotation(offsetcam_x, obj1_to_obj2_rot + offsetcam_y, f)
      end
      WaitFrame(f)
    end
  end
  if 180 <= pos_rot and pos_rot <= 270 then
    obj_turn_left2:PlaySetting(10, 0, 0, 20, 1, false)
    if is_wait then
      local f = math.floor(obj_turn_left2:GetEndFrame())
      if is_follocam then
        SetFollowerCameraOperateRotation(offsetcam_x, obj1_to_obj2_rot + offsetcam_y, f)
      end
      WaitFrame(f)
    end
  end
  if 270 < pos_rot then
    obj_turn_left1:PlaySetting(10, 0, 0, 15, 1, false)
    if is_wait then
      local f = math.floor(obj_turn_left1:GetEndFrame())
      if is_follocam then
        SetFollowerCameraOperateRotation(offsetcam_x, obj1_to_obj2_rot + offsetcam_y, f)
      end
      WaitFrame(f)
    end
  end
  obj_wait:Play(15, true)
  WaitFrame(10)
end

function ObjectTurnToRotaitonY(obj_type_1, unique_name_1, rot, is_wait)
  if is_wait == nil then
    is_wait = true
  end
  local obj_1 = Obj:new(obj_type_1, unique_name_1)
  local obj_wait = Motion.Object:new(obj_type_1, unique_name_1, "fn01_01")
  local obj_turn_left1 = Motion.Object:new(obj_type_1, unique_name_1, "ft01_02")
  local obj_turn_right1 = Motion.Object:new(obj_type_1, unique_name_1, "ft01_01")
  local obj_turn_left2 = Motion.Object:new(obj_type_1, unique_name_1, "ft02_02")
  local obj_turn_right2 = Motion.Object:new(obj_type_1, unique_name_1, "ft02_01")
  local pos_rot = rot - obj_1.rot_y
  if pos_rot < 0 then
    pos_rot = pos_rot + 360
  end
  obj_1:SetRotationY(rot, 30)
  if pos_rot < 90 then
    obj_turn_right1:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_left1:GetEndFrame() - 0.5)
      WaitFrame(f)
    end
  end
  if 90 <= pos_rot and pos_rot <= 180 then
    obj_turn_right2:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_left2:GetEndFrame() - 0.5)
      WaitFrame(f)
    end
  end
  if 180 <= pos_rot and pos_rot <= 270 then
    obj_turn_left2:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_right2:GetEndFrame() - 0.5)
      WaitFrame(f)
    end
  end
  if 270 < pos_rot then
    obj_turn_left1:Play(10, false)
    if is_wait then
      local f = math.floor(obj_turn_right1:GetEndFrame() - 0.5)
      WaitFrame(f)
    end
  end
  obj_wait:Play(15, true)
end

function SetFollowerCameraOperateRotation(rotateX, rotateY, frame)
  if frame == nil then
    if rotateX ~= default then
      Field.SetFollowerCameraOperateRotationX(rotateX)
    end
    if rotateY ~= default then
      Field.SetFollowerCameraOperateRotationY(rotateY)
    end
  else
    if rotateX ~= default then
      Field.SetFollowerCameraOperateRotationX(rotateX, frame)
    end
    if rotateY ~= default then
      Field.SetFollowerCameraOperateRotationY(rotateY, frame)
    end
  end
end

function SetEnableCameraOperate(is_enable)
  Field.SetEnableCameraOperate(is_enable)
end

function t3003_SetCamera(blend_frame)
  Cam.Inst:Set(8.11, -1.55, -16.12, 7.87, 1.896, -6.743, default, blend_frame)
end

function CameraAddLoad(file_name)
  Field.CameraAddLoad(file_name)
end

function CameraSwitchChange(switch_name, is_blend)
  Field.CameraSwitchChange(switch_name, is_blend)
end

function CameraSwitchChangeByFileName(file_name, switch_name, is_blend)
  Field.CameraSwitchChangeByFileName(file_name, switch_name, is_blend)
end

function SetNpcTalkZoomCamera(unique_name, zoom_rate, shift_to_side_dist, blend_frame, mode)
  local player = GetIndex(PLAYER, "")
  local index_npc = GetIndex(NPC, unique_name)
  local player_pos = Field.ObjectGetPosition(PLAYER, player)
  local npc_pos = Field.ObjectGetPosition(NPC, index_npc)
  local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
  local npc_y_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, npc_pos.x, npc_pos.z)
  local cam_y_degree = Field.GetAngleToTarget2D(cam_pos_x, cam_pos_z, player_pos.x, player_pos.z)
  if math.abs(npc_y_degree - cam_y_degree) <= 15 then
    local cam_yr_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, cam_pos_x, cam_pos_z)
    local npc_yr_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
    if cam_yr_degree <= npc_yr_degree then
      Field.SetFollowerCameraOperateRotationY(npc_y_degree - 20, 15)
    end
    if cam_yr_degree > npc_yr_degree then
      Field.SetFollowerCameraOperateRotationY(npc_y_degree + 20, 15)
    end
  end
  Field.SetFollowerCameraOperateRotationX(0, 15)
  Field.SetNpcTalkZoomCamera(unique_name, zoom_rate, shift_to_side_dist, blend_frame, mode)
  WaitFrame(blend_frame - 10)
end

function ClearNpcTalkZoomCamera(blend_frame, mode)
  Field.ClearNpcTalkZoomCamera(blend_frame, mode)
end

function SetNpcCamTP(npc_name, npc_size, aimY_adjust, camDist_adjust, player_adjust, frame, is_warp_pc, is_rotate_npc, env_file)
  local ply_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local npc_index = Field.GetNpcIndex(npc_name)
  local npc_pos = Field.ObjectGetPosition(FLD_OBJ_NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  local angle_adjust = -30
  local aim_hight = 0
  local cam_hight = 0
  local cam_distance = 0
  local npc_vector2d = 0
  if npc_size == "S" then
    aim_hight = 0.5
    cam_hight = 0
    cam_distance = 1
  elseif npc_size == "M" then
    aim_hight = 0
    cam_hight = 0
    cam_distance = 1
  elseif npc_size == "L" then
    aim_hight = 0
    cam_hight = 0
    cam_distance = 1
  end
  if is_warp_pc == false then
    local pc_pos_angle = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, ply_pos.x, ply_pos.z)
    npc_vector2d = Field.GetUnitVector2D(pc_pos_angle)
    npc_degree = pc_pos_angle
  else
    npc_vector2d = Field.GetUnitVector2D(npc_degree)
  end
  local player_x = npc_pos.x + npc_vector2d.x * player_adjust
  local player_z = npc_pos.z + npc_vector2d.z * player_adjust
  local cam_vector2d = Field.GetUnitVector2D(npc_degree + angle_adjust)
  local aim_x = npc_pos.x
  local aim_y = npc_pos.y + aim_hight + aimY_adjust
  local aim_z = npc_pos.z
  local cam_x = player_x + cam_vector2d.x * (cam_distance + camDist_adjust)
  local cam_y = ply_pos.y + 1.8 + cam_hight
  local cam_z = player_z + cam_vector2d.z * (cam_distance + camDist_adjust)
  if Flg.Check("FLAG_IS_SET_NPC_CAM") then
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, frame)
  else
    FadeOutWithWait(0, 5)
    if is_rotate_npc == true then
      ObjectSetRotationY(FLD_OBJ_NPC, npc_index, npc_degree, 0)
    end
    if env_file ~= nil then
      Field_SetEnvironmentSettings(env_file)
    end
    Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 0, false)
    Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 0, false)
    Field.ResetPlayer(player_x, ply_pos.y, player_z, npc_degree + 180)
    Field.FollowerWarp()
    Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, frame)
    Flg.Set("FLAG_IS_SET_NPC_CAM")
    FadeInWithWait(0, 5)
  end
end

function ClearNpcSholderCam(isFadeIn, isFadeOut, frame, npc_name)
  if Flg.Check("FLAG_IS_SET_NPC_CAM") then
    if isFadeIn == true then
      FadeOutWithWait(0, 5)
    end
    if npc_name ~= nil then
      local npc_index = Field.GetNpcIndex(npc_name)
      ObjectResetRotation(FLD_OBJ_NPC, npc_index, 0, true)
    end
    Field.ResetEnvironmentSettings()
    Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_FIELD, 0, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 0, false, false)
    Cam.Inst:Clear(frame)
    Flg.Clear("FLAG_IS_SET_NPC_CAM")
    if isFadeOut == true then
      FadeInWithWait(0, 5)
    end
  end
end

function SetShopCam(npc_name, aimY_adjust, camDist_adjust)
  local ply_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local npc_index = Field.GetNpcIndex(npc_name)
  local npc_pos = Field.ObjectGetPosition(FLD_OBJ_NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  local angle_adjust = 0
  local aim_hight = 1.5
  local cam_hight = 1.5
  local cam_distance = 2
  local vector2d = Field.GetUnitVector2D(npc_degree + angle_adjust)
  local aim_x = npc_pos.x + -0.5
  local aim_y = npc_pos.y + aim_hight + aimY_adjust
  local aim_z = npc_pos.z
  local cam_x = npc_pos.x + vector2d.x * (cam_distance + camDist_adjust)
  local cam_y = npc_pos.y + 1.5
  local cam_z = npc_pos.z + vector2d.z * (cam_distance + camDist_adjust)
  print("set shop cam: ", aim_x, ", ", aim_y, ", ", aim_z, ", ", cam_x, ", ", cam_y, ", ", cam_z)
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 20)
end

Cam = {
  Follower = {},
  Comp = {},
  Inst = {}
}

function Cam.Follower:ResetFromLocateAndPlayerRotate(locator, is_reverse)
  if is_reverse == nil then
    is_reverse = false
  end
  local player_index = GetIndex(PLAYER, "")
  local loc_pos = Field.GetLocatorPosition(locator)
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  local rotate = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, loc_pos.x, loc_pos.z)
  if not is_reverse then
    Field.SetPlayerRotationToLocator(locator, 0)
  else
    rotate = rotate + 180
    Field.SetPlayerRotation(rotate, 15)
  end
  Field.SetFollowerCameraOperateRotationY(rotate, 60, EASING_MODE_QUADRATIC_IN_OUT, 30)
  Field.SetFollowerCameraOperateRotationX(0, 60, EASING_MODE_QUADRATIC_IN_OUT, 30)
end

function Cam.Follower:ResetFromLocate(locator, is_reverse)
  if is_reverse == nil then
    is_reverse = false
  end
  local player_index = GetIndex(PLAYER, "")
  local loc_pos = Field.GetLocatorPosition(locator)
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  local rotate = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, loc_pos.x, loc_pos.z)
  if is_reverse then
    rotate = rotate + 180
  end
  Field.SetFollowerCameraOperateRotationY(rotate)
  Field.SetFollowerCameraOperateRotationX(0)
end

function Cam.Follower:ResetFromObject(obj_type, obj_name, blend_frame)
  local player_index = GetIndex(PLAYER, "")
  local obj_index = GetIndex(obj_type, obj_name)
  blend_frame = blend_frame or 0
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  local obj_pos = Field.ObjectGetPosition(obj_type, obj_index)
  local rotate = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, obj_pos.x, obj_pos.z)
  Field.SetFollowerCameraOperateRotationY(rotate, blend_frame)
  Field.SetFollowerCameraOperateRotationX(0, blend_frame)
end

function Cam.Follower:ResetFromObjectFade(obj_type, obj_name, is_fade, fade_type, blend_frame, wait_frame, angle_adjust)
  local player_index = GetIndex(PLAYER, "")
  local obj_index = GetIndex(obj_type, obj_name)
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  local obj_pos = Field.ObjectGetPosition(obj_type, obj_index)
  local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
  local npc_degree = Field.ObjectGetRotationY(obj_type, obj_index)
  if angle_adjust == nil then
    angle_adjust = 0
  end
  local vector2d = Field.GetUnitVector2D(npc_degree + angle_adjust)
  local cam_dis_x = obj_pos.x - cam_pos_x
  local cam_dis_z = obj_pos.z - cam_pos_z
  if cam_dis_x < 0 then
    cam_dis_x = -cam_dis_x
  end
  if cam_dis_z < 0 then
    cam_dis_z = -cam_dis_z
  end
  local aim_x = obj_pos.x
  local aim_y = obj_pos.y + (cam_pos_y - obj_pos.y)
  local aim_z = obj_pos.z
  local cam_x = player_pos.x + vector2d.x * cam_dis_x
  local cam_y = cam_pos_y
  local cam_z = player_pos.z + vector2d.z * cam_dis_z
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, blend_frame)
  WaitFrame(blend_frame * 0.7)
  if is_fade then
    FadeOutWithWait(fade_type, wait_frame)
  end
  WaitFrame(wait_frame)
  Cam.Inst:Clear(0)
end

function Cam.Follower:ResetFromObjectFade2(obj_type, obj_name, is_fade, fade_type, blend_frame, wait_frame, angle_adjust, is_reverse, rot)
  local pc = Obj:new(PLAYER, "")
  local obj = Obj:new(obj_type, obj_name)
  local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
  rot = rot or obj.rot_y
  angle_adjust = angle_adjust or 0
  is_reverse = is_reverse or false
  if is_reverse then
    rot = rot + 180
    if 360 < rot then
      rot = rot - 360
    end
  end
  local vector2d = Field.GetUnitVector2D(rot + angle_adjust)
  local cam_dis_x = math.abs(pc.pos.x - cam_pos_x)
  local cam_dis_z = math.abs(pc.pos.z - cam_pos_z)
  local dis = 1
  for i = 20, 1, -1 do
    local dis_x = math.abs(obj.pos.x + vector2d.x * i - pc.pos.x)
    local dis_z = math.abs(obj.pos.z + vector2d.z * i - pc.pos.z)
    if math.floor(math.abs(cam_dis_x - dis_x) - 0.5) <= 2 and math.floor(math.abs(cam_dis_z - dis_z) - 0.5) <= 2 then
      dis = i
      break
    end
  end
  Field.ObjectSuspendAutoTransparentForCamera(NPC, obj.index)
  local aim_x = obj.pos.x
  local aim_y = cam_pos_y
  local aim_z = obj.pos.z
  local cam_x = obj.pos.x + vector2d.x * dis
  local cam_y = cam_pos_y
  local cam_z = obj.pos.z + vector2d.z * dis
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, blend_frame, EASING_MODE_QUADRATIC_IN_OUT, false)
  WaitFrame(blend_frame * 0.7)
  if is_fade then
    FadeOutWithWait(fade_type, wait_frame)
  end
  WaitFrame(wait_frame)
  Field.ObjectCancelSuspendAutoTransparentForCamera(NPC, obj.index)
  Cam.Inst:Clear(0)
end

function Cam.Follower:ResetFromObjectFade3(obj_type, obj_name, is_fade, fade_type, blend_frame, wait_frame, angle_adjust, is_reverse, rot)
  local player_index = GetIndex(PLAYER, "")
  local obj_index = GetIndex(obj_type, obj_name)
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  local obj_pos = Field.ObjectGetPosition(obj_type, obj_index)
  local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
  if rot == nil then
    rot = Field.ObjectGetRotationY(obj_type, obj_index)
  end
  if angle_adjust == nil then
    angle_adjust = 0
  end
  if is_reverse == nil then
    is_reverse = false
  end
  if is_reverse then
    rot = rot + 180
    if 360 < rot then
      rot = rot - 360
    end
  end
  local vector2d = Field.GetUnitVector2D(rot + angle_adjust)
  local cam_dis_x = math.abs(player_pos.x - cam_pos_x)
  local cam_dis_z = math.abs(player_pos.z - cam_pos_z)
  local dis = 1
  for i = 20, 1, -1 do
    local dis_x = math.abs(obj_pos.x + vector2d.x * i - player_pos.x)
    local dis_z = math.abs(obj_pos.z + vector2d.z * i - player_pos.z)
    if math.floor(math.abs(cam_dis_x - dis_x) - 0.5) <= 2 and math.floor(math.abs(cam_dis_z - dis_z) - 0.5) <= 2 then
      dis = i
      break
    end
  end
  Field.ObjectSuspendAutoTransparentForCamera(NPC, obj_index)
  local aim_x = obj_pos.x
  local aim_y = cam_pos_y
  local aim_z = obj_pos.z
  local cam_x = obj_pos.x + vector2d.x * dis
  local cam_y = cam_pos_y
  local cam_z = obj_pos.z + vector2d.z * dis
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, DEFAULT_ANGLE, blend_frame, EASING_MODE_QUADRATIC_IN_OUT, true)
  WaitFrame(blend_frame * 0.7)
  if is_fade then
    FadeOutWithWait(fade_type, wait_frame)
  end
  WaitFrame(wait_frame)
  Field.ObjectCancelSuspendAutoTransparentForCamera(NPC, obj_index)
end

function Cam.Follower:ResetFromObjectAndPlayer(obj_type, obj_name, is_reverse)
  local player_index = GetIndex(PLAYER, "")
  local obj_index = GetIndex(obj_type, obj_name)
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  local obj_pos = Field.ObjectGetPosition(obj_type, obj_index)
  local rotate = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, obj_pos.x, obj_pos.z)
  if not is_reverse then
    Field.SetPlayerRotationToLocator(locator, 0)
  else
    rotate = rotate + 180
    Field.SetPlayerRotation(rotate, 15)
  end
  Field.SetFollowerCameraOperateRotationY(rotate)
  Field.SetFollowerCameraOperateRotationX(0)
end

function Cam.Follower:ResetFromRotation(y_degree)
  Field.SetPlayerRotation(y_degree, 15)
  Field.SetFollowerCameraOperateRotationY(y_degree)
  Field.SetFollowerCameraOperateRotationX(0)
end

function Cam.Follower:Reset2Clear(blend_frame, y_degree, x_degree, is_end_camera)
  y_degree = y_degree or Field.GetCameraRotationY()
  if y_degree == -1 then
    y_degree = Field.ObjectGetRotationY(PLAYER, GetIndex(PLAYER, ""))
  end
  x_degree = x_degree or 0
  blend_frame = blend_frame or 0
  print("##### y_degree = ", tostring(y_degree), " #####")
  if is_end_camera then
    Field.SetFollowerCameraOperateRotationY(y_degree)
    Field.SetFollowerCameraOperateRotationX(x_degree)
    Cam.Inst:Clear(blend_frame)
  else
    Field.SetFollowerCameraOperateRotationY(y_degree, blend_frame)
    Field.SetFollowerCameraOperateRotationX(x_degree, blend_frame)
  end
end

function Cam.Comp:ToEvent(cam_pos_x, cam_pos_y, cam_pos_z, cam_aim_x, cam_aim_y, cam_aim_z, angle, cam_blend_frame, move_point_x, move_point_z, move_frame)
  Cam.Inst:Set(cam_aim_x, cam_aim_y, cam_aim_z, cam_pos_x, cam_pos_y, cam_pos_z, angle, cam_blend_frame)
  local player_index = Field.GetPlayerIndex()
  local player_pos = Field.ObjectGetPosition(PLAYER, player_index)
  local player_dis_x = move_point_x - player_pos.x
  local player_dis_z = move_point_z - player_pos.z
  Field.MovePlayerToRelativePosFrame(player_dis_x, player_dis_z, move_frame)
end

function Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, field_of_view, blend_frame, easing_mode, collide_with_collision)
  if field_of_view == default then
    field_of_view = 45
  end
  if easing_mode == nil and collide_with_collision == nil then
    Field.SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, field_of_view, blend_frame)
  end
  if easing_mode ~= nil and collide_with_collision == nil then
    Field.SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, field_of_view, blend_frame, easing_mode)
  end
  if easing_mode == nil and collide_with_collision ~= nil then
    Field.SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, field_of_view, blend_frame, true, collide_with_collision)
  end
  if easing_mode ~= nil and collide_with_collision ~= nil then
    Field.SetInstantCamera(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, field_of_view, blend_frame, easing_mode, collide_with_collision)
  end
end

function Cam.Inst:Clear(blend_frame)
  Field.ClearInstantCamera(blend_frame)
end

function FollowObjectCamera(obj_type, unique_name, blend_frame, offset_cam_y, distance, is_end_camera, wait_frame, offset_obj_y, offset_ydegree)
  local gim = Obj:new(obj_type, unique_name)
  local player = Obj:new(PLAYER, "")
  local cam_pos_x, cam_pos_x, cam_pos_z = Field.GetCameraPos()
  distance = distance or 10
  is_end_camera = is_end_camera or false
  wait_frame = wait_frame or 120
  offset_cam_y = offset_cam_y or 2
  offset_obj_y = offset_obj_y or 0
  offset_ydegree = offset_ydegree or 20
  local pc_to_cam_ydegree = Field.GetAngleToTarget2D(player.pos.x, player.pos.z, cam_pos_x, cam_pos_z)
  local gim_to_pc_ydegree = Field.GetAngleToTarget2D(gim.pos.x, gim.pos.z, player.pos.x, player.pos.z)
  local gim_to_pc_vec
  if pc_to_cam_ydegree <= gim_to_pc_ydegree then
    gim_to_pc_vec = Field.GetUnitVector2D(gim_to_pc_ydegree - offset_ydegree)
  end
  if pc_to_cam_ydegree > gim_to_pc_ydegree then
    gim_to_pc_vec = Field.GetUnitVector2D(gim_to_pc_ydegree + offset_ydegree)
  end
  if gim_to_pc_vec ~= nil then
    local obj_cam_pos_x = gim.pos.x + gim_to_pc_vec.x * distance
    local obj_cam_pos_z = gim.pos.z + gim_to_pc_vec.z * distance
    Cam.Inst:Set(gim.pos.x, gim.pos.y + offset_obj_y, gim.pos.z, obj_cam_pos_x, gim.pos.y + offset_cam_y, obj_cam_pos_z, default, blend_frame)
    if is_end_camera then
      WaitFrame(wait_frame)
      Cam.Inst:Clear(blend_frame)
    end
  end
end

function PlayerLoadAttachment(variation_num, anim_name)
  Field.ObjectLoadAttachment(FLD_OBJ_PLAYER, Field.GetPlayerIndex(), variation_num)
  if anim_name ~= "" then
    local index = Field.GetPlayerIndex()
    Field.ObjectLoadAttachmentMotion(FLD_OBJ_PLAYER, index, variation_num, anim_name)
  end
end

function PlayerHideAttachment(variation_num)
  local index = Field.GetPlayerIndex()
  Field.ObjectHideAttachment(FLD_OBJ_PLAYER, index, variation_num)
end

function PlayerShowAttachment(variation_num)
  local index = Field.GetPlayerIndex()
  Field.ObjectShowAttachment(FLD_OBJ_PLAYER, index, variation_num)
end

function PlayerPlayAttachmentAnimation(variation_num, anim_name, blend_frame, is_loop)
  local index = Field.GetPlayerIndex()
  Field.ObjectPlayAttachmentMotion(FLD_OBJ_PLAYER, index, variation_num, anim_name, Util.SecondFromFrame(blend_frame), is_loop)
end

function IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, ele_text)
  local gim_text = "field_text"
  local pow_check = false
  local ele_check = false
  if need_ele == -1 then
    ele_check = true
  elseif need_ele == skill_ele then
    ele_check = true
  elseif need_ele ~= skill_ele then
    ele_check = false
  end
  if need_pow == 0 then
    pow_check = true
  elseif need_pow <= skill_pow then
    pow_check = true
  elseif skill_pow < need_pow then
    pow_check = false
  end
  Quake_Start(0.1, 0, 20)
  if pow_check == true and ele_check == true then
    print("Result True")
    return true
  elseif ele_check == false then
    print("Ele False")
    if ele_text == -1 then
    else
      Field_Talk_Start_Not_LetterBox(gim_text, 1)
      Message(ele_text)
    end
    Field_Talk_End_Not_LetterBox()
    return false
  elseif pow_check == false then
    print("Pow False")
    Field_Talk_Start_Not_LetterBox(gim_text, 1)
    Message("g_fa_0010_0010")
    Field_Talk_End_Not_LetterBox()
    return false
  end
end

function BreakFieldAttackObj(locator, col, wait_frame, se_id, effect)
  print("locator = ", locator, " col = ", col, " se = ", se_id, " effect = ", effect)
  local index = GetIndex(FLD_OBJ_LOCATOR, locator)
  AttachAndStartEffectScript(FLD_OBJ_LOCATOR, index, effect, false, 1, false, false, false, false)
  Quake_Start(0.2, 0, 20)
  if se_id ~= -1 then
    PlaySE(se_id, 100)
  end
  Obj:new(FLD_OBJ_LOCATOR, locator):Invisible(wait_frame)
  Field.ColOff(col)
end

function BreakFieldAttackObj_NoQuake(locator, col, wait_frame, se_id, effect)
  print("locator = ", locator, " col = ", col, " se = ", se_id, " effect = ", effect)
  local index = GetIndex(FLD_OBJ_LOCATOR, locator)
  AttachAndStartEffectScript(FLD_OBJ_LOCATOR, index, effect, false, 1, false, false, false, false)
  if se_id ~= -1 then
    PlaySE(se_id, 100)
  end
  Obj:new(FLD_OBJ_LOCATOR, locator):Invisible(wait_frame)
  Field.ColOff(col)
end

function BreakFieldAttackGim(gim_name, is_quake)
  print("gim_name = ", gim_name)
  local gim_index = Field.GetGimmickIndex(gim_name)
  Field.ObjectStartBreak(FLD_OBJ_GIMMICK, gim_index)
  if is_quake then
    Quake_Start(0.2, 0, 20)
  end
end

function LoadEffefctScript(file_name, spare_num)
  Field.LoadEffectScript(file_name, spare_num)
end

function AttachEffectScript(object_type, index, file_name, is_loop, manage_id, keep_pos, keep_rot, link_scale, link_alpha)
  Field.ObjectAttachEffectScript(object_type, index, file_name, is_loop, manage_id, keep_pos, keep_rot, link_scale, link_alpha)
end

function StartEffectScript(object_type, index, manage_id)
  Field.ObjectStartEffectScript(object_type, index, manage_id)
end

function PlayEffectScript(file_name, pos_x, pos_y, pos_z, y_degree, scale)
  Field.PlayEffectScript(file_name, pos_x, pos_y, pos_z, y_degree, scale)
end

function AttachAndStartEffectScript(object_type, index, file_name, is_loop, manage_id, keep_pos, keep_rot, link_scale, link_alpha)
  AttachEffectScript(object_type, index, file_name, is_loop, manage_id, keep_pos, keep_rot, link_scale, link_alpha)
  StartEffectScript(object_type, index, manage_id)
end

function SetQuakeEffect(effect_name)
  Field.SetQuakeEffect(effect_name)
end

function ClearQuakeEffect()
  Field.ClearQuakeEffect()
end

Tlk = {}

function Tlk:new(file_name, mode, is_open_letter, is_not_invisible)
  local obj = {}
  obj.file_name = file_name
  obj.mode = mode or 1
  obj.is_letter = is_open_letter or false
  obj.npc_name = nil
  obj.start_zoom = 45
  obj.end_zoom = 15
  obj.is_talk_start = false
  obj.is_not_invisible = nil
  if is_not_invisible == nil then
    obj.is_not_invisible = true
  end
  
  function obj:StartTalk()
    self.is_talk_start = true
    if self.is_not_invisible then
      Field_InvisibleFollowerAllGuest(0, 15, false)
      Field_InvisibleFollowerAllPartyMember(0, 15, false)
    end
    Talk.Load(self.file_name)
    Talk.SetMode(self.mode)
    if self.is_letter then
      Talk.OpenLetterBox()
    end
  end
  
  function obj:StartTalkAndCancelDigimonRide()
    Field.CancelPlayerAnywhereDigimonRide(false)
    self.is_talk_start = true
    if self.is_not_invisible then
      Field_InvisibleFollowerAllGuest(0, 15, false)
      Field_InvisibleFollowerAllPartyMember(0, 15, false)
    end
    Talk.Load(self.file_name)
    Talk.SetMode(self.mode)
    if self.is_letter then
      Talk.OpenLetterBox()
    end
  end
  
  function obj:StartTalkAction(npc_name)
    self.npc_name = npc_name
    Field.StartPlayerAndNpcTalkAction(self.npc_name)
    self:StartTalk()
  end
  
  function obj:StartTalkZoom(npc_name)
    self.npc_name = npc_name
    local player = GetIndex(PLAYER, "")
    local index_npc = GetIndex(NPC, self.npc_name)
    local player_pos = Field.ObjectGetPosition(PLAYER, player)
    local npc_pos = Field.ObjectGetPosition(NPC, index_npc)
    local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
    local npc_y_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, npc_pos.x, npc_pos.z)
    local cam_y_degree = Field.GetAngleToTarget2D(cam_pos_x, cam_pos_z, player_pos.x, player_pos.z)
    if math.abs(npc_y_degree - cam_y_degree) <= 15 then
      local cam_yr_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, cam_pos_x, cam_pos_z)
      local npc_yt_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
      if cam_yr_degree <= npc_yt_degree then
        Field.SetFollowerCameraOperateRotationY(npc_y_degree - 20, 15)
      end
      if cam_yr_degree > npc_yt_degree then
        Field.SetFollowerCameraOperateRotationY(npc_y_degree + 20, 15)
      end
    end
    Field.SetNpcTalkZoomCamera(self.npc_name, 0.8, 2, self.start_zoom, 1)
    self:StartTalk()
  end
  
  function obj:StartTalkActionAndZoom(npc_name)
    self.npc_name = npc_name
    Field.StartPlayerAndNpcTalkAction(self.npc_name)
    local player = GetIndex(PLAYER, "")
    local index_npc = GetIndex(NPC, self.npc_name)
    local player_pos = Field.ObjectGetPosition(PLAYER, player)
    local npc_pos = Field.ObjectGetPosition(NPC, index_npc)
    local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
    local npc_y_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, npc_pos.x, npc_pos.z)
    local cam_y_degree = Field.GetAngleToTarget2D(cam_pos_x, cam_pos_z, player_pos.x, player_pos.z)
    if math.abs(npc_y_degree - cam_y_degree) <= 15 then
      local cam_yr_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, cam_pos_x, cam_pos_z)
      local npc_yt_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
      if cam_yr_degree <= npc_yt_degree then
        Field.SetFollowerCameraOperateRotationY(npc_y_degree - 20, 15)
      end
      if cam_yr_degree > npc_yt_degree then
        Field.SetFollowerCameraOperateRotationY(npc_y_degree + 20, 15)
      end
    end
    Field.SetNpcTalkZoomCamera(self.npc_name, 0.8, 2, self.start_zoom, 1)
    self:StartTalk()
  end
  
  function obj:StartTalkActionAndZoomVariable(npc_name, zoom_rate)
    self.npc_name = npc_name
    Field.StartPlayerAndNpcTalkAction(self.npc_name)
    local player = GetIndex(PLAYER, "")
    local index_npc = GetIndex(NPC, self.npc_name)
    local player_pos = Field.ObjectGetPosition(PLAYER, player)
    local npc_pos = Field.ObjectGetPosition(NPC, index_npc)
    local cam_pos_x, cam_pos_y, cam_pos_z = Field.GetCameraPos()
    local npc_y_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, npc_pos.x, npc_pos.z)
    local cam_y_degree = Field.GetAngleToTarget2D(cam_pos_x, cam_pos_z, player_pos.x, player_pos.z)
    if math.abs(npc_y_degree - cam_y_degree) <= 15 then
      local cam_yr_degree = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, cam_pos_x, cam_pos_z)
      local npc_yt_degree = Field.GetAngleToTarget2D(npc_pos.x, npc_pos.z, player_pos.x, player_pos.z)
      if cam_yr_degree <= npc_yt_degree then
        Field.SetFollowerCameraOperateRotationY(npc_y_degree - 20, 15)
      end
      if cam_yr_degree > npc_yt_degree then
        Field.SetFollowerCameraOperateRotationY(npc_y_degree + 20, 15)
      end
    end
    Field.SetNpcTalkZoomCamera(self.npc_name, zoom_rate, 2, self.start_zoom, 1)
    self:StartTalk()
  end
  
  function obj:StartAction()
    Field.StartPlayerAndNpcTalkAction(self.npc_name)
  end
  
  function obj:StartZoom(npc_name)
    if npc_name ~= nil then
      self.npc_name = npc_name
    end
    Field.SetNpcTalkZoomCamera(self.npc_name, 0.8, 2, self.start_zoom, 1)
  end
  
  function obj:StartActionAndZoom(npc_name)
    if npc_name == nil then
      npc_name = self.npc_name
    end
    if npc_name ~= nil then
      self.npc_name = npc_name
    end
    Field.StartPlayerAndNpcTalkAction(self.npc_name)
    Field.SetNpcTalkZoomCamera(self.npc_name, 0.8, 2, self.start_zoom, 1)
  end
  
  function obj:Message(message, tag)
    if type(message) == "number" or type(message) == "string" then
      Talk.Message(message)
      if tag ~= nil then
        if type(tag) == "number" then
          Talk.SetNumber(tag)
        elseif type(tag) == "string" then
          Talk.SetString(tag)
        end
      end
      while not Talk.IsNext() do
        WaitFrame(1)
      end
    end
    if type(message) == "table" then
      for i = 1, #message do
        Talk.Message(message[i])
        while not Talk.IsNext() do
          WaitFrame(1)
        end
      end
    end
  end
  
  function obj:MessageAuto(message, frame)
    Talk.Message_Auto(message, frame)
    WaitFrame(1)
    while not Talk.IsNext() do
      WaitFrame(1)
    end
  end
  
  function obj:MessageClose()
    Talk.Close()
    while not Talk.IsClose() do
      WaitFrame(1)
    end
  end
  
  function obj:Select(select_num, message)
    self:MessageClose()
    Talk.MessageTalkSel(select_num, message)
    while not Talk.IsNext() do
      WaitFrame(1)
    end
    Talk.ResultSelectedNum()
    return Talk.GetResultSelectedNum()
  end
  
  function obj:EndAction()
    Field.EndPlayerAndNpcTalkAction(self.npc_name)
  end
  
  function obj:EndZoom()
    Field.ClearNpcTalkZoomCamera(self.end_zoom, 1)
  end
  
  function obj:EndActionAndZoom()
    Field.EndPlayerAndNpcTalkAction(self.npc_name)
    Field.ClearNpcTalkZoomCamera(self.end_zoom, 1)
  end
  
  function obj:EndTalk(followerinvisivle)
    WaitFrame(5)
    local followerinvisivle = followerinvisivle
    Talk.Close()
    if self.is_letter then
      print("debugrt: is_letter is true")
    else
      print("debugrt: is_letter is false")
    end
    while not Talk.IsClose() do
      WaitFrame(1)
    end
    if self.is_letter then
      Talk.CloseLetterBox()
    end
    Talk.Exit()
    while not Talk.IsExit() do
      WaitFrame(1)
    end
    Talk.End()
    self.is_talk_start = false
    if not followerinvisivle then
      Field_CancelInvisibleFollowerAllGuest(0, 15, false, false)
      Field_CancelInvisibleFollowerAllPartyMember(0, 15, false, false)
    end
  end
  
  function obj:EndTalkAction()
    Field_InvisibleFollowerAllPartyMember(0, 30, false)
    Field_InvisibleFollowerAllGuest(0, 20, false)
    Field.EndPlayerAndNpcTalkAction(self.npc_name)
    self:EndTalk()
  end
  
  function obj:EndTalkZoom()
    Field.ClearNpcTalkZoomCamera(self.end_zoom, 1)
    self:EndTalk()
    Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
  end
  
  function obj:EndTalkActionAndZoom()
    Field.EndPlayerAndNpcTalkAction(self.npc_name)
    Field.ClearNpcTalkZoomCamera(self.end_zoom, 1)
    self:EndTalk()
    Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
  end
  
  function obj:IsTalkStart()
    return self.is_talk_start
  end
  
  function obj:StartNarration()
    self.is_talk_start = true
    if self.is_not_invisible then
      Field_InvisibleFollowerAllGuest(0, 15, false)
      Field_InvisibleFollowerAllPartyMember(0, 15, false)
    end
    Talk.Load(self.file_name)
  end
  
  function obj:Narration(message, position, align, layout, dark_change)
    position = position or 0
    align = align or 0
    layout = layout or 0
    dark_change = dark_change or true
    Talk.OpenNarration(message, position, align, layout, dark_change)
    while not Talk.IsNext() do
      WaitFrame(1)
    end
  end
  
  function obj:NarrationClose()
    Talk.CloseNarration()
    while not Talk.IsCloseNarration() do
      WaitFrame(1)
    end
  end
  
  return obj
end

function Field_Talk_Start(file_name, mode)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Talk.Load(file_name)
  Talk.SetMode(mode)
  Talk.OpenLetterBox()
end

function Field_Talk_Start_Not_LetterBox(file_name, mode)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Talk.Load(file_name)
  Talk.SetMode(mode)
end

function FieldTalkStartWithoutLetterBox(file_name, mode)
  Talk.Load(file_name)
  Talk.SetMode(mode)
end

function Field_Talk_End()
  MessageClose()
  Talk.CloseLetterBox()
  TalkExit()
  Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
end

function Field_Talk_End_Not_LetterBox()
  MessageClose()
  TalkExit()
  Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
end

function FieldTalkEndWithoutLetterBox()
  MessageClose()
  TalkExit()
  Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
end

function NPC_TALK_ZOOM_START(npc_unique_name)
  SetNpcTalkZoomCamera(npc_unique_name, 0.5, 2, 60, 1)
end

function NPC_TALK_END()
  ClearNpcTalkZoomCamera(60, 1)
end

function START_PlAYER_AND_NPC_TALK_ACTION(npc_name)
  Field.StartPlayerAndNpcTalkAction(npc_name)
  Field_InvisibleFollowerAllPartyMember(0, 30, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
end

function END_PLAYER_AND_NPC_TALK_ACTION(npc_name)
  Field.EndPlayerAndNpcTalkAction(npc_name)
  Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
end

function START_TALK_ACTION_AND_ZOOM(npc_name, is_talk_action, is_zoom)
  local rot_x = Field.GetCameraRotationX()
  local rot_y_1 = Field.GetCameraRotationY()
  local rot_y = Field.ObjectGetRotationY(FLD_OBJ_PLAYER, 1)
  if is_talk_action == true then
    Field_InvisibleFollowerAllPartyMember(0, 30, false)
    Field_InvisibleFollowerAllGuest(0, 20, false)
    Field.StartPlayerAndNpcTalkAction(npc_name)
  end
  if is_zoom ~= true or rot_x ~= 0 or rot_y_1 ~= 180 then
  end
end

function START_TALK_ACTION_AND_ZOOM_VARIABLE(npc_name, is_talk_action, is_zoom, zoom_rate)
  if is_talk_action == true then
    Field_InvisibleFollowerAllPartyMember(0, 30, false)
    Field_InvisibleFollowerAllGuest(0, 20, false)
    Field.StartPlayerAndNpcTalkAction(npc_name)
  end
  if is_zoom == true then
    SetNpcTalkZoomCamera(npc_name, zoom_rate, 2, 45, 1)
  end
end

function END_TALK_ACTION_AND_ZOOM(npc_name, is_talk_action, is_zoom)
  if is_talk_action == true then
    Field.EndPlayerAndNpcTalkAction(npc_name)
    Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
  end
  if is_zoom == true then
  end
end

function FieldTalk(file_name, mode, message)
  Field_Talk_Start(file_name, mode)
  if type(message) == "number" then
    Message(message)
  elseif type(message) == "table" then
    for i = 1, #message do
      Message(message[i])
    end
    Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
    Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
  end
  Field_Talk_End()
end

function FieldTalkAndZoom(file_name, mode, message, unique_name)
  START_TALK_ACTION_AND_ZOOM(unique_name, true, true)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field_Talk_Start(file_name, mode)
  if type(message) == "number" then
    Message(message)
  elseif type(message) == "table" then
    for i = 1, #message do
      Message(message[i])
    end
  end
  Field_Talk_End()
  Field.CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field.CancelInvisibleFollowerAllGuest(0, 20, false, true)
  END_TALK_ACTION_AND_ZOOM(unique_name, true, true)
end

function AnswerTheCall()
  local SEslot_1 = PlaySE(500006, 100)
  Common.SetVibration(0.6, 0, 0.6)
  WaitFrame(15)
  Motion.Player:Play("e503", 15, true)
  WaitFrame(20)
  StopSE(SEslot_1, 1)
  PlaySE(402002, 100)
  WaitFrame(10)
end

function EndTheCall()
  Motion.Player:PlayWithMoveMotion("fn01_01", 15, 15)
  WaitFrame(15)
end

Qst = {
  Main = {},
  Sub = {},
  Hazama = {},
  DLC = {}
}

function Qst.Main:Start(quest_id, flag_id, is_save)
  Quest.Receive(quest_id)
  Quest.SetMainFlag(quest_id, flag_id)
  while not Quest.IsEndDirection() do
    WaitFrame(1)
  end
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.Main:Set(quest_id, flag_id, is_save)
  Quest.SetMainFlag(quest_id, flag_id)
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.Main:End(quest_id, flag_id, is_save)
  Digimon.RestoreAllParty()
  Quest.Receive(quest_id)
  Quest.SetMainFlag(quest_id, flag_id)
  WaitFrame(90)
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.Main:Chapter(steps, quest_id)
  for _, value in pairs(steps) do
    print("Chapter: ", quest_id, " step: ", value)
    if value == 1 then
      Qst.Main:Start(quest_id, value)
    elseif value == 255 then
      Qst.Main:End(quest_id, value)
    else
      Qst.Main:Set(quest_id, value)
    end
  end
end

function Qst.Main:Check(quest_id, current_flag, next_flag)
  if current_flag ~= nil then
    local is_current = Quest.CheckMainFlag(quest_id, current_flag)
    if next_flag ~= nil then
      local is_next = Quest.CheckMainFlag(quest_id, next_flag)
      if is_current and not is_next then
        print("Qst.Main:Check returned [ true ]")
        return true
      else
        print("Qst.Main:Check returned [ false ]")
        return false
      end
    else
      return is_current
    end
  end
  print("Qst.Main:Check returned [ nil ]")
  print("Please Check Your Scripts and Flags")
  return nil
end

function Qst.Main:AllCheck(quest_id, flag_table)
  if quest_id ~= nil and flag_table ~= nil then
    for key in pairs(flag_table) do
      local result = Quest.CheckMainFlag(quest_id, flag_table[key])
      if not result then
        return false
      end
    end
    return true
  end
  return nil
end

function Qst.Main:IsCompleted(quest_id)
  return Quest.IsCompleted(quest_id)
end

function Qst.Main:WaitUI()
  while not Quest.IsEndDirection() do
    WaitFrame(1)
  end
end

function Qst.Sub:Start(quest_id, flag_id, is_force_receive, is_save)
  MessageClose()
  Quest.OpenDetails(quest_id, is_force_receive)
  WaitCloseSubQuestWindow()
  if Quest.IsReceive() then
    Quest.SetFlag(quest_id, flag_id)
  end
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.Sub:QuickStart(quest_id, is_save)
  Quest.QuickReceive(quest_id)
  print("quick receive : ", quest_id)
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.Sub:IsAbleReceive(quest_id)
  return Quest.IsAbleReceive(QUEST_GUIDE_SUB, quest_id)
end

function Qst.Sub:Set(quest_id, flag_id, is_save)
  Quest.SetFlag(quest_id, flag_id)
  WaitFrame(30)
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.Sub:Clear(quest_id, flag_id)
  Quest.ClearFlag(quest_id, flag_id)
end

function Qst.Sub:Retreat(quest_id, guide_id, is_between_step)
  Quest.Retreat(QUEST_GUIDE_SUB, quest_id, guide_id, is_between_step)
  WaitFrame(30)
end

function Qst.Sub:End(quest_id, flag_id, is_save)
  Digimon.RestoreAllParty()
  Quest.SetFlag(quest_id, flag_id)
  Quest.Complete(quest_id)
  WaitCloseSubQuestWindow()
  WaitFrame(1)
  if is_save ~= false then
    Field.StartAutoSave()
  end
  WaitFrame(1)
  local sub_table = {}
  local digitter_id = 0
  if not Flg.Check("FLAG_IS_CLEAR_S100_178") then
    if Flg.Check("FLAG_MAIN_01_000", "FLAG_MAIN_03_401") then
      sub_table = {
        1,
        2,
        3,
        72,
        90
      }
      if Flg.Check("FLAG_DLC_COS_010") then
        table.insert(sub_table, "146")
      end
      if Flg.Check("FLAG_DLC_COS_020") then
        table.insert(sub_table, "147")
      end
      digitter_id = 1
    end
    if Flg.Check("FLAG_MAIN_03_460", "FLAG_MAIN_07_000") then
      sub_table = {
        18,
        172,
        24,
        32,
        38,
        39,
        41,
        42,
        43,
        59,
        60,
        78,
        91,
        152
      }
      if Flg.Check("FLAG_DLC_COS_030") then
        table.insert(sub_table, "148")
      end
      if Flg.Check("FLAG_DLC_COS_050") then
        table.insert(sub_table, "150")
      end
      digitter_id = 2
    end
  else
    sub_table = {
      1,
      2,
      3,
      13,
      18,
      19,
      172,
      173,
      24,
      29,
      30,
      31,
      183,
      32,
      33,
      38,
      39,
      41,
      42,
      43,
      176,
      55,
      56,
      57,
      59,
      60,
      72,
      77,
      78,
      82,
      87,
      88,
      89,
      178,
      90,
      91,
      92,
      93,
      94,
      98,
      99,
      100,
      101,
      102,
      103,
      104,
      105,
      106,
      108,
      109,
      111,
      112,
      113,
      152,
      156,
      179,
      180,
      160,
      162,
      167,
      169,
      170,
      171,
      216,
      208,
      211,
      215,
      217
    }
    digitter_id = 3
  end
  local length = #sub_table
  local count_clear = 0
  local count_notclear = 0
  for i = 1, length do
    if Qst.Sub:IsCompleted(sub_table[i]) then
      count_clear = count_clear + 1
      print(count_clear)
    else
      count_notclear = count_notclear + 1
      print("not_clear")
    end
  end
  print("count_clear" .. count_clear)
  print("not_clear" .. count_notclear)
  if count_notclear == 0 then
    if digitter_id == 1 then
      Digitter.Send(2500010)
    elseif digitter_id == 2 then
      Digitter.Send(2500020)
    elseif digitter_id == 3 then
    end
  end
end

function Qst.Sub:IsCompleted(quest_id)
  print("quest id ", quest_id, " check completed")
  return Quest.SubIsCompleted(quest_id)
end

function Qst.Sub:IsAllCompleted(quest_id_table)
  for _, quest_id in pairs(quest_id_table) do
    if not Quest.SubIsCompleted(quest_id) then
      return false
    end
  end
  return true
end

function Qst.Sub:Check(quest_id, current_flag, next_flag)
  if current_flag ~= nil then
    local is_current = Quest.CheckFlag(quest_id, current_flag)
    if next_flag ~= nil then
      local is_next = Quest.CheckFlag(quest_id, next_flag)
      if is_current and not is_next then
        print("CheckSubQuest returned [ true ]")
        return true
      else
        print("CheckSubQuest returned [ false ]")
        return false
      end
    else
      print("Qst.Sub:Check returned ", is_current)
      return is_current
    end
  end
  print("CheckSubQuest returned [ nil ]")
  print("Please Check Your Scripts and Flags")
  return nil
end

function Qst.Hazama:Orders(quest_id)
  local error_id = 0
  local is_orders = false
  if error_id == 0 then
    Quest.OpenReceiveYesNoWindow(1, quest_id, "")
  elseif error_id == 1 then
    Quest.OpenReceiveYesNoWindow(1, quest_id, "g_degi_h0415_0020")
  end
  WaitCloseHazamaQuestWindow()
  if Quest.IsReceive() then
    Quest.SetFlag(quest_id, 1)
    is_orders = true
  end
  return is_orders
end

function Qst.Hazama:Start(quest_id, timer_flg)
  if timer_flg ~= nil then
    timer_flg = false
  end
  if timer_flg then
    Quest.StopTimer()
    Quest.SubOpeningGuide(quest_id)
    WaitQuestEndDirection()
    Quest.StartTimer()
  else
    Quest.SubOpeningGuide(quest_id)
    WaitQuestEndDirection()
  end
end

function Qst.Hazama:Set(quest_id, flag_id)
  Quest.SetFlag(quest_id, flag_id)
  WaitFrame(30)
end

function Qst.Hazama:Clear(quest_id)
  Quest.OpenClearDirection(1, quest_id)
  WaitQuestEndDirection()
end

function Qst.Hazama:End(quest_id, flag_id, is_save)
  Quest.SetFlag(quest_id, flag_id)
  Quest.Complete(quest_id)
  WaitCloseSubQuestWindow()
  WaitFrame(1)
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

Icon = {}

function Qst.DLC:Start(quest_id, flag_id, is_force_receive, is_save)
  Quest.OpenDetails(quest_id, is_force_receive)
  WaitCloseSubQuestWindow()
  if Quest.IsReceive() then
    Quest.SetFlag(quest_id, flag_id)
  end
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.DLC:Set(quest_id, flag_id, is_save)
  Quest.SetFlag(quest_id, flag_id)
  WaitFrame(30)
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.DLC:End(quest_id, flag_id, is_save)
  MessageClose()
  Quest.SetFlag(quest_id, flag_id)
  Quest.Complete(quest_id)
  WaitCloseSubQuestWindow()
  WaitFrame(1)
  if is_save ~= false then
    Field.StartAutoSave()
  end
end

function Qst.DLC:Check(quest_id, current_flag, next_flag)
  if current_flag ~= nil then
    local is_current = Quest.CheckFlag(quest_id, current_flag)
    if next_flag ~= nil then
      local is_next = Quest.CheckFlag(quest_id, next_flag)
      if is_current and not is_next then
        print("Qst.DLC:Check returned [ true ]")
        return true
      else
        print("Qst.DLC:Check returned [ false ]")
        return false
      end
    else
      return is_current
    end
    return is_current
  end
  print("Qst.DLC:Check returned [ nil ]")
  print("Please Check Your Scripts and Flags")
  return nil
end

function Qst.DLC:Chapter(steps, quest_id)
  for _, value in pairs(steps) do
    print("Chapter: ", quest_id, " step: ", value)
    if value == 1 then
      Qst.DLC:Start(quest_id, value, true)
    elseif value == 255 then
      Qst.DLC:End(quest_id, value)
    else
      Qst.DLC:Set(quest_id, value)
    end
  end
end

function Icon:new(object_type, unique_name)
  local icon = {}
  icon.object_type = object_type
  icon.index = GetIndex(object_type, unique_name)
  
  function icon.SetNone()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_NONE)
  end
  
  function icon.SetScenarioTarget()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_SCENARIO_TARGET)
  end
  
  function icon.SetQuestTarget()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_QUEST_TARGET)
  end
  
  function icon.SetImportantQuest()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_IMPORTANT_QUEST)
  end
  
  function icon.SetImportantQuestReportable()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_IMPORTANT_QUEST_REPORTABLE)
  end
  
  function icon.SetSubQuest()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_SUB_QUEST)
  end
  
  function icon.SetSubQuestReportable()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_SUB_QUEST_REPORTABLE)
  end
  
  function icon.SetDigimonChat()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_DIGIMON_CHAT)
  end
  
  function icon.SetShop()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_SHOP)
  end
  
  function icon.SetTalk()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_TALK)
  end
  
  function icon.SetPCCheck()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_PC_CHECK)
  end
  
  function icon.SetTrain()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_TRAIN)
  end
  
  function icon.SetBlimp()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_BLIMP)
  end
  
  function icon.SetAreaChange()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_AREA_CHANGE)
  end
  
  function icon.SetDigimonRide()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_DIGIMON_RIDE)
  end
  
  function icon.SetNarrowSpace()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_NARROW_SPACE)
  end
  
  function icon.SetTreasure()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_TREASURE)
  end
  
  function icon.SetPopPoint()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_POP_POINT)
  end
  
  function icon.SetDuct()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_DUCT)
  end
  
  function icon.SetElevatorUp()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_ELV_UP)
  end
  
  function icon.SetElevatorDown()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_ELV_DOWN)
  end
  
  function icon.SetLadder()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_LADDER)
  end
  
  function icon.SetCarry()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_CARRY)
  end
  
  function icon.SetHide()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_HIDE)
  end
  
  function icon.SetAlongTheWall()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_ALONG_THE_WALL)
  end
  
  function icon.SetMasterBlimp()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_MASTER_BLIMP)
  end
  
  function icon.SetFlight()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_FLIGHT)
  end
  
  function icon.SetTaxi()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_TAXI)
  end
  
  function icon.SetCardShop()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_CARD_SHOP)
  end
  
  function icon.SetCostumeShop()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_COSTUME_SHOP)
  end
  
  function icon.SetDigitalGate()
    Field.ObjectSetIcon(icon.object_type, icon.index, ICO_DIGITAL_GATE)
  end
  
  function icon.Clear()
    Field.ObjectClearIcon(icon.object_type, icon.index)
  end
  
  return icon
end

function HideGuide(is_enable)
  Field.HideGuide(is_enable)
end

function IconOnID(a_locator, a_icon_type, a_height, a_rotate)
  Field.IconOnID(a_locator, a_icon_type, a_height, a_rotate)
end

function IconOffID(a_locator, a_icon_type)
  Field.IconOffID(a_locator, a_icon_type)
end

function MinimapMarkerOn(a_locator, a_icon_type)
  Field.MinimapMarkerOn(a_locator, a_icon_type)
end

function MinimapMarkerOff(a_locator, a_icon_type)
  Field.MinimapMarkerOff(a_locator, a_icon_type)
end

function SetEnableGimmickCheck(a_locator, is_enable)
  Field.SetEnableGimmickCheck(a_locator, is_enable)
end

function SetEnableAllCheckPoint(enable)
  Field.ObjectSetEnableCheckAndFieldAttack(FOR_ALL, FOR_ALL, enable)
  if not enable then
    if gMapNum == 207 then
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0002"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0003"):SetEnableCheckAndFieldAttack(true)
    end
    if gMapNum == 209 then
      Obj:new(FLD_OBJ_LOCATOR, "gim_0001"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "gim_0003"):SetEnableCheckAndFieldAttack(true)
      Obj:new(FLD_OBJ_LOCATOR, "elv_0002"):SetEnableCheckAndFieldAttack(true)
    end
  end
end

function MiniMapChange(floor_id)
  Field.ChangeFloor(floor_id)
end

function HideMinimap(is_enable)
  Field.HideMinimap(is_enable)
end

function OpenIntroduction(field_name_id, disp_delay, disp_time)
  Field.OpenIntroduction(field_name_id, Util.SecondFromFrame(disp_delay), Util.SecondFromFrame(disp_time))
  print(field_name_id)
  print(disp_delay)
  print(disp_time)
  Flg.Set("FLAG_IS_DISPLAYED_MAP_NAME_UI")
end

function MapNameDisp()
  if not Flg.Check("FLAG_IS_DISPLAYED_MAP_NAME_UI") then
    if Flg.Check("FLAG_IS_NOT_MAP_NAME_DISP") then
      return
    end
    map_prefix = Field.GetMapPrefix()
    map_num = Field.GetMapNumber()
    if map_prefix == "t" then
      if map_num == 101 then
        OpenIntroduction(10101, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 102 then
        OpenIntroduction(10102, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 103 then
        OpenIntroduction(10103, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 104 then
        OpenIntroduction(10104, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 105 then
        OpenIntroduction(10105, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 106 then
        OpenIntroduction(10106, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 107 then
        OpenIntroduction(10107, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 108 then
        OpenIntroduction(10108, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 109 then
        OpenIntroduction(10109, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 110 then
        OpenIntroduction(10110, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 201 then
        OpenIntroduction(10201, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 202 then
        OpenIntroduction(10202, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 301 then
        OpenIntroduction(10301, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 302 then
        OpenIntroduction(10302, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 401 then
        OpenIntroduction(10401, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 402 then
        OpenIntroduction(10402, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 403 then
        OpenIntroduction(10403, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 404 then
        OpenIntroduction(10404, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 408 then
        OpenIntroduction(10408, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 3001 then
        OpenIntroduction(13001, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 3002 then
        OpenIntroduction(13002, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 3003 then
        OpenIntroduction(13003, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      end
    end
    if map_prefix == "d" then
      if map_num == 101 then
        OpenIntroduction(20101, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 102 then
        OpenIntroduction(20102, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 106 then
        OpenIntroduction(20106, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 201 then
        OpenIntroduction(20201, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 202 then
        OpenIntroduction(20202, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 203 then
        OpenIntroduction(20203, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 204 then
        OpenIntroduction(20204, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 205 then
        OpenIntroduction(20205, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 206 then
        OpenIntroduction(20206, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num >= 211 and map_num <= 215 then
        OpenIntroduction(20211, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 216 then
        if Flg.Check("FLAG_MAIN_03_470") then
          OpenIntroduction(20216, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
        end
      elseif map_num == 217 then
        OpenIntroduction(20217, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 301 then
        OpenIntroduction(20301, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 304 then
        OpenIntroduction(20304, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 306 then
        OpenIntroduction(20306, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 308 then
        OpenIntroduction(20308, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 401 then
        OpenIntroduction(20401, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 404 then
        OpenIntroduction(20404, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 407 then
        OpenIntroduction(20407, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 501 then
        OpenIntroduction(20501, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 503 then
        OpenIntroduction(20503, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 505 then
        OpenIntroduction(20505, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 506 then
        OpenIntroduction(20506, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 507 then
        OpenIntroduction(20507, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 509 then
        OpenIntroduction(20509, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 511 then
        OpenIntroduction(20511, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 513 then
        OpenIntroduction(20513, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 602 then
        OpenIntroduction(20602, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 607 then
        OpenIntroduction(20607, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 608 then
        OpenIntroduction(20608, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 701 then
        OpenIntroduction(20701, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 702 then
        OpenIntroduction(20702, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 801 then
        OpenIntroduction(20801, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1003 then
        OpenIntroduction(21003, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1002 then
        OpenIntroduction(21002, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1101 then
        OpenIntroduction(21101, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1102 then
        OpenIntroduction(21102, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1103 then
        OpenIntroduction(21103, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1201 then
        OpenIntroduction(21201, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1202 then
        OpenIntroduction(21202, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1204 then
        OpenIntroduction(21204, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1301 then
        OpenIntroduction(21301, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1305 then
        OpenIntroduction(21305, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1401 then
        OpenIntroduction(21401, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1402 then
        OpenIntroduction(21402, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1403 then
        OpenIntroduction(21403, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1404 then
        OpenIntroduction(21404, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1405 then
        OpenIntroduction(21405, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1406 then
        OpenIntroduction(21406, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      elseif map_num == 1407 then
        OpenIntroduction(21407, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
      end
    end
    if map_prefix == "h" then
      OpenIntroduction(30201, MAP_NAME_DISPLAY_DELAY_FLAME, MAP_NAME_DISPLAY_FLAME)
    end
  end
end

function SetPlayerStealthFromSymbolEnemy(a_is_enable)
  Field.SetPlayerStealthFromSymbolEnemy(a_is_enable)
end

function CheckSymbolEnemySet(flag, a_is_effect)
  Flg.Set(flag)
  Field.CheckSymbolEnemyCondition(a_is_effect)
end

function CheckSymbolEnemyClear(flag, a_is_effect)
  Flg.Clear(flag)
  Field.CheckSymbolEnemyCondition(a_is_effect)
end

function IsSymbolDefeated(object_index)
  local Defeated_flg = false
  if type(object_index) == "table" then
    for i = 1, #object_index do
      if Field.IsSymbolDefeated(object_index[i]) == false then
        break
      end
    end
    if i == #object_index then
      Defeated_flg = true
    else
      Defeated_flg = false
    end
  else
    Defeated_flg = Field.IsSymbolDefeated(object_index)
  end
  return Defeated_flg
end

function CancelTheStealthAtStart()
  Field.CancelTheStealthAtStart()
end

function SymbolEnemyDiscoveryNumber(symbol_enemy_no)
  Field.SymbolEnemyDiscoveryNumber(symbol_enemy_no)
end

function EncountFromField(encount_id, battle_map_id, with_effect)
  Fade.Out(0, 0)
  Battle.Encount(encount_id, battle_map_id, with_effect)
end

function EncountFromField_PlaySound(encount_id, battle_map_id, with_effect)
  Fade.Out(0, 0)
  Sound.PlaySE(101006, 100)
  Battle.Encount(encount_id, battle_map_id, with_effect)
end

function EncountFromField_NormalEffect(encount_id, battle_map_id)
  Sound.PlaySE(101006, 100)
  StartEncountEffectNormal()
  WaitFrame(1)
  Battle.Encount(encount_id, battle_map_id, false)
end

function EncountFromField_FieldAttackEffect(encount_id, battle_map_id, center_x, center_y)
  Sound.PlaySE(101006, 100)
  Battle.SetEncountGlassEffectFA(center_x, center_y)
  WaitFrame(1)
  Battle.Encount(encount_id, battle_map_id, false)
end

function EncountFromField_NoiseEffect(encount_id, battle_map_id)
  Sound.PlaySE(101006, 100)
  StartEncountEffectNoise()
  Battle.Encount(encount_id, battle_map_id, false)
end

function EncountFromField_NoEffect(encount_id, battle_map_id)
  Battle.Encount(encount_id, battle_map_id, false)
end

function StartEncountEffectNormal()
  Battle.SetEncountGlassEffectNormal()
end

function StartEncountEffectFA(center_x, center_y)
  Battle.SetEncountGlassEffectFA(center_x, center_y)
end

function StartEncountEffectNoise()
  PostEffect.SetEncountBrightness(true, 1)
  PostEffect.SetGlitch(true, 0.02, 30, 20, 20, 0, false)
  WaitFrame(4)
  PostEffect.SetGlitch(true, 0.04, 30, 20, 20, 0, false)
  WaitFrame(2)
  PostEffect.SetEncountBrightness(true, 1.5)
  PostEffect.SetGlitch(true, 0.11, 30, 20, 20, 0, false)
  PostEffect.SetGlitchNoise(true, 1, 0.006, 0, 0, 0, 20, 23)
  WaitFrame(2)
  PostEffect.SetGlitch(true, 0.25, 30, 20, 20, 0, false)
  WaitFrame(20)
  Fade.Capture()
  WaitFrame(1)
  PostEffect.SetEncountBrightness(false, 1)
  PostEffect.SetGlitch(false, 0, 0, 0, 0, 0, false)
  PostEffect.SetGlitchNoise(false, 0, 0, 0, 0, 0, 0, 0)
end

function IsSettingRideDigimon(type)
  gim_text = "field_text"
  if type == RIDE_FLY then
    ride_type = Enum.DigimonRideTypeFlying()
    error_message = 2500
  elseif type == RIDE_JUMP then
    ride_type = Enum.DigimonRideTypeJump()
    error_message = 2502
  elseif type == RIDE_FALL then
    ride_type = Enum.DigimonRideTypeFall()
    error_message = 2501
  elseif type == RIDE_DECON then
    ride_type = Enum.DigimonRideTypeDecontamination()
    error_message = 2503
  end
  if Field.IsAvailablePlayerScriptDigimonRide(ride_type) ~= true then
    Field_Talk_Start(gim_text, 1)
    Message(error_message)
    Field_Talk_End()
    return false
  else
    return true
  end
end

function StartRideFly(is_start_effect, start_locator, cam_blend_frame)
  move_speed = 10
  ride_type = Enum.DigimonRideTypeFlying()
  Flg.Set("FLAG_IS_FLIGHT_RIDE")
  if Common.IsSettingWaitForRide() == true then
    Field.PlayerScriptDigimonRideStartWithWaitingDigimon(is_start_effect, start_locator, Util.SecondFromFrame(cam_blend_frame))
  else
    Field.PlayerScriptDigimonRideStart(ride_type, is_start_effect, start_locator, Util.SecondFromFrame(cam_blend_frame))
  end
  Field.PlayerFixedMaxSpeed(move_speed)
  while Field.IsPlayerDigimonRideGettingOnAndOff() do
    WaitFrame(Util.SecondFromFrame(1))
  end
end

function EndRide(is_end_effect, locator, cam_blend_frame)
  Field.PlayerScriptDigimonRideEnd(is_end_effect, locator, Util.SecondFromFrame(cam_blend_frame))
  Field.CancelPlayerFixedMaxSpeed()
  while Field.IsPlayerDigimonRideGettingOnAndOff() do
    WaitFrame(Util.SecondFromFrame(1))
  end
end

function StartRideFall(start_locator, goal_locator, goal_prifix, goal_map_num, cam_num)
  move_frame = 15
  rotate_frame = 10
  require("r02_010")
  local map_prefix, map_num = Field.GetMapPrefix(), Field.GetMapNumber()
  SetProhibitDigimonRide(true)
  SetPlayerRotationByLocator(start_locator, rotate_frame)
  r02_010(start_locator, cam_num)
  SetProhibitDigimonRide(false)
  if goal_prifix == map_prefix and goal_map_num == map_num then
    require("r02_020")
    SetPlayerLocator(goal_locator)
    r02_020(cam_num)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  else
    Flg.Set("FLAG_IS_MAPCHANGE_BY_FALL")
    Work.Set(Field_Fall_Cam_Num, cam_num)
    MapChange(goal_prifix, goal_map_num, goal_locator, false, 0, 0)
  end
end

function EndRideFall()
  require("r02_020")
  cam_num = Work.Get(Field_Fall_Cam_Num)
  r02_020(cam_num)
  Flg.Clear("FLAG_IS_MAPCHANGE_BY_FALL")
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
end

function StartRideJump(start_locator, goal_locator, grab_locator)
  rotate_frame = 0
  gim_text = "field_text"
  SetPlayerRotationToLocator(goal_locator, rotate_frame)
  require("r03_005")
  r03_005(grab_locator)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  SetProhibitDigimonRide(true)
  SetPlayerLocator(goal_locator)
  WaitFrame(1)
  Execute("r03_020")
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, false)
  SetProhibitDigimonRide(false)
end

function StartRideDecon(dirt_gim, dirt_col, position_locator)
  move_frame = 15
  rotate_frame = 10
  gim_text = "field_text"
  Field_Talk_Start(gim_text, 1)
  Message(2503)
  MessageTalkSel(2, 3520)
  result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Field_Talk_End()
    SetProhibitDigimonRide(true)
    SetPlayerRotationToLocator(dirt_gim, 10)
    require("r04_010")
    r04_010(position_locator)
    SetProhibitDigimonRide(false)
    Field.InvisibleGimmick(dirt_gim, 0, 0, false)
    ColOff(dirt_col)
  elseif result == RESULT_TALK01 then
    Field_Talk_End()
  end
end

function StartRideZip(locator_name, rail_id)
  require("r05_010")
  r05_010(locator_name)
  Flg.Set("FLAG_IS_ZIP")
  SetControlScriptExternalVariable("zip_rail", rail_id)
  SetControlScriptExternalVariable("player_state", "ride_zip_ready")
  Fade_In(0, 30)
end

function KeepRideZip(locator_name, rail_id)
  require("r05_010")
  Flg.Set("FLAG_IS_ZIP")
  SetControlScriptExternalVariable("zip_rail", rail_id)
  SetControlScriptExternalVariable("player_state", "ride_zip_ready")
end

function EndRideZip(locator_name)
  if Flg.Check("FLAG_IS_ZIP") == true then
    require("r05_020")
    r05_020(locator_name)
    SetControlScriptExternalVariable("player_state", "ride_zip_finish")
    Flg.Clear("FLAG_IS_ZIP")
  end
end

function SetProhibitDigimonRide(is_prohibit)
  Field.SetProhibitDigimonRide(is_prohibit)
  if Field.IsPlayerDigimonRideGettingOnAndOff() then
    WaitFrame(30)
  end
end

function CancelPlayerAnywhereDigimonRide()
  Field.CancelPlayerAnywhereDigimonRide(false, true)
end

function SetControlScriptExternalVariable(name, value)
  Field.SetControlScriptExternalVariable(name, value)
end

function ExistControlScriptExternalVariable(name)
  return Field.ExistControlScriptExternalVariable(name)
end

function GetControlScriptExternalVariableNumber(name)
  if ExistControlScriptExternalVariable(name) then
    print("====== SUCCESS VariableNumber exist ======")
    return Field.GetControlScriptExternalVariableNumber(name)
  else
    print("====== FAILED VariableNumber dont exist ====== ")
  end
end

function GetControlScriptExternalVariableBool(name)
  if ExistControlScriptExternalVariable(name) then
    print("====== SUCCESS VariableBool exist ======")
    return Field.GetControlScriptExternalVariableBool(name)
  else
    print("====== FAILED VariableBool dont exist ====== ")
  end
end

function GetControlScriptExternalVariableString(name)
  if ExistControlScriptExternalVariable(name) then
    print("====== SUCCESS VariableString exist ======")
    return Field.GetControlScriptExternalVariableString(name)
  else
    print("====== FAILED VariableString dont exist ====== ")
  end
end

function GetControlScriptExternalVariable(name, variable)
  if variable == "boolean" then
    return GetControlScriptExternalVariableBool(name)
  elseif variable == "number" then
    return GetControlScriptExternalVariableNumber(name)
  elseif variable == "string" then
    return GetControlScriptExternalVariableString(name)
  else
    print("====== FAILED VariableEroor dont exist ====== ")
  end
end

function GetUnitVector2D(y_degree)
  return Field.GetUnitVector2D(y_degree)
end

function GetAngleToTarget2D(current_x, current_z, target_x, target_z)
  return Field.GetAngleToTarget2D(current_x, current_z, target_x, target_z)
end

function CommonShopStart(npc_name, shop_id, enter_mot, buy_mot, sell_mot, cam_npc, cam_shop, default_mot, exit_mot)
  SetControlScriptExternalVariable("player_state", "shopping")
  SetControlScriptExternalVariable("shop_name", npc_name)
  SetControlScriptExternalVariable("shop_dist_adjust", dist_adjust)
  if exit_mot == nil then
    exit_mot = enter_mot
  end
  local npc_index = GetIndex(NPC, npc_name)
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
  local message2 = "g_shop" .. string.format("%03d", shop_id) .. "_0020_0010"
  local message3 = "g_shop" .. string.format("%03d", shop_id) .. "_0030_0010"
  local message4 = "g_shop" .. string.format("%03d", shop_id) .. "_0040_0010"
  Obj:new(PLAYER, ""):Invisible(10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field.HideGuide(true)
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, enter_mot, 10, 10)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  Message(message1)
  Talk.Close()
  Cam.Inst:Set(cam_shop[1], cam_shop[2], cam_shop[3], cam_shop[4], cam_shop[5], cam_shop[6], default, 20)
  Shop.Open(shop_id)
  WaitFrame(1)
  while not Shop.IsClosed() do
    local money = Common.GetMoney()
    WaitFrame(1)
    if Shop.IsDealDone() then
      Shop.ResetDeal()
      if Shop.GetDealType() == 0 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, buy_mot, 10, 10)
        Shop.Message(message3)
      elseif Shop.GetDealType() == 1 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, sell_mot, 10, 10)
        Shop.Message(message4)
      end
    end
    if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
      Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
    end
  end
  ShopClose()
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  WaitFrame(15)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, exit_mot, 10, 10)
  Message(message2)
  Field_Talk_End_Not_LetterBox()
  Field.HideGuide(false)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Cam.Inst:Clear(30)
  if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
    Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
  end
  Field.ObjectCancelSuspendAutoTransparentForCamera(NPC, npc_index)
  Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
  SetControlScriptExternalVariable("player_state", "Initialize")
  SetControlScriptExternalVariable("shop_name", nil)
  SetControlScriptExternalVariable("shop_dist_adjust", nil)
end

function DevelopShopStart(npc_name, shop_id, enter_mot, buy_mot, sell_mot, cam_npc, cam_shop, default_mot, exit_mot)
  SetControlScriptExternalVariable("player_state", "shopping")
  SetControlScriptExternalVariable("shop_name", npc_name)
  SetControlScriptExternalVariable("shop_dist_adjust", dist_adjust)
  if exit_mot == nil then
    exit_mot = enter_mot
  end
  local npc_index = GetIndex(NPC, npc_name)
  Field.ObjectLoadMotion(NPC, npc_index, enter_mot)
  Field.ObjectLoadMotion(NPC, npc_index, buy_mot)
  Field.ObjectLoadMotion(NPC, npc_index, sell_mot)
  Field.ObjectLoadMotion(NPC, npc_index, exit_mot)
  Field.ObjectLoadMotion(NPC, npc_index, "bn01")
  if default_mot ~= nil then
    if npc_name == "shop_0004" then
      local zudo_index_2 = GetIndex(NPC, "shop_0004")
      local shop_0004 = Motion.Object:new(NPC, "shop_0004", "f000")
      Field.ObjectLoadMotion(NPC, npc_index, default_mot)
    else
      Field.ObjectLoadMotion(NPC, npc_index, default_mot)
    end
  end
  Field.ObjectSuspendAutoTransparentForCamera(NPC, npc_index)
  local message1 = "g_shop" .. string.format("%03d", shop_id) .. "_0010_0010"
  local message2 = "g_shop" .. string.format("%03d", shop_id) .. "_0020_0010"
  local message3 = "g_shop" .. string.format("%03d", shop_id) .. "_0030_0010"
  local message4 = "g_shop" .. string.format("%03d", shop_id) .. "_0040_0010"
  local MapPrefix, MapNum = Field.GetMapPrefix(), Field.GetMapNumber()
  if MapPrefix == "d" and MapNum == 201 then
    if npc_name == "npc_703" then
      message1 = "g_shop151_0010_0010"
      message2 = "g_shop151_0020_0010"
      message3 = "g_shop151_0030_0010"
      message4 = "g_shop151_0040_0010"
    end
  elseif MapPrefix == "d" and MapNum == 217 then
    if npc_name == "shop_0001" then
      message1 = "g_shop151_0010_0010"
      message2 = "g_shop151_0020_0010"
      message3 = "g_shop151_0030_0010"
      message4 = "g_shop151_0040_0010"
    end
  elseif MapPrefix == "d" and MapNum == 501 and npc_name == "developshop_001" then
    message1 = "g_shop152_0110_0010"
    message2 = "g_shop152_0120_0010"
    message3 = "g_shop152_0130_0010"
    message4 = "g_shop152_0140_0010"
  end
  Obj:new(PLAYER, ""):Invisible(10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field.HideGuide(true)
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, enter_mot, 10, 10)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  if MapPrefix == "d" and MapNum == 501 and npc_name == "developshop_001" and not Flg.Check("FLAG_FIELD_D05_IS_EVELOPSHOP_FIRSTTALK") then
    Message("g_shop152_0110_0005")
    Message("g_shop152_0110_0006")
    Flg.Set("FLAG_FIELD_D05_IS_EVELOPSHOP_FIRSTTALK")
  end
  Message(message1)
  Talk.Close()
  Cam.Inst:Set(cam_shop[1], cam_shop[2], cam_shop[3], cam_shop[4], cam_shop[5], cam_shop[6], default, 20)
  Develop.OpenDevelop(shop_id)
  WaitFrame(1)
  while not Develop.IsClosedDevelop() do
    local money = Common.GetMoney()
    WaitFrame(1)
    if Shop.IsDealDone() then
      Shop.ResetDeal()
      if Shop.GetDealType() == 0 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, buy_mot, 10, 10)
        Shop.Message(message3)
      elseif Shop.GetDealType() == 1 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, sell_mot, 10, 10)
        Shop.Message(message4)
      end
    end
    if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
      if npc_name == "shop_0004" then
        local zudo_index_2 = GetIndex(NPC, "shop_0004")
        local shop_0004 = Motion.Object:new(NPC, "shop_0004", "f000")
        Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
      else
        Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
      end
    end
  end
  ShopClose()
  if npc_name == "shop_0004" then
    local zudo_index_2 = GetIndex(NPC, "shop_0004")
    local shop_0004 = Motion.Object:new(NPC, "shop_0004", "f000")
  end
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  WaitFrame(15)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, exit_mot, 10, 10)
  Message(message2)
  Field_Talk_End_Not_LetterBox()
  Field.HideGuide(false)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Cam.Inst:Clear(30)
  if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
    Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
  end
  Field.ObjectCancelSuspendAutoTransparentForCamera(NPC, npc_index)
  Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
  SetControlScriptExternalVariable("player_state", "Initialize")
  SetControlScriptExternalVariable("shop_name", nil)
  SetControlScriptExternalVariable("shop_dist_adjust", nil)
end

function DevelopShopStart_OnlySub(npc_name, shop_id, enter_mot, buy_mot, sell_mot, cam_npc, cam_shop, default_mot, exit_mot)
  SetControlScriptExternalVariable("player_state", "shopping")
  SetControlScriptExternalVariable("shop_name", npc_name)
  SetControlScriptExternalVariable("shop_dist_adjust", dist_adjust)
  if exit_mot == nil then
    exit_mot = enter_mot
  end
  local npc_index = GetIndex(NPC, npc_name)
  Field.ObjectLoadMotion(NPC, npc_index, enter_mot)
  Field.ObjectLoadMotion(NPC, npc_index, buy_mot)
  Field.ObjectLoadMotion(NPC, npc_index, sell_mot)
  Field.ObjectLoadMotion(NPC, npc_index, exit_mot)
  Field.ObjectLoadMotion(NPC, npc_index, "bn01")
  local zudo_index_2 = GetIndex(NPC, "shop_0004")
  local shop_0004 = Motion.Object:new(NPC, "shop_0004", "f000")
  if default_mot ~= nil then
    if npc_name == "shop_0004" then
      Field.ObjectLoadMotion(NPC, npc_index, default_mot)
    else
      Field.ObjectLoadMotion(NPC, npc_index, default_mot)
    end
  end
  Field.ObjectSuspendAutoTransparentForCamera(NPC, npc_index)
  local message1 = "g_shop" .. string.format("%03d", shop_id) .. "_0010_0010"
  local message2 = "g_shop" .. string.format("%03d", shop_id) .. "_0020_0010"
  local message3 = "g_shop" .. string.format("%03d", shop_id) .. "_0030_0010"
  local message4 = "g_shop" .. string.format("%03d", shop_id) .. "_0040_0010"
  Obj:new(PLAYER, ""):Invisible(10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field.HideGuide(true)
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  Cam.Inst:Set(cam_shop[1], cam_shop[2], cam_shop[3], cam_shop[4], cam_shop[5], cam_shop[6], default, 20)
  Develop.OpenDevelop(shop_id)
  WaitFrame(1)
  while not Develop.IsClosedDevelop() do
    local money = Common.GetMoney()
    WaitFrame(1)
    if Shop.IsDealDone() then
      Shop.ResetDeal()
      if Shop.GetDealType() == 0 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, buy_mot, 10, 10)
        Shop.Message(message3)
      elseif Shop.GetDealType() == 1 then
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, sell_mot, 10, 10)
        Shop.Message(message4)
      end
    end
    if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
      if npc_name == "shop_0004" then
        Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
      else
        Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
      end
    end
  end
  ShopClose()
  if npc_name == "shop_0004" then
  end
  Cam.Inst:Set(cam_npc[1], cam_npc[2], cam_npc[3], cam_npc[4], cam_npc[5], cam_npc[6], default, 20)
  Field_Talk_End_Not_LetterBox()
  Field.HideGuide(false)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Cam.Inst:Clear(30)
  if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "bn01") == true then
    Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
  end
  Field.ObjectCancelSuspendAutoTransparentForCamera(NPC, npc_index)
  SetControlScriptExternalVariable("player_state", "Initialize")
  SetControlScriptExternalVariable("shop_name", nil)
  SetControlScriptExternalVariable("shop_dist_adjust", nil)
end

function CommonShopStart_NoZoomCam(npc_name, shop_id, enter_mot, buy_mot, sell_mot, default_mot)
  SetControlScriptExternalVariable("player_state", "shopping")
  SetControlScriptExternalVariable("shop_name", npc_name)
  SetControlScriptExternalVariable("shop_dist_adjust", dist_adjust)
  local npc_index = GetIndex(NPC, npc_name)
  Field.ObjectLoadMotion(NPC, npc_index, enter_mot)
  Field.ObjectLoadMotion(NPC, npc_index, buy_mot)
  Field.ObjectLoadMotion(NPC, npc_index, sell_mot)
  if shop_id == 166 or shop_id == 167 or shop_id == 168 or shop_id == 169 or shop_id == 170 or shop_id == 171 then
    Field.ObjectLoadMotion(NPC, npc_index, "bn01")
  else
    Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  end
  if default_mot ~= nil then
    Field.ObjectLoadMotion(NPC, npc_index, default_mot)
  end
  Field.ObjectSuspendAutoTransparentForCamera(NPC, npc_index)
  local message1 = "g_shop" .. string.format("%03d", shop_id) .. "_0010_0010"
  local message2 = "g_shop" .. string.format("%03d", shop_id) .. "_0020_0010"
  local message3 = "g_shop" .. string.format("%03d", shop_id) .. "_0030_0010"
  local message4 = "g_shop" .. string.format("%03d", shop_id) .. "_0040_0010"
  if shop_id == 91 or shop_id == 92 or shop_id == 93 or shop_id == 94 or shop_id == 95 then
    message1 = "g_shop099_0010_0010"
    message2 = "g_shop099_0020_0010"
    message3 = "g_shop099_0030_0010"
    message4 = "g_shop099_0040_0010"
  end
  if shop_id == 166 or shop_id == 167 or shop_id == 168 or shop_id == 169 or shop_id == 170 or shop_id == 171 then
    message1 = "g_shop166_0010_0010"
    message2 = "g_shop166_0020_0010"
    message3 = "g_shop166_0030_0010"
    message4 = "g_shop166_0040_0010"
  end
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field_InvisibleMob(FOR_ALL, 10, 10, true, false)
  Field.HideGuide(true)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, enter_mot, 10, 10)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
  Message(message1)
  Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  Talk.Close()
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_rot = Field.ObjectGetRotationY(NPC, npc_index)
  local vector2d = Field.GetUnitVector2D(npc_rot + 150)
  local aim_x = npc_pos.x + vector2d.x * 2
  local aim_y = npc_pos.y + 1.2
  local aim_z = npc_pos.z + vector2d.z * 1
  local vector2d = Field.GetUnitVector2D(npc_rot + 30)
  local cam_x = npc_pos.x + vector2d.x * 2
  local cam_y = npc_pos.y + 1.5
  local cam_z = npc_pos.z + vector2d.z * 1
  if shop_id == 166 or shop_id == 168 or shop_id == 169 or shop_id == 171 then
    vector2d = Field.GetUnitVector2D(npc_rot + 150)
    aim_x = npc_pos.x + vector2d.x * 1
    aim_y = npc_pos.y + 0.6
    aim_z = npc_pos.z + vector2d.z * 1.75
    vector2d = Field.GetUnitVector2D(npc_rot + 30)
    cam_x = npc_pos.x + vector2d.x * 1
    cam_y = npc_pos.y + 0.9
    cam_z = npc_pos.z + vector2d.z * 1.75
  elseif shop_id == 167 then
    aim_x = 37.666
    aim_y = 2.966
    aim_z = 75.874
    cam_x = 44.326
    cam_y = 3.858
    cam_z = 68.469
  elseif shop_id == 170 then
    aim_x = -28.519
    aim_y = 4.971
    aim_z = 131.032
    cam_x = -18.639
    cam_y = 4.813
    cam_z = 129.491
  end
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 30)
  Field.ObjectResetAim(NPC, npc_index, 10)
  Obj:new(PLAYER, ""):Invisible(10)
  WaitFrame(15)
  if shop_id == 154 or shop_id == 166 or shop_id == 167 or shop_id == 168 or shop_id == 169 or shop_id == 170 or shop_id == 171 then
    Develop.OpenDevelop(shop_id)
    WaitFrame(1)
    while not Develop.IsClosedDevelop() do
      local money = Common.GetMoney()
      WaitFrame(1)
      if Shop.IsDealDone() then
        Shop.ResetDeal()
        if Shop.GetDealType() == 0 then
          Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, buy_mot, 10, 10)
          Shop.Message(message3)
        elseif Shop.GetDealType() == 1 then
          Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, sell_mot, 10, 10)
          Shop.Message(message4)
        end
      end
      if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "fn01_01") == true then
        Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      end
    end
    ShopClose()
  else
    Shop.Open(shop_id)
    WaitFrame(1)
    while not Shop.IsClosed() do
      local money = Common.GetMoney()
      WaitFrame(1)
      if Shop.IsDealDone() then
        Shop.ResetDeal()
        if Shop.GetDealType() == 0 then
          Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, buy_mot, 10, 10)
          Shop.Message(message3)
        elseif Shop.GetDealType() == 1 then
          Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, sell_mot, 10, 10)
          Shop.Message(message4)
        end
      end
      if default_mot ~= nil and Field.ObjectIsPlayingMotion(NPC, npc_index, "fn01_01") == true then
        Field.ObjectPlayMotion(NPC, npc_index, default_mot, 10, true)
        Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      end
    end
    ShopClose()
  end
  Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
  Message(message2)
  Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
  Field_Talk_End_Not_LetterBox()
  Field.HideGuide(false)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Cam.Inst:Clear(30)
  Field.ObjectCancelSuspendAutoTransparentForCamera(NPC, npc_index)
  Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
  Field_CancelInvisibleMob(FOR_ALL, 10, 20, true, false)
  SetControlScriptExternalVariable("player_state", "Initialize")
  SetControlScriptExternalVariable("shop_name", nil)
  SetControlScriptExternalVariable("shop_dist_adjust", nil)
end

function ShopkeeperCam(npc_name, shop_id, aim_hight, cam_hight, cam_distanceX, cam_distanceY)
  local npc_index = Field.GetNpcIndex(npc_name)
  local npc_pos = Field.ObjectGetPosition(FLD_OBJ_NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  local vector2d = Field.GetUnitVector2D(npc_degree)
  local aim_x = npc_pos.x + -0.5
  local aim_y = npc_pos.y + aim_hight
  local aim_z = npc_pos.z
  local cam_x = npc_pos.x + vector2d.x * cam_distanceX
  local cam_y = npc_pos.y + cam_hight
  local cam_z = npc_pos.z + vector2d.z * cam_distanceY
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 20)
end

function ShopUICam(npc_name, shop_id, aim_hight, cam_hight, aim_distanceX, aim_distanceY, cam_distanceX, cam_distanceY)
  local npc_index = Field.GetNpcIndex(npc_name)
  local npc_pos = Field.ObjectGetPosition(FLD_OBJ_NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  local vector2d = Field.GetUnitVector2D(npc_degree)
  local vector2d_2 = Field.GetUnitVector2D(npc_degree + 160)
  local aim_x = npc_pos.x + -0.5 + vector2d_2.x * aim_distanceX
  local aim_y = npc_pos.y + aim_hight
  local aim_z = npc_pos.z + vector2d_2.z * aim_distanceY
  local cam_x = npc_pos.x + vector2d.x * cam_distanceX
  local cam_y = npc_pos.y + cam_hight
  local cam_z = npc_pos.z + vector2d.z * cam_distanceY
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 20)
end

function ShopOpenTypeEnter(enter_player_state, exit_player_state, shop_number)
  SetControlScriptExternalVariable("player_state", enter_player_state)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  while GetControlScriptExternalVariableString("player_state") ~= "shopping" do
    WaitFrame(1)
  end
  local message1 = "g_shop" .. string.format("%03d", shop_number) .. "_0010_0010"
  local message2 = "g_shop" .. string.format("%03d", shop_number) .. "_0020_0010"
  local message3 = "g_shop" .. string.format("%03d", shop_number) .. "_0030_0010"
  local message4 = "g_shop" .. string.format("%03d", shop_number) .. "_0040_0010"
  Field.HideGuide(true)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  Message(message1)
  Talk.Close()
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Shop.Open(shop_number)
  WaitFrame(1)
  while not Shop.IsClosed() do
    local money = Common.GetMoney()
    WaitFrame(1)
    if Shop.IsDealDone() then
      Shop.ResetDeal()
      if Shop.GetDealType() == 0 then
        Shop.Message(message3)
      elseif Shop.GetDealType() == 1 then
        Shop.Message(message4)
      end
    end
  end
  ShopClose()
  Message(message2)
  Field_Talk_End_Not_LetterBox()
  Field.HideGuide(false)
  SetControlScriptExternalVariable("player_state", exit_player_state)
  while GetControlScriptExternalVariableString("player_state") ~= "exit" do
    WaitFrame(1)
  end
  SetControlScriptExternalVariable("player_state", "initialize")
  Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
end

function ShopConvenienceStore(shop_id, npc_name, enter_mot, dealings_mot)
  local npc_index = GetIndex(NPC, npc_name)
  Field.ObjectLoadMotion(NPC, npc_index, enter_mot)
  Field.ObjectLoadMotion(NPC, npc_index, dealings_mot)
  local message1 = "g_shop" .. string.format("%03d", shop_id) .. "_0010_0010"
  local message2 = "g_shop" .. string.format("%03d", shop_id) .. "_0020_0010"
  local message3 = "g_shop" .. string.format("%03d", shop_id) .. "_0030_0010"
  local message4 = "g_shop" .. string.format("%03d", shop_id) .. "_0040_0010"
  if shop_id == 2 then
    message1 = "g_shop001_0010_0010"
    message2 = "g_shop001_0020_0010"
    message3 = "g_shop001_0030_0010"
    message4 = "g_shop001_0040_0010"
  end
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field.HideGuide(true)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, enter_mot, 10, 10)
  Field_Talk_Start_Not_LetterBox("field_text", 1)
  Message(message1)
  Talk.Close()
  Shop.Open(shop_id)
  WaitFrame(1)
  while not Shop.IsClosed() do
    local money = Common.GetMoney()
    WaitFrame(1)
    if Shop.IsDealDone() then
      Shop.ResetDeal()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, dealings_mot, 10, 10)
      if Shop.GetDealType() == 0 then
        Shop.Message(message3)
      elseif Shop.GetDealType() == 1 then
        Shop.Message(message4)
      end
    end
  end
  ShopClose()
  Message(message2)
  MessageClose()
  TalkExit()
end

function StartShop(npc_name, shop_id, aimY_adjust, camDist_adjust, dist_adjust)
  SetControlScriptExternalVariable("player_state", "shopping")
  SetControlScriptExternalVariable("shop_name", npc_name)
  SetControlScriptExternalVariable("shop_dist_adjust", dist_adjust)
  SetShopCam(npc_name, aimY_adjust, camDist_adjust)
  Shop.Open(shop_id)
  Obj:new(PLAYER, ""):Invisible(10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
end

function EndShop()
  ShopClose()
  SetControlScriptExternalVariable("player_state", "Initialize")
  SetControlScriptExternalVariable("shop_name", nil)
  SetControlScriptExternalVariable("shop_dist_adjust", nil)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Cam.Inst:Clear(30)
end

function OpenArena(id, npc_name, enter_mot, exit_mot)
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_rot = Field.ObjectGetRotationY(NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, enter_mot)
  Field.ObjectLoadMotion(NPC, npc_index, exit_mot)
  Field.ObjectLoadMotion(NPC, npc_index, "bn01")
  Field.ObjectLoadMotion(NPC, npc_index, "f000")
  Field.ObjectLoadMotion(NPC, npc_index, "fe02")
  Field.ObjectLoadMotion(NPC, npc_index, "fe04")
  Field.ObjectLoadMotion(NPC, npc_index, "fq01")
  Field.ObjectLoadMotion(NPC, npc_index, "bv01")
  Obj:new(PLAYER, ""):Invisible(10)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  local vector2d = Field.GetUnitVector2D(npc_rot)
  local aim_x = npc_pos.x + vector2d.x * 1
  local aim_y = npc_pos.y + 1.5
  local aim_z = npc_pos.z + vector2d.z * 1
  local vector2d = Field.GetUnitVector2D(npc_rot)
  local cam_x = npc_pos.x + vector2d.x * 3
  local cam_y = npc_pos.y + 2
  local cam_z = npc_pos.z + vector2d.z * 3
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 30)
  WaitFrame(30)
  if Flg.Check("FLAG_FREEARENA_FIRSTTALK_01") then
    Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, enter_mot, 10, 10)
    WaitFrame(15)
  end
  local tlk = Tlk:new("d05", 1, false)
  tlk:StartTalk()
  if id == 1 then
    local releasecount = ArenaCheckRelease()
    local wincount = ArenaCheckWin()
    if not Flg.Check("FLAG_FREEARENA_FIRSTTALK_01") then
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "f000", 10, 10)
      tlk:Message("f_d0506_0200_0010")
      tlk:Message("f_d0506_0200_0011")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      tlk:Message("f_d0506_0200_0012")
      tlk:Message("f_d0506_0200_0013")
      tlk:Message("f_d0506_0200_0014")
      tlk:Message("f_d0506_0200_0015")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe04", 10, 10)
      tlk:Message("f_d0506_0200_0016")
      Flg.Set("FLAG_FREEARENA_FIRSTTALK_01")
    elseif 23 <= wincount then
      tlk:Message("f_d0506_0200_0050")
    elseif Flg.Check("FLAG_FREEARENA_RELEASE_018") and not Flg.Check("FLAG_FREEARENA_WIN_018") then
      tlk:Message("f_d0506_0200_0040")
      tlk:Message("f_d0506_0200_0041")
    elseif releasecount < 23 and 0 < wincount and releasecount == wincount then
      tlk:Message("f_d0506_0200_0030")
    else
      tlk:Message("f_d0506_0200_0020")
    end
  end
  tlk:MessageClose()
  vector2d = Field.GetUnitVector2D(npc_rot + 90)
  aim_x = npc_pos.x + vector2d.x * 1.3
  aim_y = npc_pos.y + 1.5
  aim_z = npc_pos.z + vector2d.z * 1.3
  vector2d = Field.GetUnitVector2D(npc_rot + 10)
  cam_x = npc_pos.x + vector2d.x * 2.6
  cam_y = npc_pos.y + 2
  cam_z = npc_pos.z + vector2d.z * 2.6
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 30)
  WaitFrame(30)
  Field.OpenArenaMenu()
  while not Field.IsClosedArenaMenu() do
    WaitFrame(1)
  end
  if Field.IsCanceledArenaMenu() then
    require("Sarena_300")
    Sarena_300:GreatestOmegaCarnival_Entry()
  elseif Field.IsChallengingArena() then
    Field.EndArenaMenu()
    Flg.Set("FLAG_FIELD_ARENA01_STARTBATTLE")
    Flg.Set("FLAG_IS_NOT_MAP_NAME_DISP")
    MapChange("d", 513, "start_00", true, FADE_BLACK, FADE_TIME)
  end
  Field.EndArenaMenu()
  local vector2d = Field.GetUnitVector2D(npc_rot)
  local aim_x = npc_pos.x + vector2d.x * 1
  local aim_y = npc_pos.y + 1.5
  local aim_z = npc_pos.z + vector2d.z * 1
  local vector2d = Field.GetUnitVector2D(npc_rot)
  local cam_x = npc_pos.x + vector2d.x * 3
  local cam_y = npc_pos.y + 2
  local cam_z = npc_pos.z + vector2d.z * 3
  tlk:EndTalk()
  Cam.Inst:Clear(30)
  Obj:new(PLAYER, ""):CancelInvisible(10)
  Field_CancelInvisibleFollowerAllPartyMember(0, 20, false, false)
  Field_CancelInvisibleFollowerAllGuest(0, 20, false, false)
end

function GetArenaReward()
  if Flg.Check("FLAG_FIELD_ARENA01_GETREWARD") then
    WaitFrame(30)
    local npc_name = "npc_0001"
    local npc_index = GetIndex(NPC, npc_name)
    Field.ObjectLoadMotion(NPC, npc_index, "fe02")
    if not Flg.Check("FLAG_FREEARENA_GREETINGSKIP_01") then
      local tlk = Tlk:new("d05", 1, false)
      tlk:StartTalk()
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "fe02", 10, 10)
      WaitFrame(15)
      tlk:Message("f_d0506_0200_0070")
      if Qst.Sub:Check(111, 15, 20) and Flg.Check("FLAG_SUB_110_111_003") then
        tlk:EndTalk(true)
      else
        tlk:EndTalk()
      end
    else
      FadeAllInWithWait(FADE_BLACK, FADE_TIME)
      WaitFrame(15)
    end
    require("Sarena_300")
    Sarena_300:GreatestOmegaCarnival_Entry()
    Flg.Clear("FLAG_FIELD_ARENA01_GETREWARD")
    Flg.Clear("FLAG_FIELD_ARENA01_STARTBATTLE")
    Flg.Clear("FLAG_FREEARENA_GREETINGSKIP_01")
    Field.ArenaGetReward()
  end
end

function SetArenaBattle()
  if Flg.Check("FLAG_FIELD_ARENA01_STARTBATTLE") then
    if Field.ArenaCanStartAfterBattle() then
      Flg.Set("FLAG_FIELD_ARENA01_GETREWARD")
      Flg.Clear("FLAG_IS_NOT_MAP_NAME_DISP")
      Field.ArenaStartAfterBattle()
    elseif Field.IsChallengingArena() then
      Field.ArenaStartBattle()
    end
  end
end

function InvisibleNpcInArena()
  local npc_num = Field.GetObjectExistsNum(NPC)
  for index_num = 1, npc_num do
    local npc_name = Field.ObjectGetUniqueName(NPC, index_num)
    Obj:new(NPC, npc_name):Invisible()
  end
end

function AddChallengerNotice(is_theater)
  local is_notify = true
  if is_theater == true and not Flg.Check("FLAG_IS_USED_REGULAR_ROUTE_TO_THEATER") then
    is_notify = false
  end
  if Flg.Check("FLAG_MAIN_12_055") and not Flg.Check("FLAG_FREEARENA_RELEASE_001") then
    Flg.Set("FLAG_FREEARENA_RELEASE_001")
    Flg.Set("FLAG_FREEARENA_RELEASE_002")
    Flg.Set("FLAG_FREEARENA_RELEASE_003")
    Flg.Set("FLAG_FREEARENA_RELEASE_004")
  end
  if Flg.Check("FLAG_MAIN_18_055") and not Flg.Check("FLAG_FREEARENA_RELEASE_010") then
    Flg.Set("FLAG_FREEARENA_RELEASE_010")
  end
  if Flg.Check("FLAG_MAIN_19_066") and not Flg.Check("FLAG_FREEARENA_RELEASE_011") then
    Flg.Set("FLAG_FREEARENA_RELEASE_011")
  end
  if Flg.Check("FLAG_OPEN_TIMEJUMP") and not Flg.Check("FLAG_FREEARENA_RELEASE_015") then
    Flg.Set("FLAG_FREEARENA_RELEASE_015")
    Flg.Set("FLAG_FREEARENA_RELEASE_013")
    Flg.Set("FLAG_FREEARENA_RELEASE_014")
  end
  if Flg.Check("FLAG_MAIN_22_445") and not Flg.Check("FLAG_FREEARENA_RELEASE_012") then
    Flg.Set("FLAG_FREEARENA_RELEASE_012")
  end
  if is_notify == true then
    if Flg.Check("FLAG_FREEARENA_RELEASE_005") then
      Digitter.Send(7010050)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_006") then
      Digitter.Send(7010060)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_007") then
      Digitter.Send(7010070)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_008") then
      Digitter.Send(7010080)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_009") then
      Digitter.Send(7010090)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_010") then
      Digitter.Send(7010100)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_011") then
      Digitter.Send(7010110)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_012") then
      Digitter.Send(7010120)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_013") then
      Digitter.Send(7010130)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_014") then
      Digitter.Send(7010140)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_015") then
      Digitter.Send(7010150)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_016") then
      Digitter.Send(7010160)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_017") then
      Digitter.Send(7010170)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_019") then
      Digitter.Send(7010190)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_020") then
      Digitter.Send(7010200)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_021") then
      Digitter.Send(7010210)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_022") then
      Digitter.Send(7010220)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_023") then
      Digitter.Send(7010230)
    end
    if Flg.Check("FLAG_FREEARENA_RELEASE_018") then
      Digitter.Send(7010180)
      require("Sarena_300")
      Sarena_300:GreatestOmegaCarnival_AppearMarusmon()
    end
  end
end

function ArenaCheckWin()
  local wincount = 0
  local flag_name = ""
  for flag_no = 1, 23 do
    flag_name = "FLAG_FREEARENA_WIN_" .. string.format("%03d", flag_no)
    if Flg.Check(flag_name) then
      wincount = wincount + 1
    end
  end
  if 1 <= wincount then
    Flg.Set("FLAG_FREEARENA_RELEASE_005")
  end
  if 2 <= wincount then
    Flg.Set("FLAG_FREEARENA_RELEASE_006")
  end
  if 3 <= wincount then
    Flg.Set("FLAG_FREEARENA_RELEASE_007")
  end
  if 4 <= wincount then
    Flg.Set("FLAG_FREEARENA_RELEASE_008")
  end
  if 8 <= wincount then
    Flg.Set("FLAG_FREEARENA_RELEASE_009")
  end
  if 22 <= wincount and Flg.Check("FLAG_IS_CLEAR_S040_160") then
    Flg.Set("FLAG_FREEARENA_RELEASE_018")
  end
  if Flg.Check("FLAG_FREEARENA_WIN_013") and Flg.Check("FLAG_FREEARENA_WIN_014") and Flg.Check("FLAG_FREEARENA_WIN_015") then
    Flg.Set("FLAG_FREEARENA_RELEASE_016")
  end
  return wincount
end

function ArenaCheckRelease()
  local releasecount = 0
  local flag_name = ""
  for flag_no = 1, 23 do
    flag_name = "FLAG_FREEARENA_RELEASE_" .. string.format("%03d", flag_no)
    if Flg.Check(flag_name) then
      releasecount = releasecount + 1
    end
  end
  return releasecount
end

Obj = {}

function Obj:new(object_type, unique_name, follower)
  local obj = {}
  obj.type = object_type
  obj.name = unique_name
  if obj.type == ENEMY and type(unique_name) == "number" then
    print("##### enemy process #####")
    obj.index = unique_name
    obj.name = Field.ObjectGetUniqueName(ENEMY, obj.index)
  elseif type(unique_name) == "string" then
    obj.index = GetIndex(obj.type, obj.name)
  elseif type(unique_name) == "number" and follower ~= nil then
    obj.index = GetIndex(object_type, follower, unique_name)
  end
  if obj.index == nil then
    return {}
  end
  obj.tag = Field.ObjectGetTag(obj.type, obj.index)
  obj.pos = Field.ObjectGetPosition(obj.type, obj.index)
  obj.nowpos = Field.ObjectGetPosition(obj.type, obj.index)
  obj.rot_y = Field.ObjectGetRotationY(obj.type, obj.index)
  obj.vec = Field.GetUnitVector2D(obj.rot_y)
  
  function obj:SetRotationY(y_degree, frame)
    y_degree = y_degree or 0
    Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
  end
  
  function obj:SetRotationYFromposition(pos_x, pos_z, frame)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, pos_x, pos_z)
    Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
  end
  
  function obj:SetObjRotation(object_type, unique_name, blend_frame)
    local obj_ = Obj:new(object_type, unique_name)
    blend_frame = blend_frame or 20
    local self_pos = Field.ObjectGetPosition(self.type, self.index)
    local rotate = Field.GetAngleToTarget2D(self_pos.x, self_pos.z, obj_.pos.x, obj_.pos.z)
    Field.ObjectLookAtTheObject(self.type, self.index, object_type, obj_.index, math.floor(blend_frame / 2))
    Field.ObjectSetRotationY(self.type, self.index, rotate, blend_frame)
  end
  
  function obj:SetObjRotationWithCamera(object_type, unique_name, blend_frame)
    local obj_ = Obj:new(object_type, unique_name)
    blend_frame = blend_frame or 20
    local self_pos = Field.ObjectGetPosition(self.type, self.index)
    local rotate = Field.GetAngleToTarget2D(self_pos.x, self_pos.z, obj_.pos.x, obj_.pos.z)
    Field.ObjectLookAtTheObject(self.type, self.index, object_type, obj_.index, math.floor(blend_frame / 2))
    Field.ObjectSetRotationY(self.type, self.index, rotate, blend_frame)
    Cam.Follower:ResetFromObject(object_type, unique_name, blend_frame)
  end
  
  function obj:SetRotationX(x_degree, frame)
    x_degree = x_degree or 0
    Field.ObjectSetRotationX(self.type, self.index, x_degree, frame)
  end
  
  function obj:SetRotationZ(z_degree, frame)
    z_degree = z_degree or 0
    Field.ObjectSetRotationZ(self.type, self.index, z_degree, frame)
  end
  
  function obj:SetRotationYToPlayer(frame)
    frame = frame or 0
    local p_index = Field.GetPlayerIndex()
    local p_pos = Field.ObjectGetPosition(PLAYER, p_index)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, p_pos.x, p_pos.z)
    Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
  end
  
  function obj:SetRotationYToPlayerAndAnim(frame)
    frame = frame or 0
    local p_index = Field.GetPlayerIndex()
    local p_pos = Field.ObjectGetPosition(PLAYER, p_index)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, p_pos.x, p_pos.z)
    local obj_y_degree = Field.ObjectGetRotationY(self.type, self.index)
    local mot_obj = Motion.Object:new(self.type, self.name, "ft03_02")
    local mot_end_frame_f = mot_obj:GetEndFrame()
    local mot_end_frame = math.floor(mot_end_frame_f + 0.5)
    if y_degree ~= obj_y_degree then
      Field.StartPlayerAndNpcTalkAction(self.index)
      mot_obj:Play(15, true)
      Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
    end
    WaitFrame(mot_end_frame)
    mot_obj:Reset(15)
  end
  
  function obj:SetRotationYToPlayerAndAnimRun(frame)
    frame = frame or 0
    local p_index = Field.GetPlayerIndex()
    local p_pos = Field.ObjectGetPosition(PLAYER, p_index)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, p_pos.x, p_pos.z)
    local obj_y_degree = Field.ObjectGetRotationY(self.type, self.index)
    local mot_obj = Motion.Object:new(self.type, self.name, "br01")
    local mot_end_frame_f = mot_obj:GetEndFrame()
    local mot_end_frame = math.floor(mot_end_frame_f + 0.5)
    if y_degree ~= obj_y_degree then
      mot_obj:Play(15, true)
      Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
      WaitFrame(mot_end_frame)
    end
    WaitFrame(mot_end_frame)
    mot_obj:Reset(15)
  end
  
  function obj:SetRotationYToPlayerAndAnimRun_Guardro(frame)
    frame = frame or 0
    Field_InvisibleFollowerAllGuest(0, 15, false)
    Field_InvisibleFollowerAllPartyMember(0, 15, false)
    local p_index = Field.GetPlayerIndex()
    local p_pos = Field.ObjectGetPosition(PLAYER, p_index)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, p_pos.x, p_pos.z)
    local obj_y_degree = Field.ObjectGetRotationY(self.type, self.index)
    local mot_obj = Motion.Object:new(self.type, self.name, "ft03_02")
    local mot_end_frame_f = mot_obj:GetEndFrame()
    local mot_end_frame = math.floor(mot_end_frame_f + 0.5)
    local degree_dif = math.abs(y_degree - obj_y_degree)
    print(degree_dif)
    if 60 <= degree_dif then
      mot_obj:Play(5, true)
      Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
      WaitFrame(mot_end_frame)
    end
    WaitFrame(mot_end_frame)
    mot_obj:Reset(10)
  end
  
  function obj:SetRotationYToPlayerAndAnimRun_big(frame)
    frame = frame or 0
    local p_index = Field.GetPlayerIndex()
    local p_pos = Field.ObjectGetPosition(PLAYER, p_index)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, p_pos.x, p_pos.z)
    local obj_y_degree = Field.ObjectGetRotationY(self.type, self.index)
    local mot_obj = Motion.Object:new(self.type, self.name, "br01")
    local mot_end_frame_f = mot_obj:GetEndFrame()
    local mot_end_frame = math.floor(mot_end_frame_f + 40)
    if y_degree ~= obj_y_degree then
      mot_obj:Play(15, true)
      Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
    end
    WaitFrame(mot_end_frame)
    mot_obj:Reset(10)
  end
  
  function obj:SetRotationYToCoordinateAndAnimRun(frame, x, y, z)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, x, z)
    local obj_y_degree = Field.ObjectGetRotationY(self.type, self.index)
    local mot_obj = Motion.Object:new(self.type, self.name, "br01")
    local mot_end_frame_f = mot_obj:GetEndFrame()
    local mot_end_frame = math.floor(mot_end_frame_f + 0.5)
    if y_degree ~= obj_y_degree then
      mot_obj:Play(15, true)
      Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
    end
    WaitFrame(mot_end_frame)
    mot_obj:Reset(0)
  end
  
  function obj:SetRotationYToObject(obj_type, unique_name_2, frame)
    local ob = Obj:new(obj_type, unique_name_2)
    local y_degree = Field.GetAngleToTarget2D(self.pos.x, self.pos.z, ob.pos.x, ob.pos.z)
    Field.ObjectSetRotationY(self.type, self.index, y_degree, frame)
  end
  
  function obj:ClearRotationY(frame)
    frame = frame or 0
    Field.ObjectSetRotationY(self.type, self.index, self.rot_y, frame)
  end
  
  function obj:ClearRotationYToRun(frame)
    frame = frame or 0
    local mot_obj = Motion.Object:new(self.type, self.name, "br01")
    local mot_end_frame_f = mot_obj:GetEndFrame()
    local mot_end_frame = math.floor(mot_end_frame_f + 0.5)
    mot_obj:Play(15, true)
    Field.ObjectSetRotationY(self.type, self.index, self.rot_y, frame)
    WaitFrame(mot_end_frame)
    mot_obj:Reset(15)
  end
  
  function obj:ClearRotationYToRun_Guardro(frame)
    frame = frame or 0
    local mot_obj = Motion.Object:new(self.type, self.name, "ft03_02")
    local mot_end_frame_f = mot_obj:GetEndFrame()
    local mot_end_frame = math.floor(mot_end_frame_f + 20)
    local obj_y_degree = Field.ObjectGetRotationY(self.type, self.index)
    local degree_dif = math.abs(self.rot_y - obj_y_degree)
    print(degree_dif)
    if 60 <= degree_dif then
      mot_obj:Play(5, true)
      Field.ObjectSetRotationY(self.type, self.index, self.rot_y, frame)
      WaitFrame(mot_end_frame)
      mot_obj:Reset(10)
    end
  end
  
  function obj:Invisible(frame, is_max_alpha_start)
    frame = frame or 0
    is_max_alpha_start = is_max_alpha_start or false
    Field.ObjectInvisible(self.type, self.index, 0, frame, is_max_alpha_start)
  end
  
  function obj:CancelInvisible(frame, is_force, is_zero_alpha_start)
    frame = frame or 0
    is_force = is_force or false
    is_zero_alpha_start = is_zero_alpha_start or false
    Field.ObjectCancelInvisible(self.type, self.index, 0, frame, is_force, is_zero_alpha_start)
  end
  
  function obj:SetEnableGimmick(enable)
    Field.SetEnableGimmickCheck(self.name, enable)
  end
  
  function obj:SetEnableCheckAndFieldAttack(enable)
    Field.ObjectSetEnableCheckAndFieldAttack(self.type, self.index, enable)
  end
  
  function obj:DisableCulling()
    Field.ObjectDisableCulling(self.type, self.index)
  end
  
  function obj:CancelDisableCulling()
    Field.ObjectCancelDisableCulling(self.type, self.index)
  end
  
  function obj:SetPos(x, y, z, on_ground)
    on_ground = on_ground or true
    Field.ObjectSetPos(self.type, self.index, x, y, z, on_ground)
    self.nowpos = Field.ObjectGetPosition(self.type, self.index)
  end
  
  function SetObjectPositionFromObject(target_type, target_name, obj_type, obj_index, offset_x, offset_y, offset_z, on_ground)
    on_ground = on_ground or true
    offset_x = offset_x or 0
    offset_y = offset_y or 0
    offset_z = offset_z or 0
    local target_index = GetIndex(target_type, target_name)
    local target_pos = Field.ObjectGetPosition(target_type, target_index)
    local pos = {}
    pos.x = target_pos.x + offset_x
    pos.y = target_pos.y + offset_y
    pos.z = target_pos.z + offset_z
    Field.ObjectSetPos(obj_type, obj_index, pos.x, pos.y, pos.z, on_ground)
  end
  
  function obj:SetObjectPositionFromObject(target_type, target_name, offset_x, offset_y, offset_z, on_ground)
    on_ground = on_ground or true
    offset_x = offset_x or 0
    offset_y = offset_y or 0
    offset_z = offset_z or 0
    local target_pos = Obj:new(target_type, target_name).pos
    local pos = {
      x = target_pos.x + offset_x,
      y = target_pos.y + offset_y,
      z = target_pos.z + offset_z
    }
    if self.type == PLAYER then
      Field.ResetPlayer(pos.x, pos.y, pos.z, Field.ObjectGetRotationY(self.type, self.index))
    else
      Field.ObjectSetPos(self.type, self.index, pos.x, pos.y, pos.z, on_ground)
    end
    self.nowpos = Field.ObjectGetPosition(self.type, self.index)
  end
  
  function obj:SetPosLocator(locator, on_ground)
    local loc_pos = Field.GetLocatorPosition(locator)
    on_ground = on_ground or true
    Field.ObjectSetPos(self.type, self.index, loc_pos.x, loc_pos.y, loc_pos.z, on_ground)
    self.nowpos = Field.ObjectGetPosition(self.type, self.index)
  end
  
  function obj:SetPlayerPosLocator(locator)
    if self.type == FLD_OBJ_PLAYER then
      Field.SetPlayerLocator(locator)
    else
      error("SetPlayerPosLocator\227\129\175Player\229\176\130\231\148\168\229\135\166\231\144\134\227\129\167\227\129\153")
    end
    self.nowpos = Field.ObjectGetPosition(self.type, self.index)
  end
  
  function obj:ResetPos()
    Field.ObjectSetPos(self.type, self.index, self.pos.x, self.pos.y, self.pos.z)
  end
  
  function obj:Move2D(y_degree, speed, frame)
    if frame ~= nil then
      Field.ObjectFrameMove2D(self.type, self.index, y_degree, speed, frame)
    else
      Field.ObjectMove2D(self.type, self.index, y_degree, speed)
    end
  end
  
  function obj:MoveToTarget2D(x_pos, z_pos, speed, frame)
    if speed ~= nil and frame == nil then
      Field.ObjectMoveToTarget2D(self.type, self.index, x_pos, z_pos, speed)
      self.nowpos = Field.ObjectGetPosition(self.type, self.index)
    end
    if speed == nil and frame ~= nil then
      Field.ObjectAdjustSpeedFrameMoveToTargetPos2D(self.type, self.index, x_pos, z_pos, frame)
      self.nowpos = Field.ObjectGetPosition(self.type, self.index)
    end
    if speed ~= nil and frame ~= nil then
      Field.ObjectFrameMoveToTarget2D(self.type, self.index, x_pos, z_pos, speed, frame)
      self.nowpos = Field.ObjectGetPosition(self.type, self.index)
    end
  end
  
  function obj:LookAt(x, y, z, blend_frame)
    Field.ObjectLookAt(self.type, self.index, x, y, z, blend_frame)
  end
  
  function obj:LookAtTheObject(target_type, target_uniquename, blend_frame)
    local index = target_uniquename
    if type(target_uniquename) == "string" and target_uniquename ~= nil then
      index = GetIndex(target_type, target_uniquename)
    end
    Field.ObjectLookAtTheObject(self.type, self.index, target_type, index, blend_frame)
  end
  
  function obj:SetIcon(icon_type)
    Field.ObjectSetIcon(self.type, self.index, icon_type)
  end
  
  function obj:SuspendAutoTransparentForCamera()
    Field.ObjectSuspendAutoTransparentForCamera(self.type, self.index)
  end
  
  function obj:CancelSuspendAutoTransParentForCamera()
    Field.ObjectCancelSuspendAutoTransparentForCamera(self.type, self.index)
  end
  
  function obj:SetFloatMessage(message_id, frame)
    Field.ObjectStartFloatMessage(self.type, self.index, message_id, frame)
  end
  
  function obj:ChangeExpression(expression, blink_type, is_lip_sync, frame, sync_with_motion_type, cancel_frame)
    Field.ObjectLoadExpression(self.type, self.index, expression)
    if sync_with_motion_type == nil and cancel_frame == nil then
      Field.ObjectChangeExpression(self.type, self.index, expression, blink_type, is_lip_sync, frame)
    elseif sync_with_motion_type ~= nil and cancel_frame ~= nil then
      Field.ObjectChangeExpression(self.type, self.index, expression, blink_type, is_lip_sync, frame, sync_with_motion_type, cancel_frame)
    end
  end
  
  function obj:ClearExpression(frame)
    Field.ObjectClearExpresson(self.type, self.index, frame)
  end
  
  function obj:ResetExporession(frame)
    Field.ObjectResetExpression(self.type, self.index, frame)
  end
  
  return obj
end

Elv = {}

function Elv:new(elv, icon, low, high, flg, rev)
  local obj = {}
  obj.elv = Obj:new(FLD_OBJ_LOCATOR, elv)
  obj.icon = Obj:new(FLD_OBJ_GIMMICK, icon)
  obj.low = low
  obj.high = high
  obj.flg = flg
  obj.rev = rev or false
  
  function obj:CheckLowCol(col_name)
    return self.low == col_name
  end
  
  function obj:CheckHighCol(col_name)
    return self.high == col_name
  end
  
  function obj:ChangeIcon(col_name)
    if self:CheckLowCol(col_name) then
      self.elv:SetIcon(ICO_ELV_UP)
      self.icon:Invisible()
    elseif self:CheckHighCol(col_name) then
      self.elv:SetIcon(ICO_NONE)
      self.icon:CancelInvisible()
    end
  end
  
  function obj:InitChangeIcon()
    if self.rev then
      if Flg.Check(self.flg) then
        self.elv:SetIcon(ICO_ELV_UP)
        self.icon:Invisible()
      else
        self.elv:SetIcon(ICO_NONE)
        self.icon:CancelInvisible()
      end
    elseif Flg.Check(self.flg) then
      self.elv:SetIcon(ICO_NONE)
      self.icon:CancelInvisible()
    else
      self.elv:SetIcon(ICO_ELV_UP)
      self.icon:Invisible()
    end
  end
  
  return obj
end

function StartDuct(start_loc, end_loc, env_file)
  SetProhibitPlayerOnlyOperate(true)
  if Flg.Check("FLAG_IS_CHANGE_AEGIOMON") then
    require("d05_01b")
    d05_01b(start_loc)
  else
    require("d05_01")
    d05_01(start_loc)
  end
  SetEnableGimmickCheck(start_loc, false)
  SetEnableGimmickCheck(end_loc, false)
  Obj:new(PLAYER, ""):Invisible()
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Motion.Player:ChangeMoveAnim("duct", 1.5)
  SetPlayerLocator(end_loc)
  CameraSwitchChangeByFileName(CAM_FILE_DUCT, "followcam_loc_01_01", false)
  if env_file ~= nil then
    Field_SetEnvironmentSettings(env_file)
  end
  FadeInWithWait(0, 30)
end

function EndDuct(start_loc, end_loc, cam, cam_rotate_y, is_aegiomon)
  Fade_OutNoLoadingWithWait(FADE_BLACK, 5)
  BackFade_In(FADE_BLACK, 0)
  if is_aegiomon == true then
    Flg.Set("FLAG_IS_CHANGE_AEGIOMON")
    PlayerModelChange(AEGIOMON)
    WaitFrame(5)
    require("d05_02")
    CheckSyncPlayerModel(false)
    Field.ResetEnvironmentSettings()
    d05_02(end_loc)
  else
    Flg.Clear("FLAG_IS_CHANGE_AEGIOMON")
    CancelPlayerModelChange()
    WaitFrame(5)
    require("d05_03")
    CheckSyncPlayerModel(false)
    Field.ResetEnvironmentSettings()
    d05_03(end_loc)
  end
  SetEnableGimmickCheck(start_loc, true)
  SetEnableGimmickCheck(end_loc, true)
  CameraSwitchChange(cam, true)
  Motion.Player:ResetMoveAnim()
  if not is_aegiomon == true then
    Field.FollowerWarp()
    Field_CancelInvisibleFollowerAllGuest(0, 0, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, false)
    SetProhibitPlayerOnlyOperate(false)
  end
  Obj:new(PLAYER, ""):CancelInvisible()
end

function GimmickZoom_In()
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  WaitFrame(5)
  Field.CameraZoomFrame(0.3, 0, 20, 0)
  WaitFrame(5)
end

function GimmickZoom_Out()
  Field.CameraZoomUndo()
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
end

function GetIndex(obj_type, name, follower_index)
  local index
  if obj_type == FLD_OBJ_NONE then
  end
  if obj_type == FLD_OBJ_PLAYER then
    index = Field.GetPlayerIndex()
  end
  if obj_type == FLD_OBJ_FOLLOWER then
    if name == "party" then
      local unique_id = Digimon.GetUniqueIDInPartyMember(follower_index)
      index = Field.GetFollowerIndexByPartyUniqueID(unique_id)
    else
      index = Field.GetFollowerIndexByGuestID(follower_index)
    end
  end
  if obj_type == FLD_OBJ_NPC then
    index = Field.GetNpcIndex(name)
  end
  if obj_type == FLD_OBJ_MOB then
    index = Field.GetMobIndex(name)
  end
  if obj_type == FLD_OBJ_RUMOR_NPC then
    index = Field.GetRumorNpcIndex(name)
  end
  if obj_type == FLD_OBJ_SYMBOL_ENEMY then
    index = Field.GetSymbolEnemyIndex(name)
  end
  if obj_type == FLD_OBJ_LOCATOR then
    index = Field.GetLocatorObjectIndex(name)
  end
  if obj_type == FLD_OBJ_GIMMICK then
    index = Field.GetGimmickIndex(name)
  end
  if index ~= nil then
    print("index = ", index)
  end
  return index
end

function Get_CatItem()
  Motion.Player:Play("fg07_d01", 0, false)
  PlaySE(403016, 100)
  Motion.NPC:Play("npc_0010", "fn12", 0, false)
  WaitFrame(60)
  if not Flg.Check("FLAG_IS_GET_ITEM_FROM_CAT") then
    INFO_GET_ITEM(211, 1)
    Flg.Set("FLAG_IS_GET_ITEM_FROM_CAT")
  end
end

function GetDistanceBetweenTwoObjectField2D(object1_x, object1_z, object2_x, object2_z)
  distance = math.sqrt((object1_x - object2_x) * (object1_x - object2_x) + (object1_z - object2_z) * (object1_z - object2_z))
  return distance
end

function CreateLoadList()
  gLoadPlayerList, gLoadNpcList, gLoadMobList, gLoadRumorNpcList = {}, {}, {}, {}
  gLoadEnemyList, gLoadGimmickList, gLoadEffectList, gLoadCameraList = {}, {}, {}, {}
end

function AddLoadList(object_type, load_table)
  if object_type == FLD_OBJ_PLAYER then
    gLoadPlayerList[#gLoadPlayerList + 1] = load_table
  elseif object_type == FLD_OBJ_NPC then
    gLoadNpcList[#gLoadNpcList + 1] = load_table
  elseif object_type == FLD_OBJ_MOB then
    gLoadMobList[#gLoadMobList + 1] = load_table
  elseif object_type == FLD_OBJ_RUMOR_NPC then
    gLoadRumorNpcList[#gLoadRumorNpcList + 1] = load_table
  elseif object_type == FLD_OBJ_SYMBOL_ENEMY then
    gLoadEnemyList[#gLoadEnemyList + 1] = load_table
  elseif object_type == FLD_OBJ_LOCATOR then
    gLoadGimmickList[#gLoadGimmickList + 1] = load_table
  elseif object_type == "effect" then
    gLoadEffectList[#gLoadEffectList + 1] = load_table
  elseif object_type == "camera" then
    gLoadCameraList[#gLoadCameraList + 1] = load_table
  end
end

function LoadDataInLoadList()
  local load_tables = {
    {
      FLD_OBJ_PLAYER,
      gLoadPlayerList
    },
    {
      FLD_OBJ_NPC,
      gLoadNpcList
    },
    {
      FLD_OBJ_MOB,
      gLoadMobList
    },
    {
      FLD_OBJ_RUMOR_NPC,
      gLoadRumorNpcList
    },
    {
      FLD_OBJ_SYMBOL_ENEMY,
      gLoadEnemyList
    },
    {
      FLD_OBJ_LOCATOR,
      gLoadGimmickList
    },
    {
      "effect",
      gLoadEffectList
    },
    {
      "camera",
      gLoadCameraList
    }
  }
  local index
  for i = 1, #load_tables do
    for load_num, load_value in pairs(load_tables[i][2]) do
      if load_tables[i][1] == "effect" then
        print("load effect")
        for j = 1, #load_value do
          LoadEffefctScript(load_value[j], 1)
        end
        goto lbl_191
      elseif load_tables[i][1] == "camera" then
        print("load camera")
        for j = 1, #load_value do
          CameraAddLoad(load_value[j])
        end
        goto lbl_191
      end
      index = GetIndex(load_tables[i][1], load_value[1])
      if index ~= nil then
        print("== function field::LoadDataInLoadList == index::", index)
        if load_value.motion ~= nil then
          for j = 1, #load_value.motion do
            Field.ObjectLoadMotion(load_tables[i][1], index, load_value.motion[j])
          end
        end
        if load_value.move_motion ~= nil then
          for j = 1, #load_value.move_motion do
            Motion.Object:LoadMove(load_tables[i][1], index, load_value.move_motion[j])
          end
        end
        if load_value.attach ~= nil then
          for j = 1, #load_value.attach do
            Field.ObjectLoadAttachment(load_tables[i][1], index, load_value.attach[j])
          end
        end
        if load_value.attach_motion ~= nil then
          for j = 1, #load_value.attach_motion do
            Field.ObjectLoadAttachmentMotion(load_tables[i][1], index, load_value.attach_motion[j][1], load_value.attach_motion[j][2])
          end
        end
        if load_value.attach_effect ~= nil then
          for j = 1, #load_value.attach_effect do
            AttachEffectScript(load_tables[i][1], index, load_value.attach_effect[j][1], load_value.attach_effect[j][2], load_value.attach_effect[j][3], false, false, false, false)
          end
        end
      end
      ::lbl_191::
    end
  end
  gLoadPlayerList, gLoadNpcList, gLoadMobList, gLoadRumorNpcList = nil, nil, nil, nil
  gLoadEnemyList, gLoadGimmickList, gLoadEffectList, gLoadCameraList = nil, nil, nil, nil
end

function GetPositionFromObject(obj1_type, obj1_name, obj2_type, obj2_name, distance)
  local obj1_index = GetIndex(obj1_type, obj1_name)
  local obj2_index = GetIndex(obj2_type, obj2_name)
  local obj1_pos = Field.ObjectGetPosition(obj1_type, obj1_index)
  local obj2_pos = Field.ObjectGetPosition(obj2_type, obj2_index)
  local angle = Field.GetAngleToTarget2D(obj1_pos.x, obj1_pos.z, obj2_pos.x, obj2_pos.z)
  local vector2d = Field.GetUnitVector2D(angle)
  local pos = {}
  pos.x = obj1_pos.x + vector2d.x * distance
  pos.z = obj1_pos.z + vector2d.z * distance
  return pos
end

function Field_SetEnvironmentSettings(file_name)
  Field.LoadEnvironmentSettings(file_name)
  Field.SetEnvironmentSettings(file_name)
end

Flg = {}

function Flg.AllCheck(flag_table, is_define)
  is_define = is_define or false
  for _, value in pairs(flag_table) do
    if is_define then
      if not Flag.Check(value) then
        print("AllFlagCheck Returned [ false ]")
        return false
      end
    elseif not Flag.Check(GET_FLAG(value)) then
      print("AllFlagCheck Returned [ false ]")
      return false
    end
  end
  print("AllFlagCheck Returned [ true ]")
  return true
end

function Flg.Check(is_true_flag, is_false_flag, is_define)
  is_define = is_define or false
  if is_define == nil then
    is_define = false
  end
  if is_true_flag ~= nil then
    local is_true
    if is_define then
      is_true = Flag.Check(is_true_flag)
    else
      is_true = Flag.Check(GET_FLAG(is_true_flag))
    end
    if is_false_flag ~= nil then
      local is_false
      if is_define then
        is_false = Flag.Check(is_false_flag)
      else
        is_false = Flag.Check(GET_FLAG(is_false_flag))
      end
      if is_true and not is_false then
        print("Flg.Check returned [ true ]")
        return true
      else
        print("Flg.Check returned [ false ]")
        return false
      end
    else
      return is_true
    end
  end
  print("Flg.Check returned [ nil ]")
  print("Please Check Your Scripts and Flags")
  return nil
end

function Flg.CheckNum(flags)
  local num = 0
  for _, value in ipairs(flags) do
    if Flg.Check(value) then
      num = num + 1
    end
  end
  return num
end

function Flg.Set(flag, is_define)
  if not flag then
    return
  end
  is_define = is_define or false
  if type(flag) == "table" then
    if next(flag) ~= nil then
      for key in pairs(flag) do
        if is_define then
          Flag.Set(flag[key])
        else
          Flag.Set(GET_FLAG(flag[key]))
        end
      end
    end
  elseif is_define then
    Flag.Set(flag)
  else
    Flag.Set(GET_FLAG(flag))
  end
end

function Flg.Clear(flag, is_define)
  if not flag then
    return
  end
  is_define = is_define or false
  if type(flag) == "table" then
    if next(flag) ~= nil then
      for key in pairs(flag) do
        if is_define then
          Flag.Clear(flag[key])
        else
          Flag.Clear(GET_FLAG(flag[key]))
        end
      end
    end
  elseif is_define then
    Flag.Clear(flag)
  else
    Flag.Clear(GET_FLAG(flag))
  end
end

function CheckItemNum(item_id, item_num)
  local current_item_num = Item.GetNum(item_id)
  if item_num <= current_item_num then
    return true
  else
    return false
  end
end

function FieldWorldMapOpenAllArea()
  local area_flag = {
    EAST_SHINJUKU = "EAST_SHINJUKU",
    AKIHABARA = "AKIHABARA",
    WEST_SHINJUKU = "WEST_SHINJUKU",
    CINEMA_WAY = "ROAD_CHINEMA",
    COSMICK = "COSMIC",
    CENTRAL = "CENTRAL",
    OCEANUS = "OCEANUS",
    MAKEDONIA = "MAKEDONIA",
    FACTREA = "FACTREA",
    ILIAS = "ILIAS",
    PLUTO = "PLUTO"
  }
  local place_flag = {
    EAST_SHINJUKU_STATION = "E_SHINJUKU_STATION",
    ROAD_MENUKI = "ROAD_MENUKI",
    ALTA = "ALTA",
    SHINJUKU_ST_EAST = "SHINJUKU_ST_EAST",
    CROSS_ROAD = "CROSS_ROAD",
    GUARD = "GUARD",
    AKIHABARA_STATION = "AKIBA_STATION",
    WEST_SHINJUKU_METROPOLITAN_GOVERNMENT = "METROPOLITAN_GOVERNMENT",
    WEST_SHINJUKU_PARK = "SHINJUKU_PARK",
    SHOPPING_STREET = "SHOPPING_STREET",
    CENTRAL_STREET = "CENTRAL_STREET",
    RADIO_TOWER = "RADIO_TOWER",
    OCEANUS_AREA2 = "OCEANUS_AREA2",
    MAKEDONIA_AREA2 = "MAKEDONIA_AREA2",
    FACTREA_AREA1 = "FACTREA_AREA1",
    ILIAS_ENTRANCE = "ILIAS_ENTRANCE",
    ILIAS_ENTRANCE2 = "ILIAS_ENTRANCE2"
  }
  for _, value in pairs(area_flag) do
    Flg.Set("AREA_OPEN_" .. value)
  end
  for _, value in pairs(place_flag) do
    Flg.Set("PLACE_OPEN_" .. value)
  end
  Flg.Set("AREA_OPEN_DEBUG")
end

function GoToOuter(locator, move_point_x, move_point_z)
  local player = Obj:new(PLAYER, "")
  local loc = Obj:new(FLD_OBJ_LOCATOR, locator)
  local loc_point_x = loc.pos.x + move_point_x
  local loc_point_z = loc.pos.z + move_point_z
  local y_degree = Field.GetAngleToTarget2D(loc.pos.x, loc.pos.z, loc_point_x, loc_point_z)
  local point_x = loc_point_x - player.pos.x
  local point_z = loc_point_z - player.pos.z
  local dis_point_x = loc_point_x + move_point_x
  local dis_point_y = loc.pos.y + 1.5
  local dis_point_z = loc_point_z + move_point_z
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Cam.Inst:Set(loc.pos.x, loc.pos.y + 1.3, loc.pos.z, dis_point_x + 1, dis_point_y, dis_point_z + 0.5, DEFAULT_ANGLE, 30)
  PlayerObjectResetAim()
  MovePlayerToRelativePosFrame(point_x, point_z, 15)
  WaitFrame(20)
  Field.ObjectResetMotion(PLAYER, 1, 10)
  WaitFrame(10)
  PlayerTurnToObject(FLD_OBJ_LOCATOR, locator, true, false, 0, 0)
  WaitFrame(10)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  Field_SetEnvironmentSettings("es_d1101_gateIn")
  PlayEffectScript("ef_f_mov_145_ga", loc.pos.x, loc.pos.y, loc.pos.z, y_degree, 1)
  PlaySE(404005, 100)
  WaitFrame(15)
  loc:Invisible(1)
  WaitFrame(30)
  Field.MovePlayerToLocatorFrame(locator, 30)
  PlaySE(200006, 100)
end

function GoToOuterGimmickObj(gim_name, move_point_x, move_point_z)
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local gate_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, gim_name))
  local loc_point_x = gate_pos.x + move_point_x
  local loc_point_z = gate_pos.z + move_point_z
  local y_degree = Field.GetAngleToTarget2D(gate_pos.x, gate_pos.z, loc_point_x, loc_point_z)
  local point_x = loc_point_x - player_pos.x
  local point_z = loc_point_z - player_pos.z
  local dis_point_x = loc_point_x + move_point_x
  local dis_point_y = gate_pos.y + 1.5
  local dis_point_z = loc_point_z + move_point_z
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Cam.Inst:Set(gate_pos.x, gate_pos.y + 1.3, gate_pos.z, dis_point_x + 1, dis_point_y, dis_point_z + 0.5, DEFAULT_ANGLE, 30)
  PlayerObjectResetAim()
  MovePlayerToRelativePosFrame(point_x, point_z, 20)
  WaitFrame(20)
  Field.ObjectResetMotion(PLAYER, 1, 10)
  WaitFrame(10)
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, gate_pos.x, gate_pos.z)
  PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
  WaitFrame(10)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  Field_SetEnvironmentSettings("es_d1101_gateIn")
  PlayEffectScript("ef_f_mov_145_ga", gate_pos.x, gate_pos.y, gate_pos.z, y_degree, 1)
  PlaySE(404005, 100)
  WaitFrame(15)
  Field.ObjectInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, gim_name), 0, 1, true)
  WaitFrame(30)
  Field.AdjustSpeedMovePlayerToTargetFrame2D(gate_pos.x, gate_pos.z, 30)
  PlaySE(200006, 100)
end

function MoveGateBlue(locator, move_point_x, move_point_z)
  local player = Obj:new(PLAYER, "")
  local loc = Obj:new(FLD_OBJ_LOCATOR, locator)
  local loc_point_x = loc.pos.x + move_point_x
  local loc_point_z = loc.pos.z + move_point_z
  local y_degree = Field.GetAngleToTarget2D(loc.pos.x, loc.pos.z, loc_point_x, loc_point_z)
  local point_x = loc_point_x - player.pos.x
  local point_z = loc_point_z - player.pos.z
  local dis_point_x = loc_point_x + move_point_x
  local dis_point_y = loc.pos.y + 1.5
  local dis_point_z = loc_point_z + move_point_z
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Cam.Inst:Set(loc.pos.x, loc.pos.y + 1.3, loc.pos.z, dis_point_x + 1, dis_point_y, dis_point_z + 0.5, DEFAULT_ANGLE, 30)
  PlayerObjectResetAim()
  MovePlayerToRelativePosFrame(point_x, point_z, 15)
  WaitFrame(20)
  Field.ObjectResetMotion(PLAYER, 1, 10)
  WaitFrame(10)
  PlayerTurnToObject(FLD_OBJ_LOCATOR, locator, true, false, 0, 0)
  WaitFrame(10)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  Field_SetEnvironmentSettings("es_d1101_gateIn")
  PlayEffectScript("ef_f_mov_140_ga", loc.pos.x, loc.pos.y, loc.pos.z, y_degree, 1)
  PlaySE(404005, 100)
  WaitFrame(15)
  loc:Invisible(1)
  WaitFrame(30)
  Field.MovePlayerToLocatorFrame(locator, 30)
  PlaySE(200006, 100)
end

function MoveGateBlueGimmickObj(gim_name, move_point_x, move_point_z)
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local gate_pos = Field.ObjectGetPosition(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, gim_name))
  local loc_point_x = gate_pos.x + move_point_x
  local loc_point_z = gate_pos.z + move_point_z
  local y_degree = Field.GetAngleToTarget2D(gate_pos.x, gate_pos.z, loc_point_x, loc_point_z)
  local point_x = loc_point_x - player_pos.x
  local point_z = loc_point_z - player_pos.z
  local dis_point_x = loc_point_x + move_point_x
  local dis_point_y = gate_pos.y + 1.5
  local dis_point_z = loc_point_z + move_point_z
  Field_InvisibleFollowerAllPartyMember(0, 20, false)
  Field_InvisibleFollowerAllGuest(0, 20, false)
  Cam.Inst:Set(gate_pos.x, gate_pos.y + 1.3, gate_pos.z, dis_point_x + 1, dis_point_y, dis_point_z + 0.5, DEFAULT_ANGLE, 30)
  PlayerObjectResetAim()
  MovePlayerToRelativePosFrame(point_x, point_z, 20)
  WaitFrame(20)
  Field.ObjectResetMotion(PLAYER, 1, 10)
  WaitFrame(10)
  local player_pos = Field.ObjectGetPosition(FLD_OBJ_PLAYER, 1)
  local rot = Field.GetAngleToTarget2D(player_pos.x, player_pos.z, gate_pos.x, gate_pos.z)
  PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
  WaitFrame(10)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  Field_SetEnvironmentSettings("es_d1101_gateIn")
  PlayEffectScript("ef_f_mov_140_ga", gate_pos.x, gate_pos.y, gate_pos.z, y_degree, 1)
  PlaySE(404005, 100)
  WaitFrame(15)
  Field.ObjectInvisible(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, gim_name), 0, 1, true)
  WaitFrame(30)
  Field.AdjustSpeedMovePlayerToTargetFrame2D(gate_pos.x, gate_pos.z, 30)
  PlaySE(200006, 100)
end

Move = {}

function Move:ToNPC(npc_name, dist_adjust)
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_rotate = Field.ObjectGetRotationY(NPC, npc_index)
  local npc_vec_2d = GetUnitVector2D(npc_rotate)
  local distance = 1.7
  local move_speed = 2
  if dist_adjust ~= nil then
    dist_adjust = 0
  end
  local move_x = npc_pos.x + npc_vec_2d.x * (distance + dist_adjust)
  local move_z = npc_pos.z + npc_vec_2d.z * (distance + dist_adjust)
  Field.MovePlayerToTargetPosFrame2D(move_x, move_z, move_speed, 50)
  WaitFrame(50)
  Field.SetPlayerRotation(npc_rotate + 180, 10)
  WaitFrame(10)
end

function Move:PlayerMoveIsTalkNPC(move_frame, npc_name)
  if Field.IsPlayerMoved() then
    local index = GetIndex(PLAYER, "")
    local npc_index = GetIndex(NPC, npc_name)
    local player_pos = Field.ObjectGetPosition(PLAYER, index)
    local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
    local player_rotation_y = Field.ObjectGetRotationY(PLAYER, index)
    local vec = Field.GetUnitVector2D(player_rotation_y)
    local dist_x = math.abs(npc_pos.x - player_pos.x)
    local dist_z = math.abs(npc_pos.z - player_pos.z)
    if dist_x >= math.abs(vec.x) and dist_z >= math.abs(vec.z) then
      MovePlayerToRelativePosFrame(vec.x, vec.z, move_frame)
      WaitFrame(move_frame - 15)
    end
  end
end

function Move:PlayerIsDoorOut(move_frame)
  if move_frame == nil then
    move_frame = 30
  end
  local index = GetIndex(PLAYER, "")
  local player_rotate = Field.ObjectGetRotationY(PLAYER, index)
  local player_vec = Field.GetUnitVector2D(player_rotate)
  Field.SetFollowerCameraOperateRotationY(player_rotate + 180)
  local vec_x = player_vec.x * 1.2
  local vec_z = player_vec.z * 1.2
  MovePlayerToRelativePosFrame(vec_x, vec_z, move_frame)
end

function Move:PlayerIsDegeGateOut(move_frame)
  if move_frame == nil then
    move_frame = 30
  end
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  local index = GetIndex(PLAYER, "")
  local player_rotate = Field.ObjectGetRotationY(PLAYER, index)
  local player_vec = Field.GetUnitVector2D(player_rotate)
  local vec_x = player_vec.x * 1.2
  local vec_z = player_vec.z * 1.2
  Fade.In(1, Util.SecondFromFrame(move_frame))
  MovePlayerToRelativePosFrame(vec_x, vec_z, move_frame)
  Flg.Set("FLAG_NOT_USE_FIELD_FADE")
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function PlayDapatureLocomonSound()
  Fade_Out(FADE_BLACK, 0)
  local depature = Sound.PlaySE(200020, 100)
  WaitFrame(30)
  Sound.StopSE(depature, 2)
  WaitFrame(15)
end

function PlayStopLocomonSound()
  Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
  WaitFrame(30)
  local run = Sound.PlaySE(200021, 100)
  WaitFrame(15)
  Sound.StopSE(run, 1)
  local depature = Sound.PlaySE(200043, 100)
  WaitFrame(15)
  Sound.StopSE(depature, 2)
  BackFade_In(FADE_BLACK, 0)
  WaitFrame(15)
end

function PlayDapatureBlimpSound()
  Fade_Out(FADE_BLACK, 0)
  WaitFrame(30)
  local start_sound = Sound.PlaySE(403053, 100)
  WaitFrame(30)
  Sound.StopSE(start_sound, 2)
  WaitFrame(15)
end

function PlayStopBlimpSound()
  Flg.Clear("FLAG_ISAREA_CHANGE_FOR_BLIMP")
  BackFade_OutNoLoadingWithWait(FADE_BLACK, 0)
  WaitFrame(30)
  local start_sound = Sound.PlaySE(403054, 100)
  WaitFrame(30)
  Sound.StopSE(start_sound, 1)
  BackFadeInWithWait(FADE_BLACK, 0)
  WaitFrame(15)
end

Restore = {}

function Restore.PartyWithInfoWindow()
  Digimon.RestoreAllParty()
  PlaySE(200007, 100)
  INFO_WINDOW(5051)
end

function Restore.Party()
  Digimon.RestoreAllParty()
end

Map = {
  AREA = {
    EAST_SHINJUKU = "EAST_SHINJUKU",
    AKIHABARA = "AKIHABARA",
    WEST_SHINJUKU = "WEST_SHINJUKU",
    ROAD_CHINEMA = "ROAD_CHINEMA",
    COSMIC = "COSMIC",
    CENTRAL = "CENTRAL",
    OCEANUS = "OCEANUS",
    MAKEDONIA = "MAKEDONIA",
    FACTREA = "FACTREA",
    ILIAS = "ILIAS",
    FANATIC_PALACE = "FANATIC_PALACE",
    PLUTO = "PLUTO",
    DEBUG = "DEBUG"
  },
  PLACE = {
    E_SHINJUKU_STATISON = "E_SHINJUKU_STATION",
    ROAD_MENUKI = "ROAD_MENUKI",
    ALTA = "ALTA",
    SHINJUKU_ST_EAST = "SHINJUKU_ST_EAST",
    CROSS_ROAD = "CROSS_ROAD",
    GUARD = "GUARD",
    AKIBA_STATION = "AKIBA_STATION",
    AKIBA_CROSS_ROAD = "AKIBA_CROSS_ROAD",
    METROPOLITAN_GOVERNMENT = "METROPOLITAN_GOVERNMENT",
    SHINJUKU_PARK = "SHINJUKU_PARK",
    SHOPPING_STREET = "SHOPPING_STREET",
    PLAYER_ROOM = "PLAYER_ROOM",
    ROOFTOP = "ROOFTOP",
    ROAD_CHINEMA_BACK_STREET = "ROAD_CHINEMA_BACK_STREET",
    ROAD_SHINJUKU_BACK_STREET = "ROAD_SHINJUKU_BACK_STREET",
    GUARD_WEST = "GUARD_WEST",
    COSMIC_AREA1 = "COSMIC_AREA1",
    CENTRAL_STREET = "CENTRAL_STREET",
    CENTRAL_STREET_B = "CENTRAL_STREET_B",
    RADIO_TOWER = "RADIO_TOWER",
    OCEANUS_AREA2 = "OCEANUS_AREA2",
    MAKEDONIA_AREA1 = "MAKEDONIA_AREA1",
    MAKEDONIA_AREA2 = "MAKEDONIA_AREA2",
    FACTREA_AREA1 = "FACTREA_AREA1",
    FACTREA_AREA2 = "FACTREA_AREA2",
    FANATIC_ENTRANCE = "FANATIC_ENTRANCE",
    ILIAS_ENTRANCE = "ILIAS_ENTRANCE",
    ILIAS_ENTRANCE2 = "ILIAS_ENTRANCE2",
    PLUTO_01 = "PLUTO_01"
  }
}

function Map.AreaKeeoOut(area_num, enable)
  WorldMap.AreaKeepOut(area_num, enable)
end

function Map.PlaceKeepOut(place_num, enable)
  WorldMap.PlaceKeepOut(place_num, enable)
end

function Map:OpenArea(area_id, enable)
  local area = ""
  if area_id == 1 then
    area = self.AREA.EAST_SHINJUKU
  elseif area_id == 2 then
    area = self.AREA.AKIHABARA
  elseif area_id == 3 then
    area = self.AREA.WEST_SHINJUKU
  elseif area_id == 4 then
    area = self.AREA.ROAD_CHINEMA
  elseif area_id == 101 then
    area = self.AREA.COSMIC
  elseif area_id == 102 then
    area = self.AREA.CENTRAL
  elseif area_id == 103 then
    area = self.AREA.OCEANUS
  elseif area_id == 104 then
    area = self.AREA.MAKEDONIA
  elseif area_id == 105 then
    area = self.AREA.FACTREA
  elseif area_id == 106 then
    area = self.AREA.ILIAS
  elseif area_id == 107 then
    area = self.AREA.PLUTO
  elseif area_id == 999 then
    area = self.AREA.DEBUG
  end
  if area ~= "" then
    if enable then
      Flg.Set("AREA_OPEN_" .. area)
    else
      Flg.Clear("AREA_OPEN_" .. area)
    end
  end
end

function Map:CloseArea(area_id, enable)
  local area = ""
  if area_id == 1 then
    area = self.AREA.EAST_SHINJUKU
  elseif area_id == 2 then
    area = self.AREA.AKIHABARA
  elseif area_id == 3 then
    area = self.AREA.WEST_SHINJUKU
  elseif area_id == 4 then
    area = self.AREA.ROAD_CHINEMA
  elseif area_id == 101 then
    area = self.AREA.COSMIC
  elseif area_id == 102 then
    area = self.AREA.CENTRAL
  elseif area_id == 103 then
    area = self.AREA.OCEANUS
  elseif area_id == 104 then
    area = self.AREA.MAKEDONIA
  elseif area_id == 105 then
    area = self.AREA.FACTREA
  elseif area_id == 106 then
    area = self.AREA.ILIAS
  elseif area_id == 107 then
    area = self.AREA.PLUTO
  elseif area_id == 999 then
    area = self.AREA.DEBUG
  end
  if area ~= "" then
    if enable then
      Flg.Set("AREA_CLOSE_" .. area)
    else
      Flg.Clear("AREA_CLOSE_" .. area)
    end
  else
    print("area none")
  end
end

function Map:OpenPlace(place_no, enable)
  local place = ""
  if place_no == 101 then
    place = self.PLACE.E_SHINJUKU_STATISON
  elseif place_no == 102 then
    place = self.PLACE.ROAD_MENUKI
  elseif place_no == 103 then
    place = self.PLACE.ALTA
  elseif place_no == 151 then
    place = self.PLACE.SHINJUKU_ST_EAST
  elseif place_no == 152 then
    place = self.PLACE.CROSS_ROAD
  elseif place_no == 153 then
    place = self.PLACE.GUARD
  elseif place_no == 155 then
    place = self.PLACE.ROAD_SHINJUKU_BACK_STREET
  elseif place_no == 201 then
    place = self.PLACE.AKIBA_STATION
  elseif place_no == 250 then
    place = self.PLACE.AKIBA_CROSS_ROAD
  elseif place_no == 301 then
    place = self.PLACE.METROPOLITAN_GOVERNMENT
  elseif place_no == 302 then
    place = self.PLACE.SHINJUKU_PARK
  elseif place_no == 351 then
    place = self.PLACE.GUARD_WEST
  elseif place_no == 401 then
    place = self.PLACE.SHOPPING_STREET
  elseif place_no == 404 then
    place = self.PLACE.PLAYER_ROOM
  elseif place_no == 408 then
    place = self.PLACE.ROOFTOP
  elseif place_no == 10101 then
    place = self.PLACE.COSMIC_AREA1
  elseif place_no == 10201 then
    place = self.PLACE.CENTRAL_STREET
  elseif place_no == 10206 then
    place = self.PLACE.RADIO_TOWER
  elseif place_no == 10211 then
    place = self.PLACE.CENTRAL_STREET_B
  elseif place_no == 10302 then
    place = self.PLACE.OCEANUS_AREA2
  elseif place_no == 10401 then
    place = self.PLACE.MAKEDONIA_AREA1
  elseif place_no == 10402 then
    place = self.PLACE.MAKEDONIA_AREA2
  elseif place_no == 10412 then
    place = self.PLACE.MAKEDONIA_AREA2
  elseif place_no == 10501 then
    place = self.PLACE.FACTREA_AREA1
  elseif place_no == 10521 then
    place = self.PLACE.FACTREA_AREA2
  elseif place_no == 10601 then
    place = self.PLACE.FANATIC_ENTRANCE
  elseif place_no == 10606 then
    place = self.PLACE.ILIAS_ENTRANCE
  elseif place_no == 10607 then
    place = self.PLACE.ILIAS_ENTRANCE2
  elseif place_no == 10701 then
    place = self.PLACE.PLUTO_01
  end
  if place ~= "" then
    if enable then
      Flg.Set("PLACE_OPEN_" .. place)
    else
      Flg.Clear("PLACE_OPEN_" .. place)
    end
  else
    print("place none")
  end
end

function Map:ClosePlace(place_no, enable)
  local place = ""
  if place_no == 101 then
    place = self.PLACE.E_SHINJUKU_STATISON
  elseif place_no == 102 then
    place = self.PLACE.ROAD_MENUKI
  elseif place_no == 103 then
    place = self.PLACE.ALTA
  elseif place_no == 151 then
    place = self.PLACE.SHINJUKU_ST_EAST
  elseif place_no == 152 then
    place = self.PLACE.CROSS_ROAD
  elseif place_no == 153 then
    place = self.PLACE.GUARD
  elseif place_no == 155 then
    place = self.PLACE.ROAD_SHINJUKU_BACK_STREET
  elseif place_no == 201 then
    place = self.PLACE.AKIBA_STATION
  elseif place_no == 250 then
    place = self.PLACE.AKIBA_CROSS_ROAD
  elseif place_no == 301 then
    place = self.PLACE.METROPOLITAN_GOVERNMENT
  elseif place_no == 302 then
    place = self.PLACE.SHINJUKU_PARK
  elseif place_no == 351 then
    place = self.PLACE.GUARD_WEST
  elseif place_no == 401 then
    place = self.PLACE.SHOPPING_STREET
  elseif place_no == 404 then
    place = self.PLACE.PLAYER_ROOM
  elseif place_no == 10101 then
    place = self.PLACE.COSMIC_AREA1
  elseif place_no == 10201 then
    place = self.PLACE.CENTRAL_STREET
  elseif place_no == 10206 then
    place = self.PLACE.RADIO_TOWER
  elseif place_no == 10211 then
    place = self.PLACE.CENTRAL_STREET_B
  elseif place_no == 10302 then
    place = self.PLACE.OCEANUS_AREA2
  elseif place_no == 10401 then
    place = self.PLACE.MAKEDONIA_AREA1
  elseif place_no == 10402 then
    place = self.PLACE.MAKEDONIA_AREA2
  elseif place_no == 10412 then
    place = self.PLACE.MAKEDONIA_AREA2
  elseif place_no == 10501 then
    place = self.PLACE.FACTREA_AREA1
  elseif place_no == 10521 then
    place = self.PLACE.FACTREA_AREA2
  elseif place_no == 10601 then
    place = self.PLACE.FANATIC_ENTRANCE
  elseif place_no == 10606 then
    place = self.PLACE.ILIAS_ENTRANCE
  elseif place_no == 10607 then
    place = self.PLACE.ILIAS_ENTRANCE2
  elseif place_no == 10701 then
    place = self.PLACE.PLUTO_01
  end
  if place ~= "" then
    if enable then
      Flg.Set("PLACE_CLOSE_" .. place)
    else
      Flg.Clear("PLACE_CLOSE_" .. place)
    end
  end
end

function Map:OpenAllAreaForTable(area_table)
  if area_table ~= nil then
    for areas in pairs(area_table) do
      Map:OpenPlace(area_table[areas].prefix, area_table[areas].place_no, area_table[areas].open)
    end
  end
end

function Map:OpenAllArea()
  local area_flag = {
    EAST_SHINJUKU = "AREA_OPEN_EAST_SHINJUKU",
    AKIHABARA = "AREA_OPEN_AKIHABARA",
    WEST_SHINJUKU = "AREA_OPEN_WEST_SHINJUKU",
    CINEMA_WAY = "AREA_OPEN_ROAD_CHINEMA",
    COSMICK = "AREA_OPEN_COSMIC",
    MERCURIUS_TOWN = "AREA_OPEN_CENTRAL",
    SEA = "AREA_OPEN_OCEANUS",
    FOREST = "AREA_OPEN_MAKEDONIA",
    FACT = "AREA_OPEN_FACTREA",
    ILIAD = "AREA_OPEN_ILIAS",
    PLUTO = "AREA_OPEN_PLUTO"
  }
  local place_flag = {
    EAST_SHINJUKU_STATION = "PLACE_OPEN_E_SHINJUKU_STATION",
    EAST_SHINJUKU_KOMAGEKI = "PLACE_OPEN_ALTA",
    AKIHABARA_STATION = "PLACE_OPEN_AKIBA_STATION",
    WEST_SHINJUKU_TOKYO_TOTYO = "PLACE_OPEN_METROPOLITAN_GOVERNMENT",
    WEST_SHINJUKU_PARK = "PLACE_OPEN_SHINJUKU_PARK",
    CINEMA_WAY_ROAD = "PLACE_OPEN_SHOPPING_STREET",
    MERCURIUS_FRONT_WAY = "PLACE_OPEN_CENTRAL_STREET",
    MERCURIUS_TOWER = "PLACE_OPEN_RADIO_TOWER",
    SEA_AREA_2 = "PLACE_OPEN_OCEANUS_AREA2",
    FOREST_AREA_1 = "PLACE_OPEN_MAKEDONIA_AREA2",
    FACT_AREA_1 = "PLACE_OPEN_FACTREA_AREA1",
    FANATIC_ENTRANCE = "AREA_OPEN_FANATIC_PALACE",
    ILIAD_ENTRANCE = "PLACE_OPEN_ILIAS_ENTRANCE",
    ILIAD_ENTRANCE2 = "PLACE_OPEN_ILIAS_ENTRANCE2"
  }
  Flg.Set(area_flag)
  Flg.Set(place_flag)
  Flg.Set("AREA_OPEN_DEBUG")
end

function ResetFAObject(with_item)
  with_item = with_item or true
  local index = 0
  local gim_num = Field.GetObjectExistsNum(FLD_OBJ_GIMMICK)
  for index = 1, gim_num do
    Field.ObjectCancelBroke(FLD_OBJ_GIMMICK, index, with_item)
  end
end

function WarpNpcPerformance(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  PlaySE(211010, 100)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
end

function WarpNpcArrival()
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  WaitFrame(30)
  FadeInWithWaitNotFlgCheck(FADE_WHITE, FADE_TIME)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_440_BerufeFlag()
  if not Flg.Check("FLAG_MAIN_22_511") then
    Flg.Set("FLAG_MAIN_22_511")
  elseif Flg.Check("FLAG_MAIN_22_511") and not Flg.Check("FLAG_MAIN_22_512") then
    Flg.Set("FLAG_MAIN_22_512")
  elseif Flg.Check("FLAG_MAIN_22_512") and not Flg.Check("FLAG_MAIN_22_513") then
    Flg.Set("FLAG_MAIN_22_513")
  elseif Flg.Check("FLAG_MAIN_22_513") and not Flg.Check("FLAG_MAIN_22_514") then
    Flg.Set("FLAG_MAIN_22_514")
  end
end

function SubQuestDigitterCheck()
  if Flg.Check("FLAG_IS_CLEAR_S095_078") and not Flg.Check("FLAG_SUB_080_059_013") then
    Flg.Set("FLAG_SUB_080_059_013")
  end
  if Flg.Check("FLAG_IS_CLEAR_S080_059") and not Flg.Check("FLAG_SUB_080_060_017") then
    Flg.Set("FLAG_SUB_080_060_017")
  end
  if Flg.Check("FLAG_IS_CLEAR_S070_055") and not Flg.Check("FLAG_SUB_070_056_007") then
    Flg.Set("FLAG_SUB_070_056_007")
  end
  if Flg.Check("FLAG_IS_CLEAR_S070_056") and not Flg.Check("FLAG_SUB_070_057_003") then
    Flg.Set("FLAG_SUB_070_057_003")
  end
  if Flg.Check("FLAG_IS_CLEAR_S070_057") and not Flg.Check("FLAG_SUB_070_167_011") then
    Flg.Set("FLAG_SUB_070_167_011")
  end
  if Flg.Check("FLAG_IS_CLEAR_S020_018") and not Flg.Check("FLAG_SUB_020_019_007") then
    Flg.Set("FLAG_SUB_020_019_007")
  end
  if Flg.Check("FLAG_IS_CLEAR_S010_002") and not Flg.Check("FLAG_S003_011") then
    Flg.Set("FLAG_S003_011")
  end
  if Flg.Check("FLAG_IS_CLEAR_S010_003") and not Flg.Check("FLAG_S003_012") then
    Flg.Set("FLAG_S003_012")
  end
  if Flg.Check("FLAG_IS_CLEAR_S110_105") and not Flg.Check("FLAG_SUB_110_105_013") then
    Flg.Set("FLAG_SUB_110_105_013")
  end
end

function Dlc_InstallCheck()
  if Flg.Check("FLAG_MAIN_03_035") then
    if Flg.Check("FLAG_MAIN_03_150") then
      if Flg.Check("FLAG_DLC_PATCH001_IS_INDICATIONS") and not Flg.Check("FLAG_DLC_EP00_001") then
        Flg.Set("FLAG_DLC_EP00_001")
      end
      if DLC.FlagCheck(1) and not Flg.Check("FLAG_DLC_EP01_001") then
        Flg.Set("FLAG_DLC_EP01_001")
      end
      if DLC.FlagCheck(2) and not Flg.Check("FLAG_DLC_EP02_001") then
        Flg.Set("FLAG_DLC_EP02_001")
      end
      if DLC.FlagCheck(3) and not Flg.Check("FLAG_DLC_EP03_001") then
        Flg.Set("FLAG_DLC_EP03_001")
      end
    end
    if DLC.FlagCheck(7) and not Flg.Check("FLAG_DLC_COS_010") then
      Flg.Set("FLAG_DLC_COS_010")
    end
    if DLC.FlagCheck(12) and not Flg.Check("FLAG_DLC_COS_040") then
      Flg.Set("FLAG_DLC_COS_040")
    end
    if DLC.FlagCheck(13) and not Flg.Check("FLAG_DLC_COS_050") then
      Flg.Set("FLAG_DLC_COS_050")
    end
    if DLC.FlagCheck(14) and not Flg.Check("FLAG_DLC_COS_020") then
      Flg.Set("FLAG_DLC_COS_020")
    end
    if DLC.FlagCheck(15) and not Flg.Check("FLAG_DLC_COS_030") then
      Flg.Set("FLAG_DLC_COS_030")
    end
    if DLC.FlagCheck(16) then
      if not Flg.Check("FLAG_DLC_COS_020") then
        Flg.Set("FLAG_DLC_COS_020")
      end
      if not Flg.Check("FLAG_DLC_COS_030") then
        Flg.Set("FLAG_DLC_COS_030")
      end
      if not Flg.Check("FLAG_DLC_COS_040") then
        Flg.Set("FLAG_DLC_COS_040")
      end
      if not Flg.Check("FLAG_DLC_COS_050") then
        Flg.Set("FLAG_DLC_COS_050")
      end
    end
  end
end

function OpenDlcStore()
  Field.OpenDLCStore()
  WaitFrame(1)
  while not Field.IsOpenDLCStore() do
  end
end
