gGimText = "field_text"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  AddLoadList(FLD_OBJ_PLAYER, {
    "",
    move_motion = {"flow"},
    motion = {
      "fg14_w02",
      "e003",
      "e004"
    },
    attach = {9},
    attach_motion = {
      {9, "e200"}
    }
  })
  if load_map_num == 301 then
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0001",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0002",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0003",
      motion = {"e001"}
    })
    AddLoadList(FLD_OBJ_LOCATOR, {
      "obj_0004",
      motion = {"e001"}
    })
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "correct03"), "f001")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "correct03"), "fe02")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "correct03"), "f004")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "correct03"), "f005")
    Field.ObjectLoadMotion(ENEMY, GetIndex(ENEMY, "correct03"), "ba01")
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  if gMapNum == 301 then
    ColOff("plan_cl_0001")
    Field_InvisibleGimmick("gim_0001", 0, 0, false)
    ColOff("plan_cl_0003")
    Field_InvisibleGimmick("gim_0004", 0, 0, false)
    ColOff("plan_cl_0002")
    Field_InvisibleGimmick("gim_0003", 0, 0, false)
    ColOff("plan_cl_0004")
    Field_InvisibleGimmick("gim_0002", 0, 0, false)
    SetControlScriptExternalVariable("enemy_state", "init")
    if not Flg.Check("FLAG_GIMMICK_H03_010") then
      if Flg.Check("FLAG_GIMMICK_H03_040") then
        local enemy = GetIndex(ENEMY, "correct01")
        Field.ObjectSetPos(ENEMY, enemy, 32.41, 0, 50.19)
        SetControlScriptExternalVariable("enemy_state", "stay")
        SetControlScriptExternalVariable("enemy_state_bef", "move_r_b")
      elseif Flg.Check("FLAG_GIMMICK_H03_050") then
        local enemy = GetIndex(ENEMY, "correct01")
        Field.ObjectSetPos(ENEMY, enemy, -20.39, 0, 50.19)
        SetControlScriptExternalVariable("enemy_state", "stay")
        SetControlScriptExternalVariable("enemy_state_bef", "move_l_b")
      end
    end
    if not Flg.Check("FLAG_GIMMICK_H03_030") then
      if Flg.Check("FLAG_GIMMICK_H03_060") then
        local enemy = GetIndex(ENEMY, "correct03")
        Field.ObjectSetPos(ENEMY, enemy, -14.305, 0, 11.201)
        Field.ObjectSetRotationY(ENEMY, enemy, 180, 0)
        Field.ObjectPlayMotion(ENEMY, enemy, "fe02", 0, true)
      else
        local enemy = GetIndex(ENEMY, "correct03")
        Field.ObjectSetPos(ENEMY, enemy, -27.01, 0, -28.567)
        Field.ObjectSetRotationY(ENEMY, enemy, 90, 0)
        Field.ObjectPlayMotion(ENEMY, enemy, "fe02", 0, true)
      end
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 301 then
    if col_name == "evt_9000" then
      M100:Event_090()
    end
    if col_name == "evt_0010" then
      M100:Event_082()
    end
    if not Flg.Check("FLAG_GIMMICK_H03_010") then
      local enemy_state = GetControlScriptExternalVariableString("enemy_state")
      local enemy_state_bef = GetControlScriptExternalVariableString("enemy_state_bef")
      if col_name == "evt_0001" then
        if enemy_state_bef == "init" then
          SetControlScriptExternalVariable("enemy_state", "move_02")
        end
      elseif col_name == "evt_0002" then
        if enemy_state_bef == "move_02" or enemy_state_bef == "move_l_a_up" or enemy_state_bef == "move_l_a_down" then
          SetControlScriptExternalVariable("enemy_state", "move_r_b")
        end
      elseif col_name == "evt_0003" then
        if enemy_state_bef == "move_r_a_up" or enemy_state_bef == "move_r_a_down" then
          SetControlScriptExternalVariable("enemy_state", "move_l_b")
        end
      elseif col_name == "evt_0004" then
        if enemy_state_bef == "move_r_b" then
          SetControlScriptExternalVariable("enemy_state", "move_r_a_down")
        end
      elseif col_name == "evt_0005" then
        if enemy_state_bef == "move_r_b" then
          SetControlScriptExternalVariable("enemy_state", "move_r_a_up")
        end
      elseif col_name == "evt_0006" then
        if enemy_state_bef == "move_l_b" then
          SetControlScriptExternalVariable("enemy_state", "move_l_a_down")
        end
      elseif col_name == "evt_0007" and enemy_state_bef == "move_l_b" then
        SetControlScriptExternalVariable("enemy_state", "move_l_a_up")
      end
    end
    if not Flg.Check("FLAG_GIMMICK_H03_030") then
      if col_name == "evt_0009" and not Flg.Check("FLAG_GIMMICK_H03_060") then
        local enemy = GetIndex(ENEMY, "correct03")
        Flg.Set("FLAG_GIMMICK_H03_060")
        Cam.Inst:Set(-24.52, 0, -28.55, -12.52, 2.76, -30.54, default, 15)
        Field.ObjectPlayMotion(ENEMY, enemy, "bn01", 15, true)
        WaitFrame(30)
        Field.ObjectPlayMotion(ENEMY, enemy, "f004", 15, false)
        WaitFrame(20)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(5)
        Cam.Inst:Set(-14.38, 0, 11.22, -12.51, 4.74, 23.45, default, 0)
        Field.ObjectSetPos(ENEMY, enemy, -14.305, 0, 11.201)
        Field.ObjectSetRotationY(ENEMY, enemy, 180, 0)
        Field.ObjectPlayMotion(ENEMY, enemy, "bn01", 0, true)
        WaitFrame(5)
        Field.ObjectPlayMotion(ENEMY, enemy, "f005", 0, false)
        WaitFrame(1)
        FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
        WaitFrame(10)
        Field.ObjectPlayMotion(ENEMY, enemy, "bn01", 15, true)
        WaitFrame(20)
        Field.ObjectPlayMotion(ENEMY, enemy, "fe02", 15, true)
        Cam.Inst:Clear(30)
        WaitFrame(30)
      elseif col_name == "evt_0008" and Flg.Check("FLAG_GIMMICK_H03_060") then
        local enemy = GetIndex(ENEMY, "correct03")
        Flg.Clear("FLAG_GIMMICK_H03_060")
        Cam.Inst:Set(-14.89, 0, 13.21, -12.91, 3.5, 24.78, default, 15)
        Field.ObjectPlayMotion(ENEMY, enemy, "bn01", 15, true)
        WaitFrame(30)
        Field.ObjectPlayMotion(ENEMY, enemy, "f004", 15, false)
        WaitFrame(20)
        Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
        WaitFrame(5)
        Cam.Inst:Set(-25.13, 1.09, -25.07, -21.72, 3.65, -16.02, default, 0)
        Field.ObjectSetPos(ENEMY, enemy, -27.01, 0, -28.567)
        Field.ObjectSetRotationY(ENEMY, enemy, 90, 0)
        Field.ObjectPlayMotion(ENEMY, enemy, "bn01", 0, true)
        WaitFrame(5)
        Field.ObjectPlayMotion(ENEMY, enemy, "f005", 0, false)
        WaitFrame(1)
        FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
        WaitFrame(10)
        Field.ObjectPlayMotion(ENEMY, enemy, "bn01", 15, true)
        WaitFrame(20)
        Field.ObjectPlayMotion(ENEMY, enemy, "fe02", 15, true)
        Cam.Inst:Clear(30)
        WaitFrame(30)
      end
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 301 then
    if gim_id == 1 or gim_id == 2 or gim_id == 3 or gim_id == 4 then
      local tlk = Tlk:new("h03")
      tlk:StartTalk()
      tlk:Message("f_h0301_0010_0010")
      tlk:EndTalk()
    end
    if gim_id == 400 then
      Field_Talk_Start_Not_LetterBox(gGimText, 1)
      Message("g_crevice_0020_0010")
      MessageClose()
      MessageTalkSel(2, "g_sel_0020_0010")
      local result = Talk.GetResultSelectedNum()
      if result == RESULT_TALK00 then
        Field_Talk_End_Not_LetterBox()
        GoToOuter("change_0001", 0, -1)
        MapChange("d", 1001, "start_05", true, 1, FADE_TIME)
      elseif result == RESULT_TALK01 then
        Field_Talk_End_Not_LetterBox()
      end
    end
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 310 or gMapNum == 311 or gMapNum == 312 or gMapNum == 313 then
    if gim_name == "log_message" then
      HazamaMessage(tonumber(gim_tag), gim_index)
    elseif gim_name == "way_out" then
      PlayerLookAtGimmickObject(gim_name)
      HazamaWayout(gim_name)
    end
  end
  if gMapNum == 310 then
    if gim_name == "control_panel" then
      if Item.GetNum(22010) > 0 then
        PlayerLookAtGimmickObject(gim_name)
        TerminalAccsess(930)
      else
        Prcs_H03RaceKeepOut()
      end
    end
  elseif gMapNum == 311 then
    if gim_name == "control_panel" then
      if Item.GetNum(22010) > 0 then
        PlayerLookAtGimmickObject(gim_name)
        TerminalAccsess(931)
      else
        Prcs_H03RaceKeepOut()
      end
    end
  elseif gMapNum == 312 then
    if gim_name == "control_panel" then
      if Item.GetNum(22010) > 0 then
        PlayerLookAtGimmickObject(gim_name)
        TerminalAccsess(932)
      else
        Prcs_H03RaceKeepOut()
      end
    end
  elseif gMapNum == 313 and gim_name == "control_panel" then
    if Item.GetNum(22010) > 0 then
      PlayerLookAtGimmickObject(gim_name)
      TerminalAccsess(933)
    else
      Prcs_H03RaceKeepOut()
    end
  end
end

function OnFieldAttackGimmick(args)
  local gim_type, gim_index, gim_name, gim_tag = args.obj_type, args.obj_index, args.unique_name, args.tag
  local need_pow, need_ele = args.need_power, args.need_element
  local skill_pow, skill_ele = args.skill_power, args.skill_element
  if 310 <= gMapNum and gMapNum <= 313 then
    if string.find(gim_name, "meat") ~= nil and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
    if string.find(gim_name, "jammer") ~= nil and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  end
end

function OnCheckActModel(act)
end
