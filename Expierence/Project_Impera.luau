-- Project_IMPERA:({"HoangHienXScripts"}) -- ☆ No Obfucated ☆
local _ws, _plrs, _coreui, _statui = game:GetService("Workspace"), game:GetService("Players"), game:GetService("CoreGui"), game:GetService("StarterGui")
local _plr = _plrs.LocalPlayer
local _tr, _airbullet = Instance.new("ScreenGui", _coreui)
_tr.Name = "__PR_ImperaScript"
_airbullet = Instance.new("TextButton", _tr)
local _smk, _var = {"A", "R", "K", "N", "I", "G", "H", "T"}, {IsEnabled = false} _airbullet.Name = "__Loop " .. _smk[math.random(1, #_smk)]
_G._Shootmode = _G._Shootmode or {
    Mode = "Multiple", Delay = 0.002,
    Melee = "Death Step", Skill = "X"
} function _get_character()
    local _char = _plr.Character
    while not _char or not _char:FindFirstChild("HumanoidRootPart") do
        _char = _plr.CharacterAdded:Wait() task.wait()
    end
    return _char
end function _return_nearest_plr()
    local _char, _n, _cl, _dis = _get_character(), nil, math.huge
    if not _char then return nil end
    for _, plr in ipairs(_plrs:GetPlayers()) do if plr ~= _plr and _plr.Character and _plr.Character:FindFirstChild("HumanoidRootPart") then
        _dis = (plr.Character.HumanoidRootPart.Position - _char.HumanoidRootPart.Position).magnitude
        if _dis < _cl then _cl = _dis
            _n = plr
        end
    end end
    return _n
end function _firingskill()
    local _target_enemies, _finalhrp, _finalpos = _return_nearest_plr()
    _finalhrp = _target_enemies and _target_enemies.Character:FindFirstChild("HumanoidRootPart") or _plr.Character:FindFirstChild("HumanoidRootPart")
    if _finalhrp then _finalpos = _finalhrp.Position
        _plr.Character:FindFirstChild(_G._Shootmode.Melee).RemoteFunction:InvokeServer(_G._Shootmode.Skill, _finalpos)
    end
end function _shoot(t)
    if _G._Shootmode.Mode == "Single" then _firingskill()
    elseif _G._Shootmode.Mode == "Multiple" then
        if not _var.IsEnabled then _var.IsEnabled = true
            t.TextColor3 = Color3.new(0, 1, 1)
        else _var.IsEnabled = false
            t.TextColor3 = Color3.new(1, 1, 1)
        end while _var.IsEnabled do wait(_G._Shootmode.Delay)
            task.spawn(_firingskill) wait(0.001)
            task.spawn(_firingskill)
        end
    end
end _airbullet.BackgroundTransparency = 0.8
_airbullet.BackgroundColor3 = Color3.new(0, 0, 0)
_airbullet.Position = UDim2.new(0.65, 0, 0.65, 0)
_airbullet.Size = UDim2.new(0.05, 0, 0.1, 0)
_airbullet.TextScaled = true
_airbullet.TextSize = 12
_airbullet.TextColor3 = Color3.new(1, 1, 1)
_airbullet.Font = Enum.Font.Arcade
_airbullet.Text = "FIRING"
_airbullet.Visible = true
local _ins_uic = Instance.new("UICorner", _airbullet)
_ins_uic.CornerRadius = UDim.new(0.15, 0)
_airbullet.MouseButton1Click:Connect(function() _shoot(_airbullet) end)
print("-- Project Impera: " .. game.GameId .. " by HoangHienXScripts --")
_statui:SetCore("SendNotification", {Title = "[HoangHienXScripts: Present]", Text = "Project-Impera Script: AutoSkills", Duration = 2.5, })
