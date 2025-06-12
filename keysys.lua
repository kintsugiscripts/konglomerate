-- Destroy old GUI if it exists
pcall(function() game.CoreGui:FindFirstChild("KeyGui"):Destroy() end)

local setClipboard = setclipboard or toclipboard or set_clipboard

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeyGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 220)
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local frameUICorner = Instance.new("UICorner")
frameUICorner.CornerRadius = UDim.new(0, 15)
frameUICorner.Parent = frame

local title = Instance.new("TextLabel", frame)
title.Text = "Key System"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0.05, 0) 
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Text = "Copy Key Link"
copyBtn.Font = Enum.Font.Gotham
copyBtn.TextSize = 16
copyBtn.Size = UDim2.new(0.8, 0, 0, 30)
copyBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local copyBtnCorner = Instance.new("UICorner")
copyBtnCorner.CornerRadius = UDim.new(0, 10)
copyBtnCorner.Parent = copyBtn

local keySystemLabel = Instance.new("TextLabel", frame)
keySystemLabel.Text = "discord.gg/YAbtHXjWqJ" -- Replace with your actual Discord invite
keySystemLabel.Font = Enum.Font.Gotham
keySystemLabel.TextSize = 12
keySystemLabel.Size = UDim2.new(0.8, 0, 0, 18)
keySystemLabel.Position = UDim2.new(0.31, 0, 0.4, 0) 
keySystemLabel.BackgroundTransparency = 1
keySystemLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
keySystemLabel.TextXAlignment = Enum.TextXAlignment.Left

local notify = Instance.new("TextLabel", frame)
notify.Text = ""
notify.Font = Enum.Font.Gotham
notify.TextSize = 14
notify.Size = UDim2.new(1, 0, 0, 20)
notify.Position = UDim2.new(0, 0, 0.8725, 0) -- below Submit button
notify.BackgroundTransparency = 1
notify.TextColor3 = Color3.fromRGB(0, 255, 0)

local keyBox = Instance.new("TextBox", frame)
local placeholder = "Enter your key..."
keyBox.Text = placeholder
keyBox.TextColor3 = Color3.fromRGB(180, 180, 180)
keyBox.PlaceholderText = placeholder
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.Size = UDim2.new(0.8, 0, 0, 30)
keyBox.Position = UDim2.new(0.1, 0, 0.5, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

keyBox.Focused:Connect(function()
    if keyBox.Text == placeholder then
        keyBox.Text = ""
        keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

keyBox.FocusLost:Connect(function()
    if keyBox.Text == "" then
        keyBox.Text = placeholder
        keyBox.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)

local submitBtn = Instance.new("TextButton", frame)
submitBtn.Text = "✅ Submit Key"
submitBtn.Font = Enum.Font.Gotham
submitBtn.TextSize = 16
submitBtn.Size = UDim2.new(0.8, 0, 0, 30)
submitBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
submitBtn.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local submitBtnCorner = Instance.new("UICorner")
submitBtnCorner.CornerRadius = UDim.new(0, 10)
submitBtnCorner.Parent = submitBtn

-- Copy key link button
copyBtn.MouseButton1Click:Connect(function()
    if setClipboard then
        setClipboard("https://discord.com/invite/YAbtHXjWqJ") -- Replace with actual link
        notify.Text = "✅ Discord link copied!"
    else
        notify.Text = "❌ Clipboard not supported."
    end
    wait(2)
    notify.Text = ""
end)

-- Key verification logic
submitBtn.MouseButton1Click:Connect(function()
    local userKey = keyBox.Text
    if userKey == "" or userKey == placeholder then
        notify.Text = "❌ Please enter a key."
        return
    end

    local success, correctKey = pcall(function()
        return game:HttpGet("https://pastebin.com/raw/QfTcNcPx") -- Replace with your Pastebin key
    end)

    if not success then
        notify.Text = "❌ Failed to fetch key."
        return
    end

    if userKey == correctKey then
        notify.Text = "✅ Key verified! Loading..."
        _G.keyVerified = true  -- <-- Set key verified here
        wait(1)
        gui:Destroy()

        local successLoad, err = pcall(function()
            if _G.loadGameScript then
                _G.loadGameScript()
            else
                warn("loadGameScript not found in global scope.")
            end
        end)

        if not successLoad then
            warn("❌ Failed to load game script:", err)
        end
    else
        notify.Text = "❌ Invalid key."
    end
end)
