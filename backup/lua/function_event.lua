function EVENT_BEGIN()
  Vista.Start()
  
  Vista.LoadVoices()
  while true do
    WaitFrame(1)
    if Vista.IsEndLoadJson() then
      break
    end
  end
end

function EVENT_START()
  Vista.Play()
  Vista.SetSkip(true)
  if not Flg.Check("FLAG_IS_LETTERBOX") then
    Talk.OpenLetterBox()
    Flg.Set("FLAG_IS_LETTERBOX")
    print("===================================")
    print("FLAG_IS_LETTERBOX_ON")
    print("===================================")
  end
  SetMobTransparentRange(20, 20, 20)
end

function FIELD_SET()
  Field_InvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleNpc("", INVISIBLE_KEY_EVENT, 0, false)
  Field_InvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false)
end

function EVENT_END(param)
  if Vista.IsSkipping() then
    Vista.SetSkip(false, true)
    Talk.CloseLetterBox()
    Flg.Clear("FLAG_IS_LETTERBOX")
    print("===================================")
    print("FLAG_IS_LETTERBOX_OFF")
    print("===================================")
  else
    Vista.SetSkip(false, true)
    if param == nil then
      Talk.CloseLetterBox()
      Flg.Clear("FLAG_IS_LETTERBOX")
      print("===================================")
      print("FLAG_IS_LETTERBOX_OFF")
      print("===================================")
    else
      print("===================================")
      print("FLAG_IS_LETTERBOX_CONTINUE")
      print("===================================")
    end
  end
  Vista.ClearMobTransparentRange()
  Event_Quake_Stop(0)
  TalkExit()
  VistaExit()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleMob(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
  local field_player_index = Field.GetPlayerIndex()
  if field_player_index then
    Field.ObjectResetAim(FLD_OBJ_PLAYER, field_player_index, 0)
  end
  if Debug.IsEventView() then
    Event_StopBGM(0, 0)
    Event_StopAllSE(0, 0)
  end
end

function EVENT_END_SEAMLESS(wait_frame)
  Talk.CloseLetterBox()
  Flg.Clear("FLAG_IS_LETTERBOX")
  print("===================================")
  print("FLAG_IS_LETTERBOX_OFF")
  print("===================================")
  Vista.ClearMobTransparentRange()
  TalkExit()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, false, false)
  Vista.SeamlessExit(Util.SecondFromFrame(wait_frame), "SCURVE")
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleMob(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
  local field_player_index = Field.GetPlayerIndex()
  if field_player_index then
    Field.ObjectResetAim(FLD_OBJ_PLAYER, field_player_index, 0)
  end
  while true do
    if Vista.IsExit() then
      Vista.SetSkip(false, true)
      Vista.End()
      break
    end
    WaitFrame(1)
  end
  if Debug.IsEventView() then
    Event_StopBGM(0, 0)
    Event_StopAllSE(0, 0)
  end
end

function EVENT_END_NPCVISIBLE()
  Vista.SetSkip(false, true)
  Talk.CloseLetterBox()
  Flg.Clear("FLAG_IS_LETTERBOX")
  print("===================================")
  print("FLAG_IS_LETTERBOX_OFF")
  print("===================================")
  Vista.ClearMobTransparentRange()
  TalkExit()
  VistaExit()
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, true, false)
  local field_player_index = Field.GetPlayerIndex()
  if field_player_index then
    Field.ObjectResetAim(FLD_OBJ_PLAYER, field_player_index, 0)
  end
  if Debug.IsEventView() then
    Event_StopBGM(0, 0)
    Event_StopAllSE(0, 0)
  end
end

function CUT_START(cut_no)
  if cut_no ~= nil then
    Vista.SetCutIndex(cut_no)
  end
end

function SetEventCutNo(num)
  Vista.SetCutTotalIndex(num)
end

function LOAD_VOICE()
  Vista.LoadVoices()
end

function CAM_WAIT(wait_frame)
  while not Vista.IsEndPlay(Util.SecondFromFrame(wait_frame)) do
    WaitFrame(1)
  end
end

function CAM_POS_WAIT(wait_frame)
  while not Vista.IsEndCameraPosition(Util.SecondFromFrame(wait_frame)) do
    WaitFrame(1)
  end
end

function CAM_OFFSET_MOVE_WAIT(wait_frame)
  while not Vista.IsEndCameraOffsetMove(Util.SecondFromFrame(wait_frame)) do
    WaitFrame(1)
  end
end

function CAM_OFFSET_TURN_WAIT(wait_frame)
  while not Vista.IsEndCameraOffsetTurn(Util.SecondFromFrame(wait_frame)) do
    WaitFrame(1)
  end
end

MOVIE = {}

function MOVIE.new(manage_name, movie_name)
  local obj = {}
  obj.manage_name = manage_name
  obj.movie_name = movie_name
  Vista.LoadMovie(manage_name, movie_name)
  Vista.SetSkip(true, true)
  
  function obj:PLAY(play_time)
    Vista.PlayMovie(self.manage_name)
    if play_time == nil then
      while true do
        WaitFrame(1)
        if Vista.IsPlayEndMovie(self.manage_name) or Vista.IsSkipping() then
          break
        end
      end
    else
      WaitFrame(play_time)
    end
  end
  
  return obj
end

function MOVIE_WAIT(a_manage_name)
  while not Vista.IsPlayEndMovie(a_manage_name) do
    WaitFrame(1)
  end
end

function MESSAGE_WAIT()
  WaitMessage()
  MessageClose()
end

function MESSAGE_WAIT2()
  WaitMessage()
  Talk.Close()
end

function MOVE_WAIT(a_name)
  while not Vista.IsEndMove(a_name) do
    WaitFrame(20)
  end
end

function EFFECT_WAIT(ManageName, Offsettime)
  while not Vista.IsEndEffect(ManageName, Offsettime) do
    WaitFrame(1)
  end
end

function EFFECTSCRIPT_WAIT(ManageName)
  while not Vista.IsEndEffectScript(ManageName) do
    WaitFrame(1)
  end
end

function MOTION_WAIT(a_name, wait_frame, timing)
  local count = 0
  while true do
    count = count + 1
    print("count===", count)
    if 0 < timing then
      timing = timing - 1
      print("================")
      print(timing)
      print("================")
    end
    if timing < 1 then
      if Vista.IsPlayingMotionLoop(a_name) then
        print("=====LoopMotionPlay")
        if Vista.IsEndLoopAnimation(a_name, 1, Util.SecondFromFrame(wait_frame)) then
          print("================")
          print("LoopMotion_End")
          print("================")
          break
        end
      else
        print("=====OneActionPlay")
        if Vista.IsEndAnimation(a_name, Util.SecondFromFrame(wait_frame)) then
          print("================")
          print("OneAction_End")
          print("================")
          break
        end
      end
    end
    WaitFrame(1)
  end
end

function ENDMOTION_WAIT(a_name, wait_frame)
  while not Vista.IsEndEndAnimation(a_name, Util.SecondFromFrame(wait_frame)) do
    WaitFrame(1)
  end
end

function BLEND_WAIT(ManageName, Offsettime)
  while not Vista.IsEndAnimationBlend(ManageName, Util.SecondFromFrame(Offsettime)) do
    WaitFrame(1)
  end
end

function LoadMap(a_name)
  Vista.LoadBackGround(a_name)
end

function LoadCamera(a_manage_name, a_name)
  Vista.LoadCameraAnimationID(a_manage_name, a_name)
end

