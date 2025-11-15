gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### e00_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
end

function OnTriggerEnter(col)
end

function OnCheckLocatorObject(gim)
end

function OnFieldAttackLocatorObject(att_gim)
end
