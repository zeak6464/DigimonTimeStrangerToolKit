gGimText = "field_text"

function Prcs_d0602_UnavailableAppearFloor()
  PlaySE(201012, 100)
  Motion.Gimmick:Play("obj_0001", "e001", false)
  Motion.Gimmick:Play("obj_0002", "e001", false)
  Motion.Gimmick:Play("obj_0003", "e001", false)
  gCollisionTable = {
    "plan_cl_1000",
    "plan_cl_1001",
    "plan_cl_1002",
    "plan_cl_1003",
    "plan_cl_1004"
  }
  ColOnWithTable(gCollisionTable)
  Flg.Set("FLAG_GIMMICK_D06_160")
end

function Prcs_d0602_AvailableAppearFloor()
  PlaySE(201013, 100)
  Motion.Gimmick:Play("obj_0001", "e003", false)
  Motion.Gimmick:Play("obj_0002", "e003", false)
  Motion.Gimmick:Play("obj_0003", "e003", false)
  gCollisionTable = {
    "plan_cl_1000",
    "plan_cl_1001",
    "plan_cl_1002",
    "plan_cl_1003",
    "plan_cl_1004"
  }
  ColOffWithTable(gCollisionTable)
  Flg.Clear("FLAG_GIMMICK_D06_160")
end

function Prcs_d0602_UnavailableAppearFloorEvent()
  Cam.Inst:Set(15.7, 7.9, 92.9, 8.8, 11.1, 99.5, default, 0)
  WaitFrame(30)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  PlaySE(201012, 100)
  Motion.Gimmick:Play("obj_0001", "e001", false)
  Motion.Gimmick:Play("obj_0002", "e001", false)
  Motion.Gimmick:Play("obj_0003", "e001", false)
  gCollisionTable = {
    "plan_cl_1000",
    "plan_cl_1001",
    "plan_cl_1002",
    "plan_cl_1003",
    "plan_cl_1004"
  }
  ColOnWithTable(gCollisionTable)
  Flg.Set("FLAG_GIMMICK_D06_160")
  Flg.Set("FLAG_GIMMICK_D06_270")
  WaitFrame(60)
  Cam.Inst:Set(-1.6, -1.2, 92.7, 0, 2, 102.1, default, 0)
  WaitFrame(20)
  Field.SetEnableGimmickCheck("gim_0001", true)
  Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
  Cam.Inst:Clear(0)
end

function Prcs_d0602_SecuritySwitchEvent()
  FadeOutWithWait(0, 20)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  Cam.Inst:Set(1.8, -1.3, -206.5, -1.4, 3.1, -198.2, default, 0)
  Field.ResetPlayer(-0.6, 0.2, -201.4, 20)
  Obj:new(NPC, "npc_0001"):CancelInvisible(nil, true)
  FadeInWithWait(0, 20)
  Prcs_d0602_RemoveSecurityEvent()
  Cam.Inst:Set(1.8, -1.3, -206.5, -1.4, 3.1, -198.2, default, 0)
  Cam.Inst:Set(11.9, 7.5, -200.1, 5.9, 10.7, -192.8, default, 30)
  WaitFrame(30)
  Cam.Inst:Set(1.8, -1.3, -206.5, -1.4, 3.1, -198.2, default, 0)
  FadeOutWithWait(0, 20)
  Common.DeleteGuest(27261)
  Field_CancelInvisibleFollowerAllGuest(0, 0, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 0, false, false)
  Obj:new(NPC, "npc_0001"):Invisible()
  Cam.Inst:Clear(0)
  FadeInWithWait(0, 20)
  Flg.Set("FLAG_GIMMICK_D06_140")
end

function Prcs_d0602_RemoveSecurityEvent()
  FadeOutWithWait(0, 20)
  Motion.Gimmick:Play("gim_0002", "e002", false)
  WaitFrame(30)
  FadeInWithWait(0, 20)
  Flg.Set("FLAG_GIMMICK_D06_190")
  WaitFrame(30)
  Motion.Gimmick:Play("obj_0001", "e002", false)
  Motion.Gimmick:Play("obj_0002", "e002", false)
  Cam.Inst:Set(-0.1, 5.7, -169.1, -0.1, 5.1, -159.1, default, 0)
  WaitFrame(1)
  Cam.Inst:Clear(500)
  WaitFrame(30)
  Motion.Gimmick:Play("obj_0003", "e002", false)
  WaitFrame(15)
  Cam.Inst:Set(14.8, 7.9, -220.6, 9.5, 12.5, -213.5, default, 0)
  Motion.Gimmick:Play("obj_0003", "e002", false)
  WaitFrame(15)
  PlaySE(201014, 100)
  WaitFrame(25)
  Cam.Inst:Set(-13.4, 8.5, -219.5, -8, 13.1, -212.4, default, 0)
  Motion.Gimmick:ResetFrame("obj_0003", "e002", 13, 13, 60, false)
  WaitFrame(5)
  Field.ResetPlayer(-0.6, 0.2, -201.4, 90)
  SetControlScriptExternalVariable("npc_ctrl_state", "rotate01")
  PlaySE(201014, 100)
  WaitFrame(80)
  Flg.Clear("FLAG_GIMMICK_D06_160")
  gCollisionTable = {
    "plan_cl_1000",
    "plan_cl_1001",
    "plan_cl_1002",
    "plan_cl_1003",
    "plan_cl_1004"
  }
  ColOffWithTable(gCollisionTable)
  Field.SetEnableGimmickCheck("gim_0002", false)
  SetProhibitDigimonRide(false)
