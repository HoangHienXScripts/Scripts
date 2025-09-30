-- B.Helper Tool --
local plrs, core
plrs = game:GetService("Players")
core = game:GetService("CoreGui")

local plr
plr = plrs.LocalPlayer

local scriptdata, color = {
    questlevel = "none",
    questname = "none",
    questnum = "none",
    questnpc = "none",
    questwaitpos = "none",
    questcount = "none",
    fullstructure = "none",
    buttons_data = {
        default = {
            font = Enum.Font.Code
        },
        ui_candrag = true,
        font = "Code"
    },
    func = {
        uic = function(t, r) local uic_new = Instance.new("UICorner", t)
            uic_new.CornerRadius = UDim.new(r, 0)
        end,
        mb1c = function(t, s) t.MouseButton1Click:Connect(s) end,
        fl = function(t, s) t.FocusLost:Connect(s) end
    }
}, {
    black = Color3.new(0, 0, 0),
    white = Color3.new(1, 1, 1),
    red = Color3.new(1, 0, 0),
    green = Color3.new(0, 1, 0),
    blue = Color3.new(0, 1, 1),
    yellow = Color3.new(1, 1, 0)
}

local screenui, df, sf, txt_lb_a, txtbox_a, txt_lb_b, txtbox_b, txt_lb_c, txtbox_c, txt_lb_d, txt_lb_e
local txtbutton_d, txtbutton_e, copyfullpath, level_cap
screenui = Instance.new("ScreenGui", core)
df = Instance.new("Frame", screenui)
sf = Instance.new("ScrollingFrame", df)
txt_lb_a = Instance.new("TextLabel", sf)
txtbox_a = Instance.new("TextBox", sf)
txt_lb_b = Instance.new("TextLabel", sf)
txtbox_b = Instance.new("TextBox", sf)
txt_lb_c = Instance.new("TextLabel", sf)
txtbox_c = Instance.new("TextBox", sf)
txt_lb_d = Instance.new("TextLabel", sf)
txt_lb_e = Instance.new("TextLabel", sf)
txtbutton_d = Instance.new("TextButton", sf)
txtbutton_e = Instance.new("TextButton", sf)
copyfullpath = Instance.new("TextButton", sf)
level_cap = Instance.new("TextBox", sf)

screenui.Name = "HHxScript_" .. math.random(1, 9999)
df.Name = "DragF_X"
sf.Name = "Scroll_A"
txt_lb_a.Name = "Display_QuestName"
txtbox_a.Name = "Input_A"
txt_lb_b.Name = "Display_QuestNumber"
txtbox_b.Name = "Input_B"
txt_lb_c.Name = "Display_MonsterName"
txtbox_c.Name = "Input_C"
txt_lb_d.Name = "Display_NPCPosition"
txt_lb_e.Name = "Display_WaitingSpot"
txtbutton_d.Name = "GetPos_D"
txtbutton_e.Name = "GetPos_E"
copyfullpath.Name = "GetFinalStructure"
level_cap.Name = "Input_Extra"

df.BackgroundTransparency = 0.5
df.BackgroundColor3 = color.black
df.Position = UDim2.new(0.35, 0, 0.35, 0)
df.Size = UDim2.new(0.25, 0, 0.4, 0)
df.Active = true
df.Draggable = scriptdata.buttons_data.ui_candrag or false
df.Visible = true
scriptdata.func.uic(df, 0.05)

sf.BackgroundTransparency = 0.75
sf.BackgroundColor3 = color.black
sf.Position = UDim2.new(0.02, 0, 0.02, 0)
sf.Size = UDim2.new(0.8, 0, 0.96, 0)
sf.CanvasSize = UDim2.new(0, 0, 2, 0)
sf.ScrollBarThickness = 0.1
sf.Visible = true
scriptdata.func.uic(sf, 0.02)

