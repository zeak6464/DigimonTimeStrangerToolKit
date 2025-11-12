local ObjectName = "cubeTower_mesh_"
local COUNT = 65
local name = {}
for i = 1, COUNT do
  name[i] = ObjectName .. i
end

function entryJoint()
  return name
end

function main()
  local COUNT = 65
  local time = GetTime()
  if not initialize then
    ry = math.random() * 10
    initialize = true
  else
    for i = 1, COUNT do
      SetScale(i, math.sin(time + 100 * (i + ry) * 0.5) * 0.2 + 0.3)
      SetRotY(i, time * 0.25 + i * 1.5)
    end
  end
end
