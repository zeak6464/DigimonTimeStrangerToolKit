function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 1201 then
  elseif gMapNum == 1204 then
    if talk_id == 450 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Shop.Open(105)
      WaitCloseShopWindow()
      ShopClose()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    elseif talk_id == 451 then
      local cam_npc = {
        29.8,
        -0.34,
        -56.3,
        22.02,
        1.36,
        -50.25
      }
      local cam_shop = {
        29.04,
        -2.18,
        -57.39,
        22.43,
        1.53,
        -50.87
      }
      CommonShopStart(npc_name, 102, "ba02", "bs01", "fq02", cam_npc, cam_shop)
    elseif talk_id == 452 then
      local cam_npc = {
        13.52,
        0.98,
        -66.978,
        10.159,
        3.209,
        -57.827
      }
      local cam_shop = {
        10.457,
        3.88,
        -68.772,
        9.902,
        2.787,
        -58.847
      }
      DevelopShopStart(npc_name, 150, "fe04", "fq01", "fq01", cam_npc, cam_shop, nil, "fe02")
    elseif talk_id == 453 then
      local cam_npc = {
        26.11,
        -1.71,
        -60.75,
        19.69,
        1.03,
        -53.59
      }
      local cam_shop = {
        25.59,
        -1.61,
        -61.75,
        19.65,
        0.93,
        -54.12
      }
      CommonShopStart(npc_name, 104, "bv01", "fe04", "fe02", cam_npc, cam_shop, "f000")
    elseif talk_id == 454 then
      local cam_npc = {
        -43.68,
        3,
        -39.53,
        -33.91,
        4.75,
        -40.71
      }
      local cam_shop = {
        -44.19,
        5.16,
        -38.7,
        -34.34,
        4.65,
        -40.37
      }
      CommonShopStart(npc_name, 114, "fq01", "fe02", "fq01", cam_npc, cam_shop)
    elseif talk_id == 455 then
      local cam_npc = {
        -42.34,
        3.19,
        -45.91,
        -32.71,
        4.41,
        -43.49
      }
      local cam_shop = {
        -42.73,
        3,
        -45.77,
        -33.31,
        4.75,
        -42.92
      }
      CommonShopStart(npc_name, 131, "ba02", "fe02", "fe04", cam_npc, cam_shop)
    end
    if talk_id == 301 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0040_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 302 then
      local fldtxt = "d12"
      local fq01 = Motion.Object:new(NPC, "npc_0002", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq01:Play(20, true)
      Message("f_d1204_0090_0020")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0002"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 303 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0130_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 304 then
      local fldtxt = "d12"
      local fe04 = Motion.Object:new(NPC, "npc_0004", "fe04")
      local bn01 = Motion.Object:new(NPC, "npc_0004", "bn01")
      local fq01 = Motion.Object:new(NPC, "npc_0004", "fq01")
      local fq02 = Motion.Object:new(NPC, "npc_0004", "fq02")
      local fe02 = Motion.Object:new(NPC, "npc_0004", "fe02")
      if Flg.Check("FLAG_MAIN_12_055") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1204_0620_0010")
        Message("f_d1204_0620_0020")
        Message("f_d1204_0620_0030")
        Message("f_d1204_0620_0040")
        Message("f_d1204_0620_0050")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_08_040") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1204_0610_0010")
        Message("f_d1204_0610_0020")
        Message("f_d1204_0610_0030")
        Message("f_d1204_0610_0040")
        Message("f_d1204_0610_0050")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        fe04:Play(20, true)
        Message("f_d1204_0150_0010")
        bn01:Play(20, true)
        Message("f_d1204_0150_0020")
        fq01:Play(20, true)
        Message("f_d1204_0150_0030")
        fq02:Play(20, true)
        Message("f_d1204_0150_0040")
        fe02:Play(20, true)
        Message("f_d1204_0150_0050")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0004"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 305 then
      local fldtxt = "d12"
      local npc_0005 = Obj:new(NPC, "npc_0005")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0005:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0080_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
      npc_0005:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 307 then
      local fldtxt = "d12"
      local fq02 = Motion.Object:new(NPC, "npc_0007", "fq02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq02:Play(20, true)
      Message("f_d1204_0160_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0007"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 308 then
      local fldtxt = "d12"
      local npc_0008 = Obj:new(NPC, "npc_0008")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0008:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0260_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
      npc_0008:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 309 then
      local fldtxt = "d12"
      local f005 = Motion.Object:new(NPC, "npc_0009", "f005")
      local fq01 = Motion.Object:new(NPC, "npc_0009", "fq01")
      local bn02 = Motion.Object:new(NPC, "npc_0009", "bn02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      f005:Play(20, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0009"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
      Message("f_d1204_0170_0010")
      fq01:Play(20, true)
      Message("f_d1204_0170_0020")
      bn02:Play(20, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0009"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      Message("f_d1204_0170_0030")
      Message("f_d1204_0170_0040")
      Message("f_d1204_0170_0050")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0009"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 310 then
      local fldtxt = "d12"
      local f005 = Motion.Object:new(NPC, "npc_0010", "f005")
      local fq02 = Motion.Object:new(NPC, "npc_0010", "fq02")
      local f004 = Motion.Object:new(NPC, "npc_0010", "f004")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      f005:Play(20, true)
      Message("f_d1204_0180_0010")
      fq02:Play(20, true)
      Message("f_d1204_0180_0020")
      f004:Play(20, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0010"), "F01", EYES_BLINK_TYPE_CLOSE, false, 0)
      Message("f_d1204_0180_0030")
      Message("f_d1204_0180_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0010"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 311 then
      local fldtxt = "d12"
      local fe02 = Motion.Object:new(NPC, "npc_0011", "fe02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe02:Play(20, true)
      Message("f_d1204_0100_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0011"), 30)
      Message("f_d1204_0100_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 312 then
      local fldtxt = "d12"
      local e021 = Motion.Object:new(NPC, "npc_0012", "e021")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0190_0010")
      e021:Play(20, true)
      Message("f_d1204_0190_0020")
      Message("f_d1204_0190_0030")
      Message("f_d1204_0190_0040")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0012"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 313 then
      local fldtxt = "d12"
      local fe04 = Motion.Object:new(NPC, "npc_0013", "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe04:Play(20, true)
      Message("f_d1204_0200_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0013"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 314 then
      local fldtxt = "d12"
      local fe04 = Motion.Object:new(NPC, "npc_0014", "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fe04:Play(20, true)
      Message("f_d1204_0210_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0014"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 315 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0220_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 316 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0230_0010")
      Message("f_d1204_0230_0020")
      Message("f_d1204_0230_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 317 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0240_0010")
      Message("f_d1204_0240_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 318 then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_12_055") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1204_0630_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1204_0250_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "card_001" then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d1204_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(11201, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d1204_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d1204_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d1204_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "npc_0222" then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_11_005") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1204_0680_0010")
        Message("f_d1204_0680_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        M310:Event_040()
      end
    end
    if npc_name == "npc_0223" then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_11_056") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1204_0690_0010")
        Message("f_d1204_0690_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 306 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0580_0010")
      Message("f_d1204_0580_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 354 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(5.63, 4.48, -17.9, 1.3, 0.94, -9.61, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0470_0010")
      Message("f_d1204_0470_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 355 then
      local fldtxt = "d12"
      local npc_0055 = Obj:new(NPC, "npc_0055")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0055:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0590_0010")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0055"), "F02", EYES_BLINK_TYPE_BLINK, false, 0)
      Message("f_d1204_0590_0020")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0055"), "F01", EYES_BLINK_TYPE_BLINK, false, 0)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
      npc_0055:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 210 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0510_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 330 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0270_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 331 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0280_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 332 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0290_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 333 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0300_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 334 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0310_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 335 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0320_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 336 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0330_0010")
      Message("f_d1204_0330_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 337 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0340_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 338 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0350_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 339 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0360_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 340 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0370_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 341 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0380_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 356 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Cam.Inst:Set(-3.11, -0.06, -7.9, -2.46, 2.29, 1.78, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0550_0010")
      Message("f_d1204_0550_0020")
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 358 then
      local fldtxt = "d12"
      local bn01 = Motion.Object:new(NPC, "npc_0058", "bn01")
      local fe02 = Motion.Object:new(NPC, "npc_0058", "fe02")
      local fq01 = Motion.Object:new(NPC, "npc_0058", "fq01")
      local fq02 = Motion.Object:new(NPC, "npc_0058", "fq02")
      local k_e500 = Motion.Object:new(NPC, "npc_0059", "e500")
      local k_fq01 = Motion.Object:new(NPC, "npc_0059", "fq01")
      Cam.Inst:Set(-24.96, 0.03, -41.01, -18.18, 1.84, -33.89, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      fq02:Play(10, true)
      Message("f_d1204_0540_0010")
      k_e500:Play(20, true)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0059"), "F03", EYES_BLINK_TYPE_BLINK, false, 0)
      Message("f_d1204_0540_0020")
      fq01:Play(5, true)
      Message("f_d1204_0540_0030")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0058"), 30)
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0059"), 30)
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 360 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0560_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 361 then
      local fldtxt = "d12"
      local kokuwaA_fe02 = Motion.Object:new(NPC, "npc_0061", "fe02")
      local kokuwaA_fq01 = Motion.Object:new(NPC, "npc_0061", "fq01")
      local kokuwaB_bn01 = Motion.Object:new(NPC, "npc_0062", "bn01")
      local kokuwaB_fq01 = Motion.Object:new(NPC, "npc_0062", "fq01")
      Cam.Inst:Set(21.27, 0.38, -16.74, 12.48, 1.19, -21.43, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      kokuwaA_fe02:Play(10, true)
      Message("f_d1204_0570_0010")
      kokuwaB_fq01:Play(10, true)
      Message("f_d1204_0570_0020")
      kokuwaA_fq01:Play(10, true)
      kokuwaB_bn01:Play(10, true)
      Cam.Inst:Clear(30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 211 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      local e002 = Motion.Object:new(NPC, "npc_0211", "e002")
      local e023 = Motion.Object:new(NPC, "npc_0211", "e023")
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e002:Play(20, false)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0211"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1204_0500_0010")
      Message("f_d1204_0500_0020")
      Message("f_d1204_0500_0030")
      Message("f_d1204_0500_0040")
      e023:Play(20, false)
      Message("f_d1204_0500_0050")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0211"), 30)
      Message("f_d1204_0500_0060")
      Message("f_d1204_0500_0070")
      Message("f_d1204_0500_0080")
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0211"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      e002:Play(20, false)
      Message("f_d1204_0500_0090")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0211"), 30)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0024" then
      PlayerTurnToObject(NPC, npc_name, true, false, 0, 0)
      if Flg.Check("FLAG_MAIN_11_005", "FLAG_MAIN_11_009") then
        M310:Event_045()
      elseif Flg.Check("FLAG_MAIN_17_020", "FLAG_MAIN_17_036") then
        local tlk = Tlk:new("d12", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1204_0650_0010")
        tlk:EndTalk()
      else
        local tlk = Tlk:new("d12", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d1204_0040_0010")
        local result = tlk:Select(2, "f_d1204_0040_0020")
        if result == RESULT_TALK00 then
          tlk:EndTalk()
          MapChange("t", 408, "start_20", true, FADE_BLACK, FADE_TIME)
        end
        tlk:EndTalk()
      end
    end
    if talk_id == 250 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0640_0010")
      Message("f_d1204_0640_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_00" then
      local tlk = Tlk:new("d12", 1, true)
      if Flg.Check("FLAG_MAIN_22_190") then
        tlk:StartTalk()
        tlk:Message("f_d1204_0060_0010")
        local result = tlk:Select(2, "f_d1204_0050_0020")
        if result == RESULT_TALK00 then
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
          WaitFrame(30)
          local gate = Obj:new(FLD_OBJ_GIMMICK, "gate")
          local pc = Obj:new(PLAYER, "")
          Cam.Inst:Set(4.893, 0.658, 13.167, 0.352, 1.561, 4.304, default, 0)
          pc:SetPos(0.667, 0.03, 5.173, true)
          pc:SetRotationY(160, 0)
          FadeAllInWithWait(FADE_BLACK, FADE_TIME)
          Field_SetEnvironmentSettings("es_d1101_gateIn")
          PlayEffectScript("ef_f_mov_140_ga", gate.pos.x, gate.pos.y - 1, gate.pos.z, gate.rot_y, 1)
          WaitFrame(15)
          gate:Invisible(15)
          WaitFrame(60)
          Qst.Main:Set(self.ID, self.STEP_003)
          MapChange("d", 902, "start_00", true, FADE_BLACK, FADE_TIME)
        end
      elseif Flg.Check("FLAG_MAIN_22_010") then
        tlk:StartTalk()
        tlk:Message("f_d1204_0060_0010")
        local result = tlk:Select(2, "f_d1204_0050_0020")
        if result == RESULT_TALK00 then
          tlk:EndTalk()
          Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
          WaitFrame(30)
          local gate = Obj:new(FLD_OBJ_GIMMICK, "gate")
          local pc = Obj:new(PLAYER, "")
          Cam.Inst:Set(4.893, 0.658, 13.167, 0.352, 1.561, 4.304, default, 0)
          pc:SetPos(0.667, 0.03, 5.173, true)
          pc:SetRotationY(160, 0)
          FadeAllInWithWait(FADE_BLACK, FADE_TIME)
          Field_SetEnvironmentSettings("es_d1101_gateIn")
          PlayEffectScript("ef_f_mov_140_ga", gate.pos.x, gate.pos.y - 1, gate.pos.z, gate.rot_y, 1)
          WaitFrame(15)
          gate:Invisible(15)
          WaitFrame(60)
          MapChange("d", 900, "start_00", true, FADE_BLACK, FADE_TIME)
        else
          M420:Event_020()
        end
      end
    end
    if npc_name == "npc_0027" then
      local tlk = Tlk:new("d12", 1, true)
      if Flg.Check("FLAG_MAIN_22_212") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        tlk:StartTalk()
        tlk:Message("f_d1204_0060_0010")
        local result = tlk:Select(2, "f_d1204_0050_0020")
        if result == RESULT_TALK00 then
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
          WaitFrame(30)
          local gate = Obj:new(FLD_OBJ_GIMMICK, "gate")
          local pc = Obj:new(PLAYER, "")
          Cam.Inst:Set(4.893, 0.658, 13.167, 0.352, 1.561, 4.304, default, 0)
          pc:SetPos(0.667, 0.03, 5.173, true)
          pc:SetRotationY(160, 0)
          FadeAllInWithWait(FADE_BLACK, FADE_TIME)
          Field_SetEnvironmentSettings("es_d1101_gateIn")
          PlayEffectScript("ef_f_mov_140_ga", gate.pos.x, gate.pos.y - 1, gate.pos.z, gate.rot_y, 1)
          WaitFrame(15)
          gate:Invisible(15)
          WaitFrame(60)
          MapChange("d", 903, "start_20", true, FADE_BLACK, FADE_TIME)
        elseif result == RESULT_TALK01 then
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif Flg.Check("FLAG_MAIN_22_182") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        tlk:StartTalk()
        tlk:Message("f_d1204_0060_0010")
        local result = tlk:Select(2, "f_d1204_0050_0020")
        if result == RESULT_TALK00 then
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
          WaitFrame(30)
          local gate = Obj:new(FLD_OBJ_GIMMICK, "gate")
          local pc = Obj:new(PLAYER, "")
          Cam.Inst:Set(4.893, 0.658, 13.167, 0.352, 1.561, 4.304, default, 0)
          pc:SetPos(0.667, 0.03, 5.173, true)
          pc:SetRotationY(160, 0)
          FadeAllInWithWait(FADE_BLACK, FADE_TIME)
          Field_SetEnvironmentSettings("es_d1101_gateIn")
          PlayEffectScript("ef_f_mov_140_ga", gate.pos.x, gate.pos.y - 1, gate.pos.z, gate.rot_y, 1)
          WaitFrame(15)
          gate:Invisible(15)
          WaitFrame(60)
          MapChange("d", 902, "start_00", true, FADE_BLACK, FADE_TIME)
        elseif result == RESULT_TALK01 then
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif Flg.Check("FLAG_MAIN_22_010") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        tlk:StartTalk()
        tlk:Message("f_d1204_0060_0010")
        local result = tlk:Select(2, "f_d1204_0050_0020")
        if result == RESULT_TALK00 then
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
          WaitFrame(30)
          local gate = Obj:new(FLD_OBJ_GIMMICK, "gate")
          local pc = Obj:new(PLAYER, "")
          Cam.Inst:Set(4.893, 0.658, 13.167, 0.352, 1.561, 4.304, default, 0)
          pc:SetPos(0.667, 0.03, 5.173, true)
          pc:SetRotationY(160, 0)
          FadeAllInWithWait(FADE_BLACK, FADE_TIME)
          Field_SetEnvironmentSettings("es_d1101_gateIn")
          PlayEffectScript("ef_f_mov_140_ga", gate.pos.x, gate.pos.y - 1, gate.pos.z, gate.rot_y, 1)
          WaitFrame(15)
          gate:Invisible(15)
          WaitFrame(60)
          MapChange("d", 900, "start_00", true, FADE_BLACK, FADE_TIME)
        elseif result == RESULT_TALK01 then
          tlk:EndTalk()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        M420:Event_020()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 206 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0480_0010")
      Message("f_d1204_0480_0020")
      Message("f_d1204_0480_0030")
      Message("f_d1204_0480_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 207 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0490_0010")
      Message("f_d1204_0490_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "sub055_001" then
      require("S070_055")
      S070_055:Event_010()
    end
    if npc_name == "sub056_001" then
      require("S070_056")
      S070_056:Event_010()
    end
    if npc_name == "sub056_002" then
      require("S070_056")
      S070_056:Event_020()
    end
    if npc_name == "sub056_004" then
      require("S070_056")
      S070_056:Event_030()
    end
    if npc_name == "sub057_001" then
      require("S070_057")
      S070_057:Event_010()
    end
    if npc_name == "sub070_167_001" then
      require("S070_167")
      S070_167:Event_030()
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD12(npc_name)
    end
    if talk_id == 209 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      if not Flg.Check("FLAG_MAIN_08_037") then
        Message("f_d1204_0730_0010")
        Message("f_d1204_0730_0020")
      else
        Message("f_d1206_0030_0010")
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 212 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0750_0010")
      Message("f_d1204_0750_0020")
      Message("f_d1204_0750_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 208 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1204_0760_0010")
      Message("f_d1204_0760_0020")
      Message("f_d1204_0760_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_warp01" then
      local npc01_index = GetIndex(NPC, npc_name)
      local pos = Field.ObjectGetPosition(NPC, npc01_index)
      local rot = Field.ObjectGetRotationY(NPC, npc01_index)
      local vector2d = Field.GetUnitVector2D(rot)
      local cam_x = pos.x + vector2d.x * 5
      local cam_y = pos.y
      local cam_z = pos.z + vector2d.z * 5
      Cam.Inst:Set(pos.x, pos.y + 2.4, pos.z, cam_x, cam_y + 2.2, cam_z, DEFAULT_ANGLE, 15)
      PlayerLookAtObject(NPC, npc_name)
      local tlk = Tlk:new("d01", 1, false)
      tlk:StartTalk()
      tlk:Message("f_d0107_0100_0010")
      local result = tlk:Select(2, "f_d0107_0100_0090")
      if result == RESULT_TALK00 then
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
        Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
        MapChange("d", 201, "start_30", false, FADE_WHITE, FADE_TIME)
      else
        tlk:Message("f_d0107_0100_0040")
        tlk:EndTalk()
        PlayerObjectResetAim()
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  elseif gMapNum == 1205 then
    if talk_id == 1 then
      local fldtxt = "d12"
      local e119 = Motion.Object:new(NPC, "npc_0001", "e119")
      local e120 = Motion.Object:new(NPC, "npc_0001", "e120")
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01")
      if Flg.Check("FLAG_MAIN_12_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e120:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1205_0350_0010")
        Message("f_d1205_0350_0020")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_10_070") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e120:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1205_0340_0010")
        Message("f_d1205_0340_0020")
        e119:Play(20, true)
        Message("f_d1205_0340_0030")
        Message("f_d1205_0340_0040")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_10_058") then
        M310:Event_020()
      elseif Flg.Check("FLAG_MAIN_09_090") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e120:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1205_0330_0010")
        Message("f_d1205_0330_0020")
        e119:Play(20, true)
        Message("f_d1205_0330_0030")
        Message("f_d1205_0330_0040")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e120:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1205_0270_0010")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "npc_0001_01" then
      local fldtxt = "d12"
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0001_01"), "F01_T01")
      Cam.Inst:Set(-1.901, 4.524, -11.471, 0.0894, 3.9977, -1.6854, default, 30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      WaitFrame(30)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0001_01"), "F01_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      Message("f_d1205_0260_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0001_01"), 30)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 2 then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_13_070") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0280_0010")
        Message("f_d1205_0290_0020")
        Message("f_d1205_0290_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_12_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0320_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_10_058") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0310_0010")
        Message("f_d1205_0310_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_09_075") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0300_0010")
        Message("f_d1205_0300_0020")
        Message("f_d1205_0300_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0020_0010")
        Message("f_d1205_0020_0020")
        Message("f_d1205_0020_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 3 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0030_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 13 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0130_0010")
      Message("f_d1205_0130_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 4 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0040_0010")
      Message("f_d1205_0040_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 5 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0050_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 6 then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_12_063") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0180_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0060_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 7 then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_12_063") then
        Cam.Inst:Set(13.078463, -1.786925, 4.86853, 8.153352, 1.61896, 12.878326, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0190_0010")
        Cam.Inst:Clear(30)
        Field_Talk_End_Not_LetterBox()
      else
        Cam.Inst:Set(13.078463, -1.786925, 4.86853, 8.153352, 1.61896, 12.878326, default, 30)
        WaitFrame(30)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0070_0010")
        Message("f_d1205_0070_0020")
        Cam.Inst:Clear(30)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 9 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0090_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 12 then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_12_063") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0200_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1205_0100_0010")
        Message("f_d1205_0100_0020")
        Message("f_d1205_0100_0030")
        Message("f_d1205_0100_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 11 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0110_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 15 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0150_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 16 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0160_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 19 then
      local fldtxt = "d12"
      local e002 = Motion.Object:new(NPC, "npc_0019", "e002")
      Field.ObjectLoadExpression(NPC, GetIndex(NPC, "npc_0019"), "F02_T01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0019"), "F02_T01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
      e002:Play(20, true)
      Message("f_d1205_0250_0010")
      Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0019"), 10)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 17 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0120_0010")
      Message("f_d1205_0120_0020")
      Message("f_d1205_0120_0030")
      Message("f_d1205_0120_0040")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0500" then
      M390:Event_020()
    end
    if talk_id == 501 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0170_0010")
      Message("f_d1205_0170_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 502 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1206_0030_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 503 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0240_0010")
      Message("f_d1205_0240_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 504 then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_18_015", "FLAG_MAIN_18_018") then
        M400:Event_020()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "npc_0504"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1205_0210_0010")
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "npc_0504"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 505 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0220_0010")
      Message("f_d1205_0220_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 506 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1206_0030_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 507 then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1205_0230_0010")
      Message("f_d1205_0230_0020")
      Message("f_d1205_0230_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 508 then
      local tlk = Tlk:new("m400", 1, false)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      tlk:StartTalk()
      tlk:Message("m400_010_120")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      tlk:EndTalk()
    end
  elseif gMapNum == 1206 then
    if npc_name == "simonzu_01" then
      local fldtxt = "d12"
      local e002 = Motion.Object:new(NPC, "simonzu_01", "e002")
      local e007 = Motion.Object:new(NPC, "simonzu_01", "e007")
      if Flg.Check("FLAG_MAIN_12_070", "FLAG_MAIN_12_130") then
        M330:Event_090()
      elseif Flg.Check("FLAG_MAIN_13_010", "FLAG_MAIN_13_020") then
        M340:Event_020()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        e002:Play(20, true)
        Field.ObjectChangeExpression(NPC, GetIndex(NPC, "simonzu_01"), "F01", EYES_BLINK_TYPE_BLINK, true, 30, AUTO_CANCEL_NONE, 15)
        Message("f_d1206_0010_0010")
        Message("f_d1206_0010_0020")
        if Flg.Check("FLAG_MAIN_08_037", "FLAG_MAIN_08_040") then
          e007:Play(20, true)
          Message("f_d1206_0010_0030")
        end
        Field.ObjectResetMotion(NPC, GetIndex(NPC, "simonzu_01"), 30)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "asuna_01" then
      local fldtxt = "d12"
      if Flg.Check("FLAG_MAIN_12_070", "FLAG_MAIN_12_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1206_0020_0010")
        Message("f_d1206_0020_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      elseif Flg.Check("FLAG_MAIN_13_010", "FLAG_MAIN_13_020") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1206_0020_0030")
        Message("f_d1206_0020_0040")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d1206_0020_0010")
        Message("f_d1206_0020_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "beelstae_01" then
      local fldtxt = "d12"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d1206_0050_0010")
      Message("f_d1206_0050_0020")
      Message("f_d1206_0050_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_End_Not_LetterBox()
    end
  end
end
