Sarena_300 = {
  ID = 300,
  STEP_001 = 1,
  STEP_010 = 10,
  STEP_020 = 20,
  STEP_255 = 255
}
local text_file = ""

function Sarena_300:GreatestOmegaCarnival_Start()
  if not Flg.Check("FLAG_IS_START_Sarena_300") then
    Quest.QuickReceive(self.ID)
    Quest.SetFlag(self.ID, self.STEP_001)
    Flg.Set("FLAG_IS_START_Sarena_300")
  end
end

function Sarena_300:GreatestOmegaCarnival_Entry()
  if Qst.Sub:Check(self.ID, self.STEP_001, self.STEP_010) then
    Qst.Sub:Set(self.ID, self.STEP_010, true)
  end
end

function Sarena_300:GreatestOmegaCarnival_AppearMarusmon()
  if Qst.Sub:Check(self.ID, self.STEP_010, self.STEP_020) then
    Qst.Sub:Set(self.ID, self.STEP_020, true)
  end
end

function Sarena_300:GreatestOmegaCarnival_End()
  if Qst.Sub:Check(self.ID, self.STEP_020, self.STEP_255) then
    Qst.Sub:End(self.ID, self.STEP_255)
    Flg.Set("FLAG_IS_CLEAR_Sarena_300")
  end
end
