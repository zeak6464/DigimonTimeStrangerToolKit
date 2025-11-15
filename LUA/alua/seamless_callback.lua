function OnSeamlessAnalyzeDestinationByLinkCollision(col_name)
  first_name, col_name = _SingleSplit(col_name)
  
  if first_name ~= "col" then
    return
  end
  local base_staging_name = col_name
  first_name, col_name = _SingleSplit(col_name)
  if not first_name then
    return
  end
  local prefix = string.sub(first_name, 1, 1)
  local map_num = tonumber(string.sub(first_name, 2))
  local locator, dust = _SingleLSplit(col_name)
  return prefix, map_num, locator
end

function _SingleSplit(str)
  print("##### _SingleSplit #####")
  local delimiter = "_"
  local index = string.find(str, delimiter, 0, true)
  if index then
    local first = string.sub(str, 1, index - 1)
    local second = string.sub(str, index + 1)
    print("##### first = ", first, " ##### second = ", second, "#####")
    return first, second
  end
  return nil, nil
end

function _SingleLSplit(str)
  print("##### _SingleLSplit #####")
  local delimiter = "_"
  local rev_str = string.reverse(str)
  local index = string.find(rev_str, delimiter, 0, true)
  if index then
    local second = string.reverse(string.sub(rev_str, 1, index - 1))
    local first = string.reverse(string.sub(rev_str, index + 1))
    print("##### first = ", first, " ##### second = ", second, "#####")
    return first, second
  end
  return nil, nil
end
