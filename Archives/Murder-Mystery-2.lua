game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Success";
                Text = "Thanks for using Manny Hub!";
                Duration = 2;})
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/3aze/LTS/main/lib/turtle.lua"))()
local window = library:Window("Manny Hub")


local function updateHighlight(player)
    -- Check if the player has a character
    if player.Character then
        -- Find or create the highlight
        local highlight = player.Character:FindFirstChild("Highlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "Highlight"
            highlight.Parent = player.Character
            highlight.OutlineTransparency = 0 -- Outline fully visible
            highlight.FillTransparency = 0.5 -- Semi-transparent fill
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Always visible
        end
        
        -- Check the player's backpack and character for tools
        local hasKnife = false
        local hasGun = false
        
        if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
            hasKnife = true
        end
        if player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
            hasGun = true
        end

        -- Set the highlight color based on the tools
        if hasKnife then
            highlight.FillColor = Color3.new(1, 0, 0) -- Red fill color for Knife
            highlight.OutlineColor = Color3.new(1, 0, 0) -- Red outline color for Knife
        elseif hasGun then
            highlight.FillColor = Color3.new(0, 0, 1) -- Blue fill color for Gun
            highlight.OutlineColor = Color3.new(0, 0, 1) -- Blue outline color for Gun
        else
            highlight.FillColor = Color3.new(0.5, 0.5, 0.5) -- Grey fill color for others
            highlight.OutlineColor = Color3.new(1, 1, 1) -- White outline color for others
        end
    end
end

-- Function to remove highlights from a specific player
local function removeHighlight(player)
    if player.Character then
        local highlight = player.Character:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end

-- Function to remove highlights from all players
local function removeAllHighlights()
    for _, player in pairs(game.Players:GetPlayers()) do
        removeHighlight(player)
    end
end

-- Function to update highlights for all players
local function updateAllHighlights()
    for _, player in pairs(game.Players:GetPlayers()) do
        updateHighlight(player)
    end
end

-- Function to set up event listeners for a player
local function setupPlayer(player)
    player.CharacterAdded:Connect(function()
        -- Delay to ensure player's tools have loaded
        wait(1)
        
        if getgenv().FLO then
            -- Add/update the highlight for the new player's character
            updateHighlight(player)
        else
            -- Remove the highlight if the toggle is off
            removeHighlight(player)
        end
        
        -- Update highlight if the player's backpack changes
        player.Backpack.ChildAdded:Connect(function()
            if getgenv().FLO then
                updateHighlight(player)
            else
                removeHighlight(player)
            end
        end)
        player.Backpack.ChildRemoved:Connect(function()
            if getgenv().FLO then
                updateHighlight(player)
            else
                removeHighlight(player)
            end
        end)
    end)
end

-- Event listener for new players joining
game.Players.PlayerAdded:Connect(function(player)
    setupPlayer(player)
end)

-- Setup existing players
for _, player in pairs(game.Players:GetPlayers()) do
    setupPlayer(player)
end

window:Toggle("ESP",false, function(t)
    getgenv().FLO = t
    if getgenv().FLO then
        while getgenv().FLO do
            updateAllHighlights()
            wait(0.5)
        end
    else
        removeAllHighlights()
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

window:Slider("Walkspeed",16,30,16,function(t)

    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t

end)
