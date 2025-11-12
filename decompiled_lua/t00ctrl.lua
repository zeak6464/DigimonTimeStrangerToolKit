require("function_control")

function LoadRequest()
  print("===============LoadRequest=====================")
  map_prefix, map_num = GetMapPrefix(), GetMapNumber()
  print("====== map_prefix = ", map_prefix, " ====== map_num = ", map_num, " ======")
  if map_num == 1 then
  elseif map_num == 2 then
    LoadLocatorModel("t0002p")
  elseif map_num == 3 then
  end
end

function Initialize()
  print("===============Initialize=====================")
  map_prefix, map_num = GetMapPrefix(), GetMapNumber()
  print("====== map_prefix = ", map_prefix, " ====== map_num = ", map_num, " ======")
  SetExternalVariable("player_state", "Initialize")
  if map_num == 1 then
  elseif map_num == 2 then
  elseif map_num == 3 then
  end
end

function Update(elapsed_frame)
  map_prefix, map_num = GetMapPrefix(), GetMapNumber()
  player_state = GetExternalVariable("player_state")
  if map_num == 1 then
  end
end

function EventStartCheckNpc(npc_index)
  map_prefix, map_num = GetMapPrefix(), GetMapNumber()
  print("====== map_prefix = ", map_prefix, " ====== map_num = ", map_num, " ======")
end

function EventEndCheckNpc(npc_index)
  map_prefix, map_num = GetMapPrefix(), GetMapNumber()
  print("====== map_prefix = ", map_prefix, " ====== map_num = ", map_num, " ======")
end
