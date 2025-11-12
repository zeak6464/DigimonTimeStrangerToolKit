Sow_200 = {
  ID = 200,
  STEP_001 = 1,
  STEP_010 = 10,
  STEP_255 = 255
}
local ItemID = 797
local Itemnum = 13
local text_file = "s900_165"

function SeekHiroko_Start()
  if not Flg.Check("FLAG_SUB_SEEKHIROKO_START") then
    Digitter.Send(2200010, true)
    WaitFrame(60)
    Flg.Set("FLAG_SUB_SEEKHIROKO_START")
  end
end

function SeekHiroko_End()
  if not Flg.Check("FLAG_IS_CLEAR_Sow_200") and Flg.Check("FLAG_SUB_SEEKHIROKO_START") and Flg.Check("FLAG_SUB_SEEKHIROKO_01") and Flg.Check("FLAG_SUB_SEEKHIROKO_02") and Flg.Check("FLAG_SUB_SEEKHIROKO_03") and Flg.Check("FLAG_SUB_SEEKHIROKO_04") and Flg.Check("FLAG_SUB_SEEKHIROKO_05") and Flg.Check("FLAG_SUB_SEEKHIROKO_06") and Flg.Check("FLAG_SUB_SEEKHIROKO_07") and Flg.Check("FLAG_SUB_SEEKHIROKO_08") and Flg.Check("FLAG_SUB_SEEKHIROKO_09") and Flg.Check("FLAG_SUB_SEEKHIROKO_10") and Flg.Check("FLAG_SUB_SEEKHIROKO_11") and Flg.Check("FLAG_SUB_SEEKHIROKO_12") and Flg.Check("FLAG_SUB_SEEKHIROKO_13") then
    Digitter.Send(2200020, true)
    WaitFrame(60)
    Qst.Sub:End(Sow_200.ID, Sow_200.STEP_255)
    Flg.Set("FLAG_IS_CLEAR_Sow_200")
  end
end

function SeekHiroko_BeforeD02(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_01")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, npc_index, "e004")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  ObjectTurnToPlayer(NPC, npc_name)
  WaitFrame(45)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e004", 5, 5)
  WaitFrame(15)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200032)
  else
    Digitter.Send(2200030)
  end
end

function SeekHiroko_BeforeD03(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_02")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  WaitFrame(90)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200042)
  else
    Digitter.Send(2200040)
  end
end

function SeekHiroko_BeforeD04(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_03")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, npc_index, "e076")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e076", 5, 5)
  WaitFrame(60)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200052)
  else
    Digitter.Send(2200050)
  end
end

function SeekHiroko_BeforeD05(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_04")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  ObjectTurnToPlayer(NPC, npc_name)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200062)
  else
    Digitter.Send(2200060)
  end
end

function SeekHiroko_BeforeD06(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_05")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  WaitFrame(90)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200072)
  else
    Digitter.Send(2200070)
  end
end

function SeekHiroko_AfterD01(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_06")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  WaitFrame(90)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200082)
  else
    Digitter.Send(2200080)
  end
end

function SeekHiroko_AfterD02(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_07")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  WaitFrame(90)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200092)
  else
    Digitter.Send(2200090)
  end
end

function SeekHiroko_AfterD03(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_08")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  ObjectTurnToPlayer(NPC, npc_name)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200102)
  else
    Digitter.Send(2200100)
  end
end

function SeekHiroko_AfterD04(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_09")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  ObjectTurnToPlayer(NPC, npc_name)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200112)
  else
    Digitter.Send(2200110)
  end
end

function SeekHiroko_AfterD05(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_10")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  ObjectTurnToPlayer(NPC, npc_name)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200122)
  else
    Digitter.Send(2200120)
  end
end

function SeekHiroko_AfterD06(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_11")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  WaitFrame(90)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200132)
  else
    Digitter.Send(2200130)
  end
end

function SeekHiroko_AfterD07(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_12")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  WaitFrame(90)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200142)
  else
    Digitter.Send(2200140)
  end
end

function SeekHiroko_AfterD12(npc_name)
  local tlk = Tlk:new(text_file, 1, false)
  tlk:StartTalkAndCancelDigimonRide()
  START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  Flg.Set("FLAG_SUB_SEEKHIROKO_13")
  local npc_index = GetIndex(NPC, npc_name)
  local npc_pos = Field.ObjectGetPosition(NPC, npc_index)
  local npc_degree = Field.ObjectGetRotationY(FLD_OBJ_NPC, npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
  WaitFrame(30)
  ObjectTurnToPlayer(NPC, npc_name)
  WaitFrame(30)
  PlayEffectScript("ef_b_van_100", npc_pos.x, npc_pos.y, npc_pos.z, npc_degree, 0.5)
  Field.ObjectInvisible(NPC, npc_index, 1, 30, false)
  WaitFrame(60)
  INFO_GET_ITEM(ItemID, 1)
  tlk:EndTalk()
  END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
  if Item.GetNum(ItemID) == Itemnum then
    Qst.Sub:Set(Sow_200.ID, Sow_200.STEP_010)
    Digitter.Send(2200152)
  else
    Digitter.Send(2200150)
  end
end

function Hiroko_LoadMotion(npc_index)
  Field.ObjectLoadMotion(NPC, npc_index, "fn01_01")
  Field.ObjectLoadMotion(NPC, npc_index, "e002")
  Field.ObjectLoadMotion(NPC, npc_index, "e003")
  Field.ObjectLoadMotion(NPC, npc_index, "e003_selfie")
  Field.ObjectLoadMotion(NPC, npc_index, "e004")
  Field.ObjectLoadMotion(NPC, npc_index, "e005")
  Field.ObjectLoadMotion(NPC, npc_index, "e006")
  Field.ObjectLoadMotion(NPC, npc_index, "e007")
  Field.ObjectLoadMotion(NPC, npc_index, "e008")
  Field.ObjectLoadMotion(NPC, npc_index, "e009")
  Field.ObjectLoadMotion(NPC, npc_index, "e012")
  Field.ObjectLoadMotion(NPC, npc_index, "e013")
  Field.ObjectLoadMotion(NPC, npc_index, "e014")
  Field.ObjectLoadMotion(NPC, npc_index, "e015")
  Field.ObjectLoadMotion(NPC, npc_index, "e018")
  Field.ObjectLoadMotion(NPC, npc_index, "e019")
  Field.ObjectLoadMotion(NPC, npc_index, "e020")
  Field.ObjectLoadMotion(NPC, npc_index, "e021")
  Field.ObjectLoadMotion(NPC, npc_index, "e023")
  Field.ObjectLoadMotion(NPC, npc_index, "e032")
  Field.ObjectLoadMotion(NPC, npc_index, "e033")
  Field.ObjectLoadMotion(NPC, npc_index, "e076")
  Field.ObjectLoadMotion(NPC, npc_index, "e559")
end