function LoadModel(a_manage_name, a_model_manage_id)
  Vista.LoadCharacter(a_manage_name, a_model_manage_id)
  if a_manage_name == "HEROINE_01" then
    Vista.BindSpeaker(a_manage_name, "char_INORI")
    Vista.BindSpeaker(a_manage_name, "char_MYSTERIOUS_GIRL")
    Vista.BindSpeaker(a_manage_name, "char_PROTECTED_GIRL")
  elseif a_manage_name == "TAKEMIYA_01" then
    Vista.BindSpeaker(a_manage_name, "char_TAKEMIYA")
    Vista.BindSpeaker(a_manage_name, "char_GLASSES_WEARING_MAN")
    Vista.BindSpeaker(a_manage_name, "char_TAKEMIYA_8YEARSLATER")
  elseif a_manage_name == "TAKEMIYA_8YEARSLATER_01" then
    Vista.BindSpeaker(a_manage_name, "char_TAKEMIYA")
  elseif a_manage_name == "AEGIOMON_01" then
    Vista.BindSpeaker(a_manage_name, "char_AEGIOMON")
    Vista.BindSpeaker(a_manage_name, "char_AEGIOMON_PLAIN_CLOTHES")
    Vista.BindSpeaker(a_manage_name, "char_AEGIOMON_NO_CAP")
    Vista.BindSpeaker(a_manage_name, "char_UNKNOWN")
  elseif a_manage_name == "AEGIOMON_B_01" then
    Vista.BindSpeaker(a_manage_name, "char_AEGIOMON")
  elseif a_manage_name == "chr184aa010101_01" then
    Vista.BindSpeaker(a_manage_name, "char_AEGIOMON")
  elseif a_manage_name == "AEGIOCHUSMON_01" then
    Vista.BindSpeaker(a_manage_name, "char_AEGIOMON")
  elseif a_manage_name == "HIROKO_01" then
    Vista.BindSpeaker(a_manage_name, "char_HIROKO")
    Vista.BindSpeaker(a_manage_name, "char_HIROKO_8YEARSLATER")
  elseif a_manage_name == "HIROKO_8YEARSLATER_01" then
    Vista.BindSpeaker(a_manage_name, "char_HIROKO")
  elseif a_manage_name == "SUMERAGI_01" then
    Vista.BindSpeaker(a_manage_name, "char_SUMERAGI")
    Vista.BindSpeaker(a_manage_name, "char_MAN_OF_PUBLIC_SECURITY")
    Vista.BindSpeaker(a_manage_name, "char_SUMERAGI_8YEARSLATER")
  elseif a_manage_name == "npc056aa010101_01" then
    Vista.BindSpeaker(a_manage_name, "char_SUMERAGI")
  elseif a_manage_name == "TOUDOU_01" then
    Vista.BindSpeaker(a_manage_name, "char_TOUDO")
    Vista.BindSpeaker(a_manage_name, "char_WOMAN_OF_PUBLIC_SECURITY")
    Vista.BindSpeaker(a_manage_name, "char_TOUDO_8YEARSLATER")
  elseif a_manage_name == "npc057aa010101_01" then
    Vista.BindSpeaker(a_manage_name, "char_TOUDO")
  elseif a_manage_name == "MIREI_01" then
    Vista.BindSpeaker(a_manage_name, "char_MIREI")
    Vista.BindSpeaker(a_manage_name, "char_MIREI_CHILD")
  elseif a_manage_name == "MERCURYMON_01" then
    Vista.BindSpeaker(a_manage_name, "char_MERCURYMON")
  elseif a_manage_name == "chr928_01" then
    Vista.BindSpeaker(a_manage_name, "char_MERCURYMON")
  end
end

function LoadLocater(a_name)
  Vista.LoadLocater(a_name)
end

function LoadEffect(a_manage_name, a_name)
  Vista.LoadEffect(a_manage_name, a_name)
end

function LoadEffectScript(a_manage_name, a_name)
  Vista.LoadEffectScript(a_manage_name, a_name)
end

function LoadObject(a_manage_name, a_accessory_name)
  Vista.LoadAccessory(a_manage_name, a_accessory_name)
end

function LoadEndrollDigimonDot(a_manage_name, a_encount_id, a_index)
  digimon_id = Vista.GetBattleMemberID(a_encount_id, a_index)
  Vista.LoadDigimonDot(a_manage_name, digimon_id)
end

function LoadDissolve(a_manage_name, a_id)
  Vista.LoadDissolve(a_manage_name, a_id)
end

function LoadEnvironmentFile(ManageName, FileName)
  Vista.LoadEnvironmentSettings(ManageName, FileName)
end

function LoadSceneViewerResource(ManageName, FileName)
  Vista.LoadSceneViewerResource(ManageName, FileName)
end

function Load_LipSyncs()
  Vista.LoadCRILipSyncs()
end

