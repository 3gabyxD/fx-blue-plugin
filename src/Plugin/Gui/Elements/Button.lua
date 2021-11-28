local gui = script.Parent.Parent
local Theme = require(gui.Theme)

return function(title, icon, callback)
	local f = Instance.new("Frame")
	f.BackgroundTransparency = 1
	f.Size = UDim2.new(.8, 0, 0, Theme.TextSize)

	local b = Instance.new("TextButton")
	b.Position = UDim2.fromOffset(0, 0)
	b.Size = UDim2.new(1, 0, 1, 0)
	b.Font = Enum.Font[Theme.Font]
	b.BackgroundTransparency = 1
	b.Text = title
	b.TextSize = Theme.TextSize
	b.TextColor3 = Theme.Foreground
	b.TextTransparency = Theme.ForegroundTransparency
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.Parent = f

	if icon then
		local i = Instance.new("ImageLabel")
		i.BackgroundTransparency = 1
		i.Image = "rbxassetid://" .. icon
		i.ImageColor3 = Theme.Foreground
		i.ImageTransparency = Theme.ForegroundTransparency
		i.Size = UDim2.fromOffset(Theme.TextSize, Theme.TextSize)
		i.Parent = f
		b.Position = UDim2.fromOffset(Theme.TextSize+5, 0)
		b.Size = UDim2.new(1, -Theme.TextSize-5, 1, 0)
	end

	b.MouseEnter:Connect(function()
		b.TextColor3 = Theme.ForegroundHover
	end)
	b.MouseLeave:Connect(function()
		b.TextColor3 = Theme.Foreground
	end)

	b.MouseButton1Click:Connect(callback)

	return f
end