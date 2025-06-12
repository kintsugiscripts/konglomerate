-- Game script lookup table
local scripts = {
    [70671905624144] = "stealabaddie.lua",
    -- Add more mappings here
}

-- Define the function globally so key system can call it
_G.loadGameScript = function()
    -- Check key verification here if you want extra safety:
    if not _G.keyVerified then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ScriptHub",
            Text = "❌ Please verify your key first.",
            Duration = 5
        })
        return
    end

    local placeId = game.PlaceId
    local scriptName = scripts[placeId]

    if not scriptName then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ScriptHub",
            Text = "❌ This game is not supported.",
            Duration = 5
        })
        return
    end

    local url = "https://raw.githubusercontent.com/kintsugiscripts/konglomerate/main/" .. scriptName

    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    if not success then
        warn("❌ Failed to load game script:", err)
    end
end

-- Then load the key system
local keySystemUrl = "https://raw.githubusercontent.com/kintsugiscripts/konglomerate/main/keysys.lua"

local success, err = pcall(function()
    loadstring(game:HttpGet(keySystemUrl))()
end)

if not success then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Loader",
        Text = "❌ Failed to load key system: " .. tostring(err),
        Duration = 5
    })
end
