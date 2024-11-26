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
        
        -- Function to apply big head to zombies
        local function setBigHead(zombie)
            local head = zombie:FindFirstChild("Head")
            if head and head:IsA("BasePart") then
                if head.Size ~= Vector3.new(15, 15, 15) then
                    head.Size = Vector3.new(15, 15, 15)  -- Set head size to 15
                    head.CanCollide = false
                    head.Transparency = 0  -- Ensure the head remains visible
                end
            end
        end

        -- Continuously check zombies and apply the big head when the toggle is on
        spawn(function()
            while true do
                if Value then
                    -- Loop through all zombies in the folder and give them big heads
                    if zombieFolder then
                        for _, obj in pairs(zombieFolder:GetChildren()) do
                            if obj:IsA("Model") then
                                setBigHead(obj)
                            end
                        end
                    end
                end
                wait()  -- Wait a little bit before checking again
            end
        end)
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
