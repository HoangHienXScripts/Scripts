-- buttons --
local core, starterui
core = game:GetService("CoreGui")
sterui = game:GetService("StarterGui")

local main, screenui = {}, Instance.new("ScreenGui", core)

function adduicorner(t, r) Instance.new("UICorner", t).CornerRadius = UDim.new(r, 0) end
function do_notify(str) sterui:SetCore("SendNotification", {Title = "MODULE NOTIFY", Text = str, Duration = 1.25,}) end

function randomstrs() local keys, newest = "abcdefghy", ""
  for i = 1, #keys do
    newest = newest .. keys:sub(math.random(1, #keys), math.random(1, #keys))
  end return newest
end

main.add_button = function(keys, fname, tcolor, pos, crner, script)
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

main.removing_buttons = function()
  for _, btn in pairs(screenui:GetChildren()) do
    if btn:IsA("TextButton") then
      btn:Destroy()
    end
  end do_notify("all buttons created has been removed!")
end

return main