end

function Prcs_d0603_WallChange(wall_array, col_array, is_appearance)
  if is_appearance == true then
    local slot = Sound.PlaySE(201011, 100)
  else
    local slot = Sound.PlaySE(201010, 100)
  end
  for i = 1, #wall_array do
    gim_index = GetIndex(OGIM, wall_array[i])
    col_index = GetIndex(OGIM, col_array[i])
    if is_appearance == true then
      Field.ObjectPlayMotion(OGIM, gim_index, "e002", 10, false)
      Field.ObjectCancelInvisible(OGIM, col_index, 0, 0, true, true)
    else
      Field.ObjectPlayMotion(OGIM, gim_index, "e001", 10, false)
      Field.ObjectInvisible(OGIM, col_index, 0, 0, true)
    end
  end
end

function Prcs_d0603_WallChangeInit(wall_array, col_array, is_appearance)
  for i = 1, #wall_array do
    gim_index = GetIndex(OGIM, wall_array[i])
    col_index = GetIndex(OGIM, col_array[i])
    if is_appearance == true then
      Motion.Object:PlayFinishedAnim(OGIM, gim_index, 0, "e002")
      Field.ObjectCancelInvisible(OGIM, col_index, 0, 0, true, true)
    else
      Motion.Object:PlayFinishedAnim(OGIM, gim_index, 0, "e001")
      Field.ObjectInvisible(OGIM, col_index, 0, 0, true)
    end
  end
end

function Prcs_d0603_CrumbleFloor_01()
  if not Flg.Check("FLAG_GIMMICK_D06_090") then
    Cam.Inst:Set(-8, 2.4, 89.7, -8, 4.4, 99.5, default, 25)
    WaitFrame(30)
    Motion.Gimmick:Play("obj_0001", "e001", false)
    PlaySE(201012, 100)
    PlayerPlayAttachmentAnimation(6, "e001", 0, true)
    Motion.Gimmick:WaitFrame("obj_0001", "e001", 0)
    Motion.Gimmick:Play("obj_0005", "e001", false)
    PlaySE(201010, 100)
    Motion.Gimmick:WaitFrame("obj_0005", "e001", 0)
    WaitFrame(40)
    Flg.Set("FLAG_GIMMICK_D06_090")
    Cam.Inst:Clear(25)
    WaitFrame(15)
  else
    PlaySE(201012, 100)
    PlaySE(201010, 100)
    PlayerPlayAttachmentAnimation(6, "e001", 0, true)
    Motion.Gimmick:Play("obj_0001", "e001", false)
    Motion.Gimmick:Play("obj_0005", "e001", false)
  end
  ColOn("wall_cl_1000")
  ColOn("wall_cl_1010")
  ColOn("wall_cl_1011")
  Flg.Set("FLAG_GIMMICK_D06_020")
end

function Prcs_d0603_CrumbleFloor_02()
  PlayerPlayAttachmentAnimation(6, "e001", 0, true)
  Motion.Gimmick:Play("obj_0002", "e001", false)
  Motion.Gimmick:Play("obj_0006", "e001", false)
  PlaySE(201012, 100)
  PlaySE(201010, 100)
  gCollisionTable = {
    "wall_cl_1001",
    "wall_cl_1002",
    "wall_cl_1003",
    "wall_cl_1004",
    "wall_cl_1008",
    "wall_cl_1009"
  }
  ColOnWithTable(gCollisionTable)
  Flg.Set("FLAG_GIMMICK_D06_030")
end

function Prcs_d0603_CrumbleFloor_03()
  PlayerPlayAttachmentAnimation(6, "e001", 0, true)
  Motion.Gimmick:Play("obj_0003", "e001", false)
  Motion.Gimmick:Play("obj_0007", "e001", false)
  PlaySE(201012, 100)
  PlaySE(201010, 100)
  ColOn("wall_cl_1005")
  ColOn("wall_cl_1006")
  ColOn("wall_cl_1012")
  Flg.Set("FLAG_GIMMICK_D06_040")
end

