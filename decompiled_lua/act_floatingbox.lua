local ObjectName = "floatingbox_Model_"
local COUNT = 100
local name = {}
for i = 1, COUNT do
  name[i] = ObjectName .. i
end
name[COUNT + 1] = "act_floatingbox_pos"

function entryJoint()
  return name
end

forceOperateAnime = false

function main()
  COUNT = 100
  time = GetTime()
  if not initialize then
    px1 = {}
    py1 = {}
    pz1 = {}
    rx1 = {}
    ry1 = {}
    rz1 = {}
    for i = 1, COUNT do
      x, y, z = GetPos()
      px1[i] = x + (math.random() * 10 - 10)
      py1[i] = y + (math.random() * 10 - 10)
      pz1[i] = z + (math.random() * 10 - 10)
      rx1[i] = math.random() * 45
      ry1[i] = math.random() * 45
      rz1[i] = math.random() * 45
    end
    initialize = true
  else
    x, y, z = GetPlayerPos()
    for i = 1, COUNT do
      SetPosX(i, px1[i] + (math.sin(time / 50 + px1[i] + 0.01) + px1[i]) + px1[i])
      SetPosY(i, py1[i] + (math.sin(time / 25 + py1[i] + 0.01) + py1[i]) + py1[i])
      SetPosZ(i, pz1[i] + (math.sin(time / 50 + pz1[i] + pz1[i] * 0.01) + pz1[i]) + pz1[i])
      SetRotX(i, rx1[i] + math.sin(time / 10 * (rx1[i] / 100) * rx1[i] + rx1[i]))
      SetRotY(i, ry1[i] + math.sin(time / 100 * (ry1[i] / 100) * ry1[i] + ry1[i]))
      SetRotZ(i, rz1[i] + math.sin(time / 10 * (rz1[i] / 100) * rz1[i] + rz1[i]))
    end
  end
  px, py, pz = GetPlayerPos()
  SetRotY(101, time / 20)
  SetRotX(101, time / 100)
  SetPosZ(101, pz)
  SetPosX(101, px)
end
