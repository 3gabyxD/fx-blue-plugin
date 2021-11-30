local TweenService = game:GetService("TweenService")

local Toggled = script.Parent.Toggled
local Theme = require(script.Parent.Theme)

local Elements = script.Parent.Elements
local Resizable = require(Elements.Resizable)
local Draggable = require(Elements.Draggable)
local Button = require(Elements.Button)
local Transparency = require(Elements.Transparency)

local Cache = require(script.Parent.Parent.Logic.Cache)

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
	renderelement = function(self, element)
		local i = #self.elementframes+1
		self.elementframes[i] = Instance.new("Frame")
		self.elementframes[i].BackgroundTransparency = 1
		self.elementframes[i].Size = UDim2.new(1, 0, 0, Theme.TextSize)

		local text = Instance.new("TextButton")
		text.Text = element.Name
		text.TextSize = Theme.TextSize
		text.Font = Enum.Font[Theme.Font]
		text.TextColor3 = Theme.Foreground
		text.Size = UDim2.new(1, 0, 0, Theme.TextSize)
		text.BackgroundTransparency = 1
		text.TextXAlignment = Enum.TextXAlignment.Left

		text.MouseEnter:Connect(function()
			text.TextColor3 = Theme.ForegroundHover
		end)

		text.MouseLeave:Connect(function()
			text.TextColor3 = Theme.Foreground
		end)

		text.Parent = self.elementframes[i]

		self.elementframes[i].Parent = self.elements


	end,

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
		self.board = Instance.new("ScrollingFrame")
		self.board.Size = UDim2.new(1, 0, 1, -Theme.TextSize)
		self.board.BackgroundTransparency = 1
		self.board.AutomaticCanvasSize = Enum.AutomaticSize.Y
		self.board.CanvasSize = self.board.Size
		self.board.ScrollBarThickness = 0
		self.board.AnchorPoint = Vector2.new(.5, 1)
		self.board.Position = UDim2.fromScale(.5, 1)

		---> Elements <---
		self.elementsframe = Instance.new("Frame")
		self.elementsframe.Size = UDim2.new(0, 100, 1, 0)
		self.elementsframe.Position = UDim2.fromScale(0, 1)
		self.elementsframe.AnchorPoint = Vector2.new(0, 1)
		self.elementsframe.BackgroundColor3 = Theme.Background
		self.elementsframe.BackgroundTransparency = Theme.BackgroundTransparency
		self.elementsframe.BorderColor3 = Theme.BorderColor
		self.elementsframe.BorderSizePixel = Theme.BorderSize
		Resizable(
			self.elementsframe,
			Vector2.new(100),
			Vector2.new(200),
			{"rig"}
		)

		self.elementscorner = Instance.new("UICorner")
		if Theme.CornerRadius > 0 then
			self.elementscorner.CornerRadius = UDim.new(0, Theme.CornerRadius)
			self.elementscorner.Parent = self.elementsframe
		end

		self.elements = Instance.new("Frame")
		self.elements.Size = UDim2.fromScale(1, 1)
		self.elements.BackgroundTransparency = 1
		self.elements.BorderSizePixel = 1
		self.elements.Parent = self.elementsframe

		self.elementslist = Instance.new("UIListLayout")
		self.elementslist.SortOrder = Enum.SortOrder.LayoutOrder
		self.elementslist.Parent = self.elements

		self.elementframes = {}
		for i, v in pairs(Cache.File.elements) do
			self:renderelement(v)
		end

		self.elementsframe.Parent = self.board

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
		self.frame.Size = self.frame.Size - UDim2.fromOffset(50, 50)
		TweenService:Create(
			self.frame,
			TweenInfo.new(Theme.Transition),
			{Size = self.frame.Size + UDim2.fromOffset(50, 50)}
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