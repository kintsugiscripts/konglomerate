if not _G.keyVerified then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ScriptHub",
        Text = "❌ Please verify your key first.",
        Duration = 5
    })
    return
end


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Window = Rayfield:CreateWindow({
        Name = "KintsugiScripts on Youtube - Steal a Baddie",
        Icon = 0,
        LoadingTitle = "Steal a Baddie",
        LoadingSubtitle = "by kintsugiscripts",
        Theme = {
            TextColor = Color3.fromRGB(255, 200, 200),
            Background = Color3.fromRGB(30, 5, 10),
            Topbar = Color3.fromRGB(45, 10, 15),
            Shadow = Color3.fromRGB(20, 0, 5),
            NotificationBackground = Color3.fromRGB(35, 5, 10),
            NotificationActionsBackground = Color3.fromRGB(255, 100, 100),
            TabBackground = Color3.fromRGB(90, 20, 30),
            TabStroke = Color3.fromRGB(120, 40, 50),
            TabBackgroundSelected = Color3.fromRGB(255, 70, 70),
            TabTextColor = Color3.fromRGB(255, 190, 190),
            SelectedTabTextColor = Color3.fromRGB(60, 10, 10),
            ElementBackground = Color3.fromRGB(50, 10, 15),
            ElementBackgroundHover = Color3.fromRGB(70, 15, 20),
            SecondaryElementBackground = Color3.fromRGB(35, 5, 10),
            ElementStroke = Color3.fromRGB(150, 40, 50),
            SecondaryElementStroke = Color3.fromRGB(100, 20, 30),
            SliderBackground = Color3.fromRGB(180, 50, 60),
            SliderProgress = Color3.fromRGB(255, 80, 90),
            SliderStroke = Color3.fromRGB(255, 120, 130),
            ToggleBackground = Color3.fromRGB(50, 10, 15),
            ToggleEnabled = Color3.fromRGB(255, 60, 80),
            ToggleDisabled = Color3.fromRGB(80, 40, 40),
            ToggleEnabledStroke = Color3.fromRGB(255, 90, 110),
            ToggleDisabledStroke = Color3.fromRGB(100, 50, 50),
            ToggleEnabledOuterStroke = Color3.fromRGB(180, 60, 70),
            ToggleDisabledOuterStroke = Color3.fromRGB(70, 30, 30),
            DropdownSelected = Color3.fromRGB(70, 15, 20),
            DropdownUnselected = Color3.fromRGB(50, 10, 15),
            InputBackground = Color3.fromRGB(60, 15, 20),
            InputStroke = Color3.fromRGB(150, 50, 60),
            PlaceholderColor = Color3.fromRGB(255, 180, 180)
        },
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = false,
            FolderName = nil,
            FileName = "Big Hub"
        },
        Discord = {
            Enabled = true,
            Invite = "YAbtHXjWqJ",
            RememberJoins = true
        },
        KeySystem = false,
        KeySettings = {
            Title = "KintsugiScripts Hub",
            Subtitle = "Key System",
            Note = "Key in Discord! (discord.gg/YAbtHXjWqJ)",
            FileName = "Key",
            SaveKey = false,
            GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/QfTcNcPx"}
    }
})

local Tab = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("Misc")

local Section = Tab2:CreateSection("Server")

local Button = Tab2:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")

        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end,
})

local Button = Tab2:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")

        local function serverHop()
            local success, result = pcall(function()
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                return HttpService:JSONDecode(game:HttpGet(url))
            end)

            if success and result and result.data then
                local currentJobId = game.JobId
                for _, server in ipairs(result.data) do
                    if server.playing < server.maxPlayers and server.id ~= currentJobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
                        return
                    end
                end
            end
        end

        serverHop()
    end,
})

local Section = Tab:CreateSection("Important")

