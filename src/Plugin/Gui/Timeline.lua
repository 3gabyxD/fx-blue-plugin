local TweenService = game:GetService("TweenService")

local Toggled = script.Parent.Toggled
local Theme = require(script.Parent.Theme)

local Elements = script.Parent.Elements
local Resizable = require(Elements.Resizable)
local Draggable = require(Elements.Draggable)
local Button = require(Elements.Button)
local Transparency = require(Elements.Transparency)

local function controlbutton(image, callback)
	local b = Instance.new("ImageButton")
	b.Image = "rbxassetid://" .. image
	b.ImageColor3 = Theme.Foreground
	b.ImageTransparency = Theme.ForegroundTransparency
	b.SizeConstraint = Enum.SizeConstraint.RelativeYY
	b.Size = UDim2.fromScale(1,1)
	b.BackgroundTransparency = 1
	return b
end

return {
	Active = false,
	Init = function(self, screen, mouse)
		self.frame = Instance.new("Frame")
		self.frame.Position = UDim2.fromScale(.5, .5)
		self.frame.Size = UDim2.fromOffset(400, 250)
		self.frame.BackgroundColor3 = Theme.Background
		self.frame.BackgroundTransparency = Theme.BackgroundTransparency
		self.frame.BorderColor3 = Theme.BorderColor
		self.frame.BorderSizePixel = Theme.BorderSize
		self.frame.AnchorPoint = Vector2.new(.5, .5)
		self.frame.Visible = false

		if Theme.CornerRadius > 0 then
			self.corner = Instance.new("UICorner")
			self.corner.CornerRadius = UDim.new(0, Theme.CornerRadius)
			self.corner.Parent = self.frame
		end

		Resizable(self.frame, Vector2.new(300, 200), Vector2.new(600, 400))
		Draggable(self.frame)
		-->> Tool Bar <<---
		--> controls
		--> controlslist
		--> buttons (table)
		self.bar = Instance.new("Frame")
		self.bar.BackgroundColor3 = Theme.Midground
		self.bar.BackgroundTransparency = Theme.MidgroundTransparency
		self.bar.BorderSizePixel = Theme.BorderSize
		self.bar.BorderColor3 = Theme.BorderColor
		self.bar.Size = UDim2.new(1, 0, 0, Theme.TextSize)

		if Theme.CornerRadius > 0 then
			self.barcorner = Instance.new("UICorner")
			self.barcorner.CornerRadius = UDim.new(0, Theme.CornerRadius)
			self.barcorner.Parent = self.bar
		end

		self.controls = Instance.new("Frame")
		self.controls.AnchorPoint = Vector2.new(.5, 0)
		self.controls.Position = UDim2.fromScale(.5, 0)
		self.controls.Size = UDim2.new(0, Theme.TextSize * 5, 1, 0)

		self.controlslist = Instance.new("UIListLayout")
		self.controlslist.FillDirection = Enum.FillDirection.Horizontal
		self.controlslist.SortOrder = Enum.SortOrder.LayoutOrder
		self.controlslist.Parent = self.controls

		self.buttons = {}
		self.buttons.jumptostart = controlbutton("")
		self.buttons.jumptostart.Parent = self.controls

		self.buttons.lastkeyframe = controlbutton("")
		self.buttons.lastkeyframe.Parent = self.controls

		self.buttons.playback = controlbutton("")
		self.buttons.playback.Parent = self.controls

		self.buttons.nextkeyframe = controlbutton("")
		self.buttons.nextkeyframe.Parent = self.controls

		self.buttons.jumptoend = controlbutton("")
		self.buttons.jumptoend.Parent = self.controls

		self.controls.Parent = self.bar

		self.closebutton = Button("X", nil, function()
			self:Close()
		end)
		self.closebutton.SizeConstraint = Enum.SizeConstraint.RelativeYY
		self.closebutton.Size = UDim2.fromScale(1, 1)
		self.closebutton.Position = UDim2.fromScale(1, 0)
		self.closebutton.AnchorPoint = Vector2.new(1, 0)
		self.closebutton.Parent = self.bar

		self.bar.Parent = self.frame

		---> Board <---
		self.board = Instance.new("Frame")
		self.board.Size = UDim2.new(1, 0, 1, -Theme.TextSize)
		self.board.BackgroundTransparency = 1
		self.board.AnchorPoint = Vector2.new(.5, 1)
		self.board.Position = UDim2.fromScale(.5, 1)

		---> Elements <---
		self.elements = Instance.new("Frame")
		self.elements.Size = UDim2.new(0, 100, 1, 0)
		self.elements.Position = UDim2.fromScale(0, 1)
		self.elements.AnchorPoint = Vector2.new(0, 1)
		self.elements.BackgroundColor3 = Theme.Background
		self.elements.BackgroundTransparency = Theme.BackgroundTransparency
		self.elements.BorderColor3 = Theme.BorderColor
		self.elements.BorderSizePixel = Theme.BorderSize
		Resizable(
			self.elements,
			Vector2.new(100),
			Vector2.new(200),
			{"rig"}
		)

		self.elementscorner = Instance.new("UICorner")
		if Theme.CornerRadius > 0 then
			self.elementscorner.CornerRadius = UDim.new(0, Theme.CornerRadius)
			self.elementscorner.Parent = self.elements
		end

		self.elements.Parent = self.board

		self.board.Parent = self.frame
		self.frame.Parent = screen

		Transparency:cacheall(self.frame)

		self:Update()
	end,

	Update = function(self)
	end,

	Open = function(self)
		self.Active = true
		self.frame.Visible = true
		self.frame.Size = UDim2.fromOffset(400-50, 250-50)
		TweenService:Create(
			self.frame,
			TweenInfo.new(Theme.Transition),
			{Size = UDim2.fromOffset(400, 250)}
		):Play()
		Transparency:fade(self.frame, Theme.Transition, 1, 0)
		Toggled:Fire(self.Active)
	end,

	Close = function(self)
		Transparency:fade(self.frame, Theme.Transition, 0, 1)
		TweenService:Create(
			self.frame,
			TweenInfo.new(Theme.Transition),
			{Size = self.frame.Size - UDim2.fromOffset(50, 50)}
		):Play()
		task.wait(Theme.Transition)
		self.Active = false
		self.frame.Visible = false
		Toggled:Fire(self.Active)
	end,
}