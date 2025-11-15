function GetGender()
  local player_model_name = Common.GetPlayerModelName()
  
  local gender
  local reverse_name = string.reverse(player_model_name)
  local model_type = string.reverse(string.sub(reverse_name, 9))
  if model_type == "pc001" then
    gender = HERO
  else
    if model_type == "pc002" then
      gender = HEROINE
    else
    end
  end
  return gender
end

function PlayerModelChange(id)
  Common.PlayerModelChange(id)
end

function CancelPlayerModelChange()
  if Common.IsPlayerModelChanged() then
    Common.CancelPlayerModelChange()
  end
end

function SetEnableMenu(is_use)
  if is_use then
    Field.CancelDisableMenu()
  else
    Field.DisableMenu()
  end
end

Party = {
  Digimon = {},
  Aegiomon = {}
}
Bank = {
  Digimon = {}
}
Guest = {}

function Party.Digimon.Add(digimon_id, level, personality_id, personality_skill_id, gift)
  personality_id = personality_id or 0
  personality_skill_id = personality_skill_id or 0
  gift = gift or -1
  if Common.GetPartyNum() >= 6 then
    Common.AddBankDigimon(digimon_id, level, personality_id, personality_skill_id, gift)
  else
    Common.AddPartyDigimon(digimon_id, level, personality_id, personality_skill_id, gift)
  end
end

function Party.Aegiomon.Add(level)
  Common.AddPartyAegiomon(level, 7, 21)
  if level <= 0 or level == nil then
    level = 1
  end
  if 1 <= level then
    Common.SetAegiomonSkill(0, 21832)
    Common.SetAegiomonSkill(1, 0)
  end
end

function Party.Aegiomon.IsExist()
  return Common.ExistPartyAegiomon()
end

function Party.Aegiomon.SetExist(is_exist)
  Common.SetExistPartyAegiomon(is_exist)
end

function Bank.Digimon.Add(digimon_id, level, personality_id, personality_skill_id, gift)
  if personality_id == nil then
    personality_id = 0
  end
  if personality_skill_id == nil then
    personality_skill_id = 0
  end
  if gift == nil then
    gift = -1
  end
  Common.AddBankDigimon(digimon_id, level, personality_id, personality_skill_id, gift)
end

function Guest.Add(guest_id, is_sync)
  if is_sync == nil then
    is_sync = true
  end
  Common.AddGuest(guest_id)
  if is_sync then
    FollowerSync()
  end
end

function Guest.Delete(guest_id, is_sync)
  if is_sync == nil then
    is_sync = true
  end
  Common.DeleteGuest(guest_id)
  if is_sync then
    FollowerSync()
  end
end

function Guest.IsExist(guest_id)
  return Common.IsExistGuest(guest_id)
end

function Guest.IsExistNum(check_num)
  local num = 0
  check_num = 3 < check_num and 3 or check_num
  if Common.ExistPartyAegiomon() then
    num = num + 1
  end
  for char = 1, 999 do
    for val = 1, 9 do
      local id = tonumber(string.format("2%03d%d", char, val))
      if Common.IsExistGuest(id) then
        num = num + 1
      end
      if check_num <= num then
        return true
      end
    end
  end
  return false
end

function FldSetTimeAxis(time_axis)
  Common.SetTimeAxis(time_axis)
end

function SetTimeAxis_Past()
  Common.SetTimeAxis(PAST)
end

function SetTimeAxis_Present()
  Common.SetTimeAxis(PRESENT)
end

function GetTimeZone()
  return Common.GetTimeZone()
end

function GetTimeZoneID()
  local time_zone = Common.GetTimeZone()
  if time_zone == MORNING then
    return morning
  elseif time_zone == NOON then
    return noon
  elseif time_zone == EVENING then
    return evening
  else
    return night
  end
end

function GetTImeZoneFromID(id)
  if id == morning then
    return MORNING
  elseif id == noon then
    return NOON
  elseif id == evening then
    return EVENING
  else
    return NIGHT
  end
end

function CheckTimeAxis(start_axis, end_axis)
  if end_axis ~= nil then
    return Common.CheckTimeAxis(start_axis, end_axis)
  else
    return Common.CheckTimeAxis(start_axis)
  end
end

