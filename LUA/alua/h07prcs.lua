gGimText = "field_text"

function Prcs_h07_battle(flag, direction)
  local move_x = 0
  local move_z = 0
  if direction == "left" then
    move_x = -2
    move_z = 0
  elseif direction == "right" then
    move_x = 2
    move_z = 0
  elseif direction == "up" then
    move_x = 0
    move_z = -2
  elseif direction == "down" then
    move_x = 0
    move_z = 2
  end
  Message(2070000000)
  MessageTalkSel(2, 2070000001)
  local result = Talk.GetResultSelectedNum()
  if result == RESULT_TALK00 then
    Flg.Set(flag)
    Field_Talk_End()
    EncountFromField(90718, 20771, false)
  else
    MovePlayerToRelativePosFrame(move_x, move_z, 30)
  end
end

function CallEvent(event_id)
  if event_id == 45 then
    M420:Event_045()
    FieldObjectSync(FOR_ALL, false)
    Flg.Set("FLAG_MAIN_20_025")
  elseif event_id == 50 then
    M420:Event_050()
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(10)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(5)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    Flg.Set("FLAG_MAIN_20_030")
  elseif event_id == 60 then
    M420:Event_060()
    Flg.Set("FLAG_MAIN_20_040")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(10)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(5)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    Flg.Set("FLAG_MAIN_20_030")
  elseif event_id == 70 then
    M420:Event_070()
    Flg.Set("FLAG_MAIN_20_050")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(10)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(5)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    Flg.Set("FLAG_MAIN_20_030")
  elseif event_id == 80 then
    M420:Event_080()
    Flg.Set("FLAG_MAIN_20_060")
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(10)
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(5)
    FadeAllInWithWait(FADE_WHITE, FADE_TIME)
    Flg.Set("FLAG_MAIN_20_030")
  elseif event_id == 90 then
    Fade_OutNoLoadingWithWait(FADE_WHITE, FADE_TIME)
    WaitFrame(10)
    Flg.Set("FLAG_MAIN_20_075")
    FieldObjectSync(FOR_ALL, false)
    WaitFrame(5)
    WaitFrame(1)
    M420:Event_090()
  end
end

function CallSync()
  Field.ObjectCheckSync(MOB, false)
end
