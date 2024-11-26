local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Manny's Scripts", HidePremium = false, IntroEnabled = false, SaveConfig = nil})

OrionLib:MakeNotification({
    Name = "Notification",
    Content = "Successfully loaded.",
    Image = "rbxassetid://17829956110",
    Time = 3
})

local teleportToggle = false
local teleportPosition = CFrame.new(-744.01806640625, 54.25789642333984, -557.5186157226562)

local Tab = Window:MakeTab({
	Name = "Welcome",
	Icon = "rbxassetid://17829948098",
	PremiumOnly = false
})

Tab:AddParagraph("Thank you for using Manny's Script","Thank you for using my script, it means a lot to me!")

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4034483357",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Big head zombies",
    Callback = function()
        local zombieFolder = workspace:FindFirstChild("Zombie Storage")

        if zombieFolder then
            local function processZombies(folder)
                for _, obj in pairs(folder:GetChildren()) do
                    if obj:IsA("Model") then
                        local head = obj:FindFirstChild("Head")
                        if head and head:IsA("BasePart") then
                            head.Size = Vector3.new(13, 13, 13) -- Updated head size to 10
                            head.CanCollide = false
                            head.Transparency = 0 -- Ensure the head remains visible
                        end

                        for _, part in pairs(obj:GetChildren()) do
                            if part:IsA("BasePart") and part.Name ~= "Head" then
                                part.Transparency = 1 -- Make all other parts invisible
                                part.CanCollide = false -- Disable collisions for all other parts
                            end
                        end
                    elseif obj:IsA("Folder") or obj:IsA("Model") then
                        processZombies(obj) -- Recursively process nested folders or models
                    end
                end
            end

            processZombies(zombieFolder)
        else
            warn("Zombie Storage folder not found!")
        end
    end
})

Tab:AddButton({
    Name = "Bring zombies",
    Callback = function()
        local zombieFolder = workspace:FindFirstChild("Zombie Storage")
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and zombieFolder then
            local characterPosition = character.HumanoidRootPart.Position
            -- Position in front of the character (adjust distance as needed)
            local teleportPosition = characterPosition + character.HumanoidRootPart.CFrame.LookVector * 10

            for _, zombie in pairs(zombieFolder:GetChildren()) do
                if zombie:IsA("Model") then
                    local humanoidRootPart = zombie:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        -- Teleport each zombie in the folder to the position in front of the character
                        humanoidRootPart.CFrame = CFrame.new(teleportPosition)
                    end
                end
            end
        else
            warn("Zombie Storage folder or player character not found!")
        end
    end
})

Tab:AddButton({
    Name = "Safe spot",
    Callback = function()
        -- Create a platform far from the map
        local platformSize = Vector3.new(10, 1, 10) -- Platform size (10x1x10 studs)
        local platformPosition = Vector3.new(10000, 500, 10000) -- Platform position far away from the map

        -- Create the platform part
        local platform = Instance.new("Part")
        platform.Size = platformSize
        platform.Position = platformPosition
        platform.Anchored = true
        platform.BrickColor = BrickColor.new("Bright blue") -- Change color if needed
        platform.Name = "TeleportPlatform"
        platform.Parent = workspace

        -- Optionally, teleport the player to the platform (if desired)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(platformPosition + Vector3.new(0, 5, 0)) -- Teleport above platform
        end
    end    
})




local Tab = Window:MakeTab({
	Name = "Exit",
	Icon = "rbxassetid://9405925538",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Close gui",
    Callback = function()
        OrionLib:Destroy()
    end    
})


OrionLib:Init()
