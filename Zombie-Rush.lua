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
                            head.Size = Vector3.new(10, 10, 10)
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
