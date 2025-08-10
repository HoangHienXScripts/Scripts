-- HHxScripts: fun module...
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

_module.new = function()
    local self = setmetatable({}, {__index = _module})
    self._processpoint = 0
    return self
end

_module.ClickTarget = function(self, _target, _mode, _release, _processfinishedpoint, _delay)  -- Target phải là một phần, ví dụ: workspace.part
    local point, onscreen = _camera:WorldToScreenPoint(_target.Position)
    if onscreen then
        local screenposition = Vector2.new(point.X, point.Y)
        if self._processpoint >= _processfinishedpoint then self._processpoint = 0 end
        repeat wait(_delay)
            if _mode < 3 then _vim:SendMouseMoveEvent(screenposition.X, screenposition.Y, game) end
            if _mode == 1 then
                _vim:SendMouseButtonEvent(screenposition.X, screenposition.Y, 0, true, game, 1)
                if _release == true then
                    task.wait(_delay)
                    _vim:SendMouseButtonEvent(screenposition.X, screenposition.Y, 0, false, game, 1)
                end
            elseif _mode == 2 then
                _vu:CaptureController()
                _vu:ClickButton1(Vector2.new(0, 0))
            elseif _mode == 3 then
                if mouse1press and mouse1release and mousemoverel then
                    mousemoverel(screenposition.X, screenposition.Y)
                    mouse1press()
                    if _release == true then
                        wait(_delay)
                        mouse1release()
                    end
                else
                    return "[ERROR]: Your executor it's not supported, 2 run this function!"
                end
            end
            self._processpoint += 1
        until self._processpoint >= _processfinishedpoint or 5
    else
        _notify("[ERROR]: ", _target.Name .. " is not showing on screen, send event failed!", 1)
    end
end

_module._checktable = function(self, _t, _time)
    _time = _time or 0
    print(string.rep(" ", _time) .. "{")
    for a, b in pairs(_t) do
        local _istype = type(b)
        if _istype == "table" then
            print(string.rep(" ", _time + 4) .. a .. " = {")
            self:_checktable(b, _time + 8)
            print(string.rep(" ", _time + 4) .. "}")
        elseif _istype == "function" then
            print(string.rep(" ", _time + 4) .. a .. " = function: " .. tostring(b))
        elseif _istype == "boolean" then
            print(string.rep(" ", _time + 4) .. a .. " = " .. tostring(b))
        elseif _istype == "number" then
            print(string.rep(" ", _time + 4) .. a .. " = " .. b)
        elseif _istype == "string" then
            print(string.rep(" ", _time + 4) .. a .. " = \"" .. b .. "\"")
        elseif _istype == "nil" then
            print(string.rep(" ", _time + 4) .. a .. " = nil")
        end
    end
    print(string.rep(" ", _time) .. "}")
end

return _module
-- Perfect END... ---
