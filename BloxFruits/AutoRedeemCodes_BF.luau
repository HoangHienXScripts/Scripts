-- Code string get from REDZ :> --
-- URL: https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/Utils/BloxFruits/Codes.json --
local _clientStorage = game:GetService("ReplicatedStorage")
local _codepath, total_codes = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/Utils/BloxFruits/Codes.json"))()
total_codes = {} -- Script by HoangHien --
for each_codes in _codepath:gmatch('"(.-)"') do
    table.insert(total_codes, each_codes)
end for _, final_result_code in ipairs(total_codes) do
    _clientStorage.Remotes.Redeem:InvokeServer(final_result_code)
    print("Used Code: " .. final_result_code .. " (Exp x2)")
end
