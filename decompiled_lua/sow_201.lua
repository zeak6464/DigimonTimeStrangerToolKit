Sow_201 = {
  ID = 201,
  STEP_001 = 1,
  STEP_010 = 10,
  STEP_255 = 255
}
local ItemID = 798
local Itemnum = 17
local text_file = "s900_165"

function SeekEtemon_Start()
  if not Flg.Check("FLAG_SUB_SEEKETEMON_START") then
    Digitter.Send(2201010, true)
    WaitFrame(60)
    Flg.Set("FLAG_SUB_SEEKETEMON_START")
  end
end

function SeekEtemon_End()
  if not Flg.Check("FLAG_IS_CLEAR_Sow_201") and Flg.Check("FLAG_SUB_SEEKETEMON_START") and Flg.Check("FLAG_SUB_SEEKETEMON_01") and Flg.Check("FLAG_SUB_SEEKETEMON_02") and Flg.Check("FLAG_SUB_SEEKETEMON_03") and Flg.Check("FLAG_SUB_SEEKETEMON_04") and Flg.Check("FLAG_SUB_SEEKETEMON_05") and Flg.Check("FLAG_SUB_SEEKETEMON_06") and Flg.Check("FLAG_SUB_SEEKETEMON_07") and Flg.Check("FLAG_SUB_SEEKETEMON_08") and Flg.Check("FLAG_SUB_SEEKETEMON_09") and Flg.Check("FLAG_SUB_SEEKETEMON_10") and Flg.Check("FLAG_SUB_SEEKETEMON_11") and Flg.Check("FLAG_SUB_SEEKETEMON_12") and Flg.Check("FLAG_SUB_SEEKETEMON_13") and Flg.Check("FLAG_SUB_SEEKETEMON_14") and Flg.Check("FLAG_SUB_SEEKETEMON_15") and Flg.Check("FLAG_SUB_SEEKETEMON_16") and Flg.Check("FLAG_SUB_SEEKETEMON_17") then
    Digitter.Send(2201020, true)
    WaitFrame(60)
    Qst.Sub:End(Sow_201.ID, Sow_201.STEP_255)
    Flg.Set("FLAG_IS_CLEAR_Sow_201")
  end
end

function SeekEtemon_T0101(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_01")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201031)
  else
    Digitter.Send(2201030)
  end
end

function SeekEtemon_T0102(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_02")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201041)
  else
    Digitter.Send(2201040)
  end
end

function SeekEtemon_T0104(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_03")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201051)
  else
    Digitter.Send(2201050)
  end
end

function SeekEtemon_T0105(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_04")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201061)
  else
    Digitter.Send(2201060)
  end
end

function SeekEtemon_T0106(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_05")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201071)
  else
    Digitter.Send(2201070)
  end
end

function SeekEtemon_T0108(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_06")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201081)
  else
    Digitter.Send(2201080)
  end
end

function SeekEtemon_T0109(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_07")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201091)
  else
    Digitter.Send(2201090)
  end
end

function SeekEtemon_T0110(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_08")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201101)
  else
    Digitter.Send(2201100)
  end
end

function SeekEtemon_T0111(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_09")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201111)
  else
    Digitter.Send(2201110)
  end
end

function SeekEtemon_T0201(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_10")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201121)
  else
    Digitter.Send(2201120)
  end
end

function SeekEtemon_T0203(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_11")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201131)
  else
    Digitter.Send(2201130)
  end
end

function SeekEtemon_T0301(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_12")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201141)
  else
    Digitter.Send(2201140)
  end
end

function SeekEtemon_T0302(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_13")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201151)
  else
    Digitter.Send(2201150)
  end
end

function SeekEtemon_T0401(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_14")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201161)
  else
    Digitter.Send(2201160)
  end
end

function SeekEtemon_D1101(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_15")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201171)
  else
    Digitter.Send(2201170)
  end
end

function SeekEtemon_D1102(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_16")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201181)
  else
    Digitter.Send(2201180)
  end
end

function SeekEtemon_D1103(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  Flg.Set("FLAG_SUB_SEEKETEMON_17")
  local npc_index = GetIndex(OGIM, npc_name)
  local npc_pos = Field.ObjectGetPosition(OGIM, npc_index)
  local npc_degree = Field.ObjectGetRotationY(OGIM, npc_index)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(OGIM, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_201.ID, Sow_201.STEP_010)
    Digitter.Send(2201191)
  else
    Digitter.Send(2201190)
  end
end
