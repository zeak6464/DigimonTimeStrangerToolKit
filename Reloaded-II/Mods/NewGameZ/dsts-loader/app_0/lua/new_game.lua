require("include")

function main()
  local name = Common.GetCharName(6001)
  Common.SetPlayerName(name)
  SystemFlag.SetHideEnemiesOnMiniMap()
  SystemFlag.SetHideEnemiesOnMiniMap()
  Flg.Set("FLAG_IS_LOCK_STRIKE_PLUS")
  
  -- Give player money
  if 1 > Common.GetMoney() then
    Common.AddMoney(999999) -- Max money
  end
    
  -- Add all items (you'll need to define the complete item list)
  GiveAllItems()
  
  -- Add all digimon to bank (you'll need to define the complete digimon list)
  GiveAllDigimonToBank()
  
  TIME_AXIS = AXIS_ORIGINAL
  TIME_AXIS_SET = "X2028_daft_10"
  TIME_ZONE = NOON
  MapChangeWithTimeTravel("e", 1, "start_00", TIME_AXIS, TIME_AXIS_SET, TIME_ZONE)
end

function GiveAllItems()
  -- Basic items (1-999999) - all items
  for i = 1, 999999 do
    Item.Add(i, 99)
  end
end

function GiveAllDigimonToBank()
  -- Add digimon IDs 1-9999
  for i = 1, 999999 do
    Bank.Digimon.Add(i, 50, 1, 1, 0)
  end
end
