require("include")

function main()
  local name = Common.GetCharName(6001)
  Common.SetPlayerName(name)
  SystemFlag.SetHideEnemiesOnMiniMap()
  SystemFlag.SetHideEnemiesOnMiniMap()
  Flg.Set("FLAG_IS_LOCK_STRIKE_PLUS")
  if Item.GetNum(801) < 1 then
    Item.Add(801, 1)
  end
  if 1 > Common.GetMoney() then
    Common.AddMoney(10000)
  end
  TIME_AXIS = AXIS_ORIGINAL
  TIME_AXIS_SET = "X2028_daft_10"
  TIME_ZONE = NOON
  MapChangeWithTimeTravel("e", 1, "start_00", TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
end
