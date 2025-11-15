PRICE = 1000

function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  local npc_text = "d02"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 201 then
    local sp_text = "field_text"
    if talk_id == 300 then
      local npc_0001_bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
      local npc_0001_f000 = Motion.Object:new(NPC, "npc_0001", "f000")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0001_bn01:Play(15, true)
      Message("f_d0201_0370_0010")
      npc_0001_f000:Play(15, true)
      Message("f_d0201_0370_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    elseif talk_id == 318 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0370_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    elseif talk_id == 301 then
      local fldtxt = "d02"
      local npc_0003_bn01 = Motion.Object:new(NPC, "npc_0003", "bn01")
      local npc_0003_fq01 = Motion.Object:new(NPC, "npc_0003", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0003_bn01:Play(15, true)
      Message("f_d0201_0380_0010")
      npc_0003_fq01:Play(15, true)
      Message("f_d0201_0380_0020")
      END_TALK_ACTION_AND_ZOOM("npc_0003", true, true)
      Field_Talk_End_Not_LetterBox()
    elseif talk_id == 501 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0390_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    elseif talk_id == 500 then
      Field_Talk_Start_Not_LetterBox(sp_text, 1)
      Message("g_wm_0010_0010")
      Field_Talk_End_Not_LetterBox()
      OpenWorldMap(DW, LOCOMON)
    elseif talk_id == 302 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0420_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    elseif talk_id == 450 then
      if Qst.Sub:IsCompleted(78) then
        require("S095_078")
        S095_078:Event_070()
      end
      local cam_npc = {
        13.34,
        2.09,
        4.76,
        4.07,
        4.38,
        5.23
      }
      local cam_shop = {
        13.5,
        2.38,
        3.07,
        3.95,
        4.63,
        5.03
      }
      if Common.CheckTimeAxis("A2028_daft_360", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_360", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_390") then
        CommonShopStart(npc_name, 106, "ba02", "bs01", "fq02", cam_npc, cam_shop, nil, "bs01")
      else
        CommonShopStart(npc_name, 101, "ba02", "bs01", "fq02", cam_npc, cam_shop, nil, "bs01")
      end
    elseif talk_id == 451 then
      if Qst.Sub:IsCompleted(78) then
        require("S095_078")
        S095_078:Event_050()
      end
      if Flg.Check("FLAG_MAIN_03_480") then
        local cam_npc = {
          -32.55,
          4.3,
          28.73,
          -24.57,
          3.77,
          34.74
        }
        local cam_shop = {
          -34.044,
          3.599,
          31.34,
          -24.679,
          3.841,
          34.84
        }
        if Common.CheckTimeAxis("A2028_daft_360", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_360", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_390") then
          CommonShopStart(npc_name, 115, "fq01", "fe02", "fq01", cam_npc, cam_shop, nil, "fq01")
        else
          CommonShopStart(npc_name, 111, "fq01", "fe02", "fq01", cam_npc, cam_shop, nil, "fq01")
        end
      elseif not Flg.Check("FLAG_MAIN_03_480") then
        M120:Event_033()
        local cam_npc = {
          -32.55,
          4.3,
          28.73,
          -24.57,
          3.77,
          34.74
        }
        local cam_shop = {
          -34.66,
          5.27,
          32.33,
          -24.99,
          3.84,
          34.46
        }
        CommonShopStart(npc_name, 111, "fq01", "fe02", "fq01", cam_npc, cam_shop, nil, "fq01")
      end
    elseif talk_id == 452 then
      if Qst.Sub:IsCompleted(78) then
        require("S095_078")
        S095_078:Event_060()
      end
      if Flg.Check("FLAG_MAIN_03_480") then
        local cam_npc = {
          -31.3,
          2.66,
          27.16,
          -22.84,
          3.9,
          32.33
        }
        local cam_shop = {
          -32.07,
          3.05,
          28.94,
          -22.71,
          3.82,
          32.38
        }
        if Common.CheckTimeAxis("A2028_daft_360", "A2028_daft_450") or Common.CheckTimeAxis("P2028_daft_360", "P2028_daft_450") or Common.CheckTimeAxis("Z2028_daft_390") then
          CommonShopStart(npc_name, 124, "ba02", "fe02", "fe04", cam_npc, cam_shop, nil, "fe02")
        else
          CommonShopStart(npc_name, 121, "ba02", "fe02", "fe04", cam_npc, cam_shop, nil, "fe02")
        end
      elseif not Flg.Check("FLAG_MAIN_03_480") then
        M120:Event_033()
        local cam_npc = {
          -31.3,
          2.66,
          27.16,
          -22.84,
          3.9,
          32.33
        }
        local cam_shop = {
          -32.07,
          3.05,
          28.94,
          -22.71,
          3.82,
          32.38
        }
        CommonShopStart(npc_name, 121, "ba02", "ba02", "ba02", cam_npc, cam_shop, nil, "fe02")
      end
    elseif talk_id == 454 then
      local cam_npc = {
        -10.52,
        2.23,
        -14.94,
        -0.83,
        4.62,
        -14.32
      }
      local cam_shop = {
        -10.66,
        1.38,
        -12.35,
        -1.42,
        4.75,
        -14.15
      }
      CommonShopStart(npc_name, 103, "fe02", "fe04", "fe02", cam_npc, cam_shop, "f000", "fe02")
    elseif talk_id == 453 then
      local zudo_index_1 = GetIndex(NPC, "zudo_01")
      local zudo_index_2 = GetIndex(NPC, "shop_0004")
      local zudo_01 = Motion.Object:new(NPC, "zudo_01", "f000")
      local shop_0004 = Motion.Object:new(NPC, "shop_0004", "f000")
      require("S050_038")
      require("S050_039")
      if Flg.Check("FLAG_SUB_050_039_003") and not Qst.Sub:IsCompleted(S050_039.ID) then
        S050_039:Event_020()
      elseif not Qst.Sub:IsCompleted(S050_038.ID) and Qst.Main:IsCompleted(M140.ID) then
        S050_038:Event_010()
        S050_038:Event_030()
      elseif not Qst.Sub:IsCompleted(S050_039.ID) and not Flg.Check("FLAG_SUB_050_039_002") and Qst.Main:IsCompleted(M150.ID) and Qst.Sub:IsCompleted(S050_038.ID) then
        S050_039:Event_010()
        S050_039:Event_001()
      elseif Qst.Sub:IsCompleted(S050_038.ID) and Qst.Main:IsCompleted(M140.ID) then
        local cam_npc = {
          13.615,
          3.701,
          26.697,
          5.997,
          5.477,
          32.927
        }
        local cam_shop = {
          11.75,
          6.04,
          23.979,
          6.192,
          5.202,
          32.25
        }
        DevelopShopStart(npc_name, 150, "fe04", "fq01", "fq01", cam_npc, cam_shop, "f000", "fe02")
        WaitFrame(15)
        shop_0004:Play(15, true)
      else
        Cam.Inst:Set(11.419147, 5.078602, 26.51301, 5.484033, 3.858501, 34.468246, default, 45)
        WaitFrame(40)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0201_0310_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Cam.Inst:Clear(45)
      end
    elseif talk_id == 455 then
      Prcs_d0201_ropCam()
      Shop.Open(110)
      WaitCloseShopWindow()
      ShopClose()
      Cam.Follower:ResetFromObject(NPC, "shop_0006")
      Obj:new(PLAYER, ""):CancelInvisible()
      Cam.Inst:Clear(20)
    end
    if npc_name == "kote_03" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0201_1200_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "s080_059_001" or npc_name == "s080_059_002" then
      require("S080_059")
      S080_059:Event_010()
    end
    if npc_name == "s080_059_003" then
      require("S080_059")
      S080_059:Event_080()
      S080_059:Event_010()
    end
    if npc_name == "s080_059_002_02" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S080_059")
      S080_059:Event_110()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "s080_060_001" then
      require("S080_060")
      S080_060:Event_130()
      S080_060:Event_010()
    end
    if npc_name == "S200_150_wanya_01" then
      require("S200_150")
      S200_150:Event_070()
    end
    if npc_name == "s110_091_003" then
      require("S110_091")
      S110_091:Event_010()
    end
    if talk_id == 601 then
      NPCtalk_npc_3021and3022()
    end
    if talk_id == 602 then
      NPCtalk_npc_3021and3022()
    end
    if talk_id == 606 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0510_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 607 then
      local puni = GetIndex(NPC, "npc_3026")
      local player = Field.GetPlayerIndex()
      local npc3026_pos = Field.ObjectGetPosition(NPC, puni)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(npc3026_pos.x, npc3026_pos.z, player_pos.x, player_pos.z)
      local npc_3026_bn01 = Motion.Object:new(NPC, "npc_3026", "bn01")
      local npc_3026_fe02 = Motion.Object:new(NPC, "npc_3026", "fe02")
      local npc_3026 = Obj:new(NPC, "npc_3026")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_3026_bn01:Play(15, true)
      Message("f_d0201_0520_0010")
      MessageClose()
      WaitFrame(30)
      npc_3026_fe02:Play(15, true)
      Message("f_d0201_0520_0020")
      npc_3026_bn01:Play(15, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 308 then
      local npc_0308_bn01 = Motion.Object:new(NPC, "npc_0308", "bn01")
      local npc_0308 = Obj:new(NPC, "npc_0308")
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0308_bn01:Play(10, true)
        Message("f_d0201_0130_0040")
        Message("f_d0201_0130_0050")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0308_bn01:Play(10, true)
        Message("f_d0201_0130_0040")
        Message("f_d0201_0130_0050")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM("npc_0308", true, false)
        npc_0308:SetRotationYToPlayerAndAnimRun(15)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0308_bn01:Play(10, true)
        Message("f_d0201_0130_0010")
        Message("f_d0201_0130_0020")
        END_TALK_ACTION_AND_ZOOM("npc_0308", false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 309 then
      local vege = GetIndex(NPC, "npc_0309")
      local vege01 = Obj:new(NPC, "npc_0309")
      local player = Field.GetPlayerIndex()
      local npc0309_pos = Field.ObjectGetPosition(NPC, vege)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(npc0309_pos.x, npc0309_pos.z, player_pos.x, player_pos.z)
      local npc_0309_bn01 = Motion.Object:new(NPC, "npc_0309", "bn01")
      local npc_0309_br01 = Motion.Object:new(NPC, "npc_0309", "br01")
      local npc_0309_fe03 = Motion.Object:new(NPC, "npc_0309", "fe03")
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM("npc_0309", false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectSetRotationY(FLD_OBJ_NPC, vege, y_degree, 15)
        npc_0309_br01:Play(10, true)
        WaitFrame(15)
        npc_0309_bn01:Play(10, true)
        Message("f_d0201_0120_0040")
        END_TALK_ACTION_AND_ZOOM("npc_0309", false, false)
        Field_Talk_End_Not_LetterBox()
        vege01:ClearRotationY(15)
        npc_0309_fe03:Reset(15)
      elseif Flg.Check("FLAG_MAIN_04_000") then
        START_TALK_ACTION_AND_ZOOM("npc_0309", false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectSetRotationY(FLD_OBJ_NPC, vege, y_degree, 15)
        npc_0309_br01:Play(10, true)
        WaitFrame(15)
        npc_0309_bn01:Play(10, true)
        Message("f_d0201_0120_0030")
        END_TALK_ACTION_AND_ZOOM("npc_0309", false, false)
        Field_Talk_End_Not_LetterBox()
        vege01:ClearRotationY(15)
        npc_0309_fe03:Reset(15)
      else
        START_TALK_ACTION_AND_ZOOM("npc_0309", false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectSetRotationY(FLD_OBJ_NPC, vege, y_degree, 15)
        npc_0309_br01:Play(10, true)
        WaitFrame(15)
        npc_0309_bn01:Play(10, true)
        Message("f_d0201_0120_0010")
        Message("f_d0201_0120_0020")
        END_TALK_ACTION_AND_ZOOM("npc_0309", false, false)
        Field_Talk_End_Not_LetterBox()
        vege01:ClearRotationY(15)
        npc_0309_fe03:Reset(15)
      end
    end
    if talk_id == 310 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0480_0010")
      Message("f_d0201_0480_0020")
      Message("f_d0201_0480_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 311 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0480_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 312 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0480_0050")
      Message("f_d0201_0480_0060")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 313 then
      NPCtalk_npc_0313and0314()
    end
    if talk_id == 314 then
      NPCtalk_npc_0313and0314()
    end
    if talk_id == 315 then
      local npc_0315_bn01 = Motion.Object:new(NPC, "npc_0315", "bn01")
      local npc_0315_fe02 = Motion.Object:new(NPC, "npc_0315", "fe02")
      local npc_0315_fe04 = Motion.Object:new(NPC, "npc_0315", "fe04")
      local npc_622_fe02 = Motion.Object:new(NPC, "npc_622", "fe02")
      local npc_622_fe04 = Motion.Object:new(NPC, "npc_622", "fe04")
      local fldtxt = "d02"
      Cam.Inst:Set(-6.245532, 3.016882, -44.459526, -1.258948, 6.316666, -52.47485, default, 45)
      WaitFrame(40)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      START_TALK_ACTION_AND_ZOOM("npc_0315", true, false)
      npc_0315_bn01:Play(10, true)
      Message("f_d0201_0500_0010")
      npc_622_fe02:Play(10, true)
      Message("f_d0201_0530_0010")
      npc_0315_fe02:Play(10, true)
      Field.EndPlayerAndNpcTalkAction("npc_0315")
      Message("f_d0201_0500_0020")
      npc_0315_fe04:Play(10, true)
      npc_622_fe04:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(45)
    end
    if talk_id == 316 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0130_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 317 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0120_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 605 then
      local bn01 = Motion.Object:new(NPC, "npc_3023", "bn01")
      local fe04 = Motion.Object:new(NPC, "npc_3023", "fe04")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe04:Play(10, true)
      Message("f_d0201_0010_0010")
      bn01:Play(10, true)
      Message("f_d0201_0010_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 608 then
      local bn01 = Motion.Object:new(NPC, "npc_608", "bn01")
      local fq01 = Motion.Object:new(NPC, "npc_608", "fq01")
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        bn01:Play(20, true)
        Message("f_d0201_0020_0050")
        fq01:Play(20, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        bn01:Play(20, true)
        Message("f_d0201_0020_0030")
        Message("f_d0201_0020_0040")
        fq01:Play(20, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_630") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        bn01:Play(20, true)
        Message("f_d0201_0020_0060")
        Message("f_d0201_0020_0070")
        fq01:Play(20, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        bn01:Play(20, true)
        Message("f_d0201_0020_0010")
        Message("f_d0201_0020_0020")
        fq01:Play(20, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 610 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0030_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 624 then
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_000") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_0550_0040")
        Message("f_d0201_0550_0050")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      elseif Flg.Check("FLAG_MAIN_03_610") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_0550_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_0550_0010")
        Message("f_d0201_0550_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 611 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      local fldtxt = "d02"
      Field_Talk_Start(fldtxt, 1)
      Message("f_d0201_0040_0010")
      Message("f_d0201_0040_0020")
      Message("f_d0201_0040_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End()
      M120:Event_035()
    end
    if talk_id == 612 then
      if Flg.Check("FLAG_MAIN_03_494") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        local fldtxt = "d02"
        Field_Talk_Start(fldtxt, 1)
        Message("f_d0201_0050_0100")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif not Flg.Check("FLAG_MAIN_03_494") then
        local npc_612_bn01 = Motion.Object:new(NPC, "npc_612", "bn01")
        local npc_612_fq01 = Motion.Object:new(NPC, "npc_612", "fq01")
        local npc_612_fq02 = Motion.Object:new(NPC, "npc_612", "fq02")
        local npc_612_fe02 = Motion.Object:new(NPC, "npc_612", "fe02")
        local npc_612_fe04 = Motion.Object:new(NPC, "npc_612", "fe04")
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        local fldtxt = "d02"
        Field_Talk_Start(fldtxt, 1)
        Flg.Set("FLAG_MAIN_03_494")
        Message("f_d0201_0050_0010")
        npc_612_fq02:Play(10, true)
        Message("f_d0201_0050_0020")
        WaitFrame(15)
        Motion.Player:PlayWithMoveMotion("e002", 5, 5)
        MessageClose()
        WaitFrame(90)
        npc_612_bn01:Play(10, true)
        Message("f_d0201_0050_0030")
        npc_612_fq01:Play(10, true)
        Message("f_d0201_0050_0040")
        npc_612_bn01:Play(10, true)
        MessageClose()
        MessageTalkSel(2, "f_d0201_0050_0050")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          npc_612_fe02:Play(10, true)
          Message("f_d0201_0050_0060")
          npc_612_bn01:Play(10, true)
          Message("f_d0201_0050_0080")
          Message("f_d0201_0050_0090")
          Message("f_d0201_0050_0100")
          Field_Talk_End()
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        elseif result == RESULT_TALK01 then
          npc_612_fe04:Play(10, true)
          Message("f_d0201_0050_0070")
          npc_612_bn01:Play(10, true)
          Message("f_d0201_0050_0080")
          Message("f_d0201_0050_0090")
          Message("f_d0201_0050_0100")
          Field_Talk_End()
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        end
        M120:Event_038()
      end
    end
    if npc_name == "npc_lock_0001" then
      local npc_lock_0001 = GetIndex(NPC, "npc_lock_0001")
      local npc_lock_0002 = GetIndex(NPC, "npc_lock_0002")
      Field.ObjectLoadMotion(NPC, npc_lock_0001, "fe01")
      Field.ObjectLoadMotion(NPC, npc_lock_0002, "ba02")
      Field.ObjectLoadMotion(NPC, npc_lock_0001, "bn01")
      Field.ObjectLoadMotion(NPC, npc_lock_0002, "bn01")
      local tlk = Tlk:new("d02", 1, false)
      tlk:StartTalk()
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_lock_0002, "ba02", 15, 15)
      tlk:Message("f_d0201_1230_0010")
      Field.ObjectPlayMotion(NPC, npc_lock_0001, "fe01", 15, true)
      tlk:Message("f_d0201_1230_0020")
      tlk:EndTalk()
      Field.ObjectResetMotion(NPC, npc_lock_0001, 20)
      Field.ObjectResetMotion(NPC, npc_lock_0002, 20)
    end
    if talk_id == 2 then
      if Flg.Check("FLAG_MAIN_04_990", "FLAG_FIELD_D0606_001") then
        local tlk = Tlk:new("d06", 1, true)
        local bn01 = Motion.Object:new(NPC, "loco_mummy", "bn01")
        local fe04 = Motion.Object:new(NPC, "loco_mummy", "fe04")
        local fq01 = Motion.Object:new(NPC, "loco_mummy", "fq01")
        tlk:StartTalk()
        tlk:Message("f_d0606_0050_0010")
        tlk:Message("f_d0606_0050_0020")
        fq01:PlayWithStartMoveMotion(15, 15)
        tlk:Message("f_d0606_0050_0030")
        tlk:EndTalk()
        Flg.Set("FLAG_FIELD_D0606_001")
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        OpenWorldMap(DW, LOCOMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      else
        local tlk = Tlk:new("d02", 1, true)
        local bn01 = Motion.Object:new(NPC, "loco_mummy", "bn01")
        local fe04 = Motion.Object:new(NPC, "loco_mummy", "fe04")
        local fq01 = Motion.Object:new(NPC, "loco_mummy", "fq01")
        tlk:StartTalk()
        fq01:PlayWithStartMoveMotion(15, 15)
        tlk:Message("f_d0201_0080_0020")
        tlk:EndTalk()
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        OpenWorldMap(DW, LOCOMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      end
    end
    if talk_id == 613 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0201_0090_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 614 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0201_0100_0010")
      Message("f_d0201_0100_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 615 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0110_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 623 then
      local fe03 = Motion.Object:new(NPC, "npc_623", "fe03")
      local fe04 = Motion.Object:new(NPC, "npc_623", "fe04")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe03:Play(15, true)
      Message("f_d0201_0540_0010")
      fe04:Play(15, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 616 then
      Prcs_d0201_merukuri_0001Cam()
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0201_0230_0010")
      Message("f_d0201_0230_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 617 then
      local e013 = Motion.Object:new(NPC, "npc_617", "e013")
      local e008 = Motion.Object:new(NPC, "npc_617", "e008")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      e008:Play(15, true)
      Message("f_d0201_0240_0010")
      Message("f_d0201_0240_0020")
      e013:Play(15, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 618 then
      local e007 = Motion.Object:new(NPC, "npc_618", "e007")
      local e004 = Motion.Object:new(NPC, "npc_618", "e004")
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      e007:Play(5, true)
      Message("f_d0201_0250_0010")
      Field.StartPlayerAndNpcTalkAction(npc_name)
      Message("f_d0201_0250_0020")
      e004:Play(5, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 619 then
      local bn01 = Motion.Object:new(NPC, "npc_619", "bn01")
      local e004 = Motion.Object:new(NPC, "npc_619", "e004")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      e004:Play(15, true)
      Message("f_d0201_0260_0010")
      Message("f_d0201_0260_0020")
      bn01:Play(15, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 620 then
      local e006 = Motion.Object:new(NPC, "npc_620", "e006")
      local e007 = Motion.Object:new(NPC, "npc_620", "e007")
      local e102 = Motion.Object:new(NPC, "npc_620", "e102")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      e006:Play(5, true)
      Message("f_d0201_0270_0010")
      e007:Play(5, true)
      Message("f_d0201_0270_0020")
      e102:Play(15, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 621 then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0201_0280_0010")
      Message("f_d0201_0280_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 3 then
      if Flg.Check("FLAG_MAIN_05_030") then
        local fldtxt = "d02"
        Cam.Inst:Set(-5.909443, 4.49956, -94.495987, -14.794685, 6.750445, -90.49752, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_0630_0040")
        Message("f_d0201_0630_0050")
        Cam.Inst:Clear(30)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        local fldtxt = "d02"
        Cam.Inst:Set(-5.909443, 4.49956, -94.495987, -14.794685, 6.750445, -90.49752, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_0630_0010")
        Message("f_d0201_0630_0020")
        Message("f_d0201_0630_0030")
        Cam.Inst:Clear(30)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 700 then
      local fldtxt = "d02"
      Cam.Inst:Set(-16.952127, 2.661355, 67.956741, -22.909313, 5.022893, 75.633659, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0560_0010")
      Message("f_d0201_0560_0020")
      Message("f_d0201_0560_0030")
      Message("f_d0201_0560_0040")
      Message("f_d0201_0560_0050")
      Message("f_d0201_0560_0060")
      Message("f_d0201_0560_0070")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 701 then
      local cam_npc = {
        -32.14,
        5.08,
        29.42,
        -24.06,
        3.7,
        35.15
      }
      local cam_shop = {
        -33.81,
        6.29,
        32.17,
        -24.53,
        3.66,
        34.78
      }
      CommonShopStart(npc_name, 160, "fe03", "ba02", "fq01", cam_npc, cam_shop)
    end
    if talk_id == 702 then
      local cam_npc = {
        -29.43,
        4.1,
        25.05,
        -23.08,
        3.76,
        32.77
      }
      local cam_shop = {
        -30.83,
        5.31,
        25.85,
        -23.47,
        3.78,
        32.45
      }
      CommonShopStart(npc_name, 161, "fe02", "fq01", "fe04", cam_npc, cam_shop)
    end
    if talk_id == 703 then
      local cam_npc = {
        13.615,
        3.701,
        26.697,
        5.997,
        5.477,
        32.927
      }
      local cam_shop = {
        12.543,
        6.28,
        23.428,
        6.743,
        4.732,
        31.426
      }
      DevelopShopStart(npc_name, 151, "fq01", "fe04", "fe04", cam_npc, cam_shop, nil, "fe02")
    end
    if talk_id == 704 then
      local cam_npc = {
        11.45,
        5.71,
        3.86,
        1.67,
        4.89,
        5.78
      }
      local cam_shop = {
        10.6,
        9.27,
        3.02,
        2.15,
        4.44,
        5.32
      }
      CommonShopStart(npc_name, 163, "ba02", "fq01", "fe01", cam_npc, cam_shop)
    end
    if talk_id == 705 then
      local cam_npc = {
        -9.97,
        1.14,
        -15.05,
        -1.03,
        5.55,
        -14.25
      }
      local cam_shop = {
        -9.91,
        1.3,
        -13.28,
        -1.04,
        5.89,
        -13.82
      }
      CommonShopStart(npc_name, 162, "fe04", "fe02", "fe01", cam_npc, cam_shop)
    end
    if talk_id == 706 then
      local fldtxt = "d02"
      Cam.Inst:Set(8.181644, 6.445035, -54.388554, 4.541531, 4.298033, -45.325474, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0570_0010")
      Message("f_d0201_0570_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 707 then
      local fldtxt = "d02"
      Cam.Inst:Set(-5.19545, 4.525402, -71.567787, 1.554772, 7.017381, -64.617661, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0580_0010")
      Message("f_d0201_0580_0020")
      Message("f_d0201_0580_0030")
      Message("f_d0201_0580_0040")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 708 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0590_0010")
      Message("f_d0201_0590_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 709 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0600_0010")
      Message("f_d0201_0600_0020")
      Message("f_d0201_0600_0030")
      Message("f_d0201_0600_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 710 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0610_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 711 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0620_0010")
      Message("f_d0201_0620_0020")
      Message("f_d0201_0620_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 712 then
      local fldtxt = "d02"
      Cam.Inst:Set(13.992767, 3.608019, -13.187075, 6.558427, 5.811996, -6.872561, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0640_0010")
      Message("f_d0201_0640_0020")
      Message("f_d0201_0640_0030")
      Message("f_d0201_0640_0040")
      Message("f_d0201_0640_0050")
      Message("f_d0201_0640_0060")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 714 then
      local fldtxt = "d02"
      Cam.Inst:Set(8.428112, 4.157952, -0.59799, 1.746661, 7.006828, -7.47128, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0650_0010")
      Message("f_d0201_0650_0020")
      Message("f_d0201_0650_0030")
      Message("f_d0201_0650_0040")
      Message("f_d0201_0650_0050")
      Message("f_d0201_0650_0060")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 715 then
      local fldtxt = "d02"
      Cam.Inst:Set(-23.21248, 1.321376, 45.031662, -24.183235, 4.766621, 54.369106, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0660_0010")
      Message("f_d0201_0660_0020")
      Message("f_d0201_0660_0030")
      Message("f_d0201_0660_0040")
      Message("f_d0201_0660_0050")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 716 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0670_0010")
      Message("f_d0201_0670_0020")
      Message("f_d0201_0670_0030")
      Message("f_d0201_0670_0040")
      Message("f_d0201_0670_0050")
      Message("f_d0201_0670_0060")
      Message("f_d0201_0670_0070")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 717 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0680_0010")
      Message("f_d0201_0680_0020")
      Message("f_d0201_0680_0030")
      Message("f_d0201_0680_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 718 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0690_0010")
      Message("f_d0201_0690_0020")
      Message("f_d0201_0690_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 719 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0700_0010")
      Message("f_d0201_0700_0020")
      Message("f_d0201_0700_0030")
      Message("f_d0201_0700_0040")
      Message("f_d0201_0700_0050")
      Message("f_d0201_0700_0060")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 720 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_1220_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 756 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_1040_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 757 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_1050_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 773 then
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_13_148") then
        local tlk = Tlk:new("d02", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0201_1080_0010")
        tlk:EndTalk()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_1060_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 774 then
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_13_148") then
        local tlk = Tlk:new("d02", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0201_1090_0010")
        tlk:EndTalk()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_1070_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 775 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_1080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 776 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_1090_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 777 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0900_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 778 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0900_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 801 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0720_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 802 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0730_0010")
      Message("f_d0201_0730_0020")
      Message("f_d0201_0730_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 803 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0740_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 804 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0750_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 805 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0760_0010")
      Message("f_d0201_0760_0020")
      Message("f_d0201_0760_0030")
      Message("f_d0201_0760_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 806 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0770_0010")
      Message("f_d0201_0770_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 807 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0780_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 808 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0790_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 809 then
      if Flg.Check("FLAG_FIELD_t01_010") then
        local fldtxt = "d02"
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_800_0020")
        Message("f_d0201_800_0030")
        Message("f_d0201_800_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        local fldtxt = "d02"
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0201_800_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 810 then
      local fldtxt = "d02"
      Cam.Inst:Set(-4.85, 4.66, -58.69, -2.77, 6.56, -49.1, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_810_0010")
      Message("f_d0201_810_0020")
      Message("f_d0201_810_0030")
      Message("f_d0201_810_0040")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 812 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_820_0010")
      Message("f_d0201_820_0020")
      Message("f_d0201_820_0030")
      Message("f_d0201_820_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 813 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_830_0010")
      Message("f_d0201_830_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 814 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_840_0010")
      Message("f_d0201_840_0020")
      Message("f_d0201_840_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 815 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_850_0010")
      Message("f_d0201_850_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 816 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_860_0010")
      Message("f_d0201_860_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 817 then
      local fldtxt = "d02"
      local bn01 = Motion.Object:new(NPC, "npc_817", "bn01")
      local fe02 = Motion.Object:new(NPC, "npc_817", "fe02")
      local fq02 = Motion.Object:new(NPC, "npc_817", "fq02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe02:Play(10, true)
      Message("f_d0201_870_0010")
      bn01:Play(10, true)
      Message("f_d0201_870_0020")
      fe02:Play(10, true)
      Message("f_d0201_870_0030")
      Message("f_d0201_870_0040")
      fq02:Play(10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 818 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0910_0010")
      Message("f_d0201_0910_0020")
      Message("f_d0201_0910_0030")
      Message("f_d0201_0910_0040")
      Message("f_d0201_0910_0050")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s020_173_001" then
      require("S020_173")
      S020_173:Event_040()
    end
    if npc_name == "card_001" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0201_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1201, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0201_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0201_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0201_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "npc_warp01" then
      D02_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      if not Flg.Check("FLAG_MAIN_13_180") then
        D02_WarpNPC_After(npc_name)
      else
        D02_WarpNPC_After2(npc_name)
      end
    end
  elseif gMapNum == 202 then
    if talk_id == 316 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0190_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 317 then
      local pekku = GetIndex(NPC, "npc_0017")
      local player = Field.GetPlayerIndex()
      local npc0017_pos = Field.ObjectGetPosition(NPC, pekku)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(npc0017_pos.x, npc0017_pos.z, player_pos.x, player_pos.z)
      local npc_0017_bn01 = Motion.Object:new(NPC, "npc_0017", "bn01")
      local npc_0017_bn02 = Motion.Object:new(NPC, "npc_0017", "bn02")
      local npc_0017_fq02 = Motion.Object:new(NPC, "npc_0017", "fq02")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      WaitFrame(5)
      npc_0017_bn01:Play(15, true)
      Message("f_d0202_0200_0030")
      npc_0017_fq02:Play(15, true)
      Message("f_d0202_0200_0040")
      END_TALK_ACTION_AND_ZOOM("npc_0017", true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 318 then
      local npc_0018_bn01 = Motion.Object:new(NPC, "npc_0018", "bn01")
      local npc_0018_fe02 = Motion.Object:new(NPC, "npc_0018", "fe02")
      local npc_0018_fq01 = Motion.Object:new(NPC, "npc_0018", "fq01")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0400_0010")
      Message("f_d0202_0400_0020")
      npc_0018_fe02:Play(10, true)
      Message("f_d0202_0400_0030")
      npc_0018_bn01:Play(10, true)
      MessageClose()
      WaitFrame(15)
      Message("f_d0202_0400_0040")
      npc_0018_fq01:Play(10, true)
      Message("f_d0202_0400_0050")
      npc_0018_bn01:Play(10, true)
      MessageClose()
      WaitFrame(30)
      Message("f_d0202_0400_0060")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 319 then
      local npc_0019_bn01 = Motion.Object:new(NPC, "npc_0019", "bn01")
      local npc_0019_fe02 = Motion.Object:new(NPC, "npc_0019", "fe02")
      local npc_0019_fe04 = Motion.Object:new(NPC, "npc_0019", "fe04")
      local npc_0019 = Obj:new(NPC, "npc_0019")
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_03_630") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0019_bn01:Play(15, true)
        Message("f_d0202_0220_0020")
        npc_0019_fe04:Play(15, true)
        Message("f_d0202_0220_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        npc_0019_fe02:Play(15, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0019_fe04:Play(15, true)
        Message("f_d0202_0220_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        npc_0019_fe02:Play(15, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc_0031" then
      START_TALK_ACTION_AND_ZOOM("npc_0031", true, false)
      Field_Talk_Start("d02", 1)
      Talk.NextNoVoice()
      Message("f_d0202_0020_0010")
      Message("f_d0202_0020_0020")
      END_TALK_ACTION_AND_ZOOM("npc_0031", false, false)
      Field_Talk_End()
    end
    if talk_id == 320 then
      local npc_0020_fq01 = Motion.Object:new(NPC, "npc_0020", "fq01")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_0020_fq01:Play(15, true)
      Message("f_d0202_0230_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 321 then
      local mekanori01 = GetIndex(NPC, "npc_0021")
      local npc_0021 = Obj:new(NPC, "npc_0021")
      local player = Field.GetPlayerIndex()
      local npc0021_pos = Field.ObjectGetPosition(NPC, mekanori01)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(npc0021_pos.x, npc0021_pos.z, player_pos.x, player_pos.z)
      local npc_0021_bn01 = Motion.Object:new(NPC, "npc_0021", "bn01")
      local npc_0021_fq01 = Motion.Object:new(NPC, "npc_0021", "fq01")
      local npc_0021_br01 = Motion.Object:new(NPC, "npc_0021", "br01")
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0021:SetRotationYToPlayerAndAnimRun(15)
        npc_0021_bn01:Play(15, true)
        Message("f_d0202_0090_0060")
        npc_0021_fq01:Play(15, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0021:SetRotationYToPlayerAndAnimRun(15)
        npc_0021_bn01:Play(15, true)
        Message("f_d0202_0090_0030")
        Message("f_d0202_0090_0040")
        Message("f_d0202_0090_0050")
        npc_0021_fq01:Play(15, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_630") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        npc_0021_bn01:Play(15, true)
        Message("f_d0202_0090_0070")
        Message("f_d0202_0090_0080")
        Message("f_d0202_0090_0090")
        npc_0021_fq01:Play(15, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0202_0090_0010")
        npc_0021:SetRotationYToPlayerAndAnimRun(15)
        npc_0021_bn01:Play(15, true)
        WaitFrame(5)
        npc_0021_bn01:Play(15, true)
        Message("f_d0202_0090_0020")
        npc_0021_fq01:Play(15, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      end
    end
    if talk_id == 322 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0250_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 323 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0250_0020")
      Message("f_d0202_0250_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 400 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0230_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 324 then
      NPCtalk_npc_0024and0025()
    end
    if talk_id == 326 then
      NPCtalk_npc_0026and0027()
    end
    if talk_id == 328 then
      local npc_0028_bn01 = Motion.Object:new(NPC, "npc_0028", "bn01")
      local npc_0028_fe04 = Motion.Object:new(NPC, "npc_0028", "fe04")
      local npc_0028_fq01 = Motion.Object:new(NPC, "npc_0028", "fq01")
      local npc_0028_bn02 = Motion.Object:new(NPC, "npc_0028", "bn02")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      if Flg.Check("FLAG_MAIN_03_680") then
        npc_0028_fe04:Play(15, true)
        Message("f_d0202_0270_0050")
        Message("f_d0202_0270_0060")
        npc_0028_bn01:Play(15, true)
      elseif Flg.Check("FLAG_MAIN_03_630") then
        npc_0028_fe04:Play(15, true)
        Message("f_d0202_0270_0070")
        npc_0028_bn01:Play(15, true)
        Message("f_d0202_0270_0080")
        Message("f_d0202_0270_0090")
        npc_0028_fe04:Play(15, true)
        Message("f_d0202_0270_0100")
        npc_0028_bn01:Play(15, true)
      else
        Message("f_d0202_0270_0010")
        Message("f_d0202_0270_0020")
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 329 then
      local npc_0029_bn01 = Motion.Object:new(NPC, "npc_0029", "bn01")
      local npc_0029_fq02 = Motion.Object:new(NPC, "npc_0029", "fq02")
      local npc_0029_fe04 = Motion.Object:new(NPC, "npc_0029", "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      local fldtxt = "d02"
      Field_Talk_Start(fldtxt, 1)
      npc_0029_bn01:Play(15, true)
      Message("f_d0202_0010_0010")
      Field.EndPlayerAndNpcTalkAction("npc_0029")
      npc_0029_fq02:Play(15, true)
      Message("f_d0202_0010_0020")
      Field.StartPlayerAndNpcTalkAction("npc_0029")
      npc_0029_bn01:Play(15, true)
      Message("f_d0202_0010_0030")
      npc_0029_fe04:Play(15, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End()
    end
    if talk_id == 330 then
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0202_0030_0030")
        Message("f_d0202_0030_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0202_0030_0010")
        Message("f_d0202_0030_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 331 then
      M120:Event_063()
    end
    if talk_id == 332 then
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0202_0040_0030")
        Message("f_d0202_0040_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0202_0040_0020")
        Message("f_d0202_0040_0030")
        Message("f_d0202_0040_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0202_0040_0010")
        Message("f_d0202_0040_0020")
        Message("f_d0202_0040_0030")
        Message("f_d0202_0040_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 333 then
      local corona_e004 = Motion.Object:new(NPC, "npc_0033", "e004")
      local corona_e007 = Motion.Object:new(NPC, "npc_0033", "e007")
      local corona_e008 = Motion.Object:new(NPC, "npc_0033", "e008")
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0202_0050_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0202_0050_0010")
        corona_e008:Play(15, true)
        Message("f_d0202_0050_0020")
        corona_e007:Play(15, true)
        Message("f_d0202_0050_0030")
        corona_e004:Play(15, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0202_0050_0010")
        corona_e008:Play(15, true)
        Message("f_d0202_0050_0020")
        corona_e007:Play(15, true)
        Message("f_d0202_0050_0030")
        corona_e004:Play(15, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 337 then
      local fldtxt = "d02"
      local tyumon_bn01 = Motion.Object:new(NPC, "npc_0037", "bn01")
      local tyumon_fe02 = Motion.Object:new(NPC, "npc_0037", "fe02")
      local tyumon_fe04 = Motion.Object:new(NPC, "npc_0037", "fe04")
      local catch_bn01 = Motion.Object:new(MOB, "rumor_m140_01", "bn01")
      local catch_fq02 = Motion.Object:new(MOB, "rumor_m140_01", "fq02")
      local catch_fe04 = Motion.Object:new(MOB, "rumor_m140_01", "fe04")
      Cam.Inst:Set(20.213207, -0.446986, -11.998755, 29.698883, 2.381984, -10.577885, default, 45)
      WaitFrame(40)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      tyumon_fe04:Play(15, true)
      Message("f_d0202_0410_0010")
      tyumon_bn01:Play(15, true)
      catch_fe04:Play(15, true)
      Message("f_d0202_0410_0020")
      tyumon_fe04:Play(15, true)
      catch_bn01:Play(15, true)
      Message("f_d0202_0410_0030")
      catch_fe04:Play(15, true)
      Message("f_d0202_0410_0040")
      catch_fq02:Play(15, true)
      tyumon_fe02:Play(15, true)
      Cam.Inst:Clear(45)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 338 then
      local fldtxt = "d02"
      local ginryu_fq02 = Motion.Object:new(NPC, "npc_0038", "fq02")
      local ginryu_bn01 = Motion.Object:new(NPC, "npc_0038", "bn01")
      if Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        ginryu_fq02:Play(15, true)
        Message("f_d0202_0430_0010")
        ginryu_bn01:Play(15, true)
        Message("f_d0202_0430_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0202_0430_0010")
        Message("f_d0202_0430_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 339 then
      local fldtxt = "d02"
      local ryuda_fe02 = Motion.Object:new(NPC, "npc_0039", "fe02")
      local ryuda_fe04 = Motion.Object:new(NPC, "npc_0039", "fe04")
      local kote_bn02 = Motion.Object:new(MOB, "mob_001", "bn02")
      local kote_fq02 = Motion.Object:new(MOB, "mob_001", "fq02")
      local dorako_fe02 = Motion.Object:new(MOB, "mob_002", "fe02")
      local dorako_fe04 = Motion.Object:new(MOB, "mob_002", "fe04")
      Cam.Inst:Set(-50.009689, 1.369, -14.535481, -43.636921, 4.154455, -7.350142, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0420_0010")
      dorako_fe04:Play(15, true)
      Message("f_d0202_0420_0020")
      kote_bn02:Play(15, true)
      Message("f_d0202_0420_0030")
      Message("f_d0202_0420_0040")
      kote_fq02:Play(15, true)
      dorako_fe02:Play(15, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_001" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0202_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1202, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0202_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0202_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0202_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0202_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1203, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0202_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0202_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0202_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 600 then
      local fldtxt = "d02"
      local fq02 = Motion.Object:new(NPC, "npc_0600", "fq02")
      local bn01 = Motion.Object:new(NPC, "npc_0600", "bn01")
      local fe04 = Motion.Object:new(NPC, "npc_0600", "fe04")
      Cam.Inst:Set(25.337849, 1.599169, 12.049787, 34.307152, 1.095348, 16.442711, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq02:Play(20, true)
      Message("f_d0202_0280_0010")
      bn01:Play(20, true)
      Message("f_d0202_0280_0020")
      fe04:Play(20, true)
      Message("f_d0202_0280_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0600"), 30)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 601 then
      local fldtxt = "d02"
      local fe04 = Motion.Object:new(NPC, "npc_0601", "fe04")
      local ba02 = Motion.Object:new(NPC, "npc_0601", "ba02")
      Cam.Inst:Set(12.011372, 0.233944, -2.030405, 19.620911, 2.675184, -8.04167, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe04:Play(20, true)
      Message("f_d0202_0290_0010")
      ba02:Play(20, true)
      Message("f_d0202_0290_0020")
      Message("f_d0202_0290_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0601"), 30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 602 then
      local fldtxt = "d02"
      Cam.Inst:Set(-97.004896, 1.851061, -10.651143, -87.882507, -1.343582, -8.086716, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0300_0010")
      Message("f_d0202_0300_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 603 then
      local fldtxt = "d02"
      local fe04 = Motion.Object:new(NPC, "npc_0603", "fe04")
      Cam.Inst:Set(-45.487133, 6.002314, -4.647729, -44.137993, 3.053686, 4.811945, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe04:Play(20, true)
      Message("f_d0202_0310_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0603"), 30)
      Message("f_d0202_0310_0020")
      fe04:Play(20, true)
      Message("f_d0202_0310_0030")
      Message("f_d0202_0310_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0603"), 30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 605 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0330_0010")
      Message("f_d0202_0330_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 606 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0340_0010")
      Message("f_d0202_0340_0020")
      Message("f_d0202_0340_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 607 then
      local fldtxt = "d02"
      local fq02 = Motion.Object:new(NPC, "npc_0607", "fq02")
      local fe02 = Motion.Object:new(NPC, "npc_0607", "fe02")
      Cam.Inst:Set(-1.804254, 3.733277, -5.095055, 7.045223, 3.977485, -9.745548, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0350_0010")
      Message("f_d0202_0350_0020")
      Message("f_d0202_0350_0030")
      fq02:Play(20, true)
      Message("f_d0202_0350_0040")
      fe02:Play(20, true)
      Message("f_d0202_0350_0050")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0607"), 30)
      Message("f_d0202_0350_0060")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 608 then
      local fldtxt = "d02"
      local ba02 = Motion.Object:new(NPC, "npc_0608", "ba02")
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Cam.Inst:Set(-21.678537, 3.57371, -13.853106, -12.993326, 7.185707, -10.458908, default, 30)
      Message("f_d0202_0320_0010")
      Message("f_d0202_0320_0020")
      ba02:Play(20, true)
      Message("f_d0202_0360_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0608"), 30)
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 609 then
      local fldtxt = "d02"
      local bn02 = Motion.Object:new(NPC, "npc_0609", "bn02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0370_0010")
      bn02:Play(20, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0609"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      Message("f_d0202_0370_0020")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0609"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 610 then
      local fldtxt = "d02"
      local fq01 = Motion.Object:new(NPC, "npc_0610", "fq01")
      local ba02 = Motion.Object:new(NPC, "npc_0610", "ba02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq01:Play(20, true)
      Message("f_d0202_0380_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0610"), 30)
      Message("f_d0202_0380_0020")
      ba02:Play(20, true)
      Message("f_d0202_0380_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0610"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0611" then
      local cam_npc = {
        -7.39,
        10.12,
        -3.642,
        -7.915,
        8.62,
        6.23
      }
      local cam_shop = {
        -9.75,
        9.47,
        -3.81,
        -8.04,
        8.77,
        6.01
      }
      CommonShopStart(npc_name, 164, "fe01", "fq01", "fq01", cam_npc, cam_shop)
    end
    if talk_id == 612 then
      local fldtxt = "d02"
      Cam.Inst:Set(-45.878399, 5.045682, 7.35412, -48.913582, 2.916544, -1.93362, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0440_0010")
      Message("f_d0202_0440_0020")
      Message("f_d0202_0440_0030")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 613 then
      local fldtxt = "d02"
      local fq01 = Motion.Object:new(NPC, "npc_0613", "fq01")
      local fe02 = Motion.Object:new(NPC, "npc_0613", "fe02")
      Cam.Inst:Set(-30.34, 9.029, -37.47, -27.41, 10.19, -27.98, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0450_0010")
      fq01:Play(20, true)
      Message("f_d0202_0450_0020")
      Message("f_d0202_0450_0030")
      fe02:Play(20, true)
      Message("f_d0202_0450_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0613"), 30)
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 614 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0460_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 615 then
      local fldtxt = "d02"
      Cam.Inst:Set(27.54364, -0.576965, -6.560545, 29.529, 1.748464, 2.961169, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0470_0010")
      Message("f_d0202_0470_0020")
      Message("f_d0202_0470_0030")
      Message("f_d0202_0470_0040")
      Message("f_d0202_0470_0050")
      Message("f_d0202_0470_0060")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 659 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0660_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 671 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0720_0030")
      Message("f_d0202_0720_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 672 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0720_0050")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 674 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0720_0060")
      Message("f_d0202_0720_0070")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 675 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0720_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0677" then
      local cam_npc = {
        -7.39,
        10.12,
        -3.642,
        -7.915,
        8.62,
        6.23
      }
      local cam_shop = {
        -9.75,
        9.47,
        -3.81,
        -8.04,
        8.77,
        6.01
      }
      CommonShopStart(npc_name, 165, "fe01", "fq01", "fq01", cam_npc, cam_shop)
    end
    if talk_id == 700 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0480_0010")
      Message("f_d0202_0480_0020")
      Message("f_d0202_0480_0030")
      Message("f_d0202_0480_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 701 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0490_0010")
      Message("f_d0202_0490_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 703 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0500_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 704 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0510_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 705 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0520_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 706 then
      local fldtxt = "d02"
      Cam.Inst:Set(-49.83, 4.33, -10.13, -45.83, 7.76, -1.64, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0530_0010")
      Message("f_d0202_0530_0020")
      Message("f_d0202_0530_0030")
      Message("f_d0202_0530_0040")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 707 then
      local fldtxt = "d02"
      Cam.Inst:Set(-46.3, 6.91, 4.3, -45.88, 3.42, -5.05, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0540_0010")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Message("f_d0202_0540_0020")
      Message("f_d0202_0540_0030")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 708 then
      local fldtxt = "d02"
      Cam.Inst:Set(22.04, -0.2, 2.55, 20.47, 2.09, -7.05, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0550_0010")
      Message("f_d0202_0550_0020")
      Message("f_d0202_0550_0030")
      Message("f_d0202_0550_0040")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 711 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      SetNpcTalkZoomCamera(npc_name, 0.8, 2, 45, 1)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0560_0010")
      Message("f_d0202_0560_0020")
      Message("f_d0202_0560_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      ClearNpcTalkZoomCamera(22, 1)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 712 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0570_0010")
      Message("f_d0202_0570_0020")
      Message("f_d0202_0570_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 713 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0580_0010")
      Message("f_d0202_0580_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 714 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0590_0010")
      Message("f_d0202_0590_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 715 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0600_0010")
      Message("f_d0202_0600_0020")
      Message("f_d0202_0600_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 716 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0610_0010")
      Message("f_d0202_0610_0020")
      Message("f_d0202_0610_0030")
      Message("f_d0202_0610_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 717 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0620_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 718 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0630_0010")
      Message("f_d0202_0630_0020")
      Message("f_d0202_0630_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 719 then
      local cam_npc = {
        -7.39,
        10.12,
        -3.642,
        -7.915,
        8.62,
        6.23
      }
      local cam_shop = {
        -9.75,
        9.47,
        -3.81,
        -8.04,
        8.77,
        6.01
      }
      CommonShopStart(npc_name, 164, "fe01", "fq01", "fq01", cam_npc, cam_shop)
    end
    if talk_id == 720 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0650_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 750 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0670_0010")
      Message("f_d0202_0670_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 751 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0680_0010")
      Message("f_d0202_0680_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 752 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0690_0010")
      Message("f_d0202_0690_0020")
      Message("f_d0202_0690_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 753 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0202_0700_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0034" then
      local bea01_bn01 = Motion.Object:new(NPC, "npc_0034", "bn01")
      local bea01_fe04 = Motion.Object:new(NPC, "npc_0034", "fe04")
      local bea01_fq02 = Motion.Object:new(NPC, "npc_0034", "fq02")
      local bea01_e007 = Motion.Object:new(NPC, "npc_0034", "e007")
      require("S050_042")
      require("S050_043")
      if Qst.Sub:IsCompleted(S050_042.ID) and Flg.Check("FLAG_MAIN_05_030") then
        if not Qst.Sub:IsCompleted(S050_043.ID) then
          require("s050_043")
          S050_043:Event_059()
          S050_043:Event_010()
        end
      elseif Qst.Sub:IsCompleted(S050_042.ID) and Qst.Main:IsCompleted(M150.ID) then
        require("S050_042")
        S050_042:Event_060()
      elseif Flg.Check("FLAG_SUB_S050_041_001", "FLAG_IS_CLEAR_S050_042") then
        local tlk = Tlk:new(npc_text, 1, true)
        require("S050_041")
        S050_041:Event_035()
      elseif Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        bea01_bn01:Play(15, false)
        WaitFrame(15)
        bea01_e007:Play(15, true)
        Message("f_d0202_0060_0030")
        Message("f_d0202_0060_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        bea01_bn01:Play(15, false)
        WaitFrame(15)
        bea01_e007:Play(15, true)
        Message("f_d0202_0060_0030")
        Message("f_d0202_0060_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        bea01_bn01:Play(15, false)
        WaitFrame(15)
        bea01_e007:Play(15, true)
        Message("f_d0202_0060_0010")
        Message("f_d0202_0060_0020")
        Message("f_d0202_0060_0030")
        Message("f_d0202_0060_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc_0035" then
      if Flg.Check("FLAG_IS_CLEAR_S050_042") and Flg.Check("FLAG_MAIN_05_030") then
        require("s050_043")
        S050_043:Event_055()
      elseif Flg.Check("FLAG_MAIN_04_140") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0202_0070_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_680") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0202_0070_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0202_0070_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc_0036" then
      require("S050_042")
      require("S050_043")
      if Qst.Sub:Check(43, 15, 255) then
        S050_043:Event_056()
      elseif Flg.Check("FLAG_IS_CLEAR_S050_042") then
        S050_042:Event_070()
      end
    end
    if npc_name == "s050_041_haguru" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("s050_041")
      if Qst.Sub:Check(41, 10, 255) then
        S050_041:Event_030()
      else
        S050_041:Event_010()
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "s080_059_001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S080_059")
      S080_059:Event_020()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    elseif npc_name == "s080_059_002" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S080_059")
      S080_059:Event_030()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 800 then
      if Flg.Check("FLAG_GIMMICK_D02_190") or Flg.Check("FLAG_MAIN_03_680") then
        Prcs_d0202_patamonride_id800_2()
      else
        Prcs_d0202_patamonride_id800()
      end
    elseif talk_id == 801 then
      if Flg.Check("FLAG_GIMMICK_D02_190") or Flg.Check("FLAG_MAIN_03_680") then
        Prcs_d0202_patamonride_id801_2()
      else
        Prcs_d0202_patamonride_id801()
      end
    elseif talk_id == 802 then
      if Flg.Check("FLAG_GIMMICK_D02_190") or Flg.Check("FLAG_MAIN_03_680") then
        Prcs_d0202_patamonride_id802_2()
      else
        Prcs_d0202_patamonride_id802()
      end
    end
    if npc_name == "s080_060_001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S080_060")
      S080_060:Event_110()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "s080_060_002" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S080_060")
      S080_060:Event_070()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "s080_060_003" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S080_060")
      S080_060:Event_080()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 303 then
      require("S050_152")
      if Qst.Sub:Check(S050_152.ID, S050_152.STEP_001, S050_152.STEP_005) then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        WaitFrame(30)
        S050_152:Event_010()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        Prcs_d0202_ride_pegasmon()
      end
    end
    if talk_id == 311 then
      M130:Event_020()
    end
    if talk_id == 313 then
      M120:Event_090()
    end
    if talk_id == 314 then
      M120:Event_090()
    end
    if talk_id == 315 then
      M130:Event_020()
    end
    if npc_name == "s050_050_002" then
    end
    if npc_name == "s050_050_005" then
      require("S050_050")
    end
    if npc_name == "s050_152_002" then
      require("S050_152")
      S050_152:Event_020()
    end
    if npc_name == "s050_152_003" then
      require("S050_152")
      S050_152:Event_030()
    end
    if npc_name == "s050_152_004" then
      require("S050_152")
      S050_152:Event_040()
    end
    if npc_name == "s050_152_005" then
      require("S050_152")
      S050_152:Event_050()
    end
    if npc_name == "s050_152_006" then
      require("S050_152")
      S050_152:Event_060()
    end
    if npc_name == "sub_050_042_solar" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("s050_042")
      S050_042:Event_010()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "s050_043_clock" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("s050_043")
      S050_043:Event_075()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "npc_warp01" then
      D02_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      if not Flg.Check("FLAG_MAIN_13_180") then
        D02_WarpNPC_After(npc_name)
      else
        D02_WarpNPC_After2(npc_name)
      end
    end
    if npc_name == "card_shop_0001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      CommonShopStart_NoZoomCam(npc_name, 166, "fe02", "fe04", "fe04", "bn01")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
  elseif gMapNum == 203 then
    if talk_id == 400 then
      StartShop(npc_name, 110, -1, 0, 5)
      WaitCloseShopWindow()
      EndShop()
    end
    if npc_name == "s200_148_001" or npc_name == "s200_148_002" then
      require("S200_148")
      S200_148:Event_040()
      S200_148:Event_015()
      S200_148:Event_013()
      S200_148:Event_010()
    end
    if npc_name == "s200_148_003" then
      require("S200_148")
      S200_148:Event_025()
      S200_148:Event_020()
    end
    if npc_name == "s200_148_004" then
      require("S200_148")
      S200_148:Event_035()
      S200_148:Event_030()
    end
    if talk_id == 500 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      local fldtxt = "d02"
      local npc_index = GetIndex(NPC, "terriermon_assistant")
      local bn01 = Motion.Object:new(NPC, "terriermon_assistant", "bn01")
      local e613 = Motion.Object:new(NPC, "terriermon_assistant", "e613")
      local e613_in = Motion.Object:new(NPC, "terriermon_assistant", "e613_in")
      local e613_out = Motion.Object:new(NPC, "terriermon_assistant", "e613_out")
      local e614 = Motion.Object:new(NPC, "terriermon_assistant", "e614")
      local e615 = Motion.Object:new(NPC, "terriermon_assistant", "e615")
      local e616_in = Motion.Object:new(NPC, "terriermon_assistant", "e616_in")
      local e616 = Motion.Object:new(NPC, "terriermon_assistant", "e616")
      local e616_out = Motion.Object:new(NPC, "terriermon_assistant", "e616_out")
      local e617 = Motion.Object:new(NPC, "terriermon_assistant", "e617")
      local e618 = Motion.Object:new(NPC, "terriermon_assistant", "e618")
      local e619 = Motion.Object:new(NPC, "terriermon_assistant", "e619")
      Field.ObjectLoadExpression(NPC, npc_index, "F01")
      Field.ObjectLoadExpression(NPC, npc_index, "F02")
      Field.ObjectLoadExpression(NPC, npc_index, "F03")
      Field.ObjectLoadExpression(NPC, npc_index, "F01_T01")
      Field.ObjectLoadExpression(NPC, npc_index, "F02_T01")
      Field.ObjectLoadExpression(NPC, npc_index, "F03_T01")
      Cam.Inst:Set(6.43, -1.384, -4.19, 1.76, 1.68, 4.1, default, 30)
      if not Flg.Check("FLAG_MAIN_ASSISTANT_3") then
        Flg.Set("FLAG_MAIN_ASSISTANT_3")
        e613_out:PlayWithStartMoveMotion(10, 10)
      end
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      if not Flg.Check("FLAG_MAIN_ASSISTANT_1") then
        Sound.PlayVoice("vo_mpc999_Greeting_001")
        Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        e615:PlayWithStartMoveMotion(10, 10)
        Message("f_d0203_0010_0090")
        e617:PlayWithStartMoveMotion(10, 10)
        Message("f_d0203_0010_0100")
        Sound.PlayVoice("vo_mpc999_Doubt_001")
        Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d0203_0010_0110")
        e614:Play(10, true)
        Message("f_d0203_0010_0120")
        Sound.PlayVoice("vo_mpc999_Joy_001")
        Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d0203_0010_0130")
        Field.ObjectChangeExpression(NPC, npc_index, "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        MessageClose()
        e616_in:Play(10, false)
        WaitFrame(60)
        e616:Play(10, true)
        OpenInfoWindow(10100)
        Field.ShowGetItemLog(61, 1)
        Field.ShowGetItemLog(64, 1)
        Field.ShowGetItemLog(67, 1)
        Field.ShowGetItemLog(70, 1)
        Field.ShowGetItemLog(73, 1)
        Field.ShowGetItemLog(76, 1)
        Field.ShowGetItemLog(79, 1)
        e616_out:PlayWithStartMoveMotion(10, 10)
        WaitFrame(120)
        Sound.PlayVoice("vo_mpc999_Doubt_001")
        Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        e614:Play(10, true)
        Message("f_d0203_0010_0140")
        Sound.PlayVoice("vo_mpc999_Anger_001")
        Field.ObjectChangeExpression(NPC, npc_index, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        e617:PlayWithStartMoveMotion(10, 10)
        Message("f_d0203_0010_0150")
        Sound.PlayVoice("vo_mpc999_Joy_001_b")
        Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        e618:PlayWithStartMoveMotion(10, 10)
        Message("f_d0203_0010_0160")
        Field.ObjectChangeExpression(NPC, npc_index, "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
        Flg.Set("FLAG_MAIN_ASSISTANT_1")
        goto lbl_10128
      elseif Flg.Check("FLAG_MAIN_13_180") then
        if not Flg.Check("FLAG_MAIN_ASSISTANT_2") then
          Sound.PlayVoice("vo_mpc999_Embarrassed_001")
          Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          e617:PlayWithStartMoveMotion(10, 10)
          Message("f_d0203_0010_0300")
          Sound.PlayVoice("vo_mpc999_Joy_001")
          Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          e614:Play(10, true)
          Message("f_d0203_0010_0310")
          Message("f_d0203_0010_0320")
          Sound.PlayVoice("vo_mpc999_Joy_001_b")
          Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_d0203_0010_0330")
          Field.ObjectChangeExpression(NPC, npc_index, "F02", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          MessageClose()
          e616_in:Play(10, false)
          WaitFrame(60)
          e616:Play(10, true)
          INFO_GET_ITEM(1175, 1)
          e616_out:PlayWithStartMoveMotion(10, 10)
          Flg.Set("FLAG_MAIN_ASSISTANT_2")
          goto lbl_10128
        else
          MessageTalkSel(5, "f_d0203_0010_0170")
          local result = Talk.GetResultSelectedNum()
          if result == RESULT_TALK00 then
            Sound.PlayVoice("vo_mpc999_Delusion_001_b")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
            e617:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0180")
            Sound.PlayVoice("vo_mpc999_Embarrassed_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            e615:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0190")
            Sound.PlayVoice("vo_mpc999_Sigh_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            Message("f_d0203_0010_0200")
            Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
            goto lbl_10128
          elseif result == RESULT_TALK01 then
            Sound.PlayVoice("vo_mpc999_Sigh_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 15, AUTO_CANCEL_NONE, 15)
            Message("f_d0203_0010_0210")
            e619:Play(15, true)
            Message("f_d0203_0010_0220")
            Sound.PlayVoice("vo_mpc999_Embarrassed_001")
            e618:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0223")
            e614:Play(10, true)
            Message("f_d0203_0010_0225")
            e619:PlayWithStartMoveMotion(15, 15)
            Message("f_d0203_0010_0227")
            Field.ObjectChangeExpression(NPC, npc_index, "F03", EYES_BLINK_TYPE_BLINK, false, 15, AUTO_CANCEL_NONE, 15)
            WaitFrame(45)
            goto lbl_10128
          elseif result == RESULT_TALK02 then
            Sound.PlayVoice("vo_mpc999_Doubt_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
            Message("f_d0203_0010_0229")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            e617:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0230")
            Sound.PlayVoice("vo_mpc999_Embarrassed_001")
            e614:Play(10, true)
            Message("f_d0203_0010_0235")
            Message("f_d0203_0010_0240")
            Sound.PlayVoice("vo_mpc999_Delusion_001")
            bn01:Play(10, true)
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
            Message("f_d0203_0010_0250")
            Sound.PlayVoice("vo_mpc999_Delusion_001_b")
            Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            e617:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0260")
            Field.ObjectChangeExpression(NPC, npc_index, "F02", EYES_BLINK_TYPE_BLINK, false, 15, AUTO_CANCEL_NONE, 15)
            goto lbl_10128
          elseif result == RESULT_TALK03 then
            Sound.PlayVoice("vo_mpc999_Embarrassed_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            e618:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0270")
            e614:Play(10, true)
            Message("f_d0203_0010_0280")
            Sound.PlayVoice("vo_mpc999_Doubt_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
            bn01:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0290")
            Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_CLOSE, false, 15, AUTO_CANCEL_NONE, 15)
            goto lbl_10128
          else
            if result == RESULT_TALK04 then
              Sound.PlayVoice("vo_mpc999_Anger_001")
              Field.ObjectChangeExpression(NPC, npc_index, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
              Message("f_d0203_0010_0340")
              e614:Play(10, true)
              Message("f_d0203_0010_0350")
              Message("f_d0203_0010_0360")
              Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 15, AUTO_CANCEL_NONE, 15)
              bn01:Play(15, true)
              Message("f_d0203_0010_0370")
              Sound.PlayVoice("vo_mpc999_Embarrassed_001")
              Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
              e618:PlayWithStartMoveMotion(10, 10)
              Message("f_d0203_0010_0380")
              Field.ObjectChangeExpression(NPC, npc_index, "F02", EYES_BLINK_TYPE_BLINK, false, 15, AUTO_CANCEL_NONE, 15)
            else
            end
          end
        end
      else
        MessageTalkSel(4, "f_d0203_0010_0170")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Sound.PlayVoice("vo_mpc999_Delusion_001_b")
          Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
          e617:PlayWithStartMoveMotion(10, 10)
          Message("f_d0203_0010_0180")
          Sound.PlayVoice("vo_mpc999_Embarrassed_001")
          Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          e615:PlayWithStartMoveMotion(10, 10)
          Message("f_d0203_0010_0190")
          Sound.PlayVoice("vo_mpc999_Sigh_001")
          Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_d0203_0010_0200")
          Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
          goto lbl_10128
        elseif result == RESULT_TALK01 then
          Sound.PlayVoice("vo_mpc999_Sigh_001")
          Field.ObjectChangeExpression(NPC, npc_index, "F03_T01", EYES_BLINK_TYPE_BLINK, true, 15, AUTO_CANCEL_NONE, 15)
          Message("f_d0203_0010_0210")
          e619:Play(15, true)
          Message("f_d0203_0010_0220")
          Sound.PlayVoice("vo_mpc999_Embarrassed_001")
          e618:PlayWithStartMoveMotion(10, 10)
          Message("f_d0203_0010_0223")
          e614:Play(10, true)
          Message("f_d0203_0010_0225")
          e619:PlayWithStartMoveMotion(15, 15)
          Message("f_d0203_0010_0227")
          Field.ObjectChangeExpression(NPC, npc_index, "F03", EYES_BLINK_TYPE_BLINK, false, 15, AUTO_CANCEL_NONE, 15)
          WaitFrame(45)
          goto lbl_10128
        elseif result == RESULT_TALK02 then
          Sound.PlayVoice("vo_mpc999_Doubt_001")
          Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_d0203_0010_0229")
          Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          e617:PlayWithStartMoveMotion(10, 10)
          Message("f_d0203_0010_0230")
          Sound.PlayVoice("vo_mpc999_Embarrassed_001")
          e614:Play(10, true)
          Message("f_d0203_0010_0235")
          Message("f_d0203_0010_0240")
          Sound.PlayVoice("vo_mpc999_Delusion_001")
          bn01:Play(10, true)
          Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
          Message("f_d0203_0010_0250")
          Sound.PlayVoice("vo_mpc999_Delusion_001_b")
          Field.ObjectChangeExpression(NPC, npc_index, "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
          e617:PlayWithStartMoveMotion(10, 10)
          Message("f_d0203_0010_0260")
          Field.ObjectChangeExpression(NPC, npc_index, "F02", EYES_BLINK_TYPE_BLINK, false, 15, AUTO_CANCEL_NONE, 15)
          goto lbl_10128
        else
          if result == RESULT_TALK03 then
            Sound.PlayVoice("vo_mpc999_Embarrassed_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
            e618:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0270")
            e614:Play(10, true)
            Message("f_d0203_0010_0280")
            Sound.PlayVoice("vo_mpc999_Doubt_001")
            Field.ObjectChangeExpression(NPC, npc_index, "F01_T01", EYES_BLINK_TYPE_CLOSE, true, 30, AUTO_CANCEL_NONE, 15)
            bn01:PlayWithStartMoveMotion(10, 10)
            Message("f_d0203_0010_0290")
            Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_CLOSE, false, 15, AUTO_CANCEL_NONE, 15)
          else
          end
        end
      end
      ::lbl_10128::
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
      WaitFrame(30)
      Field.ObjectChangeExpression(NPC, npc_index, "F01", EYES_BLINK_TYPE_BLINK, false, 30, AUTO_CANCEL_NONE, 15)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  elseif gMapNum == 204 then
    if talk_id == 1 then
      require("S050_176")
      local fldtxt = "d02"
      if Flg.Check("FLAG_MAIN_04_150") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0280_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_04_000") and not Flg.Check("FLAG_MAIN_04_150") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0080_0010")
        Message("f_d0204_0080_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_03_510") and not Flg.Check("FLAG_MAIN_04_000") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0280_0040")
        Message("f_d0204_0280_0050")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 302 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0270_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 303 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0230_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 304 then
      local andoro = GetIndex(NPC, "npc_2003")
      local npc_2003 = Obj:new(NPC, "npc_2003")
      local player = Field.GetPlayerIndex()
      local npc_2003_pos = Field.ObjectGetPosition(NPC, andoro)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(npc_2003_pos.x, npc_2003_pos.z, player_pos.x, player_pos.z)
      local npc_2003_bn01 = Motion.Object:new(NPC, "npc_2003", "bn01")
      local npc_2003_fq02 = Motion.Object:new(NPC, "npc_2003", "fq02")
      START_TALK_ACTION_AND_ZOOM("npc_2003", false, true)
      Field_Talk_Start_Not_LetterBox("d02", 1)
      npc_2003_bn01:Play(10, true)
      Message("f_d0204_0300_0010")
      npc_2003_fq02:Play(15, true)
      Message("f_d0204_0300_0020")
      END_TALK_ACTION_AND_ZOOM("npc_2003", true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 305 then
      local rena = GetIndex(NPC, "npc_2004")
      local npc_2004 = Obj:new(NPC, "npc_2004")
      local player = Field.GetPlayerIndex()
      local npc_2004_pos = Field.ObjectGetPosition(NPC, rena)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(npc_2004_pos.x, npc_2004_pos.z, player_pos.x, player_pos.z)
      local npc_2004_bn01 = Motion.Object:new(NPC, "npc_2004", "bn01")
      local npc_2004_fq02 = Motion.Object:new(NPC, "npc_2004", "fq02")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM("npc_2004", false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_2004_bn01:Play(10, true)
      Message("f_d0204_0320_0010")
      Message("f_d0204_0320_0020")
      END_TALK_ACTION_AND_ZOOM("npc_2004", true, true)
      npc_2004_fq02:Play(15, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 306 then
      local rena01 = GetIndex(NPC, "npc_2005")
      local npc_2005 = Obj:new(NPC, "npc_2005")
      local player = Field.GetPlayerIndex()
      local npc_2005_pos = Field.ObjectGetPosition(NPC, rena01)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(npc_2005_pos.x, npc_2005_pos.z, player_pos.x, player_pos.z)
      local npc_2005_bn01 = Motion.Object:new(NPC, "npc_2005", "bn01")
      local npc_2005_fq01 = Motion.Object:new(NPC, "npc_2005", "fq01")
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM("npc_2005", false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_2005_bn01:Play(10, true)
      Message("f_d0204_0320_0010")
      Message("f_d0204_0320_0020")
      npc_2005_fq01:Play(15, true)
      END_TALK_ACTION_AND_ZOOM("npc_2005", true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 310 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      if CheckTimeAxis("A2020_dbef_110", "A2020_dbef_200") or Flg.Check("FLAG_IS_SET_NPC_CAM") then
        Message("f_d0204_0310_0010")
        Message("f_d0204_0310_0020")
      else
        Message("f_d0204_0480_0010")
        Message("f_d0204_0480_0020")
        Message("f_d0204_0480_0030")
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 401 then
      local knight_index = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, knight_index, "f000")
      Field.ObjectLoadMotion(NPC, knight_index, "e021")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field.ObjectPlayMotion(NPC, knight_index, "e021", 15, true)
      if Flg.Check("FLAG_MAIN_03_640") then
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0204_0020_0010")
        Field_Talk_End_Not_LetterBox()
        Field.ObjectPlayMotion(NPC, knight_index, "f000", 15, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_630") then
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0204_0060_0010")
        Field_Talk_End_Not_LetterBox()
        Field.ObjectPlayMotion(NPC, knight_index, "f000", 15, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_03_610") then
        Field_Talk_Start(npc_text, 1)
        Message("f_d0204_0050_0010")
        Field_Talk_End()
        Field.ObjectPlayMotion(NPC, knight_index, "f000", 15, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field.ObjectLookAt(NPC, GetIndex(NPC, "npc_1001"), 0.62, 0, -2.6, 0)
        M140:Event_020()
      elseif Flg.Check("FLAG_MAIN_03_495") then
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0204_0040_0010")
        Message("f_d0204_0040_0020")
        Field_Talk_End_Not_LetterBox()
        Field.ObjectPlayMotion(NPC, knight_index, "f000", 15, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0204_0020_0010")
        Field_Talk_End_Not_LetterBox()
        Field.ObjectPlayMotion(NPC, knight_index, "f000", 15, true)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      end
    end
    if talk_id == 320 then
      if Flg.Check("FLAG_MAIN_04_990", "FLAG_MAIN_05_000") then
        M150:Event_270()
      elseif Flg.Check("FLAG_MAIN_03_700") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0204_0070_0010")
        Message("f_d0204_0070_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 402 then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0204_0010_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 321 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0110_0010")
      Message("f_d0204_0110_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 323 then
      local fldtxt = "d02"
      Cam.Inst:Set(-6.763543, -0.551761, -1.52114, -0.544084, 2.762129, 3.57368, default, 45)
      WaitFrame(40)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0120_0010")
      Message("f_d0204_0120_0020")
      Message("f_d0204_0120_0030")
      Message("f_d0204_0120_0040")
      Message("f_d0204_0120_0050")
      Cam.Inst:Clear(45)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_001" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0130_0010")
      Message("f_d0204_0130_0020")
      Message("f_d0204_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0204_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1204, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0204_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0204_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0204_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0140_0010")
      Message("f_d0204_0140_0020")
      Message("f_d0204_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0204_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1205, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0204_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0204_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0204_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 326 then
      local fldtxt = "d02"
      local npc_2022_fq01 = Motion.Object:new(NPC, "npc_2022", "fq01")
      local npc_2022_fe02 = Motion.Object:new(NPC, "npc_2022", "fe02")
      Cam.Inst:Set(11.415035, 1.14283, 1.888805, 1.696389, 1.656996, 4.14458, default, 45)
      WaitFrame(45)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0150_0010")
      Message("f_d0204_0150_0020")
      npc_2022_fq01:Play(10, true)
      Message("f_d0204_0150_0030")
      Message("f_d0204_0150_0040")
      npc_2022_fe02:Play(10, true)
      Cam.Inst:Clear(45)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 328 then
      local fldtxt = "d02"
      Cam.Inst:Set(13.165389, 1.592291, -2.554467, 3.697503, 2.107004, 0.622672, default, 45)
      WaitFrame(45)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0160_0010")
      Message("f_d0204_0160_0020")
      Message("f_d0204_0160_0030")
      Message("f_d0204_0160_0040")
      Message("f_d0204_0160_0050")
      Cam.Inst:Clear(45)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 329 then
      local fldtxt = "d02"
      local npc_2014_fe02 = Motion.Object:new(NPC, "npc_2014", "fe02")
      local npc_2014_fe03 = Motion.Object:new(NPC, "npc_2014", "fe03")
      local npc_2014_fe04 = Motion.Object:new(NPC, "npc_2014", "fe04")
      local npc_2016_fe02 = Motion.Object:new(NPC, "npc_2016", "fq02")
      local npc_2016_fe04 = Motion.Object:new(NPC, "npc_2016", "fe04")
      local npc_2015_fq02 = Motion.Object:new(NPC, "npc_2015", "fq02")
      local npc_2015_fe03 = Motion.Object:new(NPC, "npc_2015", "fe03")
      local npc_2015_fe02 = Motion.Object:new(NPC, "npc_2015", "fe02")
      Cam.Inst:Set(-5.803487, -0.486595, 2.092898, 1.195136, 2.877234, 8.394003, default, 45)
      WaitFrame(45)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_2014_fe03:Play(10, true)
      Message("f_d0204_0170_0010")
      npc_2014_fe04:Play(10, true)
      Message("f_d0204_0170_0020")
      npc_2016_fe02:Play(10, true)
      Message("f_d0204_0170_0030")
      npc_2016_fe04:Play(10, true)
      Message("f_d0204_0170_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_2016"), 30)
      npc_2015_fq02:Play(10, true)
      Message("f_d0204_0170_0050")
      npc_2015_fe02:Play(10, true)
      Message("f_d0204_0170_0060")
      npc_2014_fe02:Play(10, true)
      Message("f_d0204_0170_0070")
      npc_2015_fe03:Play(10, true)
      Cam.Inst:Clear(45)
      npc_2014_fe04:Play(10, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 332 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0180_0010")
      Message("f_d0204_0180_0020")
      Message("f_d0204_0180_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 333 then
      local fldtxt = "d02"
      if Flg.Check("FLAG_FIELD_D0204_010") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0190_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Flg.Set("FLAG_FIELD_D0204_010")
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0190_0010")
        Message("f_d0204_0190_0020")
        MessageClose()
        INFO_GET_ITEM(1, 1)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 334 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0200_0010")
      Message("f_d0204_0200_0020")
      Message("f_d0204_0200_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 338 then
      local fldtxt = "d02"
      local npc_2021_bn01 = Motion.Object:new(NPC, "npc_2021", "bn01")
      local npc_2021_fe02 = Motion.Object:new(NPC, "npc_2021", "fe02")
      local npc_2021_fq02 = Motion.Object:new(NPC, "npc_2021", "fq02")
      local npc_2023_fq01 = Motion.Object:new(NPC, "npc_2023", "fq01")
      local npc_2023_bn01 = Motion.Object:new(NPC, "npc_2023", "bn01")
      local npc_2020 = GetIndex(NPC, "npc_2020")
      local npc_2023 = GetIndex(NPC, "npc_2023")
      local npc_2021 = GetIndex(NPC, "npc_2021")
      Field.ObjectLoadExpression(NPC, npc_2021, "F02")
      Cam.Inst:Set(-6.049772, 0.562175, -9.37996, -1.778313, 2.215178, -0.490516, default, 45)
      WaitFrame(45)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectLookAtTheObject(NPC, npc_2020, NPC, npc_2023, 30)
      Message("f_d0204_0210_0010")
      Message("f_d0204_0210_0020")
      Field.ObjectLookAtTheObject(NPC, npc_2023, NPC, npc_2021, 30)
      WaitFrame(30)
      npc_2023_fq01:Play(10, false)
      Message("f_d0204_0210_0030")
      npc_2023_bn01:Play(10, true)
      Field.ObjectChangeExpression(NPC, npc_2021, "F02", -1, true, 10)
      npc_2021_fq02:Play(10, true)
      Message("f_d0204_0210_0040")
      npc_2021_fe02:Play(10, true)
      Message("f_d0204_0210_0050")
      npc_2021_bn01:Play(10, true)
      Cam.Inst:Clear(45)
      Field.ObjectClearExpression(NPC, npc_2021, 10)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 339 then
      local fldtxt = "d02"
      local npc_2024_bn01 = Motion.Object:new(NPC, "npc_2024", "bn01")
      local npc_2024_fe02 = Motion.Object:new(NPC, "npc_2024", "fe02")
      local npc_2024_fq02 = Motion.Object:new(NPC, "npc_2024", "fq02")
      Cam.Inst:Set(8.12924, -1.250016, -2.027018, 0.769182, 2.216344, 3.787953, default, 45)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(45)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      npc_2024_fe02:Play(10, true)
      Motion.Player:PlayWithMoveMotion("e006", 5, 5)
      Message("f_d0204_0220_0010")
      WaitFrame(10)
      START_TALK_ACTION_AND_ZOOM("npc_2024", true, false)
      npc_2024_bn01:Play(10, true)
      Message("f_d0204_0220_0020")
      END_TALK_ACTION_AND_ZOOM("npc_2024", true, false)
      npc_2024_fq02:Play(10, true)
      Message("f_d0204_0220_0030")
      npc_2024_fe02:Play(10, true)
      Message("f_d0204_0220_0040")
      Message("f_d0204_0220_0050")
      MessageClose()
      WaitFrame(20)
      Cam.Inst:Set(8.461667, -0.850126, -1.163407, 1.94614, 2.085012, 5.831797, default, 20)
      WaitFrame(20)
      START_TALK_ACTION_AND_ZOOM("npc_2011", true, false)
      Message("f_d0204_0220_0060")
      START_TALK_ACTION_AND_ZOOM("npc_2022", true, false)
      Message("f_d0204_0220_0070")
      END_TALK_ACTION_AND_ZOOM("npc_2011", true, false)
      npc_2024_bn01:Play(10, true)
      Message("f_d0204_0220_0080")
      END_TALK_ACTION_AND_ZOOM("npc_2022", true, false)
      START_TALK_ACTION_AND_ZOOM("npc_2024", true, false)
      Message("f_d0204_0220_0090")
      END_TALK_ACTION_AND_ZOOM("npc_2024", true, false)
      npc_2024_fq02:Play(10, true)
      Cam.Inst:Clear(45)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 340 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0230_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 341 then
      if Flg.Check("FLAG_FIELD_D0204_030") then
        local fldtxt = "d02"
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0240_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_FIELD_D0204_020") then
        local fldtxt = "d02"
        Flg.Set("FLAG_FIELD_D0204_030")
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0240_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        local fldtxt = "d02"
        Flg.Set("FLAG_FIELD_D0204_020")
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0240_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 342 then
      local fldtxt = "d02"
      local Centaru_fq01 = Motion.Object:new(NPC, "npc_2027", "fq01")
      local Centaru_bn01 = Motion.Object:new(NPC, "npc_2027", "bn01")
      local mera_fe02 = Motion.Object:new(MOB, "mob_001", "fe02")
      local mera_fe04 = Motion.Object:new(MOB, "mob_001", "fe04")
      Cam.Inst:Set(-5.59511, -0.394432, -1.260661, 3.567364, 2.710846, 1.270412, default, 45)
      WaitFrame(40)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0250_0010")
      Centaru_bn01:Play(10, true)
      mera_fe04:Play(10, true)
      Message("f_d0204_0250_0020")
      Centaru_fq01:Play(10, true)
      Message("f_d0204_0250_0030")
      mera_fe02:Play(10, true)
      Cam.Inst:Clear(45)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 343 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0260_0010")
      Message("f_d0204_0260_0020")
      Message("f_d0204_0260_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0600" then
      local fldtxt = "d02"
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0600"), "F01_T01")
      require("S050_046")
      require("S050_176")
      if Qst.Sub:Check(S050_176.ID, S050_176.STEP_001, S050_176.STEP_005) then
        S050_176:Event_010()
      elseif Flg.Check("FLAG_MAIN_13_170") and not Flg.Check("FLAG_MAIN_13_180") then
        M350:Event_090()
      elseif Flg.Check("FLAG_MAIN_13_180") and not Flg.Check("FLAG_MAIN_15_040") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0600"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d0204_0610_0010")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0600"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_15_040") and not Flg.Check("FLAG_MAIN_15_050") then
        M360:Event_070()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0600"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d0204_0620_0010")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0600"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc_0800" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S050_043")
      S050_043:Event_050()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "npc_901" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0900_0150")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_902" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0900_0170")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 500 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0230_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 501 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0340_0010")
      MessageClose()
      WaitFrame(20)
      Message("f_d0204_0340_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 502 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0350_0010")
      Message("f_d0204_0350_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 504 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0360_0010")
      Message("f_d0204_0360_0020")
      Message("f_d0204_0360_0030")
      Message("f_d0204_0360_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 506 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0370_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 508 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0380_0010")
      Message("f_d0204_0380_0020")
      Message("f_d0204_0380_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 509 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0390_0010")
      Message("f_d0204_0390_0020")
      Message("f_d0204_0390_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 513 then
      local fldtxt = "d02"
      Cam.Inst:Set(8.769915, -0.600096, -0.346746, 2.404448, 2.806338, 6.572576, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0400_0010")
      Message("f_d0204_0400_0020")
      Message("f_d0204_0400_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 514 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0470_0010")
      Message("f_d0204_0470_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 515 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0230_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 516 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0410_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 518 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0420_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 519 then
      local fldtxt = "d02"
      Cam.Inst:Set(0.079853, 3.79392, -42.139061, -0.133148, 0.945045, -32.555017, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0430_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 520 then
      local fldtxt = "d02"
      Cam.Inst:Set(5.907074, 1.754077, -39.01585, 4.080098, 3.08737, -29.208401, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0440_0010")
      Message("f_d0204_0440_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 521 then
      local fldtxt = "d02"
      Cam.Inst:Set(-5.068678, 1.754077, -39.856293, -3.740613, 3.08737, -30.03496, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0450_0010")
      Message("f_d0204_0450_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 523 then
      local fldtxt = "d02"
      Cam.Inst:Set(0.226023, 2.712301, -35.562355, 0.445278, 1.089872, -25.562355, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0460_0010")
      Message("f_d0204_0460_0020")
      Message("f_d0204_0460_0030")
      Message("f_d0204_0460_0040")
      Message("f_d0204_0460_0050")
      Message("f_d0204_0460_0060")
      Message("f_d0204_0460_0070")
      Message("f_d0204_0460_0080")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_003" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_9020_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0204_9020_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1206, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0204_9020_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0204_9020_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0204_9020_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 700 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0480_0010")
      Message("f_d0204_0480_0020")
      Message("f_d0204_0480_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 701 then
      local fldtxt = "d02"
      if Flg.Check("FLAG_FIELD_D0204_010") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0500_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Flg.Set("FLAG_FIELD_D0204_010")
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0204_0500_0010")
        Message("f_d0204_0500_0020")
        Message("f_d0204_0500_0030")
        MessageClose()
        INFO_GET_ITEM(1, 1)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 702 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0490_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 703 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0510_0010")
      Message("f_d0204_0510_0020")
      Message("f_d0204_0510_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 704 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0520_0010")
      Message("f_d0204_0520_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 705 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0530_0010")
      Message("f_d0204_0530_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 706 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0540_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 707 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0550_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 708 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0204_0560_0010")
      Message("f_d0204_0560_0020")
      Message("f_d0204_0560_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s020_173_001" then
      require("S020_173")
      S020_173:Event_020()
      S020_173:Event_030()
      S020_173:Event_010()
    end
    if npc_name == "s050_176_001" then
      require("S050_176")
      S050_176:Event_010()
    end
  elseif gMapNum == 205 then
    if talk_id == 300 then
      Prcs_d0205_ride_pegasmon()
    end
  elseif gMapNum == 206 then
    local gim_text = "field_text"
    if talk_id == 500 then
      local tlk = Tlk:new("d02", 1, true)
      tlk:StartTalk()
      tlk:Message("f_d0201_0080_0020")
      tlk:EndTalk()
      Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      OpenWorldMap(DW, LOCOMON)
      Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
    end
    if talk_id == 308 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0206_0050_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 309 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0206_0060_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 301 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0206_0090_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 302 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0206_0100_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 306 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0206_0110_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 307 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0206_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0206_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      elseif result == RESULT_TALK01 then
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 303 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      M140:Event_050()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 304 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      M140:Event_050()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "sub_050_041_haguru" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("s050_041")
      S050_041:Event_020()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "sub_050_041_solar" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("s050_041")
      S050_041:Event_025()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 900 then
      Prcs_d0206_patamonride_id900()
    end
    if npc_name == "npc_warp01" then
      D02_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      if not Flg.Check("FLAG_MAIN_13_180") then
        D02_WarpNPC_After(npc_name)
      else
        D02_WarpNPC_After2(npc_name)
      end
    end
  elseif gMapNum == 207 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      if not Flg.Check("FLAG_GIMMICK_D02_250") then
        Flg.Set("FLAG_GIMMICK_D02_250")
        Message("f_d0207_0060_0010")
        Message("f_d0207_0060_0015")
        Message("f_d0207_0060_0020")
        Message("f_d0207_0060_0030")
        MessageClose()
        MessageTalkSel(2, "f_d0207_0050_0010")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_d0207_0080_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
          Prcs_d02_PickUpHagurumon("sp_0001", true, -1, "npc_0001")
          Field.DisableSystemFieldAttack()
          SetEnableAllCheckPoint(false)
          ColOn("plan_cl_0050")
          Flg.Set("FLAG_IS_CARRY_OBJECT")
        elseif result == RESULT_TALK01 then
          Message("f_d0207_0090_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
        end
      else
        Message("f_d0207_0070_0010")
        MessageClose()
        MessageTalkSel(2, "f_d0207_0050_0010")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_d0207_0080_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
          Prcs_d02_PickUpHagurumon("sp_0001", true, -1, "npc_0001")
          Field.DisableSystemFieldAttack()
          SetEnableAllCheckPoint(false)
          ColOn("plan_cl_0050")
          Flg.Set("FLAG_IS_CARRY_OBJECT")
        elseif result == RESULT_TALK01 then
          Message("f_d0207_0090_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
        end
      end
    end
    if talk_id == 500 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0207_0100_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 208 then
    if talk_id == 3 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0208_0040_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 209 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      if not Flg.Check("FLAG_GIMMICK_D02_350") then
        Flg.Set("FLAG_GIMMICK_D02_350")
        Message("f_d0209_0050_0010")
        Message("f_d0209_0050_0020")
        Message("f_d0209_0050_0030")
        MessageClose()
        MessageTalkSel(2, "f_d0209_0020_0010")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_d0209_0060_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
          Field.DisableSystemFieldAttack()
          SetEnableAllCheckPoint(false)
          Prcs_d02_PickUpHagurumon("sp_0001", true, -1, "npc_0001")
          Flg.Set("FLAG_IS_CARRY_OBJECT")
        elseif result == RESULT_TALK01 then
          Message("f_d0209_0070_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
        end
      else
        Message("f_d0209_0080_0010")
        MessageClose()
        MessageTalkSel(2, "f_d0209_0020_0010")
        local result = Talk.GetResultSelectedNum()
        if result == RESULT_TALK00 then
          Message("f_d0209_0060_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
          Field.DisableSystemFieldAttack()
          SetEnableAllCheckPoint(false)
          Prcs_d02_PickUpHagurumon("sp_0001", true, -1, "npc_0001")
          Flg.Set("FLAG_IS_CARRY_OBJECT")
        elseif result == RESULT_TALK01 then
          Message("f_d0209_0070_0010")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
          Field_Talk_End_Not_LetterBox()
        end
      end
    end
  elseif gMapNum == 210 then
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_BeforeD02(npc_name)
    end
    if npc_name == "sub_050_042_01" then
      require("s050_042")
      S050_042:Event_050()
      S050_042:Event_020()
    end
    if npc_name == "s110_092_001" then
      require("S110_092")
      S110_092:Event_010()
    end
    if npc_name == "agumon_knight_01" then
      require("S110_098")
      if Qst.Sub:Check(211, 1, 255) then
        require("S110_211")
        S110_211:Event_010()
        goto lbl_14076
      elseif Qst.Sub:IsCompleted(211) then
        require("S110_211")
        S110_211:Event_030()
        goto lbl_14076
      elseif not Qst.Sub:IsCompleted(98) and Qst.Sub:Check(98, 1) then
        S110_098:Event_010()
      elseif not Qst.Sub:Check(211, 1) then
        require("S100_087")
        S100_087:Event_030()
      end
    end
    ::lbl_14076::
    if npc_name == "gabumon_knight_01" then
      require("S100_087")
      S100_087:Event_040()
    end
    if npc_name == "RoyalKights_ULFORCEVDRAMON" then
      Cam.Inst:Set(5.91, 40.324, 10.986, 3, 39.4, 20.51, default, 30)
      require("S110_211")
      S110_211:Event_040()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKights_MAGNAMON" then
      Cam.Inst:Set(-7.55, 40.424, 12.784, -3.49, 40.39, 21.92, default, 30)
      require("S110_211")
      S110_211:Event_050()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKights_LOADKNIGHTMON" then
      if not Qst.Sub:IsCompleted(106) then
        if Qst.Sub:Check(106, 1, 255) then
          require("S110_106")
          S110_106:Event_020()
          S110_106:Event_010()
        else
          Cam.Inst:Set(7.44, 33.59, 27.1, 2.45, 33.92, 35.75, default, 30)
          require("S110_211")
          S110_211:Event_060()
          Cam.Inst:Clear(30)
        end
      else
        Cam.Inst:Set(7.44, 33.59, 27.1, 2.45, 33.92, 35.75, default, 30)
        require("S110_211")
        S110_211:Event_060()
        Cam.Inst:Clear(30)
      end
    end
    if npc_name == "RoyalKights_DUKEMON" then
      Cam.Inst:Set(10.61, 41.074, 14.914, 4.776, 40.158, 22.98, default, 30)
      require("S110_211")
      S110_211:Event_070()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKights_DYNASMON" then
      if not Qst.Sub:IsCompleted(105) then
        if not Qst.Sub:IsCompleted(104) then
          Cam.Inst:Set(6.71, 33.89, 24.81, -1.38, 33.74, 30.69, default, 30)
          require("S110_211")
          S110_211:Event_080()
          Cam.Inst:Clear(30)
        end
        require("S110_105")
        S110_105:Event_015()
        S110_105:Event_010()
      elseif not Qst.Sub:IsCompleted(106) then
        if not Qst.Sub:Check(106, 1) then
          Cam.Inst:Set(6.71, 33.89, 24.81, -1.38, 33.74, 30.69, default, 30)
          require("S110_211")
          S110_211:Event_080()
          Cam.Inst:Clear(30)
        else
          require("S110_106")
          S110_106:Event_025()
          S110_106:Event_012()
          S110_106:Event_010()
        end
      else
        Cam.Inst:Set(6.71, 33.89, 24.81, -1.38, 33.74, 30.69, default, 30)
        require("S110_211")
        S110_211:Event_080()
        Cam.Inst:Clear(30)
      end
    end
    if npc_name == "RoyalKnights_CRANIAMON" then
      Cam.Inst:Set(-6.36, 33.39, 21.01, -0.3, 34.68, 28.85, default, 30)
      require("S110_211")
      S110_211:Event_090()
      Cam.Inst:Clear(30)
    end
    if npc_name == "s110_ENBARRMON" then
      Cam.Inst:Set(-4.06, 32.994, 20.21, 1.045, 35.07, 28.56, default, 30)
      require("S110_093")
      S110_093:Event_080()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKnights_SLEIPMON" then
      Cam.Inst:Set(12.82, 38.22, 19.84, 4.37, 38.91, 25.13, default, 30)
      require("S110_211")
      S110_211:Event_100()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKights_DUFTMON" then
      Cam.Inst:Set(4.41, 33.99, 21.39, -1.71, 33.99, 29.3, default, 30)
      require("S110_211")
      S110_211:Event_110()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKights_EXAMON" then
      Cam.Inst:Set(-12.761, 41.174, 24, -9.51, 42.451, 33.37, default, 30)
      require("S110_211")
      S110_211:Event_120()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKnights_GANKOOMON" then
      require("S110_211")
      S110_211:Event_130()
    end
    if npc_name == "RoyalKnights_JESMON" then
      Cam.Inst:Set(-6.27, 34.194, 26.675, 1.654, 35.19, 32.69, default, 30)
      require("S110_211")
      S110_211:Event_140()
      Cam.Inst:Clear(30)
    end
    if npc_name == "RoyalKights_ALFAMON" then
      Cam.Inst:Set(0.05, 34.474, 15.996, -0.1978, 32.8, 25.85, default, 30)
      require("S110_211")
      S110_211:Event_150()
      Cam.Inst:Clear(30)
    end
    if npc_name == "s100_089_001" then
      require("S100_089")
      S100_089:Event_500()
    end
    if npc_name == "s100_089_002" then
      require("S100_089")
      S100_089:Event_510()
    end
    if npc_name == "s100_089_003" then
      require("S100_089")
      S100_089:Event_520()
    end
    if npc_name == "s100_089_004" then
      require("S100_089")
      S100_089:Event_530()
    end
    if npc_name == "s110_098_001" or npc_name == "s110_098_002" then
      require("S110_098")
      S110_098:Event_010()
    end
    if talk_id == 900 then
      Prcs_d0206_patamonride_id900()
    end
    if npc_name == "npc_warp01" then
      D02_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      if not Flg.Check("FLAG_MAIN_13_180") then
        D02_WarpNPC_After(npc_name)
      else
        D02_WarpNPC_After2(npc_name)
      end
    end
  elseif gMapNum == 211 then
    if npc_name == "card_001" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0211_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0211_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1207, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0211_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0211_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0211_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "card_002" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0211_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0211_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1210, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0211_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0211_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0211_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
  elseif gMapNum == 212 then
    if talk_id == 300 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Message("f_d0212_0010_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "s080_060_001" then
      require("S080_060")
      S080_060:Event_060()
    end
    if talk_id == 350 then
      local fldtxt = "d02"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0212_0020_0010")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Message("f_d0212_0020_0020")
      Message("f_d0212_0020_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 213 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      local chr001_state = GetControlScriptExternalVariableString("chr001_hide_state")
      if not Flg.Check("FLAG_IS_CHECK_D0213_DOLL_1") then
        SetControlScriptExternalVariable("chr001_hide_state", "fidget")
        Message("f_d0213_0010_0010")
      elseif not Flg.Check("FLAG_IS_CHECK_D0213_DOLL_2") then
        Flg.Set("FLAG_IS_CHECK_D0213_DOLL_2")
        Message("f_d0213_0010_0020")
      elseif not Flg.Check("FLAG_IS_CHECK_D0213_DOLL_3") then
        Flg.Set("FLAG_IS_CHECK_D0213_DOLL_3")
        Message("f_d0213_0010_0030")
      elseif not Flg.Check("FLAG_IS_CHECK_D0213_DOLL_4") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Flg.Set("FLAG_IS_CHECK_D0213_DOLL_4")
        Motion.NPC:Play("chr001_hide", "bd03", 10, false)
        WaitFrame(40)
        Motion.NPC:Play("chr001_hide", "bn01", 10, true)
        Message("f_d0213_0010_0040")
        Message("f_d0213_0010_0050")
        MessageClose()
        INFO_GET_ITEM(1142, 1)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        Message("f_d0213_0010_0060")
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 350 then
      local fldtxt = "d02"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0213_0020_0010")
      MessageClose()
      WaitFrame(10)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Motion.NPC:Play("npc_0050", "bd03", 10, false)
      WaitFrame(40)
      Motion.NPC:Play("npc_0050", "bn01", 10, true)
      Message("f_d0213_0020_0020")
      Message("f_d0213_0020_0030")
      Message("f_d0213_0020_0040")
      Message("f_d0213_0020_0050")
      Message("f_d0213_0020_0060")
      Field_Talk_End_Not_LetterBox()
      Motion.NPC:Play("npc_0050", "bd02", 10, false)
      WaitFrame(30)
      Motion.NPC:Play("npc_0050", "f000", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 360 then
      local fldtxt = "d02"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0213_0030_0010")
      MessageClose()
      WaitFrame(10)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Motion.NPC:Play("npc_0060", "bd03", 10, false)
      WaitFrame(40)
      Motion.NPC:Play("npc_0060", "bn01", 10, true)
      Message("f_d0213_0030_0020")
      Message("f_d0213_0030_0030")
      Message("f_d0213_0030_0040")
      Message("f_d0213_0030_0050")
      Message("f_d0213_0030_0060")
      Field_Talk_End_Not_LetterBox()
      Motion.NPC:Play("npc_0060", "bd02", 10, false)
      WaitFrame(30)
      Motion.NPC:Play("npc_0060", "f000", 10, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 1 then
      local fldtxt = "d02"
      local npc_index = GetIndex(NPC, "npc_0001")
      local e002 = Motion.Object:new(NPC, "npc_0001", "e002")
      local bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
      if Qst.Sub:Check(13, 10, 15) then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        require("S020_013")
        S020_013:Event_020()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0213_0040_0010")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index, "e002", 10, 10)
        Message("f_d0213_0040_0020")
        Message("f_d0213_0040_0030")
        Field.ObjectResetAim(NPC, npc_index, 20)
        Message("f_d0213_0040_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "card_001" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0213_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0213_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1208, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0213_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0213_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0213_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
  elseif gMapNum == 215 then
    if talk_id == 300 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0215_0070_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    elseif talk_id == 400 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0215_0080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 3 then
      M120:Event_066()
    end
    if talk_id == 350 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0215_0120_0010")
      Message("f_d0215_0120_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "sub055_001" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S070_055")
      S070_055:Event_010()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "s070_167_minerva" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      require("S070_167")
      S070_167:Event_005()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
  elseif gMapNum == 216 then
    if talk_id == 1 then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0216_0010_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_warp01" then
      D02_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" then
      if not Flg.Check("FLAG_MAIN_13_180") then
        D0216_WarpNPC_After(npc_name)
      else
        D0216_WarpNPC_After2(npc_name)
      end
    end
  end
  if gMapNum == 217 then
    if talk_id == 300 then
      local fldtxt = "d02"
      local g_bn01 = Motion.Object:new(NPC, "npc_0300", "bn01")
      local g_fq01 = Motion.Object:new(NPC, "npc_0300", "fq01")
      local g_fe02 = Motion.Object:new(NPC, "npc_0300", "fe02")
      local g_fe04 = Motion.Object:new(NPC, "npc_0300", "fe04")
      local s_bn01 = Motion.Object:new(NPC, "npc_0301", "bn01")
      local s_fq01 = Motion.Object:new(NPC, "npc_0301", "fq01")
      local s_fe04 = Motion.Object:new(NPC, "npc_0301", "fe02")
      local npc_index01 = GetIndex(NPC, "npc_0300")
      local npc_index02 = GetIndex(NPC, "npc_0301")
      if Flg.Check("FLAG_FIELD_D0217_GUNDORA_TALK") then
        Cam.Inst:Set(0.11, -31.77, -3.1, 0.96, -33.78, 6.65, default, 30)
        WaitFrame(30)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0217_0020_0010")
        Message("f_d0217_0020_0020")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe02", 10, 10)
        Message("f_d0217_0020_0030")
        Cam.Inst:Clear(30)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        Cam.Inst:Set(0.11, -31.77, -3.1, 0.96, -33.78, 6.65, default, 30)
        WaitFrame(30)
        Flg.Set("FLAG_FIELD_D0217_GUNDORA_TALK")
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        START_TALK_ACTION_AND_ZOOM("npc_0301", true, false)
        WaitFrame(15)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index02, "fe02", 10, 10)
        Message("f_d0217_0010_0010")
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Message("f_d0217_0010_0020")
        MessageClose()
        WaitFrame(15)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq01", 10, 10)
        Message("f_d0217_0010_0030")
        Message("f_d0217_0010_0040")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe04", 10, 10)
        Message("f_d0217_0010_0050")
        MessageClose()
        WaitFrame(5)
        INFO_GET_ITEM(1, 1)
        WaitFrame(5)
        Message("f_d0217_0010_0060")
        END_TALK_ACTION_AND_ZOOM("npc_0301", true, false)
        Cam.Inst:Clear(30)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 301 then
      local fldtxt = "d02"
      local npc_index01 = GetIndex(NPC, "npc_0301")
      local s_bn01 = Motion.Object:new(NPC, "npc_0301", "bn01")
      local s_fq02 = Motion.Object:new(NPC, "npc_0301", "fq02")
      local s_fe04 = Motion.Object:new(NPC, "npc_0301", "fe02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe02", 10, 10)
      Message("f_d0217_0030_0010")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      Message("f_d0217_0030_0020")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe02", 10, 10)
      Message("f_d0217_0030_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 302 then
      local fldtxt = "d02"
      local npc_index01 = GetIndex(NPC, "npc_0302")
      local bn01 = Motion.Object:new(NPC, "npc_0302", "bn01")
      local fe02 = Motion.Object:new(NPC, "npc_0302", "fe02")
      local fe04 = Motion.Object:new(NPC, "npc_0302", "fe04")
      local fq02 = Motion.Object:new(NPC, "npc_0302", "fq02")
      local m_fe02 = Motion.Object:new(NPC, "npc_0303", "fe02")
      local m_fe04 = Motion.Object:new(NPC, "npc_0303", "fe04")
      Cam.Inst:Set(2.19, -31.94, 5.16, -6.44, -33.23, 10.04, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fq02", 10, 10)
      Message("f_d0217_0040_0010")
      Field.ObjectPlayMotionWithStartMoveMotion(NPC, npc_index01, "fe02", 10, 10)
      Message("f_d0217_0040_0020")
      m_fe02:Play(10, true)
      Message("f_d0217_0040_0030")
      m_fe04:Play(10, true)
      fe04:Play(10, true)
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_001" then
      local fldtxt = "d02"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0217_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0217_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1209, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0217_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0217_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0217_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD02(npc_name)
    end
    if npc_name == "shop_0001" then
      local cam_npc = {
        -12.705,
        5.757,
        -11.88,
        -15.958,
        4.997,
        -2.455
      }
      local cam_shop = {
        -15.305,
        6.907,
        -12.502,
        -16.009,
        5.176,
        -2.678
      }
      DevelopShopStart(npc_name, 151, "fq01", "fe04", "fe04", cam_npc, cam_shop, nil, "fe02")
    end
  end
end

function OnFieldAttackNpc(args)
  local type, index, unique_name = args.obj_type, args.obj_index, args.unique_name
  if unique_name == "npc_0203" then
    require("S050_043")
    S050_043:Event_030()
  end
end

function D02_WarpNPC_Before(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  local map_id = Field.GetMapNumber()
  Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = 0
  if Flg.Check("FLAG_MAIN_04_990") then
    result = tlk:Select(5, "f_d0107_0100_0150")
  else
    result = tlk:Select(5, "f_d0107_0100_0180")
  end
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 or result == RESULT_TALK03 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_D12_D02_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      if Flg.Check("FLAG_MAIN_04_990") then
        MapChange("d", 201, "start_90", false, FADE_WHITE, FADE_TIME)
      else
        MapChange("d", 201, "start_31", false, FADE_WHITE, FADE_TIME)
      end
    elseif result == RESULT_TALK01 then
      MapChange("d", 204, "start_00", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 206, "start_04", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK03 then
      MapChange("d", 210, "start_02", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function D02_WarpNPC_After(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  local map_id = Field.GetMapNumber()
  Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(4, "f_d0107_0100_0160")
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_D12_D02_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 1204, "start_40", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 201, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 204, "start_00", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function D0216_WarpNPC_After(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  local map_id = Field.GetMapNumber()
  Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(3, "f_d0107_0100_0161")
  if result == RESULT_TALK00 or result == RESULT_TALK01 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_D12_D02_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 201, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 204, "start_00", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function D02_WarpNPC_After2(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  local map_id = Field.GetMapNumber()
  Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(5, "f_d0107_0100_0170")
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 or result == RESULT_TALK03 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_D12_D02_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 1204, "start_40", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 201, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 204, "start_00", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK03 then
      MapChange("d", 210, "start_02", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function D0216_WarpNPC_After2(npc_name)
  local npc01_index = GetIndex(NPC, npc_name)
  local pos = Field.ObjectGetPosition(NPC, npc01_index)
  local rot = Field.ObjectGetRotationY(NPC, npc01_index)
  local vector2d = Field.GetUnitVector2D(rot)
  local cam_x = pos.x + vector2d.x * 5
  local cam_y = pos.y
  local cam_z = pos.z + vector2d.z * 5
  local map_id = Field.GetMapNumber()
  Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
  PlayerLookAtObject(NPC, npc_name)
  local tlk = Tlk:new("d01", 1, false)
  tlk:StartTalk()
  tlk:Message("f_d0107_0100_0010")
  local result = tlk:Select(4, "f_d0107_0100_0171")
  if result == RESULT_TALK00 or result == RESULT_TALK01 or result == RESULT_TALK02 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_D12_D02_IS_WARP")
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 201, "start_30", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 204, "start_00", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK02 then
      MapChange("d", 210, "start_02", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end
