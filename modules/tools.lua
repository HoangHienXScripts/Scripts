local plrs = game:GetService("Players")
local core = game:GetService("CoreGui")
local plr = plrs.LocalPlayer

local modules = {}
modules.__index = modules

fun = function(name) return game:GetService(name) end
is_alive = function(usr)
  if usr and usr.Character and usr.Character:FindFirstChildOfClass("Humanoid") and usr.Character.Humanoid.Health > 0 then
    return true
  end return false
end

function modules:new(sv)
  local self = setmetatable({}, modules)
  self.SERVICE = fun(sv)
  return self
end

function modules:get_nearest()
  local data = {near = nil, mag = math.huge, inr = 10000}
  for _, usr in pairs(self.SERVICE:GetChildren()) do
    if usr ~= plr and usr and usr.Character and usr.Character:FindFirstChild("HumanoidRootPart") then
      local direct = (usr.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
      if direct < data.mag and direct <= data.inr then
        data.mag = direct
        data.near = usr
      end
    end
  end self.NEARBY = data.near
  return self
end

function modules:print_name()
  print("Name: " .. self.NEARBY.Name)
end

return modules
