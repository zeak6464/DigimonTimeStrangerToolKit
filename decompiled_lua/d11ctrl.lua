require("function_control")
DEFINE_FLAG("FLAG_MAIN_07_057")
DEFINE_FLAG("FLAG_MAIN_07_059")
DEFINE_FLAG("FLAG_MAIN_03_060")
DEFINE_FLAG("FLAG_MAIN_03_065")
DEFINE_FLAG("FLAG_FIELD_D11_014")
DEFINE_FLAG("FLAG_MAIN_03_400")
DEFINE_FLAG("FLAG_MAIN_03_430")
DEFINE_FLAG("FLAG_FIELD_D11_BSEnd")
gMapPrefix, gMapNum, gPlanData, gRailMoveFile = "", 0, "", ""

function LoadRequest()
  print("=============== LoadRequest =====================")
  gMapPrefix, gMapNum = GetMapPrefix(), GetMapNumber()
  gPlanData = gMapPrefix .. string.format("%04d", gMapNum) .. "p"
  gRailMoveFile = gMapPrefix .. string.format("%04d", gMapNum) .. "_railmove"
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  LoadLocatorModel(gPlanData)
  LoadRailMove(gRailMoveFile)
  if gMapNum == 1101 then
    local elecmon = GetIndex(NPC, "npc_elecmon")
    Npc(elecmon).LoadMoveMotion("")
  elseif gMapNum == 1102 then
  elseif gMapNum == 1103 then
    LoadEffectScript("ef_e_com_115", 5)
  elseif gMapNum == 1104 then
    local railmove_digimon_1 = GetIndex(MOB, "railmove_digimon_1")
    local railmove_digimon_2 = GetIndex(MOB, "railmove_digimon_2")
    local railmove_digimon_3 = GetIndex(MOB, "railmove_digimon_3")
    Mob(railmove_digimon_1).LoadMotion("br01")
    Mob(railmove_digimon_2).LoadMotion("br01")
    Mob(railmove_digimon_3).LoadMotion("br01")
    local railmove_raramon_1 = GetIndex(MOB, "railmove_raramon_1")
    local railmove_raramon_2 = GetIndex(MOB, "railmove_raramon_2")
    local railmove_raramon_3 = GetIndex(MOB, "railmove_raramon_3")
  end
end

function Initialize()
  print("=============== Initialize =====================")
  print("====== map_prefix = ", gMapPrefix, " ====== map_num = ", gMapNum, " ======")
  SetExternalVariable("player_state", "Initialize")
  local start_loc = GetLastPlayerSetLocator()
  local player_state = GetExternalVariable("player_state")
  if gMapNum == 1101 then
    gWaitCount = 0
  elseif gMapNum == 1102 then
    gWaitCount = 0
  elseif gMapNum == 1103 then
    gWaitCount = 0
  elseif gMapNum == 1104 then
    local railmove_digimon_1 = GetIndex(MOB, "railmove_digimon_1")
    local railmove_digimon_2 = GetIndex(MOB, "railmove_digimon_2")
    local railmove_digimon_3 = GetIndex(MOB, "railmove_digimon_3")
    Mob(railmove_digimon_1).LinkToRailMove("d1104_railmove", "rail_move_020")
    Mob(railmove_digimon_1).SetRailMoveInDimension3d()
    Mob(railmove_digimon_1).SetRailMoveSpeed(6)
    Mob(railmove_digimon_2).LinkToRailMove("d1104_railmove", "rail_move_021")
    Mob(railmove_digimon_2).SetRailMoveInDimension3d()
    Mob(railmove_digimon_2).SetRailMoveSpeed(6)
    Mob(railmove_digimon_3).LinkToRailMove("d1104_railmove", "rail_move_022")
    Mob(railmove_digimon_3).SetRailMoveInDimension3d()
    Mob(railmove_digimon_3).SetRailMoveSpeed(6)
    SetExternalVariable("railmove_digimon_state_1", "Initialize")
    SetExternalVariable("railmove_digimon_state_2", "Initialize")
    SetExternalVariable("railmove_digimon_state_3", "Initialize")
    local railmove_raramon_1 = GetIndex(MOB, "railmove_raramon_1")
    local railmove_raramon_2 = GetIndex(MOB, "railmove_raramon_2")
    local railmove_raramon_3 = GetIndex(MOB, "railmove_raramon_3")
    gRaramonWaitCount_1 = 0
    gRaramonWaitCount_2 = 0
    gRaramonWaitCount_3 = 0
    SetExternalVariable("railmove_raramon_state_1", "Initialize")
    SetExternalVariable("railmove_raramon_state_2", "Initialize")
    SetExternalVariable("railmove_raramon_state_3", "Initialize")
  end
