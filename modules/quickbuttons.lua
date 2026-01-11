-- buttons --
local core, starterui, htp
core = game:GetService("CoreGui")
sterui = game:GetService("StarterGui")
htp = game:GetService("HttpService")

if core:FindFirstChild("HHxScripts_SGUI") then core.HHxScripts_SGUI:Destroy() 
  print("Previous 'ScreenGui' Loaded, Has been removed.")
end

local main, screenui = {}, Instance.new("ScreenGui", core)
screenui.Name = "HHxScripts_SGUI"
local folders = {"HHxScripts", "HHxScripts/Games", "HHxScripts/Games/PLACE_" .. tostring(game.GameId) .. "_SAVEFOLDER"}
local configs = {
  saving_state = false,
  set = false,
  buttons = {}
}

function adduicorner(t, r) Instance.new("UICorner", t).CornerRadius = UDim.new(r, 0) end
function do_notify(str) sterui:SetCore("SendNotification", {Title = "MODULE NOTIFY", Text = str, Duration = 1.25,}) end

function randomstrs() local keys, newest = "abcdefghy", ""
  for i = 1, #keys do
    newest = newest .. keys:sub(math.random(1, #keys), math.random(1, #keys))
  end return newest
end

function createsave_folder()
  if isfolder and makefolder and isfile and writefile and readfile then
    for index = 1, #folders do if not isfolder(folders[index]) then makefolder(folders[index]) end
    if not isfile(folders[3] .. "/QuickButtons.json") then
      writefile(folders[3] .. "/QuickButtons.json", htp:JSONEncode(configs.buttons))
    end
  end
end

local ppx = 0
function update_configs()
  if not configs.set and isfolder(folders[3]) then
    configs.saving_state = true
    configs.set = true
  end if isfile(folders[3] .. "/QuickButtons.json") then
    configs.buttons = htp:JSONDecode(readfile(folders[3] .. "/QuickButtons.json"))
    if ppx > 0 then
      writefile(folders[3] .. "/QuickButtons.json", htp:JSONEncode(configs.buttons))
    end ppx += 1
  end
end update_configs()

main.add_config = function(cfgs)
  if type(cfgs) == "table" then
    for key, val in pairs(cfgs) do if configs[key] ~= nil then configs[key] = val end end
  end configs.set = true
  if configs.saving_state then createsave_folder() end
end

main.add_button = function(keys, fname, tcolor, pos, crner, script)
  if not configs.set then do_notify("must use function 'add_config({ key = val })' first, before run this function.") return end
  local new_btn = Instance.new("TextButton", screenui)
  new_btn.Name = randomstrs()
  new_btn.BackgroundTransparency = 0.5
  new_btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  new_btn.Position = UDim2.new(unpack(pos))
  new_btn.Size = UDim2.new(0.05, 0, 0.1, 0)
  new_btn.TextScaled = true
  new_btn.TextSize = 12
  new_btn.TextColor3 = Color3.fromRGB(unpack(tcolor))
  new_btn.Text = keys
  new_btn.Font = Enum.Font[fname]
  new_btn.Visible = true
  adduicorner(new_btn, crner)
  new_btn.MouseButton1Click:Connect(script)
  return new_btn
end

main.add_toggle = function(keys, fname, tcolor, pos, crner, script, var)
  if not configs.set then do_notify("must use function 'add_config({ key = val })' first, before run this function.") return end
  local varx = var or "none"
  if varx ~= "none" and type(varx) == "string" then configs.buttons[varx] = false end
  local new_btn = Instance.new("TextButton", screenui)
  new_btn.Name = randomstrs()
  new_btn.BackgroundTransparency = 0.5
  new_btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  new_btn.Position = UDim2.new(unpack(pos))
  new_btn.Size = UDim2.new(0.05, 0, 0.1, 0)
  new_btn.TextScaled = true
  new_btn.TextSize = 12
  new_btn.TextColor3 = Color3.fromRGB(unpack(tcolor))
  new_btn.Text = keys
  new_btn.Font = Enum.Font[fname]
  new_btn.Visible = true
  adduicorner(new_btn, crner)
  local btn_state = false
  new_btn.MouseButton1Click:Connect(function()
    if varx ~= "none" then
      if not configs.buttons[varx] then configs.buttons[varx] = true
        new_btn.TextColor3 = Color3.fromRGB(0, 255, 0)
      else configs.buttons[varx] = false
        new_btn.TextColor3 = Color3.fromRGB(unpack(tcolor))
      end
    else
      if not btn_state then btn_state = true
        new_btn.TextColor3 = Color3.fromRGB(0, 255, 0)
      else btn_state = false
        new_btn.TextColor3 = Color3.fromRGB(unpack(tcolor))
      end
    end if configs.set then update_configs() end
  end) while btn_state or configs.buttons[varx] do wait(0.01)
    script()
  end return new_btn
end

main.removing_buttons = function()
  for _, btn in pairs(screenui:GetChildren()) do
    if btn:IsA("TextButton") then
      btn:Destroy()
    end
  end do_notify("all buttons created has been removed!")
end

return main
-- First time ever make a UI_Library roblox --
