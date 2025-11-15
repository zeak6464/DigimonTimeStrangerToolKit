gim_text = "field_text"

function LoadGimmickData(load_map_num)
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 1 then
  end
end

function InitializeObject()
  map_num, map_prefix = Field.GetMapNumber(), Field.GetMapPrefix()
  print("##### map_prefix = ", map_prefix, " ##### map_num = ", map_num, " #####")
  PlayerObjectResetAim()
  if map_num == 1 then
  end
end

function OnCheckLocatorObject(gim)
end