txt_lb_a.BackgroundTransparency = 0.8
txt_lb_a.BackgroundColor3 = color.black
txt_lb_a.Position = UDim2.new(0.02, 0, 0.005, 0)
txt_lb_a.Size = UDim2.new(0.65, 0, 0.1, 0)
txt_lb_a.TextScaled = true
txt_lb_a.TextSize = 12
txt_lb_a.TextColor3 = color.white
txt_lb_a.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txt_lb_a.Text = ""
txt_lb_a.Visible = true
scriptdata.func.uic(txt_lb_a, 0.1)

txtbox_a.BackgroundTransparency = 0.8
txtbox_a.BackgroundColor3 = color.black
txtbox_a.Position = UDim2.new(0.68, 0, 0.005, 0)
txtbox_a.Size = UDim2.new(0.30, 0, 0.1, 0)
txtbox_a.TextScaled = true
txtbox_a.TextSize = 12
txtbox_a.TextColor3 = color.yellow
txtbox_a.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txtbox_a.Text = ""
txtbox_a.PlaceholderText = "Name"
txtbox_a.ClearTextOnFocus = true
txtbox_a.Visible = true
scriptdata.func.uic(txtbox_a, 0.1)

txt_lb_b.BackgroundTransparency = 0.8
txt_lb_b.BackgroundColor3 = color.black
txt_lb_b.Position = UDim2.new(0.02, 0, 0.108, 0)
txt_lb_b.Size = UDim2.new(0.65, 0, 0.1, 0)
txt_lb_b.TextScaled = true
txt_lb_b.TextSize = 12
txt_lb_b.TextColor3 = color.white
txt_lb_b.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txt_lb_b.Text = ""
txt_lb_b.Visible = true
scriptdata.func.uic(txt_lb_b, 0.1)

txtbox_b.BackgroundTransparency = 0.8
txtbox_b.BackgroundColor3 = color.black
txtbox_b.Position = UDim2.new(0.68, 0, 0.108, 0)
txtbox_b.Size = UDim2.new(0.30, 0, 0.1, 0)
txtbox_b.TextScaled = true
txtbox_b.TextSize = 12
txtbox_b.TextColor3 = color.yellow
txtbox_b.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txtbox_b.Text = ""
txtbox_b.PlaceholderText = "Number"
txtbox_b.ClearTextOnFocus = true
txtbox_b.Visible = true
scriptdata.func.uic(txtbox_b, 0.1)

txt_lb_c.BackgroundTransparency = 0.8
txt_lb_c.BackgroundColor3 = color.black
txt_lb_c.Position = UDim2.new(0.02, 0, 0.21, 0)
txt_lb_c.Size = UDim2.new(0.65, 0, 0.1, 0)
txt_lb_c.TextScaled = true
txt_lb_c.TextSize = 12
txt_lb_c.TextColor3 = color.white
txt_lb_c.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txt_lb_c.Text = ""
txt_lb_c.Visible = true
scriptdata.func.uic(txt_lb_c, 0.1)

txtbox_c.BackgroundTransparency = 0.8
txtbox_c.BackgroundColor3 = color.black
txtbox_c.Position = UDim2.new(0.68, 0, 0.21, 0)
txtbox_c.Size = UDim2.new(0.30, 0, 0.1, 0)
txtbox_c.TextScaled = true
txtbox_c.TextSize = 12
txtbox_c.TextColor3 = color.yellow
txtbox_c.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txtbox_c.Text = ""
txtbox_c.PlaceholderText = "Monster Name"
txtbox_c.ClearTextOnFocus = true
txtbox_c.Visible = true
scriptdata.func.uic(txtbox_c, 0.1)

txt_lb_d.BackgroundTransparency = 0.8
txt_lb_d.BackgroundColor3 = color.black
txt_lb_d.Position = UDim2.new(0.02, 0, 0.313, 0)
txt_lb_d.Size = UDim2.new(0.65, 0, 0.1, 0)
txt_lb_d.TextScaled = true
txt_lb_d.TextSize = 12
txt_lb_d.TextColor3 = color.white
txt_lb_d.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txt_lb_d.Text = ""
txt_lb_d.Visible = true
scriptdata.func.uic(txt_lb_d, 0.1)

