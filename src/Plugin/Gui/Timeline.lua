local TweenService = game:GetService("TweenService")

local Toggled = script.Parent.Toggled
local Theme = require(script.Parent.Theme)

local Elements = script.Parent.Elements
local Resizable = require(Elements.Resizable)
local Draggable = require(Elements.Draggable)
local Button = require(Elements.Button)
local Transparency = require(Elements.Transparency)

return {
	Active = false,
	Init = function(self, screen)
		self.frame = Instance.new("Frame")
		-- self.frame.Position = UDim2.fromScale(.5, .5)
		self.frame.Size = UDim2.fromOffset(250, 400)
		self.frame.BackgroundColor3 = Theme.Background
		self.frame.BackgroundTransparency = Theme.BackgroundTransparency
		self.frame.BorderColor3 = Theme.BorderColor
		self.frame.BorderSizePixel = Theme.BorderSize
		self.frame.Visible = false

		if Theme.CornerRadius > 0 then	
			self.corner = Instance.new("UICorner")
			self.corner.CornerRadius = UDim.new(0, Theme.CornerRadius)
			self.corner.Parent = self.frame
		end

		Resizable(self.frame,
			Vector2.new(200, 150)
		)
		Draggable(self.frame)

		self.frame.Parent = screen

		Transparency:cacheall(self.frame)
	end,
	Update = function(self)
	end,
	Open = function(self)
		self.Active = true
		self.frame.Visible = true
		self.frame.Size = UDim2.fromOffset(250-50, 400-50)
		TweenService:Create(
			self.frame,
			TweenInfo.new(Theme.Transition),
			{Size = UDim2.fromOffset(250, 400)}
		):Play()
		Transparency:fade(self.frame, Theme.Transition, 1, 0)
		Toggled:Fire(self.Active)
	end,
	Close = function(self)
		Transparency:fade(self.frame, Theme.Transition, 0, 1)
		TweenService:Create(
			self.frame,
			TweenInfo.new(Theme.Transition),
			{Size = UDim2.fromOffset(250-50, 400-50)}
		):Play()
		task.wait(Theme.Transition)
		self.Active = false
		self.frame.Visible = false
		Toggled:Fire(self.Active)
	end,
}