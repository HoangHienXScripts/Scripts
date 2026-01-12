-- Tools module by HoangHien v0.1 --
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

local modules = {}
modules.__index = modules

local fun = function(name) return game:GetService(name) end
local is_alive = function(usr)
  return usr and usr.Character and usr.Character:FindFirstChildOfClass("Humanoid") and usr.Character.Humanoid.Health > 0
end

function modules:new(sv)
	local self = setmetatable({}, modules)
	self.SERVICE = fun(sv)
	self.NEARBY = nil
	return self
end

function modules:get_nearest()
	if not (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then return self end
	local data = {near = nil, mag = math.huge, inr = 10000}
	for _, usr in pairs(self.SERVICE:GetPlayers()) do
		if usr ~= plr and is_alive(usr) and usr.Character:FindFirstChild("HumanoidRootPart") then
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
	if self.NEARBY then print("Name: " .. self.NEARBY.Name) end
	return self
end

return modules
