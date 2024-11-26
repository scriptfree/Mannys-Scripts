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
            -- Function to apply big head size to zombies
            local function setBigHead(zombie, bigHead)
                local head = zombie:FindFirstChild("Head")
                if head and head:IsA("BasePart") then
                    if bigHead then
                        if head.Size ~= Vector3.new(10, 10, 10) then
                            head.Size = Vector3.new(10, 10, 10)  -- Big head size
                            head.CanCollide = false
                            head.Transparency = 0  -- Ensure the head remains visible
                        end
                    else
                        if head.Size ~= Vector3.new(2, 1, 1) then
                            head.Size = Vector3.new(2, 1, 1)  -- Normal head size
                            head.CanCollide = true
                            head.Transparency = 0  -- Ensure the head remains visible
                        end
                    end
                end
            end

            -- Function to process all zombies in the folder
            local function processZombies(bigHead)
                for _, obj in pairs(zombieFolder:GetChildren()) do
                    if obj:IsA("Model") then
                        setBigHead(obj, bigHead)

                        -- Handle other body parts' transparency and collision
                        for _, part in pairs(obj:GetChildren()) do
                            if part:IsA("BasePart") and part.Name ~= "Head" then
                                if bigHead then
                                    if part.Transparency ~= 1 then
                                        part.Transparency = 1  -- Make other parts invisible
                                    end
                                    if part.CanCollide then
                                        part.CanCollide = false
                                    end
                                else
                                    if part.Transparency ~= 0 then
                                        part.Transparency = 0  -- Make other parts visible
                                    end
                                    if not part.CanCollide then
                                        part.CanCollide = true
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- Handle the toggle on/off and ensure big heads are applied when the toggle is on
            local headBig = Value
            if headBig then
                processZombies(true)  -- Apply big heads to existing zombies
            else
                processZombies(false)  -- Set to normal size
            end

            -- Monitor for new zombies being added to the folder
            zombieFolder.ChildAdded:Connect(function(child)
                if child:IsA("Model") then
                    setBigHead(child, headBig)  -- Apply big head to new zombie
                end
            end)

            -- Continuously update if the toggle is on
            spawn(function()
                while true do
                    if Value ~= headBig then  -- If toggle state changes
                        headBig = Value
                        processZombies(headBig)  -- Apply big heads or revert to normal
                    end
                    wait()  -- Adjust the loop delay as needed
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