function Prcs_d0603_ResetCrumbleFloor_01()
  if not Flg.Check("FLAG_GIMMICK_D06_220") then
    Cam.Inst:Set(-20.1, 2.2, 79.9, -27.4, 1.6, 86.8, default, 0)
    Field_InvisibleFollowerAllGuest(0, 10, false)
    Field_InvisibleFollowerAllPartyMember(0, 10, false)
    WaitFrame(15)
    PlaySE(201013, 100)
    PlayerPlayAttachmentAnimation(6, "e002", 0, true)
    Flg.Clear("FLAG_GIMMICK_D06_020")
    Flg.Set("FLAG_GIMMICK_D06_220")
    WaitFrame(20)
    PlaySE(201011, 100)
    Motion.Gimmick:Play("obj_0001", "e002", false)
    Motion.Gimmick:Play("obj_0005", "e002", false)
    Motion.Gimmick:WaitFrame("obj_0005", "e002", 0)
    ColOff("wall_cl_1000")
    ColOff("wall_cl_1010")
    ColOff("wall_cl_1011")
    WaitFrame(20)
    Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
    Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
    Cam.Inst:Clear(25)
  else
    Flg.Clear("FLAG_GIMMICK_D06_020")
    PlaySE(201013, 100)
    PlaySE(201011, 100)
    PlayerPlayAttachmentAnimation(6, "e002", 0, true)
    Motion.Gimmick:Play("obj_0001", "e002", false)
    Motion.Gimmick:Play("obj_0005", "e002", false)
    ColOff("wall_cl_1000")
    ColOff("wall_cl_1010")
    ColOff("wall_cl_1011")
  end
end

function Prcs_d0603_ResetCrumbleFloor()
  Flg.Clear("FLAG_GIMMICK_D06_020")
  PlaySE(201013, 100)
  PlaySE(201011, 100)
  PlayerPlayAttachmentAnimation(6, "e002", 0, true)
  Motion.Gimmick:Play("obj_0001", "e002", false)
  Motion.Gimmick:Play("obj_0005", "e002", false)
  ColOff("wall_cl_1000")
  ColOff("wall_cl_1010")
  ColOff("wall_cl_1011")
end

function Prcs_d0603_ResetCrumbleFloor_02()
  PlayerPlayAttachmentAnimation(6, "e002", 0, true)
  Motion.Gimmick:Play("obj_0002", "e002", false)
  Motion.Gimmick:Play("obj_0006", "e002", false)
  PlaySE(201013, 100)
  PlaySE(201011, 100)
  gCollisionTable = {
    "wall_cl_1001",
    "wall_cl_1002",
    "wall_cl_1003",
    "wall_cl_1004",
    "wall_cl_1008",
    "wall_cl_1009"
  }
  ColOffWithTable(gCollisionTable)
  Flg.Clear("FLAG_GIMMICK_D06_030")
end

function Prcs_d0603_ResetCrumbleFloor_03()
  PlayerPlayAttachmentAnimation(6, "e002", 0, true)
  Motion.Gimmick:Play("obj_0003", "e002", false)
  Motion.Gimmick:Play("obj_0007", "e002", false)
  ColOff("wall_cl_1005")
  ColOff("wall_cl_1006")
  ColOff("wall_cl_1012")
  PlaySE(201013, 100)
  PlaySE(201011, 100)
  Flg.Clear("FLAG_GIMMICK_D06_040")
end

function Prcs_d0603_ChangeWallGim_01()
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field.MovePlayerToLocatorFrame("sp_0002", 10)
  WaitFrame(10)
  SetPlayerRotationToLocator("gim_0006", 5)
  WaitFrame(5)
  if not Flg.Check("FLAG_GIMMICK_D06_240") then
    Motion.Player:Play("fg11_d01", 0, false)
    Motion.Gimmick:Play("gim_0006", "e001", false)
    WaitFrame(13)
    PlaySE(200015, 100)
  else
    Motion.Player:Play("fg11_u01", 0, false)
    Motion.Gimmick:Play("gim_0006", "e002", false)
    WaitFrame(15)
    PlaySE(200015, 100)
  end
  WaitFrame(40)
  Cam.Inst:Set(-3.4, 4.6, 79.7, 2.8, 7.5, 87.6, default, 0)
  WaitFrame(50)
  if not Flg.Check("FLAG_GIMMICK_D06_240") then
    Motion.Gimmick:Play("obj_0009", "e001", false)
    Motion.Gimmick:Play("obj_0010", "e001", false)
    Motion.Gimmick:Play("obj_0011", "e001", false)
    ColOff("wall_cl_2001")
    ColOff("wall_cl_2002")
    ColOff("wall_cl_2003")
    WaitFrame(20)
    if not Flg.Check("FLAG_GIMMICK_D06_060") then
      Prcs_d0603_CrumbleFloor_01()
    end
    WaitFrame(40)
    Motion.Gimmick:Play("obj_0008", "e002", false)
    ColOn("wall_cl_2000")
    Flg.Set("FLAG_GIMMICK_D06_020")
    Flg.Set("FLAG_GIMMICK_D06_240")
  else
    Motion.Gimmick:Play("obj_0009", "e002", false)
    Motion.Gimmick:Play("obj_0010", "e002", false)
    Motion.Gimmick:Play("obj_0011", "e002", false)
    ColOn("wall_cl_2001")
    ColOn("wall_cl_2002")
    ColOn("wall_cl_200")
    WaitFrame(20)
    if not Flg.Check("FLAG_GIMMICK_D06_060") then
      Prcs_d0603_ResetCrumbleFloor_01()
    end
    WaitFrame(40)
    Motion.Gimmick:Play("obj_0008", "e001", false)
    ColOff("wall_cl_2000")
    Flg.Clear("FLAG_GIMMICK_D06_240")
  end
  WaitFrame(80)
  Cam.Inst:Clear(0)
  WaitFrame(5)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetProhibitDigimonRide(false)
