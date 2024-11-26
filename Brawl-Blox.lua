game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Success";
                Text = "Thanks for using my script!";
                Duration = 2;})
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/3aze/LTS/main/lib/turtle.lua"))()
local window = library:Window("Manny's Scripts")
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
                                local offset = humanoidRootPart.CFrame.LookVector * 10 -- Adjust the distance if needed
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



window:Button("Safe spot", function()
    local platformSize = Vector3.new(10, 1, 10)
    local platformPosition = Vector3.new(10000, 500, 10000)

    local platform = Instance.new("Part")
    platform.Size = platformSize
    platform.Position = platformPosition
    platform.Anchored = true
    platform.BrickColor = BrickColor.new("Bright blue")
    platform.Name = "TeleportPlatform"
    platform.Parent = workspace

    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(platformPosition + Vector3.new(0, 5, 0))
    end
end)


window:Slider("Walkspeed",16,100,20,function(t)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)