function MapChangeWithTimePasses(prefix, map_num, locator, time_zone)
  Common.RequestMapChangeWithTimePasses(prefix, map_num, locator, time_zone)
end

function MapChangeWithTimeTravel(prefix, map_num, locator, time_axis, time_axis_set, time_zone)
  Common.SetTimeTravelRecord(time_axis, time_axis_set, time_zone)
  Common.RequestMapChangeWithTimeTravelFromRecord(prefix, map_num, locator, time_axis)
end

function OpenTimeTravelUI()
  TimeTravel.Create()
  TimeTravel.Open()
  while TimeTravel.IsClosed() do
    WaitFrame(1)
  end
  if TimeTravel.IsCanceled() then
    TimeTravel.End()
  elseif TimeTravel.IsBackOriginal() then
    Common.RequestMapChangeWithTimeTravelFromRecord()
    TimeTravel.End()
  end
end

function Fade_In(type, frame)
  Fade.In(type, Util.SecondFromFrame(frame))
end

function Fade_Out(type, frame)
  Fade.Out(type, Util.SecondFromFrame(frame))
end

function Fade_OutNoLoading(type, frame)
  Fade.OutNotLoading(type, Util.SecondFromFrame(frame))
end

function Fade_OutNoLoadingWithWait(type, frame)
  Fade.OutNotLoading(type, Util.SecondFromFrame(frame))
  while not Fade.AllIsEndType(type) do
    WaitFrame(1)
  end
end

function BackFade_In(type, frame)
  Fade.BackIn(type, Util.SecondFromFrame(frame))
end

function BackFade_Out(type, frame)
  Fade.BackOut(type, Util.SecondFromFrame(frame))
end

function BackFade_OutNoLoading(type, frame)
  Fade.BackOutNotLoading(type, Util.SecondFromFrame(frame))
end

function BackFade_OutNoLoadingWithWait(type, frame)
  Fade.BackOutNotLoading(type, Util.SecondFromFrame(frame))
  while not Fade.AllIsEndType(type) do
    WaitFrame(1)
  end
end

function FadeInWithWait(type, frame)
  if Flg.Check("FLAG_NOT_USE_FIELD_FADE") then
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
    print("##### !!! FLAG_NOT_USE_FIELD_FADE !!! #####")
  else
    Fade.In(type, Util.SecondFromFrame(frame))
    while not Fade.AllIsEndType(type) do
      WaitFrame(1)
    end
  end
end

function FadeInWithWaitNotFlgCheck(type, frame)
  Fade.In(type, Util.SecondFromFrame(frame))
  while not Fade.AllIsEndType(type) do
    WaitFrame(1)
  end
end

function FadeOutWithWait(type, frame)
  if Flg.Check("FLAG_NOT_USE_FIELD_FADE") then
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
  else
    Fade.Out(type, Util.SecondFromFrame(frame))
    while not Fade.AllIsEndType(type) do
      WaitFrame(1)
    end
  end
end

function FadeOutWithWaitNotFlgCheck(type, frame)
  Fade.Out(type, Util.SecondFromFrame(frame))
  while not Fade.AllIsEndType(type) do
    WaitFrame(1)
  end
end

function BackFadeOutWithWait(type, frame)
  if Flg.Check("FLAG_NOT_USE_FIELD_FADE") then
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
  else
    Fade.BackOut(type, Util.SecondFromFrame(frame))
    while not Fade.AllIsEndType(type) do
      WaitFrame(1)
    end
  end
end

function BackFadeOutWithWaitNotFlgCheck(type, frame)
  Fade.BackOut(type, Util.SecondFromFrame(frame))
  while not Fade.AllIsEndType(type) do
    WaitFrame(1)
  end
end

function BackFadeInWithWait(type, frame)
  if Flg.Check("FLAG_NOT_USE_FIELD_FADE") then
    Flg.Clear("FLAG_NOT_USE_FIELD_FADE")
  else
    Fade.BackIn(type, Util.SecondFromFrame(frame))
    while not Fade.AllIsEndType(type) do
      WaitFrame(1)
    end
  end
end

function BackFadeInWithWaitNotFlgCheck(type, frame)
  Fade.BackIn(type, Util.SecondFromFrame(frame))
  while not Fade.AllIsEndType(type) do
    WaitFrame(1)
  end