end

function Prcs_d0603_ChangeWallGim_02()
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field.MovePlayerToLocatorFrame("sp_0003", 10)
  WaitFrame(10)
  SetPlayerRotationToLocator("gim_0007", 5)
  WaitFrame(5)
  if not Flg.Check("FLAG_GIMMICK_D06_250") then
    Motion.Player:Play("fg11_d01", 0, false)
    Motion.Gimmick:Play("gim_0007", "e001", false)
    WaitFrame(13)
    PlaySE(200015, 100)
  else
    Motion.Player:Play("fg11_u01", 0, false)
    Motion.Gimmick:Play("gim_0007", "e002", false)
    WaitFrame(15)
    PlaySE(200015, 100)
  end
  WaitFrame(40)
  Cam.Inst:Set(-21.8, 3.7, 16.7, -26.8, 3, 25.4, default, 0)
  WaitFrame(40)
  if not Flg.Check("FLAG_GIMMICK_D06_250") then
    Motion.Gimmick:Play("obj_0016", "e002", false)
    WaitFrame(25)
    Motion.Gimmick:Play("obj_0013", "e002", false)
    Motion.Gimmick:Play("obj_0014", "e002", false)
    Motion.Gimmick:Play("obj_0012", "e002", false)
    Motion.Gimmick:Play("obj_0015", "e002", false)
    gCollisionTable = {
      "wall_cl_2004",
      "wall_cl_2005",
      "wall_cl_2006",
      "wall_cl_2007",
      "wall_cl_2008"
    }
    ColOnWithTable(gCollisionTable)
    Flg.Set("FLAG_GIMMICK_D06_250")
  else
    Motion.Gimmick:Play("obj_0013", "e001", false)
    Motion.Gimmick:Play("obj_0014", "e001", false)
    Motion.Gimmick:Play("obj_0012", "e001", false)
    Motion.Gimmick:Play("obj_0015", "e001", false)
    WaitFrame(25)
    Motion.Gimmick:Play("obj_0016", "e001", false)
    gCollisionTable = {
      "wall_cl_2004",
      "wall_cl_2005",
      "wall_cl_2006",
      "wall_cl_2007",
      "wall_cl_2008"
    }
    ColOffWithTable(gCollisionTable)
    Flg.Clear("FLAG_GIMMICK_D06_250")
  end
  WaitFrame(70)
  Cam.Inst:Clear(0)
  WaitFrame(5)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetProhibitDigimonRide(false)
end

function Prcs_d0603_ChangeWallGim_03()
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field.MovePlayerToLocatorFrame("sp_0001", 10)
  WaitFrame(15)
  SetPlayerRotationToLocator("gim_0008", 5)
  WaitFrame(5)
  if not Flg.Check("FLAG_GIMMICK_D06_260") then
    Motion.Player:Play("fg11_d01", 0, false)
    Motion.Gimmick:Play("gim_0008", "e001", false)
    WaitFrame(13)
    PlaySE(200015, 100)
  else
    Motion.Player:Play("fg11_u01", 0, false)
    Motion.Gimmick:Play("gim_0008", "e002", false)
    WaitFrame(15)
    PlaySE(200015, 100)
  end
  WaitFrame(40)
  Cam.Inst:Set(-4.1, 4, -105.2, -11.5, 5.8, -111.6, default, 0)
  WaitFrame(30)
  if not Flg.Check("FLAG_GIMMICK_D06_260") then
    Motion.Gimmick:Play("obj_0019", "e001", false)
    Motion.Gimmick:Play("obj_0020", "e001", false)
    Motion.Gimmick:Play("obj_0021", "e001", false)
    ColOff("wall_cl_2011")
    ColOff("wall_cl_2012")
    ColOff("wall_cl_2013")
    WaitFrame(20)
    if not Flg.Check("FLAG_GIMMICK_D06_080") then
      Prcs_d0603_CrumbleFloor_03()
    end
    WaitFrame(40)
    Motion.Gimmick:Play("obj_0017", "e002", false)
    Motion.Gimmick:Play("obj_0018", "e002", false)
    ColOn("wall_cl_2009")
    ColOn("wall_cl_2010")
    Flg.Set("FLAG_GIMMICK_D06_260")
  else
    Motion.Gimmick:Play("obj_0017", "e001", false)
    Motion.Gimmick:Play("obj_0018", "e001", false)
    ColOff("wall_cl_2009")
    ColOff("wall_cl_2010")
    WaitFrame(20)
    if not Flg.Check("FLAG_GIMMICK_D06_080") then
      Prcs_d0603_ResetCrumbleFloor_03()
    end
    WaitFrame(40)
    Motion.Gimmick:Play("obj_0019", "e002", false)
    Motion.Gimmick:Play("obj_0020", "e002", false)
    Motion.Gimmick:Play("obj_0021", "e002", false)
    ColOn("wall_cl_2011")
    ColOn("wall_cl_2012")
    ColOn("wall_cl_2013")
    Flg.Clear("FLAG_GIMMICK_D06_260")
  end
  WaitFrame(70)
  Cam.Inst:Clear(0)
  WaitFrame(5)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetProhibitDigimonRide(false)
