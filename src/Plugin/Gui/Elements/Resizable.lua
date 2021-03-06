local UserInputService = game:GetService("UserInputService")
local StarterPack = game:GetService("StarterPack")
local RunService = game:GetService("RunService")

local function dragger(size, pos, anc)
	local d = Instance.new("ImageButton")
	d.BackgroundTransparency = 1
	d.ImageTransparency = 1

	d.Position = pos
	d.Size = size
	d.AnchorPoint = anc

	return d
end

return function(frame, minsize, maxsize, flags)
	local startSize = frame.Size
	local startPos = frame.Position

	local holdStart: Vector2
	local direction: string

	local function setstart(x, y, dir)
		holdStart = Vector2.new(x, y)
		direction = dir
		startSize = frame.Size
		startPos = frame.Position
	end

	if flags == nil or table.find(flags, "top") then
		local dragTop = dragger(
			UDim2.new(1, 0, 0, 10),
			UDim2.fromScale(.5, 0),
			Vector2.new(.5, 1)
		)
		dragTop.Parent = frame

		dragTop.MouseButton1Down:Connect(function(x, y)
			setstart(x, y, "top")
		end)
	end

	if flags == nil or table.find(flags, "bot") then
		local dragBot = dragger(
			UDim2.new(1, 0, 0, 10),
			UDim2.fromScale(.5, 1),
			Vector2.new(.5, 0)
		)
		dragBot.Parent = frame

		dragBot.MouseButton1Down:Connect(function(x, y)
			setstart(x, y, "bot")
		end)
	end

	if flags == nil or table.find(flags, "lef") then
		local dragLeft = dragger(
			UDim2.new(0, 10, 1, 0),
			UDim2.fromScale(0, .5),
			Vector2.new(1, .5)
		)
		dragLeft.Parent = frame

		dragLeft.MouseButton1Down:Connect(function(x, y)
			setstart(x, y, "lef")
		end)
	end

	if flags == nil or table.find(flags, "rig") then
		local dragRight = dragger(
			UDim2.new(0, 10, 1, 0),
			UDim2.fromScale(1, .5),
			Vector2.new(0, .5)
		)
		dragRight.Parent = frame

		dragRight.MouseButton1Down:Connect(function(x, y)
			setstart(x, y, "rig")
		end)
	end

	UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if holdStart then
				holdStart = nil
				direction = nil
				startSize = frame.Size
				startPos = frame.Position
			end
		end
	end)

	RunService.Heartbeat:Connect(function(deltaTime)
		if holdStart then
			local pos = UserInputService:GetMouseLocation()
			local dst = holdStart - pos
			if flags == nil or table.find(flags, direction) then
				if direction == "top" then
					local maxed = math.clamp(startSize.Y.Offset + dst.Y, minsize.Y, maxsize.Y)
					frame.Size = UDim2.new(
						startSize.X.Scale,
						startSize.X.Offset,
						startSize.Y.Scale,
						maxed
					)
					frame.Position = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset,
						startPos.Y.Scale,
						startPos.Y.Offset - ((maxed - startSize.Y.Offset) * frame.AnchorPoint.X)
					)
				elseif direction == "bot" then
					local maxed = math.clamp(startSize.Y.Offset - dst.Y, minsize.Y, maxsize.Y)
					frame.Size = UDim2.new(
						startSize.X.Scale,
						startSize.X.Offset,
						startSize.Y.Scale,
						maxed
					)
					frame.Position = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset,
						startPos.Y.Scale,
						startPos.Y.Offset + ((maxed - startSize.Y.Offset) * frame.AnchorPoint.X)
					)
				elseif direction == "lef" then
					local maxed = math.clamp(startSize.X.Offset + dst.X, minsize.X, maxsize.X)
					frame.Size = UDim2.new(
						startSize.X.Scale,
						maxed,
						startSize.Y.Scale,
						startSize.Y.Offset
					)
					frame.Position = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset - ((maxed - startSize.X.Offset) * frame.AnchorPoint.X),
						startPos.Y.Scale,
						startPos.Y.Offset
					)
				elseif direction == "rig" then
					local maxed = math.clamp(startSize.X.Offset - dst.X, minsize.X, maxsize.X)
					frame.Size = UDim2.new(
						startSize.X.Scale,
						maxed,
						startSize.Y.Scale,
						startSize.Y.Offset
					)
					frame.Position = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset + ((maxed - startSize.X.Offset) * frame.AnchorPoint.X),
						startPos.Y.Scale,
						startPos.Y.Offset
					)
				end
			end
		end
	end)

end