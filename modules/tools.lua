local plrs = game:GetService("Players")
local tws = game:GetService("TweenService")
local plr = plrs.LocalPlayer

local data = {
    ctws = nil
}

local modules = {}
modules.__index = modules

local fun = function(name) return game:GetService(name) end
local is_alive = function(usr)
    return usr and usr.Character and usr.Character:FindFirstChildOfClass("Humanoid") and usr.Character.Humanoid.Health > 0
end
local create_tween = function(t1, t2, up_axis)
    if data.ctws ~= nil then data.ctws:Cancel() end
	up_axis = up_axis or 0
	data.ctws = tws:Create(t1, TweenInfo.new((t1.Position - t2.Position).magnitude / 195, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
			CFrame = CFrame.new(t2.Position + Vector3.new(0, up_axis, 0))
	}) data.ctws:Play()
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
			if direct < data.mag and direct <= data.inr and is_alive(usr) then
				data.mag = direct
				data.near = usr
			end
		end
	end self.NEARBY = data.near
	return self
end

function modules:teleport(up_axis)
    if self.NEARBY then
        local hrp = self.NEARBY.Character:FindFirstChild("HumanoidRootPart")
		up_axis = up_axis or 0
		if hrp and plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(hrp.Position + Vector3.new(0, up_axis, 0))
		end
	end return self
end

function modules:tweening_to(up_axis)
    if self.NEARBY then
        local hrp = self.NEARBY.Character:FindFirstChild("HumanoidRootPart")
		if hrp and plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            create_tween(plr.Character.HumanoidRootPart, hrp, up_axis)
		end
	end return self
end

function modules:get_username()
	if self.NEARBY then print("Name: " .. self.NEARBY.Name) end
	return self.NEARBY.Name
end

return modules
