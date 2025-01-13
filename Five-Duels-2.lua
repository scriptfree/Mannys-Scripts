local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Manny's Scripts", HidePremium = false, IntroEnabled = false, SaveConfig = nil})

OrionLib:MakeNotification({
    Name = "Notification",
    Content = "Successfully loaded.",
    Image = "rbxassetid://17829956110",
    Time = 3
})

Tab:AddToggle({
    Name = "Bighead",
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer -- The local player (you)
        local connections = {} -- Store connections to disconnect later

        local function setBigHead(character, enable)
            local head = character:FindFirstChild("Head")
            if head then
                if enable then
                    head.Size = Vector3.new(2, 2, 2) -- Set the head size to 2
                    local mesh = head:FindFirstChild("Mesh") or head:FindFirstChild("SpecialMesh")
                    if mesh then
                        mesh.Scale = Vector3.new(2, 2, 2) -- Adjust the mesh scale
                    end
                else
                    head.Size = Vector3.new(1, 1, 1) -- Reset head size to default
                    local mesh = head:FindFirstChild("Mesh") or head:FindFirstChild("SpecialMesh")
                    if mesh then
                        mesh.Scale = Vector3.new(1, 1, 1) -- Reset mesh scale to default
                    end
                end
            end
        end

        local function handlePlayer(player, enable)
            if player ~= LocalPlayer then
                if enable then
                    local connection = player.CharacterAdded:Connect(function(character)
                        task.wait(1) -- Wait for the character to fully load
                        setBigHead(character, true)
                    end)
                    table.insert(connections, connection) -- Store connection for later
                    if player.Character then
                        setBigHead(player.Character, true) -- Apply to the current character
                    end
                else
                    if player.Character then
                        setBigHead(player.Character, false) -- Reset the head size
                    end
                end
            end
        end

        if Value then
            -- Enable big heads for all players except you
            for _, player in pairs(Players:GetPlayers()) do
                handlePlayer(player, true)
            end

            -- Enable big heads for new players
            local connection = Players.PlayerAdded:Connect(function(player)
                handlePlayer(player, true)
            end)
            table.insert(connections, connection)
        else
            -- Disable big heads for all players except you
            for _, player in pairs(Players:GetPlayers()) do
                handlePlayer(player, false)
            end

            -- Disconnect all stored connections to stop processing
            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
            connections = {}
        end
    end
})

OrionLib:Init()
