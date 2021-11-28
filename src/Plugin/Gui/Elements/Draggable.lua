local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")


return function(frame, applyto)
	local detector = Instance.new("ImageButton")
	detector.ImageTransparency = 1
	detector.BackgroundTransparency = 1

	detector.Size = UDim2.fromScale(1, 1)
	detector.Parent = frame

	if applyto == nil then
		applyto = frame
	end

	local start
	local startpos: UDim2
	detector.MouseButton1Down:Connect(function(x, y)
		startpos = applyto.Position
		start = Vector2.new(x, y)
	end)

	UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and start then
			local pos = UserInputService:GetMouseLocation()
			local delta = pos - start
			applyto.Position = UDim2.new(
				startpos.X.Scale,
				startpos.X.Offset + delta.X,
				startpos.Y.Scale,
				startpos.Y.Offset + delta.Y
			)
			start = nil
		end
	end)

	RunService.Heartbeat:Connect(function(deltaTime)
		if start then
			local pos = UserInputService:GetMouseLocation()
			local delta = pos - start
			applyto.Position = UDim2.new(
				startpos.X.Scale,
				startpos.X.Offset + delta.X,
				startpos.Y.Scale,
				startpos.Y.Offset + delta.Y
			)
		end
	end)
end