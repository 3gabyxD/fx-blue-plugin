return {
	File = {
		packages = {"bezier-path", "random"},
		name = "Cool Effect",
		elements = {workspace.Baseplate}, --> assets
		frames = {
			["Baseplate"] = {
				{
					time = 0,
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