-- Toggle script for big heads
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local toggled = false
local localPlayer = Players.LocalPlayer

-- Function to give big head to a player
local function giveBigHead(player)
    if player.Character and player ~= localPlayer then
        local head = player.Character:FindFirstChild("Head")
        if head then
            head.Size = Vector3.new(5, 5, 5)
            head.Massless = true
        end
    end
end

-- Function to reset head size
local function resetHead(player)
    if player.Character and player ~= localPlayer then
        local head = player.Character:FindFirstChild("Head")
        if head then
            head.Size = Vector3.new(2, 1, 1)
            head.Massless = false
        end
    end
end

-- Toggle function
local function toggleBigHeads()
    toggled = not toggled
    if toggled then
        for _, player in pairs(Players:GetPlayers()) do
            giveBigHead(player)
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            resetHead(player)
        end
    end
end

-- Listen for T key press
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.T then
        toggleBigHeads()
    end
end)

-- Continuously update for new players or respawns
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if toggled then
            giveBigHead(player)
        end
    end)
end)

RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if toggled then
            giveBigHead(player)
        end
    end
end)

-- Initial setup for players already in the game
for _, player in pairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(character)
        if toggled then
            giveBigHead(player)
        end
    end)
    if player.Character then
        giveBigHead(player)
    end
end
