-- HoangHien UI-Library (First Time: v0.2) --
local modules = {}

local core, starterui, htp
core = game:GetService("CoreGui")
starterui = game:GetService("StarterGui")
htp = game:GetService("HttpService")
pcall(function() if core:FindFirstChild("HHxScripts_SGUI") then core.HHxScripts_SGUI:Destroy() end end)

local inst_s, configs = {
    screenui = Instance.new("ScreenGui")
}, {
    ready = false, save = false, buttons = {}
} inst_s.screenui.Parent = core
inst_s.screenui.Name = "HHxScripts_SGUI"

local folders = {
    "HHxScripts", "HHxScripts/Games", "HHxScripts/Games/PLACE_" .. game.GameId .. "_SAVEFOLDER"
}

function randomstr(leng)
    local chars = "abcdefghijklmnopqrstuvwxyz"
    local s = ""
    for i = 1, (leng or 10) do
        local r = math.random(1, #chars)
        s = s .. chars:sub(r, r)
    end
    return s
end function round_ui(obj, scale) Instance.new("UICorner", obj).CornerRadius = UDim.new(scale or 0, 0) end
function notify(t) starterui:SetCore("SendNotification", {Title = "《XScripts - UIModule》", Text = t, Duration = 1.25}) end

function setup_folders()
    if not (isfolder and makefolder and isfile and writefile and readfile) then return end
    for _, f in ipairs(folders) do if not isfolder(f) then makefolder(f) end end
    local file = folders[3] .. "/QuickButtons.json"
    if not isfile(file) then
        writefile(file, htp:JSONEncode({}))
    end
end

function load_configs()
    local file = folders[3] .. "/QuickButtons.json"
    if isfile and isfile(file) then
        configs.buttons = htp:JSONDecode(readfile(file))
    end
end

function save_configs()
    if not configs.save then return end
    writefile(folders[3] .. "/QuickButtons.json", htp:JSONEncode(configs.buttons))
end

function modules.set_configs(t)
    if type(t) ~= "table" then return end
    configs.save = t.saving_state or false
    configs.ready = true
    if configs.save then
        setup_folders()
        load_configs()
    end
end

function modules.add_button(text, font, color, pos, corner, callback)
    if not configs.ready then notify("use 'add_config({ saving_state = boolean })' first") return end
    local b = Instance.new("TextButton", inst_s.screenui)
    b.Name = randomstr(12)
    b.Size = UDim2.fromScale(0.05, 0.1)
    b.Position = UDim2.new(unpack(pos))
    b.BackgroundColor3 = Color3.new(0, 0, 0)
    b.BackgroundTransparency = 0.5
    b.TextScaled = true
    b.Text = text
    b.TextColor3 = Color3.fromRGB(unpack(color))
    b.Font = Enum.Font[font] or Enum.Font.Code
    round_ui(b, corner)
    b.MouseButton1Click:Connect(callback)
    return b
end

function modules.add_toggle(text, font, color, pos, corner, callback, key)
    if not configs.ready then notify("use 'add_config({ saving_state = boolean })' first") return end
    if not key then notify("missing final argument 'string: toggle variable' name.") return end
    local btn = modules.add_button(text, font, color, pos, corner, function() end)
    local state = configs.buttons[key] == true
    local is_running = false
    local thread
    local function update() btn.TextColor3 = state and Color3.fromRGB(0,255,0) or Color3.fromRGB(unpack(color)) end
    local function start() if thread then return end is_running = true
        thread = task.spawn(function()
            while is_running do
                task.wait()
                callback()
            end thread = nil
        end)
    end
    local function plus_reload() update() if state then start() else is_running = false end end
    btn.MouseButton1Click:Connect(function()
        state = not state
        configs.buttons[key] = state
        save_configs()
        plus_reload()
    end) plus_reload()
    return btn
end

function modules.removing_buttons()
    for _, btn in ipairs(inst_s.screenui:GetChildren()) do
        if btn:IsA("TextButton") then
            print("Destroyed: " .. btn.Name .. "!")
            btn:Destroy()
        end
    end notify("ALL UI-INSTANCE CLEARED!")
end

notify("Loaded UI-Modules by HoangHienXScripts!\n(First Time: v0.2)")
return modules
