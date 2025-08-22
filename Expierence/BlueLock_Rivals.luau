-- Blue_Lock_Rivals:({"__HoangHienXScripts"}) -- ☆ No Obfucated ☆
local _ws, _plrs, _core, _vim = game:GetService("Workspace"), game:GetService("Players"), game:GetService("CoreGui"), game:GetService("VirtualInputManager")
local _screen, _stealball, _goal
local _plr = _plrs.LocalPlayer
local _variables, _uidata = {["UIName"] = {"__HoangHienXScripts", "__StealingBall", "__Goal"}, ["ObjectName"] = {"Football"}}, _G._CustomUIStyle_HHxScripts
_uidata = _uidata or {Trans = 0.85, Color = Color3.new(0, 0, 0), Pos = UDim2.new(0.65, 0, 0.65, 0), Size = UDim2.new(0.05, 0, 0.1, 0), TxtScaled = true, TxtSized = 12, TxtColor = Color3.new(1, 1, 1), Font = Enum.Font.Arcade, Txt = "Steal"}

function _adduic(target, radius)
    local s = Instance.new("UICorner", target)
    s.CornerRadius = UDim.new(radius, 0)
end function _checkball()
    local ball = _ws:FindFirstChild(_variables["ObjectName"][1])
    if ball then return ball end
end function _returnteam() local team = _plr.Team.Name return team end
function _tpball()
    local ball = _checkball()
    if ball and ball:IsA("BasePart") then local hrp = _plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp and ball then hrp.CFrame = ball.CFrame + Vector3.new(0, -1, 0)
        end
    end
end local _loop = false
function _looptpball(t)
    local name = _plr.Name
    if not _loop then _loop = true t.TextColor3 = Color3.new(1, 1, 0)
    else game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "[Notification:]", Text = "Until we have ball, it reset!", Duration = 0.5,
    })
    end while _loop do wait(0.01)
        local _current_team = _returnteam()
        if _ws[name]:FindFirstChild("Football") then
            _loop = false
            t.TextColor3 = Color3.new(1, 1, 1)
        else
            if _current_team ~= "Visitor" then
                _tpball() else _loop = false game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "[Notification:]", Text = "You're Currently: a " .. _returnteam() .. "\nCan't catch the ball, right now!", Duration = 0.5,
                }) t.TextColor3 = Color3.new(1, 1, 1)
            end
        end
    end
end function _reachgoal(t)
    local team, hrp = _returnteam(), _plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp and team == "Home" then
        t.TextColor3 = Color3.new(1, 0, 1)
        hrp.CFrame = _ws.Goals:FindFirstChild("Goal").GoalLine.CFrame
    elseif hrp and team == "Away" then
        t.TextColor3 = Color3.new(0, 0, 1)
        hrp.CFrame = _ws.Goals:FindFirstChild("Goal1").GoalLine.CFrame
    else
        t.TextColor3 = Color3.new(1, 0, 0) game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "[Notification:]", Text = "Team: " .. _returnteam() .. "\nCan't TP to Goals!", Duration = 0.5,
        }) print("-- You're not in any Team! --")
    end if _plr.Character:FindFirstChild("Humanoid").Jump ~= true then
        _plr.Character:FindFirstChild("Humanoid").Jump = true
    end task.wait(0.5) t.TextColor3 = _uidata.TxtColor
end

_screen = Instance.new("ScreenGui", _core)
_stealball = Instance.new("TextButton", _screen)
_goal = Instance.new("TextButton", _screen)

_screen.Name = _variables["UIName"][1]
_stealball.Name = _variables["UIName"][2]
_goal.Name = _variables["UIName"][3]

_stealball.BackgroundTransparency = _uidata.Trans
_stealball.BackgroundColor3 = _uidata.Color
_stealball.Position = _uidata.Pos
_stealball.Size = _uidata.Size
_stealball.TextScaled = _uidata.TxtScaled
_stealball.TextSize = _uidata.TxtSized
_stealball.TextColor3 = _uidata.TxtColor
_stealball.Font = _uidata.Font
_stealball.Text = _uidata.Txt
_stealball.Visible = true
_adduic(_stealball, 0.15)

_goal.BackgroundTransparency = _uidata.Trans
_goal.BackgroundColor3 = _uidata.Color
_goal.Position = UDim2.new(0.58, 0, 0.65, 0)
_goal.Size = _uidata.Size
_goal.TextScaled = _uidata.TxtScaled
_goal.TextSize = _uidata.TxtSized
_goal.TextColor3 = _uidata.TxtColor
_goal.Font = _uidata.Font
_goal.Text = "Goal"
_goal.Visible = true
_adduic(_goal, 0.15)

_stealball.MouseButton1Click:Connect(function() _looptpball(_stealball) end)
_goal.MouseButton1Click:Connect(function() _reachgoal(_goal) end)
