local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/scriptfree/Mannys-Scripts/refs/heads/main/orion')))()

local Window = OrionLib:MakeWindow({Name = "Manny's Scripts", HidePremium = false, IntroEnabled = false, SaveConfig = nil})

OrionLib:MakeNotification({
    Name = "Notification",
    Content = "Successfully loaded.",
    Image = "rbxassetid://17829956110",
    Time = 3
})

local teleportToggle = false
local teleportPosition = CFrame.new(-744.01806640625, 54.25789642333984, -557.5186157226562)

local tpToggle = false
local crateToggle = false
local deleteDuplicatesToggle = false

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
    Name = "Show path",
    Callback = function()
        local segmentSystem = workspace:FindFirstChild("segmentSystem")
        if segmentSystem then
            local segmentsFolder = segmentSystem:FindFirstChild("Segments")
            if segmentsFolder then
                for _, segment in pairs(segmentsFolder:GetChildren()) do
                    local folder = segment:FindFirstChild("Folder")
                    if folder then
                        for _, part in pairs(folder:GetChildren()) do
                            if part:IsA("BasePart") then
                                if part:FindFirstChild("breakable") then
                                    part.BrickColor = BrickColor.new("Bright red")
                                else
                                    part.BrickColor = BrickColor.new("Bright green")
                                end
                            end
                        end
                    end
                end
            end
        end
    end    
})

Tab:AddButton({
    Name = "Remove vip door",
    Callback = function()
        local vipObject = workspace:FindFirstChild("VIP")
        if vipObject then
            local vipDoor = vipObject:FindFirstChild("VipDoor")
            if vipDoor then
                vipDoor:Destroy()
            else
                warn("VipDoor not found inside VIP.")
            end
        else
            warn("VIP object not found in workspace.")
        end
    end    
})

Tab:AddButton({
	Name = "Free helicopter", 
	Callback = function()
		local lobby = workspace:FindFirstChild("Lobby")
		if lobby then
			local heliArea = lobby:FindFirstChild("HeliArea")
			if heliArea then
				local unionPart = heliArea:FindFirstChild("Union")
				if unionPart then
					unionPart:Destroy()
				end

				local heliGuiPart = heliArea:FindFirstChild("HeliGui")
				if heliGuiPart then
					heliGuiPart:Destroy()
				end
			else
				warn("HeliArea object not found in Lobby.")
			end
		else
			warn("Lobby folder not found in Workspace.")
		end
	end    
})

Tab:AddToggle({
    Name = "Autofarm glass bridge",
    Default = false,
    Callback = function(Value)
        teleportToggle = Value
        if teleportToggle then
            while teleportToggle do
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = teleportPosition
                end
                task.wait() 
            end
        end
    end    
})

Tab:AddToggle({
    Name = "Autoclaim", 
    Default = false,
    Callback = function(Value)
        tpToggle = Value
        if tpToggle then
            while tpToggle do
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("FinishRewardClaimed"):FireServer()
                task.wait() -- Adjust the interval as needed
            end
        end
    end    
})

Tab:AddToggle({
    Name = "Auto Robux Crate", 
    Default = false,
    Callback = function(Value)
        crateToggle = Value
        if crateToggle then
            while crateToggle do
                local args1 = {"processCrate", 3}
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("crateRemote"):FireServer(unpack(args1))
                
                local args2 = {"processReward", 3}
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("crateRemote"):FireServer(unpack(args2))
                
                task.wait() -- Adjust the interval as needed
            end
        end
    end    
})

Tab:AddToggle({
    Name = "Remove Duplicate Tools", 
    Default = false,
    Callback = function(Value)
        deleteDuplicatesToggle = Value
        if deleteDuplicatesToggle then
            while deleteDuplicatesToggle do
                local player = game.Players.LocalPlayer
                if player and player.Backpack then
                    local seenTools = {}
                    for _, tool in pairs(player.Backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            if seenTools[tool.Name] then
                                tool:Destroy()
                            else
                                seenTools[tool.Name] = true
                            end
                        end
                    end
                end
                task.wait(1) -- Adjust the interval as needed
            end
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
