Sow_202 = {
  ID = 202,
  STEP_001 = 1,
  STEP_010 = 10,
  STEP_255 = 255
}
local ItemID = 799
local Itemnum = 13
local text_file = "sow_202"

function SeekDrKuga_Start()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_START") then
    local tlk = Tlk:new(text_file, 1, true)
    tlk:StartTalkAndCancelDigimonRide()
    AnswerTheCall()
    tlk:Message("sow_202_010")
    tlk:Message("sow_202_020")
    tlk:Message("sow_202_030")
    tlk:Message("sow_202_040")
    tlk:Message("sow_202_050")
    tlk:Message("sow_202_060")
    tlk:Message("sow_202_070")
    tlk:Message("sow_202_080")
    tlk:Message("sow_202_090")
    tlk:EndTalk()
    EndTheCall()
    Digitter.Send(2202010, true)
    WaitFrame(45)
    Flg.Set("FLAG_SUB_SEEKDRKUGA_START")
  end
end

function SeekDrKuga_End()
  if not Flg.Check("FLAG_IS_CLEAR_Sow_202") and Flg.Check("FLAG_SUB_SEEKDRKUGA_START") and Flg.Check("FLAG_SUB_SEEKDRKUGA_01") and Flg.Check("FLAG_SUB_SEEKDRKUGA_02") and Flg.Check("FLAG_SUB_SEEKDRKUGA_03") and Flg.Check("FLAG_SUB_SEEKDRKUGA_04") and Flg.Check("FLAG_SUB_SEEKDRKUGA_05") and Flg.Check("FLAG_SUB_SEEKDRKUGA_06") and Flg.Check("FLAG_SUB_SEEKDRKUGA_07") and Flg.Check("FLAG_SUB_SEEKDRKUGA_08") and Flg.Check("FLAG_SUB_SEEKDRKUGA_09") and Flg.Check("FLAG_SUB_SEEKDRKUGA_10") and Flg.Check("FLAG_SUB_SEEKDRKUGA_11") and Flg.Check("FLAG_SUB_SEEKDRKUGA_12") and Flg.Check("FLAG_SUB_SEEKDRKUGA_13") then
    Digitter.Send(2202020, true)
    WaitFrame(60)
    Qst.Sub:End(Sow_202.ID, Sow_202.STEP_255)
    Flg.Set("FLAG_IS_CLEAR_Sow_202")
  end
end

function SeekDrKuga_T0101()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_01") and Flg.Check("FLAG_SUB_SEEKDRKUGA_101") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_01")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202031)
    else
      Digitter.Send(2202030)
    end
  end
end

function SeekDrKuga_T0102()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_02") and Flg.Check("FLAG_SUB_SEEKDRKUGA_102") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_02")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202041)
    else
      Digitter.Send(2202040)
    end
  end
end

function SeekDrKuga_T0103()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_03") and Flg.Check("FLAG_SUB_SEEKDRKUGA_103") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_03")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202051)
    else
      Digitter.Send(2202050)
    end
  end
end

function SeekDrKuga_T0104()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_04") and Flg.Check("FLAG_SUB_SEEKDRKUGA_104") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_04")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202061)
    else
      Digitter.Send(2202060)
    end
  end
end

function SeekDrKuga_T0105()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_05") and Flg.Check("FLAG_SUB_SEEKDRKUGA_105") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_05")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202071)
    else
      Digitter.Send(2202070)
    end
  end
end

function SeekDrKuga_T0107()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_06") and Flg.Check("FLAG_SUB_SEEKDRKUGA_106") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_06")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202081)
    else
      Digitter.Send(2202080)
    end
  end
end

function SeekDrKuga_T0108()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_07") and Flg.Check("FLAG_SUB_SEEKDRKUGA_107") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_07")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202091)
    else
      Digitter.Send(2202090)
    end
  end
end

function SeekDrKuga_T0109()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_08") and Flg.Check("FLAG_SUB_SEEKDRKUGA_108") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_08")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202101)
    else
      Digitter.Send(2202100)
    end
  end
end

function SeekDrKuga_T0110()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_09") and Flg.Check("FLAG_SUB_SEEKDRKUGA_109") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_09")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202111)
    else
      Digitter.Send(2202110)
    end
  end
end

function SeekDrKuga_T0111()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_10") and Flg.Check("FLAG_SUB_SEEKDRKUGA_110") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_10")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202121)
    else
      Digitter.Send(2202120)
    end
  end
end

function SeekDrKuga_T0201()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_11") and Flg.Check("FLAG_SUB_SEEKDRKUGA_111") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_11")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202131)
    else
      Digitter.Send(2202130)
    end
  end
end

function SeekDrKuga_T0203()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_12") and Flg.Check("FLAG_SUB_SEEKDRKUGA_112") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_12")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202141)
    else
      Digitter.Send(2202140)
    end
  end
end

function SeekDrKuga_T0401()
  if not Flg.Check("FLAG_SUB_SEEKDRKUGA_13") and Flg.Check("FLAG_SUB_SEEKDRKUGA_113") then
    local tlk = Tlk:new(text_file, 1, false)
    tlk:StartTalkAndCancelDigimonRide()
    Flg.Set("FLAG_SUB_SEEKDRKUGA_13")
    WaitFrame(30)
    INFO_GET_ITEM(ItemID, 1)
    tlk:EndTalk()
    if Item.GetNum(ItemID) == Itemnum then
      Qst.Sub:Set(Sow_202.ID, Sow_202.STEP_010)
      Digitter.Send(2202151)
    else
      Digitter.Send(2202150)
    end
  end
end
