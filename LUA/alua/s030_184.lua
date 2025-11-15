S030_184 = {
  ID = 184,
  STEP_001 = 1,
  STEP_255 = 255
}

function S030_184:Event_010()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_255) then
    Qst.Sub:End(self.ID, self.STEP_255)
  end
end