end

function FadeAllIn(type, frame, a_start, a_end)
  if a_start == nil then
    a_start = 1
  end
  if a_end == nil then
    a_end = 0
  end
  Fade.AllIn(type, Util.SecondFromFrame(frame), a_start, a_end)
end

function FadeAllInWithWait(type, frame, a_start, a_end)
  if a_start == nil then
    a_start = 1
  end
  if a_end == nil then
    a_end = 0
  end
  Fade.AllIn(type, Util.SecondFromFrame(frame), a_start, a_end)
  while not Fade.AllIsEndType(type) do
    WaitFrame(1)
  end
end

function Quake_Start(start_value, end_value, frame)
  Quake.Start(start_value, end_value, frame)
end

function Quake_Stop()
  Quake.Stop()
end

function RegularQuake_Start(start_value, end_value, quake_frame, interval_frame)
  Field.SetRegularQuake(start_value, end_value, quake_frame, interval_frame)
end

function RegularQuake_Stop()
  Field.ClearRegularQuake()
end

function Message(a_message_id)
  Talk.Message(a_message_id)
  WaitMessage()
end

function MessageAuto(a_message_id, a_frame)
  Talk.Message_Auto(a_message_id, a_frame)
  WaitMessage()
end

function MessageTalk(a_message_id, a_visible_speaker)
  if a_visible_speaker == nil then
    a_visible_speaker = true
  end
  Talk.MessageTalk(a_message_id, a_visible_speaker)
  WaitMessage()
end

function MessageTalkAuto(a_message_id, a_frame, a_visible_speaker)
  Talk.MessageTalkAuto(a_message_id, a_frame, a_visible_speaker)
end

function MessageTalkSel(a_sel_num, a_message_id)
  Talk.MessageTalkSel(a_sel_num, a_message_id)
  WaitMessage()
  result = Talk.GetResultSelectedNum()
end

function ShowGetItemLog(item_id, num)
  Field.ShowGetItemLog(item_id, num)
end

function OpenTutorial(a_tutorial_id)
  Window.OpenTutorial(a_tutorial_id)
  WaitTutorialWindow()
  Window.CloseTutorial()
  WaitCloseTutorialWindow()
  local flg_name = "TUT_FLAG_" .. string.format("%d", 4500 + 100 * (math.floor(a_tutorial_id / 1000) - 1) + a_tutorial_id % 1000)
  Flg.Set(flg_name)
end

function WaitMessage()
  WaitFrame(1)
  while not Talk.IsNext() do
    WaitFrame(1)
  end
end

function WaitCloseTalkWindow()
  WaitFrame(1)
  while not Talk.IsClose() do
    WaitFrame(1)
  end
end

function WaitInfoWindow()
  WaitFrame(1)
  while not Window.IsNextInfo() do
    WaitFrame(1)
  end
end

function WaitCloseInfoWindow()
  WaitFrame(1)
  while not Window.IsEndCloseInfo() do
    WaitFrame(1)
  end
end

function WaitTutorialWindow()
  WaitFrame(1)
  while not Window.IsNextTutorial() do
    WaitFrame(1)
  end
end

function WaitCloseTutorialWindow()
  WaitFrame(1)
  while not Window.IsEndCloseTutorial() do
    WaitFrame(1)
  end
end

function WaitCloseSubQuestWindow()
  WaitFrame(1)
  while not Quest.IsCloseDetails() do
    WaitFrame(1)
  end
end

function WaitCloseHazamaQuestWindow()
  WaitFrame(1)
  while not Quest.IsCloseReceiveYesNoWindow() do
    WaitFrame(1)
  end
end

function WaitQuestEndDirection()
  WaitFrame(1)
  while not Quest.IsEndDirection() do
    WaitFrame(1)
  end
end

function WaitCloseShopWindow()
  WaitFrame(1)
  while not Shop.IsClosed() do
    WaitFrame(1)
  end
end

function WaitCloseDevelopWindow()
  WaitFrame(1)
  while not Develop.IsClosedDevelop() do
    WaitFrame(1)
  end
end

function MessageClose()
  Talk.Close()
  WaitCloseTalkWindow()
end

