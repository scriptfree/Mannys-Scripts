game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Success";
    Text = "Thanks for using my script!";
    Duration = 2;
})

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/3aze/LTS/main/lib/turtle.lua"))()
local window = library:Window("Manny's Scripts")
local bringEntitiesToggle = false
local originalPositions = {}

window:Toggle("Bring all players & robots", false, function(t)
    bringEntitiesToggle = t
    getgenv().FLO = t

    local function bringEntitiesAndPlayers()
        while bringEntitiesToggle do
            local player = game.Players.LocalPlayer
            local character = player.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart then
                local entitiesFolder = game.Workspace:FindFirstChild("Map")
                if entitiesFolder then
                    entitiesFolder = entitiesFolder:FindFirstChild("Perishables")
                    if entitiesFolder then
                        entitiesFolder = entitiesFolder:FindFirstChild("Characters")
                        if entitiesFolder then
                            entitiesFolder = entitiesFolder:FindFirstChild("Players")
                            if entitiesFolder then
                                for _, entity in pairs(entitiesFolder:GetChildren()) do
                                    if entity:IsA("Model") and entity ~= character then
                                        local entityRoot = entity:FindFirstChild("HumanoidRootPart") or entity.PrimaryPart
                                        if entityRoot then
                                            -- Store original position if not already stored
                                            if not originalPositions[entity] then
                                                originalPositions[entity] = entityRoot.CFrame
                                            end
                                            -- Bring entity 10 studs in front of the player
                                            local offset = humanoidRootPart.CFrame.LookVector * 10
                                            entityRoot.CFrame = CFrame.new(humanoidRootPart.Position + offset, humanoidRootPart.Position)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                -- Bring actual players
                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character then
                        local otherHumanoidRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if otherHumanoidRootPart then
                            -- Store original position if not already stored
                            if not originalPositions[otherPlayer.UserId] then
                                originalPositions[otherPlayer.UserId] = otherHumanoidRootPart.CFrame
                            end
                            -- Bring player in front of local player
                            local offset = humanoidRootPart.CFrame.LookVector * 10
                            otherHumanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position + offset, humanoidRootPart.Position)
                        end
                    end
                end
            end
            wait(0.1)
        end

        -- Return everything to original positions when toggle is off
        for entity, cframe in pairs(originalPositions) do
            if entity and entity:IsA("Model") and (entity:FindFirstChild("HumanoidRootPart") or entity.PrimaryPart) then
                (entity:FindFirstChild("HumanoidRootPart") or entity.PrimaryPart).CFrame = cframe
            elseif typeof(entity) == "number" then -- Player check (UserId stored)
                local playerToRestore = game.Players:GetPlayerByUserId(entity)
                if playerToRestore and playerToRestore.Character and playerToRestore.Character:FindFirstChild("HumanoidRootPart") then
                    playerToRestore.Character.HumanoidRootPart.CFrame = cframe
                end
            end
        end
        originalPositions = {}
    end

    if bringEntitiesToggle then
        spawn(function()
            bringEntitiesAndPlayers()
        end)
    end
end)

window:Slider("Walkspeed", 16, 100, 20, function(t)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)
