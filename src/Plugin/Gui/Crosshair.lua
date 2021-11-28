local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local gui = script.Parent
local Theme = require(gui.Theme)

return {
	Active = false,

	Init = function(self, screen)
		self.image = Instance.new("ImageLabel")
		self.image.Size = UDim2.fromOffset(Theme.CrosshairSize, Theme.CrosshairSize)
		self.image.Image = "rbxassetid://" .. Theme.Crosshair
		self.image.AnchorPoint = Vector2.new(.5, .5)
		self.image.BackgroundTransparency = 1
		self.image.Visible = false
		self.image.Parent = screen
		RunService.Heartbeat:Connect(function(deltaTime)
			local pos = UserInputService:GetMouseLocation()
			self.image.Position = UDim2.fromOffset(
				pos.X, pos.Y
			)
		end)
	end,

	Enable = function(self)
		UserInputService.MouseIconEnabled = false
		self.image.Visible = true
	end,

	Disable = function(self)
		UserInputService.MouseIconEnabled = true
		self.image.Visible = false
	end,
}