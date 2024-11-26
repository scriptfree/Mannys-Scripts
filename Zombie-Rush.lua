local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Manny's Scripts", HidePremium = false, IntroEnabled = false, SaveConfig = nil})

local teleportToggle = false
local teleportPosition = CFrame.new(-744.01806640625, 54.25789642333984, -557.5186157226562)

local Tab = Window:MakeTab({
	Name = "Welcome",
	Icon = "rbxassetid://17829948098",
	PremiumOnly = false
})

