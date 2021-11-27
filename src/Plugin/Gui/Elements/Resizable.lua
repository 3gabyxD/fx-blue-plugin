local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

return function(frame)
	local dragTop = Instance.new("ImageButton")
	dragTop.BackgroundTransparency = 1
	dragTop.ImageTransparency = 1
	dragTop.Size = UDim2.new(1, 0, 0, 10)
	dragTop.AnchorPoint = Vector2.new(.5, 1)
	dragTop.Position = UDim2.fromScale(.5, 0)
	dragTop.Parent = frame

	local startSize, abSize = frame.Size
	local startPos, abPos = frame.Position
	local topStart
	dragTop.MouseButton1Down:Connect(function(x, y)
		topStart = Vector2.new(x, y)
		startSize, abSize = frame.Size
		startPos, abPos = frame.Position
	end)

	UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if topStart then
				topStart = nil
				startSize, abSize = frame.Size
				startPos, abPos = frame.Position
			end
		end
	end)

	RunService.Heartbeat:Connect(function(deltaTime)
		if topStart then
			local pos = UserInputService:GetMouseLocation()
			local dst = topStart.Y - pos.Y
			frame.Size = UDim2.new(
				startSize.X.Scale,
				startSize.X.Offset,
				startSize.Y.Scale,
				startSize.Y.Offset + (dst)
			)

			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset,
				startPos.Y.Scale,
				startPos.Y.Offset - dst
			)

			print(startPos.Y.Offset - (dst/2))
		end
	end)

end