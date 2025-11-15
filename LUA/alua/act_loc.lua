local ObjectName = "act_loc_mesh_"
local COUNT = 200
local name = {}
for i = 1, COUNT do
  name[i] = ObjectName .. i
end

function entryJoint()
  return name
end

forceOperateAnime = true

function main()
  COUNT = 200
  time = GetTime()
  if not initialize then
    px1 = {}
    py1 = {}
    pz1 = {}
    rx1 = {}
    ry1 = {}
    rz1 = {}
    px2 = {}
    py2 = {}
    pz2 = {}
    Rand1 = {}
    Rand2 = {}
    Rand3 = {}
    Rand4 = {}
    Rand5 = {}
    for i = 1, COUNT do
      if i % 2 == 1 then
        py1[i] = math.random()
        pz1[i] = math.random() * math.random() * 2
        rx1[i] = 0
        rz1[i] = math.random(360)
        SetPosY(i, py1[i])
        SetPosZ(i, pz1[i])
        SetRotZ(i, rz1[i])
      else
        Rand1[i] = math.random() * 0.5
        Rand2[i] = math.random()
        Rand3[i] = math.random() + math.random(2, 3)
        Rand4[i] = math.random() + math.random(1, 2)
        Rand5[i] = (math.random() + 1) / 10
        SetPosY(i, Rand1[i])
      end
    end
    initialize = true
  else
    x, y, z = GetPlayerPos()
    for i = 1, COUNT do
      if i % 2 == 1 then
        ox, oy, oz = GetJointPos(i)
        kyori = math.sqrt(math.pow(ox - x, 2) + math.pow(oy - y, 2) + math.pow(oz - z, 2))
        SetRotZ(i, rz1[i] + time * Rand5[i + 1] * 10)
        SetRotX(i, rx1[i] + math.sin(time * 0.2) * 0.2 + 0.2)
      elseif 3 >= kyori then
        SetPosY(i, Rand1[i] + math.abs(kyori) + 0.2 + math.sin((time + Rand2[i]) * Rand3[i]) * Rand4[i] * Rand5[i])
      else
        SetPosY(i, Rand1[i] + 3 + math.sin((time + Rand2[i]) * Rand3[i]) * Rand4[i] * Rand5[i])
      end
    end
  end
end
