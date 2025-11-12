gGimText = "field_text"
g_h07movespeed = 2

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  if load_map_num == 701 then
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### InitializeObject #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  if gMapNum == 701 then
    if Flg.Check("FLAG_MAIN_20_015", "FLAG_MAIN_20_090") then
      SetProhibitPlayerOnlyOperate(true)
      Field.HideGuide(true)
      Field.PlayerFixedMaxSpeed(g_h07movespeed)
      local avatar_type = Common.GetPlayerAvatarType()
      if avatar_type == PLAYER_AVATAR_TYPE_HERO then
        SetControlScriptExternalVariable("avatar_type", "PLAYER_AVATAR_TYPE_HERO")
      elseif avatar_type == PLAYER_AVATAR_TYPE_HEROINE then
        SetControlScriptExternalVariable("avatar_type", "PLAYER_AVATAR_TYPE_HEROINE")
      end
    end
  elseif gMapNum == 703 then
    if Flg.Check("FLAG_GIMMICK_H07_010") then
      Obj:new(NPC, "enemy01"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_H07_020") then
      Obj:new(NPC, "enemy02"):Invisible()
    end
  elseif gMapNum == 704 then
    if Flg.Check("FLAG_GIMMICK_H07_030") then
      Obj:new(NPC, "enemy01"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_H07_040") then
      Obj:new(NPC, "enemy02"):Invisible()
    end
  elseif gMapNum == 705 then
    if Flg.Check("FLAG_GIMMICK_H07_050") then
      Obj:new(NPC, "enemy01"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_H07_060") then
      Obj:new(NPC, "enemy02"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_H07_070") then
      Obj:new(NPC, "enemy03"):Invisible()
    end
    if Flg.Check("FLAG_GIMMICK_H07_080") then
      Obj:new(NPC, "enemy04"):Invisible()
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum .. " #####")
  if gMapNum == 701 then
    if col_name == "evt_1001" then
      local pos = Field.ObjectGetPosition(PLAYER, 1)
      local pos_out = Field.ObjectGetPosition(OGIM, GetIndex(OGIM, "tag_out01"))
      local pos_start = Field.ObjectGetPosition(OGIM, GetIndex(OGIM, "tag_start02"))
      local pos_in = Field.ObjectGetPosition(OGIM, GetIndex(OGIM, "tag_in02"))
      Field.ObjectAdjustSpeedFrameMoveToTargetPos2D(PLAYER, 1, pos.x, pos_out.z, 30)
      WaitFrame(10)
      Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
      WaitFrame(5)
      Obj:new(PLAYER, ""):SetPos(pos_start.x, pos_start.y, pos_start.z, true)
      Field.ObjectAdjustSpeedFrameMoveToTargetPos2D(PLAYER, 1, pos.x, pos_in.z, 30)
      WaitFrame(10)
      FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    elseif col_name == "evt_1002" then
    elseif col_name == "evt_1003" then
    elseif col_name == "evt_1004" then
      local pos = Field.ObjectGetPosition(PLAYER, 1)
      local pos_out = Field.ObjectGetPosition(OGIM, GetIndex(OGIM, "tag_out04"))
      local pos_start = Field.ObjectGetPosition(OGIM, GetIndex(OGIM, "tag_start01"))
      local pos_in = Field.ObjectGetPosition(OGIM, GetIndex(OGIM, "tag_in01"))
      Field.ObjectAdjustSpeedFrameMoveToTargetPos2D(PLAYER, 1, pos.x, pos_out.z, 30)
      WaitFrame(10)
      Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
      WaitFrame(5)
      Obj:new(PLAYER, ""):SetPos(pos_start.x, pos_start.y, pos_start.z, true)
      Field.ObjectAdjustSpeedFrameMoveToTargetPos2D(PLAYER, 1, pos.x, pos_in.z, 30)
      WaitFrame(10)
      FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    end
  elseif gMapNum == 703 then
    if col_name == "evt_0001" then
      if not Flg.Check("FLAG_GIMMICK_H07_010") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_010", "up")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0002" then
      if not Flg.Check("FLAG_GIMMICK_H07_010") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_010", "down")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0003" then
      if not Flg.Check("FLAG_GIMMICK_H07_020") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_020", "down")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0004" and not Flg.Check("FLAG_GIMMICK_H07_020") then
      Field_Talk_Start(gGimText, 1)
      WaitFrame(30)
      Prcs_h07_battle("FLAG_GIMMICK_H07_020", "left")
      Cam.Inst:Clear(30)
      Field_Talk_End()
    end
  elseif gMapNum == 704 then
    if col_name == "evt_0001" then
      if not Flg.Check("FLAG_GIMMICK_H07_030") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_030", "down")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0002" then
      if not Flg.Check("FLAG_GIMMICK_H07_040") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_040", "left")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0003" then
      if not Flg.Check("FLAG_GIMMICK_H07_040") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_040", "right")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0004" and not Flg.Check("FLAG_GIMMICK_H07_040") then
      Field_Talk_Start(gGimText, 1)
      WaitFrame(30)
      Prcs_h07_battle("FLAG_GIMMICK_H07_040", "down")
      Cam.Inst:Clear(30)
      Field_Talk_End()
    end
  elseif gMapNum == 705 then
    if col_name == "evt_0001" then
      if not Flg.Check("FLAG_GIMMICK_H07_050") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_050", "down")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0002" then
      if not Flg.Check("FLAG_GIMMICK_H07_050") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_050", "up")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0003" then
      if not Flg.Check("FLAG_GIMMICK_H07_060") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_060", "down")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0004" then
      if not Flg.Check("FLAG_GIMMICK_H07_060") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_060", "up")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0005" then
      if not Flg.Check("FLAG_GIMMICK_H07_060") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_060", "right")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0006" then
      if not Flg.Check("FLAG_GIMMICK_H07_070") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_070", "right")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0007" then
      if not Flg.Check("FLAG_GIMMICK_H07_070") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_070", "down")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0008" then
      if not Flg.Check("FLAG_GIMMICK_H07_070") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_070", "up")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0009" then
      if not Flg.Check("FLAG_GIMMICK_H07_080") then
        Field_Talk_Start(gGimText, 1)
        WaitFrame(30)
        Prcs_h07_battle("FLAG_GIMMICK_H07_080", "up")
        Cam.Inst:Clear(30)
        Field_Talk_End()
      end
    elseif col_name == "evt_0010" and not Flg.Check("FLAG_GIMMICK_H07_080") then
      Field_Talk_Start(gGimText, 1)
      WaitFrame(30)
      Prcs_h07_battle("FLAG_GIMMICK_H07_080", "left")
      Cam.Inst:Clear(30)
      Field_Talk_End()
    end
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 701 then
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 701 and (gim_name == "access_bs_01" or gim_name == "access_bs_02" or gim_name == "access_bs_03" or gim_name == "access_bs_04" or gim_name == "access_bs_05" or gim_name == "access_bs_06") then
    M420:Event_091()
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 701 then
  end
end

function OnCheckActModel(act)
end
