local TweenService = game:GetService("TweenService")

local Toggled = script.Parent.Toggled
local TimelineUI = require(script.Parent.Timeline)
local Theme = require(script.Parent.Theme)

local Elements = script.Parent.Elements
local Button = require(Elements.Button)
local Transparency = require(Elements.Transparency)

return {
	Active = false,

	Init = function(self, screen)
		self.frame = Instance.new("Frame")
		self.frame.Size = UDim2.fromOffset(400, 350)
		self.frame.Visible = false
		self.frame.ZIndex = 50
		self.frame.AnchorPoint = Vector2.new(.5, .5)
		self.frame.Position = UDim2.fromScale(.5, .5)

		self.frame.BackgroundTransparency = Theme.BackgroundTransparency
		self.frame.BackgroundColor3 = Theme.Background
		self.frame.BorderSizePixel = Theme.BorderSize
		self.frame.BorderColor3 = Theme.BorderColor

		if Theme.CornerRadius > 0 then
			self.uicorner = Instance.new("UICorner")
			self.uicorner.CornerRadius = UDim.new(0, Theme.CornerRadius)
			self.uicorner.Parent = self.frame
		end

		self.thumbnail = Instance.new("ImageLabel")
		self.thumbnail.Size = UDim2.fromScale(1, .4)

		self.thumbnail.Image = "rbxassetid://" .. Theme.OverlayThumbnail
		self.thumbnail.ImageTransparency = Theme.OverlayThumbnailTransparency
		self.thumbnail.ScaleType = Enum.ScaleType[Theme.OverlayThumbnailScale]
		self.thumbnail.BackgroundTransparency = 1
		self.thumbnail.BorderSizePixel = 0

		self.tuicorner = Instance.new("UICorner")
		self.tuicorner.CornerRadius = UDim.new(0, Theme.CornerRadius)
		self.tuicorner.Parent = self.thumbnail

		self.thumbnail.Parent = self.frame

		self.files = Instance.new("Frame")
		self.files.AnchorPoint = Vector2.new(0, 1)
		self.files.Size = UDim2.new(.5, -Theme.OverlayPaddingSize, .6, -Theme.OverlayPaddingSize)
		self.files.Position = UDim2.new(0, Theme.OverlayPaddingSize, 1, 0)
		self.files.BackgroundTransparency = 1

		self.fileslist = Instance.new("UIListLayout")
		self.fileslist.SortOrder = Enum.SortOrder.LayoutOrder
		self.fileslist.Padding = UDim.new(0, 5)
		self.fileslist.Parent = self.files

		self.filestitle = Instance.new("TextLabel")
		self.filestitle.Size = UDim2.new(.8, 0, 0, Theme.TextSize)
		self.filestitle.Font = Enum.Font[Theme.Font]
		self.filestitle.BackgroundTransparency = 1
		self.filestitle.Text = "File"
		self.filestitle.TextSize = Theme.TextSize
		self.filestitle.TextColor3 = Theme.Foreground
		self.filestitle.TextTransparency = Theme.ForegroundTransparency
		self.filestitle.TextXAlignment = Enum.TextXAlignment.Left
		self.filestitle.Parent = self.files

		self.newbutton = Button(Theme, "New", "8111953872", function()
			TimelineUI:Open()
			self:Close()
		end)
		self.openbutton = Button(Theme, "Open", "8111953872", function()

		end)

		self.newbutton.Parent = self.files
		self.openbutton.Parent = self.files

		self.files.Parent = self.frame
		self.frame.Parent = screen

		self:Update()
		Transparency:cacheall(self.frame)
	end,

	Open = function(self)
		self.frame.Size = UDim2.fromOffset(400-50, 350-50)
		self.frame.Visible = true
		TweenService:Create(
			self.frame,
			TweenInfo.new(Theme.Transition),
			{Size = UDim2.fromOffset(400, 350)}
		):Play()
		Transparency:fade(self.frame, Theme.Transition, 1, 0)
	end,

	Close = function(self)
		Transparency:fade(self.frame, Theme.Transition, 0, 1)
		TweenService:Create(
			self.frame,
			TweenInfo.new(Theme.Transition),
			{Size = UDim2.fromOffset(400-50, 350-50)}
		):Play()
		task.wait(Theme.Transition)
		self.frame.Visible = false
	end,

	Update = function(self)
	end,

	Toggle = function(self)
		self.Active = not self.Active
		if self.Active then
			self:Open()
		else
			self:Close()
		end
		Toggled:Fire(self.Active)
	end
}