require("include_battle")
require("battle_define")

function Skill_Shoot(info)
  Battle.SetBattleCamera(13, info.group, info.index)
  WaitFrame(90)
end
