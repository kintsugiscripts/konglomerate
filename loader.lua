-- Game script lookup table
local scripts = {
    [70671905624144] = "stealabaddie.lua",  -- Use actual file name
    -- Add more game PlaceId mappings here
}

-- Define global function so the key system can call it
_G.loadGameScript = function()
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

-- Load key system from GitHub root
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