txtbutton_d.BackgroundTransparency = 0.8
txtbutton_d.BackgroundColor3 = color.black
txtbutton_d.Position = UDim2.new(0.68, 0, 0.313, 0)
txtbutton_d.Size = UDim2.new(0.30, 0, 0.1, 0)
txtbutton_d.TextScaled = true
txtbutton_d.TextSize = 12
txtbutton_d.TextColor3 = color.white
txtbutton_d.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txtbutton_d.Text = "Get Quest NPC"
txtbutton_d.Visible = true
scriptdata.func.uic(txtbutton_d, 0.1)

txt_lb_e.BackgroundTransparency = 0.8
txt_lb_e.BackgroundColor3 = color.black
txt_lb_e.Position = UDim2.new(0.02, 0, 0.416, 0)
txt_lb_e.Size = UDim2.new(0.65, 0, 0.1, 0)
txt_lb_e.TextScaled = true
txt_lb_e.TextSize = 12
txt_lb_e.TextColor3 = color.white
txt_lb_e.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txt_lb_e.Text = ""
txt_lb_e.Visible = true
scriptdata.func.uic(txt_lb_e, 0.1)

txtbutton_e.BackgroundTransparency = 0.8
txtbutton_e.BackgroundColor3 = color.black
txtbutton_e.Position = UDim2.new(0.68, 0, 0.416, 0)
txtbutton_e.Size = UDim2.new(0.30, 0, 0.1, 0)
txtbutton_e.TextScaled = true
txtbutton_e.TextSize = 12
txtbutton_e.TextColor3 = color.white
txtbutton_e.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
txtbutton_e.Text = "Get Waiting Spots"
txtbutton_e.Visible = true
scriptdata.func.uic(txtbutton_e, 0.1)

level_cap.BackgroundTransparency = 0.8
level_cap.BackgroundColor3 = color.black
level_cap.Position = UDim2.new(0.02, 0, 0.519, 0)
level_cap.Size = UDim2.new(0.65, 0, 0.1, 0)
level_cap.TextScaled = true
level_cap.TextSize = 12
level_cap.TextColor3 = color.yellow
level_cap.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
level_cap.Text = ""
level_cap.PlaceholderText = "Level"
level_cap.ClearTextOnFocus = true
level_cap.Visible = true
scriptdata.func.uic(level_cap, 0.1)

copyfullpath.BackgroundTransparency = 0.8
copyfullpath.BackgroundColor3 = color.black
copyfullpath.Position = UDim2.new(0.68, 0, 0.519, 0)
copyfullpath.Size = UDim2.new(0.30, 0, 0.1, 0)
copyfullpath.TextScaled = true
copyfullpath.TextSize = 12
copyfullpath.TextColor3 = color.white
copyfullpath.Font = Enum.Font[scriptdata.buttons_data.font] or scriptdata.buttons_data.default.font
copyfullpath.Text = "Copy Structure"
copyfullpath.Visible = true
scriptdata.func.uic(copyfullpath, 0.1)

function makeround_number(num, decimals)
    if decimals <= 0 then
        return math.floor(num)
    end
    local factor = 10 ^ decimals
    return math.floor(num * factor) / factor
end

function default()
    scriptdata.questlevel = "none"
    scriptdata.questname = "none"
    scriptdata.questnum = "none"
    scriptdata.questnpc = "none"
    scriptdata.questwaitpos = "none"
    scriptdata.questcount = "none"
    scriptdata.fullstructure = "none"
    txt_lb_a.Text = "" txtbox_a.Text = ""
    txt_lb_b.Text = "" txtbox_b.Text = ""
    txt_lb_c.Text = "" txtbox_c.Text = ""
    txt_lb_d.Text = ""
    txt_lb_e.Text = ""
    level_cap.Text = ""
end

