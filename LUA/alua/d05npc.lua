function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = "d05"
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  if gMapNum == 501 then
    gim_text = "field_text"
    if talk_id == 500 then
      local map_0001 = Obj:new(NPC, "map_0001")
      if Flg.Check("FLAG_MAIN_04_121") and Flg.Check("FLAG_MAIN_04_130") then
        if not Flg.Check("FLAG_MAIN_04_140") then
          local gim_text = "m150"
          local tlk = Tlk:new(gim_text, 1, true)
          tlk:StartTalk()
          Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "map_0001"), PLAYER, 1, 15)
          tlk:Message("m150_160_010")
          tlk:EndTalk()
          Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
          OpenWorldMap(DW, LOCOMON)
          Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        else
          local gim_text = "m150"
          local tlk = Tlk:new(gim_text, 1, true)
          tlk:StartTalk()
          Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, "map_0001"), PLAYER, 1, 15)
          tlk:Message("m150_160_010")
          tlk:EndTalk()
          Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
          OpenWorldMap(DW, LOCOMON)
          Field.ObjectResetAim(NPC, GetIndex(NPC, "map_0001"), 10)
          Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        end
      elseif Flg.Check("FLAG_MAIN_04_121") and not Flg.Check("FLAG_MAIN_04_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        map_0001:SetRotationYToPlayerAndAnimRun_Guardro(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0030_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
        map_0001:ClearRotationYToRun_Guardro(30)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        map_0001:SetRotationYToPlayerAndAnimRun_Guardro(30)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0020_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
        map_0001:ClearRotationYToRun_Guardro(30)
      end
    elseif talk_id == 503 then
      local solar_index = GetIndex(NPC, "chr728_help")
      Field.ObjectLoadMotion(NPC, solar_index, "bn01")
      Field.ObjectLoadMotion(NPC, solar_index, "bn02")
      Field.ObjectLoadMotion(NPC, solar_index, "bd03")
      Field.ObjectLoadMotion(NPC, solar_index, "br01")
      Field.ObjectLoadMotion(NPC, solar_index, "fe02")
      Field.ObjectLoadMotion(NPC, solar_index, "fe04")
      Field.ObjectLoadMotion(NPC, solar_index, "fq01")
      Field.ObjectLoadMotion(NPC, solar_index, "fq02")
      if Flg.Check("FLAG_MAIN_04_060") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, solar_index, 10)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fe02", 10, 10)
        Message("f_d0501_0090_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      elseif Flg.Check("FLAG_MAIN_04_020") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, solar_index, 10)
        Field_Talk_Start(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq02", 10, 10)
        Message("f_d0501_0090_0020")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        Field.ObjectResetAim(NPC, solar_index, 10)
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, solar_index, 10)
        Field_Talk_Start(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, solar_index, "fq02", 10, 10)
        Message("f_d0501_0090_0010")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    elseif talk_id == 504 then
      if Flg.Check("FLAG_MAIN_04_050") then
        M150:Event_080()
      elseif Flg.Check("FLAG_MAIN_04_041") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        Message("f_d0501_0050_0020")
        Message("f_d0501_0050_0030")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      elseif Flg.Check("FLAG_MAIN_04_020") then
        Flg.Set("FLAG_MAIN_04_041")
        M150:Event_080()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0050_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    elseif talk_id == 505 then
      if Flg.Check("FLAG_MAIN_04_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0100_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0100_0010")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    elseif talk_id == 603 then
      local npc_0900 = Obj:new(NPC, "npc_0900")
      local npc_0901 = Obj:new(NPC, "npc_0901")
      local npc_0902 = Obj:new(NPC, "npc_0902")
      local guardro_1 = GetIndex(NPC, "npc_0900")
      local guardro_2 = GetIndex(NPC, "npc_0901")
      local guardro_3 = GetIndex(NPC, "npc_0902")
      Field.ObjectLoadMotion(NPC, guardro_1, "bn01")
      Field.ObjectLoadMotion(NPC, guardro_1, "bn02")
      Field.ObjectLoadMotion(NPC, guardro_1, "fq01")
      Field.ObjectLoadMotion(NPC, guardro_1, "fq02")
      Field.ObjectLoadMotion(NPC, guardro_1, "fe02")
      Field.ObjectLoadMotion(NPC, guardro_1, "fe04")
      Field.ObjectLoadMotion(NPC, guardro_2, "bn01")
      Field.ObjectLoadMotion(NPC, guardro_2, "bn02")
      Field.ObjectLoadMotion(NPC, guardro_2, "fq01")
      Field.ObjectLoadMotion(NPC, guardro_2, "fq02")
      Field.ObjectLoadMotion(NPC, guardro_2, "fe02")
      Field.ObjectLoadMotion(NPC, guardro_2, "fe04")
      Field.ObjectLoadMotion(NPC, guardro_3, "bn01")
      Field.ObjectLoadMotion(NPC, guardro_3, "bn02")
      Field.ObjectLoadMotion(NPC, guardro_3, "fq01")
      Field.ObjectLoadMotion(NPC, guardro_3, "fq02")
      Field.ObjectLoadMotion(NPC, guardro_3, "fe02")
      Field.ObjectLoadMotion(NPC, guardro_3, "fe04")
      if Flg.Check("FLAG_MAIN_04_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, guardro_1, 10)
        Field.ObjectResetAim(NPC, guardro_2, 10)
        Field.ObjectResetAim(NPC, guardro_3, 10)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_1, "fq01", 10, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_2, "fq01", 10, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_3, "fq01", 10, 10)
        Message("f_d0501_0010_0110")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      elseif Flg.Check("FLAG_MAIN_04_020") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, guardro_1, 10)
        Field.ObjectResetAim(NPC, guardro_2, 10)
        Field.ObjectResetAim(NPC, guardro_3, 10)
        Field_Talk_Start(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_1, "fq01", 10, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_2, "fq01", 10, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_3, "fq01", 10, 10)
        Message("f_d0501_0010_0080")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_1, "fe04", 10, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_2, "fe04", 10, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, guardro_3, "fe04", 10, 10)
        Message("f_d0501_0010_0090")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        M150:Event_050()
      end
    end
    if talk_id == 605 then
      local tlk = Tlk:new("d0501")
      tlk:StartTalkActionAndZoom("npc_0018")
      tlk:Message("f_d0501_0120_0010")
      tlk:EndTalkActionAndZoom()
    end
    if talk_id == 100 then
      if Qst.Sub:Check(78, 1, 255) then
        require("S095_078")
        S095_078:Event_010()
      elseif Flg.Check("FLAG_MAIN_04_130") then
        Prcs_d0501_burinp_talkCam()
        WaitFrame(60)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0110_0030")
        Message("f_d0501_0110_0040")
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(60)
      else
        Prcs_d0501_burinp_talkCam()
        WaitFrame(60)
        Field_Talk_Start(npc_text, 1)
        Message("f_d0501_0110_0010")
        Message("f_d0501_0110_0020")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Cam.Inst:Clear(60)
      end
    end
    if talk_id == 101 then
      if Qst.Sub:Check(59, 5, 10) and not Flg.Check("FLAG_SUB_080_059_002") then
        require("S080_059")
        S080_059:Event_065(npc_name)
        if CheckItemNum(779, 1) then
          require("S080_059")
          S080_059:Event_070()
        end
      elseif Flg.Check("FLAG_MAIN_04_041", "FLAG_MAIN_04_050") then
        M150:Event_090()
      else
        local cam_npc = {
          52.38,
          -36.86,
          57.71,
          44.82,
          -34.83,
          63.93
        }
        local cam_shop = {
          51.44,
          -38.39,
          57.14,
          44.68,
          -34.46,
          63.37
        }
        CommonShopStart(npc_name, 140, "ba02", "bs01", "fq02", cam_npc, cam_shop)
      end
    end
    if talk_id == 102 then
      if Flg.Check("FLAG_MAIN_04_130") then
        WaitFrame(60)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0130_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Cam.Inst:Clear(60)
      else
        WaitFrame(60)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0130_0010")
        Message("f_d0501_0130_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Cam.Inst:Clear(60)
      end
    end
    if talk_id == 103 then
      local haguru_index = GetIndex(NPC, "haguru_103")
      Field.ObjectLoadMotion(NPC, haguru_index, "bn01")
      Field.ObjectLoadMotion(NPC, haguru_index, "fe04")
      Field.ObjectLoadMotion(NPC, haguru_index, "fe02")
      Field.ObjectLoadMotion(NPC, haguru_index, "fq01")
      Field.ObjectLoadMotion(NPC, haguru_index, "fq02")
      if Flg.Check("FLAG_GIMMICK_D05_040") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, haguru_index, "fe02", 10, 10)
        Message("f_d0501_0140_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, haguru_index, 10)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, haguru_index, "fq02", 10, 10)
        Message("f_d0501_0140_0010")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, haguru_index, "fe04", 10, 10)
        Message("f_d0501_0140_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 10 then
      local andro_1 = GetIndex(NPC, "npc_0010")
      local andro_2 = GetIndex(NPC, "npc_0011")
      Field.ObjectLoadMotion(NPC, andro_1, "bn01")
      Field.ObjectLoadMotion(NPC, andro_1, "bn02")
      Field.ObjectLoadMotion(NPC, andro_1, "fe02")
      Field.ObjectLoadMotion(NPC, andro_1, "fq01")
      Field.ObjectLoadMotion(NPC, andro_1, "fq02")
      Field.ObjectLoadMotion(NPC, andro_2, "bn01")
      Field.ObjectLoadMotion(NPC, andro_2, "bn02")
      Field.ObjectLoadMotion(NPC, andro_2, "fe02")
      Field.ObjectLoadMotion(NPC, andro_2, "fq01")
      Field.ObjectLoadMotion(NPC, andro_2, "fq02")
      if Flg.Check("FLAG_MAIN_04_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, andro_2, 10)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_2, "fq01", 10, 10)
        Message("f_d0501_0040_0040")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_2, "fq02", 10, 10)
        Message("f_d0501_0040_0050")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectResetAim(NPC, andro_1, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_1, "fq02", 10, 10)
        Message("f_d0501_0040_0010")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_1, "fe02", 10, 10)
        Message("f_d0501_0040_0020")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, andro_1, "fq02", 10, 10)
        Message("f_d0501_0040_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 12 then
      local tank_index = GetIndex(NPC, "npc_0012")
      Field.ObjectLoadMotion(NPC, tank_index, "bn01")
      Field.ObjectLoadMotion(NPC, tank_index, "bn02")
      Field.ObjectLoadMotion(NPC, tank_index, "fe02")
      Field.ObjectLoadMotion(NPC, tank_index, "fq01")
      Field.ObjectLoadMotion(NPC, tank_index, "fq02")
      if Flg.Check("FLAG_MAIN_04_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0060_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0060_0010")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, tank_index, "fe02", 10, 10)
        Message("f_d0501_0060_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectPlayMotion(NPC, tank_index, "bn02", 10, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 14 then
      local mekanori_index = GetIndex(NPC, "npc_0014")
      local mekanori_index_2 = GetIndex(NPC, "npc_0015")
      Field.ObjectLoadMotion(NPC, mekanori_index, "bn01")
      Field.ObjectLoadMotion(NPC, mekanori_index, "bn02")
      Field.ObjectLoadMotion(NPC, mekanori_index, "fq01")
      Field.ObjectLoadMotion(NPC, mekanori_index, "fq02")
      Field.ObjectLoadMotion(NPC, mekanori_index, "fe02")
      Field.ObjectLoadMotion(NPC, mekanori_index_2, "bn01")
      Field.ObjectLoadMotion(NPC, mekanori_index_2, "bn02")
      Field.ObjectLoadMotion(NPC, mekanori_index_2, "fq01")
      Field.ObjectLoadMotion(NPC, mekanori_index_2, "fq02")
      Field.ObjectLoadMotion(NPC, mekanori_index_2, "fe02")
      if Flg.Check("FLAG_MAIN_04_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field.ObjectResetAim(NPC, mekanori_index_2, 10)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, mekanori_index_2, "fq02", 10, 10)
        Message("f_d0501_0070_0030")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, mekanori_index_2, "fq01", 10, 10)
        Message("f_d0501_0070_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0070_0010")
        Message("f_d0501_0070_0020")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 16 then
      local clock_index = GetIndex(NPC, "npc_0016")
      Field.ObjectLoadMotion(NPC, clock_index, "bn01")
      Field.ObjectLoadMotion(NPC, clock_index, "bn02")
      Field.ObjectLoadMotion(NPC, clock_index, "fq01")
      Field.ObjectLoadMotion(NPC, clock_index, "fq02")
      Field.ObjectLoadMotion(NPC, clock_index, "fe02")
      Field.ObjectLoadMotion(NPC, clock_index, "fe04")
      if Flg.Check("FLAG_MAIN_04_130") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, clock_index, "fe04", 10, 10)
        Message("f_d0501_0080_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Field.ObjectResetAim(NPC, clock_index, 10)
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, clock_index, "fe04", 10, 10)
        Message("f_d0501_0080_0010")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, clock_index, "fq02", 10, 10)
        Message("f_d0501_0080_0020")
        Field.ObjectPlayMotionWithStartMoveMotion(NPC, clock_index, "fq01", 10, 10)
        Message("f_d0501_0080_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "kokuwa_a" then
      local kokuwa_a = GetIndex(NPC, "kokuwa_a")
      local player = Field.GetPlayerIndex()
      local kokuwa_a_pos = Field.ObjectGetPosition(NPC, kokuwa_a)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_kokuwa_a = GetAngleToTarget2D(kokuwa_a_pos.x, kokuwa_a_pos.z, player_pos.x, player_pos.z)
      if Flg.Check("FLAG_MAIN_04_093") then
        Field.ObjectSetRotationY(FLD_OBJ_NPC, kokuwa_a, y_kokuwa_a, 25)
        M150:Event_200()
      elseif Flg.Check("FLAG_GIMMICK_D05_030") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Message("f_d0501_0150_0050")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      elseif Flg.Check("FLAG_MAIN_04_070") then
        M150:Event_110()
      else
        Field.ObjectSetRotationY(FLD_OBJ_NPC, kokuwa_a, y_kokuwa_a, 25)
        M150:Event_110()
      end
    end
    if npc_name == "kokuwa_a_01" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0501_0150_0050")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 19 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0501_0170_0010")
      Message("f_d0501_0170_0020")
      Message("f_d0501_0170_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 20 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0501_0180_0010")
      Message("f_d0501_0180_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 21 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0501_0160_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 606 or talk_id == 607 then
      local npc_index01 = GetIndex(NPC, "kokuwa_a_02")
      local npc_index02 = GetIndex(NPC, "kokuwa_b_02")
      local kokuwa_a_bn01 = Motion.Object:new(NPC, "kokuwa_a_02", "bn01")
      local kokuwa_a_f005 = Motion.Object:new(NPC, "kokuwa_a_02", "f005")
      local kokuwa_a_fq01 = Motion.Object:new(NPC, "kokuwa_a_02", "fq01")
      local kokuwa_b_bn01 = Motion.Object:new(NPC, "kokuwa_b_02", "bn01")
      local kokuwa_b_fq01 = Motion.Object:new(NPC, "kokuwa_b_02", "fq01")
      local kokuwa_b_f005 = Motion.Object:new(NPC, "kokuwa_b_02", "f005")
      Cam.Inst:Set(-85.2, 0.025, -6.931, -78.14, 0.927, 0.09, default, 30)
      Obj:new(PLAYER, ""):Invisible(30)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      WaitFrame(30)
      kokuwa_a_fq01:Play(10, true)
      Message("f_d0501_0190_0010")
      kokuwa_a_bn01:Play(10, true)
      kokuwa_b_fq01:Play(10, true)
      Message("f_d0501_0190_0020")
      kokuwa_b_bn01:Play(10, true)
      Field.ObjectChangeExpression(NPC, npc_index01, "F02", EYES_BLINK_TYPE_BLINK, false, 30)
      Field.ObjectChangeExpression(NPC, npc_index02, "F02", EYES_BLINK_TYPE_BLINK, false, 30)
      kokuwa_a_f005:Play(10, true)
      kokuwa_b_f005:Play(10, true)
      Message("f_d0501_0190_0030")
      Field.ObjectClearExpression(NPC, npc_index01, 30)
      Field.ObjectClearExpression(NPC, npc_index02, 30)
      kokuwa_a_bn01:Play(10, true)
      kokuwa_b_bn01:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      Obj:new(PLAYER, ""):CancelInvisible(30)
      Cam.Inst:Clear(30)
    end
    if npc_name == "roko_01" then
      local fldtxt = "d02"
      Cam.Inst:Set(-91.67, 1.015, 8.903, -89.93, 3.187, 18.5, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0201_0630_0040")
      Message("f_d0201_0630_0050")
      Field_Talk_End_Not_LetterBox()
      Cam.Inst:Clear(30)
    end
    if talk_id == 608 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0280_0010")
      Message("f_d0501_0280_0020")
      Message("f_d0501_0280_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "card_001" and Flg.Check("FLAG_MAIN_04_121") and Flg.Check("FLAG_MAIN_04_130") then
      local fldtxt = "d05"
      local arumaji = GetIndex(NPC, "card_001")
      local arumaji01 = Obj:new(NPC, "card_001")
      local player = Field.GetPlayerIndex()
      local card_001_pos = Field.ObjectGetPosition(NPC, arumaji)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(card_001_pos.x, card_001_pos.z, player_pos.x, player_pos.z)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      arumaji01:SetRotationYToPlayerAndAnimRun(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0501_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1503, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0501_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0501_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0501_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
      arumaji01:ClearRotationYToRun(30)
    end
    if npc_name == "card_002" and Flg.Check("FLAG_MAIN_04_121") and Flg.Check("FLAG_MAIN_04_130") then
      local fldtxt = "d05"
      local metaru = GetIndex(NPC, "card_002")
      local metaru01 = Obj:new(NPC, "card_002")
      local player = Field.GetPlayerIndex()
      local card_002_pos = Field.ObjectGetPosition(NPC, metaru)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_degree = GetAngleToTarget2D(card_002_pos.x, card_002_pos.z, player_pos.x, player_pos.z)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field.ObjectSetRotationY(FLD_OBJ_NPC, metaru, y_degree, 30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_9010_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0501_9010_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1504, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0501_9010_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0501_9010_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0501_9010_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
      metaru01:ClearRotationY(30)
    end
    if talk_id == 650 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0300_0010")
      Message("f_d0501_0300_0020")
      Message("f_d0501_0300_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 651 then
      local fldtxt = "d05"
      local npc_0651 = Obj:new(NPC, "npc_0651")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0651:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0290_0010")
      Message("f_d0501_0290_0020")
      Message("f_d0501_0290_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0651:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 652 then
      local cam_npc = {
        -13.485,
        -21.063,
        66.344,
        -17.317,
        -18.838,
        75.309
      }
      local cam_shop = {
        -15.115,
        -20.995,
        65.386,
        -17.533,
        -18.997,
        74.881
      }
      CommonShopStart(npc_name, 142, "ba02", "bs01", "fq02", cam_npc, cam_shop)
    end
    if talk_id == 653 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0310_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 654 then
      local fldtxt = "d05"
      local npc_0654 = Obj:new(NPC, "npc_0654")
      npc_0654:SetRotationYToPlayerAndAnimRun_Guardro(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0320_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0654:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 655 then
      local fldtxt = "d05"
      local npc_0655 = Obj:new(NPC, "npc_0655")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0655:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0330_0010")
      Flg.Set("FLAG_GIMMICK_D05_030")
      FieldObjectSync(FOR_ALL, false)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0655:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 656 then
      local fldtxt = "d05"
      local npc_0656 = Obj:new(NPC, "npc_0656")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0656:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0340_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0656:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 657 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0350_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 658 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0350_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 659 then
      local fldtxt = "d05"
      local npc_0659 = Obj:new(NPC, "npc_0659")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_0659:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0501_0200_0010")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0501_0200_0020")
        result = tlk:Select(2, "f_d0501_0200_0030")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0501_0200_0040")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          tlk:EndTalk()
          MapChange("d", 505, "start_03", true, 0, 30)
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0501_0200_0050")
        result = tlk:Select(2, "f_d0501_0200_0060")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0501_0200_0040")
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          tlk:EndTalk()
          MapChange("d", 505, "start_03", true, 0, 30)
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0501_0200_0070")
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_0659:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 660 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      local tlk = Tlk:new("d05", 1, false, false)
      local npc_0660 = Obj:new(NPC, "npc_0660")
      npc_0660:SetRotationYToPlayerAndAnimRun_Guardro(30)
      tlk:StartTalk()
      tlk:Message("f_d0501_0260_0010")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0501_0260_0020")
        result = tlk:Select(2, "f_d0501_0260_0030")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0501_0260_0040")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0501_0260_0050")
        result = tlk:Select(2, "f_d0501_0260_0060")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0501_0260_0040")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0501_0260_0070")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(-92.791, 2.164, 8.77, -89.457, 2.7066, 18.185, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0501_0260_0080")
        Message("f_d0501_0260_0090")
        Message("f_d0501_0260_0100")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_0660:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 661 then
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0400_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 662 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_0662", "bn01")
      local fq01 = Motion.Object:new(NPC, "npc_0662", "fq01")
      local fq02 = Motion.Object:new(NPC, "npc_0662", "fq02")
      if Flg.Check("FLAG_MAIN_11_045", "FLAG_MAIN_11_086") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0501_0270_0020")
        fq01:Play(20, true)
        Message("f_d0501_0270_0030")
        bn01:Play(20, true)
        Flg.Set("FLAG_MAIN_11_086")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
        BackFade_OutNoLoadingWithWait(FADE_BLACK, 10)
        WaitFrame(20)
        Obj:new(NPC, "npc_0662"):Invisible(30, true)
        FieldObjectSync(FOR_ALL, false)
        BackFadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
        M320:Event_019()
      elseif Flg.Check("FLAG_MAIN_11_086") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0501_0270_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        fq02:Play(20, true)
        Message("f_d0501_0270_0010")
        bn01:Play(20, true)
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 671 then
      local fldtxt = "d05"
      local npc_0671 = Obj:new(NPC, "npc_0671")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0420_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "s095_077_001" then
      local npc = Obj:new(NPC, npc_name)
      require("S095_077")
      S095_077:Event_010()
      Field.ObjectResetAim(NPC, GetIndex(NPC, npc_name), 10)
    end
    if npc_name == "s095_077_002" then
      local npc = Obj:new(NPC, npc_name)
      npc:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, npc_name), PLAYER, 1, 15)
      require("S095_077")
      S095_077:Event_050()
      Field.ObjectResetAim(NPC, GetIndex(NPC, npc_name), 10)
      npc:ClearRotationYToRun_Guardro(30)
    end
    if npc_name == "s095_077_mirai" then
      local npc = Obj:new(NPC, npc_name)
      npc:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field.ObjectLookAtTheObject(NPC, GetIndex(NPC, npc_name), PLAYER, 1, 15)
      require("S095_077")
      S095_077:Event_060()
      Field.ObjectResetAim(NPC, GetIndex(NPC, npc_name), 10)
      npc:ClearRotationYToRun_Guardro(30)
    end
    if npc_name == "npc_0700" then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0370_0010")
      Message("f_d0501_0370_0020")
      Message("f_d0501_0370_0030")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "npc_0701" then
      local fldtxt = "d05"
      if Flg.Check("FLAG_MAIN_11_000") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0501_0380_0010")
        Message("f_d0501_0380_0020")
        Message("f_d0501_0380_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0501_0380_0010")
        Message("f_d0501_0380_0020")
        Message("f_d0501_0380_0030")
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End_Not_LetterBox()
      end
    end
    if npc_name == "s080_059_004" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      require("S080_059")
      S080_059:Event_050()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "s095_078_001" then
      require("S095_078")
      S095_078:Event_020()
    end
    if npc_name == "s095_078_kapuri" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      require("S095_078")
      S095_078:Event_040()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "s110_099_001" then
      require("S110_099")
      S110_099:Event_020()
    end
    if npc_name == "s110_101_002" then
      require("S110_101")
      S110_101:Event_050()
    end
    if npc_name == "s110_101_002" then
      require("S110_101")
      S110_101:Event_010()
    end
    if npc_name == "s110_101_003" then
      require("S110_101")
      S110_101:Event_045()
    end
    if npc_name == "s070_167_minerva_01" then
      require("S070_167")
      S070_167:Event_030()
    end
    if npc_name == "s110_102_001" then
      require("S110_102")
      S110_102:Event_050()
    end
    if npc_name == "s110_102_002" then
      require("S110_102")
      S110_102:Event_030()
    end
    if npc_name == "npc_warp01" then
      D05_WarpNPC_Before(npc_name)
    end
    if npc_name == "npc_warp02" or npc_name == "npc_warp03" then
      D05_WarpNPC_After(npc_name)
    end
    if npc_name == "developshop_001" then
      local cam_npc = {
        -66.881,
        -9.845,
        59.551,
        -74.917,
        -9.137,
        65.461
      }
      local cam_shop = {
        -68.098,
        -9.647,
        57.457,
        -74.792,
        -8.773,
        64.834
      }
      DevelopShopStart(npc_name, 152, "fe04", "fq01", "fq01", cam_npc, cam_shop, nil, "fe02")
      if 1 <= Item.GetNum(904) and not Qst.Sub:Check(152, 6) then
        Qst.Sub:Set(152, 6)
      end
    end
  elseif gMapNum == 502 then
    if talk_id == 805 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message("f_d0502_0100_0020")
      Field_Talk_End()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 815 then
      if Flg.Check("FLAG_MAIN_04_085") then
        M150:Event_170()
      elseif Flg.Check("FLAG_MAIN_04_074") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        Message("f_d0502_0110_0020")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        M150:Event_170()
      end
    end
    if talk_id == 818 then
      M150:Event_168()
    end
    if talk_id == 824 then
      M150:Event_180CA()
    end
    if talk_id == 825 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0502_0150_0160")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      M150:Event_180CB()
      Field_InvisibleFollowerAllPartyMember(0, 0, false)
      Field_InvisibleFollowerAllGuest(0, 0, false)
    end
    if talk_id == 827 then
      Field_Talk_Start(npc_text, 1)
      Message("f_d0502_0140_0040")
      Field_Talk_End()
    end
    if talk_id == 828 then
      if Flg.Check("FLAG_FIELD_D502_010") then
        local cam_npc = {
          53.12,
          -16.26,
          -42.88,
          43.2,
          -14.98,
          -42.78
        }
        local cam_shop = {
          53.75,
          -16.56,
          -45.02,
          44.25,
          -15.12,
          -42.37
        }
        CommonShopStart(npc_name, 141, "ba02", "fq01", "fe01", cam_npc, cam_shop)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_Talk_Start_Not_LetterBox(npc_text, 1)
        Flg.Set("FLAG_FIELD_D502_010")
        Message("f_d0502_0180_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        Field_InvisibleFollowerAllPartyMember(0, 10, false)
        Field_InvisibleFollowerAllGuest(0, 10, false)
        local cam_npc = {
          53.12,
          -16.26,
          -42.88,
          43.2,
          -14.98,
          -42.78
        }
        local cam_shop = {
          53.75,
          -16.56,
          -45.02,
          44.25,
          -15.12,
          -42.37
        }
        CommonShopStart(npc_name, 141, "ba02", "fq01", "fe01", cam_npc, cam_shop)
      end
    end
    if talk_id == 600 then
      local fldtxt = "d05"
      local npc_600 = Obj:new(NPC, "npc_600")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_600:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0210_0010")
      Message("f_d0502_0210_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_600:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 601 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_601", "bn01")
      local fq01 = Motion.Object:new(NPC, "npc_601", "fq01")
      local npc_0601 = Obj:new(NPC, "npc_0601")
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      bn01:Play(10, true)
      Message("f_d0502_0220_0010")
      Field.StartPlayerAndNpcTalkAction(npc_name)
      Message("f_d0502_0220_0020")
      fq01:Play(10, true)
      Message("f_d0502_0220_0030")
      bn01:Play(10, true)
      if Flg.Check("FLAG_FIELD_D502_020") then
        MessageClose()
        WaitFrame(30)
        Message("f_d0502_0220_0040")
        MessageClose()
        WaitFrame(60)
        Message("f_d0502_0220_0050")
      end
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 602 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_602", "bn01")
      local fe04 = Motion.Object:new(NPC, "npc_602", "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0230_0010")
      bn01:Play(10, true)
      Field.StartPlayerAndNpcTalkAction(npc_name)
      Message("f_d0502_0230_0020")
      Message("f_d0502_0230_0030")
      fe04:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 603 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_603", "bn01")
      local fe04 = Motion.Object:new(NPC, "npc_603", "fe04")
      local ba02 = Motion.Object:new(NPC, "npc_603", "ba02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0240_0010")
      bn01:Play(10, true)
      Message("f_d0502_0240_0020")
      ba02:Play(10, true)
      Message("f_d0502_0240_0030")
      fe04:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 604 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_604", "bn01")
      local e009 = Motion.Object:new(NPC, "npc_604", "e009")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      bn01:Play(10, true)
      Message("f_d0502_0250_0010")
      Message("f_d0502_0250_0020")
      Message("f_d0502_0250_0030")
      Message("f_d0502_0250_0040")
      e009:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 605 then
      local bn01 = Motion.Object:new(NPC, "npc_606", "bn01")
      local fe04 = Motion.Object:new(NPC, "npc_606", "fe04")
      local fldtxt = "d05"
      Cam.Inst:Set(22.672171, -19.292864, -78.580154, 13.925001, -14.545117, -77.607567, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0260_0010")
      Message("f_d0502_0260_0020")
      bn01:Play(10, true)
      Field.StartPlayerAndNpcTalkAction("npc_606")
      Message("f_d0502_0260_0030")
      Message("f_d0502_0260_0040")
      fe04:Play(10, true)
      Field.EndPlayerAndNpcTalkAction("npc_606")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if talk_id == 607 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_607", "bn01")
      local fq02 = Motion.Object:new(NPC, "npc_607", "fq02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      bn01:Play(10, true)
      Message("f_d0502_0270_0010")
      Message("f_d0502_0270_0020")
      Field.EndPlayerAndNpcTalkAction(npc_name)
      Message("f_d0502_0270_0030")
      fq02:Play(10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 608 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_608", "bn01")
      local fq02 = Motion.Object:new(NPC, "npc_608", "fq02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0280_0010")
      fq02:Play(10, true)
      Message("f_d0502_0280_0020")
      bn01:Play(10, true)
      Message("f_d0502_0280_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 610 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0290_0010")
      Message("f_d0502_0290_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 611 then
      local fldtxt = "d05"
      local bn01 = Motion.Object:new(NPC, "npc_611", "bn01")
      local fq01 = Motion.Object:new(NPC, "npc_611", "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Set(30.438969, -12.835659, 17.402563, 32.610348, -9.159554, 8.359808, default, 30)
      WaitFrame(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0340_0010")
      Message("f_d0502_0340_0020")
      Cam.Inst:Set(11.933138, -23.121004, 15.56265, 19.226669, -17.231264, 12.081935, default, 30)
      WaitFrame(30)
      Message("f_d0502_0340_0030")
      Cam.Inst:Set(30.438969, -12.835659, 17.402563, 32.610348, -9.159554, 8.359808, default, 30)
      WaitFrame(30)
      Message("f_d0502_0340_0040")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 650 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0300_0010")
      Message("f_d0502_0300_0020")
      Message("f_d0502_0300_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 651 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0320_0010")
      Message("f_d0502_0320_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 652 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0310_0010")
      Message("f_d0502_0310_0020")
      Message("f_d0502_0310_0030")
      Message("f_d0502_0310_0040")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 653 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0330_0010")
      Message("f_d0502_0330_0020")
      Message("f_d0502_0330_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 850 then
      local fldtxt = "d05"
      local npc_850 = Obj:new(NPC, "npc_850")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_850:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0502_0360_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0502_0360_0050")
        result = tlk:Select(2, "f_d0502_0360_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0502_0360_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0502_0360_0080")
        result = tlk:Select(2, "f_d0502_0360_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0502_0360_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0502_0360_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(40.12, 1.787, 66.77, 30.29, 0.958, 68.36, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0502_0360_0010")
        Message("f_d0502_0360_0020")
        Message("f_d0502_0360_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_850:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 851 then
      local fldtxt = "d05"
      local npc_851 = Obj:new(NPC, "npc_851")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_851:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0502_0190_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0502_0190_0050")
        result = tlk:Select(2, "f_d0502_0190_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0502_0190_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0502_0190_0080")
        result = tlk:Select(2, "f_d0502_0190_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0502_0190_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0502_0190_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Prcs_d0502_MoveCranePark_01()
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        tlk:Message("f_d0502_0190_0110")
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_851:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 852 then
      local fldtxt = "d05"
      local npc_852 = Obj:new(NPC, "npc_852")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_852:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0502_0370_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0502_0360_0050")
        result = tlk:Select(2, "f_d0502_0370_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0502_0370_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0502_0370_0080")
        result = tlk:Select(2, "f_d0502_0370_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0502_0370_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0502_0370_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(92.45, -3.698, 78.18, 83.22, -1.32, 81.23, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0502_0370_0010")
        Message("f_d0502_0370_0020")
        Message("f_d0502_0370_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_852:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 853 then
      local fldtxt = "d05"
      local npc_853 = Obj:new(NPC, "npc_853")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_853:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0502_0380_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0502_0380_0050")
        result = tlk:Select(2, "f_d0502_0380_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0502_0380_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0502_0380_0080")
        result = tlk:Select(2, "f_d0502_0380_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0502_0380_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0502_0380_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(57.69, -7.415, -8.485, 67.34, -4.911, -9.193, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0502_0380_0010")
        Message("f_d0502_0380_0020")
        Message("f_d0502_0380_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_853:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 854 then
      local fldtxt = "d05"
      local npc_854 = Obj:new(NPC, "npc_854")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_854:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0160_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_854:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 855 then
      local fldtxt = "d05"
      local npc_855 = Obj:new(NPC, "npc_855")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_855:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0502_0200_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0502_0200_0050")
        result = tlk:Select(2, "f_d0502_0200_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0502_0200_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0502_0200_0080")
        result = tlk:Select(2, "f_d0502_0200_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0502_0200_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0502_0200_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Prcs_d0502_MoveCranePark_02()
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        tlk:Message("f_d0502_0200_0110")
        tlk:Message("f_d0502_0200_0120")
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_855:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 856 then
      local fldtxt = "d05"
      local npc_856 = Obj:new(NPC, "npc_856")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_856:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0190_0010")
      MessageClose()
      MessageTalkSel(2, "f_d0502_0190_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local ticket = Prcs_d05_TicketCheck_GuideNPC()
        if ticket == 1 then
          Message("f_d0502_0190_0030")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        elseif ticket == 2 then
          Message("f_d0502_0190_0030")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        else
          Message("f_d0502_0200_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        end
      elseif result == RESULT_TALK01 then
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      end
      npc_856:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 857 then
      local fldtxt = "d05"
      local npc_857 = Obj:new(NPC, "npc_857")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_857:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0502_0390_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0502_0390_0050")
        result = tlk:Select(2, "f_d0502_0390_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0502_0390_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0502_0390_0080")
        result = tlk:Select(2, "f_d0502_0390_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0502_0390_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0502_0390_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(-9.687, -16.83, 10, -10.82, -18.9, 0.287, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0502_0390_0010")
        Message("f_d0502_0390_0020")
        Message("f_d0502_0390_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_857:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 858 then
      local fldtxt = "d05"
      local npc_858 = Obj:new(NPC, "npc_858")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_858:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0502_0400_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0502_0400_0050")
        result = tlk:Select(2, "f_d0502_0400_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0502_0400_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0502_0400_0080")
        result = tlk:Select(2, "f_d0502_0400_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0502_0400_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0502_0400_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(-69.46, -17.84, -42.36, -59.9, -18.83, -45.12, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0502_0400_0010")
        Message("f_d0502_0400_0020")
        Message("f_d0502_0400_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_858:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 859 then
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0400_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 860 then
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0400_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 861 then
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0400_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 862 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_0350_0010")
      Message("f_d0502_0350_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "card_001" then
      local fldtxt = "d05"
      local card_001 = Obj:new(NPC, "card_001")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      card_001:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0502_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0502_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1501, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0502_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0502_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0502_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
      card_001:ClearRotationYToRun_Guardro(30)
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_BeforeD05(npc_name)
    end
  elseif gMapNum == 503 then
    if talk_id == 400 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message(400100)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End()
    elseif talk_id == 301 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message(401100)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End()
    elseif talk_id == 303 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      Message(403100)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End()
    elseif talk_id == 604 then
      if not Flg.Check("FLAG_GIMMICK_D05_220") then
        if not Flg.Check("FLAG_GIMMICK_D05_240") then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start(npc_text, 1)
          Message(40401010)
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_End()
          Prcs_d0503_OpenSteamEngineDoor_01()
          FadeOutWithWait(0, 15)
          Field_InvisibleFollowerAllGuest(0, 0, false)
          Field_InvisibleFollowerAllPartyMember(0, 0, false)
          Cam.Inst:Set(-61.1, -1.1, -30.4, -56.7, 4.2, -23.2, default, 0)
          SetControlScriptExternalVariable("pos_adjust_state", "cut1")
          WaitFrame(20)
          FadeInWithWait(0, 15)
          Field_Talk_Start(npc_text, 1)
          Message(40503010)
          Quake_Start(0.2, 0, 40)
          WaitFrame(5)
          PlaySE(405002, 100)
          WaitFrame(60)
          StopSE(slot_num, 35)
          Obj:new(NPC, "chr005_enemy"):CancelInvisible()
          Obj:new(NPC, "chr373_enemy"):CancelInvisible()
          ColOn("wall_cl_0005")
          Obj:new(FLD_OBJ_LOCATOR, "obj_0005"):CancelInvisible()
          Message(40503020)
          Field_Talk_End()
          Field_CancelInvisibleFollowerAllGuest(0, 0, false, false)
          Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
          SetControlScriptExternalVariable("repairman_state", "move1")
          SetFollowerCameraOperateRotation(20, 320)
          SetControlScriptExternalVariable("miner02_state", "attacked")
          SetControlScriptExternalVariable("miner03_state", "attacked")
          Cam.Inst:Clear(30)
          Flg.Set("FLAG_GIMMICK_D05_240")
        end
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
      end
    elseif talk_id == 305 then
      if not Flg.Check("FLAG_GIMMICK_D05_270") then
        if not Flg.Check("FLAG_GIMMICK_D05_220") then
          if not Flg.Check("FLAG_GIMMICK_D05_250") then
            START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
            Field_Talk_Start(npc_text, 1)
            Message(40501010)
            Message(40501020)
            END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
            Field_Talk_End()
            Field.SetEnableGimmickCheck("gim_0006", true)
            Flg.Set("FLAG_GIMMICK_D05_250")
          else
            START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
            Field_Talk_Start(npc_text, 1)
            END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
            Field_Talk_End()
          end
        else
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start(npc_text, 1)
          Message(40504010)
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_End()
        end
      elseif not Flg.Check("FLAG_GIMMICK_D05_200") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        Message(40504020)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        SetControlScriptExternalVariable("repairman_state", "move2")
        Flg.Set("FLAG_GIMMICK_D05_200")
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(npc_text, 1)
        Message(40504031)
        local index = GetIndex(FLD_OBJ_LOCATOR, "gim_0005")
        Field.ObjectEndEffectScript(FLD_OBJ_LOCATOR, index, 1)
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Prcs_d0503_OpenSteamEngineDoor_02()
        SetControlScriptExternalVariable("miner01_state", "move_to_rest")
        SetControlScriptExternalVariable("miner02_state", "move_to_rest")
        SetControlScriptExternalVariable("miner03_state", "move_to_rest")
        SetNpcTalkZoomCamera(npc_name, 0.5, 2, 0, 1)
        Field_Talk_Start(npc_text, 1)
        Message(40504034)
        FadeOutWithWait(0, 20)
        Obj:new(NPC, "chr010_repairman"):Invisible()
        SetEnableGimmickCheck("gim_0005", false)
        FadeInWithWait(0, 20)
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_End()
        SetControlScriptExternalVariable("repairman_state", "move3")
      end
    elseif talk_id == 605 then
      if Flg.Check("FLAG_GIMMICK_D05_220") then
        if not Flg.Check("FLAG_GIMMICK_D05_440") then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start(npc_text, 1)
          Message(40506010)
          Flg.Set("FLAG_GIMMICK_D05_440")
          if Flg.Check("FLAG_GIMMICK_D05_400") and Flg.Check("FLAG_GIMMICK_D05_420") and Flg.Check("FLAG_GIMMICK_D05_440") then
            Message(40507030)
          end
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_End()
          SetControlScriptExternalVariable("miner01_state", "move1")
        elseif Flg.Check("FLAG_GIMMICK_D05_400") and Flg.Check("FLAG_GIMMICK_D05_420") and Flg.Check("FLAG_GIMMICK_D05_440") then
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          if Flg.Check("FLAG_GIMMICK_D05_270") then
            if not Flg.Check("FLAG_GIMMICK_D05_230") then
              Message(40505050)
            else
              Message(40505060)
            end
          end
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_End()
        else
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          Message(40506030)
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_End()
        end
      else
      end
    elseif talk_id == 606 then
      if Flg.Check("FLAG_GIMMICK_D05_220") then
        if not Flg.Check("FLAG_GIMMICK_D05_400") then
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          Message(40505010)
          MessageTalkSel(2, 406100)
          local result = Talk.GetResultSelectedNum()
          if result == RESULT_TALK00 then
            END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
            Field_Talk_End()
            EncountFromField(30503297, 10572, false)
          elseif result == RESULT_TALK01 then
            END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
            Field_Talk_End()
          end
        elseif Flg.Check("FLAG_GIMMICK_D05_400") and Flg.Check("FLAG_GIMMICK_D05_420") and Flg.Check("FLAG_GIMMICK_D05_440") then
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          if Flg.Check("FLAG_GIMMICK_D05_270") then
            if not Flg.Check("FLAG_GIMMICK_D05_230") then
              Message(40505050)
            else
              Message(40505060)
            end
          end
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_End()
        else
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          Message(40505030)
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_End()
        end
      else
      end
    elseif talk_id == 608 then
      if Flg.Check("FLAG_GIMMICK_D05_220") then
        if not Flg.Check("FLAG_GIMMICK_D05_420") then
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          Message(40507010)
          MessageTalkSel(2, 406100)
          local result = Talk.GetResultSelectedNum()
          if result == RESULT_TALK00 then
            END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
            Field_Talk_End()
            EncountFromField(30503298, 10572, false)
          elseif result == RESULT_TALK01 then
            END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
            Field_Talk_End()
          end
        elseif Flg.Check("FLAG_GIMMICK_D05_400") and Flg.Check("FLAG_GIMMICK_D05_420") and Flg.Check("FLAG_GIMMICK_D05_440") then
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          if Flg.Check("FLAG_GIMMICK_D05_270") then
            if not Flg.Check("FLAG_GIMMICK_D05_230") then
              Message(40505050)
            else
              Message(40505060)
            end
          end
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_End()
        else
          START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_Start(npc_text, 1)
          Message(40507040)
          END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
          Field_Talk_End()
        end
      else
      end
    elseif talk_id == 504 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start(npc_text, 1)
      if not Flg.Check("FLAG_GIMMICK_D05_470") then
        Message(50401010)
        Message(50401020)
      else
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End()
    elseif talk_id == 600 then
      require("s104")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      if not Quest.CheckFlag(104, 0) then
      else
      end
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  elseif gMapNum == 504 then
  elseif gMapNum == 505 then
    if npc_name == "vulcanus" then
      require("S095_082")
      local fldtxt = "d05"
      if Flg.Check("FLAG_MAIN_04_140") then
        if Qst.Sub:Check(82, 1, 5) then
          S095_082:Event_010()
        else
          if not Flg.Check("FLAG_MAIN_05_015") then
            Flg.Set("FLAG_MAIN_05_015")
            local bn01 = Motion.Object:new(NPC, npc_name, "bn01")
            local fn01_01 = Motion.Object:new(NPC, npc_name, "fn01_01")
            local e002 = Motion.Object:new(NPC, npc_name, "e002")
            local fq01 = Motion.Object:new(NPC, npc_name, "fq01")
            local fq02 = Motion.Object:new(NPC, npc_name, "fq02")
            local tlk = Tlk:new("s095_082")
            Cam.Inst:Set(-0.188, 8.387, -17.826, -0.1317, 7.899, -7.838, default, 30)
            tlk:StartTalk()
            bn01:Play(10, true)
            tlk:Message("s095_082_010")
            fq01:PlayWithStartMoveMotion(10, 10)
            tlk:Message("s095_082_020")
            tlk:Message("s095_082_030")
            tlk:EndTalk()
            Cam.Inst:Clear(60)
          end
          local cam_npc = {
            -0.188,
            8.387,
            -17.826,
            -0.1317,
            7.899,
            -7.838
          }
          local cam_shop = {
            -3.223,
            8.587,
            -16.975,
            -1.256,
            8.444,
            -7.1718
          }
          DevelopShopStart("vulcanus", 152, "fe04", "fq01", "fq01", cam_npc, cam_shop, nil, "fe02")
          Motion.NPC:Play("vulcanus", "e100", 10, true)
          if 1 <= Item.GetNum(904) and not Qst.Sub:Check(152, 6) then
            Qst.Sub:Set(152, 6)
          end
        end
      elseif Flg.Check("FLAG_MAIN_04_123") and not Flg.Check("FLAG_MAIN_04_140") then
        Cam.Inst:Set(-0.188, 8.387, -17.826, -0.1317, 7.899, -7.838, default, 30)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0505_0080_0010")
        Message("f_d0505_0080_0020")
        Motion.NPC:Play("vulcanus", "fe04", 10, false)
        Message("f_d0505_0080_0030")
        Motion.NPC:Play("vulcanus", "e100", 10, true)
        Field_Talk_End_Not_LetterBox()
        Cam.Inst:Clear(30)
      end
    end
    if talk_id == 12 then
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0400_0010")
      Field_Talk_End_Not_LetterBox()
    elseif talk_id == 13 then
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0501_0400_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 15 then
      local fldtxt = "d05"
      local npc_015 = Obj:new(NPC, "npc_015")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_015:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0505_0040_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0505_0040_0050")
        result = tlk:Select(2, "f_d0505_0040_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0505_0040_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0505_0040_0080")
        result = tlk:Select(2, "f_d0505_0040_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0505_0040_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0505_0040_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(-2.722, 7.22, -17.57, 2.98, 8.98, -9.55, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0505_0040_0010")
        Message("f_d0505_0040_0020")
        Message("f_d0505_0040_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_015:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 16 then
      local fldtxt = "d05"
      local npc_016 = Obj:new(NPC, "npc_016")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_016:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0505_0060_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0505_0060_0050")
        result = tlk:Select(2, "f_d0505_0060_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0505_0060_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0505_0060_0080")
        result = tlk:Select(2, "f_d0505_0060_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0505_0060_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0505_0060_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(2.16, 2.74, 3.96, 11.41, 1.89, 0.27, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0505_0060_0010")
        Message("f_d0505_0060_0020")
        Message("f_d0505_0060_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_016:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 17 then
      local fldtxt = "d05"
      local npc_017 = Obj:new(NPC, "npc_017")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_017:SetRotationYToPlayerAndAnimRun_Guardro(30)
      local tlk = Tlk:new("d05", 1, false, false)
      tlk:StartTalk()
      tlk:Message("f_d0505_0050_0040")
      tlk:MessageClose()
      local ticket = Prcs_d05_TicketCheck_GuideNPC()
      local result = 0
      if ticket == 1 then
        tlk:Message("f_d0505_0050_0050")
        result = tlk:Select(2, "f_d0505_0050_0060")
        if result == RESULT_TALK00 then
          tlk:Message("f_d0505_0050_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      elseif ticket == 2 then
        tlk:Message("f_d0505_0050_0080")
        result = tlk:Select(2, "f_d0505_0050_0090")
        if result == RESULT_TALK00 then
          INFO_RELEASE_ITEM(732, 1)
          tlk:Message("f_d0505_0050_0070")
          tlk:MessageClose()
        elseif result == RESULT_TALK01 then
        end
      else
        tlk:Message("f_d0505_0050_0100")
      end
      if (ticket == 1 or ticket == 2) and result == RESULT_TALK00 then
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
        Cam.Inst:Set(-12.06, 6.87, -8.85, -14.16, 1.94, -0.41, default, 0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        Message("f_d0505_0050_0010")
        Message("f_d0505_0050_0020")
        Message("f_d0505_0050_0030")
        tlk:MessageClose()
        WaitFrame(15)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
        Cam.Inst:Clear(0)
        FadeAllInWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(15)
      end
      tlk:EndTalk()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      npc_017:ClearRotationYToRun_Guardro(30)
    end
    if talk_id == 18 then
      local fldtxt = "d05"
      local npc_018 = Obj:new(NPC, "npc_018")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_018:SetRotationYToPlayerAndAnimRun_Guardro(30)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0505_0070_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      npc_018:ClearRotationYToRun_Guardro(30)
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD05(npc_name)
    end
    if npc_name == "npc_warp01" then
      D05_WarpNPC_Before(npc_name)
    end
  elseif gMapNum == 506 then
    if talk_id == 300 then
      local fldtxt = "d05"
      if Flg.Check("FLAG_MAIN_12_053") then
        OpenArena(1, "npc_0001", "fe02", "fe04")
      elseif Flg.Check("FLAG_MAIN_12_015", "FLAG_MAIN_12_020") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0506_0160_0010")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_12_026", "FLAG_MAIN_12_027") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0506_0160_0020")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_12_029", "FLAG_MAIN_12_030") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0506_0160_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      elseif Flg.Check("FLAG_MAIN_12_032", "FLAG_MAIN_12_035") then
        START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0506_0160_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      else
        M320:Event_020()
      end
    end
    if talk_id == 303 then
      local fldtxt = "d05"
      Cam.Inst:Set(5.74, 1.07, 104.94, 5.47, 2.64, 114.81, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0040_0010")
      Message("f_d0506_0040_0020")
      Message("f_d0506_0040_0030")
      Message("f_d0506_0040_0040")
      Message("f_d0506_0040_0050")
      Message("f_d0506_0040_0060")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if npc_name == "npc_knight" then
      local knight_bn01 = Motion.Object:new(NPC, npc_name, "bn01")
      local knight_fe02 = Motion.Object:new(NPC, npc_name, "fe02")
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      knight_fe02:PlayWithStartMoveMotion(15, 15)
      Message("f_d0506_0230_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_knight_02" then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0230_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 304 then
      local grade_bn01 = Motion.Object:new(NPC, npc_name, "bn01")
      local grade_fe02 = Motion.Object:new(NPC, npc_name, "fe02")
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      grade_fe02:PlayWithStartMoveMotion(15, 15)
      Message("f_d0506_0240_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 305 then
      local fldtxt = "d05"
      Cam.Inst:Set(9.193, 4.53, 93.94, 6.63, 1.632, 103.17, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0060_0010")
      Message("f_d0506_0060_0020")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 306 then
      local fldtxt = "d05"
      Cam.Inst:Set(-8.72, 0.57, 105.52, -3.08, 1.99, 113.65, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0070_0010")
      Message("f_d0506_0070_0020")
      Message("f_d0506_0070_0030")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 308 then
      local fldtxt = "d05"
      if Flg.Check("FLAG_MAIN_12_025") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0506_0080_0080")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0506_0080_0010")
        Cam.Inst:Set(6.346, 1.026, 106.67, 4.15, 4.193, 115.9, default, 30)
        Message("f_d0506_0080_0020")
        Cam.Inst:Set(20.63, 1.577, 97.65, 11.19, 3.16, 100.54, default, 30)
        Message("f_d0506_0080_0030")
        Cam.Inst:Set(9.457, 4.883, 95.16, 6.01, 1.091, 103.75, default, 30)
        Message("f_d0506_0080_0040")
        if Flg.Check("FLAG_IS_CLEAR_S010_159") then
          Cam.Inst:Set(-19.97, 1.593, 95.58, -11.39, 2.518, 100.588, default, 30)
          Message("f_d0506_0080_0050")
        else
          Cam.Inst:Set(-19.14, 0.329, 94.93, -11.27, 2.695, 100.63, default, 30)
          Message("f_d0506_0080_0090")
        end
        Cam.Inst:Set(-8.493, 0.602, 107.32, -1.207, 2.151, 113.588, default, 30)
        Message("f_d0506_0080_0060")
        Cam.Inst:Clear(30)
        WaitFrame(30)
        Message("f_d0506_0080_0070")
        Field_Talk_End_Not_LetterBox()
      end
    end
    if talk_id == 309 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0090_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 310 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, false, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0100_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, true)
    end
    if talk_id == 311 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0110_0010")
      Message("f_d0506_0110_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 312 then
      local fldtxt = "d05"
      Cam.Inst:Set(-8.96, 0.57, 102.57, -3.76, 1.87, 111.01, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, false, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_0120_0010")
      Message("f_d0506_0120_0020")
      Cam.Inst:Set(-9.78, 0.57, 106.11, -2.68, 2.03, 113, default, 30)
      WaitFrame(30)
      Message("f_d0506_0120_0030")
      Message("f_d0506_0120_0040")
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, false, false)
    end
    if talk_id == 313 then
      local fldtxt = "d05"
      require("S040_160")
      if Qst.Sub:Check(S040_160.ID, S040_160.STEP_001, S040_160.STEP_005) then
        S040_160:Event_010()
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start_Not_LetterBox(fldtxt, 1)
        Message("f_d0506_0130_0010")
        Message("f_d0506_0130_0020")
        Message("f_d0506_0130_0030")
        Message("f_d0506_0130_0040")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if talk_id == 314 then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      if Flg.Check("FLAG_MAIN_12_015", "FLAG_MAIN_12_020") then
        Message("f_d0506_0180_0020")
      elseif Flg.Check("FLAG_MAIN_12_026", "FLAG_MAIN_12_027") then
        Message("f_d0506_0180_0030")
      elseif Flg.Check("FLAG_MAIN_12_029", "FLAG_MAIN_12_030") then
        Message("f_d0506_0180_0040")
      elseif Flg.Check("FLAG_MAIN_12_032", "FLAG_MAIN_12_035") then
        Message("f_d0506_0180_0050")
      end
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "card_001" then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0506_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0506_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1502, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0506_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        elseif result == CARD_GAME_LOSE then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0506_9000_0050")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        else
          END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0506_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "s110_106_001" then
      require("S110_106")
      S110_106:Event_040()
      S110_106:Event_030()
    end
    if npc_name == "s040_160_001" then
      require("S040_160")
      S040_160:Event_010()
    end
    if npc_name == "s110_111_001" then
      require("S110_111")
      S110_111:Event_050()
    end
    if npc_name == "s110_111_002" then
      require("S110_111")
      S110_111:Event_060()
    end
    if npc_name == "s010_159_dura_01" then
      require("S010_159")
      S010_159:Event_030()
    end
    if npc_name == "s100_089_001" then
      if Qst.Sub:Check(208, 10, 255) then
        require("S110_208")
        S110_208:Event_010()
      else
        require("S100_089")
        S100_089:Event_600()
        S100_089:Event_030()
        S100_089:Event_010()
      end
    end
    if npc_name == "s100_089_002" then
      if Qst.Sub:Check(208, 10, 255) then
        require("S110_208")
        S110_208:Event_010()
      else
        require("S100_089")
        S100_089:Event_610()
        S100_089:Event_030()
        S100_089:Event_010()
      end
    end
    if npc_name == "s100_089_003" then
      if Qst.Sub:Check(208, 10, 255) then
        require("S110_208")
        S110_208:Event_010()
      else
        require("S100_089")
        S100_089:Event_620()
        S100_089:Event_030()
        S100_089:Event_010()
      end
    end
    if npc_name == "s100_089_004" then
      require("S110_208")
      S110_208:Event_010()
    end
    if npc_name == "s110_111_003" then
      require("S110_111")
      S110_111:Event_015()
      S110_111:Event_010()
    end
    if npc_name == "s110_111_004" then
      require("S110_111")
      S110_111:Event_020()
    end
    if npc_name == "s110_111_005" then
      require("S110_111")
      S110_111:Event_025()
    end
  elseif gMapNum == 550 then
    if talk_id == 1 then
      local fldtxt = "d05"
      local mame_fq01 = Motion.Object:new(NPC, "npc_0001", "fq01")
      local mame_fe02 = Motion.Object:new(NPC, "npc_0001", "fe02")
      local solar_bn01 = Motion.Object:new(NPC, "npc_0002", "bn01")
      local solar_fe03 = Motion.Object:new(NPC, "npc_0002", "fe03")
      local solar_fq01 = Motion.Object:new(NPC, "npc_0002", "fq01")
      local haguru_bn01 = Motion.Object:new(NPC, "npc_0003", "bn01")
      local haguru_fe02 = Motion.Object:new(NPC, "npc_0003", "fe02")
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      solar_fe03:Play(15, true)
      Message("f_d0550_0010_0010")
      haguru_fe02:Play(15, true)
      solar_fq01:Play(15, true)
      Message("f_d0550_0010_0020")
      mame_fe02:Play(15, true)
      Message("f_d0550_0010_0030")
      mame_fq01:Play(15, true)
      solar_bn01:Play(15, true)
      haguru_bn01:Play(15, true)
      Field_Talk_End_Not_LetterBox()
    end
    if npc_name == "card_001" then
      local fldtxt = "d05"
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0550_9000_0010")
      MessageClose()
      local result = 0
      MessageTalkSel(2, "f_d0550_9000_0020")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        local result = Field.StartCardGameWithNPC(1505, true)
        if result == CARD_GAME_WIN then
          START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          Field_Talk_Start_Not_LetterBox(fldtxt, 1)
          Message("f_d0550_9000_0040")
          Field_Talk_End_Not_LetterBox()
          END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
        else
          if result == CARD_GAME_LOSE then
            START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
            Field_Talk_Start_Not_LetterBox(fldtxt, 1)
            Message("f_d0550_9000_0050")
            Field_Talk_End_Not_LetterBox()
            END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
          else
          end
        end
      elseif result == RESULT_TALK01 then
        Message("f_d0550_9000_0030")
        Field_Talk_End_Not_LetterBox()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      end
    end
    if talk_id == 10 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0550_0020_0010")
      Message("f_d0550_0020_0020")
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 551 then
    if talk_id == 300 then
      local nano = Obj:new(NPC, "npc_0001")
      local nano01 = GetIndex(NPC, "npc_0001")
      local player = Field.GetPlayerIndex()
      local npc0001_pos = Field.ObjectGetPosition(NPC, nano01)
      local player_pos = Field.ObjectGetPosition(PLAYER, player)
      local y_nano = GetAngleToTarget2D(npc0001_pos.x, npc0001_pos.z, player_pos.x, player_pos.z)
      local nano_bn01 = Motion.Object:new(NPC, "npc_0001", "bn01")
      local nano_fe02 = Motion.Object:new(NPC, "npc_0001", "fe02")
      local nano_fq02 = Motion.Object:new(NPC, "npc_0001", "fq02")
      local gabe_fe02 = Motion.Object:new(NPC, "npc_0002", "fe02")
      local gabe_bn01 = Motion.Object:new(NPC, "npc_0002", "bn01")
      local gabe_fq01 = Motion.Object:new(NPC, "npc_0002", "fq01")
      local gabe = Obj:new(NPC, "npc_0002")
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      gabe:SetRotationYToPlayer(15)
      gabe_fe02:Play(15, true)
      Message("f_d0551_0010_0010")
      Field.ObjectSetRotationY(FLD_OBJ_NPC, nano01, y_nano, 25)
      WaitFrame(30)
      gabe_bn01:Play(15, true)
      Message("f_d0551_0010_0020")
      gabe_fq01:Play(15, true)
      nano_fq02:Play(15, true)
      Message("f_d0551_0010_0030")
      nano_bn01:Play(15, true)
      Message("f_d0551_0010_0040")
      nano:ClearRotationY(30)
      WaitFrame(30)
      Message("f_d0551_0010_0050")
      gabe_fe02:Play(15, true)
      Message("f_d0551_0010_0060")
      gabe:ClearRotationY(30)
      gabe_bn01:Play(15, true)
      nano_fe02:Play(15, true)
      Message("f_d0551_0010_0070")
      gabe_fq01:Play(15, true)
      Message("f_d0551_0010_0080")
      nano_bn01:Play(15, true)
      gabe_bn01:Play(15, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 310 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0551_0020_0010")
      Message("f_d0551_0020_0020")
      Message("f_d0551_0020_0030")
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 552 then
    if talk_id == 1 then
      local fldtxt = "d05"
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0552_0010_0010")
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 2 then
      Field_Talk_Start_Not_LetterBox(npc_text, 1)
      Message("f_d0552_0020_0010")
      Message("f_d0552_0020_0020")
      Message("f_d0552_0020_0030")
      Message("f_d0552_0020_0040")
      Field_Talk_End_Not_LetterBox()
    end
  end
end

function OnFieldAttackNpc(args)
  local type, index = args.obj_type, args.obj_index
  local npc_name = args.unique_name
  local skill_pow, skill_ele = args.skill_power, args.skill_element
  local need_pow, need_ele = args.need_power, args.need_element
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  print("npc_name = ", npc_name)
  if npc_name == "guest_kokuwa" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
    M150:Event_095()
  end
end

function D05_WarpNPC_Before(npc_name)
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
  local result = tlk:Select(3, "f_d0107_0100_0190")
  if result == RESULT_TALK00 or result == RESULT_TALK01 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_FIELD_D05_IS_WARP")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 501, "start_32", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 505, "start_30", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end

function D05_WarpNPC_After(npc_name)
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
  local result = tlk:Select(3, "f_d0107_0100_0200")
  if result == RESULT_TALK00 or result == RESULT_TALK01 then
    tlk:Message("f_d0107_0100_0030")
    tlk:MessageClose()
    WarpNpcPerformance(npc_name)
    Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
    Flg.Set("FLAG_FIELD_D05_IS_WARP")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(15)
    Cam.Inst:Clear(0)
    PlayerObjectResetAim()
    tlk:EndTalk()
    if result == RESULT_TALK00 then
      MapChange("d", 501, "start_31", false, FADE_WHITE, FADE_TIME)
    elseif result == RESULT_TALK01 then
      MapChange("d", 506, "start_30", false, FADE_WHITE, FADE_TIME)
    end
  else
    tlk:Message("f_d0107_0100_0040")
    tlk:EndTalk()
    PlayerObjectResetAim()
    Cam.Inst:Clear(30)
    WaitFrame(30)
  end
end
