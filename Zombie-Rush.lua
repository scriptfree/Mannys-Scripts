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

Tab:AddToggle({
    Name = "Big head zombies",
    Default = false,
    Callback = function(Value)
        local zombieFolder = workspace:FindFirstChild("Zombie Storage")

        if zombieFolder then
            local function processZombies(folder, bigHead)
                for _, obj in pairs(folder:GetChildren()) do
                    if obj:IsA("Model") then
                        local head = obj:FindFirstChild("Head")
                        if head and head:IsA("BasePart") then
                            if bigHead then
                                head.Size = Vector3.new(10, 10, 10) -- Big head size
                            else
                                head.Size = Vector3.new(2, 1, 1) -- Default head size
                            end
                            head.CanCollide = false
                            head.Transparency = bigHead and 0 or 1 -- Keep head visible when big, make invisible when normal
                        end

                        for _, part in pairs(obj:GetChildren()) do
                            if part:IsA("BasePart") and part.Name ~= "Head" then
                                if bigHead then
                                    part.Transparency = 1 -- Make other parts invisible when toggle is on
                                    part.CanCollide = false
                                else
                                    part.Transparency = 0 -- Make other parts visible when toggle is off
                                    part.CanCollide = true -- Enable collision when toggle is off
                                end
                            end
                        end
                    elseif obj:IsA("Folder") or obj:IsA("Model") then
                        processZombies(obj, bigHead) -- Recursively process nested folders or models
                    end
                end
            end

            -- Loop to continuously check the toggle state
            spawn(function()
                while true do
                    if Value then
                        processZombies(zombieFolder, true)  -- Big head when toggle is on
                    else
                        processZombies(zombieFolder, false) -- Default size when toggle is off
                    end
                    wait(0.5)  -- Adjust the loop delay as needed to reduce performance impact
                end
            end)
        else
            warn("Zombie Storage folder not found!")
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
