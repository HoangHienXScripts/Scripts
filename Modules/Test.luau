-- HHxScripts: fun module --
local _ws = game:GetService("Workspace")
local _plrs = game:GetService("Players")
local _stg = game:GetService("StarterGui")
local _vim = game:GetService("VirtualInputManager")

local _plr, _camera
_plr = _plrs.LocalPlayer
_camera = _ws.CurrentCamera

local _module = {}

function _notify(title, text, duration)
    _stg:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
    })
end

_module.ClickTarget = function(_target) -- Target phai la mot phan, vi du: workspace.part
    local point, onscreen = _camera:WorldToScreenPoint(_target.Position)
    if onscreen then
        local screenposition = Vector2.new(point.X, point.Y)
        _vim:SendMouseButtonEvent(screenposition.X, screenposition.Y, 0, true, game, 1)
        task.wait(0.05)
        _vim:SendMouseButtonEvent(screenposition.X, screenposition.Y, 0, false, game, 1)
    else
        _notify("《Click Target》", _target.Name .. " Is Not OnScreen, Can't Send Event!", 1)
    end
end

return _module
