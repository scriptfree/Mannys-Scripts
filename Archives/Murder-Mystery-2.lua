game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "Success";
    Text = "Thanks for using Manny Hub!";
    Duration = 2;
})

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/3aze/LTS/main/lib/turtle.lua"))()
local window = library:Window("Manny Hub")

local collectedCoins = {}

-- Function to teleport the player slightly above each "Coin_Server" part
local function teleportToCoins()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    local coins = workspace:GetDescendants()
    local foundCoin = false

    for _, item in ipairs(coins) do
        if item:IsA("BasePart") and item.Name == "Coin_Server" and not collectedCoins[item] then
            rootPart.CFrame = item.CFrame + Vector3.new(0, 3, 0) -- Teleport 3 units above the coin
            collectedCoins[item] = true -- Mark this coin as collected
            foundCoin = true
            -- Wait until the coin is touched (simple simulation with a delay)
            wait(0.5) -- Simulate the time it takes to touch the coin
            break
        end
    end

    -- If a Coin_Server is found and touched, teleport back to the specified coordinates
    if foundCoin then
        rootPart.CFrame = CFrame.new(-112.5636215209961, 135.0230255126953, 18.94784164428711)
    end
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local espEnabled = false
local highlights = {}

-- Function to update highlights
local function updateHighlight(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    -- Check if highlight already exists
    local highlight = highlights[player]
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Adornee = player.Character
        highlight.Parent = player.Character
        highlights[player] = highlight
    end

    -- Default color is white
    highlight.FillColor = Color3.new(1, 1, 1)

    -- Check inventory for specific tools
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        if backpack:FindFirstChild("Knife") then
            highlight.FillColor = Color3.new(1, 0, 0) -- Red
        elseif backpack:FindFirstChild("Gun") then
            highlight.FillColor = Color3.new(0, 0, 1) -- Blue
        end
    end
end

-- Function to handle players joining or respawning
local function onPlayerAdded(player)
    -- Update highlight when the player is respawned
    player.CharacterAdded:Connect(function()
        if espEnabled then
            updateHighlight(player)
        end
    end)

    -- Apply highlight on the player's first spawn (or if they are already in the game when the script starts)
    if espEnabled then
        updateHighlight(player)
    end
end

-- Setup existing players to ensure highlights
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Listen for new players joining and handle their highlights
Players.PlayerAdded:Connect(onPlayerAdded)

-- Continuously update the highlights of all players
RunService.Heartbeat:Connect(function()
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            updateHighlight(player)
        end
    end
end)

-- Toggle for ESP
window:Toggle("ESP", false, function(state)
    espEnabled = state
    if espEnabled then
        -- Add highlights to all players
        for _, player in ipairs(Players:GetPlayers()) do
            updateHighlight(player)
        end
    else
        -- Keep the highlights for all players if toggled off
        -- highlights will not be removed, so they persist
    end
end)

-- Continuous update of inventory-based highlights
RunService.Heartbeat:Connect(function()
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            updateHighlight(player)
        end
    end
end)

local bringEnemiesToggle = false
local originalPositions = {}

window:Toggle("Bring all enemies",false,function(t)
    bringEnemiesToggle = t
    getgenv().FLO = t -- Only update the global variable when this specific toggle is used

    local function bringEnemies()
        while bringEnemiesToggle do
            local player = game.Players.LocalPlayer
            local team = player.Team
            local character = player.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character then
                        local otherTeam = otherPlayer.Team
                        local otherHumanoidRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if otherHumanoidRootPart then
                            if (team and otherTeam and team ~= otherTeam) or (not team and not otherTeam) then
                                -- Store the original position if not already stored
                                if not originalPositions[otherPlayer.UserId] then
                                    originalPositions[otherPlayer.UserId] = otherHumanoidRootPart.CFrame
                                end
                                -- Calculate the position directly in front of the local player
                                local offset = humanoidRootPart.CFrame.LookVector * 3 -- Adjust the distance if needed
                                local newPosition = humanoidRootPart.Position + offset
                                -- Set the position and orientation of the other player's HumanoidRootPart
                                otherHumanoidRootPart.CFrame = CFrame.new(newPosition, humanoidRootPart.Position)
                            end
                        end
                    end
                end
            end
            wait(0.1) -- Adjust the wait time as needed
        end
        -- Return all players to their original positions
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            local originalCFrame = originalPositions[otherPlayer.UserId]
            if originalCFrame and otherPlayer.Character then
                local otherHumanoidRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                if otherHumanoidRootPart then
                    otherHumanoidRootPart.CFrame = originalCFrame
                end
            end
        end
        -- Clear the original positions table
        originalPositions = {}
    end
    local function onPlayerAdded(player)
        spawn(function()
            while bringEnemiesToggle do
                local localPlayer = game.Players.LocalPlayer
                local localTeam = localPlayer.Team
                local character = localPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart and player.Character then
                    local otherTeam = player.Team
                    local otherHumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if otherHumanoidRootPart then
                        if (localTeam and otherTeam and localTeam ~= otherTeam) or (not localTeam and not otherTeam) then
                            -- Store the original position if not already stored
                            if not originalPositions[player.UserId] then
                                originalPositions[player.UserId] = otherHumanoidRootPart.CFrame
                            end
                            -- Calculate the position directly in front of the local player
                            local offset = humanoidRootPart.CFrame.LookVector * 10 -- Adjust the distance if needed
                            local newPosition = humanoidRootPart.Position + offset
                            -- Set the position and orientation of the other player's HumanoidRootPart
                            otherHumanoidRootPart.CFrame = CFrame.new(newPosition, humanoidRootPart.Position)
                        end
                    end
                end
                wait(0.1) -- Adjust the wait time as needed
            end
        end)
    end
    if bringEnemiesToggle then
        spawn(function()
            bringEnemies()
        end)
    end
    game.Players.PlayerAdded:Connect(onPlayerAdded)
end)

window:Toggle("Autofarm coins", false, function(t)
    getgenv().FLO = t
    spawn(function()
        while getgenv().FLO do
            teleportToCoins()
            wait(2) -- Wait 2 seconds before running again
        end
    end)
end)

window:Button("Teleport to gun", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local originalPosition = humanoidRootPart.Position

    local function findGunDropInDescendants(parent)
        for _, descendant in ipairs(parent:GetDescendants()) do
            if descendant.Name == "GunDrop" and descendant:IsA("BasePart") then
                return descendant
            end
        end
        return nil
    end

    local gunDrop = findGunDropInDescendants(workspace)

    if gunDrop then
        humanoidRootPart.CFrame = gunDrop.CFrame
        wait(0.1)

        humanoidRootPart.CFrame = CFrame.new(originalPosition)
    else
        print("GunDrop part not found in the workspace.")
    end
end)

window:Button("Teleport to lobby", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-109.75447082519531, 154.662109375, 9.228076934814453)
end)

window:Button("Teleport ui", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptfree/Mannys-Scripts/refs/heads/main/Archives/Teleport-UI"))()
end)

window:Slider("Walkspeed",16,30,16,function(t)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)
