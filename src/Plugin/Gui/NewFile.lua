local TweenService = game:GetService("TweenService")

local Toggled = require(script.Parent.Toggled)
local Transparency = require(script.Parent.Transparency)

return {
	Active = false,
	Init = function(self, screen)
		
	end,
	Update = function(self)
	end,
	Open = function(self)
		Toggled:Fire(self.Active)
	end,
	Close = function(self)
		Toggled:Fire(self.Active)
	end,
}