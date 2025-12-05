-- Slap Table: Auto Parry --
-- Test --
local ws, plrs, rls, rs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
rls = game:GetService("ReplicatedStorage")
rs = game:GetService("RunService")

local zap, combat, plr, cam
zap = rls:WaitForChild("ZAP")
combat = zap:WaitForChild("COMBAT_RELIABLE")
plr = plrs.LocalPlayer
cam = ws.Camera

local memories = {
    animations = {
        trulyslap = "rbxassetid://137023753042303"
    },
    remote_args = {
        slap = {buffer.fromstring("\000"), {}},
        dodge = {buffer.fromstring("\001Q\018\248\254\186L\218A"), {}}
    }
}

function checking_realslap(target)
    for _, user in ipairs(plrs:GetPlayers()) do
        if user.Name == target and user and user.Character and user.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = user.Character.Humanoid
            if humanoid and humanoid.Health > 0 then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    if track and track.Animation.AnimationId == memories.animations.trulyslap then
                        return true
                    end
                end
            end
        end
    end return false
end

function visible(user)
    local head = user.Character and user.Character:FindFirstChild("Head")
    if head then
        local _, on = cam:WorldToScreenPoint(head.Position)
        if on then return true end
    end return false
end

function rplr_onvision()
    local near, best, range = nil, math.huge, 200
    for _, user in pairs(plrs:GetPlayers()) do
        if user and user.Character and user.Character:FindFirstChild("HumanoidRootPart") then
            local pos = user.Character.HumanoidRootPart.Position
            local dist = (pos - plr.Character.HumanoidRootPart.Position).magnitude
            if dist < best and dist <= range and visible(user) then
                best = dist
                near = user
            end
        end
    end if near ~= nil then
        return near
    end
end

rs.RenderStepped:Connect(function()
    if checking_realslap(rplr_onvision().Name) then
        combat:FireServer(unpack(memories.remote_args.dodge))
    end
end)
