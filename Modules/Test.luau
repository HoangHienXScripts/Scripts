-- HHxScripts: fun module --
local _ws = game:GetService("Workspace")
local _plrs = game:GetService("Players")
local _stg = game:GetService("StarterGui")
local _vim = game:GetService("VirtualInputManager")

local _plr = _plrs.LocalPlayer
local _camera = _ws.CurrentCamera

local _module = {}

function _notify(title, text, duration)
    pcall(function()
        _stg:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 2,
        })
    end)
end

local function _checkfunc(name)
    if typeof(getgenv) == "function" and getgenv()[name] and typeof(getgenv()[name]) == "function" then
        return getgenv()[name]
    elseif typeof(_G[name]) == "function" then
        return _G[name]
    elseif typeof(_ENV) == "table" and typeof(_ENV[name]) == "function" then
        return _ENV[name]
    end
    return nil
end

_module.ClickTarget = function(_target, _clicktype) -- Target phai la mot phan, clicktype la kieu click...
    if not _target or not _target:IsA("BasePart") then -- vi du: Target == workspace.part, Clicktype == 2...
        _notify("《Click Target》", "Invalid target", 2)
        return
    end
    
    local point, onScreen = _camera:WorldToScreenPoint(_target.Position)
    if not onScreen then
        _notify("《Click Target》", _target.Name .. " is not on screen", 2)
        return
    end
    
    local screenPos = Vector2.new(point.X, point.Y)
    if _clicktype == 1 then
        _vim:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, true, game, 1)
        task.wait(0.05)
        _vim:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, false, game, 1)
    elseif _clicktype == 2 then
        local move, press, release = _checkfunc("mousemove"), _checkfunc("mouse1press"), _checkfunc("mouse1release")
        if move and press and release then
            move(screenPos.X, screenPos.Y)
            press()
            wait(0.1)
            release()
        else
            _notify("《Click Target》", "Mouse input functions not found", 2)
        end
    else
        _notify("《Click Target》", "Invalid click type: " .. tostring(_clicktype), 2)
    end
end

return _module
