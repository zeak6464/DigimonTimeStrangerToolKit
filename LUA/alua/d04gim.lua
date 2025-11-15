gGimText = "field_text"
COL0404 = {
  "wall_cl_0001",
  "wall_cl_0002",
  "wall_cl_0003",
  "wall_cl_0004",
  "wall_cl_0005",
  "wall_cl_0006",
  "wall_cl_0007",
  "wall_cl_0008"
}
warp_cam = {}
warp_cam[1] = {
  -15.7,
  -9.2,
  -9.2,
  -11.8,
  -2.8,
  -2.6,
  25,
  -40
}
warp_cam[2] = {
  -24.4,
  3.1,
  -1.1,
  -20.1,
  7.9,
  6.4,
  25,
  -10
}
warp_cam[3] = {
  27.3,
  -15.1,
  -12.4,
  29,
  -8.5,
  -5.1,
  25,
  10
}
warp_cam[4] = {
  3.9,
  -10.4,
  -13.6,
  2.7,
  -3.3,
  -6.6,
  25,
  20
}
warp_cam[5] = {
  0,
  -40,
  -65,
  -0.5,
  -35.2,
  -56.2,
  20,
  20
}
warp_cam[6] = {
  15.9,
  -29.7,
  -63,
  11.8,
  -23.6,
  -56.3,
  20,
  0
}
warp_cam[7] = {
  -33.4,
  -58.1,
  -91.2,
  -28.7,
  -53,
  -84,
  25,
  -25
}
warp_cam[8] = {
  -14,
  -43.3,
  -70.7,
  -7.3,
  -38.2,
  -76.2,
  20,
  240
}
warp_cam[9] = {
  2.7,
  -26.2,
  5.1,
  -4.3,
  -21.2,
  10.1,
  20,
  0
}
warp_cam[10] = {
  4.8,
  -15.7,
  -38.3,
  0,
  -10,
  -44.9,
  20,
  180
}
warp_cam[11] = {
  28.6,
  -19.1,
  -88.2,
  31,
  -12,
  -81.5,
  20,
  -20
}
warp_cam[12] = {
  -0.6,
  -41.1,
  -93.9,
  0.8,
  -34.9,
  -86.2,
  20,
  10
}
start_cam = {}
start_cam[1] = {
  -24.6,
  4.9,
  0.2,
  -22,
  9.5,
  8.7
}
start_cam[2] = {
  -15.7,
  -9.2,
  -9.2,
  -11.8,
  -2.8,
  -2.6
}
start_cam[3] = {
  5.4,
  -9.4,
  -13.8,
  2.1,
  -2.4,
  -7.4
}
start_cam[4] = {
  27.3,
  -15.1,
  -12.4,
  29,
  -8.5,
  -5.1
}
start_cam[5] = {
  19.5,
  -27.1,
  -65.8,
  26.7,
  -20.9,
  -62.6
}
start_cam[6] = {
  0,
  -40,
  -65,
  -0.5,
  -35.2,
  -56.2
}
start_cam[7] = {
  -11.7,
  -40.5,
  -71.6,
  -4.5,
  -35.2,
  -76
}
start_cam[8] = {
  -33.2,
  -56.5,
  -87.3,
  -30.4,
  -50.3,
  -94.6
}
start_cam[9] = {
  4.8,
  -15.7,
  -38.3,
  0,
  -10,
  -44.9
}
start_cam[10] = {
  2.7,
  -26.2,
  5.1,
  -4.3,
  -21.2,
  10.1
}
start_cam[11] = {
  -0.6,
  -41.1,
  -93.9,
  0.8,
  -34.9,
  -86.2
}
start_cam[12] = {
  28.6,
  -19.1,
  -88.2,
  31,
  -12,
  -81.5
}
d0404_CameraAttachEffct = "ef_f_dun_117_pt"
d0406_CameraAttachEffct = "ef_f_dun_118_pt"

function LoadGimmickData(load_map_num)
  CreateLoadList()
  for i = 1, #PC_GENERAL_MOTION do
    Motion.Object:Load(FLD_OBJ_PLAYER, "", PC_GENERAL_MOTION[i])
  end
  Field.ObjectLoadAttachment(PLAYER, 1, 5)
  Field.LoadCameraAttachEffectScript(d0404_CameraAttachEffct)
  Field.LoadCameraAttachEffectScript(d0406_CameraAttachEffct)
  if load_map_num == 406 then
    Field.ObjectLoadMotion(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), "e001")
    Field.ObjectLoadMotion(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), "e002")
    Field.ObjectLoadMotion(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), "e003")
  end
  LoadDataInLoadList()
