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

local tpToggle = false
local teleportPos = CFrame.new(-956.1198120117188, -3.3999946117401123, 1337.1455078125)

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
		-- Navigate to the lobby folder and delete specific objects in HeliPad inside HeliArea
		local lobbyFolder = workspace:FindFirstChild("lobby")

		if lobbyFolder then
			local heliArea = lobbyFolder:FindFirstChild("HeliArea")
			if heliArea then
				local heliPad = heliArea:FindFirstChild("HeliPad")
				if heliPad then
					-- Delete "Union" if it exists
					local unionObject = heliPad:FindFirstChild("Union")
					if unionObject then
						unionObject:Destroy()
						print("Union has been deleted.")
					end

					-- Delete "HeliGui" if it exists
					local heliGuiObject = heliPad:FindFirstChild("HeliGui")
					if heliGuiObject then
						heliGuiObject:Destroy()
						print("HeliGui has been deleted.")
					end
				else
					warn("HeliPad not found in HeliArea!")
				end
			else
				warn("HeliArea not found in lobby!")
			end
		else
			warn("Lobby folder not found in workspace!")
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
                task.wait(3)
            end
        end
    end    
})

Tab:AddToggle({
    Name = "Autofarm maze",
    Default = false,
    Callback = function(Value)
        tpToggle = Value
        if tpToggle then
            while tpToggle do
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = teleportPos
                end
                task.wait(0.275)
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