function OpenInfoWindow(message_id)
  Window.OpenInfo(message_id)
  while not Window.IsNextInfo() do
    WaitFrame(Util.SecondFromFrame(1))
  end
  Window.CloseInfo()
  while not Window.IsEndCloseInfo() do
    WaitFrame(Util.SecondFromFrame(1))
  end
end

function ShopClose()
  Shop.End()
  WaitCloseShopWindow()
end

function INFO_WINDOW(mesNo)
  Window.OpenInfo(mesNo)
  WaitInfoWindow()
  Window.CloseInfo()
  WaitCloseInfoWindow()
end

function INFO_USE_ITEM(item_id, num)
  num = num or 1
  if item_id == 727 then
    Window.SetReplaceStringInfo("item_name", "727")
  end
  Window.SetReplaceNumberInfo(num)
  Item.Add(item_id, -num)
  Window.OpenInfo(1918)
  WaitInfoWindow()
  Window.CloseInfo()
  WaitCloseInfoWindow()
end

function INFO_GET_ITEM(ItemNo, num)
  Sound.PlaySE("101009", 100)
  Window.OpenInfoGetItem(ItemNo, num)
  WaitInfoWindow()
  Window.CloseInfo()
  WaitCloseInfoWindow()
end

function INFO_RELEASE_ITEM(item_no, num)
  Sound.PlaySE("101009", 100)
  Window.OpenInfoReleaseItem(item_no, num)
  WaitInfoWindow()
  Window.CloseInfo()
  WaitCloseInfoWindow()
end

function WaitVistaLoad()
  WaitFrame(1)
  while not Vista.IsEndLoad() do
    WaitFrame(1)
  end
end

function WaitVistaBGMovie()
  WaitFrame(1)
  while not Vista.IsReadyBGMovie() do
    WaitFrame(1)
  end
end

function TalkExit()
  Talk.Exit()
  while not Talk.IsExit() do
    WaitFrame(1)
  end
  Talk.End()
end

function VistaExit()
  Vista.Exit()
  while not Vista.IsExit() do
    WaitFrame(1)
  end
  Vista.End()
end

function StringSplit(str, pattern)
  if pattern == nil then
    pattern = "%s"
  end
  local t = {}
  for s in string.gmatch(str, pattern) do
    table.insert(t, s)
  end
  return t
end

function AllComparisonBaseAndSubject(base, subject)
  for key in pairs(subject) do
    if base ~= subject[key] then
      return false
    end
  end
  return true
end

function SomeComparisonBaseAndSubject(base, subject)
  for key in pairs(subject) do
    if base == subject[key] then
      print("SomeComparisonBaseAndSubject::returned true")
      return true
    end
  end
  print("SomeComparisonBaseAndSubject::returned false")
  return false
end

function printTable(t, indent, tableHistory)
  indent = indent or ""
  tableHistory = tableHistory or {}
  if tableHistory[t] then
    print(indent .. "*reference*")
    return
  end
  tableHistory[t] = true
  for k, v in pairs(t) do
    local valueType = type(v)
    if valueType == "table" then
      print(indent .. tostring(k) .. ":")
      printTable(v, indent .. "  ", tableHistory)
    else
      print(indent .. tostring(k) .. ": " .. tostring(v))
    end
  end
end

BitFlag = {}

function BitFlag:new()
  local obj = {}
  obj.flg = 0
  
  function obj:Set(bind)
    self.flg = bit32.bor(self.flg, bit32.lshift(1, bind))
  end
  
  function obj:Clear(bind)
    if not self:Check(bind) then
      return
    end
    self.flg = bit32.bxor(self.flg, bit32.lshift(1, bind))
  end
  
  function obj:Check(bind)
    return bit32.band(self.flg, bit32.lshift(1, bind)) == bit32.lshift(1, bind)
  end
  
  function obj:CheckNum()
    local num = 0
    local x5 = 1431655765
    local x3 = 858993459
    local xf = 252645135
    local x1 = 16843009
    num = self.flg - bit32.band(bit32.arshift(self.flg, 1), x5)
    num = bit32.band(num, x3) + bit32.band(bit32.arshift(num, 2), x3)
    num = bit32.arshift(bit32.band(num + bit32.arshift(num, 4), xf) * x1, 24)
    return num
  end
  
  return obj
end