end

function InitializeObject()
  print("##### d04_gim #####")
  print("##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  PlayerObjectResetAim()
  PlayerHideAttachment(4)
  if gMapNum == 401 then
    Field.InvisibleGimmick("obj_0001", 0, 0, false)
    if Flg.Check("FLAG_GIMMICK_D04_260") then
      ColOff("evt_9001")
    end
    if not Flg.Check("FLAG_GIMMICK_D04_030") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0003"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0004"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_040") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0011"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0012"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_060") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0013"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0014"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_070") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0007"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0008"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_080") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0009"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0010"), 0, 0, false)
    end
  elseif gMapNum == 402 then
    local npc_index = GetIndex(NPC, "M_burinpu_01")
    Field.ObjectSuspendAutoTransparent(NPC, npc_index, AUTO_TRANSPARENT_TYPE_ALL)
  elseif gMapNum == 403 then
    if not Flg.Check("FLAG_GIMMICK_D04_090") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0001"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0002"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_360") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0003"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0004"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_361") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0005"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0006"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_362") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0007"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0008"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_363") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0009"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0010"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_364") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0011"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0012"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_365") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0013"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0016"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_366") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0014"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0015"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_367") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0017"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0018"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_368") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0019"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0020"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_369") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0021"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0022"), 0, 0, false)
    end
    if not Flg.Check("FLAG_GIMMICK_D04_370") then
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0023"), 0, 0, false)
      Field.ObjectInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0024"), 0, 0, false)
    end
    if Flg.Check("FLAG_MAIN_10_020") and not Flg.Check("FLAG_MAIN_10_058") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0017"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0018"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0019"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0020"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0021"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0022"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0023"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0024"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0005"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0006"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0007"), false)
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0008"), false)
    end
  elseif gMapNum == 404 then
    if Common.CheckTimeAxis("A2020_dbef_180", "A2020_dbef_10000") then
      Field.StartCameraAttachEffectScript(d0404_CameraAttachEffct)
    end
    if Debug.RunningFromFieldSelect() == true and Common.CheckTimeAxis("FirstPast", "FinalPast") then
      Field.StartCameraAttachEffectScript(d0404_CameraAttachEffct)
    end
    if Flg.Check("FLAG_MAIN_08_000", "FLAG_MAIN_10_020") then
      ColOffWithTable(COL0404)
    elseif Flg.Check("FLAG_MAIN_10_040", "FLAG_MAIN_10_053") then
      ColOffWithTable(COL0404)
    end
  elseif gMapNum == 405 then
  elseif gMapNum == 406 then
    if Common.CheckTimeAxis("A2020_dbef_180", "A2020_dbef_10000") then
      Field.StartCameraAttachEffectScript(d0406_CameraAttachEffct)
    end
    if Debug.RunningFromFieldSelect() == true and Common.CheckTimeAxis("FirstPast", "FinalPast") then
      Field.StartCameraAttachEffectScript(d0406_CameraAttachEffct)
    end
    if Flg.Check("FLAG_FIELD_D406_CORELIGHTOFF") then
      Obj:new(FLD_OBJ_LOCATOR, "obj_0002"):Invisible()
    end
    if Flg.Check("FLAG_FIELD_D406_CORESLOW") then
      Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), "e002", 5, true)
    end
    if Flg.Check("FLAG_FIELD_D406_CORESTOP") then
      Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), "e003", 5, true)
    end
    if not Flg.Check("FLAG_FIELD_D406_CORESLOW") and not Flg.Check("FLAG_FIELD_D406_CORESTOP") then
      Field.ObjectPlayMotion(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "obj_0001"), "e001", 5, true)
    end
  elseif gMapNum == 407 then
    Obj:new(OGIM, "obj_barricade1"):CancelInvisible()
    Obj:new(OGIM, "obj_barricade2"):Invisible()
    Obj:new(OGIM, "fa_jureimon"):SetEnableCheckAndFieldAttack(false)
    if Flg.Check("FLAG_MAIN_06_041") then
      Obj:new(OGIM, "obj_barricade1"):CancelInvisible()
      Obj:new(OGIM, "obj_barricade2"):CancelInvisible()
    end
    if Flg.Check("FLAG_MAIN_06_044") then
      Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "fa_jureimon"), true)
    end
    if Flg.Check("FLAG_MAIN_06_046") then
      Obj:new(OGIM, "obj_barricade1"):Invisible()
      Obj:new(OGIM, "obj_barricade2"):Invisible()
      Obj:new(OGIM, "fa_jureimon"):SetEnableCheckAndFieldAttack(false)
    end
  end
