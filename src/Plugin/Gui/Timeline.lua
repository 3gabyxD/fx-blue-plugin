--|| Services ||--
local TweenService = game:GetService("TweenService")

--|| References ||--
local Host = script.Parent.Parent
local Theme = require(Host.Gui.Theme)
local Cache = require(Host.Logic.Cache)

--|| Elements ||--
local Elements = Host.Gui.Elements
local Transparency = require(Elements.Transparency)
local Draggable = require(Elements.Draggable)

--|| Utility ||--
local Util = Host.Util
local Instantiate = require(Util.Instantiate)

--|| Timeline ||--
local FPS = 24

return {
	DefaultSize = UDim2.fromOffset(
		600, Theme.TextSize * 8
	),

	ToolbarSize = UDim2.new(
		1, 0, 0, Theme.TextSize
	),

	BoardPadding = 20,
	SidebarWidth = 120,
	SecondsOffset = 60,
	SequenceHeight = 18,

	RenderTimelineLines = function(self)
		local lastKey = 0
		for _, frameset in pairs(Cache.File.frames) do
			for _, frame in pairs(frameset) do
				if frame.time >= lastKey then
					lastKey = frame.time
				end
			end
		end
		for i = 0, lastKey, 1 do
			local f = Instantiate("Frame", {
				Size = UDim2.fromOffset(Theme.BorderSize, Theme.TextSize*0.75),
				Position = UDim2.new(0, self.BoardPadding + i * self.SecondsOffset, .5, 0),
				AnchorPoint = Vector2.new(.5, .5),
				BackgroundColor3 = Theme.Foreground,
				BorderSizePixel = 0,
				Parent = self.Timeline
			})
		end
	end,

	PopulateElements = function(self)
		local File = Cache.File
		for Name, Frames in pairs(File.frames) do
			local Properties = {}
			for _, Frame in pairs(Frames) do
				for Property, _ in pairs(Frame) do
					if Property ~= "time" and Property ~= "easing" and not table.find(Properties, Property) then
						Properties[#Properties+1] = Property
					end
				end
			end
			local NProperties = #Properties

			self.Elements[Name] = Instantiate("Frame", {
				Size = UDim2.new(1, 0, 0, Theme.TextSize + Theme.TextSize*NProperties),
				BackgroundTransparency = 1,
				Parent = self.Board
			})

			local Title = Instantiate("Frame", {
				Size = UDim2.new(0, self.SidebarWidth, 0, Theme.TextSize),

				BackgroundColor3 = Theme.Background,
				BackgroundTransparency = Theme.BackgroundTransparency,
				BorderSizePixel = Theme.BorderSize,
				BorderColor3 = Theme.BorderColor,

				Parent = self.Elements[Name]
			})

			local TitleText = Instantiate("TextButton", {
				Parent = Title,
				Size = UDim2.new(1, -Theme.TextSize - 10, 0, Theme.TextSize),
				Position = UDim2.fromOffset(Theme.TextSize),

				BackgroundTransparency = 1,
				TextColor3 = Theme.Foreground,
				Font = Enum.Font[Theme.Font],
				TextSize = Theme.TextSize,
				Text = Name,
				TextXAlignment = Enum.TextXAlignment.Right,
			})

			local Keys = Instantiate("Frame", {
				Position = UDim2.fromOffset(self.SidebarWidth, 0),
				Size = UDim2.new(1, -self.SidebarWidth, 0, Theme.TextSize),

				BackgroundColor3 = Theme.Background,
				BackgroundTransparency = Theme.BackgroundTransparency,
				BorderSizePixel = Theme.BorderSize,
				BorderColor3 = Theme.BorderColor,

				Parent = self.Elements[Name]
			})
			for i, Property in pairs(Properties) do
				local PropertyTitle = Instantiate("TextLabel", {
					Parent = self.Elements[Name],

					Name = Property,
					Size = UDim2.new(0, self.SidebarWidth, 0, Theme.TextSize),
					Position = UDim2.fromOffset(0, i * Theme.TextSize),

					BackgroundColor3 = Theme.BackgroundAlt2,
					BackgroundTransparency = Theme.BackgroundTransparency,
					BorderSizePixel = Theme.BorderSize,
					TextColor3 = Theme.Foreground,
					Text = Property == "offset" and "CFrame" or Property,
					Font = Enum.Font[Theme.Font],
					TextSize = Theme.TextSize,
					TextXAlignment = Enum.TextXAlignment.Right,
					BorderColor3 = Theme.BorderColor,
				})

				local PropertyKeys = Instantiate("Frame", {
					Parent = self.Elements[Name],

					Name = Property,
					Size = UDim2.new(1, -self.SidebarWidth, 0, Theme.TextSize),
					Position = UDim2.fromOffset(self.SidebarWidth, i * Theme.TextSize),
					BackgroundColor3 = Theme.BackgroundAlt2,
					BackgroundTransparency = Theme.BackgroundTransparency,
					BorderSizePixel = Theme.BorderSize,
					BorderColor3 = Theme.BorderColor,
				})


			end


			for i, frame in pairs(Frames) do
				Instantiate("Frame", {
					Parent = Keys,
					Position = UDim2.new(0, self.BoardPadding + frame.time*self.SecondsOffset, 0.5, 0),
					Size = UDim2.fromOffset(Theme.TextSize/2, Theme.TextSize/2),
					AnchorPoint = Vector2.new(.5, .5),

					BorderSizePixel = 0,
					BackgroundColor3 = Theme.Foreground,
					BackgroundTransparency = Theme.ForegroundTransparency,
					ZIndex = 2,
					Rotation = 45,
				})
				
				if i > 1 then
					local last = Frames[i - 1]
					if last then
						local this = self.BoardPadding + frame.time*self.SecondsOffset
						local _last = self.BoardPadding + last.time*self.SecondsOffset
						local center = (_last + this) / 2
						Instantiate("Frame", {
							Parent = Keys,
							Position = UDim2.new(0, center, 0.5, 0),
							Size = UDim2.fromOffset(this - _last, self.SequenceHeight),
							AnchorPoint = Vector2.new(.5, .5),
							
							BorderSizePixel = 0,
							BackgroundColor3 = Theme.Midground,
							BackgroundTransparency = Theme.MidgroundTransparency,
							ZIndex = 1,
						})
					end
				end
			end
		end
	end,

	Init = function(self, screen)
		self.Window = Instantiate("Frame", {
			Size = self.DefaultSize,
			BorderSizePixel = Theme.BorderSize,
			BorderColor3 = Theme.BorderColor,
			BackgroundColor3 = Theme.Background,
			BackgroundTransparency = Theme.BackgroundTransparency,
			Visible = false
		})

		self.WindowCorner = Instantiate("UICorner", {
			CornerRadius = UDim.new(0, Theme.CornerRadius),
			Parent = self.Window
		})

		self.Menu = Instantiate("Frame", {
			Size = self.ToolbarSize,
			BorderSizePixel = Theme.BorderSize,
			BorderColor3 = Theme.BorderColor,
			BackgroundColor3 = Theme.Background,
			BackgroundTransparency = Theme.BackgroundTransparency,
			Parent = self.Window
		})

		self.Toolbar = Instantiate("Frame", {
			Position = UDim2.fromOffset(0, Theme.TextSize),
			Size = self.ToolbarSize,
			BorderSizePixel = Theme.BorderSize,
			BackgroundTransparency = 1,
			Parent = self.Window
		})

		self.Tools = Instantiate("Frame", {
			Size = UDim2.fromOffset(self.SidebarWidth, Theme.TextSize),
			BackgroundColor3 = Theme.BackgroundAlt2,
			BackgroundTransparency = Theme.BackgroundTransparency,
			BorderSizePixel = Theme.BorderSize,
			BorderColor3 = Theme.BorderColor,
			Parent = self.Toolbar
		})

		self.Timeline = Instantiate("ScrollingFrame", {
			Size = UDim2.new(1, -self.SidebarWidth, 0, Theme.TextSize),
			Position = UDim2.fromOffset(self.SidebarWidth, 0),
			BackgroundColor3 = Theme.BackgroundAlt,
			BackgroundTransparency = Theme.BackgroundTransparency,
			BorderSizePixel = Theme.BorderSize,
			BorderColor3 = Theme.BorderColor,
			ScrollBarThickness = 0,
			ScrollingEnabled = false,
			CanvasSize = UDim2.fromScale(2, 1),
			AutomaticCanvasSize = Enum.AutomaticSize.X,
			Parent = self.Toolbar
		})

		Instantiate("Frame", {
			AnchorPoint = Vector2.new(.5, .5),
			Position = UDim2.fromScale(.5, .5),
			Size = UDim2.new(1, -20, 0, Theme.BorderSize),
			BackgroundColor3 = Theme.Foreground,
			BorderSizePixel = 0,
			Parent = self.Timeline
		})
		self:RenderTimelineLines()

		self.Board = Instantiate("ScrollingFrame", {
			Position = UDim2.fromOffset(0, Theme.TextSize * 2),
			Size = UDim2.new(1, 0, 1, -Theme.TextSize * 2),
			BackgroundTransparency = 1,
			CanvasSize = UDim2.fromScale(1, 1),
			AutomaticCanvasSize = Enum.AutomaticSize.None,
			ScrollBarThickness = 0,
			ZIndex = -1,
			Parent = self.Window
		})
		Instantiate("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = self.Board
		})

		self.Elements = {}
		self:PopulateElements()


		Transparency:cacheall(self.Window)
		Draggable(self.Window)
		self.Window.Parent = screen
	end,

	Open = function(self)
		self.Window.Visible = true
	end,
	
	Close = function(self)
		self.Window.Visible = false
	end,
}