function SetPosition(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
  Vista.SetPositionWithTiming(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
end

function SetRotation(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
  Vista.SetRotationWithTiming(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
end

function SetScale(a_manage_name, a_x, a_y, a_z)
  Vista.SetScale(a_manage_name, a_x, a_y, a_z)
end

function MovePosition(a_manage_name, a_x, a_y, a_z, a_is_floor, a_speed, a_frame)
  Vista.MovePosition(a_manage_name, a_x, a_y, a_z, a_is_floor, a_speed, a_frame)
end

function MovePosition2(a_manage_name, a_x, a_y, a_z, a_is_floor, a_speed, a_frame)
  Vista.MovePositionQuick(a_manage_name, a_x, a_y, a_z, a_is_floor, a_speed, a_frame)
end

function MoveRotation(a_manage_name, a_x, a_y, a_z, a_type, a_speed, a_pre_rot, a_frame)
  if a_pre_rot == true or a_pre_rot == false then
    print("yes")
    Vista.MoveRotation(a_manage_name, a_x, a_y, a_z, a_type, a_speed, a_pre_rot, a_frame)
  else
    print("not")
    a_frame = a_pre_rot
    a_pre_rot = 1
    Vista.MoveRotation(a_manage_name, a_x, a_y, a_z, a_type, a_speed, a_pre_rot, a_frame)
  end
end

function ModelVisible(a_manage_name, a_is_visible, a_fade_time, a_timing)
  Vista.SetModelVisible(a_manage_name, a_is_visible, a_fade_time, a_timing)
end

function AttachLocate(a_manage_name, a_locator_name)
  Vista.AttachLocate(a_manage_name, a_locator_name)
end

function AttachLocateFrame(a_manage_name, a_locator_name, a_start_frame, a_end_frame)
  Vista.LocateModelByID(a_manage_name, a_locator_name, a_start_frame, a_end_frame)
end

function AttachObject(a_manage_name, a_accessory_name, a_id)
  Vista.AttachAccessory(a_manage_name, a_accessory_name, a_id)
end

function DetachObject(a_accessory_name)
  Vista.DetachAccessory(a_accessory_name)
end

function ChangeDigimonFace(a_manage_name, a_expression, a_timing)
  Vista.ChangeEyeExpressionByID(a_manage_name, a_expression, a_timing)
end

function ModelPriority(a_manage_name, a_priority)
  Vista.SetModelPriority(a_manage_name, a_priority)
end

function PlayAimQuick(a_manage_name, a_target_name)
  Vista.PlayAimQuick(a_manage_name, a_target_name)
end

function PlayAim(a_manage_name, a_target_name, a_frame, a_timing)
  if a_frame == 0 then
    PlayAimQuick(a_manage_name, a_target_name)
  else
    Vista.PlayAim(a_manage_name, a_target_name, a_frame, a_timing)
  end
end

function ResetAimQuick(a_manage_name)
  Vista.ResetAimQuick(a_manage_name)
end

function ResetAim(a_manage_name, a_frame, a_timing)
  if a_frame == 0 then
    ResetAimQuick(a_manage_name)
  else
    Vista.ResetAim(a_manage_name, a_frame, a_timing)
  end
end

function PlayAllAim(TargetChara, time1, time2)
  local AllChara = Vista.GetManageNameList()
  local rtimeA = 5
  local rtimeB = 5
  local t01 = time1 - rtimeA
  local t02 = time1 + rtimeA
  if t01 < 0 then
    t01 = 0
  end
  local t03 = time2 - rtimeB
  local t04 = time2 + rtimeB
  local prefix = "name"
  for i = 0, 99 do
    local number = string.format("%02d", i)
    local keyword = prefix .. number
    if AllChara[keyword] ~= nil then
      if AllChara[keyword] ~= TargetChara then
        local random1 = math.random(t01, t02)
        local random2 = math.random(t03, t04)
        Vista.PlayAim(AllChara[keyword], TargetChara, random1, random2)
      end
    else
      break
    end
  end
end

function PlayAllAimReset(time1, time2)
  local AllChara = Vista.GetManageNameList()
  local rtimeA = 5
  local rtimeB = 5
  local t01 = time1 - rtimeA
  local t02 = time1 + rtimeA
  if t01 < 0 then
    t01 = 0
  end
  local t03 = time2 - rtimeB
  local t04 = time2 + rtimeB
  local prefix = "name"
  for i = 0, 99 do
    local number = string.format("%02d", i)
    local keyword = prefix .. number
    if AllChara[keyword] ~= nil then
      local random1 = math.random(t01, t02)
      local random2 = math.random(t03, t04)
      Vista.ResetAim(AllChara[keyword], random1, random2)
    else
      break
    end
  end
end

function PlayAllAimQuick(TargetChara)
  local AllChara = Vista.GetManageNameList()
  local prefix = "name"
  for i = 0, 99 do
    local number = string.format("%02d", i)
    local keyword = prefix .. number
    if AllChara[keyword] ~= nil then
      if AllChara[keyword] ~= TargetChara then
        Vista.PlayAimQuick(AllChara[keyword], TargetChara)
      end
    else
      break
    end
  end
end

function PlayAllAimResetQuick()
  local AllChara = Vista.GetManageNameList()
  local prefix = "name"
  for i = 0, 99 do
    local number = string.format("%02d", i)
    local keyword = prefix .. number
    if AllChara[keyword] ~= nil then
      Vista.ResetAimQuick(AllChara[keyword])
    else
      break
    end
  end
end

function SetMobTransparentRange(width, height, depth)
  Vista.SetMobTransparentRange(width, height, depth)
end

function ClearMobTransparentRange()
  Vista.ClearMobTransparentRange()
end

function MASK_OFF(manage_name)
  Vista.SetMaskVisible(manage_name, false)
end

function MASK_ON(manage_name)
  Vista.SetMaskVisible(manage_name, true)
end

function PlayMotion(a_manage_name, a_animation_name, a_blend_time, a_is_loop, timing)
  Vista.PlayAnimation(a_manage_name, a_animation_name, a_blend_time, a_is_loop, timing)
end

function PlayMotionForce(a_manage_name, a_animation_name, a_blend_time, a_is_loop, timing)
  Vista.PlayAnimationForce(a_manage_name, a_animation_name, a_blend_time, a_is_loop, timing)
end

function ResetMotion(a_manage_name, a_is_loop, timing)
  Vista.ResetAnimation(a_manage_name, a_is_loop, timing)
end

function PlayMotionBlend(a_manage_name, a_animation_name, a_blend_time, a_is_loop, timing)
  Vista.PlayAnimationBlend(a_manage_name, a_animation_name, a_blend_time, a_is_loop, timing)
end

function ResetBlend(a_manage_name, a_animation_name, timing)
  if timing == nil then
    timing = 0
  end
  Vista.ResetAnimationBlend(a_manage_name, a_animation_name, timing)
end

function EndMotion(a_manage_name, timing)
  Vista.EndAnimation(a_manage_name, timing)
end

function SetStartFrame(a_manage_name, a_animation_name, a_start_time, a_timing)
  if a_timing == nil then
    a_timing = 0
  end
  Vista.StartFrameModel(a_manage_name, a_animation_name, a_start_time, a_timing)
end

function SetMoveStartFrame(a_manage_name, a_start_time, a_timing)
  if a_timing == nil then
    a_timing = 0
  end
  Vista.MoveStartFrameModel(a_manage_name, a_start_time, a_timing)
end

function SetLoopFrame(a_manage_name, a_animation_name, a_start_time, a_end_time)
  Vista.SetLoopFrameModel(a_manage_name, a_animation_name, a_start_time, a_end_time)
end

function PlayMotionFace(a_manage_name, a_eye_anim_name, a_mouth_anim_name, a_blend_frame, a_timing)
  Vista.PlayAnimationFace(a_manage_name, a_eye_anim_name, a_mouth_anim_name, a_blend_frame, a_timing)
end

function SetBlink(a_manage_name, a_type, a_blink_speed, a_timing)
  if a_timing == nil then
    a_timing = 0
  end
  Vista.SetBlink(a_manage_name, a_type, a_blink_speed, a_timing)
end

function SetDigimonBlink(a_manage_name, a_type, a_blink_speed, a_timing)
  if a_timing == nil then
    a_timing = 0
  end
  Vista.SetDigimonBlink(a_manage_name, a_type, a_blink_speed, a_timing)
end

function SetMouth(a_manage_name, a_type, a_frame, a_timing)
  Vista.SetMouth(a_manage_name, a_type, a_frame, a_timing)
end

function SetFace(a_manage_name, a_expression_id, a_blink_type, a_mouth_type, a_blend_frame, a_timing)
  Vista.SetFace(a_manage_name, a_expression_id, a_blink_type, a_mouth_type, a_blend_frame, a_timing)
end

function BlendEye(a_manage_name, a_x, a_y, a_way, a_frame, a_timing)
  Vista.BlendEye(a_manage_name, a_x, a_y, a_way, a_frame, a_timing)
end

function BlendFace(a_manage_name, a_x, a_y, a_z, a_type, a_way, a_frame, a_timing)
  Vista.BlendFace(a_manage_name, a_x, a_y, a_z, a_type, a_way, a_frame, a_timing)
end

function BlendFaceDigi(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
  Vista.SetAimDegree(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
end

function SetEyeUVOffsetDigi(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
  Vista.SetEyeUVOffsetDigi(a_manage_name, a_x, a_y, a_z, a_way, a_frame, a_timing)
end

function SetFacialExpressionVisible(a_manage_name, a_type, a_visible)
  Vista.SetFacialExpressionVisible(a_manage_name, a_type, a_visible)
end

function SetFacialExpressionMeshAlpha(a_manage_name, a_type, a_alpha)
  Vista.SetFacialExpressionMeshAlpha(a_manage_name, a_type, a_alpha)
end

function SetFacialExpressionScale(a_manage_name, a_type, a_scale)
  Vista.SetFacialExpressionScale(a_manage_name, a_type, a_scale)
end

function ResetFacialExpression(a_manage_name)
  Vista.ResetFacialExpression(a_manage_name)
end

function HeadReset(a_blend_frame, a_timing)
  if a_timing == nil then
    a_timing = 0
  end
  Vista.ResetAllFace(a_blend_frame, a_timing)
end

function MotionSpeed(a_speed)
  Vista.SetNextAnimationPlaySpeed(a_speed)
end

function PlayCamera(a_manage_name)
  Vista.PlayCameraAnimation(a_manage_name)
end

function SetCamera(a_x, a_y, a_z, a_roll, a_view_angle, a_way, a_frame, a_auto_decel, a_timing, a_is_curve)
  local cam_table = {
    pos_x = a_x,
    pos_y = a_y,
    pos_z = a_z,
    roll = a_roll,
    angle = a_view_angle,
    way = a_way,
    frame = a_frame,
    auto_decel = a_auto_decel,
    timing = a_timing,
    is_curve = a_is_curve
  }
  Vista.SetCameraTable(cam_table)
end

function SetCameraTarget(a_x, a_y, a_z, a_way, a_frame, a_auto_decel, a_timing, a_is_curve)
  if a_auto_decel == true then
    local cam_table = {
      pos_x = a_x,
      pos_y = a_y,
      pos_z = a_z,
      way = a_way,
      frame = a_frame,
      auto_decel = a_auto_decel,
      timing = a_timing,
      is_curve = a_is_curve
    }
    Vista.SetCameraTargetTable(cam_table)
  elseif a_auto_decel == false then
    Vista.SetCameraTarget(a_x, a_y, a_z, a_way, a_frame, a_timing, a_is_curve)
  end
end

function CameraMove(a_start_frame, a_end_frame)
  Vista.SetCameraAnimationTime(a_start_frame, a_end_frame)
end

function BlendCamera(a_manage_name)
  Vista.BlendCameraAnimation(a_manage_name)
end

function BlendSetCamera(a_manage_name)
  Vista.PlayMotionToBaseCamera(a_manage_name)
end

function StopBlendSetCamera(a_manage_name)
  Vista.StopMotionToBaseCamera(a_manage_name)
end

function SeamlessCamera(a_frame, a_move_type)
  Vista.StartSeamlessCameraFrame(a_frame, a_move_type)
end

function LocateCamera(a_locator_name)
  Vista.LocateCamera(a_locator_name)
end

function SetCameraCircle(a_pan, a_tilt, a_way, a_frame, a_timing)
  Vista.SetCameraCircle(a_pan, a_tilt, a_way, a_frame, a_timing)
end

function CameraOffsetMove(a_x, a_y, a_z, a_way, a_center, a_decel, a_frame, a_timing)
  Vista.SetCameraOffsetMove(a_x, a_y, a_z, a_way, a_center, a_decel, a_frame, a_timing)
end

function CameraOffsetTurn(a_y, a_way, a_center, a_decel, a_frame, a_timing)
  Vista.SetCameraOffsetTurn(a_y, a_way, a_center, a_decel, a_frame, a_timing)
end

function PlayEffect(a_manage_name, a_loop, a_timing)
  Vista.PlayEffect(a_manage_name, a_loop, a_timing)
end

function WindowRenamePlayer()
  Window.OpenRenamePlayer()
  while Window.IsCloseRenamePlayer() == false do
    WaitFrame(1)
  end
  Window.EndRenamePlayer()
end

function PictureLoad(texture)
  Vista.LoadEventPicture(texture)
  Vista.IsLoadingEventPicture(texture)
end

function PictureOpen(texture, a_timing)
  if a_timing == nil then
    a_timing = 0
  end
  Vista.OpenEventPicture(texture, a_timing)
end

function PictureClose()
  Vista.CloseEventPicture()
end

function Event_Quake_Start(a_start_rate, a_end_rate, a_time, a_timing)
  local vibelow = 0
  local vibehigh = 0
  local vibetime = 0
  if a_time == -1 then
    vibetime = -1
    print("===================")
    print("loopvibe", vibetime)
    print("===================")
  else
    vibetime = a_time / 30
    print("===================")
    print("timevibe", vibetime)
    print("===================")
  end
  if 10 <= a_start_rate then
    vibelow = 0
    vibehigh = 1
  else
    vibelow = 1
    vibehigh = 0
  end
  CtrVibration(vibelow, vibehigh, vibetime, a_timing)
  Vista.QuakeStart(a_start_rate, a_end_rate, a_time, a_timing)
end

function Event_Quake_Stop(a_timing)
  CtrVibration(0, 0, 0, a_timing)
  print("===================")
  print("vibe stop")
  print("===================")
  Vista.QuakeStop(a_timing)
end

function SetEmotion(a_manage_name, a_icon_name, a_x, a_y, a_z, a_scale, a_timing)
  Vista.SetEmotion(a_manage_name, a_icon_name, a_x, a_y, a_z, a_scale, a_timing)
end

function PlayDissolve(a_manage_name, a_id)
  Vista.PlayDissolve(a_manage_name, a_id)
end

function SetEnvironmentFile(ManageName)
  Vista.SetEnvironmentSettings(ManageName)
end

function SetEnvironmentFileWithTiming(ManageName, a_timing)
  Vista.SetEnvironmentSettingsWithTiming(ManageName, a_timing)
end

function ChangeEnvironmentFile(ManageName, a_second)
  Vista.ChangeEnvironmentSettings(ManageName, a_second)
end

function ResetEnvironmentSettings()
  Vista.InitEnvironmentSettings()
end

function ResetEnvironmentSettingsWithTiming(a_timing)
  Vista.InitEnvironmentSettingsWithTiming(a_timing)
end

function SetSceneViewerResource(ManageName)
  Vista.SetSceneViewerResource(ManageName)
end

function SetSceneViewerResourceWithTiming(ManageName, a_timing)
  Vista.SetSceneViewerResourceWithTiming(ManageName, a_timing)
end

function SetEnv_All(ManageName, a_timing)
  ResetEnvironmentSettingsWithTiming(a_timing)
  SetSceneViewerResourceWithTiming(ManageName, a_timing)
  SetEnvironmentFileWithTiming(ManageName, a_timing)
end

function SetSepiaFilter()
  PostEffect.SetSepiaFilter(true, 0.3, 0, false, false, 0)
  PostEffect.SetMonoFilter(true, 0.6, 0, false, false, 0)
  PostEffect.SetGlitch(true, 5.0E-5, 20, 0.005, 0.005, 0)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.2, 6, 20, 23)
end

function SetSepiaFilter_OFF()
  PostEffect.SetGlitch(false, 0, 0, 0, 0, 0)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.2, 2, 20, 23)
end

function ReSetSepiaFilter()
  PostEffect.SetSepiaFilter(true, 0.3, 0, false, false, 0)
  PostEffect.SetMonoFilter(true, 0.6, 0, false, false, 0)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.2, 2, 20, 23)
end

function SetVignette()
  PostEffect.SetVignette(true, 0, 180, 3, 0)
end

function EndVignette()
  PostEffect.SetVignette(false, 0, 180, 3, 0)
end

function EndSepiaFilter()
  PostEffect.SetMonoFilter(true, 0, 3, true, false, 0)
  PostEffect.SetSepiaFilter(true, 0, 3, true, false, 0)
  PostEffect.SetSepiaFilter(false, 0, 0, false, false, 0)
  PostEffect.SetMonoFilter(false, 0, 0, false, false, 0)
  PostEffect.SetGlitchNoise(false, 0, 0, 0, 0, 0, 20, 23)
end

function EndSepiaFilterWithWait()
  PostEffect.SetMonoFilter(true, 0, 3, true, false, 0)
  PostEffect.SetSepiaFilter(true, 0, 3, true, false, 0)
  WaitFrame(20)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.17, 2, 20, 23)
  WaitFrame(20)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.13, 2, 20, 23)
  WaitFrame(20)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.1, 2, 20, 23)
  WaitFrame(10)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.06, 2, 20, 23)
  WaitFrame(10)
  PostEffect.SetGlitchNoise(true, 2.0E-5, 0.03, 60, 0.03, 2, 20, 23)
  WaitFrame(10)
  PostEffect.SetSepiaFilter(false, 0, 0, false, false, 0)
  PostEffect.SetMonoFilter(false, 0, 0, false, false, 0)
  PostEffect.SetGlitchNoise(false, 0, 0, 0, 0, 0, 20, 23)
  WaitFrame(10)