local Button = Tab:CreateButton({
    Name = "CLICK THIS WHILE IN UR BASE FOR SCRIPT TO WORK",
    Callback = function()
        local player = game.Players.LocalPlayer
        if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            warn("Player or HumanoidRootPart not found!")
            return
        end

        local playerPos = player.Character.HumanoidRootPart.Position
        local basesFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Bases")
        if not basesFolder then
            warn("Bases folder not found under workspace.Map!")
            return
        end

        local nearestBase = nil
        local nearestDistance = math.huge

        for _, base in pairs(basesFolder:GetChildren()) do
            local rootPart = base:FindFirstChild("RootPart")
            if rootPart then
                local distance = (rootPart.Position - playerPos).Magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestBase = rootPart
                end
            end
        end

        if nearestBase then
            print("Nearest CloneBase RootPart found at:", nearestBase.Position)
            _G.NearestCloneBaseRootPart = nearestBase
        else
            warn("No CloneBase RootPart found in Bases folder.")
        end
    end,
})



local Section = Tab:CreateSection("Autofarm")

-- Parses time strings like "1m30s", "45s", "2m", or just "90" into seconds
local function parseTimeString(timeStr)
    local minutes = 0
    local seconds = 0

    local m = string.match(timeStr, "(%d+)m")
    if m then
        minutes = tonumber(m)
    end

    local s = string.match(timeStr, "(%d+)s")
    if s then
        seconds = tonumber(s)
    end

    if not m and not s then
        local n = tonumber(timeStr)
        if n then
            seconds = n
        else
            return nil -- invalid input
        end
    end

    return minutes * 60 + seconds
end

local autoLockEnabled = false
local autoLockTimer = 0

local Label = Tab:CreateLabel("Set the timer to whatever your base timer is, EG 1m30s or 60s", "shield-question", Color3.fromRGB(0, 255, 51), false) -- Title, Icon, Color, IgnoreTheme

-- Input box to set timer
local Input = Tab:CreateInput({
    Name = "Set Auto Lock Timer",
    CurrentValue = tostring(autoLockTimer),
    PlaceholderText = "e.g. 1m30s or 90 or 45s",
    RemoveTextAfterFocusLost = false,
    Flag = "AutoLockTimer",
    Callback = function(Text)
        local parsedTime = parseTimeString(Text:lower())
        if parsedTime and parsedTime > 0 then
            autoLockTimer = parsedTime
            print("Auto lock timer set to", autoLockTimer, "seconds")
        else
            warn("Invalid time format. Use formats like '1m30s', '90', '45s', or '2m'.")
        end
    end,
})

-- Auto Lock toggle
local Toggle = Tab:CreateToggle({
    Name = "Auto Lock Base",
    CurrentValue = false,
    Flag = "AutoLock",
    Callback = function(Value)
        autoLockEnabled = Value

        if autoLockEnabled then
            task.spawn(function()
                while autoLockEnabled do
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local hrp = character:WaitForChild("HumanoidRootPart")

                    local nearestRootPart = _G.NearestCloneBaseRootPart
                    if nearestRootPart and nearestRootPart.Parent then
                        local cloneBase = nearestRootPart.Parent
                        if cloneBase:FindFirstChild("Interactables") 
                        and cloneBase.Interactables:FindFirstChild("Laser") 
                        and cloneBase.Interactables.Laser:FindFirstChild("Button") 
                        and cloneBase.Interactables.Laser.Button:FindFirstChild("TouchPart") then

                            local touchPart = cloneBase.Interactables.Laser.Button.TouchPart

                            -- Save original position
                            local originalCFrame = hrp.CFrame

                            -- Teleport player to button (slightly above)
                            hrp.CFrame = touchPart.CFrame * CFrame.new(0, 3, 0)

                            -- Simulate touch press
                            firetouchinterest(hrp, touchPart, 0)
                            task.wait(0.1)
                            firetouchinterest(hrp, touchPart, 1)

                            task.wait(0.3) -- wait for press to register

                            -- Return player to original location
                            hrp.CFrame = originalCFrame
                        else
                            warn("Nearest CloneBase missing required parts to auto lock.")
                        end
                    else
                        warn("No nearest base selected or base no longer exists.")
                    end

                    task.wait(autoLockTimer)
                end
            end)
        end
    end,
})

