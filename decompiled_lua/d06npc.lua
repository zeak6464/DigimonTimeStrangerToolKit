function OnCheckNPC(npc)
  local talk_id, npc_name = npc.talk_id, npc.unique_name
  
  local npc_text = gMapPrefix .. string.format("%04d", gMapNum)
  print("====== talk_id = ", talk_id, " ====== npc_name = ", npc_name, " ======")
  print("====== default_text_file = ", npc_text, " ======")
  local fldtxt = "d06"
  if gMapNum == 601 then
  elseif gMapNum == 604 then
    if npc_name == "npc_001" then
      M410:Event_220()
    end
    if npc_name == "npc_1000" then
      M410:Event_060()
    end
    if npc_name == "npc_1001" then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
      Cam.Inst:Set(37.62, -13.09, 9.36, 40.12, -13.82, -0.29, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fq02", 10, true)
      Message("f_d0604_0090_0070")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if talk_id == 108 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0090_0050")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 109 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0090_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 110 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0090_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 111 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0090_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 112 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0090_0060")
      Message("f_d0604_0090_0061")
      Message("f_d0604_0090_0062")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if talk_id == 113 then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fe02", 10, true)
      Message("f_d0604_0090_0040")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_1019" then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
      Cam.Inst:Set(39.91, -14.25, 58.29, 46.34, -16.37, 50.94, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fq02", 10, true)
      Message("f_d0604_0230_0010")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_1020" then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "fq02")
      Field.ObjectLoadMotion(NPC, npc_index01, "e008")
      Cam.Inst:Set(36.82, -14.8, 51.5, 45.97, -13.4, 55.3, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fq02", 10, true)
      Message("f_d0604_0230_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "e008", 10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_1029" then
      local bf01 = Motion.Object:new(NPC, "npc_1029", "bf01")
      local fe04 = Motion.Object:new(NPC, "npc_1029", "fe04")
      local bn01 = Motion.Object:new(NPC, "npc_1029", "bn01")
      local npc_index = GetIndex(NPC, "npc_1029")
      Cam.Inst:Set(43.84, -26.8, -69.72, 43.98, -25.4, -59.82, default, 30)
      WaitFrame(30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      bf01:Play(10, true)
      Message("f_d0604_0260_0010")
      fe04:Play(10, true)
      Message("f_d0604_0260_0020")
      bn01:Play(10, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_1049" then
      M410:Event_214()
    end
    if npc_name == "npc_100" then
      Cam.Inst:Set(48.38, -12.27, 22.18, 43.83, -15.64, 13.94, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0410_0010")
      Message("f_d0604_0410_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_101" then
      Cam.Inst:Set(39.29, -12.97, 20.57, 43.48, -15.09, 11.75, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0400_0010")
      Message("f_d0604_0400_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_105" then
      Cam.Inst:Set(58.95, -17.5, 16.52, 49.23, -15.17, 16, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0320_0010")
      Message("f_d0604_0320_0020")
      Message("f_d0604_0320_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_108" then
      Cam.Inst:Set(29.49, -16.05, 16.32, 39.46, -15.74, 15.64, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0310_0010")
      Message("f_d0604_0310_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_109" then
      Cam.Inst:Set(57.49, -15.75, -0.27, 47.5, -15.62, 0.3, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0140_0010")
      Message("f_d0604_0140_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_110" then
      Cam.Inst:Set(29.39, -17.4, -16.1, 39.2, -15.49, -16.22, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0330_0010")
      Message("f_d0604_0330_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_111" then
      Cam.Inst:Set(59.03, -18, -15.54, 49.36, -15.63, -16.44, default, 45)
      WaitFrame(45)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0340_0010")
      Message("f_d0604_0340_0020")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_1018" then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "bn02")
      Field.ObjectLoadMotion(NPC, npc_index01, "fe01")
      Cam.Inst:Set(42.89, -15.45, -8.62, 43.09, -15.48, -18.62, default, 30)
      START_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fe01", 10, true)
      Message("f_d0604_0250_0010")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn02", 10, true)
      Cam.Inst:Clear(30)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
    end
    if npc_name == "npc_112" then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
      local npc_index02 = GetIndex(NPC, "npc_125")
      Field.ObjectLoadMotion(NPC, npc_index02, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index02, "fq01")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fq01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "fq01", 10, true)
      Message("f_d0604_0360_0010")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "bn01", 10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_113" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "fq01")
      Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      local npc_index02 = GetIndex(NPC, "npc_114")
      Field.ObjectLoadMotion(NPC, npc_index02, "fe02")
      Field.ObjectLoadMotion(NPC, npc_index02, "fe04")
      Field.ObjectLoadMotion(NPC, npc_index02, "bn01")
      local npc_index03 = GetIndex(NPC, "npc_115")
      Field.ObjectLoadMotion(NPC, npc_index03, "fe04")
      Field.ObjectLoadMotion(NPC, npc_index03, "ba01")
      Field.ObjectLoadMotion(NPC, npc_index03, "bn01")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "bn01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index03, "bn01", 10, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fe02", 10, true)
      Message("f_d0604_0370_0010")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "fe04", 10, true)
      Message("f_d0604_0370_0020")
      Field.ObjectPlayMotion(NPC, npc_index02, "bn01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index03, "ba01", 10, true)
      Message("f_d0604_0370_0030")
      Field.ObjectPlayMotion(NPC, npc_index01, "fq01", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index02, "fe02", 10, true)
      Field.ObjectPlayMotion(NPC, npc_index03, "fe04", 10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_116" then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
      Field.ObjectLoadMotion(NPC, npc_index01, "fe02")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fe02", 10, true)
      Message("f_d0604_0380_0010")
      Message("f_d0604_0380_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "fe04", 10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_117" then
      local npc_index01 = GetIndex(NPC, npc_name)
      Field.ObjectLoadMotion(NPC, npc_index01, "bn01")
      Field.ObjectLoadMotion(NPC, npc_index01, "fe04")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Field.ObjectPlayMotion(NPC, npc_index01, "fe04", 10, true)
      Message("f_d0604_0390_0010")
      Message("f_d0604_0390_0020")
      Field.ObjectPlayMotion(NPC, npc_index01, "bn01", 10, true)
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
    if npc_name == "npc_118" then
      Cam.Inst:Set(52.03, -21.8, -10.71, 46.08, -14.83, -14.71, default, 45)
      WaitFrame(45)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0420_0010")
      Message("f_d0604_0420_0020")
      Message("f_d0604_0420_0030")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, false)
      Cam.Inst:Clear(30)
    end
    if npc_name == "npc_119" then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0604_0350_0010")
      Field_Talk_End_Not_LetterBox()
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
    end
  elseif gMapNum == 606 then
    if npc_name == "locomon_staff" then
      if Flg.Check("FLAG_MAIN_05_990") and not Flg.Check("FLAG_MAIN_06_010") then
        local tlk = Tlk:new(fldtxt, 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0606_0010_0050")
        tlk:Message("f_d0606_0010_0060")
        tlk:Message("f_d0606_0010_0070")
        tlk:EndTalk()
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        OpenWorldMap(DW, LOCOMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      else
        local tlk = Tlk:new(fldtxt, 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0606_0010_0010")
        tlk:EndTalk()
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
        OpenWorldMap(DW, LOCOMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_LOCOMON")
      end
    end
    if talk_id == 100 then
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0606_0020_0020")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 101 then
      local e007 = Motion.Object:new(NPC, "npc_101", "e007")
      local e004 = Motion.Object:new(NPC, "npc_101", "e004")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      Message("f_d0606_0030_0010")
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
    if talk_id == 102 then
      local bn01 = Motion.Object:new(NPC, "npc_102", "bn01")
      local e004 = Motion.Object:new(NPC, "npc_102", "e004")
      START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_Start_Not_LetterBox(fldtxt, 1)
      e004:Play(5, true)
      Message("f_d0606_0040_0010")
      bn01:Play(5, true)
      END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      Field_Talk_End_Not_LetterBox()
    end
  elseif gMapNum == 607 then
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_BeforeD06(npc_name)
    end
  elseif gMapNum == 608 then
    if talk_id == 100 then
      if Flg.Check("FLAG_MAIN_05_990") then
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(fldtxt, 1)
        Message("f_d0608_0010_0040")
        Message("f_d0608_0010_0050")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      else
        START_TALK_ACTION_AND_ZOOM(npc_name, true, true)
        Field_Talk_Start(fldtxt, 1)
        Message("f_d0608_0010_0010")
        Message("f_d0608_0010_0020")
        Message("f_d0608_0010_0030")
        Field_Talk_End()
        END_TALK_ACTION_AND_ZOOM(npc_name, true, true)
      end
    end
    if npc_name == "sub_200_hiroko" then
      require("Sow_200")
      SeekHiroko_AfterD06(npc_name)
    end
  end
end
