local nfx1, nfy1, nfz1 = {}, {}, {}
local nfx2, nfy2, nfz2 = {}, {}, {}
local nfy3 = {}
local nfy4 = {}
local e_num, count, frame_x, frame_y, frame_z
local value_x = 0.2
local value_y = 0.3
local value_z = 0.2
local noise_frame_x1 = 48
local noise_frame_y1 = 39
local noise_frame_z1 = 55
local noise_value_x1 = 0.1
local noise_value_y1 = 0.3
local noise_value_z1 = 0.1
local noise_cycle_x1 = 11
local noise_cycle_y1 = 23
local noise_cycle_z1 = 9
local noise_frame_y2 = 51
local noise_value_y2 = 0.1
local noise_cycle_y2 = 29
local num

function Start()
  e_num = math.floor(math.sqrt(GetInstanceCount()))
  count = 0
  frame_x = e_num * 2
  frame_y = e_num * 2
  frame_z = e_num * 2
  num = math.max(noise_cycle_x1, noise_cycle_y1, noise_cycle_z1, noise_cycle_y2)
  for i = 1, GetInstanceCount() do
    SetInstanceScale(i, 1.1, 1.1, 1.1)
  end
end

function Update()
  for i = 1, num do
    nfx1[i] = math.sin(6.28 / noise_frame_x1 * (count + i * (noise_cycle_x1 + 1))) * noise_value_x1
    nfy1[i] = math.sin(6.28 / noise_frame_y1 * (count + i)) * noise_value_y1 + math.sin(6.28 / noise_frame_y1 * (count + i * 2 % (noise_cycle_y1 * 2 + 1))) * noise_value_y1 * 0.5
    nfz1[i] = math.sin(6.28 / noise_frame_z1 * (count + i * (noise_cycle_z1 + 1))) * noise_value_z1
    nfy2[i] = math.sin(6.28 / noise_frame_y2 * (count + i)) * noise_value_y2 + math.sin(6.28 / noise_frame_y2 * (count + i * 2 % (noise_cycle_y2 * 2 + 1))) * noise_value_y2 * 0.5
  end
  for i = 1, GetInstanceCount() do
    SetInstancePosition(i, math.sin(6.28 / frame_x * (count + (i * 8 % (e_num * 2) + 1))) * value_x + nfx1[i % noise_cycle_x1 + 1], math.sin(6.28 / frame_y * (count + i * 8)) * value_y + math.sin(6.28 / frame_y * (count + (i * 8 % (e_num * 2 + 1) + 1))) * value_y * 0.5 + nfy1[i % noise_cycle_y1 + 1] + nfy2[i % noise_cycle_y2 + 1], math.sin(6.28 / frame_z * (count + i * 4)) * value_z + nfz1[i % noise_cycle_z1 + 1])
    SetInstanceRotation(i, math.atan(math.sin(6.28 / frame_x * (count + (i * 8 % (e_num * 2) + 1))) * value_x + nfx1[i % noise_cycle_x1 + 1]) * 1.5, math.rad(math.sin(0.0785 * (count + i)) * 30), math.atan(math.sin(6.28 / frame_z * (count + i * 4)) * value_z + nfz1[i % noise_cycle_z1 + 1]) * 1.5)
  end
  count = count + GetDeltaFrame(30)
end
