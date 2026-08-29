-- Little funny: Encoder --
local maps, _module = {
  ["0"] = "3", ["1"] = "2", ["2"] = "6", ["3"] = "8", ["4"] = "9", ["5"] = "0",
  ["6"] = "4", ["7"] = "1", ["8"] = "5", ["9"] = "7"
}, {}

function _reverse(key)
  for i = 1, 126 do
    if string.char(i) == key then
      return i
    end
  end
end

function _index(key)
  for i, v in next, maps do
    if v == key then
      return i
    end
  end
end

function _split(str)
  local out = {}
  for part in string.gmatch(str, "[^_]+") do
    table.insert(out, part)
  end return out
end

function _module.EN(str)
  local out = ""
  for i = 1, #str do
    local number = tostring(_reverse(str:sub(i, i)))
    local scrambled = ""
    for d = 1, #number do
      scrambled = scrambled .. maps[number:sub(d, d)]
    end out = out .. scrambled .. "_"
  end return out:sub(1, #out - 1)
end

function _module.DE(str)
  local out = ""
  local codes = _split(str)
  for _, number in ipairs(codes) do
    local solve = ""
    for d = 1, #number do
      solve = solve .. _index(number:sub(d, d))
    end out = out .. string.char(tonumber(solve))
  end return out
end

return _module