scriptdata.func.fl(txtbox_a, function(enter_pressed)
    if enter_pressed then
        if txtbox_a.Text ~= "" then
            scriptdata.questname = tostring(txtbox_a.Text)
            txt_lb_a.Text = scriptdata.questname
        else
            txt_lb_a.Text = ""
        end
    end
end)

scriptdata.func.fl(txtbox_b, function(enter_pressed)
    if enter_pressed then
        if txtbox_b.Text ~= "" then
            scriptdata.questnum = tostring(txtbox_b.Text)
            txt_lb_b.Text = scriptdata.questnum
        else
            txt_lb_b.Text = ""
        end
    end
end)

scriptdata.func.fl(txtbox_c, function(enter_pressed)
    if enter_pressed then
        if txtbox_c.Text ~= "" then
            scriptdata.questcount = tostring(txtbox_c.Text)
            txt_lb_c.Text = scriptdata.questcount
        else
            txt_lb_c.Text = ""
        end
    end
end)

scriptdata.func.fl(level_cap, function(enter_pressed)
    if enter_pressed then
        scriptdata.questlevel = tostring(level_cap.Text)
    end
end)

scriptdata.func.mb1c(txtbutton_d, function()
    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then local pos_z, pos_x, pos_c
        pos_z = makeround_number(hrp.Position.X, 2)
        pos_x = makeround_number(hrp.Position.Y, 2)
        pos_c = makeround_number(hrp.Position.Z, 2)
        scriptdata.questnpc = "{" .. tostring(pos_z) .. ", " .. tostring(pos_x) .. ", " .. tostring(pos_c) .. "}"
        txt_lb_d.Text = scriptdata.questnpc
    end
end)

scriptdata.func.mb1c(txtbutton_e, function()
    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then local pos_z, pos_x, pos_c
        pos_z = makeround_number(hrp.Position.X, 2)
        pos_x = makeround_number(hrp.Position.Y, 2)
        pos_c = makeround_number(hrp.Position.Z, 2)
        if scriptdata.questwaitpos == "none" then scriptdata.questwaitpos = ""
            scriptdata.questwaitpos = scriptdata.questwaitpos .. "Vector3.new(" .. tostring(pos_z) .. ", " .. tostring(pos_x) .. ", " .. tostring(pos_c) .. ")"
        else
            scriptdata.questwaitpos = scriptdata.questwaitpos .. ",\n            Vector3.new(" .. tostring(pos_z) .. ", " .. tostring(pos_x) .. ", " .. tostring(pos_c) .. ")"
        end
        txt_lb_e.Text = scriptdata.questwaitpos
    end
end)

local unknown = false
scriptdata.func.mb1c(copyfullpath, function()
    if scriptdata.fullstructure == "none" then
        scriptdata.fullstructure = ""
        if scriptdata.questname ~= "none" and scriptdata.questnum ~= "none" and scriptdata.questnpc ~= "none" and scriptdata.questcount ~= "none" and scriptdata.questwaitpos ~= "none" and scriptdata.questlevel ~= "none" then
            scriptdata.fullstructure = '["' .. scriptdata.questlevel .. '"] = {\n        ["QuestName"] = "' .. scriptdata.questname .. '",\n        ["QuestNumber"] = ' .. scriptdata.questnum .. ',\n        ["QuestNPC"] = ' .. scriptdata.questnpc .. ',\n        ["QuestWaitingSpots"] = {\n            ' .. scriptdata.questwaitpos .. '\n        },\n        ["NPC_Count"] = "' .. scriptdata.questcount .. '"\n    }'
            setclipboard(scriptdata.fullstructure)
        else
            if not unknown then unknown = true
                copyfullpath.Text = "Error!" task.wait(0.5)
                copyfullpath.Text = "Task Incomplete!" task.wait(1.5)
                copyfullpath.Text = "Copy Structure"
                unknown = false
            end
        end
    else
        default()
    end
end)

print("Tool's Executed!\nCreator: HoangHienXScripts")
