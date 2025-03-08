local OrionLib = loadstring(game:HttpGet(('https://pastebin.com/raw/9fjCMyrA')))()

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

-- Create a Tab for the main scripts
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://17829948098",
    PremiumOnly = false
})

local betAmount = 1
local ballAmount = "1"

-- Add Textboxes inside the "Main" tab
MainTab:AddTextbox({
    Name = "Bet Amount", 
    Default = "1", 
    TextDisappear = true,
    Callback = function(value) 
        betAmount = tonumber(value) or 1
    end	  
})

MainTab:AddTextbox({
    Name = "Ball Amount", 
    Default = "1", 
    TextDisappear = true,
    Callback = function(value) 
        ballAmount = value
    end	  
})

-- Toggle to auto bet and roll
MainTab:AddToggle({
    Name = "Auto Bet & Roll", 
    Default = false,
    Callback = function(Value)
        betToggle = Value
        if betToggle then
            while betToggle do
                local args = {
                    {
                        BetAmount = betAmount,
                        BallAmount = ballAmount
                    }
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Run"):FireServer(unpack(args))

                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RollComplete"):FireServer()

                task.wait()
            end
        end
    end    
})

-- Create a Tab for exiting
local ExitTab = Window:MakeTab({
    Name = "Exit",
    Icon = "rbxassetid://9405925538",
    PremiumOnly = false
})

ExitTab:AddButton({
    Name = "Close GUI",
    Callback = function()
        OrionLib:Destroy()
    end    
})

OrionLib:Init()