end

function OnTriggerEnter(col)
  local col_name = col.name
  print("##### col_name = ", col_name, " ##### map_prefix = ", gMapPrefix, " ##### map_num = ", gMapNum, " #####")
  if gMapNum == 401 then
    if not Flg.Check("FLAG_MAIN_07_000") and col_name == "evt_0001" and not Flg.Check("FLAG_GIMMICK_D04_010") then
      Flg.Set("FLAG_GIMMICK_D04_010")
    end
    if col_name == "evt_0002" and not Flg.Check("FLAG_GIMMICK_D04_020") then
      Flg.Set("FLAG_GIMMICK_D04_020")
      MapChange("d", 403, "start_00", false, -1, -1)
    end
    if col_name == "evt_0003" then
      Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_FIELD, 30, true, false)
    end
    if col_name == "evt_0004" then
      M180:Event_220()
    end
    if col_name == "evt_0005" then
      M180:Event_080()
    end
    if col_name == "evt_9000" then
      Prcs_d04_RideFly_End("ride_fly_0003", 401)
    end
    if col_name == "evt_9001" then
      M180:Event_040()
    end
    if col_name == "evt_9900" then
      MiniMapChange(MAP_LAYER_LOW)
    elseif col_name == "evt_9901" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    elseif col_name == "evt_9902" then
      MiniMapChange(MAP_LAYER_HIGH)
    elseif col_name == "evt_9903" then
      MiniMapChange(MAP_LAYER_MIDDLE)
    end
  elseif gMapNum == 402 then
    if col_name == "evt_0001" then
      M290:Event_036()
      M300:Event_004()
    end
    if col_name == "evt_0002" then
      M290:Event_039A()
    end
    if col_name == "evt_0003" then
      M290:Event_039B()
    end
    if col_name == "evt_0004" then
      M300:Event_007A()
    end
    if col_name == "evt_0005" then
      M300:Event_007B()
    end
    if col_name == "evt_9000" then
      Prcs_d04_RideFly_End("ride_fly_0003", 402)
    end
  elseif gMapNum == 403 then
    if col_name == "evt_0001" then
      M180:Event_120()
      M300:Event_006()
    end
    if col_name == "evt_0002" then
      M180:Event_100()
    end
    if col_name == "evt_0003" then
      M180:Event_115()
    end
    if col_name == "evt_9000" then
      Prcs_d04_RideFly_End("ride_fly_0003", 403)
    elseif col_name == "evt_9001" then
      Prcs_d04_RideFly_End("ride_fly_0006", 403)
    end
    if col_name == "evt_9903" then
      Prcs_d04_RideFly_End("ride_fly_0010", 403)
    elseif col_name == "evt_9904" then
      Prcs_d04_RideFly_End("ride_fly_0013", 403)
    elseif col_name == "evt_9905" then
      Prcs_d04_RideFly_End("ride_fly_0016", 403)
    elseif col_name == "evt_9907" then
      Prcs_d04_RideFly_End("ride_fly_0019", 403)
    elseif col_name == "evt_9908" then
      Prcs_d04_RideFly_End("ride_fly_0022", 403)
    elseif col_name == "evt_9912" then
      Prcs_d04_RideFly_End("ride_fly_0025", 403)
    elseif col_name == "evt_9913" then
      Prcs_d04_RideFly_End("ride_fly_0031", 403)
    end
  elseif gMapNum == 404 then
    if col_name == "evt_1001" then
      M300:Event_020()
    end
    if col_name == "evt_1002" then
      M300:Event_030()
    end
    if col_name == "evt_1003" then
    end
    if col_name == "evt_1004" then
      M290:Event_045A()
      M300:Event_015A()
      M300:Event_195A()
    elseif col_name == "evt_1005" then
      M290:Event_045B()
    elseif col_name == "evt_1006" then
      M290:Event_045C()
      M300:Event_015C()
    elseif col_name == "evt_1007" then
      M290:Event_045D()
      M300:Event_015D()
    elseif col_name == "evt_1008" then
      M290:Event_045E()
      M300:Event_015E()
    elseif col_name == "evt_1009" then
      M300:Event_015B()
      M300:Event_195B()
    elseif col_name == "evt_1010" then
      M300:Event_195C()
    end
    if col_name == "evt_1011" and Flg.Check("FLAG_MAIN_10_055", "FLAG_MAIN_10_058") then
      local npc_index01 = GetIndex(NPC, "npc_0231")
      Field.ObjectLoadExpression(NPC, npc_index01, "F02")
      local fq01_rotos = Motion.Object:new(NPC, "npc_0229", "fq01")
      local bn01_rotos = Motion.Object:new(NPC, "npc_0229", "bn01")
      local fq01_rose = Motion.Object:new(NPC, "npc_0230", "fq01")
      local bn01_rose = Motion.Object:new(NPC, "npc_0230", "bn01")
      local fq01_gripho = Motion.Object:new(NPC, "npc_0231", "fq01")
      local bn01_gripho = Motion.Object:new(NPC, "npc_0231", "bn01")
      Cam.Inst:Set(58.69, 6.861, -43.07, 54.51, 6.043, -34.02, default, 20)
      local tlk = Tlk:new("d04", 1, true)
      tlk:StartTalk()
      fq01_rotos:Play(20, true)
      tlk:Message("f_d0404_0240_0010")
      bn01_rotos:Play(20, true)
      Field.ObjectChangeExpression(NPC, npc_index01, "F02", -1, false, 0)
      fq01_gripho:Play(20, true)
      tlk:Message("f_d0404_0240_0020")
      bn01_gripho:Play(20, true)
      fq01_rotos:Play(20, true)
      tlk:Message("f_d0404_0240_0030")
      bn01_rotos:Play(20, true)
      fq01_rose:Play(20, true)
      tlk:Message("f_d0404_0240_0040")
      bn01_rose:Play(20, true)
      tlk:MessageClose()
      Cam.Inst:Clear(20)
      WaitFrame(20)
      tlk:Message("f_d0404_0240_0050")
      Field.MovePlayerToRelativePosFrame(-4, 1, 30)
      tlk:EndTalk()
    end
    if col_name == "evt_9900" or col_name == "evt_9902" then
      MiniMapChange(1)
    elseif col_name == "evt_9901" or col_name == "evt_9903" then
      MiniMapChange(2)
    end
  elseif gMapNum == 405 then
    if col_name == "evt_0001" then
      M290:Event_038B()
    end
    if col_name == "evt_0002" then
      M290:Event_038C()
    end
    if col_name == "evt_1000" then
      require("S030_030")
      S030_030:Event_020()
    end
    if col_name == "evt_9900" then
      MiniMapChange(1)
    elseif col_name == "evt_9901" then
      MiniMapChange(2)
    end
  end
  if gMapNum == 407 then
    if col_name == "evt_0001" then
      M180:Event_153()
      M180:Event_160()
      M290:Event_053()
    end
    if col_name == "evt_0002" then
      M180:Event_155()
      M180:Event_163()
    end
  end
  if col_name == "evt_9101" then
    if Field.IsPlayerScriptDigimonRiding() == true and Flg.Check("AREA_OPEN_DEBUG") then
      WaitFrame(30)
      Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
      Field.FollowerWarp()
      EndRide(true, "ride_fly_0003", 30)
      WaitFrame(30)
      Flg.Clear("AREA_OPEN_DEBUG")
      Obj:new(NPC, "npc_0001"):CancelInvisible()
    end
  elseif col_name == "evt_9105" and Field.IsPlayerScriptDigimonRiding() == true and GetControlScriptExternalVariableString("force_ride_fly") == "start" then
    WaitFrame(30)
    Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
    Field.FollowerWarp()
    EndRide(true, "ride_fly_0013", 30)
    WaitFrame(30)
    Flg.Clear("AREA_OPEN_DEBUG")
    Obj:new(NPC, "npc_0001"):CancelInvisible()
    SetControlScriptExternalVariable("force_ride_fly", "end")
  end