end

function PreparationBeforeReactionToField()
  if gMapNum == 1101 then
  elseif gMapNum == 1102 then
  elseif gMapNum == 1103 then
  end
end

function Update(elapsed_frame)
  if GetExternalVariable("theater_state") == "play" then
    local theater_loc = string.sub(GetExternalVariable("theater_place"), 10)
    local start_loc = string.sub(GetExternalVariable("theater_place"), 1, 8)
    TheaterDoorCam(theater_loc, start_loc, elapsed_frame)
  else
    for i = 1, 2 do
      local theater = GetIndex(GIM, "theater_00" .. string.format("%02d", i))
      if theater ~= nil and LocatorObject(theater).IsPlayingMotion("e001") == false then
        LocatorObject(theater).LoadMotion("e001")
        LocatorObject(theater).Motion_PlayMotion("e001", 0, true)
      end
    end
  end
  local player_state = GetExternalVariable("player_state")
  local shadow_state = GetExternalVariable("shadow_state")
  local index = GetIndex(ENEMY, "shadow")
  if gMapNum == 1101 then
    if FlagCheck(FLAG_MAIN_03_060) and not FlagCheck(FLAG_MAIN_03_065) then
      local elecmon = GetIndex(NPC, "npc_elecmon")
      local elecmon_state = GetExternalVariable("elecmon_state")
      local elecmon_pos = GetExternalVariable("elecmon_pos")
      if elecmon_state == "escape_to1" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_200")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to2" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_100")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to3" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_201")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to4" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_101")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).Physics_SetCollisionContactForNotHit()
        Npc(elecmon).Physics_SetGravity(0)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "escape_to5")
        end
      elseif elecmon_state == "escape_to5" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_102")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "escape_to6")
        end
      elseif elecmon_state == "escape_to6" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_103")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).Physics_SetCollisionContactForNotHit()
        Npc(elecmon).Physics_SetGravity(0)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to7" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_104")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "escape_to8")
        end
      elseif elecmon_state == "escape_to8" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_105")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to9" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_106")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to10" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_107")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).Physics_SetCollisionContactForNotHit()
        Npc(elecmon).Physics_SetGravity(0)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to11" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_108")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        Npc(elecmon).Physics_SetCollisionContactForNotHit()
        Npc(elecmon).Physics_SetGravity(0)
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
          Npc(elecmon).Physics_SetCollisionContactForNotHit()
          Npc(elecmon).Physics_SetGravity(0)
        end
      elseif elecmon_state == "escape_to11_2" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_150")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        Npc(elecmon).Physics_SetCollisionContactForNotHit()
        Npc(elecmon).Physics_SetGravity(0)
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
          Npc(elecmon).Physics_SetCollisionContactForNotHit()
          Npc(elecmon).Physics_SetGravity(0)
        end
      elseif elecmon_state == "escape_to12" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_109")
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        Npc(elecmon).Physics_SetCollisionContactForNotHit()
        Npc(elecmon).Physics_SetGravity(0)
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to110" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_120")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to120" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_121")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "escape_to130")
        end
      elseif elecmon_state == "escape_to130" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_122")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to140" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_123")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to150" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_120")
        Npc(elecmon).SetRailMoveDirection(false)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to160" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_121")
        Npc(elecmon).SetRailMoveDirection(false)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to170" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_122")
        Npc(elecmon).SetRailMoveDirection(false)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "escape_to160")
        end
      elseif elecmon_state == "escape_to180" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_123")
        Npc(elecmon).SetRailMoveDirection(false)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to300" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_130")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to310" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_131")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to320" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_132")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to330" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_133")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to340" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_131")
        Npc(elecmon).SetRailMoveDirection(false)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to350" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_133")
        Npc(elecmon).SetRailMoveDirection(false)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to360" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_134")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to400" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_140")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to401" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_141")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "escape_to160")
        end
      elseif elecmon_state == "escape_to19" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_112")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to20" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_110")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          SetExternalVariable("elecmon_state", "railend")
        end
      elseif elecmon_state == "escape_to21" then
        Npc(elecmon).Physics_SetCollisionContactForMapOnly()
        Npc(elecmon).LinkToRailMove("d1101_railmove", "rail_move_111")
        Npc(elecmon).SetRailMoveDirection(true)
        Npc(elecmon).SetRailMoveInDimension2d()
        Npc(elecmon).SetRailMoveSpeed(13)
        Npc(elecmon).RailMoveGo()
        if Npc(elecmon).IsArrivalRailBothEnds() then
          Npc(elecmon).Move_Stop()
          CallEventScriptFunction("Prcs_d1101_Elecmon_Invisible")
        end
      elseif elecmon_state == "relocation0" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos0", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(0, 0)
        SetExternalVariable("elecmon_state", "standby0")
      elseif elecmon_state == "relocation1" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos1", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(0, 0)
        SetExternalVariable("elecmon_state", "standby1")
      elseif elecmon_state == "relocation2" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos2", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby2")
      elseif elecmon_state == "relocation3" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos3", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(0, 0)
        SetExternalVariable("elecmon_state", "standby3")
      elseif elecmon_state == "relocation4" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos4", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby4")
      elseif elecmon_state == "relocation5" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos5", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby5")
      elseif elecmon_state == "relocation6" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos6", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby6")
      elseif elecmon_state == "relocation7" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos7", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby7")
      elseif elecmon_state == "relocation8" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos8", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby8")
      elseif elecmon_state == "relocation9" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos9", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby9")
      elseif elecmon_state == "relocation10" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos10", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby10")
      elseif elecmon_state == "relocation11" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos11", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby11")
      elseif elecmon_state == "relocation13" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos13", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby13")
      elseif elecmon_state == "relocation20" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos20", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby20")
      elseif elecmon_state == "relocation21" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos21", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby21")
      elseif elecmon_state == "relocation23" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos23", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby23")
      elseif elecmon_state == "relocation24" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos24", 0)
        Npc(elecmon).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(elecmon).Move_SetRotationY(90, 0)
        SetExternalVariable("elecmon_state", "standby24")
      elseif elecmon_state == "railend" or elecmon_state == "standby0" or elecmon_state == "standby1" or elecmon_state == "standby2" or elecmon_state == "standby3" or elecmon_state == "standby4" or elecmon_state == "standby5" or elecmon_state == "standby6" or elecmon_state == "standby7" or elecmon_state == "standby8" or elecmon_state == "standby9" or elecmon_state == "standby10" or elecmon_state == "standby11" or elecmon_state == "standby13" or elecmon_state == "standby20" or elecmon_state == "standby21" or elecmon_state == "standby23" or elecmon_state == "standby24" then
        Npc(elecmon).Move_Stop()
        gWaitCount = gWaitCount + elapsed_frame
        if gWaitCount <= 15 then
          local elc_pos_x, elc_pos_y, elc_pos_z = GetPositionAnyObject(NPC, elecmon)
          local player_x, player_y, player_z = GetPositionAnyObject(PLAYER, 1)
          local y_degree = GetAngleToTarget2D(elc_pos_x, elc_pos_z, player_x, player_z)
          Npc(elecmon).Move_SetRotationY(y_degree, 10)
          Npc(elecmon).Motion_PlayMotion("br01", 10, true)
        elseif gWaitCount >= 240 then
          gWaitCount = 0
        else
          Npc(elecmon).Motion_ResetPlayMotion(10)
        end
      end
      if elecmon_state ~= "railend" and elecmon_state ~= "standby0" and elecmon_state ~= "standby1" and elecmon_state ~= "standby2" and elecmon_state ~= "standby3" and elecmon_state ~= "standby4" and elecmon_state ~= "standby5" and elecmon_state ~= "standby6" and elecmon_state ~= "standby7" and elecmon_state ~= "standby8" and elecmon_state ~= "standby9" and elecmon_state ~= "standby10" and elecmon_state ~= "standby11" and elecmon_state ~= "standby13" and elecmon_state ~= "standby20" and elecmon_state ~= "standby21" and elecmon_state ~= "standby23" and elecmon_state ~= "standby24" then
        gWaitCount = 0
      end
    end
    if CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      local fade_frame = 10
      local cancel_fade_frame = 10
      local dist_shield_a = GetDistanceToObject(GIMMICK, GetIndex(GIMMICK, "obj_shield_a01"))
      if dist_shield_a <= 5 then
        Gimmick(GetIndex(GIMMICK, "obj_shield_a01")).InvisibleInNowFrame(fade_frame, cancel_fade_frame, false)
        Gimmick(GetIndex(GIMMICK, "obj_shield_a02")).InvisibleInNowFrame(fade_frame, cancel_fade_frame, false)
      end
    end
  elseif gMapNum == 1102 then
  elseif gMapNum == 1103 then
    if FlagCheck(FLAG_MAIN_03_400) and not FlagCheck(FLAG_MAIN_03_430) then
      local shadow = GetIndex(NPC, "npc_blackshadow")
      local shadow_state = GetExternalVariable("shadow_state")
      local shadow_pos = GetExternalVariable("shadow_pos")
      local invisibletime = 5
      local waittime = 10
      Npc(shadow).Physics_SetCollisionContactForNotHit()
      Npc(shadow).Physics_SetGravity(0)
      if shadow_state == "initialize" then
      elseif shadow_state == "move_to3a" then
        gWaitCount = gWaitCount + elapsed_frame
        if waittime <= gWaitCount then
          Prcs_d1102_BS_Invisible()
          SetExternalVariable("shadow_state", "railend3a")
          gWaitCount = 0
        end
      elseif shadow_state == "railend3a" then
        gWaitCount = gWaitCount + elapsed_frame
        if invisibletime <= gWaitCount then
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos03a", 0)
          Npc(shadow).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          Npc(shadow).Move_SetRotationY(90, 0)
          Prcs_d1102_BS_CancelInvisible()
          Npc(shadow).Move_SetRotationY(90, 0)
          SetExternalVariable("shadow_state", "stop3a")
          gWaitCount = 0
        end
      elseif shadow_state == "stop3a" then
        SetExternalVariable("shadow_state", "move_to3b")
        Npc(shadow).Move_SetRotationY(90, 0)
      elseif shadow_state == "move_to3b" then
        gWaitCount = gWaitCount + elapsed_frame
        if waittime <= gWaitCount then
          Prcs_d1102_BS_Invisible()
          SetExternalVariable("shadow_state", "railend3b")
          gWaitCount = 0
        end
      elseif shadow_state == "railend3b" then
        gWaitCount = gWaitCount + elapsed_frame
        if invisibletime <= gWaitCount then
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos03b", 0)
          Npc(shadow).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          Npc(shadow).Move_SetRotationY(90, 0)
          Prcs_d1102_BS_CancelInvisible()
          Npc(shadow).Move_SetRotationY(90, 0)
          SetExternalVariable("shadow_state", "stop3b")
          gWaitCount = 0
        end
      elseif shadow_state == "stop3b" then
        SetExternalVariable("shadow_state", "move_to4")
        Npc(shadow).Move_SetRotationY(90, 0)
      elseif shadow_state == "move_to4" then
        gWaitCount = gWaitCount + elapsed_frame
        if waittime <= gWaitCount then
          Prcs_d1102_BS_Invisible()
          SetExternalVariable("shadow_state", "railend4")
          gWaitCount = 0
        end
      elseif shadow_state == "railend4" then
        gWaitCount = gWaitCount + elapsed_frame
        if invisibletime <= gWaitCount then
          local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos04", 0)
          Npc(shadow).Move_SetPosition(rloc_x, rloc_y, rloc_z)
          Npc(shadow).Move_SetRotationY(90, 0)
          Prcs_d1102_BS_CancelInvisible()
          Npc(shadow).Move_SetRotationY(90, 0)
          SetExternalVariable("shadow_state", "stop4")
          gWaitCount = 0
        end
      elseif shadow_state == "stop4" then
        Npc(shadow).Move_SetRotationY(90, 0)
      elseif shadow_state == "move_to4a" then
        gWaitCount = gWaitCount + elapsed_frame
        if waittime <= gWaitCount then
          SetExternalVariable("shadow_state", "railend4a")
          gWaitCount = 0
        end
      elseif shadow_state == "railend4a" then
        Npc(shadow).Move_Stop()
        Prcs_d1102_BS_Invisible()
        SetExternalVariable("shadow_state", "end")
      elseif shadow_state == "relocation1" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos02", 0)
        Npc(shadow).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Prcs_d1102_BS_CancelInvisible()
        SetExternalVariable("shadow_state", "stop2")
      elseif shadow_state == "relocation2" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos03", 0)
        Npc(shadow).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Prcs_d1102_BS_CancelInvisible()
        SetExternalVariable("shadow_state", "stop3")
      elseif shadow_state == "relocation3" then
        local rloc_x, rloc_y, rloc_z = GetLocatorPosOfLocatorModel(gPlanData, "script_pos04", 0)
        Npc(shadow).Move_SetPosition(rloc_x, rloc_y, rloc_z)
        Npc(shadow).Move_SetRotationY(90, 0)
        Prcs_d1102_BS_CancelInvisible()
        Npc(shadow).Move_SetRotationY(90, 0)
        SetExternalVariable("shadow_state", "stop4")
      end
    end
    if CheckTimeAxis("A2020_dbef_200", "A2020_dbef_210") then
      local fade_frame = 10
      local cancel_fade_frame = 10
      local dist_shield_a = GetDistanceToObject(GIMMICK, GetIndex(GIMMICK, "obj_shield_a01"))
      if dist_shield_a <= 5 then
        Gimmick(GetIndex(GIMMICK, "obj_shield_a01")).InvisibleInNowFrame(fade_frame, cancel_fade_frame, false)
        Gimmick(GetIndex(GIMMICK, "obj_shield_a02")).InvisibleInNowFrame(fade_frame, cancel_fade_frame, false)
      end
    end
  elseif gMapNum == 1104 then
    local railmove_digimon_1 = GetIndex(MOB, "railmove_digimon_1")
    local railmove_digimon_2 = GetIndex(MOB, "railmove_digimon_2")
    local railmove_digimon_3 = GetIndex(MOB, "railmove_digimon_3")
    local digimon_state_1 = GetExternalVariable("railmove_digimon_state_1")
    local digimon_state_2 = GetExternalVariable("railmove_digimon_state_2")
    local digimon_state_3 = GetExternalVariable("railmove_digimon_state_3")
    local railmove_raramon_1 = GetIndex(MOB, "railmove_raramon_1")
    local railmove_raramon_2 = GetIndex(MOB, "railmove_raramon_2")
    local railmove_raramon_3 = GetIndex(MOB, "railmove_raramon_3")
    local raramon_state_1 = GetExternalVariable("railmove_raramon_state_1")
    local raramon_state_2 = GetExternalVariable("railmove_raramon_state_2")
    local raramon_state_3 = GetExternalVariable("railmove_raramon_state_3")
    local player_pos_x, player_pos_y, player_pos_z = 0, 0, 0
    local gazer_1_pos_x, gazer_1_pos_y, gazer_1_pos_z = 0, 0, 0
    local gazer_1_y_degree = 0
    local gazer_2_pos_x, gazer_2_pos_y, gazer_2_pos_z = 0, 0, 0
    local gazer_2_y_degree = 0
    local gazer_3_pos_x, gazer_3_pos_y, gazer_3_pos_z = 0, 0, 0
    local gazer_3_y_degree = 0
    local gazer_4_pos_x, gazer_4_pos_y, gazer_4_pos_z = 0, 0, 0
    local gazer_4_y_degree = 0
    local gazer_5_pos_x, gazer_5_pos_y, gazer_5_pos_z = 0, 0, 0
    local gazer_5_y_degree = 0
    local gazer_6_pos_x, gazer_6_pos_y, gazer_6_pos_z = 0, 0, 0
    local gazer_6_y_degree = 0
    player_pos_x, player_pos_y, player_pos_z = Player().GetPosition()
    if digimon_state_1 == "Go" then
      Mob(railmove_digimon_1).Physics_SetGravity(0)
      Mob(railmove_digimon_1).Physics_SetCollisionContactForNotHit()
      Mob(railmove_digimon_1).RailMoveGo()
      Mob(railmove_digimon_1).Motion_PlayMotion("br01", 10, true)
    end
    if Mob(railmove_digimon_1).IsArrivalRailBothEnds() == true then
      Mob(railmove_digimon_1).Invisible(0, false)
    end
    if digimon_state_2 == "Go" then
      Mob(railmove_digimon_2).Physics_SetGravity(0)
      Mob(railmove_digimon_2).Physics_SetCollisionContactForNotHit()
      Mob(railmove_digimon_2).RailMoveGo()
      Mob(railmove_digimon_2).Motion_PlayMotion("br01", 20, true)
    end
    if Mob(railmove_digimon_2).IsArrivalRailBothEnds() == true then
      Mob(railmove_digimon_2).Invisible(0, false)
    end
    if digimon_state_3 == "Go" then
      Mob(railmove_digimon_3).Physics_SetGravity(0)
      Mob(railmove_digimon_3).Physics_SetCollisionContactForNotHit()
      Mob(railmove_digimon_3).RailMoveGo()
      Mob(railmove_digimon_3).Motion_PlayMotion("br01", 15, true)
    end
    if Mob(railmove_digimon_3).IsArrivalRailBothEnds() == true then
      Mob(railmove_digimon_3).Invisible(0, false)
    end
    local gazer_1 = GetIndex(MOB, "gazer_1")
    local gazer_2 = GetIndex(MOB, "gazer_2")
    local gazer_3 = GetIndex(MOB, "gazer_3")
    gazer_1_pos_x, gazer_1_pos_y, gazer_1_pos_z = Mob(gazer_1).GetPosition()
    gazer_1_y_degree = GetAngleToTarget2D(gazer_1_pos_x, gazer_1_pos_z, player_pos_x, player_pos_z)
    Mob(gazer_1).Move_SetRotationY(gazer_1_y_degree, 1)
    gazer_2_pos_x, gazer_2_pos_y, gazer_2_pos_z = Mob(gazer_2).GetPosition()
    gazer_2_y_degree = GetAngleToTarget2D(gazer_2_pos_x, gazer_2_pos_z, player_pos_x, player_pos_z)
    Mob(gazer_2).Move_SetRotationY(gazer_2_y_degree, 1)
    gazer_3_pos_x, gazer_3_pos_y, gazer_3_pos_z = Mob(gazer_3).GetPosition()
    gazer_3_y_degree = GetAngleToTarget2D(gazer_3_pos_x, gazer_3_pos_z, player_pos_x, player_pos_z)
    Mob(gazer_3).Move_SetRotationY(gazer_3_y_degree, 1)
  end
