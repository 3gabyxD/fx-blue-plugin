local TweenService = game:GetService("TweenService")

local Toggled = script.Parent.Toggled
local Theme = require(script.Parent.Theme)

local Elements = script.Parent.Elements
local Button = require(Elements.Button)
local Transparency = require(Elements.Transparency)

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