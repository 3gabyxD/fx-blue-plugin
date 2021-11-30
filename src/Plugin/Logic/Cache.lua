return {
	File = {
		packages = {"bezier-path", "random"},
		name = "Cool Effect",
		elements = {workspace.Baseplate, workspace.Part}, --> assets
		frames = {
			["Part"] = {
				{
					time = 0.3,
					easing = {{0, 0}, {1, 1}},
					offset = CFrame.new(),
					Size = Vector3.new()
				},
				{
					time = 0.6,
					easing = {{0, 0}, {1, 1}},
					offset = CFrame.new(),
					Size = Vector3.new(2, 2, 2)
				},
				{
					time = 1.45,
					easing = {{0, 0}, {1, 1}},
					offset = CFrame.new(0, 5, 0),
					Size = Vector3.new(5, 5, 5)
				}
			},
			["Baseplate"] = {
				{
					time = 0,
					easing = {
						{0, 0},
						{1, 1}
					},
					offset = CFrame.new(50, 50, 50),
					Size = Vector3.new(1, 1, 1)
				},
				{
					time = 1,
					easing = {
						{0, 0},
						{1, 1}
					},
					offset = CFrame.new(50, 50, 50)
				},
				{
					time = 2,
					easing = {
						{0, 0},
						{1, 1}
					},
					offset = CFrame.new(50, 50, 50),
					Size = Vector3.new(5, 5, 5)
				},
				{
					time = 2.5,
					easing = {
						{0, 0},
						{1, 1}
					},
					offset = CFrame.new(50, 50, 50)
				},
				{
					time = 3,
					easing = {
						{0, 0},
						{1, 1}
					},
					offset = CFrame.new(50, 50, 50)
				}
			}
		}, --> key (name of element), val (dict of properties)
	}
}