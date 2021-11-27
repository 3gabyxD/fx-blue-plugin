return function(theme, title, icon, callback)
	local f = Instance.new("Frame")
	f.BackgroundTransparency = 1
	f.Size = UDim2.new(.8, 0, 0, theme.TextSize)

	local i = Instance.new("ImageLabel")
	i.BackgroundTransparency = 1
	i.Image = "rbxassetid://" .. icon
	i.ImageColor3 = theme.Foreground
	i.ImageTransparency = theme.ForegroundTransparency
	i.Size = UDim2.fromOffset(theme.TextSize, theme.TextSize)
	i.Parent = f

	local b = Instance.new("TextButton")
	b.Position = UDim2.fromOffset(theme.TextSize+5, 0)
	b.Size = UDim2.new(1, -theme.TextSize-5, 0, theme.TextSize)
	b.Font = Enum.Font[theme.Font]
	b.BackgroundTransparency = 1
	b.Text = title
	b.TextSize = theme.TextSize
	b.TextColor3 = theme.Foreground
	b.TextTransparency = theme.ForegroundTransparency
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.Parent = f

	b.MouseButton1Click:Connect(callback)

	return f
end