end

function OnCheckLocatorObject(gim)
  local gim_id, gim_loc = gim.check_id, gim.locator
  local gim_name = gim.unique_name
  print("##### gimID = ", gim_id, " ##### locator = ", gim_loc, " #####")
  if gMapNum == 401 then
    if Flg.Check("FLAG_MAIN_06_020") then
      if gim_id == 300 then
        if Flg.Check("FLAG_GIMMICK_D04_050") then
          Field.CancelPlayerAnywhereDigimonRide(false, true)
          Prcs_d04_JumpRide("ride_whip_0001", "ride_whiplanding_0002")
        else
          PlayerLookAtLccatorObject(gim_name)
          Prcs_d0401_GuideMessage()
        end
      elseif gim_id == 301 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0002", "ride_whiplanding_0001", 5, "same")
      elseif gim_id == 302 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0003", "ride_whiplanding_0004", 5, "same")
      elseif gim_id == 303 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0004", "ride_whiplanding_0003", 5, "same")
      elseif gim_id == 304 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        M180:Event_072()
        Prcs_d04_JumpRide("ride_whip_0005", "ride_whiplanding_0006", 5, "same")
        M180:Event_075()
      elseif gim_id == 305 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0006", "ride_whiplanding_0005", 5, "same")
      elseif gim_id == 306 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0007", "ride_whiplanding_0008", 5, "same")
      elseif gim_id == 307 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0008", "ride_whiplanding_0007", 5, "same")
      elseif gim_id == 308 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0009", "ride_whiplanding_0010", 5, "same")
      elseif gim_id == 309 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0010", "ride_whiplanding_0009", 5, "same")
      elseif gim_id == 310 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0011", "ride_whiplanding_0012", 5, "same")
      elseif gim_id == 311 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0012", "ride_whiplanding_0011", 5, "same")
      elseif gim_id == 312 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0013", "ride_whiplanding_0014", 5, "low")
      elseif gim_id == 313 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0014", "ride_whiplanding_0013", 5, "high")
      elseif gim_id == 315 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRideAndMapChangeOut("ride_whip_0015", "ride_whiplanding_0015", 5, "high", 402, "start_06")
      end
    elseif gim_id == 304 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start(gGimText, 1)
      Message("g_f0401_0030_0010")
      Field_Talk_End()
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 402 then
    if Flg.Check("FLAG_MAIN_06_020") then
      if gim_id == 300 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0001", "ride_whiplanding_0002", 5, "same")
      elseif gim_id == 301 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0002", "ride_whiplanding_0001", 5, "same")
      elseif gim_id == 302 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0003", "ride_whiplanding_0004", 5, "same")
      elseif gim_name == "ride_whip_0004" then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        M300:Event_002()
        M290:Event_033()
        Prcs_d04_JumpRide("ride_whip_0004", "ride_whiplanding_0003", 5, "same")
        M300:Event_003()
      elseif gim_name == "ride_whip_0005" then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0005", "ride_whiplanding_0006", 5, "same")
      elseif gim_id == 305 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0006", "ride_whiplanding_0005", 5, "same")
      elseif gim_id == 306 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0007", "ride_whiplanding_0008", 5, "same")
      elseif gim_id == 307 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0008", "ride_whiplanding_0007", 5, "same")
      elseif gim_id == 309 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRideAndMapChangeOut("ride_whip_0009", "ride_whiplanding_0009", 5, "high", 401, "start_04")
      end
      if gim_id == 400 then
        GoToTheaterWithEvt()
      end
    end
  elseif gMapNum == 403 then
    if Flg.Check("FLAG_MAIN_06_020") then
      if gim_id == 300 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        M180:Event_110()
        Prcs_d04_JumpRide("ride_whip_0001", "ride_whiplanding_0002", 5, "high")
      elseif gim_id == 301 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0002", "ride_whiplanding_0001", 30, "low")
      elseif gim_id == 302 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0003", "ride_whiplanding_0004", 15, "same")
      elseif gim_id == 303 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0004", "ride_whiplanding_0003", 15, "same")
      elseif gim_id == 321 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0005", "ride_whiplanding_0006", 15, "low")
      elseif gim_id == 322 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0006", "ride_whiplanding_0005", 5, "high")
      elseif gim_id == 323 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0007", "ride_whiplanding_0008", 5, "low")
      elseif gim_id == 324 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0008", "ride_whiplanding_0007", 5, "high")
      elseif gim_id == 316 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0009", "ride_whiplanding_0010", 5, "low")
      elseif gim_id == 317 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0010", "ride_whiplanding_0009", 5, "high")
      elseif gim_id == 318 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0011", "ride_whiplanding_0012", 5, "same")
      elseif gim_id == 319 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0012", "ride_whiplanding_0011", 5, "same")
      elseif gim_id == 325 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0013", "ride_whiplanding_0013", 5, "same")
      elseif gim_id == 326 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0014", "ride_whiplanding_0014", 5, "same")
      elseif gim_id == 327 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0015", "ride_whiplanding_0015", 5, "same")
      elseif gim_id == 328 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0016", "ride_whiplanding_0016", 5, "same")
      elseif gim_id == 329 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0017", "ride_whiplanding_0017", 5, "same")
      elseif gim_id == 330 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0018", "ride_whiplanding_0018", 5, "same")
      elseif gim_id == 331 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0019", "ride_whiplanding_0019", 5, "same")
      elseif gim_id == 332 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0020", "ride_whiplanding_0020", 5, "same")
      elseif gim_id == 333 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0021", "ride_whiplanding_0021", 5, "same")
      elseif gim_id == 334 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0022", "ride_whiplanding_0022", 5, "same")
      elseif gim_id == 335 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0023", "ride_whiplanding_0023", 5, "same")
      elseif gim_id == 336 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0024", "ride_whiplanding_0024", 5, "same")
      end
    end
  elseif gMapNum == 404 then
    if gim_id == 1 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0404_WarpGim_01()
      MiniMapChange(2)
    elseif gim_id == 2 then
      Field.CancelPlayerAnywhereDigimonRide(false, true)
      Prcs_d0404_WarpGim_02()
      MiniMapChange(1)
    end
    if gim_id == 400 then
      GoToTheaterWithEvt()
    end
  elseif gMapNum == 405 then
    if Flg.Check("FLAG_MAIN_06_020") then
      if gim_id == 300 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0001", "ride_whiplanding_0002", 5, "same")
      elseif gim_id == 301 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0002", "ride_whiplanding_0001", 5, "same")
      elseif gim_id == 302 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0003", "ride_whiplanding_0004", 5, "same")
      elseif gim_id == 303 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0004", "ride_whiplanding_0003", 5, "same")
      elseif gim_id == 304 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0005", "ride_whiplanding_0006", 5, "high")
      elseif gim_id == 305 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0006", "ride_whiplanding_0005", 45, "low")
      elseif gim_id == 306 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0007", "ride_whiplanding_0008", 45, "low")
      elseif gim_id == 307 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0008", "ride_whiplanding_0007", 5, "high")
      elseif gim_id == 308 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0009", "ride_whiplanding_0010", 5, "high")
      elseif gim_id == 309 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0010", "ride_whiplanding_0009", 5, "low")
      elseif gim_id == 310 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0011", "ride_whiplanding_0012", 5, "high")
      elseif gim_id == 311 then
        Field.CancelPlayerAnywhereDigimonRide(false, true)
        Prcs_d04_JumpRide("ride_whip_0012", "ride_whiplanding_0011", 15, "low")
      end
    end
    if gim_id == 202 or gim_id == 203 then
      PlayerLookAtLccatorObject(gim_name)
      Field_Talk_Start(gGimText, 1)
      Message(1040500000)
      Field_Talk_End()
    end
  elseif gMapNum == 406 and gim_id == 999 then
    GoToTheaterWithEvt()
  end