end

function Prcs_d0603_DisableEyeGim_01()
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllGuest(0, 0, false)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  PlayerCheckGimmick("gim_0001", 15, "fg07_m01", 10, false)
  WaitFrame(30)
  Motion.Gimmick:Play("gim_0001", "e002", false)
  WaitFrame(30)
  WaitFrame(10)
  Cam.Inst:Set(-8.2, 5.3, 76.5, -3.1, 4.7, 67, default, 0)
  WaitFrame(15)
  Motion.Gimmick:Play("obj_0005", "e002", false)
  Motion.Gimmick:Play("obj_0001", "e003", false)
  WaitFrame(50)
  PlaySE(201014, 100)
  WaitFrame(35)
  Cam.Inst:Set(2.6, -1.4, 61.3, -1.7, 3.1, 69, default, 0)
  Flg.Set("FLAG_GIMMICK_D06_060")
  ColOff("wall_cl_1000")
  ColOff("wall_cl_1010")
  ColOff("wall_cl_1011")
  Cam.Inst:Clear(0)
  Field.SetEnableGimmickCheck("gim_0001", false)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetProhibitDigimonRide(false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0001"), false)
end

function Prcs_d0603_DisableEyeGim_02()
  Flg.Set("FLAG_GIMMICK_D06_070")
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  PlayerCheckGimmick("gim_0002", 15, "fg07_m01", 10, false)
  WaitFrame(30)
  Motion.Gimmick:Play("gim_0002", "e002", false)
  WaitFrame(30)
  Motion.Gimmick:PlayFinishedAnim("obj_0002", "e001")
  WaitFrame(10)
  Cam.Inst:Set(-8, 4.6, 12.9, -8, 4, 22.9, default, 0)
  WaitFrame(15)
  Motion.Gimmick:Play("obj_0002", "e003", false)
  WaitFrame(50)
  PlaySE(201014, 100)
  WaitFrame(35)
  Cam.Inst:Clear(0)
  WaitFrame(5)
  Field.SetEnableGimmickCheck("gim_0002", false)
  gCollisionTable = {
    "wall_cl_1001",
    "wall_cl_1002",
    "wall_cl_1003",
    "wall_cl_1004",
    "wall_cl_1008",
    "wall_cl_1009"
  }
  ColOffWithTable(gCollisionTable)
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetProhibitDigimonRide(false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0002"), false)
end

function Prcs_d0603_DisableEyeGim_03()
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Flg.Set("FLAG_GIMMICK_D06_080")
  PlayerCheckGimmick("gim_0003", 15, "fg07_m01", 10, false)
  WaitFrame(30)
  Motion.Gimmick:Play("gim_0003", "e002", false)
  WaitFrame(30)
  Motion.Gimmick:PlayFinishedAnim("obj_0003", "e001")
  WaitFrame(10)
  Cam.Inst:Set(0, 4.6, -98.9, 0, 4, -88.9, default, 0)
  WaitFrame(15)
  Motion.Gimmick:Play("obj_0003", "e003", false)
  WaitFrame(50)
  PlaySE(201014, 100)
  WaitFrame(35)
  Cam.Inst:Clear(0)
  WaitFrame(5)
  Field.SetEnableGimmickCheck("gim_0003", false)
  ColOff("wall_cl_1005")
  ColOff("wall_cl_1006")
  Field_CancelInvisibleFollowerAllGuest(0, 10, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetProhibitDigimonRide(false)
  Field.ObjectSetEnableCheckAndFieldAttack(FLD_OBJ_LOCATOR, GetIndex(FLD_OBJ_LOCATOR, "gim_0003"), false)
end

function Prcs_d0604_OpenPrisonDoorEvent()
  SetProhibitDigimonRide(true)
  SetPlayerRotationToLocator("gim_0002", 10)
  WaitFrame(5)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  Motion.Gimmick:Play("gim_0002", "e001", false)
  WaitFrame(10)
  PlaySE(200002, 100)
  WaitFrame(60)
  Fade.Out(0, 0.4)
  WaitFrame(24)
  Cam.Inst:Set(43.9, -11.5, 5.5, 44, -8.6, 15, default, 0)
  Fade.In(0, 0.4)
  WaitFrame(30)
  WaitFrame(30)
  for i = 1, 4 do
    Motion.Gimmick:Play("obj_00" .. string.format("%02d", i), "e001", false)
  end
  for i = 8, 10 do
    Motion.Gimmick:Play("obj_00" .. string.format("%02d", i), "e001", false)
  end
  PlaySE(200003, 100)
  WaitFrame(10)
  Cam.Inst:Set(52.2, -13.3, -15.4, 44.3, -8.7, -11.3, default, 0)
  WaitFrame(60)
  Cam.Inst:Set(36.6, -13, -15.9, 44.1, -8.8, -10.8, default, 0)
  PlaySE(200003, 100)
  for i = 5, 9 do
    Motion.Gimmick:Play("obj_00" .. string.format("%02d", i), "e001", false)
  end
  ColOffWithTable(COL0604_01)
  WaitFrame(80)
  Flg.Set("FLAG_GIMMICK_D06_110")
  FadeOutWithWait(0, 20)
  Cam.Inst:Clear(0)
  Field.SetEnableGimmickCheck("gim_0002", false)
  Field_InvisibleFollowerAllPartyMember(0, 0, false)
  ColOff("evt_9000")
  ColOff("evt_9001")
  ColOff("evt_9002")
  ColOff("evt_9003")
  Field.CheckSymbolEnemyCondition(true)
  SetEnableGimmickCheck("gim_0004", true)
  WaitFrame(30)
  FadeInWithWait(0, 20)
  Flg.Set("FLAG_GIMMICK_D06_190")
  Field_CancelInvisibleFollowerAllPartyMember(0, 10, false, false)
  SetProhibitDigimonRide(false)
end

function Prcs_d0604_410_OpenPrisonDoorEvent()
  Obj:new(OGIM, "obj_lattice04"):Invisible()
  Obj:new(OGIM, "obj_lattice05"):Invisible()
  Obj:new(OGIM, "obj_lattice06"):Invisible()
  Obj:new(OGIM, "col_lattice04"):Invisible()
  Obj:new(OGIM, "col_lattice05"):Invisible()
  Obj:new(OGIM, "col_lattice06"):Invisible()
  Cam.Inst:Set(43.9, -11.5, 5.5, 44, -8.6, 15, default, 0)
  Fade.In(0, 0.4)
  WaitFrame(30)
  WaitFrame(30)
  for i = 8, 10 do
    Motion.Gimmick:Play("obj_00" .. string.format("%02d", i), "e001", false)
  end
  PlaySE(200003, 100)
  WaitFrame(10)
  Cam.Inst:Set(52.2, -13.3, -15.4, 44.3, -8.7, -11.3, default, 0)
  WaitFrame(60)
  Cam.Inst:Set(36.6, -13, -15.9, 44.1, -8.8, -10.8, default, 0)
  PlaySE(200003, 100)
  for i = 5, 9 do
    Motion.Gimmick:Play("obj_00" .. string.format("%02d", i), "e001", false)
  end
  ColOff("wall_cl_1014")
  ColOff("wall_cl_1015")
  ColOff("wall_cl_1016")
  ColOff("wall_cl_1017")
  ColOff("wall_cl_1018")
  ColOff("wall_cl_1019")
  WaitFrame(60)
  Cam.Inst:Set(43.9, -13.2, 22, 44, -12.2, 12, default, 30)
  WaitFrame(30)
  local se_slot = PlaySE(201009, 100)
  Motion.Gimmick:Play("gim_0009", "e001", false)
  ColOff("wall_cl_1024")
  ColOn("wall_cl_1025")
  ColOn("wall_cl_1026")
  Motion.Gimmick:WaitFrame("gim_0009", "e001", 0)
  StopSE(se_slot, 30)
  PlaySE(201019, 100)
  Flg.Set("FLAG_GIMMICK_D06_290")
  WaitFrame(30)
  ColOff("wall_cl_1011")
  ColOff("wall_cl_1012")
  ColOff("wall_cl_1013")
  Cam.Inst:Set(43.37, -13.2, 33.54, 43.82, -12.2, 23.74, default, 30)
  WaitFrame(30)
  PlaySE(200003, 100)
  WaitFrame(10)
  for i = 2, 4 do
    Motion.Gimmick:Play("obj_00" .. string.format("%02d", i), "e001", false)
  end
  PlaySE(200003, 100)
  WaitFrame(60)
  Flg.Set("FLAG_GIMMICK_D06_180")
  Fade_OutNoLoadingWithWait(FADE_BLACK, FADE_TIME)
  WaitFrame(5)
  Cam.Inst:Clear(0)
  WaitFrame(10)
  FadeInWithWaitNotFlgCheck(FADE_BLACK, FADE_TIME)
  SetProhibitDigimonRide(false)
end

function Prcs_d0604_410_CloseUnderPrison()
  Flg.Set("FLAG_GIMMICK_D06_210")
  FieldObjectSync(OGIM, false)
  Obj:new(FLD_OBJ_GIMMICK, "col_lattice01"):CancelInvisible()
  Obj:new(FLD_OBJ_GIMMICK, "col_lattice02"):CancelInvisible()
  Obj:new(FLD_OBJ_GIMMICK, "col_lattice03"):CancelInvisible()
  Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_lattice01"), 0, "e001")
  Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_lattice02"), 0, "e001")
  Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_lattice03"), 0, "e001")
  Motion.Object:PlayFinishedAnim(FLD_OBJ_GIMMICK, GetIndex(FLD_OBJ_GIMMICK, "obj_switch02"), 0, "e001")
  PlaySE(200003, 100)
  WaitFrame(30)
end

function Prcs_d0609_Restart()
  Field.ObjectLoadMotion(PLAYER, 1, "bl01")
  PlaySE(300201, 100)
  Field.ObjectPlayMotionAndSetting(PLAYER, 1, "bd01", 0, 0, 0, 17, 1, false)
  WaitFrame(17)
  Field.ObjectPlayMotionAndSetting(PLAYER, 1, "bl01", 5, 12, 12, 120, 0.8, false)
  WaitFrame(20)
  BackFade_OutNoLoading(FADE_BLACK, FADE_TIME)
  WaitFrame(15)
  local tlk = Tlk:new("d06", 1, true)
  tlk:StartTalk()
  tlk:Message("f_d0609_0010_0010")
  tlk:EndTalk()
  for num = 1, 14 do
    local gim_name = "trap" .. string.format("%02d", num)
    local index = GetIndex(OGIM, gim_name)
    Field.ObjectCancelBroke(OGIM, index, false)
  end
  Motion.Player:ResetMoveAnim()
  Flg.Clear("FLAG_FIELD_D0609_010")
  Flg.Clear("FLAG_FIELD_D0609_020")
  Flg.Clear("FLAG_FIELD_D0609_030")
  Flg.Clear("FLAG_FIELD_D0609_040")
  WaitFrame(15)
  Flg.Set("FLAG_SKIP_AREACHANGE_MOVE")
  MapChange("d", 609, "start_00", false, 0, 0)
end

function Prcs_d0609_Restart2()
  Field.OpenGameOver()
end

function Prcs_d0609_BossCam()
  Cam.Inst:Set(-169.875, 1.03, -1.288, -161.834, 1.007, -9.811, default, 15)
  Flg.Set("FLAG_FIELD_D0609_040")
  Field.ObjectSetEnableCheckAndFieldAttack(ENEMY, GetIndex(ENEMY, "enemy_Grankuwaga02"), true)
  Digitter.Send(3060500, false, true)
  M190:Event_015()
end

function M190_Event_020()
  local enemy = GetIndex(ENEMY, "enemy_Grankuwaga01")
  Field.ObjectLoadMotion(ENEMY, enemy, "bd01")
  Field.ObjectLoadMotion(ENEMY, enemy, "bn01")
  Field.ObjectPlayMotionWithStartMoveMotion(ENEMY, enemy, "bd01", 10, 10)
  WaitFrame(20)
  M190:Event_020()
end

function Prcs_d0607_M420_01(speed)
  Field.ObjectLoadMotion(PLAYER, 1, "e502")
  Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
  local rotY = Field.ObjectGetRotationY(PLAYER, 1)
  Field.MovePlayerFrame(rotY, speed, 7)
  Fade_OutNoLoading(FADE_WHITE, 3)
  WaitFrame(9)
  Sound.StopBGM(1)
  Field.PlayerFixedMaxSpeed(5)
  Field.ObjectPlayMotion(PLAYER, 1, "e502", 15, true)
  WaitFrame(1)
  FadeAllIn(FADE_WHITE, 3)
  PlaySE(404003, 100)
  WaitFrame(60)
  SetControlScriptExternalVariable("PlayVoice_m420_015_010", "play")
  WaitFrame(30)
  Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 15, true)
  WaitFrame(15)
end

function Prcs_d0607_M420_02(speed)
  Field.ObjectLoadMotion(PLAYER, 1, "e502")
  Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
  local rotY = Field.ObjectGetRotationY(PLAYER, 1)
  Field.MovePlayerFrame(rotY, speed, 7)
  Fade_OutNoLoading(FADE_WHITE, 3)
  WaitFrame(9)
  Field.PlayerFixedMaxSpeed(2)
  Field.ObjectPlayMotion(PLAYER, 1, "e502", 15, true)
  WaitFrame(1)
  FadeAllIn(FADE_WHITE, 3)
  PlaySE(404003, 100)
  WaitFrame(90)
  SetControlScriptExternalVariable("PlayVoice_m420_015_030", "play")
  WaitFrame(30)
  Field.ObjectPlayMotion(PLAYER, 1, "fn01_01", 15, true)
  WaitFrame(15)
end

function Prcs_d0607_M420_03(speed)
  Field.ObjectLoadMotion(PLAYER, 1, "e011")
  Field.ObjectLoadMotion(PLAYER, 1, "e081")
  Field.ObjectLoadMotion(PLAYER, 1, "fn01_01")
  local rotY = Field.ObjectGetRotationY(PLAYER, 1)
  Field.MovePlayerFrame(rotY, speed, 7)
  Fade_OutNoLoading(FADE_WHITE, 3)
  WaitFrame(9)
  Field.ObjectPlayMotion(PLAYER, 1, "e011", 15, true)
  WaitFrame(1)
  FadeAllIn(FADE_WHITE, 3)
  PlaySE(404003, 100)
  WaitFrame(30)
  SetControlScriptExternalVariable("PlayVoice_m420_015_050", "play")
  WaitFrame(68)
  Field.ObjectPlayMotion(PLAYER, 1, "e081", 15, true)
  WaitFrame(60)
  SetControlScriptExternalVariable("Prcs_d0607_M420_04", "play")
end

function M420_Event_027()
  M420:Event_027()
end

function M420_Event_028()
  M420:Event_028()
end

function Prcs_d06_UnlockDoor(door_loc, check_loc1, check_loc2, cl_name, anime_name, aim_x, aim_y, aim_z, cam_x, cam_y, cam_z)
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  SetPlayerRotationToLocator(door_loc, 10)
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 30)
  WaitFrame(30)
  local se_slot = PlaySE(201009, 100)
  Motion.Gimmick:Play(door_loc, anime_name, false)
  ColOff(cl_name)
  Motion.Gimmick:WaitFrame(door_loc, anime_name, 0)
  StopSE(se_slot, 30)
  PlaySE(201019, 100)
  Field.SetEnableGimmickCheck(check_loc1, false)
  Field.SetEnableGimmickCheck(check_loc2, false)
  SetProhibitDigimonRide(false)
  Cam.Inst:Clear(30)
  WaitFrame(30)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d06_UnlockDoor_Gimmick(gim_name, col_name, anime_name, aim_x, aim_y, aim_z, cam_x, cam_y, cam_z)
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  Cam.Inst:Set(aim_x, aim_y, aim_z, cam_x, cam_y, cam_z, default, 30)
  WaitFrame(30)
  local se_slot = PlaySE(201009, 100)
  Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name), anime_name, 0, false)
  Obj:new(FLD_OBJ_GIMMICK, col_name):Invisible()
  local wait_f = Field.ObjectGetMotionDefaultEndFrame(OGIM, GetIndex(OGIM, gim_name), anime_name)
  WaitFrame(wait_f)
  StopSE(se_slot, 30)
  PlaySE(201019, 100)
  SetProhibitDigimonRide(false)
  Cam.Inst:Clear(30)
  WaitFrame(30)
  Field_CancelInvisibleFollowerAllPartyMember(0, 30, false, true)
  Field_CancelInvisibleFollowerAllGuest(0, 30, false, true)