local Toggle = Tab:CreateToggle({
    Name = "Auto Collect",
    CurrentValue = false,
    Flag = "AutoCR",
    Callback = function(Value)
        autocollectrizz = Value

        if autocollectrizz then
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local hrp = character:WaitForChild("HumanoidRootPart")
            local originalCFrame = hrp.CFrame

            -- CONSTANT: Claim cash loop
            task.spawn(function()
                local repStorage = game:GetService("ReplicatedStorage")
                local claimCash = repStorage
                    :WaitForChild("src")
                    :WaitForChild("Modules")
                    :WaitForChild("KnitClient")
                    :WaitForChild("Services")
                    :WaitForChild("BaseService")
                    :WaitForChild("RE")
                    :WaitForChild("ClaimCash")

                while autocollectrizz do
                    for i = 1, 10 do
                        if not autocollectrizz then return end
                        claimCash:FireServer(i)
                        task.wait(0.1)
                    end
                    task.wait(0.1)
                end
            end)

            -- LOOP: Teleport to StandPositions
            task.spawn(function()
                while autocollectrizz do
                    local baseRoot = _G.NearestCloneBaseRootPart
                    if baseRoot and baseRoot.Parent then
                        local base = baseRoot.Parent
                        local standsFolder = base:FindFirstChild("Interactables")
                            and base.Interactables:FindFirstChild("Stands")

                        if standsFolder then
                            for _, standModel in ipairs(standsFolder:GetChildren()) do
                                if not autocollectrizz then break end -- exit immediately if toggled off
                                local standPos = standModel:FindFirstChild("StandPosition")
                                if standPos then
                                    hrp.CFrame = standPos.CFrame + Vector3.new(0, 3, 0)
                                    task.wait(0.3)
                                end
                            end
                        else
                            warn("Stands folder not found in base.")
                        end
                    else
                        warn("Nearest base not set. Click the base button first.")
                    end

                    task.wait(0.2)
                end

                -- Return to original position when toggle is disabled
                if hrp and originalCFrame then
                    hrp.CFrame = originalCFrame
                end
            end)
        end
    end,
})

local autoExchangeEnabled = false

local Toggle = Tab:CreateToggle({
    Name = "Auto Exchange",
    CurrentValue = false,
    Flag = "AutoExchange",
    Callback = function(Value)
        autoExchangeEnabled = Value

        if autoExchangeEnabled then
            task.spawn(function()
                while autoExchangeEnabled do
                    local args = {
                        [1] = 3
                    }

                    local repStorage = game:GetService("ReplicatedStorage")
                    local exchangeRemote = repStorage
                        :WaitForChild("src")
                        :WaitForChild("Modules")
                        :WaitForChild("KnitClient")
                        :WaitForChild("Services")
                        :WaitForChild("GemExchangeService")
                        :WaitForChild("RE")
                        :WaitForChild("Exchange")

                    exchangeRemote:FireServer(unpack(args))
                    task.wait(1) -- adjust if exchange has a cooldown
                end
            end)
        end
    end,
})

local Toggle = Tab:CreateToggle({
    Name = "Auto Upgrade",
    CurrentValue = false,
    Flag = "AutoUpgrade",
    Callback = function(Value)
        autoupgrade = Value

        if autoupgrade then
            task.spawn(function()
                while autoupgrade do
                    local repStorage = game:GetService("ReplicatedStorage")
                    local upgradeRemote = repStorage
                        :WaitForChild("src")
                        :WaitForChild("Modules")
                        :WaitForChild("KnitClient")
                        :WaitForChild("Services")
                        :WaitForChild("StandService")
                        :WaitForChild("RE")
                        :WaitForChild("Upgrade")

                    for i = 1, 10 do
                        local args = {
                            [1] = i
                        }
                        upgradeRemote:FireServer(unpack(args))
                        task.wait(0.1) -- delay between each upgrade
                    end

                    task.wait(0.5) -- delay between full cycles
                end
            end)
        end
    end,
})



local autoRebirthEnabled = false

local Toggle = Tab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value)
        autoRebirthEnabled = Value

        if autoRebirthEnabled then
            task.spawn(function()
                while autoRebirthEnabled do
                    local repStorage = game:GetService("ReplicatedStorage")
                    local rebirthRemote = repStorage
                        :WaitForChild("src")
                        :WaitForChild("Modules")
                        :WaitForChild("KnitClient")
                        :WaitForChild("Services")
                        :WaitForChild("BaseService")
                        :WaitForChild("RE")
                        :WaitForChild("Rebirth")

                    rebirthRemote:FireServer()
                    task.wait(1) -- adjust if needed to match game cooldown
                end
            end)
        end
    end,
})

local Section = Tab:CreateSection("Stealing")

local quickStealEnabled = false