end

function OnCheckGimmick(gim)
  local gim_name, gim_index, gim_tag, gim_type = gim.unique_name, gim.obj_index, gim.tag, gim.obj_type
  local gim_id, gim_loc = gim.check_id, gim.locator
  print("##### gim_name = ", gim_name, " ##### gim_index = ", gim_index, " ##### gim_tag = ", gim_tag, " ##### gim_type = ", gim_type, " #####")
  if gMapNum == 401 then
  elseif gMapNum == 402 then
    if gim_name == "access_icon_01" then
      if Flg.Check("FLAG_MAIN_10_020") and not Flg.Check("FLAG_MAIN_10_058") then
        PlayerLookAtGimmickObject("lookat_01")
        local tlk = Tlk:new("d04", 1, true)
        tlk:StartTalk()
        tlk:Message("f_d0402_0150_0010")
        tlk:EndTalk()
      else
        PlayerLookAtGimmickObject("lookat_01")
        local tlk = Tlk:new("field_text", 1, true)
        tlk:StartTalk()
        tlk:Message("g_wm_0030_0010")
        tlk:EndTalk()
        Flg.Set("FLAG_ISAREA_CHANGE_FOR_BLIMP")
        OpenWorldMap(DW, BLIMPMON)
        Flg.Clear("FLAG_ISAREA_CHANGE_FOR_BLIMP")
      end
    end
  elseif gMapNum == 403 then
    if gim_name == "sub031_item01" then
      PlayerLookAtGimmickObject(gim_name)
      require("S030_031")
      S030_031:Event_030()
    end
    if gim_name == "sub031_item02" then
      PlayerLookAtGimmickObject(gim_name)
      require("S030_031")
      S030_031:Event_031()
    end
    if gim_name == "sub031_item03" then
      PlayerLookAtGimmickObject(gim_name)
      require("S030_031")
      S030_031:Event_032()
    end
    if gim_name == "s040_032_010" then
      PlayerLookAtGimmickObject(gim_name)
      require("S040_032")
      S040_032:Event_070()
    end
  elseif gMapNum == 404 then
    if gim_name == "access_point_1" then
      PlayerLookAtGimmickObject(gim_name)
      M290:Event_050()
    end
  elseif gMapNum == 405 then
  elseif gMapNum == 406 then
    if gim_name == "access_point_01" then
      PlayerLookAtGimmickObject(gim_name)
    end
    if gim_name == "obj_germination01" then
      require("S030_031")
      if Qst.Sub:Check(S030_031.ID, S030_031.STEP_005, S030_031.STEP_030) and Flg.Check("FLAG_MAIN_22_010") then
        Field.ObjectLoadMotion(PLAYER, 1, "e017")
        local tlk = Tlk:new("d04", 1, false)
        tlk:StartTalk()
        PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
        Field.ObjectPlayMotion(PLAYER, 1, "e017", 15, true)
        WaitFrame(10)
        tlk:Message("f_d0406_0020_0010")
        tlk:EndTalk()
        Field.ObjectResetMotion(PLAYER, 1, 20)
      elseif Qst.Sub:Check(S030_031.ID, S030_031.STEP_001, S030_031.STEP_005) and Flg.Check("FLAG_MAIN_22_010") then
        S030_031:Event_010()
      else
        Field.ObjectLoadMotion(PLAYER, 1, "e017")
        local tlk = Tlk:new("d04", 1, false)
        tlk:StartTalk()
        PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
        Field.ObjectPlayMotion(PLAYER, 1, "e017", 15, true)
        WaitFrame(10)
        tlk:Message("f_d0406_0010_0010")
        tlk:EndTalk()
        Field.ObjectResetMotion(PLAYER, 1, 20)
      end
    end
  end
  if gMapNum == 403 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 404 then
    if gim_name == "hazama_gate01" then
      print("====== gate_access ======")
      PlayerLookAtGimmickObject(gim_name)
      GoToHazamaWithEvt(gim)
    end
  elseif gMapNum == 405 and gim_name == "hazama_gate01" then
    print("====== gate_access ======")
    PlayerLookAtGimmickObject(gim_name)
    GoToHazamaWithEvt(gim)
  end