end

function StartFilter_timetransition()
  Event_PlaySE(404039, 100, 0, 0, 0)
  PostEffect.SetGlitchBlock(true, 0.3, 1, 0, 60, 6)
  PostEffect.SetMonoFilter(true, 0.2, 0, false, false, 0)
  WaitFrame(10)
  PostEffect.SetGlitchBlock(true, 1, 1, 0, 40, 6)
  PostEffect.SetMonoFilter(true, 0.4, 0, false, false, 0)
  WaitFrame(10)
  PostEffect.SetGlitchBlock(true, 15, 1, 0, 20, 6)
  PostEffect.SetMonoFilter(true, 0.7, 0, false, false, 0)
  WaitFrame(10)
  PostEffect.SetGlitchBlock(true, 30, 1, 0, 10, 6)
  PostEffect.SetMonoFilter(true, 1, 0, false, false, 0)
end

function SetFilter_timetransition()
  PostEffect.SetGlitch(true, 0.25, 36, 1.5, 10, 0)
  PostEffect.SetMonoFilter(true, 0.7, 0, false, false, 0)
end

function EndFilter_timetransition()
  PostEffect.SetGlitch(true, 0.15, 36, 1.5, 10, 0)
  PostEffect.SetMonoFilter(true, 0.5, 0, false, false, 0)
  WaitFrame(30)
  PostEffect.SetGlitch(true, 0.05, 24, 1.5, 10, 0)
  PostEffect.SetMonoFilter(true, 0.3, 0, false, false, 0)
  WaitFrame(20)
  PostEffect.SetGlitch(true, 0.02, 10, 1.5, 10, 0)
  PostEffect.SetMonoFilter(true, 0.1, 0, false, false, 0)
  WaitFrame(10)
  PostEffect.SetGlitch(false, 0, 0, 0, 0, 0)
  PostEffect.SetMonoFilter(false, 0, 0, false, false, 0)
end

function SetEncountGlitch()
  Event_PlaySE(300001, 100, 0, 0, 0)
  PostEffect.SetGlitch(true, 0.02, 30, 20, 20, 0, 0)
  WaitFrame(4)
  PostEffect.SetGlitch(true, 0.04, 30, 20, 20, 0, 0)
  WaitFrame(2)
  PostEffect.SetGlitch(true, 0.11, 30, 20, 20, 0, 0)
  PostEffect.SetGlitchNoise(true, 1, 0.006, 0, 0, 0, 20, 23)
  WaitFrame(2)
  PostEffect.SetGlitch(true, 0.25, 30, 20, 20, 0, 0)
  WaitFrame(20)
end

function EndEncountGlitch()
  PostEffect.SetGlitch(false, 0.01, 36, 1.5, 10, 0, 0)
  PostEffect.SetGlitchNoise(false, 0.01, 1, 0, 0, 0, 1, 2)
  PostEffect.SetMonoFilter(false, 1, 0, false, false, 0)
