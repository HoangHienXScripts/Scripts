-- HHxScripts: fun module... --
local _ws = game:GetService("Workspace")
local _plrs = game:GetService("Players")
local _stg = game:GetService("StarterGui")
local _vu = game:GetService("VirtualUser")
local _vim = game:GetService("VirtualInputManager")

local _plr, _camera
_plr = _plrs.LocalPlayer
_camera = _ws.CurrentCamera

local _module = {}
local _processpoint = 0

function _notify(title, text, duration)
    _stg:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
    })
end

_module.ClickTarget = function(_target, _mode) -- Target phai la mot phan, vi du: workspace.part
    local point, onscreen = _camera:WorldToScreenPoint(_target.Position)
    if onscreen then
        local screenposition = Vector2.new(point.X, point.Y)
        if _mode == 1 then
            _vim:SendMouseButtonEvent(screenposition.X, screenposition.Y, 0, true, game, 1)
            task.wait(0.05)
            _vim:SendMouseButtonEvent(screenposition.X, screenposition.Y, 0, false, game, 1)
        elseif _mode == 2 then
            _vim:SendMouseMoveEvent(screenposition.X, screenposition.Y, game)
            task.wait(0.05)
            _vu:CaptureController()
            _vu:ClickButton1()
        elseif _mode == 3 then
            if mouse1press and mouse1release and mousemoverel then
                mousemoverel(screenposition.X, screenposition.Y)
                if _processpoint >= 5 then
                    _processpoint = 0
                end
                repeat wait(0.1)
                    mouse1press()
                    wait(0.1)
                    mouse1release()
                    _processpoint += 1
                until _processpoint >= 5
            else
                _notify("[ERROR]", "Your client executor isnt supported this function!", 1)
            end
        end
    else
        _notify("[ERROR]", _target.Name .. " is not showing on screen, send event failed!", 1)
    end
end

return _module
-- Perfect END... ---