end

function OnFieldAttackLocatorObject(att_gim)
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 401 then
  end
  if gMapNum == 402 then
  end
  if gMapNum == 403 then
  end
  if gMapNum == 404 then
  end
  if gMapNum == 405 then
  end
end

function OnFieldAttackGimmick(att_gim)
  local gim_name = att_gim.unique_name
  local gim_tag = att_gim.tag
  local gim_id = att_gim.check_id
  local need_pow, need_ele = att_gim.need_power, att_gim.need_element
  local skill_pow, skill_ele = att_gim.skill_power, att_gim.skill_element
  print("gimName = ", gim_name, "gimID = ", gim_id, " map_prefix = ", gMapPrefix, " map_num = ", gMapNum)
  print("need_power = ", need_pow, " skill_power = ", skill_pow)
  print("need_element = ", need_ele, " skill_element = ", skill_ele)
  if gMapNum == 401 then
    if gim_tag == "fa_obj" then
      if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
        BreakFieldAttackGim(gim_name, true)
        if gim_name == "fa_obstacles_02" then
          Flg.Set("FLAG_GIMMICK_D04_050")
        end
      end
    elseif gim_tag == "fa_obj_ele" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_f0401_0040_0010") then
      BreakFieldAttackGim(gim_name, true)
      if gim_name == "fa_obstacles_05" then
        Flg.Set("FLAG_GIMMICK_D04_030")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0004"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0003"), 0, 0, false)
        M180:Event_090()
      end
      if gim_name == "fa_obstacles_07" then
        Flg.Set("FLAG_GIMMICK_D04_040")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0011"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0012"), 0, 0, false)
        M180:Event_093()
      end
      if gim_name == "fa_obstacles_06" then
        Flg.Set("FLAG_GIMMICK_D04_060")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0013"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0014"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_08" then
        Flg.Set("FLAG_GIMMICK_D04_070")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0007"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0008"), 0, 0, false)
        M180:Event_091()
      end
      if gim_name == "fa_obstacles_09" then
        Flg.Set("FLAG_GIMMICK_D04_080")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0009"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0010"), 0, 0, false)
      end
    end
  elseif gMapNum == 402 then
    if gim_tag == "fa_obj" then
      if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
        BreakFieldAttackGim(gim_name, true)
      end
    elseif gim_tag == "fa_obj_ele" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_f0401_0040_0010") then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 403 then
    if gim_tag == "fa_obj" then
      if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
        BreakFieldAttackGim(gim_name, true)
      end
    elseif gim_tag == "fa_obj_ele" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_f0401_0040_0010") then
      BreakFieldAttackGim(gim_name, true)
      if gim_name == "fa_obstacles_11" then
        Flg.Set("FLAG_GIMMICK_D04_090")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0001"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0002"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_12" then
        Flg.Set("FLAG_GIMMICK_D04_360")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0003"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0004"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_13" then
        Flg.Set("FLAG_GIMMICK_D04_361")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0005"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0006"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_14" then
        Flg.Set("FLAG_GIMMICK_D04_362")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0007"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0008"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_15" then
        Flg.Set("FLAG_GIMMICK_D04_363")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0009"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0010"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_16" then
        Flg.Set("FLAG_GIMMICK_D04_364")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0011"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0012"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_17" then
        Flg.Set("FLAG_GIMMICK_D04_365")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0013"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0016"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_18" then
        Flg.Set("FLAG_GIMMICK_D04_366")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0014"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0015"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_19" then
        Flg.Set("FLAG_GIMMICK_D04_367")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0017"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0018"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_20" then
        Flg.Set("FLAG_GIMMICK_D04_368")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0019"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0020"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_21" then
        Flg.Set("FLAG_GIMMICK_D04_369")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0021"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0022"), 0, 0, false)
      end
      if gim_name == "fa_obstacles_22" then
        Flg.Set("FLAG_GIMMICK_D04_370")
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0023"), 0, 0, false)
        Field.ObjectCancelInvisible(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "ride_whip_0024"), 0, 0, false)
      end
    end
  elseif gMapNum == 404 then
    if gim_tag == "fa_obj" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 405 then
    if gim_tag == "fa_obj" then
      if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
        BreakFieldAttackGim(gim_name, true)
        if gim_name == "fa_sub024_01" then
          require("S030_024")
          S030_024:Event_020()
        end
        if gim_name == "fa_sub024_02" then
          require("S030_024")
          S030_024:Event_021()
        end
        if gim_name == "fa_sub024_03" then
          require("S030_024")
          S030_024:Event_022()
        end
        if gim_name == "fa_sub024_04" then
          require("S030_024")
          S030_024:Event_023()
        end
        if gim_name == "fa_sub024_05" then
          require("S030_024")
          S030_024:Event_024()
        end
        if gim_name == "fa_sub024_06" then
          require("S030_024")
          S030_024:Event_025()
        end
        if gim_name == "fa_sub024_07" then
          require("S030_024")
          S030_024:Event_026()
        end
        if gim_name == "fa_sub024_08" then
          require("S030_024")
          S030_024:Event_027()
        end
        if gim_name == "fa_sub024_09" then
          require("S030_024")
          S030_024:Event_028()
        end
      end
    elseif gim_tag == "fa_obj_ele" and IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, "g_f0401_0040_0010") then
      BreakFieldAttackGim(gim_name, true)
    end
  elseif gMapNum == 407 and gim_tag == "fa_obj" then
    if gim_name == "fa_jureimon" then
      M180:Event_170()
    end
    if IsSatisfyFieldAttack(need_pow, need_ele, skill_pow, skill_ele, -1) then
      BreakFieldAttackGim(gim_name, false)
    end
  end
end

function OnCheckActModel(act)
end

function OnCheckLocatorWallAlong(wall_along)
  local start_loc = wall_along.locator
  if start_loc == "wall_along_0001" or start_loc == "wall_along_0002" then
    Field.SetFollowerCameraOperateRotationY(240)
  end
  Field.OperateStartLocatorWallAlong(start_loc)
end
