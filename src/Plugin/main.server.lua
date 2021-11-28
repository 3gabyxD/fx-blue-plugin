local Toolbar = plugin:CreateToolbar("FX-Blue")
local MainButton = Toolbar:CreateButton("Main", "Open FX-Blue", "")

local SocialService = game:GetService("SocialService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("FX-Blue-Main") then
	CoreGui:FindFirstChild("FX-Blue-Main"):Destroy()
end

local MainScreen = Instance.new("ScreenGui")
MainScreen.Name = "FX-Blue-Main"
MainScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainScreen.Parent = CoreGui

local ScreenButton = Instance.new("ImageButton")
ScreenButton.ImageTransparency = 1
ScreenButton.BackgroundTransparency = 1
ScreenButton.Size = UDim2.fromScale(1, 1)
ScreenButton.Visible = false
ScreenButton.Modal = true
ScreenButton.ZIndex = -50
--> ScreenButton.Parent = MainScreen

local mouse = plugin:GetMouse()

local Gui = script.Parent:WaitForChild("Gui")
local Toggled = Gui.Toggled
local Overlay = require(Gui.Overlay)
local Timeline = require(Gui.Timeline)

Timeline:Init(MainScreen, mouse)
Overlay:Init(MainScreen, mouse)

MainButton.Click:Connect(function()
	Overlay:Toggle()
end)

local ActiveWindows = 0

Toggled.Event:Connect(function(state)
	if state then
		ActiveWindows += 1
		if ActiveWindows == 1 then
			ScreenButton.Visible = true
		end
	else
		ActiveWindows -= 1
		if ActiveWindows <= 0 then
			ScreenButton.Visible = false
		end
	end
end)