local Toggle = Tab:CreateToggle({
    Name = "Quick Steal (PRESS INSTEAD OF HOLD)",
    CurrentValue = false,
    Flag = "QuickSteal",
    Callback = function(Value)
        quickStealEnabled = Value

        if quickStealEnabled then
            task.spawn(function()
                while quickStealEnabled do
                    for _, prompt in ipairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and prompt.HoldDuration > 0 then
                            prompt.HoldDuration = 0
                        end
                    end
                    task.wait(1) -- re-check every second
                end
            end)
        end
    end,
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local teleportEnabled = false
local teleportTask

-- Check if model meets conditions (HumanoidRootPart + BillboardGui named "StolenBillboard")
local function isTargetModel(model)
    if not model:IsA("Model") then return false end
    if not model:FindFirstChild("HumanoidRootPart") then return false end
    
    for _, descendant in pairs(model:GetDescendants()) do
        if descendant:IsA("BillboardGui") and descendant.Name == "StolenBillboard" then
            return true
        end
    end
    return false
end

-- Check if any target model is within 3 studs of the player
local function anyTargetModelsNearby()
    local character = player.Character
    if not character then return false end
    local playerHRP = character:FindFirstChild("HumanoidRootPart")
    if not playerHRP then return false end

    for _, model in pairs(Workspace:GetChildren()) do
        if isTargetModel(model) then
            local modelHRP = model:FindFirstChild("HumanoidRootPart")
            if modelHRP and (modelHRP.Position - playerHRP.Position).Magnitude <= 3 then
                return true
            end
        end
    end
    return false
end

local function startTeleportLoop()
    if teleportTask then return end

    teleportTask = task.spawn(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local BasesFolder = Workspace.Map.Bases
        
        while teleportEnabled do
            if not anyTargetModelsNearby() then
                task.wait(0.5)
            else
                -- Store current player position BEFORE teleporting each cycle
                local originalCFrame = humanoidRootPart.CFrame

                for _, cloneBase in pairs(BasesFolder:GetChildren()) do
                    if not teleportEnabled then break end
                    if cloneBase.Name == "CloneBase" then
                        local spawnPart = cloneBase:FindFirstChild("SpawnPart")
                        if spawnPart and spawnPart:IsA("BasePart") then
                            humanoidRootPart.CFrame = spawnPart.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.001)
                        else
                            warn("No SpawnPart found in CloneBase:", cloneBase:GetFullName())
                        end
                    end
                end

                if not teleportEnabled then break end
                -- Return to stored original position
                humanoidRootPart.CFrame = originalCFrame
                task.wait(1)
            end
        end

        teleportTask = nil
    end)
end

local function stopTeleport()
    teleportEnabled = false
    teleportTask = nil
end

Workspace.ChildAdded:Connect(function(child)
    if teleportEnabled and isTargetModel(child) and not teleportTask then
        print("Target model added nearby, starting teleport")
        startTeleportLoop()
    end
end)

Workspace.ChildRemoved:Connect(function(child)
    if teleportEnabled and not anyTargetModelsNearby() and teleportTask then
        print("No target models nearby, pausing teleport")
        -- loop pauses automatically in startTeleportLoop()
    end
end)

local teleportToggle = Tab:CreateToggle({
    Name = "Instant Complete Steal",
    CurrentValue = false,
    Flag = "TeleportBasesOnNearbyTarget",
    Callback = function(Value)
        teleportEnabled = Value
        if teleportEnabled then
            if anyTargetModelsNearby() then
                startTeleportLoop()
            else
                print("Waiting for target models to appear nearby...")
            end
        else
            stopTeleport()
        end
    end,
})


local noclipEnabled = false

local Toggle = Tab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        noclipEnabled = Value

        if noclipEnabled then
            task.spawn(function()
                while noclipEnabled do
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end

                    task.wait(0.1) -- frequent update to maintain effect
                end
            end)
        end
    end,
})

local Slider = Tab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100}, -- Default Roblox speed is 16
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end,
})

local Slider = Tab:CreateSlider({
    Name = "JumpHeight",
    Range = {10, 150}, -- Default is 50 in most games
    Increment = 1,
    Suffix = "Height",
    CurrentValue = 50,
    Flag = "JumpHeightSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.JumpHeight = Value
        end
    end,
})