end

function Prcs_d06_DoorSwitch_Gimmick(gim_name, tag_x, tag_z)
  SetProhibitDigimonRide(true)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  local index = GetIndex(OGIM, gim_name)
  Field.ObjectAdjustSpeedFrameMoveToTargetPos2D(PLAYER, 1, tag_x, tag_z, 30)
  WaitFrame(30)
  PlayerTurnToObject(OGIM, gim_name, true, false, 0, 0)
  Motion.Player:Play("fg11_d01", 0, false)
  Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name), "e001", 0, false)
  WaitFrame(13)
  PlaySE(200015, 100)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, gim_name), false)
  WaitFrame(30)
end

function Prcs_d06_LockDoor(text, message)
  local tlk = Tlk:new(text, 1, true)
  tlk:StartTalk()
  tlk:Message(message)
  tlk:EndTalk()
end

function Prcs_d06_PrisonSwitch(gim_name)
  Field_InvisibleFollowerAllPartyMember(0, 10, false)
  Field_InvisibleFollowerAllGuest(0, 10, false)
  SetProhibitDigimonRide(true)
  PlayerTurnToObject(FLD_OBJ_GIMMICK, gim_name, true, false, 0, 0)
  Motion.Player:Play("fg07_m01", 0, false)
  WaitFrame(15)
  PlaySE(201014, 100)
  WaitFrame(15)
  Field.ObjectSetEnableCheckAndFieldAttack(OGIM, GetIndex(OGIM, gim_name), false)
  Field.ObjectPlayMotion(OGIM, GetIndex(OGIM, gim_name), "e002", 0, false)
  SetProhibitDigimonRide(false)
end