end

function OnTouchCollision(col_name)
  if gMapNum == 1104 then
    local raramon_state_1 = GetExternalVariable("railmove_raramon_state_1")
    local raramon_state_2 = GetExternalVariable("railmove_raramon_state_2")
    local raramon_state_3 = GetExternalVariable("railmove_raramon_state_3")
    if col_name == "evt_1000" then
      SetExternalVariable("railmove_digimon_state_1", "Go")
      SetExternalVariable("railmove_digimon_state_2", "Go")
      SetExternalVariable("railmove_digimon_state_3", "Go")
    elseif col_name == "evt_2000" then
      if raramon_state_1 == "Initialize" then
        SetExternalVariable("railmove_raramon_state_1", "Go")
      end
      if raramon_state_2 == "Initialize" then
        SetExternalVariable("railmove_raramon_state_2", "Go")
      end
      if raramon_state_3 == "Initialize" then
        SetExternalVariable("railmove_raramon_state_3", "Go")
      end
    end
  end
end

function OnEncountSymbolEnemy(object_index, args)
  if gMapNum == 1101 then
    local enemy_name = SymbolEnemy(object_index).GetUniqueName()
    local enemy_tag = SymbolEnemy(object_index).GetTag()
    if FlagCheck(FLAG_MAIN_07_057) and not FlagCheck(FLAG_MAIN_07_059) then
      return REACTION_TO_ENCOUN_FORCE_NORMAL_ENCOUNT
    end
  end
end

function Prcs_d1102_BS_Invisible()
  local shadow = GetIndex(NPC, "npc_blackshadow")
  local x, y, z = Npc(shadow).GetPosition()
  PlayEffectScript("ef_e_com_115", x, y + 1.8, z, 0, 1)
  PlaySE(300214, 100)
  Npc(shadow).Invisible(10, true)
end

function Prcs_d1102_BS_CancelInvisible()
  local shadow = GetIndex(NPC, "npc_blackshadow")
  Npc(shadow).CancelInvisible(10, true, true)
end
