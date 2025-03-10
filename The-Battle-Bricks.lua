local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/scriptfree/Mannys-Scripts/refs/heads/main/orion')))()

local Window = OrionLib:MakeWindow({Name = "Manny's Scripts", HidePremium = false, IntroEnabled = false, SaveConfig = nil})

OrionLib:MakeNotification({
    Name = "Notification",
    Content = "Successfully loaded.",
    Image = "rbxassetid://17829956110",
    Time = 3
})

local Tab = Window:MakeTab({
	Name = "Welcome",
	Icon = "rbxassetid://17829948098",
	PremiumOnly = false
})

Tab:AddParagraph("Thank you for using Manny's Script","Thank you for using my script, it means a lot to me!")

-- Create the 'Main' tab
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4034483344",
    PremiumOnly = false
})

-- Add a section under the 'Main' tab
local Section = Tab:AddSection({
    Name = "Autofarm"
})

-- Add a dropdown for selecting chapter
Tab:AddDropdown({
    Name = "Chapter", 
    Default = "Chapter1", 
    Options = {"Chapter1", "Chapter2", "Chapter3"}, 
    Callback = function(Value)
        getgenv().SelectedChapter = Value
    end    
})

-- Add a Textbox for selecting the stage
Tab:AddTextbox({
    Name = "Stage", 
    Default = "1", 
    TextDisappear = false, 
    Callback = function(Value)
        -- Check if the entered value is a number
        local num = tonumber(Value)
        if num and num >= 1 and num <= 30 then
            -- If valid, set the stage to the entered number
            getgenv().SelectedStage = num
        else
            -- If invalid, print an error message and reset to default
            warn("Please enter a number between 1 and 30.")
            getgenv().SelectedStage = 1 -- Default to 1 if invalid
        end
    end  
})

-- Add toggle for auto replay stage
Tab:AddToggle({
    Name = "Auto replay stage",
    Default = false,
    Callback = function(Value)
        getgenv().AutoReplayStage = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoReplayStage do
                    local success, err = pcall(function()
                        local args = {
                            getgenv().SelectedChapter or "Chapter1",  -- Default to Chapter1 if no selection
                            getgenv().SelectedStage or 1,             -- Default to Stage 1 if no input
                            2,
                            1,
                            false,
                            {},
                            false
                        }
                        -- Trigger battle start event
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("StartBattle"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoReplayStage:", err)
                    end

                    wait(1) -- Wait before trying again
                end
            end)
        end
    end    
})

-- Add toggle for auto fire canon
Tab:AddToggle({
    Name = "Auto fire cannon",
    Default = false,
    Callback = function(Value)
        getgenv().AutoFireCannon = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoFireCannon do
                    local success, err = pcall(function()
                        local args = { "Cannon" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoFireCannon:", err)
                    end

                    wait(1) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

-- Add toggle for auto upgrade bank
Tab:AddToggle({
    Name = "Auto upgrade bank",
    Default = false,
    Callback = function(Value)
        getgenv().AutoUpgradeBank = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoUpgradeBank do
                    local success, err = pcall(function()
                        local args = { "Bank" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoUpgradeBank:", err)
                    end

                    wait(1) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

-- Add toggle for auto spawn unit 1
Tab:AddToggle({
    Name = "Auto spawn unit 1",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit1 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit1 do
                    local success, err = pcall(function()
                        local args = { "Slot1" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit1:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

-- Add toggle for auto spawn unit 2
Tab:AddToggle({
    Name = "Auto spawn unit 2",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit2 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit2 do
                    local success, err = pcall(function()
                        local args = { "Slot2" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit2:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

-- Add toggle for auto spawn unit 3
Tab:AddToggle({
    Name = "Auto spawn unit 3",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit3 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit3 do
                    local success, err = pcall(function()
                        local args = { "Slot3" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit3:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

-- Add toggle for auto spawn unit 4
Tab:AddToggle({
    Name = "Auto spawn unit 4",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit4 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit4 do
                    local success, err = pcall(function()
                        local args = { "Slot4" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit4:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

Tab:AddToggle({
    Name = "Auto spawn unit 5",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit5 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit5 do
                    local success, err = pcall(function()
                        local args = { "Slot5" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit5:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

Tab:AddToggle({
    Name = "Auto spawn unit 6",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit6 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit6 do
                    local success, err = pcall(function()
                        local args = { "Slot6" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit6:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

Tab:AddToggle({
    Name = "Auto spawn unit 7",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit7 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit7 do
                    local success, err = pcall(function()
                        local args = { "Slot7" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit7:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

Tab:AddToggle({
    Name = "Auto spawn unit 8",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSpawnUnit8 = Value
        
        if Value then
            task.spawn(function()
                while getgenv().AutoSpawnUnit8 do
                    local success, err = pcall(function()
                        local args = { "Slot8" }
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteFunction"):WaitForChild("PlayerSpawn"):InvokeServer(unpack(args))
                    end)
                    
                    if not success then
                        warn("Error in AutoSpawnUnit8:", err)
                    end

                    wait(0.5) -- Adjust the interval as needed
                end
            end)
        end
    end    
})

local Tab = Window:MakeTab({
    Name = "Exit",
    Icon = "rbxassetid://9405925538",
    PremiumOnly = false
})

Tab:AddButton({
    Name = "Close GUI",
    Callback = function()
        OrionLib:Destroy()
    end    
})

OrionLib:Init()
