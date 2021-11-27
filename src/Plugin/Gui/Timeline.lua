local TweenService = game:GetService("TweenService")

local Toggled = script.Parent.Toggled
local Theme = require(script.Parent.Theme)

local Elements = script.Parent.Elements
local Resizable = require(Elements.Resizable)
local Button = require(Elements.Button)
local Transparency = require(Elements.Transparency)

return {
	Active = false,
	Init = function(self, screen)
		self.frame = Instance.new("Frame")
		self.frame.Position = UDim2.fromScale(.5, .5)
		self.frame.Size = UDim2.fromOffset(200, 150)
		self.frame.BackgroundColor3 = Theme.Background
		self.frame.BackgroundTransparency = Theme.BackgroundTransparency
		self.frame.Visible = false

		self.corner = Instance.new("UICorner")
		self.corner.CornerRadius = UDim.new(0, Theme.CornerRadius)
		self.corner.Parent = self.frame

		Resizable(self.frame)

		self.frame.Parent = screen
	end,
	Update = function(self)
	end,
	Open = function(self)
		self.Active = true
		self.frame.Visible = true
		Toggled:Fire(self.Active)
	end,
	Close = function(self)
		self.Active = false
		self.frame.Visible = false
		Toggled:Fire(self.Active)
	end,
}