end

function Event_PlayBGM(a_id, a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.PlayBGM(a_id, a_fade_time, a_timing)
  else
    Vista.PlayBGM(a_id, a_fade_time, 0)
  end
end

function Event_StopBGM(a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.StopBGM(a_fade_time, a_timing)
  else
    Vista.StopBGM(a_fade_time, 0)
  end
end

function Event_Stop_Play_BGM(a_id, a_play_fade_time, a_timing1, a_timing2, a_stop_fade_time)
  if a_timing1 ~= nil then
    Vista.StopBGM(a_stop_fade_time, a_timing1)
    WaitFrame(Util.FrameFromSecond(a_timing1))
  else
    Vista.StopBGM(a_stop_fade_time, 0)
  end
  WaitFrame(Util.FrameFromSecond(a_stop_fade_time))
  if a_timing2 ~= nil then
    Vista.PlayBGM(a_id, a_play_fade_time, a_timing2)
  else
    Vista.PlayBGM(a_id, a_play_fade_time, 0)
  end
  if a_stop_fade_time == nil then
    a_stop_fade_time = BGM_FADE_TIME
  end
end

function Event_SetBGMVolume(a_volume, a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.SetBGMVolume(a_volume, a_fade_time, a_timing)
  else
    Vista.SetBGMVolume(a_volume, a_fade_time, 0)
  end
end

function Event_PauseBGM(a_timing)
  if a_timing ~= nil then
    Vista.PauseBGM(a_timing)
  else
    Vista.PauseBGM(0)
  end
end

function Event_ResumeBGM(a_timing)
  if a_timing ~= nil then
    Vista.ResumeBGM(a_timing)
  else
    Vista.ResumeBGM(0)
  end
end

function Event_PlaySE(a_id, a_volume_percent, a_loop, a_fade_time, a_timing)
  local gender = GetGender()
  if a_id == 410001 then
    if gender == HEROINE then
      a_id = 410101
    end
  elseif a_id == 410002 then
    if gender == HEROINE then
      a_id = 410102
    end
  elseif a_id == 410003 then
    if gender == HEROINE then
      a_id = 410103
    end
  elseif a_id == 410004 then
    if gender == HEROINE then
      a_id = 410104
    end
  elseif a_id == 410005 then
    if gender == HEROINE then
      a_id = 410105
    end
  elseif a_id == 410006 then
    if gender == HEROINE then
      a_id = 410106
    end
  elseif a_id == 410007 then
    if gender == HEROINE then
      a_id = 410107
    end
  elseif a_id == 410008 then
    if gender == HEROINE then
      a_id = 410108
    end
  elseif a_id == 410009 then
    if gender == HEROINE then
      a_id = 410109
    end
  elseif a_id == 410010 then
    if gender == HEROINE then
      a_id = 410110
    end
  elseif a_id == 410011 then
    if gender == HEROINE then
      a_id = 410111
    end
  elseif a_id == 410012 then
    if gender == HEROINE then
      a_id = 410112
    end
  elseif a_id == 410013 then
    if gender == HEROINE then
      a_id = 410113
    end
  elseif a_id == 410014 then
    if gender == HEROINE then
      a_id = 410114
    end
  elseif a_id == 410015 then
    if gender == HEROINE then
      a_id = 410115
    end
  elseif a_id == 410016 then
    if gender == HEROINE then
      a_id = 410116
    end
  elseif a_id == 410017 then
    if gender == HEROINE then
      a_id = 410117
    end
  elseif a_id == 410018 then
    if gender == HEROINE then
      a_id = 410118
    end
  elseif a_id == 410019 then
    if gender == HEROINE then
      a_id = 410119
    end
  elseif a_id == 410020 then
    if gender == HEROINE then
      a_id = 410120
    end
  elseif a_id == 410021 then
    if gender == HEROINE then
      a_id = 410121
    end
  elseif a_id == 410022 then
    if gender == HEROINE then
      a_id = 410122
    end
  elseif a_id == 410023 then
    if gender == HEROINE then
      a_id = 410123
    end
  elseif a_id == 410024 then
    if gender == HEROINE then
      a_id = 410124
    end
  elseif a_id == 410025 then
    if gender == HEROINE then
      a_id = 410125
    end
  elseif a_id == 410026 then
    if gender == HEROINE then
      a_id = 410126
    end
  elseif a_id == 410027 then
    if gender == HEROINE then
      a_id = 410127
    end
  elseif a_id == 410028 then
    if gender == HEROINE then
      a_id = 410128
    end
  elseif a_id == 410029 then
    if gender == HEROINE then
      a_id = 410129
    end
  elseif a_id == 410030 then
    if gender == HEROINE then
      a_id = 410130
    end
  elseif a_id == 410031 then
    if gender == HEROINE then
      a_id = 410131
    end
  elseif a_id == 410032 then
    if gender == HEROINE then
      a_id = 410132
    end
  elseif a_id == 410033 and gender == HEROINE then
    a_id = 410133
  end
  if a_id == 500006 then
    CtrVibration(0.5, 0, 0.5)
  end
  if a_timing ~= nil then
    return Vista.PlaySE(a_id, a_volume_percent, a_loop, a_fade_time, a_timing)
  else
    return Vista.PlaySE(a_id, a_volume_percent, a_loop, a_fade_time, 0)
  end
end

function Event_StopSE(a_slot, a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.StopSE(a_slot, a_fade_time, a_timing)
  else
    Vista.StopSE(a_slot, a_fade_time, 0)
  end
end

function Event_StopAllSE(a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.StopAllSE(a_fade_time, a_timing)
  else
    Vista.StopAllSE(a_fade_time, 0)
  end
end

function Event_SetSEVolume(a_slot, a_volume, a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.SetSEVolume(a_slot, a_volume, a_fade_time, a_timing)
  else
    Vista.SetSEVolume(a_slot, a_volume, a_fade_time, 0)
  end
end

function Event_SetAllSEVolume(a_volume, a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.SetAllSEVolume(a_volume, a_fade_time, a_timing)
  else
    Vista.SetAllSEVolume(a_volume, a_fade_time, 0)
  end
end

function Event_PauseSE(a_slot, a_timing)
  if a_timing ~= nil then
    Vista.PauseSE(a_slot, a_timing)
  else
    Vista.PauseSE(a_slot, 0)
  end
end

function Event_ResumeSE(a_slot, a_timing)
  if a_timing ~= nil then
    Vista.ResumeSE(a_slot, a_timing)
  else
    Vista.ResumeSE(a_slot, 0)
  end
end

function Event_PlayVoice(a_id, a_timing)
  if a_timing ~= nil then
    Vista.PlayVoice(a_id, a_timing)
  else
    Vista.PlayVoice(a_id, 0)
  end
end

function Event_StopVoice(a_timing)
  if a_timing ~= nil then
    Vista.StopVoice(a_timing)
  else
    Vista.StopVoice(0)
  end
end

function Event_SetVoiceVolume(a_volume, a_fade_time, a_timing)
  if a_timing ~= nil then
    Vista.SetVoiceVolume(a_volume, a_fade_time, a_timing)
  else
    Vista.SetVoiceVolume(a_volume, a_fade_time, 0)
  end
end

function PlayPartVoice(charaID, voicetype)
  local str01 = "vo_"
  local str02 = ""
  local gender = GetGender()
  if charaID == "operator" then
    if gender == HERO then
      charaID = "pcf001"
    elseif gender == HEROINE then
      charaID = "pcm001"
    end
  end
  if voicetype == "Joy" then
    str02 = "_EventJoy_001"
  elseif voicetype == "Angry" then
    str02 = "_EventAngry_001"
  elseif voicetype == "Pity" then
    str02 = "_EventPity_001"
  elseif voicetype == "Susp" then
    str02 = "_EventSuspicious_001"
  elseif voicetype == "Joy1" then
    str02 = "_EventJoy_001"
  elseif voicetype == "Joy2" then
    str02 = "_EventJoy_002"
  elseif voicetype == "Joy3" then
    str02 = "_EventJoy_003"
  elseif voicetype == "Angry1" then
    str02 = "_EventAngry_001"
  elseif voicetype == "Angry2" then
    str02 = "_EventAngry_002"
  elseif voicetype == "Angry3" then
    str02 = "_EventAngry_003"
  elseif voicetype == "Pity1" then
    str02 = "_EventPity_001"
  elseif voicetype == "Pity2" then
    str02 = "_EventPity_002"
  elseif voicetype == "Pity3" then
    str02 = "_EventPity_003"
  elseif voicetype == "Susp1" then
    str02 = "_EventSuspicious_001"
  elseif voicetype == "Susp2" then
    str02 = "_EventSuspicious_002"
  elseif voicetype == "Susp3" then
    str02 = "_EventSuspicious_003"
  elseif voicetype == "Other1" then
    str02 = "_EventOther_001"
  elseif voicetype == "Other2" then
    str02 = "_EventOther_002"
  elseif voicetype == "Other3" then
    str02 = "_EventOther_003"
  elseif voicetype == "Other4" then
    str02 = "_EventOther_004"
  elseif voicetype == "Other5" then
    str02 = "_EventOther_005"
  elseif voicetype == "Other6" then
    str02 = "_EventOther_006"
  end
  local VoiceName = str01 .. charaID .. str02
  print("===================")
  print(VoiceName)
  print("===================")
  Event_PlayVoice(VoiceName, 0)
end

function Load_DigiviceHologram()
  local gender = GetGender()
  if gender == HERO then
    LoadModel("Horo_AGENT", "pc022aa010101")
  elseif gender == HEROINE then
    LoadModel("Horo_AGENT", "pc021aa010101")
  end
  Vista.LoadAnimationFace("Horo_AGENT", "e01", "m01")
  Vista.BindSpeaker("Horo_AGENT", "char_OPERATOR_M")
  LoadEffectScript("Horo_Effect", "ef_e_com_070")
  LoadObject("ATCdigivice00_01", "ATCdigivice00")
  Vista.LoadDissolve("Horo_AGENT", 401)
  Vista.LoadAnimation("HERO_01", "e200")
  Vista.LoadAnimation("ATCdigivice00_01", "e200")
  Vista.LoadAnimation("Horo_AGENT", "e002")
  Vista.LoadAnimation("Horo_AGENT", "e004")
  Vista.LoadAnimation("Horo_AGENT", "e005")
  Vista.LoadAnimation("Horo_AGENT", "e006")
  Vista.LoadAnimation("Horo_AGENT", "e007")
  Vista.LoadAnimation("Horo_AGENT", "e008")
  Vista.LoadAnimation("Horo_AGENT", "e012")
  Vista.LoadAnimation("Horo_AGENT", "e013")
  Vista.LoadAnimation("Horo_AGENT", "e014")
  Vista.LoadAnimation("Horo_AGENT", "e015")
  Vista.LoadAnimation("Horo_AGENT", "e020")
  Vista.LoadAnimation("Horo_AGENT", "e021")
  Vista.LoadAnimation("Horo_AGENT", "e023")
  Vista.LoadAnimation("Horo_AGENT", "e030")
  Vista.LoadAnimation("Horo_AGENT", "e031")
  Vista.LoadAnimation("Horo_AGENT", "e032")
  Vista.LoadAnimation("Horo_AGENT", "e033")
  Vista.LoadAnimation("Horo_AGENT", "e002_01")
  Vista.LoadAnimation("Horo_AGENT", "e004_01")
  Vista.LoadAnimation("Horo_AGENT", "e005_01")
  Vista.LoadAnimation("Horo_AGENT", "e006_01")
  Vista.LoadAnimation("Horo_AGENT", "e007_01")
  Vista.LoadAnimation("Horo_AGENT", "e008_01")
  Vista.LoadAnimation("Horo_AGENT", "e010_01")
  Vista.LoadAnimation("Horo_AGENT", "e012_01")
  Vista.LoadAnimation("Horo_AGENT", "e013_01")
  Vista.LoadAnimation("Horo_AGENT", "e014_01")
  Vista.LoadAnimation("Horo_AGENT", "e015_01")
  Vista.LoadAnimation("Horo_AGENT", "e021_01")
  Vista.LoadAnimation("Horo_AGENT", "e033_01")
  Vista.LoadAnimationBlend("Horo_AGENT", "blend01")
  Vista.LoadAnimationBlend("Horo_AGENT", "blend02")
  Vista.LoadAnimationBlend("Horo_AGENT", "blend03")
  Vista.LoadAnimationBlend("Horo_AGENT", "blend05")
end

function Set_DigiviceHologram()
  PlayMotion("Horo_AGENT", "fn01_01", 0, true, 0)
  SetFace("Horo_AGENT", "F01", 0, 1, 0, 0)
  ModelVisible("Horo_AGENT", false, 0, 0)
  AttachObject("HERO_01", "ATCdigivice00_01", "9")
  ModelVisible("ATCdigivice00_01", false, 0, 0)
  BlendFace("Horo_AGENT", -50, 0, 0, true, "SCURVE", 0, 0)
end

function Play_DigiviceHologram()
  PlayMotion("HERO_01", "e200", 5, true, 0)
  WaitFrame(15)
  Vista.AttachModelToModel("ATCdigivice00_01", "Horo_AGENT", "holo")
  Vista.SetModelAlpha("Horo_AGENT", 0.7)
  Vista.SetModelPhantom("Horo_AGENT", 0.3, 0.9, 1)
  Vista.SetAttachModelScale("Horo_AGENT", 0.2)
  Vista.SetAttachModelPos("Horo_AGENT", 0, -0.8, -0.5)
  Vista.SetAttachModelRot("Horo_AGENT", -30, 0, 0)
  ModelVisible("ATCdigivice00_01", true, 0, 0)
  PlayMotion("ATCdigivice00_01", "e200", 0, true, 0)
  SetLoopFrame("ATCdigivice00_01", "e200", 100, 200)
  Event_PlaySE(400029, 100, false, 0, 0.3)
  WaitFrame(55)
  Event_PlaySE(401052, 100, false, 0, 0)
  WaitFrame(25)
  Vista.AttachEffectToModel("Horo_Effect", "ATCdigivice00_01", "holo")
  PlayEffect("Horo_Effect", true, 0)
  ModelVisible("Horo_AGENT", true, 0, 0)
  Vista.PlayDissolve("Horo_AGENT", 401)
end

function Close_DigiviceHologram()
  Vista.PlayDissolve("Horo_AGENT", 402)
  WaitFrame(5)
  EndMotion("HERO_01", 0)
  EndMotion("ATCdigivice00_01", 0)
  WaitFrame(10)
  Event_PlaySE(401053, 100, false, 0, 0)
  Event_PlaySE(400029, 100, false, 0, 1)
  ModelVisible("Horo_Effect", false, 15, 0)
  ENDMOTION_WAIT("HERO_01", 0)
  ModelVisible("ATCdigivice00_01", false, 0, 0)
end

function Load_DigiviceHologram_Mirei()
  LoadModel("Horo_MIREI", "char_MIREI_CHILD")
  Vista.LoadAnimationFace("Horo_MIREI", "e01", "m01")
  Vista.BindSpeaker("Horo_MIREI", "char_MIREI_CHILD")
  LoadEffectScript("Horo_Effect", "ef_e_com_070")
  LoadObject("ATCdigivice00_01", "ATCdigivice00")
  Vista.LoadDissolve("Horo_MIREI", 403)
  Vista.LoadAnimation("HERO_01", "e200")
  Vista.LoadAnimation("ATCdigivice00_01", "e200")
  Vista.LoadAnimation("Horo_MIREI", "e002")
  Vista.LoadAnimation("Horo_MIREI", "e003")
  Vista.LoadAnimation("Horo_MIREI", "e021")
  Vista.LoadAnimation("Horo_MIREI", "e550")
  Vista.LoadAnimation("Horo_MIREI", "e551")
  Vista.LoadAnimationBlend("Horo_MIREI", "blend01")
  Vista.LoadAnimationBlend("Horo_MIREI", "blend02")
  Vista.LoadAnimationBlend("Horo_MIREI", "blend03")
  Vista.LoadAnimationBlend("Horo_MIREI", "blend05")
end

function Set_DigiviceHologram_Mirei()
  PlayMotion("Horo_MIREI", "fn01_01", 0, true, 0)
  SetFace("Horo_MIREI", "F01", 0, 1, 0, 0)
  ModelVisible("Horo_MIREI", false, 0, 0)
  AttachObject("HERO_01", "ATCdigivice00_01", "9")
  ModelVisible("ATCdigivice00_01", false, 0, 0)
  BlendFace("Horo_MIREI", -50, 0, 0, true, "SCURVE", 0, 0)
end

function Play_DigiviceHologram_Mirei()
  PlayMotion("HERO_01", "e200", 5, true, 0)
  WaitFrame(15)
  Vista.AttachModelToModel("ATCdigivice00_01", "Horo_MIREI", "holo")
  Vista.SetModelAlpha("Horo_MIREI", 0.7)
  Vista.SetModelPhantom("Horo_MIREI", 0.3, 0.9, 1)
  Vista.SetAttachModelScale("Horo_MIREI", 0.2)
  Vista.SetAttachModelPos("Horo_MIREI", 0, -0.55, -0.3)
  Vista.SetAttachModelRot("Horo_MIREI", -35, 0, 0)
  ModelVisible("ATCdigivice00_01", true, 0, 0)
  PlayMotion("ATCdigivice00_01", "e200", 0, true, 0)
  SetLoopFrame("ATCdigivice00_01", "e200", 100, 200)
  Event_PlaySE(400029, 100, false, 0, 0.3)
  WaitFrame(55)
  Event_PlaySE(401052, 100, false, 0, 0)
  WaitFrame(25)
  Vista.AttachEffectToModel("Horo_Effect", "ATCdigivice00_01", "holo")
  PlayEffect("Horo_Effect", true, 0)
  ModelVisible("Horo_MIREI", true, 0, 0)
  Vista.PlayDissolve("Horo_MIREI", 403)
end

function Close_DigiviceHologram_Mirei()
  Vista.PlayDissolve("Horo_MIREI", 404)
  WaitFrame(5)
  EndMotion("HERO_01", 0)
  EndMotion("ATCdigivice00_01", 0)
  WaitFrame(10)
  Event_PlaySE(401053, 100, false, 0, 0)
  Event_PlaySE(400029, 100, false, 0, 1)
  ModelVisible("Horo_Effect", false, 15, 0)
  ENDMOTION_WAIT("HERO_01", 0)
  ModelVisible("ATCdigivice00_01", false, 0, 0)
end

function Load_Relief()
  LoadObject("t3001digi01_01", "t3001digi01")
  LoadObject("t3001digi02_01", "t3001digi02")
  LoadObject("t3001digi03_01", "t3001digi03")
  LoadObject("t3001digi04_01", "t3001digi04")
  LoadObject("t3001digi05_01", "t3001digi05")
  LoadObject("t3001digi06_01", "t3001digi06")
  LoadObject("t3001digi07_01", "t3001digi07")
  LoadObject("t3001digi08_01", "t3001digi08")
  LoadObject("t3001digi09_01", "t3001digi09")
  LoadObject("t3001digi10_01", "t3001digi10")
  LoadObject("t3001digi11_01", "t3001digi11")
  LoadObject("t3001digi12_01", "t3001digi12")
  LoadObject("t3001movewall00_01", "t3001movewall00")
  LoadObject("t3001reliefparts01_01", "t3001reliefparts01")
  LoadObject("t3001reliefparts02_01", "t3001reliefparts02")
  LoadObject("t3001reliefparts03_01", "t3001reliefparts03")
  LoadObject("t3001reliefparts04_01", "t3001reliefparts04")
  LoadObject("t3001reliefparts05_01", "t3001reliefparts05")
  LoadObject("t3001reliefparts06_01", "t3001reliefparts06")
  LoadObject("t3001reliefparts07_01", "t3001reliefparts07")
  LoadObject("t3001reliefparts08_01", "t3001reliefparts08")
  LoadObject("t3001reliefparts09_01", "t3001reliefparts09")
  LoadObject("t3001reliefparts10_01", "t3001reliefparts10")
  LoadObject("t3001reliefparts11_01", "t3001reliefparts11")
  LoadObject("t3001reliefparts12_01", "t3001reliefparts12")
  LoadObject("t3001jewel01_01", "t3001jewel01")
  LoadObject("t3001jewel02_01", "t3001jewel02")
  LoadObject("t3001jewel03_01", "t3001jewel03")
  LoadObject("t3001jewel04_01", "t3001jewel04")
  LoadObject("t3001jewel05_01", "t3001jewel05")
  LoadObject("t3001jewel06_01", "t3001jewel06")
  LoadObject("t3001jewel07_01", "t3001jewel07")
  LoadObject("t3001jewel08_01", "t3001jewel08")
  LoadObject("t3001jewel09_01", "t3001jewel09")
  LoadObject("t3001jewel10_01", "t3001jewel10")
  LoadObject("t3001jewel11_01", "t3001jewel11")
  LoadObject("t3001jewel12_01", "t3001jewel12")
  Vista.LoadAnimation("t3001digi01_01", "e001")
  Vista.LoadAnimation("t3001digi01_01", "e002")
  Vista.LoadAnimation("t3001digi02_01", "e001")
  Vista.LoadAnimation("t3001digi02_01", "e002")
  Vista.LoadAnimation("t3001digi03_01", "e001")
  Vista.LoadAnimation("t3001digi03_01", "e002")
  Vista.LoadAnimation("t3001digi04_01", "e001")
  Vista.LoadAnimation("t3001digi04_01", "e002")
  Vista.LoadAnimation("t3001digi05_01", "e001")
  Vista.LoadAnimation("t3001digi05_01", "e002")
  Vista.LoadAnimation("t3001digi06_01", "e001")
  Vista.LoadAnimation("t3001digi06_01", "e002")
  Vista.LoadAnimation("t3001digi07_01", "e001")
  Vista.LoadAnimation("t3001digi07_01", "e002")
  Vista.LoadAnimation("t3001digi08_01", "e001")
  Vista.LoadAnimation("t3001digi08_01", "e002")
  Vista.LoadAnimation("t3001digi09_01", "e001")
  Vista.LoadAnimation("t3001digi09_01", "e002")
  Vista.LoadAnimation("t3001digi10_01", "e001")
  Vista.LoadAnimation("t3001digi10_01", "e002")
  Vista.LoadAnimation("t3001digi11_01", "e001")
  Vista.LoadAnimation("t3001digi11_01", "e002")
  Vista.LoadAnimation("t3001digi12_01", "e001")
  Vista.LoadAnimation("t3001digi12_01", "e002")
  Vista.LoadAnimation("t3001movewall00_01", "e001")
  Vista.LoadAnimation("t3001movewall00_01", "e002")
  Vista.LoadAnimation("t3001reliefparts01_01", "e001")
  Vista.LoadAnimation("t3001reliefparts01_01", "e002")
  Vista.LoadAnimation("t3001reliefparts02_01", "e001")
  Vista.LoadAnimation("t3001reliefparts02_01", "e002")
  Vista.LoadAnimation("t3001reliefparts03_01", "e001")
  Vista.LoadAnimation("t3001reliefparts03_01", "e002")
  Vista.LoadAnimation("t3001reliefparts04_01", "e001")
  Vista.LoadAnimation("t3001reliefparts04_01", "e002")
  Vista.LoadAnimation("t3001reliefparts05_01", "e001")
  Vista.LoadAnimation("t3001reliefparts05_01", "e002")
  Vista.LoadAnimation("t3001reliefparts06_01", "e001")
  Vista.LoadAnimation("t3001reliefparts06_01", "e002")
  Vista.LoadAnimation("t3001reliefparts07_01", "e001")
  Vista.LoadAnimation("t3001reliefparts07_01", "e002")
  Vista.LoadAnimation("t3001reliefparts08_01", "e001")
  Vista.LoadAnimation("t3001reliefparts08_01", "e002")
  Vista.LoadAnimation("t3001reliefparts09_01", "e001")
  Vista.LoadAnimation("t3001reliefparts09_01", "e002")
  Vista.LoadAnimation("t3001reliefparts10_01", "e001")
  Vista.LoadAnimation("t3001reliefparts10_01", "e002")
  Vista.LoadAnimation("t3001reliefparts11_01", "e001")
  Vista.LoadAnimation("t3001reliefparts11_01", "e002")
  Vista.LoadAnimation("t3001jewel01_01", "e001")
  Vista.LoadAnimation("t3001jewel01_01", "e002")
  Vista.LoadAnimation("t3001jewel02_01", "e001")
  Vista.LoadAnimation("t3001jewel02_01", "e002")
  Vista.LoadAnimation("t3001jewel03_01", "e001")
  Vista.LoadAnimation("t3001jewel03_01", "e002")
  Vista.LoadAnimation("t3001jewel04_01", "e001")
  Vista.LoadAnimation("t3001jewel04_01", "e002")
  Vista.LoadAnimation("t3001jewel05_01", "e001")
  Vista.LoadAnimation("t3001jewel05_01", "e002")
  Vista.LoadAnimation("t3001jewel06_01", "e001")
  Vista.LoadAnimation("t3001jewel06_01", "e002")
  Vista.LoadAnimation("t3001jewel07_01", "e001")
  Vista.LoadAnimation("t3001jewel07_01", "e002")
  Vista.LoadAnimation("t3001jewel08_01", "e001")
  Vista.LoadAnimation("t3001jewel08_01", "e002")
  Vista.LoadAnimation("t3001jewel09_01", "e001")
  Vista.LoadAnimation("t3001jewel09_01", "e002")
  Vista.LoadAnimation("t3001jewel10_01", "e001")
  Vista.LoadAnimation("t3001jewel10_01", "e002")
  Vista.LoadAnimation("t3001jewel11_01", "e001")
  Vista.LoadAnimation("t3001jewel11_01", "e002")
  Vista.LoadAnimation("t3001jewel12_01", "e001")
  Vista.LoadAnimation("t3001jewel12_01", "e002")
end

function SetPosition_Relief()
  SetPosition("t3001digi01_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi02_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi03_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi04_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi05_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi06_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi07_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi08_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi09_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi10_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi11_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001digi12_01", 0, 10.5, -24.3, "LINEAR", 0, 0)
  SetPosition("t3001movewall00_01", 0, 7.8, -25.1, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts01_01", -3.3, 12.57, -25.45, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts02_01", 3.3, 12.57, -25.45, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts03_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts04_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts05_01", 3.3, 12.57, -25.45, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts06_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts07_01", -3.3, 12.57, -25.45, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts08_01", 3.3, 12.57, -25.45, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts09_01", -3.3, 12.57, -25.45, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts10_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts11_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001reliefparts12_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel07_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel02_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel10_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel04_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel11_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel06_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel01_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel08_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel09_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel03_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel05_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
  SetPosition("t3001jewel12_01", 0, 12.57, -24.85, "LINEAR", 0, 0)
end

function PlayMotion_Relief()
  PlayMotion("t3001digi01_01", "e002", 0, false, 0)
  PlayMotion("t3001digi02_01", "e002", 0, false, 0)
  PlayMotion("t3001digi03_01", "e002", 0, false, 0)
  PlayMotion("t3001digi04_01", "e002", 0, false, 0)
  PlayMotion("t3001digi05_01", "e002", 0, false, 0)
  PlayMotion("t3001digi06_01", "e002", 0, false, 0)
  PlayMotion("t3001digi07_01", "e002", 0, false, 0)
  PlayMotion("t3001digi08_01", "e002", 0, false, 0)
  PlayMotion("t3001digi09_01", "e002", 0, false, 0)
  PlayMotion("t3001digi10_01", "e002", 0, false, 0)
  PlayMotion("t3001digi11_01", "e002", 0, false, 0)
  PlayMotion("t3001digi12_01", "e002", 0, false, 0)
  PlayMotion("t3001movewall00_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts01_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts02_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts03_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts04_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts05_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts06_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts07_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts08_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts09_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts10_01", "e002", 0, false, 0)
  PlayMotion("t3001reliefparts11_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel01_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel01_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel02_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel03_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel04_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel05_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel06_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel07_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel08_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel09_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel10_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel11_01", "e002", 0, false, 0)
  PlayMotion("t3001jewel12_01", "e002", 0, false, 0)
end

function ObjectInvisible(index)
  Vista.GimmickObjectInvisible(index)
end

function NpcInvisible(index)
  Vista.NpcInvisible(index)
end

function RumorNpcInvisible(index)
  Vista.RumorNpcInvisible(index)
end

function SetTimeZone(a_name)
  Vista.SetTimeZone(a_name)
end

function SetTimeAxis(a_time_axis_id)
  Vista.SetTimeAxis(a_time_axis_id)
end

function SetMapStatus(status)
  Vista.SetMapStatus(status)
end

function FieldInitCancel()
  Vista.RequestNotSetInitPose()
end

EventModel = {}

function EventModel:new(manage_name, model_name)
  local obj = {}
  obj.manage_name = manage_name
  obj.model_name = model_name
  Vista.LoadModelID(obj.manage_name, obj.model_name)
  
  function obj:LoadAnimation(animation, ...)
    local t = table.pack(animation, ...)
    for i = 1, #t do
      Vista.LoadAnimation(self.manage_name, t[i])
    end
  end
  
  function obj:PlayAnimation(animation_name, blend_frame, is_loop, timing)
    if blend_frame == nil then
      blend_frame = 0
    end
    if is_loop == nil then
      is_loop = true
    end
    if timing == nil then
      timing = 0
    end
    Vista.PlayAnimation(self.manage_name, animation_name, blend_frame, is_loop, timing)
    if not string.find(self.manage_name, "chr") then
      if animation_name == "e014" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, timing + 60)
      elseif animation_name == "e014" then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, 60)
      elseif animation_name == "e019" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, timing + 87)
      elseif animation_name == "e019" then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, 87)
      elseif animation_name == "e020" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, timing + 78)
      elseif animation_name == "e020" then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, 78)
      elseif animation_name == "e050" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fs01_01", 6, true, timing + 83)
      elseif animation_name == "e050" then
        Vista.PlayAnimation(self.manage_name, "fs01_01", 6, true, 83)
      elseif animation_name == "e051" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, timing + 93)
      elseif animation_name == "e051" then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 6, true, 93)
      elseif animation_name == "ft01_01" or animation_name == "ft01_02" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 0, true, timing + 30)
      elseif animation_name == "ft01_01" or animation_name == "ft01_02" then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 0, true, 30)
      elseif animation_name == "ft02_01" or animation_name == "ft02_02" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 0, true, timing + 40)
      elseif animation_name == "ft02_01" or animation_name == "ft02_02" then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 0, true, 40)
      elseif animation_name == "ft03_01" and 1 <= timing then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 0, true, timing + 25)
      elseif animation_name == "ft03_01" then
        Vista.PlayAnimation(self.manage_name, "fn01_01", 0, true, 25)
      end
    end
  end
  
  function obj:SetPosition(x, y, z, way, frame, timing)
    if way == nil then
      way = "LINEAR"
    end
    if frame == nil then
      frame = 0
    end
    if timing == nil then
      timing = 0
    end
    Vista.SetPositionWithTiming(self.manage_name, x, y, z, way, frame, timing)
  end
  
  function obj:MovePosition(x, y, z, is_floor, speed, timing)
    if is_floor == nil then
      is_floor = false
    end
    if speed == nil then
      speed = 1
    end
    if timing == nil then
      timing = 0
    end
    Vista.MovePosition(self.manage_name, x, y, z, is_floor, speed, timing)
  end
  
  function obj:SetRotation(x, y, z, way, frame, timing)
    if way == nil then
      way = "LINEAR"
    end
    if frame == nil then
      frame = 0
    end
    if timing == nil then
      timing = 0
    end
    Vista.SetRotationWithTiming(self.manage_name, x, y, z, way, frame, timing)
  end
  
  function obj:MoveRotation(x, y, z, way, speed, pre_rot, timing)
    if way == nil then
      way = "LINEAR"
    end
    if speed == nil then
      speed = 1
    end
    if pre_rot == nil then
      pre_rot = true
    end
    if timing == nil then
      timing = 0
    end
    Vista.MoveRotation(self.manage_name, x, y, z, way, speed, pre_rot, timing)
  end
  
  function obj:SetSclae(x, y, z)
    if x == nil then
      x = 1
    end
    if y == nil then
      y = 1
    end
    if z == nil then
      z = 1
    end
    Vista.SetScale(self.manage_name, x, y, z)
  end
  
  return obj
end

function EventRankSet(rank)
  Vista.SetEventRankInfo(rank)
end

function CtrVibration(low, high, time, timing)
  if timing == nil then
    timing = 0
  end
  Vista.SetVibration(low, high, time, timing)
end

function DEBUG_WAIT()
  local count = 0
  while true do
    if Work.IsPushKey("DECIDE") then
      print("======PressTime========")
      print(count)
      print("======PressTime========")
      break
    end
    count = count + 1
    WaitFrame(Util.SecondFromFrame(1))
  end
  WaitFrame(Util.SecondFromFrame(5))
end
